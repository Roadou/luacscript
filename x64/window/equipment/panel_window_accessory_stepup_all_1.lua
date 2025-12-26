function PaGlobal_Window_Accessory_StepUp_All:initialize()
  if PaGlobal_Window_Accessory_StepUp_All._initialize == true then
    return
  end
  self._ui._stc_titleArea = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleArea, "Button_Close_PCUI")
  self._ui._btn_question = UI.getChildControl(self._ui._stc_titleArea, "Button_Question_PCUI")
  self._ui._stc_tabArea = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_TabArea")
  self._ui._stc_lb_consoleUI = UI.getChildControl(self._ui._stc_tabArea, "Static_LB_ConsoleUI")
  self._ui._stc_rb_consoleUI = UI.getChildControl(self._ui._stc_tabArea, "Static_RB_ConsoleUI")
  self._ui._radiobutton_stepUp = UI.getChildControl(self._ui._stc_tabArea, "Radiobutton_Tab1")
  self._ui._radiobutton_exchange = UI.getChildControl(self._ui._stc_tabArea, "Radiobutton_Tab2")
  self._ui._stc_selectBar = UI.getChildControl(self._ui._stc_tabArea, "Static_SelectBar")
  self._ui._stc_line = UI.getChildControl(self._ui._stc_tabArea, "Static_Line")
  self._ui._stc_itemSelectArea = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_ItemSelectArea")
  self._ui._multilineText_msg = UI.getChildControl(self._ui._stc_itemSelectArea, "MultilineText_Msg")
  self._ui._multilineText_notice = UI.getChildControl(self._ui._stc_itemSelectArea, "MultilineText_Notice")
  self._ui._btn_confirm = UI.getChildControl(self._ui._stc_itemSelectArea, "Button_Confirm")
  self._ui._stc_achieveTitle = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "StaticText_AchieveTitle")
  self._ui._stc_achieveCountBg = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_AchieveCountBG")
  self._ui._stc_itemStepUpArea = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_ContentsArea")
  self._ui._stc_selectItem = UI.getChildControl(self._ui._stc_itemStepUpArea, "Static_SelectItem")
  self._ui._stc_selectItem_stcItem = UI.getChildControl(self._ui._stc_selectItem, "Static_Item")
  self._ui._stc_selectItem_stcCheck = UI.getChildControl(self._ui._stc_selectItem, "Static_Complete")
  self._ui._multilineText_selectItem_itemName = UI.getChildControl(self._ui._stc_selectItem, "MultilineText_ItemName")
  self._ui._stc_progressBg = UI.getChildControl(self._ui._stc_itemStepUpArea, "Static_Total_ProgressBG")
  self._ui._progress2_total = UI.getChildControl(self._ui._stc_progressBg, "Progress2_Total")
  self._ui._stc_stepArea = UI.getChildControl(self._ui._stc_itemStepUpArea, "Static_StepArea")
  self._ui._stc_achieveNext = UI.getChildControl(self._ui._stc_itemStepUpArea, "Static_AchieveNEXT")
  self._ui._stc_achieveNextCountBG = UI.getChildControl(self._ui._stc_achieveNext, "Static_AchieveCountBG")
  self._ui._btn_selectNextAccessory = UI.getChildControl(self._ui._stc_achieveNext, "Button_SelectEquip")
  self._ui._stc_itemExchangeArea = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_ItemExchangeArea")
  self._ui._multilineText_itemExchangeMsg = UI.getChildControl(self._ui._stc_itemExchangeArea, "MultilineText_Msg")
  self._ui._stc_exchangeBG = UI.getChildControl(self._ui._stc_itemExchangeArea, "Static_ExchangeBG")
  self._ui._stc_before = UI.getChildControl(self._ui._stc_exchangeBG, "Static_Before")
  self._ui._stc_before_stcItem = UI.getChildControl(self._ui._stc_before, "Static_Item")
  self._ui._stc_before_itemName = UI.getChildControl(self._ui._stc_before, "MultilineText_ItemName")
  self._ui._stc_before_check = UI.getChildControl(self._ui._stc_before, "Static_BeforeCheck")
  self._ui._stc_after = UI.getChildControl(self._ui._stc_exchangeBG, "Static_After")
  self._ui._stc_after_stcItem = UI.getChildControl(self._ui._stc_after, "Static_Item")
  self._ui._stc_after_itemName = UI.getChildControl(self._ui._stc_after, "MultilineText_ItemName")
  self._ui._stc_after_check = UI.getChildControl(self._ui._stc_after, "Static_AfterCheck")
  self._ui._stc_exchangeEffect = UI.getChildControl(self._ui._stc_exchangeBG, "Static_ExchangeEffect")
  self._ui._txt_cost = UI.getChildControl(self._ui._stc_itemExchangeArea, "StaticText_Cost")
  self._ui._btn_exchange = UI.getChildControl(self._ui._stc_itemExchangeArea, "Button_Exchange")
  self._ui._stc_keyGuide_console = UI.getChildControl(Panel_Window_Accessory_StepUp_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._txt_x_consoleUI = UI.getChildControl(self._ui._stc_keyGuide_console, "StaticText_X_ConsoleUI")
  self._ui._txt_b_consoleUI = UI.getChildControl(self._ui._stc_keyGuide_console, "StaticText_B_ConsoleUI")
  self._ui._txt_a_consoleUI = UI.getChildControl(self._ui._stc_keyGuide_console, "StaticText_A_ConsoleUI")
  local slot = {}
  self._selectAreaItemList = {}
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  self._currentAccessoryGroupNo = accessoryStepUpManager:getAccessoryGroupNo()
  if self._currentAccessoryGroupNo == 0 then
    self._maxCurrentAccessoryIndexCount = ToClient_getAccessoryMaxGroupIndex(1)
  elseif self._currentAccessoryGroupNo == 1 then
    self._maxCurrentAccessoryIndexCount = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo)
  else
    local prevMaxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo - 1)
    local maxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo)
    self._maxCurrentAccessoryIndexCount = maxGroupIndex - (self._currentAccessoryGroupNo - 1) * prevMaxGroupIndex
  end
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    self._selectAreaItemList[accessoryIndex] = UI.getChildControl(self._ui._stc_itemSelectArea, "Button_ItemList_" .. accessoryIndex .. "")
    local stcItem = UI.getChildControl(self._selectAreaItemList[accessoryIndex], "Static_Item")
    slot = {}
    SlotItem.new(slot, "selectAreaItem_Slot_Icon" .. accessoryIndex .. "", accessoryIndex, stcItem, self._slotConfig)
    slot:createChild()
  end
  self._exchangeAreaItemList = {}
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    self._exchangeAreaItemList[accessoryIndex] = UI.getChildControl(self._ui._stc_itemExchangeArea, "CheckButton_ItemList_" .. accessoryIndex .. "")
    local stcItem = UI.getChildControl(self._exchangeAreaItemList[accessoryIndex], "Static_Item")
    slot = {}
    SlotItem.new(slot, "exchangeAreaItem_Slot_Icon" .. accessoryIndex .. "", accessoryIndex, stcItem, self._slotConfig)
    slot:createChild()
  end
  slot = {}
  SlotItem.new(slot, "SelectedItem_Slot_Icon", 0, self._ui._stc_selectItem_stcItem, self._slotConfig)
  slot:createChild()
  self._stepUpList = {}
  self._goalItemList = {}
  for enchantLevel = 0, __eMaxAccessoryStepUpEnchantLevel - 1 do
    self._stepUpList[enchantLevel] = UI.getChildControl(self._ui._stc_stepArea, "Static_Step_" .. enchantLevel + 1 .. "")
    if self._stepUpList[enchantLevel] ~= nil then
      local stcGoalitem = UI.getChildControl(self._stepUpList[enchantLevel], "Static_GoalItem")
      local stcItem = UI.getChildControl(stcGoalitem, "Static_Item")
      slot = {}
      SlotItem.new(slot, "GoalItem_Slot_Icon_" .. tostring(enchantLevel + 1) .. "", enchantLevel + 1, stcItem, self._slotConfig)
      slot:createChild()
      self._goalItemList[enchantLevel] = stcGoalitem
    end
  end
  self._materialList = {}
  for enchantLevel = 0, __eMaxAccessoryStepUpEnchantLevel - 1 do
    if self._stepUpList[enchantLevel] ~= nil then
      self._materialList[enchantLevel] = {}
      self._materialList[enchantLevel][0] = UI.getChildControl(self._stepUpList[enchantLevel], "Static_MaterialItem_L1")
      self._materialList[enchantLevel][1] = UI.getChildControl(self._stepUpList[enchantLevel], "Static_MaterialItem_R1")
      self._materialList[enchantLevel][2] = UI.getChildControl(self._stepUpList[enchantLevel], "Static_MaterialItem_L2")
      self._materialList[enchantLevel][3] = UI.getChildControl(self._stepUpList[enchantLevel], "Static_MaterialItem_R2")
      self._materialList[enchantLevel][4] = UI.getChildControl(self._stepUpList[enchantLevel], "Static_MaterialItem_L3")
    end
    for materialIndex = 0, __eMaxAccessoryStepUpMaterialCount - 1 do
      if self._materialList[enchantLevel][materialIndex] ~= nil then
        local stcItem = UI.getChildControl(self._materialList[enchantLevel][materialIndex], "Static_Item")
        slot = {}
        SlotItem.new(slot, "Material_Slot_Icon_", materialIndex, stcItem, self._slotConfig)
        slot:createChild()
      end
    end
  end
  slot = {}
  SlotItem.new(slot, "ExchangeBeforeItem_Slot_Icon", 0, self._ui._stc_before_stcItem, self._slotConfig)
  slot:createChild()
  slot = {}
  SlotItem.new(slot, "ExchangeAfterItem_Slot_Icon", 0, self._ui._stc_after_stcItem, self._slotConfig)
  slot:createChild()
  self._originPanelPosY = Panel_Window_Accessory_StepUp_All:GetPosY()
  local btnGet = UI.getChildControl(self._stepUpList[0], "Button_Get")
  local btnGetText = UI.getChildControl(btnGet, "StaticText_Get")
  self._originStepUpGetBtnTxtPosX = btnGetText:GetPosX()
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._isConsole = ToClient_isConsole()
  PaGlobal_Window_Accessory_StepUp_All:registEventHandler()
  PaGlobal_Window_Accessory_StepUp_All:validate()
  PaGlobal_Window_Accessory_StepUp_All._initialize = true
