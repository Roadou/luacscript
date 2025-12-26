PaGlobal_AbyssOne_EquipPreset = {
  _ui = {
    panel_BlackBg = nil,
    stc_MainBg = nil,
    btn_Close = nil,
    stc_InvenBg = nil,
    stc_TabBg = nil,
    stc_ConsoleTab_LT = nil,
    stc_ConsoleTab_RT = nil,
    rdo_Tab_Equip = nil,
    rdo_Tab_Bag = nil,
    stc_Selected_Line = nil,
    txt_Coin = nil,
    frame_MainSlotBg = nil,
    frame_Content = nil,
    frame_BlackBg = nil,
    frame_ShadowTop = nil,
    frame_Shadow = nil,
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
    list2_SocketEquipBg = nil,
    btn_SocketEquipBg_Confirm = nil,
    btn_SocketEquipBg_Cancel = nil,
    stc_AwakenWeapon_SlotBG = nil,
    stc_AwakenWeapon_Slot = nil,
    panel_BuyPreset = nil,
    stc_BuyPresetBlackBg = nil,
    stc_BuyPresetSlotBg = nil,
    txt_BuyPresetItemName = nil,
    txt_BuyPresetNeedCoin = nil,
    btn_BuyPresetConfirm = nil,
    btn_BuyPresetCancel = nil
  },
  _eTab = {
    _eEquip = 0,
    _eBag = 1,
    _eCount = 2
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
    createMaidActorOnly = false,
    createExpiration = false,
    createExpirationBG = false,
    createClassEquipBG = false,
    createEnduranceIcon = false,
    createItemLock = false,
    createBlack = true,
    createEnchant = true,
    createBadBG = false
  },
  _padSnapSlotInfo = {
    _type = nil,
    _slotIndex = nil,
    _tooltipFunc = nil
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
  _maxFrameCount = 14,
  _maxSlotCount = 8,
  _isPad = false,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_AbyssOne_EquipPreset_Init")
function FromClient_AbyssOne_EquipPreset_Init()
  PaGlobal_AbyssOne_EquipPreset:initialize()
end
function PaGlobal_AbyssOne_EquipPreset:initialize()
  if self._initialize == true or Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._isPad = _ContentsGroup_UsePadSnapping
  self._isConsole = _ContentsGroup_RenewUI
  if Panel_AbyssOne_EquipPresetBlockBg ~= nil then
    self._ui.panel_BlackBg = Panel_AbyssOne_EquipPresetBlockBg
  end
  self._ui.panel_BlackBg:SetIgnore(false)
  self._ui.stc_MainBg = UI.getChildControl(Panel_AbyssOne_EquipPresetList, "Static_MainBG")
  local top = UI.getChildControl(self._ui.stc_MainBg, "StaticText_Title")
  self._ui.btn_Close = UI.getChildControl(top, "Button_Win_Close_PCUI")
  self._ui.stc_InvenBg = UI.getChildControl(self._ui.stc_MainBg, "Static_Group_Inven")
  self._ui.stc_TabBg = UI.getChildControl(self._ui.stc_InvenBg, "Static_TabBG")
  self._ui.stc_ConsoleTab_LT = UI.getChildControl(self._ui.stc_TabBg, "StaticText_LT_ConcoleUI")
  self._ui.stc_ConsoleTab_RT = UI.getChildControl(self._ui.stc_TabBg, "StaticText_RT_ConcoleUI")
  self._ui.rdo_Tab_Equip = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Equip")
  self._ui.rdo_Tab_Bag = UI.getChildControl(self._ui.stc_TabBg, "RadioButton_Bag")
  self._ui.stc_Selected_Line = UI.getChildControl(self._ui.stc_TabBg, "Static_SelectBar")
  local coinBg = UI.getChildControl(self._ui.stc_InvenBg, "Static_CoinBG")
  self._ui.txt_Coin = UI.getChildControl(coinBg, "Static_Text_Money")
  self._ui.frame_MainSlotBg = UI.getChildControl(self._ui.stc_InvenBg, "Frame_MainSlotBG")
  self._ui.frame_Content = UI.getChildControl(self._ui.frame_MainSlotBg, "Frame_1_Content")
  self._ui.frame_BlackBg = UI.getChildControl(self._ui.frame_MainSlotBg, "Static_ClearBG")
  self._ui.frame_ShadowTop = UI.getChildControl(self._ui.frame_MainSlotBg, "Static_FrameShadow_Top")
  self._ui.frame_Shadow = UI.getChildControl(self._ui.frame_MainSlotBg, "Static_FrameShadow")
  self._ui.stc_SocketEquipBg = UI.getChildControl(Panel_AbyssOne_EquipPresetList, "Static_Crystal_BG")
  local socketTitleBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "StaticText_Title_BG_Crystal")
  self._ui.btn_SocketEquipBg_Close = UI.getChildControl(socketTitleBg, "Button_Close")
  self._ui.list2_SocketEquipBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "List2_1")
  local list2Content = UI.getChildControl(self._ui.list2_SocketEquipBg, "List2_1_Content")
  local list2RadioButton = UI.getChildControl(list2Content, "RadioButton_1")
  local list2ItemSlotBg = UI.getChildControl(list2RadioButton, "Static_ItemSlotBG")
  local list2ItemSlot = UI.getChildControl(list2ItemSlotBg, "Static_ItemIcon")
  local list2ItemSlotTable = {}
  SlotItem.new(list2ItemSlotTable, "AbyssOneEquipPreset_SocketSlot", 0, list2ItemSlot, self._slotConfig)
  list2ItemSlotTable:createChildInInstance()
  list2ItemSlotTable.icon:SetPosY(2)
  self._ui.btn_SocketEquipBg_Confirm = UI.getChildControl(self._ui.stc_SocketEquipBg, "Button_Confirm2")
  self._ui.btn_SocketEquipBg_Confirm:SetShow(not self._isPad)
  self._ui.btn_SocketEquipBg_Cancel = UI.getChildControl(self._ui.stc_SocketEquipBg, "Button_Cancel2")
  self._ui.btn_SocketEquipBg_Cancel:SetShow(not self._isPad)
  if self._isPad == true then
    self._ui.stc_SocketEquipBg:SetSize(self._ui.stc_SocketEquipBg:GetSizeX(), self._ui.stc_SocketEquipBg:GetSizeY() - 60)
    local crystalListBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "Static_BG")
    crystalListBg:SetSize(crystalListBg:GetSizeX(), crystalListBg:GetSizeY() - 60)
    self._ui.stc_SocketEquipBg:ComputePosAllChild()
  end
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
  Panel_AbyssOne_EquipPresetList:SetSize(Panel_AbyssOne_EquipPresetList:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetSizeY() + diffTextY)
  self._ui.stc_MainBg:SetSize(Panel_AbyssOne_EquipPresetList:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetSizeY())
  Panel_AbyssOne_EquipPresetList:ComputePosAllChild()
  self._ui.btn_Confirm = UI.getChildControl(self._ui.stc_MainBg, "Button_Confirm")
  self._ui.btn_Cancel = UI.getChildControl(self._ui.stc_MainBg, "Button_Cancel")
  self._ui.btn_MyAblityStatOpen:SetShow(false)
  self._ui.stc_EquipCircle = UI.getChildControl(self._ui.stc_EquipBg, "Static_MainCircle_1")
  self._ui.stc_AwakenWeapon_SlotBG = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_AwakenWeapon_BG")
  self._ui.stc_AwakenWeapon_Slot = UI.getChildControl(self._ui.stc_EquipCircle, "Static_Slot_AwakenWeapon")
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
    tempTable.slot:createChildInInstance()
    tempTable.slot.icon:SetPosY(2)
    tempTable.slot.icon:SetPosX(2)
    self._ui.stc_EquipTable[slotNo] = tempTable
  end
  if Panel_Popup_AbyssOne_BuyEquipment_All ~= nil then
    self._ui.panel_BuyPreset = Panel_Popup_AbyssOne_BuyEquipment_All
    self._ui.stc_BuyPresetBlackBg = UI.getChildControl(self._ui.panel_BuyPreset, "Static_BlackBG")
    local mainBg = UI.getChildControl(self._ui.panel_BuyPreset, "Static_Main_Bg")
    local iconBg = UI.getChildControl(mainBg, "Static_IconBG")
    self._ui.stc_BuyPresetSlotBg = UI.getChildControl(iconBg, "Static_Icon")
    local buyPopupItemSlot = {}
    SlotItem.new(buyPopupItemSlot, "AbyssOneEquipPreset_BuyPopup", 0, self._ui.stc_BuyPresetSlotBg, self._slotConfig)
    buyPopupItemSlot:createChildInInstance()
    self._ui.txt_BuyPresetItemName = UI.getChildControl(iconBg, "StaticText_ItemName")
    self._ui.txt_BuyPresetItemName:SetTextMode(__eTextMode_AutoWrap)
    local coinBg = UI.getChildControl(mainBg, "Static_CoinBG")
    self._ui.txt_BuyPresetNeedCoin = UI.getChildControl(coinBg, "StaticText_Coin")
    self._ui.btn_BuyPresetConfirm = UI.getChildControl(mainBg, "Button_Ok")
    self._ui.btn_BuyPresetConfirm:SetShow(not self._isPad)
    self._ui.btn_BuyPresetCancel = UI.getChildControl(mainBg, "Button_Cancel")
    self._ui.btn_BuyPresetCancel:SetShow(not self._isPad)
    local keyGuideArea = UI.getChildControl(self._ui.panel_BuyPreset, "Static_KeyGuide_Console")
    keyGuideArea:SetShow(self._isPad)
    if self._isPad == true then
      self._ui.panel_BuyPreset:SetSize(self._ui.panel_BuyPreset:GetSizeX(), self._ui.panel_BuyPreset:GetSizeY() - 60)
      mainBg:SetSize(self._ui.panel_BuyPreset:GetSizeX(), self._ui.panel_BuyPreset:GetSizeY())
      self._ui.panel_BuyPreset:ComputePosAllChild()
      local keyGuide_1 = UI.getChildControl(keyGuideArea, "StaticText_Confirm_Console")
      local keyGuide_2 = UI.getChildControl(keyGuideArea, "StaticText_Close_Console")
      keyGuide_1:SetShow(false)
      keyGuide_2:SetShow(false)
      local keyGuideList = Array.new()
      keyGuideList:push_back(keyGuide_1)
      keyGuideList:push_back(keyGuide_2)
      for key, control in pairs(keyGuideList) do
        if control ~= nil then
          control:SetShow(true)
        end
      end
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, keyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
      self._ui.panel_BuyPreset:ignorePadSnapMoveToOtherPanel()
    end
  end
  Panel_AbyssOne_EquipPresetList:ComputePosAllChild()
  PaGlobal_AbyssOne_EquipPreset:registEventHandler()
  PaGlobal_AbyssOne_EquipPreset:swichPlatform()
  PaGlobal_AbyssOne_EquipPreset:makeTemplete()
  PaGlobal_AbyssOne_EquipPreset._initialize = true
