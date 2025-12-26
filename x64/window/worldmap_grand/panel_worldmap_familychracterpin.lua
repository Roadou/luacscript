PaGlobal_WorldMap_FamilyCharacterPin = {
  _buttonList = {},
  _playerCreateType = __ePlayerCreateNormal,
  _isConsole = false,
  _initialize = false,
  _currentSelectIndex = -1,
  _territoryOffsetY = 95
}
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_FamilyChracterPin_1.lua")
runLua("UI_Data/Script/Window/WorldMap_Grand/Panel_WorldMap_FamilyChracterPin_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorldMap_FamilyCharacterPin_Init")
function FromClient_WorldMap_FamilyCharacterPin_Init()
  PaGlobal_WorldMap_FamilyCharacterPin:initialize()
end
