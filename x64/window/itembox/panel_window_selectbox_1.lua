function PaGlobal_SelectBox:initialize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_keyGuideBg:SetShow(true == self._isConsole)
  local stc_keyGuide_LB = UI.getChildControl(self._ui._stc_category, "Static_KeyGuide_LB")
  local stc_keyGuide_RB = UI.getChildControl(self._ui._stc_category, "Static_KeyGuide_RB")
  local stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  local stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  local stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  local stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBg, "StaticText_X_ConsoleUI")
  stc_keyGuide_LB:SetShow(true == self._isConsole)
  stc_keyGuide_RB:SetShow(true == self._isConsole)
  stc_keyGuide_B:SetShow(true == self._isConsole)
  stc_keyGuide_A:SetShow(true == self._isConsole)
  stc_keyGuide_Y:SetShow(true == self._isConsole)
  stc_keyGuide_X:SetShow(true == self._isConsole)
  local keyGuide = {
    stc_keyGuide_X,
    stc_keyGuide_Y,
    stc_keyGuide_A,
    stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Win_Close")
  self._ui._btn_close:SetShow(false == self._isConsole)
  self._ui._btn_ok:SetShow(false == self._isConsole)
  self._ui._btn_cancel:SetShow(false == self._isConsole)
  self:createCategoryTab()
  self:createSelectedSlot()
  self._ui._list2_items = UI.getChildControl(self._ui._stc_mainBg, "List2_ItemList_0")
  self._ui._stctxt_desc = UI.getChildControl(self._ui._stc_descBg, "StaticText_DescText")
  self._ui._stctxt_desc:SetTextMode(__eTextMode_AutoWrap)
  local list2Content = UI.getChildControl(self._ui._list2_items, "List2_1_Content")
  local rdoBtn = UI.getChildControl(list2Content, "RadioButton_ItemTemplete")
  local list2SlotBg = UI.getChildControl(rdoBtn, "Static_Icon_BG")
  local listItemSlot = {}
  SlotItem.new(listItemSlot, "selectBoxItemSlot_", 0, list2SlotBg, self._slotConfig)
  listItemSlot:createChild()
  listItemSlot.icon:SetSize(43, 43)
  listItemSlot.icon:SetPosY(2)
  listItemSlot.icon:SetPosY(2)
  self:validate()
  self:registerEvent()
  self._cachedData._origin_selectedBg_SizeX = self._ui._stc_selectedBg:GetSizeX()
  self._cachedData._origin_selectedBg_SizeY = self._ui._stc_selectedBg:GetSizeY()
  self._cachedData._origin_mainBg_SizeX = self._ui._stc_mainBg:GetSizeX()
  self._cachedData._origin_mainBg_SizeY = self._ui._stc_mainBg:GetSizeY()
  self._cachedData._origin_panel_SizeX = Panel_Window_SelectBox:GetSizeX()
  self._cachedData._origin_panel_SizeY = Panel_Window_SelectBox:GetSizeY()
  self._cachedData._origin_cancelBtn_SpanX = self._ui._btn_cancel:GetSpanSize().x
  self._cachedData._origin_cancelBtn_SpanY = self._ui._btn_cancel:GetSpanSize().y
  if true == self._isConsole then
    self._cachedData._origin_panel_SizeY = self._cachedData._origin_panel_SizeY - self._ui._btn_ok:GetSizeY() - 20
    self._ui._stc_selectedBg:SetSpanSize(self._ui._stc_selectedBg:GetSpanSize().x, 0)
  end
  self._initialize = true
end
function PaGlobal_SelectBox:clear()
  ToClient_clearSelectBoxIndexList()
  self._selectBoxKey = 0
  self._selectedType = -1
  self._fromWhereType = nil
  self._fromSlotNo = nil
  self._isCalledByCashShop = false
  self._ui._btn_ok:SetIgnore(true)
  self._ui._btn_ok:SetMonoTone(true)
  self._maxCount = 0
  self._snappedIndex = 0
  for ii = 0, __eSelectBoxTypeCount - 1 do
    local slot = self._ui._selectedItemSlot[ii]
    slot:clearItem()
    slot.itemEnchantKeyRaw = 0
  end
  self._ui._txt_selectedItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMBOX_DESC_SELECTREWARD"))
  self._selectItemCount = 0
  self._selectIndex = Array.new()
  self._slotNo = Array.new()
end
function PaGlobal_SelectBox:prepareOpen(fromWhereType, fromSlotNo)
  self:open(fromWhereType, fromSlotNo)
end
function PaGlobal_SelectBox:open(fromWhereType, fromSlotNo)
  if false == _ContentsGroup_SelectBox then
    return
  end
  if false == self._initialize then
    return
  end
  if nil == fromWhereType or nil == fromSlotNo then
    return
  end
  local itemSSW = getInventoryItemByType(fromWhereType, fromSlotNo)
  if nil == itemSSW then
    return
  end
  self:setItemAndShow(itemSSW:getStaticStatus(), false, fromWhereType, fromSlotNo)
  local selectedItemKey = itemSSW:getStaticStatus():get()._key:get()
  local inventorysize = ToClient_InventoryGetSize(fromWhereType)
  for ii = 0, inventorysize - 1 do
    local itemWrapper = getInventoryItemByType(fromWhereType, ii)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local itemKey = itemSSW:get()._key:get()
      if itemKey == selectedItemKey then
        self._slotNo[self._selectItemCount] = ii
        self._selectItemCount = self._selectItemCount + 1
      end
    end
  end
end
function PaGlobal_SelectBox:setItemAndShow(selctBoxItemSS, calledByCashShop, fromWhereType, fromSlotNo)
  if __eContentsType_SelectBox ~= selctBoxItemSS:getContentsEventType() then
    _PA_ASSERT(false, "ContentsEventType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    return
  end
  self:clear()
  self._isCalledByCashShop = calledByCashShop
  self._selectBoxKey = selctBoxItemSS:getContentsEventParam1()
  for ii = 0, __eSelectBoxTypeCount - 1 do
    local itemCount = ToClient_selectBoxTotalItemCount(self._selectBoxKey, ii)
    local tab = self._ui._tab[ii]
    local slot = self._ui._selectedItemSlot[ii]
    if itemCount > 0 then
      local textureName = ToClient_selectBoxTextureName(self._selectBoxKey, ii)
      tab.icon:ChangeTextureInfoTextureIDAsync(textureName .. "_Normal", 0)
      tab.icon:ChangeTextureInfoTextureIDAsync(textureName .. "_Over", 1)
      tab.icon:ChangeTextureInfoTextureIDAsync(textureName .. "_Select", 2)
      tab.icon:setRenderTexture(tab.icon:getBaseTexture())
      tab:SetShow(true)
      slot:SetShow(true)
      self._selectIndex[ii] = -1
      self._maxCount = self._maxCount + 1
    else
      tab:SetShow(false)
      slot:SetShow(false)
    end
  end
  if false == self._isConsole then
    self._ui._btn_ok:SetShow(not calledByCashShop)
  end
  self._ui._stc_selectedBg:SetShow(not calledByCashShop)
  self._ui._stc_descBg:SetShow(calledByCashShop)
  self._ui._stctxt_desc:SetShow(calledByCashShop)
  if true == calledByCashShop then
    UI.getChildControl(self._ui._stc_titleBg, "StaticText_Title"):SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMSELECTBOX_TITLE_FOR_CASHSHOP"))
    self._ui._btn_cancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_NEWCART_BTN_CLOSE"))
    self._ui._stc_mainBg:SetSize(self._cachedData._origin_mainBg_SizeX, self._cachedData._origin_mainBg_SizeY - self._cachedData._origin_selectedBg_SizeY)
    self._ui._btn_cancel:SetSpanSize(0, self._cachedData._origin_cancelBtn_SpanY)
    self._ui._stctxt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_SELECTPRODUCT_BYONE"))
    self._ui._stctxt_desc:SetSize(self._ui._stctxt_desc:GetSizeX(), self._ui._stctxt_desc:GetTextSizeY())
    self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), self._ui._stctxt_desc:GetSizeY() + 20)
    self._ui._stc_descBg:SetSpanSize(0, self._ui._btn_cancel:GetSizeY() + self._ui._btn_cancel:GetSpanSize().y + 10)
    if true == self._isConsole then
      self._ui._stc_descBg:SetSpanSize(0, self._ui._stc_keyGuideBg:GetSizeY() + self._ui._stc_keyGuideBg:GetSpanSize().y + 4)
    end
    local panelSizePadY = self._ui._stc_descBg:GetSizeY() + self._ui._btn_cancel:GetSpanSize().y
    Panel_Window_SelectBox:SetSize(self._cachedData._origin_panel_SizeX, self._cachedData._origin_panel_SizeY - self._cachedData._origin_selectedBg_SizeY + panelSizePadY)
  else
    UI.getChildControl(self._ui._stc_titleBg, "StaticText_Title"):SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ITEMSELECTBOX_TITLE"))
    self._ui._btn_cancel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    self._ui._stc_mainBg:SetSize(self._cachedData._origin_mainBg_SizeX, self._cachedData._origin_mainBg_SizeY)
    self._ui._btn_cancel:SetSpanSize(self._cachedData._origin_cancelBtn_SpanX, self._cachedData._origin_cancelBtn_SpanY)
    Panel_Window_SelectBox:SetSize(self._cachedData._origin_panel_SizeX, self._cachedData._origin_panel_SizeY)
  end
  self._ui._stc_titleBg:ComputePos()
  self._ui._stc_category:ComputePos()
  self._ui._stc_mainBg:ComputePos()
  self._ui._stc_selectedBg:ComputePos()
  self._ui._btn_ok:ComputePos()
  self._ui._btn_cancel:ComputePos()
  self._ui._stc_keyGuideBg:ComputePos()
  self._ui._stc_descBg:ComputePos()
  Panel_Window_SelectBox:ComputePos()
  local totalSizeX = self._ui._stc_selectedBg:GetSizeX()
  local gapX = 10
  local slotSizeX = self._ui._selectedItemSlot[0].bg:GetSizeX()
  local slotListSizeX = slotSizeX * self._maxCount + gapX * (self._maxCount - 1)
  local initPosX = (totalSizeX - slotListSizeX) / 2
  for ii = 0, self._maxCount - 1 do
    local slot = self._ui._selectedItemSlot[ii]
    slot:SetPosX(initPosX + (slotSizeX + gapX) * ii)
  end
  self:selectTab(0)
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  Panel_Window_SelectBox:SetShow(true)
end
function PaGlobal_SelectBox:prepareClose()
  if true == self._isCurrentMouseOnItemSlot then
    self:hideItemTooltip()
  end
  if true == self._isCurrentShowRewardMessageBox then
    return
  end
  self._isCurrentShowRewardMessageBox = false
  self:close()
