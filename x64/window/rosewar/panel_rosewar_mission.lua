PaGlobal_RoseWarMission = {
  _ui = {
    _stc_titleArea = nil,
    _btn_close = nil,
    _stc_mainArea = nil,
    _btn_missionTypeAttack = nil,
    _btn_missionTypeDefense = nil,
    _btn_missionTypeKill = nil,
    _txt_missionLimitTime = nil,
    _txt_missionRewardCount = nil,
    _btn_createMission = nil,
    _cbx_target = nil,
    _stc_targetList = nil
  },
  _eOpenMode = {
    _SET_CLEAR = 0,
    _SET_FIERCE_BATTLE = 1,
    _SET_MY_CASTLE = 2,
    _SET_ENEMY_CASTLE = 3,
    _SET_GIMMICK_FIERCE = 4,
    _COUNT = 5
  },
  _selectedTargetFierceBattleKeyRaw = nil,
  _selectedMissionType = nil,
  _addPartyButtonDataList = {},
  _addPartyButtonCount = 5,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Mission_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Mission_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarMissionInit")
function FromClient_RoseWarMissionInit()
  PaGlobal_RoseWarMission:initialize()
end
