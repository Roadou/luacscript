local UI_color = Defines.Color
local UI_CT = CppEnums.ChatType
local UI_CST = CppEnums.ChatSystemType
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
function PaGlobal_ChatMain:getShowEmoticonInfo(panelIndex)
  return PaGlobal_ChatMain._emoticonInfo[panelIndex]
end
function PaGlobal_ChatMain:resetEmoticonInfo(panelIndex)
  PaGlobal_ChatMain._emoticonInfo[panelIndex] = nil
end
function PaGlobal_ChatMain:convertFromItemGradeColor(nameColorGrade)
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
function PaGlobal_ChatMain:createChattingContent(chattingMessage, poolCurrentUI, PosY, messageIndex, panelIndex, deltascrollPosy, cacheSimpleUI, chattingUpTime, skipCount)
  if nil == skipCount then
    skipCount = 0
  end
  if skipCount > 0 then
    local lineCount = PaGlobal_ChatMain:getLineSizeCheck(chattingMessage, poolCurrentUI, PosY, messageIndex, panelIndex)
    poolCurrentUI:drawclear()
    if skipCount >= lineCount then
      skipCount = skipCount - lineCount
      return PosY, skipCount
    end
  end
  local SIZEY_OFFSET = 0
  local POSY_OFFSET = -1
  local panelSizeX = poolCurrentUI._list_PanelBG[0]:GetSizeX() - 20
  local panelSizeY = poolCurrentUI._list_PanelBG[0]:GetSizeY()
  local sender = chattingMessage:getSender(ToClient_getChatNameType())
  local chatType = chattingMessage.chatType
  local chatRoomNo = chattingMessage:getChatRoomNo()
  local noticeType = chattingMessage.noticeType
  local isGameManager = chattingMessage.isGameManager
  if true == _ContentsGroup_RenewUI_Chatting and nil ~= panelIndex then
    panelIndex = panelIndex - 1
  end
  local msgColor = Chatting_MessageColor(chatType, noticeType, panelIndex)
  local senderUserNo = chattingMessage:getUserNo()
  if PaGlobal_ChatMain:isEdanaType(chatType) == true and ToClient_IsEdana(senderUserNo) == true then
    msgColor = UI_color.C_FFfff330
  end
  local msg = PaGlobal_ChatMain:getChattingMessage(panelIndex, chattingMessage)
  local msgData
  local isLinkedItem = chattingMessage:isLinkedItem()
  local isLinkedGuild = chattingMessage:isLinkedGuild()
  local isLinkedPartyRecruit = chattingMessage:isLinkedPartyRecruit()
  local isLinkedWebSite = chattingMessage:isLinkedWebsite()
  local isLinkedMentalCard = chattingMessage:isLinkedMentalCard()
  local isLinkedQuest = chattingMessage:isLinkedQuest()
  local chatting_Icon = poolCurrentUI:newChattingIcon()
  local userType_Icon = poolCurrentUI:newUserTypeIcon()
  local recommand_Icon = poolCurrentUI:newRecommandIcon()
  local report_Button = poolCurrentUI:newReportButton()
  local chatting_GuildMark = poolCurrentUI:newChattingGuildMark()
  local chatting_sender = poolCurrentUI:newChattingSender(messageIndex)
  local isDev = ToClient_IsDevelopment()
  local chatting_contents = {}
  local emoticonCount = chattingMessage:getEmoticonCount()
  local chattingatCount = chattingMessage:getChattingAtCount()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return PosY
  end
  local reciverUserNickName = selfPlayerWrapper:getUserNickname()
  local itemGradeType = chattingMessage:getItemGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGradeType)
  local itemIconPath = chattingMessage:getIconPath()
  local mentalCardKey = chattingMessage:getMantalCardKey()
  local conetentsSizeY = chatting_sender:GetSizeY() + SIZEY_OFFSET
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
  PaGlobal_ChatMain.guildPromoteList = Array.new()
  local contentsList = Array.new()
  function contentsList:setShowAll(isShow)
    local count = contentsList:length()
    for i = 1, count do
      contentsList[i]:SetShow(isShow)
      contentsList[i] = nil
    end
  end
  if chatType == CppEnums.ChatType.Private and false == chattingMessage.isMe then
    if 0 == messageIndex then
      ChatInput_SetLastWhispersUserId(sender)
    end
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
      end
    end
  end
  chatting_Icon:SetShow(true)
  PaGlobal_ChatMain:setChattingIcon(chatType, chatting_Icon, panelIndex)
  local chat_contentAddPosX = 0
  local senderStr = PaGlobal_ChatMain:getSenderString(chattingMessage)
  chat_contentAddPosX = chat_contentAddPosX + PaGlobal_ChatMain:setchattingSender(chatType, chatRoomNo, chatting_sender, chatting_Icon, senderStr, msgColor, recommand_Icon, userType_Icon, chattingMessage, report_Button)
  chatting_sender:SetShow(true)
  PaGlobal_ChatMain._linkedGuildCache = nil
  local guildMarkAdjY = 2
  local guildMarkSize = PaGlobal_ChatMain:setChattingGuildMark(chatting_GuildMark, chattingMessage, chatting_sender, true)
  local contentindex = 1
  local textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
  local textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
  local msgstartindex = 0
  local chattingatNum = 1
  local isChattingAt = false
  if 0 ~= chattingatCount then
    isChattingAt = true
  end
  local j = 1
  local isWhile = false
  local checkItemWebAt = ChattingBlockType.Normal
  local chatEmoticon = {}
  local itemContents = {}
  local isSkip = false
  local emoticonSize = 25
  if 0 ~= emoticonCount then
    local emoNum = 1
    while emoticonCount >= emoNum do
      local emoticonindex = chattingMessage:getEmoticonIndex(emoNum - 1)
      local emoticonKey = chattingMessage:getEmoticonKey(emoNum - 1)
      local isItemEmoticon = PaGlobalFunc_isItemEmticon(emoticonKey)
      itemContents[contentindex] = false
      if msgstartindex == emoticonindex then
        if true == isLinkedGuild and 3 == contentindex then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(true)
          contentsList:push_back(chatting_contents[contentindex])
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          chatting_contents[contentindex]:SetSize(1, conetentsSizeY)
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText("")
          chatting_contents[contentindex]:SetPosY(PosY - chatting_contents[contentindex]:GetSizeY() - deltaPosY)
          contentindex = contentindex + 1
        end
        if true == isItemEmoticon then
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
          itemContents[contentindex] = true
        elseif isItemEmoticon then
          chatting_contents[contentindex]:ChangeTextureInfoNameAsync(chattingMessage:getEmoticonPath(emoNum - 1))
          local startX = chattingMessage:getEmoticonUV(emoNum - 1).x
          local startY = chattingMessage:getEmoticonUV(emoNum - 1).y
          local sizeX = chattingMessage:getEmoticonSize(emoNum - 1).x
          local sizeY = chattingMessage:getEmoticonSize(emoNum - 1).y
          chatting_contents[contentindex]:getBaseTexture():setUV(startX, startY, startX + sizeX, startY + sizeY)
          chatting_contents[contentindex]:setRenderTexture(chatting_contents[contentindex]:getBaseTexture())
          itemContents[contentindex] = true
        else
          local emoticonIndex = poolCurrentUI:getCurrentEmoticonIndex()
          if false == chattingMessage:isShowEmoticon(panelIndex) then
            local tempInfo = {}
            tempInfo._panelIndex = panelIndex
            tempInfo._emoticonIndex = emoticonIndex
            tempInfo._key = tostring(emoticonKey)
            PaGlobal_ChatMain._emoticonInfo[panelIndex] = tempInfo
            chattingMessage:setShowEmoticon(panelIndex, true)
          end
          chatting_contents[contentindex]:ChangeTextureInfoNameAsync(chattingMessage:getEmoticonPath(emoNum - 1))
          chatting_contents[contentindex]:addInputEvent("Mouse_On", "HandleOn_ChattingEmoticon(" .. panelIndex .. "," .. emoticonIndex .. "," .. tostring(emoticonKey) .. ", true, false)")
          chatting_contents[contentindex]:addInputEvent("Mouse_Out", "HandleOn_ChattingEmoticon(" .. panelIndex .. "," .. emoticonIndex .. "," .. tostring(emoticonKey) .. ", false, false)")
          chatting_contents[contentindex]:addInputEvent("Mouse_UpScroll", "Chatting_ScrollEvent( " .. panelIndex .. ", true )")
          chatting_contents[contentindex]:addInputEvent("Mouse_DownScroll", "Chatting_ScrollEvent( " .. panelIndex .. ", false )")
        end
        contentsList:push_back(chatting_contents[contentindex])
        j = 1
        isWhile = false
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - chatting_sender:GetTextSizeX()
        textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if textStaticSizeX <= 0 or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        end
        if isItemEmoticon then
          chatting_contents[contentindex]:SetSize(conetentsSizeY, conetentsSizeY)
        else
          chatting_contents[contentindex]:SetSize(emoticonSize, emoticonSize)
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
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
          chatting_contents[contentindex]:SetFontColor(msgColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          contentsList:push_back(chatting_contents[contentindex])
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          j = 1
          isWhile = false
          while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
            isWhile = true
            textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
            textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
            if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
              break
            end
            j = j + 1
          end
          if 0 == textStaticSizeX or isWhile == false then
            textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
            textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          end
          if contentindex > 1 and textStaticSizeX <= 0 then
            textStaticSizeX = panelSizeX - 10
            textStaticPosX = 0
          end
          chatting_contents[contentindex]:SetSize(textStaticSizeX, conetentsSizeY)
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          checkmsg, msgData, msgDataLen = PaGlobal_ChatMain:getTextLimitWidth(chatting_contents[contentindex], msgData)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText(checkmsg)
          chatting_contents[contentindex]:SetPosY(PosY - chatting_contents[contentindex]:GetSizeY() - deltaPosY)
          contentindex = contentindex + 1
        end
        if ispreEmoticonIndex ~= contentindex then
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), conetentsSizeY)
        else
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), conetentsSizeY)
        end
        msgstartindex = emoticonindex
      else
        checkItemWebAt = ChattingBlockType.Normal
        local drawstart = msgstartindex
        local drawend = emoticonindex
        checkItemWebAt, drawend, chattingatNum = PaGlobal_ChatMain:getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
        if emoticonindex ~= drawend then
          drawend = drawend + 1
        end
        local msgData = string.sub(msg, msgstartindex + 1, drawend)
        local msgDataLen = string.len(msgData)
        local checkmsg = {}
        local ispreEmoticonIndex = contentindex
        local msgCheckSender = string.sub(msgData, 2, msgDataLen)
        if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciverUserNickName then
          checkItemWebAt, drawend, chattingatNum = PaGlobal_ChatMain:groupingChattingAt(chattingMessage, msg, checkItemWebAt, msgCheckSender, reciverUserNickName, drawend, emoticonindex, chattingatNum, isChattingAt)
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
            chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(msgColor)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Item then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedItem(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(itemGradeColor)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Web then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedWebSite(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FF00C0D7)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Mention then
            chatting_contents[contentindex] = poolCurrentUI:newChattingAt()
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FFF601FF)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
            isChattingAt = false
          elseif checkItemWebAt == ChattingBlockType.Guild then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedGuild(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(msgColor)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(false)
            if nil ~= PaGlobal_ChatMain.guildPromoteList then
              PaGlobal_ChatMain.guildPromoteList:push_back(chatting_contents[contentindex])
            end
          elseif checkItemWebAt == ChattingBlockType.MentalCard then
            chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetFontColor(UI_color.C_FFFFFFFF)
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            if ToClient_isInAbyssOne() == false then
              chatting_contents[contentindex]:addInputEvent("Mouse_On", "HandleEventOnOut_MentalCard(" .. contentindex .. ",true )")
              chatting_contents[contentindex]:addInputEvent("Mouse_Out", "HandleEventOnOut_MentalCard(" .. contentindex .. ",false )")
              chatting_contents[contentindex]:addInputEvent("Mouse_LUp", "HandleEventLUp_MentalCard(" .. chattingMessage:getMantalCardKey() .. ")")
            end
            chatting_contents[contentindex]:SetIgnore(false)
          elseif checkItemWebAt == ChattingBlockType.Party then
            local linkedChattingParty = poolCurrentUI:newChattingLinkedParty(messageIndex)
            if nil == linkedChattingParty then
              break
            end
            chatting_contents[contentindex] = linkedChattingParty
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
          contentsList:push_back(chatting_contents[contentindex])
          local j = 1
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          j = 1
          isWhile = false
          while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
            isWhile = true
            textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
            textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
            if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
              break
            end
            j = j + 1
          end
          if 0 == textStaticSizeX or isWhile == false then
            textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
            textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          end
          if contentindex > 1 and textStaticSizeX <= 0 then
            textStaticSizeX = panelSizeX - 10
            textStaticPosX = 0
          end
          chatting_contents[contentindex]:SetSize(textStaticSizeX, conetentsSizeY)
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          checkmsg, msgData, msgDataLen = PaGlobal_ChatMain:getTextLimitWidth(chatting_contents[contentindex], msgData)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText(checkmsg)
          contentindex = contentindex + 1
        end
        if nil ~= chatting_contents[contentindex - 1] then
          if ispreEmoticonIndex ~= contentindex then
            chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), conetentsSizeY)
          else
            chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), conetentsSizeY)
          end
        end
        msgstartindex = drawend
      end
    end
    chatting_contents, contentindex = PaGlobal_ChatMain:createContentWithMsgLength(reciverUserNickName, poolCurrentUI, chatType, chattingMessage, isChattingAt, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, msgColor, msgstartindex, panelSizeX, chattingatNum, messageIndex, itemGradeColor, conetentsSizeY, recommand_Icon, userType_Icon, chatting_GuildMark, report_Button)
    local nowLineImoticon = false
    local nowLine = contentindex - 1
    local maxSizeY = 0
    for index = contentindex - 1, 1, -1 do
      if chatEmoticon[index] then
        nowLineImoticon = true
      end
      maxSizeY = 0
      if nowLineImoticon then
        local index2 = 1
        while nowLine >= index2 or index >= index2 do
          if 1 == index then
            if chatEmoticon[index2] then
              local tempSize = emoticonSize * 0.2
              chatting_contents[index2]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - tempSize - deltaPosY)
            else
              chatting_contents[index2]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY)
            end
          elseif chatEmoticon[index2] then
            chatting_contents[index2]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY)
          else
            local tempSize = emoticonSize * 0.2
            chatting_contents[index2]:SetPosY(PosY - chatting_contents[index]:GetSizeY() + tempSize - deltaPosY)
          end
          if false == itemContents[contentindex] then
            chatting_contents[index2]:SetSize(chatting_contents[index2]:GetSizeX(), emoticonSize)
          end
          index2 = index2 + 1
        end
      else
        chatting_contents[index]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY)
      end
      maxSizeY = math.max(chatting_contents[index]:GetSizeY(), maxSizeY)
      contentsList:push_back(chatting_contents[index])
      if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[index]:GetPosX() then
        if nowLineImoticon == false then
          chatting_contents[index]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY)
        end
        if skipCount > 0 then
          contentsList:setShowAll(false)
          skipCount = skipCount - 1
          isSkip = true
        else
          contentsList:setShowAll(true)
          PosY = PosY - maxSizeY + POSY_OFFSET
          isSkip = false
        end
        nowLine = index - 1
        nowLineImoticon = false
        if 1 ~= index then
          chatting_contents[index]:SetPosX(chatting_sender:GetTextSizeX() + chat_contentAddPosX)
        end
      end
    end
  else
    chatting_contents, contentindex = PaGlobal_ChatMain:createContentWithMsgLength(reciverUserNickName, poolCurrentUI, chatType, chattingMessage, isChattingAt, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, msgColor, msgstartindex, panelSizeX, chattingatNum, messageIndex, itemGradeColor, conetentsSizeY, recommand_Icon, userType_Icon, chatting_GuildMark, report_Button)
    for index = contentindex - 1, 1, -1 do
      chatting_contents[index]:SetPosY(PosY - chatting_contents[index]:GetSizeY() - deltaPosY)
      contentsList:push_back(chatting_contents[index])
      if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[index]:GetPosX() then
        if skipCount > 0 then
          contentsList:setShowAll(false)
          skipCount = skipCount - 1
          isSkip = true
        else
          contentsList:setShowAll(true)
          PosY = PosY - chatting_contents[index]:GetSizeY() + POSY_OFFSET
          if 1 ~= index then
            chatting_contents[index]:SetPosX(chatting_sender:GetTextSizeX() + chat_contentAddPosX)
          end
          isSkip = false
        end
      end
    end
  end
  chatting_Icon:SetPosY(PosY - deltaPosY + SIZEY_OFFSET - POSY_OFFSET - 2)
  if true == PaGlobal_ChatMain:checkThumbsUpOpen(chatType) then
    recommand_Icon:SetPosY(PosY - deltaPosY + SIZEY_OFFSET - POSY_OFFSET - 2)
  end
  if PaGlobal_ChatMain:isUserType(chatType, chatRoomNo) == true then
    userType_Icon:SetPosY(PosY - deltaPosY + SIZEY_OFFSET - POSY_OFFSET - 2)
  end
  if PaGlobal_ChatMain:isEdanaType(chatType) == true and ToClient_IsEdana(senderUserNo) == true then
    userType_Icon:SetPosY(PosY - deltaPosY + SIZEY_OFFSET - POSY_OFFSET - 2)
  end
  chatting_sender:SetPosY(PosY - deltaPosY + SIZEY_OFFSET - POSY_OFFSET)
  if report_Button ~= nil then
    report_Button:SetPosY(PosY - deltaPosY + SIZEY_OFFSET - POSY_OFFSET - 2)
  end
  chatting_GuildMark:SetPosY(PosY - deltaPosY - guildMarkAdjY)
  if UI_CT.System == chatType or UI_CT.Notice == chatType or chattingMessage.isMe then
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
  local guildPromoteCount = PaGlobal_ChatMain.guildPromoteList:length()
  if guildPromoteCount > 0 then
    for index = 1, guildPromoteCount do
      if 1 == index then
        PaGlobal_ChatMain.guildPromoteList[index]:SetPosX(PaGlobal_ChatMain.guildPromoteList[index]:GetPosX() + guildMarkSize)
        PaGlobal_ChatMain.guildPromoteList[index]:SetFontColor(UI_color.C_FF84FFF5)
      else
        PaGlobal_ChatMain.guildPromoteList[index]:SetPosX(PaGlobal_ChatMain.guildPromoteList[index]:GetPosX())
        PaGlobal_ChatMain.guildPromoteList[index]:SetFontColor(UI_color.C_FF84FFF5)
      end
    end
    PaGlobal_ChatMain.guildPromoteList = nil
  end
  if true == isSkip then
    chatting_Icon:SetShow(false)
    chatting_GuildMark:SetShow(false)
    chatting_sender:SetShow(false)
  else
    PosY = PosY - 5
  end
  return PosY, skipCount
