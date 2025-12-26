function PaGlobal_Widget_PersonalField_Enter_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_blackBG = UI.getChildControl(Panel_Widget_PersonalField_Enter, "Static_BlackBG")
  self._ui._stc_enterBg = UI.getChildControl(Panel_Widget_PersonalField_Enter, "Static_EnterBG")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_enterBg, "StaticText_ContentTitle")
  self._ui._txt_name = UI.getChildControl(self._ui._stc_enterBg, "StaticText_Name")
  self._ui._txt_timeTitle = UI.getChildControl(self._ui._stc_enterBg, "StaticText_Time_Title")
  self._ui._txt_time = UI.getChildControl(self._ui._stc_enterBg, "StaticText_Time_Value")
  self._ui._btn_enter = UI.getChildControl(self._ui._stc_enterBg, "Button_Enter")
  self._ui._btn_exit = UI.getChildControl(self._ui._stc_enterBg, "Button_Exit")
  self._ui._txt_keyGuideB = UI.getChildControl(self._ui._stc_enterBg, "StaticText_B_ConsoleUI")
  self._ui._txt_keyGuideY = UI.getChildControl(self._ui._stc_enterBg, "StaticText_Y_ConsoleUI")
  self._ui._stc_enterEffect = UI.getChildControl(Panel_Widget_PersonalField_Enter, "Static_EnterEffect")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Widget_PersonalField_Enter_All:validate()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  self._ui._stc_blackBG:isValidate()
  self._ui._stc_enterBg:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._txt_name:isValidate()
  self._ui._txt_timeTitle:isValidate()
  self._ui._txt_time:isValidate()
  self._ui._btn_enter:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._txt_keyGuideB:isValidate()
  self._ui._txt_keyGuideY:isValidate()
  self._ui._stc_enterEffect:isValidate()
