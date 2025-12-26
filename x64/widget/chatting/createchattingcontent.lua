local UI_color = Defines.Color
local UI_CT = CppEnums.ChatType
local UI_CNT = CppEnums.EChatNoticeType
local UI_Group = Defines.UIGroup
local IM = CppEnums.EProcessorInputMode
local UI_CST = CppEnums.ChatSystemType
local LinkedGuildCache
local GradeTypeCount = 5
local _EmoticonInfo = {}
local ChattingBlockType = {
  Normal = 0,
  Item = 1,
  Web = 2,
  Mention = 3,
  Guild = 4,
  MentalCard = 5,
  Party = 6,
  Quest = 7
}
function PaGlobalFunc_Chat_GetShowEmoticonInfo(panelIndex)
  return _EmoticonInfo[panelIndex]
end
function PaGlobalFunc_Chat_ResetEmoticonInfo(panelIndex)
  _EmoticonInfo[panelIndex] = nil
end
function ConvertFromItemGradeColor(nameColorGrade)
  if 0 == nameColorGrade then
    return 4293388263
  elseif 1 == nameColorGrade then
    return 4288921664
  elseif 2 == nameColorGrade then
    return 4283938018
  elseif 3 == nameColorGrade then
    return 4293904710
  elseif 4 == nameColorGrade then
    return 4294929482
  elseif 5 == nameColorGrade then
    return 4288704751
  else
    return UI_color.C_FFFFFFFF
  end