end
function PaGlobal_Window_Accessory_StepUp_All:registEventHandler()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  self._ui._btn_confirm:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_BtnMouseEffect(true, 0)")
  self._ui._btn_confirm:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_BtnMouseEffect(false, 0)")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:selectStepUpAccessory()")
  self._ui._btn_exchange:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_BtnMouseEffect(true, 1)")
  self._ui._btn_exchange:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_BtnMouseEffect(false, 1)")
  self._ui._btn_exchange:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:exchangeStepUpAccessory()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All_Close()")
  self._ui._radiobutton_stepUp:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:selectTab(0)")
  self._ui._radiobutton_exchange:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:selectTab(1)")
  self._ui._btn_selectNextAccessory:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:selectNextAccessory()")
  if self._isPadSnapping == true then
    Panel_Window_Accessory_StepUp_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobal_Window_Accessory_StepUp_All:selectTab(0)")
    Panel_Window_Accessory_StepUp_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobal_Window_Accessory_StepUp_All:selectTab(1)")
  end
  registerEvent("FromClient_UpdateAccessoryStepUp", "FromClient_UpdateAccessoryStepUp")
  Panel_Window_Accessory_StepUp_All:RegisterUpdateFunc("PaGloabl_Window_Accessory_StepUp_All_Update")
end
function PaGlobal_Window_Accessory_StepUp_All:prepareOpen()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  if self._isPadSnapping == true then
    if PaGlobal_InventoryEquip_Detail_Renew_Close ~= nil and Panel_Window_Inventory_Detail ~= nil and Panel_Window_Inventory_Detail:GetShow() == true then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
    end
    if PaGlobalFunc_TrashBoxConfirm_All_Close ~= nil and Panel_Window_TrashBoxConfirm_All ~= nil and Panel_Window_TrashBoxConfirm_All:GetShow() == true then
      PaGlobalFunc_TrashBoxConfirm_All_Close()
    end
    if PaGlobalFunc_WebPurchaseConfirm_All_Close ~= nil and Panel_Window_WebPurchaseConfirm_All ~= nil and Panel_Window_WebPurchaseConfirm_All:GetShow() == true then
      PaGlobalFunc_WebPurchaseConfirm_All_Close()
    end
    PaGlobalFunc_InventoryInfo_Close()
    self:showConsoleUI(true)
  else
    PaGlobalFunc_Inventory_All_SetShow(false)
    self:showConsoleUI(false)
  end
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  self._maxAccessoryGroupNo = ToClient_getAccessoryMaxGroupNo()
  self._currentAccessoryGroupNo = accessoryStepUpManager:getAccessoryGroupNo()
  self._currentAccessoryIndex = accessoryStepUpManager:getAccessoryIndex()
  self._currentAccessoryEnchantLevel = accessoryStepUpManager:getAccessoryEnchantLevel()
  self._completeAccessoryGroupNo = accessoryStepUpManager:getAccessoryCompleteGroupNo()
  if self._currentAccessoryGroupNo == 0 then
    self._maxCurrentAccessoryIndexCount = ToClient_getAccessoryMaxGroupIndex(1)
  elseif self._currentAccessoryGroupNo == 1 then
    self._maxCurrentAccessoryIndexCount = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo)
  else
    local prevMaxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo - 1)
    local maxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo)
    self._maxCurrentAccessoryIndexCount = maxGroupIndex - (self._currentAccessoryGroupNo - 1) * prevMaxGroupIndex
  end
  self._selectAccessoryIndex = 0
  self._registMaterialIndex = -1
  self._registMaterialCount = 0
  self._registMaterialSlotNo = 0
  self._exchangeState = self._eExchangeState._STATE_SELECT_BEFORE
  self._ui._stc_selectItem:AddEffect("fUI_Jewelry_Change_01B", true)
  if self._completeAccessoryGroupNo ~= self._maxAccessoryGroupNo then
    PaGlobal_Window_Accessory_StepUp_All:selectTab(0)
  else
    PaGlobal_Window_Accessory_StepUp_All:selectTab(1)
  end
  PaGlobal_Window_Accessory_StepUp_All:open()
end
function PaGlobal_Window_Accessory_StepUp_All:open()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  Panel_Window_Accessory_StepUp_All:SetShow(true)
end
function PaGlobal_Window_Accessory_StepUp_All:prepareClose()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
  self:eraseAllAreaEffect()
  self._ui._stc_selectItem:EraseAllEffect()
  if self._timerNo ~= nil then
    luaTimer_RemoveEvent(self._timerNo)
    self._timerNo = nil
  end
  self._ui._btn_confirm:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_confirm, self._btnConfirmUV[0].x1, self._btnConfirmUV[0].y1, self._btnConfirmUV[0].x2, self._btnConfirmUV[0].y2)
  self._ui._btn_confirm:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._btn_confirm:setRenderTexture(self._ui._btn_confirm:getBaseTexture())
  self._ui._btn_exchange:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_exchange, self._btnConfirmUV[0].x1, self._btnConfirmUV[0].y1, self._btnConfirmUV[0].x2, self._btnConfirmUV[0].y2)
  self._ui._btn_exchange:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._btn_exchange:setRenderTexture(self._ui._btn_exchange:getBaseTexture())
  PaGlobal_Window_Accessory_StepUp_All:close()
