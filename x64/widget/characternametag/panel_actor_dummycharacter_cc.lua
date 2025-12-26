PaGlobal_Actor_DummyCharacter_CC = {
  _ui = {},
  _initialize = false,
  _maxCCCount = 20,
  _timerNo = {}
}
runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Actor_DummyCharacter_CC_1.lua")
runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Actor_DummyCharacter_CC_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DummyCharacter_CCInit")
function FromClient_DummyCharacter_CCInit()
  PaGlobal_Actor_DummyCharacter_CC:initialize()
end
