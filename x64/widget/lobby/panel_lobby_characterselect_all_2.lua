function PaGlobalFunc_CharacterSelect_All_Open(charNo)
  PaGlobal_CharacterSelect_All:prepareOpen(charNo)
end
function PaGlobalFunc_CharacterSelect_All_Close()
  PaGlobal_CharacterSelect_All:prepareClose(charIdx)
end
function PaGlobalFunc_CharacterSelect_All_OnScreenResize()
  Panel_CharacterSelect_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_CharacterSelect_All:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_Fade:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_CharacterSelect_All._ui.stc_BackGroundBg:SetSize(PaGlobal_CharacterSelect_All._ui.stc_BackGroundBg:GetSizeX(), getScreenSizeY())
  PaGlobal_CharacterSelect_All._ui.stc_BackGroundBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_RightBg:SetSize(PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetSizeX(), getScreenSizeY())
  PaGlobal_CharacterSelect_All._ui.stc_RightBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_PrimiumBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:ComputePos()
  PaGlobal_CharacterSelect_All._ui.txt_version:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_CreateCharacter:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_CreateFreeSeasonCharacter:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_Delete:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:ComputePos()
  PaGlobal_CharacterSelect_All._ui.chk_Ghost:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_BackToServer:ComputePos()
  PaGlobal_CharacterSelect_All._ui.stc_FreeSeasonArea:ComputePos()
  PaGlobal_CharacterSelect_All._ui.btn_GamePlay:ComputePos()
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_A:ComputePos()
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_B:ComputePos()
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_Y:ComputePos()
    PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_LBRB:ComputePos()
    PaGlobal_CharacterSelect_All:keyguideAlign()
  end
  PaGlobal_CharacterSelect_All._ui.list2_Character:ComputePos()
  local padding = 15
  local btnSize = 0
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    btnSize = getScreenSizeY() - (PaGlobal_CharacterSelect_All._ui.stc_KeyGuide_A:GetPosY() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetPosY())
    btnSize = btnSize + (PaGlobal_CharacterSelect_All._ui.list2_Character:GetPosY() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetPosY()) + padding
    PaGlobal_CharacterSelect_All._ui.list2_Character:SetSize(PaGlobal_CharacterSelect_All._ui.list2_Character:GetSizeX(), getScreenSizeY() - btnSize)
  else
    btnSize = getScreenSizeY() - (PaGlobal_CharacterSelect_All._ui.stc_FreeSeasonArea:GetPosY() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetPosY())
    btnSize = btnSize + (PaGlobal_CharacterSelect_All._ui.list2_Character:GetPosY() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetPosY()) + padding
    PaGlobal_CharacterSelect_All._ui.list2_Character:SetSize(PaGlobal_CharacterSelect_All._ui.list2_Character:GetSizeX(), getScreenSizeY() - btnSize)
  end
  PaGlobal_CharacterSelect_All._ui.list2_Character:createChildContent(__ePAUIList2ElementManagerType_List)
  ToClient_padSnapRefreshTarget(Panel_CharacterSelect_All)
