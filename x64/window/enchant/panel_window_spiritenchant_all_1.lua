function PaGlobal_SpiritEnchant_All:initialize()
  if true == PaGlobal_SpiritEnchant_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlAll_Init()
  self:controlEnchant_Init()
  if true == _ContentsGroup_EnchantRenewer and nil ~= Panel_Window_AddStack_All then
    self:controlEnchantNew_Init()
  end
  self:controlLightStone_Init()
  self:controlExtraction_Init()
  self:controlPc_Init()
  self:controlConsole_Init()
  self:controlSetShow()
  self:resize()
  self._tooltipSpanX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
  if true == _ContentsGroup_EatEnchant then
    self._currentSubTab = PaGlobal_SpiritEnchant_All._SUB_TAB.DARK
  elseif true == _ContentsGroup_isSecretExtract then
    self._currentSubTab = PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK
  end
  PaGlobal_SpiritEnchant_All:registEventHandler()
  PaGlobal_SpiritEnchant_All:validate()
  PaGlobal_SpiritEnchant_All._initialize = true
end
function PaGlobal_SpiritEnchant_All:controlAll_Init()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_StackExtraction_All, "Static_TitleArea")
  self._ui.txt_titleBg = UI.getChildControl(self._ui.stc_titleBg, "StaticText_TitleIcon")
  self._ui.stc_mainTabBg = UI.getChildControl(Panel_Window_StackExtraction_All, "Static_MainTabTypeBg")
  self._ui.btn_mainRadio = {
    [1] = UI.getChildControl(self._ui.stc_mainTabBg, "Radiobutton_Enchant"),
    [2] = UI.getChildControl(self._ui.stc_mainTabBg, "Radiobutton_Caphras"),
    [3] = UI.getChildControl(self._ui.stc_mainTabBg, "Radiobutton_Extraction")
  }
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_mainTabBg, "Static_SelectBar")
  self._ui.stc_line = UI.getChildControl(self._ui.stc_mainTabBg, "Static_Line")
end
function PaGlobal_SpiritEnchant_All:controlEnchant_Init()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_enchant.stc_enchantBg = UI.getChildControl(Panel_Window_StackExtraction_All, "Static_EnchantTab")
  self._ui_enchant.stc_imageArea = UI.getChildControl(self._ui_enchant.stc_enchantBg, "Static_ImageArea")
  self._ui_enchant.stc_infoArea = UI.getChildControl(self._ui_enchant.stc_enchantBg, "Static_EnchantInfoArea")
  self._ui_enchant.stc_resultNak = UI.getChildControl(Panel_Window_StackExtraction_All, "StaticText_NakMessage")
  self._ui_enchant.stc_noticeBar = UI.getChildControl(self._ui_enchant.stc_imageArea, "StaticText_NoticeBar")
  self._ui_enchant.stc_image = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_Image")
  self._ui_enchant.stc_wingCenter = UI.getChildControl(self._ui_enchant.stc_image, "Static_MiddleWing")
  self._ui_enchant.stc_wingTop = UI.getChildControl(self._ui_enchant.stc_image, "Static_TopWing")
  self._ui_enchant.stc_wingBottom = UI.getChildControl(self._ui_enchant.stc_image, "Static_BottomWing")
  self._ui_enchant.stc_wingsInfo = {
    [1] = {
      slot = UI.getChildControl(self._ui_enchant.stc_wingCenter, "Static_Slot"),
      count = UI.getChildControl(self._ui_enchant.stc_wingCenter, "StaticText_Count")
    },
    [2] = {
      slot = UI.getChildControl(self._ui_enchant.stc_wingTop, "Static_Slot"),
      count = UI.getChildControl(self._ui_enchant.stc_wingTop, "StaticText_Count")
    },
    [3] = {
      slot = UI.getChildControl(self._ui_enchant.stc_wingBottom, "Static_Slot"),
      count = UI.getChildControl(self._ui_enchant.stc_wingBottom, "StaticText_Count")
    }
  }
  self._ui_enchant.stc_equipSlot = UI.getChildControl(self._ui_enchant.stc_image, "Static_EquipSlot")
  self._originEnchnatNoticeBgSizeY = self._ui_enchant.stc_noticeBar:GetSizeY()
  self._originEnchnatNoticeBgPosY = self._ui_enchant.stc_noticeBar:GetPosY()
  local slotEquip = {}
  SlotItem.new(slotEquip, "EnchantAll_Slot_0", 0, self._ui_enchant.stc_equipSlot, self._slotConfig)
  slotEquip:createChild()
  slotEquip.empty = true
  slotEquip:clearItem()
  slotEquip.border:SetSize(44, 44)
  slotEquip.border:SetPosX(0)
  slotEquip.border:SetPosY(0)
  self._slotEquip.slot = slotEquip
  Panel_Tooltip_Item_SetPosition(0, slotEquip, "Enchant")
  self._slotMateiralInfo = {}
  local slotMaterialCenter = {}
  SlotItem.new(slotMaterialCenter, "EnchantAll_Slot_1", 0, self._ui_enchant.stc_wingsInfo[1].slot, self._slotConfig_count)
  slotMaterialCenter:createChild()
  slotMaterialCenter.empty = true
  slotMaterialCenter:clearItem()
  slotMaterialCenter.border:SetSize(44, 44)
  slotMaterialCenter.border:SetPosX(0)
  slotMaterialCenter.border:SetPosY(0)
  self._slotMateiralInfo[1] = slotMaterialCenter
  Panel_Tooltip_Item_SetPosition(1, slotMaterialCenter, "Enchant")
  local slotMaterialTop = {}
  SlotItem.new(slotMaterialTop, "EnchantAll_Slot_2", 0, self._ui_enchant.stc_wingsInfo[2].slot, self._slotConfig_count)
  slotMaterialTop:createChild()
  slotMaterialTop.empty = true
  slotMaterialTop:clearItem()
  slotMaterialTop.border:SetSize(44, 44)
  slotMaterialTop.border:SetPosX(0)
  slotMaterialTop.border:SetPosY(0)
  self._slotMateiralInfo[2] = slotMaterialTop
  Panel_Tooltip_Item_SetPosition(2, slotMaterialTop, "Enchant")
  local slotMaterialBottom = {}
  SlotItem.new(slotMaterialBottom, "EnchantAll_Slot_3", 0, self._ui_enchant.stc_wingsInfo[3].slot, self._slotConfig_count)
  slotMaterialBottom:createChild()
  slotMaterialBottom.empty = true
  slotMaterialBottom:clearItem()
  slotMaterialBottom.border:SetSize(44, 44)
  slotMaterialBottom.border:SetPosX(0)
  slotMaterialBottom.border:SetPosY(0)
  self._slotMateiralInfo[3] = slotMaterialBottom
  Panel_Tooltip_Item_SetPosition(3, slotMaterialBottom, "Enchant")
  self._ui_enchant.stc_image2 = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_Image2")
  self._ui_enchant.stc_caphrasImage = UI.getChildControl(self._ui_enchant.stc_image2, "Static_CaphrasImage")
  self._ui_enchant.stc_caphrasEquipSlot = UI.getChildControl(self._ui_enchant.stc_caphrasImage, "Static_EquipSlot")
  self._ui_enchant.stc_caphrasCurEquipSlot = UI.getChildControl(self._ui_enchant.stc_caphrasImage, "Static_CurrentEquipSlot")
  self._ui_enchant.stc_caphrasSlot = UI.getChildControl(self._ui_enchant.stc_caphrasImage, "Static_CaphrasSlot")
  self._ui_enchant.txt_caphrasCount = UI.getChildControl(self._ui_enchant.stc_caphrasImage, "StaticText_CaphrasCount")
  self._ui_enchant.progress_caphrasNextExp = UI.getChildControl(self._ui_enchant.stc_image2, "Progress2_NextExp")
  self._ui_enchant.progress_caphrasCurExp = UI.getChildControl(self._ui_enchant.stc_image2, "Progress2_CurrentExp")
  self._ui_enchant.stc_caphrasRightLine = UI.getChildControl(self._ui_enchant.stc_image2, "Static_RightLine")
  self._ui_enchant.stc_caphrasLeftLine = UI.getChildControl(self._ui_enchant.stc_image2, "Static_LeftLine")
  self._ui_enchant.stc_caphrasLeftWing = UI.getChildControl(self._ui_enchant.stc_image2, "Static_LeftInfoWing")
  self._ui_enchant.txt_caphrasNextStep = UI.getChildControl(self._ui_enchant.stc_caphrasLeftWing, "StaticText_NextStep")
  self._ui_enchant.txt_caphrasNextMaterialInfo = UI.getChildControl(self._ui_enchant.stc_caphrasLeftWing, "StaticText_NeedMaterialInfo")
  self._ui_enchant.txt_caphrasNextMaterialInfo:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.txt_caphrasStatusTitleL = {}
  self._ui_enchant.txt_caphrasStatusValueL = {}
  self._ui_enchant.txt_caphrasStatusTitleL[1] = UI.getChildControl(self._ui_enchant.stc_caphrasLeftWing, "StaticText_StatusTitle1")
  self._ui_enchant.txt_caphrasStatusValueL[1] = UI.getChildControl(self._ui_enchant.stc_caphrasLeftWing, "StaticText_StatusValue1")
  for idx = 2, self._caphrasStatsMaxCount do
    self._ui_enchant.txt_caphrasStatusTitleL[idx] = UI.createAndCopyBasePropertyControl(self._ui_enchant.stc_caphrasLeftWing, "StaticText_StatusTitle1", self._ui_enchant.stc_caphrasLeftWing, "StaticText_StatusTitle" .. idx)
    self._ui_enchant.txt_caphrasStatusValueL[idx] = UI.createAndCopyBasePropertyControl(self._ui_enchant.stc_caphrasLeftWing, "StaticText_StatusValue1", self._ui_enchant.stc_caphrasLeftWing, "StaticText_StatusValue" .. idx)
  end
  self._ui_enchant.stc_caphrasRightWing = UI.getChildControl(self._ui_enchant.stc_image2, "Static_RightInfoWing")
  self._ui_enchant.txt_caphrasCurStep = UI.getChildControl(self._ui_enchant.stc_caphrasRightWing, "StaticText_CurrentStep")
  self._ui_enchant.txt_caphrasEffect = UI.getChildControl(self._ui_enchant.stc_caphrasRightWing, "StaticText_CaphrasEffect")
  self._ui_enchant.txt_caphrasStatusTitleR = {}
  self._ui_enchant.txt_caphrasStatusValueR = {}
  self._ui_enchant.txt_caphrasStatusTitleR[1] = UI.getChildControl(self._ui_enchant.stc_caphrasRightWing, "StaticText_StatusTitle1")
  self._ui_enchant.txt_caphrasStatusValueR[1] = UI.getChildControl(self._ui_enchant.stc_caphrasRightWing, "StaticText_StatusValue1")
  for idx = 2, self._caphrasStatsMaxCount do
    self._ui_enchant.txt_caphrasStatusTitleR[idx] = UI.createAndCopyBasePropertyControl(self._ui_enchant.stc_caphrasRightWing, "StaticText_StatusTitle1", self._ui_enchant.stc_caphrasRightWing, "StaticText_StatusTitle" .. idx)
    self._ui_enchant.txt_caphrasStatusValueR[idx] = UI.createAndCopyBasePropertyControl(self._ui_enchant.stc_caphrasRightWing, "StaticText_StatusValue1", self._ui_enchant.stc_caphrasRightWing, "StaticText_StatusValue" .. idx)
  end
  local slotResult_Caphras = {}
  SlotItem.new(slotResult_Caphras, "EnchantAll_CaphrasSlot_0", 0, self._ui_enchant.stc_caphrasEquipSlot, self._slotConfig)
  slotResult_Caphras:createChild()
  slotResult_Caphras.empty = true
  slotResult_Caphras:clearItem()
  slotResult_Caphras.border:SetSize(44, 44)
  slotResult_Caphras.border:SetPosX(0)
  slotResult_Caphras.border:SetPosY(0)
  self._slotResult_Caphras = slotResult_Caphras
  Panel_Tooltip_Item_SetPosition(4, slotResult_Caphras, "Enchant")
  local slotEquip_Caphras = {}
  SlotItem.new(slotEquip_Caphras, "EnchantAll_CaphrasSlot_1", 0, self._ui_enchant.stc_caphrasCurEquipSlot, self._slotConfig)
  slotEquip_Caphras:createChild()
  slotEquip_Caphras.empty = true
  slotEquip_Caphras:clearItem()
  slotEquip_Caphras.border:SetSize(44, 44)
  slotEquip_Caphras.border:SetPosX(0)
  slotEquip_Caphras.border:SetPosY(0)
  self._slotEquip_Caphras = slotEquip_Caphras
  Panel_Tooltip_Item_SetPosition(5, slotEquip_Caphras, "Enchant")
  local slotMaterial_Caphras = {}
  SlotItem.new(slotMaterial_Caphras, "EnchantAll_CaphrasSlot_2", 0, self._ui_enchant.stc_caphrasSlot, self._slotConfig_caphras)
  slotMaterial_Caphras:createChild()
  slotMaterial_Caphras.empty = true
  slotMaterial_Caphras:clearItem()
  self._slotMaterial_Caphras = slotMaterial_Caphras
  Panel_Tooltip_Item_SetPosition(6, slotMaterial_Caphras, "Enchant")
  self._ui_enchant.stc_bg = UI.getChildControl(self._ui_enchant.stc_infoArea, "Static_BG")
  self._ui_enchant.txt_subTitle = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_SubTItle")
  self._ui_enchant.txt_subTitleValue = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_CurrentValue")
  self._ui_enchant.txt_valks = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_Valks")
  self._ui_enchant.txt_valksValue = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_ValksValue")
  self._ui_enchant.txt_plus = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_PlusRate")
  self._ui_enchant.txt_plusValue = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_PlusRateValue")
  self._ui_enchant.btn_Add = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_Add")
  self._ui_enchant.stc_line = UI.getChildControl(self._ui_enchant.stc_infoArea, "Static_Line")
  self._ui_enchant.stc_stackChangeEffect = UI.getChildControl(self._ui_enchant.stc_infoArea, "Static_StackStorageEffect")
  self._ui_enchant.stc_buttonArea = UI.getChildControl(self._ui_enchant.stc_infoArea, "Static_ButtonArea")
  self._ui_enchant.radio_enchantNormal = UI.getChildControl(self._ui_enchant.stc_buttonArea, "RadioButton_NormalEnchant")
  self._ui_enchant.radio_enchantPerfect = UI.getChildControl(self._ui_enchant.stc_buttonArea, "RadioButton_PerfectEnchant")
  self._ui_enchant.chk_enchantForce = UI.getChildControl(self._ui_enchant.stc_buttonArea, "CheckButton_ForceEnchant")
  self._ui_enchant.chk_enchantCron = UI.getChildControl(self._ui_enchant.stc_buttonArea, "CheckButton_UseCron")
  self._ui_enchant.chk_enchantDefenceFail = UI.getChildControl(self._ui_enchant.stc_buttonArea, "CheckButton_UseDefenceFail")
  self._ui_enchant.btn_stackChange = UI.getChildControl(self._ui_enchant.stc_buttonArea, "Button_StackChange")
  self._ui_enchant.txt_stackCoolTime = UI.getChildControl(self._ui_enchant.btn_stackChange, "StaticText_Cooltime")
  self._ui_enchant.txt_enchantDesc = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_EnchantKindDesc")
  self._ui_enchant.chk_skipAni = UI.getChildControl(self._ui_enchant.stc_infoArea, "CheckButton_SkipAni")
  self._ui_enchant.txt_maxEncahnt = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_SubTItle_MaxStack")
  if true == _ContentsGroup_ChinaFontColor then
    self._ui_enchant.radio_enchantPerfect:SetFontColor(Defines.Color.C_FFFF9A38)
  end
  self._ui_enchant.txt_subTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.txt_subTitle:SetText(self._ui_enchant.txt_subTitle:GetText())
  self._ui_enchant.chk_enchantCron:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.chk_enchantCron:SetText(self._ui_enchant.chk_enchantCron:GetText())
  if false == self._isContents_Enable then
    self._ui_enchant.txt_subTitleValue:SetPosX(self._ui_enchant.txt_subTitleValue:GetPosX() + self._ui_enchant.chk_enchantCron:GetSizeX())
    self._ui_enchant.txt_valksValue:SetPosX(self._ui_enchant.txt_valksValue:GetPosX() + self._ui_enchant.chk_enchantCron:GetSizeX())
    self._ui_enchant.txt_plusValue:SetPosX(self._ui_enchant.txt_plusValue:GetPosX() + self._ui_enchant.chk_enchantCron:GetSizeX())
  end
  self._ui_enchant.chk_enchantDefenceFail:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.chk_enchantDefenceFail:SetText(self._ui_enchant.chk_enchantDefenceFail:GetText())
  self._originNakSpanY = self._ui_enchant.stc_resultNak:GetSpanSize().y
  self._originPanelSizeY = Panel_Window_StackExtraction_All:GetSizeY()
  self._originEnchantInfoSizeY = self._ui_enchant.stc_infoArea:GetSizeY()
  self._originEnchantButtonAreaPosY = self._ui_enchant.chk_skipAni:GetPosY()
  if false == self._isConsole then
    self._slotEquip.slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(true)")
    self._slotEquip.slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(false)")
    self._slotMateiralInfo[1].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(true)")
    self._slotMateiralInfo[1].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(false)")
    self._slotMateiralInfo[2].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(true)")
    self._slotMateiralInfo[2].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(false)")
    self._slotMateiralInfo[3].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(true)")
    self._slotMateiralInfo[3].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(false)")
    self._slotResult_Caphras.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(true, true)")
    self._slotResult_Caphras.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(false, true)")
    self._slotEquip_Caphras.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(true, false)")
    self._slotEquip_Caphras.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(false, false)")
    self._slotMaterial_Caphras.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_CaphrasMaterialSlotTooltip(true)")
    self._slotMaterial_Caphras.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_CaphrasMaterialSlotTooltip(false)")
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    self._ui_enchant.stc_equipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(true)")
    self._ui_enchant.stc_equipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(false)")
    self._ui_enchant.stc_wingsInfo[1].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(true)")
    self._ui_enchant.stc_wingsInfo[1].slot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(false)")
    self._ui_enchant.stc_wingsInfo[2].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(true)")
    self._ui_enchant.stc_wingsInfo[2].slot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(false)")
    self._ui_enchant.stc_wingsInfo[3].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(true)")
    self._ui_enchant.stc_wingsInfo[3].slot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(false)")
    self._ui_enchant.stc_caphrasEquipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(true, true)")
    self._ui_enchant.stc_caphrasEquipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(false, true)")
    self._ui_enchant.stc_caphrasCurEquipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(true, false)")
    self._ui_enchant.stc_caphrasCurEquipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_CaphrasEquipSlotTooltip(false, false)")
    self._ui_enchant.stc_caphrasSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_CaphrasMaterialSlotTooltip(true)")
    self._ui_enchant.stc_caphrasSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_CaphrasMaterialSlotTooltip(false)")
  else
    self._ui_enchant.stc_equipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_EquipSlotTooltip()")
    self._ui_enchant.stc_wingsInfo[1].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_MaterialTooltip()")
    self._ui_enchant.stc_wingsInfo[2].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_SubMaterialTooltip()")
    self._ui_enchant.stc_wingsInfo[3].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_DefenceMaterialTooltip()")
    self._ui_enchant.stc_caphrasEquipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_CaphrasEquipSlotTooltip(true)")
    self._ui_enchant.stc_caphrasCurEquipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_CaphrasEquipSlotTooltip(false)")
    self._ui_enchant.stc_caphrasSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_CaphrasMaterialSlotTooltip()")
  end
