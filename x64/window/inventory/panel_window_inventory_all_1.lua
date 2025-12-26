function PaGlobal_Inventory_All:initialize()
  if nil == Panel_Window_Inventory_All or true == PaGlobal_Inventory_All._initialize then
    return
  end
  PaGlobal_Inventory_All:controlInit()
  PaGlobal_Inventory_All:createSlot()
  PaGlobal_Inventory_All:setData()
  PaGlobal_Inventory_All:registerEventHandler()
  PaGlobal_Inventory_All:validate()
  PaGlobal_Inventory_All._initialize = true
end
function PaGlobal_Inventory_All:controlInit()
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_Title")
  self._ui.check_popup = UI.getChildControl(self._ui.stc_titleBG, "CheckButton_PopUp")
  self._ui.btn_question = UI.getChildControl(self._ui.stc_titleBG, "Button_Question")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Win_Close")
  self._ui.stc_radioButtonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_RadioButtonBg")
  self._ui.rdo_normalInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_NormalInventory")
  self._ui.rdo_pearlInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_CashInventory")
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui.rdo_familyInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_FamilyInventory")
  else
    self._ui.rdo_familyInven = UI.getChildControl(self._ui.stc_radioButtonBG, "Button_FamilyInventory")
  end
  self._ui.rdo_enchantMaterialInven = UI.getChildControl(self._ui.stc_radioButtonBG, "RadioButton_EnchantMaterialInventory")
  self._ui.stc_pearlInvenEffect = UI.getChildControl(self._ui.rdo_pearlInven, "Static_New_Effect")
  self._ui.stc_selectbar = UI.getChildControl(self._ui.stc_radioButtonBG, "Static_SelectBar")
  self._ui.stc_topItemSortBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_TopItemSortBG")
  self._ui.btn_checkSort = UI.getChildControl(self._ui.stc_topItemSortBG, "CheckButton_ItemSort")
  self._ui.button_sortOption = UI.getChildControl(self._ui.stc_topItemSortBG, "Button_Sort_Set")
  self._ui.txt_capacity = UI.getChildControl(self._ui.stc_topItemSortBG, "Static_Text_Capacity")
  local searchBG = UI.getChildControl(self._ui.stc_topItemSortBG, "Static_Search_BG")
  self._ui.edit_search = UI.getChildControl(searchBG, "Edit_SearchText_PCUI_Import")
  self._ui.btn_search = UI.getChildControl(searchBG, "Button_BtnSearch_PCUI")
  self._ui.txt_searchDefaultText = UI.getChildControl(searchBG, "StaticText_DefaultSearchText")
  self._ui.btn_searchReset = UI.getChildControl(searchBG, "Button_SearchReset")
  self._ui.stc_mainSlotBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_MainSlotBG")
  self._ui.scroll_inven = UI.getChildControl(self._ui.stc_mainSlotBG, "Scroll_CashInven")
  self._ui.stc_scrollArea = UI.getChildControl(Panel_Window_Inventory_All, "Scroll_Area")
  self._ui.template_slotBG = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_Slot_Temp")
  self._ui.template_slot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_SlotBG_Temp")
  self._ui.template_lockSlot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_LockSlot_Temp")
  self._ui.template_plusSlot = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_PlusSlot")
  self._ui.template_onlyPlus = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_OnlyPlus")
  self._ui.template_btnPuzzle = UI.getChildControl(Panel_Window_Inventory_All, "Button_Puzzle")
  self._ui.template_olympic = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_OlympicFilter")
  self._ui.template_delete = UI.getChildControl(self._ui.stc_mainSlotBG, "Static_Check")
  self._ui.template_delete:SetShow(false)
  self._ui.stc_bottomBG = UI.getChildControl(Panel_Window_Inventory_All, "Inventory_BottomBG")
  self._ui.stc_weightBG = UI.getChildControl(self._ui.stc_bottomBG, "Static_Texture_Weight_Background")
  self._ui.btn_buyWeight = UI.getChildControl(self._ui.stc_weightBG, "Button_BuyWeight")
  self._ui.progress_weight = UI.getChildControl(self._ui.stc_weightBG, "Progress2_Weight")
  self._ui.progress_equipment = UI.getChildControl(self._ui.stc_weightBG, "Progress2_Equipment")
  self._ui.stc_weightIcon = UI.getChildControl(self._ui.stc_weightBG, "Static_WeightIcon")
  self._ui.txt_weightValue = UI.getChildControl(self._ui.stc_weightBG, "StaticText_Weight")
  self._ui.stc_weightTooltipBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_WeightHelp_BG")
  self._ui.txt_weightDesc = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_Weight_Help")
  self._ui.txt_equipDesc = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_Equip_Help")
  self._ui.txt_moneyDesc = UI.getChildControl(Panel_Window_Inventory_All, "StaticText_MoneyHelp")
  self._ui.stc_moneyBG = UI.getChildControl(self._ui.stc_bottomBG, "Static_MoneyTypeBG")
  self._ui.stc_moneyIcon = UI.getChildControl(self._ui.stc_moneyBG, "Button_Money")
  self._ui.txt_moneyValue = UI.getChildControl(self._ui.stc_moneyBG, "Static_Text_Money")
  self._ui.stc_pearlIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_PearlIcon")
  self._ui.txt_pearlValue = UI.getChildControl(self._ui.stc_moneyBG, "StaticText_PearlValue")
  self._ui.stc_mileageIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_MileageIcon")
  self._ui.txt_mileageValue = UI.getChildControl(self._ui.stc_moneyBG, "StaticText_MileageValue")
  self._ui.stc_oceanIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_OceanIcon")
  self._ui.txt_oceanValue = UI.getChildControl(self._ui.stc_moneyBG, "StaticText_OceanValue")
  self._ui.stc_hardCoreIcon = UI.getChildControl(self._ui.stc_moneyBG, "Static_HardCoreIcon")
  self._ui.txt_hardCoreValue = UI.getChildControl(self._ui.stc_moneyBG, "Static_Text_HardCoreMoney")
  self._ui.stc_buttonBG = UI.getChildControl(self._ui.stc_bottomBG, "Static_ButtonTypeBG")
  self._ui.btn_alchemyFigureHead = UI.getChildControl(self._ui.stc_buttonBG, "Button_AlchemyFigureHead")
  self._ui.btn_alchemyStone = UI.getChildControl(self._ui.stc_buttonBG, "Button_AlchemyStone")
  self._ui.btn_manufacture = UI.getChildControl(self._ui.stc_buttonBG, "Button_Manufacture")
  self._ui.btn_dyePalette = UI.getChildControl(self._ui.stc_buttonBG, "Button_Palette")
  self._ui.btn_openEquip = UI.getChildControl(self._ui.stc_buttonBG, "Button_OpenEquip")
  self._ui.btn_lightStoneBag = UI.getChildControl(self._ui.stc_buttonBG, "Button_Artifact_Storage")
  self._ui.btn_doItemMove = UI.getChildControl(self._ui.stc_buttonBG, "Button_AutoMove")
  self._ui.btn_setItemMove = UI.getChildControl(self._ui.stc_buttonBG, "Button_Set_AutoMove")
  self._ui.btn_sellEtcAll = UI.getChildControl(self._ui.stc_buttonBG, "Button_SellEtcAll")
  self._ui.btn_moveFamilyInven = UI.getChildControl(self._ui.stc_bottomBG, "Button_moveFamilyInven")
  self._ui.btn_moveEnchantInven = UI.getChildControl(self._ui.stc_bottomBG, "Button_moveEnchantInven")
  self._ui.btn_openEquip:SetShow(false)
  self._ui.chk_trash = UI.getChildControl(self._ui.stc_bottomBG, "CheckButton_Trash")
  self._ui.txt_enchantNumber = UI.getChildControl(Panel_Window_Inventory_All, "Static_Text_Slot_Enchant_value")
  self._ui.stc_puzzleNotice = UI.getChildControl(Panel_Window_Inventory_All, "Static_Notice")
  self._ui.txt_puzzleNoticeText = UI.getChildControl(self._ui.stc_puzzleNotice, "StaticText_Notice")
  self._ui.stc_manufactureButtonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_ManufactureButtonBG")
  self._ui.btn_manufactureOpen = UI.getChildControl(self._ui.stc_manufactureButtonBG, "Button_Manufacture")
  self._ui.btn_productNote = UI.getChildControl(self._ui.stc_manufactureButtonBG, "Button_Note")
  self._ui.stc_exchangeButtonBG = UI.getChildControl(Panel_Window_Inventory_All, "Static_ExchangeButtonBG")
  self._ui.btn_waypoint = UI.getChildControl(self._ui.stc_exchangeButtonBG, "Button_WayPoint")
  self._ui.btn_widget = UI.getChildControl(self._ui.stc_exchangeButtonBG, "Button_Widget")
  self._ui.btn_delete = UI.getChildControl(self._ui.stc_bottomBG, "Button_Delete")
  self._ui.btn_restore = UI.getChildControl(self._ui.stc_bottomBG, "Button_Restore")
  self._ui.txt_trashDesc = UI.getChildControl(self._ui.stc_bottomBG, "MultilineText_Trash_Desc")
  self._ui.stc_familyInventoryDescBg = UI.getChildControl(Panel_Window_Inventory_All, "Static_FamilyInvenDescBg")
  self._ui.txt_familyInventoryDesc = UI.getChildControl(self._ui.stc_familyInventoryDescBg, "StaticText_Desc")
  self._ui.btn_familyInventoryBuySlot = UI.getChildControl(self._ui.stc_familyInventoryDescBg, "Button_FamilyInventoryBuySlot")
  self._ui.btn_familyInventoryQuest = UI.getChildControl(self._ui.stc_familyInventoryDescBg, "Button_FamilyInventoryQuest")
  self._ui.stc_cashProductBg = UI.getChildControl(Panel_Window_Inventory_All, "Static_BlockSlot")
  self._ui.btn_restoreProduct = UI.getChildControl(self._ui.stc_cashProductBg, "Button_Get_Product")
  self._ui.btn_cashProductBgClose = UI.getChildControl(self._ui.stc_cashProductBg, "Button_Close")
  PaGlobal_Inventory_All:categoryCntrolInit()
  self._ui.btn_sortSlot = UI.getChildControl(self._ui.stc_topItemSortBG, "RadioButton_Slot")
  self._ui.btn_sortList = UI.getChildControl(self._ui.stc_topItemSortBG, "RadioButton_List")
  self._ui.stc_bottomBGNew = UI.getChildControl(Panel_Window_Inventory_All, "Inventory_BottomBG_New")
  self._ui.stc_moneyBGNew = UI.getChildControl(Panel_Window_Inventory_All, "Static_MoneyTypeBG")
  self._ui.stc_countArea = UI.getChildControl(self._ui.stc_bottomBGNew, "Static_BagCountArea")
  self._ui.stc_bottom_SlotIcon = UI.getChildControl(self._ui.stc_countArea, "Static_WeightIcon")
  self._ui.prog_bottom_Slot = UI.getChildControl(self._ui.stc_countArea, "Progress2_Weight")
  self._ui.txt_bottom_SlotCount = UI.getChildControl(self._ui.stc_countArea, "StaticText_Weight")
  self._ui.btn_bottom_BuySlot = UI.getChildControl(self._ui.stc_countArea, "Button_BuyWeight")
  self._ui.stc_weightArea = UI.getChildControl(self._ui.stc_bottomBGNew, "Static_WeightArea")
  self._ui.stc_bottom_WeightIcon = UI.getChildControl(self._ui.stc_weightArea, "Static_WeightIcon")
  self._ui.prog_bottom_Weight = UI.getChildControl(self._ui.stc_weightArea, "Progress2_Weight")
  self._ui.prog_bottom_Equip = UI.getChildControl(self._ui.stc_weightArea, "Progress2_Equipment")
  self._ui.txt_bottom_Weight = UI.getChildControl(self._ui.stc_weightArea, "StaticText_Weight")
  self._ui.btn_bottom_BuyWeight = UI.getChildControl(self._ui.stc_weightArea, "Button_BuyWeight")
  self._ui.stc_btnTypeArea = UI.getChildControl(self._ui.stc_bottomBGNew, "Static_ButtonTypeBG")
  self._ui.btn_bottom_Trash = UI.getChildControl(self._ui.stc_bottomBGNew, "CheckButton_Trash")
  self._ui.btn_bottom_Delete = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_Delete")
  self._ui.btn_bottom_Restore = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_Restore")
  self._ui.txt_bottom_TrashDesc = UI.getChildControl(self._ui.stc_bottomBGNew, "MultilineText_Trash_Desc")
  self._ui.btn_bottom_FamilyInven = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_moveFamilyInven")
  self._ui.btn_bottom_EnchantInven = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_moveEnchantInven")
  self._ui.btn_bottom_Enchant = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_Enchant")
  self._ui.btn_bottom_Crystal = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_Crystal")
  self._ui.btn_bottom_ArtifactBag = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_ArtifactBag")
  self._ui.btn_bottom_Manufacture = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_Manufacture")
  self._ui.btn_bottom_AlchemyFigureHead = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_AlchemyFigureHead")
  self._ui.btn_bottom_AlchemyStone = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_AlchemyStone")
  self._ui.btn_bottom_Palette = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_Palette")
  self._ui.btn_bottom_RepairDekia = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_Dekia")
  self._ui.btn_bottom_CombineBag = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_CombineBag")
  self._ui.btn_bottom_ReforgeStone = UI.getChildControl(self._ui.stc_btnTypeArea, "Button_ReforgeStone")
  if _ContentsGroup_CombineBag == false then
    self._ui.btn_bottom_CombineBag:SetShow(false)
  end
  self._ui.btn_bottom_OpenEquip = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_OpenEquip")
  self._ui.btn_bottom_AutoMove = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_AutoMove")
  self._ui.btn_bottom_AutoMoveAll = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_AutoMoveAll")
  self._ui.btn_bottom_SetAutoMove = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_Set_AutoMove")
  self._ui.btn_bottom_SellEtcAll = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_SellEtcAll")
  self._ui.btn_bottom_ValksView = UI.getChildControl(self._ui.stc_bottomBGNew, "Button_ValksView")
  self._ui.stc_bottom_MoneyIcon = UI.getChildControl(self._ui.stc_moneyBGNew, "Button_Money")
  self._ui.txt_bottom_MoneyValue = UI.getChildControl(self._ui.stc_moneyBGNew, "Static_Text_Money")
  self._ui.stc_bottom_PearlIcon = UI.getChildControl(self._ui.stc_moneyBGNew, "Static_PearlIcon")
  self._ui.txt_bottom_PearlValue = UI.getChildControl(self._ui.stc_moneyBGNew, "StaticText_PearlValue")
  self._ui.stc_bottom_MileageIcon = UI.getChildControl(self._ui.stc_moneyBGNew, "Static_MileageIcon")
  self._ui.txt_bottom_MileageValue = UI.getChildControl(self._ui.stc_moneyBGNew, "StaticText_MileageValue")
  self._ui.stc_bottom_OceanIcon = UI.getChildControl(self._ui.stc_moneyBGNew, "Static_OceanIcon")
  self._ui.txt_bottom_OceanValue = UI.getChildControl(self._ui.stc_moneyBGNew, "StaticText_OceanValue")
  self._ui.stc_bottom_hardCoreIcon = UI.getChildControl(self._ui.stc_moneyBGNew, "Static_HardCoreIcon")
  self._ui.txt_bottom_hardCoreValue = UI.getChildControl(self._ui.stc_moneyBGNew, "Static_Text_HardCoreMoney")
