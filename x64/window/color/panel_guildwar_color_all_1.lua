function PaGlobal_GuildWarColor_All:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_titleBG = UI.getChildControl(Panel_GuildWar_Color, "Static_Title")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBG, "Button_Close")
  self._ui._stc_guildListBG = UI.getChildControl(Panel_GuildWar_Color, "Static_GuildList_BG")
  self._ui._stc_guildList = UI.getChildControl(self._ui._stc_guildListBG, "List2_TitleList_Import")
  self._ui._stc_previewColorBG = UI.getChildControl(Panel_GuildWar_Color, "Static_PreviewColor")
  self._ui._btn_confirm = UI.getChildControl(self._ui._stc_previewColorBG, "Button_Confirm")
  self._ui._btn_resetColor = UI.getChildControl(self._ui._stc_previewColorBG, "Button_ResetColor")
  self._ui._stc_illustBG = UI.getChildControl(self._ui._stc_previewColorBG, "Static_Illust")
  self._ui._stc_leftIllustBG = UI.getChildControl(self._ui._stc_illustBG, "Static_Left")
  self._ui._txt_leftGuildName = UI.getChildControl(self._ui._stc_leftIllustBG, "StaticText_GuildName")
  self._ui._txt_leftAccountName = UI.getChildControl(self._ui._stc_leftIllustBG, "StaticText_AccountName")
  self._ui._txt_leftCharacterName = UI.getChildControl(self._ui._stc_leftIllustBG, "StaticText_CharacterName")
  self._ui._stc_rightIllustBG = UI.getChildControl(self._ui._stc_illustBG, "Static_Right")
  self._ui._txt_rightGuildName = UI.getChildControl(self._ui._stc_rightIllustBG, "StaticText_GuildName")
  self._ui._txt_rightAccountName = UI.getChildControl(self._ui._stc_rightIllustBG, "StaticText_AccountName")
  self._ui._txt_rightCharacterName = UI.getChildControl(self._ui._stc_rightIllustBG, "StaticText_CharacterName")
  self._ui._stc_descBG = UI.getChildControl(self._ui._stc_previewColorBG, "Static_DescEdge_Import")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_Desc")
  self._ui._stc_keyGuideBG = UI.getChildControl(Panel_GuildWar_Color, "Static_KeyGuide_Console")
  self._ui._txt_keyGuide_A = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_Console")
  self._ui._txt_keyGuide_B = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_Console")
  self._ui._txt_keyGuide_Y = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_Console")
  self._ui._txt_keyGuide_LT_X = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_LT_X_Console")
  self:validate()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_GuildWarColor_All:validate()
  if Panel_GuildWar_Color == nil then
    return
  end
  self._ui._stc_titleBG:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._stc_guildListBG:isValidate()
  self._ui._stc_guildList:isValidate()
  self._ui._stc_previewColorBG:isValidate()
  self._ui._stc_illustBG:isValidate()
  self._ui._stc_leftIllustBG:isValidate()
  self._ui._txt_leftGuildName:isValidate()
  self._ui._txt_leftAccountName:isValidate()
  self._ui._txt_leftCharacterName:isValidate()
  self._ui._stc_rightIllustBG:isValidate()
  self._ui._txt_rightGuildName:isValidate()
  self._ui._txt_rightAccountName:isValidate()
  self._ui._txt_rightCharacterName:isValidate()
  self._ui._stc_descBG:isValidate()
  self._ui._txt_desc:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._btn_resetColor:isValidate()
  self._ui._stc_keyGuideBG:isValidate()
  self._ui._txt_keyGuide_A:isValidate()
  self._ui._txt_keyGuide_B:isValidate()
  self._ui._txt_keyGuide_Y:isValidate()
  self._ui._txt_keyGuide_LT_X:isValidate()
