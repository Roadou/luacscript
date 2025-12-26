PaGlobal_AbyssOne_Inventory_All = {
  _ui = {
    stc_MainBg = nil,
    stc_InvenBg = nil,
    stc_mainSlotBG = nil,
    scroll_inven = nil,
    template_slotBG = nil,
    template_slot = nil
  },
  slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCooltimeText = true,
    createCash = true,
    createMaidActorOnly = true,
    createItemLock = true,
    createBagIcon = true,
    createSoulComplete = true,
    isTranslation = true
  },
  config = {
    slotCount = 81,
    slotCols = 9,
    slotRows = 0,
    slotStartX = 430,
    slotStartY = 126,
    slotGapX = 54,
    slotGapY = 54,
    slotEnchantX = 13,
    slotEnchantY = 76
  },
  _filterFunc = nil,
  _rClickFunc = nil,
  _otherWindowOpenFunc = nil,
  _effect = nil,
  _slotsBackground = Array.new(),
  slots = Array.new(),
  _defaultPosX = 0,
  _defaultPosY = 0,
  _defaultSizeY = 0,
  _startSlotIndex = 0,
  INVEN_MAX_COUNT = 192,
  INVEN_MAX_SLOTNO = 194,
  INVEN_CURRENTSLOT_COUNT = 81,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Panel_AbyssOne_Inventory_All_1.lua")
runLua("UI_Data/Script/AbyssOne/Panel_AbyssOne_Inventory_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOne_Inventory_All")
function FromClient_AbyssOne_Inventory_All()
  PaGlobal_AbyssOne_Inventory_All:initialize()
end
