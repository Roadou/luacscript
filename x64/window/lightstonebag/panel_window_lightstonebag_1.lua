function PaGlobal_LightStoneBag:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping == true or ToClient_isConsole() == true
  self._artifactInventorySlotCountMax = ToClient_getArtifactInventorySlotCountMax()
  self._artifactInventoryPresetCountMax = ToClient_getArtifactInventoryPresetCountMax()
  self:initializeTitleArea()
  self:initializeTopTabArea()
  self:initializeArtifactArea()
  self:initializeLightStoneArea()
  self:initializeBottomButtonArea()
  self:initializeBottomKeyGuideArea()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_LightStoneBag:initializeTitleArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local stc_titleBg = UI.getChildControl(Panel_Window_LightStoneBag, "StaticText_TitleBg")
  local btn_close = UI.getChildControl(stc_titleBg, "Button_Win_Close")
  if self._isConsole == false then
    btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_Close()")
  end
  btn_close:SetShow(not self._isConsole)
end
function PaGlobal_LightStoneBag:initializeTopTabArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local stc_topArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_TabGroup")
  self._ui._btn_tab_artifact = UI.getChildControl(stc_topArea, "RadioButton_Tab_Artifacts")
  self._ui._stc_selectedLine_artifact = UI.getChildControl(self._ui._btn_tab_artifact, "Static_SelectedLine")
  self._ui._btn_tab_lightStone = UI.getChildControl(stc_topArea, "RadioButton_Tab_LightStone")
  self._ui._stc_selectedLine_lightStone = UI.getChildControl(self._ui._btn_tab_lightStone, "Static_SelectedLine")
  self._ui._stc_keyGuide_LB = UI.getChildControl(stc_topArea, "Static_LB_ConsoleUI")
  self._ui._stc_keyGuide_RB = UI.getChildControl(stc_topArea, "Static_RB_ConsoleUI")
  self._ui._btn_tab_artifact:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedTab(" .. LightStoneBagTabIndex.Artifact .. ")")
  self._ui._btn_tab_lightStone:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedTab(" .. LightStoneBagTabIndex.LightStone .. ")")
  if self._isConsole == true then
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_LightStoneBag_MoveTab(true)")
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_LightStoneBag_MoveTab(false)")
  end
  self._ui._stc_keyGuide_LB:SetShow(self._isConsole)
  self._ui._stc_keyGuide_RB:SetShow(self._isConsole)
end
function PaGlobal_LightStoneBag:initializeArtifactArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._stc_artifactBagArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_ArtifactBagArea")
  self._ui._txt_slotCount = UI.getChildControl(self._ui._stc_artifactBagArea, "StaticText_SlotCount")
  self._ui._btn_buyItem = UI.getChildControl(self._ui._stc_artifactBagArea, "Button_BuyItem")
  self._ui._artifactBagList = UI.getChildControl(self._ui._stc_artifactBagArea, "List2_ArtifactList")
  local artifactBag_content = UI.getChildControl(self._ui._artifactBagList, "List2_1_Content")
  local artifactBag_btn = UI.getChildControl(artifactBag_content, "Button_Artifact")
  local artifactBag_mainSlotBG = UI.getChildControl(artifactBag_btn, "Static_ItemSlotBG")
  local artifactBag_mainItemSlot = UI.getChildControl(artifactBag_mainSlotBG, "Static_ItemIcon")
  local artifactBag_subItemSlot_0_BG = UI.getChildControl(artifactBag_btn, "Static_Artifact_BG_0")
  local artifactBag_subItemSlot_0 = UI.getChildControl(artifactBag_subItemSlot_0_BG, "Static_Icon")
  local artifactBag_subItemSlot_1_BG = UI.getChildControl(artifactBag_btn, "Static_Artifact_BG_1")
  local artifactBag_subItemSlot_1 = UI.getChildControl(artifactBag_subItemSlot_1_BG, "Static_Icon")
  local artifactBag_artifactSlot = {}
  SlotItem.new(artifactBag_artifactSlot, "Artifact_Item_Slot_", 0, artifactBag_mainItemSlot, self._slotConfig)
  artifactBag_artifactSlot:createChild()
  artifactBag_artifactSlot:clearItem()
  artifactBag_artifactSlot.icon:SetPosX(0)
  artifactBag_artifactSlot.icon:SetPosY(0)
  artifactBag_artifactSlot.border:SetSize(44, 44)
  local artifactBag_subSlot_0 = {}
  SlotItem.new(artifactBag_subSlot_0, "Artifact_SubItem_Slot_0_", 0, artifactBag_subItemSlot_0, self._subSlotConfig)
  artifactBag_subSlot_0:createChild()
  artifactBag_subSlot_0:clearItem()
  artifactBag_subSlot_0.icon:SetPosX(0)
  artifactBag_subSlot_0.icon:SetPosY(0)
  artifactBag_subSlot_0.icon:SetSize(20, 20)
  local artifactBag_subSlot_1 = {}
  SlotItem.new(artifactBag_subSlot_1, "Artifact_SubItem_Slot_1_", 0, artifactBag_subItemSlot_1, self._subSlotConfig)
  artifactBag_subSlot_1:createChild()
  artifactBag_subSlot_1:clearItem()
  artifactBag_subSlot_1.icon:SetPosX(0)
  artifactBag_subSlot_1.icon:SetPosY(0)
  artifactBag_subSlot_1.icon:SetSize(20, 20)
  self._ui._artifactBagList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_LightStoneBag_OnCreateArtifactBagListContent")
  self._ui._artifactBagList:createChildContent(__ePAUIList2ElementManagerType_List)
  if ToClient_isConsole() == true then
    self._ui._btn_buyItem:SetShow(false)
    self._ui._txt_slotCount:SetPosX(self._ui._txt_slotCount:GetPosX() + self._ui._btn_buyItem:GetSizeX())
  else
    self._ui._btn_buyItem:SetShow(true)
    self._ui._btn_buyItem:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_Open( 126 )")
  end