end
function PaGlobal_GuildWarColor_All:registEventHandler()
  if Panel_GuildWar_Color == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_GuildWarColor_All_Resize")
  registerEvent("FromClient_RefreshGuildColorPanel", "FromClient_GuildWarColor_All_Refresh")
  registerEvent("FromClient_GetGuildListForWarCorresspondent", "FromClient_GetGuildListForWarCorresspondent")
  self._ui._stc_guildList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_GuildWarColor_All_CreateContent")
  self._ui._stc_guildList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:SetShow(not self._isConsole)
  self._ui._btn_confirm:SetShow(not self._isConsole)
  self._ui._btn_resetColor:SetShow(not self._isConsole)
  self._ui._stc_keyGuideBG:SetShow(self._isConsole)
  if self._isConsole == false then
    self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildWarColor_All_Close()")
    self._ui._btn_confirm:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColor_All_ChangeGuildColor()")
    self._ui._btn_resetColor:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColor_All_ResetAllGuildColor()")
  else
    Panel_GuildWar_Color:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_GuildWarColor_All_ChangeGuildColor()")
    Panel_GuildWar_Color:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_GuildWarColor_All_ResetAllGuildColor()")
  end
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  self._panelBaseSizeY = Panel_GuildWar_Color:GetSizeY()
  self._listBGBaseSizeY = self._ui._stc_previewColorBG:GetSizeY()
  self._listBaseSizeY = self._ui._stc_guildList:GetSizeY()
  self._previewBGBaseSizeY = self._ui._stc_guildListBG:GetSizeY()
  self._descBgBaseSpanSizeY = self._ui._stc_descBG:GetSpanSize().y
  self._descBaseBGSizeY = self._ui._stc_descBG:GetSizeY()
  self._descBaseSizeY = self._ui._txt_desc:GetSizeY()
end
function PaGlobal_GuildWarColor_All:setAlignKeyGuide()
  if Panel_GuildWar_Color == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local keyGuides = {
    self._ui._txt_keyGuide_LT_X,
    self._ui._txt_keyGuide_Y,
    self._ui._txt_keyGuide_A,
    self._ui._txt_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_GuildWarColor_All:resize()
  if Panel_GuildWar_Color == nil then
    return
  end
  local addSizeY = 0
  local descGapY = self._ui._txt_desc:GetTextSizeY() - self._descBaseSizeY
  if descGapY > 0 then
    addSizeY = descGapY
  end
  local buttonSizeGapY = 0
  if self._isConsole == true then
    buttonSizeGapY = 60
  end
  Panel_GuildWar_Color:SetSize(Panel_GuildWar_Color:GetSizeX(), self._panelBaseSizeY + addSizeY - buttonSizeGapY)
  self._ui._stc_guildListBG:SetSize(self._ui._stc_guildListBG:GetSizeX(), self._previewBGBaseSizeY + addSizeY - buttonSizeGapY)
  self._ui._stc_guildList:SetSize(self._ui._stc_guildList:GetSizeX(), self._listBaseSizeY + addSizeY - buttonSizeGapY)
  self._ui._stc_previewColorBG:SetSize(self._ui._stc_previewColorBG:GetSizeX(), self._listBGBaseSizeY + addSizeY - buttonSizeGapY)
  self._ui._stc_descBG:SetSize(self._ui._stc_descBG:GetSizeX(), self._descBaseBGSizeY + addSizeY)
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._descBaseSizeY + addSizeY)
  Panel_GuildWar_Color:ComputePosAllChild()
  if self._isConsole == true then
    self._ui._stc_descBG:SetSpanSize(self._ui._stc_descBG:GetSpanSize().x, 15)
  else
    self._ui._stc_descBG:SetSpanSize(self._ui._stc_descBG:GetSpanSize().x, self._descBgBaseSpanSizeY)
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local addPosX = 0
  if Panel_GuildWar_ColorList ~= nil then
    addPosX = Panel_GuildWar_ColorList:GetSizeX() / 2
  end
  Panel_GuildWar_Color:SetPosX(screenSizeX / 2 - Panel_GuildWar_Color:GetSizeX() / 2 - addPosX)
  Panel_GuildWar_Color:SetPosY(screenSizeY / 2 - Panel_GuildWar_Color:GetSizeY() / 2)
  self:setAlignKeyGuide()
end
function PaGlobal_GuildWarColor_All:prepareOpen(isShowCloseNotify)
  if Panel_GuildWar_Color == nil then
    return
  end
  if _ContentsGroup_EditGuildColor == false then
    return
  end
  if self:openCheck(isShowCloseNotify) == false then
    self:prepareClose()
    return
  end
  if Panel_GuildWar_Color:GetShow() == false and PaGlobalFunc_GuildMain_All_Close ~= nil then
    PaGlobalFunc_GuildMain_All_Close()
  end
  self:resize()
  self:update()
  self:open()
