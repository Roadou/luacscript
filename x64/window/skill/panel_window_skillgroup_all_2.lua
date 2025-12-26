function PaGlobalFunc_SkillGroup_All_Open()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SkillGroup_All_Close()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == false then
    return
  end
  if Panel_Widget_EscapeBar_All ~= nil and Panel_Widget_EscapeBar_All:GetShow() == true then
    ToClient_StopPreCoolTime()
    return
  end
  if Panel_Window_SkillGroup_SelectType ~= nil and Panel_Window_SkillGroup_SelectType:GetShow() == true then
    PaGlobalFunc_SkillGroup_SelectType_Close()
    return
  end
  if self._isPadSnapping == false and Panel_SkillGroup_CoolTimeSlot ~= nil and Panel_SkillGroup_CoolTimeSlot:GetShow() == true then
    self:prepareClose()
    PaGlobal_SkillGroup_CoolTimeSlot:close()
    return
  end
  if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == true and Panel_Window_BlackSpiritSkillLock_All ~= nil and Panel_Window_BlackSpiritSkillLock_All:GetShow() == true then
    PaGlobal_BlackSpiritSkillLock_All:prepareClose()
    return
  end
  if _ContentsGroup_SkillFilter == true and PaGlobal_SkillFilter_GetShow() == true then
    PaGlobal_SkillFilter_Close()
    return
  end
  if Panel_Window_Skill_ShowAllClasses_All ~= nil and Panel_Window_Skill_ShowAllClasses_All:GetShow() == true then
    PaGlobal_SkillShowAllClasses_All_Close()
    return
  end
  if self:checkMyClassType() == false then
    local selfPlayer = getSelfPlayer()
    if selfPlayer ~= nil then
      PaGlobal_SkillShowAllClasses_All_SelectClassType(selfPlayer:getClassType())
      return
    end
  end
  if FGlobal_WebHelper_ForceClose ~= nil and Panel_WebControl:GetShow() == true then
    FGlobal_WebHelper_ForceClose()
    return
  end
  if Panel_SkillReinforce_All ~= nil and Panel_SkillReinforce_All:GetShow() == true then
    PaGlobalFunc_PaGlobal_SkillReinforce_All_Close()
    return
  end
  local function closePanel()
    audioPostEvent_SystemUi(1, 17)
    _AudioPostEvent_SystemUiForXBOX(1, 17)
    self:prepareClose()
  end
  if self._isPadSnapping == true then
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_UNDERTHESEA_OK_MESSAGE"),
      functionYes = closePanel,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
  else
    closePanel()
  end
end
function PaGlobalFunc_SkillGroup_All_ShowAni()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  local ImageMoveAni = Panel_Window_SkillGroup_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(getScreenSizeX(), Panel_Window_SkillGroup_All:GetPosY())
  ImageMoveAni:SetEndPosition(getScreenSizeX() - Panel_Window_SkillGroup_All:GetSizeX(), Panel_Window_SkillGroup_All:GetPosY())
  ImageMoveAni.IsChangeChild = true
  Panel_Window_SkillGroup_All:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetIgnoreUpdateSnapping(true)
