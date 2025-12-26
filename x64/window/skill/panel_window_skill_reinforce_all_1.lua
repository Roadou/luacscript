function PaGlobal_SkillReinforce_All:initialize()
  if true == PaGlobal_SkillReinforce_All._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_TitleBg = UI.getChildControl(Panel_SkillReinforce_All, "Static_TitleArea")
  self._ui.btn_Exit = UI.getChildControl(self._ui.stc_TitleBg, "Button_Exit")
  self._ui.btn_Help = UI.getChildControl(self._ui.stc_TitleBg, "Button_Help")
  self._ui.btn_Help:SetShow(false)
  self._ui.btn_Help:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelSkillAwaken\" )")
  self._ui.stc_SkillReinforceBg = UI.getChildControl(Panel_SkillReinforce_All, "Static_SkillReinForceBG")
  self._ui.stc_SkillReinforceBg:SetShow(true)
  self._ui.stc_SkillReinforceArea = UI.getChildControl(self._ui.stc_SkillReinforceBg, "Static_ReinForceArea")
  self._ui.btn_SkipAni = UI.getChildControl(self._ui.stc_SkillReinforceArea, "CheckButton_SkipAni")
  self._ui.stc_Circle = UI.getChildControl(self._ui.stc_SkillReinforceArea, "Static_Circle")
  self._ui.stc_CircleEffect = UI.getChildControl(self._ui.stc_Circle, "Static_CircleEffect")
  self._ui.stc_CirclurProgress = UI.getChildControl(self._ui.stc_Circle, "CircularProgress_Progress")
  self._ui.stc_CircleSkillSlotBg = UI.getChildControl(self._ui.stc_Circle, "Static_SkillSlotBG")
  self._ui.stc_CircleSkillIcon = UI.getChildControl(self._ui.stc_CircleSkillSlotBg, "Static_SkillIcon")
  self._ui.stc_CircleSkillIconOff = UI.getChildControl(self._ui.stc_CircleSkillSlotBg, "Static_SkillIcon_Off")
  self._ui.stc_CircleSkillIconOff:SetShow(true)
  self._ui.stc_CircleSkillIconOn = UI.getChildControl(self._ui.stc_CircleSkillSlotBg, "Static_SkillIcon_ON")
  self._ui.stc_CircleSkillIconOn:SetShow(false)
  self._ui.btn_ReinforceBtn = UI.getChildControl(self._ui.stc_SkillReinforceArea, "Button_Reinforce_Btn")
  self._ui.stc_SkillSelectArea = UI.getChildControl(self._ui.stc_SkillReinforceBg, "Static_SkillSelectArea")
  self._ui.txt_SelectSkillTitle = UI.getChildControl(self._ui.stc_SkillSelectArea, "StaticText_SelectSkill_Title")
  self._ui.btn_SelectSkillBtn = UI.getChildControl(self._ui.stc_SkillSelectArea, "Button_SelectSkill_Btn")
  self._ui.stc_SelectSkillIcon = UI.getChildControl(self._ui.btn_SelectSkillBtn, "Static_SkillIcon")
  self._ui.txt_SelectSkillName = UI.getChildControl(self._ui.stc_SelectSkillIcon, "StaticText_SkillName")
  self._ui.txt_SelectSkillInfo = UI.getChildControl(self._ui.stc_SelectSkillIcon, "StaticText_SkillInfo")
  self._ui.txt_SelectSkillInfo:SetShow(false)
  self._ui.stc_SelectSkillPlus = UI.getChildControl(self._ui.btn_SelectSkillBtn, "Static_SelectSkill_Plus")
  self._ui.txt_SelectSkill = UI.getChildControl(self._ui.btn_SelectSkillBtn, "StaticText_SelectSkill")
  self._ui.stc_EffectSelectArea = UI.getChildControl(self._ui.stc_SkillReinforceBg, "Static_EffectSelectArea")
  self._ui.txt_SelectEffectTitle = UI.getChildControl(self._ui.stc_EffectSelectArea, "StaticText_SelectEffect_Title")
  self._ui.btn_SelectEffectbtn1 = UI.getChildControl(self._ui.stc_EffectSelectArea, "Button_SelectEffect_Btn01")
  self._ui.txt_Effect1 = UI.getChildControl(self._ui.btn_SelectEffectbtn1, "StaticText_Effect01")
  self._ui.txt_Effect1:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_SelectEffect1 = UI.getChildControl(self._ui.btn_SelectEffectbtn1, "StaticText_SelectEffect01")
  self._ui.stc_SelectPlus1 = UI.getChildControl(self._ui.btn_SelectEffectbtn1, "Static_SelectPlus01")
  self._ui.btn_SelectEffectbtn2 = UI.getChildControl(self._ui.stc_EffectSelectArea, "Button_SelectEffect_Btn02")
  self._ui.txt_Effect2 = UI.getChildControl(self._ui.btn_SelectEffectbtn2, "StaticText_Effect02")
  self._ui.txt_Effect2:SetTextMode(__eTextMode_LimitText)
  self._ui.txt_SelectEffect2 = UI.getChildControl(self._ui.btn_SelectEffectbtn2, "StaticText_SelectEffect02")
  self._ui.stc_SelectPlus2 = UI.getChildControl(self._ui.btn_SelectEffectbtn2, "Static_SelectPlus02")
  self._ui.txt_InfoArea = UI.getChildControl(self._ui.stc_EffectSelectArea, "StaticText_InfoArea")
  self._ui.stc_SelectSkillMain = UI.getChildControl(Panel_SkillReinforce_All, "Static_SelectSkill_Main")
  self._ui.stc_SelectSkillTitleArea = UI.getChildControl(self._ui.stc_SelectSkillMain, "Static_SelectSkill_TitleArea")
  self._ui.btn_SelectSkillExit = UI.getChildControl(self._ui.stc_SelectSkillTitleArea, "Button_SelectSkill_Exit")
  self._ui.btn_SelectSkillExit:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_CloseSkillMain()")
  self._ui.stc_RadioGroup = UI.getChildControl(self._ui.stc_SelectSkillMain, "Static_RadioGroup")
  self._ui.btn_MainWeapon = UI.getChildControl(self._ui.stc_RadioGroup, "RadioButton_Tab_MainWeapon")
  self._ui.btn_AwakenWeapon = UI.getChildControl(self._ui.stc_RadioGroup, "RadioButton_Tab_AwakenWeapon")
  self._ui.stc_SelectLine = UI.getChildControl(self._ui.stc_RadioGroup, "Static_SelctLine")
  self._ui.stc_SelectSkillArea = UI.getChildControl(self._ui.stc_SelectSkillMain, "Static_SelectSkillArea")
  self._ui.list_MainSkillList = UI.getChildControl(self._ui.stc_SelectSkillArea, "List2_MainSkillList")
  self._ui.list_AwakenSkillList = UI.getChildControl(self._ui.stc_SelectSkillArea, "List2_AwakenSkillList")
  self._ui.stc_SelectEffectMain = UI.getChildControl(Panel_SkillReinforce_All, "Static_SelectEffect_Main")
  self._ui.stc_SelectEffectTitle = UI.getChildControl(self._ui.stc_SelectEffectMain, "Static_SelectEffect_Title")
  self._ui.btn_SelectEffectExit = UI.getChildControl(self._ui.stc_SelectEffectTitle, "Button_SelectEffect_Exit")
  self._ui.btn_SelectEffectExit:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_CloseEffectMain()")
  self._ui.stc_SelectEffectArea = UI.getChildControl(self._ui.stc_SelectEffectMain, "Static_SelectEffectArea")
  self._ui.list_OptionList = UI.getChildControl(self._ui.stc_SelectEffectArea, "List2_EffectList")
  self._ui_console.stc_keyGuideBg = UI.getChildControl(Panel_SkillReinforce_All, "Static_ConsoleKey")
  self._ui_console.stc_keyGuideClose = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_MainExit")
  self._ui_console.stc_keyGuideSelect = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Sub_Select")
  self._ui_console.stc_keyGuideChangeSkill = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Console_ChangeSkill_Btn")
  self._ui_console.stc_keyGuideDetail = UI.getChildControl(self._ui_console.stc_keyGuideBg, "StaticText_Detail")
  self._ui.btn_Exit:SetShow(not self._isConsole)
  self._ui.btn_SelectSkillExit:SetShow(not self._isConsole)
  self._ui.btn_SelectEffectExit:SetShow(not self._isConsole)
  self._ui.btn_MainWeapon:SetCheck(true)
  self._ui.btn_AwakenWeapon:SetCheck(false)
  PaGlobal_SkillReinforce_All:validate()
  PaGlobal_SkillReinforce_All:registEventHandler()
  PaGlobal_SkillReinforce_All:optionalInit()
  PaGlobal_SkillReinforce_All._initialize = true
