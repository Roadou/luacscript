function MessageBoxPanelNilCheck()
  if nil ~= Panel_Window_MessageBox_All then
    return true
  end
  return false
end
function MessageBoxGetShow()
  if nil ~= Panel_Window_MessageBox_All then
    return Panel_Window_MessageBox_All:GetShow()
  end
end
function MessageBoxCheckGetShow()
  if nil ~= Panel_Window_MessageBox_All then
    return Panel_Window_MessageBox_All:GetShow()
  end
end
