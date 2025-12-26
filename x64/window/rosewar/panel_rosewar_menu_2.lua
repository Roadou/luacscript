function PaGlobalFunc_RoseWarMenu_Open()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RoseWarMenu_Close()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarMenu_IsShow()
  if Panel_RoseWar_Menu == nil then
    return false
  end
  return Panel_RoseWar_Menu:GetShow()
end
function HandleEventLUp_RoseWarMenu_OpenRoseWarEditParty()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarEditParty_IsShow() == true then
    PaGlobalFunc_RoseWarEditParty_Close()
  else
    PaGlobalFunc_RoseWarEditParty_Open()
  end
end
function HandleEventLUp_RoseWarMenu_ApplyGuild()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:applyGuild()
end
function HandleEventLUp_RoseWarMenu_ApplyMercenary()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:applyMercenary()
end
function HandleEventLUp_RoseWarMenu_SelectMenu(menuIndex)
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  if menuIndex == self._applyGuildMenu then
    self:setMenuForApplyingGuild()
  elseif menuIndex == self._applyMercenaryMenu then
    self:setMenuForApplyingMercenary()
  elseif menuIndex == self._readyRoseWarMenu then
    self:setMenuForReadyRoseWar()
  else
    return
  end
end
function HandleEventLUp_RoseWarMenu_AppointLeader()
  ToClient_RequestRoseWarMemberInfo()
end
function HandleEventLUp_RoseWarMenu_ReturnGuildMoney()
  ToClient_RequestReturnRoseWarMoney(true)
end
function HandleEventLUp_RoseWarMenu_ReturnMercenaryMoney()
  ToClient_RequestReturnRoseWarMoney(false)
end
function HandleEventLUp_RoseWarMenu_CancelApplyGuild()
  local requestCancelRoseWarByGuild = function()
    ToClient_CancelRoseWarByGuild()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CANCLEAPPLY_CONFIRM_LEADER")
  local messageBoxData = {
    title = nil,
    content = messageBoxMemo,
    functionYes = requestCancelRoseWarByGuild,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, false, false)
end
function HandleEventLUp_RoseWarMenu_CancelApplyMercenary()
  local requestCancelRoseWarByMercenary = function()
    ToClient_CancelRoseWarByMercenary()
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_CANCLEAPPLY_CONFIRM_MERCENARY")
  local messageBoxData = {
    title = nil,
    content = messageBoxMemo,
    functionYes = requestCancelRoseWarByMercenary,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, nil, false, false)
end
function HandleEventLUp_RoseWarMenu_ToggleRoseWarObserveMode()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  ToClient_RequestToggleRoseWarObserveMode()
end
function HandleEventLUp_RoseWarMenu_ToggleRoseWarTeamScoreBoard()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarTeamScoreBoard_IsShow() == true then
    PaGlobalFunc_RoseWarTeamScoreBoard_Close()
  else
    PaGlobalFunc_RoseWarTeamScoreBoard_Open()
  end
end
function HandleEventOnOut_RoseWarMenu_ShowRoseWarObserveModeToolTip(isShow)
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._btn_roseWarObserveMode
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_WAR_CORRESPONDENT_TOOLTIP")
  local desc = ""
  TooltipSimple_Show(control, name, desc)
end
function FromClient_RoseWarMenu_SetRoseWarObserveMode()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:setRoseWarObserveModeButton()
end
function FromClient_RoseWarMenu_UnsetRoseWarObserveMode()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:setRoseWarObserveModeButton()
end
function FromClient_RoseWarMenu_OnScreenResize()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  self:onScreenResize()
end
function FromClient_RoseWarMenu_ReceivedRoseWarMemberInfo()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  if PaGlobalFunc_RoseWarPartyList_IsShow() == true then
    PaGlobalFunc_RoseWarPartyList_Close()
  end
  PaGlobalFunc_RoseWarPartyList_Open()
end
function FromClient_RoseWarMenu_UpdateMenu()
  local self = PaGlobal_RoseWarMenu
  if self == nil then
    return
  end
  HandleEventLUp_RoseWarMenu_SelectMenu(self._selectedMenuIndex)
end
