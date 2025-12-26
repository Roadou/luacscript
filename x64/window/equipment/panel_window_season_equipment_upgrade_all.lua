PaGlobal_SeasonEquipment_Upgrade = {
  _ui = {
    btn_close = nil,
    stc_itemSetting = nil,
    stc_effect = nil,
    stc_naru_item = nil,
    stc_tubala = nil,
    btn_upgrade = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createEnchant = true,
    createCash = false,
    createOriginalForDuel = true
  },
  _isConsole = false,
  naruItem = nil,
  tubalaItem = nil,
  naruItemKey = nil,
  tubalaItemKey = nil,
  startAnimation = false,
  animationTotalTime = 4.7,
  animationTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/Equipment/Panel_Window_Season_Equipment_Upgrade_All_1.lua")
runLua("UI_Data/Script/Window/Equipment/Panel_Window_Season_Equipment_Upgrade_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_SeasonEquipment_Upgrade_Init")
function FromClient_PaGlobal_SeasonEquipment_Upgrade_Init()
  PaGlobal_SeasonEquipment_Upgrade:initialize()
end
