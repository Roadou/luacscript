function PaGlobal_MaidList_All:initialize()
  if true == PaGlobal_MaidList_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:initMaidActorEquipSlot()
  self._ui.list2_maid:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_MaidList_All_ListControlCreate")
  self._ui.list2_maid:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    Panel_MyHouseNavi_Update(true)
    if _ContentsGroup_MaidActorSystem == false then
      self:LogInMaidShow()
    end
  end
  self:resize()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MaidList_All:controlAll_Init()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._panelOriginSizeY = Panel_Window_MaidList_All:GetSizeY()
  self._ui.stc_title = UI.getChildControl(Panel_Window_MaidList_All, "Static_MainTitleBar")
  self._ui.txt_noMaidFound = UI.getChildControl(Panel_Window_MaidList_All, "StaticText_NoMaidFound")
  self._ui.stc_countArea = UI.getChildControl(Panel_Window_MaidList_All, "Static_BottomArea")
  self._ui.stc_whareHouse = UI.getChildControl(self._ui.stc_countArea, "Static_Left")
  self._ui.txt_whareHouseCount = UI.getChildControl(self._ui.stc_whareHouse, "StaticText_Count")
  self._ui.stc_itemMarket = UI.getChildControl(self._ui.stc_countArea, "Static_Right")
  self._ui.txt_itemMarketCount = UI.getChildControl(self._ui.stc_itemMarket, "StaticText_Count")
  self._ui.txt_maidCount = UI.getChildControl(Panel_Window_MaidList_All, "StaticText_LeftMaidCount")
  self._ui.txt_maidCountValue = UI.getChildControl(Panel_Window_MaidList_All, "StaticText_LeftMaidCountValue")
  self._ui.stc_maidListTopBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_MaidListContentBG")
  self._ui.list2_maid = UI.getChildControl(Panel_Window_MaidList_All, "List2_Maid")
  self._ui.stc_listBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_ListBg")
  self._ui.stc_tabBar = UI.getChildControl(Panel_Window_MaidList_All, "Static_TapBtmBar")
  self._ui.stc_tabBarLine = UI.getChildControl(Panel_Window_MaidList_All, "Static_TabBtmLine")
  self._ui.stc_tabBar:SetShow(true)
  self._ui.stc_tabBarLine:SetShow(true)
  self._ui.chk_UseMultiMaid = UI.getChildControl(Panel_Window_MaidList_All, "Checkbox_SetMax")
  self._ui.txt_UseMultiMaid = UI.getChildControl(self._ui.chk_UseMultiMaid, "StaticText_SetMax")
  self._ui.chk_UseMaidActor = UI.getChildControl(Panel_Window_MaidList_All, "CheckButton_Apply_Custom_Maid")
  self._ui.chk_FollowMaidActor = UI.getChildControl(Panel_Window_MaidList_All, "CheckButton_Apply_Follow_Maid")
  if self._isConsole == true then
    self._ui.stc_countArea:SetSize(460, 50)
    self._ui.stc_whareHouse:SetSize(225, 50)
    self._ui.stc_itemMarket:SetSize(225, 50)
    self._ui.stc_countArea:SetHorizonRight()
    self._ui.stc_countArea:SetVerticalBottom()
    self._ui.stc_countArea:SetSpanSize(10, 60)
    self._ui.stc_countArea:ComputePosAllChild()
    self._ui.chk_UseMultiMaid:SetHorizonLeft()
    self._ui.chk_UseMultiMaid:SetVerticalBottom()
    self._ui.chk_UseMultiMaid:SetSpanSize(self._ui.chk_UseMultiMaid:GetSpanSize().x, 75)
    self._ui.chk_UseMultiMaid:ComputePos()
    self._ui.chk_UseMaidActor:SetHorizonLeft()
    self._ui.chk_UseMaidActor:SetVerticalBottom()
    self._ui.chk_UseMaidActor:SetSpanSize(self._ui.chk_UseMaidActor:GetSpanSize().x, 65)
    self._ui.chk_UseMaidActor:ComputePos()
    self._ui.chk_FollowMaidActor:SetHorizonLeft()
    self._ui.chk_FollowMaidActor:SetVerticalBottom()
    self._ui.chk_FollowMaidActor:SetSpanSize(self._ui.chk_FollowMaidActor:GetSpanSize().x, 90)
    self._ui.chk_FollowMaidActor:ComputePos()
  else
    self._ui.stc_countArea:SetSize(695, 50)
    self._ui.stc_whareHouse:SetSize(345, 50)
    self._ui.stc_itemMarket:SetSize(345, 50)
    self._ui.stc_countArea:SetHorizonCenter()
    self._ui.stc_countArea:SetVerticalBottom()
    self._ui.stc_countArea:SetSpanSize(0, 60)
    self._ui.stc_countArea:ComputePosAllChild()
  end
  self._ui.txt_UseMultiMaid:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_UseMultiMaid:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_SETMAX"))
  if true == _ContentsGroup_UseMultiMaid then
    local isMaidCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMultiMaid, true, CppEnums.VariableStorageType.eVariableStorageType_User)
    self._ui.chk_UseMultiMaid:SetCheck(isMaidCheck)
  end
  if _ContentsGroup_MaidActorSystem == true then
    local isUseMaidActor = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMyCustomMaidActor, true, CppEnums.VariableStorageType.eVariableStorageType_User)
    self._ui.chk_UseMaidActor:SetCheck(isUseMaidActor)
    local maidActorFollowModeValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMaidActorFollowMode)
    self._ui.chk_FollowMaidActor:SetCheck(maidActorFollowModeValue < 2)
  end
  self._ui.stc_maidActor_buttonBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_Custom_Setting_Button_BG")
  self._ui.stc_maidActor_leftBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_Custom_Maid_BG1")
  self._ui.stc_maidActor_rightBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_Custom_Maid_BG2")
  self._ui.stc_maidActor_photoEmpty = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Static_Custom_Maid_Empty_Profile")
  self._ui.stc_maidActor_photo = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Static_MaidPhoto")
  self._ui.txt_maidActor_name = UI.getChildControl(self._ui.stc_maidActor_photo, "StaticText_MaidName")
  UI.setLimitTextAndAddTooltip(self._ui.txt_maidActor_name)
  self._ui.btn_maidActor_regist = UI.getChildControl(self._ui.stc_maidActor_buttonBg, "Button_Custom_Setting")
  self._ui.btn_maidActor_customize = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Button_Customize")
  self._ui.btn_maidActor_dye = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Button_Dye")
  self._ui.btn_maidActor_action = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Button_SocialAction")
  self._ui.chk_maidActor_underwearIndivisual = UI.getChildControl(self._ui.stc_maidActor_rightBg, "CheckButton_Maid_Underwear_Invisual")
  self._ui.chk_maidActor_helmIndivisual = UI.getChildControl(self._ui.stc_maidActor_rightBg, "CheckButton_Maid_Helm_Invisual")
  self._ui.chk_maidActor_helmOpen = UI.getChildControl(self._ui.stc_maidActor_rightBg, "CheckButton_Maid_HelmOpen")
  self._ui.chk_maidActor_cloakIndivisual = UI.getChildControl(self._ui.stc_maidActor_rightBg, "CheckButton_Maid_Cloak_Invisual")
  self._ui.chk_maidActor_subWeaponIndivisual = UI.getChildControl(self._ui.stc_maidActor_rightBg, "CheckButton_Maid_SubWeapon_Invisual")
  self._ui.stc_maidActor_equipHide = UI.getChildControl(self._ui.stc_maidActor_rightBg, "Static_Custom_Maid_BG2_Empty")
  self._ui.stc_maidActor_guideIcon = UI.getChildControl(self._ui.stc_maidActor_rightBg, "Static_MaidActor_GuideIcon")
