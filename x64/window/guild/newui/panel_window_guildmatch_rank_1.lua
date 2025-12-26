function PaGlobal_GuildMatchRank:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_titleBg = UI.getChildControl(Panel_Window_GuildMatch_Rank, "Static_Title_Bg")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._btn_rewardIcon = UI.getChildControl(Panel_Window_GuildMatch_Rank, "Static_RewardIcon")
  self._ui._stc_rewardTitle = UI.getChildControl(Panel_Window_GuildMatch_Rank, "StaticText_RewardTitle")
  local backBg = UI.getChildControl(Panel_Window_GuildMatch_Rank, "Static_Background")
  self._ui._stc_empty = UI.getChildControl(backBg, "StaticText_Empty")
  self._ui._lst_ranking = UI.getChildControl(Panel_Window_GuildMatch_Rank, "List2_GuildList")
  self._ui._stc_myGuildBg = UI.getChildControl(Panel_Window_GuildMatch_Rank, "Static_MyGuild")
  self._ui._txt_myGuildRank = UI.getChildControl(self._ui._stc_myGuildBg, "StaticText_Rank")
  self._ui._txt_myGuildName = UI.getChildControl(self._ui._stc_myGuildBg, "StaticText_GuildName")
  self._ui._txt_myGuildRecord = UI.getChildControl(self._ui._stc_myGuildBg, "StaticText_RecordValue")
  self._ui._txt_myGuildRankPoint = UI.getChildControl(self._ui._stc_myGuildBg, "StaticText_PointValue")
  self._ui._btn_rewardIcon:SetShow(false)
  self._ui._stc_rewardTitle:SetShow(false)
  self._ui._stc_empty:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildMatchRank:registEventHandler()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  registerEvent("FromClient_LoadCompleteMyGuildMatchRankInfo", "FromClient_LoadCompleteMyGuildMatchRankInfo")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatchRank_Close()")
  self._ui._lst_ranking:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildMatchRank_OnCreateRankInfo")
  self._ui._lst_ranking:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_GuildMatchRank:validate()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  self._ui._stc_titleBg:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._btn_rewardIcon:isValidate()
  self._ui._stc_rewardTitle:isValidate()
  self._ui._stc_empty:isValidate()
  self._ui._lst_ranking:isValidate()
  self._ui._stc_myGuildBg:isValidate()
  self._ui._txt_myGuildRank:isValidate()
  self._ui._txt_myGuildName:isValidate()
  self._ui._txt_myGuildRecord:isValidate()
  self._ui._txt_myGuildRankPoint:isValidate()
end
function PaGlobal_GuildMatchRank:prepareOpen()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  self:initialize()
  self:updateGuildRankList()
  self:updateMyGuildRankInfo()
  self:open()
