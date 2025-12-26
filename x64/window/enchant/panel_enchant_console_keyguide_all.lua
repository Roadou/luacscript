PaGlobal_Enchant_Console_KeyGuide = {
  _ui = {
    stc_keyGuideBg = nil,
    txt_A = nil,
    txt_B = nil,
    txt_RS = nil,
    txt_LT_X = nil,
    txt_LT_Y = nil,
    txt_LS = nil,
    txt_RSHri = nil,
    txt_X = nil,
    txt_RT_X = nil,
    txt_RT_Y = nil,
    txt_RT_A = nil,
    txt_LT_A = nil
  },
  _ENUM = {
    TXT_A = 1,
    TXT_B = 2,
    TXT_RS = 3,
    TXT_LT_X = 4,
    TXT_LT_Y = 5,
    TXT_LS = 6,
    TXT_RSHRI = 7,
    TXT_X = 8,
    TXT_RT_X = 9,
    TXT_RT_Y = 10,
    TXT_RT_A = 11,
    TXT_LT_A = 12
  },
  _keyGuideOrder = {},
  _isInitialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Enchant_Console_KeyGuide_All_Init")
function FromClient_Enchant_Console_KeyGuide_All_Init()
  PaGlobal_Enchant_Console_KeyGuide:initialize()
end
function PaGlobal_Enchant_Console_KeyGuide:initialize()
  if self._isInitialize == true then
    return
  end
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Enchant_Console_KeyGuide, "StaticText_KeyGuideBg_ConsoleUIRight")
  self._ui.txt_A = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.txt_B = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.txt_RS = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_RS_ConsoleUI")
  self._ui.txt_LT_X = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_LT_X_ConsoleUI")
  self._ui.txt_LT_Y = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_LT_Y_ConsoleUI")
  self._ui.txt_LS = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_LS_ConsoleUI")
  self._ui.txt_RSHri = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_RSHri_ConsoleUI")
  self._ui.txt_X = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui.txt_RT_X = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_RT_X_ConsoleUI")
  self._ui.txt_RT_Y = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_RT_Y_ConsoleUI")
  self._ui.txt_RT_A = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_RT_A_ConsoleUI")
  self._ui.txt_LT_A = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_KeyGuide_LT_A_ConsoleUI")
  self._keyGuideOrder = {
    {
      id = self._ENUM.TXT_A,
      control = self._ui.txt_A,
      always = true
    },
    {
      id = self._ENUM.TXT_B,
      control = self._ui.txt_B,
      always = true
    },
    {
      id = self._ENUM.TXT_RS,
      control = self._ui.txt_RS,
      always = true
    },
    {
      id = self._ENUM.TXT_LT_X,
      control = self._ui.txt_LT_X,
      always = false
    },
    {
      id = self._ENUM.TXT_LT_Y,
      control = self._ui.txt_LT_Y,
      always = false
    },
    {
      id = self._ENUM.TXT_LS,
      control = self._ui.txt_LS,
      always = true
    },
    {
      id = self._ENUM.TXT_RSHRI,
      control = self._ui.txt_RSHri,
      always = false
    },
    {
      id = self._ENUM.TXT_X,
      control = self._ui.txt_X,
      always = true
    },
    {
      id = self._ENUM.TXT_RT_X,
      control = self._ui.txt_RT_X,
      always = false
    },
    {
      id = self._ENUM.TXT_RT_Y,
      control = self._ui.txt_RT_Y,
      always = false
    },
    {
      id = self._ENUM.TXT_RT_A,
      control = self._ui.txt_RT_A,
      always = false
    },
    {
      id = self._ENUM.TXT_LT_A,
      control = self._ui.txt_LT_A,
      always = false
    }
  }
  self._isInitialize = true
