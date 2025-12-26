function PaGlobalFunc_SailorPresetManager_All_Open(isOnShip)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if Panel_Window_SailorPresetManager_All:GetShow() == true then
    return
  end
  if isOnShip == true then
    if true == _ContentsGroup_NewUI_Tooltip_All then
      if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
        PaGlobal_Tooltip_Skill_Servant_All_Close()
      end
    elseif nil ~= PaGlobal_Tooltip_Servant_Close then
      PaGlobal_Tooltip_Servant_Close()
    end
  end
  self:prepareOpen(isOnShip)
end
function PaGlobalFunc_SailorPresetManager_All_Close()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true then
    if self._ui._stc_restoreItemBG:GetShow() == true then
      HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()
      return
    end
    if self._ui._combo_stat:isClicked() == true then
      self._ui._combo_stat:ToggleListbox()
      return
    end
    if self._ui._combo_type:isClicked() == true then
      self._ui._combo_type:ToggleListbox()
      return
    end
  end
  if self._isPadSnapping == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  TooltipSimple_Hide()
  if PaGlobalFunc_SailorPreset_NameEdit_All_IsOpen ~= nil and PaGlobalFunc_SailorPreset_NameEdit_All_IsOpen() == true and PaGlobalFunc_SailorPreset_NameEdit_All_Close ~= nil then
    PaGlobalFunc_SailorPreset_NameEdit_All_Close()
  end
  if Panel_Window_SailorPresetManager_All:GetShow() == false then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_SailorPresetManager_All_UpdateEmployeeList(contents, key)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local filterEmployeeCount = ToClient_getPossibleEmployeeNoListSize()
  local idx = Int64toInt32(key)
  local startIndex = idx * self._eMaxEmployeeRowSlotCount
  local endIndex = startIndex + (self._eMaxEmployeeRowSlotCount - 1)
  for i = startIndex, endIndex do
    local contorlIndex = 0
    if startIndex < self._eMaxEmployeeRowSlotCount then
      controlIndex = i + 1
    else
      controlIndex = i % self._eMaxEmployeeRowSlotCount + 1
    end
    local employeeSlot = UI.getChildControl(contents, "Static_SailorSlotBg_" .. controlIndex)
    if i >= filterEmployeeCount then
      employeeSlot:SetShow(false)
    else
      employeeSlot:SetShow(true)
      employeeSlot:SetIgnore(false)
      local stc_image = UI.getChildControl(employeeSlot, "Static_Image")
      local stc_preset = UI.getChildControl(employeeSlot, "Static_Preset")
      local stc_state = UI.getChildControl(employeeSlot, "Static_State")
      local stc_ride = UI.getChildControl(employeeSlot, "StaticText_Ride")
      local txt_tevel = UI.getChildControl(employeeSlot, "StaticText_Level")
      local loyaltyProgressBG = UI.getChildControl(employeeSlot, "Static_LoyaltyProgressBg")
      local progressLoyalty = UI.getChildControl(employeeSlot, "Progress2_RoyaltyProgress")
      local employeeNo = ToClient_getPossibleEmployeeNoByIndex(i)
      local sailorInfo = PaGlobalFunc_SailorPresetManager_All_GetEmployeeInfo(employeeNo)
      if sailorInfo == nil then
        return
      end
      employeeSlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_SelectEmployeeBottomArea(" .. i .. ")")
      stc_image:ChangeTextureInfoNameAsync(sailorInfo._iconPath)
      local isViceCaptain = sailorInfo._isViceCaptain
      if isViceCaptain == true then
        stc_preset:SetShow(true)
        txt_tevel:SetShow(false)
      else
        stc_preset:SetShow(false)
        txt_tevel:SetText("Lv." .. sailorInfo._level)
        txt_tevel:SetShow(true)
      end
      loyaltyProgressBG:SetShow(true)
      progressLoyalty:SetShow(true)
      progressLoyalty:SetProgressRate(sailorInfo._royalRate)
      stc_ride:SetShow(false)
      if __eEmployeeState_Escape == sailorInfo._state then
        stc_state:ChangeTextureInfoTextureIDAsync("Combine_Etc_CrewManagement_Condition_Situation_Disease")
        stc_state:setRenderTexture(stc_state:getBaseTexture())
        stc_state:SetShow(true)
        stc_state:SetIgnore(true)
        isEscape = true
      else
        stc_state:SetShow(false)
        stc_state:SetIgnore(true)
        isEscape = false
        if Defines.s64_const.s64_0 ~= sailorInfo._onServantNo then
          local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
          if nil ~= servantInfo then
            local temporaryWrapper = getTemporaryInformationWrapper()
            local _currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
            if _currentServantWrapper ~= nil then
              if _currentServantWrapper:getServantNo() ~= servantInfo:getServantNo() then
                stc_image:SetMonoTone(true)
                stc_image:SetIgnore(true)
              else
                stc_image:SetMonoTone(false)
                stc_image:SetIgnore(false)
              end
            end
            stc_ride:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_STATE_RIDE"))
            stc_ride:SetShow(true)
            stc_ride:SetMonoTone(true)
            if self._isPadSnapping == false then
              if _currentServantWrapper ~= nil and _currentServantWrapper:getServantNo() ~= servantInfo:getServantNo() then
                employeeSlot:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_ShowOtherShipEmployeeTooltip( true, " .. idx .. ", " .. controlIndex .. ", " .. i .. ")")
                employeeSlot:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_ShowOtherShipEmployeeTooltip(false)")
              else
                employeeSlot:addInputEvent("Mouse_On", "")
                employeeSlot:addInputEvent("Mouse_Out", "")
              end
              UI.setLimitTextToReferenceAndAddTooltip(stc_ride, "", stc_ride:GetText(), stc_ride)
            else
              stc_ride:SetTextMode(__eTextMode_LimitText)
              stc_ride:SetText(stc_ride:GetText())
            end
          else
            stc_ride:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_BOARDING_ANOTHER_SHIP"))
            if self._isPadSnapping == false then
              UI.setLimitTextToReferenceAndAddTooltip(employeeSlot, "", stc_ride:GetText(), stc_ride)
            else
              stc_ride:SetTextMode(__eTextMode_LimitText)
              stc_ride:SetText(stc_ride:GetText())
            end
            stc_ride:SetShow(true)
          end
        else
          stc_ride:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERTRADEMAIN_WAIT"))
          if self._isPadSnapping == false then
            UI.setLimitTextToReferenceAndAddTooltip(employeeSlot, "", stc_ride:GetText(), stc_ride)
          else
            stc_ride:SetTextMode(__eTextMode_LimitText)
            stc_ride:SetText(stc_ride:GetText())
          end
          stc_ride:SetShow(true)
          stc_ride:SetMonoTone(false)
          stc_image:SetMonoTone(false)
        end
      end
      stc_ride:SetIgnore(true)
      stc_image:SetIgnore(true)
      if self._isPadSnapping == true then
        employeeSlot:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_CheckConsoleKeyguideEmployeeList(" .. i .. ")")
      end
    end
  end
  local stc_select = UI.getChildControl(contents, "Static_Select")
  stc_select:SetShow(false)
  stc_select:SetIgnore(true)
  return
