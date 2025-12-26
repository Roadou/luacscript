PaGlobal_Edania_PVP_HUD = {
  _ui = {
    _stc_TeamHud = nil,
    _progress_Red = nil,
    _progress_Blue = nil,
    _txt_CenterTime = nil,
    _txt_LeftPoint = nil,
    _txt_RightPoint = nil,
    _txt_LeftTeamName = nil,
    _txt_RightTeamName = nil,
    _stc_RedPointDot = Array.new(),
    _stc_BluePointDot = Array.new(),
    _txt_Round = nil,
    _txt_MultiRound = nil,
    _stc_Result = nil,
    _stc_Win = nil,
    _stc_Lose = nil
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Hud_All_1.lua")
runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Hud_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Edania_PVP_Hud_Init")
function PaGlobal_Edania_PVP_Hud_Init()
  PaGlobal_Edania_PVP_HUD:initialize()
end
