function HandleEventLUp_WorkerRandomSelectOption_All_Close()
  if nil == Panel_Window_WorkerRandomSelectOption_All or false == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  PaGlobal_WorkerRandomSelectOption_All:gradePanelSetShow(false)
  Panel_NumberPad_Close()
  PaGlobal_WorkerRandomSelectOption_All:prepareClose()
end
function HandleEventLUp_WorkerRandomSelectOption_All_CloseForConsole()
  if false == PaGlobal_WorkerRandomSelectOption_All._isConsole or false == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  if true == Panel_Window_WorkerRandomSelectOption_Grade_All:GetShow() then
    Panel_Window_WorkerRandomSelectOption_Grade_All:SetShow(false)
    return
  end
  PaGlobalFunc_WorkerRandomSelect_All_TempClose(true)
  HandleEventLUp_WorkerRandomSelectOption_All_Close()
end
function HandleEventLUp_WorkerRandomSelectOption_All_Open()
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  if PaGlobalFunc_WorkerRandomSelect_All_CheckCanHireWorker ~= nil and PaGlobalFunc_WorkerRandomSelect_All_CheckCanHireWorker() == false then
    return
  end
  local wp = getSelfPlayer():getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  if wp < 5 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WORKERRANDOMSELECT_SHORTAGE_WP_ACK"))
    return
  end
  if PaGlobal_WorkerRandomSelect_All ~= nil and (PaGlobal_WorkerRandomSelect_All._isCurrectWorkerCondition == false or PaGlobal_WorkerRandomSelect_All._isContinueSelectWorkerStart == true) then
    PaGlobal_WorkerRandomSelect_All:clearData()
    return
  end
  if true == PaGlobal_WorkerRandomSelectOption_All._isConsole then
    if _ContentsGroup_WorkerImprovement == true and PaGlobal_WorkerRandomSelect_All ~= nil and PaGlobal_WorkerRandomSelect_All._selectedRegionKeyRaw == nil then
      return
    end
    PaGlobalFunc_WorkerRandomSelect_All_TempClose(false)
  end
  PaGlobal_WorkerRandomSelectOption_All:prepareOpen()
end
function FromClient_WorkerRandomSelectOption_OnScreenResize()
  if nil == Panel_Window_WorkerRandomSelectOption_All or false == Panel_Window_WorkerRandomSelectOption_All:GetShow() then
    return
  end
  PaGlobal_WorkerRandomSelectOption_All:onScreenResize()
end
function HandleEventLUp_WorkerRandomSelectOption_All_ContinueSelectStart()
  if nil == Panel_Window_WorkerRandomSelect_All or true == Panel_Window_WorkerRandomSelectOption_Grade_All:GetShow() or true == Panel_NumberPad_IsPopUp() then
    return
  end
  if nil ~= PaGlobal_WorkerRandomSelectOption_All._config and nil ~= PaGlobalFunc_WorkerRandomSelect_All_SetConfig then
    local config = PaGlobal_WorkerRandomSelectOption_All._config
    if true == PaGlobal_WorkerRandomSelectOption_All._isConsole then
      PaGlobalFunc_WorkerRandomSelect_All_TempClose(true)
    end
    PaGlobalFunc_WorkerRandomSelect_All_SetConfig(config._workerGrade, config._repetitionCount)
    PaGlobal_WorkerRandomSelectOption_All:prepareClose()
  end
end
function HandleEventLUp_WorkerRandomSelectOption_All_SelectCountOpen()
  if nil == getSelfPlayer() or true == Panel_NumberPad_IsPopUp() then
    return
  end
  local wp = getSelfPlayer():getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local maxCountForSelection = toInt64(wp) / toInt64(5)
  ToClient_padSnapResetControl()
  ToClient_padSnapSetTargetPanel(Panel_Window_NumberPad_All)
  Panel_NumberPad_Show_MaxCount(true, maxCountForSelection, nil, HandleEventLUp_WorkerRandomSelectOption_All_SelectCountConfirm)
  if true == PaGlobal_WorkerRandomSelectOption_All._isConsole then
    Panel_Window_NumberPad_All:SetPosX(Panel_Window_WorkerRandomSelectOption_All:GetSizeX() + Panel_Window_WorkerRandomSelectOption_All:GetPosX() + 10)
    Panel_Window_NumberPad_All:SetPosY(Panel_Window_WorkerRandomSelectOption_All:GetPosY())
  end
end
function HandleEventLUp_WorkerRandomSelectOption_All_SelectCountConfirm(inputNumber64)
  if nil == inputNumber64 or nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  local count32 = Int64toInt32(inputNumber64)
  PaGlobal_WorkerRandomSelectOption_All._config._repetitionCount = count32
  PaGlobal_WorkerRandomSelectOption_All:update()
end
function HandleEventLUp_WorkerRandomSelectOption_All_SelectGradeConfirm(idx)
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  if nil == idx then
    PaGlobal_WorkerRandomSelectOption_All:gradePanelSetShow(false)
    return
  end
  PaGlobal_WorkerRandomSelectOption_All._config._workerGrade = idx
  PaGlobal_WorkerRandomSelectOption_All:update()
  PaGlobal_WorkerRandomSelectOption_All:gradePanelSetShow(false)
end
function HandleEventLUp_WorkerRandomSelectOption_All_OptionOpen(idx)
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  if 0 == idx then
    if true == Panel_Window_WorkerRandomSelectOption_Grade_All:GetShow() then
      return
    end
    PaGlobal_WorkerRandomSelectOption_All:gradePanelSetShow(true)
    Panel_NumberPad_Close()
  else
    if true == Panel_NumberPad_IsPopUp() then
      return
    end
    HandleEventLUp_WorkerRandomSelectOption_All_SelectCountOpen()
    PaGlobal_WorkerRandomSelectOption_All:gradePanelSetShow(false)
  end
  PaGlobal_WorkerRandomSelectOption_All:update()
end
function HandleEventOn_WorkerRandomSelectOption_All_LimitTextTooltip(index)
  if nil == Panel_Window_WorkerRandomSelectOption_All then
    return
  end
  local name = PaGlobal_WorkerRandomSelectOption_All._gradeTexts[index]:GetText()
  local control = PaGlobal_WorkerRandomSelectOption_All._gradeButtons[index]
  TooltipSimple_Show(control, name, nil)
end
function HandleEventOut_WorkerRandomSelectOption_All_LimitTextTooltip()
  TooltipSimple_Hide()
end
