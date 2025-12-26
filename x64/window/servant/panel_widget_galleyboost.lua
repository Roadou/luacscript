PaGlobal_GalleyBoost_All = {
  _ui = {
    _btn_main = nil,
    _txt_desc = nil,
    _txt_memberCount = nil,
    _stc_skill = nil,
    _stc_coolTime = nil,
    _txt_coolTime = nil,
    _stc_effect = nil,
    _btn_showMember = nil
  },
  _initialize = false,
  _stateType = {
    None = 1,
    PaddleMiniGame = 2,
    Boost = 3
  },
  _isDriver = false,
  _lastStartMiniGameTime = 0,
  _currentState = 0,
  _stateList = {},
  _lastCoolTimeInt = 0,
  _innerTimeForCoolTime = 0
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyBoost_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyBoost_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GalleyBoost_All_Init")
function FromClient_GalleyBoost_All_Init()
  PaGlobal_GalleyBoost_All:initialize()
end