end
function PaGlobal_AbyssOne_EquipPreset:registEventHandler()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  registerEvent("FromClient_AbyssOneEquipPresetOpen", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Open")
  registerEvent("onScreenResize", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_OnScreenResize")
  registerEvent("FromClient_AbyssOneSettingEquipPresetAck", "FromClient_AbyssOneSettingEquipPreset_Update")
  registerEvent("FromClient_AbyssOnePresetBuyingComplete", "FromClient_AbyssOne_EquipPreset_UnlockUpdate")
  registerEvent("FromClient_AbyssOneNeedSettingEquipPresetAck", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_GetShowWithNak")
  self._ui.frame_Content:addInputEvent("Mouse_UpScroll", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_ScrollEvent(true)")
  self._ui.frame_Content:addInputEvent("Mouse_DownScroll", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_ScrollEvent(false)")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Close()")
  self._ui.btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Close()")
  self._ui.rdo_Tab_Equip:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(" .. self._eTab._eEquip .. ")")
  self._ui.rdo_Tab_Bag:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(" .. self._eTab._eBag .. ")")
  self._ui.btn_SocketEquipBg_Confirm:addInputEvent("Mouse_LUp", "HandleEventUp_AbyssOne_EquipPreset_SocketChangeConfrim()")
  self._ui.btn_SocketEquipBg_Close:addInputEvent("Mouse_LUp", "PaGlobal_AbyssOne_EquipPreset:socketChangeShow(false, -1)")
  self._ui.btn_SocketEquipBg_Cancel:addInputEvent("Mouse_LUp", "PaGlobal_AbyssOne_EquipPreset:socketChangeShow(false, -1)")
  self._ui.list2_SocketEquipBg:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_AbyssOneEquip_UpdateSocketList")
  self._ui.list2_SocketEquipBg:createChildContent(__ePAUIList2ElementManagerType_List)
  if Panel_Equipment_Crystal_Tooltip ~= nil then
    if self._isPad == true then
      self._ui.btn_SocketTooltip:SetEnable(false)
      self._ui.btn_SocketTooltip:SetMonoTone(true)
    else
      self._ui.btn_SocketTooltip:SetEnable(true)
      self._ui.btn_SocketTooltip:SetMonoTone(false)
      self._ui.btn_SocketTooltip:addInputEvent("Mouse_On", "PAGlobalFunc_CrystalTooltip_AbyssOneCrystalToolTipOpen(true)")
      self._ui.btn_SocketTooltip:addInputEvent("Mouse_Out", "PAGlobalFunc_CrystalTooltip_AbyssOneCrystalToolTipOpen(false)")
      self._ui.btn_SocketTooltip:addInputEvent("Mouse_LUp", "PAGlobalFunc_CrystalTooltip_ToggleDetail()")
    end
  end
  if Panel_Popup_AbyssOne_BuyEquipment_All ~= nil then
    self._ui.btn_BuyPresetCancel:addInputEvent("Mouse_LUp", "PaGlobal_AbyssOne_EquipPreset:buyPresetPopupOpen(false)")
  end
  if self._isPad == true then
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventPadUp_AbyssOne_EquipPreset_ChangeTab(false)")
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventPadUp_AbyssOne_EquipPreset_ChangeTab(true)")
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_RSClick, "HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(" .. self._eTab._eBag .. ")")
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventPadUp_AbyssOne_EquipPreset_SocketChangeConfirm()")
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventPadUp_AbyssOne_EquipPreset_ShowToggleCrystalTooltip()")
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadUp_AbyssOne_EquipPreset_ShowDetailCrystalTooltip()")
    Panel_AbyssOne_EquipPresetList:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventPadUp_AbyssOne_EquipPreset_ToggleTooltip()")
  end
end
function PaGlobal_AbyssOne_EquipPreset:swichPlatform()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._ui.stc_ConsoleTab_LT:SetShow(self._isPad)
  self._ui.stc_ConsoleTab_RT:SetShow(self._isPad)
  self._ui.btn_Close:SetShow(self._isPad == false)
  self._ui.btn_SocketEquipBg_Close:SetShow(self._isPad == false)
  local mainEquipPresetKeyGuideBg = UI.getChildControl(Panel_AbyssOne_EquipPresetList, "Static_KeyGuide_ConsoleUI_Main")
  mainEquipPresetKeyGuideBg:SetShow(self._isPad)
  local crystalEquipKeyGuideBg = UI.getChildControl(self._ui.stc_SocketEquipBg, "Static_KeyGuide_ConsoleUI_Crystal")
  crystalEquipKeyGuideBg:SetShow(self._isPad)
  if self._isPad == true then
    local keyGuide_1 = UI.getChildControl(mainEquipPresetKeyGuideBg, "StaticText_LTY_ConsoleUI")
    local keyGuide_2 = UI.getChildControl(mainEquipPresetKeyGuideBg, "StaticText_X_ConsoleUI")
    local keyGuide_3 = UI.getChildControl(mainEquipPresetKeyGuideBg, "StaticText_A_ConsoleUI")
    local keyGuide_4 = UI.getChildControl(mainEquipPresetKeyGuideBg, "StaticText_B_ConsoleUI")
    keyGuide_1:SetShow(false)
    keyGuide_2:SetShow(false)
    keyGuide_3:SetShow(false)
    keyGuide_4:SetShow(false)
    local keyGuideList = Array.new()
    keyGuideList:push_back(keyGuide_1)
    keyGuideList:push_back(keyGuide_2)
    keyGuideList:push_back(keyGuide_3)
    keyGuideList:push_back(keyGuide_4)
    for key, control in pairs(keyGuideList) do
      if control ~= nil then
        control:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, mainEquipPresetKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
    local keyGuide_1 = UI.getChildControl(crystalEquipKeyGuideBg, "StaticText_Y_ConsoleUI")
    local keyGuide_2 = UI.getChildControl(crystalEquipKeyGuideBg, "StaticText_A_ConsoleUI")
    local keyGuide_3 = UI.getChildControl(crystalEquipKeyGuideBg, "StaticText_B_ConsoleUI")
    keyGuide_1:SetShow(false)
    keyGuide_2:SetShow(false)
    keyGuide_3:SetShow(false)
    local keyGuideList = Array.new()
    keyGuideList:push_back(keyGuide_1)
    keyGuideList:push_back(keyGuide_2)
    keyGuideList:push_back(keyGuide_3)
    for key, control in pairs(keyGuideList) do
      if control ~= nil then
        control:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, crystalEquipKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  end
end
function PaGlobal_AbyssOne_EquipPreset:makeTemplete()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
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
    local clonedBg = UI.cloneControl(slotTemp, self._ui.frame_Content, "Static_AbyssOnePreset_Group" .. tostring(idx))
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
    SlotItem.new(tempMini0, "created_AbyssOneEquipedSocketMini_0", idx, tempTable.stc_EquipSocket0, self._slotConfig)
    tempMini0:createChildInInstance()
    tempMini0.icon:SetSize(miniSocketSizeX, miniSocketSizeY)
    tempMini0.border:SetSize(miniSocketSizeX, miniSocketSizeY)
    local tempMini1 = {}
    SlotItem.new(tempMini1, "created_AbyssOneEquipedSocketMini_1", idx, tempTable.stc_EquipSocket1, self._slotConfig)
    tempMini1:createChildInInstance()
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
      SlotItem.new(tempEquipSlotTable.slot, "created_AbyssOneEquipPresetSlot" .. tostring(jj), jj, clonedEquipSlot, self._slotConfig)
      tempEquipSlotTable.slot:createChildInInstance()
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
function PaGlobal_AbyssOne_EquipPreset:prepareOpen()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if false == _ContentsGroup_AbyssOne then
    return
  end
  self._ui.rdo_Tab_Bag:SetShow(true)
  local isClassType = getSelfPlayer():getClassType()
  if __eClassType_ShyWaman == isClassType then
    self._equipSlotString[__eEquipSlotNoAwakenWeapon] = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON")
    self._equipTypeIcon[__eEquipSlotNoAwakenWeapon] = "Combine_Etc_Solare_War_Equip_Icon_Category_14"
    self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl, 283, 48, 329, 94)
    self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:setRenderTexture(self._ui.stc_EquipTable[__eEquipSlotNoAwakenWeapon].bgControl:getBaseTexture())
  end
  PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_OnScreenResize()
  local frameVScroll = self._ui.frame_MainSlotBg:GetVScroll()
  if frameVScroll ~= nil then
    frameVScroll:SetControlPos(0)
    self._ui.frame_MainSlotBg:UpdateContentPos()
  end
  self:socketChangeShow(false, -1)
  self:setTabButton()
  self:update()
  HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(self._selectedTab)
  self:open()
end
function PaGlobal_AbyssOne_EquipPreset:setTabButton()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._ui.rdo_Tab_Equip:SetCheck(false)
  self._ui.rdo_Tab_Bag:SetCheck(false)
  local selectTabButtonControl
  if self._eTab._eEquip == self._selectedTab then
    selectTabButtonControl = self._ui.rdo_Tab_Equip
  elseif self._eTab._eBag == self._selectedTab then
    selectTabButtonControl = self._ui.rdo_Tab_Bag
  end
  if selectTabButtonControl ~= nil then
    selectTabButtonControl:SetCheck(true)
    self._ui.stc_Selected_Line:SetPosX(selectTabButtonControl:GetPosX() - 25)
  end
end
function PaGlobal_AbyssOne_EquipPreset:changeEquipTypeIcon(control, type, isShy)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
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
function PaGlobal_AbyssOne_EquipPreset:resetAllSlot()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
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
    if self._isPad == true then
      self._frameControlTable[idx].btn_socketChange:removeInputEvent("Mouse_On")
    end
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
  local frameVScroll = self._ui.frame_MainSlotBg:GetVScroll()
  if frameVScroll ~= nil then
    frameVScroll:SetControlPos(0)
    self._ui.frame_MainSlotBg:UpdateContentPos()
  end
  PaGlobal_AbyssOne_EquipPreset:clearCachedIndex()
end
function PaGlobal_AbyssOne_EquipPreset:update()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self:updateEquipControl()
  self:updatePresetControl()
  if self._selectedTab == self._eTab._eBag then
    PaGlobal_AbyssOne_Inventory_All_Open()
  end
end
function PaGlobal_AbyssOne_EquipPreset:moneyUpdate()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  local myCoin = Defines.s64_const.s64_0
  local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, getMoneySlotNo())
  if _ContentsGroup_AbyssOneCoin == true then
    priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Abyss)
  end
  if nil ~= priceItemWrapper then
    myCoin = priceItemWrapper:get():getCount_s64()
  end
  self._ui.txt_Coin:SetText(makeDotMoney(myCoin))
  local textSizeX = self._ui.txt_Coin:GetTextSizeX()
  local coinSizeX = self._ui.txt_Coin:GetSizeX()
  self._ui.txt_Coin:SetSpanSize(coinSizeX + textSizeX, self._ui.txt_Coin:GetSpanSize().y)
  self._ui.txt_Coin:ComputePos()
