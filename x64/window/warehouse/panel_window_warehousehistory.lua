PaGlobal_WareHouseHistory = {
  _ui = {
    _topBg = nil,
    _mainBg = nil,
    _stc_descBg = nil,
    _txt_desc = nil,
    _stc_keyGuide = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true,
    createEnduranceIcon = true,
    createOriginalForDuel = false
  }
}
runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouseHistory_1.lua")
runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouseHistory_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WareHouseHistoryInit")
function FromClient_WareHouseHistoryInit()
  local self = PaGlobal_WareHouseHistory
  self:init()
end
