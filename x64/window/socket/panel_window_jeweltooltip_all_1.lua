function PaGlobal_JewelTooltip:initialize()
  if self._isInitialize == true then
    return
  end
  if _ContentsGroup_JewelPreset == false then
    return
  end
  self._ui.txt_Title = UI.getChildControl(Panel_Window_JewelPreset_Tooltip_All, "StaticText_Title")
  self._ui.txt_NoCrystal = UI.getChildControl(Panel_Window_JewelPreset_Tooltip_All, "StaticText_NoCrystal")
  self._ui.txt_LeftButtonDesc = UI.getChildControl(Panel_Window_JewelPreset_Tooltip_All, "StaticText_Desc")
  self._ui.stc_CrystalGroupName = UI.getChildControl(Panel_Window_JewelPreset_Tooltip_All, "StaticText_JewelGroupName")
  self._ui.stc_CrystalBg = UI.getChildControl(Panel_Window_JewelPreset_Tooltip_All, "Static_CrystalBG")
  self._ui.txt_CrystalDesc = UI.getChildControl(self._ui.stc_CrystalBg, "StaticText_CrystalDesc")
  self._ui.txt_CrystalName = UI.getChildControl(self._ui.stc_CrystalBg, "StaticText_CrystalName")
  self._ui.stc_CrystalIcon = UI.getChildControl(self._ui.stc_CrystalBg, "Static_CrystalIcon")
  self._ui.stc_DetailBG = UI.getChildControl(Panel_Window_JewelPreset_Tooltip_All, "Static_DetailBg")
  self._ui.stc_SubTitle = UI.getChildControl(self._ui.stc_DetailBG, "StaticText_SubTitle")
  self._ui.txt_Desc = UI.getChildControl(self._ui.stc_DetailBG, "StaticText_NameTemp")
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
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._isConsole = ToClient_isConsole()
  self:validate()
  self:initializeControl()
  self._isInitialize = true
end
function PaGlobal_JewelTooltip:initializeControl()
  self._ui.txt_CrystalDesc:SetShow(false)
  self._ui.stc_DetailBG:SetShow(true)
end
function PaGlobal_JewelTooltip:prepareOpen()
  if Panel_Window_JewelPreset_Tooltip_All == nil then
    return
  end
  self:open()
end
function PaGlobal_JewelTooltip:open()
  if Panel_Window_JewelPreset_Tooltip_All == nil then
    return
  end
  Panel_Window_JewelPreset_Tooltip_All:SetShow(true)
end
function PaGlobal_JewelTooltip:prepareClose()
  if Panel_Window_JewelPreset_Tooltip_All == nil then
    return
  end
  self:close()
end
function PaGlobal_JewelTooltip:close()
  if Panel_Window_JewelPreset_Tooltip_All == nil then
    return
  end
  Panel_Window_JewelPreset_Tooltip_All:SetShow(false)
end
function PaGlobal_JewelTooltip:computePos()
  local posX = Panel_Window_JewelPreset_All:GetPosX() - Panel_Window_JewelPreset_Tooltip_All:GetSizeX() - 5
  local posY = Panel_Window_JewelPreset_All:GetPosY() + Panel_Window_JewelPreset_All:GetSizeY() - Panel_Window_JewelPreset_Tooltip_All:GetSizeY()
  Panel_Window_JewelPreset_Tooltip_All:SetPosXY(posX, posY)
  posX = -self._ui.stc_DetailBG:GetSizeX() - 5
  posY = Panel_Window_JewelPreset_Tooltip_All:GetSizeY() - self._ui.stc_DetailBG:GetSizeY()
  self._ui.stc_DetailBG:SetPosXY(posX, posY)
  if Panel_Window_JewelPreset_Tooltip_All:GetPosX() - self._ui.stc_DetailBG:GetSizeX() - 5 <= 0 then
    posX = Panel_Window_JewelPreset_All:GetPosX() + Panel_Window_JewelPreset_All:GetSizeX() + 5
    Panel_Window_JewelPreset_Tooltip_All:SetPosX(posX)
    posX = Panel_Window_JewelPreset_Tooltip_All:GetSizeX() + 5
    self._ui.stc_DetailBG:SetPosX(posX)
  end
  local panelPosY = Panel_Window_JewelPreset_Tooltip_All:GetPosY()
  if panelPosY < 0 then
    Panel_Window_JewelPreset_Tooltip_All:SetPosY(0)
    self._ui.stc_DetailBG:SetPosY(Panel_Window_JewelPreset_Tooltip_All:GetPosY() + Panel_Window_JewelPreset_Tooltip_All:GetSizeY() - self._ui.stc_DetailBG:GetSizeY())
  end
