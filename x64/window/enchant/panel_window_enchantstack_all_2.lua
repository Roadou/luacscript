function PaGlobalFunc_EnchantStack_All_Open(triedStack)
  if Panel_Window_EnchantStack_All == nil then
    return
  end
  PaGlobal_EnchantStack_All:prepareOpen(triedStack)
end
function PaGlobalFunc_EnchantStack_All_Close()
  if Panel_Window_EnchantStack_All == nil or Panel_Window_EnchantStack_All:GetShow() == false then
    return true
  end
  local closeEnchantStack = function()
    PaGlobal_EnchantStack_All:prepareClose()
  end
  if ToClient_GetCurrentEnchantStackIndex() == -1 and ToClient_GetCurrentValksCryIndex() == -1 then
    closeEnchantStack()
    return true
  else
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWEL_NO_CHOICE_CLOSE"),
      functionYes = closeEnchantStack,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, nil, nil, self._isConsole)
    return false
  end
end
function PaGlobalFunc_EnchantStack_Update(resetScroll)
  if Panel_Window_EnchantStack_All == nil or Panel_Window_EnchantStack_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantStack_All:update(resetScroll)
end
function HandleEventLUp_EnchantStack_Slot(index)
  PaGlobal_EnchantStack_All:selectSlot(index)
end
function HandleEventLUp_EnchantStack_Clear()
  if PaGlobal_EnchantStack_All._ui.stc_radioButton_stack:IsCheck() == true then
    ToClient_SetCurrentEnchantStack(-1, 0)
  elseif PaGlobal_EnchantStack_All._ui.stc_radioButton_valksCry:IsCheck() == true then
    ToClient_SetCurrentValksCry(-1, 0)
  end
end
function HandleEventOn_EnchantStack_Slot(index, isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      local slot = PaGlobal_EnchantStack_All._listItemSlots[index]
      if slot ~= nil then
        slot.icon:EraseAllEffect()
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetEnchantStackForLua(index - 1), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    local slot = PaGlobal_EnchantStack_All._listItemSlots[index]
    if slot ~= nil then
      slot.icon:EraseAllEffect()
    end
    Panel_Tooltip_Item_Show(ToClient_GetEnchantStackForLua(index - 1), PaGlobal_EnchantStack_All._ui.stc_titleArea, true, false)
  end
end
function HandleEventLUp_EnchantStack_SetItemSlots()
  PaGlobal_EnchantStack_All:setItemSlots()
end
function HandleEventRUp_EnchantStack_CheckBox(index)
  PaGlobal_EnchantStack_All:setCheckBox(index)
end
function PaGlobal_EnchantStack_UpdateSelectList(contents, key)
  PaGlobal_EnchantStack_All:updateSelectList(contents, key)
end
function PaGlobalFunc_EnchantStack_All_ListClose()
  PaGlobal_EnchantStack_All._ui.stc_subSelectBG:SetShow(false)
end
function HandleEventLUp_EnchantStack_All_SetCurrentEnchantStack(count, index)
  PaGlobal_EnchantStack_All:setCurrentEnchantStack(count, index)
end
function HandleEventLUp_EnchantStack_All_Apply()
  PaGlobal_EnchantStack_All:apply()
end
function PaGlobalFunc_EnchantStack_All_ChangeTab()
  if PaGlobal_EnchantStack_All._ui.stc_radioButton_stack:IsCheck() == true then
    PaGlobal_EnchantStack_All._ui.stc_radioButton_stack:SetCheck(false)
    PaGlobal_EnchantStack_All._ui.stc_radioButton_valksCry:SetCheck(true)
  else
    PaGlobal_EnchantStack_All._ui.stc_radioButton_stack:SetCheck(true)
    PaGlobal_EnchantStack_All._ui.stc_radioButton_valksCry:SetCheck(false)
  end
  PaGlobal_EnchantStack_All:update(true)
end
function PaGlobalFunc_EnchantStack_All_ChangeTabByType(isValksCryTab)
  PaGlobal_EnchantStack_All:changeTab(isValksCryTab)
end
function PaGlobalFunc_EnchantStack_All_HandleOthersChoiceTooltip(isShow)
  PaGlobal_EnchantStack_All:handleOthersChoiceTooltip(isShow)
end
