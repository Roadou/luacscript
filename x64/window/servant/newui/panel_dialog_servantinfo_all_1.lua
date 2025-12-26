function PaGlobal_ServantInfo_All:initialize()
  if nil == Panel_Dialog_ServantInfo_All or true == self.initialize then
    return
  end
  self._ui._stc_infoBg = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_InfoBg")
  self._ui._txt_Name = UI.getChildControl(self._ui._stc_infoBg, "StaticText_ServantName")
  self._ui._icon_ServantGender = UI.getChildControl(self._ui._stc_infoBg, "Static_GenderIcon")
  self._ui._icon_SwiftHorse = UI.getChildControl(self._ui._stc_infoBg, "Static_SwiftHorseIcon")
  self._ui._icon_raceHorse = UI.getChildControl(self._ui._stc_infoBg, "Static_RaceHorseIcon")
  self._ui._icon_raceHorse:SetShow(false)
  self._ui._icon_Twins = UI.getChildControl(self._ui._stc_infoBg, "Static_Twins")
  self._ui._txt_Tier = UI.getChildControl(self._ui._stc_infoBg, "StaticText_Tier")
  self._ui._txt_creatorName = UI.getChildControl(self._ui._stc_infoBg, "StaticText_MadeBy")
  self._ui._stc_ExpBg = UI.getChildControl(self._ui._stc_infoBg, "Static_ExpBg")
  self._ui._txt_ExpTitle = UI.getChildControl(self._ui._stc_ExpBg, "StaticText_ExpTitle")
  self._ui._txt_ExpValue = UI.getChildControl(self._ui._stc_ExpBg, "StaticText_ExpValue")
  self._ui._stc_ExpProgressBg = UI.getChildControl(self._ui._stc_ExpBg, "Static_ExpProgressBg")
  self._ui._prog2_Exp = UI.getChildControl(self._ui._stc_ExpBg, "Progress2_Exp")
  self._ui._prog2_Exp_Head = UI.getChildControl(self._ui._prog2_Exp, "Progress2_1_Bar_Head")
  self._ui._btn_StackLvUp = UI.getChildControl(self._ui._stc_ExpBg, "Button_Stack_LvUp")
  self._ui._txt_ServantLv = UI.getChildControl(self._ui._stc_ExpBg, "StaticText_ServantLv")
  self._ui._stc_HpBg = UI.getChildControl(self._ui._stc_infoBg, "Static_LifeBg")
  self._ui._txt_HpTitle = UI.getChildControl(self._ui._stc_HpBg, "StaticText_HpTitle")
  self._ui._txt_HpValue = UI.getChildControl(self._ui._stc_HpBg, "StaticText_HpValue")
  self._ui._stc_HpProgressBg = UI.getChildControl(self._ui._stc_HpBg, "Static_HpProgressBg")
  self._ui._prog2_Hp = UI.getChildControl(self._ui._stc_HpBg, "Progress2_Hp")
  self._ui._prog2_Hp_Head = UI.getChildControl(self._ui._prog2_Hp, "Progress2_1_Bar_Head")
  self._ui._stc_StaminaBg = UI.getChildControl(self._ui._stc_infoBg, "Static_StaminaBg")
  self._ui._stc_StaminaProgressBg = UI.getChildControl(self._ui._stc_StaminaBg, "Static_StaminaProgressBg")
  self._ui._txt_StatminaTitle = UI.getChildControl(self._ui._stc_StaminaBg, "StaticText_StaminaTitle")
  self._ui._txt_StatminaValue = UI.getChildControl(self._ui._stc_StaminaBg, "StaticText_StaminaValue")
  self._ui._prog2_Stamina = UI.getChildControl(self._ui._stc_StaminaBg, "Progress2_Stamina")
  self._ui._prog2_Stamina_Head = UI.getChildControl(self._ui._prog2_Stamina, "Progress2_1_Bar_Head")
  self._ui._stc_WeightBg = UI.getChildControl(self._ui._stc_infoBg, "Static_WeightBg")
  self._ui._txt_WeightTitle = UI.getChildControl(self._ui._stc_WeightBg, "StaticText_WeightTitle")
  self._ui._txt_WeightValue = UI.getChildControl(self._ui._stc_WeightBg, "StaticText_WeightValue")
  self._ui._stc_WeightProgressBg = UI.getChildControl(self._ui._stc_WeightBg, "Static_WeightProgressBg")
  self._ui._prog2_Weight = UI.getChildControl(self._ui._stc_WeightBg, "Progress2_Weight")
  self._ui._prog2_Weight_Head = UI.getChildControl(self._ui._prog2_Weight, "Progress2_1_Bar_Head")
  self._ui._stc_StatBg = UI.getChildControl(self._ui._stc_infoBg, "Static_StatBg")
  self._ui._txt_SpeedTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_SpeedTitle")
  self._ui._txt_SpeedValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_SpeedValue")
  self._ui._txt_CorneringTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_CorneringSpeedTitle")
  self._ui._txt_CorneringValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_AccelrationTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_AccelerationTitle")
  self._ui._txt_AccelrationValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_AccelerationValue")
  self._ui._txt_BreakTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_BreakTitle")
  self._ui._txt_BreakValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_BreakValue")
  self._ui._txt_DefenseTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_DefenseTitle")
  self._ui._txt_DefenseValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_DefenseValue")
  self._ui._txt_DeadTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_DeadCountTitle")
  self._ui._txt_DeadValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_DeadCountValue")
  self._ui._txt_MatingTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LeftMatingCountTitle")
  self._ui._txt_MatingValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LeftMatingCountValue")
  self._ui._txt_LeftLifeTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LifeTitle")
  self._ui._txt_LeftLifeValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LifeValue")
  self._ui._txt_ImprintTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_ImprintTitle")
  self._ui._txt_ImprintValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_ImprintValue")
  self._ui._stc_OnlySpeed = UI.getChildControl(self._ui._stc_StatBg, "Static_OnlySpeed")
  self._ui._stc_OnlyAcce = UI.getChildControl(self._ui._stc_StatBg, "Static_OnlyAcce")
  self._ui._stc_OnlyCorner = UI.getChildControl(self._ui._stc_StatBg, "Static_OnlyCorner")
  self._ui._stc_OnlyBrake = UI.getChildControl(self._ui._stc_StatBg, "Static_OnlyBrake")
  self._ui._txt_PremiumChangeTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_PremiumChangeTitle")
  self._ui._txt_PremiumChangeValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_PremiumChangeValue")
  self._ui._txt_servantLevelDownTitle = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LevelDownTitle")
  self._ui._txt_servantLevelDownValue = UI.getChildControl(self._ui._stc_StatBg, "StaticText_LevelDownValue")
  self._ui._stc_StatusArea = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_StatusArea")
  self._ui._txt_StatusTitle = UI.getChildControl(self._ui._stc_StatusArea, "StaticText_StatusTitle")
  self._ui._btn_Immediate = UI.getChildControl(self._ui._stc_StatusArea, "Button_Immediate")
  self._ui._btn_GetHorse = UI.getChildControl(self._ui._stc_StatusArea, "Button_GetHorse")
  self._ui._stc_SkillBg = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_SkillBg")
  self._ui._txt_SkillBgTitle = UI.getChildControl(self._ui._stc_SkillBg, "StaticText_SkillTitle")
  self._ui._list2_Skill = UI.getChildControl(self._ui._stc_SkillBg, "List2_ServantSkill")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Skill, "List2_1_Content")
  self._ui._list2_SkillSlotBg = UI.getChildControl(self._ui._list2_Content, "Static_SkillSlotBg")
  self._ui._list2_list2_ExpBg = UI.getChildControl(self._ui._list2_Content, "Static_SkillExpBg")
  self._ui._list2_Circle_Prog2_Exp = UI.getChildControl(self._ui._list2_Content, "CircularProgress_SkillExp")
  self._ui._list2_stc_SkillIcon = UI.getChildControl(self._ui._list2_Content, "Static_SkillIcon")
  self._ui._list2_txt_SkillExpPercent = UI.getChildControl(self._ui._list2_Content, "StaticText_SkillExpPercent")
  self._ui._list2_txt_SkillName = UI.getChildControl(self._ui._list2_Content, "StaticText_SkillName")
  self._ui._list2_txt_SkillCommand = UI.getChildControl(self._ui._list2_Content, "StaticText_SkillCommandValue")
  self._ui._list2_VertiScroll = UI.getChildControl(self._ui._list2_Skill, "List2_1_VerticalScroll")
  self._ui._list2_VertiScroll_Up = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_VertiScroll_Down = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_VertiScroll_Ctrl = UI.getChildControl(self._ui._list2_VertiScroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_HoriScroll = UI.getChildControl(self._ui._list2_Skill, "List2_1_HorizontalScroll")
  self._ui._list2_HoriScroll_Up = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_HoriScroll_Down = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_HoriScroll_Ctrl = UI.getChildControl(self._ui._list2_HoriScroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._btn_SkillManagerBg = UI.getChildControl(self._ui._stc_SkillBg, "Button_SkillManagementBG")
  self._ui._btn_SkillManager = UI.getChildControl(self._ui._btn_SkillManagerBg, "Button_SkillManagement")
  self._ui._stc_ConsoleHighlight = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_consoleBox")
  self._ui._stc_ConsoleKeyGuideBg = UI.getChildControl(Panel_Dialog_ServantInfo_All, "StaticText_KeyGuide_ConsoleUI")
  self._ui._stc_ConsoleKeyGuideX = UI.getChildControl(self._ui._stc_ConsoleKeyGuideBg, "StaticText_ServantEquip")
  self._ui._stc_ConsoleKeyGuideY = UI.getChildControl(self._ui._stc_ConsoleKeyGuideBg, "StaticText_SkillTooltip")
  self._OriginSkillBgSizeY = self._ui._stc_SkillBg:GetSizeY()
  self._OriginSkillBgPosY = self._ui._stc_SkillBg:GetSpanSize().y
  self._OriginList2SizeY = self._ui._list2_Skill:GetSizeY()
  self._OriginPanelSizeY = Panel_Dialog_ServantInfo_All:GetSizeY()
  self._OriginList2PosY = self._ui._list2_Skill:GetPosY()
  self._ui._stc_ConsoleHighlight:SetShow(_ContentsGroup_UsePadSnapping)
  self._skillNameBaseSpanSizeX = self._ui._list2_txt_SkillName:GetSpanSize().x
  self._speedValueBasePosX = self._ui._txt_SpeedValue:GetPosX()
  self._acceValueBasePosX = self._ui._txt_AccelrationValue:GetPosX()
  self._cornerValueBasePosX = self._ui._txt_CorneringValue:GetPosX()
  self._brakeValueBasePosX = self._ui._txt_BreakValue:GetPosX()
  self._isConsole = _ContentsGroup_UsePadSnapping
  if false == self._isConsole then
    self._ui._stc_ConsoleKeyGuideBg:SetShow(false)
  end
  self._ui._btn_servantEquipInvenOpen = UI.getChildControl(Panel_Dialog_ServantInfo_All, "CheckButton_ServantEquip_PCUI")
  self._ui._stc_servantEquipInvenBg = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_ServantEquip_InStable")
  self._ui._btn_servantEquipInvenClose = UI.getChildControl(self._ui._stc_servantEquipInvenBg, "Button_Close_PCUI")
  self._ui._stc_servantEquipSlotBg = UI.getChildControl(self._ui._stc_servantEquipInvenBg, "Static_EquipSlot")
  for slotNo = 1, self._SERVANT_EQUIP_SLOT_COUNT do
    local slot = {}
    local itemSlot = SlotItem.new(slot, "ServantInfoEquipment_" .. slotNo, slotNo, self._ui._stc_servantEquipSlotBg, self._EQUIP_SLOT_CONFIG)
    if nil == itemSlot then
      return
    end
    slot:createChild()
    local slotControl = UI.getChildControl(self._ui._stc_servantEquipSlotBg, "Static_ItemSlot" .. tostring(slotNo))
    if nil == slotControl then
      return
    end
    local iconControl = UI.getChildControl(slotControl, "Static_Icon_EuipType")
    if nil == iconControl then
      return
    end
    slot.icon:SetPosX(slotControl:GetPosX())
    slot.icon:SetPosY(slotControl:GetPosY())
    slot.icon:SetShow(false)
    slot.icon:SetAutoDisableTime(1)
    slot.background = slotControl
    if self._isConsole == true then
      slot.icon:setPadSnapType(__ePadSnapType_Target)
      slot.icon:setPadSnapIndex(0)
    end
    slotControl:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    self._ui._servantEquipSlotList[slotNo] = {
      _slot = slot,
      _slotControl = slotControl,
      _iconControl = iconControl
    }
  end
  for slotNo = 1, self._SERVANT_PEARL_EQUIP_SLOT_COUNT do
    local slot = {}
    local itemSlot = SlotItem.new(slot, "ServantInfoPearlEquipment_" .. slotNo, slotNo, self._ui._stc_servantEquipSlotBg, self._EQUIP_SLOT_CONFIG)
    if nil == itemSlot then
      return
    end
    slot:createChild()
    local slotControl = UI.getChildControl(self._ui._stc_servantEquipSlotBg, "Static_PearlItemSlot" .. tostring(slotNo))
    if nil == slotControl then
      return
    end
    local iconControl = UI.getChildControl(slotControl, "Static_Icon_EuipType")
    if nil == iconControl then
      return
    end
    slot.background = slotControl
    slot.icon:SetPosX(slotControl:GetPosX())
    slot.icon:SetPosY(slotControl:GetPosY())
    slot.icon:SetShow(false)
    slot.icon:SetAutoDisableTime(1)
    if self._isConsole == true then
      slot.icon:setPadSnapType(__ePadSnapType_Target)
      slot.icon:setPadSnapIndex(0)
    end
    slotControl:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    self._ui._servantPearlEquipSlotList[slotNo] = {
      _slot = slot,
      _slotControl = slotControl,
      _iconControl = iconControl
    }
  end
  self._ui._btn_servantEquipInvenOpen:SetShow(true)
  self._ui._stc_vehicleBg = UI.getChildControl(self._ui._stc_servantEquipInvenBg, "Static_VehicleInvenBG")
  self._ui._stc_inventoryBg = UI.getChildControl(self._ui._stc_vehicleBg, "Static_Inventory_BG")
  self._ui._scroll_vertical = UI.getChildControl(self._ui._stc_inventoryBg, "List2_1_VerticalScroll")
  self._equipTooltipName = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANT_SHOWEQUIP_TOOLTIP_TITLE")
  self._equipTooltipDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANT_SHOWEQUIP_TOOLTIP_DESC")
  self._OriginEquipInvenBgSizeY = self._ui._stc_servantEquipInvenBg:GetSizeY()
  self._OriginVehicleBgSizeY = self._ui._stc_vehicleBg:GetSizeY()
  self._OriginInventorySizeX = self._ui._stc_inventoryBg:GetSizeX()
  self._OriginInventorySizeY = self._ui._stc_inventoryBg:GetSizeY()
  self._OriginInventorySlotSizeY = self._INVENTORY_CONFIG.size + self._INVENTORY_CONFIG.gap
  self:createInvenSlot()
  self._ui._stc_userInventory_inStable = UI.getChildControl(Panel_Dialog_ServantInfo_All, "Static_UserInvenOnlyServantEquip_InStable")
  self._ui._stc_userInventoryBG_inStable = UI.getChildControl(self._ui._stc_userInventory_inStable, "Static_UserInvenBG")
  self:createUserInvenSlot()
  self._userInvenType = CppEnums.ItemWhereType.eCashInventory
  local userInvenRdoBG = UI.getChildControl(self._ui._stc_userInventory_inStable, "Static_UserInven_RadioButtonBg")
  self._ui._rdo_userInventory_normal = UI.getChildControl(userInvenRdoBG, "RadioButton_NormalInventory")
  self._ui._rdo_userInventory_pearl = UI.getChildControl(userInvenRdoBG, "RadioButton_CashInventory")
  self._ui._stc_userInventory_selectBar = UI.getChildControl(userInvenRdoBG, "Static_SelectBar")
  self._ui._chk_viewInven = UI.getChildControl(self._ui._stc_servantEquipSlotBg, "CheckButton_ViewInven")
  self._ui._txt_viewInven = UI.getChildControl(self._ui._chk_viewInven, "StaticText_ViewInven")
  local stc_equipSlotText = UI.getChildControl(self._ui._stc_servantEquipSlotBg, "StaticText_EquipTitle")
  self._ui._rdo_userInventory_normal:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_UserInventory_RadioTypeTab()")
  self._ui._rdo_userInventory_pearl:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_UserInventory_RadioTypeTab()")
  self._ui._chk_viewInven:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_ViewUserInventoryToggle()")
  self._ui._txt_viewInven:SetTextMode(__eTextMode_LimitText)
  self._ui._txt_viewInven:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_SERVANTINFO_HASEQUIP"))
  self._ui._chk_viewInven:SetEnableArea(0, 0, self._ui._chk_viewInven:GetSizeX() + self._ui._txt_viewInven:GetTextSizeX() + 10, 20)
  self._ui._chk_viewInven:addInputEvent("Mouse_On", "PaGlobal_ServantInfo_All:ShowEquipInven(true)")
  self._ui._chk_viewInven:addInputEvent("Mouse_Out", "PaGlobal_ServantInfo_All:ShowEquipInven()")
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if uiManagerWrapper ~= nil then
    if uiManagerWrapper:hasLuaCacheDataList(__eServantInfoUserInventoryOpen) == false then
      uiManagerWrapper:setLuaCacheDataListBool(__eServantInfoUserInventoryOpen, true, CppEnums.VariableStorageType.eVariableStorageType_User)
    end
    self._ui._chk_viewInven:SetCheck(uiManagerWrapper:getLuaCacheDataListBool(__eServantInfoUserInventoryOpen))
  else
    self._ui._chk_viewInven:SetCheck(true)
  end
  if _ContentsGroup_SealedServantEquip == false then
    self._ui._chk_viewInven:SetShow(false)
    self._ui._chk_viewInven:SetCheck(false)
    self._ui._stc_userInventory_inStable:SetShow(false)
  end
  self._ui._rdo_userInventory_normal:SetCheck(true)
  PaGlobal_ServantInfo_All:updateSelectBar()
  PaGlobal_ServantInfo_All:validate()
  PaGlobal_ServantInfo_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantInfo_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantInfo_All or false == self._initialize then
    return
  end
  self._ui._list2_Skill:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantInfo_All_List2ServantSkill")
  self._ui._list2_Skill:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "FromClient_ServantInfo_All_OnScreenSize")
  registerEvent("FromClient_SetBeginningLevelServant", "FromClient_ServantInfo_All_SetBeginningLevelServant")
  registerEvent("FromClient_updateFood", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("FromClient_updateServantSupply", "PaGlobalFunc_ServantInfo_All_Update")
  if true == _ContentsGroup_Sailor then
    registerEvent("FromClient_EmployeeUpdateAck", "PaGlobalFunc_ServantInfo_All_Update")
    registerEvent("FromClient_EmployeeDeleteAck", "PaGlobalFunc_ServantInfo_All_Update")
  end
  registerEvent("FromClient_ServantInventoryUpdate", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("EventServantEquipItem", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("EventServantEquipmentUpdate", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("EventSelfServantUpdate", "PaGlobalFunc_ServantInfo_All_Update")
  registerEvent("FromClient_ClearGuildServantDeadCount", "FromClient_ClearGuildServantDeadCount")
  registerEvent("FromClient_LoadCompleteServantSimpleItem", "FromClient_LoadCompleteServantSimpleItem")
  registerEvent("FromClient_ServantChangeSkill", "FromClient_ServantInfo_All_SkillChangeFinish")
  registerEvent("FromClient_ForgetServantSkill", "FromClient_ServantInfo_All_ForgetServantSkill")
  registerEvent("EventServantEquipmentUpdate", "FromClient_ServantInfo_All_UpdateEquipSlot")
  registerEvent("FromClient_ServantPreviewEquipmentUpdate", "FromClient_ServantPreviewEquipmentUpdate")
  registerEvent("EventSelfServantUpdateUI", "PaGlobalFunc_ServantInfo_All_Update")
  self._ui._btn_SkillManager:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_SkillChangeOpen()")
  self._ui._btn_Immediate:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()")
  if false == isConsole then
    self._ui._list2_Skill:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    self._ui._list2_Skill:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    self._ui._list2_Skill:addInputEvent("Mouse_LUp", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    if nil ~= TooltipSimple_CommonShow and nil ~= TooltipSimple_Hide then
      self._ui._btn_servantEquipInvenOpen:addInputEvent("Mouse_On", "TooltipSimple_Show( PaGlobal_ServantInfo_All._ui._btn_servantEquipInvenOpen, PaGlobal_ServantInfo_All._equipTooltipName, PaGlobal_ServantInfo_All._equipTooltipDesc, false )")
      self._ui._btn_servantEquipInvenOpen:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    end
  else
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadPress_ServantInfo_All_ChangeInventoryTab(false)")
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadPress_ServantInfo_All_ChangeInventoryTab(true)")
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventLUp_ServantInfo_All_ToggleEquipInven()")
  end
  self._ui._stc_OnlySpeed:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeSpeed .. ")")
  self._ui._stc_OnlySpeed:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(false)")
  self._ui._stc_OnlyAcce:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeAcceleration .. ")")
  self._ui._stc_OnlyAcce:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(false)")
  self._ui._stc_OnlyCorner:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeCornering .. ")")
  self._ui._stc_OnlyCorner:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(false)")
  self._ui._stc_OnlyBrake:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeBrake .. ")")
  self._ui._stc_OnlyBrake:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(false)")
  UI.setLimitTextAndAddTooltip(self._ui._txt_PremiumChangeTitle)
  UI.setLimitTextAndAddTooltip(self._ui._txt_PremiumChangeValue)
  self._ui._btn_servantEquipInvenClose:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_CloseEquipInven()")
  self._ui._btn_servantEquipInvenOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantInfo_All_PrepareOpenEquipInven()")
  UIScroll.InputEventByControl(self._ui._stc_inventoryBg, "HandlerEventScroll_ServantInfo_All_InventoryScroll")
  UIScroll.InputEvent(self._ui._scroll_vertical, "HandlerEventScroll_ServantInfo_All_InventoryScroll")
  self._ui._btn_StackLvUp:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantInfo_All_LevelUpSealServantByExpStack()")
  self._ui._txt_ExpValue:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowStackLvUpTooltip(true)")
  self._ui._txt_ExpValue:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowStackLvUpTooltip(false)")
  Panel_Dialog_ServantInfo_All:RegisterShowEventFunc(true, "PaGlobalFunc_ServantInfo_All_ShowAni()")
  Panel_Dialog_ServantInfo_All:RegisterShowEventFunc(false, "PaGlobalFunc_ServantInfo_All_HideAni()")
  Panel_Dialog_ServantInfo_All:setMaskingChild(true)
  Panel_Dialog_ServantInfo_All:ActiveMouseEventEffect(true)
end
function PaGlobal_ServantInfo_All:prepareOpen(updateFlag)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All:open()
  FromClient_ServantInfo_All_OnScreenSize()
  PaGlobal_ServantInfo_All:update(updateFlag)
  local servantInfo
  if self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    servantInfo = guildStable_getServantByServantNo(self._currentVehicleNo)
  else
    servantInfo = stable_getServantByServantNo(self._currentVehicleNo)
    if servantInfo == nil and self._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(self._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(self._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    end
  end
  if nil == servantInfo then
    PaGlobal_ServantInfo_All:close()
    return
  end
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil ~= uiManagerWrapper then
    self._isShowInventory = uiManagerWrapper:getLuaCacheDataListBool(__eServantInfoInventoryOpen)
  end
  PaGlobal_ServantInfo_All:setKeyguide()
  if true == self._isShowInventory then
    HandleEventLUp_ServantInfo_All_OpenEquipInven()
  end
  if PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() == true then
    self._ui._chk_viewInven:SetShow(true)
    self._ui._stc_userInventory_inStable:SetShow(true)
  end
  if self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND then
    self._ui._chk_viewInven:SetShow(false)
    self._ui._stc_userInventory_inStable:SetShow(false)
  end
  PaGlobal_ServantInfo_All._userInvenStartSlot = 0
  PaGlobal_ServantInfo_All:updateUserInvenSlot()
  local ButtonIcon = UI.getChildControl(self._ui._btn_servantEquipInvenOpen, "Static_Icon")
  if self._currentNpcType == self._ENUM_NPC_TYPE._LAND or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND then
    ButtonIcon:ChangeTextureInfoNameAsync("combine/icon/combine_tab_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(ButtonIcon, 217, 73, 252, 108)
    ButtonIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    ButtonIcon:setRenderTexture(ButtonIcon:getBaseTexture())
  elseif self._currentNpcType == self._ENUM_NPC_TYPE._SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    ButtonIcon:ChangeTextureInfoNameAsync("combine/icon/combine_tab_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(ButtonIcon, 325, 73, 360, 108)
    ButtonIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    ButtonIcon:setRenderTexture(ButtonIcon:getBaseTexture())
  end
end
function PaGlobal_ServantInfo_All:open()
  if nil == Panel_Dialog_ServantInfo_All or true == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:SetShow(true)
end
function PaGlobal_ServantInfo_All:update(updateFlag)
  if nil == Panel_Dialog_ServantInfo_All or nil == self._currentNpcType then
    return
  end
  if updateFlag == nil then
    updateFlag = PaGlobal_ServantList_All._ENUM_UPDATE_FLAG._ALL
  end
  if self._currentNpcType == self._ENUM_NPC_TYPE._LAND or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND then
    PaGlobal_ServantInfo_All:updateLandVehicle()
  elseif self._currentNpcType == self._ENUM_NPC_TYPE._SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    PaGlobal_ServantInfo_All:updateSeaVehicle()
  end
  if updateFlag == PaGlobal_ServantList_All._ENUM_UPDATE_FLAG._ALL then
    PaGlobal_ServantInfo_All:updateEquipSlot()
    if 1 == self._currentSlotType then
      local temporaryWrapper = getTemporaryInformationWrapper()
      if nil == temporaryWrapper then
        return
      end
      local servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
      if nil ~= servantInfo then
        ToClient_requestServantSimpleItem(servantInfo:getServantNo())
      end
    elseif nil ~= self._currentVehicleNo and nil ~= self._currentVehicleIndexNo then
      ToClient_requestServantSimpleItem(self._currentVehicleNo)
    end
  end
end
function PaGlobal_ServantInfo_All:updateLandVehicle()
  if nil == Panel_Dialog_ServantInfo_All or -1 == self._currentSlotType then
    return
  end
  local servantInfo
  local isImprintAble = false
  local isUnSealed = false
  local isGuild = PaGlobalFunc_ServantFunction_All_GetIsGuild()
  self._statCount = 1
  if nil == self._currentVehicleIndexNo then
    self._currentSlotType = 1
  end
  if 0 == self._currentSlotType then
    if self._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(self._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(self._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  elseif 2 == self._currentSlotType then
  end
  if true == isGuild then
    if self._currentVehicleIndexNo ~= nil then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    end
    self._currentSlotType = 0
  end
  if nil == servantInfo then
    PaGlobal_ServantInfo_All:close()
    return
  end
  PaGlobal_ServantInfo_All:setLvUpRenewalSetting(servantInfo:getServantNo())
  PaGlobal_ServantInfo_All:switchVehicleInfo(isGuild)
  self._currentServantInfo = servantInfo
  self._currentVehicleNo = servantInfo:getServantNo()
  local myservantinfo = stable_getServantByServantNo(servantInfo:getServantNo())
  local hasRentOwnerFlag = false
  if nil ~= myservantinfo then
    hasRentOwnerFlag = Defines.s64_const.s64_0 < myservantinfo:getRentOwnerNo()
  end
  self:setSkillManagement(false)
  self._ui._txt_Tier:SetShow(false)
  local servantType = servantInfo:getVehicleType()
  local vehicleSubType = servantInfo:getVehicleSubType()
  local servantTier = servantInfo:getTier()
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  local servantRegionName = servantInfo:getRegionName()
  local servantState = servantInfo:getStateType()
  local isMatingComplete = servantInfo:isMatingComplete()
  local isChangingRegion = servantInfo:isChangingRegion()
  local isPcroomOnly = servantInfo:isPcroomOnly()
  local characterKeyRaw = servantInfo:getCharacterKeyRaw()
  local isMutationHorse = servantType == __eVehicleType_Horse and vehicleSubType == __eTVehicleSubType_MutationHorse
  if servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_RaceHorse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_RidableBabyElephant or servantType == CppEnums.VehicleType.Type_RepairableCarriage or 9113 == characterKeyRaw or 9114 == characterKeyRaw or 9115 == characterKeyRaw then
    self._ui._txt_Tier:SetShow(false)
    self._ui._txt_Tier:SetText("")
    local tierName = servantInfo:getDisplayTierName()
    if nil ~= tierName then
      self._ui._txt_Tier:SetText(tierName)
      self._ui._txt_Tier:SetShow(true)
    end
    if (_ContentsGroup_ServantLevelUpRenewal == true or _ContentsGroup_ServantLevelUpRenewal == false and servantInfo:isSeized() == false) and servantState ~= CppEnums.ServantStateType.Type_RegisterMarket and servantState ~= CppEnums.ServantStateType.Type_RegisterMating and servantState ~= CppEnums.ServantStateType.Type_Mating and servantState ~= CppEnums.ServantStateType.Type_Coma and servantState ~= CppEnums.ServantStateType.Type_SkillTraining and servantType ~= CppEnums.VehicleType.Type_RaceHorse and isMatingComplete == false and isChangingRegion == false and hasRentOwnerFlag == false and isPcroomOnly == false and isMutationHorse == false then
      self:setSkillManagement(true)
    end
  elseif true == servantInfo:doHaveVehicleSkill() and false == isGuild then
    self:setSkillManagement(true)
  end
  if servantType ~= CppEnums.VehicleType.Type_Horse then
    self:setSkillManagement(false)
  end
  self._ui._icon_SwiftHorse:SetShow(false)
  self._ui._icon_raceHorse:SetShow(false)
  self._ui._icon_SwiftHorse:SetMonoTone(true, true)
  self._ui._icon_Twins:SetShow(false)
  if servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_RaceHorse then
    if 9 ~= servantTier and false == isPcroomOnly and self._isContentsStallionEnable then
      local isStallion = servantInfo:isStallion()
      self._ui._icon_SwiftHorse:SetShow(true)
      if true == isStallion then
        self._ui._icon_SwiftHorse:SetMonoTone(false, false)
        self._ui._icon_raceHorse:SetMonoTone(false, false)
      else
        self._ui._icon_SwiftHorse:SetMonoTone(true, false)
        self._ui._icon_raceHorse:SetMonoTone(false, false)
      end
    end
    if servantType == CppEnums.VehicleType.Type_RaceHorse then
      self._ui._icon_raceHorse:SetShow(true)
      self._ui._icon_SwiftHorse:SetShow(false)
    else
      self._ui._icon_raceHorse:SetShow(false)
    end
  end
  if _ContentsGroup_ServantLevelUpRenewal == true then
    self._ui._txt_Name:SetText(servantInfo:getName())
    self._ui._txt_ServantLv:SetText(tostring(servantInfo:getLevel()) .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_LV"))
    self._ui._txt_ServantLv:SetShow(true)
  else
    local servantName = ""
    if isGuild == true then
      servantName = servantInfo:getName()
    else
      servantName = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(servantInfo:getLevel()) .. " " .. servantInfo:getName()
    end
    self._ui._txt_Name:SetText(servantName)
    self._ui._txt_ServantLv:SetShow(false)
  end
  local curHp = servantInfo:getHp()
  local maxHp = servantInfo:getMaxHp()
  local curStamina = servantInfo:getMp()
  local maxStamina = servantInfo:getMaxMp()
  self._ui._txt_HpValue:SetText(makeDotMoney(curHp) .. " / " .. makeDotMoney(maxHp))
  self._ui._txt_StatminaValue:SetText(makeDotMoney(curStamina) .. " / " .. makeDotMoney(maxStamina))
  self._ui._prog2_Hp:SetProgressRate(curHp / maxHp * 100)
  self._ui._prog2_Stamina:SetProgressRate(curStamina / maxStamina * 100)
  local max_weight_s64 = servantInfo:getMaxWeight_s64()
  local max_weight = Int64toInt32(max_weight_s64 / Defines.s64_const.s64_10000)
  self._ui._prog2_Weight:SetProgressRate(0)
  self._ui._txt_WeightTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_WEIGHT"))
  self._ui._txt_WeightValue:SetText(makeDotMoney(max_weight) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  self._ui._stc_WeightProgressBg:SetShow(false)
  self._ui._prog2_Weight:SetShow(false)
  if true == isUnSealed then
    local actorKeyRaw = servantInfo:getActorKeyRaw()
    local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
    if nil ~= vehicleActorWrapper then
      local vehicleActor = vehicleActorWrapper:get()
      local possessableWeight_s64 = vehicleActor:getPossessableWeight_s64()
      local total_weight_s64 = vehicleActor:getCurrentWeight_s64()
      max_weight = possessableWeight_s64 / Defines.s64_const.s64_100
      local weightPercent = Int64toInt32(total_weight_s64 / max_weight)
      self._ui._txt_WeightValue:SetText(makeWeightString(total_weight_s64, 1) .. " / " .. makeWeightString(possessableWeight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
      self._ui._stc_WeightProgressBg:SetShow(true)
      self._ui._prog2_Weight:SetShow(true)
      self._ui._prog2_Weight:SetProgressRate(weightPercent)
    end
  else
    self._ui._txt_WeightValue:SetText(makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  end
  self._ui._txt_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
  self._ui._txt_AccelrationValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
  self._ui._txt_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
  self._ui._txt_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
  if ToClient_IsOceanSiegeBeingOnMyChannel() == true then
    local speedLimit = servantInfo:getStatLimitRatioForOceanSiege()
    self._ui._txt_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) * speedLimit / 10000) .. "%")
    self._ui._txt_AccelrationValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) * speedLimit / 10000) .. "%")
    self._ui._txt_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) * speedLimit / 10000) .. "%")
    self._ui._txt_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) * speedLimit / 10000) .. "%")
  end
  self._ui._txt_DefenseTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE"))
  local defense = servantInfo:getDefense()
  self._ui._txt_DefenseValue:SetText(defense)
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_DefenseTitle, self._ui._txt_DefenseValue)
  local deadCount = servantInfo:getDeadCount()
  if true == isGuild then
    if servantType == __eVehicleType_Elephant or servantType == __eVehicleType_GuildDragon then
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDSERVANTINFO_INJURY"))
      self._ui._txt_DeadValue:SetText(deadCount * 10 .. "%")
    else
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT"))
      self._ui._txt_DeadValue:SetText(deadCount)
    end
  else
    local s64_exp = servantInfo:getExp_s64()
    local s64_needexp = servantInfo:getNeedExp_s64()
    local s64_exp_percent = Defines.s64_const.s64_0
    local s64_expStack = 0
    local possibleLevel = 0
    if isUnSealed == true then
      local unsealServantInfo = stable_getServantByServantNo(self._currentVehicleNo)
      if unsealServantInfo ~= nil then
        s64_expStack = unsealServantInfo:getExperienceStack()
        possibleLevel = unsealServantInfo:getPossibleLevel()
      end
    else
      s64_expStack = servantInfo:getExperienceStack()
      possibleLevel = servantInfo:getPossibleLevel()
    end
    if _ContentsGroup_ServantLevelUpRenewal == true then
      self._ui._txt_ExpValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_EXP", "servantexp", makeDotMoney(s64_expStack)))
    else
      self._ui._txt_ExpValue:SetText(makeDotMoney(s64_exp) .. " / " .. makeDotMoney(s64_needexp))
    end
    if s64_exp > Defines.s64_const.s64_0 then
      self._ui._prog2_Exp:SetProgressRate(Int64toInt32(s64_exp) / Int64toInt32(s64_needexp) * 100)
    else
      self._ui._prog2_Exp:SetProgressRate(0)
    end
    if servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_Elephant then
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_KILLCOUNT"))
    elseif servantType == CppEnums.VehicleType.Type_Carriage or servantType == CppEnums.VehicleType.Type_CowCarriage or servantType == CppEnums.VehicleType.Type_RepairableCarriage then
      self._ui._txt_DeadTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT"))
    end
    if true == servantInfo:doClearCountByDead() then
      deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
    else
      deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
    end
    self._ui._txt_DeadValue:SetText(deadCount)
  end
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_DeadTitle, self._ui._txt_DeadValue)
  self._ui._txt_MatingTitle:SetShow(false)
  self._ui._txt_MatingValue:SetShow(false)
  PaGlobal_ServantInfo_All:SetTimerShow(false)
  if true == servantInfo:doMating() and 9 ~= servantTier then
    local matingCount = servantInfo:getMatingCount()
    if servantInfo:doClearCountByMating() then
      matingCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", matingCount)
    else
      matingCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", matingCount)
    end
    self._ui._txt_MatingValue:SetText(matingCount)
    self._ui._txt_MatingValue:SetShow(true)
    self._ui._txt_MatingTitle:SetShow(true)
    PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_MatingTitle, self._ui._txt_MatingValue)
    if CppEnums.ServantStateType.Type_Mating == servantState and not isMatingComplete then
      PaGlobal_ServantInfo_All:SetTimerShow(true, 1, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_INFO_MATINGTIME") .. " " .. convertStringFromDatetime(servantInfo:getMatingTime()), servantInfo)
    end
  end
  self._ui._txt_LeftLifeValue:SetShow(true)
  self._ui._txt_LeftLifeTitle:SetShow(true)
  if true == servantInfo:isPeriodLimit() then
    self._ui._txt_LeftLifeValue:SetText(convertStringFromDatetime(servantInfo:getExpiredTime()))
  else
    self._ui._txt_LeftLifeValue:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
  end
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_LeftLifeTitle, self._ui._txt_LeftLifeValue)
  local isCarriage = false
  if servantType == CppEnums.VehicleType.Type_Carriage or servantType == CppEnums.VehicleType.Type_CowCarriage then
    self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_DURABILITY"))
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_LIFE"))
    self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_PERIOD"))
    isCarriage = true
  elseif servantType == CppEnums.VehicleType.Type_RepairableCarriage then
    self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_DURABILITY"))
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
    isCarriage = true
  else
    self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_HORSEHP_NAME"))
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_STAMINA"))
  end
  if true == isGuild then
    self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_STAMINA"))
  end
  self._ui._icon_ServantGender:SetShow(false)
  if (servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_RaceHorse) and true == servantInfo:isDisplayGender() then
    self._ui._icon_ServantGender:SetShow(true)
    self._ui._icon_ServantGender:ChangeTextureInfoNameAsync("combine/etc/combine_etc_stable.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if true == servantInfo:isMale() then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._icon_ServantGender, 1, 209, 31, 239)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._icon_ServantGender, 1, 178, 31, 208)
    end
    self._ui._icon_ServantGender:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._icon_ServantGender:setRenderTexture(self._ui._icon_ServantGender:getBaseTexture())
  end
  local remainSecondsToUneal = servantInfo:getRemainSecondsToUnseal()
  if true == isChangingRegion then
    PaGlobal_ServantInfo_All:SetTimerShow(true, 0, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_INFO_REGION_CHANGING_TIME") .. " " .. convertStringFromDatetime(remainSecondsToUneal), servantInfo)
  elseif servantState == CppEnums.ServantStateType.Type_SkillTraining and false == stable_isSkillExpTrainingComplete(self._currentVehicleNo) then
    PaGlobal_ServantInfo_All:SetTimerShow(true, 0, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_TRAININGTIME") .. " " .. convertStringFromDatetime(servantInfo:getSkillTrainingTime()), servantInfo)
  end
  self._ui._txt_ImprintTitle:SetShow(false)
  self._ui._txt_ImprintValue:SetShow(false)
  if true == servantInfo:isImprint() then
    isImprintAble = true
    self._ui._txt_ImprintValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTING"))
  elseif servantType == CppEnums.VehicleType.Type_Horse or servantType == CppEnums.VehicleType.Type_Camel or servantType == CppEnums.VehicleType.Type_Donkey or servantType == CppEnums.VehicleType.Type_Elephant or servantType == CppEnums.VehicleType.Type_RidableBabyElephant then
    isImprintAble = true
    if isMutationHorse == true then
      self._ui._txt_ImprintValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLCHANGE_COUPON_DISABLE"))
    else
      self._ui._txt_ImprintValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_ISIMPRINTPOSSIBLE"))
    end
  end
  if true == isImprintAble then
    self._ui._txt_ImprintTitle:SetShow(true)
    self._ui._txt_ImprintValue:SetShow(true)
    PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_ImprintTitle, self._ui._txt_ImprintValue)
  end
  local servantType = servantInfo:getVehicleType()
  if false == servantInfo:isGuildServant() and true == servantInfo:doHaveVehicleSkill() and servantType == CppEnums.VehicleType.Type_Horse then
    self._ui._txt_PremiumChangeTitle:SetShow(true)
    self._ui._txt_PremiumChangeValue:SetShow(true)
    PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_PremiumChangeTitle, self._ui._txt_PremiumChangeValue)
    if 0 < servantInfo:getServantSkillChangeConfirmedCount() or isMutationHorse == true then
      self._ui._txt_PremiumChangeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLCHANGE_COUPON_DISABLE"))
    else
      self._ui._txt_PremiumChangeValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLCHANGE_COUPON_ABLE"))
    end
    UI.setLimitTextAndAddTooltip(self._ui._txt_PremiumChangeValue)
  else
    self._ui._txt_PremiumChangeTitle:SetShow(false)
    self._ui._txt_PremiumChangeValue:SetShow(false)
  end
  local showServantLevelDown = false
  if _ContentsGroup_ServantLevelDown == true then
    local myservantInfo = stable_getServantByServantNo(servantInfo:getServantNo())
    if myservantInfo ~= nil then
      if myservantinfo:getCanUseLevelDown() == true then
        self._ui._txt_servantLevelDownValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLCHANGE_COUPON_ABLE"))
      else
        self._ui._txt_servantLevelDownValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SKILLCHANGE_COUPON_DISABLE"))
      end
      showServantLevelDown = true
    end
  end
  if showServantLevelDown == true then
    self._ui._txt_servantLevelDownTitle:SetShow(true)
    self._ui._txt_servantLevelDownValue:SetShow(true)
    PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_servantLevelDownTitle, self._ui._txt_servantLevelDownValue)
  else
    self._ui._txt_servantLevelDownTitle:SetShow(false)
    self._ui._txt_servantLevelDownValue:SetShow(false)
  end
  local statBgSizeY = 20 + (self._ui._txt_SpeedTitle:GetSizeY() + 10) * (self._statCount + 1)
  local infoBgSizeY = statBgSizeY + (self._ui._stc_HpBg:GetSizeY() + 15) * 4 + self._ui._txt_Tier:GetSizeY() + self._ui._txt_Name:GetSizeY() + 50
  local addSize = 0
  if true == isChangingRegion and false == servantInfo:doHaveVehicleSkill() then
    addSize = self._ui._stc_StatusArea:GetSizeY() + 20
  end
  self._ui._stc_StatBg:SetSize(self._ui._stc_StatBg:GetSizeX(), statBgSizeY)
  self._ui._stc_infoBg:SetSize(self._ui._stc_infoBg:GetSizeX(), infoBgSizeY + addSize)
  self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY() - addSize)
  if 2 ~= self._currentVehicleNo then
    PaGlobal_ServantInfo_All:skillUpdate()
  end
  self._ui._stc_OnlySpeed:SetShow(false)
  self._ui._stc_OnlyAcce:SetShow(false)
  self._ui._stc_OnlyCorner:SetShow(false)
  self._ui._stc_OnlyBrake:SetShow(false)
  local speedValuePosX = self._speedValueBasePosX
  local acceValuePosX = self._acceValueBasePosX
  local cornerValuePosX = self._cornerValueBasePosX
  local brakeValuePosX = self._brakeValueBasePosX
  if servantType == CppEnums.VehicleType.Type_Horse then
    local speedAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeSpeed)
    if speedAddItemUseCount > 0 then
      speedValuePosX = speedValuePosX - self._ui._stc_OnlySpeed:GetSizeX()
      self._ui._stc_OnlySpeed:SetShow(true)
    end
    local acceAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeAcceleration)
    if acceAddItemUseCount > 0 then
      acceValuePosX = acceValuePosX - self._ui._stc_OnlyAcce:GetSizeX()
      self._ui._stc_OnlyAcce:SetShow(true)
    end
    local cornerAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeCornering)
    if cornerAddItemUseCount > 0 then
      cornerValuePosX = cornerValuePosX - self._ui._stc_OnlyCorner:GetSizeX()
      self._ui._stc_OnlyCorner:SetShow(true)
    end
    local brakeAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeBrake)
    if brakeAddItemUseCount > 0 then
      brakeValuePosX = brakeValuePosX - self._ui._stc_OnlyBrake:GetSizeX()
      self._ui._stc_OnlyBrake:SetShow(true)
    end
  end
  self._ui._txt_SpeedValue:SetPosX(speedValuePosX)
  self._ui._txt_AccelrationValue:SetPosX(acceValuePosX)
  self._ui._txt_CorneringValue:SetPosX(cornerValuePosX)
  self._ui._txt_BreakValue:SetPosX(brakeValuePosX)
  if servantType == __eVehicleType_Horse and vehicleSubType == __eTVehicleSubType_MutationHorse then
    self._ui._icon_SwiftHorse:SetShow(false)
    self._ui._icon_Twins:SetShow(true)
  end
  self._ui._txt_creatorName:SetShow(false)
