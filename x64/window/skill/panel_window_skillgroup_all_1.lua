function PaGlobal_SkillGroup_All:initialize()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._stc_skillTypeArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_SkillTypeArea")
  self._ui._rdo_successionSkill = UI.getChildControl(self._ui._stc_skillTypeArea, "RadioButton_SussessionSkill")
  self._ui._rdo_awakenSkill = UI.getChildControl(self._ui._stc_skillTypeArea, "RadioButton_AwakenSkill")
  self._ui._stc_successionLock = UI.getChildControl(self._ui._stc_skillTypeArea, "Static_SussessionLock")
  self._ui._stc_awakenLock = UI.getChildControl(self._ui._stc_skillTypeArea, "Static_AwakenLock")
  self._ui._stc_radioGroup = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_RadioGroup")
  self._ui._rdo_tab_mainWeapon = UI.getChildControl(self._ui._stc_radioGroup, "RadioButton_Tab_MainWeapon")
  self._ui._rdo_tab_awakenWeapon = UI.getChildControl(self._ui._stc_radioGroup, "RadioButton_Tab_AwakenWeapon")
  self._ui._rdo_tab_fusionSkill = UI.getChildControl(self._ui._stc_radioGroup, "RadioButton_Tab_FusionSkill")
  self._ui._rdo_tab_upgradeSkill = UI.getChildControl(self._ui._stc_radioGroup, "RadioButton_Tab_Skill_Upgrade")
  self._ui._stc_selectLine = UI.getChildControl(self._ui._stc_radioGroup, "Static_SelectLine")
  self._ui._keyguide_LB = UI.getChildControl(self._ui._stc_radioGroup, "Static_SelectLB_C")
  self._ui._keyguide_RB = UI.getChildControl(self._ui._stc_radioGroup, "Static_SelectRB_C")
  self._ui._stc_topFunctionArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_TopFunctionArea")
  self._ui._edit_search = UI.getChildControl(self._ui._stc_topFunctionArea, "Edit_Search")
  self._ui._btn_search = UI.getChildControl(self._ui._edit_search, "Button_Search")
  self._ui._keyguide_RT_X = UI.getChildControl(self._ui._edit_search, "StaticText_X_ConsoleUI")
  self._ui._stc_skillPoint = UI.getChildControl(self._ui._stc_topFunctionArea, "Static_SkillPoint")
  self._ui._txt_skillPointTitle = UI.getChildControl(self._ui._stc_skillPoint, "StaticText_SkillPointTitle")
  self._ui._txt_skillPointTitleText = UI.getChildControl(self._ui._stc_skillPoint, "StaticText_SkillPointTitle_Text")
  self._ui._txt_skillPointValue = UI.getChildControl(self._ui._stc_skillPoint, "StaticText_SkillPointValue")
  self._ui._btn_allReset = UI.getChildControl(self._ui._stc_topFunctionArea, "Button_AllReset")
  self._ui._btn_skillSet = UI.getChildControl(self._ui._stc_topFunctionArea, "Button_SkillSet")
  self._ui._btn_filter = UI.getChildControl(self._ui._stc_topFunctionArea, "Button_Filter")
  self._ui._stc_mainWeaponSkillArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_MainWeaponSkillArea")
  self._ui._frame_skillGroupArea_main = UI.getChildControl(self._ui._stc_mainWeaponSkillArea, "Frame_SkillGroupArea")
  self._ui._scroll_skillGroupArea_main = UI.getChildControl(self._ui._frame_skillGroupArea_main, "Frame_1_VerticalScroll")
  self._ui._stc_awakenSkillArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_AwakenSkillArea")
  self._ui._frame_skillGroupArea_awaken = UI.getChildControl(self._ui._stc_awakenSkillArea, "Frame_SkillGroupArea")
  self._ui._scroll_skillGroupArea_awaken = UI.getChildControl(self._ui._frame_skillGroupArea_awaken, "Frame_1_VerticalScroll")
  self._ui._stc_fusionSkillArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_FusionSkillArea")
  self._ui._stc_fusionSkillTopArea = UI.getChildControl(self._ui._stc_fusionSkillArea, "Static_SkillTopArea")
  self._ui._frame_fusionSkill = UI.getChildControl(self._ui._stc_fusionSkillArea, "Frame_FusionSkill")
  self._ui._scroll_skillGroupArea_fusionSkill = UI.getChildControl(self._ui._frame_fusionSkill, "Frame_FusionSkill_VerticalScroll")
  self._ui._stc_upgradeSkillArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_UpgradeSkillArea")
  self._ui._list2_upgradeList = UI.getChildControl(self._ui._stc_upgradeSkillArea, "List2_Upgrade_List")
  self._ui._btn_naviSkillMaster = UI.getChildControl(self._ui._stc_upgradeSkillArea, "Button_Navi_SkillMaster")
  self._ui._keyguide_naviSkillMaster = UI.getChildControl(self._ui._stc_upgradeSkillArea, "StaticText_Navi_SkillMaster_ConsoleUI")
  self._ui._stc_bottomArea = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_BottomArea")
  self._ui._btn_movie = UI.getChildControl(self._ui._stc_bottomArea, "Button_Movie")
  self._ui._btn_showOtherCharSkill = UI.getChildControl(self._ui._stc_bottomArea, "Button_ShowOtherChar_Skill")
  self._ui._combo_skillSetting = UI.getChildControl(self._ui._stc_bottomArea, "Combobox2_Skill_Setting")
  self._ui._chk_playShow = UI.getChildControl(self._ui._stc_bottomArea, "Checkbox_PlayShow")
  self._ui._stc_presetBG = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_PresetBG")
  self._ui._rdo_preset_templete = UI.getChildControl(self._ui._stc_presetBG, "RadioButton_Preset_Templete")
  self._ui._btn_lock_templete = UI.getChildControl(self._ui._stc_presetBG, "Button_Lock_Templete")
  self._ui._btn_presetSave = UI.getChildControl(self._ui._stc_presetBG, "Button_PresetSave")
  self._ui._stc_selectPreset = UI.getChildControl(self._ui._stc_presetBG, "Static_SelectTab")
  self._ui._stc_shiftGuideMain = UI.getChildControl(Panel_Window_SkillGroup_All, "Static_ShiftGuideMain")
  local shiftGuideBg = UI.getChildControl(self._ui._stc_shiftGuideMain, "Static_ShiftGuideBG")
  self._ui._btn_shiftGuideClose = UI.getChildControl(shiftGuideBg, "Button_Close")
  self._ui._keyguide_Bg = UI.getChildControl(Panel_Window_SkillGroup_All, "StaticText_KeyGuideBg_ConsoleUI")
  self._ui._keyguide_CameraBg = UI.getChildControl(Panel_Window_SkillGroup_All, "StaticText_CameraKeyGuideBg_ConsoleUI")
  self._ui._keyguide_A = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_LearnSkill_ConsoleUI")
  self._ui._keyguide_B = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_Close_ConsoleUI")
  self._ui._keyguide_X = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_SkillPresetMemo_ConsoleUI")
  self._ui._keyguide_Y = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_ResetSkill_ConsoleUI")
  self._ui._keyguide_LS = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_SkillLock_ConsoleUI")
  self._ui._keyguide_LT_A = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_LearnMaxSkill_ConsoleUI")
  self._ui._keyguide_LT_X = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_StartSpiritSkillAnim_ConsoleUI")
  self._ui._keyGuide_LT_X_sub = UI.getChildControl(self._ui._keyguide_LT_X, "StaticText_KeyGuide_LT_ConsoleUI")
  self._ui._keyguide_LT_Y = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_ResetSkillLevel_ConsoleUI")
  self._ui._keyguide_LT_DPad = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_ChangeLevel_ConsoleUI")
  self._ui._keyguide_RT_Y = UI.getChildControl(self._ui._keyguide_Bg, "StaticText_ShowOtherClassSkill")
  self._ui._templeteList = UI.getChildControl(Panel_Window_SkillGroup_All, "TempleteList")
  self._ui._stc_templete_skillGroup = UI.getChildControl(self._ui._templeteList, "Radiobutton_SkillGroup_Template")
  self._ui._rdo_templete_skillSubGroup = UI.getChildControl(self._ui._templeteList, "Static_SkillSubGroup_Templete")
  self._ui._stc_templete_lineControl = UI.getChildControl(self._ui._templeteList, "Static_LineControl_Templete")
  self._ui._stc_templete_fusionSkill = UI.getChildControl(self._ui._templeteList, "Static_FusionSkill_Templete")
  self._ui._stc_templete_fusionSkillResult = UI.getChildControl(self._ui._templeteList, "Static_FusionSkillResult_Templete")
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self:registerEventHandler()
  self:validate()
  self:checkPlatform()
  self:makeDefaultUI()
  self:defaultPanelResize()
  self._initialize = true
end
function PaGlobal_SkillGroup_All:registerEventHandler()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  Panel_Window_SkillGroup_All:RegisterShowEventFunc(true, "PaGlobalFunc_SkillGroup_All_ShowAni()")
  Panel_Window_SkillGroup_All:RegisterShowEventFunc(false, "PaGlobalFunc_SkillGroup_All_HideAni()")
  Panel_Window_SkillGroup_All:registReloadEvent(__eUIReloadEventType_SwapCharacter)
  registerEvent("onScreenResize", "PaGlobalFunc_SkillGroup_All_Resize")
  registerEvent("FromClient_SkillWindowClose", "PaGlobalFunc_SkillGroup_All_Close")
  registerEvent("EventSkillWindowUpdate", "PaGlobalFunc_SkillGroup_All_Update")
  registerEvent("FromClient_SelfPlayerCombatSkillPointChanged", "PaGlobalFunc_SkillGroup_All_SkillGroupSkillPointUpdate")
  registerEvent("EventSkillWindowClearSkillAll", "PaGlobalFunc_SkillGroup_All_ClearSkills")
  registerEvent("EventlearnedSkill", "PaGlobalFunc_SkillGroup_All_SkillGroupLearnedSkill")
  registerEvent("EventSkillWindowClearSkillByPoint", "PaGlobalFunc_SkillGroup_All_ClearSkillByPoint")
  registerEvent("FromClient_EventSkillWindowAllUpdate", "PaGlobalFunc_SkillGroup_All_ChangePreset")
  registerEvent("FromClient_responseLearnFusionSkill", "PaGlobalFunc_SkillGroup_All_responseLearnFusionSkill")
  registerEvent("FromClient_responseClearFusionSkill", "PaGlobalFunc_SkillGroup_All_responseClearFusionSkill")
  registerEvent("FromClient_SuccessSkillAwaken", "PaGlobalFunc_SkillGroup_All_SuccessSkillReinforceInSkillGroup")
  registerEvent("FromClient_ChangeSkillAwakeningBitFlag", "PaGlobalFunc_SkillGroup_All_SuccessSkillReinforceInSkillGroup")
  registerEvent("FromClient_ChangeAwakenSkill", "PaGlobalFunc_SkillGroup_All_SuccessSkillReinforceInSkillGroup")
  registerEvent("FromClient_responseSkillPresetSlotExpansion", "PaGlobalFunc_SkillGroup_All_responseSkillPresetSlotExpansion")
  registerEvent("FromClient_SkillAndPresetClearConfirm", "PaGlobalFunc_SkillGroup_All_SkillAndPresetClearConfirm")
  registerEvent("FromClient_SkillAndPresetClear", "PaGlobalFunc_SkillGroup_All_SkillAndPresetClear")
  registerEvent("FromClient_SkillPresetSave", "PaGlobalFunc_SkillGroup_All_SkillPresetSaveMessage")
  registerEvent("FromClient_UseSkillAskFromOtherPlayer", "PaGlobalFunc_SkillGroup_All_UseSkillAskFromOtherPlayer")
  self._ui._rdo_successionSkill:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillTypeArea(" .. __eSkillTypeParam_Inherit .. ")")
  self._ui._rdo_awakenSkill:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillTypeArea(" .. __eSkillTypeParam_Awaken .. ")")
  self._ui._rdo_tab_mainWeapon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectTab(" .. self._eTabType._mainWeapon .. ")")
  self._ui._rdo_tab_awakenWeapon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectTab(" .. self._eTabType._awaken .. ")")
  self._ui._rdo_tab_fusionSkill:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectTab(" .. self._eTabType._fusion .. ")")
  self._ui._rdo_tab_upgradeSkill:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectTab(" .. self._eTabType._upgrade .. ")")
  self._ui._stc_shiftGuideMain:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_CloseShiftGuide()")
  self._ui._btn_shiftGuideClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_CloseShiftGuide()")
  self._ui._btn_showOtherCharSkill:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_OpenSkillShowAllClasses()")
  self._ui._combo_skillSetting:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_ComboSkillSetting()")
  self._ui._edit_search:addInputEvent("Mouse_LDown", "PaGlobal_SkillGroup_All:handleEventLUp_SearchText()")
  self._ui._edit_search:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SearchText()")
  self._ui._edit_search:RegistAllKeyEvent("PaGlobal_SkillGroup_All:handleEventLUp_SearchText()")
  self._ui._edit_search:RegistReturnKeyEvent("PaGlobal_SkillGroup_All:handleEventLUp_SearchButton()")
  self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SearchButton()")
  self._ui._btn_search:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOut_SearchButton(true)")
  self._ui._btn_search:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOut_SearchButton(false)")
  self._ui._btn_filter:addInputEvent("Mouse_LUp", "PaGlobal_SkillFilter_Toggle()")
  self._ui._btn_filter:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOut_FilterButton(true)")
  self._ui._btn_filter:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOut_FilterButton(false)")
  self._ui._btn_allReset:addInputEvent("Mouse_LUp", "SkillEvent_SkillGroupWindow_ClearSkill(0)")
  self._ui._btn_allReset:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOut_AllResetButton(true)")
  self._ui._btn_allReset:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOut_AllResetButton(false)")
  self._ui._btn_skillSet:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowSkill\" )")
  self._ui._btn_skillSet:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOff_HelpButton(true)")
  self._ui._btn_skillSet:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOff_HelpButton(false)")
  self._ui._chk_playShow:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:viewControllerToggle()")
  self._ui._chk_playShow:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOut_PlaySkillButton(true)")
  self._ui._chk_playShow:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOut_PlaySkillButton(false)")
  self._ui._btn_naviSkillMaster:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_OnClickedFindNpcButton()")
  if PaGlobal_MovieSkillGuide_Web ~= nil then
    self._ui._btn_movie:addInputEvent("Mouse_LUp", "PaGlobal_MovieSkillGuide_Web:Open()")
    self._ui._btn_movie:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOut_MovieButton(true)")
    self._ui._btn_movie:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOut_MovieButton(false)")
  end
  self._ui._list2_upgradeList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_SkillGroup_All_CreateUpgradeSkillListContent")
  self._ui._list2_upgradeList:createChildContent(__ePAUIList2ElementManagerType_List)
  if self._isPadSnapping == true then
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_SkillGroup_All_OnClickedFindNpcButton()")
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_SkillGroup_All:selectPrevTab()")
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_SkillGroup_All:selectNextTab()")
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_SearchButton()")
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "PaGlobal_SkillGroup_All_FocusEditSearch()")
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "PaGlobalFunc_SkillGroup_All_OpenSkillShowAllClasses()")
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PaGlobal_SkillGroup_All_ResetSkillCamera()")
    self._ui._edit_search:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_SkillGroup_All_EndXboxKeyInput")
  end
end
function PaGlobal_SkillGroup_All:checkPlatform()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isPadSnapping == true then
    self._ui._keyguide_LB:SetShow(true)
    self._ui._keyguide_RB:SetShow(true)
    self._ui._keyguide_CameraBg:SetShow(true)
    self._ui._keyguide_Bg:SetShow(true)
    self._ui._keyguide_RT_X:SetShow(true)
    self._ui._keyguide_naviSkillMaster:SetShow(true)
    self._ui._btn_search:SetShow(false)
    self._ui._btn_naviSkillMaster:SetShow(false)
    self._ui._stc_bottomArea:SetShow(false)
    self._ui._btn_skillSet:SetShow(false)
    self._ui._btn_allReset:SetPosX(self._ui._btn_skillSet:GetPosX())
    self._ui._stc_skillPoint:SetSize(self._ui._stc_skillPoint:GetSizeX() + self._ui._btn_skillSet:GetSizeX() + 10, self._ui._stc_skillPoint:GetSizeY())
    self._ui._txt_skillPointValue:SetPosX(self._ui._txt_skillPointValue:GetPosX() + self._ui._btn_skillSet:GetSizeX() + 10)
    self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAY_BLACKSKILL"))
  else
    self._ui._keyguide_LB:SetShow(false)
    self._ui._keyguide_RB:SetShow(false)
    self._ui._keyguide_CameraBg:SetShow(false)
    self._ui._keyguide_Bg:SetShow(false)
    self._ui._keyguide_naviSkillMaster:SetShow(false)
    self._ui._keyguide_RT_X:SetShow(false)
    self._ui._btn_search:SetShow(true)
    self._ui._btn_naviSkillMaster:SetShow(true)
    self._ui._stc_bottomArea:SetShow(true)
    self._ui._btn_skillSet:SetShow(true)
  end
  self._originSkillPointSizeX = self._ui._stc_skillPoint:GetSizeX()
  self._originSkillPointValuePosX = self._ui._txt_skillPointValue:GetPosX()
  local isEnterAbyssOne = _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true
  if isEnterAbyssOne == true then
    self._ui._keyguide_naviSkillMaster:SetShow(false)
    self._ui._btn_naviSkillMaster:SetShow(false)
    Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  end
  if _ContentsOption_CH_GameType == true or isEnterAbyssOne == true then
    local gap = self._ui._btn_movie:GetSizeX() + 10
    self._ui._btn_movie:SetShow(false)
    self._ui._btn_showOtherCharSkill:SetSize(self._ui._btn_showOtherCharSkill:GetSizeX() + gap / 2, self._ui._btn_showOtherCharSkill:GetSizeY())
    self._ui._combo_skillSetting:SetSize(self._ui._combo_skillSetting:GetSizeX() + gap / 2, self._ui._combo_skillSetting:GetSizeY())
    self._ui._combo_skillSetting:SetSpanSize(self._ui._combo_skillSetting:GetSpanSize().x - gap, self._ui._combo_skillSetting:GetSpanSize().y)
    self._ui._combo_skillSetting:ComputePos()
  end
end
function PaGlobal_SkillGroup_All:prepareOpen()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if _ContentsGroup_ShowOtherClassSkill == false then
    return
  end
  if Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
    return
  end
  if ToClient_IsJoinQuizGame() == true then
    return
  end
  if isMoviePlayMode() == true then
    return
  end
  if ToClient_IsObserverModeInSolrare() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLOPENALERT_INDEAD"))
    return
  end
  if isDeadInWatchingMode() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLOPENALERT_INDEAD"))
  end
  ToClient_SaveUiInfo(false)
  if ToClient_SniperGame_IsPlaying() == true then
    return
  end
  if PaGloabl_MiniGame_GalleyPaddle_All_IsPlaying ~= nil and PaGloabl_MiniGame_GalleyPaddle_All_IsPlaying() == true then
    return
  end
  if PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction ~= nil and PaGlobal_Widget_HadumField_Enter_All_CheckHadumFieldEnterAction() == true or PaGlobalFunc_BossReward_IsOpen ~= nil and PaGlobalFunc_BossReward_IsOpen() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoMiniGameYachtDiceNotExitGame"))
    return
  end
  if MessageBoxGetShow() == true then
    allClearMessageData()
  end
  if Panel_Stamina ~= nil then
    self._isShowStaminaPanel = Panel_Stamina:GetShow()
  end
  if Panel_IngameCashShop_EasyPayment ~= nil and Panel_IngameCashShop_EasyPayment:GetShow() == true then
    PaGlobalFunc_EasyBuy_Close()
  end
  if _ContentsGroup_SkillFilter == true then
    PaGlobal_SkillFilter_ResetFilter()
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self._classType = selfPlayer:getClassType()
  self._isReverseSkillType = PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(self._classType)
  self._isWindow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSkillGroupWindowViewPlayPanel)
  self:defaultPanelResize()
  self:makeUIDataDefault()
  self:update()
  self:alignKeyguide(0)
  if _ContentsGroup_NewUI_Tooltip_All == true then
    PaGlobal_Tooltip_Control_All:hide()
    PaGlobal_Tooltip_Item_LinkedItem_All:prepareClose()
    PaGlobal_Tooltip_Item_LinkedClickItem_All:prepareClose()
  else
    Panel_Tooltip_Item_hideTooltip()
    Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  end
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  if self._isDialog == true then
    self._ui._chk_playShow:SetIgnore(true)
    self._ui._chk_playShow:SetMonoTone(true)
    self._ui._chk_playShow:addInputEvent("Mouse_LUp", "")
    self._ui._chk_playShow:addInputEvent("Mouse_On", "")
    self._ui._chk_playShow:addInputEvent("Mouse_Out", "")
    self._ui._chk_playShow:SetCheck(true)
    self._isWindow = not self._ui._chk_playShow:IsCheck()
    self:updateViewController()
  else
    self._ui._chk_playShow:SetIgnore(false)
    self._ui._chk_playShow:SetMonoTone(false)
    self._ui._chk_playShow:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:viewControllerToggle()")
    self._ui._chk_playShow:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleOnOut_PlaySkillButton(true)")
    self._ui._chk_playShow:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleOnOut_PlaySkillButton(false)")
    self:updateViewController()
  end
  if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == true then
    PaGlobal_BlackSpiritSkillLock_All:prepareClose()
  end
  if self._isPadSnapping == false then
    PaGlobal_SkillGroup_CoolTimeSlot:close()
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_OPEN_SKILLGROUP_WINDOW")
  ToClient_UpdateOpenUICondition(__eCheckOpenUIType_SkillUI)
  PaGlobal_SkillShowAllClasses_All:setControl()
  self:open()
end
function PaGlobal_SkillGroup_All:makeUIDataDefault()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:clearPoolData()
  self._skillSubGroupInfo = {}
  self._skillGroupInfo = {}
  self._lineInfo = {}
  self._fusionSkillInfo = {}
  self._fusionSkillResultInfo = {}
  self._searchSkillGroupInfo = {}
  self._searchFusionSkillInfo = {}
  self._selectedSkillType = self:getCurrentSkillType()
  self:makeSkillTypeArea()
  self:updateSkillTypeArea()
  self:makeMainWeaponSkillArea()
  self:makeAwakenSkillArea()
  self:makeFusionSkillArea()
  self:makeUpgradeSkillArea()
  if self._selectedTab == -1 then
    self._selectedTab = self._eTabType._mainWeapon
  end
  self._ui._edit_search:SetEditText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_EDIT_SEARCH"), false)
