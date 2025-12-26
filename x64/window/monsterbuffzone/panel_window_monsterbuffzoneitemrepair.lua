PaGlobal_MonsterBuffZoneItemRepair = {
  _ui = {
    _btn_close = nil,
    _stc_centerBG = nil,
    _stc_effectBG = nil,
    _stc_monsterBuffZoneItemSlotBG = nil,
    _stc_materialItemSlotBG = nil,
    _stc_keyGuideBG = nil,
    _btn_skipAnimation = nil,
    _btn_repair = nil,
    _prg_endurancePreview = nil,
    _prg_enduranceCurrent = nil,
    _txt_enduranceCurrent = nil,
    _stc_descBG = nil,
    _txt_desc = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _materialSlotConfig = {
    createIcon = true,
    createBorder = true,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = true
  },
  _selectItemInfo_Dekia = nil,
  _selectItemInfo_Material = nil,
  _monsterBuffZoneItemSlot = nil,
  _materialItemSlot = nil,
  _isPlayingAnimation = false,
  _animationAccTime = 0,
  _animationMaxTime = 3,
  _animationSoundID = nil,
  _animationSoundID_Console = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZoneItemRepair_1.lua")
runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZoneItemRepair_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MonsterBuffZoneItemRepairInit")
function FromClient_MonsterBuffZoneItemRepairInit()
  PaGlobal_MonsterBuffZoneItemRepair:initialize()
end
