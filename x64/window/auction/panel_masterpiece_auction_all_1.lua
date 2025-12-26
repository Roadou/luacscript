function PaGlobal_Masterpiece_Auction_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:SetUiSetting()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Masterpiece_Auction_All:controlAll_Init()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Masterpiece_Auction_All, "StaticText_Title")
  self._ui.itemList.list2_lefeContent = UI.getChildControl(Panel_Masterpiece_Auction_All, "List2_LeftContent")
  self._ui.itemList.stc_centerBg = UI.getChildControl(Panel_Masterpiece_Auction_All, "Static_CenterBG01")
  self._ui.itemList.stc_auctionItemSlot = UI.getChildControl(self._ui.itemList.stc_centerBg, "Static_AuctionItemSlot")
  self._ui.itemList.txt_masterpieceName = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_MasterpieceName")
  self._ui.itemList.txt_masterpieceAuthor = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_MasterpieceAuthor")
  self._ui.itemList.txt_masterpieceStory = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_MasterpieceStory")
  self._ui.itemList.txt_currentPrice_title = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_CurrentPrice_Title")
  self._ui.itemList.txt_currentPrice_Value = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_CurrentPrice_Value")
  self._ui.stc_MoneyArea = UI.getChildControl(self._ui.itemList.stc_centerBg, "Static_MyMoneyArea")
  self._ui.txt_MoneyValue = UI.getChildControl(self._ui.stc_MoneyArea, "StaticText_MoneyValue")
  self._ui.itemList.txt_leftTime = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_LeftTime")
  self._ui.itemList.txt_masterpieceReady = UI.getChildControl(self._ui.itemList.stc_centerBg, "StaticText_MasterpieceReady")
  self._ui.bidList.list2_myBid = UI.getChildControl(Panel_Masterpiece_Auction_All, "List2_2")
  self._ui.rdo_buttons = UI.getChildControl(Panel_Masterpiece_Auction_All, "Static_RadioButtons")
  self._ui.btn_itemList = UI.getChildControl(self._ui.rdo_buttons, "RadioButton_ItemList")
  self._ui.btn_myBidList = UI.getChildControl(self._ui.rdo_buttons, "RadioButton_MyBidList")
  self._ui.stc_selectLine = UI.getChildControl(self._ui.rdo_buttons, "Static_SelctLine")
  self._ui.txt_bottomDesc = UI.getChildControl(Panel_Masterpiece_Auction_All, "StaticText_BottomDesc")
  self._ui.btn_Reload = UI.getChildControl(self._ui.rdo_buttons, "Button_AddFriend")
  local listContent = UI.getChildControl(self._ui.bidList.list2_myBid, "List2_1_Content")
  local leftSlot = {}
  local leftButton = UI.getChildControl(listContent, "Static_LeftButton")
  local itemlistSlot = UI.getChildControl(leftButton, "Static_ItemSlotBg1")
  SlotItem.new(leftSlot, "MasterpieceAuction_Slot_Icon_", 0, itemlistSlot, self._slotConfig)
  leftSlot:createChild()
  leftSlot.empty = true
  leftSlot:clearItem()
  local rightSlot = {}
  local rightButton = UI.getChildControl(listContent, "Static_RightButton")
  local itemlistSlot = UI.getChildControl(rightButton, "Static_ItemSlotBg1")
  SlotItem.new(rightSlot, "MasterpieceAuction_Slot_Icon_", 0, itemlistSlot, self._slotConfig)
  rightSlot:createChild()
  rightSlot.empty = true
  rightSlot:clearItem()
  if false == self._isConsole then
    local myBiddingListBg1 = UI.getChildControl(leftButton, "Static_MyBiddingListBg1")
    myBiddingListBg1:ReleaseTexture()
    myBiddingListBg1:ChangeTextureInfoNameAsync("")
    myBiddingListBg1:ChangeOnTextureInfoNameAsync("")
    myBiddingListBg1:ChangeClickTextureInfoNameAsync("")
    myBiddingListBg1:ChangeTextureInfoNameAsync("combine/frame/combine_frame_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(myBiddingListBg1, 256, 1, 306, 51)
    myBiddingListBg1:getBaseTexture():setUV(x1, y1, x2, y2)
    local myBiddingListBg2 = UI.getChildControl(rightButton, "Static_MyBiddingListBg1")
    myBiddingListBg2:ReleaseTexture()
    myBiddingListBg2:ChangeTextureInfoNameAsync("")
    myBiddingListBg2:ChangeOnTextureInfoNameAsync("")
    myBiddingListBg2:ChangeClickTextureInfoNameAsync("")
    myBiddingListBg2:ChangeTextureInfoNameAsync("combine/frame/combine_frame_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(myBiddingListBg2, 256, 1, 306, 51)
    myBiddingListBg2:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  self._PANELSIZEY = Panel_Masterpiece_Auction_All:GetSizeY()
  self._DESCSIZEY = self._ui.txt_bottomDesc:GetSizeY()
end
function PaGlobal_Masterpiece_Auction_All:controlPc_Init()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  local title = UI.getChildControl(Panel_Masterpiece_Auction_All, "StaticText_Title")
  self._ui_pc.btn_close = UI.getChildControl(title, "Button_Close")
  self._ui_pc.btn_question = UI.getChildControl(title, "Button_Question")
  self._ui_pc.btn_detach = UI.getChildControl(title, "Button_DetachUI")
  self._ui_pc.btn_bid = UI.getChildControl(self._ui.itemList.stc_centerBg, "Button_Bid")
end
function PaGlobal_Masterpiece_Auction_All:controlConsole_Init()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui_console.stc_buttonGuide = UI.getChildControl(Panel_Masterpiece_Auction_All, "Static_ButtonGuide_C")
  self._ui_console.stc_iconLB = UI.getChildControl(self._ui.rdo_buttons, "Static_SelectLB_C")
  self._ui_console.stc_iconRB = UI.getChildControl(self._ui.rdo_buttons, "Static_SelectRB_C")
end
function PaGlobal_Masterpiece_Auction_All:SetUiSetting()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui_pc.btn_question:SetShow(false)
  self._ui_pc.btn_detach:SetShow(false)
  if false == PaGlobal_Masterpiece_Auction_All._isConsole then
    self._ui_console.stc_buttonGuide:SetShow(false)
    self._ui_console.stc_iconLB:SetShow(false)
    self._ui_console.stc_iconRB:SetShow(false)
  else
    self._ui.btn_Reload:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_console.stc_buttonGuide:SetShow(true)
    self._ui_console.stc_iconLB:SetShow(true)
    self._ui_console.stc_iconRB:SetShow(true)
  end
  self._ui.itemList._slotItem = {}
  SlotItem.new(self._ui.itemList._slotItem, "MasterpieceAuction_Slot_Icon_", 0, self._ui.itemList.stc_auctionItemSlot, self._slotConfig)
  self._ui.itemList._slotItem:createChild()
  FromClient_Masterpiece_Auction_All_ReSizePanel()
end
function PaGlobal_Masterpiece_Auction_All:registEventHandler()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Masterpiece_Auction_All_ReSizePanel()")
  registerEvent("FromClient_ResponseAuction_UpdateAuctionList", "FromClient_Masterpiece_Auction_All_UpdateAuctionList")
  registerEvent("FromClient_BidAuctionGoods", "FromClient_Masterpiece_Auction_All_BidAuctionGoods")
  registerEvent("EventWarehouseUpdate", "FromClient_Masterpiece_Auction_All_WarehouseUpdate")
  self._ui.itemList.list2_lefeContent:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Masterpiece_Auction_All_ItemListControlCreate")
  self._ui.itemList.list2_lefeContent:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.bidList.list2_myBid:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_Masterpiece_Auction_All_BidListControlCreate")
  self._ui.bidList.list2_myBid:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Masterpiece_Auction_All_Close()")
    self._ui.btn_itemList:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_TabSelect()")
    self._ui.btn_myBidList:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_TabSelect()")
    self._ui.btn_Reload:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_Reload()")
    self._ui_pc.btn_bid:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_BidButton()")
  else
    Panel_Masterpiece_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_Masterpiece_Auction_All_Close()")
    Panel_Masterpiece_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventPadRBLB_Masterpiece_Auction_All_ToggleTab( -1 )")
    Panel_Masterpiece_Auction_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventPadRBLB_Masterpiece_Auction_All_ToggleTab( 1 )")
  end
end
function PaGlobal_Masterpiece_Auction_All:prepareOpen()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self:setOpenUiSetting()
  PaGlobal_Masterpiece_Auction_All:open()
end
function PaGlobal_Masterpiece_Auction_All:open()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  Panel_Masterpiece_Auction_All:SetShow(true)
end
function PaGlobal_Masterpiece_Auction_All:prepareClose()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self:clearSlotItem()
  self._isOpenEscMenu = false
  self._isItemList = true
  self._selectListIndex = 0
  self._TABMENU.COUNT = 1
  PaGlobal_Masterpiece_Auction_All:close()
end
function PaGlobal_Masterpiece_Auction_All:close()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  Panel_Masterpiece_Auction_All:SetShow(false)
end
function PaGlobal_Masterpiece_Auction_All:update()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
end
function PaGlobal_Masterpiece_Auction_All:validate()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self:allValidate()
  self:pcValidate()
  self:consoleValidate()
end
function PaGlobal_Masterpiece_Auction_All:allValidate()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui.itemList.list2_lefeContent:isValidate()
  self._ui.itemList.stc_centerBg:isValidate()
  self._ui.itemList.stc_auctionItemSlot:isValidate()
  self._ui.itemList.txt_masterpieceName:isValidate()
  self._ui.itemList.txt_masterpieceAuthor:isValidate()
  self._ui.itemList.txt_masterpieceStory:isValidate()
  self._ui.itemList.txt_currentPrice_title:isValidate()
  self._ui.itemList.txt_currentPrice_Value:isValidate()
  self._ui.itemList.txt_leftTime:isValidate()
  self._ui.itemList.txt_masterpieceReady:isValidate()
  self._ui.bidList.list2_myBid:isValidate()
  self._ui.btn_itemList:isValidate()
  self._ui.btn_myBidList:isValidate()
  self._ui.stc_selectLine:isValidate()
  self._ui.txt_bottomDesc:isValidate()
  self._ui.btn_Reload:isValidate()
end
function PaGlobal_Masterpiece_Auction_All:pcValidate()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui_pc.btn_close:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_detach:isValidate()
  self._ui_pc.btn_bid:isValidate()
end
function PaGlobal_Masterpiece_Auction_All:consoleValidate()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui_console.stc_buttonGuide:isValidate()
  self._ui_console.stc_iconLB:isValidate()
  self._ui_console.stc_iconRB:isValidate()
end
function PaGlobal_Masterpiece_Auction_All:updateItemList()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  local itemListCount = myAuctionInfo:getItemAuctionListCount()
  if 0 == itemListCount then
    self:clearSlotItem()
    self:itemListSetting(false)
  else
    self:itemListSetting(true)
  end
  self._ui.itemList.list2_lefeContent:getElementManager():clearKey()
  for itemCount = 0, itemListCount - 1 do
    self._ui.itemList.list2_lefeContent:getElementManager():pushKey(toInt64(0, itemCount))
  end
end
function PaGlobal_Masterpiece_Auction_All:itemListSetting(isShow)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_Masterpiece_Auction_All:itemListSetting\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  self._ui.itemList.txt_masterpieceReady:SetShow(false == isShow)
  self._ui.itemList.txt_masterpieceName:SetShow(isShow)
  self._ui.itemList.txt_masterpieceAuthor:SetShow(isShow)
  self._ui.itemList.txt_masterpieceStory:SetShow(isShow)
  self._ui.itemList.list2_lefeContent:SetShow(true)
  if false == isShow then
    self._ui.itemList.txt_currentPrice_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECE_LOWPRICE"))
    self._ui.itemList.txt_currentPrice_Value:SetText(makeDotMoney(0))
    self._ui.itemList.txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MASTERPIECE_LEFTTIME", "time", tostring(Util.Time.timeFormatting_Minute(0))))
    self._ui.itemList.txt_leftTime:SetPosX(self._LEFTTIMEPOSX - self._ui.itemList.txt_leftTime:GetTextSizeX() * 0.5)
  end
  self:openEscMenuSetting()
  local invenMoney = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
  self._ui.txt_MoneyValue:SetText(makeDotMoney(invenMoney))
end
function PaGlobal_Masterpiece_Auction_All:openEscMenuSetting()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  if false == self._isOpenEscMenu then
    self._ui.stc_MoneyArea:SetShow(true)
    self._ui.itemList.txt_currentPrice_title:SetShow(true)
    self._ui.itemList.txt_currentPrice_Value:SetShow(true)
  end
  self:setNotice()
end
function PaGlobal_Masterpiece_Auction_All:updateBidList()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  local myAuctionInfo = RequestGetAuctionInfo()
  if nil == myAuctionInfo then
    return
  end
  warehouse_requestInfoFromNpc()
  self._ui.bidList.list2_myBid:getElementManager():clearKey()
  local bidCount = myAuctionInfo:getMyItemBidListCount()
  local bidItemListCount = bidCount / 2 + bidCount % 2
  for index = 0, bidItemListCount - 1 do
    self._ui.bidList.list2_myBid:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_Masterpiece_Auction_All:bidListControlCreate(control, key)
  if control == nil then
    return
  end
  local auctionInfo = RequestGetAuctionInfo()
  if auctionInfo == nil then
    return
  end
  local key_32 = Int64toInt32(key)
  local leftKey = key_32 * 2
  local rightKey = key_32 * 2 + 1
  PaGlobal_Masterpiece_Auction_All:setBidListControl(auctionInfo, control, leftKey, true)
  PaGlobal_Masterpiece_Auction_All:setBidListControl(auctionInfo, control, rightKey, false)
end
function PaGlobal_Masterpiece_Auction_All:setBidListControl(auctionInfo, control, key, isLeft)
  if auctionInfo == nil or control == nil or key == nil then
    return
  end
  local btn_bidcontent
  if isLeft == true then
    btn_bidcontent = UI.getChildControl(control, "Static_LeftButton")
  else
    btn_bidcontent = UI.getChildControl(control, "Static_RightButton")
  end
  if btn_bidcontent == nil then
    return
  end
  btn_bidcontent:SetShow(false)
  local auctionType = auctionInfo:getAuctionType()
  local goodsInfo = auctionInfo:getMyItemBidListAt(key)
  if goodsInfo == nil then
    return
  end
  btn_bidcontent:SetShow(true)
  local txt_bidItemName = UI.getChildControl(btn_bidcontent, "StaticText_BidItemName1")
  local stc_bidItemSlot = UI.getChildControl(btn_bidcontent, "Static_ItemSlotBg1")
  local txt_bidLeftTime = UI.getChildControl(btn_bidcontent, "StaticText_LeftTime1")
  local stc_bidItemCondition = UI.getChildControl(btn_bidcontent, "Static_BidCondition1")
  local btn_bidItem = UI.getChildControl(btn_bidcontent, "Button_Auction1")
  local txt_bidPriceTitle = UI.getChildControl(btn_bidcontent, "StaticText_BidPriceTitle1")
  local txt_bidPrice = UI.getChildControl(btn_bidcontent, "StaticText_BidMoney1")
  btn_bidItem:SetMonoTone(true)
  btn_bidItem:SetIgnore(true)
  stc_bidItemCondition:ChangeTextureInfoNameAsync("combine/etc/combine_etc_imperialauction.dds")
  local leftTime_u64 = goodsInfo:getExpireTime_u64() / toUint64(0, 1000)
  local highPrice_s64 = goodsInfo:getUpperBidPrice_s64()
  local myPrice_s64 = goodsInfo:getMyBidPrice_s64()
  local isBiddable = goodsInfo:isSuccessBid()
  local isEnd = goodsInfo:isAuctionEnd()
  local texUVKey = 1
  if isBiddable == true or isEnd == false then
    local itemWrapper = goodsInfo:getItem()
    if itemWrapper == nil then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if itemSSW == nil then
      return
    end
    local slot = {}
    SlotItem.reInclude(slot, "MasterpieceAuction_Slot_Icon_", 0, stc_bidItemSlot, PaGlobal_Masterpiece_Auction_All._slotConfig)
    slot:clearItem()
    slot:setItem(itemWrapper)
    slot.icon:addInputEvent("Mouse_On", "HandleEventOn_Masterpiece_Auction_All_ShowTooltip(true," .. key .. "," .. auctionType .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_Masterpiece_Auction_All_ShowTooltip(false," .. key .. "," .. auctionType .. ")")
    txt_bidItemName:SetText(itemSSW:getName())
    UI.setLimitTextAndAddTooltip(txt_bidItemName)
    txt_bidLeftTime:SetText(tostring(Util.Time.timeFormatting_Minute(Int64toInt32(leftTime_u64))))
    txt_bidPrice:SetText(makeDotMoney(myPrice_s64))
    if highPrice_s64 > myPrice_s64 then
      btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_RECIEVEMONEY"))
      btn_bidItem:SetMonoTone(false)
      btn_bidItem:SetIgnore(false)
      btn_bidItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_CancelBidorSell(" .. key .. ")")
      texUVKey = 2
    elseif isBiddable then
      btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_RECIEVEITEM"))
      btn_bidItem:SetMonoTone(false)
      btn_bidItem:SetIgnore(false)
      btn_bidItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_GetSuccessItemorMoney(" .. key .. ")")
      texUVKey = 3
    else
      btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_TOPPRICEITEM"))
      btn_bidItem:SetMonoTone(true)
      btn_bidItem:SetIgnore(false)
      btn_bidItem:addInputEvent("Mouse_LUp", "")
      texUVKey = 1
    end
  else
    txt_bidPrice:SetText(makeDotMoney(myPrice_s64))
    btn_bidItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_RECIEVEMONEY"))
    btn_bidItem:SetMonoTone(false)
    btn_bidItem:SetIgnore(false)
    btn_bidItem:addInputEvent("Mouse_LUp", "HandleEventLUp_Masterpiece_Auction_All_CancelBidorSell(" .. key .. ")")
  end
  local x1, y1, x2, y2 = setTextureUV_Func(stc_bidItemCondition, PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][1], PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][2], PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][3], PaGlobal_Masterpiece_Auction_All._bidConditionUV[texUVKey][4])
  stc_bidItemCondition:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_bidItemCondition:setRenderTexture(stc_bidItemCondition:getBaseTexture())
