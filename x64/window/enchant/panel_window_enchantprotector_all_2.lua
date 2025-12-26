function PaGlobalFunc_EnchantProtector_All_Open()
  if Panel_Window_EnchantProtector_All == nil or Panel_Window_EnchantProtector_All:GetShow() == true then
    return
  end
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if ToClient_GetIsReadyGroupEnchant() == true then
    return
  end
  PaGlobal_EnchantProtector_All:prepareOpen()
end
function PaGlobalFunc_EnchantProtector_All_Close()
  if Panel_Window_EnchantProtector_All == nil or Panel_Window_EnchantProtector_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantProtector_All:prepareClose()
end
function PaGlobalFunc_EnchantProtector_All_Apply()
  if Panel_Window_EnchantProtector_All == nil or Panel_Window_EnchantProtector_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantProtector_All:apply()
  PaGlobal_EnchantProtector_All:prepareClose()
end
function FromClient_UpdateProtector()
  if Panel_Window_EnchantProtector_All == nil or Panel_Window_EnchantProtector_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantProtector_All:update()
end
function PaGlobal_EnchantProtector_CreateContent(content, key)
  PaGlobal_EnchantProtector_All:createContent(content, key)
end
function HandleEventOn_EnchantProtector_Slot(index, isShow)
  Panel_Tooltip_Item_Show_GeneralStatic(index, "Protector", isShow, false)
end
function HandleEventOn_EnchantProtector_SelectIndex(index)
  PaGlobal_EnchantProtector_All:selectIndex(index)
end