end
function PaGlobal_AbyssOne_EquipPreset:updatePresetControl()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_AbyssOne_EquipPreset:moneyUpdate()
  if self._eTab._eBag == self._selectedTab then
    return
  end
  local classType = selfPlayer:getClassType()
  local startLoopIndex = 0
  local endLoopIndex = 13
  local isShy = __eClassType_ShyWaman == classType
  local slotCount = 1
  local mainBgSize = 0
  for idx = startLoopIndex, endLoopIndex do
    if idx > 2 then
      classType = __eClassType_Count
    end
    local equipSlotNo = self._eEquipSlot[idx]
    if nil ~= self._frameControlTable[slotCount] then
      local equipString = self._equipSlotString[equipSlotNo]
      local UIFrameTable = self._frameControlTable[slotCount]
      local currentEquipString = PaGlobal_AbyssOne_EquipPreset:getCurrentEquipItemName(equipSlotNo)
      UIFrameTable.txt_EquipSlot:SetText(currentEquipString)
      UI.setLimitTextAndAddTooltip(UIFrameTable.txt_EquipSlot, UIFrameTable.txt_EquipSlot:GetText(), "")
      PaGlobal_AbyssOne_EquipPreset:changeEquipTypeIcon(UIFrameTable.stc_EquipSlotIcon, equipSlotNo, isShy)
      if equipSlotNo == __eEquipSlotNoAwakenWeapon and isShy == true then
        equipString = PAGetString(Defines.StringSheet_GAME, "LUA_SHAI_AWAKEN_WEAPON_TYPE")
      end
      UIFrameTable.txt_Title:SetText(equipString)
      local equipedSocketItemKey0 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 0)
      local equipedSocket0SSW = getItemEnchantStaticStatus(equipedSocketItemKey0)
      if nil ~= equipedSocket0SSW then
        UIFrameTable.txt_EquipSocket0:SetText(PaGlobalFunc_Util_GetItemGradeColorName(equipedSocket0SSW:get()._key))
        UI.setLimitTextAndAddTooltip(UIFrameTable.txt_EquipSocket0, UIFrameTable.txt_EquipSocket0:GetText(), "")
        UIFrameTable.stc_EquipSocket0:SetShow(true)
        local miniSocket0 = {}
        SlotItem.reInclude(miniSocket0, "created_AbyssOneEquipedSocketMini_0", idx, UIFrameTable.stc_EquipSocket0, self._slotConfig)
        miniSocket0:setItemByStaticStatus(equipedSocket0SSW)
      end
      local equipedSocketItemKey1 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 1)
      local equipedSocket1SSW = getItemEnchantStaticStatus(equipedSocketItemKey1)
      if nil ~= equipedSocket1SSW then
        UIFrameTable.txt_EquipSocket1:SetText(PaGlobalFunc_Util_GetItemGradeColorName(equipedSocket1SSW:get()._key))
        UI.setLimitTextAndAddTooltip(UIFrameTable.txt_EquipSocket1, UIFrameTable.txt_EquipSocket1:GetText(), "")
        UIFrameTable.stc_EquipSocket1:SetShow(true)
        local miniSocket1 = {}
        SlotItem.reInclude(miniSocket1, "created_AbyssOneEquipedSocketMini_1", idx, UIFrameTable.stc_EquipSocket1, self._slotConfig)
        miniSocket1:setItemByStaticStatus(equipedSocket1SSW)
      end
      local availableSocketSize = ToClient_GetAbyssOnePresetSocketListSize(equipSlotNo)
      local canEquipSocket = self._eTab._eOther ~= self._selectedTab and availableSocketSize > 0
      UIFrameTable.btn_socketChange:SetShow(canEquipSocket)
      UIFrameTable.stc_SocketBg:SetShow(canEquipSocket)
      if true == canEquipSocket then
        UIFrameTable.btn_socketChange:addInputEvent("Mouse_LUp", "PaGlobal_AbyssOne_EquipPreset:socketChangeBtnClick(" .. slotCount .. " ," .. equipSlotNo .. ")")
        if self._isPad == true then
          UIFrameTable.btn_socketChange:addInputEvent("Mouse_On", "PaGlobalFunc_AbyssOne_EquipPreset_ClearPadSnapInfo()")
        end
      else
        local sizeY = self._slotMainBgSizeY - UIFrameTable.stc_SocketBg:GetSizeY()
        UIFrameTable.clonedMainBg:SetSize(UIFrameTable.clonedMainBg:GetSizeX(), sizeY)
        UIFrameTable.clonedMainBg:SetSpanSize(UIFrameTable.clonedMainBg:GetSpanSize().x, mainBgSize + 10)
        UIFrameTable.clonedEquipBg:SetSpanSize(UIFrameTable.clonedEquipBg:GetSpanSize().x, UIFrameTable.stc_TitleBg:GetSizeY() + 5)
      end
      local equipItemCount = ToClient_GetAbyssOnePresetEquipListSize(equipSlotNo, classType)
      for mainSlotIndex = 1, equipItemCount do
        local presetLevel = mainSlotIndex - 1
        local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlotNo, classType, presetLevel, false)
        if presetEquipSSW == nil then
          return
        end
        local needCoin_s64 = presetEquipSSW:getAbyssCoin()
        local isBasicItem = needCoin_s64 <= toInt64(0, 0)
        local isUnlocked = ToClient_isUnlockAbyssOneEquipPresetByIndex(equipSlotNo, presetLevel, false)
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
            local slotControl = UIFrameTable.equipSlotTable[mainSlotIndex].control:SetShow(true)
            slot:setItemByStaticStatus(itemSSW)
            slot._item = equipItemKey
            Panel_Tooltip_Item_SetPosition(equipSlotNo + mainSlotIndex, slot, "AbyssOnePreset")
            UIFrameTable.equipSlotTable[mainSlotIndex].itemName = itemSSW:getName()
            slot.icon:SetShow(true)
            slot.icon:removeInputEvent("Mouse_RUp")
            slot.icon:removeInputEvent("Mouse_LUp")
            slot.icon:removeInputEvent("Mouse_On")
            if self._isPad == false then
              slot.icon:removeInputEvent("Mouse_Out")
            end
            local lockItemControl = UIFrameTable.lockSlotTable[mainSlotIndex]
            lockItemControl:SetShow(not isUnlocked and not (needCoin_s64 <= toInt64(0, 0)))
            if true == isUnlocked then
              if false == isEquipedItem then
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLRUp_AbyssOne_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                if self._isPad == false then
                  slot.icon:addInputEvent("Mouse_RUp", "HandleEventLRUp_AbyssOne_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                end
              end
            else
              if true == isBasicItem then
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLRUp_AbyssOne_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                if self._isPad == false then
                  slot.icon:addInputEvent("Mouse_RUp", "HandleEventLRUp_AbyssOne_EquipPreset_EquipConfirm(true," .. slotCount .. "," .. mainSlotIndex .. "," .. presetLevel .. "," .. equipSlotNo .. ")")
                end
              else
                slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. presetLevel .. ",false)")
                lockItemControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. presetLevel .. ",false)")
              end
              lockItemControl:addInputEvent("Mouse_On", "HandleEventOnOut_AbyssOne_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",true)")
              lockItemControl:addInputEvent("Mouse_Out", "HandleEventOnOut_AbyssOne_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",false)")
            end
            slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_AbyssOne_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",true)")
            slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AbyssOne_EquipPreset_Tooltip(" .. equipSlotNo .. "," .. mainSlotIndex .. ",false)")
          end
        end
      end
      local skillType = ToClient_GetSelfPlayerSkillType()
      if equipSlotNo == __eEquipSlotNoAwakenWeapon and skillType ~= __eSkillTypeParam_Awaken then
        UIFrameTable.clonedMainBg:SetShow(false)
      else
        mainBgSize = mainBgSize + UIFrameTable.clonedMainBg:GetSizeY() + 10
        UIFrameTable.clonedMainBg:SetShow(true)
        slotCount = slotCount + 1
      end
    end
  end
  self._ui.frame_Content:SetSize(self._ui.frame_Content:GetSizeX(), mainBgSize + (slotCount + 45) + self._ui.frame_ShadowTop:GetSizeY())
  local frameVScroll = self._ui.frame_MainSlotBg:GetVScroll()
  if frameVScroll ~= nil then
    frameVScroll:SetInterval(self._ui.frame_Content:GetSizeY() / 100 * 1.5)
  end
  self._ui.frame_MainSlotBg:UpdateContentPos()
