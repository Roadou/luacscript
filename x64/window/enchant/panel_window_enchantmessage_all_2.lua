function PaGlobalFunc_EnchantMessage_All_Open()
  if Panel_Window_EnchantMessage_All == nil or Panel_Window_EnchantMessage_All:GetShow() == true then
    return
  end
  PaGlobal_EnchantMessage_All:prepareOpen()
end
function PaGlobalFunc_EnchantMessage_All_Close()
  if Panel_Window_EnchantMessage_All == nil or Panel_Window_EnchantMessage_All:GetShow() == false then
    return
  end
  PaGlobal_EnchantMessage_All:prepareClose()
end
function PaGlobalFunc_EnchantMessage_All_ShowNakMessage(message)
  if Panel_Window_EnchantMessage_All == nil then
    return
  end
  PaGlobal_EnchantMessage_All:prepareOpen()
  PaGlobal_EnchantMessage_All:showNakMessage(message)
end