end
function PaGlobal_Inventory_All:createSlot()
  for ii = 0, self.config.slotCount - 1 do
    local slot = {}
    slot.empty = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_Base_" .. ii)
    slot.lock = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_Lock_" .. ii)
    slot.plus = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_Plus_" .. ii)
    slot.onlyPlus = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_OnlyPlus_" .. ii)
    slot.olympic = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_OlympicFilter_" .. ii)
    CopyBaseProperty(self._ui.template_slot, slot.empty)
    CopyBaseProperty(self._ui.template_lockSlot, slot.lock)
    CopyBaseProperty(self._ui.template_plusSlot, slot.plus)
    CopyBaseProperty(self._ui.template_onlyPlus, slot.onlyPlus)
    CopyBaseProperty(self._ui.template_olympic, slot.olympic)
    UIScroll.InputEventByControl(slot.empty, "HandleEventScroll_Inventory_All_UpdateScroll")
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.empty:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.empty:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.lock:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.lock:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.plus:SetPosX(self.config.slotStartX + self.config.slotGapX * col - 4)
    slot.plus:SetPosY(self.config.slotStartY + self.config.slotGapY * row - 4)
    slot.onlyPlus:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.onlyPlus:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.olympic:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.olympic:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.empty:SetShow(false)
    slot.lock:SetShow(false)
    slot.plus:SetShow(false)
    slot.onlyPlus:SetShow(false)
    slot.olympic:SetShow(false)
    self._slotsBackground[ii] = slot
  end
  local useStartSlot = inventorySlotNoUserStart()
  for ii = 0, self.config.slotCount - 1 do
    local slotNo = ii + useStartSlot
    local slot = {}
    SlotItem.new(slot, "ItemIcon_" .. ii, ii, Panel_Window_Inventory_All, self.slotConfig)
    slot:createChild()
    slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Inventory_All_RUpEvent(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LDown", "HandleEventLDown_Inventory_All_SlotLClick(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_LUpEvent(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_Inventory_All_PressMoveEvent(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_IconTooltip(true, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_IconTooltip(false, " .. ii .. ")")
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_Inventory_All_UpdateScroll")
    slot.icon:SetAutoDisableTime(0.2)
    local row = math.floor(ii / self.config.slotCols)
    local col = ii % self.config.slotCols
    slot.icon:SetPosX(self.config.slotStartX + self.config.slotGapX * col)
    slot.icon:SetPosY(self.config.slotStartY + self.config.slotGapY * row)
    slot.icon:SetEnableDragAndDrop(true)
    slot.isEmpty = true
    Panel_Tooltip_Item_SetPosition(ii, slot, "inventory")
    slot.background = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "Inventory_Slot_BG_" .. ii)
    CopyBaseProperty(self._ui.template_slotBG, slot.background)
    slot.background:SetSize(slot.icon:GetSizeX(), slot.icon:GetSizeY())
    slot.background:SetPosX(slot.icon:GetPosX())
    slot.background:SetPosY(slot.icon:GetPosY())
    slot.background:SetShow(false)
    slot.icon:SetSize(44, 44)
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.cooltime:SetSize(44, 44)
    slot.cooltime:SetPosX(0)
    slot.cooltime:SetPosY(0)
    slot.delete = UI.createControl(__ePAUIControl_Static, slot.icon, "Inventory_Slot_DeleteFilter_" .. ii)
    CopyBaseProperty(self._ui.template_delete, slot.delete)
    slot.delete:SetPosX(0)
    slot.delete:SetPosY(0)
    self.slots[ii] = slot
    local effectSlot = {}
    local puzzle = UI.createControl(__ePAUIControl_Button, slot.icon, "Puzzle_Control_" .. ii)
    CopyBaseProperty(self._ui.template_btnPuzzle, puzzle)
    puzzle:SetShow(false)
    puzzle:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_MakePuzzle(" .. ii .. ")")
    puzzle:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_PuzzleTooltip(true," .. ii .. ")")
    puzzle:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_PuzzleTooltip(false)")
    Panel_Window_Inventory_All:SetChildIndex(self._ui.stc_puzzleNotice, 9999)
    Panel_Window_Inventory_All:SetChildIndex(self.slots[ii].icon, 9998)
    effectSlot.isFirstItem = false
    effectSlot.puzzleControl = puzzle
    self.slotEtcData[ii] = effectSlot
  end
  for ii = 0, self.config.slotCount - 1 do
    local slot = self._slotsBackground[ii]
    Panel_Window_Inventory_All:SetChildIndex(slot.plus, 15099)
    Panel_Window_Inventory_All:SetChildIndex(slot.onlyPlus, 15100)
    Panel_Window_Inventory_All:SetChildIndex(slot.olympic, 15101)
  end
  for ii = 0, self.INVEN_MAX_SLOTNO do
    self.newItemData[ii] = nil
    self.newPearlItemData[ii] = nil
    self.newEnchantMaterial[ii] = nil
  end
  if FGlobal_IsCommercialService() then
    if isGameTypeGT() then
      self._ui.stc_pearlIcon:SetShow(false)
      self._ui.txt_pearlValue:SetShow(false)
      self._ui.stc_mileageIcon:SetShow(false)
      self._ui.txt_mileageValue:SetShow(false)
      self._ui.stc_bottom_PearlIcon:SetShow(false)
      self._ui.txt_bottom_PearlValue:SetShow(false)
      self._ui.stc_bottom_MileageIcon:SetShow(false)
      self._ui.txt_bottom_MileageValue:SetShow(false)
    else
      self._ui.stc_pearlIcon:SetShow(true)
      self._ui.txt_pearlValue:SetShow(true)
      self._ui.stc_mileageIcon:SetShow(true)
      self._ui.txt_mileageValue:SetShow(true)
      self._ui.stc_bottom_PearlIcon:SetShow(true)
      self._ui.txt_bottom_PearlValue:SetShow(true)
      self._ui.stc_bottom_MileageIcon:SetShow(true)
      self._ui.txt_bottom_MileageValue:SetShow(true)
    end
  elseif isGameTypeNA() then
    self._ui.stc_pearlIcon:SetShow(true)
    self._ui.txt_pearlValue:SetShow(true)
    self._ui.stc_mileageIcon:SetShow(true)
    self._ui.txt_mileageValue:SetShow(true)
    self._ui.stc_bottom_PearlIcon:SetShow(true)
    self._ui.txt_bottom_PearlValue:SetShow(true)
    self._ui.stc_bottom_MileageIcon:SetShow(true)
    self._ui.txt_bottom_MileageValue:SetShow(true)
  else
    self._ui.stc_pearlIcon:SetShow(false)
    self._ui.txt_pearlValue:SetShow(false)
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
    self._ui.stc_bottom_PearlIcon:SetShow(false)
    self._ui.txt_bottom_PearlValue:SetShow(false)
    self._ui.stc_bottom_MileageIcon:SetShow(false)
    self._ui.txt_bottom_MileageValue:SetShow(false)
  end
  if isGameTypeGT() then
    self._ui.stc_pearlIcon:SetShow(false)
    self._ui.txt_pearlValue:SetShow(false)
    self._ui.stc_mileageIcon:SetShow(false)
    self._ui.txt_mileageValue:SetShow(false)
    self._ui.stc_bottom_PearlIcon:SetShow(false)
    self._ui.txt_bottom_PearlValue:SetShow(false)
    self._ui.stc_bottom_MileageIcon:SetShow(false)
    self._ui.txt_bottom_MileageValue:SetShow(false)
    if false == _ContentsGroup_OceanCurrent then
      self._ui.stc_oceanIcon:SetShow(false)
      self._ui.txt_oceanValue:SetShow(false)
      self._ui.stc_bottom_OceanIcon:SetShow(false)
      self._ui.txt_bottom_OceanValue:SetShow(false)
    else
      self._ui.stc_oceanIcon:SetSpanSize(5, self._ui.stc_oceanIcon:GetSpanSize().y)
      self._ui.txt_oceanValue:SetSpanSize(40, 10)
      self._ui.txt_oceanValue:ComputePos()
    end
  end
  self:setShowControlsForHardCoreChannel()
  self._ui.btn_buyWeight:SetShow(_ContentsGroup_EasyBuy)
  self._ui.btn_bottom_BuyWeight:SetShow(_ContentsGroup_EasyBuy)
  self._ui.btn_doItemMove:SetShow(false)
  self._ui.btn_setItemMove:SetShow(false)
  self._ui.btn_bottom_AutoMove:SetShow(false)
  self._ui.btn_bottom_AutoMoveAll:SetShow(false)
  self._ui.btn_bottom_SetAutoMove:SetShow(false)
  self._ui.btn_delete:SetShow(false)
  self._ui.btn_restore:SetShow(false)
  self._ui.txt_trashDesc:SetShow(false)
  self._ui.btn_bottom_Delete:SetShow(false)
  self._ui.btn_bottom_Restore:SetShow(false)
  self._ui.txt_bottom_TrashDesc:SetShow(false)
  local BG = UI.getChildControl(Panel_Window_Inventory_All, "Static_RemoteWarehouseBG")
  local BlackBG = UI.getChildControl(BG, "Static_BlackBG")
  local Desc = UI.getChildControl(BG, "StaticText_Desc")
  self._ui.stc_remoteWarehouseDescBG = UI.createControl(__ePAUIControl_Static, Panel_Window_Inventory_All, "RemoteWareHouseBG_1")
  self._ui.stc_remoteWarehouseBlackBG = UI.createControl(__ePAUIControl_Static, self._ui.stc_remoteWarehouseDescBG, "RemoteWareHouseBlackBG_1")
  self._ui.txt_remoteWarehouseDesc = UI.createControl(__ePAUIControl_StaticText, self._ui.stc_remoteWarehouseDescBG, "RemoteWareHouseDesc_1")
  CopyBaseProperty(BG, self._ui.stc_remoteWarehouseDescBG)
  CopyBaseProperty(BlackBG, self._ui.stc_remoteWarehouseBlackBG)
  CopyBaseProperty(Desc, self._ui.txt_remoteWarehouseDesc)
  self._ui.stc_remoteWarehouseDescBG:ChangeTextureInfoNameAsync("combine/frame/combine_frame_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_remoteWarehouseDescBG, 205, 1, 255, 51)
  self._ui.stc_remoteWarehouseDescBG:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.stc_remoteWarehouseDescBG:setRenderTexture(self._ui.stc_remoteWarehouseDescBG:getBaseTexture())
  self._ui.txt_remoteWarehouseDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_remoteWarehouseDesc:SetText(self._ui.txt_remoteWarehouseDesc:GetText())
end
function PaGlobal_Inventory_All:setShowControlsForHardCoreChannel()
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.stc_hardCoreIcon:SetShow(true)
    self._ui.txt_hardCoreValue:SetShow(true)
    self._ui.stc_bottom_hardCoreIcon:SetShow(true)
    self._ui.txt_bottom_hardCoreValue:SetShow(true)
    self._ui.stc_oceanIcon:SetShow(false)
    self._ui.txt_oceanValue:SetShow(false)
    self._ui.stc_bottom_OceanIcon:SetShow(false)
    self._ui.txt_bottom_OceanValue:SetShow(false)
    self._ui.stc_bottom_PearlIcon:SetShow(false)
    self._ui.txt_bottom_PearlValue:SetShow(false)
    self._ui.stc_bottom_MoneyIcon:SetShow(false)
    self._ui.txt_bottom_MoneyValue:SetShow(false)
    self._ui.stc_bottom_MileageIcon:SetShow(false)
    self._ui.txt_bottom_MileageValue:SetShow(false)
    self._ui.btn_bottom_Enchant:SetShow(false)
    self._ui.btn_bottom_Crystal:SetShow(false)
    self._ui.btn_bottom_ArtifactBag:SetShow(false)
    self._ui.btn_bottom_CombineBag:SetShow(false)
    self._ui.btn_bottom_ReforgeStone:SetShow(false)
    self._ui.btn_bottom_Palette:SetShow(false)
    self._ui.btn_bottom_Manufacture:SetShow(false)
    self._ui.btn_bottom_AlchemyFigureHead:SetShow(false)
    self._ui.btn_bottom_RepairDekia:SetShow(false)
    self._ui.btn_bottom_AlchemyStone:SetShow(false)
    self._ui.btn_bottom_BuySlot:SetShow(false)
    self._ui.btn_bottom_BuyWeight:SetShow(false)
  else
    self._ui.stc_hardCoreIcon:SetShow(false)
    self._ui.txt_hardCoreValue:SetShow(false)
    self._ui.stc_bottom_hardCoreIcon:SetShow(false)
    self._ui.txt_bottom_hardCoreValue:SetShow(false)
  end
end
function PaGlobal_Inventory_All:setSpanSizeInvenButtonsForService()
  if CppEnums.ServiceResourceType.eServiceResourceType_TR == ToClient_getResourceType() then
    self._ui.rdo_familyInven:SetSpanSize(self._ui.rdo_familyInven:GetSpanSize().x + 10, self._ui.rdo_familyInven:GetSpanSize().y)
  end
end
function PaGlobal_Inventory_All:setShowFamilyButton(show)
  if show == true then
    self._ui.rdo_familyInven:SetShow(true)
    self:setSpanSizeInvenButtonsForService()
  else
    self._ui.rdo_familyInven:SetShow(false)
  end
  self:setRadioButtonPosition()
end
function PaGlobal_Inventory_All:setRadioButtonPosition()
  local radioButtonCount = 0
  if self._ui.rdo_normalInven:GetShow() == true then
    radioButtonCount = radioButtonCount + 1
  end
  if self._ui.rdo_pearlInven:GetShow() == true then
    radioButtonCount = radioButtonCount + 1
  end
  if self._ui.rdo_enchantMaterialInven:GetShow() == true then
    radioButtonCount = radioButtonCount + 1
  end
  if self._ui.rdo_familyInven:GetShow() == true then
    radioButtonCount = radioButtonCount + 1
  end
  local radioButtonStartSpanX = -1 * (radioButtonCount - 1) * self._radioButtonSpanXGap / 2
  if radioButtonCount >= self._tabAdjustedNeeded then
    radioButtonStartSpanX = radioButtonStartSpanX - self._tabStartOffest
  end
  if self._ui.rdo_normalInven:GetShow() == true then
    self._ui.rdo_normalInven:SetSpanSize(radioButtonStartSpanX, self._ui.rdo_normalInven:GetSpanSize().y)
    radioButtonStartSpanX = radioButtonStartSpanX + self._radioButtonSpanXGap
  end
  if self._ui.rdo_pearlInven:GetShow() == true then
    self._ui.rdo_pearlInven:SetSpanSize(radioButtonStartSpanX, self._ui.rdo_pearlInven:GetSpanSize().y)
    radioButtonStartSpanX = radioButtonStartSpanX + self._radioButtonSpanXGap
  end
  if self._ui.rdo_enchantMaterialInven:GetShow() == true then
    self._ui.rdo_enchantMaterialInven:SetSpanSize(radioButtonStartSpanX, self._ui.rdo_enchantMaterialInven:GetSpanSize().y)
    radioButtonStartSpanX = radioButtonStartSpanX + self._radioButtonSpanXGap
  end
  if self._ui.rdo_familyInven:GetShow() == true then
    self._ui.rdo_familyInven:SetSpanSize(radioButtonStartSpanX, self._ui.rdo_familyInven:GetSpanSize().y)
    radioButtonStartSpanX = radioButtonStartSpanX + self._radioButtonSpanXGap
  end
  PaGlobal_Inventory_All:setSpanSizeInvenButtonsForService()
end
function PaGlobal_Inventory_All:setData()
  self.config.slotRows = self.config.slotCount / self.config.slotCols
  self._isItemLockContentsOpen = ToClient_IsContentsGroupOpen("219")
  self._defaultPosX = Panel_Window_Inventory_All:GetPosX()
  self._defaultPosY = Panel_Window_Inventory_All:GetPosY()
  self._defaultSizeY = Panel_Window_Inventory_All:GetSizeY()
  self._defaultMoneySpanY = self._ui.stc_moneyBG:GetSpanSize().y
  self._defaultWeightSpanY = self._ui.stc_weightBG:GetSpanSize().y
  self._defaultWeightTooltipSizeY = self._ui.stc_weightTooltipBG:GetSizeY()
  PaGlobal_Inventory_All._openedUIMode = PaGlobal_Inventory_All._bottomBG_UIMode.Normal
  PaGlobal_Inventory_All:reloadBottomBgFromMode(PaGlobal_Inventory_All._openedUIMode, true)
  self._ui.txt_enchantNumber:SetShow(false)
  self._ui.check_popup:SetShow(_ContentsGroup_PopUp)
  self._ui.btn_alchemyStone:SetShow(_ContentsGroup_AlchemyStone)
  self._ui.btn_alchemyFigureHead:SetShow(_ContentsGroup_JewelPreset)
  self._ui.btn_lightStoneBag:SetShow(_ContentsGroup_LightStoneBag)
  self._ui.btn_lightStoneBag:SetPosX(self._ui.btn_alchemyFigureHead:GetPosX())
  self._ui.button_sortOption:SetShow(true)
  self._ui.btn_sortSlot:SetShow(_ContentsGroup_InvenCategory)
  self._ui.btn_sortList:SetShow(_ContentsGroup_InvenCategory)
  self._ui.stc_bottomBGNew:SetShow(_ContentsGroup_InvenCategory)
  self._ui.stc_moneyBGNew:SetShow(_ContentsGroup_InvenCategory)
  self._ui.txt_capacity:SetShow(not _ContentsGroup_InvenCategory)
  self._ui.stc_bottomBG:SetShow(not _ContentsGroup_InvenCategory)
  self._ui.btn_bottom_Crystal:SetShow(_ContentsGroup_JewelPreset)
  self._ui.btn_bottom_ArtifactBag:SetShow(_ContentsGroup_LightStoneBag)
  self._ui.btn_bottom_AlchemyFigureHead:SetShow(_ContentsGroup_AlchemyFigureHead)
  self._ui.btn_bottom_AlchemyStone:SetShow(_ContentsGroup_AlchemyStone)
  self._ui.btn_bottom_ReforgeStone:SetShow(_ContentsGroup_ReforgeStonePreset)
  local bottonBtnLeftTable = Array.new()
  bottonBtnLeftTable:push_back(self._ui.btn_bottom_Crystal)
  bottonBtnLeftTable:push_back(self._ui.btn_bottom_ArtifactBag)
  bottonBtnLeftTable:push_back(self._ui.btn_bottom_ReforgeStone)
  bottonBtnLeftTable:push_back(self._ui.btn_bottom_CombineBag)
  local count = 1
  for i = 1, #bottonBtnLeftTable do
    if bottonBtnLeftTable[i]:GetShow() == true then
      bottonBtnLeftTable[i]:SetSpanSize(self._ui.btn_bottom_Enchant:GetSpanSize().x + (self._ui.btn_bottom_Enchant:GetSizeX() + 5) * count, bottonBtnLeftTable[i]:GetSpanSize().y)
      count = count + 1
    end
  end
  local bottonBtnRightTable = Array.new()
  bottonBtnRightTable:push_back(self._ui.btn_bottom_AlchemyFigureHead)
  bottonBtnRightTable:push_back(self._ui.btn_bottom_AlchemyStone)
  bottonBtnRightTable:push_back(self._ui.btn_bottom_Palette)
  bottonBtnRightTable:push_back(self._ui.btn_bottom_RepairDekia)
  count = 1
  for i = 1, #bottonBtnRightTable do
    if bottonBtnRightTable[i]:GetShow() == true then
      bottonBtnRightTable[i]:SetSpanSize(self._ui.btn_bottom_Manufacture:GetSpanSize().x + (self._ui.btn_bottom_Manufacture:GetSizeX() + 10) * count, bottonBtnRightTable[i]:GetSpanSize().y)
      count = count + 1
    end
  end
  self._ui.rdo_normalInven:SetCheck(true)
  Panel_Window_Inventory_All:SetChildIndex(self._ui.stc_manufactureButtonBG, 10000)
  Panel_Window_Inventory_All:SetChildIndex(self._ui.stc_exchangeButtonBG, 10000)
  PaGlobal_Inventory_All:changeMileageIcon()
  Panel_Inventory_CoolTime_Effect_Item_Slot:RegisterShowEventFunc(true, "PaGlobalFunc_ItemCoolTimeEffect_ShowAni()")
  if false == _ContentsGroup_FamilyInventory or ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.rdo_familyInven:SetShow(false)
  else
    PaGlobal_Inventory_All:setSpanSizeInvenButtonsForService()
    self._ui.rdo_familyInven:SetTextMode(__eTextMode_AutoWrap)
    self._ui.rdo_familyInven:SetText(self._ui.rdo_familyInven:GetText())
    self._ui.txt_familyInventoryDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_familyInventoryDesc:SetText(self._ui.txt_familyInventoryDesc:GetText())
  end
  if false == _ContentsGroup_EnchantRemaster then
    self._ui.rdo_enchantMaterialInven:SetShow(false)
  else
    PaGlobal_Inventory_All:setSpanSizeInvenButtonsForService()
    self._ui.rdo_enchantMaterialInven:SetTextMode(__eTextMode_AutoWrap)
    self._ui.rdo_enchantMaterialInven:SetText(self._ui.rdo_enchantMaterialInven:GetText())
  end
  self:setRadioButtonPosition()
  self:deleteMode_clearData()
  self._ui.btn_alchemyFigureHead:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_CRYSTALBTN_TOOLTIPNAME"))
  PaGlobal_Inventory_All:setShowControlsForHardCoreChannel()
end
function PaGlobal_Inventory_All:registerEventHandler()
  if nil == Panel_Window_Inventory_All then
    return
  end
  self._ui.check_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_CheckPopUpUI()")
  self._ui.check_popup:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_PopupUITooltip(true)")
  self._ui.check_popup:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_PopupUITooltip(false)")
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowInventory\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question, "\"PanelWindowInventory\"")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Inventory_All_Close()")
  self._ui.rdo_normalInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  self._ui.rdo_pearlInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui.rdo_familyInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  else
    self._ui.rdo_familyInven:addInputEvent("Mouse_LUp", "PaGlobal_FamilyInvnetory_Open()")
  end
  self._ui.rdo_enchantMaterialInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SelectTab()")
  self._ui.button_sortOption:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_ShowSortOption()")
  self._ui.txt_capacity:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( true )")
  self._ui.txt_capacity:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_CapacityTooltip( true )")
  self._ui.txt_capacity:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_CapacityTooltip( false )")
  if true == _ContentsGroup_changeFamilyInvenOpenAction then
    self._ui.btn_moveFamilyInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.FamilyInventory .. ")")
    self._ui.btn_bottom_FamilyInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.FamilyInventory .. ")")
  end
  if _ContentsGroup_EnchantRemaster == true then
    self._ui.btn_moveEnchantInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.EnchantInventory .. ")")
    self._ui.btn_bottom_EnchantInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.EnchantInventory .. ")")
  end
  UIScroll.InputEvent(self._ui.scroll_inven, "HandleEventScroll_Inventory_All_UpdateScroll")
  UIScroll.InputEventByControl(self._ui.stc_scrollArea, "HandleEventScroll_Inventory_All_UpdateScroll")
  self._ui.stc_weightIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_WeightTooltip( true )")
  self._ui.stc_weightIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_WeightTooltip( false )")
  self._ui.stc_weightBG:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_WeightTooltip( true )")
  self._ui.stc_weightBG:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_WeightTooltip( false )")
  self._ui.btn_buyWeight:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( false )")
  self._ui.btn_buyWeight:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(true)")
  self._ui.btn_buyWeight:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(false)")
  self._ui.stc_moneyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 0)")
  self._ui.stc_moneyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 0)")
  self._ui.stc_pearlIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenPearlShop()")
  self._ui.stc_pearlIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 1)")
  self._ui.stc_pearlIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 1)")
  self._ui.stc_mileageIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 2)")
  self._ui.stc_mileageIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 2)")
  self._ui.stc_oceanIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 3)")
  self._ui.stc_oceanIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 3)")
  self._ui.stc_hardCoreIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 4)")
  self._ui.stc_hardCoreIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 4)")
  self._ui.stc_bottom_MoneyIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 0)")
  self._ui.stc_bottom_MoneyIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 0)")
  self._ui.stc_bottom_PearlIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenPearlShop()")
  self._ui.stc_bottom_PearlIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 1)")
  self._ui.stc_bottom_PearlIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 1)")
  self._ui.stc_bottom_MileageIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 2)")
  self._ui.stc_bottom_MileageIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 2)")
  self._ui.stc_bottom_OceanIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 3)")
  self._ui.stc_bottom_OceanIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 3)")
  self._ui.stc_bottom_hardCoreIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(true, 4)")
  self._ui.stc_bottom_hardCoreIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_MoneyIconTooltip(false, 4)")
  self._ui.stc_bottom_WeightIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_WeightTooltip( true )")
  self._ui.stc_bottom_WeightIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_WeightTooltip( false )")
  self._ui.stc_bottom_SlotIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_SlotInfoTooltip( true )")
  self._ui.stc_bottom_SlotIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_SlotInfoTooltip( false )")
  self._ui.stc_bottom_SlotIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( true )")
  self._ui.btn_bottom_BuyWeight:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( false )")
  self._ui.btn_bottom_BuyWeight:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(true)")
  self._ui.btn_bottom_BuyWeight:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BuyWeightTooltip(false)")
  self._ui.btn_bottom_BuySlot:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_EasyBuyOpen( true )")
  self._ui.btn_bottom_BuySlot:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BuySlotTooltip(true)")
  self._ui.btn_bottom_BuySlot:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BuySlotTooltip(false)")
  self._ui.btn_bottom_Enchant:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.Enchant .. ")")
  self._ui.btn_bottom_Enchant:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.Enchant .. " )")
  self._ui.btn_bottom_Enchant:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.Enchant .. " )")
  self._ui.btn_bottom_Crystal:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.JewelPreset .. ")")
  self._ui.btn_bottom_Crystal:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.JewelPreset .. " )")
  self._ui.btn_bottom_Crystal:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.JewelPreset .. " )")
  self._ui.btn_bottom_Crystal:setButtonShortcutsWithEvent("PaGlobalFunc_JewelPreset_Open()", "PANEL_ENCHANT_SOCKET_TITLE")
  self._ui.btn_bottom_ArtifactBag:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.LightStoneBag .. ")")
  self._ui.btn_bottom_ArtifactBag:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.LightStoneBag .. " )")
  self._ui.btn_bottom_ArtifactBag:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.LightStoneBag .. " )")
  self._ui.btn_bottom_Manufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.Manufacture .. ")")
  self._ui.btn_bottom_Manufacture:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.Manufacture .. " )")
  self._ui.btn_bottom_Manufacture:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.Manufacture .. " )")
  self._ui.btn_bottom_AlchemyFigureHead:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.AlchemyFigureHead .. ")")
  self._ui.btn_bottom_AlchemyFigureHead:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.AlchemyFigureHead .. " )")
  self._ui.btn_bottom_AlchemyFigureHead:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.AlchemyFigureHead .. " )")
  self._ui.btn_bottom_AlchemyStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.AlchemyStone .. ")")
  self._ui.btn_bottom_AlchemyStone:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.AlchemyStone .. " )")
  self._ui.btn_bottom_AlchemyStone:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.AlchemyStone .. " )")
  if _ContentsGroup_AlchemyStoneRenewal == true then
    self._ui.btn_bottom_AlchemyStone:setButtonShortcutsWithEvent("PaGlobalFunc_AlchemyStone_Renewal_All_Open()", "PANEL_SIMPLESHORTCUT_ALCHEMY_RECHARGE")
  else
    self._ui.btn_bottom_AlchemyStone:setButtonShortcutsWithEvent("PaGlobalFunc_AlchemyStone_All_Open()", "PANEL_SIMPLESHORTCUT_ALCHEMY_RECHARGE")
  end
  self._ui.btn_bottom_Palette:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.Palette .. ")")
  self._ui.btn_bottom_Palette:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.Palette .. " )")
  self._ui.btn_bottom_Palette:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.Palette .. " )")
  if _ContentsGroup_MonsterBuffZone == true and _ContentsGroup_InvenCategory == true then
    self._ui.btn_bottom_RepairDekia:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.RepairDekia .. ")")
    self._ui.btn_bottom_RepairDekia:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.RepairDekia .. " )")
    self._ui.btn_bottom_RepairDekia:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.RepairDekia .. " )")
  else
    self._ui.btn_bottom_RepairDekia:SetShow(false)
  end
  if _ContentsGroup_CombineBag == true then
    self._ui.btn_bottom_CombineBag:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.CombineBag .. ")")
    self._ui.btn_bottom_CombineBag:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.CombineBag .. " )")
    self._ui.btn_bottom_CombineBag:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.CombineBag .. " )")
  end
  if _ContentsGroup_ReforgeStonePreset == true then
    self._ui.btn_bottom_ReforgeStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.ReforgeStonePreset .. ")")
    self._ui.btn_bottom_ReforgeStone:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.ReforgeStonePreset .. " )")
    self._ui.btn_bottom_ReforgeStone:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.ReforgeStonePreset .. " )")
  end
  self._ui.btn_alchemyFigureHead:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.JewelPreset .. ")")
  self._ui.btn_alchemyFigureHead:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.JewelPreset .. " )")
  self._ui.btn_alchemyFigureHead:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.JewelPreset .. " )")
  self._ui.btn_alchemyStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.AlchemyStone .. " )")
  self._ui.btn_alchemyStone:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( true, " .. InventoryBottomOpenUIButtonIndex.AlchemyStone .. " )")
  self._ui.btn_alchemyStone:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip( false, " .. InventoryBottomOpenUIButtonIndex.AlchemyStone .. " )")
  if true == _ContentsGroup_AlchemyStone then
    self._ui.btn_alchemyStone:setButtonShortcuts("PANEL_SIMPLESHORTCUT_ALCHEMY_RECHARGE")
  end
  self._ui.btn_manufacture:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.Manufacture .. ")")
  self._ui.btn_manufacture:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.Manufacture .. ")")
  self._ui.btn_manufacture:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.Manufacture .. ")")
  self._ui.btn_dyePalette:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.Palette .. ")")
  self._ui.btn_dyePalette:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.Palette .. ")")
  self._ui.btn_dyePalette:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.Palette .. ")")
  if _ContentsGroup_LightStoneBag == true then
    self._ui.btn_lightStoneBag:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.LightStoneBag .. ")")
    self._ui.btn_lightStoneBag:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(true, " .. InventoryBottomOpenUIButtonIndex.LightStoneBag .. ")")
    self._ui.btn_lightStoneBag:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_BottomButtonTooltip(false, " .. InventoryBottomOpenUIButtonIndex.LightStoneBag .. ")")
  end
  self._ui.btn_openEquip:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenEquipment()")
  self._ui.chk_trash:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_ItemDelete()")
  self._ui.chk_trash:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_TrashTooltip( true )")
  self._ui.chk_trash:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_TrashTooltip( false )")
  self._ui.btn_bottom_Trash:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_ItemDelete()")
  self._ui.btn_bottom_Trash:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_TrashTooltip( true )")
  self._ui.btn_bottom_Trash:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_TrashTooltip( false )")
  self._ui.btn_sellEtcAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SellAllEtcItem()")
  self._ui.btn_doItemMove:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:requestMoveItemsInventoryToWarehouse(true)")
  self._ui.btn_setItemMove:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:prepareOpen()")
  self._ui.edit_search:addInputEvent("Mouse_LDown", "PaGlobal_Inventory_All:setFocusSearchText()")
  self._ui.edit_search:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:setFocusSearchText()")
  self._ui.edit_search:RegistReturnKeyEvent("PaGlobal_Inventory_All:searchItem()")
  self._ui.btn_search:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:searchItem()")
  self._ui.btn_searchReset:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:clearSearch()")
  self._ui.btn_searchReset:addInputEvent("Mouse_On", "HandleEventOnOut_Inventory_All_SearchResetTooltip(true)")
  self._ui.btn_searchReset:addInputEvent("Mouse_Out", "HandleEventOnOut_Inventory_All_SearchResetTooltip(false)")
  self._ui.btn_delete:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_RequestDeleteItemList()")
  self._ui.btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenRestorePanel()")
  self._ui.btn_bottom_Delete:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_RequestDeleteItemList()")
  self._ui.btn_bottom_Restore:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenRestorePanel()")
  self._ui.btn_familyInventoryBuySlot:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BuyFamilyInvenSlot()")
  self._ui.btn_familyInventoryQuest:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_FamilyInvenQuest()")
  self._ui.btn_bottom_OpenEquip:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_OpenEquipment()")
  self._ui.btn_bottom_AutoMove:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:requestMoveItemsInventoryToWarehouse(true)")
  self._ui.btn_bottom_AutoMoveAll:addInputEvent("Mouse_LUp", "PaGlobal_Inventory_All:requestMoveItemsInventoryToWarehouse(false)")
  self._ui.btn_bottom_SetAutoMove:addInputEvent("Mouse_LUp", "PaGlobal_ItemMoveSet:prepareOpen()")
  self._ui.btn_bottom_SellEtcAll:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_SellAllEtcItem()")
  self._ui.btn_bottom_ValksView:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_BottomButtonClick(" .. InventoryBottomOpenUIButtonIndex.ValksList .. ")")
  self._ui.btn_restoreProduct:addInputEvent("Mouse_LUp", "FGlobal_Window_PearlBox_Purchase_Restore()")
  self._ui.btn_cashProductBgClose:addInputEvent("Mouse_LUp", "HandleEventLUp_Inventory_All_cashProductRestoreBgClose()")
  Panel_Window_Inventory_All:RegisterShowEventFunc(true, "PaGlobalFunc_Inventory_All_ShowAni()")
  Panel_Window_Inventory_All:RegisterShowEventFunc(false, "PaGlobalFunc_Inventory_All_HideAni()")
  Panel_Window_Inventory_All:RegisterUpdateFunc("PaGlobalFunc_Inventory_All_UpdatePerFrame")
  registerEvent("FromClient_cursorOnOffSignal", "FromClient_Inventory_All_CursorOnOffSignal")
  registerEvent("FromClient_RenderModeChangeState", "FromClient_Inventory_All_RenderModeChange_FlushRestoreFunc")
  registerEvent("onScreenResize", "PaGlobalFunc_Inventory_All_OnScreenResize")
  registerEvent("FromClient_WeightChanged", "Invnetory_updateData")
  registerEvent("FromClient_InventoryUpdate", "FromClient_Inventory_All_UpdateSlotDataByAddItem")
  registerEvent("EventInventorySetShow", "PaGlobalFunc_Inventory_All_SetShow")
  registerEvent("EventInventorySetShowWithFilter", "FromClient_Inventory_All_SetShowWithFilter")
  registerEvent("EventAddItemToInventory", "FromClient_Inventory_All_AddItem")
  registerEvent("EventUnEquipItemToInventory", "FromClient_Inventory_All_UnequipItem")
  registerEvent("FromClient_UseItemAskFromOtherPlayer", "FromClient_Inventory_All_UseItemAskFromOtherPlayer")
  registerEvent("FromClient_FindExchangeItemNPC", "FromClient_Inventory_All_FindExchangeItemNPC")
  registerEvent("FromClient_InventoryUpdatebyAddItem", "FromClient_Inventory_All_UpdateSlotDataByAddItem")
  registerEvent("FromClient_UpdateInventoryBag", "FromClient_Inventory_All_UpdateSlotDataByAddItem")
  registerEvent("FromClient_OpenFamilyInventory", "FromClient_Inventory_All_OpenFamilyInventory")
  registerEvent("FromClient_DeleteItemSucceed", "FromClient_Inventory_All_DeleteItemSucceed")
  registerEvent("FromClient_ShowUseMapaeItemGuideMessageBox", "FromClient_Inventory_All_ShowUseMapaeItemGuideMessageBox")
  registerEvent("FromClient_NotifyWebCashRestoreCount", "FromClient_NotifyWebCashRestoreCount")
