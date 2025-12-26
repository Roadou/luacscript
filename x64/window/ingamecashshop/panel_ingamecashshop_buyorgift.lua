local UI_color = Defines.Color
local UI_PLT = CppEnums.CashPurchaseLimitType
local UI_CCC = CppEnums.CashProductCategory
local UI_EventCart = CppEnums.EventCartDiscountType
Panel_IngameCashShop_BuyOrGift:SetShow(false)
Panel_IngameCashShop_BuyOrGift:setGlassBackground(true)
Panel_IngameCashShop_BuyOrGift:ActiveMouseEventEffect(true)
local isCouponOpen = ToClient_IsContentsGroupOpen("224")
local inGameShopBuy = {
  _config = {
    _slot = {
      _startX = 17,
      _startY = 150,
      _gapX = 46
    },
    _buy = {
      _startX = 17,
      _startY = 150,
      _gapX = 46
    },
    _sizeGift = 44,
    _sizeBG = 44,
    _sizePanel = 85,
    _giftTopListMaxCount = 3,
    _giftTopListCount = 0,
    _giftTopListStart = 0,
    _giftBotListMaxCount = 5,
    _giftBotListCount = 0,
    _giftBotListStart = 0,
    _itemCountPerLine = 8
  },
  _addSizeY = 0,
  giftTopList = {},
  giftBotList = {},
  giftUserList = {},
  _savedNotEnoughMoney = false,
  savedProductCount = 1,
  savedCouponApply = nil,
  _immediatelyUse = true,
  savedCouponDiscountRate = 0,
  savedCouponDiscountTextSizeX = 0,
  _panelTitle = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_Title"),
  _static_LeftBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_LeftBG"),
  _static_PearlBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_PearlBG"),
  _static_ItemIconBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GoodsSlotBG"),
  _static_ItemIcon = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GoodsSlot"),
  _static_ItemName = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_GoodsName"),
  _static_PearlIcon = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_PearlIcon"),
  _txt_PearlIconPrice = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_CouponPearlIcon"),
  _txt_DiscountDirection = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_DiscountDirection"),
  _static_DiscountPrice = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_DiscountGoodsPrice"),
  _static_Gift = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_GiftTo"),
  _edit_Gift = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Edit_GiftTo"),
  _static_GiftListBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GiftListBG"),
  _static_GiftListTopBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GiftListTopBG"),
  _static_GiftListMiddleBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GiftListMiddleBG"),
  _static_GiftListBotBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GiftListBotBG"),
  _static_GiftList_NonUser = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_NonUser"),
  _scroll_GiftTopList = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Scroll_GiftTopList"),
  _scroll_GiftBotList = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Scroll_GiftBotList"),
  _buttonFriendList = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Button_Friend"),
  _buttonGuildList = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Button_Guild"),
  _button_AddUser = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Button_AddUser"),
  _button_Close = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Button_Win_Close"),
  _button_Confirm = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Button_Confirm"),
  _button_Cancle = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Button_Cancle"),
  _stc_MoneyArea = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_MyMoneyArea"),
  _staticText_ItemListTitle = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_ItemListTitle"),
  _staticText_Notice = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_Notice"),
  _static_Caution = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_Caution"),
  _slotCount = 20,
  _slots = Array.new(),
  _needMoneyType = -1,
  _stc_guildGiveawayItemBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GuildRewardOneArea"),
  _stc_guildGiveawayItemsBG = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Static_GuildRewardMultiArea"),
  _txt_guildGiveawayDesc = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "StaticText_DescBG"),
  _productNoRaw = nil,
  _isGift = false,
  _byCart = false,
  _easyBuy = false,
  _eventCart = false,
  _isUsePearl = false,
  _currentSelectedEventTab = 0,
  _discountPrice_s64 = toInt64(0, 0),
  _itemSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true
  }
}
inGameShopBuy.icon_Pearl = UI.getChildControl(inGameShopBuy._static_GiftListMiddleBG, "StaticText_TotalPearlIcon")
inGameShopBuy._txt_MoneyValue = UI.getChildControl(inGameShopBuy._stc_MoneyArea, "StaticText_MoneyValue")
local contry = {
  kr = 0,
  jp = 1,
  ru = 2,
  kr2 = 3,
  tw = 4,
  tr = 5,
  id = 6,
  na = 7,
  sa = 8
}
local cashIconType = {
  cash = 0,
  pearl = 1,
  mileage = 2,
  silver = 3
}
local giftSendType = {userNo = 0, characterName = 1}
local eCountryType = CppEnums.CountryType
local gameServiceType = getGameServiceType()
local isKorea = eCountryType.NONE == gameServiceType or eCountryType.DEV == gameServiceType or eCountryType.KOR_ALPHA == gameServiceType or eCountryType.KOR_REAL == gameServiceType or eCountryType.KOR_TEST == gameServiceType
local isNaver = CppEnums.MembershipType.naver == getMembershipType()
local isJapan = eCountryType.JPN_ALPHA == gameServiceType or eCountryType.JPN_REAL == gameServiceType
local isJapanConsole = true == ToClient_isConsole() and CppEnums.ServiceResourceType.eServiceResourceType_JP == ToClient_getResourceType()
local noticeSizeY = 0
if true == isJapan or true == isJapanConsole then
  noticeSizeY = inGameShopBuy._staticText_Notice:GetSizeY()
end
function inGameShopBuy:init()
  local slotConfig = self._config._slot
  self._staticText_Notice:SetTextMode(__eTextMode_AutoWrap)
  if false == isJapan and false == isJapanConsole then
    self._staticText_Notice:SetShow(false)
  end
  local gapCount = 0
  for ii = 0, self._slotCount - 1 do
    local slot = {}
    slot.iconBG = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Static_SubItemSlotBG", Panel_IngameCashShop_BuyOrGift, "InGameShopBuy_Sub_" .. ii)
    slot.icon = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Static_SubItemSlot", slot.iconBG, "InGameShopBuy_Sub_Icon_" .. ii)
    slot._itemRaw = 0
    slot._itemCount = 0
    if ii > 0 and 0 == ii % self._config._itemCountPerLine then
      gapCount = gapCount + 1
    end
    slot.iconBG:SetPosX(slotConfig._startX + slotConfig._gapX * (ii - self._config._itemCountPerLine * gapCount))
    slot.iconBG:SetPosY(slotConfig._startY + 46 * gapCount)
    slot.icon:SetPosX((slot.iconBG:GetSizeX() - slot.icon:GetSizeX()) / 2)
    slot.icon:SetPosY((slot.iconBG:GetSizeY() - slot.icon:GetSizeY()) / 2)
    self._slots[ii] = slot
  end
  self._static_BuyLineBG = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Static_BuyLineBG", Panel_IngameCashShop_BuyOrGift, "InGameShopBuy_Buy")
  self._static_PearlIcon = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_PearlIcon", self._static_BuyLineBG, "InGameShopBuy_Buy_PearlPrice")
  self._static_Price = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_GoodsPrice", self._static_BuyLineBG, "InGameShopBuy_Buy_Price")
  self._static_BuyCountTitle = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_BuyCount", self._static_BuyLineBG, "InGameShopBuy_Buy_Count")
  self._edit_count = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Edit_BuyCount", self._static_BuyLineBG, "InGameShopBuy_Buy_EditCount")
  self._button_CountUp = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_CountPlus", self._static_BuyLineBG, "InGameShopBuy_Buy_ButtonPlus")
  self._button_CountDown = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_CountMinus", self._static_BuyLineBG, "InGameShopBuy_Buy_Button_Minus")
  self._static_PearlIcon:SetShow(false)
  self._static_Price:SetShow(false)
  self._txt_PearlIconPrice:SetShow(true)
  self._button_CountUp:addInputEvent("Mouse_LUp", "InGameShopBuy_Count( true )")
  self._button_CountUp:SetAutoDisableTime(0)
  self._button_CountDown:addInputEvent("Mouse_LUp", "InGameShopBuy_Count( false )")
  self._button_CountDown:SetAutoDisableTime(0)
  self._edit_count:addInputEvent("Mouse_LUp", "OpenNumberPad_CashCount()")
  self._static_BuyCountTitle:addInputEvent("Mouse_LUp", "OpenNumberPad_CashCount()")
  self._edit_count:SetEnable(true)
  self._edit_count:SetText("1")
  self._static_CouponApplyBG = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Static_CouponApplyBG", Panel_IngameCashShop_BuyOrGift, "InGameShopBuy_CouponBG")
  self._txt_CouponApplyName = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_CouponApplyBG", self._static_CouponApplyBG, "InGameShopBuy_CouponName")
  self._btn_CouponCancel = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_CouponCancel", self._static_CouponApplyBG, "InGameShopBuy_CouponCancel")
  self._txt_CouponApplyIcon = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_CouponApplyIcon", self._static_CouponApplyBG, "InGameShopBuy_CouponIcon")
  self._txt_CouponApplyIcon:SetPosX(0)
  self._txt_CouponApplyIcon:SetPosY(0)
  self._btn_CouponCancel:ComputePos()
  self._btn_CouponCancel:addInputEvent("Mouse_LUp", "FGlobal_IngameShopBuy_Update(false, 1)")
  self._static_GiftListBG:SetPosY(200)
  self._static_GiftListBG:SetSize(self._static_GiftListBG:GetSizeX(), 375)
  self._static_GiftListTopBG:SetPosY(205)
  self._static_GiftListTopBG:SetSize(self._static_GiftListTopBG:GetSizeX(), 90)
  self._static_GiftListTopBG:addInputEvent("Mouse_UpScroll", "Scroll_GiftTopList( true )")
  self._static_GiftListTopBG:addInputEvent("Mouse_DownScroll", "Scroll_GiftTopList( false )")
  self._static_GiftListMiddleBG:SetPosY(300)
  self._static_GiftListMiddleBG:SetSize(self._static_GiftListMiddleBG:GetSizeX(), 50)
  self.icon_Pearl:SetText("0")
  for giftIdx = 0, self._config._giftTopListMaxCount - 1 do
    local slot = {}
    slot.name = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_GiftListName", self._static_GiftListTopBG, "GiftTopListName_" .. giftIdx)
    slot.count = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Edit_GiftListBuyCount", slot.name, "GiftTopListCountBox_" .. giftIdx)
    slot.btnPlus = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_GiftListCountPlus", slot.count, "GiftTopList_BtnPlus_" .. giftIdx)
    slot.btnMinus = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_GiftListCountMinus", slot.count, "GiftTopList_BtnMinus_" .. giftIdx)
    slot.btnDelete = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_GiftListDelete", slot.count, "GiftTopList_BtnDelete_" .. giftIdx)
    slot.name:SetSpanSize(10, 5 + (5 + slot.name:GetSizeY() * giftIdx))
    slot.count:SetSpanSize(252, -2)
    slot.btnPlus:SetSpanSize(slot.count:GetSizeX() + 3, 5)
    slot.btnMinus:SetSpanSize(slot.btnPlus:GetSpanSize().x + slot.btnMinus:GetSizeX() + 2, 5)
    slot.btnDelete:SetSpanSize(slot.btnMinus:GetSpanSize().x + slot.btnDelete:GetSizeX() + 2, 5)
    slot.btnPlus:SetAutoDisableTime(0)
    slot.btnMinus:SetAutoDisableTime(0)
    slot.btnDelete:SetAutoDisableTime(0)
    slot.count:SetIgnore(true)
    slot.name:addInputEvent("Mouse_UpScroll", "Scroll_GiftTopList( true )")
    slot.name:addInputEvent("Mouse_DownScroll", "Scroll_GiftTopList( false )")
    slot.count:addInputEvent("Mouse_UpScroll", "Scroll_GiftTopList( true )")
    slot.count:addInputEvent("Mouse_DownScroll", "Scroll_GiftTopList( false )")
    slot.btnPlus:addInputEvent("Mouse_UpScroll", "Scroll_GiftTopList( true )")
    slot.btnPlus:addInputEvent("Mouse_DownScroll", "Scroll_GiftTopList( false )")
    slot.btnMinus:addInputEvent("Mouse_UpScroll", "Scroll_GiftTopList( true )")
    slot.btnMinus:addInputEvent("Mouse_DownScroll", "Scroll_GiftTopList( false )")
    slot.btnDelete:addInputEvent("Mouse_UpScroll", "Scroll_GiftTopList( true )")
    slot.btnDelete:addInputEvent("Mouse_DownScroll", "Scroll_GiftTopList( false )")
    self.giftTopList[giftIdx] = slot
  end
  Panel_IngameCashShop_BuyOrGift:RemoveControl(self._scroll_GiftTopList)
  Panel_IngameCashShop_BuyOrGift:RemoveControl(self._static_GiftList_NonUser)
  self._static_GiftListTopBG:AddChild(self._scroll_GiftTopList)
  self._static_GiftListTopBG:AddChild(self._static_GiftList_NonUser)
  self._static_GiftList_NonUser:SetTextMode(__eTextMode_AutoWrap)
  self._static_GiftList_NonUser:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_BUYORGIFT_NONUSER"))
  self._scroll_GiftTopList:SetSize(self._scroll_GiftTopList:GetSizeX(), self._static_GiftListTopBG:GetSizeY() - 10)
  self._scroll_GiftTopList:ComputePos()
  self._static_GiftListBotBG:SetPosY(355)
  self._static_GiftListBotBG:SetSize(self._static_GiftListBotBG:GetSizeX(), 175)
  self._static_GiftListBotBG:addInputEvent("Mouse_UpScroll", "Scroll_GiftBotList( true )")
  self._static_GiftListBotBG:addInputEvent("Mouse_DownScroll", "Scroll_GiftBotList( false )")
  for giftBotIdx = 0, self._config._giftBotListMaxCount - 1 do
    local slot = {}
    slot.name = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "StaticText_GiftListName", self._static_GiftListBotBG, "GiftBotListName_" .. giftBotIdx)
    slot.btnAdd = UI.createAndCopyBasePropertyControl(Panel_IngameCashShop_BuyOrGift, "Button_AddList", slot.name, "GiftBotListAddList_" .. giftBotIdx)
    slot.name:SetSpanSize(10, 35 + (5 + slot.name:GetSizeY() * giftBotIdx))
    slot.btnAdd:SetSpanSize(307, -3)
    slot.name:addInputEvent("Mouse_UpScroll", "Scroll_GiftBotList( true )")
    slot.name:addInputEvent("Mouse_DownScroll", "Scroll_GiftBotList( false )")
    slot.btnAdd:addInputEvent("Mouse_UpScroll", "Scroll_GiftBotList( true )")
    slot.btnAdd:addInputEvent("Mouse_DownScroll", "Scroll_GiftBotList( false )")
    self.giftBotList[giftBotIdx] = slot
  end
  Panel_IngameCashShop_BuyOrGift:RemoveControl(self._buttonFriendList)
  Panel_IngameCashShop_BuyOrGift:RemoveControl(self._buttonGuildList)
  Panel_IngameCashShop_BuyOrGift:RemoveControl(self._scroll_GiftBotList)
  self._static_GiftListBotBG:AddChild(self._buttonFriendList)
  self._static_GiftListBotBG:AddChild(self._buttonGuildList)
  self._static_GiftListBotBG:AddChild(self._scroll_GiftBotList)
  self._scroll_GiftBotList:SetSize(self._scroll_GiftBotList:GetSizeX(), self._static_GiftListBotBG:GetSizeY() - 55)
  local buttonSizeX = self._buttonFriendList:GetTextSizeX()
  if buttonSizeX < self._buttonGuildList:GetTextSizeX() then
    buttonSizeX = self._buttonGuildList:GetTextSizeX()
  end
  self._buttonFriendList:SetSize(buttonSizeX + 10, self._buttonFriendList:GetSizeY())
  self._buttonGuildList:SetSize(buttonSizeX + 10, self._buttonFriendList:GetSizeY())
  self._buttonGuildList:SetSpanSize(self._buttonFriendList:GetSizeX() + 8, self._buttonGuildList:GetSpanSize().y)
  self._buttonFriendList:ComputePos()
  self._buttonGuildList:ComputePos()
  self._scroll_GiftBotList:ComputePos()
  self._txt_PearlIconPrice:SetPosX(0)
  self._txt_PearlIconPrice:SetPosY(0)
  self._radioButtonSelectPearl = UI.getChildControl(Panel_IngameCashShop_BuyOrGift, "Radiobutton_InmyPearl")
  self._static_Caution:SetShow(false)
  UIScroll.InputEvent(inGameShopBuy._scroll_GiftBotList, "Scroll_GiftBotList")
  UIScroll.InputEvent(inGameShopBuy._scroll_GiftTopList, "Scroll_GiftTopList")
  self.savedProductCount = 1
  if true == _ContentsGroup_GuildGiveaway then
    local slot = {bg = nil, itemEnchantKeyRaw = 0}
    slot.bg = UI.getChildControl(self._stc_guildGiveawayItemBG, "Static_Slot")
    SlotItem.new(slot, "GuildGiveawayItem", 0, slot.bg, self._itemSlotConfig)
    slot:createChild()
    slot.icon:SetPosX(0)
    slot.icon:SetPosY(0)
    slot.icon:SetShow(true)
    slot.icon:addInputEvent("Mouse_On", "InGameShopBuy_ShowGuildGiveawayItemToolTip(true, nil)")
    slot.icon:addInputEvent("Mouse_Out", "InGameShopBuy_ShowGuildGiveawayItemToolTip(false, nil)")
    self._guildGiveawayItemSlot = slot
    self._guildGiveawayItemSlots = {}
    local baseSlot = UI.getChildControl(self._stc_guildGiveawayItemsBG, "Static_Slot")
    for ii = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
      local slot = {bg = nil, itemEnchantKeyRaw = 0}
      slot.bg = UI.cloneControl(baseSlot, self._stc_guildGiveawayItemsBG, "GuildGiveawayItemBG_" .. ii)
      slot.bg:SetShow(false)
      SlotItem.new(slot, "GuildGiveawayItem_" .. ii, ii, slot.bg, self._itemSlotConfig)
      slot:createChild()
      slot.icon:SetPosX(0)
      slot.icon:SetPosY(0)
      slot.icon:SetShow(true)
      slot.icon:addInputEvent("Mouse_On", "InGameShopBuy_ShowGuildGiveawayItemToolTip(true, " .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "InGameShopBuy_ShowGuildGiveawayItemToolTip(false, nil)")
      self._guildGiveawayItemSlots[ii] = slot
    end
    UI.deleteControl(baseSlot)
    self._guildGiveawayItemsBgSizeX = self._stc_guildGiveawayItemsBG:GetSizeX()
    self._guildGiveawayItemsBgSizeY = self._stc_guildGiveawayItemsBG:GetSizeY()
  end
  self._static_ItemIcon:SetPosX(self._static_ItemIconBG:GetPosX() + (self._static_ItemIconBG:GetSizeX() - self._static_ItemIcon:GetSizeX()) / 2)
  self._static_ItemIcon:SetPosY(self._static_ItemIconBG:GetPosY() + (self._static_ItemIconBG:GetSizeY() - self._static_ItemIcon:GetSizeY()) / 2)
