function PaGlobal_AutoMove_Result_All:initialize()
  if PaGlobal_AutoMove_Result_All._initialize == true then
    return
  end
  self._ui._stc_topGroup = UI.getChildControl(Panel_AutoMove_Result_All, "Static_TopGroup")
  self._ui._stc_topGroup_stc_deco = UI.getChildControl(self._ui._stc_topGroup, "Static_Deco")
  self._ui._stc_topGroup_txt_title = UI.getChildControl(self._ui._stc_topGroup, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_topGroup, "Button_Close")
  self._ui._stc_contentGroup = UI.getChildControl(Panel_AutoMove_Result_All, "Static_ContentGroup")
  self._ui._frame_autoMove = UI.getChildControl(self._ui._stc_contentGroup, "Frame_TotalReward")
  self._ui._frame_content = UI.getChildControl(self._ui._frame_autoMove, "Frame_1_Content")
  self._ui._frame_content_stc_group = UI.getChildControl(self._ui._frame_content, "Static_Group")
  self._ui._frame_content_stc_group_txt_groupTitle = UI.getChildControl(self._ui._frame_content_stc_group, "StaticText_GroupTitle")
  self._ui._frame_content_stc_group_txt_groupTitle_stc_1 = UI.getChildControl(self._ui._frame_content_stc_group_txt_groupTitle, "Static_1")
  self._ui._frame_content_stc_group_stc_itemSlotBg = UI.getChildControl(self._ui._frame_content_stc_group, "Static_ItemSlotBg")
  self._ui._frame_content_verticalScroll = UI.getChildControl(self._ui._frame_autoMove, "Frame_1_VerticalScroll")
  self._ui._frame_content_verticalScroll_btn_frame_1_verticalScroll_upButton = UI.getChildControl(self._ui._frame_content_verticalScroll, "Frame_1_VerticalScroll_UpButton")
  self._ui._frame_content_verticalScroll_btn_frame_1_verticalScroll_downButton = UI.getChildControl(self._ui._frame_content_verticalScroll, "Frame_1_VerticalScroll_DownButton")
  self._ui._frame_content_verticalScroll_ctrlButton = UI.getChildControl(self._ui._frame_content_verticalScroll, "Frame_1_VerticalScroll_CtrlButton")
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll = UI.getChildControl(self._ui._frame_autoMove, "Frame_1_HorizontalScroll")
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_upButton = UI.getChildControl(self._ui._frame_autoMove_scroll_frame_1_horizontalScroll, "Frame_1_HorizontalScroll_UpButton")
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_downButton = UI.getChildControl(self._ui._frame_autoMove_scroll_frame_1_horizontalScroll, "Frame_1_HorizontalScroll_DownButton")
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_ctrlButton = UI.getChildControl(self._ui._frame_autoMove_scroll_frame_1_horizontalScroll, "Frame_1_HorizontalScroll_CtrlButton")
  self._ui._stc_functionButton = UI.getChildControl(Panel_AutoMove_Result_All, "Static_FunctionButton")
  self._ui._btn_autoMove = UI.getChildControl(self._ui._stc_functionButton, "Button_AutoMove")
  self._ui._stc_desc = UI.getChildControl(Panel_AutoMove_Result_All, "Static_Desc")
  self._ui._stc_desc_txt_desc = UI.getChildControl(self._ui._stc_desc, "StaticText_Desc")
  self._ui._stc_key_guide_consoleUI = UI.getChildControl(Panel_AutoMove_Result_All, "Static_Key_Guide_ConsoleUI")
  self._ui._stc_key_guide_consoleUI_txt_coin_consoleUI = UI.getChildControl(self._ui._stc_key_guide_consoleUI, "StaticText_Coin_ConsoleUI")
  self._ui._stc_key_guide_consoleUI_txt_close_consoleUI = UI.getChildControl(self._ui._stc_key_guide_consoleUI, "StaticText_Close_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._COL_SLOT_COUNT = math.floor(self._ui._frame_content:GetSizeX() / (self._ICON_SIZE + 10))
  self._CONTENT_FRAME_SIZE_Y = self._ui._frame_content:GetSizeY()
  PaGlobal_AutoMove_Result_All:registEventHandler()
  PaGlobal_AutoMove_Result_All:validate()
  self._ui._frame_content_stc_group_txt_groupTitle:SetShow(false)
  self._ui._frame_content_stc_group_stc_itemSlotBg:SetShow(false)
  self._ui._stc_desc_txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_desc_txt_desc:SetText(self._ui._stc_desc_txt_desc:GetText())
  local diff = self._ui._stc_desc:GetSizeY() - (self._ui._stc_desc_txt_desc:GetTextSizeY() + 20)
  self._ui._stc_desc:SetSize(self._ui._stc_desc:GetSizeX(), self._ui._stc_desc_txt_desc:GetTextSizeY() + 20)
  Panel_AutoMove_Result_All:SetSize(Panel_AutoMove_Result_All:GetSizeX(), Panel_AutoMove_Result_All:GetSizeY() - diff)
  self._ui._stc_key_guide_consoleUI:SetShow(_ContentsGroup_UsePadSnapping)
  if self._isConsole == true then
    self._ui._stc_functionButton:SetShow(false)
    self._ui._stc_desc:SetPosY(self._ui._stc_topGroup:GetSizeY() + self._ui._stc_contentGroup:GetSizeY() + 20)
    Panel_AutoMove_Result_All:SetSize(Panel_AutoMove_Result_All:GetSizeX(), self._ui._stc_topGroup:GetSizeY() + self._ui._stc_contentGroup:GetSizeY() + self._ui._stc_desc:GetSizeY() + 40)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui._stc_key_guide_consoleUI_txt_coin_consoleUI,
      self._ui._stc_key_guide_consoleUI_txt_close_consoleUI
    }, self._ui._stc_key_guide_consoleUI, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui._stc_key_guide_consoleUI:SetPosY(Panel_AutoMove_Result_All:GetSizeY())
  end
  PaGlobal_AutoMove_Result_All._initialize = true
