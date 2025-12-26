function PaGlobal_SailorPresetManager_All:initialize()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._stc_titleBg = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_TitleBg")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Win_Close_PCUI")
  self._ui._btn_wikiGuide = UI.getChildControl(self._ui._stc_titleBg, "Button_WikiGuide")
  self._ui._stc_leftArea = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_LeftArea")
  self._ui._txt_shipName = UI.getChildControl(self._ui._stc_leftArea, "StaticText_ShipName")
  self._ui._txt_shipType = UI.getChildControl(self._ui._stc_leftArea, "StaticText_ShipType")
  self._ui._stc_shipImage = UI.getChildControl(self._ui._stc_leftArea, "Static_ShipImage")
  self._ui._btn_up = UI.getChildControl(self._ui._stc_shipImage, "Button_Up")
  self._ui._btn_down = UI.getChildControl(self._ui._stc_shipImage, "Button_Down")
  self._ui._txt_cabinPage = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Page")
  self._ui._btn_savePreset = UI.getChildControl(self._ui._stc_shipImage, "Button_Save")
  self._ui._txt_viceCaptain = UI.getChildControl(self._ui._stc_shipImage, "StaticText_ViceCaptain")
  self._ui._txt_sail = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Sail")
  self._ui._txt_steering = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Steering")
  self._ui._txt_fishing = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Fishing")
  self._ui._txt_deck = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Deck")
  self._ui._txt_cook = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Cook")
  self._ui._txt_cannon = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Cannon")
  self._ui._txt_cabin = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Cabin")
  self._ui._txt_fishing:SetShow(_ContentsGroup_EmployeeAutoFishing == true)
  self._ui._stc_selectSlot = UI.getChildControl(self._ui._stc_shipImage, "Static_SelectSlot")
  self._ui._txt_presetSlotCount = UI.getChildControl(self._ui._stc_shipImage, "StaticText_MemberCount")
  self._ui._txt_sailTitle = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Sail")
  self._ui._txt_cookTitle = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Cook")
  self._ui._txt_cannonTitle = UI.getChildControl(self._ui._stc_shipImage, "StaticText_Cannon")
  self._ui._stc_rightArea = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_RightArea")
  self._ui._txt_noSelect = UI.getChildControl(self._ui._stc_rightArea, "StaticText_NoSelect")
  self._ui._stc_sailorListBg = UI.getChildControl(self._ui._stc_rightArea, "Static_SailorListBg")
  self._ui._stc_employeeImage = UI.getChildControl(self._ui._stc_sailorListBg, "Static_SailorImageBg")
  self._ui._stc_image = UI.getChildControl(self._ui._stc_employeeImage, "Static_Image")
  self._ui._txt_level = UI.getChildControl(self._ui._stc_employeeImage, "StaticText_Level")
  self._ui._txt_employeeTitleName = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SailorTitleName")
  self._ui._stc_expProgressBG = UI.getChildControl(self._ui._stc_sailorListBg, "Static_EXPProgressBg")
  self._ui._progress2_exp = UI.getChildControl(self._ui._stc_sailorListBg, "Progress2_EXPProgress")
  self._ui._txt_expValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_EXPValue")
  self._ui._progress2_royalty = UI.getChildControl(self._ui._stc_sailorListBg, "Progress2_RoyaltyProgress")
  self._ui._txt_royaltyValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_RoyaltyValue")
  self._ui._txt_employeeState = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SailorState")
  self._ui._stc_employeeName = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SailorName")
  self._ui._stc_stateIcon1 = UI.getChildControl(self._ui._stc_sailorListBg, "Static_StateIcon1")
  self._ui._stc_stateIcon2 = UI.getChildControl(self._ui._stc_sailorListBg, "Static_StateIcon2")
  self._ui._chk_button1 = UI.getChildControl(self._ui._stc_sailorListBg, "CheckButton_1")
  self._ui._chk_button2 = UI.getChildControl(self._ui._stc_sailorListBg, "CheckButton_2")
  self._ui._chk_button3 = UI.getChildControl(self._ui._stc_sailorListBg, "CheckButton_3")
  self._ui._chk_button4 = UI.getChildControl(self._ui._stc_sailorListBg, "CheckButton_4")
  self._ui._chk_button5 = UI.getChildControl(self._ui._stc_sailorListBg, "CheckButton_5")
  self._ui._txt_foodTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_FoodTitle")
  self._ui._txt_costTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_NeedCountTitle")
  self._ui._txt_weightTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_WeightTitle")
  self._ui._txt_speedTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SpeedTitle")
  self._ui._txt_accelTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_AccelTitle")
  self._ui._txt_corneringTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_TurningTitle")
  self._ui._txt_brakeTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_BreakTitle")
  self._ui._txt_patienceTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_PatienceTitle")
  self._ui._txt_focusTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_FocusTitle")
  self._ui._txt_powerTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_PowerTitle")
  self._ui._txt_sightTitle = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SightTitle")
  self._ui._txt_foodValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_FoodValue")
  self._ui._txt_costValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_NeedCountValue")
  self._ui._txt_weightValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_WeightValue")
  self._ui._txt_speedValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SpeedValue")
  self._ui._txt_accelValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_AccelValue")
  self._ui._txt_corneringValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_TurningValue")
  self._ui._txt_breakValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_BreakValue")
  self._ui._txt_patienceValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_PatienceValue")
  self._ui._txt_focusValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_FocusValue")
  self._ui._txt_powerValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_PowerValue")
  self._ui._txt_sightValue = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_SightValue")
  self._ui._btn_fire = UI.getChildControl(self._ui._stc_sailorListBg, "Button_Fire")
  self._ui._btn_restore = UI.getChildControl(self._ui._stc_sailorListBg, "Button_Restore_PCUI")
  self._ui._txt_viceCaptainDesc = UI.getChildControl(self._ui._stc_sailorListBg, "StaticText_ViceCaptainDesc")
  self._ui._stc_bottomArea = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_BottomArea")
  self._ui._list2_employee = UI.getChildControl(self._ui._stc_bottomArea, "List2_SailorList")
  self._ui._btn_buyEmployeeSlot = UI.getChildControl(self._ui._stc_bottomArea, "Button_BuySailorSlot")
  self._ui._btn_restoreAll = UI.getChildControl(self._ui._stc_bottomArea, "Button_RestoreAll")
  self._ui._txt_sailorSlotCount = UI.getChildControl(self._ui._stc_bottomArea, "StaticText_SailorSlotCount")
  self._ui._combo_stat = UI.getChildControl(self._ui._stc_bottomArea, "Combobox2_Stat")
  self._ui._combo_statList = UI.getChildControl(self._ui._combo_stat, "Combobox2_1_List")
  self._ui._combo_type = UI.getChildControl(self._ui._stc_bottomArea, "Combobox2_Type")
  self._ui._combo_typeList = UI.getChildControl(self._ui._combo_type, "Combobox2_1_List")
  self._ui._stc_buttonArea = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_ButtonArea")
  self._ui._btn_unride = UI.getChildControl(self._ui._stc_buttonArea, "Button_Unride_PCUI")
  self._ui._btn_autoArrange = UI.getChildControl(self._ui._stc_buttonArea, "Button_AutoArrange")
  self._ui._btn_buyEmploeePreset = UI.getChildControl(self._ui._stc_buttonArea, "Button_PurchaseAdditional")
  self._ui._btn_editPresetName = UI.getChildControl(self._ui._stc_buttonArea, "Button_GroupOption")
  self._ui._stc_restoreItemBG = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_Restore_ItemBg_New")
  self._ui._btn_restoreClose = UI.getChildControl(self._ui._stc_restoreItemBG, "Button_RestoreClose")
  self._ui._stc_treatementBg = UI.getChildControl(self._ui._stc_restoreItemBG, "Static_TreatmentBg")
  self._ui._stc_recoveryBg = UI.getChildControl(self._ui._stc_restoreItemBG, "Static_RecoveryBg")
  self._ui._stc_keyGuideConsole = UI.getChildControl(Panel_Window_SailorPresetManager_All, "Static_KeyGuide_ConsoleUI")
  self._ui._btn_A = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._btn_B = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui._btn_X = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui._btn_Y = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui._btn_LsClick = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_LS_ConsoleUI")
  self._ui._btn_RsClick = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_RS_ConsoleUI")
  self._ui._btn_RtX = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_RT_X_ConsoleUI")
  self._ui._btn_RtY = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_RT_Y_ConsoleUI")
  self._ui._btn_LtA = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_LT_A_ConsoleUI")
  self._ui._btn_LtX = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_LT_X_ConsoleUI")
  self._ui._btn_LtY = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_LT_Y_ConsoleUI")
  self._ui._btn_LtRt = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_LT_RT_ConsoleUI")
  self._ui._btn_RSHorizontal = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_RSHri_ConsoleUI")
  self._ui._btn_RSVertical = UI.getChildControl(self._ui._stc_keyGuideConsole, "StaticText_KeyGuide_RSVer_ConsoleUI")
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._stc_keyGuideConsole:SetShow(true)
  else
    self._ui._stc_keyGuideConsole:SetShow(false)
  end
  self._presetSlotList = Array.new()
  for i = 0, self._eMaxPresetSlotCount do
    local slotTemplete = {
      _slotIndex = -1,
      _isActive = false,
      _isApply = false,
      _employeeNo = 0,
      _slotPresetJob = 0,
      _stc_control = nil,
      _stc_plus = nil,
      _stc_image = nil,
      _stc_progress = nil,
      _progressLoyalty = nil
    }
    slotTemplete._slotPresetJob = ToClient_getEmployeePresetSlotJob(i)
    slotTemplete._stc_control = UI.getChildControl(self._ui._stc_shipImage, "Static_ShipSlotBg_" .. i)
    slotTemplete._stc_plus = UI.getChildControl(slotTemplete._stc_control, "Static_Plus")
    slotTemplete._stc_image = UI.getChildControl(slotTemplete._stc_control, "Static_Image")
    slotTemplete._stc_progress = UI.getChildControl(slotTemplete._stc_control, "Static_LoyaltyProgressBg")
    slotTemplete._progressLoyalty = UI.getChildControl(slotTemplete._stc_control, "Progress2_RoyaltyProgress")
    slotTemplete._stc_control:SetIgnore(false)
    slotTemplete._stc_plus:SetIgnore(true)
    slotTemplete._stc_image:SetIgnore(true)
    slotTemplete._stc_progress:SetIgnore(true)
    slotTemplete._progressLoyalty:SetIgnore(true)
    slotTemplete._slotIndex = i
    self._presetSlotList:push_back(slotTemplete)
  end
  self._presetSlotTextList = Array.new()
  self._presetSlotTextList:push_back(self._ui._txt_viceCaptain)
  self._presetSlotTextList:push_back(self._ui._txt_sail)
  self._presetSlotTextList:push_back(self._ui._txt_deck)
  self._presetSlotTextList:push_back(self._ui._txt_steering)
  self._presetSlotTextList:push_back(self._ui._txt_cannon)
  self._presetSlotTextList:push_back(self._ui._txt_cook)
  self._presetSlotTextList:push_back(self._ui._txt_fishing)
  self._presetSlotTextList:push_back(self._ui._txt_cabin)
  local presetTitleButton = UI.getChildControl(self._ui._stc_buttonArea, "StaticText_GroupTitle")
  self._presetTitleOriginPosX = presetTitleButton:GetPosX()
  self._panelOriginPosY = Panel_Window_SailorPresetManager_All:GetPosY()
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  self:registerEventHandler()
  self:setPcControl()
  self:setConsoleControl()
  self:validate()
  self._initialize = true