end
function PaGlobalFunc_CharacterSelect_All_List2Update(content, key)
  local charIdx = Int64toInt32(key)
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local isAnimationFinished = PaGlobal_CharacterSelect_All._allAnimationFinished
  local isShowAnimation = PaGlobal_CharacterSelect_All._listContentsShowAniFlag
  local haveCount = PaGlobal_CharacterSelect_All._playerData.haveCount
  local limitCount = PaGlobal_CharacterSelect_All._playerData.useAbleCount
  local maxCount = PaGlobal_CharacterSelect_All._playerData.maxSlot
  PaGlobal_CharacterSelect_All._listContents[charIdx] = content
  if false == isAnimationFinished and false == isShowAnimation then
    PaGlobal_CharacterSelect_All._listContentsSlideTarget[charIdx] = PaGlobal_CharacterSelect_All._listContentsBaseX
    content:SetAlphaExtraChild(0)
  else
    PaGlobal_CharacterSelect_All._listContentsAlphaTarget[charIdx] = 1
    PaGlobal_CharacterSelect_All._listContentsAlphaFlag[charIdx] = true
  end
  local btnSlot = UI.getChildControl(content, "Button_CharacterSlot")
  local selectGradation = UI.getChildControl(btnSlot, "Static_SelectGradation")
  local btn_Enter = UI.getChildControl(btnSlot, "Button_Enter")
  local stc_ClassIcon = UI.getChildControl(content, "Static_ClassIcon")
  local stc_SeasonSlot = UI.getChildControl(content, "Static_SeasonSlot")
  local txt_lv = UI.getChildControl(content, "StaticText_Lv")
  local txt_Name = UI.getChildControl(content, "StaticText_Name")
  local txt_Region = UI.getChildControl(content, "StaticText_Region")
  local stc_DeleteConsole = UI.getChildControl(content, "StaticText_DeleteConsole")
  local stc_DeleteIconConsole = UI.getChildControl(stc_DeleteConsole, "StaticText_DeleteIcon")
  local stc_Delete = UI.getChildControl(content, "StaticText_Delete")
  local stc_DeleteIcon = UI.getChildControl(stc_Delete, "StaticText_DeleteIcon")
  local stc_UnlockIcon = UI.getChildControl(content, "Static_UnlockIcon")
  local stc_LockIcon = UI.getChildControl(content, "Static_LockIcon")
  local btn_Up = UI.getChildControl(content, "Button_Up")
  local btn_Down = UI.getChildControl(content, "Button_Down")
  local stc_LandServant = UI.getChildControl(content, "Static_ServantView_Ground")
  local stc_SeaServant = UI.getChildControl(content, "Static_ServantView_Sea")
  local txt_SeasonDesc = UI.getChildControl(content, "StaticText_SeasonDesc")
  local stc_duelCharIcon = UI.getChildControl(content, "Static_OriginalCha")
  local txt_AddIcon = UI.getChildControl(content, "StaticText_AddIcon")
  local btns = {
    _slot = btnSlot,
    _enter = btn_Enter,
    _delete = stc_Delete
  }
  PaGlobal_CharacterSelect_All._ui._btn_EnterTable[charIdx] = btns
  btnSlot:SetShow(false)
  btnSlot:addInputEvent("Mouse_On", "")
  btnSlot:addInputEvent("Mouse_LUp", "")
  btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  btnSlot:SetIgnore(false)
  btnSlot:setNotImpactScrollEvent(true)
  btn_Enter:SetShow(false)
  selectGradation:SetShow(false)
  stc_ClassIcon:SetShow(false)
  txt_lv:SetShow(false)
  txt_Name:SetShow(false)
  txt_Region:SetShow(false)
  stc_Delete:SetShow(false)
  txt_AddIcon:SetShow(false)
  stc_UnlockIcon:SetShow(false)
  stc_LockIcon:SetShow(false)
  stc_LockIcon:SetMonoTone(true)
  btn_Up:SetShow(false)
  btn_Down:SetShow(false)
  stc_LandServant:SetShow(false)
  stc_SeaServant:SetShow(false)
  stc_SeasonSlot:SetShow(false)
  txt_SeasonDesc:SetShow(false)
  txt_lv:SetText("")
  txt_Name:SetText("")
  txt_Region:SetText("")
  stc_Delete:SetSize(stc_Delete:GetTextSizeX() + 50, stc_Delete:GetSizeY())
  stc_Delete:ComputePos()
  stc_DeleteIcon:SetSpanSize(10, stc_DeleteIcon:GetSpanSize().y)
  stc_DeleteIcon:SetShow(false)
  stc_DeleteConsole:SetShow(false)
  stc_DeleteIconConsole:SetShow(false)
  stc_duelCharIcon:SetShow(false)
  txt_AddIcon:SetPosX((content:GetSizeX() - (txt_AddIcon:GetSizeX() + txt_AddIcon:GetTextSizeX()) + 5) / 2)
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "")
    btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  end
  if charIdx < haveCount then
    local charData = getCharacterDataByIndex(charIdx, playerCreateType)
    local regionInfo
    if nil ~= charData then
      local charName = getCharacterName(charData)
      local classType = getCharacterClassType(charData)
      local level = string.format("%d", charData._level)
      local pcDeliveryRegionKey = charData._arrivalRegionOrWaypointKey
      local serverUtc64 = getServerUtc64()
      local location = "-"
      if 0 ~= charData._currentPosition.x and 0 ~= charData._currentPosition.y and 0 ~= charData._currentPosition.z then
        if pcDeliveryRegionKey ~= 0 and serverUtc64 > charData._arrivalTime then
          if _ContentsGroup_WorldMapFamilyCharacterManagement == true then
            location = getRegionNameByWaypointKey(pcDeliveryRegionKey)
          else
            local arrivalRegionKey = RegionKey(pcDeliveryRegionKey)
            local regionInfoArrival = getRegionInfoByRegionKey(arrivalRegionKey)
            regionInfo = regionInfoArrival
            location = regionInfoArrival:getAreaName()
          end
        else
          regionInfo = getRegionInfoByPosition(charData._currentPosition)
          location = regionInfo:getAreaName()
        end
      end
      PaGlobalFunc_Util_SetClassSymbolIcon(stc_ClassIcon, classType)
      txt_lv:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. ". " .. level)
      txt_lv:SetSize(txt_lv:GetTextSizeX() + 5, txt_lv:GetSizeY())
      if false == isGameTypeKorea() then
        txt_Name:SetSpanSize(PaGlobal_CharacterSelect_All._ui._originNameSpanX + 5, txt_Name:GetSpanSize().y)
      else
        txt_Name:SetSpanSize(PaGlobal_CharacterSelect_All._ui._originNameSpanX, txt_Name:GetSpanSize().y)
      end
      txt_Name:SetText(charName)
      txt_Name:SetPosX(txt_lv:GetPosX() + txt_lv:GetTextSizeX() + 10)
      txt_Region:SetTextMode(__eTextMode_LimitText)
      txt_Region:SetText(location)
      local removeTime = getCharacterDataRemoveTime(charIdx, playerCreateType)
      local isMouseOverFlag = charIdx == PaGlobal_CharacterSelect_All._currentOveredCharIdx and false == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
      local mouseOverEffect = isMouseOverFlag and charIdx ~= PaGlobal_CharacterSelect_All._selectedCharIdx
      local isSelectedFlag = charIdx == PaGlobal_CharacterSelect_All._selectedCharIdx and false == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
      if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
        if PaGlobal_CharacterSelect_All._currentTab == PaGlobal_CharacterSelect_All._TABTYPE._NORMAL then
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        else
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        end
        btn_Enter:SetShow(false)
      else
        btn_Enter:SetShow(isSelectedFlag or isMouseOverFlag)
        btnSlot:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_CharacterOver(" .. charIdx .. ")")
      end
      btn_Enter:addInputEvent("Mouse_LUp", "")
      btnSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CharacterSelect(" .. charIdx .. ",false)")
      btnSlot:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_CharacterOut(" .. charIdx .. ")")
      if true == mouseOverEffect then
        PaGlobal_CharacterSelect_All._listContentsSlideFlag[charIdx] = true
        PaGlobal_CharacterSelect_All._listContentsSlideTarget[charIdx] = PaGlobal_CharacterSelect_All._listContentsBaseX - 10
      else
        PaGlobal_CharacterSelect_All._listContentsSlideFlag[charIdx] = true
        PaGlobal_CharacterSelect_All._listContentsSlideTarget[charIdx] = PaGlobal_CharacterSelect_All._listContentsBaseX
      end
      if nil ~= removeTime then
        if false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
          stc_Delete:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CancelDeleting(" .. charIdx .. ")")
        else
          btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.DELETING) .. ")")
          btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CharacterSelect_All_CancelDeleting(" .. charIdx .. ")")
        end
      else
        btn_Enter:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_PrepareEnterToField(" .. charIdx .. ")")
        if charIdx == PaGlobal_CharacterSelect_All._selectedCharIdx then
          selectGradation:SetShow(true)
          if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
            btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED) .. ")")
            btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_CharacterSelect_All_PrepareEnterToField(" .. charIdx .. ")")
            btnSlot:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_CharacterSelect_All_Deleting()")
            if false == _ContentsGroup_RenewUI then
              btn_Enter:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_PrepareEnterToField(" .. charIdx .. ")")
            end
          end
        elseif true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
          btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT) .. ")")
        end
      end
      local SealedServantCount = 0
      local servantType = 0
      local servantControl
      for eServantIdx = 0, PaGlobal_CharacterSelect_All._eServantView.max do
        local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(charData, eServantIdx)
        if briefServantInfo ~= nil and briefServantInfo:isMasterlessHorse() == false then
          if 0 == eServantIdx then
            servantControl = stc_LandServant
            servantType = 0
            local servantKind = briefServantInfo:getServantKind()
            local servantKindSub = briefServantInfo:getServantKindSub()
            if 2 == servantKind and 2 == servantKindSub then
              local texturePath = "combine/icon/combine_basic_icon_01.dds"
              servantControl:ChangeTextureInfoNameAsync(texturePath)
              x1, y1, x2, y2 = setTextureUV_Func(servantControl, 136, 149, 156, 173)
              servantControl:getBaseTexture():setUV(x1, y1, x2, y2)
            end
          else
            servantControl = stc_SeaServant
            servantType = 1
          end
          SealedServantCount = SealedServantCount + 1
          if nil ~= servantControl then
            servantControl:SetShow(true)
            if false == PaGlobal_CharacterSelect_All._isUsePadSnapping then
              servantControl:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_ServantIconTooltip(true, " .. charIdx .. ", " .. eServantIdx .. "," .. servantType .. ")")
              servantControl:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_ServantIconTooltip(false)")
            end
          end
        end
      end
      stc_Delete:SetEnableArea(0, 0, stc_Delete:GetTextSizeX() + stc_Delete:GetSizeX(), stc_Delete:GetSizeY())
      if true == _ContentsGroup_UsePadSnapping then
        stc_Delete:SetShow(false)
        stc_DeleteConsole:SetShow(nil ~= removeTime)
        stc_DeleteIconConsole:SetShow(nil ~= removeTime)
      else
        stc_DeleteConsole:SetShow(false)
        stc_DeleteIconConsole:SetShow(false)
        stc_Delete:SetShow(nil ~= removeTime)
      end
      btnSlot:SetShow(true)
      stc_ClassIcon:SetShow(true)
      txt_Name:SetShow(true)
      txt_lv:SetShow(true)
      txt_Region:SetShow(true)
      if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
        stc_SeasonSlot:SetShow(charData._characterSeasonType == __eCharacterSeasonType_Season)
      end
      if ToClient_IsDuelCharacterByCharacterNo(charData._characterNo_s64) == true then
        stc_duelCharIcon:SetShow(true)
        stc_duelCharIcon:addInputEvent("Mouse_On", "HandleEventOn_CharacterSelect_All_DuelCharTooltip(true," .. charIdx .. ")")
        stc_duelCharIcon:addInputEvent("Mouse_Out", "HandleEventOn_CharacterSelect_All_DuelCharTooltip(false)")
      end
      local standardSpanSizeX = 365
      if stc_duelCharIcon:GetShow() then
        stc_duelCharIcon:SetSpanSize(standardSpanSizeX, stc_duelCharIcon:GetSpanSize().y)
        standardSpanSizeX = standardSpanSizeX - 22
      end
      if stc_SeaServant:GetShow() then
        stc_SeaServant:SetSpanSize(standardSpanSizeX, stc_SeaServant:GetSpanSize().y)
        standardSpanSizeX = standardSpanSizeX - 22
      end
      if stc_LandServant:GetShow() then
        stc_LandServant:SetSpanSize(standardSpanSizeX, stc_LandServant:GetSpanSize().y)
        standardSpanSizeX = standardSpanSizeX - 22
      end
    end
  elseif charIdx == haveCount then
    if haveCount < limitCount then
      btnSlot:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_CreateNewCharacter()")
      btnSlot:addInputEvent("Mouse_On", "HandleEventLOn_CharacterSelect_All_KeyGuideChange(" .. charIdx .. ", " .. tostring(PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER) .. ")")
      btnSlot:SetIgnore(false)
      btnSlot:SetShow(true)
      txt_AddIcon:SetShow(true)
      stc_UnlockIcon:SetShow(false)
      stc_LockIcon:SetShow(false)
    else
      btnSlot:SetIgnore(true)
      btnSlot:SetShow(true)
      txt_AddIcon:SetShow(false)
      stc_UnlockIcon:SetShow(false)
      stc_LockIcon:SetShow(true)
    end
  elseif charIdx < limitCount then
    btnSlot:SetIgnore(true)
    btnSlot:SetShow(true)
    txt_AddIcon:SetShow(false)
    stc_UnlockIcon:SetShow(true)
    stc_LockIcon:SetShow(false)
  else
    btnSlot:SetIgnore(true)
    btnSlot:SetShow(true)
    txt_AddIcon:SetShow(false)
    stc_UnlockIcon:SetShow(false)
    stc_LockIcon:SetShow(true)
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    local hardCoreData = getCharacterDataByIndex(charIdx, playerCreateType)
    if nil ~= hardCoreData then
      local isAccumulated = ToClient_getHardCoreCharacterAccumulated(hardCoreData._characterNo_s64)
      if isAccumulated == true then
        local checkLogin = ToClient_getHardCoreCharacterLoginPossible(hardCoreData._characterNo_s64)
        if checkLogin == __eHardCoreLoginCheckAccumulated then
          txt_Region:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_CHANGEPOINT_COMPLETE"))
        elseif checkLogin == __eHardCoreLoginCheckReset then
          txt_Region:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_WIDGET_ENTER"))
        end
      end
    end
  end
