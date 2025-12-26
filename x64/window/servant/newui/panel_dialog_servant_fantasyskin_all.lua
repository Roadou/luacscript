PaGlobal_ServantFantasySkin = {
  _ui = {
    btn_close = nil,
    stc_textureSlotLeft = nil,
    stc_textureBgLeft = nil,
    stc_textBgLeft = nil,
    stc_selectLeft = nil,
    stc_textureSlotRight = nil,
    stc_textureBgRight = nil,
    stc_textBgRight = nil,
    stc_selectRight = nil,
    btn_confirm = nil
  },
  _currentServantNo = nil,
  _currentServantCharacterKeyRaw = nil,
  _changeTargetFormIndexRaw = nil,
  _beforeSceneIndex = -1,
  _currentSelectedButtonIndex = -1,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySkin_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySkin_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantFantasySkin")
function FromClient_ServantFantasySkin()
  PaGlobal_ServantFantasySkin:initialize()
end
