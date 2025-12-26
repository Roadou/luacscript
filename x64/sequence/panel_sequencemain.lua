local _Multiline_GamePlayConditionDesc, _StaticText_CantAttackAlertMessage
local _NoSequenceUI = false
local _renderMode, _renderModeSequencePlayerControl, _loadingBlackBG, _loadingCircle, _prevSequenceControlUIMode, _killCountTextDesc, _MinimumKillCount, _posRatioX, _posRatioY, _alignType
local _originControlSizeX = 1280
local _originControlSizeY = 100
registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceMain")
function FromClient_InitSequenceMain()
  Panel_SequenceMain:SetPosX(0)
  Panel_SequenceMain:SetPosY(0)
  Panel_SequenceMain:SetShow(false)
  Panel_SequenceMain:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_SequenceMain:SetIgnore(true)
  _Multiline_GamePlayConditionDesc = UI.getChildControl(Panel_SequenceMain, "MultilineText_GamePlayConditionDesc")
  _StaticText_CantAttackAlertMessage = UI.getChildControl(Panel_SequenceMain, "StaticText_DoNotSequencePlay")
  _KillCountText = UI.getChildControl(Panel_SequenceMain, "StaticText_KillCount")
  _loadingBlackBG = UI.getChildControl(Panel_SequenceMain, "Static_BlackBG")
  _loadingCircle = UI.getChildControl(Panel_SequenceMain, "Static_LoadingCircle")
  _loadingBlackBG:SetSize(getScreenSizeX(), getScreenSizeY())
  _loadingCircle:ComputePos()
  _renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_Sequence
  }, false)
  _renderMode:setClosefunctor(renderMode, FromClient_StopSequence)
  _renderModeSequencePlayerControl = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_SequencePlayerControl
  }, false)
  _renderMode:setClosefunctor(renderMode, FromClient_SequencePlayerControl_Close)
  _prevSequenceControlUIMode = Defines.UIMode.eUIMode_Default
  ToClient_setSequenceState(false)
  registerEvent("FromClient_PlaySequence", "FromClient_PlaySequence")
  registerEvent("FromClient_PlaySequence_Ocean", "FromClient_PlaySequence_Ocean")
  registerEvent("FromClient_StopSequence", "FromClient_StopSequence")
  registerEvent("FromClient_StopSequence_Ocean", "FromClient_StopSequence_Ocean")
  registerEvent("FromClient_PauseResumeSequence", "FromClient_PauseResumeSequence")
  registerEvent("FromClient_CloseSequenceEditorUI_Ocean", "FromClient_CloseSequenceEditorUI_Ocean")
  registerEvent("FromClient_ShowSequenceGamePlayConditionDesc", "FromClient_ShowSequenceGamePlayConditionDesc")
  registerEvent("FromClient_LeavePossessPostUpdateSequence", "FromClient_LeavePossessPostUpdateSequence")
  registerEvent("onScreenResize", "FromClient_ResizeScreenSequence")
  registerEvent("FromClient_NoSequenceUIMode", "FromClient_NoSequenceUIMode")
  registerEvent("FromClient_StartSequencePlayerControlable", "FromClient_SequencePlayerControl_Open")
  registerEvent("FromClient_EndSequencePlayerControlable", "FromClient_SequencePlayerControl_Close")
  registerEvent("FromClient_SequenceCantAttackAlertMessage", "FromClient_SequenceCantAttackAlertMessage")
  registerEvent("FromClient_SetShowSequenceLoadingPanel", "FromClient_SetShowSequenceLoadingPanel")
  registerEvent("FromClient_SequenceStartkillCount", "FromClient_SequenceStartkillCount")
  registerEvent("FromClient_SequencecClearKillCount", "FromClient_SequencecClearKillCount")
  registerEvent("FromClient_SequenceUpdatekillCount", "FromClient_SequenceUpdatekillCount")
end
function FromClient_SequencePlayerControl_Open()
  if ToClient_isConsole() == true then
    if PaGlobalFunc_TooltipInfo_Close ~= nil then
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif Panel_Tooltip_Item_hideTooltip ~= nil then
    Panel_Tooltip_Item_hideTooltip()
  end
  if TooltipSimple_Hide ~= nil then
    TooltipSimple_Hide()
  end
  _prevSequenceControlUIMode = GetUIMode()
  _renderModeSequencePlayerControl:set()
  SetUIMode(Defines.UIMode.eUIMode_SequencePlayerControl)
