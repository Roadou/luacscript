function PaGlobalFunc_RoseWarNakWarLog_Open()
  local self = PaGlobal_RoseWar_NakWarLog
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_RoseWarNakWarLog_Close()
  local self = PaGlobal_RoseWar_NakWarLog
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_RoseWarNakWarLog_IsShow()
  if Panel_RoseWar_Nak_WarLog == nil then
    return false
  end
  return Panel_RoseWar_Nak_WarLog:GetShow()
end
function FromClient_RoseWarNakWarLog_ChangeRoseWarState(state)
  local self = PaGlobal_RoseWar_NakWarLog
  if self == nil or state == nil then
    return
  end
  if state == __eRoseWar_Start then
    PaGlobalFunc_RoseWarNakWarLog_Open()
  else
    PaGlobalFunc_RoseWarNakWarLog_Close()
  end
end
