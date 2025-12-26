local UI_color = Defines.Color
Panel_Stamina:SetShow(false, false)
local staticBar = UI.getChildControl(Panel_Stamina, "StaminaBar")
local _bar_FullGauge = UI.getChildControl(Panel_Stamina, "Static_FullGauge")
local _txt_StaminaMax = UI.getChildControl(Panel_Stamina, "StaticText_StaminaMax")
local _cannonDesc = UI.getChildControl(Panel_Stamina, "StaticText_CannonDesc")
local maxBarSize = staticBar:GetSizeX()
Panel_Stamina:RegisterShowEventFunc(false, "Panel_Stamina_HideAni()")
Panel_Stamina:ComputePos()
function Panel_Stamina_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_Stamina, 0, 0.2)
  aniInfo:SetHideAtEnd(true)
end
local SpUseType = {
  Once = 0,
  Continue = 1,
  Recover = 2,
  Stop = 3,
  Reset = 4,
  None = 5,
  Count = 6
}
function Stamina_Update()
  local useType = ToClient_GetSelfPlayerSPUseType()
  if useType >= SpUseType.Count then
    return
  end
  local sp = ToClient_GetSelfPlayerSP()
  local maxSp = ToClient_GetSelfPlayerMaxSP()
  if Panel_Cannon_Value_IsCannon == true then
    _cannonDesc:SetShow(true)
  else
    _cannonDesc:SetShow(false)
  end
  if sp == maxSp and useType == SpUseType.Recover then
    _bar_FullGauge:SetShow(true)
    _bar_FullGauge:EraseAllEffect()
    Panel_Stamina:SetShow(false, false)
    return
  end
  if UI.isFlushedUI() == true then
    local isSequenceControlableMode = ToClient_isPlayerControlable()
    if isSequenceControlableMode == false then
      Panel_Stamina:SetShow(false, false)
      return
    end
  end
  local spRate = sp / maxSp
  local alpha = (1 - spRate) * 15
  local fullGauge = spRate * 100
  if alpha > 1 then
    alpha = 1
  end
  Panel_Stamina:SetAlphaChild(alpha)
  staticBar:SetProgressRate(fullGauge)
  _txt_StaminaMax:SetFontAlpha(alpha)
  _txt_StaminaMax:SetText(tostring(math.floor(spRate * 100)))
  Panel_Stamina:SetShow(true, false)
end
function FromClient_Stamina_OnResize()
  Panel_Stamina:ComputePos()
end
registerEvent("onScreenResize", "FromClient_Stamina_OnResize")
registerEvent("EventStaminaUpdate", "Stamina_Update()")
Panel_Stamina:RegisterUpdateFunc("Stamina_Update")