end
function PaGlobal_Window_Accessory_StepUp_All:close()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  Panel_Window_Accessory_StepUp_All:SetShow(false)
end
function PaGlobal_Window_Accessory_StepUp_All:selectTab(tabNum)
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  self._exchangeBeforeIndex = nil
  self._exchangeAfterIndex = nil
  self._exchangeState = self._eExchangeState._STATE_SELECT_BEFORE
  self._selectAccessoryIndex = 0
  if self._timerNo ~= nil then
    luaTimer_RemoveEvent(self._timerNo)
    self._timerNo = nil
  end
  local updateType = 1
  if tabNum == 0 then
    local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
    local showSelectArea = false
    if accessoryStepUpManager:isProgressing() == false or self._currentAccessoryEnchantLevel == __eMaxAccessoryStepUpEnchantLevel and self._currentAccessoryGroupNo < self._maxAccessoryGroupNo and self._currentAccessoryGroupNo == self._completeAccessoryGroupNo then
      showSelectArea = true
    end
    if showSelectArea == true then
      updateType = 0
    else
      updateType = 1
    end
    self._ui._stc_selectBar:SetPosX(self._ui._radiobutton_stepUp:GetPosX() + self._ui._radiobutton_stepUp:GetSizeX() / 2 - self._ui._stc_selectBar:GetSizeX() / 2)
    self._ui._radiobutton_stepUp:SetCheck(true)
  else
    updateType = 2
    self._ui._stc_selectBar:SetPosX(self._ui._radiobutton_exchange:GetPosX() + self._ui._radiobutton_exchange:GetSizeX() / 2 - self._ui._stc_selectBar:GetSizeX() / 2)
    self._ui._radiobutton_exchange:SetCheck(true)
  end
  self:eraseAllAreaEffect()
  self:update(updateType)
end
function PaGlobal_Window_Accessory_StepUp_All:update(updateType)
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  self._currentAccessoryGroupNo = accessoryStepUpManager:getAccessoryGroupNo()
  self._currentAccessoryIndex = accessoryStepUpManager:getAccessoryIndex()
  self._currentAccessoryEnchantLevel = accessoryStepUpManager:getAccessoryEnchantLevel()
  self._completeAccessoryGroupNo = accessoryStepUpManager:getAccessoryCompleteGroupNo()
  if self._currentAccessoryGroupNo == 0 then
    self._maxCurrentAccessoryIndexCount = ToClient_getAccessoryMaxGroupIndex(1)
  elseif self._currentAccessoryGroupNo == 1 then
    self._maxCurrentAccessoryIndexCount = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo)
  else
    local prevMaxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo - 1)
    local maxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo)
    self._maxCurrentAccessoryIndexCount = maxGroupIndex - (self._currentAccessoryGroupNo - 1) * prevMaxGroupIndex
  end
  self:eraseAllStepUpAreaEffect()
  if updateType == nil then
    updateType = self._eUpdateType._TYPE_SELECT
  end
  if updateType == self._eUpdateType._TYPE_SELECT then
    self:updatgeAchieveBg()
    self:updateSelectArea()
    self._ui._stc_itemSelectArea:SetShow(true)
    self._ui._stc_itemStepUpArea:SetShow(false)
    self._ui._stc_itemExchangeArea:SetShow(false)
  elseif updateType == self._eUpdateType._TYPE_STEPUP then
    self:updatgeAchieveBg()
    self:updateStepUpArea()
    self._ui._stc_itemSelectArea:SetShow(false)
    self._ui._stc_itemStepUpArea:SetShow(true)
    self._ui._stc_itemExchangeArea:SetShow(false)
  elseif updateType == self._eUpdateType._TYPE_EXCHANGE then
    self:updateExchangeArea()
    self._ui._stc_itemSelectArea:SetShow(false)
    self._ui._stc_itemStepUpArea:SetShow(false)
    self._ui._stc_itemExchangeArea:SetShow(true)
  end
end
function PaGlobal_Window_Accessory_StepUp_All:updatgeAchieveBg()
  for completeIndex = 0, self._completeAccessoryGroupNo - 1 do
    local stcAchieveCount = UI.getChildControl(self._ui._stc_achieveCountBg, "Static_Achieve_" .. completeIndex .. "")
    stcAchieveCount:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stcAchieveCount, self._stepDotCompleteUv[0].x1, self._stepDotCompleteUv[0].y1, self._stepDotCompleteUv[0].x2, self._stepDotCompleteUv[0].y2)
    stcAchieveCount:getBaseTexture():setUV(x1, y1, x2, y2)
    stcAchieveCount:setRenderTexture(stcAchieveCount:getBaseTexture())
  end
  for notCompleteIndex = self._completeAccessoryGroupNo, self._maxAccessoryGroupNo - 1 do
    local stcAchieveCount = UI.getChildControl(self._ui._stc_achieveCountBg, "Static_Achieve_" .. notCompleteIndex .. "")
    stcAchieveCount:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stcAchieveCount, self._stepDotCompleteUv[2].x1, self._stepDotCompleteUv[2].y1, self._stepDotCompleteUv[2].x2, self._stepDotCompleteUv[2].y2)
    stcAchieveCount:getBaseTexture():setUV(x1, y1, x2, y2)
    stcAchieveCount:setRenderTexture(stcAchieveCount:getBaseTexture())
  end
  if 0 < self._currentAccessoryGroupNo and self._currentAccessoryGroupNo ~= self._completeAccessoryGroupNo then
    local stcAchieveCount = UI.getChildControl(self._ui._stc_achieveCountBg, "Static_Achieve_" .. self._currentAccessoryGroupNo - 1 .. "")
    stcAchieveCount:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stcAchieveCount, self._stepDotCompleteUv[1].x1, self._stepDotCompleteUv[1].y1, self._stepDotCompleteUv[1].x2, self._stepDotCompleteUv[1].y2)
    stcAchieveCount:getBaseTexture():setUV(x1, y1, x2, y2)
    stcAchieveCount:setRenderTexture(stcAchieveCount:getBaseTexture())
  end
end
function PaGlobal_Window_Accessory_StepUp_All:updateSelectArea()
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    local stcItem = UI.getChildControl(self._selectAreaItemList[accessoryIndex], "Static_Item")
    local txtItemName = UI.getChildControl(self._selectAreaItemList[accessoryIndex], "MultilineText_ItemName")
    local itemKey = ToClient_getAccessoryStepUpItemKey(accessoryIndex + 1)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    local slot = {}
    SlotItem.reInclude(slot, "selectAreaItem_Slot_Icon" .. accessoryIndex .. "", accessoryIndex, stcItem, self._slotConfig)
    slot:clearItem()
    slot.icon:SetIgnore(true)
    if itemSSW ~= nil then
      slot:setItemByStaticStatus(itemSSW)
      txtItemName:SetText(itemSSW:getName())
    end
    stcItem:SetIgnore(false)
    if self._isConsole == false then
      stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 0, " .. accessoryIndex .. ")")
      stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
      self._selectAreaItemList[accessoryIndex]:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:clickStepUpAccessory(" .. accessoryIndex + 1 .. ")")
    else
      self._selectAreaItemList[accessoryIndex]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 0, " .. accessoryIndex .. ")")
      self._selectAreaItemList[accessoryIndex]:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
    end
    stcItem:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:clickStepUpAccessory(" .. accessoryIndex + 1 .. ")")
    self._ui._btn_confirm:SetIgnore(true)
    self._ui._btn_confirm:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_confirm, self._btnConfirmUV[0].x1, self._btnConfirmUV[0].y1, self._btnConfirmUV[0].x2, self._btnConfirmUV[0].y2)
    self._ui._btn_confirm:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._btn_confirm:setRenderTexture(self._ui._btn_confirm:getBaseTexture())
  end