end
function inGameShopBuy:registMessageHandler()
  self._button_Close:addInputEvent("Mouse_LUp", "InGameShopBuy_Close()")
  self._button_Confirm:addInputEvent("Mouse_LUp", "InGameShopBuy_ConfirmMSG()")
  self._button_Cancle:addInputEvent("Mouse_LUp", "InGameShopBuy_Close()")
  self._button_AddUser:addInputEvent("Mouse_LUp", "InGameShopBuy_CheckAddUser()")
  self._edit_Gift:addInputEvent("Mouse_LUp", "HandelClicked_InGameShopBuy_SetAddUser()")
  self._buttonFriendList:addInputEvent("Mouse_LUp", "HandelClicked_InGameShopBuy_FriendGuild()")
  self._buttonGuildList:addInputEvent("Mouse_LUp", "HandelClicked_InGameShopBuy_FriendGuild()")
end
function inGameShopBuy:registEventHandler()
  registerEvent("FromClient_NotifyCompleteBuyProduct", "FromClient_NotifyCompleteBuyProduct")
  registerEvent("FromClient_IncashshopGetUserNickName", "FromClient_IncashshopGetUserNickName")
end
function inGameShopBuy:updateByEventCart()
  self._static_Price:SetLineRender(false)
  self._txt_PearlIconPrice:SetLineRender(false)
  self._static_DiscountPrice:SetShow(false)
  self._txt_DiscountDirection:SetShow(false)
  self._static_CouponApplyBG:SetShow(false)
  self._txt_CouponApplyIcon:SetShow(false)
  self._btn_CouponCancel:SetShow(false)
  self._txt_PearlIconPrice:SetFontColor(UI_color.C_FFEFEFEF)
  self.savedCouponApply = false
  self._stc_MoneyArea:SetShow(false)
  for ii = 0, self._slotCount - 1 do
    local slot = self._slots[ii]
    slot._itemRaw = 0
    slot._itemCount = 0
    slot.iconBG:SetShow(false)
  end
  local eventCartProductCount = getIngameCashMall():getEventCartListCount(self._currentSelectedEventTab)
  local itemListCount = 0
  local nextProductCount = 0
  local realCount = 0
  local lastCashProduct
  if eventCartProductCount >= 8 then
    self._addSizeY = 46
  else
    self._addSizeY = 0
  end
  for jj = 0, eventCartProductCount - 1 do
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(getIngameCashMall():getEventCartListByIndex(jj, self._currentSelectedEventTab))
    if nil == cashProduct then
      return
    end
    nextProductCount = cashProduct:getItemListCount() + itemListCount
    for ii = itemListCount, nextProductCount - 1 do
      local item = cashProduct:getItemByIndex(ii - itemListCount)
      local itemCount = cashProduct:getItemCountByIndex(ii - itemListCount)
      local index = -1
      local slot
      for kk = 0, realCount do
        slot = self._slots[kk]
        if slot._itemRaw == item:get()._key:get() then
          index = kk
          break
        end
      end
      if index >= 0 then
        slot = self._slots[index]
        slot._itemCount = slot._itemCount + itemCount
        slot.icon:SetText(tostring(slot._itemCount))
      else
        slot = self._slots[realCount]
        slot.icon:ChangeTextureInfoNameAsync("icon/" .. item:getIconPath())
        slot.icon:addInputEvent("Mouse_On", "InGameShopBuy_ShowEventCartItemToolTip( true, " .. getIngameCashMall():getEventCartListByIndex(jj, self._currentSelectedEventTab) .. "," .. realCount .. "," .. ii - itemListCount .. " )")
        slot.icon:addInputEvent("Mouse_Out", "InGameShopBuy_ShowEventCartItemToolTip( false, " .. getIngameCashMall():getEventCartListByIndex(jj, self._currentSelectedEventTab) .. "," .. realCount .. "," .. ii - itemListCount .. " )")
        slot.icon:SetText(tostring(itemCount))
        slot._itemCount = itemCount
        slot._itemRaw = item:get()._key:get()
        slot.iconBG:SetShow(true)
        realCount = realCount + 1
      end
    end
    itemListCount = nextProductCount
    lastCashProduct = cashProduct
  end
  InGameShopBuy_ChangeMoneyIconTexture(lastCashProduct:getMainCategory(), lastCashProduct:isMoneyPrice())
  local giftGap = 0
  self._static_Gift:SetShow(false)
  self._edit_Gift:SetShow(false)
  if self._isGift then
    self._static_Gift:SetShow(true)
    self._edit_Gift:SetShow(true)
    self._edit_Gift:SetIgnore(false)
    self._edit_Gift:SetEnable(true)
    self._edit_Gift:SetDisableColor(false)
    giftGap = self._config._sizeGift
  end
  local buyConfig = self._config._buy
  self._static_BuyLineBG:SetPosX(buyConfig._startX)
  self._static_BuyLineBG:SetPosY(buyConfig._startY + buyConfig._gapX + 30 + noticeSizeY + self._addSizeY)
  if self._isGift then
    self._static_BuyLineBG:SetShow(false)
    self._static_LeftBG:SetSize(self._static_LeftBG:GetSizeX(), buyConfig._startY + buyConfig._gapX + noticeSizeY + self._addSizeY)
    Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), 620 + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_GiftListBG:SetPosY(200 + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_GiftListTopBG:SetPosY(205 + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_GiftListMiddleBG:SetPosY(300 + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_GiftListBotBG:SetPosY(355 + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_GiftListBG:SetShow(true)
    self._static_GiftListTopBG:SetShow(true)
    self._static_GiftListMiddleBG:SetShow(true)
    self._static_GiftListBotBG:SetShow(true)
    self._button_AddUser:SetShow(true)
    self._static_PearlBG:SetShow(false)
    self._txt_PearlIconPrice:SetShow(false)
    self._static_PearlIcon:SetShow(false)
    inGameShopBuy:AddedListUpdate()
    inGameShopBuy:UserListUpdate()
  else
    self._static_LeftBG:SetSize(self._static_LeftBG:GetSizeX(), buyConfig._startY + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_PearlBG:SetPosY(260 + noticeSizeY + self._addSizeY)
    self._static_PearlBG:SetSize(self._static_GiftListBG:GetSizeX(), 30)
    self._static_CouponApplyBG:SetPosY(self._static_PearlBG:GetPosY() + 10)
    self._txt_CouponApplyIcon:ComputePos()
    local couponBGSizeX = self._static_CouponApplyBG:GetSizeX()
    Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), buyConfig._startY + buyConfig._gapX + self._config._sizePanel + self._static_PearlBG:GetSizeY() + 40 + noticeSizeY + self._addSizeY)
    local pearlIconPriceByCoupon = self._static_PearlBG:GetPosY() + self._static_PearlBG:GetSizeY() / 2 - self._txt_PearlIconPrice:GetSizeY() / 2
    self._static_PearlBG:SetShow(true)
    self._static_GiftListBG:SetShow(false)
    self._static_GiftListTopBG:SetShow(false)
    self._static_GiftListBotBG:SetShow(false)
    self._static_GiftListMiddleBG:SetShow(false)
    self._button_AddUser:SetShow(false)
    self._txt_PearlIconPrice:SetShow(true)
    self.savedCouponDiscountTextSizeX = 0
    self._txt_DiscountDirection:SetPosY(pearlIconPriceByCoupon + 7)
    local pearIconTextPosX = couponBGSizeX - couponBGSizeX / 2 - self._txt_PearlIconPrice:GetTextSizeX() / 2 - self.savedCouponDiscountTextSizeX
    self._txt_PearlIconPrice:SetPosX(pearIconTextPosX)
    self._txt_PearlIconPrice:SetPosY(pearlIconPriceByCoupon)
    self._static_DiscountPrice:SetPosX(self._txt_PearlIconPrice:GetPosX() + self._txt_PearlIconPrice:GetTextSizeX() + self._static_DiscountPrice:GetTextSizeX() + 60)
    self._static_DiscountPrice:SetPosY(pearlIconPriceByCoupon)
    self._radioButtonSelectPearl:SetShow(false)
    local pearlIconPriceByCoupon = self._static_PearlBG:GetPosY() + self._static_PearlBG:GetSizeY() / 2 - self._txt_PearlIconPrice:GetSizeY() / 2
    FGlobal_IngameCashShop_BuyOrGift(0, 0)
  end
  self._static_Gift:ComputePos()
  self._edit_Gift:ComputePos()
  self._button_AddUser:ComputePos()
  self._button_Confirm:ComputePos()
  self._button_Cancle:ComputePos()
end
local territoryKeyToWaypointKey = {
  [0] = 1,
  [1] = 301,
  [2] = 601,
  [3] = 1101,
  [4] = 1301,
  [6] = 1623,
  [5] = 1395,
  [7] = 1649,
  [8] = 1691
}
function inGameShopBuy:update(isCouponApply)
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  self._static_Price:SetLineRender(false)
  self._txt_PearlIconPrice:SetLineRender(false)
  self._static_DiscountPrice:SetShow(false)
  self._txt_DiscountDirection:SetShow(false)
  self._static_CouponApplyBG:SetShow(false)
  self._txt_CouponApplyIcon:SetShow(false)
  self._btn_CouponCancel:SetShow(false)
  self._txt_PearlIconPrice:SetFontColor(UI_color.C_FFEFEFEF)
  self.savedCouponApply = isCouponApply
  self._static_ItemIcon:ChangeTextureInfoNameAsync("Icon/" .. cashProduct:getIconPath())
  self._static_ItemName:SetTextMode(__eTextMode_AutoWrap)
  local sumPrice = cashProduct:getPrice() * toInt64(0, self.savedProductCount)
  self._static_ItemName:SetText(cashProduct:getName())
  self._static_Price:SetText(makeDotMoney(sumPrice))
  self._txt_PearlIconPrice:SetText(makeDotMoney(sumPrice))
  self._discountPrice_s64 = toInt64(0, 0)
  InGameShopBuy_ChangeMoneyIconTexture(cashProduct:getMainCategory(), cashProduct:isMoneyPrice())
  for ii = 0, self._slotCount - 1 do
    local slot = self._slots[ii]
    slot.iconBG:SetShow(false)
  end
  local itemListCount = cashProduct:getItemListCount()
  for ii = 0, itemListCount - 1 do
    local slot = self._slots[ii]
    local item = cashProduct:getItemByIndex(ii)
    local itemCount = cashProduct:getItemCountByIndex(ii)
    local itemGrade = item:getGradeType()
    slot.icon:ChangeTextureInfoNameAsync("icon/" .. item:getIconPath())
    slot.icon:addInputEvent("Mouse_On", "InGameShopBuy_ShowItemToolTip( true, " .. ii .. " )")
    slot.icon:addInputEvent("Mouse_Out", "InGameShopBuy_ShowItemToolTip( false, " .. ii .. " )")
    slot.icon:SetText(tostring(itemCount))
    slot.iconBG:SetShow(true)
  end
  local subItemListCount = itemListCount + cashProduct:getSubItemListCount()
  for ii = itemListCount, subItemListCount - 1 do
    local slot = self._slots[ii]
    local item = cashProduct:getSubItemByIndex(ii - itemListCount)
    local itemCount = cashProduct:getSubItemCountByIndex(ii - itemListCount)
    local itemGrade = item:getGradeType()
    slot.icon:ChangeTextureInfoNameAsync("icon/" .. item:getIconPath())
    slot.icon:addInputEvent("Mouse_On", "InGameShopBuy_ShowSubItemToolTip( true, " .. ii - itemListCount .. " )")
    slot.icon:addInputEvent("Mouse_Out", "InGameShopBuy_ShowSubItemToolTip( false, " .. ii - itemListCount .. " )")
    slot.icon:SetText(tostring(itemCount))
    slot.iconBG:SetShow(true)
  end
  if subItemListCount > 8 then
    self._addSizeY = 46
  else
    self._addSizeY = 0
  end
  if cashProduct:isChooseCash() then
    local checklist = FGlobal_IngameCashShopCashCheckList_ReturnValue()
    if nil == checklist then
      return
    end
    local validChooseCashProduct = cashProduct:chooseCashCount()
    local chooseStartCount = subItemListCount
    local chooseCount = 0
    local indexList = Array.new()
    for ll = 0, validChooseCashProduct - 1 do
      if checklist[ll] > 0 then
        indexList[chooseCount] = {
          [0] = ll,
          [1] = checklist[ll]
        }
        chooseCount = chooseCount + 1
      end
    end
    if chooseStartCount + chooseCount > 8 then
      self._addSizeY = 46
    end
    for jj = 0, chooseCount - 1 do
      local chooseCashProduct = cashProduct:getChooseCashByIndex(indexList[jj][0])
      local itemListCount = chooseCashProduct:getItemListCount() + chooseStartCount
      for ii = chooseStartCount, itemListCount - 1 do
        local slot = self._slots[ii]
        local item = chooseCashProduct:getItemByIndex(ii - chooseStartCount)
        local itemCount = chooseCashProduct:getItemCountByIndex(ii - chooseStartCount) * toInt64(0, indexList[jj][1])
        local itemGrade = item:getGradeType()
        slot.icon:ChangeTextureInfoNameAsync("icon/" .. item:getIconPath())
        slot.icon:addInputEvent("Mouse_On", "InGameShopBuy_ShowChooseItemToolTip( true, " .. indexList[jj][0] .. ", " .. chooseStartCount .. ", " .. ii .. " )")
        slot.icon:addInputEvent("Mouse_Out", "InGameShopBuy_ShowChooseItemToolTip( false )")
        slot.icon:SetText(tostring(itemCount))
        slot.iconBG:SetShow(true)
      end
      chooseStartCount = itemListCount
    end
  end
  self:updateGuildGiveaway(cashProduct)
  local giftGap = 0
  self._static_Gift:SetShow(false)
  self._edit_Gift:SetShow(false)
  if self._isGift then
    self._static_Gift:SetShow(true)
    self._edit_Gift:SetShow(true)
    self._edit_Gift:SetIgnore(false)
    self._edit_Gift:SetEnable(true)
    self._edit_Gift:SetDisableColor(false)
    giftGap = self._config._sizeGift
  end
  local buyConfig = self._config._buy
  self._static_BuyLineBG:SetPosX(buyConfig._startX)
  self._static_BuyLineBG:SetPosY(buyConfig._startY + buyConfig._gapX + 30 + noticeSizeY + self._addSizeY)
  if self._isGift then
    self._static_BuyLineBG:SetShow(false)
    self._static_LeftBG:SetSize(self._static_LeftBG:GetSizeX(), 130 + noticeSizeY + self._addSizeY)
    Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), 620 + noticeSizeY + self._addSizeY)
    self._static_GiftListBG:SetPosY(200 + noticeSizeY + self._addSizeY)
    self._static_GiftListTopBG:SetPosY(205 + noticeSizeY + self._addSizeY)
    self._static_GiftListMiddleBG:SetPosY(300 + noticeSizeY + self._addSizeY)
    self._static_GiftListBotBG:SetPosY(355 + noticeSizeY + self._addSizeY)
    self._static_GiftListBG:SetShow(true)
    self._static_GiftListTopBG:SetShow(true)
    self._static_GiftListMiddleBG:SetShow(true)
    self._static_GiftListBotBG:SetShow(true)
    self._button_AddUser:SetShow(true)
    self._static_PearlBG:SetShow(false)
    self._txt_PearlIconPrice:SetShow(false)
    self._static_PearlIcon:SetShow(false)
    inGameShopBuy:AddedListUpdate()
    inGameShopBuy:UserListUpdate()
    if false == ToClient_canGiftPearlProductCharacterName() then
      self._static_Gift:SetShow(false)
      self._edit_Gift:SetShow(false)
      self._button_AddUser:SetShow(false)
    end
  else
    self._static_BuyLineBG:SetShow(true)
    self._static_LeftBG:SetSize(self._static_LeftBG:GetSizeX(), buyConfig._startY + buyConfig._gapX + noticeSizeY + self._addSizeY)
    self._static_PearlBG:SetPosY(260 + noticeSizeY + self._addSizeY)
    if isCouponApply then
      self._static_PearlBG:SetSize(self._static_GiftListBG:GetSizeX(), 70)
    else
      self._static_PearlBG:SetSize(self._static_GiftListBG:GetSizeX(), 30)
    end
    self._static_CouponApplyBG:SetPosY(self._static_PearlBG:GetPosY() + 10)
    self._txt_CouponApplyIcon:ComputePos()
    local couponBGSizeX = self._static_CouponApplyBG:GetSizeX()
    Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), buyConfig._startY + buyConfig._gapX + self._config._sizePanel + self._static_PearlBG:GetSizeY() + giftGap + 40 + noticeSizeY + self._addSizeY)
    local pearlIconPriceByCoupon = self._static_PearlBG:GetPosY() + self._static_PearlBG:GetSizeY() / 2 - self._txt_PearlIconPrice:GetSizeY() / 2
    self._static_PearlBG:SetShow(true)
    self._static_GiftListBG:SetShow(false)
    self._static_GiftListTopBG:SetShow(false)
    self._static_GiftListBotBG:SetShow(false)
    self._static_GiftListMiddleBG:SetShow(false)
    self._button_AddUser:SetShow(false)
    self._txt_PearlIconPrice:SetShow(true)
    self.savedCouponDiscountTextSizeX = 0
    if isCouponApply and nil ~= isCouponApply then
      local couponIndex = FGlobal_IngameCashShopCoupon_ReturnValue()
      local couponWrapper = ToClient_GetCouponInfoWrapper(couponIndex)
      if nil == couponWrapper then
        return
      end
      local couponName = couponWrapper:getCouponName()
      local couponDiscountRate = couponWrapper:getCouponDisCountRate()
      local couponDiscountPearl = couponWrapper:getCouponDisCountPearl()
      local couponState = couponWrapper:getCouponState()
      local couponCategoryCheck = couponWrapper:checkCategory(cashProduct:getMainCategory(), cashProduct:getMiddleCategory(), cashProduct:getSmallCategory())
      local couponMaxDiscount = couponWrapper:getCouponMaxDisCountPearl()
      local couponMinProductPearl = couponWrapper:getCouponMinProductPearl()
      local isDiscountPearl = couponWrapper:isDisCountPearl()
      if not couponCategoryCheck and Panel_IngameCashShop_BuyOrGift:GetShow() then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_UNABLECOUPON"))
        self._static_PearlBG:SetSize(self._static_GiftListBG:GetSizeX(), 30)
        Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), buyConfig._startY + buyConfig._gapX + self._config._sizePanel + self._static_PearlBG:GetSizeY() + giftGap + 40 + noticeSizeY + self._addSizeY)
        local pearIconTextPosX = couponBGSizeX - couponBGSizeX / 2 - self._txt_PearlIconPrice:GetTextSizeX() / 2
        self._txt_PearlIconPrice:SetPosX(pearIconTextPosX)
        local couponCheckPearlIcon = self._static_PearlBG:GetPosY() + self._static_PearlBG:GetSizeY() / 2 - self._txt_PearlIconPrice:GetSizeY() / 2
        self._txt_PearlIconPrice:SetPosY(couponCheckPearlIcon)
        self._button_Confirm:ComputePos()
        self._button_Cancle:ComputePos()
        return
      end
      self.savedCouponDiscountRate = couponDiscountRate
      self._static_Price:SetLineRender(0 == couponState or 1 == couponState)
      self._txt_PearlIconPrice:SetLineRender(0 == couponState or 1 == couponState)
      self._txt_PearlIconPrice:SetFontColor(UI_color.C_FFC4BEBE)
      self._static_DiscountPrice:SetShow(true)
      self._txt_DiscountDirection:SetShow(true)
      local couponDiscountValue
      if false == isDiscountPearl then
        self.savedProductCount = 1
        couponDiscountValue = cashProduct:getPrice() * toInt64(0, couponDiscountRate / 10000) / toInt64(0, 100)
        if couponMaxDiscount > toInt64(0, 0) then
          if couponMaxDiscount < couponDiscountValue then
            couponDiscountValue = couponMaxDiscount
            self._static_DiscountPrice:SetText(makeDotMoney(tostring(cashProduct:getPrice() - couponMaxDiscount)))
            self._txt_CouponApplyName:SetText(tostring(couponName) .. PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_LIMITMAXSALE"))
          else
            self._static_DiscountPrice:SetText(makeDotMoney(tostring(cashProduct:getPrice() - couponDiscountValue)))
            self._txt_CouponApplyName:SetText(tostring(couponName))
          end
        else
          self._static_DiscountPrice:SetText(makeDotMoney(tostring(cashProduct:getPrice() - couponDiscountValue)))
          self._txt_CouponApplyName:SetText(tostring(couponName))
        end
        self._static_Price:SetText(makeDotMoney(cashProduct:getPrice()))
        self._txt_PearlIconPrice:SetText(makeDotMoney(cashProduct:getPrice()))
        self._edit_count:SetText("1")
      else
        local productPrice = cashProduct:getPrice() * toInt64(0, self.savedProductCount)
        couponDiscountValue = productPrice - couponDiscountPearl
        if couponDiscountValue <= toInt64(0, 0) then
          couponDiscountValue = ToClient_MinCashProductPriceCoupon()
        end
        self._static_DiscountPrice:SetText(makeDotMoney(tostring(couponDiscountValue)))
        self._txt_CouponApplyName:SetText(tostring(couponName))
      end
      UI.setLimitTextAndAddTooltip(self._txt_CouponApplyName, self._txt_CouponApplyName:GetText(), "")
      self._txt_CouponApplyIcon:SetText("")
      self._discountPrice_s64 = cashProduct:getPrice() - couponDiscountValue
      if true == _ContentsGroup_PearlShopMileage and true == PaGlobal_CashMileage_IsOpenCheck() then
        PaGlobal_CashMileage_ChangeConsumePearl(self._discountPrice_s64)
      end
      if _ContentsGroup_PearlShopMoonBlessingRenew == true and PaGlobal_MoonBlessingRenew_IsOpenCheck() == true then
        PaGlobal_MoonBlessing_ChangeConsumePearl(self._discountPrice_s64)
      end
      self._txt_CouponApplyIcon:SetShow(true)
      self._btn_CouponCancel:SetShow(true)
      self._static_CouponApplyBG:SetShow(true)
      self._txt_CouponApplyName:SetShow(true)
      self.savedCouponDiscountTextSizeX = self._static_DiscountPrice:GetTextSizeX() + 30
      pearlIconPriceByCoupon = self._static_CouponApplyBG:GetPosY() + self._static_CouponApplyBG:GetSizeY() / 2 + self._txt_PearlIconPrice:GetSizeY()
    end
    self._txt_DiscountDirection:SetPosY(pearlIconPriceByCoupon + 7)
    local pearIconTextPosX = couponBGSizeX - couponBGSizeX / 2 - self._txt_PearlIconPrice:GetTextSizeX() / 2 - self.savedCouponDiscountTextSizeX
    self._txt_PearlIconPrice:SetPosX(pearIconTextPosX)
    self._txt_PearlIconPrice:SetPosY(pearlIconPriceByCoupon)
    self._static_DiscountPrice:SetPosX(self._txt_PearlIconPrice:GetPosX() + self._txt_PearlIconPrice:GetTextSizeX() + self._static_DiscountPrice:GetTextSizeX() + 60)
    self._static_DiscountPrice:SetPosY(pearlIconPriceByCoupon)
    FGlobal_IngameCashShop_BuyOrGift(cashProduct:getPrice(), cashProduct:getMainCategory())
  end
  if cashProduct:isMoneyPrice() then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    local territoryKeyRaw = regionInfo:getTerritoryKeyRaw()
    local waypointKey = territoryKeyToWaypointKey[territoryKeyRaw]
    local warehouseWrapper = warehouse_get(waypointKey)
    self._static_PearlBG:SetSize(self._static_PearlBG:GetSizeX(), self._static_PearlBG:GetSizeY() + 50)
    Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), Panel_IngameCashShop_BuyOrGift:GetSizeY() + 70)
    self._stc_MoneyArea:ComputePos()
    self._stc_MoneyArea:SetShow(true)
    local silverInInventory = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
    self._txt_MoneyValue:SetText(makeDotMoney(silverInInventory))
  else
    self._stc_MoneyArea:SetShow(false)
  end
  self._static_Gift:ComputePos()
  self._edit_Gift:ComputePos()
  self._button_AddUser:ComputePos()
  self._button_Confirm:ComputePos()
  self._button_Cancle:ComputePos()
