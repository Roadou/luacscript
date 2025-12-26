function PaGlobal_ArtifactsExchangeLog_Open()
  PaGlobal_ArtifactsExchangeLog:prepareOpen()
end
function PaGlobal_ArtifactsExchangeLog_Close()
  PaGlobal_ArtifactsExchangeLog:prepareClose()
end
function HandleEventLUp_ArtifactsExchangeLog_DoExchange()
  PaGlobal_ArtifactsExchangeLog:prepareClose()
  PaGlobalFunc_ArtifactExchange_Excute()
end
function PaGlobal_ArtifactsExchangeLog_ControlCreate(content, key)
  local slotNo = Int64toInt32(key)
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemName = UI.getChildControl(content, "StaticText_ItemName")
  local itemSlotBg = UI.getChildControl(content, "Static_SlotBg")
  local nameColorGrade = itemSSW:getGradeType()
  if 0 == nameColorGrade then
    itemName:SetFontColor(4292925656)
  elseif 1 == nameColorGrade then
    itemName:SetFontColor(4290110555)
  elseif 2 == nameColorGrade then
    itemName:SetFontColor(4284724988)
  elseif 3 == nameColorGrade then
    itemName:SetFontColor(4294951744)
  elseif 4 == nameColorGrade then
    itemName:SetFontColor(4293815895)
  else
    itemName:SetFontColor(Defines.Color.C_FFC4C4C4)
  end
  itemName:SetText(itemSSW:getName())
  local slot = {}
  SlotItem.reInclude(slot, "Artifact_Slot_", 0, itemSlotBg, PaGlobal_ArtifactsExchangeLog._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(itemSSW)
  slot.icon:addInputEvent("Mouse_On", "PaGlobal_ArtifactsExchangeLog_ToolTip( true, " .. slotNo .. ")")
  slot.icon:addInputEvent("Mouse_Out", "PaGlobal_ArtifactsExchangeLog_ToolTip( false )")
end
function PaGlobal_ArtifactsExchangeLog_ToolTip(isShow, slotNo)
  if true == isShow then
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, slotNo)
    if nil == itemWrapper then
      return
    end
    local itemSSW = itemWrapper:getStaticStatus()
    if _ContentsGroup_RenewUI_Tooltip == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    else
      Panel_Tooltip_Item_Show(itemSSW, Panel_Window_Artifacts_Exchange_LOG_All, true)
    end
  elseif false == isShow then
    if _ContentsGroup_RenewUI_Tooltip == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
  end
end
