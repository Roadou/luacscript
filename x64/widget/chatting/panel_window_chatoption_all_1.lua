local UI_CT = CppEnums.ChatType
local UI_color = Defines.Color
local UI_CST = CppEnums.ChatSystemType
function PaGlobal_ChatOption_All:initialize()
  if true == PaGlobal_ChatOption_All._initialize or nil == Panel_Window_ChatOption_All then
    return
  end
  self:mainChatOptionInitialize()
  self:blockListInitialize()
  for ii = 0, self._chatOptionData.makeChatPanelCount - 1 do
    self._chatPanelSet[ii] = false
  end
  for ii = 0, self._chatOptionData.chatFilterCount - 1 do
    self._channelFilter[ii] = false
  end
  for ii = 1, self._chatOptionData.chatSystemFilterCount - 1 do
    self._channelSystemFilter[ii] = false
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ChatOption_All:validate()
  PaGlobal_ChatOption_All:registEventHandler()
  PaGlobal_ChatOption_All:swichPlatform(self._isConsole)
  PaGlobal_ChatOption_All._initialize = true
end
function PaGlobal_ChatOption_All:mainChatOptionInitialize()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Main_Bg")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_mainBg, "Button_Close")
  self._ui.btn_question = UI.getChildControl(self._ui.stc_mainBg, "Button_Question")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Title")
  self._ui.stc_transparentBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Slider")
  self._ui.progress_transparent = UI.getChildControl(self._ui.stc_transparentBg, "Progress2_1")
  self._ui.slider_transparent = UI.getChildControl(self._ui.stc_transparentBg, "Slider_1")
  self._ui.btn_sliderTransparent = UI.getChildControl(self._ui.slider_transparent, "Slider_1_Button")
  self._ui.txt_transparantNum = UI.getChildControl(self._ui.stc_transparentBg, "StaticText_Change_Number")
  self._ui.stc_transparant_alpha0 = UI.getChildControl(self._ui.stc_transparentBg, "StaticText_0")
  self._ui.stc_transparant_alpha100 = UI.getChildControl(self._ui.stc_transparentBg, "StaticText_100")
  self._ui.btn_reset_color = UI.getChildControl(Panel_Window_ChatOption_All, "Button_Reset_Color")
  self._ui.stc_chatViewBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Chat_View_Bg")
  self._ui.btn_selectAll = UI.getChildControl(self._ui.stc_chatViewBg, "Button_Select_All")
  self._ui.btn_deSelectAll = UI.getChildControl(self._ui.stc_chatViewBg, "Button_Deselect_All")
  self._ui.stc_selectTemplate = UI.getChildControl(self._ui.stc_chatViewBg, "Static_Check_0")
  self._ui.stc_selectBgTemplate = UI.getChildControl(self._ui.stc_selectTemplate, "Static_bg")
  self._ui.chk_selectCheckTemplate = UI.getChildControl(self._ui.stc_selectTemplate, "CheckButton_1")
  self._ui.btn_selectColorTemplate = UI.getChildControl(self._ui.stc_selectTemplate, "RadioButton_Color")
  self._ui.stc_systemTitleBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_System_Bg")
  self._ui.stc_systemBtn = UI.getChildControl(self._ui.stc_systemTitleBg, "Static_System_Btn")
  self._ui.stc_systemTitleOn = UI.getChildControl(self._ui.stc_systemBtn, "Static_Bg_Active")
  self._ui.chk_systemSelect = UI.getChildControl(self._ui.stc_systemBtn, "CheckButton_1")
  self._ui.rdo_systemColor = UI.getChildControl(self._ui.stc_systemBtn, "RadioButton_Color")
  self._ui.chk_systemTemplate = UI.getChildControl(self._ui.stc_systemTitleBg, "CheckButton_Options_0")
  self._ui.stc_emogiTitleBg = UI.getChildControl(Panel_Window_ChatOption_All, "StaticText_Emogi_Title")
  self._ui.stc_emogiTitleIcon = UI.getChildControl(Panel_Window_ChatOption_All, "StaticText_6")
  self._ui.rdo_textSizes = {}
  self._ui.stc_textSizeBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_TextSize_Bg")
  for ii = 1, 5 do
    self._ui.rdo_textSizes[ii] = UI.getChildControl(self._ui.stc_textSizeBg, "RadioButton_" .. ii)
    self._ui.rdo_textSizes[ii]:SetEnableArea(0, 0, self._ui.rdo_textSizes[ii]:GetSizeX() + self._ui.rdo_textSizes[ii]:GetTextSizeX() + 3, self._ui.rdo_textSizes[ii]:GetSizeY())
  end
  self._ui.stc_scrollAniBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Scroll_Animation_Bg")
  self._ui.rdo_scrollAniOn = UI.getChildControl(self._ui.stc_scrollAniBg, "RadioButton_1")
  self._ui.rdo_scrollAniOff = UI.getChildControl(self._ui.stc_scrollAniBg, "RadioButton_2")
  self._ui.rdo_scrollAniOn:SetEnableArea(0, 0, self._ui.rdo_scrollAniOn:GetSizeX() + self._ui.rdo_scrollAniOn:GetTextSizeX() + 3, self._ui.rdo_scrollAniOn:GetSizeY())
  self._ui.rdo_scrollAniOff:SetEnableArea(0, 0, self._ui.rdo_scrollAniOff:GetSizeX() + self._ui.rdo_scrollAniOff:GetTextSizeX() + 3, self._ui.rdo_scrollAniOff:GetSizeY())
  self._ui.stc_emogiBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Emogi_Bg")
  self._ui.rdo_emogisOn = UI.getChildControl(self._ui.stc_emogiBg, "RadioButton_1")
  self._ui.rdo_emogisOff = UI.getChildControl(self._ui.stc_emogiBg, "RadioButton_2")
  self._ui.rdo_emogisOn:SetEnableArea(0, 0, self._ui.rdo_emogisOn:GetSizeX() + self._ui.rdo_emogisOn:GetTextSizeX() + 3, self._ui.rdo_emogisOn:GetSizeY())
  self._ui.rdo_emogisOff:SetEnableArea(0, 0, self._ui.rdo_emogisOff:GetSizeX() + self._ui.rdo_emogisOff:GetTextSizeX() + 3, self._ui.rdo_emogisOff:GetSizeY())
  self._ui.stc_optionBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Option_Bg")
  self._ui.chk_optionsHeader = UI.getChildControl(self._ui.stc_optionBg, "CheckButton_1")
  self._ui.chk_optionsTime = UI.getChildControl(self._ui.stc_optionBg, "CheckButton_2")
  self._ui.chk_optionsHeader:SetEnableArea(0, 0, self._ui.chk_optionsHeader:GetSizeX() + self._ui.chk_optionsHeader:GetTextSizeX() + 3, self._ui.chk_optionsHeader:GetSizeY())
  self._ui.chk_optionsTime:SetEnableArea(0, 0, self._ui.chk_optionsTime:GetSizeX() + self._ui.chk_optionsTime:GetTextSizeX() + 3, self._ui.chk_optionsTime:GetSizeY())
  self._ui.stc_banBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Ban_Bg")
  self._ui.btn_banList = UI.getChildControl(self._ui.stc_banBg, "Button_Ban")
  self._ui.stc_arabBg = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Arab_Bg")
  self._ui.rdo_arabOn = UI.getChildControl(self._ui.stc_arabBg, "RadioButton_1")
  self._ui.rdo_arabOff = UI.getChildControl(self._ui.stc_arabBg, "RadioButton_2")
  self._ui.stc_arabBg:SetShow(false)
  self._ui.btn_groupChat = UI.getChildControl(Panel_Window_ChatOption_All, "Button_GroupChat")
  self._ui.btn_confirm = UI.getChildControl(Panel_Window_ChatOption_All, "Button_Confirm")
  self._ui.btn_cancle = UI.getChildControl(Panel_Window_ChatOption_All, "Button_Cancel")