end
function PaGlobal_LightStoneBag:initializeLightStoneArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._stc_lightStoneBagArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_LightStoneBagArea")
  self._ui._stc_lightStoneSubTabGroup = UI.getChildControl(self._ui._stc_lightStoneBagArea, "Static_SubTabGroup")
  self._ui._lightStoneTypeCheckButtonList = Array.new()
  for lightStoneSubTypeIndex = 0, __eLightStoneItemSubType_Count - 1 do
    self._ui._lightStoneTypeCheckButtonList[lightStoneSubTypeIndex] = UI.getChildControl(self._ui._stc_lightStoneSubTabGroup, "CheckButton_Type_" .. tostring(lightStoneSubTypeIndex))
    self._ui._lightStoneTypeCheckButtonList[lightStoneSubTypeIndex]:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedLightStoneTypeButton(" .. lightStoneSubTypeIndex .. ")")
    if self._isConsole == true then
      self._ui._lightStoneTypeCheckButtonList[lightStoneSubTypeIndex]:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneTypeButton_OnPadSnap()")
    end
    self._lightStoneTypeFilter[lightStoneSubTypeIndex] = true
  end
  self._ui._lightStoneBagList = UI.getChildControl(self._ui._stc_lightStoneBagArea, "List2_LightStoneList")
  local content = UI.getChildControl(self._ui._lightStoneBagList, "List2_1_Content")
  local btn_item = UI.getChildControl(content, "Button_LightStone")
  local stc_itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local tempSlot = {}
  SlotItem.new(tempSlot, "LightStone_Item_Slot_", 0, stc_itemIcon, self._slotConfig)
  tempSlot:createChild()
  tempSlot:clearItem()
  tempSlot.icon:SetPosX(0)
  tempSlot.icon:SetPosY(0)
  tempSlot.border:SetSize(44, 44)
  self._ui._lightStoneBagList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_LightStoneBag_OnCreateLightStoneBagListContent")
  self._ui._lightStoneBagList:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_LightStoneBag:initializeBottomButtonArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._stc_bottomButtonArea = UI.getChildControl(Panel_Window_LightStoneBag, "Static_BottomSelectedArea")
  self._ui._btn_showEquipLightStoneUI = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_Setting")
  self._ui._btn_getAllItemFromInventory = UI.getChildControl(self._ui._stc_bottomButtonArea, "Button_MoveAll")
  self._ui._btn_showEquipLightStoneUI:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedSettingUIButton()")
  self._ui._btn_getAllItemFromInventory:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_OnClickedMoveAllItemButton()")
end
function PaGlobal_LightStoneBag:initializeBottomKeyGuideArea()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_Window_LightStoneBag, "Static_KeyGuide_Bg")
  self._ui._stc_keyGuideBG:SetShow(true)
  self._ui._stc_keyGuide_LTA = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_LT_MoveAll_ConsoleUI")
  self._ui._stc_keyGuide_RTY = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_RT_LightStone_ConsoleUI")
  self._ui._stc_keyGuide_RTX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_RT_ArtifactPreset_ConsoleUI")
  self._ui._stc_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui._stc_keyGuide_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
end
function PaGlobal_LightStoneBag:registEventHandler()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "PaGlobalFunc_LightStoneBag_OnClickedMoveAllItemButton()")
    Panel_Window_LightStoneBag:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobalFunc_LightStoneBag_OnClickedSettingUIButton()")
  end
  registerEvent("FromClient_UpdateLightStoneBag", "FromClient_UpdateLightStoneBag")
  registerEvent("FromClient_UpdateArifactBag", "FromClient_UpdateArifactBag")
  registerEvent("FromClient_UpdateAtifactBagVariedCount", "FromClient_UpdateAtifactBagVariedCount")
