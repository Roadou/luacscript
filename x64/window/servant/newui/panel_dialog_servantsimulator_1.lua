function PaGlobal_ServantSimulator:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_titleBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_TitleArea")
  self._ui._btn_stickerUI = UI.getChildControl(self._ui._stc_titleBg, "CheckButton_PopUp")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._stc_mainBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_MainBG")
  self._ui._stc_tabBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_RadioButtonBg")
  self._ui._stc_detailBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_DetailInfo")
  self._ui._btn_growUp = UI.getChildControl(self._ui._stc_tabBg, "RadioButton_GrowUp")
  self._ui._btn_mating = UI.getChildControl(self._ui._stc_tabBg, "RadioButton_Mating")
  self._ui._btn_detail = UI.getChildControl(self._ui._stc_tabBg, "RadioButton_DetailInfo")
  self._ui._stc_selectLine = UI.getChildControl(self._ui._stc_tabBg, "Static_SelectBar")
  self._ui._btn_stickerUI:SetShow(_ContentsGroup_PopUp)
  self._ui._btn_close:SetShow(self._isConsole == false)
  self:initGrowUpControl()
  self:initMatingControl()
  self:initDetailControl()
  self:initConsoleKeyGuide()
  self:registEventHandler()
  self:validate()
  self:changeTab(self._tabType.GROWUP)
  self:clearGrowUpSelectInfo()
  self:clearMatingSelectInfo(__eHorseSimulateHorseMaleType_Male)
  self:clearMatingSelectInfo(__eHorseSimulateHorseMaleType_Female)
  self:clearDetailSelectInfo()
  if self._isConsole == true then
    Panel_Dialog_ServantSimulator:ignorePadSnapMoveToOtherPanel()
  end
  self._initialize = true
end
function PaGlobal_ServantSimulator:initConsoleKeyGuide()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._stc_keyGuideBg = UI.getChildControl(Panel_Dialog_ServantSimulator, "Static_KeyGuideBg")
  self._ui._stc_keyGuideLB = UI.getChildControl(self._ui._stc_tabBg, "Static_LB_ConsoleUI")
  self._ui._stc_keyGuideRB = UI.getChildControl(self._ui._stc_tabBg, "Static_RB_ConsoleUI")
  self._ui._stc_keyGuideBg:SetShow(self._isConsole)
  self._ui._stc_keyGuideLB:SetShow(self._isConsole)
  self._ui._stc_keyGuideRB:SetShow(self._isConsole)
end
function PaGlobal_ServantSimulator:registEventHandler()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._isConsole == true then
    Panel_Dialog_ServantSimulator:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_ServantSimulator:changeTabConsole( false )")
    Panel_Dialog_ServantSimulator:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_ServantSimulator:changeTabConsole( true )")
    Panel_Dialog_ServantSimulator:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ServantSimulator_ClearMatingEditText()")
    Panel_Dialog_ServantSimulator:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
    Panel_Dialog_ServantSimulator:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_ServantSimulator_ToggleSubView(" .. tostring(__eHorseSimulateHorseMaleType_Male) .. ")")
    Panel_Dialog_ServantSimulator:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "HandleEventLUp_ServantSimulator_ToggleSubView(" .. tostring(__eHorseSimulateHorseMaleType_Female) .. ")")
  end
  self._ui._btn_stickerUI:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_PopUpUI()")
  self._ui._btn_stickerUI:addInputEvent("Mouse_On", "HandleEventLOnOut_ServantSimulator_PopUpUI(true)")
  self._ui._btn_stickerUI:addInputEvent("Mouse_Out", "HandleEventLOnOut_ServantSimulator_PopUpUI(false)")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSimulator_Close()")
  self._ui._btn_growUp:addInputEvent("Mouse_LUp", "PaGlobal_ServantSimulator:changeTab(" .. tostring(self._tabType.GROWUP) .. ")")
  self._ui._btn_mating:addInputEvent("Mouse_LUp", "PaGlobal_ServantSimulator:changeTab(" .. tostring(self._tabType.MATING) .. ")")
  self._ui._btn_detail:addInputEvent("Mouse_LUp", "PaGlobal_ServantSimulator:changeTab(" .. tostring(self._tabType.DETAIL) .. ")")
  registerEvent("FromClient_OpenServantSimulatorDetailInformation", "FromClient_OpenServantSimulatorDetailInformation")
  self:registEventHandler_GrowUp()
  self:registEventHandler_Mating()
  self:registEventHandler_Detail()