end
function PaGlobal_Enchant_Console_KeyGuide:prepareOpen()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_Enchant_Console_KeyGuide:open()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  Panel_Enchant_Console_KeyGuide:SetShow(true)
end
function PaGlobal_Enchant_Console_KeyGuide:prepareClose()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  self:close()
end
function PaGlobal_Enchant_Console_KeyGuide:close()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  Panel_Enchant_Console_KeyGuide:SetShow(false)
end
function PaGlobal_Enchant_Console_KeyGuide:update()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  for _, info in ipairs(self._keyGuideOrder) do
    info.control:SetShow(false)
  end
  local startY = 10
  local gapY = 45
  local count = 0
  for _, info in ipairs(self._keyGuideOrder) do
    local isShow = info.always
    if info.always == false then
      isShow = self:checkCondition(info.id)
    end
    if isShow == true then
      info.control:SetText(self:getKeyGuideText(info.id))
      info.control:SetShow(true)
      info.control:SetPosY(startY + gapY * count)
      count = count + 1
    end
    self:setFunction(info.id, isShow)
  end
  local newHeight = count * gapY + 10
  self._ui.stc_keyGuideBg:SetShow(true)
  self._ui.stc_keyGuideBg:SetSize(self._ui.stc_keyGuideBg:GetSizeX(), newHeight)
  Panel_Enchant_Console_KeyGuide:SetSize(self._ui.stc_keyGuideBg:GetSizeX(), newHeight)
  Panel_Enchant_Console_KeyGuide:SetPosXY(getScreenSizeX() - Panel_Enchant_Console_KeyGuide:GetSizeX(), getScreenSizeY() - Panel_Enchant_Console_KeyGuide:GetSizeY())
end
function PaGlobal_Enchant_Console_KeyGuide:getKeyGuideText(id)
  if id == self._ENUM.TXT_A then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT")
  elseif id == self._ENUM.TXT_B then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE")
  elseif id == self._ENUM.TXT_RS then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_ENCHANT_INVENTORY")
  elseif id == self._ENUM.TXT_LT_X then
    if ToClient_GetIsGroupEnchant() == true then
      if PaGlobal_EnchantMain_All:isAnimating() == true then
        return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_PARTYENCHANT_READYCANCLE")
      elseif ToClient_GetIsReadyGroupEnchant() == true then
        return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_PARTYENCHANT_READYCANCLE")
      else
        return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_PARTYENCHANT_READY")
      end
    elseif PaGlobal_EnchantMain_All:isAnimating() == true then
      return PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL")
    elseif ToClient_IsCurrentMaterialCaphras() == true then
      if ToClient_IsTargetCaphrasPromotable() == true then
        return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_FORCEDENCHANTTITLE")
      else
        return PAGetString(Defines.StringSheet_GAME, "LUA_NEWENCHANT_APPLY_BUTTON_NORM_CAPHRAS")
      end
    else
      return PAGetString(Defines.StringSheet_RESOURCE, "ENCHANT_TEXT_TITLE")
    end
  elseif id == self._ENUM.TXT_LT_Y then
    if ToClient_GetIsGroupEnchant() == true then
      if ToClient_GetIsReadyGroupEnchant() == true then
        return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_CRON_GO_CANCEL")
      else
        return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_CRON_GO")
      end
    elseif PaGlobal_EnchantMain_All:isAnimating() == true then
      return PAGetString(Defines.StringSheet_GAME, "LUA_ENCHANT_CANCEL")
    elseif ToClient_IsCurrentMaterialCaphras() == true then
      return ""
    else
      return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWEL_CRON_ENCHANT_BTN")
    end
  elseif id == self._ENUM.TXT_LS then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_SKIP_ANIMATION")
  elseif id == self._ENUM.TXT_RSHRI then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_CONSOLE_KEYGUIDE_NADER_PAGING")
  elseif id == self._ENUM.TXT_X then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PEARLSHOP_DETAILINFOVIEW")
  elseif id == self._ENUM.TXT_RT_X then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_DARK_ADDITIONAL_CONSOLE_KEYGUIDE")
  elseif id == self._ENUM.TXT_RT_Y then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_PARTYENCHANT_ENCHANT")
  elseif id == self._ENUM.TXT_RT_A then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_EXTRACT")
  elseif id == self._ENUM.TXT_LT_A then
    return PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_TITLE")
  end
  return ""
