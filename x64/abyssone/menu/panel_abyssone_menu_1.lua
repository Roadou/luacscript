function PaGlobal_AbyssOneMenu:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local btnBg = UI.getChildControl(Panel_Menu_AbyssOne, "Static_BTN_BG")
  self._ui._btn_openEquip = UI.getChildControl(btnBg, "Button_Inventory")
  self._ui._btn_returnMagnus = UI.getChildControl(btnBg, "Button_Recall")
  self._ui._btn_exit = UI.getChildControl(btnBg, "Button_Exit")
  self._ui._btn_retry = UI.getChildControl(btnBg, "Button_Retry")
  self._ui._btn_ringMenu = UI.getChildControl(btnBg, "Button_RingMenu_ConsoleUI")
  self._ui._btn_gameOption = UI.getChildControl(btnBg, "Button_Option")
  self._ui._btn_trayMode = UI.getChildControl(btnBg, "Button_Tray")
  self._ui._btn_gameExit = UI.getChildControl(btnBg, "Button_GameExit")
  self._ui._stc_keyGuide_A = UI.getChildControl(btnBg, "Static_SelectButton_Console")
  self._ui._btn_ringMenu:SetShow(self._isConsole)
  self._ui._stc_keyGuide_A:SetShow(self._isConsole)
  self:initControlPos()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_AbyssOneMenu:initControlPos()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  local pivotY = 0
  if self._ui._btn_ringMenu:GetShow() == true then
    pivotY = self._ui._btn_ringMenu:GetSpanSize().y
  elseif self._ui._btn_retry:GetShow() == true then
    pivotY = self._ui._btn_retry:GetSpanSize().y
  elseif self._ui._btn_exit:GetShow() == true then
    pivotY = self._ui._btn_exit:GetSpanSize().y
  elseif self._ui._btn_returnMagnus:GetShow() == true then
    pivotY = self._ui._btn_returnMagnus:GetSpanSize().y
  elseif self._ui._btn_openEquip:GetShow() == true then
    pivotY = self._ui._btn_openEquip:GetSpanSize().y
  else
    return
  end
  local btnBg = UI.getChildControl(Panel_Menu_AbyssOne, "Static_BTN_BG")
  local stc_line = UI.getChildControl(btnBg, "Static_Line")
  stc_line:SetSpanSize(stc_line:GetSpanSize().x, pivotY + 100)
  self._ui._btn_gameOption:SetSpanSize(self._ui._btn_gameOption:GetSpanSize().x, stc_line:GetSpanSize().y + 35)
  self._ui._btn_trayMode:SetSpanSize(self._ui._btn_trayMode:GetSpanSize().x, self._ui._btn_gameOption:GetSpanSize().y + 50)
  self._ui._btn_gameExit:SetSpanSize(self._ui._btn_gameExit:GetSpanSize().x, self._ui._btn_trayMode:GetSpanSize().y + 50)
  self._ui._btn_trayMode:SetShow(_ContentsGroup_RenewUI == false)
  if _ContentsGroup_RenewUI == false then
    self._ui._btn_trayMode:SetSpanSize(self._ui._btn_trayMode:GetSpanSize().x, self._ui._btn_gameOption:GetSpanSize().y + 50)
    self._ui._btn_gameExit:SetSpanSize(self._ui._btn_gameExit:GetSpanSize().x, self._ui._btn_trayMode:GetSpanSize().y + 50)
  else
    self._ui._btn_gameExit:SetSpanSize(self._ui._btn_gameExit:GetSpanSize().x, self._ui._btn_gameOption:GetSpanSize().y + 50)
  end
end
function PaGlobal_AbyssOneMenu:registEventHandler()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  self._ui._btn_openEquip:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._OPEN_EQUIP) .. ")")
  self._ui._btn_returnMagnus:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._RETURN_MAGNUS) .. ")")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._EXIT_ABYSSONE) .. ")")
  self._ui._btn_retry:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._RETRY) .. ")")
  self._ui._btn_gameOption:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._OPEN_GAMEOPTION) .. ")")
  self._ui._btn_trayMode:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._TRAY_MODE) .. ")")
  self._ui._btn_gameExit:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._EXIT_GAME) .. ")")
  if self._isConsole == true then
    self._ui._btn_ringMenu:addInputEvent("Mouse_LUp", "HandleEventLUp_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._RINGMENU_SETTING) .. ")")
    self._ui._btn_openEquip:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._OPEN_EQUIP) .. ")")
    self._ui._btn_returnMagnus:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._RETURN_MAGNUS) .. ")")
    self._ui._btn_exit:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._EXIT_ABYSSONE) .. ")")
    self._ui._btn_retry:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._RETRY) .. ")")
    self._ui._btn_ringMenu:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._RINGMENU_SETTING) .. ")")
    self._ui._btn_gameOption:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._OPEN_GAMEOPTION) .. ")")
    self._ui._btn_trayMode:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._TRAY_MODE) .. ")")
    self._ui._btn_gameExit:addInputEvent("Mouse_On", "HandleEventLOn_AbyssOne_Menu(" .. tostring(self._BTN_TYPE._EXIT_GAME) .. ")")
    Panel_Menu_AbyssOne:ignorePadSnapMoveToOtherPanel()
  end
  Panel_Menu_AbyssOne:RegisterShowEventFunc(true, "Panel_Menu_AbyssOne_ShowAni()")
  Panel_Menu_AbyssOne:RegisterShowEventFunc(false, "Panel_Menu_AbyssOne_HideAni()")
  registerEvent("EventGameWindowClose", "FromClient_AbyssOneMenu_Exit")
  registerEvent("FromClient_PlayCutScene", "FromClient_AbyssOneMenu_Close")
end
function PaGlobal_AbyssOneMenu:validate()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  self._ui._btn_openEquip:isValidate()
  self._ui._btn_returnMagnus:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._btn_retry:isValidate()
  self._ui._btn_ringMenu:isValidate()
  self._ui._btn_gameOption:isValidate()
  self._ui._btn_trayMode:isValidate()
  self._ui._btn_gameExit:isValidate()
end
function PaGlobal_AbyssOneMenu:prepareOpen()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  self:recalcPanelSize()
  self:open()
end
function PaGlobal_AbyssOneMenu:open()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  Panel_Menu_AbyssOne:SetShow(true, true)
end
function PaGlobal_AbyssOneMenu:prepareClose()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  self:close()
end
function PaGlobal_AbyssOneMenu:close()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  Panel_Menu_AbyssOne:SetShow(false, true)
end
function PaGlobal_AbyssOneMenu:recalcPanelSize()
  if Panel_Menu_AbyssOne == nil then
    return
  end
  local screenY = getScreenSizeY()
  Panel_Menu_AbyssOne:SetPosX(0)
  Panel_Menu_AbyssOne:SetPosY(0)
  Panel_Menu_AbyssOne:SetSize(Panel_Menu_AbyssOne:GetSizeX(), screenY)
  Panel_Menu_AbyssOne:ComputePosAllChild()
end
