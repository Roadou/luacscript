function HandleEventLUp_Inventory_All_CheckPopUpUI()
  if PaGlobal_Inventory_All._ui.check_popup:IsCheck() then
    Panel_Window_Inventory_All:OpenUISubApp()
  else
    Panel_Window_Inventory_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_Inventory_All_PopupUITooltip(isShow)
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_Inventory_All._ui.check_popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_Inventory_All._ui.check_popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Inventory_All_SelectTab()
  local self = PaGlobal_Inventory_All
  if self == nil then
    return
  end
  self:clearFocusSearchText()
  if Panel_AutoMove_Result_All ~= nil and Panel_AutoMove_Result_All:GetShow() == true then
    PaGlobal_AutoMove_Result_All:prepareClose()
  end
  if Panel_Window_AlchemyStoneEvolve_All ~= nil and Panel_Window_AlchemyStoneEvolve_All:GetShow() == true then
    PaGlobal_AlchemyStoneEvolve_All:update()
  end
  PaGlobal_Endurance_Recovery_All_StreamRecoveryStop()
  if DragManager:isDragging() then
    DragManager:clearInfo()
  end
  if true == _ContentsGroup_NewUI_ClothInventory_All or true == _ContentsGroup_RenewUI then
    PaGlobalFunc_ClothInventory_All_Close()
  elseif Panel_Window_ClothInventory:GetShow() then
    ClothInventory_Close()
  end
  self._startSlotIndex = 0
  self._startCategorySlotIndex = 0
  self:selectTabSound()
  self._ui.scroll_inven:SetControlTop()
  self:changeMileageIcon()
  self:categoryScrollTop()
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.Inventory)
  PaGlobalFunc_AutoSortFunctionPanel_Hide()
  Inventory_FamilyInvenEffect(false)
  if self._openedUIMode ~= self._bottomBG_UIMode.OpenedEnchant then
    if (self.otherWindowOpenFunc ~= nil or self.rClickFunc ~= nil or self.filterFunc ~= nil or self.effect ~= nil) and self._isDeleteMode == false then
      return
    end
    self:deleteMode_setShow(false)
  end
end
function HandleEventLUp_Inventory_All_ShowSortOption()
  if PaGlobal_Inventory_All == nil then
    return
  end
  PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(InvenSortLinkPanelIndex.Inventory)
end
function PaGlobalFunc_Inventory_All_IsSorted()
  return PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.Inventory)
end
function HandleEventLUp_Inventory_All_EasyBuyOpen(isSlot)
  if CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() then
    if true == isSlot then
      PaGlobalFunc_EasyBuy_Open(87)
    else
      PaGlobalFunc_EasyBuy_Open(86)
    end
  elseif true == isSlot then
    PaGlobalFunc_EasyBuy_Open(5)
  else
    PaGlobalFunc_EasyBuy_Open(4)
  end
end
function HandleEventOnOut_Inventory_All_CapacityTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYSLOT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYSLOT_TOOLTIP_DESC")
  TooltipSimple_Show(PaGlobal_Inventory_All._ui.txt_capacity, name, desc)
end
function HandleEventScroll_Inventory_All_UpdateScroll(isUp)
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    return
  end
  local useStartSlot = inventorySlotNoUserStart()
  local inventory = Inventory_GetCurrentInventory()
  local inventoryMaxSize = 0
  if CppEnums.ItemWhereType.eFamilyInventory == Inventory_GetCurrentInventoryType() then
    inventoryMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
  else
    inventoryMaxSize = inventory:sizeXXX()
  end
  local maxSize = inventoryMaxSize - useStartSlot
  local prevSlotIndex = PaGlobal_Inventory_All._startSlotIndex
  PaGlobal_Inventory_All._startSlotIndex = UIScroll.ScrollEvent(PaGlobal_Inventory_All._ui.scroll_inven, isUp, PaGlobal_Inventory_All.config.slotRows, maxSize, PaGlobal_Inventory_All._startSlotIndex, PaGlobal_Inventory_All.config.slotCols)
  local intervalSlotIndex = PaGlobal_Inventory_All.INVEN_MAX_COUNT - PaGlobal_Inventory_All.INVEN_CURRENTSLOT_COUNT
  if prevSlotIndex == 0 and PaGlobal_Inventory_All._startSlotIndex == 0 or prevSlotIndex == intervalSlotIndex and PaGlobal_Inventory_All._startSlotIndex == intervalSlotIndex then
    return
  end
  Inventory_updateSlotData()
end
function HandleEventOnOut_Inventory_All_WeightTooltip(isShow)
  local selfPlayerWrapper = getSelfPlayer()
  local selfPlayer = selfPlayerWrapper:get()
  local s64_moneyWeight = selfPlayer:getMoneyInventory():getMoneyWeight_s64()
  local s64_equipmentWeight = selfPlayer:getEquipment():getWeight_s64()
  local s64_allWeight = selfPlayer:getCurrentWeight_s64()
  local s64_maxWeight = selfPlayer:getPossessableWeight_s64()
  local moneyWeight = Int64toInt32(s64_moneyWeight) / 10000
  local equipmentWeight = Int64toInt32(s64_equipmentWeight) / 10000
  local allWeight = Int64toInt32(s64_allWeight) / 10000
  local maxWeight = Int64toInt32(s64_maxWeight) / 10000
  local invenWeight = allWeight - equipmentWeight - moneyWeight
  if isShow == true then
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_WEIGHTHELP_1") .. string.format("%.1f", invenWeight) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "(" .. string.format("%.1f", invenWeight / maxWeight * 100) .. "%)")
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_EQUIPHELP_1") .. string.format("%.1f", equipmentWeight) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "(" .. string.format("%.1f", equipmentWeight / maxWeight * 100) .. "%)")
    PaGlobal_Inventory_All._ui.txt_moneyDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_MONEYHELP_1") .. string.format("%.1f", moneyWeight) .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT") .. "(" .. string.format("%.1f", moneyWeight / maxWeight * 100) .. "%)")
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.stc_weightTooltipBG, 9000)
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.txt_weightDesc, 9999)
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.txt_equipDesc, 9999)
    Panel_Window_Inventory_All:SetChildIndex(PaGlobal_Inventory_All._ui.txt_moneyDesc, 9999)
    PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetShow(true)
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetShow(true)
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetShow(true)
    PaGlobal_Inventory_All._ui.txt_moneyDesc:SetShow(true)
    local mousePosY = getMousePosY()
    local invenPosY = Panel_Window_Inventory_All:GetPosY()
    if true == Panel_Window_Inventory_All:IsUISubApp() then
      invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
    end
    PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetPosY(mousePosY - invenPosY + 25)
    local endPosY = invenPosY + PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetPosY()
    if endPosY > getScreenSizeY() then
      local gap = endPosY - getScreenSizeY()
      PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetPosY(PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetScreenParentPosY() - gap)
    end
    if true == _ContentsGroup_RenewUI_ItemMarketPlace then
      PaGlobal_Inventory_All._ui.txt_moneyDesc:SetShow(false)
      PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetSize(PaGlobal_Inventory_All._ui.stc_weightTooltipBG:GetSizeX(), PaGlobal_Inventory_All._defaultWeightTooltipSizeY)
      PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetPosY(PaGlobal_Inventory_All._ui.txt_weightDesc:GetPosY() - 12)
    end
  else
    PaGlobal_Inventory_All._ui.stc_weightTooltipBG:SetShow(false)
    PaGlobal_Inventory_All._ui.txt_weightDesc:SetShow(false)
    PaGlobal_Inventory_All._ui.txt_equipDesc:SetShow(false)
    PaGlobal_Inventory_All._ui.txt_moneyDesc:SetShow(false)
  end
