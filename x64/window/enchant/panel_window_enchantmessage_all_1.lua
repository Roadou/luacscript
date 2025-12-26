function PaGlobal_EnchantMessage_All:initialize()
  if Panel_Window_EnchantMessage_All == nil or PaGlobal_EnchantMessage_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnchantMessage_All:controlInit()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
  self._ui.stc_nakMessage = UI.getChildControl(Panel_Window_EnchantMessage_All, "StaticText_NakMessage")
end
function PaGlobal_EnchantMessage_All:prepareOpen()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
  PaGlobal_EnchantMessage_All:open()
end
function PaGlobal_EnchantMessage_All:open()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
  Panel_Window_EnchantMessage_All:SetShow(true)
end
function PaGlobal_EnchantMessage_All:prepareClose()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
  PaGlobal_EnchantMessage_All:close()
end
function PaGlobal_EnchantMessage_All:close()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
  Panel_Window_EnchantMessage_All:SetShow(false)
end
function PaGlobal_EnchantMessage_All:registEventHandler()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
end
function PaGlobal_EnchantMessage_All:validate()
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
end
function PaGlobal_EnchantMessage_All:showNakMessage(message)
  if nil == Panel_Window_EnchantMessage_All then
    return
  end
  self:prepareOpen()
  self._ui.stc_nakMessage:SetText(message)
end
