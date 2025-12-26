function PaGlobal_IngameCashSHop_ReturnBack:initialize()
  if true == PaGlobal_IngameCashSHop_ReturnBack._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBG = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleBG, "Button_Close")
  self._ui._stc_productArea = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Static_ProductArea")
  self._ui._stc_itemSlotBG = UI.getChildControl(self._ui._stc_productArea, "Static_ItemSlotBG")
  self._ui._stc_txtMoonBlessing = UI.getChildControl(self._ui._stc_itemSlotBG, "StaticText_SubItemTitle_MoonBlessing")
  local iconBG = UI.getChildControl(self._ui._stc_itemSlotBG, "Static_GoodsSlotBG")
  self._ui._stc_productIcon = UI.getChildControl(iconBG, "Static_GoodsSlot")
  self._ui._stc_productName = UI.getChildControl(self._ui._stc_itemSlotBG, "StaticText_GoodsName")
  self._ui._stc_productPrice = UI.getChildControl(self._ui._stc_itemSlotBG, "StaticText_GoodsPriceValue")
  self._ui._stc_productCount = UI.getChildControl(self._ui._stc_itemSlotBG, "StaticText_BuyCount")
  self._ui._stc_couponSlotBG = UI.getChildControl(self._ui._stc_productArea, "Static_CouponSlotBG")
  self._ui._slotTemplete = UI.getChildControl(self._ui._stc_itemSlotBG, "Static_SubSlot_Temp")
  self._ui._slotTemplete:SetShow(false)
  self._ui._slotTempleteMoonBlessing = UI.getChildControl(self._ui._stc_itemSlotBG, "Static_SubSlot_Temp_MoonBlessing")
  self._ui._slotTempleteMoonBlessing:SetShow(false)
  local iconBG = UI.getChildControl(self._ui._stc_couponSlotBG, "Static_GoodsSlotBG")
  self._ui._stc_couponIcon = UI.getChildControl(iconBG, "Static_GoodsSlot")
  self._ui._stc_couponName = UI.getChildControl(self._ui._stc_couponSlotBG, "StaticText_CouponName")
  self._ui._stc_couponCount = UI.getChildControl(self._ui._stc_couponSlotBG, "StaticText_BuyCount")
  self._ui._list2 = UI.getChildControl(self._ui._stc_productArea, "List2_Product")
  self._ui._btn_confirm = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Button_Confirm")
  self._ui._btn_cancle = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Button_Cancle")
  self._ui._stc_keyGuidBG = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Static_KeyGuide_Console")
  self._ui._stc_check = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "StaticText_EditBackGroundText")
  self._ui._edit_check = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Edit_SearchText_PCUI")
  self._ui._txt_xButton = UI.getChildControl(self._ui._edit_check, "StaticText_XButton")
  self._ui._stc_editIcon = UI.getChildControl(self._ui._edit_check, "Static_Icon")
  self._ui._stc_DescBG = UI.getChildControl(Panel_IngameCashSHop_ReturnBack, "Static_DescEdge_Import")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_DescBG, "StaticText_Desc")
  self._ui._list2:setNotImpactScrollEvent(true)
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_RETURN_BOTTOM_DESC"))
  local gabY = self._ui._txt_desc:GetTextSizeY() - self._ui._stc_DescBG:GetSizeY()
  if gabY > 0 then
    self._ui._stc_DescBG:SetSize(self._ui._stc_DescBG:GetSizeX(), self._ui._stc_DescBG:GetSizeY() + gabY)
    Panel_IngameCashSHop_ReturnBack:SetSize(Panel_IngameCashSHop_ReturnBack:GetSizeX(), Panel_IngameCashSHop_ReturnBack:GetSizeY() + gabY)
    self._ui._stc_keyGuidBG:ComputePos()
    self._ui._btn_confirm:ComputePos()
    self._ui._btn_cancle:ComputePos()
  end
  self:descSetting()
  self._panelSizeY = Panel_IngameCashSHop_ReturnBack:GetSizeY()
  self._productSizeY = self._ui._stc_productArea:GetSizeY()
  self._editPosY = self._ui._edit_check:GetPosY()
  self._descPosY = self._ui._stc_DescBG:GetPosY()
  self._ui._txt_xButton:SetShow(self._isConsole)
  self._ui._btn_confirm:SetShow(not self._isConsole)
  self._ui._btn_cancle:SetShow(not self._isConsole)
  self._ui._stc_editIcon:SetShow(not self._isConsole)
  if self._isConsole == true then
    self:initKeyGuide()
    Panel_IngameCashSHop_ReturnBack:ignorePadSnapMoveToOtherPanel()
  end
  self:createEventCartSubItemSlot()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_IngameCashSHop_ReturnBack:createEventCartSubItemSlot()
  local content = UI.getChildControl(self._ui._list2, "List2_1_Content")
  local itemSlotBG = UI.getChildControl(content, "Static_ItemSlotBG")
  local subSlot = UI.getChildControl(itemSlotBG, "Static_SubSlot_Temp")
  subSlot:SetShow(false)
  local startPosX = subSlot:GetPosX()
  for idx = 1, 10 do
    local subSlot = UI.cloneControl(subSlot, itemSlotBG, "Static_SubSlot_" .. tostring(idx))
    local goodsSlot = UI.getChildControl(subSlot, "Static_GoodsSlot")
    subSlot:SetPosX(startPosX)
    goodsSlot:SetPosX(startPosX)
    startPosX = startPosX + subSlot:GetSizeX() + 5
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:initKeyGuide()
  if Panel_IngameCashSHop_ReturnBack == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._ui._stc_keyGuidBG:SetShow(true)
  local stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuidBG, "StaticText_Confirm_ConsoleUI")
  local stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuidBG, "StaticText_XboxClose_ConsoleUI")
  local stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuidBG, "StaticText_Coupon_ConsoleUI")
  local stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuidBG, "StaticText_Detail_ConsoleUI")
  local keyGuideList = Array.new()
  keyGuideList:push_back(stc_keyGuide_X)
  keyGuideList:push_back(stc_keyGuide_Y)
  keyGuideList:push_back(stc_keyGuide_A)
  keyGuideList:push_back(stc_keyGuide_B)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuidBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
