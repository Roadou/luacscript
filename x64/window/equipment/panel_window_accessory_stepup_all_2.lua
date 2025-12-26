function PaGlobal_Window_Accessory_StepUp_All_Open()
  if _ContentsGroup_AccessoryStepUp == false then
    return
  end
  if PaGlobal_Window_Accessory_StepUp_All == nil then
    return
  end
  PaGlobal_Window_Accessory_StepUp_All:prepareOpen()
end
function PaGlobal_Window_Accessory_StepUp_All_Close()
  if _ContentsGroup_AccessoryStepUp == false then
    return
  end
  if PaGlobal_Window_Accessory_StepUp_All == nil then
    return
  end
  PaGlobal_Window_Accessory_StepUp_All:prepareClose()
end
function PaGlobal_Window_Accessory_StepUp_All_SelectStepUpAccessory()
  if _ContentsGroup_AccessoryStepUp == false then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  ToClient_RequestSelectAccessoryStepUp(self._completeAccessoryGroupNo + 1, self._selectAccessoryIndex)
end
function PaGlobal_Window_Accessory_StepUp_All_ShowRegistMaterialMessageBox(materialCount, materialIndex, materialSlotNo, itemEnchantKey)
  if _ContentsGroup_AccessoryStepUp == false then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  self._registMaterialIndex = materialIndex
  self._registMaterialCount = Int64toInt32(materialCount)
  self._registMaterialSlotNo = materialSlotNo
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  local contentString = ""
  if materialIndex == __eMaxAccessoryStepUpMaterialCount - 1 then
    local itemName = PaGlobalFunc_Util_GetItemGradeColorName(itemEnchantKey)
    contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EQUIPRESIST_CONFIRM", "itemName", itemName)
  else
    local itemName = itemSSW:getName()
    contentString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_MATERIALREGIST_CONFIRM", "itemName", itemName, "count", self._registMaterialCount)
  end
  local function clickNo()
    self._registMaterialIndex = 0
    self._registMaterialCount = 0
    self._registMaterialSlotNo = -1
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = contentString,
    functionYes = PaGlobal_Window_Accessory_StepUp_All_RegistMaterial,
    functionNo = clickNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_Window_Accessory_StepUp_All_RegistMaterial()
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, self._registMaterialSlotNo)
  if itemWrapper == nil then
    return
  end
  if itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) == true then
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_ACCESSORYSTEPUP_COPYITEM_MATERIAL"),
      functionYes = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
    return
  end
  ToClient_RequestRegistMaterialAccessoryStepUp(self._registMaterialIndex, self._registMaterialSlotNo, self._registMaterialCount)
end
function PaGlobal_Window_Accessory_StepUp_All_ExchangeStepUpAccessory()
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  self._timerNo = nil
  self._audioId = nil
  self._audioIdXbox = nil
  local beforeItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeBeforeIndex)
  local beforeItemslotNo = ToClient_InventoryGetSlotNo(ItemEnchantKey(beforeItemKey, __eMaxAccessoryStepUpEnchantLevel))
  local afterItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeAfterIndex)
  ToClient_RequestExchangeAccessoryStepUp(CppEnums.ItemWhereType.eInventory, beforeItemslotNo, afterItemKey)
end
function PaGloabl_Window_Accessory_StepUp_All_ShowAni()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
end
function PaGloabl_Window_Accessory_StepUp_All_HideAni()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
end
function PaGlobal_Window_Accessory_StepUp_All_BtnMouseEffect(isOn, btnIndex)
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  local btnControl
  if btnIndex == 0 then
    btnControl = self._ui._btn_confirm
  else
    btnControl = self._ui._btn_exchange
  end
  local x1, y1, x2, y2
  btnControl:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
  if isOn == true then
    x1, y1, x2, y2 = setTextureUV_Func(btnControl, self._btnConfirmUV[2].x1, self._btnConfirmUV[2].y1, self._btnConfirmUV[2].x2, self._btnConfirmUV[2].y2)
  else
    x1, y1, x2, y2 = setTextureUV_Func(btnControl, self._btnConfirmUV[1].x1, self._btnConfirmUV[1].y1, self._btnConfirmUV[1].x2, self._btnConfirmUV[1].y2)
  end
  btnControl:getBaseTexture():setUV(x1, y1, x2, y2)
  btnControl:setRenderTexture(btnControl:getBaseTexture())
