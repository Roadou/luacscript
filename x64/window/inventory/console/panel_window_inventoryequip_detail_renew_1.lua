function PaGlobal_InventoryEquip_Detail_Renew:initialize()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  if true == self._initialize then
    return
  end
  self._ui.frame_information = UI.getChildControl(Panel_Window_Inventory_Detail, "Frame_Infomation")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_information, "Frame_1_Content")
  self._ui.frame_vScroll = UI.getChildControl(self._ui.frame_information, "Frame_1_VerticalScroll")
  self._ui.chk_crystal = UI.getChildControl(self._ui.frame_content, "CheckButton_Crystal")
  self._ui.chk_equipset = UI.getChildControl(self._ui.frame_content, "CheckButton_EquipSet")
  self._ui.chk_artifact = UI.getChildControl(self._ui.frame_content, "CheckButton_ArtifactsOptions")
  self._ui.stc_crystal_template = UI.getChildControl(self._ui.frame_content, "Static_CrystalBg_Template")
  self._ui.stc_equipset_template = UI.getChildControl(self._ui.frame_content, "Static_EquipmentSetBg_Template")
  self._ui.stc_artifactBg = UI.getChildControl(self._ui.frame_content, "Static_ArtifactsBg")
  self._ui.txt_setOptionTitle = UI.getChildControl(self._ui.stc_artifactBg, "StaticText_Set_Effect_Title")
  self._ui.txt_setOption = UI.getChildControl(self._ui.stc_artifactBg, "StaticText_SetOption")
  self._ui.txt_noLightStone = UI.getChildControl(self._ui.stc_artifactBg, "StaticText_NoLightStone")
  self._ui.stc_crystal_template:SetShow(false)
  self._ui.stc_equipset_template:SetShow(false)
  self._originPanelSizeY = Panel_Window_Inventory_Detail:GetSizeY()
  for ii = 1, 2 do
    local equip = {}
    equip.txt_equipName = UI.getChildControl(self._ui.stc_artifactBg, "StaticText_EquipmentName_" .. ii)
    equip.stc_mainBg = UI.getChildControl(self._ui.stc_artifactBg, "Static_Main_Bg_" .. ii)
    equip.stc_line = UI.getChildControl(equip.stc_mainBg, "Static_Stones")
    equip.stc_lightStone = {}
    for jj = 1, 2 do
      local lightStone = {}
      local stc = UI.getChildControl(equip.stc_mainBg, "Static_LightStone_Option_" .. jj)
      lightStone.stc_lightStoneIcon = UI.getChildControl(stc, "Static_LightStone_Icon")
      lightStone.txt_lightStoneName = UI.getChildControl(stc, "StaticText_LightStone_Name")
      lightStone.txt_lightStoneDesc = UI.getChildControl(stc, "StaticText_LightStone_Desc")
      lightStone.txt_lightStoneName:SetTextMode(__eTextMode_Limit_AutoWrap)
      lightStone.txt_lightStoneDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
      lightStone.stc_off = UI.getChildControl(equip.stc_mainBg, "Static_Stone_Off_" .. jj)
      lightStone.stc_on = UI.getChildControl(equip.stc_mainBg, "Static_On_" .. jj)
      equip.stc_lightStone[jj] = lightStone
    end
    self._artifactListEquip[ii] = equip
  end
  self._ui.txt_setOption:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_setOptionTitle:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._classType = getSelfPlayer():getClassType()
  self._txt_emptySlot = " <PAColor0xffc4bebe>(" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT") .. ")<PAOldColor>"
  self:createControls()
  self:registEventHandler()
  self:validate()
  self:createJeweltemplate()
  self._initialize = true
end
function PaGlobal_InventoryEquip_Detail_Renew:registEventHandler()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  Panel_Window_Inventory_Detail:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_InventoryEquip_Detail_Renew_Close()")
  self._ui.chk_crystal:addInputEvent("Mouse_LUp", "HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()")
  self._ui.chk_equipset:addInputEvent("Mouse_LUp", "HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()")
  self._ui.chk_artifact:addInputEvent("Mouse_LUp", "HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()")
  registerEvent("EventEquipmentUpdate", "FromClient_InventoryEquip_Detail_Renew_EquipmentChanged")
  registerEvent("EventServantEquipmentUpdate", "FromClient_InventoryEquip_Detail_Renew_EquipmentChanged")
