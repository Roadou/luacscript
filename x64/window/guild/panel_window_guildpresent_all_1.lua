function PaGlobal_GuildPresent_All:initialize()
  if self._initialize == true or Panel_Window_GuildPresent == nil then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local stc_titleArea = UI.getChildControl(Panel_Window_GuildPresent, "Static_GuildPresent_TitleArea")
  self._ui._btn_confirm = UI.getChildControl(Panel_Window_GuildPresent, "Button_GuildUpdate")
  self._ui._pc._btn_close = UI.getChildControl(stc_titleArea, "Button_GuildPresent_Close_PCUI")
  self._ui._pc._btn_question = UI.getChildControl(stc_titleArea, "Button_GuildPresent_Question_PCUI")
  self._ui._pc._btn_question:SetShow(not self._isConsole)
  local stc_contentArea = UI.getChildControl(Panel_Window_GuildPresent, "Static_GuildPresent_ContentArea")
  self._ui._stc_itemSlotGuideText = UI.getChildControl(stc_contentArea, "Static_GuildPresent_MultilineText")
  self._ui._stc_searchBg = UI.getChildControl(stc_contentArea, "Static_GuildPresent_Search_BG")
  self._ui._stc_defaultSearchText = UI.getChildControl(self._ui._stc_searchBg, "StaticText_DefaultSearchText")
  self._ui._edit_memberNameText = UI.getChildControl(self._ui._stc_searchBg, "Edit_SearchText_PCUI_Import")
  local stc_itemSlotFrame = UI.getChildControl(stc_contentArea, "Static_GuildPresent_ItemSlotFrame")
  self._ui._stc_itemSlot = UI.getChildControl(stc_itemSlotFrame, "Static_GuildPresent_ItemSlot")
  self._ui._console._keyGuideBg = UI.getChildControl(Panel_Window_GuildPresent, "Static_KeyGuide_ConsoleUI")
  self._ui._console._txt_keyGuideApply = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui._console._txt_keyGuideClose = UI.getChildControl(self._ui._console._keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui._console._txt_keyGuideInput = UI.getChildControl(self._ui._stc_searchBg, "StaticText_XButton")
  self._ui._edit_memberNameText:SetMaxInput(getGameServiceTypeUserNickNameLength())
  self._ui._stc_itemSlotGuideText:SetShow(false)
  self._ui._stc_itemSlotGuideText:SetTextMode(__eTextMode_AutoWrap)
  if self._isConsole == false then
    self._ui._pc._btn_close:SetShow(true)
    self._ui._btn_confirm:SetShow(true)
    self._ui._console._keyGuideBg:SetShow(false)
    self._ui._console._txt_keyGuideClose:SetShow(false)
    self._ui._console._txt_keyGuideApply:SetShow(false)
    self._ui._console._txt_keyGuideInput:SetShow(false)
  else
    self._ui._pc._btn_close:SetShow(false)
    self._ui._btn_confirm:SetShow(false)
    self._ui._console._keyGuideBg:SetShow(true)
    self._ui._console._txt_keyGuideClose:SetShow(true)
    self._ui._console._txt_keyGuideApply:SetShow(true)
    self._ui._console._txt_keyGuideInput:SetShow(true)
    local keyguides = {
      self._ui._console._txt_keyGuideApply,
      self._ui._console._txt_keyGuideClose
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui._console._keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  PaGlobal_GuildPresent_All:registEventHandler()
  self._initialize = true
end
function PaGlobal_GuildPresent_All:prepareOpen()
  if Panel_Window_GuildPresent == nil or Panel_Window_GuildPresent:GetShow() == true then
    return
  end
  if Panel_Window_Warehouse == nil then
    return
  end
  local posX = Panel_Window_Warehouse:GetPosX() - Panel_Window_GuildPresent:GetSizeX()
  local posY = Panel_Window_Warehouse:GetPosY()
  Panel_Window_GuildPresent:SetPosX(posX)
  Panel_Window_GuildPresent:SetPosY(posY)
  PaGlobal_GuildPresent_All:open()
end
function PaGlobal_GuildPresent_All:open()
  if Panel_Window_GuildPresent == nil then
    return
  end
  Panel_Window_GuildPresent:SetShow(true, true)
end
function PaGlobal_GuildPresent_All:prepareClose()
  if Panel_Window_GuildPresent == nil then
    return
  end
  if Panel_Window_GuildPresent:GetShow() == false then
    return
  end
  PaGlobal_GuildPresent_All:clear()
  PaGlobal_GuildPresent_All:close()
  if Panel_Window_Warehouse:GetShow() == true then
    PaGlobal_WareHouse_All:update()
  end
end
function PaGlobal_GuildPresent_All:close()
  if Panel_Window_GuildPresent == nil then
    return
  end
  Panel_Window_GuildPresent:SetShow(false, false)
end
function PaGlobal_GuildPresent_All:registEventHandler()
  if Panel_Window_GuildPresent == nil then
    return
  end
  if self._isConsole == false then
    self._ui._pc._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildPresent_All_Close()")
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildPresent_All_Confirm()")
    self._ui._stc_itemSlot:addInputEvent("Mouse_RUp", "PaGlobal_GuildPresent_All:popItemSlot()")
    self._ui._edit_memberNameText:addInputEvent("Mouse_LUp", "PaGlobal_GuildPresent_All:clearDefaultMemberName()")
    self._ui._pc._btn_question:addInputEvent("Mouse_LUp", "PaGlobal_GuildPresent_All:showToggleWebHelper()")
  else
    Panel_Window_GuildPresent:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildPresent_InputName_SetFocus()")
    Panel_Window_GuildPresent:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildPresent_All_Confirm()")
  end
end
function PaGlobal_GuildPresent_All:clear()
  if Panel_Window_GuildPresent == nil then
    return
  end
  self._selectedItemKey = -1
  self._ui._stc_itemSlotGuideText:SetShow(false)
  self._ui._stc_itemSlot:SetShow(false)
  self._ui._edit_memberNameText:SetEditText("")
  self._ui._stc_defaultSearchText:SetShow(true)
  ClearFocusEdit()
end
function PaGlobal_GuildPresent_All:pushItemSlot(wareHouseSlotNo)
  if Panel_Window_GuildPresent == nil then
    return
  end
  local warehouseWrapper = PaGlobal_Warehouse_All_GetWarehouseWarpper()
  if warehouseWrapper == nil then
    return
  end
  local itemWrapper = warehouseWrapper:getItem(wareHouseSlotNo)
  if itemWrapper == nil then
    return
  end
  self._selectedItemKey = itemWrapper:getStaticStatus():getItemKey()
  self._ui._stc_itemSlot:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getStaticStatus():getIconPath())
  self._ui._stc_itemSlot:getBaseTexture():setUV(0, 0, 1, 1)
  self._ui._stc_itemSlot:SetShow(true)
  self._ui._stc_itemSlotGuideText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDPRESENT_DESC_UNSELECT", "SelectedItemName", itemWrapper:getStaticStatus():getName()))
  self._ui._stc_itemSlotGuideText:SetShow(true)
  self._selectedItemSlotNo = wareHouseSlotNo
end
function PaGlobal_GuildPresent_All:popItemSlot()
  if Panel_Window_GuildPresent == nil then
    return
  end
  self._selectedItemKey = -1
  self._ui._stc_itemSlot:SetShow(false)
  self._ui._stc_itemSlotGuideText:SetShow(false)
end
function PaGlobal_GuildPresent_All:CreateControl()
end
function PaGlobal_GuildPresent_All:setGuildMemberData()
end
function PaGlobal_GuildPresent_All:clearDefaultMemberName()
  if Panel_Window_GuildPresent == nil then
    return
  end
  if self._ui._stc_defaultSearchText:GetShow() == true then
    self._ui._stc_defaultSearchText:SetShow(false)
  end
end
function PaGlobal_GuildPresent_All:setFocusGuildMemberEdit()
  PaGlobal_GuildPresent_All:clearDefaultMemberName()
  self._ui._edit_memberNameText:SetEditText("")
  SetFocusEdit(self._ui._edit_memberNameText)
end
function PaGlobal_GuildPresent_All:presentItemToGuildMember()
  if Panel_Window_GuildPresent == nil then
    return
  end
  local selectedGuildMemberName = self._ui._edit_memberNameText:GetEditText()
  if selectedGuildMemberName == nil then
    return
  end
  ToClient_PresentItemToGuildMember(selectedGuildMemberName, ItemEnchantKey(self._selectedItemKey), self._selectedItemSlotNo)
end
function PaGlobal_GuildPresent_All:showToggleWebHelper()
  if Panel_Window_GuildPresent == nil then
    return
  end
  Panel_WebHelper_ShowToggle("GuildPresent")
end