end
function PaGlobal_ChatMain:uiPrivateChatType(chatType, chatting_Icon)
  if true == _ContentsGroup_RenewUI_Chatting then
    PaGlobalFunc_ChattingHistory_SetChatIcon(chatType, chatting_Icon)
    return
  end
  local isChatDivision = false
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eChatDivision) == false then
    isChatDivision = true
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eChatDivision, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  else
    isChatDivision = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eChatDivision)
  end
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
  elseif UI_CT.Channel == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 108, 96, 162, 120)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  elseif UI_CT.GuildManager == chatType then
    if isChatDivision then
      local x1, y1, x2, y2 = setTextureUV_Func(chatting_Icon, 108, 120, 162, 144)
      chatting_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      chatting_Icon:setRenderTexture(chatting_Icon:getBaseTexture())
    else
      chatting_Icon:SetShow(false)
      chatting_Icon:SetSize(0, chatting_Icon:GetSizeY())
    end
  end
end
function PaGlobal_ChatMain:getMessageFontColor(msg)
  if nil == msg then
    return ""
  end
  local Message = msg
  local msgLen = string.len(Message)
  if msgLen < 31 then
    return ""
  end
  local startIdx, endIdx = string.find(Message, "<PAColor0x")
  if nil ~= startIdx and nil ~= endIdx then
    local tempIdx, destIdx = string.find(Message, "<PAOldColor>")
    if nil == tempIdx and nil == destIdx or startIdx > destIdx then
      local fontColor = ""
      fontColor = string.sub(Message, startIdx, endIdx + 9)
      return fontColor
    else
      return ""
    end
  end