end
function PaGlobal_IngameCashSHop_ReturnBack:descSetting()
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_RETURN_BOTTOM_DESC"))
  local gabY = self._ui._txt_desc:GetTextSizeY() - self._ui._txt_desc:GetSizeY()
  if gabY > 0 then
    self._ui._stc_DescBG:SetSize(self._ui._stc_DescBG:GetSizeX(), self._ui._stc_DescBG:GetSizeY() + gabY)
    Panel_IngameCashSHop_ReturnBack:SetSize(Panel_IngameCashSHop_ReturnBack:GetSizeX(), Panel_IngameCashSHop_ReturnBack:GetSizeY() + gabY)
  end
  self._ui._stc_keyGuidBG:ComputePos()
  self._ui._btn_confirm:ComputePos()
  self._ui._btn_cancle:ComputePos()
end
function PaGlobal_IngameCashSHop_ReturnBack:registEventHandler()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  self._ui._btn_cancle:addInputEvent("Mouse_LUp", "PaGlobal_IngameCashSHop_ReturnBack_Close()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_IngameCashSHop_ReturnBack_Close()")
  self._ui._edit_check:addInputEvent("Mouse_LUp", "HandleEventLUp_IngameCashSHop_SetFocusEdit()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_IngameCashSHop_RequestRefund()")
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_IngameCashSHop_UpdateContent")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stc_couponIcon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashSHop_ReturnBack_SimpletooltipTitle(true)")
  self._ui._stc_couponIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashSHop_ReturnBack_SimpletooltipTitle(false)")
  registerEvent("FromClient_RefundMoonBlessingPrepareList", "FromClient_RefundMoonBlessingPrepareList")
  if self._isConsole == true then
    Panel_IngameCashSHop_ReturnBack:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_IngameCashSHop_RequestRefund()")
    Panel_IngameCashSHop_ReturnBack:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_IngameCashSHop_SetFocusEdit()")
    Panel_IngameCashSHop_ReturnBack:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_IngameCashSHop_ReturnBack_Close()")
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:updateControl(control, key)
  local index = Int64toInt32(key)
  local productNo = ToClient_GetPurchaseItemCashProdcutNoByIndex(index)
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
  if nil == cashProduct then
    return
  end
  itemSlotBG = UI.getChildControl(control, "Static_ItemSlotBG")
  itemSlotBG:SetShow(true)
  local iconBG = UI.getChildControl(itemSlotBG, "Static_GoodsSlotBG")
  local productIcon = UI.getChildControl(iconBG, "Static_GoodsSlot")
  local productName = UI.getChildControl(itemSlotBG, "StaticText_GoodsName")
  local productPrice = UI.getChildControl(itemSlotBG, "StaticText_GoodsPriceValue")
  local productCount = UI.getChildControl(itemSlotBG, "StaticText_BuyCount")
  productIcon:ChangeTextureInfoNameAsync("icon/" .. cashProduct:getIconPath())
  productIcon:setRenderTexture(productIcon:getBaseTexture())
  productIcon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashSHop_ReturnBack_ShowToolTip(true," .. productNo .. ")")
  productIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashSHop_ReturnBack_ShowToolTip(false," .. productNo .. ")")
  productName:SetText(cashProduct:getDisplayName())
  local originalPearl = Int64toInt32(ToClient_GetPurchaseOriginalPearByIndex(index))
  local usePearl = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(index))
  productPrice:SetText(originalPearl)
  local count = ToClient_GetPurchaseBuyCountByIndex(index)
  productCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. " " .. count)
  productCount:SetSize(productCount:GetTextSizeX(), productCount:GetSizeY())
  productCount:ComputePos()
  self:subSlotSettingForEvent(cashProduct, control, key)
