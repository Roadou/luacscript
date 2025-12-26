function PaGlobal_WorldMap_FamilyCharacterPin:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local default_singular = UI.getChildControl(Panel_Worldmap_FamilyCharacter_Pin_All, "Button_Singular")
  default_singular:SetShow(false)
  default_singular:SetIgnore(false)
  local default_plural = UI.getChildControl(Panel_Worldmap_FamilyCharacter_Pin_All, "Button_Plural")
  default_plural:SetShow(false)
  default_plural:SetIgnore(false)
  local default_memberCount = UI.getChildControl(default_plural, "StaticText_MemberCount")
  default_memberCount:SetShow(true)
  default_memberCount:SetIgnore(false)
  local default_plural_tail = UI.getChildControl(default_plural, "Static_Tail")
  default_plural_tail:SetShow(true)
  default_plural_tail:SetIgnore(true)
  default_plural_tail:SetDepth(10000)
  local default_classIcon = UI.getChildControl(default_singular, "Static_ClassIcon")
  default_classIcon:SetShow(true)
  default_classIcon:SetIgnore(true)
  local default_characterName = UI.getChildControl(default_singular, "StaticText_CharacterName")
  default_characterName:SetShow(true)
  default_characterName:SetIgnore(true)
  local default_characterLevel = UI.getChildControl(default_singular, "StaticText_CharacterLevel")
  default_characterLevel:SetShow(true)
  default_characterLevel:SetIgnore(true)
  local default_singular_tail = UI.getChildControl(default_singular, "Static_Tail")
  default_singular_tail:SetShow(true)
  default_singular_tail:SetIgnore(true)
  default_singular_tail:SetDepth(10000)
  Panel_Worldmap_FamilyCharacter_Pin_All:SetIgnore(true)
  Panel_Worldmap_FamilyCharacter_Pin_All:setMaskingChild(true)
  Panel_Worldmap_FamilyCharacter_Pin_All:setGlassBackground(true)
  Panel_Worldmap_FamilyCharacter_Pin_All:SetDragAll(false)
  Panel_Worldmap_FamilyCharacter_Pin_All:SetOffsetIgnorePanel(true)
  self:registerEventHandler()
  self._initialize = true
end
function PaGlobal_WorldMap_FamilyCharacterPin:registerEventHandler()
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  registerEvent("FromClient_ShowWorldMapFamilyCharacterIcon", "FromClient_ShowWorldMapFamilyCharacterIcon")
  registerEvent("FromClient_ShowWorldMapFamilyCharacterIconGroup", "FromClient_ShowWorldMapFamilyCharacterIconGroup")
  registerEvent("FromClient_HideWorldMapFamilyCharacterIcon", "FromClient_HideWorldMapFamilyCharacterIcon")
  registerEvent("FromClient_SetPosWorldMapFamilyCharacterIcon", "FromClient_SetPosWorldMapFamilyCharacterIcon")
  registerEvent("FromClient_ResetCurrentWorldMapFamilyCharacterIndex", "FromClient_ResetCurrentWorldMapFamilyCharacterIndex")
end
function PaGlobal_WorldMap_FamilyCharacterPin:showSingularButton(characterIcon, index)
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  local characterData = getCharacterDataByIndex(index, self._playerCreateType)
  if characterData == nil then
    UI.ASSERT_NAME(false, "\236\155\148\235\147\156\235\167\181 \234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176 \236\156\132\236\185\152 \237\140\168\235\132\144\236\157\132 show \237\149\160 \236\136\152 \236\151\134\235\139\164. index\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\132 Index:" .. tostring(index), "\236\157\180\236\163\188")
    return
  end
  local button = self:getButton(index)
  if button == nil then
    UI.ASSERT_NAME(false, "\236\155\148\235\147\156\235\167\181 \234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176 \236\156\132\236\185\152 \236\156\132\236\160\175\236\157\152 \237\140\168\235\132\144\236\157\180 \236\151\134\235\139\164. \237\153\149\236\157\184 \237\149\132\236\154\148", "\236\157\180\236\163\188")
    return
  end
  button._singular:SetShow(true)
  button._plural:SetShow(false)
  local stc_classIcon = UI.getChildControl(button._singular, "Static_ClassIcon")
  local txt_characterName = UI.getChildControl(button._singular, "StaticText_CharacterName")
  local txt_characterLevel = UI.getChildControl(button._singular, "StaticText_CharacterLevel")
  local stc_tail = UI.getChildControl(button._singular, "Static_Tail")
  local classType = getCharacterClassType(characterData)
  local characterName = getCharacterName(characterData)
  local characterLevel = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPEDITION_UNIT_LEVEL", "level", characterData._level)
  local characterPosition = PaGlobalFunc_WorldMap_FamilyCharacterList_ComputeCharacterPosition(characterData)
  local regionInfo = getRegionInfoByPosition(characterPosition)
  PaGlobalFunc_Util_ChangeTextureClass(stc_classIcon, classType)
  txt_characterName:SetText(characterName)
  txt_characterLevel:SetText(characterLevel)
  local sizeX = stc_classIcon:GetSizeX() + txt_characterName:GetTextSizeX() + txt_characterName:GetSpanSize().x
  local sizeY = button._singular:GetSizeY()
  button._singular:SetSize(sizeX, sizeY)
  stc_tail:SetPosX(sizeX / 2 - stc_tail:GetSizeX() / 2)
  characterIcon:SetSize(1, 1)
  button._singular:SetPosX(characterIcon:GetPosX() - stc_tail:GetPosX() - stc_tail:GetSizeX() / 2)
  button._singular:SetPosY(characterIcon:GetPosY() - stc_tail:GetPosY() - stc_tail:GetSizeY())
  if self._currentSelectIndex == index then
    button._singular:SetDepth(0)
  else
    button._singular:SetDepth(characterIcon:GetDepth())
  end
  button._singular:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMapFamilyCharacterIcon_Singular(" .. tostring(regionInfo:getRegionKey()) .. "," .. tostring(index) .. ")")
  Panel_Worldmap_FamilyCharacter_Pin_All:SetShow(true)
