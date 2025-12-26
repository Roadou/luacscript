PaGlobal_MorningLand_Scenario_All = {
  _ui = {
    frame_list = nil,
    frame_content = nil,
    txt_desc = nil,
    scroll_vs = nil,
    scroll_vsCtrl = nil
  },
  _ui_pc = {
    btn_Close = nil,
    btn_Navi = nil,
    btn_AutoNavi = nil
  },
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil,
    txt_KeyGuideRS = nil
  },
  _normalDetailInfo = {
    [1] = {
      _groupId = 8503,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_1")
    },
    [2] = {
      _groupId = 8504,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_2")
    },
    [3] = {
      _groupId = 8505,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_3")
    },
    [4] = {
      _groupId = 8506,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_4")
    },
    [5] = {
      _groupId = 8507,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_5")
    },
    [6] = {
      _groupId = 8508,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_6")
    },
    [7] = {
      _groupId = 8509,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_7")
    },
    [8] = {
      _groupId = 8511,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_8")
    }
  },
  _normalDetailInfo2 = {
    [1] = {
      _groupId = 8532,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_14")
    },
    [2] = {
      _groupId = 8534,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_15")
    },
    [3] = {
      _groupId = 8529,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_16")
    },
    [4] = {
      _groupId = 8536,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_17")
    },
    [5] = {
      _groupId = 8531,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_18")
    },
    [6] = {
      _groupId = 8530,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_19")
    },
    [7] = {
      _groupId = 8535,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_20")
    },
    [8] = {
      _groupId = 8533,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_21")
    }
  },
  _hiddenDetailInfo = {
    [1] = {
      _groupId = 8510,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_9")
    },
    [2] = {
      _groupId = 8512,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_10")
    },
    [3] = {
      _groupId = 8513,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_11")
    },
    [4] = {
      _groupId = 8514,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_12")
    },
    [5] = {
      _groupId = 8515,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_13")
    },
    [6] = {
      _groupId = 8524,
      _desc = "\236\150\180\235\138\144 \235\130\160, \235\170\189\235\163\161\236\151\144\234\178\140 \236\160\132\237\149\180\236\167\132 \236\132\156\236\176\176 \237\149\152\235\130\152.\n\235\139\172\235\178\140\236\151\144 \236\155\144\236\157\184 \235\170\168\235\165\188 \236\151\173\235\179\145\236\157\180 \235\176\156\235\179\145\237\149\152\235\160\164\n\237\149\156\235\139\164\235\138\148 \235\130\180\236\154\169\236\157\180 \235\139\180\234\178\168\236\158\136\235\139\164.\n\234\178\128\236\157\128 \235\185\132, \234\178\128\236\157\128 \235\172\188... \235\140\128\236\178\180\n\235\172\180\236\138\168 \236\157\188\236\157\180 \236\157\188\236\150\180\235\130\152\235\160\164\235\138\148 \234\177\184\234\185\140?"
    }
  },
  _hiddenDetailInfo2 = {
    [1] = {
      _groupId = 8537,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_22")
    },
    [2] = {
      _groupId = 8538,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_23")
    },
    [3] = {
      _groupId = 8539,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_24")
    },
    [4] = {
      _groupId = 8540,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_25")
    },
    [5] = {
      _groupId = 8541,
      _desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_QUESTBOARD_DESC_26")
    }
  },
  _naviGroup = nil,
  _isAuto = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_Scenario_All_1.lua")
runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_Scenario_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MorningLand_Scenario_All")
function FromClient_PaGlobal_MorningLand_Scenario_All()
  PaGlobal_MorningLand_Scenario_All:initialize()
end
