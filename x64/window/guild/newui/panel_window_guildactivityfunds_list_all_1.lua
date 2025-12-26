function PaGlobal_GuildActivityFunds_List_All:initialize()
  if PaGlobal_GuildActivityFunds_List_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_listAreaBg = UI.getChildControl(Panel_Window_GuildActivityFunds_List_All, "Static_ListArea")
  self._ui.frame_list = UI.getChildControl(self._ui.stc_listAreaBg, "Frame_List")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_list, "Frame_1_Content")
  self._ui.stc_listMember = UI.getChildControl(self._ui.frame_content, "Static_List_Temp")
  self._ui.scroll_vs = UI.getChildControl(self._ui.frame_list, "Frame_1_VerticalScroll")
  self._ui.scroll_vsCtrl = UI.getChildControl(self._ui.scroll_vs, "Frame_1_VerticalScroll_CtrlButton")
  local bottomArea = UI.getChildControl(Panel_Window_GuildActivityFunds_List_All, "Static_BottomArea")
  local fundBg = UI.getChildControl(bottomArea, "Static_BG")
  self._ui.txt_Fund = UI.getChildControl(fundBg, "StaticText_GuildFunds")
  self._ui_pc.btn_Fund = UI.getChildControl(bottomArea, "Button_GetFunds")
  self._ui_pc.btn_Option = UI.getChildControl(bottomArea, "Button_Option")
  local titleBg = UI.getChildControl(Panel_Window_GuildActivityFunds_List_All, "Static_TitleArea")
  self._ui_pc.btn_Close = UI.getChildControl(titleBg, "Button_Close")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_GuildActivityFunds_List_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console.txt_KeyGuideX = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_X_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_A_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_B_ConsoleUI")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Y_ConsoleUI")
  local keyguides = {
    self._ui_console.txt_KeyGuideY,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideX,
    self._ui_console.txt_KeyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildActivityFunds_List_All:changePlatform()
  PaGlobal_GuildActivityFunds_List_All:CreateControl()
  PaGlobal_GuildActivityFunds_List_All:FrameUpdate()
  PaGlobal_GuildActivityFunds_List_All:registEventHandler()
  PaGlobal_GuildActivityFunds_List_All:validate()
  PaGlobal_GuildActivityFunds_List_All._initialize = true
end
function PaGlobal_GuildActivityFunds_List_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
  if true == self._isConsole then
    self._ui.stc_listMember:SetIgnore(false)
  else
    self._ui.stc_listMember:SetIgnore(true)
  end
end
function PaGlobal_GuildActivityFunds_List_All:registEventHandler()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_List_All_Close()")
  self._ui_pc.btn_Option:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_Option_All_Open()")
  self._ui_pc.btn_Fund:addInputEvent("Mouse_LUp", "PaGlobal_GuildActivityFunds_List_All_Confirm()")
  for index = 0, self._config.listMaxCount do
    self._ui._memberlist[index]._fundGrade:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildActivityFunds_All_Grade(" .. index .. ")")
    self._ui._memberlist[index]._memberBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_GuildActivityFunds_All_Grade(" .. index .. ")")
  end
  Panel_Window_GuildActivityFunds_List_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildActivityFunds_Option_All_Open()")
  Panel_Window_GuildActivityFunds_List_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_GuildActivityFunds_List_All_Confirm()")
  registerEvent("FromClient_ResponseGuildUpdate", "PaGlobal_GuildActivityFunds_List_All_Update")
  registerEvent("FromClient_UpdateGuildFundSetting", "PaGlobal_GuildActivityFunds_List_All_Update")
end
function PaGlobal_GuildActivityFunds_List_All:FrameUpdate()
  self._ui.frame_list:UpdateContentScroll()
  self._ui.frame_list:UpdateContentPos()
  self._ui.scroll_vs:SetInterval(self._ui.frame_content:GetSizeY() / 100 * 1.1)
end
function PaGlobal_GuildActivityFunds_List_All:CreateControl()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  local listStartY = self._ui.frame_content:GetPosY()
  local gabY = 3
  local function createListInfo(pIndex)
    local tempMember = {}
    tempMember._memberBg = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_List_Temp", self._ui.frame_content, "guildMemeberlist_MemberBg_" .. pIndex)
    tempMember._grade = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_Grade", tempMember._memberBg, "guildMemeberlist_Grade_" .. pIndex)
    tempMember._charName = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_CharName", tempMember._memberBg, "guildMemeberlist_CharName_" .. pIndex)
    tempMember._point = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_PointValue", tempMember._memberBg, "guildMemeberlist_Point_" .. pIndex)
    tempMember._fundValue = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_C_ActiviryFundsValue", tempMember._memberBg, "guildMemeberlist_FundValue_" .. pIndex)
    tempMember._fundGrade = UI.createAndCopyBasePropertyControl(self._ui.stc_listMember, "StaticText_Grade", tempMember._memberBg, "guildMemeberlist_FundGrade_" .. pIndex)
    for _, var in pairs(tempMember) do
      var:ComputePos()
      var:SetIgnore(false and false == self._isConsole)
      var:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildActivityFunds_All_Scroll(true)")
      var:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildActivityFunds_All_Scroll(false)")
    end
    if false == self._isConsole then
      tempMember._memberBg:ChangeTextureInfoNameAsync("")
    else
      tempMember._fundGrade:SetIgnore(true)
      tempMember._fundGrade:ChangeTextureInfoNameAsync("")
    end
    tempMember._grade:SetIgnore(self._isConsole)
    tempMember._charName:SetIgnore(self._isConsole)
    tempMember._point:SetIgnore(self._isConsole)
    tempMember._fundValue:SetIgnore(self._isConsole)
    tempMember._fundGrade:SetIgnore(self._isConsole)
    tempMember._memberBg:SetShow(false)
    tempMember._memberBg:SetPosY(listStartY + (tempMember._memberBg:GetSizeY() + gabY) * pIndex)
    return tempMember
  end
  for index = 0, self._config.listMaxCount do
    self._ui._memberlist[index] = createListInfo(index)
  end
end
function PaGlobal_GuildActivityFunds_List_All:prepareOpen()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  PaGlobal_GuildActivityFunds_List_All:update()
  PaGlobal_GuildActivityFunds_List_All:open()
end
function PaGlobal_GuildActivityFunds_List_All:open()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  Panel_Window_GuildActivityFunds_List_All:SetShow(true)
end
function PaGlobal_GuildActivityFunds_List_All:prepareClose()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  PaGlobal_GuildActivityFunds_Option_All_Close()
  PaGlobal_GuildActivityFunds_List_All:close()
end
function PaGlobal_GuildActivityFunds_List_All:close()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
  Panel_Window_GuildActivityFunds_List_All:SetShow(false)
end
function PaGlobal_GuildActivityFunds_List_All:validate()
  if Panel_Window_GuildActivityFunds_List_All == nil then
    return
  end
end
function PaGlobal_GuildActivityFunds_List_All:update()
  self:setGuildMemberData()
  local guildActivityFundsListComparePoint = function(w1, w2)
    if w2.point < w1.point then
      return true
    end
  end
  table.sort(self._memberlistData, guildActivityFundsListComparePoint)
  self:updateListInfo()
  self:updateBottomInfo()
  self:FrameUpdate()
end
function PaGlobal_GuildActivityFunds_List_All:setGuildMemberData()
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local memberCount = myGuildListInfo:getMemberCount()
  for index = 1, memberCount do
    local tempGuildList = {}
    local myGuildMemberInfo = myGuildListInfo:getMember(index - 1)
    if nil == myGuildMemberInfo then
      return
    end
    local prevLevel = myGuildMemberInfo:getLevel()
    local prevWp = myGuildMemberInfo:getMaxWp()
    local prevClass = myGuildMemberInfo:getClassType()
    if false == myGuildMemberInfo:isOnline() or true == myGuildMemberInfo:isGhostMode() then
      prevLevel = 0
      prevWp = 0
      prevClass = __eClassType_Count
    end
    tempGuildList = {
      idx = index - 1,
      grade = myGuildMemberInfo:getGrade(),
      name = myGuildMemberInfo:getName(),
      point = myGuildMemberInfo:getActivityPoint(),
      pointInfoList = {},
      fund = 0,
      fundGrade = 0
    }
    self._memberlistData[index] = tempGuildList
  end
end
function PaGlobal_GuildActivityFunds_List_All:updateListInfo()
  for index = 0, self._config.listMaxCount do
    self._ui._memberlist[index]._memberBg:SetShow(false)
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local contentSizeY = 0
  local memberCount = myGuildInfo:getMemberCount()
  for index = 0, memberCount - 1 do
    local dataIdx = self._memberlistData[index + 1].idx
    local myGuildMemberInfo = myGuildInfo:getMember(dataIdx)
    if nil == myGuildMemberInfo then
      return
    end
    self:updateListMemeber(myGuildMemberInfo, index, dataIdx)
    contentSizeY = contentSizeY + self._ui._memberlist[index]._charName:GetSizeY()
  end
  self._ui.frame_content:SetSize(self._ui.frame_list:GetSizeX(), contentSizeY)
end
function PaGlobal_GuildActivityFunds_List_All:updateListMemeber(guildMember, index, dataIdx)
  if guildMember == nil or index == nil or dataIdx == nil then
    return
  end
  local guildMemberControl = self._ui._memberlist[index]
  if nil == guildMemberControl then
    return
  end
  guildMemberControl._memberBg:SetShow(true)
  local gradeType = guildMember:getGrade()
  local isVacation = guildMember:isVacation()
  self:setGradeInfo(guildMemberControl._grade, index, gradeType, isVacation)
  local isOnline = true == guildMember:isOnline() and false == guildMember:isGhostMode()
  self:setOnline(isOnline, guildMember, guildMemberControl, index, dataIdx)
  guildMemberControl._point:SetText(tostring(guildMember:getActivityPoint()))
  local pointListCount = ToClient_GetActivityPointListCount(guildMember:getUserNo())
  if pointListCount > 3 then
    pointListCount = 3
  end
  local priceLimit = guildMember:getPriceLimit()
  local isPriceLimit = guildMember:getIsPriceLimit()
  if __eGuildMemberGradeMaster ~= guildMember:getGrade() and true == isPriceLimit then
    guildMemberControl._fundValue:SetText(makeDotMoney(priceLimit))
  else
    guildMemberControl._fundValue:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILD_LIST_TOOLTIP_LIMITPRICE_NO"))
  end
  guildMemberControl._fundGrade:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_INCENTIVE_GRADE_FOR_WHAT", "grade", tostring(guildMember:getActivityGrade())))
end
function PaGlobal_GuildActivityFunds_List_All:setGradeInfo(control, index, grade, isVacation)
  if control == nil or index == nil or grade == nil or isVacation == nil then
    return
  end
  control:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_ETC_Guild.dds")
  if __eGuildMemberGradeMaster == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 227, 267, 253)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeAdviser == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 68, 1, 110, 27)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeSubMaster == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 200, 267, 226)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeNormal == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 146, 267, 172)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeGunner == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 68, 28, 110, 54)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeSupplyOfficer == grade then
    local x1, y1, x2, y2 = setTextureUV_Func(control, 224, 173, 267, 199)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeJunior == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 83, 44, 109)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeScribe == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 500, 44, 543, 70)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeChiefOfStaff == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 500, 114, 543, 140)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif __eGuildMemberGradeMissionOfficer == grade then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 500, 141, 543, 167)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  control:setRenderTexture(control:getBaseTexture())
