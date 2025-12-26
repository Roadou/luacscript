function PaGlobal_EnchantEquip_All:initialize()
  if Panel_Window_Enchant_Equip_All == nil or PaGlobal_EnchantEquip_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnchantEquip_All:controlInit()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  self._ui.stc_titleBox = UI.getChildControl(Panel_Window_Enchant_Equip_All, "Static_TitleBox")
  self._ui.radiobtn_Bg = UI.getChildControl(Panel_Window_Enchant_Equip_All, "Static_RadioButtonBg")
  self._ui.rdo_inven = UI.getChildControl(self._ui.radiobtn_Bg, "RadioButton_Inventory")
  self._ui.rdo_pearlInven = UI.getChildControl(self._ui.radiobtn_Bg, "RadioButton_Pearl_Inventory")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.radiobtn_Bg, "Static_SelectBar")
  self._ui.radiobtn_slot = UI.getChildControl(Panel_Window_Enchant_Equip_All, "RadioButton_Slot")
  self._ui.radiobtn_list = UI.getChildControl(Panel_Window_Enchant_Equip_All, "RadioButton_List")
  self._ui.frame_itemList = UI.getChildControl(Panel_Window_Enchant_Equip_All, "Frame_TotalReward_Import")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_itemList, "Frame_1_Content")
  self._ui.stc_listGroup = UI.getChildControl(self._ui.frame_content, "Static_ListGroup")
  self._ui.txt_noItem = UI.getChildControl(self._ui.frame_content, "StaticText_No_Itemlog")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_Enchant_Equip_All, "Static_Key_Guide")
  self._ui.scroll_vertical = UI.getChildControl(self._ui.frame_itemList, "Frame_1_VerticalScroll")
  self._ui.scroll_vertical_btn = UI.getChildControl(self._ui.scroll_vertical, "Frame_1_VerticalScroll_CtrlButton")
  for categoryType = 0, __eInvenCategoryType_Count - 1 do
    local tempContent = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_ListGroup", self._ui.frame_content, "CategoryGroup_" .. categoryType)
    if tempContent ~= nil then
      local tempTitleName = UI.createAndCopyBasePropertyControl(self._ui.stc_listGroup, "StaticText_GroupTitle", tempContent, "StaticText_GroupTitle_" .. categoryType)
      self._categoryList[categoryType] = {}
      self._categoryList[categoryType].content = tempContent
      self._categoryList[categoryType].titleName = tempTitleName
      self._categoryList[categoryType].titleName:SetText(ToClient_getCategoryNameByType(categoryType))
      self._categoryList[categoryType].content:SetShow(false)
      self._categoryList[categoryType].titleName:ChangeTextureInfoTextureIDAsync("Combine_Basic_Icon_02_Inventory_Category_" .. tostring(categoryType))
      self._categoryList[categoryType].titleName:setRenderTexture(self._categoryList[categoryType].titleName:getBaseTexture())
    end
  end
  self._ui.radiobtn_slot:SetCheck(true)
end
function PaGlobal_EnchantEquip_All:setConsoleUI()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  self._ui.stc_keyGuide:SetShow(false)
  local guideIconGroup = {}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.stc_keyGuide:ComputePos()
end
function PaGlobal_EnchantEquip_All:prepareOpen()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  PaGlobal_EnchantEquip_All._ui.frame_itemList:GetVScroll():SetControlTop()
  PaGlobal_EnchantEquip_All:open()
  ToClient_UpdateEnchantTargetList()
end
function PaGlobal_EnchantEquip_All:open()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  Panel_Window_Enchant_Equip_All:SetShow(true)
end
function PaGlobal_EnchantEquip_All:prepareClose()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_EnchantEquip_All:close()
end
function PaGlobal_EnchantEquip_All:close()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  Panel_Window_Enchant_Equip_All:SetShow(false)
end
function PaGlobal_EnchantEquip_All:registEventHandler()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  registerEvent("FromClient_UpdateEnchantEquip", "FromClient_UpdateEnchantEquip")
  self._ui.rdo_inven:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantEquip_ChangeInventoryType(" .. CppEnums.ItemWhereType.eInventory .. ")")
  self._ui.rdo_pearlInven:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantEquip_ChangeInventoryType(" .. CppEnums.ItemWhereType.eCashInventory .. ")")
  if self._isConsole == true then
    Panel_Window_Enchant_Equip_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_EnchantEquip_ChangeInventoryType(" .. CppEnums.ItemWhereType.eInventory .. ")")
    Panel_Window_Enchant_Equip_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_EnchantEquip_ChangeInventoryType(" .. CppEnums.ItemWhereType.eCashInventory .. ")")
  end
  self._ui.radiobtn_slot:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantEquip_SetItemSlots()")
  self._ui.radiobtn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantEquip_SetItemSlots()")
