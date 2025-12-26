PaGlobal_AlchemyStoneEvolve_All = {
  _ui = {
    _stc_close = nil,
    _stc_guideBG = nil,
    _txt_multiline = nil,
    _stc_slot_itemSlot1 = nil,
    _stc_slot_itemSlot2 = nil,
    _txt_probability = nil,
    _txt_needItem = nil,
    _txt_resultItem = nil,
    _progress_stack = nil,
    _txt_stack = nil,
    _stc_stackEffect = nil,
    _stc_matArea = nil,
    _stc_itemSlotBG1 = nil,
    _stc_itemAddSlotBG1 = nil,
    _stc_slot_itemSlotBottom1 = nil,
    _stc_protectArea = nil,
    _stc_itemSlotBG2 = nil,
    _stc_itemAddSlotBG2 = nil,
    _stc_slot_itemSlotBottom2 = nil,
    _btn_apply = nil,
    _btn_applyWithProtect = nil,
    _chk_skipAni = nil,
    _stc_consoleKeyGuide = nil,
    _keyGuideA = nil,
    _keyGuideB = nil,
    _keyGuideX = nil,
    _keyGuideY = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createCash = true
  },
  _evolveSlot = {
    [0] = {},
    [1] = {},
    [2] = {},
    [3] = {}
  },
  _alchemyStoneWhereType = nil,
  _alchemyStoneSlotNo = nil,
  _alchemyStoneType = nil,
  _alchemyStoneItemKey = nil,
  _materialWhereType = nil,
  _materialSlotNo = nil,
  _materialItemKey = nil,
  _materialItemCount = nil,
  _protectWhereType = nil,
  _protectSlotNo = nil,
  _protectItemCount = nil,
  _protectItemKeyRaw = 16080,
  _resultItemWrapper = nil,
  _startEffectPlay = false,
  _btnApplyOriginSpanSizeX = 0,
  _matAreaOriginSpznSizeX = 0,
  _protectAreaOriginSpznSizeX = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_AlchemyStoneEvolve_All_Init")
function FromClient_AlchemyStoneEvolve_All_Init()
  PaGlobal_AlchemyStoneEvolve_All:initialize()
end
function PaGlobal_AlchemyStoneEvolve_All:initialize()
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  local stc_titleBar = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Static_TitleBar")
  self._ui._stc_close = UI.getChildControl(stc_titleBar, "Static_Close")
  self._ui._stc_guideBG = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Static_GuideBG")
  self._ui._txt_multiline = UI.getChildControl(self._ui._stc_guideBG, "MultilineText_Text")
  local stc_mainBG = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Static_MainBG_Stack_Normal")
  self._ui._stc_slot_itemSlot1 = UI.getChildControl(stc_mainBG, "Static_Slot_ItemSlot1")
  self._ui._stc_slot_itemSlot2 = UI.getChildControl(stc_mainBG, "Static_Slot_ItemSlot2")
  self._ui._txt_probability = UI.getChildControl(stc_mainBG, "StaticText_Probability")
  self._ui._txt_needItem = UI.getChildControl(stc_mainBG, "StaticText_NeedITem")
  self._ui._txt_resultItem = UI.getChildControl(stc_mainBG, "StaticText_ResultITem")
  self._ui._progress_stack = UI.getChildControl(stc_mainBG, "Progress2_Stack")
  self._ui._txt_stack = UI.getChildControl(stc_mainBG, "StaticText_Stack")
  self._ui._stc_stackEffect = UI.getChildControl(stc_mainBG, "Static_StackEffect")
  local stc_bottomArea = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Static_BottomArea")
  self._ui._stc_matArea = UI.getChildControl(stc_bottomArea, "Static_NeedItem")
  self._ui._stc_itemSlotBG1 = UI.getChildControl(self._ui._stc_matArea, "Static_ItemSlotBG")
  self._ui._stc_itemAddSlotBG1 = UI.getChildControl(self._ui._stc_matArea, "Static_ItemAddSlotBG")
  self._ui._stc_slot_itemSlotBottom1 = UI.getChildControl(self._ui._stc_matArea, "Static_Slot_ItemSlot")
  self._ui._stc_protectArea = UI.getChildControl(stc_bottomArea, "Static_Protection")
  self._ui._stc_itemSlotBG2 = UI.getChildControl(self._ui._stc_protectArea, "Static_ItemSlotBG")
  self._ui._stc_itemAddSlotBG2 = UI.getChildControl(self._ui._stc_protectArea, "Static_ItemAddSlotBG")
  self._ui._stc_slot_itemSlotBottom2 = UI.getChildControl(self._ui._stc_protectArea, "Static_Slot_ItemSlot")
  self._ui._txt_itemSlotCount = UI.getChildControl(self._ui._stc_protectArea, "StaticText_1")
  self._ui._btn_apply = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Button_Apply")
  self._ui._btn_applyWithProtect = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Button_ApplyWithProtect")
  self._ui._chk_skipAni = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "CheckButton_SkipAni")
  local txt_skipAni = UI.getChildControl(self._ui._chk_skipAni, "StaticText_SkipAni")
  self._ui._chk_skipAni:SetEnableArea(0, 0, self._ui._chk_skipAni:GetSizeX() + txt_skipAni:GetTextSizeX() + 10, self._ui._chk_skipAni:GetSizeY())
  self._ui._stc_consoleKeyGuide = UI.getChildControl(Panel_Window_AlchemyStoneEvolve_All, "Static_ConsoleKeyGuide")
  self._ui._keyGuideA = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._keyGuideB = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui._keyGuideX = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui._keyGuideY = UI.getChildControl(self._ui._stc_consoleKeyGuide, "StaticText_KeyGuide_Y_ConsoleUI")
  SlotItem.new(self._evolveSlot[0], "stc_evolveSlotLeft", 0, self._ui._stc_slot_itemSlot1, self._slotConfig)
  self._evolveSlot[0]:createChild()
  self._evolveSlot[0].Empty = true
  self._evolveSlot[0]:clearItem()
  SlotItem.new(self._evolveSlot[1], "stc_evolveSlotRight", 0, self._ui._stc_slot_itemSlot2, self._slotConfig)
  self._evolveSlot[1]:createChild()
  self._evolveSlot[1].Empty = true
  self._evolveSlot[1]:clearItem()
  SlotItem.new(self._evolveSlot[2], "stc_evolveSlotMaterial", 0, self._ui._stc_slot_itemSlotBottom1, self._slotConfig)
  self._evolveSlot[2]:createChild()
  self._evolveSlot[2].Empty = true
  self._evolveSlot[2]:clearItem()
  SlotItem.new(self._evolveSlot[3], "stc_evolveSlotProtect", 0, self._ui._stc_slot_itemSlotBottom2, self._slotConfig)
  self._evolveSlot[3]:createChild()
  self._evolveSlot[3].Empty = true
  self._evolveSlot[3]:clearItem()
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._btnApplyOriginSpanSizeX = self._ui._btn_apply:GetSpanSize().x
  self._matAreaOriginSpznSizeX = self._ui._stc_matArea:GetSpanSize().x
  self._protectAreaOriginSpznSizeX = self._ui._stc_protectArea:GetSpanSize().x
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_AlchemyStoneEvolve_All:registEventHandler()
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  self._ui._stc_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStoneEvolve_All_Close()")
  self._ui._btn_apply:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStoneEvolve_All_Evolve(false)")
  self._ui._btn_applyWithProtect:addInputEvent("Mouse_LUp", "PaGlobalFunc_AlchemyStoneEvolve_All_Evolve(true)")
  if self._isPadSnapping == true then
    self._ui._stc_close:SetShow(false)
    Panel_Window_AlchemyStoneEvolve_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_AlchemyStoneEvolve_All_CheckSkipAni()")
    self._ui._stc_slot_itemSlotBottom1:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_AlchemyStoneEvolve_All_ClearItemSlot(2)")
    self._ui._stc_slot_itemSlotBottom2:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_AlchemyStoneEvolve_All_ClearItemSlot(3)")
    self._ui._stc_slot_itemSlot1:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 0)")
    self._ui._stc_slot_itemSlot2:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 1)")
    self._ui._stc_slot_itemSlotBottom1:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 2)")
    self._ui._stc_slot_itemSlotBottom2:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 3)")
    self._evolveSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(0)")
    self._evolveSlot[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(0)")
    self._evolveSlot[2].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(1)")
    self._evolveSlot[3].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(2)")
    self._ui._btn_apply:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(3)")
    self._ui._btn_applyWithProtect:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(3)")
  else
    self._ui._stc_close:SetShow(true)
    self._evolveSlot[2].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_AlchemyStoneEvolve_All_ClearItemSlot(2)")
    self._evolveSlot[3].icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_AlchemyStoneEvolve_All_ClearItemSlot(3)")
    self._evolveSlot[0].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 0)")
    self._evolveSlot[1].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 1)")
    self._evolveSlot[2].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 2)")
    self._evolveSlot[3].icon:addInputEvent("Mouse_On", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(true, 3)")
  end
  self._evolveSlot[0].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(false)")
  self._evolveSlot[1].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(false)")
  self._evolveSlot[2].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(false)")
  self._evolveSlot[3].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(false)")
end
function PaGlobal_AlchemyStoneEvolve_All:prepareOpen(alchemyStoneWhereType, alchemyStoneSlotNo, alchemyStoneItemKey, alchemyStoneType, cancelEvolve)
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  if self._isPadSnapping == true then
    PaGlobal_EnchantInventoryShowToggle()
  elseif PaGlobal_Inventory_All ~= nil and PaGlobal_Inventory_All._ui.rdo_enchantMaterialInven:IsCheck() == false then
    PaGlobal_Inventory_All._ui.rdo_normalInven:SetCheck(false)
    PaGlobal_Inventory_All._ui.rdo_pearlInven:SetCheck(false)
    if _ContentsGroup_changeFamilyInvenOpenAction == true then
      PaGlobal_Inventory_All._ui.rdo_familyInven:SetCheck(false)
    end
    PaGlobal_Inventory_All._ui.rdo_enchantMaterialInven:SetCheck(true)
    HandleEventLUp_Inventory_All_SelectTab()
  end
  if cancelEvolve == false then
    if alchemyStoneWhereType == nil or alchemyStoneSlotNo == nil or alchemyStoneType == nil or alchemyStoneItemKey == nil then
      return
    end
    self:clearItemSlot()
    self._alchemyStoneWhereType = alchemyStoneWhereType
    self._alchemyStoneSlotNo = alchemyStoneSlotNo
    self._alchemyStoneType = alchemyStoneType
    self._alchemyStoneItemKey = alchemyStoneItemKey
    PaGlobalFunc_AlchemyStoneEvolve_All_SetMaterialAuto()
  elseif self._protectWhereType == __eItemWhereTypeCount then
    self:clearItemSlot(3)
  end
  self:update()
  if self._isPadSnapping == true then
    Panel_Window_AlchemyStone_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_AlchemyStoneEvolve_All)
  end
  self:open()