end
function FGlobal_IngameCashShop_BuyOrGift(price, moneyType)
  local self = inGameShopBuy
  local buyConfig = self._config._buy
  if true == self._isGift or true == self._eventCart then
    self._radioButtonSelectPearl:SetCheck(false)
    Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), buyConfig._startY + buyConfig._gapX + self._config._sizePanel + self._static_PearlBG:GetSizeY() + 40 + noticeSizeY + self._addSizeY)
    return
  end
  self._radioButtonSelectPearl:SetShow(false)
  self._radioButtonSelectPearl:SetCheck(false)
  local guildGiveawayBG
  if true == self._stc_guildGiveawayItemBG:GetShow() then
    guildGiveawayBG = self._stc_guildGiveawayItemBG
  elseif true == self._stc_guildGiveawayItemsBG:GetShow() then
    guildGiveawayBG = self._stc_guildGiveawayItemsBG
  else
    guildGiveawayBG = nil
  end
  local addSizeY = 0
  if nil ~= guildGiveawayBG then
    local sizeY = guildGiveawayBG:GetSizeY()
    addSizeY = sizeY + 10
    local posY = self._static_PearlBG:GetPosY() + self._static_PearlBG:GetSizeY() + 10
    guildGiveawayBG:SetPosY(posY)
    self._txt_guildGiveawayDesc:SetPosY(posY + sizeY - self._txt_guildGiveawayDesc:GetSizeY())
  end
  Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), buyConfig._startY + buyConfig._gapX + self._config._sizePanel + self._static_PearlBG:GetSizeY() + 40 + addSizeY + noticeSizeY + self._addSizeY)
  self._static_Gift:ComputePos()
  self._edit_Gift:ComputePos()
  self._button_AddUser:ComputePos()
  self._button_Confirm:ComputePos()
  self._button_Cancle:ComputePos()
