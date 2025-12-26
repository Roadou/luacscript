function PaGlobal_StartBranch_All:initialize()
  if true == PaGlobal_StartBranch_All._initialize then
    return
  end
  local BottomBtnGroup = UI.getChildControl(Panel_Window_StartBranch, "Static_QuestBranchBottomGroup")
  PaGlobal_StartBranch_All._ui._btn_SelectBranch = UI.getChildControl(BottomBtnGroup, "Button_SelectBranch")
  PaGlobal_StartBranch_All._ui._btn_Cancel = UI.getChildControl(BottomBtnGroup, "Button_Cancel")
  PaGlobal_StartBranch_All._ui._stc_blockBg = UI.getChildControl(Panel_Window_StartBranch, "StaticText_BlackBG")
  PaGlobal_StartBranch_All._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_StartBranch_All._ui_console._btn_SelectBranch = UI.getChildControl(BottomBtnGroup, "StaticText_SelectBranch_ConsoleUI")
  PaGlobal_StartBranch_All._ui_console._btn_Cancel = UI.getChildControl(BottomBtnGroup, "StaticText_Cancel_ConsoleUI")
  PaGlobal_StartBranch_All._ui_console._stc_LB = UI.getChildControl(BottomBtnGroup, "Static_LB")
  PaGlobal_StartBranch_All._ui_console._stc_RB = UI.getChildControl(BottomBtnGroup, "Static_RB")
  local radioBtnGroup = UI.getChildControl(Panel_Window_StartBranch, "Static_QuestBranchMiddleGroup")
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    PaGlobal_StartBranch_All._ui._btn_Radio[i] = UI.getChildControl(radioBtnGroup, "Radiobutton_Branch_" .. tostring(i))
    self._branchListInfo[i + 1] = {}
    self._branchListInfo[i + 1].control = PaGlobal_StartBranch_All._ui._btn_Radio[i]
    self._branchListInfo[i + 1].contentOption = nil
    if i == 1 then
      self._branchListInfo[i + 1].contentOption = _ContentsGroup_MountainOfEternalWinter
    elseif i == 2 then
      self._branchListInfo[i + 1].contentOption = _ContentsGroup_MorningLand
    end
    self._ui_console._stc_update[i] = UI.getChildControl(self._ui._btn_Radio[i], "StaticText_UpdateTag")
    self._ui_console._stc_point[i] = UI.getChildControl(self._ui._btn_Radio[i], "Static_PointDeco")
  end
  if false == self._isConsole then
    PaGlobal_StartBranch_All._ui._btn_SelectBranch:SetShow(true)
    PaGlobal_StartBranch_All._ui._btn_Cancel:SetShow(true)
    PaGlobal_StartBranch_All._ui_console._btn_SelectBranch:SetShow(false)
    PaGlobal_StartBranch_All._ui_console._btn_Cancel:SetShow(false)
    PaGlobal_StartBranch_All._ui_console._stc_LB:SetShow(false)
    PaGlobal_StartBranch_All._ui_console._stc_RB:SetShow(false)
  else
    PaGlobal_StartBranch_All._ui._btn_SelectBranch:SetShow(false)
    PaGlobal_StartBranch_All._ui._btn_Cancel:SetShow(false)
    PaGlobal_StartBranch_All._ui_console._btn_SelectBranch:SetShow(true)
    PaGlobal_StartBranch_All._ui_console._btn_Cancel:SetShow(true)
    PaGlobal_StartBranch_All._ui_console._stc_LB:SetShow(true)
    PaGlobal_StartBranch_All._ui_console._stc_RB:SetShow(true)
    self._ui_console._stc_update[0]:SetShow(false)
    self._ui_console._stc_update[1]:SetShow(true)
    self._ui_console._stc_update[2]:SetShow(false)
    self._ui_console._stc_point[0]:SetShow(false)
    self._ui_console._stc_point[1]:SetShow(true)
    self._ui_console._stc_point[2]:SetShow(false)
  end
  PaGlobal_StartBranch_All._originalSelectButton_PC_spanX = PaGlobal_StartBranch_All._ui._btn_SelectBranch:GetSpanSize().x
  PaGlobal_StartBranch_All._originalSelectButton_Console_spanX = PaGlobal_StartBranch_All._ui_console._btn_SelectBranch:GetSpanSize().x
  PaGlobal_StartBranch_All:registEventHandler()
  PaGlobal_StartBranch_All:validate()
  PaGlobal_StartBranch_All._initialize = true
