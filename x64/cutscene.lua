Panel_Cutscene:SetPosX(0)
Panel_Cutscene:SetPosY(0)
Panel_Cutscene:SetShow(false, false)
Panel_Cutscene:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
Panel_Cutscene:SetIgnore(true)
local renderMode = RenderModeWrapper.new(99, {
  Defines.RenderMode.eRenderMode_CutScene
}, false)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local Static_LatterBoxTop = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxTop")
local Static_LatterBoxBottom = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxBottom")
local Static_LetterBoxLeft = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxLeft")
local Static_LetterBoxRight = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxRight")
local Static_FadeScreen = UI.getChildControl(Panel_Cutscene, "Static_FadeScreen")
local Multiline_Subtitle = UI.getChildControl(Panel_Cutscene, "MultilineText_Subtitle")
local Static_SupportVoice = UI.getChildControl(Panel_Cutscene, "StaticText_SupportVoice")
local IM = CppEnums.EProcessorInputMode
local UIMode = Defines.UIMode
local prevUIMode = UIMode.eUIMode_Default
local isCutScenePlay = false
local isEnableDistanceCheckNak = true
ToClient_setCutSceneState(false)
function FGlobal_SetIsCutScenePlay(isValid)
  isCutScenePlay = isValid
  ToClient_setCutSceneState(isValid)
end
function FGlobal_GetIsCutScenePlay()
  isCutScenePlay = ToClient_isCutSceneState()
  return isCutScenePlay
end
function FGlobal_GetIsCutScenePlayerControlMode()
  return ToClient_isCutScenePlayerControlMode()
end
Panel_Cutscene:RegisterUpdateFunc("Update_Subtitle")
function Update_Subtitle(deltaTime)
  if isSubtitleDelete == false then
    subtitleTimer = subtitleTimer + deltaTime
    if subtitleTimer > subtitleDeleteTime then
      subtitleTimer = 0
      subtitleDeleteTime = 0
      isSubtitleDelete = true
      Multiline_Subtitle:SetText("")
    end
  end
