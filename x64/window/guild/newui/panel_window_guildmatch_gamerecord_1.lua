function PaGlobal_GuildMatchGameRecord:initialize()
  if self._initialize == true then
    return
  end
  local titleBg = UI.getChildControl(Panel_Window_GuildMatch_GameRecord, "Static_Title_Bg")
  self._ui._btn_close = UI.getChildControl(titleBg, "Button_Close")
  local bodyBg = UI.getChildControl(Panel_Window_GuildMatch_GameRecord, "Static_BodyArea")
  self._ui._cbx_gameList = UI.getChildControl(bodyBg, "Combobox_1")
  self._ui._stc_comboBoxList = UI.getChildControl(self._ui._cbx_gameList, "Combobox_1_List")
  local myGuildBg = UI.getChildControl(bodyBg, "Static_MyGuildBg")
  self._ui._txt_MyguildName = UI.getChildControl(myGuildBg, "StaticText_Title_Name")
  self._ui._lst_MyGuildRecord = UI.getChildControl(myGuildBg, "List2_MemberList")
  local targetGuildBg = UI.getChildControl(bodyBg, "Static_OpponentBg")
  self._ui._txt_TargetGuildName = UI.getChildControl(targetGuildBg, "StaticText_Title_Name")
  self._ui._lst_TargetGuildRecord = UI.getChildControl(targetGuildBg, "List2_MemberList")
  self._ui._stc_myGuild_killDeath = UI.getChildControl(myGuildBg, "StaticText_Title_KDA")
  self._ui._stc_myGuild_heal = UI.getChildControl(myGuildBg, "StaticText_Title_Heal")
  self._ui._stc_myGuild_takeDamage = UI.getChildControl(myGuildBg, "StaticText_Title_Harm")
  self._ui._stc_myGuild_giveDamage = UI.getChildControl(myGuildBg, "StaticText_Title_Damage")
  self._ui._stc_myGuild_ccCount = UI.getChildControl(myGuildBg, "StaticText_Title_CCCount")
  self._ui._stc_enemyGuild_killDeath = UI.getChildControl(targetGuildBg, "StaticText_Title_KDA")
  self._ui._stc_enemyGuild_heal = UI.getChildControl(targetGuildBg, "StaticText_Title_Heal")
  self._ui._stc_enemyGuild_takeDamage = UI.getChildControl(targetGuildBg, "StaticText_Title_Harm")
  self._ui._stc_enemyGuild_giveDamage = UI.getChildControl(targetGuildBg, "StaticText_Title_Damage")
  self._ui._stc_enemyGuild_ccCount = UI.getChildControl(targetGuildBg, "StaticText_Title_CCCount")
  self._ui._lst_MyGuildRecord:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildMatchGameRecord_OnCreateListContent")
  self._ui._lst_MyGuildRecord:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._lst_TargetGuildRecord:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildMatchGameRecord_OnCreateListContent")
  self._ui._lst_TargetGuildRecord:createChildContent(__ePAUIList2ElementManagerType_List)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_GuildMatchGameRecord:registEventHandler()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildMatchGameRecord_Close()")
  self._ui._stc_myGuild_killDeath:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(0, " .. tostring(__eGuildMatchPersonalRecordSortOption_KillDeath) .. ")")
  self._ui._stc_myGuild_killDeath:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, true, 1)")
  self._ui._stc_myGuild_killDeath:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, true, 1)")
  self._ui._stc_myGuild_heal:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(0, " .. tostring(__eGuildMatchPersonalRecordSortOption_Recovery) .. ")")
  self._ui._stc_myGuild_heal:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, true, 2)")
  self._ui._stc_myGuild_heal:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, true, 2)")
  self._ui._stc_myGuild_takeDamage:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(0, " .. tostring(__eGuildMatchPersonalRecordSortOption_TakeDamage) .. ")")
  self._ui._stc_myGuild_takeDamage:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, true, 3)")
  self._ui._stc_myGuild_takeDamage:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, true, 3)")
  self._ui._stc_myGuild_giveDamage:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(0, " .. tostring(__eGuildMatchPersonalRecordSortOption_GiveDamage) .. ")")
  self._ui._stc_myGuild_giveDamage:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, true, 4)")
  self._ui._stc_myGuild_giveDamage:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, true, 4)")
  self._ui._stc_myGuild_ccCount:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(0, " .. tostring(__eGuildMatchPersonalRecordSortOption_CCCount) .. ")")
  self._ui._stc_myGuild_ccCount:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, true, 5)")
  self._ui._stc_myGuild_ccCount:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, true, 5)")
  self._ui._stc_enemyGuild_killDeath:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(1, " .. tostring(__eGuildMatchPersonalRecordSortOption_KillDeath) .. ")")
  self._ui._stc_enemyGuild_killDeath:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, false, 1)")
  self._ui._stc_enemyGuild_killDeath:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, false, 1)")
  self._ui._stc_enemyGuild_heal:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(1, " .. tostring(__eGuildMatchPersonalRecordSortOption_Recovery) .. ")")
  self._ui._stc_enemyGuild_heal:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, false, 2)")
  self._ui._stc_enemyGuild_heal:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, false, 2)")
  self._ui._stc_enemyGuild_takeDamage:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(1, " .. tostring(__eGuildMatchPersonalRecordSortOption_TakeDamage) .. ")")
  self._ui._stc_enemyGuild_takeDamage:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, false, 3)")
  self._ui._stc_enemyGuild_takeDamage:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, false, 3)")
  self._ui._stc_enemyGuild_giveDamage:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(1, " .. tostring(__eGuildMatchPersonalRecordSortOption_GiveDamage) .. ")")
  self._ui._stc_enemyGuild_giveDamage:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, false, 4)")
  self._ui._stc_enemyGuild_giveDamage:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, false, 4)")
  self._ui._stc_enemyGuild_ccCount:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_Sort(1, " .. tostring(__eGuildMatchPersonalRecordSortOption_CCCount) .. ")")
  self._ui._stc_enemyGuild_ccCount:addInputEvent("Mouse_On", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(true, false, 5)")
  self._ui._stc_enemyGuild_ccCount:addInputEvent("Mouse_Out", "HandleEventLUp_GuildMatchGameRecord_ShowLimitTextToolTip(false, false, 5)")
  registerEvent("FromClient_GuildMatchPersonalRecordSortResult", "FromClient_GuildMatchPersonalRecordSortResult")
end
function PaGlobal_GuildMatchGameRecord:validate()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._cbx_gameList:isValidate()
  self._ui._stc_comboBoxList:isValidate()
  self._ui._txt_MyguildName:isValidate()
  self._ui._lst_MyGuildRecord:isValidate()
  self._ui._txt_TargetGuildName:isValidate()
  self._ui._lst_TargetGuildRecord:isValidate()
  self._ui._stc_myGuild_killDeath:isValidate()
  self._ui._stc_myGuild_heal:isValidate()
  self._ui._stc_myGuild_takeDamage:isValidate()
  self._ui._stc_myGuild_giveDamage:isValidate()
  self._ui._stc_myGuild_ccCount:isValidate()
  self._ui._stc_enemyGuild_killDeath:isValidate()
  self._ui._stc_enemyGuild_heal:isValidate()
  self._ui._stc_enemyGuild_takeDamage:isValidate()
  self._ui._stc_enemyGuild_giveDamage:isValidate()
  self._ui._stc_enemyGuild_ccCount:isValidate()
end
function PaGlobal_GuildMatchGameRecord:prepareOpen()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  ToClient_ClearGuildMatchPersonalRecordSortInfo()
  self:resetRecordTitleText(nil)
  self:updateComboBox()
  self:updateRecordList()
  self:open()
end
function PaGlobal_GuildMatchGameRecord:open()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  Panel_Window_GuildMatch_GameRecord:SetShow(true)
end
function PaGlobal_GuildMatchGameRecord:prepareClose()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  TooltipSimple_Hide()
  if self._ui._stc_comboBoxList:GetShow() == true then
    self._ui._cbx_gameList:ToggleListbox()
  end
  self:close()
end
function PaGlobal_GuildMatchGameRecord:close()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  Panel_Window_GuildMatch_GameRecord:SetShow(false)
end
function PaGlobal_GuildMatchGameRecord:updateComboBox()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  self._ui._cbx_gameList:GetListControl():AddSelectEvent("HandleEventLUp_GuildMatchGameRecord_UpdateRecordList()")
  self._ui._cbx_gameList:DeleteAllItem(0)
  self._ui._cbx_gameList:setListTextHorizonCenter()
  local gameRecordCount = ToClient_GetGuildMatchGameRecordCount()
  if gameRecordCount == 0 then
    self._ui._cbx_gameList:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_RECORD_OMBOBOXEMPTY"))
  else
    for gameIndex = 0, gameRecordCount - 1 do
      local gameTime_s64 = ToClient_GetGuildMatchGameRecordTime(gameIndex)
      local paTime = PATime(gameTime_s64)
      local year = tostring(paTime:GetYear())
      local month = tostring(paTime:GetMonth())
      local day = tostring(paTime:GetDay())
      local hour = tostring(paTime:GetHour())
      local min = tostring(paTime:GetMinute())
      if paTime:GetMonth() < 10 then
        month = "0" .. month
      end
      if paTime:GetDay() < 10 then
        day = "0" .. day
      end
      if paTime:GetHour() < 10 then
        hour = "0" .. hour
      end
      if paTime:GetMinute() < 10 then
        min = "0" .. min
      end
      local myGuildResult = ToClient_GetGuildMatchPersonalRecordResult(gameIndex, 0)
      local myGuildMatchingType = ToClient_GetGuildMatchPersonalRecordMatchingType(gameIndex, 0)
      local resultString = ""
      local machingTypeString = ""
      if _ContentsGroup_GuildMatchRenewMatching == true then
        machingTypeString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_MATCHING_TYPE_" .. tostring(myGuildMatchingType)) .. "] "
      end
      if myGuildResult == __eGuildMatchResultType_Win then
        resultString = "<PAColor0xff77c2ff>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YARR_WIN") .. "<PAOldColor>"
      elseif myGuildResult == __eGuildMatchResultType_Lose then
        resultString = "<PAColor0xffff826b>" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YARR_LOSE") .. "<PAOldColor>"
      end
      local dateString = PAGetStringParam4(Defines.StringSheet_GAME, "LUA_GUILDMATCH_RECORD_COMBOBOXDATE", "year", year, "month", month, "day", day, "hour", hour .. ":" .. min)
      local enemyGuildNameString = ToClient_GetGuildMatchPersonalRecordGuildName(gameIndex, 1)
      local descString = machingTypeString .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_GUILDMATCH_RECORD_COMBOBOXITEM", "date", dateString, "result", resultString, "guildName", enemyGuildNameString)
      self._ui._cbx_gameList:AddItem(descString)
    end
  end
  self._ui._cbx_gameList:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildMatchGameRecord_ToggleComboBox()")
  self._ui._cbx_gameList:SetSelectItemIndex(self._currentGameIndex)