end
function PaGlobal_IngameCashSHop_ReturnBack:setProductItemSettingForEventCart(eventCartNo)
  self._ui._list2:getElementManager():clearKey()
  self._ui._stc_itemSlotBG:SetShow(false)
  self._ui._list2:SetShow(true)
  local gabY = self._ui._list2:GetSizeY() - self._ui._stc_itemSlotBG:GetSizeY()
  Panel_IngameCashSHop_ReturnBack:SetSize(Panel_IngameCashSHop_ReturnBack:GetSizeX(), self._panelSizeY + gabY)
  Panel_IngameCashSHop_ReturnBack:ComputePos()
  self._ui._stc_productArea:SetSize(self._ui._stc_productArea:GetSizeX(), self._productSizeY + gabY)
  self._ui._edit_check:SetPosY(self._editPosY + gabY)
  self._ui._stc_check:SetPosY(self._editPosY + gabY)
  self._ui._stc_DescBG:SetPosY(self._descPosY + gabY)
  self._ui._stc_keyGuidBG:ComputePos()
  self._ui._btn_confirm:ComputePos()
  self._ui._btn_cancle:ComputePos()
  for index = 0, PaGlobal_CashShopBuyHistory._realHistoryCount - 1 do
    local targetNo = ToClient_GetPurchaseEventCartNoByIndex(index)
    if eventCartNo == targetNo then
      self._ui._list2:getElementManager():pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:setProductItemSetting(index)
  self._ui._stc_itemSlotBG:SetShow(false)
  self._ui._list2:SetShow(false)
  Panel_IngameCashSHop_ReturnBack:SetSize(Panel_IngameCashSHop_ReturnBack:GetSizeX(), self._panelSizeY)
  Panel_IngameCashSHop_ReturnBack:ComputePos()
  self._ui._stc_productArea:SetSize(self._ui._stc_productArea:GetSizeX(), self._productSizeY)
  self._ui._edit_check:SetPosY(self._editPosY)
  self._ui._stc_check:SetPosY(self._editPosY)
  self._ui._stc_DescBG:SetPosY(self._descPosY)
  self._ui._stc_keyGuidBG:ComputePos()
  self._ui._btn_confirm:ComputePos()
  self._ui._btn_cancle:ComputePos()
  local productNo = ToClient_GetPurchaseItemCashProdcutNoByIndex(index)
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
  if nil == cashProduct then
    return
  end
  self._ui._stc_itemSlotBG:SetShow(true)
  self._ui._stc_productIcon:ChangeTextureInfoNameAsync("icon/" .. cashProduct:getIconPath())
  self._ui._stc_productIcon:setRenderTexture(self._ui._stc_productIcon:getBaseTexture())
  self._ui._stc_productIcon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashSHop_ReturnBack_ShowToolTip(true," .. productNo .. ")")
  self._ui._stc_productIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashSHop_ReturnBack_ShowToolTip(false," .. productNo .. ")")
  self._ui._stc_productName:SetText(cashProduct:getDisplayName())
  local originalPearl = Int64toInt32(ToClient_GetPurchaseOriginalPearByIndex(index))
  local usePearl = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(index))
  if originalPearl == usePearl then
    self._ui._stc_productPrice:SetText(usePearl)
  else
    self._ui._stc_productPrice:SetText(originalPearl .. " -> " .. usePearl)
  end
  local count = ToClient_GetPurchaseBuyCountByIndex(index)
  self._ui._stc_productCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. " " .. count)
  self._ui._stc_productCount:SetSize(self._ui._stc_productCount:GetTextSizeX(), self._ui._stc_productCount:GetSizeY())
  self._ui._stc_productCount:ComputePos()
  self:subSlotSetting(index, cashProduct)
