function PaGlobal_Widget_PersonalField_Enter_All_Open(isShowEffect)
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  PaGlobal_Widget_PersonalField_Enter_All:prepareOpen(isShowEffect)
end
function PaGlobal_Widget_PersonalField_Enter_All_Close()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  if true == PaGlobal_Widget_PersonalField_Enter_All._isShowEffect then
    return
  end
  PaGlobal_Widget_PersonalField_Enter_All:prepareClose()
end
function PaGlobal_Widget_PersonalField_Enter_All_UpdateEnterEffect(deltaTime)
  PaGlobal_Widget_PersonalField_Enter_All:updateEnterEffect(deltaTime)
end
function PaGlobal_Widget_PersonalField_Enter_All_Enter()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  if true == ToClient_IsEnterMirrorField() then
    return
  end
  if nil == PaGlobal_Widget_PersonalField_All_CheckChangeState then
    return
  end
  if false == PaGlobal_Widget_PersonalField_All_CheckChangeState(true, true) then
    return
  end
  ToClient_EnterOrLeavePersonalField(true)
end
function FromClient_Widget_PersonalField_Enter_All_UpdateRemainTime()
  if nil == Panel_Widget_PersonalField_Enter or false == Panel_Widget_PersonalField_Enter:GetShow() then
    return
  end
  PaGlobal_Widget_PersonalField_Enter_All:updateRemainTime()
end
function FromClient_Widget_PersonalField_Enter_All_ResizePanel()
  if nil == Panel_Widget_PersonalField_Enter then
    return
  end
  local screenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  Panel_Widget_PersonalField_Enter:SetSize(screenSize.x, screenSize.y)
  Panel_Widget_PersonalField_Enter:SetPosX(0)
  Panel_Widget_PersonalField_Enter:SetPosY(0)
  Panel_Widget_PersonalField_Enter:ComputePosAllChild()
  PaGlobal_Widget_PersonalField_Enter_All._ui._stc_blackBG:SetSize(screenSize.x, screenSize.y)
end
