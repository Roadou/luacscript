function PaGlobal_AlchemyStone_Renewal_All:initialize()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_Window_AlchemyStone_All, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Close")
  self._ui._btn_question = UI.getChildControl(self._ui._stc_title, "Button_Question")
  self._ui._stc_radioGroup = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_RadioGroup")
  self._ui._txt_lb_console = UI.getChildControl(self._ui._stc_radioGroup, "StaticText_LB_ConsoleUI")
  self._ui._txt_rb_console = UI.getChildControl(self._ui._stc_radioGroup, "StaticText_RB_ConsoleUI")
  self._ui._rdo_tab_charge = UI.getChildControl(self._ui._stc_radioGroup, "RadioButton_Tab_Charge")
  self._ui._rdo_tab_upgrade = UI.getChildControl(self._ui._stc_radioGroup, "RadioButton_Tab_Upgrade")
  self._ui._stc_selectBar = UI.getChildControl(self._ui._stc_radioGroup, "Static_SelectBar")
  local stc_guideBG = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_GuideBG")
  self._ui._txt_multiline = UI.getChildControl(stc_guideBG, "MultilineText_Text")
  self._ui._stc_chargeBG = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_RechargeBG")
  self._ui._stc_charge = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_Recharge")
  self._ui._stc_chargeSlotLeft = UI.getChildControl(self._ui._stc_charge, "Static_Slot_Left")
  self._ui._stc_chargeSlotRight = UI.getChildControl(self._ui._stc_charge, "Static_Slot_Right")
  self._ui._txt_needItem = UI.getChildControl(self._ui._stc_charge, "StaticText_NeedITem")
  self._ui._txt_durability = UI.getChildControl(self._ui._stc_charge, "StaticText_Durability")
  self._ui._stc_upgradeBG = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_PolishBG")
  self._ui._stc_upgrade = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_Polish")
  self._ui._txt_exp = UI.getChildControl(self._ui._stc_upgrade, "MultilineText_Exp")
  self._ui._circular_gauge = UI.getChildControl(self._ui._stc_upgrade, "CircularProgress_Guage")
  self._ui._stc_upgradeSlotLeft = UI.getChildControl(self._ui._stc_upgrade, "Static_Slot_1")
  self._ui._stc_upgradeSlotRight = UI.getChildControl(self._ui._stc_upgrade, "Static_Slot_2")
  self._ui._progress_stack = UI.getChildControl(self._ui._stc_upgrade, "Progress2_Stack")
  self._ui._txt_stack = UI.getChildControl(self._ui._stc_upgrade, "StaticText_Stack")
  self._ui._stc_stackEffect = UI.getChildControl(self._ui._stc_upgrade, "Static_StackEffect")
  self._ui._chk_skipAni = UI.getChildControl(Panel_Window_AlchemyStone_All, "CheckButton_SkipAni")
  local txt_skipAni = UI.getChildControl(self._ui._chk_skipAni, "StaticText_SkipAni")
  self._ui._chk_skipAni:SetEnableArea(0, 0, self._ui._chk_skipAni:GetSizeX() + txt_skipAni:GetTextSizeX() + 10, self._ui._chk_skipAni:GetSizeY())
  self._ui._btn_charge = UI.getChildControl(Panel_Window_AlchemyStone_All, "Button_Charge")
  self._ui._stc_descBG = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_DescBG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_Desc")
  self._ui._stc_result = UI.getChildControl(Panel_Window_AlchemyStone_All, "Static_Result")
  self._ui._stc_resultIemNameBG = UI.getChildControl(self._ui._stc_result, "Static_ItemNameBG")
  self._ui._txt_result = UI.getChildControl(self._ui._stc_resultIemNameBG, "StaticText_Success")
  self._ui._txt_resultItemName = UI.getChildControl(self._ui._stc_resultIemNameBG, "StaticText_ItemName")
  self._ui._stc_resultItemSlotBG = UI.getChildControl(self._ui._stc_result, "Static_ItemSlotBG")
  self._ui._stc_resultItemSlot = UI.getChildControl(self._ui._stc_resultItemSlotBG, "Static_ItemSlot")
  self._ui._txt_resultDesc = UI.getChildControl(self._ui._stc_result, "StaticText_ResultDesc")
  self._ui._stc_consoleKeyGuide = UI.getChildControl(Panel_Window_AlchemyStone_All, "StaticText_ConsoleGuide")
  self._ui._keyGuideA = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_Confirm")
  self._ui._keyGuideB = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_Close")
  self._ui._keyGuideX = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_ShowDetail")
  self._ui._keyGuideY = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_SkipAnimation")
  SlotItem.new(self._chargeSlot[0], "stc_chargeSlotLeft", 0, self._ui._stc_chargeSlotLeft, self._slotConfig)
  self._chargeSlot[0]:createChild()
  self._chargeSlot[0].Empty = true
  self._chargeSlot[0]:clearItem()
  SlotItem.new(self._chargeSlot[1], "stc_chargeSlotRight", 0, self._ui._stc_chargeSlotRight, self._slotConfig)
  self._chargeSlot[1]:createChild()
  self._chargeSlot[1].Empty = true
  self._chargeSlot[1]:clearItem()
  SlotItem.new(self._upgradeSlot[0], "stc_upgradeSlotLeft", 0, self._ui._stc_upgradeSlotLeft, self._slotConfig)
  self._upgradeSlot[0]:createChild()
  self._upgradeSlot[0].Empty = true
  self._upgradeSlot[0]:clearItem()
  SlotItem.new(self._upgradeSlot[1], "stc_upgradeSlotRight", 0, self._ui._stc_upgradeSlotRight, self._slotConfig)
  self._upgradeSlot[1]:createChild()
  self._upgradeSlot[1].Empty = true
  self._upgradeSlot[1]:clearItem()
  SlotItem.new(self._evolveResultSlot[0], "_evolveResultSlot", 0, self._ui._stc_resultItemSlot, self._slotConfig)
  self._evolveResultSlot[0]:createChild()
  self._evolveResultSlot[0].Empty = true
  self._evolveResultSlot[0]:clearItem()
  self._originPanelSizeY = Panel_Window_AlchemyStone_All:GetSizeY()
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self:registEventHandler()
  self:validate()
  self:setConsole()
  self._initialize = true