end
function PaGlobal_GuildWarColor_All:open()
  if Panel_GuildWar_Color == nil then
    return
  end
  Panel_GuildWar_Color:SetShow(true)
end
function PaGlobal_GuildWarColor_All:prepareClose()
  if Panel_GuildWar_Color == nil then
    return
  end
  if Panel_GuildWar_ColorList ~= nil and Panel_GuildWar_ColorList:GetShow() == true and PaGlobalFunc_GuildWarColorList_All_Close ~= nil then
    PaGlobalFunc_GuildWarColorList_All_Close()
  end
  self:close()
end
function PaGlobal_GuildWarColor_All:close()
  if Panel_GuildWar_Color == nil then
    return
  end
  Panel_GuildWar_Color:SetShow(false)
end
function PaGlobal_GuildWarColor_All:openCheck(isShowCloseNotify)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  local guildNoOrAllianceNo = selfPlayerWrapper:getGuildNo_s64()
  if selfPlayerWrapper:isGuildAllianceMember() == true then
    guildNoOrAllianceNo = selfPlayerWrapper:getGuildAllianceNo_s64()
  end
  if ToClient_isWarCorresspondent() == false then
    if ToClient_getSiegeParticipant() == false then
      if isShowCloseNotify == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDCOLOR_MSG_JOIN"))
      end
      return false
    end
    if ToClient_getEditGuildColorByGuildNo(guildNoOrAllianceNo) == 0 then
      if isShowCloseNotify == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDCOLOR_MSG_SIEGE_ING"))
      end
      return false
    end
    local selfPlayer = getSelfPlayer():get()
    if selfPlayer == nil then
      return false
    end
    if _ContentsGroup_GuildAuthoritySeparation == true then
      if PaGlobalFunc_Guild_Authorization_RightCheck(__eGuildRightNew_EditGuildColor) == false then
        if isShowCloseNotify == true then
          PaGlobalFunc_Guild_Authorization_ShowErrMessage(__eGuildRightNew_EditGuildColor)
        end
        return false
      end
    elseif _ContentsGroup_GuildRightInfo == true then
      if ToClient_IsCheckGuildRightType(__eGuildRightType_EditGuildColor) == false then
        if isShowCloseNotify == true then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDCOLOR_MSG_GRADE_SET"))
        end
        return false
      end
    elseif selfPlayer:isGuildMaster() == false and selfPlayer:isGuildSubMaster() == false then
      if isShowCloseNotify == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDCOLOR_MSG_GRADE_SET"))
      end
      return false
    end
    local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
    if myGuildListInfo == nil then
      if isShowCloseNotify == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseItemNotExistGuild"))
      end
      return false
    end
    local myUserNo = selfPlayer:getUserNo()
    local myGuildMemberInfo = myGuildListInfo:getMemberByUserNo(myUserNo)
    if myGuildMemberInfo == nil then
      if isShowCloseNotify == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantUseItemNotExistGuild"))
      end
      return false
    end
    local expiration = myGuildMemberInfo:getContractedExpirationUtc()
    local leftTime = Int64toInt32(getLeftSecond_TTime64(expiration))
    if leftTime <= 0 then
      if isShowCloseNotify == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDCOLOR_MSG_REAGREEMENT"))
      end
      return false
    end
  end
  if ToClient_getGuildColorCount() <= 1 then
    if isShowCloseNotify == true then
      if ToClient_IsVillageSiegeBeing() == true then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSiege2024ParticipatingGuildOnlyOneLeft"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCanUseGuildSkillOnlyParticipant"))
      end
    end
    return false
  end
  self._myGuildOrAllianceNo = guildNoOrAllianceNo
  return true
end
function PaGlobal_GuildWarColor_All:update()
  if Panel_GuildWar_Color == nil then
    return
  end
  ToClient_updateTempGuildColor()
  self._ui._stc_guildList:getElementManager():clearKey()
  local guildNoListCount = ToClient_getGuildColorCount()
  if guildNoListCount <= 1 then
    return
  end
  for index = 0, guildNoListCount - 1 do
    self._ui._stc_guildList:getElementManager():pushKey(toInt64(0, index))
  end
