function PaGlobalFunc_ValksList_All_Open()
  if PaGlobal_ValksList_All == nil then
    return
  end
  PaGlobal_ValksList_All:prepareOpen()
end
function PaGlobalFunc_ValksList_All_Close()
  if PaGlobal_ValksList_All == nil then
    return
  end
  PaGlobal_ValksList_All:prepareClose()
end
function PaGlobalFunc_ValksList_All_IsShow()
  if PaGlobal_ValksList_All == nil then
    return
  end
  return Panel_Window_ValksList_All:GetShow()
end
function PaGlobalFunc_ValksList_All_Update()
  if PaGlobal_ValksList_All == nil then
    return
  end
  if PaGlobalFunc_ValksList_All_IsShow() == false then
    return
  end
  PaGlobal_ValksList_All:update()
end
function HandleEventOn_ValksList_ShowTooltip(index, isShow)
  if ToClient_isConsole() == true then
    if isShow == nil then
      isShow = not Panel_Widget_Tooltip_Renew:GetShow()
    end
    if isShow == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, ToClient_GetInventoryEnchantMaterial(index), Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if isShow == false then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
    Panel_Tooltip_Item_Show(ToClient_GetInventoryEnchantMaterial(index), PaGlobal_ValksList_All._ui.stc_titleArea, true, false)
  end
end