end
function PaGlobal_AlchemyStone_Renewal_All:registEventHandler()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_Renewal_All_Close()")
  self._ui._rdo_tab_charge:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(0)")
  self._ui._rdo_tab_upgrade:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(1)")
  if self._isPadSnapping == true then
    Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(0)")
    Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobalFunc_AlchemyStone_Renewal_All_SelectTab(1)")
    Panel_Window_AlchemyStone_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_AlchemyStone_Renewal_All_CheckSkipAni()")
    self._ui._stc_chargeSlotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(2)")
    self._ui._stc_chargeSlotRight:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(1)")
    self._ui._stc_upgradeSlotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(2)")
    self._ui._stc_upgradeSlotRight:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(1)")
    self._ui._stc_chargeSlotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 0)")
    self._ui._stc_chargeSlotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 1)")
    self._ui._stc_upgradeSlotLeft:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 0)")
    self._ui._stc_upgradeSlotRight:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 1)")
    self._ui._stc_resultItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 2)")
    self._chargeSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(0)")
    self._upgradeSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(0)")
    self._chargeSlot[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(1)")
    self._upgradeSlot[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(1)")
    self._ui._chk_skipAni:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(2)")
    self._ui._btn_charge:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(2)")
    self._evolveResultSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_SetKeyGuide(3)")
  else
    self._chargeSlot[0].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(2)")
    self._chargeSlot[1].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(1)")
    self._upgradeSlot[0].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(2)")
    self._upgradeSlot[1].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_AlchemyStone_Renewal_All_ClearItemSlot(1)")
    self._chargeSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 0)")
    self._chargeSlot[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 1)")
    self._upgradeSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 0)")
    self._upgradeSlot[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 1)")
    self._evolveResultSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(true, 2)")
  end
  self._chargeSlot[0].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(false)")
  self._chargeSlot[1].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(false)")
  self._upgradeSlot[0].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(false)")
  self._upgradeSlot[1].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(false)")
  self._evolveResultSlot[0].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStone_Renewal_All_ItemToolTip(false)")
  registerEvent("FromClient_AlchemyRepair", "FromClient_AlchemyStone_Renewal_All_Charge")
  registerEvent("FromClient_ItemUpgrade", "FromClient_AlchemyStone_Renewal_All_Upgrade")
  registerEvent("FromClient_AlchemyEvolve", "FromClient_AlchemyStone_Renewal_All_EvolveResult")
  Panel_Window_AlchemyStone_All:RegisterUpdateFunc("PaGlobalFunc_AlchemyStone_Renewal_All_UpdateTime")
