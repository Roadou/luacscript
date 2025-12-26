function PaGlobal_CharacterStatDetail_All:initialize()
  if self._initialize == true then
    return
  end
  local stat = UI.getChildControl(Panel_Window_StatDetail_All, "Static_Detail_Stat")
  self._ui.btn_close = UI.getChildControl(Panel_Window_StatDetail_All, "Button_Close")
  self._ui.list2_Contents = UI.getChildControl(stat, "List2_Detail_Stat")
  self._ui.stc_padKeyGuid = UI.getChildControl(Panel_Window_StatDetail_All, "Static_BottomBg_ConsoleUI_Import")
  self._isConsole = _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    self._ui.stc_padKeyGuid:SetShow(true)
    local stc_keyGuide_B = UI.getChildControl(self._ui.stc_padKeyGuid, "StaticText_B_ConsoleUI")
    local keyGuideList = Array.new()
    keyGuideList:push_back(stc_keyGuide_B)
    for key, guide in pairs(keyGuideList) do
      if guide ~= nil then
        guide:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_padKeyGuid, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
  else
    self._ui.stc_padKeyGuid:SetShow(false)
  end
  self:registEventHandler()
  self:validate()
  self.STAT_ENUM.TRIBE_EDANIA_DD = 9
  for k in pairs(self.STAT_ENUM) do
    if self.STAT_ENUM[k] ~= nil then
      table.insert(self.STAT_ENUM_SORT, k)
    end
  end
  table.sort(self.STAT_ENUM_SORT, function(a, b)
    return self.STAT_ENUM[a] < self.STAT_ENUM[b]
  end)
  self._initialize = true
end
function PaGlobal_CharacterStatDetail_All:registEventHandler()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_CharacterStatDetail_All_Close()")
  self._ui.list2_Contents:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_CharacterStatDetail_All_ListUpdate")
  self._ui.list2_Contents:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_UpdatePlayerAttackStat", "PaGlobal_CharacterStatDetail_All_StatUpdate")
end
function PaGlobal_CharacterStatDetail_All:validate()
  self._ui.btn_close:isValidate()
  self._ui.list2_Contents:isValidate()
end
function PaGlobal_CharacterStatDetail_All:prepareOpen()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  self:setPanelPosition()
  self:update()
  self:open()
end
function PaGlobal_CharacterStatDetail_All:open()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  Panel_Window_StatDetail_All:SetShow(true)
end
function PaGlobal_CharacterStatDetail_All:prepareClose()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  self:close()
end
function PaGlobal_CharacterStatDetail_All:close()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  Panel_Window_StatDetail_All:SetShow(false)
end
function PaGlobal_CharacterStatDetail_All:update()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  self._ui.list2_Contents:getElementManager():clearKey()
  for _, k in ipairs(self.STAT_ENUM_SORT) do
    self._ui.list2_Contents:getElementManager():pushKey(self.STAT_ENUM[k])
  end
end
function PaGlobal_CharacterStatDetail_All:setPanelPosition()
  if Panel_Window_StatDetail_All == nil then
    return
  end
  local posX = Panel_Window_StatNew_All:GetPosX() - Panel_Window_StatDetail_All:GetSizeX() - 5
  local posY = Panel_Window_StatNew_All:GetPosY()
  Panel_Window_StatDetail_All:SetPosX(posX)
  Panel_Window_StatDetail_All:SetPosY(posY)
