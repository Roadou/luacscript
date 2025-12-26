function PaGlobal_AutoUseBuffItem:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._currentPresetIndex = ToClient_getAutoUseItemPresetIndex()
  self._presetMaxSize = ToClient_getAutoUseItemPresetMaxSize()
  self:initialize_titleArea()
  self:initialize_topArea()
  self:initialize_mainArea()
  self:initialize_descArea()
  self:initialize_bottomArea()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_AutoUseBuffItem:initialize_titleArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._ui._stc_titleArea = UI.getChildControl(Panel_Window_AutoBuff, "Static_TitleArea")
  local titleName = UI.getChildControl(self._ui._stc_titleArea, "StaticText_TitleIcon")
  local btnClose = UI.getChildControl(self._ui._stc_titleArea, "Button_Win_Close")
  if self._isConsole == true then
    btnClose:SetShow(false)
  else
    btnClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_AutoUseBuffItem_Close()")
    btnClose:SetShow(true)
  end
end
function PaGlobal_AutoUseBuffItem:initialize_topArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._ui._stc_topArea = UI.getChildControl(Panel_Window_AutoBuff, "Static_TopArea")
  self._ui._btn_onOffToggle = UI.getChildControl(self._ui._stc_topArea, "CheckButton_OnOff")
  self._ui._stc_toggleStateText = UI.getChildControl(self._ui._stc_topArea, "StaticText_Text_State")
  self._ui._stc_checkCountText = UI.getChildControl(self._ui._stc_topArea, "StaticText_SelectItemCount")
  self._ui._btn_clearPreset = UI.getChildControl(self._ui._stc_topArea, "Button_Reset")
  self._ui._btn_checkSafeRegion = UI.getChildControl(self._ui._stc_topArea, "CheckButton_Saftyzone")
  self._ui._btn_checkSafeRegion:SetShow(_ContentsGroup_AutoUseBuffSafeRegionCheck)
  self._presetButtonList = Array.new()
  for presetIndex = 0, self._presetMaxSize - 1 do
    self._presetButtonList[presetIndex] = UI.getChildControl(self._ui._stc_topArea, "RadioButton_Preset_" .. tostring(presetIndex))
    self._presetButtonList[presetIndex]:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_ClickPresetButton(" .. tostring(presetIndex) .. ")")
    self._presetButtonList[presetIndex]:addInputEvent("Mouse_On", "HandleEventLOnOut_AutoUseBuffItem_ShowSimpleTooltip(true, 1," .. tostring(presetIndex) .. ")")
    self._presetButtonList[presetIndex]:addInputEvent("Mouse_Out", "HandleEventLOnOut_AutoUseBuffItem_ShowSimpleTooltip(false, 1," .. tostring(presetIndex) .. ")")
    if self._currentPresetIndex == presetIndex then
      self._presetButtonList[presetIndex]:SetCheck(true)
    else
      self._presetButtonList[presetIndex]:SetCheck(false)
    end
    if _ContentsGroup_AutoUseBuffSafeRegionCheck == false then
      self._presetButtonList[presetIndex]:SetSpanSize(self._presetButtonList[presetIndex]:GetSpanSize().x, self._presetButtonList[presetIndex]:GetSpanSize().y + self._ui._btn_checkSafeRegion:GetSizeY())
    end
  end
  if _ContentsGroup_AutoUseBuffSafeRegionCheck == false then
    self._ui._btn_clearPreset:SetSpanSize(self._ui._btn_clearPreset:GetSpanSize().x, self._ui._btn_clearPreset:GetSpanSize().y + self._ui._btn_checkSafeRegion:GetSizeY())
  end
  self._ui._btn_onOffToggle:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_ToggleAutoUseMode()")
  self._ui._btn_onOffToggle:addInputEvent("Mouse_On", "HandleEventLOnOut_AutoUseBuffItem_ShowSimpleTooltip(true, 0)")
  self._ui._btn_onOffToggle:addInputEvent("Mouse_Out", "HandleEventLOnOut_AutoUseBuffItem_ShowSimpleTooltip(false, 0)")
  self._ui._btn_clearPreset:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_ClearCurrentPreset()")
  if _ContentsGroup_AutoUseBuffSafeRegionCheck == true then
    self._ui._btn_checkSafeRegion:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_TogglePresetSafeRegionCheck()")
  end
