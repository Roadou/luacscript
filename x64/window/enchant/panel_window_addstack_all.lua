PaGlobal_AddStack_All = {
  _ui = {
    _stc_TitleBar = nil,
    _stc_CloseIcon = nil,
    _stc_mainBG = nil,
    _stc_ItemList = nil,
    _btn_DespairCrystal = nil,
    _stc_DespairCrystalName = nil,
    _stc_DespairCrystalCount = nil,
    _stc_DespairCrystalSelect = nil,
    _btn_StoneWeapon = nil,
    _stc_StoneWeaponName = nil,
    _stc_StoneWeaponCount = nil,
    _stc_StoneWeaponSelect = nil,
    _btn_ValksScroll = nil,
    _stc_ValksScrollSName = nil,
    _stc_ValksScrollCount = nil,
    _stc_ValksScrollSelect = nil,
    _stc_ItemListConsume = nil,
    _btn_Consume = nil,
    _stc_ConsumeItemName = nil,
    _stc_ConsumeItemCount = nil,
    _stc_ConsumeSelect = nil,
    _stc_mainValksBG = nil,
    _stc_ItemListValks = nil,
    _btn_ValksNormal = nil,
    _stc_ValksName = nil,
    _stc_ValksCount = nil,
    _stc_Valksselect = nil,
    _btn_ValksEvent = nil,
    _stc_ValksEventName = nil,
    _stc_ValksEventCount = nil,
    _stc_ValksEventSelect = nil,
    _stc_valueBG = nil,
    _stc_stackValue = nil,
    _stc_stackRate = nil,
    _stc_consumeRateBG = nil,
    _stc_consumeRate = nil,
    _stc_ApplyBG = nil,
    _btn_Apply = nil,
    _stc_subSelectBG = nil,
    _stc_titleBG = nil,
    _stc_title = nil,
    _btn_selectListClose = nil,
    _list2_selectList = nil,
    _stc_ValksIconDummy = nil,
    _stc_ValksEventIconDummy = nil,
    _stc_StoneWeaponIconDummy = nil,
    _stc_ValksScrollIconDummy = nil,
    _stc_ConsumeIconDummy = nil,
    _stc_DespairCrystalIconDummy = nil
  },
  _STACK_ITEM_TYPE = {
    _ITEM_TYPE_VALKS = 0,
    _ITEM_TYPE_VALKS_EVENT = 1,
    _ITEM_TYPE_BLACKSTONE_WEAPON = 2,
    _ITEM_TYPE_BLACKSTONE_ARMO = 3,
    _ITEM_TYPE_VALKS_SCROLL = 4,
    _ITEM_TYPE_CONSUME = 5,
    _ITEM_TYPE_DESPAIRCRYSTAL = 6,
    _COUNT = 7
  },
  _STACK_ITEM_KEY = {
    [0] = 17643,
    [1] = 17900,
    [2] = 16001,
    [3] = 16002,
    [4] = 17800,
    [5] = 0,
    [6] = 8411
  },
  _ITEM_WHERETYPE = {
    [0] = CppEnums.ItemWhereType.eCashInventory,
    [1] = CppEnums.ItemWhereType.eInventory,
    [2] = CppEnums.ItemWhereType.eInventory,
    [3] = CppEnums.ItemWhereType.eInventory,
    [4] = CppEnums.ItemWhereType.eCashInventory,
    [5] = CppEnums.ItemWhereType.eInventory,
    [6] = CppEnums.ItemWhereType.eInventory
  },
  _BG_TYPE = {
    _BG_VALKS = 0,
    _BG_BLACKSTONE = 1,
    _BG_COUNT = 2
  },
  _INVENTORY_SLOT_CONFIG = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = false
  },
  _slotIconList = {},
  _currentBgType = nil,
  _currentUiInfo = nil,
  _isDespairCrystalClosed = false,
  _listSnappingUpdate = false,
  _initialize = false,
  _valksIndex = 0
}
runLua("UI_Data/Script/Window/Enchant/Panel_Window_AddStack_All_1.lua")
runLua("UI_Data/Script/Window/Enchant/Panel_Window_AddStack_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AddStack_AllInit")
function FromClient_AddStack_AllInit()
  PaGlobal_AddStack_All:initialize()
end