end
function PaGlobal_MaidList_All:controlPc_Init()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_title, "Button_Close_PCUI")
  self._ui_pc.stc_tabBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_TapBg_PCUI")
  self._ui_pc.btn_radios[self._eTAB_TYPE.ALL] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_All")
  self._ui_pc.btn_radios[self._eTAB_TYPE.STORAGE] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_Warehouse")
  if true == _ContentsGroup_ItemMarketKor2 then
    self._ui_pc.btn_radios[self._eTAB_TYPE.MARKETPLACE] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_Itemmarket")
  end
  UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_Itemmarket"):SetShow(_ContentsGroup_ItemMarketKor2)
  if _ContentsGroup_MaidActorSystem == true then
    self._ui_pc.btn_radios[self._eTAB_TYPE.MAIDACTOR] = UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_MaidActor")
  end
  UI.getChildControl(self._ui_pc.stc_tabBg, "RadioButton_MaidActor"):SetShow(_ContentsGroup_MaidActorSystem)
  self._ui_pc.btn_warehouse = UI.getChildControl(Panel_Window_MaidList_All, "Button_SummonMaid_Warehouse_PCUI")
  self._ui_pc.btn_market = UI.getChildControl(Panel_Window_MaidList_All, "Button_SummonMaid_Market_PCUI")
  self._ui_pc.btn_marketPlace = UI.getChildControl(Panel_Window_MaidList_All, "Button_SummonMaid_MarketPlace_PCUI")
  self._ui_pc.btn_pcRoom = UI.getChildControl(Panel_Window_MaidList_All, "Button_PCRoomRegist_PCUI")
  self._ui_pc.btn_ScaleResize = UI.getChildControl(Panel_Window_MaidList_All, "Button_ScaleResize")
  self._ui_pc.btn_summonMaidActor = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Button_SummonMaidActor_PCUI")
  self._ui_pc.btn_maidActorManagement = UI.getChildControl(self._ui.stc_maidActor_leftBg, "Button_MaidActorManagement_PCUI")
  self._ui_pc.btn_ScaleResize:addInputEvent("Mouse_LDown", "HandleEventLDown_MaidList_All_ScaleResizeStart()")
  self._ui_pc.btn_ScaleResize:addInputEvent("Mouse_LPress", "HandleEventLPress_MaidList_All_ScaleResizing()")
  self._ui_pc.btn_ScaleResize:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ScaleResizeEnd()")
  self._ui_pc.btn_ScaleResize:SetShow(true)
  self._ui_pc.btn_ScaleResize:SetChildIndex(Panel_Window_MaidList_All, 9999)
  self._ui_pc.btn_warehouse:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_warehouse:SetText(self._ui_pc.btn_warehouse:GetText())
  self._ui_pc.btn_market:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_market:SetText(self._ui_pc.btn_market:GetText())
  self._ui_pc.btn_marketPlace:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_marketPlace:SetText(self._ui_pc.btn_marketPlace:GetText())
  self._ui_pc.btn_pcRoom:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_pcRoom:SetText(self._ui_pc.btn_pcRoom:GetText())
  self._ui_pc.btn_summonMaidActor:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_summonMaidActor:SetText(self._ui_pc.btn_summonMaidActor:GetText())
  self._ui_pc.btn_maidActorManagement:SetTextMode(__eTextMode_AutoWrap)
  self._ui_pc.btn_maidActorManagement:SetText(self._ui_pc.btn_maidActorManagement:GetText())
end
Panel_Window_MaidList_All:setDynamicScalePanelIndex(__eDynamicScalePanel_MaidList)
function PaGlobal_MaidList_All:controlConsole_Init()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui_console.stc_tabBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_TapBg_ConsoleUI")
  self._ui_console.rdo_tabs[self._eTAB_TYPE.ALL] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_All")
  self._ui_console.rdo_tabs[self._eTAB_TYPE.STORAGE] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_Warehouse")
  self._ui_console.rdo_tabs[self._eTAB_TYPE.MARKETPLACE] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_Itemmarket")
  if _ContentsGroup_MaidActorSystem == true then
    self._ui_console.rdo_tabs[self._eTAB_TYPE.MAIDACTOR] = UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_MaidActor")
  end
  UI.getChildControl(self._ui_console.stc_tabBg, "RadioButton_MaidActor"):SetShow(_ContentsGroup_MaidActorSystem)
  self._ui_console.stc_keyGuideLB = UI.getChildControl(self._ui_console.stc_tabBg, "StaticText_KeyGuideLB")
  self._ui_console.stc_keyGuideRB = UI.getChildControl(self._ui_console.stc_tabBg, "StaticText_KeyGuideRB")
  self._ui_console.stc_keyGuideAreaBg = UI.getChildControl(Panel_Window_MaidList_All, "Static_KeyGuideArea_ConsoleUI")
  self._ui_console.stc_guideIconY = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_Y_ConsoleUI")
  self._ui_console.stc_guideIconLS = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_LS_ConsoleUI")
  self._ui_console.stc_guideIconB = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_Close_ConsoleUI")
  self._ui_console.stc_guideIconRS = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "Button_Scroll")
  self._ui_console.stc_guideIconX = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_X_ConsoleUI")
  self._ui_console.stc_guideIconLTX = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_LTX_ConsoleUI")
  self._ui_console.stc_guideIconLTY = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_LTY_ConsoleUI")
  self._ui_console.stc_guideIconRTX = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_RTX_ConsoleUI")
  self._ui_console.stc_guideIconRTY = UI.getChildControl(self._ui_console.stc_keyGuideAreaBg, "StaticText_RTY_ConsoleUI")
  self._ui_console.rdo_tabs[self._eTAB_TYPE.ALL]:SetTextMode(__eTextMode_AutoWrap)
  self._ui_console.rdo_tabs[self._eTAB_TYPE.STORAGE]:SetTextMode(__eTextMode_AutoWrap)
  self._ui_console.rdo_tabs[self._eTAB_TYPE.MARKETPLACE]:SetTextMode(__eTextMode_AutoWrap)
  if _ContentsGroup_MaidActorSystem == true then
    self._ui_console.rdo_tabs[self._eTAB_TYPE.MAIDACTOR]:SetTextMode(__eTextMode_AutoWrap)
  end
end
function PaGlobal_MaidList_All:controlSetShow()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if self._isConsole == false then
    self._ui_pc.stc_tabBg:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_warehouse:SetShow(true)
    self._ui_pc.btn_summonMaidActor:SetShow(false)
    self._ui_pc.btn_maidActorManagement:SetShow(false)
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      self._ui_pc.btn_market:SetShow(false)
      self._ui_pc.btn_marketPlace:SetShow(true)
    else
      self._ui_pc.btn_market:SetShow(true)
      self._ui_pc.btn_marketPlace:SetShow(false)
    end
    self._ui_pc.btn_marketPlace:SetShow(_ContentsGroup_ItemMarketKor2)
    if true == _ContentsGroup_KR_Transfer and true == ToClient_isShowRegistPcRoomMaidButton() then
      self._ui_pc.btn_pcRoom:SetShow(true)
    else
      self._ui_pc.btn_pcRoom:SetShow(false)
    end
    self._ui_console.stc_tabBg:SetShow(false)
    self._ui_console.stc_keyGuideAreaBg:SetShow(false)
  else
    self._ui_pc.stc_tabBg:SetShow(false)
    self._ui_console.stc_tabBg:SetShow(true)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_warehouse:SetShow(false)
    self._ui_pc.btn_summonMaidActor:SetShow(false)
    self._ui_pc.btn_maidActorManagement:SetShow(false)
    self._ui_pc.btn_market:SetShow(false)
    self._ui_pc.btn_marketPlace:SetShow(false)
    self._ui_pc.btn_pcRoom:SetShow(false)
    self._ui_pc.btn_ScaleResize:SetShow(false)
    self._ui_console.stc_keyGuideAreaBg:SetShow(true)
  end
end
function PaGlobal_MaidList_All:initMaidActorEquipSlot()
  if Panel_Window_MaidList_All == nil then
    return
  end
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if self:checkMaidUsableSlot(slotNo) == true then
      local slotBG = UI.getChildControl(self._ui.stc_maidActor_rightBg, self._slotNoId[slotNo] .. "_BG")
      slotBG:SetShow(false)
      self.slotBGs[slotNo] = slotBG
      local slot = {}
      slot.icon = UI.getChildControl(self._ui.stc_maidActor_rightBg, self._slotNoId[slotNo])
      SlotItem.new(slot, "Equipment_" .. slotNo, slotNo, Panel_Window_MaidList_All, self._slotConfig)
      slot:createChild()
      if self._isConsole == true then
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_MaidList_All_EquipSlotRClick(" .. slotNo .. ")")
      else
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_MaidList_All_ShowMaidActorEquipGuideWebUI()")
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_MaidList_All_EquipSlotRClick(" .. slotNo .. ")")
      end
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_EquipmentTooltip(" .. slotNo .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_EquipmentTooltip(" .. slotNo .. ",false)")
      Panel_Tooltip_Item_SetPosition(slotNo, slot, "maidEquipment")
      self.slots[slotNo] = slot
      if slotNo == __eEquipSlotNoTemp and _ContentsGroup_TempXXX == false then
        self.slotBGs[slotNo]:SetShow(false)
        self.slots[slotNo].icon:SetShow(false)
      end
      if slotNo == __eEquipSlotNoAvatarUnderwear then
        self._maidActorEquipSlot_UnderWearSpanX = self.slotBGs[slotNo]:GetSpanSize().x
        self._maidActorEquipSlot_UnderWearSpanY = self.slotBGs[slotNo]:GetSpanSize().y
      end
    end
  end
