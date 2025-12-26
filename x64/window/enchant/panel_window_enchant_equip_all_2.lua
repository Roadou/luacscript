function PaGlobalFunc_EnchantEquip_All_Open()
  if Panel_Window_Enchant_Equip_All == nil or Panel_Window_Enchant_Equip_All:GetShow() == true then
    return
  end
  PaGlobal_EnchantEquip_All:prepareOpen()
end
function PaGlobalFunc_EnchantEquip_All_Close()
  if Panel_Window_Enchant_Equip_All == nil or Panel_Window_Enchant_Equip_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantEquip_All:prepareClose()
end
function FromClient_UpdateEnchantEquip()
  if Panel_Window_Enchant_Equip_All == nil or Panel_Window_Enchant_Equip_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantEquip_All:update()
end
function HandleEventRUp_EnchantEquip_Slot(index)
  local itemWrapper = ToClient_GetEnchantTargetByIndex(index - 1)
  if itemWrapper == nil then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if itemStatic == nil then
    return
  end
  audioPostEvent_SystemItem(itemStatic._itemMaterial)
  ToClient_SetCurrentEnchantTarget(index - 1)
end
function HandleEventOn_EnchantEquip_Slot(index, isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      local itemWrapper = ToClient_GetEnchantTargetByIndex(index - 1)
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    Panel_Tooltip_Item_Show_GeneralNormal(index, "EnchantEquip", isShow, false)
    Panel_Tooltip_Item_Set_Position(PaGlobal_EnchantEquip_All._ui.frame_content, true, true)
  end
end
function HandleEventLUp_EnchantEquip_SetItemSlots()
  PaGlobal_EnchantEquip_All:setItemSlots()
end
function HandleEventLUp_EnchantEquip_ChangeInventoryType(inventoryType)
  PaGlobal_EnchantEquip_All:changeInventoryType(inventoryType)
end