end
function PaGlobal_SpiritEnchant_All:controlExtraction_Init()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_extraction.stc_extractionBg = UI.getChildControl(Panel_Window_StackExtraction_All, "Static_StackExtractionTab")
  self._ui_extraction.stc_subTabBg = UI.getChildControl(self._ui_extraction.stc_extractionBg, "Static_SubTabTypeBg")
  self._ui_extraction.btn_subRadio = {
    [1] = UI.getChildControl(self._ui_extraction.stc_subTabBg, "Radiobutton_StackEnchant"),
    [2] = UI.getChildControl(self._ui_extraction.stc_subTabBg, "Radiobutton_ExtsractionStack")
  }
  self._ui_extraction.stc_selectBar = UI.getChildControl(self._ui_extraction.stc_subTabBg, "Static_SelectBar")
  self._ui_extraction.stc_line = UI.getChildControl(self._ui_extraction.stc_subTabBg, "Static_Line")
  self._ui_extraction.stc_extractionAreaBg = UI.getChildControl(self._ui_extraction.stc_extractionBg, "Static_StackEnchantPart")
  self._ui_extraction.stc_imageArea = UI.getChildControl(self._ui_extraction.stc_extractionAreaBg, "Static_ImageArea")
  self._ui_extraction.stc_imageDarkPredation = UI.getChildControl(self._ui_extraction.stc_imageArea, "Static_StackEnchantImage")
  self._ui_extraction.stc_itemSlot = UI.getChildControl(self._ui_extraction.stc_imageDarkPredation, "Static_ItemSlot")
  local slot = {}
  SlotItem.new(slot, "EnchantAll_DarkSlot_0", 0, self._ui_extraction.stc_itemSlot, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.border:SetSize(44, 44)
  slot.border:SetPosX(0)
  slot.border:SetPosY(0)
  self._slotDarkItem = slot
  Panel_Tooltip_Item_SetPosition(7, slot, "Enchant")
  self._ui_extraction.txt_stackRate = UI.getChildControl(self._ui_extraction.stc_imageDarkPredation, "StaticText_StackRate")
  self._ui_extraction.stc_imageSecretBook = UI.getChildControl(self._ui_extraction.stc_imageArea, "Static_StackExtsractionImage")
  self._ui_extraction.stc_bookSlot = UI.getChildControl(self._ui_extraction.stc_imageSecretBook, "Static_StackBookSlot")
  self._ui_extraction.stc_scrollSlot = UI.getChildControl(self._ui_extraction.stc_imageSecretBook, "Static_StackScrollSlot")
  local slotBook = {}
  SlotItem.new(slotBook, "EnchantAll_BookSlot_0", 0, self._ui_extraction.stc_bookSlot, self._slotConfig)
  slotBook:createChild()
  slotBook.empty = true
  slotBook:clearItem()
  slotBook.border:SetSize(44, 44)
  slotBook.border:SetPosX(0)
  slotBook.border:SetPosY(0)
  self._slotBookItem = slotBook
  Panel_Tooltip_Item_SetPosition(8, slotBook, "Enchant")
  local slotValks = {}
  SlotItem.new(slotValks, "EnchantAll_BookSlot_1", 0, self._ui_extraction.stc_scrollSlot, self._slotConfig)
  slotValks:createChild()
  slotValks.empty = true
  slotValks:clearItem()
  slotValks.border:SetSize(44, 44)
  slotValks.border:SetPosX(0)
  slotValks.border:SetPosY(0)
  self._slotValksItem = slotValks
  Panel_Tooltip_Item_SetPosition(9, slotValks, "Enchant")
  self._ui_extraction.stc_infoArea = UI.getChildControl(self._ui_extraction.stc_extractionAreaBg, "Static_CurrentEnchantInfoArea")
  self._ui_extraction.txt_subTitle = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_SubTitle")
  self._ui_extraction.txt_valks = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_ValksTitle")
  self._ui_extraction.txt_valksValue = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_ValksValue")
  self._ui_extraction.txt_plus = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_NormalTitle")
  self._ui_extraction.txt_plusValue = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_NormalValue")
  self._ui_extraction.stc_verticalLine = UI.getChildControl(self._ui_extraction.stc_infoArea, "Static_VerticalLine")
  self._ui_extraction.txt_currentStack = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_CurrentStack")
  self._ui_extraction.stc_arrowIcon = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_RightWayArrow")
  self._ui_extraction.txt_resultStack = UI.getChildControl(self._ui_extraction.stc_infoArea, "StaticText_AfterStack")
  self._ui_extraction.stc_bottomArea = UI.getChildControl(self._ui_extraction.stc_extractionAreaBg, "Static_BottomDescArea")
  self._ui_extraction.txt_extractionDesc = UI.getChildControl(self._ui_extraction.stc_bottomArea, "StaticText_Desc")
  self._ui_extraction.chk_skipAni = UI.getChildControl(self._ui_extraction.stc_bottomArea, "CheckButton_SkipAni")
  self._originExtractionBottomBGSizeY = self._ui_extraction.stc_bottomArea:GetSizeY()
  self._originExtractionButtonAreaPosY = self._ui_extraction.chk_skipAni:GetPosY()
  self._ui_extraction.txt_valks:SetTextMode(__eTextMode_AutoWrap)
  self._ui_extraction.txt_valks:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEW_BONUS2"))
  if false == self._isConsole then
    self._slotDarkItem.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_DarkPredationTooltip(true)")
    self._slotDarkItem.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_DarkPredationTooltip(false)")
    self._slotBookItem.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(1, true)")
    self._slotBookItem.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(1, false)")
    self._slotValksItem.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(2, true)")
    self._slotValksItem.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(2, false)")
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    self._ui_extraction.stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_DarkPredationTooltip(true)")
    self._ui_extraction.stc_itemSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_DarkPredationTooltip(false)")
    self._ui_extraction.stc_bookSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(1, true)")
    self._ui_extraction.stc_bookSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(1, false)")
    self._ui_extraction.stc_scrollSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(2, true)")
    self._ui_extraction.stc_scrollSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_BookExtractionTooltip(2, false)")
  else
    self._ui_extraction.stc_itemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_DarkPredationTooltip()")
    self._ui_extraction.stc_bookSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_BookExtractionTooltip(1)")
    self._ui_extraction.stc_scrollSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_BookExtractionTooltip(2)")
  end
end
function PaGlobal_SpiritEnchant_All:controlPc_Init()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_pc.btn_enchantGo = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_EnchantGoGo")
  self._ui_pc.btn_groupEnchantGo = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_GroupEnchantGoGo")
  self._ui_pc.btn_groupEnchantGo:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_ReqGroupEnchantAniStart()")
  self._ui_pc.chk_inventoryOpen = UI.getChildControl(self._ui_enchant.stc_infoArea, "CheckButton_GroupEnchantInventoryOpen")
  self._ui_pc.chk_inventoryOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_GroupEnchantInventoryToggle()")
  self._ui_pc.btn_groupEnchantReady = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_GroupEnchantReady")
  self._ui_pc.btn_groupEnchantReady:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_ReqGroupEnchant()")
  self._ui_pc.btn_extractionGo = UI.getChildControl(self._ui_extraction.stc_bottomArea, "Button_Execution")
  self._ui_pc.btn_question = UI.getChildControl(self._ui.stc_titleBg, "Button_Question")
  self._ui_pc.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui_enchant.chk_skipAni:SetCheck(false)
  self._ui_extraction.chk_skipAni:SetCheck(false)
end
function PaGlobal_SpiritEnchant_All:controlConsole_Init()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_console.stc_mainTabLB = UI.getChildControl(self._ui.stc_mainTabBg, "Static_LB_ConsoleUI")
  self._ui_console.stc_mainTabRB = UI.getChildControl(self._ui.stc_mainTabBg, "Static_RB_ConsoleUI")
  self._ui_console.stc_enchantGoY = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_ConsoleButtonY")
  self._ui_console.stc_extractionSubTabLT = UI.getChildControl(self._ui_extraction.stc_subTabBg, "Static_LT_ConsoleUI")
  self._ui_console.stc_extractionSubTabRT = UI.getChildControl(self._ui_extraction.stc_subTabBg, "Static_RT_ConsoleUI")
  self._ui_console.stc_exractionGoY = UI.getChildControl(self._ui_extraction.stc_bottomArea, "Button_Execute_Console")
  self._ui_console.stc_keyguideBg = UI.getChildControl(Panel_Window_StackExtraction_All, "Static_ConsoleKeyGuide")
  self._ui_console.stc_cancle = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_CancelButton_C")
  self._ui_console.stc_detail = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_DetailButton_C")
  self._ui_console.stc_rstick = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_Rst_Wheel_C")
  self._ui_console.stc_select = UI.getChildControl(self._ui_console.stc_keyguideBg, "StaticText_SelectButton_C")
end
function PaGlobal_SpiritEnchant_All:controlSetShow()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_isSecretExtract then
    self._ui_extraction.btn_subRadio[self._SUB_TAB.BOOK]:SetShow(false)
    self._ui_extraction.btn_subRadio[self._SUB_TAB.DARK]:SetSpanSize(0, 0)
    self._ui_extraction.btn_subRadio[self._SUB_TAB.DARK]:ComputePos()
  end
  if false == _ContentsGroup_EatEnchant then
    self._ui_extraction.btn_subRadio[self._SUB_TAB.DARK]:SetShow(false)
    if true == self._ui_extraction.btn_subRadio[self._SUB_TAB.BOOK]:GetShow() then
      self._ui_extraction.btn_subRadio[self._SUB_TAB.BOOK]:SetSpanSize(0, 0)
      self._ui_extraction.btn_subRadio[self._SUB_TAB.BOOK]:ComputePos()
    end
  end
  self:showGuaranteeEnchantBG(false)
  if false == _ContentsGroup_FamilyStack then
    self._ui_enchant.btn_stackChange:SetShow(false)
  else
    self._ui_enchant.btn_stackChange:SetShow(true)
    local stackChangeBtnSizeX = self._ui_enchant.btn_stackChange:GetSizeX()
    if false == _ContentsGroup_EnchantRenewer then
      self._ui_enchant.chk_enchantCron:SetSpanSize(self._ui_enchant.chk_enchantCron:GetSpanSize().x + stackChangeBtnSizeX + 5, self._ui_enchant.chk_enchantCron:GetSpanSize().y)
      self._ui_enchant.chk_enchantDefenceFail:SetSpanSize(self._ui_enchant.chk_enchantDefenceFail:GetSpanSize().x + stackChangeBtnSizeX + 5, self._ui_enchant.chk_enchantDefenceFail:GetSpanSize().y)
      self._ui_enchant.txt_subTitleValue:SetSpanSize(self._ui_enchant.txt_subTitleValue:GetSpanSize().x - stackChangeBtnSizeX - 5, self._ui_enchant.txt_subTitleValue:GetSpanSize().y)
      self._ui_enchant.txt_valksValue:SetSpanSize(self._ui_enchant.txt_valksValue:GetSpanSize().x - stackChangeBtnSizeX - 5, self._ui_enchant.txt_valksValue:GetSpanSize().y)
      self._ui_enchant.txt_plusValue:SetSpanSize(self._ui_enchant.txt_plusValue:GetSpanSize().x - stackChangeBtnSizeX - 5, self._ui_enchant.txt_plusValue:GetSpanSize().y)
      self._ui_enchant.stc_line:SetSize(self._ui_enchant.stc_line:GetSizeX() - stackChangeBtnSizeX - 5, self._ui_enchant.stc_line:GetSizeY())
    end
    self._ui_enchant.txt_stackCoolTime:SetShow(false)
  end
  self._ui_pc.btn_groupEnchantGo:SetShow(false)
  self._ui_pc.chk_inventoryOpen:SetShow(false)
  self._ui_pc.btn_groupEnchantReady:SetShow(false)
  if false == self._isConsole then
    self._ui_pc.btn_question:SetShow(true)
    self._ui_pc.btn_close:SetShow(true)
    self._ui_pc.btn_enchantGo:SetShow(true)
    self._ui_pc.btn_extractionGo:SetShow(true)
    self._ui_console.stc_mainTabLB:SetShow(false)
    self._ui_console.stc_mainTabRB:SetShow(false)
    self._ui_console.stc_enchantGoY:SetShow(false)
    self._ui_console.stc_extractionSubTabLT:SetShow(false)
    self._ui_console.stc_extractionSubTabRT:SetShow(false)
    self._ui_console.stc_exractionGoY:SetShow(false)
    self._ui_console.stc_keyguideBg:SetShow(false)
    local releaseTexture = {
      [1] = self._ui_enchant.stc_wingsInfo[1].slot,
      [2] = self._ui_enchant.stc_wingsInfo[2].slot,
      [3] = self._ui_enchant.stc_wingsInfo[2].slot,
      [4] = self._ui_enchant.stc_equipSlot,
      [5] = self._ui_extraction.stc_itemSlot,
      [6] = self._ui_extraction.stc_bookSlot,
      [7] = self._ui_extraction.stc_scrollSlot
    }
    for index = 1, #releaseTexture do
      releaseTexture[index]:ReleaseTexture()
      releaseTexture[index]:ChangeTextureInfoNameAsync("")
    end
  else
    self._ui_pc.btn_question:SetShow(false)
    self._ui_pc.btn_close:SetShow(false)
    self._ui_pc.btn_enchantGo:SetShow(false)
    self._ui_pc.btn_extractionGo:SetShow(false)
    self._ui_console.stc_mainTabLB:SetShow(true)
    self._ui_console.stc_mainTabRB:SetShow(true)
    self._ui_console.stc_enchantGoY:SetShow(true)
    self._ui_console.stc_extractionSubTabLT:SetShow(true)
    self._ui_console.stc_extractionSubTabRT:SetShow(true)
    self._ui_console.stc_exractionGoY:SetShow(true)
    self._ui_console.stc_keyguideBg:SetShow(true)
  end
end
function PaGlobal_SpiritEnchant_All:prepareOpen()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._isWaitingServer = false
  self._isLeaderGroupEnchantMode = false
  self._isAniSkip = false
  self._isEndGroupEnchant = false
  self._isGroupEnchantReady = false
  self._enchantFailureRv = 0
  self._ui_enchant.btn_Add:SetShow(false)
  self._ui_enchant.btn_showTriedStack:SetShow(false)
  self:showGuaranteeEnchantBG(false)
  self._isGroupEnchantPartyMember = ToClient_GetIsEnterGroupEnchant()
  local selfIsPartyLeader = RequestParty_isLeader()
  self._ui_enchant.btn_groupEnchant:SetShow(selfIsPartyLeader == true and _ContentsGroup_SpiritGroupEnchant == true)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    self._ui_enchant.btn_beginnerGuide:SetShow(userType == __eEAdmissionSpeedChannelType_Newbie)
  end
  self._ui.btn_mainRadio[1]:SetIgnore(false)
  self._ui.btn_mainRadio[2]:SetShow(true)
  self._ui.btn_mainRadio[3]:SetShow(true)
  self._ui_enchant.stc_StackSave:SetIgnore(false)
  self._ui_pc.chk_inventoryOpen:SetShow(false)
  self._ui_pc.btn_groupEnchantGo:SetShow(false)
  self._ui_pc.btn_groupEnchantReady:SetShow(false)
  self._ui_enchant.chk_enchantCron:SetCheck(false)
  if self._isConsole == true and Panel_Window_Inventory ~= nil then
    Panel_Window_Inventory:ComputePos()
  end
  PaGlobal_SpiritEnchant_All:open()
  HandleEventLUp_SpiritEnchant_All_MainTabSelect(self._MAIN_TAB.ENCHANT)
  if true == PaGlobalFunc_DialogList_All_IsOpenForBlacksmith() then
    HandleEventLUp_SpiritEnchant_All_MainTabSelect(self._MAIN_TAB.EXTRACTION)
    HandleEventLUp_SpiritEnchant_All_SubTabSelect(self._SUB_TAB.BOOK)
    PaGlobalFunc_DialogList_All_ClearIsOpenForBlacksmith()
  elseif true == PaGlobalFunc_DialogList_All_IsOpenForCaphras() then
    HandleEventLUp_SpiritEnchant_All_MainTabSelect(self._MAIN_TAB.CARPHRAS)
    PaGlobalFunc_DialogList_All_ClearIsOpenForCaphras()
  end
  if false == _ContentsGroup_RenewUI_Inventory then
    PaGlobalFunc_Inventory_All_OpenWithSpiritEnchant(nil, nil, nil, nil, nil)
  else
    InventoryWindow_Show()
  end
  local isCheckCron = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantCron:IsCheck()
  ToClient_RequestSpiritEnchantRecord(isCheckCron, 4)
  local isCheckHammer = PaGlobal_SpiritEnchant_All._ui_enchant.chk_enchantDefenceFail:IsCheck()
  ToClient_SpiritEnchantRecord_SetCheckHammer(isCheckHammer, __eSpiritEnchantRecordHammerType_EnchantPanelOpen)
end
function PaGlobal_SpiritEnchant_All:open()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  Panel_Window_StackExtraction_All:SetShow(true)
  if self._isGroupEnchantPartyMember == true then
    PaGlobal_PartyEnchant:prepareOpen()
  end
end
function PaGlobal_SpiritEnchant_All:prepareClose()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if _ContentsGroup_EnchantLightStone == true then
    self:clearLightStoneEnchantSlot()
  else
    self:clearEnchantSlot()
  end
  self:clearCaphrasSlot()
  self:clearDarkSlot()
  self:clearBookSlot()
  self._isClickCancle = true
  if true == self._isAnimating then
    if PaGlobal_SpiritEnchant_All._MAIN_TAB.ENCHANT == PaGlobal_SpiritEnchant_All._currentMainTab then
      PaGlobal_SpiritEnchant_All:cancleEnchant()
    elseif PaGlobal_SpiritEnchant_All._MAIN_TAB.CARPHRAS == PaGlobal_SpiritEnchant_All._currentMainTab then
      PaGlobal_SpiritEnchant_All:cancleCaphrasPromotion()
    elseif PaGlobal_SpiritEnchant_All._SUB_TAB.BOOK == PaGlobal_SpiritEnchant_All._currentSubTab then
      PaGlobal_SpiritEnchant_All:cancleBookExtraction()
    else
      PaGlobal_SpiritEnchant_All:cancleDarkPredation()
    end
  end
  self._isAnimating = false
  if nil ~= Panel_Npc_Dialog_All then
    Panel_Npc_Dialog_All:SetIgnoreChild(false)
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
  elseif nil ~= Panel_Npc_Dialog then
    Panel_Npc_Dialog:SetIgnoreChild(false)
  end
  self._isNakAnimating = false
  self:stopEnchantResultNakMessage()
  self._ui_extraction.btn_subRadio[1]:SetIgnore(false)
  self._ui_extraction.btn_subRadio[2]:SetIgnore(false)
  for i = 1, #self._ui.btn_mainRadio do
    self._ui.btn_mainRadio[i]:SetIgnore(false)
    self._ui.btn_mainRadio[i]:SetCheck(false)
  end
  PaGlobal_SpiritEnchant_All:setAnimationSkipButton()
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_SpiritEnchant_All:close()
  if false == _ContentsGroup_RenewUI_Inventory then
    PaGlobalFunc_Inventory_All_CloseWithSpiritEnchant()
  else
    InventoryWindow_Close()
  end
  PaGlobalFunc_OtherUser_TriedStack_Close()
end
function PaGlobal_SpiritEnchant_All:close()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  Panel_Window_StackExtraction_All:SetShow(false)
end
function PaGlobal_SpiritEnchant_All:registEventHandler()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  Panel_Window_StackExtraction_All:RegisterShowEventFunc(true, "")
  Panel_Window_StackExtraction_All:RegisterShowEventFunc(false, "")
  Panel_Window_StackExtraction_All:RegisterUpdateFunc("PaGlobalFunc_SpiritEnchant_All_UpdateFuncCheckAni")
  registerEvent("EventEnchantResultShow", "FromClient_SpiritEnchant_All_EnchantResultShow")
  registerEvent("EventGroupEnchantResultShow", "FromClient_SpiritEnchant_All_GroupEnchantResultShow")
  registerEvent("FromClient_EnchantFailCountUpResult", "FromClient_SpiritEnchant_All_EnchantFailCountUpResult")
  registerEvent("FromClient_UpgradeItem", "FromClient_SpiritEnchant_All_CaphrasUpgradeItem")
  registerEvent("FromClient_UpdateEnchantFailCount", "FromClient_SpiritEnchant_All_UpdateEnchantFailCount")
  registerEvent("FromClient_PromotionItem", "FromClient_SpiritEnchant_All_CaphrasPromotionItem")
  registerEvent("FromClient_FailCountUpdate", "FromClient_SpiritEnchant_All_FailCountUpdate")
  registerEvent("onScreenResize", "FromClient_SpiritEnchant_All_OnScreenResize")
  registerEvent("FromClient_InventoryUpdate", "FromClient_SpiritEnchant_All_UpdateEnchantFailCount")
  registerEvent("FromClient_StrartGroupEnchantAni", "FromClient_StrartGroupEnchantAni")
  registerEvent("FromClient_ConvertEnchantFailCountToItem", "FromClient_SpiritEnchant_All_ConvertEnchantFailCountToItem")
  registerEvent("FromClient_ConvertEnchantFailItemToCount", "FromClient_SpiritEnchant_All_ConvertEnchantFailItemToCount")
  registerEvent("FromClient_ConvertEnchantFailCountToItemAck", "FromClient_SpiritEnchant_All_ConvertEnchantFailCountToItemAck")
  registerEvent("FromClient_ConvertEnchantFailItemToCountAck", "FromClient_SpiritEnchant_All_ConvertEnchantFailItemToCountAck")
  if true == _ContentsGroup_FamilyStack then
    registerEvent("FromClient_ResponseEnchantStackSlotList", "FromClient_SpiritEnchant_All_FamilyStack_Update")
    registerEvent("FromClient_ResponseExpandEnchantStackSlotCount", "FromClient_SpiritEnchant_All_FamilyStack_Update")
  end
  if true == _ContentsGroup_EnchantLightStone then
    registerEvent("FromClinet_responseEnchantLightStone", "FromClinet_responseEnchantLightStone")
  end
  registerEvent("FromClient_ReceivedTriedStackInfo", "FromClient_ReceivedTriedStackInfo")
  if false == self._isConsole then
    self._ui_pc.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SpiritEnchant\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui_pc.btn_question, "\"SpiritEnchant\"")
    self._ui_pc.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SpiritEnchant_All_Close()")
    self._ui.btn_mainRadio[1]:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_MainTabSelect(" .. self._MAIN_TAB.ENCHANT .. ")")
    self._ui.btn_mainRadio[2]:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_MainTabSelect(" .. self._MAIN_TAB.CARPHRAS .. ")")
    self._ui.btn_mainRadio[3]:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_MainTabSelect(" .. self._MAIN_TAB.EXTRACTION .. ")")
    self._ui_extraction.btn_subRadio[1]:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_SubTabSelect(" .. self._SUB_TAB.DARK .. ")")
    self._ui_extraction.btn_subRadio[2]:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_SubTabSelect(" .. self._SUB_TAB.BOOK .. ")")
    self._slotEquip.slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
    self._slotMateiralInfo[1].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
    for ii = LightStoneControlType.Main, LightStoneControlType.Sub1 do
      local slot = self._ui_enchant.lightStoneControlList[ii].slot
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SpiritEnchant_All_ReleseTargetItem()")
    end
    self._ui_enchant.radio_enchantNormal:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()")
    self._ui_enchant.radio_enchantPerfect:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()")
    self._ui_enchant.chk_enchantForce:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_RadioCheckClick(1)")
    self._ui_enchant.chk_enchantCron:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_RadioCheckClick(2)")
    self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_DefenceFailClick()")
    self._ui_enchant.btn_stackChange:addInputEvent("Mouse_LUp", "PaGlobalFunc_StackStorage_All_Toggle()")
    self._ui_enchant.btn_stackChange:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_StackChangeTooltip(true)")
    self._ui_enchant.btn_stackChange:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_StackChangeTooltip(false)")
  else
    self._ui_enchant.radio_enchantNormal:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()")
    self._ui_enchant.radio_enchantPerfect:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantCheckClick()")
    self._ui_enchant.chk_enchantForce:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_RadioCheckClick(1)")
    self._ui_enchant.chk_enchantCron:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_RadioCheckClick(2)")
    self._ui_enchant.chk_enchantDefenceFail:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_DefenceFailClick()")
    self._ui_enchant.btn_stackChange:addInputEvent("Mouse_LUp", "PaGlobalFunc_StackStorage_All_Toggle()")
    self._ui_enchant.btn_stackChange:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_StackChangeTooltip(true)")
    self._ui_enchant.btn_stackChange:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_StackChangeTooltip(false)")
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandlePadEventLBRB_SpiritEnchant_All_MainMoveTab(true)")
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandlePadEventLBRB_SpiritEnchant_All_MainMoveTab(false)")
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_LT, "HandlePadEventLTRT_SpiritEnchant_All_SubMoveTab(true)")
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_RT, "HandlePadEventLTRT_SpiritEnchant_All_SubMoveTab(false)")
  end
