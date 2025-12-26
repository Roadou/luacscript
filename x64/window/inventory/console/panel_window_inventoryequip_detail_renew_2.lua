function PaGlobal_InventoryEquip_Detail_Renew_Open()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(false)
end
function PaGlobal_InventoryEquip_Detail_Renew_Open_BySimpleInventory()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(true)
end
function PaGlobal_InventoryEquip_Detail_Renew_Open_ByJewelPreset()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareOpen(false, true)
end
function PaGlobal_InventoryEquip_Detail_Renew_Close()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  PaGlobal_InventoryEquip_Detail_Renew:prepareClose()
end
function FromClient_InventoryEquip_Detail_Renew_EquipmentChanged()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  if _ContentsGroup_JewelPreset == true then
    PaGlobal_InventoryEquip_Detail_Renew:update()
  else
    PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
  end
end
function HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedCrystals()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  if _ContentsGroup_JewelPreset == true then
    PaGlobal_InventoryEquip_Detail_Renew:update()
  else
    PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
  end
end
function HandleEventOn_InventoryEquip_Detail_Renew_UpdateEquippedSet()
  if nil == Panel_Window_Inventory_Detail then
    return
  end
  if _ContentsGroup_JewelPreset == true then
    PaGlobal_InventoryEquip_Detail_Renew:update()
  else
    PaGlobal_InventoryEquip_Detail_Renew:updateEquippedCrystals()
  end
end
