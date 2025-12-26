function PaGlobal_FriendMessangerFloatingAlert_All:createMessanger(messangerIdstr)
  local miniMessanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiName = nil,
    _uiClose = nil,
    _uiCount = nil,
    _uiBig = nil,
    _uiRecentMessage = nil,
    _uiMessage = nil,
    _contentMessage = nil,
    _openRoomId = nil,
    _alertIndex = nil
  }
  function miniMessanger:initialize(messangerIdstr)
    miniMessanger:createPanel(messangerIdstr)
    miniMessanger:prepareControl(messangerIdstr)
  end
  function miniMessanger:clear()
    UI.deletePanel(miniMessanger._mainPanel:GetID())
    miniMessanger._mainPanel = nil
    miniMessanger._openRoomId = nil
    miniMessanger._alertIndex = nil
    for _, info in pairs(miniMessanger._uiMessage) do
      if nil ~= info.content then
        info.content:SetShow(false)
        UI.deleteControl(info.content)
      end
    end
  end
  function miniMessanger:createPanel(messangerIdstr)
    local newName = "Panel_FriendMiniMessangerAlert" .. messangerIdstr
    miniMessanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Widget_Friends_FloatingAlert, miniMessanger._mainPanel)
    miniMessanger._mainPanel:SetDragAll(true)
  end
  function miniMessanger:prepareControl(messangerIdstr)
    local titleBar = UI.getChildControl(Panel_Widget_Friends_FloatingAlert, "Static_Top")
    local recentMessage = UI.getChildControl(Panel_Widget_Friends_FloatingAlert, "Static_RecentMessage")
    miniMessanger._uiTitleBg = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_FloatingAlert, miniMessanger._mainPanel, "Static_Top", 0)
    miniMessanger._uiName = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Name", 0)
    miniMessanger._uiName:SetText(" ")
    miniMessanger._uiClose = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Close", 0)
    miniMessanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_CloseMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiCount = miniMessanger:createControl(__ePAUIControl_StaticText, titleBar, miniMessanger._uiTitleBg, "StaticText_Count", 0)
    miniMessanger._uiBig = miniMessanger:createControl(__ePAUIControl_Button, titleBar, miniMessanger._uiTitleBg, "Button_Big", 0)
    miniMessanger._uiRecentMessage = miniMessanger:createControl(__ePAUIControl_Static, Panel_Widget_Friends_FloatingAlert, miniMessanger._mainPanel, "Static_RecentMessage", 0)
    miniMessanger._uiMessage = {}
    miniMessanger._contentMessage = nil
    miniMessanger._uiTitleBg:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiRecentMessage:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiBig:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._uiCount:addInputEvent("Mouse_LUp", "FriendMessangerFloatingAlert_OpenMainMessanger(" .. messangerIdstr .. ")")
    miniMessanger._alertIndex = tonumber(messangerIdstr)
  end
  function miniMessanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  miniMessanger:initialize(messangerIdstr)
  return miniMessanger
end
function FriendMessangerFloatingAlert_Update(messangerIdstr, alertIndex, friendName, messageNone)
  local miniMessanger = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[alertIndex]
  if nil == miniMessanger then
    return
  end
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local message = messengerInfo:lastMessage()
  miniMessanger._uiName:SetText(" ")
  local messageCount = messengerInfo:getNoneReadMessageCount()
  if nil == message then
    miniMessanger._uiName:SetText(friendName)
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
    return
  end
  miniMessanger._uiName:SetText(friendName)
  for _, info in pairs(miniMessanger._uiMessage) do
    if nil ~= info.content then
      info.content:SetShow(false)
      UI.deleteControl(info.content)
    end
  end
  FriendMessangerFloatingAlert_UpdateMessage(miniMessanger, messangerIdstr, message)
  FriendMessangerFloatingAlert_SetPosMessageUI(miniMessanger)
  if messageCount > 0 then
    miniMessanger._uiCount:SetShow(true)
    miniMessanger._uiCount:SetText(tostring(messageCount))
    if messageCount >= 100 then
      miniMessanger._uiCount:SetText("99+")
    end
  else
    miniMessanger._uiCount:SetShow(false)
    miniMessanger._uiCount:SetText("0")
  end
  miniMessanger._openRoomId = messangerId_s64
