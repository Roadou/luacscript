function PaGlobal_MyInstruments_All_Open()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:prepareOpen()
end
function PaGlobal_MyInstruments_All_Close()
  if nil == Panel_Window_MyInstruments_All then
    return
  end
  PaGlobal_MyInstruments_All:prepareClose()
end
function PaGlobal_MyInstruments_All_Update()
end
function HandleEventOnOut_MyInstruments_Show(itemKey)
  if nil == itemKey then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemSSW == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, Panel_Window_MyInstruments_All, true)
end
