PaGlobal_AlchemyStone_Renewal_All = {
  _ui = {
    _stc_title = nil,
    _btn_close = nil,
    _btn_question = nil,
    _stc_radioGroup = nil,
    _txt_lb_console = nil,
    _txt_rb_console = nil,
    _rdo_tab_charge = nil,
    _rdo_tab_upgrade = nil,
    _stc_selectBar = nil,
    _txt_multiline = nil,
    _stc_chargeBG = nil,
    _stc_charge = nil,
    _stc_slot_left = nil,
    _stc_slot_right = nil,
    _txt_needItem = nil,
    _txt_durability = nil,
    _stc_upgradeBG = nil,
    _stc_upgrade = nil,
    _txt_exp = nil,
    _circular_gauge = nil,
    _stc_slot_1 = nil,
    _stc_slot_2 = nil,
    _progress_stack = nil,
    _txt_stack = nil,
    _stc_stackEffect = nil,
    _chk_skipAni = nil,
    _btn_charge = nil,
    _stc_descBG = nil,
    _txt_desc = nil,
    _stc_result = nil,
    _txt_result = nil,
    _stc_resultIemNameBG = nil,
    _txt_resultItemName = nil,
    _stc_resultItemSlotBG = nil,
    _stc_resultItemSlot = nil,
    _txt_resultDesc = nil,
    _stc_consoleKeyGuide = nil,
    _keyGuideA = nil,
    _keyGuideB = nil,
    _keyGuideX = nil,
    _keyGuideY = nil,
    _stc_blockBg = nil
  },
  _eTab = {_charge = 0, _upgrade = 1},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _chargeSlot = {
    [0] = {},
    [1] = {}
  },
  _upgradeSlot = {
    [0] = {},
    [1] = {}
  },
  _evolveResultSlot = {
    [0] = {}
  },
  _alchemyStoneWhereType = nil,
  _alchemyStoneSlotNo = nil,
  _alchemyStoneType = nil,
  _alchemyStoneItemKey = nil,
  _materialWhereType = nil,
  _materialSlotNo = nil,
  _materialItemKey = nil,
  _materialItemCount = nil,
  _chargeEffectTime = 0,
  _upgradeEffectTime = 0,
  _evolveEffectTime = 0,
  _startEffectPlay = false,
  _originPanelSizeY = 0,
  _resultMsg = {},
  _audioId = nil,
  _audioIdXbox = nil,
  _isPadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_Renewal_All_1.lua")
runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_Renewal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AlchemyStone_All_Init")
function FromClient_AlchemyStone_All_Init()
  PaGlobal_AlchemyStone_Renewal_All:initialize()
end