end
function PaGlobal_SailorPresetManager_All:registerEventHandler()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._ui._list2_employee:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SailorPresetManager_All_UpdateEmployeeList")
  self._ui._list2_employee:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_Close()")
  self._ui._btn_savePreset:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_ClickSavePreset()")
  self._ui._btn_unride:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeeAll()")
  self._ui._btn_autoArrange:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_MakeRecommandEmployeePreset()")
  self._ui._btn_restoreAll:addInputEvent("Mouse_LUp", "PaGlobal_SailorRestore_All:prepareOpen()")
  self._ui._btn_buyEmployeeSlot:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_BuyEmployeeSlotItem()")
  self._ui._btn_buyEmploeePreset:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_BuyEmployeePresetItem()")
  self._ui._txt_viceCaptain:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,1)")
  self._ui._txt_viceCaptain:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_sail:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,2)")
  self._ui._txt_sail:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_steering:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,3)")
  self._ui._txt_steering:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_cannon:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,4)")
  self._ui._txt_cannon:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_deck:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,5)")
  self._ui._txt_deck:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_cook:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,6)")
  self._ui._txt_cook:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_cabin:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,7)")
  self._ui._txt_cabin:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._txt_fishing:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(true,8)")
  self._ui._txt_fishing:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_SimpleTooltip(false,0)")
  self._ui._combo_stat:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_ComboStat()")
  self._ui._combo_stat:GetListControl():SetIgnore(false)
  self._ui._combo_stat:GetListControl():AddSelectEvent("PaGlobalFunc_SailorPresetManager_All_SetComboStat()")
  self._ui._combo_type:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_ComboType()")
  self._ui._combo_type:GetListControl():SetIgnore(false)
  self._ui._combo_type:GetListControl():AddSelectEvent("PaGlobalFunc_SailorPresetManager_All_SetComboType()")
  self._ui._btn_up:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_ClickCabinUpButton()")
  self._ui._btn_down:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_ClickCabinDownButton()")
  self._ui._btn_fire:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_DoSailorFire()")
  self._ui._btn_restoreClose:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()")
  self._ui._btn_editPresetName:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_OpenEditPresetName()")
  local sailorInfoTitleList = {
    [self._infoType.SPEED] = self._ui._txt_speedTitle,
    [self._infoType.EXCEL] = self._ui._txt_accelTitle,
    [self._infoType.TURNING] = self._ui._txt_corneringTitle,
    [self._infoType.BRAKE] = self._ui._txt_brakeTitle,
    [self._infoType.PATIENCE] = self._ui._txt_patienceTitle,
    [self._infoType.POWER] = self._ui._txt_powerTitle,
    [self._infoType.FOCUS] = self._ui._txt_focusTitle,
    [self._infoType.SIGHT] = self._ui._txt_sightTitle
  }
  for index, control in ipairs(sailorInfoTitleList) do
    control:SetIgnore(false)
    control:SetEnable(true)
    control:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_InfoTitleTooltip(true, " .. index .. ")")
    control:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_InfoTitleTooltip(false, " .. index .. ")")
  end
  for i = 1, #self._presetSlotList do
    if self._presetSlotList[i] ~= nil then
      local slotIndex = i - 1
      if self._isPadSnapping == true then
        self._presetSlotList[i]._stc_control:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobalFunc_SailorPresetManager_All_SelectEmployeePresetSlot(" .. slotIndex .. ")")
        self._presetSlotList[i]._stc_control:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeePresetSlot(" .. slotIndex .. ")")
      else
        self._presetSlotList[i]._stc_control:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_SelectEmployeePresetSlot(" .. slotIndex .. ")")
        self._presetSlotList[i]._stc_control:addInputEvent("Mouse_RUp", "PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeePresetSlot(" .. slotIndex .. ")")
      end
      self._presetSlotList[i]._stc_control:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_PresetSlotSimpleTooltip(true, " .. i .. ")")
      self._presetSlotList[i]._stc_control:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_PresetSlotSimpleTooltip(false)")
    end
  end
  if self._isPadSnapping == true then
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_SailorPresetManager_All_Close()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobal_SailorRestore_All:prepareOpen()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PaGlobalFunc_SailorPresetManager_All_ClickSavePreset()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_SailorPresetManager_All_MakeRecommandEmployeePreset()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeeAll()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobalFunc_SailorPresetManager_All_OpenEditPresetName()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SailorPresetManager_All_MoveToComboStat()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobalFunc_SailorPresetManager_All_MoveToComboType()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "PaGlobalFunc_SailorPresetManager_All_DoSailorFire()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobalFunc_SailorPresetManager_All_MoveRsLeft()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobalFunc_SailorPresetManager_All_MoveRsRight()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "PaGlobalFunc_SailorPresetManager_All_ClickCabinUpButton()")
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "PaGlobalFunc_SailorPresetManager_All_ClickCabinDownButton()")
  end
  registerEvent("FromClient_SailorPresetManager_ResponseApplyEmployee", "FromClient_SailorPresetManager_ResponseApplyEmployee()")
  registerEvent("FromClient_SailorPresetManager_ResponseUnapplyEmployee", "FromClient_SailorPresetManager_ResponseUnapplyEmployee()")
  registerEvent("FromClient_SailorPresetManager_ApplyEmployeePresetAll", "FromClient_SailorPresetManager_ApplyEmployeePresetAll()")
  registerEvent("FromClient_SailorPresetManager_UnapplyEmployeeAll", "FromClient_SailorPresetManager_UnapplyEmployeeAll()")
  registerEvent("FromClient_EmployeeDeleteAck", "PaGlobalFunc_SailorPresetGroup_All_Delete()")
  registerEvent("FromClient_SailorPresetManager_ResponseUpdateEmployee", "PaGlobalFunc_SailorPresetGroup_All_EmployeeUpdate()")
  registerEvent("FromClient_SailorPresetManager_MakeRecommandEmployeePreset", "FromClient_SailorPresetManager_MakeRecommandEmployeePreset()")
  registerEvent("FromClient_SailorPresetManager_ResponseRecoveryEmployee", "FromClient_SailorPresetManager_ResponseRecoveryEmployee()")
  registerEvent("FromClient_EmployeeVarySlotAck", "FromClient_SailorPresetManager_EmployeeVarySlotAck")
  registerEvent("FromClient_SailorPresetManager_IncreaseEmployeePreset", "FromClient_SailorPresetManager_IncreaseEmployeePreset()")