end
function PaGlobal_ServantInfo_All:updateSeaVehicle()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  local isUnSealed = false
  local servantInfo
  self._statCount = 1
  if nil == self._currentVehicleIndexNo then
    self._currentSlotType = 1
  end
  local isGuild = PaGlobalFunc_ServantFunction_All_GetIsGuild()
  if isGuild == true then
    self._currentSlotType = 0
  end
  if 0 == self._currentSlotType then
    if isGuild == true then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType and false == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  local deadCount = 0
  if nil ~= servantInfo then
    deadCount = servantInfo:getDeadCount()
  end
  if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() and true == _ContentsGroup_OceanCurrent then
    local servantInfoByActor
    if nil ~= servantInfo then
    end
    if nil ~= servantInfoByActor then
      servantInfo = servantInfoByActor
    end
  end
  if nil == servantInfo then
    return
  end
  local actorKeyRaw = servantInfo:getActorKeyRaw()
  local vehicleActorWrapper = getVehicleActor(actorKeyRaw)
  self._currentServantInfo = servantInfo
  self._currentVehicleNo = servantInfo:getServantNo()
  PaGlobal_ServantInfo_All:setLvUpRenewalSetting(servantInfo:getServantNo())
  PaGlobal_ServantInfo_All:switchVehicleInfo(true)
  local servantName = servantInfo:getName()
  self._ui._txt_Name:SetText(servantName)
  self._ui._txt_Tier:SetShow(false)
  if __eServantTypeShip == stable_getServantType() then
    local shipTypeStr = servantInfo:getDisplayName()
    if nil == shipTypeStr then
      shipTypeStr = ""
    else
      self._ui._txt_Tier:SetShow(true)
      self._ui._txt_Tier:SetText(shipTypeStr)
    end
  end
  local curHp = servantInfo:getHp()
  local maxHp = servantInfo:getMaxHp()
  local curStamina = getMpToServantInfo(servantInfo)
  local maxStamina = getMaxMpToServantInfo(servantInfo)
  self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_DURABILITY"))
  self._ui._txt_HpValue:SetText(makeDotMoney(curHp) .. " / " .. makeDotMoney(maxHp))
  self._ui._txt_StatminaValue:SetText(makeDotMoney(curStamina) .. " / " .. makeDotMoney(maxStamina))
  self._ui._prog2_Hp:SetProgressRate(curHp / maxHp * 100)
  self._ui._prog2_Stamina:SetProgressRate(curStamina / maxStamina * 100)
  local max_weight_s64 = servantInfo:getMaxWeight_s64()
  local max_weight = Int64toInt32(max_weight_s64 / Defines.s64_const.s64_10000)
  self._ui._prog2_Weight:SetProgressRate(0)
  self._ui._stc_WeightProgressBg:SetShow(false)
  self._ui._prog2_Weight:SetShow(false)
  if false == isUnSealed then
    self._ui._txt_WeightValue:SetText(makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  elseif nil ~= servantInfo then
    local currentWeight = servantInfo:getInventoryWeight_s64() + servantInfo:getEquipWeight_s64() + servantInfo:getMoneyWeight_s64()
    if nil ~= vehicleActorWrapper then
      local vehicleActor = vehicleActorWrapper:get()
      if nil ~= vehicleActor then
        currentWeight = vehicleActor:getCurrentWeight_s64()
      end
    end
    local total_weight = Int64toInt32(currentWeight / Defines.s64_const.s64_10000)
    local weightPercent = total_weight / max_weight * 100
    self._ui._txt_WeightValue:SetText(makeWeightString(currentWeight, 1) .. " / " .. makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
    self._ui._stc_WeightProgressBg:SetShow(true)
    self._ui._prog2_Weight:SetShow(true)
    self._ui._prog2_Weight:SetProgressRate(weightPercent)
  end
  local speed = servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
  local accel = servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration)
  local cornering = servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
  local braking = servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
  if true == _ContentsGroup_Sailor and nil ~= vehicleActorWrapper then
    speed = speed + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Speed)
    accel = accel + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Acceleration)
    cornering = cornering + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Cornering)
    braking = braking + vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Servant_Brake)
  end
  if ToClient_IsOceanSiegeBeingOnMyChannel() == true then
    local speedLimit = servantInfo:getStatLimitRatioForOceanSiege()
    speed = speed * speedLimit
    accel = accel * speedLimit
    cornering = cornering * speedLimit
    braking = braking * speedLimit
  end
  self._ui._txt_SpeedValue:SetText(string.format("%.1f", speed / 10000) .. "%")
  self._ui._txt_AccelrationValue:SetText(string.format("%.1f", accel / 10000) .. "%")
  self._ui._txt_CorneringValue:SetText(string.format("%.1f", cornering / 10000) .. "%")
  self._ui._txt_BreakValue:SetText(string.format("%.1f", braking / 10000) .. "%")
  self._ui._txt_DefenseTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE"))
  local defense = servantInfo:getDefense()
  self._ui._txt_DefenseValue:SetText(defense)
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_DefenseTitle, self._ui._txt_DefenseValue)
  if true == _ContentsGroup_OceanCurrent then
    local characterKey = servantInfo:getCharacterKeyRaw()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME"))
    else
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
    end
  else
    local vehicleType = servantInfo:getVehicleType()
    if CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
    else
      self._ui._txt_StatminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
    end
  end
  PaGlobal_ServantInfo_All:SetTimerShow(false)
  local isChangingRegion = servantInfo:isChangingRegion()
  if true == isChangingRegion then
    local remainSecondsToUneal = servantInfo:getRemainSecondsToUnseal()
    PaGlobal_ServantInfo_All:SetTimerShow(true, 0, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_INFO_REGION_CHANGING_TIME") .. " " .. convertStringFromDatetime(remainSecondsToUneal), servantInfo)
  end
  local deadTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT")
  if true == _ContentsGroup_OceanCurrent and true == servantInfo:getIsDamageShip() then
    deadCount = deadCount / ToClinet_GetServantMaxDeadCount() * 100 .. "%"
    deadTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_WOUNDEDPERCENT")
  else
  end
  if servantInfo:doClearCountByDead() then
    deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETOK", "deadCount", deadCount)
  else
    deadCount = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEINFO_RESETNO", "deadCount", deadCount)
  end
  self._ui._txt_DeadTitle:SetText(deadTitleStr)
  self._ui._txt_DeadValue:SetText(deadCount)
  PaGlobal_ServantInfo_All:uiReposition(self._ui._txt_DeadTitle, self._ui._txt_DeadValue)
  local addSize = 0
  if true == isChangingRegion and false == servantInfo:doHaveVehicleSkill() then
    addSize = self._ui._stc_StatusArea:GetSizeY() + 20
  end
  local statBgSizeY = 20 + (self._ui._txt_SpeedTitle:GetSizeY() + 10) * (self._statCount + 1)
  local infoBgSizeY = statBgSizeY + (self._ui._stc_HpBg:GetSizeY() + 15) * 3 + self._ui._txt_Tier:GetSizeY() + self._ui._txt_Name:GetSizeY() + 50
  self._ui._stc_StatBg:SetSize(self._ui._stc_StatBg:GetSizeX(), statBgSizeY)
  self._ui._stc_infoBg:SetSize(self._ui._stc_infoBg:GetSizeX(), infoBgSizeY + addSize)
  self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY() - addSize)
  self._ui._stc_OnlySpeed:SetShow(false)
  self._ui._txt_SpeedValue:SetPosX(self._speedValueBasePosX)
  self._ui._txt_servantLevelDownTitle:SetShow(false)
  self._ui._txt_servantLevelDownValue:SetShow(false)
  local creatorName = servantInfo:getCreatorNickname()
  if creatorName == nil or creatorName == "" then
    self._ui._txt_creatorName:SetShow(false)
  else
    self._ui._txt_creatorName:SetShow(true)
    self._ui._txt_creatorName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_MADEBY_TITLE") .. " : " .. creatorName)
  end
  PaGlobal_ServantInfo_All:skillUpdate()