end
function PaGlobal_IngameCashSHop_ReturnBack:setCouponSetting(index)
  self._ui._stc_couponSlotBG:SetShow(false)
  local couponName = ToClient_GetPurchaseCouponNameByIndex(index)
  if couponName == nil or couponName == "" then
    return
  end
  local iconPath = ToClient_GetPurchaseCouponIconPathByIndex(index)
  if iconPath == nil or iconPath == "" then
    return
  end
  self._ui._stc_couponSlotBG:SetShow(true)
  self._ui._stc_couponSlotBG:SetSpanSize(self._ui._stc_couponSlotBG:GetSpanSize().x, self._ui._stc_itemSlotBG:GetSpanSize().y + self._ui._stc_itemSlotBG:GetSizeY() + 5)
  local gabY = 0
  if self._ui._list2:GetShow() == true then
    gabY = self._ui._list2:GetSizeY() - self._ui._stc_itemSlotBG:GetSizeY()
  end
  gabY = gabY + self._moonblessingGab
  Panel_IngameCashSHop_ReturnBack:SetSize(Panel_IngameCashSHop_ReturnBack:GetSizeX(), self._panelSizeY + gabY + self._ui._stc_couponSlotBG:GetSizeY() + 5)
  self._ui._stc_productArea:SetSize(self._ui._stc_productArea:GetSizeX(), self._productSizeY + gabY + self._ui._stc_couponSlotBG:GetSizeY() + 5)
  self._ui._edit_check:SetPosY(self._editPosY + self._ui._stc_couponSlotBG:GetSizeY() + gabY)
  self._ui._stc_check:SetPosY(self._editPosY + self._ui._stc_couponSlotBG:GetSizeY() + gabY)
  self._ui._stc_DescBG:SetPosY(self._descPosY + self._ui._stc_couponSlotBG:GetSizeY() + gabY)
  self._ui._stc_keyGuidBG:ComputePos()
  self._ui._btn_confirm:ComputePos()
  self._ui._btn_cancle:ComputePos()
  self._ui._stc_couponIcon:ChangeTextureInfoNameAsync("icon/" .. iconPath)
  self._ui._stc_couponIcon:setRenderTexture(self._ui._stc_couponIcon:getBaseTexture())
  self._ui._stc_couponName:SetText(couponName)
  self._ui._stc_couponCount:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_MANUFACTURE_COUNT") .. " 1")
  self._ui._stc_couponName:SetSize(self._ui._stc_couponName:GetTextSizeX(), self._ui._stc_couponName:GetSizeY())
  self._ui._stc_couponName:ComputePos()
  self._ui._stc_couponName:SetText(self._ui._stc_couponName:GetText())
  local notiControl = UI.getChildControl(self._ui._stc_couponSlotBG, "StaticText_Noti")
  notiControl:SetShow(false)
