PaGlobal_MaidActorRegist = {
  _ui = {
    stc_blackBg = nil,
    stc_title = nil,
    btn_close = nil,
    frm_list = nil,
    fct_list = nil,
    rdo_template = nil,
    stc_registerBG = nil,
    edt_name = nil,
    txt_desc = nil,
    btn_regist = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideX = nil,
    stc_keyGuideY = nil
  },
  _eOpenType = {MAID_LIST = 0, MAID_ACTOR_LIST = 1},
  _openType = nil,
  _slots = nil,
  _selectSlotIndex = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorRegist_All_1.lua")
runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorRegist_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MaidActorRegistInit")
function FromClient_MaidActorRegistInit()
  PaGlobal_MaidActorRegist:initialize()
end
