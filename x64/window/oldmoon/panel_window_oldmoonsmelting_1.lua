function PaGlobal_OldMoonSmelting:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = true == ToClient_isConsole()
  self._isPadMode = true == self._isConsole or true == _ContentsGroup_UsePadSnapping
  self:initializeTitleArea()
  self:initializeLeftTopArea()
  self:initializeLeftBottomButtonArea()
  self:initializeLeftBottomDescArea()
  self:initializeRightListArea()
  self:initializeRightMaterialArea()
  if true == self._isPadMode then
    self:initializeConsoleKeyGuideArea()
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_OldMoonSmelting:initializeTitleArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._btn_closeButton = UI.getChildControl(self._ui._stc_titleArea, "Button_Close")
  if false == self._isPadMode then
    self._ui._btn_closeButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_Close()")
  end
  self._ui._btn_closeButton:SetShow(not self._isPadMode)
end
function PaGlobal_OldMoonSmelting:initializeLeftTopArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._stc_smeltAreaBg = UI.getChildControl(self._ui._stc_leftTopArea, "Static_SmeltAreaBg")
  self._ui._stc_smeltableItemSlot = UI.getChildControl(self._ui._stc_smeltAreaBg, "Static_SmeltableItemSlot")
  self._ui._stc_materialItemSlot = UI.getChildControl(self._ui._stc_smeltAreaBg, "Static_MaterialItemSlot")
  self._ui._stc_smeltingEffect = UI.getChildControl(self._ui._stc_smeltAreaBg, "Static_SmeltingEffectTarget")
  self._ui._prg_smeltingProgressBar = UI.getChildControl(self._ui._stc_smeltAreaBg, "Progress2_1")
  self._ui._prg_smeltingProgressBar:SetAniSpeed(0.1)
  self._ui._prg_smeltingProgressBar:SetSmoothMode(true)
  local textArea = UI.getChildControl(self._ui._stc_leftTopArea, "Static_CountArea")
  self._ui._txt_smeltingProgressText = UI.getChildControl(textArea, "MultilineText_1")
  local targetSlot = {}
  SlotItem.new(targetSlot, "Smelting_Item_Slot_", 0, self._ui._stc_smeltableItemSlot, self._slotConfig)
  targetSlot:createChild()
  targetSlot:clearItem()
  targetSlot.icon:SetPosX(0)
  targetSlot.icon:SetPosY(0)
  targetSlot.border:SetSize(44, 44)
  self._smeltingSlotInfo._targetItemSlot = targetSlot
  self._smeltingSlotInfo._targetItemSlot.icon:SetShow(false)
  local materialSlot = {}
  SlotItem.new(materialSlot, "Material_Item_Slot_", 0, self._ui._stc_materialItemSlot, self._slotConfig)
  materialSlot:createChild()
  materialSlot:clearItem()
  materialSlot.icon:SetPosX(0)
  materialSlot.icon:SetPosY(0)
  materialSlot.border:SetSize(44, 44)
  self._smeltingSlotInfo._materialItemSlot = materialSlot
  self._smeltingSlotInfo._materialItemSlot.icon:SetShow(false)
  if true == self._isPadMode then
    self._smeltingSlotInfo._targetItemSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowSelectedItemTooltip(true)")
    self._smeltingSlotInfo._targetItemSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowSelectedItemTooltip(false)")
    self._smeltingSlotInfo._targetItemSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_OldMoonSmelting_ClearTargetItemSlot()")
    self._smeltingSlotInfo._materialItemSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(true)")
    self._smeltingSlotInfo._materialItemSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(false)")
    self._smeltingSlotInfo._materialItemSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_OldMoonSmelting_ClearMaterialItemSlot()")
  else
    self._smeltingSlotInfo._targetItemSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowSelectedItemTooltip(true)")
    self._smeltingSlotInfo._targetItemSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowSelectedItemTooltip(false)")
    self._smeltingSlotInfo._targetItemSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_OldMoonSmelting_ClearTargetItemSlot()")
    self._smeltingSlotInfo._materialItemSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(true)")
    self._smeltingSlotInfo._materialItemSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(false)")
    self._smeltingSlotInfo._materialItemSlot.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_OldMoonSmelting_ClearMaterialItemSlot()")
  end
