function PaGlobal_CharacterSelect_All:initialize()
  if true == PaGlobal_CharacterSelect_All._initialize or nil == Panel_CharacterSelect_All then
    return
  end
  self._ui.stc_BackGroundBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_GradationBG")
  self._ui.stc_RightBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_RightBg")
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_RightBg, "StaticText_CharacterSelect")
  self._ui.txt_CharacterCount = UI.getChildControl(self._ui.stc_RightBg, "StaticText_CharacterCount")
  self._ui.stc_CharacterCountGuide = UI.getChildControl(self._ui.stc_RightBg, "Static_CharacterCountGuide")
  self._ui.rdo_Normal = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_Normal")
  self._ui.rdo_Special = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_Special")
  self._ui.rdo_HardCore = UI.getChildControl(self._ui.stc_RightBg, "RadioButton_HardCore")
  self._ui.stc_KeyGuide_LB = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeTab_LB_ConsoleUI")
  self._ui.stc_KeyGuide_RB = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeTab_RB_ConsoleUI")
  self._ui.btn_Delete = UI.getChildControl(self._ui.stc_RightBg, "Button_DeleteCharacter")
  self._ui.btn_ChangePosition = UI.getChildControl(self._ui.stc_RightBg, "Checkbox_CharacterPosChange")
  self._ui.btn_CreateCharacter = UI.getChildControl(self._ui.stc_RightBg, "Button_Double_CreateCharacter")
  self._ui.btn_CreateCharacterText = UI.getChildControl(self._ui.btn_CreateCharacter, "StaticText_Text")
  self._ui.btn_CreateFreeSeasonCharacter = UI.getChildControl(self._ui.stc_RightBg, "Button_Double_CreateFreeSeasonCharacter")
  self._ui.btn_BackToServer = UI.getChildControl(self._ui.stc_RightBg, "Button_ExitToServerSelect")
  self._ui.chk_Ghost = UI.getChildControl(self._ui.stc_RightBg, "CheckButton_Offline")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_RightBg, "Static_SelectLine")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_RightBg, "StaticText_Select_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_RightBg, "StaticText_Exit_ConsoleUI")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_RightBg, "StaticText_Delete_ConsoleUI")
  self._ui.stc_KeyGuide_LBRB = UI.getChildControl(self._ui.stc_RightBg, "StaticText_ChangeSlotLocation_RB_ConsoleUI")
  self._ui.stc_LeftTimeBg = UI.getChildControl(self._ui.stc_RightBg, "Static_LeftTimeBg")
  self._ui.stc_LeftTime = UI.getChildControl(self._ui.stc_LeftTimeBg, "StaticText_LeftTime")
  self._ui.stc_StartTime = UI.getChildControl(self._ui.stc_LeftTimeBg, "StaticText_StartTime")
  self._ui.stc_ReloadTime = UI.getChildControl(self._ui.stc_LeftTimeBg, "StaticText_ReloadTime")
  self._ui.txt_FamilyName = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_FamilyName")
  self._ui.txt_CharacterName = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_CharacterName")
  self._ui.txt_CharacterStatus = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_Ticket")
  self._ui.list2_Character = UI.getChildControl(Panel_CharacterSelect_All, "List2_CharacterListBG")
  self._ui.stc_RightClick = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_MouseRightClick")
  self._ui.stc_MouseWheel = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_MouseWheel")
  self._ui.stc_Fade = UI.getChildControl(Panel_CharacterSelect_All, "Static_Fade")
  self._ui.txt_version = UI.getChildControl(Panel_CharacterSelect_All, "StaticText_VersionString")
  self._ui.stc_PrimiumBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_Premium")
  self._ui.txt_PrimiumTitle = UI.getChildControl(self._ui.stc_PrimiumBg, "StaticText_Title")
  self._ui.txt_PrimiumDesc = UI.getChildControl(self._ui.stc_PrimiumBg, "StaticText_Desc")
  self._ui.stc_SeasonBg = UI.getChildControl(Panel_CharacterSelect_All, "Static_Season")
  self._ui.txt_SeasonTitle = UI.getChildControl(self._ui.stc_SeasonBg, "StaticText_Title")
  self._ui.txt_SeasonDesc = UI.getChildControl(self._ui.stc_SeasonBg, "StaticText_Desc")
  self._ui.btn_GamePlay = UI.getChildControl(self._ui.stc_RightBg, "Button_Go_Play_BlackDesert")
  self._ui.stc_PrimiumBg:SetShow(false)
  if self._ui.txt_PrimiumDesc:GetTextSizeX() >= self._ui.txt_PrimiumDesc:GetSizeX() then
    local gap = self._ui.txt_PrimiumDesc:GetSizeY()
    self._ui.txt_PrimiumDesc:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_PrimiumDesc:SetText(self._ui.txt_PrimiumDesc:GetText())
    self._ui.txt_PrimiumDesc:SetSize(self._ui.txt_PrimiumDesc:GetSizeX(), self._ui.txt_PrimiumDesc:GetTextSizeY() + 5)
    gap = math.abs(self._ui.txt_PrimiumDesc:GetSizeY() - gap)
    self._ui.stc_PrimiumBg:SetSize(self._ui.stc_PrimiumBg:GetSizeX(), self._ui.stc_PrimiumBg:GetSizeY() + gap)
    self._ui.stc_PrimiumBg:ComputePos()
  end
  self._ui.stc_SeasonBg:SetShow(false)
  self._ui.txt_SeasonDesc:SetShow(false)
  if self._ui.txt_SeasonDesc:GetTextSizeX() >= self._ui.txt_SeasonDesc:GetSizeX() then
    local gap = self._ui.txt_SeasonDesc:GetSizeY()
    self._ui.txt_SeasonDesc:SetTextMode(__eTextMode_AutoWrap)
    if true == isGameServiceTypeConsole() then
      self._ui.txt_SeasonDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_SEASON_DESC_CONSOLE"))
    else
      self._ui.txt_SeasonDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_SEASON_DESC"))
    end
    self._ui.txt_SeasonDesc:SetSize(self._ui.txt_SeasonDesc:GetSizeX(), self._ui.txt_SeasonDesc:GetTextSizeY() + 10)
    gap = math.abs(self._ui.txt_SeasonDesc:GetSizeY() - gap)
    self._ui.stc_SeasonBg:SetSize(self._ui.stc_SeasonBg:GetSizeX(), self._ui.stc_SeasonBg:GetSizeY() + gap)
    self._ui.stc_SeasonBg:ComputePos()
  end
  local list2content = UI.getChildControl(self._ui.list2_Character, "List2_1_Content")
  local seaIcon = UI.getChildControl(list2content, "Static_ServantView_Sea")
  local name = UI.getChildControl(list2content, "StaticText_Name")
  self._ui.stc_Fade:SetShow(false)
  self._ui.chk_Ghost:SetShow(_ContentsGroup_GhostMode)
  self._ui.chk_Ghost:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENTERTOFIELDMODE_OFFLINE"))
  self._ui._originNameSpanX = name:GetSpanSize().x
  self._ui.btn_Delete:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_ChangePosition:SetTextMode(__eTextMode_AutoWrap)
  self._ui.btn_BackToServer:SetTextMode(__eTextMode_AutoWrap)
  self._list2OriginY = self._ui.list2_Character:GetSizeY()
  self._seaIconOriginX = seaIcon:GetSpanSize().x
  self._ui._rdoTables[self._TABTYPE._NORMAL] = self._ui.rdo_Normal
  if false == self._isPremiumCharacterOpen then
    self._ui._rdoTables[self._TABTYPE._NORMAL]:SetSpanSize(0, self._ui._rdoTables[self._TABTYPE._NORMAL]:GetSpanSize().y)
  else
    self._ui._rdoTables[self._TABTYPE._PREMIUM] = self._ui.rdo_Special
    self._ui._rdoTables[self._TABTYPE._NORMAL]:SetSpanSize(-100, self._ui._rdoTables[self._TABTYPE._NORMAL]:GetSpanSize().y)
    self._ui._rdoTables[self._TABTYPE._PREMIUM]:SetSpanSize(100, self._ui._rdoTables[self._TABTYPE._PREMIUM]:GetSpanSize().y)
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui._rdoTables[self._TABTYPE._HARDCORE] = self._ui.rdo_HardCore
    self._ui._rdoTables[self._TABTYPE._HARDCORE]:SetSpanSize(0, self._ui._rdoTables[self._TABTYPE._HARDCORE]:GetSpanSize().y)
    self._ui._rdoTables[self._TABTYPE._NORMAL]:SetShow(false)
    self._ui._rdoTables[self._TABTYPE._PREMIUM]:SetShow(false)
  end
  self._ui.rdo_Normal:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_NORMALCHARACTERSLOT"))
  self._ui.rdo_Special:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_PREMIUMCHARACTERSLOT"))
  self._ui.rdo_HardCore:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE"))
  self._ui.rdo_Normal:SetShow(ToClient_HardCoreChannelWithContensOption() == false)
  self._ui.rdo_Special:SetShow(self._isPremiumCharacterOpen and ToClient_HardCoreChannelWithContensOption() == false)
  self._ui.rdo_HardCore:SetShow(ToClient_HardCoreChannelWithContensOption())
  self._ui.stc_SelectLine:SetSpanSize(self._ui.rdo_Normal:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.stc_SelectLine:SetSpanSize(self._ui.rdo_HardCore:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
  end
  local list2Content = UI.getChildControl(self._ui.list2_Character, "List2_1_Content")
  self._listContentsCount = getCharacterSlotLimit(__ePlayerCreateNormal)
  for idx = 0, self._listContentsCount do
    self._listContentsLaunchTimeTable[idx] = (idx - 1) * 0.03
  end
  self._ui.stc_FreeSeasonArea = UI.getChildControl(self._ui.stc_RightBg, "Static_FreeSeason_CountArea")
  self._ui.stc_FreeSeasonCountBox = UI.getChildControl(self._ui.stc_FreeSeasonArea, "Static_Count_Box")
  self._ui.stc_FreeSeasonCountCircle[0] = UI.getChildControl(self._ui.stc_FreeSeasonCountBox, "Static_CircleBG_0")
  for idx = 1, self._MAX_CIRCLE_COUNT - 1 do
    local clonedCircleBg = UI.cloneControl(self._ui.stc_FreeSeasonCountCircle[0], self._ui.stc_FreeSeasonCountBox, "Static_CircleBG_" .. tostring(idx))
    clonedCircleBg:SetSpanSize(20 * idx, 0)
    self._ui.stc_FreeSeasonCountCircle[idx] = clonedCircleBg
  end
  local freeSeasonCharacterUsableCount = getUsableSeasonCharacterSlotCount()
  if freeSeasonCharacterUsableCount > 0 then
    for idx = 0, freeSeasonCharacterUsableCount - 1 do
      local light = UI.getChildControl(self._ui.stc_FreeSeasonCountCircle[self._MAX_CIRCLE_COUNT - idx - 1], "Static_Light")
      light:SetShow(true)
      if 0 < self._seasonCharacterCount and idx == 0 then
        light:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Etc_Server_Icon_SeasonCharacter_Check")
        light:setRenderTexture(light:getBaseTexture())
      end
    end
  end
  self._currentTab = self._TABTYPE._NORMAL
  self._ui._rdoTables[self._currentTab]:SetCheck(true)
  self._isConsole = isGameServiceTypeConsole()
  self._isUsePadSnapping = _ContentsGroup_UsePadSnapping
  PaGlobal_CharacterSelect_All:validate()
  PaGlobal_CharacterSelect_All:registEventHandler(self._isUsePadSnapping)
  PaGlobal_CharacterSelect_All:swichPlatform(self._isUsePadSnapping)
  self._firstSeasonOriPosX = self._ui.btn_CreateFreeSeasonCharacter:GetPosX()
  self._firstSeasonOriSizeX = self._ui.btn_CreateFreeSeasonCharacter:GetSizeX()
  self._firstSeasonPosX = self._ui.btn_CreateFreeSeasonCharacter:GetPosX() - self._ui.btn_CreateFreeSeasonCharacter:GetSizeX() - 10
  self._firstSeasonSizeX = self._ui.btn_CreateFreeSeasonCharacter:GetSizeX() * 2 + 10
  PaGlobal_CharacterSelect_All._initialize = true
end
function PaGlobal_CharacterSelect_All:registEventHandler(isUsePadSnapping)
  self._ui.list2_Character:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_CharacterSelect_All_List2Update")
  self._ui.list2_Character:createChildContent(__ePAUIList2ElementManagerType_List)
  Panel_CharacterSelect_All:RegisterUpdateFunc("PaGlobalFunc_CharacterSelectAll_PerFrameUpdate")
  Panel_CharacterSelect_All:RegisterShowEventFunc(true, "PaGlobalFunc_NPCShop_ALL_SetANI( true )")
  registerEvent("EventChangeLobbyStageToCharacterSelect", "PaGlobalFunc_CharacterSelect_All_Open")
  registerEvent("FromClient_OpenXboxLoadingPanel", "PaGlobalFunc_CharacterSelect_All_Close")
  registerEvent("FromClient_ChangeStartPositionByTutorialSkip", "FromClient_CharacterSelect_All_ChangeStartPositionByTutorialSkip")
  registerEvent("FromClient_HardCoreChangeUserInfo", "PaGlobalFunc_CharacterSelect_All_HardCoreUserInfoChange")
  registerEvent("EventCancelEnterWating", "FromClient_ChracterSelect_All_CancelEnterWating")
  registerEvent("EventReceiveEnterWating", "FromClient_ChracterSelect_All_ReceiveWaiting")
  registerEvent("EventSetEnterWating", "FromClient_ChracterSelect_All_SetWaitingUserCount")
  if ToClient_IsDevelopment() == true then
    registerEvent("PlayGoAutoViewAllCharacters", "FromClient_PlayGoAutoViewAllCharacters")
    registerEvent("PlayGoTabChange", "FromClient_PlayGoTabChange")
    registerEvent("PlayGoCreateNewCharacter", "FromClient_PlayGoCreateNewCharacter")
  end
  if true == isUsePadSnapping then
    self._ui.btn_CreateCharacter:registerPadEvent(__eConsoleUIPadEvent_A, "HandleEventLUp_CharacterSelect_All_CreateNewCharacter()")
    self._ui.btn_CreateFreeSeasonCharacter:registerPadEvent(__eConsoleUIPadEvent_A, "PaGlobalFunc_Season_Character_Create()")
    self._ui.btn_GamePlay:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_ClickGamePlay()")
    self._ui.btn_GamePlay:addInputEvent("Mouse_On", "HandleEventLUp_CharacterSelect_All_MouseOnGamePlay()")
    self._ui.chk_Ghost:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_OfflineModeTooltip(true)")
  else
    self._ui.rdo_Normal:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_TabClick(" .. self._TABTYPE._NORMAL .. ")")
    if true == self._isPremiumCharacterOpen then
      self._ui.rdo_Special:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_TabClick(" .. self._TABTYPE._PREMIUM .. ")")
    end
    if _ContentsGroup_HardCoreChannel == true then
      self._ui.rdo_HardCore:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_TabClick(" .. self._TABTYPE._HARDCORE .. ")")
    end
    self._ui.btn_BackToServer:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_BackToServerSelect()")
    self._ui.btn_Delete:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_Deleting()")
    self._ui.chk_Ghost:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_OfflineModeTooltip(true)")
    self._ui.chk_Ghost:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_OfflineModeTooltip(false)")
    Panel_CharacterSelect_All:addInputEvent("Mouse_On", "HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(true)")
    Panel_CharacterSelect_All:addInputEvent("Mouse_Out", "HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(false)")
    self._ui.stc_CharacterCountGuide:addInputEvent("Mouse_On", "HandleEventOnOut_CharacterSelect_All_CharacterCountGuide(true)")
    self._ui.stc_CharacterCountGuide:addInputEvent("Mouse_Out", "HandleEventOnOut_CharacterSelect_All_CharacterCountGuide(false)")
    self._ui.btn_CreateCharacter:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CreateNewCharacter()")
    self._ui.btn_CreateFreeSeasonCharacter:addInputEvent("Mouse_LUp", "PaGlobalFunc_Season_Character_Create()")
    self._ui.btn_GamePlay:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_ClickGamePlay()")
  end
end
function PaGlobal_CharacterSelect_All:swichPlatform(isUsePadSnapping)
  self._ui.btn_Delete:SetShow(not isUsePadSnapping)
  self._ui.btn_ChangePosition:SetShow(false)
  self._ui.btn_BackToServer:SetShow(not isUsePadSnapping)
  self._ui.chk_Ghost:SetShow(not self._isConsole)
  self._ui.stc_KeyGuide_A:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_B:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_Y:SetShow(isUsePadSnapping)
  self._ui.stc_KeyGuide_LBRB:SetShow(isUsePadSnapping)
  self._ui.stc_RightClick:SetShow(not isUsePadSnapping)
  self._ui.stc_MouseWheel:SetShow(not isUsePadSnapping)
  if true == self._isConsole then
    PaGlobal_CharacterSelect_All:SetGamerTagShow()
    self._ui.txt_version:SetText("ver." .. tostring(ToClient_getVersionString()))
  else
    local posY = getScreenSizeY() - self._ui.stc_RightClick:GetSizeY() - 20
    self._ui.stc_RightClick:SetPosX(20)
    self._ui.stc_RightClick:SetPosY(posY)
    self._ui.stc_RightClick:SetText(self._ui.stc_RightClick:GetText())
    self._ui.stc_MouseWheel:SetPosX(self._ui.stc_RightClick:GetPosX() + self._ui.stc_RightClick:GetTextSizeX() + 60)
    self._ui.stc_MouseWheel:SetPosY(posY)
  end
end
function PaGlobal_CharacterSelect_All:SetGamerTagShow()
  PaGlobal_CheckGamerTag()
  local uiOffset = ToClient_GetConsoleUIOffset()
  local resizedRatioX = getScreenSizeX() * uiOffset
  local resizedRatioY = getScreenSizeY() * uiOffset
  local gap = 0
  if resizedRatioX > 0 then
    gap = gap + 15
  end
  local scaleX = self._ui.txt_CharacterStatus:GetPosX() + gap + resizedRatioX
  local scaleY = self._ui.txt_CharacterStatus:GetPosY() + self._ui.txt_CharacterStatus:GetSizeY() + 30 + resizedRatioY
  Panel_GamerTag:SetPosX(scaleX)
  Panel_GamerTag:SetPosY(scaleY)
end
function PaGlobal_CharacterSelect_All:prepareOpen(charNo)
  if true == PaGlobal_CharacterSelect_All._isConsole then
    PaGlobalFunc_Customization_Close()
    PaGlobalFunc_Customization_InputName_Close()
    PaGlobal_CharacterSelect_All:SetGamerTagShow()
  elseif false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    showAllUI(false)
  else
    PaGlobalFunc_Customization_Close()
    PaGlobalFunc_Customization_InputName_Close()
  end
  local charIdx = -1
  if charNo == -1 or charNo == -2 then
    charIdx = charNo
  else
    local haveCount = PaGlobal_CharacterSelect_All._playerData.haveCount
    for idx = 0, haveCount - 1 do
      local charData = getCharacterDataByIndex(idx, PaGlobal_CharacterSelect_All._playerCreateType)
      if nil ~= charData and charNo == charData._characterNo_s64 then
        charIdx = idx
        break
      end
    end
  end
  if -1 == charIdx or charIdx >= self._playerData.haveCount then
    self._selectedCharIdx = 0
  elseif -2 ~= charIdx then
    self._selectedCharIdx = charIdx
  end
  if self._isConsole == true and charIdx == -1 then
    self._ui.list2_Character:moveTopIndex()
    ToClient_padSnapResetControl()
  end
  self:prepareHardCoreChannel()
  PaGlobal_CharacterSelect_All:open()
  PaGlobal_CharacterSelect_All:CheckAndSetPadUI()
  PaGlobalFunc_CharacterSelect_All_OnScreenResize()
  PaGlobal_CharacterSelect_All:update()
  HandleEventLUp_CharacterSelect_All_CharacterSelect(self._selectedCharIdx, true)
  PaGlobal_CharacterSelect_All:SetKeyGuideShow(self._eKeyGuideType.SELECTED)
  PaGlobal_CharacterSelect_All:CheckNewCharacter()
  if self._isUsePadSnapping == true and self._isConsole == false then
    local sizeX = self._ui.list2_Character:GetSizeX()
    local sizeY = self._ui.list2_Character:GetSizeY() - self._ui.chk_Ghost:GetSizeY() - self._ui.btn_CreateFreeSeasonCharacter:GetSizeY() - self._ui.stc_FreeSeasonArea:GetSizeY() - 30
    self._ui.list2_Character:SetSize(sizeX, sizeY)
    local characterListBG = UI.getChildControl(self._ui.list2_Character, "List2_1_Content")
    if characterListBG == nil then
      return
    end
    local slot = UI.getChildControl(characterListBG, "Button_CharacterSlot")
    if slot == nil then
      return
    end
    local offLineSizeX = slot:GetSizeX()
    self._ui.chk_Ghost:SetSize(offLineSizeX, self._ui.chk_Ghost:GetSizeY())
    self._ui.chk_Ghost:SetPosXY(slot:GetPosX(), self._ui.list2_Character:GetPosY() + self._ui.list2_Character:GetSizeY() + 10)
  end
  if true == ToClient_isConsole() then
    local sizeX = self._ui.list2_Character:GetSizeX()
    local sizeY = self._ui.list2_Character:GetSizeY() - self._ui.btn_CreateFreeSeasonCharacter:GetSizeY() - self._ui.stc_FreeSeasonArea:GetSizeY() - 30
    self._ui.list2_Character:SetSize(sizeX, sizeY)
  end
  local removeTime = getCharacterDataRemoveTime(self._selectedCharIdx, PaGlobal_CharacterSelect_All._playerCreateType)
  if self._playerData.haveCount == 0 or removeTime ~= nil or self._ui.btn_ChangePosition:IsCheck() == true then
    self._ui.btn_GamePlay:SetMonoTone(true)
    self._ui.btn_GamePlay:SetEnable(false)
  else
    self._ui.btn_GamePlay:SetMonoTone(false)
    self._ui.btn_GamePlay:SetEnable(true)
  end
end
function PaGlobal_CharacterSelect_All:CheckNewCharacter()
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  if playerCreateType ~= __ePlayerCreateNormal then
    return
  end
  local haveCount = PaGlobal_CharacterSelect_All._playerData.haveCount
  local newCharacterIndex
  for idx = 0, haveCount - 1 do
    local charData = getCharacterDataByIndex(idx, playerCreateType)
    if nil ~= charData and 0 == charData._currentPosition.x and 0 == charData._currentPosition.y and 0 == charData._currentPosition.z then
      newCharacterIndex = idx
      break
    end
  end
  if nil ~= newCharacterIndex then
    self._ui.list2_Character:moveIndex(newCharacterIndex)
  end
end
function PaGlobal_CharacterSelect_All:update()
  if self._ui.rdo_Special:IsCheck() == true then
    self._playerCreateType = __ePlayerCreatePremium
  elseif self._ui.rdo_HardCore:IsCheck() == true then
    self._playerCreateType = __ePlayerCreateHardCore
  else
    self._playerCreateType = __ePlayerCreateNormal
  end
  self._playerData.maxSlot = getCharacterSlotMaxCount(self._playerCreateType)
  self._playerData.haveCount = getCharacterDataCount(self._playerCreateType)
  self._playerData.useAbleCount = getCharacterSlotLimit(self._playerCreateType)
  self._ui.txt_FamilyName:SetText(getFamilyName())
  self._ui.txt_CharacterCount:SetText("")
  self._ui.btn_ChangePosition:SetMonoTone(self._playerCreateType ~= __ePlayerCreateNormal)
  self._ui.btn_ChangePosition:SetEnable(self._playerCreateType == __ePlayerCreateNormal)
  if self._isUsePadSnapping and self._isPremiumCharacterOpen and false == self._ui.btn_ChangePosition:IsCheck() then
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_CharacterSelect_All_TabChange(-1)")
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_CharacterSelect_All_TabChange(1)")
    self._ui.stc_KeyGuide_LB:SetShow(true)
    self._ui.stc_KeyGuide_RB:SetShow(true)
  else
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "")
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "")
    self._ui.stc_KeyGuide_LB:SetShow(false)
    self._ui.stc_KeyGuide_RB:SetShow(false)
  end
  if ToClient_IsDevelopment() == true then
    Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "SavePlayGoEssentialFiles()")
  end
  self._ui.stc_PrimiumBg:SetShow(self._playerCreateType == __ePlayerCreatePremium)
  if true == _ContentsGroup_SeasonContents then
    if self._playerCreateType ~= __ePlayerCreateNormal then
      PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
    else
      local characterData = getCharacterDataByIndex(self._selectedCharIdx, self._playerCreateType)
      if nil ~= characterData then
        local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
        PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(isSeasonCharacter)
      end
    end
  else
    PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
  end
  self:selectTabBaseUpdate()
  local seasonCharacterSlotCount = getUsableSeasonCharacterSlotCount()
  local curChannelData = getCurrentChannelServerData()
  local isMultiNationServer = false
  if curChannelData ~= nil then
    isMultiNationServer = curChannelData:isMultiNationServer()
  end
  self._canMakeSeason = (_ContentsGroup_SeasonContents or _ContentsGroup_PreSeason) and seasonCharacterSlotCount > 0 and isMultiNationServer == false
  self._seasonCharacterCount = 0
  local toIndex = self._ui.list2_Character:getCurrenttoIndex()
  local scrollPos = self._ui.list2_Character:GetVScroll():GetControlPos()
  self._ui.list2_Character:getElementManager():clearKey()
  for idx = 0, self._playerData.maxSlot - 1 do
    local charData = getCharacterDataByIndex(idx, __ePlayerCreateNormal)
    if nil ~= charData then
      if true == _ContentsGroup_PreSeason and false == _ContentsGroup_SeasonContents then
        if charData._characterSeasonType == __eCharacterSeasonType_Season then
          self._canMakeSeason = false
        end
      elseif true == _ContentsGroup_SeasonContents and (charData._characterSeasonType == __eCharacterSeasonType_Season or charData._characterSeasonType == __eCharacterSeasonType_Graduation) then
        self._canMakeSeason = false
      end
      if _ContentsGroup_SeasonGraduateByUser == true and (charData._characterSeasonType == __eCharacterSeasonType_Season or seasonCharacterSlotCount <= 0) then
        self._canMakeSeason = false
        if charData._characterSeasonType == __eCharacterSeasonType_Season then
          self._seasonCharacterCount = self._seasonCharacterCount + 1
        end
      end
    end
    self._ui.list2_Character:getElementManager():pushKey(toInt64(0, idx))
  end
  self._ui.list2_Character:setCurrenttoIndex(toIndex)
  self._ui.list2_Character:GetVScroll():SetControlPos(scrollPos)
  self._listContentsCount = self._playerData.maxSlot
  if nil ~= self._selectedCharIdx and -1 ~= self._selectedCharIdx then
    local removeTime = getCharacterDataRemoveTime(self._selectedCharIdx, self._playerCreateType)
    self._ui.btn_Delete:SetEnable(nil == removeTime)
    self._ui.btn_Delete:SetMonoTone(nil ~= removeTime, nil ~= removeTime)
    if nil ~= removeTime then
      PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(nil, removeTime)
    else
      local characterData = getCharacterDataByIndex(self._selectedCharIdx, self._playerCreateType)
      if nil ~= characterData then
        PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(characterData)
      end
    end
  end
  if self._canMakeSeason == false or self._playerCreateType ~= __ePlayerCreateNormal then
    self._ui.btn_CreateFreeSeasonCharacter:SetMonoTone(true)
    self._ui.btn_CreateFreeSeasonCharacter:SetEnable(false)
  else
    self._ui.btn_CreateFreeSeasonCharacter:SetMonoTone(false)
    self._ui.btn_CreateFreeSeasonCharacter:SetEnable(true)
  end
  local freeSeasonCharacterUsableCount = getUsableSeasonCharacterSlotCount()
  if freeSeasonCharacterUsableCount > 0 and isMultiNationServer == false then
    for idx = 0, freeSeasonCharacterUsableCount - 1 do
      local light = UI.getChildControl(self._ui.stc_FreeSeasonCountCircle[self._MAX_CIRCLE_COUNT - idx - 1], "Static_Light")
      light:SetShow(true)
      if 0 < self._seasonCharacterCount and idx == 0 then
        light:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Etc_Server_Icon_SeasonCharacter_Check")
        light:setRenderTexture(light:getBaseTexture())
      end
    end
  end
  if PaGlobalFunc_Customization_ForceFirstChracterSeason ~= nil and PaGlobalFunc_Customization_ForceFirstChracterSeason() == true and seasonCharacterSlotCount > 0 then
    self._ui.btn_CreateCharacter:SetShow(false)
    self._ui.btn_CreateFreeSeasonCharacter:SetPosX(self._firstSeasonPosX)
    self._ui.btn_CreateFreeSeasonCharacter:SetSize(self._firstSeasonSizeX, self._ui.btn_CreateFreeSeasonCharacter:GetSizeY())
    if PaGlobal_CharacterSelect_All._playerData.haveCount == 0 and self._isFirstEnter == false and ToClient_HardCoreChannelWithContensOption() == false and PaGlobalFunc_Season_Character_Create ~= nil then
      PaGlobalFunc_Season_Character_Create()
      self._isFirstEnter = true
    end
  else
    self._ui.btn_CreateCharacter:SetShow(true)
    self._ui.btn_CreateFreeSeasonCharacter:SetPosX(self._firstSeasonOriPosX)
    self._ui.btn_CreateFreeSeasonCharacter:SetSize(self._firstSeasonOriSizeX, self._ui.btn_CreateFreeSeasonCharacter:GetSizeY())
    self._ui.btn_CreateCharacter:ComputePos()
    self._ui.btn_CreateFreeSeasonCharacter:ComputePos()
  end
  self._ui.btn_CreateCharacter:SetShow(false)
  self._ui.btn_CreateFreeSeasonCharacter:SetShow(false)
  local removeTime = getCharacterDataRemoveTime(self._selectedCharIdx, PaGlobal_CharacterSelect_All._playerCreateType)
  if PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() == true or self._playerData.haveCount == 0 or removeTime ~= nil then
    self._ui.btn_GamePlay:SetMonoTone(true)
    self._ui.btn_GamePlay:SetEnable(false)
  else
    self._ui.btn_GamePlay:SetMonoTone(false)
    self._ui.btn_GamePlay:SetEnable(true)
  end
