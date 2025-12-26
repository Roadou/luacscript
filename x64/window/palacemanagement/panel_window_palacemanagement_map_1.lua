function PaGlobal_PalaceManagement_Map:initialize()
  if PaGlobal_PalaceManagement_Map._initialize == true then
    return
  end
  self._waypointUI = Toclient_getPalaceManageRegionWaypointKey()
  self._ui.btn_Close = UI.getChildControl(Panel_Window_PalaceManagement_Map, "Button_Close")
  local static_MapBg = UI.getChildControl(Panel_Window_PalaceManagement_Map, "Static_MapBg")
  self._ui.sts_title = UI.getChildControl(static_MapBg, "StaticText_Title")
  self._ui.sts_BlackScreen = UI.getChildControl(Panel_Window_PalaceManagement_Map, "Static_BlackScreen")
  self._ui.sts_BlackScreen:SetShow(false)
  self._ui.btn_PalaceOpen = UI.getChildControl(self._ui.sts_BlackScreen, "Button_Open")
  self._ui.btn_PalaceOpen:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_OPEN"))
  self._ui.btn_PalaceOpenDesc = UI.getChildControl(self._ui.sts_BlackScreen, "StaticText_Desc")
  self._ui.btn_shutDown = UI.getChildControl(static_MapBg, "Button_ShutDown")
  self._ui.btn_shutDown:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_MAP_SHUTDOWN"))
  self._ui.sts_BlackScreen:SetShow(false)
  self._ui.st_consoleKeyGuide = UI.getChildControl(Panel_Window_PalaceManagement_Map, "Static_KeyGuide_ConsoleUI_Import")
  if isGameTypeKorea() then
    self._ui.sts_title:SetShow(false)
  end
  self._uiToolTip.st_NodeBg = UI.getChildControl(Panel_Window_PalaceManagement_Tooltip, "Static_NodeBg")
  self._uiToolTip.st_NodeName = UI.getChildControl(Panel_Window_PalaceManagement_Tooltip, "StaticText_Title")
  local btn_Node = UI.getChildControl(Panel_Window_PalaceManagement_Tooltip, "Button_Node")
  self._uiToolTip.btn_NodeWorking = UI.getChildControl(btn_Node, "Static_Working")
  local mainBG = UI.getChildControl(Panel_Window_PalaceManagement_Tooltip, "Static_MainBg")
  self._uiToolTip.st_WorkerBg = UI.getChildControl(mainBG, "Static_WorkerImageBg")
  self._uiToolTip.st_WorkerImg = UI.getChildControl(self._uiToolTip.st_WorkerBg, "Static_WorkerImage")
  self._uiToolTip.st_WorkerEmpty = UI.getChildControl(self._uiToolTip.st_WorkerBg, "Static_WorkerEmpty")
  self._uiToolTip.st_WorkerText = UI.getChildControl(self._uiToolTip.st_WorkerBg, "StaticText_WorkerState")
  self._uiToolTip.st_ActProgressBG = UI.getChildControl(self._uiToolTip.st_WorkerBg, "Static_ActBg")
  self._uiToolTip.st_ActProgress = UI.getChildControl(self._uiToolTip.st_WorkerBg, "Progress2_Act")
  self._uiToolTip.txt_ActProgressText = UI.getChildControl(self._uiToolTip.st_WorkerBg, "StaticText_ActPoint")
  self._uiToolTip.st_BoardSpace = UI.getChildControl(mainBG, "Board_Space")
  self._uiToolTip.st_BoardText = UI.getChildControl(self._uiToolTip.st_BoardSpace, "StaticText_Name")
  for index = 1, self._tooltipBoardItemCountMAX do
    self._uiToolTip.st_itemSlotBG[index] = UI.getChildControl(self._uiToolTip.st_BoardSpace, "Static_SlotBg_" .. index)
    local itemSlot = {}
    SlotItem.new(itemSlot, "BoardItem" .. index, 0, self._uiToolTip.st_itemSlotBG[index], self._slotConfig)
    itemSlot:createChild()
    itemSlot.icon:SetHorizonCenter()
    itemSlot.icon:SetVerticalMiddle()
    itemSlot.icon:ComputePos()
    self._tooltipItemSlot[index] = itemSlot
  end
  self._uiToolTip.st_selectedSlot = UI.getChildControl(self._uiToolTip.st_BoardSpace, "Static_SelectedSlot")
  self._boardGroupCount = ToClient_GetPalaceManageBoardGroupCount()
  local templeateControl = UI.getChildControl(static_MapBg, "Button_Node_Template")
  templeateControl:SetShow(false)
  for ii = 0, self._boardGroupCount - 1 do
    local boardGroupKey = ToClient_GetPalaceManageBoardGroupKey(ii)
    local boardGroupName = ToClient_GetPalaceManageBoardGroupName(boardGroupKey)
    local boadGroupData = {
      _boardGroupKey = 0,
      _boardGroupName = "",
      _isWorking = false,
      _item = nil
    }
    boadGroupData._boardGroupKey = boardGroupKey
    boadGroupData._boardGroupName = boardGroupName
    boadGroupData._isWorking = false
    local boardGroupControl = {}
    boardGroupControl._button = UI.cloneControl(templeateControl, static_MapBg, "BoardGroup_" .. ii)
    boardGroupControl._animationBtn = UI.getChildControl(boardGroupControl._button, "Static_Working")
    boardGroupControl._text = UI.getChildControl(boardGroupControl._button, "StaticText_NodeName")
    boardGroupControl._text2 = UI.getChildControl(boardGroupControl._button, "StaticText_NodeName_2")
    boardGroupControl._itemSlot = UI.getChildControl(boardGroupControl._button, "Static_ItemSlotBg")
    local itemSlot = {}
    SlotItem.new(itemSlot, "PalaceManageMap_", 0, boardGroupControl._itemSlot, self._slotConfig)
    itemSlot:createChild()
    itemSlot.icon:SetSize(28, 28)
    itemSlot.border:SetSize(30, 30)
    itemSlot.icon:SetHorizonCenter()
    itemSlot.icon:SetVerticalMiddle()
    itemSlot.icon:ComputePos()
    boadGroupData._item = itemSlot
    self._boardGroupData[ii] = boadGroupData
    local isProduct = __ePalaceManageType_Production == ToClient_PalaceManagegetBoadGroupTypeRaw(boardGroupKey)
    if true == isProduct then
      boardGroupControl._button:SetColor(Defines.Color.C_FFC1FFC2)
    else
      boardGroupControl._button:SetColor(Defines.Color.C_FFFFEEA0)
    end
    self._boardGroupControl[boardGroupKey] = boardGroupControl
    self._boardGroupControl[boardGroupKey]._button:SetShow(true)
    self._boardGroupControl[boardGroupKey]._animationBtn:SetShow(true)
    self._boardGroupControl[boardGroupKey]._text:SetShow(true)
    self._boardGroupControl[boardGroupKey]._text:SetText(boardGroupName)
    local boardGroupNameSizeX = self._boardGroupControl[boardGroupKey]._text:GetTextSizeX() + 20
    if boardGroupNameSizeX > self._boardGroupControl[boardGroupKey]._text:GetSizeX() then
      self._boardGroupControl[boardGroupKey]._text:SetShow(false)
      self._boardGroupControl[boardGroupKey]._text2:SetShow(true)
      self._boardGroupControl[boardGroupKey]._text2:SetText(boardGroupName)
    else
      self._boardGroupControl[boardGroupKey]._text:SetShow(true)
      self._boardGroupControl[boardGroupKey]._text2:SetShow(false)
    end
    self._boardGroupControl[boardGroupKey]._button:SetPosX(self._boardGroupPos[boardGroupKey]._x)
    self._boardGroupControl[boardGroupKey]._button:SetPosY(self._boardGroupPos[boardGroupKey]._y)
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.st_consoleKeyGuide:SetShow(self._isConsole)
  PaGlobal_PalaceManagement_Map:registEventHandler()
  PaGlobal_PalaceManagement_Map:validate()
  PaGlobal_PalaceManagement_Map._initialize = true
