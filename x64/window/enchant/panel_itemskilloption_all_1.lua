function PaGlobalFunc_ItemSkillOption_All_Open()
  if _ContentsGroup_ItemSkillOption == false or _ContentsGroup_ReforgeStonePreset == true then
    return
  end
  PaGlobal_ItemSkillOption_All:prepareOpen()
end
function PaGlobalFunc_ItemSkillOption_All_Close()
  PaGlobal_ItemSkillOption_All:prepareClose()
end
function FromClient_ItemSkillOption_All_UpdateItemList()
  if Panel_Window_ItemSkillOption_All:GetShow() == false then
    return
  end
  PaGlobal_ItemSkillOption_All:clearAllLeftItemSlot()
  PaGlobal_ItemSkillOption_All:update()
  PaGlobal_ItemSkillOption_All:updateMatItem()
end
function PaGlobal_ItemSkillOption_All_isImprove()
  return PaGlobal_ItemSkillOption_All._doImprove
end
function HandleEventOnOut_ItemSkillOption_All_AniSkipToolTip(isShow)
end
function HandleEventLUp_ItemSkillOption_All_DoImprove()
  local self = PaGlobal_ItemSkillOption_All
  if true == self._doImprove then
    self._ui._stc_improvementSlotBg:EraseAllEffect()
    self._targetItemSlot.icon:EraseAllEffect()
    self._materialSlot.icon:EraseAllEffect()
    self._doImprove = false
    audioPostEvent_SystemUi(5, 99)
    _AudioPostEvent_SystemUiForXBOX(5, 99)
    self._ui._chk_skipAni:SetIgnore(false)
    return
  end
  if self._toApplySkillOptionIndex == -1 then
    for idx = 1, #self._appliedSkillOptionCtrlList do
      if self._appliedSkillOptionCtrlList[idx]._rdoBtn:IsCheck() == true then
        self._toApplySkillOptionIndex = idx
        break
      end
    end
  end
  if self._equipSlotNo == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTMATERIAL"))
    return
  end
  if self._materialSlotNo == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_RECOVERY_GUIDE_SELECTMATERIAL"))
    return
  end
  if true == self._ui._chk_skipAni:IsCheck() then
    ToClient_requestUpdateItemSkillOption(self._equipSlotNo, self._materialSlotNo, self._toApplySkillOptionIndex - 1)
    self._targetItemSlot.icon:EraseAllEffect()
    self._targetItemSlot.icon:AddEffect("fUI_ItemEnchant_01A", false, 0, 0)
    self._doImprove = false
    self._doAnimation = false
    self._animationTime = 0
    self._ui._stc_improvementSlotBg:EraseAllEffect()
    self._materialSlot.icon:EraseAllEffect()
    self._ui._chk_skipAni:SetIgnore(false)
    return
  else
    self._ui._stc_improvementSlotBg:EraseAllEffect()
    self._targetItemSlot.icon:EraseAllEffect()
    self._materialSlot.icon:EraseAllEffect()
    self._ui._stc_improvementSlotBg:AddEffect("fUI_Improvement_01A", true, 20, 0)
    audioPostEvent_SystemUi(5, 6)
    _AudioPostEvent_SystemUiForXBOX(5, 6)
    audioPostEvent_SystemUi(5, 50)
    _AudioPostEvent_SystemUiForXBOX(5, 50)
    self._ui._chk_skipAni:SetIgnore(true)
  end
  self._animationTime = 0
  self._doImprove = true
