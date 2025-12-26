function PaGlobal_SnowBoardMenu:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  local titleBg = UI.getChildControl(Panel_Window_SnowBoard_Menu_All, "Static_TitleBg")
  self._ui.btn_close = UI.getChildControl(titleBg, "Button_Close")
  self._ui.stc_tabBg = UI.getChildControl(Panel_Window_SnowBoard_Menu_All, "Static_RadioButtonBg")
  self._ui.rdo_tabTemplate = UI.getChildControl(self._ui.stc_tabBg, "RadioButton_Template")
  self._ui.stc_tabSelectLine = UI.getChildControl(self._ui.stc_tabBg, "Static_SelectLine")
  self:initialize_Tab()
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_SnowBoard_Menu_All, "Static_MainBg")
  self._ui.stc_tabImageGroup = UI.getChildControl(self._ui.stc_mainBg, "Static_BannerImgGroup")
  self._ui.stc_tabImage = UI.getChildControl(self._ui.stc_tabImageGroup, "Static_Banner1")
  self._ui.stc_itemModeNewBg = UI.getChildControl(self._ui.stc_mainBg, "Static_ItemGroup")
  self._ui.lst_itemRank = UI.getChildControl(self._ui.stc_itemModeNewBg, "List2_ItemRankingListGroup")
  self._ui.stc_itemEmptyList = UI.getChildControl(self._ui.lst_itemRank, "StaticText_EmptyList")
  self._ui.stc_itemMyRankBg = UI.getChildControl(self._ui.stc_itemModeNewBg, "Static_MyRankingGroup")
  self._ui.stc_itemToolTip = UI.getChildControl(self._ui.stc_itemMyRankBg, "Static_WarningIcon_Tooltip")
  self._ui.stc_speedModeBg = UI.getChildControl(self._ui.stc_mainBg, "Static_RankingGroup")
  local titleList = UI.getChildControl(self._ui.stc_speedModeBg, "Static_ColumnNameGroup")
  self._ui.stc_challengeTitle = UI.getChildControl(titleList, "StaticText_Challenge")
  self._ui.stc_challengeTitle:SetShow(_ContentsGroup_SnowBoardRaceEventGhostReplay)
  if _ContentsGroup_SnowBoardRaceEventGhostReplay == false then
    local timeTItle = UI.getChildControl(titleList, "StaticText_Time")
    timeTItle:SetSpanSize(self._ui.stc_challengeTitle:GetSpanSize().x, timeTItle:GetSpanSize().y)
    timeTItle:ComputePos()
    local nameTitle = UI.getChildControl(titleList, "StaticText_Name")
    nameTitle:SetSpanSize(0, nameTitle:GetSpanSize().y)
    nameTitle:ComputePos()
  end
  self._ui.lst_rank = UI.getChildControl(self._ui.stc_speedModeBg, "List2_RankingListGroup")
  self._ui.stc_emptyList = UI.getChildControl(self._ui.lst_rank, "StaticText_EmptyList")
  self._ui.stc_myRankBg = UI.getChildControl(self._ui.stc_speedModeBg, "Static_MyRankingGroup")
  self._ui.stc_speedToolTip = UI.getChildControl(self._ui.stc_myRankBg, "Static_WarningIcon_Tooltip")
  self._ui.stc_buttonBg = UI.getChildControl(self._ui.stc_mainBg, "Static_ButtonBg")
  self._ui.btn_gameStart = UI.getChildControl(self._ui.stc_buttonBg, "Button_GameStart")
  self._ui.btn_eventOver = UI.getChildControl(self._ui.stc_buttonBg, "StaticText_EventOver")
  self._ui.btn_showInfo = UI.getChildControl(self._ui.stc_tabImageGroup, "Button_InfoOpen")
  self._ui.stc_Info = UI.getChildControl(Panel_Window_SnowBoard_Menu_All, "Static_Info")
  self._ui.stc_frameDesc = UI.getChildControl(self._ui.stc_Info, "Frame_Description")
  self._ui.stc_frameContents = UI.getChildControl(self._ui.stc_frameDesc, "Frame_1_Content")
  for index = 0, self._frameContentsCount - 1 do
    local radioButton = UI.getChildControl(self._ui.stc_frameContents, "RadioButton_" .. index)
    local descBG = UI.getChildControl(self._ui.stc_frameContents, "Static_BG_" .. index)
    local table = {
      _radioButton = radioButton,
      _bg = descBG,
      _title = UI.getChildControl(radioButton, "StaticText_" .. index),
      _desc = UI.getChildControl(descBG, "StaticText_Desc_" .. index)
    }
    self._frame[index] = table
    self._frame[index]._radioButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_SnowBoardMenu_DescriptionCheck(" .. index .. ")")
  end
  self._frame[0]._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_TITLE_COMMON"))
  self._frame[0]._desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_DESC_COMMON"))
  if self._isConsole == true then
    self._frame[0]._desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_DESC_COMMON_CONSOLE"))
  end
  self._frame[1]._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_TITLE_SCORE"))
  self._frame[1]._desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_DESC_SCORE"))
  self._frame[2]._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_TITLE_JUMP"))
  self._frame[2]._desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_DESC_JUMP"))
  self._frame[3]._title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_TITLE_SPEED"))
  self._frame[3]._desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SNOWBOARD_INFO_DESC_SPEED"))
  for index = 0, self._frameContentsCount - 1 do
    self._frame[index]._desc:SetSize(self._frame[index]._desc:GetSizeX(), self._frame[index]._desc:GetTextSizeY())
  end
  self._ui.btn_dev_updateRank = UI.getChildControl(self._ui.stc_buttonBg, "Button_Development_UpdateRank")
  self._ui.btn_dev_updateRank:SetShow(ToClient_IsDevelopment() == true)
  self._uiConsole.stc_tabLB = UI.getChildControl(self._ui.stc_tabBg, "Static_LB_ConsoleUI")
  self._uiConsole.stc_tabRB = UI.getChildControl(self._ui.stc_tabBg, "Static_RB_ConsoleUI")
  self._uiConsole.stc_keyGuideBG = UI.getChildControl(Panel_Window_SnowBoard_Menu_All, "Static_ConsoleKeyGuideBG")
  self._uiConsole.stc_key_Y = UI.getChildControl(self._uiConsole.stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._uiConsole.stc_key_X = UI.getChildControl(self._uiConsole.stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._uiConsole.stc_key_A = UI.getChildControl(self._uiConsole.stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._uiConsole.stc_key_B = UI.getChildControl(self._uiConsole.stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._uiConsole.stc_key_LTX = UI.getChildControl(self._uiConsole.stc_keyGuideBG, "StaticText_LTX_ConsoleUI")
  self._uiConsole.stc_key_LTY = UI.getChildControl(self._uiConsole.stc_keyGuideBG, "StaticText_LTY_ConsoleUI")
  if self._isConsole == true then
    self._ui.btn_close:SetShow(false)
    self._uiConsole.stc_tabLB:SetShow(true)
    self._uiConsole.stc_tabRB:SetShow(true)
    self._uiConsole.stc_keyGuideBG:SetShow(true)
    self._uiConsole.stc_key_A:SetShow(false)
    local keyGuides = {
      self._uiConsole.stc_key_LTX,
      self._uiConsole.stc_key_LTY,
      self._uiConsole.stc_key_Y,
      self._uiConsole.stc_key_X,
      self._uiConsole.stc_key_A,
      self._uiConsole.stc_key_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._uiConsole.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, 50, nil)
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_SnowBoardMenu:initialize_Tab()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  self._tabs = {}
  local tabCount = ToClient_SnowBoardCourseCount()
  local tabSizeX = self._ui.rdo_tabTemplate:GetSizeX()
  local tabTermX = 10
  local tabSumX = tabSizeX * tabCount + tabTermX * (tabCount - 1)
  local spanX = (self._ui.stc_tabBg:GetSizeX() - tabSumX) / 2
  for ii = 0, tabCount - 1 do
    local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByIndex(ii)
    if snowBoardStatic ~= nil then
      local tabData = {
        _keyRaw = nil,
        _mode = nil,
        _control = nil
      }
      tabData._keyRaw = snowBoardStatic:getKeyRaw()
      tabData._mode = snowBoardStatic:getMode()
      tabData._control = UI.cloneControl(self._ui.rdo_tabTemplate, self._ui.stc_tabBg, "RadioButton_Mode_" .. ii)
      UI.ASSERT_NAME(tabData._control ~= nil, "\236\138\164\235\133\184\236\154\176\235\179\180\235\147\156 \235\169\148\235\137\180 \237\131\173 \236\187\168\237\138\184\235\161\164 \235\179\181\236\160\156 \236\139\164\237\140\168!", "\236\157\180\236\163\188")
      tabData._control:SetShow(true)
      tabData._control:SetText(snowBoardStatic:getName())
      tabData._control:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_SelectTab(" .. ii .. ")")
      tabData._control:SetHorizonLeft()
      tabData._control:SetVerticalMiddle()
      tabData._control:SetSpanSize(spanX, tabData._control:GetSpanSize().y)
      tabData._control:ComputePos()
      spanX = spanX + tabSizeX + tabTermX
      self._tabs[ii] = tabData
    end
  end
end
function PaGlobal_SnowBoardMenu:registEventHandler()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_SnowBoard_Menu_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_SnowBoardMenu_TabPad(-1)")
    Panel_Window_SnowBoard_Menu_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_SnowBoardMenu_TabPad(1)")
    Panel_Window_SnowBoard_Menu_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SnowBoardMenu_ShowDescInfo()")
    Panel_Window_SnowBoard_Menu_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_SnowBoardMenu_GameStart()")
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SnowBoardMenu_Close()")
  self._ui.btn_gameStart:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_GameStart()")
  self._ui.btn_showInfo:addInputEvent("Mouse_LUp", "PaGlobalFunc_SnowBoardMenu_ShowDescInfo()")
  if ToClient_IsDevelopment() == true then
    self._ui.btn_dev_updateRank:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_UpdateRankForDev()")
  end
  self._ui.lst_itemRank:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SnowBoardMenu_OnCreateItemRankContent")
  self._ui.lst_itemRank:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.lst_rank:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SnowBoardMenu_OnCreateRankContent")
  self._ui.lst_rank:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.stc_itemToolTip:addInputEvent("Mouse_On", "PaGlobalFunc_SnowBoardMenu_RecordWarning_ToolTip(0,1)")
  self._ui.stc_itemToolTip:addInputEvent("Mouse_Out", "PaGlobalFunc_SnowBoardMenu_RecordWarning_ToolTip(0,0)")
  self._ui.stc_speedToolTip:addInputEvent("Mouse_On", "PaGlobalFunc_SnowBoardMenu_RecordWarning_ToolTip(1,1)")
  self._ui.stc_speedToolTip:addInputEvent("Mouse_Out", "PaGlobalFunc_SnowBoardMenu_RecordWarning_ToolTip(1,0)")
  registerEvent("FromClient_EnterSnowBoardField", "FromClient_SnowBoardMenu_OnEnterField")
  registerEvent("FromClient_UpdateSnowBoardTotalRankerList", "FromClient_SnowBoardMenu_UpdateRank")
  registerEvent("FromClient_OnDownloadFromWeb", "FromClient_SnowBoardMenu_DownloadComplete")
  registerEvent("FromClient_PlaySnowBoardReplay", "FromClient_SnowBoardMenu_PlayReplay")
  registerEvent("FromClient_PadSnapChangeTarget", "PaGlobalFunc_SnowBoardMenu_KeyGuide")
end
function PaGlobal_SnowBoardMenu:prepareOpen()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  ToClient_RequestSnowBoardRankList()
  if self._currentTabIndex == nil then
    self._currentTabIndex = 0
  end
  self._ui.stc_Info:SetShow(false)
  self:selectTab(self._currentTabIndex)
  self._ui.btn_gameStart:SetShow(_ContentsGroup_SnowBoardMirrorEnter)
  self._ui.btn_eventOver:SetShow(_ContentsGroup_SnowBoardMirrorEnter == false)
  self:open()
end
function PaGlobal_SnowBoardMenu:open()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  Panel_Window_SnowBoard_Menu_All:SetShow(true)
end
function PaGlobal_SnowBoardMenu:prepareClose()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  TooltipSimple_Hide()
  Panel_Window_SnowBoard_Menu_All:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_SnowBoardMenu:close()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  Panel_Window_SnowBoard_Menu_All:SetShow(false)
end
function PaGlobal_SnowBoardMenu:selectTab(index)
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  ToClient_padSnapResetControl()
  local tabData = self._tabs[index]
  if tabData == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(tabData._keyRaw)
  if snowBoardStatic == nil then
    return
  end
  for k, v in pairs(self._tabs) do
    if v ~= nil and v._control ~= nil then
      v._control:SetCheck(v._keyRaw == tabData._keyRaw)
    end
  end
  self._ui.stc_tabSelectLine:SetSpanSize(tabData._control:GetSpanSize().x + (tabData._control:GetSizeX() - self._ui.stc_tabSelectLine:GetSizeX()) / 2, self._ui.stc_tabSelectLine:GetSpanSize().y)
  self._ui.stc_tabSelectLine:ComputePos()
  self._currentTabIndex = index
  local currentTabMode = snowBoardStatic:getMode()
  if currentTabMode == __eSnowBoardCourseMode_Item then
    self._ui.stc_tabImage:ChangeTextureInfoTextureIDAsync(self._titleTexture[1])
    self._ui.stc_tabImage:setRenderTexture(self._ui.stc_tabImage:getBaseTexture())
    self:showItemModeGroup()
    self:updateItemRankList()
    self:updateItemRankContent(true, self._ui.stc_itemMyRankBg, nil)
  elseif currentTabMode == __eSnowBoardCourseMode_Speed then
    local texture = self._titleTexture[2]
    if tabData._keyRaw == 3 then
      texture = self._titleTexture[3]
    end
    self._ui.stc_tabImage:ChangeTextureInfoTextureIDAsync(texture)
    self._ui.stc_tabImage:setRenderTexture(self._ui.stc_tabImage:getBaseTexture())
    self:showSpeedModeGroup()
    self:updateRankList()
    self:updateRankContent(true, self._ui.stc_myRankBg, nil)
  end
end
function PaGlobal_SnowBoardMenu:showSpeedModeGroup()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  self._ui.stc_itemModeNewBg:SetShow(false)
  self._ui.stc_speedModeBg:SetShow(true)
end
function PaGlobal_SnowBoardMenu:showItemModeGroup()
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  self._ui.stc_itemModeNewBg:SetShow(true)
  self._ui.stc_speedModeBg:SetShow(false)
end
function PaGlobal_SnowBoardMenu:updateRankList()
  if Panel_Window_SnowBoard_Menu_All == nil then
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
  local listManager = self._ui.lst_rank:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local rankDataCount = ToClient_GetSnowBoardRankerDataCount(tabData._keyRaw)
  if rankDataCount <= 0 then
    self._ui.stc_emptyList:SetShow(true)
  else
    self._ui.stc_emptyList:SetShow(false)
    for index = 0, rankDataCount - 1 do
      listManager:pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_SnowBoardMenu:updateRankContent(isSelfRecord, content, key)
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
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
  local courseKeyRaw = tabData._keyRaw
  local currentMode = snowBoardStatic:getMode()
  local txt_rank = UI.getChildControl(content, "StaticText_Rank")
  local txt_userNickname = UI.getChildControl(content, "StaticText_Name")
  local txt_lapTime = UI.getChildControl(content, "StaticText_LapTime")
  local btn_challenge = UI.getChildControl(content, "Button_Challenge")
  local btn_playReplay = UI.getChildControl(content, "Button_PlayReplay")
  local btn_downloadSmall = UI.getChildControl(content, "Button_DownView")
  local btn_downloadBig = UI.getChildControl(content, "Button_Download")
  if isSelfRecord == true then
    local recordWarningText = UI.getChildControl(content, "StaticText_Warning")
    local recordWarningIcon = UI.getChildControl(content, "Static_WarningIcon_Tooltip")
    local rankNumber = ToClient_GetMySnowBoardBestRank(courseKeyRaw)
    local rankString = tostring(rankNumber)
    if rankNumber == -1 then
      rankString = tostring(ToClient_GetSnowBoardRankMax()) .. "+"
    elseif rankNumber == 0 then
      rankString = PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_RANKING_NORANK")
    end
    txt_rank:SetText(rankString)
    txt_userNickname:SetText(selfPlayer:getUserNickname())
    local recordTick = Int64toInt32(ToClient_GetMySnowBoardBestRecordTick(courseKeyRaw))
    local recordMinute = math.min(99, math.floor(recordTick / 60000))
    local recordSecond = math.floor(recordTick % 60000 / 1000)
    local recordMillis = math.floor(recordTick % 1000)
    local recordText = string.format("%02d:%02d:%03d", recordMinute, recordSecond, recordMillis)
    txt_lapTime:SetText(recordText)
    btn_challenge:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_StartGameWithGhost(true, " .. tostring(courseKeyRaw) .. ", -1)")
    btn_playReplay:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_StartReplay(true, " .. tostring(courseKeyRaw) .. ", -1)")
    btn_downloadBig:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_DownloadReplay(true, " .. tostring(courseKeyRaw) .. ", -1)")
    btn_downloadBig:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_DownloadReplay(true, " .. tostring(courseKeyRaw) .. ", -1)")
    local uniqueNo = ToClient_GetMySnowBoardBestRecordUniqueNo(courseKeyRaw)
    local isExistGhostReplayFile = ToClient_IsExistSnowBoardReplayFile(uniqueNo)
    btn_challenge:SetShow(isExistGhostReplayFile == true)
    btn_playReplay:SetShow(isExistGhostReplayFile == true)
    btn_downloadBig:SetShow(isExistGhostReplayFile == false)
    btn_downloadSmall:SetShow(isExistGhostReplayFile == false)
    local possibleRecord = ToClient_GetPossibleSnowBoardRecord()
    local possibleReplay = false
    if possibleRecord == false then
      possibleReplay = false
      btn_challenge:SetShow(false)
      btn_playReplay:SetShow(false)
      btn_downloadSmall:SetShow(false)
      btn_downloadBig:SetShow(false)
      txt_userNickname:SetShow(false)
      txt_lapTime:SetShow(false)
      txt_rank:SetShow(false)
      recordWarningText:SetShow(true)
      recordWarningIcon:SetShow(true)
      recordWarningText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_SNOWBOARD_EVENT_WARNING"))
    end
    if possibleRecord == true and recordTick <= 0 then
      possibleReplay = false
      recordWarningText:SetShow(true)
      recordWarningText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NORECORD"))
      recordWarningIcon:SetShow(false)
      txt_userNickname:SetShow(false)
      txt_lapTime:SetShow(false)
      txt_rank:SetShow(false)
      btn_challenge:SetShow(false)
      btn_playReplay:SetShow(false)
      btn_downloadSmall:SetShow(false)
      btn_downloadBig:SetShow(false)
    elseif possibleRecord == true and recordTick > 0 then
      possibleReplay = true
      recordWarningText:SetShow(false)
      recordWarningIcon:SetShow(false)
      txt_userNickname:SetShow(true)
      txt_lapTime:SetShow(true)
      txt_rank:SetShow(true)
    end
    if _ContentsGroup_SnowBoardRaceEventGhostReplay == false then
      possibleReplay = false
    end
    if self._isConsole == true then
      if possibleReplay == true then
        if isExistGhostReplayFile == false then
          content:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_SnowBoardMenu_DownloadReplay(true, " .. tostring(courseKeyRaw) .. ", -1)")
          content:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_SnowBoardMenu_DownloadReplay(true, " .. tostring(courseKeyRaw) .. ", -1)")
        else
          content:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_SnowBoardMenu_StartGameWithGhost(true, " .. tostring(courseKeyRaw) .. ", -1)")
          content:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_SnowBoardMenu_StartReplay(true, " .. tostring(courseKeyRaw) .. ", -1)")
        end
      end
      content:addInputEvent("Mouse_On", "PaGlobal_SnowBoardMenu:alignKeyGuide(" .. tostring(possibleReplay) .. "," .. tostring(isExistGhostReplayFile == false) .. ")")
      content:addInputEvent("Mouse_Out", "PaGlobal_SnowBoardMenu:alignKeyGuide(false,false)")
    end
  else
    local txt_rankIcon = UI.getChildControl(content, "Static_RankIcon")
    local txt_rankCountIcon = UI.getChildControl(txt_rankIcon, "Static_RankCount")
    local rankIndex = Int64toInt32(key)
    local rankNumber = ToClient_GetSnowBoardRankerRank(courseKeyRaw, rankIndex)
    txt_rank:SetText(tostring(rankNumber))
    local rankIconTexture = self._rankTextureBG[3]
    local rankTextIconTexture = self._rankTexture[3]
    if rankNumber == 1 or rankNumber == 2 then
      rankIconTexture = self._rankTextureBG[rankNumber]
      rankTextIconTexture = self._rankTexture[rankNumber]
    end
    txt_rankIcon:ChangeTextureInfoTextureIDAsync(rankIconTexture)
    txt_rankIcon:setRenderTexture(txt_rankIcon:getBaseTexture())
    txt_rankCountIcon:ChangeTextureInfoTextureIDAsync(rankTextIconTexture)
    txt_rankCountIcon:setRenderTexture(txt_rankCountIcon:getBaseTexture())
    if rankNumber <= 3 then
      txt_rankIcon:SetShow(true)
    else
      txt_rankIcon:SetShow(false)
    end
    txt_userNickname:SetText(ToClient_GetSnowBoardRankerNickname(courseKeyRaw, rankIndex))
    local recordTick = Int64toInt32(ToClient_GetSnowBoardRankerRecordTick(courseKeyRaw, rankIndex))
    local recordMinute = math.min(99, math.floor(recordTick / 60000))
    local recordSecond = math.floor(recordTick % 60000 / 1000)
    local recordMillis = math.floor(recordTick % 1000)
    local recordText = string.format("%02d:%02d:%03d", recordMinute, recordSecond, recordMillis)
    txt_lapTime:SetText(recordText)
    btn_challenge:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_StartGameWithGhost(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
    btn_playReplay:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_StartReplay(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
    btn_downloadBig:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_DownloadReplay(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
    btn_downloadSmall:addInputEvent("Mouse_LUp", "HandleEventLUp_SnowBoardMenu_DownloadReplay(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
    local uniqueNo = ToClient_GetSnowBoardRankerRecordUniqueNo(courseKeyRaw, rankIndex)
    local isExistGhostReplayFile = ToClient_IsExistSnowBoardReplayFile(uniqueNo)
    btn_challenge:SetShow(isExistGhostReplayFile == true)
    btn_playReplay:SetShow(isExistGhostReplayFile == true)
    btn_downloadBig:SetShow(isExistGhostReplayFile == false)
    btn_downloadSmall:SetShow(isExistGhostReplayFile == false)
    local possibleReplay = _ContentsGroup_SnowBoardRaceEventGhostReplay == true
    if self._isConsole == true then
      if _ContentsGroup_SnowBoardRaceEventGhostReplay == true then
        if isExistGhostReplayFile == false then
          content:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_SnowBoardMenu_DownloadReplay(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
          content:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_SnowBoardMenu_DownloadReplay(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
        else
          content:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_SnowBoardMenu_StartGameWithGhost(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
          content:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_SnowBoardMenu_StartReplay(false, " .. tostring(courseKeyRaw) .. "," .. tostring(rankIndex) .. ")")
        end
      end
      content:addInputEvent("Mouse_On", "PaGlobal_SnowBoardMenu:alignKeyGuide(" .. tostring(possibleReplay) .. "," .. tostring(isExistGhostReplayFile == false) .. ")")
      content:addInputEvent("Mouse_Out", "PaGlobal_SnowBoardMenu:alignKeyGuide(false,false)")
    end
  end
  if _ContentsGroup_SnowBoardMirrorEnter == false then
    btn_challenge:SetIgnore(true)
    btn_playReplay:SetIgnore(true)
    btn_downloadBig:SetIgnore(true)
    btn_downloadSmall:SetIgnore(true)
    btn_challenge:SetMonoTone(true)
    btn_playReplay:SetMonoTone(true)
    btn_downloadBig:SetMonoTone(true)
    btn_downloadSmall:SetMonoTone(true)
  else
    btn_challenge:SetIgnore(false)
    btn_playReplay:SetIgnore(false)
    btn_downloadBig:SetIgnore(false)
    btn_downloadSmall:SetIgnore(false)
    btn_challenge:SetMonoTone(false)
    btn_playReplay:SetMonoTone(false)
    btn_downloadBig:SetMonoTone(false)
    btn_downloadSmall:SetMonoTone(false)
  end
  if _ContentsGroup_SnowBoardRaceEventGhostReplay == false then
    btn_challenge:SetShow(false)
    btn_playReplay:SetShow(false)
    btn_downloadSmall:SetShow(false)
    btn_downloadBig:SetShow(false)
    txt_lapTime:SetSpanSize(self._ui.stc_challengeTitle:GetSpanSize().x, txt_lapTime:GetSpanSize().y)
    txt_lapTime:ComputePos()
    txt_userNickname:SetSpanSize(0, txt_userNickname:GetSpanSize().y)
    txt_userNickname:ComputePos()
  end
end
function PaGlobal_SnowBoardMenu:updateItemRankList()
  if Panel_Window_SnowBoard_Menu_All == nil then
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
  local listManager = self._ui.lst_itemRank:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  local rankDataCount = ToClient_GetSnowBoardRankerDataCount(tabData._keyRaw)
  if rankDataCount <= 0 then
    self._ui.stc_itemEmptyList:SetShow(true)
  else
    self._ui.stc_itemEmptyList:SetShow(false)
    for index = 0, rankDataCount - 1 do
      listManager:pushKey(toInt64(0, index))
    end
  end
end
function PaGlobal_SnowBoardMenu:updateItemRankContent(isSelfRecord, content, key)
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
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
  local courseKeyRaw = tabData._keyRaw
  local currentMode = snowBoardStatic:getMode()
  local txt_rank = UI.getChildControl(content, "StaticText_Rank")
  local txt_userNickname = UI.getChildControl(content, "StaticText_Name")
  local txt_ItemCount = UI.getChildControl(content, "StaticText_ItemCount")
  local txt_lapTime = UI.getChildControl(content, "StaticText_LapTime")
  if isSelfRecord == true then
    local recordWarningText = UI.getChildControl(content, "StaticText_Warning")
    local recordWarningIcon = UI.getChildControl(content, "Static_WarningIcon_Tooltip")
    local rankNumber = ToClient_GetMySnowBoardBestRank(courseKeyRaw)
    local rankString = tostring(rankNumber)
    if rankNumber == -1 then
      rankString = tostring(ToClient_GetSnowBoardRankMax()) .. "+"
    elseif rankNumber == 0 then
      rankString = PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_RANKING_NORANK")
    end
    txt_rank:SetText(rankString)
    txt_ItemCount:SetText(ToClient_GetMySnowBoardBestRecordItem(courseKeyRaw))
    txt_userNickname:SetText(selfPlayer:getUserNickname())
    local recordTick = Int64toInt32(ToClient_GetMySnowBoardBestRecordTick(courseKeyRaw))
    local recordMinute = math.min(99, math.floor(recordTick / 60000))
    local recordSecond = math.floor(recordTick % 60000 / 1000)
    local recordMillis = math.floor(recordTick % 1000)
    local recordText = string.format("%02d:%02d:%03d", recordMinute, recordSecond, recordMillis)
    txt_lapTime:SetText(recordText)
    local possibleRecord = ToClient_GetPossibleSnowBoardRecord()
    local possibleReplay = false
    if possibleRecord == false then
      possibleReplay = false
      txt_rank:SetShow(false)
      txt_userNickname:SetShow(false)
      txt_ItemCount:SetShow(false)
      txt_lapTime:SetShow(false)
      recordWarningText:SetShow(true)
      recordWarningIcon:SetShow(true)
      recordWarningText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_SNOWBOARD_EVENT_WARNING"))
    end
    if possibleRecord == true and recordTick <= 0 then
      possibleReplay = false
      recordWarningText:SetShow(true)
      recordWarningText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NORECORD"))
      recordWarningIcon:SetShow(false)
      txt_userNickname:SetShow(false)
      txt_lapTime:SetShow(false)
      txt_rank:SetShow(false)
      txt_ItemCount:SetShow(false)
    elseif possibleRecord == true and recordTick > 0 then
      possibleReplay = true
      recordWarningText:SetShow(false)
      recordWarningIcon:SetShow(false)
      txt_userNickname:SetShow(true)
      txt_lapTime:SetShow(true)
      txt_rank:SetShow(true)
      txt_ItemCount:SetShow(true)
    end
    if _ContentsGroup_SnowBoardRaceEventGhostReplay == false then
      possibleReplay = false
    end
  else
    local txt_rankIcon = UI.getChildControl(content, "Static_RankIcon")
    local txt_rankCountIcon = UI.getChildControl(txt_rankIcon, "Static_RankCount")
    local rankIndex = Int64toInt32(key)
    local rankNumber = ToClient_GetSnowBoardRankerRank(courseKeyRaw, rankIndex)
    txt_rank:SetText(tostring(rankNumber))
    local rankIconTexture = self._rankTextureBG[3]
    local rankTextIconTexture = self._rankTexture[3]
    if rankNumber == 1 or rankNumber == 2 then
      rankIconTexture = self._rankTextureBG[rankNumber]
      rankTextIconTexture = self._rankTexture[rankNumber]
    end
    txt_rankIcon:ChangeTextureInfoTextureIDAsync(rankIconTexture)
    txt_rankIcon:setRenderTexture(txt_rankIcon:getBaseTexture())
    txt_rankCountIcon:ChangeTextureInfoTextureIDAsync(rankTextIconTexture)
    txt_rankCountIcon:setRenderTexture(txt_rankCountIcon:getBaseTexture())
    if rankNumber <= 3 then
      txt_rankIcon:SetShow(true)
    else
      txt_rankIcon:SetShow(false)
    end
    txt_userNickname:SetText(ToClient_GetSnowBoardRankerNickname(courseKeyRaw, rankIndex))
    local recordTick = Int64toInt32(ToClient_GetSnowBoardRankerRecordTick(courseKeyRaw, rankIndex))
    local recordMinute = math.min(99, math.floor(recordTick / 60000))
    local recordSecond = math.floor(recordTick % 60000 / 1000)
    local recordMillis = math.floor(recordTick % 1000)
    local recordText = string.format("%02d:%02d:%03d", recordMinute, recordSecond, recordMillis)
    txt_lapTime:SetText(recordText)
    txt_ItemCount:SetText(ToClient_GetSnowBoardRankerRecordItem(courseKeyRaw, rankIndex))
  end
  if self._isConsole == true then
    content:addInputEvent("Mouse_On", "PaGlobal_SnowBoardMenu:alignKeyGuide(false,false)")
    content:addInputEvent("Mouse_Out", "PaGlobal_SnowBoardMenu:alignKeyGuide(false,false)")
  end
end
function PaGlobal_SnowBoardMenu:alignKeyGuide(showDown, needDown)
  if Panel_Window_SnowBoard_Menu_All == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  self._uiConsole.stc_key_LTY:SetShow(showDown)
  self._uiConsole.stc_key_X:SetShow(showDown)
  if needDown == true then
    self._uiConsole.stc_key_LTY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_SNOWBOARD_MENU_DOWNLOAD"))
  else
    self._uiConsole.stc_key_LTY:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MENU_SNOWBOARD_MENU_CHALLENGE"))
  end
  local keyGuides = {
    self._uiConsole.stc_key_LTX,
    self._uiConsole.stc_key_LTY,
    self._uiConsole.stc_key_Y,
    self._uiConsole.stc_key_X,
    self._uiConsole.stc_key_A,
    self._uiConsole.stc_key_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._uiConsole.stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, 50, nil)
end