end
function PaGlobal_OldMoonSmelting:initializeLeftBottomButtonArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._ckb_skipAnimationButton = UI.getChildControl(self._ui._stc_leftBottomButtonArea, "CheckBox_SkipAni")
  self._ui._btn_smeltingButton = UI.getChildControl(self._ui._stc_leftBottomButtonArea, "Button_Smelting")
  self._ui._btn_keyGuide_Y = UI.getChildControl(self._ui._stc_leftBottomButtonArea, "Button_KeyguideY")
  self._ui._btn_smeltingButton:SetShow(not self._isPadMode)
  self._ui._btn_keyGuide_Y:SetShow(self._isPadMode)
  if true == self._isPadMode then
    self._ui._btn_smeltingButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnClickedDoSmeltingButton()")
  else
    self._ui._btn_smeltingButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnClickedDoSmeltingButton()")
  end
end
function PaGlobal_OldMoonSmelting:initializeLeftBottomDescArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._txt_smeltingDesc = UI.getChildControl(self._ui._stc_leftBottomDescArea, "StaticText_Desc")
  self._ui._txt_smeltingDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui._txt_smeltingDesc:setLineCountByLimitAutoWrap(4)
end
function PaGlobal_OldMoonSmelting:initializeRightListArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._lst_smeltableItemList = UI.getChildControl(self._ui._stc_rightArea, "List2_SmeltableItemList")
  self._ui._stc_notExistItem = UI.getChildControl(self._ui._lst_smeltableItemList, "StaticText_Desc")
  local listContent = UI.getChildControl(self._ui._lst_smeltableItemList, "List2_1_Content")
  local rdoButton = UI.getChildControl(listContent, "RadioButton_SmetableItem")
  local itemSlotBg = UI.getChildControl(rdoButton, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local tempSlot = {}
  SlotItem.new(tempSlot, "Smelting_Item_Slot_", 0, itemIcon, self._slotConfig)
  tempSlot:createChild()
  tempSlot:clearItem()
  tempSlot.icon:SetPosX(0)
  tempSlot.icon:SetPosY(0)
  tempSlot.border:SetSize(44, 44)
end
function PaGlobal_OldMoonSmelting:initializeRightMaterialArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._btn_useMaterialItemButton = UI.getChildControl(self._ui._stc_rightBottomArea, "Button_UseMaterialItem")
  self._ui._txt_materialItemCount = UI.getChildControl(self._ui._btn_useMaterialItemButton, "StaticText_ItemCount")
  local itemSlotBg = UI.getChildControl(self._ui._btn_useMaterialItemButton, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemName = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local materialSlot = {}
  SlotItem.new(materialSlot, "Have_Material_Item_Slot_", 0, itemIcon, self._materialSlotConfig)
  materialSlot:createChild()
  materialSlot:clearItem()
  materialSlot.icon:SetPosX(0)
  materialSlot.icon:SetPosY(0)
  materialSlot.border:SetSize(44, 44)
  self._ui._stc_materialItemIcon = materialSlot
  local materialItemSSW = ToClient_getOldMoonSmeltingMaterialItemSSW()
  if nil == materialItemSSW then
    UI.ASSERT_NAME(false, "\234\183\184\235\175\144\235\139\172 \236\160\156\235\160\168\236\151\144 \237\149\132\236\154\148\237\149\156 \236\158\172\235\163\140 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  itemName:SetTextMode(__eTextMode_AutoWrap)
  itemName:SetText(materialItemSSW:getName())
  PAGlobalFunc_SetItemTextColor(itemName, materialItemSSW)
  if true == self._isPadMode then
    self._ui._btn_useMaterialItemButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnClickedMaterialItemButton()")
    self._ui._stc_materialItemIcon.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(true)")
    self._ui._stc_materialItemIcon.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(false)")
  else
    self._ui._btn_useMaterialItemButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnClickedMaterialItemButton()")
    self._ui._stc_materialItemIcon.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(true)")
    self._ui._stc_materialItemIcon.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowMaterialItemTooltip(false)")
  end
end
function PaGlobal_OldMoonSmelting:initializeConsoleKeyGuideArea()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._stc_consoleKeyguidArea:SetShow(self._isPadMode)
  if true == self._isPadMode then
    self._ui._btn_keyGuide_A = UI.getChildControl(self._ui._stc_consoleKeyguidArea, "Keyguide_A")
    self._ui._btn_keyGuide_B = UI.getChildControl(self._ui._stc_consoleKeyguidArea, "Keyguide_B")
    local keyGuides = {
      self._ui._btn_keyGuide_A,
      self._ui._btn_keyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_consoleKeyguidArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    return
  end
end
function PaGlobal_OldMoonSmelting:registEventHandler()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  if true == self._isPadMode then
    Panel_Window_OldMoonSmelting:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_OldMoonSmelting_OnClickedDoSmeltingButton()")
  end
  registerEvent("EventEquipmentUpdate", "FromClient_OldMoonSmelting_UpdateItemList")
  registerEvent("FromClient_SuccessOldMoonSmeltingResult", "FromClient_OldMoonSmelting_Result")
  self._ui._lst_smeltableItemList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_OldMoonSmelting_OnCreateListContent")
  self._ui._lst_smeltableItemList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_OldMoonSmelting:prepareOpen()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._animation_accTime = 0
  self._currentSelectedSlotNoIndex = -1
  self._ui._ckb_skipAnimationButton:SetCheck(false)
  ToClient_padSnapChangeToTarget(self._ui._stc_materialItemIcon.icon)
  self:initPanelPos()
  self:updateSmeltableItemList()
  self:refreshMaterialItemIcon()
  self:clearSmeltingTargetItem()
  self:clearMaterialItem()
  self:changeSmeltingButtonText_Do()
  self:UnLockUIControl()
  self:cancelSmelting()
  self:open()
end
function PaGlobal_OldMoonSmelting:initPanelPos()
  local panel = Panel_Window_OldMoonSmelting
  if nil == panel then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  panel:SetPosX((screenX - panelSizeX) / 2)
  panel:SetPosY((screenY - panelSizeY) / 2)
end
function PaGlobal_OldMoonSmelting:createSmeltableItemContent(content, key)
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  if nil == self._listInfo._slotNoList then
    return
  end
  local radioButton = UI.getChildControl(content, "RadioButton_SmetableItem")
  local itemSlotBg = UI.getChildControl(radioButton, "Static_ItemSlotBG")
  local itemIcon = UI.getChildControl(itemSlotBg, "Static_ItemIcon")
  local itemName = UI.getChildControl(itemSlotBg, "StaticText_ItemName")
  local equipedItemString = UI.getChildControl(radioButton, "StaticText_EquipItem")
  local currentValueString = UI.getChildControl(radioButton, "StaticText_CurrentValue")
  local slotNoIndex = Int64toInt32(key)
  local realSlotNo = self._listInfo._slotNoList[slotNoIndex]
  if nil == realSlotNo then
    return
  end
  if self._currentSelectedSlotNoIndex == slotNoIndex then
    radioButton:SetCheck(true)
  else
    radioButton:SetCheck(false)
  end
  local slot = {}
  SlotItem.reInclude(slot, "Smelting_Item_Slot_", 0, itemIcon, self._slotConfig)
  slot:clearItem()
  local itemWrapper, itemSSW
  if slotNoIndex < self._listInfo._equipedSlotNoEnd then
    itemWrapper = ToClient_getEquipmentItem(realSlotNo)
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper)
    end
    itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    equipedItemString:SetShow(true)
    currentValueString:SetShow(false)
    if true == self._isPadMode then
      radioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",true)")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",true)")
      slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(true," .. realSlotNo .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false,nil,nil)")
    else
      radioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",true)")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",true)")
      slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(true," .. realSlotNo .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false,nil,nil)")
    end
  else
    itemWrapper = getInventoryItem(realSlotNo)
    if nil ~= itemWrapper then
      slot:setItem(itemWrapper)
    end
    itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    equipedItemString:SetShow(false)
    currentValueString:SetShow(true)
    local currentValue = itemWrapper:get():getCurrentOldMoonSmeltedValue()
    local maxValue = itemWrapper:get():getMaxOldMoonSmeltedValue()
    local percentString = string.format("%.0f", math.floor(currentValue / maxValue * 100))
    currentValueString:SetTextMode(__eTextMode_AutoWrap)
    currentValueString:SetText(percentString .. "%")
    if true == self._isPadMode then
      radioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",false)")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",false)")
      slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(true," .. realSlotNo .. ",false)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false,nil,nil)")
    else
      radioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",false)")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_OldMoonSmelting_OnSelectedListContent(" .. slotNoIndex .. ",false)")
      slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(true," .. realSlotNo .. ",false)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false,nil,nil)")
    end
  end
  local enchantLevel = itemSSW:get()._key:getEnchantLevel()
  local enchantText = ""
  if enchantLevel >= 16 then
    enchantText = HighEnchantLevel_ReplaceString(enchantLevel) .. " "
  end
  itemName:SetTextMode(__eTextMode_AutoWrap)
  itemName:SetText(enchantText .. itemSSW:getName())
  PAGlobalFunc_SetItemTextColor(itemName, itemSSW)
