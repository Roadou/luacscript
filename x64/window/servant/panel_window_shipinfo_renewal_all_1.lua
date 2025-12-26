function PaGlobal_ShipInfo_Renewal_All:initialize()
  if true == PaGlobal_ShipInfo_Renewal_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_titieBG = UI.getChildControl(Panel_Window_ShipInfo_Renewal_All, "Static_TitleBg")
  self._ui.btn_close_PC = UI.getChildControl(self._ui.stc_titieBG, "Button_Win_Close_PCUI")
  self._ui.btn_question_PC = UI.getChildControl(self._ui.stc_titieBG, "Button_Question")
  self._ui._stc_KeyGuideBG = UI.getChildControl(Panel_Window_ShipInfo_Renewal_All, "Static_KeyGuide_Console")
  self._ui._txt_KeyGuideX = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_X_Console")
  self._ui._txt_KeyGuideLS = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_LS_Console")
  self._ui._txt_KeyGuideB = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_B_Console")
  self._ui._txt_KeyGuideLTX = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_KeyGuideLTX_Console")
  self._ui._txt_KeyGuideLTY = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_KeyGuideLTY_Console")
  self._ui._txt_KeyGuideLTA = UI.getChildControl(self._ui._stc_KeyGuideBG, "StaticText_KeyGuideLTA_Console")
  self._ui._txt_KeyGuideLS:SetShow(false)
  self._ui.stc_baseInfoGroup = UI.getChildControl(Panel_Window_ShipInfo_Renewal_All, "Static_BaseInfoGroup")
  self._ui.stc_basic_infoBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_BasicInfoBG")
  self._ui.txt_basic_ShipNameTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipName")
  self._ui.txt_basic_ShipName = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipNameValue")
  self._ui.txt_basic_ShipDPTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipDP")
  self._ui.txt_basic_ShipDP = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipDP_Value")
  self._ui.txt_basic_ShipHPTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipHP")
  self._ui.txt_basic_ShipHP = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipHP_Value")
  self._ui.txt_basic_WeightTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_Weight")
  self._ui.txt_basic_Weight = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_Weight_Value")
  self._ui.txt_basic_ShipType = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipTypeValue")
  self._ui.txt_creatorTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_MadeBy_Title")
  self._ui.txt_creatorName = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_MadeBy_Value")
  self._ui.txt_basic_CostTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_Cost")
  self._ui.txt_basic_Cost = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_Cost_Value")
  self._ui.txt_barterCountTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_BarterCountTitle")
  self._ui.txt_barterCount = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_BarterCount_Value")
  self._ui.txt_basic_DamageTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_Damage")
  self._ui.txt_basic_Damage = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_DamageValue")
  self._ui.txt_basic_ShipFoodTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipFood")
  self._ui.txt_basic_ShipFood = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipFood_Value")
  self._ui.btn_foodEmergency = UI.getChildControl(self._ui.stc_basic_infoBG, "Button_ShipFood_Emergency")
  self._ui.txt_cannonCountTitle = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_Cannon")
  self._ui.txt_cannonCount = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_CannonValue")
  self._ui.btn_cannonEmergency = UI.getChildControl(self._ui.stc_basic_infoBG, "Button_Cannon_Emergency")
  self._ui.stc_stat_Speed = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_Speed")
  self._ui.txt_basic_SpeedTitle = UI.getChildControl(self._ui.stc_stat_Speed, "StaticText_SpeedTitle")
  self._ui.txt_basic_Speed = UI.getChildControl(self._ui.stc_stat_Speed, "StaticText_SpeedValue")
  self._ui.stc_stat_Accel = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_Acceleration")
  self._ui.txt_basic_AccelTitle = UI.getChildControl(self._ui.stc_stat_Accel, "StaticText_AccelerationTitle")
  self._ui.txt_basic_Accel = UI.getChildControl(self._ui.stc_stat_Accel, "StaticText_AccelerationValue")
  self._ui.stc_stat_Cornering = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_CorneringSpeed")
  self._ui.txt_basic_CorneringTitle = UI.getChildControl(self._ui.stc_stat_Cornering, "StaticText_CorneringSpeedTitle")
  self._ui.txt_basic_Cornering = UI.getChildControl(self._ui.stc_stat_Cornering, "StaticText_CorneringSpeedValue")
  self._ui.stc_stat_Brake = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_Break")
  self._ui.txt_basic_BreakTitle = UI.getChildControl(self._ui.stc_stat_Brake, "StaticText_BreakTitle")
  self._ui.txt_basic_Break = UI.getChildControl(self._ui.stc_stat_Brake, "StaticText_BreakValue")
  self._ui.stc_stat_CannonCoolTime = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_CoolTime")
  self._ui.txt_basic_CannonCoolTimeTitle = UI.getChildControl(self._ui.stc_stat_CannonCoolTime, "StaticText_CoolTimeTitle")
  self._ui.txt_basic_CannonCoolTime = UI.getChildControl(self._ui.stc_stat_CannonCoolTime, "StaticText_CoolTimeValue")
  self._ui.stc_stat_CannonMaxLength = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_MaximumRange")
  self._ui.txt_basic_CannonMaxLengthTitle = UI.getChildControl(self._ui.stc_stat_CannonMaxLength, "StaticText_MaximumRangeTitle")
  self._ui.txt_basic_CannonMaxLength = UI.getChildControl(self._ui.stc_stat_CannonMaxLength, "StaticText_MaximumRangeValue")
  self._ui.stc_stat_CannonAccuracy = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_Accracy")
  self._ui.txt_basic_CannonAccuracyTitle = UI.getChildControl(self._ui.stc_stat_CannonAccuracy, "StaticText_AccuracyTitle")
  self._ui.txt_basic_CannonAccuracy = UI.getChildControl(self._ui.stc_stat_CannonAccuracy, "StaticText_AccuracyValue")
  self._ui.stc_stat_CannonMaxAngle = UI.getChildControl(self._ui.stc_basic_infoBG, "Static_Stat_Angle")
  self._ui.txt_basic_CannonMaxAngleTitle = UI.getChildControl(self._ui.stc_stat_CannonMaxAngle, "StaticText_AngleTitle")
  self._ui.txt_basic_CannonMaxAngle = UI.getChildControl(self._ui.stc_stat_CannonMaxAngle, "StaticText_AngleValue")
  self._ui.stc_basic_ShipInvenBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_ShipInvenBG")
  self._ui.stc_basic_ShipInven = UI.getChildControl(self._ui.stc_basic_ShipInvenBG, "Static_Inventory_BG")
  self._ui.stc_basic_ShipInvenSlot = UI.getChildControl(self._ui.stc_basic_ShipInven, "Static_ShipInventorySlot")
  self._ui.list_basic_ShipInven = UI.getChildControl(self._ui.stc_basic_ShipInven, "List2_1_VerticalScroll")
  self._ui.stc_basic_weightBG = UI.getChildControl(self._ui.stc_basic_ShipInvenBG, "Static_Weight")
  self._ui.progress_basic_weight = UI.getChildControl(self._ui.stc_basic_weightBG, "Progress2_WeightBar")
  self._ui.txt_basic_progressWeight = UI.getChildControl(self._ui.stc_basic_weightBG, "StaticText_WeightValue")
  self._ui.stc_weightGuide = UI.getChildControl(self._ui.stc_basic_weightBG, "Static_WeightGuide")
  self._ui.stc_alert = UI.getChildControl(self._ui.stc_basic_weightBG, "Static_Alert")
  self._ui.stc_basic_EquipSlot = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_EquipSlot")
  self._ui.btn_SailorManager = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Button_SailorManager")
  self._ui.btn_Upgrade = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Button_Upgrade")
  self._ui.stc_basic_SkillBG = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_SkillListBG")
  self._ui.list_basic_SkillList = UI.getChildControl(self._ui.stc_basic_SkillBG, "List2_SkillList")
  UI.setLimitTextAndAddTooltip(self._ui.btn_SailorManager)
  self._ui._statBarBg = {}
  self._ui._statBar = {}
  for index = 1, self._statType.Count - 1 do
    self._ui._statBarBg[index] = {}
    self._ui._statBar[index] = {}
    for barIndex = 1, self._config.statBarCount do
      if index == self._statType.Speed then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Speed, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Speed, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.Acceleration then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Accel, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Accel, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.CorneringSpeed then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Cornering, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Cornering, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.Brake then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Brake, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_Brake, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.CoolTime then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonCoolTime, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonCoolTime, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.MaximumRange then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonMaxLength, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonMaxLength, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.Accuracy then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonAccuracy, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonAccuracy, "Static_Point_" .. tostring(barIndex))
      elseif index == self._statType.Angle then
        self._ui._statBarBg[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonMaxAngle, "Static_PointBg_" .. tostring(barIndex))
        self._ui._statBar[index][barIndex] = UI.getChildControl(self._ui.stc_stat_CannonMaxAngle, "Static_Point_" .. tostring(barIndex))
      end
    end
  end
  self._ui._chk_goHome = UI.getChildControl(self._ui.stc_basic_EquipSlot, "CheckButton_GoHome")
  self._ui._stc_goHomeListArea = UI.getChildControl(Panel_Window_ShipInfo_Renewal_All, "Static_GoHomeListArea")
  self._ui._btn_homeTemplete = UI.getChildControl(self._ui._stc_goHomeListArea, "Button_Home_Template")
  local homeButtonCount = 0
  local buttonStartPos = -30
  local buttonGap = 5
  for i = 1, #self._homePositionList do
    local regionKeyRaw = self._homePositionList[i].regionKeyRaw
    local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
    local territoryKeyRaw = regionInfoWrapper:getTerritoryKeyRaw()
    if PaGlobal_WareHouse_All._territoryContentsOption ~= nil and PaGlobal_WareHouse_All._territoryContentsOption[territoryKeyRaw] == true then
      local homeButton = UI.createAndCopyBasePropertyControl(self._ui._stc_goHomeListArea, "Button_Home_Template", self._ui._stc_goHomeListArea, "button_home_" .. regionKeyRaw)
      homeButton:SetShow(true)
      homeButton:SetIgnore(false)
      homeButton:SetText(regionInfoWrapper:getAreaName())
      homeButton:addInputEvent("Mouse_LUp", "HandleEventLUp_ShipInfoRenewalAll_SelectHomeButton(" .. i .. ")")
      homeButton:SetPosXY(homeButton:GetPosX(), buttonStartPos + homeButton:GetSizeY())
      UI.setLimitTextAndAddTooltip(homeButton)
      buttonStartPos = homeButton:GetPosY() + 5
      homeButtonCount = homeButtonCount + 1
    end
  end
  local homeListSizeY = homeButtonCount * self._ui._btn_homeTemplete:GetSizeY() + (homeButtonCount - 1) * buttonGap
  self._ui._stc_goHomeListArea:SetSize(self._ui._stc_goHomeListArea:GetSizeX(), homeListSizeY + 20)
  self:initLimitText()
  self._useStartSlot = inventorySlotNoUserStart()
  PaGlobal_ShipInfo_Renewal_All:basic_createSlots()
  PaGlobal_ShipInfo_Renewal_All:registerEventHandler()
  PaGlobal_ShipInfo_Renewal_All:validate()
  PaGlobal_ShipInfo_Renewal_All:setControlShow()
  local list2_contents = UI.getChildControl(self._ui.list_basic_SkillList, "List2_1_Content")
  local stc_skillName = UI.getChildControl(list2_contents, "Static_SkillName")
  local txt_skillName = UI.getChildControl(stc_skillName, "StaticText_ShipName")
  self._skillNameBaseSpanSizeX = txt_skillName:GetSpanSize().x
  PaGlobal_ShipInfo_Renewal_All._initialize = true
