function PaGlobalFunc_MaidList_All_Open()
  PaGlobal_MaidList_All:prepareOpen()
end
function PaGlobalFunc_MaidList_All_Close()
  PaGlobal_MaidList_All:prepareClose()
end
function PadEventRBLB_PaGlobal_MaidList_All_NextTab(val)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil == val then
    _PA_ASSERT_NAME(false, "HandleEventLUp_MaidList_All_Update:\236\158\152\235\170\187\235\144\156 val \234\176\146\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local tabIndexArray = Array.new()
  for ii = 1, PaGlobal_MaidList_All._eTAB_TYPE.COUNT - 1 do
    if PaGlobal_MaidList_All._ui_console.rdo_tabs[ii] ~= nil then
      tabIndexArray:push_back(ii)
    end
  end
  local min = 1
  local max = #tabIndexArray
  local findCurrIdx
  for key, val in pairs(tabIndexArray) do
    if val == PaGlobal_MaidList_All._currentTab then
      findCurIdx = key
      break
    end
  end
  if findCurIdx == nil then
    return
  end
  local nextIdx = findCurIdx + val
  if max < nextIdx then
    nextIdx = min
  elseif min > nextIdx then
    nextIdx = max
  end
  local realIdx = tabIndexArray[nextIdx]
  if realIdx ~= nil then
    _AudioPostEvent_SystemUiForXBOX(51, 6)
    PaGlobal_MaidList_All:setTabTo(realIdx)
  end
end
function HandleEventLUp_MaidList_All_Update(index)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil == index then
    _PA_ASSERT_NAME(false, "HandleEventLUp_MaidList_All_Update:\236\158\152\235\170\187\235\144\156 index \234\176\146\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  PaGlobal_MaidList_All:setTabTo(index)
end
function HandleEventLUp_MaidList_All_RegistMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if PaGlobalFunc_MaidActorRegist_IsShow() == true then
    PaGlobalFunc_MaidActorRegist_Close()
  else
    PaGlobalFunc_MaidActorRegist_Open(PaGlobal_MaidActorRegist._eOpenType.MAID_LIST)
  end
end
function HandleEventLUp_MaidList_All_CustomizeMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if ToClient_IsSummonMaidActor() == true then
    if IngameCustomize_Show() == true then
      HandleClicked_CashCustomization_ChangeMode()
      PaGlobalFunc_MaidList_All_Close()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindSummonMaidActor"))
    return
  end
end
function HandleEventLUp_MaidList_All_ListMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if PaGlobalFunc_MaidActorList_IsShow() == true then
    PaGlobalFunc_MaidActorList_Close()
  else
    TooltipSimple_Hide()
    PaGlobalFunc_MaidActorList_Open()
  end
end
function HandleEventLUp_MaidList_All_DyeMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if ToClient_IsSummonMaidActor() == true then
    local isOpenComplete = false
    if _ContentsGroup_RenewUI_Dyeing == true then
      if _ContentsGroup_NewUI_Dye_All == true then
        isOpenComplete = PaGlobal_Dye_All_Open()
        if isOpenComplete == true then
          InputMLUp_Dye_SelectCharacterType(PaGlobal_Dye_All._enumCharacterType.MaidActor)
        end
      else
        isOpenComplete = PaGlobalFunc_Dyeing_Open()
      end
    elseif _ContentsGroup_NewUI_Dye_All == true then
      isOpenComplete = PaGlobal_Dye_All_Open()
      if isOpenComplete == true then
        InputMLUp_Dye_SelectCharacterType(PaGlobal_Dye_All._enumCharacterType.MaidActor)
      end
    else
      isOpenComplete = FGlobal_Panel_Dye_ReNew_Open()
    end
    if isOpenComplete == true then
      audioPostEvent_SystemUi(1, 24)
      _AudioPostEvent_SystemUiForXBOX(1, 24)
      PaGlobalFunc_MaidList_All_Close()
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindSummonMaidActor"))
    return
  end
end
function HandleEventLUp_MaidList_All_SocialActionMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if ToClient_IsSummonMaidActor() == true then
    FGlobal_SocialAction_ShowToggle()
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindSummonMaidActor"))
    return
  end
end
function HandleEventLUp_MaidList_All_OnClickedMaidActorOutfitOption(type)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if type == 1 then
    ToClient_SetMaidActorUnderwearOrSwimmingSuitMode(self._ui.chk_maidActor_underwearIndivisual:IsCheck())
  elseif type == 2 then
    ToClient_SetMaidActorHideHelm(self._ui.chk_maidActor_helmIndivisual:IsCheck())
  elseif type == 3 then
    ToClient_SetMaidActorShowBattleHelm(self._ui.chk_maidActor_helmOpen:IsCheck())
  elseif type == 4 then
    ToClient_SetMaidActorHideCloak(self._ui.chk_maidActor_cloakIndivisual:IsCheck())
  elseif type == 5 then
    ToClient_SetMaidActorHideSubWeapon(self._ui.chk_maidActor_subWeaponIndivisual:IsCheck())
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\160\129\236\157\184 type\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self:updateMaidActorRenderFlagButton(type)
end
function HandleEventLUp_MaidList_All_ToggleSummonMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if ToClient_IsSummonMaidActor() == true then
    ToClient_RequestUnsummonHeadMaidActor()
    TooltipSimple_Hide()
  else
    ToClient_RequestSummonHeadMaidActor(__eMaidActorAiValue_Direct)
  end
end
function HandleEventOnOut_MaidList_All_SimpleTooltip(isShow, tipType)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control, name, desc
  if tipType == 0 then
    control = self._ui_pc.btn_warehouse
    name = PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU10")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_OPENWAREHOUSEBYMAID_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  elseif tipType == 1 then
    control = self._ui_pc.btn_market
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_MAID_MARKETOPENBYMAID_BUTTON_TOOLTIP")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_OPENMARKETBYMAID_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  elseif tipType == 2 then
    control = self._ui_pc.btn_marketPlace
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_MARKETPLACE_OPEN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MARKETPLACE_WALLETINVENTORY_SELLTOOLTIPDESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  elseif tipType == 3 then
    control = self._ui_pc.btn_pcRoom
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_REGISTEPCROOMMAIDBUTTON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MAIDLIST_ALL_PCROOM_REGISTER_DESC")
  elseif tipType == 4 then
    if self._ui.chk_UseMultiMaid ~= nil and self._ui.chk_UseMultiMaid:GetShow() == true then
      control = self._ui.chk_UseMultiMaid
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_SETMAX")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDORDER_GROUP_DESC")
    end
  elseif tipType == 5 then
    if self._ui.chk_UseMaidActor ~= nil and self._ui.chk_UseMaidActor:GetShow() == true then
      control = self._ui.chk_UseMaidActor
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_USE_MAIDACTOR_BUTTON_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_USE_MAIDACTOR_BUTTON_DESC")
    end
  elseif tipType == 6 then
    control = self._ui.btn_maidActor_regist
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_REGIST_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_REGIST_DESC")
  elseif tipType == 7 then
    control = self._ui.btn_maidActor_customize
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_CUSTOMIZE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_CUSTOMIZE_DESC")
  elseif tipType == 8 then
    control = self._ui_pc.btn_maidActorManagement
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_LIST_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_LIST_DESC")
  elseif tipType == 9 then
    control = self._ui.btn_maidActor_dye
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_DYE_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_DYE_DESC")
  elseif tipType == 10 then
    control = self._ui.btn_maidActor_action
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_SOCIALACTION_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_SOCIALACTION_DESC")
  elseif tipType == 11 then
    control = UI.getChildControl(self._ui.chk_maidActor_underwearIndivisual, "Static_Icon")
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_UNDERWEAR_INDIVISUAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_UNDERWEAR_INDIVISUAL_DESC")
  elseif tipType == 12 then
    control = UI.getChildControl(self._ui.chk_maidActor_helmIndivisual, "Static_Icon")
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_HELM_INDIVISUAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_HELM_INDIVISUAL_DESC")
  elseif tipType == 13 then
    control = UI.getChildControl(self._ui.chk_maidActor_helmOpen, "Static_Icon")
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_HELM_OPEN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_HELM_OPEN_DESC")
  elseif tipType == 14 then
    control = UI.getChildControl(self._ui.chk_maidActor_cloakIndivisual, "Static_Icon")
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_CLOAK_INDIVISUAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_CLOAK_INDIVISUAL_DESC")
  elseif tipType == 15 then
    control = UI.getChildControl(self._ui.chk_maidActor_subWeaponIndivisual, "Static_Icon")
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_SUBWEAPON_INDIVISUAL_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_SUBWEAPON_INDIVISUAL_DESC")
  elseif tipType == 16 then
    if self._ui.chk_FollowMaidActor ~= nil and self._ui.chk_FollowMaidActor:GetShow() == true then
      control = self._ui.chk_FollowMaidActor
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_FOLLOW_MAIDACTOR_BUTTON_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_FOLLOW_MAIDACTOR_BUTTON_DESC")
    end
  elseif tipType == 17 then
    control = self._ui.stc_maidActor_guideIcon
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_EQUIP_GUIDE_MAIDACTOR_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_EQUIP_GUIDE_MAIDACTOR_DESC")
  elseif tipType == 18 then
    control = self._ui_pc.btn_summonMaidActor
    if ToClient_IsSummonMaidActor() == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_UNSUMMON_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_UNSUMMON_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_SUMMON_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_CUSTOM_BTN_SUMMON_DESC")
    end
  end
  if control ~= nil then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventLUp_MaidList_All_ClickPcRoomBtn()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_MAIDLIST_ALL_PCROOM_MESSAGEBOX_DESC"),
    functionYes = HandleEventLUp_MaidList_All_RegistPCRoomMaid,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLUp_MaidList_All_RegistPCRoomMaid()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  ToClient_RegistPcRoomMaid()
  self._ui_pc.btn_pcRoom:SetShow(false)
  self:updateCheckBoxButtonShowState()
end
function HandleEventLDown_MaidList_All_ScaleResizeStart()
  PaGlobal_MaidList_All._panelOpenPosX = Panel_Window_MaidList_All:GetPosX()
  PaGlobal_MaidList_All._panelOpenPosY = Panel_Window_MaidList_All:GetPosY()
  UI.PanelDynamicSacle_ResizeStart(Panel_Window_MaidList_All)
end
function HandleEventLPress_MaidList_All_ScaleResizing()
  UI.PanelDynamicSacle_ResizePressing(Panel_Window_MaidList_All)
  PaGlobal_MaidList_All:setTabTo(PaGlobal_MaidList_All._currentTab)
  PaGlobal_MaidList_All._ui.list2_maid:requestUpdateVisible()
  Panel_Window_MaidList_All:SetPosX(PaGlobal_MaidList_All._panelOpenPosX)
  Panel_Window_MaidList_All:SetPosY(PaGlobal_MaidList_All._panelOpenPosY)
end
function HandleEventLUp_MaidList_All_ScaleResizeEnd()
  UI.PanelDynamicSacle_ResizeEnd(Panel_Window_MaidList_All)
end
function HandleEventOnOut_MaidList_All_EmptySlotTooltip(slotNo, isOn)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if isOn == false then
    TooltipSimple_Hide()
    return
  end
  local control
  local slot = self.slots[slotNo]
  if slot ~= nil then
    control = slot.icon
  end
  if control ~= nil then
    TooltipSimple_Show(control, "", self._slotNoIdToString[slotNo])
  end
end
function HandleEventOnOut_MaidList_All_EquipmentTooltip(slotNo, isOn)
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "maidEquipment", isOn, false, nil, nil, Panel_Window_MaidList_All, 2, 50)
end
function HandleEventRUp_MaidList_All_EquipSlotRClick(slotNo)
  local itemWrapper = ToClient_getMaidActorEquipmentItem(slotNo)
  if itemWrapper ~= nil then
    TooltipSimple_Hide()
    Panel_Tooltip_Item_hideTooltip()
    ToClient_requestUnequipFromMaidActor(slotNo)
  end