end
function PaGlobalFunc_SailorPresetManager_All_SelectEmployeeBottomArea(selectedEmployeeIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  self._selectBottomArea = true
  local employeeNo = ToClient_getPossibleEmployeeNoByIndex(selectedEmployeeIndex)
  self:selectEmployeeBottomArea(selectedEmployeeIndex)
  self:updateSelectEmployee(employeeNo)
  self._ui._stc_selectSlot:SetShow(false)
end
function PaGlobalFunc_SailorPresetManager_All_ConsoleMoveEmployeePresetSlot(employeePresetSlotIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  local presetSlot = self._presetSlotList[employeePresetSlotIndex + 1]
  if presetSlot == nil or presetSlot._slotIndex ~= employeePresetSlotIndex then
    return
  end
  if presetSlot._isApply == true then
    self:clearSelectControl()
    self:updateSelectEmployee(presetSlot._employeeNo)
    self:selectEmployeeBottomArea(nil)
  end
end
function PaGlobalFunc_SailorPresetManager_All_SelectEmployeePresetSlot(employeePresetSlotIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  self._selectBottomArea = false
  local presetSlot = self._presetSlotList[employeePresetSlotIndex + 1]
  if presetSlot == nil or presetSlot._slotIndex ~= employeePresetSlotIndex then
    return
  end
  if presetSlot._isApply == true then
    self:clearSelectControl()
    self:updateSelectEmployee(presetSlot._employeeNo)
    self:selectEmployeeBottomArea(nil)
  else
    if self._selectedEmployeeNo == 0 then
      return
    end
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper == nil then
      return
    end
    self._currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
    if self._currentServantWrapper == nil then
      return
    end
    local presetSlot = self._presetSlotList[employeePresetSlotIndex + 1]
    if presetSlot == nil or presetSlot._slotIndex ~= employeePresetSlotIndex then
      return
    end
    self._selectedPresetSlot = presetSlot
    local currentServantNo = self._currentServantWrapper:getServantNo()
    if presetSlot._slotPresetJob == __eEmployeePresetJob_Cabin then
      employeePresetSlotIndex = employeePresetSlotIndex + (self._currentCabinPageCount - 1) * self._cabinSlotMaxCount
    end
    ToClient_requestApplyEmployeePresetJob(self._selectedEmployeeNo, currentServantNo, employeePresetSlotIndex)
  end
end
function PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeePresetSlot(employeePresetSlotIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local presetSlot = self._presetSlotList[employeePresetSlotIndex + 1]
  if presetSlot == nil or presetSlot._slotIndex ~= employeePresetSlotIndex or presetSlot._isApply == false then
    return
  end
  self._selectedPresetSlot = presetSlot
  if presetSlot._slotPresetJob == __eEmployeePresetJob_Cabin then
    employeePresetSlotIndex = employeePresetSlotIndex + (self._currentCabinPageCount - 1) * self._cabinSlotMaxCount
  end
  ToClient_requestUnApplyEmployee(presetSlot._employeeNo, employeePresetSlotIndex)
end
function FromClient_SailorPresetManager_ResponseApplyEmployee(employeeNo)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._selectedPresetSlot == nil then
    return
  end
  local presetSlot = self._selectedPresetSlot
  if presetSlot ~= nil and presetSlot._employeeNo == 0 then
    presetSlot._stc_image:ChangeTextureInfoNameAsync(self:getEmployeeIconPath(employeeNo))
    presetSlot._stc_plus:SetShow(false)
    presetSlot._isApply = true
    presetSlot._employeeNo = employeeNo
    local sailorInfo = PaGlobalFunc_SailorPresetManager_All_GetEmployeeInfo(employeeNo)
    if sailorInfo ~= nil then
      presetSlot._stc_progress:SetShow(true)
      presetSlot._progressLoyalty:SetShow(true)
      presetSlot._progressLoyalty:SetProgressRate(sailorInfo._royalRate)
    end
    local slotIndex = presetSlot._slotIndex
    if presetSlot._slotPresetJob == __eEmployeePresetJob_Cabin then
      slotIndex = slotIndex + (self._currentCabinPageCount - 1) * self._cabinSlotMaxCount
    end
    self._selectedPresetSlot = nil
    PaGlobalFunc_SailorPresetGroup_All_Update()
    FromClient_ServantList_All_UpdateVehicleList()
    self._selectedEmployeeNo = 0
    self:updateSelectEmployee(employeeNo)
  end
end
function FromClient_SailorPresetManager_ResponseUnapplyEmployee(employeeNo)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local presetSlot = self._selectedPresetSlot
  if presetSlot ~= nil and presetSlot._employeeNo == employeeNo then
    presetSlot._stc_image:ChangeTextureInfoNameAsync("")
    presetSlot._stc_plus:SetShow(true)
    presetSlot._isApply = false
    presetSlot._employeeNo = 0
    presetSlot._stc_progress:SetShow(false)
    presetSlot._progressLoyalty:SetShow(false)
    local slotIndex = presetSlot._slotIndex
    if presetSlot._slotPresetJob == __eEmployeePresetJob_Cabin then
      slotIndex = slotIndex + (self._currentCabinPageCount - 1) * self._cabinSlotMaxCount
    end
    self._selectedPresetSlot = nil
    PaGlobalFunc_SailorPresetGroup_All_Update()
    FromClient_ServantList_All_UpdateVehicleList()
    self._selectedEmployeeNo = 0
    self._selectedEmployeeIndex = 0
    self:selectEmployeeBottomArea(self._selectedEmployeeIndex)
    self:updateSelectEmployee(self._selectedEmployeeNo)
  end
end
function PaGlobalFunc_SailorPresetManager_All_ClickSavePreset()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobalFunc_SailorPresetGroup_All_Open()
end
function PaGlobalFunc_SailorPresetManager_All_ApplyEmployeePreset(presetNo)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  self._selectedPresetNo = presetNo
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_APPLY", "number", presetNo),
    functionYes = PaGlobalFunc_SailorPresetManager_All_ApplyEmployeePresetConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobalFunc_SailorPresetManager_All_ApplyEmployeePresetConfirm()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  self._currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if self._currentServantWrapper == nil then
    return
  end
  local currentServantNo = self._currentServantWrapper:getServantNo()
  local presetIndex = self._selectedPresetNo - 1
  ToClient_requestApplyEmployeePresetAll(currentServantNo, presetIndex)
end
function PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeeAll()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  self._currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if self._currentServantWrapper == nil then
    return
  end
  ToClient_requestUnapplyEmployeeAll(self._currentServantWrapper:getServantNo())
end
function FromClient_SailorPresetManager_ApplyEmployeePresetAll()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_SailorPresetGroup_All_Update()
  FromClient_ServantList_All_UpdateVehicleList()
  self._selectedEmployeeNo = 0
  self._selectedEmployeeIndex = 0
  self:selectEmployeeBottomArea(self._selectedEmployeeIndex)
  self:updateSelectEmployee(self._selectedEmployeeNo)
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_APPLY_COMPLETE"))
  local deseaseEmployeeCount = ToClient_getPresetDiseaseEmployeeNoCount()
  local alreadyAppliedEmployeeCount = ToClient_getPresetAlreadyApplyEmployeeNoCount()
  if deseaseEmployeeCount ~= 0 or alreadyAppliedEmployeeCount ~= 0 then
    local contentString = ""
    for i = 0, alreadyAppliedEmployeeCount do
      local employeeNo = ToClient_getPresetAlreadyApplyEmployeeNoByIndex(i)
      local emploeeWrapper = ToClient_getEmployeeWrapperByEmployeeNo(employeeNo)
      if emploeeWrapper ~= nil then
        contentString = contentString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_APPLY_FAIL_DESC_01", "name", emploeeWrapper:getEmployeeName())
        contentString = contentString .. "\n"
      end
    end
    for ii = 0, deseaseEmployeeCount do
      local employeeNo = ToClient_getPresetDiseaseEmployeeNoByIndex(ii)
      local emploeeWrapper = ToClient_getEmployeeWrapperByEmployeeNo(employeeNo)
      if emploeeWrapper ~= nil then
        if alreadyAppliedEmployeeCount ~= 0 then
          contentString = contentString .. "\n"
        end
        if ii > 0 then
          contentString = contentString .. "\n"
        end
        contentString = contentString .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_APPLY_FAIL_DESC_02", "name", emploeeWrapper:getEmployeeName())
      end
    end
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_APPLY_FAIL"),
      content = contentString,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  end
end
function FromClient_SailorPresetManager_UnapplyEmployeeAll()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_SailorPresetGroup_All_Update()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ALL_DISEMBARK"))
  FromClient_ServantList_All_UpdateVehicleList()
end
function PaGlobalFunc_SailorPresetManager_All_DoSailorFire()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local function doSailorFireReq()
    if self._selectedEmployeeNo == 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NOSELECT_EMPLOYEE_FOR_DISMISSAL"))
    else
      ToClient_requestDeleteEmployee(self._selectedEmployeeNo)
    end
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FIRE_ALTER_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FIRE_ALTER_CONTENT"),
    functionYes = doSailorFireReq,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_SailorPresetGroup_All_Update()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  self:clearEmployeeInfoList()
  self:makeEmployeeInfoList()
  self:clearPresetSlotData(false)
  self:setCurrentEmployeePreset()
  self:filterAndSortPossibleEmployeeList()
end
function PaGlobalFunc_SailorPresetManager_All_MakeRecommandEmployeePreset()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_AUTO_APPLY_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_AUTO_APPLY"),
    functionYes = PaGlobalFunc_SailorPresetManager_All_MakeRecommandEmployeePresetConfirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobalFunc_SailorPresetManager_All_MakeRecommandEmployeePresetConfirm()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  ToClient_requestMakeRecommandEmployeePreset()
end
function FromClient_SailorPresetManager_MakeRecommandEmployeePreset()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_SailorPresetGroup_All_Update()
  FromClient_ServantList_All_UpdateVehicleList()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_AUTO_ARRANGE"))
end
function PaGlobalFunc_SailorPresetManager_All_ComboStat()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  self._ui._combo_stat:ToggleListbox()
end
function PaGlobalFunc_SailorPresetManager_All_MoveToComboStat()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if self._ui._combo_stat:isClicked() == true then
    self._ui._combo_stat:ToggleListbox()
  else
    ToClient_padSnapChangeToTarget(self._ui._combo_stat)
  end
end
function PaGlobalFunc_SailorPresetManager_All_SetComboStat()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._selectedEmployeeAbility == self._ui._combo_stat:GetSelectIndex() then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  self._selectedEmployeeAbility = self:getEmployeeAbility(self._ui._combo_stat:GetSelectIndex())
  local employeeType = self._selectedEmployeeType
  if employeeType == nil then
    employeeType = 0
  end
  ToClient_filterAndSortPossibleEmployeeNoList(employeeType, self._selectedEmployeeAbility)
  self:clearSelectControl()
  PaGlobalFunc_SailorPresetGroup_All_Update()
end
function PaGlobalFunc_SailorPresetManager_All_ComboType()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  self._ui._combo_type:ToggleListbox()
end
function PaGlobalFunc_SailorPresetManager_All_MoveToComboType()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if self._ui._combo_type:isClicked() == true then
    self._ui._combo_type:ToggleListbox()
  else
    ToClient_padSnapChangeToTarget(self._ui._combo_type)
  end
end
function PaGlobalFunc_SailorPresetManager_All_SetComboType()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._selectedEmployeeType == self._ui._combo_type:GetSelectIndex() then
    return
  end
  PaGlobalFunc_WorkerManager_All_Audio(0, 0)
  self._selectedEmployeeType = self._ui._combo_type:GetSelectIndex()
  local employeeAbility = self._selectedEmployeeAbility
  if employeeAbility == nil then
    employeeAbility = __eEmployeeAbility_Count
  end
  ToClient_filterAndSortPossibleEmployeeNoList(self._selectedEmployeeType, employeeAbility)
  self:clearSelectControl()
  PaGlobalFunc_SailorPresetGroup_All_Update()
end
function PaGlobalFunc_SailorPresetManager_All_GetEmployeeInfo(employeeNo)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if #self._employeeInfoList == 0 and self._employeeInfoList[0] == nil then
    return
  end
  for i = 0, #self._employeeInfoList do
    local employeeInfo = self._employeeInfoList[i]
    if employeeInfo._employeeNo == employeeNo then
      return employeeInfo
    end
  end
end
function PaGlobalFunc_SailorPresetManager_All_GetEmployeePresetInfo(employeeNo)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if #self._presetSlotList == 0 then
    return
  end
  for i = 1, #self._presetSlotList do
    local presetSlot = self._presetSlotList[i]
    if presetSlot._employeeNo ~= nil and presetSlot._employeeNo == employeeNo then
      return presetSlot
    end
  end
end
function PaGlobalFunc_SailorPresetManager_All_ClickCabinUpButton()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._currentCabinPageCount == 1 then
    return
  end
  self._currentCabinPageCount = self._currentCabinPageCount - 1
  self._ui._txt_cabinPage:SetText(self._currentCabinPageCount)
  self:setCurrentServantSlot()
  self:clearPresetSlotData()
  self:setCurrentEmployeePreset()
end
function PaGlobalFunc_SailorPresetManager_All_ClickCabinDownButton()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if currentServantWrapper == nil then
    return
  end
  local currentServantcharacterKeyRaw = currentServantWrapper:getCharacterKeyRaw()
  local cabinMaxCount = ToClient_getEmployeePresetJobCount(currentServantcharacterKeyRaw, __eEmployeePresetJob_Cabin)
  if cabinMaxCount <= self._cabinSlotMaxCount * self._currentCabinPageCount then
    return
  end
  self._currentCabinPageCount = self._currentCabinPageCount + 1
  self._ui._txt_cabinPage:SetText(self._currentCabinPageCount)
  self:setCurrentServantSlot()
  self:clearPresetSlotData()
  self:setCurrentEmployeePreset()
end
function PaGlobalFunc_SailorPresetManager_All_InfoTitleTooltip(isShow, infoType)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  if self._infoType.SPEED == infoType then
    control = self._ui._txt_speedTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_SPEED_DESC")
  elseif self._infoType.EXCEL == infoType then
    control = self._ui._txt_accelTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_ACCELATION_DESC")
  elseif self._infoType.TURNING == infoType then
    control = self._ui._txt_corneringTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_CORNERING_DESC")
  elseif self._infoType.BRAKE == infoType then
    control = self._ui._txt_brakeTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_BRAKING_DESC")
  elseif self._infoType.PATIENCE == infoType then
    control = self._ui._txt_patienceTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_PATIENCE_DESC")
  elseif self._infoType.POWER == infoType then
    control = self._ui._txt_powerTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_POWER_DESC")
  elseif self._infoType.FOCUS == infoType then
    control = self._ui._txt_focusTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_FOCUS_DESC")
  elseif self._infoType.SIGHT == infoType then
    control = self._ui._txt_sightTitle
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILORMANAGER_SIGHT_DESC")
  end
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_SailorPresetManager_All_SailorRestore(sailorIndex, loyalismType)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if loyalismType == __eEmployeeLoyalismType_Loyalty then
    self._ui._stc_recoveryBg:SetShow(true)
    self._ui._stc_treatementBg:SetShow(false)
    local itemCount = ToClient_getRecoveryItemCount()
    for index = 1, itemCount do
      local itemSlot = UI.getChildControl(self._ui._stc_recoveryBg, "Static_RecoverySlotBg" .. index)
      local stc_itemIcon = UI.getChildControl(itemSlot, "Static_Slot")
      local txt_itemCount = UI.getChildControl(itemSlot, "StaticText_Count")
      local stc_cashIcon = UI.getChildControl(itemSlot, "Static_CashIcon")
      local itemKey = ToClient_getRecoveryItemkeyByIndex(index - 1, loyalismType)
      local itemEnchantKey = ItemEnchantKey(itemKey, 0)
      local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
      local recoveryItemCount = ToClient_InventoryGetItemCount(itemEnchantKey)
      if itemWrapper == nil then
        return
      end
      if itemWrapper:isCash() == true then
        stc_cashIcon:SetShow(true)
      else
        stc_cashIcon:SetShow(false)
      end
      txt_itemCount:SetText(tostring(recoveryItemCount))
      stc_itemIcon:ChangeTextureInfoNameAsync("icon/" .. itemWrapper:getIconPath())
      stc_itemIcon:SetShow(true)
      stc_itemIcon:addInputEvent("Mouse_RUp", "HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployee(" .. sailorIndex .. "," .. itemKey .. ", " .. loyalismType .. ")")
      stc_itemIcon:addInputEvent("Mouse_On", "HandleEventLUp_SailorPresetManager_ShowRestoreItemTooltip(true," .. index .. "," .. loyalismType .. ")")
      stc_itemIcon:addInputEvent("Mouse_Out", "HandleEventLUp_SailorPresetManager_ShowRestoreItemTooltip(false)")
      if self._isPadSnapping == true then
        itemSlot:registerPadEvent(__eConsoleUIPadEvent_RT, "HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployee(" .. sailorIndex .. "," .. itemKey .. ", " .. loyalismType .. ")")
        itemSlot:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployeeAll_Console(" .. sailorIndex .. "," .. itemKey .. ", " .. loyalismType .. ")")
        itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()")
      end
    end
  elseif loyalismType == __eEmployeeLoyalismType_resurrection then
    self._ui._stc_treatementBg:SetShow(true)
    self._ui._stc_recoveryBg:SetShow(false)
    local itemCount = ToClient_getResurrectionItemCount()
    for index = 1, itemCount do
      local itemSlot = UI.getChildControl(self._ui._stc_treatementBg, "Static_TreatmentSlotBg" .. index)
      local stc_itemIcon = UI.getChildControl(itemSlot, "Static_Slot")
      local txt_itemCount = UI.getChildControl(itemSlot, "StaticText_Count")
      local stc_cashIcon = UI.getChildControl(itemSlot, "Static_CashIcon")
      local itemKey = ToClient_getRecoveryItemkeyByIndex(index - 1, loyalismType)
      local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
      local recoveryItemCount = ToClient_InventoryGetItemCount(ItemEnchantKey(itemKey))
      if itemWrapper == nil then
        return
      end
      if itemWrapper:isCash() == true then
        stc_cashIcon:SetShow(true)
      else
        stc_cashIcon:SetShow(false)
      end
      txt_itemCount:SetText(tostring(recoveryItemCount))
      stc_itemIcon:ChangeTextureInfoNameAsync("icon/" .. itemWrapper:getIconPath())
      stc_itemIcon:SetShow(true)
      stc_itemIcon:addInputEvent("Mouse_RUp", "HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployee(" .. sailorIndex .. "," .. itemKey .. ", " .. loyalismType .. ")")
      stc_itemIcon:addInputEvent("Mouse_On", "HandleEventLUp_SailorPresetManager_ShowRestoreItemTooltip(true," .. index .. "," .. loyalismType .. ")")
      stc_itemIcon:addInputEvent("Mouse_Out", "HandleEventLUp_SailorPresetManager_ShowRestoreItemTooltip(false)")
      if self._isPadSnapping == true then
        itemSlot:registerPadEvent(__eConsoleUIPadEvent_RT, "HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployee(" .. sailorIndex .. "," .. itemKey .. ", " .. loyalismType .. ")")
        itemSlot:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployeeAll_Console(" .. sailorIndex .. "," .. itemKey .. ", " .. loyalismType .. ")")
        itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()")
      end
    end
  end
  self._ui._stc_restoreItemBG:SetShow(true)
  local windowPosX = self._ui._btn_restore:GetParentPosX() + self._ui._btn_restore:GetSizeX() - Panel_Window_SailorPresetManager_All:GetPosX()
  local windowPosY = self._ui._btn_restore:GetParentPosY() - Panel_Window_SailorPresetManager_All:GetPosY()
  self._ui._stc_restoreItemBG:SetPosXY(windowPosX, windowPosY)
  if self._isPadSnapping == true then
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "")
  end
end
function HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if nil == Panel_Window_SailorPresetManager_All then
    return
  end
  self._ui._stc_restoreItemBG:SetShow(false)
  if self._isPadSnapping == true then
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "PaGlobalFunc_SailorPresetManager_All_DoSailorFire()")
  end
  if self._isPadSnapping == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployee(sailorIndex, itemKey, restoreValue)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  local sailorInfo = PaGlobal_SailorPresetManager_All._employeeInfoList[sailorIndex]
  if sailorInfo ~= nil then
    if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) == true then
      ToClient_requestRecoveryEmployeeByItemKey(sailorInfo._employeeNo, itemKey, restoreValue, true)
    else
      ToClient_requestRecoveryEmployeeByItemKey(sailorInfo._employeeNo, itemKey, restoreValue, false)
    end
  end
end
function HandlerEventRUp_SailorPresetManager_All_requestRecoveryEmployeeAll_Console(sailorIndex, itemKey, restoreValue)
  if nil == Panel_Window_SailorPresetManager_All then
    return
  end
  local sailorInfo = PaGlobal_SailorPresetManager_All._employeeInfoList[sailorIndex]
  if sailorInfo ~= nil then
    ToClient_requestRecoveryEmployeeByItemKey(sailorInfo._employeeNo, itemKey, restoreValue, true)
  end
end
function PaGlobalFunc_SailorPresetGroup_All_EmployeeUpdate(employeeNo)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if Panel_Window_SailorPresetManager_All ~= nil and Panel_Window_SailorPresetManager_All:GetShow() == false then
    return
  end
  self._selectedEmployeeNo = 0
  self:clearEmployeeInfoList()
  self:makeEmployeeInfoList()
  self:updateSelectEmployee(employeeNo)
  HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()
end
function PaGlobalFunc_SailorPresetManager_All_OpenEditPresetName()
  if PaGlobalFunc_SailorPreset_NameEdit_All_Open ~= nil then
    PaGlobalFunc_SailorPreset_NameEdit_All_Open()
  end
end
function PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(isShow, index)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  if index == 1 then
    control = self._ui._txt_viceCaptain
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_VICECAPTAIN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_01")
  elseif index == 2 then
    control = self._ui._txt_sail
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_SAIL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_02")
  elseif index == 3 then
    control = self._ui._txt_steering
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_STEERING")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_03")
  elseif index == 4 then
    control = self._ui._txt_cannon
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_CANNON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_04")
  elseif index == 5 then
    control = self._ui._txt_deck
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_DECK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_05")
  elseif index == 6 then
    control = self._ui._txt_cook
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_COOK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_06")
  elseif index == 7 then
    control = self._ui._txt_cabin
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_CABIN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_07")
  elseif index == 8 then
    control = self._ui._txt_fishing
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_FISH")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_08")
  end
  if control == nil then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_SailorPresetManager_All_ShowPresetNameTooltip(isShow, ii)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if currentServantWrapper == nil then
    return
  end
  local currentServantcharacterKeyRaw = currentServantWrapper:getCharacterKeyRaw()
  local presetName = ToClient_getEmployeePresetName(currentServantcharacterKeyRaw, ii - 1)
  local name, desc, control = "", "", nil
  control = UI.getChildControl(self._ui._stc_buttonArea, "Button_Group_" .. ii)
  if control == nil then
    return
  end
  if presetName ~= nil then
    desc = presetName
  else
    desc = tostring(ii)
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_SailorPresetGroup_All_Delete()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if Panel_Window_SailorPresetManager_All ~= nil and Panel_Window_SailorPresetManager_All:GetShow() == false then
    return
  end
  self:clearEmployeeInfoList()
  self:makeEmployeeInfoList()
  self:updateSelectEmployee(0)
  self:filterAndSortPossibleEmployeeList()
