function PaGlobal_MonsterBuffZoneItemRepair:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBG = UI.getChildControl(Panel_Window_MonsterBuffZoneItemRepair, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(titleBG, "Button_Win_Close")
  self._ui._stc_centerBG = UI.getChildControl(Panel_Window_MonsterBuffZoneItemRepair, "Static_ContentBG")
  self._ui._stc_effectBG = UI.getChildControl(self._ui._stc_centerBG, "Static_Bg")
  self._ui._stc_monsterBuffZoneItemSlotBG = UI.getChildControl(self._ui._stc_centerBG, "Static_DekiaItemBg")
  self._ui._stc_materialItemSlotBG = UI.getChildControl(self._ui._stc_centerBG, "Static_MaterialItemBg")
  local gaugeBG = UI.getChildControl(self._ui._stc_centerBG, "Static_GaugeBG_1")
  self._ui._prg_endurancePreview = UI.getChildControl(gaugeBG, "Progress2_Endurance_Gauge_1_PreView")
  self._ui._prg_enduranceCurrent = UI.getChildControl(gaugeBG, "Progress2_Endurance_Gauge_1")
  self._ui._txt_enduranceCurrent = UI.getChildControl(gaugeBG, "StaticText_Endurance")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_MonsterBuffZoneItemRepair, "StaticText_ConsoleGuide")
  self._ui._btn_skipAnimation = UI.getChildControl(Panel_Window_MonsterBuffZoneItemRepair, "CheckButton_SkipAni")
  self._ui._btn_repair = UI.getChildControl(Panel_Window_MonsterBuffZoneItemRepair, "Button_Repair")
  self._ui._stc_descBG = UI.getChildControl(Panel_Window_MonsterBuffZoneItemRepair, "Static_DescBg")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_Desc")
  self._ui._prg_endurancePreview:SetAniSpeed(0.2)
  self._ui._prg_enduranceCurrent:SetAniSpeed(0.5)
  local monsterBuffZoneItemSlot = {}
  SlotItem.new(monsterBuffZoneItemSlot, "Repair_Item_Slot_", 0, self._ui._stc_monsterBuffZoneItemSlotBG, self._slotConfig)
  monsterBuffZoneItemSlot:createChild()
  monsterBuffZoneItemSlot:clearItem()
  monsterBuffZoneItemSlot.icon:SetPosX(0)
  monsterBuffZoneItemSlot.icon:SetPosY(0)
  monsterBuffZoneItemSlot.border:SetSize(44, 44)
  self._monsterBuffZoneItemSlot = monsterBuffZoneItemSlot
  self._monsterBuffZoneItemSlot.icon:SetShow(false)
  local materialItemSlot = {}
  SlotItem.new(materialItemSlot, "Material_Item_Slot_", 0, self._ui._stc_materialItemSlotBG, self._slotConfig)
  materialItemSlot:createChild()
  materialItemSlot:clearItem()
  materialItemSlot.icon:SetPosX(0)
  materialItemSlot.icon:SetPosY(0)
  materialItemSlot.border:SetSize(44, 44)
  self._materialItemSlot = materialItemSlot
  self._materialItemSlot.icon:SetShow(false)
  self._ui._btn_close:SetShow(not self._isConsole)
  self._ui._stc_keyGuideBG:SetShow(self._isConsole)
  if self._isConsole == true then
    local stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Confirm")
    local stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Close")
    local keyGuideList = Array.new()
    keyGuideList:push_back(stc_keyGuide_A)
    keyGuideList:push_back(stc_keyGuide_B)
    for key, control in pairs(keyGuideList) do
      if control ~= nil then
        control:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
  end
  local originalDescBGSizeY = self._ui._stc_descBG:GetSizeY()
  local getDescTextSizeY = self._ui._txt_desc:GetTextSizeY()
  self._ui._stc_descBG:SetSize(self._ui._stc_descBG:GetSizeX(), getDescTextSizeY + 20)
  local newDescBGSizeY = self._ui._stc_descBG:GetSizeY()
  local diffY = newDescBGSizeY - originalDescBGSizeY
  Panel_Window_MonsterBuffZoneItemRepair:SetSize(Panel_Window_MonsterBuffZoneItemRepair:GetSizeX(), Panel_Window_MonsterBuffZoneItemRepair:GetSizeY() + diffY)
  Panel_Window_MonsterBuffZoneItemRepair:ComputePosAllChild()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_MonsterBuffZoneItemRepair:registEventHandler()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._monsterBuffZoneItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MonsterBuffZone_ShowMonsterBuffZoneItemTooltip(true)")
  self._monsterBuffZoneItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MonsterBuffZone_ShowMonsterBuffZoneItemTooltip(false)")
  self._monsterBuffZoneItemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_MonsterBuffZone_ClearMonsterBuffZoneItemSlot()")
  self._materialItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_MonsterBuffZone_ShowMaterialItemTooltip(true)")
  self._materialItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_MonsterBuffZone_ShowMaterialItemTooltip(false)")
  self._materialItemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_MonsterBuffZone_ClearMaterialItemSlot()")
  self._ui._btn_repair:addInputEvent("Mouse_LUp", "HandleEventLUp_MonsterBuffZoneRapair_RequestRepair()")
  if self._isConsole == false then
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MonsterBuffZoneItemRepair_Close()")
  end
  registerEvent("FromClient_RepairMonsterBuffZoneItem", "FromClient_MonsterBuffZoneItemRepair_Result")