end
function PaGlobal_AbyssOne_EquipPreset:updateEquipControl()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local isEquipItemChange = false
  for idx = 1, #self._eEquipSlot do
    local equipSlotNo = self._eEquipSlot[idx - 1]
    local currentEquipItem = ToClient_GetAbyssOnePresetItem(self._selectedEquipPresetNo, equipSlotNo)
    if nil ~= currentEquipItem and nil ~= self._ui.stc_EquipTable[equipSlotNo] then
      local itemEnchantKey = currentEquipItem:getKey()
      local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
      if nil ~= itemSSW then
        local equipControlTable = self._ui.stc_EquipTable[equipSlotNo]
        SlotItem.reInclude(equipControlTable.slot, "created_EquipItemSlot_" .. tostring(idx), idx, equipControlTable.control, self._slotConfig)
        equipControlTable.slot:setItemByStaticStatus(itemSSW)
        equipControlTable.slot._item = itemEnchantKey:getItemKey()
        Panel_Tooltip_Item_SetPosition(self._selectedEquipPresetNo + equipSlotNo, equipControlTable.slot, "AbyssOneEquipment")
        equipControlTable.slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_AbyssOne_EquipPreset_EquipTooltip(" .. tostring(self._selectedEquipPresetNo) .. "," .. tonumber(equipSlotNo) .. ",true)")
        equipControlTable.slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AbyssOne_EquipPreset_EquipTooltip(" .. tostring(self._selectedEquipPresetNo) .. "," .. tonumber(equipSlotNo) .. ",false)")
        equipControlTable.currentEquipItemKey = itemSSW:get()._key
        if true == Panel_AbyssOne_EquipPresetList:GetShow() and equipControlTable.currentEquipItemKey ~= itemSSW:get()._key then
          isEquipItemChange = true
        end
        equipControlTable.currentEquipItemName = PaGlobalFunc_Util_GetItemGradeColorName(itemSSW:get()._key)
        equipControlTable.bgControl:SetShow(false)
      end
    end
  end
  local classType = selfPlayer:getClassType()
  local offenceValue = ToClient_GetAbyssOnePresetOffenceStat()
  local defenceValue = ToClient_GetAbyssOnePresetDefenceStat()
  local awakenValue = ToClient_GetAbyssOnePresetAwakenOffenceStat()
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
  local skillType = ToClient_GetSelfPlayerSkillType()
  local awakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  if nil == awakenWeaponContentsOpen then
    awakenWeaponContentsOpen = false
  end
  if awakenWeaponContentsOpen == true and skillType == __eSkillTypeParam_Awaken then
    self._ui.txt_Attack:SetSpanSize(self._ui.txt_Attack:GetSpanSize().x, 15)
    self._ui.txt_AttackValue:SetSpanSize(self._ui.txt_AttackValue:GetSpanSize().x, 15)
    self._ui.txt_Defence:SetSpanSize(self._ui.txt_Defence:GetSpanSize().x, 95)
    self._ui.txt_DefenceValue:SetSpanSize(self._ui.txt_DefenceValue:GetSpanSize().x, 95)
    self._ui.stc_AwakenWeapon_Slot:SetShow(true)
    local awakenEquipItem = ToClient_GetAbyssOnePresetItem(self._selectedEquipPresetNo, __eEquipSlotNoAwakenWeapon)
    if awakenEquipItem:getKey():isDefined() == true then
      self._ui.stc_AwakenWeapon_SlotBG:SetShow(false)
    else
      self._ui.stc_AwakenWeapon_SlotBG:SetShow(true)
    end
  else
    self._ui.txt_AwakenValue:SetShow(false)
    self._ui.txt_AwakenTitle:SetShow(false)
    self._ui.txt_ShyTitle:SetShow(false)
    self._ui.txt_ShyValue:SetShow(false)
    self._ui.stc_AwakenWeapon_SlotBG:SetShow(false)
    self._ui.stc_AwakenWeapon_Slot:SetShow(false)
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
    if self._awakenValue ~= awakenValue then
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
function PaGlobal_AbyssOne_EquipPreset:socketChangeBtnClick(mainBgIndex, equipSlot)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
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
  if self._eTab._eEquip ~= self._selectedTab then
    classType = __eClassType_Count
  end
  local currentEquipItem = ToClient_GetAbyssOnePresetItem(self._selectedEquipPresetNo, equipSlot)
  if false == currentEquipItem:getKey():isDefined() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SOLARE_EQUIPMENT_SET_MSG"))
    return
  end
  self._currentPushedSocketItemKey0 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, equipSlot, 0)
  self._currentPushedSocketItemKey1 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, equipSlot, 1)
  if -1 == self._frameControlTable[mainBgIndex].currentSelectedItemIndex then
    local equipItemCount = ToClient_GetAbyssOnePresetEquipListSize(equipSlot, classType)
    for idx = 0, equipItemCount - 1 do
      local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlot, classType, idx, false)
      if presetEquipSSW ~= presetEquipSSW then
        local equipItemKey = presetEquipSSW:getEquipItemKey()
        if currentEquipItem:getKey():getItemKey() == equipItemKey:getItemKey() then
          self._frameControlTable[mainBgIndex].currentSelectedItemIndex = idx
        end
      end
    end
  end
  self._ui.list2_SocketEquipBg:getElementManager():clearKey()
  self._unlockedSocketTable = Array.new()
  local socketItemList = ToClient_GetAbyssOnePresetSocketListSize(equipSlot)
  if socketItemList > 0 then
    for socketIndex = 0, socketItemList - 1 do
      local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlot, classType, socketIndex, true)
      if presetEquipSSW ~= nil then
        local socketItemKey = presetEquipSSW:getEquipItemKey()
        local needCoin_s64 = presetEquipSSW:getAbyssCoin()
        local isUnlocked = ToClient_isUnlockAbyssOneEquipPresetByIndex(equipSlot, socketIndex, true) or needCoin_s64 <= toInt64(0, 0)
        if true == isUnlocked then
          local tempTable = {
            _itemKey = socketItemKey:getItemKey(),
            _isUnlock = isUnlocked,
            _isFree = needCoin_s64 <= toInt64(0, 0)
          }
          self._unlockedSocketTable:push_back(tempTable)
        end
        for avaliableSocketCount = 1, 2 do
          self._ui.list2_SocketEquipBg:getElementManager():pushKey(toInt64(socketIndex, socketItemKey:getItemKey()))
        end
      end
    end
    PaGlobal_AbyssOne_EquipPreset:socketChangeShow(true, mainBgIndex, equipSlot)
  end
