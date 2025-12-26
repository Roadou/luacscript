function PaGlobal_CharacterStatNew_All:initialize()
  if PaGlobal_CharacterStatNew_All._initialize == true then
    return
  end
  local titleBg = UI.getChildControl(Panel_Window_StatNew_All, "Static_TitleBg")
  local bg1 = UI.getChildControl(Panel_Window_StatNew_All, "Static_TextBG1")
  local title1 = UI.getChildControl(bg1, "Static_Title1")
  self._ui.stc_titleText_PVE = UI.getChildControl(title1, "StaticText_Title_PVE")
  local bg2 = UI.getChildControl(Panel_Window_StatNew_All, "Static_TextBG2")
  local title2 = UI.getChildControl(bg2, "Static_Title2")
  local subTitle = UI.getChildControl(title1, "StaticText_Title_Stat")
  if subTitle ~= nil then
    UI.setLimitTextAndAddTooltip(subTitle)
  end
  local subTitle2 = UI.getChildControl(title2, "StaticText_Title_Stat")
  if subTitle2 ~= nil then
    UI.setLimitTextAndAddTooltip(subTitle2)
  end
  for index = 1, self.STAT_ENUM.COUNT - 1 do
    local uicontrol = {
      [0] = nil,
      [1] = nil
    }
    self._uiValue[index] = uicontrol
    local staticText
    if index < self.STAT_ENUM.PERCENT_CRI then
      staticText = UI.getChildControl(bg1, "StaticText_StatName" .. index)
      self._uiValue[index][0] = UI.getChildControl(bg1, "StaticText_PVE_Stat" .. index)
      self._uiValue[index][1] = UI.getChildControl(bg1, "StaticText_PVP_Stat" .. index)
    else
      staticText = UI.getChildControl(bg2, "StaticText_StatName" .. 1 + (index - self.STAT_ENUM.PERCENT_CRI))
      self._uiValue[index][0] = UI.getChildControl(bg2, "StaticText_Common" .. 1 + (index - self.STAT_ENUM.PERCENT_CRI))
      self._uiValue[index][1] = nil
    end
    if staticText ~= nil then
      UI.setLimitTextAndAddTooltip(staticText)
    end
  end
  self._ui.btn_close = UI.getChildControl(titleBg, "Button_Close_PCUI")
  self._ui.btn_detail = UI.getChildControl(Panel_Window_StatNew_All, "Button_Detail_Stat")
  self._ui.btn_bonusStat = UI.getChildControl(Panel_Window_StatNew_All, "Button_Bonus_Stat")
  self._ui.stc_padKeyGuide = UI.getChildControl(Panel_Window_StatNew_All, "Static_BottomBg_ConsoleUI_Import")
  if self._ui.btn_detail ~= nil then
    UI.setLimitTextAndAddTooltip(self._ui.btn_detail)
  end
  if self._ui.btn_bonusStat ~= nil then
    UI.setLimitTextAndAddTooltip(self._ui.btn_bonusStat)
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    self._ui.stc_padKeyGuide:SetShow(true)
  else
    self._ui.stc_padKeyGuide:SetShow(false)
  end
  PaGlobal_CharacterStatNew_All:registEventHandler()
  PaGlobal_CharacterStatNew_All:validate()
  local keyA = UI.getChildControl(self._ui.stc_padKeyGuide, "StaticText_KeyGuide_A")
  local keyB = UI.getChildControl(self._ui.stc_padKeyGuide, "StaticText_B_ConsoleUI")
  local keyGuides = {keyA, keyB}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_padKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_CharacterStatNew_All._initialize = true
end
function PaGlobal_CharacterStatNew_All:registEventHandler()
  if Panel_Window_StatNew_All == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_CharacterStatNew_Close()")
  self._ui.btn_detail:addInputEvent("Mouse_LUp", "PaGlobal_CharacterStatDetail_All_Open()")
  if ToClient_isConsole() == true then
    self._ui.btn_bonusStat:addInputEvent("Mouse_LUp", "PaGlobalFunc_CharacterStatNew_OpenBonusStatBrowserConsole()")
  else
    self._ui.btn_bonusStat:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"BonusStat\" )")
  end
  registerEvent("FromClient_UpdatePlayerAttackStat", "PaGlobal_CharacterStatNew_Update")
end
function PaGlobal_CharacterStatNew_All:validate()
  self._ui.stc_titleText_PVE:isValidate()
  for index = 1, self.STAT_ENUM.COUNT - 1 do
    self._uiValue[index][0]:isValidate()
    if index < self.STAT_ENUM.PERCENT_CRI then
      self._uiValue[index][1]:isValidate()
    end
  end
end
function PaGlobal_CharacterStatNew_All:prepareOpen()
  if Panel_Window_StatNew_All == nil then
    return
  end
  self:setPanelPosition()
  self:updateValue()
  self:open()
end
function PaGlobal_CharacterStatNew_All:open()
  if Panel_Window_StatNew_All == nil then
    return
  end
  Panel_Window_StatNew_All:SetShow(true)