end
function PaGlobal_IngameCashSHop_ReturnBack:subSlotSetting(index, cashProduct)
  for ii = 1, #self._subSlot + 10 do
    if nil ~= self._subSlot[ii] then
      self._subSlot[ii]:SetShow(false)
    end
  end
  local mainItemCount = cashProduct:getItemListCount()
  local subItemCount = cashProduct:getSubItemListCount()
  local itemCount = mainItemCount + subItemCount
  local posX = self._ui._slotTemplete:GetSpanSize().x
  for ii = 1, itemCount do
    local itemWrapper
    if ii <= mainItemCount then
      itemWrapper = cashProduct:getItemByIndex(ii - 1)
    else
      itemWrapper = cashProduct:getSubItemByIndex(ii - mainItemCount - 1)
    end
    if nil ~= itemWrapper then
      if self._subSlot[ii] == nil then
        self._subSlot[ii] = UI.cloneControl(self._ui._slotTemplete, self._ui._stc_itemSlotBG, "SubItemSlot_" .. ii)
      end
      self._subSlot[ii]:SetShow(true)
      self._subSlot[ii]:SetSpanSize(posX, self._subSlot[ii]:GetSpanSize().y)
      posX = posX + self._subSlot[ii]:GetSizeX() + 5
      local icon = UI.getChildControl(self._subSlot[ii], "Static_GoodsSlot")
      icon:ComputePos()
      icon:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getIconPath())
      icon:setRenderTexture(icon:getBaseTexture())
      icon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashSHop_ReturnBack_ItemShowToolTip(true," .. ii .. ")")
      icon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashSHop_ReturnBack_ItemShowToolTip(false," .. ii .. ")")
    end
  end
  local productNoCount = ToClint_GetChooseProductListCount(index)
  if 0 == productNoCount then
    return
  end
  for ii = 1, productNoCount do
    local chooseProductNo = ToClint_GetChooseProductNoByIndex(index, ii - 1)
    local chooseProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(chooseProductNo)
    if nil ~= chooseProduct then
      local chooseitemCount = chooseProduct:getItemListCount()
      for jj = itemCount + 1, itemCount + 1 + chooseitemCount do
        local index = jj - (itemCount + 1)
        local itemWrapper = chooseProduct:getItemByIndex(index)
        if nil ~= itemWrapper then
          if self._subSlot[jj] == nil then
            self._subSlot[jj] = UI.cloneControl(self._ui._slotTemplete, self._ui._stc_itemSlotBG, "SubItemSlot_" .. jj)
          end
          self._subSlot[jj]:SetShow(true)
          self._subSlot[jj]:SetSpanSize(posX, self._subSlot[jj]:GetSpanSize().y)
          posX = posX + self._subSlot[jj]:GetSizeX() + 5
          local icon = UI.getChildControl(self._subSlot[jj], "Static_GoodsSlot")
          icon:ComputePos()
          icon:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getIconPath())
          icon:setRenderTexture(icon:getBaseTexture())
          icon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashSHop_ReturnBack_ItemShowToolTip2(true," .. chooseProductNo .. "," .. index .. "," .. jj .. ")")
          icon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashSHop_ReturnBack_ItemShowToolTip2(false," .. chooseProductNo .. "," .. index .. "," .. jj .. ")")
        end
      end
      itemCount = itemCount + 1 + chooseitemCount
    end
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:moonblessingSlotSettingNew(moonblessingIndex)
  self:resetSlot()
  self._moonblessingGab = 0
  self._ui._stc_txtMoonBlessing:SetShow(false)
  local itemCount = ToClient_GetMoonBlessingRefundRewardCount()
  local posX = self._ui._slotTempleteMoonBlessing:GetSpanSize().x
  local posY = self._ui._slotTempleteMoonBlessing:GetSpanSize().y
  local row = 0
  local slotIndex = 1
  for ii = 1, itemCount do
    local rewardData = ToClient_GetMoonBlessingRefundRewardAt(moonblessingIndex, ii - 1)
    for jj = 1, rewardData:getBaseRewardCount() do
      local baseRewardInfo, itemWrapper
      baseRewardInfo = rewardData:getBaseRewardAt(jj - 1)
      if baseRewardInfo == nil then
        return
      end
      local baseRewardEnchantKey = baseRewardInfo:getItemEnchantKey()
      local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(baseRewardEnchantKey))
      local uiSlot = self._moonBlessingSlot[slotIndex]
      row = math.floor((slotIndex - 1) / self._COL_SLOT_COUNT)
      local col = (slotIndex - 1) % self._COL_SLOT_COUNT
      if nil == uiSlot then
        self._moonBlessingSlot[slotIndex] = {}
        local itemSlotBg = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotBG, "Static_SubSlot_Temp_MoonBlessing", self._ui._stc_itemSlotBG, "MoonBlessingItemSlot_" .. slotIndex)
        local slot = {}
        local slotConfig = {
          createIcon = true,
          createBorder = false,
          createEnchant = false,
          createCount = true,
          createClassEquipBG = false,
          createCash = false
        }
        SlotItem.new(slot, "MoonBlessingReward_Slot_" .. slotIndex .. "_" .. slotIndex, slotIndex, itemSlotBg, slotConfig)
        slot:createChild()
        slot.iconBg = itemSlotBg
        slot.icon:SetSize(self._ICONSIZE, self._ICONSIZE)
        itemSlotBg:SetSpanSize(posX + (self._ICONSIZE + 5) * col, posY + (self._ICONSIZE + 5) * row)
        itemSlotBg:SetShow(true)
        itemSlotBg:SetIgnore(true)
        self._moonBlessingSlot[slotIndex] = slot
        uiSlot = slot
        slot.icon:SetAutoDisableTime(0.5)
      end
      if nil ~= itemWrapper then
        uiSlot.iconBg:SetShow(true)
        uiSlot:setItemByStaticStatus(itemWrapper, baseRewardInfo._itemCount)
        uiSlot.count:SetSize(self._ICONSIZE - 3, self._ICONSIZE / 2)
        uiSlot.count:SetPosY(self._ICONSIZE * 0.5 + 5)
        uiSlot.count:SetPosX(2)
        uiSlot.count:SetText(tostring(baseRewardInfo._itemCount))
        uiSlot.count:SetShow(true)
        uiSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashSHop_ShowRefundMoonBlessingItemTooltip(" .. tostring(slotIndex) .. "," .. baseRewardInfo:getItemEnchantKey() .. ", true)")
        uiSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashSHop_ShowRefundMoonBlessingItemTooltip(" .. tostring(slotIndex) .. "," .. baseRewardInfo:getItemEnchantKey() .. ", false)")
        slotIndex = slotIndex + 1
      end
    end
  end
  local gabY = 0
  if itemCount ~= 0 then
    gabY = self._ui._stc_txtMoonBlessing:GetSizeY() + (row + 1) * (self._ICONSIZE + 10)
    self._ui._stc_txtMoonBlessing:SetShow(true)
  end
  self._ui._stc_itemSlotBG:SetSize(self._ui._stc_itemSlotBG:GetSizeX(), self._productSizeY + gabY - 20)
  Panel_IngameCashSHop_ReturnBack:SetSize(Panel_IngameCashSHop_ReturnBack:GetSizeX(), self._panelSizeY + gabY)
  Panel_IngameCashSHop_ReturnBack:ComputePos()
  self._ui._stc_productArea:SetSize(self._ui._stc_productArea:GetSizeX(), self._productSizeY + gabY)
  self._ui._edit_check:SetPosY(self._editPosY + gabY)
  self._ui._stc_check:SetPosY(self._editPosY + gabY)
  self._ui._stc_DescBG:SetPosY(self._descPosY + gabY)
  self._ui._stc_productCount:ComputePos()
  self._ui._stc_keyGuidBG:ComputePos()
  self._ui._btn_confirm:ComputePos()
  self._ui._btn_cancle:ComputePos()
  self._moonblessingGab = gabY
