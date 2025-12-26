PaGlobal_LocalWarInfo_All_New = {
  _ui = {
    _stc_titleBG = nil,
    _stc_leftBG = nil,
    _stc_banner = nil,
    _stc_picTooltip = nil,
    _list2_serverList = nil,
    _frame_desc = nil,
    _tree_mapList = nil,
    _stc_mapListContent = Array.new(),
    _rule = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    },
    _reward = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    },
    _explanation = {
      _txt_title = nil,
      _stc_background = nil,
      _txt_content = {}
    }
  },
  _ui_pc = {_btn_close = nil, _btn_help = nil},
  _ui_console = {
    _stc_keyguideBG = nil,
    _stc_keyguideA = nil,
    _stc_keyguideB = nil,
    _stc_keyguideY = nil
  },
  _posConfig = {
    _listStartPosY = 5,
    _iconStartPosY = 88,
    _listPosYGap = 45
  },
  _eMapKeyIndex = {
    _NORMAL = 0,
    _GAMOSNEST = 10,
    _SEASONNORMAL = 11,
    _SEASONGAMOSE = 12,
    _DISABLECAMONORMAL = 15,
    _DISABLECAMOGAMOS = 16,
    _SEASONDISABLECAMONORMAL = 17,
    _SEASONDISABLECAMOGAMOSE = 18,
    _OCCUPATION = 21,
    _SEASONOCCUPATION = 22,
    _DISABLEOCCUPATION = 23,
    _SEASONDISABLEOCCUPATION = 24,
    _PAPUCRIO = 30
  },
  _mapList = {
    _NORMAL = Array.new(),
    _GAMOSNEST = Array.new(),
    _OCCUPATION = Array.new(),
    _PAPUCRIO = Array.new(),
    _COUNT = 4
  },
  _treeMapTable = Array.new(),
  _roomTitle = Array.new(),
  _maxRoomTitleCount = 0,
  _tempRoomTitleIndex = 4,
  _openDesc = -1,
  _maxRuleSize = 40,
  _ruleCount = 9,
  _maxRewardSize = 20,
  _rewardCount = 2,
  _maxExplanationSize = 30,
  _explanationCount = 3,
  _localWarServerCountLimit = 0,
  _rule_ani_SpeedTime = 5,
  _treeMainIndex = 1,
  _treeKeyIndex = 1,
  _maxListCount = 10,
  _originalCamoPosX = 50,
  _isOccupationDesc = false,
  _isGrouthLocalWar = ToClient_IsContentsGroupOpen("338"),
  _updateDeltaTime = 10,
  _joinableDebeffTable = {
    [1] = 58140,
    [2] = 15419,
    [3] = 51734,
    [4] = 15335,
    [5] = 15592,
    [6] = 49911,
    [7] = 15648
  },
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_New_1.lua")
runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_New_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_LocalWarInfo_All_New_Init")
function FromClient_luaLoadComplete_LocalWarInfo_All_New_Init()
  PaGlobal_LocalWarInfo_All_New:initialize()
end