end
function PaGlobal_SailorPresetManager_All:setPcControl()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  UI.setLimitTextAndAddTooltip(self._ui._btn_savePreset, self._ui._btn_savePreset:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._btn_restoreAll, self._ui._btn_restoreAll:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._btn_editPresetName, self._ui._btn_editPresetName:GetText(), "")
  self._ui._btn_buyEmploeePreset:SetSpanSize(200, self._ui._btn_buyEmploeePreset:GetSpanSize().y)
  local sailorListText = UI.getChildControl(self._ui._stc_bottomArea, "StaticText_SailorList")
  if sailorListText:GetPosX() + sailorListText:GetTextSizeX() > self._ui._txt_sailorSlotCount:GetPosX() then
    local diff = sailorListText:GetPosX() + sailorListText:GetTextSizeX() - self._ui._txt_sailorSlotCount:GetPosX() + 10
    self._ui._txt_sailorSlotCount:SetPosX(self._ui._txt_sailorSlotCount:GetPosX() + diff)
    self._ui._btn_buyEmployeeSlot:SetPosX(self._ui._btn_buyEmployeeSlot:GetPosX() + diff)
  end
end
function PaGlobal_SailorPresetManager_All:setConsoleControl()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  self._ui._btn_close:SetShow(false)
  self._ui._btn_savePreset:SetShow(false)
  self._ui._btn_unride:SetShow(false)
  self._ui._btn_autoArrange:SetShow(false)
  self._ui._btn_restore:SetShow(false)
  self._ui._btn_restoreAll:SetShow(false)
  self._ui._btn_fire:SetShow(false)
  self._ui._btn_editPresetName:SetShow(false)
  self._ui._combo_stat:SetSpanSize(230, self._ui._combo_stat:GetSpanSize().y)
  self._ui._combo_type:SetSpanSize(0, self._ui._combo_type:GetSpanSize().y)
  self._ui._btn_buyEmploeePreset:SetSpanSize(10, self._ui._btn_buyEmploeePreset:GetSpanSize().y)
end
function PaGlobal_SailorPresetManager_All:prepareOpen(isOnShip)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._employeeCount = ToClient_getEmployeeCount()
  if self._employeeCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_EMPTYEMPLOYEELIST"))
    return
  end
  self._isOnShip = isOnShip
  ToClient_makeDefaultPossibleEmployeeNoList()
  self:clearEmployeeInfoList()
  self:clearPresetSlotData(true)
  self:clearSelectControl()
  self._currentCabinPageCount = 1
  self._currentPresetButtonNum = 1
  self._ui._txt_cabinPage:SetText(self._currentCabinPageCount)
  self:setCurrentServantSlot()
  self:makeEmployeeInfoList()
  self:makeCurrentEmployeePreset()
  self:setCurrentEmployeePreset()
  self:createComboBox()
  self:filterAndSortPossibleEmployeeList()
  self:checkHideUiOnShip()
  self:setControl()
  if self._isPadSnapping == true then
    Panel_Dialog_ServantInfo_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    Panel_Dialog_ServantList_All:ignorePadSnapMoveToOtherPanelUpdate(true)
    ToClient_padSnapResetControl()
    ToClient_padSnapSetTargetPanel(Panel_Window_SailorPresetManager_All)
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    self:setConsoleKeyguide(self._keyguideState._noSelect)
  end
  self:open()
end
function PaGlobal_SailorPresetManager_All:open()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  Panel_Window_SailorPresetManager_All:SetShow(true)
end
function PaGlobal_SailorPresetManager_All:prepareClose()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._selectedEmployeeNo = 0
  self._selectedEmployeeIndex = -1
  self._selectedPresetSlot = nil
  self._selectedEmployeeAbility = nil
  self._selectedEmployeeType = nil
  self:clearEmployeeInfoList()
  self:clearPresetSlotData(true)
  if self._isPadSnapping == true then
    Panel_Dialog_ServantInfo_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    Panel_Dialog_ServantList_All:ignorePadSnapMoveToOtherPanelUpdate(false)
    ToClient_padSnapResetControl()
  end
  self:close()
end
function PaGlobal_SailorPresetManager_All:close()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  Panel_Window_SailorPresetManager_All:SetShow(false)
end
function PaGlobal_SailorPresetManager_All:setControl()
  if Panel_Window_SailorPresetManager_All == nil or Panel_Dialog_ServantInfo_All == nil then
    return
  end
  if self._isOnShip == false then
    local posX = Panel_Dialog_ServantInfo_All:GetPosX() - Panel_Window_SailorPresetManager_All:GetSizeX() - 15
    Panel_Window_SailorPresetManager_All:SetPosX(posX)
  else
    Panel_Window_SailorPresetManager_All:SetPosX((getScreenSizeX() - Panel_Window_SailorPresetManager_All:GetSizeX()) / 2)
  end
  local presetButtonTitle = UI.getChildControl(self._ui._stc_buttonArea, "StaticText_GroupTitle")
  local presetCount = ToClient_getEmployeePresetCount()
  local diffX = 0
  local diffX2 = 0
  local titleSpanX = 0
  local buttonSpanX = 0
  local titleOriginSpanX = 0
  local buttonOriginSpanX = 0
  if self._isPadSnapping == true then
    presetButtonTitle:SetSpanSize(0, presetButtonTitle:GetSpanSize().y)
    if presetButtonTitle:GetPosX() + presetButtonTitle:GetTextSizeX() > Panel_Window_SailorPresetManager_All:GetSizeX() then
      diffX = presetButtonTitle:GetPosX() + presetButtonTitle:GetTextSizeX() - Panel_Window_SailorPresetManager_All:GetSizeX() + 10
    end
    titleOriginSpanX = 0
    buttonOriginSpanX = 120
    presetButtonTitle:SetSpanSize(titleOriginSpanX + diffX, presetButtonTitle:GetSpanSize().y)
    if ToClient_isConsole() == true then
      local buttonEndPosX = presetButtonTitle:GetPosX() + 35 * presetCount
      if buttonEndPosX >= Panel_Window_SailorPresetManager_All:GetSizeX() then
        diffX2 = buttonEndPosX - Panel_Window_SailorPresetManager_All:GetSizeX() + 10
      end
    else
      local buttonEndPosX = presetButtonTitle:GetPosX() + 35 * presetCount
      if buttonEndPosX >= self._ui._btn_buyEmploeePreset:GetPosX() then
        diffX2 = buttonEndPosX - self._ui._btn_buyEmploeePreset:GetPosX() + 10
      end
    end
  else
    if self._presetTitleOriginPosX + presetButtonTitle:GetTextSizeX() > self._ui._btn_editPresetName:GetPosX() then
      diffX = self._presetTitleOriginPosX + presetButtonTitle:GetTextSizeX() - self._ui._btn_editPresetName:GetPosX() + 10
    end
    titleOriginSpanX = 160
    buttonOriginSpanX = 275
    presetButtonTitle:SetSpanSize(titleOriginSpanX + diffX, presetButtonTitle:GetSpanSize().y)
    local buttonEndPosX = presetButtonTitle:GetPosX() + 35 * presetCount
    if buttonEndPosX >= self._ui._btn_buyEmploeePreset:GetPosX() then
      diffX2 = buttonEndPosX - self._ui._btn_buyEmploeePreset:GetPosX() + 10
    end
  end
  presetButtonTitle:SetSpanSize(titleOriginSpanX + diffX + diffX2, presetButtonTitle:GetSpanSize().y)
  buttonSpanX = buttonOriginSpanX + diffX + diffX2
  for ii = 1, presetCount do
    local presetButton = UI.getChildControl(self._ui._stc_buttonArea, "Button_Group_" .. ii)
    presetButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_ApplyEmployeePreset(" .. ii .. ")")
    presetButton:addInputEvent("Mouse_On", "PaGlobalFunc_SailorPresetManager_All_ShowPresetNameTooltip(true," .. ii .. ")")
    presetButton:addInputEvent("Mouse_Out", "PaGlobalFunc_SailorPresetManager_All_ShowPresetNameTooltip(false," .. ii .. ")")
    presetButton:SetSpanSize(buttonSpanX - 35 * (ii - 1), presetButton:GetSpanSize().y)
    presetButton:SetShow(true)
  end
  self._ui._txt_noSelect:SetShow(true)
  self._ui._stc_sailorListBg:SetShow(false)
  self._ui._stc_restoreItemBG:SetShow(false)
