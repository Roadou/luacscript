Panel_Equipment_Crystal_Tooltip:SetShow(false, false)
Panel_Equipment_Crystal_Tooltip:ActiveMouseEventEffect(true)
Panel_Equipment_Crystal_Tooltip:setMaskingChild(true)
Panel_Equipment_Crystal_Tooltip:setGlassBackground(true)
local UI_color = Defines.Color
local _panel = Panel_Equipment_Crystal_Tooltip
local CrystalTooltip = {
  _ui = {
    txt_windowTitle = UI.getChildControl(_panel, "StaticText_Title"),
    txt_noCrystal = UI.getChildControl(_panel, "StaticText_NoCrystal"),
    txt_windowDesc = UI.getChildControl(_panel, "StaticText_Desc"),
    txt_equipmentName = UI.getChildControl(_panel, "StaticText_EquipmentName"),
    txt_jewelGroupName = UI.getChildControl(_panel, "StaticText_JewelGroupName"),
    stc_crystalBG = UI.getChildControl(_panel, "Static_CrystalBG"),
    stc_detailBG = UI.getChildControl(_panel, "Static_DetailBg")
  },
  _listEquipmentName = {},
  _listEquipmentSize = 0,
  _listCrystal = {},
  _listCrystalSize = 0,
  _usingEquipmentUICount = 0,
  _usingCrystalUICount = 0,
  _listCrystalGroupNameSize = 0,
  _listCrystalGroupName = {},
  _usingCrystalGroupNumberUICount = 0,
  _lastJewelGroupNumber = -1,
  _txt_emptySlot = nil,
  _equipNoMin = __eEquipSlotNoRightHand,
  _equipNoMax = __eEquipSlotNoArtifact1,
  _socketCount = 0,
  _panelSizeY = 0,
  _isDetail = false,
  _isSolareToolTip = false,
  _isAbyssOneToolTip = false,
  _totalDesc = {},
  _buffCount = 0,
  _beforeCount = -1,
  _startIndex = 2,
  _separationCharater = "&",
  _exeptionLanguage = false,
  _currentSocketPresetInfo = {},
  _tooltipOrderTable = {
    __eJewelSpecialSlotNecklace,
    __eJewelSpecialSlotRing1,
    __eJewelSpecialSlotRing2,
    __eJewelSpecialSlotEaring1,
    __eJewelSpecialSlotEaring2,
    __eJewelSpecialSlotBelt,
    __eJewelSpecialSlot1MorningLand,
    __eJewelSpecialSlot2MorningLand,
    __eJewelSpecialSlotAwakenWeapon1,
    __eEquipSlotNoRightHand,
    __eJewelSpecialSlotAwakenWeapon2,
    __eEquipSlotNoLeftHand,
    __eEquipSlotNoSubTool,
    __eEquipSlotNoChest,
    __eEquipSlotNoGlove,
    __eEquipSlotNoBoots,
    __eEquipSlotNoAvatarChest,
    __eEquipSlotNoHelm,
    __eEquipSlotNoNecklace,
    __eEquipSlotNoRing1,
    __eEquipSlotNoRing2,
    __eEquipSlotNoEaring1,
    __eEquipSlotNoEaring2
  },
  _initialYSize = 0
}
function CrystalTooltip:Init()
  self._ui.stc_crystalIcon = UI.getChildControl(self._ui.stc_crystalBG, "Static_CrystalIcon")
  self._ui.txt_crystalName = UI.getChildControl(self._ui.stc_crystalBG, "StaticText_CrystalName")
  self._ui.txt_crystalDesc = UI.getChildControl(self._ui.stc_crystalBG, "StaticText_CrystalDesc")
  self._ui.txt_subTitle = UI.getChildControl(self._ui.stc_detailBG, "StaticText_SubTitle")
  self._ui.txt_effectDescTemp = UI.getChildControl(self._ui.stc_detailBG, "StaticText_NameTemp")
  self._ui.txt_effectDesc = {}
  self._ui.txt_windowDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_windowDesc:SetText(self._ui.txt_windowDesc:GetText())
  self._classType = getSelfPlayer():getClassType()
  self._txt_emptySlot = " <PAColor0xffc4bebe>(" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT") .. ")<PAOldColor>"
  self._ui.txt_equipmentName:SetShow(false)
  self._ui.txt_jewelGroupName:SetShow(false)
  self._ui.stc_crystalIcon:SetShow(false)
  self._ui.txt_crystalName:SetShow(false)
  self._ui.txt_crystalDesc:SetShow(false)
  self:AllSlotIsEmpty(true)
  self:SetPanelPos()
  Panel_Equipment_Crystal_Tooltip:SetShow(false, false)
  if isGameTypeRussia() or isGameServiceTypeTurkey() then
    self._exeptionLanguage = true
  end
  local languageType = ToClient_getResourceType()
  if nil ~= languageType then
    self._languageTypeString = Defines.LanguageTypeToString[languageType]
    if nil ~= self._languageTypeString and ("FR" == self._languageTypeString or "SP" == self._languageTypeString or "PT" == self._languageTypeString or "ES" == self._languageTypeString or "DE" == self._languageTypeString) then
      self._exeptionLanguage = true
    end
  end
  self._initialYSize = Panel_Equipment_Crystal_Tooltip:GetSizeY()
end
function CrystalTooltip:Update()
  self:UpdateUI()
  self:SetPanelPos()
  _panel:SetShow(true, true)
end
function CrystalTooltip:UpdateSimpleItem()
  if nil == PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo then
    return
  end
  local characterNo = PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
  if nil == characterNo then
    return
  end
  self:UpdateUI(characterNo)
  self:SetPanelPos(true)
  _panel:SetShow(true, true)
