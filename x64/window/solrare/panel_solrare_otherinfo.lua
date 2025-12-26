PaGlobal_Solrare_OtherInfo = {
  _ui = {
    _btn_Close = nil,
    _stc_ClassIcon = nil,
    _stc_Awaken = nil,
    _stc_Succesion = nil,
    _stc_RankIcon = nil,
    _txt_Score = nil,
    _txt_Name = nil,
    _txt_Class = nil,
    _stc_EquipMainSlot = {},
    _stc_EquipAcceSlot = {},
    _stc_Skill = {}
  },
  _eEquipSlot = {
    [0] = __eEquipSlotNoRightHand,
    [1] = __eEquipSlotNoLeftHand,
    [2] = __eEquipSlotNoAwakenWeapon,
    [3] = __eEquipSlotNoGlove,
    [4] = __eEquipSlotNoBoots,
    [5] = __eEquipSlotNoHelm,
    [6] = __eEquipSlotNoChest,
    [7] = __eEquipSlotNoBelt,
    [8] = __eEquipSlotNoNecklace,
    [9] = __eEquipSlotNoEaring1,
    [10] = __eEquipSlotNoEaring2,
    [11] = __eEquipSlotNoRing1,
    [12] = __eEquipSlotNoRing2,
    [13] = __eEquipSlotNoAlchemyStone,
    [14] = __eEquipSlotNoArtifact1,
    [15] = __eEquipSlotNoArtifact2
  },
  _initPosX = 0,
  _initPosY = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Solrare_OtherInfo_Init")
function FromClient_Solrare_OtherInfo_Init()
  PaGlobal_Solrare_OtherInfo:initialize()
end
function PaGlobal_Solrare_OtherInfo:initialize()
  if true == PaGlobal_Solrare_OtherInfo._initialize or nil == Panel_Solrare_OtherInfo then
    return
  end
  local titleBg = UI.getChildControl(Panel_Solrare_OtherInfo, "Static_Title_Bg")
  self._ui._btn_Close = UI.getChildControl(titleBg, "Button_Close")
  local topBg = UI.getChildControl(Panel_Solrare_OtherInfo, "Static_Top")
  local profileBg = UI.getChildControl(topBg, "Static_Profile")
  self._ui._stc_ClassIcon = UI.getChildControl(profileBg, "Static_Profile_Icon")
  self._ui._stc_Awaken = UI.getChildControl(profileBg, "Static_Type_Awaken")
  self._ui._stc_Succesion = UI.getChildControl(profileBg, "Static_Type_Succesion")
  local rankBg = UI.getChildControl(topBg, "Static_Rank_Wrap")
  self._ui._stc_RankIcon = UI.getChildControl(rankBg, "Static_Rank_Icon")
  self._ui._txt_Score = UI.getChildControl(rankBg, "StaticText_Score")
  self._ui._txt_Name = UI.getChildControl(rankBg, "StaticText_Name")
  self._ui._txt_Class = UI.getChildControl(rankBg, "StaticText_TypeText")
  local equipBg = UI.getChildControl(Panel_Solrare_OtherInfo, "Static_Equip_BG")
  local equipBox = UI.getChildControl(equipBg, "Static_EquipBox")
  local equipMain = UI.getChildControl(equipBox, "Static_Equip_Main")
  local equipAcce = UI.getChildControl(equipBox, "Static_Equip_Accessory")
  local slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = false,
    createExpiration = false,
    createExpirationBG = false,
    createClassEquipBG = false,
    createEnduranceIcon = false,
    createItemLock = false,
    createBlack = true,
    createEnchant = true,
    createBadBG = false
  }
  for index = 0, 6 do
    local slotMain = UI.getChildControl(equipMain, "Static_SlotBG_" .. tostring(index))
    self._ui._stc_EquipMainSlot[index] = {}
    SlotItem.new(self._ui._stc_EquipMainSlot[index], "equipMain_" .. tostring(index), 0, slotMain, slotConfig)
    self._ui._stc_EquipMainSlot[index]:createChild()
    self._ui._stc_EquipMainSlot[index].icon:SetSize(slotMain:GetSizeX(), slotMain:GetSizeY())
    self._ui._stc_EquipMainSlot[index].parent = slotMain
    local slotAcce = UI.getChildControl(equipAcce, "Static_SlotBG_" .. tostring(index))
    self._ui._stc_EquipAcceSlot[index] = {}
    SlotItem.new(self._ui._stc_EquipAcceSlot[index], "equipAcce_" .. tostring(index), 0, slotAcce, slotConfig)
    self._ui._stc_EquipAcceSlot[index]:createChild()
    self._ui._stc_EquipAcceSlot[index].icon:SetSize(slotAcce:GetSizeX(), slotAcce:GetSizeY())
    self._ui._stc_EquipAcceSlot[index].parent = slotAcce
  end
  local awakenBg = UI.getChildControl(Panel_Solrare_OtherInfo, "Static_SkillAwaken_BG")
  for index = 0, 5 do
    self._ui._stc_Skill[index] = {}
    self._ui._stc_Skill[index].main = UI.getChildControl(awakenBg, "Static_Skill_" .. tostring(index))
    self._ui._stc_Skill[index].slotBg = UI.getChildControl(self._ui._stc_Skill[index].main, "Static_SkillSlotBG")
    self._ui._stc_Skill[index].icon = UI.getChildControl(self._ui._stc_Skill[index].slotBg, "Static_SkillIcon")
    self._ui._stc_Skill[index].title = UI.getChildControl(self._ui._stc_Skill[index].main, "StaticText_NorSkill_Title")
    self._ui._stc_Skill[index].titleInfo = UI.getChildControl(self._ui._stc_Skill[index].title, "StaticText_NorSkill_Info")
    self._ui._stc_Skill[index].effect = UI.getChildControl(self._ui._stc_Skill[index].main, "StaticText_NorSkillEff_Title")
    self._ui._stc_Skill[index].eff1 = UI.getChildControl(self._ui._stc_Skill[index].effect, "StaticText_NorSkillEff01")
    self._ui._stc_Skill[index].eff2 = UI.getChildControl(self._ui._stc_Skill[index].effect, "StaticText_NorSkillEff02")
    self._ui._stc_Skill[index].none = UI.getChildControl(self._ui._stc_Skill[index].main, "StaticText_NorSkillActive")
    self._ui._stc_Skill[index].none:SetText("LV " .. 50 + index * 2)
  end
  self._initPosX = Panel_Solrare_OtherInfo:GetPosX()
  self._initPosY = Panel_Solrare_OtherInfo:GetPosY()
  PaGlobal_Solrare_OtherInfo:registerEvent()
  PaGlobal_Solrare_OtherInfo._initialize = true