end
function PaGlobal_ServantInfo_All:uiReposition(titleControl, valueControl)
  if nil == titleControl or nil == valueControl then
    return
  end
  titleControl:SetSpanSize(titleControl:GetSpanSize().x, self._ui._txt_AccelrationValue:GetSpanSize().y + self._ADDPOSY * self._statCount)
  valueControl:SetSpanSize(titleControl:GetSpanSize().x, self._ui._txt_AccelrationValue:GetSpanSize().y + self._ADDPOSY * self._statCount)
  self._statCount = self._statCount + 1
end
function PaGlobal_ServantInfo_All:skillUpdate()
  if nil == self._currentSlotType or nil == self._currentVehicleNo then
    return
  end
  local servantInfo
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    elseif self._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(self._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(self._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
      self:setSkillManagement(false)
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if nil == servantInfo then
    return
  end
  if _ContentsGroup_ServantLevelUpRenewal == false and self._currentSlotType == 1 and self._ui._btn_SkillManagerBg:GetShow() == true then
    self:setSkillManagement(false)
  end
  local skillCount = 0
  self._ui._stc_SkillBg:SetSize(self._ui._stc_SkillBg:GetSizeX(), self._OriginSkillBgSizeY)
  self._ui._list2_Skill:SetSize(self._ui._list2_Skill:GetSizeX(), self._OriginList2SizeY)
  Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._OriginPanelSizeY)
  if false == servantInfo:doHaveVehicleSkill() then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY())
    self._ui._stc_SkillBg:SetShow(false)
    if true == self._isConsole then
      self._ui._stc_ConsoleHighlight:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX() + 1, Panel_Dialog_ServantInfo_All:GetSizeY() + 1)
    end
    return
  else
    self._ui._stc_SkillBg:SetShow(true)
    skillCount = servantInfo:getSortedSkillCountForDisplay()
  end
  local addSpanY = 0
  if true == self._ui._stc_StatusArea:GetShow() then
    addSpanY = self._ui._stc_StatusArea:GetSizeY()
  end
  if self._currentNpcType == self._ENUM_NPC_TYPE._SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    local spanY = self._ui._stc_StatBg:GetSpanSize().y + self._ui._txt_SpeedTitle:GetSpanSize().y + self._ADDPOSY * 2 + 10 + addSpanY
    self._ui._stc_SkillBg:SetSpanSize(self._ui._stc_SkillBg:GetSpanSize().x, spanY)
  else
    local spanY = self._ui._stc_StatBg:GetSpanSize().y + (self._ui._txt_AccelrationValue:GetSpanSize().y + self._statCount * self._ADDPOSY) + addSpanY
    self._ui._stc_SkillBg:SetSpanSize(self._ui._stc_SkillBg:GetSpanSize().x, spanY)
  end
  self._ui._list2_Skill:ComputePos()
  self._skillIdxTable = {}
  self._ui._list2_Skill:getElementManager():clearKey()
  local uiCount = 0
  local displaySkillCount = 0
  for skillIdx = 0, skillCount - 1 do
    skillWrapper = servantInfo:getSortedSkillForDisplay(skillIdx)
    if nil ~= skillWrapper and false == skillWrapper:isTrainingSkill() then
      self._skillIdxTable[skillIdx] = skillIdx
      self._ui._list2_Skill:getElementManager():pushKey(toInt64(0, skillIdx))
      uiCount = uiCount + 1
      displaySkillCount = displaySkillCount + 1
    end
  end
  local skillCountString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SKILLCOUNT", "servantSkillListCnt", displaySkillCount)
  self._ui._txt_SkillBgTitle:SetText(skillCountString)
  if true == _ContentsGroup_HorseSkillLearnNewWay then
    local skillDiceCount = servantInfo:getServantSkillDiceCount()
    skillCount = skillCount + 1
    local maxDiceSearchCount = skillCount + skillDiceCount - 1
    for ii = skillCount, maxDiceSearchCount do
      self._skillIdxTable[uiCount] = ii
      self._ui._list2_Skill:getElementManager():pushKey(toInt64(0, uiCount))
      uiCount = uiCount + 1
    end
  end
  if nil ~= self._currentSkillListData._pos and nil ~= self._currentSkillListData._index then
    self._ui._list2_Skill:setCurrenttoIndex(self._currentSkillListData._index)
    self._ui._list2_Skill:GetVScroll():SetControlPos(self._currentSkillListData._pos)
  end
  local gap = self._OriginSkillBgSizeY - self._OriginList2SizeY
  if uiCount <= 0 then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY())
    self:setSkillManagement(false)
    self._ui._stc_SkillBg:SetShow(false)
    if true == self._isConsole then
      self._ui._stc_ConsoleHighlight:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX() + 1, Panel_Dialog_ServantInfo_All:GetSizeY() + 1)
    end
    return
  elseif uiCount <= 4 then
    self._ui._list2_Skill:SetSize(self._ui._list2_Skill:GetSizeX(), self._ui._list2_Content:GetSizeY() * uiCount + 5)
    self._ui._stc_SkillBg:SetSize(self._ui._list2_Skill:GetSizeX(), self._ui._list2_Skill:GetSizeY() + gap)
    if self._isConsole == true then
      ToClient_padSnapIgnoreMoveToThisControl(Panel_Dialog_ServantInfo_All, false)
    end
  else
    local offset = 0
    if Panel_Dialog_ServantFunction_All ~= nil then
      offset = Panel_Dialog_ServantFunction_All:GetSizeY()
    end
    self._ui._list2_Skill:SetSize(self._ui._list2_Skill:GetSizeX(), self._OriginList2SizeY - offset)
    self._ui._stc_SkillBg:SetSize(self._ui._stc_SkillBg:GetSizeX(), self._OriginSkillBgSizeY - offset)
    if self._isConsole == true then
      ToClient_padSnapIgnoreMoveToThisControl(Panel_Dialog_ServantInfo_All, false)
    end
  end
  local isSKillManagerBtnOn = self._ui._btn_SkillManagerBg:GetShow()
  if true == isSKillManagerBtnOn then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY() + self._ui._stc_SkillBg:GetSizeY() + 15)
    self._ui._btn_SkillManagerBg:ComputePos()
    self._ui._btn_SkillManager:SetIgnore(false)
  else
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), self._ui._stc_infoBg:GetSizeY() + self._ui._stc_SkillBg:GetSizeY() - 5)
    self._ui._btn_SkillManager:SetIgnore(true)
  end
  if true == self._ui._stc_StatusArea:GetShow() then
    Panel_Dialog_ServantInfo_All:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX(), Panel_Dialog_ServantInfo_All:GetSizeY() + self._ui._stc_StatusArea:GetSizeY() + 10)
  end
  if true == self._isConsole then
    self._ui._stc_ConsoleHighlight:SetSize(Panel_Dialog_ServantInfo_All:GetSizeX() + 1, Panel_Dialog_ServantInfo_All:GetSizeY() + 1)
  end