end
function PaGlobal_MaidList_All:resize()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil ~= self._panelOpenPosX and nil ~= self._panelOpenPosY then
    Panel_Window_MaidList_All:SetPosXY(self._panelOpenPosX, self._panelOpenPosY)
  end
  self._ui_pc.btn_warehouse:ComputePos()
  self._ui_pc.btn_market:ComputePos()
  self._ui_pc.btn_marketPlace:ComputePos()
  self._ui_pc.btn_pcRoom:ComputePos()
  self._ui_pc.btn_summonMaidActor:ComputePos()
  self._ui_pc.btn_maidActorManagement:ComputePos()
  self._ui.txt_maidCount:ComputePos()
  self._ui.txt_maidCountValue:ComputePos()
  Panel_Window_MaidList_All:ComputePos()
  if false == self._isConsole then
    local panelPosX = Panel_Widget_ServantIcon:GetPosX() + 250
    local panelPosY = Panel_Widget_ServantIcon:GetPosY() + Panel_Widget_ServantIcon:GetSizeY() + 10
    if getScreenSizeX() < panelPosX + Panel_Window_MaidList_All:GetSizeX() then
      panelPosX = getScreenSizeX() - Panel_Window_MaidList_All:GetSizeX() - 10
    end
    if getScreenSizeY() < panelPosY + Panel_Window_MaidList_All:GetSizeY() then
      panelPosY = Panel_Widget_ServantIcon:GetPosY() - Panel_Window_MaidList_All:GetSizeY() - 10
    end
    Panel_Window_MaidList_All:SetPosXY(panelPosX, panelPosY)
  else
    Panel_Window_MaidList_All:SetSize(Panel_Window_MaidList_All:GetSizeX(), self._panelOriginSizeY - self._ui_pc.btn_warehouse:GetSizeY() - 10)
    self:consoleKeyGuideSet(true, true, false)
    local gapX = (getOriginScreenSizeX() - getScreenSizeX()) * 0.5
    local gapY = (getOriginScreenSizeY() - getScreenSizeY()) * 0.5
    Panel_Window_MaidList_All:SetPosX(Panel_Window_MaidList_All:GetPosX() + gapX)
    Panel_Window_MaidList_All:SetPosY(Panel_Window_MaidList_All:GetPosY() + gapY)
  end
end
function PaGlobal_MaidList_All:consoleKeyGuideSet(showMarket, showStorage, showMaidActor)
  if self._isConsole == false then
    return
  end
  if _ContentsGroup_MaidActorSystem == false then
    showMaidActor = false
  end
  self._ui_console.stc_guideIconRS:SetShow(showMaidActor == false)
  self._ui_console.stc_guideIconLS:SetShow(_ContentsGroup_UseMultiMaid == true and showMaidActor == false)
  if _ContentsGroup_UseMultiMaid == true and showMaidActor == false then
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_MaidList_All_UseMultiMaidClick(true)")
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
  end
  self._ui_console.stc_guideIconB:SetShow(true)
  self._ui_console.stc_guideIconX:SetShow(showMarket)
  if showMarket == true then
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_MaidList_All_SelectMaid(" .. self._eTAB_TYPE.MARKETPLACE .. ")")
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
  self._ui_console.stc_guideIconY:SetShow(showStorage)
  if showStorage == true then
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_MaidList_All_SelectMaid(" .. self._eTAB_TYPE.STORAGE .. ")")
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  self._ui_console.stc_guideIconRTX:SetShow(showMaidActor)
  self._ui_console.stc_guideIconRTY:SetShow(showMaidActor)
  self._ui_console.stc_guideIconLTX:SetShow(showMaidActor)
  self._ui_console.stc_guideIconLTY:SetShow(showMaidActor)
  if showMaidActor == true then
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_MaidList_All_ListMaidActor()")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "HandleEventLUp_MaidList_All_ToggleSummonMaidActor()")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_MaidList_All_ChangeMaidActorFollowMode(true)")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_MaidList_All_UseMaidActorClick(true)")
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
  end
  local isUseMultiMaid = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMultiMaid, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  local useMaidActor = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMyCustomMaidActor, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  local isMaidActorFollowMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMaidActorFollowMode) < 2
  self:keyGuideAlign(isUseMultiMaid, useMaidActor, isMaidActorFollowMode)
