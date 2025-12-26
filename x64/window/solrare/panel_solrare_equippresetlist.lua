PaGlobal_Solare_EquipPreset = {
  _ui = {
    panel_BlackBg = nil,
    stc_MainBg = nil,
    btn_Close = nil,
    stc_InvenBg = nil,
    stc_TabBg = nil,
    stc_ConsoleTab_LT = nil,
    stc_ConsoleTab_RT = nil,
    rdo_Tab_Weapon = nil,
    rdo_Tab_Armor = nil,
    rdo_Tab_ETC = nil,
    stc_Selected_Line = nil,
    txt_Coin = nil,
    frame_MainSlotBg = nil,
    frame_Content = nil,
    frame_BlackBg = nil,
    frame_ShadowTop = nil,
    frame_Shadow = nil,
    frame_VetiScroll = nil,
    stc_EquipBg = nil,
    stc_EquipTable = {},
    stc_EquipCircle = nil,
    txt_Attack = nil,
    txt_AttackValue = nil,
    txt_Defence = nil,
    txt_DefenceValue = nil,
    txt_AwakenTitle = nil,
    txt_AwakenValue = nil,
    txt_ShyTitle = nil,
    txt_ShyValue = nil,
    btn_MyAblityStatOpen = nil,
    btn_SocketTooltip = nil,
    txt_Desc = nil,
    btn_Confirm = nil,
    btn_Cancel = nil,
    stc_SocketEquipBg = nil,
    btn_SocketEquipBg_Close = nil,
    btn_SocketEquipBg_ConsoleLT = nil,
    btn_SocketEquipBg_ConsoleRT = nil,
    rdo_SocketEquipBg_Slot1 = nil,
    rdo_SocketEquipBg_Slot2 = nil,
    stc_SocketEquipBg_Selected = nil,
    list2_SocketEquipBg = nil,
    btn_SocketEquipBg_Confirm = nil,
    btn_SocketEquipBg_Cancel = nil,
    panel_BuyPreset = nil,
    stc_BuyPresetBlackBg = nil,
    stc_BuyPresetSlotBg = nil,
    txt_BuyPresetItemName = nil,
    txt_BuyPresetNeedCoin = nil,
    btn_BuyPresetConfirm = nil,
    btn_BuyPresetCancel = nil,
    keyguildBg = nil,
    keypad_RB = nil,
    keypad_A = nil,
    keypad_B = nil,
    keypad_Y = nil,
    keypad_X = nil
  },
  _eTab = {
    _eWeapon = 0,
    _eArmor = 1,
    _eOther = 2
  },
  _eEquipSlot = {
    [0] = __eEquipSlotNoRightHand,
    [1] = __eEquipSlotNoLeftHand,
    [2] = __eEquipSlotNoAwakenWeapon,
    [3] = __eEquipSlotNoGlove,
    [4] = __eEquipSlotNoBoots,
    [5] = __eEquipSlotNoHelm,
    [6] = __eEquipSlotNoChest,
    [7] = __eEquipSlotNoBelt,
    [8] = __eEquipSlotNoNecklace,
    [9] = __eEquipSlotNoEaring1,
    [10] = __eEquipSlotNoEaring2,
    [11] = __eEquipSlotNoRing1,
    [12] = __eEquipSlotNoRing2,
    [13] = __eEquipSlotNoAlchemyStone,
    [14] = __eEquipSlotNoArtifact1,
    [15] = __eEquipSlotNoArtifact2
  },
  _equipSlotString = {
    [__eEquipSlotNoRightHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND"),
    [__eEquipSlotNoLeftHand] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND"),
    [__eEquipSlotNoAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_awakenWeapon"),
    [__eEquipSlotNoGlove] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_GLOVES"),
    [__eEquipSlotNoBoots] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_BOOTS"),
    [__eEquipSlotNoHelm] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_HELM"),
    [__eEquipSlotNoChest] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_UPPERBODY"),
    [__eEquipSlotNoBelt] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_WAISTBAND"),
    [__eEquipSlotNoNecklace] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_NECKLACE"),
    [__eEquipSlotNoEaring1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [__eEquipSlotNoEaring2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_EARRING"),
    [__eEquipSlotNoRing1] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [__eEquipSlotNoRing2] = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_RING"),
    [__eEquipSlotNoAlchemyStone] = PAGetString(Defines.StringSheet_GAME, "Lua_EquipSlotNo_String_alchemyStone"),
    [__eEquipSlotNoArtifact1] = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_EQUIP_RELIC"),
    [__eEquipSlotNoArtifact2] = PAGetString(Defines.StringSheet_GAME, "LUA_TOOLTIP_EQUIP_RELIC")
  },
  _equipTypeIcon = {
    [__eEquipSlotNoRightHand] = "Combine_Etc_Solare_War_Equip_Icon_Category_01",
    [__eEquipSlotNoLeftHand] = "Combine_Etc_Solare_War_Equip_Icon_Category_02",
    [__eEquipSlotNoAwakenWeapon] = "Combine_Etc_Solare_War_Equip_Icon_Category_03",
    [__eEquipSlotNoGlove] = "Combine_Etc_Solare_War_Equip_Icon_Category_06",
    [__eEquipSlotNoBoots] = "Combine_Etc_Solare_War_Equip_Icon_Category_07",
    [__eEquipSlotNoHelm] = "Combine_Etc_Solare_War_Equip_Icon_Category_05",
    [__eEquipSlotNoChest] = "Combine_Etc_Solare_War_Equip_Icon_Category_04",
    [__eEquipSlotNoBelt] = "Combine_Etc_Solare_War_Equip_Icon_Category_10",
    [__eEquipSlotNoNecklace] = "Combine_Etc_Solare_War_Equip_Icon_Category_09",
    [__eEquipSlotNoEaring1] = "Combine_Etc_Solare_War_Equip_Icon_Category_08",
    [__eEquipSlotNoEaring2] = "Combine_Etc_Solare_War_Equip_Icon_Category_08",
    [__eEquipSlotNoRing1] = "Combine_Etc_Solare_War_Equip_Icon_Category_11",
    [__eEquipSlotNoRing2] = "Combine_Etc_Solare_War_Equip_Icon_Category_11",
    [__eEquipSlotNoAlchemyStone] = "Combine_Etc_Solare_War_Equip_Icon_Category_12",
    [__eEquipSlotNoArtifact1] = "Combine_Etc_Solare_War_Equip_Icon_Category_13",
    [__eEquipSlotNoArtifact2] = "Combine_Etc_Solare_War_Equip_Icon_Category_13"
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = false,
    createExpiration = false,
    createExpirationBG = false,
    createClassEquipBG = false,
    createEnduranceIcon = false,
    createItemLock = false,
    createBlack = true,
    createEnchant = true,
    createBadBG = false
  },
  _atkValue = 0,
  _defValue = 0,
  _awakenValue = 0,
  _slotMainBgSizeY = 0,
  _slotEquipBgSpanY = 0,
  _selectedTab = 0,
  _selectedSocketTab = 0,
  _selectedEquipPresetNo = 0,
  _currentOpenEquipNoBySocketChange64 = -1,
  _currentPushedSocketItemKey0 = -1,
  _currentPushedSocketItemKey1 = -1,
  _selectedSocketPresetNo0 = -1,
  _selectedSocketPresetNo1 = -1,
  _frameControlTable = Array.new(),
  _unlockedSocketTable = Array.new(),
  _originFrameControlSocketSpanY = 0,
  _frameScrollCtrlPos = 0,
  _maxFrameCount = 10,
  _maxSlotCount = 8,
  _isConsole = false,
  _awakenWeaponContentsOpen = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Solare_EquipPreset_Init")
function FromClient_Solare_EquipPreset_Init()
  PaGlobal_Solare_EquipPreset:initialize()
end
function PaGlobal_Solare_EquipPreset:initialize()
  if true == PaGlobal_Solare_EquipPreset._initialize or nil == Panel_Solrare_EquipPresetList then
    return
  end
  if nil ~= Panel_Solrare_EquipPresetBlockBg then
    self._ui.panel_BlackBg = Panel_Solrare_EquipPresetBlockBg
  end
  self._ui.panel_BlackBg:SetIgnore(false)
  self._ui.stc_MainBg = UI.getChildControl(Panel_Solrare_EquipPresetList, "Static_MainBG")
  local top = UI.getChildControl(self._ui.stc_MainBg, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(top, "Button_Win_Close_PCUI")
  self._ui.stc_InvenBg = UI.getChildControl(self._ui.stc_MainBg, "Static_Group_Inven")
  self._ui.stc_TabBg = UI.getChildControl(self._ui.stc_InvenBg, "Static_TabBG")
  self._ui.stc_ConsoleTab_LT = UI.getChildControl(self._ui.stc_TabBg, "StaticText_LT_ConcoleUI")
  self._ui.stc_ConsoleTab_RT = UI.getChildControl(self._ui.stc_TabBg, "StaticText_RT_ConcoleUI")
  self._ui.rdo_Tab_Weapon = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Weapon")
  self._ui.rdo_Tab_Armor = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Armor")
  self._ui.rdo_Tab_ETC = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_ETC")
  self._ui.stc_Selected_Line = UI.getChildControl(self._ui.stc_TabBg, "Static_SelectBar")
  local coinBg = UI.getChildControl(self._ui.stc_InvenBg, "Static_CoinBG")
  self._ui.txt_Coin = UI.getChildControl(coinBg, "Static_Text_Money")
  self._ui.frame_MainSlotBg = UI.getChildControl(self._ui.stc_InvenBg, "Frame_MainSlotBG")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame_MainSlotBg, "Frame_1_Content")
  self._ui.frame_BlackBg = UI.getChildControl(self._ui.frame_MainSlotBg, "Static_ClearBG")
  self._ui.frame_ShadowTop = UI.getChildControl(self._ui.frame_MainSlotBg, "Static_FrameShadow_Top")
  self._ui.frame_Shadow = UI.getChildControl(self._ui.frame_MainSlotBg, "Static_FrameShadow")
  self._ui.frame_VetiScroll = UI.getChildControl(self._ui.frame_MainSlotBg, "Frame_1_VerticalScroll")
  self._ui.frame_VetiScrollCtrl = UI.getChildControl(self._ui.frame_VetiScroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.stc_SocketEquipBg = UI.getChildControl(Panel_Solrare_EquipPresetList, "Static_Crystal_BG")
  local socketTitleBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "StaticText_Title_BG_Crystal")
  self._ui.btn_SocketEquipBg_Close = UI.getChildControl(socketTitleBg, "Button_Close")
  local socketTabBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "Static_TabBG_Crystal")
  self._ui.btn_SocketEquipBg_ConsoleLT = UI.getChildControl(socketTabBg, "StaticText_LT_ConcoleUI")
  self._ui.btn_SocketEquipBg_ConsoleRT = UI.getChildControl(socketTabBg, "StaticText_RT_ConcoleUI")
  self._ui.rdo_SocketEquipBg_Slot1 = UI.getChildControl(socketTabBg, "RadioButton_Slot0")
  self._ui.rdo_SocketEquipBg_Slot1:SetHorizonCenter()
  self._ui.rdo_SocketEquipBg_Slot1:SetSpanSize(0, 0)
  self._ui.rdo_SocketEquipBg_Slot2 = UI.getChildControl(socketTabBg, "RadioButton_Slot1")
  self._ui.rdo_SocketEquipBg_Slot2:SetShow(false)
  self._ui.stc_SocketEquipBg_Selected = UI.getChildControl(socketTabBg, "Static_SelectBar")
  self._ui.rdo_SocketEquipBg_Slot1:SetCheck(true)
  self._ui.stc_SocketEquipBg_Selected:SetSpanSize(self._ui.rdo_SocketEquipBg_Slot1:GetSpanSize().x, self._ui.stc_SocketEquipBg_Selected:GetSpanSize().y)
  self._ui.keyguildBg = UI.getChildControl(self._ui.stc_MainBg, "Static_Key_GuideGroup_ConsoleUI")
  self._ui.keypad_RB = UI.getChildControl(self._ui.keyguildBg, "StaticText_RB_ConsoleUI")
  self._ui.keypad_RB:SetShow(false)
  self._ui.keypad_A = UI.getChildControl(self._ui.keyguildBg, "StaticText_A_ConsoleUI")
  self._ui.keypad_B = UI.getChildControl(self._ui.keyguildBg, "StaticText_B_ConsoleUI")
  self._ui.keypad_Y = UI.getChildControl(self._ui.keyguildBg, "StaticText_Y_ConsoleUI")
  self._ui.keypad_X = UI.getChildControl(self._ui.keyguildBg, "StaticText_X_ConsoleUI")
  self._ui.keypadTable = {
    self._ui.keypad_RB,
    self._ui.keypad_Y,
    self._ui.keypad_X,
    self._ui.keypad_A,
    self._ui.keypad_B
  }
  self._ui.list2_SocketEquipBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "List2_1")
  local list2Content = UI.getChildControl(self._ui.list2_SocketEquipBg, "List2_1_Content")
  local list2RadioButton = UI.getChildControl(list2Content, "RadioButton_1")
  local list2ItemSlotBg = UI.getChildControl(list2RadioButton, "Static_ItemSlotBG")
  local list2ItemSlot = UI.getChildControl(list2ItemSlotBg, "Static_ItemIcon")
  local list2ItemSlotTable = {}
  SlotItem.new(list2ItemSlotTable, "SolareEquipPreset_SocketSlot", 0, list2ItemSlot, self._slotConfig)
  list2ItemSlotTable:createChild()
  list2ItemSlotTable:clearItem()
  list2ItemSlotTable.icon:SetPosY(2)
  self._ui.btn_SocketEquipBg_Confirm = UI.getChildControl(self._ui.stc_SocketEquipBg, "Button_Confirm2")
  self._ui.btn_SocketEquipBg_Cancel = UI.getChildControl(self._ui.stc_SocketEquipBg, "Button_Cancel2")
  self._ui.stc_EquipBg = UI.getChildControl(self._ui.stc_MainBg, "Static_Group_Equip")
  local abilityArea = UI.getChildControl(self._ui.stc_EquipBg, "Static_AbilityArea")
  self._ui.txt_Attack = UI.getChildControl(abilityArea, "StaticText_Attack")
  self._ui.txt_AttackValue = UI.getChildControl(abilityArea, "StaticText_Attack_Value")
  self._ui.txt_Defence = UI.getChildControl(abilityArea, "StaticText_Defence")
  self._ui.txt_DefenceValue = UI.getChildControl(abilityArea, "StaticText_Defence_Value")
  self._ui.txt_AwakenValue = UI.getChildControl(abilityArea, "StaticText_AwakenAttack_Value")
  self._ui.txt_AwakenTitle = UI.getChildControl(abilityArea, "StaticText_AwakenAttack")
  self._ui.txt_ShyTitle = UI.getChildControl(abilityArea, "StaticText_ShyStat1_Title")
  self._ui.txt_ShyValue = UI.getChildControl(abilityArea, "StaticText_ShyStat1_Value")
  self._ui.btn_MyAblityStatOpen = UI.getChildControl(self._ui.stc_EquipBg, "Button_MyStat")
  self._ui.btn_SocketTooltip = UI.getChildControl(self._ui.stc_EquipBg, "Button_EquipCrystal")
  local desc = UI.getChildControl(self._ui.stc_MainBg, "Static_DescBox_BG")
  self._ui.txt_Desc = UI.getChildControl(desc, "StaticText_1")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(self._ui.txt_Desc:GetText())
  local descSizeY = desc:GetSizeY()
  local descTextSizeY = self._ui.txt_Desc:GetTextSizeY()
  local diffTextY = descTextSizeY - descSizeY + 10
  desc:SetSize(desc:GetSizeX(), desc:GetSizeY() + diffTextY)
  desc:ComputePos()
  Panel_Solrare_EquipPresetList:SetSize(Panel_Solrare_EquipPresetList:GetSizeX(), Panel_Solrare_EquipPresetList:GetSizeY() + diffTextY)
  Panel_Solrare_EquipPresetList:ComputePosAllChild()
  self._ui.btn_Confirm = UI.getChildControl(self._ui.stc_MainBg, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(self._ui.stc_MainBg, "Button_Cancel")
  self._ui.btn_MyAblityStatOpen:SetShow(false)
  self._ui.stc_EquipCircle = UI.getChildControl(self._ui.stc_EquipBg, "Static_MainCircle_1")
  local tempEquipTable = {
    [__eEquipSlotNoRightHand] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_RightHand"),
    [__eEquipSlotNoLeftHand] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_LeftHand"),
    [__eEquipSlotNoChest] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Chest"),
    [__eEquipSlotNoGlove] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Glove"),
    [__eEquipSlotNoBoots] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Boots"),
    [__eEquipSlotNoHelm] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Helm"),
    [__eEquipSlotNoNecklace] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Necklace"),
    [__eEquipSlotNoRing1] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Ring1"),
    [__eEquipSlotNoRing2] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Ring2"),
    [__eEquipSlotNoEaring1] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Earing1"),
    [__eEquipSlotNoEaring2] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Earing2"),
    [__eEquipSlotNoBelt] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Belt"),
    [__eEquipSlotNoAlchemyStone] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_AlchemyStone"),
    [__eEquipSlotNoAwakenWeapon] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_AwakenWeapon"),
    [__eEquipSlotNoArtifact1] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Bracelet1"),
    [__eEquipSlotNoArtifact2] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Bracelet2")
  }
  local tempEquipTableBg = {
    [__eEquipSlotNoRightHand] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_RightHand_BG"),
    [__eEquipSlotNoLeftHand] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_LeftHand_BG"),
    [__eEquipSlotNoChest] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Chest_BG"),
    [__eEquipSlotNoGlove] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Glove_BG"),
    [__eEquipSlotNoBoots] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Boots_BG"),
    [__eEquipSlotNoHelm] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Helm_BG"),
    [__eEquipSlotNoNecklace] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Necklace_BG"),
    [__eEquipSlotNoRing1] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Ring1_BG"),
    [__eEquipSlotNoRing2] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Ring2_BG"),
    [__eEquipSlotNoEaring1] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Earing1_BG"),
    [__eEquipSlotNoEaring2] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Earing2_BG"),
    [__eEquipSlotNoBelt] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Belt_BG"),
    [__eEquipSlotNoAlchemyStone] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_AlchemyStone_BG"),
    [__eEquipSlotNoAwakenWeapon] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_AwakenWeapon_BG"),
    [__eEquipSlotNoArtifact1] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Bracelet1_BG"),
    [__eEquipSlotNoArtifact2] = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_Bracelet2_BG")
  }
  for idx = 1, #self._eEquipSlot do
    local slotNo = self._eEquipSlot[idx - 1]
    local tempTable = {
      control = nil,
      bgControl = nil,
      slot = {},
      equipSlotNo = slotNo,
      currentEquipItemKey = -1,
      currentEquipItemName = ""
    }
    tempTable.control = tempEquipTable[slotNo]
    tempTable.bgControl = tempEquipTableBg[slotNo]
    SlotItem.new(tempTable.slot, "created_EquipItemSlot_" .. tostring(slotNo), slotNo, tempTable.control, self._slotConfig)
    tempTable.slot:createChild()
    tempTable.slot:clearItem()
    tempTable.slot.icon:SetPosY(2)
    tempTable.slot.icon:SetPosX(2)
    self._ui.stc_EquipTable[slotNo] = tempTable
  end
  if nil ~= Panel_Popup_Solare_BuyEquipment_All then
    self._ui.panel_BuyPreset = Panel_Popup_Solare_BuyEquipment_All
    self._ui.stc_BuyPresetBlackBg = UI.getChildControl(Panel_Popup_Solare_BuyEquipment_All, "Static_BlackBG")
    local mainBg = UI.getChildControl(Panel_Popup_Solare_BuyEquipment_All, "Static_Main_Bg")
    local iconBg = UI.getChildControl(mainBg, "Static_IconBG")
    self._ui.stc_BuyPresetSlotBg = UI.getChildControl(iconBg, "Static_Icon")
    local buyPopupItemSlot = {}
    SlotItem.new(buyPopupItemSlot, "SolareEquipPreset_BuyPopup", 0, self._ui.stc_BuyPresetSlotBg, self._slotConfig)
    buyPopupItemSlot:createChild()
    buyPopupItemSlot:clearItem()
    self._ui.txt_BuyPresetItemName = UI.getChildControl(iconBg, "StaticText_ItemName")
    self._ui.txt_BuyPresetItemName:SetTextMode(__eTextMode_AutoWrap)
    local coinBg = UI.getChildControl(mainBg, "Static_CoinBG")
    self._ui.txt_BuyPresetNeedCoin = UI.getChildControl(coinBg, "StaticText_Coin")
    self._ui.btn_BuyPresetConfirm = UI.getChildControl(mainBg, "Button_Ok")
    self._ui.btn_BuyPresetCancel = UI.getChildControl(mainBg, "Button_Cancel")
  end
  self._isConsole = _ContentsGroup_RenewUI
  PaGlobal_Solare_EquipPreset:registEventHandler()
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    ToClient_RequestLoadSolareEquipPresetList()
    ToClient_RequestSolarePresetUnlockList()
  end
  PaGlobal_Solare_EquipPreset:swichPlatform(self._isConsole)
  PaGlobal_Solare_EquipPreset:makeTemplete()
  PaGlobal_Solare_EquipPreset._initialize = true
end
function PaGlobal_Solare_EquipPreset:registEventHandler()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_OnScreenResize")
  registerEvent("FromClient_SolareSettingEquipPresetAck", "FromClient_SolareSettingEquipPreset_Update")
  registerEvent("FromClient_SolarePresetBuyingComplete", "FromClient_Solare_EquipPreset_UnlockUpdate")
  self._ui.frame_Content:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_ScrollEvent(true)")
  self._ui.frame_Content:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_ScrollEvent(false)")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_Close()")
  self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_Close()")
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Solrare_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelectByPad(false)")
    Panel_Solrare_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelectByPad(true)")
  else
    self._ui.rdo_Tab_Weapon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelect(" .. self._eTab._eWeapon .. ")")
    self._ui.rdo_Tab_Armor:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelect(" .. self._eTab._eArmor .. ")")
    self._ui.rdo_Tab_ETC:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelect(" .. self._eTab._eOther .. ")")
  end
  self._ui.btn_SocketEquipBg_Confirm:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketChangeConfrim()")
  self._ui.btn_SocketEquipBg_Close:addInputEvent("Mouse_LUp", "PaGlobal_Solare_EquipPreset:socketChangeShow(false, -1)")
  self._ui.btn_SocketEquipBg_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_Solare_EquipPreset:socketChangeShow(false, -1)")
  self._ui.list2_SocketEquipBg:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_SolareEquip_UpdateSocketList")
  self._ui.list2_SocketEquipBg:createChildContent(__ePAUIList2ElementManagerType_List)
  if nil ~= Panel_Equipment_Crystal_Tooltip then
    if _ContentsGroup_UsePadSnapping == false then
      self._ui.btn_SocketTooltip:addInputEvent("Mouse_On", "PAGlobalFunc_CrystalTooltip_SolareCrystalToolTipOpen(true)")
      self._ui.btn_SocketTooltip:addInputEvent("Mouse_Out", "PAGlobalFunc_CrystalTooltip_SolareCrystalToolTipOpen(false)")
      self._ui.btn_SocketTooltip:addInputEvent("Mouse_LUp", "PAGlobalFunc_CrystalTooltip_ToggleDetail()")
    else
      Panel_Solrare_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventUp_Solare_EquipPreset_SocketToolTipByPad()")
      Panel_Solrare_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventUp_Solare_EquipPreset_SocketDetailToolTipByPad()")
    end
  end
  if nil ~= Panel_Popup_Solare_BuyEquipment_All then
    self._ui.btn_BuyPresetCancel:addInputEvent("Mouse_LUp", "PaGlobal_Solare_EquipPreset:buyPresetPopupOpen(false)")
  end
end
function PaGlobal_Solare_EquipPreset:swichPlatform(isConsole)
  self._ui.btn_SocketTooltip:SetShow(not _ContentsGroup_UsePadSnapping)
end
function PaGlobal_Solare_EquipPreset:makeTemplete()
  local slotTemp = UI.getChildControl(self._ui.frame_Content, "Static_1")
  slotTemp:SetShow(false)
  local equipSlotBgTemp = UI.getChildControl(slotTemp, "Static_Equip_Templete")
  local equipSlotTemp = UI.getChildControl(equipSlotBgTemp, "RadioButton_ItemSlot_Templete")
  local lockSlotTemp = UI.getChildControl(equipSlotBgTemp, "Static_LockedSlotBg_Template")
  local readySlotTemp = UI.getChildControl(equipSlotBgTemp, "Static_ReadySlot_Templete")
  local equipedSlotTemp = UI.getChildControl(equipSlotBgTemp, "Static_EquipedSlot_Templete")
  equipSlotTemp:SetShow(false)
  lockSlotTemp:SetShow(false)
  lockSlotTemp:SetIgnore(false)
  readySlotTemp:SetShow(false)
  equipedSlotTemp:SetShow(false)
  self._slotMainBgSizeY = slotTemp:GetSizeY()
  self._slotEquipBgSpanY = equipSlotBgTemp:GetSpanSize().y
  self._originFrameControlSocketSpanY = equipSlotBgTemp:GetSpanSize().y
  for idx = 0, self._maxFrameCount - 1 do
    local tempTable = {
      clonedMainBg = nil,
      clonedEquipBg = nil,
      txt_Title = nil,
      stc_EquipSlotIcon = nil,
      txt_EquipSlot = nil,
      txt_EquipSocket0 = nil,
      txt_EquipSocket1 = nil,
      stc_EquipSocket0 = nil,
      stc_EquipSocket1 = nil,
      stc_TitleBg = nil,
      stc_SocketBg = nil,
      equipSlotTable = Array.new(),
      lockSlotTable = Array.new(),
      readySlotTable = Array.new(),
      equipedSlotTable = Array.new(),
      btn_socketChange = nil,
      currentSelectedItemIndex = -1
    }
    local clonedBg = UI.cloneControl(slotTemp, self._ui.frame_Content, "Static_SolarePreset_Group" .. tostring(idx))
    local clonedTitleBg = UI.getChildControl(clonedBg, "StaticText_Title_Templete")
    local clonedEquipSlotBg = UI.getChildControl(clonedBg, "Static_Equip_Templete")
    tempTable.stc_TitleBg = UI.getChildControl(clonedTitleBg, "Static_Title_BG")
    tempTable.stc_SocketBg = UI.getChildControl(clonedTitleBg, "Static_Crystal_BG")
    tempTable.stc_EquipSlotIcon = UI.getChildControl(clonedTitleBg, "Static_ItemName_Select")
    tempTable.txt_EquipSlot = UI.getChildControl(clonedTitleBg, "StaticText_ItemName_Select")
    tempTable.txt_EquipSocket0 = UI.getChildControl(tempTable.stc_SocketBg, "StaticText_Slot_0")
    tempTable.txt_EquipSocket1 = UI.getChildControl(tempTable.stc_SocketBg, "StaticText_Slot_1")
    tempTable.stc_EquipSocket0 = UI.getChildControl(tempTable.stc_SocketBg, "Static_SlotIcon_BG_0")
    tempTable.stc_EquipSocket1 = UI.getChildControl(tempTable.stc_SocketBg, "Static_SlotIcon_BG_1")
    local miniSocketSizeX = tempTable.stc_EquipSocket0:GetSizeX()
    local miniSocketSizeY = tempTable.stc_EquipSocket0:GetSizeY()
    local tempMini0 = {}
    SlotItem.new(tempMini0, "created_SolareEquipedSocketMini_0", idx, tempTable.stc_EquipSocket0, self._slotConfig)
    tempMini0:createChild()
    tempMini0:clearItem()
    tempMini0.icon:SetSize(miniSocketSizeX, miniSocketSizeY)
    tempMini0.border:SetSize(miniSocketSizeX, miniSocketSizeY)
    local tempMini1 = {}
    SlotItem.new(tempMini1, "created_SolareEquipedSocketMini_1", idx, tempTable.stc_EquipSocket1, self._slotConfig)
    tempMini1:createChild()
    tempMini1:clearItem()
    tempMini1.icon:SetSize(miniSocketSizeX, miniSocketSizeY)
    tempMini1.border:SetSize(miniSocketSizeX, miniSocketSizeY)
    tempTable.btn_socketChange = UI.getChildControl(clonedTitleBg, "Button_Set_Crystal")
    clonedBg:SetShow(true)
    clonedEquipSlotBg:SetShow(true)
    tempTable.txt_EquipSlot:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
    tempTable.txt_EquipSocket0:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
    tempTable.txt_EquipSocket1:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
    UI.setLimitTextAndAddTooltip(tempTable.txt_EquipSlot, tempTable.txt_EquipSlot:GetText(), "")
    UI.setLimitTextAndAddTooltip(tempTable.txt_EquipSocket0, tempTable.txt_EquipSocket0:GetText(), "")
    UI.setLimitTextAndAddTooltip(tempTable.txt_EquipSocket1, tempTable.txt_EquipSocket1:GetText(), "")
    local gap = 10
    for jj = 0, self._maxSlotCount - 1 do
      local clonedEquipSlot = UI.cloneControl(equipSlotTemp, clonedEquipSlotBg, "Radio_Equip_Slot" .. tostring(idx) .. "_" .. tostring(jj))
      local clonedLockSlot = UI.cloneControl(lockSlotTemp, clonedEquipSlotBg, "Static_Equip_lock" .. tostring(idx) .. "_" .. tostring(jj))
      local clonedReadySlot = UI.cloneControl(readySlotTemp, clonedEquipSlotBg, "Static_Equip_Ready" .. tostring(idx) .. "_" .. tostring(jj))
      local clonedEquipedSlot = UI.cloneControl(equipedSlotTemp, clonedEquipSlotBg, "Static_Equip_Equiped" .. tostring(idx) .. "_" .. tostring(jj))
      clonedEquipSlot:SetSpanSize((equipSlotTemp:GetSizeX() + gap) * jj, equipSlotTemp:GetSpanSize().y)
      clonedLockSlot:SetSpanSize((lockSlotTemp:GetSizeX() + gap) * jj, lockSlotTemp:GetSpanSize().y)
      clonedReadySlot:SetSpanSize((readySlotTemp:GetSizeX() + gap) * jj, readySlotTemp:GetSpanSize().y)
      clonedEquipedSlot:SetSpanSize((clonedEquipedSlot:GetSizeX() + gap) * jj, clonedEquipedSlot:GetSpanSize().y)
      local tempEquipSlotTable = {
        control = nil,
        slot = {},
        itemName = ""
      }
      tempEquipSlotTable.control = clonedEquipSlot
      tempEquipSlotTable.control:SetGroup(idx)
      SlotItem.new(tempEquipSlotTable.slot, "created_SolareEquipPresetSlot" .. tostring(jj), jj, clonedEquipSlot, self._slotConfig)
      tempEquipSlotTable.slot:createChild()
      tempEquipSlotTable.slot:clearItem()
      tempEquipSlotTable.slot.icon:SetPosY(2)
      tempEquipSlotTable.slot.icon:SetPosX(2)
      tempTable.equipSlotTable:push_back(tempEquipSlotTable)
      tempTable.lockSlotTable:push_back(clonedLockSlot)
      tempTable.readySlotTable:push_back(clonedReadySlot)
      tempTable.equipedSlotTable:push_back(clonedEquipedSlot)
    end
    clonedBg:SetSpanSize(clonedBg:GetSpanSize().x, (clonedBg:GetSizeY() + 10) * idx)
    clonedBg:SetShow(false)
    tempTable.clonedMainBg = clonedBg
    tempTable.clonedEquipBg = clonedEquipSlotBg
    tempTable.txt_Title = clonedTitleBg
    self._frameControlTable:push_back(tempTable)
  end
end
function PaGlobal_Solare_EquipPreset:prepareOpen()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  if false == _ContentsGroup_Solare then
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_Solrare_Matching:ignorePadSnapUpdate(true)
    self._ui.keypad_RB:SetShow(false)
    PaGlobal_Solare_EquipPreset:keyAlign()
  end
  local isClassType = getSelfPlayer():getClassType()
  if __eClassType_ShyWaman == isClassType then
    self._equipSlotString[__eEquipSlotNoAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON")
    self._equipTypeIcon[__eEquipSlotNoAwakenWeapon] = "Combine_Etc_Solare_War_Equip_Icon_Category_14"
    self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl, 283, 48, 329, 94)
    self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:setRenderTexture(self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:getBaseTexture())
  end
  ToClient_RequestLoadSolareEquipPresetList()
  ToClient_UpdateSolarePresetStat()
  PaGlobalFunc_PaGlobal_Solare_EquipPreset_OnScreenResize()
  self._ui.frame_VetiScroll:SetControlTop()
  PaGlobal_Solare_EquipPreset:socketChangeShow(false, -1)
  PaGlobal_Solare_EquipPreset:setTabButton()
  PaGlobal_Solare_EquipPreset:update()
  PaGlobal_Solare_EquipPreset:open()
end
function PaGlobal_Solare_EquipPreset:setTabButton()
  self._ui.rdo_Tab_Weapon:SetCheck(false)
  self._ui.rdo_Tab_Armor:SetCheck(false)
  self._ui.rdo_Tab_ETC:SetCheck(false)
  if self._eTab._eWeapon == self._selectedTab then
    self._ui.rdo_Tab_Weapon:SetCheck(true)
    self._ui.stc_Selected_Line:SetSpanSize(self._ui.rdo_Tab_Weapon:GetSpanSize().x, self._ui.stc_Selected_Line:GetSpanSize().y)
  elseif self._eTab._eArmor == self._selectedTab then
    self._ui.rdo_Tab_Armor:SetCheck(true)
    self._ui.stc_Selected_Line:SetSpanSize(self._ui.rdo_Tab_Armor:GetSpanSize().x, self._ui.stc_Selected_Line:GetSpanSize().y)
  elseif self._eTab._eOther == self._selectedTab then
    self._ui.rdo_Tab_ETC:SetCheck(true)
    self._ui.stc_Selected_Line:SetSpanSize(self._ui.rdo_Tab_ETC:GetSpanSize().x, self._ui.stc_Selected_Line:GetSpanSize().y)
  end
end
function PaGlobal_Solare_EquipPreset:changeEquipTypeIcon(control, type, isShy)
  if nil == control then
    return
  end
  if nil == self._equipTypeIcon[type] then
    return
  end
  local textureID = self._equipTypeIcon[type]
  if type == __eEquipSlotNoAwakenWeapon and true == isShy then
    textureID = "Combine_Etc_Solare_War_Equip_Icon_Category_14"
  end
  control:ChangeTextureInfoTextureIDAsync(textureID, 0)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_Solare_EquipPreset:resetAllSlot()
  for idx = 1, #self._frameControlTable do
    self._frameControlTable[idx].clonedMainBg:SetShow(false)
    self._frameControlTable[idx].txt_EquipSlot:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
    self._frameControlTable[idx].txt_Title:SetText("")
    self._frameControlTable[idx].stc_SocketBg:SetShow(true)
    self._frameControlTable[idx].txt_EquipSocket0:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
    self._frameControlTable[idx].txt_EquipSocket1:SetText(PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT"))
    self._frameControlTable[idx].stc_EquipSocket0:SetShow(false)
    self._frameControlTable[idx].stc_EquipSocket1:SetShow(false)
    self._frameControlTable[idx].btn_socketChange:removeInputEvent("Mouse_LUp")
    self._frameControlTable[idx].currentSelectedItemIndex = -1
    for jj = 1, #self._frameControlTable[idx].equipSlotTable do
      self._frameControlTable[idx].equipSlotTable[jj].control:SetShow(false)
      self._frameControlTable[idx].equipSlotTable[jj].control:SetCheck(false)
      self._frameControlTable[idx].equipSlotTable[jj].slot:clearItem()
      self._frameControlTable[idx].equipSlotTable[jj].itemName = ""
      self._frameControlTable[idx].lockSlotTable[jj]:SetShow(false)
      self._frameControlTable[idx].equipedSlotTable[jj]:SetShow(false)
    end
    self._frameControlTable[idx].clonedMainBg:SetSize(self._frameControlTable[idx].clonedMainBg:GetSizeX(), self._slotMainBgSizeY)
    self._frameControlTable[idx].clonedMainBg:ComputePos()
    self._frameControlTable[idx].clonedMainBg:SetSpanSize(self._frameControlTable[idx].clonedMainBg:GetSpanSize().x, (self._frameControlTable[idx].clonedMainBg:GetSizeY() + 10) * (idx - 1))
    self._frameControlTable[idx].clonedEquipBg:SetSpanSize(self._frameControlTable[idx].clonedEquipBg:GetSpanSize().x, self._slotEquipBgSpanY)
  end
  self._frameScrollCtrlPos = 0
  self._ui.frame_ShadowTop:SetShow(false)
  self._ui.frame_Shadow:SetShow(true)
  self._ui.frame_VetiScroll:SetControlTop()
  PaGlobal_Solare_EquipPreset:clearCachedIndex()
end
function PaGlobal_Solare_EquipPreset:update()
  PaGlobal_Solare_EquipPreset:updateEquipControl()
  PaGlobal_Solare_EquipPreset:updatePresetControl()
end
function PaGlobal_Solare_EquipPreset:updatePresetControl()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local myCoin = ToClient_GetMySolareCoin()
  self._ui.txt_Coin:SetText(myCoin)
  local classType = selfPlayer:getClassType()
  local startLoopIndex = 0
  local endLoopIndex = 2
  if self._eTab._eWeapon == self._selectedTab then
    startLoopIndex = 0
    endLoopIndex = 2
  elseif self._eTab._eArmor == self._selectedTab then
    startLoopIndex = 3
    endLoopIndex = 6
    classType = __eClassType_Count
  elseif self._eTab._eOther == self._selectedTab then
    startLoopIndex = 7
    endLoopIndex = 13
    classType = __eClassType_Count
  end
  local isShy = __eClassType_ShyWaman == classType
  local slotCount = 1
  local mainBgSize = 0
  for idx = startLoopIndex, endLoopIndex do
    local equipSlotNo = self._eEquipSlot[idx]
    if nil ~= self._frameControlTable[slotCount] then
      local equipString = self._equipSlotString[equipSlotNo]
      local UIFrameTable = self._frameControlTable[slotCount]
      local currentEquipString = PaGlobal_Solare_EquipPreset:getCurrentEquipItemName(equipSlotNo)
      UIFrameTable.txt_EquipSlot:SetText(currentEquipString)
      UI.setLimitTextAndAddTooltip(UIFrameTable.txt_EquipSlot, UIFrameTable.txt_EquipSlot:GetText(), "")
      PaGlobal_Solare_EquipPreset:changeEquipTypeIcon(UIFrameTable.stc_EquipSlotIcon, equipSlotNo, isShy)
      if equipSlotNo == __eEquipSlotNoAwakenWeapon and isShy == true then
        equipString = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_AWAKEN_WEAPON_TYPE")
      end
      UIFrameTable.txt_Title:SetText(equipString)
      local equipedSocketItemKey0 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 0)
      local equipedSocket0SSW = getItemEnchantStaticStatus(equipedSocketItemKey0)
      if nil ~= equipedSocket0SSW then
        UIFrameTable.txt_EquipSocket0:SetText(PaGlobalFunc_Util_GetItemGradeColorName(equipedSocket0SSW:get()._key))
        UI.setLimitTextAndAddTooltip(UIFrameTable.txt_EquipSocket0, UIFrameTable.txt_EquipSocket0:GetText(), "")
        UIFrameTable.stc_EquipSocket0:SetShow(true)
        local miniSocket0 = {}
        SlotItem.reInclude(miniSocket0, "created_SolareEquipedSocketMini_0", idx, UIFrameTable.stc_EquipSocket0, self._slotConfig)
        miniSocket0:setItemByStaticStatus(equipedSocket0SSW)
      end
      local equipedSocketItemKey1 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 1)
      local equipedSocket1SSW = getItemEnchantStaticStatus(equipedSocketItemKey1)
      if nil ~= equipedSocket1SSW then
        UIFrameTable.txt_EquipSocket1:SetText(PaGlobalFunc_Util_GetItemGradeColorName(equipedSocket1SSW:get()._key))
        UI.setLimitTextAndAddTooltip(UIFrameTable.txt_EquipSocket1, UIFrameTable.txt_EquipSocket1:GetText(), "")
        UIFrameTable.stc_EquipSocket1:SetShow(true)
        local miniSocket1 = {}
        SlotItem.reInclude(miniSocket1, "created_SolareEquipedSocketMini_1", idx, UIFrameTable.stc_EquipSocket1, self._slotConfig)
        miniSocket1:setItemByStaticStatus(equipedSocket1SSW)
      end
      local availableSocketSize = ToClient_GetSolarePresetSocketListSize(equipSlotNo)
      local canEquipSocket = self._eTab._eOther ~= self._selectedTab and availableSocketSize > 0
      UIFrameTable.btn_socketChange:SetShow(canEquipSocket)
      UIFrameTable.stc_SocketBg:SetShow(canEquipSocket)
      if true == canEquipSocket then
        UIFrameTable.btn_socketChange:addInputEvent("Mouse_LUp", "PaGlobal_Solare_EquipPreset:socketChangeBtnClick(" .. slotCount .. " ," .. equipSlotNo .. ")")
      else
        local sizeY = self._slotMainBgSizeY - UIFrameTable.stc_SocketBg:GetSizeY()
        UIFrameTable.clonedMainBg:SetSize(UIFrameTable.clonedMainBg:GetSizeX(), sizeY)
        UIFrameTable.clonedMainBg:SetSpanSize(UIFrameTable.clonedMainBg:GetSpanSize().x, mainBgSize + 10)
        UIFrameTable.clonedEquipBg:SetSpanSize(UIFrameTable.clonedEquipBg:GetSpanSize().x, UIFrameTable.stc_TitleBg:GetSizeY() + 5)
      end
      local equipItemCount = ToClient_GetSolarePresetEquipListSize(equipSlotNo, classType)
      for mainSlotIndex = 1, equipItemCount do
        local presetLevel = mainSlotIndex - 1
        local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(equipSlotNo, classType, presetLevel, false)
        if presetEquipSSW == nil then
          return
        end
        local needCoin = presetEquipSSW:getSolareCoin()
        local isBasicItem = needCoin <= 0
        local isUnlocked = ToClient_isUnlockSolareEquipPresetByIndex(equipSlotNo, presetLevel, false)
        local equipItemKey = presetEquipSSW:getEquipItemKey()
        if true == equipItemKey:isDefined() then
          local itemSSW = getItemEnchantStaticStatus(equipItemKey)
          if nil ~= itemSSW then
            local isEquipedItem = false
            UIFrameTable.equipedSlotTable[mainSlotIndex]:SetShow(false)
            if -1 ~= self._ui.stc_EquipTable[equipSlotNo].currentEquipItemKey and self._ui.stc_EquipTable[equipSlotNo].currentEquipItemKey:getItemKey() == equipItemKey:getItemKey() then
              UIFrameTable.currentSelectedItemIndex = mainSlotIndex - 1
              isEquipedItem = true
              UIFrameTable.equipedSlotTable[mainSlotIndex]:SetShow(true)
            end
            local slot = UIFrameTable.equipSlotTable[mainSlotIndex].slot
            local slotControl = UIFrameTable.equipSlotTable[mainSlotIndex].control
            slotControl:SetShow(true)
            slot:setItemByStaticStatus(itemSSW)
            slot._item = equipItemKey
            Panel_Tooltip_Item_SetPosition(equipSlotNo + mainSlotIndex, slot, "SolarePreset")
            UIFrameTable.equipSlotTable[mainSlotIndex].itemName = itemSSW:getName()
            slot.icon:SetShow(true)
            slot.icon:removeInputEvent("Mouse_RUp")
            slot.icon:removeInputEvent("Mouse_LUp")
            slot.icon:removeInputEvent("Mouse_On")
            slot.icon:removeInputEvent("Mouse_Out")
            local lockItemControl = UIFrameTable.lockSlotTable[mainSlotIndex]
            lockItemControl:SetShow(not isUnlocked and not (needCoin <= 0))
            if true == isUnlocked then
              if false == isEquipedItem then
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLRUp_Solare_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                if _ContentsGroup_UsePadSnapping == false then
                  slot.icon:addInputEvent("Mouse_RUp", "HandleEventLRUp_Solare_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                end
              end
            else
              if true == isBasicItem then
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLRUp_Solare_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                if _ContentsGroup_UsePadSnapping == false then
                  slot.icon:addInputEvent("Mouse_RUp", "HandleEventLRUp_Solare_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                end
              else
                slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. presetLevel .. ",false)")
                lockItemControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. presetLevel .. ",false)")
              end
              if _ContentsGroup_UsePadSnapping == false then
                lockItemControl:addInputEvent("Mouse_On", "HandleEventOnOut_Solare_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",true)")
                lockItemControl:addInputEvent("Mouse_Out", "HandleEventOnOut_Solare_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",false)")
              else
                slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Solare_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",false)")
              end
            end
            if _ContentsGroup_UsePadSnapping == false then
              slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Solare_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",true)")
              slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Solare_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",false)")
            else
              slotControl:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Solare_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",false)")
            end
          end
        end
      end
      mainBgSize = mainBgSize + UIFrameTable.clonedMainBg:GetSizeY()
      UIFrameTable.clonedMainBg:SetShow(true)
      slotCount = slotCount + 1
    end
  end
  self._ui.frame_Content:SetSize(self._ui.frame_Content:GetSizeX(), mainBgSize + (slotCount + 45) + self._ui.frame_ShadowTop:GetSizeY())
  self._ui.frame_VetiScroll:SetInterval(self._ui.frame_Content:GetSizeY() / 100 * 1.1)
  self._ui.frame_MainSlotBg:UpdateContentScroll()
  self._ui.frame_MainSlotBg:UpdateContentPos()