end
function PaGlobal_SelectBox:close()
  Panel_Window_SelectBox:SetShow(false)
end
function PaGlobal_SelectBox:validate()
  self._ui._stc_titleBg:isValidate()
  self._ui._stc_category:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_selectedBg:isValidate()
  self._ui._txt_selectedItem:isValidate()
  self._ui._btn_ok:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._list2_items:isValidate()
  self._ui._stc_keyGuideBg:isValidate()
  self._ui._stc_descBg:isValidate()
  self._ui._stctxt_desc:isValidate()
end
function PaGlobal_SelectBox:registerEvent()
  if true == self._isConsole then
    Panel_Window_SelectBox:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobal_SelectBox:moveTab(-1)")
    Panel_Window_SelectBox:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_SelectBox:moveTab(1)")
    Panel_Window_SelectBox:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_SelectBox:prepareClose()")
    Panel_Window_SelectBox:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_SelectBox:requestSelectBoxOpen()")
    Panel_Window_SelectBox:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_SelectBox:detailItemInfo()")
  else
    self._ui._btn_ok:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:requestSelectBoxOpen()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:prepareClose()")
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:prepareClose()")
  end
  self._ui._list2_items:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_SelectBox_List2Update")
  self._ui._list2_items:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_useSelectBox", "FromClient_useSelectBox")
  registerEvent("FromClient_SelectFantasyServant", "FromClient_SelectFantasyServant")