end
function PaGlobalFunc_CharacterSelectAll_PerFrameUpdate(deltaT)
  luaTimer_UpdatePerFrame(deltaT)
  PaGlobal_CharacterSelect_All._updateDelay = PaGlobal_CharacterSelect_All._updateDelay + deltaT
  if PaGlobal_CharacterSelect_All._updateDelay > 1 and true == PaGlobal_CharacterSelect_All._allAnimationFinished then
    PaGlobal_CharacterSelect_All._updateDelay = 0
    for characterIdx = 0, PaGlobal_CharacterSelect_All._playerData.useAbleCount - 1 do
      PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, characterIdx))
    end
    if -1 ~= PaGlobal_CharacterSelect_All._selectedCharIdx and PaGlobal_CharacterSelect_All._selectedCharIdx ~= nil then
      local removeTime = getCharacterDataRemoveTime(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._playerCreateType)
      if nil ~= removeTime then
        PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(nil, removeTime)
      else
        local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._playerCreateType)
        if nil ~= characterData then
          PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(characterData)
        end
      end
    end
  end
  if false == PaGlobal_CharacterSelect_All._animationPlayed then
    PaGlobal_CharacterSelect_All._timeElapsed = PaGlobal_CharacterSelect_All._timeElapsed + deltaT
    if PaGlobal_CharacterSelect_All._timeElapsed > PaGlobal_CharacterSelect_All._animationDelay and false == PaGlobal_CharacterSelect_All._listContentsShowAniFlag then
      PaGlobal_CharacterSelect_All._listContentsShowAniFlag = true
    end
    if 1 < PaGlobal_CharacterSelect_All._timeElapsed then
      PaGlobal_CharacterSelect_All._animationPlayed = true
      PaGlobal_CharacterSelect_All._allAnimationFinished = true
    end
  end
  if true == PaGlobal_CharacterSelect_All._listContentsShowAniFlag then
    PaGlobal_CharacterSelect_All:playListComponentsAni(deltaT)
  end
  for ii = 0, PaGlobal_CharacterSelect_All._listContentsCount do
    if true == PaGlobal_CharacterSelect_All._listContentsAlphaFlag[ii] then
      PaGlobal_CharacterSelect_All:animateListComponentsAlpha(deltaT, ii)
    end
    if true == PaGlobal_CharacterSelect_All._listContentsSlideFlag[ii] then
      PaGlobal_CharacterSelect_All:animateListComponentsSlide(deltaT, ii)
    end
  end