end
function PaGlobal_AlchemyStoneEvolve_All:open()
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  Panel_Window_AlchemyStoneEvolve_All:SetShow(true)
end
function PaGlobal_AlchemyStoneEvolve_All:prepareClose(startEvolve)
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  if startEvolve == nil then
    startEvolve = false
  end
  if startEvolve == false then
    self:clearItemSlot()
  end
  if self._isPadSnapping == true then
    Panel_Window_AlchemyStone_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    ToClient_padSnapResetControl()
    PaGlobal_EnchantInventoryShowToggle()
  else
    PaGlobal_AlchemyStone_Renewal_All:selectNormalInventoryTab()
  end
  PaGlobal_AlchemyStone_Renewal_All:update()
  self:close()
end
function PaGlobal_AlchemyStoneEvolve_All:close()
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  Panel_Window_AlchemyStoneEvolve_All:SetShow(false)
end
function PaGlobal_AlchemyStoneEvolve_All:update()
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  self._ui._txt_multiline:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMYSTONE_RENEWAL_GUIDE_DESC2"))
  self._ui._txt_needItem:SetText("")
  self._ui._txt_resultItem:SetText("")
  self._ui._txt_stack:SetText("")
  self._ui._progress_stack:SetProgressRate(0)
  self._ui._txt_probability:SetText("")
  local guaranteeEnchantMaxCount = 0
  local currentGuaranteeEnchantCount = 0
  if self._alchemyStoneWhereType ~= nil then
    local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
    if itemSSW ~= nil then
      self._evolveSlot[0]:setItemByStaticStatus(itemSSW, 1, nil, nil, nil)
      self._evolveSlot[0].Empty = false
      self._resultItemWrapper = getAlchemyEvolveItemStaticStatusWrapper(itemSSW:get()._key:getItemKey(), 0)
      self._evolveSlot[1]:setItemByStaticStatus(self._resultItemWrapper, 1, nil, nil, nil)
      self._evolveSlot[1].Empty = false
      guaranteeEnchantMaxCount = itemSSW:getSSEnchantCount()
      currentGuaranteeEnchantCount = itemSSW:getCurrentEnchantCount()
      local progressPercent = currentGuaranteeEnchantCount / guaranteeEnchantMaxCount * 100
      if guaranteeEnchantMaxCount > 0 then
        self._ui._progress_stack:SetProgressRate(progressPercent)
        self._ui._txt_stack:SetText(currentGuaranteeEnchantCount .. "/" .. guaranteeEnchantMaxCount)
      end
    end
    local evolveRate = ToClient_requestAlchemyEvolveRate(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
    local evolveRateString = string.format("%.2f", evolveRate / CppDefine.e100Percent * 100)
    self._ui._txt_probability:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_RATE", "rate", evolveRateString))
  else
    self._evolveSlot[0]:clearItem()
    self._evolveSlot[0].Empty = true
    self._evolveSlot[1]:clearItem()
    self._evolveSlot[1].Empty = true
  end
  if self._materialItemCount ~= nil then
    local itemSSW = getItemEnchantStaticStatus(self._materialItemKey)
    if itemSSW ~= nil then
      self._evolveSlot[2]:setItemByStaticStatus(itemSSW, self._materialItemCount, nil, nil, nil)
      self._evolveSlot[2].Empty = false
    end
  else
    self._evolveSlot[2]:clearItem()
    self._evolveSlot[2].Empty = true
  end
  self._ui._txt_itemSlotCount:SetText("")
  local protectItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._protectItemKeyRaw))
  if protectItemSSW ~= nil then
    if self._protectItemCount ~= nil then
      self._ui._txt_itemSlotCount:SetText(tostring(self._protectItemCount))
      self._evolveSlot[3]:setItemByStaticStatus(protectItemSSW, ToClient_GetItemPreventCronCount(self._alchemyStoneWhereType, self._alchemyStoneSlotNo), nil, nil, nil)
      self._evolveSlot[3].Empty = false
      self._evolveSlot[3].icon:SetMonoTone(false)
      self._evolveSlot[3].icon:AddEffect("fUI_SpiritEnchant_New_Cron_Slot_01A", true, 0, 0)
    else
      self._evolveSlot[3].icon:EraseAllEffect()
      if self._alchemyStoneWhereType ~= nil then
        self._evolveSlot[3]:setItemByStaticStatus(protectItemSSW, ToClient_GetItemPreventCronCount(self._alchemyStoneWhereType, self._alchemyStoneSlotNo), nil, nil, nil)
        self._evolveSlot[3].Empty = false
        self._evolveSlot[3].icon:SetMonoTone(true)
      else
        self._evolveSlot[3]:clearItem()
        self._evolveSlot[3].Empty = true
      end
    end
  end
  local needCronCount = ToClient_GetItemPreventCronCount(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
  if self._protectItemCount ~= nil then
    if Int64toInt32(self._protectItemCount) >= Int64toInt32(needCronCount) then
      self._ui._btn_apply:SetMonoTone(true)
      self._ui._btn_apply:SetIgnore(true)
      self._ui._btn_applyWithProtect:SetMonoTone(false)
      self._ui._btn_applyWithProtect:SetIgnore(false)
      self._ui._btn_applyWithProtect:AddEffect("fUI_SpiritEnchant_New_DropBlock_01B", true, 0, 0)
    else
      self._ui._btn_apply:SetMonoTone(false)
      self._ui._btn_apply:SetIgnore(false)
      self._ui._btn_applyWithProtect:SetMonoTone(true)
      self._ui._btn_applyWithProtect:SetIgnore(true)
      self._ui._btn_applyWithProtect:EraseAllEffect()
    end
  else
    self._ui._btn_apply:SetMonoTone(false)
    self._ui._btn_apply:SetIgnore(false)
    self._ui._btn_applyWithProtect:SetMonoTone(true)
    self._ui._btn_applyWithProtect:SetIgnore(true)
    self._ui._btn_applyWithProtect:EraseAllEffect()
    if PaGlobalFunc_AlchemyStoneEvolve_All_FindProtectItem() == true then
      self._ui._btn_applyWithProtect:SetMonoTone(false)
      self._ui._btn_applyWithProtect:SetIgnore(false)
    end
  end
  if 0 >= Int64toInt32(needCronCount) or currentGuaranteeEnchantCount == guaranteeEnchantMaxCount then
    self._ui._btn_apply:SetSize(558, self._ui._btn_apply:GetSizeY())
    self._ui._btn_apply:SetSpanSize(0, self._ui._btn_apply:GetSpanSize().y)
    self._ui._btn_applyWithProtect:SetShow(false)
    self._ui._stc_matArea:SetSpanSize(210, self._ui._stc_matArea:GetSpanSize().y)
    self._ui._stc_protectArea:SetShow(false)
    if currentGuaranteeEnchantCount == guaranteeEnchantMaxCount then
      self._ui._txt_probability:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_RATE", "rate", 100))
    end
  else
    self._ui._btn_apply:SetSize(272, self._ui._btn_apply:GetSizeY())
    self._ui._btn_applyWithProtect:SetSize(272, self._ui._btn_applyWithProtect:GetSizeY())
    self._ui._btn_apply:SetSpanSize(self._btnApplyOriginSpanSizeX, self._ui._btn_apply:GetSpanSize().y)
    self._ui._btn_applyWithProtect:SetSpanSize(-self._btnApplyOriginSpanSizeX, self._ui._btn_applyWithProtect:GetSpanSize().y)
    self._ui._btn_applyWithProtect:SetShow(true)
    self._ui._stc_matArea:SetSpanSize(self._matAreaOriginSpznSizeX, self._ui._stc_matArea:GetSpanSize().y)
    self._ui._stc_protectArea:SetSpanSize(self._protectAreaOriginSpznSizeX, self._ui._stc_protectArea:GetSpanSize().y)
    self._ui._stc_protectArea:SetShow(true)
  end
  if self._materialItemCount == nil then
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStoneEvolve_All_SetInvenFilterMat, PaGlobalFunc_AlchemyStoneEvolve_All_InvenMatRClick, nil, nil)
  elseif self._protectItemCount == nil then
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStoneEvolve_All_SetInvenFilterCron, PaGlobalFunc_AlchemyStoneEvolve_All_InvenCronRClick, nil, nil)
  else
    Inventory_SetFunctor(PaGlobalFunc_AlchemyStoneEvolve_All_SetInvenFilterNone, PaGlobalFunc_AlchemyStoneEvolve_All_InvenNoneRClick, nil, nil)
  end
  self._ui._btn_apply:ComputePos()
  self._ui._btn_applyWithProtect:ComputePos()
  self._ui._stc_matArea:ComputePos()
  self._ui._stc_protectArea:ComputePos()
