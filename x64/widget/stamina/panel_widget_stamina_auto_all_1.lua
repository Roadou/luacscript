function PaGlobal_StaminaAuto:initialize()
  if self._initialize == true then
    return
  end
  self._ui.stc_BG = UI.getChildControl(Panel_Stamina_Auto, "Static_Gradation_BG")
  self._ui.stc_Design = UI.getChildControl(Panel_Stamina_Auto, "Static_Gradation_Design")
  self._ui.chk_AutoRun = UI.getChildControl(Panel_Stamina_Auto, "CheckButton_AutoRun")
  self._ui.txt_AutoRunEnable = UI.getChildControl(self._ui.chk_AutoRun, "StaticText_AutoRunEnable")
  self._ui.txt_AutoRunConsoleGuide = UI.getChildControl(self._ui.chk_AutoRun, "StaticText_AutoRunConsoleGuide")
  self._ui.stc_Dongle = UI.getChildControl(Panel_Stamina_Auto, "Static_Sequence_Dongle")
  self._ui.stc_PressLTCircle = UI.getChildControl(Panel_Stamina_Auto, "CircularProgress_ConsoleLB")
  self:isValidate()
  self:registerEvent()
  self._ui.txt_AutoRunConsoleGuide:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTO_RUN_DESC1_CONSOLE"))
  if _ContentsGroup_UsePadSnapping == true then
    self._ui.txt_AutoRunConsoleGuide:SetShow(true)
  end
  self._isAnimationAdded = false
  self._initialize = true
end
function PaGlobal_StaminaAuto:prepareOpen()
  if Panel_Stamina_Auto == nil then
    return
  end
  local savedAutoRunCheck = false
  if nil ~= ToClient_getGameUIManagerWrapper() then
    savedAutoRunCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eUseMovePastForPlayer)
  end
  self:setEffectForAutoRunButton(false)
  self._ui.chk_AutoRun:SetCheck(savedAutoRunCheck)
  self._isOpening = true
  self:computePos()
  self:open()
end
function PaGlobal_StaminaAuto:open()
  if Panel_Stamina_Auto == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  if selfPlayerWrapper:get():isVehicleDriver() == true then
    return
  end
  Panel_Stamina_Auto:SetShow(true)
  Panel_Stamina_Auto:SetAlphaChild(0)
  self:AutoRunStartOrStop()
end
function PaGlobal_StaminaAuto:prepareClose()
  if Panel_Stamina_Auto == nil then
    return
  end
  self._isOpening = false
  self:close()
end
function PaGlobal_StaminaAuto:close()
  if Panel_Stamina_Auto == nil then
    return
  end
end
function PaGlobal_StaminaAuto:isValidate()
  if Panel_Stamina_Auto == nil then
    return
  end
  self._ui.stc_BG:isValidate()
  self._ui.stc_Design:isValidate()
  self._ui.chk_AutoRun:isValidate()
  self._ui.stc_Dongle:isValidate()
  self._ui.txt_AutoRunEnable:isValidate()
  self._ui.txt_AutoRunConsoleGuide:isValidate()
end
function PaGlobal_StaminaAuto:registerEvent()
  if Panel_Stamina_Auto == nil then
    return
  end
  self._ui.chk_AutoRun:SetCheck(true)
  self._ui.chk_AutoRun:addInputEvent("Mouse_LUp", "HandleEventLUp_AutoRunStartOrStop()")
  Panel_Stamina_Auto:RegisterUpdateFunc("Stamina_Auto_Update")
end
function PaGlobal_StaminaAuto:updateAlpha(fadeAlpha)
  Panel_Stamina_Auto:SetAlphaChild(fadeAlpha)
  self._ui.txt_AutoRunEnable:SetFontAlpha(fadeAlpha)
  self._ui.txt_AutoRunConsoleGuide:SetFontAlpha(fadeAlpha)
  if fadeAlpha >= 1 and PaGlobal_StaminaAuto._ui.chk_AutoRun:IsCheck() == false then
    self:setEffectForAutoRunButton(true)
  else
    self:setEffectForAutoRunButton(false)
  end
end
function PaGlobal_StaminaAuto:setEffectForAutoRunButton(flag)
  if flag == false and self._isAnimationAdded == true then
    self._ui.chk_AutoRun:EraseAllEffect()
    self._isAnimationAdded = false
    return
  end
  if self._isAnimationAdded == true then
    return
  end
  self._isAnimationAdded = true
  self._ui.chk_AutoRun:AddEffect("FUI_AutoRun_Button_01A", true, 0, 0)
