PaGlobal_CharacterInfo_HardCore_Basic = {
  _ui = {
    photoBg = nil,
    stc_CharPhoto = nil,
    btn_FacePhoto = nil,
    stc_EnchantStackIcon = nil,
    txt_EnchantStackIcon_Value = nil,
    txt_PlayerName = nil,
    txt_PlayerLv = nil,
    txt_HpTitle = nil,
    txt_HpVal = nil,
    txt_MpTitle = nil,
    txt_Mp_Val = nil,
    txt_LTTitle = nil,
    txt_LTVal = nil,
    stc_PotenBg = nil,
    txt_AtkSpd = nil,
    txt_AtkLv = nil,
    txt_MoveSpd = nil,
    txt_MoveLv = nil,
    txt_Critical = nil,
    txt_CriticalLv = nil,
    stc_TitleBg = nil,
    txt_TitleName = nil,
    txt_TitleDesc = nil,
    txt_TitleCondi = nil,
    comb_Filter = nil
  },
  _initialize = false,
  _selfPlayer = nil,
  _potentialData = {},
  _statOriginSpanX = 30,
  _checkAwaken = nil,
  _isAwakenWeaponContentsOpen = false,
  _MAX_POTENCIALSLOT = 4,
  _ENUM_POTEN = {
    ATKSPD = 0,
    MOVESPD = 1,
    CRITICAL = 2
  },
  _currentTab = nil,
  _list2ScrollData = {_list2Idx = 0, _ScrollPos = 0}
}
runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_Basic_All_1.lua")
runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_Basic_All_2.lua")
runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_Basic_All_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_CharacterInfo_HardCore_Basic_Init")
function FromClient_CharacterInfo_HardCore_Basic_Init()
  PaGlobal_CharacterInfo_HardCore_Basic:initialize()
end