end
function PaGlobal_ShipInfo_Renewal_All:registerEventHandler()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  self._ui.list_basic_SkillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ShipInfoRenewalAll_CreateSkillList")
  self._ui.list_basic_SkillList:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    self._ui.btn_close_PC:addInputEvent("Mouse_LUp", "PaGlobal_ShipInfo_Renewal_All:prepareClose()")
    self._ui.btn_question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelServantinfo\" )")
    PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question_PC, "\"PanelServantinfo\"")
    UIScroll.InputEventByControl(self._ui.stc_basic_ShipInven, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven")
    UIScroll.InputEvent(self._ui.list_basic_ShipInven, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven")
    self._ui.txt_basic_ShipFood:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_ShipFoodTooltip(true)")
    self._ui.txt_basic_ShipFood:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_ShipFoodTooltip(false)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(true)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(false)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(" .. __eServantSupplyItemType_Food .. ")")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(true)")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(false)")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(" .. __eServantSupplyItemType_Cannon .. ")")
    self._ui.btn_Upgrade:addInputEvent("Mouse_LUp", "PaGlobalFunc_ShipInfoRenewalAll_ViewServantUpgrade()")
    self._ui.btn_SailorManager:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_Open(true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_weightGuide, true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_weightGuide, false)")
    self._ui.stc_alert:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_alert, true)")
    self._ui.stc_alert:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_alert, false)")
  else
    self._ui.btn_foodEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(true)")
    self._ui.btn_foodEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(false)")
    self._ui.btn_foodEmergency:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(" .. __eServantSupplyItemType_Food .. ")")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(true)")
    self._ui.btn_cannonEmergency:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(false)")
    self._ui.btn_cannonEmergency:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(" .. __eServantSupplyItemType_Cannon .. ")")
    self._ui.btn_Upgrade:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ShipInfoRenewalAll_ViewServantUpgrade()")
    self._ui.btn_SailorManager:addInputEvent("Mouse_LUp", "PaGlobalFunc_SailorPresetManager_All_Open(true)")
    Panel_Window_ShipInfo_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.txt_basic_progressWeight, true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_weightGuide, true)")
    self._ui.stc_weightGuide:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_weightGuide, false)")
    self._ui.stc_alert:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_alert, true)")
    self._ui.stc_alert:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(PaGlobal_ShipInfo_Renewal_All._ui.stc_alert, false)")
  end
  self._ui._chk_goHome:addInputEvent("Mouse_On", "PaGlobalFunc_ShipInfoRenewalAll_ShowGoHomeTooltip(true)")
  self._ui._chk_goHome:addInputEvent("Mouse_Out", "PaGlobalFunc_ShipInfoRenewalAll_ShowGoHomeTooltip(false)")
  self._ui._chk_goHome:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoRenewalAll_OpenGoHomeList()")
  registerEvent("FromClient_updateShipStat", "FromClient_ShipInfoRenewal_ShipStatChangedByBuff")
  registerEvent("FromClient_FinishRepairServantByViceCaptain", "FromClient_ShipInfoRenewal_ShipStatChangedByBuff")
  registerEvent("EventSelfPlayerRideOn", "FromClient_ShipInfoRenewal_ShipStatChangedByBuff")
  registerEvent("EventSelfPlayerRideOff", "FromClient_ShipInfoRenewal_ShipStatChangedByBuff")
  registerEvent("EventServantEquipItem", "FromClient_ShipInfoRenewal_ChangeEquipItem")
  registerEvent("EventServantEquipmentUpdate", "FromClient_ShipInfoRenewal_ChangeEquipItem")
  registerEvent("FromClient_InventoryUpdate", "FromClient_ShipInfoRenewal_UpdateItem")
  registerEvent("FromClient_ServantInventoryUpdate", "FromClient_ShipInfoRenewal_UpdateItem")
  registerEvent("FromClient_notifyShipWeakenItem", "FromClient_ShipInfoRenewal_notifyShipWeakenItem")
  registerEvent("FromClient_updateFood", "FromClient_ShipInfoRenewal_UpdateFoodStat")
  registerEvent("FromClient_UpdateCannonStatCount", "FromClient_ShipInfoRenewal_UpdateCannonStat")