end
function PaGlobal_ChatOption_All:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_ChatOption_All:prepareOpen(penelIdex, drawPanelIndex, isCombinedMainPanel)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == penelIdex or nil == drawPanelIndex or nil == isCombinedMainPanel then
    return
  end
  if ToClient_isPlayerControlable() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDuringSequence"))
    return
  end
  self._panelIndex = penelIdex
  self._drawPanelIndex = drawPanelIndex
  self._isCombinedMainPanel = isCombinedMainPanel
  self._ui.txt_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHATTING_OPTION_TITLE", "panel_Index", self._panelIndex + 1))
  PaGlobal_ChatOption_All:open()
  PaGlobal_ChatOption_All:update()
  PaGlobal_ChatOption_All:resize()
  self._isPrevValueSaving = true
end
function PaGlobal_ChatOption_All:dataclear()
  self._panelIndex = nil
  self._drawPanelIndex = nil
  self._isCombinedMainPanel = false
  self._isPrevValueSaving = false
  self._prevTransparency = -1
  self._prevIsCheckDivision = true
  self._prevIsCheckChatTime = {}
  self._preChattingAnimation = true
  self._preEmoticonAutoPlay = true
  self._prevFontSizeType = CppEnums.ChatFontSizeType.eChatFontSizeType_Normal
  self._preUseHarfBuzz = false
  self._selectBlockIndex = -1
end
function PaGlobal_ChatOption_All:open()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  Panel_Window_ChatOption_All:SetShow(true)
end
function PaGlobal_ChatOption_All:prepareClose()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  local chatCount = ToClient_getChattingPanelCount()
  for panelIdex = 0, chatCount - 1 do
    local chatPanel = ToClient_getChattingPanel(panelIdex)
    chatPanel:setChatFontSizeType(self._prevFontSizeType)
    if true == chatPanel:isOpen() then
      PaGlobal_ChatOption_All_SetIsShowTimeString(panelIdex, self._prevIsCheckChatTime[panelIdex])
    end
  end
  setisChangeFontSize(true)
  ToClient_setUseHarfBuzz(self._preUseHarfBuzz)
  FGlobal_ChattingcheckArabicType(self._preUseHarfBuzz)
  HandleEventLUp_ChatOption_All_ChattingAnimation(self._preChattingAnimation)
  if self._panelIndex ~= nil then
    FGlobal_Chatting_PanelTransparency(self._panelIndex, self._prevTransparency, true)
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  if true == chatPanel:isCombinedToMainPanel() then
    for idx = 0, chatCount - 1 do
      local chatPanel = ToClient_getChattingPanel(idx)
      if true == chatPanel:isCombinedToMainPanel() then
        FGlobal_Chatting_PanelTransparency(idx, self._prevTransparency, true)
      end
    end
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eChatDivision, self._prevIsCheckDivision, CppEnums.VariableStorageType.eVariableStorageType_User)
  PaGlobal_ChatOption_All_RegisterUpdate()
  PaGlobalFunc_ChattingColor_All_Close()
  HandleEventLUp_ChatOption_All_CloseBlockList()
  self:dataclear()
  PaGlobal_ChatOption_All:close()
end
function PaGlobal_ChatOption_All:close()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  Panel_Window_ChatOption_All:SetShow(false)
end
function PaGlobal_ChatOption_All:update()
  self:initPanelOption()
  self:setTransparency()
  self:setFontSize()
  self:setChattingAni()
  self:setEmogiPlay()
  self:setEtcOption()
  self:setHarfBuzzOption()
