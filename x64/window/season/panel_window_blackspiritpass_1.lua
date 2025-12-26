function PaGlobal_BlackspiritPass:initialize()
  if true == self._initialize then
    return
  end
  self:controlAll_Init()
  self:controlAll_Init_Console()
  self:controlSetShow()
  self:registEventHandler()
  self:validate()
  self:setSeasonDate()
  self:updateTotalQuestInfo()
  self:updateQuestListControl()
  self:updateSeasonPassLockState()
  self:clearQuestLoadingTable()
  self._ui._stc_blackSpiritPassMain:SetSize(self._ui._stc_blackSpiritPassMain:GetSizeX(), Panel_Window_BeginnerRoadmap:GetSizeY())
  self._ui._stc_blackSpiritPassMain:ComputePos()
  self._initialize = true
  if _ContentsGroup_RenewUI == false then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
end
function PaGlobal_BlackspiritPass:controlAll_Init()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  self._ui._stc_blackSpiritPassMain = UI.getChildControl(Panel_Window_BeginnerRoadmap, "Static_BlackspiritPass")
  self._ui._stc_banner = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "Static_BannerArea")
  self._ui._txt_date = UI.getChildControl(self._ui._stc_banner, "StaticText_Date")
  self._ui._btn_directBuy = UI.getChildControl(self._ui._stc_banner, "Button_ClickGuide")
  self._ui._btn_seasonGuide = UI.getChildControl(self._ui._stc_banner, "Button_SeasonGuide")
  local isRealConsole = ToClient_isConsole()
  if isRealConsole == false then
    self._ui._btn_seasonGuide:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_ShowSeasonPassGuideNote()")
  end
  self._ui._btn_seasonGuide:SetMonoTone(isRealConsole)
  self._ui._btn_seasonGuide:SetIgnore(isRealConsole)
  self._ui._btn_toggleShowRoadMap = UI.getChildControl(self._ui._stc_banner, "CheckButton_Pass_Toggle")
  self._ui._btn_toggleShowRoadMap:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_ToggleShowRoadMap()")
  self._ui._btn_toggleShowRoadMap:SetCheck(true)
  self._ui._btn_toggleShowRoadMap:SetShow(_ContentsGroup_UseBeginnerRoadMap)
  self._ui._list_quest = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "List2_Quest")
  self._ui._stc_lockBG = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "Static_LockBG")
  self._ui._stc_lockIcon = UI.getChildControl(self._ui._stc_lockBG, "Static_TopLock")
  self._ui._stc_lockEffect = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "Static_LockEffect")
  self._ui._stc_graduation = UI.getChildControl(Panel_Window_BeginnerRoadmap, "Static_Graduation")
  self._ui._btn_graduation = UI.getChildControl(self._ui._stc_graduation, "Button_Graduation")
  self._ui._txt_blackSpiritBuyDesc = UI.getChildControl(self._ui._stc_graduation, "StaticText_DescPass")
  self._ui._stc_bottomDescBg = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "Static_BottomDesc")
  self._ui._txt_bottomDesc = UI.getChildControl(self._ui._stc_bottomDescBg, "StaticText_Desc")
  self._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONPASS_BOTTOM_DESC_1"))
  self._ui._txt_ForceGraduate = UI.getChildControl(self._ui._stc_bottomDescBg, "StaticText_ForceGraduate")
  self._ui._txt_RateViewLink = UI.getChildControl(self._ui._stc_bottomDescBg, "StaticText_RateView_Link")
  self._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_bottomDesc:SetText(self._ui._txt_bottomDesc:GetText())
  self._ui._txt_bottomDesc:SetSize(self._ui._txt_bottomDesc:GetSizeX(), self._ui._txt_bottomDesc:GetTextSizeY())
  self._ui._txt_ForceGraduate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONPASS_BOTTOM_DESC_STOPSEASON_BASE"))
  self._ui._txt_ForceGraduate:SetSize(self._ui._txt_ForceGraduate:GetSizeX(), self._ui._txt_ForceGraduate:GetTextSizeY() + 10)
  self._ui._txt_ForceGraduate:SetSpanSize(self._ui._stc_bottomDescBg:GetSpanSize().x, self._ui._txt_bottomDesc:GetPosY() + self._ui._txt_bottomDesc:GetSizeY())
  self._ui._txt_RateViewLink:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK"))
  self._ui._txt_RateViewLink:SetSize(self._ui._txt_RateViewLink:GetSizeX(), self._ui._txt_RateViewLink:GetTextSizeY() + 10)
  self._ui._txt_RateViewLink:SetSpanSize(self._ui._txt_RateViewLink:GetSpanSize().x, self._ui._txt_ForceGraduate:GetPosY() + self._ui._txt_ForceGraduate:GetSizeY())
  self._ui._stc_bottomDescBg:SetSize(self._ui._stc_bottomDescBg:GetSizeX(), self._ui._txt_bottomDesc:GetSizeY() + self._ui._txt_ForceGraduate:GetSizeY() + self._ui._txt_RateViewLink:GetSizeY() + 5)
  self._ui._stc_subTitleArea = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "Static_SubTitleArea")
  local listContent = self._ui._list_quest:GetContent()
  local normalSlotBG = UI.getChildControl(listContent, "Static_NormalSlotBG")
  local slotBG = UI.getChildControl(normalSlotBG, "Static_Slot")
  local slot = {}
  SlotItem.new(slot, "NormalSlot", nil, slotBG, self._rewardSlotConfig)
  slot:createChild()
  slot:clearItem()
  slot.icon:SetHorizonCenter()
  slot.icon:SetVerticalMiddle()
  local premiumBack = UI.getChildControl(listContent, "Static_PremiumBackground")
  local premiumSlotBG = UI.getChildControl(premiumBack, "Static_PremiumSlotBG")
  local slotBG = UI.getChildControl(premiumSlotBG, "Static_Slot")
  local slot = {}
  SlotItem.new(slot, "PremiumSlot", nil, slotBG, self._rewardSlotConfig)
  slot:createChild()
  slot:clearItem()
  slot.icon:SetHorizonCenter()
  slot.icon:SetVerticalMiddle()
  local stc_graduateBg = UI.getChildControl(Panel_Season_Graduation_All, "Static_Contents")
  self._ui._btn_gradutaionConfirm = UI.getChildControl(stc_graduateBg, "Button_Confirm")
  self._ui._btn_gradutaionCancel = UI.getChildControl(stc_graduateBg, "Button_Cancle")
  local stc_title = UI.getChildControl(Panel_Season_Graduation_All, "StaticText_Title")
  self._ui._btn_gradutationClose = UI.getChildControl(stc_title, "Button_Close")
  self._ui._stc_frameGraduate = UI.getChildControl(stc_graduateBg, "Frame_1")
  self._ui._stc_frameContents = UI.getChildControl(self._ui._stc_frameGraduate, "Frame_1_Content")
  self._ui._btn_scrollGraduate = UI.getChildControl(self._ui._stc_frameGraduate, "Frame_1_VerticalScroll")
  local txt_desc = UI.getChildControl(self._ui._stc_frameContents, "StaticText_Desc")
  local txtSizeY = txt_desc:GetTextSizeY()
  self._ui._stc_frameContents:SetSize(self._ui._stc_frameContents:GetSizeX(), txtSizeY + 10)
  self._ui._stc_frameContents:ComputePos()
  self._ui._stc_frameGraduate:UpdateContentScroll()
  self._scrollSizeY = self._ui._stc_frameContents:GetSizeY()
  self._maxScrollSizeY = self._scrollSizeY / 100
  self._scrollValue = self._scrollSizeY / 1000
