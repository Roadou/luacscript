PaGlobal_RoseWarEditParty = {
  _ui = {
    _stc_tabArea = nil,
    _btn_toggleShowNameMode = nil,
    _btn_guildTab = nil,
    _stc_guildNotPlaceCount = nil,
    _btn_mercenaryTab = nil,
    _stc_mercenaryNotPlaceCount = nil,
    _stc_tabLine = nil,
    _stc_memberListBg = nil,
    _lst_memberList = nil,
    _cbx_sortOption = nil,
    _stc_sortOptionList = nil,
    _btn_autoPlacement = nil,
    _frm_partyList = nil,
    _frmContent_partyList = nil,
    _stc_rclick_menu = nil
  },
  _eSelectMode = {
    ONLY_ONE = 0,
    ADD_ONE = 1,
    ADD_RANGE = 2,
    COUNT = 3
  },
  _eRClickButtonType = {
    JOIN_PARTY = 0,
    SET_PARTY_LEADER = 1,
    SET_SUBCOMMANDER = 2,
    UNSET_SUBCOMMANDER = 3,
    COUNT = 4
  },
  _memberList_selectInfo = nil,
  _partyMemberList_selectInfo = nil,
  _currentSortOption = __eRoseWarMemberListSortType_NameAsc,
  _currentTab = __eRoseWarPartyType_Count,
  _partyDataPool = nil,
  _partyDataPoolCount = 20,
  _rClickMenuButtonPool = nil,
  _rClickMenuButtonPoolCount = 20,
  _dragPanel = nil,
  _isEditMode = false,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_EditParty_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_EditParty_2.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_EditParty_3.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarEditPartyInit")
function FromClient_RoseWarEditPartyInit()
  PaGlobal_RoseWarEditParty:initialize()
end