end
function PaGlobal_Solare_EquipPreset:updateEquipControl()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local isEquipItemChange = false
  for idx = 1, #self._eEquipSlot do
    local equipSlotNo = self._eEquipSlot[idx - 1]
    local equipControlTable = self._ui.stc_EquipTable[equipSlotNo]
    if equipControlTable ~= nil then
      local currentEquipItemWrapper = ToClient_GetSolareEquippedItemWrapper(self._selectedEquipPresetNo, equipSlotNo)
      if currentEquipItemWrapper == nil then
        equipControlTable.slot:clearItem()
        if _ContentsGroup_UsePadSnapping == false then
          equipControlTable.slot.icon:removeInputEvent("Mouse_On")
          equipControlTable.slot.icon:removeInputEvent("Mouse_Out")
        end
        equipControlTable.currentEquipItemKey = -1
        equipControlTable.currentEquipItemName = ""
        equipControlTable.bgControl:SetShow(true)
      else
        local itemEnchantKey = currentEquipItemWrapper:get():getKey()
        local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
        if nil ~= itemSSW then
          SlotItem.reInclude(equipControlTable.slot, "created_EquipItemSlot_" .. tostring(idx), idx, equipControlTable.control, self._slotConfig)
          equipControlTable.slot:setItemByStaticStatus(itemSSW)
          equipControlTable.slot._item = itemEnchantKey:getItemKey()
          Panel_Tooltip_Item_SetPosition(self._selectedEquipPresetNo + equipSlotNo, equipControlTable.slot, "solareEquipment")
          if _ContentsGroup_UsePadSnapping == false then
            equipControlTable.slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Solare_EquipPreset_EquipTooltip(" .. tostring(self._selectedEquipPresetNo) .. "," .. tonumber(equipSlotNo) .. ",true)")
            equipControlTable.slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Solare_EquipPreset_EquipTooltip(" .. tostring(self._selectedEquipPresetNo) .. "," .. tonumber(equipSlotNo) .. ",false)")
          end
          equipControlTable.currentEquipItemKey = itemSSW:get()._key
          if true == Panel_Solrare_EquipPresetList:GetShow() and equipControlTable.currentEquipItemKey ~= itemSSW:get()._key then
            isEquipItemChange = true
          end
          equipControlTable.currentEquipItemName = PaGlobalFunc_Util_GetItemGradeColorName(itemSSW:get()._key)
          equipControlTable.bgControl:SetShow(false)
        end
      end
    end
  end
  local classType = selfPlayer:getClassType()
  local offenceValue = ToClient_GetSolarePresetOffenceStat()
  local defenceValue = ToClient_GetSolarePresetDefenceStat()
  local awakenValue = ToClient_GetSolarePresetAwakenOffenceStat()
  self._ui.txt_AttackValue:SetText(math.floor(offenceValue))
  self._ui.txt_DefenceValue:SetText(math.floor(defenceValue))
  local isShy = __eClassType_ShyWaman == classType
  self._ui.txt_AwakenValue:SetShow(not isShy)
  self._ui.txt_AwakenTitle:SetShow(not isShy)
  self._ui.txt_ShyTitle:SetShow(isShy)
  self._ui.txt_ShyValue:SetShow(isShy)
  if true == isShy then
    self._ui.txt_ShyValue:SetText(math.floor(awakenValue))
  else
    self._ui.txt_AwakenValue:SetText(math.floor(awakenValue))
  end
  self._awakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  if nil == self._awakenWeaponContentsOpen then
    self._awakenWeaponContentsOpen = false
  end
  local awakenWeaponItemWrapper = ToClient_GetSolareEquippedItemWrapper(self._selectedEquipPresetNo, __eEquipSlotNoAwakenWeapon)
  if self._awakenWeaponContentsOpen and nil ~= awakenWeaponItemWrapper then
    self._ui.txt_Attack:SetSpanSize(self._ui.txt_Attack:GetSpanSize().x, 15)
    self._ui.txt_AttackValue:SetSpanSize(self._ui.txt_AttackValue:GetSpanSize().x, 15)
    self._ui.txt_Defence:SetSpanSize(self._ui.txt_Defence:GetSpanSize().x, 95)
    self._ui.txt_DefenceValue:SetSpanSize(self._ui.txt_DefenceValue:GetSpanSize().x, 95)
  else
    self._ui.txt_AwakenValue:SetShow(false)
    self._ui.txt_AwakenTitle:SetShow(false)
    self._ui.txt_ShyTitle:SetShow(false)
    self._ui.txt_ShyValue:SetShow(false)
    self._ui.txt_Attack:SetSpanSize(self._ui.txt_Attack:GetSpanSize().x, 35)
    self._ui.txt_AttackValue:SetSpanSize(self._ui.txt_AttackValue:GetSpanSize().x, 35)
    self._ui.txt_Defence:SetSpanSize(self._ui.txt_Defence:GetSpanSize().x, 75)
    self._ui.txt_DefenceValue:SetSpanSize(self._ui.txt_DefenceValue:GetSpanSize().x, 75)
  end
  if true == isEquipItemChange then
    self._ui.stc_EquipTable[__eEquipSlotNoAlchemyStone].control:AddEffect("UI_ItemInstall_BigRing02", false, 0, 0)
    if self._atkValue ~= offenceValue then
      self._ui.txt_AttackValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      self._ui.txt_AttackValue:AddEffect("UI_SkillButton01", false, 19, -1)
      self._atkValue = offenceValue
    end
    if self._defValue ~= defenceValue then
      self._ui.txt_DefenceValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      self._ui.txt_DefenceValue:AddEffect("UI_SkillButton01", false, 19, -1)
      self._defValue = defenceValue
    end
    if self._awakenValue ~= awakenValue and self._awakenWeaponContentsOpen then
      if true == isShy then
        self._ui.txt_AwakenValue:AddEffect("fUI_SkillButton01", false, 19, -1)
        self._ui.txt_AwakenValue:AddEffect("UI_SkillButton01", false, 19, -1)
      else
        self._ui.txt_ShyValue:AddEffect("fUI_SkillButton01", false, 19, -1)
        self._ui.txt_ShyValue:AddEffect("UI_SkillButton01", false, 19, -1)
      end
      self._awakenValue = awakenValue
    end
  end