end
function Stamina_Auto_Update(deltaTime)
  if PaGlobal_StaminaAuto._isOpening == true then
    PaGlobal_StaminaAuto._fadeAlpha = PaGlobal_StaminaAuto._fadeAlpha + deltaTime
    if PaGlobal_StaminaAuto._fadeAlpha > 1 then
      PaGlobal_StaminaAuto._fadeAlpha = 1
    end
  else
    PaGlobal_StaminaAuto._fadeAlpha = PaGlobal_StaminaAuto._fadeAlpha - deltaTime
    if PaGlobal_StaminaAuto._fadeAlpha < 0 then
      PaGlobal_StaminaAuto._fadeAlpha = 0
      Panel_Stamina_Auto:SetShow(false)
    end
  end
  PaGlobal_StaminaAuto:updateAlpha(PaGlobal_StaminaAuto._fadeAlpha)
  if _ContentsGroup_UsePadSnapping == true then
    if isPadPressed(__eJoyPadInputType_LeftTrigger) == true then
      PaGlobal_StaminaAuto._ui.stc_PressLTCircle:SetShow(true)
      PaGlobal_StaminaAuto._isKeyPressedTime = PaGlobal_StaminaAuto._isKeyPressedTime + deltaTime
      PaGlobal_StaminaAuto._ui.stc_PressLTCircle:SetProgressRate(PaGlobal_StaminaAuto._isKeyPressedTime / 1.5 * 100)
      if PaGlobal_StaminaAuto._isKeyPressedTime >= 1.5 then
        PaGlobal_StaminaAuto._ui.chk_AutoRun:SetCheck(not PaGlobal_StaminaAuto._ui.chk_AutoRun:IsCheck())
        HandleEventLUp_AutoRunStartOrStop()
        PaGlobal_StaminaAuto._isKeyPressedTime = 0
        PaGlobal_StaminaAuto._ui.stc_PressLTCircle:SetProgressRate(0)
        PaGlobal_StaminaAuto._ui.stc_PressLTCircle:SetShow(false)
      end
    else
      PaGlobal_StaminaAuto._isKeyPressedTime = 0
      PaGlobal_StaminaAuto._ui.stc_PressLTCircle:SetProgressRate(0)
      PaGlobal_StaminaAuto._ui.stc_PressLTCircle:SetShow(false)
    end
  end
end
function PaGlobal_StaminaAuto:AutoRunStartOrStop()
  if Panel_Stamina_Auto == nil then
    return
  end
  local isChkAutoRun = PaGlobal_StaminaAuto._ui.chk_AutoRun:IsCheck()
  if isChkAutoRun == true then
    PaGlobal_StaminaAuto._ui.txt_AutoRunEnable:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTO_RUN_DESC2"))
    PaGlobal_StaminaAuto._ui.stc_Dongle:SetShow(true)
    PaGlobal_StaminaAuto._ui.txt_AutoRunConsoleGuide:SetShow(false)
  else
    PaGlobal_StaminaAuto._ui.txt_AutoRunEnable:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_AUTO_RUN_DESC1"))
    PaGlobal_StaminaAuto._ui.stc_Dongle:SetShow(false)
    if _ContentsGroup_UsePadSnapping == true then
      PaGlobal_StaminaAuto._ui.txt_AutoRunConsoleGuide:SetShow(true)
    end
  end
  ToClient_SetCanMoveFast(isChkAutoRun)
  PaGlobal_StaminaAuto:computePos()
  if nil ~= ToClient_getGameUIManagerWrapper() then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eUseMovePastForPlayer, isChkAutoRun, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
end
function PaGlobal_StaminaAuto:computePos()
  if Panel_Stamina_Auto == nil or Panel_Stamina == nil then
    return
  end
  local posX = Panel_Stamina:GetPosX() + Panel_Stamina:GetSizeX() * 0.5 - Panel_Stamina_Auto:GetSizeX() * 0.5
  local posY = Panel_Stamina:GetPosY() - Panel_Stamina_Auto:GetSizeY() - 20
  if PaGlobal_StaminaAuto._ui.txt_AutoRunConsoleGuide:GetShow() == true then
    posY = posY - 20
  end
  Panel_Stamina_Auto:SetPosXY(posX, posY)
end
function FromClient_SetStaminaAuto(isOpen)
  if isOpen == true then
    PaGlobal_StaminaAuto:prepareOpen()
  else
    PaGlobal_StaminaAuto:prepareClose()
  end
end
registerEvent("FromClient_SetStaminaAuto", "FromClient_SetStaminaAuto")
