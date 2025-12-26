Panel_DialogMovie:SetShow(false, false)
local updateTime = 0
local static_DialogMovie
isDialogMoviePlaying = false
local DialogMoviePlayTime = 20
local dialogTextSpanSizeY = 150
local renderMode = RenderModeWrapper.new(99, {
  Defines.RenderMode.eRenderMode_Video
}, false)
local isConsoleService = isGameServiceTypeConsole()
local currentVideoPath = ""
function FromClient_preparePlayDialogVideo()
  isDialogMoviePlaying = true
end
function FromClient_PlayDialogVideo(videoPath, isHaveSrt)
  local uiScale = getGlobalScale()
  if static_DialogMovie == nil then
    if isConsoleService == true then
      static_DialogMovie = UI.createControl(__ePAUIControl_WebControl, Panel_DialogMovie, "VideoControl_Movie")
      static_DialogMovie:SetUrl(1920, 1080, "coui://UI_Data/UI_Html/Intro_Movie.html")
    else
      static_DialogMovie = UI.createControl(__ePAUIControl_VideoContent, Panel_DialogMovie, "VideoControl_Movie")
    end
  end
  if nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    PaGlobalFunc_DialogMain_All_Close()
  end
  currentVideoPath = videoPath
  ToClient_SetFalseCharacterViewMode()
  Panel_DialogMovie:SetShow(true, false)
  local sizeX = getResolutionSizeX()
  local sizeY = getResolutionSizeY()
  sizeX = sizeX / uiScale
  sizeY = sizeY / uiScale
  local movieSizeX = sizeX
  local movieSizeY = sizeX * 9 / 16
  if sizeY < movieSizeY then
    movieSizeX = sizeY * 16 / 9
    movieSizeY = sizeY
  end
  Panel_DialogMovie:SetPosX(0)
  Panel_DialogMovie:SetPosY(0)
  Panel_DialogMovie:SetSize(sizeX, sizeY)
  renderMode:set()
  static_DialogMovie:SetIgnore(false)
  local tempPosX = (getOriginScreenSizeX() - movieSizeX) * 0.5
  local tempPosY = (getOriginScreenSizeY() - movieSizeY) * 0.5
  static_DialogMovie:SetPosX(tempPosX)
  static_DialogMovie:SetPosY(tempPosY)
  static_DialogMovie:SetSize(movieSizeX, movieSizeY)
  local moviePath = ""
  if isConsoleService == true then
    moviePath = "coui://" .. videoPath .. ".webm"
  else
    moviePath = videoPath .. ".bk2"
  end
  local subTitlePath = ""
  if true == isHaveSrt then
    subTitlePath = videoPath .. ".srt"
  end
  if isConsoleService == true then
    toClient_FadeIn(1)
    static_DialogMovie:TriggerEvent("PlayMovie", moviePath)
  else
    local stc_subTitle = static_DialogMovie:getSubTitleControl()
    if nil ~= stc_subTitle then
      stc_subTitle:SetSpanSize(0, dialogTextSpanSizeY)
    end
    static_DialogMovie:createVideoView(moviePath, getResolutionSizeX(), getResolutionSizeY(), false, true, subTitlePath)
    isDialogMoviePlaying = true
  end
  SetUIMode(Defines.UIMode.eUIMode_Movie)
  setMoviePlayMode(true)
end
function SetMovieSize()
  local uiScale = getGlobalScale()
  if static_DialogMovie == nil then
    return
  end
  local sizeX = getResolutionSizeX()
  local sizeY = getResolutionSizeY()
  sizeX = sizeX / uiScale
  sizeY = sizeY / uiScale
  local movieSizeX = sizeX
  local movieSizeY = sizeX * 9 / 16
  local posX = 0
  local posY = 0
  if sizeY >= movieSizeY then
    posY = (sizeY - movieSizeY) / 2
  else
    movieSizeX = sizeY * 16 / 9
    movieSizeY = sizeY
    posX = (sizeX - movieSizeX) / 2
  end
  Panel_DialogMovie:SetPosX(0)
  Panel_DialogMovie:SetPosY(0)
  Panel_DialogMovie:SetSize(sizeX, sizeY)
  static_DialogMovie:SetIgnore(false)
  static_DialogMovie:SetPosX(posX)
  static_DialogMovie:SetPosY(posY)
  static_DialogMovie:SetSize(movieSizeX, movieSizeY)
end
function CloseDialogMovie()
  if static_DialogMovie ~= nil then
    if true == _ContentsGroup_UseInGameVideoContent then
      static_DialogMovie:resetVideoView()
    end
    if isConsoleService == true then
      static_DialogMovie:TriggerEvent("StopMovie", "")
    end
  end
  Panel_DialogMovie:SetShow(false, false)
  isDialogMoviePlaying = false
  SetUIMode(Defines.UIMode.eUIMode_Default)
  setMoviePlayMode(false)
  FGlobal_SetIsCutScenePlay(false)
  renderMode:reset()
  toClient_FadeIn(1)
end
function ShowDialogMovie()
  if nil == static_DialogMovie then
    return
  end
  setMoviePlayMode(true)
end
function FromClient_StopDialogVideo(param)
  if param == 1 then
    if Panel_DialogMovie:GetShow() == true then
      FromClient_PlayDialogVideo(currentVideoPath, false)
    end
  elseif 2 == param and true == Panel_DialogMovie:GetShow() then
    setMoviePlayMode(false)
    toClient_FadeIn(1)
    CloseDialogMovie()
  end
end
function PaGlobalFunc_DialogMovie_IsPlayingMovie()
  if static_DialogMovie == nil then
    return false
  end
  return isDialogMoviePlaying
end
registerEvent("FromClient_preparePlayDialogVideo", "FromClient_preparePlayDialogVideo")
registerEvent("FromClient_PlayDialogVideo", "FromClient_PlayDialogVideo")
registerEvent("ToClient_EndGuideMovie", "FromClient_StopDialogVideo")
registerEvent("onScreenResize", "SetMovieSize")
renderMode:setClosefunctor(renderMode, FromClient_StopDialogVideo)