end
function PaGlobal_LightStoneBag:validate()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self._ui._btn_tab_artifact:isValidate()
  self._ui._stc_selectedLine_artifact:isValidate()
  self._ui._btn_tab_lightStone:isValidate()
  self._ui._stc_selectedLine_lightStone:isValidate()
  self._ui._stc_keyGuide_LB:isValidate()
  self._ui._stc_keyGuide_RB:isValidate()
  self._ui._stc_artifactBagArea:isValidate()
  self._ui._artifactBagList:isValidate()
  self._ui._txt_slotCount:isValidate()
  self._ui._btn_buyItem:isValidate()
  self._ui._stc_lightStoneBagArea:isValidate()
  self._ui._stc_lightStoneSubTabGroup:isValidate()
  self._ui._lightStoneBagList:isValidate()
  self._ui._stc_bottomButtonArea:isValidate()
  self._ui._btn_showEquipLightStoneUI:isValidate()
  self._ui._btn_getAllItemFromInventory:isValidate()
  if self._isConsole == true then
    self._ui._stc_keyGuideBG:isValidate()
    self._ui._stc_keyGuide_LTA:isValidate()
    self._ui._stc_keyGuide_RTY:isValidate()
    self._ui._stc_keyGuide_RTX:isValidate()
    self._ui._stc_keyGuide_Y:isValidate()
    self._ui._stc_keyGuide_A:isValidate()
    self._ui._stc_keyGuide_B:isValidate()
    self._ui._stc_keyGuide_X:isValidate()
  end
end
function PaGlobal_LightStoneBag:prepareOpen()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  self:resetData()
  self:openUISetting()
  self:onClickedTab(self._currentTabIndex)
  if self._currentIndex == LightStoneBagTabIndex.Artifact then
    PaGlobalFunc_ArtifactPreset_All_Open()
  end
  self:open()
end
function PaGlobal_LightStoneBag:open()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  Panel_Window_LightStoneBag:SetShow(true)
end
function PaGlobal_LightStoneBag:prepareClose()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if PaGlobalFunc_ArtifactPreset_All_Close(PaGlobal_ArtifactPreset_All._closeType._closePanel) == false then
    return
  end
  if self._isConsole == true then
  elseif _ContentsGroup_NewUI_Inventory_All == true then
    PaGlobalFunc_Inventory_All_ShowEquipUI()
  else
    Inventory_ShowEquipUI()
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  if PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset ~= nil then
    PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(false, nil)
  end
  Panel_Tooltip_Item_hideTooltip()
  if _ContentsOption_CH_CheckProhibitedWord == true then
    ToClient_ClearArtifactPresetNoCache()
  end
  self:hideMouseRClickGuide()
  self:close()
end
function PaGlobal_LightStoneBag:close()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  Panel_Window_LightStoneBag:SetShow(false)
end
function PaGlobal_LightStoneBag:openUISetting()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if PaGlobalFunc_CombineBag_IsShow() == true then
    PaGlobalFunc_CombineBag_Close()
  end
  if self._isConsole == true then
    if Panel_Window_Inventory ~= nil then
      local inventoryPanelPosX = Panel_Window_Inventory:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory:GetPosY()
      Panel_Window_LightStoneBag:SetPosX(inventoryPanelPosX - Panel_Window_LightStoneBag:GetSizeX() - 5)
      Panel_Window_LightStoneBag:SetPosY(inventoryPanelPosY)
    end
  else
    if Panel_Window_Inventory_All ~= nil and false == Panel_Window_Inventory_All:IsUISubApp() then
      local inventoryPanelPosX = Panel_Window_Inventory_All:GetPosX()
      local inventoryPanelPosY = Panel_Window_Inventory_All:GetPosY()
      local posX = inventoryPanelPosX - Panel_Window_LightStoneBag:GetSizeX() - 5
      if posX < 0 then
        posX = inventoryPanelPosX + Panel_Window_Inventory_All:GetSizeX() + 5
      end
      Panel_Window_LightStoneBag:SetPosX(posX)
      Panel_Window_LightStoneBag:SetPosY(inventoryPanelPosY)
    end
    if _ContentsGroup_NewUI_Inventory_All == true then
      if Panel_Window_Inventory_All:GetShow() == false then
        Panel_Window_Inventory_All:SetShow(true)
      end
    elseif Panel_Window_Inventory:GetShow() == false then
      Panel_Window_Inventory:SetShow(true)
    end
  end
end
function PaGlobal_LightStoneBag:isShowPanel()
  if Panel_Window_LightStoneBag == nil then
    return false
  end
  return Panel_Window_LightStoneBag:GetShow()