end
function PaGlobal_IngameCashSHop_ReturnBack:subSlotSettingForEvent(cashProduct, control, key)
  local itemSlotBG = UI.getChildControl(control, "Static_ItemSlotBG")
  local subSlotTemp = UI.getChildControl(itemSlotBG, "Static_SubSlot_Temp")
  local itemCount = cashProduct:getItemListCount()
  local posX = subSlotTemp:GetPosX()
  local keyString = tostring(key)
  for idx = 1, 10 do
    local subSlot = UI.getChildControl(itemSlotBG, "Static_SubSlot_" .. tostring(idx))
    subSlot:SetPosX(posX)
    subSlot:SetSpanSize(posX, subSlotTemp:GetSpanSize().y)
    posX = posX + subSlotTemp:GetSizeX() + 5
    if idx <= itemCount then
      subSlot:SetShow(true)
      local itemWrapper = cashProduct:getItemByIndex(idx - 1)
      if itemWrapper ~= nil then
        local icon = UI.getChildControl(subSlot, "Static_GoodsSlot")
        icon:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getIconPath())
        icon:setRenderTexture(icon:getBaseTexture())
        icon:addInputEvent("Mouse_On", "HandleEventOnOut_IngameCashShop_ReturnBack_ItemShowToolTipForEventCart(true," .. cashProduct:getNoRaw() .. ", " .. idx .. ", " .. keyString .. ")")
        icon:addInputEvent("Mouse_Out", "HandleEventOnOut_IngameCashShop_ReturnBack_ItemShowToolTipForEventCart(false," .. cashProduct:getNoRaw() .. ", " .. idx .. ", " .. keyString .. ")")
      end
    else
      subSlot:SetShow(false)
    end
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:prepareOpen(index, controlIndex, eventCartNo)
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  if _ContentsGroup_RefundCashProduct == false then
    return
  end
  if -1 ~= self._selectIndex and nil ~= PaGlobal_CashShopBuyHistory_ChangeClickTexture then
    PaGlobal_CashShopBuyHistory_ChangeClickTexture(self._selectControlIndex, false)
  end
  self._selectIndex = index
  self._selectControlIndex = controlIndex
  if nil ~= PaGlobal_CashShopBuyHistory_ChangeClickTexture then
    PaGlobal_CashShopBuyHistory_ChangeClickTexture(self._selectControlIndex, true)
  end
  self._ui._edit_check:SetEditText("")
  if eventCartNo == 0 then
    self:setProductItemSetting(index)
  else
    self:setProductItemSettingForEventCart(eventCartNo)
  end
  local moonblessingIndex = ToClient_GetMoonBlessingIndexByIndex(index)
  self:moonblessingSlotSettingNew(moonblessingIndex)
  self:setCouponSetting(index)
  self:recalcPanelPosition()
  self:open()
  if self._isConsole == true then
    ToClient_padSnapSetTargetPanel(Panel_IngameCashSHop_ReturnBack)
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:recalcPanelPosition()
  local panel = Panel_IngameCashSHop_ReturnBack
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local calcPosX = 0
  local calcPosY = screenCenterY - panelSizeY / 2
  if self._isConsole == true and PaGlobalFunc_PearlShop_GetMainBgPosSizeX ~= nil then
    local targetPosX, targetSizeX = PaGlobalFunc_PearlShop_GetMainBgPosSizeX()
    calcPosX = targetPosX + targetSizeX + 30
  else
    calcPosX = screenCenterX - panelSizeX / 2
  end
  if calcPosX < 0 then
    calcPosX = 0
  elseif getScreenSizeX() <= calcPosX + panelSizeX then
    local diffX = calcPosX + panelSizeX - getScreenSizeX()
    calcPosX = calcPosX - diffX - 10
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_IngameCashSHop_ReturnBack:open()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  Panel_IngameCashSHop_ReturnBack:SetShow(true)
end
function PaGlobal_IngameCashSHop_ReturnBack:prepareClose()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  if nil ~= PaGlobal_CashShopBuyHistory_ChangeClickTexture then
    PaGlobal_CashShopBuyHistory_ChangeClickTexture(self._selectControlIndex, false)
  end
  self._selectIndex = -1
  self._selectControlIndex = -1
  self._ui._edit_check:SetEditText("")
  ClearFocusEdit()
  Panel_Tooltip_Item_hideTooltip()
  if self._isConsole == true and Panel_PearlShop ~= nil then
    ToClient_padSnapSetTargetPanel(Panel_PearlShop)
  end
  self:close()
