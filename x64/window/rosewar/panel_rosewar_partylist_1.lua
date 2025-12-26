function PaGlobal_RoseWarPartyList:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_RoseWar_PartyList, "Static_TitleBar")
  self._ui._stc_tabBar = UI.getChildControl(Panel_RoseWar_PartyList, "Static_TabBar")
  self._ui._stc_top = UI.getChildControl(Panel_RoseWar_PartyList, "Static_Top")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Close")
  self._ui._chk_showFamily = UI.getChildControl(self._ui._stc_tabBar, "CheckButton_FamilyNameShow")
  self._ui._chk_showMinify = UI.getChildControl(self._ui._stc_tabBar, "CheckButton_MinifyShow")
  local guildMark = UI.getChildControl(self._ui._stc_top, "Static_GuildMark")
  local stcProfileCommander = UI.getChildControl(self._ui._stc_top, "Static_Profile_Commander")
  local stcCommanderDeco = UI.getChildControl(stcProfileCommander, "Static_ClassDeco")
  self._ui._stc_regionMark = UI.getChildControl(self._ui._stc_top, "Static_RegionMark")
  self._ui._stc_guildMark = UI.getChildControl(guildMark, "Static_GuildIcon")
  self._ui._stc_guildName = UI.getChildControl(self._ui._stc_top, "StaticText_GuildName")
  self._ui._btn_appoint = UI.getChildControl(self._ui._stc_top, "Button_Commander_Appoint")
  self._ui._stc_commanderIcon = UI.getChildControl(stcProfileCommander, "Static_Profile_Icon")
  self._ui._stc_commanderClassIcon = UI.getChildControl(stcCommanderDeco, "Static_ClassIcon")
  self._ui._stc_commanderSuccession = UI.getChildControl(stcCommanderDeco, "Static_Symbol_Succession")
  self._ui._stc_commanderAwaken = UI.getChildControl(stcCommanderDeco, "Static_Symbol_Awaken")
  self._ui._stc_commanderShy = UI.getChildControl(stcCommanderDeco, "Static_Symbol_Shy")
  self._ui._stc_commanderArcher = UI.getChildControl(stcCommanderDeco, "Static_Symbol_Archer")
  self._ui._stc_commanderName = UI.getChildControl(stcCommanderDeco, "StaticText_Name")
  self._ui._frm_original = UI.getChildControl(Panel_RoseWar_PartyList, "Frame_1_Original")
  self._ui._frm_contentOrigin = UI.getChildControl(self._ui._frm_original, "Frame_1_Content")
  self._ui._frm_minify = UI.getChildControl(Panel_RoseWar_PartyList, "Frame_1_Minify")
  self._ui._frm_contentMinify = UI.getChildControl(self._ui._frm_minify, "Frame_1_Content")
  self:makeMemberDataPool()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarPartyList:registEventHandler()
  if PaGlobal_RoseWarPartyList == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_RoseWarPartyList_Close()")
  self._ui._btn_appoint:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_Appoint()")
  self._ui._chk_showMinify:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_ShowMinify()")
  self._ui._chk_showFamily:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_ShowFamilyName()")
  registerEvent("FromClient_ChangeRoseWarCommander", "FromClient_RoseWarPartyList_ChangeRoseWarCommander")
end
function PaGlobal_RoseWarPartyList:validate()
  if Panel_RoseWar_PartyList == nil then
    return
  end
end
function PaGlobal_RoseWarPartyList:prepareOpen()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  self._selectedIndex = -1
  self:setCommanderInfo()
  self:updateSlot()
  self:open()
