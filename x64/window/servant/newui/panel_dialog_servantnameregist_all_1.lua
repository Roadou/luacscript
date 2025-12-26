function PaGlobal_ServantNameRegist_All:initialize()
  if nil == Panel_Dialog_ServantNameRegist_All or true == self.initialize then
    return
  end
  self._ui._stc_Title = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "StaticText_Title")
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Button_Close")
  self._ui._stc_MainBg = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_MainBg")
  self._ui._stc_ContentBg = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_ContentBg")
  self._ui._stc_HorseImage = UI.getChildControl(self._ui._stc_ContentBg, "Static_Image")
  self._ui._stc_GenderIcon = UI.getChildControl(self._ui._stc_HorseImage, "Static_GenderIcon")
  self._ui._txt_HpTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_HpTitle")
  self._ui._txt_HpValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_HpValue")
  self._ui._txt_StaminaTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_StaminaTitle")
  self._ui._txt_StaminaValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_StaminaValue")
  self._ui._txt_WeightTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_WeightTitle")
  self._ui._txt_WeightValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_WeightValue")
  self._ui._txt_LeftLifeTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_LeftLifeTitle")
  self._ui._txt_LeftLifeValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_LeftLifeValue")
  self._ui._txt_SpeedTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_SpeedTitle")
  self._ui._txt_SpeedValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_SpeedValue")
  self._ui._txt_AccelTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_AccelerationTitle")
  self._ui._txt_AccelValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_AccelerationValue")
  self._ui._txt_CorneringTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_CorneringSpeedTitle")
  self._ui._txt_CorneringValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_BreakTitle = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_BreakTitle")
  self._ui._txt_BreakValue = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_BreakValue")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_X_ConsoleUI")
  self._ui._stc_EditNaming = UI.getChildControl(self._ui._stc_ContentBg, "Edit_Naming")
  self._ui._stc_EditRentalName = UI.getChildControl(self._ui._stc_ContentBg, "Edit_RentalName")
  self._ui._stc_PriceBg = UI.getChildControl(self._ui._stc_ContentBg, "StaticText_PriceBg")
  self._ui._txt_Price = UI.getChildControl(self._ui._stc_PriceBg, "StaticText_PriceValue")
  self._ui._stc_Mutation_ContentBg = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_SpecialHorseBg")
  self._ui._stc_Mutation_HorseImage = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "Static_Image")
  self._ui._stc_Mutation_GenderIcon = UI.getChildControl(self._ui._stc_Mutation_HorseImage, "Static_GenderIcon")
  self._ui._txt_Mutation_HpTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_HpTitle")
  self._ui._txt_Mutation_HpValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_HpValue")
  self._ui._txt_Mutation_StaminaTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_StaminaTitle")
  self._ui._txt_Mutation_StaminaValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_StaminaValue")
  self._ui._txt_Mutation_WeightTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_WeightTitle")
  self._ui._txt_Mutation_WeightValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_WeightValue")
  self._ui._txt_Mutation_LeftLifeTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_LeftLifeTitle")
  self._ui._txt_Mutation_LeftLifeValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_LeftLifeValue")
  self._ui._txt_Mutation_SpeedTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_SpeedTitle")
  self._ui._txt_Mutation_SpeedValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_SpeedValue")
  self._ui._txt_Mutation_AccelTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_AccelerationTitle")
  self._ui._txt_Mutation_AccelValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_AccelerationValue")
  self._ui._txt_Mutation_CorneringTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_CorneringSpeedTitle")
  self._ui._txt_Mutation_CorneringValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_Mutation_BreakTitle = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_BreakTitle")
  self._ui._txt_Mutation_BreakValue = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_BreakValue")
  self._ui._stc_Mutation_KeyGuide_LT = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_LT_ConsoleUI")
  self._ui._stc_Mutation_KeyGuide_Plus = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_Plus_ConsoleUI")
  self._ui._stc_Mutation_KeyGuide_X = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_X_ConsoleUI")
  self._ui._stc_Mutation_EditNaming = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "Edit_Naming")
  self._ui._sct_Mutation_Desc = UI.getChildControl(self._ui._stc_Mutation_ContentBg, "StaticText_Desc2")
  self._ui._sct_Mutation_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._sct_Mutation_Desc:SetText(self._ui._sct_Mutation_Desc:GetText())
  self._ui._rdo_Mine = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "RadioButton_Mine")
  self._ui._rdo_All = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "RadioButton_All")
  self._ui._btn_Confirm = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Button_Confirm")
  self._ui._btn_Cancel = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Button_Cancel")
  self._ui._stc_Console_KeyGuides = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_Console_KeyGuides, "StaticText_B_ConsoleUI")
  self._ui._stc_OnlySpeed = UI.getChildControl(self._ui._stc_ContentBg, "Static_OnlySpeed")
  self._ui._stc_OnlyAcce = UI.getChildControl(self._ui._stc_ContentBg, "Static_OnlyAcce")
  self._ui._stc_OnlyCorner = UI.getChildControl(self._ui._stc_ContentBg, "Static_OnlyCorner")
  self._ui._stc_OnlyBrake = UI.getChildControl(self._ui._stc_ContentBg, "Static_OnlyBrake")
  self._ui._stc_RegisterFromCarriage = UI.getChildControl(Panel_Dialog_ServantNameRegist_All, "StaticText_RegisterFromCarriage")
  self._ORIGIN_PANELSIZE_Y = Panel_Dialog_ServantNameRegist_All:GetSizeY()
  self._ORIGIN_BUTTONPOS_Y = self._ui._btn_Confirm:GetPosY()
  self._ORIGIN_MAINBGSIZE_Y = self._ui._stc_MainBg:GetSizeY()
  self._speedValueBasePosX = self._ui._txt_SpeedValue:GetPosX()
  self._acceValueBasePosX = self._ui._txt_AccelValue:GetPosX()
  self._cornerValueBasePosX = self._ui._txt_CorneringValue:GetPosX()
  self._brakeValueBasePosX = self._ui._txt_BreakValue:GetPosX()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._lastEditControl = nil
  if true == self._isConsole then
    self._ORIGIN_PANELSIZE_Y = self._ORIGIN_PANELSIZE_Y - self._ui._btn_Confirm:GetSizeY() - 15
    self._ORIGIN_MAINBGSIZE_Y = self._ORIGIN_MAINBGSIZE_Y - self._ui._btn_Confirm:GetSizeY() - 15
  end
  PaGlobal_ServantNameRegist_All:validate()
  PaGlobal_ServantNameRegist_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantNameRegist_All:registerEventHandler(self._isConsole)
