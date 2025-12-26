function PaGlobalFunc_ChatOption_All_Open(penelIdex, drawPanelIndex, isCombinedMainPanel)
  PaGlobal_ChatOption_All:prepareOpen(penelIdex, drawPanelIndex, isCombinedMainPanel)
end
function PaGlobalFunc_ChatOption_All_Close()
  PaGlobal_ChatOption_All:prepareClose()
end
function PaGlobalFunc_ChatOption_All_GetShow()
  if Panel_Window_ChatOption_All == nil then
    return false
  end
  return Panel_Window_ChatOption_All:GetShow()
end
function HandleEventLUp_ChatOption_All_Close()
  PaGlobalFunc_ChatOption_All_Close()
end
function HandleEventLUp_ChatOption_All_ConfirmSetting()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  local panelIndex = PaGlobal_ChatOption_All._panelIndex
  PaGlobal_ChatOption_All:confirmFilter()
  PaGlobal_ChatOption_All:saveOptions()
  ToClient_SaveUiInfo(false)
  PaGlobal_ChatOption_All:dataclear()
  PaGlobal_ChatOption_All:close()
  PaGlobalFunc_ChattingColor_All_Close()
  ToClient_saveChattingPanelOptionLog(panelIndex)
end
function HandleEventLUp_ChatOption_All_SelectAllChatFilter(isSelect)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  for ii = 0, PaGlobal_ChatOption_All._chatOptionData.chatFilterCount - 1 do
    PaGlobal_ChatOption_All._btnFilter[ii].check:SetCheck(isSelect)
    PaGlobal_ChatOption_All._channelFilter[ii] = isSelect
  end
  TooltipSimple_Hide()
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLPress_ChatOption_All_SetTransparency()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  local self = PaGlobal_ChatOption_All
  local transparency = self._ui.btn_sliderTransparent:GetPosX() / (self._ui.slider_transparent:GetSizeX() - self._ui.btn_sliderTransparent:GetSizeX())
  local percent = math.abs(transparency * 100)
  self._ui.txt_transparantNum:SetText(string.format("%.0f", percent))
  self._ui.progress_transparent:SetProgressRate(percent)
  FGlobal_Chatting_PanelTransparency(self._panelIndex, transparency, true)
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_TextSize(textSizeType)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if nil == textSizeType then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  local count = ToClient_getChattingPanelCount()
  for panelIdx = 0, count - 1 do
    local chatPanel = ToClient_getChattingPanel(panelIdx)
    chatPanel:setChatFontSizeType(textSizeType - 1)
  end
  setisChangeFontSize(true)
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_ChattingAnimation(isAniFlag)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if nil == isAniFlag then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eChattingAnimation, isAniFlag, CppEnums.VariableStorageType.eVariableStorageType_User)
  Chatting_setUsedSmoothChattingUp(isAniFlag)
end
function HandleEventLUp_ChatOption_All_EmoticonAutoPlay(isAutoPlay)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if nil == isAutoPlay then
    return
  end
  PaGlobal_ChatOption_All._isUseEmoticonAutoPlay = isAutoPlay
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_ChattingColorReset()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  PaGlobal_ChatOption_All:resetAllChattingColor()
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_ChatFilter(chatType)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if nil == chatType then
    return
  end
  local check = PaGlobal_ChatOption_All._btnFilter[chatType].check:IsCheck()
  PaGlobal_ChatOption_All._channelFilter[chatType] = check
  TooltipSimple_Hide()
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_ChattingColor(chatType, chatButton)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if nil == chatType or nil == chatButton then
    return
  end
  TooltipSimple_Hide()
  PaGlobalFunc_ChattingColor_All_Open(PaGlobal_ChatOption_All._panelIndex, chatType, chatButton, false)
end
function HandleEventLUp_ChatOption_All_MainSystemFilter()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  local check = PaGlobal_ChatOption_All._ui.chk_systemSelect:IsCheck()
  PaGlobal_ChatOption_All._channelSystemFilter[PaGlobal_ChatOption_All._eChatSystemButtonType.eChatSystem] = check
  for idx = 1, PaGlobal_ChatOption_All._chatOptionData.chatSystemFilterCount - 1 do
    PaGlobal_ChatOption_All._btnSystemFilter[idx].main:SetCheck(check)
    PaGlobal_ChatOption_All._channelSystemFilter[idx] = check
  end
  TooltipSimple_Hide()
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_SystemFilter(systemType)
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if nil == systemType then
    return
  end
  local check = PaGlobal_ChatOption_All._btnSystemFilter[systemType].main:IsCheck()
  PaGlobal_ChatOption_All._channelSystemFilter[systemType] = check
  if true == check and false == PaGlobal_ChatOption_All._ui.chk_systemSelect:IsCheck() then
    PaGlobal_ChatOption_All._ui.chk_systemSelect:SetCheck(true)
    PaGlobal_ChatOption_All._channelSystemFilter[PaGlobal_ChatOption_All._eChatSystemButtonType.eChatSystem] = check
  end
  TooltipSimple_Hide()
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventLUp_ChatOption_All_MainSystemColor()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  TooltipSimple_Hide()
  PaGlobalFunc_ChattingColor_All_Open(PaGlobal_ChatOption_All._panelIndex, CppEnums.ChatType.System, 0, true)
