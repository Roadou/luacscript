function PaGlobal_BlackspiritPass_Open()
  if Panel_Window_BeginnerRoadmap == nil then
    return false
  end
  if _ContentsGroup_SeasonContents == false then
    UI.ASSERT_NAME(false, "\236\139\156\236\166\140 \236\187\168\236\152\181\236\157\180 \234\186\188\236\160\184\236\158\136\235\138\148\235\141\176 \236\151\172\234\184\184 \237\131\128\235\169\180\236\149\136\235\144\156\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  if ToClient_isAllSeasonPassLoaded() == false then
    return false
  end
  return PaGlobal_BlackspiritPass:prepareOpen()
end
function PaGlobal_BlackspiritPass_Close()
  if Panel_Window_BeginnerRoadmap == nil then
    return false
  end
  if _ContentsGroup_SeasonContents == false then
    UI.ASSERT_NAME(false, "\236\139\156\236\166\140 \236\187\168\236\152\181\236\157\180 \234\186\188\236\160\184\236\158\136\235\138\148\235\141\176 \236\151\172\234\184\184 \237\131\128\235\169\180\236\149\136\235\144\156\235\139\164.", "\236\157\180\236\163\188")
    return false
  end
  return PaGlobal_BlackspiritPass:prepareClose()
end
function PaGlobal_BlackspiritPass_GetShow()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  return PaGlobal_BlackspiritPass._ui._stc_blackSpiritPassMain:GetShow()
end
function PaGlobal_BlackspiritPass_UpdateListContent(content, key)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  PaGlobal_BlackspiritPass:updateListContent(content, key)
end
function PaGlobal_BlackspiritPass_IsThereAnyReward()
  if Panel_Window_BeginnerRoadmap == nil then
    return false
  end
  local self = PaGlobal_BlackspiritPass
  if self == nil then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  self._hasSeasonPass = selfPlayer:get():isSeasonPass()
  local hasItemState = self._state.clear
  local questCount = ToClient_SeasonPassQuestCount()
  for index = 0, questCount - 1 do
    local questInfo = self._questInfo[index]
    if questInfo ~= nil and (hasItemState == questInfo.normalQuestState or self._hasSeasonPass == true and hasItemState == questInfo.premiumQuestState) then
      return true
    end
  end
  return false
end
function PaGlobal_BlackspiritPass_OpenToIndex(listIdx, moveIndex)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local self = PaGlobal_BlackspiritPass
  if self == nil then
    return
  end
  if moveIndex == nil then
    moveIndex = listIdx
  end
  if PaGlobalFunc_SeasonPassAndRoadMap_GetShow() == false then
    PaGlobalFunc_SeasonPassAndRoadMap_Open()
  end
  self._ui._list_quest:moveIndex(moveIndex)
  self._ui._list_quest:Update(0, false)
  self._animListIdx = listIdx
  if self._isConsole == true then
    local moveKey = self._ui._list_quest:getKeyByIndex(listIdx)
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
function PaGlobal_BlackspiritPass_Update(deltaTime)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  PaGlobal_BlackspiritPass_StampAnimation(deltaTime)
end
function PaGlobal_BlackspiritPass_StampAnimation(deltaTime)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local self = PaGlobal_BlackspiritPass
  if self == nil then
    return
  end
  if self._animListIdx == nil then
    return
  end
  local startIndex = self._ui._list_quest:getCurrenttoIndex()
  local visibleContentCount = self._ui._list_quest:getChildContentListSize()
  local listIdx = self._animListIdx
  if startIndex <= listIdx and listIdx <= startIndex + visibleContentCount then
    local content = self._ui._list_quest:GetContentByKey(listIdx)
    if content == nil then
      return
    end
    local stc_missionStamp = UI.getChildControl(content, "Static_CompleteStamp")
    stc_missionStamp:SetShow(true)
    stc_missionStamp:ResetVertexAni()
    stc_missionStamp:SetVertexAniRun("Ani_Move_Pos_New", true)
    stc_missionStamp:SetVertexAniRun("Ani_Scale_New", true)
    self._animListIdx = nil
  end
end
function PaGlobalFunc_BlackspiritPass_SetSnapFocus(isSnapped)
  local self = PaGlobal_BlackspiritPass
  if self == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if self._ui._stc_keyGuideArea:GetShow() ~= isSnapped then
    self._ui._stc_keyGuideArea:SetShow(isSnapped)
  end
  if isSnapped == true then
    if self._hasSeasonPass == false then
      Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_BlackspiritPass_ShowEasyPayment()")
    else
      Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    end
    if ToClient_isConsole() == false then
      Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "HandleEventLUp_BlackspiritPass_ShowSeasonPassGuideNote()")
    else
      Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
    end
    if _ContentsGroup_UseBeginnerRoadMap == true then
      Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_BlackspiritPass_ToggleShowRoadMap()")
    end
  else
    Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    Panel_Window_BeginnerRoadmap:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
  end
