function PaGlobal_ReforgeStonePreset:initialize()
  if PaGlobal_ReforgeStonePreset._initialize == true then
    return
  end
  local titlebarArea = UI.getChildControl(Panel_Window_ReforgeStonePreset_All, "Static_TitleBar")
  self._ui.btn_Close = UI.getChildControl(titlebarArea, "Button_Close")
  local rightArea = UI.getChildControl(Panel_Window_ReforgeStonePreset_All, "Static_RightArea")
  self._ui.list_ReforgeStone = UI.getChildControl(rightArea, "List2_StoneList")
  local listContent = UI.getChildControl(self._ui.list_ReforgeStone, "List2_TotalEvent_Content")
  local listButtonTemplate = UI.getChildControl(listContent, "CheckButton_ItemSkill_Templete")
  local listButtonSlotBG = UI.getChildControl(listButtonTemplate, "Static_ItemSlotBG")
  self._ui.btn_Total = UI.getChildControl(rightArea, "RadioButton_All")
  self._ui.btn_Possessed = UI.getChildControl(rightArea, "RadioButton_Has")
  self._ui.btn_Activated = UI.getChildControl(rightArea, "RadioButton_Active")
  local leftArea = UI.getChildControl(Panel_Window_ReforgeStonePreset_All, "Static_LeftArea")
  local leftTopArea = UI.getChildControl(leftArea, "Static_TopArea")
  local leftButtonArea = UI.getChildControl(leftArea, "Static_ButtonArea")
  self._ui.stc_ActivatedPreset = UI.getChildControl(leftTopArea, "StaticText_ActivatedPreset")
  self._ui.btn_Apply = UI.getChildControl(leftButtonArea, "Button_Apply")
  self._ui.btn_Save = UI.getChildControl(leftButtonArea, "Button_Save")
  self._ui.btn_Clear = UI.getChildControl(leftButtonArea, "Button_ResetPreset")
  self._ui.stc_LeftEffectArea = UI.getChildControl(leftArea, "Static_EffectArea")
  self._ui.stc_WeaponTooltip = UI.getChildControl(self._ui.stc_LeftEffectArea, "Static_Current_Weapon_Tooltip")
  self._ui.btn_TotalEffect = UI.getChildControl(self._ui.stc_LeftEffectArea, "CheckButton_EnchantButton")
  local stc_EffectTitle = UI.getChildControl(self._ui.stc_LeftEffectArea, "StaticText_Current_Weapon")
  local stc_DecoL = UI.getChildControl(self._ui.stc_LeftEffectArea, "Static_DecoLine_L")
  local stc_DecoR = UI.getChildControl(self._ui.stc_LeftEffectArea, "Static_DecoLine_R")
  local decoGap = 20
  local textSizeX = stc_EffectTitle:GetTextSizeX()
  stc_EffectTitle:SetSize(textSizeX, stc_EffectTitle:GetSizeY())
  stc_EffectTitle:SetHorizonCenter()
  stc_DecoL:SetSpanSize(-textSizeX / 2 - decoGap - stc_DecoL:GetSizeX() / 2, stc_DecoL:GetSpanSize().y)
  stc_DecoR:SetSpanSize(textSizeX / 2 + decoGap + stc_DecoR:GetSizeX() / 2, stc_DecoR:GetSpanSize().y)
  local presetNameArea = UI.getChildControl(leftTopArea, "Static_PresetNameArea")
  self._ui.btn_EditName = UI.getChildControl(presetNameArea, "Button_Edit")
  self._ui.stc_TotalEffectList = UI.getChildControl(leftArea, "Static_Show_Total_Effect")
  self._ui.effectDescList[0] = UI.getChildControl(self._ui.stc_TotalEffectList, "StaticText_Effect_0")
  self._ui.stc_LineDeco = UI.getChildControl(self._ui.stc_TotalEffectList, "Static_LineDeco")
  self._totalEffectOriginSizeX = self._ui.stc_TotalEffectList:GetSizeX()
  self:createItemSlot("ReforgeStoneItemIcon_", listButtonSlotBG)
  local weaponArea = UI.getChildControl(leftArea, "Static_WeaponArea")
  self._ui.stc_ActivatedSlotBg = UI.getChildControl(weaponArea, "Static_ReforgeStone_Slot_BG")
  self._ui.stc_ActivateEffect = UI.getChildControl(weaponArea, "Static_Effect")
  self._ui.reforgeSlotList[__eReforgeStoneSlotType_MainWeapon] = UI.getChildControl(weaponArea, "RadioButton_MainWeapon_Slot")
  self._ui.reforgeSlotList[__eReforgeStoneSlotType_AwakenWeapon] = UI.getChildControl(weaponArea, "RadioButton_AwakenWeapon_Slot")
  self._ui.reforgeSlotList[__eReforgeStoneSlotType_SubWeapon] = UI.getChildControl(weaponArea, "RadioButton_SubWeapon_Slot")
  for index = 0, __eReforgeStoneSlotType_Count - 1 do
    local stc_ItemSlot = UI.getChildControl(self._ui.reforgeSlotList[index], "Static_ItemSlot")
    self:createItemSlot("ReforgeSlotItemIcon_" .. tostring(index), stc_ItemSlot)
  end
  self._maxActableStoneCount = ToClient_GetReforgeStoneActableCount()
  self._maxBagSize = ToClient_GetReforgeStoneMaxBagSize()
  local totalEffectSpanSizeY = leftArea:GetSizeY() - (self._ui.stc_LeftEffectArea:GetSpanSize().y + self._ui.btn_TotalEffect:GetSpanSize().y + self._ui.btn_TotalEffect:GetSizeY())
  self._ui.stc_TotalEffectList:SetSpanSize(self._ui.stc_TotalEffectList:GetSpanSize().x, totalEffectSpanSizeY)
  self._isConsole = _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    local presetNameEditKeyGuide = UI.getChildControl(presetNameArea, "Static_Guide_ConsoleUI")
    presetNameEditKeyGuide:SetShow(true)
    self._ui.btn_Close:SetShow(false)
  end
  self:consoleKeyGuideAlign()
  self:validate()
  self:initPresetButtonControls()
  self:initCurrentActivatedControls()
  self:initReforgeStoneList()
  self:initCurrentActiveSkillList()
  self:registEventHandler()
  PaGlobal_ReforgeStonePreset._initialize = true
  if self._isConsole == true then
    self._ui.btn_Close:SetShow(false)
  end
  local languageType = ToClient_getResourceType()
  if languageType ~= nil then
    local languageTypeToString = Defines.LanguageTypeToString[languageType]
    if languageTypeToString ~= nil and (languageTypeToString == "FR" or languageTypeToString == "TR" or languageTypeToString == "DE" or languageTypeToString == "RU") then
      self._exeptionLanguage = true
    end
  end
