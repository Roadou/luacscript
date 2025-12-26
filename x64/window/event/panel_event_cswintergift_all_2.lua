function PaGlobal_Event_CSWintergift_Open(regionData)
  if nil == Panel_Event_CSWinterGift then
    return
  end
  PaGlobal_Event_CSWintergift:prepareOpen(regionData)
end
function PaGlobal_Event_CSWintergift_Close()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  PaGlobal_Event_CSWintergift:prepareClose()
end
function PaGlobal_Event_CSWintergift_SaveShowByToday()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  PaGlobal_Event_CSWintergift:saveShowByToday()
  PaGlobal_Event_CSWintergift:prepareClose()
end
function HandleEvent_LUp_Event_CSWintergift_Confirm()
  if nil == Panel_Event_CSWinterGift or false == Panel_Event_CSWinterGift:GetShow() then
    return
  end
  if true == ToClient_isPS() then
    local nationType = getServiceNationType()
    if 1 == nationType then
      if true == ToClient_GetIsBuyBundleByProductID(self._ps_EU_EntitlementID) then
        return
      end
    elseif true == ToClient_GetIsBuyBundleByProductID(self._ps_NA_ASIA_EntitlementID) then
      return
    end
    ToClient_openPS4Store()
  else
    if true == ToClient_GetIsBuyBundleByProductID(self._xbox_LegacyProductID) then
      return
    end
    ToClient_XboxShowStore()
  end
end
function HandleEvent_LUp_Event_CSWintergift_ShowSelectItemTooltip()
  if nil == Panel_Event_CSWinterGift or false == Panel_Event_CSWinterGift:GetShow() then
    return
  end
  PaGlobal_Event_CSWintergift._isTooltipShow = not PaGlobal_Event_CSWintergift._isTooltipShow
  if false == PaGlobal_Event_CSWintergift._isTooltipShow then
    if false == PaGlobal_Event_CSWintergift._isConsole then
      if nil ~= Panel_Tooltip_Item_hideTooltip then
        Panel_Tooltip_Item_hideTooltip()
      end
    elseif nil ~= PaGlobalFunc_TooltipInfo_Close then
      PaGlobalFunc_TooltipInfo_Close()
    end
    return
  end
  local selectIndex = PaGlobal_Event_CSWintergift._selectIndex
  if nil == selectIndex then
    return
  end
  local itemSlot = PaGlobal_Event_CSWintergift._giftSlot[selectIndex]
  if nil == itemSlot then
    return
  end
  local selectItemKeyRaw = PaGlobal_Event_CSWintergift._giftItemKeyRaw[selectIndex]
  if nil == selectItemKeyRaw then
    return
  end
  local selectItemKey = ItemEnchantKey(selectItemKeyRaw)
  local selectItemSSW = getItemEnchantStaticStatus(selectItemKey)
  if nil == selectItemSSW then
    return
  end
  if false == PaGlobal_Event_CSWintergift._isConsole then
    Panel_Tooltip_Item_Show(selectItemSSW, itemSlot, true, false)
  else
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, selectItemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEvent_Out_Event_CSWintergift_CloseSelectItemTooltip()
  if false == PaGlobal_Event_CSWintergift._isConsole then
    if nil ~= Panel_Tooltip_Item_hideTooltip then
      Panel_Tooltip_Item_hideTooltip()
    end
  elseif nil ~= PaGlobalFunc_TooltipInfo_Close then
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_Event_CSWintergift._isTooltipShow = false
end
function HandleEvent_On_Event_CSWintergift_UpdateSelectIndex(selectIndex)
  if nil == Panel_Event_CSWinterGift or false == Panel_Event_CSWinterGift:GetShow() then
    return
  end
  PaGlobal_Event_CSWintergift._selectIndex = selectIndex
end
function FromClient_Event_CSWintergift_ResizePanel()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  Panel_Event_CSWinterGift:ComputePosAllChild()
end
