function PaGlobalFunc_RoseWarScoreBoardWidget_Open()
  local self = PaGlobal_RoseWarScoreBoardWidget
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RoseWarScoreBoardWidget_Close()
  local self = PaGlobal_RoseWarScoreBoardWidget
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLDown_RoseWarScoreBoardWidget_ToggleScoreBoard()
  local self = PaGlobal_RoseWarScoreBoardWidget
  if self == nil then
    return
  end
  self._tempPanelPosX = Panel_RoseWar_ScoreBoardWidget:GetPosX()
  self._tempPanelPosY = Panel_RoseWar_ScoreBoardWidget:GetPosY()
end
function HandleEventLUp_RoseWarScoreBoardWidget_ToggleScoreBoard()
  local self = PaGlobal_RoseWarScoreBoardWidget
  if self == nil then
    return
  end
  if self._tempPanelPosX ~= nil and self._tempPanelPosY ~= nil and (self._tempPanelPosX ~= Panel_RoseWar_ScoreBoardWidget:GetPosX() or self._tempPanelPosY ~= Panel_RoseWar_ScoreBoardWidget:GetPosY()) then
    return
  else
    self._tempPanelPosX = nil
    self._tempPanelPosY = nil
  end
  if PaGlobalFunc_RoseWarScoreBoard_IsShow() == true then
    PaGlobalFunc_RoseWarScoreBoard_Close()
  else
    PaGlobalFunc_RoseWarScoreBoard_Open()
  end
end
function FromClient_RoseWarScoreBoardWidget_UpdateScore(scoreType, scoreValue)
  local self = PaGlobal_RoseWarScoreBoardWidget
  if self == nil then
    return
  end
  if Panel_RoseWar_ScoreBoardWidget:GetShow() == false then
    PaGlobalFunc_RoseWarScoreBoardWidget_Open()
    return
  end
  if scoreType == __eRoseWarPersonalRecordType_Kill then
    self:updateKill(scoreValue)
  elseif scoreType == __eRoseWarPersonalRecordType_Death then
    self:updateDeath(scoreValue)
  else
    UI.ASSERT_NAME(false, "scoreType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\235\130\152\236\154\148?", "\236\157\180\236\163\188")
    return
  end
end
function FromClient_RoseWarScoreBoardWidget_OnScreenResize()
  local self = PaGlobal_RoseWarScoreBoardWidget
  if self == nil then
    return
  end
  self:onScreenResize()
end
