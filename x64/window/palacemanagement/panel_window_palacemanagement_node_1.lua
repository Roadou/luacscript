function PaGlobal_PalaceManagement_Node:initialize()
  if PaGlobal_PalaceManagement_Node._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleArea = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_TitleArea")
  self._ui.btn_Close = UI.getChildControl(titleArea, "Button_Close")
  self._ui.st_Title = UI.getChildControl(titleArea, "StaticText_Title")
  self._ui.st_NodeBg = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_NodeBg")
  self._ui.st_NodeName = UI.getChildControl(Panel_Window_PalaceManagement_Node, "StaticText_NodeName")
  self._ui.btn_Node = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Button_Node")
  self._ui.st_nodeBG = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_NodeBg")
  self._ui.st_Working = UI.getChildControl(self._ui.btn_Node, "Static_Working")
  self._ui.st_NodeDesc = UI.getChildControl(Panel_Window_PalaceManagement_Node, "StaticText_NodeDesc")
  local workerBg = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_WorkerBg")
  local workerBg2 = UI.getChildControl(workerBg, "Static_WorkerImageBg")
  self._ui.st_WorkerTitle = UI.getChildControl(workerBg, "StaticText_Title")
  self._ui.st_WorkerEmpty = UI.getChildControl(workerBg2, "Static_WorkerEmpty")
  self._ui.st_WorkerImg = UI.getChildControl(workerBg2, "Static_WorkerImage")
  self._ui.txt_WorkerName = UI.getChildControl(workerBg2, "StaticText_WorkerName")
  self._ui.st_WorkerText = UI.getChildControl(workerBg2, "StaticText_WorkerState")
  self._ui.st_ActProgressBG = UI.getChildControl(workerBg2, "Static_ActBg")
  self._ui.st_ActProgress = UI.getChildControl(workerBg2, "Progress2_Act")
  self._ui.txt_ActProgressText = UI.getChildControl(workerBg2, "StaticText_ActPoint")
  self._ui.st_ProgressBG = UI.getChildControl(workerBg, "Static_ProgressBg")
  self._ui.st_Progress = UI.getChildControl(workerBg, "Progress2_Working")
  self._ui.btn_WorkStop = UI.getChildControl(workerBg, "Button_Cancel")
  self._ui.txt_ProgressText = UI.getChildControl(workerBg, "StaticText_WorkingStatus")
  self._ui.txt_ProgressText:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._ui.st_MainBg = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_MainBg")
  self._ui.st_ItemListTitle = UI.getChildControl(self._ui.st_MainBg, "StaticText_Title")
  self._ui.st_LeftCount = UI.getChildControl(self._ui.st_MainBg, "StaticText_LeftCount")
  self._ui.btn_ChangeBoard = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Button_Change")
  self._ui.btn_RestartWork = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Button_Do")
  self._ui.btn_Warehouse = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Button_Warehouse")
  self._ui.st_MouseRBtn = UI.getChildControl(self._ui.st_MainBg, "Static_MouseRBtn")
  self._ui.txt_RClick = UI.getChildControl(self._ui.st_MainBg, "StaticText_RClick")
  self._ui.btn_Navi = UI.getChildControl(self._ui.btn_Node, "Button_Navi")
  self._ui.st_NpcName = UI.getChildControl(self._ui.btn_Navi, "StaticText_Npc")
  self._ui.st_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_TITLE"))
  self._ui.st_WorkerTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_WORKERTITLE"))
  self._ui.st_ItemListTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_ITEMTITLE"))
  self._ui.btn_ChangeBoard:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_CHANGEBUTTON"))
  self._ui.btn_RestartWork:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PLANT_WORKMANAGER_BTN_DOWORK"))
  self._ui.st_ConsoleKeyGuide = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_KeyGuide_ConsoleUI_Import")
  self._ui.txt_ConsoleUI_RT = UI.getChildControl(self._ui.st_ConsoleKeyGuide, "StaticText_RT_ConsoleUI")
  for ii = 0, self._maxBoardCount - 1 do
    local boardData = {
      _btn_BoardSpace = nil,
      _st_BoardName = nil,
      _ItemCount = self._maxItemCount,
      _currentSelectItem = 0,
      _boardIndex = 0,
      _st_SelectedSlot = nil,
      _st_ItemSlotBG = {},
      _ItemSlot = {},
      _ItemProbability = {},
      _ItemGradeColor = {},
      _btn_Reload = nil,
      _isOpen = false,
      _st_LockBg = nil,
      _st_LockIcon = nil,
      _st_MaterialSelectSlot = nil
    }
    boardData._boardIndex = ii
    local boardButtonString = "RadioButton_Space_Template_" .. tostring(ii)
    boardData._btn_BoardSpace = UI.getChildControl(self._ui.st_MainBg, boardButtonString)
    boardData._st_BoardName = UI.getChildControl(boardData._btn_BoardSpace, "StaticText_Name")
    boardData._st_SelectedSlot = UI.getChildControl(boardData._btn_BoardSpace, "Static_SelectedSlot")
    boardData._btn_Reload = UI.getChildControl(boardData._btn_BoardSpace, "Button_Reload")
    boardData._btn_Reload:setPadSnapType(__ePadSnapType_Target)
    boardData._btn_Reload:setPadSnapIndex(0)
    boardData._st_LockBg = UI.getChildControl(boardData._btn_BoardSpace, "Static_LockBg")
    boardData._st_LockIcon = UI.getChildControl(boardData._st_LockBg, "Static_Icon")
    boardData._st_MaterialSelectSlot = UI.getChildControl(boardData._btn_BoardSpace, "Static_RClickSlot")
    for jj = 0, self._maxItemCount - 1 do
      boardData._st_ItemSlotBG[jj] = UI.getChildControl(boardData._btn_BoardSpace, "Static_SlotBg_" .. tostring(jj + 1))
      local itemSlot = {}
      SlotItem.new(itemSlot, "BoardItem" .. jj, 0, boardData._st_ItemSlotBG[jj], self._slotConfig)
      itemSlot:createChild()
      itemSlot.icon:SetHorizonCenter()
      itemSlot.icon:SetVerticalMiddle()
      itemSlot.icon:ComputePos()
      if self._isConsole == true then
        itemSlot.icon:setPadSnapType(__ePadSnapType_Target)
        itemSlot.icon:setPadSnapIndex(1)
      end
      boardData._ItemSlot[jj] = itemSlot
    end
    self._board[ii] = boardData
  end
  self._ui.st_MaterialBg = UI.getChildControl(Panel_Window_PalaceManagement_Node, "Static_MaterialItemBg")
  self._ui.txt_MaterialTitle = UI.getChildControl(self._ui.st_MaterialBg, "StaticText_MaterialTitle")
  self._ui.txt_Count = UI.getChildControl(self._ui.st_MaterialBg, "StaticText_Count")
  for ii = 0, self._maxMaterialItemCount - 1 do
    self._ui.st_MaterialItemSlot[ii] = UI.getChildControl(self._ui.st_MaterialBg, "Static_MaterialSlotBg_" .. ii)
    local itemSlot = {}
    SlotItem.new(itemSlot, "MaterialSlotItem_" .. ii, 0, self._ui.st_MaterialItemSlot[ii], self._slotConfig)
    itemSlot:createChild()
    itemSlot.icon:SetHorizonCenter()
    itemSlot.icon:SetVerticalMiddle()
    self._materialSlot[ii] = itemSlot
    self._ui.txt_MaterialName[ii] = UI.getChildControl(self._ui.st_MaterialItemSlot[ii], "StaticText_ItemName")
    self._ui.txt_MaterialCount[ii] = UI.getChildControl(self._ui.st_MaterialItemSlot[ii], "StaticText_HaveCount")
  end
  Panel_Window_PalaceManagement_Node:ignorePadSnapMoveToOtherPanel()
  self._ui.st_ConsoleKeyGuide:SetShow(self._isConsole)
  if self._isConsole == true then
    self._ui.btn_ChangeBoard:SetShow(false)
    self._ui.btn_RestartWork:SetShow(false)
    self._ui.btn_Warehouse:SetShow(false)
  else
    self._ui.btn_ChangeBoard:SetShow(true)
    self._ui.btn_RestartWork:SetShow(true)
    self._ui.btn_Warehouse:SetShow(true)
  end
  PaGlobal_PalaceManagement_Node:registEventHandler()
  PaGlobal_PalaceManagement_Node:validate()
  PaGlobal_PalaceManagement_Node._initialize = true
