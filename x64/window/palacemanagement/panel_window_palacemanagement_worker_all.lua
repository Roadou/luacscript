PaGlobal_PalaceManagement_Worker = {
  _ui = {
    list2_WorkerList = nil,
    st_noWorkerText = nil,
    st_itemControl = nil,
    st_itemName = nil,
    st_workingTime = nil,
    st_workingCount = nil,
    st_workMaterialBg = nil,
    btn_workingCountChange = nil,
    st_luckText = nil,
    btn_changeCount = nil,
    btn_doWork = nil,
    btn_close = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = false,
    createEnchant = true,
    createEnduranceIcon = false,
    createOriginalForDuel = false
  },
  _slotConfigMaterial = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = false,
    createEnchant = true,
    createEnduranceIcon = false,
    createOriginalForDuel = false
  },
  _workItem = nil,
  _workItemMaterialControl = {},
  _workItemMaterial = {},
  _maxMaterialItemCount = 5,
  _workerNoRawArray = {},
  _openBoardGroupKeyRaw = 0,
  _selectWorkerNo = 0,
  _selectListindex = -1,
  _workCount = 1,
  _initialize = false
}
runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Worker_1.lua")
runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Worker_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PalaceMangement_Worker_Init")
function FromClient_PalaceMangement_Worker_Init()
  PaGlobal_PalaceManagement_Worker:initialize()
end