end
function PaGlobal_MonsterBuffZoneItemRepair:prepareOpen()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self:clearData()
  self:openUiSetting()
  self:open()
end
function PaGlobal_MonsterBuffZoneItemRepair:openUiSetting()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self._isConsole == true then
    if Panel_Window_Inventory ~= nil then
      local inventoryPanelPosX = Panel_Window_Inventory:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory:GetPosY()
      Panel_Window_MonsterBuffZoneItemRepair:SetPosX(inventoryPanelPosX - Panel_Window_MonsterBuffZoneItemRepair:GetSizeX() - 5)
      Panel_Window_MonsterBuffZoneItemRepair:SetPosY(inventoryPanelPosY)
    end
  elseif Panel_Window_Inventory_All ~= nil and false == Panel_Window_Inventory_All:IsUISubApp() then
    local inventoryPanelPosX = Panel_Window_Inventory_All:GetPosX()
    local inventoryPanelPosY = Panel_Window_Inventory_All:GetPosY()
    local posX = inventoryPanelPosX - Panel_Window_MonsterBuffZoneItemRepair:GetSizeX() - 5
    if posX < 0 then
      posX = inventoryPanelPosX + Panel_Window_Inventory_All:GetSizeX() + 5
    end
    Panel_Window_MonsterBuffZoneItemRepair:SetPosX(posX)
    Panel_Window_MonsterBuffZoneItemRepair:SetPosY(inventoryPanelPosY)
  end
  InventoryWindow_Show()
  Inventory_SetFunctor(PaGlobalFunc_MonsterBuffZoneItemRepair_Filter, PaGlobalFunc_MonsterBuffZoneItemRepair_RClickFunction, nil, nil)
  if _ContentsGroup_NewUI_Inventory_All == true and PaGlobalFunc_Inventory_All_SelectNormalInventory ~= nil then
    PaGlobalFunc_Inventory_All_SelectNormalInventory()
  end
end
function PaGlobal_MonsterBuffZoneItemRepair:open()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  Panel_Window_MonsterBuffZoneItemRepair:SetShow(true)
end
function PaGlobal_MonsterBuffZoneItemRepair:prepareClose()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self:clearData()
  self:closeUiSetting()
  self:close()