end
function PaGlobal_PalaceManagement_Map:registEventHandler()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  self._ui.btn_PalaceOpen:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_ContentUse(true)")
  self._ui.btn_shutDown:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_ContentUse(false)")
  for ii = 0, self._boardGroupCount - 1 do
    local boardGroupKey = self._boardGroupData[ii]._boardGroupKey
    self._boardGroupControl[boardGroupKey]._button:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Node_Open(" .. boardGroupKey .. ")")
    self._boardGroupControl[boardGroupKey]._button:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Tooltip_Open(" .. boardGroupKey .. ")")
    self._boardGroupControl[boardGroupKey]._button:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Tooltip_Close()")
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Map_Close()")
  registerEvent("FromClient_PalaceManagementisChangeUsed", "PaGlobal_PalaceManagement_isUsedChange")
  registerEvent("FromClient_SetTownMode", "PaGlobal_PalaceManagement_WorldMapTownOn")
  registerEvent("WorldMap_WorkerDataUpdateByPalaceManage", "PaGlobal_PalaceManagement_Map_WorkingChange")
  Panel_Window_PalaceManagement_Map:RegisterShowEventFunc(true, "PalaceManagement_Map_ShowAni()")
  Panel_Window_PalaceManagement_Map:RegisterShowEventFunc(false, "PalaceManagement_Map_HideAni()")