end
function PaGlobal_ServantNameRegist_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantNameRegist_All or false == self._initialize then
    return
  end
  self._ui._stc_EditNaming:SetMaxInput(getGameServiceTypeServantNameLength())
  registerEvent("FromClient_ServantChildInfo", "PaGlobalFunc_ServantNameRegist_All_OpenByMating")
  registerEvent("FromClient_ServantRegisterToAuction", "PaGlobalFunc_ServantNameRegist_All_Close")
  registerEvent("onScreenResize", "FromClient_ServantNameRegist_All_OnScreenResize")
  registerEvent("FromClient_WildHorseRegisterCarriage", "PaGlobalFunc_ServantNameRegist_All_OpenByTaming")
  if false == isConsole then
    Panel_Dialog_ServantNameRegist_All:SetDragEnable(true)
    Panel_Dialog_ServantNameRegist_All:SetDragAll(true)
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_Close()")
    self._ui._btn_Cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_Close()")
    self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_ServantRegister()")
    self._ui._stc_EditNaming:addInputEvent("Mouse_LDown", "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Edit\" )")
    self._ui._stc_EditRentalName:addInputEvent("Mouse_LDown", "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Edit\" )")
    self._ui._stc_Mutation_EditNaming:addInputEvent("Mouse_LDown", "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Mutation\" )")
    self._ui._stc_EditNaming:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Edit()")
    self._ui._stc_EditRentalName:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Edit()")
    self._ui._stc_Mutation_EditNaming:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Mutation()")
    self._ui._rdo_All:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 0 )")
    self._ui._rdo_Mine:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 1 )")
    self._ui._stc_OnlySpeed:addInputEvent("Mouse_On", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeSpeed .. ")")
    self._ui._stc_OnlySpeed:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(false)")
    self._ui._stc_OnlyAcce:addInputEvent("Mouse_On", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeAcceleration .. ")")
    self._ui._stc_OnlyAcce:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(false)")
    self._ui._stc_OnlyCorner:addInputEvent("Mouse_On", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeCornering .. ")")
    self._ui._stc_OnlyCorner:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(false)")
    self._ui._stc_OnlyBrake:addInputEvent("Mouse_On", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(true," .. __eServantStatTypeBrake .. ")")
    self._ui._stc_OnlyBrake:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantNameRegist_All_ShowUseAddStatItemTooltip(false)")
  else
    Panel_Dialog_ServantNameRegist_All:ignorePadSnapMoveToOtherPanel()
    self._ui._stc_EditNaming:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Edit")
    self._ui._stc_EditRentalName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Edit")
    self._ui._stc_Mutation_EditNaming:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Mutation")
    self._ui._stc_EditNaming:addInputEvent("Mouse_LDown", "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Edit\" )")
    self._ui._stc_EditRentalName:addInputEvent("Mouse_LDown", "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Edit\" )")
    self._ui._stc_Mutation_EditNaming:addInputEvent("Mouse_LDown", "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Mutation\" )")
    self._ui._stc_EditNaming:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Edit()")
    self._ui._stc_EditRentalName:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Edit()")
    self._ui._stc_Mutation_EditNaming:RegistReturnKeyEvent("PaGlobalFunc_ServantNameRegist_All_ReturnEvent_Mutation()")
    Panel_Dialog_ServantNameRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ServantNameRegist_All_TamingServantRegister()")
    Panel_Dialog_ServantNameRegist_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Edit\" )")
    Panel_Dialog_ServantNameRegist_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Mutation\" )")
    self._ui._stc_Mutation_EditNaming:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Edit\" )")
    self._ui._stc_EditNaming:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_ServantNameRegist_All_ClearEdit( \"Mutation\" )")
    self._ui._stc_Mutation_EditNaming:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ServantNameRegist_All_TamingServantRegister()")
    self._ui._stc_EditNaming:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_ServantNameRegist_All_TamingServantRegister()")
    self._ui._rdo_All:addInputEvent("Mouse_On", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 0 )")
    self._ui._rdo_Mine:addInputEvent("Mouse_On", "HandleEventLUp_ServantNameRegist_All_ClickRadioButton( 1 )")
  end