end
function PaGlobal_ShipInfo_Renewal_All:basic_createSlots()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  for ii = 1, self._equipSlotMaxCount do
    self._equipSlotBG[ii] = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Static_ItemSlot" .. ii)
    self._equipSlotBG[ii]:SetShow(true)
    self._equipSlotCashBG[ii] = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Static_PearlItemSlot" .. ii)
    self._equipSlotCashBG[ii]:SetShow(true)
    self._equipSlotBGIcon[ii] = UI.getChildControl(self._equipSlotBG[ii], "Static_Icon_EuipType" .. ii)
    self._equipSlotCashBGIcon[ii] = UI.getChildControl(self._equipSlotCashBG[ii], "Static_Icon_EuipType" .. ii)
    local slot = {}
    SlotItem.new(slot, "Slot_ShipEquip_" .. ii, ii, self._equipSlotBG[ii], self._slotConfig)
    slot:createChild()
    local cashSlot = {}
    SlotItem.new(cashSlot, "Slot_ShipCashEquip_" .. ii, ii, self._equipSlotCashBG[ii], self._slotConfig)
    cashSlot:createChild()
    self._equipItemSlots[ii] = slot
    self._equipItemCashSlots[ii] = cashSlot
  end
  self._config.row = math.floor(self._config.CONST_COUNT / self._config.col)
  for ii = 0, self._config.CONST_COUNT - 1 do
    self._invenSlotBG[ii] = UI.createAndCopyBasePropertyControl(self._ui.stc_basic_ShipInven, "Static_ShipInventorySlot", self._ui.stc_basic_ShipInven, "Static_ShipInvenSlot_" .. ii)
    self._invenSlotBG[ii]:SetPosX(self._config.startPos + (self._config.size + self._config.gap) * (ii % self._config.col))
    self._invenSlotBG[ii]:SetPosY(self._config.startPos + (self._config.size + self._config.gap) * math.floor(ii / self._config.col))
    self._invenSlotBG[ii]:SetShow(false)
    local slot = {}
    SlotItem.new(slot, "Slot_ShipInven_" .. ii, ii, self._invenSlotBG[ii], self._slotConfig)
    slot:createChild()
    self._invenSlotBG[ii]:addInputEvent("Mouse_UpScroll", "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven(true)")
    self._invenSlotBG[ii]:addInputEvent("Mouse_DownScroll", "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven(false)")
    self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven(true)")
    self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven(false)")
    UIScroll.InputEventByControl(slot.icon, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven")
    self._invenItemSlots[ii] = slot
  end
  local notuseControl = UI.getChildControl(self._ui.stc_basic_EquipSlot, "Static_PearlItemSlot5")
  notuseControl:SetShow(false)
end
function PaGlobal_ShipInfo_Renewal_All:setControlShow()
  if false == _ContentsGroup_OceanCurrent then
    self._ui.txt_cannonCountTitle:SetShow(false)
    self._ui.txt_cannonCount:SetShow(false)
    self._ui.stc_basic_ShipInvenBG:SetSpanSize(self._ui.stc_basic_ShipInvenBG:GetSpanSize().x, self._ui.stc_basic_ShipInvenBG:GetSpanSize().y + 145)
    self._ui.list_basic_SkillList:SetSize(self._ui.list_basic_SkillList:GetSizeX(), self._ui.list_basic_SkillList:GetSizeY() - self._ui.list_basic_SkillList:GetSizeY() * 0.5 + 16)
    Panel_Window_ShipInfo_Renewal_All:SetSize(Panel_Window_ShipInfo_Renewal_All:GetSizeX(), Panel_Window_ShipInfo_Renewal_All:GetSizeY() - 141)
    Panel_Window_ShipInfo_Renewal_All:ComputePos()
  end
  if false == _ContentsGroup_Sailor then
    self._ui.txt_barterCountTitle:SetShow(false)
    self._ui.txt_barterCount:SetShow(false)
    self._ui.txt_basic_CostTitle:SetShow(false)
    self._ui.txt_basic_Cost:SetShow(false)
    self._ui.txt_basic_ShipFoodTitle:SetSpanSize(self._ui.txt_basic_CostTitle:GetSpanSize().x, self._ui.txt_basic_CostTitle:GetSpanSize().y)
    self._ui.txt_basic_ShipFood:SetSpanSize(self._ui.txt_basic_Cost:GetSpanSize().x, self._ui.txt_basic_Cost:GetSpanSize().y + 20)
    self._ui.btn_foodEmergency:SetSpanSize(self._ui.btn_foodEmergency:GetSpanSize().x, self._ui.txt_basic_ShipFood:GetSpanSize().y - 3)
    local decoLine = UI.getChildControl(self._ui.stc_baseInfoGroup, "Static_DecoLine")
    decoLine:SetShow(false)
  end
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.btn_close_PC:SetShow(false)
    self._ui.btn_question_PC:SetShow(false)
    self._ui._stc_KeyGuideBG:SetShow(true)
    self:setAlignKeyGuide()
  else
    self._ui._stc_KeyGuideBG:SetShow(false)
  end
  if true == _ContentsOption_CH_Help then
    self._ui.btn_question_PC:SetShow(false)
  end
end
function PaGlobal_ShipInfo_Renewal_All:setAlignKeyGuide()
  local keyGuides = {
    self._ui._txt_KeyGuideLTY,
    self._ui._txt_KeyGuideLTA,
    self._ui._txt_KeyGuideLTX,
    self._ui._txt_KeyGuideLS,
    self._ui._txt_KeyGuideX,
    self._ui._txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ShipInfo_Renewal_All:basic_Update()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  PaGlobal_ShipInfo_Renewal_All:updateShipInformation()
  PaGlobal_ShipInfo_Renewal_All:updateShipStat()
  PaGlobal_ShipInfo_Renewal_All:updateCannonStat()
  PaGlobal_ShipInfo_Renewal_All:updateStatBar()
  PaGlobal_ShipInfo_Renewal_All:updateShipEquipment()
  PaGlobal_ShipInfo_Renewal_All:updateShipSkill()
  PaGlobal_ShipInfo_Renewal_All:updateShipInventory()
end
function PaGlobal_ShipInfo_Renewal_All:updateShipInformation()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if vehicleActorWrapper == nil then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if vehicleActor == nil then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if vehicleActor:isGuildVehicle() == true then
    servantWrapper = guildStable_getServantByServantNo(servantWrapper:getServantNo())
  end
  if servantWrapper == nil then
    return
  end
  local staticText = UI.getChildControl(self._ui.stc_basic_infoBG, "StaticText_ShipFood")
  local vehicleType = servantWrapper:getVehicleType()
  local characterKey = vehicleActorWrapper:getCharacterKey()
  local isFood = false
  self._ui.txt_basic_ShipFood:SetIgnore(true)
  if true == _ContentsGroup_OceanCurrent then
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      staticText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME"))
      self._ui.txt_basic_ShipFood:SetIgnore(false)
      isFood = true
    else
      staticText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
    end
    if self._isBigShip == true then
      self._ui.btn_question_PC:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"Big_Ship\" )")
      PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question_PC, "\"Big_Ship\"")
    end
  elseif CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
    staticText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_SHIPINFO_MP"))
  else
    staticText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
  end
  self._ui.txt_basic_ShipFood:ComputePos()
  self._ui.txt_cannonCount:ComputePos()
  if false == isFood then
    if true == self._isConsole then
      self._ui._txt_KeyGuideLTY:SetShow(false)
      self._ui._txt_KeyGuideLTA:SetShow(false)
      self:setAlignKeyGuide()
      Panel_Window_ShipInfo_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
      Panel_Window_ShipInfo_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
    else
      self._ui.btn_foodEmergency:SetShow(false)
      self._ui.btn_cannonEmergency:SetShow(false)
    end
  elseif true == self._isConsole then
    self._ui._txt_KeyGuideLTY:SetShow(true)
    self._ui._txt_KeyGuideLTA:SetShow(true)
    self:setAlignKeyGuide()
    Panel_Window_ShipInfo_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(" .. __eServantSupplyItemType_Food .. ")")
    Panel_Window_ShipInfo_Renewal_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(" .. __eServantSupplyItemType_Cannon .. ")")
  else
    self._ui.txt_basic_ShipFood:SetPosX(self._ui.txt_basic_ShipFood:GetPosX() - self._ui.btn_foodEmergency:GetSizeX() - 10)
    self._ui.txt_cannonCount:SetPosX(self._ui.txt_cannonCount:GetPosX() - self._ui.btn_cannonEmergency:GetSizeX() - 10)
    self._ui.btn_foodEmergency:SetShow(true)
    self._ui.btn_cannonEmergency:SetShow(true)
  end
  self._ui.txt_basic_ShipName:SetText(servantWrapper:getName())
  self._ui.txt_basic_ShipDP:SetText(vehicleActorWrapper:get():getDefense())
  self._ui.txt_basic_ShipHP:SetText(makeDotMoney(servantWrapper:getHp()) .. " / " .. makeDotMoney(servantWrapper:getMaxHp()))
  local shipHpMaxSizeX = 230
  self._ui.txt_basic_ShipHPTitle:SetSize(shipHpMaxSizeX - self._ui.txt_basic_ShipHP:GetTextSizeX(), self._ui.txt_basic_ShipHPTitle:GetSizeY())
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_ShipHPTitle)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.txt_basic_ShipHPTitle:SetIgnore(not self._ui.txt_basic_ShipHPTitle:IsLimitText())
  end
  self._ui.txt_basic_ShipFood:SetText(makeDotMoney(servantWrapper:getFood()) .. " / " .. makeDotMoney(servantWrapper:getMaxFood()))
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  local strWeight = str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui.txt_basic_Weight:SetText(strWeight)
  self._ui.txt_basic_Cost:SetText(vehicleActorWrapper:getEmployeeStats(__eEmployeeAbility_Employee_Cost) .. " / " .. servantWrapper:getEmployeeMaxCost())
  self._ui.txt_barterCount:SetText(tostring(ToClient_barterTotalExchangeCount()))
  self._ui.txt_cannonCount:SetText(tostring(servantWrapper:getServantStatParam(__eServantStatParamType_Cannon)))
  local creatorName = servantWrapper:getCreatorNickname()
  if creatorName == nil or creatorName == "" then
    self._ui.txt_creatorTitle:SetShow(false)
    self._ui.txt_creatorName:SetShow(false)
  else
    self._ui.txt_creatorTitle:SetShow(true)
    self._ui.txt_creatorName:SetShow(true)
    self._ui.txt_creatorName:SetText(creatorName)
  end
  self._ui.btn_SailorManager:SetShow(servantWrapper:getEmployeeMaxCost() ~= 0)