end
function PaGlobal_ChatOption_All:initPanelOption()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == self._panelIndex then
    return
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  if nil == chatPanel then
    _PA_ASSERT(false, "chatPanel \236\160\149\235\179\180\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164.")
    return
  end
  self._isUseEmoticonAutoPlay = chatPanel:getUseEmoticonAutoPlay()
  local index = 0
  if not self._chatPanelSet[self._panelIndex] then
    local optionCount = 0
    local idx = 0
    self:initChatFilter(chatPanel)
    self:initSystemFilter(chatPanel)
    self._chatPanelSet[self._panelIndex] = true
  end
  self:updatefilterColor(chatPanel)
  self:updateChatFilter(chatPanel)
end
function PaGlobal_ChatOption_All:initChatFilter(chatPanel)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == chatPanel then
    return
  end
  if nil == self._panelIndex then
    return
  end
  local index = 0
  local nextPosX = self._ui.stc_selectTemplate:GetPosX()
  local nextPosY = self._ui.stc_selectTemplate:GetPosY()
  self._ui.stc_selectTemplate:SetShow(false)
  local chatType
  for idx = 0, self._chatOptionData.chatFilterCount - 1 do
    if nil == self._btnFilter[idx] then
      local tempBtn = {}
      tempBtn.main = UI.cloneControl(self._ui.stc_selectTemplate, self._ui.stc_chatViewBg, "Stataic_ChatCheck_" .. idx)
      tempBtn.bg = UI.getChildControl(tempBtn.main, "Static_bg")
      tempBtn.check = UI.getChildControl(tempBtn.main, "CheckButton_1")
      tempBtn.color = UI.getChildControl(tempBtn.main, "RadioButton_Color")
      tempBtn.main:SetPosX(nextPosX)
      tempBtn.main:SetPosY(nextPosY)
      tempBtn.main:SetShow(true)
      self._btnFilter[idx] = tempBtn
    end
    if self._eChatButtonType.eChatNotice == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_NOTICE"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Notice))
      self._btnFilter[idx].color:SetShow(false)
    elseif self._eChatButtonType.eChatWorldWithItem == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_WORLD"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.WorldWithItem))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.WorldWithItem .. "," .. idx .. ")")
    elseif self._eChatButtonType.eChatWorld == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_SERVERGROUP"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.World))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.World .. "," .. idx .. ")")
    elseif self._eChatButtonType.eChatGuild == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_GUILD"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Guild))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Guild .. "," .. idx .. ")")
    elseif self._eChatButtonType.eChatParty == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_PARTY"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Party))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Party .. "," .. idx .. ")")
    elseif self._eChatButtonType.eChatBattle == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_BATTLE"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Battle))
      self._btnFilter[idx].color:SetShow(false)
    elseif self._eChatButtonType.eChatPublic == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_GENERAL"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Public))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Public .. "," .. idx .. ")")
    elseif self._eChatButtonType.eChatRolePlay == idx then
      self._btnFilter[idx].check:SetText("RolePlay")
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.RolePlay))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.RolePlay .. "," .. idx .. ")")
      self._btnFilter[idx].main:SetShow(self._isRoleplayTypeOpen)
    elseif self._eChatButtonType.eChatPrivate == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_WHISPER"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Private))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Private .. "," .. idx .. ")")
    elseif self._eChatButtonType.eChatArsha == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_ARSHA"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Arsha))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Arsha .. "," .. idx .. ")")
      self._btnFilter[idx].main:SetShow(self._isArshaOpen)
    elseif self._eChatButtonType.eChatTeam == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHATTING_OPTION_FILTER_TEAM"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Team))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Team .. "," .. idx .. ")")
      self._btnFilter[idx].main:SetShow(self._isArshaOpen or self._isLocalWarOpen or self._isSavageDefenceOpen)
    elseif self._eChatButtonType.eChatAlliance == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDALLIANCE_TITLE"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Alliance))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Alliance .. "," .. idx .. ")")
      self._btnFilter[idx].main:SetShow(self._isGuildAlianceOpen)
    elseif self._eChatButtonType.eChatChannelChatting == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_CHANNEL"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.Channel))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.Channel .. "," .. idx .. ")")
      self._btnFilter[idx].main:SetShow(self._isChannelChatOpen)
    elseif self._eChatButtonType.eChatGuildManager == idx then
      self._btnFilter[idx].check:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_GUILDMANAGER"))
      self._btnFilter[idx].check:SetCheck(chatPanel:isShowChatType(UI_CT.GuildManager))
      self._btnFilter[idx].color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColor(" .. UI_CT.GuildManager .. "," .. idx .. ")")
    end
    self._btnFilter[idx].check:SetEnableArea(0, 0, self._btnFilter[idx].check:GetSizeX() + self._btnFilter[idx].check:GetTextSizeX() + 3, self._btnFilter[idx].check:GetSizeY())
    self._btnFilter[idx].check:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChatFilter(" .. idx .. ")")
    self._btnFilter[idx].check:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_ChatFilterTooltip(true, " .. idx .. ")")
    self._btnFilter[idx].check:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_ChatFilterTooltip(false)")
    self._btnFilter[idx].color:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 99, " .. idx .. ")")
    self._btnFilter[idx].color:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
    if true == self._btnFilter[idx].main:GetShow() then
      nextPosY = nextPosY + self._ui.stc_selectTemplate:GetSizeY()
    end
    if self._ui.stc_chatViewBg:GetSizeY() < nextPosY + self._ui.btn_selectAll:GetSizeY() then
      nextPosX = nextPosX + self._ui.stc_selectTemplate:GetSizeX()
      nextPosY = self._ui.stc_selectTemplate:GetPosY()
    end
  end
