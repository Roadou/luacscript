PaGlobal_SnowBoardMain = {
  _renderMode = nil,
  _prevUIMode = nil,
  _isSet = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_SnowBoardInit")
registerEvent("FromClient_SnowBoardRaceReady", "FromClient_SnowBoardMain_PrepareRace")
registerEvent("FromClient_SnowBoardRaceStart", "FromClient_SnowBoardMain_StartRace")
registerEvent("FromClient_SnowBoardRaceComplete", "FromClient_SnowBoardMain_EndRace")
registerEvent("FromClient_SnowBoardFailCheckPoint", "FromClient_SnowBoardFailCheckPoint")
registerEvent("FromClient_SnowBoardSuccessCheckPoint", "FromClient_SnowBoardSuccessCheckPoint")
registerEvent("FromClient_AcquireSnowBoardCoin", "FromClient_AcquireSnowBoardCoin")
registerEvent("FromClient_ChangeSnowBoardReplayUploadState", "FromClient_SnowBoardMain_ChangeUploadState")
registerEvent("FromClient_LeaveSnowBoardField", "FromClient_SnowBoardMain_LeaveSnowBoardField")
function PaGlobal_SnowBoardMain:set()
  self._renderMode:set()
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_SnowBoardInMirrorField)
  self._isSet = true
end
function PaGlobal_SnowBoardMain:unset()
  self._renderMode:reset()
  if self._prevUIMode ~= Defines.UIMode.eUIMode_SnowBoardInMirrorField then
    SetUIMode(self._prevUIMode)
  end
  self._isSet = false
end
function FromClient_SnowBoardInit()
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  self._renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_SnowBoardInMirrorField
  }, false)
  self._renderMode:setClosefunctor(renderMode, FromClient_SnowBoardMain_EndRace)
  self._prevUIMode = Defines.UIMode.eUIMode_Default
end
function FromClient_SnowBoardMain_PrepareRace(courseKeyRaw)
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  self:set()
end
function FromClient_SnowBoardMain_StartRace()
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
end
function FromClient_SnowBoardMain_EndRace(courseKeyRaw, isRaceComplete, raceRecordTick, racePenaltyTick, isUploadingGhostReplay)
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  if isUploadingGhostReplay ~= nil and isUploadingGhostReplay == true then
    return
  end
end
function PaGlobalFunc_SnowBoardMain_StopWithMessageBox()
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  if Panel_Window_SnowBoard_Result_All:GetShow() then
    return
  end
  PaGlobal_MessageBox_SnowBoard_Open()
end
function FromClient_SnowBoardFailCheckPoint()
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  audioPostEvent_SystemUi(11, 177)
end
function FromClient_SnowBoardSuccessCheckPoint(checkPointIndex)
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  local totalCheckPointCount = ToClient_SnowBoardCourseCheckPointCount()
  if totalCheckPointCount ~= 0 and checkPointIndex == totalCheckPointCount - 1 then
    return
  end
  audioPostEvent_SystemUi(11, 175)
end
function FromClient_AcquireSnowBoardCoin()
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  audioPostEvent_SystemUi(5, 89)
end
function FromClient_SnowBoardMain_ChangeUploadState(isUploading)
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  if isUploading ~= true or self._isSet == true then
  else
    self:set()
    UI.ASSERT_NAME(false, "\236\151\133\235\161\156\235\147\156 \236\164\145\236\157\184\235\141\176 \236\157\180\235\175\184 renderMode\234\176\128 \237\146\128\235\160\164\236\158\136\235\139\164? \235\161\156\236\167\129 \236\152\164\235\165\152. \235\176\156\236\131\157\236\139\156 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
end
function FromClient_SnowBoardMain_LeaveSnowBoardField()
  local self = PaGlobal_SnowBoardMain
  if self == nil then
    return
  end
  self:unset()
  if PaGlobalFunc_ItemLog_ClearReadyToShowData ~= nil then
    PaGlobalFunc_ItemLog_ClearReadyToShowData()
  end
end