end
function CrystalTooltip:CreateSimpleSolareUI(itemWrapper, socketNo)
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  PAGlobalFunc_SetItemTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetShow(false)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:CreateSimpleAbyssOneUI(itemWrapper, socketNo)
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  PAGlobalFunc_SetItemTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetShow(false)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:CreateDetailSolareUI(itemWrapper, socketNo)
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  PAGlobalFunc_SetItemTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
  if nil == skillSSW then
    self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  else
    local buffList = ""
    for buffIdx = 0, skillSSW:getBuffCount() - 1 do
      local desc = skillSSW:getBuffDescription(buffIdx)
      if nil == desc or "" == desc then
        break
      end
      if nil == buffList or "" == buffList then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
    end
    local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(self._classType)
    if subSkillSSW ~= nil then
      for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
        local desc = subSkillSSW:getBuffDescription(buffIdx)
        if nil == desc or "" == desc then
          break
        end
        if nil == buffList or "" == buffList then
          buffList = desc
        else
          buffList = buffList .. " / " .. desc
        end
      end
    end
    self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(itemEnchantSSW:getName() .. " <PAColor0xffc4bebe>(" .. buffList .. ")<PAOldColor>")
  end
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:CreateDetailAbyssOneUI(itemWrapper, socketNo)
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  PAGlobalFunc_SetItemTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
  if nil == skillSSW then
    self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  else
    local buffList = ""
    for buffIdx = 0, skillSSW:getBuffCount() - 1 do
      local desc = skillSSW:getBuffDescription(buffIdx)
      if nil == desc or "" == desc then
        break
      end
      if nil == buffList or "" == buffList then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
    end
    local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(self._classType)
    if subSkillSSW ~= nil then
      for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
        local desc = subSkillSSW:getBuffDescription(buffIdx)
        if nil == desc or "" == desc then
          break
        end
        if nil == buffList or "" == buffList then
          buffList = desc
        else
          buffList = buffList .. " / " .. desc
        end
      end
    end
    self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(itemEnchantSSW:getName() .. " <PAColor0xffc4bebe>(" .. buffList .. ")<PAOldColor>")
  end
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:SetSolareEquipmentAndCrystalUI(itemWrapper)
  if nil == itemWrapper then
    return
  end
  if self._usingEquipmentUICount + 1 > self._listEquipmentSize then
    self._listEquipmentName[self._usingEquipmentUICount] = self:GetNewEquipmentCopy(self._usingEquipmentUICount)
    self._listEquipmentSize = self._listEquipmentSize + 1
  end
  if 0 == self._usingEquipmentUICount then
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(self._ui.txt_equipmentName:GetPosY())
  else
    local bottomCrystal = self._listCrystal[self._usingCrystalUICount - self._socketCount - 1]
    local equipmentNamePosY = bottomCrystal.stc_crystalBG:GetPosY() + bottomCrystal.txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(equipmentNamePosY + 5)
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PAGlobalFunc_SetItemTextColor(self._listEquipmentName[self._usingEquipmentUICount], itemSSW)
  self._listEquipmentName[self._usingEquipmentUICount]:SetText(tostring(itemWrapper:getStaticStatus():getName()))
  self._listEquipmentName[self._usingEquipmentUICount]:SetShow(true)
  self._panelSizeY = self._panelSizeY + self._ui.txt_equipmentName:GetSizeY() + 5
  local curEquipNamePosY = self._listEquipmentName[self._usingEquipmentUICount]:GetPosY() + self._ui.txt_equipmentName:GetSizeY()
  local crystalPosY = 0
  for crystalIdx = 0, self._socketCount - 1 do
    local curIndex = self._usingCrystalUICount - self._socketCount + crystalIdx
    local crystalSizeY = self._listCrystal[curIndex].txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listCrystal[curIndex].stc_crystalBG:SetPosY(curEquipNamePosY + crystalPosY)
    self._listCrystal[curIndex].stc_crystalBG:SetShow(true)
    crystalPosY = crystalPosY + crystalSizeY + 5
    self._panelSizeY = self._panelSizeY + crystalSizeY
  end
  self._panelSizeY = self._panelSizeY + 5 * (self._socketCount - 1)
  self._usingEquipmentUICount = self._usingEquipmentUICount + 1
end
function CrystalTooltip:SetAbyssOneEquipmentAndCrystalUI(itemWrapper)
  if nil == itemWrapper then
    return
  end
  if self._usingEquipmentUICount + 1 > self._listEquipmentSize then
    self._listEquipmentName[self._usingEquipmentUICount] = self:GetNewEquipmentCopy(self._usingEquipmentUICount)
    self._listEquipmentSize = self._listEquipmentSize + 1
  end
  if 0 == self._usingEquipmentUICount then
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(self._ui.txt_equipmentName:GetPosY())
  else
    local bottomCrystal = self._listCrystal[self._usingCrystalUICount - self._socketCount - 1]
    local equipmentNamePosY = bottomCrystal.stc_crystalBG:GetPosY() + bottomCrystal.txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(equipmentNamePosY + 5)
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PAGlobalFunc_SetItemTextColor(self._listEquipmentName[self._usingEquipmentUICount], itemSSW)
  self._listEquipmentName[self._usingEquipmentUICount]:SetText(tostring(itemWrapper:getStaticStatus():getName()))
  self._listEquipmentName[self._usingEquipmentUICount]:SetShow(true)
  self._panelSizeY = self._panelSizeY + self._ui.txt_equipmentName:GetSizeY() + 5
  local curEquipNamePosY = self._listEquipmentName[self._usingEquipmentUICount]:GetPosY() + self._ui.txt_equipmentName:GetSizeY()
  local crystalPosY = 0
  for crystalIdx = 0, self._socketCount - 1 do
    local curIndex = self._usingCrystalUICount - self._socketCount + crystalIdx
    local crystalSizeY = self._listCrystal[curIndex].txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listCrystal[curIndex].stc_crystalBG:SetPosY(curEquipNamePosY + crystalPosY)
    self._listCrystal[curIndex].stc_crystalBG:SetShow(true)
    crystalPosY = crystalPosY + crystalSizeY + 5
    self._panelSizeY = self._panelSizeY + crystalSizeY
  end
  self._panelSizeY = self._panelSizeY + 5 * (self._socketCount - 1)
  self._usingEquipmentUICount = self._usingEquipmentUICount + 1
end
function CrystalTooltip:updateSolareCrystalTooltip()
  self._ui.txt_windowTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIPMENT_JUELTITLE"))
  self._socketCount = 0
  local isEquipExist = false
  for equipNo = self._equipNoMin, self._equipNoMax - 1 do
    local itemWrapper = ToClient_GetSolareEquippedItemWrapper(0, equipNo)
    if nil ~= itemWrapper then
      isEquipExist = true
      local socketCount = 0
      if nil ~= itemWrapper then
        socketCount = itemWrapper:get():getUsableItemSocketCount()
      end
      self._socketCount = socketCount
      if 0 ~= socketCount then
        for socketNo = 0, socketCount - 1 do
          local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
          if nil ~= itemEnchantSSW then
            if true == self._isDetail then
              CrystalTooltip:CreateDetailSolareUI(itemWrapper, socketNo)
            else
              CrystalTooltip:CreateSimpleSolareUI(itemWrapper, socketNo)
            end
          else
            self:CreateEmptyCrystalUI()
          end
          self._usingCrystalUICount = self._usingCrystalUICount + 1
        end
        CrystalTooltip:SetSolareEquipmentAndCrystalUI(itemWrapper)
      end
      _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
      self:AllSlotIsEmpty(false)
      for equipmentNo = self._usingEquipmentUICount, self._listEquipmentSize - 1 do
        self._listEquipmentName[equipmentNo]:SetShow(false)
      end
      for crystalNo = self._usingCrystalUICount, self._listCrystalSize - 1 do
        self._listCrystal[crystalNo].stc_crystalBG:SetShow(false)
      end
    end
  end
  if false == isEquipExist then
    self:AllSlotIsEmpty(false)
    _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
    for equipmentNo = self._usingEquipmentUICount, self._listEquipmentSize - 1 do
      self._listEquipmentName[equipmentNo]:SetShow(false)
    end
    for crystalNo = self._usingCrystalUICount, self._listCrystalSize - 1 do
      self._listCrystal[crystalNo].stc_crystalBG:SetShow(false)
    end
  end
  for idx = 0, self._usingCrystalGroupNumberUICount - 1 do
    if self._listCrystalGroupName[idx] ~= nil then
      self._listCrystalGroupName[idx]:SetShow(false)
    end
  end