end
function FGlobal_IngameCashShop_BuyOrGift_ReturnCategoryValue()
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  return cashProduct:getMainCategory()
end
function FGlobal_IngameShopBuy_Update(isCouponApply)
  local self = inGameShopBuy
  InGameShopBuy_ResetCount(isCouponApply)
  if false == isCouponApply then
    IngameCashShopCoupon_Update(self._productNoRaw, self.savedProductCount)
    PaGlobalFunc_IngameCashShopCoupon_ResetValue()
  end
end
function inGameShopBuy:AddedListUpdate()
  for giftIdx = 0, self._config._giftTopListMaxCount - 1 do
    local slot = self.giftTopList[giftIdx]
    slot.name:SetShow(false)
  end
  self._config._giftTopListCount = getIngameCashMall():getGiftListCount()
  local uiIdx = 0
  for idx = self._config._giftTopListStart, self._config._giftTopListCount - 1 do
    if uiIdx <= self._config._giftTopListMaxCount - 1 then
      local slot = self.giftTopList[uiIdx]
      local data = getIngameCashMall():getGiftList(idx)
      slot.name:SetShow(true)
      slot.name:SetText(data:getName())
      slot.count:SetEditText(data:getCount(), true)
      slot.btnPlus:addInputEvent("Mouse_LUp", "HandleClicked_InGameShop_ChangeGiftCount( true, " .. idx .. " )")
      slot.btnMinus:addInputEvent("Mouse_LUp", "HandleClicked_InGameShop_ChangeGiftCount( false, " .. idx .. " )")
      if self._eventCart then
        slot.btnPlus:SetEnable(false)
        slot.btnMinus:SetEnable(false)
      else
        slot.btnPlus:SetEnable(true)
        slot.btnMinus:SetEnable(true)
      end
      slot.btnDelete:addInputEvent("Mouse_LUp", "HandleClicked_InGameShop_DeleteGiftList( " .. idx .. " )")
      uiIdx = uiIdx + 1
    end
    UIScroll.SetButtonSize(self._scroll_GiftTopList, self._config._giftTopListMaxCount, self._config._giftTopListCount)
  end
  self._static_GiftList_NonUser:SetShow(false)
  if 0 >= self._config._giftTopListCount then
    self._static_GiftList_NonUser:SetShow(true)
  end
  if self._config._giftTopListMaxCount < self._config._giftTopListCount then
    self._scroll_GiftTopList:SetShow(true)
  else
    self._scroll_GiftTopList:SetShow(false)
  end
end
function FGlobal_IngameCashShop_BuyOrGift_TotalPearlPrice()
  local self = inGameShopBuy
  local totalPearl = 0
  local pearlPrice = 0
  if self._eventCart then
    pearlPrice = Int64toInt32(FGlobal_IngameCashShopEventCart_TotalPriceByIndex(self._currentSelectedEventTab))
  else
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
    if nil == cashProduct then
      return
    end
    pearlPrice = Int64toInt32(cashProduct:getPrice())
  end
  for idx = 0, self._config._giftTopListCount - 1 do
    local data = getIngameCashMall():getGiftList(idx)
    for ii = 0, data:getCount() - 1 do
      totalPearl = totalPearl + pearlPrice
    end
  end
  self.icon_Pearl:SetText(makeDotMoney(totalPearl))
  if true == _ContentsGroup_PearlShopMileage and true == PaGlobal_CashMileage_IsOpenCheck() then
    PaGlobal_CashMileage_ChangeConsumePearl(totalPearl)
  end
  if _ContentsGroup_PearlShopMoonBlessingRenew == true and PaGlobal_MoonBlessingRenew_IsOpenCheck() == true then
    PaGlobal_MoonBlessing_ChangeConsumePearl(totalPearl)
  end
end
function inGameShopBuy:UserListUpdate()
  for giftBotIdx = 0, self._config._giftBotListMaxCount - 1 do
    local slot = self.giftBotList[giftBotIdx]
    slot.name:SetShow(false)
  end
  self.giftUserList = {}
  local userCount = 0
  local isFriend = self._buttonFriendList:IsCheck()
  if isFriend then
    local friendGroupCount
    friendGroupCount = RequestFriends_getFriendGroupCount()
    for groupIndex = 0, friendGroupCount - 1 do
      local friendGroup
      friendGroup = RequestFriends_getFriendGroupAt(groupIndex)
      local friendCount = friendGroup:getFriendCount()
      for friendIndex = 0, friendCount - 1 do
        local friendInfo = friendGroup:getFriendAt(friendIndex)
        local friendName = friendInfo:getName()
        if friendInfo:isOnline() then
        else
          local s64_lastLogoutTime = friendInfo:getLastLogoutTime_s64()
          friendName = friendName .. "(" .. convertStringFromDatetimeOverHour(s64_lastLogoutTime) .. ")"
        end
        self.giftUserList[userCount] = {
          name = friendInfo:getName(),
          userNo = friendInfo:getUserNo(),
          sendType = giftSendType.userNo
        }
        userCount = userCount + 1
      end
    end
  else
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if nil ~= myGuildListInfo then
      local memberCount = myGuildListInfo:getMemberCount()
      for index = 0, memberCount - 1 do
        local myGuildMemberInfo = myGuildListInfo:getMember(index)
        if nil ~= myGuildMemberInfo and not myGuildMemberInfo:isSelf() then
          local guildMemberName = ""
          if myGuildMemberInfo:isOnline() == true then
            guildMemberName = myGuildMemberInfo:getName()
          else
            local s64_lastLogoutTime = myGuildMemberInfo:getElapsedTimeAfterLogOut_s64()
            guildMemberName = myGuildMemberInfo:getName() .. "(" .. convertStringFromDatetimeOverHour(s64_lastLogoutTime) .. ")"
          end
          self.giftUserList[userCount] = {
            name = myGuildMemberInfo:getName(),
            userNo = myGuildMemberInfo:getUserNo(),
            sendType = giftSendType.userNo
          }
          userCount = userCount + 1
        end
      end
    end
  end
  self._config._giftBotListCount = userCount
  local uiIdx = 0
  for idx = self._config._giftBotListStart, self._config._giftBotListCount - 1 do
    if uiIdx <= self._config._giftBotListMaxCount - 1 then
      local slot = self.giftBotList[uiIdx]
      local data = self.giftUserList[idx]
      slot.name:SetShow(true)
      slot.name:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_BUYORGIFT_NAME_HAEDKEYWORD", "name", data.name))
      slot.btnAdd:addInputEvent("Mouse_LUp", "HandleClicked_AddGiftTopList( " .. idx .. " )")
      uiIdx = uiIdx + 1
    end
    UIScroll.SetButtonSize(self._scroll_GiftBotList, self._config._giftBotListMaxCount, self._config._giftBotListCount)
  end
  if self._config._giftBotListMaxCount - 1 < #self.giftUserList then
    self._scroll_GiftBotList:SetShow(true)
  else
    self._scroll_GiftBotList:SetShow(false)
  end