end
function PaGlobal_RoseWarPartyList:open()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  Panel_RoseWar_PartyList:SetShow(true)
end
function PaGlobal_RoseWarPartyList:prepareClose()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWarPartyList:close()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  Panel_RoseWar_PartyList:SetShow(false)
end
function PaGlobal_RoseWarPartyList:makeMemberDataPool()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._memberDataPool = {}
  self._memberMiniDataPool = {}
  local memberTemplate = UI.getChildControl(self._ui._frm_contentOrigin, "Static_ListTemplate")
  local memberTemplateMini = UI.getChildControl(self._ui._frm_contentMinify, "Static_ListTemplate")
  memberTemplate:SetShow(false)
  memberTemplateMini:SetShow(false)
  local slotSpanY = 5
  for index = 0, self._memberDataMaxCount do
    local controlID = "Static_PartyList_Member_" .. tostring(index)
    local newControl = UI.cloneControl(memberTemplate, self._ui._frm_contentOrigin, controlID)
    local memberData = {
      _control = newControl,
      _stc_guildGrade = nil,
      _stc_classBg = nil,
      _stc_classIcon = nil,
      _stc_symbolSuccession = nil,
      _stc_symbolAwaken = nil,
      _stc_symbolShy = nil,
      _stc_symbolArcher = nil,
      _txt_memberName = nil,
      _userNo = nil,
      _isSet = false
    }
    memberData._stc_guildGrade = UI.getChildControl(newControl, "Static_Grade")
    memberData._stc_classBg = UI.getChildControl(newControl, "Static_Character_BG")
    memberData._stc_classIcon = UI.getChildControl(newControl, "Static_Class")
    memberData._stc_symbolSuccession = UI.getChildControl(newControl, "Static_Symbol_Succession")
    memberData._stc_symbolAwaken = UI.getChildControl(newControl, "Static_Symbol_Awaken")
    memberData._stc_symbolShy = UI.getChildControl(newControl, "Static_Symbol_Shy")
    memberData._stc_symbolArcher = UI.getChildControl(newControl, "Static_Symbol_Archer")
    memberData._txt_memberName = UI.getChildControl(newControl, "StaticText_MemberName")
    self._memberDataPool[index] = memberData
    local controlIDMini = "Static_PartyList_MemberMini_" .. tostring(index)
    local newControlMini = UI.cloneControl(memberTemplateMini, self._ui._frm_contentMinify, controlIDMini)
    local memberMiniData = {
      _control = newControlMini,
      _stc_guildGrade = nil,
      _txt_memberName = nil,
      _userNo = nil,
      _isSet = false
    }
    memberMiniData._stc_guildGrade = UI.getChildControl(newControlMini, "Static_Grade")
    memberMiniData._stc_solareTier = UI.getChildControl(newControlMini, "Static_Tier")
    memberMiniData._txt_memberName = UI.getChildControl(newControlMini, "StaticText_MemberName")
    self._memberMiniDataPool[index] = memberMiniData
    index = index + 1
  end
end
function PaGlobal_RoseWarPartyList:updateSlot()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  self:clearAllMemberData()
  local isShowMinify = self._ui._chk_showMinify:IsCheck()
  if isShowMinify == true then
    self._ui._frm_original:SetShow(false)
    self._ui._frm_contentOrigin:SetShow(false)
    self._ui._frm_minify:SetShow(true)
    self._ui._frm_contentMinify:SetShow(true)
    self:updateSlotForMini()
    self:updateSlotPositionForMini()
  else
    self._ui._frm_minify:SetShow(false)
    self._ui._frm_contentMinify:SetShow(false)
    self._ui._frm_original:SetShow(true)
    self._ui._frm_contentOrigin:SetShow(true)
    self:updateSlotForOrigin()
    self:updateSlotPositionForOrigin()
  end
  self._ui._chk_showMinify:SetPosXY(self._ui._chk_showFamily:GetPosX() + self._ui._chk_showFamily:GetSpanSize().x + self._ui._chk_showFamily:GetSizeX() + self._ui._chk_showFamily:GetTextSizeX(), self._ui._chk_showMinify:GetPosY())
