PaGlobal_BlackspiritPassTooltipQuest = {
  _ui = {
    _txt_title = nil,
    _stc_descBG = nil,
    _txt_desc = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackspiritPassQuest_2.lua")
runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackspiritPassQuest_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_BlackspiritPassTooltipQuest")
function FromClient_PaGlobal_BlackspiritPassTooltipQuest()
  PaGlobal_BlackspiritPassTooltipQuest:initialize()
end