end
function FromClient_PlayCutScene(cutSceneName, isFromServer)
  ToClient_SaveUiInfo(false)
  crossHair_SetShow(false)
  prevUIMode = GetUIMode()
  FGlobal_SetIsCutScenePlay(true)
  SetUIMode(Defines.UIMode.eUIMode_Cutscene)
  renderMode:set()
  if ToClient_isInAbyssOne() == true and PaGlobal_AbyssOneInfo ~= nil then
    PaGlobalFunc_AbyssOneInfo_TimeClose()
  end
  if Panel_SkillCommand ~= nil then
    Panel_SkillCommand:SetShow(false)
  end
  if true == isPhotoMode() then
    ToClient_SetPhotoModeRender(false)
  end
  if nil ~= FGlobal_WebHelper_ForceClose then
    FGlobal_WebHelper_ForceClose()
  end
  if nil ~= Panel_ProductNote and true == Panel_ProductNote:GetShow() then
    Panel_ProductNote_ShowToggle()
  end
  Panel_Cutscene:SetSize(getScreenSizeX(), getScreenSizeY())
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Cutscene:SetPosXY(0, 0)
  end
  Panel_Cutscene:SetShow(true)
  ToClient_CutscenePlay(cutSceneName, isFromServer)
  local latterHeight = (getScreenSizeY() - 0.5625 * getScreenSizeX()) / 2
  local letterWidth = (getScreenSizeX() - 1.7777777777777777 * getScreenSizeY()) / 2
  if latterHeight < 0 then
    latterHeight = 0
  end
  if letterWidth < 0 then
    letterWidth = 0
  end
  if true == ToClient_isCutSceneLetterBoxTestMode() then
    local resolutionScreenX = getResolutionSizeX()
    local resolutionScreenY = getResolutionSizeY()
    local screenX = getScreenSizeX()
    local screenY = getScreenSizeY()
    local lateY = screenY / resolutionScreenY
    local latterBoxMinRate = 0.125
    local latterBoxMinSizeY = resolutionScreenY * latterBoxMinRate * lateY
    if latterHeight < latterBoxMinSizeY then
      latterHeight = latterBoxMinSizeY
    end
    Static_FadeScreen:SetShow(true)
    Static_FadeScreen:SetSize(getScreenSizeX(), getScreenSizeY())
    Static_FadeScreen:ComputePos()
    Static_LatterBoxTop:SetShow(true)
    Static_LatterBoxTop:SetSize(getScreenSizeX(), latterHeight)
    Static_LatterBoxTop:ComputePos()
    Static_LatterBoxBottom:SetShow(true)
    Static_LatterBoxBottom:SetSize(getScreenSizeX(), latterHeight)
    Static_LatterBoxBottom:ComputePos()
    Static_LetterBoxLeft:SetShow(true)
    Static_LetterBoxLeft:SetSize(letterWidth, getScreenSizeX())
    Static_LetterBoxLeft:ComputePos()
    Static_LetterBoxRight:SetShow(true)
    Static_LetterBoxRight:SetSize(letterWidth, getScreenSizeX())
    Static_LetterBoxRight:ComputePos()
    Static_SupportVoice:SetShow(false)
    Multiline_Subtitle:SetText("")
    Multiline_Subtitle:SetSize(getScreenSizeX(), Multiline_Subtitle:GetSizeY())
    Multiline_Subtitle:SetSpanSize(0, latterHeight)
    Multiline_Subtitle:ComputePos()
  else
    Static_FadeScreen:SetShow(true)
    Static_FadeScreen:SetSize(getScreenSizeX(), getScreenSizeY())
    Static_FadeScreen:ComputePos()
    Static_LatterBoxTop:SetShow(true)
    Static_LatterBoxTop:SetSize(getScreenSizeX(), latterHeight)
    Static_LatterBoxTop:ComputePos()
    Static_LatterBoxBottom:SetShow(true)
    Static_LatterBoxBottom:SetSize(getScreenSizeX(), latterHeight)
    Static_LatterBoxBottom:ComputePos()
    Static_LetterBoxLeft:SetShow(true)
    Static_LetterBoxLeft:SetSize(letterWidth, getScreenSizeX())
    Static_LetterBoxLeft:ComputePos()
    Static_LetterBoxRight:SetShow(true)
    Static_LetterBoxRight:SetSize(letterWidth, getScreenSizeX())
    Static_LetterBoxRight:ComputePos()
    Static_SupportVoice:SetShow(false)
    Static_SupportVoice:ComputePos()
    Multiline_Subtitle:SetText("")
    Multiline_Subtitle:SetSize(getScreenSizeX(), Multiline_Subtitle:GetSizeY())
    Multiline_Subtitle:SetSpanSize(0, latterHeight + 10)
    Multiline_Subtitle:ComputePos()
  end
  local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
  txt_keyGuideB:SetShow(_ContentsGroup_UsePadSnapping and false == ToClient_IsEnterSequence())
  if true == _ContentsGroup_UsePadSnapping then
    txt_keyGuideB:ComputePos()
    txt_keyGuideB:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GENERIC_KEYGUIDE_XBOX_SKIP"))
    txt_keyGuideB:SetPosX(getScreenSizeX() - txt_keyGuideB:GetSizeX() - txt_keyGuideB:GetTextSizeX() - 10)
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_CUTSCENE")
  if true == ToClient_IsEnterSequence() then
    PaGlobal_CutSceneScript_Open()
  end
  if hideRecentTargetInfo ~= nil then
    hideRecentTargetInfo()
  end
  FromClient_LeaveSequencePossessMode_Sequence_HpMpBar_Close()
  FromClient_LeaveSequencePossessMode_Sequence_Stamina_Close()
  FromClient_LeaveSequencePossessMode_Sequence_Adrenallin_Close()
  isEnableDistanceCheckNak = true
end
function FromClient_StopCutScene(cutSceneName)
  Multiline_Subtitle:SetText("")
  Static_LatterBoxTop:SetShow(false)
  Static_LatterBoxBottom:SetShow(false)
  Static_LetterBoxRight:SetShow(false)
  Static_LetterBoxLeft:SetShow(false)
  Panel_Cutscene:SetShow(false)
  Static_FadeScreen:SetShow(false)
  if prevUIMode ~= Defines.UIMode.eUIMode_Cutscene then
    SetUIMode(prevUIMode)
  end
  FGlobal_SetIsCutScenePlay(false)
  renderMode:reset()
  crossHair_SetShow(true)
  postProcessMessageData()
  if PaGlobal_TutorialManager ~= nil then
    PaGlobal_TutorialManager:handleStopCutScene(cutSceneName)
  end
  if Panel_Window_CutSceneSkip ~= nil and Panel_Window_CutSceneSkip:GetShow() == true then
    PaGlobal_CutSceneSkip_Close()
  end
  if Panel_Window_CutSceneScript ~= nil and Panel_Window_CutSceneScript:GetShow() == true then
    PaGlobal_CutSceneScript_Close()
  end
  if Panel_Window_CutSceneEscSkip ~= nil and Panel_Window_CutSceneEscSkip:GetShow() == true then
    PaGlobalFunc_CutSceneEscSkip_Close()
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_CUTSCENE")
  isEnableDistanceCheckNak = true