end
function PaGlobalFunc_SkillGroup_All_HideAni()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  local ImageMoveAni = Panel_Window_SkillGroup_All:addMoveAnimation(0, 0.3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  ImageMoveAni:SetStartPosition(Panel_Window_SkillGroup_All:GetPosX(), Panel_Window_SkillGroup_All:GetPosY())
  ImageMoveAni:SetEndPosition(getScreenSizeX(), Panel_Window_SkillGroup_All:GetPosY())
  ImageMoveAni.IsChangeChild = true
  Panel_Window_SkillGroup_All:CalcUIAniPos(ImageMoveAni)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetHideAtEnd(true)
  ImageMoveAni:SetDisableWhileAni(true)
  ImageMoveAni:SetIgnoreUpdateSnapping(true)
end
function PaGlobalFunc_SkillGroup_All_ClearSkillByPoint(skillNo)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if _ContentsGroup_SkillComboGuide == true and PaGlobal_SkillCombo_UpdateSkillCombo ~= nil then
    PaGlobal_SkillCombo_UpdateSkillCombo()
  end
  if Phantom_Locate ~= nil and self._ui._chk_playShow:IsCheck() == false then
    if Panel_MainStatus_Remaster ~= nil and Panel_MainStatus_Remaster:GetShow() == true then
      PaGlobalFunc_MainStatus_UpdateResource()
      PaGlobalFunc_MainStatus_UpdateBuffList()
    else
      Phantom_Locate()
      buffList_update()
    end
  end
  if self._isClearSkillFusion == true then
    Panel_SkillTooltip_Hide()
    self:updateFusionSkillArea()
  else
    local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
    if skillGroupInfo ~= nil then
      self:updateSkillGroupInfo(skillGroupInfo)
      self:showGroupLearnLastSkillByGroup(skillGroupInfo)
      local nextSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, skillGroupInfo._selectLevel)
      if nextSkillKey:isDefined() == true then
        local nextSkillNo = nextSkillKey:getSkillNo()
        PaGloabl_SkillGroup_ShowDesc(nextSkillNo)
        if self._isPadSnapping == false then
          Panel_SkillTooltip_Show(nextSkillNo, true, "SkillBox")
        end
      end
      self:handleEventMouseOnOff_SkillGroup(true, skillGroupInfo._key)
      self:updateSlot()
      if self._isPadSnapping == true then
        ToClient_padSnapChangeToTarget(skillGroupInfo._control)
        self:alignKeyguide(2, skillGroupInfo._key)
      end
    else
      Panel_SkillTooltip_Hide()
    end
  end
  self._isClearSkillFusion = false
end
function PaGlobalFunc_SkillGroup_All_GetClearSkillGroupInfo()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return nil, nil
  end
  local skillGroupInfo = self._skillGroupInfo[self._clearSkillGroupKey]
  if skillGroupInfo ~= nil then
    return skillGroupInfo._key, skillGroupInfo._selectLevel
  end
  return nil, nil
end
function PaGlobalFunc_SkillGroup_All_StartDrag(skillNo)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_NpcDialog then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  self._isDraggingFromTree = true
  if skillLevelInfo ~= nil and skillTypeStaticWrapper ~= nil then
    DragManager:setDragInfo(Panel_Window_SkillGroup_All, nil, skillLevelInfo._skillKey:get(), "Icon/" .. skillTypeStaticWrapper:getIconPath(), PaGlobalFunc_SkillGroup_All_GroundClick, nil)
    if self._isEditMode == false then
      self:handleEventLUp_EditMode()
    end
  end
end
function PaGlobalFunc_SkillGroup_All_GroundClick(whereType, skillKey)
  if isUseNewQuickSlot() == true then
    FGlobal_SetNewQuickSlot_BySkillGroundClick(skillKey)
  end
end
function PaGlobalFunc_SkillGroup_All_CannotLernSkill(branchType)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = "",
    functionYes = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if __eSkillTypeParam_Inherit == branchType then
    messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MUST_SELECT_TREE", "type", PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION"))
  elseif __eSkillTypeParam_Awaken == branchType then
    messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MUST_SELECT_TREE", "type", PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN"))
  end
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_SkillGroup_All_FindSkillGroupAndFocusEffect(skillNo)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  local needSkill = getSkillStaticStatus(skillNo, 1)
  if needSkill ~= nil then
    local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
    if skillGroupInfo ~= nil then
      self:skillFocusEffect(1, skillGroupInfo, 0)
      if self._isPadSnapping == true then
        ToClient_padSnapChangeToTarget(skillGroupInfo._control)
      end
      return true
    end
  end
  return false
end
function PaGlobalFunc_SkillGroup_All_IsSearchState()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true and (self._curAlignType == 6 or isPadPressed(__eJoyPadInputType_RightTrigger) == true) then
    return true
  end
  return false
end
function PaGlobalFunc_SkillGroup_All_ClearSkills()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == false then
    return
  end
  PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
  self:changeSkillType()
  self:getCurrentSkillType()
  self:updateSkillTypeArea()
  self:update()
  self:updateSlot()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_RESETSUCCESS"))
end
function PaGlobalFunc_SkillGroup_All_CloseShiftGuide()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self._ui._stc_shiftGuideMain:SetShow(false)
end
function PaGlobalFunc_SkillGroup_All_Resize()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:defaultPanelResize()
  if true == Panel_Window_SkillGroup_Controller:GetShow() then
    PaGlobal_SkillGroup_Controller_Resize()
  end
  PaGlobal_SkillGroup_QuickSlot_Resize()
