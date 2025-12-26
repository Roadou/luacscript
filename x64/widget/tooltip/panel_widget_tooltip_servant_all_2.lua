function PaGlobal_Tooltip_Servant_All_Open(control, servantType)
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  PaGlobal_ToolTip_Servant_All:prepareOpen(control, servantType)
end
function PaGlobal_Tooltip_Servant_All_Close()
  PaGlobal_ToolTip_Servant_All:prepareClose()
end
function PaGlobal_Tooltip_Servant_All_OnScreenSizeRefresh()
  PaGlobal_ToolTip_Servant_All:ComputePos()
end
