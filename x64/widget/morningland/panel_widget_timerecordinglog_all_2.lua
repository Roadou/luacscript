function PaGlobal_TimeRecording_Open(time)
  if Panel_TimeLog_All == nil then
    return
  end
  if Panel_TimeLog_All:GetShow() == true then
    return
  end
  PaGlobal_TimeRecording:prepareOpen(time)
end
function PaGlobal_TimeRecording_Close()
  if Panel_TimeLog_All == nil then
    return
  end
  if Panel_TimeLog_All:GetShow() == false then
    return
  end
  PaGlobal_TimeRecording:prepareClose()
end
