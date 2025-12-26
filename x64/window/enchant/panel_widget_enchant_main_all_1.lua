function PaGlobal_EnchantMain_All:initialize()
  if Panel_Widget_Enchant_Main_All == nil or PaGlobal_EnchantMain_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:registEventHandler()
  self:validate()
  self:resize()
  self._initialize = true
end
function PaGlobal_EnchantMain_All:controlInit()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  self._ui.stc_background = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Static_MainBG")
  self._ui.stc_effectArea = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Static_DirectingEffectsArea")
  self._ui.stc_corePattern = UI.getChildControl(self._ui.stc_effectArea, "Static_CorePattern")
  self._ui.txt_successRate = UI.getChildControl(self._ui.stc_corePattern, "StaticText_1")
  self._ui.stc_enchantTargetSlot = UI.getChildControl(self._ui.stc_corePattern, "Static_Slot")
  self._ui.stc_circularProgress = UI.getChildControl(self._ui.stc_corePattern, "CircularProgress_Rate")
  self._ui.stc_materialSlotArea = UI.getChildControl(self._ui.stc_effectArea, "Static_MaterialSlotArea")
  self._ui.btn_otherMaterial = UI.getChildControl(self._ui.stc_materialSlotArea, "Button_OtherMaterial")
  self._ui.stc_enchantMaterialSlot = UI.getChildControl(self._ui.stc_materialSlotArea, "Static_Slot")
  self._ui.stc_protector = UI.getChildControl(self._ui.stc_effectArea, "Static_DestructionPrevention")
  self._ui.txt_cronNeedCount = UI.getChildControl(self._ui.stc_protector, "StaticText_CronNeedCount")
  self._ui.stc_protectorSlot = UI.getChildControl(self._ui.stc_protector, "Static_Slot")
  self._ui.btn_selectProtector = UI.getChildControl(self._ui.stc_protector, "Button_SelectProtector")
  self._ui.txt_currentProtectorCount = UI.getChildControl(self._ui.stc_protector, "StaticText_CronNeedCount")
  self._ui.stc_protectorEffect = UI.getChildControl(self._ui.stc_protector, "Static_Protection_Effect")
  self._ui.stc_agris = UI.getChildControl(self._ui.stc_effectArea, "Static_Hammer")
  self._ui.stc_agrisProgress = UI.getChildControl(self._ui.stc_agris, "Progress2_Hammer")
  self._ui.txt_agrisText = UI.getChildControl(self._ui.stc_agris, "StaticText_1")
  self._ui.stc_agrisEffect = UI.getChildControl(self._ui.stc_agris, "Static_Effect")
  self._ui.stc_agrisDesc = UI.getChildControl(self._ui.stc_effectArea, "Static_AgrisDesc")
  self._ui.txt_agrisDesc = UI.getChildControl(self._ui.stc_agrisDesc, "MultilineText_Congratulations")
  self._ui.stc_functionButtons = UI.getChildControl(self._ui.stc_effectArea, "Static_FunctionButtons")
  self._ui.btn_stack = UI.getChildControl(self._ui.stc_functionButtons, "Button_Stack")
  self._ui.txt_naderrCooltime = UI.getChildControl(self._ui.stc_functionButtons, "StaticText_Cooltime")
  self._ui.btn_extraction = UI.getChildControl(self._ui.stc_functionButtons, "Button_Extraction")
  self._ui.stc_rateValueBG = UI.getChildControl(self._ui.stc_effectArea, "Static_RateValueBG")
  self._ui.txt_rateText = UI.getChildControl(self._ui.stc_rateValueBG, "MultilineText_Rate")
  self._ui.txt_currentStack = UI.getChildControl(self._ui.stc_rateValueBG, "StaticText_Enchant_Probability")
  self._ui.txt_currentValksCry = UI.getChildControl(self._ui.stc_rateValueBG, "StaticText_Strengthen_Stack")
  self._ui.txt_totalStack = UI.getChildControl(self._ui.stc_rateValueBG, "MultilineText_Total_Probability")
  self._ui.btn_othersChoice = UI.getChildControl(self._ui.stc_rateValueBG, "Button_Recommand")
  self._ui.stc_tuvalaExchange = UI.getChildControl(self._ui.stc_effectArea, "Static_TuvalaExchange")
  self._ui.stc_tuvalaSlot = UI.getChildControl(self._ui.stc_tuvalaExchange, "Static_ItemSlot")
  self._ui.txt_tuvalaName = UI.getChildControl(self._ui.stc_tuvalaSlot, "StaticText_ItemName")
  self._ui.btn_tuvalaExchange = UI.getChildControl(self._ui.stc_tuvalaExchange, "Button_Exchange")
  self._ui.stc_tuvalaStat = UI.getChildControl(self._ui.stc_tuvalaExchange, "Static_StatusArea")
  for index = 1, self._tuvalaStatMax do
    self._ui.list_tuvalaStat[index] = {}
    self._ui.list_tuvalaStat[index].txt_name = UI.getChildControl(self._ui.stc_tuvalaStat, "StaticText_Name" .. index)
    self._ui.list_tuvalaStat[index].txt_value = UI.getChildControl(self._ui.stc_tuvalaStat, "StaticText_Value" .. index)
  end
  self._ui.txt_enchantSuccess = UI.getChildControl(self._ui.stc_effectArea, "StaticText_Enchant_Success")
  self._ui.txt_enchantFail = UI.getChildControl(self._ui.stc_effectArea, "StaticText_Enchant_Fail")
  self._ui.stc_effect = UI.getChildControl(self._ui.stc_effectArea, "Static_Effect")
  self._ui.stc_caphrasArea = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Static_CaphrasEnchantArea")
  self._ui.stc_caphrasMaterial = UI.getChildControl(self._ui.stc_caphrasArea, "Static_LeftSlot")
  self._ui.stc_caphrasMaterialSlot = UI.getChildControl(self._ui.stc_caphrasMaterial, "Static_Slot")
  self._ui.txt_caphrasCount = UI.getChildControl(self._ui.stc_caphrasMaterial, "StaticText_CaphrasCount")
  self._ui.btn_caphrasOtherMaterial = UI.getChildControl(self._ui.stc_caphrasMaterial, "Button_OtherMaterial")
  self._ui.stc_caphrasTarget = UI.getChildControl(self._ui.stc_caphrasArea, "Static_CenterSlot")
  self._ui.txt_slotCurrentStage = UI.getChildControl(self._ui.stc_caphrasTarget, "StaticText_CurrentStep")
  self._ui.stc_caphrasTargetSlot = UI.getChildControl(self._ui.stc_caphrasTarget, "Static_Slot")
  self._ui.stc_currentStage = UI.getChildControl(self._ui.stc_caphrasTarget, "Static_CurrentStepArea")
  self._ui.txt_currentStage = UI.getChildControl(self._ui.stc_currentStage, "StaticText_Current")
  self._ui.txt_currentValue = UI.getChildControl(self._ui.stc_currentStage, "StaticText_StatusValue")
  self._ui.stc_caphrasNext = UI.getChildControl(self._ui.stc_caphrasArea, "Static_RightSlot")
  self._ui.txt_slotNextStage = UI.getChildControl(self._ui.stc_caphrasNext, "StaticText_NextStep")
  self._ui.stc_caphrasNextSlot = UI.getChildControl(self._ui.stc_caphrasNext, "Static_Slot")
  self._ui.stc_nextStage = UI.getChildControl(self._ui.stc_caphrasNext, "Static_NextStepArea")
  self._ui.txt_nextStage = UI.getChildControl(self._ui.stc_nextStage, "StaticText_Next")
  self._ui.txt_nextValue = UI.getChildControl(self._ui.stc_nextStage, "StaticText_StatusValue")
  self._ui.txt_caphrasNeed = UI.getChildControl(self._ui.stc_nextStage, "StaticText_Needs")
  self._ui.stc_caphrasProgress = UI.getChildControl(self._ui.stc_caphrasArea, "Progress2_NextStep")
  self._ui.stc_caphrasEffect = UI.getChildControl(self._ui.stc_caphrasArea, "Static_Effect")
  self._ui.stc_bottonFunctionArea = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Static_BottomFunctionArea")
  self._ui.btn_perfectEnchant = UI.getChildControl(self._ui.stc_bottonFunctionArea, "CheckButton_ForceEnchant")
  self._ui.btn_enchantStart = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_Enchant")
  self._ui.btn_cronEnchantStart = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_Cron_Enchant")
  self._ui.btn_skipAnimation = UI.getChildControl(self._ui.stc_bottonFunctionArea, "CheckButton_SkipAni")
  self._ui.btn_skipAnimation:SetEnableArea(0, 0, self._ui.btn_skipAnimation:GetSizeX() + self._ui.btn_skipAnimation:GetTextSizeX() + 10, self._ui.btn_skipAnimation:GetSizeY())
  self._ui.txt_enchantNotice = UI.getChildControl(self._ui.stc_bottonFunctionArea, "MultilineText_ChooseEquipment")
  self._ui.radioBtn_normal = UI.getChildControl(self._ui.stc_bottonFunctionArea, "RadioButton_NormalEnchant")
  self._ui.radioBtn_endurance = UI.getChildControl(self._ui.stc_bottonFunctionArea, "RadioButton_EnduranceEnchant")
  self._ui.radioBtn_perfect = UI.getChildControl(self._ui.stc_bottonFunctionArea, "RadioButton_ForceEnchant")
  self._ui.btn_groupEnchantReady = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_GroupEnchant_Ready")
  self._ui.btn_groupEnchantReadyCancel = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_GroupEnchant_ReadyCancel")
  self._ui.btn_cronGroupEnchantReady = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_CronGroupEnchant_Ready")
  self._ui.btn_cronGroupEnchantReadyCancel = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_CronGroupEnchant_ReadyCancel")
  self._ui.btn_groupEnchantStart = UI.getChildControl(self._ui.stc_bottonFunctionArea, "Button_GroupEnchant_Start")
  self._ui.btn_inventory = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Static_Inventory")
  self._ui.stc_naderrBand = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Static_StackStorageArea")
  for index = 1, self._naderrSlotMax do
    self._ui.list_naderrSlot[index] = {}
    self._ui.list_naderrSlot[index].btn_body = UI.getChildControl(self._ui.stc_naderrBand, "Button_Slot_" .. index)
    self._ui.list_naderrSlot[index].txt_total = UI.getChildControl(self._ui.list_naderrSlot[index].btn_body, "StaticText_CurrentValue")
    self._ui.list_naderrSlot[index].txt_base = UI.getChildControl(self._ui.list_naderrSlot[index].btn_body, "StaticText_BaseValue")
    self._ui.list_naderrSlot[index].txt_valks = UI.getChildControl(self._ui.list_naderrSlot[index].btn_body, "StaticText_ValksValue")
    self._ui.list_naderrSlot[index].stc_lock = UI.getChildControl(self._ui.list_naderrSlot[index].btn_body, "Static_LockSlot")
  end
  self._ui.btn_leftPage = UI.getChildControl(self._ui.stc_naderrBand, "Button_Left")
  self._ui.btn_rightPage = UI.getChildControl(self._ui.stc_naderrBand, "Button_Right")
  self._ui.btn_groupEnchant = UI.getChildControl(Panel_Widget_Enchant_Main_All, "Button_Banner")
  PaGlobal_EnchantMain_All:InitSlots()
