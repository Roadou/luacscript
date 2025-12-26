function PaGlobal_GuildMemberPointDetail_All:initialize()
  if PaGlobal_GuildMemberPointDetail_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local infoArea = UI.getChildControl(Panel_Window_GuildMemberPointDetail_All, "Static_InfoArea")
  self._ui.stc_Grade = UI.getChildControl(infoArea, "Static_Grade")
  self._ui.txt_FamilyName = UI.getChildControl(infoArea, "StaticText_FamilyName")
  self._ui.txt_Point = UI.getChildControl(infoArea, "StaticText_PointValue")
  self._ui.frame_list = UI.getChildControl(Panel_Window_GuildMemberPointDetail_All, "Frame_DocumentArea")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_list, "Frame_1_Content")
  self._ui.scroll_vs = UI.getChildControl(self._ui.frame_list, "Frame_1_VerticalScroll")
  self._ui.scroll_vsCtrl = UI.getChildControl(self._ui.scroll_vs, "Frame_1_VerticalScroll_CtrlButton")
  local titleArea = UI.getChildControl(Panel_Window_GuildMemberPointDetail_All, "Static_TitleArea")
  self._ui_pc.btn_Close = UI.getChildControl(titleArea, "Button_Close")
  self._ui_pc.btn_Close2 = UI.getChildControl(Panel_Window_GuildMemberPointDetail_All, "Button_Close")
  self._ui_console.btn_Close = UI.getChildControl(Panel_Window_GuildMemberPointDetail_All, "Static_ConsoleUI")
  local txt_KeyGuideX = UI.getChildControl(self._ui_console.btn_Close, "StaticText_B_ConsoleUI")
  infoArea:addInputEvent("Mouse_UpScroll", "HandleEventScroll_GuildMemberPointDetail_All_Scroll(true)")
  infoArea:addInputEvent("Mouse_DownScroll", "HandleEventScroll_GuildMemberPointDetail_All_Scroll(false)")
  local keyguides = {txt_KeyGuideX}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui_console.btn_Close, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  PaGlobal_GuildMemberPointDetail_All:registEventHandler()
  PaGlobal_GuildMemberPointDetail_All:changePlatform()
  PaGlobal_GuildMemberPointDetail_All:CreateControl()
  PaGlobal_GuildMemberPointDetail_All:FrameUpdate()
  PaGlobal_GuildMemberPointDetail_All:validate()
  PaGlobal_GuildMemberPointDetail_All._initialize = true
end
function PaGlobal_GuildMemberPointDetail_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
end
function PaGlobal_GuildMemberPointDetail_All:registEventHandler()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  self._ui_pc.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_GuildMemberPointDetail_All_Close()")
  self._ui_pc.btn_Close2:addInputEvent("Mouse_LUp", "PaGlobal_GuildMemberPointDetail_All_Close()")
  Panel_Window_GuildMemberPointDetail_All:registerPadEvent(__eConsoleUIPadEvent_B, "PaGlobal_GuildMemberPointDetail_All_Close()")
  registerEvent("FromClient_LoadGuildActivityPoint", "PaGlobal_GuildMemberPointDetail_All_LoadGuildActivityPoint")
end
function PaGlobal_GuildMemberPointDetail_All:CreateControl()
  self._ui.stc_siegeTitle = UI.getChildControl(self._ui.frame_content, "StaticText_SiegeWarTitle")
  self._ui.stc_requestTitle = UI.getChildControl(self._ui.frame_content, "StaticText_PointApplicationTitle")
  self._ui.stc_sendAllTitle = UI.getChildControl(self._ui.frame_content, "StaticText_PointBonusTitle")
  local function createListInfo(type, pIndex)
    local documentIcon
    documentIcon = UI.createAndCopyBasePropertyControl(self._ui.frame_content, "Static_DocumentIcon_Template", self._ui.frame_content, type .. "_guildMemeberlist_MemberBg_" .. pIndex)
    documentIcon:SetShow(false)
    return documentIcon
  end
  for index = 0, self._config.listMaxCount - 1 do
    self._ui._requestList[index] = createListInfo(1, index)
    self._ui._allSendList[index] = createListInfo(2, index)
  end
