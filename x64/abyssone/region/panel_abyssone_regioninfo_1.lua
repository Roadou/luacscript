function PaGlobal_AbyssOneInfo:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_decoLine = UI.getChildControl(Panel_Window_AbyssOneInfo, "Static_DecoLine")
  self._ui._stc_titleText = UI.getChildControl(Panel_Window_AbyssOneInfo, "StaticText_Title")
  self._ui._stc_titleText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_descText = UI.getChildControl(Panel_Window_AbyssOneInfo, "StaticText_Desc")
  self._ui._stc_descText:SetTextMode(__eTextMode_AutoWrap)
  self:registEventHandler()
  self:validate()
  self._initialize = true
  self:prepareOpen()
end
function PaGlobal_AbyssOneInfo:registEventHandler()
  if Panel_Window_AbyssOneInfo == nil then
    return
  end
  registerEvent("FromClient_EnterToInstanceField", "FromClient_SetAbyssOneRegionInfo")
end
function PaGlobal_AbyssOneInfo:validate()
  if Panel_Window_AbyssOneInfo == nil then
    return
  end
  self._ui._stc_decoLine:isValidate()
  self._ui._stc_titleText:isValidate()
  self._ui._stc_descText:isValidate()
end
function PaGlobal_AbyssOneInfo:prepareOpen()
  if Panel_Window_AbyssOneInfo == nil then
    return
  end
  local isSuccess = self:setData()
  if isSuccess == false then
    return
  end
  self:recalcControlSizePos()
  self:open()
end
function PaGlobal_AbyssOneInfo:open()
  if Panel_Window_AbyssOneInfo == nil then
    return
  end
  Panel_Window_AbyssOneInfo:SetShow(true)
end
function PaGlobal_AbyssOneInfo:prepareClose()
  if Panel_Window_AbyssOneInfo == nil then
    return
  end
  self:close()
end
function PaGlobal_AbyssOneInfo:close()
  if Panel_Window_AbyssOneInfo == nil then
    return
  end
  Panel_Window_AbyssOneInfo:SetShow(false)
end
function PaGlobal_AbyssOneInfo:recalcControlSizePos()
  local panel = Panel_Window_AbyssOneInfo
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
function PaGlobal_AbyssOneInfo:setData()
  if Panel_Window_AbyssOneInfo == nil then
    return false
  end
  local currentMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local instanceMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(currentMapKey)
  if instanceMapSSW == nil then
    return false
  end
  local mapNameStrig = PAGetString(Defines.StringSheet_GAME, instanceMapSSW:getFieldNameStringKey())
  if mapNameStrig == nil then
    return false
  end
  local mapDescString = PAGetString(Defines.StringSheet_GAME, instanceMapSSW:getFieldDescStringKey())
  if mapDescString == nil then
    return false
  end
  self._ui._stc_titleText:SetText(mapNameStrig)
  self._ui._stc_descText:SetText(mapDescString)
  return true
end