end
function HandleEventRUp_MaidList_All_ShowMaidActorEquipGuideWebUI()
  Panel_WebHelper_ShowToggle("MaidActor")
end
function onScreenResize_MaidList_All_Resize()
  PaGlobal_MaidList_All:resize()
end
function FromClient_RefreshMaidList_MaidList_All()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if self._currentTab == self._eTAB_TYPE.MAIDACTOR then
    self:updateLeftMaidCountText()
  else
    self:updateData(self._currentTab)
    self:pushDataToList()
  end
end
function FromClient_MaidList_All_RefreshPcRoomState()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if self._isConsole == true then
    return
  end
  self._ui_pc.btn_pcRoom:SetShow(ToClient_isShowRegistPcRoomMaidButton())
  self:updateCheckBoxButtonShowState()
end
function FromClient_MaidList_All_MaidActorEvent(eventType)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if _ContentsGroup_MaidActorSystem == false then
    return
  end
  if eventType == __eMaidActorEventType_Load then
    self:LogInMaidShow()
  elseif eventType == __eMaidActorEventType_Regist or eventType == __eMaidActorEventType_Unregist then
    if self._currentTab == self._eTAB_TYPE.MAIDACTOR then
      self:setTabTo(self._eTAB_TYPE.MAIDACTOR)
    end
  elseif (eventType == __eMaidActorEventType_ChangeHead or eventType == __eMaidActorEventType_ChangeName) and self._currentTab == self._eTAB_TYPE.MAIDACTOR then
    self:updateMaidActorData()
  end
