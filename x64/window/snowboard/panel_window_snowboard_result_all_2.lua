function PaGlobalFunc_SnowBoardFieldResult_Open(courseKeyRaw, isRaceComplete, isBestRecord, raceRecordTick, racePenaltyTick, isUploadingGhostReplay)
  local self = PaGlobal_SnowBoardFieldResult
  if self == nil then
    return
  end
  self:prepareOpen(courseKeyRaw, isRaceComplete, isBestRecord, raceRecordTick, racePenaltyTick, isUploadingGhostReplay)
end
function PaGlobalFunc_SnowBoardFieldResult_Close()
  local self = PaGlobal_SnowBoardFieldResult
  if self == nil then
    return
  end
  self:prepareClose(false)
end
function FromClient_SnowBoardFieldResult_ChangeUploadState(isUploadingGhostReplay)
  local self = PaGlobal_SnowBoardFieldResult
  if self == nil then
    return
  end
  self:updateExitText(isUploadingGhostReplay)
end
function PaGlobalFunc_SnowBoardFieldResult_CloseLeave()
  local self = PaGlobal_SnowBoardFieldResult
  if self == nil then
    return
  end
  self:prepareClose(true)
end
