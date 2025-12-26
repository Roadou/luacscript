PaGlobal_InventoryEquip_Detail_Renew = {
  _ui = {
    frame_information = nil,
    frame_content = nil,
    frame_vScroll = nil,
    chk_crystal = nil,
    stc_crystal_template = nil,
    chk_equipset = nil,
    stc_equipset_template = nil,
    chk_artifact = nil,
    stc_artifactBg = nil,
    crystalGroup = {},
    setEffectGroup = {}
  },
  slotConfig_Crystal = {createIcon = true, createBorder = false},
  _tooltipOrderTable = {
    __eJewelSpecialSlotNecklace,
    __eJewelSpecialSlotRing1,
    __eJewelSpecialSlotRing2,
    __eJewelSpecialSlotEaring1,
    __eJewelSpecialSlotEaring2,
    __eJewelSpecialSlotBelt,
    __eJewelSpecialSlot1MorningLand,
    __eJewelSpecialSlot2MorningLand,
    __eJewelSpecialSlotAwakenWeapon1,
    __eEquipSlotNoRightHand,
    __eJewelSpecialSlotAwakenWeapon2,
    __eEquipSlotNoLeftHand,
    __eEquipSlotNoSubTool,
    __eEquipSlotNoChest,
    __eEquipSlotNoGlove,
    __eEquipSlotNoBoots,
    __eEquipSlotNoAvatarChest,
    __eEquipSlotNoHelm,
    __eEquipSlotNoNecklace,
    __eEquipSlotNoRing1,
    __eEquipSlotNoRing2,
    __eEquipSlotNoEaring1,
    __eEquipSlotNoEaring2
  },
  _listJewelGroup = {},
  _listJewelGroupSize = 0,
  _usingJewelGroupUICount = 0,
  _listJewel = {},
  _listJewelSize = 0,
  _usingJewelUICount = 0,
  _artifactListEquip = {},
  _isSimpleInventory = false,
  _originPanelSizeY = 790,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Detail_Renew_1.lua")
runLua("UI_Data/Script/Window/Inventory/Console/Panel_Window_InventoryEquip_Detail_Renew_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InventoryEquip_Detail_Renew_Init")
function FromClient_InventoryEquip_Detail_Renew_Init()
  PaGlobal_InventoryEquip_Detail_Renew:initialize()
end