end
function PaGlobal_InventoryEquip_Detail_Renew:createJeweltemplate()
  for idx = 0, 20 do
    self:createJewelGroupSlot()
    local data = self._listJewelGroup[self._usingJewelGroupUICount]
    for index = 0, 20 do
      if data.jewelList[index] == nil then
        local templateJewelBG = UI.getChildControl(data.jewelBG, "Static_SocketBG")
        local jewelInfo = {
          slotBG = nil,
          iconBG = nil,
          icon = {},
          jewelName = nil
        }
        jewelInfo.slotBG = UI.cloneControl(templateJewelBG, data.jewelBG, "Static_JewelBG_" .. index)
        jewelInfo.iconBG = UI.getChildControl(jewelInfo.slotBG, "Static_SlotBg_Template")
        jewelInfo.icon = SlotItem.new(jewelInfo.icon, "jewel_iconBG", nil, jewelInfo.iconBG, self.slotConfig_Crystal)
        jewelInfo.icon:createChild()
        jewelInfo.icon:clearItem()
        jewelInfo.icon.icon:SetSize(jewelInfo.iconBG:GetSizeX(), jewelInfo.iconBG:GetSizeY())
        jewelInfo.jewelName = UI.getChildControl(jewelInfo.slotBG, "StaticText_EffectDesc")
        jewelInfo.jewelName:SetTextMode(__eTextMode_AutoWrap)
        jewelInfo.slotBG:SetIgnore(true)
        jewelInfo.slotBG:SetPosY(jewelInfo.slotBG:GetPosY() + (jewelInfo.slotBG:GetSizeY() + 5) * index)
        data.jewelList[index] = jewelInfo
      end
    end
    self._usingJewelGroupUICount = self._usingJewelGroupUICount + 1
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(isSimpleInventory, isJewelPreset)
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self._isSimpleInventory = isSimpleInventory
  if true == isSimpleInventory then
    if nil == Panel_Window_SimpleInventory then
      return
    end
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_SimpleInventory:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_SimpleInventory:GetPosY())
    Panel_Window_Inventory_Detail:ignorePadSnapMoveToOtherPanelUpdate(true)
  elseif isJewelPreset == true then
    if Panel_Window_JewelPreset_All == nil then
      return
    end
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_JewelPreset_All:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_JewelPreset_All:GetPosY())
    Panel_Window_Inventory_Detail:ignorePadSnapMoveToOtherPanelUpdate(false)
  else
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_Inventory:GetPosY())
    Panel_Window_Inventory_Detail:ignorePadSnapMoveToOtherPanelUpdate(false)
  end
  if self._isSimpleInventory == true then
    self._ui.chk_equipset:SetShow(false)
    self._ui.chk_equipset:SetCheck(false)
    self._ui.chk_artifact:SetShow(false)
    self._ui.chk_artifact:SetCheck(false)
  else
    self._ui.chk_equipset:SetShow(true)
    self._ui.chk_artifact:SetShow(true)
  end
  self:setPanelSize()
  self._ui.chk_crystal:SetCheck(true)
  self:update(self._ui.chk_crystal:IsCheck())
  self:open()
end
function PaGlobal_InventoryEquip_Detail_Renew:open()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  Panel_Window_Inventory_Detail:SetShow(true)
end
function PaGlobal_InventoryEquip_Detail_Renew:prepareClose()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self:close()
end
function PaGlobal_InventoryEquip_Detail_Renew:close()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  Panel_Window_Inventory_Detail:SetShow(false)
end
function PaGlobal_InventoryEquip_Detail_Renew:validate()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  self._ui.frame_information:isValidate()
  self._ui.frame_content:isValidate()
  self._ui.chk_crystal:isValidate()
  self._ui.stc_crystal_template:isValidate()
  self._ui.chk_equipset:isValidate()
  self._ui.stc_equipset_template:isValidate()
  self._ui.chk_artifact:isValidate()
  self._ui.stc_artifactBg:isValidate()