end
function PaGlobal_CharacterStatNew_All:prepareClose()
  if Panel_Window_StatNew_All == nil then
    return
  end
  if Panel_Window_StatDetail_All:GetShow() == true then
    PaGlobal_CharacterStatDetail_All_Close()
  end
  self:close()
end
function PaGlobal_CharacterStatNew_All:close()
  if Panel_Window_StatNew_All == nil then
    return
  end
  Panel_Window_StatNew_All:SetShow(false)
end
function PaGlobal_CharacterStatNew_All:updateValue()
  if Panel_Window_StatNew_All == nil then
    return
  end
  local offenceStat = ToClient_getCharacterAttackOffenceStat()
  local defenceStat = ToClient_getCharacterAttackDefenceStat()
  if offenceStat == nil or defenceStat == nil then
    return
  end
  local addAtkType = ToClient_GetNotationAbilityOption_AddAtkType()
  local newTribeType = __eNewTribeType_Count
  if addAtkType == __eUINotationAbilityAddAtkType_Kamasylvia then
    newTribeType = __eNewTribeType_Kamasilvia
  elseif addAtkType == __eUINotationAbilityAddAtkType_Ain then
    newTribeType = __eNewTribeType_NonHuman
  elseif addAtkType == __eUINotationAbilityAddAtkType_Human then
    newTribeType = __eNewTribeType_Human
  elseif addAtkType == __eUINotationAbilityAddAtkType_Edania then
    newTribeType = __eNewTribeType_Edania
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    local fontColor = PaGlobalFunc_NotationAbility_GetFontColor()
    local glowFontColor = PaGlobalFunc_NotationAbility_GetGlowFontColor()
    self._ui.stc_titleText_PVE:SetFontColor(fontColor)
    self._ui.stc_titleText_PVE:useGlowFont(true, "RealFont_16_Base", glowFontColor)
    for index = 1, self.STAT_ENUM.PERCENT_CRI - 1 do
      self._uiValue[index][0]:SetFontColor(fontColor)
      self._uiValue[index][0]:useGlowFont(true, "RealFont_16_Base", glowFontColor)
    end
  end
  local mainAttackType = ToClient_getMainAttackType()
  local dd_1_pve = ToClient_getAttackOffenceAll(__eSkillTypeParam_Succession, true, newTribeType, false)
  local dd_1_pvp = ToClient_getAttackOffenceAll(__eSkillTypeParam_Succession, false, __eNewTribeType_Count, true)
  local dd_2_pve = ToClient_getAttackOffenceAll(__eSkillTypeParam_Awaken, true, newTribeType, false)
  local dd_3_pvp = ToClient_getAttackOffenceAll(__eSkillTypeParam_Awaken, false, __eNewTribeType_Count, true)
  self._uiValue[self.STAT_ENUM.MAIN_OFFENCE][0]:SetText(dd_1_pve)
  self._uiValue[self.STAT_ENUM.MAIN_OFFENCE][1]:SetText(dd_1_pvp)
  self._uiValue[self.STAT_ENUM.AWAKEN_OFFENCE][0]:SetText(dd_2_pve)
  self._uiValue[self.STAT_ENUM.AWAKEN_OFFENCE][1]:SetText(dd_3_pvp)
  local hit = ToClient_getAttackHitAll(mainAttackType)
  self._uiValue[self.STAT_ENUM.HIT][0]:SetText(hit)
  self._uiValue[self.STAT_ENUM.HIT][1]:SetText(hit)
  local dv_1 = ToClient_getAttackDvAllWithAttackType(__eAttackTypeDirect)
  local dv_2 = ToClient_getAttackDvAllWithAttackType(__eAttackTypeRange)
  local dv_3 = ToClient_getAttackDvAllWithAttackType(__eAttackTypeMagical)
  self._uiValue[self.STAT_ENUM.DV_1][0]:SetText(dv_1)
  self._uiValue[self.STAT_ENUM.DV_1][1]:SetText(dv_1)
  self._uiValue[self.STAT_ENUM.DV_2][0]:SetText(dv_2)
  self._uiValue[self.STAT_ENUM.DV_2][1]:SetText(dv_2)
  self._uiValue[self.STAT_ENUM.DV_3][0]:SetText(dv_3)
  self._uiValue[self.STAT_ENUM.DV_3][1]:SetText(dv_3)
  local pv1_pve = ToClient_getAttackPvAllWithAttackType(__eAttackTypeDirect, true, false)
  local pv2_pve = ToClient_getAttackPvAllWithAttackType(__eAttackTypeRange, true, false)
  local pv3_pve = ToClient_getAttackPvAllWithAttackType(__eAttackTypeMagical, true, false)
  local pv1_pvp = ToClient_getAttackPvAllWithAttackType(__eAttackTypeDirect, false, true)
  local pv2_pvp = ToClient_getAttackPvAllWithAttackType(__eAttackTypeRange, false, true)
  local pv3_pvp = ToClient_getAttackPvAllWithAttackType(__eAttackTypeMagical, false, true)
  self._uiValue[self.STAT_ENUM.PV_1][0]:SetText(pv1_pve)
  self._uiValue[self.STAT_ENUM.PV_2][0]:SetText(pv2_pve)
  self._uiValue[self.STAT_ENUM.PV_3][0]:SetText(pv3_pve)
  self._uiValue[self.STAT_ENUM.PV_1][1]:SetText(pv1_pvp)
  self._uiValue[self.STAT_ENUM.PV_2][1]:SetText(pv2_pvp)
  self._uiValue[self.STAT_ENUM.PV_3][1]:SetText(pv3_pvp)
  local pvePvRateAll = ToClient_getAttackPvRateAll(true) / CppDefine.e1Percent
  local pvpPvRateAll = ToClient_getAttackPvRateAll(false) / CppDefine.e1Percent
  self._uiValue[self.STAT_ENUM.PV_RATE][0]:SetText(tostring(pvePvRateAll) .. "%")
  self._uiValue[self.STAT_ENUM.PV_RATE][1]:SetText(tostring(pvpPvRateAll) .. "%")
  local cc1 = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Stun) / CppDefine.e1Percent) .. "%"
  local cc2 = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockdown) / CppDefine.e1Percent) .. "%"
  local cc3 = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockback) / CppDefine.e1Percent) .. "%"
  self._uiValue[self.STAT_ENUM.CC_REG_1][0]:SetText(cc1)
  self._uiValue[self.STAT_ENUM.CC_REG_2][0]:SetText(cc2)
  self._uiValue[self.STAT_ENUM.CC_REG_3][0]:SetText(cc3)
  self._uiValue[self.STAT_ENUM.CC_REG_1][1]:SetText("-")
  self._uiValue[self.STAT_ENUM.CC_REG_2][1]:SetText("-")
  self._uiValue[self.STAT_ENUM.CC_REG_3][1]:SetText("-")
  local criticalAddPercent = offenceStat:getCriticalAddPercentRate() / CppDefine.e1Percent
  local textCriAddPercent = tostring(criticalAddPercent) .. "%"
  self._uiValue[self.STAT_ENUM.PERCENT_CRI][0]:SetText(textCriAddPercent)
  local criticalAddDamage = offenceStat:getCriticalAddDamageRate() / CppDefine.e1Percent
  local textCriAddDamage = tostring(criticalAddDamage) .. "%"
  self._uiValue[self.STAT_ENUM.PERCENT_CRI_DAMAGE][0]:SetText(textCriAddDamage)
  local backAttackAddDamage = offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Back) / CppDefine.e1Percent
  local backAttackAddDamage = tostring(backAttackAddDamage) .. "%"
  self._uiValue[self.STAT_ENUM.PERCENT_BACK_DAMAGE][0]:SetText(backAttackAddDamage)
  local airAttackAddDamage = offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Air) / CppDefine.e1Percent
  local textairAttackAddDamage = tostring(airAttackAddDamage) .. "%"
  self._uiValue[self.STAT_ENUM.PERCENT_AIR_DAMAGE][0]:SetText(textairAttackAddDamage)
  local downAddDamage = offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Down) / CppDefine.e1Percent
  local textDownAddDamage = tostring(downAddDamage) .. "%"
  self._uiValue[self.STAT_ENUM.PERCENT_DOWN_DAMAGE][0]:SetText(textDownAddDamage)