end
function HandleEventOnOut_Inventory_All_SlotInfoTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYSLOT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYSLOT_TOOLTIP_DESC")
  local control = PaGlobal_Inventory_All._ui.stc_bottom_SlotIcon
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Inventory_All_BuyWeightTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYWEIGHT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BUYWEIGHT_TOOLTIP_DESC")
  local icon = PaGlobal_Inventory_All._ui.stc_weightIcon
  local control = PaGlobal_Inventory_All._ui.btn_buyWeight
  if _ContentsGroup_InvenCategory == true then
    control = PaGlobal_Inventory_All._ui.btn_bottom_BuyWeight
    icon = PaGlobal_Inventory_All._ui.stc_bottom_WeightIcon
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_Inventory_All_BuySlotTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_DESC")
  local icon = PaGlobal_Inventory_All._ui.stc_bottom_SlotIcon
  local control = PaGlobal_Inventory_All._ui.btn_bottom_BuySlot
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_Inventory_All_MoneyIconTooltip(isShow, tipType)
  local name, desc, control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "GAME_EXCHANGE_ITEMTOOLTIP_DESCRIPTION_SILVER")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SILVER_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.stc_bottom_MoneyIcon
    else
      control = PaGlobal_Inventory_All._ui.stc_moneyIcon
    end
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_MONEYICON_TOOLTIP_PEARL_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_PEARL_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.stc_bottom_PearlIcon
    else
      control = PaGlobal_Inventory_All._ui.stc_pearlIcon
    end
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_MONEYICON_TOOLTIP_MILEAGE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INGAMESHOP_MONEYICON_TOOLTIP_MILEAGE_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.stc_bottom_MileageIcon
    else
      control = PaGlobal_Inventory_All._ui.stc_mileageIcon
    end
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_AUCTION_SEASHELL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SEASHELL_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.stc_bottom_OceanIcon
    else
      control = PaGlobal_Inventory_All._ui.stc_oceanIcon
    end
  elseif 4 == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_HARDCORENMONEY")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_HARDCORENMONEY")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.stc_bottom_hardCoreIcon
    else
      control = PaGlobal_Inventory_All._ui.stc_hardCoreIcon
    end
  end
  if isShow then
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Inventory_All_OpenPearlShop()
  if Defines.UIMode.eUIMode_Default ~= GetUIMode() then
    return
  end
  InGameShop_Open()
end
function HandleEventLUp_Inventory_All_BottomButtonClick(functionType)
  if functionType == nil then
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  if functionType == InventoryBottomOpenUIButtonIndex.EnchantInventory == true and Panel_Dialog_NPCShop_All ~= nil and Panel_Dialog_NPCShop_All:GetShow() == true then
    return
  end
  if DragManager:isDragging() == true then
    DragManager:clearInfo()
  end
  PaGlobal_Warehouse_All_Close()
  local doShowEquipUI = true
  if functionType == InventoryBottomOpenUIButtonIndex.AlchemyFigureHead then
    if PaGlobal_AlchemyFigureHead_All_IsShow() == true then
      doShowEquipUI = true
    else
      doShowEquipUI = false
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.AlchemyStone then
    if _ContentsGroup_AlchemyStoneRenewal then
      if PaGlobalFunc_AlchemyStone_Renewal_All_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    elseif _ContentsGroup_NewUI_AlchemyStone_All == true then
      if PaGlobalFunc_AlchemyStone_All_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Manufacture then
    if PaGlobalFunc_Manufacture_All_IsShow() == true then
      doShowEquipUI = true
    else
      doShowEquipUI = false
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Palette then
    if _ContentsGroup_NewUI_Dye_All == true then
      if PaGlobal_Palette_All_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    elseif _ContentsGroup_NewUI_Dye_Palette_All == true then
      if PaGlobal_Dye_Palette_All_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    elseif FGlobal_DyePalette_IsShow() == true then
      doShowEquipUI = true
    else
      doShowEquipUI = false
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.LightStoneBag then
    if _ContentsGroup_LightStoneBag == true then
      if PaGlobalFunc_LightStoneBag_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.FamilyInventory then
    if _ContentsGroup_FamilyInventory == true then
      if PaGlobal_FamilyInvnetory_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.JewelPreset then
    if _ContentsGroup_JewelPreset == true then
      if PaGlobalFunc_JewelPreset_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Enchant then
    doShowEquipUI = false
  elseif functionType == InventoryBottomOpenUIButtonIndex.RepairDekia then
    if _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true then
      if PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.CombineBag then
    if PaGlobalFunc_CombineBag_IsShow() == true then
      doShowEquipUI = true
    else
      doShowEquipUI = false
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.EnchantInventory then
    if _ContentsGroup_EnchantRemaster == true then
      local isEnchantOpen = Panel_Widget_Enchant_Main_All:GetShow()
      if isEnchantOpen == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoEnchantPanelOpen"))
        return
      end
    end
    if _ContentsGroup_EnchantRemaster == true then
      if PaGlobal_EnchantInventory_IsShow() == true then
        doShowEquipUI = true
      else
        doShowEquipUI = false
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.ValksList and _ContentsGroup_EnchantRemaster == true then
    if PaGlobalFunc_ValksList_All_IsShow() == true then
      doShowEquipUI = true
    else
      doShowEquipUI = false
    end
  end
  if doShowEquipUI == false then
    PaGlobalFunc_Inventory_All_CloseSideUI(functionType)
  end
  if functionType == InventoryBottomOpenUIButtonIndex.AlchemyFigureHead then
    if PaGlobal_AlchemyFigureHead_All_IsShow() == true then
      PaGlobal_AlchemyFigureHead_All_Close()
    else
      PaGlobal_AlchemyFigureHead_All_Open()
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.AlchemyStone then
    if _ContentsGroup_AlchemyStoneRenewal then
      if PaGlobalFunc_AlchemyStone_Renewal_All_IsShow() == true then
        PaGlobalFunc_AlchemyStone_Renewal_All_Close()
      else
        PaGlobalFunc_AlchemyStone_Renewal_All_Open()
      end
    elseif _ContentsGroup_NewUI_AlchemyStone_All == true then
      if PaGlobalFunc_AlchemyStone_All_IsShow() == true then
        PaGlobalFunc_AlchemyStone_All_Close()
      else
        PaGlobalFunc_AlchemyStone_All_Open()
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Manufacture then
    if PaGlobalFunc_Manufacture_All_IsShow() == true then
      PaGlobalFunc_Manufacture_All_Close()
    else
      PaGlobalFunc_Inventory_All_OpenManufacture()
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Palette then
    if _ContentsGroup_NewUI_Dye_All == true then
      if PaGlobal_Palette_All_IsShow() == true then
        PaGlobal_Palette_All_Close()
      else
        PaGlobalFunc_Inventory_All_OpenPalette()
      end
    elseif _ContentsGroup_NewUI_Dye_Palette_All == true then
      if PaGlobal_Dye_Palette_All_IsShow() == true then
        PaGlobal_Dye_Palette_All_Close()
      else
        PaGlobalFunc_Inventory_All_OpenPalette()
      end
    elseif FGlobal_DyePalette_IsShow() == true then
      FGlobal_DyePalette_Close()
    else
      PaGlobalFunc_Inventory_All_OpenPalette()
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.LightStoneBag then
    if _ContentsGroup_LightStoneBag == true then
      if PaGlobalFunc_LightStoneBag_IsShow() == true then
        PaGlobalFunc_LightStoneBag_Close()
      else
        PaGlobalFunc_LightStoneBag_Open()
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.FamilyInventory then
    if _ContentsGroup_FamilyInventory == true then
      if PaGlobal_FamilyInvnetory_IsShow() == true then
        PaGlobal_FamilyInvnetory_Close(true)
      else
        PaGlobal_FamilyInvnetory_Open()
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.JewelPreset then
    if PaGlobalFunc_JewelPreset_IsShow() == true then
      PaGlobalFunc_JewelPreset_Close()
      Inventory_SetFunctor(nil, nil, nil, nil)
    elseif ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == false and ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) == false then
      if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:IsShow() == true then
        return
      end
      PaGlobalFunc_JewelPreset_Open()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCanJointhisChannel"))
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Enchant then
    if IsSelfPlayerWaitAction() == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SUMMON_BLACKSPIRIT"))
      return
    end
    ToClient_AddBlackSpiritFlush(0, true, CppEnums.EFlush_BlackSpirit_Ui_Type.eFlush_BlackSpirit_Ui_ItemEnchant)
  elseif functionType == InventoryBottomOpenUIButtonIndex.RepairDekia then
    if _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true then
      if PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == true then
        PaGlobalFunc_MonsterBuffZoneItemRepair_Close()
      else
        PaGlobalFunc_MonsterBuffZoneItemRepair_Open()
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.CombineBag then
    if PaGlobalFunc_CombineBag_IsShow() == true then
      PaGlobalFunc_CombineBag_Close()
    else
      PaGlobalFunc_CombineBag_Open()
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.ReforgeStonePreset then
    if PaGlobal_ReforgeStonePreset_GetShow() == true then
      PaGlobal_ReforgeStonePreset_Close()
    else
      PaGlobal_ReforgeStonePreset_Open()
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.EnchantInventory then
    if _ContentsGroup_EnchantRemaster == true then
      if PaGlobal_EnchantInventory_IsShow() == true then
        PaGlobal_EnchantInventory_Close(true)
      else
        PaGlobal_EnchantInventory_Open()
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.ValksList and _ContentsGroup_EnchantRemaster == true then
    if PaGlobalFunc_ValksList_All_IsShow() == true then
      PaGlobalFunc_ValksList_All_Close()
    else
      PaGlobalFunc_ValksList_All_Open()
    end
  end
  if _ContentsGroup_NewUI_Equipment_All == true then
    PaGlobalFunc_Equipment_All_SetShow(doShowEquipUI)
  else
    FGlobal_Equipment_SetHide(doShowEquipUI)
  end
