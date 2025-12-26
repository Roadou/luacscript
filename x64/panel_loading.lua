Panel_Loading:SetShow(true, false)
Panel_Loading:SetOffsetIgnorePanel(true)
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local _currentTime = 10000
local _isStartLoading = false
local screenX, screenY
local _bg1 = UI.getChildControl(Panel_Loading, "Static_BG_1")
local _bg2 = UI.getChildControl(Panel_Loading, "Static_BG_2")
local _regionName = UI.getChildControl(Panel_Loading, "StaticText_RegionName")
local _knowledge_Image = UI.getChildControl(Panel_Loading, "Static_knowImage")
local _knowledge_title = UI.getChildControl(Panel_Loading, "StaticText_knowTitle")
local _knowledge_desc = UI.getChildControl(Panel_Loading, "StaticText_knowDesc")
local txt_randomGuide = UI.getChildControl(Panel_Loading, "StaticText_RandomGuide")
local txt_randomGuide2 = UI.getChildControl(Panel_Loading, "StaticText_RandomGuide2")
local progressRate = UI.getChildControl(Panel_Loading, "Progress2_Loading")
local progressHead = UI.getChildControl(progressRate, "Progress2_Bar_Head")
local staticBack = UI.getChildControl(Panel_Loading, "Static_Progress_Back")
local goblinRun = UI.getChildControl(Panel_Loading, "Static_GoblinRun")
local txt_versionInfo = UI.getChildControl(Panel_Loading, "StaticText_VersionInfo")
local txt_loadComplete = UI.getChildControl(Panel_Loading, "StaticText_LoadComplete")
local backGroundBlackBG = UI.getChildControl(Panel_Loading, "Static_BlackBG")
local backGroundEvnetImage = UI.getChildControl(Panel_Loading, "Static_BackImage")
local stc_movieBG = UI.getChildControl(Panel_Loading, "Static_MovieBG")
local _ui_loadingMovie
local stc_fade = UI.getChildControl(Panel_Loading, "Static_Fade")
local stc_bi
if true == isGameTypeKorea() then
  stc_bi = UI.getChildControl(Panel_Loading, "Static_BI")
else
  stc_bi = UI.getChildControl(Panel_Loading, "Static_BI_Global")
