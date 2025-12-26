function PaGlobal_JewelInven:initialize()
  if self._isInitialize == true then
    return
  end
  if _ContentsGroup_JewelPreset == false then
    return
  end
  self._ui.stc_TitleBarArea = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_TitlebarArea")
  self._ui.btn_Close = UI.getChildControl(self._ui.stc_TitleBarArea, "Button_Close")
  self._ui.btn_Question = UI.getChildControl(self._ui.stc_TitleBarArea, "Button_Question")
  self._ui.stc_TopArea = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_TopArea")
  self._ui.stc_JewelCount = UI.getChildControl(self._ui.stc_TopArea, "StaticText_HaveCount")
  self._ui.rdo_SortByName = UI.getChildControl(self._ui.stc_TopArea, "RadioButton_Name")
  self._ui.rdo_SortByGroup = UI.getChildControl(self._ui.stc_TopArea, "RadioButton_Group")
  self._ui.rdo_SortByGrade = UI.getChildControl(self._ui.stc_TopArea, "RadioButton_Grade")
  self._ui.chk_TrashButton = UI.getChildControl(self._ui.stc_TopArea, "CheckButton_Trash")
  self._ui.rdo_ViewByList = UI.getChildControl(self._ui.stc_TopArea, "RadioButton_List")
  self._ui.rdo_ViewBySlot = UI.getChildControl(self._ui.stc_TopArea, "RadioButton_Slot")
  self._ui.stc_ListBG = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_ListBG")
  self._ui.list2_Jewel = UI.getChildControl(self._ui.stc_ListBG, "List2_Crystal")
  self._ui.list2_JewelContent = UI.getChildControl(self._ui.list2_Jewel, "List2_1_Content")
  self._ui.scroll_Vertical = UI.getChildControl(self._ui.list2_Jewel, "List2_1_VerticalScroll")
  self._ui.stc_SlotBG = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_SlotBg")
  self._ui.stc_Frame = UI.getChildControl(self._ui.stc_SlotBG, "Frame_JewelInvenSlotBg")
  self._ui.stc_FrameContent = UI.getChildControl(self._ui.stc_Frame, "Frame_1_Content")
  self._ui.stc_VerticalScroll = UI.getChildControl(self._ui.stc_Frame, "Frame_1_VerticalScroll")
  self._ui.stc_BottomArea = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_BottomArea")
  self._ui.rdo_ExtractByTool = UI.getChildControl(self._ui.stc_BottomArea, "RadioButton_Tool")
  self._ui.rdo_ExtractByBlackSpirit = UI.getChildControl(self._ui.stc_BottomArea, "RadioButton_BlackSpirit")
  self._ui.stc_DescArea = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_DescArea")
  self._ui.stc_Desc = UI.getChildControl(self._ui.stc_DescArea, "StaticText_Desc")
  self._ui.stc_TrashArea = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_TrashArea")
  self._ui.stc_TrashDesc = UI.getChildControl(self._ui.stc_TrashArea, "StaticText_1")
  self._ui.btn_Delete = UI.getChildControl(self._ui.stc_TrashArea, "Button_Delete")
  self._ui.btn_Cancel = UI.getChildControl(self._ui.stc_TrashArea, "Button_Cancel")
  self._ui.stc_Console_Buttons = UI.getChildControl(Panel_Window_JewelPreset_Inven_All, "Static_BottomConsoleButtons")
  self._ui.btn_Console_Delete = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_Y_ConsoleUI")
  self._ui.btn_Console_Select = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_A_ConsoleUI")
  self._ui.btn_Console_Cancel = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_B_ConsoleUI")
  self._ui.btn_Console_Detail = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_X_ConsoleUI")
  self._ui.btn_Console_PresetList = UI.getChildControl(self._ui.stc_Console_Buttons, "Button_LT_ConsoleUI")
  self._ui.btn_Console_PresetList:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_ADJUSTTOOLTIP_NAME"))
  local slotBG = UI.getChildControl(self._ui.list2_JewelContent, "Static_SlotBg")
  local tempSlot = {}
  SlotItem.new(tempSlot, "JewelList_Slot_", 0, slotBG, self._slotConfig)
  tempSlot:createChild()
  tempSlot:clearItem()
  local posXStart = 26
  local posYStart = 26
  local interval = 12
  local emptyCotrol = UI.getChildControl(self._ui.stc_FrameContent, "Static_SlotBg_Template")
  local lockControl = UI.getChildControl(self._ui.stc_FrameContent, "Static_LockedSlot_Template")
  local addControl = UI.getChildControl(self._ui.stc_FrameContent, "Static_AddSlot")
  local deleteControl = UI.getChildControl(self._ui.stc_FrameContent, "Static_Check")
  emptyCotrol:SetShow(false)
  lockControl:SetShow(false)
  addControl:SetShow(false)
  deleteControl:SetShow(false)
  local frameSizeY = 0
  for idx = 0, ToClient_GetJewelInvenMaxCount() - 1 do
    local slot = {}
    slot.empty = UI.cloneControl(emptyCotrol, self._ui.stc_FrameContent, "Static_JewelInven_Empty_" .. tostring(idx))
    slot.lock = UI.cloneControl(lockControl, self._ui.stc_FrameContent, "Static_JewelInven_Lock_" .. tostring(idx))
    slot.add = UI.cloneControl(addControl, self._ui.stc_FrameContent, "Static_JewelInven_Add_" .. tostring(idx))
    slot.check = UI.cloneControl(deleteControl, self._ui.stc_FrameContent, "Static_JewelInven_Check_" .. tostring(idx))
    local posX = posXStart + (slot.empty:GetSizeX() + interval) * (idx % 10)
    local posY = posYStart + (slot.empty:GetSizeY() + interval) * math.floor(idx / 10)
    slot.empty:SetPosXY(posX, posY)
    slot.lock:SetPosXY(posX, posY)
    slot.add:SetPosXY(posX, posY)
    slot.check:SetPosXY(posX, posY)
    slot.jewelItem = {}
    SlotItem.new(slot.jewelItem, "JewelSlot_", 0, slot.empty, self._slotConfig)
    slot.jewelItem:createChild()
    slot.jewelItem:clearItem()
    slot.empty:SetChildIndex(slot.jewelItem.icon, 9)
    local isUse = UI.getChildControl(slot.empty, "Static_IsUse")
    slot.empty:SetChildIndex(isUse, 9999)
    self._jewelSlotList[idx] = slot
    frameSizeY = posY
  end
  self._ui.stc_FrameContent:SetSize(self._ui.stc_FrameContent:GetSizeX(), frameSizeY + emptyCotrol:GetSizeY() + interval)
  local scrollInterval = ToClient_GetJewelInvenMaxCount() / 10 - 10
  self._ui.stc_VerticalScroll:SetInterval(scrollInterval)
  self._ui.stc_Frame:UpdateContentScroll()
  self._ui.stc_Frame:UpdateContentPos()
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._isConsole = ToClient_isConsole()
  self:registerEventHandler()
  self:validate()
  self:initializeControl()
  self._isInitialize = true