end
function PalaceManagement_Map_ShowAni()
  local aniInfo1 = Panel_Window_PalaceManagement_Map:addScaleAnimation(0, 0.2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.35)
  aniInfo1:SetEndScale(PaGlobal_PalaceManagement_Map._scale)
  aniInfo1.AxisX = Panel_Window_PalaceManagement_Map:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_PalaceManagement_Map:GetSizeY() / 2
  aniInfo1.ScaleType = 1
  aniInfo1.IsChangeChild = true
end
function PalaceManagement_Map_HideAni()
end
function PaGlobal_PalaceManagement_Map:prepareOpen()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  self:update()
  PaGlobal_PalaceManagement_Map:open()
end
function PaGlobal_PalaceManagement_Map:open()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  local modifyScaleX = getScreenSizeX() / Panel_Window_PalaceManagement_Map:GetSizeX()
  local modifyScaleY = getScreenSizeY() / Panel_Window_PalaceManagement_Map:GetSizeY()
  if modifyScaleX < 1 then
    Panel_Window_PalaceManagement_Map:SetScaleChild(modifyScaleX, modifyScaleX)
    ToClient_applyDynamicScalePanel(Panel_Window_PalaceManagement_Map)
    self._scale = 0.9
  elseif modifyScaleY < 1 then
    Panel_Window_PalaceManagement_Map:SetScaleChild(modifyScaleY, modifyScaleY)
    ToClient_applyDynamicScalePanel(Panel_Window_PalaceManagement_Map)
    self._scale = 0.9
  end
  Panel_Window_PalaceManagement_Map:ComputePos()
  if Panel_Window_PalaceManagement_Map:GetShow() == true then
    return
  end
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_PalaceManagement_Map, true)
  else
    Panel_Window_PalaceManagement_Map:SetShow(true, true)
  end
  local isOpened = ToClient_GetPalaceManageContentUsed()
  self:updateSnapTarget(isOpened)
end
function PaGlobal_PalaceManagement_Map:updateSnapTarget(isOpened)
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  if Panel_Window_PalaceManagement_Map:GetShow() == false then
    return
  end
  if isOpened == true then
    local boardGroupKey = self._boardGroupData[0]._boardGroupKey
    ToClient_padSnapSetTargetGroup(self._boardGroupControl[boardGroupKey]._button)
  else
    ToClient_padSnapSetTargetGroup(self._ui.btn_PalaceOpen)
  end
end
function PaGlobal_PalaceManagement_Map:prepareClose()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  PaGlobal_PalaceManagement_Tooltip_Close()
  PaGlobal_PalaceManagement_Node_Close()
  self:close()
end
function PaGlobal_PalaceManagement_Map:close()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  if Panel_Window_PalaceManagement_Map:GetShow() == false then
    return
  end
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:pop()
  else
    Panel_Window_PalaceManagement_Map:SetShow(false)
  end
end
function PaGlobal_PalaceManagement_Map:update()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  self:updateIsUsed()
  for ii = 0, self._boardGroupCount - 1 do
    local boardGroupKey = self._boardGroupData[ii]._boardGroupKey
    self._boardGroupData[ii]._isWorking = ToClient_GetPalaceManageBoardGroupIsWorking(boardGroupKey)
    if self._boardGroupData[ii]._isWorking == true then
      self._boardGroupControl[boardGroupKey]._animationBtn:SetVertexAniRun("Ani_Rotate_New", true)
      self._boardGroupControl[boardGroupKey]._animationBtn:SetShow(true)
      local itemSSW = ToClient_PalaceManageGetSelectedtItemInBoardGroup(boardGroupKey)
      if itemSSW ~= nil then
        self._boardGroupData[ii]._item:clearItem()
        self._boardGroupData[ii]._item:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
        self._boardGroupData[ii]._item.icon:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Map_showToolTip(" .. ii .. "," .. itemSSW:getItemKey() .. ",true)")
        self._boardGroupData[ii]._item.icon:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Map_showToolTip(" .. ii .. "," .. itemSSW:getItemKey() .. ",false)")
        self._boardGroupControl[boardGroupKey]._itemSlot:SetShow(true)
      end
    else
      self._boardGroupControl[boardGroupKey]._itemSlot:SetShow(false)
      self._boardGroupControl[boardGroupKey]._animationBtn:ResetVertexAni()
      self._boardGroupControl[boardGroupKey]._animationBtn:SetShow(false)
    end
  end