end
function PaGlobal_OldMoonSmelting:releaseEquipItem(slotNoIndex)
  if nil == Panel_Window_OldMoonSmelting or nil == slotNoIndex then
    return
  end
  PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false, nil, nil)
  equipmentDoUnequip(self._listInfo._slotNoList[slotNoIndex])
end
function PaGlobal_OldMoonSmelting:selectItem(slotNoIndex)
  if nil == Panel_Window_OldMoonSmelting or nil == slotNoIndex then
    return
  end
  Panel_NumberPad_Close()
  self._currentSelectedSlotNoIndex = slotNoIndex
  self:fillSmeltingTargetItem(slotNoIndex)
end
function PaGlobal_OldMoonSmelting:updateSelectedItemProgressInfo(slotNoIndex)
  if nil == Panel_Window_OldMoonSmelting or nil == slotNoIndex then
    return
  end
  if slotNoIndex < self._listInfo._equipedSlotNoEnd then
    return
  end
  local realSlotNo = self._listInfo._slotNoList[slotNoIndex]
  local itemWrapper = getInventoryItem(realSlotNo)
  if nil == itemWrapper then
    return
  end
  local item = itemWrapper:get()
  if nil == item then
    return
  end
  local currentValue = item:getCurrentOldMoonSmeltedValue()
  local maxValue = item:getMaxOldMoonSmeltedValue()
  local percent = currentValue / maxValue * 100
  local isShowBuffDesc = false
  local buffDescString
  if true == itemWrapper:isOldMoonFullSatck() then
    local buffCount = itemWrapper:getOldMoonBuffCount()
    if buffCount > 0 then
      buffDescString = itemWrapper:getOldMoonBuffDesc(0)
      isShowBuffDesc = true
    end
  end
  self._ui._prg_smeltingProgressBar:SetProgressRate(percent)
  if true == isShowBuffDesc and nil ~= buffDescString then
    self._ui._txt_smeltingProgressText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OLDMOON_COMPLETE", "option", buffDescString))
  else
    self._ui._txt_smeltingProgressText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_OldMoon_Count", "currentCount", currentValue, "maxCount", maxValue))
  end
  local isFull = false
  if currentValue == maxValue then
    isFull = true
  end
  if false == self._isPadMode then
    self._ui._btn_smeltingButton:SetIgnore(isFull)
    self._ui._btn_smeltingButton:SetMonoTone(isFull)
  end