end
function PaGlobal_JewelInven:registerEventHandler()
  registerEvent("FromClient_UpdateJewelList", "FromClient_UpdateJewelList")
  registerEvent("FromClient_NotifyExtractJewel", "FromClient_NotifyExtractJewel")
  if self._isPadSnapping == false then
    self._ui.chk_TrashButton:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowTrashButtonTooltip(true)")
    self._ui.chk_TrashButton:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowTrashButtonTooltip(false)")
  end
  self._ui.rdo_ViewByList:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectViewType(" .. JewelViewType.List .. ")")
  self._ui.rdo_ViewByList:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowViewTypeTooltip(true, " .. JewelViewType.List .. ")")
  self._ui.rdo_ViewByList:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowViewTypeTooltip(false, " .. JewelViewType.List .. ")")
  self._ui.rdo_ViewBySlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectViewType(" .. JewelViewType.Slot .. ")")
  self._ui.rdo_ViewBySlot:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowViewTypeTooltip(true, " .. JewelViewType.Slot .. ")")
  self._ui.rdo_ViewBySlot:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowViewTypeTooltip(false, " .. JewelViewType.Slot .. ")")
  self._ui.rdo_SortByName:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectSortType(" .. JewelSortType.SortByName .. ")")
  self._ui.rdo_SortByGroup:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectSortType(" .. JewelSortType.SortByGroupNumber .. ")")
  self._ui.rdo_SortByGrade:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectSortType(" .. JewelSortType.SortByGrade .. ")")
  self._ui.chk_TrashButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_SelectJewelToBeDeleted()")
  self._ui.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"crystalPreset\" )")
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_CloseWithESC()")
  self._ui.list2_Jewel:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_JewelInven_OnCreateJewelListContent")
  self._ui.list2_Jewel:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_Delete:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_DeleteJewel()")
  self._ui.btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CancelDeleteJewel()")
end
function PaGlobal_JewelInven:initializeControl()
  local crystalExtractionSlotBG = UI.getChildControl(self._ui.rdo_ExtractByTool, "Static_RdoSlotBg")
  local slot = {}
  SlotItem.new(slot, "Crystal_Extraction_", 0, crystalExtractionSlotBG, self._extractionSlotConfig)
  slot:createChild()
  self._extractionItemTable[0] = slot
  local blackSpiritSlotBG = UI.getChildControl(self._ui.rdo_ExtractByBlackSpirit, "Static_RdoSlotBg")
  local slot = {}
  SlotItem.new(slot, "BlackSpirit_Extraction_", 0, blackSpiritSlotBG, self._extractionSlotConfig)
  slot:createChild()
  self._extractionItemTable[1] = slot
  self._ui.stc_Desc:SetTextMode(__eTextMode_AutoWrap)
  local buttonY_ConsoleUI = UI.getChildControl(self._ui.btn_Delete, "Button_Y_ConsoleUI")
  local buttonB_ConsoleUI = UI.getChildControl(self._ui.btn_Cancel, "Button_B_ConsoleUI")
  if self._isPadSnapping == true then
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_Question:SetShow(false)
    self._ui.stc_Console_Buttons:SetShow(true)
    buttonY_ConsoleUI:SetShow(true)
    buttonB_ConsoleUI:SetShow(true)
  else
    self._ui.btn_Close:SetShow(true)
    self._ui.btn_Question:SetShow(true)
    self._ui.stc_Console_Buttons:SetShow(false)
    buttonY_ConsoleUI:SetShow(false)
    buttonB_ConsoleUI:SetShow(false)
  end
end
function PaGlobal_JewelInven:prepareOpen(jewelInvenMode)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  self._jewelInvenMode = jewelInvenMode
  self._ui.rdo_ExtractByTool:SetCheck(false)
  self._ui.rdo_ExtractByBlackSpirit:SetCheck(false)
  if self._isPadSnapping == true then
    Panel_Window_JewelPreset_Inven_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    if self._jewelInvenMode == JewelInvenMode.ExtractMode then
      Panel_Window_JewelPreset_Inven_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    else
      Panel_Window_JewelPreset_Inven_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    end
  end
  if PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  if self._jewelViewType == JewelViewType.List then
    self._ui.stc_ListBG:SetShow(true)
    self._ui.stc_SlotBG:SetShow(false)
  else
    self._ui.stc_ListBG:SetShow(false)
    self._ui.stc_SlotBG:SetShow(true)
  end
  PaGlobal_JewelPreset._closeByJewelInven = true
  if PaGlobal_JewelInven._ui.chk_TrashButton:IsCheck() == true then
    PaGlobal_JewelInven._ui.chk_TrashButton:SetCheck(false)
    PaGlobalFunc_JewelInven_SelectJewelToBeDeleted()
  end
  self:update()
  self:computePos()
  self:open()
end
function PaGlobal_JewelInven:open()
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  Panel_Window_JewelPreset_Inven_All:SetShow(true)
  if self._jewelInvenMode ~= JewelInvenMode.ExtractMode then
    audioPostEvent_SystemUi(1, 43)
    _AudioPostEvent_SystemUiForXBOX(1, 43)
  end
  if Panel_Window_JewelPreset_Inven_All:GetShow() == true then
    Inventory_SetFunctor(PaGlobalFunc_JewelInven_Filter, PaGlobalFunc_JewelInven_RClickFunction, nil, nil)
  end
end
function PaGlobal_JewelInven:prepareClose()
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_JewelPreset._closeByJewelInven = false
  self._ui.chk_TrashButton:SetCheck(false)
  self._ui.stc_TrashArea:SetShow(false)
  self._ui.stc_DescArea:SetShow(true)
  self._ui.rdo_SortByName:SetShow(true)
  self._ui.rdo_SortByGroup:SetShow(true)
  self._ui.rdo_SortByGrade:SetShow(true)
  self:close()