end
function PaGlobal_ReforgeStonePreset:consoleKeyGuideAlign()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local stc_keyGuideBG = UI.getChildControl(Panel_Window_ReforgeStonePreset_All, "Static_ConsoleKeyGuide")
  self._ui.stc_ConsoleKey_A = UI.getChildControl(stc_keyGuideBG, "StaticText_SelectButton_C")
  self._ui.stc_ConsoleKey_B = UI.getChildControl(stc_keyGuideBG, "StaticText_CancelButton_C")
  self._ui.stc_ConsoleKey_X = UI.getChildControl(stc_keyGuideBG, "StaticText_DetailButton_C")
  if self._isConsole == true then
    local tempBtnGroup = {
      self._ui.stc_ConsoleKey_X,
      self._ui.stc_ConsoleKey_A,
      self._ui.stc_ConsoleKey_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ReforgeStonePreset:createItemSlot(name, control)
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local itemSlot = {}
  SlotItem.new(itemSlot, name, 0, control, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetHorizonCenter()
  itemSlot.icon:SetVerticalMiddle()
  itemSlot.icon:ComputePos()
  return itemSlot
end
function PaGlobal_ReforgeStonePreset:registEventHandler()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_ReforgeStonePreset_Close()")
  self._ui.btn_Total:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeReforgeStoneListType(" .. tostring(self._reforgeStoneListType.total) .. ")")
  self._ui.btn_Possessed:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeReforgeStoneListType(" .. tostring(self._reforgeStoneListType.possessed) .. ")")
  self._ui.btn_Activated:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeReforgeStoneListType(" .. tostring(self._reforgeStoneListType.activated) .. ")")
  self._ui.list_ReforgeStone:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ReforgeStonePreset_All_UpdateList2MatItem")
  self._ui.list_ReforgeStone:createChildContent(__ePAUIList2ElementManagerType_List)
  for index = 0, __eReforgeStoneSlotType_Count - 1 do
    if self._ui.reforgeSlotList[index] ~= nil then
      local stc_ItemSlot = UI.getChildControl(self._ui.reforgeSlotList[index], "Static_ItemSlot")
      local itemSlot = {}
      SlotItem.reInclude(itemSlot, "ReforgeSlotItemIcon_" .. tostring(index), 0, stc_ItemSlot, self._slotConfig)
      itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ReforgeStonePreset_All_ReforgeSlotItemToolTip(" .. tostring(index) .. ", true, false)")
      itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ReforgeStonePreset_All_ReforgeSlotItemToolTip(" .. tostring(index) .. ", false, false)")
      itemSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentSlotType(" .. tostring(index) .. ")")
      self._ui.reforgeSlotList[index]:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentSlotType(" .. tostring(index) .. ")")
      if self._isConsole == true then
        stc_ItemSlot:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ReforgeStonePreset_All_ReforgeSlotItemToolTip(" .. tostring(index) .. ", true, true)")
      end
    end
  end
  self._ui.btn_Save:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_SaveCurrentActiveList()")
  self._ui.btn_Apply:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ApplyCurrentPreset()")
  self._ui.btn_Clear:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ClearCurrentPreset()")
  self._ui.btn_EditName:addInputEvent("Mouse_LUp", "PaGlobalFunc_ReforgePresetNameEdit_Open()")
  self._ui.btn_TotalEffect:addInputEvent("Mouse_LUp", "PaGlobal_ReforgeStonePreset:updateTotalEffectList()")
  self._ui.stc_WeaponTooltip:addInputEvent("Mouse_On", "HandleEventOnOut_ReforgeStonePreset_All_WeaponToolTip(true)")
  self._ui.stc_WeaponTooltip:addInputEvent("Mouse_Out", "HandleEventOnOut_ReforgeStonePreset_All_WeaponToolTip(false)")
  if self._isConsole == true then
    Panel_Window_ReforgeStonePreset_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_ReforgePresetNameEdit_Open()")
  end
  registerEvent("FromClient_UpdateReforgeStoneBag", "FromClient_ReforgeStonePreset_All_UpdateReforgeStoneBag")
  registerEvent("FromClient_UpdateReforgeStoneCurrentActivatedList", "FromClient_ReforgeStonePreset_All_UpdateCurrentActivatedList")
  registerEvent("FromClient_UpdateReforgeStonePresetNo", "FromClient_ReforgeStonePreset_All_UpdateReforgeStonePresetNo")
  registerEvent("FromClient_ClearReforgeStonePreset", "FromClient_ReforgeStonePreset_All_ClearPreset")
  registerEvent("FromClient_SaveReforgeStonePresetName", "FromClient_ReforgeStonePreset_All_UpdatePresetName")
  registerEvent("FromClient_AddReforgeStoneActivateEffect", "FromClient_ReforgeStonePreset_All_AddActivateEffect")
  registerEvent("EventEquipmentUpdate", "FromClient_ReforgeStonePreset_All_UpdateReforgeSlot")
end
function PaGlobal_ReforgeStonePreset:validate()
end
function PaGlobal_ReforgeStonePreset:prepareOpen()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_ReforgeStonePreset:open()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  Panel_Window_ReforgeStonePreset_All:SetShow(true)
end
function PaGlobal_ReforgeStonePreset:prepareClose()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_ReforgeStonePreset:close()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  Panel_Window_ReforgeStonePreset_All:SetShow(false)
end
function PaGlobal_ReforgeStonePreset:update()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._currentPresetNo = ToClient_GetCurrentReforgeStonePresetNo()
  if self._currentPresetNo == -1 then
    self._currentPresetNo = 0
  end
  self._currentSlotType = 0
  self:updateReforgeStonePresetButtons()
  ToClient_SetCurrentActivatedReforgeStone(self._currentPresetNo, self._currentSlotType)
  self._currentReforgeStoneListType = self._reforgeStoneListType.total
  self._ui.btn_Total:SetCheck(true)
  self._ui.btn_Possessed:SetCheck(false)
  self._ui.btn_Activated:SetCheck(false)
  self._ui.btn_TotalEffect:SetCheck(false)
  self:updateReforgeStoneList(false)
  self:refreshReforgeStoneListKey()
  self:updateReforgeSlotControls()
  self:updateCurrentActivatedList()
  self:updateReforgeStonePresetButtonName()
  self:updateCurrentReforgeStonePresetName()
  self:updateTotalEffectList()
  self:updateReforgeSlotApplyActiveCountAll()
  self:addReforgeSlotSelectEffect()
  if self._isConsole == true then
    self._consoleTooltip = false
  end
end
function PaGlobal_ReforgeStonePreset:initPresetButtonControls()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._ui.presetButtonList = {}
  local presetMaxCount = ToClient_GetMaxReforgeStonePresetCount()
  local leftArea = UI.getChildControl(Panel_Window_ReforgeStonePreset_All, "Static_LeftArea")
  local leftTopArea = UI.getChildControl(leftArea, "Static_TopArea")
  local presetButton = UI.getChildControl(leftTopArea, "Button_Preset_0")
  self._ui.presetButtonList[0] = presetButton
  local areaSizeX = leftTopArea:GetSizeX()
  local buttonAreaGap = presetButton:GetSpanSize().x
  local buttonAreaSizeX = areaSizeX - buttonAreaGap * 2
  local buttonGap = 10
  local buttonSizeX = (buttonAreaSizeX - buttonGap * (presetMaxCount - 1)) / presetMaxCount
  presetButton:SetSize(buttonSizeX, presetButton:GetSizeY())
  presetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentPresetNo(" .. tostring(0) .. ")")
  for index = 1, presetMaxCount - 1 do
    local clonedPresetButton = UI.cloneControl(presetButton, leftTopArea, "Button_Preset_" .. index)
    self._ui.presetButtonList[index] = clonedPresetButton
    local prevControl = self._ui.presetButtonList[index - 1]
    local spanSizeX = prevControl:GetSpanSize().x + prevControl:GetSizeX() + buttonGap
    clonedPresetButton:SetSpanSize(spanSizeX, clonedPresetButton:GetSpanSize().y)
    clonedPresetButton:addInputEvent("Mouse_LUp", "HandleEventLUp_ReforgeStonePreset_All_ChangeCurrentPresetNo(" .. tostring(index) .. ")")
  end
end
function PaGlobal_ReforgeStonePreset:initCurrentActivatedControls()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._ui.currentActivatedList = {}
  local slotCount = self._maxActableStoneCount
  local slotArea = self._ui.stc_ActivatedSlotBg
  local activatedSlot = UI.getChildControl(slotArea, "Static_ActivatedSlot_0")
  self._ui.currentActivatedList[0] = activatedSlot
  local areaSizeX = slotArea:GetSizeX()
  local slotGap = 25
  local slotAreaSizeX = activatedSlot:GetSizeX() * slotCount + slotGap * (slotCount - 1)
  local startPanSizeX = areaSizeX / 2 - slotAreaSizeX / 2
  activatedSlot:SetSpanSize(startPanSizeX, activatedSlot:GetSpanSize().y)
  local mouseEvent = "Mouse_RUp"
  if self._isConsole == true then
    mouseEvent = "Mouse_LUp"
  end
  local itemSlot = {}
  SlotItem.new(itemSlot, "ReforgeStoneActivatedListIcon_", 0, activatedSlot, self._slotConfig)
  itemSlot:createChild()
  itemSlot.icon:SetHorizonCenter()
  itemSlot.icon:SetVerticalMiddle()
  itemSlot.icon:ComputePos()
  itemSlot.icon:addInputEvent(mouseEvent, "HandleEventLUp_ReforgeStonePreset_All_RemoveCurrentActivated(" .. tostring(0) .. ")")
  itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ReforgeStonePreset_All_CurrentActivatedShowToolTip(" .. tostring(0) .. ", true, false)")
  itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ReforgeStonePreset_All_CurrentActivatedShowToolTip(" .. tostring(0) .. ",false, false)")
  for index = 1, slotCount - 1 do
    local clonedSlot = UI.cloneControl(activatedSlot, slotArea, "Static_ActivatedSlot_" .. index)
    self._ui.currentActivatedList[index] = clonedSlot
    local prevControl = self._ui.currentActivatedList[index - 1]
    local spanSizeX = prevControl:GetSpanSize().x + prevControl:GetSizeX() + slotGap
    itemSlot = {}
    SlotItem.reInclude(itemSlot, "ReforgeStoneActivatedListIcon_", 0, clonedSlot, self._slotConfig)
    clonedSlot:SetSpanSize(spanSizeX, clonedSlot:GetSpanSize().y)
    itemSlot.icon:addInputEvent(mouseEvent, "HandleEventLUp_ReforgeStonePreset_All_RemoveCurrentActivated(" .. tostring(index) .. ")")
    itemSlot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_ReforgeStonePreset_All_CurrentActivatedShowToolTip(" .. tostring(index) .. ",true)")
    itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_ReforgeStonePreset_All_CurrentActivatedShowToolTip(" .. tostring(index) .. ",false)")
  end
  if self._isConsole == true then
    for index = 0, slotCount - 1 do
      self._ui.currentActivatedList[index]:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOnOut_ReforgeStonePreset_All_CurrentActivatedShowToolTip(" .. tostring(index) .. ", true, true)")
    end
  end
end
function PaGlobal_ReforgeStonePreset:initReforgeStoneList()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._reforgeStoneList = {}
  local reforgeStoneCount = ToClient_GetReforgeStoneItemCount()
  for index = 0, reforgeStoneCount - 1 do
    local itemKey = ToClient_GetReforgeStoneItemKeyByIndex(index)
    local reforgeStoneInfo = {_state = __eReforgeStoneState_None, _slotNo = -1}
    self._reforgeStoneList[itemKey] = reforgeStoneInfo
  end
end
function PaGlobal_ReforgeStonePreset:initCurrentActiveSkillList()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local actableCount = self._maxActableStoneCount
  local weaponDec = UI.getChildControl(self._ui.stc_LeftEffectArea, "Static_CurrentWeapon_Dec")
  local skillTemplate = UI.getChildControl(weaponDec, "Static_ItemSkillName_0")
  self._ui.stc_NoActivateText = UI.getChildControl(weaponDec, "StaticText_NoActivate_Weapon")
  self._ui.currentActiveSkillList[0] = skillTemplate
  local sideGap = skillTemplate:GetSpanSize().x
  local maxCountX = 3
  local controlSizeX = skillTemplate:GetSizeX()
  local controlGapX = (weaponDec:GetSizeX() - sideGap * 2 - controlSizeX * maxCountX) / (maxCountX - 1)
  local controlGapY = 38
  for index = 1, actableCount - 1 do
    local clonedControl = UI.cloneControl(skillTemplate, weaponDec, "Static_ItemSkillName_" .. index)
    self._ui.currentActiveSkillList[index] = clonedControl
    local spanX = sideGap + index % maxCountX * (controlGapX + controlSizeX)
    local spanY = skillTemplate:GetSpanSize().y + controlGapY * math.floor(index / maxCountX)
    clonedControl:SetSpanSize(spanX, spanY)
  end
end
function PaGlobal_ReforgeStonePreset:updateReforgeStoneList(needUpdateList)
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local invenSize = selfPlayer:getInventorySlotCount(false)
  for key, value in pairs(self._reforgeStoneList) do
    value._state = ToClient_GetReforgeStoneState(self._currentSlotType, key)
    value._slotNo = -1
  end
  for invenIdx = 0, invenSize - 1 do
    local slotNo = selfPlayer:getRealInventorySlotNoNew(__eItemWhereTypeInventory, invenIdx)
    if ToClient_CheckUsableReforgeStone(slotNo) == true then
      local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
      if itemWrapper ~= nil then
        local itemEchantSSW = itemWrapper:getStaticStatus():get()
        local itemkey = itemEchantSSW._key:getItemKey()
        if self._reforgeStoneList[itemkey] ~= nil and self._reforgeStoneList[itemkey]._state == __eReforgeStoneState_None then
          self._reforgeStoneList[itemkey]._slotNo = slotNo
        end
      end
    end
  end
  if needUpdateList == true then
    for key, value in pairs(self._reforgeStoneList) do
      self._ui.list_ReforgeStone:requestUpdateByKey(toInt64(0, key))
    end
  end
  if self._isConsole == true then
    self:updateConsoleAKeyText()
  end
end
function PaGlobal_ReforgeStonePreset:refreshReforgeStoneListKey()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._ui.list_ReforgeStone:getElementManager():clearKey()
  local reforgeStoneCount = ToClient_GetReforgeStoneItemCount()
  for index = 0, reforgeStoneCount - 1 do
    local itemKey = ToClient_GetReforgeStoneItemKeyByIndex(index)
    local stoneInfo = self._reforgeStoneList[itemKey]
    if stoneInfo ~= nil and (self._currentReforgeStoneListType == self._reforgeStoneListType.activated and stoneInfo._state == __eReforgeStoneState_Activated or self._currentReforgeStoneListType == self._reforgeStoneListType.possessed and stoneInfo._state == __eReforgeStoneState_InBag or self._currentReforgeStoneListType == self._reforgeStoneListType.total) then
      self._ui.list_ReforgeStone:getElementManager():pushKey(toInt64(0, itemKey))
    end
  end
end
function PaGlobal_ReforgeStonePreset:updateCurrentActivatedList()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local slotCount = self._maxActableStoneCount
  self._ui.stc_NoActivateText:SetShow(true)
  for index = 0, slotCount - 1 do
    local control = self._ui.currentActivatedList[index]
    local skillControl = self._ui.currentActiveSkillList[index]
    local skillTextControl = UI.getChildControl(skillControl, "StaticText_Effect")
    if control ~= nil and skillTextControl ~= nil then
      local itemSlot = {}
      SlotItem.reInclude(itemSlot, "ReforgeStoneActivatedListIcon_", 0, control, self._slotConfig)
      itemSlot:clearItem()
      local itemKey = ToClient_GetCurrentActivatedReforgeStoneByIndex(index)
      if itemKey ~= 0 then
        local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, 0))
        if itemSSW ~= nil then
          itemSlot:setItemByStaticStatus(itemSSW)
        end
      end
      local skillText = self:getSkillTextByItemKey(itemKey)
      if skillText == nil or skillText == "" then
        skillControl:SetShow(false)
      else
        skillText = string.gsub(skillText, "([%+%-]?[%d%.%,%%]+)", "<PAColor0xffffc340>%1<PAOldColor>")
        skillTextControl:SetText(skillText)
        UI.setLimitAutoWrapTextAndAddTooltip(skillTextControl, 2, "", skillText)
        skillControl:SetShow(true)
        self._ui.stc_NoActivateText:SetShow(false)
      end
    end
  end
  self:updateBottomButtons()
  self:updateCurrentPresetTotalBuffDesc()
  self:updateReforgeSlotApplyActiveCountAll()