end
function PaGlobal_InventoryEquip_Detail_Renew:setPanelSize()
  local titleAreaSizeY = 50
  if true == self._isSimpleInventory then
    if nil == Panel_Window_SimpleInventory then
      return
    end
    local simpleInventorySizeY = Panel_Window_SimpleInventory:GetSizeY()
    Panel_Window_Inventory_Detail:SetSize(Panel_Window_Inventory_Detail:GetSizeX(), simpleInventorySizeY)
    self._ui.frame_information:SetSize(self._ui.frame_information:GetSizeX(), simpleInventorySizeY - titleAreaSizeY)
  else
    Panel_Window_Inventory_Detail:SetSize(Panel_Window_Inventory_Detail:GetSizeX(), self._originPanelSizeY)
    self._ui.frame_information:SetSize(self._ui.frame_information:GetSizeX(), self._originPanelSizeY - titleAreaSizeY)
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:update()
  local padding = 10
  self._ui.frame_content:SetPosY(0)
  local currentPresetNo = 0
  if self._isSimpleInventory == true then
    local characterNo = PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
    if nil == characterNo then
      return
    end
    currentPresetNo = ToClient_GetJewelPresetNoByCharacterNo(characterNo)
  else
    currentPresetNo = ToClient_GetCurrentJewelPresetNo()
  end
  for idx, jewelData in pairs(self._listJewelGroup) do
    jewelData.jewelBG:SetShow(false)
    jewelData.jewelGroupName:SetShow(false)
    for idx2, value in pairs(jewelData.jewelList) do
      value.slotBG:SetShow(false)
      value.iconBG:SetShow(true)
      value.jewelName:SetShow(true)
    end
  end
  local posY = self._ui.frame_content:GetPosY() + self._ui.chk_crystal:GetSizeY() + padding
  if currentPresetNo ~= __eJewelNotActivatingPresetNo and self._ui.chk_crystal:IsCheck() == true then
    local jewelBuffTable = {}
    for idx, value in pairs(self._tooltipOrderTable) do
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(currentPresetNo, value)
      local needToShow = true
      local equipItemWrapper
      local socketCount = 0
      if value == __eJewelSpecialSlotAwakenWeapon1 then
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        if self._isSimpleInventory == false then
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
        local isAlreadyExistJewelGroup = false
        local data
        for idx2, value2 in pairs(jewelBuffTable) do
          if value2 ~= nil and value2.groupNumber == jewelItemSSW:getJewelGroupNumber() then
            isAlreadyExistJewelGroup = true
            data = value2
          end
        end
        if isAlreadyExistJewelGroup == true and data ~= nil then
          table.insert(data.slotNo, value)
        else
          local data = {
            groupNumber = jewelItemSSW:getJewelGroupNumber(),
            slotNo = {}
          }
          table.insert(data.slotNo, value)
          table.insert(jewelBuffTable, data)
        end
      end
    end
    local sortBySlotNo = function(slotNo1, slotNo2)
      return slotNo1 < slotNo2
    end
    local sortByJewelGroup = function(data1, data2)
      return data1.groupNumber < data2.groupNumber
    end
    for idx, value in pairs(jewelBuffTable) do
      table.sort(value.slotNo, sortBySlotNo)
    end
    table.sort(jewelBuffTable, sortByJewelGroup)
    self._usingJewelGroupUICount = 0
    for idx, data in pairs(jewelBuffTable) do
      self:createJewelTooltip(data, currentPresetNo)
      self._usingJewelGroupUICount = self._usingJewelGroupUICount + 1
    end
    for idx = 0, self._usingJewelGroupUICount - 1 do
      local jewelData = self._listJewelGroup[idx]
      jewelData.jewelBG:SetShow(true)
      jewelData.jewelGroupName:SetShow(true)
      jewelData.jewelBG:SetPosY(posY)
      local BGSizeY = jewelData.jewelGroupName:GetTextSizeY()
      for i, k in pairs(jewelData.jewelList) do
        if k.slotBG:GetShow() == true then
          BGSizeY = BGSizeY + k.slotBG:GetSizeY() + 2
        end
      end
      jewelData.jewelBG:SetSize(jewelData.jewelBG:GetSizeX(), BGSizeY + padding)
      posY = posY + BGSizeY + padding
    end
  end
  self._ui.chk_equipset:SetPosY(posY + padding)
  posY = posY + self:updateEquippedSetEffect() + padding * 2 + self._ui.chk_equipset:GetSizeY() - 5
  self._ui.chk_artifact:SetPosY(posY + padding)
  posY = posY + self:updateArtifactOption() + padding * 2
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), posY)
  self._ui.frame_information:UpdateContentScroll()
  self._ui.frame_information:UpdateContentPos()
  self._ui.frame_information:UpdateContentPosWithSnap()
  PaGlobal_MainStatus_AttackStatusUpdate()
  if ToClient_isConsole() == false then
    PaGlobal_SelfPlayerExpGage_AttackInfoUpdate()
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:createJewelTooltip(data, presetNo)
  self:createJewelGroupSlot()
  local jewelCount = #data.slotNo
  for idx = 1, jewelCount do
    local slotNo = data.slotNo[idx]
    local jewelSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(presetNo, slotNo)
    if jewelSSW ~= nil then
      local jewelUIData = self._listJewelGroup[self._usingJewelGroupUICount]
      jewelUIData.jewelGroupName:SetText(jewelSSW:getJewelGroupName())
      self:createJewelSlot(jewelUIData, idx - 1, jewelSSW)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:createJewelGroupSlot()
  if self._usingJewelGroupUICount + 1 > self._listJewelGroupSize then
    self._listJewelGroup[self._usingJewelGroupUICount] = self:getNewJewelGroupCopy(self._usingJewelGroupUICount)
    self._listJewelGroupSize = self._listJewelGroupSize + 1
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:getNewJewelGroupCopy(index)
  local jewel = {
    jewelBG = nil,
    jewelGroupName = nil,
    jewelList = {}
  }
  jewel.jewelBG = UI.cloneControl(self._ui.stc_crystal_template, self._ui.frame_content, "Static_JewelBg_Template_" .. index)
  ToClient_padSnapRefreshTarget(jewel.jewelBG)
  jewel.jewelGroupName = UI.getChildControl(jewel.jewelBG, "StaticText_EquipmentName")
  jewel.jewelGroupName:SetTextMode(__eTextMode_AutoWrap)
  return jewel
