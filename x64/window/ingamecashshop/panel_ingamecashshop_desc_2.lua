function PaGlobal_IngameCashShop_DescOpen()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  PaGlobal_IngameCashSHop_ReturnBack_Close()
  PaGlobal_IngameCashShop_Desc:prepareOpen()
end
function PaGlobal_IngameCashShop_DescClose()
  if nil == Panel_IngameCashShop_Desc then
    return
  end
  PaGlobal_IngameCashShop_Desc:prepareClose()
end
function PaGlobal_IngameCashShop_DescGetShow()
  if Panel_IngameCashShop_Desc == nil then
    return false
  end
  return Panel_IngameCashShop_Desc:GetShow()
end