end
function PaGlobal_SpiritEnchant_All:validate()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_mainTabBg:isValidate()
  self._ui.btn_mainRadio[1]:isValidate()
  self._ui.btn_mainRadio[2]:isValidate()
  self._ui.btn_mainRadio[3]:isValidate()
  self._ui.stc_selectBar:isValidate()
  self._ui.stc_line:isValidate()
  self._ui_enchant.stc_enchantBg:isValidate()
  self._ui_enchant.stc_imageArea:isValidate()
  self._ui_enchant.stc_infoArea:isValidate()
  self._ui_enchant.stc_noticeBar:isValidate()
  self._ui_enchant.stc_image:isValidate()
  self._ui_enchant.stc_wingCenter:isValidate()
  self._ui_enchant.stc_wingTop:isValidate()
  self._ui_enchant.stc_wingBottom:isValidate()
  self._ui_enchant.txt_enchantRate:isValidate()
  self._ui_enchant.stc_equipSlot:isValidate()
  self._ui_enchant.stc_blablaBg:isValidate()
  self._ui_enchant.txt_blablaText:isValidate()
  self._ui_enchant.txt_enchantRate:isValidate()
  self._ui_enchant.stc_equipSlot:isValidate()
  self._ui_enchant.stc_image2:isValidate()
  self._ui_enchant.stc_caphrasImage:isValidate()
  self._ui_enchant.stc_caphrasEquipSlot:isValidate()
  self._ui_enchant.stc_caphrasCurEquipSlot:isValidate()
  self._ui_enchant.stc_caphrasSlot:isValidate()
  self._ui_enchant.txt_caphrasCount:isValidate()
  self._ui_enchant.progress_caphrasNextExp:isValidate()
  self._ui_enchant.progress_caphrasCurExp:isValidate()
  self._ui_enchant.stc_caphrasRightLine:isValidate()
  self._ui_enchant.stc_caphrasLeftLine:isValidate()
  self._ui_enchant.stc_caphrasLeftWing:isValidate()
  self._ui_enchant.txt_caphrasNextStep:isValidate()
  self._ui_enchant.txt_caphrasNextMaterialInfo:isValidate()
  for idx = 1, 4 do
    self._ui_enchant.txt_caphrasStatusTitleL[idx]:isValidate()
    self._ui_enchant.txt_caphrasStatusValueL[idx]:isValidate()
  end
  self._ui_enchant.stc_caphrasRightWing:isValidate()
  self._ui_enchant.txt_caphrasCurStep:isValidate()
  self._ui_enchant.txt_caphrasEffect:isValidate()
  for idx = 1, 4 do
    self._ui_enchant.txt_caphrasStatusTitleR[idx]:isValidate()
    self._ui_enchant.txt_caphrasStatusValueR[idx]:isValidate()
  end
  self._ui_enchant.stc_bg:isValidate()
  self._ui_enchant.txt_subTitle:isValidate()
  self._ui_enchant.txt_subTitleValue:isValidate()
  self._ui_enchant.txt_valks:isValidate()
  self._ui_enchant.txt_valksValue:isValidate()
  self._ui_enchant.txt_plus:isValidate()
  self._ui_enchant.txt_plusValue:isValidate()
  self._ui_enchant.btn_Add:isValidate()
  self._ui_enchant.stc_buttonArea:isValidate()
  self._ui_enchant.radio_enchantNormal:isValidate()
  self._ui_enchant.radio_enchantPerfect:isValidate()
  self._ui_enchant.chk_enchantForce:isValidate()
  self._ui_enchant.chk_enchantCron:isValidate()
  self._ui_enchant.chk_enchantDefenceFail:isValidate()
  self._ui_enchant.txt_enchantDesc:isValidate()
  self._ui_enchant.chk_skipAni:isValidate()
  self._ui_enchant.txt_maxEncahnt:isValidate()
  self._ui_enchant.stc_tubalaExchangeBg:isValidate()
  self._ui_enchant.txt_congraturation:isValidate()
  self._ui_enchant.stc_tubalaItemSlotBg:isValidate()
  self._ui_enchant.stc_tubalaItemSlot:isValidate()
  self._ui_enchant.txt_itemName:isValidate()
  self._ui_enchant.stc_attackPointArea:isValidate()
  self._ui_enchant.txt_apTitle:isValidate()
  self._ui_enchant.txt_hitTitle:isValidate()
  self._ui_enchant.txt_apValue:isValidate()
  self._ui_enchant.txt_hitValue:isValidate()
  self._ui_enchant.stc_defencePointArea:isValidate()
  self._ui_enchant.txt_dpTitle:isValidate()
  self._ui_enchant.txt_dodTitle:isValidate()
  self._ui_enchant.txt_RedTitle:isValidate()
  self._ui_enchant.txt_dpValue:isValidate()
  self._ui_enchant.txt_dodValue:isValidate()
  self._ui_enchant.txt_redValue:isValidate()
  self._ui_enchant.btn_tubalaExchange:isValidate()
  self._ui_extraction.stc_extractionBg:isValidate()
  self._ui_extraction.stc_subTabBg:isValidate()
  self._ui_extraction.btn_subRadio[1]:isValidate()
  self._ui_extraction.btn_subRadio[2]:isValidate()
  self._ui_extraction.stc_selectBar:isValidate()
  self._ui_extraction.stc_line:isValidate()
  self._ui_extraction.stc_extractionAreaBg:isValidate()
  self._ui_extraction.stc_imageArea:isValidate()
  self._ui_extraction.stc_imageDarkPredation:isValidate()
  self._ui_extraction.stc_itemSlot:isValidate()
  self._ui_extraction.txt_stackRate:isValidate()
  self._ui_extraction.stc_imageSecretBook:isValidate()
  self._ui_extraction.stc_bookSlot:isValidate()
  self._ui_extraction.stc_scrollSlot:isValidate()
  self._ui_extraction.stc_infoArea:isValidate()
  self._ui_extraction.txt_subTitle:isValidate()
  self._ui_extraction.txt_valks:isValidate()
  self._ui_extraction.txt_valksValue:isValidate()
  self._ui_extraction.txt_plus:isValidate()
  self._ui_extraction.txt_plusValue:isValidate()
  self._ui_extraction.stc_verticalLine:isValidate()
  self._ui_extraction.txt_currentStack:isValidate()
  self._ui_extraction.stc_arrowIcon:isValidate()
  self._ui_extraction.txt_resultStack:isValidate()
  self._ui_extraction.stc_bottomArea:isValidate()
  self._ui_extraction.txt_extractionDesc:isValidate()
  self._ui_extraction.chk_skipAni:isValidate()
  self._ui_pc.btn_enchantGo:isValidate()
  self._ui_pc.btn_extractionGo:isValidate()
  self._ui_pc.btn_question:isValidate()
  self._ui_pc.btn_close:isValidate()
  self._ui_console.stc_mainTabLB:isValidate()
  self._ui_console.stc_mainTabRB:isValidate()
  self._ui_console.stc_enchantGoY:isValidate()
  self._ui_console.stc_extractionSubTabLT:isValidate()
  self._ui_console.stc_extractionSubTabRT:isValidate()
  self._ui_console.stc_exractionGoY:isValidate()
