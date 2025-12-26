PaGlobal_RoseWar_NakWarLog_L = {
  _ui = {
    static_PositiveBox = nil,
    static_NegativeBox = nil,
    static_NeutralBox = nil
  },
  _readyLogList = {},
  _showingLogList = {},
  _logInfoList = {},
  _showingTime = 12,
  _hideTime = 1,
  _maxShowCount = 7,
  _initialize = false
}
NakWarLog_BoxType = {
  positive = 0,
  negative = 1,
  neutral = 2,
  count = 3
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_WarLog_L_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_WarLog_L_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarNakWarLogLInit")
function FromClient_RoseWarNakWarLogLInit()
  PaGlobal_RoseWar_NakWarLog_L:initialize()
end
