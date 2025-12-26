function PaGlobalFunc_GuildWarColor_All_Open()
  if ToClient_isWarCorresspondent() == true then
    ToClient_RequestSiegeGuildListForWarCorresspondent()
    return
  end
  PaGlobal_GuildWarColor_All:prepareOpen(true)
end
function PaGlobalFunc_GuildWarColor_All_Close()
  PaGlobal_GuildWarColor_All:prepareClose()
end
function PaGlobalFunc_GuildWarColor_All_CreateContent(content, key64)
  PaGlobal_GuildWarColor_All:createContent(content, key64)
end
function PaGlobalFunc_GuildWarColor_All_ResetSelectGuildColor()
  PaGlobal_GuildWarColor_All:setSelectGuildColor(PaGlobal_GuildWarColor_All._baseColor)
end
function PaGlobalFunc_GuildWarColor_All_SetSelectGuildColor(colorKey)
  PaGlobal_GuildWarColor_All:setSelectGuildColor(colorKey)
end
function PaGlobalFunc_GuildWarColor_All_SetAllGuildColor(colorKey)
  PaGlobal_GuildWarColor_All:setAllGuildColor(colorKey)
end
function PaGlobalFunc_GuildWarColor_All_SetNameColor(colorKey)
  PaGlobal_GuildWarColor_All:setNameColor(colorKey)
end
function PaGlobalFunc_GuildWarColor_All_GetSelectedColor()
  return PaGlobal_GuildWarColor_All._selectedColor
end
function HandleEventLUp_GuildWarColor_All_SelectGuildIndex(index, isOpenList)
  PaGlobal_GuildWarColor_All:selectGuildIndex(index)
  if isOpenList == true and PaGlobalFunc_GuildWarColorList_All_Open ~= nil then
    PaGlobalFunc_GuildWarColorList_All_Open()
  end
end
function HandleEventLUp_GuildWarColor_All_ResetAllGuildColor()
  PaGlobal_GuildWarColor_All:setAllGuildColor(PaGlobal_GuildWarColor_All._baseColor)
end
function HandleEventLUp_GuildWarColor_All_ChangeGuildColor()
  local rv = ToClient_requestChangeGuildColor()
  if rv ~= 0 then
    return
  end
  PaGlobal_GuildWarColor_All:prepareClose()
end
function FromClient_GuildWarColor_All_Resize()
  PaGlobal_GuildWarColor_All:resize()
  PaGlobal_GuildWarColor_All:update()
end
function FromClient_GuildWarColor_All_Refresh()
  if Panel_GuildWar_Color == nil or Panel_GuildWar_Color:GetShow() == false then
    return
  end
  PaGlobal_GuildWarColor_All:prepareOpen(false)
end
function FromClient_GetGuildListForWarCorresspondent()
  local self = PaGlobal_GuildWarColor_All
  if self == nil then
    return
  end
  self:prepareOpen(true)
end
