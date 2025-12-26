function PaGlobalFunc_PaGlobal_SkillReinforce_All_Open()
  PaGlobal_SkillReinforce_All:prepareOpen()
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_Close()
  PaGlobal_SkillReinforce_All:prepareClose()
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_Exit()
  if true == PaGlobal_SkillReinforce_All._ui.stc_SelectSkillMain:GetShow() then
    PaGlobal_SkillReinforce_All._ui.stc_SelectSkillMain:SetShow(false)
    PaGlobal_SkillReinforce_All:setSpan(true)
    Panel_SkillTooltip_Hide()
    TooltipSimple_Hide()
    return
  end
  if true == PaGlobal_SkillReinforce_All._ui.stc_SelectEffectMain:GetShow() then
    PaGlobal_SkillReinforce_All._ui.stc_SelectEffectMain:SetShow(false)
    PaGlobal_SkillReinforce_All:setSpan(true)
    Panel_SkillTooltip_Hide()
    TooltipSimple_Hide()
    return
  end
  PaGlobal_SkillReinforce_All:prepareClose()
  if Panel_Npc_Dialog_All ~= nil and Panel_Npc_Dialog_All:GetShow() == true then
    PaGlobalFunc_PaGlobal_ReinforceSkill_All_Open()
  end
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_CloseSkillMain()
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All._ui.stc_SelectSkillMain:SetShow(false)
  PaGlobal_SkillReinforce_All:setSpan(true)
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_CloseEffectMain()
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All._ui.stc_SelectEffectMain:SetShow(false)
  PaGlobal_SkillReinforce_All:setSpan(true)
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_SetSkill(skillNo, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:setSkill(skillNo, index)
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_SetOption(isFirst, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:setOption(isFirst, index)
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_SkillList_Show()
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:skillList_Show()
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_OptionList_Show(_isFirst)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:optionList_Show(_isFirst)
end
function HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(isShow, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:limitTextOptionListTooltip(isShow, index)
end
function HandleEventLUp_PaGlobal_SkillReinforce_All_ReinforceDo(isAddOption)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:doReinforce(isAddOption)
end
function HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(selectButtonType, skillNo, isAwakenSet, optionIndex)
  PaGlobal_SkillReinforce_All:setCurrentButtonData(selectButtonType, skillNo, isAwakenSet, optionIndex)
end
function HandleEventLUp_SkillReinforce_All_ToggleSkipAni()
  if Panel_SkillReinforce_All == nil then
    return
  end
  local control = PaGlobal_SkillReinforce_All._ui.btn_SkipAni
  if control == nil then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eSkillReinforceAnimSkip, control:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_SetSkillToolTip(skillNo, isAwakenSet)
  if nil ~= Panel_SkillTooltip_GetShow and true == Panel_SkillTooltip_GetShow() then
    Panel_SkillTooltip_Hide()
  else
    if nil == skillNo or nil == isAwakenSet then
      Panel_SkillTooltip_Hide()
      return
    end
    local skillAwakenSet = "SkillAwakenSet"
    if false == isAwakenSet then
      skillAwakenSet = "SkillAwaken"
    end
    Panel_SkillTooltip_Show(skillNo, false, skillAwakenSet)
  end
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_SetOptionToolTip(optionIndex)
  if nil == optionIndex then
    HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)
  else
    HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(true, optionIndex)
  end
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_EffectGo(deltaTime)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:skillReinforceEffectGo(deltaTime)
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_CreateSkillContent(content, key)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:createSkillControl(content, key)
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_CreateOptionContent(content, key)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:createOptionControl(content, key)
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_Change(skillType, skillNo, skillIndex, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:change(skillType, skillNo, skillIndex, index, false)
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_Show(skillType, skillNo, skillIndex, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:show(skillType, skillNo, skillIndex, index, false)
end
function PaGlobalFunc_PaGlobal_SkillReinforce_All_NewShow(skillType, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  PaGlobal_SkillReinforce_All:show(skillType, nil, nil, index, false)
end
function FromClient_SuccessSkillReinforceAll(skillNo, level)
  if not ToClient_IsContentsGroupOpen("203") then
    return
  end
  if nil == Panel_SkillReinforce_All then
    return
  end
  if Panel_Window_SkillGroup ~= nil and Panel_Window_SkillGroup:GetShow() == true then
    return
  end
  if Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
    return
  end
  if PaGlobal_SkillReinforce_All._isAddOption == true then
    audioPostEvent_SystemUi(3, 3)
    _AudioPostEvent_SystemUiForXBOX(3, 3)
  end
  PaGlobalFunc_PaGlobal_ReinforceSkill_All_Open()
  PaGlobal_ReinforceSkill_All_SetEffect(PaGlobal_SkillReinforce_All._type, PaGlobal_SkillReinforce_All._inSkillIndex)
  if nil ~= Panel_Npc_Dialog and true == Panel_Npc_Dialog:GetShow() then
    Dialog_updateButtons()
  end
  if nil ~= Panel_Npc_Dialog_All and true == Panel_Npc_Dialog_All:GetShow() then
    PaGlobalFunc_DialogMain_All_BottomFuncBtnUpdate()
  end
end
function PaGloabl_PaGlobal_SkillReinforce_All_ShowAni()
  if nil == Panel_SkillReinforce_All then
    return
  end
  Panel_SkillReinforce_All:SetAlpha(0)
  UIAni.AlphaAnimation(1, Panel_SkillReinforce_All, 0, 0.3)
end
function PaGloabl_PaGlobal_SkillReinforce_All_HideAni()
  if nil == Panel_SkillReinforce_All then
    return
  end
  local ani1 = UIAni.AlphaAnimation(0, Panel_SkillReinforce_All, 0, 0.2)
  ani1:SetHideAtEnd(true)
end
function HandleEventLUp_PaGlobal_ShowSkillList(isMain)
  if nil == Panel_SkillReinforce_All then
    return
  end
  local posX = 0
  if true == isMain then
    PaGlobal_SkillReinforce_All._ui.list_MainSkillList:SetShow(true)
    PaGlobal_SkillReinforce_All._ui.list_AwakenSkillList:SetShow(false)
    posX = PaGlobal_SkillReinforce_All._ui.stc_RadioGroup:GetSizeX() * 0.5 - PaGlobal_SkillReinforce_All._ui.stc_SelectLine:GetSizeX() * 0.5 - PaGlobal_SkillReinforce_All._ui.btn_MainWeapon:GetSizeX() * 0.5
  else
    PaGlobal_SkillReinforce_All._ui.list_MainSkillList:SetShow(false)
    PaGlobal_SkillReinforce_All._ui.list_AwakenSkillList:SetShow(true)
    posX = PaGlobal_SkillReinforce_All._ui.stc_RadioGroup:GetSizeX() * 0.5 + PaGlobal_SkillReinforce_All._ui.btn_AwakenWeapon:GetSizeX() * 0.5 - PaGlobal_SkillReinforce_All._ui.stc_SelectLine:GetSizeX() * 0.5
  end
  PaGlobal_SkillReinforce_All._ui.stc_SelectLine:SetPosX(posX)
end