end
function PaGlobalFunc_CharacterSelect_All_ShowAni()
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    local ImageMoveAni = PaGlobal_CharacterSelect_All._ui.stc_RightBg:addMoveAnimation(0, 0.7, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
    ImageMoveAni:SetStartPosition(getScreenSizeX(), 0)
    ImageMoveAni:SetEndPosition(getScreenSizeX() - PaGlobal_CharacterSelect_All._ui.stc_RightBg:GetSizeX(), 0)
    ImageMoveAni.IsChangeChild = true
    PaGlobal_CharacterSelect_All._ui.stc_RightBg:CalcUIAniPos(ImageMoveAni)
  end
end
function PaGlobalFunc_CharacterSelect_All_FadeIn()
  if true == PaGlobal_CharacterSelect_All._isConsole then
    return
  end
  local fadeOutT = PaGlobal_CharacterSelect_All._enteringGameFadeOutTime
  local ImageAni = PaGlobal_CharacterSelect_All._ui.stc_Fade:addColorAnimation(0, fadeOutT, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_FF000000)
  ImageAni:SetEndColor(Defines.Color.C_00000000)
  ImageAni:SetHideAtEnd(true)
  PaGlobal_CharacterSelect_All._isBlockServerBack = false
end
function PaGlobalFunc_CharacterSelect_All_FadeOut()
  if true == PaGlobal_CharacterSelect_All._isConsole then
    return
  end
  local fadeOutT = PaGlobal_CharacterSelect_All._enteringGameFadeOutTime
  PaGlobal_CharacterSelect_All._ui.stc_Fade:SetShow(true)
  local ImageAni = PaGlobal_CharacterSelect_All._ui.stc_Fade:addColorAnimation(0, fadeOutT, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  ImageAni:SetStartColor(Defines.Color.C_00000000)
  ImageAni:SetEndColor(Defines.Color.C_FF000000)
  ImageAni:SetHideAtEnd(false)
  PaGlobal_CharacterSelect_All._isBlockServerBack = true
end
function HandleEventOn_CharacterSelect_All_OfflineModeTooltip(isShow)
  local self = PaGlobal_CharacterSelect_All
  if self == nil then
    return
  end
  if self._isUsePadSnapping == true then
    if isShow == true then
      self:SetKeyGuideShow(self._eKeyGuideType.ADD_NEWCHARACTER)
    end
  else
    if isShow == false then
      TooltipSimple_Hide()
      return
    end
    local title = PAGetString(Defines.StringSheet_GAME, "LUA_ENTERTOFIELDMODE_OFFLINE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_OFFLINE_TOOLTIP")
    TooltipSimple_Show(self._ui.chk_Ghost, title, desc)
  end
end
function HandleEventOnOut_CharacterSelect_All_CharacterCountGuide(isShow)
  if true == isShow then
    local playerCreateType = __ePlayerCreateNormal
    if self._ui.rdo_Special:IsCheck() == true then
      playerCreateType = __ePlayerCreatePremium
    elseif self._ui.rdo_HardCore:IsCheck() == true then
      playerCreateType = __ePlayerCreateHardCore
    else
      playerCreateType = __ePlayerCreateNormal
    end
    local maxSlot = getCharacterSlotMaxCount(playerCreateType)
    local limitCount = getCharacterSlotLimit(playerCreateType)
    local haveCount = getCharacterDataCount(playerCreateType)
    local title = "\236\186\144\235\166\173\237\132\176 \236\138\172\235\161\175 \236\136\152"
    local desc = ""
    local desc1 = "\236\186\144\235\166\173\237\132\176 \236\138\172\235\161\175 \236\136\152\235\167\140\237\129\188 \236\186\144\235\166\173\237\132\176\235\165\188 \236\131\157\236\132\177\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164."
    local desc2 = "\236\186\144\235\166\173\237\132\176 \236\138\172\235\161\175\236\157\128 \237\142\132 \236\131\129\236\160\144\236\151\144\236\132\156 \237\140\144\235\167\164\237\149\152\235\138\148 <PAColor0xFFFFC832>[\236\186\144\235\166\173\237\132\176 \236\138\172\235\161\175 \237\153\149\236\158\165\234\182\140]<PAOldColor>\236\156\188\235\161\156 \237\153\149\236\158\165\237\149\160 \236\136\152 \236\158\136\236\138\181\235\139\136\235\139\164(\237\152\132\236\158\172 <PAColor0xFFFFC832>" .. maxSlot - limitCount .. "<PAOldColor>\234\176\156\236\157\152 \236\138\172\235\161\175 <PAColor0xFF96D4FC>\237\153\149\236\158\165 \234\176\128\235\138\165<PAOldColor>)."
    if limitCount == maxSlot or playerCreateType ~= __ePlayerCreateNormal then
      desc = desc1
    else
      desc = desc1 .. " " .. desc2
    end
    TooltipSimple_Show(PaGlobal_CharacterSelect_All._ui.stc_CharacterCountGuide, title, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOn_CharacterSelect_All_ServantIconTooltip(isShow, charDataIdx, servantIdx, servantType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(charDataIdx, __ePlayerCreateNormal)
  if nil == characterData then
    return
  end
  local briefServantInfo = ToClient_GetBriefServantInfoByCharacter(characterData, servantIdx)
  if nil == briefServantInfo then
    return
  end
  local name = briefServantInfo:getName()
  local desc = HandleEventOn_CharacterSelect_All_GetServantTooltipText(briefServantInfo)
  local control
  if 0 == servantType then
    control = UI.getChildControl(PaGlobal_CharacterSelect_All._listContents[charDataIdx], "Static_ServantView_Ground")
  else
    control = UI.getChildControl(PaGlobal_CharacterSelect_All._listContents[charDataIdx], "Static_ServantView_Sea")
  end
  if nil ~= control then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOn_CharacterSelect_All_DuelCharTooltip(isShow, charDataIdx)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local characterData = getCharacterDataByIndex(charDataIdx, __ePlayerCreateNormal)
  if nil == characterData then
    return
  end
  if ToClient_IsDuelCharacterByCharacterNo(characterData._characterNo_s64) == false then
    return
  end
  local duelCharacterName = ""
  local duelCharacterCount = ToClient_GetMyDuelCharacterCount()
  if duelCharacterCount <= 0 then
    return
  end
  for idx = 0, duelCharacterCount - 1 do
    local duelCharacterData = ToClient_GetDuelCharacterDataByIndex(idx)
    if duelCharacterData ~= nil and characterData._characterNo_s64 ~= duelCharacterData._characterNo_s64 then
      if duelCharacterName == "" then
        duelCharacterName = tostring(getCharacterName(duelCharacterData))
      else
        duelCharacterName = duelCharacterName .. ", " .. tostring(getCharacterName(duelCharacterData))
      end
    end
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_GAME_DUELCHARICON_TOOLTIP_NAME")
  local desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAME_DUELCHARICON_TOOLTIP_DESC", "Charactername", duelCharacterName)
  local control = UI.getChildControl(PaGlobal_CharacterSelect_All._listContents[charDataIdx], "Static_OriginalCha")
  if nil ~= control then
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOn_CharacterSelect_All_GetServantTooltipText(briefServantInfo)
  if nil == briefServantInfo then
    return
  end
  local servantKind = briefServantInfo:getServantKind()
  local servantCharacterKeyRaw = briefServantInfo:getServantCharacterKeyRaw()
  local strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_" .. servantKind)
  if 31053 == briefServantInfo:getServantCharacterKeyRaw() then
    strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_15_1")
  end
  if 2 == servantKind then
    local servantSubKind = briefServantInfo:getServantKindSub()
    if 2 == servantSubKind then
      strKind = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_SERVANTKIND_2_2")
    end
  end
  local isFantasyHorse = PaGlobal_CheckFantasyHorse(servantCharacterKeyRaw)
  local strText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_KIND", "kind", strKind)
  if false == isFantasyHorse then
    if CppEnums.ServantKind.Type_Horse == servantKind and true == briefServantInfo:isMale() then
      strText = strText .. "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GENDER_MALE") .. ")"
    elseif CppEnums.ServantKind.Type_Horse == servantKind and false == briefServantInfo:isMale() then
      strText = strText .. "(" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_GENDER_FEMALE") .. ")"
    end
  end
  local level = briefServantInfo:getLevel()
  if level > 0 then
    strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_LEVEL", "level", level)
  end
  if CppEnums.ServantKind.Type_Horse == servantKind or CppEnums.ServantKind.Type_RaceHorse == servantKind then
    local tier = briefServantInfo:getTier()
    if tier > 0 then
      local tierName = ToClient_GetDisplayTierName(servantCharacterKeyRaw)
      strText = strText .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TOOLTIP_TIER", "tier", tierName)
    end
  end
  return strText
end
function HandleEventLUp_CharacterSelect_All_CreateNewCharacter()
  if MessageBoxGetShow() then
    return
  end
  local do_Create = function()
    local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
    if true == PaGlobal_CharacterSelect_All._isConsole then
      local isChecked = PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
      if true == isChecked then
        PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
        if PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
          PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED)
        else
          PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT)
        end
        PaGlobal_CharacterSelect_All:update()
      end
    end
    if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and nil ~= PaGlobalFunc_Customization_SetSeasonBtnShow then
      if playerCreateType == __ePlayerCreateNormal and true == PaGlobal_CharacterSelect_All._canMakeSeason then
        PaGlobalFunc_Customization_SetSeasonBtnShow(true)
      else
        PaGlobalFunc_Customization_SetSeasonBtnShow(false)
      end
    end
    if false == PaGlobal_Season_Character_Create:prepareOpen(playerCreateType) then
      FGlobal_SetPlayerCreateType(playerCreateType)
      changeCreateCharacterMode_SelectClass(playerCreateType)
    end
    if _ContentsOption_CH_GPM == true then
      ToClient_reportChinaGPM(__eReportSceneConfirmCreateCharacter, true)
    end
  end
  local MessageData = {
    title = nil,
    content = nil,
    functionYes = nil,
    functionApply = nil,
    functionNo = nil,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if PaGlobal_CharacterSelect_All._playerCreateType == __ePlayerCreatePremium then
    if PaGlobal_CharacterSelect_All._playerData.haveCount < PaGlobal_CharacterSelect_All._playerData.maxSlot then
      MessageData.title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_BTN")
      MessageData.content = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_NOTIFY")
      MessageData.functionYes = do_Create
      MessageData.functionNo = MessageBox_Empty_function
    elseif PaGlobal_CharacterSelect_All._playerData.haveCount == PaGlobal_CharacterSelect_All._playerData.maxSlot then
      MessageData.title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATEMSGBOXTITLE")
      MessageData.content = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATEMSGBOXDESC1")
      MessageData.functionApply = MessageBox_Empty_function
      MessageBox.showMessageBox(MessageData)
      return
    end
  elseif PaGlobal_CharacterSelect_All._playerData.haveCount < PaGlobal_CharacterSelect_All._playerData.useAbleCount then
    MessageData.title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_BTN")
    MessageData.content = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_NOTIFY")
    MessageData.functionYes = do_Create
    MessageData.functionNo = MessageBox_Empty_function
  elseif PaGlobal_CharacterSelect_All._playerData.haveCount == PaGlobal_CharacterSelect_All._playerData.maxSlot then
    MessageData.title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATEMSGBOXTITLE")
    MessageData.content = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATEMSGBOXDESC1")
    MessageData.functionApply = MessageBox_Empty_function
    MessageBox.showMessageBox(MessageData)
    return
  elseif PaGlobal_CharacterSelect_All._playerData.haveCount == PaGlobal_CharacterSelect_All._playerData.useAbleCount then
    MessageData.title = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATEMSGBOXTITLE")
    MessageData.content = PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATEMSGBOXDESC2")
    MessageData.functionApply = MessageBox_Empty_function
    MessageBox.showMessageBox(MessageData)
    return
  end
  local isHardCoreChannel = _ContentsGroup_HardCoreChannel == true and ToClient_isHardCoreChannel()
  if isHardCoreChannel == true and PaGlobal_CharacterSelect_All._playerCreateType == __ePlayerCreateHardCore then
    local joinPossible = ToClient_isHardCoreChannelEnterPossible()
    if joinPossible == false then
      local level = ToClient_isHardCoreChannelEnterPossibleLevel()
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CHARACTERSELECT_HARDCORE"),
        content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HARDCORECHANNEL_CANTPLAY_NOTIFY", "level", level),
        functionApply = resetSelectChannel,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
        functionYes = MessageBox_Empty_function
      }
      MessageBox.showMessageBox(messageBoxData)
      return
    end
  end
  PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_BTN"), PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERSELECT_CREATENEWCHARACTER_NOTIFY"), do_Create, MessageBox_Empty_function, nil, nil)
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportSceneClickCreateCharacter, true)
  end
