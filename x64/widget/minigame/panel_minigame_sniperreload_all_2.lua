function PaGlobal_MiniGame_SniperReload_All_Open()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._ui.progress_reloadTimeBG:SetShow(_ContentsGroup_NewSniperMode)
  PaGlobal_MiniGame_SniperReload_All:prepareOpen()
end
function PaGlobal_MiniGame_SniperReload_All_Close()
  if nil == Panel_MiniGame_SniperReload_All or false == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperReload_All:prepareClose()
end
function PaGlobal_MiniGame_SniperReload_All_UpdatePerFrame(deltaTime)
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  if _ContentsGroup_NewSniperMode == true and PaGlobal_MiniGame_SniperReload_All._reloadFailed == true then
    PaGlobal_MiniGame_SniperReload_All_UpdatePerFrame_NewSniperMode(deltaTime)
    return
  end
  PaGlobal_MiniGame_SniperReload_All._reloadRemainTime = PaGlobal_MiniGame_SniperReload_All._reloadRemainTime - deltaTime
  if PaGlobal_MiniGame_SniperReload_All._reloadRemainTime < 0 then
    PaGlobal_MiniGame_SniperReload_All._reloadRemainTime = 0
  end
  if _ContentsGroup_NewSniperMode == true then
    PaGlobal_MiniGame_SniperReload_All._ui.progress_reloadTime:SetProgressRate(PaGlobal_MiniGame_SniperReload_All._reloadRemainTime / PaGlobal_MiniGame_SniperReload_All._reloadTimeLimit * 100)
  else
    local remainTime = string.format("%.2f", PaGlobal_MiniGame_SniperReload_All._reloadRemainTime)
    PaGlobal_MiniGame_SniperReload_All._ui.txt_leftTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMARKET_CASHITEREMIND_TIME", "Time", remainTime))
  end
  PaGlobal_MiniGame_SniperReload_All._theta = PaGlobal_MiniGame_SniperReload_All._theta + deltaTime * PaGlobal_MiniGame_SniperReload_All._speed
  if PaGlobal_MiniGame_SniperReload_All._theta > PaGlobal_MiniGame_SniperReload_All._piDouble then
    PaGlobal_MiniGame_SniperReload_All._theta = 0
    PaGlobal_MiniGame_SniperReload_All._inputLocked = false
    PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:ResetVertexAni()
    PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
  end
  PaGlobal_MiniGame_SniperReload_All._markPosX = math.cos(PaGlobal_MiniGame_SniperReload_All._theta) * -PaGlobal_MiniGame_SniperReload_All._span + PaGlobal_MiniGame_SniperReload_All._span + PaGlobal_MiniGame_SniperReload_All._leftEndX
  PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:SetPosX(PaGlobal_MiniGame_SniperReload_All._markPosX)
end
function PaGlobal_MiniGame_SniperReload_All_KeyFunc(keyType)
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  if _ContentsGroup_NewSniperMode == true then
    PaGlobal_MiniGame_SniperReload_All_KeyFunc_NewSniperMode(keyType)
    return
  end
  if CppEnums.MiniGameKeyType.MiniGameKeyType_Space == keyType then
    if false == PaGlobal_MiniGame_SniperReload_All._inputLocked and PaGlobal_MiniGame_SniperReload_All._leftSuccessX < PaGlobal_MiniGame_SniperReload_All._markPosX and PaGlobal_MiniGame_SniperReload_All._markPosX < PaGlobal_MiniGame_SniperReload_All._rightSuccessX then
      getSelfPlayer():get():SetMiniGameResult(0)
      PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:ResetVertexAni()
      PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
      PaGlobal_MiniGame_SniperReload_All_Close()
      luaTimer_AddEvent(PaGlobal_MiniGame_SniperGame_All_FadeIn, 500, false, 0)
    else
      audioPostEvent_SystemUi(11, 40)
      PaGlobal_MiniGame_SniperReload_All._inputLocked = true
      PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:ResetVertexAni()
      local aniData = PaGlobal_MiniGame_SniperReload_All._activeReloadControl.reloadMark:addColorAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
      aniData:SetStartColor(Defines.Color.C_FFFF0000)
      aniData:SetEndColor(Defines.Color.C_FFFFAB6D)
    end
  end
end
function PaGlobal_MiniGame_SniperReload_All_UpdatePerFrame_NewSniperMode(deltaTime)
  if _ContentsGroup_NewSniperMode == false then
    return
  end
  local self = PaGlobal_MiniGame_SniperReload_All
  if self == nil then
    return
  end
  if self._reloadFailed == false then
    return
  end
  self._reloadOverTime = self._reloadOverTime - deltaTime
  if self._reloadOverTime > 0 then
    return
  end
  getSelfPlayer():get():SetMiniGameResult(0)
  PaGlobal_MiniGame_SniperReload_All_Close()
  luaTimer_AddEvent(PaGlobal_MiniGame_SniperGame_All_FadeIn, 500, false, 0)
  self._reloadFailed = false
  self._reloadOverTime = 0
end
function PaGlobal_MiniGame_SniperReload_All_KeyFunc_NewSniperMode(keyType)
  if _ContentsGroup_NewSniperMode == false then
    return
  end
  if keyType ~= CppEnums.MiniGameKeyType.MiniGameKeyType_Space then
    return
  end
  local self = PaGlobal_MiniGame_SniperReload_All
  if self == nil then
    return
  end
  if self._reloadFailed == true then
    return
  end
  if self._leftSuccessX < self._markPosX and self._markPosX < self._rightSuccessX then
    getSelfPlayer():get():SetMiniGameResult(0)
    self._activeReloadControl.reloadMark:ResetVertexAni()
    self._activeReloadControl.reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
    PaGlobal_MiniGame_SniperReload_All_Close()
    luaTimer_AddEvent(PaGlobal_MiniGame_SniperGame_All_FadeIn, 500, false, 0)
  else
    audioPostEvent_SystemUi(11, 40)
    self._activeReloadControl.reloadMark:ResetVertexAni()
    self._activeReloadControl.reloadMark:SetColor(Defines.Color.C_FFFF0000)
    self._reloadOverTime = 2
    self._reloadFailed = true
  end
end
function FromClient_Minigame_Sniper_All_OnScreenSize()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  Panel_MiniGame_SniperReload_All:ComputePosAllChild()
end
