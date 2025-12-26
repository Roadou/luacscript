function FromClient_WorldMapBarterInfo(panel, regionKey, existNormal, existSpecial)
  if nil == panel then
    return
  end
  local self = PaGlobal_WorldMapBarterInfo
  if true == existNormal and true == existSpecial then
    self:showAllBg(panel, regionKey)
  elseif true == existNormal and false == existSpecial then
    self:showNormalBg(panel, regionKey)
  else
    if false == existNormal and true == existSpecial then
      self:showSpecialBg(panel, regionKey)
    else
    end
  end
end
function FromClient_WorldMapUpdateBarterInfo(panel, regionKey, existNormal, existSpecial, isFromNormal, isDiscoverSpecial)
  if panel == nil then
    return
  end
  local self = PaGlobal_WorldMapBarterInfo
  if self == nil then
    return
  end
  if isDiscoverSpecial == true then
    local specialBarter = ToClient_specialBarterWrapper()
    if specialBarter == nil then
      return
    end
  end
  if existNormal == true and existSpecial == true then
    local updateType = 0
    local specialBarter = ToClient_specialBarterWrapper()
    if specialBarter == nil then
      updateType = 3
    elseif isFromNormal then
      updateType = 2
    elseif isDiscoverSpecial == true then
      updateType = 0
    else
      updateType = 1
    end
    self:updateAllCount(panel, regionKey, updateType)
  elseif existNormal == true and existSpecial == false then
    self:updateNormalCount(panel, regionKey)
  elseif existNormal == false and existSpecial == true then
    self:updateSpecialCount(panel, regionKey, isDiscoverSpecial)
  else
    return
  end
end
function PaGlobalFunc_FindBarterRegionByItem(findToRegion, itemEnchantKeyRaw)
  local regionKey = ToClient_FindBarterRegionByItem(findToRegion, itemEnchantKeyRaw)
  local regionWrapper = getRegionInfoWrapper(regionKey:get())
  if nil == regionWrapper then
    PaGlobalFunc_FindBarterItemByMarket(itemEnchantKeyRaw)
    return
  end
  ToCleint_gotoWorldmapPosition(regionWrapper:getPosition())
end
function PaGlobalFunc_FindBarterItemByMarket(itemEnchantKeyRaw)
  if false == _ContentsGroup_RenewBarter then
    return
  end
  local canRegister = ToClient_RequestBarterItemByTrade(itemEnchantKeyRaw)
  if true == canRegister then
    if true == PaGlobalFunc_MarketPlace_GetShow() then
      PaGlobalFunc_MarketPlace_Close()
    end
    PaGlobalFunc_ItemMarket_OpenbyBarter(itemEnchantKeyRaw)
  end
end
function FromClient_ResetBarterInitializedFlags()
  PaGlobal_WorldMapBarterInfo._isNormalInitialized = {}
  PaGlobal_WorldMapBarterInfo._isDiscoveredSpeical = false
end