end
function PaGlobal_JewelTooltip:update()
  self._totalDesc = {}
  self._buffCount = 0
  self._usingCrystalUICount = 0
  self._posY = 0
  self._lastJewelGroupNumber = -1
  self._usingCrystalGroupNumberUICount = 0
  local classType = getSelfPlayer():getClassType()
  local jewelBuffTable = {}
  local currentPresetNo = ToClient_GetCurrentJewelPresetNo()
  if currentPresetNo == __eJewelNotActivatingPresetNo then
    for idx, value in pairs(self._listCrystal) do
      value.stc_CrystalBG:SetShow(false)
    end
    for idx, value in pairs(self._listCrystalGroupName) do
      value:SetShow(false)
    end
    self._ui.txt_Title:SetText("<PAColor0xffffc340>" .. PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_NOPRESET") .. "<PAOldColor>")
    self._posY = self._ui.txt_Title:GetPosY() + self._ui.txt_Title:GetTextSizeY() + 20
    self._ui.txt_NoCrystal:SetShow(true)
    self._ui.txt_NoCrystal:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_NoCrystal:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_CRYSTAL_EMPTY"))
    self._ui.txt_NoCrystal:SetPosY(self._posY)
    self._posY = self._posY + self._ui.txt_NoCrystal:GetTextSizeY() + 10
    self._ui.txt_LeftButtonDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_LeftButtonDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIPMENT_SETEFFECT_DESC"))
    self._ui.txt_LeftButtonDesc:SetPosY(self._posY)
    Panel_Window_JewelPreset_Tooltip_All:SetSize(Panel_Window_JewelPreset_Tooltip_All:GetSizeX(), self._posY + self._ui.txt_LeftButtonDesc:GetTextSizeY() + 10)
    self:detail()
    return
  end
  for idx, value in pairs(self._tooltipOrderTable) do
    local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(currentPresetNo, value)
    local needToShow = true
    local equipItemWrapper
    local socketCount = 0
    if value == __eJewelSpecialSlotAwakenWeapon1 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
      if equipItemWrapper == nil then
        needToShow = false
      else
        socketCount = equipItemWrapper:get():getUsableItemSocketCount()
        if socketCount < 1 then
          needToShow = false
        end
      end
    elseif value == __eJewelSpecialSlotAwakenWeapon2 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAwakenWeapon)
      if equipItemWrapper == nil then
        needToShow = false
      else
        socketCount = equipItemWrapper:get():getUsableItemSocketCount()
        if socketCount < 2 then
          needToShow = false
        end
      end
    elseif value == __eJewelSpecialSlotPearlAvatarChest then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAvatarChest)
      if equipItemWrapper == nil then
        needToShow = false
      else
        socketCount = equipItemWrapper:get():getUsableItemSocketCount()
        if socketCount < 1 then
          needToShow = false
        end
      end
    elseif value == __eJewelSpecialSlotNecklace then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoNecklace)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotRing1 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoRing1)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotRing2 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoRing2)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotEaring1 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoEaring1)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotEaring2 then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoEaring2)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
      end
    elseif value == __eJewelSpecialSlotBelt then
      equipItemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoBelt)
      if equipItemWrapper == nil then
        needToShow = false
      else
        needToShow = equipItemWrapper:getStaticStatus():get():isKarazardAccessory() == true
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
  self._posY = self._ui.txt_Title:GetPosY() + self._ui.txt_Title:GetTextSizeY() + 10
  for idx, value in pairs(self._listCrystal) do
    value.stc_CrystalBG:SetShow(false)
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
  if ToClient_GetCurrentJewelPresetNo() ~= __eJewelNotActivatingPresetNo then
    local presetName = PaGlobal_JewelPreset._ui.txt_AdjustName:GetText()
    if presetName ~= nil then
      self._ui.txt_Title:SetText(presetName)
    end
    if self._buffCount > 0 then
      self._ui.txt_NoCrystal:SetShow(false)
    else
      self._ui.txt_NoCrystal:SetShow(true)
      self._ui.txt_NoCrystal:SetTextMode(__eTextMode_AutoWrap)
      self._ui.txt_NoCrystal:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOOLTIP_CRYSTAL_EMPTY"))
      self._ui.txt_NoCrystal:SetPosY(self._posY)
      self._posY = self._posY + self._ui.txt_NoCrystal:GetTextSizeY() + 10
    end
  end
  self._ui.txt_LeftButtonDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_LeftButtonDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIPMENT_SETEFFECT_DESC"))
  self._ui.txt_LeftButtonDesc:SetPosY(self._posY)
  Panel_Window_JewelPreset_Tooltip_All:SetSize(Panel_Window_JewelPreset_Tooltip_All:GetSizeX(), self._posY + self._ui.txt_LeftButtonDesc:GetTextSizeY() + 10)
  self:detail()
