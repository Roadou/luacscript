PaGlobal_InteractionGathering_All = {
  _ui = {
    _backGround = nil,
    _btn_ax = nil,
    _btn_injector = nil,
    _btn_homi = nil,
    _btn_meat = nil,
    _btn_leather = nil,
    _btn_pick = nil,
    _btn_barehand = nil
  },
  _collectTypeList = {
    __eCollectToolType_Axe,
    __eCollectToolType_Syringe,
    __eCollectToolType_Hoe,
    __eCollectToolType_ButcheryKnife,
    __eCollectToolType_SkinKnife,
    __eCollectToolType_Pickax,
    __eCollectToolType_BareHands
  },
  _config = {
    _MAXICON = 3,
    _ANIMATION_TIME = 0.35,
    _guideDescXSize = 300,
    _guideDescYSize = 0,
    _iconTextTextSpanY = -28,
    _btn_offset_x = 0,
    _btn_offset_y = 0,
    _circle_radius = 60
  },
  _isRotating = false,
  _clockWiseRotation = false,
  _buttonFirstOpen = false,
  _buttonAnimationTime = 0,
  _collectTypeUIInfo = {},
  _activatedIconCount = 0,
  _activatedIconList = {},
  _initialize = false,
  _collectActionString = ""
}
runLua("UI_Data/Script/Widget/Interaction/UI_Character_InterActionGathering_All_1.lua")
runLua("UI_Data/Script/Widget/Interaction/UI_Character_InterActionGathering_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_InteractionGatheringInit")
function FromClient_InteractionGatheringInit()
  PaGlobal_InteractionGathering_All:initialize()
end