end
function PaGlobal_AutoUseBuffItem:initialize_mainArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._ui._stc_mainArea = UI.getChildControl(Panel_Window_AutoBuff, "Static_MainArea")
  self._ui._frm_mainFrame = UI.getChildControl(self._ui._stc_mainArea, "Frame_AutoBuff")
  self._ui._frm_mainFrameContent = UI.getChildControl(self._ui._frm_mainFrame, "Frame_1_ItemGroup")
  self._ui._template_itemGroup = UI.getChildControl(self._ui._frm_mainFrameContent, "Static_ItemGroup_Template")
end
function PaGlobal_AutoUseBuffItem:initialize_descArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._ui._stc_descArea = UI.getChildControl(Panel_Window_AutoBuff, "Static_DescArea")
  local descText = UI.getChildControl(self._ui._stc_descArea, "StaticText_Desc")
  descText:SetTextMode(__eTextMode_AutoWrap)
  descText:SetText(descText:GetText())
  if descText:IsAutoWrapText() == true then
    local originDescAreaSizeY = self._ui._stc_descArea:GetSizeY()
    descText:SetSize(descText:GetSizeX(), descText:GetTextSizeY())
    self._ui._stc_descArea:SetSize(self._ui._stc_descArea:GetSizeX(), descText:GetSizeY() + 20)
    local newDescAreaSizeY = self._ui._stc_descArea:GetSizeY()
    if originDescAreaSizeY ~= newDescAreaSizeY then
      local diffY = newDescAreaSizeY - originDescAreaSizeY
      Panel_Window_AutoBuff:SetSize(Panel_Window_AutoBuff:GetSizeX(), Panel_Window_AutoBuff:GetSizeY() + diffY)
      self._ui._stc_descArea:ComputePosAllChild()
    end
  end
end
function PaGlobal_AutoUseBuffItem:initialize_bottomArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._ui._btn_confirm = UI.getChildControl(Panel_Window_AutoBuff, "Button_Confirm")
  self._ui._btn_close = UI.getChildControl(Panel_Window_AutoBuff, "Button_Close")
  self._ui._btn_confirm:SetShow(not self._isConsole)
  self._ui._btn_close:SetShow(not self._isConsole)
  if self._isConsole == true then
    Panel_Window_AutoBuff:SetSize(Panel_Window_AutoBuff:GetSizeX(), Panel_Window_AutoBuff:GetSizeY() - self._ui._btn_confirm:GetSizeY() - 10)
    self._ui._stc_descArea:ComputePosAllChild()
  else
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_ConfirmButton()")
    self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_CloseButton()")
  end
  self._ui._stc_keyGuideArea = UI.getChildControl(Panel_Window_AutoBuff, "Static_KeyGuide_Console")
  if self._isConsole == true then
    self._ui._stc_keyGuideArea:SetShow(true)
    self._ui._stc_keyGuideArea:ComputePosAllChild()
  else
    self._ui._stc_keyGuideArea:SetShow(false)
    return
  end
  local keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Select_Console")
  local keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Close_Console")
  local keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Activate_Console")
  local keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Reset_Console")
  local keyGuide_LBRB = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_TabPreset")
  local keyGuide_LTY = UI.getChildControl(self._ui._stc_keyGuideArea, "StaticText_Y_ConsoleUI")
  keyGuide_A:SetShow(false)
  keyGuide_B:SetShow(false)
  keyGuide_Y:SetShow(false)
  keyGuide_X:SetShow(false)
  keyGuide_LBRB:SetShow(false)
  keyGuide_LTY:SetShow(false)
  local keyGuideList = Array.new()
  if _ContentsGroup_AutoUseBuffSafeRegionCheck == true then
    keyGuideList:push_back(keyGuide_LTY)
  end
  keyGuideList:push_back(keyGuide_LBRB)
  keyGuideList:push_back(keyGuide_X)
  keyGuideList:push_back(keyGuide_Y)
  keyGuideList:push_back(keyGuide_A)
  keyGuideList:push_back(keyGuide_B)
  for key, control in pairs(keyGuideList) do
    if control ~= nil then
      control:SetShow(true)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideArea, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