end
function PaGlobal_JewelTooltip:createDetailJewelUI(slotNo, classType, presetNo)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(presetNo, slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local isNewGroupNumber = self:createNewGroupNameSlotUI(itemEnchantSSW:getJewelGroupNumber())
  self:createNewSlotUI()
  self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:getBaseTexture())
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
  self._listCrystal[self._usingCrystalUICount].txt_CrystalName:SetText(strItemName .. " <PAColor0xffc4bebe>(" .. buffList .. ")<PAOldColor>")
  if isNewGroupNumber == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetText(itemEnchantSSW:getJewelGroupName())
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetPosY(self._posY)
    self._posY = self._posY + self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:GetTextSizeY() + 10
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetShow(true)
    self._usingCrystalGroupNumberUICount = self._usingCrystalGroupNumberUICount + 1
  end
  self._listCrystal[self._usingCrystalUICount].stc_CrystalBG:SetPosY(self._posY)
  self._posY = self._posY + self._listCrystal[self._usingCrystalUICount].txt_CrystalName:GetTextSizeY()
  self._listCrystal[self._usingCrystalUICount].stc_CrystalBG:SetShow(true)
end
function PaGlobal_JewelTooltip:createSimpleJewelUI(slotNo, classType, presetNo)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(presetNo, slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local isNewGroupNumber = self:createNewGroupNameSlotUI(itemEnchantSSW:getJewelGroupNumber())
  self:createNewSlotUI()
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemEnchantSSW:getName(), itemEnchantSSW)
  self._listCrystal[self._usingCrystalUICount].txt_CrystalName:SetText(strItemName)
  self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon, 0, 0, 42, 42)
  self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:setRenderTexture(self._listCrystal[self._usingCrystalUICount].stc_CrystalIcon:getBaseTexture())
  self._listCrystal[self._usingCrystalUICount].txt_CrystalDesc:SetText(" ")
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
  if isNewGroupNumber == true then
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetText(itemEnchantSSW:getJewelGroupName())
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetPosY(self._posY)
    self._posY = self._posY + self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:GetTextSizeY() + 10
    self._listCrystalGroupName[self._usingCrystalGroupNumberUICount]:SetShow(true)
    self._usingCrystalGroupNumberUICount = self._usingCrystalGroupNumberUICount + 1
  end
  self._listCrystal[self._usingCrystalUICount].stc_CrystalBG:SetPosY(self._posY)
  self._posY = self._posY + self._listCrystal[self._usingCrystalUICount].txt_CrystalName:GetTextSizeY()
  self._listCrystal[self._usingCrystalUICount].stc_CrystalBG:SetShow(true)
