function PaGlobalFunc_JewelTooltip_Open()
  PaGlobal_JewelTooltip:prepareOpen()
end
function PaGlobalFunc_JewelTooltip_Close()
  PaGlobal_JewelTooltip:prepareClose()
end
function PaGlobalFunc_JewelTooltip_Show(isShow)
  if isShow == nil then
    return
  end
  if isShow == false then
    PaGlobalFunc_JewelTooltip_Close()
    return
  end
  PaGlobal_JewelTooltip:update()
  PaGlobalFunc_JewelTooltip_Open()
  PaGlobal_JewelTooltip:computePos()
end
function PaGlobalFunc_JewelTooltip_ChangeDetail()
  PaGlobal_JewelTooltip._isDetail = not PaGlobal_JewelTooltip._isDetail
  PaGlobalFunc_JewelTooltip_Show(true)
end