end
function PaGlobal_ChatMain:IsContainPAColor(msg)
  if nil ~= msg then
    local startIdx, endIdx = string.find(msg, "<PAColor0x")
    if nil ~= startIdx and nil ~= endIdx then
      return true
    else
      return false
    end
  else
    return false
  end
end
function PaGlobal_ChatMain:IsContainOldColor(msg)
  if nil ~= msg then
    local startIdx, endIdx = string.find(msg, "<PAOldColor>")
    if nil ~= startIdx and nil ~= endIdx then
      return true, endIdx
    else
      return false, 0
    end
  else
    return false, 0
  end
end
function PaGlobal_ChatMain:FindOldColorIndexTable(msg)
  local lastEndIndexTable = {}
  local findIndex = 0
  local stringLen = string.len(msg)
  local checkMsg = msg
  local tableIdx = 0
  local findMaxCount = 5
  local findCount = 0
  while findMaxCount > findCount do
    findCount = findCount + 1
    local isContained, endIdx = self:IsContainOldColor(checkMsg)
    if true == isContained then
      lastEndIndexTable[tableIdx] = endIdx + findIndex
      findIndex = endIdx
      tableIdx = tableIdx + 1
      checkMsg = string.sub(checkMsg, endIdx, stringLen)
    else
      break
    end
  end
  return lastEndIndexTable
end
function PaGlobal_ChatMain:applyPreviousColor(msg, originMsg)
  if nil == msg or nil == originMsg then
    return ""
  end
  local checkMsg = msg
  local msgLen = string.len(originMsg)
  if msgLen < 31 then
    return checkMsg
  end
  local checkMsgStartIdx, checkMsgEndIdx = string.find(originMsg, checkMsg, nil, true)
  if nil == checkMsgStartIdx or nil == checkMsgEndIdx then
    return checkMsg
  end
  local paColorRegexCode = "<PAColor0x%w%w%w%w%w%w%w%w>"
  local colorStartIdx, colorEndIdx = string.find(checkMsg, paColorRegexCode)
  local oldStartIdx, oldEndIdx = string.find(checkMsg, "<PAOldColor>", nil, true)
  if nil ~= colorStartIdx and nil ~= colorEndIdx and nil ~= oldStartIdx and nil ~= oldEndIdx then
    if colorStartIdx > oldStartIdx then
      local findCount = 0
      local lastFindStartIdx = 0
      local lastFindEndIdx = 0
      while findCount < 20 do
        local findString = string.sub(originMsg, lastFindEndIdx, checkMsgStartIdx + oldStartIdx)
        local findStart, findEnd = string.find(findString, paColorRegexCode)
        if nil ~= findStart and nil ~= findEnd then
          if checkMsgStartIdx + oldStartIdx <= lastFindEndIdx + findStart then
            do
              local previousStartIdex = lastFindStartIdx - 5
              if previousStartIdex < 0 then
                previousStartIdex = 0
              end
              local previousEndIndex = lastFindEndIdx + 5
              if msgLen < previousEndIndex then
                previousEndIndex = msgLen - 1
              end
              local prevColor = string.sub(originMsg, previousStartIdex, previousEndIndex)
              prevColor = string.match(prevColor, paColorRegexCode)
              if nil ~= prevColor then
                checkMsg = string.format("%s%s", prevColor, checkMsg)
              end
            end
          else
            lastFindStartIdx = lastFindEndIdx + findStart
            lastFindEndIdx = lastFindEndIdx + findEnd
            else
              if 0 ~= lastFindStartIdx then
                local previousStartIdex = lastFindStartIdx - 5
                if previousStartIdex < 0 then
                  previousStartIdex = 0
                end
                local previousEndIndex = lastFindEndIdx + 5
                if msgLen < previousEndIndex then
                  previousEndIndex = msgLen - 1
                end
                local prevColor = string.sub(originMsg, previousStartIdex, previousEndIndex)
                prevColor = string.match(prevColor, paColorRegexCode)
                if nil ~= prevColor then
                  checkMsg = string.format("%s%s", prevColor, checkMsg)
                end
              end
              break
            end
            findCount = findCount + 1
            elseif nil == colorStartIdx and nil == colorEndIdx and nil ~= oldStartIdx and nil ~= oldEndIdx then
              local findCount = 0
              local lastFindStartIdx = 0
              local lastFindEndIdx = 0
              while findCount < 20 do
                local findString = string.sub(originMsg, lastFindEndIdx, checkMsgStartIdx + oldStartIdx)
                local findStart, findEnd = string.find(findString, paColorRegexCode)
                if nil ~= findStart and nil ~= findEnd then
                  if checkMsgStartIdx + oldStartIdx <= lastFindEndIdx + findStart then
                    local previousStartIdex = lastFindStartIdx - 5
                    if previousStartIdex < 0 then
                      previousStartIdex = 0
                    end
                    local previousEndIndex = lastFindEndIdx + 5
                    if msgLen < previousEndIndex then
                      previousEndIndex = msgLen - 1
                    end
                    local prevColor = string.sub(originMsg, previousStartIdex, previousEndIndex)
                    prevColor = string.match(prevColor, paColorRegexCode)
                    if nil ~= prevColor then
                      checkMsg = string.format("%s%s", prevColor, checkMsg)
                    end
                    break
                  end
                  lastFindStartIdx = lastFindEndIdx + findStart
                  lastFindEndIdx = lastFindEndIdx + findEnd
                else
                  if 0 ~= lastFindStartIdx then
                    local previousStartIdex = lastFindStartIdx - 5
                    if previousStartIdex < 0 then
                      previousStartIdex = 0
                    end
                    local previousEndIndex = lastFindEndIdx + 5
                    if msgLen < previousEndIndex then
                      previousEndIndex = msgLen - 1
                    end
                    local prevColor = string.sub(originMsg, previousStartIdex, previousEndIndex)
                    prevColor = string.match(prevColor, paColorRegexCode)
                    if nil ~= prevColor then
                      checkMsg = string.format("%s%s", prevColor, checkMsg)
                    end
                  end
                  break
                end
                findCount = findCount + 1
              end
            end
          end
      end
    end
  return checkMsg
