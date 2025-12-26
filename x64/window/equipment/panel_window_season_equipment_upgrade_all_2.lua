function PaGlobal_SeasonEquipment_Upgrade_Open()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if true == Panel_Window_Season_Equiptment_Upgrade_All:GetShow() then
    return
  end
  PaGlobal_SeasonEquipment_Upgrade:prepareOpen()
  if false == PaGlobal_SeasonEquipment_Upgrade._isConsole then
    PaGlobal_Equipment_All_ShowSeasonUpgradeEquipEffect(true)
    PaGlobal_Equipment_All_ShowSeasonUpgradeBannerEffect(false)
  else
    PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(true, false)
  end
end
function PaGlobal_SeasonEquipment_Upgrade_Close()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if false == Panel_Window_Season_Equiptment_Upgrade_All:GetShow() then
    return
  end
  PaGlobal_SeasonEquipment_Upgrade:prepareClose()
  if false == PaGlobal_SeasonEquipment_Upgrade._isConsole then
    PaGlobal_Equipment_All_ShowSeasonUpgradeEquipEffect(false)
  else
    PaGlobal_InventoryEquip_ShowSeasonUpgradeBannerEffect(true, true)
  end
end
function PaGlobal_SeasonEquipment_Upgrade_GetShow()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return false
  end
  return Panel_Window_Season_Equiptment_Upgrade_All:GetShow()
end
function PaGlobal_SeasonEquipment_Upgrade_Filter(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if true == itemSSW:get():isChangeEquipItem() then
    return false
  end
  return true
end
function PaGlobal_SeasonEquipment_Upgrade_All_RClickForTargetItem(slotNo, itemWrapper, count, inventoryType)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  if true == itemSSW:get():isChangeEquipItem() then
    PaGlobal_SeasonEquipment_Upgrade.naruItemKey = itemSSW:get()._key
    PaGlobal_SeasonEquipment_Upgrade:setNaruItem(slotNo, itemWrapper, inventoryType)
  end
end
function PaGlobal_SeasonEquipment_Upgrade_UpdateRegistFunc(deltaTime)
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if true == PaGlobal_SeasonEquipment_Upgrade.startAnimation then
    PaGlobal_SeasonEquipment_Upgrade.animationTime = PaGlobal_SeasonEquipment_Upgrade.animationTime + deltaTime
    if PaGlobal_SeasonEquipment_Upgrade.animationTotalTime < PaGlobal_SeasonEquipment_Upgrade.animationTime then
      PaGlobal_SeasonEquipment_Upgrade.startAnimation = false
      PaGlobal_SeasonEquipment_Upgrade.animationTime = 0
      PaGlobal_SeasonEquipment_Upgrade._ui.stc_effect:EraseAllEffect()
      ToClient_RequestChangeEquipItem(PaGlobal_SeasonEquipment_Upgrade.naruItem.inventoryType, PaGlobal_SeasonEquipment_Upgrade.naruItem.slotNo)
      Panel_Window_Season_Equiptment_Upgrade_All:ClearUpdateLuaFunc()
    end
  end
end
function PaGlobal_SeasonEquipment_Upgrade_All_ClearChangeItem(fromItemKey, fromLevel, toItemKey, toLevel)
  if Panel_Window_StackExtraction_All:GetShow() then
    local naruName = ""
    local tubalaName = ""
    local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._naruItemWhereType, PaGlobal_SpiritEnchant_All._naruItemSlotNo)
    if nil ~= itemWrapper then
      naruName = itemWrapper:getStaticStatus():getName()
    end
    local tubalaItemSSW = getItemEnchantStaticStatus(PaGlobal_SpiritEnchant_All._tubalaItemKey)
    if nil ~= tubalaItemSSW then
      tubalaName = tubalaItemSSW:getName()
    end
    Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SEASON_EQUIPMENT_CHANGE_COMPLETE", "naru", naruName, "tubala", tubalaName))
    PaGlobal_SpiritEnchant_All:clearEnchantSlot()
    return
  end
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == fromItemKey or nil == fromLevel or nil == toItemKey or nil == fromLevel then
    return
  end
  if nil == PaGlobal_SeasonEquipment_Upgrade.naruItemKey or nil == PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey then
    return
  end
  if fromItemKey ~= PaGlobal_SeasonEquipment_Upgrade.naruItemKey:getItemKey() then
    return
  end
  if fromLevel ~= PaGlobal_SeasonEquipment_Upgrade.naruItemKey:getEnchantLevel() then
    return
  end
  if toItemKey ~= PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey:getItemKey() then
    return
  end
  if toLevel ~= PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey:getEnchantLevel() then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(PaGlobal_SeasonEquipment_Upgrade.naruItemKey)
  local naruName = ""
  local tubalaName = ""
  if nil ~= itemSSW then
    naruName = itemSSW:getName()
  end
  itemSSW = getItemEnchantStaticStatus(PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey)
  if nil ~= itemSSW then
    tubalaName = itemSSW:getName()
  end
  PaGlobal_SeasonEquipment_Upgrade:clearNaruItem()
  Proc_ShowMessage_Ack(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SEASON_EQUIPMENT_CHANGE_COMPLETE", "naru", naruName, "tubala", tubalaName))
end
function HandleEventRUp_SeasonEquipment_Upgrade_All_ReleaseNaruItem()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  PaGlobal_SeasonEquipment_Upgrade:clearNaruItem()
  Panel_Tooltip_Item_hideTooltip()
end
function HandleEventOn_SeasonEquipment_Upgrade_All_NaruItemTootip()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == PaGlobal_SeasonEquipment_Upgrade.naruItemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(PaGlobal_SeasonEquipment_Upgrade.naruItemKey)
  if nil ~= itemSSW then
    if true == _ContentsGroup_RenewUI then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, PaGlobal_SeasonEquipment_Upgrade.naruItem.icon)
    else
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SeasonEquipment_Upgrade.naruItem.icon, true, false, nil, nil, nil)
    end
  end
