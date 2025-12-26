PaGlobal_Edania_PVP_Challneger = {
  _ui = {
    _stc_BuffBG = nil,
    _stc_EnemyBuffBoarder = nil,
    _stc_EnemyBuffIcon = nil,
    _stc_Selected = nil,
    _stc_Line = nil,
    _stc_PlayerControl = Array.new(),
    _txt_LeftTime = nil,
    _stc_Direction = nil,
    _stc_Circle = nil,
    _txt_TimeLeft = nil
  },
  _appliedBuff_UIPool = {},
  _appliedBuff_UIPool_Last = 0,
  _elapsedTime = 0,
  _challengerCount = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Challenger_All_1.lua")
runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Challenger_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Edania_PVP_Challenger_Init")
function PaGlobal_Edania_PVP_Challenger_Init()
  PaGlobal_Edania_PVP_Challneger:initialize()
end