end
function HandleEventLOn_CharacterSelect_All_KeyGuideChange(charIdx, type)
  PaGlobal_CharacterSelect_All:SetKeyGuideShow(type)
  HandleEventOn_CharacterSelect_All_CharacterOver(charIdx)
end
function HandleEventOn_CharacterSelect_All_CharacterOver(charIdx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  TooltipSimple_Hide()
  if nil ~= PaGlobal_CharacterSelect_All._currentOveredCharIdx and nil ~= charIdx and charIdx ~= PaGlobal_CharacterSelect_All._currentOveredCharIdx then
    local prevIdx = PaGlobal_CharacterSelect_All._currentOveredCharIdx
    PaGlobal_CharacterSelect_All._currentOveredCharIdx = charIdx
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, prevIdx))
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, PaGlobal_CharacterSelect_All._currentOveredCharIdx))
  end
  HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(false)
end
function HandleEventOn_CharacterSelect_All_CharacterOut()
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if nil ~= PaGlobal_CharacterSelect_All._currentOveredCharIdx and nil ~= charIdx and charIdx == PaGlobal_CharacterSelect_All._currentOveredCharIdx then
    for ii = 1, PaGlobal_CharacterSelect_All._listContentsCount do
      PaGlobal_CharacterSelect_All._listContentsSlideTarget[ii] = PaGlobal_CharacterSelect_All._listContentsBaseX
      PaGlobal_CharacterSelect_All._listContentsSlideFlag[ii] = true
    end
  end
end
function HandleEventLUp_CharacterSelect_All_CharacterSelect(charIdx, initialSelect)
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local charData = getCharacterDataByIndex(charIdx, playerCreateType)
  local prevIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
  if nil ~= charData then
    local classType = getCharacterClassType(charData)
    local removeTime = getCharacterDataRemoveTime(charIdx, playerCreateType)
    local isDeleting = nil ~= removeTime
    local isSeasonCharacter = charData._characterSeasonType == __eCharacterSeasonType_Season
    if true == _ContentsGroup_SeasonContents then
      if playerCreateType == __ePlayerCreateNormal then
        PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(isSeasonCharacter)
      end
    else
      PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
    end
    PaGlobal_CharacterSelect_All._isSelectDeletingChar = isDeleting
    PaGlobal_CharacterSelect_All._ui.btn_Delete:SetEnable(not isDeleting)
    PaGlobal_CharacterSelect_All._ui.btn_Delete:SetMonoTone(isDeleting, isDeleting)
    if true == isDeleting then
      PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(nil, removeTime)
    else
      PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(charData, nil)
    end
    PaGlobal_CharacterSelect_All._prevSelectedCharIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
    PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, PaGlobal_CharacterSelect_All._prevSelectedCharIdx))
    PaGlobal_CharacterSelect_All._ui.list2_Character:requestUpdateByKey(toInt64(0, PaGlobal_CharacterSelect_All._selectedCharIdx))
    if true == initialSelect or prevIdx ~= PaGlobal_CharacterSelect_All._selectedCharIdx then
      PaGlobal_CharacterSelect_All:setCharacterView(PaGlobal_CharacterSelect_All._selectedCharIdx, classType, playerCreateType, false)
      local charName = getCharacterName(charData)
      PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText(charName)
    end
    _AudioPostEvent_SystemUiForXBOX(50, 1)
  else
    PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText("")
  end
  PaGlobal_CharacterSelect_All._ui.stc_SeasonBg:SetShow(false)
  local content = PaGlobal_CharacterSelect_All._ui.list2_Character:GetContentByKey(toInt64(0, charIdx))
  if content ~= nil then
    local btnSlot = UI.getChildControl(content, "Button_CharacterSlot")
    local btn_Enter = UI.getChildControl(btnSlot, "Button_Enter")
    local removeTime = getCharacterDataRemoveTime(charIdx, playerCreateType)
    if removeTime ~= nil or PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() == true then
      btn_Enter:SetShow(false)
      PaGlobal_CharacterSelect_All._ui.btn_GamePlay:SetMonoTone(true)
      PaGlobal_CharacterSelect_All._ui.btn_GamePlay:SetEnable(false)
    else
      btn_Enter:SetShow(true)
      PaGlobal_CharacterSelect_All._ui.btn_GamePlay:SetMonoTone(false)
      PaGlobal_CharacterSelect_All._ui.btn_GamePlay:SetEnable(true)
    end
    if PaGlobal_CharacterSelect_All._isUsePadSnapping == true then
      btn_Enter:SetShow(false)
    end
    btn_Enter:addInputEvent("Mouse_LUp", "HandleEventLUp_CharacterSelect_All_PrepareEnterToField(" .. charIdx .. ")")
  end
end
function PaGlobalFunc_CharacterSelect_All_UpdateChracterStatus(charData, removeTime)
  if nil == charData and nil ~= removeTime then
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTER_DELETE") .. " ( " .. removeTime .. " )")
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFD05D48)
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    local loginPossible = ToClient_getHardCoreCharacterLoginPossible(charData._characterNo_s64)
    if loginPossible == __eHardCoreLoginCheckReset or loginPossible == __eHardCoreLoginCheckRemainPlayTime then
      reasonText = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENTER_TO_FIELD")
    elseif loginPossible == __eHardCoreLoginCheckPlayTimeEmpty then
      reasonText = PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSnailMinorPlayTimeEmpty")
    elseif loginPossible == __eHardCoreLoginCheckAccumulated then
      reasonText = PAGetString(Defines.StringSheet_GAME, "LUA_HARDCORE_CHANGEPOINT_COMPLETE_STATE")
    end
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(reasonText)
    return
  end
  local firstTicketNo = getFirstTicketNoByAll()
  local currentTicketN = getCurrentTicketNo()
  local ticketCountByRegion = charData._lastTicketNoByRegion
  local classType = getCharacterClassType(charData)
  local isPossibleClass = ToClient_IsCustomizeOnlyClass(classType)
  local text = ""
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFF5BA3A)
  if Defines.s64_const.s64_m1 ~= firstTicketNo or Defines.s64_const.s64_m1 ~= ticketCountByRegion then
    PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFD05D48)
    text = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NOT_ENTER_TO_FIELD")
  elseif true == isPossibleClass then
    text = ""
  else
    text = PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_ENTER_TO_FIELD")
  end
  local serverUtc64 = getServerUtc64()
  if charData._arrivalRegionOrWaypointKey ~= 0 and serverUtc64 < charData._arrivalTime then
    local remainTime = charData._arrivalTime - serverUtc64
    local strTime = convertStringFromDatetime(remainTime)
    text = text .. "\n" .. PAGetString(Defines.StringSheet_GAME, "CHARACTER_WORKING_TEXT_DELIVERY") .. " : " .. strTime
  end
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(text)
end
function PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
  return PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:IsCheck()