end
function PaGlobal_AlchemyStoneEvolve_All:clearItemSlot(clearIndex)
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  if clearIndex == nil then
    clearIndex = 1
  end
  if clearIndex <= 1 then
    self._alchemyStoneWhereType = nil
    self._alchemyStoneSlotNo = nil
    self._alchemyStoneType = nil
    self._alchemyStoneItemKey = nil
    self._resultItemWrapper = nil
  end
  if clearIndex <= 2 then
    self._materialWhereType = nil
    self._materialSlotNo = nil
    self._materialItemKey = nil
    self._materialItemCount = nil
  end
  if clearIndex <= 3 then
    self._protectWhereType = nil
    self._protectSlotNo = nil
    self._protectItemCount = nil
  end
end
function PaGlobal_AlchemyStoneEvolve_All:validate()
  if Panel_Window_AlchemyStoneEvolve_All == nil then
    return
  end
  self._ui._stc_close:isValidate()
  self._ui._stc_guideBG:isValidate()
  self._ui._txt_multiline:isValidate()
  self._ui._stc_slot_itemSlot1:isValidate()
  self._ui._stc_slot_itemSlot2:isValidate()
  self._ui._txt_probability:isValidate()
  self._ui._txt_needItem:isValidate()
  self._ui._txt_resultItem:isValidate()
  self._ui._progress_stack:isValidate()
  self._ui._txt_stack:isValidate()
  self._ui._stc_stackEffect:isValidate()
  self._ui._stc_itemSlotBG1:isValidate()
  self._ui._stc_itemAddSlotBG1:isValidate()
  self._ui._stc_slot_itemSlotBottom1:isValidate()
  self._ui._stc_itemSlotBG2:isValidate()
  self._ui._stc_itemAddSlotBG2:isValidate()
  self._ui._stc_slot_itemSlotBottom2:isValidate()
  self._ui._btn_apply:isValidate()
  self._ui._btn_applyWithProtect:isValidate()
  self._ui._stc_consoleKeyGuide:isValidate()
  self._ui._keyGuideA:isValidate()
  self._ui._keyGuideB:isValidate()
  self._ui._keyGuideX:isValidate()
  self._ui._keyGuideY:isValidate()