end
function PaGlobal_CharacterSelect_All:getMaxSlot(playerCreateType)
  local maxcount = 0
  if getCharacterDataCount(playerCreateType) <= getCharacterSlotMaxCount(playerCreateType) then
    maxcount = getCharacterSlotLimit(playerCreateType) + 1
  else
    maxcount = getCharacterDataCount(playerCreateType)
  end
  return maxcount
end
function PaGlobal_CharacterSelect_All:enableEnterBtn(isEnable)
  self._ui.btn_Delete:SetEnable(isEnable)
  self._ui.btn_ChangePosition:SetEnable(isEnable)
  self._ui.btn_CreateCharacter:SetEnable(isEnable)
  self._ui.btn_BackToServer:SetEnable(isEnable)
  self._ui.rdo_Normal:SetEnable(isEnable)
  self._ui.rdo_Special:SetEnable(isEnable)
  self._ui.rdo_HardCore:SetEnable(isEnable)
  self._ui.btn_GamePlay:SetEnable(isEnable)
  for idx = 0, #self._ui._btn_EnterTable do
    self._ui._btn_EnterTable[idx]._enter:SetEnable(isEnable)
    self._ui._btn_EnterTable[idx]._delete:SetEnable(isEnable)
    self._ui._btn_EnterTable[idx]._slot:SetEnable(isEnable)
  end
  if true == self._isUsePadSnapping then
    if true == isEnable then
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLBRB_CharacterSelect_All_TabChange(-1)")
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLBRB_CharacterSelect_All_TabChange(1)")
    else
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_LB, "")
      Panel_CharacterSelect_All:registerPadEvent(__eConsoleUIPadEvent_RB, "")
    end
  end