end
function PaGlobal_MonsterBuffZoneItemRepair:clearData()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._ui._stc_effectBG:EraseAllEffect()
  self:stopAnimationSound()
  if self._isPlayingAnimation == true then
    self:cancelRepair()
  end
  self._isPlayingAnimation = false
  self._animationAccTime = 0
  self:unlockUI()
  self:clearMonsterBuffZoneItem()
  self:clearMaterialItem()
  self:changeButton_DoRepair()
end
function PaGlobal_MonsterBuffZoneItemRepair:closeUiSetting()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self._isConsole == true then
  elseif _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_ShowEquipUI()
  else
    Inventory_ShowEquipUI()
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
end
function PaGlobal_MonsterBuffZoneItemRepair:close()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  Panel_Window_MonsterBuffZoneItemRepair:SetShow(false)
end
function PaGlobal_MonsterBuffZoneItemRepair:validate()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._ui._stc_centerBG:isValidate()
  self._ui._stc_effectBG:isValidate()
  self._ui._stc_monsterBuffZoneItemSlotBG:isValidate()
  self._ui._stc_materialItemSlotBG:isValidate()
  self._ui._prg_endurancePreview:isValidate()
  self._ui._prg_enduranceCurrent:isValidate()
  self._ui._txt_enduranceCurrent:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._btn_skipAnimation:isValidate()
  self._ui._btn_repair:isValidate()
  self._ui._stc_descBG:isValidate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_MonsterBuffZoneItemRepair:doRepair()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self:checkSelectItem() == false then
    return
  end
  if self._ui._btn_skipAnimation:IsCheck() == true then
    self:doRepairXXX()
  else
    self:doRepairAnimation()
  end
end
function PaGlobal_MonsterBuffZoneItemRepair:doRepairAnimation()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self:checkSelectItem() == false then
    return
  end
  self:lockUI()
  self:changeButton_CancelRepair()
  self:playAnimationSound()
  self._ui._stc_effectBG:EraseAllEffect()
  self._ui._stc_effectBG:AddEffect("fUI_DekiaLanterns_Charge_01A", false, 0, 0)
  self._isPlayingAnimation = true
  self._animationAccTime = 0
  Panel_Window_MonsterBuffZoneItemRepair:RegisterUpdateFunc("PaGlobalFunc_MonsterBuffZoneItemRepair_Update")
end
function PaGlobal_MonsterBuffZoneItemRepair:cancelRepair()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self:unlockUI()
  self:changeButton_DoRepair()
  self._animationSoundID = nil
  self._animationSoundID_Console = nil
  self._isPlayingAnimation = false
  self._animationAccTime = 0
  Panel_Window_MonsterBuffZoneItemRepair:ClearUpdateLuaFunc()
end
function PaGlobal_MonsterBuffZoneItemRepair:doRepairXXX()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self:checkSelectItem() == false then
    return
  end
  local targetItemSlotNo = self._selectItemInfo_Dekia._slotNo
  local targetItemKey = self._selectItemInfo_Dekia._itemKey
  local targetItemWhereType = self._selectItemInfo_Dekia._inventoryType
  local materialItemSlotNo = self._selectItemInfo_Material._slotNo
  local materialItemKey = self._selectItemInfo_Material._itemKey
  local materialItemWhereType = self._selectItemInfo_Material._inventoryType
  local materialItemCount = self._selectItemInfo_Material._count
  ToClient_RequestRepairMonsterBuffZoneItem(targetItemSlotNo, targetItemKey, targetItemWhereType, materialItemSlotNo, materialItemKey, materialItemWhereType, materialItemCount)
end
function PaGlobal_MonsterBuffZoneItemRepair:update(deltaTime)
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._animationAccTime = self._animationAccTime + deltaTime
  if self._animationMaxTime < self._animationAccTime and self._isPlayingAnimation == true then
    self:doRepairXXX()
    self:cancelRepair()
  end