end
function PaGlobalFunc_BlackSpiritPass_GetRewardTooltipString()
  return PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_REWARD_DESC_ETC")
end
function HandleEventOnOut_BlackspiritPass_ShowItemTooltip(isShow, listIdx, isPremium, itemKey, isSeasonCoupon)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  if isShow == false then
    if _ContentsGroup_RenewUI == false then
      Panel_Tooltip_Item_hideTooltip()
      TooltipBlackSpiritPassQuest_Hide()
      TooltipSimple_Hide()
    else
      PaGlobalFunc_TooltipInfo_Close()
      TooltipSimple_Hide()
    end
    return
  end
  if isSeasonCoupon == nil then
    isSeasonCoupon = false
  end
  if PaGlobal_BlackspiritPass._isConsole == true then
    PaGlobalFunc_BlackspiritPass_SetSnapFocus(true)
  end
  local mainText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON")
  local descText = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTREWARD_SIMPLE_TOOLTIP_COMPLETE_SEASON_DESC")
  local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(listIdx)
  if nil == content then
    return
  end
  local control
  if false == isPremium then
    control = UI.getChildControl(content, "Static_NormalSlotBG")
  else
    local premiumBack = UI.getChildControl(content, "Static_PremiumBackground")
    control = UI.getChildControl(premiumBack, "Static_PremiumSlotBG")
  end
  if isSeasonCoupon == true then
    local slotIcon = UI.getChildControl(control, "Static_Slot")
    TooltipSimple_Show(control, mainText, descText, slotIcon)
  else
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if itemSSW == nil then
      return
    end
    if _ContentsGroup_RenewUI == false then
      Panel_Tooltip_Item_Show(itemSSW, control, true)
    else
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    end
  end
end
function HandleEventOnOut_BlackspiritPass_RefreshKeyGuide(listIndex)
  local self = PaGlobal_BlackspiritPass
  if self == nil or listIndex == nil then
    return
  end
  local content = self._ui._list_quest:GetContentByKey(listIndex)
  if content == nil then
    return
  end
  local questBG = UI.getChildControl(content, "Static_QuestBG")
  local btn_Way = UI.getChildControl(questBG, "Button_Waypoint")
  local mode = 0
  if btn_Way:GetShow() == true then
    mode = 1
  end
  self:setKeyGuideAlign(mode)
end
function HandleEventLUp_BlackspiritPass_GetRewardItem(listIdx, isPremium)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local questType
  if false == isPremium then
    questType = __eSeasonPassQuest_Normal
  else
    questType = __eSeasonPassQuest_SeasonPass
  end
  ToClient_RequestCompleteSeasonPassQuest(listIdx, questType)
end
function HandleEventLUp_BlackspiritPass_AlreadyGetReward()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_ALREADY_GET_REWARD")
  Proc_ShowMessage_Ack(msg)
end
function HandleEventLUp_BlackspiritPass_ShowEasyPayment()
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  if false == isGameServiceTypeConsole() then
    PaGlobalFunc_EasyBuy_Open(80)
  else
    PaGlobalFunc_SeasonPassAndRoadMap_Close(true)
    HandleEventLUp_MenuRemake_CashShop()
  end
