PaGlobal_NotationAbility = {
  _ui = {
    _btn_close = nil,
    _rdo_showEquipAbility = nil,
    _rdo_showTotalAbility = nil,
    _chk_addMonsterAtk = nil,
    _rdo_addKindNone = nil,
    _rdo_addKindKamaAtk = nil,
    _rdo_addKindAinAtk = nil,
    _rdo_addKindHumanAtk = nil,
    _rdo_addKindEdaniaAtk = nil
  },
  _isPadMode = false,
  _initialize = false,
  _initializeLate = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Notation_Ability_All_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Notation_Ability_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_NotationAbilityInit")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_NotationAbilityInitLate")
function FromClient_NotationAbilityInit()
  PaGlobal_NotationAbility:initialize()
end
function FromClient_NotationAbilityInitLate()
  PaGlobal_NotationAbility._initializeLate = true
  PaGlobal_NotationAbility:updateOtherUI()
end
