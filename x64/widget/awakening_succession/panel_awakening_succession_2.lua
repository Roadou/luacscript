function FromClient_AwakeningSuccession_OnClearQuest(questNo)
  local panel = Panel_Widget_Awakening_Succession_Select_All
  if nil == panel then
    return
  end
  local self = PaGlobal_AwakeningSuccession
  if nil == self then
    return
  end
  local condition = ToClient_checkConditionPopUpSkillSelectUI(questNo)
  if false == condition then
    return
  end
  self:prepareOpen()
end
function FromClient_AwakeningSuccession_ClearSkills()
  local panel = Panel_Widget_Awakening_Succession_Select_All
  if nil == panel then
    return
  end
  if false == panel:GetShow() then
    return
  end
  local self = PaGlobal_AwakeningSuccession
  if nil == self then
    return
  end
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_RESETSUCCESS"))
  self:requestLeanRootSkill()
end
function PaGlobalFunc_AwakeningSuccession_OnClieckRadioButton()
  local panel = Panel_Widget_Awakening_Succession_Select_All
  if nil == panel then
    return
  end
  local self = PaGlobal_AwakeningSuccession
  if nil == self then
    return
  end
  self:updateSelectedInfo()
end
function PaGlobalFunc_AwakeningSuccession_OnClieckConfirmButton()
  local panel = Panel_Widget_Awakening_Succession_Select_All
  if nil == panel then
    return
  end
  local self = PaGlobal_AwakeningSuccession
  if nil == self then
    return
  end
  if true == self._processInfo._isWatingClearSkillResult then
    return
  end
  local isCheckAwaken = self._ui._btn_left_awakening:IsCheck()
  local isCheckSuccession = self._ui._btn_right_succession:IsCheck()
  if isCheckAwaken == isCheckSuccession then
    return
  end
  local skillPointInfo = ToClient_getSkillPointInfo(0)
  if nil == skillPointInfo then
    return
  end
  local isNeedClearSkillPoint = skillPointInfo._remainPoint ~= skillPointInfo._acquirePoint
  local currentType = ToClient_GetCurrentPlayerSkillType()
  local doLearnRootSkill = false
  local doResetSkill = false
  local requestSkillType
  if true == isCheckAwaken then
    if true == isNeedClearSkillPoint then
      if currentType ~= __eSkillTypeParam_Awaken then
        doResetSkill = true
        requestSkillType = __eSkillTypeParam_Awaken
      end
    elseif currentType ~= __eSkillTypeParam_Awaken then
      doLearnRootSkill = true
      requestSkillType = __eSkillTypeParam_Awaken
    end
  elseif true == isNeedClearSkillPoint then
    if currentType ~= __eSkillTypeParam_Inherit then
      doResetSkill = true
      requestSkillType = __eSkillTypeParam_Inherit
    end
  elseif currentType ~= __eSkillTypeParam_Inherit then
    doLearnRootSkill = true
    requestSkillType = __eSkillTypeParam_Inherit
  end
  if true == doResetSkill or true == doLearnRootSkill then
    local function resetSkill()
      if true == doResetSkill then
        if PaGlobal_SkillGroup ~= nil then
          local selectedParam = PaGlobal_SkillGroup._selectedTree
          PaGlobal_SkillGroup._isChangingTree = selectedParam
        end
        if PaGlobal_SkillGroup_All ~= nil then
          if PaGlobal_SkillGroup_All._selectedSkillType == __eSkillTypeParam_Inherit then
            PaGlobal_SkillGroup_All._targetSkillType = __eSkillTypeParam_Awaken
          else
            PaGlobal_SkillGroup_All._targetSkillType = __eSkillTypeParam_Inherit
          end
        end
        local isSuccessRequest = ToClient_SkillWindow_ClearSkill(false)
        if true == isSuccessRequest then
          self._processInfo._isWatingClearSkillResult = true
          self._processInfo._requestSkillType = requestSkillType
        end
      else
        self._processInfo._isWatingClearSkillResult = true
        self._processInfo._requestSkillType = requestSkillType
        self:requestLeanRootSkill()
      end
    end
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = "",
      functionYes = resetSkill,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    if __eSkillTypeParam_Inherit == requestSkillType then
      messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHER_SELECT", "type", PAGetString(Defines.StringSheet_GAME, "LUA_SUCCESSION"))
    elseif __eSkillTypeParam_Awaken == requestSkillType then
      messageBoxData.content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHER_SELECT", "type", PAGetString(Defines.StringSheet_GAME, "LUA_AWAKEN"))
    end
    MessageBox.showMessageBox(messageBoxData)
  else
    local function closePanel()
      self:prepareClose()
    end
    local messageBoxData = {
      content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AWAKENING_SUCCESSION_DONE"),
      functionYes = closePanel,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
