function PaGlobal_FriendMessangerFloating_All:createMessanger(messangerIdstr, userName, friendUserNo)
  local miniMessanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiName = nil,
    _uiClose = nil,
    _uiCount = nil,
    _uiBig = nil,
    _uiRecentMessage = nil,
    _uiMessage = nil,
    _friendUserNo = nil
  }
  function miniMessanger:initialize(messangerIdstr, userName, friendUserNo)
    miniMessanger:createPanel(messangerIdstr)
    miniMessanger:prepareControl(messangerIdstr, userName)
    miniMessanger._friendUserNo = friendUserNo
  end
  function miniMessanger:clear()
    UI.deletePanel(miniMessanger._mainPanel:GetID())
    miniMessanger._mainPanel = nil
    miniMessanger._friendUserNo = nil
    for _, info in pairs(miniMessanger._uiMessage) do
      if nil ~= info.content then
        info.content:SetShow(false)
        UI.deleteControl(info.content)
      end
    end
  end
  function miniMessanger:createPanel(messangerIdstr)
    local newName = "Panel_FriendMiniMessanger" .. messangerIdstr
    miniMessanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Widget_Friends_Floating, miniMessanger._mainPanel)
    miniMessanger._mainPanel:SetDragAll(true)
    miniMessanger._mainPanel:SetShow(true)
  end
  function miniMessanger:prepareControl(messangerIdstr, userName)
    local titleBar = UI.getChildControl(Panel_Widget_Friends_Floating, "Static_Top")
    local recentMessage = UI.getChildControl(Panel_Widget_Friends_Floating, "Static_RecentMessage")
    miniMessanger._uiTitleBg = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_Floating, miniMessanger._mainPanel, "Static_Top", 0)
    miniMessanger._uiName = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Name", 0)
    miniMessanger._uiName:SetText(userName)
    miniMessanger._uiClose = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Close", 0)
    miniMessanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessangerFloating_CloseMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiCount = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Count", 0)
    miniMessanger._uiBig = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Big", 0)
    miniMessanger._uiBig:addInputEvent("Mouse_LUp", "FriendMessangerFloating_OpenBigMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiRecentMessage = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_Floating, miniMessanger._mainPanel, "Static_RecentMessage", 0)
    miniMessanger._uiMessage = {}
  end
  function miniMessanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  miniMessanger:initialize(messangerIdstr, userName, friendUserNo)
  return miniMessanger
end
function FriendMessangerFloating_Update(messangerIdstr)
  local miniMessanger = PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr]
  if nil == miniMessanger then
    return
  end
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local message = messengerInfo:lastMessage()
  local messageCount = messengerInfo:getNoneReadMessageCount()
  if nil == message or "" == message then
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
    return
  end
  for _, info in pairs(miniMessanger._uiMessage) do
    if nil ~= info.content then
      info.content:SetShow(false)
      UI.deleteControl(info.content)
    end
  end
  FriendMessangerFloating_UpdateMessage(miniMessanger, messangerIdstr, message)
  FriendMessangerFloating_SetPosMessageUI(miniMessanger)
  if messageCount > 0 then
    miniMessanger._uiCount:SetShow(true)
    miniMessanger._uiCount:SetText(tostring(messageCount))
  else
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
  end
end
function FriendMessangerFloating_OpenMessanger(messangerId, friendUserNo)
  local messangerIdstr = tostring(messangerId)
  local friendUserNostr = tostring(friendUserNo)
  FriendMessanger_Close(messangerIdstr)
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local userName = friendInfo:getName()
  if nil == PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] then
    PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] = PaGlobal_FriendMessangerFloating_All:createMessanger(messangerIdstr, userName, tonumber64(friendUserNostr))
  end
  FriendMessangerFloating_Update(messangerIdstr)
end
function FriendMessangerFloating_CloseMessanger(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local miniMessanger = PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr]
  if nil == miniMessanger then
    return
  end
  miniMessanger._mainPanel:SetShow(false)
  miniMessanger:clear()
  PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] = nil
end
function FriendMessangerFloating_OpenBigMessanger(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local miniMessanger = PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr]
  if nil == miniMessanger then
    return
  end
  local friendUserNo = miniMessanger._friendUserNo
  miniMessanger._mainPanel:SetShow(false)
  miniMessanger:clear()
  PaGlobal_FriendMessangerFloating_All._messangerList[messangerIdstr] = nil
  FromClient_FriendInfoListOpenMessanger(messangerIdstr, friendUserNo)
  FromClient_FriendInfoList_All_FriendMessangerUpdate(tostring(messangerIdstr), true)
