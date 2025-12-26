function PaGlobal_DropItemImageToolTip_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._txt_name = UI.getChildControl(Panel_Window_DropItem_ImageTooltip_All, "Tooltip_Name")
  self._ui._txt_desc = UI.getChildControl(Panel_Window_DropItem_ImageTooltip_All, "Tooltip_Description")
  self._ui._stc_line = UI.getChildControl(Panel_Window_DropItem_ImageTooltip_All, "Static_Line")
  self._ui._stc_image = UI.getChildControl(Panel_Window_DropItem_ImageTooltip_All, "Static_Image")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_DropItemImageToolTip_All:registEventHandler()
  if Panel_Window_DropItem_ImageTooltip_All == nil then
    return
  end
end
function PaGlobal_DropItemImageToolTip_All:validate()
  if Panel_Window_DropItem_ImageTooltip_All == nil then
    return
  end
  self._ui._txt_name:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._stc_line:isValidate()
  self._ui._stc_image:isValidate()
end
function PaGlobal_DropItemImageToolTip_All:prepareOpen(name, desc, textureId)
  if Panel_Window_DropItem_ImageTooltip_All == nil then
    return
  end
  if name == nil or name == "" then
    UI.ASSERT_NAME(false, "Name \234\176\146\236\157\180 \235\185\132\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if desc == nil or desc == "" then
    UI.ASSERT_NAME(false, "Desc \234\176\146\236\157\180 \235\185\132\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if textureId == nil or textureId == "" then
    UI.ASSERT_NAME(false, "TextureId \234\176\146\236\157\180 \235\185\132\236\150\180\236\158\136\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._ui._stc_image:ChangeTextureInfoAndSizeByTextureIDKey(textureId, 0, true)
  self._ui._stc_image:setRenderTexture(self._ui._stc_image:getBaseTexture())
  self._ui._txt_name:SetSize(self._ui._stc_image:GetSizeX() + 5, self._ui._txt_name:GetSizeY())
  self._ui._txt_name:SetText(name)
  self._ui._txt_name:SetSize(self._ui._txt_name:GetSizeX(), self._ui._txt_name:GetTextSizeY())
  self._ui._stc_line:SetSize(self._ui._stc_image:GetSizeX() + 0, self._ui._stc_line:GetSizeY())
  self._ui._txt_desc:SetSize(self._ui._stc_image:GetSizeX() + 5, self._ui._txt_desc:GetSizeY())
  self._ui._txt_desc:SetText(desc)
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._ui._txt_desc:GetTextSizeY())
  self._ui._txt_name:SetSpanSize(5, 10)
  self._ui._stc_line:SetSpanSize(0, self._ui._txt_name:GetSpanSize().y + self._ui._txt_name:GetSizeY() + 5)
  self._ui._txt_desc:SetSpanSize(5, self._ui._stc_line:GetSpanSize().y + self._ui._stc_line:GetSizeY() + 5)
  self._ui._stc_image:SetSpanSize(0, self._ui._txt_desc:GetSpanSize().y + self._ui._txt_desc:GetSizeY() + 10)
  local newPanelSizeX = self._ui._stc_image:GetSizeX() + 20
  local newPanelSizeY = self._ui._stc_image:GetSpanSize().y + self._ui._stc_image:GetSizeY() + 10
  Panel_Window_DropItem_ImageTooltip_All:SetSize(newPanelSizeX, newPanelSizeY)
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  Panel_Window_DropItem_ImageTooltip_All:SetPosX(mousePosX + 15)
  Panel_Window_DropItem_ImageTooltip_All:SetPosY(mousePosY + 15)
  if screenSizeX < Panel_Window_DropItem_ImageTooltip_All:GetPosX() + Panel_Window_DropItem_ImageTooltip_All:GetSizeX() then
    Panel_Window_DropItem_ImageTooltip_All:SetPosX(mousePosX - Panel_Window_DropItem_ImageTooltip_All:GetSizeX())
  else
    Panel_Window_DropItem_ImageTooltip_All:SetPosX(mousePosX + 15)
  end
  if screenSizeY < Panel_Window_DropItem_ImageTooltip_All:GetPosY() + Panel_Window_DropItem_ImageTooltip_All:GetSizeY() then
    Panel_Window_DropItem_ImageTooltip_All:SetPosY(mousePosY - Panel_Window_DropItem_ImageTooltip_All:GetSizeY())
  else
    Panel_Window_DropItem_ImageTooltip_All:SetPosY(mousePosY + 15)
  end
  Panel_Window_DropItem_ImageTooltip_All:ComputePosAllChild()
  self:open()
end
function PaGlobal_DropItemImageToolTip_All:open()
  if Panel_Window_DropItem_ImageTooltip_All == nil then
    return
  end
  Panel_Window_DropItem_ImageTooltip_All:SetShow(true)
end
function PaGlobal_DropItemImageToolTip_All:prepareClose()
  if Panel_Window_DropItem_ImageTooltip_All == nil then
    return
  end
  self:close()
end
function PaGlobal_DropItemImageToolTip_All:close()
  if Panel_Window_DropItem_ImageTooltip_All == nil then
    return
  end
  Panel_Window_DropItem_ImageTooltip_All:SetShow(false)
end
