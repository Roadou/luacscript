function PaGlobal_Atoraxion_RegionInfo:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_decoLine = UI.getChildControl(Panel_Window_AtoraxionInfo, "Static_DecoLine")
  self._ui._stc_titleText = UI.getChildControl(Panel_Window_AtoraxionInfo, "StaticText_Title")
  self._ui._stc_titleText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_descText = UI.getChildControl(Panel_Window_AtoraxionInfo, "StaticText_Desc")
  self._ui._stc_descText:SetTextMode(__eTextMode_AutoWrap)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Atoraxion_RegionInfo:registEventHandler()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
end
function PaGlobal_Atoraxion_RegionInfo:validate()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  self._ui._stc_decoLine:isValidate()
  self._ui._stc_titleText:isValidate()
  self._ui._stc_descText:isValidate()
end
function PaGlobal_Atoraxion_RegionInfo:prepareOpen()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  self:recalcControlSizePos()
  self:open()
end
function PaGlobal_Atoraxion_RegionInfo:open()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  Panel_Window_AtoraxionInfo:SetShow(true)
end
function PaGlobal_Atoraxion_RegionInfo:prepareClose()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  self:close()
end
function PaGlobal_Atoraxion_RegionInfo:close()
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  Panel_Window_AtoraxionInfo:SetShow(false)
end
function PaGlobal_Atoraxion_RegionInfo:recalcControlSizePos()
  local panel = Panel_Window_AtoraxionInfo
  if panel == nil then
    return
  end
  local panelSizeX = 0
  self._ui._stc_titleText:SetSize(self._ui._stc_titleText:GetSizeX(), self._ui._stc_titleText:GetTextSizeY())
  self._ui._stc_titleText:SetSpanSize(self._ui._stc_titleText:GetSpanSize().x, self._ui._stc_titleText:GetSpanSize().y)
  if panelSizeX < self._ui._stc_titleText:GetSizeX() then
    panelSizeX = self._ui._stc_titleText:GetSizeX() + self._ui._stc_titleText:GetSpanSize().x
  end
  self._ui._stc_decoLine:SetSpanSize(self._ui._stc_decoLine:GetSpanSize().x, self._ui._stc_titleText:GetSizeY() + self._ui._stc_titleText:GetSpanSize().y)
  if panelSizeX < self._ui._stc_decoLine:GetSizeX() then
    panelSizeX = self._ui._stc_decoLine:GetSizeX() + self._ui._stc_decoLine:GetSpanSize().x
  end
  self._ui._stc_descText:SetSize(self._ui._stc_descText:GetSizeX(), self._ui._stc_descText:GetTextSizeY())
  self._ui._stc_descText:SetSpanSize(self._ui._stc_descText:GetSpanSize().x, self._ui._stc_decoLine:GetSizeY() + self._ui._stc_decoLine:GetSpanSize().y + 5)
  if panelSizeX < self._ui._stc_descText:GetSizeX() then
    panelSizeX = self._ui._stc_descText:GetSizeX() + self._ui._stc_descText:GetSpanSize().x
  end
  panel:SetSize(panelSizeX + 10, self._ui._stc_descText:GetSizeY() + self._ui._stc_descText:GetSpanSize().y + 10)
  panel:ComputePosAllChild()
end
function PaGlobal_Atoraxion_RegionInfo:setData(areaName, regionKey)
  if Panel_Window_AtoraxionInfo == nil then
    return
  end
  self._ui._stc_titleText:SetText(areaName)
  self._ui._stc_descText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATORAXXION_INFO_DESC_" .. tostring(regionKey)))
  return
end
