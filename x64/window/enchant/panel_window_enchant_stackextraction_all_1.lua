function PaGlobal_StackExtraction_All:initialize()
  if Panel_Window_Enchant_StackExtraction_All == nil or PaGlobal_StackExtraction_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_StackExtraction_All:controlInit()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_Enchant_StackExtraction_All, "Static_TitleArea")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_stackEnchant = UI.getChildControl(Panel_Window_Enchant_StackExtraction_All, "Static_StackEnchantPart")
  self._ui.stc_imageArea = UI.getChildControl(self._ui.stc_stackEnchant, "Static_ImageArea")
  self._ui.stc_extractionImage = UI.getChildControl(self._ui.stc_imageArea, "Static_StackExtsractionImage")
  self._ui.stc_bookSlot = UI.getChildControl(self._ui.stc_extractionImage, "Static_StackBookSlot")
  self._ui.stc_valksAdviceSlot = UI.getChildControl(self._ui.stc_extractionImage, "Static_StackScrollSlot")
  self._ui.stc_infoArea = UI.getChildControl(self._ui.stc_stackEnchant, "Static_CurrentEnchantInfoArea")
  self._ui.txt_valksValue = UI.getChildControl(self._ui.stc_infoArea, "StaticText_ValksValue")
  self._ui.txt_stackValue = UI.getChildControl(self._ui.stc_infoArea, "StaticText_NormalValue")
  self._ui.txt_currentStack = UI.getChildControl(self._ui.stc_infoArea, "StaticText_CurrentStack")
  self._ui.stc_bottomArea = UI.getChildControl(self._ui.stc_stackEnchant, "Static_BottomDescArea")
  self._ui.btn_skipAnimation = UI.getChildControl(self._ui.stc_bottomArea, "CheckButton_SkipAni")
  self._ui.btn_execution = UI.getChildControl(self._ui.stc_bottomArea, "Button_Execution")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_ConsoleKeyGuide")
  self._ui.txt_guideIconB = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_CancelButton_C")
  local bookSlot = {}
  SlotItem.new(bookSlot, "EnchantBookSlot", 0, self._ui.stc_bookSlot, self._slotConfig)
  bookSlot:createChild()
  bookSlot.empty = true
  bookSlot:clearItem()
  bookSlot.border:SetSize(44, 44)
  bookSlot.border:SetPosX(0)
  bookSlot.border:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_bookSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_StackExtraction_BookSlot(nil)")
    bookSlot.icon:addInputEvent("Mouse_LUp", "HandleEventOn_StackExtraction_ReleaseBook()")
    bookSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_StackExtraction_BookSlot(false)")
  else
    bookSlot.icon:addInputEvent("Mouse_On", "HandleEventOn_StackExtraction_BookSlot(true)")
    bookSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_StackExtraction_BookSlot(false)")
    bookSlot.icon:addInputEvent("Mouse_RUp", "HandleEventOn_StackExtraction_ReleaseBook()")
  end
  self._bookSlot = bookSlot
  local valksAdviceSlot = {}
  SlotItem.new(valksAdviceSlot, "EnchantValksAdviceSlot", 0, self._ui.stc_valksAdviceSlot, self._slotConfig)
  valksAdviceSlot:createChild()
  valksAdviceSlot.empty = true
  valksAdviceSlot:clearItem()
  valksAdviceSlot.border:SetSize(44, 44)
  valksAdviceSlot.border:SetPosX(0)
  valksAdviceSlot.border:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_valksAdviceSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_StackExtraction_ValksAdviceSlot(nil)")
    valksAdviceSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_StackExtraction_ValksAdviceSlot(false)")
  else
    valksAdviceSlot.icon:addInputEvent("Mouse_On", "HandleEventOn_StackExtraction_ValksAdviceSlot(true)")
    valksAdviceSlot.icon:addInputEvent("Mouse_Out", "HandleEventOn_StackExtraction_ValksAdviceSlot(false)")
  end
  self._valksAdviceSlot = valksAdviceSlot
end
function PaGlobal_StackExtraction_All:setConsoleUI()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  self._ui.stc_keyGuide:SetShow(self._isConsole == true)
  self._ui.btn_close:SetShow(self._isConsole == false)
  local guideIconGroup = {
    self._ui.txt_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.stc_keyGuide:ComputePos()
end
function PaGlobal_StackExtraction_All:prepareOpen()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  PaGlobal_StackExtraction_All:resetAnimation()
  PaGlobal_StackExtraction_All:open()
  ToClient_UpdateStackExtraction()
  if _ContentsGroup_RenewUI_Inventory == false then
    PaGlobalFunc_Inventory_All_OpenWithSpiritEnchant(nil, nil, nil, nil, nil)
  else
    PaGlobalFunc_InventoryInfo_Open(1, false, 0, false)
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_StackExtraction_All_FilterForBookExtraction, PaGlobalFunc_StackExtraction_All_RClickForEnchantTargetItem, PaGlobalFunc_StackExtraction_All_Close, nil)
end
function PaGlobal_StackExtraction_All:open()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  Panel_Window_Enchant_StackExtraction_All:SetShow(true)
end
function PaGlobal_StackExtraction_All:prepareClose()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  if self._isConsole == true then
    if PaGlobalFunc_InventoryInfo_Close ~= nil then
      PaGlobalFunc_InventoryInfo_Close()
    end
  elseif PaGlobalFunc_Inventory_All_SetShow ~= nil then
    PaGlobalFunc_Inventory_All_SetShow(false)
  end
  PaGlobal_StackExtraction_All:resetAnimation()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_StackExtraction_All:close()
