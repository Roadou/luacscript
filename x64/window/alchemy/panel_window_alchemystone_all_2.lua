function PaGlobalFunc_AlchemyStone_All_Open()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:prepareOpen()
end
function PaGlobalFunc_AlchemyStone_All_Close()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:prepareClose()
end
function PaGlobalFunc_AlchemyStone_All_IsShow()
  if Panel_Window_AlchemyStone_All == nil then
    return nil
  end
  return Panel_Window_AlchemyStone_All:GetShow()
end
function HandleEventRUp_AlchemyStone_UnSetSlot(slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == PaGlobal_AlchemyStone_All._isPushDoit then
    return
  end
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:chargeTab_UnSetSlot(slotType)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:expTab_UnSetSlot(slotType)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == PaGlobal_AlchemyStone_All._selectedTabIdx then
    PaGlobal_AlchemyStone_All:upgradeTab_UnSetSlot(slotType)
  end
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(true)
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(false)
  PaGlobal_AlchemyStone_All._resultItemKey = {}
  PaGlobal_AlchemyStone_All._resultItemIndex = -1
  if nil ~= Panel_Tooltip_Item_hideTooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandleEventLUp_AlchemyStone_All_SelectTab(tabType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:selectTab(tabType)
end
function HandleEventLUp_AlchemyStone_Doit()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local doUpgrade = function()
    if PaGlobal_AlchemyStone_All._ui.chk_skipAni:IsCheck() == true then
      PaGlobal_AlchemyStone_All._isPushDoit = false
      Panel_AlchemyStone_All_DoItSkipAni()
    else
      PaGlobal_AlchemyStone_All._isPushDoit = true
    end
    Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGrade = itemSSW:getGradeType()
  local itemContentsParam2 = itemSSW:get()._contentsEventParam2
  local msgTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_TITLE")
  local msgContent = ""
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
    if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
      return
    end
    if itemContentsParam2 + 1 <= Int64toInt32(PaGlobal_AlchemyStone_All._fromCount) then
      PaGlobal_AlchemyStone_All._isPushDoit = true
      Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_WARN_2"))
    end
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
    if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
      return
    end
    local alchemystoneExp = itemWrapper:getExperience() * 1.0E-4
    if alchemystoneExp >= 150 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPMAX_WARRING"))
      return
    end
    PaGlobal_AlchemyStone_All._isPushDoit = true
    Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
    if PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
      return
    end
    if 0 ~= checkToEvolveAlchemyStone() then
      return
    end
    if 3 == itemContentsParam2 or 4 == itemContentsParam2 then
      msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT1")
    elseif 5 == itemContentsParam2 or 6 == itemContentsParam2 then
      msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT2")
    elseif 7 == itemContentsParam2 then
      if itemGrade < 3 then
        msgContent = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSGBOX_CONTENT2")
      end
    else
      PaGlobal_AlchemyStone_All._isPushDoit = true
      Inventory_SetFunctor(PaGlobal_AlchemyStone_All_MaterialFilterAllNot, nil, nil, nil)
    end
    if "" ~= msgContent then
      local messageBoxData = {
        title = msgTitle,
        content = msgContent,
        functionYes = doUpgrade,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, "middle")
    end
  end
  if PaGlobal_AlchemyStone_All._isPushDoit == true and PaGlobal_AlchemyStone_All._ui.chk_skipAni:IsCheck() == true then
    PaGlobal_AlchemyStone_All._isPushDoit = false
    Panel_AlchemyStone_All_DoItSkipAni()
  end
  PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:SetShow(true)
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(PaGlobal_AlchemyStone_All._isPushDoit)
  PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(true ~= PaGlobal_AlchemyStone_All._isPushDoit)
  audioPostEvent_SystemUi(1, 43)
  _AudioPostEvent_SystemUiForXBOX(1, 43)
end
function HandleEventOnOut_AlchemyStone_ResultItemTooltip(isShow, index)
  if nil == Panel_Window_AlchemyStone_All or true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
    Panel_Tooltip_Item_Show(resultItemWrapper, PaGlobal_AlchemyStone_All._resultSlot[index].icon, true, false, nil, nil, nil)
  end
end
function HandlePadEventXUp_AlchemyStone_ResultItemTooltip(index)
  if nil == Panel_Window_AlchemyStone_All or false == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), index)
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, resultItemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
  end