end
function PaGlobal_SpiritEnchant_All:resize()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_Caphras and false == _ContentsGroup_isSecretExtract and false == _ContentsGroup_EatEnchant then
    self._ui.btn_mainRadio[self._MAIN_TAB.CARPHRAS]:SetShow(false)
    self._ui.btn_mainRadio[self._MAIN_TAB.EXTRACTION]:SetShow(false)
    self._ui.btn_mainRadio[self._MAIN_TAB.ENCHANT]:SetSpanSize(0, self._ui.btn_mainRadio[self._MAIN_TAB.ENCHANT]:GetSpanSize().y)
  else
    local eClosedTab, eOpenTab
    if false == _ContentsGroup_Caphras then
      eClosedTab = self._MAIN_TAB.CARPHRAS
      eOpenTab = self._MAIN_TAB.EXTRACTION
    end
    if false == _ContentsGroup_isSecretExtract and false == _ContentsGroup_EatEnchant then
      eClosedTab = self._MAIN_TAB.EXTRACTION
      eOpenTab = self._MAIN_TAB.CARPHRAS
    end
    if nil == eClosedTab or nil == eOpenTab then
      return
    end
    self._ui.btn_mainRadio[eClosedTab]:SetShow(false)
    self._ui.btn_mainRadio[self._MAIN_TAB.ENCHANT]:SetSpanSize(-80, self._ui.btn_mainRadio[self._MAIN_TAB.ENCHANT]:GetSpanSize().y)
    self._ui.btn_mainRadio[eOpenTab]:SetSpanSize(80, self._ui.btn_mainRadio[self._MAIN_TAB.EXTRACTION]:GetSpanSize().y)
    self._ui.btn_mainRadio[eOpenTab]:ComputePos()
    self._ui.btn_mainRadio[self._MAIN_TAB.ENCHANT]:ComputePos()
  end
  if true == self._isConsole then
    local invenPosY = 0
    if true == _ContentsGroup_NewUI_Inventory_All then
      invenPosY = Panel_Window_Inventory_All:GetPosY()
    else
      invenPosY = Panel_Window_Inventory:GetPosY()
    end
    Panel_Window_StackExtraction_All:SetPosY(invenPosY + 50)
  end
  self._tooltipSpanX = (getOriginScreenSizeX() - getScreenSizeX()) / 2
end
function PaGlobal_SpiritEnchant_All:clearItemSlot(itemSlot)
  itemSlot.inventoryType = nil
  itemSlot.slotNo = nil
  itemSlot:clearItem()
  itemSlot.empty = true
  itemSlot.icon:EraseAllEffect()
end
function PaGlobal_SpiritEnchant_All:mainTabCheck(radioBtn, selectBar)
  for idx = 1, 3 do
    self._ui.btn_mainRadio[idx]:SetCheck(false)
  end
  local barPosX = radioBtn:GetPosX() + radioBtn:GetSizeX() / 2 - selectBar:GetSizeX() / 2
  radioBtn:SetCheck(true)
  selectBar:SetPosX(barPosX)
end
function PaGlobal_SpiritEnchant_All:subTabCheck(radioBtn, selectBar)
  for idx = 1, 2 do
    self._ui_extraction.btn_subRadio[idx]:SetCheck(false)
  end
  local barPosX = radioBtn:GetPosX() + radioBtn:GetSizeX() / 2 - selectBar:GetSizeX() / 2
  radioBtn:SetCheck(true)
  selectBar:SetPosX(barPosX)