end
function PaGlobal_Solare_EquipPreset:socketChangeBtnClick(mainBgIndex, equipSlot)
  if nil == equipSlot then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if self._eTab._eOther == self._selectedTab then
    return
  end
  if nil == self._frameControlTable[mainBgIndex] then
    return
  end
  local classType = selfPlayer:getClassType()
  if self._eTab._eWeapon ~= self._selectedTab then
    classType = __eClassType_Count
  end
  local currentEquipItem = ToClient_GetSolareEquippedItemWrapper(self._selectedEquipPresetNo, equipSlot)
  if currentEquipItem == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_MSG"))
    return
  end
  self._currentPushedSocketItemKey0 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, equipSlot, 0)
  self._currentPushedSocketItemKey1 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, equipSlot, 1)
  if -1 == self._frameControlTable[mainBgIndex].currentSelectedItemIndex then
    local equipItemCount = ToClient_GetSolarePresetEquipListSize(equipSlot, classType)
    for idx = 0, equipItemCount - 1 do
      local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(equipSlot, classType, idx, false)
      if presetEquipSSW ~= presetEquipSSW then
        local equipItemKey = presetEquipSSW:getEquipItemKey()
        if currentEquipItem:get():getKey():getItemKey() == equipItemKey:getItemKey() then
          self._frameControlTable[mainBgIndex].currentSelectedItemIndex = idx
        end
      end
    end
  end
  self._ui.list2_SocketEquipBg:getElementManager():clearKey()
  self._unlockedSocketTable = Array.new()
  local socketItemList = ToClient_GetSolarePresetSocketListSize(equipSlot)
  if socketItemList > 0 then
    for socketIndex = 0, socketItemList - 1 do
      local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(equipSlot, classType, socketIndex, true)
      if presetEquipSSW ~= nil then
        local socketItemKey = presetEquipSSW:getEquipItemKey()
        local needCoin = presetEquipSSW:getSolareCoin()
        local isUnlocked = ToClient_isUnlockSolareEquipPresetByIndex(equipSlot, socketIndex, true) or needCoin <= 0
        if true == isUnlocked then
          local tempTable = {
            _itemKey = socketItemKey:getItemKey(),
            _isUnlock = isUnlocked,
            _isFree = needCoin <= 0
          }
          self._unlockedSocketTable:push_back(tempTable)
        end
        for avaliableSocketCount = 1, 2 do
          self._ui.list2_SocketEquipBg:getElementManager():pushKey(toInt64(socketIndex, socketItemKey:getItemKey()))
        end
      end
    end
    PaGlobal_Solare_EquipPreset:socketChangeTabClick(0)
    PaGlobal_Solare_EquipPreset:socketChangeShow(true, mainBgIndex, equipSlot)
  end
