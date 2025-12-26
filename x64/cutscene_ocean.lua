Panel_Cutscene:SetPosX(0)
Panel_Cutscene:SetPosY(0)
Panel_Cutscene:SetShow(false, false)
Panel_Cutscene:SetSize(getScreenSizeX(), getScreenSizeY())
Panel_Cutscene:SetIgnore(true)
local Static_LatterBoxTop = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxTop")
local Static_LatterBoxBottom = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxBottom")
local Static_LetterBoxLeft = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxLeft")
local Static_LetterBoxRight = UI.getChildControl(Panel_Cutscene, "Static_LetterBoxRight")
local Static_FadeScreen = UI.getChildControl(Panel_Cutscene, "Static_FadeScreen")
local Multiline_Subtitle = UI.getChildControl(Panel_Cutscene, "MultilineText_Subtitle")
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
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
  Panel_Cutscene:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Cutscene:SetShow(true)
  local latterHeight = (getScreenSizeY() - 0.5625 * getScreenSizeX()) / 2
  local letterWidth = (getScreenSizeX() - 1.7777777777777777 * getScreenSizeY()) / 2
  if latterHeight < 0 then
    latterHeight = 0
  end
  if letterWidth < 0 then
    letterWidth = 0
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
  Multiline_Subtitle:SetText("")
  Multiline_Subtitle:SetSize(getScreenSizeX(), Multiline_Subtitle:GetSizeY())
  Multiline_Subtitle:SetSpanSize(0, latterHeight + 10)
  Multiline_Subtitle:ComputePos()
  if true == _ContentsGroup_UsePadSnapping then
    local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
    if nil ~= txt_keyGuideB then
      txt_keyGuideB:SetShow(true)
    end
  end
  ToClient_CutscenePlay(cutSceneName, isFromServer)
end
function FromClient_PlayCutSceneOcean(cutSceneName)
  Panel_Cutscene:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Cutscene:SetShow(true)
  local latterHeight = (getScreenSizeY() - 0.5625 * getScreenSizeX()) / 2
  local letterWidth = (getScreenSizeX() - 1.7777777777777777 * getScreenSizeY()) / 2
  if latterHeight < 0 then
    latterHeight = 0
  end
  if letterWidth < 0 then
    letterWidth = 0
  end
  Static_FadeScreen:SetShow(true)
  Static_FadeScreen:SetSize(getScreenSizeX(), getScreenSizeY())
  Static_FadeScreen:ComputePos()
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
    Multiline_Subtitle:SetText("")
    Multiline_Subtitle:SetSize(getScreenSizeX(), Multiline_Subtitle:GetSizeY())
    Multiline_Subtitle:SetSpanSize(0, latterHeight)
    Multiline_Subtitle:ComputePos()
  else
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
    Multiline_Subtitle:SetText("")
    Multiline_Subtitle:SetSize(getScreenSizeX(), Multiline_Subtitle:GetSizeY())
    Multiline_Subtitle:SetSpanSize(0, latterHeight + 10)
    Multiline_Subtitle:ComputePos()
  end
  if true == _ContentsGroup_UsePadSnapping then
    local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
    if nil ~= txt_keyGuideB then
      txt_keyGuideB:SetShow(true)
    end
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_CUTSCENE")
  ToClient_CutscenePlayOcean(cutSceneName)
  if nil ~= FromClient_StopSequence_Ocean then
    FromClient_StopSequence_Ocean()
  end
end
function FromClient_ChangeFreeCamMode(state)
  Static_LatterBoxTop:SetShow(state)
  Static_LatterBoxBottom:SetShow(state)
  Static_LetterBoxRight:SetShow(state)
  Static_LetterBoxLeft:SetShow(state)
  Panel_Cutscene:SetShow(state)
  Static_FadeScreen:SetShow(state)
end
function FromClient_StopCutScene()
  Multiline_Subtitle:SetText("")
  Static_LatterBoxTop:SetShow(false)
  Static_LatterBoxBottom:SetShow(false)
  Static_LetterBoxRight:SetShow(false)
  Static_LetterBoxLeft:SetShow(false)
  Static_FadeScreen:SetShow(false)
  Panel_Cutscene:SetShow(false)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_CUTSCENE")
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
  if false == isGameServiceTypeConsole() then
    return
  end
  local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
  if nil ~= txt_keyGuideB then
    txt_keyGuideB:SetShow(true)
  end