end
function PaGlobal_GuildMatchGameRecord:updateRecordList()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  self:updateMyGuildRecordList()
  self:updateEnemyGuildRecordList()
end
function PaGlobal_GuildMatchGameRecord:updateMyGuildRecordList()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  self._cacheInfo._myGuildAceIndex = ToClient_GetGuildMatchPersonalRecordAceIndex(self._currentGameIndex, 0)
  local myGuildListManager = self._ui._lst_MyGuildRecord:getElementManager()
  if myGuildListManager == nil then
    return
  end
  myGuildListManager:clearKey()
  local personalRecordInfoCount = ToClient_GetGuildMatchPersonalRecordCountFromMyGuild(self._currentGameIndex)
  for index = 0, personalRecordInfoCount - 1 do
    myGuildListManager:pushKey(toInt64(0, index))
  end
  local myGuildNameString = ToClient_GetGuildMatchPersonalRecordGuildName(self._currentGameIndex, 0)
  local myGuildResult = ToClient_GetGuildMatchPersonalRecordResult(self._currentGameIndex, 0)
  local myGuildMatchingType = ToClient_GetGuildMatchPersonalRecordMatchingType(self._currentGameIndex, 0)
  local matchingTypeString = ""
  if _ContentsGroup_GuildMatchRenewMatching == true then
    matchingTypeString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_MATCHING_TYPE_" .. tostring(myGuildMatchingType)) .. "] "
  end
  if myGuildResult == __eGuildMatchResultType_Win then
    myGuildNameString = matchingTypeString .. "<PAColor0xff77c2ff>" .. "[" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YARR_WIN") .. "] " .. "<PAOldColor>" .. myGuildNameString
  elseif myGuildResult == __eGuildMatchResultType_Lose then
    myGuildNameString = matchingTypeString .. "<PAColor0xffff826b>" .. "[" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YARR_LOSE") .. "] " .. "<PAOldColor>" .. myGuildNameString
  end
  self._ui._txt_MyguildName:SetText(myGuildNameString)