end
function PaGlobal_Widget_PersonalField_Enter_All:registEventHandler()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_PersonalField_Enter_All_ResizePanel")
  registerEvent("FromClient_UpdatePersonalFieldRemainTime", "FromClient_Widget_PersonalField_Enter_All_UpdateRemainTime")
  self._ui._btn_enter:SetShow(not self._isConsole)
  self._ui._btn_exit:SetShow(not self._isConsole)
  self._ui._btn_enter:addInputEvent("Mouse_LUp", "PaGlobal_Widget_PersonalField_Enter_All_Enter()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "PaGlobal_Widget_PersonalField_Enter_All_Close()")
  if true == self._isConsole then
    Panel_Widget_PersonalField_Enter:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_Widget_PersonalField_Enter_All_Close()")
  end
end
function PaGlobal_Widget_PersonalField_Enter_All:prepareOpen(isShowEffect)
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  if false == _ContentsGroup_PersonalField then
    return
  end
  Panel_Widget_PersonalField_Enter:EraseAllEffect()
  Panel_Widget_PersonalField_Enter:ClearUpdateLuaFunc()
  self._isShowEffect = false
  self._curEffectTime = 0
  FromClient_Widget_PersonalField_Enter_All_ResizePanel()
  if true == isShowEffect then
    self._ui._stc_enterBg:SetShow(false)
    self._ui._stc_blackBG:SetShow(true)
    self:showEffect()
  else
    if self:updateEnterData() == false then
      self:prepareClose()
      return
    end
    if true == self._isConsole then
      Panel_Widget_PersonalField_Enter:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_Widget_PersonalField_Enter_All_Enter()")
      self._ui._txt_keyGuideB:SetShow(true)
      self._ui._txt_keyGuideY:SetShow(true)
    else
      self._ui._btn_enter:SetShow(true)
      self._ui._btn_exit:SetShow(true)
    end
    self._ui._stc_enterBg:SetShow(true)
    self._ui._stc_blackBG:SetShow(false)
  end
  self:open()
end
function PaGlobal_Widget_PersonalField_Enter_All:open()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  Panel_Widget_PersonalField_Enter:SetShow(true)
end
function PaGlobal_Widget_PersonalField_Enter_All:prepareClose()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  Panel_Widget_PersonalField_Enter:EraseAllEffect()
  Panel_Widget_PersonalField_Enter:ClearUpdateLuaFunc()
  self._isShowEffect = false
  self._curEffectTime = 0
  self:close()
end
function PaGlobal_Widget_PersonalField_Enter_All:close()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  Panel_Widget_PersonalField_Enter:SetShow(false)
end
function PaGlobal_Widget_PersonalField_Enter_All:updateEnterData()
  if nil == Panel_Widget_PersonalField_Enter then
    return false
  end
  if true == ToClient_IsEnterMirrorField() then
    return false
  end
  if nil == PaGlobal_Widget_PersonalField_All_CheckChangeState then
    return false
  end
  if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(true, false) then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return false
  end
  local selfPlayerPosition = selfPlayer:getPosition()
  local instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByPosition(selfPlayerPosition)
  if nil == instanceSpawnWrapper then
    return false
  end
  local index = instanceSpawnWrapper:getIndex()
  if -1 == index then
    return false
  end
  local radius = instanceSpawnWrapper:getRadius()
  local distance = instanceSpawnWrapper:getDistance(selfPlayerPosition)
  if distance > radius * 0.8 then
    return false
  end
  local areaName = instanceSpawnWrapper:getAreaName()
  if nil ~= areaName then
    self._ui._txt_name:SetText(areaName)
  end
  if true == ToClient_IsEnterMirrorField() then
    self._ui._btn_exit:SetShow(false == self._isConsole)
  else
    self._ui._btn_enter:SetShow(false == self._isConsole)
  end
  self:updateRemainTime()
  return true
end
function PaGlobal_Widget_PersonalField_Enter_All:updateRemainTime()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  if nil == PaGlobal_Widget_PersonalField_All_SetRemainTimeText then
    return
  end
  PaGlobal_Widget_PersonalField_All_SetRemainTimeText(self._ui._txt_time)
end
function PaGlobal_Widget_PersonalField_Enter_All:updateEnterEffect(deltaTime)
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  self._curEffectTime = self._curEffectTime + deltaTime
  if self._curEffectTime < self._maxEffectTime then
    return
  end
  self:prepareClose()
end
function PaGlobal_Widget_PersonalField_Enter_All:showEffect()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  self._ui._stc_enterBg:SetShow(false)
  if true == self._isConsole then
    Panel_Widget_PersonalField_Enter:registerPadEvent(__eConsoleUIPadEvent_Y, "")
    self._ui._txt_keyGuideB:SetShow(false)
    self._ui._txt_keyGuideY:SetShow(false)
  else
    self._ui._btn_enter:SetShow(false)
    self._ui._btn_exit:SetShow(false)
  end
  self._isShowEffect = true
  self._curEffectTime = 0
  Panel_Widget_PersonalField_Enter:EraseAllEffect()
  Panel_Widget_PersonalField_Enter:AddEffect("fUI_InGame_Light_01A", false, 0, 0)
  audioPostEvent_SystemUi(25, 2)
  _AudioPostEvent_SystemUiForXBOX(25, 2)
  Panel_Widget_PersonalField_Enter:RegisterUpdateFunc("PaGlobal_Widget_PersonalField_Enter_All_UpdateEnterEffect")
  local blackShowStartTime = 0
  local blackShowEndTime = 0.5
  local blackHideTime = 0.5
  local blackHideStartTime = math.max(self._maxEffectTime - blackHideTime, 0)
  local blackHideEndTime = self._maxEffectTime
  self:setAniToControl(true, self._ui._stc_blackBG, blackShowStartTime, blackShowEndTime, Defines.Color.C_55FFFFFF, Defines.Color.C_CCFFFFFF)
  self:setAniToControl(false, self._ui._stc_blackBG, blackHideStartTime, blackHideEndTime, Defines.Color.C_CCFFFFFF, Defines.Color.C_55FFFFFF)
end
function PaGlobal_Widget_PersonalField_Enter_All:setAniToControl(isShow, control, startTime, endTime, startValue, endValue)
  if nil == control then
    return
  end
  local aniInfo = control:addColorAnimation(startTime, endTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(startValue)
  aniInfo:SetEndColor(endValue)
  aniInfo.IsChangeChild = true
end