end
function PaGlobal_Solare_EquipPreset:socketChangeShow(isShow, mainBgIndex, equipSlot)
  if nil == equipSlot then
    equipSlot = -1
  end
  self._ui.frame_BlackBg:SetShow(isShow)
  self._ui.stc_SocketEquipBg:SetShow(isShow)
  if _ContentsGroup_UsePadSnapping == true then
    local isPanelShow = self._ui.stc_SocketEquipBg:GetShow()
    Panel_Window_Solrare_Matching:ignorePadSnapUpdate(isPanelShow)
  end
  if false == isShow then
    PaGlobal_Solare_EquipPreset:clearCachedIndex()
    if _ContentsGroup_UsePadSnapping == true then
      return
    end
  else
    self._currentOpenEquipNoBySocketChange64 = toInt64(mainBgIndex, equipSlot)
  end
  if _ContentsGroup_UsePadSnapping == true then
    local elementManager = self._ui.list2_SocketEquipBg:getElementManager()
    if elementManager ~= nil then
      local contentsCount = Int64toInt32(elementManager:getSize())
      for index = 0, contentsCount - 1 do
        local contentKey = self._ui.list2_SocketEquipBg:getKeyByIndex(index)
        local content = self._ui.list2_SocketEquipBg:GetContentByKey(contentKey)
        if content ~= nil then
          ToClient_padSnapChangeToTarget(content)
          break
        end
      end
    end
  end