end
function PaGlobal_ChatOption_All:initSystemFilter(chatPanel)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == chatPanel then
    return
  end
  if nil == self._panelIndex then
    return
  end
  self._ui.chk_systemSelect:SetText(PAGetString(Defines.StringSheet_GAME, "CHATTING_TAB_SYSTEM"))
  self._ui.chk_systemSelect:SetCheck(chatPanel:isShowChatType(UI_CT.System))
  self._ui.chk_systemSelect:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_MainSystemFilter()")
  self._ui.chk_systemSelect:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 11)")
  self._ui.chk_systemSelect:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.rdo_systemColor:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_MainSystemColor()")
  self._ui.rdo_systemColor:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 98)")
  self._ui.rdo_systemColor:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.chk_systemSelect:SetEnableArea(0, 0, self._ui.chk_systemSelect:GetSizeX() + self._ui.chk_systemSelect:GetTextSizeX() + 3, self._ui.chk_systemSelect:GetSizeY())
  local chatColorIndex = chatPanel:getChatSystemColorIndex(UI_CT.System)
  if -1 == chatColorIndex then
    self._ui.rdo_systemColor:SetColor(UI_color.C_FFC4BEBE)
  else
    self._ui.rdo_systemColor:SetColor(FGlobal_ColorList(chatColorIndex))
  end
  local index = 0
  local nextPosX = self._ui.chk_systemTemplate:GetPosX()
  local nextPosY = self._ui.chk_systemTemplate:GetPosY()
  self._ui.chk_systemTemplate:SetShow(false)
  for idx = 1, self._chatOptionData.chatSystemFilterCount - 1 do
    if nil == self._btnSystemFilter[idx] then
      local tempBtn = {}
      tempBtn.main = UI.cloneControl(self._ui.chk_systemTemplate, self._ui.stc_systemTitleBg, "Stataic_SystemCheck_" .. idx)
      tempBtn.main:SetPosX(nextPosX)
      tempBtn.main:SetPosY(nextPosY)
      tempBtn.main:SetShow(true)
      self._btnSystemFilter[idx] = tempBtn
    end
    if self._eChatSystemButtonType.eChatSystemUndefine == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TAB_SYSTEM_UNDEFINE"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.Undefine))
    elseif self._eChatSystemButtonType.eChatSystemPrivateItem == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TAB_SYSTEM_PRIVATEITEM"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.PrivateItem))
    elseif self._eChatSystemButtonType.eChatSystemPartyItem == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TAB_SYSTEM_PARTYITEM"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.PartyItem))
    elseif self._eChatSystemButtonType.eChatSystemMarket == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TAB_SYSTEM_MARKET"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.Market))
      self._btnSystemFilter[idx].main:SetShow(true == self._isItemMarketKor2Open)
    elseif self._eChatSystemButtonType.eChatSystemWorker == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TAB_SYSTEM_WORKER"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.Worker))
    elseif self._eChatSystemButtonType.eChatSystemHarvest == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHATTING_TAB_SYSTEM_HARVEST"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.Harvest))
    elseif self._eChatSystemButtonType.eChatSystemEnchant == idx then
      self._btnSystemFilter[idx].main:SetText(PAGetString(Defines.StringSheet_GAME, "DIALOG_BUTTON_QUEST_ENCHANT"))
      self._btnSystemFilter[idx].main:SetCheck(chatPanel:isShowChatSystemType(UI_CST.Enchant))
    end
    self._btnSystemFilter[idx].main:SetEnableArea(0, 0, self._btnSystemFilter[idx].main:GetSizeX() + self._btnSystemFilter[idx].main:GetTextSizeX() + 3, self._btnSystemFilter[idx].main:GetSizeY())
    self._btnSystemFilter[idx].main:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_SystemFilter(" .. idx .. ")")
    self._btnSystemFilter[idx].main:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_SystemFilterTooltip(true, " .. idx .. ")")
    self._btnSystemFilter[idx].main:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_SystemFilterTooltip(false)")
    if true == self._btnSystemFilter[idx].main:GetShow() then
      nextPosY = nextPosY + self._ui.chk_systemTemplate:GetSizeY() + 20
    end
    if self._ui.stc_systemTitleBg:GetSizeY() < nextPosY + self._ui.stc_systemBtn:GetSizeY() then
      nextPosX = nextPosX + math.abs(self._ui.stc_systemTitleBg:GetSizeX() / 3)
      nextPosY = self._ui.chk_systemTemplate:GetPosY()
    end
  end
end
function PaGlobal_ChatOption_All:updatefilterColor(chatPanel)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == chatPanel then
    return
  end
  if nil == self._panelIndex then
    return
  end
  for idx = 0, self._chatOptionData.chatFilterCount - 1 do
    if self._eChatButtonType.eChatNotice == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Notice)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFFFEF82)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatWorldWithItem == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.WorldWithItem)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF00F3A0)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatWorld == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.World)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFFF973A)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatGuild == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Guild)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF84FFF5)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatParty == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Party)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF8EBD00)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatPublic == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Public)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFE7E7E7)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatPrivate == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Private)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFF601FF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatRolePlay == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.RolePlay)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF00B4FF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatArsha == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Arsha)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFFFD237)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatTeam == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Team)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFB97FEF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatAlliance == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Alliance)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF74C5FE)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatChannelChatting == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Channel)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF55a1dd)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatGuildManager == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.GuildManager)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFC694FF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    end
  end
  local chatColorIndex = chatPanel:getChatSystemColorIndex(UI_CT.System)
  if -1 == chatColorIndex then
    self._ui.rdo_systemColor:SetColor(UI_color.C_FFC4BEBE)
  else
    self._ui.rdo_systemColor:SetColor(FGlobal_ColorList(chatColorIndex))
  end