end
function PaGlobal_Window_Accessory_StepUp_All:updateStepUpArea()
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  local finishAccessoryStepUp = false
  if self._currentAccessoryEnchantLevel == __eMaxAccessoryStepUpEnchantLevel and self._currentAccessoryGroupNo == self._completeAccessoryGroupNo then
    finishAccessoryStepUp = true
  end
  if self._isPadSnapping == true then
    PaGlobal_Window_Accessory_StepUp_All_SetStepUpAreaSnappingIgnore(false)
  end
  local itemKey = ToClient_getAccessoryStepUpItemKey(self._currentAccessoryIndex)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
  local slot = {}
  SlotItem.reInclude(slot, "SelectedItem_Slot_Icon", 0, self._ui._stc_selectItem_stcItem, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  if itemSSW ~= nil then
    slot:setItemByStaticStatus(itemSSW)
    self._ui._multilineText_selectItem_itemName:SetText(PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemSSW:getName(), itemSSW))
    if finishAccessoryStepUp == true then
      if self._ui._stc_selectItem_stcCheck:GetShow() == false then
        self._ui._stc_selectItem_stcCheck:AddEffect("fUI_Jewelry_Change_Complete_01A")
        audioPostEvent_SystemUi(5, 94)
        _AudioPostEvent_SystemUiForXBOX(5, 94)
      end
      self._ui._stc_selectItem_stcCheck:SetShow(true)
    else
      self._ui._stc_selectItem_stcCheck:SetShow(false)
    end
    self._ui._stc_selectItem_stcItem:SetIgnore(false)
    if self._isConsole == false then
      self._ui._stc_selectItem_stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 1, 0, true)")
      self._ui._stc_selectItem_stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
    else
      self._ui._stc_selectItem:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 1, 0, true)")
      self._ui._stc_selectItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
    end
  end
  self._ui._progress2_total:SetProgressRate(math.floor((self._currentAccessoryEnchantLevel - 1) / (__eMaxAccessoryStepUpEnchantLevel - 1) * 100))
  for enchantLevel = 1, __eMaxAccessoryStepUpEnchantLevel do
    local stcProgressDeco = UI.getChildControl(self._ui._stc_progressBg, "Static_Deco_" .. enchantLevel .. "")
    if enchantLevel <= self._currentAccessoryEnchantLevel then
      stcProgressDeco:SetShow(true)
    else
      stcProgressDeco:SetShow(false)
    end
  end
  for enchantLevel = 0, __eMaxAccessoryStepUpEnchantLevel - 1 do
    local stepUpState = self._eStepUpState._STATE_FINISH
    local accessoryEnchantLevel = enchantLevel + 1
    if accessoryEnchantLevel < self._currentAccessoryEnchantLevel or finishAccessoryStepUp == true then
      stepUpState = self._eStepUpState._STATE_FINISH
    elseif self._currentAccessoryEnchantLevel == accessoryEnchantLevel then
      stepUpState = self._eStepUpState._STATE_PROGRESS
    else
      stepUpState = self._eStepUpState._STATE_BEFORE
    end
    local stepBg = self._stepUpList[enchantLevel]
    local materialReadyCount = 0
    for materialIndex = 0, __eMaxAccessoryStepUpMaterialCount - 1 do
      local materialBg = self._materialList[enchantLevel][materialIndex]
      local stcItem = UI.getChildControl(materialBg, "Static_Item")
      local stcItem_snap = UI.getChildControl(materialBg, "Static_Item_Snap")
      local itemEnchantKey = ToClient_getAccessoryStepUpMaterialItemEnchantKey(self._currentAccessoryIndex, enchantLevel, materialIndex)
      local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
      local slot = {}
      SlotItem.reInclude(slot, "Material_Slot_Icon_", materialIndex, stcItem, self._slotConfig)
      slot:clearItem()
      slot.icon:SetIgnore(true)
      if itemSSW ~= nil then
        slot:setItemByStaticStatus(itemSSW)
        stcItem:SetIgnore(false)
        if self._isConsole == false then
          stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 1, " .. enchantLevel .. ", false, " .. materialIndex .. ")")
          stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
        else
          stcItem:SetIgnore(true)
          stcItem_snap:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 1, " .. enchantLevel .. ", false, " .. materialIndex .. ")")
        end
      end
      if materialIndex == __eMaxAccessoryStepUpMaterialCount - 1 and materialReadyCount < __eMaxAccessoryStepUpMaterialCount - 1 then
        stcItem:SetMonoTone(true)
      else
        stcItem:SetMonoTone(false)
      end
      local txtCount = UI.getChildControl(materialBg, "StaticText_Count")
      local progressBg = UI.getChildControl(materialBg, "Static_ProgressBG")
      local materialProgressBg = UI.getChildControl(progressBg, "CircularProgress_1")
      local materialUseCount = 0
      if stepUpState == self._eStepUpState._STATE_PROGRESS then
        materialUseCount = Int64toInt32(accessoryStepUpManager:getMaterialParamCount(materialIndex))
      end
      local materialMaxCount = ToClient_getAccessoryStepUpMaterialNeedCount(self._currentAccessoryIndex, enchantLevel, materialIndex)
      if stepUpState == self._eStepUpState._STATE_FINISH then
        if self._isConsole == false then
          stcItem:removeInputEvent("Mouse_LUp")
        else
          stcItem_snap:removeInputEvent("Mouse_LUp")
        end
        txtCount:SetText("<PAColor0xFFFFCE22>" .. materialMaxCount .. "<PAOldColor> / " .. materialMaxCount .. "")
        materialProgressBg:SetProgressRate(100)
      elseif stepUpState == self._eStepUpState._STATE_PROGRESS then
        if materialUseCount == materialMaxCount then
          txtCount:SetText("<PAColor0xFFFFCE22>" .. materialUseCount .. "<PAOldColor> / " .. materialMaxCount .. "")
        else
          txtCount:SetText("<PAColor0xFFF26A6A>" .. materialUseCount .. "<PAOldColor> / " .. materialMaxCount .. "")
        end
        materialProgressBg:SetProgressRate(math.floor(materialUseCount / materialMaxCount * 100))
        if materialUseCount < materialMaxCount then
          if self._isConsole == false then
            stcItem:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:registMaterial(" .. enchantLevel .. "," .. materialIndex .. ")")
          else
            stcItem_snap:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:registMaterial(" .. enchantLevel .. "," .. materialIndex .. ")")
          end
        elseif self._isConsole == false then
          stcItem:removeInputEvent("Mouse_LUp")
        else
          stcItem_snap:removeInputEvent("Mouse_LUp")
        end
      else
        if self._isConsole == false then
          stcItem:removeInputEvent("Mouse_LUp")
        else
          stcItem_snap:removeInputEvent("Mouse_LUp")
        end
        txtCount:SetText("<PAColor0xFFF26A6A>0<PAOldColor> / " .. materialMaxCount .. "")
        materialProgressBg:SetProgressRate(0)
      end
      local checkBg = UI.getChildControl(materialBg, "Static_Complete")
      if stepUpState == self._eStepUpState._STATE_FINISH or stepUpState == self._eStepUpState._STATE_PROGRESS and materialUseCount >= materialMaxCount then
        if checkBg:GetShow() == false then
          checkBg:AddEffect("fUI_Jewelry_Change_Check_01A")
          audioPostEvent_SystemUi(0, 29)
          _AudioPostEvent_SystemUiForXBOX(0, 29)
          checkBg:SetShow(true)
        end
        materialReadyCount = materialReadyCount + 1
      else
        checkBg:SetShow(false)
      end
      local uvIndex = 0
      if stepUpState == self._eStepUpState._STATE_BEFORE or stepUpState == self._eStepUpState._STATE_PROGRESS and materialUseCount < materialMaxCount then
        if materialIndex % 2 == 0 then
          uvIndex = 0
        else
          uvIndex = 1
        end
      elseif materialIndex % 2 == 0 then
        uvIndex = 2
      else
        uvIndex = 3
      end
      materialBg:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(materialBg, self._stepMeterialGaugeUV[uvIndex].x1, self._stepMeterialGaugeUV[uvIndex].y1, self._stepMeterialGaugeUV[uvIndex].x2, self._stepMeterialGaugeUV[uvIndex].y2)
      materialBg:getBaseTexture():setUV(x1, y1, x2, y2)
      materialBg:setRenderTexture(materialBg:getBaseTexture())
    end
    local itemKey = ToClient_getAccessoryStepUpItemKey(self._currentAccessoryIndex)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, accessoryEnchantLevel))
    local stcGoalItem = self._goalItemList[enchantLevel]
    local stcItem = UI.getChildControl(stcGoalItem, "Static_Item")
    local checkBg = UI.getChildControl(stcGoalItem, "Static_Complete")
    local slot = {}
    SlotItem.reInclude(slot, "GoalItem_Slot_Icon_" .. tostring(enchantLevel + 1) .. "", enchantLevel, stcItem, self._slotConfig)
    slot:clearItem()
    slot.icon:SetIgnore(true)
    if itemSSW ~= nil then
      slot:setItemByStaticStatus(itemSSW)
      stcItem:SetIgnore(false)
      if self._isConsole == false then
        stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 1, " .. enchantLevel .. ", false)")
        stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
      else
        stcGoalItem:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 1, " .. enchantLevel .. ", false)")
        stcGoalItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
      end
    end
    if stepUpState == self._eStepUpState._STATE_FINISH or stepUpState == self._eStepUpState._STATE_PROGRESS and materialReadyCount == __eMaxAccessoryStepUpMaterialCount then
      stcItem:SetMonoTone(false)
    else
      stcItem:SetMonoTone(true)
    end
    if stepUpState == self._eStepUpState._STATE_FINISH then
      if checkBg:GetShow() == false then
        checkBg:AddEffect("fUI_Jewelry_Change_Check_01A")
        audioPostEvent_SystemUi(0, 29)
        _AudioPostEvent_SystemUiForXBOX(0, 29)
        checkBg:SetShow(true)
        local getItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, accessoryEnchantLevel - 1))
        if getItemSSW ~= nil then
          local getItemName = HighAccessoryEnchantLevel_ReplaceString(accessoryEnchantLevel) .. " " .. getItemSSW:getName()
          PaGloabl_Widget_Nak_AccessoryStepUp_All_Open(1, getItemName)
        end
      end
    else
      checkBg:SetShow(false)
    end
    local goalItemProgressBg = UI.getChildControl(stcGoalItem, "CircularProgress_1")
    local btnGet = UI.getChildControl(stepBg, "Button_Get")
    local btnGetText = UI.getChildControl(btnGet, "StaticText_Get")
    local diff = btnGet:GetSizeX() / 2 - (self._originStepUpGetBtnTxtPosX + (btnGetText:GetSizeX() + btnGetText:GetTextSizeX()) / 2) - 5
    btnGetText:SetPosX(self._originStepUpGetBtnTxtPosX + diff)
    if stepUpState == self._eStepUpState._STATE_FINISH then
      goalItemProgressBg:SetProgressRate(100)
    else
      goalItemProgressBg:SetProgressRate(math.floor(materialReadyCount / __eMaxAccessoryStepUpMaterialCount * 100))
    end
    if stepUpState == self._eStepUpState._STATE_PROGRESS and materialReadyCount == __eMaxAccessoryStepUpMaterialCount then
      btnGet:SetIgnore(false)
      btnGet:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:getStepUpAccessory(" .. enchantLevel .. ")")
      btnGet:SetShow(true)
      btnGet:AddEffect("fUI_Jewelry_Change_Button_01A", true)
      if self._isPadSnapping == true then
        ToClient_padSnapChangeToTarget(btnGet)
      end
    else
      btnGet:SetIgnore(true)
      btnGet:SetShow(false)
      btnGet:EraseAllEffect()
    end
    stepBg:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stepBg, self._stepTextureUV[stepUpState].x1, self._stepTextureUV[stepUpState].y1, self._stepTextureUV[stepUpState].x2, self._stepTextureUV[stepUpState].y2)
    stepBg:getBaseTexture():setUV(x1, y1, x2, y2)
    stepBg:setRenderTexture(stepBg:getBaseTexture())
    if stepUpState == self._eStepUpState._STATE_PROGRESS then
      stepBg:AddEffect("fUI_Jewelry_Change_Page_01A", true)
    else
      stepBg:EraseAllEffect()
    end
    local stcProgressBgOn = UI.getChildControl(stepBg, "Static_ProgressBG_On")
    if stepUpState == self._eStepUpState._STATE_FINISH or stepUpState == self._eStepUpState._STATE_PROGRESS and materialReadyCount == __eMaxAccessoryStepUpMaterialCount then
      stcProgressBgOn:SetShow(true)
    else
      stcProgressBgOn:SetShow(false)
    end
  end
  if finishAccessoryStepUp == true and self._currentAccessoryGroupNo ~= self._maxAccessoryGroupNo then
    self._ui._stc_achieveNext:SetIgnore(true)
    self._timerNo = luaTimer_AddEvent(PaGlobal_Window_Accessory_StepUp_All_ShowAchieveNext, 3000, false, 0)
  else
    self._ui._stc_achieveNext:SetShow(false)
  end
