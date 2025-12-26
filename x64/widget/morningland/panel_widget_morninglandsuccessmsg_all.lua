PaGlobal_MorningLandSuccessMsg = {
  _ui = {
    txt_content = nil,
    txt_timeLog = nil,
    stc_newIcon = nil
  },
  _msgVisibleTime = 5,
  _clearTime = 0,
  _elementalMonsterKey = 2,
  _initialize = false
}
runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_MorningLandSuccessMsg_All_1.lua")
runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_MorningLandSuccessMsg_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MorningLandSuccessMsg_Init")
function FromClient_PaGlobal_MorningLandSuccessMsg_Init()
  PaGlobal_MorningLandSuccessMsg:initialize()
end
