PaGlobal_NakMsgSequence = {
  _stc_bg = nil,
  _stc_txt = nil,
  _isConsole = false,
  _initialize = false,
  _showTime = 0
}
registerEvent("FromClient_luaLoadComplete", "FromClient_NakMsgSequence_Init")
function FromClient_NakMsgSequence_Init()
  PaGlobal_NakMsgSequence:initialize()
end
function PaGlobal_NakMsgSequence:initialize()
  if nil == Panel_NakMessage_Sequence then
    return
  end
  self._stc_bg = UI.getChildControl(Panel_NakMessage_Sequence, "Static_Desc_BG")
  self._stc_txt = UI.getChildControl(self._stc_bg, "MultilineText_Desc_3")
  Panel_NakMessage_Sequence:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_NakMessage_Sequence:ComputePosAllChild()
  registerEvent("FromClient_NoticeHasPartyForPlaySequence", "FromClient_NoticeHasPartyForPlaySequence")
  registerEvent("FromClient_NoticeRideOffForPlaySequence", "FromClient_NoticeRideOffForPlaySequence")
  registerEvent("FromClient_NoticeDontAcceptQuestSequence", "FromClient_NoticeDontAcceptQuestSequence")
  self._initialize = true
end
function PaGlobal_NakMsgSequence:open()
  Panel_NakMessage_Sequence:SetShow(true)
end
function PaGlobal_NakMsgSequence:close()
  Panel_NakMessage_Sequence:SetShow(false)
end
function FromClient_NoticeHasPartyForPlaySequence(sec)
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_PARTYSTATE_ALERT_FORSEQUENCE")
  PaGlobal_NakMsgSequence:setNakMessage(msg, sec)
end
function FromClient_NoticeDontAcceptQuestSequence(sec)
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_SEQUENCE_MSG")
  PaGlobal_NakMsgSequence:setNakMessage(msg, sec)
end
function FromClient_NoticeRideOffForPlaySequence(sec)
  local msg = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NAK_SEQUENCE_MSG")
  PaGlobal_NakMsgSequence:setNakMessage(msg, sec)
end
function PaGlobal_NakMsgSequence:setNakMessage(msg, sec)
  if nil == Panel_NakMessage_Sequence then
    return
  end
  local settedTime = sec
  if settedTime > 0 then
    settedTime = settedTime + 1
  end
  self._showTime = settedTime
  self._stc_txt:SetText(tostring(msg))
end
function PaGlobalFunc_NakMsgSequence_UpdateFunc(deltaTime)
  if nil == Panel_NakMessage_Sequence then
    return
  end
  if PaGlobal_NakMsgSequence._showTime <= 0 then
    if true == Panel_NakMessage_Sequence:GetShow() then
      PaGlobal_NakMsgSequence._showTime = 0
      PaGlobal_NakMsgSequence:close()
      return
    end
  else
    PaGlobal_NakMsgSequence._showTime = PaGlobal_NakMsgSequence._showTime - deltaTime
    if false == Panel_NakMessage_Sequence:GetShow() then
      PaGlobal_NakMsgSequence:open()
    end
  end
end
