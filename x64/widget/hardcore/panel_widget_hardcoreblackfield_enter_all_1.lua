function PaGlobal_Widget_HardCoreBlackField_Enter_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_blackBG = UI.getChildControl(Panel_Widget_HardCoreBlackField_Enter, "Static_BlackBG")
  self._ui._stc_enterEffect = UI.getChildControl(Panel_Widget_HardCoreBlackField_Enter, "Static_EnterEffect")
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:registEventHandler()
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  registerEvent("FromClient_ShowHardCoreBlackFieldEnterEffect", "FromClient_ShowHardCoreBlackFieldEnterEffect")
  registerEvent("onScreenResize", "FromClient_Widget_HardCoreBlackField_Enter_ResizePanel")
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:prepareOpen()
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  self:resizePanel()
  self:showEffect()
  self:open()
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:open()
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  Panel_Widget_HardCoreBlackField_Enter:SetShow(true)
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:prepareClose()
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  self:close()
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:close()
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  Panel_Widget_HardCoreBlackField_Enter:EraseAllEffect()
  Panel_Widget_HardCoreBlackField_Enter:ClearUpdateLuaFunc()
  Panel_Widget_HardCoreBlackField_Enter:SetShow(false)
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:resizePanel()
  local panel = Panel_Widget_HardCoreBlackField_Enter
  if panel == nil then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  panel:SetSize(screenSizeX, screenSizeY)
  panel:SetPosX(0)
  panel:SetPosY(0)
  panel:ComputePosAllChild()
  self._ui._stc_blackBG:SetSize(screenSizeX, screenSizeY)
  self._ui._stc_blackBG:ComputePos()
  self._ui._stc_enterEffect:SetSize(screenSizeX, screenSizeY)
  self._ui._stc_enterEffect:ComputePos()
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:updateEnterEffect(deltaTime)
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  self._curEffectTime = self._curEffectTime + deltaTime
  if self._curEffectTime < self._maxEffectTime then
    return
  end
  self:prepareClose()
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:showEffect()
  if Panel_Widget_HardCoreBlackField_Enter == nil then
    return
  end
  self._ui._stc_blackBG:SetShow(true)
  self._curEffectTime = 0
  Panel_Widget_HardCoreBlackField_Enter:EraseAllEffect()
  Panel_Widget_HardCoreBlackField_Enter:AddEffect("fUI_InGame_Light_01A", false, 0, 0)
  Panel_Widget_HardCoreBlackField_Enter:RegisterUpdateFunc("PaGlobal_Widget_HardCoreBlackField_Enter_UpdateEnterEffect")
  audioPostEvent_SystemUi(25, 2)
  _AudioPostEvent_SystemUiForXBOX(25, 2)
  local blackShowStartTime = 0
  local blackShowEndTime = 0.5
  local blackHideTime = 0.5
  local blackHideStartTime = math.max(self._maxEffectTime - blackHideTime, 0)
  local blackHideEndTime = self._maxEffectTime
  self:setAniToControl(true, self._ui._stc_blackBG, blackShowStartTime, blackShowEndTime, Defines.Color.C_55FFFFFF, Defines.Color.C_CCFFFFFF)
  self:setAniToControl(false, self._ui._stc_blackBG, blackHideStartTime, blackHideEndTime, Defines.Color.C_CCFFFFFF, Defines.Color.C_55FFFFFF)
end
function PaGlobal_Widget_HardCoreBlackField_Enter_All:setAniToControl(isShow, control, startTime, endTime, startValue, endValue)
  if control == nil then
    return
  end
  local aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(startValue)
  aniInfo:SetEndColor(endValue)
  aniInfo.IsChangeChild = true
end