end
function PaGlobal_ReforgeStonePreset:getSkillTextByItemKey(itemKey)
  if Panel_Window_ReforgeStonePreset_All == nil or itemKey == nil then
    return
  end
  local skillSSW = ToClient_getReforgeStoneSkillByItemKey(itemKey)
  if skillSSW ~= nil then
    local buffCount = skillSSW:getBuffCount()
    local buffText = ""
    for buffIdx = 0, buffCount - 1 do
      local buffName = skillSSW:getBuffDescription(buffIdx)
      if buffName ~= "" then
        if buffText ~= "" then
          buffText = buffText .. " / " .. buffName
        else
          buffText = buffName
        end
      end
    end
    return buffText
  end
end
function PaGlobal_ReforgeStonePreset:setReforgeSlotControl(slotAreaControl, itemSlotName, equipSlotNo, index)
  if Panel_Window_ReforgeStonePreset_All == nil or slotAreaControl == nil or equipSlotNo == nil then
    return
  end
  local stc_ItemSlot = UI.getChildControl(slotAreaControl, "Static_ItemSlot")
  local stc_ItemSlotBG = UI.getChildControl(slotAreaControl, "Static_ItemSlot_BG")
  local itemSlot = {}
  SlotItem.reInclude(itemSlot, itemSlotName, 0, stc_ItemSlot, self._slotConfig)
  itemSlot:clearItem()
  stc_ItemSlotBG:SetShow(true)
  local itemWrapper = ToClient_getEquipmentItem(equipSlotNo)
  if itemWrapper == nil then
    return
  end
  if ToClient_Inventory_CheckItemLock(equipSlotNo, __eItemWhereTypeEquip) == true then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil or itemSSW:get():getContentsEventType() ~= __eContentsType_ItemSkillOption then
    return
  end
  stc_ItemSlotBG:SetShow(false)
  itemSlot:setItemByStaticStatus(itemSSW)