end
function PaGlobal_Solare_EquipPreset:buyPresetPopupOpen(isShow, classType, equipSlotNo, presetLevel, isSocket)
  if false == isShow then
    self._ui.panel_BuyPreset:SetShow(false)
    if _ContentsGroup_UsePadSnapping == true then
      Panel_Solrare_EquipPresetList:ignorePadSnapUpdate(false)
      Panel_Window_Solrare_Matching:ignorePadSnapUpdate(false)
    end
    return
  end
  local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(equipSlotNo, classType, presetLevel, isSocket)
  if nil == presetEquipSSW then
    return
  end
  local equipItemKey = presetEquipSSW:getEquipItemKey(presetLevel)
  local itemSSW = getItemEnchantStaticStatus(equipItemKey)
  if nil == itemSSW then
    return
  end
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, "SolareEquipPreset_BuyPopup", equipSlotNo, self._ui.stc_BuyPresetSlotBg, self._slotConfig)
  itemSlot:setItemByStaticStatus(itemSSW)
  local myCoin = ToClient_GetMySolareCoin()
  local needCoin = presetEquipSSW:getSolareCoin()
  local isBuyAble = myCoin >= needCoin
  self._ui.txt_BuyPresetItemName:SetText(itemSSW:getName())
  self._ui.txt_BuyPresetNeedCoin:SetText(needCoin)
  self._ui.btn_BuyPresetConfirm:SetIgnore(not isBuyAble, not isBuyAble)
  self._ui.btn_BuyPresetConfirm:SetMonoTone(not isBuyAble, not isBuyAble)
  if true == isBuyAble then
    self._ui.txt_BuyPresetNeedCoin:SetFontColor(Defines.Color.C_FFE0E0E0)
    self._ui.btn_BuyPresetConfirm:addInputEvent("Mouse_LUp", "PaGlobal_Solare_EquipPreset:buyPresetPopupRequest(" .. tostring(equipSlotNo) .. ", " .. tostring(presetLevel) .. "," .. tostring(isSocket) .. ")")
  else
    self._ui.btn_BuyPresetConfirm:removeInputEvent("Mouse_LUp")
    self._ui.txt_BuyPresetNeedCoin:SetFontColor(Defines.Color.C_FFEE5555)
  end
  self._ui.stc_BuyPresetBlackBg:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.stc_BuyPresetBlackBg:ComputePos()
  self._ui.panel_BuyPreset:ComputePos()
  self._ui.panel_BuyPreset:SetShow(true)
  if _ContentsGroup_UsePadSnapping == true and self._ui.panel_BuyPreset:GetShow() == true then
    Panel_Solrare_EquipPresetList:ignorePadSnapUpdate(true)
    Panel_Window_Solrare_Matching:ignorePadSnapUpdate(true)
    ToClient_padSnapSetTargetPanel(self._ui.panel_BuyPreset)
  end