end
function HandleEventOnOut_AlchemyStone_ItemToolTip(isShow, slotType)
  if nil == Panel_Window_AlchemyStone_All or true == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if true == isShow then
    local control, itemWrapper
    if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
      control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon
      if -1 ~= PaGlobal_AlchemyStone_All._toWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
      else
        return
      end
    else
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == PaGlobal_AlchemyStone_All._selectedTabIdx then
        if PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
          return
        end
        control = PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == PaGlobal_AlchemyStone_All._selectedTabIdx or PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == PaGlobal_AlchemyStone_All._selectedTabIdx then
        if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
          return
        end
        control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      end
      if -1 ~= PaGlobal_AlchemyStone_All._fromWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo)
        Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
      else
        return
      end
    end
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function HandlePadEventXUp_AlchemyStone_ItemToolTip(slotType)
  if nil == Panel_Window_AlchemyStone_All or false == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if nil ~= PaGlobalFunc_TooltipInfo_GetShow and false == PaGlobalFunc_TooltipInfo_GetShow() then
    local control, itemWrapper
    if slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE then
      control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon
      if -1 ~= PaGlobal_AlchemyStone_All._toWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
      else
        return
      end
    elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT then
      if PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty then
        return
      end
      control = PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon
      if -1 ~= PaGlobal_AlchemyStone_All._fromWhereType then
        itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo)
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
      else
        return
      end
    elseif slotType == PaGlobal_AlchemyStone_All._SLOT_TYPE.BLACKSTONE then
      local itemWrapper
      itemWrapper = getInventoryItemByType(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._blackStonSlotNo)
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    end
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function HandleEventOnOut_AlchemyStone_CheckSlotType(isOn, slotType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if true == isOn then
    PaGlobal_AlchemyStone_All._currentSlotType = slotType
  end
end
function HandlePadEventLBUp_MoveTab(direction)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:Console_MoveTab(direction)
end
function HandlePadEventAUp_OpenInventory()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:console_OpenInventory()
end
function FromClient_ItemUpgrade_All(itemwhereType, slotNo, exp)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if PaGlobal_AlchemyStone_All._TAB_TYPE.EXP ~= PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(itemwhereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  local itemName = itemWrapper:getStaticStatus():getName()
  local mainMsg = itemName .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_DONE_EXP")
  local subMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_EXP") .. string.format("%.2f", itemWrapper:getExperience() / 10000) .. "%"
  local iconPath = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  local iconUV = float4(0, 0, 42, 42)
  ToClient_RequestNakMessageRenewelWithStringAndIcon(__eNakMessage_AlchemyStoneGrindingSuccess, mainMsg, subMsg, iconPath, iconUV)
  PaGlobal_AlchemyStone_All._ui._recharge.progress_curExp:SetProgressRate(itemWrapper:getExperience() / 10000)
  local _exp = string.format("%.2f", itemWrapper:getExperience() / 10000)
  PaGlobal_AlchemyStone_All._ui._recharge.txt_expValue:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPERIENCE", "exp", _exp))
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
end
function FromClient_AlchemyRepair_All(whereType, slotNo)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, Int64toInt32(slotNo))
  if nil ~= itemWrapper then
    local itemSSW = itemWrapper:getStaticStatus()
    local itemName = itemSSW:getName()
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_CHARGE_COMPLETE_ACK", "itemName", itemName))
    if PaGlobal_AlchemyStone_All._ui.chk_skipAni:IsCheck() == false then
      PaGlobal_AlchemyStone_All:clearData(true)
    elseif PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE ~= tabType then
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
    end
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStone_All_InvenMatRClick, nil, nil)
    PaGlobal_AlchemyStone_All:UpdateStone(whereType, slotNo)
  end
