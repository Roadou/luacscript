PaGlobal_RedBattleField_Match = {
  _ui = {btn_canel = nil, txt_time = nil},
  _matchingDelayTime = 2,
  _matchingTime = 0,
  _matchingCloseTime = 0,
  _currentDeltaTime = 0,
  _currentElapsedTime = 0,
  _isInitialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_RedBattleField_Match_Init")
function FromClient_RedBattleField_Match_Init()
  PaGlobal_RedBattleField_Match:initialize()
end
function PaGlobal_RedBattleField_Match:initialize()
  if self._isInitialize == true or Panel_Widget_LocalWar_Match_All == nil then
    return
  end
  self._ui.btn_canel = UI.getChildControl(Panel_Widget_LocalWar_Match_All, "Button_Cancel")
  self._ui.txt_time = UI.getChildControl(Panel_Widget_LocalWar_Match_All, "StaticText_Time")
  self:registEventHandler()
  self._isInitialize = true
end
function PaGlobal_RedBattleField_Match:registEventHandler()
  if Panel_Widget_LocalWar_Match_All == nil then
    return
  end
  self._ui.btn_canel:addInputEvent("Mouse_LUp", "PaGlobalFunc_RedBattleField_MatchingState_PrepareClose()")
end
function PaGlobal_RedBattleField_Match:prepareOpen()
  if Panel_Widget_LocalWar_Match_All == nil then
    return
  end
  PaGlobal_RedBattleField_Match:open()
end
function PaGlobal_RedBattleField_Match:open()
  if Panel_Widget_LocalWar_Match_All == nil then
    return
  end
  Panel_Widget_LocalWar_Match_All:SetShow(true)
end
function PaGlobal_RedBattleField_Match:prepareClose()
  if Panel_Widget_LocalWar_Match_All == nil then
    return
  end
  Panel_Widget_LocalWar_Match_All:ClearUpdateLuaFunc()
  PaGlobal_RedBattleField_Match._currentElapsedTime = 0
  PaGlobal_RedBattleField_Match._currentDeltaTime = 0
  PaGlobal_RedBattleField_Match:close()
end
function PaGlobal_RedBattleField_Match:close()
  if Panel_Widget_LocalWar_Match_All == nil then
    return
  end
  Panel_Widget_LocalWar_Match_All:SetShow(false)
end
function PaGlobalFunc_RedBattleField_MatchingState_Open()
  if Panel_Widget_LocalWar_Match_All:GetShow() == true then
    return
  end
  PaGlobal_RedBattleField_Match._ui.txt_time:SetText("")
  PaGlobal_RedBattleField_Match._currentElapsedTime = 0
  PaGlobal_RedBattleField_Match._currentDeltaTime = 0
  Panel_Widget_LocalWar_Match_All:ClearUpdateLuaFunc()
  Panel_Widget_LocalWar_Match_All:RegisterUpdateFunc("FromClient_RedBattleField_MatchingState_UpdatePerFrame")
  Panel_Widget_LocalWar_Match_All:ComputePos()
  PaGlobal_RedBattleField_Match:prepareOpen()
end
function PaGlobalFunc_RedBattleField_MatchingState_PrepareClose()
  if PaGlobal_RedBattleField_Match._matchingCloseTime < PaGlobal_RedBattleField_Match._matchingDelayTime then
    local remainSecTime = math.floor(PaGlobal_RedBattleField_Match._matchingDelayTime - PaGlobal_RedBattleField_Match._matchingCloseTime)
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "GAME_CONSOLE_REFRESH_MAIL_COOLTIME", "cooltime", remainSecTime))
    return
  end
  PaGlobal_RedBattleField_Match._matchingCloseTime = 0
  ToClient_requestCancleMatching()
end
function PaGlobalFunc_RedBattleField_MatchingState_Close()
  PaGlobal_RedBattleField_Match:prepareClose()
end
function FromClient_RedBattleField_MatchingState_UpdatePerFrame(deltaTime)
  PaGlobal_RedBattleField_Match._matchingCloseTime = PaGlobal_RedBattleField_Match._matchingCloseTime + deltaTime
  PaGlobal_RedBattleField_Match._currentDeltaTime = PaGlobal_RedBattleField_Match._currentDeltaTime + deltaTime
  if PaGlobal_RedBattleField_Match._currentDeltaTime > 1 then
    PaGlobal_RedBattleField_Match._currentElapsedTime = PaGlobal_RedBattleField_Match._currentElapsedTime + 1
    PaGlobal_RedBattleField_Match._currentDeltaTime = 0
    PaGlobal_RedBattleField_Match._ui.txt_time:SetText(convertSecondsToClockTime(PaGlobal_RedBattleField_Match._currentElapsedTime))
  end
end
function FromClient_RedBattleField_MatchServerConnectSuccess()
  ToClient_requestJoinMatching(__eMatchMode_Count, __eInstanceContentsType_RedBattleField, 0, -1, 0)
end
function FromClient_RedBattleField_SuccessMatchServerLogin()
  if ToClient_IsMatchingStateByMatchServer() == true then
    PaGlobalFunc_RedBattleField_MatchingState_Open()
  elseif Panel_Widget_LocalWar_Match_All:GetShow() == true then
    PaGlobalFunc_RedBattleField_MatchingState_Close()
  end
end
function FromClient_RedBattleField_SuccessMatchServerLogout()
  PaGlobalFunc_RedBattleField_MatchingState_Close()
  PaGlobalFunc_RedBattleField_MatchingConfirm_Close()
end
function FromClient_RedBattleField_MatchingSuccess()
  if Panel_Widget_LocalWar_Match_All:GetShow() == true then
    return
  end
  PaGlobalFunc_RedBattleField_MatchingConfirm_Close()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CASH_CUSTOMIZATION_BUYITEM_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_REDBATTLEFIELD_ENDTER_LOADING"),
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function FromClient_RedBattleField_MatchingStateUpdate(isMatching)
  if ToClient_IsMatchingStateByMatchServer() == true then
    PaGlobalFunc_RedBattleField_MatchingState_Open()
  elseif Panel_Widget_LocalWar_Match_All:GetShow() == true then
    PaGlobalFunc_RedBattleField_MatchingState_Close()
  end
end
