function EasybuyShowAni()
  local ImageMoveAni = Panel_IngameCashShop_EasyPayment:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX() / 2 - Panel_IngameCashShop_EasyPayment:GetSizeX() / 2, 0 - Panel_IngameCashShop_EasyPayment:GetSizeY())
  ImageMoveAni:SetEndPosition(getScreenSizeX() / 2 - Panel_IngameCashShop_EasyPayment:GetSizeX() / 2, getScreenSizeY() - getScreenSizeY() / 2 - Panel_IngameCashShop_EasyPayment:GetSizeY() / 2)
  ImageMoveAni.IsChangeChild = true
  Panel_IngameCashShop_EasyPayment:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
end
function EasybuyHideAni()
  local ImageMoveAni = Panel_IngameCashShop_EasyPayment:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX() / 2 - Panel_IngameCashShop_EasyPayment:GetSizeX() / 2, getScreenSizeY() - getScreenSizeY() / 2 - Panel_IngameCashShop_EasyPayment:GetSizeY() / 2)
  ImageMoveAni:SetEndPosition(getScreenSizeX() / 2 - Panel_IngameCashShop_EasyPayment:GetSizeX() / 2, 0 - Panel_IngameCashShop_EasyPayment:GetSizeY())
  ImageMoveAni.IsChangeChild = true
  Panel_IngameCashShop_EasyPayment:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
  ImageMoveAni:SetDisableWhileAni(true)
