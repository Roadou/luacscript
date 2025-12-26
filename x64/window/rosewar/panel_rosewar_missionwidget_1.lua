function PaGlobal_RoseWarMissionWidget:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_progressMissionArea = UI.getChildControl(Panel_RoseWar_MissionWidget, "Static_ProgressQuestBg")
  self._ui._stc_typeIcon = UI.getChildControl(self._ui._stc_progressMissionArea, "Static_TypeIcon")
  self._ui._stc_missionName = UI.getChildControl(self._ui._stc_progressMissionArea, "StaticText_QuestName")
  self._ui._stc_remainTimeIcon = UI.getChildControl(self._ui._stc_progressMissionArea, "Static_RemainTimeIcon")
  self._ui._txt_remainTime = UI.getChildControl(self._ui._stc_progressMissionArea, "StaticText_RemainTime")
  self._ui._btn_navi = UI.getChildControl(self._ui._stc_progressMissionArea, "Button_Navi")
  self._ui._stc_result_complete = UI.getChildControl(Panel_RoseWar_MissionWidget, "StaticText_Result_Complete")
  self._ui._stc_result_fail = UI.getChildControl(Panel_RoseWar_MissionWidget, "StaticText_Result_Fail")
  self:registEventHandler()
  self:validate()
  if ToClient_IsParticipateInRoseWar() == true then
    FromClient_RoseWarMissionWidget_ChangeRoseWarState(ToClient_GetRoseWarState())
    FromClient_RoseWarMissionWidget_CreateMission(ToClient_GetCurrentProgressRoseWarMissionKey())
  end
  self._initialize = true
end
function PaGlobal_RoseWarMissionWidget:registEventHandler()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarMissionWidget_ChangeRoseWarState")
  registerEvent("FromClient_ReceivedNewRoseWarMission", "FromClient_RoseWarMissionWidget_CreateMission")
  registerEvent("FromClient_CompleteRoseWarMission", "FromClient_RoseWarMissionWidget_CompleteMission")
  registerEvent("FromClient_FailedRoseWarMission", "FromClient_RoseWarMissionWidget_FailedMission")
  registerEvent("FromClient_UpdateConditionRoseWarMission", "FromClient_RoseWarMissionWidget_UpdateMissionCondition")
  registerEvent("FromClient_UpdateRoseWarTeamNo", "FromClient_RoseWarMissionWidget_UpdateSelfPlayerRoseWarState")
  registerEvent("FromClient_UpdateRoseWarMemberGradeType", "FromClient_RoseWarMissionWidget_UpdateSelfPlayerRoseWarState")
  registerEvent("onScreenResize", "FromClient_RoseWarMissionWidget_OnScreenResize")
end
function PaGlobal_RoseWarMissionWidget:validate()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self._ui._stc_progressMissionArea:isValidate()
  self._ui._stc_typeIcon:isValidate()
  self._ui._stc_missionName:isValidate()
  self._ui._stc_remainTimeIcon:isValidate()
  self._ui._txt_remainTime:isValidate()
  self._ui._btn_navi:isValidate()
  self._ui._stc_result_complete:isValidate()
  self._ui._stc_result_fail:isValidate()
end
function PaGlobal_RoseWarMissionWidget:onScreenResize()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if Panel_RoseWar_ScoreBoardWidget ~= nil then
    local scoreBoardPosY = Panel_RoseWar_ScoreBoardWidget:GetPosY()
    local scoreBoardSizeY = Panel_RoseWar_ScoreBoardWidget:GetSizeY()
    Panel_RoseWar_MissionWidget:SetPosX(getScreenSizeX() - Panel_RoseWar_MissionWidget:GetSizeX() - 10)
    Panel_RoseWar_MissionWidget:SetPosY(scoreBoardPosY + scoreBoardSizeY + 10)
  end
end
function PaGlobal_RoseWarMissionWidget:prepareOpen()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self:updateMission()
  self:onScreenResize()
  self:hideQuestWidget(true)
  self:open()
end
function PaGlobal_RoseWarMissionWidget:open()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  Panel_RoseWar_MissionWidget:RegisterUpdateFunc("PaGlobalFunc_RoseWarMissionWidget_Update")
  Panel_RoseWar_MissionWidget:SetShow(true)
end
function PaGlobal_RoseWarMissionWidget:prepareClose()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self:hideResult()
  self:clearMission()
  self:hideQuestWidget(false)
  self:close()
end
function PaGlobal_RoseWarMissionWidget:close()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  Panel_RoseWar_MissionWidget:ClearUpdateLuaFunc()
  Panel_RoseWar_MissionWidget:SetShow(false)