end
function PaGlobal_AutoMove_Result_All:registEventHandler()
  if Panel_AutoMove_Result_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_AutoMove_Result_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ClickAutoMove()")
  else
    self._ui._btn_autoMove:addInputEvent("Mouse_LUp", "HandleEventLUp_ClickAutoMove()")
    self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ClickClose()")
  end
end
function PaGlobal_AutoMove_Result_All:prepareOpen(isCurrentWarehouse)
  if Panel_AutoMove_Result_All == nil then
    return
  end
  PaGlobal_AutoMove_Result_All._isCurrentWarehouse = isCurrentWarehouse
  if self._isConsole == true then
    Panel_AutoMove_Result_All:SetPosX(Panel_Window_Warehouse:GetPosX() + Panel_Window_Warehouse:GetSizeX() / 1.5 - Panel_AutoMove_Result_All:GetSizeX() / 1.5)
    Panel_AutoMove_Result_All:ignorePadSnapMoveToOtherPanel()
  elseif Panel_Window_Inventory_All ~= nil then
    Panel_AutoMove_Result_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_AutoMove_Result_All:GetSizeX() - 5)
    Panel_AutoMove_Result_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
  end
  if PaGlobal_NumberPad_All_GetShow ~= nil and Panel_NumberPad_Close ~= nil and PaGlobal_NumberPad_All_GetShow() == true then
    Panel_NumberPad_Close()
  end
  PaGlobal_AutoMove_Result_All:update()
end
function PaGlobal_AutoMove_Result_All:open()
  if Panel_AutoMove_Result_All == nil then
    return
  end
  Panel_AutoMove_Result_All:SetShow(true)
end
function PaGlobal_AutoMove_Result_All:prepareClose()
  if Panel_AutoMove_Result_All == nil then
    return
  end
  PaGlobal_AutoMove_Result_All:ResetSlot()
  PaGlobal_AutoMove_Result_All:close()
end
function PaGlobal_AutoMove_Result_All:close()
  if Panel_AutoMove_Result_All == nil then
    return
  end
  Panel_AutoMove_Result_All:SetShow(false)
end
function PaGlobal_AutoMove_Result_All:update()
  if Panel_AutoMove_Result_All == nil then
    return
  end
  PaGlobal_AutoMove_Result_All:Update_SelectRadio(PaGlobal_AutoMove_Result_All._isCurrentWarehouse)
end
function PaGlobal_AutoMove_Result_All:updateAutoMove(isCurrentWarehouse)
  if Panel_AutoMove_Result_All == nil then
    return
  end
  PaGlobal_AutoMove_Result_All:Update_SelectRadio(isCurrentWarehouse)
end
function PaGlobal_AutoMove_Result_All:validate()
  if Panel_AutoMove_Result_All == nil then
    return
  end
  self._ui._stc_topGroup:isValidate()
  self._ui._stc_topGroup_stc_deco:isValidate()
  self._ui._stc_topGroup_txt_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_contentGroup:isValidate()
  self._ui._frame_autoMove:isValidate()
  self._ui._frame_content:isValidate()
  self._ui._frame_content_stc_group:isValidate()
  self._ui._frame_content_stc_group_txt_groupTitle:isValidate()
  self._ui._frame_content_stc_group_txt_groupTitle_stc_1:isValidate()
  self._ui._frame_content_stc_group_stc_itemSlotBg:isValidate()
  self._ui._frame_content_verticalScroll:isValidate()
  self._ui._frame_content_verticalScroll_btn_frame_1_verticalScroll_upButton:isValidate()
  self._ui._frame_content_verticalScroll_btn_frame_1_verticalScroll_downButton:isValidate()
  self._ui._frame_content_verticalScroll_ctrlButton:isValidate()
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll:isValidate()
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_upButton:isValidate()
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_downButton:isValidate()
  self._ui._frame_autoMove_scroll_frame_1_horizontalScroll_btn_frame_1_horizontalScroll_ctrlButton:isValidate()
  self._ui._stc_functionButton:isValidate()
  self._ui._btn_autoMove:isValidate()
  self._ui._stc_desc:isValidate()
  self._ui._stc_desc_txt_desc:isValidate()
  self._ui._stc_key_guide_consoleUI:isValidate()
  self._ui._stc_key_guide_consoleUI_txt_coin_consoleUI:isValidate()
  self._ui._stc_key_guide_consoleUI_txt_close_consoleUI:isValidate()
end