end
function CrystalTooltip:updateAbyssOneCrystalTooltip()
  self._ui.txt_windowTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIPMENT_JUELTITLE"))
  self._socketCount = 0
  local isEquipExist = false
  for equipNo = self._equipNoMin, self._equipNoMax - 1 do
    local itemWrapper = ToClient_GetAbyssOneEquippedItemWrapper(0, equipNo)
    if nil ~= itemWrapper then
      isEquipExist = true
      local socketCount = 0
      if nil ~= itemWrapper then
        socketCount = itemWrapper:get():getUsableItemSocketCount()
      end
      self._socketCount = socketCount
      if 0 ~= socketCount then
        for socketNo = 0, socketCount - 1 do
          local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
          if nil ~= itemEnchantSSW then
            if true == self._isDetail then
              CrystalTooltip:CreateDetailAbyssOneUI(itemWrapper, socketNo)
            else
              CrystalTooltip:CreateSimpleAbyssOneUI(itemWrapper, socketNo)
            end
          else
            self:CreateEmptyCrystalUI()
          end
          self._usingCrystalUICount = self._usingCrystalUICount + 1
        end
        CrystalTooltip:SetAbyssOneEquipmentAndCrystalUI(itemWrapper)
      end
      _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
      self:AllSlotIsEmpty(false)
      for equipmentNo = self._usingEquipmentUICount, self._listEquipmentSize - 1 do
        self._listEquipmentName[equipmentNo]:SetShow(false)
      end
      for crystalNo = self._usingCrystalUICount, self._listCrystalSize - 1 do
        self._listCrystal[crystalNo].stc_crystalBG:SetShow(false)
      end
    end
  end
  if false == isEquipExist then
    self:AllSlotIsEmpty(false)
    _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
    for equipmentNo = self._usingEquipmentUICount, self._listEquipmentSize - 1 do
      self._listEquipmentName[equipmentNo]:SetShow(false)
    end
    for crystalNo = self._usingCrystalUICount, self._listCrystalSize - 1 do
      self._listCrystal[crystalNo].stc_crystalBG:SetShow(false)
    end
  end
  for idx = 0, self._usingCrystalGroupNumberUICount - 1 do
    if self._listCrystalGroupName[idx] ~= nil then
      self._listCrystalGroupName[idx]:SetShow(false)
    end
  end
end
function CrystalTooltip:UpdateUI(characterNo)
  self._usingEquipmentUICount = 0
  self._usingCrystalUICount = 0
  self._panelSizeY = 60 + self._ui.txt_windowDesc:GetTextSizeY()
  if true == self._isSolareToolTip then
    CrystalTooltip:updateSolareCrystalTooltip()
    self._ui.stc_detailBG:SetShow(false)
    return
  end
  if true == self._isAbyssOneToolTip then
    CrystalTooltip:updateAbyssOneCrystalTooltip()
    self._ui.stc_detailBG:SetShow(false)
    return
  end
  if _ContentsGroup_JewelPreset == true then
    self._totalDesc = {}
    self._buffCount = 0
    self._usingCrystalUICount = 0
    self._lastJewelGroupNumber = -1
    self._usingCrystalGroupNumberUICount = 0
    self._posY = 0
    local classType = getSelfPlayer():getClassType()
    local jewelBuffTable = {}
    local currentPresetNo = 0
    if characterNo == nil then
      currentPresetNo = ToClient_GetCurrentJewelPresetNo()
    else
      currentPresetNo = ToClient_GetJewelPresetNoByCharacterNo(characterNo)
    end
    if currentPresetNo == __eJewelNotActivatingPresetNo then
      for idx = 0, self._listEquipmentSize - 1 do
        if self._listEquipmentName[idx] ~= nil then
          self._listEquipmentName[idx]:SetShow(false)
        end
      end
      for idx, value in pairs(self._listCrystal) do
        value.stc_crystalBG:SetShow(false)
      end
      for idx, value in pairs(self._listCrystalGroupName) do
        value:SetShow(false)
      end
      self._ui.txt_windowTitle:SetText("<PAColor0xffffc340>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_NOPRESET") .. "<PAOldColor>")
      self._posY = self._ui.txt_windowTitle:GetPosY() + self._ui.txt_windowTitle:GetTextSizeY() + 20
      self._ui.txt_noCrystal:SetShow(true)
      self._ui.txt_noCrystal:SetTextMode(__eTextMode_AutoWrap)
      self._ui.txt_noCrystal:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_CRYSTAL_EMPTY"))
      self._ui.txt_noCrystal:SetPosY(self._posY)
      self._posY = self._posY + self._ui.txt_noCrystal:GetTextSizeY() + 10
      self._ui.txt_windowDesc:SetTextMode(__eTextMode_AutoWrap)
      self._ui.txt_windowDesc:SetPosY(self._posY)
      _panel:SetSize(_panel:GetSizeX(), self._posY + self._ui.txt_windowDesc:GetTextSizeY() + 10)
      self:detail()
      return
    end
    for idx, value in pairs(self._tooltipOrderTable) do
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(currentPresetNo, value)
      local needToShow = true
      local equipItemWrapper
      local socketCount = 0
      if value == __eJewelSpecialSlotAwakenWeapon1 then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
          if equipItemWrapper == nil then
            needToShow = false
          else
            socketCount = equipItemWrapper:get():getUsableItemSocketCount()
            if socketCount < 1 then
              needToShow = false
            end
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoAwakenWeapon)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              socketCount = itemWrapper:get():getUsableItemSocketCount()
              if socketCount < 1 then
                needToShow = false
              end
            end
          end
        end
      elseif value == __eJewelSpecialSlotAwakenWeapon2 then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
          if equipItemWrapper == nil then
            needToShow = false
          else
            socketCount = equipItemWrapper:get():getUsableItemSocketCount()
            if socketCount < 2 then
              needToShow = false
            end
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoAwakenWeapon)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              socketCount = itemWrapper:get():getUsableItemSocketCount()
              if socketCount < 2 then
                needToShow = false
              end
            end
          end
        end
      elseif value == __eJewelSpecialSlotPearlAvatarChest then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAvatarChest)
          if equipItemWrapper == nil then
            needToShow = false
          else
            socketCount = equipItemWrapper:get():getUsableItemSocketCount()
            if socketCount < 1 then
              needToShow = false
            end
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoAvatarChest)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              socketCount = itemWrapper:get():getUsableItemSocketCount()
              if socketCount < 1 then
                needToShow = false
              end
            end
          end
        end
      elseif value == __eJewelSpecialSlotNecklace then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoNecklace)
          if equipItemWrapper == nil then
            needToShow = false
          else
            needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoNecklace)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              needToShow = itemWrapper:getStaticStatus():get():isKarazardAccessory() == true
            end
          end
        end
      elseif value == __eJewelSpecialSlotRing1 then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoRing1)
          if equipItemWrapper == nil then
            needToShow = false
          else
            needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoRing1)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              needToShow = itemWrapper:getStaticStatus():get():isKarazardAccessory() == true
            end
          end
        end
      elseif value == __eJewelSpecialSlotRing2 then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoRing2)
          if equipItemWrapper == nil then
            needToShow = false
          else
            needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoRing2)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              needToShow = itemWrapper:getStaticStatus():get():isKarazardAccessory() == true
            end
          end
        end
      elseif value == __eJewelSpecialSlotEaring1 then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoEaring1)
          if equipItemWrapper == nil then
            needToShow = false
          else
            needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoEaring1)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              needToShow = itemWrapper:getStaticStatus():get():isKarazardAccessory() == true
            end
          end
        end
      elseif value == __eJewelSpecialSlotEaring2 then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoEaring2)
          if equipItemWrapper == nil then
            needToShow = false
          else
            needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoEaring2)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = false
            else
              needToShow = itemWrapper:getStaticStatus():get():isKarazardAccessory() == true
            end
          end
        end
      elseif value == __eJewelSpecialSlotBelt then
        if characterNo == nil then
          equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoBelt)
          if equipItemWrapper == nil then
            needToShow = false
          else
            needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
          end
        else
          equipItemWrapper = PaGlobal_SimpleInventory._equipWrapper:getSimpleEquipItemWrapper(__eEquipSlotNoBelt)
          if equipItemWrapper == nil then
            needToShow = false
          else
            local itemWrapper = equipItemWrapper:getItem()
            if itemWrapper == nil then
              needToShow = falsex
            else
              needToShow = itemWrapper:getStaticStatus():get():isKarazardAccessory() == true
            end
          end
        end
      end
      if jewelItemSSW ~= nil and needToShow == true then
        local data = {
          slotNo = value,
          groupNumber = jewelItemSSW:getJewelGroupNumber()
        }
        table.insert(jewelBuffTable, data)
      end
    end
    local sortFunction = function(data1, data2)
      if data1.groupNumber == data2.groupNumber then
        return data1.slotNo < data2.slotNo
      else
        return data1.groupNumber < data2.groupNumber
      end
    end
    table.sort(jewelBuffTable, sortFunction)
    self._posY = self._ui.txt_windowTitle:GetPosY() + self._ui.txt_windowTitle:GetTextSizeY() + 10
    for idx, value in pairs(self._listCrystal) do
      value.stc_crystalBG:SetShow(false)
    end
    for idx, value in pairs(self._listCrystalGroupName) do
      value:SetShow(false)
    end
    for idx, data in pairs(jewelBuffTable) do
      if self._isDetail == true then
        self:createDetailJewelUI(data.slotNo, classType, currentPresetNo)
      else
        self:createSimpleJewelUI(data.slotNo, classType, currentPresetNo)
      end
      self._usingCrystalUICount = self._usingCrystalUICount + 1
    end
    if currentPresetNo ~= __eJewelNotActivatingPresetNo then
      local presetName = ToClient_GetJewelPresetName(currentPresetNo)
      if presetName == nil then
        presetName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_TAB_DEFAULT1", "num", currentPresetNo + 1)
      end
      self._ui.txt_windowTitle:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_APPLYPRESET", "presetName", "<PAColor0xffffc340>" .. "[" .. presetName .. "]" .. "<PAOldColor>"))
      if 0 < self._buffCount then
        self._ui.txt_noCrystal:SetShow(false)
      else
        self._ui.txt_noCrystal:SetShow(true)
        self._ui.txt_noCrystal:SetTextMode(__eTextMode_AutoWrap)
        self._ui.txt_noCrystal:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_CRYSTAL_EMPTY"))
        self._ui.txt_noCrystal:SetPosY(self._posY)
        self._posY = self._posY + self._ui.txt_noCrystal:GetTextSizeY() + 10
      end
    end
    if self._usingCrystalUICount == 0 then
      self:AllSlotIsEmpty(true)
    else
      self._ui.txt_windowDesc:SetPosY(self._posY + 10)
      self:AllSlotIsEmpty(false)
    end
    _panel:SetSize(_panel:GetSizeX(), self._posY + self._ui.txt_windowDesc:GetTextSizeY() + 10)
    for idx = 0, self._listEquipmentSize - 1 do
      if self._listEquipmentName[idx] ~= nil then
        self._listEquipmentName[idx]:SetShow(false)
      end
    end
    self:jeweldetail()
  else
    local equipWrapper
    if nil ~= characterNo then
      equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
      if nil == equipWrapper then
        return
      end
    end
    self._totalDesc = {}
    self._buffCount = 0
    for equipNo = self._equipNoMin, self._equipNoMax - 1 do
      local itemWrapper
      if nil == characterNo then
        itemWrapper = ToClient_getEquipmentItem(equipNo)
      else
        local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
        if nil == equipItemWrapper then
          return
        end
        itemWrapper = equipItemWrapper:getItem()
      end
      local socketCount = 0
      if nil ~= itemWrapper then
        socketCount = itemWrapper:get():getUsableItemSocketCount()
      end
      self._socketCount = socketCount
      if 0 ~= socketCount then
        for socketNo = 0, socketCount - 1 do
          local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
          if nil ~= itemEnchantSSW then
            if true == self._isDetail then
              self:CreateDetailCrystalUI(equipNo, socketNo, characterNo)
            else
              self:CreateSimpleCrystalUI(equipNo, socketNo, characterNo)
            end
          else
            self:CreateEmptyCrystalUI()
          end
          self._usingCrystalUICount = self._usingCrystalUICount + 1
        end
        self:SetEquipmentAndCrystalUI(equipNo, characterNo)
      end
      _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
      self:AllSlotIsEmpty(false)
      for equipmentNo = self._usingEquipmentUICount, self._listEquipmentSize - 1 do
        self._listEquipmentName[equipmentNo]:SetShow(false)
      end
      for crystalNo = self._usingCrystalUICount, self._listCrystalSize - 1 do
        self._listCrystal[crystalNo].stc_crystalBG:SetShow(false)
      end
    end
    self:detail()
  end