end
function PaGlobal_LightStoneBag:createArtifactBagListContent(content, s64_key)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local bagIndex = Int64toInt32(s64_key)
  local artifactItemSSW = ToClient_GetArtifactBagItemStaticStatusWrapper(bagIndex)
  if artifactItemSSW == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:createArtifactBagListContent] \236\156\160\235\172\188 \234\176\128\235\176\169\236\151\144 \236\158\136\235\138\148 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local subItem_0_SSW = ToClient_GetFirstArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local subItem_1_SSW = ToClient_GetSecondArtifactBagSubItemStaticStatusWrapper(bagIndex)
  local bagItemCount_s64 = ToClient_GetArtifactBagItemCount64(bagIndex)
  local btn_slot = UI.getChildControl(content, "Button_Artifact")
  local mainSlotBG = UI.getChildControl(btn_slot, "Static_ItemSlotBG")
  local mainItemSlot = UI.getChildControl(mainSlotBG, "Static_ItemIcon")
  local mainItemName = UI.getChildControl(mainSlotBG, "StaticText_ItemName")
  if self._isConsole == true then
    if PaGlobal_ArtifactPreset_All._isEditMode == true then
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_AddArtifactPresetItem(" .. tostring(s64_key) .. ")")
    else
      btn_slot:addInputEvent("Mouse_LUp", "PaGlobalFunc_ArtifactPreset_All_RequestPopArtifactItem(" .. tostring(s64_key) .. ")")
    end
  elseif PaGlobal_ArtifactPreset_All._isEditMode == true then
    btn_slot:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactPreset_All_AddArtifactPresetItem(" .. tostring(s64_key) .. ")")
  else
    btn_slot:addInputEvent("Mouse_RUp", "PaGlobalFunc_ArtifactPreset_All_RequestPopArtifactItem(" .. tostring(s64_key) .. ")")
  end
  local itemGrade = artifactItemSSW:getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  mainItemName:setLineCountByLimitAutoWrap(2)
  mainItemName:SetText(artifactItemSSW:getName())
  if mainItemName:IsLimitText() == true then
    mainItemName:SetIgnore(true)
  end
  mainItemName:SetFontColor(itemGradeColor)
  local mainSlot = {}
  SlotItem.reInclude(mainSlot, "Artifact_Item_Slot_", 0, mainItemSlot, self._slotConfig)
  mainSlot:clearItem()
  mainSlot:setItemByStaticStatus(artifactItemSSW, bagItemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
  if self._isConsole == true then
    btn_slot:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_OnPadSnap(true)")
    btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_OnPadSnap(false)")
    if ToClient_isConsole() == true then
      mainSlot.icon:addInputEvent("Mouse_On", "")
      mainSlot.icon:addInputEvent("Mouse_Out", "")
      btn_slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LightStoneBag:toggleArtifactItemTooltip(" .. tostring(s64_key) .. ")")
    else
      btn_slot:addInputEvent("Mouse_On", "PaGlobal_LightStoneBag:setSnapAndArtifactToolTip(true," .. tostring(s64_key) .. ")")
      btn_slot:addInputEvent("Mouse_Out", "PaGlobal_LightStoneBag:setSnapAndArtifactToolTip(false," .. tostring(s64_key) .. ")")
    end
  else
    btn_slot:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(true," .. tostring(s64_key) .. ")")
    btn_slot:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(false," .. tostring(s64_key) .. ")")
    mainSlot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowItemTooltip(true," .. tostring(s64_key) .. ")")
    mainSlot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowItemTooltip(false," .. tostring(s64_key) .. ")")
  end
  local subItemSlot_0_BG = UI.getChildControl(btn_slot, "Static_Artifact_BG_0")
  local subItemSlot_0 = UI.getChildControl(subItemSlot_0_BG, "Static_Icon")
  local subSlot_0 = {}
  SlotItem.reInclude(subSlot_0, "Artifact_SubItem_Slot_0_", 0, subItemSlot_0, self._subSlotConfig)
  if subItem_0_SSW ~= nil then
    subSlot_0:setItemByStaticStatus(subItem_0_SSW)
  else
    subSlot_0:clearItem()
  end
  if ToClient_isConsole() == false then
    if subItem_0_SSW ~= nil then
      subSlot_0.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(true," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
      subSlot_0.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(false," .. tostring(s64_key) .. "," .. tostring(0) .. ")")
    else
      subSlot_0.icon:addInputEvent("Mouse_On", "")
      subSlot_0.icon:addInputEvent("Mouse_Out", "")
    end
  end
  local subItemSlot_1_BG = UI.getChildControl(btn_slot, "Static_Artifact_BG_1")
  local subItemSlot_1 = UI.getChildControl(subItemSlot_1_BG, "Static_Icon")
  local subSlot_1 = {}
  SlotItem.reInclude(subSlot_1, "Artifact_SubItem_Slot_1_", 0, subItemSlot_1, self._subSlotConfig)
  if subItem_1_SSW ~= nil then
    subSlot_1:setItemByStaticStatus(subItem_1_SSW)
  else
    subSlot_1:clearItem()
  end
  if ToClient_isConsole() == false then
    if subItem_1_SSW ~= nil then
      subSlot_1.icon:addInputEvent("Mouse_On", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(true," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
      subSlot_1.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_ArtifactBag_ShowSubItemTooltip(false," .. tostring(s64_key) .. "," .. tostring(1) .. ")")
    else
      subSlot_1.icon:addInputEvent("Mouse_On", "")
      subSlot_1.icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_LightStoneBag:createLightStoneBagListContent(content, s64_key)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local subTypeIndex = getLightBagSubIndex(s64_key)
  local bagIndex = getLightBagIndex(s64_key)
  local lightStoneItemSSW = ToClient_GetLightStoneBagItemStaticStatusWrapper(subTypeIndex, bagIndex)
  if lightStoneItemSSW == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:createLightStoneBagListContent] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\151\144 \236\158\136\235\138\148 \236\149\132\236\157\180\237\133\156 \236\160\149\235\179\180\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local btn_item = UI.getChildControl(content, "Button_LightStone")
  local stc_itemSlotBg = UI.getChildControl(btn_item, "Static_ItemSlotBG")
  local stc_itemIcon = UI.getChildControl(stc_itemSlotBg, "Static_ItemIcon")
  local txt_itemName = UI.getChildControl(stc_itemSlotBg, "StaticText_ItemName")
  local txt_itemDesc = UI.getChildControl(stc_itemSlotBg, "StaticText_Desc")
  if self._isConsole == true then
    btn_item:addInputEvent("Mouse_LUp", "PaGlobalFunc_LightStoneBag_RequestPopLightStoneItem(" .. tostring(s64_key) .. ")")
  else
    btn_item:addInputEvent("Mouse_RUp", "PaGlobalFunc_LightStoneBag_RequestPopLightStoneItem(" .. tostring(s64_key) .. ")")
  end
  if self._isConsole == true then
    btn_item:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneBag_OnPadSnap(true)")
    btn_item:addInputEvent("Mouse_Out", "PaGlobalFunc_LightStoneBag_OnPadSnap(false)")
    if ToClient_isConsole() == true then
      btn_item:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LightStoneBag:toggleLightStoneItemTooltip(" .. tostring(s64_key) .. ")")
    else
      btn_item:addInputEvent("Mouse_On", "PaGlobal_LightStoneBag:setSnapAndLightStoneToolTip(true," .. tostring(s64_key) .. ")")
      btn_item:addInputEvent("Mouse_Out", "PaGlobal_LightStoneBag:setSnapAndLightStoneToolTip(false," .. tostring(s64_key) .. ")")
    end
  else
    btn_item:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(true," .. tostring(s64_key) .. ")")
    btn_item:addInputEvent("Mouse_Out", "PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(false," .. tostring(s64_key) .. ")")
  end
  local itemGrade = lightStoneItemSSW:getGradeType()
  local itemGradeColor = PAGlobalFunc_SetItemTextColorByItemGrade(itemGrade)
  txt_itemName:SetText(lightStoneItemSSW:getName())
  if txt_itemName:IsLimitText() == true then
    txt_itemName:SetIgnore(true)
  end
  txt_itemName:SetFontColor(itemGradeColor)
  local classType = getSelfPlayer():getClassType()
  local jewelSkillStaticWrapper = lightStoneItemSSW:getSkillByIdx(classType)
  if jewelSkillStaticWrapper ~= nil then
    local buffCount = jewelSkillStaticWrapper:getBuffCount()
    local descText = ""
    for buffIdx = 0, buffCount - 1 do
      local descCurrent = jewelSkillStaticWrapper:getBuffDescription(buffIdx)
      if descCurrent == "" then
        break
      end
      if buffIdx == 0 then
        descText = descCurrent
      else
        descText = descText .. ", " .. descCurrent
      end
    end
    txt_itemDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
    txt_itemDesc:setLineCountByLimitAutoWrap(2)
    txt_itemDesc:SetText(descText)
    UI.setLimitAutoWrapTextAndAddTooltip(txt_itemDesc, 2, txt_itemDesc:GetText(), "")
  end
  local slot = {}
  SlotItem.reInclude(slot, "LightStone_Item_Slot_", 0, stc_itemIcon, self._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(lightStoneItemSSW, ToClient_GetLightStoneBagItemCount64(subTypeIndex, bagIndex), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, true)
  if ToClient_isConsole() == true then
    slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LightStoneBag:toggleLightStoneItemTooltip(" .. tostring(s64_key) .. ")")
  else
    slot.icon:addInputEvent("Mouse_On", "PaGlobalFunc_LightStoneBag_ShowItemTooltip(true," .. tostring(s64_key) .. ")")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobalFunc_LightStoneBag_ShowItemTooltip(false," .. tostring(s64_key) .. ")")
  end
end
function PaGlobal_LightStoneBag:resetData()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  PaGlobal_ArtifactPreset_All._ui._btn_editPreset:SetCheck(false)
  self._currentMouseOnArtifactBagIndex = nil
  if self._isConsole == true then
    self._beforePadSnapState = nil
    self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnBag)
  end
  self:syncLightStoneTypeFilterButton()
end
function PaGlobal_LightStoneBag:changePadSnapState(newState, isForceChange)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if newState ~= LightStoneBagConsoleSnapState.SnapOnBag and newState ~= LightStoneBagConsoleSnapState.SnapOnPreset and newState ~= LightStoneBagConsoleSnapState.SnapOnEditMode then
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 PadSnapState \236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isChangedState = self._currentPadSnapState ~= newState or self._beforePadSnapState ~= newState
  if newState ~= LightStoneBagConsoleSnapState.SnapOnEditMode then
    self._beforePadSnapState = newState
  end
  if self._currentPadSnapState ~= LightStoneBagConsoleSnapState.SnapOnEditMode or isForceChange ~= nil and isForceChange == true then
    self._currentPadSnapState = newState
  end
  if isChangedState == true then
    self:resyncKeyGuideState()
  end
end
function PaGlobal_LightStoneBag:resyncKeyGuideState()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local showKeyGuideList = Array.new()
  local hideKeyGuideList = Array.new()
  if self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnBag then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
    showKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
    if ToClient_isConsole() == true then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    end
    showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
    if ToClient_isConsole() == false then
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    end
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
  elseif self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnPreset then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_PRESET_BTN_USE"))
    showKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
    showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
    hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
  elseif self._currentPadSnapState == LightStoneBagConsoleSnapState.SnapOnEditMode then
    self._ui._stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
    if self._beforePadSnapState == LightStoneBagConsoleSnapState.SnapOnBag then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
    elseif self._beforePadSnapState == LightStoneBagConsoleSnapState.SnapOnPreset then
      showKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    else
      showKeyGuideList:push_back(self._ui._stc_keyGuide_RTX)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_A)
      showKeyGuideList:push_back(self._ui._stc_keyGuide_B)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_X)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_Y)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_LTA)
      hideKeyGuideList:push_back(self._ui._stc_keyGuide_RTY)
    end
  else
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 self._currentPadSnapState\236\157\152 \234\176\146\236\151\144 \235\140\128\237\149\156 \236\178\152\235\166\172\234\176\128 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  for key, control in pairs(showKeyGuideList) do
    if control ~= nil then
      control:SetShow(true)
    end
  end
  for key, control in pairs(hideKeyGuideList) do
    if control ~= nil then
      control:SetShow(false)
    end
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(showKeyGuideList, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
end
function PaGlobal_LightStoneBag:updateArtifactBagSlotCount()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local currentSlotCount = ToClient_GetArtifactBagSize()
  if currentSlotCount >= self._artifactInventorySlotCountMax then
    self._ui._txt_slotCount:SetFontColor(Defines.Color.C_FFD05D48)
  else
    self._ui._txt_slotCount:SetFontColor(Defines.Color.C_FF83A543)
  end
  self._ui._txt_slotCount:SetText(tostring(ToClient_GetArtifactBagSize()) .. " / " .. tostring(self._artifactInventorySlotCountMax))
end
function PaGlobal_LightStoneBag:onClickedTab(tabIndex)
  if Panel_Window_LightStoneBag == nil or tabIndex == nil then
    return
  end
  if tabIndex < 0 then
    tabIndex = 0
  elseif tabIndex >= LightStoneBagTabIndex.TabCount then
    tabIndex = LightStoneBagTabIndex.TabCount - 1
  end
  if tabIndex == LightStoneBagTabIndex.Artifact then
    self._ui._stc_lightStoneSubTabGroup:SetShow(false)
    self._ui._stc_artifactBagArea:SetShow(true)
    self._ui._stc_lightStoneBagArea:SetShow(false)
    self._ui._stc_selectedLine_artifact:SetShow(true)
    self._ui._stc_selectedLine_lightStone:SetShow(false)
    PaGlobalFunc_ArtifactPreset_All_ToggleEditMode(true)
    self:reloadList_artifactBagList(false)
    PaGlobal_ArtifactPreset_All:loadArtifactPresetList(false)
    Inventory_SetFunctor(PaGlobalFunc_ArtifactBag_Filter, PaGlobalFunc_ArtifactBag_RClickFunction, nil, nil)
    self._ui._btn_tab_artifact:SetCheck(true)
    self._ui._btn_tab_lightStone:SetCheck(false)
    PaGlobalFunc_ArtifactPreset_All_Open()
  elseif tabIndex == LightStoneBagTabIndex.LightStone then
    if PaGlobalFunc_ArtifactPreset_All_Close(PaGlobal_ArtifactPreset_All._closeType._changeTab) == false then
      return
    end
    self._ui._stc_lightStoneSubTabGroup:SetShow(true)
    self._ui._stc_artifactBagArea:SetShow(false)
    self._ui._stc_lightStoneBagArea:SetShow(true)
    self._ui._stc_selectedLine_artifact:SetShow(false)
    self._ui._stc_selectedLine_lightStone:SetShow(true)
    self:reloadList_lightStoneBagList(false)
    PaGlobal_ArtifactPreset_All._ui._btn_editPreset:SetCheck(false)
    if self._isConsole == true then
      self:changePadSnapState(LightStoneBagConsoleSnapState.SnapOnBag, true)
    end
    Inventory_SetFunctor(PaGlobalFunc_LightStoneBag_Filter, PaGlobalFunc_LightStoneBag_RClickFunction, nil, nil)
    self._ui._btn_tab_artifact:SetCheck(false)
    self._ui._btn_tab_lightStone:SetCheck(true)
  else
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:onClickedTab] Tab Index\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  ClearFocusEdit()
  self._currentTabIndex = tabIndex
