function PaGlobalFunc_AccountLinking_Web_Open()
  if true == Panel_Window_AccountLinking_Web:GetShow() then
    return
  end
  PaGlobal_AccountLinking_Web:prepareOpen()
end
function PaGlobalFunc_AccountLinking_Web_Close()
  if false == Panel_Window_AccountLinking_Web:GetShow() then
    return
  end
  PaGlobal_AccountLinking_Web:prepareClose()
end
function PaGlobalFunc_AccountLinking_Web_ShowAni()
  UIAni.fadeInSCR_Down(Panel_Window_AccountLinking_Web)
  local aniInfo1 = Panel_Window_AccountLinking_Web:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.1)
  aniInfo1.AxisX = Panel_Window_AccountLinking_Web:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_AccountLinking_Web:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Window_AccountLinking_Web:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.1)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_AccountLinking_Web:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_AccountLinking_Web:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function PaGlobalFunc_AccountLinking_Web_HideAni()
  audioPostEvent_SystemUi(13, 5)
  Panel_Window_AccountLinking_Web:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Window_AccountLinking_Web, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_resetCoherentUIForAccountLinking_Web()
  if Panel_Window_AccountLinking_Web:GetShow() then
    TooltipSimple_Hide()
    PaGlobalFunc_AccountLinking_Web_Close()
  end
end
function FromClient_AccountLinking_Web_isMainView(isMainView)
  if PaGlobal_AccountLinking_Web == nil then
    return
  end
  PaGlobal_AccountLinking_Web._isMainView = isMainView
end
function PaGlobalFunc_AccountLinking_Web_Confirm(str, contentLabel)
  if PaGlobal_AccountLinking_Web == nil then
    return
  end
  PaGlobal_AccountLinking_Web._ui.stc_webControl:TriggerEvent("FromClient_SendContentString", str, contentLabel)
end
