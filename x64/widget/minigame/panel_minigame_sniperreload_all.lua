PaGlobal_MiniGame_SniperReload_All = {
  _ui = {
    stc_spaceBar = nil,
    txt_leftTime = nil,
    txt_desc = nil,
    progress_reloadTimeBG = nil,
    progress_reloadTime = nil,
    stc_sniper_normal = nil,
    stc_sniper_normal_reloadMark = nil,
    stc_sniper_marnii = nil,
    stc_sniper_marnii_reloadMark = nil
  },
  _theta = 0,
  _markPosX = 50,
  _leftEndX = 80,
  _rightEndX = 410,
  _span = 165,
  _speed = 5,
  _leftSuccessX = 220,
  _rightSuccessX = 276,
  _piDouble = math.pi * 2,
  _inputLocked = false,
  _reloadOverTime = 0,
  _reloadFailed = false,
  _isMarniiSniperRifle = false,
  _activeReloadControl = {},
  _reloadTimeLimit = 5,
  _reloadRemainTime = 5,
  _config = {_reloadTimeDefault = 5},
  _initialize = false
}
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperReload_All_1.lua")
runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperReload_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MiniGame_SniperReload_All_Init")
function FromClient_MiniGame_SniperReload_All_Init()
  PaGlobal_MiniGame_SniperReload_All:initialize()
end