end
function PaGlobal_EnchantMain_All:InitSlots()
  local slotTarget = {}
  SlotItem.new(slotTarget, "EnchantSlotTarget", 0, self._ui.stc_enchantTargetSlot, self._slotConfig)
  slotTarget:createChild()
  slotTarget.empty = true
  slotTarget:clearItem()
  slotTarget.border:SetSize(44, 44)
  slotTarget.border:SetPosX(0)
  slotTarget.border:SetPosY(0)
  Panel_Tooltip_Item_SetPosition(0, slotTarget, "Enchant")
  if self._isConsole == true then
    self._ui.stc_enchantTargetSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_TargetSlot(nil)")
    slotTarget.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotTarget.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_TargetSlot(false)")
  else
    slotTarget.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_TargetSlot(true)")
    slotTarget.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_TargetSlot(false)")
    slotTarget.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
  end
  self._slotTarget = slotTarget
  local slotMaterial = {}
  SlotItem.new(slotMaterial, "EnchantSlotMaterial", 0, self._ui.stc_enchantMaterialSlot, self._slotConfig)
  slotMaterial:createChild()
  slotMaterial.empty = true
  slotMaterial:clearItem()
  slotMaterial.border:SetSize(44, 44)
  slotMaterial.border:SetPosX(0)
  slotMaterial.border:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_enchantMaterialSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_MaterialSlot(nil)")
    slotMaterial.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotMaterial.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_MaterialSlot(false)")
  else
    slotMaterial.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotMaterial.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_MaterialSlot(true)")
    slotMaterial.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_MaterialSlot(false)")
    slotMaterial.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_OtherMaterial()")
  end
  self._slotMaterial = slotMaterial
  local slotProtector = {}
  SlotItem.new(slotProtector, "EnchantSlotProtector", 0, self._ui.stc_protectorSlot, self._slotConfig)
  slotProtector:createChild()
  slotProtector.empty = true
  slotProtector:clearItem()
  slotProtector.border:SetSize(44, 44)
  slotProtector.icon:SetPosX(-6.5)
  slotProtector.icon:SetPosY(-0.5)
  Panel_Tooltip_Item_SetPosition(0, slotProtector, "Enchant")
  if self._isConsole == true then
    self._ui.stc_protectorSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_ProtectorSlot(nil)")
    slotProtector.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMain_All_ClearProtector()")
    slotProtector.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_ProtectorSlot(false)")
  else
    slotProtector.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_EnchantMain_All_ClearProtector()")
    slotProtector.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_ProtectorSlot(true)")
    slotProtector.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_ProtectorSlot(false)")
    slotProtector.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ProtectorSelect()")
  end
  self._slotProtector = slotProtector
  local slotCaphrasMaterial = {}
  SlotItem.new(slotCaphrasMaterial, "EnchantSlotCaphrasMaterial", 0, self._ui.stc_caphrasMaterialSlot, self._slotConfig)
  slotCaphrasMaterial:createChild()
  slotCaphrasMaterial.empty = true
  slotCaphrasMaterial:clearItem()
  slotCaphrasMaterial.border:SetSize(44, 44)
  slotCaphrasMaterial.icon:SetPosX(0)
  slotCaphrasMaterial.icon:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_caphrasMaterialSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_MaterialSlot(nil)")
    slotCaphrasMaterial.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotCaphrasMaterial.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_MaterialSlot(false)")
  else
    slotCaphrasMaterial.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotCaphrasMaterial.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_MaterialSlot(true)")
    slotCaphrasMaterial.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_MaterialSlot(false)")
    slotCaphrasMaterial.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_OtherMaterial()")
  end
  self._slotCaphrasMaterial = slotCaphrasMaterial
  local slotCaphrasTarget = {}
  SlotItem.new(slotCaphrasTarget, "EnchantSlotCaphrasTarget", 0, self._ui.stc_caphrasTargetSlot, self._slotConfig)
  slotCaphrasTarget:createChild()
  slotCaphrasTarget.empty = true
  slotCaphrasTarget:clearItem()
  slotCaphrasTarget.border:SetSize(44, 44)
  slotCaphrasTarget.icon:SetPosX(0)
  slotCaphrasTarget.icon:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_caphrasTargetSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_SlotCaphrasTarget(nil)")
    slotCaphrasTarget.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotCaphrasTarget.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_SlotCaphrasTarget(false)")
  else
    slotCaphrasTarget.icon:addInputEvent("Mouse_RUp", "PaGlobalFunc_EnchantMain_All_ClearEnchantTarget()")
    slotCaphrasTarget.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_SlotCaphrasTarget(true)")
    slotCaphrasTarget.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_SlotCaphrasTarget(false)")
  end
  self._slotCaphrasTarget = slotCaphrasTarget
  local slotCaphrasNext = {}
  SlotItem.new(slotCaphrasNext, "EnchantSlotCaphrasNext", 0, self._ui.stc_caphrasNextSlot, self._slotConfig)
  slotCaphrasNext:createChild()
  slotCaphrasNext.empty = true
  slotCaphrasNext:clearItem()
  slotCaphrasNext.border:SetSize(44, 44)
  slotCaphrasNext.icon:SetPosX(0)
  slotCaphrasNext.icon:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_caphrasNextSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_SlotCaphrasNext(nil)")
    slotCaphrasNext.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_SlotCaphrasNext(false)")
  else
    slotCaphrasNext.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_SlotCaphrasNext(true)")
    slotCaphrasNext.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_SlotCaphrasNext(false)")
  end
  self._slotCaphrasNext = slotCaphrasNext
  local slotTuvala = {}
  SlotItem.new(slotTuvala, "EnchantSlotTuvala", 0, self._ui.stc_tuvalaSlot, self._slotConfig)
  slotTuvala:createChild()
  slotTuvala.empty = true
  slotTuvala:clearItem()
  slotTuvala.border:SetSize(44, 44)
  slotTuvala.icon:SetPosX(0)
  slotTuvala.icon:SetPosY(0)
  if self._isConsole == true then
    self._ui.stc_tuvalaSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantMain_slotTuvala(nil)")
    slotTuvala.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_slotTuvala(false)")
  else
    slotTuvala.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantMain_slotTuvala(true)")
    slotTuvala.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantMain_slotTuvala(false)")
  end
  self._slotTuvala = slotTuvala
end
function PaGlobal_EnchantMain_All:resize()
  Panel_Widget_Enchant_Main_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_Enchant_Main_All:ComputePosAllChild()
  Panel_Widget_StackStorage_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Widget_StackStorage_All:ComputePos()
  self._ui.stc_background:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.stc_background:ComputePos()
end
function PaGlobal_EnchantMain_All:prepareOpen()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  Inventory_SetFunctor(nil, PaGlobal_Enchant_All_RClickInventory, nil, nil)
  local isEnterGroupEnchant = ToClient_GetIsEnterGroupEnchant()
  ToClient_SetIsGroupEnchant(isEnterGroupEnchant)
  ToClient_ClearEnchantTarget()
  ToClient_RequestEnchantRecord(__eEnchantRecord_EnchantPanelOpen)
  PaGlobal_EnchantMain_All:resetAnimation()
  PaGlobal_EnchantMain_All:open()
  PaGlobal_EnchantMain_All:update()
  if ToClient_GetIsGroupEnchant() == true then
    PaGlobal_PartyEnchant:prepareOpen()
  end
end
function PaGlobal_EnchantMain_All:open()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  Panel_Widget_Enchant_Main_All:SetShow(true)
end
function PaGlobal_EnchantMain_All:handleGroupEnchantClose()
  if _ContentsGroup_SpiritGroupEnchant == false then
    return false
  end
  if ToClient_IsGroupEnchantAble() == false then
    return false
  end
  if PaGlobal_PartyEnchant._isAnimating == true then
    return true
  end
  if RequestParty_isLeader() == true then
    local doExit = function()
      ToClient_RequestGroupEnchantCancel()
      PaGlobal_EnchantMain_All:prepareClose()
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "PANEL_EVENT_PARTYENCHANT_CLOSE"),
      functionYes = doExit,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    local selfPlayer = getSelfPlayer()
    local isDead
    if nil ~= selfPlayer then
      isDead = selfPlayer:isDead()
    end
    if isDead == true then
      ToClient_RequestGroupEnchantCancel()
      return false
    end
    MessageBox.showMessageBox(messageBoxData)
    return true
  end
  ToClient_RequestGroupEnchantItemSetCancel()
  return false
end
function PaGlobal_EnchantMain_All:prepareClose()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  if false == _ContentsGroup_RenewUI_Inventory then
    PaGlobalFunc_Inventory_All_CloseWithSpiritEnchant()
  else
    InventoryWindow_Close()
  end
  ToClient_SetIsGroupEnchant(false)
  if _ContentsGroup_SpiritGroupEnchant == true then
    PaGlobalFunc_PartyEnchant_Close()
  end
  PaGlobalFunc_EnchantStackConfirm_All_Close()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  PaGlobal_EnchantMain_All:cancelAnimation()
  PaGlobal_EnchantMain_All:close()
  HandleEventLUp_DialogMain_All_BackClick()
  if self._isConsole == true and PaGlobal_Enchant_Console_KeyGuide_Close ~= nil then
    PaGlobal_Enchant_Console_KeyGuide_Close()
  end