end
function PaGlobal_GuildMatchGameRecord:updateEnemyGuildRecordList()
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  self._cacheInfo._enemyGuildAceIndex = ToClient_GetGuildMatchPersonalRecordAceIndex(self._currentGameIndex, 1)
  local targetGuildListManager = self._ui._lst_TargetGuildRecord:getElementManager()
  if targetGuildListManager == nil then
    return
  end
  targetGuildListManager:clearKey()
  local personalRecordInfoCount = ToClient_GetGuildMatchPersonalRecordCountFromTargetGuild(self._currentGameIndex)
  for index = 0, personalRecordInfoCount - 1 do
    targetGuildListManager:pushKey(toInt64(1, index))
  end
  local targetGuildNameString = ToClient_GetGuildMatchPersonalRecordGuildName(self._currentGameIndex, 1)
  local targetGuildResult = ToClient_GetGuildMatchPersonalRecordResult(self._currentGameIndex, 1)
  local targetGuildMatchingType = ToClient_GetGuildMatchPersonalRecordMatchingType(self._currentGameIndex, 1)
  local matchingTypeString = ""
  if _ContentsGroup_GuildMatchRenewMatching == true then
    matchingTypeString = "[" .. PAGetString(Defines.StringSheet_GAME, "LUA_GUILDMATCH_MATCHING_TYPE_" .. tostring(targetGuildMatchingType)) .. "] "
  end
  if targetGuildResult == __eGuildMatchResultType_Win then
    targetGuildNameString = matchingTypeString .. "<PAColor0xff77c2ff>" .. "[" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YARR_WIN") .. "] " .. "<PAOldColor>" .. targetGuildNameString
  elseif targetGuildResult == __eGuildMatchResultType_Lose then
    targetGuildNameString = matchingTypeString .. "<PAColor0xffff826b>" .. "[" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_YARR_LOSE") .. "] " .. "<PAOldColor>" .. targetGuildNameString
  end
  self._ui._txt_TargetGuildName:SetText(targetGuildNameString)