end
function PaGlobal_CharacterSelect_All:open()
  if nil == Panel_CharacterSelect_All then
    return
  end
  Panel_CharacterSelect_All:SetShow(true)
end
function PaGlobal_CharacterSelect_All:prepareClose()
  TooltipSimple_Hide()
  if true == self._isConsole then
    Panel_GamerTag:ComputePos()
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  PaGlobal_CharacterSelect_All:close()
end
function PaGlobal_CharacterSelect_All:close()
  Panel_CharacterSelect_All:SetShow(false)
end
function PaGlobal_CharacterSelect_All:setCharacterView(charIdx, classType, playerCreateType, isChangeSpecialTab)
  local cameraSettingData = NewClassData.lobbyCharacterSelectCameraPosition[classType]
  if cameraSettingData ~= nil then
    local cameraPosition = cameraSettingData.position
    local pitchRoll = cameraSettingData.pitchRoll
    local weatherData = cameraSettingData.weather
    viewCharacter(charIdx, cameraPosition.xPos, cameraPosition.yPos, cameraPosition.zPos, cameraPosition.rotation, playerCreateType, isChangeSpecialTab)
    viewCharacterPitchRoll(pitchRoll.pitch, pitchRoll.roll)
    viewCharacterFov(cameraSettingData.fov)
    setWeatherTime(weatherData.index, weatherData.time)
  else
    viewCharacter(charIdx, 0, 0, 0, 0, playerCreateType, isChangeSpecialTab)
    viewCharacterPitchRoll(0, 0)
  end
