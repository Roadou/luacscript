PaGlobal_GotoShop_Banner = {
  _ui = {_chk_showToday = nil, _stc_shopBanner = nil},
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobal_GotoShop_Banner")
function FromClient_PaGlobal_GotoShop_Banner()
  PaGlobal_GotoShop_Banner:initialize()
end
function PaGlobal_GotoShop_Banner:initialize()
  self._ui._stc_shopBanner = UI.getChildControl(Panel_Widget_GotoShop_Banner, "Static_ShopBanner")
  self._ui._chk_showToday = UI.getChildControl(self._ui._stc_shopBanner, "CheckButton_1")
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_GotoShop_Banner:registerEvent()
  self._ui._chk_showToday:addInputEvent("Mouse_LUp", "PaGlobal_GotoShop_Banner:saveShowByToday()")
  self._ui._stc_shopBanner:addInputEvent("Mouse_LUp", "PaGlobalFunc_Equipment_ShopBanner_GoToShop()")
end
function PaGlobal_GotoShop_Banner:saveShowByToday()
  local year = ToClient_GetThisYear()
  local month = ToClient_GetThisMonth()
  local day = ToClient_GetToday()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eEquipmentNewbieShopBannerShowToday, year, month, day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
  Panel_Widget_GotoShop_Banner:SetShow(false)
end
function PaGlobal_GotoShop_Banner:showByToday()
  local year = ToClient_GetThisYear()
  local month = ToClient_GetThisMonth()
  local day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eEquipmentNewbieShopBannerShowToday)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if year == savedYear and month == savedMonth and day == savedDay then
      return false
    end
  end
  return true
end
function PaGlobalFunc_Equipment_ShopBanner_Open()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
  if userType ~= 2 then
    return
  end
  if PaGlobal_GotoShop_Banner:showByToday() == false then
    return
  end
  PaGlobal_GotoShop_Banner._ui._chk_showToday:SetCheck(false)
  Panel_Widget_GotoShop_Banner:SetShow(true)
end
function PaGlobalFunc_Equipment_ShopBanner_Close()
  if Panel_Widget_GotoShop_Banner == nil then
    return
  end
  Panel_Widget_GotoShop_Banner:SetShow(false)
end
function PaGlobalFunc_Equipment_ShopBanner_GoToShop()
  InGameShop_Open()
  InGameShop_RadioReset()
  PaGlobal_InGameShop_GoToTab(3)
  InGameShop_TabEvent(3)
  InGameShop_SubTabEvent(3, 1)
end