end
function PaGlobal_SkillGroup_All:open()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local showAni = self._isWindow and not self._isDialog
  Panel_Window_SkillGroup_All:SetShow(true, showAni)
end
function PaGlobal_SkillGroup_All:prepareClose()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self._clearSkillGroupKey = 0
  self:close()
  if ToClient_LearnSkillCameraIsShow() == true then
    local result = ToClient_LearnSkillCameraHide()
    if result == false then
      return
    end
  end
  if Panel_Window_SkillGroup_Controller:GetShow() == true then
    PaGlobal_SkillGroup_Controller:close()
  end
  if _ContentsGroup_NewUI_Tooltip_All == true then
    PaGlobal_Tooltip_Control_All:hide()
    PaGlobal_Tooltip_Item_LinkedItem_All:prepareClose()
    PaGlobal_Tooltip_Item_LinkedClickItem_All:prepareClose()
  else
    Panel_Tooltip_Item_hideTooltip()
    Panel_Tooltip_Item_chattingLinkedItemClick_hideTooltip()
  end
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  PaGlobal_SkillGroup_QuickSlot:close()
  if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == true then
    PaGlobal_BlackSpiritSkillLock_All:prepareClose()
  end
  if self._isPadSnapping == false then
    PaGlobal_SkillGroup_CoolTimeSlot:close()
  end
  if self._focusEffect ~= nil then
    self._focusEffect:EraseAllEffect()
    self._focusEffect = nil
  end
  self:updateEditMode(false)
  if self._isDialog == true then
    PaGlobalFunc_DialogMain_All_SetRenderMode()
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
    HandleEventLUp_DialogMain_All_BackClick()
    self._isDialog = false
  end
  if self._isShowStaminaPanel == true and Stamina_Update ~= nil then
    Stamina_Update()
  end
  if PaGlobal_SkillPreset_Close ~= nil then
    PaGlobal_SkillPreset_Close()
  end
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  if self._isPadSnapping == true and PaGlobalFunc_ConsoleKeyGuide_SetRideState ~= nil then
    PaGlobalFunc_ConsoleKeyGuide_SetRideState()
  end
  PaGlobalFunc_SkillWindowCloseTimeReset()
  if ToClient_isInAbyssOne() == false then
    PaGlobal_MainStatus_AttackStatusUpdate()
    if self._isPadSnapping == false then
      PaGlobal_SelfPlayerExpGage_AttackInfoUpdate()
    end
  end
end
function PaGlobal_SkillGroup_All:close()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local showAni = self._isWindow and self._showAni and not self._isDialog
  Panel_Window_SkillGroup_All:SetShow(false, showAni)
  self._showAni = true
