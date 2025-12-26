local TIMER_VISIBLETIME = 5
local TIMER_FADETIME = 2
function PaGlobal_TimeRecording:initialize()
  if self._initialize == true then
    return
  end
  self._ui.txt_Time = UI.getChildControl(Panel_TimeLog_All, "StaticText_TimeLog")
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_TimeRecording:registerEventHandler()
  registerEvent("FromClient_ExecuteBossMonsterStopWatch", "FromClient_ExecuteBossMonsterStopWatch")
end
function PaGlobal_TimeRecording:prepareOpen(time)
  if Panel_TimeLog_All == nil then
    return
  end
  self._visibleTime = TIMER_VISIBLETIME
  self._fadeTime = TIMER_FADETIME
  local miliseconds = Int64toInt32(time)
  local seconds = miliseconds / 1000
  local minute = math.floor(seconds / 60)
  local restSeconds = math.floor(seconds - minute * 60)
  local strMinute = tostring(minute)
  local strSeconds = tostring(restSeconds)
  if minute < 10 then
    strMinute = tostring(0) .. strMinute
  end
  if restSeconds < 10 then
    strSeconds = tostring(0) .. strSeconds
  end
  local textTime = strMinute .. " : " .. strSeconds
  self._ui.txt_Time:SetText(textTime)
  Panel_TimeLog_All:RegisterUpdateFunc("Update_TimeRecord")
  Panel_TimeLog_All:AddEffect("FUI_Morning_Timer_01A", false, 0, 0)
  audioPostEvent_SystemUi(34, 30)
  _AudioPostEvent_SystemUiForXBOX(34, 30)
  PaGlobal_TimeRecording:open()
end
function PaGlobal_TimeRecording:open()
  if Panel_TimeLog_All == nil then
    return
  end
  Panel_TimeLog_All:SetShow(true)
end
function PaGlobal_TimeRecording:prepareClose()
  if Panel_TimeLog_All == nil then
    return
  end
  Panel_TimeLog_All:ClearUpdateLuaFunc()
  PaGlobal_TimeRecording:close()
end
function PaGlobal_TimeRecording:close()
  if Panel_TimeLog_All == nil then
    return
  end
  Panel_TimeLog_All:SetShow(false)
end
function Update_TimeRecord(deltaTime)
  if Panel_TimeLog_All == nil then
    return
  end
  PaGlobal_TimeRecording._visibleTime = PaGlobal_TimeRecording._visibleTime - deltaTime
  if PaGlobal_TimeRecording._visibleTime > 0 then
    return
  end
  PaGlobal_TimeRecording:prepareClose()
end
function FromClient_ExecuteBossMonsterStopWatch(state, time)
  if state ~= __eStopWatchPause and state ~= __eStopWatchEnd then
    return
  end
  if _ContentsGroup_MorningLandTierGo == true and state == __eStopWatchEnd and PaGlobal_ShowMorningLandSuccessMsg ~= nil then
    PaGlobal_ShowMorningLandSuccessMsg(time)
    return
  end
  if PaGlobal_TimeRecording_Open == nil then
    return
  end
  PaGlobal_TimeRecording_Open(time)
end
function PaGlobal_TimeRecording:validate()
  if Panel_TimeLog_All == nil then
    return
  end
  self._ui.txt_Time:isValidate()
end
