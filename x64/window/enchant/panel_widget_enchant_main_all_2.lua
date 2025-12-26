function PaGlobalFunc_EnchantMain_All_Open()
  if Panel_Widget_Enchant_Main_All == nil or Panel_Widget_Enchant_Main_All:GetShow() == true then
    return
  end
  PaGlobal_EnchantMain_All:prepareOpen()
end
function PaGlobalFunc_EnchantMain_All_Close()
  if Panel_Widget_Enchant_Main_All == nil or Panel_Widget_Enchant_Main_All:GetShow() == false then
    return
  end
  local isCloseCanceledByGroupEnchant = PaGlobal_EnchantMain_All:handleGroupEnchantClose()
  if isCloseCanceledByGroupEnchant == true then
    return
  end
  PaGlobal_EnchantMain_All:prepareClose()
end
function FromClient_UpdateEnchantMain()
  if Panel_Widget_Enchant_Main_All == nil then
    return
  end
  PaGlobal_EnchantMain_All:update()
end
function PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()
  if Panel_Widget_Enchant_Main_All == nil then
    return
  end
  if PaGlobal_EnchantMain_All:isAnimating() == true then
    return
  end
  if ToClient_GetIsReadyGroupEnchant() == true then
    return
  end
  PaGlobal_EnchantMain_All:clearEnchantTarget()
end
function PaGlobalFunc_EnchantMain_All_ClearProtector()
  if Panel_Widget_Enchant_Main_All == nil then
    return
  end
  if PaGlobal_EnchantMain_All:isAnimating() == true then
    return
  end
  if ToClient_GetIsReadyGroupEnchant() == true then
    return
  end
  PaGlobal_EnchantMain_All:clearProtector()