end
PaGlobalFunc_SetLoadingPrrgressSizeY(progressRate)
local isDraganOpen = ToClient_IsContentsGroupOpen("6")
local iskamasilviaOpen = ToClient_IsContentsGroupOpen("5")
local isOdyllitaOpen = ToClient_IsContentsGroupOpen("7")
local isBgOpen = isDraganOpen
local bgImageTexture = {}
local isUseVideoView = false
local isLoadingSkip = false
local _movieLength, _movieURL, _moviePath, _movieOrder
local _isRandom = false
local isLogoHide = false
local _currentMovieIndex
local isNotPlayLoadingVideo = true == _ContentsGroup_LoadingImageBuddy or true == _ContentsGroup_LoadingImageSage
function SetLoadingTexturePathForException()
  _moviePath = {
    "UI_Movie/O_01.bk2",
    "UI_Movie/O_02.bk2",
    "UI_Movie/O_03.bk2"
  }
  if true == isOdyllitaOpen then
    _movieURL = {
      "coui://UI_Movie/O_01.webm",
      "coui://UI_Movie/O_02.webm",
      "coui://UI_Movie/O_03.webm"
    }
    _moviePath = {
      "UI_Movie/O_01.bk2",
      "UI_Movie/O_02.bk2",
      "UI_Movie/O_03.bk2"
    }
    _movieLength = {
      8000,
      7000,
      5000
    }
    _movieOrder = {
      1,
      2,
      3
    }
    isUseVideoView = true
  elseif true == ToClient_IsContentsGroupOpen("504") then
    _movieURL = {
      "coui://UI_Movie/Ocean1.webm",
      "coui://UI_Movie/Ocean2.webm",
      "coui://UI_Movie/Remaster_loading_Scene_003_re.webm",
      "coui://UI_Movie/Remaster_loading_Scene_004_re.webm"
    }
    _movieLength = {
      10000,
      10000,
      10000,
      10000
    }
    _movieOrder = {
      1,
      2,
      3,
      4
    }
  else
    _movieURL = {
      "coui://UI_Movie/01_sliced.webm",
      "coui://UI_Movie/02_sliced.webm",
      "coui://UI_Movie/03_sliced.webm",
      "coui://UI_Movie/04_sliced.webm",
      "coui://UI_Movie/05_sliced.webm",
      "coui://UI_Movie/06_sliced.webm",
      "coui://UI_Movie/07_sliced.webm",
      "coui://UI_Movie/08_sliced.webm",
      "coui://UI_Movie/09_sliced.webm"
    }
    _movieLength = {
      10000,
      10000,
      10000,
      10000,
      10000,
      10000,
      10000,
      10000,
      10000
    }
    _movieOrder = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    }
  end
  if isBgOpen then
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/Dragan_01.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/Dragan_02.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/Dragan_03.dds",
      [3] = "New_UI_Common_ForLua/Window/Loading/Dragan_04.dds",
      [4] = "New_UI_Common_ForLua/Window/Loading/Dragan_05.dds",
      [5] = "New_UI_Common_ForLua/Window/Loading/Dragan_06.dds",
      ["count"] = 6
    }
    _moviePath = nil
    _movieURL = nil
  end
  if isGameTypeJapan() then
    isBgOpen = false
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/event_13.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/event_14.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/event_15.dds",
      ["count"] = 3
    }
    _moviePath = nil
    _movieURL = nil
  end
  if true == isGameTypeNA() then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
      [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
      ["count"] = 4
    }
    _moviePath = nil
    _movieURL = nil
  end
  if isGameTypeJapan() then
    isBgOpen = false
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
      [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
      ["count"] = 4
    }
    _moviePath = nil
    _movieURL = nil
  end
  if isGameTypeTaiwan() then
    isBgOpen = false
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
      [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
      ["count"] = 4
    }
    _moviePath = nil
    _movieURL = nil
  end
  if isGameTypeSA() then
    isBgOpen = false
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_1.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_2.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_3.dds",
      [3] = "New_UI_Common_ForLua/Window/Loading/bgNAOnly_4.dds",
      ["count"] = 4
    }
    _moviePath = nil
    _movieURL = nil
  end
  if isGameServiceTypeConsole() then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_1.dds",
      [1] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_2.dds",
      [2] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_3.dds",
      [3] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_4.dds",
      [4] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_5.dds",
      [5] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_6.dds",
      [6] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_7.dds",
      [7] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_8.dds",
      [8] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_9.dds",
      [9] = "New_UI_Common_ForLua/Window/Loading/xbox_loading_10.dds",
      ["count"] = 10
    }
    _moviePath = nil
    _movieURL = nil
  end
  if true == _ContentsGroup_RemasterUI_Lobby then
    isBgOpen = true
  end
  if true == isOdyllitaOpen then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "New_UI_Common_ForLua/Window/Lobby/bgOdyllita_1.dds",
      [1] = "New_UI_Common_ForLua/Window/Lobby/bgOdyllita_2.dds",
      [2] = "New_UI_Common_ForLua/Window/Lobby/bgOdyllita_3.dds",
      [3] = "New_UI_Common_ForLua/Window/Lobby/bgOdyllita_4.dds",
      ["count"] = 4
    }
    _moviePath = nil
    _movieURL = nil
  end
  if true == _ContentsGroup_Corsair then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "Combine/Loading/BlackDesert_With_Friends.dds",
      ["count"] = 1
    }
    _moviePath = nil
    _movieURL = nil
    isLogoHide = true
  end
  if true == _ContentsGroup_AtoraxionSea and false == isGameTypeCH() then
    _moviePath = {
      "UI_Movie/login_01.bk2",
      "UI_Movie/login_02.bk2",
      "UI_Movie/login_03.bk2"
    }
    _movieURL = {
      "coui://UI_Movie/login_01.webm",
      "coui://UI_Movie/login_02.webm",
      "coui://UI_Movie/login_03.webm"
    }
    isBgOpen = false
    _movieOrder = {
      1,
      2,
      3
    }
    isLogoHide = false
  end
  if true == _ContentsGroup_MountainOfEternalWinter then
    _moviePath = {
      "UI_Movie/PC/Loading/Winter/login_01.bk2",
      "UI_Movie/PC/Loading/Winter/login_02.bk2",
      "UI_Movie/PC/Loading/Winter/login_03.bk2",
      "UI_Movie/PC/Loading/Winter/login_04.bk2",
      "UI_Movie/PC/Loading/Winter/login_05.bk2",
      "UI_Movie/PC/Loading/Winter/login_06.bk2"
    }
    isBgOpen = false
    _movieOrder = {
      3,
      4,
      1,
      2,
      5,
      6
    }
    isLogoHide = false
  end
  if true == _ContentsGroup_Dracania and true == isGameTypeKorea() then
    _moviePath = {
      "UI_Movie/PC/Loading/Dracania_01.bk2",
      "UI_Movie/PC/Loading/Dracania_02.bk2",
      "UI_Movie/PC/Loading/Dracania_03.bk2",
      "UI_Movie/PC/Loading/Dracania_04.bk2",
      "UI_Movie/PC/Loading/Dracania_05.bk2",
      "UI_Movie/PC/Loading/Dracania_06.bk2"
    }
    isBgOpen = false
    _movieOrder = {1, 2}
    _isRandom = true
    isLogoHide = true
  end
  if true == _ContentsGroup_Dracania and true ~= isGameTypeKorea() then
    _moviePath = {
      "UI_Movie/PC/Loading/Dracania_01.bk2",
      "UI_Movie/PC/Loading/Dracania_02.bk2",
      "UI_Movie/PC/Loading/Dracania_03.bk2",
      "UI_Movie/PC/Loading/Dracania_04.bk2",
      "UI_Movie/PC/Loading/Dracania_05.bk2",
      "UI_Movie/PC/Loading/Dracania_06.bk2",
      "UI_Movie/PC/Loading/Winter/login_01.bk2",
      "UI_Movie/PC/Loading/Winter/login_02.bk2",
      "UI_Movie/PC/Loading/Winter/login_03.bk2",
      "UI_Movie/PC/Loading/Winter/login_04.bk2",
      "UI_Movie/PC/Loading/Winter/login_05.bk2",
      "UI_Movie/PC/Loading/Winter/login_06.bk2"
    }
    isBgOpen = false
    _movieOrder = {
      1,
      2,
      5,
      6,
      3,
      4,
      7,
      8
    }
    _isRandom = true
    isLogoHide = true
  end
  if isGameServiceTypeConsole() == true then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "Combine/Loading/Console/loading_11.dds",
      [1] = "Combine/Loading/Console/loading_20_cs.dds",
      [2] = "Combine/Loading/Console/loading_CS_06.dds",
      [3] = "Combine/Loading/Console/loading_CS_10.dds",
      [4] = "Combine/Loading/Console/loading_CS_14.dds",
      ["count"] = 5
    }
    _moviePath = nil
    _movieURL = nil
    isLogoHide = true
  elseif isGameTypeKorea() == true then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "Combine/Loading/202312/loading_34.dds",
      [1] = "Combine/Loading/250918/SeasonV.dds",
      [2] = "Combine/Loading/UpdateImage/Loading_Img_01.dds",
      ["count"] = 3
    }
    _moviePath = nil
    _movieURL = nil
    isLogoHide = true
  else
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "Combine/Loading/202312/loading_34.dds",
      [1] = "Combine/Loading/250918/SeasonV.dds",
      [2] = "Combine/Loading/UpdateImage/Loading_Img_01.dds",
      ["count"] = 3
    }
    _moviePath = nil
    _movieURL = nil
    isLogoHide = true
  end
  if isGameTypeCH() == true then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = "Combine/Loading/Service/loading_01_china.dds",
      [1] = "Combine/Loading/250918/SeasonV_China.dds",
      [2] = "Combine/Loading/UpdateImage/Loading_Img_01.dds",
      ["count"] = 3
    }
    _moviePath = nil
    _movieURL = nil
    isLogoHide = true
  end