end
function PaGlobalFunc_AlchemyStoneEvolve_All_Open(alchemyStoneWhereType, alchemyStoneSlotNo, alchemyStoneItemKey, alchemyStoneType, cancelEvolve)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if cancelEvolve == nil then
    cancelEvolve = false
  end
  self:prepareOpen(alchemyStoneWhereType, alchemyStoneSlotNo, alchemyStoneItemKey, alchemyStoneType, cancelEvolve)
end
function PaGlobalFunc_AlchemyStoneEvolve_All_Close()
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_AlchemyStoneEvolve_All_SetInvenFilterMat(slotNo, itemWrapper, inventoryType)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return true
  end
  if inventoryType ~= __eItemWhereTypeEnchantInventory then
    return true
  end
  if self._alchemyStoneWhereType == nil then
    return
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if staticStatus == nil then
    return true
  end
  local key = itemWrapper:get():getKey()
  if staticStatus:isAlchemyUpgradeMaterial(self._alchemyStoneItemKey) == true then
    return false
  end
  return true
end
function PaGlobalFunc_AlchemyStoneEvolve_All_InvenMatRClick(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return
  end
  if self._startEffectPlay == true then
    return
  end
  if self._materialItemCount ~= nil then
    return
  end
  self._materialWhereType = inventoryType
  self._materialSlotNo = slotNo
  self._materialItemKey = itemWrapper:get():getKey()
  local setMatFunc = function(itemCount)
    local self = PaGlobal_AlchemyStoneEvolve_All
    if self == nil then
      return
    end
    self._materialItemCount = itemCount
    self:update()
  end
  self:update()
  if count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, count, nil, setMatFunc, false, nil, nil)
  else
    setMatFunc(toInt64(0, 1))
  end