end
function PaGlobal_ShipInfo_Renewal_All:updateShipStat()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  local speed = servantWrapper:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
  local accel = servantWrapper:getStat(CppEnums.ServantStatType.Type_Acceleration)
  local cornering = servantWrapper:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
  local braking = servantWrapper:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
  local extraSpeed = 0
  local extraAccel = 0
  local extraCornering = 0
  local extraBraking = 0
  local sailStatStaticStatus = ToClient_getSailStatStaticStatus()
  if nil ~= sailStatStaticStatus then
    extraAccel = sailStatStaticStatus:getVariedStatByIndex(0)
    extraSpeed = sailStatStaticStatus:getVariedStatByIndex(1)
    extraCornering = sailStatStaticStatus:getVariedStatByIndex(2)
    extraBraking = sailStatStaticStatus:getVariedStatByIndex(3)
  end
  local shipTypeStr = servantWrapper:getDisplayName()
  if nil == shipTypeStr then
    shipTypeStr = ""
  end
  self._ui.txt_basic_ShipType:SetText(shipTypeStr)
  local isDriver = false
  if nil ~= getSelfPlayer() and 0 == getSelfPlayer():get():getVehicleSeatIndex() then
    isDriver = true
  end
  local isUseExtraStat = false
  if true == vehicleActorWrapper:isOceanShip() and false == vehicleActor:isGuildVehicle() and true == isDriver then
    isUseExtraStat = true
  end
  if ToClient_IsOceanSiegeBeingOnMyChannel() == true then
    local speedLimit = servantWrapper:getStatLimitRatioForOceanSiege()
    accel = accel * speedLimit
    speed = speed * speedLimit
    cornering = cornering * speedLimit
    braking = braking * speedLimit
    extraAccel = extraAccel * speedLimit
    extraSpeed = extraSpeed * speedLimit
    extraCornering = extraCornering * speedLimit
    extraBraking = extraBraking * speedLimit
  end
  if true == isUseExtraStat then
    if 0 == extraSpeed then
      self._ui.txt_basic_Speed:SetText(string.format("%.1f", speed * 1.0E-4) .. "%(+0%)")
    else
      self._ui.txt_basic_Speed:SetText(string.format("%.1f", speed * 1.0E-4) .. "%" .. "(+" .. string.format("%.1f", extraSpeed * 1.0E-4) .. "%)")
    end
    if 0 == extraAccel then
      self._ui.txt_basic_Accel:SetText(string.format("%.1f", accel * 1.0E-4) .. "%(+0%)")
    else
      self._ui.txt_basic_Accel:SetText(string.format("%.1f", accel * 1.0E-4) .. "%" .. "(+" .. string.format("%.1f", extraAccel * 1.0E-4) .. "%)")
    end
    if 0 == extraCornering then
      self._ui.txt_basic_Cornering:SetText(string.format("%.1f", cornering * 1.0E-4) .. "%(+0%)")
    else
      self._ui.txt_basic_Cornering:SetText(string.format("%.1f", cornering * 1.0E-4) .. "%" .. "(+" .. string.format("%.1f", extraCornering * 1.0E-4) .. "%)")
    end
    if 0 == extraBraking then
      self._ui.txt_basic_Break:SetText(string.format("%.1f", braking * 1.0E-4) .. "%(+0%)")
    else
      self._ui.txt_basic_Break:SetText(string.format("%.1f", braking * 1.0E-4) .. "%" .. "(+" .. string.format("%.1f", extraBraking * 1.0E-4) .. "%)")
    end
  else
    self._ui.txt_basic_Speed:SetText(string.format("%.1f", speed * 1.0E-4) .. "%")
    self._ui.txt_basic_Accel:SetText(string.format("%.1f", accel * 1.0E-4) .. "%")
    self._ui.txt_basic_Cornering:SetText(string.format("%.1f", cornering * 1.0E-4) .. "%")
    self._ui.txt_basic_Break:SetText(string.format("%.1f", braking * 1.0E-4) .. "%")
  end
  local deadCount = servantWrapper:getDeadCount()
  local deadTitleStr = PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_DESTROYCOUNT")
  if true == _ContentsGroup_OceanCurrent and true == servantWrapper:getIsDamageShip() then
    deadCount = deadCount / ToClinet_GetServantMaxDeadCount() * 100 .. "%"
    deadTitleStr = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_WOUNDEDPERCENT")
  end
  self._ui.txt_basic_DamageTitle:SetText(deadTitleStr)
  self._ui.txt_basic_Damage:SetText(deadCount)
