PaGlobal_DialogList_All = {
  _ui = {
    stc_titleBg = nil,
    stc_title = nil,
    stc_titleDeco = nil,
    stc_splitTabBg = nil,
    btn_splitRadiolist = {},
    stc_selectBar = nil,
    list2_button = nil,
    stc_subBg = nil
  },
  _ui_pc = {stc_listKeyGuideBg = nil, txt_listKeyGuide = nil},
  _ui_console = {
    stc_bottomBg = nil,
    stc_iconA = nil,
    stc_iconB = nil,
    stc_iconLB = nil,
    stc_iconRB = nil
  },
  _dialogButtonIcon = {
    [0] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 319,
      y1 = 339,
      x2 = 349,
      y2 = 369
    },
    [1] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 412,
      y1 = 339,
      x2 = 442,
      y2 = 369
    },
    [2] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 443,
      y1 = 339,
      x2 = 473,
      y2 = 369
    },
    [3] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 381,
      y1 = 339,
      x2 = 411,
      y2 = 369
    },
    [4] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 350,
      y1 = 339,
      x2 = 380,
      y2 = 369
    },
    [5] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 350,
      y1 = 339,
      x2 = 380,
      y2 = 369
    },
    [6] = {
      texture = "Renewal/UI_Icon/Console_DialogueIcon_00.dds",
      x1 = 218,
      y1 = 1,
      x2 = 248,
      y2 = 31
    },
    [7] = {
      texture = "Combine/Icon/Combine_Dialogue_Icon_00.dds",
      x1 = 381,
      y1 = 339,
      x2 = 411,
      y2 = 369
    }
  },
  _dialogTitleType = {
    [CppEnums.DialogState.eDialogState_Talk] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_TALK"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 230,
      y1 = 230,
      x2 = 285,
      y2 = 285
    },
    [CppEnums.DialogState.eDialogState_QuestList] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_QUEST"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 59,
      y1 = 2,
      x2 = 114,
      y2 = 57
    },
    [CppEnums.DialogState.eDialogState_Help] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_HELP"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 59,
      y1 = 2,
      x2 = 114,
      y2 = 57
    },
    [CppEnums.DialogState.eDialogState_Exchange] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_EXCHANGE"),
      texture = "combine/icon/combine_title_icon_00.dds",
      x1 = 230,
      y1 = 230,
      x2 = 285,
      y2 = 285
    },
    [CppEnums.DialogState.eDialogState_MainQuestList] = {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_ALL_WINDOWTITLE_MAINQUEST"),
      texture = "combine/icon/combine_dialogue_icon_00.dds",
      x1 = 83,
      y1 = 452,
      x2 = 123,
      y2 = 492
    }
  },
  _dialogListCount = 0,
  _listShowMaxCount = 0,
  _listContentSizeY = 0,
  _listOriginSizeY = 0,
  _panelOriginSizeY = 0,
  _isQuestComplete = false,
  _isContactTalk = false,
  _btnSplitString = {},
  _splitIdx = 0,
  _SPLIT_IDX = {
    ALL = 0,
    RECOMMENDATION = 1,
    REPEAT = 2,
    MAIN = 3
  },
  _moveAblelist = {},
  _listKeyGuideString = {
    [0] = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_KEYGUIDE_NORMAL"),
    [1] = PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_LIST_KEYGUIDE_BLACKSPIRIT")
  },
  _questLoadingDataList = nil,
  _initialize = false
}
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All_1.lua")
runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_DialogList_All_Init")
function FromClient_DialogList_All_Init()
  PaGlobal_DialogList_All:initialize()
end