end
function PaGlobal_JewelInven:close()
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  Panel_Window_JewelPreset_Inven_All:SetShow(false)
end
function PaGlobal_JewelInven:updateExtractionItem()
  local crystalExtractionSSW = getItemEnchantStaticStatus(self._materialEnchantKey.stuffCrystalExtraction)
  if crystalExtractionSSW ~= nil then
    self._ui.rdo_ExtractByTool:SetText(crystalExtractionSSW:getName())
    self._materialItemInfo.slotNo[0] = getSelfPlayer():get():getInventory():getSlot(self._materialEnchantKey.stuffCrystalExtraction)
    self._materialItemInfo.whereType[0] = CppEnums.ItemWhereType.eInventory
    local itemCount = 0
    if self._materialItemInfo.slotNo[0] ~= __eTInventorySlotNoUndefined then
      itemCount = Int64toInt32(getInventoryItemByType(self._materialItemInfo.whereType[0], self._materialItemInfo.slotNo[0]):get():getCount_s64())
    end
    self._extractionItemTable[0]:setItemByStaticStatus(crystalExtractionSSW, itemCount)
    if self._isPadSnapping == false then
      self._extractionItemTable[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(true," .. tostring(0) .. ")")
      self._extractionItemTable[0].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(false," .. tostring(0) .. ")")
    else
      self._ui.rdo_ExtractByTool:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(true," .. tostring(0) .. ")")
      self._ui.rdo_ExtractByTool:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(false," .. tostring(0) .. ")")
    end
    local crystalExtractionCountControl = UI.getChildControl(self._ui.rdo_ExtractByTool, "StaticText_Count")
    crystalExtractionCountControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", tostring(itemCount)))
    if itemCount == 0 then
      self._ui.rdo_ExtractByTool:SetFontColor(Defines.Color.C_FFC4C4C4)
      self._ui.rdo_ExtractByTool:SetIgnore(true)
      self._ui.rdo_ExtractByTool:SetMonoTone(true)
      local slotBG = UI.getChildControl(self._ui.rdo_ExtractByTool, "Static_RdoSlotBg")
      slotBG:SetIgnore(true)
    else
      PAGlobalFunc_SetItemTextColor(self._ui.rdo_ExtractByTool, crystalExtractionSSW)
      self._ui.rdo_ExtractByTool:SetIgnore(false)
      self._ui.rdo_ExtractByTool:SetMonoTone(false)
      local slotBG = UI.getChildControl(self._ui.rdo_ExtractByTool, "Static_RdoSlotBg")
      slotBG:SetIgnore(false)
    end
  end
  local blackSpiritSSW = getItemEnchantStaticStatus(self._materialEnchantKey.stuffBlackspirit)
  if blackSpiritSSW ~= nil then
    self._ui.rdo_ExtractByBlackSpirit:SetText(blackSpiritSSW:getName())
    self._materialItemInfo.slotNo[1] = getSelfPlayer():get():getCashInventory():getSlot(self._materialEnchantKey.stuffBlackspirit)
    self._materialItemInfo.whereType[1] = CppEnums.ItemWhereType.eCashInventory
    local itemCount = 0
    if self._materialItemInfo.slotNo[1] ~= __eTInventorySlotNoUndefined then
      itemCount = Int64toInt32(getInventoryItemByType(self._materialItemInfo.whereType[1], self._materialItemInfo.slotNo[1]):get():getCount_s64())
    end
    self._extractionItemTable[1]:setItemByStaticStatus(blackSpiritSSW, itemCount)
    if self._isPadSnapping == false then
      self._extractionItemTable[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(true," .. tostring(1) .. ")")
      self._extractionItemTable[1].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(false," .. tostring(1) .. ")")
    else
      self._ui.rdo_ExtractByBlackSpirit:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(true," .. tostring(1) .. ")")
      self._ui.rdo_ExtractByBlackSpirit:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowExtractionItemToolTip(false," .. tostring(1) .. ")")
    end
    local blackSpiritCountControl = UI.getChildControl(self._ui.rdo_ExtractByBlackSpirit, "StaticText_Count")
    blackSpiritCountControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_METERIALITEMCNT", "count", tostring(itemCount)))
    if itemCount == 0 then
      self._ui.rdo_ExtractByBlackSpirit:SetFontColor(Defines.Color.C_FFC4C4C4)
      self._ui.rdo_ExtractByBlackSpirit:SetIgnore(true)
      self._ui.rdo_ExtractByBlackSpirit:SetMonoTone(true)
      local slotBG = UI.getChildControl(self._ui.rdo_ExtractByBlackSpirit, "Static_RdoSlotBg")
      slotBG:SetIgnore(true)
    else
      PAGlobalFunc_SetItemTextColor(self._ui.rdo_ExtractByBlackSpirit, blackSpiritSSW)
      self._ui.rdo_ExtractByBlackSpirit:SetIgnore(false)
      self._ui.rdo_ExtractByBlackSpirit:SetMonoTone(false)
      local slotBG = UI.getChildControl(self._ui.rdo_ExtractByBlackSpirit, "Static_RdoSlotBg")
      slotBG:SetIgnore(false)
    end
  end
end
function PaGlobal_JewelInven:update()
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  ToClient_ClearDeleteJewelNoList()
  if self._jewelViewType == JewelViewType.List then
    local curIndex = self._ui.list2_Jewel:getCurrenttoIndex()
    local listManager = self._ui.list2_Jewel:getElementManager()
    listManager:clearKey()
    local jewelListTable = self:sortJewelList()
    for idx, value in pairs(jewelListTable) do
      local jewelNo = ToClient_GetJewelNoByIndex(value)
      listManager:pushKey(jewelNo)
    end
    for idx = 1, ToClient_GetJewelInvenCount() - #jewelListTable do
      listManager:pushKey(-2)
    end
    if self._isConsole == false and self._jewelInvenMode ~= JewelInvenMode.ExtractMode and ToClient_GetJewelInvenCount() < ToClient_GetJewelInvenMaxCount() then
      listManager:pushKey(-1)
    end
    self._ui.list2_Jewel:moveIndex(curIndex)
  else
    local jewelListTable = self:sortJewelList()
    local jewelInvenCount = ToClient_GetJewelInvenCount()
    for idx = 0, ToClient_GetJewelInvenMaxCount() - 1 do
      local slot = self._jewelSlotList[idx]
      slot.add:addInputEvent("Mouse_On", "")
      slot.add:addInputEvent("Mouse_Out", "")
      slot.add:addInputEvent("Mouse_LUp", "")
      slot.check:SetShow(false)
      local isUseControl = UI.getChildControl(slot.empty, "Static_IsUse")
      isUseControl:SetShow(false)
      if idx < jewelInvenCount then
        slot.empty:SetShow(true)
        slot.lock:SetShow(false)
        slot.add:SetShow(false)
        local listIndex = jewelListTable[idx + 1]
        if listIndex ~= nil then
          slot.empty:SetShow(true)
          slot.lock:SetShow(false)
          slot.add:SetShow(false)
          local jewelNo = ToClient_GetJewelNoByIndex(listIndex)
          if jewelNo ~= -1 then
            local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
            if jewelItemSSW ~= nil then
              slot.jewelItem:setItemByStaticStatus(jewelItemSSW)
              local jewelString = tostring(jewelNo)
              local isJewelUse = false
              for i = ToClient_GetJewelPresetMaxCount() - 1, 0, -1 do
                local isShow = ToClient_IsJewelInThatPreset(i, jewelNo)
                if isShow == true then
                  isJewelUse = true
                  break
                end
              end
              if isJewelUse == true then
                isUseControl:SetShow(true)
              end
              if self._isPadSnapping == true then
                slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowJewelSlotTooltip(true, " .. jewelString .. ", " .. idx .. ")")
                slot.empty:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelSlotTooltip(false, " .. jewelString .. ", " .. idx .. ")")
                slot.empty:addInputEvent("Mouse_LUp", "")
                slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
                if isJewelUse == true then
                  slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltipBySlot(true, " .. jewelString .. ", " .. idx .. ")")
                else
                  slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
                end
              else
                slot.jewelItem.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowJewelSlotTooltip(true, " .. jewelString .. ", " .. idx .. ")")
                slot.jewelItem.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelSlotTooltip(false, " .. jewelString .. ", " .. idx .. ")")
                slot.jewelItem.icon:addInputEvent("Mouse_LUp", "")
                if isJewelUse == true then
                  isUseControl:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltip(true, " .. jewelString .. ")")
                  isUseControl:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltip(false, " .. jewelString .. ")")
                else
                  isUseControl:addInputEvent("Mouse_On", "")
                  isUseControl:addInputEvent("Mouse_Out", "")
                end
              end
              local needMonoTone = self:decideMonotone(jewelNo)
              slot.jewelItem.icon:SetMonoTone(needMonoTone)
              slot.jewelItem.icon:addInputEvent("Mouse_LUp", "")
              if self._jewelInvenMode == JewelInvenMode.PushOrPopMode then
                if needMonoTone == false then
                  slot.jewelItem.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_PushJewel(" .. jewelString .. ")")
                end
              elseif self._jewelInvenMode == JewelInvenMode.ExtractMode then
                if self._isPadSnapping == true then
                  slot.empty:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_JewelInven_ExtractJewel(" .. jewelString .. ")")
                else
                  slot.jewelItem.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_ExtractJewel(" .. jewelString .. ")")
                end
              elseif self._jewelInvenMode == JewelInvenMode.InventoryMode and self._ui.chk_TrashButton:IsCheck() == true then
                slot.jewelItem.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewelBySlotMode(" .. jewelString .. ", " .. idx .. ", true)")
                slot.check:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewelBySlotMode(" .. jewelString .. ", " .. idx .. ", false)")
              end
            else
              slot.jewelItem:clearItem()
            end
          else
            slot.jewelItem:clearItem()
          end
        else
          slot.jewelItem:clearItem()
        end
      elseif idx == jewelInvenCount and self._isConsole == false and self._jewelInvenMode ~= JewelInvenMode.ExtractMode then
        slot.empty:SetShow(false)
        slot.lock:SetShow(false)
        slot.add:SetShow(true)
        slot.add:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowJewelInvenIncreaseItemTooltip(true, " .. idx .. ")")
        slot.add:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelInvenIncreaseItemTooltip(false, " .. idx .. ")")
        if self._isConsole == false then
          slot.add:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_BuyJewelInvenItem()")
        end
        slot.jewelItem:clearItem()
      else
        slot.empty:SetShow(false)
        slot.lock:SetShow(true)
        slot.add:SetShow(false)
        slot.jewelItem:clearItem()
      end
    end
  end
  if self._jewelInvenMode == JewelInvenMode.ExtractMode then
    self:updateExtractionItem()
  end
  self:updateJewelListCount(ToClient_GetJewelListSize())
  if self._jewelSortType == JewelSortType.SortByGroupNumber then
    self._ui.rdo_SortByName:SetCheck(false)
    self._ui.rdo_SortByGroup:SetCheck(true)
    self._ui.rdo_SortByGrade:SetCheck(false)
  elseif self._jewelSortType == JewelSortType.SortByName then
    self._ui.rdo_SortByName:SetCheck(true)
    self._ui.rdo_SortByGroup:SetCheck(false)
    self._ui.rdo_SortByGrade:SetCheck(false)
  elseif self._jewelSortType == JewelSortType.SortByGrade then
    self._ui.rdo_SortByName:SetCheck(false)
    self._ui.rdo_SortByGroup:SetCheck(false)
    self._ui.rdo_SortByGrade:SetCheck(true)
  end
  if self._jewelViewType == JewelViewType.Slot then
    self._ui.rdo_ViewByList:SetCheck(false)
    self._ui.rdo_ViewBySlot:SetCheck(true)
  elseif self._jewelViewType == JewelViewType.List then
    self._ui.rdo_ViewByList:SetCheck(true)
    self._ui.rdo_ViewBySlot:SetCheck(false)
  end
  if self._jewelInvenMode == JewelInvenMode.InventoryMode then
    self._ui.stc_JewelCount:SetSpanSize(70, self._ui.stc_JewelCount:GetSpanSize().y)
    self._ui.chk_TrashButton:SetShow(true)
  else
    self._ui.stc_JewelCount:SetSpanSize(10, self._ui.stc_JewelCount:GetSpanSize().y)
    self._ui.chk_TrashButton:SetShow(false)
  end
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_JewelInven:sortJewelList()
  local jewelListSize = ToClient_GetJewelListSize()
  local jewelNoTable = {}
  for index = 0, jewelListSize - 1 do
    local jewelNo = ToClient_GetJewelNoByIndex(index)
    if jewelNo ~= -1 then
      jewelNoTable[index] = jewelNo
    end
  end
  local monotoneTable = {}
  local notMonotoneTable = {}
  for index = 0, jewelListSize - 1 do
    local jewelNo = jewelNoTable[index]
    local needMonoTone = false
    if self._jewelInvenMode == JewelInvenMode.InventoryMode or self._jewelInvenMode == JewelInvenMode.ExtractMode then
      table.insert(notMonotoneTable, index)
    else
      needMonoTone = ToClient_IsJewelInSelectedPreset(jewelNo)
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW ~= nil then
        local jewelGroupMaxCount = jewelItemSSW:getJewelGroupMaxCount()
        if jewelGroupMaxCount > 0 then
          local jewelGroup = jewelItemSSW:getJewelGroupNumber()
          local sameJewelGroupCount = 0
          for idx = 0, __eJewelSlotMaxCount - 1 do
            local jewelItemSSW2 = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(idx)
            if jewelItemSSW2 ~= nil then
              local jewelGroup2 = jewelItemSSW2:getJewelGroupNumber()
              if jewelGroup == jewelGroup2 then
                sameJewelGroupCount = sameJewelGroupCount + 1
              end
            end
          end
          if jewelGroupMaxCount <= sameJewelGroupCount then
            needMonoTone = true
          end
        end
      end
      if ToClient_IsJewelInSpecialGroup(PaGlobal_JewelPreset._selectedJewelSlot, jewelNo) == false then
        needMonoTone = true
      end
      if needMonoTone == true then
        table.insert(monotoneTable, index)
      else
        table.insert(notMonotoneTable, index)
      end
    end
  end
  if self._jewelSortType == JewelSortType.SortByGroupNumber then
    local sortFunc1 = function(index1, index2)
      local jewelNo = ToClient_GetJewelNoByIndex(index1)
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW == nil then
        return false
      end
      local jewelItem1GroupNumber = jewelItemSSW:getJewelGroupNumber()
      local jewelItem1Name = jewelItemSSW:getName()
      jewelNo = ToClient_GetJewelNoByIndex(index2)
      jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW == nil then
        return false
      end
      local jewelItem2GroupNumber = jewelItemSSW:getJewelGroupNumber()
      local jewelItem2Name = jewelItemSSW:getName()
      if jewelItem1GroupNumber == jewelItem2GroupNumber then
        return stringCompare(jewelItem1Name, jewelItem2Name) < 0
      else
        return jewelItem1GroupNumber < jewelItem2GroupNumber
      end
    end
    table.sort(monotoneTable, sortFunc1)
    table.sort(notMonotoneTable, sortFunc1)
  elseif self._jewelSortType == JewelSortType.SortByName then
    local sortFunc = function(index1, index2)
      local jewelNo = ToClient_GetJewelNoByIndex(index1)
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW == nil then
        return false
      end
      local jewelItem1Name = jewelItemSSW:getName()
      jewelNo = ToClient_GetJewelNoByIndex(index2)
      jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW == nil then
        return false
      end
      local jewelItem2Name = jewelItemSSW:getName()
      return stringCompare(jewelItem1Name, jewelItem2Name) < 0
    end
    table.sort(monotoneTable, sortFunc)
    table.sort(notMonotoneTable, sortFunc)
  elseif self._jewelSortType == JewelSortType.SortByGrade then
    local sortFunc = function(index1, index2)
      local jewelNo = ToClient_GetJewelNoByIndex(index1)
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW == nil then
        return false
      end
      local jewelItem1GroupNumber = jewelItemSSW:getJewelGroupNumber()
      local jewelItem1Grade = jewelItemSSW:getGradeType()
      local jewelItem1Name = jewelItemSSW:getName()
      jewelNo = ToClient_GetJewelNoByIndex(index2)
      jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
      if jewelItemSSW == nil then
        return false
      end
      local jewelItem2GroupNumber = jewelItemSSW:getJewelGroupNumber()
      local jewelItem2Grade = jewelItemSSW:getGradeType()
      local jewelItem2Name = jewelItemSSW:getName()
      if jewelItem1Grade == jewelItem2Grade then
        if jewelItem1GroupNumber == jewelItem2GroupNumber then
          return stringCompare(jewelItem1Name, jewelItem2Name) < 0
        else
          return jewelItem1GroupNumber < jewelItem2GroupNumber
        end
      else
        return jewelItem1Grade > jewelItem2Grade
      end
    end
    table.sort(monotoneTable, sortFunc)
    table.sort(notMonotoneTable, sortFunc)
  end
  local jewelInvenTable = {}
  for idx, value in pairs(notMonotoneTable) do
    table.insert(jewelInvenTable, value)
  end
  for idx, value in pairs(monotoneTable) do
    table.insert(jewelInvenTable, value)
  end
  return jewelInvenTable
end
function PaGlobal_JewelInven:pushJewel(inventoryType, slotNo)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  ToClient_PushJewelToJewelList(inventoryType, slotNo)
end
function PaGlobal_JewelInven:extractJewel(jewelNo_s64)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  local function extractJewel()
    audioPostEvent_SystemUi(5, 7)
    _AudioPostEvent_SystemUiForXBOX(5, 7)
    if self._ui.rdo_ExtractByTool:IsChecked() == true then
      if self._materialItemInfo.slotNo[0] == __eTInventorySlotNoUndefined then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemNeedNotExist"))
        return
      end
      ToClient_PopJewelFromJewelList(jewelNo_s64, self._materialItemInfo.whereType[0], self._materialItemInfo.slotNo[0])
    elseif self._ui.rdo_ExtractByBlackSpirit:IsChecked() == true then
      if self._materialItemInfo.slotNo[1] == __eTInventorySlotNoUndefined then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemNeedNotExist"))
        return
      end
      ToClient_PopJewelFromJewelList(jewelNo_s64, self._materialItemInfo.whereType[1], self._materialItemInfo.slotNo[1])
    end
  end
  local itemSSW
  if self._ui.rdo_ExtractByTool:IsChecked() == true then
    itemSSW = getItemEnchantStaticStatus(self._materialEnchantKey.stuffCrystalExtraction)
  elseif self._ui.rdo_ExtractByBlackSpirit:IsChecked() == true then
    itemSSW = getItemEnchantStaticStatus(self._materialEnchantKey.stuffBlackspirit)
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESETINVEN_EXTRACTION_NOSELECT"))
    return
  end
  local itemName = "[" .. itemSSW:getName() .. "]"
  local strItemName = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemName, itemSSW)
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_CRYSTALINVEN_MESSAGE_EXTRACT", "itemname", strItemName)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_EXTRACTION_CRYSTAL_TITLE"),
    content = messageBoxMemo,
    functionYes = extractJewel,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_JewelInven:createJewelInvenContent(content, jewelNo_s64)
  local btn_slot = UI.getChildControl(content, "Button_Normal")
  local btn_special = UI.getChildControl(content, "Button_Special")
  local slotBG = UI.getChildControl(content, "Static_SlotBg")
  local addableSlotBG = UI.getChildControl(content, "Static_AddableSlotBg")
  local jewelName = UI.getChildControl(content, "StaticText_CrystalName")
  local jewelDesc = UI.getChildControl(content, "MultilineText_CrystalDesc")
  local jewelState = UI.getChildControl(content, "StaticText_StateDesc")
  local jewelUse = UI.getChildControl(content, "Static_IsUse")
  local addSlot = UI.getChildControl(content, "StaticText_LockSlot")
  jewelDesc:SetIgnore(true)
  btn_slot:SetIgnore(false)
  if Int64toInt32(jewelNo_s64) == -1 then
    btn_slot:SetShow(true)
    btn_special:SetShow(false)
    slotBG:SetShow(false)
    addableSlotBG:SetShow(false)
    jewelName:SetShow(false)
    jewelDesc:SetShow(false)
    jewelState:SetShow(false)
    jewelUse:SetShow(false)
    addSlot:SetShow(true)
    btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_BuyJewelInvenItem()")
    addSlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_BuyJewelInvenItem()")
    btn_slot:SetIgnore(false)
    return
  elseif Int64toInt32(jewelNo_s64) == -2 then
    content:SetMonoTone(false)
    btn_slot:SetShow(true)
    btn_special:SetShow(false)
    slotBG:SetShow(true)
    addableSlotBG:SetShow(false)
    jewelName:SetShow(false)
    jewelDesc:SetShow(false)
    jewelState:SetShow(true)
    addSlot:SetShow(false)
    jewelUse:SetShow(false)
    btn_slot:addInputEvent("Mouse_LUp", "")
    btn_slot:SetIgnore(true)
    local slot = {}
    SlotItem.reInclude(slot, "JewelList_Slot_", 0, slotBG, self._slotConfig)
    slot:clearItem()
    slot.icon:addInputEvent("Mouse_On", "")
    slot.icon:addInputEvent("Mouse_Out", "")
    slot.icon:addInputEvent("Mouse_LUp", "")
    return
  end
  local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo_s64)
  if jewelItemSSW == nil then
    return
  end
  local jewelNoDeleteSize = ToClient_GetJewelDeleteListSize()
  local isInDeletedList = false
  for idx = 0, jewelNoDeleteSize - 1 do
    local jewelNo = ToClient_GetDeleteJewelNoByIndex(idx)
    if jewelNo_s64 == jewelNo then
      isInDeletedList = true
    end
  end
  btn_slot:SetShow(not isInDeletedList)
  btn_special:SetShow(isInDeletedList)
  slotBG:SetShow(true)
  addableSlotBG:SetShow(false)
  jewelName:SetShow(true)
  jewelDesc:SetShow(true)
  jewelState:SetShow(false)
  addSlot:SetShow(false)
  btn_slot:addInputEvent("Mouse_LUp", "")
  local slot = {}
  SlotItem.reInclude(slot, "JewelList_Slot_", 0, slotBG, self._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(jewelItemSSW)
  jewelName:SetTextMode(__eTextMode_LimitText)
  jewelName:SetText(jewelItemSSW:getName())
  PAGlobalFunc_SetItemTextColor(jewelName, jewelItemSSW)
  local classType = getSelfPlayer():getClassType()
  local jewelSkillStaticWrapper = jewelItemSSW:getSkillByIdx(classType)
  if nil ~= jewelSkillStaticWrapper then
    local buffCount = jewelSkillStaticWrapper:getBuffCount()
    local descText = ""
    for buffIdx = 0, buffCount - 1 do
      local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
      if "" == descCurrent then
        break
      end
      if 0 == buffIdx then
        descText = descCurrent
      else
        descText = descText .. " & " .. descCurrent
      end
    end
    jewelDesc:setLineCountByLimitAutoWrap(2)
    jewelDesc:SetText(descText)
  end
  local jewelString = tostring(jewelNo_s64)
  slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowJewelTooltip(true," .. jewelString .. ")")
  slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelTooltip(false," .. jewelString .. ")")
  local needMonoTone = self:decideMonotone(jewelNo_s64)
  local isJewelUse = false
  for i = ToClient_GetJewelPresetMaxCount() - 1, 0, -1 do
    local isShow = ToClient_IsJewelInThatPreset(i, jewelNo_s64)
    if isShow == true then
      isJewelUse = true
      break
    end
  end
  jewelUse:SetShow(isJewelUse)
  if isJewelUse == false then
    jewelUse:addInputEvent("Mouse_On", "")
    jewelUse:addInputEvent("Mouse_Out", "")
    if self._isPadSnapping == true then
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "")
    end
  elseif self._isPadSnapping == true then
    btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltip(true, " .. jewelString .. ")")
  else
    jewelUse:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltip(true, " .. jewelString .. ")")
    jewelUse:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowAppliedJewelPresetTooltip(false, " .. jewelString .. ")")
  end
  content:SetMonoTone(needMonoTone)
  if needMonoTone == true then
    btn_slot:addInputEvent("Mouse_LUp", "")
    slot.icon:addInputEvent("Mouse_LUp", "")
    if self._isPadSnapping == true then
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowJewelTooltip(true," .. jewelString .. ")")
      btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelTooltip(false," .. jewelString .. ")")
    end
  elseif self._jewelInvenMode == JewelInvenMode.PushOrPopMode then
    if self._isPadSnapping == true then
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowJewelTooltip(true," .. jewelString .. ")")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_JewelPreset_PushJewel(" .. jewelString .. ")")
      btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelTooltip(false," .. jewelString .. ")")
    else
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_PushJewel(" .. jewelString .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelPreset_PushJewel(" .. jewelString .. ")")
    end
  elseif self._jewelInvenMode == JewelInvenMode.ExtractMode then
    if self._isPadSnapping == true then
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_JewelInven_ExtractJewel(" .. jewelString .. ")")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowJewelTooltip(true," .. jewelString .. ")")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelTooltip(false," .. jewelString .. ")")
      btn_slot:addInputEvent("Mouse_LUp", "")
      btn_special:addInputEvent("Mouse_LUp", "")
      slot.icon:addInputEvent("Mouse_LUp", "")
    else
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_ExtractJewel(" .. jewelString .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_ExtractJewel(" .. jewelString .. ")")
    end
  elseif self._jewelInvenMode == JewelInvenMode.InventoryMode then
    if self._isPadSnapping == true then
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_JewelInven_ShowJewelTooltip(true," .. jewelString .. ")")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_JewelInven_ShowJewelTooltip(false," .. jewelString .. ")")
      if self._ui.chk_TrashButton:IsCheck() == true then
        btn_slot:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_updateKeyGuideDeleteMode(" .. jewelString .. ")")
        btn_special:addInputEvent("Mouse_On", "PaGlobalFunc_JewelInven_updateKeyGuideDeleteMode(" .. jewelString .. ")")
        btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewel(" .. jewelString .. ")")
        btn_special:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewel(" .. jewelString .. ")")
      else
        btn_slot:addInputEvent("Mouse_LUp", "")
        btn_special:addInputEvent("Mouse_LUp", "")
        slot.icon:addInputEvent("Mouse_LUp", "")
      end
    elseif self._ui.chk_TrashButton:IsCheck() == true then
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewel(" .. jewelString .. ")")
      btn_special:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewel(" .. jewelString .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_JewelInven_CheckDeleteJewel(" .. jewelString .. ")")
    else
      btn_slot:addInputEvent("Mouse_LUp", "")
      btn_special:addInputEvent("Mouse_LUp", "")
      slot.icon:addInputEvent("Mouse_LUp", "")
    end
  end
