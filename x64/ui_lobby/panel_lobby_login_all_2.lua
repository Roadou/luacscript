function HandleEventLUp_Login_All_LoginStart()
  if ToClient_isConsole() == true and Toclient_isLoginLockByOutOfMemory() == true then
    local title = PAGetString(Defines.StringSheet_GAME, "SECONDARYPASSWORD_NOTICE")
    local content = PAGetString(Defines.StringSheet_GAME, "GAME_XBOX_LOW_MEMORY_ALARM_MESSAGE")
    local messageBoxData = {
      title = title,
      content = content,
      functionApply = MessageBox_Empty_function,
      exitButton = true,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local serviceType = getGameServiceType()
  if (isGameTypeGT() or isGameTypeKorea()) and 1 ~= serviceType and false == isUseTotalAccount() and false == isUseTotalAccountVer2() then
    FGlobal_TermsofGameUse_Open()
  else
    PaGlobal_Login_All:enterLogin()
  end
end
function HandleEventLUp_Login_All_GameExit()
  local _title = ""
  local _desc = PAGetString(Defines.StringSheet_GAME, "PANEL_GAMEEXIT_TRAY_ASK")
  local _confirmFunction = GlobalExitGameClient
  local _cancel = MessageBox_Empty_function
  local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = _confirmFunction,
    functionCancel = _cancel,
    priority = _priority,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_Login_All_ChangeAccount()
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_CHANGEACCOUNT_MSGBOX")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
    content = messageBoxMemo,
    functionYes = PaGlobal_Login_All_ChangeAccount,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "top")
end
function HandleEventLUp_Login_All_GameOption()
  showGameOption()
  ToClient_GameOptionPanelOpen()
end
function PaGlobal_Login_All_ShowAni()
  if nil == Panel_Lobby_Login_All then
    return
  end
end
function PaGlobal_Login_All_HideAni()
  if nil == Panel_Lobby_Login_All then
    return
  end
end
function FromClient_Login_All_OnMovieEvent(param)
  PaGlobal_Login_All:onMovieEvent(param)
end
function FromClient_Login_All_onScreenResize()
  PaGlobal_Login_All:onScreenResize()
end
function FromClient_Login_All_InitLoginMovie()
  PaGlobal_Login_All:initLoginMovie()
end
function FromClient_Login_All_ClickToLogin()
  HandleEventLUp_Login_All_LoginStart()
end
function FromClient_ConnectToAuthServerTimerStart()
  if nil == Panel_Lobby_Login_All then
    return
  end
  Panel_Lobby_Login_All:RegisterUpdateFunc("Update_Timer")
end
function Update_Timer(deltaTime)
  PaGlobal_Login_All._authConnectedTimeOut = PaGlobal_Login_All._authConnectedTimeOut - deltaTime
  if PaGlobal_Login_All._authConnectedTimeOut < 0 then
    allClearMessageData()
    Event_MessageBox_NotifyMessage_With_ClientMessage(PAGetString(Defines.StringSheet_GAME, "GAME_MESSAGE_CONNECT_FAIL"), 2)
  end
end
function PaGlobal_Login_All_ChangeAccount()
  ToClient_ChangeAccount()
end
function PaGlobal_Login_All_LoginButtonDisable(isDisable)
  PaGlobal_Login_All:updateButtonDisable(isDisable)
end
function PaGlobal_Login_All_LoginEnter()
  _AudioPostEvent_SystemUiForXBOX(50, 8)
  PaGlobal_Login_All:enterLogin()
end
function HandleEventLUp_Login_All_OpenAgeInfo()
  PaGlobalFunc_Common_Description_Open()
end