end
function PaGlobal_SailorPresetManager_All:makeEmployeeInfoList()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._employeeCount = ToClient_getEmployeeCount()
  if self._employeeCount <= 0 then
    return
  end
  for index = 0, self._employeeCount - 1 do
    local employeeWrapper = ToClient_getEmployeeWrapperByIndex(index)
    if employeeWrapper ~= nil then
      local employeeKey = employeeWrapper:getEmployeeKey()
      if employeeKey:isDefined() == true then
        local employeeInfoTemplate = {
          _employeeKey = employeeKey,
          _level = employeeKey:getLevel(),
          _name = employeeWrapper:getEmployeeName(),
          _loyalty = employeeWrapper:getLoyalty(),
          _maxLoyalty = employeeWrapper:getMaxLoyalty(),
          _expRate = employeeWrapper:getExperienceRate(),
          _royalRate = employeeWrapper:getLoyaltyRate(),
          _isApply = employeeWrapper:isApply(),
          _state = employeeWrapper:getState(),
          _employeeType = employeeWrapper:getEmployeeType(),
          _employeeNo = employeeWrapper:getEmployeeNo(),
          _onServantNo = employeeWrapper:getVariousNo(),
          _resSeaCurrent = employeeWrapper:getValue(__eEmployeeAbility_Resist_OceanCurrent),
          _resSeaWind = employeeWrapper:getValue(__eEmployeeAbility_Resist_WindDirection),
          _resFood = employeeWrapper:getValue(__eEmployeeAbility_Resist_Food),
          _resLoyalty = employeeWrapper:getValue(__eEmployeeAbility_Resist_Loyalty),
          _speed = employeeWrapper:getValue(__eEmployeeAbility_Servant_Speed),
          _accel = employeeWrapper:getValue(__eEmployeeAbility_Servant_Acceleration),
          _turning = employeeWrapper:getValue(__eEmployeeAbility_Servant_Cornering),
          _break = employeeWrapper:getValue(__eEmployeeAbility_Servant_Brake),
          _cannonCoolTime = employeeWrapper:getValue(__eEmployeeAbility_Servant_CannonCoolTime),
          _cannonAccuracy = employeeWrapper:getValue(__eEmployeeAbility_Servant_CannonAccuracy),
          _cannonMaxLength = employeeWrapper:getValue(__eEmployeeAbility_Servant_CannonMaxLength),
          _cannonMaxAngle = employeeWrapper:getValue(__eEmployeeAbility_Servant_CannonMaxAngle),
          _cost = employeeWrapper:getCost(),
          _foodConsume = employeeWrapper:getFoodConsume(),
          _bodyWeight = employeeWrapper:getBodyWeight(),
          _iconPath = employeeWrapper:getIconPath(),
          _isViceCaptain = employeeWrapper:getJob() == __eEmployeeJob_ViceCaptain,
          _presetJob = employeeWrapper:getPresetJob(),
          _characterKey = employeeWrapper:getCharacterKey()
        }
        self._employeeInfoList[index] = employeeInfoTemplate
      end
    end
  end
  local filterEmployeeCount = ToClient_getPossibleEmployeeNoListSize()
  local rowCount = math.floor(filterEmployeeCount / self._eMaxEmployeeRowSlotCount)
  for i = 0, rowCount do
    self._ui._list2_employee:getElementManager():pushKey(toInt64(0, i))
  end
  local employeeMaxSlotCount = ToClient_getEmployeeMaxSlotCount()
  self._ui._txt_sailorSlotCount:SetText(filterEmployeeCount .. "/" .. employeeMaxSlotCount)
end
function PaGlobal_SailorPresetManager_All:updateEmployeeInfo(employeeNo)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  for index = 0, self._employeeCount - 1 do
    local employeeWrapper = ToClient_getEmployeeWrapperByIndex(index)
    if employeeWrapper ~= nil and self._employeeInfoList[index] ~= nil and self._employeeInfoList[index]._employeeNo == employeeNo and employeeWrapper:getEmployeeNo() == employeeNo then
      self._employeeInfoList[index]._loyalty = employeeWrapper:getLoyalty()
      self._employeeInfoList[index]._maxLoyalty = employeeWrapper:getMaxLoyalty()
      self._employeeInfoList[index]._expRate = employeeWrapper:getExperienceRate()
      self._employeeInfoList[index]._royalRate = employeeWrapper:getLoyaltyRate()
      self._employeeInfoList[index]._isApply = employeeWrapper:isApply()
      self._employeeInfoList[index]._state = employeeWrapper:getState()
      self._employeeInfoList[index]._onServantNo = employeeWrapper:getVariousNo()
      self._employeeInfoList[index]._presetJob = employeeWrapper:getPresetJob()
    end
  end
end
function PaGlobal_SailorPresetManager_All:updateEmployeeInfoAll()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  for index = 0, self._employeeCount - 1 do
    local employeeWrapper = ToClient_getEmployeeWrapperByIndex(index)
    if employeeWrapper ~= nil then
      local employeeKey = employeeWrapper:getEmployeeKey()
      if employeeKey:isDefined() == true and self._employeeInfoList[index] ~= nil then
        self._employeeInfoList[index]._loyalty = employeeWrapper:getLoyalty()
        self._employeeInfoList[index]._maxLoyalty = employeeWrapper:getMaxLoyalty()
        self._employeeInfoList[index]._expRate = employeeWrapper:getExperienceRate()
        self._employeeInfoList[index]._royalRate = employeeWrapper:getLoyaltyRate()
        self._employeeInfoList[index]._isApply = employeeWrapper:isApply()
        self._employeeInfoList[index]._state = employeeWrapper:getState()
        self._employeeInfoList[index]._onServantNo = employeeWrapper:getVariousNo()
        self._employeeInfoList[index]._presetJob = employeeWrapper:getPresetJob()
      end
    end
  end
end
function PaGlobal_SailorPresetManager_All:clearEmployeeInfoList()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  for index = 0, #self._employeeInfoList do
    self._employeeInfoList[index] = nil
  end
  self._ui._list2_employee:getElementManager():clearKey()
end
function PaGlobal_SailorPresetManager_All:setCurrentServantSlot()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if currentServantWrapper == nil then
    return
  end
  local currentServantcharacterKeyRaw = currentServantWrapper:getCharacterKeyRaw()
  for i = 1, __eEmployeePresetJob_Count - 1 do
    local presetJobMaxCount = ToClient_getEmployeePresetJobCount(currentServantcharacterKeyRaw, i)
    local presetJobCount = 0
    if i == __eEmployeePresetJob_Cabin then
      presetJobCount = (self._currentCabinPageCount - 1) * self._cabinSlotMaxCount
    end
    for ii = 1, #self._presetSlotList do
      local presetSlot = self._presetSlotList[ii]
      if presetSlot._slotPresetJob == i then
        if presetJobMaxCount > presetJobCount then
          presetSlot._isActive = true
          presetSlot._stc_control:SetShow(true)
          presetJobCount = presetJobCount + 1
        else
          presetSlot._isActive = false
          presetSlot._stc_control:SetShow(false)
        end
      end
      if _ContentsGroup_EmployeeAutoFishing == false and presetSlot._slotPresetJob == __eEmployeePresetJob_Fishing then
        presetSlot._isActive = false
        presetSlot._stc_control:SetShow(false)
      end
    end
    if presetJobMaxCount == 0 then
      self._presetSlotTextList[i]:SetShow(false)
    else
      self._presetSlotTextList[i]:SetShow(true)
    end
  end
  ToClient_setEmployeePresetServant(currentServantWrapper:getServantNo())
  local shipTypeStr = currentServantWrapper:getDisplayName()
  if shipTypeStr == nil then
    shipTypeStr = ""
  end
  local creatorName = currentServantWrapper:getCreatorNickname()
  if creatorName ~= nil or creatorName ~= "" then
    shipTypeStr = shipTypeStr .. "(" .. (PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_MADEBY_TITLE") .. " : " .. creatorName) .. ")"
  end
  self._ui._txt_shipName:SetText(currentServantWrapper:getName())
  self._ui._txt_shipType:SetText(shipTypeStr)
  local sailMaxCount = ToClient_getEmployeePresetJobCount(currentServantcharacterKeyRaw, __eEmployeePresetJob_Sail)
  local cookMaxCount = ToClient_getEmployeePresetJobCount(currentServantcharacterKeyRaw, __eEmployeePresetJob_Cook)
  local cannonMaxCount = ToClient_getEmployeePresetJobCount(currentServantcharacterKeyRaw, __eEmployeePresetJob_CannonSlot)
  local sailPresetArray = Array.new()
  local cookPresetArray = Array.new()
  local cannonPresetArray = Array.new()
  for ii = 1, #self._presetSlotList do
    local presetSlot = self._presetSlotList[ii]
    if presetSlot._isActive == true then
      if presetSlot._slotPresetJob == __eEmployeePresetJob_Sail then
        sailPresetArray:push_back(presetSlot._stc_control)
      elseif presetSlot._slotPresetJob == __eEmployeePresetJob_Cook then
        cookPresetArray:push_back(presetSlot._stc_control)
      elseif presetSlot._slotPresetJob == __eEmployeePresetJob_CannonSlot then
        cannonPresetArray:push_back(presetSlot._stc_control)
      end
    end
  end
  local startPoxX = self._ui._txt_sailTitle:GetPosX() + self._ui._txt_sailTitle:GetSizeX() / 2 - sailMaxCount * 55 / 2
  for i = 1, sailMaxCount do
    sailPresetArray[i]:SetPosX(startPoxX)
    startPoxX = startPoxX + 55
  end
  startPoxX = self._ui._txt_cookTitle:GetPosX() + self._ui._txt_cookTitle:GetSizeX() / 2 - cookMaxCount * 55 / 2
  for i = 1, cookMaxCount do
    cookPresetArray[i]:SetPosX(startPoxX)
    startPoxX = startPoxX + 55
  end
  startPoxX = self._ui._txt_cannonTitle:GetPosX() + self._ui._txt_cannonTitle:GetSizeX() / 2 - cannonMaxCount * 55 / 2
  for i = 1, cannonMaxCount do
    cannonPresetArray[i]:SetPosX(startPoxX)
    startPoxX = startPoxX + 55
  end