end
function PaGlobal_AlchemyStone_Renewal_All:prepareOpen()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if _ContentsGroup_AlchemyStoneRenewal == false then
    return
  end
  PaGlobalFunc_AlchemyStone_Renewal_All_PreCheckOtherUI()
  if _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_AlchemyStone_All)
  else
    FGlobal_SetInventoryDragNoUse(Panel_Window_AlchemyStone_All)
  end
  if _ContentsGroup_NewUI_Inventory_All == true then
    if Panel_Window_Inventory_All:IsUISubApp() == true then
      Panel_Window_AlchemyStone_All:OpenUISubApp()
    end
  elseif Panel_Window_Inventory:IsUISubApp() == true then
    Panel_Window_AlchemyStone_All:OpenUISubApp()
  end
  self._currentTab = self._eTab._charge
  self:clearItemSlot()
  self:update()
  self:setPosition()
  if self._isPadSnapping == false then
    if _ContentsGroup_NewUI_Equipment_All == true then
      if Panel_Window_Equipment_All:GetShow() then
        PaGlobalFunc_Equipment_All_Close(false)
      end
    elseif Panel_Equipment:GetShow() == true then
      EquipmentWindow_Close()
    end
    if _ContentsGroup_NewUI_ClothInventory_All == true or _ContentsGroup_RenewUI == true then
      PaGlobalFunc_ClothInventory_All_Close()
    else
      ClothInventory_Close()
    end
  end
  InventoryWindow_Show()
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_Renewal_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_Renewal_All_InvenStoneRClick, nil, nil)
  if PaGlobalFunc_PreOrder_Close ~= nil then
    PaGlobalFunc_PreOrder_Close(Panel_Window_AlchemyStone_All, false)
  end
  self:selectNormalInventoryTab()
  self:open()
end
function PaGlobal_AlchemyStone_Renewal_All:open()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  Panel_Window_AlchemyStone_All:SetShow(true)
end
function PaGlobal_AlchemyStone_Renewal_All:prepareClose()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self:clearItemSlot()
  self:clearEffect()
  Inventory_SetFunctor(nil, nil, nil, nil)
  local isInvenOpen = false
  if _ContentsGroup_NewUI_Inventory_All == true then
    isInvenOpen = Panel_Window_Inventory_All:GetShow()
  else
    isInvenOpen = Panel_Window_Inventory:GetShow()
  end
  if isInvenOpen == true then
    if _ContentsGroup_RenewUI_InventoryEquip == false then
      if _ContentsGroup_NewUI_Equipment_All == true then
        PaGlobalFunc_Equipment_All_SetShow(true)
      else
        Equipment_SetShow(true)
      end
    else
      PaGlobalFunc_InventoryInfo_Close()
    end
  end
  if ToClient_isConsole() == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self:clearAudioEffect()
  self:close()