end
function PaGlobal_BlackspiritPass:controlAll_Init_Console()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  self._ui._stc_keyGuideArea = UI.getChildControl(self._ui._stc_blackSpiritPassMain, "Static_KeyGuide_Console")
  self._ui._stc_keyGuideArea:SetShow(self._isConsole)
  self._keyguide_graduate = UI.getChildControl(Panel_Season_Graduation_All, "Static_KeyGuide_ConsoleUI")
  self._keyguide_graduate:SetShow(self._isConsole)
  if self._isConsole == false then
    return
  end
  self._ui._stc_keyGuide_RT_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_RTX_ConsoleUI")
  self._ui._stc_keyGuide_RT_Y = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_RTY_ConsoleUI")
  self._ui._stc_keyGuide_LT_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_LTX_ConsoleUI")
  self._ui._stc_keyGuide_LT_Y = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_LTY_ConsoleUI")
  self._ui._stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_X_ConsoleUI")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_B_ConsoleUI")
  self._keyguide_graduate_A = UI.getChildControl(self._keyguide_graduate, "StaticText_KeyGuide_A_ConsoleUI")
  self._keyguide_graduate_B = UI.getChildControl(self._keyguide_graduate, "StaticText_KeyGuide_B_ConsoleUI")
  self._keyguide_graduate_RS = UI.getChildControl(self._keyguide_graduate, "StaticText_Move_ConsoleUI")
  self:setKeyGuideAlign(0)
