function PaGlobal_WorldMapBarterInfo:initialize()
  registerEvent("FromClient_WorldMapBarterInfo", "FromClient_WorldMapBarterInfo")
  registerEvent("FromClient_WorldMapUpdateBarterInfo", "FromClient_WorldMapUpdateBarterInfo")
  registerEvent("FromClient_ResetBarterInitializedFlags", "FromClient_ResetBarterInitializedFlags")
end
function PaGlobal_WorldMapBarterInfo:createNormalBg(control, regionKey, isShowAllBg, slots)
  local barterWrapper = ToClient_barterWrapper(regionKey)
  if nil == barterWrapper then
    return
  end
  local bg = UI.getChildControl(control, "Static_Normal")
  local fromSlotBg = UI.getChildControl(bg, "Static_MyItemBG")
  local toSlotBg = UI.getChildControl(bg, "Static_NpcItemBG")
  local fromSlot = self:createSlot(fromSlotBg, 0)
  local toSlot = self:createSlot(toSlotBg, 1)
  local regionKeyRaw = regionKey:get()
  local itemSSW = getItemEnchantStaticStatus(barterWrapper:getFromItemEnchantKey())
  if nil ~= itemSSW then
    fromSlot:setItemByStaticStatus(itemSSW, barterWrapper:getFromItemCount())
    fromSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. "," .. barterWrapper:getFromItemEnchantKey():get() .. ", 0)")
    fromSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
    fromSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_FindBarterRegionByItem(true, " .. itemSSW:get()._key:get() .. ")")
  end
  itemSSW = getItemEnchantStaticStatus(barterWrapper:getToItemEnchantKey())
  if nil ~= itemSSW then
    toSlot:setItemByStaticStatus(itemSSW, barterWrapper:getToItemCount())
    toSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. "," .. barterWrapper:getToItemEnchantKey():get() .. ", 1)")
    toSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
    toSlot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_FindBarterRegionByItem(false, " .. itemSSW:get()._key:get() .. ")")
  end
  slots[0] = fromSlot.icon
  slots[1] = toSlot.icon
  self._slotList[regionKeyRaw] = slots
  local barterCount
  if true == isShowAllBg then
    barterCount = UI.getChildControl(bg, "StaticText_Count")
  else
    barterCount = UI.getChildControl(control, "StaticText_Count")
  end
  local exchangeMaxCount = barterWrapper:getExchangeMaxCount()
  local exchangeLeftCount = exchangeMaxCount - barterWrapper:getExchangeCurrentCount()
  local barterCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERCOUNT_WORLDMAP_NODE", "count", tostring(exchangeLeftCount), "total", tostring(exchangeMaxCount))
  barterCount:SetText(barterCountString)
  if 0 == exchangeLeftCount then
    fromSlotBg:SetMonoTone(true)
    toSlotBg:SetMonoTone(true)
  else
    fromSlotBg:SetMonoTone(false)
    toSlotBg:SetMonoTone(false)
  end
end
function PaGlobal_WorldMapBarterInfo:createSpecialBg(control, regionKey, slots)
  local barterWrapper = ToClient_specialBarterWrapper()
  if nil == barterWrapper then
    return
  end
  local fromSlotBg = UI.getChildControl(control, "Static_MyItemBG")
  local toSlotBg = UI.getChildControl(control, "Static_NpcItemBG")
  local fromSlot = self:createSlot(fromSlotBg, 2)
  local toSlot = self:createSlot(toSlotBg, 3)
  local regionKeyRaw = regionKey:get()
  local itemSSW = getItemEnchantStaticStatus(barterWrapper:getFromItemEnchantKey())
  if nil ~= itemSSW then
    fromSlot:setItemByStaticStatus(itemSSW, barterWrapper:getFromItemCount())
    fromSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. ", " .. barterWrapper:getFromItemEnchantKey():get() .. ", 2)")
    fromSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
  end
  itemSSW = getItemEnchantStaticStatus(barterWrapper:getToItemEnchantKey())
  if nil ~= itemSSW then
    toSlot:setItemByStaticStatus(itemSSW, barterWrapper:getToItemCount())
    toSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. "," .. barterWrapper:getToItemEnchantKey():get() .. ", 3)")
    toSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
  end
  slots[2] = fromSlot.icon
  slots[3] = toSlot.icon
  self._slotList[regionKeyRaw] = slots