end
function PaGlobal_GuildMatchGameRecord:createPersonalRecordContent(content, key)
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  local gameIndex = self._currentGameIndex
  local guildIndex = highFromUint64(key)
  local recordIndex = lowFromUint64(key)
  local personalRecordInfo = ToClient_GetGuildMatchPersonalRecordInfo(gameIndex, guildIndex, recordIndex)
  if personalRecordInfo == nil then
    return
  end
  local guildNo = personalRecordInfo._guildNo
  local userNo = personalRecordInfo._userNo
  local classTypeRaw = personalRecordInfo._classType:get()
  local skillBranchType = personalRecordInfo._skillBranchType
  local userName = ToClient_GetGuildMatchPersonalRecordUserNickName(gameIndex, guildIndex, recordIndex)
  local killCount = personalRecordInfo._killCount
  local deathCount = personalRecordInfo._deathCount
  local giveCC = personalRecordInfo._giveCC
  local giveDamage = personalRecordInfo._giveDamage
  local takeDamage = personalRecordInfo._takeDamage
  local takeHeal = personalRecordInfo._takeHeal
  local stc_Bg = UI.getChildControl(content, "Static_Member_BG")
  local stc_classType = UI.getChildControl(stc_Bg, "Static_Profile")
  local stc_awaken = UI.getChildControl(stc_Bg, "Static_Type_Awaken")
  local stc_success = UI.getChildControl(stc_Bg, "Static_Type_Succession")
  local stc_shy = UI.getChildControl(stc_Bg, "Static_Type_Shy")
  local stc_archer = UI.getChildControl(stc_Bg, "Static_Type_Archer")
  local stc_scholar = UI.getChildControl(stc_Bg, "Static_Type_Scholar")
  local stc_deadeye = UI.getChildControl(stc_Bg, "Static_Type_DeadEye")
  local stc_ogong = UI.getChildControl(stc_Bg, "Static_Type_Ogong")
  local stc_seraphim = UI.getChildControl(stc_Bg, "Static_Type_Seraphim")
  local stc_name = UI.getChildControl(stc_Bg, "StaticText_Name")
  local stc_kda = UI.getChildControl(stc_Bg, "StaticText_KDA")
  local stc_takeHeal = UI.getChildControl(stc_Bg, "StaticText_Heal")
  local stc_takeDamage = UI.getChildControl(stc_Bg, "StaticText_Harm")
  local stc_giveDamage = UI.getChildControl(stc_Bg, "StaticText_Damage")
  local stc_giveCC = UI.getChildControl(stc_Bg, "StaticText_CCCount")
  local stc_aceIcon = UI.getChildControl(stc_Bg, "Static_Ace")
  PaGlobalFunc_Util_SetSolrareIngameClassBg(stc_classType, classTypeRaw)
  stc_awaken:SetShow(false)
  stc_success:SetShow(false)
  stc_shy:SetShow(false)
  stc_archer:SetShow(false)
  stc_scholar:SetShow(false)
  stc_deadeye:SetShow(false)
  stc_ogong:SetShow(false)
  stc_seraphim:SetShow(false)
  if classTypeRaw == __eClassType_ShyWaman then
    stc_shy:SetShow(true)
  elseif classTypeRaw == __eClassType_RangerMan then
    stc_archer:SetShow(true)
  elseif classTypeRaw == __eClassType_Scholar then
    stc_scholar:SetShow(true)
  elseif classTypeRaw == __eClassType_PWGE then
    stc_deadeye:SetShow(true)
  elseif classTypeRaw == __eClassType_PJKD then
    stc_ogong:SetShow(true)
  elseif classTypeRaw == __eClassType_PDKL then
    stc_seraphim:SetShow(true)
  elseif PaGlobalFunc_Solrare_Ranking_GetBranch(classTypeRaw, skillBranchType) == __eSkillTypeParam_Awaken then
    stc_awaken:SetShow(true)
  else
    stc_success:SetShow(true)
  end
  _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. ", "\236\161\176\236\139\156\236\153\132")
  if userNo == getSelfPlayer():get():getUserNo() then
    stc_name:SetFontColor(Defines.Color.C_FFA3EF00)
  else
    stc_name:SetFontColor(Defines.Color.C_FFD8AD70)
  end
  local isAce = false
  if guildIndex == 0 then
    if self._cacheInfo._myGuildAceIndex == recordIndex then
      isAce = true
    end
  elseif self._cacheInfo._enemyGuildAceIndex == recordIndex then
    isAce = true
  end
  stc_name:SetText(userName)
  stc_kda:SetText(tostring(killCount) .. " / " .. tostring(deathCount))
  stc_takeHeal:SetText(tostring(takeHeal))
  stc_takeDamage:SetText(tostring(takeDamage))
  stc_giveDamage:SetText(tostring(giveDamage))
  stc_giveCC:SetText(tostring(giveCC))
  stc_aceIcon:SetShow(isAce)
