PaGlobal_LandscapePainting = {
  _ui = {
    btn_Close = nil,
    list2_landscapePaintingList = nil,
    txt_Desc = nil,
    itemSubPanel = nil,
    stc_itemTemplate = nil,
    stc_ItemSlots = {},
    btn_subPanelClose = nil,
    stc_toolTipDesc = nil,
    stc_itemSubPanel_constolBtnGroup = nil,
    stc_consoleBtnGroup = nil,
    stc_console_A = nil,
    stc_console_B = nil,
    stc_console_Y = nil
  },
  _indexForType = {
    [0] = __eLandscapePaintingType_Sulfur,
    [1] = __eLandscapePaintingType_PilaKu,
    [2] = __eLandscapePaintingType_Aakman,
    [3] = __eLandscapePaintingType_Hystria,
    [4] = __eLandscapePaintingType_SycraiaUpper,
    [5] = __eLandscapePaintingType_Padix,
    [6] = __eLandscapePaintingType_AshForest,
    [7] = __eLandscapePaintingType_CryptOfRestingThoughts,
    [8] = __eLandscapePaintingType_OlunsValley,
    [9] = __eLandscapePaintingType_CityOfTheDead,
    [10] = __eLandscapePaintingType_Tungrad,
    [11] = __eLandscapePaintingType_Darkseekers
  },
  _landscapePaintingDropData = {
    [__eLandscapePaintingType_Sulfur] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_PilaKu] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_Aakman] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_Hystria] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_SycraiaUpper] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_Padix] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_AshForest] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_CryptOfRestingThoughts] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_OlunsValley] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_CityOfTheDead] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_Tungrad] = {
      string = "",
      currentPoint = 0,
      switch = false
    },
    [__eLandscapePaintingType_Darkseekers] = {
      string = "",
      currentPoint = 0,
      switch = false
    }
  },
  _paintingTexture = {
    [__eLandscapePaintingType_Sulfur] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_03_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_03_OFF"
    },
    [__eLandscapePaintingType_PilaKu] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_06_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_06_OFF"
    },
    [__eLandscapePaintingType_Aakman] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_02_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_02_OFF"
    },
    [__eLandscapePaintingType_Hystria] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_01_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_01_OFF"
    },
    [__eLandscapePaintingType_SycraiaUpper] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_05_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_05_OFF"
    },
    [__eLandscapePaintingType_Padix] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_09_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_09_OFF"
    },
    [__eLandscapePaintingType_AshForest] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_07_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_07_OFF"
    },
    [__eLandscapePaintingType_CryptOfRestingThoughts] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_08_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_08_OFF"
    },
    [__eLandscapePaintingType_OlunsValley] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_10_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_10_OFF"
    },
    [__eLandscapePaintingType_CityOfTheDead] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_11_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_11_OFF"
    },
    [__eLandscapePaintingType_Tungrad] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_04_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_04_OFF"
    },
    [__eLandscapePaintingType_Darkseekers] = {
      on = "Combine_Etc_ElaServinLandscapes_ListImg_12_ON",
      off = "Combine_Etc_ElaServinLandscapes_ListImg_12_OFF"
    }
  },
  _columCount = 5,
  _pointMax = 100000,
  _config = {
    _slotConfig = {
      createIcon = true,
      createBorder = true,
      createCount = true,
      createCash = true
    },
    chargeItemCount = 3,
    _startX = 10,
    _gapX = 50,
    _col = 5
  },
  _itemSubPanelPosX = 120,
  _itemSubPanelPosY = 320,
  _itemPosGapX = 290,
  _itemPosGapY = 380,
  _selectItemIndex = -1,
  _selectPaintingType = -1,
  _selectPaintingChargePoint = 0,
  _selectItemCount = 0,
  _initialize = false
}
runLua("UI_Data/Script/Window/DropItem/Panel_Window_LandscapePaintingDrop_1.lua")
runLua("UI_Data/Script/Window/DropItem/Panel_Window_LandscapePaintingDrop_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_LandscapePaintingDrop_Init")
function FromClient_LandscapePaintingDrop_Init()
  PaGlobal_LandscapePainting:initialize()
end