end
function PaGlobal_WorldMapBarterInfo:showAllBg(panel, regionKey)
  local allBg = UI.getChildControl(panel, "Static_BaterInfo_SpecialNormal")
  local normalBg = UI.getChildControl(panel, "Static_BarterInfo_OnlyNormal")
  local specialBg = UI.getChildControl(panel, "Static_BarterInfo_OlnySpecial")
  allBg:SetShow(false)
  normalBg:SetShow(false)
  specialBg:SetShow(false)
  local slots = {
    [0] = nil,
    [1] = nil,
    [2] = nil,
    [3] = nil
  }
  self:createNormalBg(allBg, regionKey, true, slots)
  allBg:SetShow(true)
  panel:SetShow(true)
  local barterWrapper = ToClient_specialBarterWrapper()
  if nil == barterWrapper then
    return
  end
  local stc_special = UI.getChildControl(allBg, "Static_Special")
  local barterCount = UI.getChildControl(stc_special, "StaticText_Count")
  local exchangeMaxCount = barterWrapper:getExchangeMaxCount()
  local exchangeLeftCount = exchangeMaxCount - barterWrapper:getExchangeCurrentCount()
  local barterCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERCOUNT_WORLDMAP_NODE", "count", tostring(exchangeLeftCount), "total", tostring(exchangeMaxCount))
  barterCount:SetText(barterCountString)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local fromSlotBg = UI.getChildControl(stc_special, "Static_MyItemBG")
  local toSlotBg = UI.getChildControl(stc_special, "Static_NpcItemBG")
  local hasValuePackage = selfPlayerWrapper:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  if false == hasValuePackage then
    UI.getChildControl(fromSlotBg, "Static_Question1"):SetShow(true)
    UI.getChildControl(toSlotBg, "Static_Question2"):SetShow(true)
    return
  else
    UI.getChildControl(fromSlotBg, "Static_Question1"):SetShow(false)
    UI.getChildControl(toSlotBg, "Static_Question2"):SetShow(false)
    self:createSpecialBg(stc_special, regionKey, slots)
  end
end
function PaGlobal_WorldMapBarterInfo:showNormalBg(panel, regionKey)
  local allBg = UI.getChildControl(panel, "Static_BaterInfo_SpecialNormal")
  local normalBg = UI.getChildControl(panel, "Static_BarterInfo_OnlyNormal")
  local specialBg = UI.getChildControl(panel, "Static_BarterInfo_OlnySpecial")
  allBg:SetShow(false)
  normalBg:SetShow(false)
  specialBg:SetShow(false)
  local slots = {
    [0] = nil,
    [1] = nil,
    [2] = nil,
    [3] = nil
  }
  self:createNormalBg(normalBg, regionKey, false, slots)
  normalBg:SetShow(true)
  panel:SetShow(true)
  self._isNormalInitialized[regionKey:get()] = true
end
function PaGlobal_WorldMapBarterInfo:showSpecialBg(panel, regionKey)
  local allBg = UI.getChildControl(panel, "Static_BaterInfo_SpecialNormal")
  local normalBg = UI.getChildControl(panel, "Static_BarterInfo_OnlyNormal")
  local specialBg = UI.getChildControl(panel, "Static_BarterInfo_OlnySpecial")
  allBg:SetShow(false)
  normalBg:SetShow(false)
  specialBg:SetShow(true)
  panel:SetShow(true)
  local barterWrapper = ToClient_specialBarterWrapper()
  if nil == barterWrapper then
    return
  end
  local barterCount = UI.getChildControl(specialBg, "StaticText_Count")
  local exchangeMaxCount = barterWrapper:getExchangeMaxCount()
  local exchangeLeftCount = exchangeMaxCount - barterWrapper:getExchangeCurrentCount()
  local barterCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERCOUNT_WORLDMAP_NODE", "count", tostring(exchangeLeftCount), "total", tostring(exchangeMaxCount))
  barterCount:SetText(barterCountString)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local fromSlotBg = UI.getChildControl(specialBg, "Static_MyItemBG")
  local toSlotBg = UI.getChildControl(specialBg, "Static_NpcItemBG")
  local hasValuePackage = selfPlayerWrapper:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_PremiumPackage)
  if false == hasValuePackage then
    UI.getChildControl(fromSlotBg, "Static_Question1"):SetShow(true)
    UI.getChildControl(toSlotBg, "Static_Question2"):SetShow(true)
    return
  else
    UI.getChildControl(fromSlotBg, "Static_Question1"):SetShow(false)
    UI.getChildControl(toSlotBg, "Static_Question2"):SetShow(false)
  end
  local slots = {
    [0] = nil,
    [1] = nil,
    [2] = nil,
    [3] = nil
  }
  self:createSpecialBg(specialBg, regionKey, slots)