end
function PaGlobal_SkillGroup_All:makeDefaultUI()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  for i = 1, self._skillGroupPool_maxCount_main do
    local uiInfo = {
      _control = UI.cloneControl(self._ui._stc_templete_skillGroup, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillGroup_" .. i),
      _slot = {},
      _isUse = false
    }
    local iconBg = UI.getChildControl(uiInfo._control, "Static_SlotIcon")
    SlotSkill.new(uiInfo._slot, i, iconBg, self._slotConfig)
    self._skillGroupPool_main[i] = uiInfo
  end
  for i = 1, self._skillGroupPool_maxCount_awaken do
    local uiInfo = {
      _control = UI.cloneControl(self._ui._stc_templete_skillGroup, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillGroup_" .. i),
      _slot = {},
      _isUse = false
    }
    local iconBg = UI.getChildControl(uiInfo._control, "Static_SlotIcon")
    SlotSkill.new(uiInfo._slot, i, iconBg, self._slotConfig)
    self._skillGroupPool_awaken[i] = uiInfo
  end
  for i = 1, self._skillSubGroupPool_maxCount_main do
    local uiInfo = {
      _control = UI.cloneControl(self._ui._rdo_templete_skillSubGroup, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillSubGroup_" .. i),
      _isUse = false
    }
    self._skillSubGroupPool_main[i] = uiInfo
  end
  for i = 1, self._skillSubGroupPool_maxCount_awaken do
    local uiInfo = {
      _control = UI.cloneControl(self._ui._rdo_templete_skillSubGroup, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillSubGroup_" .. i),
      _isUse = false
    }
    self._skillSubGroupPool_awaken[i] = uiInfo
  end
  for i = 1, self._line_maxCount do
    local stc_a = UI.getChildControl(self._ui._stc_templete_lineControl, "Static_A_" .. i)
    local stc_c = UI.getChildControl(self._ui._stc_templete_lineControl, "Static_C_" .. i)
    self._lineAPool_main[i] = {}
    for ii = 1, self._lineAPool_maxCount_main[i] do
      local uiInfo = {
        _control = UI.cloneControl(stc_a, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillLine_A_" .. i .. "_" .. ii),
        _isUse = false
      }
      self._lineAPool_main[i][ii] = uiInfo
    end
    self._lineCPool_main[i] = {}
    for ii = 1, self._lineCPool_maxCount_main[i] do
      local uiInfo = {
        _control = UI.cloneControl(stc_c, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillLine_C_" .. i .. "_" .. ii),
        _isUse = false
      }
      self._lineCPool_main[i][ii] = uiInfo
    end
    self._lineAPool_awaken[i] = {}
    for ii = 1, self._lineAPool_maxCount_awaken[i] do
      local uiInfo = {
        _control = UI.cloneControl(stc_a, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillLine_A_" .. i .. "_" .. ii),
        _isUse = false
      }
      self._lineAPool_awaken[i][ii] = uiInfo
    end
    self._lineCPool_awaken[i] = {}
    for ii = 1, self._lineCPool_maxCount_awaken[i] do
      local uiInfo = {
        _control = UI.cloneControl(stc_c, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillLine_C_" .. i .. "_" .. ii),
        _isUse = false
      }
      self._lineCPool_awaken[i][ii] = uiInfo
    end
  end
  for i = 1, self._fusionSkillPool_maxCount do
    local uiInfo = {
      _control = UI.cloneControl(self._ui._stc_templete_fusionSkill, self._ui._frame_fusionSkill:GetFrameContent(), "FusionSkill_" .. i),
      _mainSlot = {},
      _subSlot1 = {},
      _subSlot2 = {},
      _resultSlot1 = {},
      _resultSlot2 = {},
      _isUse = false
    }
    local slot = UI.getChildControl(uiInfo._control, "Static_MainSlot")
    local iconBg = UI.getChildControl(slot, "Static_MainIcon")
    SlotSkill.new(uiInfo._mainSlot, i, iconBg, self._slotConfig)
    slot = UI.getChildControl(uiInfo._control, "Static_SubSlot1")
    iconBg = UI.getChildControl(slot, "Static_MainIcon")
    SlotSkill.new(uiInfo._subSlot1, i, iconBg, self._slotConfig)
    slot = UI.getChildControl(uiInfo._control, "Static_SubSlot2")
    iconBg = UI.getChildControl(slot, "Static_MainIcon")
    SlotSkill.new(uiInfo._subSlot2, i, iconBg, self._slotConfig)
    slot = UI.getChildControl(uiInfo._control, "RadioButton_ResultSlot1")
    iconBg = UI.getChildControl(slot, "Static_MainIcon")
    SlotSkill.new(uiInfo._resultSlot1, i, iconBg, self._slotConfig)
    slot = UI.getChildControl(uiInfo._control, "RadioButton_ResultSlot2")
    iconBg = UI.getChildControl(slot, "Static_MainIcon")
    SlotSkill.new(uiInfo._resultSlot2, i, iconBg, self._slotConfig)
    self._fusionSkillPool[i] = uiInfo
    local uiInfo_result = {
      _control = UI.cloneControl(self._ui._stc_templete_fusionSkillResult, self._ui._stc_fusionSkillTopArea, "FusionSkillResult_" .. i),
      _slot = {},
      _isUse = false
    }
    local iconBg = UI.getChildControl(uiInfo_result._control, "Static_Slot")
    SlotSkill.new(uiInfo_result._slot, i, iconBg, self._slotConfig)
    self._fusionSkillResultPool[i] = uiInfo_result
  end
  self._btn_skillPresetList = {}
  self._btn_skillPresetLockList = {}
  if _ContentsGroup_SkillPreset == true then
    self._presetSlotMaxCount = ToClient_getSkillPresetSlotMaxCount()
    local isEnterAbyssOne = _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true
    local gapY = 10
    for i = 1, self._presetSlotMaxCount do
      local index = i - 1
      local posY = self._ui._btn_presetSave:GetPosX() + self._ui._btn_presetSave:GetSizeY() + i * gapY + (i - 1) * self._ui._rdo_preset_templete:GetSizeX()
      local rdo_skillPreset = UI.cloneControl(self._ui._rdo_preset_templete, self._ui._stc_presetBG, "Radio_SkillPreset_" .. i)
      rdo_skillPreset:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot" .. tostring(i) .. "_Normal", 0)
      rdo_skillPreset:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot" .. tostring(i) .. "_Over", 1)
      rdo_skillPreset:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot" .. tostring(i) .. "_Click", 2)
      rdo_skillPreset:setRenderTexture(rdo_skillPreset:getBaseTexture())
      rdo_skillPreset:SetPosY(posY)
      rdo_skillPreset:SetShow(true)
      rdo_skillPreset:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_applyConfirmSkillPreset(" .. tostring(index) .. ")")
      rdo_skillPreset:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:showSkillPresetToolTip(" .. index .. ")")
      rdo_skillPreset:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
      if self._isPadSnapping == true then
        rdo_skillPreset:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SkillPresetMemo_Open( PaGloabal_SkillPresetMemo._OPENTYPE._SKILL, " .. tostring(index) .. ")")
      else
        rdo_skillPreset:addInputEvent("Mouse_RUp", "PaGlobalFunc_SkillPresetMemo_Open( PaGloabal_SkillPresetMemo._OPENTYPE._SKILL, " .. tostring(index) .. ")")
      end
      self._btn_skillPresetList[i] = rdo_skillPreset
      local btn_lockPreset = UI.cloneControl(self._ui._btn_lock_templete, self._ui._stc_presetBG, "Button_LockPreset_" .. i)
      btn_lockPreset:SetPosY(posY)
      btn_lockPreset:SetShow(false)
      btn_lockPreset:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:showLockSkillPresetToolTip(true, " .. index .. ")")
      btn_lockPreset:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:showLockSkillPresetToolTip(false)")
      if isEnterAbyssOne == true then
        btn_lockPreset:addInputEvent("Mouse_LUp", "")
      else
        btn_lockPreset:addInputEvent("Mouse_LUp", "PaGlobal_SkillPreset_lockPresetBuy()")
      end
      self._btn_skillPresetLockList[i] = btn_lockPreset
    end
    self._ui._btn_presetSave:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_SkillPresetSaveOpen()")
    self._ui._btn_presetSave:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:showSkillPresetToolTip(" .. self._presetSlotMaxCount .. ")")
    self._ui._btn_presetSave:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    self._ui._btn_presetSave:SetShow(true)
    local presetBgSizeY = self._ui._btn_presetSave:GetPosX() + self._ui._btn_presetSave:GetSizeY() + gapY + (self._presetSlotMaxCount * (self._ui._rdo_preset_templete:GetSizeX() + gapY) + 5)
    self._ui._stc_presetBG:SetSize(self._ui._stc_presetBG:GetSizeX(), presetBgSizeY)
    self._ui._stc_presetBG:ComputePos()
  end
  self._ui._btn_showOtherCharSkill:SetShow(true)
  self._ui._combo_skillSetting:SetShow(true)
  self._ui._combo_skillSetting:GetListControl():SetIgnore(false)
  self._ui._combo_skillSetting:GetListControl():AddSelectEvent("PaGlobalFunc_SkillGroup_All_SelectSkillSetting()")
  self._ui._combo_skillSetting:setListTextHorizonCenter()
  self._ui._combo_skillSetting:DeleteAllItem()
  self._ui._combo_skillSetting:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PLAYSKILL_QUICKSLOT_SET"))
  self._ui._combo_skillSetting:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_COOLTIME_TITLE"))
  self._ui._combo_skillSetting:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLACKSPIRITLOCK_TITLE"))
  self._tabList = {}
  self._tabList[0] = self._ui._rdo_tab_mainWeapon
  self._tabList[1] = self._ui._rdo_tab_awakenWeapon
  self._tabList[2] = self._ui._rdo_tab_fusionSkill
  self._tabList[3] = self._ui._rdo_tab_upgradeSkill
end
function PaGlobal_SkillGroup_All:getUIByPool(poolType, lineIndex)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local control
  if poolType == self._ePoolType._skillGroup_main then
    if self._skillGroupPool_maxCount_main <= self._skillGroupPool_index_main then
      for i = self._skillGroupPool_maxCount_main + 1, self._skillGroupPool_maxCount_main * 2 do
        local uiInfo = {
          _control = UI.cloneControl(self._ui._stc_templete_skillGroup, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillGroup_" .. i),
          _slot = {},
          _isUse = false
        }
        local iconBg = UI.getChildControl(uiInfo._control, "Static_SlotIcon")
        SlotSkill.new(uiInfo._slot, i, iconBg, self._slotConfig)
        self._skillGroupPool_main[i] = uiInfo
      end
      self._skillGroupPool_maxCount_main = self._skillGroupPool_maxCount_main * 2
    end
    self._skillGroupPool_index_main = self._skillGroupPool_index_main + 1
    self._skillGroupPool_main[self._skillGroupPool_index_main]._isUse = true
    return self._skillGroupPool_main[self._skillGroupPool_index_main]
  elseif poolType == self._ePoolType._subSkillGroup_main then
    if self._skillSubGroupPool_maxCount_main <= self._skillSubGroupPool_index_main then
      for i = self._skillSubGroupPool_maxCount_main + 1, self._skillSubGroupPool_maxCount_main * 2 do
        local uiInfo = {
          _control = UI.cloneControl(self._ui._rdo_templete_skillSubGroup, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillSubGroup_" .. i),
          _isUse = false
        }
        self._skillSubGroupPool_main[i] = uiInfo
      end
      self._skillSubGroupPool_maxCount_main = self._skillSubGroupPool_maxCount_main * 2
    end
    self._skillSubGroupPool_index_main = self._skillSubGroupPool_index_main + 1
    self._skillSubGroupPool_main[self._skillSubGroupPool_index_main]._isUse = true
    return self._skillSubGroupPool_main[self._skillSubGroupPool_index_main]
  elseif poolType == self._ePoolType._skillGroup_awaken then
    if self._skillGroupPool_maxCount_awaken <= self._skillGroupPool_index_awaken then
      for i = self._skillGroupPool_maxCount_awaken + 1, self._skillGroupPool_maxCount_awaken * 2 do
        local uiInfo = {
          _control = UI.cloneControl(self._ui._stc_templete_skillGroup, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillGroup_" .. i),
          _slot = {},
          _isUse = false
        }
        local iconBg = UI.getChildControl(uiInfo._control, "Static_SlotIcon")
        SlotSkill.new(uiInfo._slot, i, iconBg, self._slotConfig)
        self._skillGroupPool_awaken[i] = uiInfo
      end
      self._skillGroupPool_maxCount_awaken = self._skillGroupPool_maxCount_awaken * 2
    end
    self._skillGroupPool_index_awaken = self._skillGroupPool_index_awaken + 1
    self._skillGroupPool_awaken[self._skillGroupPool_index_awaken]._isUse = true
    return self._skillGroupPool_awaken[self._skillGroupPool_index_awaken]
  elseif poolType == self._ePoolType._subSkillGroup_awaken then
    if self._skillSubGroupPool_maxCount_awaken <= self._skillSubGroupPool_index_awaken then
      for i = self._skillSubGroupPool_maxCount_awaken + 1, self._skillSubGroupPool_maxCount_awaken * 2 do
        local uiInfo = {
          _control = UI.cloneControl(self._ui._rdo_templete_skillSubGroup, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillSubGroup_" .. i),
          _isUse = false
        }
        self._skillSubGroupPool_awaken[i] = uiInfo
      end
      self._skillSubGroupPool_maxCount_awaken = self._skillSubGroupPool_maxCount_awaken * 2
    end
    self._skillSubGroupPool_index_awaken = self._skillSubGroupPool_index_awaken + 1
    self._skillSubGroupPool_awaken[self._skillSubGroupPool_index_awaken]._isUse = true
    return self._skillSubGroupPool_awaken[self._skillSubGroupPool_index_awaken]
  elseif poolType == self._ePoolType._fusionSkill or poolType == self._ePoolType._fusionSkillResult then
    if self._fusionSkillPool_maxCount <= self._fusionSkillPool_index or self._fusionSkillPool_maxCount <= self._fusionSkillResultPool_index then
      for i = self._fusionSkillPool_maxCount + 1, self._fusionSkillPool_maxCount * 2 do
        local uiInfo = {
          _control = UI.cloneControl(self._ui._stc_templete_fusionSkill, self._ui._frame_fusionSkill:GetFrameContent(), "FusionSkill_" .. i),
          _mainSlot = {},
          _subSlot1 = {},
          _subSlot2 = {},
          _resultSlot1 = {},
          _resultSlot2 = {},
          _isUse = false
        }
        local slot = UI.getChildControl(uiInfo._control, "Static_MainSlot")
        local iconBg = UI.getChildControl(slot, "Static_MainIcon")
        SlotSkill.new(uiInfo._mainSlot, i, iconBg, self._slotConfig)
        slot = UI.getChildControl(uiInfo._control, "Static_SubSlot1")
        iconBg = UI.getChildControl(slot, "Static_MainIcon")
        SlotSkill.new(uiInfo._subSlot1, i, iconBg, self._slotConfig)
        slot = UI.getChildControl(uiInfo._control, "Static_SubSlot2")
        iconBg = UI.getChildControl(slot, "Static_MainIcon")
        SlotSkill.new(uiInfo._subSlot2, i, iconBg, self._slotConfig)
        slot = UI.getChildControl(uiInfo._control, "RadioButton_ResultSlot1")
        iconBg = UI.getChildControl(slot, "Static_MainIcon")
        SlotSkill.new(uiInfo._resultSlot1, i, iconBg, self._slotConfig)
        slot = UI.getChildControl(uiInfo._control, "RadioButton_ResultSlot2")
        iconBg = UI.getChildControl(slot, "Static_MainIcon")
        SlotSkill.new(uiInfo._resultSlot2, i, iconBg, self._slotConfig)
        self._fusionSkillPool[i] = uiInfo
        local uiInfo_result = {
          _control = UI.cloneControl(self._ui._stc_templete_fusionSkillResult, self._ui._stc_fusionSkillTopArea, "FusionSkillResult_" .. i),
          _slot = {},
          _isUse = false
        }
        local iconBg = UI.getChildControl(uiInfo_result._control, "Static_Slot")
        SlotSkill.new(uiInfo_result._slot, i, iconBg, self._slotConfig)
        self._fusionSkillResultPool[i] = uiInfo_result
      end
      self._fusionSkillPool_maxCount = self._fusionSkillPool_maxCount * 2
    end
    if poolType == self._ePoolType._fusionSkill then
      self._fusionSkillPool_index = self._fusionSkillPool_index + 1
      self._fusionSkillPool[self._fusionSkillPool_index]._isUse = true
      return self._fusionSkillPool[self._fusionSkillPool_index]
    else
      self._fusionSkillResultPool_index = self._fusionSkillResultPool_index + 1
      self._fusionSkillResultPool[self._fusionSkillResultPool_index]._isUse = true
      return self._fusionSkillResultPool[self._fusionSkillResultPool_index]
    end
  elseif poolType == self._ePoolType._lineA_main then
    if lineIndex == nil then
      return
    end
    if self._lineAPool_maxCount_main[lineIndex] <= self._lineAPool_index_main[lineIndex] then
      local stc_a = UI.getChildControl(self._ui._stc_templete_lineControl, "Static_A_" .. lineIndex)
      for i = self._lineAPool_maxCount_main[lineIndex] + 1, self._lineAPool_maxCount_main[lineIndex] * 2 do
        local uiInfo = {
          _control = UI.cloneControl(stc_a, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillLine_A_" .. lineIndex .. "_" .. i),
          _isUse = false
        }
        self._lineAPool_main[lineIndex][i] = uiInfo
      end
      self._lineAPool_maxCount_main[lineIndex] = self._lineAPool_maxCount_main[lineIndex] * 2
    end
    self._lineAPool_index_main[lineIndex] = self._lineAPool_index_main[lineIndex] + 1
    self._lineAPool_main[lineIndex][self._lineAPool_index_main[lineIndex]]._isUse = true
    return self._lineAPool_main[lineIndex][self._lineAPool_index_main[lineIndex]]
  elseif poolType == self._ePoolType._lineA_awaken then
    if lineIndex == nil then
      return
    end
    if self._lineAPool_maxCount_awaken[lineIndex] <= self._lineAPool_index_awaken[lineIndex] then
      local stc_a = UI.getChildControl(self._ui._stc_templete_lineControl, "Static_A_" .. lineIndex)
      for i = self._lineAPool_maxCount_awaken[lineIndex] + 1, self._lineAPool_maxCount_awaken[lineIndex] * 2 do
        local uiInfo = {
          _control = UI.cloneControl(stc_a, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillLine_A_" .. lineIndex .. "_" .. i),
          _isUse = false
        }
        self._lineAPool_awaken[lineIndex][i] = uiInfo
      end
      self._lineAPool_maxCount_awaken[lineIndex] = self._lineAPool_maxCount_awaken[lineIndex] * 2
    end
    self._lineAPool_index_awaken[lineIndex] = self._lineAPool_index_awaken[lineIndex] + 1
    self._lineAPool_awaken[lineIndex][self._lineAPool_index_awaken[lineIndex]]._isUse = true
    return self._lineAPool_awaken[lineIndex][self._lineAPool_index_awaken[lineIndex]]
  elseif poolType == self._ePoolType._lineC_main then
    if lineIndex == nil then
      return
    end
    if self._lineCPool_maxCount_main[lineIndex] <= self._lineCPool_index_main[lineIndex] then
      local stc_c = UI.getChildControl(self._ui._stc_templete_lineControl, "Static_C_" .. lineIndex)
      for i = self._lineCPool_maxCount_main[lineIndex] + 1, self._lineCPool_maxCount_main[lineIndex] * 2 do
        local uiInfo = {
          _control = UI.cloneControl(stc_c, self._ui._frame_skillGroupArea_main:GetFrameContent(), "SkillLine_C_" .. lineIndex .. "_" .. i),
          _isUse = false
        }
        self._lineCPool_main[lineIndex][i] = uiInfo
      end
      self._lineCPool_maxCount_main[lineIndex] = self._lineCPool_maxCount_main[lineIndex] * 2
    end
    self._lineCPool_index_main[lineIndex] = self._lineCPool_index_main[lineIndex] + 1
    self._lineCPool_main[lineIndex][self._lineCPool_index_main[lineIndex]]._isUse = true
    return self._lineCPool_main[lineIndex][self._lineCPool_index_main[lineIndex]]
  elseif poolType == self._ePoolType._lineC_awaken then
    if lineIndex == nil then
      return
    end
    if self._lineCPool_maxCount_awaken[lineIndex] <= self._lineCPool_index_awaken[lineIndex] then
      local stc_c = UI.getChildControl(self._ui._stc_templete_lineControl, "Static_C_" .. lineIndex)
      for i = self._lineCPool_maxCount_awaken[lineIndex] + 1, self._lineCPool_maxCount_awaken[lineIndex] * 2 do
        local uiInfo = {
          _control = UI.cloneControl(stc_c, self._ui._frame_skillGroupArea_awaken:GetFrameContent(), "SkillLine_C_" .. lineIndex .. "_" .. i),
          _isUse = false
        }
        self._lineCPool_awaken[lineIndex][i] = uiInfo
      end
      self._lineCPool_maxCount_awaken[lineIndex] = self._lineCPool_maxCount_awaken[lineIndex] * 2
    end
    self._lineCPool_index_awaken[lineIndex] = self._lineCPool_index_awaken[lineIndex] + 1
    self._lineCPool_awaken[lineIndex][self._lineCPool_index_awaken[lineIndex]]._isUse = true
    return self._lineCPool_awaken[lineIndex][self._lineCPool_index_awaken[lineIndex]]
  end
  return nil
end
function PaGlobal_SkillGroup_All:clearPoolData()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  for i = 1, self._skillGroupPool_index_main do
    self._skillGroupPool_main[i]._control:SetShow(false)
    self._skillGroupPool_main[i]._slot:clearSkill()
    self._skillGroupPool_main[i]._isUse = false
  end
  for i = 1, self._skillGroupPool_index_awaken do
    self._skillGroupPool_awaken[i]._control:SetShow(false)
    self._skillGroupPool_awaken[i]._slot:clearSkill()
    self._skillGroupPool_awaken[i]._isUse = false
  end
  for i = 1, self._skillSubGroupPool_index_main do
    self._skillSubGroupPool_main[i]._control:SetShow(false)
    self._skillSubGroupPool_main[i]._isUse = false
  end
  for i = 1, self._skillSubGroupPool_index_awaken do
    self._skillSubGroupPool_awaken[i]._control:SetShow(false)
    self._skillSubGroupPool_awaken[i]._isUse = false
  end
  for i = 1, self._fusionSkillPool_index do
    self._fusionSkillPool[i]._control:SetShow(false)
    self._fusionSkillPool[i]._mainSlot:clearSkill()
    self._fusionSkillPool[i]._subSlot1:clearSkill()
    self._fusionSkillPool[i]._subSlot2:clearSkill()
    self._fusionSkillPool[i]._resultSlot1:clearSkill()
    self._fusionSkillPool[i]._resultSlot2:clearSkill()
    self._fusionSkillPool[i]._isUse = false
  end
  for i = 1, self._fusionSkillResultPool_index do
    self._fusionSkillResultPool[i]._control:SetShow(false)
    self._fusionSkillResultPool[i]._slot:clearSkill()
    self._fusionSkillResultPool[i]._isUse = false
  end
  for i = 1, self._line_maxCount do
    for ii = 1, self._lineAPool_index_main[i] do
      self._lineAPool_main[i][ii]._control:SetShow(false)
      self._lineAPool_main[i][ii]._isUse = false
    end
    for ii = 1, self._lineCPool_index_main[i] do
      self._lineCPool_main[i][ii]._control:SetShow(false)
      self._lineCPool_main[i][ii]._isUse = false
    end
    for ii = 1, self._lineAPool_index_awaken[i] do
      self._lineAPool_awaken[i][ii]._control:SetShow(false)
      self._lineAPool_awaken[i][ii]._isUse = false
    end
    for ii = 1, self._lineCPool_index_awaken[i] do
      self._lineCPool_awaken[i][ii]._control:SetShow(false)
      self._lineCPool_awaken[i][ii]._isUse = false
    end
  end
  self._skillGroupPool_index_main = 0
  self._skillSubGroupPool_index_main = 0
  self._lineAPool_index_main = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  }
  self._lineCPool_index_main = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  }
  self._skillGroupPool_index_awaken = 0
  self._skillSubGroupPool_index_awaken = 0
  self._lineAPool_index_awaken = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  }
  self._lineCPool_index_awaken = {
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0
  }
  self._fusionSkillPool_index = 0
  self._fusionSkillResultPool_index = 0
end
function PaGlobal_SkillGroup_All:update()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:updateStat()
  self:updateSkillPresetArea()
  self:selectTab(self._selectedTab)
end
function PaGlobal_SkillGroup_All:makeDefaultSkillArea(skillGroupType)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local skillGroupPoolType = self._ePoolType._count
  local subSkillGroupPoolType = self._ePoolType._count
  local lineAPoolType = self._ePoolType._count
  local lineCPoolType = self._ePoolType._count
  if skillGroupType == __eSkillGroupType_Combat then
    skillGroupPoolType = self._ePoolType._skillGroup_main
    subSkillGroupPoolType = self._ePoolType._subSkillGroup_main
    lineAPoolType = self._ePoolType._lineA_main
    lineCPoolType = self._ePoolType._lineC_main
  elseif skillGroupType == __eSkillGroupType_Awakening then
    skillGroupPoolType = self._ePoolType._skillGroup_awaken
    subSkillGroupPoolType = self._ePoolType._subSkillGroup_awaken
    lineAPoolType = self._ePoolType._lineA_awaken
    lineCPoolType = self._ePoolType._lineC_awaken
  else
    return
  end
  local tableWrapper = ToClient_getSkillGroupCellTableWrapper(skillGroupType, self._classType)
  if tableWrapper == nil then
    return
  end
  local colMaxCount = tableWrapper:sizeX()
  local rowMaxCount = tableWrapper:sizeY()
  local subGroupSize = tableWrapper:getSubGroupSizeByClassType(self._classType)
  for i = 0, subGroupSize - 1 do
    local uiInfo = self:getUIByPool(subSkillGroupPoolType)
    local skillSubGroupInfo = {
      _subGroupIndex = i,
      _control = uiInfo._control,
      _name = PAGetString(Defines.StringSheet_GAME, tableWrapper:getSubGroupStringKeyByClassType(i, self._classType)),
      _isActiveItemGroup = false
    }
    if skillSubGroupInfo._name == PAGetString(Defines.StringSheet_GAME, "LUA_SKILLTREE_PANEL_NAME6") then
      skillSubGroupInfo._isActiveItemGroup = true
    end
    local txt_subGroupName = UI.getChildControl(skillSubGroupInfo._control, "StaticText_SkillSubName")
    if txt_subGroupName ~= nil then
      txt_subGroupName:SetText(skillSubGroupInfo._name)
    end
    skillSubGroupInfo._control:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:updateDefaultSkillAreaPosition(" .. skillGroupType .. ")")
    if self._isPadSnapping == true then
      skillSubGroupInfo._control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(1)")
    end
    local subGroupKey = tostring(skillGroupType) .. "," .. tostring(i)
    self._skillSubGroupInfo[subGroupKey] = skillSubGroupInfo
  end
  for row = 0, rowMaxCount - 1 do
    for col = 0, colMaxCount - 1 do
      cellWrapper = tableWrapper:atWrapper(col, row)
      if cellWrapper ~= nil and cellWrapper:isDefined() == true then
        local cellType = cellWrapper:getType(0)
        if __eSkillGroupCellType_SkillGroup == cellType then
          local key = cellWrapper:getSkillGroupNo()
          local subGroupNo = cellWrapper:getSubGroupNo()
          local skillKey = ToClient_getSkillKeyBySkillGroupNo(key, 1)
          if skillKey:isDefined() == false then
            return
          end
          local skillNo = skillKey:getSkillNo()
          local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
          if skillTypeSSW == nil then
            return
          end
          if skillKey:isDefined() == true and PaGlobalFunc_Skill_IsBlockByConsoleSkill(skillKey:getSkillNo()) == false then
            local uiInfo = self:getUIByPool(skillGroupPoolType)
            local skillGroupInfo = {
              _key = key,
              _control = uiInfo._control,
              _subGroupNo = subGroupNo,
              _skillGroupType = skillGroupType,
              _maxLevel = ToClient_getSkillGroupMaxLevel(key),
              _isValidLocalizing = skillTypeSSW:isValidLocalizing(),
              _slot = uiInfo._slot,
              _learnPlusEffect = UI.getChildControl(uiInfo._control, "Static_Icon_Skill_Effect"),
              _ableQuickSlotEffect = UI.getChildControl(uiInfo._control, "Static_QuickSlotRegist"),
              _focusIcon = UI.getChildControl(uiInfo._control, "Static_SkillLevelFocus"),
              _skillName = UI.getChildControl(uiInfo._control, "StaticText_SkillName"),
              _btn_prev = UI.getChildControl(uiInfo._control, "Button_LeftArrow"),
              _btn_next = UI.getChildControl(uiInfo._control, "Button_RIghtArrow"),
              _check_command = UI.getChildControl(uiInfo._control, "CheckButton_Lock_Skill"),
              _showCheckCommand = false,
              _isBlockSkill = false,
              _name = "",
              _isActiveItemSkill = PaGlobalFunc_SkillGroup_All_IsActiveItemSkill(skillKey),
              _possibleMaxLevel = 1,
              _selectLevel = 1
            }
            skillGroupInfo._control:SetShow(false)
            skillGroupInfo._control:SetResetPressControl(false)
            skillGroupInfo._slot.icon:SetAutoDisableTime(0.5)
            for level = 1, skillGroupInfo._maxLevel do
              local currentLevelSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, level)
              if currentLevelSkillKey:isDefined() == true then
                local isLearn = ToClient_isLearnedSkill(currentLevelSkillKey:getSkillNo())
                if isLearn == true then
                  skillGroupInfo._selectLevel = level
                  skillGroupInfo._possibleMaxLevel = level
                end
              end
            end
            skillGroupInfo._skillName:SetTextMode(__eTextMode_Limit_AutoWrap)
            skillGroupInfo._focusIcon:SetShow(false)
            skillGroupInfo._btn_prev:SetShow(false)
            skillGroupInfo._btn_next:SetShow(false)
            skillGroupInfo._check_command:SetShow(false)
            self:skillGroupInfo_registEvent(skillGroupInfo)
            self:skillGroupInfo_selectLevel(skillGroupInfo, skillGroupInfo._selectLevel)
            self._skillGroupInfo[key] = skillGroupInfo
            if self._searchSkillGroupInfo[0] == nil then
              self._searchSkillGroupInfo[#self._searchSkillGroupInfo] = skillGroupInfo
            else
              self._searchSkillGroupInfo[#self._searchSkillGroupInfo + 1] = skillGroupInfo
            end
          end
        else
          local key = tostring(skillGroupType) .. ":" .. tostring(col) .. "," .. tostring(row)
          local cellTypeSize = cellWrapper:getTypeSize()
          self._lineInfo[key] = {}
          local index = 1
          for i = 0, cellTypeSize - 1 do
            cellType = cellWrapper:getType(i)
            if cellType == __eSkillGroupCellType_Blank then
              break
            end
            local uiInfo
            if 2 == col % 3 then
              uiInfo = self:getUIByPool(lineAPoolType, cellType - 2)
            else
              uiInfo = self:getUIByPool(lineCPoolType, cellType - 2)
            end
            local lineInfo = {
              _control = uiInfo._control,
              _lineIndex = cellType - 2,
              _isAddLine = false
            }
            lineInfo._control:SetShow(false)
            self._lineInfo[key][index] = lineInfo
            index = index + 1
            if cellType == __eSkillGroupCellType_LM or cellType == __eSkillGroupCellType_CM or cellType == __eSkillGroupCellType_RM or cellType == __eSkillGroupCellType_LB or cellType == __eSkillGroupCellType_CB or cellType == __eSkillGroupCellType_RB or cellType == __eSkillGroupCellType_Vert then
              local addUiInfo
              if 2 == col % 3 then
                addUiInfo = self:getUIByPool(lineAPoolType, 11)
              else
                addUiInfo = self:getUIByPool(lineCPoolType, 11)
              end
              local addLineInfo = {
                _control = addUiInfo._control,
                _lineIndex = 11,
                _isAddLine = true
              }
              addLineInfo._control:SetShow(false)
              self._lineInfo[key][index] = addLineInfo
              index = index + 1
            end
          end
        end
      end
    end
  end
end
function PaGlobal_SkillGroup_All:updateDefaultSkillArea(skillGroupType)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local tableWrapper = ToClient_getSkillGroupCellTableWrapper(skillGroupType, self._classType)
  if tableWrapper == nil then
    return
  end
  local colMaxCount = tableWrapper:sizeX()
  local rowMaxCount = tableWrapper:sizeY()
  local subGroupSize = tableWrapper:getSubGroupSizeByClassType(self._classType)
  for row = 0, rowMaxCount - 1 do
    for col = 0, colMaxCount - 1 do
      cellWrapper = tableWrapper:atWrapper(col, row)
      if cellWrapper ~= nil and cellWrapper:isDefined() == true then
        local cellType = cellWrapper:getType(0)
        if __eSkillGroupCellType_SkillGroup == cellType then
          local key = cellWrapper:getSkillGroupNo()
          local subGroupNo = cellWrapper:getSubGroupNo()
          local skillKey = ToClient_getSkillKeyBySkillGroupNo(key, 1)
          if skillKey:isDefined() == false then
            return
          end
          local skillNo = skillKey:getSkillNo()
          local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
          if skillTypeSSW == nil then
            return
          end
          if skillKey:isDefined() == true and PaGlobalFunc_Skill_IsBlockByConsoleSkill(skillKey:getSkillNo()) == false then
            local skillGroupInfo = self._skillGroupInfo[key]
            if skillGroupInfo == nil then
              local uiInfo = self:getUIByPool(skillGroupPoolType)
              skillGroupInfo = {
                _key = key,
                _control = uiInfo._control,
                _subGroupNo = subGroupNo,
                _skillGroupType = skillGroupType,
                _maxLevel = ToClient_getSkillGroupMaxLevel(key),
                _isValidLocalizing = skillTypeSSW:isValidLocalizing(),
                _slot = uiInfo._slot,
                _learnPlusEffect = UI.getChildControl(uiInfo._control, "Static_Icon_Skill_Effect"),
                _ableQuickSlotEffect = UI.getChildControl(uiInfo._control, "Static_QuickSlotRegist"),
                _focusIcon = UI.getChildControl(uiInfo._control, "Static_SkillLevelFocus"),
                _skillName = UI.getChildControl(uiInfo._control, "StaticText_SkillName"),
                _btn_prev = UI.getChildControl(uiInfo._control, "Button_LeftArrow"),
                _btn_next = UI.getChildControl(uiInfo._control, "Button_RIghtArrow"),
                _check_command = UI.getChildControl(uiInfo._control, "CheckButton_Lock_Skill"),
                _showCheckCommand = false,
                _isBlockSkill = false,
                _name = "",
                _isActiveItemSkill = PaGlobalFunc_SkillGroup_All_IsActiveItemSkill(skillKey),
                _possibleMaxLevel = 1,
                _selectLevel = 1
              }
              skillGroupInfo._control:SetShow(false)
              skillGroupInfo._slot.icon:SetAutoDisableTime(0.5)
            end
            for level = 1, skillGroupInfo._maxLevel do
              local currentLevelSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, level)
              if currentLevelSkillKey:isDefined() == true then
                local isLearn = ToClient_isLearnedSkill(currentLevelSkillKey:getSkillNo())
                if isLearn == true then
                  skillGroupInfo._selectLevel = level
                  skillGroupInfo._possibleMaxLevel = level
                end
              end
            end
            skillGroupInfo._skillName:SetTextMode(__eTextMode_Limit_AutoWrap)
            skillGroupInfo._focusIcon:SetShow(false)
            skillGroupInfo._btn_prev:SetShow(false)
            skillGroupInfo._btn_next:SetShow(false)
            skillGroupInfo._check_command:SetShow(false)
            self:skillGroupInfo_registEvent(skillGroupInfo)
            self:skillGroupInfo_selectLevel(skillGroupInfo, skillGroupInfo._selectLevel)
            self._skillGroupInfo[key] = skillGroupInfo
            if self._searchSkillGroupInfo[0] == nil then
              self._searchSkillGroupInfo[#self._searchSkillGroupInfo] = skillGroupInfo
            else
              self._searchSkillGroupInfo[#self._searchSkillGroupInfo + 1] = skillGroupInfo
            end
          end
        end
      end
    end
  end
end
function PaGlobal_SkillGroup_All:updateDefaultSkillAreaPosition(skillGroupType)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local skillAreaFrame, skillAreaScroll
  if skillGroupType == __eSkillGroupType_Combat or skillGroupType == __eSkillGroupType_Succession then
    skillAreaFrame = self._ui._frame_skillGroupArea_main
    skillAreaScroll = self._ui._scroll_skillGroupArea_main
  elseif skillGroupType == __eSkillGroupType_Awakening then
    skillAreaFrame = self._ui._frame_skillGroupArea_awaken
    skillAreaScroll = self._ui._scroll_skillGroupArea_awaken
  else
    return
  end
  local tableWrapper = ToClient_getSkillGroupCellTableWrapper(skillGroupType, self._classType)
  if tableWrapper == nil then
    return
  end
  local colMaxCount = tableWrapper:sizeX()
  local rowMaxCount = tableWrapper:sizeY()
  local subGroupSize = tableWrapper:getSubGroupSizeByClassType(self._classType)
  local gabX = 10
  local posX = 0
  local posY = 10
  local beforsubGroupNo = -1
  local skipSubGroupNo = -1
  local activeItemSkillCount = 0
  local itemSkillStartPosY = 0
  local showCurrentRowSkill = true
  local isRevisePos = false
  local rowSkillCount = {0}
  local rowLineCount = {0}
  local findFirstSkill = false
  local firstSubGroupSkill = false
  local firstSkillGroupPosY = 0
  for row = 0, rowMaxCount - 1 do
    showCurrentRowSkill = true
    rowSkillCount[row] = 0
    rowLineCount[row] = 0
    for col = 0, colMaxCount - 1 do
      posX = col * 125 - 65 * math.floor(col / 3) + gabX
      cellWrapper = tableWrapper:atWrapper(col, row)
      if cellWrapper ~= nil and cellWrapper:isDefined() == true then
        local cellType = cellWrapper:getType(0)
        local cellTypeSize = cellWrapper:getTypeSize()
        local subGroupNo = cellWrapper:getSubGroupNo()
        if subGroupNo == nil then
          break
        end
        if subGroupNo ~= beforsubGroupNo and subGroupSize > subGroupNo then
          findFirstSkill = false
          firstSubGroupSkill = true
          local beforeSubGroupKey = tostring(skillGroupType) .. "," .. tostring(beforsubGroupNo)
          local skillBeforeSubGroupInfo = self._skillSubGroupInfo[beforeSubGroupKey]
          if skillBeforeSubGroupInfo ~= nil and skillBeforeSubGroupInfo._control ~= nil and skillBeforeSubGroupInfo._control:IsCheck() == true then
            posY = skillBeforeSubGroupInfo._control:GetPosY() + skillBeforeSubGroupInfo._control:GetSizeY() + 10
          end
          beforsubGroupNo = subGroupNo
          local subGroupKey = tostring(skillGroupType) .. "," .. tostring(subGroupNo)
          local skillSubGroupInfo = self._skillSubGroupInfo[subGroupKey]
          if skillSubGroupInfo == nil then
            _PA_ASSERT_NAME(false, "\235\172\184\236\160\156 \235\176\156\236\131\157 subGroupKey : " .. subGroupKey, "\236\152\164\236\131\129\235\175\188")
          end
          if skillSubGroupInfo._isActiveItemGroup == true then
            if ToClient_IsExistActiveItemSkillEquip() == true then
              skillSubGroupInfo._control:SetShow(true)
              skillSubGroupInfo._control:SetPosY(posY)
              if skillSubGroupInfo._control:IsCheck() == true then
                skipSubGroupNo = subGroupNo
              else
                skipSubGroupNo = -1
              end
            else
              skillSubGroupInfo._control:SetShow(false)
              skipSubGroupNo = subGroupNo
            end
          else
            skillSubGroupInfo._control:SetShow(true)
            skillSubGroupInfo._control:SetPosY(posY)
            if skillSubGroupInfo._control:IsCheck() == true then
              skipSubGroupNo = subGroupNo
            else
              skipSubGroupNo = -1
            end
          end
          itemSkillStartPosY = posY
          firstSkillGroupPosY = posY + 10 + skillSubGroupInfo._control:GetSizeY()
        end
        if isRevisePos == false then
          posY = posY - 80
          isRevisePos = true
        end
        if col == 0 and row >= 4 and 0 >= rowSkillCount[row - 1] and 0 >= rowSkillCount[row - 2] and 0 >= rowLineCount[row - 1] and 0 >= rowLineCount[row - 2] then
          posY = posY - 40
        end
        if skipSubGroupNo == subGroupNo then
          showCurrentRowSkill = false
        end
        if __eSkillGroupCellType_SkillGroup == cellType then
          local key = cellWrapper:getSkillGroupNo()
          local skillGroupInfo = self._skillGroupInfo[key]
          rowSkillCount[row] = rowSkillCount[row] + 1
          if skillGroupInfo ~= nil and skillGroupInfo._key == key then
            if skillGroupInfo._key ~= 0 then
              if firstSubGroupSkill == true then
                findFirstSkill = true
                posY = firstSkillGroupPosY
              end
              firstSubGroupSkill = false
            end
            if showCurrentRowSkill == true then
              if skillGroupInfo._isActiveItemSkill == true then
                local isEquip = false
                for level = 1, skillGroupInfo._maxLevel do
                  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, level)
                  isEquip = ToClient_IsActiveItemSkillEquipBySkillKey(skillKey)
                  if isEquip == true then
                    break
                  end
                end
                if isEquip == true then
                  local xIndex = activeItemSkillCount % 3 * 3
                  local yIndex = math.floor(activeItemSkillCount / 3) + 1 + math.floor(activeItemSkillCount / 3)
                  local itemSkillPosX = xIndex * 125 - 65 * math.floor(xIndex / 3) + gabX
                  local itemSkillPosY = itemSkillStartPosY + yIndex * 40
                  skillGroupInfo._control:SetShow(true)
                  skillGroupInfo._control:SetPosX(itemSkillPosX)
                  skillGroupInfo._control:SetPosY(itemSkillPosY)
                  activeItemSkillCount = activeItemSkillCount + 1
                else
                  skillGroupInfo._control:SetShow(false)
                end
              else
                skillGroupInfo._control:SetShow(true)
                skillGroupInfo._control:SetPosX(posX)
                skillGroupInfo._control:SetPosY(posY)
              end
            else
              skillGroupInfo._control:SetShow(false)
            end
          else
            skillGroupInfo._control:SetShow(false)
          end
        else
          local key = tostring(skillGroupType) .. ":" .. tostring(col) .. "," .. tostring(row)
          local cellTypeSize = cellWrapper:getTypeSize()
          if cellType ~= __eSkillGroupCellType_Undefined and cellType ~= __eSkillGroupCellType_Blank and cellType ~= __eSkillGroupCellType_TypeCount then
            rowLineCount[row] = rowLineCount[row] + 1
          end
          for i = 1, #self._lineInfo[key] do
            local lineInfo = self._lineInfo[key][i]
            if showCurrentRowSkill == true then
              lineInfo._control:SetShow(true)
              lineInfo._control:SetPosX(posX)
              if lineInfo._isAddLine == false then
                lineInfo._control:SetPosY(posY)
              else
                lineInfo._control:SetPosY(posY - 5)
              end
            else
              lineInfo._control:SetShow(false)
            end
          end
        end
      end
    end
    if showCurrentRowSkill == true then
      posY = posY + 40
    end
  end
  if showCurrentRowSkill == true then
    posY = posY + 40
  else
    posY = posY + 80
  end
  if findFirstSkill == false then
    local lastSubGroupKey = tostring(skillGroupType) .. "," .. tostring(beforsubGroupNo)
    local subGroupInfo = self._skillSubGroupInfo[lastSubGroupKey]
    if subGroupInfo ~= nil and subGroupInfo._control ~= nil then
      subGroupInfo._control:SetShow(false)
    end
  end
  skillAreaFrame:GetFrameContent():SetSize(skillAreaFrame:GetFrameContent():GetSizeX(), posY)
  UIScroll.SetButtonSize(skillAreaScroll, skillAreaFrame:GetSizeY(), skillAreaFrame:GetFrameContent():GetSizeY())
  skillAreaFrame:UpdateContentPos()
end
function PaGlobal_SkillGroup_All:makeMainWeaponSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:makeDefaultSkillArea(__eSkillGroupType_Combat)
end
function PaGlobal_SkillGroup_All:makeAwakenSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:makeDefaultSkillArea(__eSkillGroupType_Awakening)
end
function PaGlobal_SkillGroup_All:makeFusionSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isOpenFusionSkill == false then
    return
  end
  self._maxFusionSkillCount = 0
  for index = 0, __eSkillFusionSlotMaxCount - 1 do
    local skillNo = ToClient_getFusionSkillNoByClassType(self._classType, index, 0)
    if skillNo ~= 0 then
      local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
      if skillTypeStaticWrapper ~= nil and skillTypeStaticWrapper:isValidLocalizing() == true then
        local fusionLearnSkillNo = 0
        if self:checkMyClassType() == true then
          fusionLearnSkillNo = ToClient_getFusionLearnSkillNo(index)
        end
        local uiInfo_result = self:getUIByPool(self._ePoolType._fusionSkillResult)
        local fusionSkillResultInfo = {
          _index = index,
          _control = uiInfo_result._control,
          _slot = uiInfo_result._slot,
          _btn_learn = UI.getChildControl(uiInfo_result._control, "Button_Learnable")
        }
        fusionSkillResultInfo._control:SetShow(false)
        fusionSkillResultInfo._slot.icon:SetAutoDisableTime(0.5)
        fusionSkillResultInfo._control:SetShow(true)
        self._fusionSkillResultInfo[index] = fusionSkillResultInfo
        self:updateFusionSkillResult(fusionLearnSkillNo, index)
        local uiInfo = self:getUIByPool(self._ePoolType._fusionSkill)
        local fusionSkillInfo = {
          _index = index,
          _control = uiInfo._control,
          _mainControl = UI.getChildControl(uiInfo._control, "Static_MainSlot"),
          _mainSlot = uiInfo._mainSlot,
          _mainSkillName = "",
          _subControl1 = UI.getChildControl(uiInfo._control, "Static_SubSlot1"),
          _subSlot1 = uiInfo._subSlot1,
          _subControl2 = UI.getChildControl(uiInfo._control, "Static_SubSlot2"),
          _subSlot2 = uiInfo._subSlot2,
          _resultControl1 = UI.getChildControl(uiInfo._control, "RadioButton_ResultSlot1"),
          _resultSlot1 = uiInfo._resultSlot1,
          _result1SkillName = "",
          _resultControl2 = UI.getChildControl(uiInfo._control, "RadioButton_ResultSlot2"),
          _resultSlot2 = uiInfo._resultSlot2,
          _result2SkillName = ""
        }
        local skillMaxCount = ToClient_getFusionSkillListCountByClassType(self._classType, index)
        local txt_skillLevel = UI.getChildControl(fusionSkillInfo._mainControl, "StaticText_Level")
        local txt_skillName = UI.getChildControl(fusionSkillInfo._mainControl, "StaticText_MainSkillName")
        local canLearnSKillLevel = 0
        txt_skillName:SetTextMode(__eTextMode_Limit_AutoWrap)
        local mainSkillNo = ToClient_getFusionMainSkillNoByClassType(self._classType, index, 0)
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(mainSkillNo)
        if skillTypeStaticWrapper ~= nil and skillTypeStaticWrapper:isValidLocalizing() == true then
          local skillTypeStatic = skillTypeStaticWrapper:get()
          fusionSkillInfo._mainSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. mainSkillNo .. ")")
          fusionSkillInfo._mainControl:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. mainSkillNo .. ")")
          if self._isPadSnapping == false then
            fusionSkillInfo._mainSlot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. mainSkillNo .. ", false, \"SkillBox\")")
            fusionSkillInfo._mainSlot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. mainSkillNo .. ", \"SkillBox\")")
          end
          fusionSkillInfo._mainSlot:setSkillTypeStatic(skillTypeStaticWrapper)
          fusionSkillInfo._mainSkillName = skillTypeStaticWrapper:getName()
          txt_skillName:SetText(fusionSkillInfo._mainSkillName)
        end
        for skillIndex = 0, skillMaxCount - 1 do
          local subControl, subSlot, resultControl, resultSlot
          if skillIndex == 0 then
            subControl = fusionSkillInfo._subControl1
            subSlot = fusionSkillInfo._subSlot1
            resultControl = fusionSkillInfo._resultControl1
            resultSlot = fusionSkillInfo._resultSlot1
          else
            subControl = fusionSkillInfo._subControl2
            subSlot = fusionSkillInfo._subSlot2
            resultControl = fusionSkillInfo._resultControl2
            resultSlot = fusionSkillInfo._resultSlot2
          end
          local subSkillNo = ToClient_getFusionSubSkillNoByClassType(self._classType, index, skillIndex)
          local txt_skillName = UI.getChildControl(subControl, "StaticText_SubSkillName")
          skillTypeStaticWrapper = getSkillTypeStaticStatus(subSkillNo)
          if skillTypeStaticWrapper ~= nil and skillTypeStaticWrapper:isValidLocalizing() == true then
            txt_skillName:SetText(skillTypeStaticWrapper:getName())
            skillTypeStatic = skillTypeStaticWrapper:get()
            subSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. subSkillNo .. ")")
            subControl:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. subSkillNo .. ")")
            if self._isPadSnapping == false then
              subSlot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. subSkillNo .. ", false, \"SkillBox\")")
              subSlot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. subSkillNo .. ", \"SkillBox\")")
            end
            subSlot:setSkillTypeStatic(skillTypeStaticWrapper)
          end
          local fusionSkillNo = ToClient_getFusionSkillNoByClassType(self._classType, index, skillIndex)
          txt_skillName = UI.getChildControl(resultControl, "StaticText_ResultSkillName")
          skillTypeStaticWrapper = getSkillTypeStaticStatus(fusionSkillNo)
          if skillTypeStaticWrapper ~= nil and skillTypeStaticWrapper:isValidLocalizing() == true then
            if skillIndex == 0 then
              fusionSkillInfo._result1SkillName = skillTypeStaticWrapper:getName()
            else
              fusionSkillInfo._result2SkillName = skillTypeStaticWrapper:getName()
            end
            txt_skillName:SetText(skillTypeStaticWrapper:getName())
            skillTypeStatic = skillTypeStaticWrapper:get()
            resultSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. fusionSkillNo .. ")")
            resultControl:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. fusionSkillNo .. ")")
            if self._isPadSnapping == false then
              resultSlot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. fusionSkillNo .. ", false, \"SkillBox\")")
              resultSlot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. fusionSkillNo .. ", \"SkillBox\")")
            end
            resultSlot:setSkillTypeStatic(skillTypeStaticWrapper)
            resultControl:SetResetPressControl(false)
            local stc_lock = UI.getChildControl(resultControl, "Static_Lock")
            local stc_ccList = UI.getChildControl(resultControl, "Static_CC_List")
            local skillSSW = getSkillStaticStatus(fusionSkillNo, 1)
            local maxSkillCCTypeCount = ToClient_getMaxSkillCCTypeCount()
            local count = 0
            for i = 1, maxSkillCCTypeCount - 1 do
              if skillSSW:isSetSkillCCType(i - 1) == true and Defines.SkillCCTypeConfig._uv[i] ~= nil then
                local uiIndex = count + 1
                local control = UI.getChildControl(stc_ccList, "Static_CC_" .. uiIndex)
                control:ChangeTextureInfoNameAsync(Defines.SkillCCTypeConfig._iconPath)
                local x1, y1, x2, y2 = setTextureUV_Func(control, Defines.SkillCCTypeConfig._uv[i].x1, Defines.SkillCCTypeConfig._uv[i].y1, Defines.SkillCCTypeConfig._uv[i].x2, Defines.SkillCCTypeConfig._uv[i].y2)
                control:getBaseTexture():setUV(x1, y1, x2, y2)
                control:setRenderTexture(control:getBaseTexture())
                if self._isPadSnapping == false then
                  control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:showSkillGroupCCTooltip(" .. index .. "," .. uiIndex .. "," .. i .. "," .. "true, " .. skillIndex .. ")")
                  control:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:showSkillGroupCCTooltip(" .. index .. "," .. uiIndex .. "," .. i .. "," .. "false, " .. skillIndex .. ")")
                end
                control:SetShow(true)
                control:SetIgnore(false)
                count = count + 1
              end
            end
            for i = count + 1, 8 do
              local control = UI.getChildControl(stc_ccList, "Static_CC_" .. i)
              control:SetShow(false)
              control:SetIgnore(true)
            end
            canLearnSKillLevel = skillSSW:get()._needCharacterLevelForLearning
            resultControl:SetChildIndex(stc_lock, resultControl:GetChildSize())
          end
        end
        if canLearnSKillLevel ~= 0 then
          txt_skillLevel:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_DEEPSKILL_LEVEL", "level", canLearnSKillLevel))
        end
        self._fusionSkillInfo[index] = fusionSkillInfo
        self._maxFusionSkillCount = self._maxFusionSkillCount + 1
        if self._searchFusionSkillInfo[0] == nil then
          self._searchFusionSkillInfo[#self._searchFusionSkillInfo] = fusionSkillInfo
        else
          self._searchFusionSkillInfo[#self._searchFusionSkillInfo + 1] = fusionSkillInfo
        end
      end
    end
  end
  local framePosY = 0
  for index = 0, self._maxFusionSkillCount - 1 do
    if self._fusionSkillResultInfo[index] ~= nil and self._fusionSkillResultInfo[index]._control ~= nil then
      self._fusionSkillResultInfo[index]._control:SetSpanSize((self._fusionSkillResultInfo[index]._control:GetSizeX() + 20) * (index - 1), 0)
      self._fusionSkillResultInfo[index]._control:ComputePos()
    end
    if self._fusionSkillInfo[index] ~= nil and self._fusionSkillInfo[index]._control ~= nil then
      local spanX = self._fusionSkillInfo[index]._control:GetSpanSize().x
      local spanY = 90 + (self._fusionSkillInfo[index]._control:GetSizeY() + 70) * index
      self._fusionSkillInfo[index]._control:SetSpanSize(spanX, spanY)
      self._fusionSkillInfo[index]._control:ComputePos()
      framePosY = self._fusionSkillInfo[index]._control:GetPosY() + self._fusionSkillInfo[index]._control:GetSizeY() + 40
    end
  end
  self._ui._frame_fusionSkill:GetFrameContent():SetSize(self._ui._frame_fusionSkill:GetFrameContent():GetSizeX(), framePosY)
  UIScroll.SetButtonSize(self._ui._scroll_skillGroupArea_fusionSkill, self._ui._frame_fusionSkill:GetSizeY(), self._ui._frame_fusionSkill:GetFrameContent():GetSizeY())
  self:updateFusionSkillArea()
end
function PaGlobal_SkillGroup_All:updateFusionSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isOpenFusionSkill == false then
    return
  end
  if self._selectedTab ~= self._eTabType._fusion then
    return
  end
  for slotNo = 0, self._maxFusionSkillCount - 1 do
    local fusionLearnSkillNo = 0
    if self:checkMyClassType() == true then
      fusionLearnSkillNo = ToClient_getFusionLearnSkillNo(slotNo)
    end
    self:updateFusionSkillResult(fusionLearnSkillNo, slotNo)
    local fusionSkillInfo = self._fusionSkillInfo[slotNo]
    local learnFusionSkill = false
    local learnIndex = -1
    local skillMaxCount = ToClient_getFusionSkillListCountByClassType(self._classType, slotNo)
    local mainSkillNo = ToClient_getFusionMainSkillNoByClassType(self._classType, slotNo, 0)
    local isLearnedMainSkill = self:updateFusionSkillMonotone(fusionSkillInfo._mainControl, fusionSkillInfo._mainSlot, mainSkillNo)
    if self._isPadSnapping == true then
      fusionSkillInfo._mainControl:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(3, nil, false, false)")
    end
    for skillIndex = 0, skillMaxCount - 1 do
      local subControl, subSlot, resultControl, resultSlot
      if skillIndex == 0 then
        subControl = fusionSkillInfo._subControl1
        subSlot = fusionSkillInfo._subSlot1
        resultControl = fusionSkillInfo._resultControl1
        resultSlot = fusionSkillInfo._resultSlot1
      else
        subControl = fusionSkillInfo._subControl2
        subSlot = fusionSkillInfo._subSlot2
        resultControl = fusionSkillInfo._resultControl2
        resultSlot = fusionSkillInfo._resultSlot2
      end
      local subSkillNo = ToClient_getFusionSubSkillNoByClassType(self._classType, slotNo, skillIndex)
      local fusionSkillNo = ToClient_getFusionSkillNoByClassType(self._classType, slotNo, skillIndex)
      local isLearnedSubSkill = self:updateFusionSkillMonotone(subControl, subSlot, subSkillNo)
      local isCanLearnedFusionSkill = isLearnedMainSkill == true and isLearnedSubSkill == true
      local isLearnedFusionSkill = self:updateFusionSkillMonotone(resultControl, resultSlot, fusionSkillNo, isCanLearnedFusionSkill)
      local stc_lock = UI.getChildControl(resultControl, "Static_Lock")
      local stc_learnable = UI.getChildControl(resultControl, "Static_Icon_Skill_Effect")
      if isLearnedFusionSkill == true or self:checkMyClassType() == false then
        if isLearnedFusionSkill == true then
          resultSlot.icon:addInputEvent("Mouse_RUp", "PaGlobal_SkillGroup_All:clearButtonClick(" .. fusionSkillNo .. ",0, false, true)")
          resultSlot.icon:addInputEvent("Mouse_RUp", "PaGlobal_SkillGroup_All:clearButtonClick(" .. fusionSkillNo .. ",0, false, true)")
          resultSlot.icon:addInputEvent("Mouse_PressMove", "PaGlobalFunc_SkillGroup_All_StartDrag(" .. fusionSkillNo .. ")")
          resultControl:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_SkillGroup_All:clearButtonClick(" .. fusionSkillNo .. ",0, false, true)")
          resultSlot.icon:SetEnableDragAndDrop(true)
          learnFusionSkill = true
          learnIndex = skillIndex
        end
        stc_lock:SetShow(false)
        stc_learnable:SetShow(false)
      else
        resultSlot.icon:removeInputEvent("Mouse_RUp")
        resultSlot.icon:removeInputEvent("Mouse_PressMove")
        if isCanLearnedFusionSkill == true then
          stc_lock:SetShow(false)
          stc_learnable:SetShow(true)
        else
          stc_lock:SetShow(true)
          stc_learnable:SetShow(false)
        end
      end
      if self._isPadSnapping == true then
        local selfPlayer = getSelfPlayer():get()
        if selfPlayer ~= nil then
          local skillStatic = getSkillStaticStatus(fusionSkillNo, 1)
          local lv = skillStatic:get()._needCharacterLevelForLearning
          local playerLevel = selfPlayer:getLevel()
          local showLearnSkill = isCanLearnedFusionSkill and learnIndex == -1 and lv <= playerLevel
          subControl:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(3, nil, false, false)")
          resultControl:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(3, nil," .. tostring(isLearnedFusionSkill) .. "," .. tostring(showLearnSkill) .. ")")
        end
      end
      local skillLevelInfo = getSkillLevelInfo(fusionSkillNo)
      if skillLevelInfo ~= nil then
        local stc_learnable = UI.getChildControl(resultControl, "Static_Icon_Skill_Effect")
        if skillLevelInfo._learnable == true and skillLevelInfo._usable == false then
          if isLearnedMainSkill == false or isLearnedSubSkill == false then
            resultSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. fusionSkillNo .. ")")
            resultControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:selectFusionSkill(" .. fusionSkillNo .. ")")
            stc_learnable:SetShow(false)
          else
            resultSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:learnFusionSkill(" .. mainSkillNo .. "," .. subSkillNo .. "," .. fusionSkillNo .. "," .. slotNo .. "," .. skillIndex .. ")")
            resultControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:learnFusionSkill(" .. mainSkillNo .. "," .. subSkillNo .. "," .. fusionSkillNo .. "," .. slotNo .. "," .. skillIndex .. ")")
            stc_learnable:SetShow(true)
          end
        else
          stc_learnable:SetShow(false)
        end
      end
      local skillSSW = getSkillStaticStatus(fusionSkillNo, 1)
      local isShowFilterEffect = PaGlobalFunc_SkillFilter_All_isFilterSkill(skillSSW, fusionSkillNo)
      resultControl:EraseAllEffect()
      if isShowFilterEffect == true then
        resultControl:AddEffect("fUI_NewSkill_Guide_03A", true, 0, 0)
      end
    end
    if self:checkMyClassType() == true then
      for skillIndex = 0, skillMaxCount - 1 do
        local resultControl, resultSlot
        if skillIndex == 0 then
          resultControl = fusionSkillInfo._resultControl1
          resultSlot = fusionSkillInfo._resultSlot1
        else
          resultControl = fusionSkillInfo._resultControl2
          resultSlot = fusionSkillInfo._resultSlot2
        end
        if learnFusionSkill == true then
          local stc_lock = UI.getChildControl(resultControl, "Static_Lock")
          local stc_learnable = UI.getChildControl(resultControl, "Static_Icon_Skill_Effect")
          if learnIndex ~= skillIndex then
            stc_lock:SetShow(true)
          end
          local fusionSkillNo = ToClient_getFusionSkillNoByClassType(self._classType, slotNo, skillIndex)
          resultSlot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. fusionSkillNo .. ")")
          resultControl:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:selectFusionSkill(" .. fusionSkillNo .. ")")
          stc_learnable:SetShow(false)
        end
      end
    end
    fusionSkillInfo._control:SetShow(true)
  end