end
function PaGlobal_CharacterStatDetail_All:listContent(control, InputKey)
  if Panel_Window_StatDetail_All == nil then
    return
  end
  if nil == control or nil == InputKey then
    return
  end
  local offenceStat = ToClient_getCharacterAttackOffenceStat()
  local defenceStat = ToClient_getCharacterAttackDefenceStat()
  if offenceStat == nil or defenceStat == nil then
    return
  end
  local key = Int64toInt32(InputKey)
  if key < self.STAT_ENUM.MAIN_OFFENCE then
    return
  end
  local mainAttackType = ToClient_getMainAttackType()
  local title = UI.getChildControl(control, "StaticText_Value_Name1")
  local value = UI.getChildControl(control, "StaticText_Value1")
  local bg = UI.getChildControl(control, "Static_Text_BG")
  if title ~= nil then
    UI.setLimitTextAndAddTooltip(title)
  end
  local titleString = "-"
  local valueString = "-"
  local textureIndex = key % 2 + 1
  bg:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_Ability_List_BG_0" .. textureIndex)
  bg:setRenderTexture(bg:getBaseTexture())
  if key == self.STAT_ENUM.MAIN_OFFENCE then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_MAIN_WEAPON_DMG")
    valueString = ToClient_getAttackOffenceAll(__eSkillTypeParam_Succession, false, __eNewTribeType_Count, false)
  elseif key == self.STAT_ENUM.AWAKEN_OFFENCE then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_AWAKEN_WEAPON_DMG")
    valueString = ToClient_getAttackOffenceAll(__eSkillTypeParam_Awaken, false, __eNewTribeType_Count, false)
  elseif key == self.STAT_ENUM.MON_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_MON_ADDITIONAL_DMG")
    valueString = ToClient_getMonsterDDWithBonus()
  elseif key == self.STAT_ENUM.PLAYER_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_USER_ADDITIONAL_DMG")
    valueString = offenceStat:getAddedPlayerDD()
  elseif key == self.STAT_ENUM.TRIBE_HUMAN_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_HUMAN_ADDITIONAL_DMG")
    valueString = offenceStat:getTribeDD(__eNewTribeType_Human)
  elseif key == self.STAT_ENUM.TRIBE_AIN_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_AIN_ADDITIONAL_DMG")
    valueString = offenceStat:getTribeDD(__eNewTribeType_NonHuman)
  elseif key == self.STAT_ENUM.TRIBE_ANIMAL_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_ANIMAL_ADDITIONAL_DMG")
    valueString = offenceStat:getTribeDD(__eNewTribeType_Others)
  elseif key == self.STAT_ENUM.TRIBE_KAMASILVIA_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_KAMA_ADDITIONAL_DMG")
    valueString = offenceStat:getTribeDD(__eNewTribeType_Kamasilvia)
  elseif key == self.STAT_ENUM.TRIBE_EDANIA_DD then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DEVIL_ADDITIONAL_DMG")
    valueString = offenceStat:getTribeDD(__eNewTribeType_Edania)
  elseif key == self.STAT_ENUM.CRITIAL_PERENCT then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_CRITICAL_RATE")
    valueString = tostring(offenceStat:getCriticalAddPercentRate() / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.CRITIAL_DAMAGE then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_CRITICAL_ADDITIONAL_DMG")
    valueString = tostring(offenceStat:getCriticalAddDamageRate() / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.BACK_ATTAK_PERENCT then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_BACKATTACK_ADDITIONAL_DMG")
    valueString = tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Back) / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.AIR_ATTAK_PERENCT then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_AIRATTACK_ADDITIONAL_DMG")
    valueString = tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Air) / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.DOWN_ATTACK_PERENCT then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DOWNATTACK_ADDITIONAL_DMG")
    valueString = tostring(offenceStat:getAdditionalDamageRate(__eAdditionalDamageType_Down) / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.HIT then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_ACCURACY_RATE")
    valueString = ToClient_getAttackHitAll(mainAttackType)
  elseif key == self.STAT_ENUM.DV_1 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DODGE_NEAR")
    valueString = ToClient_getAttackDvAllWithAttackType(__eAttackTypeDirect)
  elseif key == self.STAT_ENUM.DV_2 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DODGE_FAR")
    valueString = ToClient_getAttackDvAllWithAttackType(__eAttackTypeRange)
  elseif key == self.STAT_ENUM.DV_3 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DODGE_MAGIC")
    valueString = ToClient_getAttackDvAllWithAttackType(__eAttackTypeMagical)
  elseif key == self.STAT_ENUM.PV_1 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_REDUCE_DMG_NEAR")
    valueString = ToClient_getAttackPvAllWithAttackType(__eAttackTypeDirect, false, false)
  elseif key == self.STAT_ENUM.PV_2 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_REDUCE_DMG_FAR")
    valueString = ToClient_getAttackPvAllWithAttackType(__eAttackTypeRange, false, false)
  elseif key == self.STAT_ENUM.PV_3 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_REDUCE_DMG_MAGIC")
    valueString = ToClient_getAttackPvAllWithAttackType(__eAttackTypeMagical, false, false)
  elseif key == self.STAT_ENUM.MON_PV then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_REDUCE_DMG_MON")
    valueString = ToClient_getMonsterPvWithBonus()
  elseif key == self.STAT_ENUM.PV_RATE then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DMG_REDUCTION_RATIO")
    valueString = tostring(ToClient_getAttackPvRateAll(false) / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.PV_RATE_MON then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_DMG_REDUCTION_RATIO_MON")
    valueString = tostring(defenceStat:getDamageResistanceFromMonsterAll() / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.CC_REG_1 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_RESIST_STUN")
    valueString = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Stun) / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.CC_REG_2 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_RESIST_KNOCKDOWN")
    valueString = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockdown) / CppDefine.e1Percent) .. "%"
  elseif key == self.STAT_ENUM.CC_REG_3 then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STAT_RENEWAL_RESIST_AIRBORNE")
    valueString = tostring(defenceStat:getActionRestrictResistance(__eActionRestrictStatType_Knockback) / CppDefine.e1Percent) .. "%"
  end
  title:SetText(titleString)
  value:SetText(valueString)
end
