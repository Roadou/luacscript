PaGlobal_Common_Description = {
  _ui = {
    _stc_title = nil,
    _stc_titleExit = nil,
    _frame_desc = nil,
    _frame_content = nil,
    _frame_stc_text = nil,
    _stc_close = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Common_DescriptionInit")
registerEvent("FromClient_luaLoadCompleteLateUdpate", "FromClient_Common_DescriptionInit")
function FromClient_Common_DescriptionInit()
  PaGlobal_Common_Description:initialize()
end
function PaGlobal_Common_Description:initialize()
  local frame_import_import = UI.getChildControl(Panel_Window_Common_Description, "Static_TitleArea_Import_Import")
  self._ui._stc_title = UI.getChildControl(frame_import_import, "StaticText_Title")
  self._ui._stc_titleExit = UI.getChildControl(frame_import_import, "Button_Close")
  self._ui._frame_desc = UI.getChildControl(Panel_Window_Common_Description, "Frame_Desc")
  self._ui._frame_content = UI.getChildControl(self._ui._frame_desc, "Frame_1_Content")
  self._ui._frame_stc_text = UI.getChildControl(self._ui._frame_content, "StaticText_1")
  self._ui._stc_close = UI.getChildControl(Panel_Window_Common_Description, "Button_Exit")
  self._ui._stc_title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AGE_INFO_TITLE"))
  self._ui._frame_stc_text:SetTextMode(__eTextMode_AutoWrap)
  self._ui._frame_stc_text:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AGE_INFO_DESC"))
  self._ui._frame_stc_text:SetSize(self._ui._frame_stc_text:GetSizeX(), self._ui._frame_stc_text:GetTextSizeY())
  self._ui._frame_content:SetSize(self._ui._frame_content:GetSizeX(), self._ui._frame_stc_text:GetSizeY() + 20)
  self._ui._stc_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Common_Description_Close()")
  self._ui._stc_titleExit:addInputEvent("Mouse_LUp", "PaGlobalFunc_Common_Description_Close()")
  local frameVScroll = self._ui._frame_desc:GetVScroll()
  if frameVScroll ~= nil then
    frameVScroll:SetControlPos(0)
    self._ui._frame_desc:UpdateContentPos()
  end
  if self._ui._frame_desc:GetSizeY() < self._ui._frame_stc_text:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
end
function PaGlobal_Common_Description:open()
  Panel_Window_Common_Description:SetShow(true)
end
function PaGlobal_Common_Description:prepareOpen()
  self:open()
end
function PaGlobal_Common_Description:close()
  Panel_Window_Common_Description:SetShow(false)
end
function PaGlobal_Common_Description:prepareClose()
  self:close()
end
function PaGlobalFunc_Common_Description_Open()
  PaGlobal_Common_Description:prepareOpen()
end
function PaGlobalFunc_Common_Description_Close()
  PaGlobal_Common_Description:prepareClose()
end
