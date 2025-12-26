function PaGlobal_PalaceManagement_Worker:initialize()
  if PaGlobal_PalaceManagement_Worker._initialize == true then
    return
  end
  local workerBg = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Static_WorkerList_BG")
  self._ui.list2_WorkerList = UI.getChildControl(workerBg, "List2_1")
  self._ui.st_noWorkerText = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "StaticText_NoWorker")
  self._ui.st_itemControl = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Static_WorkInfo_Result_Icon")
  self._ui.st_itemName = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "StaticText_WorkInfo_Result_Name")
  self._ui.st_workingTime = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "StaticText_Estimated_Time_Value")
  self._ui.st_workingCount = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "StaticText_Estimated_Time_Count")
  self._ui.btn_workingCountChange = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Button_Estimated_Work_Count")
  self._ui.st_workMaterialBg = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Static_MaterialBg")
  self._ui.st_luckText = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "StaticText_Estimated_Luck_Value")
  self._ui.btn_changeCount = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Button_Estimated_Work_Count")
  self._ui.btn_doWork = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Button_doWork")
  self._ui.btn_close = UI.getChildControl(Panel_Window_PalaceManagement_WorkManager, "Button_Win_Close")
  local itemSlot = {}
  SlotItem.new(itemSlot, "PalaceManageWorkItem", 0, self._ui.st_itemControl, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetHorizonCenter()
  itemSlot.icon:SetVerticalMiddle()
  itemSlot.icon:ComputePos()
  self._workItem = itemSlot
  for index = 0, self._maxMaterialItemCount - 1 do
    self._workItemMaterialControl[index] = UI.getChildControl(self._ui.st_workMaterialBg, "Static_SlotBg_" .. index)
    local itemSlotMaterial = {}
    SlotItem.new(itemSlotMaterial, "PalaceManageMaterialItem" .. index, 0, self._workItemMaterialControl[index], self._slotConfigMaterial)
    itemSlotMaterial:createChild()
    itemSlotMaterial.icon:SetHorizonCenter()
    itemSlotMaterial.icon:SetVerticalMiddle()
    itemSlotMaterial.icon:ComputePos()
    self._workItemMaterial[index] = itemSlotMaterial
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  Panel_Window_PalaceManagement_WorkManager:ignorePadSnapMoveToOtherPanel()
  PaGlobal_PalaceManagement_Worker:registEventHandler()
  PaGlobal_PalaceManagement_Worker:validate()
  PaGlobal_PalaceManagement_Worker._initialize = true
end
function PaGlobal_PalaceManagement_Worker:registEventHandler()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self._ui.list2_WorkerList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PalaceManagement_WorkerListContent")
  self._ui.list2_WorkerList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_changeCount:addInputEvent("Mouse_LUp", "HandleClicked_PalaceManagement_Worker_WorkCount()")
  self._ui.btn_doWork:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Worker_DoWork()")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Worker_Close()")
  registerEvent("WorldMap_WorkerDataUpdateByPalaceManage", "PaGlobal_PalaceManagement_Worker_WorkingChange")
  registerEvent("WorldMap_WorkerDataUpdate", "PaGlobal_PalaceManagement_Worker_WorkingChange")
  registerEvent("EventWarehouseUpdate", "PaGlobal_PalaceManagement_Worker_WareHouseUpdate")
end
function PaGlobal_PalaceManagement_Worker:prepareOpen(boardGroupKeyRaw)
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self._openBoardGroupKeyRaw = boardGroupKeyRaw
  self:setWorkCount(1)
  self:update()
  PaGlobal_PalaceManagement_Worker:open()
end
function PaGlobal_PalaceManagement_Worker:open()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  if Panel_Window_PalaceManagement_WorkManager:GetShow() == true then
    return
  end
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Window_PalaceManagement_WorkManager, true)
  else
    Panel_Window_PalaceManagement_WorkManager:SetShow(true)
  end
