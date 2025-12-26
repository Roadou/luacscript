function PaGlobalFunc_AutoSortFunctionPanel_GetShow(panelIndex)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return nil
  end
  local panelInfo = self:getPanelInfo(panelIndex)
  if panelInfo == nil then
    return nil
  end
  if panelInfo._isInitialize == false then
    return nil
  end
  if panelInfo._ui._parent == nil then
    return nil
  end
  return panelInfo._ui._parent:GetShow()
end
function PaGlobalFunc_AutoSortFunctionPanel_ShowToggle(panelIndex)
  local isShow = PaGlobalFunc_AutoSortFunctionPanel_GetShow(panelIndex)
  if isShow ~= nil then
    if isShow == true then
      PaGlobalFunc_AutoSortFunctionPanel_Hide()
    else
      PaGlobalFunc_AutoSortFunctionPanel_Show(panelIndex)
    end
  end
end
function PaGlobalFunc_AutoSortFunctionPanel_Show(panelIndex)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:prepareOpen(panelIndex)
end
function PaGlobalFunc_AutoSortFunctionPanel_Hide()
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(panelIndex, panel, sortButtonControl, sortCheckButtonControl, categoryBtn, slotBtn, sortComponentControlAddString)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:linkPanel(panelIndex, panel, sortButtonControl, sortCheckButtonControl, categoryBtn, slotBtn, sortComponentControlAddString)
end
function PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(panelIndex, updateSlotFlag)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:loadSortOptionAndDoSort(panelIndex, updateSlotFlag)
end
function PaGlobalFunc_AutoSortFunctionPanel_IsSorted(panelIndex)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  return self:isSorted(panelIndex)
end
function PaGlobalFunc_AutoSortFunctionPanel_GetSortWhereType(panelIndex)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  return self:getCurrentInventorySortWhereType(panelIndex)
end
function HandleLUp_AutoSortFunctionPanel_ToggleUseSort(panelIndex, isConsole)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:toggleUseSort(panelIndex, isConsole)
  self:prepareClose()
end
function HandleLUp_AutoSortFunctionPanel_SetCategoryView(panelIndex, isCategoryView)
  if PaGlobal_InvenAutoSort == nil then
    return
  end
  if HandleEventLUp_Inventory_All_cashProductRestoreBgClose() ~= nil then
    HandleEventLUp_Inventory_All_cashProductRestoreBgClose()
  end
  PaGlobal_InvenAutoSort:setCategoryView(panelIndex, isCategoryView)
  PaGlobal_InvenAutoSort:prepareClose()
end
function HandleLUp_AutoSortFunctionPanel_SortProperty(sortPropertyType)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:updateSortProperty(sortPropertyType, true)
  self:prepareClose()
end
function HandleLUp_AutoSortFunctionPanel_SortBy(sortByType)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:updateSortBy(sortByType, true)
  self:prepareClose()
end
function HandleOn_AutoSortFunctionPanel_CheckIn(panelIndex)
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:checkInControl(panelIndex)
end
function HandleOut_AutoSortFunctionPanel_Hide()
  local self = PaGlobal_InvenAutoSort
  if self == nil then
    return
  end
  self:checkAndHideByMouseOut()
end
