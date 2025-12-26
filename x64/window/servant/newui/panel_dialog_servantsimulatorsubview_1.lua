function ServantSimulatorSubView_GroupSort(ii, jj)
  if ii._tierValue < jj._tierValue then
    return -1
  elseif ii._tierValue > jj._tierValue then
    return 1
  else
    return 0
  end
end
function PaGlobal_ServantSimulatorSubView:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBg = UI.getChildControl(Panel_Dialog_ServantSimulatorSubView, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleBg, "Button_Close")
  local tabBg = UI.getChildControl(Panel_Dialog_ServantSimulatorSubView, "Static_RadioButtonBg")
  self._ui._btn_all = UI.getChildControl(tabBg, "RadioButton_All")
  self._ui._btn_mine = UI.getChildControl(tabBg, "RadioButton_Mine")
  self._tabList[self._tabType.ALL] = self._ui._btn_all
  self._tabList[self._tabType.MINE] = self._ui._btn_mine
  self._ui._stc_selectLine = UI.getChildControl(tabBg, "Static_SelectBar")
  self._ui._frm_selectList = UI.getChildControl(Panel_Dialog_ServantSimulatorSubView, "Frame_SelectList")
  self._ui._frmContent_selectList = UI.getChildControl(self._ui._frm_selectList, "Frame_1_Content")
  self._ui._stc_frameGroupTemplate = UI.getChildControl(self._ui._frmContent_selectList, "Static_GroupTemplate")
  self._ui._stc_frameHorseTemplate = UI.getChildControl(self._ui._stc_frameGroupTemplate, "Static_HorseImageTemplate")
  self._ui._stc_keyGuideLB = UI.getChildControl(tabBg, "Static_LB_ConsoleUI")
  self._ui._stc_keyGuideRB = UI.getChildControl(tabBg, "Static_RB_ConsoleUI")
  self._ui._stc_keyGuideBg = UI.getChildControl(Panel_Dialog_ServantSimulatorSubView, "Static_KeyGuideBg")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B")
  self._ui._stc_frameGroupTemplate:SetShow(false)
  self._ui._stc_frameHorseTemplate:SetShow(false)
  self._ui._stc_keyGuideLB:SetShow(self._isConsole)
  self._ui._stc_keyGuideRB:SetShow(self._isConsole)
  self._ui._stc_keyGuideBg:SetShow(self._isConsole)
  self._ui._stc_keyGuide_A:SetShow(self._isConsole)
  self._ui._stc_keyGuide_B:SetShow(self._isConsole)
  self._ui._btn_close:SetShow(self._isConsole == false)
  if self._isConsole == true then
    local keyGuideList = {
      self._ui._stc_keyGuide_A,
      self._ui._stc_keyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self:changeTab(self._tabType.ALL)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ServantSimulatorSubView:registEventHandler()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  if self._isConsole == true then
    Panel_Dialog_ServantSimulatorSubView:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_ServantSimulatorSubView_ChangeTabConsole( false )")
    Panel_Dialog_ServantSimulatorSubView:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_ServantSimulatorSubView_ChangeTabConsole( true )")
  end
  self._ui._btn_all:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulatorSubView_ChangeTab(" .. tostring(self._tabType.ALL) .. ")")
  self._ui._btn_mine:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulatorSubView_ChangeTab(" .. tostring(self._tabType.MINE) .. ")")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSimulatorSubView_Close()")
end
function PaGlobal_ServantSimulatorSubView:validate()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
end
function PaGlobal_ServantSimulatorSubView:prepareOpen(openType, maleType)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  self:setTabList(openType)
  self:setData(openType, maleType)
  self:setPanelPosition()
  self:open()
  if Panel_Dialog_ServantSimulator:IsUISubApp() == true then
    Panel_Dialog_ServantSimulatorSubView:OpenUISubApp()
  else
    Panel_Dialog_ServantSimulatorSubView:CloseUISubApp()
  end
end
function PaGlobal_ServantSimulatorSubView:open()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  Panel_Dialog_ServantSimulatorSubView:SetShow(true)
end
function PaGlobal_ServantSimulatorSubView:prepareClose()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  Panel_Dialog_ServantSimulatorSubView:CloseUISubApp()
  self._openType = nil
  self._maleType = nil
  self:close()