end
function HandleEventOn_EnchantMain_TargetSlot(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, ToClient_GetCurrentEnchantTarget(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    Panel_Tooltip_Item_Show_GeneralNormal(0, "Enchant", isShow, false)
  end
end
function HandleEventOn_EnchantMain_MaterialSlot(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      if ToClient_IsCurrentEnchantMaterialSetted() == true then
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, ToClient_GetCurrentEnchantMaterial(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetNeedMaterialItemStaticStatus(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      end
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    if isShow == false or ToClient_IsCurrentEnchantTargetSetted() == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    if ToClient_IsCurrentEnchantMaterialSetted() == true then
      Panel_Tooltip_Item_Show(ToClient_GetCurrentEnchantMaterial(), PaGlobal_EnchantMain_All._slotMaterial.icon, false, true)
    else
      Panel_Tooltip_Item_Show(ToClient_GetNeedMaterialItemStaticStatus(), PaGlobal_EnchantMain_All._slotMaterial.icon, true, false)
    end
  end
end
function HandleEventOn_EnchantMain_ProtectorSlot(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      if ToClient_IsCurrentProtectorSetted() == true then
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetCurrentProtectorForLua(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetCronStoneStaticStatus(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      end
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    if isShow == false or ToClient_IsCurrentEnchantTargetSetted() == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    if ToClient_IsCurrentProtectorSetted() == true then
      Panel_Tooltip_Item_Show(ToClient_GetCurrentProtectorForLua(), PaGlobal_EnchantMain_All._slotProtector.icon, true, false)
    else
      Panel_Tooltip_Item_Show(ToClient_GetCronStoneStaticStatus(), PaGlobal_EnchantMain_All._slotProtector.icon, true, false)
    end
  end
end
function HandleEventOn_EnchantMain_SlotCaphrasTarget(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, ToClient_GetCurrentEnchantTarget(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    if isShow == false or ToClient_IsCurrentEnchantTargetSetted() == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    Panel_Tooltip_Item_Show(ToClient_GetCurrentEnchantTarget(), PaGlobal_EnchantMain_All._slotCaphrasTarget.icon, false, true)
  end
end
function HandleEventOn_EnchantMain_SlotCaphrasNext(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      if ToClient_IsTargetCaphrasPromotable() == true then
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, ToClient_GetNextLevelTargetItemForLua(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      else
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, ToClient_GetCurrentEnchantTarget(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      end
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    if isShow == false or ToClient_IsCurrentEnchantTargetSetted() == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    if ToClient_IsTargetCaphrasPromotable() == true then
      Panel_Tooltip_Item_Show(ToClient_GetNextLevelTargetItemForLua(), PaGlobal_EnchantMain_All._slotCaphrasNext.icon, true, false)
    else
      Panel_Tooltip_Item_Show(ToClient_GetCurrentEnchantTarget(), PaGlobal_EnchantMain_All._slotCaphrasNext.icon, false, true)
    end
  end
end
function HandleEventOn_EnchantMain_slotTuvala(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      local enchantTarget = ToClient_GetCurrentEnchantTarget()
      if enchantTarget ~= nil then
        local tuvalaItemKey = ToClient_getTubalaItemForNaruItemEnchantKey(enchantTarget:getStaticStatus():get()._key)
        local tuvalaItemSSW = getItemEnchantStaticStatus(tuvalaItemKey)
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, tuvalaItemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      end
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == false or ToClient_IsCurrentEnchantTargetChangableToTuvala() == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    local enchantTarget = ToClient_GetCurrentEnchantTarget()
    if enchantTarget ~= nil then
      local tuvalaItemKey = ToClient_getTubalaItemForNaruItemEnchantKey(enchantTarget:getStaticStatus():get()._key)
      local tuvalaItemSSW = getItemEnchantStaticStatus(tuvalaItemKey)
      Panel_Tooltip_Item_Show(tuvalaItemSSW, PaGlobal_EnchantMain_All._slotTuvala.icon, true, false)
    end
  end
end
function HandleEventLUp_EnchantMain_OtherMaterial()
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if ToClient_IsCurrentEnchantTargetSetted() == false then
    return
  end
  if ToClient_IsSafeLowProtectorSetted() == true then
    return
  end
  if ToClient_GetEnchantMaterialListSize() == 0 then
    return
  end
  PaGlobalFunc_EnchantMaterial_All_Open()
end
function HandleEventLUp_EnchantMain_ProtectorSelect()
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if ToClient_IsCurrentEnchantTargetSetted() == false then
    return
  end
  if ToClient_GetProtectorListSize() == 0 then
    return
  end
  PaGlobalFunc_EnchantProtector_All_Open()
end
function HandleEventLUp_EnchantMain_SetCurrentEnchantType(enchantType)
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  ToClient_SetCurrentEnchantType(enchantType)
end
function HandleEventLUp_EnchantMain_TogglePerfectButton()
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if PaGlobal_EnchantMain_All._ui.btn_perfectEnchant:IsCheck() == true then
    ToClient_SetCurrentEnchantType(__eEnchantType_Perfect)
  else
    ToClient_SetCurrentEnchantType(__eEnchantType_Normal)
  end
end
function HandleEventLUp_EnchantMain_StartButton()
  PaGlobal_EnchantMain_All:pressStartButton(false)
end
function HandleEventLUp_EnchantMain_StartCronButton()
  PaGlobal_EnchantMain_All:pressStartButton(true)
end
function HandleEventOnOut_EnchantMain_GuaranteeStackTooltip(isShow)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ANVILOFANCIENT_TOOLTIP_NAME")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_ANVILOFANCIENT_TOOLTIP_DESC")
  TooltipSimple_Show(PaGlobal_EnchantMain_All._ui.stc_agrisProgress, name, desc)
end
function PaGlobal_EnchantMain_All_UpdateFunc(deltaTime)
  PaGlobal_EnchantMain_All:checkNaderrCooltime(deltaTime)
  PaGlobal_EnchantMain_All:checkAnimation(deltaTime)
  PaGlobal_EnchantMain_All:checkNakMessage(deltaTime)
end
function FromClient_ResponseEnchant(enchantResponseType, param0, param1)
  PaGlobal_EnchantMain_All:responseEnchant(enchantResponseType, param0, param1)
end
function HandleEventLUp_EnchantMain_StackSelect()
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  PaGlobalFunc_EnchantStack_All_Open(nil)
end
function HandleEventLUp_EnchantMain_SelectNaderrSlot(index)
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  PaGlobal_EnchantMain_All:selectNaderrSlot(index)
end
function HandleEvent_EnchantMain_HoverNaderrSlot(isHover, index)
  PaGlobal_EnchantMain_All:hoverNaderrSlot(isHover, index)
end
function HandleEventLUp_EnchantMain_ChangeNaderrPage(changePage)
  PaGlobal_EnchantMain_All:changeNaderrPage(changePage)
end
function PaGlobal_EnchantMain_All_IsAnimating()
  return PaGlobal_EnchantMain_All:isAnimating()
end
function HandleEventLUp_EnchantMain_Inventory()
  if _ContentsGroup_RenewUI_Inventory == false then
    if Panel_Window_Inventory_All:GetShow() == true then
      PaGlobalFunc_Inventory_All_CloseWithSpiritEnchant()
    else
      PaGlobalFunc_Inventory_All_OpenWithSpiritEnchant(nil, nil, nil, nil, true)
    end
  else
    PaGlobalFunc_InventoryInfo_Open(1, false, 0, false)
  end
end
function HandleEventLUp_EnchantMain_TuvalaButton()
  ToClient_RequestExchangeToTuvala()
end
function PaGlobal_EnchantMain_All_CheckIsDuelItem()
  PaGlobal_EnchantMain_All:checkIsDuelItem()
end
function FromClient_StrartGroupEnchantRemasterAni()
  PaGlobal_EnchantMain_All:startGroupEnchantRemasterAni()
end
function PaGlobal_Enchant_All_RClickInventory(slotNo, itemWrapper, count, inventoryType)
  return
end
function HandleEventOnOut_Enchant_All_Tooltip(tooltipType, isShow)
  PaGlobal_EnchantMain_All:handleTooltip(tooltipType, isShow)
end
function FromClient_SetEnchantTarget()
  PaGlobal_EnchantMain_All:checkAndOpenMaterialList()
end
function HandleEventLUp_EnchantMain_ToggleSkipAnimation(isLsClick)
  PaGlobal_EnchantMain_All:toggleSkipAnimation(isLsClick)
end
function PaGlobal_EnchantMain_All_StartAudio(audioIndex)
  PaGlobal_EnchantMain_All:startAudio(audioIndex)
end
function HandleEventLUp_EnchantMain_ReadyGroupEnchant(isProtectorEnchant)
  if isProtectorEnchant == true and ToClient_GetEnchantButtonType(true, false) == __eEnchantButtonType_ProtectorList then
    HandleEventLUp_EnchantMain_ProtectorSelect()
    return
  end
  ToClient_SetProtectorEnchant(isProtectorEnchant)
  ToClient_RequestReadyGroupEnchant()
end
function HandleEventLUp_EnchantMain_OthersChoice()
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if PaGlobal_EnchantMain_All._isConsole == false then
    if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eShowOtherUserEnchantAdditionalRate) == false then
      ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, true, CppEnums.VariableStorageType.eVariableStorageType_User)
      PaGlobal_EnchantMain_All._ui.btn_othersChoice:EraseAllEffect()
      PaGlobal_EnchantStack_All._ui.btn_othersChoice:EraseAllEffect()
    else
      local showOtherUserEnchantAdditionalRate = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate)
      PaGlobal_EnchantMain_All._ui.btn_othersChoice:EraseAllEffect()
      PaGlobal_EnchantStack_All._ui.btn_othersChoice:EraseAllEffect()
      if showOtherUserEnchantAdditionalRate == true then
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, false, CppEnums.VariableStorageType.eVariableStorageType_User)
        PaGlobal_EnchantMain_All._ui.btn_othersChoice:AddEffect("FUI_StackUserInfo_Button_01B", true, 0, 0)
        PaGlobal_EnchantStack_All._ui.btn_othersChoice:AddEffect("FUI_StackUserInfo_Button_01A", true, 0, 0)
      else
        ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate, true, CppEnums.VariableStorageType.eVariableStorageType_User)
      end
    end
  end
  if Panel_OtherUser_AdditionalRate_All:GetShow() == true then
    PaGlobalFunc_OtherUser_TriedStack_Close()
    return
  end
  ToClient_RequestOthersChoice()
end
function PaGlobalFunc_EnchantMain_HandleOthersChoiceTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_EnchantMain_All._ui.btn_othersChoice
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function PaGlobalFunc_EnchantMain_UpdateEnchantTargetList()
  if Panel_Widget_Enchant_Main_All == nil then
    return
  end
  if Panel_Widget_Enchant_Main_All:GetShow() == false then
    return
  end
  ToClient_UpdateEnchantTargetList()
  ToClient_UpdateEnchantMaterialList()
  FromClient_UpdateEnchantMain()
end