end
function PaGlobal_ChatMain:createContentWithMsgLength(reciverUserNickName, poolCurrentUI, chatType, chattingMessage, isChattingAt, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, msgColor, msgstartindex, panelSizeX, chattingatNum, messageIndex, itemGradeColor, conetentsSizeY, recommand_Icon, userType_Icon, chatting_GuildMark, report_Button)
  local isLinkedItem = chattingMessage:isLinkedItem()
  local isLinkedGuild = chattingMessage:isLinkedGuild()
  local isLinkedPartyRecruit = chattingMessage:isLinkedPartyRecruit()
  local isLinkedWebSite = chattingMessage:isLinkedWebsite()
  local isLinkedMentalCard = chattingMessage:isLinkedMentalCard()
  local isLinkedQuest = chattingMessage:isLinkedQuest()
  local j = 1
  local isWhile = false
  local textStaticSizeX = 0
  local textStaticPosX = 0
  local chat_contentAddPosX = 0
  if chatting_Icon:GetShow() then
    chat_contentAddPosX = 15 + chatting_Icon:GetSizeX()
  else
    chat_contentAddPosX = 10
  end
  chat_contentAddPosX = chat_contentAddPosX + PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) + PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) + PaGlobal_ChatMain:getReportButtonSizeX(report_Button)
  if true == ToClient_getUseHarfBuzz() then
    isChattingAt = false
  end
  local fontColor = ""
  local anotherColor = ""
  local textLimitFailedCount = 0
  while msgstartindex < string.len(msg) do
    if false == isChattingAt and false == isLinkedItem and false == isLinkedGuild and false == isLinkedWebSite and false == isLinkedMentalCard and false == isLinkedPartyRecruit and isLinkedQuest == false then
      local msgData = string.sub(msg, msgstartindex + 1, string.len(msg))
      local msgDataLen = string.len(msgData)
      local checkmsg = ""
      local ispreEmoticonIndex = contentindex
      while msgDataLen > 0 do
        chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
        if nil == chatting_contents[contentindex] then
          break
        end
        chatting_contents[contentindex]:SetFontColor(msgColor)
        chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
        chatting_contents[contentindex]:SetShow(true)
        chatting_contents[contentindex]:SetIgnore(true)
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
        textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        j = 1
        isWhile = false
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if 0 == textStaticSizeX or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        end
        if contentindex > 1 and textStaticSizeX <= 0 then
          textStaticSizeX = panelSizeX - 10
          textStaticPosX = 0
        end
        chatting_contents[contentindex]:SetSize(textStaticSizeX, conetentsSizeY)
        chatting_contents[contentindex]:SetPosX(textStaticPosX)
        checkmsg, msgData, msgDataLen = PaGlobal_ChatMain:getTextLimitWidth(chatting_contents[contentindex], msgData)
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
        if nil ~= checkmsg and "" ~= checkmsg then
          checkmsg = self:applyPreviousColor(checkmsg, msg)
        end
        chatting_contents[contentindex]:SetText(checkmsg)
        contentindex = contentindex + 1
      end
      if chatting_contents[contentindex - 1] ~= nil then
        if ispreEmoticonIndex ~= contentindex then
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), conetentsSizeY)
        else
          chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), conetentsSizeY)
        end
      end
      msgstartindex = string.len(msg)
    else
      checkItemWebAt = ChattingBlockType.Normal
      local drawstart = msgstartindex
      local drawend = string.len(msg)
      checkItemWebAt, drawend, chattingatNum = PaGlobal_ChatMain:getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
      drawend = drawend + 1
      local msgData = string.sub(msg, msgstartindex + 1, drawend)
      local msgDataLen = string.len(msgData)
      local checkmsg = ""
      local ispreEmoticonIndex = contentindex
      local msgLen = string.len(msg)
      local msgCheckSender = string.sub(msgData, 2, msgDataLen)
      if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciverUserNickName then
        checkItemWebAt, drawend, chattingatNum = PaGlobal_ChatMain:groupingChattingAt(chattingMessage, msg, checkItemWebAt, msgCheckSender, reciverUserNickName, drawend, msgLen, chattingatNum, isChattingAt)
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
      local checkIndex = drawend
      while true do
        if not (msgDataLen > 0) or textLimitFailedCount >= 5 then
          break
        end
        if checkItemWebAt == ChattingBlockType.Normal then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(msgColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetShow(true)
          chatting_contents[contentindex]:SetIgnore(true)
        elseif checkItemWebAt == ChattingBlockType.Item then
          chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedItem(messageIndex)
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(itemGradeColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Web then
          chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedWebSite(messageIndex)
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FF00C0D7)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Mention then
          chatting_contents[contentindex] = poolCurrentUI:newChattingAt()
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FFF601FF)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
          isChattingAt = false
        elseif checkItemWebAt == ChattingBlockType.Guild then
          chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedGuild(messageIndex)
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(msgColor)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(false)
          if nil ~= PaGlobal_ChatMain.guildPromoteList then
            PaGlobal_ChatMain.guildPromoteList:push_back(chatting_contents[contentindex])
          end
        elseif checkItemWebAt == ChattingBlockType.MentalCard then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
          if chatting_contents[contentindex] == nil then
            break
          end
          chatting_contents[contentindex]:SetFontColor(UI_color.C_FFFFFFFF)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          if ToClient_isInAbyssOne() == false then
            chatting_contents[contentindex]:addInputEvent("Mouse_On", "HandleEventOnOut_MentalCard(" .. contentindex .. ",true )")
            chatting_contents[contentindex]:addInputEvent("Mouse_Out", "HandleEventOnOut_MentalCard(" .. contentindex .. ",false )")
            chatting_contents[contentindex]:addInputEvent("Mouse_LUp", "HandleEventLUp_MentalCard(" .. chattingMessage:getMantalCardKey() .. ")")
          end
          chatting_contents[contentindex]:SetShow(true)
          chatting_contents[contentindex]:SetIgnore(false)
        elseif checkItemWebAt == ChattingBlockType.Party then
          local linkedChattingParty = poolCurrentUI:newChattingLinkedParty(messageIndex)
          if nil == linkedChattingParty then
            break
          end
          chatting_contents[contentindex] = linkedChattingParty
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
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX() - chatting_GuildMark:GetSizeX()
        textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        j = 1
        isWhile = false
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if 0 == textStaticSizeX or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX() - chatting_GuildMark:GetSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        end
        if contentindex > 1 and textStaticSizeX <= 0 then
          textStaticSizeX = panelSizeX - 10
          textStaticPosX = 0
        end
        chatting_contents[contentindex]:SetSize(textStaticSizeX, conetentsSizeY)
        chatting_contents[contentindex]:SetPosX(textStaticPosX)
        checkmsg, msgData, msgDataLen = PaGlobal_ChatMain:getTextLimitWidth(chatting_contents[contentindex], msgData)
        if isChangeFontSize() then
          chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
        end
        if nil ~= checkmsg and "" ~= checkmsg then
          checkmsg = self:applyPreviousColor(checkmsg, msg)
        end
        chatting_contents[contentindex]:SetText(checkmsg)
        contentindex = contentindex + 1
      end
      if ispreEmoticonIndex ~= contentindex then
        chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetTextSizeX(), conetentsSizeY)
      else
        chatting_contents[contentindex - 1]:SetSize(chatting_contents[contentindex - 1]:GetSizeX(), chatting_sender:GetSizeY())
      end
      msgstartindex = drawend
    end
  end
  return chatting_contents, contentindex