end
function PaGlobal_SkillGroup_All:updateFusionSkillMonotone(slot, skillSlot, skillNo, isFusionAndLearnNeedAll)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return false
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if skillLevelInfo == nil then
    return false
  end
  if canLearnFusionSkill == nil then
    canLearnFusionSkill = false
  end
  local skillStatic = getSkillStaticStatus(skillNo, 1)
  local lv = skillStatic:get()._needCharacterLevelForLearning
  local playerLevel = selfPlayer:getLevel()
  if self:checkMyClassType() == false then
    slot:SetMonoTone(false)
    skillSlot.icon:SetMonoTone(false)
    return false
  elseif ToClient_isLearnedSkill(skillNo) == false then
    if isFusionAndLearnNeedAll == true and lv <= playerLevel then
      slot:SetMonoTone(false)
      skillSlot.icon:SetMonoTone(true, true)
    else
      slot:SetMonoTone(true, true)
      skillSlot.icon:SetMonoTone(true, true)
    end
    return false
  else
    slot:SetMonoTone(false)
    skillSlot.icon:SetMonoTone(false)
    return true
  end
end
function PaGlobal_SkillGroup_All:updateFusionSkillResult(skillNo, index)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local fusionSkillResultInfo = self._fusionSkillResultInfo[index]
  if fusionSkillResultInfo == nil then
    return
  end
  if skillNo == 0 then
    fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(0," .. index .. ")")
    fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_Out", "")
    fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_PressMove", "")
    fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_RUp", "")
    if self._isPadSnapping == true then
      fusionSkillResultInfo._slot.icon:registerPadEvent(__eConsoleUIPadEvent_Y, "")
    end
    fusionSkillResultInfo._btn_learn:SetShow(true)
    fusionSkillResultInfo._slot:clearSkill()
    return
  end
  local learnSkillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if learnSkillTypeStaticWrapper == nil and learnSkillTypeStaticWrapper:isValidLocalizing() == false then
    return
  end
  fusionSkillResultInfo._slot:setSkillTypeStatic(learnSkillTypeStaticWrapper)
  fusionSkillResultInfo._btn_learn:SetShow(false)
  fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:selectFusionSkill(" .. skillNo .. ")")
  fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_RUp", "PaGlobal_SkillGroup_All:clearButtonClick(" .. skillNo .. ",0, false, true)")
  fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_PressMove", "PaGlobalFunc_SkillGroup_All_StartDrag(" .. skillNo .. ")")
  if self._isPadSnapping == true then
    fusionSkillResultInfo._slot.icon:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_SkillGroup_All:clearButtonClick(" .. skillNo .. ",0, false, true)")
  else
    fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", false, \"SkillBox\")")
    fusionSkillResultInfo._slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
  end
  fusionSkillResultInfo._slot.icon:SetEnableDragAndDrop(true)
  fusionSkillResultInfo._slot.icon:SetShow(true)
