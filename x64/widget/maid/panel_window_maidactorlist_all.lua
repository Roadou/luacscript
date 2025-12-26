PaGlobal_MaidActorList = {
  _ui = {
    stc_blackBg = nil,
    stc_titleBg = nil,
    btn_close = nil,
    stc_mainBg = nil,
    frm_main = nil,
    fct_main = nil,
    rdo_slotTemplate = nil,
    stc_applyMaid = nil,
    stc_click = nil,
    btn_create = nil,
    btn_unregist = nil,
    btn_apply = nil,
    btn_changeName = nil,
    stc_changeNameIcon = nil,
    stc_keyGuideBg = nil,
    stc_keyGuideA = nil,
    stc_keyGuideB = nil,
    stc_keyGuideY = nil,
    stc_keyGuideLS = nil,
    stc_keyGuideRS = nil
  },
  _selectSlotIndex = nil,
  _slots = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorList_All_1.lua")
runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MaidActorListInit")
function FromClient_MaidActorListInit()
  PaGlobal_MaidActorList:initialize()
end