end
function Chatnew_CreateChattingContent(chattingMessage, poolCurrentUI, PosY, messageIndex, panelIndex, deltascrollPosy, cacheSimpleUI, chattingUpTime)
  local panelSizeX = poolCurrentUI._list_PanelBG[0]:GetSizeX() - 20
  local panelSizeY = poolCurrentUI._list_PanelBG[0]:GetSizeY()
  local nameType = chattingMessage.chatNameType
  local sender = chattingMessage:getSender(ToClient_getChatNameType())
  local chatType = chattingMessage.chatType
  local noticeType = chattingMessage.noticeType
  local isMe = chattingMessage.isMe
  local isGameManager = chattingMessage.isGameManager
  if true == _ContentsGroup_RenewUI_Chatting and nil ~= panelIndex then
    panelIndex = panelIndex - 1
  end
  local msgColor = Chatting_MessageColor(chatType, noticeType, panelIndex)
  local senderUserNo = chattingMessage:getUserNo()
  if PaGlobal_CreateChattingContent_IsEdanaType(chatType) == true and ToClient_IsEdana(senderUserNo) == true then
    msgColor = UI_color.C_FFfff330
  end
  local msg, msgData
  local isLinkedItem = chattingMessage:isLinkedItem()
  local isLinkedGuild = chattingMessage:isLinkedGuild()
  local isLinkedPartyRecruit = chattingMessage:isLinkedPartyRecruit()
  local isLinkedWebSite = chattingMessage:isLinkedWebsite()
  local isLinkedMentalCard = chattingMessage:isLinkedMentalCard()
  local isLinkedQuest = chattingMessage:isLinkedQuest()
  local chatting_Icon = poolCurrentUI:newChattingIcon()
  local chatting_GuildMark = poolCurrentUI:newChattingGuildMark()
  local chatting_sender = poolCurrentUI:newChattingSender(messageIndex)
  local isDev = ToClient_IsDevelopment()
  local chatting_contents = {}
  local chatSystemType = chattingMessage.chatSystemType
  local isChatDivision = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eChatDivision)
  local emoticonCount = chattingMessage:getEmoticonCount()
  local chattingatCount = chattingMessage:getChattingAtCount()
  local reciver = getSelfPlayer():getName()
  local itemGradeType = chattingMessage:getItemGradeType()
  local itemGradeColor = ConvertFromItemGradeColor(itemGradeType)
  local itemIconPath = chattingMessage:getIconPath()
  local mentalCardKey = chattingMessage:getMantalCardKey()
  if true == isGameManager and not isDev then
    msgColor = 4282515258
  end
  if nil == chatting_sender then
    return PosY
  end
  local deltaPosY = -chatting_sender:GetSizeY() * deltascrollPosy
  if 0 ~= chattingUpTime then
    deltaPosY = -chatting_sender:GetSizeY() + chatting_sender:GetSizeY() * chattingUpTime * 5
  end
  chatting_Icon:SetShow(true)
  if chatType == CppEnums.ChatType.Private and false == chattingMessage.isMe then
    ChatInput_SetLastWhispersUserId(sender)
    if 1 > Int64toInt32(getUtc64() - chattingMessage._time_s64) then
      local isSoundAlert = true
      if ChatInput_GetLastWhispersUserId() == sender then
        if getTickCount32() - ChatInput_GetLastWhispersTick() > 1000 then
          ChatInput_SetLastWhispersTick()
        else
          isSoundAlert = false
        end
      else
        ChatInput_SetLastWhispersTick()
      end
      if isSoundAlert and isPhotoMode() then
        audioPostEvent_SystemUi(8, 14)
        _AudioPostEvent_SystemUiForXBOX(8, 14)
      elseif not isSoundAlert or not isFocusInChatting() then
      end
    end
  end
  if UI_CT.System == chatType then
    sender = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_SYSTEM")
  elseif UI_CT.Notice == chatType then
    sender = PAGetString(Defines.StringSheet_GAME, "CHATTING_NOTICE")
  elseif UI_CT.Battle == chatType then
    sender = PAGetString(Defines.StringSheet_GAME, "CHATTING_BATTLE")
  end
  local senderStr = " [" .. sender .. "] : "
  if UI_CT.Private == chatType then
    if not isMe then
      senderStr = "\226\151\128 " .. senderStr
    elseif nameType == 0 then
      senderStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_NAMETYPE_0") .. senderStr
    elseif nameType == 1 then
      senderStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_NAMETYPE_1") .. senderStr
    end
  else
  end
  if nil ~= panelIndex and true == PaGlobal_CreateChattingContent_GetIsShowTimeString(panelIndex) or UI_CT.Private == chatType or UI_CT.System == chatType and UI_CST.Market == chatSystemType then
    msg = chattingMessage:getContent() .. " (" .. chattingMessage:getTimeString() .. ")"
  else
    msg = chattingMessage:getContent()
  end
  chatting_sender:SetText(senderStr)
  chatting_Icon:SetSize(chatting_sender:GetTextSizeY() * 2 + 5, chatting_sender:GetTextSizeY())
  UiPrivateChatType(chatType, chatting_Icon, msgColor, isChatDivision, sender, senderStr, poolCurrentUI, noticeType)
  chatting_Icon:ComputePos()
  local chat_contentAddPosX = 0
  if true == chatting_Icon:GetShow() then
    chat_contentAddPosX = 15
    chatting_sender:SetPosX(chatting_Icon:GetSizeX())
  else
    chat_contentAddPosX = 10
    chatting_sender:SetPosX(chat_contentAddPosX)
  end
  chatting_Icon:SetPosX(10)
  chatting_sender:SetTextHorizonRight()
  chatting_sender:SetAutoResize(true)
  chatting_sender:SetFontColor(msgColor)
  chatting_sender:SetText(senderStr)
  if UI_CT.System == chatType or UI_CT.Battle == chatType then
    chatting_sender:SetText(" ")
  end
  chatting_sender:SetSize(chatting_sender:GetTextSizeX(), chatting_sender:GetTextSizeY() - 4)
  chatting_sender:SetShow(true)
  local chat_contentPosX = 0
  if true == chatting_Icon:GetShow() then
    chat_contentPosX = 15
    chatting_sender:SetPosX(chatting_Icon:GetSizeX() + chat_contentPosX)
  else
    chat_contentPosX = 10
    chatting_sender:SetPosX(chat_contentPosX)
  end
  chatting_Icon:SetPosY()
  LinkedGuildCache = nil
  local guildMarkAdjY = 2
  local guildMarkSize = 0
  if true == isLinkedGuild then
    local guildMarkPureSize = chatting_sender:GetTextSizeY()
    local guildMarkMarginWidth = 8
    guildMarkSize = guildMarkPureSize + guildMarkMarginWidth
    chatting_GuildMark:SetShow(true)
    chatting_GuildMark:SetSize(guildMarkPureSize, guildMarkPureSize)
    chatting_GuildMark:SetPosX(chatting_sender:GetPosX() + chatting_sender:GetTextSizeX() + guildMarkMarginWidth / 2)
    local linkedGuildInfo = chattingMessage:getLinkedGuildInfo()
    local guildNo = linkedGuildInfo:getGuildNo()
    local isSet = setGuildTextureByGuildNo(guildNo, chatting_GuildMark)
    if false == isSet then
      chatting_GuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/BlankGuildMark.dds")
    end
    chatting_GuildMark:setRenderTexture(chatting_GuildMark:getBaseTexture())
  end
  local contentindex = 1
  local textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
  local textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
  local msgstartindex = 0
  local chattingatNum = 1
  local isChattingAt = false
  if 0 ~= chattingatCount then
    isChattingAt = true
  end
  local j = 1
  local isWhile = false
  local checkItemWebAt = ChattingBlockType.Normal
  local emoticonContentIndex = -1
  local chatEmoticon = {}
  if 0 ~= emoticonCount then
    local emoNum = 1
    while emoticonCount >= emoNum do
      local emoticonindex = chattingMessage:getEmoticonIndex(emoNum - 1)
      local emoticonKey = chattingMessage:getEmoticonKey(emoNum - 1)
      local isItemEmoticon = PaGlobalFunc_isItemEmticon(emoticonKey)
      if msgstartindex == emoticonindex then
        if true == isLinkedGuild and 3 == contentindex then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetShow(true)
          chatting_contents[contentindex]:SetIgnore(true)
          textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
          chatting_contents[contentindex]:SetSize(1, chatting_sender:GetSizeY())
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText("")
          chatting_contents[contentindex]:SetPosY(PosY - chatting_contents[contentindex]:GetSizeY() - deltaPosY)
          contentindex = contentindex + 1
        end
        if true == isItemEmoticon then
          emoticonContentIndex = contentindex
          chatting_contents[contentindex] = poolCurrentUI:newChattingEmoticon()
        else
          chatEmoticon[contentindex] = true
          local emoticonControl = poolCurrentUI:newChattingNewEmoticon()
          if nil == emoticonControl then
            break
          end
          chatting_contents[contentindex] = emoticonControl
        end
        if isItemEmoticon and nil ~= itemIconPath then
          if isLinkedMentalCard == false and isLinkedQuest == false then
            chatting_contents[contentindex]:ChangeTextureInfoNameAsync("Icon/" .. itemIconPath)
          else
            chatting_contents[contentindex]:ChangeTextureInfoNameAsync(itemIconPath)
          end
        elseif isItemEmoticon then
          chatting_contents[contentindex]:ChangeTextureInfoNameAsync(chattingMessage:getEmoticonPath(emoNum - 1))
          local startX = chattingMessage:getEmoticonUV(emoNum - 1).x
          local startY = chattingMessage:getEmoticonUV(emoNum - 1).y
          local sizeX = chattingMessage:getEmoticonSize(emoNum - 1).x
          local sizeY = chattingMessage:getEmoticonSize(emoNum - 1).y
          chatting_contents[contentindex]:getBaseTexture():setUV(startX, startY, startX + sizeX, startY + sizeY)
          chatting_contents[contentindex]:setRenderTexture(chatting_contents[contentindex]:getBaseTexture())
        else
          local emoticonIndex = poolCurrentUI:getCurrentEmoticonIndex()
          if false == chattingMessage:isShowEmoticon(panelIndex) then
            local tempInfo = {}
            tempInfo._panelIndex = panelIndex
            tempInfo._emoticonIndex = emoticonIndex
            tempInfo._key = tostring(emoticonKey)
            _EmoticonInfo[panelIndex] = tempInfo
            chattingMessage:setShowEmoticon(panelIndex, true)
          end
          chatting_contents[contentindex]:ChangeTextureInfoNameAsync(chattingMessage:getEmoticonPath(emoNum - 1))
          chatting_contents[contentindex]:addInputEvent("Mouse_On", "HandleOn_ChattingEmoticon(" .. panelIndex .. "," .. emoticonIndex .. "," .. tostring(emoticonKey) .. ", true)")
          chatting_contents[contentindex]:addInputEvent("Mouse_Out", "HandleOn_ChattingEmoticon(" .. panelIndex .. "," .. emoticonIndex .. "," .. tostring(emoticonKey) .. ", false)")
          chatting_contents[contentindex]:addInputEvent("Mouse_UpScroll", "Chatting_ScrollEvent( " .. panelIndex .. ", true )")
          chatting_contents[contentindex]:addInputEvent("Mouse_DownScroll", "Chatting_ScrollEvent( " .. panelIndex .. ", false )")
        end
        chatting_contents[contentindex]:SetShow(true)
        j = 1
        isWhile = false
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
        textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if textStaticSizeX <= 0 or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
        end
        if isItemEmoticon then
          chatting_contents[contentindex]:SetSize(chatting_sender:GetSizeY() + 4, chatting_sender:GetSizeY() + 4)
        else
          chatting_contents[contentindex]:SetSize(26, 26)
        end
        chatting_contents[contentindex]:SetPosX(textStaticPosX)
        emoNum = emoNum + 1
        contentindex = contentindex + 1
      elseif false == isChattingAt and false == isLinkedItem and false == isLinkedGuild and false == isLinkedWebSite and false == isLinkedMentalCard and false == isLinkedPartyRecruit and isLinkedQuest == false then
        local msgData = string.sub(msg, msgstartindex + 1, emoticonindex)
        local msgDataLen = string.len(msgData)
        local checkmsg = {}
        local ispreEmoticonIndex = contentindex
        while msgDataLen > 0 do
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
          chatting_contents[contentindex]:SetFontColor(msgColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetShow(true)
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
          j = 1
          isWhile = false
          while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
            isWhile = true
            textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
            textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
            if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
              break
            end
            j = j + 1
          end
          if 0 == textStaticSizeX or isWhile == false then
            textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
            textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
          end
          chatting_contents[contentindex]:SetSize(textStaticSizeX, chatting_sender:GetSizeY())
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          checkmsg = chatting_contents[contentindex]:GetTextLimitWidth(msgData)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText(checkmsg)
          chatting_contents[contentindex]:SetPosY(PosY - chatting_contents[contentindex]:GetSizeY() - deltaPosY)
          if string.len(checkmsg) < string.len(msgData) then
            local msgStr = string.sub(msgData, string.len(checkmsg) + 1, string.len(msgData))
            msgData = msgStr
            msgDataLen = string.len(msgData)
          else
            msgDataLen = 0
          end
          contentindex = contentindex + 1
        end
        if ispreEmoticonIndex ~= contentindex then
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), chatting_sender:GetSizeY())
        else
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), chatting_sender:GetSizeY())
        end
        msgstartindex = emoticonindex
      else
        checkItemWebAt = ChattingBlockType.Normal
        local drawstart = msgstartindex
        local drawend = emoticonindex
        checkItemWebAt, drawend, chattingatNum = getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
        if emoticonindex ~= drawend then
          drawend = drawend + 1
        end
        local msgData = string.sub(msg, msgstartindex + 1, drawend)
        local msgDataLen = string.len(msgData)
        local checkmsg = {}
        local ispreEmoticonIndex = contentindex
        local msgCheckSender = string.sub(msgData, 2, msgDataLen)
        if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and reciver ~= msgCheckSender then
          checkItemWebAt, drawend, chattingatNum = groupingChattingAt(chattingMessage, msg, checkItemWebAt, msgCheckSender, reciver, drawend, emoticonindex, chattingatNum, isChattingAt)
        end
        if emoticonindex + 1 == drawend then
          drawend = drawend - 1
        end
        msgData = string.sub(msg, msgstartindex + 1, drawend)
        msgDataLen = string.len(msgData)
        if checkItemWebAt == ChattingBlockType.Mention and chatType == CppEnums.ChatType.Private and chattingMessage.isMe == false then
          checkItemWebAt = ChattingBlockType.Normal
        end
        if UI_CT.Guild == chatType and checkItemWebAt == ChattingBlockType.Mention and chattingMessage:getIsChattingAtSound() == true then
          audioPostEvent_SystemUi(99, 1)
          _AudioPostEvent_SystemUiForXBOX(99, 1)
          chattingMessage:setIsChattingAtSound(false)
        end
        while msgDataLen > 0 do
          if checkItemWebAt == ChattingBlockType.Normal then
            chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
            if nil == chatting_contents[contentindex] then
              break
            end
            chatting_contents[contentindex]:SetFontColor(msgColor)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetShow(true)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Item then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedItem(messageIndex)
            if nil == chatting_contents[contentindex] then
              break
            end
            chatting_contents[contentindex]:SetFontColor(itemGradeColor)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Web then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedWebSite(messageIndex)
            if nil == chatting_contents[contentindex] then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FF00C0D7)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Mention then
            chatting_contents[contentindex] = poolCurrentUI:newChattingAt(messageIndex)
            if nil == chatting_contents[contentindex] then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FFF601FF)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
            isChattingAt = false
          elseif checkItemWebAt == ChattingBlockType.Guild then
            LinkedGuildCache = poolCurrentUI:newChattingLinkedGuild(messageIndex)
            chatting_contents[contentindex] = LinkedGuildCache
            if nil == chatting_contents[contentindex] then
              break
            end
            chatting_contents[contentindex]:SetFontColor(msgColor)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.MentalCard then
            chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
            if nil == chatting_contents[contentindex] then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FFFFFFFF)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:addInputEvent("Mouse_On", "PaGlobal_HandleOnOut_MentalCard(" .. contentindex .. ",true )")
            chatting_contents[contentindex]:addInputEvent("Mouse_Out", "PaGlobal_HandleOnOut_MentalCard(" .. contentindex .. ",false )")
            chatting_contents[contentindex]:addInputEvent("Mouse_LUp", "PaGlobal_HandleClicked_MentalCard(" .. chattingMessage:getMantalCardKey() .. ")")
            chatting_contents[contentindex]:SetShow(true)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Party then
            local LinkedPartyCache = poolCurrentUI:newChattingLinkedParty(messageIndex)
            if nil == LinkedPartyCache then
              break
            end
            chatting_contents[contentindex] = LinkedPartyCache
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FF97FFF8)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Quest then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedQuest(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FFF5BA3A)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          end
          local j = 1
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
          j = 1
          isWhile = false
          while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
            isWhile = true
            textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
            textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
            if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
              break
            end
            j = j + 1
          end
          if 0 == textStaticSizeX or isWhile == false then
            textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
            textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
          end
          chatting_contents[contentindex]:SetSize(textStaticSizeX, chatting_sender:GetSizeY())
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          checkmsg = chatting_contents[contentindex]:GetTextLimitWidth(msgData)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText(checkmsg)
          chatting_contents[contentindex]:SetPosY(PosY - chatting_contents[contentindex]:GetSizeY() - deltaPosY)
          if string.len(checkmsg) < string.len(msgData) then
            local msgStr = string.sub(msgData, string.len(checkmsg) + 1, string.len(msgData))
            msgData = msgStr
            msgDataLen = string.len(msgData)
          else
            msgDataLen = 0
          end
          contentindex = contentindex + 1
        end
        if nil ~= chatting_contents[contentindex - 1] then
          if ispreEmoticonIndex ~= contentindex then
            chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), chatting_sender:GetSizeY())
          else
            chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), chatting_sender:GetSizeY())
          end
        end
        msgstartindex = drawend
      end
    end
    chatting_contents, contentindex = CreateContentWithMsgLength(reciver, poolCurrentUI, chatType, chattingMessage, isChattingAt, isLinkedItem, isLinkedGuild, isLinkedWebSite, isLinkedMentalCard, isLinkedQuest, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, msgColor, msgstartindex, panelSizeX, chattingatNum, chattingatCount, messageIndex, itemGradeColor, isLinkedPartyRecruit)
    local isPrevContent = false
    for index = contentindex - 1, 1, -1 do
      if emoticonContentIndex > index then
        isPrevContent = true
      end
    end
    local nowLineImoticon = false
    local nowLineImoticonIdx = -1
    local nowLine = contentindex - 1
    for index = contentindex - 1, 1, -1 do
      if chatEmoticon[index] then
        nowLineImoticon = true
        nowLineImoticonIdx = index
      end
      if nowLineImoticon then
        local index2 = 1
        while nowLine >= index2 or index >= index2 do
          if chatEmoticon[index2] then
            local tempSize = (chatting_contents[nowLineImoticonIdx]:GetSizeY() - chatting_sender:GetSizeY()) / 2
            if true == isLinkedGuild then
              chatting_contents[index2]:SetPosY(PosY - chatting_contents[nowLineImoticonIdx]:GetSizeY() - tempSize - deltaPosY + 2)
            else
              chatting_contents[index2]:SetPosY(PosY - chatting_contents[nowLineImoticonIdx]:GetSizeY() - tempSize - deltaPosY)
            end
          else
            chatting_contents[index2]:SetPosY(PosY - chatting_contents[nowLineImoticonIdx]:GetSizeY() - deltaPosY + 2)
          end
          index2 = index2 + 1
        end
      else
        chatting_contents[index]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY)
      end
      chatting_contents[index]:SetShow(true)
      if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[index]:GetPosX() then
        if true == nowLineImoticon then
          if true == isLinkedGuild then
            PosY = PosY - chatting_contents[nowLineImoticonIdx]:GetSizeY() - 4
          else
            PosY = PosY - chatting_contents[nowLineImoticonIdx]:GetSizeY() - 2
          end
        else
          PosY = PosY - chatting_contents[index]:GetSizeY()
        end
        nowLine = index - 1
        nowLineImoticon = false
        if 1 ~= index then
          chatting_contents[index]:SetPosX(chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX)
        end
      end
    end
    if true == _ContentsGroup_UsePadSnapping then
      chatting_Icon:SetPosY(PosY - deltaPosY + 4)
    else
      chatting_Icon:SetPosY(PosY - deltaPosY)
    end
    chatting_sender:SetPosY(PosY - deltaPosY + 4)
    chatting_GuildMark:SetPosY(PosY - deltaPosY - guildMarkAdjY)
    PosY = PosY - 5
  else
    chatting_contents, contentindex = CreateContentWithMsgLength(reciver, poolCurrentUI, chatType, chattingMessage, isChattingAt, isLinkedItem, isLinkedGuild, isLinkedWebSite, isLinkedMentalCard, isLinkedQuest, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, msgColor, msgstartindex, panelSizeX, chattingatNum, chattingatCount, messageIndex, itemGradeColor, isLinkedPartyRecruit)
    for index = contentindex - 1, 1, -1 do
      chatting_contents[index]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY + 2)
      chatting_contents[index]:SetShow(true)
      if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[index]:GetPosX() then
        PosY = PosY - chatting_contents[index]:GetSizeY()
        if 1 ~= index then
          chatting_contents[index]:SetPosX(chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX)
        end
      end
    end
    if true == _ContentsGroup_UsePadSnapping then
      chatting_Icon:SetPosY(PosY - deltaPosY + 4)
    else
      chatting_Icon:SetPosY(PosY - deltaPosY)
    end
    chatting_sender:SetPosY(PosY - deltaPosY + 2)
    chatting_GuildMark:SetPosY(PosY - deltaPosY - guildMarkAdjY)
    PosY = PosY - 3
  end
  if UI_CT.System == chatType or UI_CT.Notice == chatType or isMe then
    if UI_CT.Channel == chatType then
      chatting_sender:SetIgnore(false)
    else
      chatting_sender:SetIgnore(true)
    end
  else
    chatting_sender:SetIgnore(false)
  end
  if UI_CT.Public == chatType then
    chatting_sender:SetOverFontColor(UI_color.C_FFC4BEBE)
  else
    chatting_sender:SetOverFontColor(UI_color.C_FFFFFFFF)
  end
  if 0 == emoticonCount and getEnableSimpleUI() then
    if cacheSimpleUI then
      chatting_sender:SetFontAlpha(1)
      for _, contents in ipairs(chatting_contents) do
        contents:SetFontAlpha(1)
      end
    else
      local alphaRate = math.pow(math.max(math.min(1 - (panelSizeY - PosY) / panelSizeY, 1), 0.01), 0.2)
      chatting_sender:SetFontAlpha(alphaRate)
      for _, contents in ipairs(chatting_contents) do
        contents:SetFontAlpha(alphaRate)
      end
    end
  end
  if nil ~= LinkedGuildCache then
    LinkedGuildCache:SetPosX(LinkedGuildCache:GetPosX() + guildMarkSize)
    LinkedGuildCache:SetFontColor(UI_color.C_FF84FFF5)
  end
  return PosY - 2
