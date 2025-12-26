PaGlobal_WorkerRandomSelect_All = {
  _ui = {
    _stc_TitleBg = nil,
    _btn_Close_PC = nil,
    _btn_Question_PC = nil,
    _stc_workerPick = nil,
    _stc_ImgBg = nil,
    _stc_WokerImg = nil,
    _stc_WorkerTier = nil,
    _txt_WorkerName = nil,
    _txt_WorkerSpeed = nil,
    _txt_WokrerMoveSpeed = nil,
    _txt_WokrerLuck = nil,
    _txt_WorkerActionPoint = nil,
    _stc_WorkerEmployBg = nil,
    _txt_WorkerEmployCount = nil,
    _stc_CurrentEnergyBg = nil,
    _icon_CurrentEnergy = nil,
    _txt_CurrentEnergy = nil,
    _stc_WorkerHireFeeBg = nil,
    _icon_WorkerHireFee = nil,
    _txt_WorkerHireFee = nil,
    _stc_MoneyArea = nil,
    _txt_MoneyValue = nil,
    _rdo_WareMoney = nil,
    _txt_WareMoney = nil,
    _btn_Continuation_PC = nil,
    _btn_OtherWorker_PC = nil,
    _btn_HireWorker_PC = nil,
    _stc_KeyGuideBg = nil,
    _stc_KeyGuide_A = nil,
    _stc_KeyGuide_B = nil,
    _stc_KeyGuide_X = nil,
    _stc_KeyGuide_Y = nil,
    _stc_Plus_ConsoleUI = nil,
    _stc_X_With_RT_ConsoleUI = nil,
    _stc_RT_With_X_ConsoleUI = nil,
    _stc_WorkerTierBg = {
      [0] = nil,
      [1] = nil
    },
    _stc_WorkerImage = {
      [0] = nil,
      [1] = nil
    },
    _list2_region = nil,
    _stc_notSelectRegion = nil,
    _stc_blockBg = nil
  },
  _currentWorkerinfo = {_workerIdx = nil, _workerPrice64 = nil},
  _config = {_repetitionCount = nil, _workerGrade = nil},
  _ENUM_GRADE = {
    NORMAL = 0,
    SKILLED = 1,
    EXPERT = 2,
    ONLYMASTER = 3
  },
  _originPanelSpanY = 0,
  _HIRECOST = 5,
  _REFRESH_RATE = 0.4,
  _delta_Time = nil,
  _Count = 0,
  _checkPopUp = nil,
  _isCurrectWorkerCondition = false,
  _isContinueSelectWorkerStart = false,
  _keyGuides = {},
  _filteredWorker = {},
  _isConsole = false,
  _initialize = false,
  _nextIndex = 0,
  _currentCount = 0,
  _selectedCharacterKey = nil,
  _selectedRegionKeyRaw = nil,
  _selectedRegionKeyRawTemp = nil,
  _workerRegionList = {},
  _separatorNumber = 100,
  _verticalControlPos = 0,
  _list2CurrentIndex = 0,
  _selectedTerritoryKeyRaw = nil,
  _territoryContentsOption = {
    [0] = true,
    [1] = true,
    [2] = _ContentsGroup_Calpheon,
    [3] = _ContentsGroup_Media,
    [4] = _ContentsGroup_Valencia,
    [5] = true,
    [6] = _ContentsGroup_Kamasilvia,
    [7] = _ContentsGroup_Dragan,
    [8] = _ContentsGroup_Othilita,
    [9] = _ContentsGroup_MountainOfEternalWinter,
    [10] = _ContentsGroup_MorningLand,
    [11] = _ContentsGroup_MediaPt2,
    [12] = true
  },
  _gradePath = "Combine/Frame/Combine_Frame_00.dds",
  _grade = {
    [0] = {
      1,
      228,
      45,
      272
    },
    [1] = {
      46,
      228,
      90,
      272
    },
    [2] = {
      91,
      228,
      135,
      272
    },
    [3] = {
      136,
      228,
      180,
      272
    },
    [4] = {
      181,
      228,
      225,
      272
    }
  }
}
runLua("UI_Data/Script/Window/WokerHire/Panel_Window_WorkerRandomSelect_All_1.lua")
runLua("UI_Data/Script/Window/WokerHire/Panel_Window_WorkerRandomSelect_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_WorkerRandomSelectInit")
function FromClient_WorkerRandomSelectInit()
  PaGlobal_WorkerRandomSelect_All:initialize()
end