end
function FromClient_SetSubtitle(subtitle, Time, posAttr)
  Panel_Cutscene:SetFadeOverRender()
  Multiline_Subtitle:SetText(subtitle)
  if posAttr == __eCUTSCENE_SUBTITLE_POS_ATTR_BOTTOM then
    Multiline_Subtitle:SetVerticalBottom()
  end
  if posAttr == __eCUTSCENE_SUBTITLE_POS_ATTR_TOP then
    Multiline_Subtitle:SetVerticalTop()
  end
  if posAttr == __eCUTSCENE_SUBTITLE_POS_ATTR_MID then
    Multiline_Subtitle:SetVerticalMiddle()
  end
  subtitleTimer = 0
  subtitleDeleteTime = Time
  isSubtitleDelete = false
end
function FromClient_SetScreenAlpha(value)
  Static_FadeScreen:SetAlpha(value)
end
function PaGlobalFunc_CutScene_ShowKeyGuide()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
  if nil ~= txt_keyGuideB then
    txt_keyGuideB:SetShow(true)
  end
end
function PaGlobalFunc_CutScene_HideKeyGuide()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
  if nil ~= txt_keyGuideB then
    txt_keyGuideB:SetShow(false)
  end
end
function PaGlobalFunc_Cutscene_IsEnableDistanceCheckNak()
  return isEnableDistanceCheckNak
end
function PaGlobalFunc_Cutscene_SetEnableDistanceCheckNak(enable)
  isEnableDistanceCheckNak = enable
end
function PaGlobalFunc_Cutscene_ShowAlert(actorKeyRaw, isSelfPlayer, param, stringKey)
  if isEnableDistanceCheckNak == false then
    return
  end
  local str = PAGetStringByStringHash(Defines.StringSheet_CUTSCENE, stringKey)
  Proc_ShowMessage_Ack(str, 5, getScreenSizeX() / 2, getScreenSizeY() / 2)
  isEnableDistanceCheckNak = false
end
function PaGlobal_GameoptionTutorial_All_RevertGraphic()
  ToClient_SetTutorialOption_RemasterMode(false)
  ToClient_SetTutorialOption_RevertGraphic()
end
function FromClient_LeavePossessPostUpdate()
  SetUIMode(Defines.UIMode.eUIMode_Cutscene)
  hideRecentTargetInfo()
end
function FromClient_EnterSequencePossessMode_LatterBox()
  Static_LatterBoxTop:SetShow(false)
  Static_LatterBoxBottom:SetShow(false)
  Static_LetterBoxLeft:SetShow(false)
  Static_LetterBoxRight:SetShow(false)
end
function FromClient_LeaveSequencePossessMode_LatterBox()
  Static_LatterBoxTop:SetShow(true)
  Static_LatterBoxBottom:SetShow(true)
  Static_LetterBoxLeft:SetShow(true)
  Static_LetterBoxRight:SetShow(true)
end
registerEvent("FromClient_EnterSequencePossessMode", "FromClient_EnterSequencePossessMode_LatterBox")
registerEvent("FromClient_LeaveSequencePossessMode", "FromClient_LeaveSequencePossessMode_LatterBox")
registerEvent("FromClient_PlayCutScene", "FromClient_PlayCutScene")
registerEvent("FromClient_StopCutScene", "FromClient_StopCutScene")
registerEvent("FromClient_SetScreenAlpha", "FromClient_SetScreenAlpha")
registerEvent("FromClient_SetSubtitle", "FromClient_SetSubtitle")
registerEvent("FromClient_LeavePossessPostUpdate", "FromClient_LeavePossessPostUpdate")
renderMode:setClosefunctor(renderMode, FromClient_StopCutScene)
ActionChartEventBindFunction(512, PaGlobalFunc_Cutscene_ShowAlert)
function SequenceFadeScreen_AlphaAnimation(toAlpha, control, startTime, endTime, red, green, blue)
  control:ResetVertexAni()
  local alphaAni = control:addColorAnimation(startTime, endTime, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  alphaAni:SetStartColorBySafe(PAUIColorType(control:GetAlpha() * 255, red, green, blue))
  alphaAni:SetEndColorBySafe(PAUIColorType(toAlpha * 255, red, green, blue))
  alphaAni.IsChangeChild = true
  return alphaAni
end
function FromClient_ShowSequenceFadeScreen(isOn, startTime, endTime)
  if Panel_Cutscene == nil then
    return
  end
  if isOn == true then
    Static_FadeScreen:SetAlpha(0)
    SequenceFadeScreen_AlphaAnimation(1, Static_FadeScreen, startTime, endTime, 0, 0, 0)
  else
    Static_FadeScreen:SetAlpha(1)
    local alphaAni = SequenceFadeScreen_AlphaAnimation(0, Static_FadeScreen, startTime, endTime, 0, 0, 0)
    alphaAni:SetHideAtEnd(true)
  end
end
registerEvent("FromClient_ShowSequenceFadeScreen", "FromClient_ShowSequenceFadeScreen")