end
function CrystalTooltip:createDetailJewelUI(slotNo, classType, presetNo)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(presetNo, slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local isNewGroupNumber = self:createNewGroupNameSlotUI(itemEnchantSSW:getJewelGroupNumber())
  self:CreateNewSlotUI()
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  local buffList = ""
  for buffIdx = 0, skillSSW:getBuffCount() - 1 do
    local desc = skillSSW:getBuffDescription(buffIdx)
    if desc == nil or desc == "" then
      break
    end
    if buffList == nil or buffList == "" then
      buffList = desc
    else
      buffList = buffList .. " / " .. desc
    end
    if self._exeptionLanguage == true then
      local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
      exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
      if isGameServiceTypeTurkey() then
        exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
      end
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = 0
        local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
        local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
        if count1 < count2 then
          self._separationCharater = "&"
          count = count2
        else
          self._separationCharater = ","
          count = count1
        end
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, exeption do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            if nil ~= cIndex1 then
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              end
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            else
              local cIndex1, cIndex2 = string.find(temp, "LT")
              if nil == cIndex1 then
                cIndex1, cIndex2 = string.find(temp, "%d+")
                if nil ~= cIndex1 then
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              else
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                temp = string.sub(temp, cIndex2, -1)
                self._buffCount = self._buffCount + 1
              end
            end
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    else
      local exeption = select(2, string.gsub(desc, "%d", "%d"))
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, count do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
            temp = string.sub(temp, cIndex2 + self._startIndex, -1)
            self._buffCount = self._buffCount + 1
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    end
  end
  local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(classType)
  if subSkillSSW ~= nil then
    for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
      local desc = subSkillSSW:getBuffDescription(buffIdx)
      if desc == nil or desc == "" then
        break
      end
      if buffList == nil or buffList == "" then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
      if self._exeptionLanguage == true then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
          local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                else
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              end
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      end
    end
  end
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemEnchantSSW:getName(), itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(strItemName .. " <PAColor0xffc4bebe>(" .. buffList .. ")<PAOldColor>")
  if isNewGroupNumber == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetText(itemEnchantSSW:getJewelGroupName())
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetPosY(self._posY)
    self._posY = self._posY + self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:GetTextSizeY() + 10
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetShow(true)
    self._usingCrystalGroupNumberUICount = self._usingCrystalGroupNumberUICount + 1
  end
  self._listCrystal[self._usingCrystalUICount].stc_crystalBG:SetPosY(self._posY)
  self._posY = self._posY + self._listCrystal[self._usingCrystalUICount].txt_crystalName:GetTextSizeY()
  self._listCrystal[self._usingCrystalUICount].stc_crystalBG:SetShow(true)
end
function CrystalTooltip:createSimpleJewelUI(slotNo, classType, presetNo)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(presetNo, slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local isNewGroupNumber = self:createNewGroupNameSlotUI(itemEnchantSSW:getJewelGroupNumber())
  self:CreateNewSlotUI()
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemEnchantSSW:getName(), itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(strItemName)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  for buffIdx = 0, skillSSW:getBuffCount() - 1 do
    local desc = skillSSW:getBuffDescription(buffIdx)
    if desc == nil or desc == "" then
      break
    end
    if self._exeptionLanguage == true then
      local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
      exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
      if isGameServiceTypeTurkey() then
        exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
      end
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = 0
        local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
        local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
        if count1 < count2 then
          self._separationCharater = "&"
          count = count2
        else
          self._separationCharater = ","
          count = count1
        end
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, exeption do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            if nil ~= cIndex1 then
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              end
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            else
              local cIndex1, cIndex2 = string.find(temp, "LT")
              if nil == cIndex1 then
                cIndex1, cIndex2 = string.find(temp, "%d+")
                if nil ~= cIndex1 then
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              else
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                temp = string.sub(temp, cIndex2, -1)
                self._buffCount = self._buffCount + 1
              end
            end
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    else
      local exeption = select(2, string.gsub(desc, "%d", "%d"))
      if exeption > 0 then
        self._totalDesc[self._buffCount] = desc
        local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
        if count > 0 then
          local temp = self._totalDesc[self._buffCount]
          for index = 1, count do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
            temp = string.sub(temp, cIndex2 + self._startIndex, -1)
            self._buffCount = self._buffCount + 1
          end
        else
          self._buffCount = self._buffCount + 1
        end
      end
    end
  end
  local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(classType)
  if subSkillSSW ~= nil then
    for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
      local desc = subSkillSSW:getBuffDescription(buffIdx)
      if desc == nil or desc == "" then
        break
      end
      if self._exeptionLanguage == true then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
          local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                else
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              end
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      end
    end
  end
  if isNewGroupNumber == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetText(itemEnchantSSW:getJewelGroupName())
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetPosY(self._posY)
    self._posY = self._posY + self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:GetTextSizeY() + 10
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetShow(true)
    self._usingCrystalGroupNumberUICount = self._usingCrystalGroupNumberUICount + 1
  end
  self._listCrystal[self._usingCrystalUICount].stc_crystalBG:SetPosY(self._posY)
  self._posY = self._posY + self._listCrystal[self._usingCrystalUICount].txt_crystalName:GetTextSizeY()
  self._listCrystal[self._usingCrystalUICount].stc_crystalBG:SetShow(true)
end
function CrystalTooltip:jeweldetail()
  if self._buffCount <= 0 then
    self._ui.txt_effectDescTemp:SetText("")
    CrystalTooltip._ui.stc_detailBG:SetShow(false)
    return
  end
  for idx, value in pairs(self._ui.txt_effectDesc) do
    value:SetShow(false)
  end
  local temp1, temp2, temp3 = {}, {}, {}
  for index = 0, #self._totalDesc do
    local cIndex1, cIndex2 = string.find(self._totalDesc[index], "+")
    if nil ~= cIndex1 or nil ~= cIndex2 then
      temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
      local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
      temp2[index] = tonumber(string.match(backString, "[%d%.]+"))
    else
      cIndex1, cIndex2 = string.find(self._totalDesc[index], "-")
      if nil ~= cIndex1 or nil ~= cIndex2 then
        temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
        local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
        temp2[index] = tonumber(string.match(backString, "[%d%.]+")) * -1
      else
        cIndex1, cIndex2 = string.find(self._totalDesc[index], "[%d%.]")
        if nil ~= cIndex1 then
          temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
          local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
          temp2[index] = tonumber(string.match(backString, "[%d%.]+"))
        end
      end
    end
  end
  local temp = {}
  local buffCategoryCount = 0
  for index = 0, #self._totalDesc do
    if buffCategoryCount > 0 then
      local isSame = false
      for ii = 0, buffCategoryCount - 1 do
        local compareIndex = temp[ii]
        if temp1[compareIndex] == temp1[index] and false == isSame then
          if nil ~= temp3[ii] then
            temp3[ii] = temp3[ii] + temp2[index]
          end
          isSame = true
        end
      end
      if false == isSame then
        temp[buffCategoryCount] = index
        temp3[buffCategoryCount] = temp2[index]
        buffCategoryCount = buffCategoryCount + 1
      end
    else
      temp[buffCategoryCount] = index
      temp3[buffCategoryCount] = temp2[index]
      buffCategoryCount = buffCategoryCount + 1
    end
  end
  local function jewelSubUICreate(index)
    if nil == self._ui.txt_effectDesc[index] then
      self._ui.txt_effectDesc[index] = UI.createAndCopyBasePropertyControl(self._ui.stc_detailBG, "StaticText_NameTemp", self._ui.stc_detailBG, "StaticText_EffectDesc_" .. index)
      self._ui.txt_effectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
    end
  end
  if 0 < self._beforeCount then
    for index = 0, self._beforeCount - 1 do
      self._ui.txt_effectDesc[index]:SetShow(false)
    end
  end
  for index = 0, buffCategoryCount - 1 do
    if nil ~= temp3[index] then
      if temp3[index] >= 0 then
        local minusCount = select(2, string.gsub(self._totalDesc[temp[index]], "-[%d%.]", "-[%d%.]"))
        if minusCount > 0 then
          for ii = 1, minusCount do
            if minusCount == ii then
              self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "+")
            end
          end
        end
        local plusCount = select(2, string.gsub(self._totalDesc[temp[index]], "+", "+"))
        if plusCount > 0 then
          local index1, index2 = string.find(self._totalDesc[temp[index]], "+")
          local frontString = string.sub(self._totalDesc[temp[index]], 1, index1 - 1)
          local backString = string.sub(self._totalDesc[temp[index]], index2, string.len(self._totalDesc[temp[index]]))
          backString = string.gsub(backString, "[%d%.]+", temp3[index])
          self._totalDesc[temp[index]] = frontString .. backString
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "<PAColor0xffffec80>+")
        else
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "[%d%.]+", "<PAColor0xffffec80>+" .. temp3[index])
        end
      else
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "[%d%.]+", "<PAColor0xffffec80>" .. temp3[index])
      end
      self._totalDesc[temp[index]] = self._totalDesc[temp[index]] .. "<PAOldColor>"
    end
    if index >= self._beforeCount then
      jewelSubUICreate(index)
    end
    self._ui.txt_effectDesc[index]:SetText(self._totalDesc[temp[index]])
    if index == 0 then
      self._ui.txt_effectDesc[index]:SetPosY(self._ui.txt_effectDescTemp:GetPosY())
    else
      local addGap = 0
      if 0 == index % 3 then
        addGap = 10
      end
      self._ui.txt_effectDesc[index]:SetPosY(self._ui.txt_effectDesc[index - 1]:GetPosY() + math.max(20, self._ui.txt_effectDesc[index - 1]:GetTextSizeY()) + addGap)
    end
    self._ui.txt_effectDesc[index]:SetShow(true)
  end
  self._ui.stc_detailBG:SetSize(self._ui.stc_detailBG:GetSizeX(), self._ui.txt_effectDesc[buffCategoryCount - 1]:GetPosY() + math.max(20, self._ui.txt_effectDesc[buffCategoryCount - 1]:GetTextSizeY()) + 10)
  CrystalTooltip._ui.stc_detailBG:SetShow(true)