end
function PaGlobalFunc_SkillGroup_All_SkillGroupLearnedSkill(skillNo)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if skillNo == nil then
    return
  end
  self:learnSkill(skillNo)
  self:updateSkillTooltip(skillNo)
  local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
  if skillGroupInfo ~= nil then
    self:handleEventMouseOnOff_SkillGroup(true, skillGroupInfo._key)
    self:updateSkillGroupInfo(skillGroupInfo)
  end
end
function PaGlobalFunc_SkillGroup_All_Update()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == false then
    return
  end
  if self:checkMyClassType() == true then
    self._learnAbleSkillCount = ToClient_getLearnableSkillCount(self._classType)
  end
  self._selectedSkillType = self:getCurrentSkillType()
  self:updateSkillTypeArea()
  self:update()
end
function PaGlobalFunc_SkillGroup_All_ChangePreset()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == false then
    return
  end
  if self:checkMyClassType() == true then
    self._learnAbleSkillCount = ToClient_getLearnableSkillCount(self._classType)
  end
  self._targetSkillType = ToClient_GetCurrentPlayerSkillType()
  self:changeSkillType()
  self:updateSkillTypeArea()
  self:updateSkillPresetArea()
  self:updateSlot()
  self:update()
end
function PaGlobalFunc_SkillGroup_All_SkillGroupSkillPointUpdate()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:updateStat()
end
function PaGlobalFunc_SkillGroup_All_SuccessSkillReinforceInSkillGroup()
  if _ContentsGroup_DarkMoonAdditionalBuff == false then
    return
  end
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  audioPostEvent_SystemUi(3, 3)
  _AudioPostEvent_SystemUiForXBOX(3, 3)
  self:makeUpgradeSkillArea()
  self:selectTab(self._eTabType._upgrade)
end
function PaGlobalFunc_SkillGroup_All_responseLearnFusionSkill(skillNo, slotIndex)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:updateFusionSkillArea()
  self:playLearnFusionSkillEffect(skillNo, slotIndex)
  self:updateStat()
  self._mainSkillNo = 0
  self._subSkillNo = 0
  self._resultSkillNo = 0
  self._selectedFusionSlotNo = 0
  self._selectedFusionSkillIndex = 0
end
function PaGlobalFunc_SkillGroup_All_responseClearFusionSkill()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:updateFusionSkillArea()
  self:alignKeyguide(3, nil, false, true)
end
function PaGlobalFunc_SkillGroup_All_LearnFusionSKillUpdatePerFrame(deltaTime)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:learnFusionSKillUpdatePerFrame(deltaTime)
end
function PaGlobalFunc_SkillGroup_All_CreateUpgradeSkillListContent(content, key)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:createUpgradeSkillListContent(content, key)
end
function PaGlobalFunc_SkillGroup_All_OpenReinforce(skillType, skillNo, skillIndex, index)
  if PaGlobal_SkillReinforce_All == nil then
    return
  end
  if _ContentsGroup_DarkMoonAdditionalBuff == false then
    return
  end
  PaGlobal_SkillReinforce_All:show(skillType, skillNo, skillIndex, index, true)
end
function PaGlobalFunc_SkillGroup_All_OpenReinforceNew(skillType, index)
  if PaGlobal_SkillReinforce_All == nil then
    return
  end
  if _ContentsGroup_DarkMoonAdditionalBuff == false then
    return
  end
  PaGlobal_SkillReinforce_All:show(skillType, nil, nil, index, true)
end
function PaGlobalFunc_SkillGroup_All_ChangeReinforce(skillType, skillNo, skillIndex, index)
  if PaGlobal_SkillReinforce_All == nil then
    return
  end
  if _ContentsGroup_DarkMoonAdditionalBuff == false then
    return
  end
  PaGlobal_SkillReinforce_All:change(skillType, skillNo, skillIndex, index, true)