end
function PaGlobal_RoseWarPartyList:updateSlotForOrigin()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  local isShowFamilyName = self._ui._chk_showFamily:IsCheck()
  local poolIndex = 0
  for index = 0, memberCount - 1 do
    local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(index)
    if roseWarMemberDataWrapper ~= nil then
      local memberPoolData = self._memberDataPool[poolIndex]
      local gradeType = roseWarMemberDataWrapper:getGradeType()
      local classType = roseWarMemberDataWrapper:getClassTypeRaw()
      local skillType = roseWarMemberDataWrapper:getSkillTypeRaw()
      local guildMemberGrade = roseWarMemberDataWrapper:getGuildMemberGrade()
      local userNo = roseWarMemberDataWrapper:getUserNo()
      memberPoolData._stc_symbolShy:SetShow(false)
      memberPoolData._stc_symbolArcher:SetShow(false)
      memberPoolData._stc_symbolAwaken:SetShow(false)
      memberPoolData._stc_symbolSuccession:SetShow(false)
      if gradeType == __eRoseWarPlayerGradeType_GuildMember or gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader then
        if classType == __eClassType_ShyWaman then
          memberPoolData._stc_symbolShy:SetShow(true)
        elseif classType == __eClassType_RangerMan then
          memberPoolData._stc_symbolArcher:SetShow(true)
        elseif skillType == __eSkillTypeParam_Awaken then
          memberPoolData._stc_symbolAwaken:SetShow(true)
        elseif skillType == __eSkillTypeParam_Inherit then
          memberPoolData._stc_symbolSuccession:SetShow(true)
        end
        PaGlobalFunc_Util_SetSolrareRankingClassBigBG(memberPoolData._stc_classBg, classType)
        PaGlobalFunc_Util_ChangeTextureClass(memberPoolData._stc_classIcon, classType)
        PaGlobalFunc_Util_SetGuildMemberGradeIcon(memberPoolData._stc_guildGrade, guildMemberGrade)
        if isShowFamilyName == true then
          memberPoolData._txt_memberName:SetText(roseWarMemberDataWrapper:getUserNickName())
        else
          memberPoolData._txt_memberName:SetText(roseWarMemberDataWrapper:getCharacterName())
        end
        memberPoolData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_SelectCommander(" .. tostring(poolIndex) .. ")")
        memberPoolData._userNo = userNo
        memberPoolData._control:SetShow(true)
        memberPoolData._isSet = true
        poolIndex = poolIndex + 1
      end
    end
  end
end
function PaGlobal_RoseWarPartyList:updateSlotForMini()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  local memberCount = ToClient_GetRoseWarMemberDataCount()
  local isShowFamilyName = self._ui._chk_showFamily:IsCheck()
  local poolIndex = 0
  for index = 0, memberCount - 1 do
    local roseWarMemberDataWrapper = ToClient_GetRoseWarMemberDataWrapper(index)
    if roseWarMemberDataWrapper ~= nil then
      local gradeType = roseWarMemberDataWrapper:getGradeType()
      local memberMiniPoolData = self._memberMiniDataPool[poolIndex]
      local classType = roseWarMemberDataWrapper:getClassTypeRaw()
      local skillType = roseWarMemberDataWrapper:getSkillTypeRaw()
      local guildMemberGrade = roseWarMemberDataWrapper:getGuildMemberGrade()
      local userNo = roseWarMemberDataWrapper:getUserNo()
      if gradeType == __eRoseWarPlayerGradeType_GuildMember or gradeType == __eRoseWarPlayerGradeType_SubCommander or gradeType == __eRoseWarPlayerGradeType_GuildPartyLeader then
        PaGlobalFunc_Util_SetGuildMemberGradeIcon(memberMiniPoolData._stc_guildGrade, guildMemberGrade)
        if isShowFamilyName == true then
          memberMiniPoolData._txt_memberName:SetText(roseWarMemberDataWrapper:getUserNickName())
        else
          memberMiniPoolData._txt_memberName:SetText(roseWarMemberDataWrapper:getCharacterName())
        end
        memberMiniPoolData._userNo = userNo
        memberMiniPoolData._control:SetShow(true)
        memberMiniPoolData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarPartyList_SelectCommander(" .. tostring(poolIndex) .. ")")
        memberMiniPoolData._isSet = true
        poolIndex = poolIndex + 1
      end
    end
  end
