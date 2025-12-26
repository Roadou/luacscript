function PaGlobal_HardCoreRanking:initialize()
  if PaGlobal_HardCoreRanking._initialize == true then
    return
  end
  local topBG = UI.getChildControl(Panel_Window_HardcoreRanking, "Static_Top")
  local profile = UI.getChildControl(topBG, "Static_Profile")
  self._ui._txt_CharacterName = UI.getChildControl(profile, "StaticText_FamilyName")
  self._ui._txt_TitleName = UI.getChildControl(profile, "StaticText_TitleName")
  self._ui._txt_MyRank = UI.getChildControl(profile, "StaticText_MyRankingValue")
  self._ui._txt_KillDeathCount = UI.getChildControl(profile, "StaticText_KillDeathValue")
  self._ui._stc_ProfileIcon = UI.getChildControl(profile, "Static_Profile_Icon")
  self._ui._stc_TierListBtn = UI.getChildControl(topBG, "Static_Tierlist_Btn")
  self._ui._stc_TierList = UI.getChildControl(Panel_Window_HardcoreRanking, "Static_TierList_BG")
  local rankWrap = UI.getChildControl(topBG, "Static_Rank_Wrap")
  self._ui._stc_MyRankIcon = UI.getChildControl(rankWrap, "Static_Rank_Icon")
  self._ui._txt_MyRankName = UI.getChildControl(rankWrap, "StaticText_Tier")
  self._ui._txt_MyRankPoint = UI.getChildControl(rankWrap, "StaticText_Score")
  self._ui._rankFrame = UI.getChildControl(Panel_Window_HardcoreRanking, "Frame_RankList")
  self._ui._frameContent = UI.getChildControl(self._ui._rankFrame, "Frame_1_Content")
  self._ui._frameScroll = UI.getChildControl(self._ui._rankFrame, "Frame_1_VerticalScroll")
  self._ui._btn_Guide = UI.getChildControl(topBG, "Button_NormalGame_Match")
  local titleBg = UI.getChildControl(Panel_Window_HardcoreRanking, "Static_Title_Bg")
  self._ui._btn_Exit = UI.getChildControl(titleBg, "Button_Close")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_HardCoreRanking:registEventHandler()
  PaGlobal_HardCoreRanking:validate()
  self._highRankerMaxCount = ToClient_GetHardCoreTotalRankThreshold()
  self._selfPlayer = getSelfPlayer()
  self._ui._frameScroll:SetInterval(50)
  self:initTierList()
  self:createControl()
  self._initialize = true
end
function PaGlobal_HardCoreRanking:initTierList()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  local rowCount = 7
  local columnCount = 3
  local totalIndex = 1
  local textureIndex = 0
  for rowIndex = 0, rowCount - 1 do
    for columnIndex = 1, columnCount do
      if rowIndex ~= 0 and columnIndex > 1 then
        break
      end
      local controlName = "StaticText_Tier_" .. tostring(rowIndex) .. "_" .. tostring(columnIndex)
      local tier = UI.getChildControl(self._ui._stc_TierList, controlName)
      if tier ~= nil and tier:GetShow() == true then
        local tierName = ""
        local tierDescText = ""
        if rowIndex == 0 then
          tierName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HARDCOE_RANKING_TIER_0_" .. tostring(columnIndex))
          tierDescText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HARDCOE_RANKING_TIERAVER_0_" .. tostring(columnIndex))
        else
          tierName = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HARDCOE_RANKING_TIERNAME_" .. tostring(rowIndex), "rank", "")
          local percent = ToClient_GetHardCoreTotalRankGradePercentByKey(totalIndex)
          if percent < 1 then
            percent = math.floor(percent * 10) / 10
          end
          tierDescText = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_HARDCOE_RANKING_TIERAVER", "percent", tostring(percent))
        end
        tier:SetText(tierName)
        local tierDesc = UI.getChildControl(tier, "StaticText_Score")
        tierDesc:SetText(tierDescText)
        self._ui._tierControlList[totalIndex] = tier
        totalIndex = totalIndex + 1
      end
    end
  end
  local unRankTier = UI.getChildControl(self._ui._stc_TierList, "StaticText_Tier_7_1")
  unRankTier:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_HARDCOE_RANKING_TIERNAME_7"))
  local unRankTierDesc = UI.getChildControl(unRankTier, "StaticText_Score")
  unRankTierDesc:SetText("")
  unRankTierDesc:SetShow(true)
  self._ui._tierControlList[0] = unRankTier