end
function PaGlobal_AlchemyStone_Renewal_All:close()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  Panel_Window_AlchemyStone_All:SetShow(false)
end
function PaGlobal_AlchemyStone_Renewal_All:setPosition()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if self._isPadSnapping == true then
    if Panel_Window_Inventory ~= nil then
      local inventoryPanelPosX = Panel_Window_Inventory:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory:GetPosY()
      Panel_Window_AlchemyStone_All:SetPosX(inventoryPanelPosX - Panel_Window_AlchemyStone_All:GetSizeX() - 5)
      Panel_Window_AlchemyStone_All:SetPosY(inventoryPanelPosY)
    end
  elseif Panel_Window_Inventory_All ~= nil and false == Panel_Window_Inventory_All:IsUISubApp() then
    local inventoryPanelPosX = Panel_Window_Inventory_All:GetPosX()
    local inventoryPanelPosY = Panel_Window_Inventory_All:GetPosY()
    local posX = inventoryPanelPosX - Panel_Window_AlchemyStone_All:GetSizeX() - 5
    if posX < 0 then
      posX = inventoryPanelPosX + Panel_Window_Inventory_All:GetSizeX() + 5
    end
    Panel_Window_AlchemyStone_All:SetPosX(posX)
    Panel_Window_AlchemyStone_All:SetPosY(inventoryPanelPosY)
  end
end
function PaGlobal_AlchemyStone_Renewal_All:setConsole()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if self._isPadSnapping == true then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_question:SetShow(false)
    self._ui._txt_lb_console:SetShow(true)
    self._ui._txt_rb_console:SetShow(true)
    self._ui._stc_consoleKeyGuide:SetShow(true)
  else
    self._ui._btn_close:SetShow(true)
    self._ui._btn_question:SetShow(true)
    self._ui._txt_lb_console:SetShow(false)
    self._ui._txt_rb_console:SetShow(false)
    self._ui._stc_consoleKeyGuide:SetShow(false)
  end