end
function FriendMessangerFloatingAlert_OpenMessanger(messangerId, friendUserNo, message)
  if false == ToClient_RoadToggleEffectNotice() then
    return
  end
  local isMessangerOpen = FriendMessanger_IsOpenMessanger(messangerId)
  local isFriendListMessangerOpen = PaGlobalFunc_FriendInfoList_All_IsFriendInfoMessangerOpen(messangerId)
  if true == isMessangerOpen or true == isFriendListMessangerOpen then
    return
  end
  local messengerInfo = ToClient_GetMessengerInfo(messangerId)
  if nil == messengerInfo then
    return
  end
  if false == messengerInfo:getAlarmIsOn() then
    return
  end
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    if nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] then
      PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] = PaGlobal_FriendMessangerFloatingAlert_All:createMessanger(tostring(i))
    end
  end
  local messangerIdstr = tostring(messangerId)
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    if nil ~= PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] and nil ~= PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i]._openRoomId and PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i]._openRoomId == messangerId then
      FriendMessangerFloatingAlert_Update(messangerIdstr, i, friendInfo:getName(), message)
      return
    end
  end
  local messangerIndex
  for i = 0, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    if nil ~= PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i] and nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i]._openRoomId then
      messangerIndex = i
      break
    end
  end
  if nil == messangerIndex then
    messangerIndex = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1
  end
  for i = messangerIndex, 0, -1 do
    if 0 == messangerIndex then
      local control = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[0]
      FriendMessangerFloatingAlert_OpenAnimation(control._mainPanel, 0, 0.3, PaGlobal_FriendMessangerFloatingAlert_All._messangerPosY[0] + control._mainPanel:GetSizeY(), 0, control._mainPanel:GetSizeY())
    else
      FriendMessangerFloatingAlert_ChangeMessangerAlert(i, i - 1, true)
    end
  end
  FriendMessangerFloatingAlert_Update(messangerIdstr, 0, friendInfo:getName(), message)
end
function FriendMessangerFloatingAlert_CloseMessanger(alertIndexstr)
  local alertIndex = tonumber(alertIndexstr)
  local miniMessanger = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[alertIndex]
  if nil == miniMessanger then
    return
  end
  local isCheck = false
  for i = alertIndex, PaGlobal_FriendMessangerFloatingAlert_All._messangerAlertCount - 1 do
    local topAlertControl = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[i + 1]
    if nil ~= topAlertControl and nil ~= topAlertControl._openRoomId then
      FriendMessangerFloatingAlert_ChangeMessangerAlert(i, i + 1, false)
      topAlertControl._openRoomId = nil
      topAlertControl._mainPanel:SetShow(false)
      topAlertControl._mainPanel:SetSpanSize(0, -control:GetSizeY())
      isCheck = true
    end
  end
  if true == isCheck then
    return
  end
  ToClient_pushCloseMessageList(miniMessanger._openRoomId)
  miniMessanger._openRoomId = nil
  miniMessanger._mainPanel:SetShow(false)
  miniMessanger._mainPanel:SetSpanSize(0, -control:GetSizeY())
end
function FriendMessangerFloatingAlert_OpenMainMessanger(alertIndexstr)
  local alertIndex = tonumber(alertIndexstr)
  local miniMessanger = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[alertIndex]
  if nil == miniMessanger then
    return
  end
  local messangerIdstr = tostring(miniMessanger._openRoomId)
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(miniMessanger._openRoomId)
  FriendMessangerFloatingAlert_CloseMessanger(alertIndexstr)
  if toInt64(0, 0) ~= friendUserNo then
    PaGlobal_FriendInfoList_Show_All()
    FromClient_FriendInfoListOpenMessangerInFriendList(tonumber64(messangerIdstr))
    FromClient_FriendInfoList_All_FriendMessangerUpdate(tostring(messangerIdstr), true)
  end
  ToClient_pushCloseMessageList(miniMessanger._openRoomId)
