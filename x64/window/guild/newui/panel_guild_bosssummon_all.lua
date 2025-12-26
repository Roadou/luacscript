PaGlobal_Guild_BossSummon_All = {
  _ui = {
    list2_BossList = nil,
    stc_BottomBG = nil,
    stc_DescFrame = nil,
    stc_DescScroll = nil,
    stc_DescContents = nil,
    txt_Desc = nil
  },
  _state = {
    NOTREADY = 0,
    GOPOSITION = 1,
    READY = 2,
    CLEAR = 3,
    StateMax = 4
  },
  _bossInfoList = {},
  _beforeLeftTime = 0,
  _enterBossKey = -1,
  _baseEnterButtonSpanX = 0,
  _baseEnterButtonSpanY = 0,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_BossSummon_All_1.lua")
runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_BossSummon_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_BossSummon_All_Init")
function FromClient_Guild_BossSummon_All_Init()
  PaGlobal_Guild_BossSummon_All:initialize()
end
