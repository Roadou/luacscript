function PaGlobal_RoseWarScoreBoard:initialize()
  if self._initialize == true then
    return
  end
  local titleBg = UI.getChildControl(Panel_RoseWar_ScoreBoard, "Static_TitleArea")
  self._ui._btn_close = UI.getChildControl(titleBg, "Button_Close")
  local tabBg = UI.getChildControl(Panel_RoseWar_ScoreBoard, "Static_TabBg")
  self._ui._rdo_guild = UI.getChildControl(tabBg, "RadioButton_List_0")
  self._ui._rdo_mercenary = UI.getChildControl(tabBg, "RadioButton_List_1")
  self._ui._stc_selectLine = UI.getChildControl(tabBg, "Static_SelectLine")
  self._ui._btn_reload = UI.getChildControl(tabBg, "Button_Reload")
  local headerBg = UI.getChildControl(Panel_RoseWar_ScoreBoard, "Static_HeaderArea")
  self._ui._stc_name = UI.getChildControl(headerBg, "StaticText_Name")
  self._ui._stc_rank = UI.getChildControl(headerBg, "StaticText_Rank")
  self._ui._stc_kill = UI.getChildControl(headerBg, "StaticText_Kill")
  self._ui._stc_death = UI.getChildControl(headerBg, "StaticText_Death")
  self._ui._lst_record = UI.getChildControl(Panel_RoseWar_ScoreBoard, "List2_1")
  self._ui._lst_record:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RoseWarScoreBoard_OnCreateListContent")
  self._ui._lst_record:createChildContent(__ePAUIList2ElementManagerType_List)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarScoreBoard:registEventHandler()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RoseWarScoreBoard_Close()")
  self._ui._rdo_guild:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedTab(" .. tostring(self._eTabType.GUILD) .. ")")
  self._ui._rdo_mercenary:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedTab(" .. tostring(self._eTabType.MERCENARY) .. ")")
  self._ui._btn_reload:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedReload()")
  self._ui._stc_name:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_UserNickName) .. ")")
  self._ui._stc_rank:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_GradeType) .. ")")
  self._ui._stc_kill:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_Kill) .. ")")
  self._ui._stc_death:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_Death) .. ")")
  registerEvent("FromClient_RoseWarMemberDataSortResult", "FromClient_RoseWarScoreBoard_SortResult")
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarScoreBoard_ChangeRoseWarState")
end
function PaGlobal_RoseWarScoreBoard:validate()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._rdo_guild:isValidate()
  self._ui._rdo_mercenary:isValidate()
  self._ui._stc_selectLine:isValidate()
  self._ui._btn_reload:isValidate()
  self._ui._stc_name:isValidate()
  self._ui._stc_rank:isValidate()
  self._ui._stc_kill:isValidate()
  self._ui._stc_death:isValidate()
  self._ui._lst_record:isValidate()
end
function PaGlobal_RoseWarScoreBoard:prepareOpen()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  self:initialize()
  if self._lastSelectedTabType == nil then
    self._lastSelectedTabType = self._eTabType.GUILD
  end
  self:changeTab(self._lastSelectedTabType)
  self:open()
