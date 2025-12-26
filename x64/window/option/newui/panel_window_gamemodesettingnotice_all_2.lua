function PaGlobalFunc_GameModeSettingNotice_All_Open(specType)
  PaGlobal_GameModeSettingNotice_All._selectSpecType = specType
  PaGlobal_GameModeSettingNotice_All:prepareOpen()
  GameOption_Cancel()
end
function PaGlobalFunc_GameModeSettingNotice_All_Close()
  PaGlobal_GameModeSettingNotice_All:prepareClose()
  showGameOption()
end
function HandleEventLUp_GameModeSettingNotice_All_Close()
  PaGlobalFunc_GameModeSettingNotice_All_Close()
end
function HandleEventLUp_GameModeSettingNotice_All_Confirm()
  PaGlobal_GameOption_All_SetSpec()
  PaGlobalFunc_GameModeSettingNotice_All_Close()
end
function FromClient_GameModeSettingNotice_All_OnScreenResize()
  PaGlobal_GameModeSettingNotice_All:resize()
end
