function PaGlobal_Widget_HadumField_Enter_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_blackBG = UI.getChildControl(Panel_Widget_HadumField_Enter, "Static_BlackBG")
  self._ui._stc_backGroundBG = UI.getChildControl(Panel_Widget_HadumField_Enter, "Static_BackGroundBG")
  self._ui._stc_enterBG = UI.getChildControl(Panel_Widget_HadumField_Enter, "Static_EnterBG")
  self._ui._stc_symbol = UI.getChildControl(self._ui._stc_enterBG, "Static_Symbol")
  self._ui._stc_line = UI.getChildControl(self._ui._stc_enterBG, "Static_Line")
  self._ui._txt_name = UI.getChildControl(self._ui._stc_enterBG, "StaticText_Name")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_enterBG, "MultilineText_Desc")
  self._ui._btn_enter = UI.getChildControl(self._ui._stc_enterBG, "Button_Enter")
  self._ui._btn_exit = UI.getChildControl(self._ui._stc_enterBG, "Button_Exit")
  self._ui._txt_keyGuideB = UI.getChildControl(self._ui._stc_enterBG, "StaticText_B_ConsoleUI")
  self._ui._txt_keyGuideY = UI.getChildControl(self._ui._stc_enterBG, "StaticText_Y_ConsoleUI")
  self._ui._stc_enterEffect = UI.getChildControl(Panel_Widget_HadumField_Enter, "Static_EnterEffect")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Widget_HadumField_Enter_All:validate()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  self._ui._stc_blackBG:isValidate()
  self._ui._stc_backGroundBG:isValidate()
  self._ui._stc_enterBG:isValidate()
  self._ui._stc_symbol:isValidate()
  self._ui._stc_line:isValidate()
  self._ui._txt_name:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._btn_enter:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._txt_keyGuideB:isValidate()
  self._ui._txt_keyGuideY:isValidate()
  self._ui._stc_enterEffect:isValidate()
end
function PaGlobal_Widget_HadumField_Enter_All:registEventHandler()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_HadumField_Enter_All_ResizePanel")
  registerEvent("FromClient_UpdateHadumFieldState", "FromClient_Widget_HadumField_Enter_All_UpdateEnterState")
  self._ui._btn_enter:SetShow(not self._isConsole)
  self._ui._btn_exit:SetShow(not self._isConsole)
  self._ui._btn_enter:addInputEvent("Mouse_LUp", "PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_Widget_HadumField_Enter_All_Close()")
  self._ui._txt_keyGuideB:SetShow(self._isConsole)
  self._ui._txt_keyGuideY:SetShow(self._isConsole)
  if true == self._isConsole then
    Panel_Widget_HadumField_Enter:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave()")
    Panel_Widget_HadumField_Enter:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_Widget_HadumField_Enter_All_Close()")
  end
end
function PaGlobal_Widget_HadumField_Enter_All:prepareOpen(isShowEffect)
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  if _ContentsGroup_HadumField == false then
    return
  end
  Panel_Widget_HadumField_Enter:EraseAllEffect()
  Panel_Widget_HadumField_Enter:ClearUpdateLuaFunc()
  self._isShowEffect = false
  self._curEffectTime = 0
  FromClient_Widget_HadumField_Enter_All_ResizePanel()
  if isShowEffect == true then
    self._ui._stc_enterBG:SetShow(false)
    self._ui._stc_backGroundBG:SetShow(false)
    self._ui._stc_blackBG:SetShow(true)
    self:showEffect()
  else
    if self:updateEnterData() == false then
      self:prepareClose()
      return
    end
    if self._isConsole == true then
      Panel_Widget_HadumField_Enter:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_Widget_HadumField_Enter_All_EnterOrLeave()")
      self._ui._txt_keyGuideB:SetShow(true)
      self._ui._txt_keyGuideY:SetShow(true)
    else
      self._ui._btn_enter:SetShow(true)
      self._ui._btn_exit:SetShow(true)
    end
    self._ui._stc_enterBG:SetShow(true)
    self._ui._stc_backGroundBG:SetShow(true)
    self._ui._stc_blackBG:SetShow(false)
  end
  self:open()
end
function PaGlobal_Widget_HadumField_Enter_All:open()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  Panel_Widget_HadumField_Enter:SetShow(true)
end
function PaGlobal_Widget_HadumField_Enter_All:prepareClose()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  Panel_Widget_HadumField_Enter:EraseAllEffect()
  Panel_Widget_HadumField_Enter:ClearUpdateLuaFunc()
  self._isShowEffect = false
  self._curEffectTime = 0
  self:close()
end
function PaGlobal_Widget_HadumField_Enter_All:close()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  Panel_Widget_HadumField_Enter:SetShow(false)
end
function PaGlobal_Widget_HadumField_Enter_All:updateEnterData()
  if Panel_Widget_HadumField_Enter == nil then
    return false
  end
  if PaGlobal_Widget_HadumField_All_CheckChangeState(true) == false then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return false
  end
  return true
end
function PaGlobal_Widget_HadumField_Enter_All:updateEnterEffect(deltaTime)
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  self._curEffectTime = self._curEffectTime + deltaTime
  if self._curEffectTime < self._maxEffectTime then
    return
  end
  self:prepareClose()
end
function PaGlobal_Widget_HadumField_Enter_All:showEffect()
  if Panel_Widget_HadumField_Enter == nil then
    return
  end
  self._ui._stc_enterBG:SetShow(false)
  if true == self._isConsole then
    Panel_Widget_HadumField_Enter:registerPadEvent(__eConsoleUIPadEvent_Y, "")
    self._ui._txt_keyGuideB:SetShow(false)
    self._ui._txt_keyGuideY:SetShow(false)
  else
    self._ui._btn_enter:SetShow(false)
    self._ui._btn_exit:SetShow(false)
  end
  self._isShowEffect = true
  self._curEffectTime = 0
  Panel_Widget_HadumField_Enter:EraseAllEffect()
  Panel_Widget_HadumField_Enter:AddEffect("fUI_InGame_Light_01C", false, 0, 0)
  audioPostEvent_SystemUi(32, 1)
  _AudioPostEvent_SystemUiForXBOX(32, 1)
  Panel_Widget_HadumField_Enter:RegisterUpdateFunc("PaGlobal_Widget_HadumField_Enter_All_UpdateEnterEffect")
  local blackShowStartTime = 0
  local blackShowEndTime = 0.5
  local blackHideTime = 0.5
  local blackHideStartTime = math.max(self._maxEffectTime - blackHideTime, 0)
  local blackHideEndTime = self._maxEffectTime
  self:setAniToControl(true, self._ui._stc_blackBG, blackShowStartTime, blackShowEndTime, Defines.Color.C_55FFFFFF, Defines.Color.C_CCFFFFFF)
  self:setAniToControl(false, self._ui._stc_blackBG, blackHideStartTime, blackHideEndTime, Defines.Color.C_CCFFFFFF, Defines.Color.C_55FFFFFF)
end
function PaGlobal_Widget_HadumField_Enter_All:setAniToControl(isShow, control, startTime, endTime, startValue, endValue)
  if nil == control then
    return
  end
  local aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(startValue)
  aniInfo:SetEndColor(endValue)
  aniInfo.IsChangeChild = true
end