end
function FromClient_StoneChange_All(whereType, slotNo)
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemName = itemSSW:getName()
  local itemKey = itemSSW:get()._key:getItemKey()
  local mainMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE")
  local subMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE2", "itemName", itemName)
  local iconPath = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  local iconUV = float4(0, 0, 42, 42)
  ToClient_RequestNakMessageRenewelWithStringAndIcon(__eNakMessage_AlchemyStoneGrowUpSuccess, mainMsg, subMsg, iconPath, iconUV)
  for index = 0, #PaGlobal_AlchemyStone_All._resultItemKey do
    if itemKey == PaGlobal_AlchemyStone_All._resultItemKey[index] then
      PaGlobal_AlchemyStone_All._resultItemIndex = index
    end
  end
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function FromClient_StoneChangeFailedByDown_All(whereType, slotNo)
  if _ContentsGroup_AlchemyStoneRenewal == true then
    return
  end
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return
  end
  local itemName = itemWrapper:getStaticStatus():getName()
  local mainMsg = PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL")
  local subMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_FAIL2", "itemName", itemName)
  local iconPath = "Icon/" .. itemWrapper:getStaticStatus():getIconPath()
  local iconUV = float4(0, 0, 42, 42)
  ToClient_RequestNakMessageRenewelWithStringAndIcon(__eNakMessage_AlchemyStoneGrowUpFail, mainMsg, subMsg, iconPath, iconUV)
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function FromClient_AlchemyEvolve_All(evolveType)
  if _ContentsGroup_AlchemyStoneRenewal == true then
    return
  end
  if nil == Panel_Window_AlchemyStone_All or not Panel_Window_AlchemyStone_All:GetShow() then
    return
  end
  if -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return
  end
  if PaGlobal_AlchemyStone_All._ui.chk_skipAni:IsCheck() == true then
    PaGlobal_AlchemyStone_All:clearData(false)
    PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetSize(PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:GetSizeX(), PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginSizeY)
    PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetPosY(PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginPosY)
    PaGlobal_AlchemyStone_All._elapsedCenterEffectTime = 3
  end
  local guideString = ""
  local resultString = ""
  if 0 == evolveType then
    guideString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_0")
    resultString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_EXPDOWN")
  elseif 1 == evolveType then
    guideString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_1")
    resultString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_STONEDESTROY")
  elseif 2 == evolveType then
    guideString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_2")
    resultString = "<PAColor0xffd05d48>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_GRADEDOWN")
  elseif 3 == evolveType then
    guideString = "<PAColor0xffd8ad70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_UPGRADERESULT_3")
    resultString = "<PAColor0xfff5ba3a>" .. PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_MSG_DONE")
  end
  guideString = guideString .. "<PAOldColor>"
  resultString = resultString .. "<PAOldColor>"
  PaGlobal_AlchemyStone_All._ui.txt_guideNormal:SetText(guideString)
  if evolveType < 3 then
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetText(resultString)
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetShow(true)
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:EraseAllEffect()
    PaGlobal_AlchemyStone_All._ui._growth.txt_fail:AddEffect("fUI_Alchemy_Development_Text_Fail_01A", false)
    audioPostEvent_SystemUi(5, 23)
    _AudioPostEvent_SystemUiForXBOX(5, 23)
  else
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetText(resultString)
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetShow(true)
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:EraseAllEffect()
    PaGlobal_AlchemyStone_All._ui._growth.txt_success:AddEffect("fUI_Alchemy_Development_Text_Success_01A", false)
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
  end
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
function AlchemyStone_onScreenResize()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:resize()
end
function PaGlobalFunc_AlchemyStone_All_PreCheckOtherUI()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if nil ~= Panel_AlchemyFigureHead_All and true == Panel_AlchemyFigureHead_All:GetShow() then
    PaGlobal_AlchemyFigureHead_All_Close()
  end
  if ToClient_isConsole() == false and true == Panel_Window_Manufacture_All:GetShow() then
    PaGlobalFunc_Manufacture_All_Close()
  end
  if _ContentsGroup_NewUI_Dye_Palette_All then
    if nil ~= Panel_Window_Dye_Palette_All and Panel_Window_Dye_Palette_All:GetShow() then
      PaGlobal_Dye_Palette_All_Close()
    end
  elseif nil ~= Panel_DyePalette and Panel_DyePalette:GetShow() then
    FGlobal_DyePalette_Close()
  end
  if _ContentsGroup_LightStoneBag == true and PaGlobalFunc_LightStoneBag_IsShow ~= nil and PaGlobalFunc_LightStoneBag_IsShow() == true then
    PaGlobalFunc_LightStoneBag_Close()
  end