end
function PaGlobalFunc_Inventory_All_CloseSideUI(exceptFunctionType)
  if exceptFunctionType == nil then
    return
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.AlchemyFigureHead and PaGlobal_AlchemyFigureHead_All_IsShow() == true then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.AlchemyStone then
    if _ContentsGroup_AlchemyStoneRenewal then
      if PaGlobalFunc_AlchemyStone_Renewal_All_IsShow() == true then
        PaGlobalFunc_AlchemyStone_Renewal_All_Close()
      end
    elseif _ContentsGroup_NewUI_AlchemyStone_All == true then
      if PaGlobalFunc_AlchemyStone_All_IsShow() == true then
        PaGlobalFunc_AlchemyStone_All_Close()
      end
    elseif FGlobal_AlchemyStone_IsShow() == true then
      FGlobal_AlchemyStone_Close()
    end
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.Manufacture and PaGlobalFunc_Manufacture_All_IsShow() == true then
    PaGlobalFunc_Manufacture_All_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.Palette then
    if _ContentsGroup_NewUI_Dye_All == true then
      if PaGlobal_Palette_All_IsShow() == true then
        PaGlobal_Palette_All_Close()
      end
    elseif _ContentsGroup_NewUI_Dye_Palette_All == true then
      if PaGlobal_Dye_Palette_All_IsShow() == true then
        PaGlobal_Dye_Palette_All_Close()
      end
    elseif FGlobal_DyePalette_IsShow() == true then
      FGlobal_DyePalette_Close()
    end
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.LightStoneBag and _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.FamilyInventory and _ContentsGroup_FamilyInventory == true and PaGlobal_FamilyInvnetory_IsShow() == true then
    PaGlobal_FamilyInvnetory_Close(true)
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.JewelPreset and _ContentsGroup_JewelPreset == true and PaGlobalFunc_JewelPreset_IsShow() == true then
    PaGlobalFunc_JewelPreset_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.RepairDekia and _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true and PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == true then
    PaGlobalFunc_MonsterBuffZoneItemRepair_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.CombineBag and PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.EnchantInventory and PaGlobal_EnchantInventory_IsShow ~= nil and PaGlobal_EnchantInventory_IsShow() == true then
    PaGlobal_EnchantInventory_Close(true)
  end
  if exceptFunctionType ~= InventoryBottomOpenUIButtonIndex.ValksList and PaGlobalFunc_ValksList_All_IsShow ~= nil and PaGlobalFunc_ValksList_All_IsShow() == true then
    PaGlobalFunc_ValksList_All_Close()
  end
end
function PaGlobalFunc_Inventory_All_ShowEquipUI()
  if _ContentsGroup_NewUI_Equipment_All == true then
    PaGlobalFunc_Equipment_All_SetShow(true)
  else
    FGlobal_Equipment_SetHide(true)
  end
