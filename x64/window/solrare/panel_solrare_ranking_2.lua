function PaGlobalFunc_SolareRanking_Open()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  ToClient_RequestSolareRankingInfo()
end
function FromClient_LoadCompleteSolareRankingInfo()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_Solrare_Ranking_Close()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventScroll_Solrare_Ranking_Update(isUp)
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  self._scrollIdx = UIScroll.ScrollEvent(self._ui._frame_Scroll, isUp, self._maxShowingRecordCount, self._currentRecordCount, self._scrollIdx, 1)
end
function PaGlobalFunc_Solrare_Ranking_SetRankBg(control, rank)
  if control == nil then
    return
  end
  if rank == 1 then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Solare_War_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1333, 141, 1433)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  elseif rank == 2 then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Solare_War_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1434, 141, 1534)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  elseif rank == 3 then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Solare_War_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1535, 141, 1635)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
    control:setRenderTexture(control:getBaseTexture())
  else
    control:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_OTHER_RANK", "rank", rank))
  end
end
function PaGlobalFunc_Solrare_Ranking_GetBranchText(classType, branch)
  local className = getCharacterClassName(classType)
  if branch == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType) == true then
    branch = __eSkillTypeParam_Inherit
  end
  if classType == __eClassType_ShyWaman or classType == __eClassType_RangerMan or classType == __eClassType_Scholar or classType == __eClassType_PWGE or classType == __eClassType_PJKD or classType == __eClassType_PDKL then
    return className
  end
  _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. ", "\236\161\176\236\139\156\236\153\132")
  if branch == __eSkillTypeParam_Awaken then
    return "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN") .. "]" .. className
  elseif branch == __eSkillTypeParam_Inherit or branch == __eSkillTypeParam_Normal then
    return "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION") .. "]" .. className
  end
  return className
end
function PaGlobalFunc_Solrare_Ranking_GetBranch(classType, branch)
  if branch == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType) == true then
    branch = __eSkillTypeParam_Inherit
  end
  if branch == __eSkillTypeParam_Awaken then
    return __eSkillTypeParam_Awaken
  elseif branch == __eSkillTypeParam_Inherit or branch == __eSkillTypeParam_Normal then
    return __eSkillTypeParam_Inherit
  end
  return branch
end
function PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(control, rankScore, isTop)
  if control == nil then
    return
  end
  if isTop == nil then
    isTop = false
  end
  local rankDefine = Defines.SolrareRank
  local myTier = CovertSolrareRankScoreToTierGrade(rankScore)
  local tierFileNumber = Defines.SolrareRankOrder[myTier]
  if tierFileNumber == nil then
    return
  end
  if tierFileNumber < 10 then
    tierFileNumber = "0" .. tostring(tierFileNumber)
  end
  local fileName = "Combine/Icon/Tier/Solare_Tier" .. tostring(tierFileNumber) .. ".dds"
  if isTop == true and myTier == Defines.SolrareRank.RANK1_1 then
    fileName = "Combine/Icon/Tier/Solare_Tier22.dds"
  end
  control:ChangeTextureInfoNameAsync(fileName)
  control:setPixelUVAndLoadTexture(0, 0, 120, 120)
end
function PaGlobalFunc_Solrare_Ranking_SetTierFrameByPreSeasonScore(control, preSeasonRankScore, teamNo, isHPWidget)
  if control == nil then
    return
  end
  local myTier = CovertSolrareRankScoreToTierGrade(preSeasonRankScore)
  local tierFileNumber = Defines.SolrareRankOrder[myTier]
  if tierFileNumber == nil then
    return
  end
  local uvStartX = 0
  local uvStartY = 0
  local uvEndX = 0
  local uvEndY = 0
  local tierNo = 1
  if tierFileNumber == 0 then
    tierNo = 8
  elseif tierFileNumber >= 1 and tierFileNumber < 4 then
    tierNo = 7
  elseif tierFileNumber >= 4 and tierFileNumber < 7 then
    tierNo = 6
  elseif tierFileNumber >= 7 and tierFileNumber < 10 then
    tierNo = 5
  elseif tierFileNumber >= 10 and tierFileNumber < 13 then
    tierNo = 4
  elseif tierFileNumber >= 13 and tierFileNumber < 17 then
    tierNo = 3
  elseif tierFileNumber >= 17 and tierFileNumber < 21 then
    tierNo = 2
  elseif 21 == tierFileNumber then
    tierNo = 1
  end
  if isHPWidget == true then
    if teamNo == __eSolareTeamNo_Red then
      uvStartX = 1027
      uvEndX = 1345
    else
      uvStartX = 1346
      uvEndX = 1664
    end
    uvStartY = 100 * tierNo - 99
    uvEndY = 100 * tierNo
  else
    if teamNo == __eSolareTeamNo_Red then
      uvStartX = 514
      uvEndX = 1026
    else
      uvStartX = 1
      uvEndX = 513
    end
    uvStartY = 122 * tierNo - 121
    uvEndY = 122 * tierNo
  end
  control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Solare_War_Frame.dds")
  control:setPixelUVAndLoadTexture(__eUITextureTypeBase, uvStartX, uvStartY, uvEndX, uvEndY)
end
function PaGlobalFunc_Solrare_Ranking_ToggleClassList()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  self._ui._classFilter:ToggleListbox()
end
function PaGlobalFunc_Solrare_Ranking_SelectClassList()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  local selectIndex = self._ui._classFilter:GetSelectIndex()
  local filterName = ""
  if selectIndex == 0 then
    filterName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DYEPALETTE_TAB_ALL")
    self:updateAllRanking(self:getCurrentGameMode())
  else
    if self._ui._classTypeList[selectIndex] == nil then
      return
    end
    local index = self._ui._classTypeList[selectIndex]
    local classType = getCharacterClassTypeByIndex(index)
    local className = getCharacterClassName(classType)
    filterName = className
    self:updateClassRanking(self:getCurrentGameMode(), classType)
  end
  self:reAlignFrameControl()
  self._ui._classFilter:SetText(filterName)
  self._ui._frame_Scroll:SetControlPos(0)
  self._ui._frame_RankingBg:UpdateContentPos()
end
function PaGlobalFunc_Solrare_Ranking_ChangeGameMode()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  self:toggleSelectModeButton()
  self:updateAllRanking(self:getCurrentGameMode())
  self:reAlignFrameControl()
  self._ui._frame_Scroll:SetControlTop()
  self._ui._frame_Scroll:SetControlPos(0)
end
function HandleEventLUp_Solrare_Ranking_DetailToggle(index)
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  if nil == self._recordControl[index] then
    return
  end
  for idx = 1, self._currentRecordCount do
    if self._recordControl[idx] ~= nil then
      if index == idx then
        if self._recordControl[idx].isDetailControlShow == true then
          self._recordControl[idx].isDetailControlShow = false
          self._recordControl[idx].chk_mostDetail:SetCheck(false)
        else
          self._recordControl[idx].isDetailControlShow = true
          self._recordControl[idx].chk_mostDetail:SetCheck(true)
        end
      else
        self._recordControl[idx].isDetailControlShow = false
        self._recordControl[idx].chk_mostDetail:SetCheck(false)
      end
    end
  end
  self:reAlignFrameControl()
end
function PaGlobalFunc_PaGlobal_Solrare_Ranking_TierListShow(isShow)
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return
  end
  self._ui._stc_TierListBg:SetShow(isShow)
end
function PaGlobalFunc_SolareRank_GetCurrentGameMode()
  local self = PaGlobal_Solrare_Ranking
  if self == nil then
    return __ePVPArenaMode_Count
  end
  return self:getCurrentGameMode()
end