end
function FromClient_ItemSkillOption_All_UpdateList2MatItem(content, key)
  local btn_list = UI.getChildControl(content, "RadioButton_EnchantItemList")
  local stc_slotBg = UI.getChildControl(btn_list, "Static_EnchantItemSlotBg")
  local stc_slot = UI.getChildControl(btn_list, "Static_EnchantItemSlot")
  local txt_name = UI.getChildControl(btn_list, "StaticText_EnchantItemName")
  local txt_count = UI.getChildControl(btn_list, "StaticText_EnchantItemSlotText")
  local stc_tooltipSlot = UI.getChildControl(content, "Static_TooltipSlot")
  local _key = Int64toInt32(key)
  local itemSSW, itemKey, slotIdx
  local itemCnt = 0
  local slot = {}
  SlotItem.reInclude(slot, "ItemSkillOption_MaterialSlot_", 0, stc_slot, PaGlobal_ItemSkillOption_All._slotConfig)
  slot:clearItem()
  btn_list:addInputEvent("Mouse_LUp", "")
  btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  stc_tooltipSlot:addInputEvent("Mouse_LUp", "")
  if PaGlobal_ItemSkillOption_All._equipSlotNo == -1 then
    if PaGlobal_ItemSkillOption_All._defaultMaterialItemKey[_key] == nil then
      return
    end
    local defaultItemKey = PaGlobal_ItemSkillOption_All._defaultMaterialItemKey[_key]._itemKey
    local wrapper = getItemEnchantStaticStatus(ItemEnchantKey(defaultItemKey, 0))
    if nil ~= wrapper then
      itemSSW = wrapper
      itemCnt = PaGlobal_ItemSkillOption_All._defaultMaterialItemKey[_key]._count
      slot:setItemByStaticStatus(wrapper)
      if false == _ContentsGroup_UsePadSnapping then
        stc_tooltipSlot:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTipSSW(" .. tostring(_key) .. ",true)")
        stc_tooltipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTipSSW(" .. tostring(_key) .. ",false)")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_ItemSkillOption_All_ShowToolTipSSW(" .. tostring(_key) .. ",true)")
      end
    end
  else
    if nil == PaGlobal_ItemSkillOption_All._materialList[_key] then
      return
    end
    slotIdx = PaGlobal_ItemSkillOption_All._materialList[_key]
    local wrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotIdx)
    if nil ~= wrapper then
      itemSSW = wrapper:getStaticStatus()
      slot:setItemByStaticStatus(itemSSW)
      itemCnt = Int64toInt32(wrapper:get():getCount_s64())
      if false == _ContentsGroup_UsePadSnapping then
        stc_tooltipSlot:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
        stc_tooltipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false)")
      else
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
      end
    end
  end
  if nil == itemSSW then
    return
  end
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetText(itemSSW:getName())
  if -1 == PaGlobal_ItemSkillOption_All._equipSlotNo then
    txt_name:SetFontColor(Defines.Color.C_FF5A5A5A)
  else
    PAGlobalFunc_SetItemTextColor(txt_name, itemSSW)
  end
  btn_list:setNotImpactScrollEvent(true)
  btn_list:SetCheck(false)
  if 0 == itemCnt then
    btn_list:SetMonoTone(true)
    slot.icon:SetMonoTone(true)
    txt_name:SetMonoTone(true)
    txt_count:SetShow(false)
  else
    txt_count:SetShow(true)
    txt_count:SetText(itemCnt)
    btn_list:SetMonoTone(false)
    slot.icon:SetMonoTone(false)
    txt_name:SetMonoTone(false)
    txt_count:SetMonoTone(false)
    if -1 ~= PaGlobal_ItemSkillOption_All._materialSlotNo and PaGlobal_ItemSkillOption_All._materialSlotNo == PaGlobal_ItemSkillOption_All._materialList[_key] then
      local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, PaGlobal_ItemSkillOption_All._materialSlotNo)
      if nil ~= itemWrapper then
        local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
        txt_count:SetText(itemCount)
        btn_list:SetCheck(true)
      end
    end
    if nil ~= slotIdx then
      if false == _ContentsGroup_UsePadSnapping then
        stc_tooltipSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_SelectMaterial(" .. slotIdx .. ")")
        btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_SelectMaterial(" .. slotIdx .. ")")
      else
        btn_list:SetIgnore(false)
        btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ItemSkillOption_All_SelectMaterial(" .. slotIdx .. ")")
      end
    end
  end