end
function PaGlobal_HardCoreRanking:registEventHandler()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  self._ui._stc_TierListBtn:addInputEvent("Mouse_On", "PaGlobal_HardCoreRanking:showTierList(true)")
  self._ui._stc_TierListBtn:addInputEvent("Mouse_Out", "PaGlobal_HardCoreRanking:showTierList(false)")
  self._ui._btn_Exit:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreRanking_Close()")
  self._ui._btn_Guide:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"HardCore\" )")
  registerEvent("FromClient_OpenHardCoreRankingPage", "PaGlobal_HardCoreRanking_ShowPage()")
  registerEvent("FromClient_UpdateHardCoreRankingSelfInfo", "PaGlobal_HardCoreRanking_UpdatSelfInfo()")
  registerEvent("FromClient_UpdateHardCoreRankingList", "PaGlobal_HardCoreRanking_UpdatRankingList()")
end
function PaGlobal_HardCoreRanking:validate()
  self._ui._txt_CharacterName:isValidate()
  self._ui._txt_TitleName:isValidate()
  self._ui._txt_MyRank:isValidate()
  self._ui._txt_KillDeathCount:isValidate()
  self._ui._stc_ProfileIcon:isValidate()
  self._ui._stc_TierListBtn:isValidate()
  self._ui._stc_TierList:isValidate()
  self._ui._stc_MyRankIcon:isValidate()
  self._ui._txt_MyRankName:isValidate()
  self._ui._txt_MyRankPoint:isValidate()
  self._ui._rankFrame:isValidate()
  self._ui._frameContent:isValidate()
  self._ui._frameScroll:isValidate()
  self._ui._btn_Guide:isValidate()
  self._ui._btn_Exit:isValidate()
end
function PaGlobal_HardCoreRanking:prepareOpen()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_HardCoreRanking:open()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  Panel_Window_HardcoreRanking:SetShow(true)
end
function PaGlobal_HardCoreRanking:prepareClose()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  self:close()
end
function PaGlobal_HardCoreRanking:close()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  Panel_Window_HardcoreRanking:SetShow(false)
end
function PaGlobal_HardCoreRanking:update()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  self:updateSelfCharacterData()
  self:updateRankingListUI()
end
function PaGlobal_HardCoreRanking:updateSelfCharacterData()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  self._ui._txt_CharacterName:SetText(self._selfPlayer:getOriginalName())
  local currentTitleKey = ToClient_GetHardCoreSelfPlayerCurrentTitleKey()
  if currentTitleKey ~= 0 then
    self._ui._txt_TitleName:SetText(ToClient_getHardCoreTitleNameByKey(currentTitleKey))
    self._ui._txt_TitleName:SetShow(true)
  else
    self._ui._txt_TitleName:SetShow(false)
  end
  local myRank = ToClient_getHardCoreMyTotalRank()
  if myRank == 0 then
    self._ui._txt_MyRank:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_RANKING_NORANK"))
  else
    self._ui._txt_MyRank:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_RANK_VALUE", "rank", tostring(myRank)))
  end
  local killCount = ToClient_getHardCoreMyKillCount()
  local deathCount = ToClient_getHardCoreMyDeathCount()
  self._ui._txt_KillDeathCount:SetText(tostring(killCount) .. " / " .. tostring(deathCount))
  PaGlobalFunc_Util_SetSolrareRankingClassBigBG(self._ui._stc_ProfileIcon, self._selfPlayer:getClassType())
  local myRankPoint = ToClient_GetHardCoreCharacterTotalRankPoint()
  if myRankPoint >= 0 then
    self._ui._txt_MyRankPoint:SetText(tostring(myRankPoint))
  else
    self._ui._txt_MyRankPoint:SetText("")
  end
  local gradeKey = ToClient_GetHardCoreTotalRankGradeKeyByRank(myRank)
  local currentTier = self._ui._tierControlList[gradeKey]
  if currentTier ~= nil then
    self:setTierTexture(gradeKey, self._ui._stc_MyRankIcon)
    self._ui._txt_MyRankName:SetText(currentTier:GetText())
  end
end
function PaGlobal_HardCoreRanking:updateRankingListUI()
  self._ui._stc_TierList:SetShow(false)
  self:updateHighRankerList()