end
function PaGlobal_SkillReinforce_All:setSpan(_isCenter)
  if true == _isCenter then
    Panel_SkillReinforce_All:SetHorizonCenter()
    Panel_SkillReinforce_All:SetSpanSize(0, Panel_SkillReinforce_All:GetSpanSize().y)
  else
    Panel_SkillReinforce_All:SetHorizonCenter()
    Panel_SkillReinforce_All:SetSpanSize(-(self._ui.stc_SelectSkillMain:GetSizeX() / 2), Panel_SkillReinforce_All:GetSpanSize().y)
  end
  Panel_SkillReinforce_All:ComputePos()
end
function PaGlobal_SkillReinforce_All:optionalInit()
  self._ui.stc_SelectSkillMain:SetShow(false)
  self._ui.stc_SelectEffectMain:SetShow(false)
  self:setSpan(true)
  self._ui.txt_InfoArea:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_InfoArea:SetText(self._ui.txt_InfoArea:GetText())
  self._ui.txt_SelectSkill:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTSKILL_2"))
end
function PaGlobal_SkillReinforce_All:skillList_Show()
  if nil == Panel_SkillReinforce_All then
    return
  end
  self._ui.stc_SelectSkillMain:SetShow(true)
  self._ui.list_MainSkillList:getElementManager():clearKey()
  self._ui.list_AwakenSkillList:getElementManager():clearKey()
  self._ui.stc_SelectEffectMain:SetShow(false)
  self._ui.btn_SelectSkillBtn:setRenderTexture(self._ui.btn_SelectSkillBtn:getBaseTexture())
  self:setSpan(false)
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if __eSkillTypeParam_Awaken ~= playerSkillType then
    self._ui.btn_MainWeapon:SetIgnore(true)
    self._ui.btn_AwakenWeapon:SetIgnore(true)
  else
    self._ui.btn_MainWeapon:SetIgnore(false)
    self._ui.btn_AwakenWeapon:SetIgnore(false)
  end
  if nil == playerSkillType then
    return
  end
  local classType = getSelfPlayer():getClassType()
  if __eClassType_ShyWaman == classType then
    self._ui.btn_AwakenWeapon:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
  else
    self._ui.btn_AwakenWeapon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_RELEASEWEAPONE"))
  end
  local count = ToClient_GetAwakeningListCount()
  if _ContentsGroup_TotalSkillReininforce == false then
    count = PaGlobal_SkillReinforce_All:reinforcable_SkillCount(self._type)
    if __eSkillTypeParam_Inherit == self._type then
      count = count + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Normal)
    end
  end
  if 0 == count then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_NOSKILL"))
    return
  end
  if _ContentsGroup_TotalSkillReininforce == true then
    for key = 0, count - 1 do
      local skillSSW = ToClient_GetAwakeningListAt(key)
      local awakeningType = skillSSW:getSkillAwakenBranchType()
      if __eSkillTypeParam_Normal == awakeningType or __eSkillTypeParam_Inherit == awakeningType then
        self._ui.list_MainSkillList:getElementManager():pushKey(toInt64(0, key))
      else
        self._ui.list_AwakenSkillList:getElementManager():pushKey(toInt64(0, key))
      end
    end
  else
    for key = 0, count - 1 do
      self._ui.list_MainSkillList:getElementManager():pushKey(toInt64(0, key))
    end
  end
  local mainCheck = self._ui.btn_MainWeapon:IsCheck()
  if __eSkillTypeParam_Awaken == playerSkillType then
    HandleEventLUp_PaGlobal_ShowSkillList(mainCheck)
  else
    HandleEventLUp_PaGlobal_ShowSkillList(true)
  end
