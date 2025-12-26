function PaGlobal_LocalQuestAlert:initialize()
  if true == PaGlobal_LocalQuestAlert._initialize then
    return
  end
  Panel_Widget_LocalQuestAlert:SetShow(false)
  PaGlobal_LocalQuestAlert._ui.txt_title = UI.getChildControl(PaGlobal_LocalQuestAlert._ui.stc_bg, "Static_Title")
  PaGlobal_LocalQuestAlert._ui.txt_desc = UI.getChildControl(PaGlobal_LocalQuestAlert._ui.stc_bg, "Static_Desc")
  PaGlobal_LocalQuestAlert._ui.txt_title:SetTextMode(__eTextMode_Limit_AutoWrap)
  PaGlobal_LocalQuestAlert._ui.txt_desc:SetTextMode(__eTextMode_Limit_AutoWrap)
  local LOCATION = PaGlobal_LocalQuestAlert._LOCAL
  PaGlobal_LocalQuestAlert._info[LOCATION.CALPHEON] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_2"),
    texture = "CalpheonClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_CALPHEON")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.BALENOS] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_0"),
    texture = "BalenosClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_BALENOS")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.VALENCIA] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_8"),
    texture = "ValenciaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_VALENCIA")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.SERENDIA] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_2"),
    texture = "SerendiaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_SERENDIA")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.CALPHEON2] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_2"),
    texture = "CalpheonClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_CALPHEON_RE")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.SERENDIA2] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_2A"),
    texture = "SerendiaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_SERENDIA2")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MEDIA] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_3"),
    texture = "MediaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MEDIA")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.DRIGAN] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_7"),
    texture = "DrieghanClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_DRIGAN")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.KAMASYLVIA] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_9"),
    texture = "KamasylviaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_KAMASYLVIA")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ODYLLITA] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_11"),
    texture = "OdyllitaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_OTHILITA")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MOUNTAINOFETERNALWINTER] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_12"),
    texture = "SnowMountainClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ETERNALWINTER")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLAND] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_13"),
    texture = "MorningLandClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLAND")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_01] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_01"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_01")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_02] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_02"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_02")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_03] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_03"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_03")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_04] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_04"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_04")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_05] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_05"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_05")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_06] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_06"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_06")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_07] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_07"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_07")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_08] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_08"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_08")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_09] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_09"),
    texture = "MorningLandBossEnding.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_09")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_10] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_10"),
    texture = "MorningLandBossEnding_2.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_10")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_11] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_11"),
    texture = "MorningLandBossEnding_2.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_11")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_12] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGEPISODE_12"),
    texture = "MorningLandBossEnding_2.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_12")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDEPISODE_13] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_13"),
    texture = "MorningLandBossEnding_2.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDEPISODE_13")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.DRAGONPALACEEPISODE_01] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_DRAGONPALACEEPISODE_01"),
    texture = "DragonPalaceClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_DRAGONPALACEEPISODE_01")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.DRAGONPALACEEPISODE_02] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_DRAGONPALACEEPISODE_02"),
    texture = "DragonPalaceClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_DRAGONPALACEEPISODE_02")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.DRAGONPALACEEPISODE_03] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_DRAGONPALACEEPISODE_03"),
    texture = "DragonPalaceClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_DRAGONPALACEEPISODE_03")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.DRAGONPALACEEPISODE_04] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_DRAGONPALACEEPISODE_04"),
    texture = "DragonPalaceClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_DRAGONPALACEEPISODE_04")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ULUKITA] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_14"),
    texture = "UlukitaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ULUKITA")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ROSEWAR] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_14"),
    texture = "Nak_ElfwarClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ROSEWAR")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ROSEWAR] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_14"),
    texture = "Nak_ElfwarClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ROSEWAR")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ATORAXION_1] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_ATORAXION_1"),
    texture = "AtoraxxionClear_1.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ATORAXION_1")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ATORAXION_2] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_ATORAXION_2"),
    texture = "AtoraxxionClear_2.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ATORAXION_2")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ATORAXION_3] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_ATORAXION_3"),
    texture = "AtoraxxionClear_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ATORAXION_3")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ATORAXION_4] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_ATORAXION_4"),
    texture = "AtoraxxionClear_4.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ATORAXION_4")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.ATORAXION_5] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_ATORAXION_5"),
    texture = "AtoraxxionClear_5.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_ATORAXION_5")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_16"),
    texture = "MorningLandClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_01] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_01"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_01")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_02] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_02"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_02")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_03] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_03"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_03")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_04] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_04"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_04")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_05] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_05"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_05")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_06] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_06"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_06")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_07] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_07"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_07")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_08] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_08"),
    texture = "MorningLandBossEnding_3.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_08")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_09] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_09"),
    texture = "MorningLandBossEnding_4.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_09")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_10] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_10"),
    texture = "MorningLandBossEnding_4.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_10")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_11] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_11"),
    texture = "MorningLandBossEnding_4.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_11")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.MORNINGLANDPT2EPISODE_12] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_MORNINGPT2EPISODE_12"),
    texture = "MorningLandBossEnding_4.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_MORNINGLANDPT2EPISODE_12")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.EDANIAPT1] = {
    location = PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_REGION_17"),
    texture = "EdaniaClear.dds",
    title = "",
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_EDANIAPT1")
  }
  PaGlobal_LocalQuestAlert._info[LOCATION.OLVIAACADEMY_ENTER] = {
    location = "[\236\138\164\237\138\184\235\167\129\237\130\164 \237\149\132\236\154\148]\236\152\172\235\185\132\236\149\132 \236\149\132\236\185\180\235\141\176\235\175\184 N\234\184\176 \236\158\133\237\149\153\236\157\132 \236\182\149\237\149\152\237\149\169\235\139\136\235\139\164.",
    texture = "OlbiaAcademyClear.dds",
    title = "",
    desc = "[\236\138\164\237\138\184\235\167\129\237\130\164 \237\149\132\236\154\148]\236\167\128\234\184\136\235\182\128\237\132\176 \236\152\172\235\185\132\236\149\132 \236\149\132\236\185\180\235\141\176\235\175\184 N\234\184\176 \237\149\153\235\182\128\236\131\157\236\158\133\235\139\136\235\139\164.\n\236\152\172\235\185\132\236\149\132 \237\149\153\234\181\144\236\151\144\236\132\156 \236\167\132\237\150\137\235\144\152\235\138\148 \236\157\152\235\162\176\235\165\188 \236\153\132\235\163\140\237\149\152\234\179\160, \235\141\148 \235\169\139\236\167\132 \235\170\168\237\151\152\234\176\128\235\161\156 \236\132\177\236\158\165\237\149\180 \235\179\180\236\132\184\236\154\148!\n\237\153\148\235\169\180 \236\154\176\236\184\161 \236\131\129\235\139\168\236\151\144 \237\145\156\236\139\156\235\144\152\235\138\148 '\236\152\172\235\185\132\236\149\132 \236\149\132\236\185\180\235\141\176\235\175\184' \236\149\132\236\157\180\236\189\152\236\157\132 \237\134\181\237\149\180 \236\167\132\237\150\137 \236\131\129\237\153\169\236\157\132 \237\153\149\236\157\184\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164."
  }
  PaGlobal_LocalQuestAlert._questInfo = {
    {
      21002,
      20,
      LOCATION.BALENOS
    },
    {
      655,
      6,
      LOCATION.BALENOS
    },
    {
      21125,
      96,
      LOCATION.BALENOS
    },
    {
      21027,
      13,
      LOCATION.SERENDIA
    },
    {
      21012,
      3,
      LOCATION.SERENDIA
    },
    {
      21205,
      11,
      LOCATION.SERENDIA
    },
    {
      21303,
      8,
      LOCATION.SERENDIA
    },
    {
      665,
      5,
      LOCATION.SERENDIA
    },
    {
      21130,
      147,
      LOCATION.SERENDIA
    },
    {
      21135,
      20,
      LOCATION.SERENDIA2
    },
    {
      21108,
      1,
      LOCATION.CALPHEON
    },
    {
      678,
      6,
      LOCATION.CALPHEON
    },
    {
      862,
      6,
      LOCATION.CALPHEON
    },
    {
      21139,
      112,
      LOCATION.CALPHEON2
    },
    {
      21411,
      14,
      LOCATION.MEDIA
    },
    {
      5529,
      21,
      LOCATION.VALENCIA
    },
    {
      6002,
      28,
      LOCATION.KAMASYLVIA
    },
    {
      21601,
      96,
      LOCATION.KAMASYLVIA
    },
    {
      21601,
      97,
      LOCATION.KAMASYLVIA
    },
    {
      7104,
      13,
      LOCATION.DRIGAN
    },
    {
      8004,
      88,
      LOCATION.ODYLLITA
    },
    {
      7500,
      120,
      LOCATION.MOUNTAINOFETERNALWINTER
    },
    {
      8524,
      22,
      LOCATION.MORNINGLAND
    },
    {
      8503,
      30,
      LOCATION.MORNINGLANDEPISODE_01
    },
    {
      8504,
      33,
      LOCATION.MORNINGLANDEPISODE_02
    },
    {
      8505,
      29,
      LOCATION.MORNINGLANDEPISODE_03
    },
    {
      8506,
      30,
      LOCATION.MORNINGLANDEPISODE_04
    },
    {
      8507,
      28,
      LOCATION.MORNINGLANDEPISODE_05
    },
    {
      8508,
      30,
      LOCATION.MORNINGLANDEPISODE_06
    },
    {
      8509,
      24,
      LOCATION.MORNINGLANDEPISODE_07
    },
    {
      8512,
      18,
      LOCATION.MORNINGLANDEPISODE_08
    },
    {
      8512,
      25,
      LOCATION.MORNINGLANDEPISODE_08
    },
    {
      8513,
      17,
      LOCATION.MORNINGLANDEPISODE_09
    },
    {
      8513,
      28,
      LOCATION.MORNINGLANDEPISODE_09
    },
    {
      8511,
      16,
      LOCATION.MORNINGLANDEPISODE_10
    },
    {
      8510,
      8,
      LOCATION.MORNINGLANDEPISODE_11
    },
    {
      8514,
      16,
      LOCATION.MORNINGLANDEPISODE_12
    },
    {
      8514,
      17,
      LOCATION.MORNINGLANDEPISODE_12
    },
    {
      8515,
      10,
      LOCATION.MORNINGLANDEPISODE_13
    },
    {
      8750,
      5,
      LOCATION.DRAGONPALACEEPISODE_01
    },
    {
      8751,
      4,
      LOCATION.DRAGONPALACEEPISODE_02
    },
    {
      8754,
      6,
      LOCATION.DRAGONPALACEEPISODE_03
    },
    {
      8753,
      12,
      LOCATION.DRAGONPALACEEPISODE_04
    },
    {
      21424,
      4,
      LOCATION.ULUKITA
    },
    {
      21606,
      8,
      LOCATION.ROSEWAR
    },
    {
      21607,
      8,
      LOCATION.ROSEWAR
    },
    {
      9027,
      44,
      LOCATION.ATORAXION_1
    },
    {
      9033,
      37,
      LOCATION.ATORAXION_2
    },
    {
      9049,
      42,
      LOCATION.ATORAXION_3
    },
    {
      9064,
      43,
      LOCATION.ATORAXION_4
    },
    {
      9064,
      46,
      LOCATION.ATORAXION_5
    },
    {
      8541,
      3,
      LOCATION.MORNINGLANDPT2
    },
    {
      8532,
      34,
      LOCATION.MORNINGLANDPT2EPISODE_01
    },
    {
      8534,
      28,
      LOCATION.MORNINGLANDPT2EPISODE_02
    },
    {
      8529,
      26,
      LOCATION.MORNINGLANDPT2EPISODE_03
    },
    {
      8536,
      31,
      LOCATION.MORNINGLANDPT2EPISODE_04
    },
    {
      8531,
      36,
      LOCATION.MORNINGLANDPT2EPISODE_05
    },
    {
      8530,
      32,
      LOCATION.MORNINGLANDPT2EPISODE_06
    },
    {
      8535,
      41,
      LOCATION.MORNINGLANDPT2EPISODE_07
    },
    {
      8533,
      38,
      LOCATION.MORNINGLANDPT2EPISODE_08
    },
    {
      8537,
      7,
      LOCATION.MORNINGLANDPT2EPISODE_09
    },
    {
      8538,
      5,
      LOCATION.MORNINGLANDPT2EPISODE_10
    },
    {
      8539,
      6,
      LOCATION.MORNINGLANDPT2EPISODE_11
    },
    {
      8540,
      2,
      LOCATION.MORNINGLANDPT2EPISODE_12
    },
    {
      9107,
      5,
      LOCATION.EDANIAPT1
    },
    {
      2308,
      1,
      LOCATION.OLVIAACADEMY_ENTER
    }
  }
  PaGlobal_LocalQuestAlert:registEventHandler()
  PaGlobal_LocalQuestAlert:validate()
  PaGlobal_LocalQuestAlert._initialize = true
