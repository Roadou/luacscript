function HandleEventLUp_WebPurchaseConfirm_All_RequestReceive()
  if PaGlobal_WebPurchaseConfirm_All == nil then
    return
  end
  ToClient_GetPurchaseCashProductFromWebRequest()
end
function FromClient_WebPurchaseConfirm_All_UpdateItemList(control, key)
  if PaGlobal_WebPurchaseConfirm_All == nil then
    return
  end
  local index = Int64toInt32(key)
  local productNo = ToClient_getWebCashRestoreCashProductNoByIndex(index)
  local stc_imgBG = UI.getChildControl(control, "Static_SlotBG")
  local stc_img = UI.getChildControl(stc_imgBG, "StaticText_Slot")
  local txt_enchant = UI.getChildControl(stc_imgBG, "StaticText_Enchant")
  local cashProduct = getIngameCashMall():getCashProductStaticStatusByProductNoRaw(productNo)
  if nil == cashProduct then
    return
  end
  control:addInputEvent("Mouse_On", "PaGlobalFunc_WebPurchaseConfirm_All_ShowItemToolTip( " .. productNo .. ", " .. index .. " )")
  control:addInputEvent("Mouse_Out", "FGlobal_CashShop_GoodsTooltipInfo_Close()")
  stc_img:ChangeTextureInfoNameAsync("icon/" .. cashProduct:getIconPath())
  stc_img:setRenderTexture(stc_img:getBaseTexture())
  txt_enchant:SetShow(false)
  local txt_itemName = UI.getChildControl(control, "StaticText_ItemName")
  txt_itemName:SetTextMode(__eTextMode_LimitText)
  txt_itemName:SetText(cashProduct:getDisplayName())
  local txt_count = UI.getChildControl(control, "StaticText_count")
  local count32 = Int64toInt32(ToClient_getWebCashRestoreCountByIndex(index))
  txt_count:SetText("X " .. count32)
  PaGlobal_WebPurchaseConfirm_All._ui._itemList:push_back(control)
end
function PaGlobalFunc_WebPurchaseConfirm_All_Open()
  if PaGlobal_WebPurchaseConfirm_All == nil then
    return
  end
  PaGlobal_WebPurchaseConfirm_All:prepareOpen()
  if HandleEventLUp_Inventory_All_cashProductRestoreBgClose ~= nil then
    HandleEventLUp_Inventory_All_cashProductRestoreBgClose()
  end
end
function PaGlobalFunc_WebPurchaseConfirm_All_Close()
  if PaGlobal_WebPurchaseConfirm_All == nil then
    return
  end
  PaGlobal_WebPurchaseConfirm_All:prepareClose()
end
function PaGlobalFunc_WebPurchaseConfirm_All_ClearItemList()
  PaGlobal_WebPurchaseConfirm_All._ui._purchaseItemList:getElementManager():clearKey()
end
function PaGlobalFunc_WebPurchaseConfirm_All_ShowItemToolTip(productKeyRaw, index)
  local control = Panel_Window_WebPurchaseConfirm_All
  FGlobal_CashShop_GoodsTooltipInfo_Open(productKeyRaw, control)
end
function PaGlobalFunc_NotifyWebCashRestoreCount(webCashRestoreCount)
  if Panel_Window_WebPurchaseConfirm_All ~= nil and Panel_Window_WebPurchaseConfirm_All:GetShow() == true then
    if webCashRestoreCount == 0 then
      PaGlobalFunc_WebPurchaseConfirm_All_Close()
    else
      PaGlobal_WebPurchaseConfirm_All:prepareOpen()
    end
  end
end
function PaGlobalFunc_WebPurchaseConfirmButtonSimpleTooltip(isShow)
  if nil == Panel_Window_WebPurchaseConfirm_All then
    return
  end
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_GETITEM_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_BUYCASHBOX_GETITEM_TOOLTIP_DESC")
  if nil ~= PaGlobal_WebPurchaseConfirm_All._ui._btn_yes then
    TooltipSimple_Show(PaGlobal_WebPurchaseConfirm_All._ui._btn_yes, name, desc)
  end
end
function PaGlobalFunc_WebPurchaseConfirm_All_MoveScroll(isUp)
  if Panel_Window_WebPurchaseConfirm_All == nil then
    return
  end
  if isUp == true then
    PaGlobal_WebPurchaseConfirm_All._ui._purchaseItemList:MouseUpScroll(PaGlobal_WebPurchaseConfirm_All._ui._purchaseItemList)
  else
    PaGlobal_WebPurchaseConfirm_All._ui._purchaseItemList:MouseDownScroll(PaGlobal_WebPurchaseConfirm_All._ui._purchaseItemList)
  end
end