end
function PaGlobal_AlchemyStone_Renewal_All:update()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self._ui._stc_chargeBG:SetShow(false)
  self._ui._stc_charge:SetShow(false)
  self._ui._stc_upgradeBG:SetShow(false)
  self._ui._stc_upgrade:SetShow(false)
  self._ui._rdo_tab_charge:SetCheck(false)
  self._ui._rdo_tab_upgrade:SetCheck(false)
  self._ui._btn_charge:addInputEvent("Mouse_LUp", "")
  self._ui._btn_charge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADE"))
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  local alchemystoneExp = 0
  local materialNeedCount = 0
  if self._currentTab == self._eTab._charge then
    self._ui._stc_chargeBG:SetShow(true)
    self._ui._stc_charge:SetShow(true)
    self._ui._rdo_tab_charge:SetCheck(true)
    self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_ENCHANT_RECHARGE_TEXT"))
    self._ui._stc_selectBar:SetPosX(self._ui._rdo_tab_charge:GetPosX() + self._ui._rdo_tab_charge:GetSizeX() / 2 - self._ui._stc_selectBar:GetSizeX() / 2)
    self._ui._btn_charge:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_Renewal_All_ChargeCheckAnimation()")
    self._ui._btn_charge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE"))
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RENEWAL_BOTTOM_DESC1"))
    self._ui._stc_descBG:SetSize(self._ui._stc_descBG:GetSizeX(), self._ui._txt_desc:GetTextSizeY() + 10)
    self._ui._txt_desc:ComputePos()
    self._ui._txt_durability:SetText("")
    self._ui._txt_needItem:SetText("")
    if self._materialItemCount ~= nil then
      local itemSSW = getItemEnchantStaticStatus(self._materialItemKey)
      if itemSSW ~= nil then
        self._chargeSlot[0]:setItemByStaticStatus(itemSSW, self._materialItemCount, nil, nil, nil)
        self._chargeSlot[0].Empty = false
      end
    else
      self._chargeSlot[0]:clearItem()
      self._chargeSlot[0].Empty = true
      self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_ENCHANT_RECHARGE_GUIDE"))
    end
    if self._alchemyStoneWhereType ~= nil then
      local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
      if itemSSW ~= nil then
        self._chargeSlot[1]:setItemByStaticStatus(itemSSW, 1, nil, nil, nil)
        self._chargeSlot[1].Empty = false
        materialNeedCount = itemSSW:get()._contentsEventParam2 + 1
        self._ui._txt_needItem:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DESC_5", "needCountMin", materialNeedCount))
      end
      local itemWrapper = getInventoryItemByType(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
      if itemWrapper ~= nil then
        local currentEndurance = itemWrapper:get():getEndurance()
        local maxEndurance = itemWrapper:get():getMaxEndurance()
        self._ui._txt_durability:SetText(currentEndurance .. "/" .. maxEndurance)
      end
    else
      self._chargeSlot[1]:clearItem()
      self._chargeSlot[1].Empty = true
      self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RENEWAL_GUIDE_DESC1"))
    end
  elseif self._currentTab == self._eTab._upgrade then
    self._ui._stc_upgradeBG:SetShow(true)
    self._ui._stc_upgrade:SetShow(true)
    self._ui._rdo_tab_upgrade:SetCheck(true)
    self._ui._stc_selectBar:SetPosX(self._ui._rdo_tab_upgrade:GetPosX() + self._ui._rdo_tab_upgrade:GetSizeX() / 2 - self._ui._stc_selectBar:GetSizeX() / 2)
    self._ui._btn_charge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXP"))
    self._ui._btn_charge:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_Renewal_All_UpgradeCheckAnimation()")
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RENEWAL_BOTTOM_DESC2"))
    self._ui._stc_descBG:SetSize(self._ui._stc_descBG:GetSizeX(), self._ui._txt_desc:GetTextSizeY() + 10)
    self._ui._txt_desc:ComputePos()
    self._ui._txt_exp:SetText("")
    self._ui._circular_gauge:SetProgressRate(0)
    self._ui._txt_stack:SetText("")
    self._ui._progress_stack:SetProgressRate(0)
    self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_ENCHANT_POLISH_TEXT"))
    if self._materialItemCount ~= nil then
      local itemSSW = getItemEnchantStaticStatus(self._materialItemKey)
      if itemSSW ~= nil then
        self._upgradeSlot[0]:setItemByStaticStatus(itemSSW, self._materialItemCount, nil, nil, nil)
        self._upgradeSlot[0].Empty = false
      end
    else
      self._upgradeSlot[0]:clearItem()
      self._upgradeSlot[0].Empty = true
      self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_ENCHANT_POLISH_GUIDE"))
    end
    if self._alchemyStoneWhereType ~= nil then
      local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
      if itemSSW ~= nil then
        self._upgradeSlot[1]:setItemByStaticStatus(itemSSW, 1, nil, nil, nil)
        self._upgradeSlot[1].Empty = false
        local guaranteeEnchantMaxCount = itemSSW:getSSEnchantCount()
        local currentGuaranteeEnchantCount = itemSSW:getCurrentEnchantCount()
        local progressPercent = currentGuaranteeEnchantCount / guaranteeEnchantMaxCount * 100
        if guaranteeEnchantMaxCount > 0 then
          self._ui._progress_stack:SetProgressRate(progressPercent)
          self._ui._txt_stack:SetText(currentGuaranteeEnchantCount .. "/" .. guaranteeEnchantMaxCount)
        end
      end
      local itemWrapper = getInventoryItemByType(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
      if itemWrapper ~= nil then
        alchemystoneExp = itemWrapper:getExperience() * 1.0E-4
        self._ui._txt_exp:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE_ENTER", "exp", string.format("%.2f", alchemystoneExp)))
        self._ui._circular_gauge:SetProgressRate(alchemystoneExp)
      end
    else
      self._upgradeSlot[1]:clearItem()
      self._upgradeSlot[1].Empty = true
      self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_ENCHANT_POLISH_GUIDE_STONE"))
    end
    if alchemystoneExp > 100 and self._materialItemCount == nil then
      local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
      if itemSSW ~= nil then
        local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), 0)
        if resultItemWrapper ~= nil then
          self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_ENCHANT_GROWTH_TEXT"))
          self._ui._btn_charge:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADE"))
          self._ui._btn_charge:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStone_Renewal_All_OpenEvolve()")
        end
      end
    end
  end
  if self._alchemyStoneWhereType ~= nil and self._materialItemCount ~= nil or alchemystoneExp > 100 then
    self._ui._btn_charge:SetIgnore(false)
  else
    self._ui._btn_charge:SetIgnore(true)
  end
  if self._alchemyStoneWhereType == nil then
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_Renewal_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_Renewal_All_InvenStoneRClick, nil, nil)
  elseif self._currentTab == self._eTab._charge and (self._materialItemCount == nil or materialNeedCount > Int64toInt32(self._materialItemCount)) or self._currentTab == self._eTab._upgrade and alchemystoneExp < 150 then
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_Renewal_All_InvenMatRClick, nil, nil)
  else
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterNone, PaGlobalFunc_AlchemyStone_Renewal_All_InvenNoneRClick, nil, nil)
  end
  if self._startEffectPlay == false then
    self._ui._btn_charge:SetMonoTone(false)
    self._ui._btn_charge:SetIgnore(false)
  end
  local panelSizeY = self._originPanelSizeY + (self._ui._stc_descBG:GetSizeY() - 80)
  Panel_Window_AlchemyStone_All:SetSize(Panel_Window_AlchemyStone_All:GetSizeX(), panelSizeY)
  if self._isPadSnapping == true then
    self._ui._stc_consoleKeyGuide:SetPosY(Panel_Window_AlchemyStone_All:GetSizeY())
  end