end
function PaGlobal_BlackspiritPass:setKeyGuideAlign(mode)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if self._lastKeyGuideAlignMode == mode then
    return
  end
  self._ui._stc_keyGuide_RT_X:SetShow(false)
  self._ui._stc_keyGuide_RT_Y:SetShow(false)
  self._ui._stc_keyGuide_LT_X:SetShow(false)
  self._ui._stc_keyGuide_LT_Y:SetShow(false)
  self._ui._stc_keyGuide_X:SetShow(false)
  self._ui._stc_keyGuide_A:SetShow(false)
  self._ui._stc_keyGuide_Y:SetShow(false)
  self._ui._stc_keyGuide_B:SetShow(false)
  local keyGuides = Array.new()
  if mode == 0 then
    keyGuides:push_back(self._ui._stc_keyGuide_B)
    keyGuides:push_back(self._ui._stc_keyGuide_A)
    keyGuides:push_back(self._ui._stc_keyGuide_X)
    keyGuides:push_back(self._ui._stc_keyGuide_LT_Y)
    if self._hasSeasonPass == false then
      keyGuides:push_back(self._ui._stc_keyGuide_LT_X)
    end
    if ToClient_isConsole() == false then
      keyGuides:push_back(self._ui._stc_keyGuide_RT_Y)
    end
    if _ContentsGroup_UseBeginnerRoadMap == true then
      keyGuides:push_back(self._ui._stc_keyGuide_RT_X)
    end
  elseif mode == 1 then
    keyGuides:push_back(self._ui._stc_keyGuide_B)
    keyGuides:push_back(self._ui._stc_keyGuide_A)
    keyGuides:push_back(self._ui._stc_keyGuide_Y)
    keyGuides:push_back(self._ui._stc_keyGuide_X)
    keyGuides:push_back(self._ui._stc_keyGuide_LT_Y)
    if self._hasSeasonPass == false then
      keyGuides:push_back(self._ui._stc_keyGuide_LT_X)
    end
    if ToClient_isConsole() == false then
      keyGuides:push_back(self._ui._stc_keyGuide_RT_Y)
    end
    if _ContentsGroup_UseBeginnerRoadMap == true then
      keyGuides:push_back(self._ui._stc_keyGuide_RT_X)
    end
  elseif mode == 2 then
    keyGuides:push_back(self._ui._stc_keyGuide_B)
    keyGuides:push_back(self._ui._stc_keyGuide_A)
    if self._ui._stc_keyGuide_Y:GetShow() == true then
      keyGuides:push_back(self._ui._stc_keyGuide_Y)
    end
    keyGuides:push_back(self._ui._stc_keyGuide_X)
    keyGuides:push_back(self._ui._stc_keyGuide_LT_Y)
    if self._hasSeasonPass == false then
      keyGuides:push_back(self._ui._stc_keyGuide_LT_X)
    end
    if ToClient_isConsole() == false then
      keyGuides:push_back(self._ui._stc_keyGuide_RT_Y)
    end
    if _ContentsGroup_UseBeginnerRoadMap == true then
      keyGuides:push_back(self._ui._stc_keyGuide_RT_X)
    end
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 mode\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local termSpanY = 5
  for key, value in pairs(keyGuides) do
    if value ~= nil then
      value:SetShow(true)
      value:SetSpanSize(value:GetSpanSize().x, 10 + termSpanY * key + value:GetSizeY() * (key - 1))
    end
  end
  self._lastKeyGuideAlignMode = mode
  self._ui._stc_keyGuideArea:ComputePosAllChild()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._keyguide_graduate_RS,
    self._keyguide_graduate_A,
    self._keyguide_graduate_B
  }, self._keyguide_graduate, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_BlackspiritPass:controlSetShow()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  self._ui._btn_directBuy:SetMonoTone(self._isConsole)
  self._ui._btn_directBuy:SetIgnore(self._isConsole)
  if self._isConsole == true then
    self._ui._btn_directBuy:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobal_BlackspiritPass:registEventHandler()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  registerEvent("FromClient_notifyUpdateSeasonPassQuest", "FromClient_BlackspiritPass_UpdateSeasonPassQuest")
  registerEvent("FromClient_SeasonPassUpdate", "FromClient_BlackspiritPass_NotifyGetSeasonPass")
  registerEvent("EventQuestUpdateNotify", "FromClient_BlackspiritPass_EventQuestUpdateNotify")
  registerEvent("FromClient_SuccessSeasonGraduateAck", "FromClient_SuccessSeasonGraduateAck")
  if _ContentsGroup_QuestBackEndLoading == true then
    registerEvent("FromClient_QuestBackEndLoadComplete", "FromClient_BlackSpiritPass_QuestBackEndLoadComplete")
  end
  if self._isConsole == false then
    self._ui._btn_directBuy:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
    self._ui._stc_lockIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
  else
    Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
    self._ui._btn_gradutaionConfirm:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_BlackspiritPass_GraduateDesc(false)")
    self._ui._btn_gradutaionConfirm:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_BlackspiritPass_GraduateDesc(true)")
    self._ui._btn_gradutaionCancel:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandleEventScroll_BlackspiritPass_GraduateDesc(false)")
    self._ui._btn_gradutaionCancel:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandleEventScroll_BlackspiritPass_GraduateDesc(true)")
  end
  self._ui._list_quest:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_BlackspiritPass_UpdateListContent")
  self._ui._list_quest:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_graduation:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GraduateShow()")
  self._ui._txt_ForceGraduate:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GraduateForce()")
  self._ui._txt_ForceGraduate:addInputEvent("Mouse_On", "HandleEventOn_BlackspiritPass_ChangeForceGraduateDesc(true)")
  self._ui._txt_ForceGraduate:addInputEvent("Mouse_Out", "HandleEventOn_BlackspiritPass_ChangeForceGraduateDesc(false)")
  self._ui._txt_RateViewLink:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackSpiritPass_OpenRateViewByLink()")
  self._ui._txt_RateViewLink:addInputEvent("Mouse_On", "HandleEventOnOut_BlackSpiritPass_ChangeRateViewButtonText(true)")
  self._ui._txt_RateViewLink:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackSpiritPass_ChangeRateViewButtonText(false)")
  self._ui._btn_gradutaionConfirm:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_Graduate()")
  self._ui._btn_gradutaionCancel:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GraduateHide()")
  self._ui._btn_gradutationClose:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GraduateHide()")
  self._ui._btn_gradutationClose:SetShow(_ContentsGroup_RenewUI == false)