end
function PaGlobal_SelectBox:createCategoryTab()
  local rdo_base = UI.getChildControl(self._ui._stc_category, "RadioButton_Category_Templete")
  local initPosX = rdo_base:GetPosX()
  local sizeX = rdo_base:GetSizeX()
  self._ui._tab = {}
  for ii = 0, __eSelectBoxTypeCount - 1 do
    do
      local tab = {button = nil, icon = nil}
      function tab:SetShow(isShow)
        tab.button:SetShow(isShow)
      end
      tab.button = UI.cloneControl(rdo_base, self._ui._stc_category, "Category_" .. ii)
      tab.button:SetShow(false)
      tab.button:SetPosX(initPosX + (sizeX + 5) * ii)
      tab.button:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:selectTab(" .. ii .. ")")
      tab.icon = UI.getChildControl(tab.button, "Static_CategoryIcon")
      tab.icon:addInputEvent("Mouse_LUp", "PaGlobal_SelectBox:selectTab(" .. ii .. ")")
      self._ui._tab[ii] = tab
    end
  end
  UI.deleteControl(rdo_base)
end
function PaGlobal_SelectBox:createSelectedSlot()
  local stc_slotBg = UI.getChildControl(self._ui._stc_selectedBg, "Static_Icon_BG")
  self._ui._selectedItemSlot = {}
  for ii = 0, __eSelectBoxTypeCount - 1 do
    do
      local slot = {bg = nil, itemEnchantKeyRaw = 0}
      function slot:SetShow(isShow)
        slot.bg:SetShow(isShow)
      end
      function slot:GetShow()
        return slot.bg:GetShow()
      end
      function slot:SetPosX(posX)
        slot.bg:SetPosX(posX)
      end
      slot.bg = UI.cloneControl(stc_slotBg, self._ui._stc_selectedBg, "SelectedItemSlot_" .. ii)
      slot.bg:SetShow(false)
      slot.bg:SetIgnore(false)
      SlotItem.new(slot, "SelectedItemIcon_" .. ii, ii, slot.bg, self._slotConfig)
      slot:createChild()
      slot.icon:SetPosX(0)
      slot.icon:SetPosY(0)
      slot.icon:SetShow(true)
      slot.icon:addInputEvent("Mouse_On", "PaGlobal_SelectBox:showSelectedItemTooltip(" .. ii .. ")")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobal_SelectBox:hideItemTooltip()")
      slot.icon:SetIgnore(false)
      self._ui._selectedItemSlot[ii] = slot
    end
  end
  UI.deleteControl(stc_slotBg)
  self._ui._txt_selectedItem = UI.getChildControl(self._ui._stc_selectedBg, "StaticText_Desc")