end
function PaGlobal_StartBranch_All:registEventHandler()
  if nil == Panel_Window_StartBranch then
    return
  end
  registerEvent("onScreenResize", "FromClient_StartBranch_All_OnScreenResize")
  if false == self._isConsole then
    PaGlobal_StartBranch_All._ui._btn_SelectBranch:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_Select()")
    PaGlobal_StartBranch_All._ui._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_Cancel()")
    for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
      self._branchListInfo[i + 1].control:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_SelectRadioButton(" .. i .. ")")
    end
  else
    Panel_Window_StartBranch:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_StartBranch_PadControl(false)")
    Panel_Window_StartBranch:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_StartBranch_PadControl(true)")
    Panel_Window_StartBranch:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_StartBranch_All_Select()")
  end
end
function PaGlobal_StartBranch_All:prepareOpen(isOpenedInGame)
  if nil == Panel_Window_StartBranch then
    return
  end
  self:recalcBottomButtonUI(isOpenedInGame)
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    self._branchListInfo[i + 1].control:EraseAllEffect()
    if 0 == i then
      self._branchListInfo[i + 1].control:AddEffect("fUI_CharacterBirth_0", true, 0, 0)
      self._branchListInfo[i + 1].control:SetCheck(true)
    else
      self._branchListInfo[i + 1].control:SetCheck(false)
    end
  end
  self._selectTab = 0
  FromClient_StartBranch_All_OnScreenResize()
  PaGlobal_StartBranch_All:open()
end
function PaGlobal_StartBranch_All:recalcBottomButtonUI(isOpenedInGame)
  if Panel_Window_StartBranch == nil then
    return
  end
  local openCount = 0
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    if self._branchListInfo[i + 1].contentOption ~= nil and self._branchListInfo[i + 1].contentOption == false then
    else
      openCount = openCount + 1
    end
  end
  local radioBtnGroup = UI.getChildControl(Panel_Window_StartBranch, "Static_QuestBranchMiddleGroup")
  local openIndex = 0
  local middlePosX = math.floor(radioBtnGroup:GetSizeX() / 2)
  local gap = self._branchListInfo[1].control:GetSizeX() + 10
  local startPos = middlePosX - (gap * math.floor(openCount / 2) + openCount % 2 * math.floor(gap / 2))
  if false == self._branchListInfo[2].contentOption and true == self._branchListInfo[3].contentOption then
    self._branchListInfo[1].control:SetPosX(middlePosX - (self._branchListInfo[1].control:GetSizeX() + self._branchListInfo[2].control:GetSizeX() + 10) / 2)
    self._branchListInfo[2].control:SetShow(false)
    self._branchListInfo[3].control:SetPosX(self._branchListInfo[1].control:GetPosX() + self._branchListInfo[1].control:GetSizeX() + 10)
  end
  if true == self._branchListInfo[2].contentOption and false == self._branchListInfo[3].contentOption then
    self._branchListInfo[1].control:SetPosX(middlePosX - (self._branchListInfo[1].control:GetSizeX() + self._branchListInfo[2].control:GetSizeX() + 10) / 2)
    self._branchListInfo[2].control:SetPosX(self._branchListInfo[1].control:GetPosX() + self._branchListInfo[1].control:GetSizeX() + 10)
    self._branchListInfo[3].control:SetShow(false)
  end
  if isOpenedInGame ~= nil and isOpenedInGame == true and _ContentsGroup_NewSequenceTutorial == true then
    if self._isConsole == true then
      self._ui_console._btn_Cancel:SetShow(false)
      self._ui_console._btn_SelectBranch:SetSpanSize(-(self._ui_console._btn_SelectBranch:GetSizeX() + self._ui_console._btn_SelectBranch:GetTextSizeX()) / 2, self._ui_console._btn_SelectBranch:GetSpanSize().y)
    else
      self._ui._btn_Cancel:SetShow(false)
      self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "")
      self._ui._btn_SelectBranch:SetSpanSize(0, self._ui._btn_SelectBranch:GetSpanSize().y)
    end
  elseif self._isConsole == true then
    self._ui_console._btn_Cancel:SetShow(true)
    self._ui_console._btn_SelectBranch:SetSpanSize(self._originalSelectButton_Console_spanX, self._ui_console._btn_SelectBranch:GetSpanSize().y)
  else
    self._ui._btn_Cancel:SetShow(true)
    self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_Cancel()")
    self._ui._btn_SelectBranch:SetSpanSize(self._originalSelectButton_PC_spanX, self._ui._btn_SelectBranch:GetSpanSize().y)
  end
  local keyGuideList = {
    self._ui_console._btn_SelectBranch,
    self._ui_console._btn_Cancel
  }
  local parentControl = UI.getChildControl(Panel_Window_StartBranch, "Static_QuestBranchBottomGroup")
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, parentControl, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_CENTER)
end
function PaGlobal_StartBranch_All:open()
  if nil == Panel_Window_StartBranch then
    return
  end
  Panel_Window_StartBranch:SetShow(true)