end
function CrystalTooltip:detail()
  if true == self._isSolareToolTip or true == self._isAbyssOneToolTip then
    self._ui.stc_detailBG:SetShow(false)
    return
  end
  if 0 >= self._buffCount then
    self._ui.stc_detailBG:SetShow(false)
    return
  end
  local temp1, temp2, temp3 = {}, {}, {}
  for index = 0, #self._totalDesc do
    local cIndex1, cIndex2 = string.find(self._totalDesc[index], "+")
    if nil ~= cIndex1 or nil ~= cIndex2 then
      temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
      temp2[index] = tonumber(string.match(self._totalDesc[index], "%d+"))
    else
      cIndex1, cIndex2 = string.find(self._totalDesc[index], "-")
      if nil ~= cIndex1 or nil ~= cIndex2 then
        temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
        temp2[index] = tonumber(string.match(self._totalDesc[index], "%d+")) * -1
      else
        cIndex1, cIndex2 = string.find(self._totalDesc[index], "%d")
        if nil ~= cIndex1 then
          temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
          temp2[index] = tonumber(string.match(self._totalDesc[index], "%d+"))
        end
      end
    end
  end
  local temp = {}
  local buffCategoryCount = 0
  for index = 0, #self._totalDesc do
    if buffCategoryCount > 0 then
      local isSame = false
      for ii = 0, buffCategoryCount - 1 do
        local compareIndex = temp[ii]
        if temp1[compareIndex] == temp1[index] and false == isSame then
          if nil ~= temp3[ii] then
            temp3[ii] = temp3[ii] + temp2[index]
          end
          isSame = true
        end
      end
      if false == isSame then
        temp[buffCategoryCount] = index
        temp3[buffCategoryCount] = temp2[index]
        buffCategoryCount = buffCategoryCount + 1
      end
    else
      temp[buffCategoryCount] = index
      temp3[buffCategoryCount] = temp2[index]
      buffCategoryCount = buffCategoryCount + 1
    end
  end
  local function crystalSubUICreate(index)
    if nil == self._ui.txt_effectDesc[index] then
      self._ui.txt_effectDesc[index] = UI.createAndCopyBasePropertyControl(self._ui.stc_detailBG, "StaticText_NameTemp", self._ui.stc_detailBG, "StaticText_EffectDesc_" .. index)
      self._ui.txt_effectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
    end
  end
  if 0 < self._beforeCount then
    for index = 0, self._beforeCount - 1 do
      self._ui.txt_effectDesc[index]:SetShow(false)
    end
  end
  for index = 0, buffCategoryCount - 1 do
    if nil ~= temp3[index] then
      if temp3[index] >= 0 then
        local minusCount = select(2, string.gsub(self._totalDesc[temp[index]], "-", "-"))
        if minusCount > 0 then
          for ii = 1, minusCount do
            if minusCount == ii then
              self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-%d", "+%d")
            else
              self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-%d", "+%d")
            end
          end
        end
        local plusCount = select(2, string.gsub(self._totalDesc[temp[index]], "+", "+"))
        if plusCount > 0 then
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "%d+", temp3[index])
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "<PAColor0xffffec80>+")
        else
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "%d+", "<PAColor0xffffec80>+" .. temp3[index])
        end
      else
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "%d+", "<PAColor0xffffec80>" .. temp3[index])
      end
      self._totalDesc[temp[index]] = self._totalDesc[temp[index]] .. "<PAOldColor>"
    end
    if index >= self._beforeCount then
      crystalSubUICreate(index)
    end
    self._ui.txt_effectDesc[index]:SetText(self._totalDesc[temp[index]])
    if 0 == index then
      self._ui.txt_effectDesc[index]:SetPosY(self._ui.txt_effectDescTemp:GetPosY())
    else
      local addGap = 0
      if 0 == index % 3 then
        addGap = 10
      end
      self._ui.txt_effectDesc[index]:SetPosY(self._ui.txt_effectDesc[index - 1]:GetPosY() + math.max(20, self._ui.txt_effectDesc[index - 1]:GetTextSizeY()) + addGap)
    end
    self._ui.txt_effectDesc[index]:SetShow(true)
  end
  self._beforeCount = buffCategoryCount
  self._ui.stc_detailBG:SetSize(self._ui.stc_detailBG:GetSizeX(), self._ui.txt_effectDesc[buffCategoryCount - 1]:GetPosY() + math.max(20, self._ui.txt_effectDesc[buffCategoryCount - 1]:GetTextSizeY()) + 10)
  self._ui.stc_detailBG:SetShow(true)
