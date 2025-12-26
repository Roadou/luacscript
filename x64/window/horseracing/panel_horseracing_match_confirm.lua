PaGlobal_HorseRacing_MatchingConfirm = {
  _ui = {_txt_Confirm = nil, _stc_ProgressBar = nil},
  _ui_pc = {_btn_Confrim = nil, _btn_Cancel = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _currentRemainTime = 0,
  _isConsole = false,
  _waitTime = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_HorseRacing_MatchingConfirm_Init")
function FromClient_HorseRacing_MatchingConfirm_Init()
  PaGlobal_HorseRacing_MatchingConfirm:initialize()
end
function PaGlobal_HorseRacing_MatchingConfirm:initialize()
  if true == PaGlobal_HorseRacing_MatchingConfirm._initialize or nil == Panel_HorseRacing_Match_Confirm then
    return
  end
  self._isConsole = _ContentsGroup_RenewUI
  self._ui._txt_Confirm = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "StaticText_Confirm")
  self._ui._stc_ProgressBar = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "Progress2_1")
  self._ui._stc_Desc = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "Static_Dec_Type")
  self._ui._multiLineText = UI.getChildControl(self._ui._stc_Desc, "MultilineText_Invite")
  local titleBg = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "Static_TitleBg")
  self._ui_pc._btn_Confrim = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "Button_Ok")
  self._ui_pc._btn_Cancel = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "Button_Cancel")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_HorseRacing_Match_Confirm, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Confirm_A")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Refuse_B")
  local keyguides = {
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_HorseRacing_MatchingConfirm:registEventHandler()
  PaGlobal_HorseRacing_MatchingConfirm:swichPlatform()
  PaGlobal_HorseRacing_MatchingConfirm._initialize = true
end
function PaGlobal_HorseRacing_MatchingConfirm:registEventHandler()
  if nil == Panel_HorseRacing_Match_Confirm then
    return
  end
  self._ui_pc._btn_Confrim:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacing_JoinConfirm()")
  self._ui_pc._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseRacing_JoinCancel()")
end
function PaGlobal_HorseRacing_MatchingConfirm:swichPlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_HorseRacing_MatchingConfirm:prepareOpen()
  if nil == Panel_HorseRacing_Match_Confirm then
    return
  end
  Panel_HorseRacing_Match_Confirm:RegisterUpdateFunc("FromClient_HorseRacing_MatchingConfirm_UpdatePerFrame")
  PaGlobalFunc_HorseRacing_MatchingState_SwitchMatchingBtn(true)
  audioPostEvent_SystemUi(30, 7)
  _AudioPostEvent_SystemUiForXBOX(30, 7)
  Panel_HorseRacing_Match_Confirm:ComputePos()
  PaGlobal_HorseRacing_MatchingConfirm:open()
end
function PaGlobal_HorseRacing_MatchingConfirm:open()
  if nil == Panel_HorseRacing_Match_Confirm then
    return
  end
  Panel_HorseRacing_Match_Confirm:SetShow(true)
end
function PaGlobal_HorseRacing_MatchingConfirm:prepareClose()
  if nil == Panel_HorseRacing_Match_Confirm then
    return
  end
  PaGlobalFunc_HorseRacing_MatchingState_SwitchMatchingBtn(false)
  Panel_HorseRacing_Match_Confirm:ClearUpdateLuaFunc()
  PaGlobal_HorseRacing_MatchingConfirm:close()
end
function PaGlobal_HorseRacing_MatchingConfirm:close()
  if nil == Panel_HorseRacing_Match_Confirm then
    return
  end
  Panel_HorseRacing_Match_Confirm:SetShow(false)
end
function HandleEventLUp_HorseRacing_JoinConfirm()
  ToClient_RequestMatchConfirm(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(false)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(false)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(true)
end
function HandleEventLUp_HorseRacing_JoinCancel()
  ToClient_RequestMatchConfirm(false)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(false)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(false)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
  PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(true)
end
function FromClient_HorseRacingJoinConfirmUpdate(minPlayerCount, playerCount, confirmCount, isConfirm)
  if nil == minPlayerCount or nil == playerCount or nil == confirmCount then
    return
  end
  if playerCount < minPlayerCount then
    PaGlobalFunc_HorseRacing_MatchingState_Open()
    PaGlobalFunc_HorseRacing_MatchingConfirm_Close()
    return
  end
  PaGlobal_HorseRacing_MatchingConfirm._waitTime = ToClient_GetMatchWaitTime()
  if Panel_HorseRacing_Match_Confirm:GetShow() == false then
    PaGlobalFunc_HorseRacing_MatchingState_Close()
    PaGlobalFunc_HorseRacing_MatchingConfirm_Open()
  end
  if true == isConfirm then
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(false)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(true)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(false)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(true)
  else
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetEnable(true)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetMonoTone(false)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Confrim:SetIgnore(false)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetEnable(true)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetMonoTone(false)
    PaGlobal_HorseRacing_MatchingConfirm._ui_pc._btn_Cancel:SetIgnore(false)
  end
end
function FromClient_HorseRacing_MatchingConfirm_UpdatePerFrame(deltaTime)
  local remainTime = ToClient_GetMatchRemainTime()
  if PaGlobal_HorseRacing_MatchingConfirm._currentMaxCountDown ~= remainTime then
    PaGlobal_HorseRacing_MatchingConfirm._currentMaxCountDown = remainTime
    PaGlobal_HorseRacing_MatchingConfirm._ui._txt_Confirm:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_HorseRacing_MatchingConfirm._ui._txt_Confirm:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_TIMELEFT", "time", tostring(PaGlobal_HorseRacing_MatchingConfirm._currentMaxCountDown)))
  end
  if PaGlobal_HorseRacing_MatchingConfirm._waitTime == toInt64(0, 0) then
    ToClient_RequestMatchTimeOut(__eInstanceContentsType_HorseRacing)
    Panel_HorseRacing_Match_Confirm:ClearUpdateLuaFunc()
    return
  end
  local rate = Int64toInt32(remainTime) / Int64toInt32(PaGlobal_HorseRacing_MatchingConfirm._waitTime) * 100
  PaGlobal_HorseRacing_MatchingConfirm._ui._stc_ProgressBar:SetProgressRate(rate)
  if rate < 1 then
    ToClient_RequestMatchTimeOut(__eInstanceContentsType_HorseRacing)
    Panel_HorseRacing_Match_Confirm:ClearUpdateLuaFunc()
  end
end
function PaGlobalFunc_HorseRacing_MatchingConfirm_Open()
  PaGlobal_HorseRacing_MatchingConfirm:prepareOpen()
end
function PaGlobalFunc_HorseRacing_MatchingConfirm_Close()
  PaGlobal_HorseRacing_MatchingConfirm:prepareClose()
end
function PaGlobalFunc_HorseRacing_MatchingConfirm_IsOpen()
  if Panel_HorseRacing_Match_Confirm == nil then
    return false
  end
  return Panel_HorseRacing_Match_Confirm:GetShow() == true
end