end
function PaGlobal_GuildWarColor_All:createContent(content, key64)
  if Panel_GuildWar_Color == nil then
    return
  end
  local index = Int64toInt32(key64)
  local stc_titleName = UI.getChildControl(content, "RadioButton_TilteName")
  local stc_guildMarkBg = UI.getChildControl(stc_titleName, "Static_GuildMark")
  local stc_guildMark = UI.getChildControl(stc_guildMarkBg, "Static_Mark")
  local txt_guildName = UI.getChildControl(stc_titleName, "StaticText_GuildName")
  local txt_territoryName = UI.getChildControl(stc_titleName, "StaticText_TerritoryName")
  local btn_guildColor = UI.getChildControl(stc_titleName, "Button_SetColor")
  stc_titleName:addInputEvent("Mouse_LUp", "HandleEventLUp_GuildWarColor_All_SelectGuildIndex(" .. tostring(index) .. ", true)")
  txt_guildName:SetTextMode(__eTextMode_LimitText)
  txt_guildName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GUILDNAME_COLOR_UNKNOWN"))
  txt_territoryName:SetTextMode(__eTextMode_LimitText)
  txt_territoryName:SetText("")
  txt_territoryName:SetShow(false)
  local isVillageSiegeBeing = ToClient_IsVillageSiegeBeing()
  local guildNo, territoryName
  local isShowInfo = false
  local isMinorSiegeModeNoReady = false
  if isVillageSiegeBeing == true and (ToClient_GetMinorSiegeMode() == __eMinorSiegeModeOccupy or ToClient_getSiegeTerritoryType() == __eSiegeTerritoryType_Ocean) then
    isMinorSiegeModeNoReady = true
  end
  if isMinorSiegeModeNoReady == true then
    guildNo = ToClient_getGuildNoByBuildingInfoIndex(index)
    territoryName = getTerritoryNameByKey(getTerritoryByIndex(ToClient_GetStartSiegeTerritoryKey()))
    if guildNo ~= toInt64(0, 0) then
      isShowInfo = true
    end
  else
    guildNo = ToClient_getGuildNoByBuildingInfoIndex(index)
    local buildingInfoCount = ToClient_getGuildColorBuildingInfoCount(index)
    for buindingInfoIndex = 0, buildingInfoCount - 1 do
      local checkBuildinfInfo = ToClient_getGuildColorBuildingInfoByIndex(index, buindingInfoIndex)
      if checkBuildinfInfo ~= nil and checkBuildinfInfo:isDetected() == true then
        if isVillageSiegeBeing == true then
          buildingRegionKey = checkBuildinfInfo:getBuildingRegionKey()
        else
          buildingRegionKey = checkBuildinfInfo:getAffiliatedRegionKey()
        end
        local regionInfo = getRegionInfoByRegionKey(buildingRegionKey)
        if regionInfo ~= nil then
          if territoryName == nil then
            territoryName = regionInfo:getAreaName()
          else
            local regionAreaName = regionInfo:getAreaName()
            if string.find(territoryName, regionAreaName) == nil then
              territoryName = territoryName .. ", " .. regionAreaName
            end
          end
        end
        isShowInfo = true
      end
    end
    if guildNo ~= toInt64(0, 0) and guildNo == self._myGuildOrAllianceNo then
      isShowInfo = true
    end
  end
  if ToClient_isWarCorresspondent() == true then
    isShowInfo = true
  end
  local guildName
  local isGuildMarkSet = false
  if isShowInfo == true then
    local allianceName = ToClient_getGuildAllianceNameByGuildNo(guildNo)
    if allianceName ~= "" then
      guildName = allianceName
      isGuildMarkSet = setGuildTextureByAllianceNo(guildNo, stc_guildMark)
    else
      local tempGuildName = ToClient_getGuildNameByGuildNo(guildNo)
      if tempGuildName ~= "" then
        guildName = tempGuildName
        isGuildMarkSet = setGuildTextureByGuildNo(guildNo, stc_guildMark)
      end
    end
    if guildName ~= nil and guildName ~= "" then
      txt_guildName:SetText(guildName)
    end
    if territoryName ~= nil then
      territoryName = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDCOLOR_TERRITORYNAME", "territoryName", territoryName)
      txt_territoryName:SetText(territoryName)
      txt_territoryName:SetShow(true)
    end
  end
  if txt_territoryName:GetShow() == true then
    txt_guildName:SetSpanSize(txt_guildName:GetSpanSize().x, 5)
    txt_guildName:SetVerticalTop()
  else
    txt_guildName:SetSpanSize(txt_guildName:GetSpanSize().x, 0)
    txt_guildName:SetVerticalMiddle()
  end
  if isGuildMarkSet == true then
    stc_guildMark:getBaseTexture():setUV(0, 0, 1, 1)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
    stc_guildMark:SetShow(true)
  else
    stc_guildMark:ChangeTextureInfoNameAsync("combine/frame/combine_frame_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(stc_guildMark, 205, 1, 255, 51)
    stc_guildMark:getBaseTexture():setUV(x1, y1, x2, y2)
    stc_guildMark:setRenderTexture(stc_guildMark:getBaseTexture())
    stc_guildMark:SetShow(true)
  end
  local guildColor = ToClient_getTempGuildColorByGuildNo(guildNo)
  if guildColor == 0 then
    guildColor = self._baseColor
  end
  btn_guildColor:SetColor(guildColor)
  UI.setLimitTextAndAddTooltip(txt_guildName)
  UI.setLimitTextAndAddTooltip(txt_territoryName)
  if index == 0 then
    stc_titleName:SetCheck(true)
    HandleEventLUp_GuildWarColor_All_SelectGuildIndex(0, true)
  else
    stc_titleName:SetCheck(false)
  end
end
function PaGlobal_GuildWarColor_All:selectGuildIndex(index)
  if Panel_GuildWar_Color == nil then
    return
  end
  if Panel_GuildWar_Color == nil or index == nil then
    return
  end
  local content = self._ui._stc_guildList:GetContentByKey(index)
  if content == nil then
    return
  end
  local stc_titleName = UI.getChildControl(content, "RadioButton_TilteName")
  if stc_titleName == nil then
    return
  end
  local txt_guildName = UI.getChildControl(stc_titleName, "StaticText_GuildName")
  if txt_guildName == nil then
    return
  end
  local guildName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NICKNAME_SAMPLE_GUILD")
  local guildNo = ToClient_getGuildNoByBuildingInfoIndex(index)
  if guildNo == self._myGuildOrAllianceNo then
    guildName = "<" .. txt_guildName:GetText() .. ">"
  elseif ToClient_IsVillageSiegeBeing() == true then
    guildName = "<" .. txt_guildName:GetText() .. ">"
  else
    local buildingInfoCount = ToClient_getGuildColorBuildingInfoCount(index)
    for buindingInfoIndex = 0, buildingInfoCount - 1 do
      local checkBuildinfInfo = ToClient_getGuildColorBuildingInfoByIndex(index, buindingInfoIndex)
      if checkBuildinfInfo ~= nil and checkBuildinfInfo:isDetected() == true then
        guildName = "<" .. txt_guildName:GetText() .. ">"
        break
      end
    end
  end
  stc_titleName:SetCheck(true)
  self._ui._txt_leftGuildName:SetText(guildName)
  self._ui._txt_rightGuildName:SetText(guildName)
  local guildNo = ToClient_getGuildNoByBuildingInfoIndex(index)
  local colorKey = ToClient_getTempGuildColorByGuildNo(guildNo)
  self._selectedColor = colorKey
  self._selectedGuildIndex = index
  self:setNameColor(colorKey)
end
function PaGlobal_GuildWarColor_All:setSelectGuildColor(colorKey)
  if Panel_GuildWar_Color == nil then
    return
  end
  if colorKey == nil or self._selectedGuildIndex == nil then
    return
  end
  local guildNo = ToClient_getGuildNoByBuildingInfoIndex(self._selectedGuildIndex)
  if guildNo == toInt64(0, 0) then
    return
  end
  local content = self._ui._stc_guildList:GetContentByKey(self._selectedGuildIndex)
  if content == nil then
    return
  end
  local bg_setColor = UI.getChildControl(content, "RadioButton_TilteName")
  if bg_setColor == nil then
    return
  end
  local btn_setColor = UI.getChildControl(bg_setColor, "Button_SetColor")
  if btn_setColor == nil then
    return
  end
  if ToClient_setTempGuildColor(guildNo, colorKey) == false then
    return
  end
  btn_setColor:SetColor(colorKey)
  self:setNameColor(colorKey)
end
function PaGlobal_GuildWarColor_All:setAllGuildColor(colorKey)
  if Panel_GuildWar_Color == nil then
    return
  end
  local guildNoListCount = ToClient_getGuildColorCount()
  if guildNoListCount == 0 then
    return
  end
  if self._selectedGuildIndex ~= nil then
    local prevContent = self._ui._stc_guildList:GetContentByKey(self._selectedGuildIndex)
    if prevContent ~= nil then
      local stc_prevTitleName = UI.getChildControl(prevContent, "RadioButton_TilteName")
      if stc_prevTitleName ~= nil then
        stc_prevTitleName:SetCheck(false)
      end
    end
  end
  for index = 0, guildNoListCount - 1 do
    self._selectedGuildIndex = index
    PaGlobal_GuildWarColor_All:setSelectGuildColor(colorKey)
  end
  HandleEventLUp_GuildWarColor_All_SelectGuildIndex(0, false)
end
function PaGlobal_GuildWarColor_All:setNameColor(colorKey)
  if Panel_GuildWar_Color == nil then
    return
  end
  self._ui._txt_leftGuildName:useGlowFont(false)
  self._ui._txt_leftAccountName:useGlowFont(false)
  self._ui._txt_leftAccountName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF000000)
  self._ui._txt_leftAccountName:SetFontColor(colorKey)
  self._ui._txt_leftCharacterName:useGlowFont(false)
  self._ui._txt_leftCharacterName:SetFontColor(colorKey)
  self._ui._txt_rightGuildName:useGlowFont(false)
  self._ui._txt_rightAccountName:useGlowFont(false)
  self._ui._txt_rightAccountName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF000000)
  self._ui._txt_rightAccountName:SetFontColor(colorKey)
  self._ui._txt_rightCharacterName:useGlowFont(false)
  self._ui._txt_rightCharacterName:SetFontColor(colorKey)
  if colorKey == 0 or colorKey == self._baseColor then
    local nameTendencyColor = function(tendency)
      local r, g, b = 0, 0, 0
      local upValue = __eMaxTendency
      local downValue = __eMinTendency
      if tendency > 0 then
        local percents = tendency / upValue
        r = math.floor(203 - 203 * percents)
        g = math.floor(203 - 203 * percents)
        b = math.floor(203 + 52 * percents)
      else
        local percents = tendency / downValue
        r = math.floor(203 + 52 * percents)
        g = math.floor(203 - 203 * percents)
        b = math.floor(203 - 203 * percents)
      end
      local sumColorValue = 4278190080 + 65536 * r + 256 * g + b
      return sumColorValue
    end
    self._ui._txt_leftGuildName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF0C6CBD)
    self._ui._txt_leftGuildName:SetFontColor(Defines.Color.C_FFFFFFFF)
    self._ui._txt_leftCharacterName:useGlowFont(true, "BaseFont_10_Glow", nameTendencyColor(300000))
    self._ui._txt_rightGuildName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF0C6CBD)
    self._ui._txt_rightGuildName:SetFontColor(Defines.Color.C_FFFFFFFF)
    self._ui._txt_rightCharacterName:useGlowFont(true, "BaseFont_10_Glow", nameTendencyColor(300000))
  else
    self._ui._txt_leftGuildName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF000000)
    self._ui._txt_leftGuildName:SetFontColor(colorKey)
    self._ui._txt_leftCharacterName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF000000)
    self._ui._txt_rightGuildName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF000000)
    self._ui._txt_rightGuildName:SetFontColor(colorKey)
    self._ui._txt_rightCharacterName:useGlowFont(true, "BaseFont_10_Glow", Defines.Color.C_FF000000)
  end
end