end
function PaGlobal_GuildMemberPointDetail_All:prepareOpen(index)
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  if self._isConsole == true then
    TooltipSimple_Hide()
  end
  if true == self._isConsole then
    ToClient_padSnapSetTargetPanel(Panel_Window_GuildMemberPointDetail_All)
  end
  PaGlobal_GuildMemberPointDetail_All:infoSetting(index)
  PaGlobal_GuildMemberPointDetail_All:update()
  PaGlobal_GuildMemberPointDetail_All:open()
end
function PaGlobal_GuildMemberPointDetail_All:open()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  Panel_Window_GuildMemberPointDetail_All:SetShow(true)
end
function PaGlobal_GuildMemberPointDetail_All:prepareClose()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  PaGlobal_GuildMemberPointDetail_All._memberIndex = -1
  PaGlobal_GuildMemberPointDetail_All:close()
end
function PaGlobal_GuildMemberPointDetail_All:close()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  Panel_Window_GuildMemberPointDetail_All:SetShow(false)
end
function PaGlobal_GuildMemberPointDetail_All:infoSetting(index)
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local guildWrapper = ToClient_GetMyGuildInfoWrapper()
  if nil == guildWrapper then
    return
  end
  local myGuildListInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildListInfo then
    return
  end
  local dataIdx = index
  local guildMember = myGuildListInfo:getMember(dataIdx)
  local userNo = guildMember:getUserNo()
  local familyName = guildMember:getName()
  local myPoint = guildMember:getActivityPoint()
  local siegePoint = ToClient_GetSiegeActivityPoint(userNo)
  local requestPoint = ToClient_GetRequestActivityPoint(userNo)
  local allSendPoint = ToClient_GetSendAllActivityPoint(userNo)
  local siegePointCount = ToClient_GetSiegeActivityPointCount(userNo)
  local requestPointCount = ToClient_GetRequestActivityPointCount(userNo)
  local allSendPointCount = ToClient_GetSendAllActivityPointCount(userNo)
  local listCount = ToClient_GetActivityPointListCount(userNo)
  local gradeType = guildMember:getGrade()
  local isVacation = guildMember:isVacation()
  self:setGradeInfo(self._ui.stc_Grade, gradeType, isVacation)
  self._ui.txt_FamilyName:SetText(familyName)
  self._ui.txt_Point:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_HAVEPOINT", "pointValue", myPoint))
  self._ui.stc_siegeTitle:SetTextMode(__eTextMode_AutoWrap)
  self._ui.stc_siegeTitle:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_SIEGEPOINT", "count", siegePointCount, "pointValue", siegePoint))
  self._ui.stc_requestTitle:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_CLAIMANTCOUNT", "count", requestPointCount, "pointValue", requestPoint))
  self._ui.stc_sendAllTitle:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_POINTDETAIL_BONUSCOUNT", "count", allSendPointCount, "pointValue", allSendPoint))
  for index = 0, self._config.listMaxCount - 1 do
    self._ui._requestList[index]:SetShow(false)
    self._ui._allSendList[index]:SetShow(false)
    self._ui._requestList[index]:addInputEvent("Mouse_LUp", "")
    self._ui._allSendList[index]:addInputEvent("Mouse_LUp", "")
  end
  self._ui.stc_requestTitle:SetPosY(self._ui.stc_siegeTitle:GetPosY() + self._ui.stc_siegeTitle:GetSizeY() + 10)
  local tempPosY = self._ui.stc_requestTitle:GetPosY() + 30
  local uIIndex = 0
  local listPosX = 0
  local listPosY = tempPosY
  local isCheck = false
  for index = 0, listCount - 1 do
    local listWrapper = ToClient_GetGuildActivityPoint(userNo, index)
    if listWrapper == nil then
      break
    end
    if index >= self._config.listMaxCount then
      break
    end
    if ToClient_GetGuildActivityPointIsSendAll(userNo, index) == false then
      listPosX = math.floor(uIIndex % self._config.colCount) * 40 + 3
      listPosY = math.floor(uIIndex / self._config.colCount) * 30 + tempPosY
      self._ui._requestList[uIIndex]:SetShow(true)
      self._ui._requestList[uIIndex]:SetPosX(listPosX)
      self._ui._requestList[uIIndex]:SetPosY(listPosY)
      self._ui._requestList[uIIndex]:addInputEvent("Mouse_On", "PaGlobal_GuildMemberPointDetail_All_OpenInfo(false," .. tostring(userNo) .. "," .. tostring(index) .. "," .. tostring(uIIndex) .. ")")
      self._ui._requestList[uIIndex]:addInputEvent("Mouse_Out", "PaGlobal_GuildMemberPointDetail_All_HideInfo()")
      PaGlobal_GuildMemberPointDetail_All:changeTexture(self._ui._requestList[uIIndex], ToClient_GetGuildActivityPointConfirmType(userNo, index))
      isCheck = true
      uIIndex = uIIndex + 1
    end
  end
  if isCheck == true then
    self._ui.stc_sendAllTitle:SetPosY(listPosY + 40)
  else
    self._ui.stc_sendAllTitle:SetPosY(listPosY + 10)
  end
  tempPosY = self._ui.stc_sendAllTitle:GetPosY() + 30
  uIIndex = 0
  listPosX = 0
  listPosY = 0
  for index = 0, listCount - 1 do
    local listWrapper = ToClient_GetGuildActivityPoint(userNo, index)
    if listWrapper == nil then
      break
    end
    if index >= self._config.listMaxCount then
      break
    end
    if ToClient_GetGuildActivityPointIsSendAll(userNo, index) == true then
      listPosX = math.floor(uIIndex % self._config.colCount) * 40 + 3
      listPosY = math.floor(uIIndex / self._config.colCount) * 30 + tempPosY
      self._ui._allSendList[uIIndex]:SetShow(true)
      self._ui._allSendList[uIIndex]:SetPosX(listPosX)
      self._ui._allSendList[uIIndex]:SetPosY(listPosY)
      self._ui._allSendList[uIIndex]:addInputEvent("Mouse_On", "PaGlobal_GuildMemberPointDetail_All_OpenInfo(true," .. tostring(userNo) .. "," .. tostring(index) .. "," .. tostring(uIIndex) .. ")")
      self._ui._allSendList[uIIndex]:addInputEvent("Mouse_Out", "PaGlobal_GuildMemberPointDetail_All_HideInfo()")
      PaGlobal_GuildMemberPointDetail_All:changeTexture(self._ui._allSendList[uIIndex], ToClient_GetGuildActivityPointConfirmType(userNo, index))
      uIIndex = uIIndex + 1
    end
  end
end
function PaGlobal_GuildMemberPointDetail_All:update()
  self:FrameUpdate()
end
function PaGlobal_GuildMemberPointDetail_All:validate()
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
end
function PaGlobal_GuildMemberPointDetail_All:FrameUpdate()
  self._ui.frame_list:UpdateContentScroll()
  self._ui.frame_list:UpdateContentPos()
  self._ui.scroll_vs:SetInterval(self._ui.frame_content:GetSizeY() / 100 * 1.1)
end
function PaGlobal_GuildMemberPointDetail_All:setGradeInfo(control, grade, isVacation)
  if nil == Panel_Window_GuildMemberPointDetail_All then
    return
  end
  if nil == control then
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
function PaGlobal_GuildMemberPointDetail_All:changeTexture(control, confrimType)
  if Panel_Window_GuildMemberPointDetail_All == nil then
    return
  end
  if nil == control then
    return
  end
  control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
  if confrimType == 0 then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 506, 1, 537, 32)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif confrimType == 1 then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 538, 1, 569, 32)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  elseif confrimType == 2 then
    control:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Guild_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(control, 570, 1, 601, 32)
    control:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  control:setRenderTexture(control:getBaseTexture())
end