end
function PaGlobal_JewelInven:updateJewelListCount(jewelListCount)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  local jewelInvenMaxCount = ToClient_GetJewelInvenCount()
  local str = tostring(jewelListCount) .. "/" .. tostring(jewelInvenMaxCount)
  local leftCountPercent = jewelListCount / jewelInvenMaxCount * 100
  if leftCountPercent >= 100 then
    fontColor = "<PAColor0xFFF03838>"
  elseif leftCountPercent > 90 then
    fontColor = "<PAColor0xFFFF8957>"
  else
    fontColor = "<PAColor0xFFFFF3AF>"
  end
  self._ui.stc_JewelCount:SetText(fontColor .. str .. "<PAOldColor>")
end
function PaGlobal_JewelInven:computePos()
  local posX = Panel_Window_JewelPreset_All:GetPosX() + (Panel_Window_JewelPreset_All:GetSizeX() - Panel_Window_JewelPreset_Inven_All:GetSizeX()) * 0.5
  local posY = Panel_Window_JewelPreset_All:GetPosY()
  Panel_Window_JewelPreset_Inven_All:SetPosXY(posX, posY)
  if self._jewelInvenMode == JewelInvenMode.PushOrPopMode or self._jewelInvenMode == JewelInvenMode.InventoryMode then
    self._ui.stc_BottomArea:SetShow(false)
    self._ui.rdo_ExtractByTool:SetShow(false)
    self._ui.rdo_ExtractByBlackSpirit:SetShow(false)
    self._ui.stc_DescArea:SetShow(true)
    if self._isPadSnapping == true then
      self._ui.stc_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CRYSTALPRESET_INVEN_DESC_CONSOLE"))
    else
      self._ui.stc_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_CRYSTALPRESET_INVEN_DESC"))
    end
    self._ui.stc_DescArea:SetSize(self._ui.stc_DescArea:GetSizeX(), self._ui.stc_Desc:GetTextSizeY() + 5)
    local panelSizeY = 0
    if self._jewelViewType == JewelViewType.List then
      self._ui.stc_DescArea:SetPosY(self._ui.stc_ListBG:GetPosY() + self._ui.stc_ListBG:GetSizeY() + 5)
      panelSizeY = self._ui.stc_TitleBarArea:GetSizeY() + self._ui.stc_TopArea:GetSizeY() + self._ui.stc_ListBG:GetSizeY() + self._ui.stc_DescArea:GetSizeY() + 20
    else
      self._ui.stc_DescArea:SetPosY(self._ui.stc_SlotBG:GetPosY() + self._ui.stc_SlotBG:GetSizeY() + 5)
      panelSizeY = self._ui.stc_TitleBarArea:GetSizeY() + self._ui.stc_TopArea:GetSizeY() + self._ui.stc_SlotBG:GetSizeY() + self._ui.stc_DescArea:GetSizeY() + 20
    end
    Panel_Window_JewelPreset_Inven_All:SetSize(Panel_Window_JewelPreset_Inven_All:GetSizeX(), panelSizeY)
    if self._isPadSnapping == true then
      self._ui.stc_Console_Buttons:SetShow(true)
      self._ui.stc_Console_Buttons:SetPosY(panelSizeY)
      if self._jewelInvenMode == JewelInvenMode.PushOrPopMode then
        self._ui.btn_Console_Detail:SetShow(true)
        self._ui.btn_Console_Select:SetShow(true)
        self._ui.btn_Console_Cancel:SetShow(true)
        self._ui.btn_Console_Delete:SetShow(false)
        self._ui.btn_Console_PresetList:SetShow(true)
        local keyGuideList = {
          self._ui.btn_Console_PresetList,
          self._ui.btn_Console_Detail,
          self._ui.btn_Console_Select,
          self._ui.btn_Console_Cancel
        }
        self._ui.btn_Console_Delete:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_REMOVE"))
        PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      else
        self._ui.btn_Console_Detail:SetShow(true)
        self._ui.btn_Console_Select:SetShow(true)
        self._ui.btn_Console_Cancel:SetShow(true)
        self._ui.btn_Console_Delete:SetShow(false)
        self._ui.btn_Console_PresetList:SetShow(true)
        local keyGuideList = {
          self._ui.btn_Console_PresetList,
          self._ui.btn_Console_Detail,
          self._ui.btn_Console_Select,
          self._ui.btn_Console_Cancel
        }
        self._ui.btn_Console_Delete:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_REMOVE"))
        PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      end
    else
      self._ui.stc_Console_Buttons:SetShow(false)
    end
  else
    self._ui.stc_BottomArea:SetShow(true)
    self._ui.rdo_ExtractByTool:SetShow(true)
    self._ui.rdo_ExtractByBlackSpirit:SetShow(true)
    self._ui.stc_DescArea:SetShow(false)
    self._ui.stc_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_EXTRACTION_CRYSTAL_BTN_EXTRACTION "))
    self._ui.stc_DescArea:SetSize(self._ui.stc_DescArea:GetSizeX(), self._ui.stc_Desc:GetTextSizeY() + 5)
    local panelSizeY = 0
    if self._jewelViewType == JewelViewType.List then
      self._ui.stc_BottomArea:SetPosY(self._ui.stc_ListBG:GetPosY() + self._ui.stc_ListBG:GetSizeY() + 5)
      panelSizeY = self._ui.stc_TitleBarArea:GetSizeY() + self._ui.stc_TopArea:GetSizeY() + self._ui.stc_ListBG:GetSizeY() + self._ui.stc_BottomArea:GetSizeY() + 10
    else
      self._ui.stc_BottomArea:SetPosY(self._ui.stc_SlotBG:GetPosY() + self._ui.stc_SlotBG:GetSizeY() + 5)
      panelSizeY = self._ui.stc_TitleBarArea:GetSizeY() + self._ui.stc_TopArea:GetSizeY() + self._ui.stc_SlotBG:GetSizeY() + self._ui.stc_BottomArea:GetSizeY() + 10
    end
    Panel_Window_JewelPreset_Inven_All:SetSize(Panel_Window_JewelPreset_Inven_All:GetSizeX(), panelSizeY)
    if self._isPadSnapping == true then
      self._ui.stc_Console_Buttons:SetShow(true)
      self._ui.stc_Console_Buttons:SetPosY(panelSizeY)
      self._ui.btn_Console_Delete:SetShow(true)
      self._ui.btn_Console_Select:SetShow(false)
      self._ui.btn_Console_Cancel:SetShow(true)
      self._ui.btn_Console_Detail:SetShow(true)
      self._ui.btn_Console_PresetList:SetShow(true)
      local keyGuideList = {
        self._ui.btn_Console_PresetList,
        self._ui.btn_Console_Delete,
        self._ui.btn_Console_Cancel,
        self._ui.btn_Console_Detail
      }
      self._ui.btn_Console_Delete:SetText(PAGetString(Defines.StringSheet_RESOURCE, "UI_WINDOW_EXTRACTION_CRYSTAL_BTN_EXTRACTION"))
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_Console_Buttons, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    else
      self._ui.stc_Console_Buttons:SetShow(false)
    end
  end