end
function PaGlobal_CharacterSelect_All:playListComponentsAni(deltaT)
  self._listContentsLaunchElapsed = self._listContentsLaunchElapsed + deltaT
  local content = self._listContents[_listContentsLaunchedCount]
  if self._playerData.useAbleCount <= self._listContentsLaunchedCount + 1 or nil == self._listContentsLaunchTimeTable[self._listContentsLaunchedCount] then
    self._listContentsShowAniFlag = false
    for ii = 1, #self._listContents do
      if self._listContents[ii] ~= nil then
        self._listContents[ii]:SetShow(true)
      end
      self._listContentsAlphaFlag[ii] = true
      self._listContentsAlphaTarget[ii] = 1
    end
    return
  else
    if nil ~= content and nil ~= content.SetShow and self._listContentsLaunchElapsed >= self._listContentsLaunchTimeTable[self._listContentsLaunchedCount] then
      content:SetShow(true)
      self._listContentsAlphaFlag[self._listContentsLaunchedCount] = true
      self._listContentsAlphaTarget[self._listContentsLaunchedCount] = 1
    end
    self._listContentsLaunchedCount = self._listContentsLaunchedCount + 1
  end
end
function PaGlobal_CharacterSelect_All:animateListComponentsSlide(deltaT, index)
  local content = PaGlobal_CharacterSelect_All._listContents[index]
  if nil == content or nil == PaGlobal_CharacterSelect_All._listContentsSlideTarget[index] then
    return
  end
  local currentPos = content:GetPosX()
  local distance = PaGlobal_CharacterSelect_All._listContentsSlideTarget[index] - currentPos
  local acc = distance / 100 * deltaT * 10
  if acc > -1 and acc < 0 then
    acc = -1
  elseif acc < 1 and acc > 0 then
    acc = 1
  end
  if 1 < math.abs(distance) then
    content:SetPosX(currentPos + acc)
  else
    content:SetPosX(PaGlobal_CharacterSelect_All._listContentsSlideTarget[index])
    PaGlobal_CharacterSelect_All._listContentsSlideFlag[index] = false
  end