end
function PaGlobal_Window_Accessory_StepUp_All:updateExchangeArea()
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    local stcExchangeItem = self._exchangeAreaItemList[accessoryIndex]
    local stcItem = UI.getChildControl(stcExchangeItem, "Static_Item")
    local txtItemName = UI.getChildControl(stcExchangeItem, "MultilineText_ItemName")
    local itemKey = ToClient_getAccessoryStepUpItemKey(accessoryIndex + 1)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
    stcExchangeItem:SetIgnore(false)
    stcExchangeItem:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:clickExchangeAccessory(" .. accessoryIndex + 1 .. ")")
    stcItem:SetMonoTone(false)
    txtItemName:SetMonoTone(false)
    local slot = {}
    SlotItem.reInclude(slot, "exchangeAreaItem_Slot_Icon" .. accessoryIndex .. "", accessoryIndex, stcItem, self._slotConfig)
    slot:clearItem()
    slot.icon:SetIgnore(true)
    if itemSSW ~= nil then
      slot:setItemByStaticStatus(itemSSW)
      if accessoryIndex + 1 == self._exchangeBeforeIndex or accessoryIndex + 1 == self._exchangeAfterIndex then
        txtItemName:SetText(PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemSSW:getName(), itemSSW))
      else
        txtItemName:SetText(itemSSW:getName())
      end
      if self._exchangeState == self._eExchangeState._STATE_SELECT_BEFORE then
        local itemCount = Int64toInt32(ToClient_InventoryGetItemCount(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel)))
        if itemCount <= 0 then
          stcItem:SetMonoTone(true)
          txtItemName:SetMonoTone(true)
        end
      end
    end
    stcItem:SetIgnore(false)
    if self._isConsole == false then
      stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 2, " .. accessoryIndex .. ")")
      stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
    else
      stcExchangeItem:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 2, " .. accessoryIndex .. ")")
      stcExchangeItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
    end
    stcItem:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All:clickExchangeAccessory(" .. accessoryIndex + 1 .. ")")
    local stcBeforeCheck = UI.getChildControl(stcExchangeItem, "Static_BeforeCheck")
    local stcAfterCheck = UI.getChildControl(stcExchangeItem, "Static_AfterCheck")
    if accessoryIndex + 1 == self._exchangeBeforeIndex then
      stcBeforeCheck:SetShow(true)
      stcAfterCheck:SetShow(false)
    elseif accessoryIndex + 1 == self._exchangeAfterIndex then
      stcBeforeCheck:SetShow(false)
      stcAfterCheck:SetShow(true)
    else
      stcBeforeCheck:SetShow(false)
      stcAfterCheck:SetShow(false)
    end
  end
  local slot = {}
  SlotItem.reInclude(slot, "ExchangeBeforeItem_Slot_Icon", 0, self._ui._stc_before_stcItem, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  self._ui._stc_before_check:SetShow(false)
  if self._exchangeBeforeIndex ~= nil then
    local beforeItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeBeforeIndex)
    local beforeItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(beforeItemKey, __eMaxAccessoryStepUpEnchantLevel))
    if beforeItemSSW ~= nil then
      slot:setItemByStaticStatus(beforeItemSSW)
      self._ui._stc_before_itemName:SetText(beforeItemSSW:getName())
      self._ui._stc_before_check:SetShow(true)
      self._ui._stc_before_stcItem:SetIgnore(false)
      if self._isConsole == false then
        self._ui._stc_before_stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 2, 0, nil, nil, true)")
        self._ui._stc_before_stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
      end
    end
  else
    self._ui._stc_before_stcItem:SetIgnore(true)
  end
  slot = {}
  SlotItem.reInclude(slot, "ExchangeAfterItem_Slot_Icon", 0, self._ui._stc_after_stcItem, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  self._ui._stc_after_check:SetShow(false)
  if self._exchangeAfterIndex ~= nil then
    local afterItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeAfterIndex)
    local afterItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(afterItemKey, __eMaxAccessoryStepUpEnchantLevel))
    if afterItemSSW ~= nil then
      slot:setItemByStaticStatus(afterItemSSW)
      self._ui._stc_after_itemName:SetText(afterItemSSW:getName())
      self._ui._stc_after_check:SetShow(true)
      self._ui._stc_after_stcItem:SetIgnore(false)
      if self._isConsole == false then
        self._ui._stc_after_stcItem:addInputEvent("Mouse_On", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(true, 2, 0, nil, nil, false)")
        self._ui._stc_after_stcItem:addInputEvent("Mouse_Out", "PaGlobal_Window_Accessory_StepUp_All_ShowAccessoryToolTip(false)")
      end
    end
  else
    self._ui._stc_after_stcItem:SetIgnore(true)
  end
  self._ui._btn_exchange:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_exchange, self._btnConfirmUV[0].x1, self._btnConfirmUV[0].y1, self._btnConfirmUV[0].x2, self._btnConfirmUV[0].y2)
  self._ui._btn_exchange:SetIgnore(true)
  self._ui._multilineText_itemExchangeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGE_1"))
  if self._exchangeState == self._eExchangeState._STATE_SELECT_BEFORE then
    self._ui._multilineText_itemExchangeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGE_1"))
  elseif self._exchangeState == self._eExchangeState._STATE_SELECT_AFTER then
    self._ui._multilineText_itemExchangeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGE_2"))
  elseif self._exchangeState == self._eExchangeState._STATE_EXCHANGE_READY then
    self._ui._multilineText_itemExchangeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGE_3"))
    self._ui._btn_exchange:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_exchange, self._btnConfirmUV[1].x1, self._btnConfirmUV[1].y1, self._btnConfirmUV[1].x2, self._btnConfirmUV[1].y2)
    self._ui._btn_exchange:SetIgnore(false)
  end
  self._ui._btn_exchange:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._btn_exchange:setRenderTexture(self._ui._btn_exchange:getBaseTexture())
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  local freeExchangeCount = accessoryStepUpManager:getAccessoryFreeExchangeCount()
  if freeExchangeCount > 0 then
    self._ui._btn_exchange:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGEFREE", "current", freeExchangeCount, "max", __eMaxAccessoryStepUpFreeExchangeCount))
    self._ui._txt_cost:SetShow(false)
  else
    self._ui._btn_exchange:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIP_DONGUPGRADE_TAP2"))
    local needCount_64 = Uint64toInt64(ToClient_GetAccessoryStepUpExchangeCost())
    local haveCount_64 = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
    local haveCount = ""
    if needCount_64 <= haveCount_64 then
      haveCount = "<PAColor0xFFFFCE22>" .. makeDotMoney(haveCount_64) .. "<PAOldColor>"
    else
      haveCount = "<PAColor0xFFF26A6A>" .. makeDotMoney(haveCount_64) .. "<PAOldColor>"
    end
    self._ui._txt_cost:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_COST", "havecount", haveCount, "needcount", makeDotMoney(needCount_64)))
    self._ui._txt_cost:SetPosX(Panel_Window_Accessory_StepUp_All:GetSizeX() / 2 - (self._ui._txt_cost:GetTextSizeX() / 2 + self._ui._txt_cost:GetSizeX()))
    self._ui._txt_cost:SetShow(true)
  end