end
function PaGlobal_ReforgeStonePreset:updateReforgeSlotControls()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  for index = 0, __eReforgeStoneSlotType_Count - 1 do
    if self._ui.reforgeSlotList[index] ~= nil then
      self:setReforgeSlotControl(self._ui.reforgeSlotList[index], "ReforgeSlotItemIcon_" .. tostring(index), self._reforgeSlotTypeToEquipSlotNo[index], index)
    end
  end
end
function PaGlobal_ReforgeStonePreset:updateReforgeStonePresetButtons()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local presetMaxCount = ToClient_GetMaxReforgeStonePresetCount()
  for index = 0, presetMaxCount - 1 do
    if self._ui.presetButtonList[index] ~= nil then
      if index == self._currentPresetNo then
        self._ui.presetButtonList[index]:SetCheck(true)
      else
        self._ui.presetButtonList[index]:SetCheck(false)
      end
    end
  end
  self:updateBottomButtons()
end
function PaGlobal_ReforgeStonePreset:updateBottomButtons()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  if self._currentPresetNo == ToClient_GetCurrentReforgeStonePresetNo() then
    self._ui.btn_Apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_DEACTIVESTONE"))
  else
    self._ui.btn_Apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_ACTIVE"))
  end
  if ToClient_CompareCurrentActivatedStoneList(self._currentPresetNo, self._currentSlotType) == false then
    self._ui.btn_Save:SetIgnore(false)
    self._ui.btn_Save:SetMonoTone(false)
    self._needSave = true
    return
  end
  self._ui.btn_Save:SetIgnore(true)
  self._ui.btn_Save:SetMonoTone(true)
  self._needSave = false