end
function PaGlobal_ShipInfo_Renewal_All:updateCannonStat()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local cannonAccuracyView = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonAccuracy) - 90
  if cannonAccuracyView > 100 then
    cannonAccuracyView = 100
  end
  self._ui.txt_basic_CannonCoolTime:SetText(string.format("%.1f", ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonCoolTime)) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND"))
  self._ui.txt_basic_CannonAccuracy:SetText(string.format("%.2f", cannonAccuracyView) .. "%")
  self._ui.txt_basic_CannonMaxLength:SetText(string.format("%.1f", ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxLength) * 0.01))
  self._ui.txt_basic_CannonMaxAngle:SetText(string.format("%.1f", ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxAngle)) .. "\203\154")
end
function PaGlobal_ShipInfo_Renewal_All:updateShipEquipment()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  self._extendedSlotInfoArray = {}
  PaGlobal_ShipInfo_Renewal_All:equipSlotUpdate(false)
  PaGlobal_ShipInfo_Renewal_All:equipSlotUpdate(true)
end
function PaGlobal_ShipInfo_Renewal_All:updateShipSkill()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillCount = servantWrapper:getSortedSkillCountForDisplay()
  local listCount = 0
  self._ui.list_basic_SkillList:getElementManager():clearKey()
  for ii = 0, skillCount - 1 do
    if nil ~= servantWrapper:getSortedSkillForDisplay(ii) then
      listCount = listCount + 1
      self._shipSkillIndex[listCount] = ii
      self._ui.list_basic_SkillList:getElementManager():pushKey(toInt64(0, listCount))
    end
  end
end
function PaGlobal_ShipInfo_Renewal_All:updateShipInventory()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == vehicleActor then
    return
  end
  if nil ~= vehicleActor:getInventory() then
    self._config.contentsCount = vehicleActor:getInventory():size() - self._useStartSlot
    self._config.count = math.min(self._config.contentsCount, self._config.CONST_COUNT)
    UIScroll.SetButtonSize(self._ui.list_basic_ShipInven, self._config.count, self._config.contentsCount)
    PaGlobal_ShipInfo_Renewal_All:basic_invenUpdate()
  end
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  local weightPercent = Int64toInt32(s64_weightAll / s64_weightMax_div)
  local strWeight = str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui.progress_basic_weight:SetProgressRate(weightPercent)
  self._ui.txt_basic_progressWeight:SetText(strWeight)
