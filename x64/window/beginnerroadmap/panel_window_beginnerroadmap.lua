PaGlobal_BeginnerRoadMap = {
  _ui = {
    _stc_roadMapMain = nil,
    _stc_roadMapTopArea = nil,
    _stc_roadMapPlayTime = nil,
    _btn_roadMapClose = nil,
    _stc_roadMapClose_Console = nil,
    _frm_roadMap = nil,
    _frm_content_roadMap = nil,
    _stc_frameHorizonScroll = nil,
    _stc_frameCenterLine = nil,
    _stc_roadMapDetailTooltip = nil,
    _stc_roadMapTooltipTitle = nil,
    _stc_roadMapTooltipDesc = nil,
    _btn_roadMapTooltipEvent = nil,
    _btn_roadMapTooltipAdventureNote = nil
  },
  _originalRoadMapSizeX = 0,
  _originalRoadMapSizeY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/BeginnerRoadMap/Panel_Window_BeginnerRoadMap_1.lua")
runLua("UI_Data/Script/Window/BeginnerRoadMap/Panel_Window_BeginnerRoadMap_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_BeginnerRoadMapInit")
function FromClient_BeginnerRoadMapInit()
  PaGlobal_BeginnerRoadMap:initialize()
end