end
function PaGlobal_PalaceManagement_Worker:prepareClose()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  if true == self._isConsole then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self:close()
end
function PaGlobal_PalaceManagement_Worker:close()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  if Panel_Window_PalaceManagement_WorkManager:GetShow() == false then
    return
  end
  if ToClient_WorldMapIsShow() == true then
    WorldMapPopupManager:pop()
  else
    Panel_Window_PalaceManagement_WorkManager:SetShow(false)
  end
end
function PaGlobal_PalaceManagement_Worker:update()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self:updateWorkItemData()
  self:updateWorkerList()
  self:updateWorkTime()
end
function PaGlobal_PalaceManagement_Worker:workerListContent(control, InputKey)
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  if nil == control or nil == InputKey then
    return
  end
  local index = Int64toInt32(InputKey)
  local workerNoRaw = self._workerNoRawArray[index]
  local workerButtonControl = UI.getChildControl(control, "Button_Worker")
  local workerNameControl = UI.getChildControl(control, "StaticText_WorkerName")
  local progressControl = UI.getChildControl(control, "Progress2_Working")
  local actionPointControl = UI.getChildControl(control, "StaticText_WorkerActionPoint")
  local workerWrapperLua = getWorkerWrapper(workerNoRaw)
  if nil == workerWrapperLua then
    return
  end
  if self._selectListindex >= 0 and self._selectListindex == index then
    workerButtonControl:setRenderTexture(workerButtonControl:getClickTexture())
  else
    workerButtonControl:setRenderTexture(workerButtonControl:getBaseTexture())
  end
  local workerLv = "<PAColor0xffffedd4>" .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. workerWrapperLua:getLevel() .. "<PAOldColor>"
  local workerName = workerWrapperLua:getGradeToColorString() .. workerWrapperLua:getName() .. "<PAOldColor>"
  workerNameControl:SetText(workerLv .. " " .. workerName)
  local actionPoint_Per = workerWrapperLua:getActionPointPercents()
  local actionPoint = workerWrapperLua:getActionPointXXX()
  local actionPoint_Max = workerWrapperLua:getMaxActionPoint()
  progressControl:SetProgressRate(actionPoint_Per)
  actionPointControl:SetText(tostring(actionPoint) .. "/" .. tostring(actionPoint_Max))
  workerButtonControl:addInputEvent("Mouse_LUp", "PaGlobal_PalaceManagement_Worker_WorkerSelect(" .. index .. ")")
  workerButtonControl:addInputEvent("Mouse_Out", "HandleOnOut_PalaceManagement_Worker_WorkCount(" .. index .. ")")
end
function PaGlobal_PalaceManagement_Worker:workerSelect(index)
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  local workerNoRaw = self._workerNoRawArray[index]
  self._selectWorkerNo = workerNoRaw
  self._selectListindex = index
  local list2ContentsSize = self._ui.list2_WorkerList:getChildContentListSize()
  for workerIndex = 0, list2ContentsSize - 1 do
    local selectedContent = self._ui.list2_WorkerList:GetContentByKey(workerIndex)
    if selectedContent ~= nil then
      local workerButtonControl = UI.getChildControl(selectedContent, "Button_Worker")
      if index == workerIndex then
        workerButtonControl:setRenderTexture(workerButtonControl:getClickTexture())
      else
        workerButtonControl:setRenderTexture(workerButtonControl:getBaseTexture())
      end
    end
  end
  self:updateWorkTime()
end
function PaGlobal_PalaceManagement_Worker:validate()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self._ui.list2_WorkerList:isValidate()
  self._ui.st_noWorkerText:isValidate()
  self._ui.st_itemControl:isValidate()
  self._ui.st_itemName:isValidate()
  self._ui.st_workingTime:isValidate()
  self._ui.st_workingCount:isValidate()
  self._ui.btn_workingCountChange:isValidate()
  self._ui.st_workMaterialBg:isValidate()
  self._ui.st_luckText:isValidate()
  self._ui.btn_doWork:isValidate()
end
function PaGlobal_PalaceManagement_Worker:setWorkCount(inputNumber)
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self._workCount = Int64toInt32(inputNumber)
  self._ui.st_workingCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_WORKMANAGER_BUILDING_DEFAULT", "getWorkingCount", self._workCount))