end
function PaGlobal_ChatOption_All:updateChatFilter(chatPanel)
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == chatPanel then
    return
  end
  if nil == self._panelIndex then
    return
  end
  local isShowChatTypeList = {}
  isShowChatTypeList[self._eChatButtonType.eChatNotice] = chatPanel:isShowChatType(UI_CT.Notice)
  isShowChatTypeList[self._eChatButtonType.eChatWorldWithItem] = chatPanel:isShowChatType(UI_CT.WorldWithItem)
  isShowChatTypeList[self._eChatButtonType.eChatWorld] = chatPanel:isShowChatType(UI_CT.World)
  isShowChatTypeList[self._eChatButtonType.eChatParty] = chatPanel:isShowChatType(UI_CT.Party)
  isShowChatTypeList[self._eChatButtonType.eChatPublic] = chatPanel:isShowChatType(UI_CT.Public)
  isShowChatTypeList[self._eChatButtonType.eChatGuild] = chatPanel:isShowChatType(UI_CT.Guild)
  isShowChatTypeList[self._eChatButtonType.eChatPrivate] = chatPanel:isShowChatType(UI_CT.Private)
  isShowChatTypeList[self._eChatButtonType.eChatBattle] = chatPanel:isShowChatType(UI_CT.Battle)
  isShowChatTypeList[self._eChatButtonType.eChatArsha] = chatPanel:isShowChatType(UI_CT.Arsha)
  isShowChatTypeList[self._eChatButtonType.eChatTeam] = chatPanel:isShowChatType(UI_CT.Team)
  isShowChatTypeList[self._eChatButtonType.eChatRolePlay] = chatPanel:isShowChatType(UI_CT.RolePlay)
  isShowChatTypeList[self._eChatButtonType.eChatAlliance] = chatPanel:isShowChatType(UI_CT.Alliance)
  isShowChatTypeList[self._eChatButtonType.eChatChannelChatting] = chatPanel:isShowChatType(UI_CT.Channel)
  isShowChatTypeList[self._eChatButtonType.eChatGuildManager] = chatPanel:isShowChatType(UI_CT.GuildManager)
  for ii = 0, self._chatOptionData.chatFilterCount - 1 do
    self._btnFilter[ii].check:SetCheck(isShowChatTypeList[ii])
    self._channelFilter[ii] = isShowChatTypeList[ii]
  end
  local isShowChatSystemTypeList = {}
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemUndefine] = chatPanel:isShowChatSystemType(UI_CST.Undefine)
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemPrivateItem] = chatPanel:isShowChatSystemType(UI_CST.PrivateItem)
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemPartyItem] = chatPanel:isShowChatSystemType(UI_CST.PartyItem)
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemMarket] = chatPanel:isShowChatSystemType(UI_CST.Market)
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemWorker] = chatPanel:isShowChatSystemType(UI_CST.Worker)
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemHarvest] = chatPanel:isShowChatSystemType(UI_CST.Harvest)
  isShowChatSystemTypeList[self._eChatSystemButtonType.eChatSystemEnchant] = chatPanel:isShowChatSystemType(UI_CST.Enchant)
  self._ui.chk_systemSelect:SetCheck(chatPanel:isShowChatType(UI_CT.System))
  for ii = 1, self._chatOptionData.chatSystemFilterCount - 1 do
    self._btnSystemFilter[ii].main:SetCheck(isShowChatSystemTypeList[ii])
    self._channelSystemFilter[ii] = isShowChatSystemTypeList[ii]
  end
end
function PaGlobal_ChatOption_All:setTransparency()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == self._panelIndex then
    return
  end
  local transparency = FGlobal_Chatting_PanelTransparency_Chk(self._panelIndex)
  self._ui.stc_transparant_alpha0:SetShow(true)
  self._ui.stc_transparant_alpha100:SetShow(true)
  self._ui.btn_sliderTransparent:SetEnable(true)
  self._ui.btn_sliderTransparent:SetShow(true)
  self._ui.slider_transparent:SetEnable(true)
  local percent = math.abs(transparency * 100)
  self._ui.progress_transparent:SetProgressRate(percent)
  self._ui.txt_transparantNum:SetText(string.format("%.0f", percent))
  self._ui.btn_sliderTransparent:SetPosX((self._ui.slider_transparent:GetSizeX() - self._ui.btn_sliderTransparent:GetSizeX()) / 100 * transparency * 100)
  if false == self._isPrevValueSaving then
    self._prevTransparency = transparency
  end
end
function PaGlobal_ChatOption_All:setFontSize()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  local thisFontSize = ToClient_getFontWrapper("BaseFont_10_Chat"):getFontSize()
  local fontSizeValue = PaGlobal_ChatOption_All_ConvertFontSizeToChatFontType(thisFontSize)
  for ii = 1, 5 do
    if ii == fontSizeValue + 1 then
      self._ui.rdo_textSizes[ii]:SetCheck(true)
    else
      self._ui.rdo_textSizes[ii]:SetCheck(false)
    end
  end
  if false == self._isPrevValueSaving then
    self._prevFontSizeType = fontSizeValue
  end
end
function PaGlobal_ChatOption_All:setChattingAni()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == self._panelIndex then
    return
  end
  local ChattingAnimationflag = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eChattingAnimation)
  if true == ChattingAnimationflag then
    self._ui.rdo_scrollAniOn:SetCheck(true)
    self._ui.rdo_scrollAniOff:SetCheck(false)
    HandleEventLUp_ChatOption_All_ChattingAnimation(true)
  else
    self._ui.rdo_scrollAniOn:SetCheck(false)
    self._ui.rdo_scrollAniOff:SetCheck(true)
    HandleEventLUp_ChatOption_All_ChattingAnimation(false)
  end
  if false == self._isPrevValueSaving then
    self._preChattingAnimation = ChattingAnimationflag
  end
