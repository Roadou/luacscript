function PaGlobalFunc_SimpleInventory_SearchResult_Open()
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  if PaGlobalFunc_SimpleInventory_SearchResult_GetShow() == true then
    PaGlobalFunc_SimpleInventory_SearchResult_Close()
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SimpleInventory_SearchResult_Close()
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_SimpleInventory_SearchResult_GetShow()
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return nil
  end
  local panel = Panel_Window_SimpleInventory_SearchResult
  if panel == nil then
    return nil
  end
  return panel:GetShow()
end
function PaGlobal_SimpleInventory_SearchResult_List2Update(content, key)
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  local index = Int64toInt32(key)
  local itemWrapper = ToClient_SimpleSearchItemWrapper(index)
  if nil == itemWrapper then
    return
  end
  local txt_element = UI.getChildControl(content, "StaticText_SearchElement")
  local characterName = itemWrapper:getCharacterName()
  local itemEnchantKey = itemWrapper:getItemEnchantKey()
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemSSW then
    return
  end
  local itemName = PaGlobalFunc_Util_GetItemGradeColorName(itemEnchantKey, false)
  txt_element:SetText(characterName .. " > " .. itemName)
  UI.setLimitTextAndAddTooltip(txt_element)
  if self._isConsole == true then
    txt_element:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_SimpleInventory_SearchResult_ClickCheckSort()")
  end
  txt_element:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory_SearchResult:gotoSlot(" .. tostring(index) .. ")")
end
function PaGlobalFunc_SimpleInventory_SearchResult_ShowSimpleToolTip(tooltipType, isShow)
  if nil == Panel_Window_SimpleInventory_SearchResult then
    return
  end
  TooltipSimple_Hide()
  if false == isShow then
    return
  end
  local tooltipData = PaGlobal_SimpleInventory_SearchResult._SIMPLE_TOOLTIP_DATA[tooltipType]
  if nil == tooltipData then
    return
  end
  if nil == tooltipData.control then
    return
  end
  TooltipSimple_Show(tooltipData.control, tooltipData.name, tooltipData.desc)
end
function PaGlobalFunc_SimpleInventory_SearchResult_DoSearchByConsole(str)
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  self._ui._edit_control:SetEditText(str)
  self:doSearch()
end
function PaGlobalFunc_SimpleInventory_SearchResult_SetFocusEdit()
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  SetFocusEdit(self._ui._edit_control)
end
function PaGlobalFunc_SimpleInventory_SearchResult_ClickCheckSort()
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  local isChecked = self._ui._check_sort:IsCheck()
  self._ui._check_sort:SetCheck(not isChecked)
  self:doSearch()
end
function PaGlobalFunc_SimpleInventory_SearchResult_UpdateWhenTransportToMyBag()
  local self = PaGlobal_SimpleInventory_SearchResult
  if self == nil then
    return
  end
  local str = self._ui._edit_control:GetEditText()
  self:reset()
  self._ui._edit_control:SetEditText(str)
  self:doSearch()
end