end
function PaGlobal_Solare_EquipPreset:buyPresetPopupRequest(equipSlotNo, presetLevel, isSocket)
  if nil == self._ui.panel_BuyPreset or false == self._ui.panel_BuyPreset:GetShow() then
    return
  end
  local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(equipSlotNo, classType, presetLevel, isSocket)
  if nil == presetEquipSSW then
    return
  end
  local equipItemKey = presetEquipSSW:getEquipItemKey(presetLevel)
  local itemSSW = getItemEnchantStaticStatus(equipItemKey)
  if nil == itemSSW then
    return
  end
  ToClient_RequestSolarePresetUnlock(equipSlotNo, presetLevel, isSocket)
end
function PaGlobal_Solare_EquipPreset:clearCachedIndex()
  self._currentOpenEquipNoBySocketChange64 = -1
  self._currentPushedSocketItemKey0 = -1
  self._currentPushedSocketItemKey1 = -1
  self._selectedSocketPresetNo0 = -1
  self._selectedSocketPresetNo1 = -1
end
function PaGlobal_Solare_EquipPreset:socketChangeTabClick(idx)
  self._selectedSocketTab = idx
  self._ui.rdo_SocketEquipBg_Slot1:SetCheck(false)
  self._ui.rdo_SocketEquipBg_Slot2:SetCheck(false)
  if 0 == self._selectedSocketTab then
    self._ui.rdo_SocketEquipBg_Slot1:SetCheck(true)
    self._ui.stc_SocketEquipBg_Selected:SetSpanSize(self._ui.rdo_SocketEquipBg_Slot1:GetSpanSize().x, self._ui.stc_SocketEquipBg_Selected:GetSpanSize().y)
  elseif 1 == self._selectedSocketTab then
    self._ui.rdo_SocketEquipBg_Slot2:SetCheck(true)
    self._ui.stc_SocketEquipBg_Selected:SetSpanSize(self._ui.rdo_SocketEquipBg_Slot2:GetSpanSize().x, self._ui.stc_SocketEquipBg_Selected:GetSpanSize().y)
  end
  self._ui.list2_SocketEquipBg:requestUpdateVisible()
end
function PaGlobal_Solare_EquipPreset:getCurrentEquipItemName(equipSlot)
  if nil == equipSlot then
    return ""
  end
  for idx = 1, #self._eEquipSlot do
    local equipSlotNo = self._eEquipSlot[idx - 1]
    if equipSlotNo == equipSlot and nil ~= self._ui.stc_EquipTable[equipSlotNo] then
      return self._ui.stc_EquipTable[equipSlotNo].currentEquipItemName
    end
  end
end
function PaGlobal_Solare_EquipPreset:open()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  self._ui.panel_BlackBg:SetShow(true)
  Panel_Solrare_EquipPresetList:SetShow(true)
end
function PaGlobal_Solare_EquipPreset:prepareClose()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  if true == self._ui.panel_BuyPreset:GetShow() then
    PaGlobal_Solare_EquipPreset:buyPresetPopupOpen(false)
    return
  end
  if true == self._ui.stc_SocketEquipBg:GetShow() then
    PaGlobal_Solare_EquipPreset:socketChangeShow(false)
    return
  end
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Window_Solrare_Matching:ignorePadSnapUpdate(false)
  end
  PAGlobalFunc_CrystalTooltip_SolareCrystalToolTipOpen(false)
  PaGlobal_Solare_EquipPreset:close()
end
function PaGlobal_Solare_EquipPreset:close()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  self._ui.panel_BlackBg:SetShow(false)
  Panel_Solrare_EquipPresetList:SetShow(false)
end
function PaGlobal_Solare_EquipPreset:keyAlign()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui.keypadTable, self._ui.keyguildBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobalFunc_PaGlobal_Solare_EquipPreset_Open()
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterSolrareStart"))
    return
  end
  if true == ToClient_IsMatchingStateByMatchServer() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_ALERT"))
    return
  end
  PaGlobal_Solare_EquipPreset:prepareOpen()
end
function PaGlobalFunc_PaGlobal_Solare_EquipPreset_Close()
  PaGlobal_Solare_EquipPreset:prepareClose()
end
function PaGlobalFunc_PaGlobal_Solare_EquipPreset_ScrollEvent(isUp)
  local self = PaGlobal_Solare_EquipPreset
  if false == self._ui.frame_VetiScroll:GetShow() then
    self._ui.frame_ShadowTop:SetShow(false)
    self._ui.frame_Shadow:SetShow(false)
    return
  end
  local scollCtrlPos = self._ui.frame_VetiScrollCtrl:GetPosY()
  if 1 > self._frameScrollCtrlPos then
    self._ui.frame_ShadowTop:SetShow(false)
    self._ui.frame_Shadow:SetShow(true)
  elseif self._frameScrollCtrlPos > 0 and scollCtrlPos ~= self._frameScrollCtrlPos then
    self._ui.frame_ShadowTop:SetShow(true)
    self._ui.frame_Shadow:SetShow(true)
  elseif scollCtrlPos == self._frameScrollCtrlPos then
    self._ui.frame_ShadowTop:SetShow(true)
    self._ui.frame_Shadow:SetShow(false)
  end
  self._frameScrollCtrlPos = scollCtrlPos
end
function HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelect(idx)
  if idx == PaGlobal_Solare_EquipPreset._selectedTab then
    return
  end
  PaGlobal_Solare_EquipPreset._selectedTab = idx
  PaGlobal_Solare_EquipPreset:resetAllSlot()
  PaGlobal_Solare_EquipPreset:socketChangeShow(false)
  PaGlobal_Solare_EquipPreset:setTabButton()
  PaGlobal_Solare_EquipPreset:updatePresetControl()