end
function PaGlobal_ChatOption_All:setEmogiPlay()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == self._panelIndex then
    return
  end
  if false == self._isEmotionAutoPlayOpen then
    self._ui.stc_emogiTitleBg:SetShow(false)
    self._ui.stc_emogiTitleIcon:SetShow(false)
    self._ui.stc_emogiBg:SetShow(false)
    return
  end
  self._ui.stc_emogiTitleBg:SetShow(true)
  self._ui.stc_emogiTitleIcon:SetShow(true)
  self._ui.stc_emogiBg:SetShow(true)
  self._ui.rdo_emogisOn:SetCheck(self._isUseEmoticonAutoPlay)
  self._ui.rdo_emogisOff:SetCheck(not self._isUseEmoticonAutoPlay)
  if false == self._isPrevValueSaving then
    self._preEmoticonAutoPlay = self._isUseEmoticonAutoPlay
  end
end
function PaGlobal_ChatOption_All:setEtcOption()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == self._panelIndex then
    return
  end
  if not ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eChatDivision) then
    self._ui.chk_optionsHeader:SetCheck(true)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eChatDivision, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  else
    self._ui.chk_optionsHeader:SetCheck(ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eChatDivision))
  end
  local currentIsCheckChatTime = PaGlobal_ChatOption_All_GetIsShowTimeString(self._panelIndex)
  self._ui.chk_optionsTime:SetCheck(currentIsCheckChatTime)
  if false == self._isPrevValueSaving then
    self._prevIsCheckDivision = self._ui.chk_optionsHeader:IsCheck()
    local chatCount = ToClient_getChattingPanelCount()
    for ii = 0, chatCount - 1 do
      self._prevIsCheckChatTime[ii] = PaGlobal_ChatOption_All_GetIsShowTimeString(ii)
    end
  end
end
function PaGlobal_ChatOption_All:setHarfBuzzOption()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if nil == self._panelIndex then
    return
  end
  local isShow = false
  if true == ToClient_IsDevelopment() then
    isShow = true
  end
  if false == self._isPrevValueSaving then
    local currentUseHarfBuzz = ToClient_getUseHarfBuzz()
    self._preUseHarfBuzz = currentUseHarfBuzz
  end
end
function PaGlobal_ChatOption_All:resetAllChattingColor()
  if nil == self._panelIndex then
    return
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  chatPanel:setChatColor(UI_CT.Notice, -1)
  chatPanel:setChatColor(UI_CT.World, -1)
  chatPanel:setChatColor(UI_CT.Public, -1)
  chatPanel:setChatColor(UI_CT.Private, -1)
  chatPanel:setChatColor(UI_CT.Party, -1)
  chatPanel:setChatColor(UI_CT.Guild, -1)
  chatPanel:setChatColor(UI_CT.WorldWithItem, -1)
  chatPanel:setChatColor(UI_CT.RolePlay, -1)
  chatPanel:setChatColor(UI_CT.Arsha, -1)
  chatPanel:setChatColor(UI_CT.Team, -1)
  chatPanel:setChatColor(UI_CT.Alliance, -1)
  chatPanel:setChatColor(UI_CT.Channel, -1)
  chatPanel:setChatColor(UI_CT.GuildManager, -1)
  chatPanel:setChatSystemColorIndex(UI_CT.System, -1)
  if self._eChatSystemButtonType.eChatSystem == 0 then
    local chatColorIndex = chatPanel:getChatSystemColorIndex(UI_CT.System)
    if -1 == chatColorIndex then
      self._ui.rdo_systemColor:SetColor(UI_color.C_FFC4BEBE)
    else
      self._ui.rdo_systemColor:SetColor(FGlobal_ColorList(chatColorIndex))
    end
  end
  for idx = 0, self._chatOptionData.chatFilterCount - 1 do
    if self._eChatButtonType.eChatNotice == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Notice)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFFFEF82)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatWorldWithItem == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.WorldWithItem)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF00F3A0)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatWorld == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.World)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFFF973A)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatGuild == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Guild)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF84FFF5)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatParty == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Party)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF8EBD00)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatPublic == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Public)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFE7E7E7)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatRolePlay == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.RolePlay)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF00B4FF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatPrivate == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Private)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFF601FF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatArsha == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Arsha)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFFFD237)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatTeam == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Team)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFB97FEF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatAlliance == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Alliance)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF74C5FE)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatChannelChatting == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.Channel)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FF55a1dd)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    elseif self._eChatButtonType.eChatGuildManager == idx then
      local chatColorIndex = chatPanel:getChatColorIndex(UI_CT.GuildManager)
      if -1 == chatColorIndex then
        self._btnFilter[idx].color:SetColor(UI_color.C_FFC694FF)
      else
        self._btnFilter[idx].color:SetColor(FGlobal_ColorList(chatColorIndex))
      end
    end
  end