end
function PaGlobal_Enchant_Console_KeyGuide:setFunction(id, isShow)
  if id == self._ENUM.TXT_A then
  elseif id == self._ENUM.TXT_B then
  elseif id == self._ENUM.TXT_RS then
    if isShow == true then
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "HandleEventLUp_EnchantMain_Inventory()")
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_Up_RSClick, "")
    end
  elseif id == self._ENUM.TXT_LT_X then
    if isShow == true then
      if ToClient_GetIsGroupEnchant() == true then
        if PaGlobal_EnchantMain_All:isAnimating() == true then
          Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
        elseif ToClient_GetIsReadyGroupEnchant() == true then
          Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "ToClient_RequestGroupEnchantItemSetCancel()")
        else
          Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_EnchantMain_ReadyGroupEnchant(false)")
        end
      elseif PaGlobal_EnchantMain_All:isAnimating() == true then
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_EnchantMain_StartButton()")
      elseif ToClient_IsCurrentMaterialCaphras() == true then
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_EnchantMain_StartButton()")
      else
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_EnchantMain_StartButton()")
      end
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    end
  elseif id == self._ENUM.TXT_LT_Y then
    if isShow == true then
      if ToClient_GetIsGroupEnchant() == true then
        if PaGlobal_EnchantMain_All:isAnimating() == true then
          Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
        elseif ToClient_GetIsReadyGroupEnchant() == true then
          Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "ToClient_RequestGroupEnchantItemSetCancel()")
        else
          Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_EnchantMain_ReadyGroupEnchant(true)")
        end
      elseif PaGlobal_EnchantMain_All:isAnimating() == true then
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_EnchantMain_StartCronButton()")
      elseif ToClient_IsCurrentMaterialCaphras() == true then
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_EnchantMain_StartCronButton()")
      else
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_EnchantMain_StartCronButton()")
      end
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    end
  elseif id == self._ENUM.TXT_LS then
    if isShow == true then
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "HandleEventLUp_EnchantMain_ToggleSkipAnimation(true)")
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_Up_LSClick, "")
    end
  elseif id == self._ENUM.TXT_RSHRI then
    if isShow == true then
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "HandleEventLUp_EnchantMain_ChangeNaderrPage(-1)")
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "HandleEventLUp_EnchantMain_ChangeNaderrPage(1)")
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RStickLeft, "")
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RStickRight, "")
    end
  elseif id == self._ENUM.TXT_X then
  elseif id == self._ENUM.TXT_RT_X then
    if isShow == true then
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventLUp_EnchantMain_StackSelect()")
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    end
  elseif id == self._ENUM.TXT_RT_Y then
    if isShow == true then
      if PaGlobal_EnchantMain_All._ui.btn_groupEnchantStart:IsIgnore() == true then
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
      else
        Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "ToClient_RequestGroupEnchantAniStart()")
      end
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
    end
  elseif id == self._ENUM.TXT_RT_A then
    if isShow == true then
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "PaGlobalFunc_StackExtraction_All_Open()")
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "")
    end
  elseif id == self._ENUM.TXT_LT_A then
    if isShow == true then
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "HandleEventLUp_EnchantMain_OthersChoice()")
    else
      Panel_Widget_Enchant_Main_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
    end
  end
end
function PaGlobal_Enchant_Console_KeyGuide:checkCondition(id)
  local conditionMap = {
    [self._ENUM.TXT_LT_X] = self.canEnchant,
    [self._ENUM.TXT_LT_Y] = self.canCronEnchant,
    [self._ENUM.TXT_RSHRI] = self.canNaderr,
    [self._ENUM.TXT_RT_X] = self.canOpenEnchantStack,
    [self._ENUM.TXT_RT_Y] = self.canGroupEnchant,
    [self._ENUM.TXT_RT_A] = self.canExtract,
    [self._ENUM.TXT_LT_A] = self.canOtherChoice
  }
  local func = conditionMap[id]
  if func ~= nil then
    return func(self)
  end
  return false
