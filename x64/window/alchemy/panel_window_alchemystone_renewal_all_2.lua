function PaGlobalFunc_AlchemyStone_Renewal_All_Open()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if Panel_Window_AlchemyStone_All == nil or Panel_Window_AlchemyStone_All:IsShow() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_Close()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if Panel_Window_AlchemyStone_All == nil or Panel_Window_AlchemyStone_All:IsShow() == false then
    return
  end
  if self._ui._stc_result:GetShow() == true then
    if self._evolveEffectTime > 0 then
      self:clearEffect()
      PaGlobalFunc_AlchemyStoneEvolve_All_Open(nil, nil, nil, nil, true)
      self:clearAudioEffect()
    end
    self:closeEvolveResult()
    return
  end
  PaGlobalFunc_AlchemyStoneEvolve_All_Close()
  self:prepareClose()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_IsShow()
  if Panel_Window_AlchemyStone_All == nil then
    return nil
  end
  return Panel_Window_AlchemyStone_All:GetShow()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_Charge()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  alchemyRepair(self._alchemyStoneWhereType, self._alchemyStoneSlotNo, self._materialWhereType, self._materialSlotNo, self._materialItemCount)
end
function PaGlobalFunc_AlchemyStone_Renewal_All_ChargeCheckAnimation()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if self._alchemyStoneWhereType == nil or self._alchemyStoneSlotNo == nil or self._materialWhereType == nil or self._materialSlotNo == nil or self._materialItemCount == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if itemSSW ~= nil then
    local materialNeedCount = itemSSW:get()._contentsEventParam2 + 1
    if materialNeedCount > Int64toInt32(self._materialItemCount) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInventoryNotEnoughItem"))
      return
    end
  end
  if self._ui._chk_skipAni:IsCheck() == true then
    PaGlobalFunc_AlchemyStone_Renewal_All_Charge()
  else
    self._chargeEffectTime = 2.5
    self._ui._stc_charge:EraseAllEffect()
    self._ui._stc_charge:AddEffect("fUI_AlchemyStone_New_01A", false)
    self._audioId = audioPostEvent_SystemUi(5, 100)
    self._audioIdXbox = _AudioPostEvent_SystemUiForXBOX(5, 100)
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_Upgrade()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  alchemyUpgrade(self._materialWhereType, self._materialSlotNo, self._materialItemCount, self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
end
function PaGlobalFunc_AlchemyStone_Renewal_All_UpgradeCheckAnimation()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if self._alchemyStoneWhereType == nil or self._alchemyStoneSlotNo == nil or self._materialWhereType == nil or self._materialSlotNo == nil or self._materialItemCount == nil then
    return
  end
  if self._ui._chk_skipAni:IsCheck() == true then
    PaGlobalFunc_AlchemyStone_Renewal_All_Upgrade()
  else
    self._upgradeEffectTime = 2.5
    self._ui._stc_upgrade:EraseAllEffect()
    self._ui._stc_upgrade:AddEffect("fUI_AlchemyStone_New_01B", false)
    self._audioId = audioPostEvent_SystemUi(5, 101)
    self._audioIdXbox = _AudioPostEvent_SystemUiForXBOX(5, 101)
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_OpenEvolve()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  PaGlobalFunc_AlchemyStoneEvolve_All_Open(self._alchemyStoneWhereType, self._alchemyStoneSlotNo, self._alchemyStoneItemKey, self._alchemyStoneType, false)
end
function PaGlobalFunc_AlchemyStone_Renewal_All_PreCheckOtherUI()
  if PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  if Panel_AlchemyFigureHead_All ~= nil and Panel_AlchemyFigureHead_All:GetShow() == true then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if ToClient_isConsole() == false and Panel_Window_Manufacture_All ~= nil and Panel_Window_Manufacture_All:GetShow() == true then
    PaGlobalFunc_Manufacture_All_Close()
  end
  if _ContentsGroup_NewUI_Dye_Palette_All then
    if Panel_Window_Dye_Palette_All ~= nil and Panel_Window_Dye_Palette_All:GetShow() == true then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif Panel_DyePalette ~= nil and Panel_DyePalette:GetShow() == true then
    FGlobal_DyePalette_Close()
  end
  if _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow ~= nil and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(tabIndex)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  self._currentTab = tabIndex
  self:clearItemSlot()
  self:clearEffect()
  self:update()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_SetInvenFilterStone(slotNo, itemWrapper, inventoryType)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if itemWrapper == nil or itemWrapper:getStaticStatus() == nil then
    return true
  end
  if itemWrapper:getStaticStatus():get():getContentsEventType() ~= 32 then
    return true
  end
  if self._currentTab == self._eTab._charge then
    if itemWrapper:isChargeableAlchemyStone() == true then
      if itemWrapper:get():getEndurance() == itemWrapper:get():getMaxEndurance() then
        return true
      else
        return false
      end
    else
      return true
    end
  elseif self._currentTab == self._eTab._upgrade then
    local alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
    if alchemyStoneType > 2 then
      return true
    end
    if itemWrapper:getStaticStatus():get()._contentsEventParam2 == 7 then
      return true
    end
    local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
    if isDuplicatedForDuel == true then
      return true
    end
    return false
  end
  return false
end
function PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat(slotNo, itemWrapper, inventoryType)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return true
  end
  if self._alchemyStoneType == nil then
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if staticStatus == nil then
    return true
  end
  local key = itemWrapper:get():getKey()
  if self._currentTab == self._eTab._charge then
    if staticStatus:isAlchemyRepair(self._alchemyStoneType) then
      return false
    end
  elseif self._currentTab == self._eTab._upgrade and staticStatus:isAlchemyUpgradeItem(self._alchemyStoneType) then
    return false
  end
  return true
end
function PaGlobalFunc_AlchemyStone_All_SetInvenFilterNone(slotNo, itemWrapper, inventoryType)
  return true
end
function PaGlobalFunc_AlchemyStone_Renewal_All_InvenStoneRClick(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return
  end
  if self._startEffectPlay == true then
    return
  end
  if self._alchemyStoneWhereType ~= nil then
    return
  end
  self._alchemyStoneWhereType = inventoryType
  self._alchemyStoneSlotNo = slotNo
  self._alchemyStoneItemKey = itemWrapper:get():getKey()
  self._alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
  self:update()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_InvenMatRClick(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return
  end
  if self._startEffectPlay == true then
    return
  end
  if self._alchemyStoneItemKey == nil then
    return
  end
  local materialNeedCount = 0
  local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if itemSSW ~= nil then
    materialNeedCount = itemSSW:get()._contentsEventParam2 + 1
  end
  if self._materialItemCount ~= nil and self._currentTab == self._eTab._charge and materialNeedCount < Int64toInt32(self._materialItemCount) then
    return
  end
  local itemKey = itemWrapper:get():getKey()
  local function setMatFunc(itemCount)
    local self = PaGlobal_AlchemyStone_Renewal_All
    if self == nil then
      return
    end
    self._materialWhereType = inventoryType
    self._materialSlotNo = slotNo
    self._materialItemKey = itemKey
    self._materialItemCount = itemCount
    self:update()
  end
  self:update()
  if count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, count, nil, setMatFunc, false, nil, nil)
  else
    setMatFunc(toInt64(0, 1))
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_InvenNoneRClick(slotNo, itemWrapper, count, inventoryType)
  return false
end
function PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(clearIndex)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  self:clearItemSlot(clearIndex)
  self:update()
end
function FromClient_AlchemyStone_Renewal_All_Charge(whereType, slotNo)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if _ContentsGroup_AlchemyStoneRenewal == false then
    return
  end
  if Panel_Window_AlchemyStone_All == nil or Panel_Window_AlchemyStone_All:GetShow() == false then
    return
  end
  if self._currentTab ~= self._eTab._charge then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, Int64toInt32(slotNo))
  if itemWrapper ~= nil then
    local itemSSW = itemWrapper:getStaticStatus()
    local itemName = itemSSW:getName()
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE_COMPLETE_ACK", "itemName", itemName))
    PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(2)
    self._ui._btn_charge:SetMonoTone(false)
    self._ui._btn_charge:SetIgnore(false)
  end
  self._audioId = nil
  self._audioIdXbox = nil
end
function FromClient_AlchemyStone_Renewal_All_Upgrade(itemwhereType, slotNo, exp)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if _ContentsGroup_AlchemyStoneRenewal == false then
    return
  end
  if Panel_Window_AlchemyStone_All == nil or Panel_Window_AlchemyStone_All:GetShow() == false then
    return
  end
  if self._currentTab ~= self._eTab._upgrade then
    return
  end
  local itemWrapper = getInventoryItemByType(itemwhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local mainMsg = itemName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_EXP")
  local subMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_EXP") .. string.format("%.2f", itemWrapper:getExperience() / 10000) .. "%"
  local iconPath = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  local iconUV = float4(0, 0, 42, 42)
  ToClient_RequestNakMessageRenewelWithStringAndIcon(__eNakMessage_AlchemyStoneGrindingSuccess, mainMsg, subMsg, iconPath, iconUV)
  PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(2)
  self._ui._btn_charge:SetMonoTone(false)
  self._ui._btn_charge:SetIgnore(false)
  self._audioId = nil
  self._audioIdXbox = nil
end
function FromClient_AlchemyStone_Renewal_All_EvolveResult(type, resultItemKey)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  self:showEvolveResult(type, resultItemKey)
  self:update()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_Use()
  local itemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAlchemyStone)
  if itemWrapper ~= nil and itemWrapper:get():getEndurance() > 0 then
    useAlchemyStone()
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_UpdateTime(deltaTime)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if self._chargeEffectTime > 0 then
    self._startEffectPlay = true
    self._chargeEffectTime = self._chargeEffectTime - deltaTime
    self._ui._btn_charge:SetMonoTone(true)
    self._ui._btn_charge:SetIgnore(true)
    if self._chargeEffectTime <= 0 and self._startEffectPlay == true then
      self._startEffectPlay = false
      self._chargeEffectTime = 0
      PaGlobalFunc_AlchemyStone_Renewal_All_Charge()
    end
  elseif 0 < self._upgradeEffectTime then
    self._startEffectPlay = true
    self._upgradeEffectTime = self._upgradeEffectTime - deltaTime
    self._ui._btn_charge:SetMonoTone(true)
    self._ui._btn_charge:SetIgnore(true)
    if 0 >= self._upgradeEffectTime and self._startEffectPlay == true then
      self._startEffectPlay = false
      self._upgradeEffectTime = 0
      PaGlobalFunc_AlchemyStone_Renewal_All_Upgrade()
    end
  elseif 0 < self._evolveEffectTime then
    self._startEffectPlay = true
    self._evolveEffectTime = self._evolveEffectTime - deltaTime
    self._ui._btn_charge:SetMonoTone(true)
    self._ui._btn_charge:SetIgnore(true)
    if 0 >= self._evolveEffectTime and self._startEffectPlay == true then
      self._startEffectPlay = false
      self._evolveEffectTime = 0
      PaGlobalFunc_AlchemyStone_Renewal_All_Evolve()
    end
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_StartEvolve()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  self:startEvolveProgressing()
end
function PaGlobalFunc_AlchemyStone_Renewal_All_Evolve()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if PaGlobal_AlchemyStoneEvolve_All == nil then
    return
  end
  if PaGlobal_AlchemyStoneEvolve_All._alchemyStoneWhereType == nil or PaGlobal_AlchemyStoneEvolve_All._alchemyStoneSlotNo == nil or PaGlobal_AlchemyStoneEvolve_All._materialWhereType == nil or PaGlobal_AlchemyStoneEvolve_All._materialSlotNo == nil or PaGlobal_AlchemyStoneEvolve_All._materialItemCount == nil then
    return
  end
  ToClient_alchemyEvolveRemaster(PaGlobal_AlchemyStoneEvolve_All._materialWhereType, PaGlobal_AlchemyStoneEvolve_All._materialSlotNo, PaGlobal_AlchemyStoneEvolve_All._materialItemCount, PaGlobal_AlchemyStoneEvolve_All._alchemyStoneWhereType, PaGlobal_AlchemyStoneEvolve_All._alchemyStoneSlotNo, PaGlobal_AlchemyStoneEvolve_All._protectWhereType, PaGlobal_AlchemyStoneEvolve_All._protectSlotNo, PaGlobal_AlchemyStoneEvolve_All._protectItemCount)
end
function PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(isShow, type)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if isShow == false then
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if type == 0 then
    if self._materialWhereType == nil then
      return
    end
    local control
    if self._currentTab == self._eTab._charge then
      control = self._upgradeSlot[0].icon
    elseif self._currentTab == self._eTab._upgrade then
      control = self._upgradeSlot[1].icon
    end
    if control == nil then
      return
    end
    local itemWrapper = getInventoryItemByType(self._materialWhereType, self._materialSlotNo)
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
    end
  elseif type == 1 then
    if self._alchemyStoneWhereType == nil then
      return
    end
    local control
    if self._currentTab == self._eTab._charge then
      control = self._chargeSlot[0].icon
    elseif self._currentTab == self._eTab._upgrade then
      control = self._chargeSlot[1].icon
    end
    if control == nil then
      return
    end
    local itemWrapper = getInventoryItemByType(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
    end
  elseif type == 2 then
    if self._resultItemKey == nil then
      return
    end
    local control = self._evolveResultSlot[0].icon
    local itemSSW = getItemEnchantStaticStatus(self._resultItemKey)
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      Panel_Tooltip_Item_Show(itemSSW, control, true, false, nil, nil, nil)
    end
  end
end
function PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(type)
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  local keyGuides = {}
  self._ui._keyGuideA:SetShow(false)
  self._ui._keyGuideX:SetShow(false)
  self._ui._keyGuideB:SetShow(false)
  self._ui._keyGuideY:SetShow(false)
  self._ui._stc_consoleKeyGuide:SetShow(true)
  if type == 0 then
    self._ui._keyGuideB:SetShow(true)
    self._ui._keyGuideY:SetShow(true)
    if self._materialWhereType == nil then
      keyGuides = {
        self._ui._keyGuideB,
        self._ui._keyGuideY
      }
    else
      keyGuides = {
        self._ui._keyGuideA,
        self._ui._keyGuideB,
        self._ui._keyGuideX,
        self._ui._keyGuideY
      }
      self._ui._keyGuideX:SetShow(true)
      self._ui._keyGuideA:SetShow(true)
      self._ui._keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    end
  elseif type == 1 then
    self._ui._keyGuideB:SetShow(true)
    self._ui._keyGuideY:SetShow(true)
    if self._alchemyStoneWhereType == nil then
      keyGuides = {
        self._ui._keyGuideB,
        self._ui._keyGuideY
      }
    else
      keyGuides = {
        self._ui._keyGuideA,
        self._ui._keyGuideB,
        self._ui._keyGuideX,
        self._ui._keyGuideY
      }
      self._ui._keyGuideX:SetShow(true)
      self._ui._keyGuideA:SetShow(true)
      self._ui._keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    end
  elseif type == 2 then
    keyGuides = {
      self._ui._keyGuideA,
      self._ui._keyGuideB,
      self._ui._keyGuideY
    }
    self._ui._keyGuideA:SetShow(true)
    self._ui._keyGuideB:SetShow(true)
    self._ui._keyGuideY:SetShow(true)
    self._ui._keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
  elseif type == 3 then
    keyGuides = {}
    self._ui._stc_consoleKeyGuide:SetShow(false)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_consoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobalFunc_AlchemyStone_Renewal_All_CheckSkipAni()
  local self = PaGlobal_AlchemyStone_Renewal_All
  if self == nil then
    return
  end
  if self._ui._chk_skipAni:IsCheck() == true then
    self._ui._chk_skipAni:SetCheck(false)
  else
    self._ui._chk_skipAni:SetCheck(true)
  end
end