end
function HandleEventLUp_BlackspiritPass_ToggleShowRoadMap()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  if _ContentsGroup_UseBeginnerRoadMap == false then
    return
  end
  local isCheck = PaGlobal_BlackspiritPass._ui._btn_toggleShowRoadMap:IsCheck()
  if PaGlobal_BlackspiritPass._isConsole == true then
    PaGlobal_BlackspiritPass._ui._btn_toggleShowRoadMap:SetCheck(not isCheck)
    isCheck = PaGlobal_BlackspiritPass._ui._btn_toggleShowRoadMap:IsCheck()
  end
  if isCheck == true then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eShowBeginnerRoadMapUI, 1, CppEnums.VariableStorageType.eVariableStorageType_User)
    PaGlobalFunc_BeginnerRoadMap_Open(false)
  else
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eShowBeginnerRoadMapUI, 2, CppEnums.VariableStorageType.eVariableStorageType_User)
    PaGlobalFunc_BeginnerRoadMap_Close()
  end
end
function HandleEventLUp_BlackspiritPass_ShowSeasonPassGuideNote()
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  Panel_WebHelper_ShowToggle("SeasonPassGuide")
end
function FromClient_BlackspiritPass_ResizePanel()
  local panel = Panel_Window_BeginnerRoadmap
  if panel == nil then
    return
  end
  local self = PaGlobal_BlackspiritPass
  if self == nil then
    return
  end
  local totalSizeY = panel:GetSizeY()
  self._ui._stc_blackSpiritPassMain:SetSize(self._ui._stc_blackSpiritPassMain:GetSizeX(), totalSizeY)
  self._ui._stc_blackSpiritPassMain:ComputePosAllChild()
  local bannerBgSizeY = self._ui._stc_banner:GetSizeY()
  local subTitleBgSizeY = self._ui._stc_subTitleArea:GetSizeY()
  if self._ui._txt_bottomDesc:GetSizeY() < self._ui._txt_bottomDesc:GetTextSizeY() then
    self._ui._txt_bottomDesc:SetSize(self._ui._txt_bottomDesc:GetSizeX(), self._ui._txt_bottomDesc:GetTextSizeY())
    self._ui._stc_bottomDescBg:SetSize(self._ui._stc_bottomDescBg:GetSizeX(), self._ui._txt_bottomDesc:GetSizeY())
  end
  local bottomDescBgSizeY = self._ui._stc_bottomDescBg:GetSizeY() + self._ui._stc_bottomDescBg:GetSpanSize().y
  local newListSizeY = totalSizeY - bannerBgSizeY - subTitleBgSizeY - bottomDescBgSizeY - 10
  self._ui._list_quest:SetSize(self._ui._list_quest:GetSizeX(), newListSizeY)
  self._ui._list_quest:SetEnableArea(0, 0, self._ui._list_quest:GetSizeX(), self._ui._list_quest:GetSizeY())
  self._ui._list_quest:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list_quest:ComputePosAllChild()
  self._ui._stc_graduation:SetSize(self._ui._stc_graduation:GetSizeX(), self._ui._list_quest:GetSizeY() + subTitleBgSizeY + 10)
  self._ui._stc_graduation:ComputePosAllChild()
  self._ui._stc_lockBG:SetSize(self._ui._stc_lockBG:GetSizeX(), newListSizeY - 5)
  self._ui._stc_lockEffect:SetSize(self._ui._stc_lockEffect:GetSizeX(), newListSizeY - 5)
  PaGlobal_BlackspiritPass:updateQuestListControl()