end
function PaGlobal_ChatOption_All:confirmFilter()
  if nil == self._panelIndex then
    return
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  chatPanel:setShowChatType(UI_CT.Notice, self._channelFilter[self._eChatButtonType.eChatNotice])
  chatPanel:setShowChatType(UI_CT.System, self._ui.chk_systemSelect:IsCheck())
  chatPanel:setShowChatType(UI_CT.World, self._channelFilter[self._eChatButtonType.eChatWorld])
  chatPanel:setShowChatType(UI_CT.Public, self._channelFilter[self._eChatButtonType.eChatPublic])
  chatPanel:setShowChatType(UI_CT.Private, self._channelFilter[self._eChatButtonType.eChatPrivate])
  chatPanel:setShowChatType(UI_CT.Party, self._channelFilter[self._eChatButtonType.eChatParty])
  chatPanel:setShowChatType(UI_CT.Guild, self._channelFilter[self._eChatButtonType.eChatGuild])
  chatPanel:setShowChatType(UI_CT.WorldWithItem, self._channelFilter[self._eChatButtonType.eChatWorldWithItem])
  chatPanel:setShowChatType(UI_CT.Battle, self._channelFilter[self._eChatButtonType.eChatBattle])
  chatPanel:setShowChatType(UI_CT.RolePlay, self._channelFilter[self._eChatButtonType.eChatRolePlay])
  chatPanel:setShowChatType(UI_CT.Arsha, self._channelFilter[self._eChatButtonType.eChatArsha])
  chatPanel:setShowChatType(UI_CT.Team, self._channelFilter[self._eChatButtonType.eChatTeam])
  chatPanel:setShowChatType(UI_CT.Alliance, self._channelFilter[self._eChatButtonType.eChatAlliance])
  chatPanel:setShowChatType(UI_CT.Channel, self._channelFilter[self._eChatButtonType.eChatChannelChatting])
  chatPanel:setShowChatType(UI_CT.GuildManager, self._channelFilter[self._eChatButtonType.eChatGuildManager])
  chatPanel:setShowChatSystemType(UI_CST.Undefine, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemUndefine])
  chatPanel:setShowChatSystemType(UI_CST.PrivateItem, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemPrivateItem])
  chatPanel:setShowChatSystemType(UI_CST.PartyItem, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemPartyItem])
  chatPanel:setShowChatSystemType(UI_CST.Market, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemMarket])
  chatPanel:setShowChatSystemType(UI_CST.Worker, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemWorker])
  chatPanel:setShowChatSystemType(UI_CST.Harvest, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemHarvest])
  chatPanel:setShowChatSystemType(UI_CST.Enchant, self._channelSystemFilter[self._eChatSystemButtonType.eChatSystemEnchant])
end
function PaGlobal_ChatOption_All:saveOptions()
  if nil == self._panelIndex then
    return
  end
  local chatPanel = ToClient_getChattingPanel(self._panelIndex)
  local count = ToClient_getChattingPanelCount()
  local currentFontSize = ToClient_getFontWrapper("BaseFont_10_Chat"):getFontSize()
  for panelIdx = 0, count - 1 do
    local chatPanel = ToClient_getChattingPanel(panelIdx)
    chatPanel:setChatFontSizeType(PaGlobal_ChatOption_All_ConvertFontSizeToChatFontType(currentFontSize))
  end
  local transparency = self._ui.btn_sliderTransparent:GetPosX() / (self._ui.slider_transparent:GetSizeX() - self._ui.btn_sliderTransparent:GetSizeX())
  chatPanel:setTransparency(transparency)
  if true == chatPanel:isCombinedToMainPanel() then
    for idx = 1, count - 1 do
      local chatPanel = ToClient_getChattingPanel(idx)
      if chatPanel:isCombinedToMainPanel() == true then
        FGlobal_Chatting_PanelTransparency(idx, transparency, false)
      end
    end
  end
  local isTimeShow = self._ui.chk_optionsTime:IsCheck()
  PaGlobal_ChatOption_All_SetIsShowTimeString(self._panelIndex, isTimeShow)
  self._prevIsCheckChatTime[self._panelIndex] = isTimeShow
  chatPanel:setUseEmoticonAutoPlay(self._isUseEmoticonAutoPlay)