end
function FromClient_ItemSkillOption_All_UpdateList2TargetItem(content, key)
  local btn_list = UI.getChildControl(content, "RadioButton_EquipList")
  local stc_slotBg = UI.getChildControl(btn_list, "Static_EquipListSlotBg")
  local stc_slot = UI.getChildControl(btn_list, "Static_EquipListSlot")
  local txt_name = UI.getChildControl(btn_list, "StaticText_EquipName")
  local txt_equiped = UI.getChildControl(btn_list, "StaticText_EquipSlotText")
  local _key = Int64toInt32(key)
  if nil == PaGlobal_ItemSkillOption_All._equipList[_key] then
    return
  end
  local slotIdx = PaGlobal_ItemSkillOption_All._equipList[_key]
  local itemWrapper
  local slot = {}
  SlotItem.reInclude(slot, "ItemSkillOption_TargetItemSlot_", 0, stc_slot, PaGlobal_ItemSkillOption_All._slotConfig)
  slot:clearItem()
  if _key <= PaGlobal_ItemSkillOption_All._indexInvenEnd then
    itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotIdx)
    slot:setItem(itemWrapper)
    local itemKey = itemWrapper:get():getKey():getItemKey()
    txt_equiped:SetShow(false)
    txt_equiped:SetIgnore(true)
    txt_equiped:addInputEvent("Mouse_LUp", "")
    if false == _ContentsGroup_UsePadSnapping then
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_SelectEquipment(" .. slotIdx .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false)")
    else
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ItemSkillOption_All_SelectEquipment(" .. slotIdx .. ")")
      if false == _ContentsGroup_RenewUI then
        btn_list:registerPadEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false)")
      end
    end
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_SelectEquipment(" .. slotIdx .. ")")
  else
    itemWrapper = ToClient_getEquipmentItem(slotIdx)
    slot:setItem(itemWrapper)
    local itemKey = itemWrapper:get():getKey():getItemKey()
    txt_equiped:SetShow(true)
    txt_equiped:SetIgnore(false)
    if false == _ContentsGroup_UsePadSnapping then
      btn_list:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_EquipmentRelese(" .. slotIdx .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true, true )")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false, true)")
    else
      btn_list:SetIgnore(false)
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true, true )")
      btn_list:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_ItemSkillOption_All_EquipmentRelese(" .. slotIdx .. ")")
      if false == ToClient_isConsole() then
        btn_list:registerPadEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false)")
      end
    end
    slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_EquipmentRelese(" .. slotIdx .. ")")
  end
  if nil == itemWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local itemGrade = itemSSW:getGradeType()
  local fontColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  txt_name:SetTextMode(__eTextMode_AutoWrap)
  txt_name:SetFontColor(fontColor)
  txt_name:SetText(itemSSW:getName())
  PAGlobalFunc_SetItemTextColor(txt_name, itemSSW)
  btn_list:setNotImpactScrollEvent(true)
  btn_list:SetCheck(false)
end
function HandleEventRUp_ItemSkillOption_All_SlotInit()
  local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, PaGlobal_ItemSkillOption_All._equipSlotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
  if true == PaGlobal_ItemSkillOption_All._doImprove then
    PaGlobal_ItemSkillOption_All._ui._stc_improvementSlotBg:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._materialSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._doImprove = false
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_RenewUI_Tooltip and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_ItemSkillOption_All:clearAllLeftItemSlot()
  PaGlobal_ItemSkillOption_All:updateForDefaultMatItem()
end
function HandleEventLUp_ItemSkillOption_All_SelectEquipment(slotIdx)
  if nil == slotIdx then
    return
  end
  if true == PaGlobal_ItemSkillOption_All._doImprove then
    return
  end
  HandleEventRUp_ItemSkillOption_All_SlotInit()
  local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotIdx)
  if nil == itemWrapper then
    return
  end
  PaGlobal_ItemSkillOption_All._targetItemSlot:clearItem()
  PaGlobal_ItemSkillOption_All._targetItemSlot:setItem(itemWrapper)
  PaGlobal_ItemSkillOption_All._equipSlotNo = slotIdx
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if false == _ContentsGroup_UsePadSnapping then
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false)")
  else
    PaGlobal_ItemSkillOption_All._ui._stc_targetItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
    PaGlobal_ItemSkillOption_All._ui._stc_targetItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ItemSkillOption_All_SlotInit()")
  end
  PaGlobal_ItemSkillOption_All._targetItemSlot.icon:EraseAllEffect()
  PaGlobal_ItemSkillOption_All._targetItemSlot.icon:AddEffect("UI_ItemJewel", false, 0, 0)
  local itemStatic = itemWrapper:getStaticStatus():get()
  if nil ~= itemStatic then
    audioPostEvent_SystemItem(itemStatic._itemMaterial)
  end
  PaGlobal_ItemSkillOption_All:updateAppliedItemSkill(itemWrapper)
  PaGlobal_ItemSkillOption_All:updateMatItem()
end
function HandleEventOnOut_ItemSkillOption_All_ShowToolTipSSW(keyIndex, isShow, isEquip)
  if nil == keyIndex then
    return
  end
  if PaGlobal_ItemSkillOption_All._defaultMaterialItemKey[keyIndex] == nil then
    return
  end
  if false == isShow or nil == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local defaultItemKey = PaGlobal_ItemSkillOption_All._defaultMaterialItemKey[keyIndex]._itemKey
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(defaultItemKey, 0))
  if nil == itemWrapper then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_ItemSkillOption_All, true)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventOnOut_ItemSkillOption_All_ShowToolTip(slotIdx, isShow, isEquip)
  if nil == slotIdx then
    return
  end
  if false == isShow or nil == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper
  if true == isEquip then
    itemWrapper = ToClient_getEquipmentItem(slotIdx)
  else
    itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotIdx)
  end
  if nil == itemWrapper then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_Show(itemWrapper, Panel_Window_ItemSkillOption_All, false, true)
  else
    if true == PaGlobalFunc_TooltipInfo_GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  end