end
function UiPrivateChatType(chatType, chatting_Icon, msgColor, isChatDivision, sender, senderStr, poolCurrentUI, noticeType)
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingHistory_SetChatIcon(chatType, chatting_Icon)
    return
  end
  local chattingIconIdx = poolCurrentUI:getCurrentChattingIconIndex()
  if UI_CT.Private == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 0, 24, 54, 48)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.Notice == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 108, 0, 162, 24)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.System == chatType then
    local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 54, 72, 108, 96)
    chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
    chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
  elseif UI_CT.World == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 0, 72, 54, 96)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.Public == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 0, 0, 54, 24)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.Party == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 0, 48, 54, 72)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.Guild == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 108, 72, 162, 96)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.WorldWithItem == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 108, 24, 162, 48)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
      chatting_Icon:SetShow(false)
    end
  elseif UI_CT.Battle == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 0, 96, 54, 120)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  elseif UI_CT.LocalWar == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 108, 48, 162, 72)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  elseif UI_CT.RolePlay == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 54, 48, 108, 72)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  elseif UI_CT.Arsha == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 54, 0, 108, 24)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  elseif UI_CT.Team == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 54, 24, 108, 48)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  elseif UI_CT.Alliance == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 54, 96, 108, 120)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  end