end
function PaGlobal_StartBranch_All:prepareClose()
  if nil == Panel_Window_StartBranch then
    return
  end
  PaGlobal_StartBranch_All:close()
end
function PaGlobal_StartBranch_All:close()
  if nil == Panel_Window_StartBranch then
    return
  end
  Panel_Window_StartBranch:SetShow(false)
end
function PaGlobal_StartBranch_All:validate()
  if nil == Panel_Window_StartBranch then
    return
  end
  PaGlobal_StartBranch_All._ui._btn_SelectBranch:isValidate()
  PaGlobal_StartBranch_All._ui._btn_Cancel:isValidate()
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    self._branchListInfo[i + 1].control:isValidate()
  end
  PaGlobal_StartBranch_All._ui_console._btn_SelectBranch:isValidate()
  PaGlobal_StartBranch_All._ui_console._btn_Cancel:isValidate()
  PaGlobal_StartBranch_All._ui_console._stc_LB:isValidate()
  PaGlobal_StartBranch_All._ui_console._stc_RB:isValidate()
end
function PaGlobal_StartBranch_All:SelectBranch()
  if nil == Panel_Window_StartBranch then
    return
  end
  local tutorialBranch = __eQuestTutorialBranch_0
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    if nil ~= self._branchListInfo[i + 1].control and self._branchListInfo[i + 1].control:IsChecked() == true then
      tutorialBranch = i
      break
    end
  end
  if false == self._isConsole then
    Panel_CharacterCreateOK_Confirm(tutorialBranch)
  else
    PaGlobalFunc_Customization_InputName_SelectStartBranch(tutorialBranch)
  end
end
function PaGlobal_StartBranch_All:SelectRadioButton(idx)
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    if nil ~= self._branchListInfo[i + 1].control then
      self._branchListInfo[i + 1].control:EraseAllEffect()
      self._branchListInfo[i + 1].control:SetCheck(false)
    end
  end
  local static = self._branchListInfo[idx + 1].control
  if nil == static then
    return
  end
  static:SetCheck(true)
  local effectName = "fUI_CharacterBirth_" .. tostring(idx)
  if 0 == idx then
    audioPostEvent_SystemUi(29, 1)
    _AudioPostEvent_SystemUiForXBOX(29, 1)
  elseif 1 == idx then
    audioPostEvent_SystemUi(29, 2)
    _AudioPostEvent_SystemUiForXBOX(29, 2)
  elseif 2 == idx then
    audioPostEvent_SystemUi(29, 3)
    _AudioPostEvent_SystemUiForXBOX(29, 3)
  end
  static:AddEffect(effectName, true, 0, 0)
end