end
function PaGlobal_CharacterSelect_All:animateListComponentsAlpha(deltaT, index)
  local content = self._listContents[index]
  if nil == content or nil == self._listContentsAlphaTarget[index] then
    return
  end
  local currentAlpha = content:GetAlpha()
  local distance = self._listContentsAlphaTarget[index] - currentAlpha
  local acc = distance * deltaT * 5
  if 0.01 < math.abs(distance) then
    local nextAlpha = currentAlpha + acc
    content:SetAlphaExtraChild(nextAlpha)
  else
    content:SetAlphaExtraChild(self._listContentsAlphaTarget[index])
    self._listContentsAlphaFlag[index] = false
  end
end
function PaGlobal_CharacterSelect_All:SetKeyGuideShow(type)
  if false == self._isUsePadSnapping then
    return
  end
  self._curKeyGuideIdx = type
  self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_TOSERVER"))
  if self._eKeyGuideType.NOT_SELECT == type then
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
  elseif self._eKeyGuideType.SELECTED == type then
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_CONNECT"))
    self._ui.stc_KeyGuide_Y:SetShow(true)
    self._ui.stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_CHANGESKILL_DELETE"))
  elseif self._eKeyGuideType.DELETING == type then
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_A:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(true)
    self._ui.stc_KeyGuide_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_DELETECANCEL"))
  elseif self._eKeyGuideType.CHANGEINGSLOT_NOT_SELECTED == type then
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_LBRB:SetShow(true)
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
    self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  elseif self._eKeyGuideType.CHANGEINGSLOT_SELECTED == type then
    self._ui.stc_KeyGuide_A:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  elseif self._eKeyGuideType.ADD_NEWCHARACTER == type then
    if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
      self._ui.stc_KeyGuide_Y:SetShow(false)
      self._ui.stc_KeyGuide_A:SetShow(true)
      self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
      self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
    else
      self._ui.stc_KeyGuide_LBRB:SetShow(false)
      self._ui.stc_KeyGuide_Y:SetShow(false)
      self._ui.stc_KeyGuide_A:SetShow(true)
      self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_EXCHANGE_SELECT"))
    end
  elseif self._eKeyGuideType.ACTIVE_GAMEPLAYBTN == type then
    self._ui.stc_KeyGuide_A:SetShow(true)
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_CONNECT"))
    self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTER_SELECT_BTN_TOSERVER"))
  elseif self._eKeyGuideType.INACTIVE_GAMEPLAYBTN == type then
    self._ui.stc_KeyGuide_A:SetShow(false)
    self._ui.stc_KeyGuide_Y:SetShow(false)
    self._ui.stc_KeyGuide_LBRB:SetShow(false)
    self._ui.stc_KeyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  end
  PaGlobal_CharacterSelect_All:keyguideAlign()