end
function FriendMessangerFloatingAlert_OpenAnimation(control, startTime, endTime, startYPos, deltaX, deltaY)
  if nil == control or nil == startTime or nil == endTime or nil == deltaX or nil == deltaY then
    return
  end
  control:SetShow(true)
  control:ComputePos()
  local pos = {
    x = control:GetPosX(),
    y = control:GetPosY()
  }
  local moveAni = control:addMoveAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  moveAni:SetStartPosition(pos.x, startYPos)
  moveAni:SetEndPosition(pos.x, startYPos - deltaY)
end
function FriendMessangerFloatingAlert_ChangeMessangerAlert(targetIndex, index, isUp)
  if nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[targetIndex] or nil == PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[index] then
    return
  end
  local miniMessanger_1 = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[targetIndex]
  local miniMessanger_2 = PaGlobal_FriendMessangerFloatingAlert_All._messangerAlert[index]
  miniMessanger_1._uiCount:SetText(miniMessanger_2._uiCount:GetText())
  miniMessanger_1._uiName:SetText(miniMessanger_2._uiName:GetText())
  for _, info in pairs(miniMessanger_1._uiMessage) do
    if nil ~= info.content then
      info.content:SetShow(false)
      UI.deleteControl(info.content)
    end
  end
  FriendMessangerFloatingAlert_UpdateMessage(miniMessanger_1, tostring(miniMessanger_1._alertIndex), miniMessanger_2._contentMessage)
  FriendMessangerFloatingAlert_SetPosMessageUI(miniMessanger_1)
  miniMessanger_1._openRoomId = miniMessanger_2._openRoomId
  local deltaY = miniMessanger_2._mainPanel:GetSizeY()
  local startY = PaGlobal_FriendMessangerFloatingAlert_All._messangerPosY[index]
  if false == isUp then
    deltaY = -deltaY
  end
  FriendMessangerFloatingAlert_OpenAnimation(miniMessanger_1._mainPanel, 0, 0.3, startY, 0, deltaY)
end
function FromClient_FriendMessangerAlarmLoad(listSize)
  if nil == listSize then
    return
  end
  for i = 0, listSize - 1 do
    local alertInfo = ToClient_getMessengerAlertInfo(i)
    if nil ~= alertInfo then
      local messengerInfo = ToClient_GetMessengerInfo(alertInfo:getMessengerNo())
      if nil ~= messengerInfo then
        local message = messengerInfo:lastMessage()
        if nil ~= message then
          FriendMessangerFloatingAlert_OpenMessanger(alertInfo:getMessengerNo(), message:getUserNo(), message)
        end
      end
    end
  end
end
function FriendMessangerFloatingAlert_UpdateMessage(miniMessanger, messangerIdstr, chattingMessage)
  if nil == miniMessanger or nil == messangerIdstr or nil == chattingMessage then
    return
  end
  local msg = chattingMessage:getContent()
  local emoticonCount = chattingMessage:getEmoticonCount()
  local recentMessage = UI.getChildControl(Panel_Widget_Friends_Floating, "Static_RecentMessage")
  local styleText = UI.getChildControl(recentMessage, "StaticText_1")
  local styleEmoticon = UI.getChildControl(recentMessage, "Static_ChatEmoticon")
  miniMessanger._uiMessage = {}
  miniMessanger._contentMessage = chattingMessage
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
          checkmsg, msgData, msgDataLen = FriendMessangerFloatingAlert_GetTextLimitWidth(contentInfo.content, msgData)
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
      checkmsg, msgData, msgDataLen = FriendMessangerFloatingAlert_GetTextLimitWidth(contentInfo.content, msgData)
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
    checkmsg, msgData, msgDataLen = FriendMessangerFloatingAlert_GetTextLimitWidth(contentInfo.content, msgData)
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
function FriendMessangerFloatingAlert_GetTextLimitWidth(chatting_contents, msgOrigin)
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
function FriendMessangerFloatingAlert_SetPosMessageUI(miniMessanger)
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