end
function PaGlobal_HardCoreRanking:showTierList(isShow)
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  self._ui._stc_TierList:SetShow(isShow)
end
function PaGlobal_HardCoreRanking:setHighRankerControl(control, rank)
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  local topRankTextureID = {
    [1] = "1st",
    [2] = "2nd",
    [3] = "3rd"
  }
  local rankControl = UI.getChildControl(control, "Static_Rank")
  if rank <= self._topRankerCount then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Solare_War_Slot_" .. topRankTextureID[rank] .. "_Normal", __eUITextureTypeBase)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Solare_War_Slot_" .. topRankTextureID[rank] .. "_Over", __eUITextureTypeOn)
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_Solare_War_Slot_" .. topRankTextureID[rank] .. "_Click", __eUITextureTypeClick)
    control:setRenderTexture(control:getBaseTexture())
    rankControl:ChangeTextureInfoTextureIDAsync("Combine_Etc_Solare_War_Icon_" .. topRankTextureID[rank])
    rankControl:setRenderTexture(rankControl:getBaseTexture())
  else
    rankControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SOLARE_OTHER_RANK", "rank", rank))
  end
end
function PaGlobal_HardCoreRanking:createControl()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  local topRankerTemplate = UI.getChildControl(self._ui._frameContent, "Static_Top_Rank_Tamplate")
  local normalRankerTemplate = UI.getChildControl(self._ui._frameContent, "Static_Other_Rank_Tamplate")
  local prevPosY = 0
  local totalSize = self._gap
  for index = 1, self._highRankerMaxCount do
    local clonedControl
    if index <= self._topRankerCount then
      clonedControl = UI.cloneControl(topRankerTemplate, self._ui._frameContent, "Static_Top_Rank_Tamplate_" .. tostring(index))
    else
      clonedControl = UI.cloneControl(normalRankerTemplate, self._ui._frameContent, "Static_Other_Rank_Tamplate" .. tostring(index))
    end
    clonedControl:SetPosY(prevPosY + self._gap)
    prevPosY = prevPosY + clonedControl:GetSizeY() + self._gap
    totalSize = totalSize + clonedControl:GetSizeY() + self._gap
    self._ui._highRankerList[index] = clonedControl
  end
  topRankerTemplate:SetShow(false)
  normalRankerTemplate:SetShow(false)
end
function PaGlobal_HardCoreRanking:setTierTexture(gradeKey, control)
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  if control == nil or gradeKey >= self._totalGradeCount then
    return
  end
  if gradeKey == 0 then
    gradeKey = self._totalGradeCount
  end
  local fileNum = gradeKey - 1
  local fileNumText = tostring(fileNum)
  if fileNum < 10 then
    fileNumText = "0" .. fileNumText
  end
  control:ChangeTextureInfoTextureIDAsync("HardcoreServer_Tier" .. fileNumText)
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_HardCoreRanking:updateHighRankerList()
  if Panel_Window_HardcoreRanking == nil then
    return
  end
  local totalSize = self._gap
  for ii = 1, self._highRankerMaxCount do
    local index = ii - 1
    local rankBg = self._ui._highRankerList[ii]
    local rankPoint = ToClient_GetHardCoreTotalHighRankerPoint(index)
    if rankPoint ~= 0 then
      local rank = ToClient_GetHardCoreTotalHighRankerRankByIndex(index)
      local gradeKey = ToClient_GetHardCoreTotalRankGradeKeyByRank(rank)
      local characterName = ToClient_GetHardCoreTotalHighRankerCharacterName(index)
      local classType = ToClient_GetHardCoreTotalHighRankerClassType(index)
      local characterBg = UI.getChildControl(rankBg, "Static_Character_BG")
      local characterNameControl = UI.getChildControl(rankBg, "StaticText_FamilyName")
      local tierIcon = UI.getChildControl(rankBg, "Static_Tier")
      local rankPointControl = UI.getChildControl(rankBg, "StaticText_Score")
      local rankControl = UI.getChildControl(rankBg, "Static_Rank")
      local classIcon = UI.getChildControl(rankBg, "Static_ClassIcon")
      PaGlobalFunc_Util_SetSolrareRankingClassBigBG(characterBg, classType)
      PaGlobalFunc_Util_ChangeTextureClass(classIcon, classType)
      characterNameControl:SetText(characterName)
      self:setTierTexture(gradeKey, tierIcon)
      self:setHighRankerControl(rankBg, rank)
      rankPointControl:SetText(tostring(rankPoint))
      if ii <= self._topRankerCount then
        local className = UI.getChildControl(rankBg, "StaticText_ClassName")
        className:SetText(NewClassData.newClass_String[classType]._classType2String)
      end
      totalSize = totalSize + rankBg:GetSizeY() + self._gap
      rankBg:SetShow(true)
    else
      rankBg:SetShow(false)
    end
  end
  self._ui._rankFrame:ComputePos()
  self._ui._rankFrame:UpdateContentPos()
  self._ui._rankFrame:UpdateContentScroll()
  self._ui._frameContent:SetSize(self._ui._frameContent:GetSizeX(), totalSize)
end