end
function PaGlobal_MaidList_All:keyGuideAlign(isUseMultiMaid, useMaidActor, isMaidActorFollowMode)
  if self._isConsole == false then
    return
  end
  if ToClient_IsSummonMaidActor() == true then
    self._ui_console.stc_guideIconRTY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_UNSUMMON"))
  else
    self._ui_console.stc_guideIconRTY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_SUMMON"))
  end
  if _ContentsGroup_UseMultiMaid == true then
    if isUseMultiMaid == true then
      self._ui_console.stc_guideIconLS:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_TOGETHERORDER_UNSET"))
    else
      self._ui_console.stc_guideIconLS:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_TOGETHERORDER_SET"))
    end
  end
  if isMaidActorFollowMode == true then
    self._ui_console.stc_guideIconLTX:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_APPLY_FOLLOWBUTTON_UNSET"))
  else
    self._ui_console.stc_guideIconLTX:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_APPLY_FOLLOWBUTTON"))
  end
  if useMaidActor == true then
    self._ui_console.stc_guideIconLTY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_USEMAIDACTOR_UNSET"))
  else
    self._ui_console.stc_guideIconLTY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MAIDLIST_USEMAIDACTOR_SET"))
  end
  local keyGuideList = Array.new()
  keyGuideList:push_back(self._ui_console.stc_guideIconRTX)
  keyGuideList:push_back(self._ui_console.stc_guideIconRTY)
  keyGuideList:push_back(self._ui_console.stc_guideIconLTX)
  keyGuideList:push_back(self._ui_console.stc_guideIconLTY)
  keyGuideList:push_back(self._ui_console.stc_guideIconRS)
  keyGuideList:push_back(self._ui_console.stc_guideIconLS)
  keyGuideList:push_back(self._ui_console.stc_guideIconX)
  keyGuideList:push_back(self._ui_console.stc_guideIconY)
  keyGuideList:push_back(self._ui_console.stc_guideIconB)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui_console.stc_keyGuideAreaBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_MaidList_All:registEventHandler()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if _ContentsGroup_MaidActorSystem == true then
    self._ui.btn_maidActor_regist:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_RegistMaidActor()")
    self._ui.btn_maidActor_regist:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 6 .. " )")
    self._ui.btn_maidActor_regist:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 6 .. " )")
    self._ui.btn_maidActor_customize:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_CustomizeMaidActor()")
    self._ui.btn_maidActor_customize:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 7 .. " )")
    self._ui.btn_maidActor_customize:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 7 .. " )")
    self._ui.btn_maidActor_dye:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_DyeMaidActor()")
    self._ui.btn_maidActor_dye:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 9 .. " )")
    self._ui.btn_maidActor_dye:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 9 .. " )")
    self._ui.btn_maidActor_action:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_SocialActionMaidActor()")
    self._ui.btn_maidActor_action:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 10 .. " )")
    self._ui.btn_maidActor_action:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 10 .. " )")
    self._ui.chk_maidActor_underwearIndivisual:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_OnClickedMaidActorOutfitOption(" .. 1 .. ")")
    self._ui.chk_maidActor_underwearIndivisual:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 11 .. " )")
    self._ui.chk_maidActor_underwearIndivisual:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 11 .. " )")
    self._ui.chk_maidActor_helmIndivisual:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_OnClickedMaidActorOutfitOption(" .. 2 .. ")")
    self._ui.chk_maidActor_helmIndivisual:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 12 .. " )")
    self._ui.chk_maidActor_helmIndivisual:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 12 .. " )")
    self._ui.chk_maidActor_helmOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_OnClickedMaidActorOutfitOption(" .. 3 .. ")")
    self._ui.chk_maidActor_helmOpen:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 13 .. " )")
    self._ui.chk_maidActor_helmOpen:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 13 .. " )")
    self._ui.chk_maidActor_cloakIndivisual:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_OnClickedMaidActorOutfitOption(" .. 4 .. ")")
    self._ui.chk_maidActor_cloakIndivisual:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 14 .. " )")
    self._ui.chk_maidActor_cloakIndivisual:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 14 .. " )")
    self._ui.chk_maidActor_subWeaponIndivisual:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_OnClickedMaidActorOutfitOption(" .. 5 .. ")")
    self._ui.chk_maidActor_subWeaponIndivisual:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 15 .. " )")
    self._ui.chk_maidActor_subWeaponIndivisual:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 15 .. " )")
    self._ui.stc_maidActor_guideIcon:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 17 .. " )")
    self._ui.stc_maidActor_guideIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 17 .. " )")
  end
  if self._isConsole == false then
    self._ui.chk_UseMultiMaid:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_UseMultiMaidClick(false)")
    self._ui.chk_UseMultiMaid:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 4 .. " )")
    self._ui.chk_UseMultiMaid:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 4 .. " )")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_Close()")
    self._ui_pc.btn_radios[self._eTAB_TYPE.ALL]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. self._eTAB_TYPE.ALL .. ")")
    self._ui_pc.btn_radios[self._eTAB_TYPE.STORAGE]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. self._eTAB_TYPE.STORAGE .. ")")
    if self._ui_pc.btn_radios[self._eTAB_TYPE.MARKETPLACE] ~= nil then
      self._ui_pc.btn_radios[self._eTAB_TYPE.MARKETPLACE]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. self._eTAB_TYPE.MARKETPLACE .. ")")
    end
    if self._ui_pc.btn_radios[self._eTAB_TYPE.MAIDACTOR] ~= nil then
      self._ui_pc.btn_radios[self._eTAB_TYPE.MAIDACTOR]:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_Update(" .. self._eTAB_TYPE.MAIDACTOR .. ")")
    end
    self._ui_pc.btn_warehouse:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_SelectMaid(" .. self._eTAB_TYPE.STORAGE .. ")")
    self._ui_pc.btn_market:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_SelectMaid(" .. self._eTAB_TYPE.MARKET .. ")")
    self._ui_pc.btn_marketPlace:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidList_All_SelectMaid(" .. self._eTAB_TYPE.MARKETPLACE .. ")")
    self._ui_pc.btn_summonMaidActor:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ToggleSummonMaidActor()")
    self._ui_pc.btn_summonMaidActor:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 18 .. " )")
    self._ui_pc.btn_summonMaidActor:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 18 .. " )")
    self._ui_pc.btn_maidActorManagement:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 8 .. " )")
    self._ui_pc.btn_maidActorManagement:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 8 .. " )")
    self._ui_pc.btn_maidActorManagement:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ListMaidActor()")
    self._ui_pc.btn_warehouse:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 0 .. " )")
    self._ui_pc.btn_warehouse:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 0 .. " )")
    self._ui_pc.btn_market:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 1 .. " )")
    self._ui_pc.btn_market:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 1 .. " )")
    self._ui_pc.btn_marketPlace:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 2 .. " )")
    self._ui_pc.btn_marketPlace:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 2 .. " )")
    if _ContentsGroup_MaidActorSystem == true then
      self._ui.chk_UseMaidActor:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_UseMaidActorClick(false)")
      self._ui.chk_UseMaidActor:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 5 .. " )")
      self._ui.chk_UseMaidActor:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 5 .. " )")
      self._ui.chk_FollowMaidActor:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ChangeMaidActorFollowMode(false)")
      self._ui.chk_FollowMaidActor:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 16 .. " )")
      self._ui.chk_FollowMaidActor:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 16 .. " )")
    end
    if _ContentsGroup_Maid == true then
      self._ui_pc.btn_warehouse:setButtonShortcuts("PANEL_MAIDLIST_OPEN_WAREHOUSE")
      if _ContentsGroup_RenewUI_ItemMarketPlace == true then
        self._ui_pc.btn_marketPlace:setButtonShortcuts("PANEL_MAIDLIST_OPEN_MARKETPLACE")
      else
        self._ui_pc.btn_market:setButtonShortcuts("PANEL_MAIDLIST_OPEN_ITEMMARKET")
      end
    end
    if _ContentsGroup_KR_Transfer == true then
      self._ui_pc.btn_pcRoom:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidList_All_ClickPcRoomBtn()")
      self._ui_pc.btn_pcRoom:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_SimpleTooltip( true, " .. 3 .. " )")
      self._ui_pc.btn_pcRoom:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_SimpleTooltip( false, " .. 3 .. " )")
    end
  else
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PadEventRBLB_PaGlobal_MaidList_All_NextTab(-1)")
    Panel_Window_MaidList_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PadEventRBLB_PaGlobal_MaidList_All_NextTab(1)")
  end
  Panel_Window_MaidList_All:RegisterUpdateFunc("PaGlobalFunc_MaidList_All_UpdatePerFrame")
  registerEvent("onScreenResize", "onScreenResize_MaidList_All_Resize")
  registerEvent("FromClient_RefreshMaidList", "FromClient_RefreshMaidList_MaidList_All")
  registerEvent("FromClient_RefreshPcRoomState", "FromClient_MaidList_All_RefreshPcRoomState")
  registerEvent("FromClient_MaidActorEvent", "FromClient_MaidList_All_MaidActorEvent")
  registerEvent("FromClient_SummonMaidActor", "FromClient_MaidList_All_SummonMaidActor")
  registerEvent("FromClient_UnsummonMaidActor", "FromClient_MaidList_All_UnsummonMaidActor")
  registerEvent("FromClient_EquipItemToMaidActor", "FromClient_MaidList_All_EquipItemToMaidActor")
  registerEvent("FromClient_UnequipItemFromMaidActor", "FromClient_MaidList_All_UnequipItemFromMaidActor")
  registerEvent("FromClient_ChangeMaidActorFollowMode", "FromClient_MaidList_All_ChangeMaidActorFollowMode")
end
function PaGlobal_MaidList_All:prepareOpen()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if ToClient_IsInClientInstanceDungeon() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoClientDungeon"))
    return
  end
  if _ContentsGroup_ForceShowWidgetIcon == true then
    local maidCount = getTotalMaidList()
    if (_ContentsGroup_KR_Transfer == false or getTemporaryInformationWrapper():isPremiumPcRoom() == false) and maidCount <= 0 then
      Panel_WebHelper_ShowToggle("Maid")
      return
    end
  end
  self:setTabTo(self._currentTab)
  self:open()
end
function PaGlobal_MaidList_All:open()
  if nil == Panel_Window_MaidList_All then
    return
  end
  Panel_Window_MaidList_All:setMaskingChild(true)
  Panel_Window_MaidList_All:setGlassBackground(true)
  Panel_Window_MaidList_All:SetShow(true)
end
function PaGlobal_MaidList_All:prepareClose()
  if nil == Panel_Window_MaidList_All then
    return
  end
  if _ContentsGroup_MaidActorSystem == true then
    Inventory_updateSlotData()
  end
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_MaidList_All:close()
  if nil == Panel_Window_MaidList_All then
    return
  end
  Panel_Window_MaidList_All:ClearUpdateLuaFunc()
  Panel_Window_MaidList_All:SetShow(false)
end
function PaGlobal_MaidList_All:validate()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui.stc_title:isValidate()
  self._ui.txt_noMaidFound:isValidate()
  self._ui.txt_maidCount:isValidate()
  self._ui.txt_maidCountValue:isValidate()
  self._ui.list2_maid:isValidate()
  self._ui.chk_UseMultiMaid:isValidate()
  self._ui.txt_UseMultiMaid:isValidate()
  self._ui.chk_UseMaidActor:isValidate()
  self._ui.chk_FollowMaidActor:isValidate()
  self._ui.stc_maidActor_buttonBg:isValidate()
  self._ui.stc_maidActor_leftBg:isValidate()
  self._ui.stc_maidActor_rightBg:isValidate()
  if self._isConsole == false then
    self._ui_pc.btn_close:isValidate()
    self._ui_pc.stc_tabBg:isValidate()
    self._ui_pc.btn_radios[self._eTAB_TYPE.ALL]:isValidate()
    self._ui_pc.btn_radios[self._eTAB_TYPE.STORAGE]:isValidate()
    if nil ~= self._ui_pc.btn_radios[self._eTAB_TYPE.MARKETPLACE] then
      self._ui_pc.btn_radios[self._eTAB_TYPE.MARKETPLACE]:isValidate()
    end
    if self._ui_pc.btn_radios[self._eTAB_TYPE.MAIDACTOR] ~= nil then
      self._ui_pc.btn_radios[self._eTAB_TYPE.MAIDACTOR]:isValidate()
    end
    self._ui_pc.btn_warehouse:isValidate()
    self._ui_pc.btn_market:isValidate()
    self._ui_pc.btn_marketPlace:isValidate()
    self._ui_pc.btn_pcRoom:isValidate()
    self._ui_pc.btn_summonMaidActor:isValidate()
    self._ui_pc.btn_maidActorManagement:isValidate()
  else
    self._ui_console.stc_tabBg:isValidate()
    self._ui_console.rdo_tabs[self._eTAB_TYPE.ALL]:isValidate()
    self._ui_console.rdo_tabs[self._eTAB_TYPE.STORAGE]:isValidate()
    self._ui_console.rdo_tabs[self._eTAB_TYPE.MARKETPLACE]:isValidate()
    if self._ui_console.rdo_tabs[self._eTAB_TYPE.MAIDACTOR] ~= nil then
      self._ui_console.rdo_tabs[self._eTAB_TYPE.MAIDACTOR]:isValidate()
    end
    self._ui_console.stc_keyGuideLB:isValidate()
    self._ui_console.stc_keyGuideRB:isValidate()
    self._ui_console.stc_keyGuideAreaBg:isValidate()
    self._ui_console.stc_guideIconY:isValidate()
    self._ui_console.stc_guideIconB:isValidate()
    self._ui_console.stc_guideIconRS:isValidate()
    self._ui_console.stc_guideIconLS:isValidate()
    self._ui_console.stc_guideIconX:isValidate()
    self._ui_console.stc_guideIconLTX:isValidate()
    self._ui_console.stc_guideIconLTY:isValidate()
    self._ui_console.stc_guideIconRTX:isValidate()
    self._ui_console.stc_guideIconRTY:isValidate()
  end
