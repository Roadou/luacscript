function PaGlobalFunc_HopeGauge_Console_Close()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  PaGlobal_HopeGauge_Console:prepareClose()
end
function PaGlobalFunc_HopeGauge_Console_Open()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  PaGlobal_HopeGauge_Console:prepareOpen()
end
function FromClient_HopeGaugeConsole_Update()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  if Panel_Widget_HopeGauge_Console:GetShow() == false then
    return
  end
  PaGlobal_HopeGauge_Console:update()
  PaGlobal_HopeGauge_Console:updateButtons()
  PaGlobal_HopeGauge_Console:updateFeedItem()
end
function FromClient_HopeGaugeConsole_UpdateTimer()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  if Panel_Widget_HopeGauge_Console:GetShow() == false then
    return
  end
  PaGlobal_HopeGauge_Console:updateTimerOnly()
end
function HandleClicked_HopeGuage_Console_SelectFeedItem(idx)
  if nil == Panel_Widget_HopeGauge then
    return
  end
  PaGlobal_HopeGauge_Console:selectFeedItem(idx)
end
function PaGlobalFunc_HopeGauge_Console_ChargeScroll(inputNumber)
  if nil == Panel_Widget_HopeGauge then
    return
  end
  local self = PaGlobal_HopeGauge_Console
  if self._selectItemIndex == nil then
    return
  end
  local function charrgeScroll()
    ToClient_ChargeItemCollectionScroll(self._selectItemIndex, self._selectedCount)
  end
  self._selectedCount = Int64toInt32(inputNumber)
  local contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEMGETSCROLL_WARNING", "count", tostring(self._selectedCount), "chargeCount", Util.Time.timeFormatting(self._selectedCount * self._selectedPoint))
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE"),
    content = contentString,
    functionYes = charrgeScroll,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if nil ~= self._selectItemIndex then
    MessageBox.showMessageBox(messageboxData)
  end
end
function FromClient_HopeGaugeConsole_InventoryUpdate()
  if Panel_Widget_HopeGauge == nil then
    return
  end
  if Panel_Widget_HopeGauge:GetShow() == false then
    return
  end
  PaGlobal_HopeGauge_Console:updateFeedItem()
end
function PaGlobalFunc_HopeGauge_Console_ShowItemTooptip(idx, itemKeyRaw, isShow)
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local self = PaGlobal_HopeGauge_Console
  if isShow == false then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local targetSlot = self._ui._stc_ItemSlots[idx]
  if targetSlot == nil then
    return
  end
  local itemKey = ItemEnchantKey(itemKeyRaw)
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if itemSSW == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, targetSlot.icon, true, false)
  end
end
function PaGlobalFunc_HopeGauge_Console_ShowItemTooptip_Toggle(idx, itemKeyRaw)
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local self = PaGlobal_HopeGauge_Console
  local isShow = true
  if self._isConsole == true then
    if PaGlobalFunc_TooltipInfo_GetShow ~= nil then
      isShow = PaGlobalFunc_TooltipInfo_GetShow()
    end
  elseif Panel_Tooltip_Item ~= nil then
    isShow = Panel_Tooltip_Item:GetShow()
  end
  if isShow == true then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local targetSlot = self._ui._stc_ItemSlots[idx]
  if targetSlot == nil then
    return
  end
  local itemKey = ItemEnchantKey(itemKeyRaw)
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if itemSSW == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, targetSlot.icon, true, false)
  end
end