end
function PaGlobal_SpiritEnchant_All:setItemToSlot(uiSlot, slotNo, itemWrapper, inventoryType, enchantLevel)
  if nil == itemWrapper then
    return
  end
  self:setItemEnchantLevelEffect(uiSlot, itemWrapper, enchantLevel)
  uiSlot.empty = false
  uiSlot.slotNo = slotNo
  uiSlot.inventoryType = inventoryType
  uiSlot.icon:SetMonoTone(false)
  local itemSSW = itemWrapper:getStaticStatus()
  self._isMaterialSlotMonotone = false
  if self._currentMainTab == self._MAIN_TAB.ENCHANT then
    local itemTotalCount = itemWrapper:getCount()
    local needItemCount = 1
    if itemTotalCount > toInt64(0, 0) and itemSSW:isStackable() then
      local needCountForPerfectEnchant_s64 = self._enchantInfo:ToClient_getNeedCountForPerfectEnchant_s64()
      if self._isShow_forceEnchant and self._ui_enchant.chk_enchantForce:IsCheck() and needCountForPerfectEnchant_s64 > toInt64(0, 0) then
        if itemTotalCount < needCountForPerfectEnchant_s64 then
          needItemCount = needCountForPerfectEnchant_s64
          self:setItemToSlotMonoTone(uiSlot, itemSSW, true)
          self._isMaterialSlotMonotone = true
        else
          needItemCount = needCountForPerfectEnchant_s64
        end
      elseif self._isSetNewPerfectItemMaterial then
        local enchantItemWrapper = getInventoryItemByType_Sub(self._grantItemWhereType, self._grantItemSlotNo)
        local needCountForNewPerfectEnchant_s64 = enchantItemWrapper:getStaticStatus():getNeedNewPerfectEnchantItemCount()
        if itemTotalCount < needCountForNewPerfectEnchant_s64 then
          needItemCount = needCountForNewPerfectEnchant_s64
          self:setItemToSlotMonoTone(uiSlot, itemSSW, true)
          self._isMaterialSlotMonotone = true
          self._materialItemSlotNo = slotNo
        else
          needItemCount = needCountForNewPerfectEnchant_s64
        end
      else
        if nil == self._grantItemWhereType or nil == self._grantItemSlotNo then
          return
        end
        local enchantItemWrapper = getInventoryItemByType_Sub(self._grantItemWhereType, self._grantItemSlotNo)
        needItemCount = enchantItemWrapper:getNeedEnchantItem(false)
      end
      self._materialNeedCount = Int64toInt32(needItemCount)
      getInventoryItemByType(inventoryType, slotNo)
      uiSlot:setItemByStaticStatus(itemSSW, needItemCount)
      if self._materialNeedCount > Int64toInt32(itemWrapper:get():getCount_s64()) or self._isSafeLowProtectorItem == true then
        uiSlot.empty = false
        uiSlot.slotNo = 0
        uiSlot.inventoryType = __eTInventorySlotNoUndefined
        uiSlot.icon:SetMonoTone(true, true)
      end
    else
      self._materialNeedCount = Int64toInt32(needItemCount)
      uiSlot:setItem(itemWrapper)
    end
  else
    uiSlot:setItem(itemWrapper)
  end
  local isSeasonCharacter = getSelfPlayer():get():isSeasonCharacter()
  if true == itemSSW:get():isChangeEquipItem() and true == isSeasonCharacter then
    self._naruItemWhereType = inventoryType
    self._naruItemSlotNo = slotNo
    self:tubalaItemSet(itemSSW)
    self._ui_enchant.stc_tubalaExchangeBg:SetShow(true)
    self._ui_enchant.stc_StackInfo:SetShow(false)
    self._ui_enchant.stc_noticeBar:SetShow(false)
    self._ui_enchant.stc_tubalaExchangeBg:EraseAllEffect()
    self._ui_enchant.stc_tubalaExchangeBg:AddEffect("fUI_Box_Light_5A", true, 0, 0)
  else
    self._ui_enchant.stc_tubalaExchangeBg:SetShow(false)
    self._ui_enchant.stc_StackInfo:SetShow(true)
    if true == self._isConsole then
      self._ui_enchant.btn_tubalaExchange:SetSize(self._ui_enchant.stc_tubalaExchangeBg:GetSizeX() * 0.8, self._ui_enchant.btn_tubalaExchange:GetSizeY())
      self._ui_enchant.btn_tubalaExchange:ComputePos()
    else
      self._ui_enchant.btn_tubalaExchange:SetSize(self._originTubalaExchangeBtnSizeX, self._ui_enchant.btn_tubalaExchange:GetSizeY())
      self._ui_enchant.btn_tubalaExchange:ComputePos()
    end
    self._ui_enchant.stc_noticeBar:SetShow(true)
  end
  if self._slotMateiralInfo[2] ~= nil and self._slotMateiralInfo[2] == uiSlot then
    self:setProtectorItems()
  end
  self:setText_EnchantInfo()
end
function PaGlobal_SpiritEnchant_All:tubalaItemSet(itemSSW)
  if nil == itemSSW then
    return
  end
  local itemKey = itemSSW:get()._key
  self._tubalaItemKey = ToClient_getTubalaItemForNaruItemEnchantKey(itemKey)
  local tubalaItemSSW = getItemEnchantStaticStatus(self._tubalaItemKey)
  if nil ~= tubalaItemSSW then
    local enchantLevel = tubalaItemSSW:get()._key:getEnchantLevel()
    local itemName = HighEnchantLevel_ReplaceString(enchantLevel) .. " " .. tubalaItemSSW:getName()
    self._ui_enchant.txt_itemName:SetText(itemName)
    self._slotTubala:setItemByStaticStatus(tubalaItemSSW, 1)
    if self._isConsole == true and ToClient_isConsole() == true then
      self._ui_enchant.stc_tubalaItemSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_ShowTubalaItemTooltip()")
    end
    self._slotTubala.icon:addInputEvent("Mouse_On", "HandleEventOn_SpiritEnchant_All_TubalaItemTooltip_Show()")
    self._slotTubala.icon:addInputEvent("Mouse_Out", "HandleEventOut_SpiritEnchant_All_TubalaItemTooltip_Hide()")
  end
  local minAttack, maxAttack, hit, dv, hdv, pv, hpv, defencePoint = 0, 0, 0, 0, 0, 0, 0, 0
  for index = 0, 2 do
    local currentMin = tubalaItemSSW:getMinDamage(index)
    minAttack = math.max(minAttack, currentMin)
    local currentMax = tubalaItemSSW:getMaxDamage(index)
    maxAttack = math.max(maxAttack, currentMax)
    local currentHit = tubalaItemSSW:ToClient_getHit(index)
    hit = math.max(hit, currentHit)
    local currnetDv = tubalaItemSSW:ToClient_getDV(index)
    dv = math.max(dv, currnetDv)
    local currentHDV = tubalaItemSSW:ToClient_getHDV(index)
    hdv = math.max(hdv, currentHDV)
    local currentPv = tubalaItemSSW:ToClient_getPV(index)
    pv = math.max(pv, currentPv)
    local currentHPv = tubalaItemSSW:ToClient_getHPV(index)
    hpv = math.max(hpv, currentHPv)
  end
  local defencePoint = dv + pv
  self._ui_enchant.txt_apValue:SetText(minAttack .. " ~ " .. maxAttack)
  self._ui_enchant.txt_hitValue:SetText(hit)
  self._ui_enchant.txt_dpValue:SetText(defencePoint)
  if hdv > 0 then
    self._ui_enchant.txt_dodValue:SetText(dv .. "(+" .. hdv .. ")")
  else
    self._ui_enchant.txt_dodValue:SetText(dv)
  end
  if hpv > 0 then
    self._ui_enchant.txt_redValue:SetText(pv .. "(+" .. hpv .. ")")
  else
    self._ui_enchant.txt_redValue:SetText(pv)
  end
  self._ui_enchant.txt_apTitle:SetShow(minAttack + maxAttack > 0)
  self._ui_enchant.txt_apValue:SetShow(minAttack + maxAttack > 0)
  self._ui_enchant.txt_hitTitle:SetShow(hit > 0)
  self._ui_enchant.txt_hitValue:SetShow(hit > 0)
  self._ui_enchant.txt_dpTitle:SetShow(defencePoint > 0)
  self._ui_enchant.txt_dpValue:SetShow(defencePoint > 0)
  self._ui_enchant.txt_dodTitle:SetShow(dv > 0)
  self._ui_enchant.txt_dodValue:SetShow(dv > 0)
  self._ui_enchant.txt_RedTitle:SetShow(pv > 0)
  self._ui_enchant.txt_redValue:SetShow(pv > 0)
  local tubalaBgSizeX = self._ui_enchant.stc_tubalaExchangeBg:GetSizeX()
  local attackValueSizeX = 100
  local defaultAttackAreaSizeX = 150
  local apTitleSizeX = self._ui_enchant.txt_apTitle:GetTextSizeX()
  local hitTitleSizeX = self._ui_enchant.txt_hitTitle:GetTextSizeX()
  local defenceValueSizeX = 50
  local defaultDeffenceAreaSizeX = 120
  local dpTitleSizeX = self._ui_enchant.txt_dpTitle:GetTextSizeX()
  local dodTitleSizeX = self._ui_enchant.txt_dodTitle:GetTextSizeX()
  local redTitleSizeX = self._ui_enchant.txt_RedTitle:GetTextSizeX()
  if self._ui_enchant.txt_apTitle:GetShow() then
    self._ui_enchant.stc_attackPointArea:SetSize(math.max(defaultAttackAreaSizeX, math.max(apTitleSizeX, hitTitleSizeX) + attackValueSizeX), self._ui_enchant.stc_attackPointArea:GetSizeY())
  else
    self._ui_enchant.stc_attackPointArea:SetSize(math.max(defaultAttackAreaSizeX, hitTitleSizeX + attackValueSizeX), self._ui_enchant.stc_attackPointArea:GetSizeY())
  end
  self._ui_enchant.stc_attackPointArea:SetPosX(240)
  self._ui_enchant.stc_defencePointArea:SetSize(math.max(defaultDeffenceAreaSizeX, math.max(dpTitleSizeX, dodTitleSizeX, redTitleSizeX) + defenceValueSizeX), self._ui_enchant.stc_defencePointArea:GetSizeY())
  self._ui_enchant.stc_defencePointArea:SetPosX(440)
  self._ui_enchant.txt_apTitle:ComputePos()
  self._ui_enchant.txt_apValue:ComputePos()
  self._ui_enchant.txt_hitTitle:ComputePos()
  self._ui_enchant.txt_hitValue:ComputePos()
  self._ui_enchant.txt_dpTitle:ComputePos()
  self._ui_enchant.txt_dpValue:ComputePos()
  self._ui_enchant.txt_dodTitle:ComputePos()
  self._ui_enchant.txt_dodValue:ComputePos()
  self._ui_enchant.txt_RedTitle:ComputePos()
  self._ui_enchant.txt_redValue:ComputePos()
  self._ui_enchant.stc_tubalaItemSlotBg:ComputePos()
  self._ui_enchant.stc_tubalaItemSlot:ComputePos()
  self._ui_enchant.txt_itemName:SetPosX(32)
  if 0 == minAttack + maxAttack + hit then
    self._ui_enchant.stc_attackPointArea:SetShow(false)
    self._ui_enchant.stc_defencePointArea:SetPosX(240)
    self._ui_enchant.stc_defencePointArea:SetShow(true)
  elseif 0 == defencePoint then
    self._ui_enchant.stc_attackPointArea:SetShow(true)
    self._ui_enchant.stc_attackPointArea:SetPosX(240)
    self._ui_enchant.stc_defencePointArea:SetShow(false)
  else
    self._ui_enchant.txt_apValue:SetShow(minAttack + maxAttack)
    self._ui_enchant.stc_attackPointArea:SetShow(true)
    self._ui_enchant.stc_defencePointArea:SetShow(true)
    self._ui_enchant.stc_defencePointArea:SetPosX(440)
    if tubalaBgSizeX < self._ui_enchant.stc_defencePointArea:GetPosX() + self._ui_enchant.stc_defencePointArea:GetSizeX() then
      self._ui_enchant.stc_defencePointArea:SetPosX(tubalaBgSizeX - self._ui_enchant.stc_defencePointArea:GetSizeX())
    end
    if self._ui_enchant.stc_defencePointArea:GetPosX() < self._ui_enchant.stc_attackPointArea:GetPosX() + self._ui_enchant.stc_attackPointArea:GetSizeX() + 50 then
      self._ui_enchant.stc_attackPointArea:SetPosX(self._ui_enchant.stc_defencePointArea:GetPosX() - self._ui_enchant.stc_attackPointArea:GetSizeX() - 50)
    end
    if self._ui_enchant.stc_attackPointArea:GetPosX() < self._ui_enchant.stc_tubalaItemSlotBg:GetPosX() + self._ui_enchant.stc_tubalaItemSlotBg:GetSizeX() + 20 then
      self._ui_enchant.stc_tubalaItemSlotBg:SetPosX(self._ui_enchant.stc_attackPointArea:GetPosX() - self._ui_enchant.stc_tubalaItemSlot:GetSizeX() - 20)
      self._ui_enchant.stc_tubalaItemSlot:SetPosX(self._ui_enchant.stc_tubalaItemSlotBg:GetPosX() + 2)
      self._ui_enchant.txt_itemName:SetPosX(self._ui_enchant.stc_tubalaItemSlotBg:GetPosX() - 78)
    end
  end
  self._ui_enchant.txt_congraturation:EraseAllEffect()
  self._ui_enchant.txt_congraturation:AddEffect("UI_QustComplete01", false, 0, -2)