end
function PaGlobal_BlackspiritPass:prepareOpen()
  if Panel_Window_BeginnerRoadmap == nil then
    return false
  end
  local isPlayShowAnimation = true
  self._graduateType = -1
  if _ContentsGroup_UseBeginnerRoadMap == true then
    local showRoadMapUIToggleValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eShowBeginnerRoadMapUI)
    if showRoadMapUIToggleValue < 2 then
      self._ui._btn_toggleShowRoadMap:SetCheck(true)
      PaGlobalFunc_BeginnerRoadMap_Open(false)
      isPlayShowAnimation = false
    else
      self._ui._btn_toggleShowRoadMap:SetCheck(false)
      if PaGlobalFunc_BeginnerRoadMap_GetShow() == true then
        PaGlobalFunc_BeginnerRoadMap_Close()
      end
      isPlayShowAnimation = true
    end
  end
  ToClient_autoAcceptSeasonPass()
  if self._hasSeasonPass == true then
    self._ui._stc_lockBG:SetShow(false)
    self._ui._btn_directBuy:SetMonoTone(true)
    self._ui._btn_directBuy:SetIgnore(true)
    self._ui._btn_directBuy:addInputEvent("Mouse_LUp", "")
    if true == self._isConsole then
      self._ui._stc_blackSpiritPassMain:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    end
  else
    self._ui._btn_directBuy:SetMonoTone(false)
    self._ui._btn_directBuy:SetIgnore(false)
  end
  self:updateTotalQuestInfo()
  self:updateQuestListControl()
  local count = self:getClearQuestCount()
  if count >= 3 then
    local moveIndex = count - 2
    self._ui._list_quest:moveIndex(moveIndex)
    if self._isConsole == true then
      local moveKey = self._ui._list_quest:getKeyByIndex(moveIndex)
      local moveContent = self._ui._list_quest:GetContentByKey(moveKey)
      if moveContent ~= nil then
        local normalSlotBG = UI.getChildControl(moveContent, "Static_NormalSlotBG")
        local normalSlot = UI.getChildControl(normalSlotBG, "Static_Slot")
        if normalSlot ~= nil then
          ToClient_padSnapChangeToTarget(normalSlot)
        end
      end
    end
  end
  self._isHideDelay = false
  self._ui._txt_blackSpiritBuyDesc:SetShow(self._hasSeasonPass == false)
  if ToClient_isAllClearSeasonPass() == true then
    HandleEventOnOut_BlackspiritPass_ShowItemTooltip(false, -1, false, -1)
    self._ui._stc_graduation:SetShow(true)
    self._ui._list_quest:SetShow(false)
    self._ui._txt_ForceGraduate:SetIgnore(true)
  else
    self._ui._stc_graduation:SetShow(false)
    self._ui._list_quest:SetShow(true)
    self._ui._txt_ForceGraduate:SetIgnore(false)
  end
  PaGlobal_BlackspiritPass:open()
  HandleEventOn_BlackspiritPass_ChangeForceGraduateDesc(false)
  HandleEventOnOut_BlackSpiritPass_ChangeRateViewButtonText(false)
  return isPlayShowAnimation
end
function PaGlobal_BlackspiritPass:open()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  Panel_Window_BeginnerRoadmap:RegisterUpdateFunc("PaGlobal_BlackspiritPass_Update")
  self._ui._stc_blackSpiritPassMain:SetShow(true)
end
function PaGlobal_BlackspiritPass:prepareClose()
  if Panel_Window_BeginnerRoadmap == nil then
    return false
  end
  if _ContentsGroup_QuestBackEndLoading == true then
    self:clearQuestLoadingTable()
  end
  local isPlayCloseAnimation = true
  if _ContentsGroup_UseBeginnerRoadMap == true then
    local isCheckShowRoadMap = self._ui._btn_toggleShowRoadMap:IsCheck()
    if isCheckShowRoadMap == true then
      PaGlobalFunc_BeginnerRoadMap_Close()
    end
    isPlayCloseAnimation = not isCheckShowRoadMap
  end
  if true == PaGlobal_BlackspiritPass._isConsole and nil ~= TooltipBlackSpiritPass_IsShow and true == TooltipBlackSpiritPass_IsShow() then
    TooltipBlackSpiritPass_Hide()
    return false
  end
  TooltipBlackSpiritPass_Hide()
  TooltipBlackSpiritPassQuest_Hide()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
    PaGlobalFunc_Widget_FunctionButton_ShowBlackspiritReopenGuideEffect()
  end
  self._animListIdx = nil
  if isPlayCloseAnimation == true then
    self._isHideDelay = true
  end
  PaGlobal_BlackspiritPass:close()
  return isPlayCloseAnimation
end
function PaGlobal_BlackspiritPass:close()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  if self._isHideDelay == false then
    self._ui._stc_blackSpiritPassMain:SetShow(false)
  end
  Panel_Window_BeginnerRoadmap:ClearUpdateLuaFunc()
end
function PaGlobal_BlackspiritPass:validate()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  self._ui._stc_banner:isValidate()
  self._ui._btn_directBuy:isValidate()
  self._ui._btn_seasonGuide:isValidate()
  self._ui._btn_toggleShowRoadMap:isValidate()
  self._ui._txt_date:isValidate()
  self._ui._list_quest:isValidate()
  self._ui._stc_lockBG:isValidate()
  self._ui._stc_lockIcon:isValidate()
  self._ui._stc_lockEffect:isValidate()
  self._ui._stc_bottomDescBg:isValidate()
  self._ui._txt_bottomDesc:isValidate()
  self._ui._stc_subTitleArea:isValidate()
  self._ui._stc_keyGuideArea:isValidate()
  if self._isConsole == true then
    self._ui._stc_keyGuide_RT_X:isValidate()
    self._ui._stc_keyGuide_RT_Y:isValidate()
    self._ui._stc_keyGuide_LT_X:isValidate()
    self._ui._stc_keyGuide_LT_Y:isValidate()
    self._ui._stc_keyGuide_X:isValidate()
    self._ui._stc_keyGuide_A:isValidate()
    self._ui._stc_keyGuide_Y:isValidate()
    self._ui._stc_keyGuide_B:isValidate()
  end