end
function PaGlobal_JewelInven:updateKeyGuideDeleteMode(stringJewelNo)
  if Panel_Window_JewelPreset_Inven_All == nil then
    return
  end
  local jewelNo = tonumber64(stringJewelNo)
  local listControl = PaGlobal_JewelInven._ui.list2_Jewel:GetContentByKey(jewelNo)
  if listControl == nil then
    return
  end
  local btn_slot = UI.getChildControl(listControl, "Button_Normal")
  local btn_special = UI.getChildControl(listControl, "Button_Special")
  if btn_slot == nil or btn_special == nil then
    return
  end
  if btn_slot:GetShow() == true then
    self._ui.btn_Console_Select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
  elseif btn_special:GetShow() == true then
    self._ui.btn_Console_Select:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_RELEASE"))
  end
end
function PaGlobal_JewelInven:notifyExtractJewel(jewelKey)
  if self._jewelInvenMode ~= JewelInvenMode.ExtractMode then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(ItemEnchantKey(jewelKey))
  if itemEnchantSSW == nil then
    return
  end
  PaGlobal_ExtractionResult:showResultMessage(PAGetString(Defines.StringSheet_GAME, "LUA_EXTRACTION_CRYSTAL_EXTRACT_DONE"), itemEnchantSSW:getName(), itemEnchantSSW)