end
function PaGlobalFunc_ExchangeTubala()
  if nil == PaGlobal_SpiritEnchant_All._naruItemWhereType or nil == PaGlobal_SpiritEnchant_All._naruItemSlotNo then
    return
  end
  local naruName = ""
  local tubalaName = ""
  local itemWrapper = getInventoryItemByType(PaGlobal_SpiritEnchant_All._naruItemWhereType, PaGlobal_SpiritEnchant_All._naruItemSlotNo)
  if nil ~= itemWrapper then
    naruName = itemWrapper:getStaticStatus():getName()
  end
  local tubalaItemSSW = getItemEnchantStaticStatus(PaGlobal_SpiritEnchant_All._tubalaItemKey)
  if nil ~= tubalaItemSSW then
    tubalaName = tubalaItemSSW:getName()
  end
  local UpgradeYes = function()
    ToClient_RequestChangeEquipItem(PaGlobal_SpiritEnchant_All._naruItemWhereType, PaGlobal_SpiritEnchant_All._naruItemSlotNo)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SEASON_EQUIPMENT_CHANGE_MESSAGE", "naru", "[<PAColor0xFF4B97FF>" .. naruName .. "<PAOldColor>]", "tubala", "[<PAColor0xFFFFC832>" .. tubalaName .. "<PAOldColor>]"),
    functionYes = UpgradeYes,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_SpiritEnchant_All:setItemToSlotMonoTone(uiSlot, itemStaticWrapper, isMonotone)
  uiSlot.empty = false
  uiSlot.slotNo = 0
  uiSlot.inventoryType = __eTInventorySlotNoUndefined
  uiSlot.icon:SetMonoTone(isMonotone, true)
  if false == isMonotone then
    uiSlot.icon:AddEffect("UI_Button_Hide", false, 0, 0)
  end
  if nil ~= itemStaticWrapper and nil ~= itemStaticWrapper:get() then
    uiSlot:setItemByStaticStatus(itemStaticWrapper, toInt64(0, 0), 0, false, false, false, 0, 0, nil)
  end
end
function PaGlobal_SpiritEnchant_All:setAsCancelButton()
  if self._currentMainTab == self._MAIN_TAB.ENCHANT or self._currentMainTab == self._MAIN_TAB.CARPHRAS then
    self._ui_pc.btn_enchantGo:EraseAllEffect()
    self._ui_pc.btn_enchantGo:EraseAllEffect()
    self._ui_pc.btn_enchantGo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL"))
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.stc_enchantGoY:SetMonoTone(true, true)
    self._ui_console.stc_exractionGoY:SetMonoTone(true, true)
  elseif self._currentMainTab == self._MAIN_TAB.EXTRACTION then
    self._ui_pc.btn_extractionGo:EraseAllEffect()
    self._ui_pc.btn_extractionGo:EraseAllEffect()
    self._ui_pc.btn_extractionGo:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL"))
    Panel_Window_StackExtraction_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self._ui_console.stc_enchantGoY:SetMonoTone(true, true)
    self._ui_console.stc_exractionGoY:SetMonoTone(true, true)
  end
end
function PaGlobal_SpiritEnchant_All:setItemEnchantLevelEffect(uiSlot, itemWrapper, enchantLevel)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW:isSpecialEnchantItem() == true and 0 < ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key) then
    enchantLevel = ToClient_getSpecialEnchantDisplayLevel(itemSSW:get()._key)
  end
  if CppEnums.ItemClassifyType.eItemClassify_Accessory == itemSSW:getItemClassify() and (itemSSW:isSpecialEnchantItem() == false or itemSSW:isSpecialAccessory() == true) then
    if nil ~= enchantLevel then
      if 1 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_01A", true, 0, 0)
      elseif 2 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_02A", true, 0, 0)
      elseif 3 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_03A", true, 0, 0)
      elseif 4 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_04A", true, 0, 0)
      elseif 5 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_05A", true, 0, 0)
      elseif 6 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_06A", true, 0, 0)
      elseif 7 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_07A", true, 0, 0)
      elseif 8 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_08A", true, 0, 0)
      elseif 9 == enchantLevel then
        uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_09A", true, 0, 0)
      end
    else
      uiSlot.icon:AddEffect("UI_Button_Hide", false, 0, 0)
    end
  elseif nil ~= enchantLevel then
    if 15 == enchantLevel then
      uiSlot.icon:AddEffect("", true, 0, 0)
    elseif 16 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_01A", true, 0, 0)
    elseif 17 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_02A", true, 0, 0)
    elseif 18 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_03A", true, 0, 0)
    elseif 19 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_04A", true, 0, 0)
    elseif 20 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_05A", true, 0, 0)
    elseif 21 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_06A", true, 0, 0)
    elseif 22 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_07A", true, 0, 0)
    elseif 23 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_08A", true, 0, 0)
    elseif 24 == enchantLevel then
      uiSlot.icon:AddEffect("fUI_SpiritEnchant_Equip_09A", true, 0, 0)
    end
  else
    uiSlot.icon:AddEffect("UI_Button_Hide", false, 0, 0)
  end
end
function PaGlobal_SpiritEnchant_All:addEnchantSuccessEffectToItemSlot(icon)
  icon:AddEffect("fUI_ItemEnchant_01A", false, 0, 0)
end
function PaGlobal_SpiritEnchant_All:getNextEnchantItemSSW(itemWrapper)
  if nil == itemWrapper then
    return nil
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return nil
  end
  local nextEnchantLevel = itemSSW:get()._key:getEnchantLevel() + 1
  if nextEnchantLevel > 25 then
    return nil
  end
  local enchantItemKey = ItemEnchantKey(itemSSW:get()._key:getItemKey(), nextEnchantLevel)
  enchantItemKey:set(itemSSW:get()._key:getItemKey(), nextEnchantLevel)
  itemSSW = getItemEnchantStaticStatus(enchantItemKey)
  return itemSSW
end
function PaGlobal_SpiritEnchant_All:setAnimationSkipButton()
  if self._currentMainTab == self._MAIN_TAB.ENCHANT then
    self._isEnchantAniSkip = self._ui_enchant.chk_skipAni:IsCheck()
  elseif self._currentMainTab == self._MAIN_TAB.CARPHRAS then
    self._isCaphrasAniSkip = self._ui_enchant.chk_skipAni:IsCheck()
  elseif self._currentMainTab == self._MAIN_TAB.EXTRACTION then
    if self._currentSubTab == self._SUB_TAB.DARK then
      self._isDarkAniSkip = self._ui_extraction.chk_skipAni:IsCheck()
    elseif self._currentSubTab == self._SUB_TAB.BOOK then
      self._isBookAniSkip = self._ui_extraction.chk_skipAni:IsCheck()
    end
  end