end
function PaGlobal_Solrare_OtherInfo:registerEvent()
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Solrare_OtherInfo_Close()")
end
function PaGlobal_Solrare_OtherInfo:open()
  Panel_Solrare_OtherInfo:SetPosX(self._initPosX)
  Panel_Solrare_OtherInfo:SetPosY(self._initPosY)
  Panel_Solrare_OtherInfo:SetShow(true)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Solrare_OtherInfo:ignorePadSnapMoveToOtherPanel(true)
    ToClient_padSnapSetTargetPanel(Panel_Solrare_OtherInfo)
  end
end
function PaGlobal_Solrare_OtherInfo:close()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  Panel_Solrare_OtherInfo:SetShow(false)
  if _ContentsGroup_UsePadSnapping == true then
    Panel_Solrare_OtherInfo:ignorePadSnapMoveToOtherPanel(false)
  end
end
function PaGlobal_Solrare_OtherInfo:updateByRanking(gameMode, index, topIndex)
  local recordInfo = ToClient_GetSolareRankingByIndex(gameMode, index)
  if nil == recordInfo then
    return
  end
  local classType = recordInfo:getClassTypeRaw(topIndex)
  local className = getCharacterClassName(classType)
  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_RankIcon, recordInfo:getRankRating())
  PaGlobalFunc_Util_SetSolrareRankingClassBigBG(self._ui._stc_ClassIcon, classType)
  self._ui._txt_Score:SetText(tostring(recordInfo:getRankRating()))
  self._ui._txt_Name:SetText(tostring(recordInfo:getName()))
  self._ui._stc_Awaken:SetShow(false)
  self._ui._stc_Succesion:SetShow(false)
  local branch = recordInfo:getSkillBranch(topIndex)
  local branchName = ""
  if branch == __eSkillTypeParam_Normal then
    self._ui._stc_Succesion:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION")
  elseif branch == __eSkillTypeParam_Awaken then
    self._ui._stc_Awaken:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN")
  elseif branch == __eSkillTypeParam_Inherit then
    self._ui._stc_Succesion:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION")
  end
  if classType == __eClassType_ShyWaman or classType == __eClassType_RangerMan or classType == __eClassType_Scholar or classType == __eClassType_PWGE or classType == __eClassType_PJKD or classType == __eClassType_PDKL then
    self._ui._stc_Awaken:SetShow(false)
    self._ui._stc_Succesion:SetShow(false)
    branchName = ""
  end
  _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\150\180\235\185\132\236\138\164\236\155\144 \235\182\132\235\166\172\237\152\149 \236\132\156\235\184\140 \236\158\144\236\155\144 UI", "\236\161\176\234\180\145\235\175\188")
  if branchName == "" then
    self._ui._txt_Class:SetText(className)
  else
    self._ui._txt_Class:SetText(className .. "(" .. branchName .. ")")
  end
  for idx = 0, 6 do
    local equipSlotNo = self._eEquipSlot[idx]
    local itemWrapper = ToClient_GetSolareRankingInfoEquipItemWrapper(gameMode, index, topIndex, equipSlotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        self._ui._stc_EquipMainSlot[idx]:clearItem()
        self._ui._stc_EquipMainSlot[idx]:setItemByStaticStatus(itemSSW)
        self._ui._stc_EquipMainSlot[idx]._item = itemSSW:getItemKey()
        self._ui._stc_EquipMainSlot[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowTotalRankingItemTooltip(true," .. tostring(idx) .. "," .. tostring(index) .. "," .. tostring(topIndex) .. "," .. tostring(equipSlotNo) .. ")")
        self._ui._stc_EquipMainSlot[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowTotalRankingItemTooltip()")
        if _ContentsGroup_UsePadSnapping == true then
        end
      end
    end
  end
  for idx = 0, 6 do
    local equipSlotNo = self._eEquipSlot[idx + 7]
    local itemWrapper = ToClient_GetSolareRankingInfoEquipItemWrapper(gameMode, index, topIndex, equipSlotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        self._ui._stc_EquipAcceSlot[idx]:clearItem()
        self._ui._stc_EquipAcceSlot[idx]:setItemByStaticStatus(itemSSW)
        self._ui._stc_EquipAcceSlot[idx]._item = itemSSW:getItemKey()
        self._ui._stc_EquipAcceSlot[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowTotalRankingItemTooltip(false," .. tostring(idx) .. "," .. tostring(index) .. "," .. tostring(topIndex) .. "," .. tostring(equipSlotNo) .. ")")
        self._ui._stc_EquipAcceSlot[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowTotalRankingItemTooltip()")
      end
    end
  end
  for idx = 0, 5 do
    local skillSSW = ToClient_GetSolareRankingInfoAwakenSkill(gameMode, index, topIndex, idx)
    if skillSSW == nil then
      self._ui._stc_Skill[idx].none:SetShow(true)
      self._ui._stc_Skill[idx].slotBg:SetShow(false)
      self._ui._stc_Skill[idx].icon:SetShow(false)
      self._ui._stc_Skill[idx].title:SetShow(false)
      self._ui._stc_Skill[idx].titleInfo:SetShow(false)
      self._ui._stc_Skill[idx].effect:SetShow(false)
      self._ui._stc_Skill[idx].eff1:SetShow(false)
      self._ui._stc_Skill[idx].eff2:SetShow(false)
    else
      self._ui._stc_Skill[idx].none:SetShow(false)
      self._ui._stc_Skill[idx].slotBg:SetShow(true)
      self._ui._stc_Skill[idx].icon:SetShow(true)
      self._ui._stc_Skill[idx].title:SetShow(true)
      self._ui._stc_Skill[idx].titleInfo:SetShow(true)
      self._ui._stc_Skill[idx].effect:SetShow(true)
      self._ui._stc_Skill[idx].eff1:SetShow(true)
      self._ui._stc_Skill[idx].eff2:SetShow(true)
      local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
      local skillNo = skillSSW:getSkillNo()
      self._ui._stc_Skill[idx].title:SetText(skillSSW:getName())
      self._ui._stc_Skill[idx].titleInfo:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui._stc_Skill[idx].titleInfo:setLineCountByLimitAutoWrap(2)
      self._ui._stc_Skill[idx].titleInfo:SetText(skillTypeSSW:getDescription())
      self._ui._stc_Skill[idx].icon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
      if self._ui._stc_Skill[idx].titleInfo:IsLimitText() then
        self._ui._stc_Skill[idx].title:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
        self._ui._stc_Skill[idx].title:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
      end
      local optionIndex1 = recordInfo:getAbility(topIndex, idx, 0)
      local optionIndex2 = recordInfo:getAbility(topIndex, idx, 1)
      if optionIndex1 ~= -1 then
        self._ui._stc_Skill[idx].eff1:SetTextMode(__eTextMode_LimitText)
        self._ui._stc_Skill[idx].eff1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
        self._ui._stc_Skill[idx].eff1:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRankingSkillToolTip(" .. index .. ", " .. 1 .. "," .. idx .. "," .. optionIndex1 .. ")")
        self._ui._stc_Skill[idx].eff1:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRankingSkillToolTip()")
      end
      if optionIndex2 ~= -1 then
        self._ui._stc_Skill[idx].eff2:SetTextMode(__eTextMode_LimitText)
        self._ui._stc_Skill[idx].eff2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
        self._ui._stc_Skill[idx].eff2:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRankingSkillToolTip(" .. index .. ", " .. 2 .. "," .. idx .. "," .. optionIndex2 .. ")")
        self._ui._stc_Skill[idx].eff2:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRankingSkillToolTip()")
      end
    end
  end
end
function PaGlobal_Solrare_OtherInfo:updateByClassRanking(gameMode, index, rankClassType, topIndex)
  local recordInfo = ToClient_GetSolareClassRankingByIndex(gameMode, rankClassType, index)
  if recordInfo == nil then
    return
  end
  local topIndexClassType = recordInfo:getClassTypeRaw(topIndex)
  local className = getCharacterClassName(topIndexClassType)
  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_RankIcon, recordInfo:getRankRating())
  PaGlobalFunc_Util_SetSolrareRankingClassBigBG(self._ui._stc_ClassIcon, topIndexClassType)
  self._ui._txt_Score:SetText(tostring(recordInfo:getRankRating()))
  self._ui._txt_Name:SetText(tostring(recordInfo:getName()))
  self._ui._stc_Awaken:SetShow(false)
  self._ui._stc_Succesion:SetShow(false)
  local branch = recordInfo:getSkillBranch(topIndex)
  local branchName = ""
  if branch == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(topIndexClassType) == true then
    branch = __eSkillTypeParam_Inherit
  end
  if branch == __eSkillTypeParam_Normal then
    self._ui._stc_Succesion:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN")
  elseif branch == __eSkillTypeParam_Awaken then
    self._ui._stc_Awaken:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN")
  elseif branch == __eSkillTypeParam_Inherit then
    self._ui._stc_Succesion:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION")
  end
  if topIndexClassType == __eClassType_ShyWaman or topIndexClassType == __eClassType_RangerMan or topIndexClassType == __eClassType_Scholar or topIndexClassType == __eClassType_PWGE or topIndexClassType == __eClassType_PJKD then
    branchName = ""
    self._ui._stc_Awaken:SetShow(false)
    self._ui._stc_Succesion:SetShow(false)
  end
  if branchName == "" then
    self._ui._txt_Class:SetText(className)
  else
    self._ui._txt_Class:SetText(className .. "(" .. branchName .. ")")
  end
  for idx = 0, 6 do
    local equipSlotNo = self._eEquipSlot[idx]
    local itemWrapper = ToClient_GetSolareClassRankingInfoEquipItemWrapper(gameMode, rankClassType, index, topIndex, equipSlotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        self._ui._stc_EquipMainSlot[idx]:clearItem()
        self._ui._stc_EquipMainSlot[idx]:setItemByStaticStatus(itemSSW)
        self._ui._stc_EquipMainSlot[idx]._item = itemSSW:getItemKey()
        self._ui._stc_EquipMainSlot[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowClassRankingItemTooltip(true," .. tostring(idx) .. "," .. tostring(rankClassType) .. "," .. tostring(index) .. "," .. tostring(topIndex) .. "," .. tostring(equipSlotNo) .. ")")
        self._ui._stc_EquipMainSlot[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowClassRankingItemTooltip()")
      end
    end
  end
  for idx = 0, 6 do
    local equipSlotNo = self._eEquipSlot[idx + 7]
    local itemWrapper = ToClient_GetSolareClassRankingInfoEquipItemWrapper(gameMode, rankClassType, index, topIndex, equipSlotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        self._ui._stc_EquipAcceSlot[idx]:clearItem()
        self._ui._stc_EquipAcceSlot[idx]:setItemByStaticStatus(itemSSW)
        self._ui._stc_EquipAcceSlot[idx]._item = itemSSW:getItemKey()
        self._ui._stc_EquipAcceSlot[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowClassRankingItemTooltip(false," .. tostring(idx) .. "," .. tostring(rankClassType) .. "," .. tostring(index) .. "," .. tostring(topIndex) .. "," .. tostring(equipSlotNo) .. ")")
        self._ui._stc_EquipAcceSlot[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowClassRankingItemTooltip()")
      end
    end
  end
  for idx = 0, 5 do
    local skillSSW = ToClient_GetSolareClassRankingInfoAwakenSkill(gameMode, rankClassType, index, topIndex, idx)
    if skillSSW == nil then
      self._ui._stc_Skill[idx].none:SetShow(true)
      self._ui._stc_Skill[idx].slotBg:SetShow(false)
      self._ui._stc_Skill[idx].icon:SetShow(false)
      self._ui._stc_Skill[idx].title:SetShow(false)
      self._ui._stc_Skill[idx].titleInfo:SetShow(false)
      self._ui._stc_Skill[idx].effect:SetShow(false)
      self._ui._stc_Skill[idx].eff1:SetShow(false)
      self._ui._stc_Skill[idx].eff2:SetShow(false)
    else
      self._ui._stc_Skill[idx].none:SetShow(false)
      self._ui._stc_Skill[idx].slotBg:SetShow(true)
      self._ui._stc_Skill[idx].icon:SetShow(true)
      self._ui._stc_Skill[idx].title:SetShow(true)
      self._ui._stc_Skill[idx].titleInfo:SetShow(true)
      self._ui._stc_Skill[idx].effect:SetShow(true)
      self._ui._stc_Skill[idx].eff1:SetShow(true)
      self._ui._stc_Skill[idx].eff2:SetShow(true)
      local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
      local skillNo = skillSSW:getSkillNo()
      self._ui._stc_Skill[idx].title:SetText(skillSSW:getName())
      self._ui._stc_Skill[idx].titleInfo:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui._stc_Skill[idx].titleInfo:setLineCountByLimitAutoWrap(2)
      self._ui._stc_Skill[idx].titleInfo:SetText(skillTypeSSW:getDescription())
      self._ui._stc_Skill[idx].icon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
      if self._ui._stc_Skill[idx].titleInfo:IsLimitText() then
        self._ui._stc_Skill[idx].title:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
        self._ui._stc_Skill[idx].title:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
      end
      local optionIndex1 = recordInfo:getAbility(topIndex, idx, 0)
      local optionIndex2 = recordInfo:getAbility(topIndex, idx, 1)
      if optionIndex1 ~= -1 then
        self._ui._stc_Skill[idx].eff1:SetTextMode(__eTextMode_LimitText)
        self._ui._stc_Skill[idx].eff1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
        self._ui._stc_Skill[idx].eff1:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip(" .. index .. ", " .. 1 .. "," .. idx .. "," .. optionIndex1 .. ")")
        self._ui._stc_Skill[idx].eff1:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip()")
      end
      if optionIndex2 ~= -1 then
        self._ui._stc_Skill[idx].eff2:SetTextMode(__eTextMode_LimitText)
        self._ui._stc_Skill[idx].eff2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
        self._ui._stc_Skill[idx].eff2:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip(" .. index .. ", " .. 2 .. "," .. idx .. "," .. optionIndex2 .. ")")
        self._ui._stc_Skill[idx].eff2:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip()")
      end
    end
  end
end
function PaGlobal_Solrare_OtherInfo:updateByRecord(index)
  local recordInfo = ToClient_GetSolareMyRecentRecordIndex(index)
  if nil == recordInfo then
    return
  end
  local classType = recordInfo:getClassTypeRaw()
  local className = getCharacterClassName(classType)
  PaGlobalFunc_Solrare_Ranking_SetTierIconByScore(self._ui._stc_RankIcon, Int64toInt32(recordInfo:getUserRankRating64()))
  PaGlobalFunc_Util_SetSolrareRankingClassBigBG(self._ui._stc_ClassIcon, classType)
  self._ui._txt_Score:SetText(tostring(Int64toInt32(recordInfo:getUserRankRating64())))
  self._ui._txt_Name:SetText(tostring(recordInfo:getName()))
  local recordGameMode = recordInfo:getMode()
  if recordGameMode == __eSolareMode_Normal_1vs1 or recordGameMode == __eSolareMode_Normal_3vs3 or recordGameMode == __eSolareMode_Custom then
    self._ui._stc_RankIcon:SetShow(false)
    self._ui._txt_Score:SetShow(false)
  else
    self._ui._stc_RankIcon:SetShow(true)
    self._ui._txt_Score:SetShow(true)
  end
  self._ui._stc_Awaken:SetShow(false)
  self._ui._stc_Succesion:SetShow(false)
  local branch = recordInfo:getSkillBranch()
  local branchName = ""
  if branch == __eSkillTypeParam_Normal and PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(classType) == true then
    branch = __eSkillTypeParam_Inherit
  end
  if branch == __eSkillTypeParam_Normal then
    self._ui._stc_Succesion:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION")
  elseif branch == __eSkillTypeParam_Awaken then
    self._ui._stc_Awaken:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN")
  elseif branch == __eSkillTypeParam_Inherit then
    self._ui._stc_Succesion:SetShow(true)
    branchName = PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION")
  end
  if classType == __eClassType_ShyWaman or classType == __eClassType_RangerMan or classType == __eClassType_Scholar or classType == __eClassType_PWGE or classType == __eClassType_PJKD or classType == __eClassType_PDKL then
    branchName = ""
    self._ui._stc_Awaken:SetShow(false)
    self._ui._stc_Succesion:SetShow(false)
  end
  _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. \236\150\180\235\185\132\236\138\164\236\155\144 \235\182\132\235\166\172\237\152\149 \236\132\156\235\184\140 \236\158\144\236\155\144 UI", "\236\161\176\234\180\145\235\175\188")
  if branchName == "" then
    self._ui._txt_Class:SetText(className)
  else
    self._ui._txt_Class:SetText(className .. "(" .. branchName .. ")")
  end
  for idx = 0, 6 do
    local equipSlotNo = self._eEquipSlot[idx]
    local itemWrapper = ToClient_GetSolareRecentRecordInfoEquipItemWrapper(index, equipSlotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        self._ui._stc_EquipMainSlot[idx]:clearItem()
        self._ui._stc_EquipMainSlot[idx]:setItemByStaticStatus(itemSSW)
        self._ui._stc_EquipMainSlot[idx]._item = itemSSW:getItemKey()
        self._ui._stc_EquipMainSlot[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentRecordItemTooltip(true," .. tostring(idx) .. "," .. tostring(index) .. "," .. tostring(equipSlotNo) .. ")")
        self._ui._stc_EquipMainSlot[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentRecordItemTooltip()")
      end
    end
  end
  for idx = 0, 6 do
    local equipSlotNo = self._eEquipSlot[idx + 7]
    local itemWrapper = ToClient_GetSolareRecentRecordInfoEquipItemWrapper(index, equipSlotNo)
    if itemWrapper ~= nil then
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        self._ui._stc_EquipAcceSlot[idx]:clearItem()
        self._ui._stc_EquipAcceSlot[idx]:setItemByStaticStatus(itemSSW)
        self._ui._stc_EquipAcceSlot[idx]._item = itemSSW:getItemKey()
        self._ui._stc_EquipAcceSlot[idx].icon:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentRecordItemTooltip(false," .. tostring(idx) .. "," .. tostring(index) .. "," .. tostring(equipSlotNo) .. ")")
        self._ui._stc_EquipAcceSlot[idx].icon:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentRecordItemTooltip()")
      end
    end
  end
  for idx = 0, 5 do
    local skillSSW = ToClient_GetSolareRecentRecordInfoAwakenSkill(index, idx)
    if skillSSW == nil then
      self._ui._stc_Skill[idx].none:SetShow(true)
      self._ui._stc_Skill[idx].slotBg:SetShow(false)
      self._ui._stc_Skill[idx].icon:SetShow(false)
      self._ui._stc_Skill[idx].title:SetShow(false)
      self._ui._stc_Skill[idx].titleInfo:SetShow(false)
      self._ui._stc_Skill[idx].effect:SetShow(false)
      self._ui._stc_Skill[idx].eff1:SetShow(false)
      self._ui._stc_Skill[idx].eff2:SetShow(false)
    else
      self._ui._stc_Skill[idx].none:SetShow(false)
      self._ui._stc_Skill[idx].slotBg:SetShow(true)
      self._ui._stc_Skill[idx].icon:SetShow(true)
      self._ui._stc_Skill[idx].title:SetShow(true)
      self._ui._stc_Skill[idx].titleInfo:SetShow(true)
      self._ui._stc_Skill[idx].effect:SetShow(true)
      self._ui._stc_Skill[idx].eff1:SetShow(true)
      self._ui._stc_Skill[idx].eff2:SetShow(true)
      local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
      local skillNo = skillSSW:getSkillNo()
      self._ui._stc_Skill[idx].title:SetText(skillSSW:getName())
      self._ui._stc_Skill[idx].titleInfo:SetTextMode(__eTextMode_Limit_AutoWrap)
      self._ui._stc_Skill[idx].titleInfo:setLineCountByLimitAutoWrap(2)
      self._ui._stc_Skill[idx].titleInfo:SetText(skillTypeSSW:getDescription())
      self._ui._stc_Skill[idx].icon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
      if self._ui._stc_Skill[idx].titleInfo:IsLimitText() then
        self._ui._stc_Skill[idx].title:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwakenSet\")")
        self._ui._stc_Skill[idx].title:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
      end
      local optionIndex1 = recordInfo:getAbility(idx, 0)
      local optionIndex2 = recordInfo:getAbility(idx, 1)
      if optionIndex1 ~= -1 then
        self._ui._stc_Skill[idx].eff1:SetTextMode(__eTextMode_LimitText)
        self._ui._stc_Skill[idx].eff1:SetText(skillSSW:getSkillAwakenDescription(optionIndex1))
        self._ui._stc_Skill[idx].eff1:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip(" .. index .. ", " .. 1 .. "," .. idx .. "," .. optionIndex1 .. ")")
        self._ui._stc_Skill[idx].eff1:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip()")
      end
      if optionIndex2 ~= -1 then
        self._ui._stc_Skill[idx].eff2:SetTextMode(__eTextMode_LimitText)
        self._ui._stc_Skill[idx].eff2:SetText(skillSSW:getSkillAwakenDescription(optionIndex2))
        self._ui._stc_Skill[idx].eff2:addInputEvent("Mouse_On", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip(" .. index .. ", " .. 2 .. "," .. idx .. "," .. optionIndex2 .. ")")
        self._ui._stc_Skill[idx].eff2:addInputEvent("Mouse_Out", "PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip()")
      end
    end
  end
end
function PaGlobalFunc_Solrare_OtherInfo_ShowRecentRecordItemTooltip(isMain, equipSlotIndex, index, equipSlotNo)
  if isMain == nil or equipSlotIndex == nil or index == nil or equipSlotNo == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = ToClient_GetSolareRecentRecordInfoEquipItemWrapper(index, equipSlotNo)
  if itemWrapper == nil then
    return
  end
  local slot
  if isMain == true then
    slot = PaGlobal_Solrare_OtherInfo._ui._stc_EquipMainSlot[equipSlotIndex].icon
  else
    slot = PaGlobal_Solrare_OtherInfo._ui._stc_EquipAcceSlot[equipSlotIndex].icon
  end
  Panel_Tooltip_Item_Show(itemWrapper, slot, false, true, nil, nil, nil, nil, "Solrare_OtherInfo")
end
function PaGlobalFunc_Solrare_OtherInfo_ShowTotalRankingItemTooltip(isMain, equipSlotIndex, index, topIndex, equipSlotNo)
  if isMain == nil or equipSlotIndex == nil or index == nil or topIndex == nil or equipSlotNo == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local gameMode = PaGlobalFunc_SolareRank_GetCurrentGameMode()
  local itemWrapper = ToClient_GetSolareRankingInfoEquipItemWrapper(gameMode, index, topIndex, equipSlotNo)
  if itemWrapper == nil then
    return
  end
  local slot
  if isMain == true then
    slot = PaGlobal_Solrare_OtherInfo._ui._stc_EquipMainSlot[equipSlotIndex].icon
  else
    slot = PaGlobal_Solrare_OtherInfo._ui._stc_EquipAcceSlot[equipSlotIndex].icon
  end
  Panel_Tooltip_Item_Show(itemWrapper, slot, false, true, nil, nil, nil, nil, "Solrare_OtherInfo")
end
function PaGlobalFunc_Solrare_OtherInfo_ShowClassRankingItemTooltip(isMain, equipSlotIndex, rankClassType, index, topIndex, equipSlotNo)
  if isMain == nil or equipSlotIndex == nil or rankClassType == nil or index == nil or topIndex == nil or equipSlotNo == nil then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local gameMode = PaGlobalFunc_SolareRank_GetCurrentGameMode()
  local itemWrapper = ToClient_GetSolareClassRankingInfoEquipItemWrapper(gameMode, rankClassType, index, topIndex, equipSlotNo)
  if itemWrapper == nil then
    return
  end
  local slot
  if isMain == true then
    slot = PaGlobal_Solrare_OtherInfo._ui._stc_EquipMainSlot[equipSlotIndex].icon
  else
    slot = PaGlobal_Solrare_OtherInfo._ui._stc_EquipAcceSlot[equipSlotIndex].icon
  end
  Panel_Tooltip_Item_Show(itemWrapper, slot, false, true, nil, nil, nil, nil, "Solrare_OtherInfo")
end
function PaGlobalFunc_Solrare_OtherInfo_ShowRankingSkillToolTip(recordIndex, uiIndex, index, optionIndex)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  local gameMode = PaGlobalFunc_SolareRank_GetCurrentGameMode()
  local skillSSW = ToClient_GetSolareRankingInfoAwakenSkill(gameMode, recordIndex, 0, index)
  if skillSSW == nil then
    TooltipSimple_Hide()
    return
  end
  local control
  if uiIndex == 1 then
    control = PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff1
  else
    control = PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff2
  end
  if _ContentsGroup_UsePadSnapping == true then
    TooltipSimple_Show(control, "", PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff1:GetText() .. "\n" .. PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff2:GetText())
  else
    TooltipSimple_Show(control, skillSSW:getSkillAwakenDescription(optionIndex))
  end
end
function PaGlobalFunc_Solrare_OtherInfo_ShowRecentSkillToolTip(recordIndex, uiIndex, index, optionIndex)
  if nil == index then
    TooltipSimple_Hide()
    return
  end
  local skillSSW = ToClient_GetSolareRecentRecordInfoAwakenSkill(recordIndex, index)
  if skillSSW == nil then
    TooltipSimple_Hide()
    return
  end
  local control
  if uiIndex == 1 then
    control = PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff1
  else
    control = PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff2
  end
  if _ContentsGroup_UsePadSnapping == true then
    TooltipSimple_Show(control, "", PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff1:GetText() .. "\n" .. PaGlobal_Solrare_OtherInfo._ui._stc_Skill[index].eff2:GetText())
  else
    TooltipSimple_Show(control, skillSSW:getSkillAwakenDescription(optionIndex))
  end
end
function PaGlobalFunc_Solrare_OtherInfo_OpenByRanking(index, topIndex)
  local gameMode = PaGlobalFunc_SolareRank_GetCurrentGameMode()
  PaGlobal_Solrare_OtherInfo:updateByRanking(gameMode, index, topIndex)
  PaGlobal_Solrare_OtherInfo:open()
end
function PaGlobalFunc_Solrare_OtherInfo_OpenByClassRanking(index, classType, topIndex)
  local gameMode = PaGlobalFunc_SolareRank_GetCurrentGameMode()
  PaGlobal_Solrare_OtherInfo:updateByClassRanking(gameMode, index, classType, topIndex)
  PaGlobal_Solrare_OtherInfo:open()
end
function PaGlobalFunc_Solrare_OtherInfo_OpenByRecord(index)
  PaGlobal_Solrare_OtherInfo:updateByRecord(index)
  PaGlobal_Solrare_OtherInfo:open()
end
function PaGlobalFunc_Solrare_OtherInfo_Close()
  PaGlobal_Solrare_OtherInfo:close()
end