end
function PaGlobal_SkillReinforce_All:createSkillControl(content, key)
  local skillListBg = UI.getChildControl(content, "Button_Skill_Frame")
  local skillListIcon = UI.getChildControl(skillListBg, "Static_SelectSkill_Icon")
  local skillListName = UI.getChildControl(skillListIcon, "StaticText_SelectSkill_Name")
  local skillListInfo = UI.getChildControl(skillListIcon, "StaticText_SelectSkill_Info")
  skillListBg:setRenderTexture(skillListBg:getBaseTexture())
  local keyint32 = Int64toInt32(key)
  local skillSSW = ToClient_GetAwakeningListAt(keyint32)
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  skillNo = skillSSW:getSkillNo()
  skillListName:SetText(tostring(skillSSW:getName()))
  skillListInfo:SetText(tostring(skillTypeSSW:getDescription()))
  skillListName:SetIgnore(true)
  skillListInfo:SetIgnore(true)
  skillListIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
  if true == self._isConsole then
    skillListBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. PaGlobal_SkillReinforce_All.eSelectButtonType.skillList .. "," .. skillNo .. ",true)")
  else
    skillListIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwaken\")")
    skillListIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  end
  skillListIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SetSkill(" .. skillNo .. ", " .. keyint32 .. ")")
  skillListBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SetSkill(" .. skillNo .. ", " .. keyint32 .. ")")
end
function PaGlobal_SkillReinforce_All:show(skillType, skillNo, skillIndex, index, usingDarkMoonBuff)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local applyAwakenSkillReset = selfPlayer:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_UnlimitedSkillAwakening)
  local applyBookOfCombat = selfPlayer:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BookOfCombat)
  local inventory = selfPlayer:get():getInventory()
  local hasMemoryFlag = inventory:getItemCount_s64(ItemEnchantKey(44195, 0))
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if nil == playerSkillType then
    return
  end
  local reinforcableCount = 0
  if true == _ContentsGroup_TotalSkillReininforce then
    reinforcableCount = PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Normal)
    if __eSkillTypeParam_Awaken == skillType then
      reinforcableCount = reinforcableCount + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Awaken)
    elseif __eSkillTypeParam_Inherit == skillType then
      reinforcableCount = reinforcableCount + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Inherit)
    end
  else
    reinforcableCount = PaGlobal_SkillReinforce_All:reinforcable_SkillCount(skillType)
    if __eSkillTypeParam_Inherit == skillType then
      reinforcableCount = reinforcableCount + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Normal)
    end
  end
  if 0 == reinforcableCount and nil == skillNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_NOSKILL"))
    return
  end
  local isAwakeningPlayer = ToClient_isSameTitleKeyForInteraction(__eInteractionTitleType_ArshaWinner)
  if nil ~= skillNo then
    if (false == isAwakeningPlayer or nil == isAwakeningPlayer) and toInt64(0, 0) == hasMemoryFlag and not applyAwakenSkillReset and not applyBookOfCombat then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_REINFORCE_NEEDITEM"))
      return
    end
    local SkillSSW = getSkillStaticStatus(skillNo, 1)
    if nil == SkillSSW then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_NOINFO"))
      return
    end
    local ActiveSkillWrapper = SkillSSW:getActiveSkillStatus()
    if nil == ActiveSkillWrapper then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_ALERT"))
      return
    end
  end
  self._ui.stc_CircleSkillIcon:ChangeTextureInfoNameAsync("")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  self._inSkillIndex = index
  PaGlobalFunc_PaGlobal_SkillReinforce_All_Open()
  self._usingDarkMoonBuff = usingDarkMoonBuff
  self:update(skillType, skillNo, nil, skillIndex)
end
function PaGlobal_SkillReinforce_All:change(skillType, skillNo, skillIndex, index, usingDarkMoonBuff)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local applyAwakenSkillReset = selfPlayer:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_UnlimitedSkillAwakening)
  local applyBookOfCombat = selfPlayer:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_BookOfCombat)
  local inventory = selfPlayer:get():getInventory()
  local hasMemoryFlag = inventory:getItemCount_s64(ItemEnchantKey(44195, 0))
  local isAwakeningPlayer = ToClient_isSameTitleKeyForInteraction(__eInteractionTitleType_ArshaWinner)
  if (false == isAwakeningPlayer or nil == isAwakeningPlayer) and toInt64(0, 0) == hasMemoryFlag and not applyAwakenSkillReset and not applyBookOfCombat then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SKILL_REINFORCE_NEEDITEM"))
    return
  end
  local playerSkillType = ToClient_GetCurrentPlayerSkillType()
  if nil == playerSkillType then
    return
  end
  local reinforcableCount = 0
  if true == _ContentsGroup_TotalSkillReininforce then
    reinforcableCount = PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Normal)
    if __eSkillTypeParam_Awaken == skillType then
      reinforcableCount = reinforcableCount + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Awaken)
    elseif __eSkillTypeParam_Inherit == skillType then
      reinforcableCount = reinforcableCount + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Inherit)
    end
  else
    reinforcableCount = PaGlobal_SkillReinforce_All:reinforcable_SkillCount(skillType)
    if __eSkillTypeParam_Inherit == skillType then
      reinforcableCount = reinforcableCount + PaGlobal_SkillReinforce_All:reinforcable_SkillCount(__eSkillTypeParam_Normal)
    end
  end
  if 0 == reinforcableCount then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_NOSKILL"))
    return
  end
  self._ui.stc_CircleSkillIcon:ChangeTextureInfoNameAsync("")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  self._inSkillIndex = index
  PaGlobalFunc_PaGlobal_SkillReinforce_All_Open()
  self._usingDarkMoonBuff = usingDarkMoonBuff
  self:update(skillType, skillNo, nil, nil, skillIndex)