end
function PaGlobal_EasyBuy:initialize()
  if self._isInitialized == true then
    return
  end
  local stc_title = UI.getChildControl(Panel_IngameCashShop_EasyPayment, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(stc_title, "Button_Win_Close")
  self._ui._lst_product = UI.getChildControl(Panel_IngameCashShop_EasyPayment, "List2_EasyBuy")
  local list2Content = UI.getChildControl(self._ui._lst_product, "List2_2_Content")
  local stc_cashProduct = UI.getChildControl(list2Content, "Static_CashProduct")
  local stc_mainItemSlot = UI.getChildControl(stc_cashProduct, "Static_MainItemSlot")
  local mainSlot = {}
  SlotItem.new(mainSlot, "EasyBuy_MainItemSlot", 0, stc_mainItemSlot, self._mainSlotConfing)
  mainSlot:createChild()
  local template_subSlotBg = UI.getChildControl(stc_cashProduct, "Template_Static_SubItemSlotBG")
  local template_subSlot = UI.getChildControl(stc_cashProduct, "Template_Static_SubItemSlot")
  local subSlotSizeX = template_subSlot:GetSizeX()
  local subSlotSizeY = template_subSlot:GetSizeY()
  for ii = 0, self._subSlotCountMax - 1 do
    local copy_subSlotBg = UI.cloneControl(template_subSlotBg, stc_cashProduct, "Static_SubItemSlotBG_" .. ii)
    if copy_subSlotBg ~= nil then
      copy_subSlotBg:SetSpanSize(template_subSlotBg:GetSpanSize().x + (copy_subSlotBg:GetSizeX() + 5) * ii, copy_subSlotBg:GetSpanSize().y)
      copy_subSlotBg:ComputePos()
      copy_subSlotBg:SetShow(true)
    end
    local copy_subSlot = UI.cloneControl(template_subSlot, stc_cashProduct, "Static_SubItemSlot_" .. ii)
    if copy_subSlot ~= nil then
      copy_subSlot:SetSpanSize(template_subSlot:GetSpanSize().x + (copy_subSlot:GetSizeX() + 5) * ii, copy_subSlot:GetSpanSize().y)
      copy_subSlot:ComputePos()
      copy_subSlot:SetShow(true)
      local subSlot = {}
      SlotItem.new(subSlot, "EasyBuy_SubItemSlot", ii, copy_subSlot, self._subSlotConfing)
      subSlot:createChild()
      subSlot.icon:SetShow(true)
      subSlot.icon:SetPosX(0)
      subSlot.icon:SetPosY(0)
      subSlot.icon:SetSize(subSlotSizeX, subSlotSizeY)
      subSlot.icon:ComputePos()
      subSlot.border:SetShow(true)
      subSlot.border:SetPosX(0)
      subSlot.border:SetPosY(0)
      subSlot.border:SetSize(subSlotSizeX, subSlotSizeY)
      subSlot.border:ComputePos()
    end
  end
  template_subSlotBg:SetShow(false)
  template_subSlot:SetShow(false)
  self._ui._stc_descBg = UI.getChildControl(Panel_IngameCashShop_EasyPayment, "Static_DescEdge")
  self._ui._stc_myPearlIcon = UI.getChildControl(self._ui._stc_descBg, "StaticText_MyPearlIcon")
  self._ui._txt_myPearlValue = UI.getChildControl(self._ui._stc_myPearlIcon, "StaticText_MyPearlValue")
  self._ui._txt_myPearl = UI.getChildControl(self._ui._stc_descBg, "StaticText_MyPearl")
  self:registerEvent()
  self._isInitialized = true
end
function PaGlobal_EasyBuy:registerEvent()
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  Panel_IngameCashShop_EasyPayment:RegisterShowEventFunc(true, "EasybuyShowAni()")
  Panel_IngameCashShop_EasyPayment:RegisterShowEventFunc(false, "EasybuyHideAni()")
  self._ui._lst_product:changeAnimationSpeed(10)
  self._ui._lst_product:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_EasyBuy_UpdateList")
  self._ui._lst_product:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_Close()")
  registerEvent("FromClient_NotifyPearlCount", "PaGlobalFunc_EasyBuy_MyPearlUpdate")
  registerEvent("FromClient_NotifyBuyCashItemForMe", "PaGlobalFunc_EasyBuy_MyPearlUpdate")
end
function PaGlobal_EasyBuy:prepareOpen(uniqueNo, waypointKey, immediatelyUse, tempCashItemSSW)
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  if isGameTypeGT() == true then
    return
  end
  if _ContentsGroup_EasyBuy == false then
    return
  end
  if ToClient_isBlockedCashShop() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoChangeCashProduct"))
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  if Panel_IngameCashShop_EasyPayment:GetShow() == true and Panel_Dialog_ServantInfo_All:GetShow() == false and Panel_Dialog_ServantInfo_All ~= nil then
    self:prepareClose()
    return
  end
  if isDeadInWatchingMode() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CASHSHOPOPENALERT_INDEAD"))
    return
  end
  if ToClient_IsConferenceMode() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_NOTUSE"))
    return
  end
  if FGlobal_IsCommercialService() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_NOTUSE"))
    return
  end
  if Panel_IngameCashShop:GetShow() == true then
    return
  end
  if getIngameCashMall() == nil then
    return
  end
  if getIngameCashMall():isShow() == true then
    return
  end
  local categoryInfo = getCategoryInfo(uniqueNo)
  if categoryInfo == nil or categoryInfo:getMainCategory() == -1 then
    return
  end
  if MessageBoxGetShow() == true then
    allClearMessageData()
  end
  if immediatelyUse == nil then
    self._immediatelyUse = true
  else
    self._immediatelyUse = immediatelyUse
  end
  if waypointKey == nil then
    waypointKey = -1
  end
  cashShop_requestCash()
  cashShop_requestCashShopList()
  PaymentPassword_Close()
  self.savedMainCategory = categoryInfo:getMainCategory()
  self.savedMiddleCategory = categoryInfo:getMiddleCategory()
  self.savedSmallCategory = categoryInfo:getSmallCategory()
  self.savedWayPointKey = waypointKey
  self.savedTempCashItemSSW = tempCashItemSSW
  self.deleteItemWhereType = CppEnums.ItemWhereType.eCount
  self.deleteItemSlotNo = __eTInventorySlotNoUndefined
  self:MyPearlUpdate()
  self:Update()
  self:open()
end
function PaGlobal_EasyBuy:open()
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  Panel_IngameCashShop_EasyPayment:SetShow(true, true)
end
function PaGlobal_EasyBuy:prepareClose()
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  if Panel_IngameCashShop_BuyOrGift:GetShow() == true then
    InGameShopBuy_Close()
  else
    self:close()
    getIngameCashMall():hide()
    PaGlobalFunc_WorkerManagerTooltip_All_Close()
    TooltipSimple_Hide()
    Panel_Tooltip_Item_hideTooltip()
    Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  end
  self.deleteItemWhereType = CppEnums.ItemWhereType.eCount
  self.deleteItemSlotNo = __eTInventorySlotNoUndefined
end
function PaGlobal_EasyBuy:close()
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  Panel_IngameCashShop_EasyPayment:SetShow(false, true)
end
function PaGlobal_EasyBuy:Update()
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  local productCount = getIngameCashMall():getListCountByCategoryLevel4(self.savedMainCategory, self.savedMiddleCategory, self.savedSmallCategory, self.savedWayPointKey)
  self._ui._lst_product:getElementManager():clearKey()
  if productCount > self._easyBuyCountCache then
    for idx = self._easyBuyCountCache, productCount - 1 do
      local productInfo = getIngameCashMall():getByCategoryLevel4(self.savedMainCategory, self.savedMiddleCategory, self.savedSmallCategory, self.savedWayPointKey, idx)
      if self.savedTempCashItemSSW == nil then
        if CheckCashProduct(productInfo) == true then
          self._ui._lst_product:getElementManager():pushKey(toInt64(0, idx))
        end
      else
        local productSSW = productInfo:getItemByIndex(0)
        if CheckCashProductInEasyPayment(productInfo) == true and productSSW:get()._key:getItemKey() == self.savedTempCashItemSSW:get()._key:getItemKey() then
          self._ui._lst_product:getElementManager():pushKey(toInt64(0, idx))
        end
      end
    end
  else
    for idx = productCount, self._easyBuyCountCache - 1 do
      local productInfo = getIngameCashMall():getByCategoryLevel4(self.savedMainCategory, self.savedMiddleCategory, self.savedSmallCategory, self.savedWayPointKey, idx)
      if self.savedTempCashItemSSW == nil then
        if CheckCashProduct(productInfo) == true then
          self._ui._lst_product:getElementManager():removeKey(toInt64(0, idx))
        end
      else
        local productSSW = productInfo:getItemByIndex(0)
        if CheckCashProductInEasyPayment(productInfo) == true and productSSW:get()._key:getItemKey() == self.savedTempCashItemSSW:get()._key:getItemKey() then
          self._ui._lst_product:getElementManager():removeKey(toInt64(0, idx))
        end
      end
    end
  end
end
function PaGlobal_EasyBuy:MyPearlUpdate()
  if Panel_IngameCashShop_EasyPayment == nil then
    return
  end
  local pearlItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eCashInventory, getPearlSlotNo())
  local pearl = 0
  if pearlItemWrapper ~= nil then
    pearl = pearlItemWrapper:get():getCount_s64()
  end
  self._ui._txt_myPearlValue:SetText(makeDotMoney(pearl))
  self._ui._txt_myPearlValue:SetSize(self._ui._txt_myPearlValue:GetTextSizeX(), self._ui._txt_myPearlValue:GetTextSizeY())
  self._ui._stc_myPearlIcon:SetSpanSize(self._ui._txt_myPearlValue:GetSpanSize().x + self._ui._txt_myPearlValue:GetSizeX(), self._ui._stc_myPearlIcon:GetSpanSize().y)
  self._ui._stc_myPearlIcon:ComputePosAllChild()
end
function PaGlobal_EasyBuy:checkExistCashItem(uniqueNo, waypointKey)
  if Panel_IngameCashShop_EasyPayment == nil then
    return false
  end
  local categoryInfo = getCategoryInfo(uniqueNo)
  if categoryInfo == nil or categoryInfo:getMainCategory() == -1 then
    return false
  end
  cashShop_requestCash()
  cashShop_requestCashShopList()
  local mainCategory = categoryInfo:getMainCategory()
  local middleCategory = categoryInfo:getMiddleCategory()
  local smallCategory = categoryInfo:getSmallCategory()
  local cashItemCount = getIngameCashMall():getListCountByCategoryLevel4(mainCategory, middleCategory, smallCategory, waypointKey)
  if cashItemCount == 0 then
    return false
  end
  return true
end