end
function CrystalTooltip:createNewGroupNameSlotUI(groupNumber)
  local isNewJewelGroup = false
  if self._lastJewelGroupNumber ~= groupNumber then
    isNewJewelGroup = true
    self._lastJewelGroupNumber = groupNumber
  else
    isNewJewelGroup = false
  end
  if self._usingCrystalGroupNumberUICount + 1 > self._listCrystalGroupNameSize and isNewJewelGroup == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount] = self:getNewCrystalGroupNameCopy(self._usingCrystalGroupNumberUICount)
    self._listCrystalGroupNameSize = self._listCrystalGroupNameSize + 1
  end
  return isNewJewelGroup
end
function CrystalTooltip:getNewCrystalGroupNameCopy(idx)
  local _crystalGroupNameCopy = UI.createAndCopyBasePropertyControl(_panel, "StaticText_JewelGroupName", _panel, "StaticText_JewelGroupName_No" .. idx)
  return _crystalGroupNameCopy
end
function CrystalTooltip:CreateNewSlotUI()
  if self._usingCrystalUICount + 1 > self._listCrystalSize then
    self._listCrystal[self._usingCrystalUICount] = self:GetNewCrystalCopy(self._usingCrystalUICount)
    self._listCrystalSize = self._listCrystalSize + 1
  end
end
function CrystalTooltip:CreateEmptyCrystalUI()
  self:CreateNewSlotUI()
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(self._txt_emptySlot)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_common_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 179, 104, 225, 150)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetShow(false)
end
function CrystalTooltip:CreateSimpleCrystalUI(equipNo, socketNo, characterNo)
  local itemWrapper
  if nil == characterNo then
    itemWrapper = ToClient_getEquipmentItem(equipNo)
  else
    local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
    local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
    if nil == equipItemWrapper then
      return
    end
    itemWrapper = equipItemWrapper:getItem()
  end
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  PAGlobalFunc_SetItemTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetShow(false)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
  local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
  if nil ~= skillSSW then
    for buffIdx = 0, skillSSW:getBuffCount() - 1 do
      local desc = skillSSW:getBuffDescription(buffIdx)
      if nil == desc or "" == desc then
        break
      end
      if true == self._exeptionLanguage then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
          local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                else
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              end
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      end
    end
    local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(self._classType)
    if subSkillSSW ~= nil then
      for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
        local desc = subSkillSSW:getBuffDescription(buffIdx)
        if nil == desc or "" == desc then
          break
        end
        if true == self._exeptionLanguage then
          local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
          exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
          if isGameServiceTypeTurkey() then
            exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
          end
          if exeption > 0 then
            self._totalDesc[self._buffCount] = desc
            local count = 0
            local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
            local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
            if count1 < count2 then
              self._separationCharater = "&"
              count = count2
            else
              self._separationCharater = ","
              count = count1
            end
            if count > 0 then
              local temp = self._totalDesc[self._buffCount]
              for index = 1, exeption do
                local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
                if nil ~= cIndex1 then
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                  if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                    temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                  end
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._buffCount = self._buffCount + 1
                else
                  local cIndex1, cIndex2 = string.find(temp, "LT")
                  if nil == cIndex1 then
                    cIndex1, cIndex2 = string.find(temp, "%d+")
                    if nil ~= cIndex1 then
                      self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                      temp = string.sub(temp, cIndex2, -1)
                      self._buffCount = self._buffCount + 1
                    end
                  else
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                end
              end
            else
              self._buffCount = self._buffCount + 1
            end
          end
        else
          local exeption = select(2, string.gsub(desc, "%d", "%d"))
          if exeption > 0 then
            self._totalDesc[self._buffCount] = desc
            local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
            if count > 0 then
              local temp = self._totalDesc[self._buffCount]
              for index = 1, count do
                local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              end
            else
              self._buffCount = self._buffCount + 1
            end
          end
        end
      end
    end
  end
