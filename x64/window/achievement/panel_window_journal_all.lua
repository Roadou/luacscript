PaGlobal_Journal_All = {
  _ui = {
    _txt_title = nil,
    _btn_close = nil,
    _stc_TabArea = nil,
    _rdo_tab_templete = nil,
    _frame_content = nil,
    _stc_questNormal_templete = nil,
    _stc_questHidden_templete = nil,
    _stc_pageArea = nil,
    _rdo_page_templete = nil,
    _btn_scrollL = nil,
    _btn_scrollR = nil,
    _stc_keyguide = nil,
    _txt_keyguideA = nil,
    _txt_keyguideB = nil,
    _stc_keyguideLB = nil,
    _stc_keyguideRB = nil
  },
  _chapterInfo = {},
  _pageInfo = {},
  _journalListType = {_morningLand = 0, _edania = 1},
  _uiTypeMaxJournalCount = {
    [0] = 8,
    [1] = 5
  },
  _currentJournalListIndex = nil,
  _currentChapter = nil,
  _currentPage = nil,
  _lastShowPage = nil,
  _stampQuestGroupNo = nil,
  _showChapterButton = false,
  _normalTempleteDetailBtnSizeX = 0,
  _isPageChanging = false,
  _speed = 2500,
  _isPadSnapping = false,
  _initialize = false
}
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_All_1.lua")
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_Journal_All_luaLoadeComplete")
function FromClient_PaGlobal_Journal_All_luaLoadeComplete()
  PaGlobal_Journal_All:initialize()
end