end
function HandleEventOnOut_Inventory_All_BottomButtonTooltip(isShow, functionType)
  if isShow == nil or functionType == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if functionType == InventoryBottomOpenUIButtonIndex.AlchemyFigureHead then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYFIGUREHEAD_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYFIGUREHEAD_TOOLTIP_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.btn_bottom_AlchemyFigureHead
    else
      control = PaGlobal_Inventory_All._ui.btn_alchemyFigureHead
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.AlchemyStone then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYSTONE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ALCHEMYSTONE_TOOLTIP_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.btn_bottom_AlchemyStone
    else
      control = PaGlobal_Inventory_All._ui.btn_alchemyStone
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Manufacture then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_MANUFACTURE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_MANUFACTURE_TOOLTIP_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.btn_bottom_Manufacture
    else
      control = PaGlobal_Inventory_All._ui.btn_manufacture
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Palette then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DYEPALETTE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DYEPALETTE_TOOLTIP_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.btn_bottom_Palette
    else
      control = PaGlobal_Inventory_All._ui.btn_dyePalette
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.LightStoneBag then
    if _ContentsGroup_LightStoneBag == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LIGHTSTONE_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LIGHTSTONE_TOOLTIP_DESC")
      if _ContentsGroup_InvenCategory == true then
        control = PaGlobal_Inventory_All._ui.btn_bottom_ArtifactBag
      else
        control = PaGlobal_Inventory_All._ui.btn_lightStoneBag
      end
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.JewelPreset then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_SOCKET_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_CRYSTALPRESETBTN_TOOLTIPDESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.btn_bottom_Crystal
    else
      control = PaGlobal_Inventory_All._ui.btn_alchemyFigureHead
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.Enchant then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEW_TITLE_BAR")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVEN_ENCHANTBUTTON_TOOLTIP_DESC")
    if _ContentsGroup_InvenCategory == true then
      control = PaGlobal_Inventory_All._ui.btn_bottom_Enchant
    else
      return
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.RepairDekia then
    if _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DEKIA_INVENBTN_TOOLTIPTITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DEKIA_INVENBTN_TOOLTIPDESC")
      control = PaGlobal_Inventory_All._ui.btn_bottom_RepairDekia
    end
  elseif functionType == InventoryBottomOpenUIButtonIndex.CombineBag then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMBINATION_SLOT_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_COMBINEBAG_DESC")
    control = PaGlobal_Inventory_All._ui.btn_bottom_CombineBag
  elseif functionType == InventoryBottomOpenUIButtonIndex.ReforgeStonePreset then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_BAG_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_BAG_TOOLTIP_DESC")
    control = PaGlobal_Inventory_All._ui.btn_bottom_ReforgeStone
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Inventory_All_ItemDelete()
  PaGlobal_AutoMove_Result_All:prepareClose()
  if true == DragManager:isDragging() and true == PaGlobalFunc_Inventory_All_CheckDragStartPanel() then
    if Panel_Window_Inventory_All == DragManager.dragStartPanel then
      PaGlobal_Inventory_All:deleteMode_setShow(false)
      local slotNo = DragManager.dragSlotInfo
      local whereType = Inventory_GetCurrentInventoryType()
      local itemWrapper = getInventoryItemByType(whereType, slotNo)
      if nil == itemWrapper then
        return
      end
      local itemCount = itemWrapper:get():getCount_s64()
      if Defines.s64_const.s64_1 == itemCount then
        PaGlobalFunc_Inventory_All_ItemDelete_Check(Defines.s64_const.s64_1, slotNo, whereType)
      else
        Panel_NumberPad_Show(true, itemCount, slotNo, PaGlobalFunc_Inventory_All_ItemDelete_Check, nil, whereType)
      end
    elseif Panel_Window_ServantInventory == DragManager.dragStartPanel then
      local actorKeyRaw = ServantInventory_GetActorKeyRawFromDragManager()
      local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
      if nil == vehicleActorWrapper then
        return
      end
      local vehicleActor = vehicleActorWrapper:get()
      if nil == vehicleActor then
        return
      end
      if true == vehicleActor:isCannon() or true == vehicleActor:isGuildVehicle() then
        local luaDelete = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DELETE")
        local luaDeleteItemMsg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINVENTORY_ONLYTRASH_INVENTORY")
        local messageContent = luaDeleteItemMsg
        local messageboxData = {
          title = luaDelete,
          content = messageContent,
          functionYes = ServantInventory_Delete_No,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
        return
      end
      local slotNo = DragManager.dragSlotInfo
      local itemWrapper = getServantInventoryItemBySlotNo(actorKeyRaw, slotNo)
      if nil == itemWrapper then
        return
      end
      local itemCount = itemWrapper:get():getCount_s64()
      if Defines.s64_const.s64_1 == itemCount then
        ServantInventory_GroundClick_Message(Defines.s64_const.s64_1, slotNo)
      else
        Panel_NumberPad_Show(true, itemCount, slotNo, ServantInventory_GroundClick_Message)
      end
    end
  else
    HandleEventLUp_Inventory_All_ItemDeleteMode()
  end
end
function HandleEventOnOut_Inventory_All_TrashTooltip(isShow)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_TOOLTIP_TITLE")
  local desc, control
  if true == _ContentsGroup_RestoreItem then
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_TOOLTIP_WITH_RESTORATION_DESC")
  else
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_TOOLTIP_DESC")
  end
  if _ContentsGroup_InvenCategory == true then
    control = PaGlobal_Inventory_All._ui.btn_bottom_Trash
  else
    control = PaGlobal_Inventory_All._ui.chk_trash
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Inventory_All_MakePuzzle(index)
  PaGlobal_Inventory_All:hidePuzzleControl()
  requestMakePuzzle()
end
function HandleEventOnOut_Inventory_All_PuzzleTooltip(isShow, slotIndex)
  if not isShow then
    PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(false)
    return
  end
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:SetAutoResize(true)
  PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_DOPUZZLE"))
  local slot = PaGlobal_Inventory_All.slots[slotIndex]
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetPosX(slot.icon:GetPosX() - PaGlobal_Inventory_All._ui.stc_puzzleNotice:GetSizeX())
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetPosY(slot.icon:GetPosY() - 20)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetSize(PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:GetSizeX() + 20, PaGlobal_Inventory_All._ui.txt_puzzleNoticeText:GetTextSizeY() + 20)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetColor(Defines.Color.C_FF000000)
  PaGlobal_Inventory_All._ui.stc_puzzleNotice:SetShow(true)
end
function HandleEventLDown_Inventory_All_SlotLClick(index)
  local selfProxy = getSelfPlayer():get()
  if nil == selfProxy then
    return
  end
  local slotNo = -1
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    slotNo = index
  else
    slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  end
  if slotNo == -1 or slotNo == nil then
    return
  end
  local inventoryType = Inventory_GetCurrentInventoryType()
  local useStartSlot = inventorySlotNoUserStart()
  local inventory = Inventory_GetCurrentInventory()
  local invenUseSize = inventory:size()
  local invenMaxSize = inventory:sizeXXX()
  if CppEnums.ItemWhereType.eFamilyInventory == currentWhereType then
    invenMaxSize = ToClient_GetFamilyInvenotryMaxSlotCount()
  end
  if Panel_Chatting_Input:IsShow() and isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil == itemWrapper then
      return
    end
    local focusEdit = GetFocusEdit()
    if ChatInput_CheckCurrentUiEdit(focusEdit) then
      FGlobal_ChattingInput_LinkedItemByInventory(slotNo, inventoryType)
    end
  elseif keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Dash) == true then
    if (isGameTypeJapan() or isGameTypeRussia()) and getContentsServiceType() == CppEnums.ContentsServiceType.eContentsServiceType_CBT then
      return
    end
    local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
    if nil ~= itemWrapper then
      ProductNote_Item_ShowToggle(itemWrapper:get():getKey():getItemKey())
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
    end
  elseif true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_MENU) then
    if true == isGameTypeKorea() and true == _ContentsGroup_FairyChangeSkill then
      local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
      if nil ~= itemWrapper and false == itemWrapper:empty() then
        local itemEnchantWrapper = itemWrapper:getStaticStatus()
        if nil ~= itemEnchantWrapper then
          local itemConnectUi = itemEnchantWrapper:getConnectUi()
          local itemKey = itemWrapper:get():getKey():getItemKey()
        end
      end
    end
  elseif invenUseSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex == index and index < invenMaxSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex then
    local isDye = Panel_Widget_Dye_All ~= nil and Panel_Widget_Dye_All:GetShow() == true
    local isCategoryView = PaGlobal_Inventory_All_IsCategoryShow() == true
    if isDye == false and isCategoryView == false then
      audioPostEvent_SystemUi(0, 0)
      HandleEventLUp_Inventory_All_EasyBuyOpen(true)
    end
  end
end
function HandleEventRUp_Inventory_All_SlotRClick(index, equipSlotNo)
  if MessageBoxGetShow() then
    return
  end
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true and Panel_Window_Enchant_StackExtraction_All:GetShow() == false then
    return
  end
  if true == PaGlobal_Inventory_All._isMarketOpen then
    return
  end
  local slotNo = -1
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    slotNo = index
  else
    slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  end
  if slotNo == -1 or slotNo == nil then
    return
  end
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  if nil ~= Panel_Window_MessageBox_SeasonItem_All and true == Panel_Window_MessageBox_SeasonItem_All:GetShow() then
    PaGlobalFunc_MessageBox_SeasonItem_All_Close()
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local isCash = itemWrapper:isCash()
  if keyCustom_IsPressed_Action(CppEnums.ActionInputType.ActionInputType_Dash) == true then
    if isCash and itemWrapper:getStaticStatus():isEquipable() == false then
      return
    end
    if false == PaGlobal_Inventory_All._isItemLockContentsOpen then
      return
    end
    if Panel_Npc_Dialog_All:IsShow() then
      return
    end
    if Panel_Window_ItemMarket_Function:GetShow() or Panel_Window_ItemMarket_RegistItem:GetShow() or true == Panel_Dialog_Repair_Function_All:GetShow() then
      return
    end
    if false == itemWrapper:getStaticStatus():isStackable() and false == itemWrapper:isSoulCollector() then
      if ToClient_Inventory_CheckItemLock(slotNo, whereType) then
        ToClient_Inventory_RemoveItemLock(slotNo, whereType)
        Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
      else
        ToClient_Inventory_InsertItemLock(slotNo, whereType)
        Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMLOCK"))
      end
    elseif ToClient_Inventory_CheckItemLock(slotNo, whereType) then
      ToClient_Inventory_RemoveItemLock(slotNo, whereType)
      Proc_ShowMessage_Ack("[" .. itemName .. "] " .. PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ITEMUNLOCK"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANNOT_ITEMLOCK"))
    end
    Inventory_updateSlotData()
  else
    PaGlobalFunc_Inventory_All_SlotRClickXXX(slotNo, equipSlotNo, index)
  end
