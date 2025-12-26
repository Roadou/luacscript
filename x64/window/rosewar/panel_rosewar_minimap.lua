PaGlobal_RoseWarMiniMap = {
  _ui = {
    _stc_miniMapBg = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_MiniMapBg"),
    _stc_miniMapNavigationGuideBg = nil,
    _chk_togglePartyList = UI.getChildControl(Panel_RoseWar_MiniMap, "CheckButton_ToggleParty"),
    _chk_toggleEditParty = UI.getChildControl(Panel_RoseWar_MiniMap, "CheckButton_EditParty"),
    _chk_toggleRoseWarMission = UI.getChildControl(Panel_RoseWar_MiniMap, "CheckButton_RoseWarQuest"),
    _chk_toggleChatting = UI.getChildControl(Panel_RoseWar_MiniMap, "CheckButton_Chatting"),
    _chk_toggleScoreBoard = UI.getChildControl(Panel_RoseWar_MiniMap, "CheckButton_ScoreBoard"),
    _stc_naviGuide = UI.getChildControl(Panel_RoseWar_MiniMap, "CheckButton_RoseWarMove"),
    _stc_dragGuide = UI.getChildControl(Panel_RoseWar_MiniMap, "StaticText_Drag"),
    _stc_pingGuide = UI.getChildControl(Panel_RoseWar_MiniMap, "StaticText_Ping"),
    _stc_objectTooltip = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_FierceBattleObject_Tooltip"),
    _stc_objectTooltip_Altar_BG = nil,
    _stc_objectTooltip_flag = nil,
    _stc_objectTooltip_image = nil,
    _stc_objectTooltip_icon = nil,
    _stc_objectTooltip_cooltime = nil,
    _stc_objectTooltip_title = nil,
    _stc_objectTooltip_desc = nil,
    _stc_objectTooltip_progressBox = nil,
    _stc_objectTooltip_red = nil,
    _stc_objectTooltip_blue = nil,
    _btn_moveMapToSelfPlayerPos = UI.getChildControl(Panel_RoseWar_MiniMap, "Button_Find_MyPosition")
  },
  _eRenderOrder = {
    MINIMAP_TEXTURE = 9999,
    MINIMAP_LINES = 9998,
    VEHICLE_ICON = 9997,
    MARKER_ICON = 9996,
    ACTOR_SELECT_ICON = 9995,
    ACTOR_ICON = 9994,
    FIERCE_BATTLE_ICON = 9993
  },
  _eMiniMapInputProcessType = {
    MOVE_MAP_MOUSE = 0,
    MOVE_MAP_KEYBOARD = 1,
    SELECT_AREA_BEGIN = 2,
    SELECT_AREA_END = 3,
    CLOSE_MINIMAP = 4,
    TOGGLE_PARTY_LIST = 5,
    TOGGLE_PARTY_EDIT = 6,
    TOGGLE_MISSION = 7,
    TOGGLE_CHATTING = 8,
    MOVE_MAP_TO_SELFPLAYER = 9,
    CLEAR_SELECT_ICON = 10,
    TOGGLE_SCOREBOARD = 11,
    NONE = 12
  },
  _eTooltipType = {
    FIERCE_BATTLE = 0,
    FIERCE_BATTLE_GIMIC = 1,
    COMMANDER = 2,
    NONE = 3
  },
  _closeFlag_m = false,
  _eInitPoolCount = {
    ACTOR_ICON = 30,
    VEHICLE_ICON = 10,
    MINIMAP_MARKER = 10,
    MINIMAP_FIERCEBATTLE_OBJECT = 10
  },
  _eExpandPoolCount = {
    ACTOR_ICON = 10,
    VEHICLE_ICON = 2,
    MINIMAP_MARKER = 5,
    MINIMAP_FIERCEBATTLE_OBJECT = 1
  },
  _miniMapMoveAnimationInfo = nil,
  _miniMapMouseMoveFlag = nil,
  _miniMapBgTexture_Kamasilvia = nil,
  _miniMapBgTexture_Odilita = nil,
  _miniMapControl = nil,
  _mouseScrollVariable = 0.1,
  _currentMiniMapRate = 1,
  _miniMapImageRateMin = 0.45,
  _miniMapImageRateMax = 2,
  _miniMapSectorGridTextureSize = 128,
  _currentMiniMapImageSizeXY = float2(0, 0),
  _miniMapImageSizeXY = float2(0, 0),
  _miniMapBGLimitMinXY = float2(0, 0),
  _miniMapBGLimitMaxXY = float2(0, 0),
  _beginSectorIndexXZ = int2(-49, -33),
  _endSectorIndexXZ = int2(-18, -54),
  _sectorSizeWithCentiMeterXXX = 12800,
  _miniMapPinData = nil,
  _miniMapMovePinData = nil,
  _miniMapDragSelectData = nil,
  _accumulatedDeltaTime = 0,
  _updateCycleTime = 0.5,
  _miniMapActorIconOriginalSizeX = 27,
  _miniMapActorIconOriginalSizeY = 32,
  _miniMapSelectedActorIconOriginSizeX = 30,
  _miniMapSelectedActorIconOriginSizeY = 30,
  _miniMapSelfActorIconOriginalSizeX = 48,
  _miniMapSelfActorIconOriginalSizeY = 80,
  _miniMapActorIconImageRateMax = 2,
  _miniMapActorIconPoolCount = 0,
  _miniMapActorIconList = nil,
  _miniMapVehicleIconOriginalSizeX = 50,
  _miniMapVehicleIconOriginalSizeY = 50,
  _miniMapVehicleIconImageRateMax = 1.5,
  _miniMapVehicleIconPoolCount = 0,
  _miniMapVehicleIconList = nil,
  _miniMapMarkerList = nil,
  _miniMapMarkerPoolCount = 50,
  _miniMapMarkerImageRateMax = 2,
  _pingAndMarkerDataList = nil,
  _miniMapFierceBattleIconList = nil,
  _miniMapFierceBattleIconPoolCount = 20,
  _miniMapGimmickFierceBattleIconList = nil,
  _miniMapGimmickFierceBattleIconPoolCount = 5,
  _miniMapBossIconList = {},
  _miniMapFierceBattleIconImageRateMax = 2,
  _gimmickRespawnTime = 0,
  _tooltipData = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_2.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_3.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_4.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_5.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_6.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_7.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap_8.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarMiniMapInit")
function FromClient_RoseWarMiniMapInit()
  PaGlobal_RoseWarMiniMap:initialize()
end