end
function PaGlobal_WorldMapBarterInfo:updateAllCount(control, regionKey, updateType)
  local allBg = UI.getChildControl(control, "Static_BaterInfo_SpecialNormal")
  local normalBg = UI.getChildControl(control, "Static_BarterInfo_OnlyNormal")
  local specialBg = UI.getChildControl(control, "Static_BarterInfo_OlnySpecial")
  if updateType == 0 then
    if self._isDiscoveredSpeical == true then
      return
    end
    local specialBarter = ToClient_specialBarterWrapper()
    if specialBarter == nil then
      return
    end
    local stc_special = UI.getChildControl(allBg, "Static_Special")
    local barterCount = UI.getChildControl(stc_special, "StaticText_Count")
    local exchangeMaxCount = specialBarter:getExchangeMaxCount()
    local exchangeLeftCount = exchangeMaxCount - specialBarter:getExchangeCurrentCount()
    local barterCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERCOUNT_WORLDMAP_NODE", "count", tostring(exchangeLeftCount), "total", tostring(exchangeMaxCount))
    barterCount:SetText(barterCountString)
    local selfPlayer = getSelfPlayer()
    if selfPlayer == nil then
      return
    end
    local fromSlotBg = UI.getChildControl(stc_special, "Static_MyItemBG")
    local toSlotBg = UI.getChildControl(stc_special, "Static_NpcItemBG")
    UI.getChildControl(fromSlotBg, "Static_Question1"):SetShow(false)
    UI.getChildControl(toSlotBg, "Static_Question2"):SetShow(false)
    local fromSlot = self:createSlot(fromSlotBg, 2)
    local toSlot = self:createSlot(toSlotBg, 3)
    local regionKeyRaw = regionKey:get()
    local itemSSW = getItemEnchantStaticStatus(specialBarter:getFromItemEnchantKey())
    if nil ~= itemSSW then
      fromSlot:setItemByStaticStatus(itemSSW, specialBarter:getFromItemCount())
      fromSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. ", " .. specialBarter:getFromItemEnchantKey():get() .. ", 2)")
      fromSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
    end
    itemSSW = getItemEnchantStaticStatus(specialBarter:getToItemEnchantKey())
    if nil ~= itemSSW then
      toSlot:setItemByStaticStatus(itemSSW, specialBarter:getToItemCount())
      toSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. "," .. specialBarter:getToItemEnchantKey():get() .. ", 3)")
      toSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
    end
    self._slotList[regionKeyRaw][2] = fromSlot.icon
    self._slotList[regionKeyRaw][3] = toSlot.icon
    self._isDiscoveredSpeical = true
    return
  elseif updateType == 1 then
    self:showAllBg(control, regionKey)
    allBg:SetShow(true)
    normalBg:SetShow(false)
    specialBg:SetShow(false)
    return
  elseif updateType == 2 then
    local stc_normal = UI.getChildControl(allBg, "Static_Normal")
    local fromSlotBg = UI.getChildControl(stc_normal, "Static_MyItemBG")
    local toSlotBg = UI.getChildControl(stc_normal, "Static_NpcItemBG")
    local barterCount = UI.getChildControl(stc_normal, "StaticText_Count")
    stc_normal:SetShow(true)
    local normalBarter = ToClient_barterWrapper(regionKey)
    if normalBarter == nil then
      return
    end
    local exchangeMaxCount = normalBarter:getExchangeMaxCount()
    local exchangeLeftCount = exchangeMaxCount - normalBarter:getExchangeCurrentCount()
    local barterCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERCOUNT_WORLDMAP_NODE", "count", tostring(exchangeLeftCount), "total", tostring(exchangeMaxCount))
    barterCount:SetText(barterCountString)
    if 0 == exchangeLeftCount then
      fromSlotBg:SetMonoTone(true)
      toSlotBg:SetMonoTone(true)
    else
      fromSlotBg:SetMonoTone(false)
      toSlotBg:SetMonoTone(false)
    end
    return
  elseif updateType == 3 then
    if self._isNormalInitialized[regionKey:get()] ~= nil and self._isNormalInitialized[regionKey:get()] == true then
      normalBg:SetShow(true)
    else
      self:showNormalBg(control, regionKey)
    end
    allBg:SetShow(false)
    specialBg:SetShow(false)
    self._isDiscoveredSpeical = false
    return
  else
    return
  end
