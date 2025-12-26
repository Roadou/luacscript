PaGlobal_Widget_Nak_AccessoryStepUp_All = {
  _ui = {_txt_msg = nil},
  _eNakType = {
    _CLEAR_QUEST = 0,
    _GET_ACCESSORY = 1,
    _EXCHANGE_ACCESSORY = 2
  },
  _timerNo = false,
  _initialize = false
}
runLua("UI_Data/Script/Widget/NakMessage//Panel_Widget_Nak_AccessoryStepUp_All_1.lua")
runLua("UI_Data/Script/Widget/NakMessage//Panel_Widget_Nak_AccessoryStepUp_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_Nak_AccessoryStepUp_All_Init")
function FromClient_Widget_Nak_AccessoryStepUp_All_Init()
  PaGlobal_Widget_Nak_AccessoryStepUp_All:initialize()
end