end
function PaGlobal_RoseWarMissionWidget:updateTimer(deltaTime)
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if self._currentProgressMissionKey == nil then
    return
  end
  local missionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(self._currentProgressMissionKey)
  if missionDataWrapper == nil then
    return
  end
  local missionExpiration = missionDataWrapper:getExpirationDate()
  if missionExpiration == nil or missionExpiration:isDefined() == false then
    return
  end
  local s64_remainTime = getLeftSecond_s64(missionExpiration)
  self._remainTime = Int64toInt32(s64_remainTime)
  local minute = 0
  local second = 0
  if self._remainTime < 0 then
    minute = 0
    second = 0
  else
    minute = math.floor(self._remainTime / 60)
    second = math.floor(self._remainTime - minute * 60)
  end
  local minuteString = ""
  if minute < 10 then
    minuteString = "0" .. tostring(minute)
  else
    minuteString = tostring(minute)
  end
  local secondString = ""
  if second < 10 then
    secondString = "0" .. tostring(second)
  else
    secondString = tostring(second)
  end
  self._ui._txt_remainTime:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_TIME", "hour", minuteString, "minute", secondString))
end
function PaGlobal_RoseWarMissionWidget:updateMission()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if self._currentProgressMissionKey == nil then
    self:clearMission()
  else
    local missionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(self._currentProgressMissionKey)
    if missionDataWrapper == nil then
      self:clearMission()
      return
    end
    local useNaviGuideBtn = false
    local missionNameString, typeIconTextureId
    local missionType = missionDataWrapper:getMissionType()
    if missionType == __eRoseWarMissionType_FierceAttack then
      local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
      if targetFierceBattleObjectWrapper == nil then
        UI.ASSERT_NAME(false, "\236\132\177\236\134\140 \236\160\144\235\160\185 \236\158\132\235\172\180\236\157\184\235\141\176 \235\140\128\236\131\129 \236\132\177\236\134\140 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164!!", "\236\157\180\236\163\188")
        return
      end
      useNaviGuideBtn = true
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_ATTACK", "SPOT", targetFierceBattleObjectWrapper:getName())
      typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
    elseif missionType == __eRoseWarMissionType_FierceDefence then
      local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
      if targetFierceBattleObjectWrapper == nil then
        UI.ASSERT_NAME(false, "\236\132\177\236\134\140 \235\176\169\236\150\180 \236\158\132\235\172\180\236\157\184\235\141\176 \235\140\128\236\131\129 \236\132\177\236\134\140 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164!!", "\236\157\180\236\163\188")
        return
      end
      useNaviGuideBtn = true
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_DEFENSE", "SPOT", targetFierceBattleObjectWrapper:getName())
      typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Blue"
    elseif missionType == __eRoseWarMissionType_Kill then
      useNaviGuideBtn = false
      missionNameString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_KILL", "current", missionDataWrapper:getCondition(), "max", missionDataWrapper:getMaxCondition())
      typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Kill"
    elseif missionType == __eRoseWarMissionType_CastleAttack then
      useNaviGuideBtn = true
      missionNameString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_ATTACK")
      typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
    elseif missionType == __eRoseWarMissionType_CastleDefence then
      useNaviGuideBtn = true
      missionNameString = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_OFFICER_DEFENSE")
      typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Blue"
    elseif missionType == __eRoseWarMissionType_GimmikAttack then
      local targetFierceBattleObjectWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(missionDataWrapper:getTargetFierceBattleKeyRaw())
      if targetFierceBattleObjectWrapper == nil then
        UI.ASSERT_NAME(false, "\236\132\177\236\134\140 \236\160\144\235\160\185 \236\158\132\235\172\180\236\157\184\235\141\176 \235\140\128\236\131\129 \236\132\177\236\134\140 \236\160\149\235\179\180\234\176\128 \236\151\134\235\139\164!!", "\236\157\180\236\163\188")
        return
      end
      useNaviGuideBtn = true
      missionNameString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_ACTIVE", "SPOT", targetFierceBattleObjectWrapper:getName())
      typeIconTextureId = "Combine_Etc_RoseWar_Command_Wight_Mission_Red"
    else
      UI.ASSERT_NAME(false, "\236\158\132\235\172\180 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    end
    if typeIconTextureId ~= nil then
      self._ui._stc_typeIcon:ChangeTextureInfoTextureIDAsync(typeIconTextureId)
      self._ui._stc_typeIcon:setRenderTexture(self._ui._stc_typeIcon:getBaseTexture())
      self._ui._stc_typeIcon:SetShow(true)
    else
      self._ui._stc_typeIcon:SetShow(false)
    end
    self._ui._stc_missionName:SetText(missionNameString)
    self._ui._stc_remainTimeIcon:SetShow(true)
    self._ui._txt_remainTime:SetShow(true)
    self:updateTimer(0)
    if useNaviGuideBtn == true then
      self._ui._btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_RoseWarMissionWidget_FindNavi()")
      self._ui._btn_navi:SetShow(true)
    else
      self._ui._btn_navi:SetShow(false)
    end
  end
end
function PaGlobal_RoseWarMissionWidget:updateCondition()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if self._currentProgressMissionKey == nil then
    return
  end
  local missionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(self._currentProgressMissionKey)
  if missionDataWrapper == nil then
    return
  end
  local missionType = missionDataWrapper:getMissionType()
  if missionType ~= __eRoseWarMissionType_Kill then
    return
  end
  local missionNameString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_KILL", "current", missionDataWrapper:getCondition(), "max", missionDataWrapper:getMaxCondition())
  self._ui._stc_missionName:SetText(missionNameString)
end
function PaGlobal_RoseWarMissionWidget:clearMission()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self._ui._stc_typeIcon:SetShow(false)
  self._ui._stc_remainTimeIcon:SetShow(false)
  self._ui._txt_remainTime:SetShow(false)
  self._ui._btn_navi:SetShow(false)
  self._ui._stc_missionName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_MISSIONWIDGET_NONE"))
end
function PaGlobal_RoseWarMissionWidget:setProgressMission(missionKey)
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  local missionDataWrapper = ToClient_GetRoseWarMissionDataWrapper(missionKey)
  if missionDataWrapper == nil then
    return
  end
  self._currentProgressMissionKey = missionKey
  self:updateMission()
  HandleEventLUp_RoseWarMissionWidget_FindNavi()
end
function PaGlobal_RoseWarMissionWidget:missionComplete()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self._currentProgressMissionKey = nil
  self:updateMission()
end
function PaGlobal_RoseWarMissionWidget:missionFail()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self._currentProgressMissionKey = nil
  self:updateMission()
end
function PaGlobal_RoseWarMissionWidget:updateResultTimer(deltaTime)
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if self._checkResultShowTime == false then
    return
  end
  self._showResultTimeSec = self._showResultTimeSec + deltaTime
  if self._showResultTimeSecMax <= self._showResultTimeSec then
    self:hideResult()
  end
end
function PaGlobal_RoseWarMissionWidget:showResult(resultType)
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if resultType == self._eResultType.COMPLTE then
    audioPostEvent_SystemUi(35, 13)
    _AudioPostEvent_SystemUiForXBOX(35, 13)
    audioPostEvent_SystemUi(36, 51)
    _AudioPostEvent_SystemUiForXBOX(36, 51)
    self._ui._stc_result_complete:AddEffect("fUI_RoseWar_Quest_Success_01A", false, 0, 0)
    self._ui._stc_result_complete:SetShow(true)
    self._ui._stc_result_fail:SetShow(false)
  elseif resultType == self._eResultType.FAIL then
    audioPostEvent_SystemUi(35, 12)
    _AudioPostEvent_SystemUiForXBOX(35, 12)
    audioPostEvent_SystemUi(36, 52)
    _AudioPostEvent_SystemUiForXBOX(36, 52)
    self._ui._stc_result_complete:SetShow(false)
    self._ui._stc_result_fail:AddEffect("fUI_RoseWar_Quest_Fail_01A", false, 0, 0)
    self._ui._stc_result_fail:SetShow(true)
  else
    return
  end
  self._checkResultShowTime = true
  self._showResultTimeSec = 0
end
function PaGlobal_RoseWarMissionWidget:hideResult()
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  self._ui._stc_result_complete:SetShow(false)
  self._ui._stc_result_fail:SetShow(false)
  self._checkResultShowTime = false
  self._showResultTimeSec = 0
end
function PaGlobal_RoseWarMissionWidget:hideQuestWidget(isHide)
  if Panel_RoseWar_MissionWidget == nil then
    return
  end
  if Panel_MainQuest ~= nil then
    Panel_MainQuest:SetIgnoreRenderAndEvent(isHide)
  end
  if Panel_CheckedQuest ~= nil then
    Panel_CheckedQuest:SetIgnoreRenderAndEvent(isHide)
  end
end
