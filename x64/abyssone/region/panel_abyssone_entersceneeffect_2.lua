function PaGlobalFunc_EnterSceneEffect_Open(useFadeAni)
  local self = PaGlobal_EnterSceneEffect
  if self == nil then
    return
  end
  if Panel_AbyssOne_EnterSceneEffect:GetShow() == true then
    return
  end
  self._isUseFadeAni = useFadeAni
  self:prepareOpen()
end
function PaGlobalFunc_EnterSceneEffect_Close()
  local self = PaGlobal_EnterSceneEffect
  if self == nil then
    return
  end
  self:prepareClose()
end
function Panel_AbyssOne_EnterSceneEffect_ShowAni()
  Panel_AbyssOne_EnterSceneEffect:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_AbyssOne_EnterSceneEffect, 0, 0.4)
end
function Panel_AbyssOne_EnterSceneEffect_HideAni()
  Panel_AbyssOne_EnterSceneEffect:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_AbyssOne_EnterSceneEffect, 0, 0.4)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobalFunc_EnterSceneEffect_Update(deltaTime)
  local self = PaGlobal_EnterSceneEffect
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_EnterSceneEffect(useFadeAni)
  local self = PaGlobal_EnterSceneEffect
  if self == nil or useFadeAni == nil then
    return
  end
  PaGlobalFunc_EnterSceneEffect_Open(useFadeAni)
end