end
function PaGlobal_LightStoneBag:reloadList_lightStoneBagList(isHoldScroll)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._lightStoneBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:reloadList_lightStoneBagList] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentScrollIndex = self._ui._lightStoneBagList:getCurrenttoIndex()
  local currentControlPos = self._ui._lightStoneBagList:GetVScroll():GetControlPos()
  listManager:clearKey()
  for subTypeIndex = 0, __eLightStoneItemSubType_Count - 1 do
    if self._lightStoneTypeFilter[subTypeIndex] ~= nil and self._lightStoneTypeFilter[subTypeIndex] == true then
      local subBagCount = ToClient_GetLightStoneBagSize(subTypeIndex)
      for index = 0, subBagCount - 1 do
        listManager:pushKey(toInt64(subTypeIndex, index))
      end
    end
  end
  local stc_emptyGuide = UI.getChildControl(self._ui._lightStoneBagList, "StaticText_Empty_LightStone")
  if stc_emptyGuide ~= nil then
    if Int64toInt32(listManager:getSize()) == 0 then
      stc_emptyGuide:SetShow(true)
    else
      stc_emptyGuide:SetShow(false)
    end
  end
  if isHoldScroll ~= nil and isHoldScroll == true then
    self._ui._lightStoneBagList:moveIndex(currentScrollIndex)
    self._ui._lightStoneBagList:GetVScroll():SetControlPos(currentControlPos)
  end
