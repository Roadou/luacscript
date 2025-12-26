PaGlobal_ServantUpgrade_Tree = {
  _ui = {
    _stc_base = UI.getChildControl(Panel_Dialog_ServantExtension_All_Tree, "Static_TierList_BG"),
    _stc_Tier_0 = nil,
    _stc_Tier_1_1 = nil,
    _stc_Tier_1_2 = nil,
    _stc_Tier_1_3 = nil,
    _stc_Tier_1_4 = nil,
    _stc_Tier_10 = nil,
    _stc_Tier_12 = nil,
    _stc_Tier_17 = nil,
    _stc_Tier_18 = nil,
    _stc_Tier_19 = nil,
    _stc_Tier_20 = nil,
    _btn_Close = UI.getChildControl(Panel_Dialog_ServantExtension_All_Tree, "Button_Close"),
    _stc_keyGuideBG = UI.getChildControl(Panel_Dialog_ServantExtension_All_Tree, "Static_KeyGuide_ConsoleUI")
  },
  _shipKey = nil,
  _upgradeKey = nil,
  _fixedShipKey = nil,
  _isConsole = false
}
function FromClient_ServantUpgrade_TreeInit()
  local self = PaGlobal_ServantUpgrade_Tree
  self:init()
end
runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade_Tree_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantUpgrade_TreeInit")