end
function PaGlobal_Inventory_All:validate()
  if nil == Panel_Window_Inventory_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.check_popup:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.btn_sellEtcAll:isValidate()
  self._ui.btn_doItemMove:isValidate()
  self._ui.btn_setItemMove:isValidate()
  self._ui.chk_trash:isValidate()
  self._ui.btn_delete:isValidate()
  self._ui.btn_restore:isValidate()
  self._ui.txt_trashDesc:isValidate()
end
function PaGlobal_Inventory_All:updateMoveItemCount(moveItemCount)
  if moveItemCount == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMMOVESET_EMPTY"))
  else
    PaGlobal_ItemMoveSet._fromItemCount = moveItemCount
  end
end
function PaGlobal_Inventory_All:getWaypointKeyTable()
  local waypointKeyTable = {}
  for index = 0, PaGlobal_WareHouse_All._maxTerritoryKeyCount - 1 do
    if PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index] ~= nil then
      for wIndex = 1, PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index]._count do
        table.insert(waypointKeyTable, PaGlobal_WareHouse_All._warehouseInfo._territoryGroup[index][wIndex])
      end
    end
  end
  return waypointKeyTable
end
function PaGlobal_Inventory_All:requestMoveItemsInventoryToWarehouse(isCurrentWarehouse)
  if isCurrentWarehouse == false and _ContentsGroup_ProjectAbyssOne == false and isGameServiceTypeConsole() == false then
    return
  end
  local isUISubApp = Panel_Window_Inventory_All:IsUISubApp()
  if isUISubApp == true and isCurrentWarehouse == false then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_TRASH_STICKER_MSG_DISABLE"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  PaGlobal_WareHouse_All._targetActorKeyRaw = getSelfPlayer():getActorKey()
  PaGlobal_AutoMove_Result_All:prepareOpen(isCurrentWarehouse)
