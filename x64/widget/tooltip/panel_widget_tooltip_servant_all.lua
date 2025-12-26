PaGlobal_ToolTip_Servant_All = {
  _ui = {
    stc_mouseL = nil,
    stc_possibleL = nil,
    stc_impossibleL = nil,
    stc_descL = nil,
    stc_desc1L = nil,
    stc_desc2L = nil,
    stc_mouseR = nil,
    stc_possibleR = nil,
    stc_impossibleR = nil,
    stc_descR = nil,
    stc_desc1R = nil,
    stc_desc2R = nil,
    stc_distance = nil,
    stc_calldistance = nil,
    stc_haveitem = nil
  },
  _initialize = false
}
runLua("UI_Data/Script/Widget/Tooltip/Panel_Widget_Tooltip_Servant_All_1.lua")
runLua("UI_Data/Script/Widget/Tooltip/Panel_Widget_Tooltip_Servant_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Tooltip_Servant_All_Init")
function FromClient_Tooltip_Servant_All_Init()
  PaGlobal_ToolTip_Servant_All:initialize()
end