end
function PaGlobal_CharacterStatNew_All:setPanelPosition()
  if Panel_Window_StatNew_All == nil then
    return
  end
  if Panel_CharacterInfo_All ~= nil and Panel_CharacterInfo_All:GetShow() == true then
    local posX = Panel_CharacterInfo_All:GetPosX() + Panel_CharacterInfo_All:GetSizeX() + 5
    local posY = Panel_CharacterInfo_All:GetPosY()
    Panel_Window_StatNew_All:SetPosX(posX)
    Panel_Window_StatNew_All:SetPosY(posY)
  end
  if Panel_Window_Equipment_All ~= nil and Panel_Window_Equipment_All:GetShow() == true then
    local posX = Panel_Window_Equipment_All:GetPosX() - Panel_Window_StatNew_All:GetSizeX() - 5
    local posY = Panel_Window_Equipment_All:GetPosY()
    Panel_Window_StatNew_All:SetPosX(posX)
    Panel_Window_StatNew_All:SetPosY(posY)
  end
  if Panel_Window_Inventory ~= nil and Panel_Window_Inventory:GetShow() == true and self._isConsole then
    local posX = Panel_Window_Inventory:GetPosX() - Panel_Window_Inventory:GetSizeX() + 15
    local posY = Panel_Window_Inventory:GetPosY()
    Panel_Window_StatNew_All:SetPosX(posX)
    Panel_Window_StatNew_All:SetPosY(posY)
  end
end
function PaGlobal_CharacterStatNew_All:getRateText(value)
  local tempValue = math.floor(value / 100)
  local floorValue = math.floor(tempValue / 100)
  local notFloorValue = tempValue / 100
  if floorValue == notFloorValue then
    return tostring(floorValue)
  else
    return string.format("%.2f", notFloorValue)
  end
  return tostring(floorValue)
end