end
function PaGlobal_LocalQuestAlert:registEventHandler()
  if nil == Panel_Widget_LocalQuestAlert then
    return
  end
  registerEvent("EventQuestUpdateNotify", "FromClient_LocalQuestAlert_QuestClearAlert")
end
function PaGlobal_LocalQuestAlert:prepareOpen(isForced)
  if nil == Panel_Widget_LocalQuestAlert then
    return
  end
  if (-1 ~= PaGlobal_LocalQuestAlert._completeInfoKey or true == isForced) and false == Panel_Widget_LocalQuestAlert:GetShow() then
    local currentInfo = PaGlobal_LocalQuestAlert._info[PaGlobal_LocalQuestAlert._completeInfoKey]
    if true == isForced then
      currentInfo = PaGlobal_LocalQuestAlert._info[1]
    end
    PaGlobal_LocalQuestAlert._ui.stc_bg:ChangeTextureInfoNameAsync("new_ui_common_forlua/widget/nakmessage/" .. currentInfo.texture)
    if PaGlobal_LocalQuestAlert._LOCAL.ROSEWAR == PaGlobal_LocalQuestAlert._completeInfoKey then
      PaGlobal_LocalQuestAlert._ui.txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_QUESTLIST_HISTORY_TXT_ROSEWAR"))
    else
      PaGlobal_LocalQuestAlert._ui.txt_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALQUESTALERT_TITLE", "region", currentInfo.location))
    end
    PaGlobal_LocalQuestAlert._ui.txt_desc:SetText(currentInfo.desc)
    if false == ToClient_isConsole() then
      audioPostEvent_SystemUi(4, 13)
    else
      _AudioPostEvent_SystemUiForXBOX(4, 13)
    end
    PaGlobal_LocalQuestAlert._ui.stc_bg:AddEffect("fUI_Light", false, 0, 0)
    PaGlobal_LocalQuestAlert._ui.stc_bg:AddEffect("UI_QustComplete01", false, 0, 0)
    PaGlobal_LocalQuestAlert._ui.stc_bg:AddEffect("UI_QustComplete02", false, 0, 0)
    PaGlobal_LocalQuestAlert._ui.stc_bg:AddEffect("fUI_QuestComplete", false, 0, 0)
    PaGlobal_LocalQuestAlert:open()
  end
end
function PaGlobal_LocalQuestAlert:open()
  if nil == Panel_Widget_LocalQuestAlert then
    return
  end
  if false == Panel_Widget_LocalQuestAlert:GetShow() then
    PaGlobal_LocalQuestAlert._completeInfoKey = -1
    PaGloabl_LocalQuestAlert_ShowAni()
    PaGloabl_LocalQuestAlert_HideAni()
  end
end
function PaGlobal_LocalQuestAlert:validate()
  if nil == Panel_Widget_LocalQuestAlert then
    return
  end
  PaGlobal_LocalQuestAlert._ui.stc_bg:isValidate()
  PaGlobal_LocalQuestAlert._ui.txt_title:isValidate()
  PaGlobal_LocalQuestAlert._ui.txt_desc:isValidate()
end