end
function SetLoadingTexturePath()
  local tempMoviePath = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Bink)
  if tempMoviePath ~= nil then
    isBgOpen = false
    _moviePath = {tempMoviePath}
    _movieOrder = {1}
    _movieLength = nil
    _isRandom = true
    isUseVideoView = true
    isLogoHide = true
    return
  end
  local tempMovieURL = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Web)
  if tempMovieURL ~= nil then
    isBgOpen = false
    _movieURL = {tempMovieURL}
    _movieOrder = {1}
    _movieLength = nil
    _isRandom = true
    isUseVideoView = true
    isLogoHide = true
    return
  end
  local tempImagePath = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Image)
  if tempImagePath ~= nil then
    isBgOpen = true
    bgImageTexture = {}
    bgImageTexture = {
      [0] = tempImagePath,
      ["count"] = 1
    }
    _moviePath = nil
    _movieURL = nil
    isLogoHide = false
    return
  end
  SetLoadingTexturePathForException()
end
SetLoadingTexturePath()
progressRate:SetCurrentProgressRate(0)
_knowLedge_TitleSizeX = 0
function LoadingPanel_Resize()
  local screenOriX = getOriginScreenSizeX()
  local screenOriY = getOriginScreenSizeY()
  screenX = getResolutionSizeX()
  screenY = getResolutionSizeY()
  local uiScale = ToClient_GetUIScale()
  local scrX = screenX / uiScale
  local scrY = screenY / uiScale
  local movieSizeX = scrX
  local movieSizeY = scrX * 9 / 16
  local posX = 0
  local posY = 0
  if scrY >= movieSizeY then
    posY = (scrY - movieSizeY) / 2
  else
    movieSizeX = scrY * 16 / 9
    movieSizeY = scrY
    posX = (scrX - movieSizeX) / 2
  end
  Panel_Loading:SetSize(screenOriX, screenOriY)
  Panel_Loading:ComputePos()
  txt_versionInfo:ComputePos()
  txt_versionInfo:SetShow(_ContentsGroup_XB_Obt)
  _bg1:SetSize(screenX, screenY)
  _bg1:ComputePos()
  _bg2:SetSize(screenX, screenY)
  _bg2:SetSize(1, 1)
  _bg2:ComputePos()
  backGroundBlackBG:SetSize(screenOriX, screenOriY)
  backGroundBlackBG:ComputePos()
  local gameOptionSetting = ToClient_getGameOptionControllerWrapper()
  if true == gameOptionSetting:getIsUHDMode() then
    if true == isGameServiceTypeConsole() then
      if true == UI.checkResolution4KForXBox() then
        uiScale = uiScale * 0.5
      end
    else
      uiScale = uiScale * 0.5
    end
  end
  local progressRateSizeY = PaGlobalFunc_GetLoadingPrrgressSizeY()
  if progressRateSizeY == 0 then
    progressRateSizeY = progressRate:GetSizeY()
  end
  progressRate:SetSize(screenOriX * 0.8, progressRateSizeY)
  progressRate:ComputePos()
  if true == isGameServiceTypeConsole() then
    local gapY = (screenOriY - getScreenSizeY()) / 2
    progressRate:SetPosY(progressRate:GetPosY() - gapY)
  end
  staticBack:SetSize(screenX * 0.8, staticBack:GetSizeY())
  staticBack:ComputePos()
  backGroundEvnetImage:SetSize(movieSizeX, movieSizeY)
  backGroundEvnetImage:ComputePos()
  backGroundEvnetImage:SetShow(isBgOpen)
  stc_movieBG:SetSize(screenX, screenY)
  stc_movieBG:ComputePos()
  stc_fade:SetSize(screenX, screenY)
  if nil ~= _ui_loadingMovie and true == _ContentsGroup_RemasterUI_Lobby then
    backGroundEvnetImage:SetShow(true)
  end
  if true == isLogoHide then
    stc_bi:SetShow(false)
  elseif true == _ContentsGroup_RemasterUI_Lobby then
    stc_bi:ComputePos()
    stc_bi:SetShow(true)
  else
    stc_bi:SetShow(false)
  end