end
function PaGlobalFunc_SailorPresetManager_All_MoveRsLeft()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if self._currentPresetButtonNum > 1 then
    self._currentPresetButtonNum = self._currentPresetButtonNum - 1
  end
  local presetButton = UI.getChildControl(self._ui._stc_buttonArea, "Button_Group_" .. self._currentPresetButtonNum)
  ToClient_padSnapChangeToTarget(presetButton)
end
function PaGlobalFunc_SailorPresetManager_All_MoveRsRight()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if self._currentPresetButtonNum < ToClient_getEmployeePresetCount() then
    self._currentPresetButtonNum = self._currentPresetButtonNum + 1
  end
  local presetButton = UI.getChildControl(self._ui._stc_buttonArea, "Button_Group_" .. self._currentPresetButtonNum)
  ToClient_padSnapChangeToTarget(presetButton)
end
function PaGlobalFunc_SailorPresetManager_All_CheckConsoleKeyguidePresetSlot(employeePresetSlotIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  local presetSlot = self._presetSlotList[employeePresetSlotIndex + 1]
  if presetSlot == nil or presetSlot._slotIndex ~= employeePresetSlotIndex then
    return
  end
  if self._ui._txt_noSelect:GetShow() == true then
    if presetSlot._isApply == true then
      self:setConsoleKeyguide(self._keyguideState._noSelectAndApply)
    else
      self:setConsoleKeyguide(self._keyguideState._noSelect)
    end
  elseif presetSlot._isApply == true then
    self:setConsoleKeyguide(self._keyguideState._selectAndApply)
  else
    self:setConsoleKeyguide(self._keyguideState._selectAndNoApply)
  end
end
function PaGlobalFunc_SailorPresetManager_All_CheckConsoleKeyguideEmployeeList(employeeIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if self._ui._txt_noSelect:GetShow() == true then
    self:setConsoleKeyguide(self._keyguideState._noSelect)
  else
    self:setConsoleKeyguide(self._keyguideState._selectAndBottomArea)
  end
end
function FromClient_SailorPresetManager_ResponseRecoveryEmployee()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if Panel_Window_SailorPresetManager_All ~= nil and Panel_Window_SailorPresetManager_All:GetShow() == false then
    return
  end
  self:clearEmployeeInfoList()
  self:makeEmployeeInfoList()
  if self._selectedEmployeeNo ~= 0 then
    local employeeNo = self._selectedEmployeeNo
    self._selectedEmployeeNo = 0
    self:updateSelectEmployee(employeeNo)
  end
  self:clearPresetSlotData(false)
  self:setCurrentEmployeePreset()
end
function PaGlobalFunc_SailorPresetManager_ShowOtherShipEmployeeTooltip(isShow, contentIndex, controlIndex, employeeIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local employeeNo = ToClient_getPossibleEmployeeNoByIndex(employeeIndex)
  local sailorInfo = PaGlobalFunc_SailorPresetManager_All_GetEmployeeInfo(employeeNo)
  if sailorInfo == nil then
    return
  end
  local servantInfo = stable_getServantByServantNo(sailorInfo._onServantNo)
  if servantInfo == nil then
    return
  end
  local control
  local content = self._ui._list2_employee:GetContentByKey(toInt64(0, contentIndex))
  if content ~= nil then
    control = UI.getChildControl(content, "Static_SailorSlotBg_" .. controlIndex)
  end
  if control ~= nil then
    TooltipSimple_Show(control, "", servantInfo:getName())
  end
end
function PaGlobalFunc_SailorPresetManager_All_PresetSlotSimpleTooltip(isShow, presetIndex)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  if self._isPadSnapping == true then
    local presetSlotIndex = presetIndex - 1
    PaGlobalFunc_SailorPresetManager_All_CheckConsoleKeyguidePresetSlot(presetSlotIndex)
  end
  local name, desc, control = "", "", nil
  local presetSlot = self._presetSlotList[presetIndex]
  if presetSlot == nil or presetSlot._isApply == true then
    return
  end
  control = presetSlot._stc_control
  if control == nil then
    return
  end
  if presetSlot._slotPresetJob == __eEmployeePresetJob_ViceCaptain then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_VICECAPTAIN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_01")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Sail then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_SAIL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_02")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Helmsman then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_STEERING")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_03")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_CannonSlot then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_CANNON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_04")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Deck then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_DECK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_05")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Cook then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_COOK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_06")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Cabin then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_CABIN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_07")
  elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Fishing then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_FISH")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_SLOT_08")
  end
  TooltipSimple_Show(control, name, desc, false)
