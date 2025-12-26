function PaGlobalFunc_RandomShop_All_Open(slotNo, priceRate)
  PaGlobal_RandowShop_All:prepareOpen(slotNo, priceRate)
end
function PaGlobalFunc_RandomShop_All_Close()
  PaGlobal_RandowShop_All:prepareClose()
end
function HandleEventOn_RandomShop_All_ItemTooltip(ii, slotNo)
  if PaGlobal_RandowShop_All._isShowRandomItem == false then
    return
  end
  local itemwrapper = npcShop_getItemBuy(ii)
  if nil ~= itemwrapper then
    local itemRandomSS = itemwrapper:getStaticStatus()
    if true == PaGlobal_RandowShop_All._isConsole then
      if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
        return
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemRandomSS, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      Panel_Tooltip_Item_Show(itemRandomSS, PaGlobal_RandowShop_All._ui.stc_itemSlot, true, false, nil)
    end
  end
end
function HandleEventOut_RandomShop_All_ItemTooltipHide()
  if true == PaGlobal_RandowShop_All._isConsole then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleEventLUp_RandomShop_All_OtherItemShow()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_RESELECT_TITLE")
  local messageDesc = ""
  local isConsumWp = ToClient_getRandomShopConsumWp()
  local wp = getSelfPlayer():getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local useWp = 0
  if 12 == PaGlobal_RandowShop_All._shopTypeNum then
    useWp = ToClient_getRandomShopConsumWp()
  elseif 13 == PaGlobal_RandowShop_All._shopTypeNum then
    useWp = 10
  end
  if wp < useWp then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_WP_SHORTAGE_ACK"))
    return
  end
  local wpCharacterString = wp
  if _ContentsGroup_UseCharacterWp == true then
    wpCharacterString = wpCharacterString .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
  end
  if 12 == PaGlobal_RandowShop_All._shopTypeNum then
    messageDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_RESELECT_STRING", "getWp", wpCharacterString, "itemWP", isConsumWp)
  elseif 13 == PaGlobal_RandowShop_All._shopTypeNum then
    messageDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_RESELECT_STRING2", "getWp", wpCharacterString)
  end
  local messageboxData = {
    title = messageTitle,
    content = messageDesc,
    functionYes = PaGlobalFunc_RandomShop_All_RequestShopList,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_RandomShop_All_BuyItem()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_RESELECT_TITLE")
  local messageDesc = PAGetString(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_BUYITEMCONFIRM")
  local messageboxData = {
    title = messageTitle,
    content = messageDesc,
    functionYes = PaGlobalFunc_RandomShop_All_BuyItem,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_RandomShop_All_ReserveKeepItem()
  ToClient_ReserveRandomShopItem(PaGlobal_RandowShop_All._selectSlotNo, PaGlobal_RandowShop_All._priceRate)
end
function HandleEventOn_RandomShop_All_SetPayment()
end
function FromClient_RandomShop_All_EventRandomShopShow(shopType, slotNo, priceRate)
  if nil == Panel_Window_RandomShop_All then
    return
  end
  if nil == shopType or nil == slotNo or nil == priceRate then
    _PA_ASSERT_NAME(false, "FromClient_RandomShop_All_EventRandomShopShow\236\156\188\235\161\156 \235\147\164\236\150\180\236\152\164\235\138\148 \236\157\184\236\158\144\234\176\128 nil.", "\236\160\149\236\167\128\237\152\156")
  end
  PaGlobal_RandowShop_All._shopTypeNum = shopType
  if 12 == shopType or 13 == shopType then
    PaGlobalFunc_RandomShop_All_Open(slotNo, priceRate)
  end
end
function FromClient_RandomShop_All_UpdateRandomShopKeepTime(u16_year, u16_month, u16_day, u16_hour, u16_minute)
  if nil == Panel_Window_RandomShop_All then
    return
  end
  local tempStr = {
    [0] = tostring(u16_minute) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE"),
    [1] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_HOUR", "hour", tostring(u16_hour)),
    [2] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_DAY", "day", tostring(u16_day)),
    [3] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_MONTH", "month", tostring(u16_month)),
    [4] = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLD_MAP_SIEGE_YEAR", "year", tostring(u16_year))
  }
  local resultString = ""
  if true == isGameServiceTypeTurkey() then
    resultString = tempStr[2] .. "" .. tempStr[3] .. "" .. tempStr[4] .. "" .. tempStr[1] .. "" .. tempStr[0]
  else
    resultString = tempStr[4] .. "" .. tempStr[3] .. "" .. tempStr[2] .. "" .. tempStr[1] .. "" .. tempStr[0]
  end
  PaGlobal_RandowShop_All._ui.mtxt_reserveTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDTIME_RANDOMSHOPITEM") .. resultString)
end
function FromClient_RandomShop_All_NotifyRandomShop(notifyType)
  if 2 == notifyType then
    PaGlobalFunc_RandomShop_All_ReserveAni(false)
  elseif 3 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RESERVED_RANDOMSHOPITEM"))
    PaGlobalFunc_RandomShop_All_ReserveAni(true)
  elseif 4 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CLEAR_RANDOMSHOPITEM"))
    PaGlobalFunc_RandomShop_All_ReserveAni(false)
  elseif 5 == notifyType then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PURCHASE_RANDOMSHOPITEM"))
    PaGlobalFunc_RandomShop_All_ReserveAni(false)
  end
end
function FromClient_RandomShop_All_MoneyUpdate()
  PaGlobal_RandowShop_All:moneyUpdate()
end
function FromClient_RandomShop_All_WpChanged()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  if false == PaGlobal_RandowShop_All._initialize then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  PaGlobal_RandowShop_All._ui.txt_myWp:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RANDOMSHOP_ALL_MYWP", "myWp", tostring(wp)))
end
function PaGlobalFunc_RandomShop_All_ReserveAni(isShow)
  if nil == Panel_Window_RandomShop_All then
    return
  end
  if 44672 == dialog_getTalkNpcKey() then
    isShow = false
  end
  PaGlobal_RandowShop_All._ui.stc_reserveIcon:SetShow(isShow)
  PaGlobal_RandowShop_All._ui.stc_reserveIcon:setUpdateTextureAni(isShow)
  PaGlobal_RandowShop_All._ui.mtxt_reserveTime:SetShow(isShow)
  if false == isShow then
    PaGlobal_RandowShop_All._ui.mtxt_reserveTime:SetText(" ")
  else
    ToClient_UpdateRandomShopKeepTime()
  end
end
function PaGlobalFunc_RandomShop_All_RequestShopList()
  if nil == Panel_Window_RandomShop_All then
    return
  end
  if true == PaGlobal_RandowShop_All._isConsole and nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  local useWp = 0
  if 12 == PaGlobal_RandowShop_All._shopTypeNum then
    useWp = ToClient_getRandomShopConsumWp()
  elseif 13 == PaGlobal_RandowShop_All._shopTypeNum then
    useWp = 10
  end
  if wp < useWp then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UNKNOWITEMSELECT_WP_SHORTAGE_ACK"))
    PaGlobalFunc_RandomShop_All_Close()
  else
    if _ContentsGroup_UseCharacterWp == true then
      local characterIndex = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterIndex()
      npcShop_requestRandomShopItemList(CppEnums.ContentsType.Contents_Shop, true, characterIndex)
    else
      npcShop_requestList(CppEnums.ContentsType.Contents_Shop, true)
    end
    if wp < useWp then
      PaGlobal_RandowShop_All._ui_pc.btn_other:SetIgnore(true)
      PaGlobal_RandowShop_All._ui_pc.btn_other:SetMonoTone(true)
    else
      PaGlobal_RandowShop_All._ui_pc.btn_other:SetIgnore(false)
      PaGlobal_RandowShop_All._ui_pc.btn_other:SetMonoTone(false)
    end
  end
end
function PaGlobalFunc_RandomShop_All_BuyItem()
  local self = PaGlobal_RandowShop_All
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:get():getMoneyInventory():getMoney_s64() < self._randomShopItemPrice then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_TradeMarket_Not_Enough_Money"))
    return
  end
  npcShop_doBuyInRandomShop(self._selectSlotNo, 1, CppEnums.ItemWhereType.eMoneyInventory, 0, self._priceRate)
end
function FromClient_RandomShop_All_BuyItem()
  local self = PaGlobal_RandowShop_All
  if self == nil then
    return
  end
  if Panel_Window_RandomShop_All == nil or Panel_Window_RandomShop_All:GetShow() == false then
    return
  end
  self._priceRate = -1
  self._selectSlotNo = -1
  self:moneyUpdate()
  self:setDefaultRandomShop(true, false)
end
function HandleEventLUp_RandomShop_All_ItemShow()
  local self = PaGlobal_RandowShop_All
  if self == nil then
    return
  end
  local IsRamdomShopkeepItem = ToClient_IsRandomShopKeepItem()
  if IsRamdomShopkeepItem == false then
    local useWp = 0
    if 12 == self._shopTypeNum then
      useWp = ToClient_getRandomShopConsumWp()
    elseif 13 == self._shopTypeNum then
      useWp = 10
    end
    local wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
    if useWp > wp then
      PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_LACK_WP", "randomShopConsumeWp", useWp, "MyWp", wp), nil, nil, MessageBox_Empty_function)
      return
    else
      local wpCharacterString = wp
      if _ContentsGroup_UseCharacterWp == true then
        wpCharacterString = wpCharacterString .. " (" .. PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterName() .. ")"
      end
      if self._shopTypeNum == 12 then
        PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_CONFIRM_RANDOMITEM_WP", "randomShopConsumeWp", useWp, "MyWp", wpCharacterString), PaGlobalFunc_DialogMain_All_RandomWorkerSelectUseMyWpConfirm, nil, nil)
      elseif self._shopTypeNum == 13 then
        PaGlobal_DialogMain_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam2(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_CONFIRM_RANDOMITEM_WP_MOROCO", "randomShopConsumeWp", useWp, "MyWp", wpCharacterString), PaGlobalFunc_DialogMain_All_RandomWorkerSelectUseMyWpConfirm, nil, nil)
      end
    end
  end
end
function PaGlobalFunc_RandomShop_All_CheckWp()
  local self = PaGlobal_RandowShop_All
  if self == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local useWp = 0
  if self._shopTypeNum == 12 then
    useWp = ToClient_getRandomShopConsumWp()
  elseif self._shopTypeNum == 13 then
    useWp = 10
  end
  local wp = selfPlayer:getWp()
  if _ContentsGroup_UseCharacterWp == true then
    wp = PaGlobalFunc_UseCharacterWp_All_GetSelectedCharacterWp()
  end
  self._ui.txt_myWp:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_RANDOMSHOP_ALL_MYWP", "myWp", tostring(wp)))
  if useWp > wp then
    self._ui_pc.btn_other:SetIgnore(true)
    self._ui_pc.btn_other:SetMonoTone(true)
  elseif ToClient_isReSelectRandomShopItem() == true then
    self._ui_pc.btn_other:SetIgnore(false)
    self._ui_pc.btn_other:SetMonoTone(false)
  else
    self._ui_pc.btn_other:SetIgnore(true)
    self._ui_pc.btn_other:SetMonoTone(true)
  end
end
