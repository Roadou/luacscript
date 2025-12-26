PaGlobal_Achievement_BookShelf_All = {
  _ui = {
    stc_TopArea = nil,
    stc_CenterArea = nil,
    stc_LeftArea = nil,
    stc_RightArea = nil,
    stc_FamilyWidget = nil,
    stc_BtnClose = nil,
    stc_Chapter = nil,
    stc_ChapterGroup = {},
    stc_ChapterSlot = nil,
    stc_ChapterTitle = nil,
    txt_FamilyStatIcon = nil,
    txt_LeftTitle = nil,
    txt_BookShelfDesc = nil,
    frame_BookShelf = nil,
    frame_BookShelfContent = nil,
    btn_BookArea = nil,
    btn_BookTitle = nil,
    btn_BookGroup = nil,
    stc_EmptyGroup_1 = nil,
    stc_EmptyGroup_1_object = nil,
    stc_EmptyGroup_2 = nil,
    stc_EmptyGroup_2_object = nil,
    stc_EmptyGroup_3 = nil,
    stc_EmptyGroup_3_object_1 = nil,
    stc_EmptyGroup_3_object_2 = nil,
    stc_EmptyGroup_4 = nil,
    stc_EmptyGroup_4_object_1 = nil,
    stc_EmptyGroup_4_object_2 = nil,
    btn_BookArea_bookImage = nil,
    list2_BookChapterList = nil,
    stc_KeyGuide = nil,
    btn_Shortcut = nil
  },
  _journalChapterCnt = 0,
  _journalGroupCnt = 0,
  _selectedJournalGroup = 1,
  _selectedJournalChapter = -1,
  _journalControlList = {},
  _chapterControlList = {},
  _initialize = false,
  _journalGroupIndexList = {},
  _targetControlList = {},
  _selectedButton = nil,
  _targetControlCount = 0,
  _CHAPTER_ICON_ROW_CNT = 4,
  _CHAPTER_ICON_CNT = 5,
  _BOOK_AREA_CNT = 4,
  _BOOK_POS_X = 15,
  _MAX_CALLING_COUNT = 20,
  _BOOK_POS_Y = {
    [0] = 32,
    [1] = 175,
    [2] = 316,
    [3] = 456
  },
  _bookShelfTextureGroup = {
    [1] = {
      texture = "combine/etc/combine_etc_adventure_03.dds",
      x1 = 0,
      y1 = 0,
      x2 = 268,
      y2 = 598,
      panelSize = 790,
      frameSize = 268,
      contentSize = 208
    },
    [2] = {
      texture = "combine/etc/combine_etc_adventure_03.dds",
      x1 = 269,
      y1 = 0,
      x2 = 761,
      y2 = 598,
      panelSize = 1014,
      frameSize = 492,
      contentSize = 434
    },
    [3] = {
      texture = "combine/etc/combine_etc_adventure_04.dds",
      x1 = 0,
      y1 = 0,
      x2 = 719,
      y2 = 598,
      panelSize = 1241,
      frameSize = 719,
      contentSize = 660
    }
  },
  _hideIndex = {10},
  _initialize = false
}
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_BookShelf_All_1.lua")
runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_BookShelf_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_Achievement_BookShelf_All_Init")
function FromClient_Achievement_BookShelf_All_Init()
  PaGlobal_Achievement_BookShelf_All:initialize()
end