end
function PaGlobalFunc_MaidList_All_ListControlCreate(control, key)
  if nil == Panel_Window_MaidList_All then
    return
  end
  local btn = UI.getChildControl(control, "Button_ListObject")
  local txt_name = UI.getChildControl(btn, "StaticText_Name")
  local txt_type = UI.getChildControl(btn, "StaticText_Func")
  local txt_cool = UI.getChildControl(btn, "StaticText_Cooltime")
  local key32 = Int64toInt32(key)
  local functionText = {
    [PaGlobal_MaidList_All._eTAB_TYPE.STORAGE] = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_WAREHOUSE"),
    [PaGlobal_MaidList_All._eTAB_TYPE.MARKETPLACE] = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_MARKET")
  }
  btn:SetIgnore(true)
  txt_name:SetText(PaGlobal_MaidList_All._maidData[key32].name)
  txt_type:SetText(functionText[PaGlobal_MaidList_All._maidData[key32].func])
  local oneMinute = 60
  local coolTime = PaGlobal_MaidList_All._maidData[key32].cool
  if 0 == coolTime then
    txt_cool:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_POSSIBLE"))
    txt_cool:SetFontColor(Defines.Color.C_FFDDC39E)
    txt_name:SetFontColor(Defines.Color.C_FFDDC39E)
    txt_type:SetFontColor(Defines.Color.C_FFDDC39E)
  elseif oneMinute > coolTime then
    txt_cool:SetFontColor(Defines.Color.C_FF9397A7)
    txt_name:SetFontColor(Defines.Color.C_FF9397A7)
    txt_type:SetFontColor(Defines.Color.C_FF9397A7)
    txt_cool:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_ONEMINUTELEFT"))
  else
    txt_cool:SetFontColor(Defines.Color.C_FF585453)
    txt_name:SetFontColor(Defines.Color.C_FF585453)
    txt_type:SetFontColor(Defines.Color.C_FF585453)
    txt_cool:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIDLIST_LEFTTIME", "minute", coolTime / oneMinute - coolTime / oneMinute % 1))
  end
end
function PaGlobal_MaidList_All:LogInMaidShow()
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) == true then
    return
  end
  if 6 < getSelfPlayer():get():getLevel() and 0 < getTotalMaidList() then
    ToClient_CallHandlerMaid("_StrAllmaidLogOut")
    local randomMaidIndex = math.random(getTotalMaidList()) - 1
    local maidInfoWrapper = getMaidDataByIndex(randomMaidIndex)
    if nil ~= maidInfoWrapper then
      local aiVariable = 2
      local maidNo = maidInfoWrapper:getMaidNo()
      ToClient_SummonMaid(maidNo, aiVariable)
    end
  end
end
function PaGlobal_MaidList_All:setTabTo(tabIndex)
  if Panel_Window_MaidList_All == nil then
    return
  end
  local radios
  if self._isConsole == false then
    radios = self._ui_pc.btn_radios
  else
    radios = self._ui_console.rdo_tabs
  end
  local tabBgPosX = self._ui_pc.stc_tabBg:GetPosX()
  local tabBgSizeX = self._ui_pc.stc_tabBg:GetSizeX()
  local showTabCount = 0
  for ii = 1, self._eTAB_TYPE.COUNT - 1 do
    if radios[ii] ~= nil then
      showTabCount = showTabCount + 1
    end
  end
  local showTabIndex = 1
  for ii = 1, self._eTAB_TYPE.COUNT - 1 do
    if radios[ii] ~= nil then
      radios[ii]:SetCheck(false)
      radios[ii]:SetFontColor(Defines.Color.C_FF585453)
      local posX = tabBgSizeX / (showTabCount + 1) * showTabIndex - radios[ii]:GetSizeX() / 2
      radios[ii]:SetPosX(posX)
      showTabIndex = showTabIndex + 1
    end
  end
  radios[tabIndex]:SetCheck(true)
  radios[tabIndex]:SetFontColor(Defines.Color.C_FFFFEDD4)
  self._ui.stc_tabBar:SetPosX(radios[tabIndex]:GetPosX() + radios[tabIndex]:GetSizeX() / 2 - self._ui.stc_tabBar:GetSizeX() / 2)
  self._currentTab = tabIndex
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  self:updateCheckBoxButtonShowState()
  if _ContentsGroup_MaidActorSystem == true then
    Inventory_updateSlotData()
  end
  if self._currentTab == self._eTAB_TYPE.MAIDACTOR then
    self:showMaidActorTab(true)
    self:updateMaidActorData()
    self:updateMaidActorRenderFlagButton(nil)
    self:updateLeftMaidCountText()
    self:updateBtnPosition(self._currentTab)
    self:consoleKeyGuideSet(true, true, true)
  else
    self:showMaidActorTab(false)
    self:updateData(self._currentTab)
    self:pushDataToList()
    if true == self._isConsole then
      local scroll = self._ui.list2_maid:GetVScroll()
      if nil ~= scroll and true == scroll:GetShow() then
        self._ui_console.stc_guideIconRS:SetShow(true)
      else
        self._ui_console.stc_guideIconRS:SetShow(false)
      end
    end
    if self._eTAB_TYPE.STORAGE == self._currentTab then
      self:consoleKeyGuideSet(false, true, false)
    elseif self._eTAB_TYPE.MARKETPLACE == self._currentTab then
      self:consoleKeyGuideSet(true, false, false)
    else
      self:consoleKeyGuideSet(true, true, false)
    end
  end
end
function PaGlobal_MaidList_All:showMaidActorTab(isMaidActorTabShow)
  if Panel_Window_MaidList_All == nil then
    return
  end
  self._ui.stc_maidActor_buttonBg:SetShow(isMaidActorTabShow)
  self._ui.stc_maidActor_leftBg:SetShow(isMaidActorTabShow)
  self._ui.stc_maidActor_rightBg:SetShow(isMaidActorTabShow)
  self._ui.chk_maidActor_underwearIndivisual:SetShow(isMaidActorTabShow)
  self._ui.chk_maidActor_helmIndivisual:SetShow(isMaidActorTabShow)
  self._ui.chk_maidActor_helmOpen:SetShow(isMaidActorTabShow)
  self._ui.chk_maidActor_cloakIndivisual:SetShow(isMaidActorTabShow)
  self._ui.chk_maidActor_subWeaponIndivisual:SetShow(isMaidActorTabShow)
  self._ui.stc_maidActor_equipHide:SetShow(isMaidActorTabShow)
  self._ui.stc_maidActor_guideIcon:SetShow(isMaidActorTabShow)
  self._ui.stc_listBg:SetShow(isMaidActorTabShow == false)
  self._ui.stc_tabBarLine:SetShow(isMaidActorTabShow == false)
  self._ui.stc_maidListTopBg:SetShow(isMaidActorTabShow == false)
  self._ui.list2_maid:SetShow(isMaidActorTabShow == false)
  self._ui.txt_noMaidFound:SetShow(isMaidActorTabShow == false)
  if self._isConsole == false then
    self._ui_pc.btn_summonMaidActor:SetShow(isMaidActorTabShow)
    self._ui_pc.btn_maidActorManagement:SetShow(isMaidActorTabShow)
    if _ContentsGroup_RenewUI_ItemMarketPlace == true then
      self._ui_pc.btn_market:SetShow(false)
      self._ui_pc.btn_marketPlace:SetShow(isMaidActorTabShow == false)
    else
      self._ui_pc.btn_market:SetShow(isMaidActorTabShow == false)
      self._ui_pc.btn_marketPlace:SetShow(false)
    end
  end