end
function PaGlobal_OldMoonSmelting:clearProgressInfo()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._prg_smeltingProgressBar:SetProgressRate(0)
  self._ui._txt_smeltingProgressText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_OLDMOON_CHOICE_ITEM_ASK"))
  if false == self._isPadMode then
    self._ui._btn_smeltingButton:SetIgnore(true)
    self._ui._btn_smeltingButton:SetMonoTone(true)
  end
end
function PaGlobal_OldMoonSmelting:updateSmeltableItemList()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local listManager = self._ui._lst_smeltableItemList:getElementManager()
  if nil == listManager then
    return
  else
    listManager:clearKey()
  end
  local slotNoIndex = 0
  self._listInfo._equipedSlotNoEnd = -1
  self._listInfo._slotNoList = {}
  for equipSlotNo = __eEquipSlotNoRightHand, __eEquipSlotNoCount do
    local itemWrapper = ToClient_getEquipmentItem(equipSlotNo)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      if nil ~= item and true == item:isOldMoonSmeltableItem() and false == ToClient_isLockItem(itemWrapper:getItemNoRaw()) and false == itemWrapper:isOldMoonFullSatck() then
        self._listInfo._slotNoList[slotNoIndex] = equipSlotNo
        listManager:pushKey(toInt64(0, slotNoIndex))
        slotNoIndex = slotNoIndex + 1
      end
    end
  end
  self._listInfo._equipedSlotNoEnd = slotNoIndex
  local inventorySize = selfPlayer:getInventorySlotCount(false)
  local useStartSlot = inventorySlotNoUserStart()
  for invenSlotNo = useStartSlot, inventorySize - 1 do
    local itemWrapper = getInventoryItem(invenSlotNo)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      if nil ~= item and true == item:isOldMoonSmeltableItem() and false == ToClient_isLockItem(itemWrapper:getItemNoRaw()) and false == itemWrapper:isOldMoonFullSatck() then
        self._listInfo._slotNoList[slotNoIndex] = invenSlotNo
        listManager:pushKey(toInt64(0, slotNoIndex))
        slotNoIndex = slotNoIndex + 1
      end
    end
  end
