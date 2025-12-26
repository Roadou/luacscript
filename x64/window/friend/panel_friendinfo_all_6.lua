function PaGlobal_FriendMessanger_All:createMessanger(messangerIdstr, userName, friendUserNo, isOnline)
  local messanger = {
    _mainPanel = nil,
    _uiTitleBg = nil,
    _uiName = nil,
    _uiClose = nil,
    _uiSmall = nil,
    _uiPopup = nil,
    _uiAlarm = nil,
    _uiEditGroup = nil,
    _uiEnter = nil,
    _uiPartyInvite = nil,
    _uiEmo = nil,
    _uiEditInputChat = nil,
    _uiSizeControl = nil,
    _uiSlider = nil,
    _uiSliderButton = nil,
    _uiFrame = nil,
    _uiFrameContent = nil,
    _uiFrameScroll = nil,
    _uiStaticBg = {},
    _uiStaticText = {},
    _uiStaticTime = {},
    _uiClassIcon = {},
    _emoticonAni = {},
    _friendUserNo = nil,
    _messangerAlpha = 1,
    _messageCount = 0,
    _messageIndex = nil,
    _contentIndex = nil,
    _isCallShow = false
  }
  function messanger:initialize(messangerIdstr, userName, friendUserNo, isOnline)
    messanger:createPanel(messangerIdstr, isOnline)
    messanger:prepareControl(messangerIdstr, userName, isOnline, friendUserNo)
    PaGlobal_FriendMessanger_All._messangerMinSizeX = messanger._mainPanel:GetSizeX()
    PaGlobal_FriendMessanger_All._messangerMinSizeY = messanger._mainPanel:GetSizeY()
    messanger._friendUserNo = friendUserNo
  end
  function messanger:clear()
    UI.deletePanel(messanger._mainPanel:GetID())
    messanger._mainPanel = nil
    messanger._friendUserNo = nil
  end
  function messanger:createPanel(messangerIdstr, isOnline)
    local newName = "Panel_FriendMessanger" .. messangerIdstr
    messanger._mainPanel = UI.createPanel(newName, Defines.UIGroup.PAGameUIGroup_WorldMap_Popups)
    CopyBaseProperty(Panel_Friend_TalkMessanger_All, messanger._mainPanel)
    messanger._mainPanel:SetDragAll(true)
    messanger._mainPanel:SetShow(true)
    messanger._mainPanel:addInputEvent("Mouse_UpScroll", "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", true )")
    messanger._mainPanel:addInputEvent("Mouse_DownScroll", "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", false )")
    if true == _ContentsGroup_UsePadSnapping then
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_Up_X, "FriendMessanger_SetFocusEdit(" .. messangerIdstr .. ")")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", true )")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "FriendMessanger_OnMouseWheel( " .. messangerIdstr .. ", false )")
      messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "friend_openChatMacro(" .. messangerIdstr .. ")")
      registerCloseLuaEvent(messanger._mainPanel, PAUIRenderModeBitSet({
        Defines.CloseType.eCloseType_Escape
      }), "FriendMessanger_Close(" .. messangerIdstr .. ")")
    end
  end
  function messanger:prepareControl(messangerIdstr, userName, isOnline, friendUserNo)
    local titleBar = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Static_Chat_TitleBar")
    local editGroup = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Static_EditGroup")
    local keyguideBg = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Static_KeyGuide_Console")
    messanger._uiTitleBg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Static_Chat_TitleBar", 0)
    messanger._uiName = messanger:createControl(__ePAUIControl_StaticText, titleBar, messanger._uiTitleBg, "StaticText_Name", 0)
    messanger._uiName:SetText(userName)
    messanger._uiClose = messanger:createControl(__ePAUIControl_Button, titleBar, messanger._uiTitleBg, "Button_Close", 0)
    messanger._uiClose:addInputEvent("Mouse_LUp", "FriendMessanger_Close(" .. messangerIdstr .. ")")
    messanger._uiSmall = messanger:createControl(__ePAUIControl_Button, titleBar, messanger._uiTitleBg, "Button_Small", 0)
    messanger._uiSmall:addInputEvent("Mouse_LUp", "FriendMessangerFloating_OpenMessanger(" .. messangerIdstr .. "," .. tostring(friendUserNo) .. ")")
    messanger._uiPopup = messanger:createControl(__ePAUIControl_CheckButton, titleBar, messanger._uiTitleBg, "CheckButton_PopUp", 0)
    messanger._uiPopup:addInputEvent("Mouse_LUp", "FriendMessanger_CheckPopupUI(" .. messangerIdstr .. ")")
    messanger._uiAlarm = messanger:createControl(__ePAUIControl_CheckButton, titleBar, messanger._uiTitleBg, "CheckButton_Alarm", 0)
    messanger._uiAlarm:addInputEvent("Mouse_LUp", "FriendMessanger_AlarmToggle(" .. messangerIdstr .. ")")
    messanger._uiSlider = messanger:createControl(__ePAUIControl_Slider, titleBar, messanger._uiTitleBg, "Slider_Alpha", 0)
    messanger._uiSlider:SetInterval(100)
    messanger._uiSlider:SetControlPos(100)
    messanger._uiSlider:addInputEvent("Mouse_LPress", "FriendMessanger_AlphaSlider( " .. messangerIdstr .. ")")
    messanger._uiSlider:addInputEvent("Mouse_LUp", "FriendMessanger_AlphaSlider( " .. messangerIdstr .. ")")
    messanger._uiSliderButton = messanger._uiSlider:GetControlButton()
    messanger._uiSliderButton:addInputEvent("Mouse_LPress", "FriendMessanger_AlphaSlider( " .. messangerIdstr .. ")")
    messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "FriendMessanger_AlphaSliderForPad(" .. messangerIdstr .. ",false)")
    messanger._mainPanel:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "FriendMessanger_AlphaSliderForPad(" .. messangerIdstr .. ",true)")
    messanger._uiFrame = messanger:createControl(__ePAUIControl_Frame, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Frame_Chat", 0)
    messanger._uiFrameContent = messanger._uiFrame:GetFrameContent()
    messanger._uiFrameScroll = messanger._uiFrame:GetVScroll()
    messanger._uiFrameHScroll = messanger._uiFrame:GetHScroll()
    local styleFrame = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Frame_Chat")
    local styleScroll = UI.getChildControl(styleFrame, "Frame_1_VerticalScroll")
    CopyBaseProperty(styleScroll, messanger._uiFrameScroll)
    messanger._uiFrameHScroll:SetIgnoreChild(true)
    messanger._uiFrameContent:SetSize(0, 0)
    messanger._uiEditGroup = messanger:createControl(__ePAUIControl_Static, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Static_EditGroup", 0)
    messanger._uiEnter = messanger:createControl(__ePAUIControl_Button, editGroup, messanger._uiEditGroup, "Button_Enter", 0)
    messanger._uiEnter:addInputEvent("Mouse_LUp", "friend_sendMessage(" .. messangerIdstr .. ")")
    messanger._uiEnter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_BTN"))
    messanger._uiEnter:SetSize(messanger._uiEnter:GetTextSizeX() + 30, messanger._uiEnter:GetSizeY())
    messanger._uiPartyInvite = messanger:createControl(__ePAUIControl_Button, editGroup, messanger._uiEditGroup, "Button_Invite", 0)
    messanger._uiPartyInvite:addInputEvent("Mouse_LUp", "FriendMessanger_PartyInvite(" .. messangerIdstr .. ")")
    messanger._uiPartyInvite:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_PARTY"))
    messanger._uiPartyInvite:SetSize(messanger._uiPartyInvite:GetTextSizeX() + 30, messanger._uiPartyInvite:GetSizeY())
    messanger._uiPartyInvite:SetPosX(messanger._uiEditGroup:GetPosX() + messanger._uiEditGroup:GetSizeX() - messanger._uiPartyInvite:GetSizeX() - 15)
    messanger._uiEnter:SetPosX(messanger._uiPartyInvite:GetPosX() - messanger._uiEnter:GetSizeX() - 5)
    messanger._uiEmo = messanger:createControl(__ePAUIControl_Static, editGroup, messanger._uiEditGroup, "Static_Emo", 0)
    messanger._uiEmo:addInputEvent("Mouse_LUp", "friend_openChatMacro(" .. messangerIdstr .. ")")
    messanger._uiEditInputChat = messanger:createControl(__ePAUIControl_Edit, editGroup, messanger._uiEditGroup, "Edit_1", 0)
    messanger._uiEditInputChat:SetSize(messanger._uiEditGroup:GetSizeX() - messanger._uiEnter:GetSizeX() * 2 - 30, messanger._uiEditGroup:GetSizeY())
    messanger._uiEditInputChat:SetMaxInput(100)
    messanger._uiEditInputChat:setOnMouseCursorType(__eMouseCursorType_Text)
    messanger._uiEditInputChat:setClickMouseCursorType(__eMouseCursorType_Text)
    messanger._uiEditInputChat:SetEnable(true)
    messanger._uiEnter:SetEnable(true)
    messanger._uiEditInputChat:addInputEvent("Mouse_LUp", "FriendMessanger_SetFocusEdit(" .. messangerIdstr .. ")")
    if true == _ContentsGroup_RenewUI then
      messanger._uiEditInputChat:setXboxVirtualKeyBoardEndEvent("friend_sendMessageByKey")
    else
      messanger._uiEditInputChat:RegistReturnKeyEvent("friend_sendMessageByKey()")
    end
    messanger._uiSizeControl = messanger:createControl(__ePAUIControl_Button, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Button_SizeControl", 0)
    messanger._uiSizeControl:addInputEvent("Mouse_LDown", "FriendMessanger_ResizeStartPos( " .. messangerIdstr .. " )")
    messanger._uiSizeControl:addInputEvent("Mouse_LPress", "FriendMessanger_Resize( " .. messangerIdstr .. " )")
    messanger._uiSizeControl:setOnMouseCursorType(__eMouseCursorType_ResizeLeft)
    messanger._uiSizeControl:setClickMouseCursorType(__eMouseCursorType_ResizeLeft)
    messanger._keyguideBg = messanger:createControl(__ePAUIControl_Static, Panel_Friend_TalkMessanger_All, messanger._mainPanel, "Static_KeyGuide_Console", 0)
    messanger._keyguideClose = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Close_Console", 0)
    messanger._keyguideSend = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Send_Console", 0)
    messanger._keyguideScroll = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Scroll_Console", 0)
    messanger._keyguideEmo = messanger:createControl(__ePAUIControl_StaticText, keyguideBg, messanger._keyguideBg, "StaticText_Emot", 0)
    if true == _ContentsGroup_UsePadSnapping then
      messanger._keyguideBg:SetShow(true)
      messanger._uiEditInputChat:SetSize(messanger._uiEditInputChat:GetSizeX() + messanger._uiEnter:GetSizeX(), messanger._uiEditInputChat:GetSizeY())
      messanger._uiClose:SetShow(false)
      messanger._uiEnter:SetShow(false)
      messanger._uiSizeControl:SetShow(false)
      messanger._uiPartyInvite:SetShow(false)
      messanger._keyguideBg:ComputePos()
    else
      messanger._uiPartyInvite:SetShow(true)
      messanger._keyguideBg:SetShow(false)
    end
    messanger._uiEmo:SetSpanSize(messanger._uiEnter:GetSpanSize().x + messanger._uiEnter:GetSizeX() + 10, messanger._uiEmo:GetSpanSize().y)
    messanger._uiEditInputChat:SetSize(messanger._uiEditGroup:GetSizeX() - (messanger._uiEnter:GetSizeX() * 2 + messanger._uiEmo:GetSizeX()) - 40, messanger._uiEditGroup:GetSizeY())
    messanger._uiEditInputChat:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_DESC"))
  end
  function messanger:createControl(controlType, parentStyleControl, parentControl, controlName, index)
    local styleControl = UI.getChildControl(parentStyleControl, controlName)
    local control = UI.createControl(controlType, parentControl, controlName .. index)
    CopyBaseProperty(styleControl, control)
    return control
  end
  function messanger:clearAllMessage()
    for index = 0, messanger._messageCount - 1 do
      messanger._uiStaticBg[index]:SetShow(false)
      messanger._uiStaticTime[index]:SetShow(false)
      messanger._uiClassIcon[index]:SetShow(false)
      messanger._emoticonAni[index]:SetShow(false)
      UI.deleteControl(messanger._uiStaticBg[index])
      UI.deleteControl(messanger._uiStaticTime[index])
      UI.deleteControl(messanger._uiClassIcon[index])
      UI.deleteControl(messanger._emoticonAni[index])
      for _, info in pairs(messanger._uiStaticText[index]) do
        if nil ~= info.content then
          info.content:SetShow(false)
          UI.deleteControl(info.content)
        end
      end
    end
    messanger._messageCount = 0
    messanger._messageIndex = nil
    messanger._contentIndex = nil
  end
  function messanger:updateMessage(chattingMessage, friendClass, isOnline)
    messanger:showMessage(chattingMessage, friendClass, isOnline)
    messanger._messageCount = messanger._messageCount + 1
  end
  function messanger:showMessage(chattingMessage, friendClass, isOnline)
    local msg = chattingMessage:getContent()
    local msgTime = chattingMessage:getTime()
    local isMe = chattingMessage.isMe
    messanger:createMessageUI(chattingMessage)
    messanger:resizeMessageUI(isMe, msg, msgTime, friendClass, isOnline)
    messanger:setPosMessageUI(isMe)
  end
  function messanger:resizeMessageUI(isMe, msg, msgTime, friendClass, isOnline)
    local panelSizeX = messanger._mainPanel:GetSizeX()
    local maxTextSizeX = panelSizeX - 100
    local maxTimeTextSize = 100
    local staticText = messanger._uiStaticText[messanger._messageCount]
    local staticBg = messanger._uiStaticBg[messanger._messageCount]
    local staticTime = messanger._uiStaticTime[messanger._messageCount]
    local staticClass = messanger._uiClassIcon[messanger._messageCount]
    local contentXSize = 0
    local contentYSize = 0
    for _, info in pairs(staticText) do
      if nil ~= info.content then
        if false == info.isEmoticon then
          if false == isMe then
            info.content:SetFontColor(Defines.Color.C_FF6C6C6C)
          else
            info.content:SetFontColor(Defines.Color.C_FFFFEDD4)
          end
        end
        if false == info.isEmoticon then
          info.content:SetSize(info.content:GetTextSizeX(), PaGlobal_FriendMessanger_All._emoticonSize)
        else
          info.content:SetSize(info.content:GetSizeX(), PaGlobal_FriendMessanger_All._emoticonSize)
        end
        if false == info.isEmoticon then
          contentXSize = contentXSize + info.content:GetTextSizeX()
        else
          contentXSize = contentXSize + info.content:GetSizeX()
        end
        contentYSize = info.content:GetSizeY()
      end
    end
    if maxTextSizeX < contentXSize then
      local lineCount = math.floor(contentXSize / maxTextSizeX)
      contentYSize = contentYSize * (lineCount + 1)
      contentXSize = maxTextSizeX
    end
    staticTime:SetFontColor(Defines.Color.C_FF988D83)
    staticTime:SetSize(maxTimeTextSize, staticTime:GetSizeY())
    local timeValue = PATime(msgTime)
    local monthString = timeValue:GetMonth()
    if timeValue:GetMonth() < 10 then
      monthString = "0" .. tostring(monthString)
    end
    local dayString = timeValue:GetDay()
    if 10 > timeValue:GetDay() then
      dayString = "0" .. tostring(dayString)
    end
    local hourString = timeValue:GetHour()
    if 10 > timeValue:GetHour() then
      hourString = "0" .. tostring(hourString)
    end
    local minuteString = timeValue:GetMinute()
    if 10 > timeValue:GetMinute() then
      minuteString = "0" .. tostring(minuteString)
    end
    staticTime:SetText(timeValue:GetYear() .. "/" .. monthString .. "/" .. dayString .. " " .. hourString .. ":" .. minuteString)
    if true == isOnline then
      PaGlobal_Friend_SetTexture(staticClass, friendClass)
    else
      PaGlobal_Friend_SetTexture(staticClass, __eClassType_Count)
    end
    staticBg:SetSize(contentXSize + 20, contentYSize + 15)
  end
  function messanger:createMessageUI(chattingMessage)
    local msg = chattingMessage:getContent()
    local isMe = chattingMessage.isMe
    local emoticonCount = chattingMessage:getEmoticonCount()
    local frameChat = UI.getChildControl(Panel_Friend_TalkMessanger_All, "Frame_Chat")
    local frameContent = UI.getChildControl(frameChat, "Frame_1_Content")
    local styleBg = UI.getChildControl(frameContent, "Static_To")
    local styleText = UI.getChildControl(styleBg, "StaticText_To")
    local styleEmoticon = UI.getChildControl(styleBg, "Static_ChatEmoticon")
    local styleTime = UI.getChildControl(styleBg, "StaticText_Time")
    local styleClass = UI.getChildControl(styleBg, "Static_ClassIcon")
    local styleEmoAni = UI.getChildControl(styleBg, "Static_ChatEmoticon_SequenceAni")
    if false == isMe then
      styleBg = UI.getChildControl(frameContent, "Static_From")
      styleText = UI.getChildControl(styleBg, "StaticText_From")
      styleEmoticon = UI.getChildControl(styleBg, "Static_ChatEmoticon")
      styleTime = UI.getChildControl(styleBg, "StaticText_Time")
      styleClass = UI.getChildControl(styleBg, "Static_ClassIcon")
      styleEmoAni = UI.getChildControl(styleBg, "Static_ChatEmoticon_SequenceAni")
    end
    messanger._uiStaticBg[messanger._messageCount] = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_BG_" .. messanger._messageCount)
    messanger._uiStaticTime[messanger._messageCount] = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Time_" .. messanger._messageCount)
    messanger._uiClassIcon[messanger._messageCount] = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_Class_" .. messanger._messageCount)
    messanger._uiStaticText[messanger._messageCount] = {}
    CopyBaseProperty(styleBg, messanger._uiStaticBg[messanger._messageCount])
    CopyBaseProperty(styleTime, messanger._uiStaticTime[messanger._messageCount])
    CopyBaseProperty(styleClass, messanger._uiClassIcon[messanger._messageCount])
    messanger._messageIndex = nil
    messanger._contentIndex = nil
    local contentindex = 0
    local msgstartindex = 0
    local textSizeX = messanger._mainPanel:GetSizeX() - 100
    local curTextSizeX = 0
    if 0 ~= emoticonCount then
      local emoNum = 1
      while emoticonCount >= emoNum do
        local emoticonindex = chattingMessage:getEmoticonIndex(emoNum - 1)
        local emoticonKey = chattingMessage:getEmoticonKey(emoNum - 1)
        local contentInfo = {}
        contentInfo.content = nil
        contentInfo.isEmoticon = false
        contentInfo.emoticonKey = 0
        contentInfo.contentCount = 0
        if msgstartindex == emoticonindex then
          local emoticonControl = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_Emo_" .. messanger._messageCount .. "_" .. contentindex)
          CopyBaseProperty(styleEmoticon, emoticonControl)
          emoticonControl:SetShow(true)
          emoticonControl:ChangeTextureInfoNameAsync(chattingMessage:getEmoticonPath(emoNum - 1))
          contentInfo.content = emoticonControl
          contentInfo.isEmoticon = true
          contentInfo.emoticonKey = emoticonKey
          messanger._uiStaticText[messanger._messageCount][contentindex] = contentInfo
          if nil == messanger._messageIndex or nil == messanger._contentIndex then
            messanger._messageIndex = messanger._messageCount
            messanger._contentIndex = contentindex
          end
          emoNum = emoNum + 1
          contentindex = contentindex + 1
          curTextSizeX = curTextSizeX + contentInfo.content:GetSizeX()
        else
          local msgData = string.sub(msg, msgstartindex + 1, emoticonindex)
          local msgDataLen = string.len(msgData)
          local checkmsg = ""
          while msgDataLen > 0 do
            local contentInfo = {}
            contentInfo.content = nil
            contentInfo.isEmoticon = false
            contentInfo.emoticonKey = 0
            local textControl = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Text_" .. messanger._messageCount .. "_" .. contentindex)
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
            checkmsg, msgData, msgDataLen = messanger:getTextLimitWidth(contentInfo.content, msgData)
            contentInfo.content:SetText(checkmsg)
            messanger._uiStaticText[messanger._messageCount][contentindex] = contentInfo
            contentindex = contentindex + 1
            curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
            if "" == checkmsg or nil == checkmsg then
              break
            end
          end
          msgstartindex = emoticonindex
        end
      end
      local msgData = string.sub(msg, msgstartindex + 1, string.len(msg))
      local msgDataLen = string.len(msgData)
      local checkmsg = ""
      while msgDataLen > 0 do
        local contentInfo = {}
        contentInfo.content = nil
        contentInfo.isEmoticon = false
        contentInfo.emoticonKey = 0
        local textControl = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Text_" .. messanger._messageCount .. "_" .. contentindex)
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
        checkmsg, msgData, msgDataLen = messanger:getTextLimitWidth(contentInfo.content, msgData)
        contentInfo.content:SetText(checkmsg)
        messanger._uiStaticText[messanger._messageCount][contentindex] = contentInfo
        contentindex = contentindex + 1
        curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
        if "" == checkmsg or nil == checkmsg then
          break
        end
      end
      msgstartindex = string.len(msg)
    else
      local msgData = string.sub(msg, msgstartindex + 1, string.len(msg))
      local msgDataLen = string.len(msgData)
      local checkmsg = ""
      while msgDataLen > 0 do
        local contentInfo = {}
        contentInfo.content = nil
        contentInfo.isEmoticon = false
        contentInfo.emoticonKey = 0
        local textControl = UI.createControl(__ePAUIControl_StaticText, messanger._uiFrameContent, "Static_Text_" .. messanger._messageCount .. "_" .. contentindex)
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
        checkmsg, msgData, msgDataLen = messanger:getTextLimitWidth(contentInfo.content, msgData)
        contentInfo.content:SetText(checkmsg)
        contentInfo.content:SetSize(textControl:GetTextSizeX(), textControl:GetSizeY())
        messanger._uiStaticText[messanger._messageCount][contentindex] = contentInfo
        contentindex = contentindex + 1
        curTextSizeX = curTextSizeX + textControl:GetTextSizeX()
        if "" == checkmsg or nil == checkmsg then
          break
        end
      end
      msgstartindex = string.len(msg)
    end
    messanger._emoticonAni[messanger._messageCount] = UI.createControl(__ePAUIControl_Static, messanger._uiFrameContent, "Static_EmoAni_" .. messanger._messageCount)
    CopyBaseProperty(styleEmoAni, messanger._emoticonAni[messanger._messageCount])
    messanger._uiStaticBg[messanger._messageCount]:SetShow(true)
    messanger._uiStaticTime[messanger._messageCount]:SetIgnore(true)
    messanger._uiStaticTime[messanger._messageCount]:SetShow(true)
    messanger._emoticonAni[messanger._messageCount]:SetShow(false)
    if false == isMe then
      messanger._uiClassIcon[messanger._messageCount]:SetIgnore(true)
      messanger._uiClassIcon[messanger._messageCount]:SetShow(true)
    else
      messanger._uiClassIcon[messanger._messageCount]:SetIgnore(true)
      messanger._uiClassIcon[messanger._messageCount]:SetShow(false)
    end
    PaGlobal_FriendMessanger_All._emoticonSize = styleEmoticon:GetSizeY()
  end
  function messanger:setPosMessageUI(isMe)
    local contentStartPosX = 0
    local contentStartPosY = 0
    local prevBgSizeY = 0
    local prevBgPosY = 0
    local preTimeSizeY = messanger._uiStaticBg[messanger._messageCount]:GetSizeY() + 1
    if 0 < messanger._messageCount then
      prevBgSizeY = messanger._uiStaticBg[messanger._messageCount - 1]:GetSizeY()
      prevBgPosY = messanger._uiStaticBg[messanger._messageCount - 1]:GetPosY() + preTimeSizeY
    end
    if false == isMe then
      messanger._uiClassIcon[messanger._messageCount]:SetPosX(5)
      messanger._uiStaticBg[messanger._messageCount]:SetPosX(messanger._uiClassIcon[messanger._messageCount]:GetPosX() + messanger._uiClassIcon[messanger._messageCount]:GetSizeX() + 10)
      messanger._uiStaticTime[messanger._messageCount]:SetPosX(messanger._uiStaticBg[messanger._messageCount]:GetPosX() + 5)
      contentStartPosX = messanger._uiStaticBg[messanger._messageCount]:GetPosX() + 10
    else
      messanger._uiStaticBg[messanger._messageCount]:SetPosX(messanger._uiFrameScroll:GetPosX() - messanger._uiStaticBg[messanger._messageCount]:GetSizeX() - 10)
      messanger._uiStaticTime[messanger._messageCount]:SetPosX(messanger._mainPanel:GetSizeX() - messanger._uiStaticTime[messanger._messageCount]:GetSizeX() - 15)
      contentStartPosX = messanger._mainPanel:GetSizeX() - messanger._uiStaticBg[messanger._messageCount]:GetSizeX() - 15
    end
    messanger._uiStaticBg[messanger._messageCount]:SetPosY(prevBgPosY + prevBgSizeY)
    messanger._uiStaticTime[messanger._messageCount]:SetPosY(messanger._uiStaticBg[messanger._messageCount]:GetPosY() + messanger._uiStaticBg[messanger._messageCount]:GetSizeY() + 5)
    messanger._uiClassIcon[messanger._messageCount]:SetPosY(messanger._uiStaticBg[messanger._messageCount]:GetPosY())
    contentStartPosY = messanger._uiStaticBg[messanger._messageCount]:GetPosY() + 10
    local panelSizeX = messanger._mainPanel:GetSizeX()
    local maxTextSizeX = panelSizeX - 100
    local curTextSizeX = 0
    local index = 0
    local addPosY = 5
    local staticText = messanger._uiStaticText[messanger._messageCount]
    while true do
      if nil == staticText[index] then
        break
      end
      local info = staticText[index]
      if nil ~= info.content then
        local tempSizeX = curTextSizeX + info.content:GetSizeX()
        if maxTextSizeX < tempSizeX then
          curTextSizeX = 0
          contentStartPosY = contentStartPosY + info.content:GetSizeY()
        end
        info.content:SetPosX(contentStartPosX + curTextSizeX)
        info.content:SetPosY(contentStartPosY)
        if false == info.isEmoticon then
          curTextSizeX = curTextSizeX + info.content:GetTextSizeX()
          info.content:SetPosY(contentStartPosY + addPosY)
        else
          curTextSizeX = curTextSizeX + info.content:GetSizeX()
          info.content:SetPosY(contentStartPosY - addPosY)
        end
        index = index + 1
      end
    end
  end
  function messanger:getTextLimitWidth(chatting_contents, msgOrigin)
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
  messanger:initialize(messangerIdstr, userName, friendUserNo, isOnline)
  return messanger
end
function FriendMessanger_AlphaSlider(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._mainPanel
  if nil == panel then
    return
  end
  messanger._messangerAlpha = math.max(messanger._uiSlider:GetControlPos(), 0.1)
  panel:SetAlpha(messanger._messangerAlpha)
  messanger._uiEditGroup:SetAlpha(messanger._messangerAlpha)
end
function FriendMessanger_AlphaSliderForPad(messangerIdstr, isUp)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._mainPanel
  if nil == panel then
    return
  end
  if true == isUp then
    messanger._messangerAlpha = messanger._messangerAlpha + 0.1
    messanger._messangerAlpha = math.min(messanger._messangerAlpha, 1)
  else
    messanger._messangerAlpha = messanger._messangerAlpha - 0.1
    messanger._messangerAlpha = math.max(messanger._messangerAlpha, 0)
  end
  messanger._uiSlider:SetControlPos(messanger._messangerAlpha * 100)
  panel:SetAlpha(messanger._messangerAlpha)
  messanger._keyguideBg:SetAlpha(messanger._messangerAlpha)
end
local orgMouseX = 0
local orgMouseY = 0
local orgPanelSizeX = 0
local orgPanelSizeY = 0
local orgPanelPosY = 0
local scrollPos = 0
function FriendMessanger_ResizeStartPos(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._mainPanel
  if nil == panel then
    return
  end
  orgMouseX = getMousePosX()
  orgMouseY = getMousePosY()
  orgPanelPosX = panel:GetPosX()
  orgPanelSizeX = panel:GetSizeX()
  orgPanelSizeY = panel:GetSizeY()
  scrollPos = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]._uiFrameScroll:GetControlPos()
end
function FriendMessanger_Resize(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local panel = messanger._mainPanel
  if nil == panel then
    return
  end
  local currentPosX = panel:GetPosX()
  local currentX = getMousePosX()
  local currentY = getMousePosY()
  local deltaX = orgMouseX - currentX
  local deltaY = currentY - orgMouseY
  local sizeX = orgPanelSizeX + deltaX
  local sizeY = orgPanelSizeY + deltaY
  if sizeX > PaGlobal_FriendMessanger_All._messangerMaxSizeX then
    sizeX = PaGlobal_FriendMessanger_All._messangerMaxSizeX
  elseif sizeX < PaGlobal_FriendMessanger_All._messangerMinSizeX then
    sizeX = PaGlobal_FriendMessanger_All._messangerMinSizeX
  end
  if sizeY > PaGlobal_FriendMessanger_All._messangerMaxSizeY then
    sizeY = PaGlobal_FriendMessanger_All._messangerMaxSizeY
  elseif sizeY < PaGlobal_FriendMessanger_All._messangerMinSizeY then
    sizeY = PaGlobal_FriendMessanger_All._messangerMinSizeY
  end
  local currentSizeX = panel:GetSizeX()
  local currentSizeY = panel:GetSizeY()
  local titleSizeY = 50
  local gap = 10
  panel:SetSize(sizeX, sizeY)
  panel:SetPosX(currentPosX + currentSizeX - sizeX)
  messanger._uiTitleBg:SetSize(sizeX - 2, titleSizeY)
  messanger._uiClose:SetPosX(panel:GetSizeX() - messanger._uiClose:GetSizeX() - gap)
  messanger._uiPopup:SetPosX(messanger._uiClose:GetPosX() - messanger._uiPopup:GetSizeX() - gap)
  messanger._uiSmall:SetPosX(messanger._uiPopup:GetPosX() - messanger._uiSmall:GetSizeX() - gap)
  messanger._uiSlider:SetPosX(messanger._uiSmall:GetPosX() - messanger._uiSlider:GetSizeX() - gap)
  messanger._uiFrameScroll:SetControlPos(scrollPos)
  messanger._uiSizeControl:SetPosY(panel:GetSizeY() - messanger._uiSizeControl:GetSizeY())
  messanger._uiEditGroup:SetPosX(gap)
  messanger._uiEditGroup:SetPosY(panel:GetSizeY() - messanger._uiEditGroup:GetSizeY() - gap)
  messanger._uiEditGroup:SetSize(panel:GetSizeX() - gap * 2, messanger._uiEditGroup:GetSizeY())
  messanger._uiPartyInvite:SetPosX(messanger._uiEditGroup:GetPosX() + messanger._uiEditGroup:GetSizeX() - messanger._uiPartyInvite:GetSizeX() - gap * 1.5)
  messanger._uiEnter:SetPosX(messanger._uiPartyInvite:GetPosX() - messanger._uiEnter:GetSizeX() - gap * 0.5)
  messanger._uiEditInputChat:SetSize(messanger._uiEditGroup:GetSizeX() - messanger._uiEnter:GetSizeX() * 2 - gap * 3, messanger._uiEditGroup:GetSizeY())
  messanger._uiEditInputChat:SetEditText(messanger._uiEditInputChat:GetEditText())
  messanger._uiFrame:SetSize(panel:GetSizeX(), panel:GetSizeY() - messanger._uiEditGroup:GetSizeY() - messanger._uiTitleBg:GetSizeY() - gap)
  messanger._uiFrameContent:SetSize(messanger._uiFrame:GetSizeX(), messanger._uiFrame:GetSizeY())
  messanger._uiEditInputChat:SetSize(messanger._uiEditGroup:GetSizeX() - (messanger._uiEnter:GetSizeX() * 2 + messanger._uiEmo:GetSizeX() * 2) - gap * 4, messanger._uiEditGroup:GetSizeY())
  if true == _ContentsGroup_UsePadSnapping then
    messanger._keyguideBg:SetSize(panel:GetSizeX(), messanger._keyguideBg:GetSizeY())
    messanger._keyguideBg:ComputePos()
    local keyGuides = {
      messanger._keyguideEmo,
      messanger._keyguideScroll,
      messanger._keyguideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, messanger._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  FriendMessanger_ListUpdate(messangerIdstr, false)
end
function FriendMessanger_CheckPopupUI(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if true == messanger._uiPopup:IsCheck() then
    messanger._mainPanel:OpenUISubApp()
  else
    messanger._mainPanel:CloseUISubApp()
  end
  PaGlobalFunc_ChatEmoticon_CloseByMessanger(messangerIdstr)
end
function FriendMessanger_AlarmToggle(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if true == messanger._uiAlarm:IsCheck() then
    ToClient_UpdateMessengerAlarm(tonumber64(messangerIdstr), __eMessengerTypeFriend, false)
  else
    ToClient_UpdateMessengerAlarm(tonumber64(messangerIdstr), __eMessengerTypeFriend, true)
  end
end
function FriendMessanger_OnMouseWheel(messangerIdstr, isUp)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local targetScroll = messanger._uiFrameScroll
  if isUp then
    targetScroll:ControlButtonUp()
  else
    targetScroll:ControlButtonDown()
  end
  messanger._uiFrame:UpdateContentPos()
end
function FriendMessanger_CheckCurrentUiEdit(targetUI)
  if toInt64(0, -1) == PaGlobal_FriendMessanger_All._currentMessangerId then
    return false
  end
  local messanger = PaGlobal_FriendMessanger_All._messangerList[PaGlobal_FriendMessanger_All._currentMessangerId]
  if nil == messanger then
    return
  end
  local currentEdit = messanger._uiEditInputChat
  if nil == currentEdit then
    return
  end
  return nil ~= targetUI and targetUI:GetKey() == currentEdit:GetKey()
end
function FriendMessanger_Close(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if true == messanger._uiPopup:IsCheck() then
    messanger._mainPanel:CloseUISubApp()
  end
  ToClient_CloseFriendMessenger(tonumber64(messangerIdstr), __eMessengerTypeFriend)
  messanger._mainPanel:SetShow(false)
  messanger:clear()
  PaGlobal_FriendMessanger_All._messangerList[messangerIdstr] = nil
  if messangerIdstr == PaGlobal_FriendMessanger_All._currentMessangerId then
    PaGlobal_FriendMessanger_All._currentMessangerId = toInt64(0, -1)
    ClearFocusEdit()
  end
  CheckChattingInput()
  if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_FriendInfo_All and true == Panel_FriendInfo_All:GetShow() then
    ToClient_padSnapSetTargetPanel(Panel_FriendInfo_All)
  end
  PaGlobalFunc_ChatEmoticon_CloseByMessanger(messangerIdstr)
end
function FriendMessanger_SetFocusEdit(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  SetFocusEdit(messanger._uiEditInputChat)
  PaGlobal_FriendMessanger_All._currentMessangerId = messangerIdstr
  if PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_DESC") == messanger._uiEditInputChat:GetEditText() then
    messanger._uiEditInputChat:SetEditText("")
  end
end
function FriendMessanger_KillFocusEdit()
  if toInt64(0, -1) == PaGlobal_FriendMessanger_All._currentMessangerId then
    return false
  end
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_FriendMessanger_All._currentMessangerId = toInt64(0, -1)
  PaGlobal_FriendInfoList_All:hidePopupMenu()
  return false
end
function FriendMessanger_IsFocusEdit()
  if toInt64(0, -1) == PaGlobal_FriendMessanger_All._currentMessangerId then
    return false
  end
  return true
end
function friend_sendMessageByKey()
  local messangerIdstr = tostring(PaGlobal_FriendMessanger_All._currentMessangerId)
  friend_sendMessage(messangerIdstr)
  PaGlobalFunc_ChatEmoticon_CloseByMessanger(messangerIdstr)
end
function friend_killFocusMessangerByKey()
  FriendMessanger_KillFocusEdit()
end
function friend_sendMessage(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local friendUserNo = messanger._friendUserNo
  if nil == friendUserNo then
    return
  end
  ToClient_SetSenderMessengerNo(tonumber64(messangerIdstr))
  ToClient_SetSenderMessengerType(__eMessengerTypeFriend)
  if PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_DESC") == messanger._uiEditInputChat:GetEditText() then
    messanger._uiEditInputChat:SetEditText("")
  end
  chatting_sendMessageByUserNo(friendUserNo, messanger._uiEditInputChat:GetEditText(), CppEnums.ChatType.Messenger)
  messanger._uiEditInputChat:SetEditText("", true)
  PaGlobalFunc_ChatEmoticon_CloseByMessanger(messangerIdstr)
end
function friend_openChatMacro(messangerIdstr)
  messangerIdstr = tostring(messangerIdstr)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  SetFocusEdit(messanger._uiEditInputChat)
  local posX = messanger._mainPanel:GetPosX() + messanger._mainPanel:GetSizeX()
  local posY = messanger._mainPanel:GetPosY()
  if true == messanger._uiPopup:IsCheck() then
    posX = messanger._uiTitleBg:GetScreenParentPosX() + messanger._uiTitleBg:GetParentPosX() + messanger._mainPanel:GetSizeX()
    posY = messanger._uiTitleBg:GetScreenParentPosY() + messanger._uiTitleBg:GetParentPosY()
  end
  PaGlobalFunc_ChatEmoticon_OpenByMessanger(posX, posY, messangerIdstr, messanger._uiPopup:IsCheck())
  if PAGetString(Defines.StringSheet_RESOURCE, "FRIEND_STCTXT_EDIT_DESC") == messanger._uiEditInputChat:GetEditText() then
    PaGlobal_FriendInfoList_All._ui.stc_Edit:SetEditText("")
  end
end
function friend_inputEmoticon(inputStr)
  if toInt64(0, -1) == PaGlobal_FriendMessanger_All._currentMessangerId then
    return
  end
  ReleaseImeComposition()
  local messangerIdstr = tostring(PaGlobal_FriendMessanger_All._currentMessangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  SetFocusEdit(messanger._uiEditInputChat)
  local message = messanger._uiEditInputChat:GetEditText()
  local originTextSize = messanger._uiEditInputChat:GetEditTextSize()
  if originTextSize > 0 then
    messanger._uiEditInputChat:AddEditText(inputStr)
  else
    messanger._uiEditInputChat:SetEditText(message .. inputStr, true)
  end
end
function FriendMessanger_ListUpdate(messangerIdstr, isEmoticonPlay)
  ToClient_sortMessengerMessage()
  messangerIdstr = tostring(messangerIdstr)
  local messangerId_s64 = tonumber64(messangerIdstr)
  local messengerInfo = ToClient_GetMessengerInfo(messangerId_s64)
  if nil == messengerInfo then
    return
  end
  local message = messengerInfo:beginMessage()
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(messangerId_s64)
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local friendClass = friendInfo:getClassType()
  local isOnline = friendInfo:isOnline()
  if 0 < messanger._messageCount then
    messanger:clearAllMessage()
  end
  while message ~= nil do
    messanger:updateMessage(message, friendClass, isOnline)
    message = messengerInfo:nextMessage()
  end
  messanger._uiAlarm:SetCheck(not messengerInfo:getAlarmIsOn())
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
  if true == _ContentsGroup_UsePadSnapping then
    if true == messanger._uiFrameScroll:GetShow() then
      messanger._keyguideScroll:SetShow(true)
    else
      messanger._keyguideScroll:SetShow(false)
    end
    local keyGuides = {
      messanger._keyguideEmo,
      messanger._keyguideScroll,
      messanger._keyguideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, messanger._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  if true == isEmoticonPlay then
    FriendMessanger_EmoticonAni(messangerId_s64)
  end
end
function FriendMessanger_IsOpenMessanger(messangerId)
  local messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return false
  end
  return true
end
function FriendMessanger_PartyInvite(messangerIdstr)
  local friendUserNo = ToClient_GetMessengerInFriendUserNo(tonumber64(messangerIdstr))
  if toInt64(0, 0) == friendUserNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoStaticStatusInvalidValue"))
    return
  end
  local friendInfo = ToClient_getFreindInfoByUserNo(friendUserNo)
  if nil == friendInfo then
    return
  end
  local userCharacterName = friendInfo:getCharacterName()
  local isOnline = friendInfo:isOnline()
  local groupNo = friendInfo:getGroupNo()
  local userNo = friendInfo:getUserNo()
  local isSelfPlayerPlayingPvPMatch = getSelfPlayer():isDefinedPvPMatch()
  if true == RequestFriends_isBlockedFriend(userNo, groupNo) then
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_DONOTHAVE_PRIVILEGE")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = MessageBox_Empty_function,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  if nil ~= userCharacterName and "" ~= userCharacterName then
    local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
    local isEnterPersonalRelayField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
    if isSelfPlayerPlayingPvPMatch == false and isEnterPersonalField == false and isEnterPersonalRelayField == false then
      Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_ACK_INVITE", "targetName", userCharacterName))
    end
  end
  RequestParty_inviteCharacter(userCharacterName)
end
function FriendMessanger_EmoticonAni(messangerId)
  local messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  if nil == messanger._messageIndex or nil == messanger._contentIndex then
    return
  end
  local emoticonControl = messanger._uiStaticText[messanger._messageIndex][messanger._contentIndex].content
  if nil == emoticonControl then
    return
  end
  local emoticonKey = messanger._uiStaticText[messanger._messageIndex][messanger._contentIndex].emoticonKey
  if nil == emoticonKey then
    return
  end
  local emoticonAniControl = messanger._emoticonAni[messanger._messageIndex]
  if nil == emoticonAniControl then
    return
  end
  local EmoticonSS = ToClient_getEmoticonInfoByKey(emoticonKey)
  if nil ~= EmoticonSS then
    local ImagePath = EmoticonSS:getSequenceImagePath()
    if nil == ImagePath then
      return
    end
    emoticonAniControl:ChangeTextureInfoNameAsync(ImagePath)
    emoticonAniControl:SetPosX(emoticonControl:GetPosX())
    emoticonAniControl:SetPosY(emoticonControl:GetPosY() - emoticonAniControl:GetSizeY() * 0.5)
    emoticonAniControl:setUpdateTextureAni(true)
    emoticonAniControl:SetShow(true)
  end
end
function FromClient_FriendInfoListUpdateMessanger(messangerIdstr)
  FriendMessanger_ListUpdate(messangerIdstr, true)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  messanger._uiFrameScroll:SetControlBottom()
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
end
function FromClient_FriendInfoListOpenMessanger(messangerId, friendUserNo)
  HandleEventLUp_FriendInfoList_All_MessangerCloseInFriendList()
  local messangerIdstr = tostring(messangerId)
  local friendUserNostr = tostring(friendUserNo)
  local friendInfo = ToClient_getFreindInfoByUserNo(tonumber64(friendUserNostr))
  if nil == friendInfo then
    return
  end
  local userName = friendInfo:getName()
  local isOnline = friendInfo:isOnline()
  if nil == PaGlobal_FriendMessanger_All._messangerList[messangerIdstr] then
    PaGlobal_FriendMessanger_All._messangerList[messangerIdstr] = PaGlobal_FriendMessanger_All:createMessanger(messangerIdstr, userName, tonumber64(friendUserNostr), isOnline)
  end
  FromClient_FriendInfoListUpdateMessanger(messangerIdstr)
end
function FromClient_FriendMessangerUpdate(messangerId)
  local messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  FriendMessanger_ListUpdate(messangerIdstr, true)
  messanger._uiFrameScroll:SetControlBottom()
  messanger._uiFrame:UpdateContentScroll()
  messanger._uiFrame:UpdateContentPos()
  messanger._uiFrameScroll:GetControlButton():SetPosX(0)
end
function FromClient_AlarmToggle(messangerId, isOn)
  messangerIdstr = tostring(messangerId)
  local messanger = PaGlobal_FriendMessanger_All._messangerList[messangerIdstr]
  if nil == messanger then
    return
  end
  messanger._uiAlarm:SetCheck(not isOn)
end