end
function PaGlobal_SpiritEnchant_All:resizePanel()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  local originPanelSizeX = Panel_Window_StackExtraction_All:GetSizeX()
  local panelSizeY = 0
  local infoAreaSizeY = 0
  if self._ui_enchant.stc_enchantBg:GetShow() then
    if true == _ContentsGroup_EnchantRenewer then
      self:resizePanel_EnchantTabNew()
    else
      if 0 < self._ui_enchant.txt_enchantDesc:GetTextSizeY() and "" ~= self._ui_enchant.txt_enchantDesc:GetText() then
        infoAreaSizeY = self._ui_enchant.txt_enchantDesc:GetTextSizeY() + self._ui_enchant.txt_enchantDesc:GetSpanSize().y - 30
        if self._currentMainTab == self._MAIN_TAB.CARPHRAS then
          infoAreaSizeY = infoAreaSizeY + 50
        end
      else
        infoAreaSizeY = self._ui_enchant.txt_enchantDesc:GetSizeY() - 20
        if self._ui_enchant.chk_enchantForce:GetShow() or self._ui_enchant.radio_enchantPerfect:GetShow() then
          infoAreaSizeY = infoAreaSizeY + self._ui_enchant.stc_buttonArea:GetSizeY() + 5
        end
      end
      if self._ui_enchant.stc_buttonArea:GetShow() then
        infoAreaSizeY = infoAreaSizeY + self._ui_enchant.stc_buttonArea:GetSizeY()
      end
      if self._ui_enchant.chk_skipAni:GetShow() then
        infoAreaSizeY = infoAreaSizeY + self._ui_enchant.chk_skipAni:GetSizeY()
      end
      if self._ui_pc.btn_enchantGo:GetShow() then
        infoAreaSizeY = infoAreaSizeY + self._ui_pc.btn_enchantGo:GetSizeY() + 10
      elseif true == self._isConsole then
        infoAreaSizeY = infoAreaSizeY + self._ui_console.stc_enchantGoY:GetSizeY() + 10
      end
      local extraSizeY = self._originEnchantInfoSizeY - infoAreaSizeY
      panelSizeY = self._originPanelSizeY - extraSizeY
      self._ui_enchant.stc_infoArea:SetSize(self._ui_enchant.stc_infoArea:GetSizeX(), self._ui_enchant.stc_infoArea:GetSizeY() - extraSizeY)
      self._ui_enchant.stc_enchantBg:SetSize(self._ui_enchant.stc_enchantBg:GetSizeX(), self._ui_enchant.stc_enchantBg:GetSizeY() - extraSizeY)
      self._ui_enchant.chk_skipAni:SetPosY(self._originEnchantButtonAreaPosY - extraSizeY)
      self._ui_pc.btn_enchantGo:SetPosY(self._originEnchantButtonAreaPosY + self._ui_enchant.chk_skipAni:GetSizeY() - extraSizeY + 5)
      self._ui_console.stc_enchantGoY:SetPosY(self._originEnchantButtonAreaPosY + self._ui_enchant.chk_skipAni:GetSizeY() - extraSizeY + 5)
      Panel_Window_StackExtraction_All:SetSize(originPanelSizeX, panelSizeY)
    end
  elseif self._ui_extraction.stc_extractionBg:GetShow() then
    infoAreaSizeY = self._ui_extraction.txt_extractionDesc:GetTextSizeY() + self._ui_extraction.chk_skipAni:GetSizeY() + self._ui_pc.btn_extractionGo:GetSizeY() + 30
    local extraSizeY = self._originExtractionBottomBGSizeY - infoAreaSizeY
    panelSizeY = self._originPanelSizeY - extraSizeY
    self._ui_extraction.stc_bottomArea:SetSize(self._ui_extraction.stc_bottomArea:GetSizeX(), self._ui_extraction.stc_bottomArea:GetSizeY() - extraSizeY)
    self._ui_extraction.chk_skipAni:SetPosY(self._originExtractionButtonAreaPosY - extraSizeY)
    self._ui_pc.btn_extractionGo:SetPosY(self._originExtractionButtonAreaPosY + self._ui_extraction.chk_skipAni:GetSizeY() - extraSizeY + 5)
    self._ui_console.stc_exractionGoY:SetPosY(self._originExtractionButtonAreaPosY + self._ui_extraction.chk_skipAni:GetSizeY() - extraSizeY + 5)
    if true == self._isConsole then
      panelSizeY = panelSizeY - self._ui_extraction.stc_subTabBg:GetSizeY()
      self._ui_extraction.stc_extractionAreaBg:SetSpanSize(self._ui_extraction.stc_extractionAreaBg:GetSpanSize().x, 0)
      self._ui_extraction.stc_extractionAreaBg:ComputePos()
    end
    Panel_Window_StackExtraction_All:SetSize(originPanelSizeX, panelSizeY)
  end
  self._ui_console.stc_keyguideBg:ComputePos()
  local tempBtnGroup = {
    self._ui_console.stc_rstick,
    self._ui_console.stc_select,
    self._ui_console.stc_detail,
    self._ui_console.stc_cancle
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui_console.stc_keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_SpiritEnchant_All:resizePanel_EnchantTabNew()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  local titleBarSizeY = self._ui.stc_titleBg:GetSizeY()
  local mainTabBarSizeY = self._ui.stc_mainTabBg:GetSizeY()
  local ImageAreaSizeY = 0
  if self._currentMainTab == self._MAIN_TAB.ENCHANT and true == self._ui_enchant.stc_image:GetShow() then
    ImageAreaSizeY = self._ui_enchant.stc_imageArea:GetSizeY()
  elseif self._currentMainTab == self._MAIN_TAB.ENCHANT and true == self._ui_enchant.stc_lightStoneImage:GetShow() then
    ImageAreaSizeY = self._ui_enchant.stc_imageArea:GetSizeY()
  elseif self._currentMainTab == self._MAIN_TAB.CARPHRAS and true == self._ui_enchant.stc_image2:GetShow() then
    ImageAreaSizeY = self._ui_enchant.stc_image2:GetSizeY()
  end
  local EnchantInfoAreaSizeY = 0
  local buttonAreaSizeY = 0
  local buttonAreaPadding = 5
  local PanelEdgePadding = 10
  if true == self._ui_enchant.stc_buttonArea:GetShow() then
    if true == self._ui_enchant.chk_enchantCron:GetShow() or true == self._ui_enchant.chk_enchantDefenceFail:GetShow() or true == self._ui_enchant.btn_stackChange:GetShow() or true == self._ui_enchant.stc_StackSave:GetShow() then
      buttonAreaSizeY = buttonAreaSizeY + self._ui_enchant.chk_enchantCron:GetSizeY() + buttonAreaPadding
    end
    if true == self._ui_enchant.radio_enchantNormal:GetShow() or true == self._ui_enchant.radio_enchantPerfect:GetShow() or true == self._ui_enchant.chk_enchantForce:GetShow() then
      buttonAreaSizeY = buttonAreaSizeY + self._ui_enchant.chk_enchantForce:GetSizeY()
    end
    EnchantInfoAreaSizeY = EnchantInfoAreaSizeY + buttonAreaSizeY + buttonAreaPadding
  end
  if true == self._ui_enchant.txt_enchantDesc:GetShow() and 0 < self._ui_enchant.txt_enchantDesc:GetTextSizeY() and "" ~= self._ui_enchant.txt_enchantDesc:GetText() then
    local descTextSizeY = self._ui_enchant.txt_enchantDesc:GetTextSizeY()
    EnchantInfoAreaSizeY = EnchantInfoAreaSizeY + descTextSizeY + buttonAreaPadding
  end
  if true == self._ui_enchant.chk_skipAni:GetShow() or true == self._ui_pc.chk_inventoryOpen:GetShow() then
    local skipButtonSizeY = self._ui_enchant.chk_skipAni:GetSizeY()
    EnchantInfoAreaSizeY = EnchantInfoAreaSizeY + skipButtonSizeY + buttonAreaPadding
  end
  if true == self._ui_pc.btn_groupEnchantReady:GetShow() then
    local groupEnchantButtonSizeY = self._ui_pc.btn_groupEnchantReady:GetSizeY()
    EnchantInfoAreaSizeY = EnchantInfoAreaSizeY + groupEnchantButtonSizeY + buttonAreaPadding
  end
  if true == self._ui_pc.btn_enchantGo:GetShow() or true == self._ui_console.stc_enchantGoY:GetShow() or true == self._ui_pc.btn_groupEnchantGo:GetShow() then
    local enchantGoSizeY = 0
    if false == self._isConsole then
      enchantGoSizeY = self._ui_pc.btn_enchantGo:GetSizeY()
    else
      enchantGoSizeY = self._ui_console.stc_enchantGoY:GetSizeY()
    end
    EnchantInfoAreaSizeY = EnchantInfoAreaSizeY + enchantGoSizeY
  end
  EnchantInfoAreaSizeY = EnchantInfoAreaSizeY + PanelEdgePadding
  local EnchantBgSizeY = ImageAreaSizeY + EnchantInfoAreaSizeY
  local PanelSizeY = titleBarSizeY + mainTabBarSizeY + PanelEdgePadding + EnchantBgSizeY
  Panel_Window_StackExtraction_All:SetSize(Panel_Window_StackExtraction_All:GetSizeX(), PanelSizeY)
  self._ui_enchant.stc_enchantBg:SetSize(self._ui_enchant.stc_enchantBg:GetSizeX(), EnchantBgSizeY)
  self._ui_enchant.stc_infoArea:SetSize(self._ui_enchant.stc_infoArea:GetSizeX(), EnchantInfoAreaSizeY)
  self._ui_enchant.stc_buttonArea:SetSize(self._ui_enchant.stc_buttonArea:GetSizeX(), buttonAreaSizeY)
  self._ui_enchant.stc_infoArea:SetSpanSize(self._ui_enchant.stc_infoArea:GetSpanSize().x, ImageAreaSizeY)
  self._ui_enchant.stc_buttonArea:SetSpanSize(self._ui_enchant.stc_buttonArea:GetSpanSize().x, PanelEdgePadding)
  self._ui_enchant.txt_enchantDesc:SetPosY(self._ui_enchant.stc_buttonArea:GetPosY() + self._ui_enchant.stc_buttonArea:GetSizeY() + buttonAreaPadding)
  self._ui_enchant.chk_skipAni:SetPosY(self._ui_enchant.txt_enchantDesc:GetPosY() + self._ui_enchant.txt_enchantDesc:GetTextSizeY())
  self._ui_pc.btn_enchantGo:SetPosY(self._ui_enchant.chk_skipAni:GetPosY() + self._ui_enchant.chk_skipAni:GetSizeY() + buttonAreaPadding)
  self._ui_console.stc_enchantGoY:SetPosY(self._ui_enchant.chk_skipAni:GetPosY() + self._ui_enchant.chk_skipAni:GetSizeY() + buttonAreaPadding)
  self._ui_pc.chk_inventoryOpen:SetPosY(self._ui_enchant.txt_enchantDesc:GetPosY() + self._ui_enchant.txt_enchantDesc:GetTextSizeY())
  self._ui_pc.btn_groupEnchantReady:SetPosY(self._ui_pc.chk_inventoryOpen:GetPosY() + self._ui_pc.chk_inventoryOpen:GetSizeY() + buttonAreaPadding)
  self._ui_pc.btn_groupEnchantGo:SetPosY(self._ui_pc.btn_groupEnchantReady:GetPosY() + self._ui_pc.btn_groupEnchantReady:GetSizeY() + buttonAreaPadding)
  if self._ui_enchant.btn_groupEnchant:GetShow() == true then
    self._ui_enchant.btn_beginnerGuide:SetSpanSize(620, 135)
  end
end
function PaGlobal_SpiritEnchant_All:updateEnchantFailCount()
  if nil == self._enchantInfo then
    self._enchantInfo = getEnchantInformation()
    self._enchantInfo:ToClient_clearData()
  end
  local failCount = self._enchantInfo:ToClient_getFailCount()
  local valksCount = self._enchantInfo:ToClient_getValksCount()
  local bonusStackCount = self._enchantInfo:ToClient_getBonusStackCount()
  local failCountUpRate = Int64toInt32(self._enchantInfo:ToClient_getFailCountUpRate())
  local enchantType = self._enchantInfo:ToClient_getEnchantType()
  if self._currentMainTab == self._MAIN_TAB.ENCHANT then
    self._ui_enchant.txt_subTitleValue:SetText("+ " .. failCount + valksCount + bonusStackCount)
    self._ui_enchant.txt_valksValue:SetText("+ " .. valksCount)
    self._ui_enchant.txt_plusValue:SetText("+ " .. failCount)
  else
    self._ui_extraction.txt_valksValue:SetText("+ " .. valksCount)
    self._ui_extraction.txt_plusValue:SetText("+ " .. failCount)
    self._ui_extraction.txt_currentStack:SetText("+ " .. failCount + valksCount + bonusStackCount)
  end
end
function PaGlobal_SpiritEnchant_All:controlEnchantNew_Init()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  self._ui_enchant.stc_enchantBgOld = self._ui_enchant.stc_enchantBg
  self._ui_enchant.stc_imageAreaOld = self._ui_enchant.stc_imageArea
  self._ui_enchant.stc_infoAreaOld = self._ui_enchant.stc_infoArea
  self._ui_enchant.stc_imageOld = self._ui_enchant.stc_image
  self._ui_enchant.stc_noticeBarOld = self._ui_enchant.stc_noticeBar
  self._ui_enchant.stc_enchantBg = UI.getChildControl(Panel_Window_StackExtraction_All, "Static_EnchantTab_New")
  self._ui_enchant.stc_imageArea = UI.getChildControl(self._ui_enchant.stc_enchantBg, "Static_ImageArea")
  self._ui_enchant.stc_infoArea = UI.getChildControl(self._ui_enchant.stc_enchantBg, "Static_EnchantInfoArea")
  self._ui_enchant.stc_resultNak = UI.getChildControl(Panel_Window_StackExtraction_All, "StaticText_NakMessage")
  self._ui_enchant.stc_noticeBar = UI.getChildControl(self._ui_enchant.stc_imageArea, "StaticText_NoticeBar")
  self._ui_enchant.stc_image = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_Image")
  self._ui_enchant.stc_topBg = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_TopBG")
  self._ui_enchant.stc_blackSpiritCountBG = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_BlackSpiritCountBG")
  self._ui_enchant.stc_wingCenter = UI.getChildControl(self._ui_enchant.stc_image, "Static_MiddleWing")
  self._ui_enchant.stc_wingTop = UI.getChildControl(self._ui_enchant.stc_image, "Static_TopWing")
  self._ui_enchant.stc_wingBottom = UI.getChildControl(self._ui_enchant.stc_image, "Static_BottomWing")
  self._ui_enchant.stc_wingsInfo = {
    [1] = {
      slot = UI.getChildControl(self._ui_enchant.stc_wingCenter, "Static_Slot"),
      count = UI.getChildControl(self._ui_enchant.stc_wingCenter, "StaticText_Count")
    },
    [2] = {
      slot = UI.getChildControl(self._ui_enchant.stc_wingTop, "Static_Slot"),
      count = UI.getChildControl(self._ui_enchant.stc_wingTop, "StaticText_Count")
    },
    [3] = {
      slot = UI.getChildControl(self._ui_enchant.stc_wingBottom, "Static_Slot"),
      count = UI.getChildControl(self._ui_enchant.stc_wingBottom, "StaticText_Count")
    }
  }
  self._ui_enchant.txt_enchantRate = UI.getChildControl(self._ui_enchant.stc_image, "StaticText_EnchantRate")
  self._ui_enchant.stc_blackSpiritCount = UI.getChildControl(self._ui_enchant.stc_image, "Static_BlackSpiritCount")
  self._ui_enchant.progress2_1 = UI.getChildControl(self._ui_enchant.stc_blackSpiritCount, "Progress2_1")
  self._ui_enchant.txt_count = UI.getChildControl(self._ui_enchant.stc_blackSpiritCount, "StaticText_Count")
  self._ui_enchant.stc_equipSlot = UI.getChildControl(self._ui_enchant.stc_image, "Static_EquipSlot")
  self._ui_enchant.stc_blablaBg = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_BlackSpiritEffect")
  self._ui_enchant.txt_blablaText = UI.getChildControl(self._ui_enchant.stc_blablaBg, "StaticText_BubbleDesc")
  self._ui_enchant.stc_blablaBg:AddEffect("fN_DarkSpirit_Gage_01A", true, 0, 0)
  self._ui_enchant.stc_blablaBg:SetShow(false)
  self._ui_enchant.txt_blablaText:SetTextMode(__eTextMode_AutoWrap)
  self._originEnchnatNoticeBgSizeY = self._ui_enchant.stc_noticeBar:GetSizeY()
  self._originEnchnatNoticeBgPosY = self._ui_enchant.stc_noticeBar:GetPosY()
  local slotEquip = {}
  SlotItem.new(slotEquip, "EnchantAll_Slot_0", 0, self._ui_enchant.stc_equipSlot, self._slotConfig)
  slotEquip:createChild()
  slotEquip.empty = true
  slotEquip:clearItem()
  slotEquip.border:SetSize(44, 44)
  slotEquip.border:SetPosX(0)
  slotEquip.border:SetPosY(0)
  self._slotEquip.slot = slotEquip
  Panel_Tooltip_Item_SetPosition(0, slotEquip, "Enchant")
  self._slotMateiralInfo = {}
  local slotMaterialCenter = {}
  SlotItem.new(slotMaterialCenter, "EnchantAll_Slot_1", 0, self._ui_enchant.stc_wingsInfo[1].slot, self._slotConfig_count)
  slotMaterialCenter:createChild()
  slotMaterialCenter.empty = true
  slotMaterialCenter:clearItem()
  slotMaterialCenter.border:SetSize(44, 44)
  slotMaterialCenter.border:SetPosX(0)
  slotMaterialCenter.border:SetPosY(0)
  self._slotMateiralInfo[1] = slotMaterialCenter
  Panel_Tooltip_Item_SetPosition(1, slotMaterialCenter, "Enchant")
  local slotMaterialTop = {}
  SlotItem.new(slotMaterialTop, "EnchantAll_Slot_2", 0, self._ui_enchant.stc_wingsInfo[2].slot, self._slotConfig_count)
  slotMaterialTop:createChild()
  slotMaterialTop.empty = true
  slotMaterialTop:clearItem()
  slotMaterialTop.border:SetSize(44, 44)
  slotMaterialTop.border:SetPosX(0)
  slotMaterialTop.border:SetPosY(0)
  self._slotMateiralInfo[2] = slotMaterialTop
  Panel_Tooltip_Item_SetPosition(2, slotMaterialTop, "Enchant")
  local slotMaterialBottom = {}
  SlotItem.new(slotMaterialBottom, "EnchantAll_Slot_3", 0, self._ui_enchant.stc_wingsInfo[3].slot, self._slotConfig_count)
  slotMaterialBottom:createChild()
  slotMaterialBottom.empty = true
  slotMaterialBottom:clearItem()
  slotMaterialBottom.border:SetSize(44, 44)
  slotMaterialBottom.border:SetPosX(0)
  slotMaterialBottom.border:SetPosY(0)
  self._slotMateiralInfo[3] = slotMaterialBottom
  Panel_Tooltip_Item_SetPosition(3, slotMaterialBottom, "Enchant")
  self._ui_enchant.stc_StackInfo = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_StackInfo")
  self._ui_enchant.txt_subTitle = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_SubTItle")
  self._ui_enchant.txt_valks = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_Valks")
  self._ui_enchant.txt_subTitleValue = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_CurrentValue")
  self._ui_enchant.txt_valksValue = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_ValksValue")
  self._ui_enchant.txt_plusValue = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_PlusRateValue")
  self._ui_enchant.btn_AddStack = UI.getChildControl(self._ui_enchant.stc_StackInfo, "Button_AddStack")
  self._ui_enchant.btn_AddStack_Valks = UI.getChildControl(self._ui_enchant.stc_StackInfo, "Button_AddStack_Valks")
  self._ui_enchant.stc_AdditionalRate_Title = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_AdditionalRate_Title")
  self._ui_enchant.stc_AdditionalRate_Icon = UI.getChildControl(self._ui_enchant.stc_StackInfo, "Static_AdditionalRate_Icon")
  self._ui_enchant.stc_AdditionalRate_Value = UI.getChildControl(self._ui_enchant.stc_StackInfo, "StaticText_AdditionalRate_Value")
  self._ui_enchant.stc_stackChangeEffect = UI.getChildControl(self._ui_enchant.stc_StackInfo, "Static_StackStorageEffect")
  self._ui_enchant.btn_showTriedStack = UI.getChildControl(self._ui_enchant.stc_StackInfo, "Button_OtherUser_AdditionalRate")
  self._ui_enchant.btn_showTriedStack:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_OtherUserAdditionalRateOption()")
  self._ui_enchant.btn_showTriedStack:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_ReqMostTriedStackTooltip(true)")
  self._ui_enchant.btn_showTriedStack:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_ReqMostTriedStackTooltip(false)")
  self._ui_enchant.btn_groupEnchant = UI.getChildControl(Panel_Window_StackExtraction_All, "Button_Banner")
  self._ui_enchant.btn_groupEnchant:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_ReqGroupEnchantReadyByLeader()")
  self._ui_enchant.btn_beginnerGuide = UI.getChildControl(Panel_Window_StackExtraction_All, "Button_Beginner_EnchantGuide")
  self._ui_enchant.btn_beginnerGuide:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantGuide()")
  self._ui_enchant.stc_buttonArea = UI.getChildControl(self._ui_enchant.stc_infoArea, "Static_ButtonArea")
  self._ui_enchant.radio_enchantNormal = UI.getChildControl(self._ui_enchant.stc_buttonArea, "RadioButton_NormalEnchant")
  self._ui_enchant.radio_enchantPerfect = UI.getChildControl(self._ui_enchant.stc_buttonArea, "RadioButton_PerfectEnchant")
  self._ui_enchant.chk_enchantForce = UI.getChildControl(self._ui_enchant.stc_buttonArea, "CheckButton_ForceEnchant")
  self._ui_enchant.chk_enchantCron = UI.getChildControl(self._ui_enchant.stc_buttonArea, "CheckButton_UseCron")
  self._ui_enchant.chk_enchantDefenceFail = UI.getChildControl(self._ui_enchant.stc_buttonArea, "CheckButton_UseDefenceFail")
  self._ui_enchant.btn_stackChange = UI.getChildControl(self._ui_enchant.stc_buttonArea, "Button_StackChange")
  self._ui_enchant.txt_stackCoolTime = UI.getChildControl(self._ui_enchant.btn_stackChange, "StaticText_Cooltime")
  self._ui_enchant.stc_StackSave = UI.getChildControl(self._ui_enchant.stc_buttonArea, "Button_StackSave")
  self._ui_enchant.chk_skipAni = UI.getChildControl(self._ui_enchant.stc_infoArea, "CheckButton_SkipAni")
  self._ui_enchant.txt_enchantDesc = UI.getChildControl(self._ui_enchant.stc_infoArea, "StaticText_EnchantKindDesc")
  self._ui_pc.btn_enchantGo = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_EnchantGoGo")
  self._ui_console.stc_enchantGoY = UI.getChildControl(self._ui_enchant.stc_infoArea, "Button_ConsoleButtonY")
  self._ui_enchant.stc_tubalaExchangeBg = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_Exchange_TubalaBg")
  self._ui_enchant.txt_congraturation = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "MultilineText_Congraturation")
  self._ui_enchant.stc_tubalaItemSlotBg = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "Static_TubalaSlotBg")
  self._ui_enchant.stc_tubalaItemSlot = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "Static_TubalaSlot")
  self._ui_enchant.txt_itemName = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "StaticText_ItemName")
  self._ui_enchant.stc_attackPointArea = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "Static_AttackStat")
  self._ui_enchant.txt_apTitle = UI.getChildControl(self._ui_enchant.stc_attackPointArea, "StaticText_APTitle")
  self._ui_enchant.txt_hitTitle = UI.getChildControl(self._ui_enchant.stc_attackPointArea, "StaticText_HitTitle")
  self._ui_enchant.txt_apValue = UI.getChildControl(self._ui_enchant.stc_attackPointArea, "StaticText_ApValue")
  self._ui_enchant.txt_hitValue = UI.getChildControl(self._ui_enchant.stc_attackPointArea, "StaticText_HitValue")
  self._ui_enchant.stc_defencePointArea = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "Static_DefenceStat")
  self._ui_enchant.txt_dpTitle = UI.getChildControl(self._ui_enchant.stc_defencePointArea, "StaticText_DPTitle")
  self._ui_enchant.txt_dodTitle = UI.getChildControl(self._ui_enchant.stc_defencePointArea, "StaticText_DodTitle")
  self._ui_enchant.txt_RedTitle = UI.getChildControl(self._ui_enchant.stc_defencePointArea, "StaticText_RedTitle")
  self._ui_enchant.txt_dpValue = UI.getChildControl(self._ui_enchant.stc_defencePointArea, "StaticText_DPValue")
  self._ui_enchant.txt_dodValue = UI.getChildControl(self._ui_enchant.stc_defencePointArea, "StaticText_DodValue")
  self._ui_enchant.txt_redValue = UI.getChildControl(self._ui_enchant.stc_defencePointArea, "StaticText_RedValue")
  self._ui_enchant.btn_tubalaExchange = UI.getChildControl(self._ui_enchant.stc_tubalaExchangeBg, "Button_Exchange")
  self._originTubalaExchangeBtnSizeX = self._ui_enchant.btn_tubalaExchange:GetSizeX()
  local slotTubala = {}
  SlotItem.new(slotTubala, "Static_Item_Tubala_", 0, self._ui_enchant.stc_tubalaItemSlot, self._slotConfig)
  slotTubala:createChild()
  slotTubala.empty = true
  slotTubala:clearItem()
  slotTubala.border:SetSize(40, 40)
  slotTubala.border:SetPosX(0)
  slotTubala.border:SetPosY(0)
  self._slotTubala = slotTubala
  if true == _ContentsGroup_ChinaFontColor then
    self._ui_enchant.radio_enchantPerfect:SetFontColor(Defines.Color.C_FFFF9A38)
  end
  self._ui_enchant.txt_subTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.txt_subTitle:SetText(self._ui_enchant.txt_subTitle:GetText())
  self._ui_enchant.chk_enchantCron:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.chk_enchantCron:SetText(self._ui_enchant.chk_enchantCron:GetText())
  self._ui_enchant.chk_enchantDefenceFail:SetTextMode(__eTextMode_AutoWrap)
  self._ui_enchant.chk_enchantDefenceFail:SetText(self._ui_enchant.chk_enchantDefenceFail:GetText())
  self._originNakSpanY = self._ui_enchant.stc_resultNak:GetSpanSize().y
  self._originPanelSizeY = Panel_Window_StackExtraction_All:GetSizeY()
  self._originEnchantInfoSizeY = self._ui_enchant.stc_infoArea:GetSizeY()
  self._originEnchantButtonAreaPosY = self._ui_enchant.chk_skipAni:GetPosY()
  self._originEnchantInfoPosY = self._ui_enchant.stc_infoArea:GetPosY()
  self._originPanelPosY = Panel_Window_StackExtraction_All:GetPosY()
  self._ui_enchant.stc_StackSave:SetTextMode(__eTextMode_LimitText)
  self._ui_enchant.btn_stackChange:SetTextMode(__eTextMode_LimitText)
  self._ui_enchant.stc_StackSave:SetText(self._ui_enchant.stc_StackSave:GetText())
  self._ui_enchant.btn_stackChange:SetText(self._ui_enchant.btn_stackChange:GetText())
  UI.setLimitTextAndAddTooltip(self._ui_enchant.chk_enchantCron)
  self:registEventHandlerNew()