end
function PaGlobal_JewelInven:decideMonotone(jewelNo)
  local needMonoTone = false
  if self._jewelInvenMode == JewelInvenMode.InventoryMode or self._jewelInvenMode == JewelInvenMode.ExtractMode then
    needMonoTone = false
  else
    needMonoTone = ToClient_IsJewelInSelectedPreset(jewelNo)
    local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelList(jewelNo)
    if jewelItemSSW ~= nil then
      local jewelGroupMaxCount = jewelItemSSW:getJewelGroupMaxCount()
      if jewelGroupMaxCount > 0 then
        local jewelGroup = jewelItemSSW:getJewelGroupNumber()
        local sameJewelGroupCount = 0
        for index = 0, __eJewelSlotMaxCount - 1 do
          local jewelItemSSW2 = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(index)
          if jewelItemSSW2 ~= nil then
            local jewelGroup2 = jewelItemSSW2:getJewelGroupNumber()
            if jewelGroup == jewelGroup2 then
              sameJewelGroupCount = sameJewelGroupCount + 1
            end
          end
        end
        if jewelGroupMaxCount <= sameJewelGroupCount then
          needMonoTone = true
        end
      end
    end
    if ToClient_IsJewelInSpecialGroup(PaGlobal_JewelPreset._selectedJewelSlot, jewelNo) == false then
      needMonoTone = true
    end
  end
  return needMonoTone