end
function PaGlobalFunc_Inventory_All_SlotRClickXXX(slotNo, equipSlotNo, index)
  local selfProxy = getSelfPlayer():get()
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if CppEnums.ItemWhereType.eCashInventory ~= inventoryType then
    local inventory = Inventory_GetCurrentInventory()
    local invenUseSize = inventory:size()
    if invenUseSize < slotNo + 1 then
      return
    end
  end
  if nil ~= itemWrapper then
    local itemEnchantWrapper = itemWrapper:getStaticStatus()
    if nil == itemEnchantWrapper then
      return
    end
    local itemConnectUi = itemEnchantWrapper:getConnectUi()
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
    if itemWrapper:checkTimeover() == true and ToClient_isTempCashItem(itemStatic._key) == true then
      PaGlobalFunc_EasyBuy_Open(103, nil, nil, ToClient_getTempCashProductItem(itemStatic._key))
      PaGlobal_EasyBuy.deleteItemWhereType = inventoryType
      PaGlobal_EasyBuy.deleteItemSlotNo = slotNo
    end
    if true == PaGlobal_VehicleInfo_All_GetPanelShow() then
      PaGlobal_VehicleInfo_All_InvenSetFunctor(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
      return
    end
    if nil ~= PaGlobal_Inventory_All.rClickFunc then
      PaGlobal_Inventory_All.rClickFunc(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
      return
    end
    if selfProxy:doRideMyVehicle() and false == Panel_Window_Warehouse:GetShow() and false == PaGlobalFunc_ServantInventory_GetShow() and nil ~= Panel_Window_CampWarehouse_All and false == Panel_Window_CampWarehouse_All:GetShow() and nil ~= Panel_Dialog_NPCShop_All and false == Panel_Dialog_NPCShop_All:GetShow() and itemStatic:isUseToVehicle() then
      if itemEnchantWrapper:isPopupItem() == true then
        PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
        return
      end
      inventoryUseItem(inventoryType, slotNo, equipSlotNo, false)
      return
    end
    PaGlobal_TutorialManager:handleInventorySlotRClick(itemWrapper:get():getKey():getItemKey())
    PaGlobal_TutorialManager:handleInventorySlotRClickgetSlotNo(slotNo)
    if DragManager:isDragging() then
      DragManager:clearInfo()
    end
    if nil ~= Panel_Auction_Regist_Popup and Panel_Auction_Regist_Popup:GetShow() then
      if itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, Auction_RegisterItemFromInventory)
      else
        Auction_RegisterItemFromInventory(1, slotNo)
      end
      return
    elseif nil ~= Panel_Window_FairySetting and Panel_Window_FairySetting:GetShow() then
      PaGlobal_FairySetting_SetPortion(itemWrapper:get():getKey())
    elseif nil ~= Panel_FairyInfo and Panel_Window_FairyUpgrade:GetShow() then
      if true == itemWrapper:getStaticStatus():isStackable() then
        Panel_NumberPad_Show(true, itemWrapper:get():getCount_s64(), slotNo, PaGlobal_FairyUpgrade_RClickItemByNumberPad, false, itemWrapper:get():getKey())
      else
        PaGlobal_FairyUpgrade_RClickItem(itemWrapper:get():getKey(), slotNo, 1)
      end
    elseif true == PaGlobalFunc_DialogMain_All_GetAuctionState() then
      return
    elseif 2 == itemEnchantWrapper:get()._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local function bindingItemUse()
        PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
      end
      local messageContent
      if itemEnchantWrapper:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = bindingItemUse,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif eConnectUiType.eConnectUi_Undefined ~= itemConnectUi then
      if eConnectUiType.eConnectUi_Letter == itemConnectUi then
        ConnectLetterUI(itemWrapper:get():getKey():getItemKey())
      else
        ConnectUI(itemConnectUi, itemWrapper:get():getKey():getItemKey())
      end
    elseif itemWrapper:getStaticStatus():getItemType() == 8 then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      audioPostEvent_SystemUi(0, 14)
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(true)
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "inventory", false, false)
      local row = math.floor((slotNo - 1) / PaGlobal_Inventory_All.config.slotCols)
      local col = (slotNo - 1) % PaGlobal_Inventory_All.config.slotCols
      local posx = 0
      local posy = 0
      if PaGlobal_Inventory_All_IsCategoryShow() == true then
        posx = PaGlobal_Inventory_All._ui.categorySlotList[index].icon:GetParentPosX() - Panel_Window_Inventory_All:GetParentPosX()
        posy = PaGlobal_Inventory_All._ui.categorySlotList[index].icon:GetParentPosY() - Panel_Window_Inventory_All:GetParentPosY()
      else
        posx = PaGlobal_Inventory_All.slots[index].icon:GetPosX()
        posy = PaGlobal_Inventory_All.slots[index].icon:GetPosY()
      end
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosX(posx - 42)
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosY(posy + 42)
      local endPosX = PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX() + PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetSizeX()
      if 0 > PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX() then
        PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosX(0)
      elseif endPosX > Panel_Window_Inventory_All:GetSizeX() then
        local gap = endPosX - Panel_Window_Inventory_All:GetSizeX()
        PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetPosX(PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX() - gap)
      end
      local _btn_MenuSizeX = PaGlobal_Inventory_All._ui.btn_manufactureOpen:GetSizeX() + 23
      local _btn_MenuTextSizeX = _btn_MenuSizeX - _btn_MenuSizeX / 2 - PaGlobal_Inventory_All._ui.btn_manufactureOpen:GetTextSizeX() / 2
      local _btn_NoteSizeX = PaGlobal_Inventory_All._ui.btn_productNote:GetSizeX() + 23
      local _btn_NoteTextSizeX = _btn_NoteSizeX - _btn_NoteSizeX / 2 - PaGlobal_Inventory_All._ui.btn_productNote:GetTextSizeX() / 2
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetTextSpan(_btn_MenuTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_productNote:SetTextSpan(_btn_NoteTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetPosY(4)
      PaGlobal_Inventory_All._ui.btn_productNote:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_productNote:SetPosY(38)
      if MiniGame_Manual_Value_FishingStart == true then
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetEnable(false)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetMonoTone(true)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetAlpha(0.8)
      else
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetEnable(true)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetMonoTone(false)
        PaGlobal_Inventory_All._ui.btn_manufactureOpen:SetAlpha(1)
      end
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenManufacture(" .. slotNo .. ")")
      PaGlobal_Inventory_All._ui.btn_productNote:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenProductNote(" .. itemWrapper:get():getKey():getItemKey() .. ")")
      PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideManufactureBG()")
      PaGlobal_Inventory_All._ui.btn_manufactureOpen:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideManufactureBG()")
      PaGlobal_Inventory_All._ui.btn_productNote:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideManufactureBG()")
      return
    elseif nil ~= PaGlobalFunc_ServantInventory_GetShow and true == PaGlobalFunc_ServantInventory_GetShow() or nil ~= Panel_Window_CampWarehouse_All and true == Panel_Window_CampWarehouse_All:GetShow() then
      if nil ~= FGlobal_PopupMoveItem_InitByInventory then
        FGlobal_PopupMoveItem_InitByInventory(slotNo, itemWrapper, itemWrapper:get():getCount_s64(), inventoryType)
        return
      end
    elseif itemEnchantWrapper:getContentsEventType() == __eContentsType_ItemBox or itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
      if ToClient_CheckAndNotifyNecessarySlotForOpenItemBox(inventoryType, slotNo, 1) ~= 0 then
        return
      end
      PaGlobal_Inventory_All._multiUseCount_s64 = itemWrapper:getCount()
      PaGlobal_Inventory_All._multiUseInventoryType = inventoryType
      PaGlobal_Inventory_All._multiUseSlotNo = slotNo
      if itemEnchantWrapper:getContentsEventParam2() == __eBoxItemUiType_NotUseMultiBoxItem then
        PaGlobal_Inventory_All._multiUseCount_s64 = toInt64(0, 1)
      elseif itemEnchantWrapper:isStackable() == false and itemEnchantWrapper:getContentsEventType() == __eContentsType_ItemBox then
        PaGlobal_Inventory_All._multiUseCount_s64 = ToClient_InventoryFindSlotListSize(inventoryType, itemWrapper:get():getKey())
      end
      if itemEnchantWrapper:isPopupItem() == true then
        if itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
          PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
        else
          PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo, HandleClicked_Inventory_All_UseMultiBoxes)
        end
        return
      elseif itemEnchantWrapper:getContentsEventType() == __eContentsType_Roulette then
        PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
        return
      end
      HandleClicked_Inventory_All_UseMultiBoxes()
    elseif true == _ContentsGroup_HopeGauge and true == itemStatic:isItemCollectionScroll() then
      PaGlobalFunc_HopeGaugeOnOff_ItemCollectionScrollUse(inventoryType, slotNo, itemEnchantWrapper:getGradeType())
    elseif itemEnchantWrapper:isPopupItem() then
      PaGlobal_UseItem_All_PopupItem(itemEnchantWrapper, inventoryType, slotNo, equipSlotNo)
    elseif itemEnchantWrapper:isExchangeItemNPC() or itemWrapper:isSoulCollector() or 17 == itemWrapper:getStaticStatus():getItemType() then
      if nil == PaGlobal_Inventory_All._ui.stc_exchangeButtonBG then
        UI.ASSERT_NAME(nil ~= PaGlobal_Inventory_All._ui.stc_exchangeButtonBG, "PaGlobal_Inventory_All._ui.stc_exchangeButtonBG \237\140\168\235\132\144\236\157\180 \236\151\134\236\138\181\235\139\136\235\139\164.", "\234\185\128\236\157\152\236\167\132")
        return
      end
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(true)
      Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "inventory", false, false)
      local row = math.floor((slotNo - 1) / PaGlobal_Inventory_All.config.slotCols)
      local col = (slotNo - 1) % PaGlobal_Inventory_All.config.slotCols
      local posx = 0
      local posy = 0
      if PaGlobal_Inventory_All_IsCategoryShow() == true then
        posx = PaGlobal_Inventory_All._ui.categorySlotList[index].icon:GetParentPosX() - Panel_Window_Inventory_All:GetParentPosX()
        posy = PaGlobal_Inventory_All._ui.categorySlotList[index].icon:GetParentPosY() - Panel_Window_Inventory_All:GetParentPosY()
      else
        posx = PaGlobal_Inventory_All.slots[index].icon:GetPosX()
        posy = PaGlobal_Inventory_All.slots[index].icon:GetPosY()
      end
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosX(posx - 42)
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosY(posy + 42)
      local _btn_WayPointSizeX = PaGlobal_Inventory_All._ui.btn_waypoint:GetSizeX() + 23
      local _btn_WayPointTextSizeX = _btn_WayPointSizeX - _btn_WayPointSizeX / 2 - PaGlobal_Inventory_All._ui.btn_waypoint:GetTextSizeX() / 2
      local _btn_WidgetSizeX = PaGlobal_Inventory_All._ui.btn_widget:GetSizeX() + 23
      local _btn_WidgetTextSizeX = _btn_WidgetSizeX - _btn_WidgetSizeX / 2 - PaGlobal_Inventory_All._ui.btn_widget:GetTextSizeX() / 2
      PaGlobal_Inventory_All._ui.btn_waypoint:SetTextSpan(_btn_WayPointTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_widget:SetTextSpan(_btn_WidgetTextSizeX, 5)
      PaGlobal_Inventory_All._ui.btn_waypoint:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_waypoint:SetPosY(4)
      PaGlobal_Inventory_All._ui.btn_widget:SetPosX(4)
      PaGlobal_Inventory_All._ui.btn_widget:SetPosY(38)
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetSize(162, 74)
      PaGlobal_Inventory_All._ui.btn_waypoint:SetShow(true)
      PaGlobal_Inventory_All._ui.btn_widget:SetPosY(38)
      local endPosX = PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX() + PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetSizeX()
      if 0 > PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX() then
        PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosX(0)
      elseif endPosX > Panel_Window_Inventory_All:GetSizeX() then
        local gap = endPosX - Panel_Window_Inventory_All:GetSizeX()
        PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetPosX(PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX() - gap)
      end
      if 17 == itemWrapper:getStaticStatus():getItemType() and false == itemEnchantWrapper:isExchangeItemNPC() then
        PaGlobal_Inventory_All._ui.btn_waypoint:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_USELESSITEM_WAYPOINT_BTN"))
        PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_NaviStart()")
      elseif itemWrapper:isSoulCollector() == true and itemWrapper:getStaticStatus():getExchangeItemNPCInfoListCount() == 0 then
        PaGlobal_Inventory_All._ui.btn_waypoint:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WAYPOINT_BTN"))
        PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_LUp", "HandleClicked_NearNpc_NaviStart( " .. CppEnums.SpawnType.eSpawnType_ChangeMarniStone .. ", false )")
      else
        PaGlobal_Inventory_All._ui.btn_waypoint:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INVENTORY_EXCHANGE_WAYPOINT_BTN"))
        PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_FindExchangeItemNPC( " .. slotNo .. " )")
      end
      PaGlobal_Inventory_All._ui.btn_widget:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_ObserveItemCount( " .. slotNo .. " )")
      PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideExchangeBG()")
      PaGlobal_Inventory_All._ui.btn_waypoint:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideExchangeBG()")
      PaGlobal_Inventory_All._ui.btn_widget:addInputEvent("Mouse_Out", "HandleEventOut_Inventory_All_HideExchangeBG()")
    elseif not itemStatic:isUseToVehicle() then
      local function useTradeItem()
        PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
      end
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      if 2 == item_type and true == itemSSW:get():isForJustTrade() then
        local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_CONTENT")
        local messageboxData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRADEITEMUSE_TITLE"),
          content = messageContent,
          functionYes = useTradeItem,
          functionNo = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageboxData)
      else
        if true == itemSSW:get():isEquipable() and false == itemSSW:isUsableServant() and false == PaGlobalFunc_Util_CheckSeasonEquip(itemSSW) then
          PaGlobalFunc_MessageBox_SeasonItem_All_Open()
        end
        local equipType = itemWrapper:getStaticStatus():getEquipType()
        if 16 == equipType or 17 == equipType or 92 == equipType and true == _ContentsGroup_ArtifactItem then
          local accSlotNo
          if true == _ContentsGroup_NewUI_Equipment_All then
            accSlotNo = PaGlobalFunc_Equipment_All_AccSlotNo(itemWrapper, true)
          else
            accSlotNo = FGlobal_AccSlotNo(itemWrapper, true)
          end
          PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, accSlotNo)
          clearOnceMouseOnEvent()
        else
          PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, equipSlotNo)
          clearOnceMouseOnEvent()
        end
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CANT_USEITEM"))
    end
  end
