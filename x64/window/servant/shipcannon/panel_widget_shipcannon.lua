PaGlobal_ShipCannon = {
  _eCannon = {
    all = 0,
    left = 1,
    right = 2,
    loopCount = 2
  },
  _eCooltime = {
    one = 1,
    two = 2,
    three = 3,
    ready = 4,
    loopCount = 4
  },
  _ui = {
    _progress_powerGauge = nil,
    _stc_cooltimes = nil,
    _stc_cannonReady = nil,
    _txt_bulletCount = nil,
    _stc_autoFishingGauge = nil,
    _progress_FishingGauge = nil,
    _stc_cantAutoFish = nil,
    _stc_fishDiscardArrow = nil
  },
  _eGradeList = {
    _none = 0,
    _normal = 1,
    _magic = 2,
    _rare = 3,
    _unique = 4,
    _count = 5
  },
  _autoFishingEffectOn = false,
  _gradeColor = {
    [0] = 4286940549,
    [1] = 4294967295,
    [2] = 4289330187,
    [3] = 4281838331,
    [4] = 4294950448
  },
  _gradeString = {},
  _chk_fishGradeList = {},
  currentPower = 0,
  _currentSelectGrade = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/ShipCannon/Panel_Widget_ShipCannon_1.lua")
runLua("UI_Data/Script/Window/Servant/ShipCannon/Panel_Widget_ShipCannon_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipCannonInit")
function FromClient_ShipCannonInit()
  PaGlobal_ShipCannon:initialize()
end