end
function PaGlobalFunc_CutScene_HideKeyGuide()
  if false == isGameServiceTypeConsole() then
    return
  end
  local txt_keyGuideB = UI.getChildControl(Panel_Cutscene, "StaticText_B_ConsoleUI")
  if nil ~= txt_keyGuideB then
    txt_keyGuideB:SetShow(false)
  end
end
function FromClient_CutsceneResizeScreen(width, height)
  if nil == Panel_Cutscene or false == Panel_Cutscene:GetShow() then
    return
  end
  Panel_Cutscene:SetSize(width, height)
  Panel_Cutscene:SetShow(true)
  local latterHeight = (height - 0.5625 * width) / 2
  local letterWidth = (width - 1.7777777777777777 * height) / 2
  if latterHeight < 0 then
    latterHeight = 0
  end
  if letterWidth < 0 then
    letterWidth = 0
  end
  Static_FadeScreen:SetShow(true)
  Static_FadeScreen:SetSize(width, height)
  Static_FadeScreen:ComputePos()
  if true == ToClient_isCutSceneLetterBoxTestMode() then
    local screenX = width
    local screenY = height
    local latterBoxMinRate = 0.125
    local latterBoxMinSizeY = screenY * latterBoxMinRate
    if latterHeight < latterBoxMinSizeY then
      latterHeight = latterBoxMinSizeY
    end
    Static_LatterBoxTop:SetShow(true)
    Static_LatterBoxTop:SetSize(width, latterHeight)
    Static_LatterBoxTop:ComputePos()
    Static_LatterBoxBottom:SetShow(true)
    Static_LatterBoxBottom:SetSize(width, latterHeight)
    Static_LatterBoxBottom:ComputePos()
    Static_LetterBoxLeft:SetShow(true)
    Static_LetterBoxLeft:SetSize(letterWidth, width)
    Static_LetterBoxLeft:ComputePos()
    Static_LetterBoxRight:SetShow(true)
    Static_LetterBoxRight:SetSize(letterWidth, width)
    Static_LetterBoxRight:ComputePos()
    Multiline_Subtitle:SetText("")
    Multiline_Subtitle:SetSize(width, Multiline_Subtitle:GetSizeY())
    Multiline_Subtitle:SetSpanSize(0, latterHeight)
    Multiline_Subtitle:ComputePos()
  else
    Static_LatterBoxTop:SetShow(true)
    Static_LatterBoxTop:SetSize(width, latterHeight)
    Static_LatterBoxTop:ComputePos()
    Static_LatterBoxBottom:SetShow(true)
    Static_LatterBoxBottom:SetSize(width, latterHeight)
    Static_LatterBoxBottom:ComputePos()
    Static_LetterBoxLeft:SetShow(true)
    Static_LetterBoxLeft:SetSize(letterWidth, width)
    Static_LetterBoxLeft:ComputePos()
    Static_LetterBoxRight:SetShow(true)
    Static_LetterBoxRight:SetSize(letterWidth, width)
    Static_LetterBoxRight:ComputePos()
    Multiline_Subtitle:SetText("")
    Multiline_Subtitle:SetSize(width, Multiline_Subtitle:GetSizeY())
    Multiline_Subtitle:SetSpanSize(0, latterHeight + 10)
    Multiline_Subtitle:ComputePos()
  end
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
registerEvent("FromClient_ChangeFreeCamMode", "FromClient_ChangeFreeCamMode")
registerEvent("FromClient_PlayCutSceneOcean", "FromClient_PlayCutSceneOcean")
registerEvent("FromClient_PlayCutScene", "FromClient_PlayCutScene")
registerEvent("FromClient_StopCutScene", "FromClient_StopCutScene")
registerEvent("FromClient_SetScreenAlpha", "FromClient_SetScreenAlpha")
registerEvent("FromClient_SetSubtitle", "FromClient_SetSubtitle")
registerEvent("FromClient_CutsceneResizeScreen", "FromClient_CutsceneResizeScreen")
Panel_Cutscene:RegisterUpdateFunc("Update_Subtitle")
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
function FromClient_CloseCutSceneEditorUI_Ocean()
  if Panel_Cutscene == nil then
    return
  end
  Panel_Cutscene:SetShow(false)
end
registerEvent("FromClient_ShowSequenceFadeScreen", "FromClient_ShowSequenceFadeScreen")
registerEvent("FromClient_CloseCutSceneEditorUI_Ocean", "FromClient_CloseCutSceneEditorUI_Ocean")
