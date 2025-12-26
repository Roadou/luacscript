function PaGlobalFunc_EasyBuy_Open(uniqueNo, waypointKey, immediatelyUse, tempCashItemSSW)
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  self:prepareOpen(uniqueNo, waypointKey, immediatelyUse, tempCashItemSSW)
end
function PaGlobalFunc_EasyBuy_Close()
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_EasyBuy_BuyItem(productRaw)
  FGlobal_InGameShopBuy_Open(productRaw, false, false, true, nil, PaGlobal_EasyBuy._immediatelyUse)
  IngameCashShopCoupon_Open(0, productRaw)
end
function PaGlobalFunc_EasyBuy_FindItemFromPearlShop(productRaw)
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productRaw)
  if cashProduct == nil then
    return
  end
  local tabIndex = PaGlobal_InGameShop_FindTabIndex(cashProduct:getMainCategory())
  local subTabIndex = cashProduct:getMiddleCategory()
  PaGlobalFunc_EasyBuy_Close()
  InGameShop_Open()
  InGameShop_RadioReset()
  PaGlobal_InGameShop_GoToTab(tabIndex)
  InGameShop_TabEvent(tabIndex)
  InGameShop_SubTabEvent(tabIndex, subTabIndex)
  local shopProductIndex = PaGlobal_InGameShop_FindProductIndex(productRaw)
  if shopProductIndex ~= nil then
    IngameCashShop_SelectedItem(shopProductIndex, 0)
  end
end
function PaGlobalFunc_EasyBuy_MyPearlUpdate()
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  self:MyPearlUpdate()
end
function PaGlobalFunc_EasyBuy_ItemTooltip(isShow, productKeyRaw, index)
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productKeyRaw)
  local itemWrapper = cashProduct:getItemByIndex(0)
  local contents = self._ui._lst_product:GetContentByKey(toInt64(0, index))
  local stc_cashProduct = UI.getChildControl(contents, "Static_CashProduct")
  local control = UI.getChildControl(stc_cashProduct, "Static_MainItemSlot")
  Panel_Tooltip_Item_Show(itemWrapper, control, true, false, nil)
end
function PaGlobalFunc_EasyBuy_SubItemTooltip(isShow, isSubCashItem, subSlotIndex, dataIndex, productKeyRaw, index)
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  if isShow == false then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productKeyRaw)
  local itemWrapper
  if isSubCashItem == true then
    itemWrapper = cashProduct:getSubItemByIndex(dataIndex)
  else
    itemWrapper = cashProduct:getItemByIndex(dataIndex)
  end
  local contents = self._ui._lst_product:GetContentByKey(toInt64(0, index))
  local stc_cashProduct = UI.getChildControl(contents, "Static_CashProduct")
  local control = UI.getChildControl(stc_cashProduct, "Static_SubItemSlot_" .. subSlotIndex)
  Panel_Tooltip_Item_Show(itemWrapper, control, true, false, nil)