end
function PaGlobal_Window_Accessory_StepUp_All:clickStepUpAccessory(selectAccessoryIndex)
  if self._currentAccessoryGroupNo <= 1 then
    if self._selectAccessoryIndex == selectAccessoryIndex then
      return
    end
    self._selectAccessoryIndex = selectAccessoryIndex
  else
    local prevMaxGroupIndex = ToClient_getAccessoryMaxGroupIndex(self._currentAccessoryGroupNo - 1)
    local calculatedSelectAccessoryIndex = selectAccessoryIndex + (self._currentAccessoryGroupNo - 1) * prevMaxGroupIndex
    if self._selectAccessoryIndex == calculatedSelectAccessoryIndex then
      return
    end
    self._selectAccessoryIndex = calculatedSelectAccessoryIndex
  end
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    local txtItemName = UI.getChildControl(self._selectAreaItemList[accessoryIndex], "MultilineText_ItemName")
    local itemKey = ToClient_getAccessoryStepUpItemKey(accessoryIndex + 1)
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if itemSSW ~= nil then
      if accessoryIndex == self._selectAccessoryIndex - 1 then
        txtItemName:SetText(PAGlobalFunc_ReturnAppliedItemColorTextForNewUI(itemSSW:getName(), itemSSW))
        self._selectAreaItemList[accessoryIndex]:AddEffect("fUI_Jewelry_Change_01A", true)
        audioPostEvent_SystemUi(5, 89)
        _AudioPostEvent_SystemUiForXBOX(5, 89)
      else
        txtItemName:SetText(itemSSW:getName())
        self._selectAreaItemList[accessoryIndex]:EraseAllEffect()
      end
    end
  end
  self._ui._btn_confirm:SetIgnore(false)
  self._ui._btn_confirm:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Equipment_Confirmation_3.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._btn_confirm, self._btnConfirmUV[1].x1, self._btnConfirmUV[1].y1, self._btnConfirmUV[1].x2, self._btnConfirmUV[1].y2)
  self._ui._btn_confirm:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._btn_confirm:setRenderTexture(self._ui._btn_confirm:getBaseTexture())
end
function PaGlobal_Window_Accessory_StepUp_All:selectStepUpAccessory()
  if self._selectAccessoryIndex <= 0 then
    return
  end
  local itemKey = ToClient_getAccessoryStepUpItemKey(self._selectAccessoryIndex)
  if itemKey ~= nil then
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_SELECTCONFIRM", "itemName", PaGlobalFunc_Util_GetItemGradeColorName(ItemEnchantKey(itemKey))),
      functionYes = PaGlobal_Window_Accessory_StepUp_All_SelectStepUpAccessory,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  end