end
function PaGlobal_ServantNameRegist_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantNameRegist_All or false == self._initialize then
    return
  end
  self._ui._stc_Console_KeyGuides:SetShow(isConsole)
  self._ui._stc_KeyGuide_X:SetShow(isConsole)
  self._ui._btn_Confirm:SetShow(not isConsole)
  self._ui._btn_Cancel:SetShow(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui._stc_KeyGuide_A,
      self._ui._stc_KeyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Console_KeyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_Console_KeyGuides:SetPosY(Panel_Dialog_ServantNameRegist_All:GetSizeY())
  end
end
function PaGlobal_ServantNameRegist_All:prepareOpen()
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  self._lastEditControl = nil
  self._ui._stc_Mutation_ContentBg:SetShow(false)
  PaGlobal_ServantNameRegist_All:open()
  PaGlobal_ServantNameRegist_All:update()
  PaGlobal_ServantNameRegist_All:updateMutation()
  PaGlobal_ServantNameRegist_All:updatePanelSize(self._isConsole)
  FromClient_ServantNameRegist_All_OnScreenResize()
end
function PaGlobal_ServantNameRegist_All:updatePanelSize(isConsole)
  local consoleSizeY = 0
  if isConsole == true then
    consoleSizeY = 70
  end
  if self._ui._stc_Mutation_ContentBg:GetShow() == true then
    Panel_Dialog_ServantNameRegist_All:SetSize(Panel_Dialog_ServantNameRegist_All:GetSizeX(), 630 - consoleSizeY)
    self._ui._stc_MainBg:SetSize(self._ui._stc_MainBg:GetSizeX(), 580 - consoleSizeY)
    self._ui._stc_ContentBg:SetSpanSize(0, 300)
  else
    Panel_Dialog_ServantNameRegist_All:SetSize(Panel_Dialog_ServantNameRegist_All:GetSizeX(), 410 - consoleSizeY)
    self._ui._stc_MainBg:SetSize(self._ui._stc_MainBg:GetSizeX(), 360 - consoleSizeY)
    self._ui._stc_ContentBg:SetSpanSize(0, 60)
  end
  if isConsole == true then
    self._ui._stc_Console_KeyGuides:SetPosY(Panel_Dialog_ServantNameRegist_All:GetSizeY())
  end
  self._ui._btn_Confirm:ComputePos()
  self._ui._btn_Cancel:ComputePos()
end
function PaGlobal_ServantNameRegist_All:updateConsoleKeyGuide(isMutationHorse, isConsole)
  if isConsole == true then
    self._ui._stc_Mutation_KeyGuide_LT:SetShow(isMutationHorse)
    self._ui._stc_Mutation_KeyGuide_Plus:SetShow(isMutationHorse)
    self._ui._stc_Mutation_KeyGuide_X:SetShow(isMutationHorse)
  else
    self._ui._stc_Mutation_KeyGuide_LT:SetShow(false)
    self._ui._stc_Mutation_KeyGuide_Plus:SetShow(false)
    self._ui._stc_Mutation_KeyGuide_X:SetShow(false)
  end
end
function PaGlobal_ServantNameRegist_All:open()
  if nil == Panel_Dialog_ServantNameRegist_All or true == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantNameRegist_All:SetShow(true)
end
function PaGlobal_ServantNameRegist_All:update()
  if nil == Panel_Dialog_ServantNameRegist_All then
    return
  end
  self._ui._stc_PriceBg:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PEARLSHOP_PRODUCTBUY_PRICE"))
  local servantInfo
  if self._registerType == CppEnums.ServantRegist.eEventType_Taming or self._registerType == CppEnums.ServantRegist.eEventType_Mating then
    servantInfo = stable_getServantByCharacterKey(self._characterKey, self._level)
  elseif nil ~= self._currentServantNo then
    servantInfo = stable_getServant(self._currentServantNo)
  end
  if nil == servantInfo then
    return
  end
  local vehicleType = servantInfo:getVehicleType()
  if CppEnums.VehicleType.Type_Horse == vehicleType and true == servantInfo:isDisplayGender() then
    self._ui._stc_GenderIcon:SetShow(true)
    self._ui._stc_GenderIcon:ChangeTextureInfoNameAsync("combine/etc/combine_etc_stable.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if true == servantInfo:isMale() then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_GenderIcon, 1, 209, 31, 239)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_GenderIcon, 1, 178, 31, 208)
    end
    self._ui._stc_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_GenderIcon:setRenderTexture(self._ui._stc_GenderIcon:getBaseTexture())
  else
    self._ui._stc_GenderIcon:SetShow(false)
  end
  if true == _ContentsGroup_OceanCurrent then
    local characterKey = servantInfo:getCharacterKeyRaw()
    local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
    if nil ~= shipStaticStatus and false == shipStaticStatus:getIsSummonFull() then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    elseif nil ~= shipStaticStatus then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    elseif CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_LIFE"))
    elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME"))
    else
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    end
  else
    local isWarterVehicle = ToClient_isVehicleTypeWarter(vehicleType)
    if CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_CowCarriage == vehicleType then
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_LIFE"))
    elseif CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME"))
    elseif true == isWarterVehicle then
      if CppEnums.VehicleType.Type_SailingBoat == vehicleType or CppEnums.VehicleType.Type_PersonalBattleShip == vehicleType or CppEnums.VehicleType.Type_PersonTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalTradeShip == vehicleType or CppEnums.VehicleType.Type_CashPersonalBattleShip == vehicleType then
        self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
        self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_GUILDSHIP_NAME"))
        self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
      else
        self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_CARRIAGE_HP"))
        self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_HEART"))
        self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
      end
    else
      self._ui._txt_HpTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_HP"))
      self._ui._txt_StaminaTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MP"))
      self._ui._txt_LeftLifeTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_LIFE"))
    end
  end
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  self._ui._stc_HorseImage:ChangeTextureInfoNameAsync(servantInfo:getIconPath1())
  self._ui._txt_HpValue:SetText(makeDotMoney(servantInfo:getMaxHp()))
  self._ui._txt_StaminaValue:SetText(makeDotMoney(getMaxMpToServantInfo(servantInfo)))
  self._ui._txt_WeightValue:SetText(makeDotMoney(servantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000))
  self._ui._txt_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
  self._ui._txt_AccelValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
  self._ui._txt_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
  self._ui._txt_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
  if true == servantInfo:isPeriodLimit() then
    self._ui._txt_LeftLifeValue:SetText(servantInfo:getStaticExpiredTime() / 60 / 60 / 24 .. PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFETIME"))
  else
    self._ui._txt_LeftLifeValue:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
  end
  HandleEventLUp_ServantNameRegist_All_ClickRadioButton(0)
  if nil ~= self._minPrice then
    self._ui._txt_Price:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_STABLEREGISTER_MATING_PRICE", "matingPrice", makeDotMoney(self._minPrice)))
  end
  self._ui._stc_OnlySpeed:SetShow(false)
  self._ui._stc_OnlyAcce:SetShow(false)
  self._ui._stc_OnlyCorner:SetShow(false)
  self._ui._stc_OnlyBrake:SetShow(false)
  local speedValuePosX = self._speedValueBasePosX
  local acceValuePosX = self._acceValueBasePosX
  local cornerValuePosX = self._cornerValueBasePosX
  local brakeValuePosX = self._brakeValueBasePosX
  if __eVehicleType_Horse == vehicleType then
    local speedAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeSpeed)
    if speedAddItemUseCount > 0 then
      speedValuePosX = speedValuePosX - self._ui._stc_OnlySpeed:GetSizeX()
      self._ui._stc_OnlySpeed:SetShow(true)
    end
    local acceAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeAcceleration)
    if acceAddItemUseCount > 0 then
      acceValuePosX = acceValuePosX - self._ui._stc_OnlyAcce:GetSizeX()
      self._ui._stc_OnlyAcce:SetShow(true)
    end
    local cornerAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeCornering)
    if cornerAddItemUseCount > 0 then
      cornerValuePosX = cornerValuePosX - self._ui._stc_OnlyCorner:GetSizeX()
      self._ui._stc_OnlyCorner:SetShow(true)
    end
    local brakeAddItemUseCount = servantInfo:getAddStatItemUseCount(__eServantStatTypeBrake)
    if brakeAddItemUseCount > 0 then
      brakeValuePosX = brakeValuePosX - self._ui._stc_OnlyBrake:GetSizeX()
      self._ui._stc_OnlyBrake:SetShow(true)
    end
  end
  self._ui._txt_SpeedValue:SetPosX(speedValuePosX)
  self._ui._txt_AccelValue:SetPosX(acceValuePosX)
  self._ui._txt_CorneringValue:SetPosX(cornerValuePosX)
  self._ui._txt_BreakValue:SetPosX(brakeValuePosX)
  if _ContentsGroup_WildHorseCatchWagon == true then
    self._ui._btn_Confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantNameRegist_All_ServantRegister(" .. tostring(self._registerFromType) .. ")")
  end