end
function inGameShopBuy:defaultPosition()
  local scrSizeX = getScreenSizeX()
  local scrSizeY = getScreenSizeY()
  local panelSizeX = Panel_IngameCashShop_BuyOrGift:GetSizeX()
  local panelSizeY = Panel_IngameCashShop_BuyOrGift:GetSizeY()
  Panel_IngameCashShop_BuyOrGift:SetPosX(scrSizeX / 2 - panelSizeX / 2)
  Panel_IngameCashShop_BuyOrGift:SetPosY(scrSizeY / 2 - panelSizeY / 2)
end
function inGameShopBuy:updateGuildGiveaway(cashProduct)
  self._stc_guildGiveawayItemBG:SetShow(false)
  self._stc_guildGiveawayItemsBG:SetShow(false)
  self._txt_guildGiveawayDesc:SetShow(false)
  if false == _ContentsGroup_GuildGiveaway then
    return
  end
  if nil == cashProduct then
    return
  end
  local key = cashProduct:getGuildGiveawayKey()
  if false == key:isDefined() then
    return
  end
  local listSize = ToClient_getGuildGiveawaySelectedListSize(key:get())
  if listSize <= 0 then
    return
  elseif 1 == listSize then
    self._stc_guildGiveawayItemBG:SetShow(true)
    local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(key:get(), 0)
    local itemCount = ToClient_getGuildGiveawaySelectedItemCount(key:get(), 0)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    local slot = self._guildGiveawayItemSlot
    if nil ~= itemSSW then
      slot:setItemByStaticStatus(itemSSW, itemCount)
      slot.itemEnchantKeyRaw = itemEnchantKey:get()
    else
      slot:clearItem()
    end
  else
    self._stc_guildGiveawayItemsBG:SetShow(true)
    local half = math.floor(__eGuildGiveawaySelectedItemMaxCount / 2)
    local baseSlot = self._guildGiveawayItemSlots[0].bg
    local itemBgSizeX = self._guildGiveawayItemsBgSizeX
    local itemBgSizeY = self._guildGiveawayItemsBgSizeY
    local initPosX = (itemBgSizeX - (baseSlot:GetSizeX() * half + 5 * (half - 1))) / 2
    local initPosY = -35
    if listSize > 5 then
      itemBgSizeY = itemBgSizeY + baseSlot:GetSizeY() + 5
      initPosY = initPosY + (itemBgSizeY - (2 * baseSlot:GetSizeY() + 5)) / 2
      for ii = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
        local slot = self._guildGiveawayItemSlots[ii]
        local col = ii % half
        local row = math.floor(ii / half)
        local posX = initPosX + (slot.bg:GetSizeX() + 5) * col
        local posY = initPosY + slot.bg:GetSizeY() * row + 5 * row
        local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(key:get(), ii)
        local itemCount = ToClient_getGuildGiveawaySelectedItemCount(key:get(), ii)
        local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
        if nil ~= itemSSW then
          slot:setItemByStaticStatus(itemSSW, itemCount)
          slot.itemEnchantKeyRaw = itemEnchantKey:get()
          slot.bg:SetPosX(posX)
          slot.bg:SetPosY(posY)
        else
          slot:clearItem()
          slot.itemEnchantKeyRaw = 0
        end
        slot.bg:SetShow(true)
      end
    else
      initPosY = initPosY + (itemBgSizeY - baseSlot:GetSizeY()) / 2
      for ii = 0, __eGuildGiveawaySelectedItemMaxCount - 1 do
        local slot = self._guildGiveawayItemSlots[ii]
        local col = ii % half
        local row = math.floor(ii / half)
        local posX = initPosX + (slot.bg:GetSizeX() + 5) * col
        local posY = initPosY + slot.bg:GetSizeY() * row + 5 * row
        local itemEnchantKey = ToClient_getGuildGiveawaySelectedItemEnchantKey(key:get(), ii)
        local itemCount = ToClient_getGuildGiveawaySelectedItemCount(key:get(), ii)
        local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
        if nil ~= itemSSW then
          slot:setItemByStaticStatus(itemSSW, itemCount)
          slot.itemEnchantKeyRaw = itemEnchantKey:get()
          slot.bg:SetPosX(posX)
          slot.bg:SetPosY(posY)
        else
          slot:clearItem()
          slot.itemEnchantKeyRaw = 0
        end
        slot.bg:SetShow(ii < 5)
      end
    end
    self._stc_guildGiveawayItemsBG:SetSize(itemBgSizeX, itemBgSizeY)
  end
  self._txt_guildGiveawayDesc:SetShow(true)
end
function InGameShopBuy_ConfirmMSG()
  local self = inGameShopBuy
  if inGameShopBuy._eventCart then
    InGameShopBuy_ConfirmEventCart()
    return
  end
  if not inGameShopBuy._isGift then
    InGameShopBuy_CouponCheck_BeforeConfirm()
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(inGameShopBuy._productNoRaw)
  if nil == cashProduct then
    return
  end
  local userCount = inGameShopBuy._config._giftTopListCount
  if userCount <= 0 then
    local msg = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_BUYORGIFT_MUST_SELECT_USER")
    Proc_ShowMessage_Ack(msg)
    return
  end
  local itemCount = 0
  for idx = self._config._giftTopListStart, self._config._giftTopListCount - 1 do
    local giftlist = getIngameCashMall():getGiftList(idx)
    if nil ~= giftlist then
      itemCount = giftlist:getCount()
      break
    end
  end
  if true == PaGlobal_CashShop_IsCheckHaveMeaning(cashProduct, itemCount) then
    return
  end
  local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
  local userName = inGameShopBuy.giftTopList[0].name:GetText()
  local messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_ONEPERSON_GIFT_CONFIRM", "userName", userName, "itemName", cashProduct:getName(), "itemCount", itemCount)
  if userCount > 1 then
    messageBoxMemo = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_GIFT_CONFIRM", "userName", userName, "countUser", userCount - 1, "itemName", cashProduct:getName(), "itemCount", itemCount)
  end
  if true == isJapan then
    local buyMethod = ""
    local priceMsg = ""
    if __ePriceType_Pearl == cashProduct:getProductPriceType() then
      buyMethod = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_PEARL")
      if true == self.savedCouponApply then
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", self._static_DiscountPrice:GetText(), "buyMethod", buyMethod)
      else
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", self.icon_Pearl:GetText(), "buyMethod", buyMethod)
      end
    elseif __ePriceType_Cash == cashProduct:getProductPriceType() then
      buyMethod = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DAUMCASH")
      if true == self.savedCouponApply then
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", self._static_DiscountPrice:GetText(), "buyMethod", buyMethod)
      else
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", self.icon_Pearl:GetText(), "buyMethod", buyMethod)
      end
    end
    if __ePriceType_Pearl == cashProduct:getProductPriceType() or __ePriceType_Cash == cashProduct:getProductPriceType() then
      messageBoxMemo = messageBoxMemo .. priceMsg .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_13")
    end
  end
  local messageBoxData = {
    title = messageBoxtitle,
    content = messageBoxMemo,
    functionYes = InGameShopBuy_Confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData, "middle")
