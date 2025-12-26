function PaGlobal_MonsterBuffZone:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_effectBG = UI.getChildControl(Panel_Window_MonsterBuffZone, "Static_ProgressBg")
  self._ui.stc_alertMessage = UI.getChildControl(Panel_Window_MonsterBuffZone, "Static_AlertMessage")
  self._ui.txt_endurance = UI.getChildControl(Panel_Window_MonsterBuffZone, "StaticText_Endurance")
  self._ui.btn_deactive = UI.getChildControl(Panel_Window_MonsterBuffZone, "Button_Deactive")
  self._ui.prg_endurance = UI.getChildControl(Panel_Window_MonsterBuffZone, "Progress2_Encurance")
  self._ui.txt_distance = UI.getChildControl(Panel_Window_MonsterBuffZone, "StaticText_Distance")
  self._ui.txt_distanceGlow = UI.getChildControl(Panel_Window_MonsterBuffZone, "StaticText_Distance_Glow")
  self:registEventHandler()
  self:validate()
  local isActivateMonsterBuffZone = ToClient_IsActivateSelfPlayerMonsterBuffZone()
  if isActivateMonsterBuffZone == true then
    FromClient_MonsterBuffZone_ActiveSelfPlayerMonsterBuffZone()
    local currentEndurance = ToClient_GetMonsterBuffZoneCurrentEndurance()
    local maxEndurance = ToClient_GetMonsterBuffZoneMaxEndurance()
    self:updateEndurance(currentEndurance, maxEndurance)
  else
    FromClient_MonsterBuffZone_DeactiveSelfPlayerMonsterBuffZone()
  end
  self._initialize = true
end
function PaGlobal_MonsterBuffZone:registEventHandler()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  registerEvent("FromClient_ActiveSelfPlayerMonsterBuffZone", "FromClient_MonsterBuffZone_ActiveSelfPlayerMonsterBuffZone")
  registerEvent("FromClient_DeactiveSelfPlayerMonsterBuffZone", "FromClient_MonsterBuffZone_DeactiveSelfPlayerMonsterBuffZone")
  registerEvent("FromClient_DecreaseMonsterBuffZoneEndurance", "FromClient_MonsterBuffZone_DecreaseMonsterBuffZoneEndurance")
  self._ui.btn_deactive:addInputEvent("Mouse_LUp", "HandleEventLUp_MonsterBuffZone_Deactive()")
end
function PaGlobal_MonsterBuffZone:prepareOpen()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  self:open()
end
function PaGlobal_MonsterBuffZone:open()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  Panel_Window_MonsterBuffZone:RegisterUpdateFunc("PaGlobalFunc_MonsterBuffZone_Update")
  Panel_Window_MonsterBuffZone:SetShow(true)
end
function PaGlobal_MonsterBuffZone:prepareClose()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  if self._effectId ~= nil then
    self._ui.stc_effectBG:EraseEffect(self._effectId)
    self._effectId = nil
  end
  self._ui.txt_distance:SetFontColor(Defines.Color.C_FFF5BA3A)
  self._ui.stc_alertMessage:SetShow(false)
  self:close()
end
function PaGlobal_MonsterBuffZone:close()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  Panel_Window_MonsterBuffZone:ClearUpdateLuaFunc()
  Panel_Window_MonsterBuffZone:SetShow(false)
end
function PaGlobal_MonsterBuffZone:validate()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  self._ui.stc_effectBG:isValidate()
  self._ui.stc_alertMessage:isValidate()
  self._ui.txt_endurance:isValidate()
  self._ui.btn_deactive:isValidate()
  self._ui.prg_endurance:isValidate()
  self._ui.txt_distance:isValidate()
  self._ui.txt_distanceGlow:isValidate()
end
function PaGlobal_MonsterBuffZone:updatePerFrame(deltaTime)
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  self:updateDistance(deltaTime)
  self:updateMouseOnOut()
end
function PaGlobal_MonsterBuffZone:updateDistance(deltaTime)
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  local currentDistance = ToClient_GetDistanceMonsterBuffZoneToSelfPlayer()
  local maxDistance = ToClient_GetMaxDistanceMonsterBuffZoneToSelfPlayer()
  self._ui.txt_distance:SetText(tostring(currentDistance))
  self._ui.txt_distanceGlow:SetText(tostring(currentDistance))
  local alertValue = 0.8
  if alertValue < currentDistance / maxDistance then
    if self._effectId == nil then
      self._effectId = self._ui.stc_effectBG:AddEffect("fUI_DekiaLanterns_Alarm_01A", true, 0, 0)
      self._ui.txt_distance:SetFontColor(Defines.Color.C_FFD05D48)
      self._ui.stc_alertMessage:SetShow(true)
    end
  elseif self._effectId ~= nil then
    self._ui.stc_effectBG:EraseEffect(self._effectId)
    self._ui.txt_distance:SetFontColor(Defines.Color.C_FFF5BA3A)
    self._ui.stc_alertMessage:SetShow(false)
    self._effectId = nil
  end
end
function PaGlobal_MonsterBuffZone:updateMouseOnOut()
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  local mouseX = getMousePosX()
  local mouseY = getMousePosY()
  local left = Panel_Window_MonsterBuffZone:GetPosX()
  local top = Panel_Window_MonsterBuffZone:GetPosY()
  local right = left + Panel_Window_MonsterBuffZone:GetSizeX()
  local bottom = top + Panel_Window_MonsterBuffZone:GetSizeY()
  local currentInputMode = UI.Get_ProcessorInputMode()
  local isMouseOver = mouseX > left and mouseX < right and mouseY > top and mouseY < bottom and currentInputMode == CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode
  self._ui.btn_deactive:SetShow(isMouseOver)
end
function PaGlobal_MonsterBuffZone:updateEndurance(currentEndurance, maxEndurance)
  if Panel_Window_MonsterBuffZone == nil then
    return
  end
  if currentEndurance == nil or maxEndurance == nil then
    self._ui.prg_endurance:SetProgressRate(0)
    self._ui.txt_endurance:SetText("")
  else
    self._ui.txt_endurance:SetText(tostring(currentEndurance) .. " / " .. tostring(maxEndurance))
    local rate = currentEndurance / maxEndurance
    self._ui.prg_endurance:SetProgressRate(rate * 100)
  end
end
