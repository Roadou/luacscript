PaGlobal_Solrare_MatchingConfirm = {
  _ui = {
    _txt_Confirm = nil,
    _stc_ProgressBar = nil,
    _stc_member = {}
  },
  _ui_pc = {_btn_Confrim = nil, _btn_Cancel = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _maxPlayerCount = 0,
  _currentRemainTime = 0,
  _isConsole = false,
  _waitTime = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Solrare_MatchingConfirm_Init")
function FromClient_Solrare_MatchingConfirm_Init()
  PaGlobal_Solrare_MatchingConfirm:initialize()
end
function PaGlobal_Solrare_MatchingConfirm:initialize()
  if true == PaGlobal_Solrare_MatchingConfirm._initialize or nil == Panel_Popup_Solare_MatchConfirm then
    return
  end
  self._isConsole = _ContentsGroup_RenewUI
  local stc_Dec = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "Static_Dec_Type")
  for index = 0, 5 do
    local member = UI.getChildControl(stc_Dec, "Static_Member_" .. tostring(index))
    member:SetShow(false)
  end
  self._ui._txt_Confirm = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "StaticText_Confirm")
  self._ui._stc_ProgressBar = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "Progress2_1")
  local titleBg = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "Static_TitleBg")
  self._ui_pc._btn_Confrim = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "Button_Ok")
  self._ui_pc._btn_Cancel = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "Button_Cancel")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Popup_Solare_MatchConfirm, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Confirm_A")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Refuse_B")
  local keyguides = {
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_Solrare_MatchingConfirm:registEventHandler()
  PaGlobal_Solrare_MatchingConfirm:swichPlatform()
  PaGlobal_Solrare_MatchingConfirm._initialize = true
end
function PaGlobal_Solrare_MatchingConfirm:registEventHandler()
  if nil == Panel_Popup_Solare_MatchConfirm then
    return
  end
  self._ui_pc._btn_Confrim:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_JoinConfirm()")
  self._ui_pc._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_Solrare_JoinCancel()")
end
function PaGlobal_Solrare_MatchingConfirm:swichPlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(true)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_Solrare_MatchingConfirm:prepareOpen()
  if nil == Panel_Popup_Solare_MatchConfirm then
    return
  end
  if false == _ContentsGroup_Solare then
    return
  end
  if nil ~= Panel_Window_GameExit_All and Panel_Window_GameExit_All:GetShow() == true then
    PaGlobal_GameExit_All_Close(true)
  end
  Panel_Popup_Solare_MatchConfirm:RegisterUpdateFunc("FromClient_Solrare_MatchingConfirm_UpdatePerFrame")
  PaGlobal_Solrare_MatchingConfirm:open()
  audioPostEvent_SystemUi(30, 7)
  _AudioPostEvent_SystemUiForXBOX(30, 7)
  Panel_Popup_Solare_MatchConfirm:ComputePos()
end
function PaGlobal_Solrare_MatchingConfirm:open()
  if nil == Panel_Popup_Solare_MatchConfirm then
    return
  end
  Panel_Popup_Solare_MatchConfirm:SetShow(true)
end
function PaGlobal_Solrare_MatchingConfirm:prepareClose()
  if nil == Panel_Popup_Solare_MatchConfirm then
    return
  end
  Panel_Popup_Solare_MatchConfirm:ClearUpdateLuaFunc()
  PaGlobal_Solrare_MatchingConfirm:close()
end
function PaGlobal_Solrare_MatchingConfirm:close()
  if nil == Panel_Popup_Solare_MatchConfirm then
    return
  end
  Panel_Popup_Solare_MatchConfirm:SetShow(false)
end
function HandleEventLUp_Solrare_JoinConfirm()
  ToClient_RequestMatchConfirm(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(false)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(false)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(true)
end
function HandleEventLUp_Solrare_JoinCancel()
  ToClient_RequestMatchConfirm(false)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(false)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(false)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
  PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(true)
end
function FromClient_SolareJoinConfirmUpdate(maxPlayerCount, playerCount, confirmCount, isConfirm)
  if nil == maxPlayerCount or nil == playerCount or nil == confirmCount then
    return
  end
  PaGlobal_Solrare_MatchingConfirm._maxPlayerCount = maxPlayerCount
  if playerCount < PaGlobal_Solrare_MatchingConfirm._maxPlayerCount then
    PaGlobalFunc_Solrare_MatchingState_Open()
    PaGlobalFunc_Solrare_MatchingConfirm_Close()
    return
  end
  PaGlobal_Solrare_MatchingConfirm._waitTime = ToClient_GetMatchWaitTime()
  if Panel_Popup_Solare_MatchConfirm:GetShow() == false then
    PaGlobalFunc_Solrare_MatchingState_Close()
    PaGlobalFunc_Solrare_MatchingConfirm_Open()
  end
  if true == isConfirm then
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(false)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(true)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(false)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(true)
  else
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(true)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(false)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(false)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(true)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(false)
    PaGlobal_Solrare_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(false)
  end
end
function FromClient_Solrare_MatchingConfirm_UpdatePerFrame(deltaTime)
  local remainTime = ToClient_GetMatchRemainTime()
  if PaGlobal_Solrare_MatchingConfirm._currentMaxCountDown ~= remainTime then
    PaGlobal_Solrare_MatchingConfirm._currentMaxCountDown = remainTime
    PaGlobal_Solrare_MatchingConfirm._ui._txt_Confirm:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_Solrare_MatchingConfirm._ui._txt_Confirm:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_TIMELEFT", "time", tostring(PaGlobal_Solrare_MatchingConfirm._currentMaxCountDown)))
  end
  if PaGlobal_Solrare_MatchingConfirm._waitTime == toInt64(0, 0) then
    ToClient_RequestMatchTimeOut(__eInstanceContentsType_Solare)
    Panel_Popup_Solare_MatchConfirm:ClearUpdateLuaFunc()
    return
  end
  local rate = Int64toInt32(remainTime) / Int64toInt32(PaGlobal_Solrare_MatchingConfirm._waitTime) * 100
  PaGlobal_Solrare_MatchingConfirm._ui._stc_ProgressBar:SetProgressRate(rate)
  if rate < 1 then
    ToClient_RequestMatchTimeOut(__eInstanceContentsType_Solare)
    Panel_Popup_Solare_MatchConfirm:ClearUpdateLuaFunc()
  end
end
function PaGlobalFunc_Solrare_MatchingConfirm_Open()
  PaGlobal_Solrare_MatchingConfirm:prepareOpen()
end
function PaGlobalFunc_Solrare_MatchingConfirm_Close()
  PaGlobal_Solrare_MatchingConfirm:prepareClose()
end
function PaGlobalFunc_Solrare_MatchingConfirm_IsOpen()
  if Panel_Popup_Solare_MatchConfirm == nil then
    return false
  end
  return Panel_Popup_Solare_MatchConfirm:GetShow()
end