end
function PaGlobal_LightStoneBag:simpleReloadList_lightStoneBagList()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._lightStoneBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_lightStoneBagList] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentLightStoneBagContentCount = Int64toInt32(listManager:getSize())
  for index = 0, currentLightStoneBagContentCount - 1 do
    local s64_key = self._ui._lightStoneBagList:getKeyByIndex(index)
    local content = self._ui._lightStoneBagList:GetContentByKey(s64_key)
    if content ~= nil then
      self:createLightStoneBagListContent(content, s64_key)
    end
  end
end
function PaGlobal_LightStoneBag:reloadList_artifactBagList(isHoldScroll)
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._artifactBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:reloadList_artifactBagList] \236\156\160\235\172\188 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentScrollIndex = self._ui._artifactBagList:getCurrenttoIndex()
  local currentControlPos = self._ui._artifactBagList:GetVScroll():GetControlPos()
  listManager:clearKey()
  local currentArtifactBagSize = ToClient_GetArtifactBagSize()
  for index = 0, currentArtifactBagSize - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  local stc_emptyGuide = UI.getChildControl(self._ui._artifactBagList, "StaticText_Empty_Artifacts")
  if stc_emptyGuide ~= nil then
    if Int64toInt32(listManager:getSize()) == 0 then
      stc_emptyGuide:SetShow(true)
    else
      stc_emptyGuide:SetShow(false)
    end
  end
  if isHoldScroll ~= nil and isHoldScroll == true then
    self._ui._artifactBagList:moveIndex(currentScrollIndex)
    self._ui._artifactBagList:GetVScroll():SetControlPos(currentControlPos)
  end
  self:updateArtifactBagSlotCount()
