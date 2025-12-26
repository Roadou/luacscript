function PaGlobalFunc_MorningLand_QuestBoard_All_ShowAni()
  Panel_MorningLand_QuestBoard_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_MorningLand_QuestBoard_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_MorningLand_QuestBoard_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_MorningLand_QuestBoard_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_MorningLand_QuestBoard_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_MorningLand_QuestBoard_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_MorningLand_QuestBoard_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobalFunc_MorningLand_QuestBoard_All_HideAni()
  Panel_MorningLand_QuestBoard_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_MorningLand_QuestBoard_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
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
function PaGlobal_MorningLand_QuestBoard_All_UpdateQuestTab(addValue)
  if Panel_MorningLand_QuestBoard_All == nil then
    return
  end
  PaGlobal_MorningLand_QuestBoard_All:updateQuestTab(addValue)
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
  for index = 1, PaGlobal_MorningLand_QuestBoard_All._hiddenQuestCount do
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
  elseif sIndex == 2 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestHidden[index - PaGlobal_MorningLand_QuestBoard_All._hiddenQuestAddIndex]
  elseif sIndex == 3 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestNormal2[index]
  elseif sIndex == 4 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestHidden2[index]
  end
  return Panel_MorningLand_QuestBoard_All:GetPosX() + info.bg:GetPosX()
end
function PaGlobal_MorningLand_QuestBoard_All_GetBgPosY(sIndex, index)
  local info
  if sIndex == 1 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestNormal[index]
  elseif sIndex == 2 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestHidden[index - PaGlobal_MorningLand_QuestBoard_All._hiddenQuestAddIndex]
  elseif sIndex == 3 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestNormal2[index]
  elseif sIndex == 4 then
    info = PaGlobal_MorningLand_QuestBoard_All._ui.btn_QuestHidden2[index]
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
function PaGlobal_MorningLand_QuestBoard_All_TabClick(index)
  PaGlobal_MorningLand_QuestBoard_All:radioBtnClick(index)
end
