PaGlobal_Widget_OnOffShip = {
  _ui = {
    btn_rideOn = nil,
    btn_approach = nil,
    stc_desc = nil
  },
  _originPosY = 0,
  _originSizeY = 0,
  _originApproachBtnPosY = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "PaGlobal_Widget_OnOffShip_Init")
function PaGlobal_Widget_OnOffShip_Init()
  PaGlobal_Widget_OnOffShip:initialize()
end
function PaGlobal_Widget_OnOffShip:initialize()
  if true == PaGlobal_Widget_OnOffShip._initialize or nil == Panel_Widget_OnOffShip then
    return
  end
  self._ui.btn_rideOn = UI.getChildControl(Panel_Widget_OnOffShip, "Button_RideOn")
  self._ui.btn_approach = UI.getChildControl(Panel_Widget_OnOffShip, "Button_Approach")
  self._ui.stc_desc = UI.getChildControl(Panel_Widget_OnOffShip, "StaticText_Desc")
  self._originPosY = Panel_Widget_OnOffShip:GetPosY()
  self._originSizeY = Panel_Widget_OnOffShip:GetSizeY()
  self._originApproachBtnPosY = self._ui.btn_approach:GetPosY()
  PaGlobal_Widget_OnOffShip:validate()
  PaGlobal_Widget_OnOffShip:registEventHandler()
  FromClient_SetOnOffShip()
  PaGlobal_Widget_OnOffShip._initialize = true
end
function PaGlobal_Widget_OnOffShip:validate()
  if nil == Panel_Widget_OnOffShip then
    return
  end
  self._ui.btn_rideOn:isValidate()
  self._ui.btn_approach:isValidate()
  self._ui.stc_desc:isValidate()
end
function PaGlobal_Widget_OnOffShip:registEventHandler()
  if nil == Panel_Widget_OnOffShip then
    return
  end
  registerEvent("FromClient_SetMoveWharfNpc", "FromClient_SetOnOffShip")
  registerEvent("FromClient_SetAutoRideShip", "FromClient_SetOnOffShip")
end
function PaGlobal_Widget_OnOffShip:open()
  if nil == Panel_Widget_OnOffShip then
    return
  end
  Panel_Widget_OnOffShip:SetShow(true)
end
function PaGlobal_Widget_OnOffShip:close()
  if nil == Panel_Widget_OnOffShip then
    return
  end
  Panel_Widget_OnOffShip:SetShow(false)
end
function FromClient_SetOnOffShip()
  if nil == Panel_Widget_OnOffShip then
    return
  end
  local self = PaGlobal_Widget_OnOffShip
  local selfProxy = getSelfPlayer()
  local isMoveWharfNpc = false
  local isAutoRideShip = false
  if selfProxy ~= nil then
    isMoveWharfNpc = selfProxy:get():isMoveWharfNpc()
    isAutoRideShip = selfProxy:get():isAutoRideShip()
  end
  if isMoveWharfNpc == false and isAutoRideShip == false then
    self:close()
    return
  end
  self:open()
  self._ui.btn_approach:SetShow(isMoveWharfNpc)
  self._ui.btn_rideOn:SetShow(isAutoRideShip)
  if self._ui.btn_rideOn:GetShow() == false then
    Panel_Widget_OnOffShip:SetSize(Panel_Widget_OnOffShip:GetSizeX(), self._originSizeY - self._ui.btn_rideOn:GetSizeY())
    Panel_Widget_OnOffShip:SetPosY(self._originPosY + self._ui.btn_rideOn:GetSizeY())
    self._ui.btn_approach:SetPosY(self._ui.btn_rideOn:SetPosY())
  else
    Panel_Widget_OnOffShip:SetSize(Panel_Widget_OnOffShip:GetSizeX(), self._originSizeY)
    Panel_Widget_OnOffShip:SetPosY(self._originPosY)
    self._ui.btn_approach:SetPosY(self._originApproachBtnPosY)
  end
  self._ui.stc_desc:SetPosY(self._ui.btn_approach:GetPosY() + self._ui.btn_approach:GetSizeY() + 10)
end