end
function PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(isShow, skillIndex, effectIndex)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local skillSSW = ToClient_GetReAwakeningListAt(skillIndex)
  if skillSSW == nil then
    return
  end
  local skillNo = skillSSW:getSkillNo()
  local realEffectIndex = ToClient_GetAwakeningAbilityIndex(skillNo, effectIndex)
  local effectString = skillSSW:getSkillAwakenDescription(realEffectIndex)
  if effectString == nil then
    return
  end
  local content = self._ui._list2_upgradeList:GetContentByKey(toInt64(0, skillIndex + 1))
  if content == nil then
    return
  end
  local area = UI.getChildControl(content, "Static_UpgradeSkill_Area")
  local skillEffectBg = UI.getChildControl(area, "StaticText_NorSkillEff_Title")
  local targetControl
  if effectIndex == 0 then
    targetControl = UI.getChildControl(skillEffectBg, "StaticText_NorSkillEff01")
  else
    targetControl = UI.getChildControl(skillEffectBg, "StaticText_NorSkillEff02")
  end
  TooltipSimple_Show(targetControl, effectString)
end
function PaGlobalFunc_SkillGroup_All_responseSkillPresetSlotExpansion(slotCount)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:updateSkillPresetArea()
  PaGlobal_TotalPreset_UpdatePreset()
end
function PaGlobalFunc_SkillGroup_All_SkillAndPresetClearConfirm()
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLANDPRESET_CLEAR_CONFIRM"),
    functionYes = PaGlobalFunc_SkillGroup_RequesetSkillAndPresetClear,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_SkillGroup_All_SkillAndPresetClear()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == false then
    return
  end
  self:updateSlot()
  self:update()
  QuickSlot_UpdateData()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLANDPRESET_CLEAR"))
end
function PaGlobalFunc_SkillGroup_All_SkillPresetSaveMessage(slotNo)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self:updateSkillPresetArea()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET" .. tostring(slotNo + 1) .. "_SAVE_ACK"))
end
function PaGlobalFunc_SkillGroup_All_PreRenderMode()
end
function PaGlobalFunc_SkillGroup_All_ComboSkillSetting()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true then
    audioPostEvent_SystemUi(0, 0)
  else
    _AudioPostEvent_SystemUiForXBOX(0, 0)
  end
  self._ui._combo_skillSetting:ToggleListbox()
end
function PaGlobalFunc_SkillGroup_All_SelectSkillSetting()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if self._isPadSnapping == true then
    audioPostEvent_SystemUi(0, 0)
  else
    _AudioPostEvent_SystemUiForXBOX(0, 0)
  end
  local selectSkillSettingIndex = self._ui._combo_skillSetting:GetSelectIndex()
  if selectSkillSettingIndex == 0 then
    self:handleEventLUp_EditMode()
  elseif selectSkillSettingIndex == 1 then
    self:handleEventLUp_CooltimeSet()
  elseif selectSkillSettingIndex == 2 then
    self:handleEventLUp_BlackSpiritSkillLock()
  end
end
function PaGlobalFunc_SkillGroup_All_ShowOtherClassSkill(classType)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if classType == nil then
    return
  end
  self:showOtherClassSkill(classType)
end
function PaGlobalFunc_SkillGroup_All_UpdateSkillFilter()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == true then
    self:updateSlot()
    self:update()
  end
end
function PaGlobalFunc_SkillGroup_All_EndXboxKeyInput(str)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self._ui._edit_search:SetEditText(str)
  ClearFocusEdit()
end
function PaGlobal_SkillGroup_All_FocusEditSearch()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self._ui._edit_search:SetEditText("", true)
  SetFocusEdit(self._ui._edit_search)
  self:alignKeyguide(6)
end
function PaGlobal_SkillGroup_All_ResetSkillCamera()
  if ToClient_LearnSkillCameraIsShow() == false then
    return
  end
  ToClient_LearnSkillCameraReset()
  ToClient_LearnSkillCameraSetZoom(200)
  ToClient_LearnSkillCameraSetPosition(70, -10)
  ToClient_LearnSkillCameraSetRotation(-2.5, -0.3)
