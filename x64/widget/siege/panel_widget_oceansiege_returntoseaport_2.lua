function FromClient_OceanSiegeReturnSeaportFlag_OnResizePenal()
  local self = PaGlobal_OceanSiegeReturnToSeaport
  if self == nil then
    return
  end
  self:onResize()
end
function FromClient_OceanSiegeReturnSeaportFlag_Toggle(isOn)
  local self = PaGlobal_OceanSiegeReturnToSeaport
  if self == nil or isOn == nil then
    return
  end
  if isOn == true then
    self:prepareOpen()
  else
    self:prepareClose()
  end
end
function HandleEventLOnOut_OceanSiegeReturnSeaportFlag_ShowTooltip(isShow)
  local self = PaGlobal_OceanSiegeReturnToSeaport
  if self == nil or isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_OCEANSIEGE_RETURN_SEAPORT_ICON_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_OCEANSIEGE_RETURN_SEAPORT_ICON_TOOLTIP_DESC")
  TooltipSimple_Show(self._ui.btn_return, name, desc)
end
function HandleEventLUp_OceanSiegeReturnSeaportFlag_Return()
  local self = PaGlobal_OceanSiegeReturnToSeaport
  if self == nil then
    return
  end
  PaGlobal_Itemwarp:showOceanSiegeWarpTownList()
end