end
function PaGlobal_Inventory_All_NoDragItem()
  local isManufactureOpen = Panel_Window_Manufacture_All:GetShow()
  local isAlchemyOpen = Panel_Window_Alchemy_All:GetShow()
  local isPersonalOpen = Panel_Window_Exchange:IsShow()
  local isUserItemOpen = Panel_UseItem_All:GetShow()
  local isDetectUserOpen = Panel_Window_DetectUser:IsShow()
  local isEnchantOpen = _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true
  if true == isPersonalOpen then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_1"))
    return true
  elseif true == isManufactureOpen then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_2"))
    return true
  elseif true == isAlchemyOpen then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_3"))
    return true
  elseif true == MessageBoxGetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_4"))
    return true
  elseif true == FGlobal_Enchant_SetTargetItem() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_5"))
    return true
  elseif true == isDetectUserOpen then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_6"))
    return true
  elseif PaGlobal_PetRegister_All_GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_7"))
    return true
  elseif true == PaGlobalFunc_RandomBoxSelect_All_GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_8"))
    return true
  elseif true == isUserItemOpen then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_DRAGINFO_MSG_4"))
    return true
  elseif isEnchantOpen == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoEnchantPanelOpen"))
    return true
  end
  return false
end
function HandleEventLUp_Inventory_All_DropHandler(index)
  if nil == DragManager.dragStartPanel then
    return false
  end
  if true == PaGlobal_Inventory_All:isRestricted() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TEXT_CANT_REPOSITIONITEM"))
    return false
  end
  if true == PaGlobal_Inventory_All_NoDragItem() then
    DragManager:clearInfo()
    return true
  end
  local slotNo = -1
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    slotNo = index
  else
    slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  end
  if slotNo == -1 or slotNo == nil then
    return
  end
  if Panel_Window_Inventory_All == DragManager.dragStartPanel then
    if DragManager.dragWhereTypeInfo == Inventory_GetCurrentInventoryType() then
      if DragManager.dragSlotInfo == PaGlobal_Inventory_All._whereUseItemSlotNo then
        PaGlobal_Inventory_All._whereUseItemMoveSlotNo = slotNo
      elseif slotNo == PaGlobal_Inventory_All._whereUseItemSlotNo then
        PaGlobal_Inventory_All._whereUseItemMoveSlotNo = DragManager.dragSlotInfo
      end
      inventory_swapItem(Inventory_GetCurrentInventoryType(), DragManager.dragSlotInfo, slotNo)
    elseif DragManager.dragWhereTypeInfo == CppEnums.ItemWhereType.eFamilyInventory then
      DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey())
    end
    DragManager:clearInfo()
  else
    return DragManager:itemDragMove(CppEnums.MoveItemToType.Type_Player, getSelfPlayer():getActorKey())
  end
  return true
