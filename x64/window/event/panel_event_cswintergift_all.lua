PaGlobal_Event_CSWintergift = {
  _ui = {
    _stc_BranchBG = nil,
    _txt_CSWinterGiftTitle = nil,
    _stc_MiddleGroup = nil,
    _stc_ReciveGroup = nil,
    _txt_BotText = nil,
    _txt_KeyGuide = nil
  },
  _giftSlotCount = 5,
  _giftSlot = {},
  _giftItemKeyRaw = {
    [1] = 17859,
    [2] = 750708,
    [3] = 45183,
    [4] = 290062,
    [5] = 750493
  },
  _giftItemCount = {
    [1] = 1,
    [2] = 5,
    [3] = 1,
    [4] = 1,
    [5] = 3
  },
  _ps_NA_ASIA_EntitlementID = "NA200G",
  _ps_EU_EntitlementID = "EU200G",
  _xbox_LegacyProductID = "344a5039-5242-3038-c056-4a3444564100",
  _selectIndex = 0,
  _isTooltipShow = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Event/Panel_Event_CSWintergift_All_1.lua")
runLua("UI_Data/Script/Window/Event/Panel_Event_CSWintergift_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Event_CSWintergift_Init")
function FromClient_PaGlobal_Event_CSWintergift_Init()
  PaGlobal_Event_CSWintergift:initialize()
end