end
function PaGlobal_CharacterSelect_All:keyguideAlign()
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui.stc_KeyGuide_B
  }, self._ui.stc_RightBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
end
function PaGlobal_CharacterSelect_All:SetMsgDataAndShow(_title, _content, _funcYes, _funcNo, _funcApply, _priority, _keyUse)
  local messageboxData = {}
  messageboxData.title = ""
  messageboxData.content = ""
  messageboxData.priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  messageboxData.functionYes = MessageBox_Empty_function
  messageboxData.functionNo = MessageBox_Empty_function
  messageboxData.functionApply = MessageBox_Empty_function
  if nil ~= _title then
    messageboxData.title = _title
  end
  if nil ~= _content then
    messageboxData.content = _content
  end
  if nil ~= _priority then
    messageboxData.priority = _priority
  end
  if nil ~= _funcYes or nil ~= _funcNo then
    if nil ~= _funcYes then
      messageboxData.functionYes = _funcYes
    end
    if nil ~= _funcNo then
      messageboxData.functionNo = _funcNo
    end
    messageboxData.functionApply = nil
  else
    if nil ~= _funcApply then
      messageboxData.functionApply = _funcApply
    end
    messageboxData.functionYes = nil
    messageboxData.functionNo = nil
  end
  MessageBox.showMessageBox(messageboxData, nil, nil, _keyUse)