end
function PaGlobal_PalaceManagement_Worker:updateWorkerList()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  for index = 0, #self._workerNoRawArray do
    self._workerNoRawArray[index] = nil
  end
  self._ui.list2_WorkerList:getElementManager():clearKey()
  self._ui.st_noWorkerText:SetShow(false)
  self._selectWorkerNo = 0
  self._selectListindex = 0
  local regionWaypointKey = Toclient_getPalaceManageWorkerRegionWaypointKey()
  local myWorkerCount = ToClient_getMyNpcWorkerCount()
  local waitWorkerCount = 0
  for workerIdx = 0, myWorkerCount - 1 do
    local workerWrapper = ToClient_getMyNpcWorkerByIndex(workerIdx)
    local workerNoRaw = workerWrapper:get():getWorkerNo():get()
    local workerWrapperLua = getWorkerWrapper(workerNoRaw, true)
    if workerWrapperLua:getHomeWaypoint() == regionWaypointKey and false == workerWrapperLua:isWorking() and false == workerWrapperLua:getIsAuctionInsert() then
      self._workerNoRawArray[waitWorkerCount] = workerNoRaw
      waitWorkerCount = waitWorkerCount + 1
    end
  end
  if waitWorkerCount == 0 then
    self._ui.st_noWorkerText:SetShow(true)
  end
  for key = 0, waitWorkerCount - 1 do
    self._ui.list2_WorkerList:getElementManager():pushKey(key)
  end
  if waitWorkerCount > 0 then
    PaGlobal_PalaceManagement_Worker_WorkerSelect(0)
  end
end
function PaGlobal_PalaceManagement_Worker:updateWorkItemData()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self._ui.st_itemName:SetText("")
  local itemSSW = ToClient_PalaceManageGetSelectedtItemInBoardGroup(self._openBoardGroupKeyRaw)
  if itemSSW == nil then
    return
  end
  self._workItem:clearItem()
  self._workItem:setItemByStaticStatus(itemSSW, Defines.s64_const.s64_1)
  self._workItem.icon:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Worker_ShowWorkItemToolTip(" .. itemSSW:getItemKey() .. ",true)")
  self._workItem.icon:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Worker_ShowWorkItemToolTip(" .. itemSSW:getItemKey() .. ",false)")
  self._ui.st_itemName:SetText(itemSSW:getName())
  self:updateWorkItemMaterial()
end
function PaGlobal_PalaceManagement_Worker:updateWorkItemMaterial()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  self._ui.st_workMaterialBg:SetShow(false)
  local boardGroupTypeRaw = ToClient_PalaceManagegetBoadGroupTypeRaw(self._openBoardGroupKeyRaw)
  if boardGroupTypeRaw ~= __ePalaceManageType_Manufacture then
    return
  end
  local boardKey = ToClient_PalaceManageGetSelectedBoardKeyRaw(self._openBoardGroupKeyRaw)
  local itemIndex = ToClient_PalaceManageGetSelectedBoardItemIndex(self._openBoardGroupKeyRaw)
  local itemExchangeSourceSSW = ToClient_PalaceManageSelectItemExchangeSource(self._openBoardGroupKeyRaw, boardKey, itemIndex)
  local resourceItemCount = 0
  if itemExchangeSourceSSW ~= nil then
    resourceItemCount = itemExchangeSourceSSW:getResourceItemStaticStatusWrapperCount()
  end
  self._ui.st_workMaterialBg:SetShow(true)
  for index = 0, self._maxMaterialItemCount - 1 do
    self._workItemMaterial[index]:clearItem()
  end
  local regionWaypointKey = Toclient_getPalaceManageWorkerRegionWaypointKey()
  if itemExchangeSourceSSW ~= nil then
    for index = 0, self._maxMaterialItemCount - 1 do
      self._workItemMaterial[index]:clearItem()
      local resourceItemNeedCount = itemExchangeSourceSSW:getResourceItemNeedCount(index)
      local resourceItemSSW = itemExchangeSourceSSW:getResourceItemStaticStatusWrapper(index)
      if resourceItemSSW ~= nil then
        local haveCount = Int64toInt32(warehouse_getItemCount(regionWaypointKey, resourceItemSSW:get()._key))
        self._workItemMaterial[index]:setItemByStaticStatus(resourceItemSSW, Defines.s64_const.s64_1)
        self._workItemMaterial[index].icon:addInputEvent("Mouse_On", "PaGlobal_PalaceManagement_Worker_ShowMaterialItemToolTip(" .. tostring(index) .. "," .. resourceItemSSW:getItemKey() .. ",true)")
        self._workItemMaterial[index].icon:addInputEvent("Mouse_Out", "PaGlobal_PalaceManagement_Worker_ShowMaterialItemToolTip(" .. tostring(index) .. "," .. resourceItemSSW:getItemKey() .. ",false)")
        local text = ""
        if resourceItemNeedCount <= haveCount then
          text = "<PAColor0x00FFFFFF>" .. haveCount .. "/" .. resourceItemNeedCount .. "<PAOldColor>"
        else
          text = "<PAColor0xFFD20000>" .. haveCount .. "/" .. resourceItemNeedCount .. "<PAOldColor>"
        end
        self._workItemMaterial[index].count:SetText(text)
      end
    end
  end