end
function PaGlobalFunc_SailorPresetManager_All_BuyEmployeeSlotItem()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_EasyBuy_Open(114)
end
function PaGlobalFunc_SailorPresetManager_All_BuyEmployeePresetItem()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  PaGlobalFunc_EasyBuy_Open(134)
end
function FromClient_SailorPresetManager_EmployeeVarySlotAck(varySlotCount)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if _ContentsGroup_EmployeePresetJob == false then
    return
  end
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SAILORSLOTITEM_RESULT", "varySlot", tostring(varySlotCount)))
  local filterEmployeeCount = ToClient_getPossibleEmployeeNoListSize()
  local employeeMaxSlotCount = ToClient_getEmployeeMaxSlotCount()
  self._ui._txt_sailorSlotCount:SetText(filterEmployeeCount .. "/" .. employeeMaxSlotCount)
end
function HandleEventLUp_SailorPresetManager_ShowRestoreItemTooltip(isShow, index, loyalismType)
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if isShow == false then
    if self._isPadSnapping == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local itemKey = ToClient_getRecoveryItemkeyByIndex(index - 1, loyalismType)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if self._isPadSnapping == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemSSW, self._ui._stc_restoreItemBG, true, false)
  end
end
function FromClient_SailorPresetManager_IncreaseEmployeePreset()
  local self = PaGlobal_SailorPresetManager_All
  if self == nil then
    return
  end
  self:setControl()
  if PaGlobalFunc_SailorPreset_NameEdit_All_IsOpen ~= nil and PaGlobalFunc_SailorPreset_NameEdit_All_IsOpen() == true and PaGlobalFunc_SailorPreset_NameEdit_All_Close ~= nil then
    PaGlobalFunc_SailorPreset_NameEdit_All_Close()
  end
end
