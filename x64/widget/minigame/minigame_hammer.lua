PaGlobal_HammerGame = {
  _isStart,
  _uiProgressBG,
  _uiProgressBar,
  _percentValue,
  _resultValue,
  _dirGauge
}
function PaGlobal_HammerGame:init()
  self._uiProgressBG = UI.getChildControl(Panel_Hammer_New, "Static_GaugeBG")
  self._uiProgressBar = UI.getChildControl(Panel_Hammer_New, "Progress2_Gauge")
  self._isStart = false
  self._percentValue = 0
  self._resultValue = 0
  self._countEnd = 0
  Panel_Hammer_New:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
end
function PaGlobal_HammerGame:Start()
  local centerX = getScreenSizeX() / 2 - Panel_Hammer_New:GetSizeX() / 2
  local centerY = getScreenSizeY() / 4
  Panel_Hammer_New:SetPosX(centerX)
  Panel_Hammer_New:SetPosY(centerY)
  Panel_Hammer_New:SetShow(true)
  self._isStart = true
  self._dirGauge = 5
  self._percentValue = 0
  self._resultValue = 0
  self._countEnd = 0
end
function PaGlobal_HammerGame_KeyFunc(keyType)
  PaGlobal_HammerGame:KeyFunc(keyType)
end
function PaGlobal_HammerGame:KeyFunc(keyType)
  if MGKT.MiniGameKeyType_Space == keyType then
    PaGlobal_HammerGame:End()
    ActionMiniGame_Stop()
  end
end
function PaGlobal_HammerGame:Update(deltaTime)
  if false == self._isStart then
    return
  end
  self._percentValue = self._percentValue + self._dirGauge
  if self._percentValue > 100 then
    self._percentValue = 100
    self._dirGauge = -5
  elseif self._percentValue < 0 then
    self._percentValue = 0
    self._dirGauge = 5
    self._countEnd = self._countEnd + 1
  end
  self._uiProgressBar:SetProgressRate(self._percentValue)
  if self._countEnd > 3 then
    self._isStart = false
    PaGlobal_HammerGame:End()
    ActionMiniGame_Stop()
  end
end
function PaGlobal_HammerGame:End()
  Panel_Hammer_New:SetShow(false)
end
Panel_Hammer_New:SetShow(false)
PaGlobal_HammerGame:init()
