PaGlobal_Solare_Custom_Invite = {
  _ui = {
    _edit_UserNickName = nil,
    _btn_Close = nil,
    _btn_Confirm = nil,
    _btn_Cancel = nil,
    _console = {
      _keyGuideBg = nil,
      _stc_Confirm = nil,
      _stc_Cancel = nil,
      _stc_InputName = nil
    }
  },
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch_Invite_1.lua")
runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch_Invite_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_SolareCustomInviteInit")
function FromClient_SolareCustomInviteInit()
  PaGlobal_Solare_Custom_Invite:initialize()
end