end
function PaGlobal_ShipInfo_Renewal_All:equipSlotUpdate(isCashSlot)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local slot, slotBG, slotBGIcon, slotNoTable
  local hasExtendedSlot = false
  if false == isCashSlot then
    slot = self._equipItemSlots
    slotBG = self._equipSlotBG
    slotBGIcon = self._equipSlotBGIcon
    if false == self._isBigShip then
      slotNoTable = self._equipSlotNoSmall
    else
      slotNoTable = self._equipSlotNoBig
    end
  else
    slot = self._equipItemCashSlots
    slotBG = self._equipSlotCashBG
    slotBGIcon = self._equipSlotCashBGIcon
    if false == self._isBigShip then
      slotNoTable = self._equipCashSlotNoSmall
    else
      slotNoTable = self._equipCashSlotNoBig
    end
  end
  for ii = 1, self._equipSlotMaxCount do
    local slotNo = slotNoTable[ii]
    slot[ii]:clearItem()
    local itemWrapper = servantWrapper:getEquipItem(slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus()
      local slotNoMax = itemSSW:getExtendedSlotCount()
      for index = 1, slotNoMax do
        local extendSlotNo = itemSSW:getExtendedSlotIndex(index - 1)
        if slotNoMax ~= extendSlotNo then
          self._extendedSlotInfoArray[extendSlotNo] = ii
          hasExtendedSlot = true
        end
      end
      slot[ii]:setItem(itemWrapper)
      slot[ii].icon:SetShow(true)
      slot[ii].icon:SetMonoTone(false)
      slotBGIcon[ii]:SetShow(false)
      if false == isCashSlot then
        chk_totem = UI.getChildControl(slotBG[ii], "CheckButton_EquipSlot_Totem")
        chk_totem:SetShow(false)
        if slotNo == self._totemSlotNum then
          slotBG[ii]:SetChildIndex(chk_totem, 9999)
          chk_totem:SetShow(true)
          chk_totem:addInputEvent("Mouse_LUp", "HandleEventMLUp_ShipInfoRenewalAll_ShowEquipToggle()")
          self._totemCheckButton = chk_totem
          PaGlobal_ShipInfo_Renewal_All:setShowToggleButton()
        end
      end
    else
      slot[ii].icon:SetShow(false)
      slotBGIcon[ii]:SetShow(true)
      if slotNo == self._totemSlotNum and nil ~= self._totemCheckButton then
        self._totemCheckButton:SetShow(false)
        self._totemCheckButton = nil
      end
    end
    local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
    if vehicleActorWrapper == nil then
      return
    end
    local vehicleActor = vehicleActorWrapper:get()
    if vehicleActor == nil then
      return
    end
    local vehicleType = vehicleActor:getVehicleType()
    if true == _ContentsGroup_UsePadSnapping then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem(" .. ii .. ", true, " .. tostring(isCashSlot) .. ")")
      slot[ii].icon:addInputEvent("Mouse_Out", "HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem(" .. ii .. ", false, " .. tostring(isCashSlot) .. ")")
    else
      slotBG[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_ShipInfo_Renewal_All_EmptySlot_Tooltip(true, " .. ii .. ", " .. tostring(isCashSlot) .. ")")
      slotBG[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_ShipInfo_Renewal_All_EmptySlot_Tooltip()")
      slot[ii].icon:addInputEvent("Mouse_On", "HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem(" .. ii .. ", true, " .. tostring(isCashSlot) .. ")")
      slot[ii].icon:addInputEvent("Mouse_Out", "HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem(" .. ii .. ", false, " .. tostring(isCashSlot) .. ")")
      slot[ii].icon:addInputEvent("Mouse_RUp", "HandlerEventRUp_ShipInfoRenewalAll_EquipItem(" .. slotNo .. ")")
      Panel_Tooltip_Item_SetPosition(slotNo, slot[ii], "ServantShipEquipment")
    end
    slotBG[ii]:addInputEvent("Mouse_On", "HandleEventOnOut_ShipInfo_Renewal_All_EmptySlot_Tooltip(true, " .. ii .. ", " .. tostring(isCashSlot) .. ")")
    slotBG[ii]:addInputEvent("Mouse_Out", "HandleEventOnOut_ShipInfo_Renewal_All_EmptySlot_Tooltip()")
    if itemWrapper == nil then
      if true == _ContentsGroup_UsePadSnapping then
        slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_ShipInfo_All_ItemAcquireHelper(" .. slotNo .. ", " .. vehicleType .. ", " .. tostring(isCashSlot) .. ")")
      else
        slotBG[ii]:addInputEvent("Mouse_LUp", "PaGlobal_ShipInfo_All_ItemAcquireHelper(" .. slotNo .. ", " .. vehicleType .. ", " .. tostring(isCashSlot) .. ")")
      end
    elseif true == _ContentsGroup_UsePadSnapping then
      slotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandlerEventRUp_ShipInfoRenewalAll_EquipItem(" .. slotNo .. ")")
    else
      slotBG[ii]:addInputEvent("Mouse_LUp", "HandlerEventRUp_ShipInfoRenewalAll_EquipItem(" .. slotNo .. ")")
    end
  end
  if true == hasExtendedSlot then
    for extendSlotNo, slotIndex in pairs(self._extendedSlotInfoArray) do
      local itemWrapper = servantWrapper:getEquipItem(slotNoTable[slotIndex])
      if nil ~= itemWrapper then
        for i = 1, self._equipSlotMaxCount do
          if extendSlotNo == slotNoTable[i] then
            slot[i]:setItem(itemWrapper)
            slot[i].icon:SetMonoTone(true)
            slot[i].icon:SetShow(true)
            slotBGIcon[i]:SetShow(false)
          end
        end
      end
    end
  end
  if isCashSlot == false and (_ContentsGroup_EmployeeAutoFishing == false or _ContentsGroup_EmployeeAutoFishing == true and ToClient_getEmployeePresetJobCount(servantWrapper:getCharacterKeyRaw(), __eEmployeePresetJob_Fishing) <= 0) and self._equipSlotBG[6] ~= nil then
    self._equipSlotBG[6]:SetShow(false)
  end
end
function PaGlobal_ShipInfo_Renewal_All:basic_invenUpdate()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  for ii = 0, self._config.CONST_COUNT - 1 do
    self._invenSlotBG[ii]:SetShow(false)
  end
  for ii = 0, self._config.count - 1 do
    local slotIndex = ii + self._startInvenSlotIndex
    local slotNo = self._useStartSlot + slotIndex
    if nil ~= self._invenSlotBG[ii] and slotIndex < self._config.contentsCount then
      self._invenSlotBG[ii]:SetShow(true)
      self._invenItemSlots[ii]:clearItem()
      local itemWrapper = getServantInventoryItemBySlotNo(self._actorKeyRaw, slotNo)
      if nil ~= itemWrapper then
        self._invenItemSlots[ii]:setItem(itemWrapper)
        self._invenItemSlots[ii].icon:SetShow(true)
        if true == self._isConsole then
          if true == _ContentsGroup_RenewUI_Tooltip then
            self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_X, "HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem_Console(" .. slotNo .. ", true)")
          else
            self._invenSlotBG[ii]:registerPadEvent(__eConsoleUIPadEvent_X, "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",true," .. ii .. ")")
            self._invenSlotBG[ii]:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",false," .. ii .. ")")
            Panel_Tooltip_Item_SetPosition(slotNo, self._invenItemSlots[ii], "servant_inventoryView")
          end
        else
          self._invenItemSlots[ii].icon:addInputEvent("Mouse_On", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",true, " .. ii .. ")")
          self._invenItemSlots[ii].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_Show_GeneralNormal(" .. slotNo .. ", \"servant_inventoryView\",false," .. ii .. ")")
          Panel_Tooltip_Item_SetPosition(slotNo, self._invenItemSlots[ii], "servant_inventoryView")
          self._invenItemSlots[ii].icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ShipInfoRenewal_All_SlotRClick(" .. slotNo .. ")")
        end
      else
        self._invenItemSlots[ii].icon:SetShow(false)
      end
    end
  end
  self:weight_Update()
end
function PaGlobal_ShipInfo_Renewal_All:weight_Update()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  local vehicleActor = vehicleActorWrapper:get()
  if nil == servantWrapper or nil == vehicleActor or nil == vehicleActorWrapper then
    return
  end
  local s64_weightMax = vehicleActor:getPossessableWeight_s64()
  local s64_weightAll = vehicleActor:getCurrentWeight_s64()
  local s64_weightMax_div = s64_weightMax / Defines.s64_const.s64_100
  local str_AllWeight = makeWeightString(s64_weightAll, 1)
  local str_MaxWeight = makeWeightString(s64_weightMax, 0)
  local weightPercent = Int64toInt32(s64_weightAll / s64_weightMax_div)
  local strWeight = str_AllWeight .. " / " .. str_MaxWeight .. " " .. PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_WEIGHT")
  self._ui.txt_basic_Weight:SetText(strWeight)
  self._ui.progress_basic_weight:SetProgressRate(weightPercent)
  self._ui.txt_basic_progressWeight:SetText(strWeight)
  if weightPercent >= 100 then
    self._ui.stc_alert:SetShow(true)
    if false == self._isConsole then
      self._ui.stc_weightGuide:SetShow(false)
    end
  else
    self._ui.stc_alert:SetShow(false)
    if false == self._isConsole then
      self._ui.stc_weightGuide:SetShow(true)
    end
  end
end
function PaGlobal_ShipInfo_Renewal_All:prepareOpen(actorKeyRaw, isBigShip)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local isShow = Panel_Window_ShipInfo_Renewal_All:GetShow()
  self._actorKeyRaw = actorKeyRaw
  self._isBigShip = isBigShip
  PaGlobal_ShipInfo_Renewal_All:basic_Update()
  Panel_Window_ShipInfo_Renewal_All:SetHorizonCenter()
  Panel_Window_ShipInfo_Renewal_All:SetVerticalMiddle()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local vehicleActorWrapper = getVehicleActor(self._actorKeyRaw)
  if nil == vehicleActorWrapper then
    return
  end
  self:changeSlotBGIcon()
  self:setShowToggleButton()
  self._servantNo = servantWrapper:getServantNo()
  self._isGuildShip = servantWrapper:isGuildServant()
  local isShipShow = true
  local isEmployeeShow = true
  if false == ToClient_IsManualCannonFireServant(self._actorKeyRaw) then
    isShipShow = false
    if false == _ContentsGroup_BattleShipFireRenewal then
      isEmployeeShow = false
    end
  end
  if true == _ContentsGroup_UsePadSnapping then
    if servantWrapper:getSortedSkillCountForDisplay() <= 0 then
      self._ui.list_basic_SkillList:SetIgnore(true)
      self._ui.list_basic_SkillList:SetShow(false)
    else
      self._ui.list_basic_SkillList:SetIgnore(false)
      self._ui.list_basic_SkillList:SetShow(true)
    end
    self:setAlignKeyGuide()
  end
  self._ui.txt_basic_CannonCoolTimeTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxLengthTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonCoolTime:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxLength:SetShow(isShipShow)
  self._ui.txt_basic_CannonAccuracyTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxAngleTitle:SetShow(isShipShow)
  self._ui.txt_basic_CannonAccuracy:SetShow(isShipShow)
  self._ui.txt_basic_CannonMaxAngle:SetShow(isShipShow)
  if servantWrapper ~= nil and ToClient_servantUpgradeCharacterKeyList(servantWrapper:getCharacterKeyRaw()) ~= nil then
    self._ui.btn_Upgrade:SetShow(true)
  else
    self._ui.btn_Upgrade:SetShow(false)
  end
  if true == _ContentsGroup_FamilyInventory and false == isShow then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(false)
  end
  if PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive ~= nil then
    PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(false)
  end
  if false == _ContentsGroup_UsePadSnapping then
    Inventory_SetFunctor(PaGlobal_ShipInfo_Renewal_All_BasicItemFilter, PaGlobal_ShipInfo_Renewal_All_Inventory_SetFunctor, nil, nil)
    InventoryWindow_Show()
    if true == _ContentsGroup_NewUI_Inventory_All then
      if Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_ShipInfo_Renewal_All:ComputePos()
      else
        Panel_Window_ShipInfo_Renewal_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_ShipInfo_Renewal_All:GetSizeX() - 10)
        Panel_Window_ShipInfo_Renewal_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
      end
    elseif Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_ShipInfo_Renewal_All:ComputePos()
    else
      Panel_Window_ShipInfo_Renewal_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_ShipInfo_Renewal_All:GetSizeX() - 10)
      Panel_Window_ShipInfo_Renewal_All:SetPosY(Panel_Window_Inventory:GetPosY())
    end
  end
  ToClient_RequestCannonStatUpdate(self._actorKeyRaw)
  self._ui._stc_goHomeListArea:SetShow(false)
  self._ui._chk_goHome:SetCheck(false)
  self:open()
