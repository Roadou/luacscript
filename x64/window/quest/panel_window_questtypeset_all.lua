PaGlobal_QuestTypeSet_All = {
  _ui = {
    stc_desc = nil,
    stc_centerBg = nil,
    stc_deco = nil,
    stc_types = {},
    stc_selectedTypeDesc = nil,
    stc_selectedTypeNameBg = nil,
    txt_selectedTypeName = nil
  },
  _ui_console = {
    stc_keyGuideBg = nil,
    stc_confirm = nil,
    stc_cancle = nil
  },
  _questTypeStr = {
    [__eQuestSelectType_Count] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE1"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ALL")
    },
    [__eQuestSelectType_Main] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "LUA_CHARACTERINFO_QUEST_T_GENERAL"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_QUEST_GENERAL")
    },
    [__eQuestSelectType_BlackSpirit] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE2"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_BLACKSPIRIT")
    },
    [__eQuestSelectType_Sub] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE3"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_SUB")
    },
    [__eQuestSelectType_Adventure] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE4"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ADVENTURE")
    },
    [__eQuestSelectType_Life] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE5"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_LIFE")
    },
    [__eQuestSelectType_Contents] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE6"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_CONTENTS")
    },
    [__eQuestSelectType_Event] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE7"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_EVENT")
    },
    [__eQuestSelectType_Etc] = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_NEW_FAVORTYPE8"),
      titleDesc = PAGetString(Defines.StringSheet_GAME, "LUA_QUEST_FAVORTYPE_TOOLTIP_DESC_ETC")
    }
  },
  _questTypeGroup = {},
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestTypeSet_All_1.lua")
runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestTypeSet_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_QuestTypeSet_All_Init")
function FromClient_QuestTypeSet_All_Init()
  PaGlobal_QuestTypeSet_All:initialize()
end