end
function FromClient_UpdateJewelList()
  PaGlobal_JewelInven:update()
end
function FromClient_NotifyExtractJewel(jewelKey)
  PaGlobal_JewelInven:notifyExtractJewel(jewelKey)
end
function PaGlobal_JewelInven:validate()
  self._ui.stc_TitleBarArea:isValidate()
  self._ui.btn_Close:isValidate()
  self._ui.btn_Question:isValidate()
  self._ui.stc_TopArea:isValidate()
  self._ui.stc_JewelCount:isValidate()
  self._ui.rdo_SortByName:isValidate()
  self._ui.rdo_SortByGroup:isValidate()
  self._ui.rdo_SortByGrade:isValidate()
  self._ui.chk_TrashButton:isValidate()
  self._ui.rdo_ViewByList:isValidate()
  self._ui.rdo_ViewBySlot:isValidate()
  self._ui.stc_ListBG:isValidate()
  self._ui.list2_Jewel:isValidate()
  self._ui.list2_JewelContent:isValidate()
  self._ui.scroll_Vertical:isValidate()
  self._ui.stc_SlotBG:isValidate()
  self._ui.stc_Frame:isValidate()
  self._ui.stc_FrameContent:isValidate()
  self._ui.stc_VerticalScroll:isValidate()
  self._ui.stc_BottomArea:isValidate()
  self._ui.rdo_ExtractByTool:isValidate()
  self._ui.rdo_ExtractByBlackSpirit:isValidate()
  self._ui.stc_DescArea:isValidate()
  self._ui.stc_Desc:isValidate()
  self._ui.stc_TrashArea:isValidate()
  self._ui.stc_TrashDesc:isValidate()
  self._ui.btn_Delete:isValidate()
  self._ui.btn_Cancel:isValidate()
  self._ui.stc_Console_Buttons:isValidate()
  self._ui.btn_Console_Delete:isValidate()
  self._ui.btn_Console_Select:isValidate()
  self._ui.btn_Console_Cancel:isValidate()
  self._ui.btn_Console_Detail:isValidate()
  self._ui.btn_Console_PresetList:isValidate()
end
