function PaGlobal_CombineBag:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initControl()
  self:createSlot()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CombineBag:initControl()
  self._ui.stc_titleBox = UI.getChildControl(Panel_Window_CombineBag, "Static_TitleBox")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBox, "Button_Win_Close")
  self._ui.txt_title = UI.getChildControl(self._ui.stc_titleBox, "StaticText_Title")
  self._ui.stc_noticeBox = UI.getChildControl(Panel_Window_CombineBag, "Static_NoticeBox")
  self._ui.stc_slotBG = UI.getChildControl(Panel_Window_CombineBag, "Static_SlotBG")
  self._ui.btn_puzzle = UI.getChildControl(Panel_Window_CombineBag, "Button_Puzzle")
  self._ui.stc_puzzleNotice = UI.getChildControl(Panel_Window_CombineBag, "Static_Notice")
  self._ui.txt_puzzleNoticeText = UI.getChildControl(self._ui.stc_puzzleNotice, "StaticText_Notice")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_CombineBag, "Static_Key_Guide")
  self._ui.stc_keyGuideDetail = UI.getChildControl(self._ui.stc_keyGuide, "Button_Detail")
  self._ui.stc_keyGuideClose = UI.getChildControl(self._ui.stc_keyGuide, "Button_Close")
  self._ui.stc_keyGuideDelete = UI.getChildControl(self._ui.stc_keyGuide, "Button_Delete")
  self._ui.stc_keyGuideMove = UI.getChildControl(self._ui.stc_keyGuide, "Button_Move")
  if false == isGameTypeKorea() and false == isGameTypeTaiwan() and false == isGameTypeJapan() then
    self._ui.txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YAZ_BAG_SHORT_TITLE"))
  else
    self._ui.txt_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMBINATION_SLOT_TITLE"))
  end
  self._ui.btn_close:SetShow(not self._isConsole)
end
function PaGlobal_CombineBag:validate()
  if Panel_Window_CombineBag == nil then
    return
  end
  self._ui.stc_titleBox:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.txt_title:isValidate()
  self._ui.stc_noticeBox:isValidate()
  self._ui.stc_slotBG:isValidate()
  self._ui.btn_puzzle:isValidate()
  self._ui.stc_puzzleNotice:isValidate()
  self._ui.txt_puzzleNoticeText:isValidate()
  self._ui.stc_keyGuide:isValidate()
  self._ui.stc_keyGuideDetail:isValidate()
  self._ui.stc_keyGuideClose:isValidate()
  self._ui.stc_keyGuideDelete:isValidate()
  self._ui.stc_keyGuideMove:isValidate()