end
function PaGlobal_CharacterSelect_All:validate()
  self._ui.stc_BackGroundBg:isValidate()
  self._ui.stc_RightBg:isValidate()
  self._ui.txt_Title:isValidate()
  self._ui.txt_CharacterCount:isValidate()
  self._ui.stc_CharacterCountGuide:isValidate()
  self._ui.rdo_Normal:isValidate()
  self._ui.rdo_Special:isValidate()
  self._ui.rdo_HardCore:isValidate()
  self._ui.btn_Delete:isValidate()
  self._ui.btn_ChangePosition:isValidate()
  self._ui.btn_BackToServer:isValidate()
  self._ui.chk_Ghost:isValidate()
  self._ui.stc_SelectLine:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.stc_KeyGuide_LBRB:isValidate()
  self._ui.txt_FamilyName:isValidate()
  self._ui.txt_CharacterName:isValidate()
  self._ui.txt_CharacterStatus:isValidate()
  self._ui.list2_Character:isValidate()
  self._ui.stc_RightClick:isValidate()
  self._ui.stc_MouseWheel:isValidate()
  self._ui.stc_Fade:isValidate()
  self._ui.stc_PrimiumBg:isValidate()
  self._ui.txt_PrimiumTitle:isValidate()
  self._ui.txt_PrimiumDesc:isValidate()
  self._ui.stc_SeasonBg:isValidate()
  self._ui.txt_SeasonTitle:isValidate()
  self._ui.txt_SeasonDesc:isValidate()
  self._ui.btn_CreateCharacter:isValidate()
  self._ui.btn_CreateFreeSeasonCharacter:isValidate()
  self._ui.stc_FreeSeasonArea:isValidate()
  self._ui.stc_FreeSeasonCountBox:isValidate()
  self._ui.btn_GamePlay:isValidate()
end
function PaGlobal_CharacterSelect_All:CheckAndSetPadUI()
  if nil == Panel_CharacterSelect_All then
    return
  end
  if false == Panel_CharacterSelect_All:GetShow() then
    return
  end
  if false == _ContentsGroup_useUISnappingOption then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  if true == _ContentsGroup_RenewUI then
    return
  end
  if false == ToClient_IsPadContollerForPC() then
    PaGlobal_CharacterSelect_All._isUsePadSnapping = false
    PaGlobal_CharacterSelect_All:swichPlatform(PaGlobal_CharacterSelect_All._isUsePadSnapping)
    PaGlobal_CharacterSelect_All:registEventHandler(PaGlobal_CharacterSelect_All._isUsePadSnapping)
    PaGlobal_CharacterSelect_All:update()
  else
    PaGlobal_CharacterSelect_All._isUsePadSnapping = true
    PaGlobal_CharacterSelect_All:swichPlatform(PaGlobal_CharacterSelect_All._isUsePadSnapping)
    PaGlobal_CharacterSelect_All:registEventHandler(PaGlobal_CharacterSelect_All._isUsePadSnapping)
    PaGlobal_CharacterSelect_All:update()
  end
end
function PaGlobal_CharacterSelect_All:checkHaveOverLevelCharacter()
  if nil == Panel_CharacterSelect_All then
    return false
  end
  local characterDataCount = getCharacterDataCount(__ePlayerCreateNormal)
  local compLevel = self._skippableLevel
  if nil ~= destLevel then
    compLevel = destLevel
  end
  for index = 0, characterDataCount - 1 do
    local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
    if compLevel <= characterData._level then
      return true
    end
  end
  return false
end
function PaGlobal_CharacterSelect_All:resetHardCoreUserXX()
  if Panel_CharacterSelect_All == nil then
    return
  end
  if _ContentsGroup_HardCoreChannel == false then
    return
  end
  if (isRealServiceMode() == false and ToClient_HardCoreChannelWithContensOption() == true) == false then
    return
  end
  local doHardCoreReset = function()
    ToClient_ResetHardcoreUserXXX()
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_FARMING_RESET"),
    functionYes = doHardCoreReset,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_CharacterSelect_All:prepareHardCoreChannel()
  if Panel_CharacterSelect_All == nil then
    return
  end
  if _ContentsGroup_HardCoreChannel == false then
    return
  end
  local isHardcoreChannel = ToClient_isHardCoreChannel()
  if isHardcoreChannel == true then
    self._playerCreateType = __ePlayerCreateHardCore
    self._currentTab = self._TABTYPE._HARDCORE
    if self._ui._rdoTables[self._TABTYPE._NORMAL] ~= nil then
      self._ui._rdoTables[self._TABTYPE._NORMAL]:SetUnchecked()
    end
    if self._ui._rdoTables[self._TABTYPE._PREMIUM] ~= nil then
      self._ui._rdoTables[self._TABTYPE._PREMIUM]:SetUnchecked()
    end
    if self._ui._rdoTables[self._TABTYPE._HARDCORE] ~= nil then
      self._ui._rdoTables[self._TABTYPE._HARDCORE]:SetCheck(true)
    end
  end
  if isRealServiceMode() == false and ToClient_HardCoreChannelWithContensOption() == true and self._ui._rdoTables[self._TABTYPE._HARDCORE] ~= nil then
    self._ui._rdoTables[self._TABTYPE._HARDCORE]:addInputEvent("Mouse_RUp", "PaGlobal_CharacterSelect_All:resetHardCoreUserXX()")
  end
