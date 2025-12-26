function PaGlobal_ContentsName:initialize()
  if PaGlobal_ContentsName._initialize == true then
    return
  end
  PaGlobal_ContentsName:registEventHandler()
  PaGlobal_ContentsName:validate()
  PaGlobal_ContentsName._initialize = true
end
function PaGlobal_ContentsName:registEventHandler()
  if Panel_ContentsName == nil then
    return
  end
end
function PaGlobal_ContentsName:prepareOpen()
  if Panel_ContentsName == nil then
    return
  end
  PaGlobal_ContentsName:open()
end
function PaGlobal_ContentsName:open()
  if Panel_ContentsName == nil then
    return
  end
  Panel_ContentsName:SetShow(true)
end
function PaGlobal_ContentsName:prepareClose()
  if Panel_ContentsName == nil then
    return
  end
  PaGlobal_ContentsName:close()
end
function PaGlobal_ContentsName:close()
  if Panel_ContentsName == nil then
    return
  end
  Panel_ContentsName:SetShow(false)
end
function PaGlobal_ContentsName:update()
  if Panel_ContentsName == nil then
    return
  end
end
function PaGlobal_ContentsName:validate()
  if Panel_ContentsName == nil then
    return
  end
end