end
function PaGlobal_InventoryEquip_Detail_Renew:createJewelSlot(jewelData, index, jewelSSW)
  if jewelData.jewelList[index] == nil then
    local templateJewelBG = UI.getChildControl(jewelData.jewelBG, "Static_SocketBG")
    local jewelInfo = {
      slotBG = nil,
      iconBG = nil,
      icon = {},
      jewelName = nil
    }
    jewelInfo.slotBG = UI.cloneControl(templateJewelBG, jewelData.jewelBG, "Static_JewelBG_" .. index)
    jewelInfo.iconBG = UI.getChildControl(jewelInfo.slotBG, "Static_SlotBg_Template")
    jewelInfo.icon = SlotItem.new(jewelInfo.icon, "jewel_iconBG", nil, jewelInfo.iconBG, self.slotConfig_Crystal)
    jewelInfo.icon:createChild()
    jewelInfo.icon:clearItem()
    jewelInfo.icon.icon:SetSize(jewelInfo.iconBG:GetSizeX(), jewelInfo.iconBG:GetSizeY())
    jewelInfo.jewelName = UI.getChildControl(jewelInfo.slotBG, "StaticText_EffectDesc")
    jewelInfo.jewelName:SetTextMode(__eTextMode_AutoWrap)
    jewelInfo.slotBG:SetIgnore(true)
    jewelInfo.slotBG:SetPosY(jewelInfo.slotBG:GetPosY() + (jewelInfo.slotBG:GetSizeY() + 5) * index)
    jewelData.jewelList[index] = jewelInfo
  end
  jewelData.jewelList[index].icon:setItemByStaticStatus(jewelSSW)
  jewelData.jewelList[index].jewelName:SetText(jewelSSW:getName())
  local nameColorGrade = jewelSSW:getGradeType()
  PaGlobalFunc_ArtifactTooltip_ChangeTextColor(jewelData.jewelList[index].jewelName, nameColorGrade)
  jewelData.jewelList[index].slotBG:SetShow(true)
  jewelData.jewelList[index].iconBG:SetShow(true)
  jewelData.jewelList[index].jewelName:SetShow(true)
  return jewelData.jewelList[index].slotBG:GetSizeY()
end
function PaGlobal_InventoryEquip_Detail_Renew:openUisetting()
  if nil == Panel_Window_Inventory then
    return
  end
  if true == self._isSimpleInventory then
    if nil == Panel_Window_SimpleInventory then
      return
    end
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_SimpleInventory:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_SimpleInventory:GetPosY())
  else
    Panel_Window_Inventory_Detail:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Inventory_Detail:GetSizeX())
    Panel_Window_Inventory_Detail:SetPosY(Panel_Window_Inventory:GetPosY())
  end
  self._ui.chk_crystal:SetCheck(true)
  HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()
  if self._isSimpleInventory == true then
    self._ui.chk_equipset:SetShow(false)
    self._ui.chk_equipset:SetCheck(false)
    self._ui.chk_artifact:SetShow(false)
    self._ui.chk_artifact:SetCheck(false)
  else
    self._ui.chk_equipset:SetShow(true)
    self._ui.chk_artifact:SetShow(true)
  end
  HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedSet()
  self._ui.frame_vScroll:SetControlTop()
  self._ui.frame_information:UpdateContentScroll()
  self._ui.frame_information:UpdateContentPos()
  self._ui.frame_information:UpdateContentPosWithSnap()
end
function PaGlobal_InventoryEquip_Detail_Renew:createControls()
  for index = 1, 20 do
    if nil == self._ui.setEffectGroup[index] then
      self:createSetEffectGroup(index)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:resetEquippedCrystals()
  for index = 1, #self._ui.crystalGroup do
    if nil ~= self._ui.crystalGroup[index] then
      self._ui.crystalGroup[index].crystalBG:SetShow(false)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:resetEquippedSet()
  for index = 1, #self._ui.setEffectGroup do
    if nil ~= self._ui.setEffectGroup[index] then
      self._ui.setEffectGroup[index].setEffectBG:SetShow(false)
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
  self:resetEquippedCrystals()
  local padding = 5
  self._ui.chk_equipset:SetPosY(self._ui.chk_crystal:GetPosY() + self._ui.chk_crystal:GetSizeY() + padding)
  if false == self._ui.chk_crystal:IsCheck() then
    local setEffectSizeY = self:updateEquippedSetEffect()
    setEffectSizeY = setEffectSizeY + (self._ui.chk_equipset:GetSizeY() + padding) * 2
    self:changeVerticalScroll(setEffectSizeY)
    return
  end
  local frameSizeY = 0
  local crystalGroupIndex = 1
  local equipSetPosY = self._ui.chk_equipset:GetPosY()
  local equipWrapper
  if true == self._isSimpleInventory then
    if nil == PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo then
      return
    end
    local characterNo = PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
    if nil == characterNo then
      return
    end
    equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
  end
  for equipNo = __eEquipSlotNoArtifact1, __eEquipSlotNoCount do
    local itemWrapper
    if true == self._isSimpleInventory then
      local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(self._slotEquipNo[equipNo])
      if nil == equipItemWrapper then
        return
      end
      itemWrapper = equipItemWrapper:getItem()
    else
      itemWrapper = ToClient_getEquipmentItem(self._slotEquipNo[equipNo])
    end
    if nil ~= itemWrapper and 0 ~= itemWrapper:get():getUsableItemSocketCount() then
      frameSizeY = frameSizeY + self:changeCrystalGroup(crystalGroupIndex, itemWrapper)
      equipSetPosY = self._ui.crystalGroup[crystalGroupIndex].crystalBG:GetPosY() + self._ui.crystalGroup[crystalGroupIndex].crystalBG:GetSizeY()
      crystalGroupIndex = crystalGroupIndex + 1
    end
  end
  self._ui.chk_equipset:SetPosY(equipSetPosY + padding)
  frameSizeY = frameSizeY + self:updateEquippedSetEffect()
  self:changeVerticalScroll(frameSizeY + (self._ui.chk_equipset:GetSizeY() + padding) * 2)