end
function PaGlobal_PalaceManagement_Map:updateIsUsed()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  local isOpened = ToClient_GetPalaceManageContentUsed()
  if isOpened == true then
    self._ui.sts_BlackScreen:SetShow(false)
  else
    self._ui.sts_BlackScreen:SetShow(true)
  end
  for ii = 0, self._boardGroupCount - 1 do
    local boardGroupKey = self._boardGroupData[ii]._boardGroupKey
    self._boardGroupControl[boardGroupKey]._button:SetIgnore(not isOpened)
    self._ui.btn_shutDown:SetIgnore(not isOpened)
  end
  local explorepoint = ToClient_GetPalaceManageExplorationPoint()
  local desc = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PALACEMANAGEMENT_VALUE", "value", explorepoint)
  self._ui.btn_PalaceOpenDesc:SetText(desc)
  self:updateSnapTarget(isOpened)
end
function PaGlobal_PalaceManagement_Map:validate()
  if Panel_Window_PalaceManagement_Map == nil then
    return
  end
  self._ui.btn_Close:isValidate()
end
function PaGlobal_PalaceManagement_Map:initializeTooltip()
  if PaGlobal_PalaceManagement_Map._initializeTooltip == true then
    return
  end
  PaGlobal_PalaceManagement_Map._initializeTooltip = true
end
function PaGlobal_PalaceManagement_Map:prepareOpenTooltip(boardGroupKey)
  if Panel_Window_PalaceManagement_Tooltip == nil then
    return
  end
  if self._boardGroupControl[boardGroupKey] == nil then
    return
  end
  local parentPosX = Panel_Window_PalaceManagement_Map:GetPosX()
  local control = self._boardGroupControl[boardGroupKey]._button
  local buttonSizeX = self._boardGroupControl[boardGroupKey]._button:GetSizeX()
  local screenPosX = control:GetParentPosX()
  local screenPosY = control:GetParentPosY()
  local posY = screenPosY
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local isLeft = screenPosX < screenSizeX / 2
  local panelSizeX = Panel_Window_PalaceManagement_Tooltip:GetSizeX()
  local panelSizeY = Panel_Window_PalaceManagement_Tooltip:GetSizeY()
  if screenSizeY < screenPosY + panelSizeY then
    local newPosY = screenSizeY - panelSizeY
    posY = newPosY - 4
  end
  if isLeft == true then
    Panel_Window_PalaceManagement_Tooltip:SetPosX(screenPosX + buttonSizeX + 30)
    Panel_Window_PalaceManagement_Tooltip:SetPosY(posY)
  else
    Panel_Window_PalaceManagement_Tooltip:SetPosX(screenPosX - 10 - panelSizeX)
    Panel_Window_PalaceManagement_Tooltip:SetPosY(posY)
  end
  self:updateTooltip(boardGroupKey)
  PaGlobal_PalaceManagement_Map:openTooltip()
end
function PaGlobal_PalaceManagement_Map:openTooltip()
  if Panel_Window_PalaceManagement_Tooltip == nil then
    return
  end
  Panel_Window_PalaceManagement_Tooltip:SetShow(true)
