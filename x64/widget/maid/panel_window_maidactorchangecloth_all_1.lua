function PaGlobal_MaidActorChangeCloth:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_MaidActorChangeCloth_All, "Static_TitleBg")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.btn_close:SetShow(self._isConsole == false)
  self._ui.lst_item = UI.getChildControl(Panel_Window_MaidActorChangeCloth_All, "List2_Item")
  self._ui.stc_emptyList = UI.getChildControl(self._ui.lst_item, "StaticText_Empty")
  local content = UI.getChildControl(self._ui.lst_item, "List2_1_Content")
  local itemSlotBg = UI.getChildControl(content, "Static_ItemSlotBg")
  local itemSlot = {}
  SlotItem.new(itemSlot, "PearlCloth_ItemSlot_", 0, itemSlotBg, self._slotConfig)
  itemSlot:createChild()
  itemSlot:clearItem()
  itemSlot.icon:SetPosX(1)
  itemSlot.icon:SetPosY(1)
  itemSlot.icon:SetShow(false)
  itemSlot.border:SetSize(46, 46)
  self._ui.stc_descBg = UI.getChildControl(Panel_Window_MaidActorChangeCloth_All, "Static_DescBg")
  self._ui.stc_needItemSlotIcon = UI.getChildControl(self._ui.stc_descBg, "StaticText_Icon")
  self._ui.txt_needItemName = UI.getChildControl(self._ui.stc_descBg, "StaticText_ItemName")
  self._ui.txt_needItemCount = UI.getChildControl(self._ui.stc_descBg, "StaticText_Count")
  local needItemSlot = {}
  SlotItem.new(needItemSlot, "Need_ItemSlot_", 0, self._ui.stc_needItemSlotIcon, self._slotConfig)
  needItemSlot:createChild()
  needItemSlot:clearItem()
  needItemSlot.icon:SetPosX(0)
  needItemSlot.icon:SetPosY(0)
  needItemSlot.icon:SetShow(false)
  needItemSlot.border:SetSize(44, 44)
  self._ui.btn_change = UI.getChildControl(Panel_Window_MaidActorChangeCloth_All, "Button_Change")
  self._ui.btn_change:SetShow(self._isConsole == false)
  self._ui.stc_guideBg = UI.getChildControl(Panel_Window_MaidActorChangeCloth_All, "Static_GuideBg")
  self._ui.txt_guide_01 = UI.getChildControl(self._ui.stc_guideBg, "StaticText_Guide_01")
  self._ui.txt_guide_02 = UI.getChildControl(self._ui.stc_guideBg, "StaticText_Guide_02")
  self._ui.txt_guide_01:SetSize(self._ui.stc_guideBg:GetSizeX(), self._ui.txt_guide_01:GetTextSizeY())
  self._ui.txt_guide_01:SetSpanSize(0, 5)
  self._ui.txt_guide_02:SetSize(self._ui.stc_guideBg:GetSizeX(), self._ui.txt_guide_02:GetTextSizeY())
  self._ui.txt_guide_02:SetSpanSize(0, self._ui.txt_guide_01:GetSpanSize().y + self._ui.txt_guide_01:GetSizeY() + 5)
  self._ui.stc_guideBg:SetSize(self._ui.stc_guideBg:GetSizeX(), self._ui.txt_guide_02:GetSpanSize().y + self._ui.txt_guide_02:GetSizeY() + 15)
  self._ui.stc_guideBg:ComputePosAllChild()
  self._ui.btn_change:SetSpanSize(self._ui.btn_change:GetSpanSize().x, self._ui.stc_guideBg:GetSpanSize().y + self._ui.stc_guideBg:GetSizeY())
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_MaidActorChangeCloth_All, "Static_KeyGuideBg")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui.stc_keyGuideX = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui.stc_keyGuideBg:SetShow(self._isConsole == true)
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_MaidActorChangeCloth:registEventHandler()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_MaidActorChangeCloth_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MaidActorChangeCloth_ToggleFloatingTooltip()")
    Panel_Window_MaidActorChangeCloth_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_MaidActorChangeCloth_DoChange()")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MaidActorChangeCloth_Close()")
    self._ui.btn_change:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorChangeCloth_DoChange()")
  end
  self._ui.lst_item:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleListEvent_MaidActorChangeCloth_CreateItemListContent")
  self._ui.lst_item:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_MaidActorChangeCloth_Show", "FromClient_MaidActorChangeCloth_Show")
  registerEvent("FromClient_MaidActorChangeCloth_Hide", "FromClient_MaidActorChangeCloth_Hide")