end
function PaGlobal_CashShop_IsCheckHaveMeaning(cashProduct, itemCount)
  if false == Panel_IngameCashShop:GetShow() then
    return false
  end
  local self = inGameShopBuy
  local price = Defines.s64_const.s64_0
  local myMoney = Defines.s64_const.s64_0
  local messageTitle, messageBoxMemo
  local productCategory = 0
  local notPopup = false
  if __ePriceType_Cash == cashProduct:getProductPriceType() then
    myMoney = getSelfPlayer():get():getCash()
    price = cashProduct:getOriginalPrice()
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYCASHMEGBOX_TITLE")
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYCASHMEGBOX_DESC")
    productCategory = 0
  elseif __ePriceType_Pearl == cashProduct:getProductPriceType() then
    local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
    if nil ~= pearlItemWrapper then
      myMoney = pearlItemWrapper:get():getCount_s64()
    end
    price = cashProduct:getProductPrice()
    if Defines.s64_const.s64_0 < self._discountPrice_s64 then
      price = self._discountPrice_s64
    end
    messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_TITLE")
    messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYPEARLMEGBOX_DESC")
    productCategory = UI_CCC.eCashProductCategory_Pearl
  elseif __ePriceType_Sliver == cashProduct:getProductPriceType() then
    myMoney = InGameShopBuy_GetSliver()
    price = cashProduct:getProductPrice()
    notPopup = true
  end
  price = price * toInt64(0, itemCount)
  if myMoney < price and (true ~= cashProduct:isApplyDiscount() or not (myMoney >= cashProduct:getDiscountPrice())) then
    if false == notPopup then
      local function MessgeBox_Yes()
        if 0 == productCategory then
          InGameShop_BuyDaumCash()
        else
          local goCategory = PaGlobal_InGameShop_GetTabIndex(UI_CCC.eCashProductCategory_Pearl)
          PaGlobal_InGameShop_GoToTab(goCategory)
          InGameShop_TabEvent(goCategory)
          self._savedNotEnoughMoney = true
        end
        InGameShopDetailInfo_Close()
        InGameShopBuy_Close(true)
      end
      local messageBoxData = {
        title = messageTitle,
        content = messageBoxMemo,
        functionYes = MessgeBox_Yes,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    else
      local msg = PAGetString(Defines.StringSheet_GAME, "LUA_KNOWLEDGEMANAGEMENT_ACK_MAKEBOOK")
      Proc_ShowMessage_Ack(msg)
    end
    return true
  end
  return false
end
function InGameShopBuy_ConfirmEventCart()
  local self = inGameShopBuy
  if not self._isGift then
    FGlobal_IngameCashShopEventCart_Confirm(self._currentSelectedEventTab)
  else
    local userCount = inGameShopBuy._config._giftTopListCount
    if userCount <= 0 then
      local msg = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_BUYORGIFT_MUST_SELECT_USER")
      Proc_ShowMessage_Ack(msg)
      return
    end
    local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_BUYORGIFT_GIFT_CONFIRM", "countUser", userCount, "itemName", PAGetString(Defines.StringSheet_GAME, "LUA_EVENTCART_ITEM"))
    local messageBoxData = {
      title = messageBoxtitle,
      content = messageBoxMemo,
      functionYes = _InGameShopBuy_Confirm_EnoughMoneyForGiftEventCart,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  end
end
function _InGameShopBuy_Confirm_EnoughMoneyForGiftEventCart()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local isCreatePasword = selfPlayer:isPaymentPassword()
  if false == isCreatePasword then
    InGameShopBuy_GiftMyFriendEventCart()
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_GIFTMYFRIEND")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionApply = InGameShopBuy_GiftMyFriendEventCart,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function InGameShopBuy_GiftMyFriendEventCart()
  PaymentPassword(FGlobal_InGameShopBuy_GiftEventCart)
end
function FGlobal_InGameShopBuy_GiftEventCart()
  local self = inGameShopBuy
  FGlobal_IngameCashShopEventCartGift_Confirm(self._currentSelectedEventTab)
end
function InGameShopBuy_CouponCheck_BeforeConfirm()
  if nil == FGlobal_IngameCashShopCoupon_ReturnValue() and true == Panel_IngameCashShop_Coupon:GetShow() then
    local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_ALERTCOUPON")
    local messageBoxData = {
      title = messageBoxtitle,
      content = messageBoxMemo,
      functionYes = InGameShopBuy_Confirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
    return
  end
  InGameShopBuy_Confirm()
end
function InGameShopBuy_Confirm()
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local count = self._edit_count:GetText()
  if true == PaGlobal_CashShop_IsCheckHaveMeaning(cashProduct, count) then
    return
  end
  if not self._isGift then
    local haveCash, havePearl, haveMileage, money = InGameShop_UpdateCash()
    local isEnoughMoney = false
    if UI_CCC.eCashProductCategory_Pearl == cashProduct:getMainCategory() then
      isEnoughMoney = haveCash >= cashProduct:getPrice() * toInt64(0, count)
    elseif UI_CCC.eCashProductCategory_Mileage == cashProduct:getMainCategory() then
      isEnoughMoney = haveMileage >= cashProduct:getPrice() * toInt64(0, count)
    else
      isEnoughMoney = true
    end
    _InGameShopBuy_Confirm_EnoughMoney()
  else
    _InGameShopBuy_Confirm_EnoughMoneyForGift()
  end
  InGameShopDetailInfo_Close()
  InGameShopBuy_Close(true)
end
function InGameShopBuy_GiftMyFriend()
  PaymentPassword(FGlobal_InGameShopBuy_Gift)
end
function _InGameShopBuy_Confirm_LackMoney(category)
  local self = inGameShopBuy
  if CppEnums.CashProductCategory.eCashProductCategory_Mileage == category then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_LACKMONEY_ACK"))
    return
  end
  self._needMoneyType = category
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT")
  local messageBoxMemo = ""
  local moneyType = ""
  if CppEnums.CashProductCategory.eCashProductCategory_Pearl == category then
    moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DAUMCASH")
    if isNaver then
      moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_NAVERCASH")
    end
    if isGameTypeTR() then
      moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DAUMCASH_TR")
    elseif isGameTypeTH() then
      moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DAUMCASH_TH")
    elseif isGameTypeID() then
      moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DAUMCASH_ID")
    end
  elseif CppEnums.CashProductCategory.eCashProductCategory_Mileage == category then
    moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_MILEAGE")
  else
    moneyType = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_PEARL")
  end
  messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_MSGBOX", "moneyType", moneyType, "moneyType2", moneyType)
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = _InGameShopBuy_BuyMoney,
    functionNo = _InGameShopBuy_Confirm_Cancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function _InGameShopBuy_BuyMoney()
  local self = inGameShopBuy
  local category = self._needMoneyType
  if CppEnums.CashProductCategory.eCashProductCategory_Pearl == category then
    InGameShop_BuyDaumCash()
  elseif CppEnums.CashProductCategory.eCashProductCategory_Mileage == category then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_MILEAGE"))
  else
    InGameShop_BuyPearl()
  end
end
function _InGameShopBuy_Confirm_EnoughMoneyForGift()
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local isCreatePasword = selfPlayer:isPaymentPassword()
  if false == isCreatePasword then
    InGameShopBuy_GiftMyFriend()
  else
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_GIFTMYFRIEND")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionApply = InGameShopBuy_GiftMyFriend,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function _InGameShopBuy_Confirm_CheckMatchedClass()
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if cashProduct == nil then
    return false
  end
  if PaGlobalFunc_IngameCashShop_isActualUsableClass == nil then
    return false
  end
  return PaGlobalFunc_IngameCashShop_isActualUsableClass(cashProduct)
end
function _InGameShopBuy_Confirm_EnoughMoney()
  local isMatchedClass = _InGameShopBuy_Confirm_CheckMatchedClass()
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  if Panel_Addiction_Prevention_All ~= nil then
    PaGlobal_AddictionPrevent:prepareClose()
  end
  local limitType = cashProduct:getCashPurchaseLimitType()
  if UI_PLT.None ~= limitType then
    local mylimitCount = getIngameCashMall():getRemainingLimitCount(self._productNoRaw)
    if mylimitCount < 1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_PURCHASELIMIT"))
      return
    end
  end
  local count = tonumber(self._edit_count:GetText())
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_ALERT")
  local messageBoxMemo = ""
  local messageBoxData
  local addPearlComment = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_PURCHASELIMIT")
  local addmathClassString = ""
  if false == isMatchedClass then
    addmathClassString = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_MATHCLASS")
  end
  local addpearlMsg = ""
  local priceMsg = ""
  if true == isJapan then
    local buyMethod = ""
    if __ePriceType_Pearl == cashProduct:getProductPriceType() then
      buyMethod = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_PEARL")
      if true == self.savedCouponApply then
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", self._static_DiscountPrice:GetText(), "buyMethod", buyMethod)
      else
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", tostring(cashProduct:getPrice() * toInt64(0, count)), "buyMethod", buyMethod)
      end
    elseif __ePriceType_Cash == cashProduct:getProductPriceType() then
      buyMethod = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DAUMCASH")
      if true == self.savedCouponApply then
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", self._static_DiscountPrice:GetText(), "buyMethod", buyMethod)
      else
        priceMsg = "\n" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_14", "pearl", tostring(cashProduct:getPrice() * toInt64(0, count)), "buyMethod", buyMethod)
      end
    end
  end
  if UI_CCC.eCashProductCategory_Pearl == cashProduct:getMainCategory() then
    messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_REALBUY", "addmathClassString", addmathClassString, "getName", cashProduct:getName(), "count", count) .. priceMsg .. addPearlComment .. addpearlMsg
  elseif true == self._easyBuy then
    if true == self._immediatelyUse then
      messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_REALBUY", "addmathClassString", addmathClassString, "getName", cashProduct:getName(), "count", count) .. priceMsg .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_BUYORGIFT_EASYBUY") .. addpearlMsg
    else
      messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_REALBUY", "addmathClassString", addmathClassString, "getName", cashProduct:getName(), "count", count) .. priceMsg .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_BUYORGIFT_EASYBUY_NOT_IMMEDIATELYUSE") .. addpearlMsg
    end
  else
    messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_REALBUY", "addmathClassString", addmathClassString, "getName", cashProduct:getName(), "count", count) .. priceMsg .. "\n" .. addpearlMsg
  end
  if true == isJapan and (__ePriceType_Pearl == cashProduct:getProductPriceType() or __ePriceType_Cash == cashProduct:getProductPriceType()) then
    messageBoxMemo = messageBoxMemo .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_13")
  end
  messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = InGameShopBuy_ConfirmDo,
    functionNo = _InGameShopBuy_Confirm_Cancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function InGameShopBuy_ConfirmDo()
  audioPostEvent_SystemUi(16, 0)
  _AudioPostEvent_SystemUiForXBOX(16, 0)
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local count = tonumber(self._edit_count:GetText())
  local couponIndex = FGlobal_IngameCashShopCoupon_ReturnValue()
  local couponKey = 0
  local couponNo = toInt64(0, -1)
  if nil ~= couponIndex then
    local couponWrapper = ToClient_GetCouponInfoWrapper(couponIndex)
    local isPossibleCouponAPply = couponWrapper:checkCategory(cashProduct:getMainCategory(), cashProduct:getMiddleCategory(), cashProduct:getSmallCategory())
    if nil ~= couponWrapper then
      couponKey = couponWrapper:getCouponKey()
      couponNo = couponWrapper:getCouponNo()
    end
  end
  local isImmediatelyUse = false
  if true == self._easyBuy and true == self._immediatelyUse then
    isImmediatelyUse = CppEnums.BuyItemReqTrType.eBuyItemReqTrType_ImmediatelyUse
    count = 1
  else
    isImmediatelyUse = CppEnums.BuyItemReqTrType.eBuyItemReqTrType_None
  end
  local isValid = false
  if cashProduct:isChooseCash() then
    isValid = InGameShopBuy_CheckChooseProduct(cashProduct)
    if false == isValid then
      return
    end
  end
  local fromWhereType = CppEnums.ItemWhereType.eCount
  if cashProduct:isMoneyPrice() then
    if IngameCashShop_StartTerritory ~= selfPlayerCurrentTerritory() then
      local messageBoxData = {
        content = PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_TERRITORY_CHANGED"),
        functionApply = InGameShop_Close,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    fromWhereType = CppEnums.ItemWhereType.eMoneyInventory
  end
  ToClient_requestBuyItem(self._productNoRaw, count, cashProduct:getPrice(), isImmediatelyUse, couponNo, couponKey, fromWhereType, true, PaGlobal_EasyBuy.deleteItemWhereType, PaGlobal_EasyBuy.deleteItemSlotNo)
  InGameShopBuy_Close()
end
function InGameShopBuy_CheckChooseProduct(cashProduct)
  local checklist = FGlobal_IngameCashShopCashCheckList_ReturnValue()
  local validChooseCashProduct = cashProduct:chooseCashCount()
  local checkCount = 0
  for ii = 0, validChooseCashProduct - 1 do
    checkCount = checkCount + checklist[ii]
  end
  if checkCount ~= cashProduct:mustChooseCount() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOP_CHOOSECOUNTDIFFERENT"))
    return false
  end
  return true
end
function _InGameShopBuy_Confirm_Cancel()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUYCANCEL"))
  InGameShopBuy_Close()
end
function FGlobal_InGameShopBuy_Gift()
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(inGameShopBuy._productNoRaw)
  if nil == cashProduct then
    return
  end
  getIngameCashMall():requestBuyGiftForList(inGameShopBuy._productNoRaw)
  inGameShopBuy._scroll_GiftTopList:SetControlTop()
  inGameShopBuy:AddedListUpdate()
end
function InGameShopBuy_Count(isUp)
  local self = inGameShopBuy
  local count = tonumber(self._edit_count:GetText())
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local price = cashProduct:getPrice()
  if not isUp then
    if count <= 1 then
      return
    end
    count = count - 1
  else
    local maxBuyCount = InGameShopBuy_GetAndCheck_CashProductMaxCountByPrice(cashProduct)
    if false == getIngameCashMall():checkCashItemBuyMaxCount(self._productNoRaw, count + 1) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_OVER20"))
      return
    end
    local limitCount = cashProduct:getCashPurchaseCount()
    if limitCount > 0 then
      local mylimitCount = getIngameCashMall():getRemainingLimitCount(self._productNoRaw)
      if count >= mylimitCount then
        return
      end
      if maxBuyCount > toInt64(0, mylimitCount) then
        maxBuyCount = toInt64(0, mylimitCount)
      end
    end
    if count + 1 <= Int64toInt32(maxBuyCount) then
      count = count + 1
    end
  end
  OpenNumberPad_CashCountConfirm(toInt64(0, count), cashProduct)
end
function InGameShopBuy_GetAndCheck_CashProductMaxCountByPrice(cashProduct)
  if nil == cashProduct then
    return Defines.s64_const.s64_0
  end
  local self = inGameShopBuy
  local priceType = cashProduct:getProductPriceType()
  local price = cashProduct:getPrice()
  local maxCountPerPrice = Defines.s64_const.s64_0
  if __ePriceType_Cash == priceType then
    local selfProxy = getSelfPlayer():get()
    local cash = selfProxy:getCash()
    if Defines.s64_const.s64_0 ~= cash then
      maxCountPerPrice = cash / price
    end
  elseif __ePriceType_Pearl == priceType then
    local pearl = Defines.s64_const.s64_0
    local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
    if nil ~= pearlItemWrapper then
      pearl = pearlItemWrapper:get():getCount_s64()
    end
    if Defines.s64_const.s64_0 ~= pearl then
      maxCountPerPrice = pearl / price
    end
  elseif __ePriceType_Sliver == priceType then
    local silver = InGameShopBuy_GetSliver()
    if Defines.s64_const.s64_0 ~= silverInWarehouse then
      maxCountPerPrice = silver / price
    end
  elseif __ePriceType_Mileage == priceType then
    local mileage = Defines.s64_const.s64_0
    local mileageItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getMileageSlotNo())
    if nil ~= mileageItemWrapper then
      mileage = mileageItemWrapper:get():getCount_s64()
    end
    if Defines.s64_const.s64_0 ~= mileage then
      maxCountPerPrice = mileage / price
    end
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_MATHCLASS"))
    return Defines.s64_const.s64_0
  end
  return maxCountPerPrice
end
function OpenNumberPad_CashCount()
  local self = inGameShopBuy
  if true == self._immediatelyUse then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local maxCountPerPrice = InGameShopBuy_GetAndCheck_CashProductMaxCountByPrice(cashProduct)
  local maxCount = getIngameCashMall():getCashItemBuyMaxCount(self._productNoRaw)
  if maxCountPerPrice < maxCount then
    maxCount = maxCountPerPrice
  end
  if toInt64(0, 0) ~= maxCount then
    local limitCount = toInt64(0, cashProduct:getCashPurchaseCount())
    if limitCount > toInt64(0, 0) then
      local mylimitCount = toInt64(0, getIngameCashMall():getRemainingLimitCount(self._productNoRaw))
      if maxCount > mylimitCount then
        maxCount = mylimitCount
      end
    end
  else
    return
  end
  Panel_NumberPad_Show(true, maxCount, cashProduct, OpenNumberPad_CashCountConfirm)
end
function OpenNumberPad_CashCountConfirm(inputNumber, cashProduct)
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  self.savedProductCount = Int64toInt32(inputNumber)
  local price = cashProduct:getPrice()
  local sumPrice = Int64toInt32(price) * self.savedProductCount
  self._static_PearlBG:SetSize(self._static_GiftListBG:GetSizeX(), 30)
  Panel_IngameCashShop_BuyOrGift:SetSize(Panel_IngameCashShop_BuyOrGift:GetSizeX(), self._config._buy._startY + self._config._buy._gapX + self._config._sizePanel + self._static_PearlBG:GetSizeY() + 40)
  self._static_Price:SetLineRender(false)
  self._txt_PearlIconPrice:SetLineRender(false)
  self._txt_PearlIconPrice:SetFontColor(UI_color.C_FFEFEFEF)
  self._static_DiscountPrice:SetShow(false)
  self._txt_DiscountDirection:SetShow(false)
  self._static_CouponApplyBG:SetShow(false)
  self._txt_CouponApplyIcon:SetShow(false)
  self._btn_CouponCancel:SetShow(false)
  local couponBGSizeX = self._static_CouponApplyBG:GetSizeX()
  local pearIconTextPosX = couponBGSizeX - couponBGSizeX / 2 - self._txt_PearlIconPrice:GetTextSizeX() / 2
  self._txt_PearlIconPrice:SetPosX(pearIconTextPosX)
  self._txt_PearlIconPrice:SetPosY(self._static_PearlBG:GetPosY() + self._static_PearlBG:GetSizeY() / 2 - self._txt_PearlIconPrice:GetSizeY() / 2)
  self._txt_PearlIconPrice:SetText(makeDotMoney(sumPrice))
  if false == Panel_IngameCashShop_Coupon:GetShow() then
    local categoryType = cashProduct:getMainCategory()
    if UI_CCC.eCashProductCategory_Pearl ~= categoryType and UI_CCC.eCashProductCategory_Mileage ~= categoryType and false == cashProduct:isMoneyPrice() and false == cashProduct:getGuildGiveawayKey():isDefined() then
      IngameCashShopCoupon_Open(0, self._productNoRaw, self.savedProductCount)
    end
  else
    FGlobal_IngameCashShopCoupon_RefreshList(self._productNoRaw, self.savedProductCount)
    FGlobal_IngameCashShopCoupon_ReturnValueCancel()
  end
  FGlobal_IngameCashShop_BuyOrGift(sumPrice, cashProduct:getMainCategory())
  if true == _ContentsGroup_PearlShopMileage and true == PaGlobal_CashMileage_IsOpenCheck() then
    local categoryType = cashProduct:getMainCategory()
    if UI_CCC.eCashProductCategory_Pearl ~= categoryType and UI_CCC.eCashProductCategory_Mileage ~= categoryType and false == cashProduct:isMoneyPrice() then
      PaGlobal_CashMileage_ChangeConsumePearl(sumPrice)
    end
  end
  if _ContentsGroup_PearlShopMoonBlessingRenew == true and PaGlobal_MoonBlessingRenew_IsOpenCheck() == true then
    local categoryType = cashProduct:getMainCategory()
    if UI_CCC.eCashProductCategory_Pearl ~= categoryType and UI_CCC.eCashProductCategory_Mileage ~= categoryType and false == cashProduct:isMoneyPrice() then
      PaGlobal_MoonBlessing_ChangeConsumePearl(sumPrice)
    end
  end
  self._static_Price:SetText(makeDotMoney(sumPrice))
  self._edit_count:SetText(tostring(self.savedProductCount))
  self._button_Confirm:ComputePos()
  self._button_Cancle:ComputePos()
  self:update()
end
function InGameShopBuy_ResetCount(isCouponApply)
  local self = inGameShopBuy
  if nil == self._productNoRaw then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
  if nil == cashProduct then
    return
  end
  local couponIndex = FGlobal_IngameCashShopCoupon_ReturnValue()
  if nil ~= couponIndex and couponIndex > 0 then
    local count = 1
    local isDiscountPearl = false
    local couponWrapper = ToClient_GetCouponInfoWrapper(couponIndex)
    if nil ~= couponWrapper then
      isDiscountPearl = couponWrapper:isDisCountPearl()
      if false == isDiscountPearl and 1 < self.savedProductCount then
        self.savedProductCount = count
        local sumPrice = Int64toInt32(price) * count
        FGlobal_IngameCashShopCoupon_RefreshList_KeepSelect(self._productNoRaw, count)
        FGlobal_IngameCashShop_BuyOrGift(sumPrice, cashProduct:getMainCategory())
      end
    end
  end
  self:update(isCouponApply)
end
function InGameShopBuy_ChangeMoneyIconTexture(categoryIdx, isEnableSilver)
  local self = inGameShopBuy
  local icon = self._txt_PearlIconPrice
  local serviceContry, iconType
  if true == isGameTypeKorea() then
    serviceContry = contry.kr
  elseif true == isGameTypeJapan() then
    serviceContry = contry.jp
  elseif true == isGameTypeRussia() then
    serviceContry = contry.ru
  elseif true == _ContentsOption_CH_GameType then
    serviceContry = contry.kr2
  elseif true == isGameTypeNA() then
    serviceContry = contry.na
  elseif true == isGameTypeTR() then
    serviceContry = contry.tr
  elseif true == isGameTypeSA() then
    serviceContry = contry.sa
  elseif true == isGameTypeID() then
    serviceContry = contry.id
  else
    serviceContry = contry.kr
  end
  if true == isEnableSilver then
    iconType = cashIconType.silver
  elseif UI_CCC.eCashProductCategory_Pearl == categoryIdx then
    iconType = cashIconType.cash
  elseif UI_CCC.eCashProductCategory_Mileage == categoryIdx then
    iconType = cashIconType.mileage
  else
    iconType = cashIconType.pearl
  end
  cashIcon_changeTextureForList(icon, serviceContry, iconType)
end
function FromClient_NotifyCompleteBuyProduct(productNoRaw, isGift, toCharacterName)
  local isPearlBox = false
  local isGuildGiveawayItem = false
  if isGift then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_NOTIFYCOMPLETEBUYPRODUCT_GIFT", "toCharacterName", toCharacterName))
  else
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
    local itemWrapper = cashProduct:getItemByIndex(0)
    isPearlBox = cashProduct:isPearlBox()
    isGuildGiveawayItem = cashProduct:getGuildGiveawayKey():isDefined()
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_NOTIFYCOMPLETE_ACK"))
    FGlobal_CashShop_SetEquip_CouponEffectCheck()
    if cashProduct:isChooseCash() then
      local chooseCashProduct = cashProduct:getChooseCashByIndex(0)
      itemWrapper = chooseCashProduct:getItemByIndex(0)
    end
    if nil == itemWrapper or itemWrapper:get():isCash() == true or itemWrapper:checkToValksItem() == true then
      if _ContentsGroup_EnchantRemaster == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_PEARLBAG_ENCHANT"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_PEARLBAG"))
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CONFIRM_NORMALBAG"))
    end
  end
  InGameShop_UpdateCash()
  InGameShopBuy_Close()
  if isPearlBox then
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
    local pearlBoxName = cashProduct:getName()
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUYPEARLBOX", "pearlBoxName", pearlBoxName)
    if true == inGameShopBuy._savedNotEnoughMoney then
      messageBoxMemo = messageBoxMemo .. PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_LASTPRODUCTGO")
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUYPEARLBOX_TITLE"),
      content = messageBoxMemo,
      functionApply = PaGlobalFunc_InGameShop_GoLastProduct,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    if _ContentsOption_CH_Purchase == false then
      FGlobal_InGameShop_OpenInventory()
    end
  elseif true == isGuildGiveawayItem then
    PaGlobalFunc_InGameShop_OpenInventory(IngameCashShop_GuildGiveawayFilter)
  end