end
function PaGlobal_PalaceManagement_Node:registEventHandler()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node_Close()")
  self._ui.st_WorkerEmpty:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_OpenWorkerList()")
  self._ui.st_WorkerImg:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_OpenWorkerList()")
  self._ui.btn_ChangeBoard:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:requestChangeBoard()")
  self._ui.btn_RestartWork:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:restartWorking()")
  self._ui.btn_Warehouse:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:openWarehouse()")
  self._ui.btn_Navi:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:setNaviToNpc()")
  self._ui.btn_WorkStop:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:stopWorking()")
  for ii = 0, self._maxBoardCount - 1 do
    self._board[ii]._btn_BoardSpace:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:updateClickedBoard(" .. ii .. ")")
    self._board[ii]._st_BoardName:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:updateClickedBoard(" .. ii .. ")")
    self._board[ii]._st_BoardName:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Node:controlNodeButtonMouseOnOut(" .. ii .. ", true)")
    self._board[ii]._st_BoardName:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Node:controlNodeButtonMouseOnOut(" .. ii .. ", false)")
    self._board[ii]._btn_Reload:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:requestReroll()")
    self._board[ii]._btn_Reload:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Node:showRerollProbability(" .. ii .. ", true" .. ")")
    self._board[ii]._btn_Reload:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Node:showRerollProbability(" .. ii .. ", false" .. ")")
    self._board[ii]._st_LockIcon:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Node:showLockIconTooltip(" .. ii .. ", true" .. ")")
    self._board[ii]._st_LockIcon:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Node:showLockIconTooltip(" .. ii .. ", false" .. ")")
  end
  registerEvent("FromClient_PalaceManagementUpdateBoards", "PaGlobal_PalaceManagement_UpdateBoards")
  registerEvent("FromClient_PalaceManagementUpdateFreeRerollCount", "PaGlobal_PalaceManagement_UpdateFreeRerollCount")
  registerEvent("WorldMap_WorkerDataUpdateByPalaceManage", "PaGlobal_PalaceManagement_Node_WorkingChange")
  registerEvent("EventWarehouseUpdate", "PaGlobal_PalaceManagement_Node_WareHouseUpdate")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_PalaceManagement_Node:requestChangeBoard()")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_PalaceManagement_Node:openWarehouse()")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobal_PalaceManagement_Node:controlConsoleWorkerInfo()")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobal_PalaceManagement_Node:changeIsShowConsoleItemTooltip()")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_PalaceManagement_Node:requestReroll()")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobal_PalaceManagement_Node:setNaviToNpc()")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_PalaceManagement_Node:updateConsoleSelectBoard(false)")
  Panel_Window_PalaceManagement_Node:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_PalaceManagement_Node:updateConsoleSelectBoard(true)")
