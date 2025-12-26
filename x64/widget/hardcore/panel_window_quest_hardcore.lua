PaGlobal_HardCoreQuestDetails = {
  _ui = {
    _titleBg = nil,
    _btn_Close = nil,
    _questUI = {},
    _noneQuest = nil
  },
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = true,
    createEnchant = true,
    createCount = true,
    createClassEquipBG = true,
    createCash = true
  },
  _baseReward = {},
  _initialize = false,
  _questCountMax = 2,
  _questData = {},
  _itemSlotMaxCount = 6,
  _originalPanelSizeY = 0
}
runLua("UI_Data/Script/Widget/HardCore/Panel_Window_Quest_HardCore_1.lua")
runLua("UI_Data/Script/Widget/HardCore/Panel_Window_Quest_HardCore_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_HardCoreQuestDetails_Init")
function FromClient_HardCoreQuestDetails_Init()
  PaGlobal_HardCoreQuestDetails:initialize()
end
