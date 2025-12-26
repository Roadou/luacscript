function PaGlobalFunc_NotationAbility_ToggleShow(fromPanel)
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  if Panel_Notation_Ability:GetShow() == true then
    self:prepareClose()
  else
    if fromPanel == nil then
      return
    end
    self:prepareOpen(fromPanel)
  end
end
function PaGlobalFunc_NotationAbility_Close()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_NotationAbility_CloseIfShow()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  if Panel_Notation_Ability:GetShow() == true then
    self:prepareClose()
  end
end
function PaGlobalFunc_NotationAbility_ChangeViewTypeByCheckButton(checkButton)
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  if checkButton:IsCheck() == true then
    PaGlobalFunc_NotationAbility_ChangeViewType(__eUINotationAbilityViewType_Total)
  else
    PaGlobalFunc_NotationAbility_ChangeViewType(__eUINotationAbilityViewType_Equip)
  end
end
function PaGlobalFunc_NotationAbility_ChangeViewType(viewType)
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  ToClient_SetNotationAbilityOption_ViewType(viewType)
  if viewType == __eUINotationAbilityViewType_Equip then
    ToClient_SetNotationAbilityOption_AddAtkType(__eUINotationAbilityAddAtkType_Count)
    ToClient_SetNotationAbilityOption_AddMonsterAtk(false)
  elseif viewType == __eUINotationAbilityViewType_Total then
    ToClient_SetNotationAbilityOption_AddAtkType(__eUINotationAbilityAddAtkType_None)
    ToClient_SetNotationAbilityOption_AddMonsterAtk(true)
  end
  self:updateButtonState()
  self:updateOtherUI()
end
function PaGlobalFunc_NotationAbility_ChangeAddAtkType(addAtkType)
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  ToClient_SetNotationAbilityOption_AddAtkType(addAtkType)
  self:updateButtonState()
  self:updateOtherUI()
end
function PaGlobalFunc_NotationAbility_ChangeAddMonsterAtk()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  ToClient_SetNotationAbilityOption_AddMonsterAtk(self._ui._chk_addMonsterAtk:IsCheck() == true)
  self:updateButtonState()
  self:updateOtherUI()
end
function PaGlobalFunc_NotationAbility_IsLateInitialized()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return false
  end
  return self._initializeLate
end
function PaGlobalFunc_NotationAbility_GetMyAtk()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return 0
  end
  return self:getMyAtk()
end
function PaGlobalFunc_NotationAbility_GetMyAwakenAtk()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return 0
  end
  return self:getMyAwakenAtk()
end
function PaGlobalFunc_NotationAbility_GetMyDef()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return 0
  end
  return self:getMyDef()
end
function PaGlobalFunc_NotationAbility_GetIconColor()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return Defines.Color.C_FFEEEEEE
  end
  return self:getIconColor()
end
function PaGlobalFunc_NotationAbility_GetFontColor()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return Defines.Color.C_FFEEEEEE
  end
  return self:getFontColor()
end
function PaGlobalFunc_NotationAbility_GetGlowFontColor()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return Defines.Color.C_FFEEEEEE
  end
  return self:getGlowFontColor()
end
function FromClient_NotationAbility_OnChangeStatus()
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  if self._initializeLate == true then
    self:updateOtherUI()
  end
end
function HandleEventOnOut_NotationAbility_ShowButtonTooltip(isShow, btnIndex)
  local self = PaGlobal_NotationAbility
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control
  local name = ""
  local desc = ""
  if btnIndex == 0 then
    control = self._ui._rdo_showEquipAbility
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_EQUIP_TOOLTIP_DESC")
  elseif btnIndex == 1 then
    control = self._ui._rdo_showTotalAbility
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_TOTAL_TOOLTIP_DESC")
  elseif btnIndex == 2 then
    control = self._ui._chk_addMonsterAtk
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_MONSTER_TOOLTIP_DESC")
  elseif btnIndex == 3 then
    control = self._ui._rdo_addKindNone
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_NONE_TOOLTIP_DESC")
  elseif btnIndex == 4 then
    control = self._ui._rdo_addKindKamaAtk
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_KAMASILVIA_TOOLTIP_DESC")
  elseif btnIndex == 5 then
    control = self._ui._rdo_addKindAinAtk
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_AIN_TOOLTIP_DESC")
  elseif btnIndex == 6 then
    control = self._ui._rdo_addKindHumanAtk
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_HUMAN_TOOLTIP_DESC")
  elseif btnIndex == 7 then
    control = self._ui._rdo_addKindEdaniaAtk
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_ABILITY_SET_EDANIA_TOOLTIP_DESC")
  else
    UI.ASSERT_NAME(false, "\235\178\132\237\138\188\236\157\180 \236\182\148\234\176\128\235\144\152\235\169\180 \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148!", "\236\157\180\236\163\188")
  end
  if control ~= nil then
    name = control:GetText()
    TooltipSimple_Show(control, name, desc)
  end
end