end
function PaGlobal_SailorPresetManager_All:makeCurrentEmployeePreset()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if currentServantWrapper == nil then
    return
  end
  local currentServantNo = currentServantWrapper:getServantNo()
  ToClient_makeCurrentEmployeePreset(currentServantNo)
end
function PaGlobal_SailorPresetManager_All:setCurrentEmployeePreset()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._ui._stc_selectSlot:SetShow(false)
  for i = 1, #self._presetSlotList do
    local presetSlot = self._presetSlotList[i]
    if presetSlot._isActive == true then
      local presetIndex = i - 1
      if presetSlot._slotPresetJob == __eEmployeePresetJob_Cabin then
        presetIndex = presetIndex + (self._currentCabinPageCount - 1) * self._cabinSlotMaxCount
      end
      local currentPresetEmployeeNo = ToClient_getCurrentEmployeePresetEmployeeNo(presetIndex)
      if Int64toInt32(currentPresetEmployeeNo) ~= 0 and presetSlot._isApply == false then
        presetSlot._stc_image:ChangeTextureInfoNameAsync(self:getEmployeeIconPath(currentPresetEmployeeNo))
        presetSlot._stc_plus:SetShow(false)
        presetSlot._employeeNo = currentPresetEmployeeNo
        presetSlot._isApply = true
        local sailorInfo = PaGlobalFunc_SailorPresetManager_All_GetEmployeeInfo(currentPresetEmployeeNo)
        if sailorInfo ~= nil then
          presetSlot._stc_progress:SetShow(true)
          presetSlot._progressLoyalty:SetShow(true)
          presetSlot._progressLoyalty:SetProgressRate(sailorInfo._royalRate)
        end
        if currentPresetEmployeeNo == self._selectedEmployeeNo then
          self._ui._stc_selectSlot:SetPosXY(presetSlot._stc_control:GetPosX(), presetSlot._stc_control:GetPosY())
          self._ui._stc_selectSlot:SetShow(true)
        end
      end
    end
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if currentServantWrapper == nil then
    return
  end
  local vehicleActorWrapper = getVehicleActor(currentServantWrapper:getActorKeyRaw())
  if vehicleActorWrapper == nil then
    return
  end
  local currentServantcharacterKeyRaw = currentServantWrapper:getCharacterKeyRaw()
  local presetSlotCountString = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_COSTCOUNT", "currentCount", vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Employee_Cost), "maxCount", currentServantWrapper:getEmployeeMaxCost())
  self._ui._txt_presetSlotCount:SetText(presetSlotCountString)
end
function PaGlobal_SailorPresetManager_All:clearPresetSlotData(clearPresetServant)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  for i = 1, #self._presetSlotList do
    local presetSlot = self._presetSlotList[i]
    presetSlot._isApply = false
    presetSlot._employeeNo = 0
    presetSlot._stc_image:ChangeTextureInfoNameAsync("")
    presetSlot._stc_plus:SetShow(true)
    presetSlot._stc_progress:SetShow(true)
    presetSlot._progressLoyalty:SetShow(false)
  end
  if clearPresetServant == true then
    ToClient_setEmployeePresetServant(0)
  end
end
function PaGlobal_SailorPresetManager_All:getEmployeeIconPath(employeeNo)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if #self._employeeInfoList < 0 then
    return ""
  end
  for i = 0, #self._employeeInfoList do
    if self._employeeInfoList[i]._employeeNo == employeeNo then
      return self._employeeInfoList[i]._iconPath
    end
  end
end
function PaGlobal_SailorPresetManager_All:clearSelectControl()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._ui._stc_selectSlot:SetShow(false)
  local filterEmployeeCount = ToClient_getPossibleEmployeeNoListSize()
  local rowCount = math.floor(filterEmployeeCount / self._eMaxEmployeeRowSlotCount)
  for i = 0, rowCount do
    local content = self._ui._list2_employee:GetContentByKey(toInt64(0, i))
    if content == nil then
      return
    end
    local stc_select = UI.getChildControl(content, "Static_Select")
    stc_select:SetShow(false)
    stc_select:SetIgnore(true)
  end
end
function PaGlobal_SailorPresetManager_All:selectEmployeeBottomArea(selectedEmployeeIndex)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if selectedEmployeeIndex == nil then
    selectedEmployeeIndex = -1
  end
  local filterEmployeeCount = ToClient_getPossibleEmployeeNoListSize()
  local rowCount = math.floor(filterEmployeeCount / self._eMaxEmployeeRowSlotCount)
  for i = 0, rowCount do
    local content = self._ui._list2_employee:GetContentByKey(toInt64(0, i))
    if content ~= nil then
      local stc_select = UI.getChildControl(content, "Static_Select")
      stc_select:SetIgnore(true)
      local selectedContentKey = math.floor(selectedEmployeeIndex / self._eMaxEmployeeRowSlotCount)
      if i == selectedContentKey then
        local employeeNo = ToClient_getPossibleEmployeeNoByIndex(selectedEmployeeIndex)
        if self._selectedEmployeeNo == employeeNo then
          stc_select:SetShow(false)
          self._selectedEmployeeIndex = -1
        else
          self._selectedEmployeeIndex = selectedEmployeeIndex
          local controlIndex = selectedEmployeeIndex % self._eMaxEmployeeRowSlotCount + 1
          local stc_employee = UI.getChildControl(content, "Static_SailorSlotBg_" .. controlIndex)
          local stc_select = UI.getChildControl(content, "Static_Select")
          if stc_employee ~= nil and stc_select ~= nil then
            stc_select:SetPosX(stc_employee:GetPosX())
            stc_select:SetShow(true)
          end
        end
      elseif selectedEmployeeIndex == -1 then
        self._selectedEmployeeIndex = -1
        stc_select:SetShow(false)
      else
        stc_select:SetShow(false)
      end
    end
  end
