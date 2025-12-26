function PaGlobalFunc_WareHouseFunctionPanel_All_Open()
  PaGlobal_WareHouseFunctionPanel_All:prepareOpen()
end
function PaGlobalFunc_WareHouseFunctionPanel_All_Close()
  PaGlobal_WareHouseFunctionPanel_All:prepareClose()
end
function HandleEventPadPress_WareHouseFunctionPanel_All_PressHouseInfoFunc(btnType)
  local eFuncType = PaGlobal_WareHouseFunctionPanel_All._eFuncType
  if btnType == eFuncType.autoMoveCurrentWay then
    PaGlobalFunc_Inventory_RequestMoveItemsInventoryToWarehouse(true)
  elseif btnType == eFuncType.autoMoveAllWay then
    PaGlobalFunc_Inventory_RequestMoveItemsInventoryToWarehouse(false)
  elseif btnType == eFuncType.autoMoveException then
    PaGlobal_ItemMoveSet:prepareOpen()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 1)
  PaGlobal_WareHouseFunctionPanel_All:prepareClose()
end
