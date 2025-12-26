function PaGlobal_RoseWarScoreBoardWidget:initialize()
  if self._initialize == true then
    return
  end
  self._ui._txt_kill = UI.getChildControl(Panel_RoseWar_ScoreBoardWidget, "StaticText_Kill")
  self._ui._txt_death = UI.getChildControl(Panel_RoseWar_ScoreBoardWidget, "StaticText_Death")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarScoreBoardWidget:registEventHandler()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  Panel_RoseWar_ScoreBoardWidget:addInputEvent("Mouse_LDown", "HandleEventLDown_RoseWarScoreBoardWidget_ToggleScoreBoard()")
  Panel_RoseWar_ScoreBoardWidget:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoardWidget_ToggleScoreBoard()")
  registerEvent("FromClient_UpdateRoseWarPersonalScoreBoard", "FromClient_RoseWarScoreBoardWidget_UpdateScore")
  registerEvent("onScreenResize", "FromClient_RoseWarScoreBoardWidget_OnScreenResize")
end
function PaGlobal_RoseWarScoreBoardWidget:validate()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  self._ui._txt_kill:isValidate()
  self._ui._txt_death:isValidate()
end
function PaGlobal_RoseWarScoreBoardWidget:onScreenResize()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  if Panel_Radar ~= nil then
    local radarPosY = Panel_Radar:GetPosY()
    local radarSizeY = Panel_Radar:GetSizeY()
    Panel_RoseWar_ScoreBoardWidget:SetPosX(getScreenSizeX() - Panel_RoseWar_ScoreBoardWidget:GetSizeX() - 10)
    Panel_RoseWar_ScoreBoardWidget:SetPosY(radarPosY + radarSizeY + 10)
  end
  self._tempPanelPosX = nil
  self._tempPanelPosY = nil
end
function PaGlobal_RoseWarScoreBoardWidget:prepareOpen()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  self:initialize()
  self:updateKill(0)
  self:updateDeath(0)
  self:updateScoreFromClient()
  self:onScreenResize()
  self:open()
end
function PaGlobal_RoseWarScoreBoardWidget:open()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  Panel_RoseWar_ScoreBoardWidget:SetShow(true)
end
function PaGlobal_RoseWarScoreBoardWidget:prepareClose()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWarScoreBoardWidget:close()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  Panel_RoseWar_ScoreBoardWidget:SetShow(false)
end
function PaGlobal_RoseWarScoreBoardWidget:updateScoreFromClient()
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  local roseWarSelfMemberData = ToClient_GetRoseWarMemberDataWrapperBySelfPlayer()
  if roseWarSelfMemberData == nil then
    return
  end
  self:updateKill(roseWarSelfMemberData:getRoseWarPersonalScore(__eRoseWarPersonalRecordType_Kill))
  self:updateDeath(roseWarSelfMemberData:getRoseWarPersonalScore(__eRoseWarPersonalRecordType_Death))
end
function PaGlobal_RoseWarScoreBoardWidget:updateKill(kill)
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  self._ui._txt_kill:SetText(tostring(kill))
end
function PaGlobal_RoseWarScoreBoardWidget:updateDeath(death)
  if Panel_RoseWar_ScoreBoardWidget == nil then
    return
  end
  self._ui._txt_death:SetText(tostring(death))
end
