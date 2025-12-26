function PaGlobal_ServantUpgrade_Close()
  local self = PaGlobal_ServantUpgrade
  if true == PaGlobal_ServantUpgrade._isConsole then
    HandleEventLUp_ServantUpgrade_Cancel()
    return
  end
  self:close()
end
function HandleEventLUp_ServantUpgrade_Cancel()
  if true == PaGlobal_ServantUpgrade._isProgressing then
    Panel_Window_ServantUpgrade:ClearUpdateLuaFunc("Update_ServantUpgrade_ProgressBar")
    PaGlobal_ServantUpgrade:cancelClear()
    return
  end
  PaGlobal_ServantUpgrade:close()
end
function Update_ServantUpgrade_ProgressBar(deltaTime)
  local self = PaGlobal_ServantUpgrade
  if self._updateCompleteTime < self._updateCurrentTime then
    return
  end
  self._updateCurrentTime = self._updateCurrentTime + deltaTime
  self._prevUpdateTime = self._updateCurrentTime
  local pct = 100 * self._updateCurrentTime / self._updateCompleteTime
  self._ui._txt_progressPct:SetText(string.format("%.0f %%", pct))
  self._ui._progressBar:SetProgressRate(pct)
  if self._updateCompleteTime < self._updateCurrentTime then
    self:progressBarUpdateComplete()
  end
end
function PaGlobal_ServantUpgrade_SelectedIndex(index)
  PaGlobal_ServantUpgrade:selectIndex(index)
end
function HandleEventLUp_ServantUpgrade_handleClickedWebGuide()
  local url = "https://www.console.playblackdesert.com/Wiki/Default?wikiNo=253"
  if ToClient_isPS4() == true then
    ToClient_OpenNativeWebBrowserPS4(url)
  elseif ToClient_isXBox() == true then
    ToClient_OpenNativeWebBrowserXB1(url, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_EXTANTION_GUIDE_BTN"))
  else
    local guideString = "Carrack_Vehicle"
    Panel_WebHelper_ShowToggle(guideString)
  end
end
