function FromClient_ToTargetKeyGuideOnOff(isToTargetExist)
  if nil == Panel_Widget_AttackWayCorrection_KeyGuide then
    return
  end
  Panel_Widget_AttackWayCorrection_KeyGuide:SetShow(isToTargetExist)
end
