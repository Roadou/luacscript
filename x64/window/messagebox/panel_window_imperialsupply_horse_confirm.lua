PaGlobal_ImperialSupplyMSG = {
  _ui = {_stc_background = nil, _stc_forEffect = nil},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true
  },
  _Slot1 = nil,
  _Slot2 = nil,
  _Slot3 = nil,
  _initialize = false,
  _event = _ContentsGroup_HorseImperialEvent,
  _SlotList = {},
  _rewardItemKeyList = {},
  _horseTier = 0,
  _isUsedAnyAddStatItem = false,
  _sellCost = 0,
  _isMutationHorse = false,
  _treasureComponentItemkey = nil,
  _isTreasureSlotShow = false,
  _isEffectShowing = false,
  _elapsedTime = 0,
  _slotEffectStartTime = 1,
  _slotShowTime = 3,
  _backgroundEffectEndTime = 5
}
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm_1.lua")
runLua("UI_Data/Script/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ImperialSupplyMSG")
function FromClient_ImperialSupplyMSG()
  PaGlobal_ImperialSupplyMSG:initialize()
end