end
local addXpos = 0
function LoadingPanel_Init()
  progressRate:SetCurrentProgressRate(0)
  local progressRateX = progressRate:GetPosX()
  local progressRateY = progressRate:GetPosY()
  local progressHeadX = progressHead:GetPosX()
  local progressHeadY = progressHead:GetPosY()
  local isXmas = ToClient_isEventOn("x-mas")
  local isHalloween = ToClient_isEventOn("Halloween")
  local isEaster = ToClient_isEventOn("Easter")
  if isXmas then
    goblinRun:ChangeTextureInfoNameAsync("New_UI_Common_ForLua/Default/goblrun2.dds")
  elseif isEaster then
    goblinRun:ChangeTextureInfoNameAsync("New_UI_Common_ForLua/Default/EN_easter.dds")
  elseif isHalloween then
    goblinRun:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/goblrun3.dds")
    progressHead:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/obsidian_child2.dds")
    addXpos = 10
  else
    goblinRun:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/goblrun.dds")
    progressHead:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/obsidian_child.dds")
  end
  goblinRun:SetPosX(progressRateX + progressHeadX + progressHead:GetSizeX() + addXpos)
  goblinRun:SetPosY(progressRateY + progressHeadY + 25)
  stc_movieBG:SetShow(false)
  local isMovieActive = false
  if _ContentsGroup_RemasterUI_Lobby then
    stc_movieBG:SetShow(true)
    if true == isNotPlayLoadingVideo then
      local isBinkOpen = true == _ContentsGroup_UseVideoContent and true == isUseVideoView
      if true == isBinkOpen then
        local binkUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Bink)
        isMovieActive = nil ~= binkUrl or nil ~= _moviePath
      else
        local webUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Web)
        isMovieActive = nil ~= webUrl or nil ~= _movieURL
      end
      stc_movieBG:SetShow(isMovieActive)
    end
    stc_fade:SetShow(false)
    _currentMovieIndex = 1
    LoadingPanel_ShuffleOrder(_movieOrder)
  end
  if true == isGameTypeCH() then
    stc_movieBG:SetShow(false)
    stc_fade:SetShow(false)
  elseif true == isGameServiceTypeConsole() and false == isMovieActive then
    stc_movieBG:SetShow(false)
    stc_fade:SetShow(false)
  end
  isLoadingSkip = false
  txt_loadComplete:SetShow(false)
