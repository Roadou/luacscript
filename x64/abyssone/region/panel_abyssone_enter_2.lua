function PaGlobalFunc_EnterAbyssOne_Open()
  local self = PaGlobal_EnterAbyssOne
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_EnterAbyssOne_Close()
  local self = PaGlobal_EnterAbyssOne
  if self == nil then
    return
  end
  self:prepareClose()
end
function Panel_AbyssOne_Enter_ShowAni()
  Panel_AbyssOne_Enter:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_AbyssOne_Enter, 0, 0.5)
end
function Panel_AbyssOne_Enter_HideAni()
  Panel_AbyssOne_Enter:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, Panel_AbyssOne_Enter, 0, 0.5)
  aniInfo:SetHideAtEnd(true)
end
function PaGlobalFunc_EnterAbyssOne_Update(deltaTime)
  local self = PaGlobal_EnterAbyssOne
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_CheckEnterAbyssOne(contentsType)
  local self = PaGlobal_EnterAbyssOne
  if self == nil then
    return
  end
  if contentsType ~= __eInstanceContentsType_AbyssOne then
    return
  end
  PaGlobalFunc_EnterAbyssOne_Open()
end
