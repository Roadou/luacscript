function PaGlobal_IngameCashSHop_ReturnBack_Open(index, controlIndex, eventCartNo)
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  if PaGlobal_IngameCashShop_DescClose ~= nil then
    PaGlobal_IngameCashShop_DescClose()
  end
  PaGlobal_IngameCashSHop_ReturnBack._selectPrepareIndex = -1
  if 0 < ToClient_GetMoonBlessingIndexByIndex(index) then
    ToClient_RequestRefundMoonBlessingList(index, controlIndex, eventCartNo)
    PaGlobal_IngameCashSHop_ReturnBack._selectPrepareIndex = index
  else
    PaGlobal_IngameCashSHop_ReturnBack:prepareOpen(index, controlIndex, eventCartNo)
  end
end
function PaGlobal_IngameCashSHop_ReturnBack_Close()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack:prepareClose()
end
function HandleEventOnOut_IngameCashSHop_ReturnBack_ItemShowToolTip(isShow, index)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local productNo = ToClient_GetPurchaseItemCashProdcutNoByIndex(PaGlobal_IngameCashSHop_ReturnBack._selectIndex)
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
  if nil == cashProduct then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local mainItemCount = cashProduct:getItemListCount()
  local itemSSW
  if index <= mainItemCount then
    itemSSW = cashProduct:getItemByIndex(index - 1)
  else
    itemSSW = cashProduct:getSubItemByIndex(index - mainItemCount - 1)
  end
  if itemSSW == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, PaGlobal_IngameCashSHop_ReturnBack._subSlot[index], true)
end
function HandleEventOnOut_IngameCashSHop_ReturnBack_ItemShowToolTip2(isShow, productNo, index, controlIndex)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
  if nil == cashProduct then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = cashProduct:getItemByIndex(index)
  if nil == itemSSW then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, PaGlobal_IngameCashSHop_ReturnBack._subSlot[controlIndex], true)
end
function HandleEventOnOut_IngameCashShop_ReturnBack_ItemShowToolTipForEventCart(isShow, productNo, index, keyString)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
  if nil == cashProduct then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = cashProduct:getItemByIndex(index - 1)
  if nil == itemSSW then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local key = tonumber64(keyString)
  local control = PaGlobal_IngameCashSHop_ReturnBack._ui._list2:GetContentByKey(key)
  if control == nil then
    return
  end
  local itemSlotBG = UI.getChildControl(control, "Static_ItemSlotBG")
  if itemSlotBG == nil then
    return
  end
  local subSlot = UI.getChildControl(itemSlotBG, "Static_SubSlot_" .. tostring(index))
  if subSlot == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, subSlot, true)
end
function HandleEventOnOut_IngameCashSHop_ReturnBack_SimpletooltipTitle(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_COUPON_TITLE")
  TooltipSimple_Show(PaGlobal_IngameCashSHop_ReturnBack._ui._stc_couponIcon, name, PaGlobal_IngameCashSHop_ReturnBack._ui._stc_couponName:GetText())
end
function HandleEventOnOut_IngameCashSHop_ReturnBack_ShowToolTip(isShow, productKeyRaw)
  if false == isShow then
    FGlobal_CashShop_GoodsTooltipInfo_Close()
    return
  end
  FGlobal_CashShop_GoodsTooltipInfo_Open(productKeyRaw, PaGlobal_IngameCashSHop_ReturnBack._ui._stc_productIcon, false)
end
function HandleEventLUp_IngameCashSHop_SetFocusEdit()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  SetFocusEdit(PaGlobal_IngameCashSHop_ReturnBack._ui._edit_check)
end
function HandleEventLUp_IngameCashSHop_RequestRefund()
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  if PaGlobal_IngameCashSHop_ReturnBack._selectIndex == -1 then
    return
  end
  if PaGlobal_IngameCashSHop_ReturnBack._ui._edit_check:GetEditText() ~= PaGlobal_IngameCashSHop_ReturnBack._ui._stc_check:GetText() then
    local text = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURN_ERROR_WORD", "confirmTxt", PaGlobal_IngameCashSHop_ReturnBack._ui._stc_check:GetText())
    Proc_ShowMessage_Ack(text)
    PaGlobal_IngameCashSHop_ReturnBack._ui._edit_check:EraseAllEffect()
    PaGlobal_IngameCashSHop_ReturnBack._ui._edit_check:AddEffect("fUI_InGame_Light_05A", false, 0, 0)
    return
  end
  local requestRefund = function()
    ToClient_RequestRefundPurchaseCashProduct(PaGlobal_IngameCashSHop_ReturnBack._selectIndex)
  end
  local productName = ""
  local pearlCount = Int64toInt32(ToClient_GetPurchaseRealUsePearByIndex(PaGlobal_IngameCashSHop_ReturnBack._selectIndex))
  if PaGlobal_IngameCashSHop_ReturnBack._ui._list2:GetShow() == true then
    productName = PaGlobal_IngameCashSHop_ReturnBack:getEventCartInfo()
  else
    productName = PaGlobal_IngameCashSHop_ReturnBack._ui._stc_productName:GetText()
  end
  local text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURN_RETURN_MSG_DESC", "productName", productName, "pearlCount", pearlCount)
  local messageBoxMemo = text
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_RETURN_RETURN_MSG_TITLE"),
    content = messageBoxMemo,
    functionYes = requestRefund,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventOnOut_IngameCashSHop_ShowRefundMoonBlessingItemTooltip(key, itemEnchantKey, isShow)
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack:showRefundMoonBlessingItemTooltip(key, itemEnchantKey, isShow)
end
function FromClient_IngameCashSHop_UpdateContent(control, key)
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack:updateControl(control, key)
end
function FromClient_RefundMoonBlessingPrepareList(controlIndex, eventCartNo)
  if nil == Panel_IngameCashSHop_ReturnBack then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack:prepareClose()
  PaGlobal_IngameCashSHop_ReturnBack:prepareOpen(PaGlobal_IngameCashSHop_ReturnBack._selectPrepareIndex, controlIndex, eventCartNo)
end