end
function PaGlobal_ReforgeStonePreset:addBuffList(totalBuffList, itemKey)
  if Panel_Window_ReforgeStonePreset_All == nil or totalBuffList == nil or itemKey == nil then
    return
  end
  if itemKey == 0 then
    return
  end
  if totalBuffList[itemKey] == nil then
    local skillSSW = ToClient_getReforgeStoneSkillByItemKey(itemKey)
    if skillSSW ~= nil then
      local buffCount = skillSSW:getBuffCount()
      local buffList = {}
      for buffIdx = 0, buffCount - 1 do
        local buffName = skillSSW:getBuffDescription(buffIdx)
        if buffName ~= "" then
          local buffInfo = {_buffName = buffName, _count = 1}
          buffList[buffIdx] = buffInfo
        end
      end
      totalBuffList[itemKey] = buffList
    end
  else
    for index, value in pairs(totalBuffList[itemKey]) do
      value._count = value._count + 1
    end
  end
end
function PaGlobal_ReforgeStonePreset:addBuffDescInfo(descList, buffInfo)
  if Panel_Window_ReforgeStonePreset_All == nil or descList == nil or buffInfo == nil then
    return
  end
  for index, value in ipairs(descList) do
    if value._effectName == buffInfo._effectName then
      value._value = value._value + buffInfo._value
      return
    end
  end
  descList:push_back(buffInfo)
