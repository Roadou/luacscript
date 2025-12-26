PaGlobal_Widget_RabbitLiverScrambleTimer = {
  _ui = {_txt_time = nil},
  _mainPanel = Panel_Widget_RabbitLiverScrambleTimer,
  _panelSize = nil,
  _grapeSize = nil,
  _socketSize = nil,
  _initialize = false,
  _timerKey = nil,
  _remainTime = 600
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Widget_RabbitLiverScrambleTimer_Init")
function FromClient_Widget_RabbitLiverScrambleTimer_Init()
  PaGlobal_Widget_RabbitLiverScrambleTimer:initialize()
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:initialize()
  if self._initialize == true or Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  self:registEventHandler()
  self._ui._txt_time = UI.getChildControl(Panel_Widget_RabbitLiverScrambleTimer, "StaticText_Time")
  self._initialize = true
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:registEventHandler()
  if nil == Panel_Widget_RabbitLiverScrambleTimer then
    return
  end
  registerEvent("FromClient_StartDragonPalaceMiniGame", "PaGlobal_Widget_RabbitLiverScrambleTimer_Open")
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:open()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  Panel_Widget_RabbitLiverScrambleTimer:SetShow(true)
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:prepareOpen()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  self.clear()
  self.open()
  self.registTimer()
  if 0 < ToClient_getPetUnsealedList() and nil ~= HandleEventLUp_PetList_SealAllPet_All then
    HandleEventLUp_PetList_SealAllPet_All()
  end
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:close()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  Panel_Widget_RabbitLiverScrambleTimer:SetShow(false)
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:prepareClose()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  self.close()
  self.clear()
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:clear()
  local self = PaGlobal_Widget_RabbitLiverScrambleTimer
  self._remainTime = 600
end
function PaGlobalFunc_Widget_RabbitLiverScrambleTimer_Update()
  local self = PaGlobal_Widget_RabbitLiverScrambleTimer
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  self._remainTime = self._remainTime - 1
  if self._remainTime < 0 then
    luaTimer_RemoveEvent(self._timerKey)
    return
  end
  self.updateTime()
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:updateTime()
  local self = PaGlobal_Widget_RabbitLiverScrambleTimer
  local minute = math.floor(self._remainTime / 60)
  local second = math.floor(self._remainTime % 60)
  self._ui._txt_time:SetText(string.format("%02d", minute) .. ":" .. string.format("%02d", second))
end
function PaGlobal_Widget_RabbitLiverScrambleTimer:registTimer()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  local self = PaGlobal_Widget_RabbitLiverScrambleTimer
  self.updateTime()
  self._timerKey = luaTimer_AddEvent(PaGlobalFunc_Widget_RabbitLiverScrambleTimer_Update, 1000, true, 1000)
end
function PaGlobal_Widget_RabbitLiverScrambleTimer_Close()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  PaGlobal_Widget_RabbitLiverScrambleTimer:prepareClose()
end
function PaGlobal_Widget_RabbitLiverScrambleTimer_Open()
  if Panel_Widget_RabbitLiverScrambleTimer == nil then
    return
  end
  if Panel_Widget_RabbitLiverScrambleTimer:GetShow() == true then
    return
  end
  PaGlobal_Widget_RabbitLiverScrambleTimer:prepareOpen()
end