end
function HandleEventLUp_CharacterSelect_All_Deleting()
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local currentSelectIdx = PaGlobal_CharacterSelect_All._selectedCharIdx
  if -1 ~= currentSelectIdx then
    local charData = getCharacterDataByIndex(currentSelectIdx, playerCreateType)
    local removeTime = getCharacterDataRemoveTime(currentSelectIdx, playerCreateType)
    if nil ~= removeTime or nil == charData then
      return
    end
    local function do_Delete()
      _AudioPostEvent_SystemUiForXBOX(50, 1)
      deleteCharacter(currentSelectIdx, playerCreateType)
    end
    local removeTimeCheckLevel = getCharacterRemoveTimeCheckLevel()
    local removeTime
    if removeTimeCheckLevel > charData._level or playerCreateType ~= __ePlayerCreateNormal then
      removeTime = Int64toInt32(getLowLevelCharacterRemoveDate())
    else
      removeTime = Int64toInt32(getCharacterRemoveDate())
    end
    local characterNameRestoreTime = Int64toInt32(getNameRemoveDate())
    local remainTime = convertStringFromDatetime(toInt64(0, characterNameRestoreTime - removeTime))
    if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and charData._characterSeasonType == __eCharacterSeasonType_Season then
      local seasonDeleteTime = getSeasonCharacterRemoveDate()
      removeTime = Int64toInt32(seasonDeleteTime)
      remainTime = convertStringFromDatetime(seasonDeleteTime)
    end
    if _ContentsGroup_HardCoreChannel == true and charData._playerCreateType == __ePlayerCreateHardCore then
      local hardCoreDeleteTime = getHardCoreCharacterRemoveDate()
      removeTime = Int64toInt32(hardCoreDeleteTime)
      remainTime = convertStringFromDatetime(hardCoreDeleteTime)
    end
    local messageContent = PAGetStringParam3(Defines.StringSheet_GAME, "CHARACTER_LATER_DELETE_MESSAGEBOX_MEMO", "removeTime", convertStringFromDatetime(toInt64(0, removeTime)), "characterName", getCharacterName(charData), "remainTime", remainTime)
    if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and charData._characterSeasonType == __eCharacterSeasonType_Season then
      messageContent = messageContent .. [[
 

 ]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CHARACTER_DELETE")
    end
    PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "CHARACTER_DELETE_MESSAGEBOX_TITLE"), messageContent, do_Delete, MessageBox_Empty_function, nil, nil)
  end
end
function HandleEventLUp_CharacterSelect_All_CancelDeleting(charIdx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished or -1 == charIdx then
    return
  end
  if -1 == charIdx then
    return
  end
  if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
    PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
  end
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local function deleteCharacterComplete()
    deleteCancelCharacter(charIdx, playerCreateType)
  end
  local characterData = getCharacterDataByIndex(charIdx, playerCreateType)
  local charName = getCharacterName(characterData)
  PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CHARACTERDELETE_CANCEL_CONFIRM_MSG", "charName", tostring(charName)), deleteCharacterComplete, MessageBox_Empty_function, nil, nil)
end
function HandleEventLUp_CharacterSelect_All_BackToServerSelect()
  if true == PaGlobal_CharacterSelect_All._isBlockServerBack then
    return
  end
  if ToClient_IsBannedGoBackServerSelect() == true then
    return
  end
  if true == PaGlobal_CharacterSelect_All._isUsePadSnapping then
    local isChecked = PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
    if true == isChecked then
      PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
      if PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED)
      elseif PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_NOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT)
      elseif PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.ADD_NEWCHARACTER)
      end
      PaGlobal_CharacterSelect_All:update()
      return
    end
  end
  PaGlobal_CharacterSelect_All:prepareClose()
  backServerSelect()
end
function HandleEventLUp_CharacterSelect_All_PrepareEnterToField(charIdx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if true == PaGlobal_CharacterSelect_All._isConsole and true == PaGlobal_CharacterSelect_All._isSelectDeletingChar then
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 8)
  if ToClient_isDataDownloadStart() then
    local isComplete = ToClient_isDataDownloadComplete()
    local percent = ToClient_getDataDownloadProgress()
    if false == isComplete then
      PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MESSAGEBOX_XBOX_DATAINSTALLATION_DESC") .. tostring(percent), nil, nil, MessageBox_Empty_function, nil)
      return
    end
  end
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local characterData = getCharacterDataByIndex(charIdx, playerCreateType)
  if nil == characterData then
    return
  end
  local lastEnterServerNo = characterData._lastEnterServerNo
  local lastLogoutTime = characterData._lastLogoutTime
  local lastLogInTime = characterData._lastLogInTime
  local classType = getCharacterClassType(characterData)
  if true == ToClient_IsCustomizeOnlyClass(classType) then
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_2")
    PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), desc, nil, nil, MessageBox_Empty_function, nil)
    return
  end
  local enterFieldType = ToClient_CheckEnterToCharacter(charIdx, playerCreateType)
  if __eLobby_Count == enterFieldType then
    return
  end
  local isSeasonCharacter = characterData._characterSeasonType == __eCharacterSeasonType_Season
  if true == _ContentsGroup_SeasonContents then
    local isSeasonChannel = ToClient_isSeasonChannel()
    if false == isSeasonCharacter and true == isSeasonChannel and false == ToClient_SelfPlayerIsGM() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_ACCESS"))
      return
    end
  elseif true == _ContentsGroup_PreSeason and true == isSeasonCharacter then
    PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_SEASONCONTENT_CANNOT_PLAY"), nil, nil, MessageBox_Empty_function, nil)
    return
  end
  if __eLobby_NoEnterToField == enterFieldType then
    return
  else
    if __eLobby_FirstSpawnCharacterLogin == enterFieldType then
      PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
      FGlobal_FirstLogin_Open(charIdx)
    elseif __eLobby_CharacterState == enterFieldType then
      local function enterGame()
        PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
        PaGlobal_CharacterSelect_All:enableEnterBtn(false)
        PaGlobalFunc_CharacterSelect_All_EnterToField()
      end
      local contentString = ToClient_GetEnterGameMessage(charIdx, playerCreateType)
      PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"), contentString, enterGame, MessageBox_Empty_function, nil, nil)
    elseif __eLobby_EnterToField == enterFieldType then
      PaGlobal_CharacterSelect_All._selectedCharIdx = charIdx
      local function tutorialSkipEnterGame()
        if _ContentsGroup_SelectStartPosition == true then
          PaGlobalFunc_StartBranch_All_SelectOpen(charIdx)
        else
          ToClient_NewSequenceTutorialSkipChangeStartPosition(true, __eQuestTutorialBranch_0, charIdx)
        end
      end
      local function enterTutorial()
        ToClient_NewSequenceTutorialSkipChangeStartPosition(false, __eQuestTutorialBranch_0, charIdx)
      end
      if true == _ContentsGroup_NewSequenceTutorial then
        local isTutorialComplete = ToClient_NewSequenceTutorialComplete(charIdx)
        local isHystriaTutorialComplete = ToClient_NewSequenceHystriaTutorialComplete(charIdx)
        local isNeedTutorial = ToClient_NewSequenceNeedTutorial(charIdx)
        local isMultiNationChampionshipServer = false
        local curChannelData = getCurrentChannelServerData()
        if curChannelData ~= nil and curChannelData:isMultiNationChampionshipServer() == true then
          isMultiNationChampionshipServer = true
        end
        if 1 == characterData._level and PaGlobal_CharacterSelect_All._playerCreateType == __ePlayerCreateNormal and isMultiNationChampionshipServer == false then
          if true == isTutorialComplete then
            PaGlobal_CharacterSelect_All:normalEnterGame(charIdx)
          elseif true == isHystriaTutorialComplete then
            tutorialSkipEnterGame()
          elseif true == ToClient_isSequenceTutorialSkipAble(charIdx) then
            local skipAbleTitle = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_SKIP_TITLE")
            local skipAbleString = PAGetString(Defines.StringSheet_GAME, "LUA_TUTORIAL_SKIP_MSG")
            if true == _ContentsGroup_UsePadSnapping then
              PaGlobal_CharacterSelect_All:SetMsgDataAndShow(skipAbleTitle, skipAbleString, enterTutorial, tutorialSkipEnterGame, nil, CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0, true)
            else
              PaGlobal_CharacterSelect_All:SetMsgDataAndShow(skipAbleTitle, skipAbleString, enterTutorial, tutorialSkipEnterGame, nil, CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_0, false)
            end
          else
            enterTutorial()
          end
        elseif characterData._level >= 2 and lastLogoutTime == lastLogInTime and PaGlobal_CharacterSelect_All._playerCreateType == __ePlayerCreateNormal and isMultiNationChampionshipServer == false then
          tutorialSkipEnterGame()
        elseif _ContentsGroup_HardCoreChannel == true and PaGlobal_CharacterSelect_All._playerCreateType == __ePlayerCreateHardCore then
          PaGlobal_CharacterSelect_All:hardCoreCharacterLogin(charIdx)
        else
          PaGlobal_CharacterSelect_All:normalEnterGame(charIdx)
        end
      else
        PaGlobal_CharacterSelect_All:normalEnterGame(charIdx)
      end
    end
    local temporaryWrapper = getTemporaryInformationWrapper()
    temporaryWrapper:setGhostMode(PaGlobal_CharacterSelect_All._ui.chk_Ghost:IsCheck())
    if _ContentsOption_CH_GPM == true then
      ToClient_reportChinaGPM(__eReportSceneClickEnterGameButton, true)
    end
  end