end
function PaGlobal_SkillReinforce_All:setSkill(skillNo, index)
  self._ui.txt_SelectSkill:SetShow(false)
  self._ui.stc_SelectSkillPlus:SetShow(false)
  self._ui.txt_SelectSkillName:SetShow(true)
  self._ui.stc_SelectSkillIcon:SetShow(true)
  local skillSSW = getSkillStaticStatus(skillNo, 1)
  local skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
  self._ui.btn_SelectSkillBtn:setRenderTexture(self._ui.btn_SelectSkillBtn:getBaseTexture())
  self._ui.txt_SelectSkillName:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectSkillName:SetText(tostring(skillSSW:getName()))
  self._ui.stc_SelectSkillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
  if true == self._isConsole then
    self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.selectSkill .. "," .. skillNo .. ",false)")
  else
    self._ui.stc_SelectSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwaken\")")
  end
  self._ui.stc_SelectSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  self._currentSkillNo = skillNo
  self._ui.stc_SelectSkillMain:SetShow(false)
  self:setSpan(true)
  if nil ~= index then
    self._currentSkillIndex = index
  end
  self._ui.stc_CircleSkillIcon:SetIgnore(false)
  self._ui.stc_CircleSkillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, true)")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  Panel_SkillTooltip_Hide()
  self._currentOptionIndex1 = nil
  self._currentOptionIndex2 = nil
  self._ui.txt_Effect1:SetShow(false)
  self._ui.txt_SelectEffect1:SetShow(true)
  self._ui.stc_SelectPlus1:SetShow(true)
  self._ui.txt_Effect2:SetShow(false)
  self._ui.txt_SelectEffect2:SetShow(true)
  self._ui.stc_SelectPlus2:SetShow(true)
  self._ui.txt_SelectEffect1:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectEffect2:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectEffect1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTOPTION"))
  self._ui.txt_SelectEffect2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTOPTION"))
end
function PaGlobal_SkillReinforce_All:createOptionControl(content, key)
  if nil == self._currentSkillNo then
    return
  end
  local optionListBg = UI.getChildControl(content, "Button_Effect_Frame")
  local optionListDesc = UI.getChildControl(optionListBg, "StaticText_1")
  optionListBg:setRenderTexture(optionListBg:getBaseTexture())
  optionListBg:addInputEvent("Mouse_On", "")
  optionListBg:addInputEvent("Mouse_Out", "")
  if true == self._isConsole then
    optionListBg:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOptionList .. ")")
  end
  local skillSSW = getSkillStaticStatus(self._currentSkillNo, 1)
  if nil ~= skillSSW then
    local activeSkillSS = skillSSW:getActiveSkillStatus()
    optionListDesc:SetTextMode(__eTextMode_AutoWrap)
    if nil ~= activeSkillSS then
      local optionCount = activeSkillSS:getSkillAwakenInfoCount()
      local count = 0
      local _key = Int64toInt32(key)
      if true == self._isFirstChangeOption then
        for index = 0, optionCount - 1 do
          if nil == self._currentOptionIndex2 then
            if index == _key then
              optionListDesc:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
              optionListBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SetOption( true," .. index .. ")")
              if 2 < optionListDesc:GetLineCount() then
                optionListDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
                optionListDesc:setLineCountByLimitAutoWrap(2)
                optionListDesc:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
                if false == self._isConsole then
                  optionListBg:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(true, " .. index .. ")")
                  optionListBg:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false, " .. index .. ")")
                end
              end
            end
          elseif index == _key and self._currentOptionIndex2 ~= _key then
            optionListDesc:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
            optionListBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SetOption( true," .. index .. ")")
            if 2 < optionListDesc:GetLineCount() then
              optionListDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
              optionListDesc:setLineCountByLimitAutoWrap(2)
              optionListDesc:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
              if false == self._isConsole then
                optionListBg:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(true, " .. index .. ")")
                optionListBg:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false, " .. index .. ")")
              end
            end
          end
        end
      else
        for index = 0, optionCount - 1 do
          if self._currentOptionIndex1 ~= index and index == _key then
            optionListDesc:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
            optionListBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SetOption( false," .. index .. ")")
            if 2 < optionListDesc:GetLineCount() then
              optionListDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
              optionListDesc:setLineCountByLimitAutoWrap(2)
              optionListDesc:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
              optionListBg:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(true, " .. index .. ")")
              optionListBg:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false, " .. index .. ")")
            end
          end
        end
      end
    end
  end
end
function PaGlobal_SkillReinforce_All:limitTextOptionListTooltip(isShow, index)
  if not isShow then
    TooltipSimple_Hide()
    return
  end
  local skillSSW = getSkillStaticStatus(self._currentSkillNo, 1)
  if nil == skillSSW then
    TooltipSimple_Hide()
    return
  end
  local activeSkillSS = skillSSW:getActiveSkillStatus()
  if nil == activeSkillSS then
    TooltipSimple_Hide()
    return
  end
  local name = tostring(activeSkillSS:getSkillAwakenDescription(index))
  local control = PaGlobal_SkillReinforce_All
  TooltipSimple_Show(self._ui.stc_SelectEffectMain, name)
