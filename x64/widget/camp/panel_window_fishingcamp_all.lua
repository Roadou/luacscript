PaGlobal_FishingCamp = {
  _ui = {
    stc_cantUse = nil,
    btn_unSeal = nil,
    btn_seal = nil
  },
  _slotUI = {
    [0] = nil,
    [1] = nil,
    [2] = nil,
    [3] = nil
  },
  _itemSlots = {},
  _itemSlotConfig = {
    createIcon = false,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _maxSlotCount = 4,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Camp/Panel_Window_FishingCamp_All_1.lua")
runLua("UI_Data/Script/Widget/Camp/Panel_Window_FishingCamp_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "Panel_Window_FishingCamp_Init")
function Panel_Window_FishingCamp_Init()
  PaGlobal_FishingCamp:initialize()
end