end
function FromClient_SequencePlayerControl_Close()
  _renderModeSequencePlayerControl:reset()
  if _prevSequenceControlUIMode ~= Defines.UIMode.eUIMode_SequencePlayerControl then
    SetUIMode(_prevSequenceControlUIMode)
  end
  if InventoryWindow_Close ~= nil then
    InventoryWindow_Close()
  end
end
function FromClient_NoSequenceUIMode(isOn)
  _NoSequenceUI = isOn
end
function FromClient_PlaySequence()
  if Panel_SequenceMain == nil then
    return
  end
  ToClient_setSequenceState(true)
  Panel_SequenceMain:SetShow(true)
  Panel_SequenceMain:SetSize(getScreenSizeX(), getScreenSizeY())
  _Multiline_GamePlayConditionDesc:SetText("")
  _Multiline_GamePlayConditionDesc:ComputePos()
  _KillCountText:SetText("")
  _KillCountText:ComputePos()
  _KillCountText:SetShow(false)
  _StaticText_CantAttackAlertMessage:SetShow(ToClient_IsAnySiegeBeingOfMyChannel())
  _StaticText_CantAttackAlertMessage:ComputePos()
  _loadingBlackBG:SetSize(getScreenSizeX(), getScreenSizeY())
  _loadingCircle:ComputePos()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_CUTSCENE")
  if _NoSequenceUI == false then
    _renderMode:set()
    SetUIMode(Defines.UIMode.eUIMode_Sequence)
  end
  FromClient_ToggleMorningBossPartyAttribute(true)
end
function FromClient_PlaySequence_Ocean()
  if Panel_SequenceMain == nil then
    return
  end
  ToClient_setSequenceState(true)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_CUTSCENE")
  Panel_SequenceMain:SetShow(true)
  Panel_SequenceMain:SetSize(getScreenSizeX(), getScreenSizeY())
  _Multiline_GamePlayConditionDesc:SetText("")
  _Multiline_GamePlayConditionDesc:ComputePos()
  _KillCountText:SetText("")
  _KillCountText:ComputePos()
  _KillCountText:SetShow(false)
  _StaticText_CantAttackAlertMessage:SetShow(false)
  _StaticText_CantAttackAlertMessage:ComputePos()
  _loadingBlackBG:SetSize(getScreenSizeX(), getScreenSizeY())
  _loadingCircle:ComputePos()
end
function FromClient_StopSequence()
  if Panel_SequenceMain == nil then
    return
  end
  ToClient_setSequenceState(false)
  Panel_SequenceMain:SetShow(false)
  _Multiline_GamePlayConditionDesc:SetShow(false)
  _StaticText_CantAttackAlertMessage:SetShow(false)
  _KillCountText:SetShow(false)
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_CUTSCENE")
  _renderMode:reset()
  local curUIMode = GetUIMode()
  if curUIMode ~= Defines.UIMode.eUIMode_EnterAbyssOne then
    SetUIMode(Defines.UIMode.eUIMode_Default)
  end
  if Panel_Widget_Party_All ~= nil and FromClient_ToggleMorningBossPartyAttribute ~= nil then
    FromClient_ToggleMorningBossPartyAttribute(false)
  end
end
function FromClient_StopSequence_Ocean()
  if Panel_SequenceMain == nil then
    return
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_CUTSCENE")
  ToClient_setSequenceState(false)
  Panel_SequenceMain:SetShow(false)
  _Multiline_GamePlayConditionDesc:SetShow(false)
  _StaticText_CantAttackAlertMessage:SetShow(false)
  _KillCountText:SetShow(false)
end
function FromClient_PauseResumeSequence(isOn)
  if Panel_SequenceMain == nil then
    return
  end
  ToClient_setSequenceState(false)
  if isOn == true then
    Panel_SequenceMain:SetShow(true)
  else
    Panel_SequenceMain:SetShow(false)
  end
end
function FromClient_LeavePossessPostUpdateSequence()
  SetUIMode(Defines.UIMode.eUIMode_Sequence)
  hideRecentTargetInfo()