end
function PaGlobal_Window_Accessory_StepUp_All:registMaterial(enchantLevel, materialIndex)
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  if materialIndex == __eMaxAccessoryStepUpMaterialCount - 1 then
    local registFinishCount = 0
    for materialCount = 0, __eMaxAccessoryStepUpMaterialCount - 2 do
      local materialMaxCount = ToClient_getAccessoryStepUpMaterialNeedCount(self._currentAccessoryIndex, enchantLevel, materialCount)
      local materialRegistCount = Int64toInt32(accessoryStepUpManager:getMaterialParamCount(materialCount))
      if materialRegistCount == materialMaxCount then
        registFinishCount = registFinishCount + 1
      end
    end
    if registFinishCount ~= __eMaxAccessoryStepUpMaterialCount - 1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EQUIPRESIST_YET"))
      return
    end
  end
  local itemEnchantKey = ToClient_getAccessoryStepUpMaterialItemEnchantKey(self._currentAccessoryIndex, enchantLevel, materialIndex)
  local materialMaxCount = ToClient_getAccessoryStepUpMaterialNeedCount(self._currentAccessoryIndex, enchantLevel, materialIndex)
  local inventoryItemCount = Int64toInt32(ToClient_InventoryGetItemCount(itemEnchantKey))
  local slotNo = ToClient_InventoryGetSlotNo(itemEnchantKey)
  local materialRegistCount = Int64toInt32(accessoryStepUpManager:getMaterialParamCount(materialIndex))
  local leftRegistCount = materialMaxCount - materialRegistCount
  local maxNumber = math.min(leftRegistCount, inventoryItemCount)
  if maxNumber <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_NO_MATERIAL"))
  elseif maxNumber == 1 then
    PaGlobal_Window_Accessory_StepUp_All_ShowRegistMaterialMessageBox(1, materialIndex, slotNo, itemEnchantKey)
  else
    Panel_NumberPad_Show(true, toInt64(0, maxNumber), materialIndex, PaGlobal_Window_Accessory_StepUp_All_ShowRegistMaterialMessageBox, false, slotNo, false, itemEnchantKey)
  end
end
function PaGlobal_Window_Accessory_StepUp_All:getStepUpAccessory(enchantLevel)
  if self._timerNo ~= nil then
    return
  end
  local progressBgOn = UI.getChildControl(self._stepUpList[enchantLevel], "Static_ProgressBG_On")
  progressBgOn:AddEffect("fUI_Jewelry_Change_Start_01A")
  self._audioId = audioPostEvent_SystemUi(5, 27)
  self._audioIdXbox = _AudioPostEvent_SystemUiForXBOX(5, 27)
  self._timerNo = luaTimer_AddEvent(PaGlobal_Window_Accessory_StepUp_All_GetStepUpAccessory, 3000, false, 0)
end
function PaGlobal_Window_Accessory_StepUp_All:eraseAllStepUpAreaEffect()
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    self._selectAreaItemList[accessoryIndex]:EraseAllEffect()
  end
  for enchantLevel = 0, __eMaxAccessoryStepUpEnchantLevel - 1 do
    local btnGet = UI.getChildControl(self._stepUpList[enchantLevel], "Button_Get")
    btnGet:EraseAllEffect()
    local progressBgOn = UI.getChildControl(self._stepUpList[enchantLevel], "Static_ProgressBG_On")
    progressBgOn:EraseAllEffect()
  end
  if self._audioId ~= nil then
    audioPostEvent_StopAudioByPlayingID(self._audioId, 0)
    self._audioId = nil
  end
  if self._audioIdXbox ~= nil then
    audioPostEvent_StopAudioByPlayingID(self._audioIdXbox, 0)
    self._audioIdXbox = nil
  end
end
function PaGlobal_Window_Accessory_StepUp_All:eraseAllAreaEffect()
  self:eraseAllStepUpAreaEffect()
  for accessoryIndex = 0, self._maxCurrentAccessoryIndexCount - 1 do
    self._exchangeAreaItemList[accessoryIndex]:EraseAllEffect()
  end
  self._ui._stc_before:EraseAllEffect()
  self._ui._stc_after:EraseAllEffect()
  self._ui._stc_exchangeEffect:EraseAllEffect()
end
function PaGlobal_Window_Accessory_StepUp_All:selectNextAccessory()
  self._ui._stc_achieveNext:SetShow(false)
  self:update(self._eUpdateType._TYPE_SELECT)
end
function PaGlobal_Window_Accessory_StepUp_All:clickExchangeAccessory(selectIndex)
  if selectIndex == self._exchangeBeforeIndex then
    self._exchangeAreaItemList[self._exchangeBeforeIndex - 1]:EraseAllEffect()
    self._ui._stc_before:EraseAllEffect()
    if self._exchangeAfterIndex ~= nil then
      self._exchangeAreaItemList[self._exchangeAfterIndex - 1]:EraseAllEffect()
      self._ui._stc_after:EraseAllEffect()
    end
    self._exchangeBeforeIndex = nil
    self._exchangeAfterIndex = nil
    self._exchangeState = self._eExchangeState._STATE_SELECT_BEFORE
  elseif selectIndex == self._exchangeAfterIndex then
    self._exchangeAreaItemList[self._exchangeAfterIndex - 1]:EraseAllEffect()
    self._ui._stc_after:EraseAllEffect()
    self._exchangeAfterIndex = nil
    self._exchangeState = self._eExchangeState._STATE_SELECT_AFTER
  elseif self._exchangeBeforeIndex == nil then
    local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
    local freeExchangeCount = accessoryStepUpManager:getAccessoryFreeExchangeCount()
    if freeExchangeCount <= 0 then
      local needCount_64 = Uint64toInt64(ToClient_GetAccessoryStepUpExchangeCost())
      local haveCount_64 = getSelfPlayer():get():getMoneyInventory():getMoney_s64()
      if needCount_64 > haveCount_64 then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoDeliveryIsLackWarehouseMoney"))
        return
      end
    end
    local itemKey = ToClient_getAccessoryStepUpItemKey(selectIndex)
    local itemCount = Int64toInt32(ToClient_InventoryGetItemCountAll(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel)))
    if itemCount <= 0 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_NO_MATERIAL"))
      return
    end
    local function clickYes()
      local beforeItemKey = ToClient_getAccessoryStepUpItemKey(selectIndex)
      local beforeItemslotNo = ToClient_InventoryGetSlotNo(ItemEnchantKey(beforeItemKey, __eMaxAccessoryStepUpEnchantLevel))
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, beforeItemslotNo)
      if itemWrapper == nil then
        return
      end
      if itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) == true then
        local messageData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
          content = PAGetString(Defines.StringSheet_GAME, "LUA_ACCESSORYSTEPUP_COPYITEM_EXCHANGE"),
          functionYes = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageData)
        return
      end
      self._exchangeAreaItemList[selectIndex - 1]:AddEffect("fUI_Jewelry_Change_Item_Select_01A_Blue", true)
      self._ui._stc_before:AddEffect("fUI_Jewelry_Change_Item_01A_Blue", true)
      self._exchangeBeforeIndex = selectIndex
      self._exchangeState = self._eExchangeState._STATE_SELECT_AFTER
      self:update(self._eUpdateType._TYPE_EXCHANGE)
    end
    if itemCount > 1 then
      local itemName = PaGlobalFunc_Util_GetItemGradeColorName(ItemEnchantKey(itemKey, __eMaxAccessoryStepUpEnchantLevel))
      local messageData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGE_SAMEITEM_TOOLTIP", "itemname", itemName, "count", itemCount),
        functionYes = clickYes,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageData)
    else
      local beforeItemKey = ToClient_getAccessoryStepUpItemKey(selectIndex)
      local beforeItemslotNo = ToClient_InventoryGetSlotNo(ItemEnchantKey(beforeItemKey, __eMaxAccessoryStepUpEnchantLevel))
      local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, beforeItemslotNo)
      if itemWrapper == nil then
        return
      end
      if itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) == true then
        local messageData = {
          title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
          content = PAGetString(Defines.StringSheet_GAME, "LUA_ACCESSORYSTEPUP_COPYITEM_EXCHANGE"),
          functionYes = MessageBox_Empty_function,
          priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
        }
        MessageBox.showMessageBox(messageData)
        return
      end
      self._exchangeAreaItemList[selectIndex - 1]:AddEffect("fUI_Jewelry_Change_Item_Select_01A_Blue", true)
      self._ui._stc_before:AddEffect("fUI_Jewelry_Change_Item_01A_Blue", true)
      self._exchangeBeforeIndex = selectIndex
      self._exchangeState = self._eExchangeState._STATE_SELECT_AFTER
    end
  elseif self._exchangeAfterIndex == nil then
    self._exchangeAreaItemList[selectIndex - 1]:AddEffect("fUI_Jewelry_Change_Item_Select_01A_Yellow", true)
    self._ui._stc_after:AddEffect("fUI_Jewelry_Change_Item_01A_Yellow", true)
    self._exchangeAfterIndex = selectIndex
    self._exchangeState = self._eExchangeState._STATE_EXCHANGE_READY
  end
  self:update(self._eUpdateType._TYPE_EXCHANGE)