end
function PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local returnValue = true
  if nil == itemWrapper or nil == itemWrapper:getStaticStatus() then
    return returnValue
  end
  local isAlchemyBellHeart = function(alchemyStoneType, contentsEventParam2)
    if 6 == alchemyStoneType or 7 == alchemyStoneType then
      return true
    end
    return false
  end
  if 32 == itemWrapper:getStaticStatus():get():getContentsEventType() then
    local alchemyStoneType = itemWrapper:getStaticStatus():get()._contentsEventParam1
    local contentsEventParam2 = itemWrapper:getStaticStatus():get()._contentsEventParam2
    if PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE then
      if true == isAlchemyBellHeart(alchemyStoneType, contentsEventParam2) then
        return true
      end
      if 7 == contentsEventParam2 then
        returnValue = true
      else
        returnValue = false
      end
      local isItemLocked = ToClient_Inventory_CheckItemLock(slotNo, inventoryType)
      if isItemLocked then
        returnValue = true
      end
      local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
      if true == isDuplicatedForDuel then
        return true
      end
    elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE then
      if itemWrapper:isChargeableAlchemyStone() == true then
        if itemWrapper:get():getEndurance() == itemWrapper:get():getMaxEndurance() then
          returnValue = true
        else
          returnValue = false
        end
      else
        return true
      end
    elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.EXP then
      if true == isAlchemyBellHeart(alchemyStoneType, contentsEventParam2) then
        return true
      end
      local isDuplicatedForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
      if true == isDuplicatedForDuel then
        return true
      end
      returnValue = false
    end
  end
  return returnValue
end
function PaGlobal_AlchemyStone_All_MaterialFilterAllNot(slotNo, itemWrapper, count, inventoryType)
  return true
end
function PaGlobalFunc_AlchemyStone_All_InvenStoneRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:invenStoneRClick(slotNo, itemWrapper, count, inventoryType)
end
function PaGlobalFunc_AlchemyStone_All_SetInvenFilterMat(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local returnValue = true
  if nil == itemWrapper then
    return returnValue
  end
  local staticStatus = itemWrapper:getStaticStatus()
  local key = itemWrapper:get():getKey()
  if nil == staticStatus or -1 == PaGlobal_AlchemyStone_All._selectedTabIdx then
    return returnValue
  end
  if PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE then
    if staticStatus:isAlchemyRepair(PaGlobal_AlchemyStone_All._selectedStoneType) then
      returnValue = false
    end
  elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.EXP then
    if staticStatus:isAlchemyUpgradeItem(PaGlobal_AlchemyStone_All._selectedStoneType) then
      returnValue = false
    end
  elseif PaGlobal_AlchemyStone_All._selectedTabIdx == PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE and staticStatus:isAlchemyUpgradeMaterial(PaGlobal_AlchemyStone_All._selectedStoneItemKey) then
    if nil ~= key then
      PaGlobal_AlchemyStone_All._blackStonSlotNo = ToClient_InventoryGetSlotNo(key)
    end
    returnValue = false
  end
  return returnValue
end
function PaGlobalFunc_AlchemyStone_All_InvenMatRClick(slotNo, itemWrapper, count, inventoryType)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  PaGlobal_AlchemyStone_All:invenMatRClick(slotNo, itemWrapper, count, inventoryType)
end
function PaGlobalFunc_AlchemyStone_All_Use()
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  local itemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoAlchemyStone)
  if nil ~= itemWrapper and 0 < itemWrapper:get():getEndurance() then
    useAlchemyStone()
  end
