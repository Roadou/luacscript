function PaGlobal_EnterSceneEffect:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_effect = UI.getChildControl(Panel_AbyssOne_EnterSceneEffect, "Static_Effect")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnterSceneEffect:registEventHandler()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  Panel_AbyssOne_EnterSceneEffect:RegisterShowEventFunc(true, "Panel_AbyssOne_EnterSceneEffect_ShowAni()")
  Panel_AbyssOne_EnterSceneEffect:RegisterShowEventFunc(false, "Panel_AbyssOne_EnterSceneEffect_HideAni()")
  registerEvent("FromClinet_EnterAbyssOne", "FromClient_EnterSceneEffect")
end
function PaGlobal_EnterSceneEffect:validate()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  self._ui._stc_effect:isValidate()
end
function PaGlobal_EnterSceneEffect:resize()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  Panel_AbyssOne_EnterSceneEffect:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_AbyssOne_EnterSceneEffect:ComputePos()
  self._ui._stc_effect:SetSize(Panel_AbyssOne_EnterSceneEffect:GetSizeX(), Panel_AbyssOne_EnterSceneEffect:GetSizeY())
  self._ui._stc_effect:ComputePos()
end
function PaGlobal_EnterSceneEffect:prepareOpen()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  self:resize()
  self._ui._stc_effect:SetShow(true)
  self._ui._stc_effect:EraseAllEffect()
  self._ui._stc_effect:AddEffect("fUI_InGame_Light_01B", false, 0, 0)
  self:open()
end
function PaGlobal_EnterSceneEffect:open()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  Panel_AbyssOne_EnterSceneEffect:RegisterUpdateFunc("PaGlobalFunc_EnterSceneEffect_Update")
  Panel_AbyssOne_EnterSceneEffect:SetShow(true, self._isUseFadeAni)
end
function PaGlobal_EnterSceneEffect:prepareClose()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  self._accTimeSec = 0
  self._ui._stc_effect:SetShow(false)
  self._ui._stc_effect:EraseAllEffect()
  self:close()
end
function PaGlobal_EnterSceneEffect:close()
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  Panel_AbyssOne_EnterSceneEffect:ClearUpdateLuaFunc()
  Panel_AbyssOne_EnterSceneEffect:SetShow(false, self._isUseFadeAni)
  self._isUseFadeAni = false
end
function PaGlobal_EnterSceneEffect:update(deltaTime)
  if Panel_AbyssOne_EnterSceneEffect == nil then
    return
  end
  self._accTimeSec = self._accTimeSec + deltaTime
  if self._hideTimeSec <= self._accTimeSec then
    PaGlobalFunc_EnterSceneEffect_Close()
  end
end