end
function PaGlobal_SkillReinforce_All:setOption(isFirst, index)
  if nil == Panel_SkillReinforce_All then
    return
  end
  local skillSSW = getSkillStaticStatus(self._currentSkillNo, 1)
  local activeSkillSS = skillSSW:getActiveSkillStatus()
  if true == isFirst then
    self._ui.btn_SelectEffectbtn1:setRenderTexture(self._ui.btn_SelectEffectbtn1:getBaseTexture())
    self._ui.txt_SelectEffect1:SetShow(false)
    self._ui.stc_SelectPlus1:SetShow(false)
    self._ui.txt_Effect1:SetShow(true)
    self._ui.txt_Effect1:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
    if false == self._isConsole then
      if self._ui.txt_Effect1:IsLimitText() then
        self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(true, " .. index .. " )")
        self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)")
      else
        self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)")
        self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)")
      end
    else
      self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOption .. ",nil,nil," .. index .. ")")
    end
    self._currentOptionIndex1 = index
  else
    self._ui.btn_SelectEffectbtn2:setRenderTexture(self._ui.btn_SelectEffectbtn2:getBaseTexture())
    self._ui.txt_SelectEffect2:SetShow(false)
    self._ui.stc_SelectPlus2:SetShow(false)
    self._ui.txt_Effect2:SetShow(true)
    self._ui.txt_Effect2:SetText(tostring(activeSkillSS:getSkillAwakenDescription(index)))
    if false == self._isConsole then
      if self._ui.txt_Effect2:IsLimitText() then
        self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(true, " .. index .. " )")
        self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)")
      else
        self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)")
        self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_Out", "HandleEventOnOut_PaGlobal_SkillReinforce_All_LimitTextOptionListTooltip(false)")
      end
    else
      self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOption .. ",nil,nil," .. index .. ")")
    end
    self._currentOptionIndex2 = index
  end
  if nil == self._currentOptionIndex1 then
    if false == self._isConsole then
      self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "")
      self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_Out", "")
    else
      self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOption .. ")")
    end
  end
  if nil == self._currentOptionIndex2 then
    if false == self._isConsole then
      self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "")
      self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_Out", "")
    else
      self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOption .. ")")
    end
  end
  self._ui.stc_SelectEffectMain:SetShow(false)
  self:setSpan(true)
  activeSkillSS:getSkillAwakenDescription(index)
  self._ui.list_OptionList:getElementManager():clearKey()
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
end
function PaGlobal_SkillReinforce_All:optionList_Show(_isFirstOption)
  if nil == Panel_SkillReinforce_All then
    return
  end
  if nil == self._currentSkillNo then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTSKILL_2"))
    return
  end
  if false == _isFirstOption and nil == self._currentOptionIndex1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTFIRSTOPTION"))
    return
  end
  local skillSSW = getSkillStaticStatus(self._currentSkillNo, 1)
  local activeSkillSS = skillSSW:getActiveSkillStatus()
  if nil ~= activeSkillSS then
    local optionCount = activeSkillSS:getSkillAwakenInfoCount()
    local count = 0
    self._isFirstChangeOption = _isFirstOption
    if true == _isFirstOption then
      self._ui.btn_SelectEffectbtn1:setRenderTexture(self._ui.btn_SelectEffectbtn1:getBaseTexture())
      self._ui.list_OptionList:getElementManager():clearKey()
      for index = 0, optionCount - 1 do
        if self._currentOptionIndex2 ~= index then
          self._ui.list_OptionList:getElementManager():pushKey(toInt64(0, index))
        end
      end
    else
      self._ui.btn_SelectEffectbtn2:setRenderTexture(self._ui.btn_SelectEffectbtn2:getBaseTexture())
      self._ui.list_OptionList:getElementManager():clearKey()
      for index = 0, optionCount - 1 do
        if self._currentOptionIndex1 ~= index then
          self._ui.list_OptionList:getElementManager():pushKey(toInt64(0, index))
        end
      end
    end
    self._ui.stc_SelectSkillMain:SetShow(false)
    self._ui.stc_SelectEffectMain:SetShow(true)
    self:setSpan(false)
  end
end
function PaGlobal_SkillReinforce_All:reinforcable_SkillCount(_type)
  local reinforcableCount = ToClient_GetAwakeningListCount()
  if reinforcableCount > 0 then
    local count = 0
    for index = 0, reinforcableCount - 1 do
      local skillSSW = ToClient_GetAwakeningListAt(index)
      if _type == skillSSW:getSkillAwakenBranchType() then
        count = count + 1
      end
    end
    return count
  else
    return reinforcableCount
  end
end
function PaGlobal_SkillReinforce_All:doReinforce(isAddOption)
  if nil == self._currentSkillIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTSKILL"))
    return
  end
  if nil == self._currentOptionIndex1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTFIRSTOPTION"))
    return
  end
  if nil == self._currentOptionIndex2 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTSECONDOPTION"))
    return
  end
  if self._ui.btn_SkipAni:IsCheck() == true then
    if true == self._isConsole and nil ~= Panel_SkillReinforce_All then
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    self._ui.btn_SelectSkillBtn:SetIgnore(true)
    self._ui.btn_SelectEffectbtn1:SetIgnore(true)
    self._ui.btn_SelectEffectbtn2:SetIgnore(true)
    self._ui.stc_SelectEffectMain:SetShow(false)
    self._ui.stc_SelectSkillMain:SetShow(false)
    self:setSpan(true)
    self._ui.btn_ReinforceBtn:EraseAllEffect()
    self._ui.btn_ReinforceBtn:SetAlpha(0.85)
    self._ui.btn_ReinforceBtn:SetFontAlpha(0.85)
    self._ui.btn_ReinforceBtn:SetIgnore(true)
    self._ui.btn_ReinforceBtn:SetMonoTone(true)
    self._ui.stc_CirclurProgress:SetProgressRate(0)
    self._ui.stc_CirclurProgress:EraseAllEffect()
    self._ui.stc_CircleSkillIcon:EraseAllEffect()
    self._currentTimer = 0
    self._isStartAwaken = false
    self._isEndCircular = false
    self._isCompleteCircular = false
    self._endCircular = false
    self._currentTimer = 0
    self._currentRate = 0
    self._deltaTime = 0
    self._ui.stc_CircleSkillIcon:SetIgnore(false)
    self._isAddOption = isAddOption
    audioPostEvent_SystemUi(27, 3)
    _AudioPostEvent_SystemUiForXBOX(27, 3)
    PaGlobal_SkillReinforce_All:doIt()
  else
    Panel_SkillReinforce_All:RegisterUpdateFunc("PaGlobalFunc_PaGlobal_SkillReinforce_All_EffectGo")
    self._isAddOption = isAddOption
    if true == self._isConsole and nil ~= Panel_SkillReinforce_All then
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    end
    self._ui.btn_SelectSkillBtn:SetIgnore(true)
    self._ui.btn_SelectEffectbtn1:SetIgnore(true)
    self._ui.btn_SelectEffectbtn2:SetIgnore(true)
    self._ui.stc_SelectEffectMain:SetShow(false)
    self._ui.stc_SelectSkillMain:SetShow(false)
    self:setSpan(true)
    PaGlobal_SkillReinforce_All:animateSkillReinforceEffect()
  end