end
function PaGlobal_ServantInfo_All:setLvUpRenewalSetting(servantNo)
  if Panel_Dialog_ServantInfo_All == nil then
    return
  end
  self._ui._txt_ExpValue:SetShow(true)
  if _ContentsGroup_ServantLevelUpRenewal == true then
    self._ui._stc_ExpProgressBg:SetShow(false)
    self._ui._prog2_Exp:SetShow(false)
    self._ui._txt_ExpTitle:SetShow(false)
    self._ui._txt_ExpValue:SetIgnore(false)
    local isUnSealed = false
    if self._currentSlotType == 0 then
      isUnSealed = false
    elseif self._currentSlotType == 1 then
      isUnSealed = true
    end
    if servantNo ~= nil and ToClient_IsPossibleServantLevelUpByExpStack(servantNo, isUnSealed) == true then
      self._ui._btn_StackLvUp:SetShow(true)
      self._ui._stc_ExpBg:SetSize(self._ui._stc_ExpBg:GetSizeX(), 70)
    else
      self._ui._btn_StackLvUp:SetShow(false)
      self._ui._stc_ExpBg:SetSize(self._ui._stc_ExpBg:GetSizeX(), 30)
      self._ui._txt_ExpValue:SetShow(false)
    end
    self._ui._stc_ExpBg:SetSpanSize(self._ui._stc_ExpBg:GetSpanSize().x, 70)
  else
    self._ui._btn_StackLvUp:SetShow(false)
    self._ui._stc_ExpProgressBg:SetShow(true)
    self._ui._prog2_Exp:SetShow(true)
    self._ui._txt_ExpTitle:SetShow(true)
    self._ui._txt_ExpValue:SetIgnore(true)
    self._ui._stc_ExpBg:SetSize(self._ui._stc_ExpBg:GetSizeX(), 30)
    self._ui._stc_ExpBg:SetSpanSize(self._ui._stc_ExpBg:GetSpanSize().x, 90)
  end
  self._ui._stc_ExpBg:ComputePos()
