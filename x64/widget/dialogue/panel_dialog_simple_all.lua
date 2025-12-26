PaGlobal_Dialog_Simple_All = {
  _ui = {
    stc_mainbg = nil,
    stc_title = nil,
    txt_npcName = nil,
    txt_contentDesc = nil,
    btn_func = nil
  },
  _initialize = false,
  _DepthButtonType = {
    TALK = 1,
    EXCHANGE = 2,
    RENTAL = 3,
    QUEST = 4
  },
  _dialogIndex = {QUEST = -1, TALK = 1},
  _mainDialog = {},
  _prevExchangeDialog = nil,
  _maxLine = 0,
  _curLine = 0,
  _btnMaxCount = 10,
  _uiBtnList = {},
  _templetSpanX = 0,
  _templetSpanY = 0
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Simple_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Simple_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogSimple_luaLoadComplete")
function FromClient_DialogSimple_luaLoadComplete()
  PaGlobal_Dialog_Simple_All:initialize()
end
