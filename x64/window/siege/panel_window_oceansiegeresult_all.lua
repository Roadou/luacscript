PaGlobal_Window_OceanSiegeResult_All = {
  _ui = {
    _stc_topMainArea = nil,
    _txt_resultTitle = nil,
    _txt_result_date = nil,
    _stc_resultVisualize = nil,
    _btn_close = nil,
    _stc_middleSubArea = nil,
    _stc_joinArea = nil,
    _txt_region = nil,
    _txt_member = nil,
    _stc_joinRewardArea = nil,
    _txt_rewardMoney = nil,
    _stc_rewardTemplete = nil,
    _txt_rewardItemTitle = nil,
    _rewardItemSlot = nil,
    _stc_joinTotalTimeArea = nil,
    _txt_joinTime = nil,
    _txt_occupyTime = nil,
    _stc_firstInfo = nil,
    _txt_firstTitleValue = nil,
    _stc_secondInfo = nil,
    _txt_secondTitleValue = nil,
    _stc_thirdInfo = nil,
    _txt_thirdTitleValue = nil,
    _stc_fifthInfo = nil,
    _txt_fifthTitleValue = nil,
    _stc_firstInfo_txt_Ranking = {},
    _stc_secondInfo_txt_Ranking = {},
    _stc_thirdInfo_txt_Ranking = {},
    _stc_fifthInfo_txt_Ranking = {},
    _personalDataList = {},
    _stc_keyGuideBG = nil
  },
  slotConfig = {createIcon = true, createBorder = true},
  _requestSiegeHistory = false,
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Siege/Panel_Window_OceanSiegeResult_All_1.lua")
runLua("UI_Data/Script/Window/Siege/Panel_Window_OceanSiegeResult_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_OceanSiegeResult_All_Init")
function FromClient_Window_OceanSiegeResult_All_Init()
  PaGlobal_Window_OceanSiegeResult_All:initialize()
end