end
function PaGlobal_WorldMap_FamilyCharacterPin:showFluralButton(characterIcon, index, groupCount, isGroupByRegion, nonNavigable)
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  local characterData = getCharacterDataByIndex(index, self._playerCreateType)
  if characterData == nil then
    UI.ASSERT_NAME(false, "\236\155\148\235\147\156\235\167\181 \234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176 \236\156\132\236\185\152 \237\140\168\235\132\144\236\157\132 show \237\149\160 \236\136\152 \236\151\134\235\139\164. index\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\132 Index:" .. tostring(index), "\236\157\180\236\163\188")
    return
  end
  local button = self:getButton(index)
  if button == nil then
    UI.ASSERT_NAME(false, "\236\155\148\235\147\156\235\167\181 \234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176 \236\156\132\236\185\152 \236\156\132\236\160\175\236\157\152 \237\140\168\235\132\144\236\157\180 \236\151\134\235\139\164. \237\153\149\236\157\184 \237\149\132\236\154\148", "\236\157\180\236\163\188")
    return
  end
  button._singular:SetShow(false)
  button._plural:SetShow(true)
  local txt_memberCount = UI.getChildControl(button._plural, "StaticText_MemberCount")
  local stc_tail = UI.getChildControl(button._plural, "Static_Tail")
  local characterPosition = PaGlobalFunc_WorldMap_FamilyCharacterList_ComputeCharacterPosition(characterData)
  local regionInfo = getRegionInfoByPosition(characterPosition)
  local nameStr = ""
  if isGroupByRegion == true then
    nameStr = regionInfo:getAreaName()
  else
    nameStr = regionInfo:getTerritoryName()
  end
  txt_memberCount:SetText(tostring(groupCount))
  button._plural:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_FAMILYCHARACTER_ICON_GROUP_NAME", "name", nameStr))
  button._plural:SetSize(button._plural:GetTextSizeX() + 50, button._plural:GetSizeY())
  local sizeX = button._plural:GetSizeX()
  local sizeY = button._plural:GetSizeY()
  txt_memberCount:SetPosX(sizeX / 2 - txt_memberCount:GetSizeX() / 2)
  stc_tail:SetPosX(sizeX / 2 - stc_tail:GetSizeX() / 2)
  characterIcon:SetSize(1, 1)
  button._plural:SetPosX(characterIcon:GetPosX() - stc_tail:GetPosX() - stc_tail:GetSizeX() / 2)
  if isGroupByRegion == true then
    button._plural:SetPosY(characterIcon:GetPosY() - stc_tail:GetPosY() - stc_tail:GetSizeY())
  else
    button._plural:SetPosY(characterIcon:GetPosY() - stc_tail:GetPosY() - stc_tail:GetSizeY() - self._territoryOffsetY)
  end
  if self._currentSelectIndex == index then
    button._plural:SetDepth(0)
  else
    button._plural:SetDepth(characterIcon:GetDepth())
  end
  button._plural:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMapFamilyCharacterIcon_Plural(" .. tostring(regionInfo:getRegionKey()) .. "," .. tostring(isGroupByRegion) .. "," .. tostring(index) .. "," .. tostring(nonNavigable) .. ")")
  txt_memberCount:addInputEvent("Mouse_LUp", "HandleEventLUp_WorldMapFamilyCharacterIcon_Plural(" .. tostring(regionInfo:getRegionKey()) .. "," .. tostring(isGroupByRegion) .. "," .. tostring(index) .. "," .. tostring(nonNavigable) .. ")")
  Panel_Worldmap_FamilyCharacter_Pin_All:SetShow(true)