end
function FromClient_CharacterSelect_All_ChangeStartPositionByTutorialSkip(isSucceced)
  if isSucceced == false then
  end
  PaGlobalFunc_CharacterSelect_All_FadeOut()
  PaGlobal_CharacterSelect_All:enableEnterBtn(false)
  luaTimer_AddEvent(PaGlobalFunc_CharacterSelect_All_TryLogin, PaGlobal_CharacterSelect_All._enteringGameFadeOutTime * 1000, false, 0)
end
function PaGlobalFunc_CharacterSelect_All_TryLogin()
  if false == selectCharacter(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._playerCreateType) then
    PaGlobal_CharacterSelect_All:enableEnterBtn(true)
    PaGlobalFunc_CharacterSelect_All_FadeIn()
  end
end
function PaGlobalFunc_CharacterSelect_All_EnterToField()
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, playerCreateType)
  local classType = getCharacterClassType(characterData)
  if nil ~= characterData then
    if true == ToClient_IsCustomizeOnlyClass(classType) then
      local desc = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1") .. PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_2")
      PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"), desc, nil, nil, MessageBox_Empty_function, nil)
    else
      PaGlobal_CharacterSelect_All:enableEnterBtn(false)
      if true == PaGlobal_CharacterSelect_All._isConsole then
        Panel_GamerTag:ComputePos()
      end
      selectCharacter(PaGlobal_CharacterSelect_All._selectedCharIdx, playerCreateType)
    end
  end
end
function PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  return PaGlobal_CharacterSelect_All._currentTab
end
function HandleEventLUp_CharacterSelect_All_TabClick(idx)
  if false == PaGlobal_CharacterSelect_All._allAnimationFinished then
    return
  end
  if true == PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() then
    PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
  end
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText("")
  if idx ~= PaGlobal_CharacterSelect_All._currentTab then
    if PaGlobal_CharacterSelect_All._isUsePadSnapping then
      PaGlobal_CharacterSelect_All._ui.rdo_Normal:SetCheck(PaGlobal_CharacterSelect_All._TABTYPE._NORMAL == idx)
      PaGlobal_CharacterSelect_All._ui.rdo_Special:SetCheck(PaGlobal_CharacterSelect_All._TABTYPE._PREMIUM == idx)
      PaGlobal_CharacterSelect_All._ui.rdo_HardCore:SetCheck(PaGlobal_CharacterSelect_All._TABTYPE._HARDCORE == idx)
      ToClient_padSnapResetControl()
    end
    if PaGlobal_CharacterSelect_All._ui.rdo_Special:IsCheck() == true then
      PaGlobal_CharacterSelect_All._playerCreateType = __ePlayerCreatePremium
    elseif PaGlobal_CharacterSelect_All._ui.rdo_HardCore:IsCheck() == true then
      PaGlobal_CharacterSelect_All._playerCreateType = __ePlayerCreateHardCore
    else
      PaGlobal_CharacterSelect_All._playerCreateType = __ePlayerCreateNormal
    end
    PaGlobal_CharacterSelect_All._selectedCharIdx = 0
    PaGlobal_CharacterSelect_All._prevSelectedCharIdx = -1
    FGlobal_SetPlayerCreateType(PaGlobal_CharacterSelect_All._playerCreateType)
    local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, PaGlobal_CharacterSelect_All._playerCreateType)
    if nil ~= characterData then
      local classType = getCharacterClassType(characterData)
      PaGlobal_CharacterSelect_All:setCharacterView(PaGlobal_CharacterSelect_All._selectedCharIdx, classType, PaGlobal_CharacterSelect_All._playerCreateType, false)
      local charName = getCharacterName(characterData)
      PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText(charName)
    else
      PaGlobal_CharacterSelect_All._selectedCharIdx = -1
      PaGlobal_CharacterSelect_All:setCharacterView(0, nil, PaGlobal_CharacterSelect_All._playerCreateType, false)
      PaGlobal_CharacterSelect_All._ui.txt_CharacterName:SetText("")
    end
    PaGlobal_CharacterSelect_All._currentTab = idx
    HandleEventLUp_CharacterSelect_All_CharacterSelect(PaGlobal_CharacterSelect_All._selectedCharIdx, false)
    PaGlobal_CharacterSelect_All:update()
  end
end
function HandleEventLBRB_CharacterSelect_All_TabChange(value)
  local idxToChange = PaGlobal_CharacterSelect_All._currentTab + value
  if ToClient_HardCoreChannelWithContensOption() == true then
    if PaGlobal_CharacterSelect_All._currentTab == PaGlobal_CharacterSelect_All._TABTYPE._HARDCORE then
      return
    end
    idxToChange = PaGlobal_CharacterSelect_All._TABTYPE._HARDCORE
  elseif idxToChange < PaGlobal_CharacterSelect_All._TABTYPE._NORMAL then
    idxToChange = PaGlobal_CharacterSelect_All._TABTYPE._PREMIUM
  elseif idxToChange > PaGlobal_CharacterSelect_All._TABTYPE._PREMIUM then
    idxToChange = PaGlobal_CharacterSelect_All._TABTYPE._NORMAL
  end
  HandleEventLUp_CharacterSelect_All_TabClick(idxToChange)
end
function HandleEventOnOut_CharacterSelect_All_LobbyCharacterCursor(isOn)
  ToClient_SetLobbyCharacterCursor(isOn)
