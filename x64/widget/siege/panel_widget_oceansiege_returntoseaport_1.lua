function PaGlobal_OceanSiegeReturnToSeaport:initialize()
  if self._initialize == true then
    return
  end
  self._ui.btn_return = UI.getChildControl(Panel_Widget_OceanSiege_ReturnToSeaport, "Button_Return")
  self:registEventHandler()
  self._initialize = true
  if ToClient_GetOceanSiegeReturnSeaportFlag() == true then
    FromClient_OceanSiegeReturnSeaportFlag_Toggle(true)
  end
end
function PaGlobal_OceanSiegeReturnToSeaport:registEventHandler()
  if Panel_Widget_OceanSiege_ReturnToSeaport == nil then
    return
  end
  self._ui.btn_return:addInputEvent("Mouse_On", "HandleEventLOnOut_OceanSiegeReturnSeaportFlag_ShowTooltip(true)")
  self._ui.btn_return:addInputEvent("Mouse_Out", "HandleEventLOnOut_OceanSiegeReturnSeaportFlag_ShowTooltip(false)")
  self._ui.btn_return:addInputEvent("Mouse_LUp", "HandleEventLUp_OceanSiegeReturnSeaportFlag_Return()")
  registerEvent("onScreenResize", "FromClient_OceanSiegeReturnSeaportFlag_OnResizePenal")
  registerEvent("FromClient_ChangeOceanSiegeReturnSeaportFlag", "FromClient_OceanSiegeReturnSeaportFlag_Toggle")
end
function PaGlobal_OceanSiegeReturnToSeaport:prepareOpen()
  if Panel_Widget_OceanSiege_ReturnToSeaport == nil then
    return
  end
  self._ui.btn_return:AddEffect("fUI_SiegeWar_Seaport_01A", true, 0, 0)
  self:onResize()
  self:open()
end
function PaGlobal_OceanSiegeReturnToSeaport:open()
  if Panel_Widget_OceanSiege_ReturnToSeaport == nil then
    return
  end
  Panel_Widget_OceanSiege_ReturnToSeaport:SetShow(true)
end
function PaGlobal_OceanSiegeReturnToSeaport:prepareClose()
  if Panel_Widget_OceanSiege_ReturnToSeaport == nil then
    return
  end
  self._ui.btn_return:EraseAllEffect()
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_OceanSiegeReturnToSeaport:close()
  if Panel_Widget_OceanSiege_ReturnToSeaport == nil then
    return
  end
  Panel_Widget_OceanSiege_ReturnToSeaport:SetShow(false)
end
function PaGlobal_OceanSiegeReturnToSeaport:onResize()
  if Panel_Widget_OceanSiege_ReturnToSeaport == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  local panelPosX = screenX * 0.7
  local panelPosY = screenY * 0.75
  Panel_Widget_OceanSiege_ReturnToSeaport:SetPosXY(panelPosX, panelPosY)
  Panel_Widget_OceanSiege_ReturnToSeaport:ComputePosAllChild()
end