end
function PaGlobal_SelectBox:requestSelectBoxOpen()
  if true == self._isCurrentShowRewardMessageBox then
    return
  end
  local rv = ToClient_checkSelectBoxOpen(self._fromWhereType, self._fromSlotNo)
  if 0 ~= rv then
    return
  end
  local itemWrapper = getInventoryItemByType(self._fromWhereType, self._fromSlotNo)
  if itemWrapper ~= nil and itemWrapper:getStaticStatus() ~= nil then
    local selectBoxContentsEventParam1 = itemWrapper:getStaticStatus():getContentsEventParam1()
    if selectBoxContentsEventParam1 == 106 or selectBoxContentsEventParam1 == 177 or selectBoxContentsEventParam1 == 230 or selectBoxContentsEventParam1 == 238 or selectBoxContentsEventParam1 == 300 or selectBoxContentsEventParam1 == 305 or selectBoxContentsEventParam1 == 321 then
      local servantKey, itemKey, selectedItemName
      for ii = 0, self._maxCount - 1 do
        local slot = self._ui._selectedItemSlot[ii]
        if nil == slot then
          return
        end
        local idx = ToClient_getSelectBoxIndex(ii)
        itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, ii, idx)
        local itemSSW = getItemEnchantStaticStatus(itemKey)
        if nil ~= itemSSW then
          if selectBoxContentsEventParam1 == 106 or selectBoxContentsEventParam1 == 230 then
            servantKey = itemSSW:getObjectKey():get()
          else
            servantKey = itemSSW:get()._key:get()
          end
          selectedItemName = itemSSW:getName()
        end
      end
      if servantKey > 0 or itemKey:get() == self._dreamSwiftItemKey then
        local confirmText
        if itemKey:get() == self._dreamSwiftItemKey then
          confirmText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FANTASYHORSE_" .. tostring(self._dreamSwiftItemKey))
        elseif selectBoxContentsEventParam1 == 106 then
          confirmText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FANTASYHORSE_" .. tostring(servantKey))
        elseif selectBoxContentsEventParam1 == 230 then
          confirmText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DREAMHORSE_" .. tostring(servantKey))
        elseif selectBoxContentsEventParam1 == 177 then
          confirmText = PAGetString(Defines.StringSheet_GAME, "LUA_MAXBLACKWEAPON_" .. tostring(servantKey))
        else
          confirmText = selectedItemName
        end
        if configrmText == "" then
          return
        end
        local function doBoxOpen()
          ToClient_requestBoxItemOpen(self._fromWhereType, self._fromSlotNo)
          self._isCurrentShowRewardMessageBox = false
          self:prepareClose()
        end
        local function dontBoxOpen()
          self._isCurrentShowRewardMessageBox = false
        end
        local msgData = {
          confirmText = confirmText,
          functionYes = doBoxOpen,
          functionNo = dontBoxOpen,
          desc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_FANTASYHORSE_DESC", "itemName", "[" .. selectedItemName .. "]"),
          bottomRedDesc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FANTASYHORSE_ALERT"),
          isUseBottomTextMultiline = true,
          isLongEditCheck = selectBoxContentsEventParam1
        }
        PaGlobalFunc_MessageBox_Edit_All_Open(msgData)
        self._isCurrentShowRewardMessageBox = true
        return
      end
    end
  end
  local manyOpen = function(count)
    PaGlobal_SelectBox:requestManyBoxOpen(count)
  end
  if 1 < self._selectItemCount then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, 0, 0)
    local selectedItemSSW = getItemEnchantStaticStatus(itemKey)
    local isCash = selectedItemSSW:isCash()
    local openItemCount = self._selectItemCount
    if true == isCash then
      local cashInventory = selfPlayer:get():getCashInventory()
      local cashFreeCount = Int64toInt32(cashInventory:getFreeCount())
      openItemCount = math.min(openItemCount, (cashFreeCount - cashFreeCount % self._maxCount) / self._maxCount)
      if openItemCount <= 0 then
        Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_SELECTBOX_CASHINVENTORY_SLOT_ALERT"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
        return
      end
    else
      local inventory = selfPlayer:get():getInventory()
      local freeCount = Int64toInt32(inventory:getFreeCount())
      openItemCount = math.min(openItemCount, (freeCount - freeCount % self._maxCount) / self._maxCount)
      if openItemCount <= 0 then
        Proc_ShowMessage_Ack_With_ChatType(PAGetString(Defines.StringSheet_GAME, "LUA_SELECTBOX_INVENTORY_SLOT_ALERT"), nil, CppEnums.ChatType.System, CppEnums.ChatSystemType.Undefine)
        return
      end
    end
    Panel_NumberPad_Show(true, toInt64(0, openItemCount), 0, manyOpen)
    return
  end
  local function doBoxOpen()
    ToClient_requestBoxItemOpen(self._fromWhereType, self._fromSlotNo)
    self._isCurrentShowRewardMessageBox = false
    self:prepareClose()
  end
  local function dontBoxOpen()
    self._isCurrentShowRewardMessageBox = false
  end
  local txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMSELECTBOX_SELECT_DESC") .. [[


]]
  for ii = 0, self._maxCount - 1 do
    local slot = self._ui._selectedItemSlot[ii]
    if nil == slot then
      return
    end
    local idx = ToClient_getSelectBoxIndex(ii)
    local itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, ii, idx)
    local itemCount = ToClient_selectBoxItemCount(self._selectBoxKey, ii, idx)
    local itemSSW = getItemEnchantStaticStatus(itemKey)
    if nil ~= itemSSW then
      txt_desc = txt_desc .. itemSSW:getName() .. " X " .. tostring(itemCount)
    end
    if ii < self._maxCount then
      txt_desc = txt_desc .. "\n"
    end
  end
  local msgData = {
    content = txt_desc,
    functionYes = doBoxOpen,
    functionNo = dontBoxOpen
  }
  PaGlobal_MessageBox_ForReward:prepareOpen(msgData)
  self._isCurrentShowRewardMessageBox = true