end
function PaGlobal_MaidList_All:updateCheckBoxButtonShowState()
  if Panel_Window_MaidList_All == nil then
    return
  end
  local isShowPcRoomButton = self._ui_pc.btn_pcRoom:GetShow()
  local isMaidCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMultiMaid, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  local isUseMaidActor = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMyCustomMaidActor, true, CppEnums.VariableStorageType.eVariableStorageType_User)
  local isMaidActorFollowMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eMaidActorFollowMode) < 2
  local isMaidTab = self._currentTab == self._eTAB_TYPE.MAIDACTOR
  self._ui.chk_UseMultiMaid:SetIgnore(_ContentsGroup_UseMultiMaid == false)
  self._ui.chk_UseMultiMaid:SetShow(_ContentsGroup_UseMultiMaid == true and isMaidTab == false and isShowPcRoomButton == false)
  self._ui.chk_UseMultiMaid:SetCheck(isMaidCheck)
  self._ui.chk_UseMaidActor:SetIgnore(_ContentsGroup_MaidActorSystem == false)
  self._ui.chk_UseMaidActor:SetShow(_ContentsGroup_MaidActorSystem == true and isMaidTab == true and isShowPcRoomButton == false)
  self._ui.chk_UseMaidActor:SetCheck(isUseMaidActor)
  self._ui.chk_FollowMaidActor:SetIgnore(_ContentsGroup_MaidActorSystem == false)
  self._ui.chk_FollowMaidActor:SetShow(_ContentsGroup_MaidActorSystem == true and isMaidTab == true and isShowPcRoomButton == false)
  self._ui.chk_FollowMaidActor:SetCheck(isMaidActorFollowMode)
end
function PaGlobal_MaidList_All:updateMaidActorData()
  if Panel_Window_MaidList_All == nil then
    return
  end
  local isHaveAnyMaidActorInfo = ToClient_CheckHaveMaidActor()
  self._ui.stc_maidActor_buttonBg:SetShow(isHaveAnyMaidActorInfo == false)
  self._ui.stc_maidActor_leftBg:SetShow(isHaveAnyMaidActorInfo)
  self._ui.stc_maidActor_rightBg:SetShow(isHaveAnyMaidActorInfo)
  self._ui.stc_maidActor_photoEmpty:SetShow(true)
  self._ui.stc_maidActor_photo:SetShow(false)
  self._ui.txt_maidActor_name:SetShow(isHaveAnyMaidActorInfo)
  if self._isConsole == false then
    self._ui_pc.btn_summonMaidActor:SetShow(isHaveAnyMaidActorInfo)
  end
  if isHaveAnyMaidActorInfo == true then
    local maidActorCount = ToClient_GetMaidActorListSize()
    for ii = 0, maidActorCount - 1 do
      local maidActorInfo = ToClient_GetMaidActorSimpleInfo(ii)
      if maidActorInfo ~= nil then
        local isHead = maidActorInfo:getIsHead()
        if isHead == true then
          local maidNo_s64 = maidActorInfo:getMaidNo()
          local maidName = maidActorInfo:getMaidName()
          local maidClassTypeRaw = maidActorInfo:getClassTypeRaw()
          self._ui.txt_maidActor_name:SetText(maidName)
          local photoFileName = ToClient_GetMaidActorFaceTexturePathFromClient(maidNo_s64)
          local isExistPhotoFile = self._ui.stc_maidActor_photo:ChangeTextureInfoNameNotDDS(photoFileName, maidClassTypeRaw, true)
          if isExistPhotoFile == true then
            self._ui.stc_maidActor_photo:getBaseTexture():setUV(0, 0, 1, 1)
            self._ui.stc_maidActor_photo:setRenderTexture(self._ui.stc_maidActor_photo:getBaseTexture())
            self._ui.stc_maidActor_photo:SetShow(true)
            self._ui.stc_maidActor_photoEmpty:SetShow(false)
            break
          end
          do
            local newClassTexutreIDData = NewClassData.newClass_Texture_ID[maidClassTypeRaw]
            if newClassTexutreIDData == nil then
              maidClassTypeRaw = -1
            end
            local defaultFace = NewClassData.newClass_Texture_ID[maidClassTypeRaw]._defaultFaceTextureTID
            if defaultFace ~= nil then
              self._ui.stc_maidActor_photo:ChangeTextureInfoTextureIDAsync(defaultFace, 0)
              self._ui.stc_maidActor_photo:setRenderTexture(self._ui.stc_maidActor_photo:getBaseTexture())
              self._ui.stc_maidActor_photo:SetShow(true)
              self._ui.stc_maidActor_photoEmpty:SetShow(false)
            end
          end
          break
        end
      end
    end
    self:updateMaidActorSlotData()
  end
end
function PaGlobal_MaidList_All:updateMaidActorRenderFlagButton(type)
  if Panel_Window_MaidList_All == nil then
    return
  end
  if type == nil or type == 1 then
    self._ui.chk_maidActor_underwearIndivisual:SetCheck(ToClient_IsMaidActorUnderwearOrSwimmingSuiteMode())
  end
  if type == nil or type == 2 then
    self._ui.chk_maidActor_helmIndivisual:SetCheck(ToClient_IsMaidActorHideHelm())
  end
  if type == nil or type == 3 then
    self._ui.chk_maidActor_helmOpen:SetCheck(ToClient_IsMaidActorShowBattleHelm())
  end
  if type == nil or type == 4 then
    self._ui.chk_maidActor_cloakIndivisual:SetCheck(ToClient_IsMaidActorHideCloak())
  end
  if type == nil or type == 5 then
    self._ui.chk_maidActor_subWeaponIndivisual:SetCheck(ToClient_IsMaidActorHideSubWeapon())
  end
end
function PaGlobal_MaidList_All:checkMaidUsableSlot(slotNo)
  if Panel_Window_MaidList_All == nil then
    return
  end
  if slotNo == __eEquipSlotNoAvatarChest or slotNo == __eEquipSlotNoAvatarGlove or slotNo == __eEquipSlotNoAvatarBoots or slotNo == __eEquipSlotNoAvatarHelm or slotNo == __eEquipSlotNoAvatarWeapon or slotNo == __eEquipSlotNoAvatarSubWeapon or slotNo == __eEquipSlotNoAvatarAwakenWeapon or slotNo == __eEquipSlotNoAvatarUnderwear or slotNo == __eEquipSlotNoFaceDecoration1 or slotNo == __eEquipSlotNoFaceDecoration2 or slotNo == __eEquipSlotNoFaceDecoration3 or slotNo == __eEquipSlotNoTemp then
    return true
  else
    return false
  end