end
function PaGlobal_CombineBag:createSlot()
  if nil ~= self._slotsBG then
    return
  end
  local slotStartX = 10
  local slotStartY = 10
  local slotGapX = 52
  local slotGapY = 52
  local slotRow = self._config.slotRows
  self._slots = {}
  self._slotsEffect = {}
  for ii = 0, self._config.slotCount - 1 do
    local slot = {}
    SlotItem.new(slot, "CombineBag_" .. ii, ii, self._ui.stc_slotBG, self._slotConfig)
    slot:createChild()
    local row = math.floor(ii / self._config.slotCols)
    local col = ii % self._config.slotRows
    slot.icon:SetPosX(slotStartX + slotGapX * col)
    slot.icon:SetPosY(slotStartY + slotGapY * row)
    slot.icon:SetSize(44, 44)
    slot.icon:SetShow(true)
    Panel_Tooltip_Item_SetPosition(ii, slot, "CombineBag")
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0.5)
    slot.border:SetPosY(0.5)
    slot.icon:SetEnableDragAndDrop(true)
    slot._invenSlotNo = nil
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_CombineBag_DropHandler(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_PressMove", "HandleEventPressMove_CombineBag_SlotDrag(" .. ii .. ")")
    slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_CombineBag_Slot(true, " .. ii .. ")")
    slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_CombineBag_Slot(false, " .. ii .. ")")
    if self._isConsole == true then
      slot.icon:setPadSnapType(__ePadSnapType_Target)
      slot.icon:setPadSnapIndex(0)
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventRUp_CombineBag_SlotRClick(" .. ii .. ")")
      slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CombineBag_DropHandler(" .. ii .. ")")
      if true == _ContentsGroup_RenewUI_Tooltip then
        slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_CombineBag_ShowTooltip(" .. ii .. ")")
      end
      slot.icon:addInputEvent("Mouse_RUp", "")
    else
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_CombineBag_SlotRClick(" .. ii .. ")")
    end
    Panel_Tooltip_Item_SetPosition(ii, slot, "CombineBag")
    self._slots[ii] = slot
    local effectSlot = {}
    local puzzle = UI.createControl(__ePAUIControl_Button, slot.icon, "Puzzle_Control_" .. ii)
    CopyBaseProperty(self._ui.btn_puzzle, puzzle)
    puzzle:SetShow(false)
    if self._isConsole == true then
      puzzle:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventLUp_CombineBag_MakePuzzle(" .. ii .. ")")
      puzzle:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventRUp_CombineBag_SlotRClick(" .. ii .. ")")
      puzzle:addInputEvent("Mouse_LUp", "")
    else
      puzzle:addInputEvent("Mouse_LUp", "HandleEventLUp_CombineBag_MakePuzzle(" .. ii .. ")")
    end
    puzzle:addInputEvent("Mouse_On", "HandleEventOnOut_CombineBag_PuzzleButton(true, " .. ii .. ")")
    puzzle:addInputEvent("Mouse_Out", "HandleEventOnOut_CombineBag_PuzzleButton(false, " .. ii .. ")")
    Panel_Window_CombineBag:SetChildIndex(self._ui.stc_puzzleNotice, 9999)
    Panel_Window_CombineBag:SetChildIndex(self._slots[ii].icon, 9998)
    effectSlot.isFirstItem = false
    effectSlot.puzzleControl = puzzle
    self._slotsEffect[ii] = effectSlot
  end
end
function PaGlobal_CombineBag:registEventHandler()
  if Panel_Window_CombineBag == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_CombineBag_Close()")
  registerEvent("FromClient_InventoryUpdate", "FromClient_PaGlobalFunc_CombineBag_UpdateInventory")
end
function PaGlobal_CombineBag:prepareOpen()
  if Panel_Window_CombineBag == nil then
    return
  end
  if _ContentsGroup_CombineBag == false then
    return
  end
  if _ContentsGroup_NewUI_Dye_Palette_All then
    if nil ~= Panel_Window_Dye_Palette_All and true == Panel_Window_Dye_Palette_All:GetShow() then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif nil ~= Panel_DyePalette and true == Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if _ContentsGroup_StaticSlot == true then
    if Panel_Window_NewbieInventory_StaticSlot_All ~= nil and Panel_Window_NewbieInventory_StaticSlot_All:GetShow() == true then
      PaGlobalFunc_NewbieInventory_Close()
    end
  elseif Panel_Window_NewbieInventory_All ~= nil and Panel_Window_NewbieInventory_All:GetShow() == true then
    PaGlobalFunc_NewbieInventory_Close()
  end
  if self._isConsole == false then
    if true == _ContentsGroup_NewUI_Equipment_All then
      PaGlobalFunc_Equipment_All_Close(true)
    else
      HandleClicked_EquipmentWindow_Close()
    end
  end
  self:showFilter()
  self:setMainUIPosition()
  self:open()
end
function PaGlobal_CombineBag:setMainUIPosition()
  if Panel_Window_CombineBag == nil then
    return
  end
  if self._isConsole == true then
    if Panel_Window_Inventory ~= nil then
      local inventoryPanelPosX = Panel_Window_Inventory:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory:GetPosY()
      Panel_Window_CombineBag:SetPosX(inventoryPanelPosX - Panel_Window_CombineBag:GetSizeX() - 5)
      Panel_Window_CombineBag:SetPosY(inventoryPanelPosY)
    end
  elseif Panel_Window_Inventory_All ~= nil and false == Panel_Window_Inventory_All:IsUISubApp() then
    local inventoryPanelPosX = Panel_Window_Inventory_All:GetPosX()
    local inventoryPanelPosY = Panel_Window_Inventory_All:GetPosY()
    local posX = inventoryPanelPosX - Panel_Window_CombineBag:GetSizeX() - 5
    if posX < 0 then
      posX = inventoryPanelPosX + Panel_Window_Inventory_All:GetSizeX() + 5
    end
    Panel_Window_CombineBag:SetPosX(posX)
    Panel_Window_CombineBag:SetPosY(inventoryPanelPosY)
  end
end
function PaGlobal_CombineBag:open()
  if Panel_Window_CombineBag == nil then
    return
  end
  Panel_Window_CombineBag:SetShow(true)
end
function PaGlobal_CombineBag:showFilter()
  Inventory_SetFunctor(PaGlobal_CombineBag_Filter, PaGlobal_CombineBag_RClickFunction, nil, nil)
end
function PaGlobal_CombineBag:prepareClose()
  if Panel_Window_CombineBag == nil then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  for ii = 0, self._config.slotCount - 1 do
    self:clearSlotItem(ii)
  end
  Inventory_updateSlotData()
  self:clearAllSlots()
  if self._isConsole == false then
    local isInvenOpen = false
    if true == _ContentsGroup_NewUI_Inventory_All then
      isInvenOpen = Panel_Window_Inventory_All:GetShow()
    else
      isInvenOpen = Panel_Window_Inventory:GetShow()
    end
    if true == isInvenOpen then
      if false == _ContentsGroup_RenewUI_InventoryEquip then
        if true == _ContentsGroup_NewUI_Equipment_All then
          PaGlobalFunc_Equipment_All_SetShow(true)
        else
          Equipment_SetShow(true)
        end
      else
        PaGlobalFunc_InventoryInfo_Close()
      end
    end
  end
  self:close()
end
function PaGlobal_CombineBag:close()
  if Panel_Window_CombineBag == nil then
    return
  end
  Panel_Window_CombineBag:SetShow(false)
end
function PaGlobal_CombineBag:isShowPanel()
  if Panel_Window_CombineBag == nil then
    return false
  end
  return Panel_Window_CombineBag:GetShow()
end
function PaGlobal_CombineBag:setSlotItem(invenSlotNo, slotNo)
  if invenSlotNo == nil then
    return
  end
  local slot = self._slots[slotNo]
  if slot == nil then
    return
  end
  local whereType = CppEnums.ItemWhereType.eInventory
  local itemWrapper = getInventoryItemByType(whereType, invenSlotNo)
  if itemWrapper == nil then
    return
  end
  slot._invenSlotNo = invenSlotNo
  slot:setItem(itemWrapper, invenSlotNo)
end
function PaGlobal_CombineBag:clearSlotItem(slotNo)
  local slot = self._slots[slotNo]
  if slot == nil then
    return
  end
  slot:clearItem(true)
  slot.icon:SetEnable(true)
  slot.icon:SetIgnore(false)
  slot.isEmpty = true
  slot.icon:EraseAllEffect()
  slot.icon:SetShow(true)
  slot._invenSlotNo = nil
end
function PaGlobal_CombineBag:swapSlotItemPosition(from, to)
  if Panel_Window_CombineBag == nil then
    return
  end
  if from == to then
    return
  end
  if self._slots[to]._invenSlotNo == nil then
    self:setSlotItem(self._slots[from]._invenSlotNo, to)
    self:clearSlotItem(from)
  else
    local tmpInvenSlotNo = self._slots[to]._invenSlotNo
    self:clearSlotItem(to)
    self:setSlotItem(self._slots[from]._invenSlotNo, to)
    self:clearSlotItem(from)
    self:setSlotItem(tmpInvenSlotNo, from)
  end
end
function PaGlobal_CombineBag:findPuzzle()
  if Panel_Window_CombineBag == nil then
    return
  end
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    if slot._invenSlotNo == nil then
      setInvenSlotListForPuzzle(ii, 0)
    else
      setInvenSlotListForPuzzle(ii, slot._invenSlotNo)
    end
  end
  self:hidePuzzleControl()
  local isFind = findPuzzleAndReadyMakeCombineBag()
  if isFind == false then
    return
  end
  local puzzleCount = getPuzzleCountCombineBag()
  local firstPuzzleIndex = -1
  for listIndex = 0, puzzleCount - 1 do
    local puzzleSlotCount = getSlotCountInPuzzle(listIndex)
    local removeListIndex = 0
    if firstPuzzleIndex ~= -1 then
      break
    end
    for each = 0, self._config.slotCount - 1 do
      if puzzleSlotCount <= removeListIndex then
        break
      end
      local slot = self._slots[each]
      local puzzleSlotNo = getPuzzleSlotAtWithIndex(listIndex, removeListIndex)
      if slot._invenSlotNo == puzzleSlotNo then
        slot.icon:AddEffect("UI_Item_MineCraft", true, 0, 0)
        if firstPuzzleIndex == -1 then
          firstPuzzleIndex = listIndex
          self._slotsEffect[each].puzzleControl:SetShow(true)
          self._slotsEffect[each].isFirstItem = true
        end
      end
      removeListIndex = removeListIndex + 1
    end
  end
end
function PaGlobal_CombineBag:isCanEnrollEnoughItem(invenSlotNo)
  local erolledItemCount = self:getCountEnrolledCount(invenSlotNo)
  local whereType = CppEnums.ItemWhereType.eInventory
  local itemWrapper = getInventoryItemByType(whereType, invenSlotNo)
  if itemWrapper == nil then
    return false
  end
  if erolledItemCount >= Int64toInt32(itemWrapper:get():getCount_s64()) then
    return false
  end
  return true
end
function PaGlobal_CombineBag:getCountEnrolledCount(invenSlotNo)
  local erolledItemCount = 0
  for ii = 0, self._config.slotCount - 1 do
    local slot = self._slots[ii]
    if slot ~= nil and slot._invenSlotNo == invenSlotNo then
      erolledItemCount = erolledItemCount + 1
    end
  end
  return erolledItemCount
end
function PaGlobal_CombineBag:hidePuzzleControl()
  for ii = 0, self._config.slotCount - 1 do
    if self._slots[ii] ~= nil then
      self._slots[ii].icon:EraseAllEffect()
      self._slotsEffect[ii].puzzleControl:SetShow(false)
      self._slotsEffect[ii].isFirstItem = false
    end
  end
  self._ui.stc_puzzleNotice:SetShow(false)
  self._ui.txt_puzzleNoticeText:SetShow(false)
end
function PaGlobal_CombineBag:clearAllSlots()
  self:hidePuzzleControl()
  for ii = 0, self._config.slotCount - 1 do
    self:clearSlotItem(ii)
  end
end
function PaGlobal_CombineBag:changePadSnapState(padSnapState)
  if Panel_Window_CombineBag == nil then
    return
  end
  if self._isConsole == false then
    self._ui.stc_keyGuide:SetShow(false)
    return
  end
  self._ui.stc_keyGuide:SetShow(true)
  local showKeyGuideList = Array.new()
  local hideKeyGuideList = Array.new()
  if padSnapState == nil or padSnapState == self._PAD_SNAP_STATE.Default then
    showKeyGuideList:push_back(self._ui.stc_keyGuideClose)
    hideKeyGuideList:push_back(self._ui.stc_keyGuideDelete)
    hideKeyGuideList:push_back(self._ui.stc_keyGuideDetail)
    hideKeyGuideList:push_back(self._ui.stc_keyGuideMove)
  elseif padSnapState == self._PAD_SNAP_STATE.OnItem then
    showKeyGuideList:push_back(self._ui.stc_keyGuideClose)
    showKeyGuideList:push_back(self._ui.stc_keyGuideDelete)
    if true == _ContentsGroup_RenewUI_Tooltip then
      showKeyGuideList:push_back(self._ui.stc_keyGuideDetail)
    else
      hideKeyGuideList:push_back(self._ui.stc_keyGuideDetail)
    end
    showKeyGuideList:push_back(self._ui.stc_keyGuideMove)
  elseif padSnapState == self._PAD_SNAP_STATE.OnPuzzleBtn then
    showKeyGuideList:push_back(self._ui.stc_keyGuideClose)
    hideKeyGuideList:push_back(self._ui.stc_keyGuideDelete)
    hideKeyGuideList:push_back(self._ui.stc_keyGuideDetail)
    hideKeyGuideList:push_back(self._ui.stc_keyGuideMove)
  else
    self._ui.stc_keyGuide:SetShow(false)
    return
  end
  for key, control in pairs(showKeyGuideList) do
    if control ~= nil then
      control:SetShow(true)
    end
  end
  for key, control in pairs(hideKeyGuideList) do
    if control ~= nil then
      control:SetShow(false)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(showKeyGuideList, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
