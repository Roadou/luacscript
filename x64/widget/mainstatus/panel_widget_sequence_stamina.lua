PaGlobal_Sequence_Stamina = {_initialize = false}
registerEvent("FromClient_luaLoadComplete", "FromClient_Init_Sequence_Stamina")
function FromClient_Init_Sequence_Stamina()
  PaGlobal_Sequence_Stamina:initialize()
  PaGlobal_Sequence_Stamina:registEventHandler()
end
function PaGlobal_Sequence_Stamina:initialize()
  self._staticBar = UI.getChildControl(Panel_Sequence_Stamina, "StaminaBar")
  self._bar_FullGauge = UI.getChildControl(Panel_Sequence_Stamina, "Static_FullGauge")
  self._txt_StaminaMax = UI.getChildControl(Panel_Sequence_Stamina, "StaticText_StaminaMax")
  self._SpUseType = {
    Once = 0,
    Continue = 1,
    Recover = 2,
    Stop = 3,
    Reset = 4,
    None = 5
  }
  Panel_Sequence_Stamina:RegisterShowEventFunc(false, "Panel_Sequence_Stamina_HideAni()")
  self:setPosition()
  self._initialize = true
end
function Panel_Sequence_Stamina_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Sequence_Stamina, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_EnterSequencePossessMode_Sequence_Stamina_Open()
  Panel_Sequence_Stamina:SetAlpha(0)
  Panel_Sequence_Stamina:SetShow(true)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_Sequence_Stamina, 0, 0.8)
  aniInfo:SetDisableWhileAni(true)
end
function FromClient_LeaveSequencePossessMode_Sequence_Stamina_Close()
  Panel_Sequence_Stamina:SetShow(false)
end
function PaGlobal_Sequence_Stamina:registEventHandler()
  registerEvent("onScreenResize", "FromClient_Sequence_Stamina_OnResize")
  registerEvent("EventStaminaUpdate", "Sequence_Stamina_Update()")
  registerEvent("FromClient_EnterSequencePossessMode", "FromClient_EnterSequencePossessMode_Sequence_Stamina_Open")
  registerEvent("FromClient_LeaveSequencePossessMode", "FromClient_LeaveSequencePossessMode_Sequence_Stamina_Close")
  Panel_Sequence_Stamina:RegisterUpdateFunc("Sequence_Stamina_Update")
end
function Sequence_Stamina_Update()
  if ToClient_isCutScenePlayerControlMode() == false and ToClient_isPlayerControlable() == false then
    return
  end
  local self = PaGlobal_Sequence_Stamina
  if self._initialize == false then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local stamina = selfPlayerWrapper:get():getStamina()
  if stamina == nil then
    return
  end
  local sp = stamina:getSp()
  local maxSp = stamina:getMaxSp()
  local useType = stamina:getUseType()
  if sp == maxSp and useType == self._SpUseType.Recover then
    self._bar_FullGauge:SetShow(true)
    self._bar_FullGauge:EraseAllEffect()
    Panel_Sequence_Stamina:SetShow(false, false)
    return
  end
  local spRate = sp / maxSp
  local alpha = (1 - spRate) * 15
  local fullGauge = spRate * 100
  if alpha > 1 then
    alpha = 1
  end
  Panel_Sequence_Stamina:SetAlphaChild(alpha)
  self._staticBar:SetProgressRate(fullGauge)
  self._txt_StaminaMax:SetFontAlpha(alpha)
  self._txt_StaminaMax:SetText(tostring(math.floor(spRate * 100)))
  Panel_Sequence_Stamina:SetShow(true, false)
end
function FromClient_Sequence_Stamina_OnResize()
  Panel_Sequence_Stamina:ComputePos()
  PaGlobal_Sequence_Stamina:setPosition()
end
function PaGlobal_Sequence_Stamina:setPosition()
  Panel_Sequence_Stamina:SetPosXY(Panel_Sequence_HpMpBar:GetPosX() + Panel_Sequence_HpMpBar:GetSizeX() / 2 - Panel_Sequence_Stamina:GetSizeX() / 2, Panel_Sequence_HpMpBar:GetPosY() - 50)
end