end
function PaGlobal_GuildActivityFunds_List_All:setOnline(isOnline, guildMemberInfo, elementControl, index, dataIdx)
  if isOnline == nil or guildMemberInfo == nil or elementControl == nil or index == nil or dataIdx == nil then
    return
  end
  if true == isOnline then
    if true == guildMemberInfo:isSelf() then
      elementControl._charName:SetFontColor(Defines.Color.C_FFEF9C7F)
    else
      elementControl._charName:SetFontColor(Defines.Color.C_FFDDC39E)
    end
    local gamerTag = ""
    if true == _ContentsGroup_RenewUI then
      if true == ToClient_isPS() then
        if nil ~= ToClient_getSelfPlayerOnlineId() then
          gamerTag = " / ( " .. tostring(ToClient_getOnlineId(guildMemberInfo:getUserNo())) .. " )"
        end
      elseif nil ~= ToClient_getXboxGuildUserGamerTag(guildMemberInfo:getUserNo()) then
        gamerTag = " / ( " .. tostring(ToClient_getXboxGuildUserGamerTag(guildMemberInfo:getUserNo())) .. " )"
      end
    end
    local selfPlayerPlatform = ToClient_getGamePlatformType()
    if guildMemberInfo:getPlatformType() ~= selfPlayerPlatform then
      gamerTag = "/ ( - )"
    end
    elementControl._charName:addInputEvent("Mouse_On", "")
    elementControl._charName:addInputEvent("Mouse_Out", "")
    elementControl._charName:SetText(guildMemberInfo:getName() .. " (" .. guildMemberInfo:getCharacterName() .. ")" .. gamerTag)
    elementControl._charName:SetTextMode(__eTextMode_LimitText)
    elementControl._charName:SetText(elementControl._charName:GetText())
    if 0 < ToClient_getGameOptionControllerWrapper():getUIFontSizeType() then
      elementControl._charName:SetText(guildMemberInfo:getName())
    else
      UI.setLimitTextAndAddTooltip(elementControl._charName)
    end
  else
    elementControl._charName:SetFontColor(Defines.Color.C_FF5A5A5A)
    elementControl._charName:SetText(guildMemberInfo:getName() .. " ( - )")
    elementControl._charName:addInputEvent("Mouse_On", "")
    elementControl._charName:addInputEvent("Mouse_Out", "")
  end
end
function PaGlobal_GuildActivityFunds_List_All:updateBottomInfo()
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local guildMoney64 = guildWrapper:getGuildBusinessFunds_s64()
  local moneyTitle = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_INCENTIVE_GUILDMONEY")
  self._ui.txt_Fund:SetText(moneyTitle .. " " .. makeDotMoney(guildMoney64))
end