end
function PaGlobal_MonsterBuffZoneItemRepair:checkSelectItem()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return false
  end
  if self._selectItemInfo_Dekia == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotExistSelectedMonsterBuffZoneItem"))
    return false
  end
  if self._selectItemInfo_Material == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotExistSelectedMonsterBuffZoneMaterialItem"))
    return false
  elseif self._selectItemInfo_Material._count < 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoIsNotExistSelectedMonsterBuffZoneMaterialItem"))
    return false
  end
  return true
end
function PaGlobal_MonsterBuffZoneItemRepair:changeButton_DoRepair()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._ui._btn_repair:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE"))
end
function PaGlobal_MonsterBuffZoneItemRepair:changeButton_CancelRepair()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._ui._btn_repair:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_CANCLE"))
end
function PaGlobal_MonsterBuffZoneItemRepair:lockUI()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._monsterBuffZoneItemSlot.icon:SetIgnore(true)
  self._materialItemSlot.icon:SetIgnore(true)
end
function PaGlobal_MonsterBuffZoneItemRepair:unlockUI()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._monsterBuffZoneItemSlot.icon:SetIgnore(false)
  self._materialItemSlot.icon:SetIgnore(false)
end
function PaGlobal_MonsterBuffZoneItemRepair:fillMonsterBuffZoneItem(slotNo, itemKey, inventoryType)
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self:clearMonsterBuffZoneItem()
  local cacheData = {
    _slotNo = slotNo,
    _itemKey = itemKey,
    _inventoryType = inventoryType
  }
  local itemWrapper = getInventoryItem(cacheData._slotNo)
  if itemWrapper ~= nil then
    self._monsterBuffZoneItemSlot.icon:SetShow(true)
    self._monsterBuffZoneItemSlot:setItem(itemWrapper)
    self._selectItemInfo_Dekia = cacheData
  end
  self:updateGauge()
  self:autoFillMaterialItem()
end
function PaGlobal_MonsterBuffZoneItemRepair:clearMonsterBuffZoneItem()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._selectItemInfo_Dekia = nil
  self._monsterBuffZoneItemSlot.icon:SetShow(false)
  self._monsterBuffZoneItemSlot:clearItem()
  Panel_Tooltip_Item_hideTooltip()
  self:updateGauge()
end
function PaGlobal_MonsterBuffZoneItemRepair:fillMaterialItem(slotNo, itemKey, count, inventoryType)
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self:clearMaterialItem()
  local materialItemSSW = ToClient_GetMonsterBuffZoneMaterialItemSSW()
  if materialItemSSW == nil then
    return
  end
  local cacheData = {
    _slotNo = slotNo,
    _itemKey = itemKey,
    _inventoryType = inventoryType,
    _count = count
  }
  self._materialItemSlot.icon:SetShow(true)
  self._materialItemSlot:setItemByStaticStatus(materialItemSSW, toInt64(0, cacheData._count))
  self._selectItemInfo_Material = cacheData
  self:updateGauge()
end
function PaGlobal_MonsterBuffZoneItemRepair:clearMaterialItem()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._selectItemInfo_Material = nil
  self._materialItemSlot.icon:SetShow(false)
  self._materialItemSlot:clearItem()
  Panel_Tooltip_Item_hideTooltip()
  self:updateGauge()
end
function PaGlobal_MonsterBuffZoneItemRepair:playAnimationSound()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self._animationSoundID = audioPostEvent_SystemUi(5, 97)
  self._animationSoundID_Console = _AudioPostEvent_SystemUiForXBOX(5, 97)
end
function PaGlobal_MonsterBuffZoneItemRepair:stopAnimationSound()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self._animationSoundID ~= nil then
    audioPostEvent_StopAudioByPlayingID(self._animationSoundID, 0)
    self._animationSoundID = nil
  end
  if self._animationSoundID_Console ~= nil then
    audioPostEvent_StopAudioByPlayingID(self._animationSoundID_Console, 0)
    self._animationSoundID_Console = nil
  end
