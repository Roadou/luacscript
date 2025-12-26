function PaGlobalFunc_SnowBoardMenu_Open()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SnowBoardMenu_Close()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_SnowBoardMenu_OnCreateItemRankContent(content, key)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  self:updateItemRankContent(false, content, key)
end
function PaGlobalFunc_SnowBoardMenu_OnCreateRankContent(content, key)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  self:updateRankContent(false, content, key)
end
function HandleEventLUp_SnowBoardMenu_SelectTab(index)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  self:selectTab(index)
end
function HandleEventLUp_SnowBoardMenu_GameStart()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  if self._currentTabIndex == nil then
    return
  end
  local tabData = self._tabs[self._currentTabIndex]
  if tabData == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(tabData._keyRaw)
  if snowBoardStatic == nil then
    return
  end
  if _ContentsGroup_SnowBoardMirrorEnter == false then
    return
  end
  local ghostUniqueNo = toInt64(0, 0)
  ToClient_RequestEnterSnowBoardField(tabData._keyRaw, ghostUniqueNo)
end
function HandleEventLUp_SnowBoardMenu_UpdateRankForDev()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  ToClient_RequestEndSnowBoardRaceQA(2)
  ToClient_RequestSnowBoardRankList()
end
function HandleEventLUp_SnowBoardMenu_StartGameWithGhost(isSelfRecord, keyRaw, index)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(keyRaw)
  if snowBoardStatic == nil then
    return
  end
  local ghostUniqueNo = toInt64(0, 0)
  if isSelfRecord == true then
    ghostUniqueNo = ToClient_GetMySnowBoardBestRecordUniqueNo(keyRaw)
  else
    ghostUniqueNo = ToClient_GetSnowBoardRankerRecordUniqueNo(keyRaw, index)
  end
  if _ContentsGroup_SnowBoardMirrorEnter == false then
    return
  end
  ToClient_RequestEnterSnowBoardField(keyRaw, ghostUniqueNo)
end
function HandleEventLUp_SnowBoardMenu_StartReplay(isSelfRecord, keyRaw, index)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(keyRaw)
  if snowBoardStatic == nil then
    return
  end
  local ghostUniqueNo = toInt64(0, 0)
  if isSelfRecord == true then
    ghostUniqueNo = ToClient_GetMySnowBoardBestRecordUniqueNo(keyRaw)
  else
    ghostUniqueNo = ToClient_GetSnowBoardRankerRecordUniqueNo(keyRaw, index)
  end
  ToClient_PlaySnowBoardReplay(ghostUniqueNo)
end
function HandleEventLUp_SnowBoardMenu_DownloadReplay(isSelfRecord, keyRaw, index)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(keyRaw)
  if snowBoardStatic == nil then
    return
  end
  ToClient_RequestDownloadSnowBoardReplay(isSelfRecord, keyRaw, index)
end
function FromClient_SnowBoardMenu_OnEnterField()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  PaGlobalFunc_SnowBoardMenu_Close()
end
function FromClient_SnowBoardMenu_UpdateRank()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  if Panel_Window_SnowBoard_Menu_All:GetShow() == false then
    return
  end
  self:selectTab(self._currentTabIndex)
end
function FromClient_SnowBoardMenu_DownloadComplete(path, filename, recordType)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  if recordType ~= __eReplayRecordType_SnowBoard then
    return
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SOLAREDOWNLOAD_COMPLETEMSG"),
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
  self:selectTab(self._currentTabIndex)
end
function FromClient_SnowBoardMenu_PlayReplay()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  PaGlobalFunc_SnowBoardMenu_Close()
end
function PaGlobalFunc_SnowBoardMenu_ShowDescInfo(show)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local isShow = self._ui.stc_Info:GetShow()
  if isShow == false then
    PaGlobalFunc_SnowBoardMenu_DescriptionCheck()
    self._ui.stc_Info:SetShow(true)
  else
    self._ui.stc_Info:SetShow(false)
  end
end
function PaGlobalFunc_SnowBoardMenu_DescriptionCheck()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local frame = self._ui.stc_frameDesc
  local vScroll = frame:GetVScroll()
  vScroll:SetControlTop()
  frame:UpdateContentScroll()
  frame:UpdateContentPos()
  self._openDesc = -1
  for index = 0, self._frameContentsCount - 1 do
    if self._frame[index]._radioButton:IsCheck() == true then
      self._openDesc = index
      self._frame[index]._bg:SetShow(true)
    else
      self._frame[index]._bg:SetShow(false)
    end
  end
  PaGlobalFunc_SnowBoardMenu_InformationUpdate()