function PaGlobal_AutoUseBuffItem:registEventHandler()
  if Panel_Window_AutoBuff == nil then
    return
  end
  registerEvent("FromClient_UpdateAutoUseBuffItemMap", "FromClient_AutoUseBuffItem_UpdateMap")
  registerEvent("FromClient_UpdateAutoUseBuffItemToggleState", "FromClient_AutoUseBuffItem_UpdateItemToggleState")
  registerEvent("FromClient_CantAutoUseBuffItemToggle", "FromClient_AutoUseBuffItem_CantToggle")
  registerEvent("FromClient_UpdateAutoUseModeToggleState", "FromClient_AutoUseBuffItem_UpdateModeToggleState")
  registerEvent("FromClient_ChangedAutoUseBuffPresetIndex", "FromClient_AutoUseBuffItem_ChangedAutoUseBuffPresetIndex")
  registerEvent("FromClient_ChangedLearnedFairyAutoUseBuffSkill", "FromClient_AutoUseBuffItem_ChangedLearnedFairyPotionSkill")
  registerEvent("FromClient_ChangedAutoUseItemPresetSafeRegionCheck", "FromClient_AutoUseBuffItem_ChangedAutoUseItemPresetSafeRegionCheck")
  registerEvent("EventSelfPlayerPreDead", "FromClient_AutoUseBuffItem_HandleDeadSelfPlayer")
  if self._isConsole == true then
    Panel_Window_AutoBuff:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_AutoUseBuffItem_ClearCurrentPreset()")
    Panel_Window_AutoBuff:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_AutoUseBuffItem_ToggleAutoUseMode()")
    Panel_Window_AutoBuff:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventLBUp_AutoUseBuffItem_ChangePreset(true)")
    Panel_Window_AutoBuff:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventLBUp_AutoUseBuffItem_ChangePreset(false)")
    if _ContentsGroup_AutoUseBuffSafeRegionCheck == true then
      Panel_Window_AutoBuff:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_AutoUseBuffItem_TogglePresetSafeRegionCheck()")
    end
  end
end
function PaGlobal_AutoUseBuffItem:prepareOpen(isOpenedByFairyInfo)
  if Panel_Window_AutoBuff == nil or isOpenedByFairyInfo == nil then
    return
  end
  if ToClient_isAplliedFairySkill() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSummonFairyLearnedAutoBuff"))
    if PaGlobalFunc_AutoUseBuffItem_GetShow() == true then
      PaGlobalFunc_AutoUseBuffItem_Close()
    end
    return
  end
  self._isOpenedByFairy = isOpenedByFairyInfo
  self:recalcPanelPosition()
  local frameVerticalScroll = UI.getChildControl(self._ui._frm_mainFrame, "Frame_1_VerticalScroll")
  frameVerticalScroll:SetControlPos(0)
  self._ui._frm_mainFrame:UpdateContentPos()
  local isActivateAutoUseBuffItemFunc = ToClient_getCurrentAutoUseModeToggleState()
  FromClient_AutoUseBuffItem_UpdateModeToggleState(isActivateAutoUseBuffItemFunc)
  if self._isConsole == true then
    Panel_Window_AutoBuff:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  self:open()
  ToClient_clearAndUpdateMap()