end
function PaGlobal_BlackspiritPass:setSeasonDate()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local startTime = PATime(ToClient_getStartSeasonTime())
  local endTime = PATime(ToClient_getEndSeasonTime())
  local start_monthStr = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. startTime:GetMonth())
  local end_monthStr = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. endTime:GetMonth())
  local strConnect = "-"
  if true == isGameTypeKorea() then
    strConnect = "~"
  end
  local startDate = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", startTime:GetYear(), "GetMonth", start_monthStr, "GetDay", startTime:GetDay())
  local endDate = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", endTime:GetYear(), "GetMonth", end_monthStr, "GetDay", endTime:GetDay())
  self._ui._txt_date:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_date:SetText(startDate .. strConnect .. endDate)
end
function PaGlobal_BlackspiritPass:updateTotalQuestInfo()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    self:updateQuestInfo(index)
  end
end
function PaGlobal_BlackspiritPass:updateQuestInfo(listIdx)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local questInfo = {
    title = nil,
    desc = nil,
    normalQuestNo = nil,
    normalReward = nil,
    normalQuestState = nil,
    premiumQuestNo = nil,
    premiumReward = nil,
    premiumQuestState = nil,
    isLoading = false
  }
  local isLoadingQuest = false
  local questWrapper = ToClient_GetSeasonPassQuestAt(listIdx, __eSeasonPassQuest_Normal)
  if questWrapper ~= nil then
    local questNo = questWrapper:getQuestNo()
    if questWrapper:isHaveBackEndData() == true then
      questInfo.title = questWrapper:getTitle()
      questInfo.desc = self:getQuestDesc(questNo)
      if ToClient_CanShowChangedSeasonPass(listIdx) == true then
        local changedTitle = ToClient_GetSeasonPassChangedTitle(listIdx)
        local changedDesc = ToClient_GetSeasonPassChangedDesc(listIdx)
        if nil ~= changedTitle and nil ~= changedDesc then
          questInfo.title = changedTitle
          questInfo.desc = changedDesc
        end
      end
      questInfo.normalQuestNo = questNo
      questInfo.normalReward = self:getQuestReward(questNo)
      if self:isRepeatQuestion(questNo) == false then
        questInfo.normalQuestState = self:getQuestState(questNo)
      else
        questInfo.normalQuestState = self:getRepeatQuestState(questNo)
      end
    else
      self:pushLoadingData(listIdx, questWrapper, __eSeasonPassQuest_Normal)
      isLoadingQuest = true
    end
  end
  local premiumQuestWrapper = ToClient_GetSeasonPassQuestAt(listIdx, __eSeasonPassQuest_SeasonPass)
  if premiumQuestWrapper ~= nil then
    local questNo = premiumQuestWrapper:getQuestNo()
    if premiumQuestWrapper:isHaveBackEndData() == true then
      questInfo.premiumQuestNo = questNo
      questInfo.premiumReward = self:getQuestReward(questNo)
      if self:isRepeatQuestion(questNo) == false then
        questInfo.premiumQuestState = self:getQuestState(questNo)
      else
        questInfo.premiumQuestState = self:getRepeatQuestState(questNo)
      end
    else
      self:pushLoadingData(listIdx, premiumQuestWrapper, __eSeasonPassQuest_SeasonPass)
      isLoadingQuest = true
    end
  end
  if isLoadingQuest == true then
    questInfo.isLoading = true
  end
  self._questInfo[listIdx] = questInfo
end
function PaGlobal_BlackspiritPass:getQuestDesc(questNo)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local groupIdx = questNo._group
  local questIdx = questNo._quest
  local questStaticInfo = questList_getQuestStatic(groupIdx, questIdx)
  if nil ~= questStaticInfo then
    return questStaticInfo:getDemandAt(0)._desc
  end
  return ""
end
function PaGlobal_BlackspiritPass:getQuestReward(questNo)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local questWrapper = ToClient_getQuestWrapper(questNo)
  if nil ~= questWrapper then
    local baseRewardWrapper = questWrapper:getQuestBaseRewardAt(0)
    if nil ~= baseRewardWrapper then
      local baseReward = baseRewardWrapper:get()
      return baseReward
    end
  end
  return nil
end
function PaGlobal_BlackspiritPass:isRepeatQuestion(questNo)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local repeatTime = ToClient_ClearedQuestRepeatTime(questNo._group, questNo._quest)
  return repeatTime > 0
end
function PaGlobal_BlackspiritPass:getQuestState(questNo)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local groupIdx = questNo._group
  local questIdx = questNo._quest
  local questInfo
  local questSatisfied = false
  local questCleared = questList_isClearQuest(groupIdx, questIdx)
  local isProgressingQuest = ToClient_isProgressingQuest(groupIdx, questIdx)
  if true == isProgressingQuest then
    questInfo = ToClient_GetQuestInfo(groupIdx, questIdx)
    if nil ~= questInfo then
      questSatisfied = questInfo:isSatisfied()
    end
  else
    questInfo = questList_getQuestStatic(groupIdx, questIdx)
  end
  if nil == questInfo then
    return self._state.none
  end
  if true == questCleared then
    return self._state.clickedReward
  elseif true == questSatisfied then
    return self._state.clear
  else
    return self._state.progressing
  end
end
function PaGlobal_BlackspiritPass:getRepeatQuestState(questNo)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local groupIdx = questNo._group
  local questIdx = questNo._quest
  local questInfo = ToClient_GetQuestInfo(groupIdx, questIdx)
  local questCleared = questList_isClearQuest(groupIdx, questIdx)
  if nil == questInfo then
    if questCleared then
      return self._state.clickedReward
    end
    return self._state.progressing
  elseif true == questCleared then
    return self._state.clickedReward
  elseif true == questInfo:isSatisfied() then
    return self._state.clear
  else
    return self._state.progressing
  end