end
function PaGlobal_Inventory_All:setIgnoreMoveItemButton(isIgnore)
  self._ui.btn_doItemMove:SetIgnore(isIgnore)
  self._ui.btn_setItemMove:SetIgnore(isIgnore)
  self._ui.btn_doItemMove:SetMonoTone(isIgnore)
  self._ui.btn_setItemMove:SetMonoTone(isIgnore)
  self._ui.btn_bottom_AutoMove:SetIgnore(isIgnore)
  self._ui.btn_bottom_AutoMoveAll:SetIgnore(isIgnore)
  self._ui.btn_bottom_SetAutoMove:SetIgnore(isIgnore)
  self._ui.btn_bottom_AutoMove:SetMonoTone(isIgnore)
  self._ui.btn_bottom_AutoMoveAll:SetMonoTone(isIgnore)
  self._ui.btn_bottom_SetAutoMove:SetMonoTone(isIgnore)
end
function PaGlobal_Inventory_All:reloadBottomBgFromMode(mode, isSetData)
  if Panel_Window_Inventory_All == nil then
    return
  end
  if mode == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_Inventory_All:reloadBottomBgFromMode] mode\234\176\128 nil\236\158\133\235\139\136\235\139\164!!", "\236\157\180\236\163\188")
    return
  end
  local invenBaseSizeY = 740
  local currentPosX = Panel_Window_Inventory_All:GetPosX()
  local currentPosY = getScreenSizeY() / 2 - invenBaseSizeY / 2
  local buttonBg_SizeY = 0
  local totalBottom_SizeY = 0
  local isUISubApp = Panel_Window_Inventory_All:IsUISubApp()
  local gap = 30
  if self._bottomBG_UIMode.Normal == mode then
    if self._ui.btn_doItemMove:GetShow() == true or self._ui.btn_setItemMove:GetShow() == true then
      self:reloadBottomBgFromMode(self._bottomBG_UIMode.OpenedWareHouse)
      return
    end
    buttonBg_SizeY = self._ui.btn_alchemyFigureHead:GetSizeY() + self._ui.btn_alchemyFigureHead:GetSpanSize().y + 10
    if _ContentsGroup_LightStoneBag == true then
      buttonBg_SizeY = buttonBg_SizeY + self._ui.btn_lightStoneBag:GetSizeY()
    end
    totalBottom_SizeY = buttonBg_SizeY + self._ui.stc_buttonBG:GetSpanSize().y
  elseif self._bottomBG_UIMode.ClickedTrashButton == mode then
    buttonBg_SizeY = 0
    totalBottom_SizeY = self._ui.txt_bottom_TrashDesc:GetSizeY() + self._ui.txt_bottom_TrashDesc:GetSpanSize().y
  elseif self._bottomBG_UIMode.OpenedEnchant == mode then
    buttonBg_SizeY = self._ui.btn_openEquip:GetSizeY() + self._ui.btn_openEquip:GetSpanSize().y + 10
    totalBottom_SizeY = buttonBg_SizeY + self._ui.stc_buttonBG:GetSpanSize().y
  elseif self._bottomBG_UIMode.OpenedWareHouse == mode then
    buttonBg_SizeY = 0
    if self._ui.btn_doItemMove:GetShow() == true then
      buttonBg_SizeY = self._ui.btn_doItemMove:GetSizeY() + self._ui.btn_doItemMove:GetSpanSize().y + 5
    elseif self._ui.btn_setItemMove:GetShow() == true then
      buttonBg_SizeY = self._ui.btn_setItemMove:GetSizeY() + self._ui.btn_setItemMove:GetSpanSize().y + 5
    end
    totalBottom_SizeY = buttonBg_SizeY + self._ui.stc_buttonBG:GetSpanSize().y
    if _ContentsGroup_InvenCategory == true then
      totalBottom_SizeY = totalBottom_SizeY + self._ui.btn_bottom_AutoMove:GetSizeY() + 10
    end
  elseif self._bottomBG_UIMode.OpenedSell == mode then
    buttonBg_SizeY = self._ui.btn_sellEtcAll:GetSizeY() + self._ui.btn_sellEtcAll:GetSpanSize().y + 5
    totalBottom_SizeY = buttonBg_SizeY + self._ui.stc_buttonBG:GetSpanSize().y
    if _ContentsGroup_InvenCategory == true then
      totalBottom_SizeY = totalBottom_SizeY + PaGlobal_Inventory_All._ui.btn_bottom_SellEtcAll:GetSizeY() + 10
    end
  elseif self._bottomBG_UIMode.OpenedCopy == mode then
    buttonBg_SizeY = self._ui.btn_openEquip:GetSizeY() + self._ui.btn_openEquip:GetSpanSize().y + 5
    totalBottom_SizeY = buttonBg_SizeY + self._ui.stc_buttonBG:GetSpanSize().y
  else
    UI.ASSERT_NAME(false, "\236\157\184\235\178\164\237\134\160\235\166\172\236\157\152 \237\149\152\235\139\168 \236\152\129\236\151\173 \237\129\172\234\184\176 \234\179\132\236\130\176\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164. \235\147\177\235\161\157\235\144\152\236\167\128 \236\149\138\236\157\128 mode \236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._ui.stc_buttonBG:SetSize(self._ui.stc_buttonBG:GetSizeX(), buttonBg_SizeY)
  self._ui.stc_bottomBG:SetSize(self._ui.stc_bottomBG:GetSizeX(), totalBottom_SizeY)
  self._ui.stc_bottomBGNew:SetSize(self._ui.stc_bottomBG:GetSizeX(), totalBottom_SizeY + 10)
  local mainSlotBg_SizeY = self._ui.stc_mainSlotBG:GetSizeY() + self._ui.stc_mainSlotBG:GetSpanSize().y
  local panel_SizeY = mainSlotBg_SizeY + totalBottom_SizeY + gap
  Panel_Window_Inventory_All:SetSize(Panel_Window_Inventory_All:GetSizeX(), panel_SizeY)
  if isSetData ~= nil and isSetData == true then
    PaGlobalFunc_Inventory_All_OnScreenResize()
    PaGlobalFunc_Equipment_All_OnScreenResize()
  end
  if false == Panel_Window_Inventory_All:GetShow() then
    Panel_Window_Inventory_All:SetPosX(currentPosX)
    Panel_Window_Inventory_All:SetPosY(currentPosY)
  end
end
