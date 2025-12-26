PaGlobal_RoseWarCommand = {
  _ui = {
    _btn_template = UI.getChildControl(Panel_RoseWar_Command, "Button_Template")
  },
  _lastPosXY_gameScene = nil,
  _openWorldPosition = float3(0, 0, 0),
  _openByMiniMap = false,
  _commandButtonList = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Command_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Command_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarCommandInit")
function FromClient_RoseWarCommandInit()
  PaGlobal_RoseWarCommand:initialize()
end
