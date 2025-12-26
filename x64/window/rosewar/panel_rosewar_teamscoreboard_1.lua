function PaGlobal_RoseWarTeamScoreBoard:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBg = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "Static_TitleArea_Import")
  self._ui._txt_title = UI.getChildControl(titleBg, "StaticText_Title")
  self._ui._btn_close = UI.getChildControl(titleBg, "Button_Close")
  self._ui._cbx_team = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "Combobox2_TeamSelect")
  self._ui._stc_teamList = UI.getChildControl(self._ui._cbx_team, "Combobox_List")
  local tabBg = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "Static_RadioButtonBg")
  self._ui._btn_guildTab = UI.getChildControl(tabBg, "RadioButton_MainGuild")
  self._ui._btn_mercenaryTab = UI.getChildControl(tabBg, "RadioButton_Third")
  self._ui._stc_selectBar = UI.getChildControl(tabBg, "Static_SelectBar")
  self._ui._btn_reload = UI.getChildControl(tabBg, "Button_Reload")
  local stc_tabGuideLB = UI.getChildControl(tabBg, "Static_LB_ConsoleUI")
  local stc_tabGuideRB = UI.getChildControl(tabBg, "Static_RB_ConsoleUI")
  local subjectBg = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "Static_M_Title_Area")
  self._ui._stc_name = UI.getChildControl(subjectBg, "StaticText_Name")
  self._ui._stc_rank = UI.getChildControl(subjectBg, "StaticText_Rank")
  self._ui._stc_kill = UI.getChildControl(subjectBg, "StaticText_Kill")
  self._ui._stc_death = UI.getChildControl(subjectBg, "StaticText_Death")
  self._ui._lst_scoreBoard = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "List2_ScoreBoard")
  local stc_descBg = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "Static_DescEdge")
  local txt_desc = UI.getChildControl(stc_descBg, "StaticText_Desc")
  self._ui._stc_keyGuide = UI.getChildControl(Panel_RoseWar_TeamScoreBoard, "Static_KeyGuideGroup")
  self._ui._cbx_team:GetListControl():AddSelectEvent("HandleEventLUp_RoseWarTeamScoreBoard_ComboBoxItem()")
  self._ui._cbx_team:setListTextHorizonCenter()
  self._ui._cbx_team:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_ComboBox()")
  self._ui._lst_scoreBoard:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_RoseWarTeamScoreBoard_OnCreateListContent")
  self._ui._lst_scoreBoard:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:SetShow(self._isConsole == false)
  self._ui._cbx_team:SetShow(self._isConsole == false)
  stc_tabGuideLB:SetShow(self._isConsole)
  stc_tabGuideRB:SetShow(self._isConsole)
  self._ui._stc_keyGuide:SetShow(self._isConsole)
  if self._isConsole == true then
    local keyGuideX = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_KeyGuideX")
    local keyGuideY = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_KeyGuideY")
    local keyGuideB = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_KeyGuideB")
    local keyGuideList = Array.new()
    keyGuideList:push_back(keyGuideX)
    keyGuideList:push_back(keyGuideY)
    keyGuideList:push_back(keyGuideB)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
  end
  local preDescBgSizeY = stc_descBg:GetSizeY()
  txt_desc:SetText(txt_desc:GetText())
  txt_desc:SetSize(txt_desc:GetSizeX(), txt_desc:GetTextSizeY())
  txt_desc:ComputePos()
  stc_descBg:SetSize(txt_desc:GetSizeX() + 20, txt_desc:GetSizeY() + 20)
  stc_descBg:ComputePos()
  local postDescBgSizeY = stc_descBg:GetSizeY()
  if preDescBgSizeY ~= postDescBgSizeY then
    local diffSizeY = postDescBgSizeY - preDescBgSizeY
    Panel_RoseWar_TeamScoreBoard:SetSize(Panel_RoseWar_TeamScoreBoard:GetSizeX(), Panel_RoseWar_TeamScoreBoard:GetSizeY() + diffSizeY)
    Panel_RoseWar_TeamScoreBoard:ComputePosAllChild()
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarTeamScoreBoard:registEventHandler()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  if self._isConsole == true then
    Panel_RoseWar_TeamScoreBoard:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_RoseWarTeamScoreBoard:changeTeam(" .. tostring(Defines.RoseWarTeamNo.KAMASYLVIA) .. ")")
    Panel_RoseWar_TeamScoreBoard:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_RoseWarTeamScoreBoard:changeTeam(" .. tostring(Defines.RoseWarTeamNo.ODYLLITA) .. ")")
    Panel_RoseWar_TeamScoreBoard:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedTab(" .. tostring(self._eTabType.GUILD) .. ")")
    Panel_RoseWar_TeamScoreBoard:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedTab(" .. tostring(self._eTabType.MERCENARY) .. ")")
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RoseWarTeamScoreBoard_Close()")
  self._ui._btn_guildTab:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedTab(" .. tostring(self._eTabType.GUILD) .. ")")
  self._ui._btn_mercenaryTab:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedTab(" .. tostring(self._eTabType.MERCENARY) .. ")")
  self._ui._btn_reload:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedReload()")
  self._ui._stc_name:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_UserNickName) .. ")")
  self._ui._stc_rank:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_GradeType) .. ")")
  self._ui._stc_kill:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_Kill) .. ")")
  self._ui._stc_death:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarTeamScoreBoard_OnClickedSort(" .. tostring(__eRoseWarMemberDataSortOption_Death) .. ")")
  registerEvent("FromClient_OnLoadCompleteRoseWarTeamScoreInfo", "FromClient_RoseWarTeamScoreBoard_OnLoadComplete")
  registerEvent("FromClient_RoseWarMemberDataSortResult", "FromClient_RoseWarTeamScoreBoard_SortResult")