end
function _InGameShopBuy_DontChangeCount()
  ClearFocusEdit()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DONTCHANGECOUNT"))
  return
end
function Scroll_GiftTopList(isUp)
  inGameShopBuy._config._giftTopListStart = UIScroll.ScrollEvent(inGameShopBuy._scroll_GiftTopList, isUp, inGameShopBuy._config._giftTopListMaxCount, inGameShopBuy._config._giftTopListCount, inGameShopBuy._config._giftTopListStart, 1)
  inGameShopBuy:AddedListUpdate()
end
function Scroll_GiftBotList(isUp)
  inGameShopBuy._config._giftBotListStart = UIScroll.ScrollEvent(inGameShopBuy._scroll_GiftBotList, isUp, inGameShopBuy._config._giftBotListMaxCount, inGameShopBuy._config._giftBotListCount, inGameShopBuy._config._giftBotListStart, 1)
  inGameShopBuy:UserListUpdate()
end
function HandleClicked_AddGiftTopList(botIdx)
  local botName = inGameShopBuy.giftUserList[botIdx].name
  local botUserNo = inGameShopBuy.giftUserList[botIdx].userNo
  local botSendType = inGameShopBuy.giftUserList[botIdx].sendType
  if "" ~= botName or nil ~= botName then
    getIngameCashMall():pushGiftToUser(botName, botUserNo, inGameShopBuy._eventCart)
  else
    _PA_ASSERT(false, "\235\141\176\236\157\180\237\132\176\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. giftUserList \235\176\176\236\151\180\236\151\144 \237\149\180\235\139\185\237\149\152\235\138\148 idx \237\152\185\236\157\128 name \234\176\146\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.")
  end
  if inGameShopBuy._eventCart then
    inGameShopBuy:updateByEventCart()
  else
    inGameShopBuy:update()
  end
  FGlobal_IngameCashShop_BuyOrGift_TotalPearlPrice()
end
function HandleClicked_InGameShop_ChangeGiftCount(isPlus, dataIdx)
  local self = inGameShopBuy
  local beforCount = getIngameCashMall():getGiftList(dataIdx):getCount()
  if isPlus then
    if beforCount >= 20 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_BUYORGIFT_MUST_LESS20"))
      return
    end
    getIngameCashMall():setGiftCount(dataIdx, beforCount + 1)
  else
    if beforCount <= 1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PANEL_INGAMECASHSHOP_BUYORGIFT_MUST_BIG1"))
      return
    end
    getIngameCashMall():setGiftCount(dataIdx, beforCount - 1)
  end
  inGameShopBuy:AddedListUpdate()
  FGlobal_IngameCashShop_BuyOrGift_TotalPearlPrice()
end
function HandleClicked_InGameShop_DeleteGiftList(dataIdx)
  getIngameCashMall():popGift(dataIdx)
  inGameShopBuy._config._giftTopListStart = 0
  inGameShopBuy._scroll_GiftTopList:SetControlTop()
  inGameShopBuy:AddedListUpdate()
  FGlobal_IngameCashShop_BuyOrGift_TotalPearlPrice()
end
function HandelClicked_InGameShopBuy_FriendGuild()
  if inGameShopBuy._eventCart then
    inGameShopBuy:updateByEventCart()
  else
    inGameShopBuy:update()
  end
end
function HandelClicked_InGameShopBuy_SetAddUser()
  inGameShopBuy._edit_Gift:SetEditText("", true)
end
function HandelClicked_InGameShopBuy_AddUser()
  local userName = inGameShopBuy._edit_Gift:GetEditText()
  getIngameCashMall():pushGiftToCharacter(userName, inGameShopBuy._eventCart)
  inGameShopBuy:AddedListUpdate()
  FGlobal_IngameCashShop_BuyOrGift_TotalPearlPrice()
  inGameShopBuy._edit_Gift:SetEditText("", true)
  ClearFocusEdit()
end
function InGameShopBuy_GetSliver()
  local self = inGameShopBuy
  local maxCountPerPrice = Defines.s64_const.s64_0
  local silverInInventory = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
  return silverInInventory
