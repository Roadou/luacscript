function PaGlobal_Tooltip_Actor_All_Open(actorKey)
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  PaGlobal_Tooltip_Actor_All:prepareOpen(actorKey)
end
function PaGlobal_Tooltip_Actor_All_Close()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  PaGlobal_Tooltip_Actor_All:prepareClose()
end
