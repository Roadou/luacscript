PaGlobal_Telescope_All = {
  _ui = {
    _pc = {
      _btn_Close = nil,
      _btn_Confirm = nil,
      _edit_TargetUser = nil
    },
    _console = {
      _keyGuideBg = nil,
      _txt_keyGuideClose = nil,
      _txt_keyGuideConfirm = nil,
      _txt_keyGuideInput = nil
    },
    _edit_TargetUserName = nil,
    _stc_ContentsText = nil,
    _stc_ContentsDesc = nil
  },
  _targetUserName = nil,
  _itemSlotNo = nil,
  _itemWhereType = nil,
  _isConsole = nil,
  _initialize = false
}
runLua("UI_Data/Script/Window/Item/Panel_Window_Telescope_All_1.lua")
runLua("UI_Data/Script/Window/Item/Panel_Window_Telescope_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TelescopeInit")
function FromClient_TelescopeInit()
  PaGlobal_Telescope_All:initialize()
end