end
function PaGlobal_SailorPresetManager_All:updateSelectEmployee(employeeNo)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if self._selectedEmployeeNo == employeeNo or employeeNo == 0 then
    self._ui._stc_selectSlot:SetShow(false)
    self._ui._txt_noSelect:SetShow(true)
    self._ui._stc_sailorListBg:SetShow(false)
    self._selectedEmployeeNo = 0
    if self._isPadSnapping == true then
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      self:setConsoleKeyguide(self._keyguideState._noSelect)
    end
    return
  end
  local presetSlot = PaGlobalFunc_SailorPresetManager_All_GetEmployeePresetInfo(employeeNo)
  if presetSlot ~= nil then
    self._ui._stc_selectSlot:SetPosXY(presetSlot._stc_control:GetPosX(), presetSlot._stc_control:GetPosY())
    self._ui._stc_selectSlot:SetShow(true)
  end
  self._ui._txt_noSelect:SetShow(false)
  self._ui._stc_sailorListBg:SetShow(true)
  self._selectedEmployeeNo = employeeNo
  local selectEmployeeData
  local selectEmployeeIndex = 0
  for i = 0, #self._employeeInfoList do
    if self._employeeInfoList[i]._employeeNo == employeeNo then
      selectEmployeeData = self._employeeInfoList[i]
      selectEmployeeIndex = i
      break
    end
  end
  if selectEmployeeData == nil then
    return
  end
  local isViceCaptain = selectEmployeeData._isViceCaptain
  self._ui._txt_level:SetShow(isViceCaptain == false)
  self._ui._txt_costTitle:SetShow(isViceCaptain == false)
  self._ui._txt_costValue:SetShow(isViceCaptain == false)
  self._ui._txt_speedTitle:SetShow(isViceCaptain == false)
  self._ui._txt_accelTitle:SetShow(isViceCaptain == false)
  self._ui._txt_corneringTitle:SetShow(isViceCaptain == false)
  self._ui._txt_brakeTitle:SetShow(isViceCaptain == false)
  self._ui._txt_patienceTitle:SetShow(isViceCaptain == false)
  self._ui._txt_focusTitle:SetShow(isViceCaptain == false)
  self._ui._txt_powerTitle:SetShow(isViceCaptain == false)
  self._ui._txt_sightTitle:SetShow(isViceCaptain == false)
  self._ui._txt_speedValue:SetShow(isViceCaptain == false)
  self._ui._txt_accelValue:SetShow(isViceCaptain == false)
  self._ui._txt_corneringValue:SetShow(isViceCaptain == false)
  self._ui._txt_breakValue:SetShow(isViceCaptain == false)
  self._ui._txt_patienceValue:SetShow(isViceCaptain == false)
  self._ui._txt_focusValue:SetShow(isViceCaptain == false)
  self._ui._txt_powerValue:SetShow(isViceCaptain == false)
  self._ui._txt_sightValue:SetShow(isViceCaptain == false)
  self._ui._stc_expProgressBG:SetShow(isViceCaptain == false)
  self._ui._progress2_exp:SetShow(isViceCaptain == false)
  self._ui._txt_expValue:SetShow(isViceCaptain == false)
  self._ui._txt_viceCaptainDesc:SetShow(isViceCaptain == true)
  self._ui._stc_image:ChangeTextureInfoNameAsync(selectEmployeeData._iconPath)
  self._ui._txt_level:SetText("Lv." .. selectEmployeeData._level)
  self._ui._txt_employeeTitleName:SetText("<" .. self:getEmployeeTypeName(selectEmployeeData._employeeType) .. ">")
  self._ui._progress2_exp:SetProgressRate(selectEmployeeData._expRate)
  self._ui._txt_expValue:SetText(tostring(selectEmployeeData._expRate) .. "%")
  self._ui._progress2_royalty:SetProgressRate(selectEmployeeData._royalRate)
  self._ui._txt_royaltyValue:SetText(selectEmployeeData._loyalty .. " / " .. selectEmployeeData._maxLoyalty)
  self._ui._stc_employeeName:SetText("Lv." .. selectEmployeeData._level .. " " .. selectEmployeeData._name)
  if selectEmployeeData._state == __eEmployeeState_Escape then
    self._ui._txt_employeeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_ESCAPE"))
  elseif selectEmployeeData._onServantNo ~= Defines.s64_const.s64_0 then
    local servantInfo = stable_getServantByServantNo(selectEmployeeData._onServantNo)
    if servantInfo ~= nil then
      if selectEmployeeData._isApply then
        self._ui._txt_employeeState:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_APPLY", "name", servantInfo:getName()))
      else
        self._ui._txt_employeeState:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EMPLOYEE_RIDE_UNAPPLY", "name", servantInfo:getName()))
      end
    else
      self._ui._txt_employeeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_BOARDING_ANOTHER_SHIP"))
    end
  else
    self._ui._txt_employeeState:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EMPLOYEE_STAY"))
  end
  UI.setLimitTextAndAddTooltip(self._ui._txt_employeeState, self._ui._txt_employeeState:GetText(), "")
  local str_AllWeight = makeWeightString(selectEmployeeData._bodyWeight, 1)
  local strWeight = str_AllWeight .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui._txt_foodValue:SetText(selectEmployeeData._foodConsume)
  self._ui._txt_costValue:SetText(selectEmployeeData._cost)
  self._ui._txt_weightValue:SetText(strWeight)
  self._ui._txt_speedValue:SetText(string.format("%.1f", selectEmployeeData._speed * 1.0E-4) .. "%")
  self._ui._txt_accelValue:SetText(string.format("%.1f", selectEmployeeData._accel * 1.0E-4) .. "%")
  self._ui._txt_corneringValue:SetText(string.format("%.1f", selectEmployeeData._turning * 1.0E-4) .. "%")
  self._ui._txt_breakValue:SetText(string.format("%.1f", selectEmployeeData._break * 1.0E-4) .. "%")
  self._ui._txt_patienceValue:SetText(string.format("%.1f", selectEmployeeData._cannonCoolTime * 1.0E-4) .. "%")
  self._ui._txt_focusValue:SetText(string.format("%.1f", selectEmployeeData._cannonAccuracy * 1.0E-4) .. "%")
  self._ui._txt_powerValue:SetText(string.format("%.1f", selectEmployeeData._cannonMaxLength * 1.0E-4) .. "%")
  self._ui._txt_sightValue:SetText(string.format("%.1f", selectEmployeeData._cannonMaxAngle * 1.0E-4) .. "%")
  if selectEmployeeData._isViceCaptain == true then
    local viceCaptainDescString = ""
    if selectEmployeeData._characterKey:get() == 62167 then
      viceCaptainDescString = PAGetString(Defines.StringSheet_GAME, "LUA_CAPTAIN_SAILOR_PRESET_SKILL_DESC_02")
    elseif selectEmployeeData._characterKey:get() == 62168 then
      viceCaptainDescString = PAGetString(Defines.StringSheet_GAME, "LUA_CAPTAIN_SAILOR_PRESET_SKILL_DESC_03")
    elseif selectEmployeeData._characterKey:get() == 62169 then
      viceCaptainDescString = PAGetString(Defines.StringSheet_GAME, "LUA_CAPTAIN_SAILOR_PRESET_SKILL_DESC_01")
    end
    self._ui._txt_viceCaptainDesc:SetText(viceCaptainDescString)
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  self._currentServantWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if self._currentServantWrapper == nil then
    return
  end
  local currentServantNo = self._currentServantWrapper:getServantNo()
  if selectEmployeeData._onServantNo == currentServantNo and selectEmployeeData._isApply == true then
    if selectEmployeeData._presetJob == __eEmployeePresetJob_Sail then
      self._ui._txt_speedValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._speed * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._speed * 1.0E-4) .. "%")
      self._ui._txt_accelValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._accel * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._accel * 1.0E-4) .. "%")
    elseif selectEmployeeData._presetJob == __eEmployeePresetJob_Helmsman then
      self._ui._txt_corneringValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._turning * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._turning * 1.0E-4) .. "%")
      self._ui._txt_breakValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._break * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._break * 1.0E-4) .. "%")
    elseif selectEmployeeData._presetJob == __eEmployeePresetJob_CannonSlot then
      self._ui._txt_focusValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._cannonAccuracy * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._cannonAccuracy * 1.0E-4) .. "%")
      self._ui._txt_powerValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._cannonMaxLength * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._cannonMaxLength * 1.0E-4) .. "%")
      self._ui._txt_sightValue:SetText("(+" .. string.format("%.1f", selectEmployeeData._cannonMaxAngle * 1.0E-4) .. "%" .. ") " .. string.format("%.1f", selectEmployeeData._cannonMaxAngle * 1.0E-4) .. "%")
    end
  end
  if __eEmployeeState_Escape == selectEmployeeData._state then
    self._ui._stc_stateIcon1:ChangeTextureInfoTextureIDAsync("Combine_Etc_CrewManagement_Condition_Situation_Disease")
  else
    self._ui._stc_stateIcon1:ChangeTextureInfoTextureIDAsync("Combine_Etc_CrewManagement_Condition_Situation_Health")
  end
  if Defines.s64_const.s64_0 ~= selectEmployeeData._onServantNo then
    self._ui._stc_stateIcon2:ChangeTextureInfoTextureIDAsync("Combine_Etc_CrewManagement_Status_Embarkation")
  else
    self._ui._stc_stateIcon2:ChangeTextureInfoTextureIDAsync("Combine_Etc_CrewManagement_Status_Standby")
  end
  self._ui._stc_stateIcon1:setRenderTexture(self._ui._stc_stateIcon1:getBaseTexture())
  self._ui._stc_stateIcon2:setRenderTexture(self._ui._stc_stateIcon2:getBaseTexture())
  HandleEventLUp_SailorPresetManager_All_SailorRestoreClose()
  if selectEmployeeData._state == __eEmployeeState_Escape then
    if self._isPadSnapping == false then
      self._ui._btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorPresetManager_All_SailorRestore(" .. selectEmployeeIndex .. "," .. __eEmployeeLoyalismType_resurrection .. ")")
    elseif self._isOnShip == false then
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SailorPresetManager_All_SailorRestore(" .. selectEmployeeIndex .. "," .. __eEmployeeLoyalismType_resurrection .. ")")
    end
  elseif self._isPadSnapping == false then
    self._ui._btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_SailorPresetManager_All_SailorRestore(" .. selectEmployeeIndex .. "," .. __eEmployeeLoyalismType_Loyalty .. ")")
  elseif self._isOnShip == false then
    Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SailorPresetManager_All_SailorRestore(" .. selectEmployeeIndex .. "," .. __eEmployeeLoyalismType_Loyalty .. ")")
  end
  if self._isPadSnapping == true then
    if self._selectBottomArea == true then
      self:setConsoleKeyguide(self._keyguideState._selectAndBottomArea)
    else
      self:setConsoleKeyguide(self._keyguideState._selectAndApply)
    end
  end