end
function InGameShopBuy_ShowItemToolTip(isShow, index)
  local self = inGameShopBuy
  if true == isShow then
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
    local itemWrapper = cashProduct:getItemByIndex(index)
    local slotIcon = self._slots[index].icon
    Panel_Tooltip_Item_Show(itemWrapper, slotIcon, true, false, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InGameShopBuy_ShowSubItemToolTip(isShow, index)
  local self = inGameShopBuy
  if true == isShow then
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
    local itemWrapper = cashProduct:getSubItemByIndex(index)
    local slotIcon = self._slots[index + cashProduct:getSubItemListCount()].icon
    Panel_Tooltip_Item_Show(itemWrapper, slotIcon, true, false, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InGameShopBuy_ShowChooseItemToolTip(isShow, chooseIndex, chooseStartCount, index)
  local self = inGameShopBuy
  if true == isShow then
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(self._productNoRaw)
    local chooseCashProduct = cashProduct:getChooseCashByIndex(chooseIndex)
    local itemWrapper = chooseCashProduct:getItemByIndex(index - chooseStartCount)
    local slotIcon = self._slots[index].icon
    Panel_Tooltip_Item_Show(itemWrapper, slotIcon, true, false, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InGameShopBuy_ShowEventCartItemToolTip(isShow, cashProductRaw, index, cashItemIndex)
  local self = inGameShopBuy
  if true == isShow then
    local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(cashProductRaw)
    local itemWrapper = cashProduct:getItemByIndex(cashItemIndex)
    local slotIcon = self._slots[index].icon
    Panel_Tooltip_Item_Show(itemWrapper, slotIcon, true, false, nil)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function InGameShopBuy_ShowGuildGiveawayItemToolTip(isShow, index)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local self = inGameShopBuy
  local slot
  if nil == index then
    slot = self._guildGiveawayItemSlot
    index = 0
  else
    slot = self._guildGiveawayItemSlots[index]
  end
  if nil == slot then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slot.itemEnchantKeyRaw))
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_SetPosition(index, slot, "GuildGiveaway")
  Panel_Tooltip_Item_Show(itemSSW, slot.icon, true)
end
function FGlobal_InGameShopBuy_Open(productNoRaw, isGift, byCart, isEasy, isEventCart, immediatelyUseParam)
  local self = inGameShopBuy
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNoRaw)
  if nil == isEventCart or false == isEventCart then
    local isValid = false
    if cashProduct:isChooseCash() then
      isValid = InGameShopBuy_CheckChooseProduct(cashProduct)
      if false == isValid then
        return false
      end
    end
  end
  if true == _ContentsGroup_SelectBox then
    PaGlobal_CloseSelectBoxPanel()
  end
  if true == isEventCart and true == _ContentsGroup_RenewUI then
    self._button_Close:SetShow(false)
    Panel_IngameCashShop_BuyOrGift:ignorePadSnapMoveToOtherPanel()
  else
    self._button_Close:SetShow(true)
  end
  self._productNoRaw = productNoRaw
  self._isGift = isGift
  self._byCart = byCart
  self._easyBuy = isEasy
  self._eventCart = isEventCart
  self._edit_count:SetText("1")
  self.savedProductCount = 1
  self._currentSelectedEventTab = FGlobal_IngameCashShop_EventCart_SelectedTab()
  self._static_ItemIconBG:SetShow(true)
  self._static_ItemIcon:SetShow(true)
  self._static_ItemName:SetShow(true)
  self._static_BuyCountTitle:SetShow(true)
  self._static_BuyLineBG:SetShow(true)
  self._edit_count:SetShow(true)
  self._staticText_ItemListTitle:SetShow(true)
  if true == isJapan or true == isJapanConsole then
    self._staticText_Notice:SetShow(true)
  end
  self._static_Caution:SetShow(false)
  self._immediatelyUse = immediatelyUseParam
  if true == isGift then
    self._panelTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_DOGIFT"))
    self._button_Confirm:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_GIFT"))
    self._edit_Gift:SetEditText("", true)
    self._buttonFriendList:SetCheck(true)
    self._buttonGuildList:SetCheck(false)
    self._radioButtonSelectPearl:SetShow(false)
    if true == isEventCart then
      self._panelTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EVENTCART_POPUPTITLE_GIFT"))
      self._static_ItemIconBG:SetShow(false)
      self._static_ItemIcon:SetShow(false)
      self._static_ItemName:SetShow(false)
      self._txt_PearlIconPrice:SetText(makeDotMoney(FGlobal_IngameCashShopEventCart_TotalPriceByIndex(self._currentSelectedEventTab)))
      self._static_Caution:SetTextMode(__eTextMode_AutoWrap)
      local eventType = FGlobal_IngameCashShop_EventCart_EventType(self._currentSelectedEventTab)
      if eventType == UI_EventCart.eEventCartDiscountType_Subtraction then
        self._static_Caution:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCART_POPUPCAUTIONPRICE", "discountpearl", FGlobal_IngameCashShop_EventCart_DiscountValue(self._currentSelectedEventTab)))
      elseif eventType == UI_EventCart.eEventCartDiscountType_Rate then
        self._static_Caution:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCART_POPUPCAUTION", "discountpearl", FGlobal_IngameCashShop_EventCart_DiscountValue(self._currentSelectedEventTab)))
      end
      if isJapan == true or isJapanConsole == true then
        local str = self._static_Caution:GetText() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_13")
        self._static_Caution:SetText(str)
      end
      self._static_Caution:SetShow(true)
    end
  else
    self._panelTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUYPRODUCT"))
    self._button_Confirm:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUY"))
    if true == isEventCart then
      self._panelTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EVENTCART_POPUPTITLE"))
      self._static_BuyCountTitle:SetShow(false)
      self._static_BuyLineBG:SetShow(false)
      self._edit_count:SetShow(false)
      self._edit_Gift:SetShow(false)
      self._static_Gift:SetShow(false)
      self._static_ItemIconBG:SetShow(false)
      self._static_ItemIcon:SetShow(false)
      self._static_ItemName:SetShow(false)
      self._txt_PearlIconPrice:SetText(makeDotMoney(FGlobal_IngameCashShopEventCart_TotalPriceByIndex(self._currentSelectedEventTab)))
      self._static_Caution:SetTextMode(__eTextMode_AutoWrap)
      local eventType = FGlobal_IngameCashShop_EventCart_EventType(self._currentSelectedEventTab)
      if eventType == UI_EventCart.eEventCartDiscountType_Subtraction then
        self._static_Caution:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCART_POPUPCAUTIONPRICE", "discountpearl", FGlobal_IngameCashShop_EventCart_DiscountValue(self._currentSelectedEventTab)))
      elseif eventType == UI_EventCart.eEventCartDiscountType_Rate then
        self._static_Caution:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EVENTCART_POPUPCAUTION", "discountpearl", FGlobal_IngameCashShop_EventCart_DiscountValue(self._currentSelectedEventTab)))
      end
      if isJapan == true or isJapanConsole == true then
        local str = self._static_Caution:GetText() .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_13")
        self._static_Caution:SetText(str)
      end
      self._static_Caution:SetShow(true)
    end
  end
  self._staticText_ItemListTitle:SetPosY(self._static_Caution:GetPosY() + self._static_Caution:GetTextSizeY() + 10)
  local gapCount = 0
  local noticePosY = 0
  local noticeAddsizeY = 0
  for ii = 0, self._slotCount - 1 do
    if ii > 0 and 0 == ii % self._config._itemCountPerLine then
      gapCount = gapCount + 1
    end
    self._slots[ii].iconBG:SetPosY(self._staticText_ItemListTitle:GetPosY() + 5 + self._staticText_ItemListTitle:GetTextSizeY() + 46 * gapCount)
    noticeAddsizeY = self._slots[ii].iconBG:GetSizeY()
    noticePosY = self._slots[ii].iconBG:GetPosY() + noticeAddsizeY
  end
  if true == isJapan and self._eventCart == false then
    self._staticText_Notice:SetPosY(noticePosY)
    local totalString = ""
    if true == isGift then
      totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_9") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_10")
      self._staticText_Notice:SetText(totalString)
    else
      local priceType = cashProduct:getProductPriceType()
      if __ePriceType_Cash == priceType then
        if true == cashProduct:isApplySellTimeLimit() then
          local endSellTimeValue = PATime(cashProduct:getEndSellTime():get_s64())
          local monthValue = tostring(endSellTimeValue:GetMonth())
          local formattedMonth = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. monthValue)
          local yearValue = endSellTimeValue:GetYear()
          endSellTime = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", tostring(yearValue), "GetMonth", formattedMonth, "GetDay", tostring(endSellTimeValue:GetDay()))
          totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_1") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_4", "endSellTime", endSellTime) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_3")
          self._staticText_Notice:SetText(totalString)
        else
          totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_1") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_3")
          self._staticText_Notice:SetText(totalString)
        end
      elseif __ePriceType_Pearl == priceType then
        if true == cashProduct:isApplySellTimeLimit() then
          local endSellTimeValue = PATime(cashProduct:getEndSellTime():get_s64())
          local monthValue = tostring(endSellTimeValue:GetMonth())
          local formattedMonth = PAGetString(Defines.StringSheet_GAME, "LUA_DATEINFO_MONTH_" .. monthValue)
          local yearValue = endSellTimeValue:GetYear()
          endSellTime = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_GOODSDETAILINFO_SELLTIME", "GetYear", tostring(yearValue), "GetMonth", formattedMonth, "GetDay", tostring(endSellTimeValue:GetDay()))
          if nil == self._easyBuy then
            totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_4", "endSellTime", endSellTime) .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_6")
          elseif true == self._immediatelyUse then
            totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2")
          else
            totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_6")
          end
          self._staticText_Notice:SetText(totalString)
        else
          if nil == self._easyBuy then
            totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_6")
          elseif true == self._immediatelyUse then
            totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2")
          else
            totalString = PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_6")
          end
          self._staticText_Notice:SetText(totalString)
        end
      else
        self._staticText_Notice:SetText("")
      end
    end
    local sizeX = self._staticText_Notice:GetSizeX()
    local textSizeY = self._staticText_Notice:GetTextSizeY()
    self._staticText_Notice:SetSize(sizeX, textSizeY)
    noticeSizeY = textSizeY + noticeAddsizeY
  end
  self.giftUserList = {}
  self._config._giftTopListCount = 0
  self._config._giftBotListCount = 0
  self._config._giftTopListStart = 0
  self._config._giftBotListStart = 0
  self._scroll_GiftTopList:SetControlTop()
  self._scroll_GiftBotList:SetControlTop()
  RequestFriendList_getFriendList()
  getIngameCashMall():clearGift()
  if true == isEventCart then
    self:updateByEventCart()
  else
    self:update()
  end
  self:defaultPosition()
  if true == isEasy or true == isEventCart then
    local isShow = false
    if true ~= immediatelyUseParam and isEasy then
      isShow = true
    end
    self._button_CountUp:SetShow(isShow)
    self._button_CountDown:SetShow(isShow)
  else
    self._button_CountUp:SetShow(true)
    self._button_CountDown:SetShow(true)
  end
  self.icon_Pearl:SetText("0")
  InGameShopBuy_Open()
  if true == isEventCart then
    if true == _ContentsGroup_PearlShopMileage and true == PaGlobal_CashMileage_IsOpenCheck() then
      PaGlobal_CashMileage_ChangeConsumePearl(Int64toInt32(FGlobal_IngameCashShopEventCart_TotalPriceByIndex(self._currentSelectedEventTab)))
    end
    if _ContentsGroup_PearlShopMoonBlessingRenew == true and PaGlobal_MoonBlessingRenew_IsOpenCheck() == true then
      PaGlobal_MoonBlessing_ChangeConsumePearl(Int64toInt32(FGlobal_IngameCashShopEventCart_TotalPriceByIndex(self._currentSelectedEventTab)))
    end
  end
  return true
end
function InGameShopBuy_Open()
  if Panel_IngameCashShop_BuyOrGift:GetShow() then
    return
  end
  inGameShopBuy._edit_Gift:SetEditText("", true)
  Panel_IngameCashShop_BuyOrGift:SetShow(true)
  FGlobal_IngameCashShopCoupon_ReturnValueCancel()
end
function InGameShopBuy_Close(isCouponCheck)
  if not Panel_IngameCashShop_BuyOrGift:GetShow() then
    return
  end
  ClearFocusEdit()
  Panel_Tooltip_Item_hideTooltip()
  Panel_IngameCashShop_BuyOrGift:SetShow(false)
  IngameCashShopCoupon_Close(isCouponCheck)
  Panel_NumberPad_Show(false, Defines.s64_const.s64_0, 0, nil)
  if nil ~= Panel_IngameCashShop_MoonBlessing_All and true == Panel_IngameCashShop_MoonBlessing_All:GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_All_Close()
  end
  if nil ~= Panel_IngameCashShop_MoonBlessing_Renew_All and true == Panel_IngameCashShop_MoonBlessing_Renew_All:GetShow() then
    PaGlobalFunc_IngameCashShopMoonBlessing_Renew_All_Close()
  end
  inGameShopBuy.savedCouponDiscountTextSizeX = 0
end
function InGameShopBuy_IsOpen()
  if Panel_IngameCashShop_BuyOrGift:GetShow() then
    return true
  end
  return false
end
function InGameShopBuy_CheckAddUser()
  if MessageBoxGetShow() then
    return
  end
  local checkUserNickName = inGameShopBuy._edit_Gift:GetEditText()
  getIngameCashMall():requestUserNickNameByCharacterName(checkUserNickName)
end
function FromClient_IncashshopGetUserNickName(outUserNickName, isSearched)
  local checkCharacterName = inGameShopBuy._edit_Gift:GetEditText()
  ClearFocusEdit()
  if true == isSearched then
    local messageBoxtitle = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
    local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CHECK_TOUSERNAME", "userNickName", outUserNickName, "characterName", checkCharacterName)
    local messageBoxData = {
      title = messageBoxtitle,
      content = messageBoxMemo,
      functionYes = HandelClicked_InGameShopBuy_AddUser,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, "middle")
  else
    local messageBoxtitle2 = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING")
    local messageBoxMemo2 = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_CHECK_TOUSERNAME_NORESULT")
    local messageBoxData2 = {
      title = messageBoxtitle2,
      content = messageBoxMemo2,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData2, "middle")
  end
end
function PaGlobalFunc_SaveNotEnoughMoneyCheck()
  return inGameShopBuy._savedNotEnoughMoney
end
function PaGlobalFunc_SaveNotEnoughMoneyValueCheck(value)
  inGameShopBuy._savedNotEnoughMoney = value
end
inGameShopBuy:init()
inGameShopBuy:registEventHandler()
inGameShopBuy:registMessageHandler()