end
function GetMessageFontColor(msg, color)
  local Message = msg
  if nil == color then
    local fontColor = ""
    while 0 < string.len(Message) do
      local startIdx, endIdx = string.find(Message, "<PAColor")
      if nil ~= startIdx and nil ~= endIdx then
        local tempIdx, destIdx = string.find(Message, "<PAOldColor>")
        if nil ~= tempIdx and nil ~= destIdx then
          Message = string.sub(Message, destIdx + 1, string.len(Message))
        else
          fontColor = string.sub(Message, startIdx, endIdx + 11)
          return fontColor
        end
      else
        return nil
      end
    end
    return nil
  else
    local startIdx, endIdx = string.find(Message, "<PAOldColor>")
    if nil ~= startIdx and nil ~= endIdx then
      Message = string.sub(Message, endIdx + 1, string.len(Message))
      return GetMessageFontColor(Message, nil)
    else
      return color
    end
  end
end
function CreateContentWithMsgLength(reciver, poolCurrentUI, chatType, chattingMessage, isChattingAt, isLinkedItem, isLinkedGuild, isLinkedWebSite, isLinkedMentalCard, isLinkedQuest, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, msgColor, msgstartindex, panelSizeX, chattingatNum, chattingatCount, messageIndex, itemGradeColor, isLinkedPartyRecruit)
  local j = 1
  local isWhile = false
  local textStaticSizeX = 0
  local textStaticPosX = 0
  local chat_contentAddPosX = 0
  if chatting_Icon:GetShow() then
    chat_contentAddPosX = 15
  else
    chat_contentAddPosX = 10
  end
  if true == ToClient_getUseHarfBuzz() then
    isChattingAt = false
  end
  while msgstartindex < string.len(msg) do
    if false == isChattingAt and false == isLinkedItem and false == isLinkedGuild and false == isLinkedWebSite and false == isLinkedMentalCard and false == isLinkedPartyRecruit and isLinkedQuest == false then
      local msgData = string.sub(msg, msgstartindex + 1, string.len(msg))
      local msgDataLen = string.len(msgData)
      local checkmsg = {}
      local ispreEmoticonIndex = contentindex
      local fontColor
      while msgDataLen > 0 do
        chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
        if nil == chatting_contents[contentindex] then
          break
        end
        chatting_contents[contentindex]:SetFontColor(msgColor)
        chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
        chatting_contents[contentindex]:SetShow(true)
        chatting_contents[contentindex]:SetIgnore(true)
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
        textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
        j = 1
        isWhile = false
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if 0 == textStaticSizeX or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
        end
        chatting_contents[contentindex]:SetSize(textStaticSizeX, chatting_sender:GetSizeY())
        chatting_contents[contentindex]:SetPosX(textStaticPosX)
        checkmsg = chatting_contents[contentindex]:GetTextLimitWidth(msgData)
        if isChangeFontSize() then
          chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
        end
        if true == ToClient_IsDevelopment() or true == isGameServiceTypeTurkey() then
          if true == ToClient_isApplyHarfBuzzByChatType(chatType) then
            chatting_contents[contentindex]:SetUseHarfBuzz(true)
          else
            chatting_contents[contentindex]:SetUseHarfBuzz(false)
          end
        else
          chatting_contents[contentindex]:SetUseHarfBuzz(false)
        end
        chatting_contents[contentindex]:SetText(checkmsg)
        if nil ~= fontColor then
          chatting_contents[contentindex]:SetText(string.format("%s%s", fontColor, checkmsg))
        else
          chatting_contents[contentindex]:SetText(checkmsg)
        end
        fontColor = GetMessageFontColor(checkmsg, fontColor)
        if string.len(checkmsg) < string.len(msgData) then
          local msgStr = string.sub(msgData, string.len(checkmsg) + 1, string.len(msgData))
          msgData = msgStr
          msgDataLen = string.len(msgData)
        else
          msgDataLen = 0
        end
        contentindex = contentindex + 1
      end
      if nil ~= chatting_contents[contentindex - 1] then
        if ispreEmoticonIndex ~= contentindex then
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), chatting_sender:GetSizeY())
        else
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), chatting_sender:GetSizeY())
        end
      end
      msgstartindex = string.len(msg)
    else
      checkItemWebAt = ChattingBlockType.Normal
      local drawstart = msgstartindex
      local drawend = string.len(msg)
      checkItemWebAt, drawend, chattingatNum = getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
      drawend = drawend + 1
      local msgData = string.sub(msg, msgstartindex + 1, drawend)
      local msgDataLen = string.len(msgData)
      local checkmsg = {}
      local ispreEmoticonIndex = contentindex
      local msgLen = string.len(msg)
      local msgCheckSender = string.sub(msgData, 2, msgDataLen)
      if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and reciver ~= msgCheckSender then
        checkItemWebAt, drawend, chattingatNum = groupingChattingAt(chattingMessage, msg, checkItemWebAt, msgCheckSender, reciver, drawend, msgLen, chattingatNum, isChattingAt)
      end
      msgData = string.sub(msg, msgstartindex + 1, drawend)
      msgDataLen = string.len(msgData)
      if checkItemWebAt == ChattingBlockType.Mention and chatType == CppEnums.ChatType.Private and chattingMessage.isMe == false then
        checkItemWebAt = ChattingBlockType.Normal
      end
      if UI_CT.Guild == chatType and checkItemWebAt == ChattingBlockType.Mention and chattingMessage:getIsChattingAtSound() == true then
        audioPostEvent_SystemUi(99, 1)
        _AudioPostEvent_SystemUiForXBOX(99, 1)
        chattingMessage:setIsChattingAtSound(false)
      end
      while msgDataLen > 0 do
        if checkItemWebAt == ChattingBlockType.Normal then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
          if nil == chatting_contents[contentindex] then
            break
          end
          chatting_contents[contentindex]:SetFontColor(msgColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetShow(true)
          chatting_contents[contentindex]:SetIgnore(true)
        elseif checkItemWebAt == ChattingBlockType.Item then
          chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedItem(messageIndex)
          if nil == chatting_contents[contentindex] then
            break
          end
          chatting_contents[contentindex]:SetFontColor(itemGradeColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Web then
          chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedWebSite(messageIndex)
          if nil == chatting_contents[contentindex] then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FF00C0D7)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Mention then
          chatting_contents[contentindex] = poolCurrentUI:newChattingAt(messageIndex)
          if nil == chatting_contents[contentindex] then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FFF601FF)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
          isChattingAt = false
        elseif checkItemWebAt == ChattingBlockType.Guild then
          LinkedGuildCache = poolCurrentUI:newChattingLinkedGuild(messageIndex)
          if nil == LinkedGuildCache then
            break
          end
          chatting_contents[contentindex] = LinkedGuildCache
          chatting_contents[contentindex]:SetFontColor(msgColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.MentalCard then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents(messageIndex)
          if nil == chatting_contents[contentindex] then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FFFFFFFF)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:addInputEvent("Mouse_On", "PaGlobal_HandleOnOut_MentalCard(" .. contentindex .. ",true )")
          chatting_contents[contentindex]:addInputEvent("Mouse_Out", "PaGlobal_HandleOnOut_MentalCard(" .. contentindex .. ",false )")
          chatting_contents[contentindex]:addInputEvent("Mouse_LUp", "PaGlobal_HandleClicked_MentalCard(" .. chattingMessage:getMantalCardKey() .. ")")
          chatting_contents[contentindex]:SetShow(true)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Party then
          local LinkedPartyCache = poolCurrentUI:newChattingLinkedParty(messageIndex)
          if nil == LinkedPartyCache then
            break
          end
          chatting_contents[contentindex] = LinkedPartyCache
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FF97FFF8)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Quest then
          chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedQuest(messageIndex)
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FF00C0D7)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        end
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
        textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
        j = 1
        isWhile = false
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if 0 == textStaticSizeX or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_Icon:GetSizeX() + chatting_sender:GetTextSizeX() + chat_contentAddPosX
        end
        chatting_contents[contentindex]:SetSize(textStaticSizeX, chatting_sender:GetSizeY())
        chatting_contents[contentindex]:SetPosX(textStaticPosX)
        checkmsg = chatting_contents[contentindex]:GetTextLimitWidth(msgData)
        if isChangeFontSize() then
          chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
        end
        chatting_contents[contentindex]:SetText(checkmsg)
        if string.len(checkmsg) < string.len(msgData) then
          local msgStr = string.sub(msgData, string.len(checkmsg) + 1, string.len(msgData))
          msgData = msgStr
          msgDataLen = string.len(msgData)
        else
          msgDataLen = 0
        end
        contentindex = contentindex + 1
      end
      if nil ~= chatting_contents[contentindex - 1] then
        if ispreEmoticonIndex ~= contentindex then
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), chatting_sender:GetSizeY())
        else
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), chatting_sender:GetSizeY())
        end
      end
      msgstartindex = drawend
    end
  end
  return chatting_contents, contentindex