end
function HandleEventLUp_ItemSkillOption_All_EquipmentRelese(slotNo)
  if nil == slotNo then
    return
  end
  if false == _ContentsGroup_RenewUI_InventoryEquip then
    if true == _ContentsGroup_NewUI_Equipment_All then
      HandleEventRUp_Equipment_All_EquipSlotRClick(slotNo)
    else
      Equipment_RClick(slotNo)
    end
  else
    InputMRUp_InventoryInfo_EquipSlot(slotNo)
  end
end
function HandleEventLUp_ItemSkillOption_All_SelectMaterial(slotIdx)
  if nil == slotIdx then
    return
  end
  if true == PaGlobal_ItemSkillOption_All._doImprove then
    return
  end
  local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotIdx)
  if nil == itemWrapper then
    return
  end
  local self = PaGlobal_ItemSkillOption_All
  self._materialSlot:clearItem()
  self._materialSlot:setItem(itemWrapper)
  self._materialSlotNo = slotIdx
  if false == _ContentsGroup_UsePadSnapping then
    self._materialSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
    self._materialSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",false)")
    self._materialSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ItemSkillOption_All_SlotInit()")
  else
    self._ui._stc_materialSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotIdx .. ",true)")
    self._ui._stc_materialSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ItemSkillOption_All_SlotInit()")
  end
  self._materialSlot.icon:EraseAllEffect()
  self._materialSlot.icon:AddEffect("UI_ItemJewel", false, 0, 0)
  audioPostEvent_SystemUi(0, 16)
  _AudioPostEvent_SystemUiForXBOX(0, 16)
  local itemSS = itemWrapper:getStaticStatus()
  local skillNo = itemSS:getContentsEventParam1()
  local skillLv = itemSS:getContentsEventParam2()
  local hasEmptySlot = false
  local hasUpperSkill = false
  self._toApplySkillOptionIndex = -1
  for idx = 1, #self._appliedSkillOptionCtrlList do
    self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetMonoTone(true, true)
    self._appliedSkillOptionCtrlList[idx]._txt:SetMonoTone(true, true)
    self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetIgnore(true)
    self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetCheck(false)
    if self._appliedSkillOptionCtrlList[idx]._skillNo == -1 then
      hasEmptySlot = true
    end
    if self._appliedSkillOptionCtrlList[idx]._skillNo == skillNo then
      hasUpperSkill = true
    end
  end
  if hasUpperSkill == true then
    for idx = 1, #self._appliedSkillOptionCtrlList do
      if self._appliedSkillOptionCtrlList[idx]._skillNo == skillNo then
        self._toApplySkillOptionIndex = idx
        break
      end
    end
  elseif hasEmptySlot == true then
    for idx = 1, #self._appliedSkillOptionCtrlList do
      if self._appliedSkillOptionCtrlList[idx]._skillNo == -1 then
        self._toApplySkillOptionIndex = idx
        break
      end
    end
  else
    for idx = 1, #self._appliedSkillOptionCtrlList do
      self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetMonoTone(false, false)
      self._appliedSkillOptionCtrlList[idx]._txt:SetMonoTone(false, false)
      self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetIgnore(false)
      ToClient_padSnapIgnoreMoveToThisControl(self._ui._stc_activeEffect, false)
    end
  end
  if self._toApplySkillOptionIndex ~= -1 then
    self._appliedSkillOptionCtrlList[self._toApplySkillOptionIndex]._rdoBtn:SetMonoTone(false, false)
    self._appliedSkillOptionCtrlList[self._toApplySkillOptionIndex]._rdoBtn:SetMonoTone(false, false)
    if hasEmptySlot == false then
      self._appliedSkillOptionCtrlList[self._toApplySkillOptionIndex]._rdoBtn:SetIgnore(false)
      ToClient_padSnapIgnoreMoveToThisControl(self._ui._stc_activeEffect, false)
    end
    self._appliedSkillOptionCtrlList[self._toApplySkillOptionIndex]._rdoBtn:SetCheck(true)
  end
  PaGlobal_ItemSkillOption_All._ui._list2_MatItem:requestUpdateVisible()