end
function PaGlobalFunc_AlchemyStoneEvolve_All_SetMaterialAuto()
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if self._alchemyStoneItemKey == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if itemSSW == nil then
    return
  end
  local needMaterialItemKey = ToClient_GetAlchemyEvolveNeedItemKey(itemSSW:get()._key:getItemKey())
  local inventory = getSelfPlayer():get():getInventoryByType(__eItemWhereTypeEnchantInventory)
  local matertialSlotNo = inventory:getSlot(needMaterialItemKey)
  local materialItemCount = inventory:getItemCount_s64(needMaterialItemKey)
  local materialItemNeedCount = ToClient_GetAlchemyEvolveNeedItemCount(self._alchemyStoneItemKey)
  if materialItemCount > materialItemNeedCount then
    materialItemCount = materialItemNeedCount
  end
  if matertialSlotNo ~= nil and matertialSlotNo ~= __eTInventorySlotNoUndefined then
    local materialWrapper = getInventoryItemByType(__eItemWhereTypeEnchantInventory, matertialSlotNo)
    if materialWrapper ~= nil then
      self._materialWhereType = __eItemWhereTypeEnchantInventory
      self._materialSlotNo = matertialSlotNo
      self._materialItemKey = materialWrapper:get():getKey()
      self._materialItemCount = materialItemCount
    end
  end
  self:update()