end
function CrystalTooltip:CreateDetailCrystalUI(equipNo, socketNo, characterNo)
  local itemWrapper
  if nil == characterNo then
    itemWrapper = ToClient_getEquipmentItem(equipNo)
  else
    local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
    local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
    if nil == equipItemWrapper then
      return
    end
    itemWrapper = equipItemWrapper:getItem()
  end
  if nil == itemWrapper then
    return
  end
  local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
  self:CreateNewSlotUI()
  PAGlobalFunc_SetItemTextColor(self._listCrystal[self._usingCrystalUICount].txt_crystalName, itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(tostring(itemEnchantSSW:getName()))
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:getBaseTexture())
  local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
  if nil == skillSSW then
    self._listCrystal[self._usingCrystalUICount].txt_crystalDesc:SetText(" ")
  else
    local buffList = ""
    for buffIdx = 0, skillSSW:getBuffCount() - 1 do
      local desc = skillSSW:getBuffDescription(buffIdx)
      if nil == desc or "" == desc then
        break
      end
      if nil == buffList or "" == buffList then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
      if true == self._exeptionLanguage then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
          local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                else
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._buffCount = self._buffCount + 1
                end
              end
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._totalDesc[self._buffCount] = desc
          local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._totalDesc[self._buffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + self._startIndex, -1)
              self._buffCount = self._buffCount + 1
            end
          else
            self._buffCount = self._buffCount + 1
          end
        end
      end
    end
    local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(self._classType)
    if subSkillSSW ~= nil then
      for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
        local desc = subSkillSSW:getBuffDescription(buffIdx)
        if nil == desc or "" == desc then
          break
        end
        if nil == buffList or "" == buffList then
          buffList = desc
        else
          buffList = buffList .. " / " .. desc
        end
        if true == self._exeptionLanguage then
          local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
          exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
          if isGameServiceTypeTurkey() then
            exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
          end
          if exeption > 0 then
            self._totalDesc[self._buffCount] = desc
            local count = 0
            local count1 = select(2, string.gsub(self._totalDesc[self._buffCount], ",", ","))
            local count2 = select(2, string.gsub(self._totalDesc[self._buffCount], "&", "&"))
            if count1 < count2 then
              self._separationCharater = "&"
              count = count2
            else
              self._separationCharater = ","
              count = count1
            end
            if count > 0 then
              local temp = self._totalDesc[self._buffCount]
              for index = 1, exeption do
                local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
                if nil ~= cIndex1 then
                  self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                  if 0 == select(2, string.gsub(self._totalDesc[self._buffCount], "%d", "%d")) then
                    temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                  end
                  temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                  self._buffCount = self._buffCount + 1
                else
                  local cIndex1, cIndex2 = string.find(temp, "LT")
                  if nil == cIndex1 then
                    cIndex1, cIndex2 = string.find(temp, "%d+")
                    if nil ~= cIndex1 then
                      self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                      temp = string.sub(temp, cIndex2, -1)
                      self._buffCount = self._buffCount + 1
                    end
                  else
                    self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._buffCount = self._buffCount + 1
                  end
                end
              end
            else
              self._buffCount = self._buffCount + 1
            end
          end
        else
          local exeption = select(2, string.gsub(desc, "%d", "%d"))
          if exeption > 0 then
            self._totalDesc[self._buffCount] = desc
            local count = select(2, string.gsub(self._totalDesc[self._buffCount], self._separationCharater, self._separationCharater))
            if count > 0 then
              local temp = self._totalDesc[self._buffCount]
              for index = 1, count do
                local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
                self._totalDesc[self._buffCount] = string.sub(temp, 1, cIndex1 - 1)
                temp = string.sub(temp, cIndex2 + self._startIndex, -1)
                self._buffCount = self._buffCount + 1
              end
            else
              self._buffCount = self._buffCount + 1
            end
          end
        end
      end
    end
    self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetText(itemEnchantSSW:getName() .. " <PAColor0xffc4bebe>(" .. buffList .. ")<PAOldColor>")
  end
  self._listCrystal[self._usingCrystalUICount].txt_crystalName:SetShow(true)
  self._listCrystal[self._usingCrystalUICount].stc_crystalIcon:SetShow(true)
end
function CrystalTooltip:SetEquipmentAndCrystalUI(equipNo, characterNo)
  local itemWrapper
  if nil == characterNo then
    itemWrapper = ToClient_getEquipmentItem(equipNo)
  else
    local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
    local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
    if nil == equipItemWrapper then
      return
    end
    itemWrapper = equipItemWrapper:getItem()
  end
  if nil == itemWrapper then
    return
  end
  if self._usingEquipmentUICount + 1 > self._listEquipmentSize then
    self._listEquipmentName[self._usingEquipmentUICount] = self:GetNewEquipmentCopy(self._usingEquipmentUICount)
    self._listEquipmentSize = self._listEquipmentSize + 1
  end
  if 0 == self._usingEquipmentUICount then
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(self._ui.txt_equipmentName:GetPosY())
  else
    local bottomCrystal = self._listCrystal[self._usingCrystalUICount - self._socketCount - 1]
    local equipmentNamePosY = bottomCrystal.stc_crystalBG:GetPosY() + bottomCrystal.txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listEquipmentName[self._usingEquipmentUICount]:SetPosY(equipmentNamePosY + 5)
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PAGlobalFunc_SetItemTextColor(self._listEquipmentName[self._usingEquipmentUICount], itemSSW)
  self._listEquipmentName[self._usingEquipmentUICount]:SetText(tostring(itemWrapper:getStaticStatus():getName()))
  self._listEquipmentName[self._usingEquipmentUICount]:SetShow(true)
  self._panelSizeY = self._panelSizeY + self._ui.txt_equipmentName:GetSizeY() + 5
  local curEquipNamePosY = self._listEquipmentName[self._usingEquipmentUICount]:GetPosY() + self._ui.txt_equipmentName:GetSizeY()
  local crystalPosY = 0
  for crystalIdx = 0, self._socketCount - 1 do
    local curIndex = self._usingCrystalUICount - self._socketCount + crystalIdx
    local crystalSizeY = self._listCrystal[curIndex].txt_crystalName:GetTextSizeY()
    if true == self._isDetail then
    end
    self._listCrystal[curIndex].stc_crystalBG:SetPosY(curEquipNamePosY + crystalPosY)
    self._listCrystal[curIndex].stc_crystalBG:SetShow(true)
    crystalPosY = crystalPosY + crystalSizeY + 5
    self._panelSizeY = self._panelSizeY + crystalSizeY
  end
  self._panelSizeY = self._panelSizeY + 5 * (self._socketCount - 1)
  self._usingEquipmentUICount = self._usingEquipmentUICount + 1
end
function CrystalTooltip:SetPanelPos(isSimpleItem)
  local control
  if true == _ContentsGroup_NewUI_Equipment_All then
    control = Panel_Window_Equipment_All
  else
    control = Panel_Equipment
  end
  if true == isSimpleItem then
    control = Panel_Window_SimpleInventory
  end
  if true == self._isSolareToolTip and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == false then
    control = Panel_Solrare_EquipPresetList
  end
  if true == self._isAbyssOneToolTip then
    control = Panel_AbyssOne_EquipPresetList
  end
  if nil == control then
    return
  end
  local equipPosX = 0
  local equipPosY = 0
  if true == control:IsUISubApp() then
    equipPosX = control:GetScreenParentPosX()
    equipPosY = control:GetScreenParentPosY()
  else
    equipPosX = control:GetPosX()
    equipPosY = control:GetPosY()
  end
  local posX = equipPosX - _panel:GetSizeX() - 5
  if posX < self._ui.stc_detailBG:GetSizeX() + 5 then
    posX = equipPosX + control:GetSizeX() + 5
    self._ui.stc_detailBG:SetPosX(_panel:GetSizeX() + 5)
  else
    self._ui.stc_detailBG:SetPosX(-5 - self._ui.stc_detailBG:GetSizeX())
  end
  local posY = equipPosY + control:GetSizeY() - _panel:GetSizeY()
  if posY < 0 then
    posY = 0
  elseif getScreenSizeY() < posY + _panel:GetSizeY() then
    posY = getScreenSizeY() - _panel:GetSizeY()
  end
  if true == self._isSolareToolTip and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == false then
    posX = Panel_Solrare_EquipPresetList:GetPosX() - _panel:GetSizeX()
    posY = Panel_Solrare_EquipPresetList:GetPosY()
  end
  if true == self._isAbyssOneToolTip then
    posX = Panel_AbyssOne_EquipPresetList:GetPosX() - _panel:GetSizeX()
    posY = Panel_AbyssOne_EquipPresetList:GetPosY()
  end
  _panel:SetPosX(posX)
  _panel:SetPosY(posY)
  self._ui.txt_windowDesc:ComputePos()
  self._ui.stc_detailBG:SetPosY(_panel:GetSizeY() - self._ui.stc_detailBG:GetSizeY())
  self._ui.txt_subTitle:ComputePos()