end
function PaGlobal_Window_Accessory_StepUp_All_GetStepUpAccessory()
  if Panel_Window_Accessory_StepUp_All == nil and Panel_Window_Accessory_StepUp_All:SetShow() == false then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  self._timerNo = nil
  self._audioId = nil
  self._audioIdXbox = nil
  ToClient_RequestAcquireRewardAccessoryStepUp()
end
function PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(isShow, areaType, index, isStepUpGoal, materialIndex, isBefore)
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local control, itemKey, itemSSW
  if areaType == self._eUpdateType._TYPE_SELECT then
    control = UI.getChildControl(self._selectAreaItemList[index], "Static_Item")
    itemKey = ToClient_getAccessoryStepUpItemKey(index + 1)
    itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  elseif areaType == self._eUpdateType._TYPE_STEPUP then
    if isStepUpGoal == true then
      control = self._ui._stc_selectItem_stcItem
      itemKey = ToClient_getAccessoryStepUpItemKey(self._currentAccessoryIndex)
      itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
    elseif materialIndex ~= nil then
      control = UI.getChildControl(self._materialList[index][materialIndex], "Static_Item")
      itemSSW = getItemEnchantStaticStatus(ToClient_getAccessoryStepUpMaterialItemEnchantKey(self._currentAccessoryIndex, index, materialIndex))
    else
      control = UI.getChildControl(self._goalItemList[index], "Static_Item")
      itemKey = ToClient_getAccessoryStepUpItemKey(self._currentAccessoryIndex)
      itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, index + 1))
    end
  elseif areaType == self._eUpdateType._TYPE_EXCHANGE then
    if isBefore ~= nil then
      if isBefore == true then
        control = self._ui._stc_before_stcItem
        itemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeBeforeIndex)
        itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
      else
        control = self._ui._stc_after_stcItem
        itemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeAfterIndex)
        itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
      end
    else
      control = UI.getChildControl(self._exchangeAreaItemList[index], "Static_Item")
      itemKey = ToClient_getAccessoryStepUpItemKey(index + 1)
      itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
    end
  end
  if itemSSW == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemSSW, control, true, false)
  end
end
function PaGlobal_Window_Accessory_StepUp_All_CheckCanGetStepUpAccessory()
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  local completeAccessoryGroupNo = accessoryStepUpManager:getAccessoryCompleteGroupNo()
  local maxAccessoryGroupNo = ToClient_getAccessoryMaxGroupNo()
  if completeAccessoryGroupNo == maxAccessoryGroupNo then
    return false
  end
  return true
end
function PaGlobal_Window_Accessory_StepUp_All_CheckShowStepUpIconEffect()
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  local currentAccessoryGroupNo = accessoryStepUpManager:getAccessoryGroupNo()
  local currentAccessoryIndex = accessoryStepUpManager:getAccessoryIndex()
  local currentEnchantLevel = accessoryStepUpManager:getAccessoryEnchantLevel()
  local completeAccessoryGroupNo = accessoryStepUpManager:getAccessoryCompleteGroupNo()
  local maxAccessoryGroupNo = ToClient_getAccessoryMaxGroupNo()
  if accessoryStepUpManager:isProgressing() == false or currentEnchantLevel == __eMaxAccessoryStepUpEnchantLevel and currentAccessoryGroupNo < maxAccessoryGroupNo and currentAccessoryGroupNo == completeAccessoryGroupNo then
    return true
  end
  for materialIndex = 0, __eMaxAccessoryStepUpMaterialCount - 1 do
    local itemEnchantKey = ToClient_getAccessoryStepUpMaterialItemEnchantKey(currentAccessoryIndex, currentEnchantLevel - 1, materialIndex)
    local materialCount = Int64toInt32(ToClient_InventoryGetItemCount(itemEnchantKey))
    if materialCount > 0 then
      return true
    end
  end
  local materialReadyCount = 0
  for materialIndex = 0, __eMaxAccessoryStepUpMaterialCount - 1 do
    local itemEnchantKey = ToClient_getAccessoryStepUpMaterialItemEnchantKey(currentAccessoryIndex, currentEnchantLevel - 1, materialIndex)
    local materialUseCount = Int64toInt32(accessoryStepUpManager:getMaterialParamCount(materialIndex))
    local materialMaxCount = ToClient_getAccessoryStepUpMaterialNeedCount(currentAccessoryIndex, currentEnchantLevel - 1, materialIndex)
    if materialUseCount == materialMaxCount then
      materialReadyCount = materialReadyCount + 1
    end
  end
  if materialReadyCount == __eMaxAccessoryStepUpMaterialCount then
    return true
  end
  return false
