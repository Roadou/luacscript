function PaGlobal_Dialog_HorseLevelDecrease_All:initialize()
  if PaGlobal_Dialog_HorseLevelDecrease_All._initialize == true then
    return
  end
  self._ui._txt_title = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "StaticText_Title")
  self._ui._stc_mainBg = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Static_MainBg")
  self._ui._stc_imageBG = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Static_ImageBG")
  self._ui._stc_horseImage = UI.getChildControl(self._ui._stc_imageBG, "Static_Image")
  self._ui._stc_horseGenderIcon = UI.getChildControl(self._ui._stc_horseImage, "Static_GenderIcon")
  self._ui._btn_horseSimulator = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Button_HorseSimulator")
  self._ui._btn_horseSimulator:SetTextMode(__eTextMode_LimitText)
  self._ui._btn_horseSimulator:SetText(self._ui._btn_horseSimulator:GetText())
  UI.setLimitTextAndAddTooltip(self._ui._btn_horseSimulator, self._ui._btn_horseSimulator:GetText())
  self._ui._stc_currentLevelBg = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Static_CurrentLevelBg")
  self._ui._txt_currentLevel_hpValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_HpValue")
  self._ui._txt_currentLevel_staminaValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_StaminaValue")
  self._ui._txt_currentLevel_weightValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_WeightValue")
  self._ui._txt_currentLevel_speedValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_SpeedValue")
  self._ui._txt_currentLevel_accelerationValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_AccelerationValue")
  self._ui._txt_currentLevel_corneringSpeedValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_currentLevel_breakValue = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_BreakValue")
  self._ui._txt_currentLevel_level = UI.getChildControl(self._ui._stc_currentLevelBg, "StaticText_Level")
  self._ui._stc_downLevelBg = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Static_DownLevelBg")
  self._ui._txt_downLevel_hpValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_HpValue")
  self._ui._txt_downLevel_staminaValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_StaminaValue")
  self._ui._txt_downLevel_weightValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_WeightValue")
  self._ui._txt_downLevel_speedValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_SpeedValue")
  self._ui._txt_downLevel_accelerationValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_AccelerationValue")
  self._ui._txt_downLevel_corneringSpeedValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_CorneringSpeedValue")
  self._ui._txt_downLevel_breakValue = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_BreakValue")
  self._ui._txt_downLevel_level = UI.getChildControl(self._ui._stc_downLevelBg, "StaticText_Level")
  self._ui._btn_close = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Button_Close")
  self._ui._btn_confirm = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Button_Confirm")
  self._ui._btn_cancel = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Button_Cancel")
  self._ui._stc_skillReset = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Static_SkillReset")
  self._ui._stc_skillIcon = UI.getChildControl(self._ui._stc_skillReset, "Static_SkillIcon")
  self._ui._txt_skillName = UI.getChildControl(self._ui._stc_skillReset, "StaticText_SkillName")
  self._ui._txt_priceBg = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "StaticText_PriceBg")
  self._ui._txt_priceValue = UI.getChildControl(self._ui._txt_priceBg, "StaticText_PriceValue")
  self._ui._stc_bottomBg_consoleUI = UI.getChildControl(Panel_Dialog_HorseLevelDecrease_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_bottomBg_consoleUI_A = UI.getChildControl(self._ui._stc_bottomBg_consoleUI, "StaticText_A_ConsoleUI")
  self._ui._stc_bottomBg_consoleUI_B = UI.getChildControl(self._ui._stc_bottomBg_consoleUI, "StaticText_B_ConsoleUI")
  self._ui._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LEVEL_DOWN"))
  PaGlobal_Dialog_HorseLevelDecrease_All:registEventHandler()
  PaGlobal_Dialog_HorseLevelDecrease_All:validate()
  PaGlobal_Dialog_HorseLevelDecrease_All._initialize = true
end
function PaGlobal_Dialog_HorseLevelDecrease_All:registEventHandler()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  registerEvent("FromClient_OpenServantLevelDown", "PaGlobal_Dialog_HorseLevelDecrease_All_Open")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_Dialog_HorseLevelDecrease_All:requestDecreaseServantLevel()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Dialog_HorseLevelDecrease_All_Close()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_Dialog_HorseLevelDecrease_All_Close()")
  self._ui._btn_horseSimulator:addInputEvent("Mouse_LUp", "PaGlobal_Dialog_HorseLevelDecrease_All:openServantSimulator()")
  if _ContentsGroup_UsePadSnapping == true then
    self._ui._btn_close:SetShow(false)
    self._ui._stc_bottomBg_consoleUI:SetShow(true)
  end
end
function PaGlobal_Dialog_HorseLevelDecrease_All:prepareOpen(servantNo, downHp, downMp, downWeight, downSpeed, downAcceleration, downCornering, downBrake, vehicleSkillKey)
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if servantInfo == nil then
    return
  end
  self._servantNo = servantNo
  local vehicleType = servantInfo:getVehicleType()
  self._ui._txt_currentLevel_level:SetText()
  self._ui._stc_horseImage:ChangeTextureInfoNameAsync(servantInfo:getIconPath1())
  self._ui._stc_horseGenderIcon:SetShow(false)
  if (vehicleType == CppEnums.VehicleType.Type_Horse or vehicleType == CppEnums.VehicleType.Type_RaceHorse) and true == servantInfo:isDisplayGender() then
    self._ui._stc_horseGenderIcon:SetShow(true)
    self._ui._stc_horseGenderIcon:ChangeTextureInfoNameAsync("combine/etc/combine_etc_stable.dds")
    local x1, y1, x2, y2 = 0, 0, 0, 0
    if true == servantInfo:isMale() then
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_horseGenderIcon, 1, 209, 31, 239)
    else
      x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_horseGenderIcon, 1, 178, 31, 208)
    end
    self._ui._stc_horseGenderIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_horseGenderIcon:setRenderTexture(self._ui._stc_horseGenderIcon:getBaseTexture())
  end
  local skillWrapper = servantInfo:getSkill(vehicleSkillKey)
  if skillWrapper ~= nil then
    self._ui._stc_skillReset:SetShow(true)
    self._ui._stc_skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillWrapper:getIconPath())
    self._ui._txt_skillName:SetText(skillWrapper:getName())
  else
    self._ui._stc_skillReset:SetShow(false)
  end
  local currentSpeedPercent = tonumber(string.format("%.1f", servantInfo:getStatExceptEquip(CppEnums.ServantStatType.Type_MaxMoveSpeed) / 10000))
  local currentAccelerationPercent = tonumber(string.format("%.1f", servantInfo:getStatExceptEquip(CppEnums.ServantStatType.Type_Acceleration) / 10000))
  local currentCorneringPercent = tonumber(string.format("%.1f", servantInfo:getStatExceptEquip(CppEnums.ServantStatType.Type_CorneringSpeed) / 10000))
  local currentBrakePercent = tonumber(string.format("%.1f", servantInfo:getStatExceptEquip(CppEnums.ServantStatType.Type_BrakeSpeed) / 10000))
  local downSpeedPercent = tonumber(string.format("%.1f", downSpeed / 10000))
  local downAccelerationPercent = tonumber(string.format("%.1f", downAcceleration / 10000))
  local downCorneringPercent = tonumber(string.format("%.1f", downCornering / 10000))
  local downBrakePercent = tonumber(string.format("%.1f", downBrake / 10000))
  local level = servantInfo:getLevel()
  self._ui._txt_currentLevel_level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", level))
  self._ui._txt_downLevel_level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORKERAUCTION_WORKERLEVEL", "level", level - 1))
  local currentMaxHp = servantInfo:getMaxHpExceptEquip()
  local currentMaxStamina = servantInfo:getMaxMpExceptEquip()
  self._ui._txt_currentLevel_hpValue:SetText(currentMaxHp)
  self._ui._txt_currentLevel_staminaValue:SetText(currentMaxStamina)
  local max_weight_s64 = servantInfo:getMaxWeight_s64()
  self._ui._txt_currentLevel_weightValue:SetText(makeWeightString(max_weight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  self._ui._txt_currentLevel_speedValue:SetText(string.format("%.1f", currentSpeedPercent) .. "%")
  self._ui._txt_currentLevel_accelerationValue:SetText(string.format("%.1f", currentAccelerationPercent) .. "%")
  self._ui._txt_currentLevel_corneringSpeedValue:SetText(string.format("%.1f", currentCorneringPercent) .. "%")
  self._ui._txt_currentLevel_breakValue:SetText(string.format("%.1f", currentBrakePercent) .. "%")
  local colorString = " <PAColor0xFFD05D48>("
  local downWeight_s64 = toInt64(0, downWeight)
  local diffWeightValue = downWeight_s64 - max_weight_s64
  self._ui._txt_downLevel_hpValue:SetText(downHp .. colorString .. downHp - currentMaxHp .. ")<PAOldColor>")
  self._ui._txt_downLevel_staminaValue:SetText(downMp .. colorString .. downMp - currentMaxStamina .. ")<PAOldColor>")
  self._ui._txt_downLevel_weightValue:SetText(makeWeightString(downWeight_s64, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT") .. colorString .. makeWeightString(diffWeightValue, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT") .. ")<PAOldColor>")
  self._ui._txt_downLevel_speedValue:SetText(string.format("%.1f", downSpeedPercent) .. "%" .. colorString .. string.format("%.1f", downSpeedPercent - currentSpeedPercent) .. "%)<PAOldColor>")
  self._ui._txt_downLevel_accelerationValue:SetText(string.format("%.1f", downAccelerationPercent) .. "%" .. colorString .. string.format("%.1f", downAccelerationPercent - currentAccelerationPercent) .. "%)<PAOldColor>")
  self._ui._txt_downLevel_corneringSpeedValue:SetText(string.format("%.1f", downCorneringPercent) .. "%" .. colorString .. string.format("%.1f", downCorneringPercent - currentCorneringPercent) .. "%)<PAOldColor>")
  self._ui._txt_downLevel_breakValue:SetText(string.format("%.1f", downBrakePercent) .. "%" .. colorString .. string.format("%.1f", downBrakePercent - currentBrakePercent) .. "%)<PAOldColor>")
  PaGlobal_Dialog_HorseLevelDecrease_All:open()
end
function PaGlobal_Dialog_HorseLevelDecrease_All:open()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  Panel_Dialog_HorseLevelDecrease_All:SetShow(true)
end
function PaGlobal_Dialog_HorseLevelDecrease_All:prepareClose()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  self._servantNo = nil
  PaGlobal_Dialog_HorseLevelDecrease_All:close()
end
function PaGlobal_Dialog_HorseLevelDecrease_All:close()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  Panel_Dialog_HorseLevelDecrease_All:SetShow(false)
end
function PaGlobal_Dialog_HorseLevelDecrease_All:update()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
end
function PaGlobal_Dialog_HorseLevelDecrease_All:validate()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_imageBG:isValidate()
  self._ui._stc_horseImage:isValidate()
  self._ui._stc_horseGenderIcon:isValidate()
  self._ui._btn_horseSimulator:isValidate()
  self._ui._stc_currentLevelBg:isValidate()
  self._ui._txt_currentLevel_hpValue:isValidate()
  self._ui._txt_currentLevel_staminaValue:isValidate()
  self._ui._txt_currentLevel_weightValue:isValidate()
  self._ui._txt_currentLevel_speedValue:isValidate()
  self._ui._txt_currentLevel_accelerationValue:isValidate()
  self._ui._txt_currentLevel_corneringSpeedValue:isValidate()
  self._ui._txt_currentLevel_breakValue:isValidate()
  self._ui._stc_downLevelBg:isValidate()
  self._ui._txt_downLevel_hpValue:isValidate()
  self._ui._txt_downLevel_staminaValue:isValidate()
  self._ui._txt_downLevel_weightValue:isValidate()
  self._ui._txt_downLevel_speedValue:isValidate()
  self._ui._txt_downLevel_accelerationValue:isValidate()
  self._ui._txt_downLevel_corneringSpeedValue:isValidate()
  self._ui._txt_downLevel_breakValue:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._stc_skillReset:isValidate()
  self._ui._stc_skillIcon:isValidate()
  self._ui._txt_skillName:isValidate()
  self._ui._txt_priceBg:isValidate()
  self._ui._txt_priceValue:isValidate()
  self._ui._stc_bottomBg_consoleUI:isValidate()
  self._ui._stc_bottomBg_consoleUI_A:isValidate()
  self._ui._stc_bottomBg_consoleUI_B:isValidate()
end
function PaGlobal_Dialog_HorseLevelDecrease_All:requestDecreaseServantLevel()
  if Panel_Dialog_HorseLevelDecrease_All == nil or Panel_Dialog_HorseLevelDecrease_All:GetShow() == false then
    return
  end
  if doHaveContentsItem(__eContentsType_DecreaseServantLevel) == false then
    if ToClient_isConsole() == true then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInventoryItemNotExist"))
      return
    end
    local EasyBuyOpen = function()
      PaGlobalFunc_EasyBuy_Open(133, nil, false)
    end
    local _title = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LEVEL_DOWN")
    local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_NOT_FOUND_ITEM_LEVEL_DOWN")
    local _confirmFunction = EasyBuyOpen
    local _cancel = MessageBox_Empty_function
    local _priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    local messageboxData = {
      title = _title,
      content = _desc,
      functionYes = _confirmFunction,
      functionNo = _cancel,
      priority = _priority
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  local function requestDecreaseServantLevel_Confirm()
    ToClient_decreaseServantLevel(self._servantNo)
    self:prepareClose()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LEVELDOWN_ITEM_USE_MSG"),
    functionYes = requestDecreaseServantLevel_Confirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_Dialog_HorseLevelDecrease_All:openServantSimulator()
  if Panel_Dialog_HorseLevelDecrease_All == nil then
    return
  end
  if _ContentsGroup_HorseSimulator == false then
    return
  end
  if self._servantNo == nil then
    return
  end
  if PaGlobalFunc_ServantSimulator_IsShow() == true then
    PaGlobalFunc_ServantSimulator_Close()
  else
    local openTabList = {
      [1] = PaGlobal_ServantSimulator._tabType.GROWUP,
      [2] = PaGlobal_ServantSimulator._tabType.MATING,
      [3] = PaGlobal_ServantSimulator._tabType.DETAIL
    }
    local servantInfo = stable_getServantByServantNo(self._servantNo)
    if servantInfo == nil then
      return
    end
    local level = servantInfo:getLevel()
    local maxLevel = ToClient_GetHorseSimulateGrowUpVariableStatLevelMax()
    if level < 2 or level > maxLevel then
      return
    end
    PaGlobalFunc_ServantSimulator_Open(openTabList, self._servantNo, level - 1)
  end
end
