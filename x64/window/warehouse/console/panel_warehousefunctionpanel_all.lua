PaGlobal_WareHouseFunctionPanel_All = {
  _ui = {
    stc_TitleBg = nil,
    stc_MainBg = nil,
    btn_FucntionTemp = nil,
    stc_ConsoleKeyGuide = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil
  },
  _eFuncType = {
    autoMoveCurrentWay = 0,
    autoMoveAllWay = 1,
    autoMoveException = 2
  },
  _eFuncRightType = {
    [0] = nil,
    [1] = nil,
    [2] = nil
  },
  _btnString = {
    [0] = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOMOVE_CURRENT"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOMOVE_ALL"),
    PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AUTOMOVE_SET_TITLE")
  },
  _eOpenType = {
    INFO = 0,
    LIST = 1,
    ALLYINFO = 2
  },
  _menuCount = 3,
  _enabledBtnCount = 0,
  _originPanelSize = 0,
  _funcBtnTable = {},
  _openType = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/WareHouse/Console/Panel_WareHouseFunctionPanel_All_1.lua")
runLua("UI_Data/Script/Window/WareHouse/Console/Panel_WareHouseFunctionPanel_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WareHouseFunctionPanel_All_Init")
function FromClient_WareHouseFunctionPanel_All_Init()
  PaGlobal_WareHouseFunctionPanel_All:initialize()
end
