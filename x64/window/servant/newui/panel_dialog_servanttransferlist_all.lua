PaGlobal_ServantTransferList_All = {
  _ui = {
    _txt_Title = nil,
    _btn_Close_PC = nil,
    _stc_Bg = nil,
    _txt_Desc = nil,
    _txt_Count = nil,
    _list2_Servant = nil,
    _list2_Content = nil,
    _list2_Btn_List = nil,
    _list2_Verti_Scroll = nil,
    _list2_Verti_Scroll_Up = nil,
    _list2_Verti_Scroll_Down = nil,
    _list2_Verti_Scroll_Ctrl = nil,
    _list2_Hori_Scroll = nil,
    _list2_Hori_Scroll_Up = nil,
    _list2_Hori_Scroll_Down = nil,
    _list2_Hori_Scroll_Ctrl = nil,
    _stc_Bottom_KeyGuide = nil,
    _stc_Keyguide_A = nil,
    _stc_Keyguide_B = nil,
    _stc_ButtonBg = nil,
    _btn_Territory_Temp = nil,
    _btn_Territory = {},
    _stc_TerritoryIcon = {}
  },
  _eOpenType = {
    STABLE = 0,
    WHARF = 1,
    WORLDMAP = 2
  },
  _curOpenType = 0,
  _transBackWordList = {},
  _isTransBackWordList = false,
  _isWorldMapOpen = false,
  _currentTitle = nil,
  _isConsole = false,
  _initailize = false,
  _servantNo = nil,
  _maxTerritoryCount = 13,
  _categoryIconTexturePath = {
    _path = "Combine/Etc/Combine_Etc_DropItem.dds",
    _normal = {
      [0] = {
        139,
        47,
        184,
        92
      },
      {
        47,
        47,
        92,
        92
      },
      {
        1,
        47,
        46,
        92
      },
      {
        93,
        47,
        138,
        92
      },
      {
        185,
        47,
        230,
        92
      },
      {
        415,
        47,
        460,
        92
      },
      {
        231,
        47,
        276,
        92
      },
      {
        277,
        47,
        322,
        92
      },
      {
        323,
        47,
        368,
        92
      },
      {
        369,
        47,
        414,
        92
      },
      {
        461,
        47,
        506,
        92
      },
      {
        507,
        47,
        552,
        92
      },
      {
        553,
        47,
        598,
        92
      }
    }
  }
}
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All_1.lua")
runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantTransferList_All_Init")
function FromClient_ServantTransferList_All_Init()
  PaGlobal_ServantTransferList_All:initialize()
end