end
function PaGlobal_AbyssOne_EquipPreset:socketChangeShow(isShow, mainBgIndex, equipSlot)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if nil == equipSlot then
    equipSlot = -1
  end
  self._ui.frame_BlackBg:SetShow(isShow)
  self._ui.stc_SocketEquipBg:SetShow(isShow)
  if false == isShow then
    PaGlobal_AbyssOne_EquipPreset:clearCachedIndex()
  else
    self._currentOpenEquipNoBySocketChange64 = toInt64(mainBgIndex, equipSlot)
    if self._isPad == true then
      local elementManager = self._ui.list2_SocketEquipBg:getElementManager()
      if elementManager ~= nil then
        local contentsCount = Int64toInt32(elementManager:getSize())
        for index = 0, contentsCount - 1 do
          local contentKey = self._ui.list2_SocketEquipBg:getKeyByIndex(index)
          local content = self._ui.list2_SocketEquipBg:GetContentByKey(contentKey)
          if content ~= nil then
            local list2RadioButton = UI.getChildControl(content, "RadioButton_1")
            if list2RadioButton ~= nil and list2RadioButton:IsIgnore() == false then
              ToClient_padSnapChangeToTarget(list2RadioButton)
              break
            end
          end
        end
      end
    end
  end
end
function PaGlobal_AbyssOne_EquipPreset:buyPresetPopupOpen(isShow, classType, equipSlotNo, presetLevel, isSocket)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if false == isShow then
    self._ui.panel_BuyPreset:SetShow(false)
    return
  end
  local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlotNo, classType, presetLevel, isSocket)
  if nil == presetEquipSSW then
    return
  end
  local equipItemKey = presetEquipSSW:getEquipItemKey(presetLevel)
  local itemSSW = getItemEnchantStaticStatus(equipItemKey)
  if nil == itemSSW then
    return
  end
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, "AbyssOneEquipPreset_BuyPopup", equipSlotNo, self._ui.stc_BuyPresetSlotBg, self._slotConfig)
  itemSlot:setItemByStaticStatus(itemSSW)
  local myCoin_s64 = toInt64(0, 0)
  local priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, getMoneySlotNo())
  if _ContentsGroup_AbyssOneCoin == true then
    priceItemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eMoneyInventory, __eInventoryMoneyType_Abyss)
  end
  if priceItemWrapper ~= nil then
    myCoin_s64 = priceItemWrapper:get():getCount_s64()
  end
  local needCoin_s64 = presetEquipSSW:getAbyssCoin()
  local isBuyAble = myCoin_s64 >= needCoin_s64
  self._ui.txt_BuyPresetItemName:SetText(itemSSW:getName())
  self._ui.txt_BuyPresetNeedCoin:SetText(makeDotMoney(needCoin_s64))
  self._ui.btn_BuyPresetConfirm:SetIgnore(not isBuyAble, not isBuyAble)
  self._ui.btn_BuyPresetConfirm:SetMonoTone(not isBuyAble, not isBuyAble)
  if true == isBuyAble then
    self._ui.txt_BuyPresetNeedCoin:SetFontColor(Defines.Color.C_FFE0E0E0)
    if self._isPad == true then
      self._ui.panel_BuyPreset:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_AbyssOne_EquipPreset:buyPresetPopupRequest(" .. tostring(equipSlotNo) .. ", " .. tostring(presetLevel) .. "," .. tostring(isSocket) .. ")")
    else
      self._ui.btn_BuyPresetConfirm:addInputEvent("Mouse_LUp", "PaGlobal_AbyssOne_EquipPreset:buyPresetPopupRequest(" .. tostring(equipSlotNo) .. ", " .. tostring(presetLevel) .. "," .. tostring(isSocket) .. ")")
    end
  else
    self._ui.txt_BuyPresetNeedCoin:SetFontColor(Defines.Color.C_FFEE5555)
    if self._isPad == false then
      self._ui.btn_BuyPresetConfirm:removeInputEvent("Mouse_LUp")
    end
  end
  self._ui.stc_BuyPresetBlackBg:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.stc_BuyPresetBlackBg:ComputePos()
  self._ui.panel_BuyPreset:ComputePos()
  self._ui.panel_BuyPreset:SetShow(true)