end
function PaGlobal_CharacterSelect_All:selectTabBaseUpdate()
  local playerCreateType = self._playerCreateType
  local isHardCoreChannel = _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel()
  local radioTableType = self._TABTYPE._NORMAL
  if self._playerCreateType == __ePlayerCreatePremium then
    radioTableType = self._TABTYPE._PREMIUM
  elseif self._playerCreateType == __ePlayerCreateHardCore then
    radioTableType = self._TABTYPE._HARDCORE
  end
  self._currentTab = radioTableType
  if self._ui._rdoTables[self._TABTYPE._NORMAL] ~= nil then
  end
  if self._ui._rdoTables[self._TABTYPE._PREMIUM] ~= nil then
  end
  if self._ui._rdoTables[self._TABTYPE._HARDCORE] ~= nil then
  end
  if isHardCoreChannel == true and self._currentTab == self._TABTYPE._HARDCORE then
    self:hardCoreServerUISetting()
  else
    self._ui.chk_Ghost:SetCheck(false)
    self._ui.chk_Ghost:SetIgnore(false)
    self._ui.stc_LeftTimeBg:SetShow(false)
  end
  self._ui.stc_SelectLine:SetSpanSize(self._ui._rdoTables[radioTableType]:GetSpanSize().x, self._ui.stc_SelectLine:GetSpanSize().y)
  if self._playerCreateType == __ePlayerCreateHardCore then
    self._ui.btn_CreateCharacterText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "LUA_HARDCORECHARACTER_CREATE"))
    self._ui.stc_FreeSeasonArea:SetShow(false)
  else
    self._ui.btn_CreateCharacterText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOBBY_CHARACTER_CREATE"))
    self._ui.stc_FreeSeasonArea:SetShow(true)
  end
end
function PaGlobal_CharacterSelect_All:normalEnterGame(charIdx)
  PaGlobalFunc_CharacterSelect_All_FadeOut()
  self:enableEnterBtn(false)
  self._selectedCharIdx = charIdx
  luaTimer_AddEvent(PaGlobalFunc_CharacterSelect_All_TryLogin, self._enteringGameFadeOutTime * 1000, false, 0)
end
function PaGlobal_CharacterSelect_All:hardCoreCharacterLogin(charIdx)
  local hardCoreCharacterData = getCharacterDataByIndex(charIdx, __ePlayerCreateHardCore)
  local loginPossible = ToClient_getHardCoreCharacterLoginPossible(hardCoreCharacterData._characterNo_s64)
  if loginPossible == __eHardCoreLoginCheckRemainPlayTime or loginPossible == __eHardCoreLoginCheckReset then
    PaGlobal_CharacterSelect_All:normalEnterGame(charIdx)
    return
  end
  local reasonText
  if loginPossible == __eHardCoreLoginCheckPlayTimeEmpty then
    reasonText = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSnailMinorPlayTimeEmpty")
  elseif loginPossible == __eHardCoreLoginCheckAccumulated then
    reasonText = PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_CHANGEPOINT_COMPLETE_STATE")
  end
  if reasonText == nil then
    return
  end
  local updateHardcoreTime = function()
    PaGlobal_CharacterSelect_All:hardCoreServerUISetting()
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE"),
    content = reasonText,
    functionYes = nil,
    functionCancel = updateHardcoreTime,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_CharacterSelect_All:hardCoreServerUISetting()
  local playerCreateType = self._playerCreateType
  local isHardCoreChannel = _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel()
  if isHardCoreChannel == false or self._currentTab ~= self._TABTYPE._HARDCORE then
    return
  end
  self._ui.chk_Ghost:SetCheck(true)
  self._ui.chk_Ghost:SetIgnore(true)
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper ~= nil then
    temporaryWrapper:setGhostMode(self._ui.chk_Ghost:IsCheck())
  end
  local hardCoreTimePosY = self._ui.btn_GamePlay:GetPosY() - self._ui.stc_LeftTimeBg:GetSizeY() - 10
  self._ui.stc_LeftTimeBg:SetPosY(hardCoreTimePosY)
  self._ui.stc_LeftTimeBg:SetShow(true)
  local btnSize = getScreenSizeY() - (PaGlobal_CharacterSelect_All._ui.stc_LeftTimeBg:GetPosY() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetPosY())
  btnSize = btnSize + (PaGlobal_CharacterSelect_All._ui.list2_Character:GetPosY() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetPosY()) + 10
  local listSize = getScreenSizeY() - btnSize
  self._ui.list2_Character:SetSize(self._ui.list2_Character:GetSizeX(), listSize)
  local leftTimeString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE_REMAINTIME")
  local leftPlayableMinute = ToClient_getHardCoreLoginPossibleRemainedPlayableMinute()
  if leftPlayableMinute == 0 then
    self._ui.stc_LeftTime:SetText(leftTimeString .. ": -")
  else
    local string = ""
    local playableHour = math.floor(leftPlayableMinute / 60)
    string = string .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", playableHour)
    local playableMinute = leftPlayableMinute % 60
    string = string .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", playableMinute)
    self._ui.stc_LeftTime:SetText(leftTimeString .. ":" .. string)
  end
  local remainedLoginPossibleSeconds = ToClient_getHardCoreLoginResetRemainedSeconds()
  local remainedString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE_RESETTIME")
  local remainedMinuteTotal = math.floor(remainedLoginPossibleSeconds / 60)
  local remainedMinute = remainedMinuteTotal % 60
  local remainedHour = math.floor(remainedMinuteTotal / 60)
  local string = ""
  string = string .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_HOUR", "time_hour", remainedHour)
  string = string .. PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_MINUTE", "time_minute", remainedMinute)
  self._ui.stc_ReloadTime:SetText(remainedString .. ":" .. string)
  self._ui.stc_ReloadTime:SetShow(true)
  local loginTimeString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE_LOGINTIME")
  local loginTime = ToClient_getHardCoreLoginTime()
  local isvalidLoginTime = true
  if loginTime:GetYear() < 2000 then
    isvalidLoginTime = false
  end
  if isvalidLoginTime == false then
    self._ui.stc_StartTime:SetText(loginTimeString .. ": --")
  else
    local string = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_GUILD_ATTRIBUTEREPORT_TIME", "hour", loginTime:GetHour(), "minute", loginTime:GetMinute())
    self._ui.stc_StartTime:SetText(loginTimeString .. ":" .. string)
  end
end
