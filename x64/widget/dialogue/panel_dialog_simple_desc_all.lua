PaGlobal_Dialog_SimpleDesc_All = {
  _ui = {
    stc_mainbg = nil,
    txt_npcName = nil,
    frame = nil,
    frame_content = nil,
    frame_verticalScroll = nil,
    txt_desc = nil,
    txt_close = nil
  },
  _initialize = false,
  _frameScrollCtrlPos = 0
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Simple_Desc_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Simple_Desc_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogSimpleDesc_luaLoadComplete")
function FromClient_DialogSimpleDesc_luaLoadComplete()
  PaGlobal_Dialog_SimpleDesc_All:initialize()
end