end
function PaGlobal_AbyssOne_EquipPreset:buyPresetPopupRequest(equipSlotNo, presetLevel, isSocket)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if nil == self._ui.panel_BuyPreset or false == self._ui.panel_BuyPreset:GetShow() then
    return
  end
  local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlotNo, classType, presetLevel, isSocket)
  if nil == presetEquipSSW then
    return
  end
  local equipItemKey = presetEquipSSW:getEquipItemKey(presetLevel)
  local itemSSW = getItemEnchantStaticStatus(equipItemKey)
  if nil == itemSSW then
    return
  end
  ToClient_RequestAbyssOnePresetUnlock(equipSlotNo, presetLevel, isSocket)
end
function PaGlobal_AbyssOne_EquipPreset:clearCachedIndex()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._currentOpenEquipNoBySocketChange64 = -1
  self._currentPushedSocketItemKey0 = -1
  self._currentPushedSocketItemKey1 = -1
  self._selectedSocketPresetNo0 = -1
  self._selectedSocketPresetNo1 = -1
end
function PaGlobal_AbyssOne_EquipPreset:getCurrentEquipItemName(equipSlot)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
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
function PaGlobal_AbyssOne_EquipPreset:open()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._ui.panel_BlackBg:SetShow(true)
  Panel_AbyssOne_EquipPresetList:SetShow(true)
end
function PaGlobal_AbyssOne_EquipPreset:prepareClose()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  if Panel_Widget_Tooltip_Renew ~= nil and PaGlobalFunc_TooltipInfo_Close ~= nil then
    PaGlobalFunc_TooltipInfo_Close()
  end
  PAGlobalFunc_CrystalTooltip_AbyssOneCrystalToolTipOpen(false)
  PaGlobalFunc_AbyssOne_EquipPreset_ClearPadSnapInfo()
  if true == self._ui.panel_BuyPreset:GetShow() then
    PaGlobal_AbyssOne_EquipPreset:buyPresetPopupOpen(false)
    return
  end
  if true == self._ui.stc_SocketEquipBg:GetShow() then
    PaGlobal_AbyssOne_EquipPreset:socketChangeShow(false)
    return
  end
  PaGlobal_AbyssOne_Inventory_All_Close()
  PaGlobal_AbyssOne_EquipPreset:close()
end
function PaGlobal_AbyssOne_EquipPreset:close()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  self._ui.panel_BlackBg:SetShow(false)
  Panel_AbyssOne_EquipPresetList:SetShow(false)
end
function PaGlobal_AbyssOne_EquipPreset:clearTabPadSnap()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if self._isPad == false then
    return
  end
  if self._selectedTab ~= self._eTab._eBag then
    for key, value in pairs(self._frameControlTable) do
      if value ~= nil and value.equipSlotTable ~= nil then
        for key2, value2 in pairs(value.equipSlotTable) do
          if value2 ~= nil and value2.control ~= nil then
            ToClient_padSnapChangeToTarget(value2.control)
            return
          end
        end
      end
    end
  else
    PaGlobal_AbyssOne_Inventory_All_ClearPadSnap()
  end
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_PrePareOpen()
  ToClient_RequestLoadAbyssOneEquipPresetList()
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Open()
  PaGlobal_AbyssOne_EquipPreset:prepareOpen()
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Close()
  PaGlobal_AbyssOne_EquipPreset:prepareClose()
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_GetShow()
  if Panel_AbyssOne_EquipPresetList == nil then
    return false
  end
  return Panel_AbyssOne_EquipPresetList:GetShow()
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_GetShowWithNak()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_ABYSSONE_EQUIP_ALERT_DESC"),
    functionYes = PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_Open,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_ScrollEvent(isUp)
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil then
    return
  end
  local frameVScroll = self._ui.frame_MainSlotBg:GetVScroll()
  if frameVScroll == nil then
    return
  end
  local frameVScrollBtn = UI.getChildControl(frameVScroll, "Frame_1_VerticalScroll_CtrlButton")
  if frameVScrollBtn == nil then
    return
  end
  if frameVScrollBtn:GetShow() == false then
    self._ui.frame_ShadowTop:SetShow(false)
    self._ui.frame_Shadow:SetShow(false)
    return
  end
  local maxSize = frameVScroll:GetSizeY() - frameVScrollBtn:GetSizeY()
  if isUp == true then
    self._frameScrollCtrlPos = self._frameScrollCtrlPos - frameVScroll:GetInterval()
    if self._frameScrollCtrlPos < 0 then
      self._frameScrollCtrlPos = 0
    end
  else
    self._frameScrollCtrlPos = self._frameScrollCtrlPos + frameVScroll:GetInterval()
    local diffMax = maxSize - self._frameScrollCtrlPos
    diffMax = math.abs(diffMax)
    if maxSize < self._frameScrollCtrlPos or diffMax < 1 then
      self._frameScrollCtrlPos = maxSize
    end
  end
  if self._frameScrollCtrlPos < 1 then
    self._ui.frame_ShadowTop:SetShow(false)
    self._ui.frame_Shadow:SetShow(true)
  elseif self._frameScrollCtrlPos > 0 and maxSize > self._frameScrollCtrlPos then
    self._ui.frame_ShadowTop:SetShow(true)
    self._ui.frame_Shadow:SetShow(true)
  elseif self._frameScrollCtrlPos == maxSize then
    self._ui.frame_ShadowTop:SetShow(true)
    self._ui.frame_Shadow:SetShow(false)
  end
end
function HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(idx)
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil then
    return
  end
  local frameVScroll = self._ui.frame_MainSlotBg:GetVScroll()
  if frameVScroll == nil then
    return
  end
  PAGlobalFunc_CrystalTooltip_AbyssOneCrystalToolTipOpen(false)
  Panel_Tooltip_Item_hideTooltip()
  if Panel_Widget_Tooltip_Renew ~= nil and PaGlobalFunc_TooltipInfo_Close ~= nil then
    PaGlobalFunc_TooltipInfo_Close()
  end
  self._selectedTab = idx
  self:resetAllSlot()
  self:socketChangeShow(false)
  self:setTabButton()
  self:updatePresetControl()
  PaGlobal_AbyssOne_Inventory_All_Open()
  if self._selectedTab ~= self._eTab._eBag then
    PaGlobal_AbyssOne_Inventory_All_Reset()
    PaGlobal_AbyssOne_Inventory_All_SetScrolShow(false)
    local contentsCount = 0
    local slotSize = 0
    local frameMainSlotBGSize = self._ui.frame_MainSlotBg:GetSizeY()
    for idx = 1, #self._frameControlTable do
      if self._frameControlTable[idx].clonedMainBg:GetShow() == true then
        contentsCount = contentsCount + 1
        slotSize = self._frameControlTable[idx].clonedMainBg:GetSizeY()
      end
    end
    local configSlotCount = math.floor(frameMainSlotBGSize / slotSize)
    if contentsCount < configSlotCount then
      configSlotCount = contentsCount
    end
    UIScroll.SetButtonSize(frameVScroll, configSlotCount, contentsCount)
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
  if self._isPad == true then
    self:clearTabPadSnap()
  end
end
function HandleEventPadUp_AbyssOne_EquipPreset_ChangeTab(isRight)
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil or isRight == nil then
    return
  end
  if isRight == true then
    if self._selectedTab == self._eTab._eCount - 1 then
      return
    else
      HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(self._selectedTab + 1)
    end
  elseif self._selectedTab == 0 then
    return
  else
    HandleEventLUp_PaGlobal_AbyssOne_EquipPreset_TabSelect(self._selectedTab - 1)
  end
end
function HandleEventPadUp_AbyssOne_EquipPreset_SocketChangeConfirm()
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil then
    return
  end
  if self._ui.stc_SocketEquipBg:GetShow() == false then
    return
  end
  HandleEventUp_AbyssOne_EquipPreset_SocketChangeConfrim()
end
function HandleEventPadUp_AbyssOne_EquipPreset_ShowToggleCrystalTooltip()
  if PaGlobalFunc_CrystalTooltip_ShowToggle ~= nil then
    PaGlobalFunc_CrystalTooltip_ShowToggle()
  end
end
function HandleEventPadUp_AbyssOne_EquipPreset_ShowDetailCrystalTooltip()
  if PaGlobalFunc_CrystalTooltip_ShowDetail ~= nil then
    PaGlobalFunc_CrystalTooltip_ShowDetail()
  end