end
function PaGlobal_AlchemyStone_Renewal_All:clearItemSlot(clearIndex)
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if clearIndex == nil then
    clearIndex = 1
  end
  if clearIndex <= 1 then
    self._alchemyStoneWhereType = nil
    self._alchemyStoneSlotNo = nil
    self._alchemyStoneType = nil
    self._alchemyStoneItemKey = nil
  end
  if clearIndex <= 2 then
    self._materialWhereType = nil
    self._materialSlotNo = nil
    self._materialItemKey = nil
    self._materialItemCount = nil
  end
end
function PaGlobal_AlchemyStone_Renewal_All:startEvolveProgressing()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self._resultItemKey = nil
  local resultItemWrapper = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if resultItemWrapper ~= nil then
    self._evolveResultSlot[0]:setItemByStaticStatus(resultItemWrapper, 1, nil, nil, nil)
    self._evolveResultSlot[0].Empty = false
  else
    self._evolveResultSlot[0]:clearItem()
    self._evolveResultSlot[0].Empty = true
  end
  self._ui._stc_resultIemNameBG:SetShow(false)
  self._ui._txt_result:SetText("")
  self._evolveEffectTime = 2.5
  self._ui._stc_resultItemSlotBG:EraseAllEffect()
  self._ui._stc_resultItemSlotBG:AddEffect("fUI_AlchemyStone_New_02A", false)
  self._audioId = audioPostEvent_SystemUi(5, 112)
  self._audioIdXbox = _AudioPostEvent_SystemUiForXBOX(5, 112)
  self._ui._stc_result:SetPosX(-Panel_Window_AlchemyStone_All:GetPosX())
  self._ui._stc_result:SetPosY(-Panel_Window_AlchemyStone_All:GetPosY())
  self._ui._stc_result:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._txt_resultDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_STONE_ENCHANT_ING_CANCEL"))
  if self._isPadSnapping == true then
    ToClient_padSnapChangeToTarget(self._ui._stc_resultItemSlot)
  end
  self._ui._stc_result:SetShow(true)