end
function PaGlobal_ServantSimulatorSubView:close()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  Panel_Dialog_ServantSimulatorSubView:SetShow(false)
end
function PaGlobal_ServantSimulatorSubView:changeTab(tabType)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  if self._tabList[tabType] == nil then
    return
  end
  if self._tabList[tabType]:GetShow() == false then
    return
  end
  if tabType == self._tabType.ALL then
    self._ui._btn_all:SetCheck(true)
    self._ui._btn_mine:SetCheck(false)
    self._ui._stc_selectLine:SetSpanSize(self._ui._btn_all:GetSpanSize().x, self._ui._stc_selectLine:GetSpanSize().y)
    self._ui._stc_selectLine:ComputePos()
  elseif tabType == self._tabType.MINE then
    self._ui._btn_all:SetCheck(false)
    self._ui._btn_mine:SetCheck(true)
    self._ui._stc_selectLine:SetSpanSize(self._ui._btn_mine:GetSpanSize().x, self._ui._stc_selectLine:GetSpanSize().y)
    self._ui._stc_selectLine:ComputePos()
  else
    UI.ASSERT_NAME(false, "tabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if self._openType ~= nil then
    self:setData(self._openType, self._maleType)
  end
end
function PaGlobal_ServantSimulatorSubView:setData(openType, maleType)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  self:clearGroupList()
  self._openType = openType
  self._maleType = maleType
  if openType == PaGlobal_ServantSimulator._tabType.GROWUP then
    self:updateFrame_GrowUp(self._ui._btn_mine:IsCheck())
  elseif openType == PaGlobal_ServantSimulator._tabType.MATING then
    self:updateFrame_Mating(self._ui._btn_mine:IsCheck())
  elseif openType == PaGlobal_ServantSimulator._tabType.DETAIL then
    self:updateFrame_Detail(true)
  else
    UI.ASSERT_NAME(false, "openType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    self._openType = nil
    self._maleType = nil
    return
  end
  self:refreshHorseFrameSize()
  if self._isConsole == true then
    ToClient_padSnapRefreshTarget(Panel_Dialog_ServantSimulatorSubView)
  end
end
function PaGlobal_ServantSimulatorSubView:setPanelPosition()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  local parentPanelCenterPosX = Panel_Dialog_ServantSimulator:GetPosX() + Panel_Dialog_ServantSimulator:GetSizeX() / 2
  local parentPanelCenterPosY = Panel_Dialog_ServantSimulator:GetPosY() + Panel_Dialog_ServantSimulator:GetSizeY() / 2
  Panel_Dialog_ServantSimulatorSubView:SetPosX(parentPanelCenterPosX - Panel_Dialog_ServantSimulatorSubView:GetSizeX() / 2)
  Panel_Dialog_ServantSimulatorSubView:SetPosY(parentPanelCenterPosY - Panel_Dialog_ServantSimulatorSubView:GetSizeY() / 2)
end
function PaGlobal_ServantSimulatorSubView:updateFrame_GrowUp(isOnlyMyHorse)
  if Panel_Dialog_ServantSimulatorSubView == nil or isOnlyMyHorse == nil then
    return
  end
  local dataCount = 0
  if isOnlyMyHorse == true then
    dataCount = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoCount()
  else
    dataCount = ToClient_GetHorseSimulateGrowUpAllSelectInfoCount()
  end
  for index = 1, dataCount do
    local dataWrapper
    if isOnlyMyHorse == true then
      dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(index - 1)
    else
      dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(index - 1)
    end
    local isMutationHorse = false
    local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
    local servantInfo = stable_getServantByCharacterKey(CharacterKey(horseCharacterKeyRaw), 1)
    if servantInfo ~= nil then
      local vehicleSubType = servantInfo:getVehicleSubType()
      local vehicleType = servantInfo:getVehicleType()
      isMutationHorse = vehicleType == __eVehicleType_Horse and vehicleSubType == __eTVehicleSubType_MutationHorse
    end
    if dataWrapper ~= nil then
      local horseTierValue = dataWrapper:getTier()
      if isMutationHorse == true then
        horseTierValue = -1
      end
      local groupDataIndex = self:findGroupDataIndex(horseTierValue)
      local groupData
      if groupDataIndex == nil then
        groupData = self:makeGroupData("Group_Tier_", horseTierValue)
        if isMutationHorse == true then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_IMPERIALHORSELIST"))
        elseif horseTierValue == 9 then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_9TIERLIST"))
        else
          groupData._title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LIST", "tier", horseTierValue))
        end
        self._groupList:push_back(groupData)
      else
        groupData = self._groupList[groupDataIndex]
      end
      groupData._group:SetShow(true)
      groupData._title:SetShow(true)
      groupData._showHorseCount = groupData._showHorseCount + 1
      local horseData = groupData._horseList[groupData._showHorseCount]
      if horseData == nil then
        horseData = self:makeHorseData(groupData._group, "Horse_" .. tostring(groupData._showHorseCount))
        groupData._horseList:push_back(horseData)
      end
      horseData._horse:SetShow(true)
      self:changeHorseImage(horseData._image, dataWrapper)
      horseData._image:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSimulator_SetGrowUpSelectResult(" .. tostring(self._openType) .. ", " .. tostring(isOnlyMyHorse) .. ", " .. tostring(self._maleType) .. "," .. tostring(index - 1) .. ")")
      horseData._image:removeInputEvent("Mouse_On")
      horseData._image:removeInputEvent("Mouse_Out")
      horseData._image:SetShow(true)
      local genderTextureId
      if servantInfo ~= nil and servantInfo:isDisplayGender() == false then
        horseData._gender:SetShow(false)
      else
        if dataWrapper:isMale() == true then
          genderTextureId = "Combine_Etc_Stable_Male"
        else
          genderTextureId = "Combine_Etc_Stable_Female"
        end
        horseData._gender:ChangeTextureInfoTextureIDAsync(genderTextureId)
        horseData._gender:setRenderTexture(horseData._gender:getBaseTexture())
        horseData._gender:SetShow(true)
      end
      if dataWrapper:isMyHorse() == true then
        local horseNameString = dataWrapper:getMyHorseNameForLua()
        horseData._name:SetText(horseNameString)
        horseData._name:SetShow(true)
      else
        horseData._name:SetShow(false)
      end
      if self._isConsole == true then
        horseData._image:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( true, " .. tostring(groupDataIndex) .. ", " .. tostring(groupData._showHorseCount) .. ", " .. tostring(self._maleType) .. ", " .. tostring(index - 1) .. ", " .. tostring(isOnlyMyHorse) .. ")")
        horseData._image:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( false )")
      end
      horseData._gender:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( true, " .. tostring(groupDataIndex) .. ", " .. tostring(groupData._showHorseCount) .. ", " .. tostring(self._maleType) .. ", " .. tostring(index - 1) .. ", " .. tostring(isOnlyMyHorse) .. ")")
      horseData._gender:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( false )")
      horseData._rate:SetShow(false)
    end
  end
end
function PaGlobal_ServantSimulatorSubView:updateFrame_Mating(isOnlyMyHorse)
  if Panel_Dialog_ServantSimulatorSubView == nil or isOnlyMyHorse == nil then
    return
  end
  if self._maleType ~= __eHorseSimulateHorseMaleType_Male and self._maleType ~= __eHorseSimulateHorseMaleType_Female then
    UI.ASSERT_NAME(false, "maleType \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local dataCount = 0
  if isOnlyMyHorse == true then
    dataCount = ToClient_GetHorseSimulateMatingMyHorseSelectInfoCount(self._maleType)
  else
    dataCount = ToClient_GetHorseSimulateMatingAllSelectInfoCount(self._maleType)
  end
  for index = 1, dataCount do
    local dataWrapper
    if isOnlyMyHorse == true then
      dataWrapper = ToClient_GetHorseSimulateMatingMyHorseSelectInfoByIndex(self._maleType, index - 1)
    else
      dataWrapper = ToClient_GetHorseSimulateMatingAllSelectInfoByIndex(self._maleType, index - 1)
    end
    local isMutationHorse = false
    local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
    local servantInfo = stable_getServantByCharacterKey(CharacterKey(horseCharacterKeyRaw), 1)
    if servantInfo ~= nil then
      local vehicleSubType = servantInfo:getVehicleSubType()
      local vehicleType = servantInfo:getVehicleType()
      isMutationHorse = vehicleType == __eVehicleType_Horse and vehicleSubType == __eTVehicleSubType_MutationHorse
    end
    if dataWrapper ~= nil then
      local horseTierValue = dataWrapper:getTier()
      if isMutationHorse == true then
        horseTierValue = -1
      end
      local groupDataIndex = self:findGroupDataIndex(horseTierValue)
      local groupData
      if groupDataIndex == nil then
        groupData = self:makeGroupData("Group_Tier_", horseTierValue)
        if isMutationHorse == true then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_IMPERIALHORSELIST"))
        elseif horseTierValue == 9 then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_9TIERLIST"))
        else
          groupData._title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LIST", "tier", horseTierValue))
        end
        self._groupList:push_back(groupData)
      else
        groupData = self._groupList[groupDataIndex]
      end
      groupData._group:SetShow(true)
      groupData._title:SetShow(true)
      groupData._showHorseCount = groupData._showHorseCount + 1
      local horseData = groupData._horseList[groupData._showHorseCount]
      if horseData == nil then
        horseData = self:makeHorseData(groupData._group, "Horse_" .. tostring(groupData._showHorseCount))
        groupData._horseList:push_back(horseData)
      end
      horseData._horse:SetShow(true)
      self:changeHorseImage(horseData._image, dataWrapper)
      horseData._image:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSimulator_SetGrowUpSelectResult(" .. tostring(self._openType) .. ", " .. tostring(isOnlyMyHorse) .. ", " .. tostring(self._maleType) .. "," .. tostring(index - 1) .. ")")
      horseData._image:removeInputEvent("Mouse_On")
      horseData._image:removeInputEvent("Mouse_Out")
      horseData._image:SetShow(true)
      local genderTextureId
      if servantInfo ~= nil and servantInfo:isDisplayGender() == false then
        horseData._gender:SetShow(false)
      else
        if dataWrapper:isMale() == true then
          genderTextureId = "Combine_Etc_Stable_Male"
        else
          genderTextureId = "Combine_Etc_Stable_Female"
        end
        horseData._gender:ChangeTextureInfoTextureIDAsync(genderTextureId)
        horseData._gender:setRenderTexture(horseData._gender:getBaseTexture())
        horseData._gender:SetShow(true)
      end
      if dataWrapper:isMyHorse() == true then
        local horseNameString = dataWrapper:getMyHorseNameForLua()
        horseData._name:SetText(horseNameString)
        horseData._name:SetShow(true)
      else
        horseData._name:SetShow(false)
      end
      if self._isConsole == true then
        horseData._image:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( true, " .. tostring(groupDataIndex) .. ", " .. tostring(groupData._showHorseCount) .. ", " .. tostring(self._maleType) .. ", " .. tostring(index - 1) .. ", " .. tostring(isOnlyMyHorse) .. ")")
        horseData._image:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( false )")
      end
      horseData._gender:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( true, " .. tostring(groupDataIndex) .. ", " .. tostring(groupData._showHorseCount) .. ", " .. tostring(self._maleType) .. ", " .. tostring(index - 1) .. ", " .. tostring(isOnlyMyHorse) .. ")")
      horseData._gender:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( false )")
      horseData._rate:SetShow(false)
    end
  end
end
function PaGlobal_ServantSimulatorSubView:updateFrame_Detail(isOnlyMyHorse)
  if Panel_Dialog_ServantSimulatorSubView == nil or isOnlyMyHorse == nil then
    return
  end
  if isOnlyMyHorse == false then
    return
  end
  local dataCount = 0
  dataCount = ToClient_GetHorseSimulateDetailInformationMyHorseInfoCount()
  for index = 1, dataCount do
    local dataWrapper
    dataWrapper = ToClient_GetHorseSimulateDetailInformationMyHorseInfoByIndex(index - 1)
    if dataWrapper ~= nil then
      local isMutationHorse = false
      local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
      local servantInfo = stable_getServantByCharacterKey(CharacterKey(horseCharacterKeyRaw), 1)
      if servantInfo ~= nil then
        local vehicleSubType = servantInfo:getVehicleSubType()
        local vehicleType = servantInfo:getVehicleType()
        isMutationHorse = vehicleType == __eVehicleType_Horse and vehicleSubType == __eTVehicleSubType_MutationHorse
      end
      local horseTierValue = dataWrapper:getTier()
      if isMutationHorse == true then
        horseTierValue = -1
      end
      local groupDataIndex = self:findGroupDataIndex(horseTierValue)
      local groupData
      if groupDataIndex == nil then
        groupData = self:makeGroupData("Group_Tier_", horseTierValue)
        if isMutationHorse == true then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_IMPERIALHORSELIST"))
        elseif horseTierValue == 0 then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "FRIEND_TEXT_GROUP_ETC"))
        elseif horseTierValue == 9 then
          groupData._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_9TIERLIST"))
        else
          groupData._title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LIST", "tier", horseTierValue))
        end
        self._groupList:push_back(groupData)
      else
        groupData = self._groupList[groupDataIndex]
      end
      groupData._group:SetShow(true)
      groupData._title:SetShow(true)
      groupData._showHorseCount = groupData._showHorseCount + 1
      local horseData = groupData._horseList[groupData._showHorseCount]
      if horseData == nil then
        horseData = self:makeHorseData(groupData._group, "Horse_" .. tostring(groupData._showHorseCount))
        groupData._horseList:push_back(horseData)
      end
      horseData._horse:SetShow(true)
      self:changeHorseImage(horseData._image, dataWrapper)
      horseData._image:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSimulator_SetGrowUpSelectResult(" .. tostring(self._openType) .. ", " .. tostring(isOnlyMyHorse) .. ", " .. tostring(self._maleType) .. "," .. tostring(index - 1) .. ")")
      horseData._image:removeInputEvent("Mouse_On")
      horseData._image:removeInputEvent("Mouse_Out")
      horseData._image:SetShow(true)
      local genderTextureId
      if servantInfo ~= nil and servantInfo:isDisplayGender() == false then
        horseData._gender:SetShow(false)
      else
        if dataWrapper:isMale() == true then
          genderTextureId = "Combine_Etc_Stable_Male"
        else
          genderTextureId = "Combine_Etc_Stable_Female"
        end
        horseData._gender:ChangeTextureInfoTextureIDAsync(genderTextureId)
        horseData._gender:setRenderTexture(horseData._gender:getBaseTexture())
        horseData._gender:SetShow(true)
      end
      local horseNameString = ""
      if dataWrapper:isMyHorse() == true then
        horseNameString = dataWrapper:getMyHorseNameForLua()
      else
        horseNameString = dataWrapper:getHorseTitleNameForLua()
      end
      if ToClient_IsDevelopment() == true then
        horseNameString = horseNameString .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
      end
      if self._isConsole == true then
        horseData._image:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( true, " .. tostring(groupDataIndex) .. ", " .. tostring(groupData._showHorseCount) .. ", " .. tostring(self._maleType) .. ", " .. tostring(index - 1) .. ", " .. tostring(isOnlyMyHorse) .. ")")
        horseData._image:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( false )")
      end
      horseData._gender:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( true, " .. tostring(groupDataIndex) .. ", " .. tostring(groupData._showHorseCount) .. ", " .. tostring(self._maleType) .. ", " .. tostring(index - 1) .. ", " .. tostring(isOnlyMyHorse) .. ")")
      horseData._gender:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip( false )")
      horseData._name:SetText(horseNameString)
      horseData._name:SetShow(true)
      horseData._rate:SetShow(false)
    end
  end
end
function PaGlobal_ServantSimulatorSubView:clearGroupList()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  if self._groupList == nil then
    self._groupList = Array.new()
  else
    for key, value in pairs(self._groupList) do
      if value ~= nil then
        value._group:SetShow(false)
        for horseKey, horseValue in pairs(value._horseList) do
          if horseValue ~= nil then
            horseValue._horse:SetShow(false)
          end
        end
        value._showHorseCount = 0
      end
    end
  end
end
function PaGlobal_ServantSimulatorSubView:makeGroupData(name, tierValue)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return nil
  end
  local groupData = {
    _group = nil,
    _title = nil,
    _tierValue = nil,
    _showHorseCount = nil,
    _horseList = nil
  }
  groupData._group = UI.cloneControl(self._ui._stc_frameGroupTemplate, self._ui._frmContent_selectList, name .. tostring(tierValue))
  groupData._title = UI.getChildControl(groupData._group, "StaticText_GroupTitle")
  groupData._tierValue = tierValue
  groupData._showHorseCount = 0
  groupData._horseList = Array.new()
  return groupData
end
function PaGlobal_ServantSimulatorSubView:makeHorseData(parent, name)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return nil
  end
  local horseData = {
    _horse = nil,
    _image = nil,
    _gender = nil,
    _name = nil,
    _rate = nil
  }
  horseData._horse = UI.cloneControl(self._ui._stc_frameHorseTemplate, parent, name)
  horseData._image = UI.getChildControl(horseData._horse, "Static_RealImage")
  horseData._gender = UI.getChildControl(horseData._horse, "Static_Gender")
  horseData._name = UI.getChildControl(horseData._horse, "StaticText_Name")
  horseData._rate = UI.getChildControl(horseData._horse, "StaticText_Rate")
  return horseData
end
function PaGlobal_ServantSimulatorSubView:findGroupDataIndex(horseTierValue)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return nil
  end
  for key, value in pairs(self._groupList) do
    if value ~= nil and value._tierValue == horseTierValue then
      return key
    end
  end
  return nil
end
function PaGlobal_ServantSimulatorSubView:refreshHorseFrameSize()
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  if self._groupList ~= nil then
    self._groupList:quicksort(ServantSimulatorSubView_GroupSort)
  end
  local groupTitleTemp = UI.getChildControl(self._ui._stc_frameGroupTemplate, "StaticText_GroupTitle")
  local groupTitleSizeY = groupTitleTemp:GetSpanSize().y + groupTitleTemp:GetSizeY()
  local maxRowCount = math.floor(self._ui._stc_frameGroupTemplate:GetSizeX() / self._ui._stc_frameHorseTemplate:GetSizeX())
  local horseDataSizeX = self._ui._stc_frameHorseTemplate:GetSizeX()
  local horseDataSizeY = self._ui._stc_frameHorseTemplate:GetSizeY()
  local horseDataTermX = 5
  local horseDataTermY = 5
  local lastGroupSpanY = 0
  local lastGroupSizeY = 0
  for key, value in pairs(self._groupList) do
    if value ~= nil and value._group:GetShow() == true then
      local showHorseCount = 0
      local horseColIndex = 0
      local lastHorseSpanY = 0
      for horseKey, horseData in pairs(value._horseList) do
        if horseData ~= nil and horseData._horse:GetShow() == true then
          if maxRowCount <= showHorseCount then
            showHorseCount = 0
            horseColIndex = horseColIndex + 1
          end
          local spanX = showHorseCount * horseDataSizeX + horseDataTermX * (showHorseCount + 1)
          lastHorseSpanY = groupTitleSizeY + horseColIndex * horseDataSizeY + horseDataTermY * (horseColIndex + 1)
          horseData._horse:SetSpanSize(spanX, lastHorseSpanY)
          horseData._horse:ComputePos()
          showHorseCount = showHorseCount + 1
        end
      end
      lastGroupSpanY = lastGroupSpanY + lastGroupSizeY
      value._group:SetSpanSize(value._group:GetSpanSize().x, lastGroupSpanY)
      lastGroupSizeY = groupTitleSizeY + lastHorseSpanY + horseDataSizeY + horseDataTermY
      value._group:SetSize(value._group:GetSizeX(), lastGroupSizeY)
      value._group:ComputePos()
    end
  end
  self._ui._frmContent_selectList:SetSize(self._ui._frmContent_selectList:GetSizeX(), lastGroupSpanY + lastGroupSizeY)
  local frameVScroll = self._ui._frm_selectList:GetVScroll()
  frameVScroll:SetControlPos(0)
  self._ui._frm_selectList:UpdateContentPos()
  if self._ui._frm_selectList:GetSizeY() < self._ui._frmContent_selectList:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
end
function PaGlobal_ServantSimulatorSubView:setTabList(openType)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  local firstKey = 0
  for key, value in pairs(self._tabList) do
    value:SetShow(false)
  end
  if openType == PaGlobal_ServantSimulator._tabType.GROWUP or openType == PaGlobal_ServantSimulator._tabType.MATING then
    self._showTabList = {
      [1] = self._tabType.MINE,
      [2] = self._tabType.ALL
    }
  elseif openType == PaGlobal_ServantSimulator._tabType.DETAIL then
    self._showTabList = {
      [1] = self._tabType.MINE
    }
  else
    UI.ASSERT_NAME(false, "openType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\152\164\234\178\189\235\175\188")
    self._openType = nil
    self._maleType = nil
    return
  end
  local tabBg = UI.getChildControl(Panel_Dialog_ServantSimulatorSubView, "Static_RadioButtonBg")
  local tabCount = #self._showTabList
  local tabInterval = 190
  local startPanX = -(tabInterval * (tabCount - 1)) / 2
  local firstKey = self._showTabList[1]
  self._currentTabIndex = 1
  for ii = 1, #self._showTabList do
    self._tabList[self._showTabList[ii]]:SetShow(true)
    self._tabList[self._showTabList[ii]]:SetSpanSize(startPanX + tabInterval * (ii - 1), 0)
  end
  PaGlobal_ServantSimulatorSubView:changeTab(firstKey)
end
function PaGlobal_ServantSimulatorSubView:toggleHorseTypeToolTip(isShow, groupDataIndex, horseControlIndex, maleType, horseIndex, isOnlyMyHorse)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  if isShow == true then
    local groupData = self._groupList[groupDataIndex]
    if groupData == nil then
      return
    end
    local horseControl = groupData._horseList[horseControlIndex]
    if horseControl == nil then
      return
    end
    local dataWrapper
    if self._openType == PaGlobal_ServantSimulator._tabType.GROWUP then
      if isOnlyMyHorse == true then
        dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(horseIndex)
      else
        dataWrapper = ToClient_GetHorseSimulateGrowUpAllSelectInfoByIndex(horseIndex)
      end
    elseif self._openType == PaGlobal_ServantSimulator._tabType.MATING then
      if isOnlyMyHorse == true then
        dataWrapper = ToClient_GetHorseSimulateMatingMyHorseSelectInfoByIndex(self._maleType, horseIndex)
      else
        dataWrapper = ToClient_GetHorseSimulateMatingAllSelectInfoByIndex(self._maleType, horseIndex)
      end
    elseif self._openType == PaGlobal_ServantSimulator._tabType.DETAIL then
      if isOnlyMyHorse == true then
        dataWrapper = ToClient_GetHorseSimulateDetailInformationMyHorseInfoByIndex(horseIndex)
      end
    else
      UI.ASSERT_NAME(false, "openType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\152\164\234\178\189\235\175\188")
      return
    end
    if dataWrapper == nil then
      return
    end
    local horseTypeTooltip = dataWrapper:getHorseTitleNameForLua()
    if ToClient_IsDevelopment() == true then
      horseTypeTooltip = horseTypeTooltip .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
    end
    TooltipSimple_Show(horseControl._horse, "", horseTypeTooltip)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_ServantSimulatorSubView:changeTabConsole(isRB)
  if Panel_Dialog_ServantSimulatorSubView == nil then
    return
  end
  local tabIndex = self._currentTabIndex
  if isRB == true then
    tabIndex = self._currentTabIndex + 1
  else
    tabIndex = self._currentTabIndex - 1
  end
  local tabCount = #self._showTabList
  if tabIndex < 1 then
    tabIndex = tabCount
  elseif tabCount < tabIndex then
    tabIndex = 1
  end
  self._currentTabIndex = tabIndex
  local tabType = self._showTabList[tabIndex]
  if self._tabList[tabType] == nil then
    return
  end
  if self._tabList[tabType]:GetShow() == false then
    return
  end
  PaGlobal_ServantSimulatorSubView:changeTab(tabType)
end
function PaGlobal_ServantSimulatorSubView:changeHorseImage(iconUI, dataWrapper)
  if iconUI == nil or dataWrapper == nil then
    return
  end
  local isDefaultForm = true
  if dataWrapper:isMyHorse() == true then
    local servantNo = dataWrapper:getServantNo()
    local servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
    if servantWrapper == nil then
      servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
    end
    if servantWrapper ~= nil then
      local currentServantFormIndexRaw = servantWrapper:getFormIndexRaw()
      local formManager = getServantFormManager()
      if formManager ~= nil then
        local currentDefaultFormIndexRaw = servantWrapper:getDefaultFormIndexRaw()
        if currentServantFormIndexRaw ~= currentDefaultFormIndexRaw and currentServantFormIndexRaw ~= 0 then
          local changableFormSSW = formManager:getFormByFormIndexRaw(currentServantFormIndexRaw)
          if changableFormSSW ~= nil then
            isDefaultForm = false
            iconUI:ChangeTextureInfoNameAsync(changableFormSSW:getIcon1())
          end
        end
      end
    end
  end
  if isDefaultForm == true then
    iconUI:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
  end
  iconUI:setRenderTexture(iconUI:getBaseTexture())
end