end
function PaGlobal_BlackspiritPass:updateQuestListControl()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  self._ui._list_quest:getElementManager():clearKey()
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    self._ui._list_quest:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_BlackspiritPass:updateListContent(content, key)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  if content == nil then
    return
  end
  local index = Int64toInt32(key)
  local questBG = UI.getChildControl(content, "Static_QuestBG")
  local txt_title = UI.getChildControl(questBG, "StaticText_Title")
  local txt_desc = UI.getChildControl(questBG, "StaticText_Desc")
  local stc_missionStamp = UI.getChildControl(content, "Static_CompleteStamp")
  local stc_loadingBG = UI.getChildControl(content, "Static_Loading_BG")
  local normalSlotBG = UI.getChildControl(content, "Static_NormalSlotBG")
  local normalSlotIcon = UI.getChildControl(normalSlotBG, "Static_Slot")
  local normalSlotGet = UI.getChildControl(normalSlotBG, "Static_Get")
  local normalSlot = {}
  SlotItem.reInclude(normalSlot, "NormalSlot", 0, normalSlotIcon, self._rewardSlotConfig)
  normalSlot.icon:SetIgnore(true)
  local premiumBack = UI.getChildControl(content, "Static_PremiumBackground")
  local premiumSlotBG = UI.getChildControl(premiumBack, "Static_PremiumSlotBG")
  local premiumSlotIcon = UI.getChildControl(premiumSlotBG, "Static_Slot")
  local premiumSlotGet = UI.getChildControl(premiumSlotBG, "Static_Get")
  local premiumSlot = {}
  SlotItem.reInclude(premiumSlot, "PremiumSlot", 0, premiumSlotIcon, self._rewardSlotConfig)
  premiumSlot.icon:SetIgnore(true)
  normalSlotIcon:EraseAllEffect()
  premiumSlotIcon:EraseAllEffect()
  local btn_Way = UI.getChildControl(questBG, "Button_Waypoint")
  btn_Way:SetShow(false)
  local isLoading = false
  local questInfo = self._questInfo[index]
  if questInfo ~= nil then
    isLoading = questInfo.isLoading
    if isLoading == true then
      stc_loadingBG:SetShow(true)
    else
      stc_loadingBG:SetShow(false)
      txt_title:SetTextMode(__eTextMode_LimitText)
      txt_title:SetText(questInfo.title)
      txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
      txt_desc:setLineCountByLimitAutoWrap(2)
      txt_desc:SetText(questInfo.desc)
      txt_desc:addInputEvent("Mouse_On", "TooltipBlackSpiritPassQuest_Show(" .. index .. ")")
      txt_desc:addInputEvent("Mouse_Out", "TooltipBlackSpiritPassQuest_Hide()")
      normalSlotIcon:ChangeTextureInfoNameAsync("")
      normalSlotIcon:setRenderTexture(normalSlotIcon:getBaseTexture())
      local normalReward = questInfo.normalReward
      if normalReward ~= nil then
        if __eRewardSeasonReward == normalReward._type then
          normalSlot:clearItem()
          normalSlotIcon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/00750592.dds")
          normalSlotIcon:setRenderTexture(normalSlotIcon:getBaseTexture())
          if self._isConsole == false then
            normalSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. 0 .. ",true )")
            normalSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( false )")
          else
            normalSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. 0 .. " ,true)")
            if ToClient_isConsole() == false then
              normalSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip(false)")
            end
          end
        else
          local itemKey = normalReward:getItemEnchantKey()
          local itemCount = normalReward._itemCount
          local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
          if itemSSW ~= nil then
            normalSlot:clearItem()
            normalSlot:setItemByStaticStatus(itemSSW, itemCount)
            if self._isConsole == false then
              normalSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. itemKey .. " )")
              normalSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( false )")
            else
              normalSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. itemKey .. " )")
              if ToClient_isConsole() == false then
                normalSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip(false)")
              end
            end
          end
        end
      end
      local premiumReward = questInfo.premiumReward
      if premiumReward ~= nil then
        premiumSlotIcon:ChangeTextureInfoNameAsync("")
        premiumSlotIcon:setRenderTexture(premiumSlotIcon:getBaseTexture())
        if __eRewardSeasonReward == premiumReward._type then
          premiumSlot:clearItem()
          premiumSlotIcon:ChangeTextureInfoNameAsync("Icon/New_Icon/03_ETC/00750592.dds")
          premiumSlotIcon:setRenderTexture(premiumSlotIcon:getBaseTexture())
          if self._isConsole == false then
            premiumSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. 0 .. ",true )")
            premiumSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( false )")
          else
            premiumSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", false, " .. 0 .. " ,true)")
            if ToClient_isConsole() == false then
              premiumSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip(false)")
            end
          end
        else
          local itemKey = premiumReward:getItemEnchantKey()
          local itemCount = premiumReward._itemCount
          local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
          if itemSSW ~= nil then
            premiumSlot:clearItem()
            premiumSlot:setItemByStaticStatus(itemSSW, itemCount)
            if self._isConsole == false then
              premiumSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", true, " .. itemKey .. " )")
              premiumSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( false )")
            else
              premiumSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_BlackspiritPass_ShowItemTooltip( true, " .. index .. ", true, " .. itemKey .. " )")
              if ToClient_isConsole() == false then
                premiumSlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_BlackspiritPass_ShowItemTooltip(false)")
              end
            end
          end
          if self._isConsole == true then
            normalSlotIcon:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "TooltipBlackSpiritPassQuest_Show_ForConsole(" .. index .. ")")
            premiumSlotIcon:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "TooltipBlackSpiritPassQuest_Show_ForConsole(" .. index .. ")")
          end
        end
      end
    end
  end
  if isLoading == false then
    if self._state.clear <= questInfo.normalQuestState then
      questBG:SetMonoTone(true)
      stc_missionStamp:SetShow(true)
      if self._state.clickedReward == questInfo.normalQuestState then
        normalSlotIcon:SetMonoTone(true)
        normalSlotGet:SetShow(true)
        normalSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
      elseif self._state.clear == questInfo.normalQuestState then
        normalSlotIcon:SetMonoTone(false)
        normalSlotGet:SetShow(false)
        normalSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. index .. ", false )")
        normalSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
      else
        normalSlotIcon:SetMonoTone(true)
        normalSlotGet:SetShow(false)
        normalSlotIcon:addInputEvent("Mouse_LUp", "")
      end
      if true == self._hasSeasonPass and self._state.clickedReward == questInfo.normalQuestState then
        if self._state.clickedReward == questInfo.premiumQuestState then
          premiumSlotIcon:SetMonoTone(true)
          premiumSlotGet:SetShow(true)
          premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
        elseif self._state.clear == questInfo.premiumQuestState then
          premiumSlotIcon:SetMonoTone(false)
          premiumSlotGet:SetShow(false)
          premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. index .. ", true )")
          premiumSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        else
          premiumSlotIcon:SetMonoTone(true)
          premiumSlotGet:SetShow(false)
          premiumSlotIcon:addInputEvent("Mouse_LUp", "")
        end
      else
        premiumSlotIcon:SetMonoTone(true)
        premiumSlotGet:SetShow(false)
        premiumSlotIcon:addInputEvent("Mouse_LUp", "")
      end
      if self._isConsole == true then
        normalSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
        premiumSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      end
    else
      questBG:SetMonoTone(false)
      stc_missionStamp:SetShow(false)
      normalSlotIcon:SetMonoTone(false)
      normalSlotGet:SetShow(false)
      normalSlotIcon:addInputEvent("Mouse_LUp", "")
      premiumSlotIcon:SetMonoTone(false)
      premiumSlotGet:SetShow(false)
      premiumSlotIcon:addInputEvent("Mouse_LUp", "")
      local questWrapper = ToClient_GetSeasonPassQuestAt(index, __eSeasonPassQuest_Normal)
      if questWrapper == nil then
        return
      end
      btn_Way:SetPosX(txt_title:GetPosX() + txt_title:GetTextSizeX() + 20)
      local isEnable = questWrapper:getQuestPositionCount() ~= 0
      btn_Way:SetShow(isEnable)
      if isEnable == true then
        btn_Way:addInputEvent("Mouse_LUp", "PaGlobalFunc_Quest_All_FindWay(" .. questInfo.normalQuestNo._group .. "," .. questInfo.normalQuestNo._quest .. "," .. QuestConditionCheckType.eQuestConditionCheckType_Progress .. ",false)")
        if self._isConsole == true then
          normalSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_Quest_All_FindWay(" .. questInfo.normalQuestNo._group .. "," .. questInfo.normalQuestNo._quest .. "," .. QuestConditionCheckType.eQuestConditionCheckType_Progress .. ",false)")
          premiumSlotIcon:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_Quest_All_FindWay(" .. questInfo.normalQuestNo._group .. "," .. questInfo.normalQuestNo._quest .. "," .. QuestConditionCheckType.eQuestConditionCheckType_Progress .. ",false)")
        end
      end
    end
    if self._isConsole == true then
      normalSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_RefreshKeyGuide(" .. index .. ")")
      premiumSlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_BlackspiritPass_RefreshKeyGuide(" .. index .. ")")
    end
  end