end
function PaGlobal_InventoryEquip_Detail_Renew:changeVerticalScroll(contentSizeY)
  local padding = 10
  contentSizeY = contentSizeY + padding
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), contentSizeY)
  self._ui.frame_information:UpdateContentScroll()
  self._ui.frame_information:UpdateContentPos()
  self._ui.frame_information:UpdateContentPosWithSnap()
end
function PaGlobal_InventoryEquip_Detail_Renew:updateEquippedSetEffect()
  self:resetEquippedSet()
  if false == self._ui.chk_equipset:IsCheck() then
    return 0
  end
  local setEffectGroupSizeY = 0
  self:updateSetEffectData()
  local dataCount = #self._setEffectData
  for index = 1, dataCount do
    if nil == self._ui.setEffectGroup[index] then
      self:createSetEffectGroup(index)
    end
    setEffectGroupSizeY = setEffectGroupSizeY + self:changeSetEffectGroup(index)
  end
  return setEffectGroupSizeY
end
function PaGlobal_InventoryEquip_Detail_Renew:createCrystalGroup(crystalGroupIndex)
  local padding = 5
  local crystal = {
    crystalBG = nil,
    equipmentName = nil,
    socket = {}
  }
  crystal.crystalBG = UI.cloneControl(self._ui.stc_crystal_template, self._ui.frame_content, "Static_CrystalBg_Template_" .. crystalGroupIndex)
  ToClient_padSnapRefreshTarget(crystal.crystalBG)
  crystal.equipmentName = UI.getChildControl(crystal.crystalBG, "StaticText_EquipmentName")
  crystal.equipmentName:SetTextMode(__eTextMode_AutoWrap)
  local socketBG = UI.getChildControl(crystal.crystalBG, "Static_SocketBG")
  for index = 1, self._maxSocketCount do
    local socketInfo = {
      slotBG = nil,
      iconBG = nil,
      icon = {},
      socketName = nil
    }
    socketInfo.slotBG = UI.cloneControl(socketBG, crystal.crystalBG, "Static_SocketBG_" .. index)
    socketInfo.iconBG = UI.getChildControl(socketInfo.slotBG, "Static_SlotBg_Template")
    socketInfo.icon = SlotItem.new(socketInfo.icon, "socket_iconBG", nil, socketInfo.iconBG, self.slotConfig_Crystal)
    socketInfo.icon:createChild()
    socketInfo.icon:clearItem()
    socketInfo.icon.icon:SetSize(socketInfo.iconBG:GetSizeX(), socketInfo.iconBG:GetSizeY())
    socketInfo.socketName = UI.getChildControl(socketInfo.slotBG, "StaticText_EffectDesc")
    socketInfo.socketName:SetTextMode(__eTextMode_AutoWrap)
    socketInfo.slotBG:SetIgnore(true)
    socketInfo.slotBG:SetPosY(socketInfo.slotBG:GetPosY() + (socketInfo.slotBG:GetSizeY() + padding) * index)
    crystal.socket[index] = socketInfo
  end
  local addSizeY = crystal.socket[1].slotBG:GetSizeY() * (self._maxSocketCount - 1)
  crystal.crystalBG:SetSize(crystal.crystalBG:GetSizeX(), crystal.crystalBG:GetSizeY() + addSizeY)
  self._ui.crystalGroup[crystalGroupIndex] = crystal