end
function PaGlobal_RoseWarPartyList:updateSlotPositionForOrigin()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  if self._memberDataPool == nil then
    return
  end
  local memberTemplate = UI.getChildControl(self._ui._frm_contentOrigin, "Static_ListTemplate")
  if memberTemplate == nil then
    return
  end
  self._ui._frm_original:SetShow(true)
  self._ui._frm_contentOrigin:SetShow(true)
  local spanX = 10
  local spanY = 10
  local termX = 5
  local termY = 5
  local rowIndex = 0
  local colIndex = 0
  local templateSizeX = memberTemplate:GetSizeX() + termX
  local templateSizeY = memberTemplate:GetSizeY() + termY
  local rowMaxCount = math.floor(self._ui._frm_contentOrigin:GetSizeX() / templateSizeX)
  for index = 0, self._memberDataMaxCount - 1 do
    local memberData = self._memberDataPool[index]
    if memberData ~= nil and memberData._isSet == true then
      spanX = termX * (rowIndex + 1) + memberData._control:GetSizeX() * rowIndex
      spanY = termY * (colIndex + 1) + memberData._control:GetSizeY() * colIndex
      rowIndex = rowIndex + 1
      memberData._control:SetShow(true)
      memberData._control:SetSpanSize(spanX, spanY)
      memberData._control:ComputePos()
      if rowMaxCount <= rowIndex then
        rowIndex = 0
        colIndex = colIndex + 1
      end
    end
  end
  self._ui._frm_contentOrigin:SetSize(self._ui._frm_contentOrigin:GetSizeX(), spanY + templateSizeY + termY)
  local frameVScroll = self._ui._frm_original:GetVScroll()
  frameVScroll:SetControlPos(0)
  self._ui._frm_original:UpdateContentPos()
end
function PaGlobal_RoseWarPartyList:updateSlotPositionForMini()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  if self._memberMiniDataPool == nil then
    return
  end
  local memberMiniTemplate = UI.getChildControl(self._ui._frm_contentMinify, "Static_ListTemplate")
  if memberMiniTemplate == nil then
    return
  end
  local spanX = 10
  local spanY = 10
  local termX = 5
  local termY = 5
  local rowIndex = 0
  local colIndex = 0
  local templateSizeX = memberMiniTemplate:GetSizeX() + termX
  local templateSizeY = memberMiniTemplate:GetSizeY() + termY
  local rowMaxCount = math.floor(self._ui._frm_contentMinify:GetSizeX() / templateSizeX)
  for index = 0, self._memberDataMaxCount - 1 do
    local memberMiniData = self._memberMiniDataPool[index]
    if memberMiniData ~= nil and memberMiniData._isSet == true then
      spanX = termX * (rowIndex + 1) + memberMiniData._control:GetSizeX() * rowIndex
      spanY = termY * (colIndex + 1) + memberMiniData._control:GetSizeY() * colIndex
      rowIndex = rowIndex + 1
      memberMiniData._control:SetShow(true)
      memberMiniData._control:SetSpanSize(spanX, spanY)
      memberMiniData._control:ComputePos()
      if rowMaxCount <= rowIndex then
        rowIndex = 0
        colIndex = colIndex + 1
      end
    end
  end
  self._ui._frm_contentMinify:SetSize(self._ui._frm_contentMinify:GetSizeX(), spanY + templateSizeY + termY)
  local frameVScroll = self._ui._frm_minify:GetVScroll()
  frameVScroll:SetControlPos(0)
  self._ui._frm_minify:UpdateContentPos()
end
function PaGlobal_RoseWarPartyList:clearAllMemberData()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  if self._memberDataPool == nil or self._memberMiniDataPool == nil then
    return
  end
  for index = 0, self._memberDataMaxCount - 1 do
    local memberPoolData = self._memberDataPool[index]
    if memberPoolData ~= nil and memberPoolData._isSet == true then
      memberPoolData._control:SetShow(false)
      memberPoolData._control:SetCheck(false)
      memberPoolData._control:removeInputEvent("Mouse_LUp")
      memberPoolData._userNo = nil
      memberPoolData._isSet = false
    end
    local memberMiniPoolData = self._memberMiniDataPool[index]
    if memberMiniPoolData ~= nil and memberMiniPoolData._isSet == true then
      memberMiniPoolData._control:SetShow(false)
      memberMiniPoolData._control:SetCheck(false)
      memberMiniPoolData._control:removeInputEvent("Mouse_LUp")
      memberMiniPoolData._userNo = nil
      memberMiniPoolData._isSet = false
    end
  end
end
function PaGlobal_RoseWarPartyList:selectCommanderIndex(index)
  if Panel_RoseWar_PartyList == nil then
    return
  end
  self._selectedIndex = index