end
function PaGlobalFunc_SkillGroup_All_OnClickedFindNpcButton()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if self._selectedTab ~= self._eTabType._upgrade then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) == true then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  local spawnType = CppEnums.SpawnType.eSpawnType_SkillTrainer
  local position = selfPlayerWrapper:get3DPos()
  local nearNpcInfo = getNearNpcInfoByType(spawnType, position)
  if nearNpcInfo == nil then
    return
  end
  if nearNpcInfo:isTimeSpawn() == false then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
  end
  local pos = nearNpcInfo:getPosition()
  local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, false)
  selfPlayer:setNavigationMovePath(npcNaviKey)
  selfPlayer:checkNaviPathUI(npcNaviKey)
  Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_NAVIGATIONDESCRIPTION", "npcName", tostring(CppEnums.SpawnTypeString[spawnType])))
  if PaGlobal_TutorialManager ~= nil then
    PaGlobal_TutorialManager:handleClickedTownNpcIconNaviStart(spawnType)
  end
end
function PaGlobalFunc_SkillGroup_PlayBlackSpiritSkill(key)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  local skillGroupInfo = self._skillGroupInfo[key]
  if skillGroupInfo == nil then
    return
  end
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, skillGroupInfo._selectLevel)
  if skillKey == nil then
    return
  end
  local skillNo = skillKey:getSkillNo()
  if skillNo == nil then
    return
  end
  local beforeSkillNo = skillNo
  local skillStatic = getSkillStaticStatus(skillNo, 1)
  if skillStatic == nil then
    return
  end
  local blackSkillNo = skillStatic:getlinkBlackSkillNo()
  local linkSkillNo = skillStatic:getLinkTooltipSkillNo()
  local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
  if blackSkillTypeSS == nil or blackSkillTypeSS:isValidLocalizing() == false then
    blackSkillNo = 0
  else
    local blackSkillStatic = getSkillStaticStatus(blackSkillNo, 1)
    if blackSkillStatic == nil then
      blackSkillNo = 0
    end
  end
  local beforeSkillShowType = self._curSkillShowType
  if self._curSkillShowType == self._eSkillShowTypeIndex._baseSkill then
    if blackSkillNo ~= 0 then
      self._curSkillShowType = self._eSkillShowTypeIndex._blackSpiritSkill
      skillNo = blackSkillNo
      if linkSkillNo ~= 0 then
        self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWSUCCESSIONSKILLDESC"))
      else
        self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWBASESKILLDESC"))
      end
    elseif linkSkillNo ~= 0 then
      self._curSkillShowType = self._eSkillShowTypeIndex._linkSkill
      skillNo = linkSkillNo
      self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWBASESKILLDESC"))
    end
  elseif self._curSkillShowType == self._eSkillShowTypeIndex._blackSpiritSkill then
    if linkSkillNo ~= 0 then
      self._curSkillShowType = self._eSkillShowTypeIndex._linkSkill
      skillNo = linkSkillNo
      self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWBASESKILLDESC"))
    else
      self._curSkillShowType = self._eSkillShowTypeIndex._baseSkill
      self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAY_BLACKSKILL"))
    end
  elseif self._curSkillShowType == self._eSkillShowTypeIndex._linkSkill then
    self._curSkillShowType = self._eSkillShowTypeIndex._baseSkill
    if blackSkillNo ~= 0 then
      self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAY_BLACKSKILL"))
    else
      self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWSUCCESSIONSKILLDESC"))
    end
  end
  if beforeSkillShowType == self._eSkillShowTypeIndex._baseSkill and beforeSkillNo == skillNo then
    return
  end
  PaGlobalFunc_SkillGroup_SkillAction(skillNo)
  if PaGloabl_SkillGroup_ShowDesc ~= nil then
    PaGloabl_SkillGroup_ShowDesc(skillNo, true)
  end
end
function PaGlobalFunc_SkillGroup_All_ChangeSkillShowTypeKeyGuide(skillNo)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if skillNo == nil then
    return
  end
  local skillStatic = getSkillStaticStatus(skillNo, 1)
  if skillStatic == nil then
    return
  end
  self._curSkillShowType = self._eSkillShowTypeIndex._baseSkill
  local blackSkillNo = skillStatic:getlinkBlackSkillNo()
  if blackSkillNo ~= nil then
    local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
    if blackSkillTypeSS ~= nil and blackSkillTypeSS:isValidLocalizing() == true then
      local blackSkillStatic = getSkillStaticStatus(blackSkillNo, 1)
      if blackSkillStatic ~= nil then
        self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAY_BLACKSKILL"))
        return
      end
    end
  end
  local linkSkillNo = skillStatic:getLinkTooltipSkillNo()
  if linkSkillNo ~= nil then
    local linkSkillTypeSS = getSkillTypeStaticStatus(linkSkillNo)
    if linkSkillTypeSS ~= nil and linkSkillTypeSS:isValidLocalizing() == true then
      local linkSkillStatic = getSkillStaticStatus(linkSkillNo, 1)
      if linkSkillStatic ~= nil then
        self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWSUCCESSIONSKILLDESC"))
        return
      end
    end
  end
