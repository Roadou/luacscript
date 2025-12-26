function PaGlobalFunc_StartBranch_All_CreateOpen()
  if nil == Panel_Window_StartBranch then
    return
  end
  if false == PaGlobal_StartBranch_All._isConsole then
    PaGlobal_StartBranch_All._ui._btn_SelectBranch:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_Select()")
  else
    Panel_Window_StartBranch:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_StartBranch_All_Select()")
  end
  PaGlobal_StartBranch_All:prepareOpen(false)
end
function PaGlobalFunc_StartBranch_All_SelectOpen(charIdx)
  if nil == Panel_Window_StartBranch then
    return
  end
  if false == _ContentsGroup_NewSequenceTutorial then
    return
  end
  if false == PaGlobal_StartBranch_All._isConsole then
    PaGlobal_StartBranch_All._ui._btn_SelectBranch:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_SelectBySkipTutorial(" .. charIdx .. ")")
  else
    Panel_Window_StartBranch:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_StartBranch_All_SelectBySkipTutorial(" .. charIdx .. ")")
  end
  PaGlobal_StartBranch_All:prepareOpen(false)
end
function PaGlobalFunc_StartBranch_All_TutorialCompleteOpen()
  if nil == Panel_Window_StartBranch then
    return
  end
  if false == PaGlobal_StartBranch_All._isConsole then
    PaGlobal_StartBranch_All._ui._btn_SelectBranch:addInputEvent("Mouse_LUp", "HandleEventLUp_StartBranch_All_SelectByEndTutorial()")
  else
    Panel_Window_StartBranch:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_StartBranch_All_SelectByEndTutorial()")
  end
  PaGlobal_StartBranch_All:prepareOpen(true)
end
function HandleEventLUp_StartBranch_All_Select()
  if nil == Panel_Window_StartBranch then
    return
  end
  PaGlobal_StartBranch_All:SelectBranch()
end
function HandleEventLUp_StartBranch_All_SelectBySkipTutorial(charIdx)
  if nil == Panel_Window_StartBranch then
    return
  end
  if false == _ContentsGroup_NewSequenceTutorial then
    return
  end
  if nil == charIdx then
    return
  end
  local tutorialBranch = __eQuestTutorialBranch_0
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    if nil ~= PaGlobal_StartBranch_All._branchListInfo[i + 1].control and PaGlobal_StartBranch_All._branchListInfo[i + 1].control:IsChecked() == true then
      tutorialBranch = i
      break
    end
  end
  ToClient_NewSequenceTutorialSkipChangeStartPosition(true, tutorialBranch, charIdx)
  PaGlobal_StartBranch_All:prepareClose()
end
function HandleEventLUp_StartBranch_All_SelectByEndTutorial()
  if nil == Panel_Window_StartBranch then
    return
  end
  if false == _ContentsGroup_NewSequenceTutorial then
    return
  end
  local tutorialBranch = __eQuestTutorialBranch_0
  for i = 0, PaGlobal_StartBranch_All._MAX_RADIO_COUNT - 1 do
    if nil ~= PaGlobal_StartBranch_All._branchListInfo[i + 1].control and PaGlobal_StartBranch_All._branchListInfo[i + 1].control:IsChecked() == true then
      tutorialBranch = i
      break
    end
  end
  if PaGlobal_GameoptionTutorial_All_RevertGraphic ~= nil then
    PaGlobal_GameoptionTutorial_All_RevertGraphic()
  end
  ToClient_NewSequenceEndTutorialTeleport(tutorialBranch)
end
function HandleEventLUp_StartBranch_All_Cancel()
  if nil == Panel_Window_StartBranch then
    return
  end
  PaGlobal_StartBranch_All:prepareClose()
end
function HandleEventLUp_StartBranch_All_SelectRadioButton(idx)
  PaGlobal_StartBranch_All:SelectRadioButton(idx)
end
function FromClient_StartBranch_All_OnScreenResize()
  if nil == Panel_Window_StartBranch then
    return
  end
  Panel_Window_StartBranch:ComputePos()
  PaGlobal_StartBranch_All._ui._stc_blockBg:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  PaGlobal_StartBranch_All._ui._stc_blockBg:SetHorizonCenter()
  PaGlobal_StartBranch_All._ui._stc_blockBg:SetVerticalMiddle()
end
function PaGloabl_StartBranch_All_ShowAni()
  if nil == Panel_Window_StartBranch then
    return
  end
end
function PaGloabl_StartBranch_All_HideAni()
  if nil == Panel_Window_StartBranch then
    return
  end
end
function PaGlobalFunc_StartBranch_PadControl(isRight)
  if nil == Panel_Window_StartBranch then
    return
  end
  local index = PaGlobal_StartBranch_All._selectTab
  function findRadioIndex(index, isRight)
    local findIndex = -1
    if isRight then
      index = (index + 2) % PaGlobal_StartBranch_All._MAX_RADIO_COUNT
    else
      index = (index + 1) % PaGlobal_StartBranch_All._MAX_RADIO_COUNT
    end
    if index < 0 or index >= PaGlobal_StartBranch_All._MAX_RADIO_COUNT then
      return -1
    end
    if PaGlobal_StartBranch_All._branchListInfo[index + 1].contentOption == nil or PaGlobal_StartBranch_All._branchListInfo[index + 1].contentOption then
      return index
    else
      findIndex = findRadioIndex(index, isRight)
    end
    return findIndex
  end
  local findIndex = findRadioIndex(index, isRight)
  if findIndex == -1 then
    return
  end
  PaGlobal_StartBranch_All._selectTab = findIndex
  PaGlobal_StartBranch_All:SelectRadioButton(findIndex)
end