end
function PaGlobal_ReforgeStonePreset:getEffectDescControl(index)
  if Panel_Window_ReforgeStonePreset_All == nil or index < 0 then
    return nil
  end
  if self._ui.effectDescList[0] == nil then
    return nil
  end
  if self._ui.effectDescList[index] ~= nil then
    return self._ui.effectDescList[index]
  end
  local clonedControl = UI.cloneControl(self._ui.effectDescList[0], self._ui.stc_TotalEffectList, "StaticText_Effect_" .. index)
  if clonedControl == nil then
    return nil
  end
  local prevControl = self._ui.effectDescList[index - 1]
  clonedControl:SetSpanSize(clonedControl:GetSpanSize().x, prevControl:GetSpanSize().y + 5 + clonedControl:GetSizeY())
  self._ui.effectDescList[index] = clonedControl
  return clonedControl
end
function PaGlobal_ReforgeStonePreset:updateCurrentPresetTotalBuffDesc()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self:clearTotalEffectDescList()
  local totalBuffList = {}
  for slotType = 0, __eReforgeStoneSlotType_Count - 1 do
    if slotType ~= self._currentSlotType then
      local activatedCount = ToClient_GetActivatedReforgeStoneCount(self._currentPresetNo, slotType)
      for stoneIndex = 0, activatedCount - 1 do
        local itemKey = ToClient_GetActivatedReforgeStoneByIndex(self._currentPresetNo, slotType, stoneIndex)
        self:addBuffList(totalBuffList, itemKey)
      end
    end
  end
  local slotCount = self._maxActableStoneCount
  for index = 0, slotCount - 1 do
    local itemKey = ToClient_GetCurrentActivatedReforgeStoneByIndex(index)
    self:addBuffList(totalBuffList, itemKey)
  end
  local reforgeStoneCount = ToClient_GetReforgeStoneItemCount()
  local descList = Array.new()
  local decimalPoint = "."
  if self._exeptionLanguage == true then
    decimalPoint = ","
  end
  for index = 0, reforgeStoneCount - 1 do
    local itemKey = ToClient_GetReforgeStoneItemKeyByIndex(index)
    local buffList = totalBuffList[itemKey]
    if buffList ~= nil then
      for index, value in pairs(buffList) do
        local valueString = string.match(value._buffName, "%d+%" .. decimalPoint .. "?%d*")
        if self._exeptionLanguage == true then
          valueString = string.gsub(valueString, ",", ".")
        end
        local valueNum = tonumber(valueString)
        if valueNum == nil then
          valueNum = 0
        end
        local buffInfo = {
          _buffName = value._buffName,
          _effectName = string.gsub(value._buffName, "[%d%" .. decimalPoint .. "]+", ""),
          _value = valueNum * value._count
        }
        self:addBuffDescInfo(descList, buffInfo)
      end
    end
  end
  if next(descList) == nil then
    return
  end
  local panelSizeY = 0
  local maxTextSizeX = 0
  for index, value in ipairs(descList) do
    local valueString = tostring(value._value)
    if self._exeptionLanguage == true then
      valueString = string.gsub(valueString, "%.", ",")
    end
    local buffDesc = string.gsub(value._buffName, "%d+%" .. decimalPoint .. "?%d*", valueString)
    buffDesc = string.gsub(buffDesc, "([%+%-]?[%d%" .. decimalPoint .. "%%]+)", "<PAColor0xffffc340>%1<PAOldColor>")
    local textControl = self:getEffectDescControl(index - 1)
    if textControl ~= nil then
      textControl:SetText(buffDesc)
      textControl:SetShow(true)
      maxTextSizeX = math.max(maxTextSizeX, textControl:GetTextSizeX())
      if index == #descList then
        panelSizeY = textControl:GetSpanSize().y + textControl:GetSizeY() + self._effectDescGapY
      end
    end
  end
  self:updateTotalEffectDescSize(maxTextSizeX, panelSizeY + 5)