end
function PaGlobal_RoseWarTeamScoreBoard:validate()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._cbx_team:isValidate()
  self._ui._stc_teamList:isValidate()
  self._ui._btn_guildTab:isValidate()
  self._ui._btn_mercenaryTab:isValidate()
  self._ui._stc_selectBar:isValidate()
  self._ui._btn_reload:isValidate()
  self._ui._stc_name:isValidate()
  self._ui._stc_rank:isValidate()
  self._ui._stc_kill:isValidate()
  self._ui._stc_death:isValidate()
  self._ui._lst_scoreBoard:isValidate()
end
function PaGlobal_RoseWarTeamScoreBoard:prepareOpen()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  local defaultTitleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_SITUATIONBOARD_TITLE")
  local scoreNo = ToClient_GetLastUpdateRoseWarScoreNo()
  if scoreNo == 0 then
    self._ui._txt_title:SetText(defaultTitleString)
  else
    local scoreDateString = tostring(scoreNo)
    local year = string.sub(scoreDateString, 1, 4)
    local month = string.sub(scoreDateString, 5, 6)
    local day = string.sub(scoreDateString, 7, 8)
    self._ui._txt_title:SetText(defaultTitleString .. " " .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_SCOREBOARD_DATE_TITLE", "month", month, "day", day))
  end
  local defaultKamaString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_KAMASILVIA")
  local defaultOdyllString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_ODILITA")
  local winString = PAGetString(Defines.StringSheet_GAME, "LUA_SAVAGEDEFENCEINFO_WIN")
  self._ui._cbx_team:DeleteAllItem(0)
  local winTeamNo = ToClient_GetRoseWarResultWinTeamNo(scoreNo)
  if winTeamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
    self._ui._cbx_team:AddItem(defaultKamaString .. " (" .. winString .. ")")
    self._ui._cbx_team:AddItem(defaultOdyllString)
  elseif winTeamNo == Defines.RoseWarTeamNo.ODYLLITA then
    self._ui._cbx_team:AddItem(defaultKamaString)
    self._ui._cbx_team:AddItem(defaultOdyllString .. " (" .. winString .. ")")
  else
    self._ui._cbx_team:AddItem(defaultKamaString)
    self._ui._cbx_team:AddItem(defaultOdyllString)
  end
  local isPlayingRoseWar = ToClient_GetRoseWarState() == __eRoseWar_Start and ToClient_IsRoseWarServer() == true
  self._ui._btn_reload:SetShow(isPlayingRoseWar)
  self:changeTeam(Defines.RoseWarTeamNo.KAMASYLVIA)
  self:changeTab(self._eTabType.GUILD)
  self:open()
end
function PaGlobal_RoseWarTeamScoreBoard:open()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  Panel_RoseWar_TeamScoreBoard:SetShow(true)
end
function PaGlobal_RoseWarTeamScoreBoard:prepareClose()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  if self._ui._stc_teamList:GetShow() == true then
    self._ui._cbx_team:ToggleListbox()
  end
  self:close()
end
function PaGlobal_RoseWarTeamScoreBoard:close()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  Panel_RoseWar_TeamScoreBoard:SetShow(false)
end
function PaGlobal_RoseWarTeamScoreBoard:changeTeam(teamNo)
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  if self._lastSelectedTeamNo == teamNo then
    return
  end
  if teamNo ~= Defines.RoseWarTeamNo.KAMASYLVIA and teamNo ~= Defines.RoseWarTeamNo.ODYLLITA then
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\167\132\236\152\129\235\179\132 \236\160\132\236\178\180 \237\153\156\236\149\189\235\143\132 UI\236\157\152 TeamNo \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._lastSelectedTeamNo = teamNo
  self._ui._cbx_team:SetSelectItemIndex(teamNo)
  self:resetRecordTitleText()
  self:changeTab(self._eTabType.GUILD)
end
function PaGlobal_RoseWarTeamScoreBoard:changeTab(tabType)
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  if tabType == self._eTabType.GUILD then
    self._ui._stc_selectBar:SetSpanSize(self._ui._btn_guildTab:GetSpanSize().x, self._ui._stc_selectBar:GetSpanSize().y)
    self._ui._btn_guildTab:SetCheck(true)
    self._ui._btn_mercenaryTab:SetCheck(false)
    self:updateGuildMemberRecord()
  elseif tabType == self._eTabType.MERCENARY then
    self._ui._stc_selectBar:SetSpanSize(self._ui._btn_mercenaryTab:GetSpanSize().x, self._ui._stc_selectBar:GetSpanSize().y)
    self._ui._btn_guildTab:SetCheck(false)
    self._ui._btn_mercenaryTab:SetCheck(true)
    self:updateMercenaryRecord()
  else
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\167\132\236\152\129\235\179\132 \236\160\132\236\178\180 \237\153\156\236\149\189\235\143\132 UI\236\157\152 TabType\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._lastSelectedTabType = tabType
end
function PaGlobal_RoseWarTeamScoreBoard:createScoreContent(content, key)
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  local highIndex = highFromUint64(key)
  local lowIndex = lowFromUint64(key)
  local scoreDataWrapper
  if highIndex == self._eTabType.GUILD then
    scoreDataWrapper = ToClient_GetRoseWarGuildMemberDataWrapper(self._lastSelectedTeamNo, lowIndex)
  elseif highIndex == self._eTabType.MERCENARY then
    scoreDataWrapper = ToClient_GetRoseWarMercenaryMemberDataWrapper(self._lastSelectedTeamNo, lowIndex)
  else
    UI.ASSERT_NAME(false, "highIndex \234\176\146\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \237\131\173 \236\162\133\235\165\152\234\176\128 \236\182\148\234\176\128 \235\144\152\236\151\136\235\139\164\235\169\180 \236\151\172\234\184\176\235\143\132 \236\178\152\235\166\172\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  if scoreDataWrapper == nil then
    return
  end
  local slotBg = UI.getChildControl(content, "Static_SlotBG")
  local txt_name = UI.getChildControl(slotBg, "StaticText_Name")
  local txt_grade = UI.getChildControl(slotBg, "StaticText_Rank")
  local txt_kill = UI.getChildControl(slotBg, "StaticText_Kill")
  local txt_death = UI.getChildControl(slotBg, "StaticText_Death")
  if scoreDataWrapper:getUserNo() == getSelfPlayer():get():getUserNo() then
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
  txt_name:SetText(scoreDataWrapper:getUserNickName())
  txt_grade:SetText(PaGlobalFunc_RoseWarMiniMap_GetGradeTypeString(scoreDataWrapper:getGradeType()))
  txt_kill:SetText(scoreDataWrapper:getRoseWarPersonalScore(__eRoseWarPersonalRecordType_Kill))
  txt_death:SetText(scoreDataWrapper:getRoseWarPersonalScore(__eRoseWarPersonalRecordType_Death))
end
function PaGlobal_RoseWarTeamScoreBoard:updateGuildMemberRecord()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  local listManager = self._ui._lst_scoreBoard:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local guildMemberRecordCount = ToClient_GetRoseWarGuildMemberDataCount(self._lastSelectedTeamNo)
  for index = 0, guildMemberRecordCount - 1 do
    listManager:pushKey(toInt64(self._eTabType.GUILD, index))
  end
end
function PaGlobal_RoseWarTeamScoreBoard:updateMercenaryRecord()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  local listManager = self._ui._lst_scoreBoard:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local mercenaryRecordCount = ToClient_GetRoseWarMercenaryMemberDataCount(self._lastSelectedTeamNo)
  for index = 0, mercenaryRecordCount - 1 do
    listManager:pushKey(toInt64(self._eTabType.MERCENARY, index))
  end
end
function PaGlobal_RoseWarTeamScoreBoard:resetRecordTitleText()
  if Panel_RoseWar_TeamScoreBoard == nil then
    return
  end
  self._ui._stc_name:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMEMBERINFO_FAMILYNAME"))
  self._ui._stc_rank:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_GUILD_POSITION"))
  self._ui._stc_kill:SetText("")
  self._ui._stc_death:SetText("")
end
