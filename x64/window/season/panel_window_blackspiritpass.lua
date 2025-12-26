PaGlobal_BlackspiritPass = {
  _ui = {
    _stc_blackSpiritPassMain = nil,
    _stc_banner = nil,
    _btn_directBuy = nil,
    _btn_seasonGuide = nil,
    _btn_toggleShowRoadMap = nil,
    _txt_date = nil,
    _list_quest = nil,
    _stc_lockBG = nil,
    _stc_lockIcon = nil,
    _stc_lockEffect = nil,
    _stc_bottomDescBg = nil,
    _txt_bottomDesc = nil,
    _txt_ForceGraduate = nil,
    _txt_RateViewLink = nil,
    _stc_subTitleArea = nil,
    _stc_keyGuideArea = nil,
    _stc_keyGuide_RT_X = nil,
    _stc_keyGuide_RT_Y = nil,
    _stc_keyGuide_LT_X = nil,
    _stc_keyGuide_LT_Y = nil,
    _stc_keyGuide_X = nil,
    _stc_keyGuide_A = nil,
    _stc_keyGuide_Y = nil,
    _stc_keyGuide_B = nil,
    _stc_graduation = nil,
    _btn_graduation = nil,
    _btn_graduationForce = nil,
    _btn_gradutaionConfirm = nil,
    _btn_gradutaionCancel = nil,
    _btn_gradutationClose = nil,
    _stc_frameGraduate = nil,
    _stc_frameContents = nil,
    _btn_scrollGraduate = nil,
    _stc_frameContents = nil,
    _keyguide_graduate = nil,
    _keyguide_graduate_A = nil,
    _keyguide_graduate_B = nil,
    _keyguide_graduate_RS = nil
  },
  _rewardSlotConfig = {
    createIcon = true,
    createBorder = false,
    createCount = true,
    createEnchant = true,
    createEnduranceIcon = true
  },
  _state = {
    none = 0,
    progressing = 1,
    clear = 2,
    clickedReward = 3
  },
  _questLoadingDataList = nil,
  _questInfo = {},
  _scrollPos = 0,
  _scrollSizeY = 0,
  _maxScrollSizeY = 0,
  _scrollValue = 0,
  _animListIdx = nil,
  _normalQuestIdx = 1,
  _premiumQuestIdx = 2,
  _lastKeyGuideAlignMode = nil,
  _hasSeasonPass = false,
  _isHideDelay = false,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _graduateType = -1,
  _initialize = false
}
runLua("UI_Data/Script/Window/Season/Panel_Window_BlackspiritPass_1.lua")
runLua("UI_Data/Script/Window/Season/Panel_Window_BlackspiritPass_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_BlackspiritPass_Init")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_luaLateUpdate_SeasonGaduateComplete_Init")
function FromClient_luaLoadComplete_BlackspiritPass_Init()
  PaGlobal_BlackspiritPass:initialize()
end
function FromClient_luaLateUpdate_SeasonGaduateComplete_Init()
  local isShow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(__eSeasonGraduateComplete)
  if isShow == false then
    return
  end
  local showAndHide = function()
    Panel_Season_Graduation_MSG:SetShow(false)
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBoolNoSave(__eSeasonGraduateComplete, false)
  end
  local bg = UI.getChildControl(Panel_Season_Graduation_MSG, "Static_Season_Graduation")
  UI.getChildControl(bg, "StaticText_Desc"):SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PASS_GRADUATION_MESSAGE_2", "familyname", getFamilyName()))
  Panel_Season_Graduation_MSG:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Season_Graduation_MSG:ComputePosAllChild()
  Panel_Season_Graduation_MSG:SetShow(true)
  luaTimer_AddEvent(showAndHide, 5000, false, 0)
end
