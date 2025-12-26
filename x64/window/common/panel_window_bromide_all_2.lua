function PaGlobalFunc_Bromide_All_Open(itemKey)
  PaGlobal_Bromide_All:prepareOpen(itemKey)
end
function PaGlobalFunc_Bromide_All_Close()
  if Panel_Window_Bromide_All == nil then
    return
  end
  if PaGlobal_Bromide_All._ui._stc_bigPicture:GetShow() == true then
    Panel_Window_Bromide_All:SetPosX(PaGlobal_Bromide_All._prevPos.x)
    Panel_Window_Bromide_All:SetPosY(PaGlobal_Bromide_All._prevPos.y)
    PaGlobal_Bromide_All._ui._stc_blackBG:SetShow(false)
    PaGlobal_Bromide_All._ui._stc_bigPicture:SetShow(false)
    PaGlobal_Bromide_All._ui._stc_smallPicture:SetShow(true)
    PaGlobal_Bromide_All:allignKeyGuide()
    return
  end
  PaGlobal_Bromide_All:prepareClose()
end
function PaGlobalFunc_Bromide_All_ShowAni()
  if Panel_Window_Bromide_All == nil then
    return
  end
  Panel_Window_Bromide_All:ResetVertexAni()
  local aniInfo1 = Panel_Window_Bromide_All:addScaleAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.1)
  aniInfo1:SetEndScale(1)
  aniInfo1.AxisX = Panel_Window_Bromide_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Bromide_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_Bromide_All_HideAni()
  if Panel_Window_Bromide_All == nil then
    return
  end
  Panel_Window_Bromide_All:ResetVertexAni()
  Panel_Window_Bromide_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Bromide_All:addColorAnimation(0, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function HandleEventLUp_Bromide_All_ToggleShowMode()
  if Panel_Window_Bromide_All == nil then
    return
  end
  local isShow = not PaGlobal_Bromide_All._ui._stc_bigPicture:GetShow()
  if isShow == true then
    PaGlobal_Bromide_All._ui._stc_smallPicture:SetShow(false)
    PaGlobal_Bromide_All._prevPos.x = Panel_Window_Bromide_All:GetPosX()
    PaGlobal_Bromide_All._prevPos.y = Panel_Window_Bromide_All:GetPosY()
    Panel_Window_Bromide_All:SetPosX(0)
    Panel_Window_Bromide_All:SetPosY(0)
    PaGlobal_Bromide_All._ui._stc_blackBG:SetShow(true)
    PaGlobal_Bromide_All._ui._stc_bigPicture:SetShow(true)
  else
    Panel_Window_Bromide_All:SetPosX(PaGlobal_Bromide_All._prevPos.x)
    Panel_Window_Bromide_All:SetPosY(PaGlobal_Bromide_All._prevPos.y)
    PaGlobal_Bromide_All._ui._stc_smallPicture:SetShow(true)
    PaGlobal_Bromide_All._ui._stc_bigPicture:SetShow(false)
    PaGlobal_Bromide_All._ui._stc_blackBG:SetShow(false)
  end
  PaGlobal_Bromide_All:allignKeyGuide()
end
function FromClient_Bromide_All_ResizePanel()
  if Panel_Window_Bromide_All == nil then
    return
  end
  local screenSize = {
    x = getScreenSizeX(),
    y = getScreenSizeY()
  }
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX() / uiScale
  local sizeY = getResolutionSizeY() / uiScale
  local imageSize = {
    x = sizeX,
    y = sizeX * 9 / 16
  }
  if screenSize.y < imageSize.y then
    imageSize.y = screenSize.y
    imageSize.x = imageSize.y * 16 / 9
  end
  PaGlobal_Bromide_All._ui._stc_blackBG:SetSize(screenSize.x, screenSize.y)
  PaGlobal_Bromide_All._ui._stc_bigPicture:SetSize(imageSize.x, imageSize.y)
  Panel_Window_Bromide_All:ComputePosAllChild()
  PaGlobal_Bromide_All._prevPos.x = Panel_Window_Bromide_All:GetPosX()
  PaGlobal_Bromide_All._prevPos.y = Panel_Window_Bromide_All:GetPosY()
  PaGlobal_Bromide_All._ui._stc_bigPicture:SetSpanSize((screenSize.x - imageSize.x) / 2, (screenSize.y - imageSize.y) / 2)
  PaGlobal_Bromide_All:allignKeyGuide()
end