end
function PaGlobalFunc_SkillGroup_All_OpenSkillShowAllClasses()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  self._ui._stc_presetBG:SetShow(false)
  PaGlobal_SkillShowAllClasses_All_Open()
end
function PaGlobalFunc_SkillGroup_All_HotKeyToggle()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if Panel_Window_SkillGroup_All:IsShow() == true then
    audioPostEvent_SystemUi(1, 17)
    _AudioPostEvent_SystemUiForXBOX(1, 17)
    PaGlobalFunc_SkillGroup_All_Close()
  else
    audioPostEvent_SystemUi(1, 18)
    _AudioPostEvent_SystemUiForXBOX(1, 18)
    PaGlobalFunc_SkillGroup_All_Open()
  end
end
function PaGlobalFunc_SkillGroup_All_OpenByHardcore()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if ToClient_isPlayerControlable() == true then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_SkillGroup_All_CloseNotShowAni()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  self._showAni = false
  PaGlobalFunc_SkillGroup_All_Close()
end
function PaGlobalFunc_SkillGroup_All_OpenAndSelectTab(tabIndex)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if tabIndex == nil then
    return
  end
  self:prepareOpen()
  self:selectTab(tabIndex)
end
function PaGlobalFunc_SkillGroup_All_KeyBoardMoveLevel()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if Defines.UIMode.eUIMode_SkillWindow ~= GetUIMode() or Panel_Window_SkillGroup_All:GetShow() == false then
    return false
  end
  if self._selectedSkillGroupKey == nil or self._selectedSkillGroupKey == 0 then
    return false
  end
  if isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_LEFT) == true then
    self:handleEventLUp_LevelButton(false, self._selectedSkillGroupKey)
    return true
  elseif isKeyDown_Once(CppEnums.VirtualKeyCode.KeyCode_RIGHT) == true then
    self:handleEventLUp_LevelButton(true, self._selectedSkillGroupKey)
    return true
  end
  return false
end
function PaGlobalFunc_SkillGroup_All_KeyBoardTabEvent()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_TAB) == true then
    if isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_CONTROL) == true then
      self:selectPrevTab()
      return true
    else
      self:selectNextTab()
      return true
    end
  end
  return false
end
function PaGlobalFunc_SkillGroup_All_OpenByAwakenGuide()
  local self = PaGlobal_SkillGroup_All
  if self == nil or Panel_Window_SkillGroup_All == nil then
    return
  end
  if _ContentsGroup_SkillPreset == false then
    return
  end
  if Panel_Window_SkillGroup_All:IsShow() == false then
    audioPostEvent_SystemUi(1, 18)
    _AudioPostEvent_SystemUiForXBOX(1, 18)
    local isNpcDialogShow = _ContentsGroup_UISkillGroupTreeLayOut == true and Panel_Npc_Dialog_All ~= nil and Panel_Npc_Dialog_All:GetShow() == true and GetUIMode() == Defines.UIMode.eUIMode_NpcDialog
    if isNpcDialogShow == true then
      if PaGlobalFunc_DialogMain_All_InnerPanelShow ~= nil then
        local targetWindowList = {Panel_Window_SkillGroup_All}
        PaGlobalFunc_DialogMain_All_InnerPanelShow(1, targetWindowList)
      end
      self:setDialog(true)
    end
    PaGlobalFunc_SkillGroup_All_Open()
    if isNpcDialogShow == true and PaGlobalFunc_DialogMain_All_ShowToggle ~= nil then
      PaGlobalFunc_DialogMain_All_ShowToggle(false)
    end
  end
  local function changeAwaken()
    self._isAwakenGuide = true
    if PaGlobalFunc_SkillGroup_SelectType_SelectTree ~= nil then
      PaGlobalFunc_SkillGroup_SelectType_SelectTree(1, true)
    end
  end
  local function settingPreset()
    local presetOpenSlotCount = ToClient_getSkillPresetSlotCount()
    if presetOpenSlotCount > 0 and PaGlobal_SkillPreset_saveSkillPresetConfirmByAwakenGuide ~= nil then
      PaGlobal_SkillPreset_saveSkillPresetConfirmByAwakenGuide()
    else
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAGEAWAKEN_DESC3"),
        functionYes = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      if self._isPadSnapping == false then
        MessageBox.showMessageBox(messageBoxData, nil, false, false)
      else
        MessageBox.showMessageBox(messageBoxData, nil, false, true)
      end
      return
    end
  end
  local function resetSkillAgree()
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAGEAWAKEN_DESC2"),
      functionYes = settingPreset,
      functionNo = changeAwaken,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if self._isPadSnapping == false then
      MessageBox.showMessageBox(messageBoxData, nil, false, false)
    else
      MessageBox.showMessageBox(messageBoxData, nil, false, true)
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SAGEAWAKEN_DESC1"),
    functionYes = resetSkillAgree,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if self._isPadSnapping == false then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData, nil, false, true)
  end