end
function PaGlobal_RoseWarScoreBoard:open()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  Panel_RoseWar_ScoreBoard:SetShow(true)
end
function PaGlobal_RoseWarScoreBoard:prepareClose()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWarScoreBoard:close()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  Panel_RoseWar_ScoreBoard:SetShow(false)
end
function PaGlobal_RoseWarScoreBoard:changeTab(tabType)
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  if tabType == self._eTabType.GUILD then
    self._ui._stc_selectLine:SetSpanSize(self._ui._rdo_guild:GetSpanSize().x + self._ui._rdo_guild:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2, self._ui._stc_selectLine:GetSpanSize().y)
    self:updateGuildMemberRecord()
  elseif tabType == self._eTabType.MERCENARY then
    self._ui._stc_selectLine:SetSpanSize(self._ui._rdo_mercenary:GetSpanSize().x + self._ui._rdo_mercenary:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2, self._ui._stc_selectLine:GetSpanSize().y)
    self:updateMercenaryRecord()
  else
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\160\132\236\178\180 \237\153\156\236\149\189\235\143\132 UI\236\157\152 TabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._lastSelectedTabType = tabType
end
function PaGlobal_RoseWarScoreBoard:createRecoardContent(content, key)
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local highIndex = highFromUint64(key)
  local lowIndex = lowFromUint64(key)
  local recordData
  if highIndex == self._eTabType.GUILD then
    recordData = ToClient_GetRoseWarGuildMemberDataWrapper(selfPlayer:getRoseWarTeamNo(), lowIndex)
  elseif highIndex == self._eTabType.MERCENARY then
    recordData = ToClient_GetRoseWarMercenaryMemberDataWrapper(selfPlayer:getRoseWarTeamNo(), lowIndex)
  else
    UI.ASSERT_NAME(false, "highIndex \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \237\131\173 \236\162\133\235\165\152\234\176\128 \236\182\148\234\176\128 \235\144\152\236\151\136\235\139\164\235\169\180 \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  if recordData == nil then
    return
  end
  local txt_name = UI.getChildControl(content, "StaticText_Name")
  local txt_grade = UI.getChildControl(content, "StaticText_Rank")
  local txt_kill = UI.getChildControl(content, "StaticText_Kill")
  local txt_death = UI.getChildControl(content, "StaticText_Death")
  if recordData:getUserNo() == getSelfPlayer():get():getUserNo() then
    txt_name:SetFontColor(Defines.Color.C_FFA3EF00)
    txt_grade:SetFontColor(Defines.Color.C_FFA3EF00)
    txt_kill:SetFontColor(Defines.Color.C_FFA3EF00)
    txt_death:SetFontColor(Defines.Color.C_FFA3EF00)
  else
    txt_name:SetFontColor(Defines.Color.C_FFFFEDD4)
    txt_grade:SetFontColor(Defines.Color.C_FFFFEDD4)
    txt_kill:SetFontColor(Defines.Color.C_FFFFEDD4)
    txt_death:SetFontColor(Defines.Color.C_FFFFEDD4)
  end
  txt_name:SetText(recordData:getUserNickName())
  txt_grade:SetText(PaGlobalFunc_RoseWarMiniMap_GetGradeTypeString(recordData:getGradeType()))
  txt_kill:SetText(recordData:getRoseWarPersonalScore(__eRoseWarPersonalRecordType_Kill))
  txt_death:SetText(recordData:getRoseWarPersonalScore(__eRoseWarPersonalRecordType_Death))
end
function PaGlobal_RoseWarScoreBoard:updateGuildMemberRecord()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local listManager = self._ui._lst_record:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local guildMemberRecordCount = ToClient_GetRoseWarGuildMemberDataCount(selfPlayer:getRoseWarTeamNo())
  for index = 0, guildMemberRecordCount - 1 do
    listManager:pushKey(toInt64(self._eTabType.GUILD, index))
  end
end
function PaGlobal_RoseWarScoreBoard:updateMercenaryRecord()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local listManager = self._ui._lst_record:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local mercenaryRecordCount = ToClient_GetRoseWarMercenaryMemberDataCount(selfPlayer:getRoseWarTeamNo())
  for index = 0, mercenaryRecordCount - 1 do
    listManager:pushKey(toInt64(self._eTabType.MERCENARY, index))
  end
end
function PaGlobal_RoseWarScoreBoard:resetRecordTitleText()
  if Panel_RoseWar_ScoreBoard == nil then
    return
  end
  self._ui._stc_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMEMBERINFO_FAMILYNAME"))
  self._ui._stc_rank:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_GUILD_POSITION"))
  self._ui._stc_kill:SetText("")
  self._ui._stc_death:SetText("")
end