end
function PaGlobal_EnchantMain_All:close()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  Panel_Widget_Enchant_Main_All:SetShow(false)
end
function PaGlobal_EnchantMain_All:registEventHandler()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  self._ui.btn_otherMaterial:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_OtherMaterial()")
  self._ui.btn_enchantStart:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_StartButton()")
  self._ui.btn_cronEnchantStart:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_StartCronButton()")
  self._ui.btn_selectProtector:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ProtectorSelect()")
  self._ui.stc_agrisProgress:addInputEvent("Mouse_On", "HandleEventOnOut_EnchantMain_GuaranteeStackTooltip(true)")
  self._ui.stc_agrisProgress:addInputEvent("Mouse_Out", "HandleEventOnOut_EnchantMain_GuaranteeStackTooltip(false)")
  self._ui.btn_stack:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_StackSelect()")
  self._ui.stc_rateValueBG:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_StackSelect()")
  self._ui.btn_stack:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENCHANT_PROBABILTY2 .. ", true)")
  self._ui.btn_stack:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENCHANT_PROBABILTY2 .. ", false)")
  self._ui.txt_currentStack:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_StackSelect()")
  self._ui.txt_currentStack:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENCHANT_PROBABILTY .. ", true)")
  self._ui.txt_currentStack:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENCHANT_PROBABILTY .. ", false)")
  self._ui.txt_currentValksCry:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_StackSelect()")
  self._ui.txt_currentValksCry:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENCHANT_VALCKSCRY .. ", true)")
  self._ui.txt_currentValksCry:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENCHANT_VALCKSCRY .. ", false)")
  self._ui.btn_othersChoice:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_OthersChoice()")
  self._ui.btn_othersChoice:addInputEvent("Mouse_On", "PaGlobalFunc_EnchantMain_HandleOthersChoiceTooltip(true)")
  self._ui.btn_othersChoice:addInputEvent("Mouse_Out", "PaGlobalFunc_EnchantMain_HandleOthersChoiceTooltip(false)")
  self._ui.stc_naderrBand:addInputEvent("Mouse_UpScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(-1)")
  self._ui.stc_naderrBand:addInputEvent("Mouse_DownScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(1)")
  for index = 1, self._naderrSlotMax do
    self._ui.list_naderrSlot[index].btn_body:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_SelectNaderrSlot(" .. index .. ")")
    self._ui.list_naderrSlot[index].btn_body:addInputEvent("Mouse_On", "HandleEvent_EnchantMain_HoverNaderrSlot(true, " .. index .. ")")
    self._ui.list_naderrSlot[index].btn_body:addInputEvent("Mouse_Out", "HandleEvent_EnchantMain_HoverNaderrSlot(false, " .. index .. ")")
    self._ui.list_naderrSlot[index].btn_body:addInputEvent("Mouse_UpScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(-1)")
    self._ui.list_naderrSlot[index].btn_body:addInputEvent("Mouse_DownScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(1)")
    if ToClient_isConsole() == false then
      self._ui.list_naderrSlot[index].stc_lock:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_Open(82)")
    end
    self._ui.list_naderrSlot[index].stc_lock:addInputEvent("Mouse_UpScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(-1)")
    self._ui.list_naderrSlot[index].stc_lock:addInputEvent("Mouse_DownScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(1)")
  end
  self._ui.btn_extraction:addInputEvent("Mouse_LUp", "PaGlobalFunc_StackExtraction_All_Open()")
  self._ui.btn_extraction:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.EXTRACTION_STACK .. ", true)")
  self._ui.btn_extraction:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.EXTRACTION_STACK .. ", false)")
  self._ui.btn_leftPage:addInputEvent("Mouse_UpScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(-1)")
  self._ui.btn_rightPage:addInputEvent("Mouse_DownScroll", "HandleEventLUp_EnchantMain_ChangeNaderrPage(1)")
  self._ui.btn_leftPage:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ChangeNaderrPage(-1)")
  self._ui.btn_rightPage:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ChangeNaderrPage(1)")
  self._ui.btn_caphrasOtherMaterial:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_OtherMaterial()")
  self._ui.btn_inventory:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_Inventory()")
  self._ui.btn_tuvalaExchange:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_TuvalaButton()")
  self._ui.btn_perfectEnchant:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_TogglePerfectButton()")
  self._ui.btn_perfectEnchant:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.PERFECT_ENCHANT .. ", true)")
  self._ui.btn_perfectEnchant:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.PERFECT_ENCHANT .. ", false)")
  self._ui.radioBtn_normal:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_SetCurrentEnchantType(" .. __eEnchantType_Normal .. ")")
  self._ui.radioBtn_normal:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.NORMAL_ENCHANT .. ", true)")
  self._ui.radioBtn_normal:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.NORMAL_ENCHANT .. ", false)")
  self._ui.radioBtn_endurance:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_SetCurrentEnchantType(" .. __eEnchantType_Endurance .. ")")
  self._ui.radioBtn_endurance:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENDURANCE_ENCHANT .. ", true)")
  self._ui.radioBtn_endurance:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.ENDURANCE_ENCHANT .. ", false)")
  self._ui.radioBtn_perfect:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_SetCurrentEnchantType(" .. __eEnchantType_Perfect .. ")")
  self._ui.radioBtn_perfect:addInputEvent("Mouse_On", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.PERFECT_ENCHANT_RADIO .. ", true)")
  self._ui.radioBtn_perfect:addInputEvent("Mouse_Out", "HandleEventOnOut_Enchant_All_Tooltip(" .. self._TOOLTIP_TYPE.PERFECT_ENCHANT_RADIO .. ", false)")
  self._ui.btn_groupEnchant:addInputEvent("Mouse_LUp", "ToClient_RequestPrepareGroupEnchant()")
  self._ui.btn_groupEnchantReady:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ReadyGroupEnchant(false)")
  self._ui.btn_groupEnchantReadyCancel:addInputEvent("Mouse_LUp", "ToClient_RequestGroupEnchantItemSetCancel()")
  self._ui.btn_cronGroupEnchantReady:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ReadyGroupEnchant(true)")
  self._ui.btn_cronGroupEnchantReadyCancel:addInputEvent("Mouse_LUp", "ToClient_RequestGroupEnchantItemSetCancel()")
  self._ui.btn_groupEnchantStart:addInputEvent("Mouse_LUp", "ToClient_RequestGroupEnchantAniStart()")
  self._ui.btn_skipAnimation:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_ToggleSkipAnimation(nil)")
  Panel_Widget_Enchant_Main_All:RegisterUpdateFunc("PaGlobal_EnchantMain_All_UpdateFunc")
  registerEvent("FromClient_UpdateEnchantMain", "FromClient_UpdateEnchantMain")
  registerEvent("FromClient_ResponseEnchant", "FromClient_ResponseEnchant")
  registerEvent("FromClient_StrartGroupEnchantAni", "FromClient_StrartGroupEnchantRemasterAni")
  registerEvent("FromClient_SetEnchantTarget", "FromClient_SetEnchantTarget")
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_EnchantMain_UpdateEnchantTargetList")
end
function PaGlobal_EnchantMain_All:validate()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
end
function PaGlobal_EnchantMain_All:update()
  if nil == Panel_Widget_Enchant_Main_All or Panel_Widget_Enchant_Main_All:GetShow() == false then
    return
  end
  local isCaphrasScreen = ToClient_IsCurrentMaterialCaphras()
  self:toggleCaphrasArea(isCaphrasScreen)
  if isCaphrasScreen == true then
    self:updateCaphrasScreen()
  else
    self:updateEnchantScreen()
  end
  self:updateFunctionButtons()
  self:updateBottomAreaButtons()
  self:updateNaderrBand()
  self:handleOtherPanels()
  self:updateGroupEnchant()
  self:resize()
