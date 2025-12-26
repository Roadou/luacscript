function PaGlobalFunc_GuildMatchRank_Open()
  local self = PaGlobal_GuildMatchRank
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_GuildMatchRank_Close()
  local self = PaGlobal_GuildMatchRank
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_GuildMatchRank_IsShow()
  local panel = Panel_Window_GuildMatch_Rank
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function PaGlobalFunc_GuildMatchRank_OnCreateRankInfo(content, key)
  local self = PaGlobal_GuildMatchRank
  if self == nil then
    return
  end
  self:createRankInfoListContent(content, key)
end
function FromClient_LoadCompleteMyGuildMatchRankInfo()
  local self = PaGlobal_GuildMatchRank
  if self == nil then
    return
  end
  self:updateMyGuildRankInfo()
end