end
function PaGlobal_AlchemyStone_Renewal_All:showEvolveResult(type, resultItemKey)
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if self._ui._stc_result:GetShow() == false then
    self._ui._stc_result:SetPosX(-Panel_Window_AlchemyStone_All:GetPosX())
    self._ui._stc_result:SetPosY(-Panel_Window_AlchemyStone_All:GetPosY())
    self._ui._stc_result:SetSize(getScreenSizeX(), getScreenSizeY())
    self._ui._stc_result:SetShow(true)
  end
  self._ui._stc_resultIemNameBG:SetShow(true)
  self._ui._txt_resultDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ALCHEMY_STONE_ENCHANT_ING_CLOSE"))
  if type == 0 then
    self._resultItemKey = resultItemKey
    self._ui._stc_resultItemSlotBG:AddEffect("fUI_AlchemyStone_New_Fail_01A", false)
    audioPostEvent_SystemUi(5, 103)
    _AudioPostEvent_SystemUiForXBOX(5, 103)
    self._ui._txt_result:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_FAIL"))
    local itemSSW = getItemEnchantStaticStatus(PaGlobal_AlchemyStoneEvolve_All._alchemyStoneItemKey)
    if itemSSW ~= nil then
      self._evolveResultSlot[0]:setItemByStaticStatus(itemSSW, 1, nil, nil, nil)
      self._evolveResultSlot[0].Empty = false
      self._ui._txt_resultItemName:SetShow(true)
      self._ui._txt_resultItemName:SetText(itemSSW:getName())
    end
  elseif type == 1 then
    self._ui._stc_resultItemSlotBG:AddEffect("fUI_AlchemyStone_New_Fail_01A", false)
    audioPostEvent_SystemUi(5, 103)
    _AudioPostEvent_SystemUiForXBOX(5, 103)
    self._ui._txt_result:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_FAIL"))
    self._evolveResultSlot[0]:clearItem()
    self._evolveResultSlot[0].Empty = true
    self._ui._txt_resultItemName:SetShow(false)
    self:clearItemSlot()
  elseif type == 2 then
    self._resultItemKey = resultItemKey
    self._ui._stc_resultItemSlotBG:AddEffect("fUI_AlchemyStone_New_Fail_01A", false)
    audioPostEvent_SystemUi(5, 103)
    _AudioPostEvent_SystemUiForXBOX(5, 103)
    self._ui._txt_result:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_FAIL"))
    local itemSSW = getItemEnchantStaticStatus(self._resultItemKey)
    if itemSSW ~= nil then
      self._evolveResultSlot[0]:setItemByStaticStatus(itemSSW, 1, nil, nil, nil)
      self._evolveResultSlot[0].Empty = false
      self._ui._txt_resultItemName:SetShow(true)
      self._ui._txt_resultItemName:SetText(itemSSW:getName())
    end
    self:clearItemSlot()
  elseif type == 3 then
    self._resultItemKey = resultItemKey
    self._ui._stc_resultItemSlotBG:AddEffect("fUI_AlchemyStone_New_Success_01A", false)
    audioPostEvent_SystemUi(5, 102)
    _AudioPostEvent_SystemUiForXBOX(5, 102)
    self._ui._txt_result:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_SUCCESS"))
    local itemSSW = getItemEnchantStaticStatus(self._resultItemKey)
    if itemSSW ~= nil then
      self._evolveResultSlot[0]:setItemByStaticStatus(itemSSW, 1, nil, nil, nil)
      self._evolveResultSlot[0].Empty = false
      self._ui._txt_resultItemName:SetShow(true)
      self._ui._txt_resultItemName:SetText(itemSSW:getName())
    end
    self:clearItemSlot()
  end
  if self._isPadSnapping == true then
    ToClient_padSnapChangeToTarget(self._ui._stc_resultItemSlot)
  end
  self._audioId = nil
  self._audioIdXbox = nil