end
function PaGlobal_SpiritEnchant_All:controlLightStone_Init()
  UI.ASSERT_NAME(nil ~= self._ui_enchant.stc_imageArea, "self._ui_enchant.stc_imageArea is nil", "\235\176\149\234\183\156\235\130\152")
  self._ui_enchant.stc_lightStoneImage = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_Image_LightStone")
  self._ui_enchant.stc_lightStoneTopBg = UI.getChildControl(self._ui_enchant.stc_imageArea, "Static_TopBG_LightStone")
  self._ui_enchant.txt_lightStoneEnchantRate = UI.getChildControl(self._ui_enchant.stc_lightStoneImage, "StaticText_EnchantRate")
  local stc_equipSlot = UI.getChildControl(self._ui_enchant.stc_lightStoneImage, "Static_EquipSlot")
  local stc_wingCenter = UI.getChildControl(self._ui_enchant.stc_lightStoneImage, "Static_MiddleWing")
  local stc_wingBottom = UI.getChildControl(self._ui_enchant.stc_lightStoneImage, "Static_Bottom_Wing")
  local stc_wingTop = UI.getChildControl(self._ui_enchant.stc_lightStoneImage, "Static_TopWing")
  self._ui_enchant.lightStoneControlList = {
    [LightStoneControlType.Main] = {
      parent = stc_equipSlot,
      slotBg = stc_equipSlot,
      count = nil,
      empty = nil,
      slot = nil
    },
    [LightStoneControlType.Sub0] = {
      parent = stc_wingCenter,
      slotBg = UI.getChildControl(stc_wingCenter, "Static_Slot"),
      count = UI.getChildControl(stc_wingCenter, "StaticText_Count"),
      empty = nil,
      slot = nil
    },
    [LightStoneControlType.Sub1] = {
      parent = stc_wingBottom,
      slotBg = UI.getChildControl(stc_wingBottom, "Static_Slot"),
      count = UI.getChildControl(stc_wingBottom, "StaticText_Count"),
      empty = nil,
      slot = nil
    },
    [LightStoneControlType.Cron] = {
      parent = stc_wingTop,
      slotBg = UI.getChildControl(stc_wingTop, "Static_Slot"),
      count = UI.getChildControl(stc_wingTop, "StaticText_Count"),
      empty = nil,
      slot = nil
    }
  }
  for ii, info in pairs(self._ui_enchant.lightStoneControlList) do
    local slot = {}
    local slotConfig
    if ii == LightStoneControlType.Cron then
      slotConfig = self._slotConfig_count
    else
      slotConfig = self._slotConfig
    end
    SlotItem.new(slot, "EnchantAll_LightStone_Slot_" .. tostring(ii), 0, info.slotBg, slotConfig)
    slot:createChild()
    slot.empty = true
    slot:clearItem()
    slot.border:SetSize(44, 44)
    slot.border:SetPosX(0)
    slot.border:SetPosY(0)
    info.slot = slot
    info.empty = UI.getChildControl(info.slotBg, "Static_emptySlotIcon")
    Panel_Tooltip_Item_SetPosition(ii, slot, "Enchant_LightStone")
  end
  for ii = LightStoneControlType.Main, LightStoneControlType.Cron do
    local slot = self._ui_enchant.lightStoneControlList[ii].slot
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_SpiritEnchant_All:showLightStoneTooltip(" .. tostring(ii) .. ")")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_SpiritEnchant_All:hideLightStoneTooltip()")
  end
end
function PaGlobal_SpiritEnchant_All:registEventHandlerNew()
  if nil == Panel_Window_StackExtraction_All then
    return
  end
  if false == _ContentsGroup_EnchantRenewer then
    return
  end
  if nil ~= Panel_Window_AddStack_All then
    self._ui_enchant.btn_AddStack:addInputEvent("Mouse_LUp", "PaGloabl_AddStack_All_Open(" .. tostring(PaGlobal_AddStack_All._BG_TYPE._BG_BLACKSTONE) .. ")")
    self._ui_enchant.btn_AddStack_Valks:addInputEvent("Mouse_LUp", "PaGloabl_AddStack_All_Open(" .. tostring(PaGlobal_AddStack_All._BG_TYPE._BG_VALKS) .. ")")
  end
  self._ui_enchant.stc_StackSave:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_SaveStack()")
  self._ui_enchant.stc_StackSave:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_StackSaveTooltip(true)")
  self._ui_enchant.stc_StackSave:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_StackSaveTooltip(false)")
  self._ui_enchant.stc_blablaBg:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_RandomBlabla()")
  self._ui_enchant.txt_blablaText:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_RandomBlabla()")
  if false == self._isConsole then
    self._slotEquip.slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(true)")
    self._slotEquip.slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(false)")
    self._slotMateiralInfo[1].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(true)")
    self._slotMateiralInfo[1].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(false)")
    self._slotMateiralInfo[2].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(true)")
    self._slotMateiralInfo[2].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(false)")
    self._slotMateiralInfo[3].icon:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(true)")
    self._slotMateiralInfo[3].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(false)")
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    self._ui_enchant.stc_equipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(true)")
    self._ui_enchant.stc_equipSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_EquipSlotTooltip(false)")
    self._ui_enchant.stc_wingsInfo[1].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(true)")
    self._ui_enchant.stc_wingsInfo[1].slot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_MaterialTooltip(false)")
    self._ui_enchant.stc_wingsInfo[2].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(true)")
    self._ui_enchant.stc_wingsInfo[2].slot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_SubMaterialTooltip(false)")
    self._ui_enchant.stc_wingsInfo[3].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(true)")
    self._ui_enchant.stc_wingsInfo[3].slot:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_DefenceMaterialTooltip(false)")
  else
    self._ui_enchant.stc_equipSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_EquipSlotTooltip()")
    self._ui_enchant.stc_wingsInfo[1].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_MaterialTooltip()")
    self._ui_enchant.stc_wingsInfo[2].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_SubMaterialTooltip()")
    self._ui_enchant.stc_wingsInfo[3].slot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlePadEventX_SpiritEnchant_All_DefenceMaterialTooltip()")
  end
  self._ui_enchant.btn_tubalaExchange:addInputEvent("Mouse_LUp", "PaGlobalFunc_ExchangeTubala()")
  self._ui_enchant.btn_tubalaExchange:ActiveMouseEventEffect(true)
  self._ui_enchant.progress2_1:addInputEvent("Mouse_On", "HandleEventOnOut_SpiritEnchant_All_GuaranteeStackTooltip(true)")
  self._ui_enchant.progress2_1:addInputEvent("Mouse_Out", "HandleEventOnOut_SpiritEnchant_All_GuaranteeStackTooltip(false)")
end
function PaGlobal_SpiritEnchant_All:showGuaranteeEnchantBG(isShow)
  if isShow == true then
    self._ui_enchant.stc_blackSpiritCountBG:SetShow(true)
    if self._isConsole == true then
      self._ui_enchant.btn_AddStack:SetIgnore(true)
      self._ui_enchant.btn_AddStack_Valks:SetIgnore(true)
      self._ui_enchant.btn_showTriedStack:SetIgnore(true)
    end
    local bgTextControl = UI.getChildControl(self._ui_enchant.stc_blackSpiritCountBG, "MultilineText_1")
    if bgTextControl ~= nil then
      if self._isSafeLowProtectorItem == true then
        bgTextControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_USESTONE_DESC"))
      else
        bgTextControl:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ANVILOFANCIENT_MAX_DESC"))
      end
    end
  else
    self._ui_enchant.stc_blackSpiritCountBG:SetShow(false)
    if self._isConsole == true then
      self._ui_enchant.btn_AddStack:SetIgnore(false)
      self._ui_enchant.btn_AddStack_Valks:SetIgnore(false)
      self._ui_enchant.btn_showTriedStack:SetIgnore(false)
    end
  end
end