end
function PaGlobal_PalaceManagement_Worker:updateWorkTime()
  if Panel_Window_PalaceManagement_WorkManager == nil then
    return
  end
  local workerWrapperLua = getWorkerWrapper(self._selectWorkerNo, true)
  if nil == workerWrapperLua then
    self._ui.st_workingTime:SetText("")
    return
  end
  local boardKey = ToClient_PalaceManageGetSelectedBoardKeyRaw(self._openBoardGroupKeyRaw)
  local itemIndex = ToClient_PalaceManageGetSelectedBoardItemIndex(self._openBoardGroupKeyRaw)
  local itemExchangeSS = ToClient_PalaceManageSelectItemExchangeSource(self._openBoardGroupKeyRaw, boardKey, itemIndex)
  if itemExchangeSS == nil then
    self._ui.st_workingTime:SetText("")
    return
  end
  local itemExchangeKeyRaw = itemExchangeSS:getExchangeKeyRaw()
  local houseUseType = CppEnums.eHouseUseType.Count
  local productCategory = itemExchangeSS:get()._productCategory
  local workingType = CppEnums.NpcWorkingType.eNpcWorkingType_PalaceManagement
  local workVolume = Int64toInt32(itemExchangeSS:get()._productTime / toInt64(0, 1000))
  local workSpeed = workerWrapperLua:getWorkEfficienceWithSkill(workingType, houseUseType, 0, productCategory) / CppDefine.e100Percent
  local workBaseTime = ToClient_getNpcWorkingBaseTime()
  local workTimeStatic = Int64toInt32(workerWrapperLua:getWorkTimeStatic(workingType, houseUseType, productCategory, itemExchangeKeyRaw))
  local workTimePercents = workerWrapperLua:getWorkTimePercents(workingType, houseUseType, productCategory, itemExchangeKeyRaw)
  local totalWorkTime = math.ceil(workVolume / workSpeed) * workBaseTime * (workTimePercents / CppDefine.e100Percent) - workTimeStatic * 1000
  self._ui.st_workingTime:SetText(Util.Time.timeFormatting(math.ceil(totalWorkTime / 1000)))
end
function PaGlobal_PalaceManagement_Worker:showToolTip(control, key, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if nil == PaGlobal_PalaceManagement_Worker or nil == itemWrapper then
    return
  end
  local self = PaGlobal_PalaceManagement_Worker
  if control == nil then
    return
  end
  if false == PaGlobal_PalaceManagement_Node._isConsole then
    if true == isShow then
      Panel_Tooltip_Item_Show(itemWrapper, control, true, false)
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  elseif true == isShow then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
