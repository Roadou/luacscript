function PaGlobal_HardCoreMenu:initialize()
  if PaGlobal_HardCoreMenu._initialize == true then
    return
  end
  local bg = UI.getChildControl(Panel_Menu_HardCore, "Static_BTN_BG")
  self._ui._btn_CharacterInfo = UI.getChildControl(bg, "Button_CharacterInfo")
  self._ui._btn_Skill = UI.getChildControl(bg, "Button_Skill")
  self._ui._btn_Ranking = UI.getChildControl(bg, "Button_Ranking")
  self._ui._btn_UISetting = UI.getChildControl(bg, "Button_UISetting")
  self._ui._btn_Escape = UI.getChildControl(bg, "Button_Escape")
  self._ui._btn_RingMenu_Option = UI.getChildControl(bg, "Button_RingMenu_ConsoleUI")
  self._ui._stc_line = UI.getChildControl(bg, "Static_Line")
  self._ui._btn_Option = UI.getChildControl(bg, "Button_Option")
  self._ui._btn_GameExit = UI.getChildControl(bg, "Button_GameExit")
  self._isConsole = _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    self._ui._btn_RingMenu_Option:SetShow(true)
    self._ui._stc_line:SetSpanSize(self._ui._stc_line:GetSpanSize().x, self._ui._stc_line:GetSpanSize().y + 50)
    self._ui._btn_Option:SetSpanSize(self._ui._btn_Option:GetSpanSize().x, self._ui._btn_Option:GetSpanSize().y + 50)
    self._ui._btn_GameExit:SetSpanSize(self._ui._btn_GameExit:GetSpanSize().x, self._ui._btn_GameExit:GetSpanSize().y + 50)
  else
    self._ui._btn_RingMenu_Option:SetShow(false)
  end
  PaGlobal_HardCoreMenu:registEventHandler()
  PaGlobal_HardCoreMenu:validate()
  PaGlobal_HardCoreMenu._initialize = true
end
function PaGlobal_HardCoreMenu:registEventHandler()
  if Panel_Menu_HardCore == nil then
    return
  end
  registerEvent("FromClient_HardCoreChannelKillLog", "FromClient_HardCoreChannelKillLog")
  self._ui._btn_CharacterInfo:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenCharacterInfo()")
  self._ui._btn_Skill:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenSkill()")
  self._ui._btn_Ranking:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenRankPage()")
  self._ui._btn_UISetting:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenUISetting()")
  self._ui._btn_Escape:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_DoEscape()")
  if self._isConsole == true then
    self._ui._btn_RingMenu_Option:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenConsoleRingMenu()")
  end
  self._ui._btn_Option:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenGameOption()")
  self._ui._btn_GameExit:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreMenu_OpenGameExit()")
end
function PaGlobal_HardCoreMenu:validate()
  self._ui._btn_CharacterInfo:isValidate()
  self._ui._btn_Skill:isValidate()
  self._ui._btn_Ranking:isValidate()
  self._ui._btn_UISetting:isValidate()
  self._ui._btn_Escape:isValidate()
  self._ui._btn_RingMenu_Option:isValidate()
  self._ui._stc_line:isValidate()
  self._ui._btn_Option:isValidate()
  self._ui._btn_GameExit:isValidate()
end
function PaGlobal_HardCoreMenu:prepareOpen()
  if Panel_Menu_HardCore == nil then
    return
  end
  self:open()
end
function PaGlobal_HardCoreMenu:open()
  if Panel_Menu_HardCore == nil then
    return
  end
  Panel_Menu_HardCore:SetShow(true)
end
function PaGlobal_HardCoreMenu:prepareClose()
  if Panel_Menu_HardCore == nil then
    return
  end
  self:close()
end
function PaGlobal_HardCoreMenu:close()
  if Panel_Menu_HardCore == nil then
    return
  end
  Panel_Menu_HardCore:SetShow(false)
end
