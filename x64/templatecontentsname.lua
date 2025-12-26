PaGlobal_ContentsName = {
  _ui = {},
  _initialize = false
}
runLua("UI_Data/TemplateContentsName_1.lua")
runLua("UI_Data/TemplateContentsName_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ContentsNameInit")
function FromClient_ContentsNameInit()
  PaGlobal_ContentsName:initialize()
end