end
function HandleEventOn_SeasonEquipment_Upgrade_All_NaruItemSimpleTootipForConsle()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == PaGlobal_SeasonEquipment_Upgrade.naruItemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(PaGlobal_SeasonEquipment_Upgrade.naruItemKey)
  if nil ~= itemSSW and true == _ContentsGroup_RenewUI then
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemNameOnly, PaGlobal_SeasonEquipment_Upgrade.naruItem.icon)
  end
end
function HandleEventOn_SeasonEquipment_Upgrade_All_TubalaItemTootip()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey)
  if nil ~= itemSSW then
    if true == _ContentsGroup_RenewUI then
      PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, PaGlobal_SeasonEquipment_Upgrade.tubalaItem.icon)
    else
      Panel_Tooltip_Item_Show(itemSSW, PaGlobal_SeasonEquipment_Upgrade.tubalaItem.icon, true, false, nil, nil, nil)
    end
  end
end
function HandleEventOn_SeasonEquipment_Upgrade_All_TubalaItemSimpleTootipForConsle()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(PaGlobal_SeasonEquipment_Upgrade.tubalaItemKey)
  if nil ~= itemSSW and true == _ContentsGroup_RenewUI then
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemNameOnly, PaGlobal_SeasonEquipment_Upgrade.tubalaItem.icon)
  end
end
function HandleEventOut_SeasonEquipment_Upgrade_All_Tooltip()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_FloatingTooltip_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleEventLUp_PaGlobal_SeasonEquipment_Upgrade()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  local self = PaGlobal_SeasonEquipment_Upgrade
  if true == self.startAnimation then
    return
  end
  if nil == self.naruItem then
    return
  end
  if nil == self.naruItem.slotNo or nil == self.naruItem.inventoryType then
    return
  end
  if nil == self.naruItemKey or nil == self.tubalaItemKey then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(self.naruItemKey)
  local naruName = ""
  local tubalaName = ""
  if nil ~= itemSSW then
    naruName = itemSSW:getName()
  end
  itemSSW = getItemEnchantStaticStatus(self.tubalaItemKey)
  if nil ~= itemSSW then
    tubalaName = itemSSW:getName()
  end
  local function UpgradeYes()
    self.startAnimation = true
    PaGlobal_SeasonEquipment_Upgrade._ui.stc_effect:AddEffect("fUI_Equipment_UP_02A", true, 0, 0)
    Panel_Window_Season_Equiptment_Upgrade_All:RegisterUpdateFunc("PaGlobal_SeasonEquipment_Upgrade_UpdateRegistFunc")
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SEASON_EQUIPMENT_CHANGE_MESSAGE", "naru", naruName, "tubala", tubalaName),
    functionYes = UpgradeYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_SeasonEquipment_Upgrade_All_OnScreenResize()
  if nil ~= Panel_Window_Equipment_All then
    Panel_Window_Season_Equiptment_Upgrade_All:SetPosX(Panel_Window_Equipment_All:GetPosX() - Panel_Window_Season_Equiptment_Upgrade_All:GetSizeX() - 100)
  end
  Panel_Window_Season_Equiptment_Upgrade_All:ComputePos()
end
function PaGlobal_SeasonEquipment_Upgrade_ShowAni()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
end
function PaGlobal_SeasonEquipment_Upgrade_HideAni()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
end