end
function PaGlobal_EnchantMain_All:updateGroupEnchant()
  if _ContentsGroup_SpiritGroupEnchant == false then
    self._ui.btn_groupEnchant:SetShow(false)
    return
  end
  local isGroupEnchant = ToClient_GetIsGroupEnchant()
  self._ui.btn_groupEnchant:SetShow(RequestParty_isLeader() == true and isGroupEnchant == false and ToClient_IsCurrentMaterialCaphras() == false)
  if isGroupEnchant == false then
    self._ui.btn_skipAnimation:SetShow(true)
    self._ui.btn_groupEnchantReady:SetShow(false)
    self._ui.btn_groupEnchantReadyCancel:SetShow(false)
    self._ui.btn_cronGroupEnchantReady:SetShow(false)
    self._ui.btn_cronGroupEnchantReadyCancel:SetShow(false)
    self._ui.btn_groupEnchantStart:SetShow(false)
    return
  end
  local isPartyLeader = RequestParty_isLeader()
  local isAnimating = self:isAnimating()
  local isReadyGroupEnchant = ToClient_GetIsReadyGroupEnchant()
  self._ui.btn_skipAnimation:SetShow(false)
  self._ui.btn_skipAnimation:SetCheck(false)
  self._ui.btn_cronEnchantStart:EraseAllEffect()
  self._ui.btn_cronGroupEnchantReady:EraseAllEffect()
  self._ui.btn_cronGroupEnchantReadyCancel:EraseAllEffect()
  if isAnimating == true then
    self._ui.btn_groupEnchantReady:SetShow(false)
    self._ui.btn_groupEnchantReadyCancel:SetShow(true)
    self._ui.btn_cronGroupEnchantReady:SetShow(false)
    self._ui.btn_cronGroupEnchantReadyCancel:SetShow(true)
    self._ui.btn_groupEnchantStart:SetShow(isPartyLeader == true)
    self._ui.btn_groupEnchantReadyCancel:SetMonoTone(true)
    self._ui.btn_groupEnchantReadyCancel:SetIgnore(true)
    self._ui.btn_cronGroupEnchantReadyCancel:SetMonoTone(true)
    self._ui.btn_cronGroupEnchantReadyCancel:SetIgnore(true)
    self._ui.btn_groupEnchantStart:SetMonoTone(true)
    self._ui.btn_groupEnchantStart:SetIgnore(true)
  elseif isReadyGroupEnchant == false then
    self._ui.btn_groupEnchantReady:SetShow(true)
    self._ui.btn_groupEnchantReadyCancel:SetShow(false)
    self._ui.btn_cronGroupEnchantReady:SetShow(true)
    self._ui.btn_cronGroupEnchantReadyCancel:SetShow(false)
    self._ui.btn_groupEnchantStart:SetShow(false)
    local startButtonType = ToClient_GetEnchantButtonType(false, false)
    local cronStartButtonType = ToClient_GetEnchantButtonType(true, false)
    self._ui.btn_groupEnchantReady:SetMonoTone(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_groupEnchantReady:SetIgnore(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_groupEnchantReadyCancel:SetMonoTone(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_groupEnchantReadyCancel:SetIgnore(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronGroupEnchantReady:SetMonoTone(cronStartButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronGroupEnchantReady:SetIgnore(cronStartButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronGroupEnchantReadyCancel:SetMonoTone(cronStartButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronGroupEnchantReadyCancel:SetIgnore(cronStartButtonType == __eEnchantButtonType_Unavailable)
    if self._ui.btn_cronGroupEnchantReady:IsIgnore() == false then
      self._ui.btn_cronGroupEnchantReady:AddEffect("fUI_SpiritEnchant_New_DropBlock_01A", true, 0, 0)
      self._ui.stc_protectorEffect:AddEffect("fUI_SpiritEnchant_New_Cron_Slot_01A", true, 0, 0)
    end
  else
    self._ui.btn_groupEnchantReady:SetShow(false)
    self._ui.btn_groupEnchantReadyCancel:SetShow(true)
    self._ui.btn_cronGroupEnchantReady:SetShow(false)
    self._ui.btn_cronGroupEnchantReadyCancel:SetShow(true)
    self._ui.btn_groupEnchantStart:SetShow(isPartyLeader == true)
    local startButtonType = ToClient_GetEnchantButtonType(false, false)
    local cronStartButtonType = ToClient_GetEnchantButtonType(true, false)
    self._ui.btn_groupEnchantReady:SetMonoTone(startButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_groupEnchantReady:SetIgnore(startButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_groupEnchantReadyCancel:SetMonoTone(startButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_groupEnchantReadyCancel:SetIgnore(startButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_cronGroupEnchantReady:SetMonoTone(cronStartButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_cronGroupEnchantReady:SetIgnore(cronStartButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_cronGroupEnchantReadyCancel:SetMonoTone(cronStartButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_cronGroupEnchantReadyCancel:SetIgnore(cronStartButtonType ~= __eEnchantButtonType_Available)
    self._ui.btn_groupEnchantStart:SetMonoTone(false)
    self._ui.btn_groupEnchantStart:SetIgnore(false)
    if self._ui.btn_cronGroupEnchantReadyCancel:IsIgnore() == false then
      self._ui.btn_cronGroupEnchantReadyCancel:AddEffect("fUI_SpiritEnchant_New_DropBlock_01A", true, 0, 0)
      self._ui.stc_protectorEffect:AddEffect("fUI_SpiritEnchant_New_Cron_Slot_01A", true, 0, 0)
    end
  end
  if isReadyGroupEnchant == true then
    PaGlobalFunc_EnchantMaterial_All_Close()
    PaGlobalFunc_EnchantProtector_All_Close()
  end
  local cancelButtonPosX = self._readyCancelButtonPosX
  if isPartyLeader == false then
    cancelButtonPosX = 0
  end
  if self._isConsole == true and PaGlobal_Enchant_Console_KeyGuide_Open ~= nil then
    PaGlobal_Enchant_Console_KeyGuide_Open()
  end
end
function PaGlobal_EnchantMain_All:updateFunctionButtons()
  if ToClient_IsCurrentEnchantTargetChangableToTuvala() == true or ToClient_IsGuaranteeEnchant() == true then
    self._ui.stc_functionButtons:SetShow(false)
    self._ui.btn_othersChoice:SetShow(false)
    return
  end
  self._ui.stc_functionButtons:SetShow(true)
  self._ui.btn_othersChoice:SetShow(ToClient_CanShowOthersChoice())
end
function PaGlobal_EnchantMain_All:updateCaphrasScreen()
  self:updateCaphrasMaterialSlot()
  self:updateCaphrasTargetSlot()
  self:updateCaphrasNextSlot()
  self:updateCaphrasProgress()
  if PaGlobalFunc_OtherUser_TriedStack_Close ~= nil then
    PaGlobalFunc_OtherUser_TriedStack_Close()
  end
end
function PaGlobal_EnchantMain_All:updateCaphrasProgress()
  self._ui.stc_caphrasProgress:SetProgressRate(ToClient_GetCaphrasProgressPercent() * 100)
end
function PaGlobal_EnchantMain_All:updateCaphrasNextSlot()
  self._slotCaphrasNext:clearItem(true)
  if ToClient_IsCurrentEnchantTargetSetted() == false then
    return
  end
  if ToClient_IsTargetCaphrasPromotable() == true then
    self._slotCaphrasNext:setItemByStaticStatus(ToClient_GetNextLevelTargetItemForLua(), 1)
    local maxCaphrasLevel = ToClient_GetCurrentCaphrasLevel()
    self._ui.txt_slotNextStage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_STAGE", "num", tostring(maxCaphrasLevel)))
    self._ui.txt_caphrasNeed:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FINALENERGY"))
    self._ui.txt_nextStage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MAX_CRONELV", "level", tostring(maxCaphrasLevel)))
    self._ui.txt_nextValue:SetText("")
  else
    self._slotCaphrasNext:setItem(ToClient_GetCurrentEnchantTarget(), 0)
    local nextCaphrasLevel = ToClient_GetCurrentCaphrasLevel() + 1
    self._ui.txt_slotNextStage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_STAGE", "num", tostring(nextCaphrasLevel)))
    self._ui.txt_caphrasNeed:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_REQUIRE_CAPHRAS", "num", tostring(ToClient_GetCaphrasCountToNextLevel())))
    self._ui.txt_nextStage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_NEXT_BONUS", "bonus", tostring(nextCaphrasLevel)))
    local cronEnchantSS = ToClient_GetNextLevelCronEnchantForLua()
    local statString = self:createCaphrasStatString(cronEnchantSS)
    self._ui.txt_nextValue:SetText(statString)
  end
end
function PaGlobal_EnchantMain_All:updateCaphrasTargetSlot()
  self._slotCaphrasTarget:clearItem(true)
  local enchantTargetItemWrapper = ToClient_GetCurrentEnchantTarget()
  if enchantTargetItemWrapper == nil then
    return
  end
  self._slotCaphrasTarget:setItem(enchantTargetItemWrapper, 0)
  local currentCaphrasLevel = ToClient_GetCurrentCaphrasLevel()
  self._ui.txt_slotCurrentStage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_STAGE", "num", tostring(currentCaphrasLevel)))
  self._ui.txt_currentStage:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_CURRENT_CRONELV", "level", tostring(currentCaphrasLevel)))
  local cronEnchantSS = ToClient_GetCurrentLevelCronEnchantForLua()
  local statString = self:createCaphrasStatString(cronEnchantSS)
  self._ui.txt_currentValue:SetText(statString)
end
function PaGlobal_EnchantMain_All:createCaphrasStatString(cronEnchantSS)
  local statString = ""
  local statValue
  statValue = cronEnchantSS:getAddedDD()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_ATTACK") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedHIT()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_HIT") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedDV()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_DODGE") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedHDV()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_DODGE") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedPV()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_REDUCE") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedHPV()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_REDUCE") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedMaxHP()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_HP") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  statValue = cronEnchantSS:getAddedMaxMP()
  if statValue > 0 then
    statString = statString .. "<PAColor0xFFD8AD70>" .. PAGetString(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_CAPHRAS_MP") .. "<PAOldColor>  +" .. tostring(statValue) .. "\n"
  end
  return statString
end
function PaGlobal_EnchantMain_All:updateCaphrasMaterialSlot()
  self._slotCaphrasMaterial:clearItem(true)
  self._ui.txt_caphrasCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_CAPHRAS", "value", 0))
  local enchantMaterialItemWrapper = ToClient_GetCurrentEnchantMaterial()
  if enchantMaterialItemWrapper == nil then
    return
  end
  self._slotCaphrasMaterial:setItemByStaticStatus(enchantMaterialItemWrapper:getStaticStatus(), ToClient_GetCaphrasMaterialNeedItemCount())
  self._ui.txt_caphrasCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_CAPHRAS", "value", tostring(enchantMaterialItemWrapper:getCount())))
end
function PaGlobal_EnchantMain_All:updateEnchantScreen()
  self:updateEnchantTargetSlot()
  self:updateAgrisStack()
  self:updateSuccessRate()
  self:updateEnchantMaterialSlot()
  self:updateProtectorSlot()
  self:updateEnchantRate()
  self:updateTuvalaExchange()
end
function PaGlobal_EnchantMain_All:updateTuvalaExchange()
  if ToClient_IsCurrentEnchantTargetSetted() == false then
    self._ui.stc_tuvalaExchange:SetShow(false)
    return
  end
  if ToClient_IsCurrentEnchantTargetChangableToTuvala() == false then
    self._ui.stc_tuvalaExchange:SetShow(false)
    return
  end
  self._ui.stc_tuvalaExchange:SetShow(true)
  self._slotTuvala:clearItem()
  local tuvalaItemKey = ToClient_getTubalaItemForNaruItemEnchantKey(ToClient_GetCurrentEnchantTarget():getStaticStatus():get()._key)
  local tuvalaItemSSW = getItemEnchantStaticStatus(tuvalaItemKey)
  self._slotTuvala:setItemByStaticStatus(tuvalaItemSSW, 1)
  self._ui.txt_tuvalaName:SetText(tuvalaItemSSW:getName())
  local minAttack, maxAttack, hit, dv, hdv, pv, hpv = 0, 0, 0, 0, 0, 0, 0
  for index = 0, __eAttackTypeCount - 1 do
    local currentMin = tuvalaItemSSW:getMinDamage(index)
    minAttack = math.max(minAttack, currentMin)
    local currentMax = tuvalaItemSSW:getMaxDamage(index)
    maxAttack = math.max(maxAttack, currentMax)
    local currentHit = tuvalaItemSSW:ToClient_getHit(index)
    hit = math.max(hit, currentHit)
    local currnetDv = tuvalaItemSSW:ToClient_getDV(index)
    dv = math.max(dv, currnetDv)
    local currentHDV = tuvalaItemSSW:ToClient_getHDV(index)
    hdv = math.max(hdv, currentHDV)
    local currentPv = tuvalaItemSSW:ToClient_getPV(index)
    pv = math.max(pv, currentPv)
    local currentHPv = tuvalaItemSSW:ToClient_getHPV(index)
    hpv = math.max(hpv, currentHPv)
  end
  local defencePoint = dv + pv
  for index = 1, self._tuvalaStatMax do
    self._ui.list_tuvalaStat[index].txt_name:SetShow(false)
    self._ui.list_tuvalaStat[index].txt_value:SetShow(false)
  end
  local currentIndex = 1
  if minAttack + maxAttack > 0 then
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEPOINT_ATTACKPOINT"))
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetText(minAttack .. " ~ " .. maxAttack)
    currentIndex = currentIndex + 1
  end
  if hit > 0 then
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TEXT_HIT"))
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetText(tostring(hit))
    currentIndex = currentIndex + 1
  end
  if defencePoint > 0 then
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE"))
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetText(tostring(defencePoint))
    currentIndex = currentIndex + 1
  end
  if dv > 0 then
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetShow(true)
    local valueString = tostring(dv)
    if hdv > 0 then
      valueString = valueString .. "(+" .. hdv .. ")"
    end
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEPOINT_DODGETITLE"))
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetText(valueString)
    currentIndex = currentIndex + 1
  end
  if pv > 0 then
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetShow(true)
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetShow(true)
    local valueString = tostring(pv)
    if hpv > 0 then
      valueString = valueString .. "(+" .. hpv .. ")"
    end
    self._ui.list_tuvalaStat[currentIndex].txt_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BATTLEPOINT_REDUCEDAMAGEPOINT"))
    self._ui.list_tuvalaStat[currentIndex].txt_value:SetText(valueString)
    currentIndex = currentIndex + 1
  end
end
function PaGlobal_EnchantMain_All:updateEnchantRate()
  if ToClient_IsCurrentEnchantTargetChangableToTuvala() == true or ToClient_IsGuaranteeEnchant() == true then
    self._ui.txt_rateText:SetShow(false)
    self._ui.txt_currentStack:SetShow(false)
    self._ui.txt_currentValksCry:SetShow(false)
    self._ui.txt_totalStack:SetShow(false)
    return
  end
  self._ui.txt_rateText:SetShow(true)
  self._ui.txt_currentStack:SetShow(true)
  self._ui.txt_currentValksCry:SetShow(true)
  self._ui.txt_totalStack:SetShow(ToClient_IsCurrentEnchantTargetSetted() == true)
  local enchantStack = ToClient_GetEnchantStack()
  local valksStack = ToClient_GetValksStack()
  local totalStack = enchantStack + valksStack + ToClient_GetBonusStack()
  self._ui.txt_currentStack:SetText(tostring(enchantStack))
  self._ui.txt_currentValksCry:SetText(tostring(valksStack))
  self._ui.txt_totalStack:SetText(totalStack .. " (+" .. self:getAdditionalSuccessRate(false) .. "%)")
end
function PaGlobal_EnchantMain_All:updateEnchantTargetSlot()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  self._slotTarget:clearItem(true)
  local enchantTargetItemWrapper = ToClient_GetCurrentEnchantTarget()
  if enchantTargetItemWrapper ~= nil then
    self._slotTarget:setItem(enchantTargetItemWrapper, 0)
  end
  self:updateEnchantTargetEffect()
end
function PaGlobal_EnchantMain_All:updateAgrisStack()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  local enchantTargetItemWrapper = ToClient_GetCurrentEnchantTarget()
  self._ui.stc_agrisEffect:EraseAllEffect()
  self._ui.stc_agris:SetShow(false)
  if enchantTargetItemWrapper ~= nil and enchantTargetItemWrapper:getSSEnchantCount() ~= 0 and ToClient_IsCurrentEnchantTargetChangableToTuvala() == false then
    local ssEnchantCount = enchantTargetItemWrapper:getSSEnchantCount()
    local currentEnchantCount = enchantTargetItemWrapper:getCurrentEnchantCount()
    self._ui.stc_agris:SetShow(true)
    self._ui.stc_agrisProgress:SetProgressRate(currentEnchantCount / ssEnchantCount * 100)
    self._ui.txt_agrisText:SetText(tostring(currentEnchantCount) .. " / " .. tostring(ssEnchantCount))
    if ssEnchantCount == currentEnchantCount then
      self._ui.stc_agrisEffect:AddEffect("fUI_SpiritEnchant_New_Hammer_01A", true, 0, 0)
    end
  end
  self._ui.stc_agrisDesc:SetShow(ToClient_IsGuaranteeEnchant() == true)
end
function PaGlobal_EnchantMain_All:updateSuccessRate()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  if ToClient_IsCurrentEnchantTargetChangableToTuvala() == true then
    self._ui.txt_successRate:SetShow(false)
    return
  end
  local successRate = self:getSuccessRate()
  self._ui.txt_successRate:SetShow(ToClient_IsCurrentEnchantTargetSetted())
  self._ui.txt_successRate:SetText(successRate .. "%")
  self._ui.txt_successRate:useGlowFont(true, "RealFont_14_Glow", 2581371171)
  self._ui.stc_circularProgress:SetProgressRate(successRate)
end
function PaGlobal_EnchantMain_All:getAdditionalSuccessRate(isStackCalculate)
  local rate = ToClient_GetEnchantRemasterSuccessRate(false, isStackCalculate) - ToClient_GetEnchantRemasterSuccessRate(true, isStackCalculate)
  if rate < 0 then
    rate = 0
  end
  local enchantPercentString = ""
  if _ContentsGroup_ViewRate == true then
    enchantPercentString = rate / CppDefine.e100Percent * 100
  else
    enchantPercentString = string.format("%.2f", rate / CppDefine.e100Percent * 100)
  end
  return enchantPercentString
end
function PaGlobal_EnchantMain_All:getSuccessRate()
  local rate = ToClient_GetEnchantRemasterSuccessRate(false, false)
  if ToClient_IsGuaranteeEnchant() == true then
    rate = 1000000
  end
  if rate < 0 then
    rate = 0
  end
  local enchantPercentString = ""
  if _ContentsGroup_ViewRate == true then
    enchantPercentString = rate / CppDefine.e100Percent * 100
  else
    enchantPercentString = string.format("%.2f", rate / CppDefine.e100Percent * 100)
  end
  return enchantPercentString
end
function PaGlobal_EnchantMain_All:updateEnchantMaterialSlot()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  self._slotMaterial:clearItem(true)
  self._ui.btn_otherMaterial:SetShow(ToClient_GetEnchantMaterialListSize() > 0)
  local enchantTargetItemWrapper = ToClient_GetCurrentEnchantTarget()
  if enchantTargetItemWrapper == nil then
    return
  end
  local enchantMaterialItemWrapper = ToClient_GetCurrentEnchantMaterial()
  local enchantMaterialSetted = ToClient_IsCurrentEnchantMaterialSetted()
  self._slotMaterial.icon:SetMonoTone(enchantMaterialSetted == false)
  if enchantMaterialItemWrapper ~= nil then
    self._slotMaterial:setItemByStaticStatus(enchantMaterialItemWrapper:getStaticStatus(), ToClient_GetEnchantMaterialNeedItemCount())
    return
  end
  local enchantMaterialItemStaticStatus = ToClient_GetNeedMaterialItemStaticStatus()
  if enchantMaterialItemStaticStatus ~= nil then
    self._slotMaterial:setItemByStaticStatus(enchantMaterialItemStaticStatus, ToClient_GetEnchantMaterialNeedItemCount())
  end
end
function PaGlobal_EnchantMain_All:updateProtectorSlot()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  self._slotProtector:clearItem(true)
  self._ui.stc_protector:SetShow(ToClient_GetProtectorNeedItemCount() > 0 and ToClient_IsNewPerfectEnchantSetted() == false)
  local isProtectorAvailable = 0 < ToClient_GetProtectorListSize()
  self._ui.btn_selectProtector:SetShow(isProtectorAvailable)
  local enchantTargetItemWrapper = ToClient_GetCurrentEnchantTarget()
  if enchantTargetItemWrapper == nil then
    return
  end
  local protectorSS = ToClient_GetCurrentProtectorForLua()
  if protectorSS == nil then
    protectorSS = ToClient_GetCronStoneStaticStatus()
  end
  local protectorSetted = ToClient_IsCurrentProtectorSetted()
  local protectorCount = ToClient_GetProtectorNeedItemCount()
  self._slotProtector.icon:SetMonoTone(protectorSetted == false)
  self._slotProtector:setItemByStaticStatus(protectorSS, protectorCount)
  local ownedCount = ToClient_GetOwnedProtectorCount()
  self._ui.txt_currentProtectorCount:SetShow(ownedCount ~= 0)
  self._ui.txt_currentProtectorCount:SetText(tostring(ownedCount))
end
function PaGlobal_EnchantMain_All:clearEnchantTarget()
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  local itemWrapper = ToClient_GetCurrentEnchantTarget()
  if itemWrapper == nil then
    return
  end
  local itemStatic = itemWrapper:getStaticStatus():get()
  if itemStatic == nil then
    return
  end
  audioPostEvent_SystemItem(itemStatic._itemMaterial)
  ToClient_ClearEnchantTarget()
end
function PaGlobal_EnchantMain_All:clearProtector()
  local protectorSS = ToClient_GetCurrentProtectorForLua()
  if protectorSS == nil then
    return
  end
  local itemStatic = protectorSS:get()
  if itemStatic == nil then
    return
  end
  audioPostEvent_SystemItem(itemStatic._itemMaterial)
  ToClient_ClearCurrentProtector()
end
function PaGlobal_EnchantMain_All:updateEnchantTypeButtons()
  self._ui.btn_perfectEnchant:SetShow(false)
  self._ui.radioBtn_normal:SetShow(false)
  self._ui.radioBtn_endurance:SetShow(false)
  self._ui.radioBtn_perfect:SetShow(false)
  self._ui.btn_perfectEnchant:SetCheck(false)
  self._ui.radioBtn_normal:SetCheck(false)
  self._ui.radioBtn_endurance:SetCheck(false)
  self._ui.radioBtn_perfect:SetCheck(false)
  if ToClient_IsCurrentMaterialCaphras() == true then
    return
  end
  local isPerfectEnchantAvailable = ToClient_IsPerfectEnchantAvailable()
  local enchantType = ToClient_GetCurrentEnchantType()
  if ToClient_IsEnduranceEnchantAvailable() == true then
    self._ui.radioBtn_normal:SetShow(true)
    self._ui.radioBtn_endurance:SetShow(true)
    if isPerfectEnchantAvailable == true then
      self._ui.radioBtn_perfect:SetShow(true)
    end
    if enchantType == __eEnchantType_Normal then
      self._ui.radioBtn_normal:SetCheck(true)
    elseif enchantType == __eEnchantType_Perfect then
      self._ui.radioBtn_perfect:SetCheck(true)
    elseif enchantType == __eEnchantType_Endurance then
      self._ui.radioBtn_endurance:SetCheck(true)
    end
    return
  end
  if isPerfectEnchantAvailable == true then
    self._ui.btn_perfectEnchant:SetShow(true)
    self._ui.btn_perfectEnchant:SetCheck(enchantType == __eEnchantType_Perfect)
    return
  end
end
function PaGlobal_EnchantMain_All:updateBottomAreaButtons()
  self._ui.txt_enchantNotice:SetText(self:getNoticeText())
  local isCaphrasScreen = ToClient_IsCurrentMaterialCaphras()
  local buttonName = ""
  local startButtonType = __eEnchantButtonType_Count
  local cronStartButtonType = __eEnchantButtonType_Count
  self._ui.stc_protectorEffect:EraseAllEffect()
  self._ui.btn_cronEnchantStart:EraseAllEffect()
  if PaGlobal_EnchantMain_All:isAnimating() == true then
    startButtonType = ToClient_GetEnchantButtonType(false, true)
    cronStartButtonType = ToClient_GetEnchantButtonType(true, true)
    if startButtonType ~= __eEnchantButtonType_Unavailable then
      self._ui.btn_enchantStart:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL"))
    end
    self._ui.btn_enchantStart:SetMonoTone(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_enchantStart:SetIgnore(startButtonType == __eEnchantButtonType_Unavailable)
    if cronStartButtonType ~= __eEnchantButtonType_Unavailable then
      self._ui.btn_cronEnchantStart:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL"))
    end
    self._ui.btn_cronEnchantStart:SetMonoTone(cronStartButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronEnchantStart:SetIgnore(cronStartButtonType == __eEnchantButtonType_Unavailable)
  elseif isCaphrasScreen == true then
    if ToClient_IsTargetCaphrasPromotable() == true then
      buttonName = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTTITLE")
    else
      buttonName = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_APPLY_BUTTON_NORM_CAPHRAS")
    end
    self._ui.btn_enchantStart:SetText(buttonName)
    local isAvailable = ToClient_IsTargetCaphrasUpgradable() == true or ToClient_IsTargetCaphrasPromotable() == true
    self._ui.btn_enchantStart:SetMonoTone(isAvailable == false)
    self._ui.btn_enchantStart:SetIgnore(isAvailable == false)
  else
    startButtonType = ToClient_GetEnchantButtonType(false, false)
    cronStartButtonType = ToClient_GetEnchantButtonType(true, false)
    self._ui.btn_enchantStart:SetText(PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE"))
    self._ui.btn_cronEnchantStart:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWEL_CRON_ENCHANT_BTN"))
    self._ui.btn_enchantStart:SetMonoTone(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_enchantStart:SetIgnore(startButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronEnchantStart:SetMonoTone(cronStartButtonType == __eEnchantButtonType_Unavailable)
    self._ui.btn_cronEnchantStart:SetIgnore(cronStartButtonType == __eEnchantButtonType_Unavailable)
    if self._ui.btn_cronEnchantStart:IsIgnore() == false then
      self._ui.btn_cronEnchantStart:AddEffect("fUI_SpiritEnchant_New_DropBlock_01A", true, 0, 0)
      self._ui.stc_protectorEffect:AddEffect("fUI_SpiritEnchant_New_Cron_Slot_01A", true, 0, 0)
    end
  end
  self:updateEnchantTypeButtons()
  self._ui.btn_enchantStart:SetShow(ToClient_GetIsGroupEnchant() == false)
  self._ui.btn_cronEnchantStart:SetShow(ToClient_GetIsGroupEnchant() == false and isCaphrasScreen == false)
  if isCaphrasScreen == true then
    self._ui.btn_enchantStart:SetSpanSize(0, 0)
    self._ui.btn_skipAnimation:SetSpanSize(182, 10)
  else
    self._ui.btn_enchantStart:SetSpanSize(138, 0)
    self._ui.btn_skipAnimation:SetSpanSize(320, 10)
  end
  if self._isConsole == true and PaGlobal_Enchant_Console_KeyGuide_Open ~= nil then
    PaGlobal_Enchant_Console_KeyGuide_Open()
  end
end
function PaGlobal_EnchantMain_All:updateNaderrBand()
  if ToClient_IsCurrentMaterialCaphras() == true then
    self._ui.stc_naderrBand:SetShow(false)
    return
  end
  self._ui.stc_naderrBand:SetShow(true)
  local bonusStack = ToClient_GetBonusStack()
  local slotSize = ToClient_GetFailCountSlotSize()
  local pageOffset = self._naderrSlotMax * self._naderrPage
  for uiIndex = 1, self._naderrSlotMax do
    local slotIndex = uiIndex + pageOffset
    local isInsideRange = slotSize >= slotIndex
    self._ui.list_naderrSlot[uiIndex].btn_body:SetIgnore(isInsideRange == false)
    self._ui.list_naderrSlot[uiIndex].stc_lock:SetShow(isInsideRange == false)
    self._ui.list_naderrSlot[uiIndex].txt_total:SetShow(isInsideRange == true)
    self._ui.list_naderrSlot[uiIndex].txt_base:SetShow(false)
    self._ui.list_naderrSlot[uiIndex].txt_valks:SetShow(false)
    if isInsideRange == true then
      local baseStack = ToClient_GetSlotFailCount(slotIndex - 1)
      local valksStack = ToClient_GetSlotValksCount(slotIndex - 1)
      self._ui.list_naderrSlot[uiIndex].txt_total:SetText(tostring(bonusStack + baseStack + valksStack))
      self._ui.list_naderrSlot[uiIndex].txt_base:SetText(tostring(baseStack))
      self._ui.list_naderrSlot[uiIndex].txt_valks:SetText(tostring(valksStack))
    end
  end
  self._ui.btn_leftPage:SetShow(false)
  if self._naderrPage > 0 then
    self._ui.btn_leftPage:SetShow(true)
  end
  self._ui.btn_rightPage:SetShow(false)
  if slotSize > pageOffset + self._naderrSlotMax then
    self._ui.btn_rightPage:SetShow(true)
  end
end
function PaGlobal_EnchantMain_All:selectNaderrSlot(index)
  local slotIndex = self._naderrSlotMax * self._naderrPage + index
  ToClient_RequestSwapEnchantStackSlot(slotIndex - 1)
  self._ui.list_naderrSlot[index].btn_body:EraseAllEffect()
  self._ui.list_naderrSlot[index].btn_body:AddEffect("fUI_StackChange_Click_01A", false, 0, 0)
  self._ui.stc_rateValueBG:AddEffect("fUI_SpiritEnchant_New_Dark_01A", false, 0, 0)
  self:startAudio(self._AUDIO.SELECT_NADERR)
end
function PaGlobal_EnchantMain_All:changeNaderrPage(changePage)
  if self._ui.btn_leftPage:GetShow() == false and changePage == -1 then
    return
  end
  if self._ui.btn_rightPage:GetShow() == false and changePage == 1 then
    return
  end
  self:startAudio(self._AUDIO.CHANGE_NADERR)
  PaGlobal_EnchantMain_All._naderrPage = PaGlobal_EnchantMain_All._naderrPage + changePage
  PaGlobal_EnchantMain_All:updateNaderrBand()
end
function PaGlobal_EnchantMain_All:hoverNaderrSlot(isHover, index)
  self._ui.list_naderrSlot[index].txt_total:SetShow(isHover == false)
  self._ui.list_naderrSlot[index].txt_base:SetShow(isHover == true)
  self._ui.list_naderrSlot[index].txt_valks:SetShow(isHover == true)
end
function PaGlobal_EnchantMain_All:handleOtherPanels()
  if ToClient_IsCurrentEnchantTargetSetted() == false then
    PaGlobalFunc_EnchantEquip_All_Open()
    PaGlobalFunc_EnchantMaterial_All_Close()
    PaGlobalFunc_EnchantProtector_All_Close()
    PaGlobalFunc_OtherUser_TriedStack_Close()
  else
    PaGlobalFunc_EnchantEquip_All_Close()
    if self._isConsole == false then
      local showOtherUserEnchantAdditionalRate = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate)
      if showOtherUserEnchantAdditionalRate == true then
        if ToClient_IsCurrentMaterialCaphras() == false then
          ToClient_RequestOthersChoice()
        end
      else
        PaGlobal_EnchantMain_All._ui.btn_othersChoice:EraseAllEffect()
        PaGlobal_EnchantMain_All._ui.btn_othersChoice:AddEffect("FUI_StackUserInfo_Button_01B", true, 0, 0)
      end
    end
  end
end
function PaGlobal_EnchantMain_All:startEnchant()
  self:resetAnimation()
  self._enchantAnim = self._ENCHANT_ANIM.START
  local enchantRandomNum = math.random(1, 3)
  if ToClient_IsCurrentProtectorSetted() == true then
    if ToClient_IsSafeLowProtectorSetted() == true then
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_Cron_01A", true, 0, 0)
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01B", true, 0, 0)
      self:startAudio(self._AUDIO.ENCHANT_CRON_START)
      self._animTime = 5.5
    elseif enchantRandomNum == 1 then
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_Cron_01A", true, 0, 0)
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01A", true, 0, 0)
      self:startAudio(self._AUDIO.ENCHANT_START)
      self._animTime = 5.5
    elseif enchantRandomNum == 2 then
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_Cron_01A_2S", true, 0, 0)
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01A_2S", true, 0, 0)
      self:startAudio(self._AUDIO.ENCHANT_START_2S)
      self._animTime = 4.5
    elseif enchantRandomNum == 3 then
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_Cron_01A_3S", true, 0, 0)
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01A_3S", true, 0, 0)
      self:startAudio(self._AUDIO.ENCHANT_START_3S)
      self._animTime = 6.5
    end
  elseif enchantRandomNum == 1 then
    self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01A", true, 0, 0)
    self:startAudio(self._AUDIO.ENCHANT_START)
    self._animTime = 5.5
  elseif enchantRandomNum == 2 then
    self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01A_2S", true, 0, 0)
    self:startAudio(self._AUDIO.ENCHANT_START_2S)
    self._animTime = 4.5
  elseif enchantRandomNum == 3 then
    self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_01A_3S", true, 0, 0)
    self:startAudio(self._AUDIO.ENCHANT_START_3S)
    self._animTime = 6.5
  end
  self._ui.txt_enchantSuccess:SetShow(false)
  self._ui.txt_enchantFail:SetShow(false)
  self:updateFunctionButtons()
  self:updateBottomAreaButtons()
  self:updateGroupEnchant()
  ToClient_BlackspiritEnchantStart()
  ToClient_RequestEnchantRecord(__eEnchantRecord_StartAnimation)
end
function PaGlobal_EnchantMain_All:requestEnchant()
  self:resetAnimation()
  local isSuccess = ToClient_RequestEnchant()
  if isSuccess == false then
    self:update()
    ToClient_BlackspiritEnchantCancel()
  end
end
function PaGlobal_EnchantMain_All:responseEnchant(enchantResponseType, param0, param1)
  if enchantResponseType == __eEnchantResponseType_Enchant then
    if param0 == self._ENCHANT_RESULT.SUCCESS then
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_Success_01A", true, 0, 0)
      self:startAudio(self._AUDIO.ENCHANT_SUCCESS)
      self._ui.txt_enchantSuccess:SetShow(true)
      self._ui.txt_enchantFail:SetShow(false)
      self._nakSpan = self._maxNakSpan
    else
      if param1 ~= 0 then
        self._ui.stc_agrisEffect:AddEffect("fUI_SpiritEnchant_New_Hammer_02A", true, 0, 0)
      end
      self:startAudio(self._AUDIO.ENCHANT_FAIL)
      self._ui.stc_effect:AddEffect("fUI_SpiritEnchant_New_Fail_01A", true, 0, 0)
      self._ui.txt_enchantFail:SetShow(true)
      self._ui.txt_enchantSuccess:SetShow(false)
      self._nakSpan = self._maxNakSpan
    end
  elseif enchantResponseType == __eEnchantResponseType_Caphras then
    self:showNakMessage(self._NAK_TYPE.CAPHRAS, param0)
    self:startAudio(self._AUDIO.ENCHANT_SUCCESS)
  elseif enchantResponseType == __eEnchantResponseType_AddStack then
    if param0 == false then
      self:startAudio(self._AUDIO.ITEM_TO_STACK_FAIL)
    else
      self:startAudio(self._AUDIO.ITEM_TO_STACK)
    end
    self:showNakMessage(self._NAK_TYPE.ADD_STACK, param0)
    PaGlobalFunc_EnchantStack_Update(false)
  elseif enchantResponseType == __eEnchantResponseType_Extraction then
    self:startAudio(self._AUDIO.STACK_TO_ITEM)
    self:showNakMessage(self._NAK_TYPE.EXTRACTION)
  end
end
function PaGlobal_EnchantMain_All:cancelAnimation()
  if self._enchantAnim == self._ENCHANT_ANIM.START then
    ToClient_RequestEnchantRecord(__eEnchantRecord_EnchantCancel)
  end
  if PaGlobal_EnchantMain_All:isAnimating() == true then
    self:startAudio(self._AUDIO.CANCEL)
    ToClient_BlackspiritEnchantCancel()
  end
  self:resetAnimation()
end
function PaGlobal_EnchantMain_All:resetAnimation()
  self._enchantAnim = self._ENCHANT_ANIM.NONE
  self._animTime = 10
  self._ui.stc_agrisEffect:EraseAllEffect()
  self._ui.stc_effect:EraseAllEffect()
  self._ui.stc_caphrasEffect:EraseAllEffect()
  self:updateBottomAreaButtons()
end
function PaGlobal_EnchantMain_All:toggleCaphrasArea(isCaphrasScreen)
  if nil == Panel_Widget_Enchant_Main_All then
    return
  end
  local isScreenChanged = self._ui.stc_effectArea:GetShow() ~= (isCaphrasScreen == false)
  if isScreenChanged == true then
    self._ui.btn_skipAnimation:SetCheck(false)
    self:resetAnimation()
  end
  self._ui.stc_effectArea:SetShow(isCaphrasScreen == false)
  self._ui.stc_caphrasArea:SetShow(isCaphrasScreen == true)
end
function PaGlobal_EnchantMain_All:pressStartButton(isProtectorEnchant)
  if isProtectorEnchant == true then
    if self._ui.btn_cronEnchantStart:IsIgnore() == true then
      return
    end
  elseif self._ui.btn_enchantStart:IsIgnore() == true then
    return
  end
  local isImmediateClose = PaGlobalFunc_EnchantStack_All_Close()
  if isImmediateClose == false then
    return
  end
  local isCaphrasScreen = ToClient_IsCurrentMaterialCaphras()
  local isAnimating = PaGlobal_EnchantMain_All:isAnimating()
  ToClient_SetProtectorEnchant(isProtectorEnchant)
  PaGlobalFunc_EnchantMaterial_All_Close()
  PaGlobalFunc_EnchantProtector_All_Close()
  if isAnimating == true then
    self:cancelAnimation()
  elseif isCaphrasScreen == true then
    self:handleCaphrasStartButton()
  else
    if isProtectorEnchant == true and ToClient_GetEnchantButtonType(true, false) == __eEnchantButtonType_ProtectorList then
      HandleEventLUp_EnchantMain_ProtectorSelect()
      return
    end
    self:handleEnchantStartButton()
  end
end
function PaGlobal_EnchantMain_All:handleEnchantStartButton()
  PaGlobal_EnchantMain_All:checkStackTooHigh()
end
function PaGlobal_EnchantMain_All:checkStackTooHigh()
  if ToClient_IsStackTooHigh() == true then
    PaGlobalFunc_EnchantStackConfirm_All_Open(false)
    return
  end
  self:checkIsDuelItem()
end
function PaGlobal_EnchantMain_All:checkIsDuelItem()
  local function checkFunction()
    self:checkIsStackTooLow()
  end
  local enchantTargetItemWrapper = ToClient_GetCurrentEnchantTarget()
  if enchantTargetItemWrapper == nil then
    return
  end
  if enchantTargetItemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem) == true then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_COPYITEM_MESSAGEDESC"),
      functionApply = checkFunction,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, nil, false, self._isConsole == true)
    return
  end
  checkFunction()
end
function PaGlobal_EnchantMain_All:checkIsStackTooLow()
  local function checkFunction()
    self:checkIsCaphrasStacked()
  end
  if ToClient_IsStackTooLow() == true then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGEDESC"),
      functionApply = checkFunction,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, nil, false, self._isConsole == true)
    return
  end
  checkFunction()
end
function PaGlobal_EnchantMain_All:checkIsCaphrasStacked()
  local function checkFunction()
    self:handleEnchantStart()
  end
  if ToClient_IsCaphrasStacked() == true then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_CRON_ENERGY_WARNING_DESC_CAPHRAS"),
      functionApply = checkFunction,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData, nil, false, self._isConsole == true)
    return
  end
  checkFunction()
end
function PaGlobal_EnchantMain_All:handleEnchantStart()
  if self._ui.btn_skipAnimation:IsCheck() == true then
    self:requestEnchant()
    return
  end
  self:startEnchant()
end
function PaGlobal_EnchantMain_All:handleCaphrasStartButton()
  local function caphrasConfirm()
    if self._ui.btn_skipAnimation:IsCheck() == true then
      self:resetAnimation()
      self:requestCaphrasEnchant()
      return
    end
    self:startCaphrasEnchant()
  end
  if ToClient_IsTargetCaphrasPromotable() == true then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_MESSAGETITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PROMOTE_WARNING_CAPHRAS"),
      functionYes = caphrasConfirm,
      functionNo = MessageBox_Empty_function
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  caphrasConfirm()
end
function PaGlobal_EnchantMain_All:startCaphrasEnchant()
  self:resetAnimation()
  self._ui.stc_caphrasEffect:AddEffect("fUI_CaphrasEnchant_New_01A", true, 0, 0)
  self:startAudio(self._AUDIO.CAPHRAS)
  self._enchantAnim = self._ENCHANT_ANIM.CAPHRAS_START
  self._animTime = 5.5
  self._ui.btn_enchantStart:SetMonoTone(true)
  self._ui.btn_enchantStart:SetIgnore(true)
  self:updateBottomAreaButtons()
  ToClient_BlackspiritEnchantStart()
end
function PaGlobal_EnchantMain_All:requestCaphrasEnchant()
  local doCaphrasEnchant = function()
    ToClient_RequestCaphrasEnchant()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_OBJECTCONTROL_CONFIRM"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_CAPHRAS_OVER_10TH"),
    functionYes = doCaphrasEnchant,
    functionNo = MessageBox_Empty_function
  }
  if ToClient_GetCurrentCaphrasLevel() == 10 then
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  doCaphrasEnchant()
end
function PaGlobal_EnchantMain_All:isAnimating()
  return self._enchantAnim ~= self._ENCHANT_ANIM.NONE
end
function PaGlobal_EnchantMain_All:getNoticeText()
  if ToClient_IsCurrentEnchantTargetSetted() == false then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_CHOOSE_EQUIPMENT")
  end
  if ToClient_IsCurrentMaterialCaphras() == true then
    return ""
  end
  if ToClient_IsCurrentEnchantTargetChangableToTuvala() == true then
    return ""
  end
  if ToClient_IsGuaranteeEnchant() == true then
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT")
  end
  if ToClient_IsNewPerfectEnchantSetted() == true then
    local noticeText = ""
    local endurancePenalty = ToClient_GetNewPerfectEnchantEndurancePenalty()
    if endurancePenalty > 0 then
      noticeText = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT_PENALTY", "maxEndurance", tostring(endurancePenalty), "currentEndurance", tostring(ToClient_GetTargetMaxEndurance()))
    else
      noticeText = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT")
    end
    return noticeText
  end
  if ToClient_IsPerfectEnchantSetted() == true then
    local enchantMaterial = ToClient_GetCurrentEnchantMaterial()
    local noticeText = ""
    if enchantMaterial ~= nil then
      noticeText = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT") .. "\n" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_PERFECTE_PANALTY", "ItemName", tostring(enchantMaterial:getStaticStatus():getName()), "count", tostring(ToClient_GetEnchantMaterialNeedItemCount()), "endurance", tostring(ToClient_GetPerfectEnchantEndurancePenalty())) .. " " .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SPIRITENCHANT_ALL_RESULT_ENDURANCE", "curEndurance", ToClient_GetTargetMaxEndurance())
    end
    return noticeText
  end
  local noticeText = self:getEnduranceDecreaseText() .. "\n"
  if ToClient_IsCurrentProtectorSetted() == true then
    if ToClient_IsProtectorSettedExceptCronStone() == true then
      noticeText = noticeText .. self:getProtectorExceptCronStoneText() .. "\n"
    else
      noticeText = noticeText .. self:getCronStoneText() .. "\n"
    end
    noticeText = string.sub(noticeText, 1, -2)
    return noticeText
  end
  local enchantDangerType = ToClient_GetTargetEnchantDangerType()
  if enchantDangerType == __eEnchantDangerType_DownAndBroken or enchantDangerType == __eEnchantDangerType_Broken then
    noticeText = noticeText .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_1") .. "\n"
  end
  if enchantDangerType == __eEnchantDangerType_Gradedown or enchantDangerType == __eEnchantDangerType_DownAndBroken then
    noticeText = noticeText .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_3") .. "\n"
  end
  noticeText = string.sub(noticeText, 1, -2)
  return noticeText
end
function PaGlobal_EnchantMain_All:getEnduranceDecreaseText()
  local reducedEndurance = ToClient_GetTargetReducedEnduranceWhenFail()
  local enchantDangerType = ToClient_GetTargetEnchantDangerType()
  local enchantTarget = ToClient_GetCurrentEnchantTarget()
  if enchantTarget == nil then
    return ""
  end
  local itemSSW = enchantTarget:getStaticStatus()
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and ToClient_IsDeadGodEquip(itemSSW:get()._key:getItemKey()) == false then
    return ""
  end
  if enchantDangerType == __eEnchantDangerType_Safe then
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_100PERCENT")
  end
  if ToClient_IsEnduranceEnchantSetted() == true then
    reducedEndurance = reducedEndurance - 1
  end
  return PAGetStringParam2(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_0", "maxEndurance", tostring(reducedEndurance), "currentEndurance", ToClient_GetTargetMaxEndurance())
end
function PaGlobal_EnchantMain_All:getProtectorExceptCronStoneText()
  local enchantTarget = ToClient_GetCurrentEnchantTarget()
  if enchantTarget == nil then
    return ""
  end
  local isSpecialEnchantItem = enchantTarget:getStaticStatus():isSpecialEnchantItem()
  local isAccessory = enchantTarget:getStaticStatus():getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Accessory
  local isKarazardAccessory = enchantTarget:getStaticStatus():isKarazardAccessory() == true
  local isItemSkillOption = enchantTarget:getStaticStatus():getContentsEventType() == __eContentsType_ItemSkillOption
  if true == isSpecialEnchantItem then
    isAccessory = false
  end
  if isKarazardAccessory == true then
    isAccessory = true
  end
  if ToClient_IsSafeLowProtectorSetted() == true then
    if isAccessory == true then
      return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_PENALTY_2")
    end
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_STONE_PENALTY_1")
  end
  if isAccessory == true then
    if isKarazardAccessory == true then
      return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_5")
    end
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY3")
  end
  if isItemSkillOption == true then
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_4")
  end
  local protectorItemSSW = ToClient_GetCurrentProtectorForLua()
  if protectorItemSSW == nil then
    return ""
  end
  local protectorItemKey = protectorItemSSW:get()._key:getItemKey()
  if protectorItemKey == 761801 then
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_6")
  end
  if protectorItemKey == 761802 then
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_7")
  end
  if protectorItemKey == 761803 then
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY_8")
  end
  return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_HAMMER_PENALTY")
end
function PaGlobal_EnchantMain_All:getCronStoneText()
  local enchantTarget = ToClient_GetCurrentEnchantTarget()
  if enchantTarget == nil then
    return ""
  end
  local enchantDangerType = ToClient_GetTargetEnchantDangerType()
  local isAccessory = enchantTarget:getStaticStatus():getItemClassify() == CppEnums.ItemClassifyType.eItemClassify_Accessory
  if enchantDangerType == __eEnchantDangerType_Broken or enchantDangerType == __eEnchantDangerType_DownAndBroken then
    if isAccessory == true then
      return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
    end
    return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_3") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
  end
  return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_5") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_PENALTY_4")
end
function PaGlobal_EnchantMain_All:checkNaderrCooltime(deltaTime)
  if self._ui.stc_naderrBand:GetShow() == false then
    return
  end
  self._naderrCooltimeDeltaTime = self._naderrCooltimeDeltaTime + deltaTime
  if self._naderrCooltimeDeltaTime < 1 then
    return
  end
  self._naderrCooltimeDeltaTime = 0
  local coolTime = ToClient_GetRemainSwapEnchantStackSlotCoolTime()
  if coolTime <= toInt64(0, 0) then
    self._ui.txt_naderrCooltime:SetShow(false)
    return
  end
  local expirationTimeString = convertStringFromDatetimeType2(coolTime)
  self._ui.txt_naderrCooltime:SetShow(true)
  self._ui.txt_naderrCooltime:SetText(expirationTimeString)
end
function PaGlobal_EnchantMain_All:checkAnimation(deltaTime)
  if self._enchantAnim == self._ENCHANT_ANIM.NONE then
    return
  end
  self._animTime = self._animTime - deltaTime
  if self._enchantAnim == self._ENCHANT_ANIM.START and self._animTime < 0 then
    self:resetAnimation()
    self:requestEnchant()
  end
  if self._enchantAnim == self._ENCHANT_ANIM.CAPHRAS_START and self._animTime < 0 then
    self:resetAnimation()
    self:requestCaphrasEnchant()
  end
end
function PaGlobal_EnchantMain_All:showNakMessage(nakType, param0)
  self._nakSpan = self._maxNakSpan
  local message = ""
  if nakType == self._NAK_TYPE.CAPHRAS then
    message = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_NEWENCHANT_RESULT_5_CAPHRAS", "count", tostring(param0))
  elseif nakType == self._NAK_TYPE.ADD_STACK then
    if param0 == false then
      message = PAGetString(Defines.StringSheet_GAME, "LUA_EATENCHANT_STACK_FAIL")
    else
      message = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_6")
    end
  elseif nakType == self._NAK_TYPE.EXTRACTION then
    message = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANTCOUNTEXTRACTION_5")
  end
  PaGlobalFunc_EnchantMessage_All_ShowNakMessage(message)
end
function PaGlobal_EnchantMain_All:checkNakMessage(deltaTime)
  if self._nakSpan == 0 then
    return
  end
  self._nakSpan = self._nakSpan - deltaTime
  if self._nakSpan <= 0 then
    self._nakSpan = 0
    PaGlobalFunc_EnchantMessage_All_Close()
    self._ui.txt_enchantSuccess:SetShow(false)
    self._ui.txt_enchantFail:SetShow(false)
  end
end
function PaGlobal_EnchantMain_All:startGroupEnchantRemasterAni()
  self:startEnchant()
  PaGlobalFunc_PartyEnchant_StartEffect()
end
function PaGlobal_EnchantMain_All:handleTooltip(tooltipType, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = ""
  local desc = ""
  if tooltipType == self._TOOLTIP_TYPE.PERFECT_ENCHANT then
    control = self._ui.btn_perfectEnchant
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTDESC")
  elseif tooltipType == self._TOOLTIP_TYPE.PERFECT_ENCHANT_RADIO then
    control = self._ui.radioBtn_perfect
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTDESC")
  elseif tooltipType == self._TOOLTIP_TYPE.NORMAL_ENCHANT then
    control = self._ui.radioBtn_normal
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_PRIORITY_ENCHANT")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_DRASTICENCHANT_DESC")
  elseif tooltipType == self._TOOLTIP_TYPE.ENDURANCE_ENCHANT then
    control = self._ui.radioBtn_endurance
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_PRIORITY_ENDURANCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_METICULOUSENCHANT_DESC")
  elseif tooltipType == self._TOOLTIP_TYPE.EXTRACTION_STACK then
    control = self._ui.btn_extraction
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_TOOLTIP_STACKEXTRACTION_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_TOOLTIP_STACKEXTRACTION_DESC")
  elseif tooltipType == self._TOOLTIP_TYPE.ENCHANT_PROBABILTY then
    control = self._ui.txt_currentStack
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_TOOLTIP_DARK_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_TOOLTIP_DARK_DESC")
  elseif tooltipType == self._TOOLTIP_TYPE.ENCHANT_PROBABILTY2 then
    control = self._ui.btn_stack
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_TOOLTIP_DARK_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_TOOLTIP_DARK_DESC")
  elseif tooltipType == self._TOOLTIP_TYPE.ENCHANT_VALCKSCRY then
    control = self._ui.txt_currentValksCry
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_TOOLTIP_PROBABILITY_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_TOOLTIP_PROBABILITY_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
function PaGlobal_EnchantMain_All:checkAndOpenMaterialList()
  local materialListSize = ToClient_GetEnchantMaterialListSize()
  if ToClient_IsCurrentEnchantMaterialSetted() == true then
    materialListSize = materialListSize - 1
  end
  if materialListSize > 0 then
    PaGlobalFunc_EnchantMaterial_All_Open()
  end
end
function PaGlobal_EnchantMain_All:toggleSkipAnimation(isLsClick)
  if PaGlobal_EnchantMain_All_IsAnimating() == true then
    self._ui.btn_skipAnimation:SetCheck(false)
    return
  end
  if self._isConsole == true and isLsClick == true then
    self._ui.btn_skipAnimation:SetCheck(not self._ui.btn_skipAnimation:IsCheck())
  end
end
function PaGlobal_EnchantMain_All:startAudio(audioIndex)
  if audioIndex[1] == nil or audioIndex[2] == nil then
    return
  end
  audioPostEvent_SystemUi(audioIndex[1], audioIndex[2])
  _AudioPostEvent_SystemUiForXBOX(audioIndex[1], audioIndex[2])
end
function PaGlobal_EnchantMain_All:updateEnchantTargetEffect()
  self._slotTarget.icon:EraseAllEffect()
  local itemWrapper = ToClient_GetCurrentEnchantTarget()
  if itemWrapper == nil then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
  if itemSSW:isSpecialEnchantItem() == true and 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and (itemSSW:isSpecialEnchantItem() == false or itemSSW:isSpecialAccessory() == true) then
    if enchantLevel ~= nil then
      if 1 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_01A", true, 0, 0)
      elseif 2 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_02A", true, 0, 0)
      elseif 3 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_03A", true, 0, 0)
      elseif 4 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_04A", true, 0, 0)
      elseif 5 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_05A", true, 0, 0)
      elseif 6 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_06A", true, 0, 0)
      elseif 7 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_07A", true, 0, 0)
      elseif 8 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_08A", true, 0, 0)
      elseif 9 == enchantLevel then
        self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_09A", true, 0, 0)
      end
    else
      self._slotTarget.icon:AddEffect("UI_Button_Hide", false, 0, 0)
    end
  elseif nil ~= enchantLevel then
    if 15 == enchantLevel then
      self._slotTarget.icon:AddEffect("", true, 0, 0)
    elseif 16 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_01A", true, 0, 0)
    elseif 17 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_02A", true, 0, 0)
    elseif 18 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_03A", true, 0, 0)
    elseif 19 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_04A", true, 0, 0)
    elseif 20 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_05A", true, 0, 0)
    elseif 21 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_06A", true, 0, 0)
    elseif 22 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_07A", true, 0, 0)
    elseif 23 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_08A", true, 0, 0)
    elseif 24 == enchantLevel then
      self._slotTarget.icon:AddEffect("fUI_SpiritEnchant_Equip_09A", true, 0, 0)
    end
  else
    self._slotTarget.icon:AddEffect("UI_Button_Hide", false, 0, 0)
  end
end