end
function PaGlobal_EnchantEquip_All:validate()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
end
function PaGlobal_EnchantEquip_All:update()
  if nil == Panel_Window_Enchant_Equip_All or Panel_Window_Enchant_Equip_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantEquip_All:setItemSlots()
  ToClient_padSnapRefreshTarget(Panel_Window_Enchant_Equip_All)
end
function PaGlobal_EnchantEquip_All:setItemSlots()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  if self._inventoryWhereType == CppEnums.ItemWhereType.eInventory then
    self._ui.stc_selectBar:SetPosX(self._ui.rdo_inven:GetPosX() + (self._ui.rdo_inven:GetSizeX() - self._ui.stc_selectBar:GetSizeX()) * 0.5)
  elseif self._inventoryWhereType == CppEnums.ItemWhereType.eCashInventory then
    self._ui.stc_selectBar:SetPosX(self._ui.rdo_pearlInven:GetPosX() + (self._ui.rdo_pearlInven:GetSizeX() - self._ui.stc_selectBar:GetSizeX()) * 0.5)
  end
  PaGlobal_EnchantEquip_All:resetSlot()
  local itemCount = ToClient_GetEnchantTargetListSize()
  PaGlobal_EnchantEquip_All._ui.txt_noItem:SetShow(false)
  PaGlobal_EnchantEquip_All._ui.stc_listGroup:SetShow(false)
  if itemCount == 0 then
    PaGlobal_EnchantEquip_All._ui.txt_noItem:SetShow(true)
    return
  end
  local sizeY = 0
  if self._ui.radiobtn_slot:IsCheck() == true then
    sizeY = PaGlobal_EnchantEquip_All:setItemSlotsBySlot()
  elseif self._ui.radiobtn_list:IsCheck() == true then
    sizeY = PaGlobal_EnchantEquip_All:setItemSlotsByList()
  end
  PaGlobal_EnchantEquip_All:updateFrameContent(sizeY)
  PaGlobal_EnchantEquip_All._ui.frame_itemList:UpdateContentScroll()
  PaGlobal_EnchantEquip_All._ui.frame_itemList:GetVScroll():SetControlTop()
  PaGlobal_EnchantEquip_All._ui.frame_itemList:UpdateContentPos()
