PaGlobal_CharacterInfo_BuffDetail_All = {
  _ui = {
    _listClass = {},
    _listGroup = {},
    _listTemplate = {},
    _listScroll = {},
    stc_KeyGuide_Bg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    scaleRatio = 1,
    oriMousePosX = 0,
    oriMousePosY = 0
  },
  _config = {
    slotMaxCount = 12,
    dataMaxCount = 8,
    descMaxCount = 9
  },
  _uiPool = {
    classTitle = {},
    groupTitle = {},
    listMain = {}
  },
  _currentDescIndex = {
    uiCount = nil,
    groupIdx = nil,
    tokenIdx = nil,
    dataIdx = nil
  },
  _startSlotIndex = 1,
  _listCount = 0,
  _openedOffset = 0,
  _useArray = {},
  _groupOpen = {},
  _initialize = false,
  _isConsole = false,
  _numToVar = {
    [1] = "A",
    [2] = "B",
    [3] = "C",
    [4] = "D",
    [5] = "E",
    [6] = "F",
    [7] = "G",
    [8] = "H"
  },
  _hideOption = {
    [1] = 7
  },
  _formulaData = {
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_CATEGORY_NORMAL_EXP"),
      data = nil
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_BATTLE"),
      iconUV = {
        x1 = 83,
        y1 = 443,
        x2 = 123,
        y2 = 483
      },
      format = "A*(B+(1+C)+D+E+F)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LevelExp,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LevelExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LevelExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_COMBATBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_TITLE")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LevelExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_HOTTIME"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NIGHTBUFF"),
          func = ToClient_getExperienceBuffPercentByNight,
          params = {},
          unit = "%",
          desc = nil
        },
        [6] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GOLDENBELLBUFF"),
          func = ToClient_getExperienceBuffPercentByGoldenbell,
          params = {},
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_SKILL"),
      iconUV = {
        x1 = 124,
        y1 = 443,
        x2 = 164,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D))",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.SkillExp,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.SkillExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_HOTTIME"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.SkillExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FAIRYLOOK")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.SkillExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_BREATH"),
      iconUV = {
        x1 = 165,
        y1 = 443,
        x2 = 205,
        y2 = 483
      },
      format = "A*(1+B)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.FitnessExp,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.FitnessExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_STRENGTH"),
      iconUV = {
        x1 = 165,
        y1 = 443,
        x2 = 205,
        y2 = 483
      },
      format = "A*(1+B)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.FitnessExp,
        1
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.FitnessExp,
            1
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_HEALTH"),
      iconUV = {
        x1 = 165,
        y1 = 443,
        x2 = 205,
        y2 = 483
      },
      format = "A*(1+B)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.FitnessExp,
        2
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.FitnessExp,
            2
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_CONTRIBUTE"),
      iconUV = {
        x1 = 206,
        y1 = 443,
        x2 = 246,
        y2 = 483
      },
      format = "A*(1+B)*(1+C)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.ExploreExp,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.ExploreExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerExploreExperienceBonus,
          params = {},
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_CATEGORY_LIFELEVEL_EXP"),
      data = nil
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NORMAL_EXP_RIDE"),
      iconUV = {
        x1 = 1,
        y1 = 443,
        x2 = 41,
        y2 = 483
      },
      format = "(A*((1+B)+C+D)+2*E)*(1+F)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.VehicleExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.VehicleExp,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.VehicleExp,
            CppEnums.LifeExperienceType.training
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_HOTTIME")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_TRAININGLVL"),
          func = ToClient_getLifeExperienceLevel,
          params = {
            CppEnums.LifeExperienceType.training
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VEHICLEEXTRALEVEL1"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_TRAININGLEVELLIMIT")
          }
        },
        [6] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_TRAININGCOEF"),
          func = ToClient_getVehicleExperienceCoefficientByStat,
          params = {},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_TRAININGSTATEXPRATE")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_COLLECT"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.gather
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.gather
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.gather
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.gather
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.gather
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_FISH"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.fishing
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.fishing
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.fishing
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.fishing
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.fishing
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_HUNT"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.hunting
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.hunting
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.hunting
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.hunting
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.hunting
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_COOK"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.cooking
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.cooking
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.cooking
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.cooking
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.cooking
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_ALCHEMY"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.alchemy
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.alchemy
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.alchemy
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.alchemy
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.alchemy
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_PROCESS"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.manufacture
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.manufacture
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.manufacture
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FAIRYLOOK")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.manufacture
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.manufacture
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_HORSE"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.training
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.training
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.training
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.training
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.training
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_TRADE"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.trade
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.trade
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.trade
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.trade
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.trade
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_CULTIVATION"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.growth
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.growth
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.growth
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETEQUIPSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.growth
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.growth
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_SAILING"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.sail
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.sail
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.barter
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.sail
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.sail
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LIFELEVEL_EXP_COMMERCE"),
      iconUV = {
        x1 = 42,
        y1 = 443,
        x2 = 82,
        y2 = 483
      },
      format = "A*(1+B)*(C+(1+D)+E)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.LifeExp,
        CppEnums.LifeExperienceType.barter
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ACQUIREDEXP"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_EXP")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAINEXP")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_NEWOLVIABUFF"),
          func = ToClient_getOlviaServerLifeExperienceBonus,
          params = {
            CppEnums.LifeExperienceType.barter
          },
          unit = "%",
          desc = nil
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.barter
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL")
          }
        },
        [4] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.barter
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_VALUEPACKAGE"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BOOKOFCOMBAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIFEBOOK"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [5] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_EVENTBUFF"),
          func = ToClient_getEventBuffPercent,
          params = {
            CppEnums.ShowParamBuffType.LifeExp,
            CppEnums.LifeExperienceType.barter
          },
          unit = "%",
          desc = nil
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_CATEGORY_GAINCHANCE"),
      data = nil
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_WOOD"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*(B+C)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTEQUIPBUFF"),
          func = ToClient_getCollectExperiencePercentByTool,
          params = {__eCollectToolType_Axe},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_Axe},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_SAP"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*(B+C)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTEQUIPBUFF"),
          func = ToClient_getCollectExperiencePercentByTool,
          params = {__eCollectToolType_Syringe},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_Syringe},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_HOE"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*(B+C)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTEQUIPBUFF"),
          func = ToClient_getCollectExperiencePercentByTool,
          params = {__eCollectToolType_Hoe},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_Hoe},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_SLAUGHTER"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*(B+C)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTEQUIPBUFF"),
          func = ToClient_getCollectExperiencePercentByTool,
          params = {__eCollectToolType_ButcheryKnife},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_ButcheryKnife},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_TAN"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*(B+C)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTEQUIPBUFF"),
          func = ToClient_getCollectExperiencePercentByTool,
          params = {__eCollectToolType_SkinKnife},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_SkinKnife},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_MINE"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*(B+C)",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTEQUIPBUFF"),
          func = ToClient_getCollectExperiencePercentByTool,
          params = {__eCollectToolType_Pickax},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_Pickax},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_WATER"),
      iconUV = {
        x1 = 247,
        y1 = 443,
        x2 = 287,
        y2 = 483
      },
      format = "A*B",
      parsed = {},
      totalParams = nil,
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY1")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_COLLECTSTATCOEF"),
          func = ToClient_LoadCollectingStatData,
          params = {__eCollectToolType_EmptyBottle},
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_BASECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SPECIALCOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RARECOLLECT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LUCKYTOOLCONSTRAINT")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_RAREFISH"),
      iconUV = {
        x1 = 329,
        y1 = 443,
        x2 = 369,
        y2 = 483
      },
      format = "A+B",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.RareLargeFishRate,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_RAREFISHRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY2")
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY2")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.RareLargeFishRate,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FISHINGROD"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FISHINGFLOAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_HIGHFISG"),
      iconUV = {
        x1 = 329,
        y1 = 443,
        x2 = 369,
        y2 = 483
      },
      format = "A+B",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.RareLargeFishRate,
        1
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_LARGEFISHRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_GAIN_PROBABILITY2")
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY2")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.RareLargeFishRate,
            1
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FISHINGROD"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FISHINGFLOAT"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_KNOWLEDGE"),
      iconUV = {
        x1 = 493,
        y1 = 443,
        x2 = 533,
        y2 = 483
      },
      format = "A*(1+B+C)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.AquireRateKnowledge,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_KNOWLEDGERATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_KNOWLEDGE_PROBABILITY1")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_KNOWLEDGE_PROBABILITY2")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.AquireRateKnowledge,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.AquireRateKnowledge,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_GAINCHANCE_HIGHKNOWLEDGE"),
      iconUV = {
        x1 = 534,
        y1 = 443,
        x2 = 574,
        y2 = 483
      },
      format = "A+B+C",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.AquireRateHighKnowledge,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_RANDOMRATE"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_RANDOM_PROBABILITY")
          },
          unit = nil,
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PROBABILITY2")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.AquireRateHighKnowledge,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET")
          }
        },
        [3] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.AquireRateHighKnowledge,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_CATEGORY_ETCCHANCE"),
      data = nil
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ETCCHANCE_PROCESS"),
      iconUV = {
        x1 = 370,
        y1 = 443,
        x2 = 410,
        y2 = 483
      },
      format = "A*(1+B)",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.ManufactureRate,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_MANUFACTURERATE_PROBABILITY"),
          func = nil,
          params = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_MANUFACTURERATE_PROBABILITY")
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_SUCCESS_PROBABILITY")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.ManufactureRate,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_EQUIPMENTJEWEL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ETCCHANCE_FISH"),
      iconUV = {
        x1 = 288,
        y1 = 443,
        x2 = 328,
        y2 = 483
      },
      format = "A+B",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.AutoFishingRate,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.AutoFishingRate,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FISHINGROD"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FISHINGCHAIR"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_AUTOFISHMINTIME")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.AutoFishingRate,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETPROPERTY"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_AUTOFISHMINTIME")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ETCCHANCE_DEAD"),
      iconUV = {
        x1 = 411,
        y1 = 443,
        x2 = 451,
        y2 = 483
      },
      format = "A+B",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.SkipDeathPenalty,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.SkipDeathPenalty,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FOODPOTION"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PCROOM")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.SkipDeathPenalty,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_FAIRYLOOK")
          }
        }
      }
    },
    {
      name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_ETCCHANCE_ARMOR"),
      iconUV = {
        x1 = 452,
        y1 = 443,
        x2 = 492,
        y2 = 483
      },
      format = "A+B",
      parsed = {},
      totalParams = {
        CppEnums.ShowParamBuffType.ResistanceEndurance,
        0
      },
      data = {
        [1] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_CHARACTERBUFF"),
          func = ToClient_getBuffPercentByCharacter,
          params = {
            CppEnums.ShowParamBuffType.ResistanceEndurance,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_CLOTHSETBUFF"),
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_LIGHTSTONESET")
          }
        },
        [2] = {
          name = PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DETAILNAME_PETSKILLBUFF"),
          func = ToClient_getBuffPercentByPet,
          params = {
            CppEnums.ShowParamBuffType.ResistanceEndurance,
            0
          },
          unit = "%",
          desc = {
            PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_PETBASICSKILL")
          }
        }
      }
    }
  }
}
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_BuffDetail_All_1.lua")
runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_BuffDetail_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharInfo_BuffDetail_All_Init")
function FromClient_CharInfo_BuffDetail_All_Init()
  PaGlobal_CharacterInfo_BuffDetail_All:initialize()
end