end
function PaGlobal_RoseWarPartyList:selectCommander()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  local isShowMinify = self._ui._chk_showMinify:IsCheck()
  if isShowMinify == true then
    do
      local memberMiniPoolData = self._memberMiniDataPool[self._selectedIndex]
      if memberMiniPoolData == nil or memberMiniPoolData._userNo == nil then
        return
      end
      local function requestChangeCommander()
        ToClient_RequestChangeRoseWarCommander(memberMiniPoolData._userNo)
      end
      local userNickName = memberMiniPoolData._txt_memberName:GetText()
      local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_APPLY_CONFIRM_COMMANDER", "familyname", userNickName)
      local messageBoxData = {
        title = nil,
        content = messageBoxMemo,
        functionYes = requestChangeCommander,
        functionNo = MessageBox_Empty_function,
        exitButton = true,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, nil, false, false)
    end
  else
    do
      local memberPoolData = self._memberDataPool[self._selectedIndex]
      if memberPoolData == nil or memberPoolData._userNo == nil then
        return
      end
      local function requestChangeCommander()
        ToClient_RequestChangeRoseWarCommander(memberPoolData._userNo)
      end
      local userNickName = memberPoolData._txt_memberName:GetText()
      local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_APPLY_CONFIRM_COMMANDER", "familyname", userNickName)
      local messageBoxData = {
        title = nil,
        content = messageBoxMemo,
        functionYes = requestChangeCommander,
        functionNo = MessageBox_Empty_function,
        exitButton = true,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData, nil, false, false)
    end
  end
end
function PaGlobal_RoseWarPartyList:setCommanderInfo()
  if Panel_RoseWar_PartyList == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  local classType = selfPlayer:getClassType()
  local skillTypeParam = ToClient_GetCurrentPlayerSkillType()
  local playerName = selfPlayer:getUserNickname()
  local roseWarTeamNo = selfPlayer:getRoseWarTeamNo()
  PaGlobalFunc_Util_SetSolrareRankingClassBigBG(self._ui._stc_commanderIcon, classType)
  PaGlobalFunc_Util_ChangeTextureClass(self._ui._stc_commanderClassIcon, classType)
  self._ui._stc_commanderName:SetText(playerName)
  if roseWarTeamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
    self._ui._stc_top:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_CampList_BG_Kama")
    self._ui._stc_regionMark:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_CampList_Icon_Flag_Kama")
  elseif roseWarTeamNo == Defines.RoseWarTeamNo.ODYLLITA then
    self._ui._stc_top:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_CampList_BG_Odil")
    self._ui._stc_regionMark:ChangeTextureInfoTextureIDAsync("Combine_Etc_RoseWar_CampList_Icon_Flag_Odil")
  end
  self._ui._stc_top:setRenderTexture(self._ui._stc_top:getBaseTexture())
  self._ui._stc_regionMark:setRenderTexture(self._ui._stc_regionMark:getBaseTexture())
  self._ui._stc_commanderSuccession:SetShow(false)
  self._ui._stc_commanderAwaken:SetShow(false)
  self._ui._stc_commanderShy:SetShow(false)
  self._ui._stc_commanderArcher:SetShow(false)
  if classType == __eClassType_ShyWaman then
    self._ui._stc_commanderShy:SetShow(true)
  elseif classType == __eClassType_RangerMan then
    self._ui._stc_commanderArcher:SetShow(true)
  elseif skillType == __eSkillTypeParam_Awaken then
    self._ui._stc_commanderAwaken:SetShow(true)
  elseif skillType == __eSkillTypeParam_Inherit then
    self._ui._stc_commanderSuccession:SetShow(true)
  end
  local myGuildWrapper = ToClient_GetMyGuildInfoWrapper()
  local isSet = setGuildTextureByGuildNo(myGuildWrapper:getGuildNo_s64(), self._ui._stc_guildMark)
  local x1, y1, x2, y2 = 0, 0, 1, 1
  if isSet == true then
    self._ui._stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_guildMark:setRenderTexture(self._ui._stc_guildMark:getBaseTexture())
  else
    self._ui._stc_guildMark:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_guildMark, 227, 17, 270, 43)
    self._ui._stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui._stc_guildMark:setRenderTexture(self._ui._stc_guildMark:getBaseTexture())
  end
  self._ui._stc_guildName:SetText(myGuildWrapper:getName())
end