end
function PaGlobal_SelectBox:requestManyBoxOpen(count)
  if nil == count then
    return
  end
  local openBoxCount = Int64toInt32(count)
  local function doBoxOpen()
    local temp = {}
    for ii = 0, self._maxCount - 1 do
      local idx = ToClient_getSelectBoxIndex(ii)
      temp[ii] = idx
    end
    for index = 0, openBoxCount - 1 do
      for ii = 0, self._maxCount - 1 do
        ToClient_setSelectBoxIndex(ii, temp[ii])
      end
      ToClient_requestBoxItemOpen(self._fromWhereType, self._slotNo[index])
    end
    self._isCurrentShowRewardMessageBox = false
    self:prepareClose()
  end
  local function dontBoxOpen()
    self._isCurrentShowRewardMessageBox = false
  end
  local txt_desc = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMSELECTBOX_SELECT_DESC") .. [[


]]
  for ii = 0, self._maxCount - 1 do
    local slot = self._ui._selectedItemSlot[ii]
    if nil == slot then
      return
    end
    local idx = ToClient_getSelectBoxIndex(ii)
    local itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, ii, idx)
    local itemCount = ToClient_selectBoxItemCount(self._selectBoxKey, ii, idx)
    local itemSSW = getItemEnchantStaticStatus(itemKey)
    if nil ~= itemSSW then
      txt_desc = txt_desc .. itemSSW:getName() .. " X " .. tostring(itemCount * count)
    end
    if ii < self._maxCount then
      txt_desc = txt_desc .. "\n"
    end
  end
  local msgData = {
    content = txt_desc,
    functionYes = doBoxOpen,
    functionNo = dontBoxOpen
  }
  PaGlobal_MessageBox_ForReward:prepareOpen(msgData)
  self._isCurrentShowRewardMessageBox = true