end
function FromClient_MaidList_All_SummonMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if self._currentTab ~= self._eTAB_TYPE.MAIDACTOR then
    return
  end
  self:consoleKeyGuideSet(true, true, true)
  self:updateMaidActorSlotData()
  self:updateMaidActorRenderFlagButton(nil)
end
function FromClient_MaidList_All_UnsummonMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if self._currentTab ~= self._eTAB_TYPE.MAIDACTOR then
    return
  end
  self:consoleKeyGuideSet(true, true, true)
  self:updateMaidActorSlotData()
end
function FromClient_MaidList_All_EquipItemToMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if self._currentTab ~= self._eTAB_TYPE.MAIDACTOR then
    return
  end
  self:updateMaidActorSlotData()
  self:updateMaidActorRenderFlagButton(nil)
end
function FromClient_MaidList_All_UnequipItemFromMaidActor()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if self._currentTab ~= self._eTAB_TYPE.MAIDACTOR then
    return
  end
  self:updateMaidActorSlotData()
  self:updateMaidActorRenderFlagButton(nil)
end
function FromClient_MaidList_All_ChangeMaidActorFollowMode()
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  local maidActorFollowModeValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMaidActorFollowMode)
  self._ui.chk_FollowMaidActor:SetCheck(maidActorFollowModeValue < 2)