end
function PaGlobal_BlackspiritPass:getListIndex(InQuestNo)
  if nil == Panel_Window_BeginnerRoadmap then
    return -1, false
  end
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    local normalQuestNo = self._questInfo[index].normalQuestNo
    if normalQuestNo ~= nil and normalQuestNo._group == InQuestNo._group and normalQuestNo._quest == InQuestNo._quest then
      return index, false
    end
    local premiumQuestNo = self._questInfo[index].premiumQuestNo
    if premiumQuestNo ~= nil and premiumQuestNo._group == InQuestNo._group and premiumQuestNo._quest == InQuestNo._quest then
      return index, true
    end
  end
  return -1, false
end
function PaGlobal_BlackspiritPass:updateGetRewardItem(listIdx, isPremium)
  local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
  if nil == content then
    return
  end
  local rewardSlotBG
  if false == isPremium then
    rewardSlotBG = UI.getChildControl(content, "Static_NormalSlotBG")
  else
    local premiumBack = UI.getChildControl(content, "Static_PremiumBackground")
    rewardSlotBG = UI.getChildControl(premiumBack, "Static_PremiumSlotBG")
  end
  local slotIcon = UI.getChildControl(rewardSlotBG, "Static_Slot")
  local slotGet = UI.getChildControl(rewardSlotBG, "Static_Get")
  slotGet:SetShow(true)
  slotGet:SetAlpha(0)
  local ImageAni = slotGet:addColorAnimation(0.2, 0.4, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_00000000)
  ImageAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  slotGet:EraseAllEffect()
  slotGet:AddEffect("fUI_BlackSpirit_Pass_Check_01A", false, 0, -1)
  slotGet:AddEffect("UI_Check_02A", false, 0, -1)
  slotIcon:SetMonoTone(true)
  slotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_AlreadyGetReward()")
  slotIcon:EraseAllEffect()
  if false == isPremium then
    PaGlobal_BlackspiritPass._questInfo[listIdx].normalQuestState = PaGlobal_BlackspiritPass._state.clickedReward
  else
    PaGlobal_BlackspiritPass._questInfo[listIdx].premiumQuestState = PaGlobal_BlackspiritPass._state.clickedReward
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
  local questInfo = PaGlobal_BlackspiritPass._questInfo[listIdx]
  if nil ~= questInfo then
    local questNo = questInfo.normalQuestNo
    if PaGlobal_BlackspiritPass:isRepeatQuestion(questNo) and false == isPremium and true == PaGlobal_BlackspiritPass._hasSeasonPass then
      local premiumBack = UI.getChildControl(content, "Static_PremiumBackground")
      local premiumSlotBG = UI.getChildControl(premiumBack, "Static_PremiumSlotBG")
      local premiumSlotIcon = UI.getChildControl(premiumSlotBG, "Static_Slot")
      local premiumSlotGet = UI.getChildControl(premiumSlotBG, "Static_Get")
      premiumSlotIcon:SetMonoTone(false)
      premiumSlotGet:SetShow(false)
      premiumSlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_BlackspiritPass_GetRewardItem( " .. listIdx .. ", true )")
      premiumSlotIcon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
    end
  end