end
function PaGlobal_ServantNameRegist_All:updateMutation()
  if self._registerType ~= CppEnums.ServantRegist.eEventType_Mating then
    return
  end
  if self._mutationCharacterKey == nil then
    self:updateConsoleKeyGuide(false, self._isConsole)
    return
  end
  local servantInfo = stable_getServantByCharacterKey(self._mutationCharacterKey, self._level)
  if servantInfo == nil then
    return
  end
  local vehicleType = servantInfo:getVehicleType()
  if CppEnums.VehicleType.Type_Horse == vehicleType and true == servantInfo:isDisplayGender() then
    self._ui._stc_Mutation_GenderIcon:SetShow(true)
    self._ui._stc_Mutation_GenderIcon:ChangeTextureInfoNameAsync("combine/etc/combine_etc_stable.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if true == servantInfo:isMale() then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_Mutation_GenderIcon, 1, 209, 31, 239)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_Mutation_GenderIcon, 1, 178, 31, 208)
    end
    self._ui._stc_Mutation_GenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_Mutation_GenderIcon:setRenderTexture(self._ui._stc_Mutation_GenderIcon:getBaseTexture())
  else
    self._ui._stc_Mutation_GenderIcon:SetShow(false)
  end
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_Mutation_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_Mutation_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  self._ui._stc_Mutation_HorseImage:ChangeTextureInfoNameAsync(servantInfo:getIconPath1())
  self._ui._txt_Mutation_HpValue:SetText(makeDotMoney(servantInfo:getMaxHp()))
  self._ui._txt_Mutation_StaminaValue:SetText(makeDotMoney(getMaxMpToServantInfo(servantInfo)))
  self._ui._txt_Mutation_WeightValue:SetText(makeDotMoney(servantInfo:getMaxWeight_s64() / Defines.s64_const.s64_10000))
  self._ui._txt_Mutation_SpeedValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000) .. "%")
  self._ui._txt_Mutation_AccelValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_Acceleration) / 10000) .. "%")
  self._ui._txt_Mutation_CorneringValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000) .. "%")
  self._ui._txt_Mutation_BreakValue:SetText(string.format("%.1f", servantInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000) .. "%")
  if true == servantInfo:isPeriodLimit() then
    self._ui._txt_Mutation_LeftLifeValue:SetText(servantInfo:getStaticExpiredTime() / 60 / 60 / 24 .. PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFETIME"))
  else
    self._ui._txt_Mutation_LeftLifeValue:SetText(PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_LIFEVALUE"))
  end
  self._ui._stc_Mutation_ContentBg:SetShow(true)
  self._ui._stc_Mutation_ContentBg:EraseEffect(_mutationHorseBGEffectKey)
  _mutationHorseBGEffectKey = self._ui._stc_Mutation_ContentBg:AddEffect("fUI_ingame_horse_01a", true)
  self:updateConsoleKeyGuide(true, self._isConsole)
end
function PaGlobal_ServantNameRegist_All:prepareClose()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  if false == _ContentsGroup_RenewUI then
    self._ui._stc_EditNaming:SetEditText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLEINFO_EDITBOX_COMMENT"), true)
  else
    local randIndex = getRandomValue(1, #PaGlobal_ServantFunction_All._randomName_ForConsole)
    self._ui._stc_EditNaming:SetEditText(PaGlobal_ServantFunction_All._randomName_ForConsole[randIndex])
  end
  ClearFocusEdit()
  PaGlobal_ServantNameRegist_All._mutationCharacterKey = nil
  PaGlobal_ServantNameRegist_All:close()
end
function PaGlobal_ServantNameRegist_All:close()
  if nil == Panel_Dialog_ServantNameRegist_All or false == Panel_Dialog_ServantNameRegist_All:GetShow() then
    return
  end
  Panel_Dialog_ServantNameRegist_All:SetShow(false)
end
function PaGlobal_ServantNameRegist_All:validate()
  if nil == Panel_Dialog_ServantNameRegist_All then
    return
  end
  self._ui._stc_Title:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_MainBg:isValidate()
  self._ui._stc_ContentBg:isValidate()
  self._ui._stc_HorseImage:isValidate()
  self._ui._stc_GenderIcon:isValidate()
  self._ui._txt_HpTitle:isValidate()
  self._ui._txt_HpValue:isValidate()
  self._ui._txt_StaminaTitle:isValidate()
  self._ui._txt_StaminaValue:isValidate()
  self._ui._txt_WeightTitle:isValidate()
  self._ui._txt_WeightValue:isValidate()
  self._ui._txt_LeftLifeTitle:isValidate()
  self._ui._txt_LeftLifeValue:isValidate()
  self._ui._txt_SpeedTitle:isValidate()
  self._ui._txt_SpeedValue:isValidate()
  self._ui._txt_AccelTitle:isValidate()
  self._ui._txt_AccelValue:isValidate()
  self._ui._txt_CorneringTitle:isValidate()
  self._ui._txt_CorneringValue:isValidate()
  self._ui._txt_BreakTitle:isValidate()
  self._ui._txt_BreakValue:isValidate()
  self._ui._stc_EditNaming:isValidate()
  self._ui._stc_EditRentalName:isValidate()
  self._ui._stc_PriceBg:isValidate()
  self._ui._txt_Price:isValidate()
  self._ui._rdo_Mine:isValidate()
  self._ui._rdo_All:isValidate()
  self._ui._btn_Confirm:isValidate()
  self._ui._btn_Cancel:isValidate()
  self._ui._stc_Console_KeyGuides:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui._stc_OnlySpeed:isValidate()
  self._ui._stc_Mutation_ContentBg:isValidate()
  self._ui._stc_Mutation_HorseImage:isValidate()
  self._ui._stc_Mutation_GenderIcon:isValidate()
  self._ui._txt_Mutation_HpTitle:isValidate()
  self._ui._txt_Mutation_HpValue:isValidate()
  self._ui._txt_Mutation_StaminaTitle:isValidate()
  self._ui._txt_Mutation_StaminaValue:isValidate()
  self._ui._txt_Mutation_WeightTitle:isValidate()
  self._ui._txt_Mutation_WeightValue:isValidate()
  self._ui._txt_Mutation_LeftLifeTitle:isValidate()
  self._ui._txt_Mutation_LeftLifeValue:isValidate()
  self._ui._txt_Mutation_SpeedTitle:isValidate()
  self._ui._txt_Mutation_SpeedValue:isValidate()
  self._ui._txt_Mutation_AccelTitle:isValidate()
  self._ui._txt_Mutation_AccelValue:isValidate()
  self._ui._txt_Mutation_CorneringTitle:isValidate()
  self._ui._txt_Mutation_CorneringValue:isValidate()
  self._ui._txt_Mutation_BreakTitle:isValidate()
  self._ui._txt_Mutation_BreakValue:isValidate()
  self._ui._stc_Mutation_KeyGuide_LT:isValidate()
  self._ui._stc_Mutation_KeyGuide_Plus:isValidate()
  self._ui._stc_Mutation_KeyGuide_X:isValidate()
  self._ui._stc_Mutation_EditNaming:isValidate()
  self._initialize = true
end