end
function PaGlobal_ServantSimulator:validate()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._stc_titleBg:isValidate()
  self._ui._btn_stickerUI:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_tabBg:isValidate()
  self._ui._stc_detailBg:isValidate()
  self._ui._btn_growUp:isValidate()
  self._ui._btn_mating:isValidate()
  self._ui._btn_detail:isValidate()
  self._ui._stc_selectLine:isValidate()
  self:validate_GrowUp()
  self:validate_Mating()
  self:validate_Detail()
end
function PaGlobal_ServantSimulator:prepareOpen(openTabList, fromServantNo, selectedLevel)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if openTabList == nil then
    return
  end
  self:clearGrowUpSelectInfo()
  self:clearMatingSelectInfo(__eHorseSimulateHorseMaleType_Male)
  self:clearMatingSelectInfo(__eHorseSimulateHorseMaleType_Female)
  self:clearDetailSelectInfo()
  self._openTabList = openTabList
  local openTabCount = #openTabList
  if openTabCount == 0 then
    return
  end
  self._ui._btn_growUp:SetShow(false)
  self._ui._btn_mating:SetShow(false)
  self._ui._btn_detail:SetShow(false)
  local sceneIdx = PaGlobalFunc_ServantList_All_GetSceneIndex()
  if nil ~= sceneIdx then
    PaGlobalFunc_ServantFunction_All_Servant_ScenePopObject(sceneIdx)
  end
  for ii = 1, openTabCount do
    local tabType = openTabList[ii]
    if tabType == self._tabType.GROWUP then
      self._ui._btn_growUp:SetShow(true)
    elseif tabType == self._tabType.MATING then
      self._ui._btn_mating:SetShow(true)
    elseif tabType == self._tabType.DETAIL then
      if fromServantNo ~= nil then
        self._detailSelectInfo._servantNo = fromServantNo
      end
      self._ui._btn_detail:SetShow(true)
    else
      UI.ASSERT_NAME(false, "tabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\152\164\234\178\189\235\175\188")
      return
    end
    if ii == 1 then
      self:changeTab(tabType)
      self._tabIndex = ii
    end
  end
  ToClient_InitializeHorseSimulateManager()
  TooltipSimple_Hide()
  if fromServantNo ~= nil then
    local dataCount = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoCount()
    for ii = 1, dataCount do
      local dataWrapper = ToClient_GetHorseSimulateGrowUpMyHorseSelectInfoByIndex(ii - 1)
      if dataWrapper == nil then
        return
      end
      if dataWrapper:getServantNo() == self._detailSelectInfo._servantNo then
        self:updateRightBg_GrowUpSelectInfo(ii - 1, true, selectedLevel)
      end
    end
    dataCount = ToClient_GetHorseSimulateDetailInformationMyHorseInfoCount()
    for ii = 1, dataCount do
      local dataWrapper = ToClient_GetHorseSimulateDetailInformationMyHorseInfoByIndex(ii - 1)
      if dataWrapper == nil then
        return
      end
      if dataWrapper:getServantNo() == fromServantNo then
        self:requestHorseDetailInformation(ii - 1)
      end
    end
  else
    self:updateResult(self._currentTabType, nil, nil, nil)
  end
  self:open()
