function PaGlobalFunc_WorldMapFamilyCharacterIcon_HideAll()
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:hideAll()
end
function FromClient_ShowWorldMapFamilyCharacterIcon(characterIcon, index)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:showSingularButton(characterIcon, index)
end
function FromClient_ShowWorldMapFamilyCharacterIconGroup(characterIcon, index, groupCount, isGroupByRegion, nonNavigable)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:showFluralButton(characterIcon, index, groupCount, isGroupByRegion, nonNavigable)
end
function FromClient_HideWorldMapFamilyCharacterIcon(index)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:hideIcon(index)
end
function FromClient_SetPosWorldMapFamilyCharacterIcon(characterIcon, index)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:setPosIcon(characterIcon, index)
end
function HandleEventLUp_WorldMapFamilyCharacterIcon_Singular(regionKeyRaw, index)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  PaGlobalFunc_WorldMap_FamilyCharacterList_Select(regionKeyRaw, true, false)
  self:setCurrentSelectIndex(index)
end
function HandleEventLUp_WorldMapFamilyCharacterIcon_Plural(regionKeyRaw, isGroupByRegion, index, nonNavigable)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  PaGlobalFunc_WorldMap_FamilyCharacterList_Select(regionKeyRaw, isGroupByRegion, nonNavigable)
  self:setCurrentSelectIndex(index)
end
function FromClient_ResetCurrentWorldMapFamilyCharacterIndex()
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:setCurrentSelectIndex(-1)
  self:setCurrentSelectPinEffect(-1, false, false)
end
function PaGlobalFunc_WorldMapFamilyCharacterIcon_SelectCurrentCaracter(characterDataIndex, isShow, isPlural)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return
  end
  self:setCurrentSelectPinEffect(characterDataIndex, isShow, isPlural)
end
function PaGlobalFunc_WorldMapFamilyCharacterIcon_GetShowCharacterPin(characterDataIndex, isPlural)
  local self = PaGlobal_WorldMap_FamilyCharacterPin
  if self == nil then
    return false
  end
  return self:getShowCharacterPin(characterDataIndex, isPlural)
end
