function PaGlobalFunc_ChattingColor_All_Open(panelIndex, chatType, buttonType, isSystem)
  PaGlobal_ChattingColor_All._panelIndex = panelIndex
  PaGlobal_ChattingColor_All._chatType = chatType
  PaGlobal_ChattingColor_All._buttonType = buttonType
  PaGlobal_ChattingColor_All._isSystem = isSystem
  PaGlobal_ChattingColor_All:prepareOpen()
end
function PaGlobalFunc_ChattingColor_All_Close()
  PaGlobal_ChattingColor_All:prepareClose()
end
function HandleEventLUp_ChattingColor_All_Close()
  PaGlobalFunc_ChattingColor_All_Close()
end
function HandleEventLUp_ChattingColor_All_SelectColor(index)
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  PaGlobal_ChattingColor_All._savedColorIndex = index
end
function HandleEventLUp_ChattingColor_All_ConfirmColor()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  local self = PaGlobal_ChattingColor_All
  if nil == self._panelIndex or nil == self._chatType or nil == self._buttonType or nil == self._isSystem then
    return
  end
  if nil == self._savedColorIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_COLOR_NOSELECTCOLOR"))
    return
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  if self._isSystem then
    chatPanel:setChatSystemColorIndex(self._chatType, self._savedColorIndex)
  else
    chatPanel:setChatColor(self._chatType, self._savedColorIndex)
  end
  PaGlobalFunc_ChatOption_All_SettingColor(self._savedColorIndex, self._buttonType, self._panelIndex, self._isSystem)
  PaGlobalFunc_ChattingColor_All_Close()
end
function FromClient_ChattingColor_All_Resize()
  if nil == Panel_Window_Chatting_Color_All then
    return
  end
  PaGlobal_ChattingColor_All:resize()
end