end
function PaGlobal_ServantSimulator:open()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  Panel_Dialog_ServantSimulator:SetShow(true)
end
function PaGlobal_ServantSimulator:prepareClose()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if PaGlobalFunc_ServantSimulatorSubView_IsShow() == true then
    PaGlobalFunc_ServantSimulatorSubView_Close()
  end
  if self._ui._growUp._cbx_horseLevel:GetListControl():GetShow() == true then
    self._ui._growUp._cbx_horseLevel:ToggleListbox()
    if self._isConsole == true then
      return
    end
  end
  if self._ui._growUp._cbx_lifeLevel:GetListControl():GetShow() == true then
    self._ui._growUp._cbx_lifeLevel:ToggleListbox()
    if self._isConsole == true then
      return
    end
  end
  if self._ui._mating._cbx_horseLevelMale:GetListControl():GetShow() == true then
    self._ui._mating._cbx_horseLevelMale:ToggleListbox()
    if self._isConsole == true then
      return
    end
  end
  if self._ui._mating._cbx_horseLevelFemale:GetListControl():GetShow() == true then
    self._ui._mating._cbx_horseLevelFemale:ToggleListbox()
    if self._isConsole == true then
      return
    end
  end
  Panel_Dialog_ServantSimulator:CloseUISubApp()
  self._ui._btn_stickerUI:SetCheck(false)
  self:clearDetailSelectInfo()
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_ServantSimulator:close()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  Panel_Dialog_ServantSimulator:SetShow(false)
end
function PaGlobal_ServantSimulator:changeTab(tabType)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._currentTabType == tabType then
    return
  end
  Panel_NumberPad_Close()
  TooltipSimple_Hide()
  local stc_keyGuide_Y, stc_keyGuide_LTY, stc_keyGuide_RTY, stc_keyGuide_A, stc_keyGuide_B, keyGuideList
  if self._isConsole == true then
    stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_X")
    stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Y")
    stc_keyGuide_LTY = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_LTY")
    stc_keyGuide_RTY = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_RTY")
    stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A")
    stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B")
    keyGuideList = Array.new()
    stc_keyGuide_X:SetShow(false)
    stc_keyGuide_Y:SetShow(false)
    stc_keyGuide_LTY:SetShow(false)
    stc_keyGuide_RTY:SetShow(false)
    stc_keyGuide_A:SetShow(false)
    stc_keyGuide_B:SetShow(false)
  end
  if tabType == self._tabType.GROWUP then
    self._ui._stc_selectLine:SetSpanSize(self._ui._btn_growUp:GetSpanSize().x, self._ui._stc_selectLine:GetSpanSize().y)
    self._ui._btn_growUp:SetCheck(true)
    self._ui._btn_mating:SetCheck(false)
    self._ui._btn_detail:SetCheck(false)
    self._ui._growUp._stc_growUpBg:SetShow(true)
    self._ui._mating._stc_matingBg:SetShow(false)
    self._ui._stc_detailBg:SetShow(false)
    if self._isConsole == true then
      keyGuideList:push_back(stc_keyGuide_Y)
      keyGuideList:push_back(stc_keyGuide_A)
      keyGuideList:push_back(stc_keyGuide_B)
    end
  elseif tabType == self._tabType.MATING then
    self._ui._stc_selectLine:SetSpanSize(self._ui._btn_mating:GetSpanSize().x, self._ui._stc_selectLine:GetSpanSize().y)
    self._ui._btn_growUp:SetCheck(false)
    self._ui._btn_mating:SetCheck(true)
    self._ui._btn_detail:SetCheck(false)
    self._ui._growUp._stc_growUpBg:SetShow(false)
    self._ui._mating._stc_matingBg:SetShow(true)
    self._ui._stc_detailBg:SetShow(false)
    if self._isConsole == true then
      keyGuideList:push_back(stc_keyGuide_LTY)
      keyGuideList:push_back(stc_keyGuide_RTY)
      keyGuideList:push_back(stc_keyGuide_X)
      keyGuideList:push_back(stc_keyGuide_A)
      keyGuideList:push_back(stc_keyGuide_B)
    end
  elseif tabType == self._tabType.DETAIL then
    self._ui._stc_selectLine:SetSpanSize(self._ui._btn_detail:GetSpanSize().x, self._ui._stc_selectLine:GetSpanSize().y)
    self._ui._btn_growUp:SetCheck(false)
    self._ui._btn_mating:SetCheck(false)
    self._ui._btn_detail:SetCheck(true)
    self._ui._growUp._stc_growUpBg:SetShow(false)
    self._ui._mating._stc_matingBg:SetShow(false)
    self._ui._stc_detailBg:SetShow(true)
    if self._isConsole == true then
      keyGuideList:push_back(stc_keyGuide_Y)
      keyGuideList:push_back(stc_keyGuide_A)
      keyGuideList:push_back(stc_keyGuide_B)
    end
  else
    return
  end
  if self._isConsole == true then
    for key, control in pairs(keyGuideList) do
      if control ~= nil then
        control:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  end
  self._currentTabType = tabType
end
function PaGlobal_ServantSimulator:changeTabConsole(isRB)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._currentTabType == tabType then
    return
  end
  if isRB == true then
    self._tabIndex = self._tabIndex + 1
    if self._tabIndex > #self._openTabList then
      self._tabIndex = 1
    end
  else
    self._tabIndex = self._tabIndex - 1
    if self._tabIndex < 1 then
      self._tabIndex = #self._openTabList
    end
  end
  local changeTabType = self._openTabList[self._tabIndex]
  PaGlobal_ServantSimulator:changeTab(changeTabType)
end
function PaGlobal_ServantSimulator:updateResult(tabType, isOnlyMyHorse, maleType, index)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if tabType == self._tabType.GROWUP then
    if self:updateRightBg_GrowUpSelectInfo(index, isOnlyMyHorse, nil) == false then
    end
  elseif tabType == self._tabType.MATING then
    if self:updateRightBg_MatingSelectInfo(index, isOnlyMyHorse, maleType) == false then
    end
  elseif tabType == self._tabType.DETAIL then
    self:requestHorseDetailInformation(index)
    return
  else
    UI.ASSERT_NAME(false, "tabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_ServantSimulator:changeCloseButtonInputEvent(isDialogMode)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._isConsole == true then
    return
  end
  if isDialogMode == true then
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantFunction_All_Close()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantSimulator_Close()")
  end
end