end
function PaGlobal_ReforgeStonePreset:updateReforgeStonePresetButtonName()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local presetCount = ToClient_GetCurrentReforgeStonePresetCount()
  for index = 0, presetCount - 1 do
    local presetName = ToClient_GetReforgeStonePresetName(index)
    if presetName == nil or presetName == "" then
      presetName = tostring(index + 1)
    end
    self._ui.presetButtonList[index]:SetText(presetName)
    UI.setLimitTextAndAddTooltip(self._ui.presetButtonList[index], "", presetName)
  end
end
function PaGlobal_ReforgeStonePreset:updateCurrentReforgeStonePresetName()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local currentPresetNo = ToClient_GetCurrentReforgeStonePresetNo()
  if currentPresetNo == -1 then
    self._ui.stc_ActivatedPreset:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CRYSTALPRESET_NOPRESET"))
  else
    local presetName = ToClient_GetReforgeStonePresetName(currentPresetNo)
    if presetName == nil or presetName == "" then
      presetName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PRESETTOTAL_TABBUTTON", "number", tostring(currentPresetNo + 1))
    end
    self._ui.stc_ActivatedPreset:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_TOTALPRESET", "presetname", presetName))
  end
end
function PaGlobal_ReforgeStonePreset:updateReforgeSlotApplyActiveCount(slotType)
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  if slotType == nil or slotType < 0 or slotType >= __eReforgeStoneSlotType_Count then
    return
  end
  if self._ui.reforgeSlotList[slotType] == nil then
    return
  end
  local stoneCountControl = UI.getChildControl(self._ui.reforgeSlotList[slotType], "MultilineText_StoneCount")
  if stoneCountControl == nil then
    return
  end
  local activatedCount = 0
  if slotType == self._currentSlotType then
    activatedCount = ToClient_GetCurrentActivatedReforgeStoneCount()
  else
    activatedCount = ToClient_GetActivatedReforgeStoneCount(self._currentPresetNo, slotType)
  end
  local text = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WINDOW_REFORGESTONE_TOTALPRESET_APPLY", "active1", activatedCount, "active2", self._maxActableStoneCount)
  stoneCountControl:SetText(text)
end
function PaGlobal_ReforgeStonePreset:updateReforgeSlotApplyActiveCountAll()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  for slotType = 0, __eReforgeStoneSlotType_Count - 1 do
    self:updateReforgeSlotApplyActiveCount(slotType)
  end