end
function PaGlobal_Enchant_Console_KeyGuide:canEnchant()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  if ToClient_GetIsGroupEnchant() == true then
    return PaGlobal_EnchantMain_All._ui.btn_groupEnchantReady:GetShow() == true and PaGlobal_EnchantMain_All._ui.btn_groupEnchantReady:IsIgnore() == false or PaGlobal_EnchantMain_All._ui.btn_groupEnchantReadyCancel:GetShow() == true and PaGlobal_EnchantMain_All._ui.btn_groupEnchantReadyCancel:IsIgnore() == false
  else
    return PaGlobal_EnchantMain_All._ui.btn_enchantStart:IsIgnore() == false
  end
end
function PaGlobal_Enchant_Console_KeyGuide:canCronEnchant()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  if ToClient_GetIsGroupEnchant() == true then
    return PaGlobal_EnchantMain_All._ui.btn_cronGroupEnchantReady:GetShow() == true and PaGlobal_EnchantMain_All._ui.btn_cronGroupEnchantReady:IsIgnore() == false or PaGlobal_EnchantMain_All._ui.btn_cronGroupEnchantReadyCancel:GetShow() == true and PaGlobal_EnchantMain_All._ui.btn_cronGroupEnchantReadyCancel:IsIgnore() == false
  else
    return PaGlobal_EnchantMain_All._ui.btn_cronEnchantStart:IsIgnore() == false and ToClient_IsCurrentMaterialCaphras() == false
  end
end
function PaGlobal_Enchant_Console_KeyGuide:canNaderr()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  return ToClient_IsCurrentMaterialCaphras() == false
end
function PaGlobal_Enchant_Console_KeyGuide:canOpenEnchantStack()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  return ToClient_IsCurrentMaterialCaphras() == false
end
function PaGlobal_Enchant_Console_KeyGuide:canGroupEnchant()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  return RequestParty_isLeader() == true and ToClient_IsCurrentMaterialCaphras() == false and PaGlobal_EnchantMain_All._ui.btn_groupEnchantStart:GetShow() == true and PaGlobal_EnchantMain_All._ui.btn_groupEnchantStart:IsIgnore() == false
end
function PaGlobal_Enchant_Console_KeyGuide:canExtract()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  return ToClient_IsCurrentMaterialCaphras() == false
end
function PaGlobal_Enchant_Console_KeyGuide:canOtherChoice()
  if PaGlobal_EnchantMain_All == nil then
    return false
  end
  return PaGlobal_EnchantMain_All._ui.btn_othersChoice:GetShow() == true and ToClient_IsCurrentMaterialCaphras() == false
end
function PaGlobal_Enchant_Console_KeyGuide:isValidate()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  self._ui.stc_keyGuideBg:isValidate()
  self._ui.txt_A:isValidate()
  self._ui.txt_B:isValidate()
  self._ui.txt_RS:isValidate()
  self._ui.txt_LT_X:isValidate()
  self._ui.txt_LT_Y:isValidate()
  self._ui.txt_LS:isValidate()
  self._ui.txt_RSHri:isValidate()
  self._ui.txt_X:isValidate()
  self._ui.txt_RT_X:isValidate()
  self._ui.txt_RT_Y:isValidate()
  self._ui.txt_RT_A:isValidate()
  self._ui.txt_LT_A:isValidate()
end
function PaGlobal_Enchant_Console_KeyGuide_Open()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  PaGlobal_Enchant_Console_KeyGuide:prepareOpen()
end
function PaGlobal_Enchant_Console_KeyGuide_Close()
  if Panel_Enchant_Console_KeyGuide == nil then
    return
  end
  PaGlobal_Enchant_Console_KeyGuide:prepareClose()
end