end
function PaGlobal_PalaceManagement_Node:prepareOpen(boardGroupKey)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  self._boardGroupKey = boardGroupKey
  self._characterKey = ToClient_PalaceManageGetNpcCharacterKey(boardGroupKey)
  self._dialogIndex = ToClient_PalaceManageGetNpcDialogIndex(boardGroupKey)
  self._boardGroupType = ToClient_PalaceManagegetBoadGroupTypeRaw(boardGroupKey)
  local boardGroupTypeName = {
    [__ePalaceManageType_Production] = "LUA_WORLDMAP_NODETYPE_5",
    [__ePalaceManageType_Manufacture] = "PANEL_TOOLTIP_PROCESSING"
  }
  self._boardGroupName = ToClient_GetPalaceManageBoardGroupName(boardGroupKey) .. " : " .. PAGetString(Defines.StringSheet_GAME, boardGroupTypeName[self._boardGroupType])
  local nodeBgTextureID = ToClient_PalaceManageGetBoardGroupTextureID(boardGroupKey)
  self._ui.st_NodeBg:ChangeTextureInfoTextureIDAsync(nodeBgTextureID)
  self._ui.st_NodeBg:setRenderTexture(self._ui.st_NodeBg:getBaseTexture())
  local nodeDesc = ToClient_PalaceManageGetBoardGroupDesc(boardGroupKey)
  self._ui.st_NodeDesc:SetText(nodeDesc)
  self._isOnProbabilityToolTip = false
  if self._boardGroupType == __ePalaceManageType_Manufacture then
    self._ui.st_MouseRBtn:SetShow(true)
    self._ui.txt_RClick:SetShow(true)
    self._ui.txt_ConsoleUI_RT:SetShow(true)
  else
    self._ui.st_MouseRBtn:SetShow(false)
    self._ui.txt_RClick:SetShow(false)
    self._ui.txt_ConsoleUI_RT:SetShow(false)
  end
  self:updateWorkerUpdatePerFrameSet(true)
  self:updateWorkerUI()
  self:updateBoardGroupTitle()
  self:setBoardItems()
  self:updateBoardList(self._boardGroupKey)
  self._consoleItemTooltipKey = 0
  self:open()
end
function PaGlobal_PalaceManagement_Node:open()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if Panel_Window_PalaceManagement_Node:GetShow() == true then
    return
  end
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_PalaceManagement_Node, true)
  else
    Panel_Window_PalaceManagement_Node:SetShow(true)
  end
end
function PaGlobal_PalaceManagement_Node:updateBoardGroupTitle()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  self._ui.st_NodeName:SetText(self._boardGroupName)
  local isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(self._boardGroupKey)
  if self._boardGroupType == __ePalaceManageType_Production then
    self._ui.st_LeftCount:SetShow(true)
    self:updateFreeRerollCount(false)
  else
    self._ui.st_LeftCount:SetShow(false)
  end
  local npcData = getNpcInfoByCharacterKeyRaw(self._characterKey, self._dialogIndex)
  local npcName = npcData:getName()
  self._ui.st_NpcName:SetText(npcName)
  if isWorking == true then
    self._ui.st_Working:SetShow(true)
    self._ui.st_Working:SetVertexAniRun("Ani_Rotate_New", true)
  else
    self._ui.st_Working:SetShow(false)
    self._ui.st_Working:ResetVertexAni()
  end