end
function PaGlobal_MaidActorChangeCloth:prepareOpen(fromWhereType, fromSlotNo)
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  self:clearWhenShowOrHide()
  self._fromWhereType = fromWhereType
  self._fromSlotNo = fromSlotNo
  self:updateList()
  self:updateMaterialItem(true)
  self:resizePanel()
  self:updateKeyGuide()
  self:open()
end
function PaGlobal_MaidActorChangeCloth:open()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  Panel_Window_MaidActorChangeCloth_All:SetShow(true)
end
function PaGlobal_MaidActorChangeCloth:prepareClose()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  self:clearWhenShowOrHide()
  self:close()
end
function PaGlobal_MaidActorChangeCloth:close()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  Panel_Window_MaidActorChangeCloth_All:SetShow(false)
end
function PaGlobal_MaidActorChangeCloth:clearWhenShowOrHide()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  ToClient_ClearMaidActorChangeClothTargetItem()
  self._console_overSlot_whereType = nil
  self._console_overSlot_slotNo = nil
  self._fromWhereType = nil
  self._fromSlotNo = nil
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function PaGlobal_MaidActorChangeCloth:updateList()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  local listManager = self._ui.lst_item:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  self._ui.stc_emptyList:SetShow(true)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eCashInventory
  local inventory_cash = selfPlayer:get():getInventoryByType(itemWhereType)
  if inventory_cash == nil then
    return
  end
  local pushCount = 0
  local invenMaxSize = inventory_cash:sizeXXX()
  for slotNo = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
    if itemWrapper ~= nil and itemWrapper:isChangableAvatarItemForMaidActor() == true then
      listManager:pushKey(toInt64(itemWhereType, slotNo))
      pushCount = pushCount + 1
    end
  end
  if pushCount > 0 then
    self._ui.stc_emptyList:SetShow(false)
  end
end
function PaGlobal_MaidActorChangeCloth:createItemListContent(content, key)
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  local itemWhereType = highFromUint64(key)
  local slotNo = lowFromUint64(key)
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemNoRaw = itemWrapper:getItemNoRaw()
  local btn = UI.getChildControl(content, "CheckButton_ItemList")
  local stc_itemSlotBg = UI.getChildControl(content, "Static_ItemSlotBg")
  local txt_itemName = UI.getChildControl(content, "StaticText_ItemName")
  if self._isConsole == true then
    btn:addInputEvent("Mouse_On", "HandleEventLOnOut_MaidActorChangeCloth_TooltipItem(true, " .. tostring(itemWhereType) .. "," .. tostring(slotNo) .. ")")
    btn:addInputEvent("Mouse_Out", "HandleEventLOnOut_MaidActorChangeCloth_TooltipItem(false, " .. tostring(itemWhereType) .. "," .. tostring(slotNo) .. ")")
  end
  btn:addInputEvent("Mouse_LUp", "HandleEventLUp_MaidActorChangeCloth_SelectItem(" .. tostring(itemWhereType) .. "," .. tostring(slotNo) .. ")")
  btn:SetCheck(ToClient_IsMaidActorChangeClothTargetItem(itemNoRaw))
  local stc_itemSlot = UI.getChildControl(stc_itemSlotBg, "Static_PearlCloth_ItemSlot_")
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, "PearlCloth_ItemSlot_", 0, stc_itemSlotBg, self._slotConfig)
  itemSlot:clearItem()
  itemSlot:setItem(itemWrapper)
  stc_itemSlot:SetShow(true)
  itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_MaidActorChangeCloth_ItemTooltip(true," .. tostring(itemWhereType) .. "," .. tostring(slotNo) .. ")")
  itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_MaidActorChangeCloth_ItemTooltip(false," .. tostring(itemWhereType) .. "," .. tostring(slotNo) .. ")")
  local itemGrade = itemWrapper:getStaticStatus():getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  txt_itemName:SetTextMode(__eTextMode_Limit_AutoWrap)
  txt_itemName:setLineCountByLimitAutoWrap(1)
  txt_itemName:SetText(itemWrapper:getStaticStatus():getName())
  txt_itemName:SetFontColor(itemGradeColor)
  txt_itemName:SetIgnore(true)
