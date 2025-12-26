PaGlobal_RedBattleField_MatchConfirm = {
  _ui = {
    _txt_Confirm = nil,
    _stc_ProgressBar = nil,
    _stc_Desc = nil,
    _multiLineText = nil
  },
  _ui_pc = {_btn_Confrim = nil, _btn_Cancel = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil
  },
  _currentRemainTime = 0,
  _isConsole = false,
  _waitTime = 0,
  _isInitialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_RedBattleField_MatchConfirm_Init")
function FromClient_RedBattleField_MatchConfirm_Init()
  PaGlobal_RedBattleField_MatchConfirm:initialize()
end
function PaGlobal_RedBattleField_MatchConfirm:initialize()
  if self._isInitialize == true or Panel_LocalWar_Match_Confirm_All == nil then
    return
  end
  self._isConsole = _ContentsGroup_RenewUI
  self._ui._txt_Confirm = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "StaticText_Confirm")
  self._ui._stc_ProgressBar = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "Progress2_1")
  self._ui._stc_Desc = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "Static_Dec_Type")
  self._ui._multiLineText = UI.getChildControl(self._ui._stc_Desc, "MultilineText_Invite")
  local titleBg = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "Static_TitleBg")
  self._ui_pc._btn_Confrim = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "Button_Ok")
  self._ui_pc._btn_Cancel = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "Button_Cancel")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_LocalWar_Match_Confirm_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Confirm_A")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Refuse_B")
  local keyguides = {
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self:registEventHandler()
  self:swichPlatform()
  self._isInitialize = true
end
function PaGlobal_RedBattleField_MatchConfirm:registEventHandler()
  if Panel_LocalWar_Match_Confirm_All == nil then
    return
  end
  self._ui_pc._btn_Confrim:addInputEvent("Mouse_LUp", "HandleEventLUp_RedBattleField_JoinConfirm()")
  self._ui_pc._btn_Cancel:addInputEvent("Mouse_LUp", "HandleEventLUp_RedBattleField_JoinCancel()")
end
function PaGlobal_RedBattleField_MatchConfirm:swichPlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_RedBattleField_MatchConfirm:prepareOpen()
  if Panel_LocalWar_Match_Confirm_All == nil then
    return
  end
  Panel_LocalWar_Match_Confirm_All:RegisterUpdateFunc("FromClient_RedBattleField_MatchingConfirm_UpdatePerFrame")
  audioPostEvent_SystemUi(30, 7)
  _AudioPostEvent_SystemUiForXBOX(30, 7)
  Panel_LocalWar_Match_Confirm_All:ComputePos()
  self:open()
end
function PaGlobal_RedBattleField_MatchConfirm:open()
  if Panel_LocalWar_Match_Confirm_All == nil then
    return
  end
  Panel_LocalWar_Match_Confirm_All:SetShow(true)
end
function PaGlobal_RedBattleField_MatchConfirm:prepareClose()
  if Panel_LocalWar_Match_Confirm_All == nil then
    return
  end
  Panel_LocalWar_Match_Confirm_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_RedBattleField_MatchConfirm:close()
  if Panel_LocalWar_Match_Confirm_All == nil then
    return
  end
  Panel_LocalWar_Match_Confirm_All:SetShow(false)
end
function HandleEventLUp_RedBattleField_JoinConfirm()
  ToClient_RequestMatchConfirm(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetEnable(false)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetIgnore(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetEnable(false)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetIgnore(true)
end
function HandleEventLUp_RedBattleField_JoinCancel()
  ToClient_RequestMatchConfirm(false)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetEnable(false)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetIgnore(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetEnable(false)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
  PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetIgnore(true)
end
function FromClient_RedBattleFieldJoinConfirmUpdate(minPlayerCount, playerCount, confirmCount, isConfirm)
  if nil == minPlayerCount or nil == playerCount or nil == confirmCount then
    return
  end
  if playerCount < minPlayerCount then
    PaGlobalFunc_RedBattleField_MatchingState_Open()
    PaGlobalFunc_RedBattleField_MatchingConfirm_Close()
    return
  end
  PaGlobal_RedBattleField_MatchConfirm._waitTime = ToClient_GetMatchWaitTime()
  if Panel_LocalWar_Match_Confirm_All:GetShow() == false then
    PaGlobalFunc_RedBattleField_MatchingState_Close()
    PaGlobalFunc_RedBattleField_MatchingConfirm_Open()
  end
  if isConfirm == true then
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetEnable(false)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetMonoTone(true)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetIgnore(true)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetEnable(false)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetMonoTone(true)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetIgnore(true)
  else
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetEnable(true)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetMonoTone(false)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Confrim:SetIgnore(false)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetEnable(true)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetMonoTone(false)
    PaGlobal_RedBattleField_MatchConfirm._ui_pc._btn_Cancel:SetIgnore(false)
  end
end
function FromClient_RedBattleField_MatchingConfirm_UpdatePerFrame(deltaTime)
  local remainTime = ToClient_GetMatchRemainTime()
  if PaGlobal_RedBattleField_MatchConfirm._currentMaxCountDown ~= remainTime then
    PaGlobal_RedBattleField_MatchConfirm._currentMaxCountDown = remainTime
    PaGlobal_RedBattleField_MatchConfirm._ui._txt_Confirm:SetTextMode(__eTextMode_AutoWrap)
    PaGlobal_RedBattleField_MatchConfirm._ui._txt_Confirm:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_TIMELEFT", "time", tostring(PaGlobal_RedBattleField_MatchConfirm._currentMaxCountDown)))
  end
  if PaGlobal_RedBattleField_MatchConfirm._waitTime == toInt64(0, 0) then
    ToClient_RequestMatchTimeOut(__eInstanceContentsType_RedBattleField)
    Panel_LocalWar_Match_Confirm_All:ClearUpdateLuaFunc()
    return
  end
  local rate = Int64toInt32(remainTime) / Int64toInt32(PaGlobal_RedBattleField_MatchConfirm._waitTime) * 100
  PaGlobal_RedBattleField_MatchConfirm._ui._stc_ProgressBar:SetProgressRate(rate)
  if rate < 1 then
    ToClient_RequestMatchTimeOut(__eInstanceContentsType_RedBattleField)
    Panel_LocalWar_Match_Confirm_All:ClearUpdateLuaFunc()
  end
end
function PaGlobalFunc_RedBattleField_MatchingConfirm_Open()
  PaGlobal_RedBattleField_MatchConfirm:prepareOpen()
end
function PaGlobalFunc_RedBattleField_MatchingConfirm_Close()
  PaGlobal_RedBattleField_MatchConfirm:prepareClose()
end
function PaGlobalFunc_RedBattleField_MatchingConfirm_IsOpen()
  if Panel_LocalWar_Match_Confirm_All == nil then
    return false
  end
  return Panel_LocalWar_Match_Confirm_All:GetShow() == true
end