end
function FromClient_BlackspiritPass_UpdateSeasonPassQuest(questNoRaw)
  if Panel_Window_BeginnerRoadmap == nil then
    return
  end
  local self = PaGlobal_BlackspiritPass
  if self == nil then
    return
  end
  local questWrapper = questList_getQuestInfo(questNoRaw)
  if questWrapper ~= nil then
    local questNo = questWrapper:getQuestNo()
    local listIdx, isPremium = self:getListIndex(questNo)
    if listIdx ~= -1 then
      self:updateQuestInfo(listIdx)
      local content = self._ui._list_quest:GetContentByKey(listIdx)
      if content ~= nil then
        local key = toInt64(0, listIdx)
        self:updateListContent(content, key)
      end
    end
    local state = self:getQuestState(questNo)
    if self._normalQuestIdx == questNo._quest % 2 then
      local demand
      local questInfo = ToClient_GetQuestInfo(questNo._group, questNo._quest)
      if questInfo ~= nil then
        demand = questInfo:getDemandAt(0)
      else
        local questStaticInfo = questList_getQuestStatic(questNo._group, questNo._quest)
        demand = questStaticInfo:getDemandAt(0)
      end
      if demand ~= nil then
        AcquireQuestDirect_UpdateQuestDemand(nil, demand, true)
      end
      if self._state.clear == state then
        if listIdx >= 3 then
          local moveIndex = listIdx - 2
          PaGlobal_BlackspiritPass_OpenToIndex(listIdx, moveIndex)
        else
          PaGlobal_BlackspiritPass_OpenToIndex(listIdx)
        end
      end
    end
  end
  if _ContentsGroup_RenewUI == false then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
end
function FromClient_BlackspiritPass_NotifyGetSeasonPass(isSuccess)
  if nil == Panel_Window_BeginnerRoadmap then
    return
  end
  PaGlobal_BlackspiritPass:updateSeasonPassLockState()
  PaGlobal_BlackspiritPass:updateTotalQuestInfo()
  PaGlobal_BlackspiritPass:updateQuestListControl()
  PaGlobal_BlackspiritPass._ui._txt_blackSpiritBuyDesc:SetShow(PaGlobal_BlackspiritPass._hasSeasonPass == false)
  PaGlobal_BlackspiritPass._ui._stc_graduation:SetShow(false)
  PaGlobal_BlackspiritPass._ui._list_quest:SetShow(true)
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_Widget_FunctionButton_HandleUpdate(Widget_Function_Type.BlackSpiritPass)
  end
end
function FromClient_BlackspiritPass_EventQuestUpdateNotify(isAccept, questNoRaw)
  if true == isAccept then
    return
  end
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  local questWrapper = questList_getQuestInfo(questNoRaw)
  if questWrapper ~= nil then
    local questNo = questWrapper:getQuestNo()
    local listIdx, isPremium = PaGlobal_BlackspiritPass:getListIndex(questNo)
    if listIdx == -1 then
      return
    end
    PaGlobal_BlackspiritPass:updateGetRewardItem(listIdx, isPremium)
    if ToClient_isAllClearSeasonPass() == true then
      HandleEventOnOut_BlackspiritPass_ShowItemTooltip(false, -1, false, -1)
      PaGlobal_BlackspiritPass._ui._stc_graduation:SetShow(true)
      PaGlobal_BlackspiritPass._ui._list_quest:SetShow(false)
    end
  end
end
function PaGlobal_BlackspiritPass_GetChangedQuestDescription(questNo)
  if nil == PaGlobal_BlackspiritPass then
    return
  end
  local self = PaGlobal_BlackspiritPass
  local index = self:getListIndex(questNo)
  if -1 == index then
    return ""
  end
  return self._questInfo[index].desc
