PaGlobal_EncyclopediaNotice = {
  _ui = {
    stc_titleArea = nil,
    btn_close = nil,
    list2_noticeList = nil,
    stc_bg = nil,
    stc_banner = nil,
    btn_fishEncyclopedia = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _initialize = false,
  _isConsole = false
}
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_EncyclopediaNotice_1.lua")
runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_EncyclopediaNotice_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_EncyclopediaNotice_Init")
function FromClient_EncyclopediaNotice_Init()
  PaGlobal_EncyclopediaNotice:initialize()
end
