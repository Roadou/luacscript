function PaGlobalFunc_Achievement_BookShelf_All_Open()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionHardCoreServer"))
    return
  end
  PaGlobal_Achievement_BookShelf_All:prepareOpen()
end
function PaGlobalFunc_Achievement_BookShelf_All_Close()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:prepareClose()
end
function PaGlobalFunc_Achievement_BookShelf_All_ShowToggle()
  if nil == Panel_Window_Achievement_BookShelf_All or false == _ContentsGroup_AchievementQuest then
    return
  end
  if Panel_Window_Achievement_BookShelf_All:GetShow() then
    PaGlobal_Achievement_BookShelf_All:prepareClose()
  else
    PaGlobal_Achievement_BookShelf_All:prepareOpen()
  end
end
function PaGlobalFunc_Achievement_BookShelf_All_ShowToggleFamilyWidget()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:showToggleFamilyWidget()
end
function PaGlobalFunc_Achievement_BookShelf_All_LeftClick()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:moveLeftTarget()
end
function HandleEventLUp_Achievement_BookShelf_All_SelectJournal(index)
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:selectJournal(index)
end
function HandleEventLUp_Achievement_BookShelf_All_SelectChapter(index)
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  PaGlobal_Achievement_BookShelf_All:selectChapter(index)
end
function PaGlobalFunc_Achievement_BookShelf_All_GetBookInfoForBookmark()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  return PaGlobal_Achievement_BookShelf_All._selectedJournalGroup, PaGlobal_Achievement_BookShelf_All._selectedJournalChapter
end
function FromClient_Achievement_BookShelf_All_UpdateQuestList()
  if nil == Panel_Window_Achievement_BookShelf_All then
    return
  end
  if Panel_Window_Achievement_BookShelf_All:GetShow() == false then
    return
  end
  PaGlobal_Achievement_BookShelf_All:update()
end
function PaGlobal_Achievement_BookShelf_All_UpdateSetDirectJournalChapter(questGroup, questNo)
  PaGlobal_Achievement_BookShelf_All:updateSetDirectJournalChapter(questGroup, questNo)
end
function HandleEventOn_Achievement_BookShelf_All_ShowSubTitleTooltip(isShow, index, journalKey, chapterKey)
  local self = PaGlobal_Achievement_BookShelf_All
  if self == nil then
    return
  end
  if isShow == true then
    local subDescString = ToClient_GetJournalSubDesc(journalKey, chapterKey)
    if subDescString == nil then
      return
    end
    local control = self._chapterControlList[index].slot
    local name = ""
    local desc = subDescString
    if control ~= nil then
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