end
function FromClient_BlackSpiritPass_QuestBackEndLoadComplete(s32_questNoRaw)
  if Panel_Window_BeginnerRoadmap == nil or _ContentsGroup_QuestBackEndLoading == false then
    return
  end
  if Panel_Window_BeginnerRoadmap:GetShow() == false then
    return
  end
  if PaGlobal_BlackspiritPass:isExistLoadingDataAnyOne() == false then
    return
  end
  local updateTargetListIndex = -1
  for index = 1, #PaGlobal_BlackspiritPass._questLoadingDataList do
    local value = PaGlobal_BlackspiritPass._questLoadingDataList[index]
    if value ~= nil then
      if value._questNoRaw[__eSeasonPassQuest_Normal] == s32_questNoRaw then
        value._questNoRaw[__eSeasonPassQuest_Normal] = nil
      elseif value._questNoRaw[__eSeasonPassQuest_SeasonPass] == s32_questNoRaw then
        value._questNoRaw[__eSeasonPassQuest_SeasonPass] = nil
      end
      if value._questNoRaw[__eSeasonPassQuest_Normal] == nil and value._questNoRaw[__eSeasonPassQuest_SeasonPass] == nil then
        updateTargetListIndex = value._questIndex
        table.remove(PaGlobal_BlackspiritPass._questLoadingDataList, index)
        break
      end
    end
  end
  if updateTargetListIndex ~= -1 then
    PaGlobal_BlackspiritPass:updateQuestInfo(updateTargetListIndex)
    local contentKey = PaGlobal_BlackspiritPass._ui._list_quest:getKeyByIndex(updateTargetListIndex)
    local content = PaGlobal_BlackspiritPass._ui._list_quest:GetContentByKey(contentKey)
    if content ~= nil then
      PaGlobal_BlackspiritPass:updateListContent(content, contentKey)
    end
  end
end
function HandleEventLUp_BlackspiritPass_Graduate()
  ToClient_ReqSeasonGraduateByUser(0)
end
function HandleEventOn_BlackspiritPass_ChangeForceGraduateDesc(isOn)
  if isOn == true then
    PaGlobal_BlackspiritPass._ui._txt_ForceGraduate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONPASS_BOTTOM_DESC_STOPSEASON_ON"))
  else
    PaGlobal_BlackspiritPass._ui._txt_ForceGraduate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONPASS_BOTTOM_DESC_STOPSEASON_BASE"))
  end
end
function HandleEventLUp_BlackspiritPass_GraduateForce()
  local doGraduate = function()
    ToClient_ReqSeasonGraduateByUser(2)
  end
  local msgData = {
    confirmText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STOPSEASON_CONFIRM"),
    functionYes = doGraduate,
    functionNo = nil,
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STOPSEASON_DESC"),
    bottomRedDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STOPSEASON_DESC2"),
    isBlockBgShow = true,
    addPanelSizeX = 70,
    varyDescTextControlSizeX = 30,
    isInputEndUseKey = false,
    isUseBottomTextMultiline = false
  }
  PaGlobalFunc_MessageBox_Edit_All_Open(msgData)
end
function HandleEventLUp_BlackSpiritPass_OpenRateViewByLink()
  PaGlobalFunc_Util_OpenRateView(PaGlobalFunc_SeasonPassAndRoadMap_Close)
end
function HandleEventOnOut_BlackSpiritPass_ChangeRateViewButtonText(isOn)
  if isOn == true then
    PaGlobal_BlackspiritPass._ui._txt_RateViewLink:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK_ON"))
  else
    PaGlobal_BlackspiritPass._ui._txt_RateViewLink:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RATEDESC_HERE_CLICK"))
  end
end
function HandleEventLUp_BlackspiritPass_GraduateShow()
  Panel_Season_Graduation_All:SetShow(true)
  Panel_Season_Graduation_All:ComputePos()
end
function HandleEventLUp_BlackspiritPass_GraduateHide()
  Panel_Season_Graduation_All:SetShow(false)
end
function FromClient_SuccessSeasonGraduateAck()
  if _ContentsGroup_RenewUI == false then
    return
  end
  HandleEventLUp_BlackspiritPass_GraduateHide()
  PaGlobal_GameExit_All_GoToCharacterSelectXXX()
end
function HandleEventScroll_BlackspiritPass_GraduateDesc(isUp)
  local self = PaGlobal_BlackspiritPass
  local value = self._scrollValue
  if isUp == false then
    value = -self._scrollValue
  end
  self._scrollPos = self._scrollPos + value
  if self._scrollPos <= 0 then
    self._scrollPos = 0
  elseif self._scrollPos >= self._maxScrollSizeY then
    self._scrollPos = self._maxScrollSizeY
  end
  self._ui._btn_scrollGraduate:SetControlPos(self._scrollPos / self._scrollSizeY * 100)
  self._ui._stc_frameGraduate:UpdateContentPos()
  self._ui._stc_frameGraduate:UpdateContentScroll()
end
