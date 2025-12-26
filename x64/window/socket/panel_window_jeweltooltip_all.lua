PaGlobal_JewelTooltip = {
  _ui = {
    txt_Title = nil,
    txt_NoCrystal = nil,
    txt_LeftButtonDesc = nil,
    stc_CrystalGroupName = nil,
    stc_CrystalBg = nil,
    txt_CrystalDesc = nil,
    txt_CrystalName = nil,
    stc_CrystalIcon = nil,
    stc_DetailBG = nil,
    stc_SubTitle = nil,
    txt_Desc = nil
  },
  _totalDesc = {},
  _exeptionLanguage = false,
  _buffCount = 0,
  _separationCharater = "&",
  _startIndex = 2,
  _isDetail = true,
  _listCrystalSize = 0,
  _listCrystal = {},
  _usingCrystalUICount = 0,
  _listCrystalGroupNameSize = 0,
  _listCrystalGroupName = {},
  _usingCrystalGroupNumberUICount = 0,
  _lastJewelGroupNumber = -1,
  _posY = 0,
  _beforeCount = -1,
  _effectDesc = {},
  _languageTypeString = "",
  _isPadSnapping = false,
  _isConsole = false,
  _initialize = false,
  _tooltipOrderTable = {
    __eJewelSpecialSlotNecklace,
    __eJewelSpecialSlotRing1,
    __eJewelSpecialSlotRing2,
    __eJewelSpecialSlotEaring1,
    __eJewelSpecialSlotEaring2,
    __eJewelSpecialSlotBelt,
    __eJewelSpecialSlot1MorningLand,
    __eJewelSpecialSlot2MorningLand,
    __eJewelSpecialSlotAwakenWeapon1,
    __eEquipSlotNoRightHand,
    __eJewelSpecialSlotAwakenWeapon2,
    __eEquipSlotNoLeftHand,
    __eEquipSlotNoSubTool,
    __eEquipSlotNoChest,
    __eEquipSlotNoGlove,
    __eEquipSlotNoBoots,
    __eEquipSlotNoAvatarChest,
    __eEquipSlotNoHelm,
    __eEquipSlotNoNecklace,
    __eEquipSlotNoRing1,
    __eEquipSlotNoRing2,
    __eEquipSlotNoEaring1,
    __eEquipSlotNoEaring2
  }
}
runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelTooltip_All_1.lua")
runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelTooltip_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_JewelTooltipInit")
function FromClient_JewelTooltipInit()
  PaGlobal_JewelTooltip:initialize()
end
