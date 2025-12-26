PaGlobal_Window_Accessory_StepUp_All = {
  _ui = {
    _stc_titleArea = nil,
    _btn_close = nil,
    _btn_question = nil,
    _stc_tabArea = nil,
    _stc_lb_consoleUI = nil,
    _stc_rb_consoleUI = nil,
    _radiobutton_stepUp = nil,
    _radiobutton_exchange = nil,
    _stc_selectBar = nil,
    _stc_line = nil,
    _stc_itemSelectArea = nil,
    _multilineText_msg = nil,
    _multilineText_notice = nil,
    _btn_confirm = nil,
    _stc_achieveTitle = nil,
    _stc_achieveCountBg = nil,
    _stc_itemStepUpArea = nil,
    _stc_selectItem = nil,
    _stc_selectItem_stcItem = nil,
    _stc_selectItem_stcCheck = nil,
    _multilineText_selectItem_itemName = nil,
    _stc_progressBg = nil,
    _progress2_total = nil,
    _stc_stepArea = nil,
    _stc_achieveNext = nil,
    _stc_achieveNextCountBG = nil,
    _btn_selectNextAccessory = nil,
    _stc_itemExchangeArea = nil,
    _multilineText_itemExchangeMsg = nil,
    _stc_exchangeBG = nil,
    _stc_before = nil,
    _stc_before_stcItem = nil,
    _stc_before_itemName = nil,
    _stc_before_check = nil,
    _stc_after = nil,
    _stc_after_stcItem = nil,
    _stc_after_itemName = nil,
    _stc_after_check = nil,
    _stc_exchangeEffect = nil,
    _txt_cost = nil,
    _btn_exchange = nil,
    _stc_keyGuide_console = nil,
    _txt_x_consoleUI = nil,
    _txt_b_consoleUI = nil,
    _txt_a_consoleUI = nil
  },
  _eUpdateType = {
    _TYPE_SELECT = 0,
    _TYPE_STEPUP = 1,
    _TYPE_EXCHANGE = 2
  },
  _eStepUpState = {
    _STATE_FINISH = 0,
    _STATE_PROGRESS = 1,
    _STATE_BEFORE = 2
  },
  _eExchangeState = {
    _STATE_SELECT_BEFORE = 0,
    _STATE_SELECT_AFTER = 1,
    _STATE_EXCHANGE_READY = 2
  },
  _selectAreaItemList = {},
  _exchangeAreaItemList = {},
  _stepUpList = {},
  _goalItemList = {},
  _materialList = {},
  _btnConfirmUV = {
    [0] = {
      x1 = 971,
      y1 = 923,
      x2 = 1277,
      y2 = 976
    },
    [1] = {
      x1 = 971,
      y1 = 977,
      x2 = 1277,
      y2 = 1030
    },
    [2] = {
      x1 = 971,
      y1 = 1031,
      x2 = 1277,
      y2 = 1084
    }
  },
  _stepTextureUV = {
    [0] = {
      x1 = 1,
      y1 = 863,
      x2 = 257,
      y2 = 1432
    },
    [1] = {
      x1 = 258,
      y1 = 863,
      x2 = 514,
      y2 = 1432
    },
    [2] = {
      x1 = 515,
      y1 = 863,
      x2 = 771,
      y2 = 1432
    }
  },
  _stepDotCompleteUv = {
    [0] = {
      x1 = 1150,
      y1 = 885,
      x2 = 1171,
      y2 = 906
    },
    [1] = {
      x1 = 1172,
      y1 = 885,
      x2 = 1193,
      y2 = 906
    },
    [2] = {
      x1 = 1194,
      y1 = 885,
      x2 = 1215,
      y2 = 906
    }
  },
  _stepMeterialGaugeUV = {
    [0] = {
      x1 = 1517,
      y1 = 456,
      x2 = 1616,
      y2 = 519
    },
    [1] = {
      x1 = 1512,
      y1 = 328,
      x2 = 1611,
      y2 = 391
    },
    [2] = {
      x1 = 1517,
      y1 = 520,
      x2 = 1616,
      y2 = 583
    },
    [3] = {
      x1 = 1512,
      y1 = 392,
      x2 = 1611,
      y2 = 455
    }
  },
  _slotConfig = {createIcon = true, createEnchant = true},
  _completeAccessoryGroupNo = 0,
  _currentAccessoryGroupNo = 0,
  _currentAccessoryIndex = 0,
  _currentAccessoryEnchantLevel = -1,
  _maxAccessoryGroupNo = 0,
  _maxCurrentAccessoryIndexCount = 0,
  _selectAccessoryIndex = 0,
  _registMaterialIndex = -1,
  _registMaterialCount = 0,
  _registMaterialSlotNo = 0,
  _exchangeBeforeIndex = nil,
  _exchangeAfterIndex = nil,
  _exchangeState = nil,
  _BASIC_MAX_ACCESSORY_INDEX = 3,
  _originPanelPosY = 0,
  _originStepUpGetBtnTxtPosX = 0,
  _timerNo = nil,
  _audioId = nil,
  _audioIdXbox = nil,
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Equipment/Panel_Window_Accessory_StepUp_All_1.lua")
runLua("UI_Data/Script/Window/Equipment/Panel_Window_Accessory_StepUp_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Window_Accessory_StepUp_All_Init")
function FromClient_Window_Accessory_StepUp_All_Init()
  PaGlobal_Window_Accessory_StepUp_All:initialize()
end