end
function PaGlobal_BlackspiritPass:updateSeasonPassLockState()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    self._hasSeasonPass = selfPlayer:get():isSeasonPass()
  end
  if self._ui._stc_blackSpiritPassMain:GetShow() and true == self._ui._stc_lockBG:GetShow() and true == self._hasSeasonPass then
    self:showUnlockAnimation()
  end
  self:setKeyGuideAlign(2)
end
function PaGlobal_BlackspiritPass:showUnlockAnimation()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  self._ui._stc_lockBG:SetShow(true)
  local ImageAni = self._ui._stc_lockBG:addColorAnimation(0, 0.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  ImageAni:SetEndColor(Defines.Color.C_00000000)
  ImageAni.IsChangeChild = true
  ImageAni:SetHideAtEnd(true)
  self._ui._stc_lockEffect:EraseAllEffect()
  self._ui._stc_lockEffect:AddEffect("fUI_BlackSpirit_Pass_Clear_01A", false, 0, 0)
  if false == self._isConsole then
    self._ui._btn_directBuy:SetMonoTone(true)
    self._ui._btn_directBuy:SetIgnore(true)
    self._ui._btn_directBuy:addInputEvent("Mouse_LUp", "")
  else
    self._ui._stc_blackSpiritPassMain:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
  end
end
function PaGlobal_BlackspiritPass:getClearQuestCount()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local clearCount = 0
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    local questInfo = self._questInfo[index]
    if questInfo ~= nil and questInfo.isLoading == false and self._state.clear <= questInfo.normalQuestState then
      clearCount = clearCount + 1
    end
  end
  return clearCount
end
function PaGlobal_BlackspiritPass:clearQuestLoadingTable()
  if Panel_Window_BeginnerRoadmap == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  self._questLoadingDataList = Array.new()
end
function PaGlobal_BlackspiritPass:pushLoadingData(questIndex, questSSW, seasonPassQuestType)
  if Panel_Window_BeginnerRoadmap == nil or _ContentsGroup_QuestBackEndLoading == false or questIndex == nil or questSSW == nil or seasonPassQuestType == nil then
    return
  end
  if seasonPassQuestType ~= __eSeasonPassQuest_Normal and seasonPassQuestType ~= __eSeasonPassQuest_SeasonPass then
    return
  end
  if self._questLoadingDataList == nil then
    self._questLoadingDataList = Array.new()
  end
  local newLoadingData = {
    _questIndex = questIndex,
    _questNoRaw = {
      [__eSeasonPassQuest_Normal] = nil,
      [__eSeasonPassQuest_SeasonPass] = nil
    }
  }
  newLoadingData._questNoRaw[seasonPassQuestType] = questSSW:getKey()
  local isExistValue = false
  for index = #self._questLoadingDataList, 1, -1 do
    local value = self._questLoadingDataList[index]
    if value ~= nil and value._questIndex == newLoadingData._questIndex then
      if value._questNoRaw[seasonPassQuestType] == newLoadingData._questNoRaw[seasonPassQuestType] then
        return
      else
        value._questNoRaw[seasonPassQuestType] = newLoadingData._questNoRaw[seasonPassQuestType]
        isExistValue = true
        break
      end
    end
  end
  if isExistValue == false then
    self._questLoadingDataList:push_back(newLoadingData)
  end
  questSSW:requestLoadBackEndData()
end
function PaGlobal_BlackspiritPass:isExistLoadingDataAnyOne()
  if Panel_Window_BeginnerRoadmap == nil or _ContentsGroup_QuestBackEndLoading == false then
    return false
  end
  if self._questLoadingDataList == nil then
    return false
  end
  local isExistAnyOne = self._questLoadingDataList:length() ~= 0
  return isExistAnyOne
end