end
function HandleEventLUp_PaGlobal_Solare_EquipPreset_TabSelectByPad(isUp)
  if isUp == true then
    PaGlobal_Solare_EquipPreset._selectedTab = PaGlobal_Solare_EquipPreset._selectedTab + 1
    if PaGlobal_Solare_EquipPreset._selectedTab > PaGlobal_Solare_EquipPreset._eTab._eOther then
      PaGlobal_Solare_EquipPreset._selectedTab = PaGlobal_Solare_EquipPreset._eTab._eWeapon
    end
  else
    PaGlobal_Solare_EquipPreset._selectedTab = PaGlobal_Solare_EquipPreset._selectedTab - 1
    if PaGlobal_Solare_EquipPreset._selectedTab < PaGlobal_Solare_EquipPreset._eTab._eWeapon then
      PaGlobal_Solare_EquipPreset._selectedTab = PaGlobal_Solare_EquipPreset._eTab._eOther
    end
  end
  PaGlobal_Solare_EquipPreset:resetAllSlot()
  PaGlobal_Solare_EquipPreset:socketChangeShow(false)
  PaGlobal_Solare_EquipPreset:setTabButton()
  PaGlobal_Solare_EquipPreset:updatePresetControl()
end
function HandleEventOnOut_Solare_EquipPreset_SocketTooltip(equipSlotNo, isShow)
  if _ContentsGroup_UsePadSnapping == true then
    isShow = not Panel_Tooltup_Item_isShow()
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_Show_GeneralStatic(equipSlotNo, "SolareSocket", isShow, false, Panel_Solrare_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_Solrare_EquipPresetList:GetPosY())
end
function HandleEventOnOut_Solare_EquipPreset_Tooltip(equipSlotNo, presetIndex, isShow)
  if _ContentsGroup_RenewUI == true then
    local classType = __eClassType_Count
    if equipSlotNo == __eEquipSlotNoRightHand or equipSlotNo == __eEquipSlotNoLeftHand or equipSlotNo == __eEquipSlotNoAwakenWeapon then
      classType = getSelfPlayer():getClassType()
    end
    local itemSSW = ToClient_GetSolarePresetItemWrapper(equipSlotNo, classType, presetIndex - 1)
    if itemSSW ~= nil then
      local slotIndex = toInt64(PaGlobal_Solare_EquipPreset._selectedEquipPresetNo, equipSlotNo)
      PaGlobalFunc_TooltipInfo_SolareEquipPresetOpen(Defines.TooltipDataType.ItemWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "SolarePreset", slotIndex)
    end
  else
    if _ContentsGroup_UsePadSnapping == true then
      isShow = not Panel_Tooltup_Item_isShow()
    end
    if false == isShow then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    local slotIndex = toInt64(equipSlotNo, presetIndex)
    Panel_Tooltip_Item_Show_GeneralStatic(slotIndex, "SolarePreset", isShow, false, Panel_Solrare_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_Solrare_EquipPresetList:GetPosY())
  end
end
function HandleEventOnOut_Solare_EquipPreset_EquipTooltip(presetNo, equipSlotNo, isShow)
  if _ContentsGroup_UsePadSnapping == true then
    isShow = not Panel_Tooltup_Item_isShow()
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local slotIndex = toInt64(presetNo, equipSlotNo)
  Panel_Tooltip_Item_Show_GeneralNormal(slotIndex, "solareEquipment", isShow, slotIndex, Panel_Solrare_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_Solrare_EquipPresetList:GetPosY())
end
function PaGlobalFunc_PaGlobal_Solare_EquipPreset_UnlockCondition(classType, equipSlotNo, presetLevel, isSocket)
  PaGlobal_Solare_EquipPreset:buyPresetPopupOpen(true, classType, equipSlotNo, presetLevel, isSocket)
end
function PaGlobalFunc_PaGlobal_Solare_EquipPreset_OnScreenResize()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  Panel_Solrare_EquipPresetList:ComputePos()
  PaGlobal_Solare_EquipPreset._ui.panel_BlackBg:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_Solare_EquipPreset._ui.panel_BlackBg:ComputePos()
end
function FromClient_SolareSettingEquipPreset_Update()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  PaGlobal_Solare_EquipPreset:updateEquipControl()
  if false == Panel_Solrare_EquipPresetList:GetShow() then
    return
  end
  ToClient_UpdateSolarePresetStat()
  PaGlobal_Solare_EquipPreset:socketChangeShow(false)
  PaGlobal_Solare_EquipPreset:update()
  audioPostEvent_SystemUi(30, 14)
  _AudioPostEvent_SystemUiForXBOX(30, 14)
end
function FromClient_Solare_EquipPreset_UnlockUpdate()
  if nil == Panel_Solrare_EquipPresetList then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUYCOMPLETE"))
  PaGlobal_Solare_EquipPreset:buyPresetPopupOpen(false)
  PaGlobal_Solare_EquipPreset:updatePresetControl()
  local mainBgIndex = highFromUint64(PaGlobal_Solare_EquipPreset._currentOpenEquipNoBySocketChange64)
  local equipSlotNo = lowFromUint64(PaGlobal_Solare_EquipPreset._currentOpenEquipNoBySocketChange64)
  PaGlobal_Solare_EquipPreset:socketChangeBtnClick(mainBgIndex, equipSlotNo)