end
function PaGlobal_AutoUseBuffItem:recalcPanelPosition()
  local panel = Panel_Window_AutoBuff
  if panel == nil then
    return
  end
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  if self._isConsole == true then
    panelSizeY = panelSizeY + self._ui._stc_keyGuideArea:GetSizeY()
  end
  local calcPosX = screenCenterX - panelSizeX / 2
  local calcPosY = screenCenterY - panelSizeY / 2
  if self._isOpenedByFairy == true and Panel_FairyInfo_All ~= nil then
    calcPosX = Panel_FairyInfo_All:GetPosX() + Panel_FairyInfo_All:GetSizeX() + 10
  end
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 5 then
    calcPosY = 5
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_AutoUseBuffItem:open()
  if Panel_Window_AutoBuff == nil then
    return
  end
  Panel_Window_AutoBuff:RegisterUpdateFunc("PaGlobalFunc_AutoUseBuffItem_Update")
  Panel_Window_AutoBuff:SetShow(true)
  ToClient_setShowAutoUseItemUI(true)
end
function PaGlobal_AutoUseBuffItem:prepareClose()
  if Panel_Window_AutoBuff == nil then
    return
  end
  if self._isOpenedByFairy == true and PaGlobal_FairyInfo_All ~= nil then
    PaGlobal_FairyInfo_All:recalcPanelPosition(0, -20)
  end
  self._isOpenedByFairy = false
  if self._isConsole == true and ToClient_isConsole() == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  self:close()
end
function PaGlobal_AutoUseBuffItem:close()
  if Panel_Window_AutoBuff == nil then
    return
  end
  Panel_Window_AutoBuff:ClearUpdateLuaFunc()
  Panel_Window_AutoBuff:SetShow(false)
  ToClient_setShowAutoUseItemUI(false)
end
function PaGlobal_AutoUseBuffItem:validate()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._stc_topArea:isValidate()
  self._ui._btn_onOffToggle:isValidate()
  self._ui._btn_checkSafeRegion:isValidate()
  self._ui._stc_toggleStateText:isValidate()
  self._ui._stc_checkCountText:isValidate()
  self._ui._stc_mainArea:isValidate()
  self._ui._frm_mainFrame:isValidate()
  self._ui._frm_mainFrameContent:isValidate()
  self._ui._stc_descArea:isValidate()
  self._ui._stc_keyGuideArea:isValidate()