end
function PaGlobal_ReforgeStonePreset:updateTotalEffectList()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  if self._ui.btn_TotalEffect:IsCheck() == false then
    self._ui.stc_TotalEffectList:SetShow(false)
    return
  end
  self:updateCurrentPresetTotalBuffDesc()
  self._ui.stc_TotalEffectList:SetShow(true)
end
function PaGlobal_ReforgeStonePreset:updateTotalEffectDescSize(textSizeX, sizeY)
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  local textGapX = 30
  local lineGapX = 20
  local panelGapX = 25
  local controlSizeX = math.max(textSizeX + textGapX, self._totalEffectOriginSizeX)
  self._ui.stc_TotalEffectList:SetSize(controlSizeX, sizeY)
  self._ui.stc_LineDeco:SetSize(controlSizeX - lineGapX, self._ui.stc_LineDeco:GetSizeY())
  for key, value in pairs(self._ui.effectDescList) do
    value:SetSize(controlSizeX - textGapX, value:GetSizeY())
  end
  self._ui.stc_TotalEffectList:ComputePosAllChild()
  local spanX = -self._ui.btn_TotalEffect:GetSizeX() / 2 - self._ui.stc_TotalEffectList:GetSizeX() / 2 - panelGapX
  self._ui.stc_TotalEffectList:SetSpanSize(spanX, self._ui.stc_TotalEffectList:GetSpanSize().y)
end
function PaGlobal_ReforgeStonePreset:clearTotalEffectDescList()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  for key, value in pairs(self._ui.effectDescList) do
    value:SetShow(false)
  end
  local defaultControl = self._ui.effectDescList[0]
  defaultControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_REFORGESTONE_CHANGE_NOEFFECT"))
  defaultControl:SetShow(true)
  self:updateTotalEffectDescSize(defaultControl:GetTextSizeX(), self._ui.effectDescList[0]:GetSpanSize().y + self._ui.effectDescList[0]:GetSizeY() + self._effectDescGapY + 5)
end
function PaGlobal_ReforgeStonePreset:changeConsoleTooltipShow()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._consoleTooltip = not self._consoleTooltip
  if self._consoleTooltip == false then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
    end
    Panel_Tooltip_Item_hideTooltip()
    return
  end
end
function PaGlobal_ReforgeStonePreset:addActiveEffect(index, isActive)
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  if index == nil or index < 0 or self._ui.currentActivatedList[index] == nil then
    return
  end
  self._ui.stc_ActivateEffect:EraseAllEffect()
  local spanX = self._ui.stc_ActivatedSlotBg:GetPosX() + self._ui.currentActivatedList[index]:GetSpanSize().x
  local spanY = self._ui.stc_ActivatedSlotBg:GetSpanSize().y + self._ui.currentActivatedList[index]:GetSpanSize().y
  local sizeGapX = (self._ui.stc_ActivateEffect:GetSizeX() - self._ui.currentActivatedList[index]:GetSizeX()) / 2
  local sizeGapY = (self._ui.stc_ActivateEffect:GetSizeY() - self._ui.currentActivatedList[index]:GetSizeY()) / 2
  self._ui.stc_ActivateEffect:SetSpanSize(spanX - sizeGapX, spanY - sizeGapY)
  if isActive == true then
    self._ui.stc_ActivateEffect:AddEffect("fUI_ReforgeStone_On_01A", true, 0, 0)
    audioPostEvent_SystemUi(5, 114)
    _AudioPostEvent_SystemUiForXBOX(5, 114)
  else
    self._ui.stc_ActivateEffect:AddEffect("fUI_ReforgeStone_Off_01A", true, 0, 0)
    audioPostEvent_SystemUi(5, 115)
    _AudioPostEvent_SystemUiForXBOX(5, 115)
  end
end
function PaGlobal_ReforgeStonePreset:updateConsoleAKeyText()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  self._ui.stc_ConsoleKey_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  if self._currentSnapSlotIndex ~= nil then
    self._currentSnapItemKey = ToClient_GetCurrentActivatedReforgeStoneByIndex(self._currentSnapSlotIndex)
  end
  if self._currentSnapItemKey == nil or self._reforgeStoneList[self._currentSnapItemKey] == nil then
    return
  end
  if self._reforgeStoneList[self._currentSnapItemKey]._state == __eReforgeStoneState_Activated then
    self._ui.stc_ConsoleKey_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_RELEASE"))
  end
end
function PaGlobal_ReforgeStonePreset:addReforgeSlotSelectEffect()
  if Panel_Window_ReforgeStonePreset_All == nil then
    return
  end
  if self._currentSlotType == nil or self._currentSlotType < 0 or self._ui.reforgeSlotList[self._currentSlotType] == nil then
    return
  end
  for index = 0, __eReforgeStoneSlotType_Count - 1 do
    self._ui.reforgeSlotList[index]:EraseAllEffect()
  end
  self._ui.reforgeSlotList[self._currentSlotType]:AddEffect("fUI_ReforgeStone_Select_01A", true, 0, 0)
end
