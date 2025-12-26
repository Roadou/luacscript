function PaGlobal_GuildAttributeReport_All_Open(index)
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildAttributeReport_All._selectIndex = index
  ToClient_RequestGuildActivityPointList()
end
function PaGlobal_GuildAttributeReport_All_LoadGuildActivityPoint()
  if PaGlobal_GuildAttributeReport_All._selectIndex == nil then
    return
  end
  PaGlobal_GuildAttributeReport_All:prepareOpen(PaGlobal_GuildAttributeReport_All._selectIndex)
end
function PaGlobal_GuildAttributeReport_All_Close()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  PaGlobal_GuildAttributeReport_All:prepareClose()
end
function PaGlobal_GuildAttributeReport_All_Request()
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if PaGlobal_GuildAttributeReport_All._selectOption == -1 or PaGlobal_GuildAttributeReport_All._selectOption == nil then
    return
  end
  ToClient_RequestGuildActivityPoint(PaGlobal_GuildAttributeReport_All._isSendAll, PaGlobal_GuildAttributeReport_All._selectOption)
  PaGlobal_GuildAttributeReport_All_Close()
end
function PaGlobal_GuildAttributeReport_All_Select(index)
  if Panel_GuildAttributeReport_All == nil then
    return
  end
  if index == nil then
    return
  end
  PaGlobal_GuildAttributeReport_All._selectOption = index
end