end
function PaGlobal_JewelTooltip:detail()
  if self._buffCount <= 0 then
    self._ui.txt_Desc:SetText("")
    self._ui.stc_DetailBG:SetShow(false)
    return
  end
  self._ui.stc_DetailBG:SetShow(true)
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
    if nil == self._effectDesc[index] then
      self._effectDesc[index] = UI.createAndCopyBasePropertyControl(self._ui.stc_DetailBG, "StaticText_NameTemp", self._ui.stc_DetailBG, "StaticText_EffectDesc_" .. index)
      self._effectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
    end
  end
  if 0 < self._beforeCount then
    for index = 0, self._beforeCount - 1 do
      self._effectDesc[index]:SetShow(false)
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
    self._effectDesc[index]:SetText(self._totalDesc[temp[index]])
    if index == 0 then
      self._effectDesc[index]:SetPosY(self._ui.txt_Desc:GetPosY())
    else
      local addGap = 0
      if 0 == index % 3 then
        addGap = 10
      end
      self._effectDesc[index]:SetPosY(self._effectDesc[index - 1]:GetPosY() + math.max(20, self._effectDesc[index - 1]:GetTextSizeY()) + addGap)
    end
    self._effectDesc[index]:SetShow(true)
  end
  self._beforeCount = buffCategoryCount
  self._ui.stc_DetailBG:SetSize(self._ui.stc_DetailBG:GetSizeX(), self._effectDesc[buffCategoryCount - 1]:GetPosY() + math.max(20, self._effectDesc[buffCategoryCount - 1]:GetTextSizeY()) + 10)
end
function PaGlobal_JewelTooltip:createNewSlotUI()
  if self._usingCrystalUICount + 1 > self._listCrystalSize then
    self._listCrystal[self._usingCrystalUICount] = self:getNewCrystalCopy(self._usingCrystalUICount)
    self._listCrystalSize = self._listCrystalSize + 1
  end
end
function PaGlobal_JewelTooltip:getNewCrystalCopy(idx)
  local _crystalCopy = {
    stc_CrystalBG,
    stc_CrystalIcon,
    txt_CrystalName,
    txt_CrystalDesc
  }
  _crystalCopy.stc_CrystalBG = UI.createAndCopyBasePropertyControl(Panel_Window_JewelPreset_Tooltip_All, "Static_CrystalBG", Panel_Window_JewelPreset_Tooltip_All, "Static_CrystalBG_No" .. idx)
  _crystalCopy.stc_CrystalIcon = UI.createAndCopyBasePropertyControl(self._ui.stc_CrystalBg, "Static_CrystalIcon", _crystalCopy.stc_CrystalBG, "Static_CrystalIcon_No" .. idx)
  _crystalCopy.txt_CrystalName = UI.createAndCopyBasePropertyControl(self._ui.stc_CrystalBg, "StaticText_CrystalName", _crystalCopy.stc_CrystalBG, "StaticText_CrystalName_No" .. idx)
  _crystalCopy.txt_CrystalDesc = UI.createAndCopyBasePropertyControl(self._ui.stc_CrystalBg, "StaticText_CrystalDesc", _crystalCopy.stc_CrystalBG, "StaticText_CrystalDesc_No" .. idx)
  _crystalCopy.txt_CrystalDesc:SetText("")
  _crystalCopy.txt_CrystalDesc:SetTextMode(__eTextMode_AutoWrap)
  _crystalCopy.txt_CrystalName:SetTextMode(__eTextMode_AutoWrap)
  return _crystalCopy
end
function PaGlobal_JewelTooltip:createNewGroupNameSlotUI(groupNumber)
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
function PaGlobal_JewelTooltip:getNewCrystalGroupNameCopy(idx)
  local _crystalGroupNameCopy = UI.createAndCopyBasePropertyControl(Panel_Window_JewelPreset_Tooltip_All, "StaticText_JewelGroupName", Panel_Window_JewelPreset_Tooltip_All, "StaticText_JewelGroupName_No" .. idx)
  return _crystalGroupNameCopy
end
function PaGlobal_JewelTooltip:validate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_NoCrystal:isValidate()
  self._ui.txt_LeftButtonDesc:isValidate()
  self._ui.stc_CrystalGroupName:isValidate()
  self._ui.stc_CrystalBg:isValidate()
  self._ui.txt_CrystalDesc:isValidate()
  self._ui.txt_CrystalName:isValidate()
  self._ui.stc_CrystalIcon:isValidate()
end
