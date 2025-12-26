function FromClient_NotifyWareHouseHistory()
  if Panel_Window_WareHouseHistory ~= nil and Panel_Window_WareHouseHistory:GetShow() == true then
    local self = PaGlobal_WareHouseHistory
    self._ui._list2_logList:getElementManager():clearKey()
    for ii = ToClient_wareHouseMoveItemHistoryCount() - 1, 0, -1 do
      self._ui._list2_logList:getElementManager():pushKey(ii)
    end
    self._ui._list2_logList:ComputePos()
  end
end
function HandleEvent_Warehouse_All_HistoryOpen()
  if Panel_Window_WareHouseHistory == nil then
    return
  end
  if Panel_Window_WareHouseHistory:GetShow() == true then
    PaGlobal_WareHouseHistory:close()
  else
    PaGlobal_WareHouseHistory:open()
  end
end
function PaGlobal_WareHouseHistory_CreateControlList2(content, key)
  local self = PaGlobal_WareHouseHistory
  local index = Int64toInt32(key)
  local wrapper = ToClient_wareHouseHistoryWrapper(index)
  if nil == wrapper then
    return
  end
  content:SetIgnore(true)
  local txt_info = UI.getChildControl(content, "StaticText_Content")
  local txt_date = UI.getChildControl(content, "StaticText_Date")
  local slotBg = UI.getChildControl(content, "Static_SlotBg")
  local itemIcon = UI.getChildControl(slotBg, "Static_ItemIcon")
  local itemCount = UI.getChildControl(slotBg, "StaticText_ItemCount")
  local txt = ""
  local itemSSW = getItemEnchantStaticStatus(wrapper:getItemEnchantKey())
  if nil ~= itemSSW then
    local slot = {}
    local itemStatic = itemSSW:get()
    local enchantLevel = itemStatic._key:getEnchantLevel()
    SlotItem.reInclude(slot, "WareHistory_ItemIcon_", 0, itemIcon, PaGlobal_WareHouseHistory._slotConfig)
    slot:setItemByStaticStatus(itemSSW)
    slotBg:SetIgnore(not _ContentsGroup_UsePadSnapping)
    itemIcon:SetIgnore(_ContentsGroup_UsePadSnapping)
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_WareHouseHistory:itemTooltipShow(" .. index .. "," .. wrapper:getItemEnchantKey():get() .. ")")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_WareHouseHistory:itemTooltipHide()")
    itemCount:SetText(tostring(wrapper:getItemCount()))
    if true == wrapper:isPush() then
      txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_PUSH", "userNickName", getRegionNameByWaypointKey(wrapper:getWaypointKey()))
    else
      txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_POP", "userNickName", getRegionNameByWaypointKey(wrapper:getWaypointKey()))
    end
  end
  txt_info:SetText(txt)
  local paTime = PATime(wrapper:getRegisterDate())
  local year = tostring(paTime:GetYear())
  local month = tostring(paTime:GetMonth())
  local day = tostring(paTime:GetDay())
  local hour = tostring(paTime:GetHour())
  local min = tostring(paTime:GetMinute())
  txt_date:SetText(year .. "." .. month .. "." .. day .. " " .. string.format("%.02d", hour) .. ":" .. string.format("%.02d", min))
end
function HandleEventRUp_WareHouseHistory_ShowFloatingTooltip(isShow, index, itemEnchantKey)
  if false == isShow then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    local content = PaGlobal_WareHouseHistory._ui._list2_logList:GetContentByKey(index)
    local slotBg = UI.getChildControl(content, "Static_SlotBg")
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, slotBg, "WareHouse")
  end
end
function HandleEventRUp_WareHouseHistory_ShowDetailTooltip(itemEnchantKey)
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if nil ~= itemSSW then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