end
function PaGlobal_ShipInfo_Renewal_All:changeSlotBGIcon()
  for ii = 1, self._equipSlotMaxCount do
    local slotBG = self._equipSlotBG[ii]
    local cashSlotBG = self._equipSlotCashBG[ii]
    local slotBGIcon = self._equipSlotBGIcon[ii]
    local cashSlotBGIcon = self._equipSlotCashBGIcon[ii]
    local uvTable = self._equipSlotBigShipUV
    local slotNo = self._equipSlotNoBig[ii]
    local cashSlotNo = self._equipCashSlotNoBig[ii]
    if false == self._isBigShip then
      uvTable = self._equipSlotSmallShipUV
      slotNo = self._equipSlotNoSmall[ii]
      cashSlotNo = self._equipCashSlotNoSmall[ii]
    end
    local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
    if 0 == slotNo or _ContentsGroup_EmployeeAutoFishing == false and ii == 6 or _ContentsGroup_EmployeeAutoFishing == true and 0 >= ToClient_getEmployeePresetJobCount(servantWrapper:getCharacterKeyRaw(), __eEmployeePresetJob_Fishing) and ii == 6 then
      slotBG:SetShow(false)
    else
      slotBG:SetShow(true)
    end
    if 0 == cashSlotNo then
      cashSlotBG:SetShow(false)
    else
      cashSlotBG:SetShow(true)
    end
    if nil == uvTable[slotNo] then
      return
    end
    if ii == 6 then
      slotBGIcon:ChangeTextureInfoTextureIDAsync("Combine_Etc_Equip_Life_Icon_RingMenu_Off_FishingRod_Normal", 0)
      slotBGIcon:setRenderTexture(slotBGIcon:getBaseTexture())
    else
      slotBGIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_icon_01.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBGIcon, uvTable[slotNo].x1, uvTable[slotNo].y1, uvTable[slotNo].x2, uvTable[slotNo].y2)
      slotBGIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBGIcon:setRenderTexture(slotBGIcon:getBaseTexture())
    end
    cashSlotBGIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_icon_01.dds")
    x1, y1, x2, y2 = setTextureUV_Func(cashSlotBGIcon, uvTable[cashSlotNo].x1, uvTable[cashSlotNo].y1, uvTable[cashSlotNo].x2, uvTable[cashSlotNo].y2)
    cashSlotBGIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    cashSlotBGIcon:setRenderTexture(cashSlotBGIcon:getBaseTexture())
  end
end
function PaGlobal_ShipInfo_Renewal_All:open()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  Panel_Window_ShipInfo_Renewal_All:SetShow(true)
end
function PaGlobal_ShipInfo_Renewal_All:prepareClose()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == _ContentsGroup_FamilyInventory then
    PaGlobalFunc_Inventory_All_familyInventoryButtonActive(true)
  end
  if PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive ~= nil then
    PaGlobalFunc_Inventory_All_EnchantInventoryButtonActive(true)
  end
  if false == _ContentsGroup_UsePadSnapping then
    HelpMessageQuestion_Out()
    HandleEventMLUp_ItemFilter_Close()
    if nil ~= Panel_Window_ServantUpgrade and true == Panel_Window_ServantUpgrade:GetShow() then
      PaGlobal_ServantUpgrade_Close()
    end
  elseif self._ui._stc_goHomeListArea:GetShow() == true then
    self._ui._stc_goHomeListArea:SetShow(false)
    self._ui._chk_goHome:SetCheck(false)
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  self:close()
end
function PaGlobal_ShipInfo_Renewal_All:close()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  Panel_Window_ShipInfo_Renewal_All:SetShow(false)
end
function PaGlobal_ShipInfo_Renewal_All:validate()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  self._ui._stc_goHomeListArea:isValidate()
  self._ui._btn_homeTemplete:isValidate()
end
function PaGlobal_ShipInfo_Renewal_All:showEquipToggle()
  local temporaryWrapper = getTemporaryInformationWrapper()
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if nil == seaVehicleWrapper then
    return
  end
  if nil == self._totemCheckButton then
    return
  end
  local isCheck = self._totemCheckButton:IsCheck()
  if isCheck then
    ToClient_SetVehicleEquipSlotFlag(seaVehicleWrapper:getActorKeyRaw(), self._totemSlotNum)
  else
    ToClient_ResetVehicleEquipSlotFlag(seaVehicleWrapper:getActorKeyRaw(), self._totemSlotNum)
  end
end
function PaGlobal_ShipInfo_Renewal_All:setShowToggleButton()
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  if nil == self._totemCheckButton then
    return
  end
  if false == self._isBigShip then
    local isCheck = ToClient_IsSetVehicleEquipSlotFlag(self._actorKeyRaw, self._totemSlotNum)
    self._totemCheckButton:SetShow(true)
    self._totemCheckButton:SetCheck(isCheck)
    return
  end
  self._totemCheckButton:SetShow(false)
end
function PaGlobal_ShipInfo_Renewal_All:inventory_SetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local fromItemWrapper = getInventoryItemByType(inventoryType, slotNo)
  if nil == fromItemWrapper then
    return
  end
  local itemSSW = fromItemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local itemSS = itemSSW:get()
  if nil == itemSS then
    return false
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  if nil == servantWrapper then
    return false
  end
  self._inventoryType = inventoryType
  self._inventorySlotNo = slotNo
  function PaGlobal_ShipInfo_Renewal_All_InventoryUseItem()
    inventoryUseItem(PaGlobal_ShipInfo_Renewal_All._inventoryType, PaGlobal_ShipInfo_Renewal_All._inventorySlotNo, __eEquipSlotNoCount, false)
  end
  local servantKind = servantWrapper:getServantKind()
  local servantKindSub = servantWrapper:getServantKindSub()
  if true == itemSS:isServantTypeUsable(servantKind, servantKindSub) then
    if 2 == itemSS._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local messageContent
      if itemSSW:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = PaGlobal_ShipInfo_Renewal_All_InventoryUseItem,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      PaGlobal_ShipInfo_Renewal_All_InventoryUseItem()
    end
  else
    PaGlobal_ShipInfo_Renewal_All._moveItemToType = CppEnums.MoveItemToType.Type_Player
    PaGlobal_ShipInfo_Renewal_All._inventoryType = inventoryType
    FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, CppEnums.MoveItemToType.Type_NewShip, PaGlobal_ShipInfo_Renewal_All._actorKeyRaw, true)
  end
