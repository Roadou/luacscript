PaGlobal_ShipInfo_Renewal_All = {
  _ui = {_stc_goHomeListArea = nil, _btn_homeTemplete = nil},
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true,
    createEnduranceIcon = true
  },
  _equipSlotBG = {},
  _equipSlotCashBG = {},
  _equipSlotBGIcon = {},
  _equipSlotCashBGIcon = {},
  _equipItemSlots = {},
  _equipItemCashSlots = {},
  _equipSlotNoBig = {
    3,
    4,
    5,
    25,
    12,
    7
  },
  _equipCashSlotNoBig = {
    14,
    15,
    16,
    26,
    0,
    0
  },
  _equipSlotNoSmall = {
    4,
    5,
    6,
    25,
    0,
    0
  },
  _equipCashSlotNoSmall = {
    15,
    16,
    14,
    26,
    0,
    0
  },
  _equipSlotBigShipUV = {
    [3] = {
      x1 = 87,
      y1 = 259,
      x2 = 129,
      y2 = 301
    },
    [4] = {
      x1 = 1,
      y1 = 216,
      x2 = 43,
      y2 = 258
    },
    [5] = {
      x1 = 173,
      y1 = 259,
      x2 = 215,
      y2 = 301
    },
    [25] = {
      x1 = 1,
      y1 = 259,
      x2 = 43,
      y2 = 301
    },
    [12] = {
      x1 = 173,
      y1 = 302,
      x2 = 215,
      y2 = 344
    },
    [7] = {
      x1 = 730,
      y1 = 1,
      x2 = 785,
      y2 = 56
    },
    [14] = {
      x1 = 130,
      y1 = 259,
      x2 = 172,
      y2 = 301
    },
    [15] = {
      x1 = 44,
      y1 = 216,
      x2 = 86,
      y2 = 258
    },
    [16] = {
      x1 = 216,
      y1 = 259,
      x2 = 258,
      y2 = 301
    },
    [26] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    },
    [0] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    }
  },
  _equipSlotSmallShipUV = {
    [4] = {
      x1 = 1,
      y1 = 216,
      x2 = 43,
      y2 = 258
    },
    [5] = {
      x1 = 1,
      y1 = 302,
      x2 = 43,
      y2 = 344
    },
    [6] = {
      x1 = 87,
      y1 = 216,
      x2 = 129,
      y2 = 258
    },
    [25] = {
      x1 = 1,
      y1 = 259,
      x2 = 43,
      y2 = 301
    },
    [15] = {
      x1 = 44,
      y1 = 216,
      x2 = 86,
      y2 = 258
    },
    [16] = {
      x1 = 44,
      y1 = 302,
      x2 = 86,
      y2 = 344
    },
    [14] = {
      x1 = 130,
      y1 = 259,
      x2 = 172,
      y2 = 301
    },
    [26] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    },
    [0] = {
      x1 = 44,
      y1 = 259,
      x2 = 86,
      y2 = 301
    }
  },
  _equipSlotNo = {
    3,
    4,
    5,
    6,
    12,
    25,
    7,
    14,
    15,
    16,
    17,
    26
  },
  _equipSlotID = {
    [3] = "Static_ItemSlot1",
    [4] = "Static_ItemSlot2",
    [5] = "Static_ItemSlot3",
    [6] = "Static_ItemSlot1",
    [12] = "Static_ItemSlot4",
    [25] = "Static_ItemSlot5",
    [7] = "Static_ItemSlot6",
    [14] = "Static_PearlItemSlot1",
    [15] = "Static_PearlItemSlot2",
    [16] = "Static_PearlItemSlot3",
    [17] = "Static_PearlItemSlot4",
    [26] = "Static_PearlItemSlot4"
  },
  _contractSlotNum = 12,
  _equipSlotMaxCount = 6,
  _totemSlotNum = 6,
  _totemCheckButton = nil,
  _extendedSlotInfoArray = nil,
  _isBigShip = false,
  _invenSlotBG = {},
  _invenItemSlots = {},
  _config = {
    row = -1,
    col = 11,
    gap = 5,
    startPos = 5,
    size = 45,
    count = 0,
    contentsCount = 0,
    CONST_COUNT = 33,
    statBarCount = 11
  },
  _useStartSlot = nil,
  _shipSkillIndex = {},
  _tooltipControls = nil,
  _actorKeyRaw = nil,
  _servantNo = nil,
  _isGuildShip = false,
  _startInvenSlotIndex = 0,
  _initialize = false,
  _moveItemToType = nil,
  _inventoryType = nil,
  _inventorySlotNo = 0,
  _shipType = {
    Panokseon = 1,
    Carrack_Advance = 2,
    Carrack_Balance = 3,
    Carrack_Volante = 4,
    Carrack_Valor = 5
  },
  _keyToType = {},
  _statType = {
    Speed = 1,
    Acceleration = 2,
    CorneringSpeed = 3,
    Brake = 4,
    CoolTime = 5,
    MaximumRange = 6,
    Accuracy = 7,
    Angle = 8,
    Count = 9
  },
  _statMinimum = {
    [1] = {
      105,
      100,
      110,
      115,
      13,
      150,
      10,
      10
    },
    [2] = {
      110,
      100,
      115,
      115,
      13,
      150,
      10,
      10
    },
    [3] = {
      115,
      100,
      115,
      115,
      12,
      150,
      10,
      10
    },
    [4] = {
      120,
      110,
      125,
      125,
      12,
      150,
      10,
      10
    },
    [5] = {
      115,
      100,
      125,
      125,
      11,
      150,
      10,
      10
    }
  },
  _statMaximum = {
    [1] = {
      211,
      253,
      402,
      350,
      11,
      285,
      205,
      82
    },
    [2] = {
      197,
      212,
      329,
      286,
      12,
      240,
      140,
      58
    },
    [3] = {
      202,
      217,
      334,
      291,
      11,
      240,
      140,
      58
    },
    [4] = {
      212,
      227,
      339,
      296,
      10,
      240,
      140,
      58
    },
    [5] = {
      204,
      224,
      339,
      296,
      8,
      240,
      140,
      58
    }
  },
  _homePositionList = {
    [1] = {
      regionKeyRaw = 5,
      x = 4623,
      y = -7630,
      z = 92550
    },
    [2] = {
      regionKeyRaw = 120,
      x = -365897,
      y = -8214.63,
      z = 42960.9
    },
    [3] = {
      regionKeyRaw = 182,
      x = 153059,
      y = -8208,
      z = 289390
    },
    [4] = {
      regionKeyRaw = 619,
      x = 979898,
      y = -7583,
      z = 344511
    },
    [5] = {
      regionKeyRaw = 1000,
      x = -107762,
      y = -8208,
      z = 628577
    },
    [6] = {
      regionKeyRaw = 1219,
      x = -1299109,
      y = -8208,
      z = 1125473
    },
    [7] = {
      regionKeyRaw = 1246,
      x = -993933,
      y = -8234.68,
      z = 1350140
    }
  }
}
runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_Renewal_All_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_Renewal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ShipInfoRenewalAll_luaLoadComplete")
function FromClient_ShipInfoRenewalAll_luaLoadComplete()
  PaGlobal_ShipInfo_Renewal_All:initialize()
end
