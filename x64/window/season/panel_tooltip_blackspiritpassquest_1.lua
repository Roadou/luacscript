function TooltipBlackSpiritPassQuest_Show(index)
  PaGlobal_BlackspiritPassTooltipQuest:prepareOpen(index)
end
function TooltipBlackSpiritPassQuest_Hide()
  PaGlobal_BlackspiritPassTooltipQuest:prepareClose()
end
function TooltipBlackSpiritPassQuest_IsShow()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return false
  end
  return Panel_Widget_Tooltip_BlackSpiritPass_Quest:GetShow()
end
function TooltipBlackSpiritPassQuest_Show_ForConsole(index)
  PaGlobal_BlackspiritPassTooltipQuest:prepareOpenConsole(index)
end