end
function Panel_AlchemyStone_All_UpdateTime(deltaTime)
  if nil == Panel_Window_AlchemyStone_All then
    return
  end
  if PaGlobal_AlchemyStone_All._elapsedCenterEffectTime > 0 then
    PaGlobal_AlchemyStone_All._elapsedCenterEffectTime = PaGlobal_AlchemyStone_All._elapsedCenterEffectTime - deltaTime
    if PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:GetShow() == false then
      PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:SetShow(true)
    end
    if PaGlobal_AlchemyStone_All._elapsedCenterEffectTime <= 0 then
      PaGlobal_AlchemyStone_All._elapsedCenterEffectTime = 0
      PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:SetShow(false)
      PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetShow(false)
      PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetShow(false)
    end
  end
  if PaGlobal_AlchemyStone_All._isPushDoit then
    PaGlobal_AlchemyStone_All._elapsTime = PaGlobal_AlchemyStone_All._elapsTime + deltaTime
    local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
    if PaGlobal_AlchemyStone_All._skipEffect == true and PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
      if -1 ~= PaGlobal_AlchemyStone_All._fromWhereType and -1 ~= PaGlobal_AlchemyStone_All._fromSlotNo then
        local Rate = ToClient_GetAlchemyUpgradeRate(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
      end
      alchemyEvolve(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
      PaGlobal_AlchemyStone_All._isPushDoit = false
      PaGlobal_AlchemyStone_All:clearData(false)
      Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
      PaGlobal_AlchemyStone_All._isUpgrade = false
      PaGlobal_AlchemyStone_All._elapsTime = 0
    end
    if 0 < PaGlobal_AlchemyStone_All._elapsTime and false == PaGlobal_AlchemyStone_All._startEffectPlay then
      PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetMonoTone(true)
      PaGlobal_AlchemyStone_All._ui_pc.btn_apply:SetEnable(false)
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:EraseAllEffect()
      PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Grind_R_Slot_01A", false, 3, 0)
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        PaGlobal_AlchemyStone_All._resultSlotBg[0]:AddEffect("fUI_Alchemy_Development_R_Slot_01A", false)
        PaGlobal_AlchemyStone_All._resultSlotBg[1]:AddEffect("fUI_Alchemy_Development_R_Slot_01A", false)
        PaGlobal_AlchemyStone_All._resultSlotBg[2]:AddEffect("fUI_Alchemy_Development_R_Slot_01A", false)
      else
        if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
          PaGlobal_AlchemyStone_All._ui._recharge.txt_needCount:SetShow(false)
        end
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:EraseAllEffect()
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].icon:AddEffect("fUI_Alchemy_Grind_L_Slot_01A", false)
      end
      PaGlobal_AlchemyStone_All._startEffectPlay = true
      if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType or PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
        audioPostEvent_SystemUi(5, 80)
        _AudioPostEvent_SystemUiForXBOX(5, 80)
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        audioPostEvent_SystemUi(5, 81)
        _AudioPostEvent_SystemUiForXBOX(5, 81)
      end
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeEffect:AddEffect("fUI_Alchemy_Development_L_Slot_01A", false)
      end
      PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetIgnore(true)
      PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetMonoTone(true)
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 1 and false == PaGlobal_AlchemyStone_All._contentEffectPlay then
      PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:EraseAllEffect()
      local effectName = ""
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        effectName = "fUI_Alchemy_Development_01A"
      else
        effectName = "fUI_Alchemy_grind_01A"
      end
      PaGlobal_AlchemyStone_All._ui.stc_CenterEffect:AddEffect(effectName, false, 0, -30)
      PaGlobal_AlchemyStone_All._contentEffectPlay = true
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 2.5 and false == PaGlobal_AlchemyStone_All._slotEffectPlay then
      if PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Stone_Upgrade02", false)
      end
      PaGlobal_AlchemyStone_All._slotEffectPlay = true
      if PaGlobal_AlchemyStone_All._ui.radio_Upgrade:IsCheck() then
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
      end
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 3 and false == PaGlobal_AlchemyStone_All._effectEnd then
      PaGlobal_AlchemyStone_All._effectEnd = true
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 5 and PaGlobal_AlchemyStone_All._elapsTime < 9 then
      if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE ~= tabType then
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
        PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
      end
      if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
        alchemyRepair(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo, PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._fromCount)
        PaGlobal_AlchemyStone_All._elapsTime = 0
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
        alchemyUpgrade(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._fromCount, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        PaGlobal_AlchemyStone_All._elapsTime = 0
        PaGlobal_AlchemyStone_All._isPushDoit = false
        PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetIgnore(false)
        PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetMonoTone(false)
        Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
        PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetIgnore(false)
        PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetMonoTone(false)
      elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
        alchemyEvolve(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
        PaGlobal_AlchemyStone_All._elapsTime = 9
      end
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 9.5 and false == PaGlobal_AlchemyStone_All._isUpgrade then
      if -1 < PaGlobal_AlchemyStone_All._resultItemIndex then
        PaGlobal_AlchemyStone_All._resultSlotBg[PaGlobal_AlchemyStone_All._resultItemIndex]:AddEffect("fUI_Alchemy_Development_Succes_Slot_01A", false)
      else
        PaGlobal_AlchemyStone_All._growthSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Development_Fail_Slot_01A", false)
      end
      PaGlobal_AlchemyStone_All._isUpgrade = true
    end
    if PaGlobal_AlchemyStone_All._elapsTime > 12 and PaGlobal_AlchemyStone_All._isUpgrade then
      PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetSize(PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:GetSizeX(), PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginSizeY)
      PaGlobal_AlchemyStone_All._ui._growth.stc_upgradeSlotBg:SetPosY(PaGlobal_AlchemyStone_All._upgradeSlotBg_OriginPosY)
      PaGlobal_AlchemyStone_All._ui._growth.txt_success:SetShow(false)
      PaGlobal_AlchemyStone_All._ui._growth.txt_fail:SetShow(false)
      PaGlobal_AlchemyStone_All._isPushDoit = false
      PaGlobal_AlchemyStone_All:clearData(false)
      Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
      PaGlobal_AlchemyStone_All._isUpgrade = false
      PaGlobal_AlchemyStone_All._elapsTime = 0
      PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetIgnore(false)
      PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetMonoTone(false)
    end
  else
    PaGlobal_AlchemyStone_All._elapsTime = 0
    PaGlobal_AlchemyStone_All._isUpgrade = false
    PaGlobal_AlchemyStone_All._startEffectPlay = false
    PaGlobal_AlchemyStone_All._contentEffectPlay = false
    PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetIgnore(false)
    PaGlobal_AlchemyStone_All._ui.chk_skipAni:SetMonoTone(false)
  end
  if false == PaGlobal_AlchemyStone_All._isConsole then
    for idx = 1, #PaGlobal_AlchemyStone_All._radioTabs do
      PaGlobal_AlchemyStone_All._radioTabs[idx]:SetEnable(not PaGlobal_AlchemyStone_All._isPushDoit)
    end
  else
    PaGlobal_AlchemyStone_All._ui_console.stc_guideIconA:SetShow(not PaGlobal_AlchemyStone_All._isPushDoit)
    PaGlobal_AlchemyStone_All:setKeyGuideAlign()
  end
end
function Panel_AlchemyStone_All_DoItSkipAni()
  if PaGlobal_AlchemyStone_All._ui.chk_skipAni:IsCheck() == false then
    return
  end
  local tabType = PaGlobal_AlchemyStone_All._selectedTabIdx
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
    PaGlobal_AlchemyStone_All._ui._recharge.txt_needCount:SetShow(false)
  end
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE == tabType then
    alchemyRepair(PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo, PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._fromCount)
    audioPostEvent_SystemUi(5, 96)
    _AudioPostEvent_SystemUiForXBOX(5, 96)
    PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Grind_Shot_01A", false, 3, 0)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.EXP == tabType then
    alchemyUpgrade(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._fromCount, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
    audioPostEvent_SystemUi(5, 96)
    _AudioPostEvent_SystemUiForXBOX(5, 96)
    PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.STONE].icon:AddEffect("fUI_Alchemy_Grind_Shot_01A", false, 3, 0)
  elseif PaGlobal_AlchemyStone_All._TAB_TYPE.UPGRADE == tabType then
    alchemyEvolve(PaGlobal_AlchemyStone_All._fromWhereType, PaGlobal_AlchemyStone_All._fromSlotNo, PaGlobal_AlchemyStone_All._toWhereType, PaGlobal_AlchemyStone_All._toSlotNo)
  end
  if PaGlobal_AlchemyStone_All._TAB_TYPE.CHARGE ~= tabType then
    PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT]:clearItem()
    PaGlobal_AlchemyStone_All._rechargeSlot[PaGlobal_AlchemyStone_All._SLOT_TYPE.MAT].Empty = true
  end
  Inventory_SetFunctor(PaGlobalFunc_AlchemyStone_All_SetInvenFilterStone, PaGlobalFunc_AlchemyStone_All_InvenStoneRClick, nil, nil)
end