end
function HandleEventOnOut_MentalCard(index, isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if ToClient_isInAbyssOne() == true then
    return
  end
  if Panel_WorldMap ~= nil and Panel_WorldMap:GetShow() == true then
    return
  end
  local control = PaGlobal_getChattingContentsByIndex(index)
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_MENTALCARD_TOOLTIP_NAME")
  local desc
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_MentalCard(mentalCardKey)
  if ToClient_isInAbyssOne() == true then
    return
  end
  if false == _ContentsGroup_RenewUI_Knowledge then
    Panel_Knowledge_Show()
    Panel_Knowledge_SelectAnotherCard(mentalCardKey, true)
  else
    PaGlobalFunc_Window_Knowledge_Show()
  end
end
function PaGlobal_ChatMain:getTextLimitWidth(chatting_contents, msgOrigin)
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
function PaGlobal_ChatMain:getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
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
  if isLinkedItem then
    checkFinishItemWebSite = true
  end
  if isLinkedGuild then
    checkFinishItemWebSite = true
  end
  if isLinkedWebSite then
    checkFinishItemWebSite = true
  end
  if true == isLinkedPartyRecruit then
    checkFinishItemWebSite = true
  end
  if isLinkedQuest == true then
    checkFinishItemWebSite = true
  end
  local checkItemWebAt = ChattingBlockType.Normal
  if isLinkedItem then
    local LinkeditemStart = chattingMessage:getLinkedItemStartIndex()
    local LinkeditemEnd = chattingMessage:getLinkedItemEndIndex()
    if isChattingAt and chattingatNum <= chattingatCount then
      if atStart > LinkeditemStart and checkFinishItemWebSite then
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
  elseif isLinkedGuild then
    local LinkedguildStart = chattingMessage:getLinkedGuildStartIndex()
    local LinkedguildEnd = chattingMessage:getLinkedGuildEndIndex()
    if isChattingAt and chattingatCount >= chattingatNum then
      if atStart > LinkedguildStart and checkFinishItemWebSite then
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
    if isChattingAt and chattingatCount >= chattingatNum then
      if atStart > LinkedwebStart and checkFinishItemWebSite then
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
  elseif isChattingAt and chattingatCount >= chattingatNum then
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
  elseif true == isLinkedPartyRecruit then
    local LinkedPartyStart = chattingMessage:getLinkedPartyRecruitStartIndex()
    local LinkedPartyEnd = chattingMessage:getLinkedPartyRecruitEndIndex()
    if isChattingAt and chattingatCount >= chattingatNum then
      if atStart > LinkedPartyStart and true == checkFinishItemWebSite then
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
function PaGlobal_ChatMain:getLineSizeCheck(chattingMessage, poolCurrentUI, PosY, messageIndex, panelIndex)
  local panelSizeX = poolCurrentUI._list_PanelBG[0]:GetSizeX() - 20
  local panelSizeY = poolCurrentUI._list_PanelBG[0]:GetSizeY()
  local emoticonCount = chattingMessage:getEmoticonCount()
  local chatType = chattingMessage.chatType
  local chatRoomNo = chattingMessage:getChatRoomNo()
  local isLinkedItem = chattingMessage:isLinkedItem()
  local isLinkedGuild = chattingMessage:isLinkedGuild()
  local isLinkedPartyRecruit = chattingMessage:isLinkedPartyRecruit()
  local isLinkedWebSite = chattingMessage:isLinkedWebsite()
  local isLinkedMentalCard = chattingMessage:isLinkedMentalCard()
  local isLinkedQuest = chattingMessage:isLinkedQuest()
  local chatting_Icon = poolCurrentUI:newChattingIcon()
  local userType_Icon = poolCurrentUI:newUserTypeIcon()
  local recommand_Icon = poolCurrentUI:newRecommandIcon()
  local report_Button = poolCurrentUI:newReportButton()
  local chatting_GuildMark = poolCurrentUI:newChattingGuildMark()
  local chatting_sender = poolCurrentUI:newChattingSender(0)
  local chatting_contents = {}
  local msg = PaGlobal_ChatMain:getChattingMessage(panelIndex, chattingMessage)
  local reciverUserNickName = getSelfPlayer():getUserNickname()
  PaGlobal_ChatMain:setChattingIcon(chatType, chatting_Icon, panelIndex)
  local chat_contentAddPosX = 0
  local senderStr = PaGlobal_ChatMain:getSenderString(chattingMessage)
  chat_contentAddPosX = chat_contentAddPosX + PaGlobal_ChatMain:setchattingSender(chatType, chatRoomNo, chatting_sender, chatting_Icon, senderStr, 0, recommand_Icon, userType_Icon, chattingMessage, report_Button)
  local guildMarkAdjY = 2
  local guildMarkSize = PaGlobal_ChatMain:setChattingGuildMark(chatting_GuildMark, chattingMessage, chatting_sender, false)
  local contentindex = 1
  local textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
  local textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
  local msgstartindex = 0
  local chattingatNum = 1
  local isChattingAt = false
  local j = 1
  local isWhile = false
  local checkItemWebAt = ChattingBlockType.Normal
  local emoticonContentIndex = -1
  local chatEmoticon = {}
  local lineCount = 0
  if 0 ~= emoticonCount then
    local emoNum = 1
    while emoticonCount >= emoNum do
      local emoticonindex = chattingMessage:getEmoticonIndex(emoNum - 1)
      local emoticonKey = chattingMessage:getEmoticonKey(emoNum - 1)
      local isItemEmoticon = PaGlobalFunc_isItemEmticon(emoticonKey)
      if msgstartindex == emoticonindex then
        if true == isLinkedGuild and 3 == contentindex then
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          chatting_contents[contentindex]:SetIgnore(true)
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          chatting_contents[contentindex]:SetSize(1, chatting_sender:GetSizeY())
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText("")
          contentindex = contentindex + 1
        end
        if true == isItemEmoticon then
          chatting_contents[contentindex] = poolCurrentUI:newChattingEmoticon()
        else
          chatEmoticon[contentindex] = true
          local emoticonControl = poolCurrentUI:newChattingNewEmoticon()
          if nil == emoticonControl then
            break
          end
          chatting_contents[contentindex] = emoticonControl
        end
        j = 1
        isWhile = false
        textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
        textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
        while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
          isWhile = true
          textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
          textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
          if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
            break
          end
          j = j + 1
        end
        if textStaticSizeX <= 0 or isWhile == false then
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
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
          chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
          chatting_contents[contentindex]:SetFontColor(0)
          chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          j = 1
          isWhile = false
          while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
            isWhile = true
            textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
            textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
            if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
              break
            end
            j = j + 1
          end
          if 0 == textStaticSizeX or isWhile == false then
            textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
            textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          end
          if contentindex > 1 and textStaticSizeX <= 0 then
            textStaticSizeX = panelSizeX - 10
            textStaticPosX = 0
          end
          chatting_contents[contentindex]:SetSize(textStaticSizeX, chatting_sender:GetSizeY())
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          checkmsg, msgData, msgDataLen = PaGlobal_ChatMain:getTextLimitWidth(chatting_contents[contentindex], msgData)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText(checkmsg)
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
        checkItemWebAt, drawend, chattingatNum = PaGlobal_ChatMain:getCheckItemWebAt(chattingMessage, chattingatNum, drawstart, drawend, isChattingAt)
        if emoticonindex ~= drawend then
          drawend = drawend + 1
        end
        local msgData = string.sub(msg, msgstartindex + 1, drawend)
        local msgDataLen = string.len(msgData)
        local checkmsg = {}
        local ispreEmoticonIndex = contentindex
        local msgCheckSender = string.sub(msgData, 2, msgDataLen)
        if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciverUserNickName then
          checkItemWebAt, drawend, chattingatNum = PaGlobal_ChatMain:groupingChattingAt(chattingMessage, msg, checkItemWebAt, msgCheckSender, reciverUserNickName, drawend, emoticonindex, chattingatNum)
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
            chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Item then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedItem(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Web then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedWebSite(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Mention then
            chatting_contents[contentindex] = poolCurrentUI:newChattingAt()
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
            isChattingAt = false
          elseif checkItemWebAt == ChattingBlockType.Guild then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedGuild(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
            if nil ~= PaGlobal_ChatMain.guildPromoteList then
              PaGlobal_ChatMain.guildPromoteList:push_back(chatting_contents[contentindex])
            end
          elseif checkItemWebAt == ChattingBlockType.MentalCard then
            chatting_contents[contentindex] = poolCurrentUI:newChattingContents()
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Party then
            local chatLinkedParty = poolCurrentUI:newChattingLinkedParty()
            if nil == chatLinkedParty then
              break
            end
            chatting_contents[contentindex] = chatLinkedParty
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          elseif checkItemWebAt == ChattingBlockType.Quest then
            chatting_contents[contentindex] = poolCurrentUI:newChattingLinkedQuest(messageIndex)
            if chatting_contents[contentindex] == nil then
              break
            end
            chatting_contents[contentindex]:SetTextMode(__eTextMode_ChattingText)
            chatting_contents[contentindex]:SetIgnore(true)
          end
          local j = 1
          textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
          textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          j = 1
          isWhile = false
          while contentindex > 1 and nil ~= chatting_contents[contentindex - j] and chatting_contents[contentindex - j]:GetSizeX() < panelSizeX - chatting_Icon:GetSizeX() - chatting_sender:GetTextSizeX() do
            isWhile = true
            textStaticSizeX = textStaticSizeX - chatting_contents[contentindex - j]:GetSizeX()
            textStaticPosX = textStaticPosX + chatting_contents[contentindex - j]:GetSizeX()
            if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[contentindex - j]:GetPosX() then
              break
            end
            j = j + 1
          end
          if 0 == textStaticSizeX or isWhile == false then
            textStaticSizeX = panelSizeX - chatting_Icon:GetSizeX() - PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon) - PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon) - PaGlobal_ChatMain:getReportButtonSizeX(report_Button) - chatting_sender:GetTextSizeX()
            textStaticPosX = chatting_sender:GetTextSizeX() + chat_contentAddPosX
          end
          if contentindex > 1 and textStaticSizeX <= 0 then
            textStaticSizeX = panelSizeX - 10
            textStaticPosX = 0
          end
          chatting_contents[contentindex]:SetSize(textStaticSizeX, chatting_sender:GetSizeY())
          chatting_contents[contentindex]:SetPosX(textStaticPosX)
          checkmsg, msgData, msgDataLen = PaGlobal_ChatMain:getTextLimitWidth(chatting_contents[contentindex], msgData)
          if isChangeFontSize() then
            chatting_contents[contentindex]:setChangeFontAfterTransSizeValue(true)
          end
          chatting_contents[contentindex]:SetText(checkmsg)
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
    chatting_contents, contentindex = PaGlobal_ChatMain:createContentWithMsgLength(reciverUserNickName, poolCurrentUI, chatType, chattingMessage, isChattingAt, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, 0, msgstartindex, panelSizeX, chattingatNum, messageIndex, 0, 1, recommand_Icon, userType_Icon, chatting_GuildMark, report_Button)
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
          end
          index2 = index2 + 1
        end
      end
      if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[index]:GetPosX() then
        lineCount = lineCount + 1
        nowLine = index - 1
        nowLineImoticon = false
        if 1 ~= index then
          chatting_contents[index]:SetPosX(chatting_sender:GetTextSizeX() + chat_contentAddPosX)
        end
      end
    end
  else
    chatting_contents, contentindex = PaGlobal_ChatMain:createContentWithMsgLength(reciverUserNickName, poolCurrentUI, chatType, chattingMessage, isChattingAt, contentindex, chatting_contents, chatting_Icon, chatting_sender, msg, 0, msgstartindex, panelSizeX, chattingatNum, messageIndex, 0, 1, recommand_Icon, userType_Icon, chatting_GuildMark, report_Button)
    for index = contentindex - 1, 1, -1 do
      if chatting_sender:GetTextSizeX() + chat_contentAddPosX >= chatting_contents[index]:GetPosX() then
        lineCount = lineCount + 1
        if 1 ~= index then
          chatting_contents[index]:SetPosX(chatting_sender:GetTextSizeX() + chat_contentAddPosX)
        end
      end
    end
  end
  for k, contents in ipairs(chatting_contents) do
    contents:SetShow(false)
  end
  return lineCount
end
function PaGlobal_ChatMain:getSenderString(chattingMessage)
  local nameType = chattingMessage.chatNameType
  local senderNameType = ToClient_getChatNameType()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    senderNameType = 1
  end
  local sender = chattingMessage:getSender(senderNameType)
  local chatType = chattingMessage.chatType
  if UI_CT.System == chatType then
    sender = PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_SYSTEM")
  elseif UI_CT.Notice == chatType then
    sender = PAGetString(Defines.StringSheet_GAME, "CHATTING_NOTICE")
  elseif UI_CT.Battle == chatType then
    sender = PAGetString(Defines.StringSheet_GAME, "CHATTING_BATTLE")
  end
  local senderStr = " [" .. sender .. "] : "
  if UI_CT.Private == chatType then
    if not chattingMessage.isMe then
      senderStr = "\226\151\128 " .. senderStr
    elseif 0 == nameType then
      senderStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_NAMETYPE_0") .. senderStr
    elseif 1 == nameType then
      senderStr = PAGetString(Defines.StringSheet_GAME, "LUA_CHAT_NAMETYPE_1") .. senderStr
    end
  else
  end
  return senderStr
end
function PaGlobal_ChatMain:setChattingIcon(chatType, chatting_Icon, panelIndex)
  local chatPanel = ToClient_getChattingPanel(panelIndex)
  local fontType = chatPanel:getChatFontSizeType()
  local fontSize = PaGlobal_ChatMain:convertChatFontTypeToFontSize(fontType)
  local iconSizeY = fontSize + 8
  local iconSizeX = iconSizeY * 2 + 5
  chatting_Icon:SetSize(iconSizeX, iconSizeY)
  PaGlobal_ChatMain:uiPrivateChatType(chatType, chatting_Icon)
  chatting_Icon:ComputePos()
  chatting_Icon:SetPosX(10)
end
function PaGlobal_ChatMain:checkThumbsUpOpen(chatType)
  if nil == chatType then
    return false
  end
  if false == _ContentsGroup_Chat_Thumb then
    return false
  end
  if true == _ContentsGroup_UsePadSnapping then
    return false
  end
  if false == (chatType == UI_CT.World or chatType == UI_CT.WorldWithItem or chatType == UI_CT.Public or chatType == UI_CT.Channel) then
    return false
  end
  return true
end
function PaGlobal_ChatMain:setchattingSender(chatType, chatRoomNo, chatting_sender, chatting_Icon, senderStr, msgColor, recommand_Icon, userType_Icon, chattingMessage, report_Button)
  local chat_contentAddPosX = 0
  local senderUserNo = chattingMessage:getUserNo()
  if true == PaGlobal_ChatMain:checkThumbsUpOpen(chatType) and false == chattingMessage.isGameManager then
    local selfUserNo = getSelfPlayer():get():getUserNo()
    local thumbsUpCnt = chattingMessage:getThumbsUpCount()
    local thumbsUpGrade = chattingMessage:getThumbsUpGrade()
    if thumbsUpGrade > 0 then
      recommand_Icon:SetShow(true)
    else
      recommand_Icon:SetShow(false)
    end
    recommand_Icon:ComputePos()
    if nil == thumbsUpCnt then
      thumbsUpCnt = 0
    else
      thumbsUpCnt = Int64toInt32(thumbsUpCnt)
    end
    if thumbsUpGrade > 0 then
      local imgIndex = thumbsUpGrade - 1
      local normalTextureInfo = PaGlobal_ChatMain._recommand_btnUV._normal[imgIndex]
      local onTextureInfo = PaGlobal_ChatMain._recommand_btnUV._on[imgIndex]
      local clickTextureInfo = PaGlobal_ChatMain._recommand_btnUV._click[imgIndex]
      local x1, y1, x2, y2 = setTextureUV_Func(recommand_Icon, normalTextureInfo.x1, normalTextureInfo.y1, normalTextureInfo.x2, normalTextureInfo.y2)
      recommand_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
      x1, y1, x2, y2 = setTextureUV_Func(recommand_Icon, onTextureInfo.x1, onTextureInfo.y1, onTextureInfo.x2, onTextureInfo.y2)
      recommand_Icon:getOnTexture():setUV(x1, y1, x2, y2)
      x1, y1, x2, y2 = setTextureUV_Func(recommand_Icon, clickTextureInfo.x1, clickTextureInfo.y1, clickTextureInfo.x2, clickTextureInfo.y2)
      recommand_Icon:getClickTexture():setUV(x1, y1, x2, y2)
      recommand_Icon:setRenderTexture(recommand_Icon:getBaseTexture())
    end
    recommand_Icon:addInputEvent("Mouse_LUp", "")
    if nil == senderUserNo or nil == selfUserNo or selfUserNo ~= senderUserNo then
    end
    recommand_Icon:addInputEvent("Mouse_On", "HandleOn_Chatting_RecommandTooltip(" .. thumbsUpCnt .. ")")
    recommand_Icon:addInputEvent("Mouse_Out", "PaGlobal_SpeechBubble_Hide()")
    if true == chatting_Icon:GetShow() then
      chat_contentAddPosX = chat_contentAddPosX + 15
      recommand_Icon:SetPosX(chatting_Icon:GetSizeX() + chat_contentAddPosX)
    else
      chat_contentAddPosX = chat_contentAddPosX + 10
      recommand_Icon:SetPosX(chat_contentAddPosX)
    end
    chat_contentAddPosX = recommand_Icon:GetPosX() + PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon)
  else
    recommand_Icon:SetShow(false)
    if true == chatting_Icon:GetShow() then
      chat_contentAddPosX = chat_contentAddPosX + 15
      chat_contentAddPosX = chat_contentAddPosX + chatting_Icon:GetSizeX()
    else
      chat_contentAddPosX = chat_contentAddPosX + 10
    end
  end
  if true == PaGlobal_ChatMain:isRecommand(chatType, chatRoomNo) then
    local thumbsUpCnt = chattingMessage:getThumbsUpCount()
    if nil == thumbsUpCnt then
      thumbsUpCnt = 0
    else
      thumbsUpCnt = Int64toInt32(thumbsUpCnt)
    end
    chatting_sender:addInputEvent("Mouse_On", "HandleOn_Chatting_RecommandTooltip(" .. thumbsUpCnt .. ")")
    chatting_sender:addInputEvent("Mouse_Out", "PaGlobal_SpeechBubble_Hide()")
  else
    chatting_sender:addInputEvent("Mouse_On", "")
    chatting_sender:addInputEvent("Mouse_Out", "")
  end
  userType_Icon:SetShow(false)
  if PaGlobal_ChatMain:isEdanaType(chatType) == true and ToClient_IsEdana(senderUserNo) == true then
    userType_Icon:SetShow(true)
    userType_Icon:ComputePos()
    local edaniaRegion = ToClient_GetEdaniaRegion(senderUserNo)
    local baseTextureID = ""
    local onTextureID = ""
    local clickTextureID = ""
    if edaniaRegion == __eEdaniaRegion_Aetherion then
      baseTextureID = "Combine_Etc_EdaniaIcon_Jordain_Normal"
      onTextureID = "Combine_Etc_EdaniaIcon_Jordain_Over"
      baseTextureID = "Combine_Etc_EdaniaIcon_Jordain_Click"
    elseif edaniaRegion == __eEdaniaRegion_Nymphamare then
      baseTextureID = "Combine_Etc_EdaniaIcon_Rusalka_Normal"
      onTextureID = "Combine_Etc_EdaniaIcon_Rusalka_Over"
      baseTextureID = "Combine_Etc_EdaniaIcon_Rusalka_Click"
    elseif edaniaRegion == __eEdaniaRegion_Orbita then
      baseTextureID = "Combine_Etc_EdaniaIcon_Ensla_Normal"
      onTextureID = "Combine_Etc_EdaniaIcon_Ensla_Over"
      baseTextureID = "Combine_Etc_EdaniaIcon_Ensla_Click"
    elseif edaniaRegion == __eEdaniaRegion_Tenebraum then
      baseTextureID = "Combine_Etc_EdaniaIcon_Kartian_Normal"
      onTextureID = "Combine_Etc_EdaniaIcon_Kartian_Over"
      baseTextureID = "Combine_Etc_EdaniaIcon_Kartian_Click"
    elseif edaniaRegion == __eEdaniaRegion_Zephyros then
      baseTextureID = "Combine_Etc_EdaniaIcon_Caphras_Normal"
      onTextureID = "Combine_Etc_EdaniaIcon_Caphras_Over"
      baseTextureID = "Combine_Etc_EdaniaIcon_Caphras_Click"
    end
    userType_Icon:ChangeTextureInfoTextureIDAsync(baseTextureID, 0)
    userType_Icon:ChangeTextureInfoTextureIDAsync(onTextureID, 1)
    userType_Icon:ChangeTextureInfoTextureIDAsync(baseTextureID, 2)
    userType_Icon:setRenderTexture(userType_Icon:getBaseTexture())
    userType_Icon:SetPosX(chat_contentAddPosX)
    chat_contentAddPosX = chat_contentAddPosX + userType_Icon:GetSizeX()
    userType_Icon:addInputEvent("Mouse_On", "HandleOn_Chatting_EdanaTooltip(true, " .. tostring(senderUserNo) .. ")")
    userType_Icon:addInputEvent("Mouse_Out", "PaGlobal_SpeechBubble_Hide()")
  end
  if PaGlobal_ChatMain:isUserType(chatType, chatRoomNo) == true then
    if ToClient_IsOlviaAcademyGuide(senderUserNo) == true then
      userType_Icon:SetShow(true)
      userType_Icon:ComputePos()
      local userTypeNormalTextureInfo = PaGlobal_ChatMain._userType_btnUV._normal._returnUser
      local userTypeOnTextureInfo = PaGlobal_ChatMain._userType_btnUV._on._returnUser
      local userTypeClickTextureInfo = PaGlobal_ChatMain._userType_btnUV._click._returnUser
      local x1, y1, x2, y2
      if nil ~= userTypeNormalTextureInfo then
        userType_Icon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_ChatRanking.dds")
        x1, y1, x2, y2 = setTextureUV_Func(userType_Icon, userTypeNormalTextureInfo.x1, userTypeNormalTextureInfo.y1, userTypeNormalTextureInfo.x2, userTypeNormalTextureInfo.y2)
        userType_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
        userType_Icon:setRenderTexture(userType_Icon:getBaseTexture())
      end
      if nil ~= userTypeOnTextureInfo then
        userType_Icon:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_ChatRanking.dds")
        x1, y1, x2, y2 = setTextureUV_Func(userType_Icon, userTypeOnTextureInfo.x1, userTypeOnTextureInfo.y1, userTypeOnTextureInfo.x2, userTypeOnTextureInfo.y2)
        userType_Icon:getOnTexture():setUV(x1, y1, x2, y2)
      end
      if nil ~= userTypeClickTextureInfo then
        userType_Icon:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_ChatRanking.dds")
        x1, y1, x2, y2 = setTextureUV_Func(userType_Icon, userTypeClickTextureInfo.x1, userTypeClickTextureInfo.y1, userTypeClickTextureInfo.x2, userTypeClickTextureInfo.y2)
        userType_Icon:getClickTexture():setUV(x1, y1, x2, y2)
      end
      userType_Icon:SetPosX(chat_contentAddPosX)
      chat_contentAddPosX = chat_contentAddPosX + userType_Icon:GetSizeX()
      userType_Icon:addInputEvent("Mouse_On", "HandleOn_Chatting_UserTypeTooltip(" .. UserType .. ")")
      userType_Icon:addInputEvent("Mouse_Out", "PaGlobal_SpeechBubble_Hide()")
      recommand_Icon:SetShow(false)
    elseif recommand_Icon:GetShow() == false then
      local temporaryWrapper = getTemporaryInformationWrapper()
      if nil ~= temporaryWrapper then
        local UserType = chattingMessage:getUserType()
        if 1 == UserType or 2 == UserType then
          userType_Icon:SetShow(true)
          userType_Icon:ComputePos()
          local userTypeNormalTextureInfo, userTypeOnTextureInfo, userTypeClickTextureInfo
          if UserType == 1 then
            userTypeNormalTextureInfo = PaGlobal_ChatMain._userType_btnUV._normal._returnUser
            userTypeOnTextureInfo = PaGlobal_ChatMain._userType_btnUV._on._returnUser
            userTypeClickTextureInfo = PaGlobal_ChatMain._userType_btnUV._click._returnUser
          elseif UserType == 2 then
            userTypeNormalTextureInfo = PaGlobal_ChatMain._userType_btnUV._normal._newbieUser
            userTypeOnTextureInfo = PaGlobal_ChatMain._userType_btnUV._on._newbieUser
            userTypeClickTextureInfo = PaGlobal_ChatMain._userType_btnUV._click._newbieUser
          end
          local x1, y1, x2, y2
          if nil ~= userTypeNormalTextureInfo then
            userType_Icon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_ChatRanking.dds")
            x1, y1, x2, y2 = setTextureUV_Func(userType_Icon, userTypeNormalTextureInfo.x1, userTypeNormalTextureInfo.y1, userTypeNormalTextureInfo.x2, userTypeNormalTextureInfo.y2)
            userType_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
            userType_Icon:setRenderTexture(userType_Icon:getBaseTexture())
          end
          if nil ~= userTypeOnTextureInfo then
            userType_Icon:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_ChatRanking.dds")
            x1, y1, x2, y2 = setTextureUV_Func(userType_Icon, userTypeOnTextureInfo.x1, userTypeOnTextureInfo.y1, userTypeOnTextureInfo.x2, userTypeOnTextureInfo.y2)
            userType_Icon:getOnTexture():setUV(x1, y1, x2, y2)
          end
          if nil ~= userTypeClickTextureInfo then
            userType_Icon:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_ChatRanking.dds")
            x1, y1, x2, y2 = setTextureUV_Func(userType_Icon, userTypeClickTextureInfo.x1, userTypeClickTextureInfo.y1, userTypeClickTextureInfo.x2, userTypeClickTextureInfo.y2)
            userType_Icon:getClickTexture():setUV(x1, y1, x2, y2)
          end
          userType_Icon:SetPosX(chat_contentAddPosX)
          if true == userType_Icon:GetShow() then
            chat_contentAddPosX = chat_contentAddPosX + userType_Icon:GetSizeX()
            userType_Icon:addInputEvent("Mouse_On", "HandleOn_Chatting_UserTypeTooltip(" .. UserType .. ")")
            userType_Icon:addInputEvent("Mouse_Out", "PaGlobal_SpeechBubble_Hide()")
          end
        else
          userType_Icon:SetShow(false)
        end
      end
    end
  end
  if PaGlobal_ChatMain:isReportButton(chatType) == true then
    if chattingMessage.isMe == false then
      local isAbuseChatIndex1, isAbuseChatIndex2 = string.find(chattingMessage:getContent(), "*")
      if isAbuseChatIndex1 ~= nil and isAbuseChatIndex2 ~= nil then
        report_Button:SetShow(true)
      else
        report_Button:SetShow(false)
      end
      if chatting_Icon:GetShow() == true then
        report_Button:SetPosX(chat_contentAddPosX)
        if report_Button:GetShow() == true then
          chat_contentAddPosX = chat_contentAddPosX + report_Button:GetSizeX()
        else
        end
      else
        report_Button:SetPosX(chat_contentAddPosX)
        if report_Button:GetShow() == true then
          chat_contentAddPosX = chat_contentAddPosX + report_Button:GetSizeX()
        else
        end
      end
    else
      report_Button:SetShow(false)
    end
  elseif report_Button ~= nil then
    report_Button:SetShow(false)
  end
  chatting_sender:SetPosX(chat_contentAddPosX)
  chatting_sender:SetTextHorizonRight()
  chatting_sender:SetAutoResize(true)
  chatting_sender:SetFontColor(msgColor)
  chatting_sender:SetText(senderStr)
  if UI_CT.System == chatType or UI_CT.Battle == chatType then
    chatting_sender:SetText(" ")
  end
  chatting_sender:SetSize(chatting_sender:GetTextSizeX(), chatting_sender:GetTextSizeY() - 4)
  return chat_contentAddPosX
end
function PaGlobal_ChatMain:setChattingGuildMark(chatting_GuildMark, chattingMessage, chatting_sender, isShow)
  if false == chattingMessage:isLinkedGuild() then
    return
  end
  local guildMarkPureSize = chatting_sender:GetTextSizeY()
  local guildMarkMarginWidth = 8
  local guildMarkSize = guildMarkPureSize + guildMarkMarginWidth
  chatting_GuildMark:SetShow(isShow)
  chatting_GuildMark:SetSize(guildMarkPureSize, guildMarkPureSize)
  chatting_GuildMark:SetPosX(chatting_sender:GetPosX() + chatting_sender:GetTextSizeX() + guildMarkMarginWidth / 2)
  if true == isShow then
    local linkedGuildInfo = chattingMessage:getLinkedGuildInfo()
    local guildNo = linkedGuildInfo:getGuildNo()
    local isSet = setGuildTextureByGuildNo(guildNo, chatting_GuildMark)
    if false == isSet then
      chatting_GuildMark:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Default/BlankGuildMark.dds")
    end
    chatting_GuildMark:setRenderTexture(chatting_GuildMark:getBaseTexture())
  end
  return guildMarkSize
end
function PaGlobal_ChatMain:getChattingMessage(panelIndex, chattingMessage)
  if nil == panelIndex then
    return
  end
  local chatType = chattingMessage.chatType
  local msg = chattingMessage:getContent()
  if UI_CT.Channel == chatType then
    local chatRoomNo = chattingMessage:getChatRoomNo()
    if true == ToClient_SelfPlayerIsGM() and 0 ~= chatRoomNo then
      local chatRoomInfo = ToClient_getChannelChatingRoomByRoomNo(chatRoomNo)
      if nil ~= chatRoomInfo then
        msg = msg .. " (" .. tostring(chatRoomInfo:getRoomName()) .. ") "
      end
    end
  end
  if true == PaGlobal_ChatMain:getIsShowTimeString(panelIndex) or UI_CT.Private == chatType or UI_CT.System == chatType and UI_CST.Market == chattingMessage.chatSystemType then
    msg = msg .. " (" .. chattingMessage:getTimeString() .. ")"
  end
  return msg
end
function PaGlobal_ChatMain:getIsShowTimeString(index)
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
function PaGlobal_ChatMain:getRecommandIconSizeX(recommand_Icon)
  if recommand_Icon:GetShow() then
    return recommand_Icon:GetSizeX()
  end
  return 0
end
function PaGlobal_ChatMain:getUserTypeIconSizeX(userType_Icon)
  if userType_Icon:GetShow() then
    return userType_Icon:GetSizeX()
  end
  return 0
end
function PaGlobal_ChatMain:getReportButtonSizeX(report_Button)
  if report_Button ~= nil and report_Button:GetShow() == true then
    return report_Button:GetSizeX()
  end
  return 0
end
function PaGlobal_ChatMain:getRecommandGradeIndex(thumbsUpGrade)
  if 3 == thumbsUpGrade then
    return 1
  elseif 2 == thumbsUpGrade then
    return 2
  elseif 1 == thumbsUpGrade then
    return 3
  else
    return 10
  end
end
function HandleOn_Chatting_TargetReport(isShow, poolIndex, controlIndex)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TARGETREPORT_TOOLTIP")
  local desc = ""
  local control
  local paramIndex = poolIndex
  if 0 == poolIndex then
    paramIndex = PaGlobal_ChatMain._mainPanelSelectPanelIndex
  end
  local chatPanel = ToClient_getChattingPanel(paramIndex)
  local poolCurrentUI = PaGlobal_ChatMain:getPool(poolIndex)
  local messageIndex = poolCurrentUI._list_ChattingSender[controlIndex]
  if nil == messageIndex then
    return
  end
  TooltipSimple_Show(messageIndex, name, desc)
end
function PaGlobal_ChatMain:groupingChattingAt(chattingMessage, messageContent, checkItemWebAt, msgCheckSender, reciverUserNickName, drawend, msgEnd, chattingatNum, isChattingAt)
  while checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciverUserNickName do
    local drawStartTemp = drawend
    local drawEndTemp = msgEnd
    local chattingatNumTemp = chattingatNum
    checkItemWebAt, drawEndTemp, chattingatNumTemp = PaGlobal_ChatMain:getCheckItemWebAt(chattingMessage, chattingatNumTemp, drawStartTemp, drawEndTemp, isChattingAt)
    drawEndTemp = drawEndTemp + 1
    local msgDataTemp = string.sub(messageContent, drawStartTemp + 1, drawEndTemp)
    local msgDataLenTemp = string.len(msgDataTemp)
    msgCheckSender = string.sub(msgDataTemp, 2, msgDataLenTemp)
    if checkItemWebAt == ChattingBlockType.Normal or checkItemWebAt == ChattingBlockType.Mention and msgCheckSender ~= reciverUserNickName then
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