end
function PaGlobal_SailorPresetManager_All:createComboBox()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._ui._combo_stat:setListTextHorizonCenter()
  self._ui._combo_stat:DeleteAllItem()
  self._ui._combo_stat:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_TITLE"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_01"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_02"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_03"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_04"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_06"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_05"))
  self._ui._combo_stat:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_ABILITY_FILTER_07"))
  self._ui._combo_type:setListTextHorizonCenter()
  self._ui._combo_type:DeleteAllItem()
  self._ui._combo_type:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_CATEGORY_FILTER_TITLE"))
  for i = 0, 20 do
    local numString = tostring(i)
    if i < 10 then
      numString = "0" .. numString
    end
    self._ui._combo_type:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_CATEGORY_FILTER_" .. numString))
  end
  UI.setLimitTextAndAddTooltip(self._ui._combo_stat, self._ui._combo_stat:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._combo_type, self._ui._combo_type:GetText(), "")
  Panel_Window_SailorPresetManager_All:SetChildIndex(self._ui._combo_stat, 999)
  Panel_Window_SailorPresetManager_All:SetChildIndex(self._ui._combo_type, 999)
end
function PaGlobal_SailorPresetManager_All:getEmployeeAbility(comboIndex)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if comboIndex == 0 then
    return __eEmployeeAbility_Servant_Speed
  elseif comboIndex == 1 then
    return __eEmployeeAbility_Servant_Acceleration
  elseif comboIndex == 2 then
    return __eEmployeeAbility_Servant_Cornering
  elseif comboIndex == 3 then
    return __eEmployeeAbility_Servant_Brake
  elseif comboIndex == 4 then
    return __eEmployeeAbility_Servant_CannonAccuracy
  elseif comboIndex == 5 then
    return __eEmployeeAbility_Servant_CannonMaxLength
  elseif comboIndex == 6 then
    return __eEmployeeAbility_Servant_CannonMaxAngle
  end
end
function PaGlobal_SailorPresetManager_All:filterAndSortPossibleEmployeeList()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if self._selectedEmployeeType == nil then
    self._selectedEmployeeType = 0
  end
  if self._selectedEmployeeAbility == nil then
    self._selectedEmployeeAbility = __eEmployeeAbility_Count
  end
  ToClient_filterAndSortPossibleEmployeeNoList(self._selectedEmployeeType, self._selectedEmployeeAbility)
end
function PaGlobal_SailorPresetManager_All:checkHideUiOnShip()
  local isShowUi = self._isOnShip == false and ToClient_isConsole() == false
  local canBuyEmployeeSlot = ToClient_canBuyEmployeeSlot()
  local canBuyEmployeePreset = ToClient_getEmployeePresetCount() < ToClient_getEmployeePresetMaxCount()
  self._ui._btn_savePreset:SetShow(isShowUi)
  self._ui._btn_fire:SetShow(isShowUi)
  self._ui._btn_restore:SetShow(isShowUi)
  self._ui._btn_restoreAll:SetShow(isShowUi)
  self._ui._btn_buyEmployeeSlot:SetShow(isShowUi and canBuyEmployeeSlot)
  self._ui._btn_buyEmploeePreset:SetShow(isShowUi and canBuyEmployeePreset)
  if self._isPadSnapping == true then
    self._ui._btn_savePreset:SetShow(false)
    self._ui._btn_fire:SetShow(false)
    self._ui._btn_restore:SetShow(false)
    self._ui._btn_restoreAll:SetShow(false)
    if self._isOnShip == true then
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "")
    else
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobal_SailorRestore_All:prepareOpen()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PaGlobalFunc_SailorPresetManager_All_ClickSavePreset()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_RTPress, "PaGlobalFunc_SailorPresetManager_All_DoSailorFire()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobalFunc_SailorPresetManager_All_MakeRecommandEmployeePreset()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobalFunc_SailorPresetManager_All_UnapplyEmployeeAll()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobalFunc_SailorPresetManager_All_OpenEditPresetName()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "PaGlobalFunc_SailorPresetManager_All_MoveRsLeft()")
      Panel_Window_SailorPresetManager_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "PaGlobalFunc_SailorPresetManager_All_MoveRsRight()")
    end
  end
