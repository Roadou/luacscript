function PaGlobal_HardCoreChannel_UIController:initialize()
  if PaGlobal_HardCoreChannel_UIController._initialize == true then
    return
  end
  self:setShowSettingAndLock()
  PaGlobal_HardCoreChannel_UIController._initialize = true
end
function PaGlobal_HardCoreChannel_UIController:setShowSettingAndLock()
  if _ContentsGroup_HardCoreChannel == false then
    return
  end
  for index, panel in pairs(self._cantShowUIPanelList) do
    if nil ~= panel then
      if ToClient_isHardCoreChannel() == true then
        panel:SetShow(false)
        panel:SetShowLock(true)
      else
        panel:SetShowLock(false)
      end
    end
  end
  for index, panel in pairs(self._hardCorePanelList) do
    if nil ~= panel then
      if ToClient_isHardCoreChannel() == false then
        panel:SetShow(false)
        panel:SetShowLock(true)
      else
        panel:SetShowLock(false)
      end
    end
  end
end