end
function PaGlobalFunc_SnowBoardMenu_InformationUpdate(deltaTime)
  local self = PaGlobal_SnowBoardMenu
  if self == nil or Panel_Window_SnowBoard_Menu_All:GetShow() == false then
    return
  end
  local frame = self._ui.stc_frameDesc
  local vScroll = frame:GetVScroll()
  local content = frame:GetFrameContent()
  local valueExtraY = 200
  for index = 0, self._frameContentsCount - 1 do
    if self._frame[index]._radioButton:IsCheck() == true then
      vScroll:SetShow(frame:GetSizeY() < self._frame[index]._desc:GetSizeY() + valueExtraY)
      content:SetSize(content:GetSizeX(), self._frame[index]._desc:GetSizeY() + valueExtraY)
      self._frame[index]._bg:SetSize(self._frame[index]._bg:GetSizeX(), self._frame[index]._desc:GetSizeY())
      self._frame[index]._bg:SetShow(true)
    else
      self._frame[index]._bg:SetSize(self._frame[index]._bg:GetSizeX(), 10)
      self._frame[index]._bg:SetShow(false)
    end
  end
  for index = 0, self._frameContentsCount - 1 do
    self._frame[index]._bg:SetPosY(self._frame[index]._radioButton:GetPosY() + self._frame[index]._radioButton:GetSizeY())
    if self._frame[index + 1] ~= nil then
      if self._frame[index]._bg:GetShow() == true then
        self._frame[index + 1]._radioButton:SetPosY(self._frame[index]._bg:GetPosY() + self._frame[index]._bg:GetSizeY() + 15)
      else
        self._frame[index + 1]._radioButton:SetPosY(self._frame[index]._radioButton:GetPosY() + self._frame[index]._radioButton:GetSizeY() + 5)
      end
    end
  end
end
function PaGlobalFunc_SnowBoardMenu_RecordWarning_ToolTip(tab, show)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  if show == 0 then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui.stc_itemToolTip
  if tab == 1 then
    control = self._ui.stc_speedToolTip
  end
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_TOOLTIP_RECORD_TITLE")
  local text = PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_TOOLTIP_RECORD_DESC")
  TooltipSimple_Show(control, title, text)
end
function PaGlobalFunc_SnowBoardMenu_TabPad(plus)
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local applyTab = self._currentTabIndex + plus
  if applyTab < 0 then
    applyTab = 2
  elseif applyTab > 2 then
    applyTab = 0
  end
  self:selectTab(applyTab)
end
function PaGlobalFunc_SnowBoardMenu_RecordWarning_ToolTipPad()
  local self = PaGlobal_SnowBoardMenu
  if self == nil then
    return
  end
  local isShow = Panel_Tooltip_SimpleText:GetShow()
  if isShow == true then
    TooltipSimple_Hide()
    return
  end
  local tab = self._currentTabIndex
  local targetControl = self._ui.stc_itemToolTip
  if tab >= 1 then
    targetControl = self._ui.stc_speedToolTip
  end
  local pos = {
    x = targetControl:GetParentPosX() + targetControl:GetSizeX(),
    y = Panel_Window_SnowBoard_Menu_All:GetPosY() + 60
  }
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_TOOLTIP_RECORD_TITLE")
  local text = PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_TOOLTIP_RECORD_DESC")
  TooltipSimple_ShowSetSetPos_Console(pos, title, text)
end
function PaGlobalFunc_SnowBoardMenu_KeyGuide(fromControl, targetControl)
  local self = PaGlobal_SnowBoardMenu
  if self == nil or Panel_Window_SnowBoard_Menu_All:GetShow() == false then
    return
  end
  if targetControl ~= nil and targetControl:GetID() == "Static_MyRankingGroup" then
    if self._currentTabIndex == 0 then
      ToClient_ExecuteHandleEventByControl(self._ui.stc_itemMyRankBg, "Mouse_On")
    else
      ToClient_ExecuteHandleEventByControl(self._ui.stc_myRankBg, "Mouse_On")
    end
  end
end