end
function PaGlobalFunc_MaidList_All_IsCheckedUseMultiMaid(isMarket)
  if nil == Panel_Window_MaidList_All then
    return
  end
  return PaGlobal_MaidList_All:isCheckMaidChief(isMarket)
end
function HandleEventLUp_MaidList_All_UseMultiMaidClick(isPadMode)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if isPadMode == true then
    self._ui.chk_UseMultiMaid:SetCheck(self._ui.chk_UseMultiMaid:IsCheck() == false)
  end
  local isUseMultiMaid = self._ui.chk_UseMultiMaid:IsCheck()
  local isUseMaidActor = self._ui.chk_UseMaidActor:IsCheck()
  local isMaidActorFollowMode = self._ui.chk_FollowMaidActor:IsCheck()
  self:keyGuideAlign(isUseMultiMaid, isUseMaidActor, isMaidActorFollowMode)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMultiMaid, isUseMultiMaid, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function HandleEventLUp_MaidList_All_UseMaidActorClick(isPadMode)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if isPadMode == true then
    self._ui.chk_UseMaidActor:SetCheck(self._ui.chk_UseMaidActor:IsCheck() == false)
  end
  local isUseMultiMaid = self._ui.chk_UseMultiMaid:IsCheck()
  local isUseMaidActor = self._ui.chk_UseMaidActor:IsCheck()
  local isMaidActorFollowMode = self._ui.chk_FollowMaidActor:IsCheck()
  self:keyGuideAlign(isUseMultiMaid, isUseMaidActor, isMaidActorFollowMode)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMyCustomMaidActor, isUseMaidActor, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function HandleEventLUp_MaidList_All_ChangeMaidActorFollowMode(isPadMode)
  local self = PaGlobal_MaidList_All
  if self == nil then
    return
  end
  if isPadMode == true then
    self._ui.chk_FollowMaidActor:SetCheck(self._ui.chk_FollowMaidActor:IsCheck() == false)
  end
  local isUseMultiMaid = self._ui.chk_UseMultiMaid:IsCheck()
  local isUseMaidActor = self._ui.chk_UseMaidActor:IsCheck()
  local isMaidActorFollowMode = self._ui.chk_FollowMaidActor:IsCheck()
  self:keyGuideAlign(isUseMultiMaid, isUseMaidActor, isMaidActorFollowMode)
  ToClient_RequestMaidActorFollowMode(isMaidActorFollowMode)
end
function PaGlobal_MaidList_All_resettingInvenFunc()
  if false == _ContentsGroup_UsePadSnapping and Panel_Window_Inventory_All ~= nil and Panel_Window_Inventory_All:GetShow() == true then
    if Panel_Window_ShipInfo_Renewal_All ~= nil and Panel_Window_ShipInfo_Renewal_All:GetShow() == true then
      Inventory_SetFunctor(PaGlobal_ShipInfo_Renewal_All_BasicItemFilter, PaGlobal_ShipInfo_Renewal_All_Inventory_SetFunctor, nil, nil)
    elseif Panel_Window_ShipInfo_All ~= nil and Panel_Window_ShipInfo_All:GetShow() == true then
      Inventory_SetFunctor(PaGlobal_ShipInfo_All_BasicItemFilter, PaGlobal_ShipInfo_All_Inventory_SetFunctor, nil, nil)
    end
  end
end