end
function PaGlobal_InventoryEquip_Detail_Renew:changeCrystalGroup(crystalGroupIndex, itemWrapper)
  if nil == itemWrapper then
    return 0
  end
  local padding = 5
  local itemSSW = itemWrapper:getStaticStatus()
  local equipmentName = itemSSW:getName()
  self._ui.crystalGroup[crystalGroupIndex].equipmentName:SetText(equipmentName)
  self._ui.crystalGroup[crystalGroupIndex].equipmentName:SetSize(self._ui.crystalGroup[crystalGroupIndex].equipmentName:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].equipmentName:GetTextSizeY())
  self._ui.crystalGroup[crystalGroupIndex].crystalBG:SetShow(true)
  local socketCount = itemWrapper:get():getUsableItemSocketCount()
  for index = 1, #self._ui.crystalGroup[crystalGroupIndex].socket do
    self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetShow(false)
  end
  for index = 1, socketCount do
    self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetShow(true)
    local itemEnchantSSW = itemWrapper:getPushedItem(index - 1)
    if nil ~= itemEnchantSSW then
      local nameColorGrade = itemEnchantSSW:getGradeType()
      PaGlobalFunc_ArtifactTooltip_ChangeTextColor(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName, nameColorGrade)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetText(tostring(itemEnchantSSW:getName()))
      local addBgSizeY = 0
      if self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY() > self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY() then
        addBgSizeY = self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY() - self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY()
      end
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY())
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeY() + addBgSizeY)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetShow(true)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].icon:setItemByStaticStatus(itemEnchantSSW)
    else
      self._ui.crystalGroup[crystalGroupIndex].socket[index].icon:clearItem()
      PaGlobalFunc_ArtifactTooltip_ChangeTextColor(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
      local addBgSizeY = 0
      if self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY() < self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY() then
        addBgSizeY = self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeY() - self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY()
      end
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:GetSizeY() - addBgSizeY)
      self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:SetSize(self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetSizeX(), self._ui.crystalGroup[crystalGroupIndex].socket[index].socketName:GetTextSizeY())
    end
    self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:ComputePos()
    if 1 ~= index then
      self._ui.crystalGroup[crystalGroupIndex].socket[index].slotBG:SetPosY(self._ui.crystalGroup[crystalGroupIndex].socket[index - 1].slotBG:GetSizeY() + self._ui.crystalGroup[crystalGroupIndex].socket[index - 1].slotBG:GetPosY())
    end
  end
  local crystalBGSizeY = self._ui.crystalGroup[crystalGroupIndex].socket[1].slotBG:GetSizeY() + self._ui.crystalGroup[crystalGroupIndex].equipmentName:GetSizeY() + padding
  if false ~= self._ui.crystalGroup[crystalGroupIndex].socket[self._maxSocketCount].slotBG:GetShow() then
    crystalBGSizeY = crystalBGSizeY + (self._ui.crystalGroup[crystalGroupIndex].socket[1].slotBG:GetSizeY() + padding)
  end
  self._ui.crystalGroup[crystalGroupIndex].crystalBG:SetSize(self._ui.crystalGroup[crystalGroupIndex].crystalBG:GetSizeX(), crystalBGSizeY)
  local crystalBGPosY = self._ui.chk_crystal:GetSizeY() + padding * 2
  if 1 ~= crystalGroupIndex then
    crystalBGPosY = self._ui.crystalGroup[crystalGroupIndex - 1].crystalBG:GetPosY() + self._ui.crystalGroup[crystalGroupIndex - 1].crystalBG:GetSizeY() + padding
  end
  self._ui.crystalGroup[crystalGroupIndex].crystalBG:SetPosY(crystalBGPosY)
  return crystalBGSizeY + padding
end
function PaGlobal_InventoryEquip_Detail_Renew:updateSetEffectData()
  local sortedInfoList = ToClient_GetSkillPieceInfo()
  self._setEffectData = {}
  if nil == sortedInfoList then
    return
  end
  local listIndex = 0
  while nil ~= sortedInfoList[listIndex] do
    local groupTitle = sortedInfoList[listIndex]:getGroupTitle()
    local dataIndex = self:getSetEffectData(groupTitle)
    if nil == self._setEffectData[dataIndex] then
      local data = {
        groupTitle = nil,
        desc = {},
        isApplied = {}
      }
      table.insert(self._setEffectData, data)
    end
    local descIndex = #self._setEffectData[dataIndex].desc
    self._setEffectData[dataIndex].groupTitle = groupTitle
    local descText = sortedInfoList[listIndex]:getDescTitle() .. " : " .. sortedInfoList[listIndex]:getDesc()
    table.insert(self._setEffectData[dataIndex].desc, descText)
    table.insert(self._setEffectData[dataIndex].isApplied, sortedInfoList[listIndex]:getApply())
    listIndex = listIndex + 1
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:getSetEffectData(groupTitle)
  for index = 1, #self._setEffectData + 1 do
    if nil ~= self._setEffectData[index] then
      if self._setEffectData[index].groupTitle == groupTitle then
        return index
      end
    else
      return index
    end
  end
