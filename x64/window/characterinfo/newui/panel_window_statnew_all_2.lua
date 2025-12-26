function PaGlobal_CharacterStatNew_ShowAni()
  if PaGlobal_CharacterStatNew_All == nil then
    return
  end
end
function PaGlobal_CharacterStatNew_HideAni()
  if PaGlobal_CharacterStatNew_All == nil then
    return
  end
end
function PaGlobal_CharacterStatNew_Open()
  if PaGlobal_CharacterStatNew_All == nil then
    return
  end
  PaGlobal_CharacterStatNew_All:prepareOpen()
end
function PaGlobal_CharacterStatNew_Close()
  if PaGlobal_CharacterStatNew_All == nil then
    return
  end
  PaGlobal_CharacterStatNew_All:prepareClose()
end
function PaGlobal_CharacterStatNew_Update()
  if PaGlobal_CharacterStatNew_All == nil then
    return
  end
  if Panel_Window_StatNew_All:GetShow() == false then
    return
  end
  PaGlobal_CharacterStatNew_All:updateValue()
end
function PaGlobal_CharacterStatNew_Toggle()
  local self = PaGlobal_CharacterStatNew_All
  if self == nil then
    return
  end
  local isShow = Panel_Window_StatNew_All:GetShow()
  if isShow == true then
    PaGlobal_CharacterStatNew_Close()
  else
    PaGlobal_CharacterStatNew_Open()
  end
end
function PaGlobalFunc_CharacterStatNew_OpenBonusStatBrowserConsole()
  local url = "https://www.console.playblackdesert.com/Wiki/Default?wikiNo=297"
  if ToClient_isPS() == true then
    ToClient_OpenNativeWebBrowserPS4(url)
  else
    ToClient_OpenNativeWebBrowserXB1(url, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_SHOW_BONUS_STAT"))
  end
end