end
function PaGlobal_ServantInfo_All:switchVehicleInfo(isShip_orGuild)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  self._ui._stc_StatusArea:SetShow(false)
  self:setSkillManagement(false)
  if false == isShip_orGuild then
    self._ui._txt_MatingTitle:SetShow(false)
    self._ui._txt_MatingValue:SetShow(false)
    self._ui._txt_LeftLifeTitle:SetShow(false)
    self._ui._txt_LeftLifeValue:SetShow(false)
    self._ui._txt_ImprintTitle:SetShow(false)
    self._ui._txt_ImprintValue:SetShow(false)
    self._ui._txt_PremiumChangeTitle:SetShow(false)
    self._ui._txt_PremiumChangeValue:SetShow(false)
    self._ui._stc_ExpBg:SetShow(true)
    local statBgGroup = {}
    statBgGroup[0] = self._ui._stc_ExpBg
    statBgGroup[1] = self._ui._stc_HpBg
    statBgGroup[2] = self._ui._stc_StaminaBg
    statBgGroup[3] = self._ui._stc_WeightBg
    if _ContentsGroup_ServantLevelUpRenewal == true then
      for i = 1, #statBgGroup do
        if self._ui._btn_StackLvUp:GetShow() == true then
          statBgGroup[i]:SetSpanSize(0, 110 + self._STATBGGAP * i)
        else
          statBgGroup[i]:SetSpanSize(0, 70 + self._STATBGGAP * i)
        end
      end
    else
      for i = 0, #statBgGroup do
        statBgGroup[i]:SetSpanSize(0, self._ui._stc_ExpBg:GetSpanSize().y + self._STATBGGAP * i)
      end
    end
    self._ui._stc_StatBg:SetPosY(statBgGroup[3]:GetPosY() + self._STATBGGAP - 10)
    self._ui._stc_SkillBg:SetPosY(self._ui._stc_StatBg:GetPosY() - self._STATBGGAP * 2)
  else
    self._ui._txt_MatingTitle:SetShow(false)
    self._ui._txt_MatingValue:SetShow(false)
    self._ui._txt_LeftLifeTitle:SetShow(false)
    self._ui._txt_LeftLifeValue:SetShow(false)
    self._ui._txt_ImprintTitle:SetShow(false)
    self._ui._txt_ImprintValue:SetShow(false)
    self._ui._txt_PremiumChangeTitle:SetShow(false)
    self._ui._txt_PremiumChangeValue:SetShow(false)
    self._ui._icon_SwiftHorse:SetShow(false)
    self._ui._icon_raceHorse:SetShow(false)
    self:setSkillManagement(false)
    self._ui._icon_ServantGender:SetShow(false)
    PaGlobal_ServantInfo_All:SetTimerShow(false)
    self._ui._stc_ExpBg:SetShow(false)
    local statBgGroup = {}
    statBgGroup[0] = self._ui._stc_HpBg
    statBgGroup[1] = self._ui._stc_StaminaBg
    statBgGroup[2] = self._ui._stc_WeightBg
    for i = 0, #statBgGroup do
      statBgGroup[i]:SetSpanSize(0, self._ui._stc_ExpBg:GetSpanSize().y + self._STATBGGAP * i)
    end
    self._ui._stc_StatBg:SetPosY(statBgGroup[2]:GetPosY() + self._STATBGGAP - 10)
    self._ui._stc_SkillBg:SetPosY(self._ui._stc_StatBg:GetPosY() - self._STATBGGAP * 2)
  end