end
function PaGlobal_EnchantEquip_All:setItemSlotsByList()
  PaGlobal_EnchantEquip_All._ui.stc_listGroup:SetShow(true)
  local categoryStartPosY = 0
  local groupItemSlotIndex = 0
  local itemStartPosY = self.SLOT_OFFSET
  local categorySizeY = 50
  local sortedList = {}
  local itemCount = ToClient_GetEnchantTargetListSize()
  for index = 1, itemCount do
    local itemWrapper = ToClient_GetEnchantTargetByIndex(index - 1)
    if itemWrapper ~= nil and itemWrapper:getItemWhereType() == self._inventoryWhereType then
      local categoryType = itemWrapper:getInventCategoryType()
      local showIndex = ToClient_getCategoryShowIndexByType(categoryType)
      if sortedList[showIndex] == nil then
        sortedList[showIndex] = {}
      end
      sortedList[showIndex][#sortedList[showIndex] + 1] = index
      sortedList[showIndex]._categoryType = categoryType
    end
  end
  for showIndex = 0, __eInvenCategoryType_Count - 1 do
    if sortedList[showIndex] ~= nil then
      local categoryType = sortedList[showIndex]._categoryType
      self._categoryList[categoryType].content:SetShow(true)
      self._categoryList[categoryType].content:SetSpanSize(0, categoryStartPosY + 10)
      groupItemSlotIndex = 0
      for _, realIndex in ipairs(sortedList[showIndex]) do
        local itemWrapper = ToClient_GetEnchantTargetByIndex(realIndex - 1)
        if itemWrapper ~= nil and itemWrapper:getItemWhereType() == self._inventoryWhereType then
          if PaGlobal_EnchantEquip_All._listItemSlots[realIndex] == nil then
            PaGlobal_EnchantEquip_All._listItemSlots[realIndex] = PaGlobal_EnchantEquip_All:createSlot(realIndex)
          end
          local slot = PaGlobal_EnchantEquip_All._listItemSlots[realIndex]
          local row = math.floor(groupItemSlotIndex / self.COLUMN_PER_ROW)
          local col = groupItemSlotIndex % self.COLUMN_PER_ROW
          local itemPosY = self._categoryList[categoryType].content:GetPosY() + categorySizeY
          slot.iconBg:SetPosX(PaGlobal_EnchantEquip_All.SLOT_OFFSET + PaGlobal_EnchantEquip_All.SLOT_SIZE * col)
          slot.iconBg:SetPosY(itemPosY + PaGlobal_EnchantEquip_All.SLOT_OFFSET + PaGlobal_EnchantEquip_All.SLOT_SIZE * row)
          slot.iconBg:SetShow(true)
          slot:clearItem(true)
          slot:setItem(itemWrapper, realIndex)
          Panel_Tooltip_Item_SetPosition(realIndex, slot, "EnchantEquip")
          if self._isConsole == true then
            slot.iconBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantEquip_Slot(" .. realIndex .. ", nil)")
            slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_EnchantEquip_Slot(" .. realIndex .. ")")
            slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantEquip_Slot(" .. realIndex .. ", false)")
          else
            slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_EnchantEquip_Slot(" .. realIndex .. ")")
            slot.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantEquip_Slot(" .. realIndex .. ", true)")
            slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantEquip_Slot(" .. realIndex .. ", false)")
          end
          groupItemSlotIndex = groupItemSlotIndex + 1
          itemStartPosY = slot.iconBg:GetPosY()
          categoryStartPosY = itemStartPosY + categorySizeY
        end
      end
    end
  end
  return categoryStartPosY + 10
end
function PaGlobal_EnchantEquip_All:setItemSlotsBySlot()
  PaGlobal_EnchantEquip_All._ui.stc_listGroup:SetShow(true)
  local itemCount = ToClient_GetEnchantTargetListSize()
  local row = 0
  local col = 0
  local uiIndex = 1
  for index = 1, itemCount do
    local itemWrapper = ToClient_GetEnchantTargetByIndex(index - 1)
    if itemWrapper ~= nil and itemWrapper:getItemWhereType() == self._inventoryWhereType then
      if PaGlobal_EnchantEquip_All._listItemSlots[index] == nil then
        PaGlobal_EnchantEquip_All._listItemSlots[index] = PaGlobal_EnchantEquip_All:createSlot(index)
      end
      local slot = PaGlobal_EnchantEquip_All._listItemSlots[index]
      row = math.floor((uiIndex - 1) / PaGlobal_EnchantEquip_All.COLUMN_PER_ROW)
      col = (uiIndex - 1) % PaGlobal_EnchantEquip_All.COLUMN_PER_ROW
      slot.iconBg:SetPosX(PaGlobal_EnchantEquip_All.SLOT_OFFSET + PaGlobal_EnchantEquip_All.SLOT_SIZE * col)
      slot.iconBg:SetPosY(PaGlobal_EnchantEquip_All.SLOT_OFFSET + PaGlobal_EnchantEquip_All.SLOT_SIZE * row)
      slot.iconBg:SetShow(true)
      slot:clearItem(true)
      slot:setItem(itemWrapper, index)
      Panel_Tooltip_Item_SetPosition(index, slot, "EnchantEquip")
      if self._isConsole == true then
        slot.iconBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantEquip_Slot(" .. index .. ", nil)")
        slot.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_EnchantEquip_Slot(" .. index .. ")")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantEquip_Slot(" .. index .. ", false)")
      else
        slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_EnchantEquip_Slot(" .. index .. ")")
        slot.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantEquip_Slot(" .. index .. ", true)")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantEquip_Slot(" .. index .. ", false)")
      end
      uiIndex = uiIndex + 1
    end
  end
  return PaGlobal_EnchantEquip_All.SLOT_OFFSET + PaGlobal_EnchantEquip_All.SLOT_SIZE * (row + 1)