end
function PaGlobal_OldMoonSmelting:refreshMaterialItemIcon()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  local materialItemSSW = ToClient_getOldMoonSmeltingMaterialItemSSW()
  if nil == materialItemSSW then
    UI.ASSERT_NAME(false, "\234\183\184\235\175\144\235\139\172 \236\160\156\235\160\168\236\151\144 \237\149\132\236\154\148\237\149\156 \236\158\172\235\163\140 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local inventory = selfPlayer:getInventory()
  local s64_haveMaterialItemCount = inventory:getItemCount_s64(materialItemSSW:get()._key)
  self._ui._stc_materialItemIcon.icon:SetShow(true)
  self._ui._stc_materialItemIcon:setItemByStaticStatus(materialItemSSW, toInt64(0, 0))
  self._ui._txt_materialItemCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_materialItemCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_NEEDMATERIALCOUNT", "count", Int64toInt32(s64_haveMaterialItemCount)))
end
function PaGlobal_OldMoonSmelting:refreshSmeltingProgressInfo()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._txt_smeltingProgressText:EraseAllEffect()
  self._ui._txt_smeltingProgressText:AddEffect("fUI_OldMoonSmelting_02A", false, 0, 0)
  self:updateSelectedItemProgressInfo(self._currentSelectedSlotNoIndex)
end
function PaGlobal_OldMoonSmelting:refreshListSelectedContent()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  if -1 == self._currentSelectedSlotNoIndex then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\132\160\237\131\157\235\144\156 \235\166\172\236\138\164\237\138\184 \236\187\168\237\133\144\236\184\160 \236\157\184\235\141\177\236\138\164\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local content = self._ui._lst_smeltableItemList:GetContentByKey(toInt64(0, self._currentSelectedSlotNoIndex))
  if nil == content then
    return
  end
  local radioButton = UI.getChildControl(content, "RadioButton_SmetableItem")
  local currentValueString = UI.getChildControl(radioButton, "StaticText_CurrentValue")
  local slotNoIndex = Int64toInt32(self._currentSelectedSlotNoIndex)
  local realSlotNo = self._listInfo._slotNoList[slotNoIndex]
  if nil == realSlotNo then
    return
  end
  if slotNoIndex < self._listInfo._equipedSlotNoEnd then
    UI.ASSERT_NAME(false, "\236\158\165\236\176\169 \236\164\145\236\157\184 \236\149\132\236\157\180\237\133\156\236\157\152 \236\160\156\235\160\168 \236\167\132\237\150\137\235\143\132\235\138\148 \236\151\134\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  else
    local itemWrapper = getInventoryItem(realSlotNo)
    if nil == itemWrapper then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if nil == itemSSW then
      return
    end
    local currentValue = itemWrapper:get():getCurrentOldMoonSmeltedValue()
    local maxValue = itemWrapper:get():getMaxOldMoonSmeltedValue()
    local percentString = string.format("%.0f", math.floor(currentValue / maxValue * 100))
    currentValueString:SetTextMode(__eTextMode_AutoWrap)
    currentValueString:SetText(percentString .. "%")
  end
end
function PaGlobal_OldMoonSmelting:fillSmeltingTargetItem(slotNoIndex)
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self:clearSmeltingTargetItem()
  if slotNoIndex < self._listInfo._equipedSlotNoEnd then
    UI.ASSERT_NAME(false, "\236\158\165\236\176\169 \236\164\145\236\157\184 \236\149\132\236\157\180\237\133\156\236\157\132 \236\160\156\235\160\168\237\149\160 \236\136\156 \236\151\134\235\139\164. \236\158\165\236\176\169\237\149\180\236\160\156\235\165\188 \235\168\188\236\160\128\237\149\180\236\149\188\237\149\156\235\139\164! [1]", "\236\157\180\236\163\188")
    return
  else
    local realSlotNo = self._listInfo._slotNoList[slotNoIndex]
    local itemWrapper = getInventoryItem(realSlotNo)
    if nil ~= itemWrapper then
      self._smeltingSlotInfo._targetItemSlot.icon:SetShow(true)
      self._smeltingSlotInfo._targetItemSlot:setItem(itemWrapper)
      self._smeltingSlotInfo._targetItemSlotNoIndex = slotNoIndex
    end
  end
  self:updateSelectedItemProgressInfo(slotNoIndex)
end
function PaGlobal_OldMoonSmelting:clearSmeltingTargetItem()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._smeltingSlotInfo._targetItemSlot.icon:SetShow(false)
  self._smeltingSlotInfo._targetItemSlot:clearItem()
  self._smeltingSlotInfo._targetItemSlotNoIndex = -1
  self:clearProgressInfo()
end
function PaGlobal_OldMoonSmelting:inputMaterialItem()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if -1 == self._smeltingSlotInfo._targetItemSlotNoIndex then
    return
  end
  if self._smeltingSlotInfo._targetItemSlotNoIndex < self._listInfo._equipedSlotNoEnd then
    UI.ASSERT_NAME(false, "\236\158\165\236\176\169 \236\164\145\236\157\184 \236\149\132\236\157\180\237\133\156\236\157\132 \236\160\156\235\160\168\237\149\160 \236\136\156 \236\151\134\235\139\164. \236\158\165\236\176\169\237\149\180\236\160\156\235\165\188 \235\168\188\236\160\128\237\149\180\236\149\188\237\149\156\235\139\164! [2]", "\236\157\180\236\163\188")
    return
  end
  local materialItemSSW = ToClient_getOldMoonSmeltingMaterialItemSSW()
  if nil == materialItemSSW then
    return
  end
  local realSlotNo = self._listInfo._slotNoList[self._smeltingSlotInfo._targetItemSlotNoIndex]
  local smeltingTargetItemWrapper = getInventoryItem(realSlotNo)
  if nil == smeltingTargetItemWrapper then
    return
  end
  local currentValue = smeltingTargetItemWrapper:get():getCurrentOldMoonSmeltedValue()
  local maxValue = smeltingTargetItemWrapper:get():getMaxOldMoonSmeltedValue()
  local s64_needCount = toInt64(0, maxValue - currentValue)
  if toInt64(0, 0) == s64_needCount then
    return
  end
  local inventory = selfPlayer:getInventory()
  local s64_haveMaterialItemCount = inventory:getItemCount_s64(materialItemSSW:get()._key)
  local inputMaxCount = toInt64(0, 0)
  if s64_needCount <= s64_haveMaterialItemCount then
    inputMaxCount = s64_needCount
  else
    inputMaxCount = s64_haveMaterialItemCount
  end
  Panel_NumberPad_Show(true, inputMaxCount, nil, PaGlobalFunc_OldMoonSmelting_OnInputedMaterialCount)
end
function PaGlobal_OldMoonSmelting:fillMaterialItem(inputNumber)
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return
  end
  if -1 == self._smeltingSlotInfo._targetItemSlotNoIndex then
    return
  end
  if self._smeltingSlotInfo._targetItemSlotNoIndex < self._listInfo._equipedSlotNoEnd then
    return
  end
  local materialItemSSW = ToClient_getOldMoonSmeltingMaterialItemSSW()
  if nil == materialItemSSW then
    return
  end
  self:clearMaterialItem()
  self._smeltingSlotInfo._s64_materialItemCount = inputNumber
  self._smeltingSlotInfo._materialItemSlot.icon:SetShow(true)
  self._smeltingSlotInfo._materialItemSlot:setItemByStaticStatus(materialItemSSW, self._smeltingSlotInfo._s64_materialItemCount)
end
function PaGlobal_OldMoonSmelting:clearMaterialItem()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._smeltingSlotInfo._materialItemSlot.icon:SetShow(false)
  self._smeltingSlotInfo._materialItemSlot:clearItem()
  self._smeltingSlotInfo._s64_materialItemCount = toInt64(0, 0)
end
function PaGlobal_OldMoonSmelting:cancelSmelting()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self:changeSmeltingButtonText_Do()
  self:UnLockUIControl()
  self._animation_accTime = 0
  self._isPlayingSmeltingAnimation = false
  Panel_Window_Extraction_EnchantStone_All:ClearUpdateLuaFunc()
end
function PaGlobal_OldMoonSmelting:doSmelting()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  if -1 == self._currentSelectedSlotNoIndex then
    return
  end
  if -1 == self._smeltingSlotInfo._targetItemSlotNoIndex then
    return
  end
  if self._smeltingSlotInfo._targetItemSlotNoIndex < self._listInfo._equipedSlotNoEnd then
    return
  end
  if self._smeltingSlotInfo._s64_materialItemCount < toInt64(0, 1) then
    return
  end
  if true == self._ui._ckb_skipAnimationButton:IsCheck() then
    self:doSmeltingXXX()
  else
    self:doSmeltingAnimation()
  end
end
function PaGlobal_OldMoonSmelting:doSmeltingXXX()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  if -1 == self._currentSelectedSlotNoIndex then
    return
  end
  if -1 == self._smeltingSlotInfo._targetItemSlotNoIndex then
    return
  end
  if self._smeltingSlotInfo._targetItemSlotNoIndex < self._listInfo._equipedSlotNoEnd then
    return
  end
  if self._smeltingSlotInfo._s64_materialItemCount < toInt64(0, 1) then
    return
  end
  local itemWhereType = CppEnums.ItemWhereType.eInventory
  local realSlotNo = self._listInfo._slotNoList[self._currentSelectedSlotNoIndex]
  local tryValue = Int64toInt32(self._smeltingSlotInfo._s64_materialItemCount)
  ToClient_requestItemOldMoonSmelting(itemWhereType, realSlotNo, tryValue)
end
function PaGlobal_OldMoonSmelting:doSmeltingAnimation()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self:changeSmeltingButtonText_Cancel()
  self:LockUIControl()
  self._ui._stc_smeltingEffect:EraseAllEffect()
  self._ui._stc_smeltingEffect:AddEffect("fUI_OldMoonSmelting_01A", false, 0, -7)
  self._animation_accTime = 0
  self._isPlayingSmeltingAnimation = true
  Panel_Window_OldMoonSmelting:RegisterUpdateFunc("PaGlobalFunc_OldMoonSmelting_Update")
end
function PaGlobal_OldMoonSmelting:update(deltaTime)
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._animation_accTime = self._animation_accTime + deltaTime
  if self._animation_maxTime < self._animation_accTime and true == self._isPlayingSmeltingAnimation then
    self:cancelSmelting()
    self:doSmeltingXXX()
  end
end
function PaGlobal_OldMoonSmelting:changeSmeltingButtonText_Do()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._btn_smeltingButton:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_OLDMOON_EXECUTE_BTN"))
end
function PaGlobal_OldMoonSmelting:changeSmeltingButtonText_Cancel()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._btn_smeltingButton:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DIALOG_MAIN_ALL_BTN_CANCLE"))
end
function PaGlobal_OldMoonSmelting:LockUIControl()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._ckb_skipAnimationButton:SetIgnore(true)
  self._ui._lst_smeltableItemList:SetEnable(false)
  self._ui._btn_useMaterialItemButton:SetIgnore(true)
  self._smeltingSlotInfo._targetItemSlot.icon:SetIgnore(true)
  self._smeltingSlotInfo._targetItemSlot.icon:SetMonoTone(true)
  self._smeltingSlotInfo._materialItemSlot.icon:SetIgnore(true)
  self._smeltingSlotInfo._materialItemSlot.icon:SetMonoTone(true)
end
function PaGlobal_OldMoonSmelting:UnLockUIControl()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._ckb_skipAnimationButton:SetIgnore(false)
  self._ui._lst_smeltableItemList:SetEnable(true)
  self._ui._btn_useMaterialItemButton:SetIgnore(false)
  self._smeltingSlotInfo._targetItemSlot.icon:SetIgnore(false)
  self._smeltingSlotInfo._targetItemSlot.icon:SetMonoTone(false)
  self._smeltingSlotInfo._materialItemSlot.icon:SetIgnore(false)
  self._smeltingSlotInfo._materialItemSlot.icon:SetMonoTone(false)
end
function PaGlobal_OldMoonSmelting:open()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  Panel_Window_OldMoonSmelting:SetShow(true)
end
function PaGlobal_OldMoonSmelting:prepareClose()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  PaGlobalFunc_OldMoonSmelting_ShowItemTooltip(false, nil, nil)
  Panel_NumberPad_Close()
  self._ui._stc_smeltingEffect:EraseAllEffect()
  self._ui._txt_smeltingProgressText:EraseAllEffect()
  self:close()
end
function PaGlobal_OldMoonSmelting:close()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  Panel_Window_OldMoonSmelting:SetShow(false)
end
function PaGlobal_OldMoonSmelting:validate()
  if nil == Panel_Window_OldMoonSmelting then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._btn_closeButton:isValidate()
  self._ui._stc_leftTopArea:isValidate()
  self._ui._stc_smeltAreaBg:isValidate()
  self._ui._stc_smeltableItemSlot:isValidate()
  self._ui._stc_materialItemSlot:isValidate()
  self._ui._stc_smeltingEffect:isValidate()
  self._ui._prg_smeltingProgressBar:isValidate()
  self._ui._txt_smeltingProgressText:isValidate()
  self._ui._stc_leftBottomButtonArea:isValidate()
  self._ui._ckb_skipAnimationButton:isValidate()
  self._ui._btn_smeltingButton:isValidate()
  self._ui._btn_keyGuide_Y:isValidate()
  self._ui._stc_leftBottomDescArea:isValidate()
  self._ui._txt_smeltingDesc:isValidate()
  self._ui._stc_rightArea:isValidate()
  self._ui._lst_smeltableItemList:isValidate()
  self._ui._stc_notExistItem:isValidate()
  self._ui._stc_rightBottomArea:isValidate()
  self._ui._btn_useMaterialItemButton:isValidate()
  self._ui._stc_materialItemIcon.icon:isValidate()
  if true == self._isPadMode then
    self._ui._stc_consoleKeyguidArea:isValidate()
    self._ui._btn_keyGuide_A:isValidate()
    self._ui._btn_keyGuide_B:isValidate()
  end
end