end
function PaGlobal_SkillGroup_All:playLearnFusionSkillEffect(skillNo, index)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if skillNo == nil or index == nil or skillNo == 0 then
    return
  end
  local fusionSkillResultInfo = self._fusionSkillResultInfo[index]
  if fusionSkillResultInfo == nil then
    return
  end
  local fusionSkillInfo = self._fusionSkillInfo[index]
  if fusionSkillInfo == nil then
    return
  end
  fusionSkillResultInfo._slot.icon:AddEffect("fUI_NewSkill_Intensive_Succes_Slot_02A", false, 0, 0)
  if self._selectedFusionSkillIndex == 0 then
    fusionSkillInfo._resultSlot1.icon:AddEffect("fUI_NewSkill_Intensive_Succes_Slot_01A", false, 0, 0)
    if self._isPadSnapping == true then
      ToClient_padSnapChangeToTarget(fusionSkillInfo._resultControl1)
    end
  else
    fusionSkillInfo._resultSlot2.icon:AddEffect("fUI_NewSkill_Intensive_Succes_Slot_01A", false, 0, 0)
    if self._isPadSnapping == true then
      ToClient_padSnapChangeToTarget(fusionSkillInfo._resultControl2)
    end
  end
end
function PaGlobal_SkillGroup_All:makeUpgradeSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isOpenUpgradeSkill == false then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  if self._ui._list2_upgradeList:getElementManager() == nil then
    return
  end
  self._ui._list2_upgradeList:getElementManager():clearKey()
  local updateSkillViewCount = 3
  if _ContentsGroup_TotalSkillReininforce == true then
    updateSkillViewCount = 6
  end
  local forUpdate = ToClient_GetReAwakeningListCount()
  self._upgradeIndex = 0
  for index = 0, updateSkillViewCount - 1 do
    self._ui._list2_upgradeList:getElementManager():pushKey(toInt64(0, index + 1))
  end
  local isHideSkillMaster = false
  if _ContentsGroup_DarkMoonAdditionalBuff == true and selfPlayer:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BookOfCombat) == true then
    isHideSkillMaster = true
  end
  if _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true then
    isHideSkillMaster = true
  end
  if isHideSkillMaster == true then
    self._ui._btn_naviSkillMaster:SetShow(false)
    self._ui._keyguide_naviSkillMaster:SetShow(false)
    if self._isPadSnapping == true then
      Panel_Window_SkillGroup_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
  end
end
function PaGlobal_SkillGroup_All:createUpgradeSkillListContent(content, key)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  local index = Int64toInt32(key) - 1
  local area = UI.getChildControl(content, "Static_UpgradeSkill_Area")
  local skillSlotBg = UI.getChildControl(area, "Static_SkillSlotBG")
  local skillIcon = UI.getChildControl(skillSlotBg, "Static_SkillIcon")
  local skillName = UI.getChildControl(area, "StaticText_NorSkill_Title")
  local skillDesc = UI.getChildControl(skillName, "StaticText_NorSkill_Info")
  local skillEffectBg = UI.getChildControl(area, "StaticText_NorSkillEff_Title")
  local skillEffect_0 = UI.getChildControl(skillEffectBg, "StaticText_NorSkillEff01")
  local skillEffect_1 = UI.getChildControl(skillEffectBg, "StaticText_NorSkillEff02")
  local deactivatedSkill = UI.getChildControl(area, "StaticText_NorSkillActive")
  local noneSkill = UI.getChildControl(area, "StaticText_NorSkillNoneActive")
  local btn_reinforceSkill = UI.getChildControl(area, "Button_NorBtn_Active")
  local stc_change = UI.getChildControl(btn_reinforceSkill, "Static_Change")
  local stc_unLock = UI.getChildControl(btn_reinforceSkill, "Static_UnLockIcon")
  local btn_skillChange = UI.getChildControl(skillSlotBg, "Button_SkillChangeButton")
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if playerSkillType == nil then
    return
  end
  skillName:SetShow(false)
  skillDesc:SetShow(false)
  skillIcon:SetShow(false)
  skillEffectBg:SetShow(false)
  skillEffect_0:SetShow(false)
  skillEffect_1:SetShow(false)
  deactivatedSkill:SetShow(false)
  noneSkill:SetShow(false)
  btn_reinforceSkill:SetShow(false)
  btn_skillChange:SetShow(false)
  if _ContentsGroup_DarkMoonAdditionalBuff == true and selfPlayer:isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BookOfCombat) == true then
    btn_reinforceSkill:SetShow(true)
  end
  local skillSSW = ToClient_GetReAwakeningListAt(index)
  if skillSSW ~= nil then
    local skillNo = skillSSW:getSkillNo()
    skillName:SetTextMode(__eTextMode_AutoWrap)
    skillName:SetText(skillSSW:getName())
    skillName:SetShow(true)
    local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
    if skillTypeSSW ~= nil then
      skillDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
      skillDesc:setLineCountByLimitAutoWrap(2)
      skillDesc:SetText(skillTypeSSW:getDescription())
      skillDesc:SetShow(true)
      skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
      if self._isPadSnapping == true then
        skillIcon:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(4)")
        skillIcon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillUpgrade(" .. skillNo .. ")")
      else
        skillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ",false,\"SkillAwakenSet\")")
        skillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
      end
      skillIcon:SetShow(true)
    end
    local effectCount = ToClient_GetAwakeningAbilityCount(skillNo)
    if effectCount == 1 then
      skillEffectBg:SetShow(true)
      local effectIndex_0 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
      skillEffect_0:SetTextMode(__eTextMode_LimitText)
      skillEffect_0:SetText(skillSSW:getSkillAwakenDescription(effectIndex_0))
      skillEffect_0:addInputEvent("Mouse_On", "PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(true," .. index .. ",0)")
      skillEffect_0:addInputEvent("Mouse_Out", "PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(false)")
      skillEffect_0:SetShow(true)
      skillEffect_1:SetTextMode(__eTextMode_LimitText)
      skillEffect_1:SetText("")
      skillEffect_1:addInputEvent("Mouse_On", "")
      skillEffect_1:addInputEvent("Mouse_Out", "")
      skillEffect_1:SetShow(true)
    elseif effectCount == 2 then
      skillEffectBg:SetShow(true)
      local effectIndex_0 = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
      skillEffect_0:SetTextMode(__eTextMode_LimitText)
      skillEffect_0:SetText(skillSSW:getSkillAwakenDescription(effectIndex_0))
      skillEffect_0:addInputEvent("Mouse_On", "PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(true," .. index .. ",0)")
      skillEffect_0:addInputEvent("Mouse_Out", "PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(false)")
      skillEffect_0:SetShow(true)
      local effectIndex_1 = ToClient_GetAwakeningAbilityIndex(skillNo, 1)
      skillEffect_1:SetTextMode(__eTextMode_LimitText)
      skillEffect_1:SetText(skillSSW:getSkillAwakenDescription(effectIndex_1))
      skillEffect_1:addInputEvent("Mouse_On", "PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(true," .. index .. ",1)")
      skillEffect_1:addInputEvent("Mouse_Out", "PaGlobalFunc_SkillGroup_All_ShowUpgradeSkillEffectDescToolTip(false)")
      skillEffect_1:SetShow(true)
    end
    if btn_reinforceSkill:GetShow() == true then
      stc_change:SetShow(true)
      stc_unLock:SetShow(false)
      btn_reinforceSkill:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_OpenReinforce(" .. playerSkillType .. ", " .. skillNo .. "," .. index .. "," .. self._upgradeIndex .. ")")
      btn_skillChange:SetShow(true)
      btn_skillChange:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_ChangeReinforce(" .. playerSkillType .. ", " .. skillNo .. "," .. index .. "," .. self._upgradeIndex .. ")")
      self._upgradeIndex = self._upgradeIndex + 1
      if self._isPadSnapping == true then
        btn_reinforceSkill:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(1)")
        btn_skillChange:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:alignKeyguide(1)")
      end
    end
  else
    local playerLevel = selfPlayer:getLevel()
    local openCount = 0
    if playerLevel < 50 then
      openCount = 0
    elseif playerLevel < 52 then
      openCount = 1
    elseif playerLevel < 54 then
      openCount = 2
    elseif playerLevel < 56 then
      openCount = 3
    elseif playerLevel < 58 then
      openCount = 4
    elseif playerLevel < 60 then
      openCount = 5
    else
      openCount = 6
    end
    local contentOpenLevel = 50 + index * 2
    if index < openCount then
      deactivatedSkill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. tostring(contentOpenLevel))
      deactivatedSkill:SetSize(deactivatedSkill:GetTextSizeX() + 5, deactivatedSkill:GetSizeY())
      deactivatedSkill:SetShow(true)
    else
      noneSkill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. " " .. tostring(contentOpenLevel))
      noneSkill:SetSize(noneSkill:GetTextSizeX() + 5, noneSkill:GetSizeY())
      noneSkill:SetShow(true)
    end
    if btn_reinforceSkill:GetShow() == true then
      stc_change:SetShow(false)
      stc_unLock:SetShow(true)
      btn_reinforceSkill:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_OpenReinforceNew(" .. playerSkillType .. "," .. self._upgradeIndex .. ")")
    end
  end
end
function PaGlobal_SkillGroup_All:updateMainWeaponSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:updateDefaultSkillArea(__eSkillGroupType_Combat)
end
function PaGlobal_SkillGroup_All:updateAwakenSkillArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:updateDefaultSkillArea(__eSkillGroupType_Awakening)
end
function PaGlobal_SkillGroup_All:updateSkillPresetArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if _ContentsGroup_SkillPreset == false then
    return
  end
  self._ui._stc_presetBG:SetShow(self:checkMyClassType() == true)
  self._ui._btn_presetSave:SetShow(true)
  local currSlotCount = ToClient_getSkillPresetSlotCount()
  for i = 1, self._presetSlotMaxCount do
    if self._btn_skillPresetList[i] == nil or self._btn_skillPresetLockList[i] == nil then
      break
    end
    local index = i - 1
    if currSlotCount > index then
      self._btn_skillPresetList[i]:SetShow(true)
      self._btn_skillPresetLockList[i]:SetShow(false)
      if Toclient_getSkillPresetSlotEmpty(index) == true then
        self._btn_skillPresetList[i]:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot1_Dimmed_Normal", 0)
        self._btn_skillPresetList[i]:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot1_Dimmed_Over", 1)
        self._btn_skillPresetList[i]:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot1_Dimmed_Click", 2)
      else
        self._btn_skillPresetList[i]:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot" .. tostring(i) .. "_Normal", 0)
        self._btn_skillPresetList[i]:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot" .. tostring(i) .. "_Over", 1)
        self._btn_skillPresetList[i]:ChangeTextureInfoTextureIDAsync("Combine_Btn_SkillSaveSlot" .. tostring(i) .. "_Click", 2)
      end
      self._btn_skillPresetList[i]:setRenderTexture(self._btn_skillPresetList[i]:getBaseTexture())
    else
      self._btn_skillPresetList[i]:SetShow(false)
      self._btn_skillPresetLockList[i]:SetShow(true)
    end
  end
  local selectedSlotNo = ToClient_getSkillPresetApplySlotNo()
  if selectedSlotNo == -1 then
    self._ui._stc_selectPreset:SetShow(false)
  else
    local interval = (self._ui._stc_selectPreset:GetSizeY() - self._btn_skillPresetList[selectedSlotNo + 1]:GetSizeY()) / 2
    self._ui._stc_selectPreset:SetPosY(self._btn_skillPresetList[selectedSlotNo + 1]:GetPosY() - interval)
    self._ui._stc_selectPreset:SetShow(true)
  end
end
function PaGlobal_SkillGroup_All:selectTab(tabType)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self._ui._rdo_tab_mainWeapon:SetCheck(false)
  self._ui._rdo_tab_awakenWeapon:SetCheck(false)
  self._ui._rdo_tab_fusionSkill:SetCheck(false)
  self._ui._rdo_tab_upgradeSkill:SetCheck(false)
  self._ui._stc_mainWeaponSkillArea:SetShow(false)
  self._ui._stc_awakenSkillArea:SetShow(false)
  self._ui._stc_fusionSkillArea:SetShow(false)
  self._ui._stc_upgradeSkillArea:SetShow(false)
  self._selectedTab = tabType
  if self._selectedTab == self._eTabType._mainWeapon then
    self._ui._stc_mainWeaponSkillArea:SetShow(true)
    self._ui._rdo_tab_mainWeapon:SetCheck(true)
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_tab_mainWeapon:GetPosX() + self._ui._rdo_tab_mainWeapon:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2)
    self:updateDefaultSkillAreaPosition(__eSkillGroupType_Combat)
  elseif self._selectedTab == self._eTabType._awaken then
    self._ui._stc_awakenSkillArea:SetShow(true)
    self._ui._rdo_tab_awakenWeapon:SetCheck(true)
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_tab_awakenWeapon:GetPosX() + self._ui._rdo_tab_awakenWeapon:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2)
    self:updateDefaultSkillAreaPosition(__eSkillGroupType_Awakening)
  elseif self._selectedTab == self._eTabType._fusion then
    self._ui._stc_fusionSkillArea:SetShow(true)
    self._ui._rdo_tab_fusionSkill:SetCheck(true)
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_tab_fusionSkill:GetPosX() + self._ui._rdo_tab_fusionSkill:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2)
    self:updateFusionSkillArea()
  elseif self._selectedTab == self._eTabType._upgrade then
    self._ui._stc_upgradeSkillArea:SetShow(true)
    self._ui._rdo_tab_upgradeSkill:SetCheck(true)
    self._ui._stc_selectLine:SetPosX(self._ui._rdo_tab_upgradeSkill:GetPosX() + self._ui._rdo_tab_upgradeSkill:GetSizeX() / 2 - self._ui._stc_selectLine:GetSizeX() / 2)
  end
end
function PaGlobal_SkillGroup_All:skillGroupInfo_registEvent(skillGroupInfo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  skillGroupInfo._control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(true," .. skillGroupInfo._key .. ")")
  skillGroupInfo._check_command:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(true," .. skillGroupInfo._key .. ")")
  skillGroupInfo._btn_prev:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(true," .. skillGroupInfo._key .. ")")
  skillGroupInfo._btn_next:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(true," .. skillGroupInfo._key .. ")")
  skillGroupInfo._control:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(false," .. skillGroupInfo._key .. ")")
  skillGroupInfo._check_command:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(false," .. skillGroupInfo._key .. ")")
  skillGroupInfo._btn_prev:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(false," .. skillGroupInfo._key .. ")")
  skillGroupInfo._btn_next:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(false," .. skillGroupInfo._key .. ")")
  skillGroupInfo._check_command:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillCommandLock(" .. skillGroupInfo._key .. ")")
  skillGroupInfo._control:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
  skillGroupInfo._btn_prev:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_LevelButton(false, " .. skillGroupInfo._key .. ")")
  skillGroupInfo._btn_next:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_LevelButton(true, " .. skillGroupInfo._key .. ")")
  if self._isPadSnapping == true then
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_DpadLeft, "PaGlobal_SkillGroup_All:handleEventLUp_LevelButton(false, " .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_DpadRight, "PaGlobal_SkillGroup_All:handleEventLUp_LevelButton(true," .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LSClick, "PaGlobal_SkillGroup_All:handleEventLUp_SkillCommandLock(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SkillGroup_PlayBlackSpiritSkill(" .. skillGroupInfo._key .. ")")
  end
end
function PaGlobal_SkillGroup_All:skillGroupInfo_updateSkillCCType(skillGroupInfo, skillSSW)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local CCList = UI.getChildControl(skillGroupInfo._control, "Static_CC_List")
  local count = 0
  local maxSkillCCTypeCount = ToClient_getMaxSkillCCTypeCount()
  for i = 1, maxSkillCCTypeCount - 1 do
    if skillSSW:isSetSkillCCType(i - 1) == true and Defines.SkillCCTypeConfig._uv[i] ~= nil then
      count = count + 1
      local CC_control = UI.getChildControl(CCList, "Static_CC_" .. count)
      if CC_control ~= nil then
        CC_control:ChangeTextureInfoNameAsync(Defines.SkillCCTypeConfig._iconPath)
        local x1, y1, x2, y2 = setTextureUV_Func(CC_control, Defines.SkillCCTypeConfig._uv[i].x1, Defines.SkillCCTypeConfig._uv[i].y1, Defines.SkillCCTypeConfig._uv[i].x2, Defines.SkillCCTypeConfig._uv[i].y2)
        CC_control:getBaseTexture():setUV(x1, y1, x2, y2)
        CC_control:setRenderTexture(CC_control:getBaseTexture())
        if self._isPadSnapping == false then
          CC_control:addInputEvent("Mouse_On", "PaGlobal_SkillGroup_All:showSkillGroupCCTooltip(" .. skillGroupInfo._key .. "," .. count .. "," .. i .. "," .. "true" .. ")")
          CC_control:addInputEvent("Mouse_Out", "PaGlobal_SkillGroup_All:showSkillGroupCCTooltip(" .. skillGroupInfo._key .. "," .. count .. "," .. i .. "," .. "false" .. ")")
        end
        CC_control:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
        skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SkillGroup_PlayBlackSpiritSkill(" .. skillGroupInfo._key .. ")")
        CC_control:SetShow(true)
        CC_control:SetIgnore(false)
      end
    end
  end
  for i = count + 1, 8 do
    local CC_control = UI.getChildControl(CCList, "Static_CC_" .. i)
    CC_control:SetShow(false)
    CC_control:SetIgnore(true)
  end
  if count > 0 then
    CCList:SetShow(true)
    CCList:SetIgnore(false)
  else
    CCList:SetShow(false)
    CCList:SetIgnore(true)
  end
end
function PaGlobal_SkillGroup_All:skillGroupInfo_selectLevel(skillGroupInfo, selectLevel, isLearnSkill)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isLearnSkill == nil then
    isLearnSkill = false
  end
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, selectLevel)
  if skillKey:isDefined() == false then
    return
  end
  local skillNo = skillKey:getSkillNo()
  local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
  if skillTypeSSW == nil then
    return
  end
  skillGroupInfo._slot:setSkillTypeStatic(skillTypeSSW)
  if skillGroupInfo._maxLevel == 1 then
    skillGroupInfo._skillName:SetSize(170, skillGroupInfo._skillName:GetSizeY())
  end
  skillGroupInfo._name = skillTypeSSW:getName()
  skillGroupInfo._skillName:SetText(skillTypeSSW:getName())
  local skillTypeStatic = skillTypeSSW:get()
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  local skillSSW = getSkillStaticStatus(skillNo, 1)
  if skillTypeSSW:isSkillCommandCheck() == true then
    skillGroupInfo._isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if skillGroupInfo._isBlockSkill == true then
      skillGroupInfo._showCheckCommand = true
      skillGroupInfo._check_command:SetShow(true)
    elseif skillLevelInfo._learnable == false and skillLevelInfo._usable == true then
      skillGroupInfo._showCheckCommand = true
    else
      skillGroupInfo._showCheckCommand = false
    end
    skillGroupInfo._check_command:SetCheck(skillGroupInfo._isBlockSkill)
  else
    skillGroupInfo._showCheckCommand = false
  end
  local filterSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, 1)
  local filterSkillNo = filterSkillKey:getSkillNo()
  local isShowFilterEffect = PaGlobalFunc_SkillFilter_All_isFilterSkill(skillSSW, filterSkillNo)
  skillGroupInfo._control:EraseAllEffect()
  if isShowFilterEffect == true then
    skillGroupInfo._control:AddEffect("fUI_NewSkill_Guide_03A", true, 0, 0)
  end
  local isLearnedSkill = ToClient_isLearnedSkill(skillNo)
  local branchType = skillSSW:getSkillAwakenBranchType()
  local isOtherBranch = self._canSelectBranch == true and branchType ~= __eSkillTypeParam_Normal and branchType ~= self._selectedSkillType
  local nextSkillNo = 0
  if isLearnedSkill == true and isOtherBranch == false then
    skillGroupInfo._learnPlusEffect:SetShow(false)
    skillGroupInfo._slot.icon:addInputEvent("Mouse_RUp", "PaGlobal_SkillGroup_All:clearButtonClick(" .. skillNo .. "," .. skillGroupInfo._key .. ", false)")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_SkillGroup_All:clearButtonClick(" .. skillNo .. "," .. skillGroupInfo._key .. ", false)")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "PaGlobal_SkillGroup_All:clearButtonClick(" .. skillNo .. "," .. skillGroupInfo._key .. ", true)")
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
    if skillLevelInfo._learnable == false and skillLevelInfo._usable and skillTypeStaticWrapper:get()._isSettableQuickSlot == true then
      skillGroupInfo._slot.icon:addInputEvent("Mouse_PressMove", "PaGlobalFunc_SkillGroup_All_StartDrag(" .. skillNo .. ")")
      skillGroupInfo._slot.icon:SetEnableDragAndDrop(true)
    else
      skillGroupInfo._slot.icon:addInputEvent("Mouse_PressMove", "")
      skillGroupInfo._slot.icon:SetEnableDragAndDrop(false)
    end
    local nextSkillKey = ToClient_getNextLevelSkill(skillGroupInfo._key, selectLevel)
    local canLearnNextLevel = true
    if nextSkillKey:isDefined() == true then
      local nextSkillLevelInfo = getSkillLevelInfo(nextSkillKey:getSkillNo())
      local nextSkillSSW = getSkillStaticStatus(nextSkillKey:getSkillNo(), 1)
      if nextSkillLevelInfo ~= nil and nextSkillLevelInfo._learnable == true and nextSkillLevelInfo._usable == false then
        nextSkillNo = nextSkillKey:getSkillNo()
        skillGroupInfo._learnPlusEffect:SetIgnore(true)
        skillGroupInfo._learnPlusEffect:SetShow(true)
      else
        skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
        skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SkillGroup_PlayBlackSpiritSkill(" .. skillGroupInfo._key .. ")")
        skillGroupInfo._learnPlusEffect:SetShow(false)
        skillGroupInfo._learnPlusEffect:SetIgnore(false)
      end
    else
      skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
      skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
      skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
      skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SkillGroup_PlayBlackSpiritSkill(" .. skillGroupInfo._key .. ")")
    end
  else
    if skillLevelInfo == nil then
      return
    end
    if skillLevelInfo._learnable == true and isOtherBranch == false then
      skillGroupInfo._learnPlusEffect:SetShow(true)
      skillGroupInfo._learnPlusEffect:SetIgnore(true)
    else
      skillGroupInfo._learnPlusEffect:SetShow(false)
      skillGroupInfo._learnPlusEffect:SetIgnore(false)
    end
    skillGroupInfo._slot.icon:addInputEvent("Mouse_PressMove", "")
    skillGroupInfo._slot.icon:addInputEvent("Mouse_RUp", "")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    skillGroupInfo._slot.icon:SetEnableDragAndDrop(false)
  end
  if self:checkMyClassType() == false then
    skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "PaGlobalFunc_SkillGroup_PlayBlackSpiritSkill(" .. skillGroupInfo._key .. ")")
    skillGroupInfo._control:SetMonoTone(false, false)
    skillGroupInfo._slot.icon:SetMonoTone(false, false)
    skillGroupInfo._ableQuickSlotEffect:SetShow(false)
  elseif isOtherBranch == true then
    skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobalFunc_SkillGroup_All_CannotLernSkill(" .. branchType .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_SkillGroup_All_CannotLernSkill(" .. branchType .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobalFunc_SkillGroup_All_CannotLernSkill(" .. branchType .. ")")
    skillGroupInfo._control:SetMonoTone(true, true)
    skillGroupInfo._slot.icon:SetMonoTone(true, true)
    skillGroupInfo._ableQuickSlotEffect:SetMonoTone(true, true)
  elseif isLearnedSkill == true then
    if skillTypeStatic:isActiveSkill() == true and skillTypeStatic._isSettableQuickSlot == true then
      skillGroupInfo._ableQuickSlotEffect:SetShow(true)
    else
      skillGroupInfo._ableQuickSlotEffect:SetShow(false)
    end
    skillGroupInfo._control:SetMonoTone(false)
    skillGroupInfo._slot.icon:SetMonoTone(false)
    skillGroupInfo._ableQuickSlotEffect:SetMonoTone(false)
    if nextSkillNo ~= 0 then
      skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. nextSkillNo .. ")")
      skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. nextSkillNo .. ")")
      skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. nextSkillNo .. ")")
    end
  elseif skillLevelInfo._learnable == true then
    skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. skillNo .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. skillNo .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. skillNo .. ")")
    skillGroupInfo._control:SetMonoTone(false)
    skillGroupInfo._slot.icon:SetMonoTone(true, true)
    skillGroupInfo._ableQuickSlotEffect:SetMonoTone(true, true)
  else
    skillGroupInfo._slot.icon:addInputEvent("Mouse_LUp", "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. skillNo .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. skillNo .. ")")
    skillGroupInfo._control:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(" .. skillNo .. ")")
    skillGroupInfo._control:SetMonoTone(true, true)
    skillGroupInfo._slot.icon:SetMonoTone(true, true)
    skillGroupInfo._ableQuickSlotEffect:SetMonoTone(true, true)
  end
  if isLearnSkill == true then
    skillGroupInfo._slot.icon:EraseAllEffect()
    audioPostEvent_SystemUi(4, 2)
    _AudioPostEvent_SystemUiForXBOX(4, 2)
    skillGroupInfo._slot.icon:AddEffect("fUI_NewSkill_New_Skill_01A", false, 0, 0)
    skillGroupInfo._slot.icon:AddEffect("", false, 0, 0)
    skillGroupInfo._slot.icon:AddEffect("fUI_NewSkill_New_Skill_Slot_01A", false, 0, 0)
  end
  local currentCircleLevel = -1
  local circleDefaultList = UI.getChildControl(skillGroupInfo._control, "Static_SkillLevelNone")
  local circleLearnList = UI.getChildControl(skillGroupInfo._control, "Static_SkillLevelLearn")
  for ii = 1, 25 do
    local circleDefault = UI.getChildControl(circleDefaultList, "Button_SkillLevelNone_" .. ii)
    local circleLearn = UI.getChildControl(circleLearnList, "Button_SkillLevelLearn_" .. ii)
    if skillGroupInfo._isActiveItemSkill == true then
      circleDefault:SetShow(false)
      circleLearn:SetShow(false)
    elseif ii <= skillGroupInfo._maxLevel then
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, ii)
      if skillKey:isDefined() == true then
        local isLearn = ToClient_isLearnedSkill(skillKey:getSkillNo())
        circleDefault:SetShow(isLearn == false)
        circleLearn:SetShow(isLearn == true)
        if isLearn == true and ii > currentCircleLevel then
          currentCircleLevel = ii
        end
      else
        circleDefault:SetShow(true)
        circleLearn:SetShow(false)
      end
    else
      circleDefault:SetShow(false)
      circleLearn:SetShow(false)
    end
  end
  if skillSSW ~= nil then
    self:skillGroupInfo_updateSkillCCType(skillGroupInfo, skillSSW)
  end
  skillGroupInfo._slot.icon:addInputEvent("Mouse_On", "HandleMOver_SkillWindow_ToolTipShow(" .. skillNo .. ", " .. skillGroupInfo._key .. ")")
  skillGroupInfo._slot.icon:addInputEvent("Mouse_Out", "HandleMOver_SkillWindow_ToolTipHide(" .. skillNo .. ", \"SkillBox\")")
  if skillGroupInfo._isActiveItemSkill == true then
    skillGroupInfo._focusIcon:SetShow(false)
  else
    local selectedCircle = UI.getChildControl(circleDefaultList, "Button_SkillLevelNone_" .. selectLevel)
    skillGroupInfo._focusIcon:SetSpanSize(circleDefaultList:GetSpanSize().x + selectedCircle:GetSpanSize().x - 2, circleDefaultList:GetSpanSize().y + selectedCircle:GetSpanSize().y - 2)
    skillGroupInfo._focusIcon:SetShow(true)
  end
  skillGroupInfo._selectLevel = selectLevel
  self:alignKeyguide(2, skillGroupInfo._key)