end
function FromClient_ItemSkillOptionAll_UpdatePerframe(deltaTime)
  PaGlobal_ItemSkillOption_All._animationTime = PaGlobal_ItemSkillOption_All._animationTime + deltaTime
  if true == PaGlobal_ItemSkillOption_All._doImprove then
    PaGlobal_ItemSkillOption_All._ui._keyGuide_DoEnchant_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_CANCELBUTTON"))
    PaGlobal_ItemSkillOption_All._ui._btn_DoEnchant:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_CANCELBUTTON"))
  else
    PaGlobal_ItemSkillOption_All._ui._keyGuide_DoEnchant_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_BUTTON"))
    PaGlobal_ItemSkillOption_All._ui._btn_DoEnchant:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_BUTTON"))
  end
  if true == PaGlobal_ItemSkillOption_All._doAnimation then
    PaGlobal_ItemSkillOption_All._ui._btn_DoEnchant:SetIgnore(true)
    PaGlobal_ItemSkillOption_All._ui._keyGuide_DoEnchant_Y:SetMonoTone(true)
    Panel_Window_ItemSkillOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  else
    PaGlobal_ItemSkillOption_All._ui._btn_DoEnchant:SetIgnore(false)
    PaGlobal_ItemSkillOption_All._ui._keyGuide_DoEnchant_Y:SetMonoTone(false)
    Panel_Window_ItemSkillOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ItemSkillOption_All_DoImprove()")
  end
  if PaGlobal_ItemSkillOption_All._animationPlayTime < PaGlobal_ItemSkillOption_All._animationTime and true == PaGlobal_ItemSkillOption_All._doImprove then
    ToClient_requestUpdateItemSkillOption(PaGlobal_ItemSkillOption_All._equipSlotNo, PaGlobal_ItemSkillOption_All._materialSlotNo, PaGlobal_ItemSkillOption_All._toApplySkillOptionIndex - 1)
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:AddEffect("fUI_ItemEnchant_01A", false, 0, 0)
    PaGlobal_ItemSkillOption_All._ui._chk_skipAni:SetIgnore(false)
    PaGlobal_ItemSkillOption_All._doImprove = false
    PaGlobal_ItemSkillOption_All._doAnimation = true
    PaGlobal_ItemSkillOption_All._animationTime = 0
  end
  if PaGlobal_ItemSkillOption_All._animationTime > 3 and true == PaGlobal_ItemSkillOption_All._doAnimation then
    PaGlobal_ItemSkillOption_All._animationTime = 0
    PaGlobal_ItemSkillOption_All._ui._stc_improvementSlotBg:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._materialSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._doAnimation = false
  end
end
function PaGlobalFunc_ItemSkillOption_GetSkillDesc(itemWrapper, delims)
  local buffText = ""
  if itemWrapper == nil then
    return buffText
  end
  local appliedSkillCount = itemWrapper:getAppliedItemSkillOptionCount()
  for idx = 1, appliedSkillCount do
    local skillWrapper = itemWrapper:getAppliedItemSkillOptionByIndex(idx - 1)
    if skillWrapper ~= nil then
      local buffCount = skillWrapper:getBuffCount()
      for buffIdx = 0, skillWrapper:getBuffCount() - 1 do
        local buffName = skillWrapper:getBuffDescription(buffIdx)
        if buffName ~= "" then
          if buffText ~= "" then
            buffText = buffText .. tostring(delims) .. buffName
          else
            buffText = buffName
          end
        end
      end
    end
  end
  return buffText
end
function FromClient_ResponseUpdateItemSkillOption(slotNo)
  if Panel_Window_ItemSkillOption_All:GetShow() == false then
    return
  end
  PaGlobal_ItemSkillOption_All:clearAllLeftItemSlot()
  PaGlobal_ItemSkillOption_All:update()
  local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
  if itemWrapper ~= nil then
    PaGlobal_ItemSkillOption_All._targetItemSlot:setItem(itemWrapper)
    local itemKey = itemWrapper:get():getKey():getItemKey()
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:addInputEvent("Mouse_LUp", "")
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotNo .. ",true)")
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_ShowToolTip(" .. slotNo .. ",false)")
    PaGlobal_ItemSkillOption_All._equipSlotNo = slotNo
    audioPostEvent_SystemUi(5, 22)
    _AudioPostEvent_SystemUiForXBOX(5, 22)
  end
  PaGlobal_ItemSkillOption_All:updateAppliedItemSkill()
  PaGlobal_ItemSkillOption_All:updateMatItem()
end