end
function PaGlobal_ShipInfo_Renewal_All:ShipInfo_Tooltip_Open(actorKeyRaw, key32)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local content = PaGlobal_ShipInfo_Renewal_All._ui.list_basic_SkillList:GetContentByKey(toInt64(0, key32))
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  local skillIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(PaGlobal_ShipInfo_Renewal_All._shipSkillIndex[key32])
  if true == _ContentsGroup_NewUI_Tooltip_All then
    PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, skillIcon, false)
  else
    PaGlobal_Tooltip_Servant_Open(skillWrapper, skillIcon, false)
    if true == _ContentsGroup_UsePadSnapping and nil ~= Panel_Tooltip_Skill_Servant then
      Panel_Tooltip_Skill_Servant:SetPosY(stc_BG:GetParentPosY())
      Panel_Tooltip_Skill_Servant:SetPosX(Panel_Window_ShipInfo_Renewal_All:GetPosX() + Panel_Window_ShipInfo_Renewal_All:GetSizeX())
    end
  end
end
function PaGlobal_ShipInfo_Renewal_All:ShipInfo_CheckSkillLock(actorKeyRaw, key32)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == _ContentsGroup_UsePadSnapping then
    self._ui._txt_KeyGuideLS:SetShow(false)
    self:setAlignKeyGuide()
  end
  if nil == actorKeyRaw or nil == key32 then
    return
  end
  local content = PaGlobal_ShipInfo_Renewal_All._ui.list_basic_SkillList:GetContentByKey(toInt64(0, key32))
  if nil == content then
    return
  end
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  if nil == stc_BG then
    return
  end
  local skillIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  if nil == skillIcon then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(PaGlobal_ShipInfo_Renewal_All._shipSkillIndex[key32])
  if nil == skillWrapper then
    return
  end
  local chk_skillLockIcon = UI.getChildControl(stc_BG, "CheckButton_SkillLockIcon")
  if nil ~= chk_skillLockIcon then
    chk_skillLockIcon:SetCheck(ToClient_isBlockVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType()))
    if true == _ContentsGroup_UsePadSnapping and true == chk_skillLockIcon:GetShow() then
      self._ui._txt_KeyGuideLS:SetShow(true)
      self:setAlignKeyGuide()
    end
  end
end
function PaGlobal_ShipInfo_Renewal_All:initLimitText()
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CostTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_barterCountTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_cannonCountTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_SpeedTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_AccelTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CorneringTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_BreakTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CannonCoolTimeTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CannonMaxLengthTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CannonAccuracyTitle)
  UI.setLimitTextAndAddTooltip(self._ui.txt_basic_CannonMaxAngleTitle)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.txt_basic_CostTitle:SetIgnore(not self._ui.txt_basic_CostTitle:IsLimitText())
    self._ui.txt_barterCountTitle:SetIgnore(not self._ui.txt_barterCountTitle:IsLimitText())
    self._ui.txt_cannonCountTitle:SetIgnore(not self._ui.txt_cannonCountTitle:IsLimitText())
    self._ui.txt_basic_CannonAccuracyTitle:SetIgnore(not self._ui.txt_basic_CannonAccuracyTitle:IsLimitText())
    self._ui.txt_basic_CannonCoolTimeTitle:SetIgnore(not self._ui.txt_basic_CannonCoolTimeTitle:IsLimitText())
  end
end
function PaGlobal_ShipInfo_Renewal_All:updateServantSkillLock(index, isClickedBg)
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(self._shipSkillIndex[index])
  if nil == skillWrapper then
    return
  end
  local key = self._ui.list_basic_SkillList:getKeyByIndex(index - 1)
  if -1 == key then
    index = index + 1
    key = self._ui.list_basic_SkillList:getKeyByIndex(index - 1)
  end
  local control = self._ui.list_basic_SkillList:GetContentByKey(key)
  local stc_BG = UI.getChildControl(control, "Static_SkillName")
  local stc_skliIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  local chk_skillLockIcon = UI.getChildControl(stc_BG, "CheckButton_SkillLockIcon")
  if nil == chk_skillLockIcon then
    return
  end
  if nil ~= isClickedBg and true == isClickedBg then
    chk_skillLockIcon:SetCheck(not chk_skillLockIcon:IsCheck())
  end
  local isCheck = chk_skillLockIcon:IsCheck()
  if true == isCheck then
    ToClient_blockVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType())
  else
    ToClient_enableVehicleSkillCommand(skillWrapper:getKey(), servantWrapper:getServantType())
  end
end
function PaGlobal_ShipInfo_Renewal_All:updateStatBar()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  local characterKey = servantWrapper:getCharacterKeyRaw()
  local shipType = self._keyToType[characterKey]
  if shipType == nil then
    for index = 1, self._statType.Count - 1 do
      for barIndex = 1, self._config.statBarCount do
        self._ui._statBarBg[index][barIndex]:SetShow(false)
        self._ui._statBar[index][barIndex]:SetShow(false)
      end
    end
    return
  end
  for index = 1, self._statType.Count - 1 do
    for barIndex = 1, self._config.statBarCount do
      self._ui._statBarBg[index][barIndex]:SetShow(true)
    end
  end
  for index = 1, self._statType.Count - 1 do
    local statValue = 0
    if index == self._statType.Speed then
      statValue = servantWrapper:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) * 1.0E-4
    elseif index == self._statType.Acceleration then
      statValue = servantWrapper:getStat(CppEnums.ServantStatType.Type_Acceleration) * 1.0E-4
    elseif index == self._statType.CorneringSpeed then
      statValue = servantWrapper:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) * 1.0E-4
    elseif index == self._statType.Brake then
      statValue = servantWrapper:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) * 1.0E-4
    elseif index == self._statType.CoolTime then
      statValue = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonCoolTime)
    elseif index == self._statType.MaximumRange then
      statValue = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxLength) * 0.01
    elseif index == self._statType.Accuracy then
      statValue = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonAccuracy) - 90
    elseif index == self._statType.Angle then
      statValue = ToClient_GetManualCannonFireCannonStatus(__eServantStatTypeCannonMaxAngle)
    end
    if (index == self._statType.Speed or index == self._statType.Acceleration or index == self._statType.CorneringSpeed or index == self._statType.Brake) and ToClient_IsOceanSiegeBeingOnMyChannel() == true then
      local speedLimit = servantInfo:getStatLimitRatioForOceanSiege()
      statValue = statValue * speedLimit
    end
    local barCount = self:getStatBarCount(shipType, index, statValue)
    for barIndex = 1, self._config.statBarCount do
      if barIndex <= barCount then
        self._ui._statBar[index][barIndex]:SetShow(true)
      else
        self._ui._statBar[index][barIndex]:SetShow(false)
      end
    end
  end
end
function PaGlobal_ShipInfo_Renewal_All:getStatBarCount(shipType, statType, statValue)
  local minimum = self._statMinimum[shipType][statType]
  local maximum = self._statMaximum[shipType][statType]
  local valuePerBar = (maximum - minimum) / self._config.statBarCount
  return math.floor((statValue - minimum) / valuePerBar)
end