end
function PaGlobal_ChatOption_All:registEventHandler()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ChatOption_All_OnScreenResize")
  registerEvent("FromClient_UpdateBlockList", "FromClient_ChatOption_All_UpdateBlockList")
  registerEvent("FromClient_applyChattingOptionToLua", "FromClient_ChattingOption_All_applyChattingOptionToLua")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_Close()")
  self._ui.btn_cancle:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_Close()")
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Chatting\" )")
  self._ui.btn_groupChat:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChannelChat_Open()")
  self._ui.btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ConfirmSetting()")
  self._ui.btn_selectAll:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_SelectAllChatFilter(true)")
  self._ui.btn_deSelectAll:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_SelectAllChatFilter(false)")
  self._ui.slider_transparent:addInputEvent("Mouse_LPress", "HandleEventLPress_ChatOption_All_SetTransparency()")
  self._ui.btn_sliderTransparent:addInputEvent("Mouse_LPress", "HandleEventLPress_ChatOption_All_SetTransparency()")
  self._ui.rdo_scrollAniOn:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingAnimation(true)")
  self._ui.rdo_scrollAniOn:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 25)")
  self._ui.rdo_scrollAniOn:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.rdo_scrollAniOff:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingAnimation(false)")
  self._ui.rdo_scrollAniOff:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 26)")
  self._ui.rdo_scrollAniOff:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.rdo_emogisOn:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_EmoticonAutoPlay(true)")
  self._ui.rdo_emogisOn:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 31)")
  self._ui.rdo_emogisOn:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.rdo_emogisOff:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_EmoticonAutoPlay(false)")
  self._ui.rdo_emogisOff:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 32)")
  self._ui.rdo_emogisOff:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.chk_optionsHeader:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_HeaderOption()")
  self._ui.chk_optionsHeader:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 29)")
  self._ui.chk_optionsHeader:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.chk_optionsTime:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChatTimeOption()")
  self._ui.chk_optionsTime:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 30)")
  self._ui.chk_optionsTime:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  self._ui.btn_reset_color:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_ChattingColorReset()")
  self._ui.btn_reset_color:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 28)")
  self._ui.btn_reset_color:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  for ii = 1, 5 do
    self._ui.rdo_textSizes[ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_TextSize(" .. ii .. ")")
    self._ui.rdo_textSizes[ii]:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_TextSizeTooltip(true, " .. ii .. ")")
    self._ui.rdo_textSizes[ii]:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_TextSizeTooltip(false)")
  end
  self._ui.btn_banList:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_BanListOpen()")
  self._ui.btn_banList:addInputEvent("Mouse_On", "HandleEventOn_ChatOption_All_Tooltip(true, 27)")
  self._ui.btn_banList:addInputEvent("Mouse_Out", "HandleEventOn_ChatOption_All_Tooltip(false)")
  Panel_Window_ChatOption_All:SetShow(false)
  Panel_Window_ChatOption_All:ActiveMouseEventEffect(true)
  Panel_Window_ChatOption_All:setGlassBackground(true)
end
function PaGlobal_ChatOption_All:validate()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  self._ui.stc_mainBg:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_transparentBg:isValidate()
  self._ui.progress_transparent:isValidate()
  self._ui.slider_transparent:isValidate()
  self._ui.btn_sliderTransparent:isValidate()
  self._ui.txt_transparantNum:isValidate()
  self._ui.stc_transparant_alpha0:isValidate()
  self._ui.stc_transparant_alpha100:isValidate()
  self._ui.btn_reset_color:isValidate()
  self._ui.stc_chatViewBg:isValidate()
  self._ui.btn_selectAll:isValidate()
  self._ui.btn_deSelectAll:isValidate()
  self._ui.stc_selectTemplate:isValidate()
  self._ui.stc_selectBgTemplate:isValidate()
  self._ui.chk_selectCheckTemplate:isValidate()
  self._ui.btn_selectColorTemplate:isValidate()
  self._ui.stc_systemTitleBg:isValidate()
  self._ui.stc_systemBtn:isValidate()
  self._ui.stc_systemTitleOn:isValidate()
  self._ui.chk_systemSelect:isValidate()
  self._ui.rdo_systemColor:isValidate()
  self._ui.chk_systemTemplate:isValidate()
  self._ui.stc_emogiTitleBg:isValidate()
  self._ui.stc_emogiTitleIcon:isValidate()
  self._ui.stc_textSizeBg:isValidate()
  for ii = 1, 5 do
    self._ui.rdo_textSizes[ii]:isValidate()
  end
  self._ui.stc_scrollAniBg:isValidate()
  self._ui.rdo_scrollAniOn:isValidate()
  self._ui.rdo_scrollAniOff:isValidate()
  self._ui.stc_emogiBg:isValidate()
  self._ui.rdo_emogisOn:isValidate()
  self._ui.rdo_emogisOff:isValidate()
  self._ui.stc_optionBg:isValidate()
  self._ui.chk_optionsHeader:isValidate()
  self._ui.chk_optionsTime:isValidate()
  self._ui.stc_banBg:isValidate()
  self._ui.btn_banList:isValidate()
  self._ui.stc_arabBg:isValidate()
  self._ui.rdo_arabOn:isValidate()
  self._ui.rdo_arabOff:isValidate()
  self._ui.btn_confirm:isValidate()
  self._ui.btn_cancle:isValidate()
  self._ban_ui.stc_banList:isValidate()
  self._ban_ui.stc_banTitle:isValidate()
  self._ban_ui.btn_banClose:isValidate()
  self._ban_ui.btn_banQuestion:isValidate()
  self._ban_ui.list2_ban:isValidate()
  self._ban_ui.btn_banDelete:isValidate()
  self._ban_ui.btn_banDeleteAll:isValidate()
end
function PaGlobal_ChatOption_All:resize()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  Panel_Window_ChatOption_All:ComputePos()
end
function PaGlobal_ChatOption_All:blockListInitialize()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  self._ban_ui.stc_banList = UI.getChildControl(Panel_Window_ChatOption_All, "Static_Ban_List")
  self._ban_ui.stc_banTitle = UI.getChildControl(self._ban_ui.stc_banList, "Static_Main_Ban_Bg")
  self._ban_ui.btn_banClose = UI.getChildControl(self._ban_ui.stc_banTitle, "Button_Ban_Close")
  self._ban_ui.btn_banQuestion = UI.getChildControl(self._ban_ui.stc_banTitle, "Button_Ban_Question")
  self._ban_ui.list2_ban = UI.getChildControl(self._ban_ui.stc_banList, "List2_Ban_Player")
  self._ban_ui.btn_banDelete = UI.getChildControl(self._ban_ui.stc_banList, "Button_Delete")
  self._ban_ui.btn_banDeleteAll = UI.getChildControl(self._ban_ui.stc_banList, "Button_Delete_All")
  self._ban_ui.list2_ban:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ChatOption_All_UpdateBlockList")
  self._ban_ui.list2_ban:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ban_ui.btn_banClose:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_CloseBlockList()")
  self._ban_ui.btn_banDelete:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_DeleteBlockList()")
  self._ban_ui.btn_banDeleteAll:addInputEvent("Mouse_LUp", "HandleEventLUp_ChatOption_All_DeleteAllBlockList()")
end
function PaGlobal_ChatOption_All:toggleBlockList()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if self._ban_ui.stc_banList:GetShow() then
    self._ban_ui.stc_banList:SetShow(false)
  else
    self._ban_ui.stc_banList:SetShow(true)
  end
end
function PaGlobal_ChatOption_All:updateBlockList()
  if nil == Panel_Window_ChatOption_All then
    return
  end
  if false == self._ban_ui.stc_banList:GetShow() then
    return
  end
  self._ban_ui.list2_ban:getElementManager():clearKey()
  local blockCount = ToClient_RequestBlockCount()
  for ii = 0, blockCount - 1 do
    self._ban_ui.list2_ban:getElementManager():pushKey(ii)
  end
end