end
function PaGlobalFunc_AlchemyStoneEvolve_All_FindProtectItem(isEffectOn)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  local foundSlotIcon, scrollInfo
  if self._isPadSnapping == false then
    if PaGlobal_Inventory_All_FindItemSlot ~= nil then
      foundSlotIcon, scrollInfo = PaGlobal_Inventory_All_FindItemSlot(self._protectItemKeyRaw)
      if foundSlotIcon ~= nil then
        if isEffectOn == true then
          foundSlotIcon:AddEffect("fUI_NewItem02", true, 0, 0)
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_CRON_GO_SYSTEM"))
        end
        return true
      end
    end
  else
    local inventory = getSelfPlayer():get():getInventoryByType(__eItemWhereTypeEnchantInventory)
    local protectSlotNo = inventory:getSlot(ItemEnchantKey(self._protectItemKeyRaw))
    if protectSlotNo ~= nil then
      if isEffectOn == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALCHEMY_ENCHANT_CRON_GO_SYSTEM"))
      end
      return true
    end
  end
  return false
end
function PaGlobalFunc_AlchemyStoneEvolve_All_SetInvenFilterCron(slotNo, itemWrapper, inventoryType)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return true
  end
  if inventoryType ~= __eItemWhereTypeEnchantInventory then
    return true
  end
  if self._alchemyStoneWhereType == nil or self._materialWhereType == nil then
    return
  end
  local preventCronCount = ToClient_GetItemPreventCronCount(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
  if Int64toInt32(preventCronCount) <= 0 then
    return true
  end
  local alchemyStoneSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if alchemyStoneSSW ~= nil then
    local guaranteeEnchantMaxCount = alchemyStoneSSW:getSSEnchantCount()
    local currentGuaranteeEnchantCount = alchemyStoneSSW:getCurrentEnchantCount()
    if guaranteeEnchantMaxCount ~= 0 and guaranteeEnchantMaxCount == currentGuaranteeEnchantCount then
      return true
    end
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if staticStatus == nil then
    return true
  end
  local itemKeyRaw = staticStatus:getItemKey()
  if itemKeyRaw == self._protectItemKeyRaw then
    return false
  end
  return true
end
function PaGlobalFunc_AlchemyStoneEvolve_All_InvenCronRClick(slotNo, itemWrapper, count, inventoryType)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if itemWrapper == nil then
    return
  end
  if self._startEffectPlay == true then
    return
  end
  if self._alchemyStoneWhereType == nil or self._materialWhereType == nil then
    return
  end
  local alchemyStoneSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if alchemyStoneSSW ~= nil then
    local guaranteeEnchantMaxCount = alchemyStoneSSW:getSSEnchantCount()
    local currentGuaranteeEnchantCount = alchemyStoneSSW:getCurrentEnchantCount()
    if guaranteeEnchantMaxCount ~= 0 and guaranteeEnchantMaxCount == currentGuaranteeEnchantCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoDontUseCronAndAnvil"))
      return
    end
  end
  local staticStatus = itemWrapper:getStaticStatus()
  if staticStatus == nil then
    return
  end
  local itemKeyRaw = staticStatus:getItemKey()
  if itemKeyRaw ~= self._protectItemKeyRaw then
    return
  end
  self._protectWhereType = inventoryType
  self._protectSlotNo = slotNo
  local setMatFunc = function(itemCount)
    local self = PaGlobal_AlchemyStoneEvolve_All
    if self == nil then
      return
    end
    self._protectItemCount = itemCount
    self:update()
  end
  self:update()
  local preventCronCount = ToClient_GetItemPreventCronCount(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
  if count < preventCronCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEnoughCron"))
    return
  end
  if preventCronCount > toInt64(0, 1) then
    Panel_NumberPad_Show(true, preventCronCount, nil, setMatFunc, false, nil, nil)
  else
    setMatFunc(toInt64(0, 1))
  end
end
function PaGlobalFunc_AlchemyStoneEvolve_All_SetInvenFilterNone(slotNo, itemWrapper, inventoryType)
  return true
end
function PaGlobalFunc_AlchemyStoneEvolve_All_InvenNoneRClick(slotNo, itemWrapper, count, inventoryType)
  return false
end
function PaGlobalFunc_AlchemyStoneEvolve_All_Evolve(useProtect)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if self._alchemyStoneWhereType == nil or self._alchemyStoneSlotNo == nil or self._materialWhereType == nil or self._materialSlotNo == nil or self._materialItemCount == nil then
    return
  end
  if useProtect == true then
    if self._protectWhereType == nil or self._protectSlotNo == nil or self._protectItemCount == nil then
      PaGlobalFunc_AlchemyStoneEvolve_All_FindProtectItem(true)
      return
    end
  else
    self._protectWhereType = __eItemWhereTypeCount
    self._protectSlotNo = __eTInventorySlotNoUndefined
    self._protectItemCount = 0
  end
  local itemSSW = getItemEnchantStaticStatus(self._alchemyStoneItemKey)
  if itemSSW ~= nil and ToClient_GetAlchemyEvolveNeedItemCount(itemSSW:get()._key) > self._materialItemCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEnoughMaterialAccessoryStepUp"))
    return
  end
  if useProtect == true then
    local preventCronCount = ToClient_GetItemPreventCronCount(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
    if preventCronCount > self._protectItemCount then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEnoughCron"))
      return
    end
  end
  if self._ui._chk_skipAni:IsCheck() == true then
    PaGlobalFunc_AlchemyStone_Renewal_All_Evolve()
  else
    PaGlobalFunc_AlchemyStone_Renewal_All_StartEvolve()
  end
  self:prepareClose(true)
end
function PaGlobalFunc_AlchemyStoneEvolve_All_ClearItemSlot(clearIndex)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  self:clearItemSlot(clearIndex)
  self:update()
end
function PaGlobalFunc_AlchemyStoneEvolve_All_ItemToolTip(isShow, type)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if isShow == false then
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  if type == 0 then
    if self._alchemyStoneWhereType == nil then
      return
    end
    local itemWrapper = getInventoryItemByType(self._alchemyStoneWhereType, self._alchemyStoneSlotNo)
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      local control = self._evolveSlot[0].icon
      Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
    end
  elseif type == 1 then
    if self._resultItemWrapper == nil then
      return
    end
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, self._resultItemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      local control = self._evolveSlot[1].icon
      Panel_Tooltip_Item_Show(self._resultItemWrapper, control, true, false, nil, nil, nil)
    end
  elseif type == 2 then
    if self._materialWhereType == nil then
      return
    end
    local itemWrapper = getInventoryItemByType(self._materialWhereType, self._materialSlotNo)
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      local control = self._evolveSlot[1].icon
      Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil)
    end
  elseif type == 3 then
    local protectItemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._protectItemKeyRaw))
    if protectItemSSW == nil then
      return
    end
    if ToClient_isConsole() == true then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, protectItemSSW, Defines.TooltipTargetType.ItemWithoutCompare)
    else
      local control = self._evolveSlot[1].icon
      Panel_Tooltip_Item_Show(protectItemSSW, control, true, false, nil, nil, nil)
    end
  end
