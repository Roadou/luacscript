function PaGlobalFunc_ServantSimulatorSubView_Open(openType, maleType)
  local self = PaGlobal_ServantSimulatorSubView
  if self == nil or openType == nil then
    return
  end
  self:prepareOpen(openType, maleType)
end
function PaGlobalFunc_ServantSimulatorSubView_Close()
  local self = PaGlobal_ServantSimulatorSubView
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ServantSimulatorSubView_IsShow()
  local panel = Panel_Dialog_ServantSimulatorSubView
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function HandleEventLUp_ServantSimulatorSubView_ChangeTab(tabType)
  local self = PaGlobal_ServantSimulatorSubView
  if self == nil then
    return
  end
  self:changeTab(tabType)
end
function HandleEventLUp_ServantSimulatorSubView_ChangeTabConsole(isRB)
  local self = PaGlobal_ServantSimulatorSubView
  if self == nil then
    return
  end
  self:changeTabConsole(isRB)
end
function HandleEventOnOut_ServantSimulatorSubView_ToggleHorseTypeToolTip(isShow, groupDataIndex, horseControlIndex, maleType, horseIndex, isOnlyMyHorse)
  local self = PaGlobal_ServantSimulatorSubView
  if self == nil then
    return
  end
  self:toggleHorseTypeToolTip(isShow, groupDataIndex, horseControlIndex, maleType, horseIndex, isOnlyMyHorse)
end