end
function LoadingPanel_ShuffleOrder(table)
  if nil == table or nil == #table then
    return
  end
  if #table <= 1 then
    return
  end
  for ii = 1, #table do
    local temp = table[ii]
    local posToShuffle = getRandomValue(1, #table)
    table[ii] = table[posToShuffle]
    table[posToShuffle] = temp
  end
end
function LoadingPanel_LoadMovie()
  if false == _ContentsGroup_RemasterUI_Lobby or true == isGameTypeCH() then
    return
  end
  local isMovieActive = false
  if true == isNotPlayLoadingVideo then
    local isBinkOpen = true == _ContentsGroup_UseVideoContent and true == isUseVideoView
    if true == isBinkOpen then
      local binkUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Bink)
      isMovieActive = nil ~= binkUrl or nil ~= _moviePath
    else
      local webUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Web)
      isMovieActive = nil ~= webUrl or nil ~= _movieURL
    end
    stc_movieBG:SetShow(isMovieActive)
    if false == isMovieActive then
      ToClient_setLoadingSkip()
    end
  else
    stc_movieBG:SetShow(true)
  end
  if true == isGameServiceTypeConsole() and false == isMovieActive then
    stc_movieBG:SetShow(false)
    return
  end
  if nil == _ui_loadingMovie then
    if true == _ContentsGroup_UseVideoContent and true == isUseVideoView then
      _ui_loadingMovie = UI.createControl(__ePAUIControl_VideoContent, stc_movieBG, "VideoContent_LoadingMovie")
    else
      _ui_loadingMovie = UI.createControl(__ePAUIControl_WebControl, stc_movieBG, "Static_LoadingMovie")
    end
    _ui_loadingMovie:addInputEvent("Mouse_LUp", "LoadingPanel_SetRandomGuide()")
  end
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX()
  local sizeY = getResolutionSizeY()
  sizeX = sizeX / uiScale
  sizeY = sizeY / uiScale
  local movieSizeX = sizeX
  local movieSizeY = sizeX * 1080 / 1920
  local posX = 0
  local posY = 0
  if sizeY >= movieSizeY then
    posY = (sizeY - movieSizeY) / 2
  else
    movieSizeX = sizeY * 1920 / 1080
    movieSizeY = sizeY
    posX = (sizeX - movieSizeX) / 2
  end
  local marginX = movieSizeX * 0.013
  local marginY = movieSizeY * 0.013
  if false == _ContentsGroup_UseVideoContent then
    _ui_loadingMovie:SetPosX(posX - marginX / 2)
    _ui_loadingMovie:SetPosY(posY - marginY / 2)
    _ui_loadingMovie:SetSize(movieSizeX + marginX, movieSizeY + marginY)
  else
    local tempPosX = (getOriginScreenSizeX() - movieSizeX) * 0.5
    local tempPosY = (getOriginScreenSizeY() - movieSizeY) * 0.5
    _ui_loadingMovie:SetPosX(tempPosX)
    _ui_loadingMovie:SetPosY(tempPosY)
    _ui_loadingMovie:SetSize(movieSizeX, movieSizeY)
  end
  if true == _ContentsGroup_UseVideoContent and true == isUseVideoView then
    local moviePath = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Bink)
    if nil ~= moviePath and true == _ContentsGroup_LoadingScreenMovie then
      _ui_loadingMovie:createVideoView(moviePath, getResolutionSizeX(), getResolutionSizeY(), false, true)
    elseif nil ~= _moviePath then
      _ui_loadingMovie:createVideoView(_moviePath[1], getResolutionSizeX(), getResolutionSizeY(), false, true)
    end
  else
    _ui_loadingMovie:SetUrl(1920, 1080, "coui://UI_Data/UI_Html/LobbyBG_Movie.html")
  end
