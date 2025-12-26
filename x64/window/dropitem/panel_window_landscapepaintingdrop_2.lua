function PaGlobal_LandscapePainting_ShowAni()
  if PaGlobal_LandscapePainting == nil then
    return
  end
end
function PaGlobal_LandscapePainting_HideAni()
  if PaGlobal_LandscapePainting == nil then
    return
  end
end
function PaGlobal_LandscapePainting_Open()
  if PaGlobal_LandscapePainting == nil then
    return
  end
  PaGlobal_LandscapePainting:prepareOpen()
end
function PaGlobal_LandscapePainting_Close()
  if PaGlobal_LandscapePainting == nil then
    return
  end
  PaGlobal_LandscapePainting:prepareClose()
end
function PaGlobal_LandscapePainting_Toggle()
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  local isShow = Panel_Window_LandscapePaintingDrop:GetShow()
  if isShow == true then
    PaGlobal_LandscapePainting:prepareClose()
  else
    PaGlobal_LandscapePainting:prepareOpen()
  end
end
function PaGlobal_LandscapePainting_TotalSwitchToggle()
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  ToClient_requestToggleLandScapePaintingTotalSwitch()
end
function PaGlobal_LandscapePainting_UpdateSwitch()
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  if Panel_Window_LandscapePaintingDrop:GetShow() == false then
    return
  end
  self:update()
end
function PaGlobal_LandscapePainting_UpdatePoint(changeFromUseItem)
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  if Panel_Window_LandscapePaintingDrop:GetShow() == false then
    return
  end
  self:update()
  if changeFromUseItem == true and self._ui.itemSubPanel:GetShow() == true then
    if self._selectPaintingType ~= -1 then
      self:updateItemSlots(self._selectPaintingType)
    else
      self._ui.itemSubPanel:SetShow(false)
    end
  end
end
function PaGlobal_LandscapePainting_showLandscapePaintingItem(landScpaePaintingType, row, col)
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  if landScpaePaintingType >= __eLandscapePaintingType_Count or landScpaePaintingType < 0 then
    return
  end
  self:prepareItemSlot(landScpaePaintingType, row, col)
end
function PaGlobal_LandscapePainting_addLandscapePaintingPoint(landScpaePaintingType, idx)
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  if landScpaePaintingType >= __eLandscapePaintingType_Count or landScpaePaintingType < 0 then
    return
  end
  self:selectChargeItem(landScpaePaintingType, idx)
end
function PaGlobal_LandscapePainting_chargeLandscapePaintingPoint(inputNumber)
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  self:chargeLandscapePaintingPoint(inputNumber)
end
function PaGlobal_LandscapePainting_getToolTipString(includeKeyGuide)
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  return self:getToolTipString(includeKeyGuide)
end
function PaGlobal_LandscapePainting_itemSubPanelClose()
  if PaGlobal_LandscapePainting == nil then
    return
  end
  PaGlobal_LandscapePainting:itemSubPanelClose()
end