end
function PaGlobal_GuildMatchGameRecord:resetRecordTitleText(guildIndex)
  if Panel_Window_GuildMatch_GameRecord == nil then
    return
  end
  local killDeathString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SOLARE_KDA")
  local healString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SOLARE_HEAL")
  local takeDamageString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SOLARE_HARM")
  local giveDamageString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SOLARE_DAMAGE")
  local ccCountString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SOLARE_SUBTITLE_CC")
  if guildIndex == 0 then
    self._ui._stc_myGuild_killDeath:SetText(killDeathString)
    self._ui._stc_myGuild_heal:SetText(healString)
    self._ui._stc_myGuild_takeDamage:SetText(takeDamageString)
    self._ui._stc_myGuild_giveDamage:SetText(giveDamageString)
    self._ui._stc_myGuild_ccCount:SetText(ccCountString)
  elseif guildIndex == 1 then
    self._ui._stc_enemyGuild_killDeath:SetText(killDeathString)
    self._ui._stc_enemyGuild_heal:SetText(healString)
    self._ui._stc_enemyGuild_takeDamage:SetText(takeDamageString)
    self._ui._stc_enemyGuild_giveDamage:SetText(giveDamageString)
    self._ui._stc_enemyGuild_ccCount:SetText(ccCountString)
  else
    self._ui._stc_myGuild_killDeath:SetText(killDeathString)
    self._ui._stc_myGuild_heal:SetText(healString)
    self._ui._stc_myGuild_takeDamage:SetText(takeDamageString)
    self._ui._stc_myGuild_giveDamage:SetText(giveDamageString)
    self._ui._stc_myGuild_ccCount:SetText(ccCountString)
    self._ui._stc_enemyGuild_killDeath:SetText(killDeathString)
    self._ui._stc_enemyGuild_heal:SetText(healString)
    self._ui._stc_enemyGuild_takeDamage:SetText(takeDamageString)
    self._ui._stc_enemyGuild_giveDamage:SetText(giveDamageString)
    self._ui._stc_enemyGuild_ccCount:SetText(ccCountString)
  end
end