end
function PaGlobal_MaidList_All:updateMaidActorSlotData()
  if Panel_Window_MaidList_All == nil then
    return
  end
  if self._currentTab ~= self._eTAB_TYPE.MAIDACTOR then
    return
  end
  local isSummonedMaidActor = ToClient_IsSummonMaidActor()
  self._ui.btn_maidActor_customize:SetShow(isSummonedMaidActor)
  self._ui.btn_maidActor_dye:SetShow(isSummonedMaidActor)
  self._ui.btn_maidActor_action:SetShow(isSummonedMaidActor)
  self._ui.chk_maidActor_underwearIndivisual:SetShow(isSummonedMaidActor)
  self._ui.chk_maidActor_helmIndivisual:SetShow(isSummonedMaidActor)
  self._ui.chk_maidActor_helmOpen:SetShow(isSummonedMaidActor)
  self._ui.chk_maidActor_cloakIndivisual:SetShow(isSummonedMaidActor)
  self._ui.chk_maidActor_subWeaponIndivisual:SetShow(isSummonedMaidActor)
  self._ui.stc_maidActor_equipHide:SetShow(isSummonedMaidActor == false)
  if self._isConsole == false then
    self._ui_pc.btn_summonMaidActor:SetShow(true)
    if isSummonedMaidActor == true then
      self._ui_pc.btn_summonMaidActor:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_UNSUMMON"))
    else
      self._ui_pc.btn_summonMaidActor:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_SUMMON"))
    end
  end
  self._extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  local summonMaidActorClassTypeRaw = ToClient_GetSummonMaidActorClassTypeRaw()
  local isOpenAwakenWeaponContents = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(summonMaidActorClassTypeRaw)
  if isOpenAwakenWeaponContents == nil then
    isOpenAwakenWeaponContents = false
  end
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if self:checkMaidUsableSlot(slotNo) == true then
      local slot = self.slots[slotNo]
      local slotBG = self.slotBGs[slotNo]
      local itemWrapper = ToClient_getMaidActorEquipmentItem(slotNo)
      local isEmptySlot = true
      local isHideSlot = false
      if slotNo == __eEquipSlotNoAvatarAwakenWeapon then
        if __eClassType_ShyWaman == summonMaidActorClassTypeRaw then
          isHideSlot = true
        else
          isHideSlot = isOpenAwakenWeaponContents == false
        end
      elseif slotNo == __eEquipSlotNoAvatarUnderwear then
        local spanX = 0
        local spanY = slotBG:GetSpanSize().y
        if __eClassType_ShyWaman == summonMaidActorClassTypeRaw or isOpenAwakenWeaponContents == false then
          spanX = 124
          spanY = self._maidActorEquipSlot_UnderWearSpanY
        else
          spanX = self._maidActorEquipSlot_UnderWearSpanX
          spanY = self._maidActorEquipSlot_UnderWearSpanY
        end
        slotBG:SetSpanSize(spanX, spanY)
        slotBG:ComputePos()
        slot.icon:SetSpanSize(spanX, spanY)
        slot.icon:ComputePos()
      end
      if isSummonedMaidActor == false or itemWrapper == nil then
        isEmptySlot = true
        slot:clearItem()
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_EmptySlotTooltip(" .. slotNo .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_EmptySlotTooltip(" .. slotNo .. ",false)")
      else
        isEmptySlot = false
        local itemSSW = itemWrapper:getStaticStatus()
        local slotNoMax = itemSSW:getExtendedSlotCount()
        for i = 1, slotNoMax do
          local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
          if slotNoMax ~= extendSlotNo then
            self._extendedSlotInfoArray[extendSlotNo] = slotNo
            checkExtendedSlot = true
          end
        end
        slot:setItem(itemWrapper, slotNo, true)
        slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MaidList_All_EquipmentTooltip(" .. slotNo .. ",true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MaidList_All_EquipmentTooltip(" .. slotNo .. ",false)")
      end
      slot.border:EraseAllEffect()
      slot.icon:EraseAllEffect()
      slot.icon:SetEnable(true)
      slot.icon:SetMonoTone(false)
      if isHideSlot == true then
        slotBG:SetShow(false)
        slot.icon:SetShow(false)
      else
        slotBG:SetShow(isEmptySlot == true)
        slot.icon:SetShow(true)
      end
    end
  end
  if checkExtendedSlot == true then
    for extendSlotNo, parentSlotNo in pairs(self._extendedSlotInfoArray) do
      local itemWrapper = ToClient_getMaidActorEquipmentItem(parentSlotNo)
      local slogBg = self.slotBGs[extendSlotNo]
      local slot = self.slots[extendSlotNo]
      slogBg:SetShow(false)
      slot:setItem(itemWrapper, slotNo, true)
      slot.icon:SetEnable(false)
      slot.icon:SetMonoTone(true)
    end
  end
end
function PaGlobal_MaidList_All:updateData(tab)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if tab == self._eTAB_TYPE.MAIDACTOR then
    return
  end
  self._maidData = {}
  local maidCount = getTotalMaidList()
  if maidCount < 1 then
    self._ui.txt_maidCountValue:SetText("0")
    self._ui.txt_noMaidFound:SetShow(true)
    self:updateLeftMaidCountText()
    return
  else
    self._ui.txt_noMaidFound:SetShow(false)
  end
  local waremaidChiefIndex = -1
  local marketmaidChiefIndex = -1
  local availableMaidCount = 0
  for ii = 1, maidCount do
    local maidInfoWrapper = getMaidDataByIndex(ii - 1)
    if nil ~= maidInfoWrapper then
      local data = {
        name = maidInfoWrapper:getName(),
        cool = maidInfoWrapper:getCoolTime(),
        isChief = 0
      }
      if true == maidInfoWrapper:isAbleInWarehouse() or maidInfoWrapper:isAbleOutWarehouse() then
        data.func = self._eTAB_TYPE.STORAGE
      elseif true == maidInfoWrapper:isAbleSubmitMarket() then
        data.func = self._eTAB_TYPE.MARKETPLACE
      end
      local index = #self._maidData + 1
      if true == maidInfoWrapper:isMaidChief() then
        data.isChief = 1
        waremaidChiefIndex = index
      elseif true == maidInfoWrapper:isMaidChiefMarket() then
        data.isChief = 1
        marketmaidChiefIndex = index
      else
        data.isChief = 0
      end
      if tab == self._eTAB_TYPE.STORAGE and data.func == self._eTAB_TYPE.STORAGE then
        self._maidData[index] = data
      elseif tab == self._eTAB_TYPE.MARKETPLACE and data.func == self._eTAB_TYPE.MARKETPLACE then
        self._maidData[index] = data
      elseif tab == self._eTAB_TYPE.MARKET and data.func == self._eTAB_TYPE.MARKET then
        self._maidData[index] = data
      elseif tab == self._eTAB_TYPE.ALL then
        self._maidData[index] = data
      end
      if nil ~= self._maidData[index] and 0 == self._maidData[index].cool then
        availableMaidCount = availableMaidCount + 1
      end
    end
  end
  if tab == self._eTAB_TYPE.STORAGE then
    if -1 ~= waremaidChiefIndex and nil ~= self._maidData and nil ~= self._maidData[waremaidChiefIndex] then
      local tempTable = {}
      local index = #tempTable + 1
      tempTable[index] = self._maidData[waremaidChiefIndex]
      for ii = 1, #self._maidData do
        if nil ~= self._maidData[ii] and 0 == self._maidData[ii].isChief then
          index = #tempTable + 1
          tempTable[index] = self._maidData[ii]
        end
      end
      self._maidData = tempTable
    end
  elseif tab == self._eTAB_TYPE.MARKETPLACE then
    if -1 ~= marketmaidChiefIndex and nil ~= self._maidData and nil ~= self._maidData[marketmaidChiefIndex] then
      local tempTable = {}
      local index = #tempTable + 1
      tempTable[index] = self._maidData[marketmaidChiefIndex]
      for ii = 1, #self._maidData do
        if nil ~= self._maidData[ii] and 0 == self._maidData[ii].isChief then
          index = #tempTable + 1
          tempTable[index] = self._maidData[ii]
        end
      end
      self._maidData = tempTable
    end
  elseif tab == self._eTAB_TYPE.ALL and nil ~= self._maidData then
    local tempTable = {}
    local index = #tempTable + 1
    if -1 ~= waremaidChiefIndex then
      tempTable[index] = self._maidData[waremaidChiefIndex]
    end
    if -1 ~= marketmaidChiefIndex then
      index = #tempTable + 1
      tempTable[index] = self._maidData[marketmaidChiefIndex]
    end
    for ii = 1, #self._maidData do
      if nil ~= self._maidData[ii] and 0 == self._maidData[ii].isChief then
        index = #tempTable + 1
        tempTable[index] = self._maidData[ii]
      end
    end
    self._maidData = tempTable
  end
  self:updateLeftMaidCountText()
  self:updateBtnPosition(tab)
  self._ui.txt_maidCountValue:SetText(availableMaidCount)
end
function PaGlobal_MaidList_All:updateLeftMaidCountText()
  if Panel_Window_MaidList_All == nil then
    return
  end
  self._ui.txt_whareHouseCount:SetText(tostring(ToClient_getUsableMaidCountByType(false)) .. "/" .. tostring(ToClient_getMaidCount(false)))
  self._ui.txt_itemMarketCount:SetText(tostring(ToClient_getUsableMaidCountByType(true)) .. "/" .. tostring(ToClient_getMaidCount(true)))
end
function PaGlobal_MaidList_All:updateBtnPosition(tab)
  if nil == Panel_Window_MaidList_All then
    return
  end
  if true == self._isConsole then
    return
  end
  if tab == self._eTAB_TYPE.ALL or tab == self._eTAB_TYPE.MAIDACTOR then
    self._ui_pc.btn_market:SetSpanSize(15, 15)
    self._ui_pc.btn_warehouse:SetShow(true)
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      self._ui_pc.btn_market:SetShow(false)
      self._ui_pc.btn_marketPlace:SetShow(true)
    else
      self._ui_pc.btn_market:SetShow(true)
      self._ui_pc.btn_marketPlace:SetShow(false)
    end
    self._ui_pc.btn_marketPlace:SetShow(_ContentsGroup_ItemMarketKor2)
  elseif tab == self._eTAB_TYPE.STORAGE then
    self._ui_pc.btn_warehouse:SetShow(true)
    self._ui_pc.btn_market:SetShow(false)
    self._ui_pc.btn_marketPlace:SetShow(false)
  elseif tab == self._eTAB_TYPE.MARKETPLACE then
    self._ui_pc.btn_warehouse:SetShow(false)
    self._ui_pc.btn_market:SetShow(false)
    self._ui_pc.btn_marketPlace:SetShow(true)
  elseif tab == self._eTAB_TYPE.MARKET then
    self._ui_pc.btn_warehouse:SetShow(false)
    self._ui_pc.btn_market:SetSpanSize(15, 15)
    self._ui_pc.btn_market:SetShow(true)
    self._ui_pc.btn_marketPlace:SetShow(false)
  end
end
function PaGlobal_MaidList_All:pushDataToList()
  if nil == Panel_Window_MaidList_All then
    return
  end
  self._ui.list2_maid:getElementManager():clearKey()
  for ii = 1, #self._maidData do
    self._ui.list2_maid:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobal_MaidList_All:isCheckMaidChief(isMarket)
  return ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMultiMaid, true, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobalFunc_MaidList_All_UpdatePerFrame(deltaTime)
  if nil == Panel_Window_MaidList_All then
    return
  end
  local elapsedTime = 0
  local updateInterval = 1
  elapsedTime = elapsedTime + deltaTime
  if updateInterval < elapsedTime then
    elapsedTime = 0
    PaGlobal_MaidList_All:updateData(PaGlobal_MaidList_All._currentTab)
    PaGlobal_MaidList_All._ui.list2_maid:requestUpdateVisible()
  end
end
function PaGlobalFunc_MaidList_All_SelectMaid(key32)
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  if nil == Panel_Window_MaidList_All then
    return
  end
  if nil == key32 then
    _PA_ASSERT_NAME(false, "PaGlobalFunc_MaidList_All_SelectMaid: key32\236\157\180 nil\236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    _PA_ASSERT_NAME(false, "PaGlobalFunc_MaidList_All_SelectMaid: selfProxy nil\236\158\133\235\139\136\235\139\164", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local isFreeBattle = selfProxy:get():isBattleGroundDefine()
  local isArshaJoin = ToClient_IsMyselfInArena()
  local localWarTeam = ToClient_GetMyTeamNoRedBattleField()
  local isPremiumCharacter = getTemporaryInformationWrapper():isPremiumCharacter()
  local isSavageDefence = ToClient_getPlayNowSavageDefence()
  local isGuildBattle = ToClient_getJoinGuildBattle()
  local isRestrictRegion = ToClient_RestrictContentsByRegion(__eRestrictContentsType_Maid)
  if localWarTeam ~= 0 or ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_LOCALWAR"))
    return
  end
  if isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_FREEBATTLE"))
    return
  end
  if isArshaJoin then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_ARSHA"))
    return
  end
  if selfplayerIsInHorseRace() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_HORSERACE_NEW"))
    return
  end
  if isPremiumCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  if isSavageDefence then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayingSavageDefence"))
    return
  end
  if isGuildBattle then
    if true == ToClient_isPersonalBattle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_PERSONALBATTLE"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_GUILDBATTLE"))
    end
    return
  end
  if isRestrictRegion then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_HORSERACE"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterSolrareStart"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_MiniGame) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  local warehouseInMaid = checkMaid_WarehouseIn(true)
  local marketMaid = checkMaid_SubmitMarket(true)
  local enableWarehouseMaid = checkMaid_WarehouseIn(false)
  local enableMarketMaid = checkMaid_SubmitMarket(false)
  if PaGlobal_MaidList_All._eTAB_TYPE.MARKETPLACE == key32 then
    if marketMaid then
      if _ContentsOption_CH_CreditPoint == true then
        PaGlobalFunc_MarketPlace_CheckCreditPoint(eCreditPointCheckOpenType.openFromMaid)
      else
        PaGlobalFunc_MarketPlace_OpenByMaid()
      end
      if ToClient_CheckExistSummonMaid() and -1 ~= PaGlobal_MaidList_All._dontGoMaid then
        if 0 == PaGlobal_MaidList_All._maidType then
          ToClient_CallHandlerMaid("_marketMaid")
        else
          for mIndex = 0, getTotalMaidList() - 1 do
            local maidInfoWrapper = getMaidDataByIndex(mIndex)
            if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
              ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
              ToClient_CallHandlerMaid("_warehouseMaidLogOut")
              PaGlobal_MaidList_All._dontGoMaid = mIndex
              PaGlobal_MaidList_All:prepareClose()
              PaGlobal_MaidList_All._maidType = 0
              ToClient_CallHandlerMaid("_marketMaid")
              break
            end
          end
        end
        PaGlobal_MaidList_All:prepareClose()
      else
        for mIndex = 0, getTotalMaidList() - 1 do
          local maidInfoWrapper = getMaidDataByIndex(mIndex)
          if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
            ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
            PaGlobal_MaidList_All._dontGoMaid = mIndex
            PaGlobal_MaidList_All:prepareClose()
            PaGlobal_MaidList_All._maidType = 0
            ToClient_CallHandlerMaid("_marketMaid")
            break
          end
        end
      end
    else
      if false == enableMarketMaid then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_MARKETMAID_NONE"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_MARKETMAID_COOLTIME"))
      end
      if Panel_Dialog_Repair_Function_All ~= nil and Panel_Dialog_Repair_Function_All:GetShow() == true then
        SetUIMode(Defines.UIMode.eUIMode_Repair)
      else
        SetUIMode(Defines.UIMode.eUIMode_Default)
      end
    end
  elseif PaGlobal_MaidList_All._eTAB_TYPE.STORAGE == key32 then
    if warehouseInMaid then
      if nil ~= Panel_Window_CampWarehouse_All and Panel_Window_CampWarehouse_All:GetShow() then
        PaGlobalFunc_CampWarehouse_All_Close()
      end
      if nil ~= Panel_Window_Equip_CharacterTag_ItemCopy and true == Panel_Window_Equip_CharacterTag_ItemCopy:GetShow() and nil ~= PaGlobal_Equip_CharacterTag_ItemCopy_Close then
        PaGlobal_Equip_CharacterTag_ItemCopy_Close()
      end
      if nil ~= PaGlobal_FamilyInvnetory_Close then
        PaGlobal_FamilyInvnetory_Close(true)
      end
      PaGlobal_Warehouse_All_OpenPanelFromMaid(PaGlobal_MaidList_All:isCheckMaidChief(false))
      local maidCount = getTotalMaidList() - 1
      if ToClient_CheckExistSummonMaid() and -1 ~= PaGlobal_MaidList_All._dontGoMaid then
        if 1 == PaGlobal_MaidList_All._maidType then
          ToClient_CallHandlerMaid("_warehouseMaid")
        else
          for mIndex = 0, maidCount do
            local maidInfoWrapper = getMaidDataByIndex(mIndex)
            if (maidInfoWrapper:isAbleInWarehouse() or maidInfoWrapper:isAbleOutWarehouse()) and 0 == maidInfoWrapper:getCoolTime() then
              ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
              ToClient_CallHandlerMaid("_marketMaidLogOut")
              ToClient_CallHandlerMaid("_warehouseMaid")
              PaGlobal_MaidList_All._dontGoMaid = mIndex
              PaGlobal_MaidList_All:prepareClose()
              PaGlobal_MaidList_All._maidType = 1
              break
            end
          end
        end
        PaGlobal_MaidList_All:prepareClose()
      else
        for mIndex = 0, maidCount do
          local maidInfoWrapper = getMaidDataByIndex(mIndex)
          if (maidInfoWrapper:isAbleInWarehouse() or maidInfoWrapper:isAbleOutWarehouse()) and 0 == maidInfoWrapper:getCoolTime() then
            ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
            ToClient_CallHandlerMaid("_warehouseMaid")
            PaGlobal_MaidList_All._dontGoMaid = mIndex
            PaGlobal_MaidList_All:prepareClose()
            PaGlobal_MaidList_All._maidType = 1
            break
          end
        end
      end
    else
      if false == enableWarehouseMaid then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_WAREHOUSEMAID_NONE"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_WAREHOUSEMAID_COOLTIME"))
      end
      if Panel_Dialog_Repair_Function_All ~= nil and Panel_Dialog_Repair_Function_All:GetShow() == true then
        SetUIMode(Defines.UIMode.eUIMode_Repair)
      else
        SetUIMode(Defines.UIMode.eUIMode_Default)
      end
    end
  elseif PaGlobal_MaidList_All._eTAB_TYPE.MARKET == key32 then
    FGlobal_ItemMarket_OpenByMaid()
    if ToClient_CheckExistSummonMaid() and -1 ~= PaGlobal_MaidList_All._dontGoMaid then
      if 0 == PaGlobal_MaidList_All._maidType then
        ToClient_CallHandlerMaid("_marketMaid")
      else
        for mIndex = 0, getTotalMaidList() - 1 do
          local maidInfoWrapper = getMaidDataByIndex(mIndex)
          if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
            ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
            ToClient_CallHandlerMaid("_warehouseMaidLogOut")
            PaGlobal_MaidList_All._dontGoMaid = mIndex
            PaGlobal_MaidList_All:prepareClose()
            PaGlobal_MaidList_All._maidType = 0
            ToClient_CallHandlerMaid("_marketMaid")
            break
          end
        end
      end
      PaGlobal_MaidList_All:prepareClose()
    else
      for mIndex = 0, getTotalMaidList() - 1 do
        local maidInfoWrapper = getMaidDataByIndex(mIndex)
        if maidInfoWrapper:isAbleSubmitMarket() and 0 == maidInfoWrapper:getCoolTime() then
          ToClient_SummonMaid(maidInfoWrapper:getMaidNo(), 1)
          PaGlobal_MaidList_All._dontGoMaid = mIndex
          PaGlobal_MaidList_All:prepareClose()
          PaGlobal_MaidList_All._maidType = 0
          ToClient_CallHandlerMaid("_marketMaid")
          break
        end
      end
    end
  end
end