end
function HandleEventPressMove_Inventory_All_SlotDrag(index)
  if nil ~= PaGlobal_Inventory_All._inventoryDragNoUsePanel and PaGlobal_Inventory_All._inventoryDragNoUsePanel:IsShow() then
    return
  end
  if true == PaGlobal_Inventory_All._isMarketOpen then
    return
  end
  if MessageBoxGetShow() then
    return
  end
  if _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true and PaGlobalFunc_MonsterBuffZoneItemRepair_IsShow() == true then
    return
  end
  if true == Panel_Window_Extraction_Caphras_All:GetShow() then
    return
  end
  local slotNo = -1
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    slotNo = index
  else
    slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  end
  if slotNo == -1 or slotNo == nil then
    return
  end
  local whereType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local isEquip = itemSSW:get():isEquipable()
  DragManager:setDragInfo(Panel_Window_Inventory_All, whereType, slotNo, "Icon/" .. itemWrapper:getStaticStatus():getIconPath(), PaGlobalFunc_Inventory_All_GroundClick, getSelfPlayer():getActorKey())
  if itemWrapper:getStaticStatus():get():isItemSkill() or itemWrapper:getStaticStatus():get():isUseToVehicle() or true == isEquip then
    QuickSlot_ShowBackGround()
  end
  Item_Move_Sound(itemWrapper)
end
function HandleEventOnOut_Inventory_All_IconTooltip(isShow, index)
  if PaGlobal_Inventory_All_IsCategoryShow() == true then
    HandleEventOnOut_Inventory_All_CategoryIconTooltip(isShow, index)
    return
  end
  if false == isShow then
    if nil ~= PaGlobal_Inventory_All.slotOverEffect then
      PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.slotOverEffect)
    end
    if PaGlobal_Inventory_All.slots[index]._isLockedItem == true then
      PaGlobal_Inventory_All.slots[index].icon:SetAlpha(0.5)
      PaGlobal_Inventory_All.slots[index].icon:SetMonoTone(true)
      PaGlobal_Inventory_All.slots[index].icon:EraseAllEffect()
    end
    PaGlobal_Inventory_All._tooltipWhereType = nil
    PaGlobal_Inventory_All._tooltipSlotNo = nil
    Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", false, false)
    TooltipSimple_Hide()
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local slotNo = PaGlobal_Inventory_All.slots[index]._slotNo
  if slotNo < PaGlobal_Inventory_All.INVEN_MAX_SLOTNO then
    if nil ~= PaGlobal_Inventory_All.effectScene.searchItem[slotNo] then
      PaGlobal_Inventory_All.searchItemEffectOff[slotNo] = true
      PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.effectScene.searchItem[slotNo])
      PaGlobal_Inventory_All.effectScene.searchItem[slotNo] = nil
    end
    if nil ~= PaGlobal_Inventory_All.effectScene.newItem[slotNo] then
      if PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked() == true then
        PaGlobal_Inventory_All.newItemData[slotNo] = nil
      elseif PaGlobal_Inventory_All._ui.rdo_pearlInven:IsChecked() == true then
        PaGlobal_Inventory_All.newPearlItemData[slotNo] = nil
      elseif PaGlobal_Inventory_All._ui.rdo_enchantMaterialInven:IsChecked() == true then
        PaGlobal_Inventory_All.newEnchantMaterial[slotNo] = nil
      end
      PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.effectScene.newItem[slotNo])
      PaGlobal_Inventory_All.effectScene.newItem[slotNo] = nil
      PaGlobal_Inventory_All:setNewPearlTabEffect()
    end
  end
  if PaGlobal_Inventory_All.slots[index]._isLockedItem == true then
    PaGlobal_Inventory_All.slots[index].icon:SetAlpha(1)
    PaGlobal_Inventory_All.slots[index].icon:SetMonoTone(false)
    PaGlobal_Inventory_All.slots[index].icon:EraseAllEffect()
  end
  local useStartSlot = inventorySlotNoUserStart()
  local invenUseSize = selfPlayer:get():getInventorySlotCount(not PaGlobal_Inventory_All._ui.rdo_normalInven:IsChecked())
  if invenUseSize - useStartSlot - PaGlobal_Inventory_All._startSlotIndex == index then
    local isDye = nil ~= Panel_Widget_Dye_All and Panel_Widget_Dye_All:GetShow()
    if not isGameTypeGT() and _ContentsGroup_EasyBuy and false == isDye then
      local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_NAME")
      local desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ADDINVENTORY_TOOLTIP_DESC")
      local control = PaGlobal_Inventory_All.slots[index].icon
      TooltipSimple_Show(control, name, desc)
      return
    end
  end
  if nil ~= PaGlobal_Inventory_All.slotOverEffect then
    PaGlobal_Inventory_All.slots[index].icon:EraseEffect(PaGlobal_Inventory_All.slotOverEffect)
  end
  PaGlobal_Inventory_All.slotOverEffect = PaGlobal_Inventory_All.slots[index].icon:AddEffect("UI_Inventory_EmptySlot", false, 0, 0)
  PaGlobal_Inventory_All._tooltipWhereType = Inventory_GetCurrentInventoryType()
  PaGlobal_Inventory_All._tooltipSlotNo = slotNo
  Panel_Tooltip_Item_Show_GeneralNormal(index, "inventory", true, false)
end
function HandleEventLUp_Inventory_All_OpenManufacture(slotNo)
  if nil ~= Panel_Window_Manufacture_All and Panel_Window_Manufacture_All:GetShow() then
    return
  end
  if not IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_MANUFACTURE"))
    return
  end
  if 0 ~= ToClient_GetMyTeamNoRedBattleField() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_LOCALWAR_ALERT"))
    return
  end
  PaGlobalFunc_Manufacture_All_Open(nil, CppEnums.ItemWhereType.eInventory, true)
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutManufactreBG = true
end
function HandleEventLUp_Inventory_All_OpenProductNote(itemKey)
  ProductNote_Item_ShowToggle(itemKey)
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutManufactreBG = true
end
function HandleEventOut_Inventory_All_HideManufactureBG()
  if true == PaGlobal_Inventory_All._clickOutManufactreBG then
    PaGlobal_Inventory_All._clickOutManufactreBG = false
    return
  end
  local invenPosX = Panel_Window_Inventory_All:GetPosX()
  local invenPosY = Panel_Window_Inventory_All:GetPosY()
  if true == Panel_Window_Inventory_All:IsUISubApp() then
    invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
  end
  local panelPosX = invenPosX + PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosX()
  local panelPosY = invenPosY + PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetPosY()
  local panelSizeX = PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetSizeX()
  local panelSizeY = PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:GetSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if panelPosX <= mousePosX and mousePosX <= panelPosX + panelSizeX and panelPosY <= mousePosY and mousePosY <= panelPosY + panelSizeY then
    return
  end
  PaGlobal_Inventory_All._ui.stc_manufactureButtonBG:SetShow(false)