end
function PaGlobal_IngameCashSHop_ReturnBack:close()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  Panel_IngameCashSHop_ReturnBack:SetShow(false)
end
function PaGlobal_IngameCashSHop_ReturnBack:validate()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:getEventCartInfo()
  local productName = ""
  local control = self._ui._list2:GetContentByKey(toInt64(0, PaGlobal_IngameCashSHop_ReturnBack._selectIndex))
  if nil ~= control then
    local itemSlotBG = UI.getChildControl(control, "Static_ItemSlotBG")
    local nameControl = UI.getChildControl(itemSlotBG, "StaticText_GoodsName")
    productName = nameControl:GetText()
  end
  if "" ~= productName then
    local size = self._ui._list2:getElementManager():getSize()
    local count = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_EVENTCART_RETURN_COUNT", "count", tostring(size))
    productName = productName .. " " .. count
  end
  return productName
end
function PaGlobal_IngameCashSHop_ReturnBack:resetSlot()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  local slotIndex = 1
  for index, uiSlot in pairs(self._moonBlessingSlot) do
    if nil ~= uiSlot then
      Panel_Tooltip_Item_hideTooltip()
      uiSlot:clearItem()
      uiSlot.iconBg:SetShow(false)
      if true == self._isConsole then
        uiSlot.icon:registerPadEvent(__eConsoleUIPadEvent_A, "")
      else
        uiSlot.icon:addInputEvent("Mouse_RUp", "")
      end
      uiSlot.icon:addInputEvent("Mouse_On", "")
      uiSlot.icon:addInputEvent("Mouse_Out", "")
      slotIndex = slotIndex + 1
    end
  end
end
function PaGlobal_IngameCashSHop_ReturnBack:showRefundMoonBlessingItemTooltip(key, itemEnchantKey, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local info = self._moonBlessingSlot[key]
  if nil == info then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local control = info.icon
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