end
function PaGlobal_GuildMatchRank:open()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  Panel_Window_GuildMatch_Rank:SetShow(true)
end
function PaGlobal_GuildMatchRank:prepareClose()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  self:close()
end
function PaGlobal_GuildMatchRank:close()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  Panel_Window_GuildMatch_Rank:SetShow(false)
end
function PaGlobal_GuildMatchRank:createRankInfoListContent(content, key)
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  local highIndex = highFromUint64(key)
  local lowIndex = lowFromUint64(key)
  local isBig = false
  if lowIndex == self._invalidRankInfoIndexForBig then
    isBig = true
  end
  local stc_big = UI.getChildControl(content, "Static_Big")
  local stc_small = UI.getChildControl(content, "Static_Small")
  content:SetShow(true)
  stc_big:SetShow(isBig == true)
  stc_small:SetShow(isBig == false)
  if isBig == true then
    local dataWrapper = ToClient_GetGuildMatchRankInfoWrapper(highIndex)
    if dataWrapper == nil then
      return
    end
    local rank_1_bg = UI.getChildControl(stc_big, "Static_Rank1Bg")
    local rank_2_bg = UI.getChildControl(stc_big, "Static_Rank2Bg")
    local rank_3_bg = UI.getChildControl(stc_big, "Static_Rank3Bg")
    local rank_1_icon = UI.getChildControl(stc_big, "Static_1st")
    local rank_2_icon = UI.getChildControl(stc_big, "Static_2nd")
    local rank_3_icon = UI.getChildControl(stc_big, "Static_3rd")
    local guildName = UI.getChildControl(stc_big, "StaticText_GuildName")
    local guildMasterName = UI.getChildControl(stc_big, "StaticText_GuildMaster")
    local guildRecord = UI.getChildControl(stc_big, "StaticText_RecordValue")
    local guildRankPoint = UI.getChildControl(stc_big, "StaticText_PointValue")
    rank_1_bg:SetShow(false)
    rank_2_bg:SetShow(false)
    rank_3_bg:SetShow(false)
    rank_1_icon:SetShow(false)
    rank_2_icon:SetShow(false)
    rank_3_icon:SetShow(false)
    if highIndex == 0 then
      rank_1_bg:SetShow(true)
      rank_1_icon:SetShow(true)
    elseif highIndex == 1 then
      rank_2_bg:SetShow(true)
      rank_2_icon:SetShow(true)
    else
      rank_3_bg:SetShow(true)
      rank_3_icon:SetShow(true)
    end
    guildName:SetText(dataWrapper:getGuildName())
    guildMasterName:SetText(dataWrapper:getGuildMasterUserNickname())
    guildRecord:SetText(dataWrapper:getWinCount() .. " / " .. dataWrapper:getLoseCount())
    guildRankPoint:SetText(dataWrapper:getRankPoint())
  else
    local topBg = UI.getChildControl(stc_small, "Static_TopBg")
    local bottomBg = UI.getChildControl(stc_small, "Static_BottomBg")
    topBg:SetShow(false)
    bottomBg:SetShow(false)
    local highDataWrapper = ToClient_GetGuildMatchRankInfoWrapper(highIndex)
    if highDataWrapper ~= nil then
      local guildRank = UI.getChildControl(topBg, "StaticText_Rank")
      local guildName = UI.getChildControl(topBg, "StaticText_GuildName")
      local guildRecord = UI.getChildControl(topBg, "StaticText_RecordValue")
      local guildRankPoint = UI.getChildControl(topBg, "StaticText_PointValue")
      guildRank:SetText(highIndex + 1)
      guildName:SetText(highDataWrapper:getGuildName())
      guildRecord:SetText(highDataWrapper:getWinCount() .. " / " .. highDataWrapper:getLoseCount())
      guildRankPoint:SetText(highDataWrapper:getRankPoint())
      topBg:SetShow(true)
    end
    if lowIndex ~= self._invalidRankInfoIndexForSmall then
      local lowDataWrapper = ToClient_GetGuildMatchRankInfoWrapper(lowIndex)
      if lowDataWrapper ~= nil then
        local guildRank = UI.getChildControl(bottomBg, "StaticText_Rank")
        local guildName = UI.getChildControl(bottomBg, "StaticText_GuildName")
        local guildRecord = UI.getChildControl(bottomBg, "StaticText_RecordValue")
        local guildRankPoint = UI.getChildControl(bottomBg, "StaticText_PointValue")
        guildRank:SetText(lowIndex + 1)
        guildName:SetText(lowDataWrapper:getGuildName())
        guildRecord:SetText(lowDataWrapper:getWinCount() .. " / " .. lowDataWrapper:getLoseCount())
        guildRankPoint:SetText(lowDataWrapper:getRankPoint())
        bottomBg:SetShow(true)
      end
    end
  end
end
function PaGlobal_GuildMatchRank:updateGuildRankList()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  local listManager = self._ui._lst_ranking:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local count = ToClient_GetGuildMatchRankInfoCount()
  if count == 0 then
    self._ui._stc_empty:SetShow(true)
    return
  else
    self._ui._stc_empty:SetShow(false)
  end
  local index = 0
  for fakeIndex = 0, count - 1 do
    if count <= index then
      break
    end
    local isEnd = false
    if index < 3 then
      listManager:pushKey(toInt64(index, self._invalidRankInfoIndexForBig))
      index = index + 1
    else
      local nextIndex = index + 1
      if count <= nextIndex then
        nextIndex = self._invalidRankInfoIndexForSmall
        isEnd = true
      end
      listManager:pushKey(toInt64(index, nextIndex))
      index = index + 2
    end
    if isEnd == true then
      break
    end
  end
end
function PaGlobal_GuildMatchRank:updateMyGuildRankInfo()
  if Panel_Window_GuildMatch_Rank == nil then
    return
  end
  self._ui._txt_myGuildRank:SetText("-")
  self._ui._txt_myGuildName:SetText("-")
  self._ui._txt_myGuildRecord:SetText("-")
  self._ui._txt_myGuildRankPoint:SetText("-")
  local myGuildRankInfoWrapper = ToClient_GetGuildMatchSelfPlayerRankInfoWrapper()
  if myGuildRankInfoWrapper == nil then
    return
  end
  self._ui._txt_myGuildRank:SetText(myGuildRankInfoWrapper:getRank())
  self._ui._txt_myGuildName:SetText(myGuildRankInfoWrapper:getGuildName())
  self._ui._txt_myGuildRecord:SetText(myGuildRankInfoWrapper:getWinCount() .. " / " .. myGuildRankInfoWrapper:getLoseCount())
  self._ui._txt_myGuildRankPoint:SetText(myGuildRankInfoWrapper:getRankPoint())
end
