function PaGlobal_PalaceManagement_Node_Open(boardGroupKey)
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  PaGlobal_PalaceManagement_Node:prepareOpen(boardGroupKey)
end
function PaGlobal_PalaceManagement_Node_Close()
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  PaGlobal_PalaceManagement_Node:prepareClose()
end
function PaGlobal_PalaceManagement_UpdateBoards()
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  PaGlobal_PalaceManagement_Node:updateBoards()
end
function PaGlobal_PalaceManagement_UpdateFreeRerollCount()
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  PaGlobal_PalaceManagement_Node:updateFreeRerollCount(true)
end
function PaGlobal_PalaceManagement_Node_UpdatePerframeWorker(deltaTime)
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  if Panel_Window_PalaceManagement_Node:GetShow() == false then
    return
  end
  local self = PaGlobal_PalaceManagement_Node
  self:updateWorkerUI()
end
function PaGlobal_PalaceManagement_Node_WorkingChange(boardGroupKeyRaw, workerNoRaw)
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  if Panel_Window_PalaceManagement_Node:GetShow() == false then
    return
  end
  local self = PaGlobal_PalaceManagement_Node
  if boardGroupKeyRaw == self._boardGroupKey then
    self:updateBoardGroupTitle()
    self:updateWorkerUpdatePerFrameSet()
    self:updateWorkerUI()
  end
end
function PaGlobal_PalaceManagement_Node_ShowToolTip(boardIndex, itemIndex, key, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == PaGlobal_PalaceManagement_Node or nil == itemWrapper then
    return
  end
  local self = PaGlobal_PalaceManagement_Node
  local control = self._board[boardIndex]._ItemSlot[itemIndex].icon
  if control == nil then
    return
  end
  if self._board[boardIndex]._isOpen then
    self:controlNodeButtonMouseOnOut(boardIndex, isShow)
  end
  if false == PaGlobal_PalaceManagement_Node._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, control, true, false)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  else
    if true == isShow then
      self._consoleItemTooltipKey = key
    else
      self._consoleItemTooltipKey = 0
    end
    self:updateShowConsoleItemTooltip()
  end
end
function PaGlobal_PalaceManagement_OpenWorkerList()
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  local self = PaGlobal_PalaceManagement_Node
  local isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(self._boardGroupKey)
  if isWorking == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerIsWorking"))
    return
  end
  PaGlobal_PalaceManagement_Worker_Open(self._boardGroupKey)
end
function PaGlobal_PalaceManagement_Node_WareHouseUpdate(townWaypointKey)
  if PaGlobal_PalaceManagement_Node == nil then
    return
  end
  local regionWaypointKey = Toclient_getPalaceManageWorkerRegionWaypointKey()
  if regionWaypointKey ~= townWaypointKey then
    return
  end
  local isShow = Panel_Window_PalaceManagement_Node:GetShow()
  if isShow == false then
    return
  end
  local self = PaGlobal_PalaceManagement_Node
  self:updateMaterialItem()
end
function HandleEventLOnOut_PalaceManagement_ShowWorkerName(isShow)
  local self = PaGlobal_PalaceManagement_Node
  if self == nil or isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui.txt_WorkerName, "", self._ui.txt_WorkerName:GetText())
end
function HandleEventLOnOut_PalaceManagement_ShowWorkState(isShow)
  local self = PaGlobal_PalaceManagement_Node
  if self == nil or isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui.st_WorkerText, "", self._ui.st_WorkerText:GetText())
end