end
function PaGlobal_SailorPresetManager_All:getEmployeeTypeName(employeeType)
  if employeeType <= 0 or employeeType > 29 then
    _PA_ASSERT_NAME(false, "\236\132\160\236\155\144 type\236\157\180 \235\138\152\236\150\180\235\130\172\236\138\181\235\139\136\235\139\164. \237\149\180\235\139\185 \236\138\164\237\138\184\235\167\129 \235\140\128\236\157\145 \236\158\145\236\151\133\236\157\180 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
    return ""
  end
  if employeeType >= 24 and employeeType <= 29 then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAILORMANAGER_VICECAPTAIN")
  end
  local numString = tostring(employeeType)
  if employeeType < 10 then
    numString = "0" .. numString
  end
  return PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_PRESET_CATEGORY_FILTER_" .. numString)
end
function PaGlobal_SailorPresetManager_All:setConsoleKeyguide(state)
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  self._ui._btn_A:SetShow(false)
  self._ui._btn_B:SetShow(false)
  self._ui._btn_X:SetShow(false)
  self._ui._btn_Y:SetShow(false)
  self._ui._btn_LsClick:SetShow(false)
  self._ui._btn_RsClick:SetShow(false)
  self._ui._btn_RtX:SetShow(false)
  self._ui._btn_RtY:SetShow(false)
  self._ui._btn_LtA:SetShow(false)
  self._ui._btn_LtX:SetShow(false)
  self._ui._btn_LtY:SetShow(false)
  self._ui._btn_LtRt:SetShow(false)
  self._ui._btn_RSHorizontal:SetShow(false)
  self._ui._btn_RSVertical:SetShow(false)
  local keyGuideList = {}
  if state == self._keyguideState._noSelect then
    self._ui._btn_A:SetShow(true)
    self._ui._btn_B:SetShow(true)
    self._ui._btn_LsClick:SetShow(true)
    self._ui._btn_RsClick:SetShow(true)
    self._ui._btn_RtX:SetShow(true)
    self._ui._btn_RtY:SetShow(true)
    self._ui._btn_LtA:SetShow(true)
    self._ui._btn_LtX:SetShow(true)
    self._ui._btn_LtY:SetShow(true)
    self._ui._btn_LtRt:SetShow(true)
    self._ui._btn_RSHorizontal:SetShow(true)
    self._ui._btn_RSVertical:SetShow(true)
    self._ui._btn_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    if self._isOnShip == false then
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_LsClick,
        self._ui._btn_RsClick,
        self._ui._btn_RtX,
        self._ui._btn_RtY,
        self._ui._btn_LtA,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_LtRt,
        self._ui._btn_RSHorizontal,
        self._ui._btn_RSVertical
      }
    else
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_RSVertical
      }
    end
  elseif state == self._keyguideState._noSelectAndApply then
    self._ui._btn_A:SetShow(true)
    self._ui._btn_B:SetShow(true)
    self._ui._btn_X:SetShow(true)
    self._ui._btn_LsClick:SetShow(true)
    self._ui._btn_RsClick:SetShow(true)
    self._ui._btn_RtX:SetShow(true)
    self._ui._btn_RtY:SetShow(true)
    self._ui._btn_LtA:SetShow(true)
    self._ui._btn_LtX:SetShow(true)
    self._ui._btn_LtY:SetShow(true)
    self._ui._btn_LtRt:SetShow(true)
    self._ui._btn_RSHorizontal:SetShow(true)
    self._ui._btn_RSVertical:SetShow(true)
    self._ui._btn_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    if self._isOnShip == false then
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_X,
        self._ui._btn_LsClick,
        self._ui._btn_RsClick,
        self._ui._btn_RtX,
        self._ui._btn_RtY,
        self._ui._btn_LtA,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_LtRt,
        self._ui._btn_RSHorizontal,
        self._ui._btn_RSVertical
      }
    else
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_X,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_RSVertical
      }
    end
  elseif state == self._keyguideState._selectAndApply then
    self._ui._btn_A:SetShow(true)
    self._ui._btn_B:SetShow(true)
    self._ui._btn_X:SetShow(true)
    self._ui._btn_Y:SetShow(true)
    self._ui._btn_LsClick:SetShow(true)
    self._ui._btn_RsClick:SetShow(true)
    self._ui._btn_RtX:SetShow(true)
    self._ui._btn_RtY:SetShow(true)
    self._ui._btn_LtA:SetShow(true)
    self._ui._btn_LtX:SetShow(true)
    self._ui._btn_LtY:SetShow(true)
    self._ui._btn_LtRt:SetShow(true)
    self._ui._btn_RSHorizontal:SetShow(true)
    self._ui._btn_RSVertical:SetShow(true)
    self._ui._btn_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    if self._isOnShip == false then
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_X,
        self._ui._btn_Y,
        self._ui._btn_LsClick,
        self._ui._btn_RsClick,
        self._ui._btn_RtX,
        self._ui._btn_RtY,
        self._ui._btn_LtA,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_LtRt,
        self._ui._btn_RSHorizontal,
        self._ui._btn_RSVertical
      }
    else
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_X,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_RSVertical
      }
    end
  elseif state == self._keyguideState._selectAndNoApply or state == self._keyguideState._selectAndBottomArea then
    self._ui._btn_A:SetShow(true)
    self._ui._btn_B:SetShow(true)
    self._ui._btn_Y:SetShow(true)
    self._ui._btn_LsClick:SetShow(true)
    self._ui._btn_RsClick:SetShow(true)
    self._ui._btn_RtX:SetShow(true)
    self._ui._btn_RtY:SetShow(true)
    self._ui._btn_LtA:SetShow(true)
    self._ui._btn_LtX:SetShow(true)
    self._ui._btn_LtY:SetShow(true)
    self._ui._btn_LtRt:SetShow(true)
    self._ui._btn_RSHorizontal:SetShow(true)
    self._ui._btn_RSVertical:SetShow(true)
    if state == self._keyguideState._selectAndNoApply then
      self._ui._btn_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EMPLOYEE_SHIP_RIDE"))
    else
      self._ui._btn_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    end
    if self._isOnShip == false then
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_Y,
        self._ui._btn_LsClick,
        self._ui._btn_RsClick,
        self._ui._btn_RtX,
        self._ui._btn_RtY,
        self._ui._btn_LtA,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_LtRt,
        self._ui._btn_RSHorizontal,
        self._ui._btn_RSVertical
      }
    else
      keyGuideList = {
        self._ui._btn_A,
        self._ui._btn_B,
        self._ui._btn_LtX,
        self._ui._btn_LtY,
        self._ui._btn_RSVertical
      }
    end
  end
  if self._isOnShip == true then
    self._ui._btn_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    self._ui._btn_Y:SetShow(false)
    self._ui._btn_LsClick:SetShow(false)
    self._ui._btn_RsClick:SetShow(false)
    self._ui._btn_LtRt:SetShow(false)
    self._ui._btn_RtX:SetShow(false)
    self._ui._btn_RtY:SetShow(false)
    self._ui._btn_LtA:SetShow(false)
    self._ui._btn_RSHorizontal:SetShow(false)
  end
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuideConsole, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  if self._panelOriginPosY + Panel_Window_SailorPresetManager_All:GetSizeY() + self._ui._stc_keyGuideConsole:GetSizeY() > getScreenSizeY() then
    local diffY = self._panelOriginPosY + Panel_Window_SailorPresetManager_All:GetSizeY() + self._ui._stc_keyGuideConsole:GetSizeY() - getScreenSizeY() - 10
    Panel_Window_SailorPresetManager_All:SetPosY(self._panelOriginPosY - diffY)
  end
end
function PaGlobal_SailorPresetManager_All:validate()
  if Panel_Window_SailorPresetManager_All == nil then
    return
  end
  self._ui._stc_titleBg:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_wikiGuide:isValidate()
  self._ui._stc_leftArea:isValidate()
  self._ui._txt_shipName:isValidate()
  self._ui._txt_shipType:isValidate()
  self._ui._stc_shipImage:isValidate()
  self._ui._btn_up:isValidate()
  self._ui._btn_down:isValidate()
  self._ui._txt_cabinPage:isValidate()
  self._ui._btn_savePreset:isValidate()
  self._ui._txt_viceCaptain:isValidate()
  self._ui._txt_sail:isValidate()
  self._ui._txt_steering:isValidate()
  self._ui._txt_fishing:isValidate()
  self._ui._txt_deck:isValidate()
  self._ui._txt_cook:isValidate()
  self._ui._txt_cannon:isValidate()
  self._ui._txt_cabin:isValidate()
  self._ui._stc_selectSlot:isValidate()
  self._ui._txt_presetSlotCount:isValidate()
  self._ui._txt_sailTitle:isValidate()
  self._ui._txt_cookTitle:isValidate()
  self._ui._txt_cannonTitle:isValidate()
  self._ui._stc_rightArea:isValidate()
  self._ui._txt_noSelect:isValidate()
  self._ui._stc_sailorListBg:isValidate()
  self._ui._stc_employeeImage:isValidate()
  self._ui._stc_image:isValidate()
  self._ui._txt_level:isValidate()
  self._ui._txt_employeeTitleName:isValidate()
  self._ui._stc_expProgressBG:isValidate()
  self._ui._progress2_exp:isValidate()
  self._ui._txt_expValue:isValidate()
  self._ui._progress2_royalty:isValidate()
  self._ui._txt_royaltyValue:isValidate()
  self._ui._txt_employeeState:isValidate()
  self._ui._stc_employeeName:isValidate()
  self._ui._chk_button1:isValidate()
  self._ui._chk_button2:isValidate()
  self._ui._chk_button3:isValidate()
  self._ui._chk_button4:isValidate()
  self._ui._chk_button5:isValidate()
  self._ui._txt_foodTitle:isValidate()
  self._ui._txt_costTitle:isValidate()
  self._ui._txt_weightTitle:isValidate()
  self._ui._txt_speedTitle:isValidate()
  self._ui._txt_accelTitle:isValidate()
  self._ui._txt_corneringTitle:isValidate()
  self._ui._txt_brakeTitle:isValidate()
  self._ui._txt_patienceTitle:isValidate()
  self._ui._txt_focusTitle:isValidate()
  self._ui._txt_powerTitle:isValidate()
  self._ui._txt_sightTitle:isValidate()
  self._ui._txt_foodValue:isValidate()
  self._ui._txt_costValue:isValidate()
  self._ui._txt_weightValue:isValidate()
  self._ui._txt_speedValue:isValidate()
  self._ui._txt_accelValue:isValidate()
  self._ui._txt_corneringValue:isValidate()
  self._ui._txt_breakValue:isValidate()
  self._ui._txt_patienceValue:isValidate()
  self._ui._txt_focusValue:isValidate()
  self._ui._txt_powerValue:isValidate()
  self._ui._txt_sightValue:isValidate()
  self._ui._btn_fire:isValidate()
  self._ui._btn_restore:isValidate()
  self._ui._txt_viceCaptainDesc:isValidate()
  self._ui._stc_bottomArea:isValidate()
  self._ui._list2_employee:isValidate()
  self._ui._btn_restoreAll:isValidate()
  self._ui._btn_buyEmployeeSlot:isValidate()
  self._ui._combo_stat:isValidate()
  self._ui._combo_statList:isValidate()
  self._ui._combo_type:isValidate()
  self._ui._combo_typeList:isValidate()
  self._ui._txt_sailorSlotCount:isValidate()
  self._ui._stc_buttonArea:isValidate()
  self._ui._btn_unride:isValidate()
  self._ui._btn_autoArrange:isValidate()
  self._ui._btn_buyEmploeePreset:isValidate()
  self._ui._btn_editPresetName:isValidate()
  self._ui._stc_keyGuideConsole:isValidate()
  self._ui._btn_A:isValidate()
  self._ui._btn_B:isValidate()
  self._ui._btn_X:isValidate()
  self._ui._btn_Y:isValidate()
  self._ui._btn_LsClick:isValidate()
  self._ui._btn_RsClick:isValidate()
  self._ui._btn_RtX:isValidate()
  self._ui._btn_RtY:isValidate()
  self._ui._btn_LtA:isValidate()
  self._ui._btn_LtX:isValidate()
  self._ui._btn_LtY:isValidate()
  self._ui._btn_LtRt:isValidate()
  self._ui._btn_RSHorizontal:isValidate()
  self._ui._btn_RSVertical:isValidate()
end
