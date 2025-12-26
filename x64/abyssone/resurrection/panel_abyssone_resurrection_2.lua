function PaGlobalFunc_AbyssOneResurrection_Open()
  local self = PaGlobal_AbyssOneResurrection
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_AbyssOneResurrection_Close()
  local self = PaGlobal_AbyssOneResurrection
  if self == nil then
    return
  end
  self:prepareClose()
end
function Panel_AbyssOne_Resurrection_ShowAni()
  Panel_AbyssOne_Resurrection:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_AbyssOne_Resurrection, 0, 0.5)
end
function Panel_AbyssOne_Resurrection_HideAni()
  Panel_AbyssOne_Resurrection:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_AbyssOne_Resurrection, 0, 0.5)
  aniInfo:SetHideAtEnd(true)
end
function HandleEventLUp_AbyssOneResurrection_Revive(reviveType)
  local self = PaGlobal_AbyssOneResurrection
  if self == nil or reviveType == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  if ToClient_CheckInstanceMirrorFieldRestartTime(true) == false then
    return
  else
    ToClient_SetInstanceMirrorFieldRestartNextTime(60)
  end
  deadMessage_Revival(reviveType, 255, CppEnums.ItemWhereType.eCount, selfPlayerWrapper:getRegionKey(), false, toInt64(0, 0), false, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
  if __eRespawnType_AbyssOne == reviveType then
    self._ui._btn_returnMagnus:SetIgnore(true)
    self._ui._btn_returnMagnus:SetMonoTone(true)
    self._ui._btn_exit:SetIgnore(true)
    self._ui._btn_exit:SetMonoTone(true)
  else
    self:setButtuonIgnoreAndMonotone(true)
  end
end
function FromClient_AbyssOne_Dead()
  local self = PaGlobal_AbyssOneResurrection
  if self == nil then
    return
  end
  PaGlobalFunc_AbyssOneResurrection_Open()
end
function FromClient_AbyssOne_Revive()
  local self = PaGlobal_AbyssOneResurrection
  if self == nil then
    return
  end
  PaGlobalFunc_AbyssOneResurrection_Close()
end
function FromClient_AbyssOne_RestartFail()
  PaGlobal_AbyssOneResurrection:setButtuonIgnoreAndMonotone(false)
end