end
function PaGlobal_SkillReinforce_All:skillReinforceEffectGo(deltaTime)
  if true == self._isStartAwaken and self._currentTimer < 3 and false == self._isCompleteCircular then
    self._currentTimer = self._currentTimer + deltaTime
    self._currentRate = self._currentRate + self._tmpValue * deltaTime
    self._ui.stc_CirclurProgress:SetProgressRate(self._currentRate)
    if self._currentRate >= 100 then
      self._ui.stc_CirclurProgress:EraseAllEffect()
      self._ui.stc_CircleSkillIcon:EraseAllEffect()
      self._ui.stc_CirclurProgress:AddEffect("UI_ItemInstall_BigRing", true, 0, 0)
      self._ui.stc_CircleSkillIcon:AddEffect("UI_ItemInstall_Gold", true, 0, 0)
      self._ui.stc_CircleSkillIcon:AddEffect("UI_SkillAwakeningShield", false, 0, 0)
      self._ui.stc_CircleSkillIcon:AddEffect("fUI_SkillButton02", false, 0, 0)
      self._ui.stc_CircleSkillIcon:AddEffect("fUI_NewSkill01", false, 0, 0)
      self._ui.stc_CircleSkillIcon:AddEffect("UI_SkillAwakeningFinal", false, 0, 0)
      self._ui.stc_CircleSkillIcon:AddEffect("fUI_SkillAwakenBoom", false, 0, 0)
      self._currentTimer = 0
      self._isCompleteCircular = true
    end
  end
  if true == self._isCompleteCircular then
    self._currentTimer = self._currentTimer + deltaTime
    if self._currentTimer > 2 then
      self._isStartAwaken = false
      self._isEndCircular = false
      self._isCompleteCircular = false
      self._endCircular = false
      self._currentTimer = 0
      self._currentRate = 0
      self._deltaTime = 0
      self._ui.stc_CircleSkillIcon:SetIgnore(false)
      PaGlobal_SkillReinforce_All:doIt()
    end
  end
end
function PaGlobal_SkillReinforce_All:doIt()
  local haveOptionIndex = -1
  local skillSSW
  if self._isAddOption then
    skillSSW = ToClient_GetReAwakeningListAt(self._currentSkillIndex)
  else
    skillSSW = ToClient_GetAwakeningListAt(self._currentSkillIndex)
  end
  if nil == skillSSW then
    return
  end
  local skillNo = skillSSW:getSkillNo()
  local currentSkillOptionCount = ToClient_GetAwakeningAbilityCount(skillNo)
  if currentSkillOptionCount > 0 then
    haveOptionIndex = ToClient_GetAwakeningAbilityIndex(skillNo, 0)
  end
  local skillAwakeningActorType = __eSkillReinforceType_NonPlayer
  if self._usingDarkMoonBuff == true then
    skillAwakeningActorType = __eSkillReinforceType_DarkMoonBuff
  elseif PaGlobalFunc_ReinforceSkill_All_IsSkillAwakeningPlayer() == true then
    skillAwakeningActorType = __eSkillReinforceType_Player
  end
  if nil == self._beforeSkillIndex then
    if self._isAddOption then
      ToClient_RequestChangeAwakeningBitFlag(skillAwakeningActorType, self._currentSkillIndex, self._currentOptionIndex1, self._currentOptionIndex2)
    else
      ToClient_RequestSkillAwakening(skillAwakeningActorType, self._currentSkillIndex, self._currentOptionIndex1, self._currentOptionIndex2)
    end
  else
    ToClient_RequestChangeAwakeningSkill(skillAwakeningActorType, self._beforeSkillIndex, self._currentSkillIndex, self._currentOptionIndex1, self._currentOptionIndex2)
  end
  PaGlobal_SkillReinforce_All:prepareClose()
end
function PaGlobal_SkillReinforce_All:animateSkillReinforceEffect()
  audioPostEvent_SystemUi(3, 10)
  _AudioPostEvent_SystemUiForXBOX(27, 2)
  self._currentTimer = 0
  self._isStartAwaken = true
  self._ui.stc_CircleSkillIcon:SetIgnore(true)
  self._ui.btn_ReinforceBtn:EraseAllEffect()
  self._ui.btn_ReinforceBtn:SetAlpha(0.85)
  self._ui.btn_ReinforceBtn:SetFontAlpha(0.85)
  self._ui.btn_ReinforceBtn:SetIgnore(true)
  self._ui.btn_ReinforceBtn:SetMonoTone(true)
  self._ui.stc_CirclurProgress:AddEffect("UI_ItemInstall_ProduceRing", true, 0, 0)
  self._ui.stc_CircleSkillIcon:AddEffect("UI_SkillAwakening01", false, 0, 0)
  self._ui.stc_CirclurProgress:SetShow(true)
end
function PaGlobal_SkillReinforce_All:registEventHandler()
  if nil == Panel_SkillReinforce_All then
    return
  end
  self._ui.btn_Exit:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_Exit()")
  self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_OptionList_Show(true)")
  self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_OptionList_Show(false)")
  self._ui.list_MainSkillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PaGlobal_SkillReinforce_All_CreateSkillContent")
  self._ui.list_MainSkillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_AwakenSkillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PaGlobal_SkillReinforce_All_CreateSkillContent")
  self._ui.list_AwakenSkillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.list_OptionList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_PaGlobal_SkillReinforce_All_CreateOptionContent")
  self._ui.list_OptionList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_MainWeapon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_ShowSkillList(true)")
  self._ui.btn_AwakenWeapon:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_ShowSkillList(false)")
  Panel_SkillReinforce_All:setGlassBackground(true)
  Panel_SkillReinforce_All:RegisterShowEventFunc(true, "PaGloabl_PaGlobal_SkillReinforce_All_ShowAni()")
  Panel_SkillReinforce_All:RegisterShowEventFunc(false, "PaGloabl_PaGlobal_SkillReinforce_All_HideAni()")
  if true == self._isConsole then
    self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOption .. ")")
    self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.skillOption .. ")")
  end
  self._ui.btn_SkipAni:addInputEvent("Mouse_LUp", "HandleEventLUp_SkillReinforce_All_ToggleSkipAni()")
