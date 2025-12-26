PaGlobal_Tooltip_Actor_All = {
  _ui = {btn_close = nil},
  _mainPanel = Panel_Widget_Tooltip_Actor_All,
  _actorKey = 0,
  _panelSize = nil,
  _grapeSize = nil,
  _socketSize = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Actor_All_1.lua")
runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Actor_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Tooltip_Actor_All_Init")
registerEvent("FromClient_SelectedCharacterActor", "FromClient_SelectedCharacterActor")
function FromClient_Tooltip_Actor_All_Init()
  PaGlobal_Tooltip_Actor_All:initialize()
end
function FromClient_SelectedCharacterActor(actorKeyRaw)
  local actorProxyWrapper = getActor(actorKeyRaw)
  if nil == actorProxyWrapper then
    return
  end
  PaGlobal_Tooltip_Actor_All_Open(actorKeyRaw)
end
