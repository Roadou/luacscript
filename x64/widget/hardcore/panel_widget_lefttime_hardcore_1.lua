function PaGlobal_HardCoreLeftTime:initialize()
  if PaGlobal_HardCoreLeftTime._initialize == true then
    return
  end
  local timeTitle = UI.getChildControl(Panel_Widget_LeftTime_HardCore, "StaticText_TimeTitle")
  timeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE_REMAINTIME"))
  self._ui._stc_TimeValue = UI.getChildControl(Panel_Widget_LeftTime_HardCore, "StaticText_TimeValue")
  self._ui._stc_BlackBarrier = UI.getChildControl(Panel_Widget_LeftTime_HardCore, "Static_BlackBarrier")
  local blackBarrierText = UI.getChildControl(self._ui._stc_BlackBarrier, "StaticText_BlackBarrierTitle")
  blackBarrierText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_LEFTTIME_BLAKCBARRIERTITLE_HARDCORE"))
  self._ui._stc_BlackBarrierLeftPlayersCount = UI.getChildControl(self._ui._stc_BlackBarrier, "StaticText_BalckBarrierValue")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_HardCoreLeftTime:registEventHandler()
  PaGlobal_HardCoreLeftTime:validate()
  PaGlobal_HardCoreLeftTime._initialize = true
  if _ContentsGroup_HardCoreChannel == true then
    if ToClient_isHardCoreChannel() == true then
      self:prepareOpen()
    else
      Panel_Widget_LeftTime_HardCore:SetShow(false)
    end
  end
end
function PaGlobal_HardCoreLeftTime:registEventHandler()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  registerEvent("FromClient_HardCoreUpdateBlackField", "PaGlobal_HardCoreLeftTime_UpdateBlackField")
  registerEvent("FromClient_HardCoreUpdateLeftTime", "PaGlobal_HardCoreLeftTime_UpdateLeftTime")
end
function PaGlobal_HardCoreLeftTime:validate()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
end
function PaGlobal_HardCoreLeftTime:prepareOpen()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  self:updateBlackField()
  self:open()
end
function PaGlobal_HardCoreLeftTime:open()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  Panel_Widget_LeftTime_HardCore:SetShow(true)
end
function PaGlobal_HardCoreLeftTime:prepareClose()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  self:close()
end
function PaGlobal_HardCoreLeftTime:close()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  Panel_Widget_LeftTime_HardCore:SetShow(false)
end
function PaGlobal_HardCoreLeftTime:updateBlackField()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  if ToClient_IsHardCorePlayerInBlackField() == false then
    self._ui._stc_BlackBarrier:SetShow(false)
    return
  end
  self._ui._stc_BlackBarrier:SetShow(true)
  local leftPlayerCount = ToClient_getHardCoreBlackFieldPlayerCount()
  local text = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_LEFTTIME_LEFTMEMBERVALUE_HARDCORE", "count", leftPlayerCount)
  self._ui._stc_BlackBarrierLeftPlayersCount:SetText(text)
end
function PaGlobal_HardCoreLeftTime:updateLeftTime()
  if Panel_Widget_LeftTime_HardCore == nil then
    return
  end
  local s64_leftTime = ToClient_getHardCoreLeftTime()
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_hour = s64_leftTime / s64_hourCycle
  local s64_minute = (s64_leftTime - s64_hourCycle * s64_hour) / s64_minuteCycle
  local s64_Second = s64_leftTime - s64_hourCycle * s64_hour - s64_minuteCycle * s64_minute
  local hourString = tostring(s64_hour)
  local minuteString = tostring(s64_minute)
  local secondString = tostring(s64_Second)
  local limit = toInt64(0, 10)
  if s64_hour < limit then
    hourString = "0" .. hourString
  end
  if s64_minute < limit then
    minuteString = "0" .. minuteString
  end
  if s64_Second < limit then
    secondString = "0" .. secondString
  end
  local leftTimeText = hourString .. " : " .. minuteString .. " : " .. secondString
  self._ui._stc_TimeValue:SetText(leftTimeText)
end