end
function PaGlobal_LightStoneBag:simpleReloadList_artifactBagList()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  local listManager = self._ui._artifactBagList:getElementManager()
  if listManager == nil then
    UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_artifactBagList] \236\156\160\235\172\188 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local currentArtifactBagContentCount = Int64toInt32(listManager:getSize())
  for index = 0, currentArtifactBagContentCount - 1 do
    local s64_key = self._ui._artifactBagList:getKeyByIndex(index)
    local content = self._ui._artifactBagList:GetContentByKey(s64_key)
    if content ~= nil then
      self:createArtifactBagListContent(content, s64_key)
    end
  end
  self:updateArtifactBagSlotCount()
end
function PaGlobal_LightStoneBag:hideMouseRClickGuide()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  if self._currentTabIndex == LightStoneBagTabIndex.LightStone then
    local listManager = self._ui._lightStoneBagList:getElementManager()
    if listManager == nil then
      UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_lightStoneBagList] \234\180\145\235\170\133\236\132\157 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local currentLightStoneBagContentCount = Int64toInt32(listManager:getSize())
    for index = 0, currentLightStoneBagContentCount - 1 do
      local s64_key = self._ui._lightStoneBagList:getKeyByIndex(index)
      PaGlobalFunc_LightStoneBag_ShowMouseRClickGuide(false, s64_key)
    end
  elseif self._currentTabIndex == LightStoneBagTabIndex.Artifact then
    local listManager = self._ui._artifactBagList:getElementManager()
    if listManager == nil then
      UI.ASSERT_NAME(false, "[PaGlobal_LightStoneBag:simpleReloadList_artifactBagList] \236\156\160\235\172\188 \234\176\128\235\176\169\236\157\152 ListManager\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
      return
    end
    local currentArtifactBagContentCount = Int64toInt32(listManager:getSize())
    for index = 0, currentArtifactBagContentCount - 1 do
      local s64_key = self._ui._artifactBagList:getKeyByIndex(index)
      PaGlobalFunc_ArtifactBag_ShowMouseRClickGuide(false, s64_key)
    end
  end
end
function PaGlobal_LightStoneBag:onClickedLightStoneTypeButton(typeIndex)
  if Panel_Window_LightStoneBag == nil or typeIndex == nil then
    return
  end
  if self._currentTabIndex ~= LightStoneBagTabIndex.LightStone then
    return
  end
  if self._ui._lightStoneTypeCheckButtonList[typeIndex] == nil or self._lightStoneTypeFilter[typeIndex] == nil then
    return
  end
  self._lightStoneTypeFilter[typeIndex] = self._ui._lightStoneTypeCheckButtonList[typeIndex]:IsCheck()
  self:syncLightStoneTypeFilterButton()
  self:reloadList_lightStoneBagList(false)
end
function PaGlobal_LightStoneBag:setSnapAndArtifactToolTip(isShow, s64_key)
  PaGlobalFunc_ArtifactBag_OnPadSnap(isShow)
  PaGlobalFunc_ArtifactBag_ShowItemTooltip(isShow, s64_key)
end
function PaGlobal_LightStoneBag:setSnapAndLightStoneToolTip(isShow, s64_key)
  PaGlobalFunc_LightStoneBag_OnPadSnap(isShow)
  PaGlobalFunc_LightStoneBag_ShowItemTooltip(isShow, s64_key)
end
function PaGlobal_LightStoneBag:syncLightStoneTypeFilterButton()
  if Panel_Window_LightStoneBag == nil then
    return
  end
  for typeIndex, control in pairs(self._ui._lightStoneTypeCheckButtonList) do
    if control ~= nil and self._lightStoneTypeFilter[typeIndex] ~= nil and control:IsCheck() ~= self._lightStoneTypeFilter[typeIndex] then
      control:SetCheck(self._lightStoneTypeFilter[typeIndex])
    end
  end
end
function PaGlobal_LightStoneBag:fromClient_reloadLightStoneBagList(isFullReload)
  if Panel_Window_LightStoneBag == nil or isFullReload == nil then
    return
  end
  if isFullReload == true then
    self:reloadList_lightStoneBagList(true)
  else
    self:simpleReloadList_lightStoneBagList()
  end
end
function PaGlobal_LightStoneBag:fromClient_reloadArtifactBagList(isFullReload)
  if Panel_Window_LightStoneBag == nil or isFullReload == nil then
    return
  end
  if isFullReload == true then
    self:reloadList_artifactBagList(true)
  else
    self:simpleReloadList_artifactBagList()
  end
end
function PaGlobal_LightStoneBag:toggleArtifactItemTooltip(s64_key)
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif PaGlobalFunc_Tooltip_Item_All_GetShow() == true then
    isShow = false
  end
  PaGlobalFunc_ArtifactBag_ShowItemTooltip(isShow, s64_key)
end
function PaGlobal_LightStoneBag:toggleLightStoneItemTooltip(s64_key)
  local isShow = true
  if self._isConsole == true and ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      isShow = false
    end
  elseif PaGlobalFunc_Tooltip_Item_All_GetShow() == true then
    isShow = false
  end
  PaGlobalFunc_LightStoneBag_ShowItemTooltip(isShow, s64_key)
end