end
function FromClient_ShowSequenceGamePlayConditionDesc(isOn, descStrintKey)
  if Panel_SequenceMain == nil or isOn == nil or descStrintKey == nil then
    return
  end
  if isOn == true then
    local screenX = getScreenSizeX()
    local screenY = getScreenSizeY()
    local centerRatio = 0.5
    local descriptionString = PAGetString(Defines.StringSheet_CUTSCENE, descStrintKey)
    if descriptionString == nil or descriptionString == "" then
      _Multiline_GamePlayConditionDesc:SetText("")
      _Multiline_GamePlayConditionDesc:SetShow(false)
      return
    end
    _Multiline_GamePlayConditionDesc:SetText(descriptionString)
    local textSizeX = _Multiline_GamePlayConditionDesc:GetSizeX()
    local textCenter = screenX * centerRatio - textSizeX * centerRatio
    _Multiline_GamePlayConditionDesc:SetSize(_Multiline_GamePlayConditionDesc:GetSizeX(), _Multiline_GamePlayConditionDesc:GetTextSizeY() + 10)
    _Multiline_GamePlayConditionDesc:SetPosX(textCenter)
    _Multiline_GamePlayConditionDesc:SetPosY(screenY - _Multiline_GamePlayConditionDesc:GetSizeY())
    _Multiline_GamePlayConditionDesc:SetShow(true)
  else
    _Multiline_GamePlayConditionDesc:SetText("")
    _Multiline_GamePlayConditionDesc:SetShow(false)
  end
end
function Fromclient_ResizeScreenSequence()
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_SequenceMain:SetPosX(0)
  Panel_SequenceMain:SetPosY(0)
  Panel_SequenceMain:SetSize(screenX, screenY)
  Panel_SequenceMain:ComputePosAllChild()
  _loadingBlackBG:SetSize(getScreenSizeX(), getScreenSizeY())
  _loadingCircle:ComputePos()
end
function FromClient_CloseSequenceEditorUI_Ocean()
  if Panel_SequenceMain == nil then
    return
  end
  Panel_SequenceMain:SetShow(false)
end
function FromClient_SequenceCantAttackAlertMessage()
  if Panel_SequenceMain == nil then
    return
  end
  if Panel_SequenceMain:GetShow() == false then
    return
  end
  _StaticText_CantAttackAlertMessage:SetShow(ToClient_IsAnySiegeBeingOfMyChannel())
end
function FromClient_SetShowSequenceLoadingPanel(flag)
  if Panel_SequenceMain == nil then
    return
  end
  _loadingBlackBG:SetShow(flag)
  _loadingCircle:SetShow(flag)
end
function UpdateSequenceKillCount(count)
  if _killCountTextDesc == nil or _killCountTextDesc == "" then
    return
  end
  local str = _killCountTextDesc .. " : " .. tostring(count) .. " / " .. tostring(_MinimumKillCount)
  _KillCountText:SetSize(_originControlSizeX, _originControlSizeY)
  _KillCountText:SetText(str)
  _KillCountText:SetSize(_KillCountText:GetTextSizeX(), _KillCountText:GetTextSizeY())
  local textSizeX = _KillCountText:GetSizeX()
  local textSizeY = _KillCountText:GetSizeY()
  local centerRatio = 0.5
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  if _alignType == 0 then
    centerRatio = 0
  elseif _alignType == 2 then
    centerRatio = 1
  end
  newPosX = screenX * _posRatioX * 0.01 - textSizeX * centerRatio
  newPosY = screenY * _posRatioY * 0.01 - textSizeY * centerRatio
  local rightPos = newPosX + _KillCountText:GetSizeX()
  if screenX < rightPos then
    local delta = rightPos - screenX + 10
    newPosX = newPosX - delta
  elseif 0 > newPosX then
    newPosX = 10
  end
  local bottomPos = newPosY + _KillCountText:GetSizeY()
  if screenY < bottomPos then
    local delta = bottomPos - screenY + 10
    newPosY = newPosY - delta
  elseif 0 > newPosY then
    newPosY = 10
  end
  _KillCountText:SetPosX(newPosX)
  _KillCountText:SetPosY(newPosY)
end
function FromClient_SequenceStartkillCount(stringKey, minimumKillCount, posRatioX, posRatioY, alignType)
  _MinimumKillCount = minimumKillCount
  _killCountTextDesc = PAGetString(Defines.StringSheet_CUTSCENE, stringKey)
  _posRatioX = posRatioX
  _posRatioY = posRatioY
  _alignType = alignType
  UpdateSequenceKillCount(0)
  _KillCountText:SetShow(true)
end
function FromClient_SequenceUpdatekillCount(count)
  if _KillCountText:GetShow() == false then
    return
  end
  UpdateSequenceKillCount(count)
end
function FromClient_SequencecClearKillCount(isClear)
  _KillCountText:SetText("")
  _KillCountText:SetShow(false)
end
