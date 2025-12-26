PaGlobal_GalleyMember_All = {
  _ui = {_stc_memberTemplate = nil},
  _initialize = false,
  _innerTimer = 0,
  _memberSlotCount = 10,
  _memberSlotUIArr = {},
  _memberActorKeyArr = {}
}
runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyMember_1.lua")
runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyMember_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_GalleyMember_All_Init")
function FromClient_GalleyMember_All_Init()
  PaGlobal_GalleyMember_All:initialize()
end
