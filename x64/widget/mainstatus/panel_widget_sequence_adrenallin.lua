PaGlobal_Sequence_Adrenallin = {
  _ui = {
    _adCircleProgress = UI.getChildControl(Panel_Sequence_Adrenallin, "CircularProgress_Adrenallin"),
    _txt_Adrenallin = UI.getChildControl(Panel_Sequence_Adrenallin, "StaticText_AdPercent")
  },
  _prevAdrenallin = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Init_Sequence_Adrenallin")
function FromClient_Init_Sequence_Adrenallin()
  PaGlobal_Sequence_Adrenallin:initialize()
  PaGlobal_Sequence_Adrenallin:registEventHandler()
end
function PaGlobal_Sequence_Adrenallin:initialize()
  self:setPosition()
  self._initialize = true
end
function FromClient_EnterSequencePossessMode_Sequence_Adrenallin_Open()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    Panel_Sequence_Adrenallin:SetShow(false)
    return
  end
  Panel_Sequence_Adrenallin:SetAlpha(0)
  Panel_Sequence_Adrenallin:SetShow(selfPlayer:isEnableAdrenalin())
  local aniInfo = UIAni.AlphaAnimation(1, Panel_Sequence_Adrenallin, 0, 0.8)
  aniInfo:SetDisableWhileAni(true)
end
function FromClient_LeaveSequencePossessMode_Sequence_Adrenallin_Close()
  Panel_Sequence_Adrenallin:SetShow(false)
end
function PaGlobal_Sequence_Adrenallin:registEventHandler()
  registerEvent("onScreenResize", "FromClient_SequenceAdrenallin_OnScreenResize")
  registerEvent("FromClient_UpdateAdrenalin", "FromClient_UpdateSequenceAdrenalin")
  registerEvent("FromClient_EnterSequencePossessMode", "FromClient_EnterSequencePossessMode_Sequence_Adrenallin_Open")
  registerEvent("FromClient_LeaveSequencePossessMode", "FromClient_LeaveSequencePossessMode_Sequence_Adrenallin_Close")
end
function PaGlobalFunc_Sequence_Adrenallin_Update()
  local self = PaGlobal_Sequence_Adrenallin
  if self._initialize == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local adrenallin = selfPlayer:getAdrenalin()
  adrenallin = adrenallin / 10
  adrenallin = math.floor(adrenallin) / 10
  adrenallin = string.format("%.1f", adrenallin)
  self._ui._adCircleProgress:SetProgressRate(adrenallin)
  self._ui._txt_Adrenallin:SetText(adrenallin .. "%")
  self._prevAdrenallin = adrenallin
end
function FromClient_UpdateSequenceAdrenalin()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  PaGlobalFunc_Sequence_Adrenallin_Update()
end
function FromClient_SequenceAdrenallin_OnScreenResize()
  Panel_Sequence_Adrenallin:ComputePos()
  PaGlobal_Sequence_Adrenallin:setPosition()
end
function PaGlobal_Sequence_Adrenallin:setPosition()
  Panel_Sequence_Adrenallin:SetPosXY(Panel_Sequence_HpMpBar:GetPosX() + Panel_Sequence_HpMpBar:GetSizeX() + 20, Panel_Sequence_HpMpBar:GetPosY() - 5)
end
