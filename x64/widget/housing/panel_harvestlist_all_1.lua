function PaGlobal_HarvestList_All:initialize()
  if true == PaGlobal_HarvestList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_HarvestTitle = UI.getChildControl(Panel_HarvestList_All, "Static_HarvestTitle")
  self._ui_pc.btn_Exit = UI.getChildControl(stc_HarvestTitle, "Button_Exit")
  self._ui.stc_InfoArea = UI.getChildControl(Panel_HarvestList_All, "Static_InfoArea")
  local stc_HarvestInfoArea = UI.getChildControl(self._ui.stc_InfoArea, "Static_HarvestInfoArea")
  local stc_InfoList = UI.getChildControl(stc_HarvestInfoArea, "Static_InfoList")
  local btn_Work = UI.getChildControl(stc_InfoList, "Button_doWork")
  local btn_Navi = UI.getChildControl(stc_InfoList, "Button_Navi")
  for index = 0, self._maxTentCount - 1 do
    self.slot[index] = {}
    local slot = self.slot[index]
    slot.bg = UI.createAndCopyBasePropertyControl(stc_HarvestInfoArea, "Static_InfoList", stc_HarvestInfoArea, "HarvestSlotBG_" .. index)
    slot.territotyName = UI.createAndCopyBasePropertyControl(stc_InfoList, "StaticText_TerritotyName", slot.bg, "HarvestSlotTerritotyName_" .. index)
    slot.townName = UI.createAndCopyBasePropertyControl(stc_InfoList, "StaticText_TownName", slot.bg, "HarvestSlot_TownName_" .. index)
    slot.address = UI.createAndCopyBasePropertyControl(stc_InfoList, "StaticText_Address", slot.bg, "HarvestSlot_Address_" .. index)
    slot.btnDoWork = UI.createAndCopyBasePropertyControl(stc_InfoList, "Button_doWork", slot.bg, "HarvestSlot_DoWorkBtn_" .. index)
    slot.workIcon = UI.createAndCopyBasePropertyControl(btn_Work, "Static_Worker", slot.btnDoWork, "HarvestSlot_DoWorkIcon_" .. index)
    slot.btnNavi = UI.createAndCopyBasePropertyControl(stc_InfoList, "Button_Navi", slot.bg, "HarvestSlot_NaviBtn_" .. index)
    slot.naviIcon = UI.createAndCopyBasePropertyControl(btn_Navi, "Static_NaviIcon", slot.btnNavi, "HarvestSlot_NaviIcon_" .. index)
    slot.txt_SeedCount = UI.createAndCopyBasePropertyControl(stc_InfoList, "StaticText_SeedCount", slot.bg, "HarvestSlot_SeedCount_" .. index)
    slot.stc_TentTimeIcon = UI.createAndCopyBasePropertyControl(stc_InfoList, "Static_TentTimeIcon", slot.bg, "HarvestSlot_TimeIcon_" .. index)
    slot.txt_ProgressPercent = UI.createAndCopyBasePropertyControl(stc_InfoList, "StaticText_ProgressPercent", slot.bg, "HarvestSlot_Percent_" .. index)
    if true == self._isConsole then
      slot.btnInfo = UI.createAndCopyBasePropertyControl(stc_InfoList, "RadioButton_Info_Console", slot.bg, "HarvestSlot_InfoBtn_" .. index)
    else
      slot.btnInfo = UI.createAndCopyBasePropertyControl(stc_InfoList, "RadioButton_Info", slot.bg, "HarvestSlot_InfoBtn_" .. index)
    end
    slot.tentPos = float3(0, 0, 0)
    local slotPosY = (slot.bg:GetSizeY() + self.config.cellSpan) * index + self.config.startPosY
    slot.bg:SetPosY(slotPosY)
    slot.btnInfo:SetShow(true)
    if true == self._isConsole then
      slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_HarvestList_All_NavigatorStart(" .. index .. ")")
      slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_HarvestList_All_TentInfoShow(" .. index .. ")")
    else
      slot.btnNavi:addInputEvent("Mouse_LUp", "HandleEventLUp_HarvestList_All_NavigatorStart(" .. index .. ")")
      slot.btnInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_HarvestList_All_TentInfoShow(" .. index .. ")")
      slot.bg:addInputEvent("Mouse_LUp", "HandleEventLUp_HarvestList_All_TentInfoShow(" .. index .. ")")
    end
  end
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_HarvestList_All, "Static_Console_KeyGuide")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Key_Y")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Key_X")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Key_A")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Key_B")
  local keyguides = {
    self._ui_console.txt_KeyGuideY,
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self:changePlatform()
  PaGlobal_HarvestList_All:registEventHandler()
  PaGlobal_HarvestList_All:validate()
  PaGlobal_HarvestList_All._initialize = true
end
function PaGlobal_HarvestList_All:registEventHandler()
  if nil == Panel_HarvestList_All then
    return
  end
  if true == self._isConsole then
  else
    self._ui_pc.btn_Exit:addInputEvent("Mouse_LUp", "PaGlobal_HarvestList_All_Close()")
  end
  registerEvent("FromClient_RenderModeChangeState", "FromClient_HarvestList_RenderModeChange")
end
function PaGlobal_HarvestList_All:prepareOpen()
  if nil == Panel_HarvestList_All then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  PaGlobal_HarvestList_All:update()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local myTentCount = temporaryWrapper:getSelfTentCount()
  if myTentCount > 0 then
    HandleEventLUp_HarvestList_All_TentInfoShow(0)
    self.slot[self._selectInfoIndex].btnInfo:SetCheck(true)
  end
  PaGlobal_HarvestList_All:open()
end
function PaGlobal_HarvestList_All:open()
  if nil == Panel_HarvestList_All then
    return
  end
  Panel_HarvestList_All:SetShow(true)
end
function PaGlobal_HarvestList_All:prepareClose()
  if nil == Panel_HarvestList_All then
    return
  end
  audioPostEvent_SystemUi(13, 5)
  _AudioPostEvent_SystemUiForXBOX(13, 5)
  self._selectInfoIndex = 0
  PaGlobal_Worldmap_TentInfo_All_Close()
  PaGlobal_HarvestList_All:close()
end
function PaGlobal_HarvestList_All:close()
  if nil == Panel_HarvestList_All then
    return
  end
  Panel_HarvestList_All:SetShow(false)
end
function PaGlobal_HarvestList_All:update()
  if nil == Panel_HarvestList_All then
    return
  end
  for index = 0, self._maxTentCount - 1 do
    self.slot[index].bg:SetShow(false)
    self.slot[index].btnInfo:SetCheck(false)
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local myTentCount = temporaryWrapper:getSelfTentCount()
  if myTentCount <= 0 then
    return
  end
  for index = 0, myTentCount - 1 do
    local householdDataWithInstallationWrapper = temporaryWrapper:getSelfTentWrapperByIndex(index)
    if nil == householdDataWithInstallationWrapper then
      return
    end
    local characterSSW = householdDataWithInstallationWrapper:getHouseholdCharacterStaticStatusWrapper()
    if nil ~= characterSSW and characterSSW:getName() ~= nil then
      local tentWrapper = temporaryWrapper:getSelfTentWrapperByIndex(index)
      if nil == tentWrapper then
        return
      end
      local tentPosX = tentWrapper:getSelfTentPositionX()
      local tentPosY = tentWrapper:getSelfTentPositionY()
      local tentPosZ = tentWrapper:getSelfTentPositionZ()
      local tentPos = float3(tentPosX, tentPosY, tentPosZ)
      self.slot[index].tentPos = tentPos
      local regionWrapper = ToClient_getRegionInfoWrapperByPosition(tentPos)
      self.slot[index].territotyName:SetText(regionWrapper:getTerritoryName())
      self.slot[index].btnNavi:SetPosX(self.slot[index].territotyName:GetPosX() + self.slot[index].territotyName:GetSizeX() / 2 + self.slot[index].territotyName:GetTextSizeX() / 2 + 10)
      self.slot[index].townName:SetText(regionWrapper:getAreaName())
      local tentItemSSW = characterSSW:getItemEnchantStatcStaticWrapper()
      local tentName = characterSSW:getName()
      local tentGrade = tentItemSSW:getGradeType()
      if 0 == tentGrade then
        tentName = "<PAColor0xFFC4C4C4>" .. tentName .. "<PAOldColor>"
      elseif 1 == tentGrade then
        tentName = "<PAColor0xFF83A543>" .. tentName .. "<PAOldColor>"
      elseif 2 == tentGrade then
        tentName = "<PAColor0xFF438DCC>" .. tentName .. "<PAOldColor>"
      elseif 3 == tentGrade then
        tentName = "<PAColor0xFFF5BA3A>" .. tentName .. "<PAOldColor>"
      elseif 4 == tentGrade then
        tentName = "<PAColor0xFFD05D48>" .. tentName .. "<PAOldColor>"
      else
        tentName = "<PAColor0xFFC4C4C4>" .. tentName .. "<PAOldColor>"
      end
      self.slot[index].address:SetText(tentName)
      self.slot[index].txt_SeedCount:SetPosX(self.slot[index].address:GetPosX() + self.slot[index].address:GetSizeX() / 2 + self.slot[index].address:GetTextSizeX() / 2 + 5)
      self.slot[index].txt_SeedCount:SetText("(" .. tostring(tentWrapper:getSelfHarvestCount()) .. ")")
      local isWork = self:isWorkeOnHarvest(householdDataWithInstallationWrapper)
      if true == isWork then
        self.slot[index].workIcon:SetColor(Defines.Color.C_FFEBC467)
        if true == self._isConsole then
          self.slot[index].bg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
        else
          self.slot[index].btnDoWork:addInputEvent("Mouse_LUp", "")
          self.slot[index].btnDoWork:addInputEvent("Mouse_On", "HandleEventOn_HarvestList_All_WorkTooltipShow( true , " .. tostring(index) .. " )")
          self.slot[index].btnDoWork:addInputEvent("Mouse_Out", "HandleEventOn_HarvestList_All_WorkTooltipShow (  false , " .. tostring(index) .. " )")
        end
      else
        self.slot[index].workIcon:SetColor(Defines.Color.C_FFE0E0E0)
        if true == self._isConsole then
          self.slot[index].bg:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_HarvestList_All_WorkManagerOpen(" .. index .. ")")
        else
          self.slot[index].btnDoWork:addInputEvent("Mouse_LUp", "HandleEventLUp_HarvestList_All_WorkManagerOpen(" .. index .. ")")
          self.slot[index].btnDoWork:addInputEvent("Mouse_On", "")
          self.slot[index].btnDoWork:addInputEvent("Mouse_Out", "")
        end
      end
      if self._selectInfoIndex == index then
        self.slot[index].btnInfo:SetCheck(true)
      end
      self.slot[index].bg:SetShow(true)
      local count = householdDataWithInstallationWrapper:getSelfHarvestCount()
      local _min = 200
      local _name = ""
      if count > 0 then
        for ii = 0, count - 1 do
          local progressingInfo = householdDataWithInstallationWrapper:getInstallationProgressingInfo(ii)
          if nil ~= progressingInfo then
            local harvestCharacterSSW = householdDataWithInstallationWrapper:getSelfHarvest(ii)
            if nil == harvestCharacterSSW then
              return
            end
            local percent = math.min(householdDataWithInstallationWrapper:getSelfHarvestCompleteRate(ii) * 100, 200)
            if _min >= percent then
              _name = harvestCharacterSSW:getName()
              _min = math.floor(percent)
            end
            local itemSSW = harvestCharacterSSW:getItemEnchantStatcStaticWrapper()
            local itemGrade = itemSSW:getGradeType()
            if 0 == itemGrade then
              _name = "<PAColor0xFFC4C4C4>" .. _name .. "<PAOldColor>"
            elseif 1 == itemGrade then
              _name = "<PAColor0xFF83A543>" .. _name .. "<PAOldColor>"
            elseif 2 == itemGrade then
              _name = "<PAColor0xFF438DCC>" .. _name .. "<PAOldColor>"
            elseif 3 == itemGrade then
              _name = "<PAColor0xFFF5BA3A>" .. _name .. "<PAOldColor>"
            elseif 4 == itemGrade then
              _name = "<PAColor0xFFD05D48>" .. _name .. "<PAOldColor>"
            else
              _name = "<PAColor0xFFC4C4C4>" .. _name .. "<PAOldColor>"
            end
          end
        end
        self.slot[index].townName:SetSpanSize(510, 0)
        self.slot[index].townName:SetText(_name)
        self.slot[index].txt_ProgressPercent:SetText("(" .. _min .. "%)")
        self.slot[index].txt_ProgressPercent:SetPosX(self.slot[index].townName:GetPosX() + self.slot[index].townName:GetSizeX() / 2 + self.slot[index].townName:GetTextSizeX() / 2 + 5)
        self.slot[index].txt_ProgressPercent:SetShow(true)
      else
        self.slot[index].townName:SetSpanSize(525, 0)
        self.slot[index].townName:SetText("-")
        self.slot[index].txt_ProgressPercent:SetShow(false)
      end
      local expireTime_s64 = householdDataWithInstallationWrapper:getSelfTentExpiredTime_s64()
      local lefttime_hour = Int64toInt32(getLeftSecond_TTime64(expireTime_s64)) / 3600
      self.slot[index].stc_TentTimeIcon:SetPosX(self.slot[index].txt_SeedCount:GetPosX() + self.slot[index].txt_SeedCount:GetTextSizeX() + 5)
      if lefttime_hour < 48 then
        self.slot[index].stc_TentTimeIcon:SetColor(4294925640)
        self.slot[index].stc_TentTimeIcon:SetShow(true)
      elseif lefttime_hour < 168 then
        self.slot[index].stc_TentTimeIcon:SetColor(4294962752)
        self.slot[index].stc_TentTimeIcon:SetShow(true)
      else
        self.slot[index].stc_TentTimeIcon:SetShow(false)
      end
    end
  end
end
function PaGlobal_HarvestList_All:validate()
  if nil == Panel_HarvestList_All then
    return
  end
  self._ui_pc.btn_Exit:isValidate()
  self._ui.stc_InfoArea:isValidate()
end
function PaGlobal_HarvestList_All:isWorkeOnHarvest(houseWrapper)
  if nil == Panel_HarvestList_All then
    return
  end
  if nil == houseWrapper then
    return
  end
  local houseHoldNo = houseWrapper:getHouseholdNo()
  return ToClient_hasWorkerWorkingInHarvest(houseHoldNo)
end
function PaGlobal_HarvestList_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