end
function PaGlobal_InventoryEquip_Detail_Renew:createSetEffectGroup(setEffectGroupIndex)
  local padding = 5
  local setEffectGroup = {
    setEffectBG = nil,
    equipmentName = nil,
    setEffectDesc = {}
  }
  setEffectGroup.setEffectBG = UI.cloneControl(self._ui.stc_equipset_template, self._ui.frame_content, "Static_EquipmentSetBg_Template_" .. setEffectGroupIndex)
  ToClient_padSnapRefreshTarget(setEffectGroup.setEffectBG)
  setEffectGroup.equipmentName = UI.getChildControl(setEffectGroup.setEffectBG, "StaticText_SetEffectTitle")
  setEffectGroup.equipmentName:SetTextMode(__eTextMode_AutoWrap)
  setEffectGroup.setEffectDesc[1] = UI.getChildControl(setEffectGroup.setEffectBG, "StaticText_SetDesc")
  setEffectGroup.setEffectDesc[1]:SetTextMode(__eTextMode_AutoWrap)
  self._ui.setEffectGroup[setEffectGroupIndex] = setEffectGroup
end
function PaGlobal_InventoryEquip_Detail_Renew:createSetEffectDesc(setEffectGroupIndex, index)
  local padding = 5
  local controlToClone = self._ui.setEffectGroup[setEffectGroupIndex].setEffectDesc[1]
  local parent = self._ui.setEffectGroup[setEffectGroupIndex].setEffectBG
  local cloneControl = UI.cloneControl(controlToClone, parent, "StaticText_SetDesc_" .. index)
  self._ui.setEffectGroup[setEffectGroupIndex].setEffectDesc[index] = cloneControl
  self._ui.setEffectGroup[setEffectGroupIndex].setEffectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
end
function PaGlobal_InventoryEquip_Detail_Renew:changeSetEffectGroup(setEffectGroupIndex)
  local padding = 5
  local addSizeY = 0
  local currentGroupUI = self._ui.setEffectGroup[setEffectGroupIndex]
  currentGroupUI.setEffectBG:SetShow(true)
  currentGroupUI.equipmentName:SetText(self._setEffectData[setEffectGroupIndex].groupTitle)
  currentGroupUI.equipmentName:SetSize(currentGroupUI.equipmentName:GetSizeX(), currentGroupUI.equipmentName:GetTextSizeY())
  local setEffectBGSizeY = 0
  for index = 1, #currentGroupUI.setEffectDesc do
    currentGroupUI.setEffectDesc[index]:SetShow(false)
  end
  for index = 1, #self._setEffectData[setEffectGroupIndex].desc do
    if nil == currentGroupUI.setEffectDesc[index] then
      self:createSetEffectDesc(setEffectGroupIndex, index)
    end
    currentGroupUI.setEffectDesc[index]:SetShow(true)
    if true == self._setEffectData[setEffectGroupIndex].isApplied[index] then
      currentGroupUI.setEffectDesc[index]:SetFontColor(Defines.Color.C_FF96D4FC)
    else
      currentGroupUI.setEffectDesc[index]:SetFontColor(Defines.Color.C_FFDDC39E)
    end
    currentGroupUI.setEffectDesc[index]:SetText(self._setEffectData[setEffectGroupIndex].desc[index])
    currentGroupUI.setEffectDesc[index]:SetSize(currentGroupUI.setEffectDesc[index]:GetSizeX(), currentGroupUI.setEffectDesc[index]:GetTextSizeY())
    local prevControl
    if 1 == index then
      prevControl = currentGroupUI.equipmentName
      setEffectBGSizeY = currentGroupUI.equipmentName:GetSizeY() + padding + currentGroupUI.setEffectDesc[index]:GetSizeY() + padding
    else
      prevControl = currentGroupUI.setEffectDesc[index - 1]
      setEffectBGSizeY = setEffectBGSizeY + currentGroupUI.setEffectDesc[index]:GetSizeY() + padding
    end
    currentGroupUI.setEffectDesc[index]:SetPosY(prevControl:GetPosY() + prevControl:GetSizeY())
  end
  currentGroupUI.setEffectBG:SetSize(currentGroupUI.setEffectBG:GetSizeX(), setEffectBGSizeY)
  local setEffectGroupPosY = self._ui.chk_equipset:GetPosY() + self._ui.chk_equipset:GetSizeY() + padding
  if 1 ~= setEffectGroupIndex and nil ~= self._ui.setEffectGroup[setEffectGroupIndex - 1] then
    setEffectGroupPosY = self._ui.setEffectGroup[setEffectGroupIndex - 1].setEffectBG:GetPosY() + self._ui.setEffectGroup[setEffectGroupIndex - 1].setEffectBG:GetSizeY() + padding
  end
  currentGroupUI.setEffectBG:SetPosY(setEffectGroupPosY)
  return setEffectBGSizeY + padding
