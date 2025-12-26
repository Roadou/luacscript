PaGlobal_RoseWarMissionAccept = {
  _ui = {
    _txt_missionName = UI.getChildControl(Panel_RoseWar_MissionAccept, "StaticText_Mission")
  },
  _timeAcc = 0,
  _showTime = 6,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MissionAccept_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MissionAccept_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_FromClient_RoseWarMissionAcceptInit")
function FromClient_FromClient_RoseWarMissionAcceptInit()
  PaGlobal_RoseWarMissionAccept:initialize()
end