end
function PaGlobal_Window_Accessory_StepUp_All:exchangeStepUpAccessory()
  local beforeItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeBeforeIndex)
  local beforeItemName = ""
  if beforeItemKey ~= nil then
    beforeItemName = PaGlobalFunc_Util_GetItemGradeColorName(ItemEnchantKey(beforeItemKey, __eMaxAccessoryStepUpEnchantLevel))
  end
  local afterItemKey = ToClient_getAccessoryStepUpItemKey(self._exchangeAfterIndex)
  local afterItemName = ""
  if afterItemKey ~= nil then
    afterItemName = PaGlobalFunc_Util_GetItemGradeColorName(ItemEnchantKey(afterItemKey, __eMaxAccessoryStepUpEnchantLevel))
  end
  local accessoryStepUpManager = getSelfPlayer():getAccessoryStepUpManager()
  local freeExchangeCount = accessoryStepUpManager:getAccessoryFreeExchangeCount()
  local contentString = ""
  if freeExchangeCount > 0 then
    contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGECONFIRM_FREE", "itemName1", beforeItemName, "itemName2", afterItemName, "current", freeExchangeCount)
  else
    local moneyName = PAGetString(Defines.StringSheet_GAME, "GAME_EXCHANGE_ITEMTOOLTIP_DESCRIPTION_SILVER")
    local moneyCount = makeDotMoney(Uint64toInt64(ToClient_GetAccessoryStepUpExchangeCost()))
    contentString = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_EXCHANGECONFIRM", "itemName1", moneyName, "count", moneyCount, "itemName2", beforeItemName, "itemName3", afterItemName)
  end
  local function clickYes()
    self._ui._stc_exchangeEffect:AddEffect("fUI_Jewelry_Change_Last_01A")
    self._timerNo = luaTimer_AddEvent(PaGlobal_Window_Accessory_StepUp_All_ExchangeStepUpAccessory, 3000, false, 0)
    self._audioId = audioPostEvent_SystemUi(5, 28)
    self._audioIdXbox = _AudioPostEvent_SystemUiForXBOX(5, 28)
  end
  local messageData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = contentString,
    functionYes = clickYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageData)
end
function PaGlobal_Window_Accessory_StepUp_All:showConsoleUI(isShow)
  if isShow == true then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_question:SetShow(false)
    self._ui._stc_lb_consoleUI:SetShow(true)
    self._ui._stc_rb_consoleUI:SetShow(true)
    self._ui._stc_keyGuide_console:SetShow(true)
    local keyGuideList = {}
    if self._isConsole == true then
      self._ui._txt_x_consoleUI:SetShow(true)
      keyGuideList = {
        self._ui._txt_x_consoleUI,
        self._ui._txt_a_consoleUI,
        self._ui._txt_b_consoleUI
      }
    else
      self._ui._txt_x_consoleUI:SetShow(false)
      keyGuideList = {
        self._ui._txt_a_consoleUI,
        self._ui._txt_b_consoleUI
      }
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuide_console, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_keyGuide_console:SetPosY(Panel_Window_Accessory_StepUp_All:GetSizeY())
    Panel_Window_Accessory_StepUp_All:SetPosY(self._originPanelPosY - self._ui._stc_keyGuide_console:GetSizeY() / 2)
  else
    self._ui._btn_close:SetShow(true)
    self._ui._btn_question:SetShow(true)
    if _ContentsOption_CH_Help == true then
      self._ui._btn_question:SetShow(false)
    end
    self._ui._stc_lb_consoleUI:SetShow(false)
    self._ui._stc_rb_consoleUI:SetShow(false)
    self._ui._stc_keyGuide_console:SetShow(false)
    Panel_Window_Accessory_StepUp_All:SetPosY(self._originPanelPosY)
  end
end
function PaGlobal_Window_Accessory_StepUp_All:validate()
  if Panel_Window_Accessory_StepUp_All == nil then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_question:isValidate()
  self._ui._stc_keyGuide_console:isValidate()
  self._ui._txt_x_consoleUI:isValidate()
  self._ui._txt_b_consoleUI:isValidate()
  self._ui._txt_a_consoleUI:isValidate()
  self._ui._stc_tabArea:isValidate()
  self._ui._stc_lb_consoleUI:isValidate()
  self._ui._stc_rb_consoleUI:isValidate()
  self._ui._radiobutton_stepUp:isValidate()
  self._ui._radiobutton_exchange:isValidate()
  self._ui._stc_selectBar:isValidate()
  self._ui._stc_line:isValidate()
  self._ui._stc_itemSelectArea:isValidate()
  self._ui._multilineText_msg:isValidate()
  self._ui._multilineText_notice:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._stc_achieveTitle:isValidate()
  self._ui._stc_achieveCountBg:isValidate()
  self._ui._stc_itemStepUpArea:isValidate()
  self._ui._stc_selectItem:isValidate()
  self._ui._stc_selectItem_stcItem:isValidate()
  self._ui._stc_selectItem_stcCheck:isValidate()
  self._ui._multilineText_selectItem_itemName:isValidate()
  self._ui._stc_progressBg:isValidate()
  self._ui._progress2_total:isValidate()
  self._ui._stc_stepArea:isValidate()
  self._ui._stc_achieveNext:isValidate()
  self._ui._stc_achieveNextCountBG:isValidate()
  self._ui._btn_selectNextAccessory:isValidate()
  self._ui._stc_itemExchangeArea:isValidate()
  self._ui._multilineText_itemExchangeMsg:isValidate()
  self._ui._stc_exchangeBG:isValidate()
  self._ui._stc_before:isValidate()
  self._ui._stc_before_stcItem:isValidate()
  self._ui._stc_before_itemName:isValidate()
  self._ui._stc_before_check:isValidate()
  self._ui._stc_after:isValidate()
  self._ui._stc_after_stcItem:isValidate()
  self._ui._stc_after_itemName:isValidate()
  self._ui._stc_after_check:isValidate()
  self._ui._stc_exchangeEffect:isValidate()
  self._ui._txt_cost:isValidate()
  self._ui._btn_exchange:isValidate()
end
