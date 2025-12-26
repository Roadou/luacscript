PaGlobal_Achievement_MorningLand = {
  _ui = {
    _stc_mainBG = nil,
    _stc_title = nil,
    _stc_leftFrame = nil,
    _stc_leftFrameContent = nil,
    _stc_leftFrameDesc = nil,
    _stc_emptyPageDesc = nil,
    _stc_image = nil,
    _btn_pageLeft = nil,
    _btn_pageRight = nil,
    _btn_left = nil,
    _btn_right = nil,
    _btn_close = nil,
    _btn_bookMark = nil,
    _stc_addEffect = nil,
    _stc_artworkArea = nil,
    _stc_artworkImage = nil,
    _btn_artworkPageLeft = nil,
    _btn_artworkPageRight = nil,
    _btn_artworkLeft = nil,
    _btn_artworkRight = nil,
    _btn_artworkPlay = nil,
    _btn_artworkClose = nil,
    _btn_artworkFullScreen = nil,
    _stc_artworkFullScreen = nil,
    _stc_artwork2KImage = nil,
    _stc_emptyPageRight = nil
  },
  _originalTitleTextSpanY = 0,
  _autowrapTitleTextSpanY = 0,
  _pageAnimationDeltaTime = 0,
  _pageAnimationSpeed = 2400,
  _pageAnimationNextPageXSize = 0,
  _dataList = nil,
  _currentJournalKey = nil,
  _currentChapterKey = nil,
  _currentPageIndex = nil,
  _currentPageCount = nil,
  _isConsole = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_MorningLand_1.lua")
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_MorningLand_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_AchievementMorningLandInit")
function FromClient_AchievementMorningLandInit()
  PaGlobal_Achievement_MorningLand:initialize()
end
