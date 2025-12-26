function PaGlobal_HardCoreQuest_ShowAni()
  if PaGlobal_HardCoreQuest == nil then
    return
  end
end
function PaGlobal_HardCoreQuest_HideAni()
  if PaGlobal_HardCoreQuest == nil then
    return
  end
end
function PaGlobal_HardCoreQuest_Open()
  if PaGlobal_HardCoreQuest == nil then
    return
  end
  PaGlobal_HardCoreQuest:prepareOpen()
end
function PaGlobal_HardCoreQuest_Close()
  if PaGlobal_HardCoreQuest == nil then
    return
  end
  PaGlobal_HardCoreQuest:prepareClose()
end
function PaGlobal_HardCoreQuest_Toggle()
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  local isShow = Panel_Widget_Quest_HardCore:GetShow()
  if isShow == true then
    PaGlobal_HardCoreQuest:prepareClose()
  else
    PaGlobal_HardCoreQuest:prepareOpen()
  end
end
function PaGlobal_HardCoreQuest_HardCoreSurvivalPoint()
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:updateRankPoint(true)
end
function PaGlobal_HardCoreQuest_UpdateQuestInfo()
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:updateQuest(index)
end
function PaGlobal_HardCoreQuest_QuestInfo(index)
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:openQuestInfo(index)
end
function PaGlobal_HardCoreQuest_QuestNavi(index)
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:findQuestNavi(index)
end
function PaGlobal_HardCoreQuest_UpdateHardCoreMyRank()
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:updateMyRank()
end
function PaGlobal_HardCoreQuest_UpdateHardCoreHighRankerList()
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:updateHighRankerList()
end
function PaGlobal_HardCoreQuest_UpdateWidgetPosition()
  local self = PaGlobal_HardCoreQuest
  if self == nil then
    return
  end
  self:updateWidgetPosition()
end