end
function PaGlobal_EnchantEquip_All:updateFrameContent(sizeY)
  PaGlobal_EnchantEquip_All._ui.frame_content:SetSize(PaGlobal_EnchantEquip_All._ui.frame_content:GetSizeX(), sizeY)
  local tempSizeY = PaGlobal_EnchantEquip_All._ui.scroll_vertical:GetSizeY() * (PaGlobal_EnchantEquip_All.CONTENT_MIN_HEIGHT / PaGlobal_EnchantEquip_All._ui.frame_content:GetSizeY())
  PaGlobal_EnchantEquip_All._ui.scroll_vertical_btn:SetSize(PaGlobal_EnchantEquip_All._ui.scroll_vertical_btn:GetSizeX(), tempSizeY)
  PaGlobal_EnchantEquip_All._ui.frame_itemList:UpdateContentScroll()
  PaGlobal_EnchantEquip_All._ui.frame_itemList:UpdateContentPos()
end
function PaGlobal_EnchantEquip_All:resetSlot()
  if nil == Panel_Window_Enchant_Equip_All then
    return
  end
  for ii = 0, __eInvenCategoryType_Count - 1 do
    if self._categoryList[ii] ~= nil then
      self._categoryList[ii].content:SetShow(false)
    end
  end
  for index = 1, #PaGlobal_EnchantEquip_All._listItemSlots do
    if PaGlobal_EnchantEquip_All._listItemSlots[index] ~= nil then
      Panel_Tooltip_Item_Show_GeneralStatic(index, "EnchantEquip", false, false)
      PaGlobal_EnchantEquip_All._listItemSlots[index]:clearItem()
      PaGlobal_EnchantEquip_All._listItemSlots[index].iconBg:SetShow(false)
      PaGlobal_EnchantEquip_All._listItemSlots[index].icon:addInputEvent("Mouse_RUp", "")
      PaGlobal_EnchantEquip_All._listItemSlots[index].icon:addInputEvent("Mouse_On", "")
      PaGlobal_EnchantEquip_All._listItemSlots[index].icon:addInputEvent("Mouse_Out", "")
    end
  end
  for index = 1, #PaGlobal_EnchantEquip_All._listItemSlots do
    if PaGlobal_EnchantEquip_All._listItemSlots[index] ~= nil then
      Panel_Tooltip_Item_Show_GeneralStatic(index, "EnchantEquip", false, false)
      PaGlobal_EnchantEquip_All._listItemSlots[index]:clearItem()
      PaGlobal_EnchantEquip_All._listItemSlots[index].iconBg:SetShow(false)
      PaGlobal_EnchantEquip_All._listItemSlots[index].icon:addInputEvent("Mouse_RUp", "")
      PaGlobal_EnchantEquip_All._listItemSlots[index].icon:addInputEvent("Mouse_On", "")
      PaGlobal_EnchantEquip_All._listItemSlots[index].icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_EnchantEquip_All:createSlot(index)
  local keyString = "EnchantEquip_SlotBG_"
  local itemSlotBg = UI.createAndCopyBasePropertyControl(PaGlobal_EnchantEquip_All._ui.stc_listGroup, "Static_ItemSlotBg", PaGlobal_EnchantEquip_All._ui.frame_content, keyString .. tostring(index))
  local itemSlot = {}
  SlotItem.new(itemSlot, keyString .. tostring(index), index, itemSlotBg, PaGlobal_EnchantEquip_All._slotConfig)
  itemSlot:createChild()
  itemSlot.iconBg = itemSlotBg
  itemSlotBg:SetShow(true)
  itemSlotBg:SetIgnore(false)
  itemSlot.icon:SetAutoDisableTime(0.5)
  return itemSlot
end
function PaGlobal_EnchantEquip_All:changeInventoryType(inventoryWhereType)
  self._inventoryWhereType = inventoryWhereType
  self:update()
end