end
function PaGlobal_SkillReinforce_All:prepareOpen()
  if nil == Panel_SkillReinforce_All then
    return
  end
  self._ui.stc_CircleSkillIcon:ChangeTextureInfoNameAsync("")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
  self._ui.stc_CircleSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  if false == self._isConsole then
    self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_On", "")
    self._ui.btn_SelectEffectbtn1:addInputEvent("Mouse_Out", "")
    self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_On", "")
    self._ui.btn_SelectEffectbtn2:addInputEvent("Mouse_Out", "")
  end
  PaGlobalFunc_PaGlobal_ReinforceSkill_All_Close()
  self._ui.stc_SelectSkillMain:SetShow(false)
  self._ui.stc_SelectEffectMain:SetShow(false)
  self:setSpan(true)
  self._currentSkillNo = nil
  self._currentSkillIndex = nil
  self._currentOptionIndex1 = nil
  self._currentOptionIndex2 = nil
  self._isFirstChangeOption = nil
  self._isAddOption = false
  self._usingDarkMoonBuff = false
  self._ui.btn_ReinforceBtn:SetIgnore(false)
  self._ui.btn_ReinforceBtn:SetMonoTone(false)
  self._ui.stc_CirclurProgress:EraseAllEffect()
  self._ui.stc_CircleSkillIcon:EraseAllEffect()
  self._ui.stc_CirclurProgress:SetProgressRate(0)
  self._isEndCircular = true
  self._isCompleteCircular = false
  self._endCircular = 100
  self._deltaTime = 0
  self._endTime = 2
  self._tmpValue = self._endCircular / self._endTime
  self._currentTimer = 0
  self._currentRate = 0
  self._isStartAwaken = false
  TooltipSimple_Hide()
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(false)
  HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(self.eSelectButtonType.selectSkill)
  self._ui_console.stc_keyGuideBg:SetShow(self._isConsole)
  self._ui.btn_SkipAni:SetCheck(ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSkillReinforceAnimSkip))
  if self._isConsole == true and Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
    Panel_Window_SkillGroup_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  PaGlobal_SkillReinforce_All:open()
end
function PaGlobal_SkillReinforce_All:open()
  if nil == Panel_SkillReinforce_All then
    return
  end
  Panel_SkillReinforce_All:SetShow(true, true)
end
function PaGlobal_SkillReinforce_All:prepareClose()
  if nil == Panel_SkillReinforce_All then
    return
  end
  Panel_SkillReinforce_All:ClearUpdateLuaFunc()
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  PaGlobalFunc_DialogMain_All_SubPanelSetShow(true)
  self._ui_console.stc_keyGuideBg:SetShow(false)
  if self._isConsole == true and Panel_Window_SkillGroup_All ~= nil and Panel_Window_SkillGroup_All:GetShow() == true then
    Panel_Window_SkillGroup_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  end
  PaGlobal_SkillReinforce_All:close()
end
function PaGlobal_SkillReinforce_All:close()
  if nil == Panel_SkillReinforce_All then
    return
  end
  Panel_SkillReinforce_All:SetShow(false, true)
end
function PaGlobal_SkillReinforce_All:update(skillType, skillNo, optionIndex, reinforceSkillIndex, skillIndex)
  if nil == Panel_SkillReinforce_All then
    return
  end
  local reinforcableCount = ToClient_GetAwakeningListCount()
  local skillSSW, skillTypeSSW
  if nil == skillIndex then
    if nil == skillNo then
      self._ui.btn_SelectSkillBtn:SetShow(true)
      self._ui.btn_SelectSkillBtn:SetIgnore(false)
      self._ui.btn_SelectEffectbtn1:SetIgnore(false)
      self._ui.btn_SelectEffectbtn2:SetIgnore(false)
      self._ui.txt_SelectSkillName:SetShow(false)
      self._ui.stc_SelectSkillIcon:SetShow(false)
      self._ui.txt_SelectSkill:SetShow(true)
      self._ui.stc_SelectSkillPlus:SetShow(true)
      self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SkillList_Show()")
      self._ui.stc_SelectSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Hide()")
      self._ui.stc_SelectSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
    else
      skillSSW = getSkillStaticStatus(skillNo, 1)
      skillTypeSSW = skillSSW:getSkillTypeStaticStatusWrapper()
      self._ui.btn_SelectSkillBtn:SetShow(true)
      self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SkillList_Show()")
      PaGlobal_SkillReinforce_All:setSkill(skillNo)
      self._ui.btn_SelectSkillBtn:SetIgnore(true)
      self._ui.btn_SelectEffectbtn1:SetIgnore(false)
      self._ui.btn_SelectEffectbtn2:SetIgnore(false)
      self._ui.txt_SelectSkill:SetShow(false)
      self._ui.stc_SelectSkillPlus:SetShow(false)
      self._ui.txt_SelectSkillName:SetShow(true)
      self._ui.stc_SelectSkillIcon:SetShow(true)
      self._ui.txt_SelectSkillName:SetText(tostring(skillSSW:getName()))
      self._ui.stc_SelectSkillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeSSW:getIconPath())
      if false == self._isConsole then
        self._ui.stc_SelectSkillIcon:addInputEvent("Mouse_On", "Panel_SkillTooltip_Show(" .. skillNo .. ", false, \"SkillAwaken\")")
      end
      self._ui.stc_SelectSkillIcon:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
    end
  else
    self._ui.btn_SelectSkillBtn:SetIgnore(false)
    self._ui.btn_SelectEffectbtn1:SetIgnore(false)
    self._ui.btn_SelectEffectbtn2:SetIgnore(false)
    self._ui.txt_SelectSkillName:SetShow(false)
    self._ui.stc_SelectSkillIcon:SetShow(false)
    self._ui.txt_SelectSkill:SetShow(true)
    self._ui.stc_SelectSkillPlus:SetShow(true)
    self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_SkillList_Show()")
  end
  if nil ~= reinforceSkillIndex then
    self._currentSkillIndex = reinforceSkillIndex
    self._ui.btn_ReinforceBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_ReinforceDo( true )")
    if true == self._isConsole then
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_PaGlobal_SkillReinforce_All_ReinforceDo(true)")
      if nil ~= skillNo then
        self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.selectSkill .. "," .. skillNo .. ",false)")
      else
        self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.selectSkill .. ")")
      end
    end
  else
    self._ui.btn_ReinforceBtn:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SkillReinforce_All_ReinforceDo( false )")
    if true == self._isConsole then
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_PaGlobal_SkillReinforce_All_ReinforceDo(false)")
      if nil ~= skillNo then
        self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.selectSkill .. "," .. skillNo .. ",false)")
      else
        self._ui.btn_SelectSkillBtn:addInputEvent("Mouse_On", "HandleEventOn_PaGlobal_SkillReinforce_All_SetCurrentButtonData(" .. self.eSelectButtonType.selectSkill .. ")")
      end
    end
  end
  self._type = skillType
  _haveOptionIndex = optionIndex
  self._beforeSkillIndex = skillIndex
  self._ui.txt_SelectEffect1:SetShow(true)
  self._ui.txt_SelectEffect1:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectEffect1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTOPTION"))
  self._ui.txt_SelectEffect2:SetShow(true)
  self._ui.txt_SelectEffect2:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_SelectEffect2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILLREINFORCE_SELECTOPTION"))
  self._ui.txt_Effect1:SetShow(false)
  self._ui.txt_Effect2:SetShow(false)
  self._ui.stc_SelectPlus1:SetShow(true)
  self._ui.stc_SelectPlus2:SetShow(true)