end
function PaGlobal_AlchemyStone_Renewal_All:closeEvolveResult()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self._resultItemKey = nil
  self._ui._stc_result:SetShow(false)
end
function PaGlobal_AlchemyStone_Renewal_All:clearEffect()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self._startEffectPlay = false
  self._chargeEffectTime = 0
  self._upgradeEffectTime = 0
  self._evolveEffectTime = 0
  self._ui._stc_charge:EraseAllEffect()
  self._ui._stc_upgrade:EraseAllEffect()
  self._ui._stc_resultItemSlotBG:EraseAllEffect()
  self._ui._btn_charge:SetMonoTone(false)
  self._ui._btn_charge:SetIgnore(false)
end
function PaGlobal_AlchemyStone_Renewal_All:clearAudioEffect()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if self._audioId ~= nil then
    audioPostEvent_StopAudioByPlayingID(self._audioId, 0)
    self._audioId = nil
  end
  if self._audioIdXbox ~= nil then
    audioPostEvent_StopAudioByPlayingID(self._audioIdXbox, 0)
    self._audioIdXbox = nil
  end
  self._audioId = nil
  self._audioIdXbox = nil
end
function PaGlobal_AlchemyStone_Renewal_All:selectNormalInventoryTab()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  if PaGlobal_Inventory_All ~= nil and PaGlobal_Inventory_All._ui.rdo_normalInven:IsCheck() == false then
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
    if _ContentsGroup_changeFamilyInvenOpenAction == true then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
    end
    PaGlobal_Inventory_All._ui.rdo_enchantMaterialInven:SetCheck(false)
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(true)
    HandleEventLUp_Inventory_All_SelectTab()
  end
end
function PaGlobal_AlchemyStone_Renewal_All:validate()
  if Panel_Window_AlchemyStone_All == nil then
    return
  end
  self._ui._stc_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_question:isValidate()
  self._ui._stc_radioGroup:isValidate()
  self._ui._txt_lb_console:isValidate()
  self._ui._txt_rb_console:isValidate()
  self._ui._rdo_tab_charge:isValidate()
  self._ui._rdo_tab_upgrade:isValidate()
  self._ui._stc_selectBar:isValidate()
  self._ui._txt_multiline:isValidate()
  self._ui._stc_chargeBG:isValidate()
  self._ui._stc_charge:isValidate()
  self._ui._stc_chargeSlotLeft:isValidate()
  self._ui._stc_chargeSlotRight:isValidate()
  self._ui._txt_needItem:isValidate()
  self._ui._txt_durability:isValidate()
  self._ui._stc_upgradeBG:isValidate()
  self._ui._stc_upgrade:isValidate()
  self._ui._txt_exp:isValidate()
  self._ui._circular_gauge:isValidate()
  self._ui._stc_upgradeSlotLeft:isValidate()
  self._ui._stc_upgradeSlotRight:isValidate()
  self._ui._progress_stack:isValidate()
  self._ui._txt_stack:isValidate()
  self._ui._stc_stackEffect:isValidate()
  self._ui._chk_skipAni:isValidate()
  self._ui._btn_charge:isValidate()
  self._ui._stc_descBG:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_result:isValidate()
  self._ui._txt_result:isValidate()
  self._ui._stc_resultIemNameBG:isValidate()
  self._ui._txt_resultItemName:isValidate()
  self._ui._stc_resultItemSlotBG:isValidate()
  self._ui._stc_resultItemSlot:isValidate()
  self._ui._txt_resultDesc:isValidate()
  self._ui._stc_consoleKeyGuide:isValidate()
  self._ui._keyGuideA:isValidate()
  self._ui._keyGuideB:isValidate()
  self._ui._keyGuideX:isValidate()
end
