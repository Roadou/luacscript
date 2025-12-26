PaGlobal_RoseWarPartyList = {
  _ui = {
    _stc_title = nil,
    _btn_close = nil,
    _stc_tabBar = nil,
    _stc_top = nil,
    _stc_sideTab = nil,
    _chk_showFamily = nil,
    _chk_showMinify = nil,
    _btn_kamasilvia = nil,
    _btn_odilita = nil,
    _btn_guildTab = nil,
    _btn_mercenaryTab = nil,
    _stc_regionMark = nil,
    _stc_guildMark = nil,
    _btn_appoint = nil,
    _txt_guildName = nil,
    _stc_commanderIcon = nil,
    _stc_commanderClassIcon = nil,
    _stc_commanderSuccession = nil,
    _stc_commanderAwaken = nil,
    _stc_commanderShy = nil,
    _stc_commanderArcher = nil,
    _stc_commanderName = nil,
    _stc_subCommanderIcon_1 = nil,
    _stc_subCommanderIcon_2 = nil,
    _stc_subCommanderIcon_3 = nil,
    _frm_original = nil,
    _frm_contentOrigin = nil,
    _memberDataPool = nil,
    _frm_minify = nil,
    _frm_contentMinify = nil,
    _memberMiniDataPool = nil
  },
  _memberDataMaxCount = 100,
  _initialize = false,
  _selectedIndex = -1
}
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_PartyList_1.lua")
runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_PartyList_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarPartyListInit")
function FromClient_RoseWarPartyListInit()
  PaGlobal_RoseWarPartyList:initialize()
end
