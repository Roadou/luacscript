function PaGlobalFunc_StackExtraction_All_Open()
  if Panel_Window_Enchant_StackExtraction_All == nil or Panel_Window_Enchant_StackExtraction_All:GetShow() == true then
    return
  end
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  PaGlobal_StackExtraction_All:prepareOpen()
end
function PaGlobalFunc_StackExtraction_All_Close()
  if Panel_Window_Enchant_StackExtraction_All == nil or Panel_Window_Enchant_StackExtraction_All:GetShow() == false then
    return
  end
  PaGlobal_StackExtraction_All:prepareClose()
end
function PaGlobalFunc_StackExtraction_All_Execution()
  if PaGlobal_StackExtraction_All._ui.btn_skipAnimation:IsCheck() == true then
    PaGlobal_StackExtraction_All:resetAnimation()
    PaGlobal_StackExtraction_All:requestExtraction()
    return
  end
  PaGlobal_StackExtraction_All:startExtraction()
end
function PaGlobalFunc_StackExtraction_All_UpdateFuncCheckAni(deltaTime)
  if PaGlobal_StackExtraction_All._isEnchantAnim == false then
    return
  end
  PaGlobal_StackExtraction_All._animTime = PaGlobal_StackExtraction_All._animTime + deltaTime
  if PaGlobal_StackExtraction_All._animTime > PaGlobal_StackExtraction_All._ANIM_LENGTH then
    PaGlobal_StackExtraction_All:resetAnimation()
    PaGlobal_StackExtraction_All:requestExtraction()
  end
end
function FromClient_UpdateStackExtraction()
  PaGlobal_StackExtraction_All:update()
end
function HandleEventOn_StackExtraction_BookSlot(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetCurrentExtractionBookForLua(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    if isShow == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    Panel_Tooltip_Item_Show(ToClient_GetCurrentExtractionBookForLua(), PaGlobal_StackExtraction_All._bookSlot.icon, true, false)
  end
end
function HandleEventOn_StackExtraction_ValksAdviceSlot(isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetCurrentExtractableValksAdviceForLua(), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == nil then
      isShow = not Panel_Tooltip_Item:GetShow()
    end
    if isShow == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    Panel_Tooltip_Item_Show(ToClient_GetCurrentExtractableValksAdviceForLua(), PaGlobal_StackExtraction_All._valksAdviceSlot.icon, true, false)
  end
end
function HandleEventOn_StackExtraction_ReleaseBook()
  ToClient_ClearStackExtraction()
  PaGlobal_StackExtraction_All:update()
end
function PaGlobalFunc_StackExtraction_All_HandleExecutionButton()
  PaGlobal_StackExtraction_All:handleExecutionButton()
end
function PaGlobalFunc_StackExtraction_All_FilterForBookExtraction(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local failCount = getSelfPlayer():get():getEnchantFailCount()
  if CppEnums.ContentsEventType.ContentsType_ConvertEnchantFailCountToItem == itemSSW:get():getContentsEventType() then
    local maxEnchantParam = itemSSW:getContentsEventParam1()
    return failCount > maxEnchantParam
  else
    return true
  end
end
function PaGlobalFunc_StackExtraction_All_RClickForEnchantTargetItem(slotNo, itemWrapper, count, inventoryType)
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    return
  end
  if nil == itemWrapper then
    return
  end
  local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedForDuel then
    return
  end
  PaGlboalFunc_StackExtractiont_All_SetExtractionItemBook(slotNo, inventoryType)
end
function PaGlboalFunc_StackExtractiont_All_SetExtractionItemBook(slotNo, inventoryType)
  ToClient_SetExtractionItemBook(slotNo, inventoryType)
  PaGlobal_StackExtraction_All:update()
end