end
function PaGlobal_Masterpiece_Auction_All:bidListSetting(isShow)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_Masterpiece_Auction_All:itemListSetting\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  self._ui.bidList.list2_myBid:SetShow(isShow)
end
function PaGlobal_Masterpiece_Auction_All:setOpenUiSetting()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui_pc.btn_bid:SetMonoTone(true)
  self._ui_pc.btn_bid:SetIgnore(true)
  self._ui_pc.btn_bid:addInputEvent("Mouse_LUp", "")
  self._ui.itemList.txt_masterpieceName:SetText("")
  self._ui.itemList.txt_masterpieceAuthor:SetText("")
  self._ui.itemList.txt_masterpieceStory:SetText("")
  self._ui.itemList.txt_currentPrice_Value:SetText("0")
  self:setItemListSetting(true)
  self:updateItemList()
  self._ui.btn_itemList:SetCheck(true)
  self._ui.btn_myBidList:SetCheck(false)
  self:setNotice()
  HandleEventLUp_Masterpiece_Auction_All_SetInfomation(self._selectListIndex)
end
function PaGlobal_Masterpiece_Auction_All:setItemListSetting(isShow)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_Masterpiece_Auction_All:setItemListSetting\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  local isBidListShow = false
  if true == isShow then
    self._ui.stc_selectLine:SetPosX(self._ui.btn_itemList:GetPosX() + self._ui.btn_itemList:GetSizeX() * 0.3)
    isBidListShow = false
  else
    isBidListShow = true
  end
  self:setBidListSetting(isBidListShow)
  if true == PaGlobal_Masterpiece_Auction_All._ui.btn_itemList:IsCheck() then
    self._ui.itemList.list2_lefeContent:SetShow(true)
  else
    self._ui.itemList.list2_lefeContent:SetShow(false)
  end
  self._ui.itemList.stc_centerBg:SetShow(isShow)
  self._ui.itemList.stc_auctionItemSlot:SetShow(isShow)
  self._ui.itemList.txt_masterpieceName:SetShow(isShow)
  self._ui.itemList.txt_masterpieceAuthor:SetShow(isShow)
  self._ui.itemList.txt_masterpieceStory:SetShow(isShow)
  self._ui.itemList.txt_currentPrice_title:SetShow(isShow)
  self._ui.itemList.txt_currentPrice_Value:SetShow(isShow)
  self._ui.itemList.txt_leftTime:SetShow(isShow)
  self._ui.stc_MoneyArea:SetShow(isShow)