end
function PaGlobal_SelectBox:selectedItem(selectedType, idx)
  if true == self._isCurrentShowRewardMessageBox then
    return
  end
  if true == self._isCalledByCashShop then
    return
  end
  if self._selectedType ~= selectedType then
    return
  end
  local itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, self._selectedType, idx)
  local itemCount = ToClient_selectBoxItemCount(self._selectBoxKey, self._selectedType, idx)
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if nil == itemSSW then
    return
  end
  local slot = self._ui._selectedItemSlot[selectedType]
  if nil == slot or false == slot:GetShow() then
    return
  end
  slot.itemEnchantKeyRaw = itemKey:get()
  slot:setItemByStaticStatus(itemSSW, itemCount)
  slot.icon:AddEffect("fUI_Us_Item_Select_01A", false, 0, 0)
  ToClient_setSelectBoxIndex(selectedType, idx)
  self._selectIndex[selectedType] = idx
  local rv = ToClient_checkSelectBoxOpen(self._fromWhereType, self._fromSlotNo)
  if 0 == rv then
    self._ui._btn_ok:SetIgnore(false)
    self._ui._btn_ok:SetMonoTone(false)
    self._ui._txt_selectedItem:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEMBOX_DESC_REWARDCONFIRM"))
  end
  local rv = ToClient_checkSelectBoxOpen(self._fromWhereType, self._fromSlotNo)
  if 0 ~= rv then
    local nextType = selectedType + 1
    if nextType < self._maxCount then
      self:selectTab(nextType)
    end
  end
  local list2Count = Int64toInt32(self._ui._list2_items:getElementManager():getSize())
  for ii = 0, list2Count - 1 do
    self._ui._list2_items:requestUpdateByKey(ii)
  end
end
function PaGlobal_SelectBox:moveTab(value)
  if false == self._isConsole then
    return
  end
  local index = self._selectedType + value
  if index < 0 then
    index = self._maxCount - 1
  else
    if index >= self._maxCount then
      index = 0
    else
    end
  end
  self:selectTab(index)
  self:hideItemTooltip()
end
function PaGlobal_SelectBox:selectTab(newSelectedType)
  if true == self._isCurrentShowRewardMessageBox then
    return
  end
  local oldSelectedType = self._selectedType
  if newSelectedType == oldSelectedType then
    return
  end
  for ii = 0, __eSelectBoxTypeCount - 1 do
    self._ui._tab[ii].button:SetCheck(false)
  end
  local newTab = self._ui._tab[newSelectedType]
  local newTextureName = ToClient_selectBoxTextureName(self._selectBoxKey, newSelectedType)
  newTab.button:SetCheck(true)
  newTab.icon:ChangeTextureInfoTextureIDAsync(newTextureName .. "_Over", 0)
  newTab.icon:setRenderTexture(newTab.icon:getBaseTexture())
  if oldSelectedType >= 0 then
    local oldTab = self._ui._tab[oldSelectedType]
    local oldTextureName = ToClient_selectBoxTextureName(self._selectBoxKey, oldSelectedType)
    oldTab.icon:ChangeTextureInfoTextureIDAsync(oldTextureName .. "_Normal", 0)
    oldTab.icon:setRenderTexture(oldTab.icon:getBaseTexture())
  end
  self._selectedType = newSelectedType
  self:updateList2Items()