end
function PaGlobal_SkillReinforce_All:setCurrentButtonData(selectButtonType, skillNo, isAwakenSet, optionIndex)
  if nil == Panel_SkillReinforce_All then
    return
  end
  if false == _ContentsGroup_TotalSkillReininforce then
    return
  end
  if false == self._isConsole then
    return
  end
  Panel_SkillTooltip_Hide()
  TooltipSimple_Hide()
  Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui_console.stc_keyGuideClose:SetShow(true)
  self._ui_console.stc_keyGuideSelect:SetShow(true)
  self._ui_console.stc_keyGuideChangeSkill:SetShow(false)
  self._ui_console.stc_keyGuideDetail:SetShow(false)
  local keyGuides = {}
  local curIndex = 1
  if self.eSelectButtonType.skillOption == selectButtonType then
    if nil ~= self._currentSkillNo and nil ~= optionIndex and (optionIndex == self._currentOptionIndex1 and true == self._ui.txt_Effect1:IsLimitText() or optionIndex == self._currentOptionIndex2 and true == self._ui.txt_Effect2:IsLimitText()) then
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PaGlobal_SkillReinforce_All_SetOptionToolTip(" .. optionIndex .. ")")
      self._ui_console.stc_keyGuideDetail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PEARLSHOP_DETAILINFOVIEW"))
      self._ui_console.stc_keyGuideDetail:SetShow(true)
      keyGuides[curIndex] = self._ui_console.stc_keyGuideDetail
      curIndex = curIndex + 1
    end
  elseif nil ~= skillNo and nil ~= isAwakenSet and (self.eSelectButtonType.skillList == selectButtonType or self.eSelectButtonType.selectSkill == selectButtonType and nil ~= self._currentSkillNo) then
    if true == isAwakenSet then
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PaGlobal_SkillReinforce_All_SetSkillToolTip(" .. skillNo .. ",true)")
    else
      Panel_SkillReinforce_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_PaGlobal_SkillReinforce_All_SetSkillToolTip(" .. skillNo .. ",false)")
    end
    self._ui_console.stc_keyGuideDetail:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_REINFORCE_CONSOLE_DETAIL"))
    self._ui_console.stc_keyGuideDetail:SetShow(true)
    keyGuides[curIndex] = self._ui_console.stc_keyGuideDetail
    curIndex = curIndex + 1
  end
  self._ui_console.stc_keyGuideChangeSkill:SetShow(true)
  keyGuides[curIndex] = self._ui_console.stc_keyGuideChangeSkill
  curIndex = curIndex + 1
  keyGuides[curIndex] = self._ui_console.stc_keyGuideSelect
  curIndex = curIndex + 1
  keyGuides[curIndex] = self._ui_console.stc_keyGuideClose
  curIndex = curIndex + 1
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_SkillReinforce_All:validate()
  if nil == Panel_SkillReinforce_All then
    return
  end
  self._ui.stc_TitleBg:isValidate()
  self._ui.btn_Exit:isValidate()
  self._ui.btn_Help:isValidate()
  self._ui.stc_SkillReinforceBg:isValidate()
  self._ui.stc_SkillReinforceArea:isValidate()
  self._ui.btn_SkipAni:isValidate()
  self._ui.stc_Circle:isValidate()
  self._ui.stc_CircleEffect:isValidate()
  self._ui.stc_CirclurProgress:isValidate()
  self._ui.stc_CircleSkillSlotBg:isValidate()
  self._ui.stc_CircleSkillIcon:isValidate()
  self._ui.stc_CircleSkillIconOff:isValidate()
  self._ui.stc_CircleSkillIconOn:isValidate()
  self._ui.btn_ReinforceBtn:isValidate()
  self._ui.stc_SkillSelectArea:isValidate()
  self._ui.txt_SelectSkillTitle:isValidate()
  self._ui.btn_SelectSkillBtn:isValidate()
  self._ui.stc_SelectSkillIcon:isValidate()
  self._ui.txt_SelectSkillName:isValidate()
  self._ui.txt_SelectSkillInfo:isValidate()
  self._ui.stc_SelectSkillPlus:isValidate()
  self._ui.txt_SelectSkill:isValidate()
  self._ui.stc_EffectSelectArea:isValidate()
  self._ui.txt_SelectEffectTitle:isValidate()
  self._ui.btn_SelectEffectbtn1:isValidate()
  self._ui.txt_Effect1:isValidate()
  self._ui.txt_SelectEffect1:isValidate()
  self._ui.stc_SelectPlus1:isValidate()
  self._ui.btn_SelectEffectbtn2:isValidate()
  self._ui.txt_Effect2:isValidate()
  self._ui.txt_SelectEffect2:isValidate()
  self._ui.stc_SelectPlus2:isValidate()
  self._ui.stc_SelectSkillMain:isValidate()
  self._ui.stc_SelectSkillTitleArea:isValidate()
  self._ui.btn_SelectSkillExit:isValidate()
  self._ui.stc_SelectSkillArea:isValidate()
  self._ui.list_MainSkillList:isValidate()
  self._ui.list_AwakenSkillList:isValidate()
  self._ui.stc_RadioGroup:isValidate()
  self._ui.btn_MainWeapon:isValidate()
  self._ui.btn_AwakenWeapon:isValidate()
  self._ui.stc_SelectLine:isValidate()
  self._ui.stc_SelectEffectMain:isValidate()
  self._ui.stc_SelectEffectTitle:isValidate()
  self._ui.btn_SelectEffectExit:isValidate()
  self._ui.stc_SelectEffectArea:isValidate()
  self._ui.list_OptionList:isValidate()
  self._ui.txt_InfoArea:isValidate()
  self._ui_console.stc_keyGuideBg:isValidate()
  self._ui_console.stc_keyGuideClose:isValidate()
  self._ui_console.stc_keyGuideSelect:isValidate()
  self._ui_console.stc_keyGuideChangeSkill:isValidate()
  self._ui_console.stc_keyGuideDetail:isValidate()
end