end
function PaGlobal_StackExtraction_All:close()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  Panel_Window_Enchant_StackExtraction_All:SetShow(false)
end
function PaGlobal_StackExtraction_All:registEventHandler()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_StackExtraction_All_Close()")
  self._ui.btn_execution:addInputEvent("Mouse_LUp", "PaGlobalFunc_StackExtraction_All_HandleExecutionButton()")
  Panel_Window_Enchant_StackExtraction_All:RegisterUpdateFunc("PaGlobalFunc_StackExtraction_All_UpdateFuncCheckAni")
  registerEvent("FromClient_UpdateStackExtraction", "FromClient_UpdateStackExtraction")
end
function PaGlobal_StackExtraction_All:validate()
  if nil == Panel_Window_Enchant_StackExtraction_All then
    return
  end
end
function PaGlobal_StackExtraction_All:update()
  if nil == Panel_Window_Enchant_StackExtraction_All or Panel_Window_Enchant_StackExtraction_All:GetShow() == false then
    return
  end
  self:updateSlots()
  self:updateInfoArea()
  self:updateButton()
  PaGlobal_EnchantMain_All:updateEnchantRate()
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(PaGlobalFunc_StackExtraction_All_FilterForBookExtraction, PaGlobalFunc_StackExtraction_All_RClickForEnchantTargetItem, PaGlobalFunc_StackExtraction_All_Close, nil)
end
function PaGlobal_StackExtraction_All:updateButton()
  local buttonName = ""
  if self:isAnimating() == true then
    buttonName = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL")
  else
    buttonName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTEXTRACTION_TITLE")
  end
  self._ui.btn_execution:SetText(buttonName)
  local isBookAvailable = ToClient_IsCurrentExtractionBookSetted()
  self._ui.btn_execution:SetIgnore(isBookAvailable == false)
  self._ui.btn_execution:SetMonoTone(isBookAvailable == false)
end
function PaGlobal_StackExtraction_All:updateSlots()
  local isBookAvailable = ToClient_IsCurrentExtractionBookSetted()
  self._bookSlot.icon:SetIgnore(false)
  self._bookSlot:clearItem(true)
  local bookItemSS = ToClient_GetCurrentExtractionBookForLua()
  if bookItemSS ~= nil then
    self._bookSlot:setItemByStaticStatus(bookItemSS, 1)
    self._bookSlot.icon:SetMonoTone(isBookAvailable == false)
  else
    self._bookSlot.icon:SetIgnore(true)
  end
  self._valksAdviceSlot.icon:SetIgnore(false)
  self._valksAdviceSlot:clearItem(true)
  local valksAdviceItemSS = ToClient_GetCurrentExtractableValksAdviceForLua()
  if valksAdviceItemSS ~= nil then
    self._valksAdviceSlot:setItemByStaticStatus(valksAdviceItemSS, 1)
    self._valksAdviceSlot.icon:SetMonoTone(isBookAvailable == false)
  else
    self._valksAdviceSlot.icon:SetIgnore(true)
  end
end
function PaGlobal_StackExtraction_All:updateInfoArea()
  local valksValue = ToClient_GetValksStack()
  local stackValue = ToClient_GetEnchantStack()
  local currentStack = valksValue + stackValue + ToClient_GetBonusStack()
  self._ui.txt_valksValue:SetText("+" .. valksValue)
  self._ui.txt_stackValue:SetText("+" .. stackValue)
  self._ui.txt_currentStack:SetText("+" .. currentStack)
end
function PaGlobal_StackExtraction_All:resetAnimation()
  self._ui.stc_extractionImage:EraseAllEffect()
  self._isEnchantAnim = false
  self._animTime = 0
end
function PaGlobal_StackExtraction_All:requestExtraction()
  self._ui.btn_execution:SetMonoTone(false)
  self._ui.btn_execution:SetIgnore(false)
  ToClient_RequestExtraction()
end
function PaGlobal_StackExtraction_All:startExtraction()
  self:resetAnimation()
  self._isEnchantAnim = true
  self._ui.stc_extractionImage:AddEffect("fUI_BlackBook_01A", false)
  self._ui.btn_execution:SetMonoTone(true)
  self._ui.btn_execution:SetIgnore(true)
  self:updateButton()
  PaGlobal_EnchantMain_All_StartAudio(PaGlobal_EnchantMain_All._AUDIO.EXTRACTION_START)
end
function PaGlobal_StackExtraction_All:isAnimating()
  return self._isEnchantAnim == true
end
function PaGlobal_StackExtraction_All:handleExecutionButton()
  if self:isAnimating() == true then
    self:resetAnimation()
    self:updateButton()
    PaGlobal_EnchantMain_All_StartAudio(PaGlobal_EnchantMain_All._AUDIO.CANCEL)
    return
  end
  local stackValue = ToClient_GetEnchantStack()
  local bookItemSS = ToClient_GetCurrentExtractionBookForLua()
  local itemName = ""
  if bookItemSS ~= nil then
    itemName = getItemName(bookItemSS:get())
  end
  local messageBoxMemo = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_MSGDESC", "itemName", itemName, "failCount", stackValue, "failCount2", stackValue)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_MSGTITLE"),
    content = messageBoxMemo,
    functionYes = PaGlobalFunc_StackExtraction_All_Execution,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