end
function HandleEventLUp_Inventory_All_NaviStart()
  HandleClicked_TownNpcIcon_NaviStart(16, false)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutExchangeBG = true
end
function HandleEventLUp_Inventory_All_FindExchangeItemNPC(slotNo)
  PaGlobal_Inventory_All:findExchangeItemNPCbySlotNo(slotNo)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutExchangeBG = true
end
function HandleEventLUp_Inventory_All_ObserveItemCount(slotNo)
  local inventoryType = Inventory_GetCurrentInventoryType()
  local itemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == itemWrapper then
    PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  PaGlobal_Inventory_All._whereUseItemSlotNo = slotNo
  PaGlobal_Inventory_All._whereUseItemSSW = itemSSW
  FGlobal_WhereUseITemDirectionOpen(itemSSW, slotNo)
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
  PaGlobal_Inventory_All._clickOutExchangeBG = true
end
function HandleEventOut_Inventory_All_HideExchangeBG()
  if true == PaGlobal_Inventory_All._clickOutExchangeBG then
    PaGlobal_Inventory_All._clickOutExchangeBG = false
    return
  end
  local invenPosX = Panel_Window_Inventory_All:GetPosX()
  local invenPosY = Panel_Window_Inventory_All:GetPosY()
  if true == Panel_Window_Inventory_All:IsUISubApp() then
    invenPosX = Panel_Window_Inventory_All:GetScreenParentPosX()
    invenPosY = Panel_Window_Inventory_All:GetScreenParentPosY()
  end
  local panelPosX = invenPosX + PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosX()
  local panelPosY = invenPosY + PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetPosY()
  local panelSizeX = PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetSizeX()
  local panelSizeY = PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:GetSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if panelPosX <= mousePosX and mousePosX <= panelPosX + panelSizeX and panelPosY <= mousePosY and mousePosY <= panelPosY + panelSizeY then
    return
  end
  PaGlobal_Inventory_All._ui.stc_exchangeButtonBG:SetShow(false)
end
function HandleEventLUp_Inventory_All_SellAllEtcItem()
  local messageTitle = PAGetString(Defines.StringSheet_GAME, "LUA_NPCSHOP_SELL_ALERT_2")
  local messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_SEllATONCE_CAUTION_MSG")
  local messageboxData = {
    title = messageTitle,
    content = messageContent,
    functionYes = PaGlobalFunc_NPCShop_ALL_SellAllEtcItem,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventOnOut_Inventory_All_SearchResetTooltip(isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local uiControl = PaGlobal_Inventory_All._ui.btn_searchReset
  if nil == uiControl then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TOOLTIP_SEARCHRESET")
  local desc = ""
  TooltipSimple_Show(uiControl, name, desc)
end
function HandleEventLUp_Inventory_All_ItemDeleteMode()
  local self = PaGlobal_Inventory_All
  if DragManager:isDragging() == true then
    self:deleteMode_setShow(false)
    return
  end
  if (self.otherWindowOpenFunc ~= nil or self.rClickFunc ~= nil or self.filterFunc ~= nil or self.effect ~= nil) and self._isDeleteMode == false then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_MSG_DISABLE"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    self._ui.chk_trash:SetCheck(false)
    self._ui.btn_bottom_Trash:SetCheck(false)
    return
  end
  if Inventory_GetCurrentInventoryType() ~= CppEnums.ItemWhereType.eInventory then
    if true == _ContentsGroup_RestoreItem then
      PaGlobalFunc_Restore_All_Open()
    end
    self:deleteMode_setShow(false)
    return
  end
  self:deleteMode_toggleShow()
end
function HandleEventLUp_Inventory_All_LUpEvent(index)
  if PaGlobal_Inventory_All:isDeleteMode() == true then
    HandleEventLUp_Inventory_All_RegisterDeleteItem(index)
  else
    HandleEventLUp_Inventory_All_DropHandler(index)
  end
end
function HandleEventRUp_Inventory_All_RUpEvent(index)
  if PaGlobal_Inventory_All:isDeleteMode() == true then
    HandleEventLUp_Inventory_All_UnRegisterDeleteItem(index)
  else
    HandleEventRUp_Inventory_All_SlotRClick(index)
  end
end
function HandleEventPressMove_Inventory_All_PressMoveEvent(index)
  if PaGlobal_Inventory_All:isDeleteMode() == true then
    return
  end
  HandleEventPressMove_Inventory_All_SlotDrag(index)
end
function HandleEventLUp_Inventory_All_RegisterDeleteItem(index)
  if Panel_Window_NumberPad_All:GetShow() == true then
    return
  end
  PaGlobal_Inventory_All:deleteMode_registerItem(index)
end
function HandleEventLUp_Inventory_All_UnRegisterDeleteItem(index)
  if Panel_Window_NumberPad_All:GetShow() == true then
    return
  end
  PaGlobal_Inventory_All:deleteMode_unregisterItem(index)
end
function HandleEventLUp_Inventory_All_RequestDeleteItemList()
  if PaGlobal_Inventory_All._deleteItemListCount == 0 and Panel_Window_TrashBoxConfirm_All:GetShow() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_NOITEM"))
    return
  end
  PaGlobalFunc_TrashBoxConfirm_All_Open(PaGlobal_TrashBoxMode.InventoryMode)
end
function HandleEventLUp_Inventory_All_OpenRestorePanel()
  if _ContentsGroup_RestoreItem == false then
    return
  end
  PaGlobalFunc_Restore_All_Open()
end
function HandleEventLUp_Inventory_All_BuyFamilyInvenSlot()
  PaGlobalFunc_EasyBuy_Open(87)
end
function HandleEventLUp_Inventory_All_FamilyInvenQuest()
  if true == Panel_Window_Quest_All:GetShow() then
    PaGlobalFunc_Quest_All_Close()
  else
    HandleEventLUp_Quest_All_SetTabMenu(3)
    PaGlobalFunc_Quest_All_Open()
  end
end
function HandleClicked_NearNpc_NaviStart(spawnType, isAuto)
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if nil == isAuto then
    isAuto = false
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ToClient_DeleteNaviGuideByGroup(0)
  _spawnType = spawnType
  local position = player:get3DPos()
  local nearNpcInfo = getNearNpcInfoByType(spawnType, position)
  if nil == nearNpcInfo then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if false == curChannelData._isMain and CppEnums.SpawnType.eSpawnType_TerritoryTrade == spawnType then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_TOWNNPCNAVI_IMPERIAL_DELIVERY_ONLY_FIRSTCH"))
    return
  end
  local isSpawnNearNpc = nearNpcInfo:isTimeSpawn()
  local pos = nearNpcInfo:getPosition()
  local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), isAuto, isAuto)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  local selfPlayer = getSelfPlayer():get()
  selfPlayer:setNavigationMovePath(npcNaviKey)
  selfPlayer:checkNaviPathUI(npcNaviKey)
  if false == isSpawnNearNpc then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
  end
  PaGlobal_TutorialManager:handleClickedTownNpcIconNaviStart(spawnType, isAuto)
end
function HandleClicked_Inventory_All_UseMultiBoxes()
  Panel_NumberPad_Show(true, PaGlobal_Inventory_All._multiUseCount_s64, PaGlobal_Inventory_All._multiUseInventoryType, HandleEvent_Inventory_All_UseMultiItems, false, PaGlobal_Inventory_All._multiUseSlotNo, false, nil, nil)
end
function HandleEvent_Inventory_All_UseMultiItems(count, inventoryType, slotNo)
  if Int64toInt32(count) <= 0 then
    return
  end
  ToClient_SetMultiUseItemCount(count)
  PaGlobalFunc_Inventory_All_UseItemTargetSelf(inventoryType, slotNo, nil)
  ToClient_SetMultiUseItemCount(1)
  PaGlobal_Inventory_All._multiUseCount_s64 = Defines.s64_const.s64_0
  PaGlobal_Inventory_All._multiUseInventoryType = nil
  PaGlobal_Inventory_All._multiUseSlotNo = nil
end