end
function PaGlobalFunc_AlchemyStoneEvolve_All_SetKeyGuide(type)
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  local keyGuides = {}
  self._ui._keyGuideA:SetShow(false)
  self._ui._keyGuideX:SetShow(false)
  self._ui._keyGuideB:SetShow(true)
  self._ui._keyGuideY:SetShow(true)
  if type == 0 then
    if self._alchemyStoneWhereType == nil then
      keyGuides = {
        self._ui._keyGuideB,
        self._ui._keyGuideY
      }
    else
      keyGuides = {
        self._ui._keyGuideB,
        self._ui._keyGuideX,
        self._ui._keyGuideY
      }
      self._ui._keyGuideX:SetShow(true)
    end
  elseif type == 1 then
    if self._materialWhereType == nil then
      keyGuides = {
        self._ui._keyGuideB,
        self._ui._keyGuideY
      }
    else
      keyGuides = {
        self._ui._keyGuideA,
        self._ui._keyGuideB,
        self._ui._keyGuideX,
        self._ui._keyGuideY
      }
      self._ui._keyGuideX:SetShow(true)
      self._ui._keyGuideA:SetShow(true)
      self._ui._keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    end
  elseif type == 2 then
    if self._protectItemCount == nil then
      keyGuides = {
        self._ui._keyGuideB,
        self._ui._keyGuideX,
        self._ui._keyGuideY
      }
      self._ui._keyGuideX:SetShow(true)
    else
      keyGuides = {
        self._ui._keyGuideA,
        self._ui._keyGuideB,
        self._ui._keyGuideX,
        self._ui._keyGuideY
      }
      self._ui._keyGuideX:SetShow(true)
      self._ui._keyGuideA:SetShow(true)
      self._ui._keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    end
  elseif type == 3 then
    keyGuides = {
      self._ui._keyGuideA,
      self._ui._keyGuideB,
      self._ui._keyGuideY
    }
    self._ui._keyGuideA:SetShow(true)
    self._ui._keyGuideA:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"))
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_consoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobalFunc_AlchemyStoneEvolve_All_CheckSkipAni()
  local self = PaGlobal_AlchemyStoneEvolve_All
  if self == nil then
    return
  end
  if self._ui._chk_skipAni:IsCheck() == true then
    self._ui._chk_skipAni:SetCheck(false)
  else
    self._ui._chk_skipAni:SetCheck(true)
  end
end
