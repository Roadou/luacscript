function PaGlobal_ArshaApplyWeb_All_ShowAni()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  UIAni.fadeInSCR_Down(Panel_Arsha_ApplyWeb_All)
  local aniInfo1 = Panel_Arsha_ApplyWeb_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Arsha_ApplyWeb_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Arsha_ApplyWeb_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Arsha_ApplyWeb_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Arsha_ApplyWeb_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Arsha_ApplyWeb_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobal_ArshaApplyWeb_All_HideAni()
  if nil == Panel_Arsha_ApplyWeb_All then
    return
  end
  Panel_Arsha_ApplyWeb_All:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Arsha_ApplyWeb_All, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_resetCoherentUIForArshaWeb()
  if nil == Panel_Arsha_ApplyWeb_All or false == Panel_Arsha_ApplyWeb_All:GetShow() then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_ArshaApplyWeb_All_Close()
end
function PaGlobal_ArshaApplyWeb_All_Close()
  PaGlobal_ArshaApplyWeb_All:prepareClose()
end
function PaGlobal_ArshaApplyWeb_All_Open()
  PaGlobal_ArshaApplyWeb_All:prepareOpen()
end