end
function FromClient_FriendMessangerFloatingUpdate(messangerId)
  local messangerIdstr = tostring(messangerId)
  FriendMessangerFloating_Update(messangerIdstr)
end
function FriendMessangerFloating_UpdateMessage(miniMessanger, messangerIdstr, chattingMessage)
  if nil == miniMessanger or nil == messangerIdstr or nil == chattingMessage then
    return
  end
  local msg = chattingMessage:getContent()
  local emoticonCount = chattingMessage:getEmoticonCount()
  local recentMessage = UI.getChildControl(Panel_Widget_Friends_Floating, "Static_RecentMessage")
  local styleText = UI.getChildControl(recentMessage, "StaticText_1")
  local styleEmoticon = UI.getChildControl(recentMessage, "Static_ChatEmoticon")
  miniMessanger._uiMessage = {}
  local contentindex = 0
  local msgstartindex = 0
  local textSizeX = miniMessanger._uiRecentMessage:GetSizeX() - 100
  local curTextSizeX = 0
  if 0 ~= emoticonCount then
    local emoNum = 1
    local isLimitText = false
    while emoticonCount >= emoNum do
      local emoticonindex = chattingMessage:getEmoticonIndex(emoNum - 1)
      local emoticonKey = chattingMessage:getEmoticonKey(emoNum - 1)
      local contentInfo = {}
      contentInfo.content = nil
      contentInfo.isEmoticon = false
      contentInfo.emoticonKey = 0
      contentInfo.contentCount = 0
      if true == isLimitText then
        break
      end
      if msgstartindex == emoticonindex then
        local emoticonControl = UI.createControl(__ePAUIControl_Static, miniMessanger._uiRecentMessage, "Static_Emo_" .. messangerIdstr .. "_" .. contentindex)
        CopyBaseProperty(styleEmoticon, emoticonControl)
        emoticonControl:SetShow(true)
        emoticonControl:ChangeTextureInfoNameAsync(chattingMessage:getEmoticonPath(emoNum - 1))
        contentInfo.content = emoticonControl
        contentInfo.isEmoticon = true
        contentInfo.emoticonKey = emoticonKey
        miniMessanger._uiMessage[contentindex] = contentInfo
        emoNum = emoNum + 1
        contentindex = contentindex + 1
        curTextSizeX = curTextSizeX + contentInfo.content:GetSizeX()
        if textSizeX - curTextSizeX < 15 then
          isLimitText = true
        end
      else
        local msgData = string.sub(msg, msgstartindex + 1, emoticonindex)
        local msgDataLen = string.len(msgData)
        local checkmsg = ""
        while msgDataLen > 0 do
          local contentInfo = {}
          contentInfo.content = nil
          contentInfo.isEmoticon = false
          contentInfo.emoticonKey = 0
          local textControl = UI.createControl(__ePAUIControl_StaticText, miniMessanger._uiRecentMessage, "Static_Text_" .. messangerIdstr .. "_" .. contentindex)
          CopyBaseProperty(styleText, textControl)
          textControl:SetShow(true)
          contentInfo.content = textControl
          contentInfo.isEmoticon = false
          contentInfo.emoticonKey = 0
          if textSizeX - curTextSizeX > 15 then
            contentInfo.content:SetSize(textSizeX - curTextSizeX, textControl:GetSizeY())
          else
            curTextSizeX = 0
          end
          checkmsg, msgData, msgDataLen = FriendMessangerFloating_GetTextLimitWidth(contentInfo.content, msgData)
          contentInfo.content:SetText(checkmsg)
          miniMessanger._uiMessage[contentindex] = contentInfo
          contentindex = contentindex + 1
          curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
          if "" == checkmsg or nil == checkmsg then
            break
          end
          if msgDataLen > 0 then
            isLimitText = true
            break
          end
        end
        msgstartindex = emoticonindex
      end
    end
    local msgData = string.sub(msg, msgstartindex + 1, string.len(msg))
    local msgDataLen = string.len(msgData)
    local checkmsg = ""
    if false == isLimitText then
      local contentInfo = {}
      contentInfo.content = nil
      contentInfo.isEmoticon = false
      contentInfo.emoticonKey = 0
      local textControl = UI.createControl(__ePAUIControl_StaticText, miniMessanger._uiRecentMessage, "Static_Text_" .. messangerIdstr .. "_" .. contentindex)
      CopyBaseProperty(styleText, textControl)
      textControl:SetShow(true)
      contentInfo.content = textControl
      contentInfo.isEmoticon = false
      contentInfo.emoticonKey = 0
      if textSizeX - curTextSizeX > 15 then
        contentInfo.content:SetSize(textSizeX - curTextSizeX, textControl:GetSizeY())
      else
        curTextSizeX = 0
      end
      checkmsg, msgData, msgDataLen = FriendMessangerFloating_GetTextLimitWidth(contentInfo.content, msgData)
      if msgDataLen > 0 then
        checkmsg = checkmsg .. "..."
      end
      contentInfo.content:SetText(checkmsg)
      miniMessanger._uiMessage[contentindex] = contentInfo
      contentindex = contentindex + 1
      curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
    else
      local contentInfo = {}
      contentInfo.content = nil
      contentInfo.isEmoticon = false
      contentInfo.emoticonKey = 0
      local textControl = UI.createControl(__ePAUIControl_StaticText, miniMessanger._uiRecentMessage, "Static_Text_" .. messangerIdstr .. "_" .. contentindex)
      CopyBaseProperty(styleText, textControl)
      textControl:SetShow(true)
      contentInfo.content = textControl
      contentInfo.isEmoticon = false
      contentInfo.emoticonKey = 0
      contentInfo.content:SetText("...")
      miniMessanger._uiMessage[contentindex] = contentInfo
      contentindex = contentindex + 1
      curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
    end
    msgstartindex = string.len(msg)
  else
    local msgData = string.sub(msg, msgstartindex + 1, string.len(msg))
    local msgDataLen = string.len(msgData)
    local checkmsg = ""
    local contentInfo = {}
    contentInfo.content = nil
    contentInfo.isEmoticon = false
    contentInfo.emoticonKey = 0
    local textControl = UI.createControl(__ePAUIControl_StaticText, miniMessanger._uiRecentMessage, "Static_Text_" .. messangerIdstr .. "_" .. contentindex)
    CopyBaseProperty(styleText, textControl)
    textControl:SetShow(true)
    contentInfo.content = textControl
    contentInfo.isEmoticon = false
    contentInfo.emoticonKey = 0
    if textSizeX - curTextSizeX > 15 then
      contentInfo.content:SetSize(textSizeX - curTextSizeX, textControl:GetSizeY())
    else
      curTextSizeX = 0
    end
    checkmsg, msgData, msgDataLen = FriendMessangerFloating_GetTextLimitWidth(contentInfo.content, msgData)
    if msgDataLen > 0 then
      checkmsg = checkmsg .. "..."
    end
    contentInfo.content:SetText(checkmsg)
    contentInfo.content:SetSize(textControl:GetTextSizeX(), textControl:GetSizeY())
    miniMessanger._uiMessage[contentindex] = contentInfo
    contentindex = contentindex + 1
    curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
    msgstartindex = string.len(msg)
  end
end
function FriendMessangerFloating_GetTextLimitWidth(chatting_contents, msgOrigin)
  if nil == chatting_contents or nil == msgOrigin then
    return
  end
  local msg = chatting_contents:GetTextLimitWidth(msgOrigin)
  if string.len(msg) < string.len(msgOrigin) then
    local msgStr = string.sub(msgOrigin, string.len(msg) + 1, string.len(msgOrigin))
    local msgLen = string.len(msgStr)
    return msg, msgStr, msgLen
  end
  return msg, msgOrigin, 0
end
function FriendMessangerFloating_SetPosMessageUI(miniMessanger)
  local contentStartPosX = miniMessanger._uiRecentMessage:GetPosX() + 15
  local curTextSizeX = 0
  local index = 0
  local staticText = miniMessanger._uiMessage
  while true do
    if nil == staticText[index] then
      break
    end
    local info = staticText[index]
    if nil ~= info.content then
      info.content:SetPosX(contentStartPosX + curTextSizeX)
      if false == info.isEmoticon then
        curTextSizeX = curTextSizeX + info.content:GetTextSizeX()
      else
        curTextSizeX = curTextSizeX + info.content:GetSizeX()
      end
      index = index + 1
    end
  end
end