end
function PaGlobal_SelectBox:updateList2Items()
  local itemCount = ToClient_selectBoxTotalItemCount(self._selectBoxKey, self._selectedType)
  self._ui._list2_items:getElementManager():clearKey()
  for ii = 0, itemCount - 1 do
    self._ui._list2_items:getElementManager():pushKey(ii)
  end
end
function PaGlobal_SelectBox:showSelectedItemTooltip(index)
  local slot = self._ui._selectedItemSlot[index]
  if nil == slot then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(slot.itemEnchantKeyRaw))
  if nil == itemSSW then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, slot.icon, true)
  self._isCurrentMouseOnItemSlot = true
end
function PaGlobal_SelectBox:showList2ItemTooltip(idx)
  local content = self._ui._list2_items:GetContentByKey(idx)
  if nil == content then
    return
  end
  local btn_template = UI.getChildControl(content, "RadioButton_ItemTemplete")
  local stc_iconBG = UI.getChildControl(btn_template, "Static_Icon_BG")
  local itemKey = ToClient_selectBoxItemEnchantKey(self._selectBoxKey, self._selectedType, idx)
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if nil == itemSSW then
    return
  end
  if true == self._isConsole then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, stc_iconBG, true)
  end
  self._isCurrentMouseOnItemSlot = true
end
function PaGlobal_SelectBox:hideItemTooltip()
  if true == self._isConsole then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self._isCurrentMouseOnItemSlot = false
end
function PaGlobal_SelectBox:detailItemInfo()
  if false == self._isConsole then
    return
  end
  self:showList2ItemTooltip(self._snappedIndex)
end
function PaGlobal_SelectBox:setSnappedList2Index(idx)
  if false == self._isConsole then
    return
  end
  if self._snappedIndex ~= idx then
    self:hideItemTooltip()
  end
  self._snappedIndex = idx
end
function PaGlobalFunc_SelectFantasyServant_UpdatePerFrame_For_Effect(updateTime)
  if Panel_Dialog_ServantSwiftResult_All == nil then
    return
  end
  PaGlobal_SelectBox._elapsedTime = PaGlobal_SelectBox._elapsedTime + updateTime
  if PaGlobal_SelectBox._elapsedTime > 8 then
    PaGlobalFunc_ServantSwiftResult_All_EffectErase()
    PaGlobalFunc_ServantSwiftResult_All_EffectClose()
    Panel_Dialog_ServantSwiftResult_All:ClearUpdateLuaFunc()
  end
end
function FromClient_SelectFantasyServant(servantKey)
  local self = PaGlobal_SelectBox
  self._elapsedTime = 0
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(false)
  if 31580 == servantKey or 31583 == servantKey then
    Panel_Dialog_ServantSwiftResult_All:AddEffect("fUI_Horse_Upgrade_06B_A", false, 0, 220)
  elseif 31579 == servantKey or 31582 == servantKey then
    Panel_Dialog_ServantSwiftResult_All:AddEffect("fUI_Horse_Upgrade_06C_A", false, 0, 220)
  elseif 31578 == servantKey or 31581 == servantKey then
    Panel_Dialog_ServantSwiftResult_All:AddEffect("fUI_Horse_Upgrade_06D_A", false, 0, 220)
  elseif 31621 == servantKey then
    Panel_Dialog_ServantSwiftResult_All:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01D_A", false, 0, 220)
  elseif 31620 == servantKey then
    Panel_Dialog_ServantSwiftResult_All:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01B_A", false, 0, 220)
  elseif 31619 == servantKey then
    Panel_Dialog_ServantSwiftResult_All:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01C_A", false, 0, 220)
  end
  PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow(true)
  Panel_Dialog_ServantSwiftResult_All:RegisterUpdateFunc("PaGlobalFunc_SelectFantasyServant_UpdatePerFrame_For_Effect")
end
