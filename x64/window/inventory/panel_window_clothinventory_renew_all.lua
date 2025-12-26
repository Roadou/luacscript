PaGlobal_ClothInventory_Renew_All = {
  _ui = {
    _stc_titleBg = nil,
    _btn_close = nil,
    _stc_bg = nil,
    _slotBg = {},
    _slot = {},
    _txt_desc = nil,
    _btn_changeAll = nil,
    _stc_keyguideBg = nil,
    _txt_tooltip = nil
  },
  _config = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createMaidActorOnly = true,
    createEnduranceIcon = true
  },
  _currSlotInfo = {
    index = nil,
    fromSlotNo = nil,
    fromWhereType = nil
  },
  _bagType = nil,
  _bagSize = nil,
  _fromWhereType = nil,
  _fromSlotNo = nil,
  _inventoryBagType = nil,
  _slotColCount = nil,
  _slotBg = {},
  _slot = {},
  _slotNoIdToString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BODY"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HANDS"),
    [2] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_BOOTS"),
    [3] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_HELM"),
    [4] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_MAIN"),
    [5] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_SUB"),
    [6] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AVATAR_UNDERWEAR"),
    [7] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_avatarAwakenWeapon")
  },
  _isPadSnapping = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_Renew_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_Renew_All_2.lua")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_ClothInventory_Renew_All_Init")
function FromClient_ClothInventory_Renew_All_Init()
  PaGlobal_ClothInventory_Renew_All:initialize()
end
