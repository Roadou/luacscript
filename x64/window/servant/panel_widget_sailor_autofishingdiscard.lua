PaGlobal_SailorAutoFishingDiscard_All = {
  _ui = {_stc_fishDiscardList = nil, _stc_closeFishDiscardList = nil},
  _eGradeList = {
    _none = 0,
    _normal = 1,
    _magic = 2,
    _rare = 3,
    _unique = 4,
    _count = 5
  },
  _arrowGradeColor = {
    [0] = 4286940549,
    [1] = 4294967295,
    [2] = 4289330187,
    [3] = 4281838331,
    [4] = 4294950448
  },
  _fishGradeColor = {
    [0] = 4278190080,
    [1] = 4292927712,
    [2] = 4286817603,
    [3] = 4282947792,
    [4] = 4294294074
  },
  _gradeString = {},
  _chk_fishGradeList = {},
  _currentSelectGrade = 0,
  _isPadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_Sailor_AutoFishingDiscard_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_Sailor_AutoFishingDiscard_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SailorAutoFishingDiscard_All_luaLoadComplete")
function FromClient_SailorAutoFishingDiscard_All_luaLoadComplete()
  PaGlobal_SailorAutoFishingDiscard_All:initialize()
end