end
function FromClient_LoadingPanel_OnMovieEvent(param)
  if false == _ContentsGroup_RemasterUI_Lobby then
    return
  end
  if 1 == param then
    if true == _ContentsGroup_UseVideoContent and true == isUseVideoView then
      return
    end
    LoadingPanel_StartFadeIn()
    if true == isGameServiceTypeConsole() and true == _ContentsGroup_LoadingScreenMovie then
      local movieUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Web)
      if nil ~= movieUrl then
        _ui_loadingMovie:TriggerEvent("PlayMovie", movieUrl)
      elseif nil ~= _ui_loadingMovie and nil ~= _movieURL then
        _ui_loadingMovie:TriggerEvent("PlayMovie", _movieURL[_movieOrder[_currentMovieIndex]])
      end
    elseif nil ~= _ui_loadingMovie and nil ~= _movieURL then
      _ui_loadingMovie:TriggerEvent("PlayMovie", _movieURL[_movieOrder[_currentMovieIndex]])
    end
  elseif 2 == param then
    _currentMovieIndex = _currentMovieIndex + 1
    if nil == _movieOrder[_currentMovieIndex] then
      local count = #_movieOrder
      _currentMovieIndex = getRandomValue(1, count)
    end
    if true == isNotPlayLoadingVideo then
      local isBinkOpen = true == _ContentsGroup_UseVideoContent and true == isUseVideoView
      local isMovieActive = false
      if true == isBinkOpen then
        local binkUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Bink)
        isMovieActive = nil ~= binkUrl or nil ~= _moviePath
      else
        local webUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Web)
        isMovieActive = nil ~= webUrl or nil ~= _movieURL
      end
      if false == isMovieActive then
        ToClient_setLoadingSkip()
      end
      stc_movieBG:SetShow(isMovieActive)
    end
    if true == _ContentsGroup_UseVideoContent and true == isUseVideoView then
      local moviePath = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Bink)
      if nil ~= moviePath and true == _ContentsGroup_LoadingScreenMovie then
        _ui_loadingMovie:playVideoView(moviePath, false, true)
      elseif nil ~= _moviePath then
        if true == _isRandom then
          local count = #_movieOrder
          _currentMovieIndex = getRandomValue(1, count)
        end
        if nil == _movieOrder[_currentMovieIndex] then
          _currentMovieIndex = 1
        end
        _ui_loadingMovie:playVideoView(_moviePath[_movieOrder[_currentMovieIndex]], false, true)
      end
    else
      local movieUrl = ToClient_getLoadingMoviePath(__eLoadingMoviePlayerType_Web)
      if nil ~= movieUrl and true == _ContentsGroup_LoadingScreenMovie then
        _ui_loadingMovie:TriggerEvent("PlayMovie", movieUrl)
      elseif nil ~= _movieURL then
        _ui_loadingMovie:TriggerEvent("PlayMovie", _movieURL[_movieOrder[_currentMovieIndex]])
      end
    end
    LoadingPanel_StartFadeIn()
  end
  if nil ~= PaGlobal_FadeOutClose then
    PaGlobal_FadeOutClose()
  end
end
local _fadeTime = 1
function LoadingPanel_StartFadeIn()
  stc_fade:SetShow(false)
end
function LoadingPanel_StartFadeOut()
  stc_fade:SetShow(false)
end
function LoadingPanel_SetProgress(rate)
  progressRate:SetProgressRate(rate)
  local progressRateX = progressRate:GetPosX()
  local progressRateY = progressRate:GetPosY()
  local progressHeadX = progressHead:GetPosX()
  local progressHeadY = progressHead:GetPosY()
  local isHalloween = ToClient_isEventOn("Halloween")
  local addXpos2 = 0
  if isHalloween then
    addXpos2 = 10
  else
    addXpos2 = 0
  end
  goblinRun:SetPosX(progressRateX + progressHeadX + progressHead:GetSizeX() + addXpos2)
  goblinRun:SetPosY(progressRateY + goblinRun:GetSizeY() * 0.5)
end
function LoadingPanel_SetRegionName()
  local cameraPosition = getWorldMapCameraLookAt()
  _regionName:SetText(getRegionNameByPosition(cameraPosition))
