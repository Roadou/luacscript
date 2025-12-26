PaGlobal_CannonStack = {
  _eStack = {
    _stack_0 = 0,
    _stack_1 = 1,
    _stack_2 = 2,
    _stack_3 = 3,
    _count = 4
  },
  _ui = {
    _stc_stackBg_0 = nil,
    _stc_stackBg_1 = nil,
    _stc_stackBg_2 = nil,
    _stc_stack_0 = nil,
    _stc_stack_1 = nil,
    _stc_stack_2 = nil
  },
  _originalPosX = 0,
  _originalPosY = 0,
  _cannonStackInfoList = nil,
  _currentIndex = nil,
  _initialize = false
}
runLua("UI_Data/Script/AbyssOne/Servant/Panel_CannonStack_AbyssOne_1.lua")
runLua("UI_Data/Script/AbyssOne/Servant/Panel_CannonStack_AbyssOne_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CannonStackInit")
function FromClient_CannonStackInit()
  PaGlobal_CannonStack:initialize()
end