end
function FromClient_SolareEquip_UpdateSocketList(content, key)
  local self = PaGlobal_Solare_EquipPreset
  local str = tostring(content:GetID())
  local length = string.len(str)
  local contentIndex = string.sub(str, length, length)
  local socketSlotIndex = contentIndex % 2
  local index = highFromUint64(key)
  local itemKey = lowFromUint64(key)
  local list2RadioButton = UI.getChildControl(content, "RadioButton_1")
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemSSW then
    list2RadioButton:SetShow(false)
    return
  end
  list2RadioButton:SetShow(true)
  local list2ItemSlotBg = UI.getChildControl(list2RadioButton, "Static_ItemSlotBG")
  local list2EquipState = UI.getChildControl(list2RadioButton, "StaticText_EquipState")
  local list2ItemName = UI.getChildControl(list2ItemSlotBg, "StaticText_ItemName")
  local list2Selected = UI.getChildControl(list2RadioButton, "StaticText_Selected")
  local list2Locked = UI.getChildControl(list2ItemSlotBg, "Static_LockedSlotBg_Template")
  list2ItemName:SetText(PaGlobalFunc_Util_GetItemGradeColorName(ItemEnchantKey(itemKey, 0)))
  UI.setLimitTextAndAddTooltip(list2ItemName, list2ItemName:GetText(), "")
  local list2ItemSlot = UI.getChildControl(list2ItemSlotBg, "Static_ItemIcon")
  local slotTable = {}
  SlotItem.reInclude(slotTable, "SolareEquipPreset_SocketSlot", index, list2ItemSlot, self._slotConfig)
  slotTable:setItemByStaticStatus(itemSSW)
  slotTable._item = ItemEnchantKey(itemKey, 0)
  Panel_Tooltip_Item_SetPosition(index, slotTable, "SolareSocket")
  if _ContentsGroup_UsePadSnapping == false then
    slotTable.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Solare_EquipPreset_SocketTooltip(" .. tostring(index) .. ",true)")
    slotTable.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Solare_EquipPreset_SocketTooltip(" .. tostring(index) .. ",false)")
  else
    list2RadioButton:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_Solare_EquipPreset_SocketTooltip(" .. tostring(index) .. ",false)")
  end
  list2EquipState:SetShow(false)
  list2Selected:SetShow(false)
  list2RadioButton:SetIgnore(false)
  list2RadioButton:SetCheck(false)
  slotTable.icon:removeInputEvent("Mouse_LUp")
  list2RadioButton:removeInputEvent("Mouse_LUp")
  list2Locked:SetShow(false)
  local isUnlocked = false
  local isFree = false
  for idx = 1, #self._unlockedSocketTable do
    if self._unlockedSocketTable[idx]._itemKey == itemKey then
      isUnlocked = self._unlockedSocketTable[idx]._isUnlock
      isFree = self._unlockedSocketTable[idx]._isFree
      break
    end
  end
  list2Locked:SetShow(not isUnlocked and not isFree)
  if -1 == self._currentOpenEquipNoBySocketChange64 then
    return
  end
  if false == isUnlocked then
    local mainBgIndex = highFromUint64(self._currentOpenEquipNoBySocketChange64)
    if nil == self._frameControlTable[mainBgIndex] then
      return
    end
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local equipSlotNo = lowFromUint64(self._currentOpenEquipNoBySocketChange64)
    local presetLevel = self._frameControlTable[mainBgIndex].currentSelectedItemIndex
    local classType = selfPlayer:getClassType()
    if self._eTab._eWeapon ~= self._selectedTab then
      classType = __eClassType_Count
    end
    slotTable.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. index .. ",true)")
    list2RadioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. index .. ",true)")
    list2ItemName:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_Solare_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. index .. ",true)")
    return
  end
  if 0 == socketSlotIndex then
    if self._currentPushedSocketItemKey0:getItemKey() == itemKey then
      list2EquipState:SetShow(true)
      list2RadioButton:SetIgnore(true)
      if -1 == self._selectedSocketPresetNo0 then
        self._selectedSocketPresetNo0 = index
      end
    else
      if self._selectedSocketPresetNo0 == index then
        list2RadioButton:SetCheck(true)
        list2Selected:SetShow(true)
      end
      slotTable.icon:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
      list2RadioButton:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
      list2ItemName:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
    end
  elseif 1 == socketSlotIndex then
    if self._currentPushedSocketItemKey1:getItemKey() == itemKey then
      list2RadioButton:SetIgnore(true)
      list2EquipState:SetShow(true)
      if -1 == self._selectedSocketPresetNo1 then
        self._selectedSocketPresetNo1 = index
      end
    else
      if self._selectedSocketPresetNo1 == index then
        list2RadioButton:SetCheck(true)
        list2Selected:SetShow(true)
      end
      slotTable.icon:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
      list2RadioButton:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
      list2ItemName:addInputEvent("Mouse_LUp", "HandleEventUp_Solare_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
    end
  end
end
function HandleEventUp_Solare_EquipPreset_SocketSelect(socketIndex, socketPresetIndex)
  local self = PaGlobal_Solare_EquipPreset
  if 0 == socketIndex then
    self._selectedSocketPresetNo0 = socketPresetIndex
  elseif 1 == socketIndex then
    self._selectedSocketPresetNo1 = socketPresetIndex
  end
  self._ui.list2_SocketEquipBg:requestUpdateVisible()
end
function HandleEventUp_Solare_EquipPreset_SocketToolTipByPad()
  local isShow = Panel_Equipment_Crystal_Tooltip:GetShow()
  PAGlobalFunc_CrystalTooltip_SolareCrystalToolTipOpen(not isShow)
  PaGlobal_Solare_EquipPreset._ui.keypad_RB:SetShow(not isShow)
  PaGlobal_Solare_EquipPreset:keyAlign()
end
function HandleEventUp_Solare_EquipPreset_SocketDetailToolTipByPad()
  local isShow = Panel_Equipment_Crystal_Tooltip:GetShow()
  if isShow == false then
    return
  end
  PAGlobalFunc_CrystalTooltip_ToggleDetail()
end
function HandleEventUp_Solare_EquipPreset_SocketChangeConfrim()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterSolrareStart"))
    return
  end
  local self = PaGlobal_Solare_EquipPreset
  if -1 == self._currentOpenEquipNoBySocketChange64 then
    return
  end
  local self = PaGlobal_Solare_EquipPreset
  local mainBgIndex = highFromUint64(self._currentOpenEquipNoBySocketChange64)
  if nil == self._frameControlTable[mainBgIndex] then
    return
  end
  local selectedEquipSlotNo = lowFromUint64(self._currentOpenEquipNoBySocketChange64)
  if __eEquipSlotNoBelt == selectedEquipSlotNo or __eEquipSlotNoNecklace == selectedEquipSlotNo or __eEquipSlotNoEaring1 == selectedEquipSlotNo or __eEquipSlotNoEaring2 == selectedEquipSlotNo or __eEquipSlotNoRing1 == selectedEquipSlotNo or __eEquipSlotNoRing2 == selectedEquipSlotNo or __eEquipSlotNoAlchemyStone == selectedEquipSlotNo then
    return
  end
  if self._eTab._eOther == self._selectedTab then
    return
  end
  local classType = selfPlayer:getClassType()
  if self._eTab._eWeapon ~= self._selectedTab then
    classType = __eClassType_Count
  end
  local currentSelectedMainItemIndex = self._frameControlTable[mainBgIndex].currentSelectedItemIndex
  local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(selectedEquipSlotNo, classType, currentSelectedMainItemIndex, false)
  if nil == presetEquipSSW then
    return
  end
  local equipItemKey = presetEquipSSW:getEquipItemKey(currentSelectedMainItemIndex)
  local equipItemSSW = getItemEnchantStaticStatus(equipItemKey)
  if nil == equipItemSSW then
    return
  end
  local isUnlocked = ToClient_isUnlockSolareEquipPresetByIndex(selectedEquipSlotNo, currentSelectedMainItemIndex, false)
  if false == isUnlocked then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
    return
  end
  local equipItemName = equipItemSSW:getName()
  local socketItemName0 = ""
  if -1 ~= self._selectedSocketPresetNo0 then
    local presetSocketSSW = ToClient_GetSolarePresetStaticStatus(selectedEquipSlotNo, classType, self._selectedSocketPresetNo0, true)
    if presetSocketSSW == nil then
      return
    end
    local socketItemKey = presetSocketSSW:getEquipItemKey()
    if true == socketItemKey:isDefined() then
      local socketSSW = getItemEnchantStaticStatus(socketItemKey)
      socketItemName0 = socketSSW:getName()
    end
  else
    local equipiedSocketItemKey0 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, selectedEquipSlotNo, 0)
    local isEquipedSocketFind = false
    local firstPossibleSocketName = ""
    local socketItemList = ToClient_GetSolarePresetSocketListSize(selectedEquipSlotNo)
    for idx = 0, socketItemList - 1 do
      local presetSocketSSW = ToClient_GetSolarePresetStaticStatus(selectedEquipSlotNo, classType, idx, true)
      if presetSocketSSW == nil then
        return
      end
      local socketItemKey = presetSocketSSW:getEquipItemKey()
      local itemSSW = getItemEnchantStaticStatus(socketItemKey)
      if true == equipiedSocketItemKey0:isDefined() and socketItemKey:getItemKey() == equipiedSocketItemKey0:getItemKey() and nil ~= itemSSW then
        socketItemName0 = itemSSW:getName()
        self._selectedSocketPresetNo0 = idx
        isEquipedSocketFind = true
      end
      if 0 == idx and nil ~= itemSSW then
        firstPossibleSocketName = itemSSW:getName()
      end
    end
    if false == isEquipedSocketFind then
      self._selectedSocketPresetNo0 = 0
      socketItemName0 = firstPossibleSocketName
    end
  end
  local socketItemName1 = ""
  if -1 ~= self._selectedSocketPresetNo1 then
    local presetSocketSSW = ToClient_GetSolarePresetStaticStatus(selectedEquipSlotNo, classType, self._selectedSocketPresetNo1, true)
    if presetSocketSSW == nil then
      return
    end
    local socketItemKey = presetSocketSSW:getEquipItemKey()
    if true == socketItemKey:isDefined() then
      local socketSSW = getItemEnchantStaticStatus(socketItemKey)
      socketItemName1 = socketSSW:getName()
    end
  else
    local equipiedSocketItemKey1 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, selectedEquipSlotNo, 1)
    local socketItemList = ToClient_GetSolarePresetSocketListSize(selectedEquipSlotNo)
    local isEquipedSocketFind = false
    local firstPossibleSocketName = ""
    for idx = 0, socketItemList - 1 do
      local presetSocketSSW = ToClient_GetSolarePresetStaticStatus(selectedEquipSlotNo, classType, idx, true)
      if presetSocketSSW == nil then
        return
      end
      local socketItemKey = presetSocketSSW:getEquipItemKey()
      local itemSSW = getItemEnchantStaticStatus(socketItemKey)
      if true == equipiedSocketItemKey1:isDefined() and socketItemKey:getItemKey() == equipiedSocketItemKey1:getItemKey() and nil ~= itemSSW then
        socketItemName1 = itemSSW:getName()
        self._selectedSocketPresetNo1 = idx
        isEquipedSocketFind = true
      end
      if 0 == idx and nil ~= itemSSW then
        firstPossibleSocketName = itemSSW:getName()
      end
    end
    if false == isEquipedSocketFind then
      self._selectedSocketPresetNo1 = 0
      socketItemName1 = firstPossibleSocketName
    end
  end
  isUnlocked = ToClient_isUnlockSolareEquipPresetByIndex(selectedEquipSlotNo, self._selectedSocketPresetNo0, true)
  if false == isUnlocked then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
    return
  end
  isUnlocked = ToClient_isUnlockSolareEquipPresetByIndex(selectedEquipSlotNo, self._selectedSocketPresetNo1, true)
  if false == isUnlocked then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
    return
  end
  local function equipConfirm()
    ToClient_RequestSaveSolareEquipPreset(selectedEquipSlotNo, currentSelectedMainItemIndex, self._selectedSocketPresetNo0, self._selectedSocketPresetNo1, self._selectedEquipPresetNo)
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM_EUIP", "equip", equipItemName)
  if "" ~= socketItemName0 then
    messageBoxMemo = messageBoxMemo .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM_EUIP", "equip", socketItemName0)
  end
  if "" ~= socketItemName1 then
    messageBoxMemo = messageBoxMemo .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM_EUIP", "equip", socketItemName1)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_CRYSTAL_SET_CONFIRM"),
    content = messageBoxMemo,
    functionYes = equipConfirm,
    functionNo = MessageBox_Empty_function,
    exitButton = false,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventLRUp_Solare_EquipPreset_EquipConfirm(isRightClick, mainBgIndex, mainSlotIndex, equipPresetIndex, equipSlotNo)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if mainBgIndex < 0 then
    return
  end
  if equipPresetIndex < 0 then
    return
  end
  local self = PaGlobal_Solare_EquipPreset
  if nil == self._frameControlTable[mainBgIndex] then
    return
  end
  if nil == self._frameControlTable[mainBgIndex].equipSlotTable[mainSlotIndex] then
    return
  end
  self._frameControlTable[mainBgIndex].currentSelectedItemIndex = equipPresetIndex
  if false == isRightClick then
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterSolrareStart"))
    return
  end
  local presetEquipSSW = ToClient_GetSolarePresetStaticStatus(equipSlotNo, classType, equipPresetIndex, false)
  if nil == presetEquipSSW then
    return
  end
  local needCoin = presetEquipSSW:getSolareCoin()
  local isBasicItem = needCoin <= 0
  if false == isBasicItem then
    local isUnlocked = ToClient_isUnlockSolareEquipPresetByIndex(equipSlotNo, equipPresetIndex, false)
    if false == isUnlocked then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
      return
    end
  end
  local equipItemName = self._frameControlTable[mainBgIndex].equipSlotTable[mainSlotIndex].itemName
  local classType = selfPlayer:getClassType()
  if self._eTab._eWeapon ~= self._selectedTab then
    classType = __eClassType_Count
  end
  local socketItemName0 = ""
  local socketItemName1 = ""
  local socketPresetNo0 = -1
  local socketPresetNo1 = -1
  if __eEquipSlotNoBelt == equipSlotNo or __eEquipSlotNoNecklace == equipSlotNo or __eEquipSlotNoEaring1 == equipSlotNo or __eEquipSlotNoEaring2 == equipSlotNo or __eEquipSlotNoRing1 == equipSlotNo or __eEquipSlotNoRing2 == equipSlotNo or __eEquipSlotNoAlchemyStone == equipSlotNo then
  else
    socketPresetNo0 = 0
    socketPresetNo1 = 0
    local socketItemList = ToClient_GetSolarePresetSocketListSize(equipSlotNo)
    if socketItemList > 0 then
      local equipiedSocketItemKey0 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 0)
      local equipiedSocketItemKey1 = ToClient_GetSolarePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 1)
      for idx = 0, socketItemList - 1 do
        local presetSocketSSW = ToClient_GetSolarePresetStaticStatus(equipSlotNo, classType, idx, true)
        if presetSocketSSW == nil then
          return
        end
        local socketItemKey = presetSocketSSW:getEquipItemKey()
        if true == equipiedSocketItemKey0:isDefined() and socketItemKey:getItemKey() == equipiedSocketItemKey0:getItemKey() then
          local itemSSW = getItemEnchantStaticStatus(socketItemKey)
          socketItemName0 = itemSSW:getName()
          socketPresetNo0 = idx
        end
        if true == equipiedSocketItemKey1:isDefined() and socketItemKey:getItemKey() == equipiedSocketItemKey1:getItemKey() then
          local itemSSW = getItemEnchantStaticStatus(socketItemKey)
          socketItemName1 = itemSSW:getName()
          socketPresetNo1 = idx
        end
      end
      local presetSocketSSW = ToClient_GetSolarePresetStaticStatus(equipSlotNo, classType, 0, true)
      if presetSocketSSW == nil then
        return
      end
      if socketItemName0 == "" then
        local socketItemKey = presetSocketSSW:getEquipItemKey()
        local itemSSW = getItemEnchantStaticStatus(socketItemKey)
        socketItemName0 = itemSSW:getName()
      end
      if socketItemName1 == "" then
        local socketItemKey = presetSocketSSW:getEquipItemKey()
        local itemSSW = getItemEnchantStaticStatus(socketItemKey)
        socketItemName1 = itemSSW:getName()
      end
    end
  end
  local function equipConfirm()
    ToClient_RequestSaveSolareEquipPreset(equipSlotNo, equipPresetIndex, socketPresetNo0, socketPresetNo1, self._selectedEquipPresetNo)
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM_EUIP", "equip", equipItemName)
  if "" ~= socketItemName0 then
    messageBoxMemo = messageBoxMemo .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM_EUIP", "equip", socketItemName0)
  end
  if "" ~= socketItemName1 then
    messageBoxMemo = messageBoxMemo .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM_EUIP", "equip", socketItemName1)
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_CONFIRM"),
    content = messageBoxMemo,
    functionYes = equipConfirm,
    functionNo = MessageBox_Empty_function,
    exitButton = false,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