end
function PaGlobal_HandleOnOut_MentalCard(index, isShow)
  if false == isShow then
    TooltipSimple_Hide()
  end
  if true == Panel_WorldMap:GetShow() then
    return
  end
  local control = PaGlobal_getChattingContentsByIndex(index)
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_MENTALCARD_TOOLTIP_NAME")
  local desc
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_HandleClicked_MentalCard(mentalCardKey)
  if false == _ContentsGroup_RenewUI_Knowledge then
    Panel_Knowledge_Show()
    Panel_Knowledge_SelectAnotherCard(mentalCardKey, true)
  else
    PaGlobalFunc_Window_Knowledge_Show()
  end
end
function PaGlobal_CreateChattingContent_GetIsShowTimeString(index)
  if nil == index then
    return
  end
  local chatPanel = ToClient_getChattingPanel(index)
  if nil == chatPanel then
    _PA_ASSERT(false, "\236\151\134\235\138\148 \235\178\136\237\152\184\236\157\152 \236\177\132\237\140\133 \237\140\168\235\132\144\236\158\133\235\139\136\235\139\164.(" .. tostring(index) .. ")")
    return false
  end
  return chatPanel:getIsShowTimeString()
end
function getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
  local isLinkedItem = chattingMessage:isLinkedItem()
  local isLinkedGuild = chattingMessage:isLinkedGuild()
  local isLinkedPartyRecruit = chattingMessage:isLinkedPartyRecruit()
  local isLinkedWebSite = chattingMessage:isLinkedWebsite()
  local isLinkedMentalCard = chattingMessage:isLinkedMentalCard()
  local isLinkedQuest = chattingMessage:isLinkedQuest()
  local chattingatCount = chattingMessage:getChattingAtCount()
  local atStart = chattingMessage:getChattingAtStartIndex(chattingatNum - 1)
  local atEnd = chattingMessage:getChattingAtEndIndex(chattingatNum - 1)
  local checkFinishItemWebSite = false
  if isLinkedItem == true then
    checkFinishItemWebSite = true
  end
  if isLinkedGuild == true then
    checkFinishItemWebSite = true
  end
  if isLinkedWebSite == true then
    checkFinishItemWebSite = true
  end
  if isLinkedPartyRecruit == true then
    checkFinishItemWebSite = true
  end
  if isLinkedQuest == true then
    checkFinishItemWebSite = true
  end
  local checkItemWebAt = ChattingBlockType.Normal
  if isLinkedItem == true then
    local LinkeditemStart = chattingMessage:getLinkedItemStartIndex()
    local LinkeditemEnd = chattingMessage:getLinkedItemEndIndex()
    if isChattingAt == true and chattingatNum <= chattingatCount then
      if atStart > LinkeditemStart and checkFinishItemWebSite == true then
        checkItemWebAt = ChattingBlockType.Item
      else
        checkItemWebAt = ChattingBlockType.Mention
      end
    else
      checkItemWebAt = ChattingBlockType.Item
    end
    if checkItemWebAt == ChattingBlockType.Item then
      if drawstart <= LinkeditemStart and drawend >= LinkeditemEnd then
        if drawstart == LinkeditemStart then
          drawend = LinkeditemEnd - 1
          checkFinishItemWebSite = false
        else
          drawend = LinkeditemStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    elseif checkItemWebAt == ChattingBlockType.Mention then
      if drawstart <= atStart and atEnd <= drawend then
        if drawstart == atStart then
          drawend = atEnd - 1
          chattingatNum = chattingatNum + 1
        else
          drawend = atStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    end
  elseif isLinkedGuild == true then
    local LinkedguildStart = chattingMessage:getLinkedGuildStartIndex()
    local LinkedguildEnd = chattingMessage:getLinkedGuildEndIndex()
    if isChattingAt == true and chattingatCount >= chattingatNum then
      if atStart > LinkedguildStart and checkFinishItemWebSite == true then
        checkItemWebAt = ChattingBlockType.Guild
      else
        checkItemWebAt = ChattingBlockType.Mention
      end
    else
      checkItemWebAt = ChattingBlockType.Guild
    end
    if checkItemWebAt == ChattingBlockType.Guild then
      if drawstart <= LinkedguildStart and drawend >= LinkedguildEnd then
        if drawstart == LinkedguildStart then
          drawend = LinkedguildEnd - 1
          checkFinishItemWebSite = false
        else
          drawend = LinkedguildStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    elseif checkItemWebAt == ChattingBlockType.Mention then
      if drawstart <= atStart and atEnd <= drawend then
        if drawstart == atStart then
          drawend = atEnd - 1
          chattingatNum = chattingatNum + 1
        else
          drawend = atStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    end
  elseif isLinkedWebSite then
    local LinkedwebStart = chattingMessage:getLinkedWebsiteStartIndex()
    local LinkedwebEnd = chattingMessage:getLinkedWebsiteEndIndex()
    if isChattingAt == true and chattingatCount >= chattingatNum then
      if atStart > LinkedwebStart and checkFinishItemWebSite == true then
        checkItemWebAt = ChattingBlockType.Web
      else
        checkItemWebAt = ChattingBlockType.Mention
      end
    else
      checkItemWebAt = ChattingBlockType.Web
    end
    if checkItemWebAt == ChattingBlockType.Web then
      if drawstart <= LinkedwebStart and drawend >= LinkedwebEnd then
        if drawstart == LinkedwebStart then
          drawend = LinkedwebEnd - 1
          checkFinishItemWebSite = false
        else
          drawend = LinkedwebStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    elseif checkItemWebAt == ChattingBlockType.Mention then
      if drawstart <= atStart and atEnd <= drawend then
        if drawstart == atStart then
          drawend = atEnd - 1
          chattingatNum = chattingatNum + 1
        else
          drawend = atStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    end
  elseif isChattingAt == true and chattingatCount >= chattingatNum then
    if drawstart <= atStart and atEnd <= drawend then
      if drawstart == atStart then
        drawend = atEnd - 1
        checkItemWebAt = ChattingBlockType.Mention
        chattingatNum = chattingatNum + 1
      else
        drawend = atStart - 1
        checkItemWebAt = ChattingBlockType.Normal
      end
    else
      checkItemWebAt = ChattingBlockType.Normal
    end
  elseif isLinkedMentalCard then
    checkItemWebAt = ChattingBlockType.MentalCard
  elseif isLinkedPartyRecruit == true then
    local LinkedPartyStart = chattingMessage:getLinkedPartyRecruitStartIndex()
    local LinkedPartyEnd = chattingMessage:getLinkedPartyRecruitEndIndex()
    if isChattingAt == true and chattingatCount >= chattingatNum then
      if atStart > LinkedPartyStart and checkFinishItemWebSite == true then
        checkItemWebAt = ChattingBlockType.Party
      else
        checkItemWebAt = ChattingBlockType.Mention
      end
    else
      checkItemWebAt = ChattingBlockType.Party
    end
    if checkItemWebAt == ChattingBlockType.Party then
      if drawstart <= LinkedPartyStart and drawend >= LinkedPartyEnd then
        if drawstart == LinkedPartyStart then
          drawend = LinkedPartyEnd - 1
          checkFinishItemWebSite = false
        else
          drawend = LinkedPartyStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    elseif checkItemWebAt == ChattingBlockType.Mention then
      if drawstart <= atStart and atEnd <= drawend then
        if drawstart == atStart then
          drawend = atEnd - 1
          chattingatNum = chattingatNum + 1
        else
          drawend = atStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    end
  elseif isLinkedQuest == true then
    local linkedQuestStart = chattingMessage:getLinkedQuestStartIndex()
    local linkedQuestEnd = chattingMessage:getLinkedQuestEndIndex()
    if isChattingAt == true and chattingatCount >= chattingatNum then
      if atStart > linkedQuestStart and checkFinishItemWebSite == true then
        checkItemWebAt = ChattingBlockType.Quest
      else
        checkItemWebAt = ChattingBlockType.Mention
      end
    else
      checkItemWebAt = ChattingBlockType.Quest
    end
    if checkItemWebAt == ChattingBlockType.Quest then
      if drawstart <= linkedQuestStart and drawend >= linkedQuestEnd then
        if drawstart == linkedQuestStart then
          drawend = linkedQuestEnd - 1
          checkFinishItemWebSite = false
        else
          drawend = linkedQuestStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    elseif checkItemWebAt == ChattingBlockType.Mention then
      if drawstart <= atStart and atEnd <= drawend then
        if drawstart == atStart then
          drawend = atEnd - 1
          chattingatNum = chattingatNum + 1
        else
          drawend = atStart - 1
          checkItemWebAt = ChattingBlockType.Normal
        end
      else
        checkItemWebAt = ChattingBlockType.Normal
      end
    end
  end
  if checkItemWebAt == ChattingBlockType.Mention and chattingMessage.isMe == true then
    checkItemWebAt = ChattingBlockType.Normal
  end
  return checkItemWebAt, drawend, chattingatNum