end
function PaGlobal_MonsterBuffZoneItemRepair:playSuccessRepairSound()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  self:stopAnimationSound()
  audioPostEvent_SystemUi(5, 98)
  _AudioPostEvent_SystemUiForXBOX(5, 98)
end
function PaGlobal_MonsterBuffZoneItemRepair:updateGauge()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  local dekiaItemWrapper
  if self._selectItemInfo_Dekia ~= nil then
    dekiaItemWrapper = getInventoryItemByType(self._selectItemInfo_Dekia._inventoryType, self._selectItemInfo_Dekia._slotNo)
  end
  if dekiaItemWrapper == nil then
    self._ui._prg_endurancePreview:SetProgressRate(0)
    self._ui._prg_enduranceCurrent:SetProgressRate(0)
    self._ui._txt_enduranceCurrent:SetText("")
  else
    local currentEndurance = dekiaItemWrapper:getEndurance()
    local maxEndurance = dekiaItemWrapper:getMaxEndurance()
    self._ui._prg_enduranceCurrent:SetProgressRate(currentEndurance / maxEndurance * 100)
    self._ui._txt_enduranceCurrent:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_TOOLBOX_ENDURANCE", "endurance", currentEndurance, "max", maxEndurance))
    local selectedMaterialCount = 0
    if self._selectItemInfo_Material ~= nil then
      selectedMaterialCount = self._selectItemInfo_Material._count
    end
    if selectedMaterialCount == 0 then
      self._ui._prg_endurancePreview:SetProgressRate(0)
    else
      local amplifierRecoveryValue = ToClient_GetMonsterBuffZoneAmplifierRecoveryValue()
      local previewEndurance = (currentEndurance + selectedMaterialCount * amplifierRecoveryValue) / maxEndurance
      local isFull = false
      if previewEndurance > 1 then
        isFull = true
      end
      if isFull == true then
        self._ui._prg_endurancePreview:SetProgressRate(100)
      else
        self._ui._prg_endurancePreview:SetProgressRate(previewEndurance * 100)
      end
    end
  end
end
function PaGlobal_MonsterBuffZoneItemRepair:autoFillMaterialItem()
  if Panel_Window_MonsterBuffZoneItemRepair == nil then
    return
  end
  if self._selectItemInfo_Dekia == nil then
    return
  end
  self:clearMaterialItem()
  local materialItemSSW = ToClient_GetMonsterBuffZoneMaterialItemSSW()
  if materialItemSSW == nil then
    return
  end
  local dekiaItemWrapper = getInventoryItemByType(self._selectItemInfo_Dekia._inventoryType, self._selectItemInfo_Dekia._slotNo)
  if dekiaItemWrapper == nil then
    return
  end
  local currentEndurance = dekiaItemWrapper:getEndurance()
  local maxEndurance = dekiaItemWrapper:getMaxEndurance()
  if currentEndurance == maxEndurance then
    return
  end
  local repairableValue = maxEndurance - currentEndurance
  if repairableValue <= 0 then
    return
  end
  local amplifierRecoveryValue = ToClient_GetMonsterBuffZoneAmplifierRecoveryValue()
  local needMaterialItemCount = math.ceil(repairableValue / amplifierRecoveryValue)
  local haveMaterialItemCount = Int64toInt32(ToClient_InventoryGetItemCount(materialItemSSW:get()._key))
  if haveMaterialItemCount == 0 then
    return
  end
  local materialItemSlotNo = ToClient_InventoryGetSlotNo(materialItemSSW:get()._key)
  local fillableCount = 0
  if needMaterialItemCount == haveMaterialItemCount then
    fillableCount = haveMaterialItemCount
  elseif needMaterialItemCount < haveMaterialItemCount then
    fillableCount = needMaterialItemCount
  elseif needMaterialItemCount > haveMaterialItemCount then
    fillableCount = haveMaterialItemCount
  end
  self:fillMaterialItem(materialItemSlotNo, materialItemSSW:get()._key:getItemKey(), fillableCount, CppEnums.ItemWhereType.eInventory)
end
