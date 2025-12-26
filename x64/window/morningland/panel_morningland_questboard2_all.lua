PaGlobal_MorningLand_QuestBoard_All = {
  _ui = {
    stc_Title = nil,
    stc_Effect = nil,
    stc_tabArea = nil,
    rdo_morning1 = nil,
    stc_selected1 = nil,
    rdo_morning2 = nil,
    stc_selected2 = nil,
    stc_contentArea = nil,
    stc_QuestNormalArea = nil,
    stc_QuestHiddenArea = nil,
    stc_QuestNormalArea2 = nil,
    stc_QuestHiddenArea2 = nil,
    btn_Left = nil,
    btn_Right = nil,
    btn_QuestNormal = {},
    btn_QuestHidden = {},
    btn_QuestNormal2 = {},
    btn_QuestHidden2 = {},
    stc_NoticeBg = nil,
    txt_Notice = nil,
    btn_Scroll_L = nil,
    btn_Scroll_R = nil,
    stc_PageArea = nil,
    rdo_1 = nil,
    rdo_2 = nil,
    rdo_3 = nil,
    rdo_4 = nil
  },
  _ui_pc = {btn_Close = nil, btn_Question = nil},
  _ui_console = {
    stc_KeyGuideBG = nil,
    txt_KeyGuideA = nil,
    txt_KeyGuideB = nil,
    txt_KeyGuideL = nil,
    txt_KeyGuideR = nil
  },
  _eQuestTab = {
    eNormal = 0,
    eHidden = 1,
    eNormal2 = 2,
    eHidden2 = 3
  },
  _normalInfo = {
    [1] = {
      _groupId = 8503,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_01"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 1117,
          x2 = 1395,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 1117,
          x2 = 1395,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 559,
            x2 = 837,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 559,
            x2 = 837,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 23
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 280,
            x2 = 558,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 280,
            x2 = 558,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 26
        }
      },
      _booKSelfGroupId = 8700,
      _booKSelfQuestId = 1
    },
    [2] = {
      _groupId = 8504,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_02"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 1,
          x2 = 279,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 1,
          x2 = 279,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 280,
            x2 = 558,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 280,
            x2 = 558,
            y1 = 385,
            y2 = 768
          },
          _questId = 21
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 385,
            y2 = 768
          },
          _questId = 25
        }
      },
      _booKSelfGroupId = 8701,
      _booKSelfQuestId = 1
    },
    [3] = {
      _groupId = 8505,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_03"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 559,
          x2 = 837,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 559,
          x2 = 837,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 22
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 1117,
            x2 = 1395,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1117,
            x2 = 1395,
            y1 = 385,
            y2 = 768
          },
          _questId = 25
        }
      },
      _booKSelfGroupId = 8702,
      _booKSelfQuestId = 1
    },
    [4] = {
      _groupId = 8506,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_04"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 280,
          x2 = 558,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 280,
          x2 = 558,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 838,
            x2 = 1116,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 838,
            x2 = 1116,
            y1 = 385,
            y2 = 768
          },
          _questId = 20
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 559,
            x2 = 837,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 559,
            x2 = 837,
            y1 = 385,
            y2 = 768
          },
          _questId = 25
        }
      },
      _booKSelfGroupId = 8703,
      _booKSelfQuestId = 1
    },
    [5] = {
      _groupId = 8507,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_05"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 1,
          x2 = 279,
          y1 = 769,
          y2 = 1152
        },
        _on = {
          x1 = 1,
          x2 = 279,
          y1 = 1153,
          y2 = 1536
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 1117,
            x2 = 1395,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 1117,
            x2 = 1395,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 20
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_04.dds",
          _base = {
            x1 = 838,
            x2 = 1116,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 838,
            x2 = 1116,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 24
        }
      },
      _booKSelfGroupId = 8704,
      _booKSelfQuestId = 1
    },
    [6] = {
      _groupId = 8508,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_06"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 280,
          x2 = 558,
          y1 = 769,
          y2 = 1152
        },
        _on = {
          x1 = 280,
          x2 = 558,
          y1 = 1153,
          y2 = 1536
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_05.dds",
          _base = {
            x1 = 280,
            x2 = 558,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 280,
            x2 = 558,
            y1 = 385,
            y2 = 768
          },
          _questId = 30
        }
      },
      _booKSelfGroupId = 8705,
      _booKSelfQuestId = 1
    },
    [7] = {
      _groupId = 8509,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_07"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 838,
          x2 = 1116,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 838,
          x2 = 1116,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_05.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 385,
            y2 = 768
          },
          _questId = 24
        }
      },
      _booKSelfGroupId = 8706,
      _booKSelfQuestId = 1
    },
    [8] = {
      _groupId = 8511,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_08"),
      _normalUV = {
        _dds = "combine/etc/combine_etc_morningland_mainquest.dds",
        _base = {
          x1 = 559,
          x2 = 837,
          y1 = 769,
          y2 = 1152
        },
        _on = {
          x1 = 559,
          x2 = 837,
          y1 = 1153,
          y2 = 1536
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_05.dds",
          _base = {
            x1 = 559,
            x2 = 837,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 559,
            x2 = 837,
            y1 = 385,
            y2 = 768
          },
          _questId = 16
        }
      },
      _booKSelfGroupId = 8707,
      _booKSelfQuestId = 3
    }
  },
  _normalInfo2 = {
    [1] = {
      _groupId = 8532,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_01"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 1117,
          x2 = 1395,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 1117,
          x2 = 1395,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 838,
            x2 = 1116,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 838,
            x2 = 1116,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 26
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 1117,
            x2 = 1395,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 1117,
            x2 = 1395,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 29
        }
      },
      _booKSelfGroupId = 8542,
      _booKSelfQuestId = 1
    },
    [2] = {
      _groupId = 8534,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_02"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 1,
          x2 = 279,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 1,
          x2 = 279,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 385,
            y2 = 768
          },
          _questId = 22
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 280,
            x2 = 558,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 280,
            x2 = 558,
            y1 = 385,
            y2 = 768
          },
          _questId = 26
        }
      },
      _booKSelfGroupId = 8543,
      _booKSelfQuestId = 1
    },
    [3] = {
      _groupId = 8529,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_03"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 559,
          x2 = 837,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 559,
          x2 = 837,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 1117,
            x2 = 1395,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1117,
            x2 = 1395,
            y1 = 385,
            y2 = 768
          },
          _questId = 22
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 25
        }
      },
      _booKSelfGroupId = 8544,
      _booKSelfQuestId = 1
    },
    [4] = {
      _groupId = 8536,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_04"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 838,
          x2 = 1116,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 838,
          x2 = 1116,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 280,
            x2 = 558,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 280,
            x2 = 558,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 29
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 559,
            x2 = 837,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 559,
            x2 = 837,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 28
        }
      },
      _booKSelfGroupId = 8545,
      _booKSelfQuestId = 1
    },
    [5] = {
      _groupId = 8531,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_05"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 280,
          x2 = 558,
          y1 = 1,
          y2 = 384
        },
        _on = {
          x1 = 280,
          x2 = 558,
          y1 = 385,
          y2 = 768
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 559,
            x2 = 837,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 559,
            x2 = 837,
            y1 = 385,
            y2 = 768
          },
          _questId = 31
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_09.dds",
          _base = {
            x1 = 838,
            x2 = 1116,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 838,
            x2 = 1116,
            y1 = 385,
            y2 = 768
          },
          _questId = 35
        }
      },
      _booKSelfGroupId = 8546,
      _booKSelfQuestId = 1
    },
    [6] = {
      _groupId = 8530,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_06"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 280,
          x2 = 558,
          y1 = 769,
          y2 = 1152
        },
        _on = {
          x1 = 280,
          x2 = 558,
          y1 = 1153,
          y2 = 1536
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_10.dds",
          _base = {
            x1 = 559,
            x2 = 837,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 559,
            x2 = 837,
            y1 = 385,
            y2 = 768
          },
          _questId = 26
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_10.dds",
          _base = {
            x1 = 838,
            x2 = 1116,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 838,
            x2 = 1116,
            y1 = 385,
            y2 = 768
          },
          _questId = 31
        }
      },
      _booKSelfGroupId = 8547,
      _booKSelfQuestId = 1
    },
    [7] = {
      _groupId = 8535,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_07"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 1,
          x2 = 279,
          y1 = 769,
          y2 = 1152
        },
        _on = {
          x1 = 1,
          x2 = 279,
          y1 = 1153,
          y2 = 1536
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_10.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 385,
            y2 = 768
          },
          _questId = 30
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_10.dds",
          _base = {
            x1 = 280,
            x2 = 558,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 280,
            x2 = 558,
            y1 = 385,
            y2 = 768
          },
          _questId = 39
        }
      },
      _booKSelfGroupId = 8548,
      _booKSelfQuestId = 1
    },
    [8] = {
      _groupId = 8533,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_08"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_08.dds",
        _base = {
          x1 = 559,
          x2 = 837,
          y1 = 769,
          y2 = 1152
        },
        _on = {
          x1 = 559,
          x2 = 837,
          y1 = 1153,
          y2 = 1536
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_10.dds",
          _base = {
            x1 = 1117,
            x2 = 1395,
            y1 = 1,
            y2 = 384
          },
          _on = {
            x1 = 1117,
            x2 = 1395,
            y1 = 385,
            y2 = 768
          },
          _questId = 33
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_10.dds",
          _base = {
            x1 = 1,
            x2 = 279,
            y1 = 769,
            y2 = 1152
          },
          _on = {
            x1 = 1,
            x2 = 279,
            y1 = 1153,
            y2 = 1536
          },
          _questId = 37
        }
      },
      _booKSelfGroupId = 8549,
      _booKSelfQuestId = 1
    }
  },
  _hiddenInfo = {
    [1] = {
      _groupId = 8510,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_09"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
        _base = {
          x1 = 1,
          x2 = 171,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 1,
          x2 = 171,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 1,
            x2 = 171,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 1,
            x2 = 171,
            y1 = 407,
            y2 = 812
          },
          _questId = 8
        }
      },
      _booKSelfGroupId = 8710,
      _booKSelfQuestId = 1
    },
    [2] = {
      _groupId = 8512,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_10"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
        _base = {
          x1 = 172,
          x2 = 342,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 172,
          x2 = 342,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 856,
            x2 = 1026,
            y1 = 1,
            y2 = 406
          },
          _on = {
            x1 = 856,
            x2 = 1026,
            y1 = 1,
            y2 = 406
          },
          _questId = 12
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 172,
            x2 = 342,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 172,
            x2 = 342,
            y1 = 407,
            y2 = 812
          },
          _questId = 19
        }
      },
      _booKSelfGroupId = 8707,
      _booKSelfQuestId = 1
    },
    [3] = {
      _groupId = 8513,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_11"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
        _base = {
          x1 = 343,
          x2 = 513,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 343,
          x2 = 513,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 343,
            x2 = 513,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 343,
            x2 = 513,
            y1 = 407,
            y2 = 812
          },
          _questId = 12
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 856,
            x2 = 1026,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 856,
            x2 = 1026,
            y1 = 407,
            y2 = 812
          },
          _questId = 18
        }
      },
      _booKSelfGroupId = 8708,
      _booKSelfQuestId = 1
    },
    [4] = {
      _groupId = 8514,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_12"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
        _base = {
          x1 = 514,
          x2 = 684,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 514,
          x2 = 684,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 514,
            x2 = 684,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 514,
            x2 = 684,
            y1 = 407,
            y2 = 812
          },
          _questId = 13
        },
        [2] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 514,
            x2 = 684,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 514,
            x2 = 684,
            y1 = 407,
            y2 = 812
          },
          _questId = 15
        }
      },
      _booKSelfGroupId = 8709,
      _booKSelfQuestId = 1
    },
    [5] = {
      _groupId = 8515,
      _name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGMAINPROGRESS_TITLE_13"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
        _base = {
          x1 = 685,
          x2 = 855,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 685,
          x2 = 855,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_06.dds",
          _base = {
            x1 = 685,
            x2 = 855,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 685,
            x2 = 855,
            y1 = 407,
            y2 = 812
          },
          _questId = 10
        }
      },
      _booKSelfGroupId = 8710,
      _booKSelfQuestId = 4
    },
    [6] = {
      _groupId = 8524,
      _name = "\236\157\180\235\172\180\234\184\176\236\160\132",
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
        _base = {
          x1 = 1,
          x2 = 171,
          y1 = 407,
          y2 = 812
        },
        _on = {
          x1 = 1,
          x2 = 171,
          y1 = 407,
          y2 = 812
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
          _base = {
            x1 = 172,
            x2 = 342,
            y1 = 407,
            y2 = 812
          },
          _on = {
            x1 = 172,
            x2 = 342,
            y1 = 407,
            y2 = 812
          },
          _questId = 22
        }
      },
      _booKSelfGroupId = 8714,
      _booKSelfQuestId = 1
    }
  },
  _hiddenInfo2 = {
    [1] = {
      _groupId = 8537,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_09"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
        _base = {
          x1 = 514,
          x2 = 684,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 514,
          x2 = 684,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
          _base = {
            x1 = 514,
            x2 = 684,
            y1 = 1,
            y2 = 406
          },
          _on = {
            x1 = 514,
            x2 = 684,
            y1 = 1,
            y2 = 406
          },
          _questId = 7
        }
      },
      _booKSelfGroupId = 8550,
      _booKSelfQuestId = 1
    },
    [2] = {
      _groupId = 8538,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_10"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
        _base = {
          x1 = 1,
          x2 = 171,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 1,
          x2 = 171,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
          _base = {
            x1 = 685,
            x2 = 855,
            y1 = 1,
            y2 = 406
          },
          _on = {
            x1 = 685,
            x2 = 855,
            y1 = 1,
            y2 = 406
          },
          _questId = 5
        }
      },
      _booKSelfGroupId = 8551,
      _booKSelfQuestId = 1
    },
    [3] = {
      _groupId = 8539,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_11"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
        _base = {
          x1 = 172,
          x2 = 342,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 172,
          x2 = 342,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
          _base = {
            x1 = 172,
            x2 = 342,
            y1 = 1,
            y2 = 406
          },
          _on = {
            x1 = 172,
            x2 = 342,
            y1 = 1,
            y2 = 406
          },
          _questId = 6
        }
      },
      _booKSelfGroupId = 8552,
      _booKSelfQuestId = 1
    },
    [4] = {
      _groupId = 8540,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_12"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
        _base = {
          x1 = 343,
          x2 = 513,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 343,
          x2 = 513,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
          _base = {
            x1 = 343,
            x2 = 513,
            y1 = 1,
            y2 = 406
          },
          _on = {
            x1 = 343,
            x2 = 513,
            y1 = 1,
            y2 = 406
          },
          _questId = 2
        }
      },
      _booKSelfGroupId = 8553,
      _booKSelfQuestId = 1
    },
    [5] = {
      _groupId = 8541,
      _name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNINGMAINPROGRESS_TITLE_13"),
      _normalUV = {
        _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
        _base = {
          x1 = 856,
          x2 = 1026,
          y1 = 1,
          y2 = 406
        },
        _on = {
          x1 = 856,
          x2 = 1026,
          y1 = 1,
          y2 = 406
        }
      },
      _completeUV = {
        [1] = {
          _dds = "combine/etc/Combine_Etc_MorningLand_MainQuest_11.dds",
          _base = {
            x1 = 1027,
            x2 = 1197,
            y1 = 1,
            y2 = 406
          },
          _on = {
            x1 = 1027,
            x2 = 1197,
            y1 = 1,
            y2 = 406
          },
          _questId = 2
        }
      },
      _booKSelfGroupId = 8554,
      _booKSelfQuestId = 1
    }
  },
  _normalPercentInfo = {
    [1] = {
      _groupId = 8503,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4,
        [29] = 4,
        [30] = 4
      },
      _finalId = 30
    },
    [2] = {
      _groupId = 8504,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 4,
        [31] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [32] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 3,
        [26] = 3,
        [27] = 3,
        [28] = 3,
        [29] = 4,
        [30] = 4,
        [33] = 4
      },
      _finalId = 33
    },
    [3] = {
      _groupId = 8505,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 4,
        [10] = 4,
        [28] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [30] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 5,
        [26] = 5,
        [27] = 6,
        [29] = 4
      },
      _finalId = 29
    },
    [4] = {
      _groupId = 8506,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4,
        [29] = 4,
        [30] = 4
      },
      _finalId = 30
    },
    [5] = {
      _groupId = 8507,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [27] = 4,
        [30] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [29] = 4,
        [23] = 4,
        [24] = 6,
        [25] = 6,
        [26] = 8,
        [28] = 4
      },
      _finalId = 28
    },
    [6] = {
      _groupId = 8508,
      info = {
        [1] = 2,
        [2] = 2,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 3,
        [32] = 3,
        [10] = 3,
        [11] = 3,
        [12] = 3,
        [34] = 3,
        [13] = 3,
        [14] = 3,
        [15] = 3,
        [33] = 3,
        [16] = 3,
        [35] = 3,
        [17] = 3,
        [18] = 3,
        [19] = 3,
        [36] = 3,
        [20] = 3,
        [21] = 3,
        [22] = 3,
        [23] = 3,
        [24] = 3,
        [25] = 3,
        [26] = 3,
        [27] = 3,
        [31] = 3,
        [28] = 3,
        [37] = 3,
        [29] = 3,
        [30] = 3
      },
      _finalId = 30
    },
    [7] = {
      _groupId = 8509,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [25] = 4,
        [7] = 4,
        [26] = 4,
        [8] = 4,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [23] = 2,
        [24] = 2
      },
      _finalId = 24
    },
    [8] = {
      _groupId = 8511,
      info = {
        [1] = 5,
        [2] = 5,
        [3] = 5,
        [4] = 5,
        [5] = 5,
        [6] = 5,
        [7] = 5,
        [8] = 5,
        [17] = 5,
        [9] = 5,
        [18] = 10,
        [10] = 5,
        [11] = 5,
        [12] = 5,
        [13] = 5,
        [14] = 5,
        [15] = 5,
        [16] = 10
      },
      _finalId = 16
    }
  },
  _normalPercentInfo2 = {
    [1] = {
      _groupId = 8532,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 3,
        [10] = 3,
        [11] = 3,
        [12] = 3,
        [13] = 3,
        [14] = 3,
        [15] = 3,
        [16] = 3,
        [17] = 3,
        [31] = 3,
        [32] = 3,
        [18] = 3,
        [19] = 4,
        [20] = 4,
        [21] = 4,
        [22] = 4,
        [33] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4,
        [29] = 4,
        [30] = 4
      },
      _finalId = 30
    },
    [2] = {
      _groupId = 8534,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 5,
        [17] = 5,
        [18] = 5,
        [19] = 5,
        [20] = 5,
        [21] = 5,
        [22] = 5,
        [23] = 5,
        [24] = 5,
        [25] = 5,
        [26] = 5,
        [27] = 5
      },
      _finalId = 27
    },
    [3] = {
      _groupId = 8529,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 4,
        [10] = 4,
        [11] = 5,
        [12] = 5,
        [13] = 5,
        [14] = 5,
        [15] = 5,
        [16] = 5,
        [17] = 5,
        [18] = 5,
        [19] = 5,
        [20] = 5,
        [21] = 5,
        [22] = 10,
        [23] = 10,
        [24] = 10,
        [25] = 20
      },
      _finalId = 25
    },
    [4] = {
      _groupId = 8536,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [30] = 4,
        [15] = 5,
        [16] = 5,
        [17] = 5,
        [18] = 5,
        [19] = 3,
        [20] = 3,
        [21] = 3,
        [22] = 3,
        [29] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4
      },
      _finalId = 28
    },
    [5] = {
      _groupId = 8531,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 3,
        [10] = 3,
        [11] = 3,
        [12] = 3,
        [13] = 3,
        [14] = 3,
        [15] = 3,
        [16] = 3,
        [17] = 3,
        [18] = 3,
        [19] = 3,
        [20] = 3,
        [21] = 3,
        [22] = 3,
        [23] = 4,
        [24] = 4,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4,
        [29] = 4,
        [30] = 4,
        [31] = 4,
        [32] = 4,
        [33] = 4,
        [34] = 4,
        [35] = 4
      },
      _finalId = 35
    },
    [6] = {
      _groupId = 8530,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 4,
        [10] = 4,
        [11] = 4,
        [12] = 4,
        [13] = 4,
        [14] = 4,
        [15] = 4,
        [16] = 4,
        [17] = 4,
        [18] = 4,
        [19] = 4,
        [20] = 4,
        [21] = 3,
        [22] = 3,
        [23] = 3,
        [24] = 3,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4,
        [29] = 4,
        [30] = 4,
        [31] = 4
      },
      _finalId = 31
    },
    [7] = {
      _groupId = 8535,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 3,
        [10] = 3,
        [11] = 3,
        [12] = 3,
        [13] = 3,
        [14] = 3,
        [15] = 3,
        [16] = 3,
        [17] = 3,
        [18] = 3,
        [19] = 3,
        [20] = 3,
        [21] = 4,
        [22] = 4,
        [23] = 4,
        [24] = 4,
        [25] = 4,
        [26] = 4,
        [27] = 4,
        [28] = 4,
        [29] = 4,
        [30] = 4,
        [31] = 3,
        [32] = 3,
        [33] = 3,
        [34] = 3,
        [35] = 4,
        [36] = 4,
        [37] = 4,
        [38] = 4,
        [39] = 4
      },
      _finalId = 39
    },
    [8] = {
      _groupId = 8533,
      info = {
        [1] = 3,
        [2] = 3,
        [3] = 3,
        [4] = 3,
        [5] = 3,
        [6] = 3,
        [7] = 3,
        [8] = 3,
        [9] = 3,
        [10] = 3,
        [11] = 3,
        [12] = 3,
        [13] = 3,
        [14] = 3,
        [15] = 3,
        [16] = 3,
        [17] = 3,
        [18] = 3,
        [19] = 3,
        [20] = 3,
        [21] = 3,
        [22] = 3,
        [23] = 3,
        [24] = 3,
        [25] = 3,
        [26] = 3,
        [27] = 3,
        [28] = 3,
        [29] = 3,
        [30] = 3,
        [31] = 3,
        [32] = 3,
        [33] = 4,
        [34] = 5,
        [35] = 5,
        [36] = 6,
        [37] = 6
      },
      _finalId = 37
    }
  },
  _hiddenPercentInfo = {
    [1] = {
      _groupId = 8510,
      info = {
        [1] = 10,
        [2] = 10,
        [3] = 10,
        [4] = 20,
        [5] = 10,
        [6] = 10,
        [7] = 10,
        [8] = 20
      },
      _finalId = 8
    },
    [2] = {
      _groupId = 8512,
      info = {
        [1] = 5,
        [2] = 5,
        [3] = 5,
        [4] = 5,
        [5] = 5,
        [6] = 5,
        [7] = 5,
        [8] = 5,
        [9] = 5,
        [10] = 5,
        [11] = 5,
        [12] = 5,
        [13] = 5,
        [26] = 5,
        [14] = 5,
        [27] = 5,
        [15] = 5,
        [16] = 5,
        [17] = 10,
        [18] = 10,
        [19] = 5,
        [20] = 5,
        [28] = 5,
        [21] = 5,
        [22] = 5,
        [23] = 5,
        [24] = 5,
        [25] = 25
      },
      _finalId = 25
    },
    [3] = {
      _groupId = 8513,
      info = {
        [1] = 4,
        [2] = 4,
        [26] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [24] = 4,
        [9] = 4,
        [23] = 4,
        [10] = 9,
        [11] = 4,
        [12] = 5,
        [13] = 5,
        [14] = 5,
        [15] = 5,
        [16] = 5,
        [29] = 9,
        [17] = 5,
        [18] = 4,
        [19] = 4,
        [25] = 4,
        [20] = 4,
        [21] = 4,
        [27] = 9,
        [22] = 5,
        [28] = 5
      },
      _finalId = 28
    },
    [4] = {
      _groupId = 8514,
      info = {
        [1] = 8,
        [2] = 8,
        [3] = 8,
        [4] = 8,
        [5] = 8,
        [6] = 8,
        [8] = 8,
        [9] = 8,
        [10] = 8,
        [11] = 8,
        [12] = 10,
        [14] = 10,
        [13] = 10,
        [15] = 5,
        [16] = 5
      },
      _finalId = 16
    },
    [5] = {
      _groupId = 8515,
      info = {
        [1] = 10,
        [2] = 10,
        [3] = 10,
        [4] = 10,
        [5] = 10,
        [6] = 10,
        [7] = 10,
        [8] = 10,
        [9] = 10,
        [10] = 10
      },
      _finalId = 10
    },
    [6] = {
      _groupId = 8524,
      info = {
        [1] = 4,
        [2] = 4,
        [3] = 4,
        [4] = 4,
        [5] = 4,
        [6] = 4,
        [7] = 4,
        [8] = 4,
        [9] = 5,
        [10] = 5,
        [11] = 5,
        [12] = 5,
        [13] = 5,
        [14] = 5,
        [15] = 5,
        [16] = 5,
        [17] = 5,
        [18] = 5,
        [19] = 5,
        [20] = 5,
        [21] = 5,
        [22] = 5
      },
      _finalId = 22
    }
  },
  _hiddenPercentInfo2 = {
    [1] = {
      _groupId = 8537,
      info = {
        [1] = 10,
        [2] = 15,
        [3] = 15,
        [4] = 15,
        [5] = 15,
        [6] = 15,
        [7] = 15
      },
      _finalId = 7
    },
    [2] = {
      _groupId = 8538,
      info = {
        [1] = 20,
        [2] = 20,
        [3] = 20,
        [4] = 20,
        [5] = 20
      },
      _finalId = 5
    },
    [3] = {
      _groupId = 8539,
      info = {
        [1] = 15,
        [2] = 15,
        [3] = 15,
        [4] = 15,
        [5] = 20,
        [6] = 20
      },
      _finalId = 6
    },
    [4] = {
      _groupId = 8540,
      info = {
        [1] = 50,
        [2] = 50
      },
      _finalId = 2
    },
    [5] = {
      _groupId = 8541,
      info = {
        [1] = 50,
        [2] = 50
      },
      _finalId = 2
    }
  },
  _selectTabType = nil,
  _normalQuestCount = 8,
  _hiddenQuestCount = 5,
  _normalQuest2Count = 8,
  _hiddenQuest2Count = 5,
  _hiddenQuestAddIndex = 0,
  _speed = 2500,
  _stampQuest = 0,
  _currentPage = 0,
  _nextPage = 0,
  _content1 = nil,
  _content2 = nil,
  _clearLevel = 0,
  _isConsole = false,
  _initialize = false,
  _frameScrollCtrlPos = 0,
  _isPageChanging = false
}
runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_QuestBoard2_All_1.lua")
runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_QuestBoard2_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_MorningLand_QuestBoard_All")
function FromClient_PaGlobal_MorningLand_QuestBoard_All()
  PaGlobal_MorningLand_QuestBoard_All:initialize()
end
