function PaGlobal_IngameCashShop_Desc:initialize()
  if true == PaGlobal_IngameCashShop_Desc._initialize then
    return
  end
  local bg = UI.getChildControl(Panel_IngameCashShop_Desc, "Static_DescEdge_Import")
  self._ui._txt_desc = UI.getChildControl(bg, "StaticText_Desc")
  self._ui._stc_keyGuide = UI.getChildControl(Panel_IngameCashShop_Desc, "Static_KeyGuide_Console")
  local titleArea = UI.getChildControl(Panel_IngameCashShop_Desc, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleArea, "Button_Close")
  self._ui._btn_confirm = UI.getChildControl(Panel_IngameCashShop_Desc, "Button_Confirm")
  self:registEventHandler()
  self:validate()
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_INGAMECASHSHOP_IMPOSSIBLE_CANCEL"))
  local gabY = self._ui._txt_desc:GetTextSizeY() - self._ui._txt_desc:GetSizeY()
  if gabY > 0 then
    Panel_IngameCashShop_Desc:SetSize(Panel_IngameCashShop_Desc:GetSizeX(), Panel_IngameCashShop_Desc:GetSizeY() + gabY)
    bg:SetSize(bg:GetSizeX(), bg:GetSizeY() + gabY)
  end
  self._ui._btn_confirm:ComputePos()
  self._ui._btn_confirm:SetShow(not _ContentsGroup_RenewUI)
  self._ui._btn_close:SetShow(not _ContentsGroup_RenewUI)
  if true == _ContentsGroup_RenewUI then
    Panel_IngameCashShop_Desc:SetSize(Panel_IngameCashShop_Desc:GetSizeX(), Panel_IngameCashShop_Desc:GetSizeY() - self._ui._btn_confirm:GetSizeY())
  end
  self._ui._stc_keyGuide:ComputePos()
  self._ui._stc_keyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  local key = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_Close_ConsoleUI")
  key:SetSpanSize(key:GetTextSizeX() + 30, key:GetSpanSize().y)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_IngameCashShop_Desc:ignorePadSnapMoveToOtherPanel()
  end
  self._initialize = true
end
function PaGlobal_IngameCashShop_Desc:registEventHandler()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_IngameCashShop_DescClose()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_IngameCashShop_DescClose()")
end
function PaGlobal_IngameCashShop_Desc:prepareOpen()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_IngameCashShop_Desc:recalcPanelPosition()
  if Panel_IngameCashShop_Desc == nil then
    return
  end
  local panel = Panel_IngameCashShop_Desc
  local screenCenterX = getScreenSizeX() / 2
  local screenCenterY = getScreenSizeY() / 2
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local calcPosX = screenCenterX - panelSizeX / 2
  local calcPosY = screenCenterY - panelSizeY / 2
  if _ContentsGroup_RenewUI == true then
    calcPosX = screenCenterX + 10
  end
  if calcPosX < 0 then
    calcPosX = 0
  elseif calcPosX > getScreenSizeX() - panelSizeX then
    local gap = calcPosX - (getScreenSizeX() - panelSizeX)
    calcPosX = calcPosX - gap - 10
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
end
function PaGlobal_IngameCashShop_Desc:open()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  Panel_IngameCashShop_Desc:SetShow(true)
end
function PaGlobal_IngameCashShop_Desc:prepareClose()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  self:close()
end
function PaGlobal_IngameCashShop_Desc:close()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  Panel_IngameCashShop_Desc:SetShow(false)
end
function PaGlobal_IngameCashShop_Desc:validate()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
end
