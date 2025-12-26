PaGlobal_ChangeMaidActorName = {
  _ui = {
    stc_blackBg = nil,
    stc_titleBg = nil,
    btn_close = nil,
    stc_mainBg = nil,
    edt_name = nil,
    txt_desc = nil,
    stc_buttonBg = nil,
    btn_apply = nil,
    btn_cancel = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideX = nil
  },
  _maidNo = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Maid/Panel_Window_ChangeMaidActorName_All_1.lua")
runLua("UI_Data/Script/Widget/Maid/Panel_Window_ChangeMaidActorName_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ChangeMaidActorNameInit")
function FromClient_ChangeMaidActorNameInit()
  PaGlobal_ChangeMaidActorName:initialize()
end
