function PaGlobal_GuildPointMenu_All:initialize()
  if PaGlobal_GuildPointMenu_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.btn_Management = UI.getChildControl(Panel_Window_GuildPointMenu_All, "Button_Management")
  self._ui.btn_SendAll = UI.getChildControl(Panel_Window_GuildPointMenu_All, "Button_SendAll")
  self._ui.btn_Option = UI.getChildControl(Panel_Window_GuildPointMenu_All, "Button_Option")
  local KeyGuide1 = UI.getChildControl(self._ui.btn_Management, "StaticText_A_ConsoleUI")
  local KeyGuide2 = UI.getChildControl(self._ui.btn_SendAll, "StaticText_A_ConsoleUI")
  local KeyGuide3 = UI.getChildControl(self._ui.btn_Option, "StaticText_A_ConsoleUI")
  KeyGuide1:SetShow(self._isConsole)
  KeyGuide2:SetShow(self._isConsole)
  KeyGuide3:SetShow(self._isConsole)
  self._ui_pc.btn_Close = UI.getChildControl(Panel_Window_GuildPointMenu_All, "Button_Close")
  self._ui_pc.btn_Close:SetShow(not self._isConsole)
  PaGlobal_GuildPointMenu_All:registEventHandler()
  PaGlobal_GuildPointMenu_All:validate()
  PaGlobal_GuildPointMenu_All._initialize = true
end
function PaGlobal_GuildPointMenu_All:registEventHandler()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  self._ui.btn_Management:addInputEvent("Mouse_LUp", "PaGlobal_GuildDocumentManagement_All_Open()")
  self._ui.btn_SendAll:addInputEvent("Mouse_LUp", "PaGlobal_GuildAttributeReport_All_Open(" .. tostring(-1) .. ")")
  self._ui.btn_Option:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointOption_All_Open()")
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildPointMenu_All_Close()")
end
function PaGlobal_GuildPointMenu_All:prepareOpen()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  PaGlobal_GuildPointMenu_All:open()
end
function PaGlobal_GuildPointMenu_All:open()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  Panel_Window_GuildPointMenu_All:SetShow(true)
end
function PaGlobal_GuildPointMenu_All:prepareClose()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  PaGlobal_GuildPointMenu_All:close()
end
function PaGlobal_GuildPointMenu_All:close()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
  Panel_Window_GuildPointMenu_All:SetShow(false)
end
function PaGlobal_GuildPointMenu_All:update()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
end
function PaGlobal_GuildPointMenu_All:validate()
  if Panel_Window_GuildPointMenu_All == nil then
    return
  end
end