end
local function LoadingPanel_PlayKnowledgeAni()
  _bg1:SetShow(true)
  _bg2:SetShow(true)
  local ImageMoveAni = _knowledge_Image:addMoveAnimation(0, 1.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(screenX / 2 - 200, screenY / 2 - 350)
  ImageMoveAni:SetEndPosition(screenX / 2 - 200, screenY / 2 - 400)
  ImageMoveAni.IsChangeChild = true
  _knowledge_Image:CalcUIAniPos(ImageMoveAni)
  local knowTitleMoveAni = _knowledge_title:addMoveAnimation(0, 1.65, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleMoveAni:SetStartPosition(screenX / 2 - _knowLedge_TitleSizeX / 2, screenY / 2 - 50)
  knowTitleMoveAni:SetEndPosition(screenX / 2 - _knowLedge_TitleSizeX / 2, screenY / 2 + 20)
  knowTitleMoveAni.IsChangeChild = true
  _knowledge_title:CalcUIAniPos(knowTitleMoveAni)
  local knowDescMoveAni = _knowledge_desc:addMoveAnimation(0, 1.75, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescMoveAni:SetStartPosition(screenX / 2 - 300, screenY / 2 - 25)
  knowDescMoveAni:SetEndPosition(screenX / 2 - 300, screenY / 2 + 50)
  knowDescMoveAni.IsChangeChild = true
  _knowledge_desc:CalcUIAniPos(knowDescMoveAni)
  local ImageAni = _knowledge_Image:addColorAnimation(0, 0.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageAni:SetStartColor(UI_color.C_00FFFFFF)
  ImageAni:SetEndColor(UI_color.C_00FFFFFF)
  ImageAni.IsChangeChild = true
  local knowTitleAni = _knowledge_title:addColorAnimation(0, 0.35, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleAni:SetStartColor(UI_color.C_00FFFFFF)
  knowTitleAni:SetEndColor(UI_color.C_00FFFFFF)
  knowTitleAni.IsChangeChild = true
  local knowDescAni = _knowledge_desc:addColorAnimation(0, 0.45, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescAni:SetStartColor(UI_color.C_00FFFFFF)
  knowDescAni:SetEndColor(UI_color.C_00FFFFFF)
  knowDescAni.IsChangeChild = true
  local ImageAni = _knowledge_Image:addColorAnimation(0.25, 0.85, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageAni:SetStartColor(UI_color.C_00FFFFFF)
  ImageAni:SetEndColor(UI_color.C_FFFFFFFF)
  ImageAni.IsChangeChild = true
  local knowTitleAni = _knowledge_title:addColorAnimation(0.35, 0.95, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleAni:SetStartColor(UI_color.C_00FFFFFF)
  knowTitleAni:SetEndColor(UI_color.C_FFFFFFFF)
  knowTitleAni.IsChangeChild = true
  local knowDescAni = _knowledge_desc:addColorAnimation(0.45, 1.25, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescAni:SetStartColor(UI_color.C_00FFFFFF)
  knowDescAni:SetEndColor(UI_color.C_FFFFFFFF)
  knowDescAni.IsChangeChild = true
  local ImageAni = _knowledge_Image:addColorAnimation(7, 7.65, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageAni:SetStartColor(UI_color.C_FFFFFFFF)
  ImageAni:SetEndColor(UI_color.C_00FFFFFF)
  ImageAni.IsChangeChild = true
  local knowTitleAni = _knowledge_title:addColorAnimation(7, 7.75, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowTitleAni:SetStartColor(UI_color.C_FFFFFFFF)
  knowTitleAni:SetEndColor(UI_color.C_00FFFFFF)
  knowTitleAni.IsChangeChild = true
  local knowDescAni = _knowledge_desc:addColorAnimation(7, 7.85, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  knowDescAni:SetStartColor(UI_color.C_FFFFFFFF)
  knowDescAni:SetEndColor(UI_color.C_00FFFFFF)
  knowDescAni.IsChangeChild = true
end
local function LoadingPanel_GetRandomKnowledge()
  local mentalCardData = RequestIntimacy_getRandomKnowledge()
  if nil ~= mentalCardData then
    _knowledge_Image:SetShow(true, false)
    _knowledge_title:SetShow(true, false)
    _knowledge_desc:SetShow(true, false)
    local screenX = getScreenSizeX()
    _knowledge_Image:ChangeTextureInfoNameAsync(mentalCardData:getPicture())
    _knowledge_title:SetText(mentalCardData:getName())
    _knowLedge_TitleSizeX = _knowledge_title:GetTextSizeX()
    _knowledge_desc:SetTextMode(__eTextMode_AutoWrap)
    _knowledge_desc:SetText(mentalCardData:getDesc())
    LoadingPanel_PlayKnowledgeAni()
  end
  if true == _ContentsGroup_RenewUI then
  end
end
function LoadingPanel_GetBackGroundImage()
  if isBgOpen and nil ~= bgImageTexture and nil ~= bgImageTexture.count then
    local loadingImageIndex = math.random(0, bgImageTexture.count - 1)
    loadingImageIndex = (loadingImageIndex + 1) % bgImageTexture.count
    backGroundEvnetImage:ChangeTextureInfoNameAsync(bgImageTexture[loadingImageIndex])
    backGroundEvnetImage:getBaseTexture():setUV(0, 0, 1, 1)
    backGroundEvnetImage:setRenderTexture(backGroundEvnetImage:getBaseTexture())
  end
end
local updateTime = 0
local isScope = false
function LoadingPanel_UpdatePerFrame(deltaTime)
  if true == _ContentsGroup_RemasterUI_Lobby then
    luaTimer_UpdatePerFrame(deltaTime)
  end
  _currentTime = _currentTime + deltaTime
  updateTime = updateTime - deltaTime
  if _currentTime > 5 then
    _currentTime = 0
    LoadingPanel_SetRandomGuide()
  end
  if false == isLoadingSkip and (true == isKeyUpFor(CppEnums.VirtualKeyCode.KeyCode_SPACE) or true == isPadUp(__eJoyPadInputType_Y)) then
    ToClient_setLoadingSkip()
    isLoadingSkip = true
  end
end
registerEvent("ToClient_EndGuideMovie", "FromClient_LoadingPanel_OnMovieEvent")
registerEvent("EventMapLoadProgress", "LoadingPanel_SetProgress")
registerEvent("onScreenResize", "LoadingPanel_Resize")
registerEvent("FromClient_LoadingComplete", "FromClient_LoadingPanel_LoadingComplete")
registerEvent("FromClient_CloseLoadingPanel", "FromClient_CloseLoadingPanel")
Panel_Loading:RegisterUpdateFunc("LoadingPanel_UpdatePerFrame")
LoadingPanel_Resize()
LoadingPanel_GetBackGroundImage()
function InitLoadingMoviePanel()
  _PA_LOG("COHERENT", "InitLoadingMoviePanel")
  LoadingPanel_LoadMovie()
end
function RegisterEvent()
  registerEvent("FromClient_luaLoadCompleteLateUdpate", "InitLoadingMoviePanel")
  Panel_Loading:addInputEvent("Mouse_LUp", "LoadingPanel_SetRandomGuide()")
end
local prevGuideNum = 0
local prevControl = txt_randomGuide
function LoadingPanel_SetRandomGuide()
  _currentTime = 0
  local control = txt_randomGuide
  if nil ~= prevControl then
    local prevControlFadeOutAni = prevControl:addColorAnimation(0, 0.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    prevControlFadeOutAni:SetStartColor(UI_color.C_FFFFFFFF)
    prevControlFadeOutAni:SetEndColor(UI_color.C_00FFFFFF)
    prevControlFadeOutAni.IsChangeChild = true
    if txt_randomGuide == prevControl then
      control = txt_randomGuide2
    elseif txt_randomGuide2 == prevControl then
      control = txt_randomGuide
    end
  end
  prevControl = control
  local nextControlFadeInAni = control:addColorAnimation(0, 0.4, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  nextControlFadeInAni:SetStartColor(UI_color.C_00FFFFFF)
  nextControlFadeInAni:SetEndColor(UI_color.C_FFFFFFFF)
  nextControlFadeInAni.IsChangeChild = true
  local randomGuideText = ToClient_GetOperationMention(0)
  control:SetText(randomGuideText)
  control:SetShow(true)
  control:ComputePos()
end
function FromClient_LoadingPanel_LoadingComplete()
  if false == stc_movieBG:GetShow() then
    ToClient_setLoadingSkip()
    return
  end
  txt_loadComplete:ComputePos()
  txt_loadComplete:SetShow(true)
  local loadingSkipText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOADING_SKIPMESSAGE")
  if true == _ContentsGroup_UsePadSnapping and false == _ContentsGroup_RenewUI then
    loadingSkipText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOADING_SKIPMESSAGE_CONSOLE")
  end
  txt_loadComplete:SetText(loadingSkipText)
end
function FromClient_CloseLoadingPanel()
  if nil == Panel_Loading then
    return
  end
  Panel_Loading:SetShow(false)
end
RegisterEvent()
