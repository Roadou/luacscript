PaGlobal_TopIcon_AutoUseBuffItem = {
  _ui = {
    stc_Icon = nil,
    stc_nextUseItemParent = nil,
    stc_nextUseItemSlotBg = nil,
    stc_nextUseItemProgress = nil
  },
  _slotConfig = {createIcon = true},
  _autoUseBuffItem_UseItemTermTime = 1,
  _autoUseBuffItem_ExpireTime = 0,
  _initialize = false
}
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_AutoUseBuffItem_1.lua")
runLua("UI_Data/Script/Widget/TopWidgetIcon/Console/Panel_Widget_TopIcon_Fairy_AutoUseBuffItem_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_TopIcon_AutoUseBuffItemInit")
function FromClient_TopIcon_AutoUseBuffItemInit()
  PaGlobal_TopIcon_AutoUseBuffItem:initialize()
end