end
function PaGlobal_ServantInfo_All:updateServantSkillByList2(content, key)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == key or nil == self._currentSlotType then
    return
  end
  local servantInfo
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    elseif self._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(self._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(self._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if nil == servantInfo then
    content:SetShow(false)
    return
  else
    content:SetShow(true)
  end
  local key32 = Int64toInt32(key)
  local skillSlotBg = UI.getChildControl(content, "Static_SkillSlotBg")
  local expBg = UI.getChildControl(content, "Static_SkillExpBg")
  local circle_Prog2_Exp = UI.getChildControl(content, "CircularProgress_SkillExp")
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local skillExpPercent = UI.getChildControl(content, "StaticText_SkillExpPercent")
  local skillName = UI.getChildControl(content, "StaticText_SkillName")
  local skillCommand = UI.getChildControl(content, "StaticText_SkillCommandValue")
  local skillStallionIcon = UI.getChildControl(content, "Static_SkillStallionIcon")
  circle_Prog2_Exp:SetProgressRate(0)
  circle_Prog2_Exp:SetShow(false)
  expBg:SetShow(false)
  skillExpPercent:SetShow(false)
  skillSlotBg:setNotImpactScrollEvent(true)
  skillName:SetTextMode(__eTextMode_LimitText)
  skillCommand:SetTextMode(__eTextMode_AutoWrap)
  local actorKeyRaw = servantInfo:getActorKeyRaw()
  local skillWrapper = servantInfo:getSortedSkillForDisplay(key32)
  local sortedKey32 = servantInfo:getSortedSkillKey(key32)
  if nil ~= skillWrapper then
    if false == skillWrapper:isTrainingSkill() then
      skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillWrapper:getIconPath())
      if true == self._isConsole then
        skillSlotBg:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_SnappingSkill(true," .. key32 .. ")")
        skillSlotBg:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_SnappingSkill(false)")
      else
        skillIcon:addInputEvent("Mouse_On", "HandleEventOn_Servant_Tooltip_Open(" .. key32 .. ")")
        skillIcon:addInputEvent("Mouse_Out", "HandleEventOut_ServantInfo_All_SkillTooltipClose()")
      end
      local isStallionSkill = servantInfo:isStallionSkill(skillWrapper:getKey())
      skillStallionIcon:SetShow(isStallionSkill)
      local skillNameSpanSizeX = self._skillNameBaseSpanSizeX
      if true == isStallionSkill then
        local gabX = 5
        skillNameSpanSizeX = skillNameSpanSizeX + skillStallionIcon:GetSizeX() - gabX
        if false == self._isConsole then
          skillStallionIcon:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowStallionToolTip(true," .. key32 .. ")")
          skillStallionIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowStallionToolTip(false)")
        end
      end
      skillName:SetSpanSize(skillNameSpanSizeX, skillName:GetSpanSize().y)
      skillName:SetText(skillWrapper:getName())
      skillCommand:SetText(skillWrapper:getDescription())
      if self._currentNpcType ~= self._ENUM_NPC_TYPE._SEA and self._currentNpcType ~= self._ENUM_NPC_TYPE._GUILD_SEA then
        expBg:SetShow(true)
        local expPercentTxt = servantInfo:getSkillExp(sortedKey32) / (skillWrapper:getMaxExp() / 100)
        if expPercentTxt >= 100 then
          expPercentTxt = 100
        end
        circle_Prog2_Exp:SetShow(true)
        skillExpPercent:SetShow(true)
        skillExpPercent:SetText(tonumber(string.format("%.0f", expPercentTxt)) .. "%")
        circle_Prog2_Exp:SetProgressRate(expPercentTxt)
        circle_Prog2_Exp:SetAniSpeed(0)
      end
    end
  elseif true == _ContentsGroup_HorseSkillLearnNewWay then
    skillIcon:addInputEvent("Mouse_On", "")
    skillIcon:addInputEvent("Mouse_Out", "")
    skillName:SetText("")
    skillCommand:SetText("")
  end
  if true == skillName:IsLimitText() then
    skillName:addInputEvent("Mouse_On", "HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(" .. key32 .. " , true)")
    skillName:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(" .. key32 .. " , false)")
  else
    skillName:addInputEvent("Mouse_On", "")
    skillName:addInputEvent("Mouse_Out", "")
  end
  if false == self._isConsole then
    skillSlotBg:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    skillSlotBg:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
    skillSlotBg:addInputEvent("Mouse_LUp", "HandleEventScroll_ServantInfo_All_saveScrollPos()")
  end
end
function PaGlobal_ServantInfo_All:Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
  local skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local servantInfo
  if 0 == self._currentSlotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(self._currentVehicleIndexNo)
    elseif self._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(self._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(self._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    else
      servantInfo = stable_getServant(self._currentVehicleIndexNo)
    end
  elseif 1 == self._currentSlotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    isUnSealed = true
  end
  if nil == servantInfo then
    return
  end
  local skillWrapper = servantInfo:getSortedSkillForDisplay(key32)
  if nil == skillWrapper then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Open then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Open then
    local isShowStallionSkillTooltip = false
    if true == self._isConsole then
      isShowStallionSkillTooltip = servantInfo:isStallionSkill(skillWrapper:getKey())
    end
    PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false, isShowStallionSkillTooltip)
    if nil ~= PaGlobal_Tooltip_Servant_SetPos and nil ~= Panel_Tooltip_Skill_Servant then
      PaGlobal_Tooltip_Servant_SetPos(Panel_Dialog_ServantInfo_All:GetPosX() - Panel_Tooltip_Skill_Servant:GetSizeX(), self._ui._stc_SkillBg:GetPosY() + 50)
    end
  end
end
function PaGlobal_ServantInfo_All:SetTimerShow(isShow, btnType, text, servantInfo)
  if isShow == false or servantInfo == nil then
    self._ui._stc_StatusArea:SetShow(false)
    return
  end
  if PaGlobalFunc_ServantFunction_All_GetIsGuild() == true and btnType ~= 0 then
    self._ui._stc_StatusArea:SetShow(false)
    return
  end
  self._ui._stc_StatusArea:SetShow(isShow)
  self._ui._btn_Immediate:SetShow(false)
  self._ui._btn_GetHorse:SetShow(false)
  local isBtnAble = false
  if btnType == 0 or btnType == nil then
    self._ui._txt_StatusTitle:SetText(text)
  elseif btnType == 1 then
    self._ui._txt_StatusTitle:SetText(text)
    if FGlobal_IsCommercialService() and not servantInfo:isMale() then
      self._ui._btn_Immediate:SetShow(true)
      isBtnAble = true
    end
  elseif btnType == 2 then
  end
  if true == isBtnAble then
    self._ui._txt_StatusTitle:SetHorizonLeft()
    self._ui._txt_StatusTitle:SetTextHorizonLeft()
    self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY())
    self._ui._txt_StatusTitle:SetSpanSize(20, 0)
  else
    self._ui._txt_StatusTitle:SetHorizonCenter()
    self._ui._txt_StatusTitle:SetTextHorizonCenter()
    self._ui._stc_StatusArea:SetPosY(self._ui._stc_infoBg:GetPosY() + self._ui._stc_infoBg:GetSizeY())
    self._ui._txt_StatusTitle:SetSpanSize(0, 0)
  end
end
function PaGlobal_ServantInfo_All:prepareClose()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  self._currentNpcType = nil
  self._currentVehicleIndexNo = nil
  self._currentSlotType = nil
  self._currentVehicleNo = nil
  self._currentSkillListData._pos = nil
  self._currentSkillListData._index = nil
  HandleEventOut_ServantInfo_All_SkillTooltipClose()
  PaGlobal_ServantInfo_All:close()
end
function PaGlobal_ServantInfo_All:close()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:SetShow(false)
end
function PaGlobal_ServantInfo_All:validate()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  self._ui._stc_infoBg:isValidate()
  self._ui._txt_Name:isValidate()
  self._ui._icon_ServantGender:isValidate()
  self._ui._icon_SwiftHorse:isValidate()
  self._ui._txt_Tier:isValidate()
  self._ui._txt_ExpTitle:isValidate()
  self._ui._txt_ExpValue:isValidate()
  self._ui._stc_ExpProgressBg:isValidate()
  self._ui._prog2_Exp:isValidate()
  self._ui._prog2_Exp_Head:isValidate()
  self._ui._txt_HpTitle:isValidate()
  self._ui._txt_HpValue:isValidate()
  self._ui._stc_HpProgressBg:isValidate()
  self._ui._prog2_Hp:isValidate()
  self._ui._prog2_Hp_Head:isValidate()
  self._ui._stc_StaminaProgressBg:isValidate()
  self._ui._txt_StatminaTitle:isValidate()
  self._ui._txt_StatminaValue:isValidate()
  self._ui._prog2_Stamina:isValidate()
  self._ui._prog2_Stamina_Head:isValidate()
  self._ui._txt_WeightTitle:isValidate()
  self._ui._txt_WeightValue:isValidate()
  self._ui._stc_WeightProgressBg:isValidate()
  self._ui._prog2_Weight:isValidate()
  self._ui._prog2_Weight_Head:isValidate()
  self._ui._stc_StatBg:isValidate()
  self._ui._txt_SpeedTitle:isValidate()
  self._ui._txt_SpeedValue:isValidate()
  self._ui._txt_CorneringTitle:isValidate()
  self._ui._txt_CorneringValue:isValidate()
  self._ui._txt_AccelrationTitle:isValidate()
  self._ui._txt_AccelrationValue:isValidate()
  self._ui._txt_BreakTitle:isValidate()
  self._ui._txt_BreakValue:isValidate()
  self._ui._txt_DeadTitle:isValidate()
  self._ui._txt_DeadValue:isValidate()
  self._ui._txt_MatingTitle:isValidate()
  self._ui._txt_MatingValue:isValidate()
  self._ui._txt_LeftLifeTitle:isValidate()
  self._ui._txt_LeftLifeValue:isValidate()
  self._ui._txt_ImprintTitle:isValidate()
  self._ui._txt_ImprintValue:isValidate()
  self._ui._txt_PremiumChangeTitle:isValidate()
  self._ui._txt_PremiumChangeValue:isValidate()
  self._ui._stc_OnlySpeed:isValidate()
  self._ui._stc_StatusArea:isValidate()
  self._ui._txt_StatusTitle:isValidate()
  self._ui._btn_Immediate:isValidate()
  self._ui._btn_GetHorse:isValidate()
  self._ui._stc_SkillBg:isValidate()
  self._ui._txt_SkillBgTitle:isValidate()
  self._ui._list2_Skill:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_SkillSlotBg:isValidate()
  self._ui._list2_list2_ExpBg:isValidate()
  self._ui._list2_Circle_Prog2_Exp:isValidate()
  self._ui._list2_stc_SkillIcon:isValidate()
  self._ui._list2_txt_SkillExpPercent:isValidate()
  self._ui._list2_txt_SkillName:isValidate()
  self._ui._list2_txt_SkillCommand:isValidate()
  self._ui._list2_VertiScroll:isValidate()
  self._ui._list2_VertiScroll_Up:isValidate()
  self._ui._list2_VertiScroll_Down:isValidate()
  self._ui._list2_VertiScroll_Ctrl:isValidate()
  self._ui._list2_HoriScroll_Up:isValidate()
  self._ui._list2_HoriScroll_Down:isValidate()
  self._ui._list2_HoriScroll_Ctrl:isValidate()
  self._ui._stc_ExpBg:isValidate()
  self._ui._stc_HpBg:isValidate()
  self._ui._stc_StaminaBg:isValidate()
  self._ui._stc_WeightBg:isValidate()
  self._ui._stc_ConsoleHighlight:isValidate()
  self._ui._btn_servantEquipInvenOpen:isValidate()
  self._ui._stc_servantEquipInvenBg:isValidate()
  self._ui._btn_servantEquipInvenClose:isValidate()
  self._ui._stc_ConsoleKeyGuideBg:isValidate()
  self._ui._stc_ConsoleKeyGuideX:isValidate()
  self._ui._stc_ConsoleKeyGuideY:isValidate()
  for slotNo = 1, self._SERVANT_EQUIP_SLOT_COUNT do
    self._ui._servantEquipSlotList[slotNo]._slotControl:isValidate()
    self._ui._servantEquipSlotList[slotNo]._iconControl:isValidate()
  end
  for slotNo = 1, self._SERVANT_PEARL_EQUIP_SLOT_COUNT do
    self._ui._servantPearlEquipSlotList[slotNo]._slotControl:isValidate()
    self._ui._servantPearlEquipSlotList[slotNo]._iconControl:isValidate()
  end
  self._ui._txt_servantLevelDownTitle:isValidate()
  self._ui._txt_servantLevelDownValue:isValidate()
  self._initialize = true
end
function PaGlobal_ServantInfo_All:updateEquipData(vehicleType, isPearl)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local servantInfo = PaGlobal_ServantInfo_All:GetServantWrapper(self._currentVehicleIndexNo, self._currentSlotType)
  if nil == servantInfo then
    return
  end
  if nil == PaGlobalFunc_Util_getVehicleTypeGroup then
    return
  end
  if nil == PaGlobalFunc_Util_VehicleEquipNoToSlotNo then
    return
  end
  if nil == PaGlobalFunc_Util_getVehicleSlotNoToEquipNo then
    return
  end
  local vehicleTypeGroup = PaGlobalFunc_Util_getVehicleTypeGroup(vehicleType)
  if nil == vehicleTypeGroup or Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._COUNT == vehicleTypeGroup then
    return
  end
  local slotList
  if true == isPearl then
    slotList = self._ui._servantPearlEquipSlotList
  else
    slotList = self._ui._servantEquipSlotList
  end
  if nil == slotList then
    return
  end
  local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local regionName = regionInfo:getAreaName()
  local unsealed = 1
  if PaGlobal_ServantInfo_All._currentSlotType == unsealed then
    regionName = servantInfo:getRegionName()
  end
  self._extendSlotNoList = {}
  local loopCount = 0
  if isPearl == true then
    loopCount = self._SERVANT_PEARL_EQUIP_SLOT_COUNT
  else
    loopCount = self._SERVANT_EQUIP_SLOT_COUNT
  end
  for slotNo = 1, loopCount do
    local slot = slotList[slotNo]._slot
    if nil ~= slot then
      slot:clearItem()
      local iconControl = slotList[slotNo]._iconControl
      if nil ~= iconControl then
        iconControl:SetShow(true)
      end
      local equipNo = PaGlobalFunc_Util_VehicleEquipNoToSlotNo(vehicleTypeGroup, slotNo, isPearl)
      if nil ~= equipNo and 0 ~= equipNo then
        slot.icon:addInputEvent("Mouse_On", "")
        slot.icon:addInputEvent("Mouse_Out", "")
        slot.icon:addInputEvent("Mouse_RUp", "")
        slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
        slot.icon:SetEnable(true)
        slot.background:SetIgnore(false)
        slot.icon:SetMonoTone(false)
        if nil ~= self._extendSlotNoList[slotNo] then
          local extendParentItemWrapper = servantInfo:getEquipItem(self._extendSlotNoList[slotNo])
          if nil ~= extendParentItemWrapper then
            slot:setItem(extendParentItemWrapper, slotNo, true)
            slot.icon:SetEnable(false)
            slot.icon:SetMonoTone(true)
            slot.icon:SetShow(true)
            slot.background:SetIgnore(true)
            if nil ~= iconControl then
              iconControl:SetShow(false)
            end
          end
        else
          local itemWrapper = servantInfo:getEquipItem(equipNo)
          if nil ~= itemWrapper then
            slot:setItem(itemWrapper, slotNo, true)
            local itemSSW = itemWrapper:getStaticStatus()
            if nil ~= itemSSW then
              local itemKey = itemSSW:get()._key
              if nil ~= itemKey then
                slot.icon:addInputEvent("Mouse_On", "HandleEventOn_ServantInfo_All_EquipToolTip(" .. equipNo .. ",true)")
                slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_ServantInfo_All_EquipToolTip(" .. equipNo .. ",false)")
                local isPcroomOnly = servantInfo:isPcroomOnly()
                local isMatingComplete = servantInfo:isMatingComplete()
                local hasRentOwnerFlag = Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo()
                if _ContentsGroup_SealedServantEquip == true and servantInfo:getRegionName() == regionName and servantInfo:isChangingRegion() == false and (servantInfo:getStateType() == CppEnums.ServantStateType.Type_Stable or servantInfo:getStateType() == CppEnums.ServantStateType.Type_Field) and (self._currentNpcType == self._ENUM_NPC_TYPE._SEA or self._currentNpcType == self._ENUM_NPC_TYPE._LAND) and isPcroomOnly == false and isMatingComplete == false and hasRentOwnerFlag == false then
                  slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ServantInfo_All_UnEquip(" .. equipNo .. ")")
                  slot.background:SetIgnore(true)
                  slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ServantInfo_All_UnEquip(" .. equipNo .. ")")
                end
                Panel_Tooltip_Item_SetPosition(slotNo, slot, "ServantShipEquipment")
                slot.icon:SetShow(true)
                if nil ~= iconControl then
                  iconControl:SetShow(false)
                end
              end
              local extendSlotCount = itemSSW:getExtendedSlotCount()
              for ii = 0, extendSlotCount - 1 do
                local extendEquipNo = itemSSW:getExtendedSlotIndex(ii)
                local extendSlotNo = PaGlobalFunc_Util_getVehicleSlotNoToEquipNo(vehicleTypeGroup, extendEquipNo, isPearl)
                if -1 ~= extendSlotNo then
                  self._extendSlotNoList[extendSlotNo] = equipNo
                end
              end
            end
          else
            slot.icon:SetShow(false)
            if equipNo < 0 or equipNo >= __eEquipSlotNoCount or vehicleTypeGroup == Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP and equipNo == __eEquipSlotNoBelt then
              slotList[slotNo]._slotControl:addInputEvent("Mouse_LUp", "")
            elseif vehicleTypeGroup == Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP or vehicleTypeGroup == Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP then
              slotList[slotNo]._slotControl:addInputEvent("Mouse_LUp", "PaGlobal_ShipInfo_All_ItemAcquireHelper(" .. equipNo .. ", " .. tostring(vehicleType) .. ", " .. tostring(isPearl) .. " )")
            else
              slotList[slotNo]._slotControl:addInputEvent("Mouse_LUp", "PaGlobal_VehicleInfo_All_ItemAcquireHelper(" .. equipNo .. ", " .. tostring(vehicleType) .. " )")
            end
          end
        end
      end
    end
  end
  if ToClient_IsContentsGroupOpen("1429") == false and (vehicleTypeGroup == Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._SHIP or vehicleTypeGroup == Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP) and self._ui._servantEquipSlotList[self._SERVANT_PEARL_EQUIP_SLOT_COUNT] ~= nil then
    local slotList = self._ui._servantEquipSlotList[self._SERVANT_PEARL_EQUIP_SLOT_COUNT]
    slotList._slotControl:SetShow(false)
    slotList._iconControl:SetShow(false)
  end
  local haveFishingPresetSlot = 0 < ToClient_getEmployeePresetJobCount(servantInfo:getCharacterKeyRaw(), __eEmployeePresetJob_Fishing)
  if isPearl == false then
    if (_ContentsGroup_EmployeeAutoFishing == true and haveFishingPresetSlot == false or _ContentsGroup_EmployeeAutoFishing == false) and self._ui._servantEquipSlotList[6] ~= nil then
      local slotList = self._ui._servantEquipSlotList[6]
      slotList._slotControl:SetShow(false)
      slotList._iconControl:SetShow(false)
    end
  elseif _ContentsGroup_EmployeeAutoFishing == true then
    local startSpanX = 275
    if vehicleTypeGroup == Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._BIGSHIP and haveFishingPresetSlot == true then
      startSpanX = 310
    end
    for slotNo = 1, self._SERVANT_PEARL_EQUIP_SLOT_COUNT do
      local newSpanX = (slotNo - 1) * 50 + startSpanX
      self._ui._servantPearlEquipSlotList[slotNo]._slotControl:SetSpanSize(newSpanX, self._ui._servantPearlEquipSlotList[slotNo]._slotControl:GetSpanSize().y)
      self._ui._servantPearlEquipSlotList[slotNo]._slot.icon:SetPosXY(self._ui._servantPearlEquipSlotList[slotNo]._slotControl:GetPosX(), self._ui._servantPearlEquipSlotList[slotNo]._slotControl:GetPosY())
    end
  end
end
function PaGlobal_ServantInfo_All:updateEquipSlot()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == self._currentServantInfo then
    return
  end
  local vehicleType = self._currentServantInfo:getVehicleType()
  self:changeEquipSlotBaseTexture(vehicleType)
  self:updateEquipData(vehicleType, true)
  self:updateEquipData(vehicleType, false)
end
function PaGlobal_ServantInfo_All:createInvenSlot()
  if nil == Panel_Dialog_ServantInfo_All then
    return false
  end
  self._invenItemSlots = {}
  self._invenSlotBG = {}
  if 0 == self._INVENTORY_CONFIG.col then
    return false
  end
  self._INVENTORY_CONFIG.row = math.floor(self._INVENTORY_CONFIG.CONST_COUNT / self._INVENTORY_CONFIG.col)
  for ii = 0, self._INVENTORY_CONFIG.CONST_COUNT - 1 do
    self._invenSlotBG[ii] = UI.createAndCopyBasePropertyControl(self._ui._stc_inventoryBg, "Static_VehicleInventorySlot", self._ui._stc_inventoryBg, "Static_VehicleInventorySlot_" .. ii)
    if nil == self._invenSlotBG[ii] then
      return
    end
    self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandlerEventScroll_ServantInfo_All_InventoryScroll(true)")
    self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandlerEventScroll_ServantInfo_All_InventoryScroll(false)")
    local posX = self._INVENTORY_CONFIG.startPos + (self._INVENTORY_CONFIG.size + self._INVENTORY_CONFIG.gap) * (ii % self._INVENTORY_CONFIG.col)
    local posY = self._INVENTORY_CONFIG.startPos + (self._INVENTORY_CONFIG.size + self._INVENTORY_CONFIG.gap) * math.floor(ii / self._INVENTORY_CONFIG.col)
    self._invenSlotBG[ii]:SetPosX(posX)
    self._invenSlotBG[ii]:SetPosY(posY)
    self._invenSlotBG[ii]:SetShow(false)
    local slot = {}
    SlotItem.new(slot, "Slot_ServerntInven_" .. ii, ii, self._invenSlotBG[ii], self._INVENTORY_SLOT_CONFIG)
    slot:createChild()
    UIScroll.InputEventByControl(slot.icon, "HandlerEventScroll_ServantInfo_All_InventoryScroll")
    slot.icon:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandlerEventScroll_ServantInfo_All_InventoryScroll(true)")
    slot.icon:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandlerEventScroll_ServantInfo_All_InventoryScroll(false)")
    self._invenItemSlots[ii] = slot
  end
  return true
end
function PaGlobal_ServantInfo_All:updateInvenSlot()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  local config = self._INVENTORY_CONFIG
  for ii = 0, config.CONST_COUNT - 1 do
    self._invenSlotBG[ii]:SetShow(false)
  end
  if nil == self._currentServantInfo then
    return
  end
  if nil == self._currentServantInventory then
    return
  end
  local actorKey = self._currentServantInfo:getActorKeyRaw()
  for ii = 0, config.count - 1 do
    local slotNo = ii + self._startInvenSlotIndex
    if nil ~= self._invenSlotBG[ii] then
      self._invenSlotBG[ii]:SetShow(true)
      self._invenItemSlots[ii]:clearItem()
      self._invenItemSlots[ii].icon:addInputEvent("Mouse_On", "")
      self._invenItemSlots[ii].icon:addInputEvent("Mouse_Out", "")
      local itemWrapper = self._currentServantInventory:getSimpleItemWrapper(CppEnums.ItemWhereType.eServantInventory, slotNo)
      if nil ~= itemWrapper then
        local itemSSW = getItemEnchantStaticStatus(itemWrapper:getItemEnchantKey())
        if nil ~= itemSSW then
          self._invenItemSlots[ii]:setItemByStaticStatus(itemSSW, itemWrapper:getItemCount_s64())
          self._invenItemSlots[ii].icon:SetShow(true)
          local itemKey = itemSSW:get()._key
          if nil ~= itemKey then
            self._invenItemSlots[ii].icon:addInputEvent("Mouse_On", "HandleEventOn_ServantInfo_All_EquipInvenToolTip(" .. itemKey:get() .. ",true)")
            self._invenItemSlots[ii].icon:addInputEvent("Mouse_Out", "HandleEventOn_ServantInfo_All_EquipInvenToolTip(" .. itemKey:get() .. ",false)")
          end
        end
      else
        self._invenItemSlots[ii].icon:SetShow(false)
      end
    end
  end
end
function PaGlobal_ServantInfo_All:updateInventory()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == self._currentServantInfo then
    return
  end
  local servantInfo
  if self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA then
    servantInfo = guildStable_getServantByServantNo(self._currentVehicleNo)
  else
    servantInfo = stable_getServantByServantNo(self._currentVehicleNo)
    if servantInfo == nil and self._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(self._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(self._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    end
  end
  if nil == servantInfo then
    return
  end
  self._INVENTORY_CONFIG.contentsCount = servantInfo:getInventoryMax()
  if self._INVENTORY_CONFIG.contentsCount == 0 or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND then
    self._INVENTORY_CONFIG.contentsCount = 0
    self._ui._stc_vehicleBg:SetShow(false)
  else
    self._ui._stc_vehicleBg:SetShow(true)
  end
  self._INVENTORY_CONFIG.count = math.min(self._INVENTORY_CONFIG.contentsCount, self._INVENTORY_CONFIG.CONST_COUNT)
  UIScroll.SetButtonSize(self._ui._scroll_vertical, self._INVENTORY_CONFIG.count, self._INVENTORY_CONFIG.contentsCount)
  self:updateInvenSlot()
  self._INVENTORY_CONFIG.currentRow = math.ceil(self._INVENTORY_CONFIG.count / self._INVENTORY_CONFIG.col)
  PaGlobal_ServantInfo_All:updateInventorySize()
  self:updateUserInvenSlot()
end
function PaGlobal_ServantInfo_All:updateInventorySize()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local slotRowSizeDiff = self._OriginInventorySlotSizeY * (self._INVENTORY_CONFIG.row - self._INVENTORY_CONFIG.currentRow)
  local equipInvenDiff = self._OriginEquipInvenBgSizeY - slotRowSizeDiff
  local vehicleBgSizeDiff = self._OriginVehicleBgSizeY - slotRowSizeDiff
  local invenBgSizeDiff_X = self._OriginInventorySizeX
  local invenBgSizeDiff_Y = self._OriginInventorySizeY - slotRowSizeDiff
  if self._INVENTORY_CONFIG.currentRow <= 1 then
    invenBgSizeDiff_X = invenBgSizeDiff_X - self._OriginInventorySlotSizeY * (self._INVENTORY_CONFIG.col - self._INVENTORY_CONFIG.contentsCount)
  end
  self._ui._stc_servantEquipInvenBg:SetSize(self._ui._stc_servantEquipInvenBg:GetSizeX(), equipInvenDiff)
  self._ui._stc_vehicleBg:SetSize(self._ui._stc_vehicleBg:GetSizeX(), vehicleBgSizeDiff)
  self._ui._stc_inventoryBg:SetSize(invenBgSizeDiff_X, invenBgSizeDiff_Y)
  self._ui._stc_userInventory_inStable:SetPosY(self._USERINVENTORY_CONFIG.originalPosY - slotRowSizeDiff)
end
function PaGlobal_ServantInfo_All:clearInventory()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  for ii = 0, self._INVENTORY_CONFIG.count - 1 do
    if nil ~= self._invenSlotBG[ii] then
      self._invenSlotBG[ii]:SetShow(true)
    end
    if nil ~= self._invenItemSlots[ii] then
      self._invenItemSlots[ii]:clearItem()
      self._invenItemSlots[ii].icon:addInputEvent("Mouse_On", "")
      self._invenItemSlots[ii].icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_ServantInfo_All:changeEquipSlotBaseTexture(vehicleType)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == PaGlobalFunc_Util_getVehicleTypeGroup then
    return
  end
  local vehicleTypeGroup = PaGlobalFunc_Util_getVehicleTypeGroup(vehicleType)
  if nil == vehicleTypeGroup or Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._COUNT == vehicleTypeGroup then
    _PA_ASSERT(false, "ServantInfo_ALL \235\170\169\235\161\157\236\151\144 \236\151\134\235\138\148 vehicleType" .. "(" .. tostring(vehicleType) .. ") \236\158\133\235\139\136\235\139\164. Type \236\182\148\234\176\128\234\176\128 \237\149\132\236\154\148\237\149\152\236\167\128 \236\149\138\236\157\128\236\167\128 \237\153\149\236\157\184\235\176\148\235\158\141\235\139\136\235\139\164.")
    return
  end
  if nil == Util.VEHICLE_EQUIP_TYPE_ICON_UV[vehicleTypeGroup] then
    _PA_ASSERT(false, "ServantInfo_ALL \236\158\165\235\185\132 \236\149\132\236\157\180\236\189\152 \235\170\169\235\161\157\236\151\144 \236\151\134\235\138\148 vehicleType" .. "(" .. tostring(vehicleType) .. ") \236\158\133\235\139\136\235\139\164. \236\182\148\234\176\128\234\176\128 \237\149\132\236\154\148\237\149\152\236\167\128 \236\149\138\236\157\128\236\167\128 \237\153\149\236\157\184\235\176\148\235\158\141\235\139\136\235\139\164..")
    return
  end
  if nil == Util.VEHICLE_PEARLEQUIP_TYPE_ICON_UV[vehicleTypeGroup] then
    _PA_ASSERT(false, "ServantInfo_ALL \237\142\132\236\158\165\235\185\132 \236\149\132\236\157\180\236\189\152 \235\170\169\235\161\157\236\151\144 \236\151\134\235\138\148 vehicleType" .. "(" .. tostring(vehicleType) .. ") \236\158\133\235\139\136\235\139\164. \236\182\148\234\176\128\234\176\128 \237\149\132\236\154\148\237\149\152\236\167\128 \236\149\138\236\157\128\236\167\128 \237\153\149\236\157\184\235\176\148\235\158\141\235\139\136\235\139\164..")
    return
  end
  if nil == Util.VEHICLE_EQUIP_TYPE_TEXTURE_PATH[vehicleTypeGroup] then
    _PA_ASSERT(false, "ServantInfo_ALL \237\133\141\236\138\164\236\178\152 \235\170\169\235\161\157\236\151\144 \236\151\134\235\138\148 vehicleType" .. "(" .. tostring(vehicleType) .. ") \236\158\133\235\139\136\235\139\164. \236\182\148\234\176\128\234\176\128 \237\149\132\236\154\148\237\149\152\236\167\128 \236\149\138\236\157\128\236\167\128 \237\153\149\236\157\184\235\176\148\235\158\141\235\139\136\235\139\164..")
    return
  end
  for slotNo = 1, self._SERVANT_EQUIP_SLOT_COUNT do
    if nil == self._ui._servantEquipSlotList[slotNo] then
      return
    end
    local slotControl = self._ui._servantEquipSlotList[slotNo]._slotControl
    if nil == slotControl then
      return
    end
    local iconControl = self._ui._servantEquipSlotList[slotNo]._iconControl
    if nil == iconControl then
      return
    end
    local uvTable = Util.VEHICLE_EQUIP_TYPE_ICON_UV[vehicleTypeGroup]
    local texturePath = Util.VEHICLE_EQUIP_TYPE_TEXTURE_PATH[vehicleTypeGroup]
    if nil ~= uvTable[slotNo] then
      if slotNo == 6 then
        iconControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Equip_Life_Icon_RingMenu_Off_FishingRod_Normal", 0)
        iconControl:setRenderTexture(iconControl:getBaseTexture())
      else
        iconControl:ChangeTextureInfoNameAsync(texturePath)
        local x1, y1, x2, y2 = setTextureUV_Func(iconControl, uvTable[slotNo].x1, uvTable[slotNo].y1, uvTable[slotNo].x2, uvTable[slotNo].y2)
        iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
        iconControl:setRenderTexture(iconControl:getBaseTexture())
      end
    else
      slotControl:SetShow(false)
    end
    slotControl:SetShow(true)
  end
  for slotNo = 1, self._SERVANT_PEARL_EQUIP_SLOT_COUNT do
    if nil == self._ui._servantPearlEquipSlotList[slotNo] then
      return
    end
    local slotControl = self._ui._servantPearlEquipSlotList[slotNo]._slotControl
    if nil == slotControl then
      return
    end
    local iconControl = self._ui._servantPearlEquipSlotList[slotNo]._iconControl
    if nil == iconControl then
      return
    end
    local uvTable = Util.VEHICLE_PEARLEQUIP_TYPE_ICON_UV[vehicleTypeGroup]
    local texturePath = Util.VEHICLE_EQUIP_TYPE_TEXTURE_PATH[vehicleTypeGroup]
    if nil ~= uvTable[slotNo] then
      iconControl:ChangeTextureInfoNameAsync(texturePath)
      local x1, y1, x2, y2 = setTextureUV_Func(iconControl, uvTable[slotNo].x1, uvTable[slotNo].y1, uvTable[slotNo].x2, uvTable[slotNo].y2)
      iconControl:getBaseTexture():setUV(x1, y1, x2, y2)
      iconControl:setRenderTexture(iconControl:getBaseTexture())
      slotControl:SetShow(true)
    else
      slotControl:SetShow(false)
    end
  end
end
function PaGlobal_ServantInfo_All:setKeyguide()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if true == self._isConsole then
    local keyguide = {
      self._ui._stc_ConsoleKeyGuideY,
      self._ui._stc_ConsoleKeyGuideX
    }
    self._ui._keyguides = keyguide
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self._ui._keyguides, self._ui._stc_ConsoleKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ServantInfo_All:setSkillManagement(isOn)
  if true == isOn then
    self._ui._btn_SkillManagerBg:SetShow(true)
    self._ui._btn_SkillManager:SetShow(true)
  else
    self._ui._btn_SkillManagerBg:SetShow(false)
    self._ui._btn_SkillManager:SetShow(false)
  end
end
function PaGlobal_ServantInfo_All:switchEquipInvenConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if true == isConsole then
    self._ui._btn_servantEquipInvenClose:SetShow(false)
  else
    self._ui._btn_servantEquipInvenClose:SetShow(true)
  end
end
function PaGlobal_ServantInfo_All:createUserInvenSlot()
  self._ui.stc_categoryBG = self._ui._stc_userInventoryBG_inStable
  self._ui.frame_category = UI.getChildControl(self._ui.stc_categoryBG, "Frame_CategoryInven")
  self._ui.frame_categoryContent = UI.getChildControl(self._ui.frame_category, "Frame_1_Content")
  self._ui.frame_categoryVerticalScroll = UI.getChildControl(self._ui.frame_category, "Frame_1_VerticalScroll")
  self._ui.stc_categoryGroup = UI.getChildControl(self._ui.frame_categoryContent, "Static_Group")
  self._ui.txt_categoryTitle = UI.getChildControl(self._ui.stc_categoryGroup, "StaticText_GroupTitle")
  self._ui.txt_noItem = UI.getChildControl(self._ui.frame_categoryContent, "StaticText_No_Itemlog")
  local tmp_userInvenSlotBG = UI.getChildControl(self._ui.stc_categoryGroup, "Static_ItemSlotBg")
  self._ui.stc_categoryGroup:SetShow(false)
  self._ui.txt_noItem:SetShow(false)
  for servantType = 0, self._ENUM_SERVANT_TYPE._COUNT - 1 do
    self._ui.categoryList[servantType] = {}
    for equipSlotNo = 0, __eEquipSlotNoCount - 1 do
      local titleText = PaGlobal_ServantInfo_All:GetEquipSlotName(servantType, equipSlotNo)
      if titleText ~= nil then
        local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_categoryContent, "Static_Group", self._ui.frame_categoryContent, "CategoryGroup_" .. servantType .. equipSlotNo)
        if tempContent ~= nil then
          local tempTitleName = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "StaticText_GroupTitle", tempContent, "StaticText_GroupTitle_" .. equipSlotNo)
          local tempDeco = UI.createAndCopyBasePropertyControl(self._ui.stc_categoryGroup, "Static_DecoLine", tempContent, "StaticText_GroupDeco_" .. equipSlotNo)
          self._ui.categoryList[servantType][equipSlotNo] = {}
          self._ui.categoryList[servantType][equipSlotNo].content = tempContent
          self._ui.categoryList[servantType][equipSlotNo].titleName = tempTitleName
          self._ui.categoryList[servantType][equipSlotNo].titleName:SetText(titleText)
          self._ui.categoryList[servantType][equipSlotNo].deco = tempDeco
          self._ui.categoryList[servantType][equipSlotNo].content:SetShow(false)
        end
      end
    end
  end
  local slotSizeX = 50
  local slotSizeY = 50
  for slotNo = 0, self._USERINVENTORY_CONFIG.maxSize - 1 do
    local slot = {}
    local slotBackground = UI.createControl(__ePAUIControl_Static, self._ui.frame_categoryContent, "Inventory_Slot_BG_" .. slotNo)
    SlotItem.new(slot, "UserInvenOnlyServantEquip_" .. slotNo, slotNo, self._ui.frame_categoryContent, self._USERINVENTORY_SLOT_CONFIG)
    slot:createChild()
    slot.icon:SetShow(false)
    slot.isEmpty = true
    slot.background = slotBackground
    CopyBaseProperty(tmp_userInvenSlotBG, slot.background)
    slot.background:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
    slot.background:SetShow(false)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.classEquipBG:ChangeTextureInfoNameAsync("new_ui_common_forlua/window/inventory/Disable_Class.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slot.classEquipBG, 1, 1, 12, 12)
    slot.classEquipBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slot.classEquipBG:setRenderTexture(slot.classEquipBG:getBaseTexture())
    slot.itemLock:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Icon_00.dds")
    x1, y1, x2, y2 = setTextureUV_Func(slot.itemLock, 116, 1, 134, 20)
    slot.itemLock:getBaseTexture():setUV(x1, y1, x2, y2)
    slot.itemLock:setRenderTexture(slot.itemLock:getBaseTexture())
    slot.icon:setPadSnapType(__ePadSnapType_Target)
    slot.icon:setPadSnapIndex(0)
    slot.icon:SetAutoDisableTime(1)
    self._userInvenSlot[slotNo] = slot
  end
end
function PaGlobal_ServantInfo_All:GetServantWrapper(servantNo, slotType)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return nil
  end
  local servantInfo
  if 0 == slotType then
    if true == PaGlobalFunc_ServantFunction_All_GetIsGuild() then
      servantInfo = guildStable_getServant(servantNo)
    elseif PaGlobal_ServantList_All:isCrogdaloServant(servantNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(servantNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    else
      servantInfo = stable_getServant(servantNo)
    end
  elseif 1 == slotType then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if nil == temporaryWrapper then
      return nil
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  end
  return servantInfo
end
function PaGlobal_ServantInfo_All:updateUserInvenSlot()
  if Panel_Dialog_ServantInfo_All == nil then
    return
  end
  if _ContentsGroup_SealedServantEquip == false or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_SEA or self._currentNpcType == self._ENUM_NPC_TYPE._GUILD_LAND then
    self._ui._chk_viewInven:SetShow(false)
    self._ui._stc_userInventory_inStable:SetShow(false)
    return
  end
  local sealed = 0
  local unsealed = 1
  local servantInfo = PaGlobal_ServantInfo_All:GetServantWrapper(self._currentVehicleIndexNo, self._currentSlotType)
  if servantInfo == nil then
    self._ui._chk_viewInven:SetShow(false)
    self._ui._stc_userInventory_inStable:SetShow(false)
    return
  end
  if PaGlobal_ServantInfo_All._currentSlotType == sealed then
    local regionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
    local regionName = regionInfo:getAreaName()
    if servantInfo:getRegionName() ~= regionName or servantInfo:isChangingRegion() == true then
      self._ui._chk_viewInven:SetShow(false)
      self._ui._stc_userInventory_inStable:SetShow(false)
      return
    end
    local hasRentOwnerFlag = Defines.s64_const.s64_0 < servantInfo:getRentOwnerNo()
    local servantState = servantInfo:getStateType()
    local isPcroomOnly = servantInfo:isPcroomOnly()
    local isMatingComplete = servantInfo:isMatingComplete()
    if servantInfo:isSeized() == true or servantState ~= CppEnums.ServantStateType.Type_Stable or isPcroomOnly == true or isMatingComplete == true or hasRentOwnerFlag == true then
      self._ui._chk_viewInven:SetShow(false)
      self._ui._stc_userInventory_inStable:SetShow(false)
      return
    end
  end
  if self._ui._chk_viewInven:IsCheck() == false then
    self._ui._stc_userInventory_inStable:SetShow(false)
  end
  local selfPlayer = getSelfPlayer():get()
  local invenWhereType = ServantInfo_All_UserInventory_GetCurrentType()
  local inventory = selfPlayer:getInventoryByType(invenWhereType)
  local inventoryUseSize = inventory:size()
  local servantEquipCount = 0
  local inventoryColSize = self._USERINVENTORY_CONFIG.col
  local startRow = math.floor(self._userInvenStartSlot / inventoryColSize)
  self._ui.txt_noItem:SetShow(false)
  for slotNo = 0, self._USERINVENTORY_CONFIG.maxSize - 1 do
    if self._userInvenSlot[slotNo] ~= nil then
      self._userInvenSlot[slotNo].isEmpty = true
      self._userInvenSlot[slotNo]:clearItem(true)
      self._userInvenSlot[slotNo].icon:addInputEvent("Mouse_On", "")
      self._userInvenSlot[slotNo].icon:addInputEvent("Mouse_Out", "")
      self._userInvenSlot[slotNo].icon:addInputEvent("Mouse_RUp", "")
      self._userInvenSlot[slotNo].icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      self._userInvenSlot[slotNo].background:SetShow(false)
      self._userInvenSlot[slotNo].icon:SetShow(false)
    end
  end
  for servantType = 0, self._ENUM_SERVANT_TYPE._COUNT - 1 do
    for ii = 0, __eEquipSlotNoCount - 1 do
      if self._ui.categoryList[servantType][ii] ~= nil then
        self._ui.categoryList[servantType][ii].content:SetShow(false)
      end
    end
  end
  local sortInvenType
  if invenWhereType == CppEnums.ItemWhereType.eInventory then
    sortInvenType = __eInventorySortWhereType_Inventory
  else
    sortInvenType = __eInventorySortWhereType_CashInventoryForCharacter
  end
  selfPlayer:sortInventorySlotNoNew(sortInvenType, __eInventorySortPropertyType_Auto, __eInventorySortByType_Ascending)
  local sortedList = {}
  local categoryStartPosY = 0
  local groupItemSlotIndex = 0
  local itemSlotIndex = 0
  local itemStartPosY = 20
  local categorySizeY = 40
  local categoryWeight = 0
  local itemWrapper
  for servantType = 0, self._ENUM_SERVANT_TYPE._COUNT - 1 do
    sortedList[servantType] = {}
  end
  local noItem = true
  for slotNo = 0, inventoryUseSize do
    local realInvenSlotNo = selfPlayer:getRealInventorySlotNoNew(sortInvenType, slotNo)
    itemWrapper = getInventoryItemByType(invenWhereType, realInvenSlotNo)
    if itemWrapper ~= nil then
      local itemisProper = false
      if self._currentNpcType == self._ENUM_NPC_TYPE._SEA and isEquipForSeaVehicle(itemWrapper) == true then
        itemisProper = true
      elseif self._currentNpcType == self._ENUM_NPC_TYPE._LAND and isEquipForLandVehicle(itemWrapper) == true then
        itemisProper = true
      end
      if itemisProper == true then
        local itemSSW = itemWrapper:getStaticStatus()
        local equipSlotNo = itemSSW:getEquipSlotNo()
        local servantEquipType = GetItemEquipServantType(itemWrapper)
        if servantEquipType ~= nil then
          noItem = false
          if sortedList[servantEquipType][equipSlotNo] == nil then
            sortedList[servantEquipType][equipSlotNo] = {}
          end
          sortedList[servantEquipType][equipSlotNo][#sortedList[servantEquipType][equipSlotNo] + 1] = realInvenSlotNo
          sortedList[servantEquipType][equipSlotNo]._categoryType = equipSlotNo
        end
      end
    end
  end
  ToClient_padSnapIgnoreMoveToThisControl(self._ui.frame_category, false)
  if noItem == true then
    self._ui.txt_noItem:SetShow(true)
    self._ui.frame_categoryVerticalScroll:SetShow(false)
    self._ui.frame_categoryContent:SetSize(self._ui.frame_categoryContent:GetSizeX(), self._ui.frame_category:GetSizeY())
    ToClient_padSnapIgnoreMoveToThisControl(self._ui.frame_category, true)
    return
  end
  for servantEquipType = 0, self._ENUM_SERVANT_TYPE._COUNT - 1 do
    for equipSlotNo = 0, __eEquipSlotNoCount - 1 do
      if sortedList[servantEquipType][equipSlotNo] ~= nil then
        local categoryType = sortedList[servantEquipType][equipSlotNo]._categoryType
        self._ui.categoryList[servantEquipType][categoryType].content:SetShow(true)
        self._ui.categoryList[servantEquipType][categoryType].content:SetSpanSize(0, categoryStartPosY + 10)
        groupItemSlotIndex = 0
        for index, realSlotNo in ipairs(sortedList[servantEquipType][equipSlotNo]) do
          itemWrapper = getInventoryItemByType(invenWhereType, realSlotNo)
          if itemWrapper ~= nil then
            local slot = self._userInvenSlot[realSlotNo]
            slot:clearItem(true)
            slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
            slot:setItem(itemWrapper, realSlotNo)
            slot.isEmpty = false
            local row = math.floor(groupItemSlotIndex / self._USERINVENTORY_CONFIG.col)
            local col = groupItemSlotIndex % self._USERINVENTORY_CONFIG.col
            local itemPosY = self._ui.categoryList[servantEquipType][categoryType].content:GetPosY() + categorySizeY
            slot.icon:SetPosX(self._USERINVENTORY_CONFIG.startPosX + self._USERINVENTORY_CONFIG.slotGapX * col)
            slot.icon:SetPosY(itemPosY + self._USERINVENTORY_CONFIG.slotGapY * row)
            slot.icon:SetShow(true)
            slot.background:SetPosX(slot.icon:GetPosX())
            slot.background:SetPosY(slot.icon:GetPosY())
            slot.background:SetShow(true)
            local itemSSW = itemWrapper:getStaticStatus()
            if itemSSW ~= nil then
              local itemStatic = itemSSW:get()
              if itemStatic:isServantTypeUsable(servantInfo:getServantKind(), servantInfo:getServantKindSub()) == false then
                slot.classEquipBG:SetShow(true)
                if _ContentsGroup_ChinaFontColor == true then
                  slot.icon:SetColor(Defines.Color.C_FF6195BD)
                else
                  slot.icon:SetColor(Defines.Color.C_FFD20000)
                end
              end
              if ToClient_isLockItem(itemWrapper:getItemNoRaw()) == true then
                slot.itemLock:SetShow(true)
              else
                slot.itemLock:SetShow(false)
              end
              local itemKey = itemSSW:get()._key
              if itemKey ~= nil then
                slot.icon:addInputEvent("Mouse_On", "HandleEventOn_ServantInfo_All_ItemWrapperToolTip(" .. realSlotNo .. ",true)")
                slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_ServantInfo_All_ItemWrapperToolTip(" .. realSlotNo .. ",false)")
                slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ServantInfo_All_EquipFromInventory(" .. realSlotNo .. ")")
                slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ServantInfo_All_EquipFromInventory(" .. realSlotNo .. ")")
              end
            end
            groupItemSlotIndex = groupItemSlotIndex + 1
            itemStartPosY = slot.icon:GetPosY()
            categoryStartPosY = itemStartPosY + categorySizeY
          end
        end
      end
    end
  end
  self._ui.frame_category:UpdateContentScroll()
  self._ui.frame_category:UpdateContentPos()
  self._ui.frame_categoryVerticalScroll:SetShow(false)
  self._ui.frame_categoryContent:SetSize(self._ui.frame_categoryContent:GetSizeX(), categoryStartPosY + 10)
  if categoryStartPosY > self._ui.frame_category:GetSizeY() then
    self._ui.frame_categoryVerticalScroll:SetShow(true)
    self._ui.frame_categoryVerticalScroll:SetInterval(self._ui.frame_categoryContent:GetSizeY() * 0.01 * 1.1)
  end
end
function PaGlobal_ServantInfo_All:ShowEquipInven(isShow)
  if nil == isShow then
    self._ui._txt_viewInven:SetFontColor(4292390256)
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  local autoWrapOK = self._ui._txt_viewInven:IsLimitText() == true
  if true == isShow then
    if autoWrapOK == true then
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_SERVANTINFO_HASEQUIP")
      control = self._ui._chk_viewInven
      TooltipSimple_Show(control, name, desc)
    else
      self._ui._txt_viewInven:SetFontColor(4294962644)
    end
  end
end
function PaGlobal_ServantInfo_All:updateSelectBar()
  if self._ui._rdo_userInventory_normal:IsChecked() == true then
    self._ui._stc_userInventory_selectBar:SetSpanSize(self._ui._rdo_userInventory_normal:GetPosX() + (self._ui._rdo_userInventory_normal:GetSizeX() - self._ui._stc_userInventory_selectBar:GetSizeX()) * 0.5, self._ui._stc_userInventory_selectBar:GetSpanSize().y)
  else
    self._ui._stc_userInventory_selectBar:SetSpanSize(self._ui._rdo_userInventory_pearl:GetPosX() + (self._ui._rdo_userInventory_pearl:GetSizeX() - self._ui._stc_userInventory_selectBar:GetSizeX()) * 0.5, self._ui._stc_userInventory_selectBar:GetSpanSize().y)
  end
end
function PaGlobal_ServantInfo_All:GetEquipSlotName(type, equipSlotNo)
  if type == nil or equipSlotNo == nil then
    return
  end
  if type == self._ENUM_SERVANT_TYPE._HORSE then
    return self._SERVANT_KIND_TYPESTRING[0][equipSlotNo]
  elseif type == self._ENUM_SERVANT_TYPE._CARRIAGE then
    return self._SERVANT_KIND_TYPESTRING[1][equipSlotNo]
  elseif type == self._ENUM_SERVANT_TYPE._ELEPHANT then
    return self._SERVANT_KIND_TYPESTRING[2][equipSlotNo]
  elseif type == self._ENUM_SERVANT_TYPE._SHIP then
    return self._SERVANT_KIND_TYPESTRING[3][equipSlotNo]
  elseif type == self._ENUM_SERVANT_TYPE._OCEANSHIP then
    return self._SERVANT_KIND_TYPESTRING[4][equipSlotNo]
  end
end
function PaGlobal_ServantInfo_All:categoryScrollTop()
  self._ui.frame_categoryVerticalScroll:SetInterval(self._ui.frame_categoryContent:GetSizeY() * 0.01 * 1.1)
  self._ui.frame_categoryVerticalScroll:SetControlTop()
  self._ui.frame_category:UpdateContentScroll()
  self._ui.frame_category:UpdateContentPos()
end