end
function PaGlobal_Window_Accessory_StepUp_All_ShowAchieveNext()
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  self._ui._stc_achieveNext:SetIgnore(false)
  if self._isPadSnapping == true then
    PaGlobal_Window_Accessory_StepUp_All_SetStepUpAreaSnappingIgnore(true)
    ToClient_padSnapChangeToTarget(self._ui._btn_selectNextAccessory)
  end
  self._ui._stc_achieveNext:SetShow(false)
  self._ui._stc_achieveNext:SetColor(Defines.Color.C_00000000)
  local ImageAni = self._ui._stc_achieveNext:addColorAnimation(0, 1.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  ImageAni:SetStartColor(Defines.Color.C_00000000)
  ImageAni:SetEndColor(Defines.Color.C_FFFFFFFF)
  ImageAni.IsChangeChild = true
  self._ui._stc_achieveNext:SetShow(true)
  for completeIndex = 0, self._completeAccessoryGroupNo - 1 do
    local stcAchieveCount = UI.getChildControl(self._ui._stc_achieveNextCountBG, "Static_Achieve_" .. completeIndex .. "")
    stcAchieveCount:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stcAchieveCount, self._stepDotCompleteUv[0].x1, self._stepDotCompleteUv[0].y1, self._stepDotCompleteUv[0].x2, self._stepDotCompleteUv[0].y2)
    stcAchieveCount:getBaseTexture():setUV(x1, y1, x2, y2)
    stcAchieveCount:setRenderTexture(stcAchieveCount:getBaseTexture())
  end
  for notCompleteIndex = self._completeAccessoryGroupNo, self._maxAccessoryGroupNo - 1 do
    local stcAchieveCount = UI.getChildControl(self._ui._stc_achieveNextCountBG, "Static_Achieve_" .. notCompleteIndex .. "")
    stcAchieveCount:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stcAchieveCount, self._stepDotCompleteUv[2].x1, self._stepDotCompleteUv[2].y1, self._stepDotCompleteUv[2].x2, self._stepDotCompleteUv[2].y2)
    stcAchieveCount:getBaseTexture():setUV(x1, y1, x2, y2)
    stcAchieveCount:setRenderTexture(stcAchieveCount:getBaseTexture())
  end
end
function PaGlobal_Window_Accessory_StepUp_All_CheckDoAccessoryStepUp()
  if ToClient_isPremiumCharacter() == true or ToClient_HardCoreChannelWithContensOption() == true then
    return false
  end
  if _ContentsGroup_AccessoryStepUp == true and questList_isClearQuest(11263, 2) == true then
    return true
  end
  return false
end
function PaGlobal_Window_Accessory_StepUp_All_SetStepUpAreaSnappingIgnore(setIgnore)
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  if setIgnore == nil or setIgnore ~= true and setIgnore ~= false then
    return
  end
  self._ui._stc_selectItem:SetIgnore(setIgnore)
  for enchantLevel = 0, __eMaxAccessoryStepUpEnchantLevel - 1 do
    for materialIndex = 0, __eMaxAccessoryStepUpMaterialCount - 1 do
      local materialBg = self._materialList[enchantLevel][materialIndex]
      materialBg:SetIgnore(setIgnore)
    end
    local stcGoalItem = self._goalItemList[enchantLevel]
    stcGoalItem:SetIgnore(setIgnore)
  end
end
function FromClient_UpdateAccessoryStepUp()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  local self = PaGlobal_Window_Accessory_StepUp_All
  if self == nil then
    return
  end
  if self._exchangeBeforeIndex ~= nil and self._exchangeAfterIndex ~= nil then
    local afterItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeAfterIndex)
    local afterItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(afterItemKey, __eMaxAccessoryStepUpEnchantLevel))
    if afterItemSSW ~= nil then
      local itemName = HighAccessoryEnchantLevel_ReplaceString(__eMaxAccessoryStepUpEnchantLevel) .. " " .. afterItemSSW:getName()
      PaGloabl_Widget_Nak_AccessoryStepUp_All_Open(2, itemName)
    end
    self:eraseAllAreaEffect()
    self._exchangeState = self._eExchangeState._STATE_SELECT_BEFORE
    self._exchangeBeforeIndex = nil
    self._exchangeAfterIndex = nil
    self:update(self._eUpdateType._TYPE_EXCHANGE)
  else
    self:update(self._eUpdateType._TYPE_STEPUP)
  end
end