end
function PaGlobal_SkillGroup_All:skillGroupInfo_showCheckCommand(skillGroupInfo, isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if skillGroupInfo == nil then
    return
  end
  if skillGroupInfo._isBlockSkill == true then
    skillGroupInfo._check_command:SetShow(true)
  elseif isShow == true and skillGroupInfo._showCheckCommand == true then
    skillGroupInfo._check_command:SetShow(true)
  else
    skillGroupInfo._check_command:SetShow(false)
  end
end
function PaGlobal_SkillGroup_All:showSkillGroupCCTooltip(key, uiIndex, index, isShow, skillIndex)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = control
  if self._selectedTab == self._eTabType._fusion then
    local fusionSkillInfo = self._fusionSkillInfo[key]
    if fusionSkillInfo == nil then
      return
    end
    if skillIndex == 0 then
      local CCList = UI.getChildControl(fusionSkillInfo._resultControl1, "Static_CC_List")
      control = UI.getChildControl(CCList, "Static_CC_" .. uiIndex)
    else
      local CCList = UI.getChildControl(fusionSkillInfo._resultControl2, "Static_CC_List")
      control = UI.getChildControl(CCList, "Static_CC_" .. uiIndex)
    end
  else
    local skillGroupInfo = self._skillGroupInfo[key]
    if skillGroupInfo == nil then
      return
    end
    local CCList = UI.getChildControl(skillGroupInfo._control, "Static_CC_List")
    control = UI.getChildControl(CCList, "Static_CC_" .. uiIndex)
  end
  if control == nil then
    return
  end
  local title = ""
  local desc = ""
  if index == 1 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_INVINCIBILITY")
  elseif index == 2 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_SUPERARMOR")
  elseif index == 3 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FRONTGUARD")
  elseif index == 4 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKDOWN")
  elseif index == 5 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_JUMP")
  elseif index == 6 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_BOUND")
  elseif index == 7 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FAINT")
  elseif index == 8 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_STIFFNESS")
  elseif index == 9 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_KNOCKBACK")
  elseif index == 10 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_CATCH")
  elseif index == 11 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_FREEZE")
  elseif index == 12 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_DOWNSMASH")
  elseif index == 13 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_AIRSMASH")
  elseif index == 14 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_DOWNATTACK")
  elseif index == 15 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_AIRATTACK")
  elseif index == 16 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_COUNTERATTACK")
  elseif index == 17 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_SPEEDATTACK")
  else
    UI.ASSERT(false, "SkillCCType \236\149\132\236\157\180\236\189\152\236\157\180 \236\182\148\234\176\128\235\144\160 \234\178\189\236\154\176 \237\136\180\237\140\129 \236\138\164\237\138\184\235\167\129 \236\182\148\234\176\128\235\143\132 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.")
  end
  TooltipSimple_Show(control, title, desc)
end
function PaGlobal_SkillGroup_All:handleEventMouseOnOff_SkillGroup(isShow, key)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local skillGroupInfo = self._skillGroupInfo[key]
  if skillGroupInfo == nil then
    return
  end
  self:skillGroupInfo_showCheckCommand(skillGroupInfo, isShow)
  if isShow == true and skillGroupInfo._maxLevel > 1 and skillGroupInfo._isActiveItemSkill == false then
    skillGroupInfo._btn_prev:SetShow(true)
    skillGroupInfo._btn_next:SetShow(true)
  else
    skillGroupInfo._btn_prev:SetShow(false)
    skillGroupInfo._btn_next:SetShow(false)
  end
  self:alignKeyguide(2, key)
end
function PaGlobal_SkillGroup_All:handleEventLUp_SkillGroup(key, nextSkillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local skillGroupInfo = self._skillGroupInfo[key]
  if skillGroupInfo == nil then
    return
  end
  if nextSkillNo ~= nil and self._isPadSnapping == false then
    self:handleEventLUp_LearnSkill(nextSkillNo)
    return
  end
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, skillGroupInfo._selectLevel)
  self._selectedSkillNo = skillKey:getSkillNo()
  self._selectedSkillGroupKey = key
  PaGlobalFunc_SkillGroup_SkillAction(self._selectedSkillNo)
  PaGlobalFunc_SkillGroup_All_ChangeSkillShowTypeKeyGuide(self._selectedSkillNo)
  self:handleMLUp_Frame()
end
function PaGlobal_SkillGroup_All:handleEventLUp_SkillUpgrade(skillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  PaGlobalFunc_SkillGroup_SkillAction(skillNo)
  PaGlobalFunc_SkillGroup_All_ChangeSkillShowTypeKeyGuide(skillNo)
  self:handleMLUp_Frame()
end
function PaGlobal_SkillGroup_All:handleEventLUp_LevelButton(isPlus, key)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isPlus == nil then
    return
  end
  local skillGroupInfo = self._skillGroupInfo[key]
  if skillGroupInfo == nil then
    return
  end
  local isPressShift = isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT)
  if isPressShift == true then
    if isPlus == true then
      level = skillGroupInfo._maxLevel
    else
      level = 1
    end
  elseif isPlus == true then
    level = skillGroupInfo._selectLevel + 1
    if skillGroupInfo._maxLevel < level then
      level = skillGroupInfo._maxLevel
    end
  else
    level = skillGroupInfo._selectLevel - 1
    if level <= 1 then
      level = 1
    end
  end
  self:skillGroupInfo_selectLevel(skillGroupInfo, level)
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, level)
  if skillKey:isDefined() == false then
    return
  end
  local skillNo = skillKey:getSkillNo()
  PaGlobal_SkillGroup_All._selectedSkillNo = skillNo
  PaGloabl_SkillGroup_ShowDesc(skillNo)
  PaGlobalFunc_SkillGroup_All_ChangeSkillShowTypeKeyGuide(skillNo)
end
function PaGlobal_SkillGroup_All:handleEventLUp_SkillCommandLock(key)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local skillGroupInfo = self._skillGroupInfo[key]
  if skillGroupInfo == nil then
    return
  end
  local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, skillGroupInfo._selectLevel)
  if skillKey:isDefined() == false then
    return
  end
  local skillNo = skillKey:getSkillNo()
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if skillLevelInfo ~= nil then
    local isBlockSkill = ToClient_isBlockSkillCommand(skillLevelInfo._skillKey)
    if isBlockSkill == true then
      local groupMaxLevel = ToClient_getSkillGroupMaxLevel(skillGroupInfo._key)
      for ii = 1, groupMaxLevel do
        local relatedSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, ii)
        local relatedSkillNo = relatedSkillKey:getSkillNo()
        local relatedSkillLevelInfo = getSkillLevelInfo(relatedSkillNo)
        if relatedSkillLevelInfo ~= nil then
          ToClient_enableSkillCommand(relatedSkillLevelInfo._skillKey)
        end
      end
    else
      ToClient_blockSkillCommand(skillLevelInfo._skillKey)
    end
  end
  self:skillGroupInfo_selectLevel(skillGroupInfo, skillGroupInfo._selectLevel)
end
function PaGlobal_SkillGroup_All:checkMyClassType()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == true then
    return false
  end
  if self._classType ~= selfPlayer:getClassType() then
    return false
  end
  return true
end
function PaGlobal_SkillGroup_All:handleEventLUp_LearnSkill(skillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self:checkMyClassType() == false then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if skillTypeStaticWrapper == nil then
    return
  end
  local skillLevelInfo = getSkillLevelInfo(skillNo)
  if skillLevelInfo == nil then
    return
  end
  local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
  if skillGroupInfo ~= nil then
    if self._isPadSnapping == true and (self._selectedSkillGroupKey == nil or self._selectedSkillGroupKey ~= skillGroupInfo._key) then
      self:handleEventLUp_SkillGroup(skillGroupInfo._key)
      return
    else
      self:handleEventLUp_SkillGroup(skillGroupInfo._key)
    end
    if skillGroupInfo._learnPlusEffect:GetShow() == false then
      return
    end
  end
  local isPressShift = false
  if self._isPadSnapping == true then
    if isPadPressed(__eJoyPadInputType_LeftTrigger) == true then
      isPressShift = true
    end
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) == true then
    isPressShift = true
  end
  local function needSkillEffect()
    if PaGlobalFunc_SkillGroup_All_FindSkillGroupAndFocusEffect(skillLevelInfo._needSkillNo1) == true then
      local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillLevelInfo._needSkillNo1)
      if skillGroupInfo ~= nil then
        self:showGroupLearnLastSkillByGroup(skillGroupInfo)
      end
    elseif PaGlobalFunc_SkillGroup_All_FindSkillGroupAndFocusEffect(skillLevelInfo._needSkillNo2) == true then
      local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillLevelInfo._needSkillNo2)
      if skillGroupInfo ~= nil then
        self:showGroupLearnLastSkillByGroup(skillGroupInfo)
      end
    end
  end
  skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  skillLevelInfo = getSkillLevelInfo(skillNo)
  local learnedSkillLevel = getLearnedSkillLevel(skillTypeStaticWrapper)
  if skillLevelInfo._learnable == false and learnedSkillLevel == 0 then
    local skillSSW = getSkillStaticStatus(skillNo, 1)
    if skillSSW == nil then
      return
    end
    local branchType = skillSSW:getSkillAwakenBranchType()
    local resultString = self:getLearnSkillAlert(skillLevelInfo, branchType)
    if "" ~= resultString then
      local messageBoxMemo = resultString
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
        content = messageBoxMemo,
        functionYes = needSkillEffect,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
    return
  end
  local function dolearnSkill(isAll)
    local isSucess = false
    local skillLevelInfo = getSkillLevelInfo(skillNo)
    if skillLevelInfo ~= nil and skillLevelInfo._learnable == true then
      local skillSS = getSkillStaticStatus(skillNo, 1)
      if skillSS ~= nil then
        if skillSS:isAnyPreRequiredSkillBlocked() == true then
          local blockedPreRequiredSkillKeyList = skillSS:getBlockedPreRequiredSkillNoList()
          local skillNameStr = ""
          for k, v in pairs(blockedPreRequiredSkillKeyList) do
            local skillNo = v:getSkillNo()
            local skillTypeSS = getSkillTypeStaticStatus(skillNo)
            if skillTypeSS ~= nil and skillTypeSS:getName() ~= nil then
              if skillNameStr == "" then
                skillNameStr = skillTypeSS:getName()
              else
                skillNameStr = skillNameStr .. ", " .. skillTypeSS:getName()
              end
            end
          end
          local messageData = {
            title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
            content = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_BLOCKED_NOTICE") .. [[


]] .. skillNameStr,
            functionCancel = MessageBox_Empty_function,
            priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
          }
          MessageBox.showMessageBox(messageData)
        elseif isAll == true then
          local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
          if skillGroupInfo ~= nil then
            ToClient_doLearnSkillGroup(skillGroupInfo._key)
          end
          isSucess = true
        else
          isSuccess = skillWindow_DoLearn(skillNo)
        end
      end
    end
    if isSucess == true and PaGlobal_TooltipSkill_All ~= nil then
      PaGlobal_TooltipSkill_All.TooltipSkillGroup_NextLevel.main:SetShow(false)
    end
  end
  skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  local skillType = skillTypeStaticWrapper:requiredEquipType()
  if skillType == 55 then
    if skillLevelInfo._learnable == true then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLTYPE_MEMO1")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = dolearnSkill,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  elseif skillType == 56 then
    if skillLevelInfo._learnable == true then
      local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_SKILLTYPE_MEMO2")
      local messageBoxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
        content = messageBoxMemo,
        functionYes = dolearnSkill,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageBoxData)
    end
  elseif isPressShift == true then
    dolearnSkill(true)
  else
    dolearnSkill(false)
  end
end
function PaGlobal_SkillGroup_All:getSkillGroupInfoBySkillNo(skillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
  if skillTypeStaticWrapper == nil then
    return nil
  end
  local skillTypeStatic = skillTypeStaticWrapper:get()
  if skillTypeStatic == nil then
    return nil
  end
  local key = skillTypeStatic:getSkillGroupNo()
  return self._skillGroupInfo[key]
end
function PaGlobal_SkillGroup_All:showGroupLearnLastSkillByGroup(skillGroupInfo, isLearnSkill)
  if skillGroupInfo == nil then
    return
  end
  if isLearnSkill == nil then
    isLearnSkill = false
  end
  local currentGroupLevel = self:getCurrentGroupLevel(skillGroupInfo)
  local currentSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, currentGroupLevel)
  local currentSkillNo = currentSkillKey:getSkillNo()
  if isLearnSkill == false then
    PaGloabl_SkillGroup_ShowDesc(currentSkillNo)
    PaGlobalFunc_SkillGroup_All_ChangeSkillShowTypeKeyGuide(currentSkillNo)
  end
  self:skillGroupInfo_selectLevel(skillGroupInfo, currentGroupLevel, isLearnSkill)
end
function PaGlobal_SkillGroup_All:getCurrentGroupLevel(skillGroupInfo)
  if skillGroupInfo == nil then
    return
  end
  local selectLevel = 1
  for ii = 1, skillGroupInfo._maxLevel do
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, ii)
    if skillKey:isDefined() == true then
      local isLearn = ToClient_isLearnedSkill(skillKey:getSkillNo())
      if isLearn == true then
        selectLevel = ii
      end
    end
  end
  return selectLevel
end
function PaGlobal_SkillGroup_All:changeSkillType()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._focusEffect ~= nil then
    self._focusEffect:EraseAllEffect()
  end
  if self._targetSkillType == __eSkillTypeParam_Awaken then
    self._ui._rdo_awakenSkill:AddEffect("fUI_NewSkill_AroUp_Bookmark_01B", false, 0, 0)
    audioPostEvent_SystemUi(27, 3)
    _AudioPostEvent_SystemUiForXBOX(27, 3)
    if self._isReverseSkillType == true then
      local awakenRoot = ToClient_getAwakenRootSkillGroupNo(self._classType)
      local skillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
      if skillKey:isDefined() == true then
        local skillNo = skillKey:getSkillNo()
        self:handleEventLUp_LearnSkill(skillNo)
      end
    else
      self:updateAwakenSkillArea()
    end
    if self._isAwakenGuide == true then
      self:selectTab(self._eTabType._awaken)
      self._isAwakenGuide = false
    end
  elseif self._targetSkillType == __eSkillTypeParam_Inherit then
    self._ui._rdo_successionSkill:AddEffect("fUI_NewSkill_AroUp_Bookmark_01A", false, 0, 0)
    audioPostEvent_SystemUi(27, 3)
    _AudioPostEvent_SystemUiForXBOX(27, 3)
    local successionRoot = ToClient_getSuccessionRootSkillGroupNo(self._classType)
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
    if skillKey:isDefined() == true then
      local skillNo = skillKey:getSkillNo()
      self:handleEventLUp_LearnSkill(skillNo)
    end
  end
  self._selectedSkillType = self._targetSkillType
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eSkillGroupWindowPlayerTree, self._selectedSkillType + 1, CppEnums.VariableStorageType.eVariableStorageType_Character)
  self._targetSkillType = -1
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
end
function PaGlobal_SkillGroup_All:makeSkillTypeArea()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(self._classType)
  local awakenRoot = ToClient_getAwakenRootSkillGroupNo(self._classType)
  if successionRoot == 0 or PaGlobalFunc_Util_IsSuccessionContentsOpen(self._classType) == false or self:checkMyClassType() == false then
    self._ui._stc_skillTypeArea:SetShow(false)
    self._canSelectBranch = false
  else
    self._ui._stc_skillTypeArea:SetShow(true)
  end
  self:defaultPanelResize()
  if self._isLearnedAwakenSkill == false and self._isLearnedSuccessionSkill == false then
    self._canSelectBranch = false
  else
    self._canSelectBranch = true
  end
