PaGlobal_SailControl = {
  _ui = {btn_SailControl = nil, chk_button = nil},
  _isFoldable = false,
  _isShowOkiyluaBless = nil,
  _progressMoveSpeed = 2,
  _actorKeyRaw = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_SailControl_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_SailControl_2.lua")
registerEvent("FromClient_luaLoadComplete", "PaGlobal_SailControl_luaLoadComplete")
function PaGlobal_SailControl_luaLoadComplete()
  PaGlobal_SailControl:initialize()
end
