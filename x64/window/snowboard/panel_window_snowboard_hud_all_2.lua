function PaGlobalFunc_SnowBoardHud_Open(courseKeyRaw)
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  self:prepareOpen(courseKeyRaw)
end
function PaGlobalFunc_SnowBoardHud_Close()
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_SnowBoardHud_Update(deltaTime)
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function PaGlobalFunc_SnowBoardHud_ActionButton()
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  local actionButton = ToClient_CanStartSnowBoardAction()
  self._ui.btn_rideSnowBoard:SetShow(actionButton)
end
function FromClient_SnowBoardHud_PrepareRace(courseKeyRaw)
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  PaGlobalFunc_SnowBoardFieldResult_CloseLeave()
  PaGlobalFunc_SnowBoardHud_Open(courseKeyRaw)
end
function FromClient_SnowBoardHud_StartRace()
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  self:startTimer()
end
function FromClient_SnowBoardHud_EndRace(courseKeyRaw, isRaceComplete, raceRecordTick, racePenaltyTick)
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  PaGlobalFunc_SnowBoardHud_Close()
end
function FromClient_SnowBoardHud_AcquireCoin(totalCoinCount)
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  self:setCoinCount(totalCoinCount)
end
function PaGlobalFunc_SnowBoardHud_SuccessCheckPoint()
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  self:updateCheckText()
  self:updateCheckPointBar()
end
function PaGlobalFunc_SnowBoardHud_RideSnowBoard()
  local self = PaGlobal_SnowBoardHud
  if self == nil then
    return
  end
  local actionButton = ToClient_CanStartSnowBoardAction()
  if actionButton == false then
    return
  end
  ToClient_StartSnowBoardAction()
end