end
function PaGlobal_WorldMapBarterInfo:updateNormalCount(control, regionKey)
  local allBg = UI.getChildControl(control, "Static_BaterInfo_SpecialNormal")
  local normalBg = UI.getChildControl(control, "Static_BarterInfo_OnlyNormal")
  local specialBg = UI.getChildControl(control, "Static_BarterInfo_OlnySpecial")
  allBg:SetShow(false)
  specialBg:SetShow(false)
  normalBg:SetShow(true)
  control:SetShow(true)
  local barterWrapper = ToClient_barterWrapper(regionKey)
  if barterWrapper == nil then
    return
  end
  local barterCount = UI.getChildControl(normalBg, "StaticText_Count")
  local bg = UI.getChildControl(normalBg, "Static_Normal")
  local fromSlotBg = UI.getChildControl(bg, "Static_MyItemBG")
  local toSlotBg = UI.getChildControl(bg, "Static_NpcItemBG")
  local exchangeMaxCount = barterWrapper:getExchangeMaxCount()
  local exchangeLeftCount = exchangeMaxCount - barterWrapper:getExchangeCurrentCount()
  local barterCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERCOUNT_WORLDMAP_NODE", "count", tostring(exchangeLeftCount), "total", tostring(exchangeMaxCount))
  barterCount:SetText(barterCountString)
  if 0 == exchangeLeftCount then
    fromSlotBg:SetMonoTone(true)
    toSlotBg:SetMonoTone(true)
  else
    fromSlotBg:SetMonoTone(false)
    toSlotBg:SetMonoTone(false)
  end
end
function PaGlobal_WorldMapBarterInfo:updateSpecialCount(control, regionKey, isDiscoverSpecial)
  local allBg = UI.getChildControl(control, "Static_BaterInfo_SpecialNormal")
  local normalBg = UI.getChildControl(control, "Static_BarterInfo_OnlyNormal")
  local specialBg = UI.getChildControl(control, "Static_BarterInfo_OlnySpecial")
  allBg:SetShow(false)
  normalBg:SetShow(false)
  local specialBarter = ToClient_specialBarterWrapper()
  if isDiscoverSpecial == true then
    if self._isDiscoveredSpeical == true then
      return
    end
    local fromSlotBg = UI.getChildControl(specialBg, "Static_MyItemBG")
    local toSlotBg = UI.getChildControl(specialBg, "Static_NpcItemBG")
    UI.getChildControl(fromSlotBg, "Static_Question1"):SetShow(false)
    UI.getChildControl(toSlotBg, "Static_Question2"):SetShow(false)
    local fromSlot = self:createSlot(fromSlotBg, 2)
    local toSlot = self:createSlot(toSlotBg, 3)
    local regionKeyRaw = regionKey:get()
    local itemSSW = getItemEnchantStaticStatus(specialBarter:getFromItemEnchantKey())
    if nil ~= itemSSW then
      fromSlot:setItemByStaticStatus(itemSSW, specialBarter:getFromItemCount())
      fromSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. ", " .. specialBarter:getFromItemEnchantKey():get() .. ", 2)")
      fromSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
    end
    itemSSW = getItemEnchantStaticStatus(specialBarter:getToItemEnchantKey())
    if nil ~= itemSSW then
      toSlot:setItemByStaticStatus(itemSSW, specialBarter:getToItemCount())
      toSlot.icon:addInputEvent("Mouse_On", "PaGlobal_WorldMapBarterInfo:itemTooltipShow(" .. regionKeyRaw .. "," .. specialBarter:getToItemEnchantKey():get() .. ", 3)")
      toSlot.icon:addInputEvent("Mouse_Out", "PaGlobal_WorldMapBarterInfo:itemTooltipHide()")
    end
    self._slotList[regionKeyRaw][2] = fromSlot.icon
    self._slotList[regionKeyRaw][3] = toSlot.icon
    self._isDiscoveredSpeical = true
  elseif specialBarter == nil then
    specialBg:SetShow(false)
  else
    self:showSpecialBg(control, regionKey)
    specialBg:SetShow(true)
    control:SetShow(true)
  end
end
function PaGlobal_WorldMapBarterInfo:createSlot(parent, index)
  local slot = {}
  SlotItem.new(slot, "itemIcon", index, parent, self._slotConfig)
  slot:createChild()
  slot.icon:SetPosX(0)
  slot.icon:SetPosY(0)
  slot.icon:SetShow(true)
  return slot
end
function PaGlobal_WorldMapBarterInfo:itemTooltipShow(regionKeyRaw, itemEnchantKey, index)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local control = self._slotList[regionKeyRaw][index]
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_WorldMapBarterInfo:itemTooltipHide()
  Panel_Tooltip_Item_hideTooltip()
end