end
function PaGlobal_SkillGroup_All:updateSkillTypeArea(openTab)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  if openTab == nil then
    openTab = false
  end
  self._ui._rdo_successionSkill:SetShow(self._isLearnedSuccessionSkill)
  self._ui._stc_successionLock:SetShow(not self._isLearnedSuccessionSkill)
  self._ui._rdo_awakenSkill:SetShow(self._isLearnedAwakenSkill)
  self._ui._stc_awakenLock:SetShow(not self._isLearnedAwakenSkill)
  if self._isLearnedSuccessionSkill == true and self._selectedSkillType == __eSkillTypeParam_Inherit then
    self._ui._rdo_successionSkill:SetCheck(true)
    self._ui._rdo_awakenSkill:SetCheck(false)
    if openTab == true then
      self:selectTab(self._eTabType._mainWeapon)
    end
  elseif self._isLearnedAwakenSkill == true and self._selectedSkillType == __eSkillTypeParam_Awaken then
    self._ui._rdo_successionSkill:SetCheck(false)
    self._ui._rdo_awakenSkill:SetCheck(true)
    if openTab == true then
      self:selectTab(self._eTabType._awaken)
    end
  elseif self._selectedSkillType == __eSkillTypeParam_Normal then
    self._ui._rdo_successionSkill:SetCheck(false)
    self._ui._rdo_awakenSkill:SetCheck(false)
    if openTab == true then
      self:selectTab(self._eTabType._mainWeapon)
    end
  end
  local stc_isSuccesstion = UI.getChildControl(self._ui._rdo_successionSkill, "StaticText_CurrentStatus")
  local stc_isAwaken = UI.getChildControl(self._ui._rdo_awakenSkill, "StaticText_CurrentStatus")
  if self._selectedSkillType == __eSkillTypeParam_Inherit then
    stc_isSuccesstion:SetShow(true)
    stc_isAwaken:SetShow(false)
  elseif self._selectedSkillType == __eSkillTypeParam_Awaken then
    stc_isSuccesstion:SetShow(false)
    stc_isAwaken:SetShow(true)
  else
    stc_isSuccesstion:SetShow(false)
    stc_isAwaken:SetShow(false)
  end
  if self._selectedSkillType == __eSkillTypeParam_Normal then
    self:shiftKeyGuideShow()
  end
  local viewTabCount = 0
  local viewTabList = Array.new()
  viewTabList:push_back(self._ui._rdo_tab_mainWeapon)
  viewTabList:push_back(self._ui._rdo_tab_awakenWeapon)
  if self._classType == __eClassType_ShyWaman then
    self._ui._rdo_tab_awakenWeapon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_TALENT"))
  else
    self._ui._rdo_tab_awakenWeapon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLESTALLION_AWAKEN"))
  end
  self._isOpenFusionSkill = ToClient_isLearnFusionSkillLevel() and ToClient_getFusionSkillListCountByClassType(self._classType, 0) ~= 0 or self:checkMyClassType() == false
  if self._isOpenFusionSkill == true then
    viewTabList:push_back(self._ui._rdo_tab_fusionSkill)
  else
    self._ui._rdo_tab_fusionSkill:SetShow(false)
  end
  local playerLevel = selfPlayer:getLevel()
  self._isOpenUpgradeSkill = playerLevel >= 50 and ToClient_HardCoreChannelWithContensOption() == false and self:checkMyClassType() == true
  if self._isOpenUpgradeSkill == true then
    viewTabList:push_back(self._ui._rdo_tab_upgradeSkill)
  else
    self._ui._rdo_tab_upgradeSkill:SetShow(false)
  end
  local viewCount = #viewTabList
  for i = 1, viewCount do
    if viewTabList[i] ~= nil then
      viewTabList[i]:SetShow(true)
      viewTabList[i]:SetSize(self._ui._stc_radioGroup:GetSizeX() / viewCount, viewTabList[i]:GetSizeY())
      viewTabList[i]:SetPosX(self._ui._stc_radioGroup:GetSizeX() / viewCount * (i - 1))
    end
  end
end
function PaGlobal_SkillGroup_All:handleEventLUp_SkillTypeArea(skillType)
  if PaGlobalFunc_SkillGroup_All_IsSearchState() == true then
    return
  end
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  local skillKey = 0
  if skillType == __eSkillTypeParam_Inherit then
    local successionRoot = ToClient_getSuccessionRootSkillGroupNo(self._classType)
    skillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  elseif skillType == __eSkillTypeParam_Awaken then
    local awakenRoot = ToClient_getAwakenRootSkillGroupNo(self._classType)
    skillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
  end
  if skillKey:isDefined() == false then
    return
  end
  local skillNo = skillKey:getSkillNo()
  PaGlobalFunc_SkillGroup_SelectType_Open(self._classType, skillType, skillNo)
end
function PaGlobal_SkillGroup_All:shiftKeyGuideShow()
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  local spInfo = ToClient_getSkillPointInfo(0)
  if spInfo == nil then
    return
  end
  local playerLevel = selfPlayer:getLevel()
  local skillPoint = tonumber(selfPlayer:getRemainSkillPoint())
  local maxSkillPoint = tonumber(spInfo._acquirePoint)
  if skillPoint == maxSkillPoint and playerLevel >= 56 and self:checkMyClassType() == true then
    self._ui._stc_shiftGuideMain:SetShow(true)
    if self._isPadSnapping == true then
      ToClient_padSnapChangeToTarget(self._ui._btn_shiftGuideClose)
    end
  end
end
function PaGlobal_SkillGroup_All:getCurrentSkillType()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(self._classType)
  local awakenRoot = ToClient_getAwakenRootSkillGroupNo(self._classType)
  if successionRoot == 0 or PaGlobalFunc_Util_IsSuccessionContentsOpen(self._classType) == false then
    return
  end
  local successionSkillKey = ToClient_getSkillKeyBySkillGroupNo(successionRoot, 1)
  local successionSkillNo = successionSkillKey:getSkillNo()
  local successionSkillSSW = getSkillStaticStatus(successionSkillNo, 1)
  local successionSkillTypeSSW = getSkillTypeStaticStatus(successionSkillNo)
  local successionNeedSkillNo = 0
  if successionSkillSSW ~= nil then
    local successionNeedSkill = successionSkillSSW:getAllPreRequiredSkillNoList()
    if successionNeedSkill ~= nil and successionNeedSkill[0] ~= nil then
      successionNeedSkillNo = successionNeedSkill[0]:getSkillNo()
    end
  end
  self._isLearnedSuccessionSkill = ToClient_isLearnedSkill(successionSkillNo)
  if self._isLearnedSuccessionSkill == false then
    self._isLearnedSuccessionSkill = ToClient_isLearnedSkill(successionNeedSkillNo)
  end
  local awakenSkillKey = ToClient_getSkillKeyBySkillGroupNo(awakenRoot, 1)
  local awakenSkillNo = awakenSkillKey:getSkillNo()
  local awakenSkillSSW = getSkillStaticStatus(awakenSkillNo, 1)
  local awakenNeedSkillNo = 0
  if awakenSkillSSW ~= nil then
    local awakenNeedSkill = awakenSkillSSW:getAllPreRequiredSkillNoList()
    if awakenNeedSkill ~= nil and awakenNeedSkill[0] ~= nil then
      awakenNeedSkillNo = awakenNeedSkill[0]:getSkillNo()
    end
  end
  self._isLearnedAwakenSkill = ToClient_isLearnedSkill(awakenSkillNo)
  if self._isLearnedAwakenSkill == false then
    self._isLearnedAwakenSkill = ToClient_isLearnedSkill(awakenNeedSkillNo)
  end
  local selectedSkillType = __eSkillTypeParam_Normal
  if self._isLearnedSuccessionSkill == false and self._isLearnedAwakenSkill == false then
    selectedSkillType = __eSkillTypeParam_Normal
  elseif self._isLearnedSuccessionSkill == true and self._isLearnedAwakenSkill == true then
    local cacheValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eSkillGroupWindowPlayerTree)
    if cacheValue == 0 then
      selectedSkillType = ToClient_GetCurrentPlayerSkillType()
    else
      selectedSkillType = cacheValue - 1
    end
  elseif self._isReverseSkillType == false then
    if self._isLearnedAwakenSkill == true and self._isLearnedSuccessionSkill == false then
      selectedSkillType = __eSkillTypeParam_Awaken
    end
  elseif self._isLearnedSuccessionSkill == true and self._isLearnedAwakenSkill == false then
    selectedSkillType = __eSkillTypeParam_Inherit
  end
  return selectedSkillType
end
function PaGlobal_SkillGroup_All:learnSkill(skillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self:checkMyClassType() == false then
    return
  end
  if _ContentsGroup_SkillComboGuide == true and PaGlobal_SkillCombo_UpdateSkillCombo ~= nil then
    PaGlobal_SkillCombo_UpdateSkillCombo()
  end
  if self._selectedTab == self._eTabType._mainWeapon then
    self:updateMainWeaponSkillArea()
    self:updateStat()
    audioPostEvent_SystemUi(27, 1)
    _AudioPostEvent_SystemUiForXBOX(27, 1)
  elseif self._selectedTab == self._eTabType._awaken then
    self:updateAwakenSkillArea()
    self:updateStat()
    audioPostEvent_SystemUi(27, 1)
    _AudioPostEvent_SystemUiForXBOX(27, 1)
  end
  local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
  if skillGroupInfo ~= nil then
    self:updateSkillGroupInfo(skillGroupInfo, true)
    self:showGroupLearnLastSkillByGroup(skillGroupInfo, true)
  end
end
function PaGlobal_SkillGroup_All:defaultPanelResize()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local screenSizeY = getScreenSizeY()
  Panel_Window_SkillGroup_All:SetSize(Panel_Window_SkillGroup_All:GetSizeX(), screenSizeY)
  Panel_Window_SkillGroup_All:ComputePos()
  local topFrameSize = 0
  if self._ui._stc_skillTypeArea:GetShow() == true then
    self._ui._stc_radioGroup:SetPosY(self._ui._stc_skillTypeArea:GetPosY() + self._ui._stc_skillTypeArea:GetSizeY())
    topFrameSize = self._ui._stc_skillTypeArea:GetSizeY()
  else
    self._ui._stc_radioGroup:SetPosY(0)
    self._ui._rdo_tab_mainWeapon:SetPosY(0)
    self._ui._rdo_tab_awakenWeapon:SetPosY(0)
    self._ui._rdo_tab_fusionSkill:SetPosY(0)
    self._ui._rdo_tab_upgradeSkill:SetPosY(0)
    self._ui._stc_topFunctionArea:SetPosY(self._ui._rdo_tab_mainWeapon:GetSizeY())
  end
  self._ui._stc_topFunctionArea:SetPosY(self._ui._stc_radioGroup:GetPosY() + self._ui._stc_radioGroup:GetSizeY())
  topFrameSize = topFrameSize + self._ui._stc_topFunctionArea:GetSizeY()
  local framePosY = self._ui._stc_topFunctionArea:GetPosY() + self._ui._stc_topFunctionArea:GetSizeY()
  topFrameSize = topFrameSize + self._ui._stc_topFunctionArea:GetSizeY()
  if self._isPadSnapping == true then
    framePosY = framePosY + 1
  end
  local frameSizeY = 0
  if self._isPadSnapping == true then
    frameSizeY = screenSizeY - topFrameSize
  else
    frameSizeY = screenSizeY - topFrameSize - self._ui._stc_bottomArea:GetSizeY()
  end
  self._ui._stc_mainWeaponSkillArea:SetPosY(framePosY)
  self._ui._stc_awakenSkillArea:SetPosY(framePosY)
  self._ui._stc_fusionSkillArea:SetPosY(framePosY)
  self._ui._stc_upgradeSkillArea:SetPosY(framePosY)
  self._ui._stc_mainWeaponSkillArea:SetSize(self._ui._stc_mainWeaponSkillArea:GetSizeX(), frameSizeY)
  self._ui._stc_awakenSkillArea:SetSize(self._ui._stc_awakenSkillArea:GetSizeX(), frameSizeY)
  self._ui._stc_fusionSkillArea:SetSize(self._ui._stc_fusionSkillArea:GetSizeX(), frameSizeY)
  self._ui._stc_upgradeSkillArea:SetSize(self._ui._stc_upgradeSkillArea:GetSizeX(), frameSizeY)
  self._ui._frame_skillGroupArea_main:SetPosY(0)
  self._ui._frame_skillGroupArea_main:SetSize(self._ui._frame_skillGroupArea_main:GetSizeX(), frameSizeY)
  self._ui._frame_skillGroupArea_awaken:SetPosY(0)
  self._ui._frame_skillGroupArea_awaken:SetSize(self._ui._frame_skillGroupArea_awaken:GetSizeX(), frameSizeY)
  if self:checkMyClassType() == true then
    self._ui._stc_fusionSkillTopArea:SetShow(true)
    self._ui._frame_fusionSkill:SetPosY(self._ui._stc_fusionSkillTopArea:GetSizeY())
    self._ui._frame_fusionSkill:SetSize(self._ui._frame_fusionSkill:GetSizeX(), frameSizeY - self._ui._stc_fusionSkillTopArea:GetSizeY())
    self._ui._list2_upgradeList:SetPosY(0)
    self._ui._list2_upgradeList:SetSize(self._ui._list2_upgradeList:GetSizeX(), frameSizeY)
  else
    self._ui._stc_fusionSkillTopArea:SetShow(false)
    self._ui._frame_fusionSkill:SetPosY(0)
    self._ui._frame_fusionSkill:SetSize(self._ui._frame_fusionSkill:GetSizeX(), frameSizeY)
  end
  self._ui._stc_bottomArea:ComputePos()
  self._ui._stc_presetBG:ComputePos()
  self._ui._btn_naviSkillMaster:ComputePos()
  self._ui._keyguide_naviSkillMaster:ComputePos()
  if self._isPadSnapping == true then
    if self._isWindow == false then
      local spanY = getScreenSizeY() - Panel_Window_SkillGroup_All:GetSizeY() - 20
      self._ui._keyguide_CameraBg:SetSpanSize(self._ui._keyguide_CameraBg:GetSpanSize().x, -spanY)
      self._ui._keyguide_CameraBg:SetShow(true)
    else
      self._ui._keyguide_CameraBg:SetShow(false)
    end
  end
end
function PaGlobal_SkillGroup_All:updateSkillTooltip(skillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if Panel_Window_SkillGroup_All:GetShow() == false then
    return
  end
  local skillGroupInfo = self:getSkillGroupInfoBySkillNo(skillNo)
  if skillGroupInfo == nil then
    return
  end
  if self._isPadSnapping == true then
    ToClient_padSnapChangeToTarget(skillGroupInfo._control)
    self:alignKeyguide(2, skillGroupInfo._key)
  else
    if Panel_Tooltip_SkillGroup_forLearning:GetShow() == false and Panel_SkillTooltip_GetShow() == false then
      return
    end
    Panel_SkillTooltip_Hide()
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, skillGroupInfo._selectLevel)
    if skillKey:isDefined() == false then
      return
    end
    local skillNo = skillKey:getSkillNo()
    Panel_SkillTooltip_Show(skillNo, false, "SkillAwakenSet")
  end
end
function PaGlobal_SkillGroup_All:updateStat()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer == nil then
    return
  end
  local skillPointInfo = ToClient_getSkillPointInfo(0)
  if skillPointInfo == nil then
    return
  end
  self._remainSkillPoint = skillPointInfo._remainPoint
  local skillPointNeedExp = selfPlayer:getSkillPointNeedExperience()
  if skillPointNeedExp == 0 then
    return
  end
  local skillExpRate = selfPlayer:getSkillPointExperience() / skillPointNeedExp * 100
  local skillPointExp = string.format("%.1f", skillExpRate)
  local skillPoint = tostring("<PAColor0xfff5ba3a>" .. skillPointInfo._remainPoint) .. " / " .. tostring(skillPointInfo._acquirePoint .. "(" .. tostring(skillPointExp) .. "%)<PAOldColor>")
  self._ui._txt_skillPointValue:SetText(skillPoint)
end
function PaGlobal_SkillGroup_All:clearButtonClick(skillNo, skillGroupKey, isAllSkill, isSkillFusion)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local isPressShift = isAllSkill
  if self._isPadSnapping == false and true == isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) then
    isPressShift = true
  end
  self._isClearSkillFusion = isSkillFusion
  if isPressShift == false or isSkillFusion == true then
    local returnValue = ToClient_RequestClearSkillPartly(skillNo)
    if returnValue == 0 then
      ToClient_clearSkillCoolTimeSlot(skillNo)
      PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
      self._clearSkillGroupKey = skillGroupKey
    end
  else
    local returnValue = ToClient_doClearSkillGroup(skillGroupKey)
    if returnValue == true then
      ToClient_clearSkillCoolTimeSlot(skillNo)
      PaGlobal_SkillCoolTimeQuickSlot:updateQuickSlot()
      self._clearSkillGroupKey = skillGroupKey
    end
  end
end
function PaGlobal_SkillGroup_All:updateSlot()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  for key, skillGroupInfo in pairs(self._skillGroupInfo) do
    self:updateSkillGroupInfo(skillGroupInfo)
    self:skillGroupInfo_selectLevel(skillGroupInfo, skillGroupInfo._selectLevel)
  end
end
function PaGlobal_SkillGroup_All:selectFusionSkill(skillNo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self._selectedSkillNo = skillNo
  PaGlobalFunc_SkillGroup_SkillAction(skillNo)
end
function PaGlobal_SkillGroup_All:learnFusionSkill(mainSkillNo, subSkillNo, resultSkillNo, slotNo, skillIndex)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isPadSnapping == true and self._selectedSkillNo ~= resultSkillNo then
    return
  end
  if self._fusionSkillEffectPlay == false then
    self._fusionSkillEffectPlay = true
    self._fusionSkillEffectTime = 0
    Panel_Window_SkillGroup_All:RegisterUpdateFunc("PaGlobalFunc_SkillGroup_All_LearnFusionSKillUpdatePerFrame")
    audioPostEvent_SystemUi(27, 2)
    _AudioPostEvent_SystemUiForXBOX(27, 2)
    local fusionSkillInfo = self._fusionSkillInfo[slotNo]
    if fusionSkillInfo ~= nil then
      if skillIndex == 0 then
        fusionSkillInfo._control:AddEffect("fUI_NewSkill_Intensive_01A", false, 0, 0)
      else
        fusionSkillInfo._control:AddEffect("fUI_NewSkill_Intensive_01B", false, 0, 0)
      end
    end
    self._mainSkillNo = mainSkillNo
    self._subSkillNo = subSkillNo
    self._resultSkillNo = resultSkillNo
    self._selectedFusionSlotNo = slotNo
    self._selectedFusionSkillIndex = skillIndex
  end
end
function PaGlobal_SkillGroup_All:learnFusionSKillUpdatePerFrame(deltaTime)
  self._fusionSkillEffectTime = self._fusionSkillEffectTime + deltaTime
  if self._fusionSkillEffectTime > 2 and self._fusionSkillEffectPlay == true then
    ToClient_requestLearnFusionSkill(self._resultSkillNo, self._mainSkillNo, self._subSkillNo)
    self._fusionSkillEffectTime = 0
    self._fusionSkillEffectPlay = false
    Panel_Window_SkillGroup_All:ClearUpdateLuaFunc()
  end
end
function PaGlobal_SkillGroup_All:showSkillPresetToolTip(index)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local title = ""
  local message = ""
  local control
  if self._presetSlotMaxCount == index then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_SAVE_TOOLTIP_NAME")
    message = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_SAVE_TOOLTIP_DESC")
    control = self._ui._btn_presetSave
    self:alignKeyguide(5)
  else
    local isSet, presetMemo = PaGlobalFunc_SkillPresetMemo_IsSetMemo(index)
    if isSet == nil or isSet == false then
      title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_DISK" .. tostring(index + 1))
    else
      title = presetMemo
    end
    message = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_TOOLTIP_DESC")
    if self._isPadSnapping == false then
      message = message .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_MEMOGUIDE")
    end
    control = self._btn_skillPresetList[index + 1]
    self:alignKeyguide(5, nil, nil, nil, true)
  end
  TooltipSimple_Show(control, title, message)
end
function PaGlobal_SkillGroup_All:showLockSkillPresetToolTip(isShow, index)
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_DISK" .. tostring(index + 1))
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_TOOLTIP_DESC")
  local control = self._btn_skillPresetList[index + 1]
  TooltipSimple_Show(control, title, desc)
  self:alignKeyguide(5)
end
function PaGlobal_SkillGroup_All:viewControllerToggle()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_NpcDialog then
    return
  end
  self._isWindow = not self._ui._chk_playShow:IsCheck()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSkillGroupWindowViewPlayPanel, self._isWindow, CppEnums.VariableStorageType.eVariableStorageType_User)
  self:updateViewController()
end
function PaGlobal_SkillGroup_All:updateViewController()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isWindow == false then
    if ToClient_LearnSkillCameraIsShow() == true then
      ToClient_LearnSkillCameraHide()
    end
    self:updateEditMode(false)
    PaGlobal_SkillGroup_Controller:open(Panel_Window_SkillGroup_All)
    if self:checkMyClassType() == true then
      ToClient_LearnSkillCameraShow()
    else
      ToClient_LearnSkillCameraShowOtherClass(self._classType)
    end
    ToClient_LearnSkillCameraLoadCharcterAndCamera()
    ToClient_LearnSkillCameraSetZoom(200)
    ToClient_LearnSkillCameraSetPosition(70, -10)
    ToClient_LearnSkillCameraSetRotation(-2.5, -0.3)
    self:skillGroupResize()
  else
    if ToClient_LearnSkillCameraIsShow() == true and ToClient_LearnSkillCameraHide() == false then
      return
    end
    if Panel_Window_SkillGroup_Controller:GetShow() == true then
      PaGlobal_SkillGroup_Controller:close()
    end
  end
  self._ui._chk_playShow:SetCheck(not self._isWindow)
end
function PaGlobal_SkillGroup_All:handleEventLUp_EditMode()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:updateEditMode(not self._isEditMode)
end
function PaGlobal_SkillGroup_All:updateEditMode(isEditMode)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self._isEditMode = isEditMode
  if self._isEditMode == true then
    PaGlobal_SkillGroup_QuickSlot:prepareOpen()
  else
    DragManager:clearInfo()
    PaGlobal_SkillGroup_QuickSlot:prepareClose()
  end
  if Panel_Window_SkillGroup_Controller:GetShow() == true then
    PaGlobal_SkillGroup_Controller:updateEditMode(self._isEditMode)
  end
end
function PaGlobal_SkillGroup_All:handleEventLUp_BlackSpiritSkillLock()
  if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == false then
    return
  end
  PaGlobalFunc_BlackSpiritSkillLock_All_Toggle(2)
end
function PaGlobal_SkillGroup_All:handleEventLUp_CooltimeSet()
  PaGlobal_SkillGroup_CoolTimeSlot_Toggle()
end
function PaGlobal_SkillGroup_All:setDialog(isDialog)
  if isDialog == nil then
    isDialog = false
  end
  self._isDialog = isDialog
end
function PaGlobal_SkillGroup_All:handleMOut_FrameOut()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if DragManager.groundClickFunc ~= nil and self._isEditMode == false then
    self:HandleEventLUp_EditMode()
  end
end
function PaGlobal_SkillGroup_All:handleMLUp_Frame()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if DragManager.groundClickFunc ~= nil then
    DragManager:clearInfo()
  end
end
function PaGlobal_SkillGroup_All:resetScrollPos()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self._ui._scroll_skillGroupArea_awaken:SetControlPos(0)
  self._ui._frame_skillGroupArea_awaken:UpdateContentPos()
  self._ui._scroll_skillGroupArea_main:SetControlPos(0)
  self._ui._frame_skillGroupArea_main:UpdateContentPos()
  self._ui._scroll_skillGroupArea_fusionSkill:SetControlPos(0)
  self._ui._frame_fusionSkill:UpdateContentPos()
