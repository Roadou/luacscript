function PaGlobalFunc_AbyssOneMenu_GetShow()
  if Panel_Menu_AbyssOne == nil then
    return false
  end
  return Panel_Menu_AbyssOne:GetShow()
end
function PaGlobalFunc_AbyssOneMenu_ShowToggle()
  local panel = Panel_Menu_AbyssOne
  if panel == nil then
    return
  end
  local self = PaGlobal_AbyssOneMenu
  if self == nil then
    return
  end
  if panel:GetShow() == true then
    self:prepareClose()
  else
    self:prepareOpen()
  end
end
function PaGlobalFunc_AbyssOneMenu_Close()
  local panel = Panel_Menu_AbyssOne
  if panel == nil then
    return
  end
  local self = PaGlobal_AbyssOneMenu
  if self == nil then
    return
  end
  if panel:GetShow() == true then
    self:prepareClose()
  end
end
function Panel_Menu_AbyssOne_ShowAni()
  Panel_Menu_AbyssOne:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_Menu_AbyssOne, 0, 0.1)
end
function Panel_Menu_AbyssOne_HideAni()
  Panel_Menu_AbyssOne:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Menu_AbyssOne, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function HandleEventLUp_AbyssOne_Menu(btnType)
  local self = PaGlobal_AbyssOneMenu
  if self == nil or btnType == nil then
    return
  end
  local hideMenu = false
  if btnType == self._BTN_TYPE._OPEN_EQUIP then
    PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_PrePareOpen()
    hideMenu = true
  elseif btnType == self._BTN_TYPE._RETURN_MAGNUS then
    local function do_confirm()
      local MagnusMapKey = ToClient_GetAbyssOneBaseMapKey()
      ToClient_MoveInstanceField(__eInstanceContentsType_AbyssOne, 0, MagnusMapKey)
      hideMenu = true
    end
    local messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_MSG_RECALL")
    local currentMapKey = ToClient_GetCurrentInstanceFieldMapKey()
    if currentMapKey == ToClient_GetAbyssOneBaseMapKey() then
      messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ABYSSONE_MAGNUS_RETRY")
    end
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageBoxDesc,
      functionYes = do_confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
      exitButton = true
    }
    MessageBox.showMessageBox(messageboxData)
  elseif btnType == self._BTN_TYPE._EXIT_ABYSSONE then
    local function do_confirm()
      ToClient_UnJoinInstanceFieldForAll()
      hideMenu = true
    end
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_MSG_EXIT"),
      functionYes = do_confirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
      exitButton = true
    }
    MessageBox.showMessageBox(messageboxData)
  elseif btnType == self._BTN_TYPE._RINGMENU_SETTING then
    if self._isConsole == false then
      return
    end
    if FromClient_ConsoleQuickMenu_OpenCustomPage ~= nil then
      FromClient_ConsoleQuickMenu_OpenCustomPage(2)
      hideMenu = true
    end
  elseif btnType == self._BTN_TYPE._OPEN_GAMEOPTION then
    showGameOption()
    hideMenu = true
  elseif btnType == self._BTN_TYPE._TRAY_MODE then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_TRAYBLACKDESERT_ACK"))
    ToClient_CheckTrayIcon()
    hideMenu = true
  elseif btnType == self._BTN_TYPE._EXIT_GAME then
    local function do_Exit()
      disConnectToGame()
      GlobalExitGameClient()
      hideMenu = true
    end
    messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK"),
      functionYes = do_Exit,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
      exitButton = true
    }
    MessageBox.showMessageBox(messageboxData)
  elseif btnType == self._BTN_TYPE._RETRY then
    local currentMapKey = ToClient_GetCurrentInstanceFieldMapKey()
    local MagnusMapKey = ToClient_GetAbyssOneBaseMapKey()
    if currentMapKey == MagnusMapKey then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseFromCurrentRegion"))
    else
      if ToClient_CheckInstanceMirrorFieldRestartTime(true) == false then
        return
      end
      local do_retry = function()
        local selfPlayerWrapper = getSelfPlayer()
        if selfPlayerWrapper == nil then
          return
        end
        deadMessage_Revival(__eRespawnType_AbyssOne, 255, CppEnums.ItemWhereType.eCount, selfPlayerWrapper:getRegionKey(), false, toInt64(0, 0), false, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
        ToClient_SetInstanceMirrorFieldRestartNextTime(60)
      end
      messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
        content = PAGetString(Defines.StringSheet_GAME, "LUA_POPUP_MSG_RETRY"),
        functionYes = do_retry,
        functionCancel = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
        exitButton = true
      }
      MessageBox.showMessageBox(messageboxData)
      hideMenu = true
    end
  else
    UI.ASSERT_NAME(false, "\236\150\180\235\185\132\236\138\164\236\155\144 \235\169\148\235\137\180\236\157\152 \235\178\132\237\138\188 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  if hideMenu == true and Panel_Menu_AbyssOne:GetShow() == true then
    self:prepareClose()
  end
end
function HandleEventLOn_AbyssOne_Menu(btnType)
  local self = PaGlobal_AbyssOneMenu
  if self == nil or btnType == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local targetControl
  if btnType == self._BTN_TYPE._OPEN_EQUIP then
    targetControl = self._ui._btn_openEquip
  elseif btnType == self._BTN_TYPE._RETURN_MAGNUS then
    targetControl = self._ui._btn_returnMagnus
  elseif btnType == self._BTN_TYPE._EXIT_ABYSSONE then
    targetControl = self._ui._btn_exit
  elseif btnType == self._BTN_TYPE._RINGMENU_SETTING then
    targetControl = self._ui._btn_ringMenu
  elseif btnType == self._BTN_TYPE._OPEN_GAMEOPTION then
    targetControl = self._ui._btn_gameOption
  elseif btnType == self._BTN_TYPE._TRAY_MODE then
    targetControl = self._ui._btn_trayMode
  elseif btnType == self._BTN_TYPE._EXIT_GAME then
    targetControl = self._ui._btn_gameExit
  elseif btnType == self._BTN_TYPE._RETRY then
    targetControl = self._ui._btn_retry
  else
    UI.ASSERT_NAME(false, "\236\150\180\235\185\132\236\138\164\236\155\144 \235\169\148\235\137\180\236\157\152 \235\178\132\237\138\188 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \236\182\148\234\176\128\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  if targetControl ~= nil then
    self._ui._stc_keyGuide_A:SetPosY(targetControl:GetPosY())
  end
end
function FromClient_AbyssOneMenu_Exit()
  local self = PaGlobal_AbyssOneMenu
  if self == nil then
    return
  end
  local currentUIMode = GetUIMode()
  if currentUIMode == Defines.UIMode.eUIMode_NpcDialog or currentUIMode == Defines.UIMode.eUIMode_NpcSimpleDialog then
    return
  end
  HandleEventLUp_AbyssOne_Menu(self._BTN_TYPE._EXIT_GAME)
end
function FromClient_AbyssOneMenu_Close()
  local self = PaGlobal_AbyssOneMenu
  if self == nil then
    return
  end
  if Panel_Menu_AbyssOne:GetShow() == true then
    self:prepareClose()
  end
end