end
function PaGlobalFunc_EasyBuy_UpdateList(contents, key)
  local self = PaGlobal_EasyBuy
  if self == nil then
    return
  end
  local productIndex = Int64toInt32(key)
  local productInfo = getIngameCashMall():getByCategoryLevel4(self.savedMainCategory, self.savedMiddleCategory, self.savedSmallCategory, self.savedWayPointKey, productIndex)
  if productInfo == nil then
    return
  end
  local stc_cashProduct = UI.getChildControl(contents, "Static_CashProduct")
  local stc_mainSlotBg = UI.getChildControl(stc_cashProduct, "Static_MainItemSlotBG")
  local stc_mainSlot = UI.getChildControl(stc_cashProduct, "Static_MainItemSlot")
  local txt_mainSlotName = UI.getChildControl(stc_cashProduct, "StaticText_MainItemName")
  local stc_pearlIcon = UI.getChildControl(stc_cashProduct, "Static_PearlIcon")
  local txt_price = UI.getChildControl(stc_cashProduct, "StaticText_PriceValue")
  local btn_detail = UI.getChildControl(stc_cashProduct, "Button_Detail")
  local btn_buy = UI.getChildControl(stc_cashProduct, "Button_Buy")
  local mainSlot = {}
  SlotItem.reInclude(mainSlot, "EasyBuy_MainItemSlot", 0, stc_mainSlot, self._mainSlotConfing)
  local mylimitCount = getIngameCashMall():getRemainingLimitCount(productInfo:getNoRaw())
  local productSSW = productInfo:getItemByIndex(0)
  local limitType = productInfo:getCashPurchaseLimitType()
  if productSSW == nil then
    productSSW = productInfo:getSubItemByIndex(0)
  end
  if productSSW ~= nil then
    stc_mainSlotBg:SetShow(true)
    stc_mainSlot:SetShow(true)
    mainSlot:setItemByStaticStatus(productSSW, 1, -1, false)
    mainSlot.icon:SetShow(true)
    mainSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_EasyBuy_ItemTooltip(true, " .. productInfo:getNoRaw() .. ", " .. productIndex .. ")")
    mainSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_EasyBuy_ItemTooltip(false)")
    for ii = 0, self._subSlotCountMax - 1 do
      local stc_subSlotBg = UI.getChildControl(stc_cashProduct, "Static_SubItemSlotBG_" .. ii)
      if stc_subSlotBg ~= nil then
        stc_subSlotBg:SetShow(false)
      end
      local stc_subSlot = UI.getChildControl(stc_cashProduct, "Static_SubItemSlot_" .. ii)
      if stc_subSlot ~= nil then
        stc_subSlot:SetShow(false)
      end
    end
    local subItemTotalCount = productInfo:getItemListCount() + productInfo:getSubItemListCount()
    if subItemTotalCount > 1 then
      local productItemCount = productInfo:getItemListCount()
      for ii = 0, productItemCount - 1 do
        local subItemSSW = productInfo:getItemByIndex(ii)
        local subItemCount = productInfo:getItemCountByIndex(ii)
        local stc_subSlotBg = UI.getChildControl(stc_cashProduct, "Static_SubItemSlotBG_" .. ii)
        if stc_subSlotBg ~= nil then
          stc_subSlotBg:SetShow(true)
        end
        local stc_subSlot = UI.getChildControl(stc_cashProduct, "Static_SubItemSlot_" .. ii)
        if stc_subSlot ~= nil then
          stc_subSlot:SetShow(true)
          local subSlot = {}
          SlotItem.reInclude(subSlot, "EasyBuy_SubItemSlot", ii, stc_subSlot, self._subSlotConfing)
          subSlot:setItemByStaticStatus(subItemSSW, subItemCount, -1, false)
          subSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_EasyBuy_SubItemTooltip(true, false, " .. ii .. ", " .. ii .. ", " .. productInfo:getNoRaw() .. ", " .. productIndex .. ")")
          subSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_EasyBuy_SubItemTooltip(false)")
        end
      end
      local subItemListCount = productInfo:getSubItemListCount()
      for ii = productItemCount, productItemCount + subItemListCount - 1 do
        local subItemSSW = productInfo:getSubItemByIndex(ii - productItemCount)
        local subItemCount = productInfo:getSubItemCountByIndex(ii - productItemCount)
        local stc_subSlotBg = UI.getChildControl(stc_cashProduct, "Static_SubItemSlotBG_" .. ii)
        if stc_subSlotBg ~= nil then
          stc_subSlotBg:SetShow(true)
        end
        local stc_subSlot = UI.getChildControl(stc_cashProduct, "Static_SubItemSlot_" .. ii)
        if stc_subSlot ~= nil then
          stc_subSlot:SetShow(true)
          local subSlot = {}
          SlotItem.reInclude(subSlot, "EasyBuy_SubItemSlot", ii, stc_subSlot, self._subSlotConfing)
          subSlot:setItemByStaticStatus(subItemSSW, subItemCount, -1, false)
          subSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_EasyBuy_SubItemTooltip(true, true, " .. ii .. ", " .. ii - productItemCount .. ", " .. productInfo:getNoRaw() .. ", " .. productIndex .. ")")
          subSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_EasyBuy_SubItemTooltip(false)")
        end
      end
    end
    txt_mainSlotName:SetShow(true)
    txt_mainSlotName:SetTextMode(__eTextMode_LimitText)
    txt_mainSlotName:SetText(productInfo:getName())
    if subItemTotalCount > 1 then
      txt_mainSlotName:SetVerticalTop()
      txt_mainSlotName:SetSpanSize(txt_mainSlotName:GetSpanSize().x, 15)
    else
      txt_mainSlotName:SetVerticalMiddle()
      txt_mainSlotName:SetSpanSize(txt_mainSlotName:GetSpanSize().x, 0)
    end
    txt_mainSlotName:ComputePos()
    txt_price:SetShow(true)
    if productInfo:isApplyDiscount() then
      txt_price:SetText(makeDotMoney(productInfo:getOriginalPrice()) .. " -> <PAColor0xfface400>" .. makeDotMoney(productInfo:getPrice()) .. "<PAOldColor>")
    else
      txt_price:SetText(makeDotMoney(productInfo:getOriginalPrice()))
    end
    txt_price:SetSize(txt_price:GetTextSizeX(), txt_price:GetTextSizeY())
    txt_price:ComputePos()
    stc_pearlIcon:SetSpanSize(txt_price:GetSpanSize().x + txt_price:GetSizeX() + 5, stc_pearlIcon:GetSpanSize().y)
    stc_pearlIcon:ComputePos()
    btn_detail:SetShow(true)
    btn_detail:SetFontColor(Defines.Color.C_FFE0E0E0)
    btn_detail:SetEnable(true)
    btn_buy:SetShow(true)
    btn_buy:SetFontColor(4278239447)
    btn_buy:SetEnable(true)
    if (CppEnums.CashPurchaseLimitType.AtCharacter == limitType or CppEnums.CashPurchaseLimitType.AtAccount == limitType) and mylimitCount <= 0 then
      btn_detail:SetFontColor(4294077034)
      btn_detail:SetEnable(false)
      btn_buy:SetFontColor(4294077034)
      btn_buy:SetEnable(false)
    end
    btn_detail:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_FindItemFromPearlShop( " .. productInfo:getNoRaw() .. " )")
    btn_buy:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_BuyItem( " .. productInfo:getNoRaw() .. " )")
  end
end