end
function PaGlobal_SkillGroup_All:showOtherClassSkill(classType)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._classType == classType then
    return
  end
  self._classType = classType
  self._isReverseSkillType = PaGlobalFunc_Util_IsSuccessionFirstLearnClassType(self._classType)
  if self._isDialog == true then
    self._ui._chk_playShow:SetCheck(true)
    self._isWindow = not self._ui._chk_playShow:IsCheck()
  else
    self._isWindow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSkillGroupWindowViewPlayPanel)
  end
  self._selectedTab = self._eTabType._mainWeapon
  self:defaultPanelResize()
  self:makeUIDataDefault()
  self:update()
  self:updateViewController()
  self:resetScrollPos()
  if self:checkMyClassType() == true then
    self._ui._combo_skillSetting:SetIgnore(false)
    self._ui._stc_presetBG:SetShow(true)
    self._ui._btn_allReset:SetShow(true)
    self._ui._stc_skillPoint:SetSize(self._originSkillPointSizeX, self._ui._stc_skillPoint:GetSizeY())
    self._ui._txt_skillPointValue:SetPosX(self._originSkillPointValuePosX)
  else
    self._ui._combo_skillSetting:SetIgnore(true)
    self._ui._stc_presetBG:SetShow(false)
    self._ui._btn_allReset:SetShow(false)
    self._ui._stc_skillPoint:SetSize(self._originSkillPointSizeX + self._ui._btn_allReset:GetSizeX() + 10, self._ui._stc_skillPoint:GetSizeY())
    self._ui._txt_skillPointValue:SetPosX(self._originSkillPointValuePosX + self._ui._btn_allReset:GetSizeX() + 10)
  end
  if self._isPadSnapping == true and self._skillSubGroupPool_main[1] ~= nil then
    ToClient_padSnapChangeToTarget(self._skillSubGroupPool_main[1]._control)
  end
end
local editText = ""
function PaGlobal_SkillGroup_All:handleEventLUp_SearchText()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if PaGlobalFunc_SkillGroup_All_KeyBoardTabEvent() == true then
    return
  end
  if self._ui._edit_search:GetFocusEdit() == false and (GetFocusEdit() ~= nil or GlobalKeyBinder_CheckKeyPressed(CppEnums.VirtualKeyCode.KeyCode_RETURN) == false) then
    self._ui._edit_search:SetEditText("")
  end
  SetFocusEdit(self._ui._edit_search)
  if editText ~= self._ui._edit_search:GetEditText() then
    editText = self._ui._edit_search:GetEditText()
    self._filterText = nil
    self._filterIndex = -1
    self._filterFusionIndex = -1
    self._filterFusionSkillIndex = 0
  end
end
function PaGlobal_SkillGroup_All:handleEventLUp_SearchButton()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if CheckChattingInput() == false then
    ClearFocusEdit()
  end
  self._filterText = self._ui._edit_search:GetEditText()
  if self._filterText ~= nil and self._filterText:len() ~= 0 then
    if self:searchSkill() == false then
      self._filterText = nil
      self._filterIndex = -1
      self._filterFusionIndex = -1
      self._filterFusionSkillIndex = 0
      if self._focusEffect ~= nil then
        self._focusEffect:EraseAllEffect()
      end
    end
  else
    self._filterText = nil
    self._filterIndex = -1
    self._filterFusionIndex = -1
    self._filterFusionSkillIndex = 0
  end
end
function PaGlobal_SkillGroup_All:searchSkill()
  if Panel_Window_SkillGroup_All == nil then
    return false
  end
  for index = 0, #self._searchSkillGroupInfo do
    local skillGroupInfo = self._searchSkillGroupInfo[index]
    if index > self._filterIndex and stringSearch(skillGroupInfo._name, self._filterText) == true then
      self._filterIndex = index
      self:skillFocusEffect(1, skillGroupInfo, 1)
      return true
    end
  end
  local fusionIndex = 0
  for index = 0, #self._searchFusionSkillInfo do
    local fusionSkillInfo = self._searchFusionSkillInfo[index]
    if index > self._filterFusionIndex then
      local findFusionSkill = false
      if 1 > self._filterFusionSkillIndex and stringSearch(fusionSkillInfo._result1SkillName, self._filterText) == true then
        self._filterFusionSkillIndex = 1
        findFusionSkill = true
      elseif self._filterFusionSkillIndex < 2 and stringSearch(fusionSkillInfo._result2SkillName, self._filterText) == true then
        self._filterFusionSkillIndex = 2
        findFusionSkill = true
      end
      if findFusionSkill == true then
        self._filterFusionIndex = index
        self:skillFocusEffect(2, fusionSkillInfo, 1, self._filterFusionSkillIndex)
        return true
      end
      self._filterFusionSkillIndex = 0
    end
  end
  return false
end
function PaGlobal_SkillGroup_All:skillFocusEffect(skillType, skillInfo, effectType, fusionSkillIndex)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if skillType == nil or skillInfo == nil or effectType == nil then
    return
  end
  if self._focusEffect ~= nil then
    self._focusEffect:EraseAllEffect()
  end
  if skillType == 1 then
    local skillGroupInfo = skillInfo
    local subGroupKey = tostring(skillGroupInfo._skillGroupType) .. "," .. tostring(skillGroupInfo._subGroupNo)
    local skillSubGroupInfo = self._skillSubGroupInfo[subGroupKey]
    if skillSubGroupInfo ~= nil and skillSubGroupInfo._control ~= nil and skillSubGroupInfo._control:IsCheck() == true then
      skillSubGroupInfo._control:SetCheck(false)
      self:updateDefaultSkillAreaPosition(subGroupKey)
    end
    if skillGroupInfo._skillGroupType == __eSkillGroupType_Awakening then
      self:selectTab(self._eTabType._awaken)
      local contentUseSize = self._ui._frame_skillGroupArea_awaken:GetFrameContent():GetSizeY() - self._ui._frame_skillGroupArea_awaken:GetSizeY()
      local posPercents = (skillGroupInfo._control:GetPosY() - self._ui._frame_skillGroupArea_awaken:GetSizeY() / 2) / contentUseSize
      self._ui._scroll_skillGroupArea_awaken:SetControlPos(math.max(math.min(posPercents, 1), 0))
      self._ui._frame_skillGroupArea_awaken:UpdateContentPos()
    else
      self:selectTab(self._eTabType._mainWeapon)
      local contentUseSize = self._ui._frame_skillGroupArea_main:GetFrameContent():GetSizeY() - self._ui._frame_skillGroupArea_main:GetSizeY()
      local posPercents = (skillGroupInfo._control:GetPosY() - self._ui._frame_skillGroupArea_main:GetSizeY() / 2) / contentUseSize
      self._ui._scroll_skillGroupArea_main:SetControlPos(math.max(math.min(posPercents, 1), 0))
      self._ui._frame_skillGroupArea_main:UpdateContentPos()
    end
    skillInfo._control:GetPosY()
    self._focusEffect = skillGroupInfo._control
  elseif skillType == 2 then
    if fusionSkillIndex == nil then
      return
    end
    local fusionSkillInfo = skillInfo
    self:selectTab(self._eTabType._fusion)
    if fusionSkillIndex == 1 then
      self._focusEffect = fusionSkillInfo._resultControl1
    elseif fusionSkillIndex == 2 then
      self._focusEffect = fusionSkillInfo._resultControl2
    end
    if 2 <= fusionSkillInfo._index then
      self._ui._scroll_skillGroupArea_fusionSkill:SetControlPos(1)
    else
      self._ui._scroll_skillGroupArea_fusionSkill:SetControlPos(0)
    end
    self._ui._frame_fusionSkill:UpdateContentPos()
  else
    return
  end
  if effectType == 0 then
    self._focusEffect:AddEffect("fUI_NewSkill_Guide_01B", true, 0, 0)
  elseif effectType == 1 then
    self._focusEffect:AddEffect("fUI_NewSkill_Guide_01A", true, 0, 0)
  end
  if self._isPadSnapping == true then
    ToClient_padSnapChangeToTarget(self._focusEffect)
  end
end
function PaGlobal_SkillGroup_All:selectPrevTab()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local index = self._selectedTab - 1
  if index < 0 then
    index = self._eTabType._upgrade
  end
  if self._tabList[index]:GetShow() == false then
    self._selectedTab = index
    self:selectPrevTab()
  else
    self:selectTab(index)
  end
end
function PaGlobal_SkillGroup_All:selectNextTab()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local index = self._selectedTab + 1
  if index > self._eTabType._upgrade then
    index = self._eTabType._mainWeapon
  end
  if self._tabList[index]:GetShow() == false then
    self._selectedTab = index
    self:selectNextTab()
  else
    self:selectTab(index)
  end
end
function PaGlobal_SkillGroup_All:handleOnOut_MovieButton(isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._chk_playShow, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_MOVIETOOLTIP"))
end
function PaGlobal_SkillGroup_All:handleOnOut_PlaySkillButton(isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._chk_playShow, PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_PLSYSKILLSHOW_TOOLTIP_NAME"), PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_PLSYSKILLSHOW_TOOLTIP_DESC"))
end
function PaGlobal_SkillGroup_All:handleOnOut_SearchButton(isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._chk_playShow, PAGetString(Defines.StringSheet_GAME, "LUA_SKILLFILTER_DESC"))
end
function PaGlobal_SkillGroup_All:handleOnOut_FilterButton(isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._chk_playShow, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLFILTER_TITLE"), PAGetString(Defines.StringSheet_GAME, "LUA_SKILLFILTER_DESC"))
  self:alignKeyguide(1)
end
function PaGlobal_SkillGroup_All:handleOnOut_AllResetButton(isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._chk_playShow, PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MARKETPLACE_FAVORITE_ALL_RESET_BTN"))
  self:alignKeyguide(1)
end
function PaGlobal_SkillGroup_All:handleOnOff_HelpButton(isShow)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(self._ui._chk_playShow, PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_TOOLTIP_HELP_NAME"), PAGetString(Defines.StringSheet_GAME, "LUA_PLAYSKILL_TOOLTIP_HELP_DESC"))
end
function PaGlobal_SkillGroup_All:updateSkillGroupInfo(skillGroupInfo, isShowSkill)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if isShowSkill == nil then
    isShowSkill = false
  end
  for level = 1, skillGroupInfo._maxLevel do
    local currentLevelSkillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, level)
    if currentLevelSkillKey:isDefined() == true then
      local isLearn = ToClient_isLearnedSkill(currentLevelSkillKey:getSkillNo())
      if isLearn == true then
        skillGroupInfo._selectLevel = level
        skillGroupInfo._possibleMaxLevel = level
      end
    end
  end
  self._skillGroupInfo[skillGroupInfo._key] = skillGroupInfo
  if isShowSkill == true then
    self:handleEventLUp_SkillGroup(skillGroupInfo._key)
  end
end
function PaGlobal_SkillGroup_All:alignKeyguide(alignType, key, isLearnedFusionSkill, showLearnFusionSkill, isEnablePresetMemo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  if alignType == nil then
    return
  elseif alignType == 0 or alignType == 1 then
    if self._curAlignType == alignType then
      return
    end
  elseif alignType == 2 then
    if key == nil then
      return
    end
    local skillGroupInfo = self._skillGroupInfo[key]
    if skillGroupInfo == nil then
      return
    end
  elseif alignType == 3 and (isLearnedFusionSkill == nil or showLearnFusionSkill == nil) then
    return
  end
  self._curAlignType = alignType
  local keyGuides = {}
  keyGuides[1] = self._ui._keyguide_A
  keyGuides[2] = self._ui._keyguide_B
  keyGuides[3] = self._ui._keyguide_X
  keyGuides[4] = self._ui._keyguide_Y
  keyGuides[5] = self._ui._keyguide_LS
  keyGuides[6] = self._ui._keyguide_LT_A
  keyGuides[7] = self._ui._keyguide_LT_X
  keyGuides[8] = self._ui._keyguide_LT_Y
  keyGuides[9] = self._ui._keyguide_LT_DPad
  keyGuides[10] = self._ui._keyguide_RT_Y
  for i = 1, #keyGuides do
    if keyGuides[i] ~= nil then
      keyGuides[i]:SetShow(false)
    end
  end
  self._ui._keyguide_B:SetShow(true)
  self._ui._keyguide_RT_Y:SetShow(ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AbyssOne) == false)
  if alignType == 0 then
    self._curSkillShowType = self._eSkillShowTypeIndex._baseSkill
  elseif alignType == 1 then
    self._curSkillShowType = self._eSkillShowTypeIndex._baseSkill
    self._ui._keyguide_A:SetShow(true)
    self._ui._keyguide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
  elseif alignType == 2 then
    local skillGroupInfo = self._skillGroupInfo[key]
    local level = skillGroupInfo._selectLevel
    local maxLevel = skillGroupInfo._maxLevel
    local skillKey = ToClient_getSkillKeyBySkillGroupNo(skillGroupInfo._key, level)
    local skillNo = skillKey:getSkillNo()
    local skillLevelInfo = getSkillLevelInfo(skillNo)
    local skillTypeSSW = getSkillTypeStaticStatus(skillNo)
    local skillStatic = getSkillStaticStatus(skillNo, 1)
    if skillLevelInfo ~= nil and skillTypeSSW ~= nil then
      local skillType = skillTypeSSW:requiredEquipType()
      isSkillTypeShuriken = 55 == skillType or 56 == skillType
      if skillTypeSSW:isSkillCommandCheck() == true and level >= 1 and skillLevelInfo._learnable == false and skillLevelInfo._usable == true then
        self._ui._keyguide_LS:SetShow(true)
      end
    end
    if skillStatic ~= nil then
      if skillStatic:isAutoLearnSkillByLevel() == false then
        local isBaseLearnSkill = false
        local skilsSS = skillStatic:get()
        if skilsSS == nil or skilsSS._needSkillPointForLearning == 0 then
          isBaseLearnSkill = true
        end
        if level > 1 or isBaseLearnSkill == false and ToClient_isLearnedSkill(skillNo) == true then
          self._ui._keyguide_Y:SetShow(true)
          if maxLevel > 1 and level >= 2 then
            self._ui._keyguide_LT_Y:SetShow(true)
          end
        end
      end
      local isBlackSpiritSkill = false
      local blackSkillNo = skillStatic:getlinkBlackSkillNo()
      local blackSkillTypeSS = getSkillTypeStaticStatus(blackSkillNo)
      if blackSkillTypeSS ~= nil and blackSkillTypeSS:isValidLocalizing() == true then
        local blackSkillStatic = getSkillStaticStatus(blackSkillNo, 1)
        if blackSkillStatic ~= nil then
          self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PLAY_BLACKSKILL"))
          self._ui._keyguide_LT_X:SetShow(true)
        end
      end
      local isSuccessionSkill = false
      local linkSkillNo = skillStatic:getLinkTooltipSkillNo()
      local linkSkillTypeSS = getSkillTypeStaticStatus(linkSkillNo)
      if linkSkillTypeSS ~= nil and linkSkillTypeSS:isValidLocalizing() == true then
        local linkSkillStatic = getSkillStaticStatus(linkSkillNo, 1)
        if linkSkillStatic ~= nil then
          self._ui._keyGuide_LT_X_sub:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLGROUP_SHOWSUCCESSIONSKILLDESC"))
          self._ui._keyguide_LT_X:SetShow(true)
        end
      end
    end
    local learnSkillKeyGuideString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_SELECTSKILL")
    if skillGroupInfo._learnPlusEffect:GetShow() == true then
      isCanLearn = true
      if maxLevel > 1 and level + 1 ~= maxLevel and isSkillTypeShuriken == false then
        self._ui._keyguide_LT_A:SetShow(true)
      end
      learnSkillKeyGuideString = learnSkillKeyGuideString .. " / " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SKILL_MOUSE_GUIDE_L")
    end
    if skillGroupInfo._btn_next:GetShow() == true then
      self._ui._keyguide_LT_DPad:SetShow(true)
    end
    self._ui._keyguide_A:SetText(learnSkillKeyGuideString)
    self._ui._keyguide_A:SetShow(true)
  elseif alignType == 3 then
    self._ui._keyguide_A:SetShow(true)
    local keyGuideString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_SELECTSKILL")
    if isLearnedFusionSkill == true then
      self._ui._keyguide_Y:SetShow(true)
    else
      self._ui._keyguide_Y:SetShow(false)
      if showLearnFusionSkill == true then
        keyGuideString = keyGuideString .. " / " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SKILL_MOUSE_GUIDE_L")
      end
    end
    self._ui._keyguide_A:SetText(keyGuideString)
  elseif alignType == 4 then
    self._ui._keyguide_A:SetShow(true)
    self._ui._keyguide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILLREINFORCE_SELECTSKILL"))
  elseif alignType == 5 then
    self._ui._keyguide_A:SetShow(true)
    self._ui._keyguide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SELECT"))
    if isEnablePresetMemo ~= nil and isEnablePresetMemo == true then
      self._ui._keyguide_X:SetShow(true)
    else
      self._ui._keyguide_X:SetShow(false)
    end
  end
  self._ui._keyguide_Bg:SetShow(true)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._keyguide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_TOP, nil, 0)
  local x1, y1, x2, y2 = 0, 0, 0, 0
  if alignType == 6 then
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._keyguide_RT_X, 1, 1, 45, 45)
  else
    x1, y1, x2, y2 = setTextureUV_Func(self._ui._keyguide_RT_X, 136, 1, 180, 45)
  end
  self._ui._keyguide_RT_X:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._keyguide_RT_X:setRenderTexture(self._ui._keyguide_RT_X:getBaseTexture())
end
function PaGlobal_SkillGroup_All:getLearnSkillAlert(skillLevelInfo, branchType)
  if skillLevelInfo == nil or branchType == nil then
    return ""
  end
  if branchType == __eSkillTypeParam_Inherit then
    if _ContentsGroup_Succession == false then
      return ""
    end
    if PaGlobalFunc_Util_IsSuccessionContentsOpen(self._classType) then
      return ""
    end
  end
  local needSkillString = ""
  local forbidSkillString = ""
  local resultString = ""
  local SkillStaticWrapper = getSkillStaticStatus(skillLevelInfo._needSkillNo1, 1)
  if SkillStaticWrapper ~= nil then
    if ToClient_isLearnedSkill(SkillStaticWrapper:getSkillNo() == false) then
      needSkillString = SkillStaticWrapper:getName()
    end
  end
  SkillStaticWrapper = getSkillStaticStatus(skillLevelInfo._needSkillNo2, 1)
  if SkillStaticWrapper ~= nil then
    if ToClient_isLearnedSkill(SkillStaticWrapper:getSkillNo() == false) then
      if needSkillString ~= "" then
        needSkillString = needSkillString .. ", "
      end
      needSkillString = needSkillString .. SkillStaticWrapper:getName()
    end
  end
  local index = 0
  while true do
    local skillNo = skillLevelInfo:atValue(index)
    if skillNo == 0 or index > 10 then
      break
    end
    SkillStaticWrapper = getSkillStaticStatus(skillNo, 1)
    if SkillStaticWrapper ~= nil then
      if ToClient_isLearnedSkill(SkillStaticWrapper:getSkillNo() == true) then
        local currentForbidSkillString = SkillStaticWrapper:getName()
        if currentForbidSkillString ~= "" then
          if forbidSkillString == "" then
            forbidSkillString = currentForbidSkillString
          else
            forbidSkillString = forbidSkillString .. ", " .. currentForbidSkillString
          end
        end
      end
    end
    index = index + 1
  end
  if needSkillString ~= "" then
    resultString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_01", "SkillName", needSkillString)
  end
  if forbidSkillString ~= "" then
    if resultString == "" then
      resultString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_02", "SkillName", forbidSkillString)
    else
      resultString = resultString .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_SKILLALERT_02", "SkillName", forbidSkillString)
    end
  end
  return resultString
end
function PaGlobal_SkillGroup_All:skillpresetLockToolTipShow(isShow, index)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  if index == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  title = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_DISK" .. tostring(index + 1))
  desc = PAGetString(Defines.StringSheet_GAME, "LUA_SKILLPRESET_TOOLTIP_DESC")
  control = self._btn_skillPresetLockList[index]
  TooltipSimple_Show(control, title, desc)
end
function PaGlobal_SkillGroup_All:skillGroupResize()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self:defaultPanelResize()
  if Panel_Window_SkillGroup_Controller:GetShow() == true then
    PaGlobal_SkillGroup_Controller_Resize()
  end
  PaGlobal_SkillGroup_QuickSlot_Resize()
end
function PaGlobal_SkillGroup_All:checkIsAwakenSelectSkill(skillGroupInfo)
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  local subGroupKey = tostring(skillGroupInfo._skillGroupType) .. "," .. tostring(skillGroupInfo._subGroupNo)
  local skillSubGroupInfo = self._skillSubGroupInfo[subGroupKey]
  if skillSubGroupInfo ~= nil and skillSubGroupInfo._name == PAGetString(Defines.StringSheet_GAME, "LUA_SKILLTREE_PANEL_NAME5") then
    return true
  end
  return false
end
function PaGlobal_SkillGroup_All:validate()
  if Panel_Window_SkillGroup_All == nil then
    return
  end
  self._ui._stc_skillTypeArea:isValidate()
  self._ui._rdo_successionSkill:isValidate()
  self._ui._rdo_awakenSkill:isValidate()
  self._ui._stc_successionLock:isValidate()
  self._ui._stc_awakenLock:isValidate()
  self._ui._stc_radioGroup:isValidate()
  self._ui._rdo_tab_mainWeapon:isValidate()
  self._ui._rdo_tab_awakenWeapon:isValidate()
  self._ui._rdo_tab_fusionSkill:isValidate()
  self._ui._rdo_tab_upgradeSkill:isValidate()
  self._ui._stc_topFunctionArea:isValidate()
  self._ui._edit_search:isValidate()
  self._ui._btn_search:isValidate()
  self._ui._stc_skillPoint:isValidate()
  self._ui._btn_allReset:isValidate()
  self._ui._btn_skillSet:isValidate()
  self._ui._btn_filter:isValidate()
  self._ui._stc_mainWeaponSkillArea:isValidate()
  self._ui._frame_skillGroupArea_main:isValidate()
  self._ui._stc_awakenSkillArea:isValidate()
  self._ui._frame_skillGroupArea_awaken:isValidate()
  self._ui._stc_fusionSkillArea:isValidate()
  self._ui._frame_fusionSkill:isValidate()
  self._ui._stc_upgradeSkillArea:isValidate()
  self._ui._list2_upgradeList:isValidate()
  self._ui._btn_naviSkillMaster:isValidate()
  self._ui._stc_bottomArea:isValidate()
  self._ui._btn_movie:isValidate()
  self._ui._btn_showOtherCharSkill:isValidate()
  self._ui._combo_skillSetting:isValidate()
  self._ui._chk_playShow:isValidate()
  self._ui._stc_presetBG:isValidate()
  self._ui._rdo_preset_templete:isValidate()
  self._ui._btn_lock_templete:isValidate()
  self._ui._btn_presetSave:isValidate()
  self._ui._stc_shiftGuideMain:isValidate()
  self._ui._btn_shiftGuideClose:isValidate()
  self._ui._stc_templete_skillGroup:isValidate()
  self._ui._rdo_templete_skillSubGroup:isValidate()
  self._ui._stc_templete_lineControl:isValidate()
  self._ui._stc_templete_fusionSkill:isValidate()
  self._ui._stc_templete_fusionSkillResult:isValidate()
end
