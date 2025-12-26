function PaGlobal_PalaceManagement_Worker_Open(boardGroupKeyRaw)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  PaGlobal_PalaceManagement_Worker:prepareOpen(boardGroupKeyRaw)
end
function PaGlobal_PalaceManagement_Worker_Close()
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  PaGlobal_PalaceManagement_Worker:prepareClose()
end
function PaGlobal_PalaceManagement_Worker_WorkerSelect(index)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  PaGlobal_PalaceManagement_Worker:workerSelect(index)
end
function PaGlobal_PalaceManagement_Worker_WorkingChange(boardGroupKeyRaw, workerNoRaw)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  if Panel_Window_PalaceManagement_WorkManager:GetShow() == false then
    return
  end
  local self = PaGlobal_PalaceManagement_Worker
  if boardGroupKeyRaw == self._openBoardGroupKeyRaw then
    self:update()
  end
end
function PaGlobal_PalaceManagement_Worker_DoWork()
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  local self = PaGlobal_PalaceManagement_Worker
  local workerNoRaw = self._selectWorkerNo
  ToClient_PalaceManageDoWork(workerNoRaw, self._openBoardGroupKeyRaw, self._workCount)
end
function PaGlobal_PalaceManagement_Worker_SetWorkCount(inputNumber)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  PaGlobal_PalaceManagement_Worker:setWorkCount(inputNumber)
end
function HandleClicked_PalaceManagement_Worker_WorkCount()
  local s64_MaxWorkableCount = toInt64(0, 50000)
  if s64_MaxWorkableCount <= toInt64(0, 0) then
    _PA_LOG("\234\185\128\235\175\188\234\181\172", "\236\157\188\234\190\188\236\157\180 \236\158\145\236\151\133\237\149\160 \236\136\152 \236\151\134\236\138\181\235\139\136\235\139\164.")
  else
    Panel_NumberPad_Show(true, s64_MaxWorkableCount, 0, PaGlobal_PalaceManagement_Worker_SetWorkCount, false)
  end
end
function HandleOnOut_PalaceManagement_Worker_WorkCount(index)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  local self = PaGlobal_PalaceManagement_Worker
  if index == self._selectListindex then
    local selectedContent = self._ui.list2_WorkerList:GetContentByKey(index)
    if selectedContent ~= nil then
      local workerButtonControl = UI.getChildControl(selectedContent, "Button_Worker")
      workerButtonControl:setRenderTexture(workerButtonControl:getClickTexture())
    end
  end
end
function PaGlobal_PalaceManagement_Worker_ShowWorkItemToolTip(key, isShow)
  local self = PaGlobal_PalaceManagement_Worker
  local control = self._workItem.icon
  if control == nil then
    return
  end
  self:showToolTip(control, key, isShow)
end
function PaGlobal_PalaceManagement_Worker_ShowMaterialItemToolTip(index, key, isShow)
  local self = PaGlobal_PalaceManagement_Worker
  local control = self._workItemMaterial[index].icon
  if control == nil then
    return
  end
  self:showToolTip(control, key, isShow)
end
function PaGlobal_PalaceManagement_WorkerListContent(control, key)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  PaGlobal_PalaceManagement_Worker:workerListContent(control, key)
end
function PaGlobal_PalaceManagement_Worker_WareHouseUpdate(townWaypointKey)
  if PaGlobal_PalaceManagement_Worker == nil then
    return
  end
  local regionWaypointKey = Toclient_getPalaceManageWorkerRegionWaypointKey()
  if regionWaypointKey ~= townWaypointKey then
    return
  end
  local isShow = Panel_Window_PalaceManagement_WorkManager:GetShow()
  if isShow == false then
    return
  end
  local self = PaGlobal_PalaceManagement_Worker
  self:updateWorkItemMaterial()
end
