function PaGlobal_MorningLand_QuestBoard_All_Open()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  PaGlobal_MorningLand_QuestBoard_All:prepareOpen()
end
function PaGlobal_MorningLand_QuestBoard_All_Close()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  PaGlobal_MorningLand_QuestBoard_All:prepareClose()
end
function PaGlobal_MorningLand_QuestBoard_All_UpdateQuestTab()
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  PaGlobal_MorningLand_QuestBoard_All:updateQuestTab()
end
function PaGlobal_MorningLand_QuestBoard_All_UpdateQuestPadTab(isLeft)
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  PaGlobal_MorningLand_QuestBoard_All:updateQuestPadTab(isLeft)
end
function PaGlobal_MorningLand_QuestBoard_All_ShowNameToggle(isOn, index)
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  if isOn == nil or index == nil then
    return
  end
  PaGlobal_MorningLand_QuestBoard_All:showNameToggle(isOn, index)
end
function PaGlobal_MorningLand_QuestBoard_All_ExecuteLuaFunc(funcText)
  if getSelfPlayer() == nil then
    return
  end
  if funcText == "MorningLandStart" then
    PaGlobal_MorningLand_QuestBoard_All_Open()
    PaGlobal_MorningLand_QuestBoardAlert_All_Open()
  end
end
function PaGlobal_MorningLand_QuestBoard_All_CheckStamp(isAccept, questNoRaw)
  if isAccept == nil or questNoRaw == nil then
    return
  end
  local questInfoWrapper = questList_getQuestInfo(questNoRaw)
  if nil == questInfoWrapper then
    return
  end
  if isAccept == true then
    return
  end
  local questNo = questInfoWrapper:getQuestNo()
  for index = 1, PaGlobal_MorningLand_QuestBoard_All._normalQuestCount do
    local groupId = PaGlobal_MorningLand_QuestBoard_All._normalPercentInfo[index]._groupId
    if groupId == questNo._group then
      PaGlobal_MorningLand_QuestBoard_All._stampQuest = questNo._group
      break
    end
  end
  for index = 1, PaGlobal_MorningLand_QuestBoard_All._hoddenQuestCount do
    local groupId = PaGlobal_MorningLand_QuestBoard_All._hiddenPercentInfo[index]._groupId
    if groupId == questNo._group then
      PaGlobal_MorningLand_QuestBoard_All._stampQuest = questNo._group
      break
    end
  end
end
function PaGlobal_MorningLand_QuestBoard_All_GetBgPosX(sIndex, index)
  local info
  if sIndex == 1 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestNormal[index]
  else
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestHidden[index]
  end
  return Panel_MorningLand_QuestBoard_All:GetPosX() + info.bg:GetPosX()
end
function PaGlobal_MorningLand_QuestBoard_All_GetBgPosY(sIndex, index)
  local info
  if sIndex == 1 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestNormal[index]
  else
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestHidden[index]
  end
  return Panel_MorningLand_QuestBoard_All:GetPosY() + info.bg:GetPosY()
end
function PaGlobal_MorningLand_QuestBoard_All_OpenBookShelfQuest(index, questGroup, questNo)
  if index == nil or questGroup == nil or questNo == nil then
    return
  end
  local progressPercent = PaGlobal_MorningLand_QuestBoard_All:getProgressPercent(index)
  local isComplete = false
  if progressPercent >= 100 then
    isComplete = true
  end
  if isComplete == false then
    return
  end
  PaGlobalFunc_Achievement_OpenBookShelfQuest(questGroup, questNo)
end
function PaGlobal_MorningLand_QuestBoard_All_IsMorningQuestBordQuest(questGroupID)
  return PaGlobal_MorningLand_QuestBoard_All:isMorningQuestBordQuest(questGroupID)
end