end
function HandleEventOnOut_AbyssOne_EquipPreset_SocketTooltip(equipSlotNo, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    if Panel_Widget_Tooltip_Renew ~= nil and PaGlobalFunc_TooltipInfo_Close ~= nil then
      PaGlobalFunc_TooltipInfo_Close()
    end
    if PaGlobal_AbyssOne_EquipPreset._isPad == true then
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = nil
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = nil
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = nil
    end
    return
  end
  if PaGlobal_AbyssOne_EquipPreset._isPad == true then
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = "AbyssOneSocket"
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = equipSlotNo
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = Panel_Tooltip_Item_Show_GeneralStatic
    return
  end
  Panel_Tooltip_Item_Show_GeneralStatic(equipSlotNo, "AbyssOneSocket", isShow, false, Panel_AbyssOne_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetPosY())
end
function HandleEventOnOut_AbyssOne_EquipPreset_Tooltip(equipSlotNo, presetIndex, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    if Panel_Widget_Tooltip_Renew ~= nil and PaGlobalFunc_TooltipInfo_Close ~= nil then
      PaGlobalFunc_TooltipInfo_Close()
    end
    if PaGlobal_AbyssOne_EquipPreset._isPad == true then
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = nil
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = nil
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = nil
    end
    return
  end
  local slotIndex = toInt64(equipSlotNo, presetIndex)
  if PaGlobal_AbyssOne_EquipPreset._isPad == true then
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = "AbyssOnePreset"
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = slotIndex
    if PaGlobal_AbyssOne_EquipPreset._isConsole == true then
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = PaGlobalFunc_TooltipInfo_AbyssOnePresetOpen
    else
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = Panel_Tooltip_Item_Show_GeneralStatic
    end
    return
  end
  Panel_Tooltip_Item_Show_GeneralStatic(slotIndex, "AbyssOnePreset", isShow, false, Panel_AbyssOne_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetPosY())
end
function HandleEventOnOut_AbyssOne_EquipPreset_EquipTooltip(presetNo, equipSlotNo, isShow)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    if Panel_Widget_Tooltip_Renew ~= nil and PaGlobalFunc_TooltipInfo_Close ~= nil then
      PaGlobalFunc_TooltipInfo_Close()
    end
    if PaGlobal_AbyssOne_EquipPreset._isPad == true then
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = nil
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = nil
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = nil
    end
    return
  end
  local slotIndex = toInt64(presetNo, equipSlotNo)
  if PaGlobal_AbyssOne_EquipPreset._isPad == true then
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = "AbyssOneEquipment"
    PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = slotIndex
    if PaGlobal_AbyssOne_EquipPreset._isConsole == true then
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = PaGlobalFunc_TooltipInfo_Open
    else
      PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = Panel_Tooltip_Item_Show_GeneralNormal
    end
    return
  end
  Panel_Tooltip_Item_Show_GeneralNormal(slotIndex, "AbyssOneEquipment", isShow, slotIndex, Panel_AbyssOne_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetPosY())
end
function PaGlobalFunc_AbyssOne_EquipPreset_ClearPadSnapInfo()
  if PaGlobal_AbyssOne_EquipPreset == nil then
    return
  end
  if PaGlobal_AbyssOne_EquipPreset._isPad == false then
    return
  end
  PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._type = nil
  PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._slotIndex = nil
  PaGlobal_AbyssOne_EquipPreset._padSnapSlotInfo._tooltipFunc = nil
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_UnlockCondition(classType, equipSlotNo, presetLevel, isSocket)
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  PaGlobal_AbyssOne_EquipPreset:buyPresetPopupOpen(true, classType, equipSlotNo, presetLevel, isSocket)
end
function PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_OnScreenResize()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  Panel_AbyssOne_EquipPresetList:ComputePos()
  PaGlobal_AbyssOne_EquipPreset._ui.panel_BlackBg:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_AbyssOne_EquipPreset._ui.panel_BlackBg:ComputePos()
end
function FromClient_AbyssOneSettingEquipPreset_Update()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  if Panel_AbyssOne_EquipPresetList:GetShow() == false then
    return
  end
  PaGlobal_AbyssOne_EquipPreset:socketChangeShow(false)
  PaGlobal_AbyssOne_EquipPreset:update()
  audioPostEvent_SystemUi(30, 14)
  _AudioPostEvent_SystemUiForXBOX(30, 14)
end
function FromClient_AbyssOne_EquipPreset_UnlockUpdate()
  if Panel_AbyssOne_EquipPresetList == nil then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_INGAMECASHSHOP_BUYORGIFT_BUYCOMPLETE"))
  PaGlobal_AbyssOne_EquipPreset:buyPresetPopupOpen(false)
  PaGlobal_AbyssOne_EquipPreset:updatePresetControl()
  local mainBgIndex = highFromUint64(PaGlobal_AbyssOne_EquipPreset._currentOpenEquipNoBySocketChange64)
  local equipSlotNo = lowFromUint64(PaGlobal_AbyssOne_EquipPreset._currentOpenEquipNoBySocketChange64)
  PaGlobal_AbyssOne_EquipPreset:socketChangeBtnClick(mainBgIndex, equipSlotNo)
end
function HandleEventPadUp_AbyssOne_EquipPreset_ToggleTooltip()
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil then
    return
  end
  if self._isPad == false then
    return
  end
  if self._selectedTab == self._eTab._eBag then
    if self._padSnapSlotInfo == nil or self._padSnapSlotInfo._slotIndex == nil or self._padSnapSlotInfo._tooltipFunc == nil then
      return
    end
    local whereType = CppEnums.ItemWhereType.eInstanceInventory
    local itemWrapper = getInventoryItemByType(whereType, self._padSnapSlotInfo._slotIndex)
    if itemWrapper == nil then
      return
    end
    if PaGlobal_AbyssOne_EquipPreset._isConsole == true then
      self._padSnapSlotInfo._tooltipFunc(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      self._padSnapSlotInfo._tooltipFunc(itemWrapper, Panel_AbyssOne_EquipPresetList, false, true)
    end
    return
  end
  if Panel_Tooltup_Item_isShow() == true then
    Panel_Tooltip_Item_hideTooltip()
  elseif Panel_Widget_Tooltip_Renew ~= nil and PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    if self._padSnapSlotInfo == nil or self._padSnapSlotInfo._type == nil or self._padSnapSlotInfo._slotIndex == nil or self._padSnapSlotInfo._tooltipFunc == nil then
      return
    end
    if PaGlobal_AbyssOne_EquipPreset._isConsole == false then
      self._padSnapSlotInfo._tooltipFunc(self._padSnapSlotInfo._slotIndex, self._padSnapSlotInfo._type, true, self._padSnapSlotInfo._slotIndex, Panel_AbyssOne_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetPosY())
      return
    end
    local highValue64 = highFromUint64(self._padSnapSlotInfo._slotIndex)
    local lowValue64 = lowFromUint64(self._padSnapSlotInfo._slotIndex)
    if self._padSnapSlotInfo._type == "AbyssOnePreset" then
      local equipSlotNo32 = highValue64
      local presetIndex = lowValue64 - 1
      local slotNo = highValue64 + lowValue64
      local classType = __eClassType_Count
      if equipSlotNo32 == __eEquipSlotNoRightHand or equipSlotNo32 == __eEquipSlotNoLeftHand or equipSlotNo32 == __eEquipSlotNoAwakenWeapon then
        classType = getSelfPlayer():getClassType()
      end
      local itemSSW = ToClient_GetAbyssOnePresetItemWrapper(equipSlotNo32, classType, presetIndex)
      if nil == itemSSW then
        return
      end
      self._padSnapSlotInfo._tooltipFunc(Defines.TooltipDataType.ItemWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX(), "AbyssOnePreset", self._padSnapSlotInfo._slotIndex)
    elseif self._padSnapSlotInfo._type == "AbyssOneEquipment" then
      local itemSSW = ToClient_GetAbyssOneEquippedItemWrapper(highValue64, lowValue64)
      if nil == itemSSW then
        return
      end
      self._padSnapSlotInfo._tooltipFunc(Defines.TooltipDataType.ItemWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0, getScreenSizeX(), "AbyssOneEquipment")
    else
      self._padSnapSlotInfo._tooltipFunc(self._padSnapSlotInfo._slotIndex, self._padSnapSlotInfo._type, true, self._padSnapSlotInfo._slotIndex, Panel_AbyssOne_EquipPresetList:GetPosX() - Panel_Tooltip_Item:GetSizeX(), Panel_AbyssOne_EquipPresetList:GetPosY())
    end
  end
end
function FromClient_AbyssOneEquip_UpdateSocketList(content, key)
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil then
    return
  end
  local str = tostring(content:GetID())
  local length = string.len(str)
  local contentIndex = string.sub(str, length, length)
  local socketSlotIndex = contentIndex % 2
  local index = highFromUint64(key)
  local itemKey = lowFromUint64(key)
  local list2RadioButton = UI.getChildControl(content, "RadioButton_1")
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemSSW == nil then
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
  SlotItem.reInclude(slotTable, "AbyssOneEquipPreset_SocketSlot", index, list2ItemSlot, self._slotConfig)
  slotTable:setItemByStaticStatus(itemSSW)
  slotTable._item = ItemEnchantKey(itemKey, 0)
  Panel_Tooltip_Item_SetPosition(index, slotTable, "AbyssOneSocket")
  slotTable.icon:addInputEvent("Mouse_On", "HandleEventOnOut_AbyssOne_EquipPreset_SocketTooltip(" .. tostring(index) .. ",true)")
  slotTable.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_AbyssOne_EquipPreset_SocketTooltip(" .. tostring(index) .. ",false)")
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
    if self._eTab._eEquip ~= self._selectedTab then
      classType = __eClassType_Count
    end
    slotTable.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. index .. ",true)")
    list2RadioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_PaGlobal_AbyssOne_EquipPreset_UnlockCondition(" .. classType .. "," .. equipSlotNo .. "," .. index .. ",true)")
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
      slotTable.icon:addInputEvent("Mouse_LUp", "HandleEventUp_AbyssOne_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
      list2RadioButton:addInputEvent("Mouse_LUp", "HandleEventUp_AbyssOne_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
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
      slotTable.icon:addInputEvent("Mouse_LUp", "HandleEventUp_AbyssOne_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
      list2RadioButton:addInputEvent("Mouse_LUp", "HandleEventUp_AbyssOne_EquipPreset_SocketSelect(" .. socketSlotIndex .. "," .. index .. ")")
    end
  end
end
function HandleEventUp_AbyssOne_EquipPreset_SocketSelect(socketIndex, socketPresetIndex)
  local self = PaGlobal_AbyssOne_EquipPreset
  if self == nil then
    return
  end
  if socketIndex == 0 then
    self._selectedSocketPresetNo0 = socketPresetIndex
  elseif socketIndex == 1 then
    self._selectedSocketPresetNo1 = socketPresetIndex
  end
  self._ui.list2_SocketEquipBg:requestUpdateVisible()
end
function HandleEventUp_AbyssOne_EquipPreset_SocketChangeConfrim()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local self = PaGlobal_AbyssOne_EquipPreset
  if self._currentOpenEquipNoBySocketChange64 == -1 then
    return
  end
  local self = PaGlobal_AbyssOne_EquipPreset
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
  if self._eTab._eEquip ~= self._selectedTab then
    classType = __eClassType_Count
  end
  local currentSelectedMainItemIndex = self._frameControlTable[mainBgIndex].currentSelectedItemIndex
  local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(selectedEquipSlotNo, classType, currentSelectedMainItemIndex, false)
  if nil == presetEquipSSW then
    return
  end
  local equipItemKey = presetEquipSSW:getEquipItemKey(currentSelectedMainItemIndex)
  local equipItemSSW = getItemEnchantStaticStatus(equipItemKey)
  if nil == equipItemSSW then
    return
  end
  local isUnlocked = ToClient_isUnlockAbyssOneEquipPresetByIndex(selectedEquipSlotNo, currentSelectedMainItemIndex, false)
  if false == isUnlocked then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
    return
  end
  local equipItemName = equipItemSSW:getName()
  local socketItemName0 = ""
  if -1 ~= self._selectedSocketPresetNo0 then
    local presetSocketSSW = ToClient_GetAbyssOnePresetStaticStatus(selectedEquipSlotNo, classType, self._selectedSocketPresetNo0, true)
    if presetSocketSSW == nil then
      return
    end
    local socketItemKey = presetSocketSSW:getEquipItemKey()
    if true == socketItemKey:isDefined() then
      local socketSSW = getItemEnchantStaticStatus(socketItemKey)
      socketItemName0 = socketSSW:getName()
    end
  else
    local equipiedSocketItemKey0 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, selectedEquipSlotNo, 0)
    local isEquipedSocketFind = false
    local firstPossibleSocketName = ""
    local socketItemList = ToClient_GetAbyssOnePresetSocketListSize(selectedEquipSlotNo)
    for idx = 0, socketItemList - 1 do
      local presetSocketSSW = ToClient_GetAbyssOnePresetStaticStatus(selectedEquipSlotNo, classType, idx, true)
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
    local presetSocketSSW = ToClient_GetAbyssOnePresetStaticStatus(selectedEquipSlotNo, classType, self._selectedSocketPresetNo1, true)
    if presetSocketSSW == nil then
      return
    end
    local socketItemKey = presetSocketSSW:getEquipItemKey()
    if true == socketItemKey:isDefined() then
      local socketSSW = getItemEnchantStaticStatus(socketItemKey)
      socketItemName1 = socketSSW:getName()
    end
  else
    local equipiedSocketItemKey1 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, selectedEquipSlotNo, 1)
    local socketItemList = ToClient_GetAbyssOnePresetSocketListSize(selectedEquipSlotNo)
    local isEquipedSocketFind = false
    local firstPossibleSocketName = ""
    for idx = 0, socketItemList - 1 do
      local presetSocketSSW = ToClient_GetAbyssOnePresetStaticStatus(selectedEquipSlotNo, classType, idx, true)
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
  isUnlocked = ToClient_isUnlockAbyssOneEquipPresetByIndex(selectedEquipSlotNo, self._selectedSocketPresetNo0, true)
  if false == isUnlocked then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
    return
  end
  isUnlocked = ToClient_isUnlockAbyssOneEquipPresetByIndex(selectedEquipSlotNo, self._selectedSocketPresetNo1, true)
  if false == isUnlocked then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
    return
  end
  ToClient_RequestSaveAbyssOneEquipPreset(selectedEquipSlotNo, currentSelectedMainItemIndex, self._selectedSocketPresetNo0, self._selectedSocketPresetNo1, self._selectedEquipPresetNo)
end
function HandleEventLRUp_AbyssOne_EquipPreset_EquipConfirm(isRightClick, mainBgIndex, mainSlotIndex, equipPresetIndex, equipSlotNo)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if mainBgIndex < 0 then
    return
  end
  if equipPresetIndex < 0 then
    return
  end
  local self = PaGlobal_AbyssOne_EquipPreset
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
  local presetEquipSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlotNo, classType, equipPresetIndex, false)
  if nil == presetEquipSSW then
    return
  end
  local needCoin_s64 = presetEquipSSW:getAbyssCoin()
  local isBasicItem = needCoin_s64 <= toInt64(0, 0)
  if isBasicItem == false then
    local isUnlocked = ToClient_isUnlockAbyssOneEquipPresetByIndex(equipSlotNo, equipPresetIndex, false)
    if false == isUnlocked then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoEquipSlotItemNotExist"))
      return
    end
  end
  local equipItemName = self._frameControlTable[mainBgIndex].equipSlotTable[mainSlotIndex].itemName
  local classType = selfPlayer:getClassType()
  if self._eTab._eEquip ~= self._selectedTab then
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
    local socketItemList = ToClient_GetAbyssOnePresetSocketListSize(equipSlotNo)
    if socketItemList > 0 then
      local equipiedSocketItemKey0 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 0)
      local equipiedSocketItemKey1 = ToClient_GetAbyssOnePresetSocketItem(self._selectedEquipPresetNo, equipSlotNo, 1)
      for idx = 0, socketItemList - 1 do
        local presetSocketSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlotNo, classType, idx, true)
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
      local presetSocketSSW = ToClient_GetAbyssOnePresetStaticStatus(equipSlotNo, classType, 0, true)
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
  ToClient_RequestSaveAbyssOneEquipPreset(equipSlotNo, equipPresetIndex, socketPresetNo0, socketPresetNo1, self._selectedEquipPresetNo)
end