end
function PaGlobal_PalaceManagement_Node:updateSelectItemSlot(boardIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local currentSelectItem = ToClient_PalaceManageGetBoardSelectItemIndex(self._boardGroupKey, boardIndex)
  self._board[boardIndex]._currentSelectItem = currentSelectItem
  self._board[boardIndex]._st_SelectedSlot:SetShow(true)
  self._board[boardIndex]._st_SelectedSlot:SetPosX(self._board[self._currentSelectBoardIndex]._st_ItemSlotBG[currentSelectItem]:GetPosX())
  self._board[boardIndex]._st_SelectedSlot:SetPosY(self._board[self._currentSelectBoardIndex]._st_ItemSlotBG[currentSelectItem]:GetPosY())
  if self._boardGroupType == __ePalaceManageType_Manufacture then
    self:setMaterialsItem(boardIndex, currentSelectItem)
  end
end
function PaGlobal_PalaceManagement_Node:setOpenBoardData(currentSelectBoardKey, boardKey, boardIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  self._board[boardIndex]._st_LockBg:SetShow(false)
  self._board[boardIndex]._btn_BoardSpace:SetIgnore(false)
  if boardKey == currentSelectBoardKey then
    self._currentSelectBoardIndex = boardIndex
    self._board[self._currentSelectBoardIndex]._btn_BoardSpace:SetCheck(true)
    self:updateSelectItemSlot(boardIndex)
    if self._boardGroupType == __ePalaceManageType_Production then
      self._board[self._currentSelectBoardIndex]._btn_Reload:SetShow(true)
    else
      self._board[self._currentSelectBoardIndex]._btn_Reload:SetShow(false)
    end
  else
    self._board[boardIndex]._btn_BoardSpace:SetCheck(false)
    self._board[boardIndex]._btn_Reload:SetShow(false)
    if self._boardGroupType == __ePalaceManageType_Production then
      self:updateSelectItemSlot(boardIndex)
    else
      self._board[boardIndex]._st_SelectedSlot:SetShow(false)
    end
  end
end
function PaGlobal_PalaceManagement_Node:setCloseBoardData(currentSelectBoardKey, boardKey, boardIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  self._board[boardIndex]._st_LockBg:SetShow(true)
  self._board[boardIndex]._btn_BoardSpace:SetIgnore(true)
  self._board[boardIndex]._btn_BoardSpace:SetCheck(false)
  self._board[boardIndex]._st_SelectedSlot:SetShow(false)
  self._board[boardIndex]._btn_Reload:SetShow(false)
end
function PaGlobal_PalaceManagement_Node:updateBoardList(boardGroupKey)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local currentSelectBoardKey = ToClient_PalaceManageGetSelectedBoardKeyRaw(boardGroupKey)
  self._tooltipDesc = ""
  for ii = 0, self._maxBoardCount - 1 do
    local boardKey = ToClient_PalaceManagegetBoadKeyRaw(boardGroupKey, ii)
    if boardKey ~= 0 then
      self._board[ii]._btn_BoardSpace:SetShow(true)
      local boardName = ToClient_PalaceManageGetBoardName(boardGroupKey, ii)
      self._board[ii]._st_BoardName:SetText(boardName)
      self._board[ii]._isOpen = ToClient_PalaceManageGetBoardIsOpen(boardGroupKey, ii)
      if self._board[ii]._isOpen == true then
        self:setOpenBoardData(currentSelectBoardKey, boardKey, ii)
      else
        self:setCloseBoardData(currentSelectBoardKey, boardKey, ii)
      end
      if boardKey == currentSelectBoardKey then
        self:updateBoardItemProbabilities(ii)
      end
      local isProduct = __ePalaceManageType_Production == ToClient_PalaceManagegetBoadGroupTypeRaw(boardGroupKey)
      if true == isProduct then
        self._ui.btn_Node:SetColor(Defines.Color.C_FFC1FFC2)
        self._ui.st_MaterialBg:SetShow(false)
      else
        self._ui.btn_Node:SetColor(Defines.Color.C_FFFFEEA0)
        self._ui.st_MaterialBg:SetShow(true)
      end
    else
      self._board[ii]._btn_BoardSpace:SetShow(false)
    end
  end
  if "" ~= self._tooltipDesc then
    self._tooltipDesc = "<PAColor0xfff5ba3a>" .. self._ui.st_NpcName:GetText() .. "<PAOldColor>\236\151\144\234\178\140 <PAColor0xfff5ba3a>[\234\177\176\236\160\144 \237\153\149\236\158\165 \236\157\152\235\162\176]<PAOldColor>\235\165\188 \236\136\152\236\163\188\235\176\155\236\149\132 \236\153\132\235\163\140 \236\139\156 <PAColor0xfff5ba3a>\236\131\136\235\161\156\236\154\180 \234\179\181\235\176\169\236\157\180 \234\176\156\235\176\169<PAOldColor>\235\144\169\235\139\136\235\139\164.\n<PAColor0xfff5ba3a>[\234\177\176\236\160\144 \237\153\149\236\158\165 \236\157\152\235\162\176]<PAOldColor>\235\138\148 \236\157\152\235\162\176 \237\131\128\236\158\133 '\236\187\168\237\133\144\236\184\160'\234\176\128 \236\151\180\235\160\164 \236\158\136\236\150\180\236\149\188 \236\136\152\236\163\188\235\176\155\236\157\132 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164."
  end
end
function PaGlobal_PalaceManagement_Node:updateClickedBoard(boardIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._currentSelectBoardIndex == boardIndex then
    return
  end
  if self._board[boardIndex]._isOpen == false then
    return
  end
  self._currentSelectBoardIndex = boardIndex
end
function PaGlobal_PalaceManagement_Node:updateConsoleSelectBoard(moveSide)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local boardIndex = self._currentSelectBoardIndex
  self._board[boardIndex]._btn_BoardSpace:SetCheck(false)
  local addIndex = 0
  if moveSide == true then
    addIndex = 1
  else
    addIndex = -1
  end
  for Index = 0, self._maxBoardCount - 1 do
    boardIndex = boardIndex + addIndex
    if boardIndex >= self._maxBoardCount then
      boardIndex = 0
    end
    if boardIndex < 0 then
      boardIndex = self._maxBoardCount - 1
    end
    if self._board[boardIndex]._btn_BoardSpace:GetShow() == true and self._board[boardIndex]._isOpen == true then
      break
    end
  end
  self._board[boardIndex]._btn_BoardSpace:SetCheck(true)
  if self._currentSelectBoardIndex == boardIndex then
    return
  end
  self._currentSelectBoardIndex = boardIndex
  self:updateClickedBoard(self._currentSelectBoardIndex)
  ToClient_padSnapChangeToTarget(self._board[self._currentSelectBoardIndex]._st_BoardName)
end
function PaGlobal_PalaceManagement_Node:requestChangeBoard()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  ToClient_PalaceManageChangeBoard(self._boardGroupKey, self._currentSelectBoardIndex)
end
function PaGlobal_PalaceManagement_Node:updateBoards()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if Panel_Window_PalaceManagement_Node:GetShow() == false then
    return
  end
  self:updateBoardList(self._boardGroupKey)
  local messageString = PAGetString(Defines.StringSheet_GAME, "LUA_PALACEMANAGEMENT_UPDATE_BOARDINFO")
  Proc_ShowMessage_Ack(messageString)
end
function PaGlobal_PalaceManagement_Node:updateMaterialItem()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local itemExchangeSourceSSW = ToClient_PalaceManageSelectItemExchangeSource(self._boardGroupKey, self._showMaterialsBoardKey, self._showMaterialsItemIndex)
  local resourceItemCount = 0
  local possibleCount = 99999
  if itemExchangeSourceSSW ~= nil then
    resourceItemCount = itemExchangeSourceSSW:getResourceItemStaticStatusWrapperCount()
    for index = 0, self._maxMaterialItemCount - 1 do
      self._materialSlot[index]:clearItem()
      local count = 0
      local resourceItemNeedCount = itemExchangeSourceSSW:getResourceItemNeedCount(index)
      local resourceItemSSW = itemExchangeSourceSSW:getResourceItemStaticStatusWrapper(index)
      if nil ~= resourceItemSSW then
        local haveCount = Int64toInt32(warehouse_getItemCount(self._warehouseRegionKey, resourceItemSSW:get()._key))
        self._materialSlot[index]:setItemByStaticStatus(resourceItemSSW, Defines.s64_const.s64_1)
        self._materialSlot[index].icon:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Node:showToolTip(" .. index .. "," .. resourceItemSSW:getItemKey() .. ",true)")
        self._materialSlot[index].icon:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Node:showToolTip(" .. index .. "," .. resourceItemSSW:getItemKey() .. ",false)")
        local text = ""
        if resourceItemNeedCount <= haveCount then
          text = "<PAColor0xfff5ba3a>" .. haveCount .. "<PAOldColor>"
        else
          text = "<PAColor0xFFD20000>" .. haveCount .. "<PAOldColor>"
        end
        count = math.floor(haveCount / resourceItemNeedCount)
        possibleCount = math.min(possibleCount, count)
        self._materialSlot[index].count:SetText(resourceItemNeedCount)
        local itemSSW = getItemEnchantStaticStatus(resourceItemSSW:get()._key)
        PAGlobalFunc_SetItemTextColor(self._ui.txt_MaterialName[index], itemSSW)
        self._ui.txt_MaterialName[index]:SetText(itemSSW:getName())
        self._ui.txt_MaterialCount[index]:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_DIALOG_EXCHANGE_HAVECOUNT", "count", text))
        self._ui.st_MaterialItemSlot[index]:SetShow(true)
        self._ui.st_MaterialBg:SetSize(self._ui.st_MaterialBg:GetSizeX(), self._ui.st_MaterialItemSlot[index]:GetPosY() + self._ui.st_MaterialItemSlot[index]:GetSizeY() + 14)
        self._ui.st_MaterialBg:ComputePos()
      else
        self._ui.st_MaterialItemSlot[index]:SetShow(false)
      end
    end
    if 0 == possibleCount then
      self._ui.txt_Count:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_CANT"))
    else
      self._ui.txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_POSSIBLECOUNT", "possibleCount", possibleCount))
    end
  end
  local itemSSW = ToClient_PalaceManageGetItem(ToClient_PalaceManagegetBoadGroupTypeRaw(self._boardGroupKey), self._showMaterialsBoardKey, self._showMaterialsItemIndex)
  if nil ~= itemSSW then
    PAGlobalFunc_SetItemTextColor(self._ui.txt_MaterialTitle, itemSSW)
    self._ui.txt_MaterialTitle:SetText("[" .. itemSSW:getName() .. "]")
  end
end
function PaGlobal_PalaceManagement_Node:showToolTip(controlIndex, itemKey, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemWrapper then
    return
  end
  local control = self._materialSlot[controlIndex].icon
  if control == nil then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_Show(itemWrapper, control, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_PalaceManagement_Node:updateFreeRerollCount(checkNodeOpen)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if checkNodeOpen == true and Panel_Window_PalaceManagement_Node:GetShow() == false then
    return
  end
  if self._boardGroupType ~= __ePalaceManageType_Production then
    return
  end
  self._freeRerollCount = ToClient_GetPalaceManageFreeRerollCount()
  if self._freeRerollCount == 0 then
    local needPearlCount = ToClient_PalaceManageGetNeedPearlCountForReroll()
    local usePearlText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PALACEMANAGEMENT_REROLL_CASH", "pearl", tostring(needPearlCount))
    self._ui.st_LeftCount:SetText(usePearlText)
  else
    local rerollCountText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PALACEMANAGEMENT_REROLL_LEFTCOUNT", "leftCount", tostring(self._freeRerollCount))
    self._ui.st_LeftCount:SetText(rerollCountText)
  end
end
function PaGlobal_PalaceManagement_Node:requestReroll()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._isConsole == true and isPadPressed(__eJoyPadInputType_LeftTrigger) == true then
    return
  end
  local freeRerollCount = ToClient_GetPalaceManageFreeRerollCount()
  local usePearl = freeRerollCount == 0
  if usePearl == true then
    local function requestUsePearlReroll()
      ToClient_PalaceManageReroll(self._boardGroupKey, true)
    end
    local needPearlCount = ToClient_PalaceManageGetNeedPearlCountForReroll()
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_MSGBOX_REROLL", "pearl", tostring(needPearlCount)),
      functionYes = requestUsePearlReroll,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    ToClient_PalaceManageReroll(self._boardGroupKey, usePearl)
  end
end
function PaGlobal_PalaceManagement_Node:requestChangeSelectItem(boardIndex, itemIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  PaGlobal_PalaceManagement_Node:updateClickedBoard(boardIndex)
  if self._boardGroupType ~= __ePalaceManageType_Manufacture then
    local messageString = PAGetString(Defines.StringSheet_GAME, "LUA_PALACEMANAGEMENT_ONLY_MANUFACTURE")
    Proc_ShowMessage_Ack(messageString)
    return
  end
  local clickedBoardKey = ToClient_PalaceManagegetBoadKeyRaw(self._boardGroupKey, self._currentSelectBoardIndex)
  local currentSelectBoardKey = ToClient_PalaceManageGetSelectedBoardKeyRaw(self._boardGroupKey)
  if clickedBoardKey ~= currentSelectBoardKey then
    return
  end
  ToClient_PalaceManageRequestChangeSelectItem(self._boardGroupKey, boardIndex, itemIndex)
end
function PaGlobal_PalaceManagement_Node:controlNodeButtonMouseOnOut(boardIndex, mouseOn)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._board[boardIndex]._btn_BoardSpace:IsChecked() == true then
    return
  end
  local textureInfo
  if mouseOn == true then
    textureInfo = self._board[boardIndex]._btn_BoardSpace:getOnTexture()
  else
    textureInfo = self._board[boardIndex]._btn_BoardSpace:getBaseTexture()
  end
  self._board[boardIndex]._btn_BoardSpace:setRenderTexture(textureInfo)
end
function PaGlobal_PalaceManagement_Node:updateBoardItemProbabilities(boardIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._boardGroupType ~= __ePalaceManageType_Production then
    return
  end
  local boardKeyRaw = ToClient_PalaceManagegetBoadKeyRaw(self._boardGroupKey, boardIndex)
  local itemCount = ToClient_PalaceManageGetItemCount(self._boardGroupType, boardKeyRaw)
  local productionBoard = self._board[boardIndex]
  for ii = 0, itemCount - 1 do
    local probability = ToClient_PalaceManageGetProbability(self._boardGroupKey, boardIndex, ii)
    self._board[boardIndex]._ItemProbability[ii] = math.floor(probability * 10000 + 0.5) / 10000
  end
  if self._isOnProbabilityToolTip == true then
    self:showRerollProbability(boardIndex, true)
  end
end
function PaGlobal_PalaceManagement_Node:updateMaterialSelectSlot()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._boardGroupType ~= __ePalaceManageType_Manufacture then
    return
  end
  for boardIndex = 0, self._maxBoardCount - 1 do
    self._board[boardIndex]._st_MaterialSelectSlot:SetShow(false)
    local boardKey = ToClient_PalaceManagegetBoadKeyRaw(self._boardGroupKey, boardIndex)
    if boardKey == self._showMaterialsBoardKey then
      local currentBoardKey = ToClient_PalaceManageGetSelectedBoardKeyRaw(self._boardGroupKey)
      local currentItemIndex = ToClient_PalaceManageGetSelectedBoardItemIndex(self._boardGroupKey)
      if self._showMaterialsBoardKey ~= currentBoardKey or self._showMaterialsItemIndex ~= currentItemIndex then
        self._board[boardIndex]._st_MaterialSelectSlot:SetShow(true)
        self._board[boardIndex]._st_MaterialSelectSlot:SetPosX(self._board[boardIndex]._st_ItemSlotBG[self._showMaterialsItemIndex]:GetPosX())
        self._board[boardIndex]._st_MaterialSelectSlot:SetPosY(self._board[boardIndex]._st_ItemSlotBG[self._showMaterialsItemIndex]:GetPosY())
      end
    end
  end
end
function PaGlobal_PalaceManagement_Node:setMaterialsItem(boardIndex, itemIndex)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._boardGroupType ~= __ePalaceManageType_Manufacture then
    return
  end
  if self._board[boardIndex]._isOpen == false then
    return
  end
  self._showMaterialsBoardKey = ToClient_PalaceManagegetBoadKeyRaw(self._boardGroupKey, boardIndex)
  self._showMaterialsItemIndex = itemIndex
  self:updateMaterialSelectSlot()
  self:updateMaterialItem()
end
function PaGlobal_PalaceManagement_Node:setBoardItems()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local boardGroupTypeRaw = ToClient_PalaceManagegetBoadGroupTypeRaw(self._boardGroupKey)
  local currentBoardKey = ToClient_PalaceManageGetSelectedBoardKeyRaw(self._boardGroupKey)
  local currentItemIndex = ToClient_PalaceManageGetSelectedBoardItemIndex(self._boardGroupKey)
  for ii = 0, self._maxBoardCount - 1 do
    local boardKeyRaw = ToClient_PalaceManagegetBoadKeyRaw(self._boardGroupKey, ii)
    local itemCount = ToClient_PalaceManageGetItemCount(boardGroupTypeRaw, boardKeyRaw)
    self._board[ii]._st_MaterialSelectSlot:SetShow(false)
    for jj = 0, self._maxItemCount - 1 do
      self._board[ii]._ItemSlot[jj]:clearItem()
      self._board[ii]._st_ItemSlotBG[jj]:SetIgnore(false)
      self._board[ii]._ItemSlot[jj].icon:SetIgnore(false)
      self._board[ii]._ItemProbability[jj] = -1
      if jj < itemCount then
        local itemSSW = ToClient_PalaceManageGetItem(boardGroupTypeRaw, boardKeyRaw, jj)
        self._board[ii]._ItemSlot[jj]:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
        self._board[ii]._ItemSlot[jj].icon:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Node_ShowToolTip(" .. ii .. "," .. jj .. "," .. itemSSW:getItemKey() .. ",true)")
        self._board[ii]._ItemSlot[jj].icon:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Node_ShowToolTip(" .. ii .. "," .. jj .. "," .. itemSSW:getItemKey() .. ",false)")
        self._board[ii]._ItemSlot[jj].icon:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:requestChangeSelectItem(" .. ii .. "," .. jj .. ")")
        self._board[ii]._st_ItemSlotBG[jj]:SetShow(true)
        self._board[ii]._st_ItemSlotBG[jj]:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Node:controlNodeButtonMouseOnOut(" .. ii .. ",true)")
        self._board[ii]._st_ItemSlotBG[jj]:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Node:controlNodeButtonMouseOnOut(" .. ii .. ",false)")
        if boardGroupTypeRaw == __ePalaceManageType_Manufacture then
          self._board[ii]._ItemSlot[jj].icon:addInputEvent("Mouse_RUp", "PaGlobal_PalaceManagement_Node:setMaterialsItem(" .. ii .. "," .. jj .. ")")
          self._board[ii]._ItemSlot[jj].icon:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobal_PalaceManagement_Node:setMaterialsItem(" .. ii .. "," .. jj .. ")")
          if boardKeyRaw == currentBoardKey and jj == currentItemIndex then
            self:setMaterialsItem(ii, jj)
          end
        end
      else
        self._board[ii]._st_ItemSlotBG[jj]:SetShow(false)
      end
      if self._board[ii]._isOpen == true then
        self._board[ii]._btn_BoardSpace:SetIgnore(false)
        self._board[ii]._btn_BoardSpace:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node:updateClickedBoard(" .. ii .. ")")
      else
        self._board[ii]._btn_BoardSpace:SetIgnore(true)
        self._board[ii]._st_ItemSlotBG[jj]:SetIgnore(true)
      end
    end
  end
end
function PaGlobal_PalaceManagement_Node:setNaviToNpc()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local npcData = getNpcInfoByCharacterKeyRaw(self._characterKey, self._dialogIndex)
  local guideNpcPos
  if nil ~= npcData then
    local npcPosition = npcData:getPosition()
    guideNpcPos = float3(npcPosition.x, npcPosition.y, npcPosition.z)
  end
  ToClient_WorldMapNaviClear()
  ToClient_WorldMapNaviStart(guideNpcPos, NavigationGuideParam(), false, false)
end
function PaGlobal_PalaceManagement_Node:prepareClose()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  Panel_Window_PalaceManagement_Node:ClearUpdateLuaFunc()
  if true == self._isConsole then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_PalaceManagement_Node:close()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if Panel_Window_PalaceManagement_Node:GetShow() == false then
    return
  end
  PaGlobal_PalaceManagement_Worker_Close()
  PaGlobal_Warehouse_All_Close()
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:pop()
  else
    Panel_Window_PalaceManagement_Node:SetShow(false)
  end
end
function PaGlobal_PalaceManagement_Node:update()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
end
function PaGlobal_PalaceManagement_Node:updateWorkerUpdatePerFrameSet(isPrepareOpen)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  Panel_Window_PalaceManagement_Node:ClearUpdateLuaFunc()
  if isPrepareOpen == false and Panel_Window_PalaceManagement_Node:GetShow() == false then
    return
  end
  local isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(self._boardGroupKey)
  if isWorking == false then
    return
  end
  Panel_Window_PalaceManagement_Node:RegisterUpdateFunc("PaGlobal_PalaceManagement_Node_UpdatePerframeWorker")
end
function PaGlobal_PalaceManagement_Node:setTextAndAutoWrap(control, string, tooltipFunc)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if control == nil or tooltipFunc == nil or string == nil then
    return
  end
  control:SetTextMode(__eTextMode_Limit_AutoWrap)
  control:setLineCountByLimitAutoWrap(1)
  control:SetText(string)
  if control:IsLimitText() == true then
    control:SetIgnore(false)
    control:addInputEvent("Mouse_On", tooltipFunc .. "(true)")
    control:addInputEvent("Mouse_Out", tooltipFunc .. "(false)")
  else
    control:SetIgnore(true)
    control:addInputEvent("Mouse_On", "")
    control:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_PalaceManagement_Node:updateWorkerInfo(workerWrapperLua, prevWorker)
  if workerWrapperLua == nil then
    return
  end
  local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  local workerNameString = workerLv .. " " .. workerName
  local workerIcon = workerWrapperLua:getWorkerIcon()
  local workString = workerNameString
  self:setTextAndAutoWrap(self._ui.txt_WorkerName, workString, "HandleEventLOnOut_PalaceManagement_ShowWorkerName")
  self._ui.st_WorkerImg:ChangeTextureInfoNameAsync(workerIcon)
  self._ui.st_WorkerImg:SetShow(true)
  self._ui.st_ActProgressBG:SetShow(true)
  self._ui.st_ActProgress:SetShow(true)
  self._ui.txt_ActProgressText:SetShow(true)
  local actionPoint_Per = workerWrapperLua:getActionPointPercents()
  local actionPoint = workerWrapperLua:getActionPointXXX()
  local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
  local currentActionPoint = workerWrapperLua:getActionPoint()
  self._ui.st_ActProgress:SetProgressRate(actionPoint_Per)
  self._ui.txt_ActProgressText:SetText(tostring(actionPoint) .. "/" .. tostring(actionPoint_Max))
  if prevWorker == false then
    self._ui.st_ProgressBG:SetShow(true)
    self._ui.st_Progress:SetShow(true)
    self._ui.btn_WorkStop:SetShow(true)
    self._ui.txt_ProgressText:SetShow(true)
    local workingLeftPercent = workerWrapperLua:currentProgressPercents()
    local working_LeftTime = workerWrapperLua:getLeftWorkingTimeXXX(getServerUtc64())
    self._ui.st_Progress:SetProgressRate(workingLeftPercent)
    local workName = workerWrapperLua:getWorkStringPalace()
    local workLeftTime = workerWrapperLua:getWorkLeftTimePalace()
    self._ui.st_WorkerText:SetText(workName)
    self:setTextAndAutoWrap(self._ui.st_WorkerText, workName, "HandleEventLOnOut_PalaceManagement_ShowWorkState")
    self._ui.txt_ProgressText:SetText(workLeftTime)
  end
end
function PaGlobal_PalaceManagement_Node:updateWorkerUI()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(self._boardGroupKey)
  if isWorking == true then
    self._ui.st_WorkerEmpty:SetShow(false)
    local workerWrapperLua
    local workerNo = ToClient_GetPalaceManageWorkerNo(self._boardGroupKey)
    local workerNoRaw = Int64toInt32(workerNo)
    if workerNoRaw ~= 0 then
      workerWrapperLua = getWorkerWrapper(workerNo, true)
      self:updateWorkerInfo(workerWrapperLua, false)
    else
      self._ui.st_WorkerEmpty:SetShow(true)
      self._ui.st_ProgressBG:SetShow(false)
      self._ui.st_Progress:SetShow(false)
      self._ui.btn_WorkStop:SetShow(false)
      self._ui.txt_ProgressText:SetShow(false)
      self._ui.st_ActProgressBG:SetShow(false)
      self._ui.st_ActProgress:SetShow(false)
      self._ui.txt_ActProgressText:SetShow(false)
    end
  else
    local prevWorkerNo = ToClient_GetPalaceManagePrevWorkerNo(self._boardGroupKey)
    local prevWorkerNoRaw = Int64toInt32(prevWorkerNo)
    self._ui.st_ProgressBG:SetShow(false)
    self._ui.st_Progress:SetShow(false)
    self._ui.txt_ProgressText:SetShow(false)
    self._ui.btn_WorkStop:SetShow(false)
    if prevWorkerNoRaw ~= 0 then
      local workerWrapperLua
      workerWrapperLua = getWorkerWrapper(prevWorkerNo, true)
      self._ui.st_WorkerEmpty:SetShow(false)
      if workerWrapperLua ~= nil then
        self:updateWorkerInfo(workerWrapperLua, true)
      else
        self._ui.st_WorkerEmpty:SetShow(true)
        self._ui.txt_WorkerName:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_RentHouseNoWorkingByWorkerNotSelect"))
        self._ui.st_WorkerText:SetText("")
        self._ui.st_WorkerImg:SetShow(false)
        self._ui.st_ActProgressBG:SetShow(false)
        self._ui.st_ActProgress:SetShow(false)
        self._ui.txt_ActProgressText:SetShow(false)
      end
    else
      self._ui.st_WorkerEmpty:SetShow(true)
      self._ui.txt_WorkerName:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_RentHouseNoWorkingByWorkerNotSelect"))
      self._ui.st_WorkerText:SetText("")
      self._ui.st_WorkerImg:SetShow(false)
      self._ui.st_ActProgressBG:SetShow(false)
      self._ui.st_ActProgress:SetShow(false)
      self._ui.txt_ActProgressText:SetShow(false)
    end
    Panel_Window_PalaceManagement_Node:ClearUpdateLuaFunc()
  end
end
function PaGlobal_PalaceManagement_Node:stopWorking()
  local workerNo = ToClient_GetPalaceManageWorkerNo(self._boardGroupKey)
  local workerNoRaw = Int64toInt32(workerNo)
  if workerNoRaw == 0 then
    return
  end
  local workerWrapperLua = getWorkerWrapper(workerNo)
  if workerWrapperLua == nil then
    return
  end
  local workingState = workerWrapperLua:getWorkingStateXXX()
  local function cancelDoWork()
    ToClient_requestCancelNextWorking(WorkerNo(workerNo))
  end
  local workName = workerWrapperLua:getWorkString()
  local cancelWorkContent = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LARGECRAFT_WORKMANAGER_CANCELWORK_CONTENT", "workName", workName)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_WORKINGPROGRESS_CANCELWORK_TITLE"),
    content = cancelWorkContent,
    functionYes = cancelDoWork,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData, "top")
end
function PaGlobal_PalaceManagement_Node:restartWorking()
  local isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(self._boardGroupKey)
  if isWorking == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoWorkerIsWorking"))
    return
  end
  local prevWorkerNo = ToClient_GetPalaceManagePrevWorkerNo(self._boardGroupKey)
  local prevWorkerNoRaw = Int64toInt32(prevWorkerNo)
  if prevWorkerNoRaw == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "Lua_RentHouseNoWorkingByWorkerNotSelect"))
    return
  end
  local workerWrapperLua
  workerWrapperLua = getWorkerWrapper(prevWorkerNo, true)
  if workerWrapperLua ~= nil then
    local currentActionPoint = workerWrapperLua:getActionPoint()
    ToClient_requestRepeatWork(WorkerNo(prevWorkerNo), currentActionPoint)
  end
end
function PaGlobal_PalaceManagement_Node:openWarehouse()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if Panel_Window_Warehouse:GetShow() == true then
    return
  end
  if ToClient_WorldMapIsShow() == true then
    PaGlobal_Warehouse_All_OpenPanelFromWorldmap(self._warehouseRegionKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
  else
    PaGlobal_Warehouse_All_OpenPanel(self._warehouseRegionKey, CppEnums.WarehoouseFromType.eWarehoouseFromType_Worldmap)
  end
  Panel_Window_Warehouse:SetPosX(Panel_Window_PalaceManagement_Node:GetPosX() + Panel_Window_PalaceManagement_Node:GetSizeX() + 10)
end
function PaGlobal_PalaceManagement_Node:showRerollProbability(boardIndex, isShow)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    self._isOnProbabilityToolTip = false
    return
  end
  local boardKeyRaw = ToClient_PalaceManagegetBoadKeyRaw(self._boardGroupKey, boardIndex)
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_PALACEMANAGEMENT_NODE_REROLL_TOOLTIPTITLE")
  local desc = ""
  local maxLength = 0
  for itemIndex = 0, self._maxItemCount - 1 do
    local probability = self._board[boardIndex]._ItemProbability[itemIndex]
    if probability ~= -1 then
      local itemSSW = ToClient_PalaceManageGetItem(__ePalaceManageType_Production, boardKeyRaw, itemIndex)
      local name = PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemSSW:getName(), itemSSW)
      local probabilityTextColor = "<PAColor0xFFFFF3AF>"
      if probability == 0 then
        probabilityTextColor = "<PAColor0xFFd31550>"
      end
      desc = desc .. name .. "<PAColor0xfface400> : <PAOldColor>" .. probabilityTextColor .. tostring(probability) .. [[
%
<PAOldColor>]]
    end
  end
  desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_PALACEMANAGEMENT_NODE_REROLL_TOOLTIPDESC")
  self._isOnProbabilityToolTip = true
  TooltipSimple_Show(self._board[boardIndex]._btn_Reload, title, desc, false)
end
function PaGlobal_PalaceManagement_Node:showLockIconTooltip(boardIndex, isShow)
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local tooltipTile = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_LOCKICON_TOOLTIPTITLE")
  local tooltipDesc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_NODE_LOCKICON_TOOLTIPDESC", "npcName", self._ui.st_NpcName:GetText())
  local control = self._board[boardIndex]._st_LockIcon
  TooltipSimple_Show(control, tooltipTile, tooltipDesc, false)
end
function PaGlobal_PalaceManagement_Node:changeIsShowConsoleItemTooltip()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if isPadPressed(__eJoyPadInputType_LeftTrigger) == true then
    return
  end
  self._isShowConsoleItemTooltip = not self._isShowConsoleItemTooltip
  self:updateShowConsoleItemTooltip()
end
function PaGlobal_PalaceManagement_Node:updateShowConsoleItemTooltip()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if self._consoleItemTooltipKey == 0 or self._isShowConsoleItemTooltip == false then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(self._consoleItemTooltipKey))
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
end
function PaGlobal_PalaceManagement_Node:controlConsoleWorkerInfo()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
  local isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(self._boardGroupKey)
  if isWorking == true then
    self:stopWorking()
    return
  end
  PaGlobal_PalaceManagement_OpenWorkerList()
end
function PaGlobal_PalaceManagement_Node:validate()
  if Panel_Window_PalaceManagement_Node == nil then
    return
  end
end
