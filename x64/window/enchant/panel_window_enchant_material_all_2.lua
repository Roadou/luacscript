function PaGlobalFunc_EnchantMaterial_All_Open()
  if Panel_Window_Enchant_Material_All == nil or Panel_Window_Enchant_Material_All:GetShow() == true then
    return
  end
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if ToClient_GetIsReadyGroupEnchant() == true then
    return
  end
  PaGlobal_EnchantMaterial_All:prepareOpen()
end
function PaGlobalFunc_EnchantMaterial_All_Close()
  if Panel_Window_Enchant_Material_All == nil or Panel_Window_Enchant_Material_All:GetShow() == false then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_EnchantMaterial_All:prepareClose()
end
function PaGlobal_EnchantMaterial_All_CreateListControl(control, key)
  PaGlobal_EnchantMaterial_All:createListControl(control, key)
end
function PaGlobalFunc_EnchantMaterial_All_Apply()
  PaGlobal_EnchantMaterial_All:apply()
end
function HandleEventOn_EnchantMaterial_SelectIndex(index)
  PaGlobal_EnchantMaterial_All:selectIndex(index)
end
function FromClient_UpdateEnchantMaterial()
  PaGlobal_EnchantMaterial_All:update()
end
function HandleEventOn_EnchantMaterial_Slot(index, isShow)
  Panel_Tooltip_Item_Show_GeneralStatic(index, "Enchant", isShow, false)
end