end
function PaGlobal_InventoryEquip_Detail_Renew:updateArtifactOption()
  if self._ui.chk_artifact:IsCheck() == true then
    self._ui.stc_artifactBg:SetShow(true)
  else
    self._ui.stc_artifactBg:SetShow(false)
    return 0
  end
  self._ui.stc_artifactBg:SetPosY(self._ui.chk_artifact:GetPosY() + self._ui.chk_artifact:GetSizeY() + 5)
  self._equipmentSize = 0
  self._panelSizeY = 70 + self._ui.txt_noLightStone:GetTextSizeY()
  self._panelSizeY = 70
  local equipWrapper
  for ii = 1, 2 do
    local stc = self._artifactListEquip[ii]
    stc.txt_equipName:SetShow(false)
    stc.stc_mainBg:SetShow(false)
  end
  for equipNo = __eEquipSlotNoArtifact1, __eEquipSlotNoCount - 1 do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    if nil ~= itemWrapper then
      local socketCount = itemWrapper:get():getUsableItemSocketCount()
      if 0 ~= socketCount then
        self._equipmentSize = self._equipmentSize + 1
        local equip = self._artifactListEquip[self._equipmentSize]
        equip.txt_equipName:SetShow(true)
        equip.stc_mainBg:SetShow(true)
        local equipItemEnchantSSW = itemWrapper:getStaticStatus()
        local equipItemGrade = equipItemEnchantSSW:getGradeType()
        PaGlobalFunc_ArtifactTooltip_ChangeTextColor(equip.txt_equipName, equipItemGrade)
        equip.txt_equipName:SetTextMode(__eTextMode_Limit_AutoWrap)
        equip.txt_equipName:SetText(equipItemEnchantSSW:getName())
        for socketNo = 0, socketCount - 1 do
          local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
          if nil ~= itemEnchantSSW then
            local nameColorGrade = itemEnchantSSW:getGradeType()
            PaGlobalFunc_ArtifactTooltip_ChangeTextColor(equip.stc_lightStone[socketNo + 1].txt_lightStoneName, nameColorGrade)
            equip.stc_lightStone[socketNo + 1].txt_lightStoneName:SetText(itemEnchantSSW:getName())
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
            local x1, y1, x2, y2 = setTextureUV_Func(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon, 0, 0, 42, 42)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:setRenderTexture(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture())
            equip.stc_lightStone[socketNo + 1].stc_on:SetShow(true)
            local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
            if nil == skillSSW then
              equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText("")
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
              equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText(buffList)
            end
          else
            equip.stc_lightStone[socketNo + 1].txt_lightStoneName:SetText(self._txt_emptySlot)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_common_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon, 179, 104, 225, 150)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:setRenderTexture(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture())
            equip.stc_lightStone[socketNo + 1].stc_on:SetShow(false)
            equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText("")
          end
        end
      end
    end
  end
  if 0 ~= self._equipmentSize then
    self._ui.txt_noLightStone:SetShow(false)
    self._ui.txt_setOptionTitle:SetShow(true)
    self._ui.txt_setOption:SetShow(true)
    self._ui.txt_setOption:SetText("")
    local setStr = ToClient_getLightStoneSet()
    if nil ~= setStr then
      self._ui.txt_setOption:SetText(setStr)
    else
      self._ui.txt_setOption:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_NOSET"))
    end
    self._panelSizeY = self._panelSizeY + (self._artifactListEquip[1].stc_mainBg:GetSizeY() + self._artifactListEquip[1].txt_equipName:GetTextSizeY() + 5) * self._equipmentSize
    self._panelSizeY = self._panelSizeY + self._ui.txt_setOptionTitle:GetTextSizeY() + self._ui.txt_setOption:GetTextSizeY() + 5
    self._panelSizeY = self._panelSizeY + 70
    local equip = self._artifactListEquip[self._equipmentSize]
    local setOptionTitleY = equip.stc_mainBg:GetPosY() + equip.stc_mainBg:GetSizeY() + 20
    self._ui.txt_setOptionTitle:SetPosY(setOptionTitleY)
    self._ui.txt_setOption:SetPosY(setOptionTitleY + self._ui.txt_setOptionTitle:GetTextSizeY() + 5)
    self._panelSizeY = self._ui.txt_setOption:GetPosY() + self._ui.txt_setOption:GetTextSizeY() + 10
  else
    self._ui.txt_noLightStone:SetShow(true)
    self._ui.txt_setOptionTitle:SetShow(false)
    self._ui.txt_setOption:SetShow(false)
  end
  self._ui.stc_artifactBg:SetSize(self._ui.stc_artifactBg:GetSizeX(), self._panelSizeY)
  self._ui.txt_setOptionTitle:ComputePos()
  self._ui.txt_setOption:ComputePos()
  return self._panelSizeY
end
function PaGlobal_InventoryEquip_Detail_Renew:changeTextColor(control, nameColorGrade)
  if 0 == nameColorGrade then
    control:SetFontColor(Defines.Color.C_FFDDC39E)
  elseif 1 == nameColorGrade then
    control:SetFontColor(4284350320)
  elseif 2 == nameColorGrade then
    control:SetFontColor(4283144191)
  elseif 3 == nameColorGrade then
    control:SetFontColor(4294953010)
  elseif 4 == nameColorGrade then
    control:SetFontColor(4294929408)
  else
    control:SetFontColor(Defines.Color.C_FFDDC39E)
  end
end
