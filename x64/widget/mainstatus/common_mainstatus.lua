local _swapSetShowTable = {
  remasterTable = {PaGlobalFunc_MainStatus_SetShow},
  beforeTable = {
    PaGlobalFunc_PvpMode_SetShow,
    PaGlobalFunc_SelfPlayerExpGage_SetShow,
    FGlobal_User_Bar_Show,
    Panel_Adrenallin_SetShow
  }
}
function checkHpAlertPostEvent()
  if true == PaGlobalFunc_IsRemasterUIOption() then
    PaGlobalFunc_MainStatus_CheckHpAlertPostEvent()
  else
    PaGlobalFunc_CheckHpAlertPostEvent()
  end
end
function FGlobal_DangerAlert_Show(isShow)
  if true == PaGlobalFunc_IsRemasterUIOption() then
    PaGlobalFunc_MainStatus_DangerAlertShow(isShow)
  elseif ToClient_isConsole() == true then
    PaGlobalFunc_MainStatusInfo_DangerAlertShow()
  else
    PaGlobalFunc_DangerAlert_Show(isShow)
  end
end
function Panel_MainStatus_User_Bar_Onresize()
  if true == PaGlobalFunc_IsRemasterUIOption() then
    FromClient_MainStatus_OnResize()
  else
    PaGlobalFunc_UserBar_Onresize()
  end
end
function Panel_SelfPlayerExpGage_SetShow(isShow, isAni)
  if true == PaGlobalFunc_IsRemasterUIOption() then
    PaGlobalFunc_MainStatus_SetShow(isShow)
  else
    PaGlobalFunc_SelfPlayerExpGage_SetShow(isShow, isAni)
  end
end
function FGlobal_ImmediatelyResurrection(resurrFunc)
  if true == PaGlobalFunc_IsRemasterUIOption() then
    PaGlobalFunc_MainStatus_ImmediatelyResurrection(resurrFunc)
  else
    FGlobal_UserBar_ImmediatelyResurrection(resurrFunc)
  end
end
function Panel_MainStatus_User_Bar_CharacterInfoWindowUpdate()
  if true == PaGlobalFunc_IsRemasterUIOption() then
    PaGlobalFunc_MainStatus_CharacterInfoWindowUpdate()
  else
    PaGlobalFunc_UserBar_CharacterInfoWindowUpdate()
  end
end
function PvpMode_ShowButton(isShow)
  if true == PaGlobalFunc_IsRemasterUIOption() then
    PaGlobalFunc_MainStatus_ShowPVPButton(isShow)
  else
    PaGlobalFunc_PvpMode_ShowButton(isShow)
  end
end
function FGlobal_ClassResource_SetShowControl(isShow)
  Panel_ClassResource_SetShow(isShow)
end
function FromClient_MainStatus_SwapUIOption(isRemaster, isForce)
  PaGlobalFunc_SetRemasterUIOption(isRemaster)
  local showTable, hideTable
  if true == isRemaster then
    showTable = _swapSetShowTable.remasterTable
    hideTable = _swapSetShowTable.beforeTable
    PaGlobalFunc_MainStatus_UpdateAll()
  else
    hideTable = _swapSetShowTable.remasterTable
    showTable = _swapSetShowTable.beforeTable
    PaGlobalFunc_UserBar_CharacterInfoWindowUpdate()
  end
  for _, func in pairs(showTable) do
    func(true, false, isForce)
  end
  for _, func in pairs(hideTable) do
    func(false, false, isForce)
  end
end
