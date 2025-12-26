function PaGlobal_HardCoreMenu_ShowAni()
  if PaGlobal_HardCoreMenu == nil then
    return
  end
end
function PaGlobal_HardCoreMenu_HideAni()
  if PaGlobal_HardCoreMenu == nil then
    return
  end
end
function PaGlobal_HardCoreMenu_Open()
  if PaGlobal_HardCoreMenu == nil then
    return
  end
  PaGlobal_HardCoreMenu:prepareOpen()
end
function PaGlobal_HardCoreMenu_Close()
  if PaGlobal_HardCoreMenu == nil then
    return
  end
  PaGlobal_HardCoreMenu:prepareClose()
end
function PaGlobal_HardCoreMenu_Toggle()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  local isShow = Panel_Menu_HardCore:GetShow()
  if isShow == true then
    PaGlobal_HardCoreMenu:prepareClose()
  else
    PaGlobal_HardCoreMenu:prepareOpen()
  end
end
function PaGlobal_HardCoreMenu_OpenCharacterInfo()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_CharacterInfo_HardCore_Open()
end
function PaGlobal_HardCoreMenu_OpenRankPage()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreRanking_Open()
end
function PaGlobal_HardCoreMenu_OpenSkill()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreMenu_Toggle()
  if _ContentsGroup_ShowOtherClassSkill == true then
    PaGlobalFunc_SkillGroup_All_OpenByHardcore()
  else
    PaGlobalFunc_SkillGroup_Open()
  end
end
function PaGlobal_HardCoreMenu_OpenUISetting()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreMenu_Toggle()
  FGlobal_UiSet_Open()
end
function PaGlobal_HardCoreMenu_DoEscape()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreMenu_Toggle()
  HandleEventLUp_MenuRemake_Escape()
end
function PaGlobal_HardCoreMenu_OpenConsoleRingMenu()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreMenu_Toggle()
  PaGlobalFunc_Menu_All_RingMenuSetting_Open()
end
function PaGlobal_HardCoreMenu_OpenGameOption()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreMenu_Toggle()
  FromClient_GameOption_All_TogglePanel()
end
function PaGlobal_HardCoreMenu_OpenGameExit()
  local self = PaGlobal_HardCoreMenu
  if self == nil then
    return
  end
  PaGlobal_HardCoreMenu_Toggle()
  PaGlobal_GameExit_All_ShowToggle(false)
end
function FromClient_HardCoreChannelKillLog(killPlayer, deadPlayer)
  local color = "<PAColor0xFF2C7BFF>"
  local isAlly = false
  PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.normal, killPlayer, deadPlayer, nil, isAlly)
end