end
function PaGlobalFunc_SkillGroup_All_IsAwakenGuide()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  return self._isAwakenGuide
end
function PaGlobalFunc_SkillGroup_All_SetAwakenGuide(isAwakenGuide)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if isAwakenGuide == nil then
    return
  end
  self._isAwakenGuide = isAwakenGuide
end
function PaGlobalFunc_SkillGroup_All_EnableSkillReturn()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return 0
  end
  return ToClient_getLearnableSkillCount(selfPlayer:getClassType())
end
function PaGlobalFunc_SkillGroup_All_PlayerLearnableSkill()
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  for key, skillGroupInfo in pairs(self._skillGroupInfo) do
    for level = 1, skillGroupInfo._maxLevel do
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(key, level)
      local skillNo = skillKey:getSkillNo()
      local skillSS = getSkillStaticStatus(skillNo, 1)
      if skillSS ~= nil and skillSS:getSkillAwakenBranchType() == self._eTabType._mainWeapon then
        local skillLevelInfo = getSkillLevelInfo(skillNo)
        if skillLevelInfo ~= nil and skillLevelInfo._learnable == true and skillLevelInfo._isLearnByQuest == false then
          return true
        else
          return false
        end
      end
    end
  end
  return false
end
function PaGlobalFunc_SkillGroup_All_SkillpresetEasyBuy()
  PaGlobalFunc_EasyBuy_Open(81, nil, false)
end
function PaGlobalFunc_SkillGroup_All_SkillPresetSaveOpen()
  if _ContentsGroup_SkillPreset == true and PaGlobal_SkillPreset_Open ~= nil then
    PaGlobal_SkillPreset_Open(ToClient_getSkillPresetSlotCount())
  end
end
function PaGlobalFunc_Skill_IsBlockByConsoleSkill(skillNo)
  return false
end
function PaGlobalFunc_SkillGroup_All_IsActiveItemSkill(skillKey)
  if skillKey == nil then
    return false
  end
  if ToClient_IsActiveItemLearnSkillAutoLearn(skillKey) == true then
    return false
  end
  return ToClient_IsActiveItemSkill(skillKey)
end
function PaGlobalFunc_SkillGroup_All_UseSkillAskFromOtherPlayer(fromName)
  if MessageBoxGetShow() == true then
    MessageBox_Empty_function()
    allClearMessageData()
  end
  local clickYes = function()
    ToClient_AnswerUseSkill(true)
  end
  local clickNo = function()
    ToClient_AnswerUseSkill(false)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_ANSWERSKILL_MESSAGEBOX_TITLE"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ANSWERSKILL_QUESTTION", "from_name", fromName),
    functionYes = clickYes,
    functionCancel = clickNo,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobalFunc_SkillGroup_All_GetConvertTabIndex(skillType)
  local self = PaGlobal_SkillGroup_All
  if self == nil then
    return
  end
  if skillType == nil then
    return
  end
  if __eSkillTypeParam_Awaken == skillType then
    return self._eTabType._awaken
  else
    return self._eTabType._mainWeapon
  end
end