end
function PaGlobal_MaidActorChangeCloth:updateMaterialItem(isWhenPanelShow)
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  local needItemWrapper = getInventoryItemByType(self._fromWhereType, self._fromSlotNo)
  if isWhenPanelShow == true and needItemWrapper ~= nil then
    local stc_needItemSlot = UI.getChildControl(self._ui.stc_needItemSlotIcon, "Static_Need_ItemSlot_")
    local needItemSlot = {}
    SlotItem.reInclude(needItemSlot, "Need_ItemSlot_", 0, self._ui.stc_needItemSlotIcon, self._slotConfig)
    needItemSlot:clearItem()
    needItemSlot:setItem(needItemWrapper)
    stc_needItemSlot:SetShow(true)
    local itemGrade = needItemWrapper:getStaticStatus():getGradeType()
    local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
    self._ui.txt_needItemName:SetTextMode(__eTextMode_Limit_AutoWrap)
    self._ui.txt_needItemName:setLineCountByLimitAutoWrap(1)
    self._ui.txt_needItemName:SetText(needItemWrapper:getStaticStatus():getName())
    self._ui.txt_needItemName:SetFontColor(itemGradeColor)
    needItemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_MaidActorChangeCloth_ItemTooltip(true," .. tostring(self._fromWhereType) .. "," .. tostring(self._fromSlotNo) .. ")")
    needItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_MaidActorChangeCloth_ItemTooltip(false," .. tostring(self._fromWhereType) .. "," .. tostring(self._fromSlotNo) .. ")")
  end
  local needCount = Int64toInt32(ToClient_GetNeedItemCountForChangeClothForMaidActor())
  local hasCount = Int64toInt32(needItemWrapper:getCount())
  self._ui.txt_needItemCount:SetText("(" .. needCount .. "/" .. hasCount .. ")")
end
function PaGlobal_MaidActorChangeCloth:selectItem(itemWhereType, slotNo)
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(itemWhereType, slotNo)
  if itemWrapper == nil then
    return
  end
  local itemNoRaw = itemWrapper:getItemNoRaw()
  if ToClient_IsMaidActorChangeClothTargetItem(itemNoRaw) == true then
    if ToClient_RemoveMaidActorChangeClothTargetItem(itemNoRaw) == false then
      return
    end
  elseif ToClient_AddMaidActorChangeClothTargetItem(self._fromWhereType, self._fromSlotNo, itemNoRaw) == false then
    local key = toInt64(itemWhereType, slotNo)
    local content = self._ui.lst_item:GetContentByKey(key)
    if content ~= nil then
      local btn = UI.getChildControl(content, "CheckButton_ItemList")
      btn:SetCheck(false)
    end
    return
  end
  self._ui.lst_item:requestUpdateVisible()
  self:updateMaterialItem(false)
end
function PaGlobal_MaidActorChangeCloth:resizePanel()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  local panelSizeY = 0
  if self._isConsole == true then
    panelSizeY = self._ui.stc_titleBg:GetSizeY() + 10 + self._ui.lst_item:GetSizeY() + 10 + self._ui.stc_descBg:GetSizeY() + 10 + self._ui.stc_guideBg:GetSizeY() + 10
  else
    panelSizeY = self._ui.stc_titleBg:GetSizeY() + 10 + self._ui.lst_item:GetSizeY() + 10 + self._ui.stc_descBg:GetSizeY() + 10 + self._ui.stc_guideBg:GetSizeY() + 10 + self._ui.btn_change:GetSizeY() + 10
  end
  Panel_Window_MaidActorChangeCloth_All:SetSize(Panel_Window_MaidActorChangeCloth_All:GetSizeX(), panelSizeY)
  Panel_Window_MaidActorChangeCloth_All:ComputePosAllChild()
end
function PaGlobal_MaidActorChangeCloth:updateKeyGuide()
  if Panel_Window_MaidActorChangeCloth_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local keyGuideList = Array.new()
  keyGuideList:push_back(self._ui.stc_keyGuideY)
  keyGuideList:push_back(self._ui.stc_keyGuideX)
  keyGuideList:push_back(self._ui.stc_keyGuideA)
  keyGuideList:push_back(self._ui.stc_keyGuideB)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