end
function HandleEventLUp_CharacterSelect_All_ExitGame()
  local do_Exit = function()
    disConnectToGame()
    GlobalExitGameClient()
  end
  PaGlobal_CharacterSelect_All:SetMsgDataAndShow(PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_TITLE"), PAGetString(Defines.StringSheet_GAME, "GAME_EXIT_MESSAGEBOX_MEMO"), do_Exit, MessageBox_Empty_function, nil, nil)
end
function FromClient_ChracterSelect_All_CancelEnterWating()
  if true == PaGlobal_CharacterSelect_All._playerData.isWaitLine then
    MessageBox_HideAni()
    PaGlobal_CharacterSelect_All._playerData.isWaitLine = false
  end
end
function FromClient_ChracterSelect_All_ReceiveWaiting()
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  PaGlobal_CharacterSelect_All._playerData.isWaitLine = true
  local characterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, playerCreateType)
  if nil == characterData then
    UI.ASSERT(false, "\236\186\144\235\166\173\237\132\176 \236\132\160\237\131\157 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164!")
    return
  end
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetFontColor(Defines.Color.C_FFD05D48)
  PaGlobal_CharacterSelect_All._ui.txt_CharacterStatus:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_GAMEEXIT_NOT_ENTER_TO_FIELD"))
  local strWaitingMsg = PaGlobalFunc_CharacterSelect_All_MakeWaitingUserMsg(characterData._lastTicketNoByRegion)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "CHARACTER_ENTER_WAITING_TITLE"),
    content = strWaitingMsg,
    functionCancel = PaGlobalFunc_CharacterSelectRemaster_ClickCancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1m,
    enablePriority = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function FromClient_ChracterSelect_All_SetWaitingUserCount()
  if false == PaGlobal_CharacterSelect_All._playerData.isWaitLine then
    return
  end
  local strWaitingMsg = PaGlobalFunc_CharacterSelect_All_MakeWaitingUserMsg(-1)
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "CHARACTER_ENTER_WAITING_TITLE"),
    content = strWaitingMsg,
    functionCancel = PaGlobalFunc_CharacterSelectRemaster_ClickCancel,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_1m,
    enablePriority = true
  }
  if true == MessageBox.doHaveMessageBoxData(messageboxData.title) then
    setCurrentMessageData(messageboxData)
  else
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobalFunc_CharacterSelectRemaster_ClickCancel()
  sendEnterWaitingCancel()
  PaGlobal_CharacterSelect_All:enableEnterBtn(true)
  PaGlobalFunc_CharacterSelect_All_FadeIn()
end
function PaGlobalFunc_CharacterSelect_All_MakeWaitingUserMsg(receiveTicketNoMyRegion)
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  local ticketCountByRegion = receiveTicketNoMyRegion
  if -1 == ticketCountByRegion then
    local selectedCharacterData = getCharacterDataByIndex(PaGlobal_CharacterSelect_All._selectedCharIdx, playerCreateType)
    local regionInfo = getRegionInfoByPosition(selectedCharacterData._currentPosition)
    local regionGroupKey = 1
    if nil ~= regionInfo then
      regionGroupKey = regionInfo:getRegionGroupKey()
    end
    ticketCountByRegion = getTicketCountByRegion(regionGroupKey)
  end
  local currentTicketNo = getCurrentTicketNo()
  local firstTicketNoByAll = getFirstTicketNoByAll()
  local totalWaitingPlayerCount = getAllWaitingLine() - getAllCancelCount()
  local myRegionWaitingPlayerCount = getMyWaitingLine() - getCancelCount()
  if totalWaitingPlayerCount < 0 then
    totalWaitingPlayerCount = 0
  end
  if myRegionWaitingPlayerCount <= 0 then
    myRegionWaitingPlayerCount = 0
  end
  local waitMsg = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WAIT_MESSAGE")
  local serverWaitStr = PAGetStringParam1(Defines.StringSheet_GAME, "CHARACTER_SERVER_WAIT_COUNT", "iCount", tostring(totalWaitingPlayerCount))
  local regionWaitStr = PAGetStringParam1(Defines.StringSheet_GAME, "CHARACTER_REGION_WAIT_COUNT", "iCount", tostring(myRegionWaitingPlayerCount))
  local emptyStr = PAGetString(Defines.StringSheet_GAME, "CHARACTER_WAITING_PLAYER_EMPTY")
  local taiwanMsg = ""
  if Defines.s64_const.s64_m1 == firstTicketNoByAll and Defines.s64_const.s64_m1 ~= ticketCountByRegion then
    strWaitingMsg = waitMsg .. [[


]] .. regionWaitStr .. taiwanMsg
  elseif Defines.s64_const.s64_m1 == ticketCountByRegion and Defines.s64_const.s64_m1 ~= firstTicketNoByAll or Defines.s64_const.s64_m1 ~= ticketCountByRegion and 0 == myRegionWaitingPlayerCount then
    strWaitingMsg = waitMsg .. [[


]] .. serverWaitStr .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "CHARACTER_REGION_WAIT_TEXT") .. emptyStr .. taiwanMsg
  else
    strWaitingMsg = waitMsg .. [[


]] .. serverWaitStr .. [[


]] .. regionWaitStr .. taiwanMsg
  end
  return strWaitingMsg
end
function PaGlobalFunc_CharacterSelect_All_CanMakeSeason()
  if nil == Panel_CharacterSelect_All then
    return false
  end
  return PaGlobal_CharacterSelect_All._canMakeSeason
end
function PaGlobalFunc_CharacterSelect_All_CheckAndSetPadUI()
  if nil == Panel_CharacterSelect_All then
    return
  end
  PaGlobal_CharacterSelect_All:CheckAndSetPadUI()
end
function SavePlayGoEssentialFiles()
  ToClient_savePlayGoEssentialFiles()
end
function HandleEventLUp_CharacterSelect_All_ClickGamePlay()
  local self = PaGlobal_CharacterSelect_All
  if self == nil then
    return
  end
  if PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick() == true then
    return
  end
  HandleEventLUp_CharacterSelect_All_PrepareEnterToField(PaGlobal_CharacterSelect_All._selectedCharIdx)
end
function HandleEventLUp_CharacterSelect_All_MouseOnGamePlay()
  local self = PaGlobal_CharacterSelect_All
  if self == nil then
    return
  end
  if self._ui.btn_GamePlay:IsEnable() == true then
    self:SetKeyGuideShow(self._eKeyGuideType.ACTIVE_GAMEPLAYBTN)
  else
    self:SetKeyGuideShow(self._eKeyGuideType.INACTIVE_GAMEPLAYBTN)
  end
end
function FromClient_PlayGoAutoViewAllCharacters(index)
  HandleEventLUp_CharacterSelect_All_CharacterSelect(index, true)
end
function FromClient_PlayGoTabChange(value)
  HandleEventLBRB_CharacterSelect_All_TabChange(value)
end
function FromClient_PlayGoCreateNewCharacter()
  local playerCreateType = PaGlobal_CharacterSelect_All._playerCreateType
  if true == PaGlobal_CharacterSelect_All._isConsole then
    local isChecked = PaGlobalFunc_CharacterSelect_All_IsPositionChangeClick()
    if true == isChecked then
      PaGlobal_CharacterSelect_All._ui.btn_ChangePosition:SetCheck(false)
      if PaGlobal_CharacterSelect_All._eKeyGuideType.CHANGEINGSLOT_SELECTED == PaGlobal_CharacterSelect_All._curKeyGuideIdx then
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.SELECTED)
      else
        PaGlobal_CharacterSelect_All:SetKeyGuideShow(PaGlobal_CharacterSelect_All._eKeyGuideType.NOT_SELECT)
      end
      PaGlobal_CharacterSelect_All:update()
    end
  end
  if (true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason) and nil ~= PaGlobalFunc_Customization_SetSeasonBtnShow then
    if playerCreateType == __ePlayerCreateNormal and true == PaGlobal_CharacterSelect_All._canMakeSeason then
      PaGlobalFunc_Customization_SetSeasonBtnShow(true)
    else
      PaGlobalFunc_Customization_SetSeasonBtnShow(false)
    end
  end
  if false == PaGlobal_Season_Character_Create:prepareOpen(playerCreateType) then
    changeCreateCharacterMode_SelectClass(playerCreateType)
    FGlobal_SetPlayerCreateType(playerCreateType)
  end
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportSceneConfirmCreateCharacter, true)
  end
end
function PaGlobalFunc_CharacterSelect_All_HardCoreUserInfoChange()
  if PaGlobal_CharacterSelect_All == nil then
    return
  end
  PaGlobal_CharacterSelect_All:hardCoreServerUISetting()
end