end
function PaGlobal_Masterpiece_Auction_All:setBidListSetting(isShow)
  UI.ASSERT_NAME(nil ~= isShow, "PaGlobal_Masterpiece_Auction_All:setBidListSetting\236\157\152 isShow nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  self._ui.bidList.list2_myBid:SetShow(isShow)
  self._ui.txt_bottomDesc:SetShow(isShow)
  if true == isShow then
    self._ui.stc_selectLine:SetPosX(self._ui.btn_myBidList:GetPosX() + self._ui.btn_myBidList:GetSizeX() * 0.3)
    self:updateBidList()
  end
end
function PaGlobal_Masterpiece_Auction_All:clearSlotItem()
  self._ui.itemList._slotItem.icon:addInputEvent("Mouse_On", "")
  self._ui.itemList._slotItem.icon:addInputEvent("Mouse_Out", "")
  self._ui.itemList._slotItem:clearItem()
end
function PaGlobal_Masterpiece_Auction_All:bidTypeMessage(idx)
  UI.ASSERT_NAME(nil ~= idx, "PaGlobal_Masterpiece_Auction_All:bidTypeMessage\236\157\152 idx nil\236\157\180\235\169\180 \236\149\136\235\144\156\235\139\164.", "\234\185\128\236\156\164\236\167\128")
  if 2 == index then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECEAUCTION_BIDTYPEMESSAGE_" .. index))
  end
  self._bidTypeIndex = self._bidType._bidNone
end
function PaGlobal_Masterpiece_Auction_All:setNotice()
  if nil == Panel_Masterpiece_Auction_All then
    return
  end
  local descText = ""
  local sizeY = 0
  self._ui.txt_bottomDesc:SetSize(self._ui.txt_bottomDesc:GetSizeX(), self._DESCSIZEY)
  Panel_Masterpiece_Auction_All:SetSize(Panel_Masterpiece_Auction_All:GetSizeX(), self._PANELSIZEY)
  if false == self._isOpenEscMenu then
    self._ui.btn_myBidList:SetShow(true)
    self._ui_console.stc_iconLB:SetShow(true == self._isConsole)
    self._ui_console.stc_iconRB:SetShow(true == self._isConsole)
    self._ui_pc.btn_bid:SetShow(true)
    if true == self._isItemList then
      self._ui.txt_bottomDesc:SetShow(false)
    else
      descText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MASTERPIECEAUCTION_DESC")
      self._ui.txt_bottomDesc:SetShow(true)
      self._ui.txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
      self._ui.txt_bottomDesc:setPadding(CppEnums.Padding.ePadding_Right, 5)
      self._ui.txt_bottomDesc:SetText(descText)
    end
  else
    self._ui.btn_myBidList:SetShow(false)
    self._ui_console.stc_iconLB:SetShow(false)
    self._ui_console.stc_iconRB:SetShow(false)
    self._ui_pc.btn_bid:SetShow(false)
    descText = PAGetString(Defines.StringSheet_GAME, "LUA_MASTERPIECE_AUCTION_BOTTOMDESC")
    self._ui.txt_bottomDesc:SetShow(true)
    self._ui.txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_bottomDesc:setPadding(CppEnums.Padding.ePadding_Right, 5)
    self._ui.txt_bottomDesc:SetText(descText)
  end
  local gab = 20
  local descSizeX = self._ui.txt_bottomDesc:GetSizeX()
  local descTextSizeY = self._ui.txt_bottomDesc:GetTextSizeY()
  local descBgSizeY = descTextSizeY + gab
  if true == self._ui.txt_bottomDesc:GetShow() then
    if true == self._isItemList then
      self._ui.txt_bottomDesc:SetSize(descSizeX, descBgSizeY)
      Panel_Masterpiece_Auction_All:SetSize(Panel_Masterpiece_Auction_All:GetSizeX(), self._PANELSIZEY + descBgSizeY + gab)
    else
      local addSizeY = 0
      if descTextSizeY > self._DESCSIZEY then
        addSizeY = descBgSizeY - self._DESCSIZEY
      end
      self._ui.txt_bottomDesc:SetSize(descSizeX, self._DESCSIZEY + addSizeY)
      Panel_Masterpiece_Auction_All:SetSize(Panel_Masterpiece_Auction_All:GetSizeX(), self._PANELSIZEY + addSizeY)
    end
  end
  FromClient_Masterpiece_Auction_All_ReSizePanel()
  self:setPosControl()
end
function PaGlobal_Masterpiece_Auction_All:setPosControl()
  if true == self._isItemList then
    self._ui.stc_selectLine:SetPosX(self._ui.btn_itemList:GetPosX() + self._ui.btn_itemList:GetSizeX() * 0.3)
  else
    self._ui.stc_selectLine:SetPosX(self._ui.btn_myBidList:GetPosX() + self._ui.btn_myBidList:GetSizeX() * 0.3)
  end
  self._ui.itemList.txt_leftTime:SetPosX(self._LEFTTIMEPOSX - self._ui.itemList.txt_leftTime:GetTextSizeX() * 0.5)
end