end
function groupingChattingAt(chattingMessage, messageContent, checkItemWebAt, msgCheckSender, reciver, drawend, msgEnd, chattingatNum, isChattingAt)
  while checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciver do
    local drawStartTemp = drawend
    local drawEndTemp = msgEnd
    local chattingatNumTemp = chattingatNum
    checkItemWebAt, drawEndTemp, chattingatNumTemp = getCheckItemWebAt(chattingMessage, chattingatNumTemp, drawStartTemp, drawEndTemp, isChattingAt)
    drawEndTemp = drawEndTemp + 1
    local msgDataTemp = string.sub(messageContent, drawStartTemp + 1, drawEndTemp)
    local msgDataLenTemp = string.len(msgDataTemp)
    msgCheckSender = string.sub(msgDataTemp, 2, msgDataLenTemp)
    if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciver then
      drawend = drawEndTemp
      chattingatNum = chattingatNumTemp
      if msgEnd <= drawend then
        checkItemWebAt = ChattingBlockType.Normal
        break
      end
    else
      checkItemWebAt = ChattingBlockType.Normal
      break
    end
  end
  return checkItemWebAt, drawend, chattingatNum
end
function PaGlobal_CreateChattingContent_IsEdanaType(chatType)
  if chatType == UI_CT.World or chatType == UI_CT.Public or chatType == UI_CT.WorldWithItem then
    return true
  end
  return false
end