end
function HandleEventLUp_ChatOption_All_ChatTimeOption()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  local isCheck = PaGlobal_ChatOption_All._ui.chk_optionsTime:IsCheck()
  PaGlobal_ChatOption_All_SetIsShowTimeString(PaGlobal_ChatOption_All._panelIndex, isCheck)
end
function HandleEventLUp_ChatOption_All_HeaderOption()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  local isCheck = PaGlobal_ChatOption_All._ui.chk_optionsHeader:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eChatDivision, isCheck, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function HandleEventOn_ChatOption_All_Tooltip(isShow, tipType, idx)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if 11 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_DESC")
    control = PaGlobal_ChatOption_All._ui.chk_systemSelect
  elseif 25 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SCROLLANIMATION_USE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SCROLLANIMATION_USE_DESC")
    control = PaGlobal_ChatOption_All._ui.rdo_scrollAniOn
  elseif 26 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SCROLLANIMATION_NONEUSE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SCROLLANIMATION_NONEUSE_DESC")
    control = PaGlobal_ChatOption_All._ui.rdo_scrollAniOff
  elseif 27 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATBLOCKLIST_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATBLOCKLIST_DESC")
    control = PaGlobal_ChatOption_All._ui.btn_banList
  elseif 28 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_COLORRESET_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_COLORRESET_DESC")
    control = PaGlobal_ChatOption_All._ui.btn_reset_color
  elseif 29 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATOPTION_CHATDIVISION_HEAD")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATHEAD_DESC")
    control = PaGlobal_ChatOption_All._ui.chk_optionsHeader
  elseif 30 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTINGOPTION_CHATTIME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATTIME_DESC")
    control = PaGlobal_ChatOption_All._ui.chk_optionsTime
  elseif 31 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_CHATOPTION_TOOLTIP_SCROLLANIMATION_USE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_EMOTICON_DESC_ON")
    control = PaGlobal_ChatOption_All._ui.rdo_emogisOn
  elseif 32 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "LUA_CHATOPTION_TOOLTIP_SCROLLANIMATION_NONEUSE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_EMOTICON_DESC_OFF")
    control = PaGlobal_ChatOption_All._ui.rdo_emogisOff
  elseif 98 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATCOLORSET_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATCOLORSET_DESC")
    control = PaGlobal_ChatOption_All._ui.rdo_systemColor
  elseif 99 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATCOLORSET_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHATCOLORSET_DESC")
    control = PaGlobal_ChatOption_All._btnFilter[idx].color
  end
  if nil ~= name and nil ~= desc and nil ~= control then
    TooltipSimple_Show(control, name, desc, false)
  end