end
function PaGlobal_WorldMap_FamilyCharacterPin:hideIcon(index)
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  local button = self:getButton(index)
  if button == nil then
    UI.ASSERT_NAME(false, "\236\155\148\235\147\156\235\167\181 \234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176 \236\156\132\236\185\152 \237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\235\138\148\235\139\164. [hideIcon] Index:" .. tostring(index), "\236\157\180\236\163\188")
    return
  end
  button._singular:SetShow(false)
  button._plural:SetShow(false)
end
function PaGlobal_WorldMap_FamilyCharacterPin:hideAll()
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  if self._buttonList == nil then
    return
  end
  for key, value in pairs(self._buttonList) do
    if value ~= nil then
      value._singular:SetShow(false)
      value._plural:SetShow(false)
    end
  end
end
function PaGlobal_WorldMap_FamilyCharacterPin:setPosIcon(characterIcon, index)
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  local button = self:getButton(index)
  if button == nil then
    UI.ASSERT_NAME(false, "\236\155\148\235\147\156\235\167\181 \234\176\128\235\172\184 \235\130\180 \236\186\144\235\166\173\237\132\176 \236\156\132\236\185\152 \236\156\132\236\160\175\236\157\152 \235\178\132\237\138\188\236\157\180 \236\151\134\235\139\164. \237\153\149\236\157\184 \237\149\132\236\154\148", "\236\157\180\236\163\188")
    return
  end
  button._singular:SetPosX(characterIcon:GetPosX() + characterIcon:GetSizeX() / 2 - panel:GetSizeX() / 2)
  button._singular:SetPosY(characterIcon:GetPosY())
  button._plural:SetPosX(characterIcon:GetPosX() + characterIcon:GetSizeX() / 2 - panel:GetSizeX() / 2)
  button._plural:SetPosY(characterIcon:GetPosY())
end
function PaGlobal_WorldMap_FamilyCharacterPin:getButton(index)
  local defaultPanel = Panel_Worldmap_FamilyCharacter_Pin_All
  if defaultPanel == nil then
    return nil
  end
  if self._buttonList[index] ~= nil then
    return self._buttonList[index]
  end
  local default_singular = UI.getChildControl(defaultPanel, "Button_Singular")
  local default_plural = UI.getChildControl(defaultPanel, "Button_Plural")
  local buttonControls = {_singular = nil, _plural = nil}
  buttonControls._singular = UI.cloneControl(default_singular, Panel_Worldmap_FamilyCharacter_Pin_All, "Button_Singular_" .. tostring(index))
  buttonControls._plural = UI.cloneControl(default_plural, Panel_Worldmap_FamilyCharacter_Pin_All, "Button_Plural_" .. tostring(index))
  self._buttonList[index] = buttonControls
  return self._buttonList[index]
end
function PaGlobal_WorldMap_FamilyCharacterPin:setCurrentSelectIndex(index)
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  self._currentSelectIndex = index
end
function PaGlobal_WorldMap_FamilyCharacterPin:setCurrentSelectPinEffect(index, isShow, isPlural)
  if Panel_Worldmap_FamilyCharacter_Pin_All == nil then
    return
  end
  if isShow == true and self._buttonList[index] == nil then
    return
  end
  for key, value in pairs(self._buttonList) do
    if value ~= nil then
      local classIcon = UI.getChildControl(value._singular, "Static_ClassIcon")
      if classIcon ~= nil then
        classIcon:EraseAllEffect()
      end
      local countIcon = UI.getChildControl(value._plural, "StaticText_MemberCount")
      if countIcon ~= nil then
        countIcon:EraseAllEffect()
      end
    end
  end
  if isShow == false then
    return
  end
  if isPlural == true then
    local countIcon = UI.getChildControl(self._buttonList[index]._plural, "StaticText_MemberCount")
    local classIcon = UI.getChildControl(self._buttonList[index]._singular, "Static_ClassIcon")
    countIcon:AddEffect("fUI_Map_CharacterPing_01A", true, 0, 0)
    classIcon:AddEffect("fUI_Map_CharacterPing_01A", true, 0, 0)
  else
    local classIcon = UI.getChildControl(self._buttonList[index]._singular, "Static_ClassIcon")
    classIcon:AddEffect("fUI_Map_CharacterPing_01A", true, 0, 0)
  end
end