end
function CrystalTooltip:GetNewEquipmentCopy(idx)
  local _equipmentCopy = UI.createAndCopyBasePropertyControl(_panel, "StaticText_EquipmentName", _panel, "StaticText_EquipmentName_No" .. idx)
  return _equipmentCopy
end
function CrystalTooltip:GetNewCrystalCopy(idx)
  local _crystalCopy = {
    stc_crystalBG,
    stc_crystalIcon,
    txt_crystalName,
    txt_crystalDesc
  }
  _crystalCopy.stc_crystalBG = UI.createAndCopyBasePropertyControl(_panel, "Static_CrystalBG", _panel, "Static_CrystalBG_No" .. idx)
  _crystalCopy.stc_crystalIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_crystalBG, "Static_CrystalIcon", _crystalCopy.stc_crystalBG, "Static_CrystalIcon_No" .. idx)
  _crystalCopy.txt_crystalName = UI.createAndCopyBasePropertyControl(self._ui.stc_crystalBG, "StaticText_CrystalName", _crystalCopy.stc_crystalBG, "StaticText_CrystalName_No" .. idx)
  _crystalCopy.txt_crystalDesc = UI.createAndCopyBasePropertyControl(self._ui.stc_crystalBG, "StaticText_CrystalDesc", _crystalCopy.stc_crystalBG, "StaticText_CrystalDesc_No" .. idx)
  _crystalCopy.txt_crystalDesc:SetTextMode(__eTextMode_AutoWrap)
  _crystalCopy.txt_crystalName:SetTextMode(__eTextMode_AutoWrap)
  return _crystalCopy
end
function CrystalTooltip:AllSlotIsEmpty(flag)
  self._ui.txt_noCrystal:SetShow(flag)
end
function PaGlobalFunc_CrystalToolTip_InitWithIcon(icon)
  if not icon then
    return false
  end
  icon:addInputEvent("Mouse_On", "PAGlobalFunc_CrystalTooltip_Show(true)")
  icon:addInputEvent("Mouse_Out", "PAGlobalFunc_CrystalTooltip_Show(false)")
  icon:addInputEvent("Mouse_LUp", "PAGlobalFunc_CrystalTooltip_ToggleDetail()")
  return true
end
function PAGlobalFunc_CrystalTooltip_ToggleDetail()
  local self = CrystalTooltip
  self._isDetail = not self._isDetail
  self:Update()
  if true == _panel:IsUISubApp() then
    _panel:CloseUISubApp()
    self:SetPanelPos()
    _panel:OpenUISubApp()
  end
end
function PAGlobalFunc_CrystalTooltip_Show(flag)
  local self = CrystalTooltip
  if _panel:GetShow() == flag then
    return
  end
  self._isSolareToolTip = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  self._isAbyssOneToolTip = false
  if flag then
    self._isDetail = false
    self:Update()
  end
  local equipPanel
  if true == _ContentsGroup_NewUI_Equipment_All then
    equipPanel = Panel_Window_Equipment_All
  else
    equipPanel = Panel_Equipment
  end
  if true == equipPanel:IsUISubApp() then
    if flag then
      _panel:SetShow(true)
      _panel:OpenUISubApp()
    else
      _panel:SetShow(false)
      _panel:CloseUISubApp()
    end
  else
    _panel:SetShow(flag, flag)
  end
end
function PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(flag)
  if _panel:GetShow() == flag then
    return
  end
  if true == flag then
    CrystalTooltip._isDetail = false
    CrystalTooltip:UpdateSimpleItem()
  end
  _panel:SetShow(flag, flag)
end
function PAGlobalFunc_CrystalTooltip_ToggleDetail_ForSimpleItem()
  local self = CrystalTooltip
  self._isDetail = not self._isDetail
  self:UpdateSimpleItem()
end
function FGlobal_CrystalToolTip_Init()
  local self = CrystalTooltip
  self:Init()
  registerEvent("FromClient_UpdateJewelPresetInfo", "FromClient_CrystalTooltip_LoadCurrentPresetInfo")
end
function PAGlobalFunc_CrystalTooltip_LoadedPresetInfoReset()
  if nil == CrystalTooltip then
    return
  end
  for idx, value in pairs(CrystalTooltip._tooltipOrderTable) do
    if nil ~= CrystalTooltip._currentSocketPresetInfo[value] then
      CrystalTooltip._currentSocketPresetInfo[value] = -1
    end
  end
end
function FromClient_CrystalTooltip_LoadCurrentPresetInfo(slotNo, jewelNo_s64)
  CrystalTooltip._currentSocketPresetInfo[slotNo] = Int64toInt32(jewelNo_s64)
end
function PAGlobalFunc_CrystalTooltip_SolareCrystalToolTipOpen(flag)
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  if false == Panel_Solrare_EquipPresetList:GetShow() then
    return
  end
  local self = CrystalTooltip
  self._isSolareToolTip = true
  if flag then
    self._isDetail = false
    self:Update()
  end
  if false == flag then
    self._isSolareToolTip = false
  end
  if true == Panel_Solrare_EquipPresetList:IsUISubApp() then
    if flag then
      _panel:SetShow(true)
      _panel:OpenUISubApp()
    else
      _panel:SetShow(false)
      _panel:CloseUISubApp()
    end
  else
    _panel:SetShow(flag, flag)
  end
end
function PAGlobalFunc_CrystalTooltip_AbyssOneCrystalToolTipOpen(flag)
  if nil == Panel_AbyssOne_EquipPresetList then
    return
  end
  if false == Panel_AbyssOne_EquipPresetList:GetShow() then
    return
  end
  local self = CrystalTooltip
  self._isAbyssOneToolTip = true
  if flag then
    self._isDetail = false
    self:Update()
  end
  if false == flag then
    self._isAbyssOneToolTip = false
  end
  if true == Panel_AbyssOne_EquipPresetList:IsUISubApp() then
    if flag then
      _panel:SetShow(true)
      _panel:OpenUISubApp()
    else
      _panel:SetShow(false)
      _panel:CloseUISubApp()
    end
  else
    _panel:SetShow(flag, flag)
  end
end
function PaGlobalFunc_CrystalTooltip_ShowToggle()
  if Panel_Equipment_Crystal_Tooltip == nil then
    return
  end
  local isShow = Panel_Equipment_Crystal_Tooltip:GetShow()
  PAGlobalFunc_CrystalTooltip_AbyssOneCrystalToolTipOpen(not isShow)
end
function PaGlobalFunc_CrystalTooltip_ShowDetail()
  if Panel_Equipment_Crystal_Tooltip == nil then
    return
  end
  if Panel_Equipment_Crystal_Tooltip:GetShow() == false then
    return
  end
  PAGlobalFunc_CrystalTooltip_ToggleDetail()
end
registerEvent("FromClient_luaLoadComplete", "FGlobal_CrystalToolTip_Init")