end
function HandleEventOn_ChatOption_All_ChatFilterTooltip(isShow, tipType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local self = PaGlobal_ChatOption_All
  if self._eChatButtonType.eChatNotice == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_NOTICE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_NOTICE_DESC")
  elseif self._eChatButtonType.eChatWorldWithItem == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_WORLD_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_WORLD_DESC")
  elseif self._eChatButtonType.eChatWorld == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SERVER_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SERVER_DESC")
  elseif self._eChatButtonType.eChatGuild == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_GUILD_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_GUILD_DESC")
  elseif self._eChatButtonType.eChatParty == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_PARTY_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_PARTY_DESC")
  elseif self._eChatButtonType.eChatBattle == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_COMBAT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_COMBAT_DESC")
  elseif self._eChatButtonType.eChatPublic == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_NORMAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_NORMAL_DESC")
  elseif self._eChatButtonType.eChatPrivate == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_WHISPER_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_WHISPER_DESC")
  elseif self._eChatButtonType.eChatRolePlay == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_ROLEPLAY_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_ROLEPLAY_DESC")
  elseif self._eChatButtonType.eChatArsha == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_ARSHA_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_ARSHA_DESC")
  elseif self._eChatButtonType.eChatTeam == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_TEAM_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_TEAM_DESC")
  elseif self._eChatButtonType.eChatAlliance == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTIONTOOLTIP_ALLIANCE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTIONTOOLTIP_ALLIANCE_DESC")
  elseif self._eChatButtonType.eChatChannelChatting == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHANNEL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_CHANNEL_DESC")
  elseif self._eChatButtonType.eChatGuildManager == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_GUILDMANAGER_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_GUILDMANAGER_DESC")
  end
  if nil ~= name and nil ~= desc then
    control = self._btnFilter[tipType].check
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOn_ChatOption_All_SystemFilterTooltip(isShow, tipType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local self = PaGlobal_ChatOption_All
  if self._eChatSystemButtonType.eChatSystemUndefine == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_NORMAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_NORMAL_DESC")
  elseif self._eChatSystemButtonType.eChatSystemPrivateItem == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_PERSONITEM_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_PERSONITEM_DESC")
  elseif self._eChatSystemButtonType.eChatSystemPartyItem == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_PARTYITEM_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_PARTYITEM_DESC")
  elseif self._eChatSystemButtonType.eChatSystemMarket == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_ITEMMARKET_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_ITEMMARKET_DESC")
  elseif self._eChatSystemButtonType.eChatSystemWorker == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_WORKER_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_WORKER_DESC")
  elseif self._eChatSystemButtonType.eChatSystemHarvest == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_HARVEST_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_SYSTEM_HARVEST_DESC")
  elseif self._eChatSystemButtonType.eChatSystemEnchant == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_ENCHANT")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_ENCHANT")
  end
  if nil ~= name and nil ~= desc then
    control = self._btnSystemFilter[tipType].main
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOn_ChatOption_All_TextSizeTooltip(isShow, tipType)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local self = PaGlobal_ChatOption_All
  if 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_VERYSMALL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_VERYSMALL_DESC")
    control = rdo_FontSizeSmall
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_SMALL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_SMALL_DESC")
    control = rdo_FontSizeSmall2
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_NORMAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_NORMAL_DESC")
    control = rdo_FontSizeNormal
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_BIG_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_BIG_DESC")
    control = rdo_FontSizeNormal2
  elseif 5 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_VERYBIG_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATOPTION_TOOLTIP_FONT_VERYBIG_DESC")
    control = rdo_FontSizeBig
  end
  if nil ~= name and nil ~= desc then
    control = self._ui.rdo_textSizes[tipType]
    TooltipSimple_Show(control, name, desc)
  end
end
function FromClient_ChatOption_All_OnScreenResize()
  PaGlobal_ChatOption_All:resize()
end
function FromClient_ChattingOption_All_applyChattingOptionToLua(presetIndex, chatWindowIndex, chatFontSizeType, chatNameType, isCombined, transparency, isUsedSmoothChattingUp)
  PaGlobalFunc_ChatOption_All_Open(chatWindowIndex, chatWindowIndex, isCombined)
  HandleEventLUp_ChatOption_All_HeaderOption()
  FGlobal_Chatting_PanelTransparency(chatWindowIndex, transparency, false)
  TooltipSimple_Hide()
  PaGlobal_ChatOption_All_RegisterUpdate()
  Panel_Window_ChatOption_All:SetShow(false, false)
  Panel_Window_ChatOption_All:SetIgnore(true)
  PaGlobalFunc_ChattingColor_All_Close()
  Chatting_setUsedSmoothChattingUp(isUsedSmoothChattingUp)
  PaGlobalFunc_ChatOption_All_UpdateChattingAnimationControl(isUsedSmoothChattingUp)
  setisChangeFontSize(true)
end
function PaGlobal_ChatOption_All_ConvertFontSizeToChatFontType(chattingFontSize)
  local ChatFontType = CppEnums.ChatFontSizeType.eChatFontSizeType_Normal
  if chattingFontSize == 10 then
    ChatFontType = CppEnums.ChatFontSizeType.eChatFontSizeType_Small
  elseif chattingFontSize == 12 then
    ChatFontType = CppEnums.ChatFontSizeType.eChatFontSizeType_Medium
  elseif chattingFontSize == 14 then
    ChatFontType = CppEnums.ChatFontSizeType.eChatFontSizeType_Normal
  elseif chattingFontSize == 18 then
    ChatFontType = CppEnums.ChatFontSizeType.eChatFontSizeType_Biggish
  elseif chattingFontSize == 20 then
    ChatFontType = CppEnums.ChatFontSizeType.eChatFontSizeType_Big
  end
  return tonumber(ChatFontType)
end
function PaGlobal_ChatOption_All_ConvertChatFontTypeToFontSize(chattingFontType)
  local fontSize = 14
  if chattingFontType == CppEnums.ChatFontSizeType.eChatFontSizeType_Small then
    fontSize = 10
  elseif chattingFontType == CppEnums.ChatFontSizeType.eChatFontSizeType_Medium then
    fontSize = 12
  elseif chattingFontType == CppEnums.ChatFontSizeType.eChatFontSizeType_Normal then
    fontSize = 14
  elseif chattingFontType == CppEnums.ChatFontSizeType.eChatFontSizeType_Biggish then
    fontSize = 18
  elseif chattingFontType == CppEnums.ChatFontSizeType.eChatFontSizeType_Big then
    fontSize = 20
  end
  return fontSize
end
function PaGlobal_ChatOption_All_GetIsShowTimeString(index)
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
function PaGlobal_ChatOption_All_SetIsShowTimeString(panelIndex, isCheck)
  if nil == panelIndex then
    return
  end
  if nil == isCheck then
    return
  end
  local chatPanel = ToClient_getChattingPanel(panelIndex)
  if nil == chatPanel then
    _PA_ASSERT(false, "\236\151\134\235\138\148 \235\178\136\237\152\184\236\157\152 \236\177\132\237\140\133 \237\140\168\235\132\144\236\158\133\235\139\136\235\139\164.(" .. tostring(panelIndex) .. ")")
    return
  end
  if false == chatPanel:isOpen() then
    return
  end
  chatPanel:setIsShowTimeString(isCheck)
  PaGlobal_ChatOption_All_RegisterUpdate()
end
function PaGlobal_ChatOption_All_RegisterUpdate()
  if true == _ContentsGroup_UsePadSnapping then
    return
  end
  FromClient_ChatUpdate(nil, nil, true)
end
function PaGlobalFunc_ChatOption_All_UpdateChattingAnimationControl(isUsedChattingAnimation)
  if true == isUsedChattingAnimation then
    PaGlobal_ChatOption_All._ui.rdo_scrollAniOn:SetCheck(true)
    PaGlobal_ChatOption_All._ui.rdo_scrollAniOff:SetCheck(false)
    HandleEventLUp_ChatOption_All_ChattingAnimation(true)
  else
    PaGlobal_ChatOption_All._ui.rdo_scrollAniOn:SetCheck(false)
    PaGlobal_ChatOption_All._ui.rdo_scrollAniOff:SetCheck(true)
    HandleEventLUp_ChatOption_All_ChattingAnimation(false)
  end
end
function setisChangeFontSize(isSet)
  PaGlobal_ChatOption_All._isChangeFontSize = isSet
end
function isChangeFontSize()
  return PaGlobal_ChatOption_All._isChangeFontSize
end
function PaGlobalFunc_ChatOption_All_SettingColor(index, chatType, panelIndex, isSystem)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  if true == isSystem then
    PaGlobal_ChatOption_All._ui.rdo_systemColor:SetColor(FGlobal_ColorList(index))
  else
    PaGlobal_ChatOption_All._btnFilter[chatType].color:SetColor(FGlobal_ColorList(index))
  end
end
function PaGlobalFunc_ChatOption_All_filterBgShow(isShow, buttonType, isSystem)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  for ii = 0, PaGlobal_ChatOption_All._chatOptionData.chatFilterCount - 1 do
    PaGlobal_ChatOption_All._btnFilter[ii].bg:SetShow(false)
  end
  PaGlobal_ChatOption_All._ui.stc_systemTitleOn:SetShow(false)
  if false == isShow then
    return
  end
  if false == isSystem then
    PaGlobal_ChatOption_All._btnFilter[buttonType].bg:SetShow(true)
  else
    PaGlobal_ChatOption_All._ui.stc_systemTitleOn:SetShow(true)
  end
end
function HandleEventLUp_ChatOption_All_BanListOpen()
  if nil == PaGlobal_ChatOption_All._panelIndex then
    return
  end
  PaGlobal_ChatOption_All:toggleBlockList()
  PaGlobal_ChatOption_All:updateBlockList()
end
function PaGlobal_ChatOption_All_UpdateBlockList(control, key)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  local key32 = Int64toInt32(key)
  local txt_blockName = UI.getChildControl(control, "StaticText_Name")
  local blockName = ToClient_RequestGetBlockName(key32)
  txt_blockName:SetText(blockName)
  txt_blockName:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_SelectBlockName(" .. key32 .. ")")
end
function HandleEventLUp_ChatOption_All_SelectBlockName(index)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == index then
    return
  end
  PaGlobal_ChatOption_All._selectBlockIndex = index
end
function HandleEventLUp_ChatOption_All_DeleteBlockList()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if -1 == PaGlobal_ChatOption_All._selectBlockIndex then
    return
  end
  local deleteName = ToClient_RequestGetBlockName(PaGlobal_ChatOption_All._selectBlockIndex)
  ToClient_RequestDeleteBlockName(deleteName)
  PaGlobal_ChatOption_All._selectBlockIndex = -1
end
function HandleEventLUp_ChatOption_All_DeleteAllBlockList()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  PaGlobal_ChatOption_All._selectBlockIndex = -1
  ToClient_RequestDeleteAllBlockList()
end
function HandleEventLUp_ChatOption_All_CloseBlockList()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  PaGlobal_ChatOption_All._ban_ui.stc_banList:SetShow(false)
end
function FromClient_ChatOption_All_UpdateBlockList()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  PaGlobal_ChatOption_All:updateBlockList()
end