end
function PaGlobal_AutoUseBuffItem:createItemGroupList()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self._itemGroupDataList = Array.new()
  local categoryCount = ToClient_getAutoUseBuffItemCategoryCount()
  for index = 0, categoryCount - 1 do
    local categoryKey = ToClient_getAutoUseBuffItemCategoryKey(index)
    local categorySSW = ToClient_getAutoUseBuffItemCategoryStaticStatusWrapper(categoryKey)
    if categorySSW ~= nil then
      local itemGroupData = {
        _categoryKeyRaw = categoryKey:get(),
        _groupControl = UI.cloneControl(self._ui._template_itemGroup, self._ui._frm_mainFrameContent, "Static_ItemGroup_" .. tostring(categoryKey:get())),
        _emptyControl = nil,
        _itemControlList = Array.new(),
        _lineControlList = Array.new(),
        _itemSlotList = Array.new()
      }
      if itemGroupData._groupControl == nil then
        UI.ASSERT_NAME(false, "[AutoUseBuffItem UI] \236\149\132\236\157\180\237\133\156 \234\183\184\235\163\185 \236\160\149\235\179\180 \236\132\184\237\140\133\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      end
      local groupTitleName = UI.getChildControl(itemGroupData._groupControl, "StaticText_GroupTitle")
      groupTitleName:SetText(categorySSW:getCategoryName())
      itemGroupData._emptyControl = UI.getChildControl(itemGroupData._groupControl, "StaticText_Empty")
      itemGroupData._groupControl:SetShow(true)
      self._itemGroupDataList[index] = itemGroupData
    end
  end
end
function PaGlobal_AutoUseBuffItem:update_frame(deltaTime)
  local panel = Panel_Window_AutoBuff
  if panel == nil then
    return
  end
  if self._itemGroupDataList == nil then
    return
  end
  for key, value in pairs(self._itemGroupDataList) do
    if value ~= nil then
      local categoryKey = AutoUseBuffItemCategoryKey(value._categoryKeyRaw)
      for key2, value2 in pairs(value._itemControlList) do
        if value2 ~= nil then
          for key3, value3 in pairs(value2) do
            if value3 ~= nil then
              local element = ToClient_getAutoUseBuffItemElement(categoryKey, key2, key3)
              if element ~= nil and element:getItemCount() ~= toInt64(0, 0) then
                local itemSlotData = value._itemSlotList[key2][key3]
                if itemSlotData ~= nil and itemSlotData.icon ~= nil and itemSlotData.cooltime ~= nil and itemSlotData.cooltimeText ~= nil and itemSlotData.icon:GetShow() == true then
                  local remainTime = element:getRemainTime()
                  local itemReuseTime = element:getItemReuseCycle() / 1000
                  local realRemainTime = remainTime * itemReuseTime
                  local intRemainTime = realRemainTime - realRemainTime % 1 + 1
                  if remainTime > 0 then
                    itemSlotData.cooltime:UpdateCoolTime(remainTime)
                    itemSlotData.cooltime:SetShow(true)
                    itemSlotData.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
                    if itemReuseTime >= intRemainTime then
                      itemSlotData.cooltimeText:SetShow(true)
                    else
                      itemSlotData.cooltimeText:SetShow(false)
                    end
                  elseif itemSlotData.cooltime:GetShow() == true then
                    itemSlotData.cooltime:SetShow(false)
                    itemSlotData.cooltimeText:SetShow(false)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_AutoUseBuffItem:update_once()
  if Panel_Window_AutoBuff == nil then
    return
  end
  self:refresh_topArea()
  self:refresh_mainArea()
  self:refresh_checkItemCountArea()
end
function PaGlobal_AutoUseBuffItem:refresh_topArea(isOn)
  if Panel_Window_AutoBuff == nil then
    return
  end
  local isActivateAutoUseBuffItemFunc = isOn
  if isActivateAutoUseBuffItemFunc == nil then
    isActivateAutoUseBuffItemFunc = ToClient_getCurrentAutoUseModeToggleState()
  end
  if isActivateAutoUseBuffItemFunc == true then
    self._ui._stc_toggleStateText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOBUFF_TXT_ACTIVATE"))
  else
    self._ui._stc_toggleStateText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOBUFF_TXT_STOP"))
  end
  self._ui._btn_onOffToggle:SetCheck(isActivateAutoUseBuffItemFunc)
  if _ContentsGroup_AutoUseBuffSafeRegionCheck == true then
    self._ui._btn_checkSafeRegion:SetCheck(ToClient_getCurrentAutoUsePresetSafeRegionCheck())
  end
end
function PaGlobal_AutoUseBuffItem:refresh_checkItemCountArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  local currentCheckCount = ToClient_getAutoUseBuffItemTotalCheckedCount()
  if currentCheckCount == 0 then
    self._ui._stc_checkCountText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTOBUFF_SELECTEDITEMCOUNT_EMPTY"))
  else
    self._ui._stc_checkCountText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_AUTOBUFF_SELECTEDITEMCOUNT", "count", currentCheckCount, "max", ToClient_getAutoUseBuffItemCheckableMaxCount()))
  end
  local checkableMaxCount = ToClient_getAutoUseBuffItemCheckableMaxCount()
  if currentCheckCount == 0 then
    self:setNotCheckedItemListMonotone(false)
  elseif currentCheckCount == checkableMaxCount then
    self:setNotCheckedItemListMonotone(true)
  elseif currentCheckCount < checkableMaxCount then
    self:setNotCheckedItemListMonotone(false)
  elseif currentCheckCount > checkableMaxCount then
    ToClient_clearAndUpdateMap()
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\160\129\236\157\184 \234\178\189\235\161\156\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_AutoUseBuffItem:setNotCheckedItemListMonotone(isMonotone)
  if Panel_Window_AutoBuff == nil then
    return
  end
  if self._itemGroupDataList == nil then
    return
  end
  for key, value in pairs(self._itemGroupDataList) do
    if value ~= nil then
      local categoryKey = AutoUseBuffItemCategoryKey(value._categoryKeyRaw)
      for key2, value2 in pairs(value._itemControlList) do
        if value2 ~= nil then
          for key3, value3 in pairs(value2) do
            if value3 ~= nil then
              local element = ToClient_getAutoUseBuffItemElement(categoryKey, key2, key3)
              if element ~= nil and element:getItemCount() ~= toInt64(0, 0) then
                local newItemSlotCheck = UI.getChildControl(value3, "Static_Check")
                if newItemSlotCheck ~= nil then
                  if isMonotone == true then
                    if newItemSlotCheck:GetShow() == true then
                      value3:SetMonoTone(false)
                    else
                      value3:SetMonoTone(true)
                    end
                  else
                    value3:SetMonoTone(false)
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function PaGlobal_AutoUseBuffItem:refresh_mainArea()
  if Panel_Window_AutoBuff == nil then
    return
  end
  if self._itemGroupDataList == nil then
    self:createItemGroupList()
  end
  for key, value in pairs(self._itemGroupDataList) do
    if value ~= nil then
      value._emptyControl:SetShow(false)
      for key2, value2 in pairs(value._itemControlList) do
        if value2 ~= nil then
          for key3, value3 in pairs(value2) do
            if value3 ~= nil then
              value3:SetShow(false)
              local newItemSlotBg = UI.getChildControl(value3, "Static_IconSlot")
              local newItemSlotIcon = UI.getChildControlNoneAssert(newItemSlotBg, "Static_Icon_AutoUseBuffItemSlot_")
              if newItemSlotIcon ~= nil then
                newItemSlotIcon:addInputEvent("Mouse_On", "")
                newItemSlotIcon:addInputEvent("Mouse_Out", "")
                newItemSlotIcon:addInputEvent("Mouse_LUp", "")
              end
              local newItemSlotCheck = UI.getChildControl(value3, "Static_Check")
              newItemSlotCheck:SetShow(false)
              newItemSlotCheck:addInputEvent("Mouse_On", "")
              newItemSlotCheck:addInputEvent("Mouse_Out", "")
              newItemSlotCheck:addInputEvent("Mouse_LUp", "")
            end
          end
        end
      end
      for key4, value4 in pairs(value._lineControlList) do
        if value4 ~= nil then
          value4:SetShow(false)
        end
      end
    end
  end
  local frameVerticalScroll = UI.getChildControl(self._ui._frm_mainFrame, "Frame_1_VerticalScroll")
  local framePosX = frameVerticalScroll:GetPosX()
  for key = 0, #self._itemGroupDataList do
    local value = self._itemGroupDataList[key]
    local categoryKey = AutoUseBuffItemCategoryKey(value._categoryKeyRaw)
    local groupCount = ToClient_getAutoUseBuffItemGroupCount(categoryKey)
    local isEmptyGroup = false
    if groupCount ~= 0 then
      local groupAccumulatedSpanY = 0
      for groupIndex = 0, groupCount - 1 do
        local buffCategory = ToClient_getAutoUseBuffItemBuffCategory(categoryKey, groupIndex)
        local elementCount = ToClient_getAutoUseBuffItemElementCount(categoryKey, buffCategory)
        if elementCount == 0 then
          isEmptyGroup = true
          break
        else
          if groupIndex > 0 then
            local lingControlTemplate = UI.getChildControl(value._groupControl, "Static_Line_Template")
            local newLineControl = value._lineControlList[groupIndex]
            if newLineControl == nil then
              newLineControl = UI.cloneControl(lingControlTemplate, value._groupControl, "Static_Line_" .. tostring(groupIndex))
            end
            newLineControl:SetSpanSize(newLineControl:GetSpanSize().x, groupAccumulatedSpanY + 10)
            newLineControl:SetShow(true)
            groupAccumulatedSpanY = newLineControl:GetSpanSize().y
            value._lineControlList[groupIndex] = newLineControl
          end
          local iconGapXY = 5
          for elementIndex = 0, elementCount - 1 do
            local element = ToClient_getAutoUseBuffItemElement(categoryKey, buffCategory, elementIndex)
            if element:isDefined() == true then
              local itemKey = element:getItemKey()
              local itemCount_s64 = element:getItemCount()
              local isChecked = element:isChecked()
              local itemSSW = getItemEnchantStaticStatus(itemKey)
              if itemKey ~= nil then
                local itemBgControlTemplate = UI.getChildControl(value._groupControl, "Static_ItemSlotBg_Template")
                local buffCategoryItemTable = value._itemControlList[buffCategory]
                if buffCategoryItemTable == nil then
                  value._itemControlList[buffCategory] = Array.new()
                end
                local newItemControl = value._itemControlList[buffCategory][elementIndex]
                if newItemControl == nil then
                  newItemControl = UI.cloneControl(itemBgControlTemplate, value._groupControl, "Static_ItemSlotBg_" .. tostring(categoryKey:get()) .. "_" .. tostring(buffCategory) .. "_" .. tostring(elementIndex))
                end
                local newItemSlotCheck = UI.getChildControl(newItemControl, "Static_Check")
                newItemSlotCheck:SetShow(isChecked)
                if isChecked == true then
                  local newItemSlotUseOrderNo = UI.getChildControl(newItemSlotCheck, "StaticText_Count")
                  newItemSlotUseOrderNo:SetShow(element:isShowUseOrderNo())
                  newItemSlotUseOrderNo:SetText(element:getItemUseOrderNo())
                end
                newItemSlotCheck:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_ToggltUseItem(" .. tostring(categoryKey:get()) .. "," .. tostring(buffCategory) .. "," .. tostring(elementIndex) .. ")")
                newItemSlotCheck:addInputEvent("Mouse_On", "HandleEventLOnOut_AutoUseBuffItem_ShowItemTooltip(true," .. tostring(categoryKey:get()) .. "," .. tostring(buffCategory) .. "," .. tostring(elementIndex) .. ")")
                newItemSlotCheck:addInputEvent("Mouse_Out", "HandleEventLOnOut_AutoUseBuffItem_ShowItemTooltip(false," .. tostring(categoryKey:get()) .. "," .. tostring(buffCategory) .. "," .. tostring(elementIndex) .. ")")
                local newItemSlot = {}
                local newItemSlotBg = UI.getChildControl(newItemControl, "Static_IconSlot")
                local newItemSlotIcon = UI.getChildControlNoneAssert(newItemSlotBg, "Static_Icon_AutoUseBuffItemSlot_")
                if newItemSlotIcon == nil then
                  SlotItem.new(newItemSlot, "Icon_AutoUseBuffItemSlot_", 0, newItemSlotBg, self._slotConfig)
                  newItemSlot:createChild()
                  newItemSlot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
                  newItemSlot.icon:SetPosX(0)
                  newItemSlot.icon:SetPosY(0)
                  newItemSlot.icon:SetSize(44, 44)
                  newItemSlot.icon:SetHorizonLeft()
                  newItemSlot.icon:SetVerticalTop()
                  newItemSlot.cooltime:SetSize(44, 44)
                  newItemSlot.cooltime:SetPosX(0)
                  newItemSlot.cooltime:SetPosY(0)
                  if value._itemSlotList[buffCategory] == nil then
                    value._itemSlotList[buffCategory] = Array.new()
                  end
                  value._itemSlotList[buffCategory][elementIndex] = newItemSlot
                else
                  newItemSlot = value._itemSlotList[buffCategory][elementIndex]
                  newItemSlot:clearItem()
                  newItemSlot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
                end
                if itemCount_s64 == toInt64(0, 0) then
                  newItemControl:SetMonoTone(true, true)
                else
                  newItemControl:SetMonoTone(false, false)
                end
                newItemSlot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoUseBuffItem_ToggltUseItem(" .. tostring(categoryKey:get()) .. "," .. tostring(buffCategory) .. "," .. tostring(elementIndex) .. ")")
                newItemSlot.icon:addInputEvent("Mouse_On", "HandleEventLOnOut_AutoUseBuffItem_ShowItemTooltip(true," .. tostring(categoryKey:get()) .. "," .. tostring(buffCategory) .. "," .. tostring(elementIndex) .. ")")
                newItemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLOnOut_AutoUseBuffItem_ShowItemTooltip(false," .. tostring(categoryKey:get()) .. "," .. tostring(buffCategory) .. "," .. tostring(elementIndex) .. ")")
                local validRowSizeX = framePosX - itemBgControlTemplate:GetSizeX()
                local iconRowMaxCount = math.floor(validRowSizeX / itemBgControlTemplate:GetSizeX())
                local rowIndex = math.floor(elementIndex / iconRowMaxCount)
                local colIndex = elementIndex - iconRowMaxCount * rowIndex
                local beginSpanX = 10
                local beginSpanY = itemBgControlTemplate:GetSpanSize().y
                local iconTermSpanXY = 5
                local prevLineControl = value._lineControlList[groupIndex]
                if prevLineControl ~= nil and prevLineControl:GetShow() == true then
                  beginSpanY = prevLineControl:GetSpanSize().y + 10
                end
                newItemControl:SetSpanSize(beginSpanX + (newItemSlotBg:GetSizeX() + iconTermSpanXY) * colIndex, beginSpanY + (newItemSlotBg:GetSizeY() + iconTermSpanXY) * rowIndex)
                newItemControl:SetShow(true)
                if groupAccumulatedSpanY < newItemControl:GetPosY() + newItemControl:GetSizeY() then
                  groupAccumulatedSpanY = newItemControl:GetPosY() + newItemControl:GetSizeY()
                end
                value._itemControlList[buffCategory][elementIndex] = newItemControl
              end
            end
          end
        end
      end
      value._groupControl:SetSize(value._groupControl:GetSizeX(), groupAccumulatedSpanY + 10)
    else
      isEmptyGroup = true
      value._groupControl:SetSize(value._groupControl:GetSizeX(), value._emptyControl:GetSpanSize().y + value._emptyControl:GetSizeY() + 10)
    end
    value._emptyControl:SetShow(isEmptyGroup)
    local prevGroupValue = self._itemGroupDataList[key - 1]
    if prevGroupValue ~= nil then
      value._groupControl:SetSpanSize(value._groupControl:GetSpanSize().x, prevGroupValue._groupControl:GetSpanSize().y + prevGroupValue._groupControl:GetSizeY())
    end
  end
  for i = #self._itemGroupDataList, 1, -1 do
    local reverseValue = self._itemGroupDataList[i]
    if reverseValue ~= nil then
      self._ui._frm_mainFrameContent:SetSize(self._ui._frm_mainFrameContent:GetSizeX(), reverseValue._groupControl:GetSpanSize().y + reverseValue._groupControl:GetSizeY() + 20)
      break
    end
  end
  self._ui._frm_mainFrame:UpdateContentPos()
  if self._ui._frm_mainFrame:GetSizeY() < self._ui._frm_mainFrameContent:GetSizeY() then
    frameVerticalScroll:SetShow(true)
  else
    frameVerticalScroll:SetShow(false)
  end
end
function PaGlobal_AutoUseBuffItem:update_itemIconState(categoryKey, buffCategory, elementIndex, isChecked, itemUseOrderNo, isShowUseOrderNo)
  if Panel_Window_AutoBuff == nil then
    return
  end
  if categoryKey == nil or buffCategory == nil or elementIndex == nil or isChecked == nil or itemUseOrderNo == nil or isShowUseOrderNo == nil then
    return
  end
  if self._itemGroupDataList == nil then
    return
  end
  for key = 0, #self._itemGroupDataList do
    local value = self._itemGroupDataList[key]
    if value ~= nil and value._categoryKeyRaw == categoryKey:get() then
      if value._itemControlList[buffCategory] ~= nil and value._itemControlList[buffCategory][elementIndex] ~= nil then
        local checkControl = UI.getChildControl(value._itemControlList[buffCategory][elementIndex], "Static_Check")
        if checkControl ~= nil then
          checkControl:SetShow(isChecked)
          if isChecked == true then
            local newItemSlotUseOrderNo = UI.getChildControl(checkControl, "StaticText_Count")
            newItemSlotUseOrderNo:SetShow(isShowUseOrderNo)
            newItemSlotUseOrderNo:SetText(itemUseOrderNo)
          end
        end
      end
      return
    end
  end
end