end
function PaGlobal_PalaceManagement_Map:updateTooltip(boardGroupKey)
  if Panel_Window_PalaceManagement_Tooltip == nil then
    return
  end
  local boadGroupData
  self._uiToolTip.st_WorkerEmpty:SetShow(true)
  self._uiToolTip.st_WorkerImg:SetShow(false)
  for ii = 0, self._boardGroupCount - 1 do
    if self._boardGroupData[ii]._boardGroupKey == boardGroupKey then
      boadGroupData = self._boardGroupData[ii]
      break
    end
  end
  if boadGroupData == nil then
    return
  end
  self._uiToolTip.st_NodeName:SetText(boadGroupData._boardGroupName)
  local tooltipTextSizeX = self._uiToolTip.st_NodeName:GetTextSizeX()
  if tooltipTextSizeX > 150 then
    self._uiToolTip.st_NodeName:SetSize(330 + (tooltipTextSizeX - 150), 64)
  else
    self._uiToolTip.st_NodeName:SetSize(330, 64)
  end
  local nodeBgTextureID = ToClient_PalaceManageGetBoardGroupTextureID(boardGroupKey)
  self._uiToolTip.st_NodeBg:ChangeTextureInfoTextureIDAsync(nodeBgTextureID)
  self._uiToolTip.st_NodeBg:setRenderTexture(self._uiToolTip.st_NodeBg:getBaseTexture())
  local btn_Node = UI.getChildControl(Panel_Window_PalaceManagement_Tooltip, "Button_Node")
  local isProduct = __ePalaceManageType_Production == ToClient_PalaceManagegetBoadGroupTypeRaw(boardGroupKey)
  if true == isProduct then
    btn_Node:SetColor(Defines.Color.C_FFC1FFC2)
  else
    btn_Node:SetColor(Defines.Color.C_FFFFEEA0)
  end
  if boadGroupData._isWorking == false then
    self._uiToolTip.btn_NodeWorking:SetShow(false)
    self._uiToolTip.btn_NodeWorking:ResetVertexAni()
    self._uiToolTip.st_ActProgressBG:SetShow(false)
    self._uiToolTip.st_ActProgress:SetShow(false)
    self._uiToolTip.txt_ActProgressText:SetShow(false)
  else
    self._uiToolTip.btn_NodeWorking:SetShow(true)
    self._uiToolTip.btn_NodeWorking:SetVertexAniRun("Ani_Rotate_New", true)
    self._uiToolTip.st_ActProgressBG:SetShow(true)
    self._uiToolTip.st_ActProgress:SetShow(true)
    self._uiToolTip.txt_ActProgressText:SetShow(true)
  end
  self._uiToolTip.st_WorkerText:SetText(PAGetString(Defines.StringSheet_GAME, "Lua_RentHouseNoWorkingByWorkerNotSelect"))
  local workerWrapperLua
  local workerNo = ToClient_GetPalaceManageWorkerNo(boardGroupKey)
  local workerNoRaw = Int64toInt32(workerNo)
  if workerNoRaw ~= 0 then
    workerWrapperLua = getWorkerWrapper(workerNo, true)
    if workerWrapperLua ~= nil then
      local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
      local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
      local workerNameString = workerLv .. " " .. workerName
      self._uiToolTip.st_WorkerText:SetText(workerNameString)
      local workerIcon = workerWrapperLua:getWorkerIcon()
      self._uiToolTip.st_WorkerImg:ChangeTextureInfoNameAsync(workerIcon)
      self._uiToolTip.st_WorkerImg:SetShow(true)
      self._uiToolTip.st_WorkerEmpty:SetShow(false)
      local actionPoint_Per = workerWrapperLua:getActionPointPercents()
      local actionPoint = workerWrapperLua:getActionPointXXX()
      local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
      local currentActionPoint = workerWrapperLua:getActionPoint()
      self._uiToolTip.st_ActProgress:SetProgressRate(actionPoint_Per)
      self._uiToolTip.txt_ActProgressText:SetText(tostring(actionPoint) .. "/" .. tostring(actionPoint_Max))
    end
  end
  local boardName = ToClient_PalaceManageGetSelectedBoardName(boardGroupKey)
  self._uiToolTip.st_BoardText:SetText(boardName)
  local boardGroupTypeRaw = ToClient_PalaceManagegetBoadGroupTypeRaw(boardGroupKey)
  local boardKeyRaw = ToClient_PalaceManageGetSelectedBoardKeyRaw(boardGroupKey)
  local selectItemIndex = ToClient_PalaceManageGetSelectedBoardItemIndex(boardGroupKey)
  if boardKeyRaw == 0 then
    return
  end
  self._uiToolTip.st_selectedSlot:SetShow(false)
  if selectItemIndex + 1 < self._tooltipBoardItemCountMAX then
    self._uiToolTip.st_selectedSlot:SetShow(true)
    local posX = self._uiToolTip.st_itemSlotBG[selectItemIndex + 1]:GetPosX()
    local posY = self._uiToolTip.st_itemSlotBG[selectItemIndex + 1]:GetPosY()
    self._uiToolTip.st_selectedSlot:SetPosXY(posX, posY)
  end
  local itemCount = ToClient_PalaceManageGetItemCount(boardGroupTypeRaw, boardKeyRaw)
  for index = 1, self._tooltipBoardItemCountMAX do
    self._tooltipItemSlot[index]:clearItem()
    local itemSSW = ToClient_PalaceManageGetItem(boardGroupTypeRaw, boardKeyRaw, index - 1)
    if itemSSW ~= nil then
      self._tooltipItemSlot[index]:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
    end
  end
end
function PaGlobal_PalaceManagement_Map_showToolTip(controlIndex, key, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == itemWrapper then
    return
  end
  local control = PaGlobal_PalaceManagement_Map._boardGroupData[controlIndex]._item.icon
  if control == nil then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_Show(itemWrapper, control, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
