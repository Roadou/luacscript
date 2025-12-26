PaGlobal_Guild_Authorization_All = {
  _ui = {
    stc_title = nil,
    txt_title = nil,
    btn_close = nil,
    stc_main = nil,
    frame_1 = nil,
    frame_1_content = nil,
    checkBtn_groupTemplate = nil,
    stcText_groupTitle = nil,
    checkBtn_template = nil,
    stcText_right = nil,
    verticalScroll = nil,
    vs_upBtn = nil,
    vs_downBtn = nil,
    vs_ctrlBtn = nil,
    horizontalScroll = nil,
    hs_upBtn = nil,
    hs_downBtn = nil,
    hs_ctrlBtn = nil,
    stc_1 = nil,
    stc_keyGuide_consoleUI = nil,
    txt_b_consoleUI = nil,
    txt_a_consoleUI = nil,
    btn_reset = nil,
    btn_admin = nil,
    btn_cancel = nil,
    btn_close2 = nil
  },
  _groupCount = 0,
  _rightCount = {},
  _rightControlList = nil,
  _groupControlList = nil,
  _rightInfoList = nil,
  _targetMemberUserNo = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Guild/Panel_Guild_Authorization_All_1.lua")
runLua("UI_Data/Script/Window/Guild/Panel_Guild_Authorization_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Guild_Authorization_All_Init")
function FromClient_Guild_Authorization_All_Init()
  PaGlobal_Guild_Authorization_All:initialize()
end
