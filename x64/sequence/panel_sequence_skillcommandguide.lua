registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceSkillCommandGuide")
local skillCommand_Sequence = {
  _config = {
    pos = {
      gapY = 35,
      startX = 0,
      startY = 0
    }
  },
  _copyCommand = {},
  _slots = Array.new(),
  _attackModeTipSlot = {},
  skilldatatable = {},
  skillCount = 0,
  lvupSkillCount = 0,
  recommandSkillCount = 0,
  skillCommand = {},
  skillCommandControl = {},
  skillCommandCount = 0,
  elapsedTime = 0,
  skillCommandIndex = {},
  skillCommandShowkeep = {},
  color = Defines.Color.C_FF444444,
  viewableMaxSkillCount = 20,
  skillNameSizeX = 0,
  isLevelUp = false,
  sizeUpCount = 0,
  cooltimeSkill = {},
  _weaponType = 0,
  _isServantRide = false,
  _actorKeyRaw = nil,
  _comboTitle = nil,
  _comboSlotMaxCount = 3,
  _comboSlotIndex = 0,
  _skillComboShowIndex = 0,
  _maxBgSizeX = 0,
  _comboSlot = nil,
  _skillComboTimer = 0,
  _skillComboFrameDelay = 30,
  _skillComboLastUpdate = 0,
  _skillCombo = {},
  _skillComboControl = {},
  _skillComboComtrolTypeCount = 6,
  _skillComboControlIconCount = 20,
  _skillComboNextIconCount = 10,
  _skillComboMaxBgSizeX = 0,
  _skillComboBgSize = 0,
  _skillComboLineCount = 0,
  _curComboType = -1,
  _classType = nil,
  _eDrakaniaFormType = {FORM_NORMAL = 1, FORM_DRAGON = 2}
}
function FromClient_InitSequenceSkillCommandGuide()
  Panel_Sequence_SkillCommandGuide:setMaskingChild(true)
  Panel_Sequence_SkillCommandGuide:ActiveMouseEventEffect(true)
  Panel_Sequence_SkillCommandGuide:setGlassBackground(true)
  InitSkillCommandGuide()
  Panel_Sequence_SkillCommandGuide:RegisterUpdateFunc("SkillCommand_UpdateTime_Sequence")
  registerEvent("FromClient_SkillCommandList_Sequence", "FromClient_SkillCommandList_Sequence")
  registerEvent("onScreenResize", "FGlobal_SkillCommand_ResetPosition_Sequence")
  registerEvent("FromClient_StopSequence", "PaGlobal_SkillGuide_Sequence_Close")
  registerEvent("FromClient_ShowSequenceSkillCommandNoLimit", "FromClient_ShowSequenceSkillCommandNoLimit")
end
function InitSkillCommandGuide()
  for i = 0, skillCommand_Sequence.viewableMaxSkillCount - 1 do
    local slot = {}
    slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_C_SkillBG", Panel_Sequence_SkillCommandGuide, "skillCommand_Sequence_mainBG_" .. i)
    slot._blueBG = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_C_SkillBlueBG", slot._mainBG, "skillCommand_Sequence_blueBG_" .. i)
    slot._yellowBG = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_C_SkillYellowBG", slot._mainBG, "skillCommand_Sequence_yellowBG_" .. i)
    slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_C_SkillIcon", slot._mainBG, "skillCommand_Sequence_skillIcon_" .. i)
    slot._skillName = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_C_SkillName", slot._mainBG, "skillCommand_Sequence_skillName_" .. i)
    slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_SkillCommandBody", slot._mainBG, "skillCommand_Sequence_skillCommandBody_" .. i)
    slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_C_SkillCommand", slot._mainBG, "skillCommand_Sequence_skillCommand_" .. i)
    slot._skillNext = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_Next", slot._mainBG, "skillCommand_Sequence_skillNext_" .. skillCommand_Sequence.viewableMaxSkillCount)
    slot._mainBG:SetShow(false)
    slot._blueBG:SetShow(false)
    slot._yellowBG:SetShow(false)
    slot._skillIcon:SetShow(false)
    slot._skillName:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    slot._skillCommand:SetShow(false)
    slot._skillNext:SetShow(false)
    skillCommand_Sequence._slots[i] = slot
  end
  skillCommand_Sequence._classType = getSelfPlayer():getClassType()
  Panel_Sequence_SkillCommandGuide:SetSize(300, 250)
  skillCommand_Sequence:InitAttackModeTipSlot()
  Panel_Sequence_SkillCommandGuide:SetRenderAndEventHide(true)
  Panel_Sequence_SkillCommandGuide:SetShow(false)
end
function skillCommand_Sequence:InitAttackModeTipSlot()
  local slot = {}
  slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_C_SkillBG", Panel_Sequence_SkillCommandGuide, "AttackModeTip_mainBG_Cutscene")
  slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_C_SkillIcon", slot._mainBG, "AttackModeTip_skillIcon_Cutscene")
  slot._skillName = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_C_SkillName", slot._mainBG, "AttackModeTip_skillName_Cutscene")
  slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_SkillCommandBody", slot._mainBG, "AttackModeTip_skillCommandBody_Cutscene")
  slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_C_SkillCommand", slot._mainBG, "AttackModeTip_skillCommand_Sequence")
  slot._mainBG:SetShow(false)
  slot._skillIcon:SetShow(false)
  slot._skillName:SetShow(false)
  slot._skillCommandBody:SetShow(false)
  slot._skillCommand:SetShow(false)
  skillCommand_Sequence._attackModeTipSlot = slot
end
function skillCommand_Sequence_Open(actorKeyRaw)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if 0 == skillCommand_Sequence.skillCount then
    return
  end
  for i = 0, skillCommand_Sequence.skillCount - 1 do
    local slot = skillCommand_Sequence._slots[i]
    local slotConfig = skillCommand_Sequence._config.pos
    slot._mainBG:SetShow(true)
    slot._skillIcon:SetShow(true)
    slot._skillName:SetShow(true)
    slot._skillCommandBody:SetShow(true)
    slot._blueBG:SetShow(false)
    slot._yellowBG:SetShow(false)
  end
  skillCommand_Sequence.sizeUpCount = 0
  Panel_Sequence_SkillCommandGuide:SetSize(300, 250)
  skillCommand_Sequence:SetSkill_Sequence()
  Panel_Sequence_SkillCommandGuide:SetShow(true)
end
function getSkillNoFromGroupForSequence(skillNo)
  if skillNo == nil then
    return 0
  end
  local skillKey = ToClient_GetTopLevelActiveSkillForSequence(skillNo)
  return skillKey:getSkillNo()
end
function FromClient_SkillCommandList_Sequence(skillNo, isAwaken)
  if isAwaken == true then
    return
  end
  if skillCommand_Sequence._weaponType == 2 then
    return
  end
  if 0 < #skillCommand_Sequence.skilldatatable then
    local skillCheck = false
    for index = 1, #skillCommand_Sequence.skilldatatable do
      if skillCommand_Sequence.skilldatatable[index] == skillNo then
        skillCheck = true
      end
    end
    if not skillCheck then
      table.insert(skillCommand_Sequence.skilldatatable, skillNo)
      skillCommand_Sequence.recommandSkillCount = skillCommand_Sequence.recommandSkillCount + 1
    end
  else
    table.insert(skillCommand_Sequence.skilldatatable, skillNo)
    skillCommand_Sequence.recommandSkillCount = skillCommand_Sequence.recommandSkillCount + 1
  end
  skillCommand_Sequence.skillCommandShowkeep[skillCommand_Sequence.lvupSkillCount + skillCommand_Sequence.recommandSkillCount - 1] = false
  skillCommand_Sequence.elapsedTime = 0
end
function FromClient_SkillCommandDataSet_Sequence()
  SkillCommand_Reset()
  if nil == getSelfPlayer() then
    return
  end
  ToClient_RequestCommandListForSequence()
  skillCommand_Sequence.skillCount = skillCommand_Sequence.recommandSkillCount + skillCommand_Sequence.lvupSkillCount
  if 0 == skillCommand_Sequence.skillCount then
    return
  end
  skillCommand_Sequence_Open()
  skillCommand_Sequence.lvupSkillCount = 0
end
function SkillCommand_SetSkillShow_Sequence(skillNo, isShow)
  if false == _ContentsGroup_SkillEffect then
    return
  end
  if nil == skillNo or nil == isShow then
    return
  end
  if true == isShow then
    for index, value in pairs(skillCommand_Sequence.cooltimeSkill) do
      if value == skillNo then
        table.remove(skillCommand_Sequence.cooltimeSkill, index)
      end
    end
  else
    local skillCheck = false
    for index, value in pairs(skillCommand_Sequence.cooltimeSkill) do
      if value == skillNo then
        skillCheck = true
      end
    end
    if false == skillCheck then
      table.insert(skillCommand_Sequence.cooltimeSkill, skillNo)
    end
  end
  local sortFunc = function(a, b)
    return a < b
  end
  table.sort(skillCommand_Sequence.cooltimeSkill, sortFunc)
  local skillAddCnt = 0
  skillCommand_Sequence.sizeUpCount = 0
  for i = 0, skillCommand_Sequence.skillCount - 1 do
    local slot = skillCommand_Sequence._slots[i]
    local isDoubleSize = false
    local skillNo = skillCommand_Sequence.skilldatatable[i + 1]
    if nil ~= skillNo then
      local skillKey = getSkillNoFromGroupForSequence(skillNo)
      local isShow = true
      for index, value in pairs(skillCommand_Sequence.cooltimeSkill) do
        if skillKey == value then
          isShow = false
        end
      end
      local skillTypeWrapper = getSkillTypeStaticStatus(skillKey)
      if nil ~= skillTypeWrapper then
        local name = skillTypeWrapper:getName()
        if nil ~= name then
          slot._skillName:SetText(name)
        end
      end
    end
  end
end
function skillCommand_Sequence:SetSkill_Sequence()
  for i = 0, skillCommand_Sequence.skillCount - 1 do
    if nil ~= skillCommand_Sequence.skilldatatable[i + 1] then
      local skillWrapper = getSkillCommandStatus(skillCommand_Sequence.skilldatatable[i + 1])
      local skillKey = getSkillNoFromGroupForSequence(skillCommand_Sequence.skilldatatable[i + 1])
      local skillTypeWrapper = getSkillTypeStaticStatus(skillKey)
      local name = ""
      local iconPath = ""
      if nil ~= skillTypeWrapper then
        name = skillTypeWrapper:getName()
        iconPath = skillTypeWrapper:getIconPath()
      else
        name = skillWrapper:getName()
        iconPath = skillWrapper:getIconPath()
      end
      local slot = skillCommand_Sequence._slots[i]
      slot._skillIcon:ChangeTextureInfoNameAsync("Icon/" .. iconPath)
      slot._skillIcon:SetMonoTone(false)
      slot._skillName:SetText(name)
      skillCommand_Sequence.skillNameSizeX = math.max(skillCommand_Sequence.skillNameSizeX, slot._skillName:GetPosX() + slot._skillName:GetTextSizeX())
    end
  end
  for i = 0, skillCommand_Sequence.skillCount - 1 do
    local skillWrapper = getSkillCommandStatus(skillCommand_Sequence.skilldatatable[i + 1])
    local command = ""
    if false == _ContentsGroup_UsePadSnapping then
      command = skillWrapper:getCommand()
    else
      command = skillWrapper:getConsoleCommand()
    end
    local slot = skillCommand_Sequence._slots[i]
    local isDoubleSize = false
    skillCommand_Sequence.skillCommand[i] = 0
    skillCommand_Sequence.skillCommandControl[i] = {}
    command = SkillCommand_SearchCommand_Sequence(command, i, skillCommand_Sequence.skilldatatable[i + 1])
    slot._skillCommandBody:SetPosX(skillCommand_Sequence.skillNameSizeX)
    skillCommand_Sequence._slots[i]._mainBG:SetPosY(0 + (i + skillCommand_Sequence.sizeUpCount) * 30 + i * 2)
    if Panel_Sequence_SkillCommandGuide:GetSizeX() < slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() then
      if slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() > 500 then
        Panel_Sequence_SkillCommandGuide:SetSize(400, 250)
      end
      isDoubleSize = skillCommand_Sequence:CommandControl_RePos(i)
    end
    slot.isDoubleSize = isDoubleSize
    if true == isDoubleSize then
      slot._skillName:SetPosY(15)
      slot._skillIcon:SetPosY(17)
      skillCommand_Sequence.sizeUpCount = skillCommand_Sequence.sizeUpCount + 1
    else
      slot._skillIcon:SetPosY(2)
      slot._skillName:SetPosY(0)
    end
    skillCommand_Sequence._maxBgSizeX = math.max(skillCommand_Sequence._maxBgSizeX, skillCommand_Sequence.skillNameSizeX + slot._skillCommandBody:GetSizeX())
  end
  for i = 0, skillCommand_Sequence.skillCount - 1 do
    local slot = skillCommand_Sequence._slots[i]
    slot._mainBG:SetSize(skillCommand_Sequence._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._blueBG:SetSize(skillCommand_Sequence._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._yellowBG:SetSize(skillCommand_Sequence._maxBgSizeX, slot._skillCommandBody:GetSizeY())
  end
  for i = 0, skillCommand_Sequence.skillCount - 1 do
    if skillCommand_Sequence.skillCommandShowkeep[i] then
      skillCommand_Sequence._slots[i]._blueBG:SetShow(true)
    end
  end
end
function skillCommand_Sequence:CommandControl_RePos(index)
  local slot = skillCommand_Sequence._slots[index]
  local basePosX = slot._skillCommandBody:GetPosX()
  local tempPosX = 5
  local skillCommandSizeX = Panel_Sequence_SkillCommandGuide:GetSizeX() - slot._skillCommandBody:GetPosX()
  local skillCommandSizeY = 30
  local isDoubleSize = false
  for controlCountIndex = 0, #skillCommand_Sequence.skillCommandControl[index] do
    local controlPos = skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:GetPosX() + skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:GetSizeX() + basePosX
    local continue = false
    if skillCommandSizeX < tempPosX + skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:GetSizeX() then
      skillCommandSizeX = self.skillCommandControl[index][controlCountIndex]:GetPosX() + skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:GetSizeX()
      if 5 == tempPosX then
        continue = true
      end
    end
    if controlPos > Panel_Sequence_SkillCommandGuide:GetSizeX() and false == continue then
      skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:SetPosX(tempPosX)
      skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:SetPosY(skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:GetPosY() + 30)
      tempPosX = tempPosX + skillCommand_Sequence.skillCommandControl[index][controlCountIndex]:GetSizeX() + 5
      skillCommandSizeY = 60
      isDoubleSize = true
    end
  end
  slot._skillCommandBody:SetSize(skillCommandSizeX, skillCommandSizeY)
  return isDoubleSize
end
function SkillCommand_StringMatchForConvert_Sequence(commandIndex, stringIndex, plusIndex)
  local returnValue
  if nil ~= commandIndex then
    returnValue = 0
    if nil ~= stringIndex then
      if stringIndex < commandIndex then
        returnValue = 1
      end
      if nil ~= plusIndex and plusIndex < math.min(commandIndex, stringIndex) then
        returnValue = 2
      end
    elseif nil ~= plusIndex and plusIndex < commandIndex then
      returnValue = 2
    end
  elseif nil ~= stringIndex then
    returnValue = 1
    if nil ~= plusIndex and plusIndex < stringIndex then
      returnValue = 2
    end
  elseif nil ~= plusIndex then
    returnValue = 2
  end
  return returnValue
end
function commandControlRePos(controlType, text, uiIndex)
  local tempControl
  tempControl = skillCommand_Sequence.skillCommandControl[uiIndex][skillCommand_Sequence.skillCommand[uiIndex]]
  tempControl:SetPosY(0)
  if 0 == controlType then
    if "LB" ~= text and "RB" ~= text then
      tempControl:SetText(text)
      tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
      tempControl:SetPosY(2)
    end
  elseif 1 == controlType then
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
  elseif 2 == controlType then
    tempControl:SetPosY(6)
  end
  tempControl:SetShow(true)
  local tempPosX = skillCommand_Sequence._slots[uiIndex]._skillCommandBody:GetSizeX()
  tempControl:SetPosX(tempPosX)
  skillCommand_Sequence._slots[uiIndex]._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX() + 5, skillCommand_Sequence._slots[uiIndex]._skillCommandBody:GetSizeY())
  skillCommand_Sequence.skillCommand[uiIndex] = skillCommand_Sequence.skillCommand[uiIndex] + 1
end
function commandControlSet(controlType, text, uiIndex)
  local tempControl
  local LBstring = ""
  local RBstring = ""
  if false == _ContentsGroup_UsePadSnapping then
    LBstring = "LB"
    RBstring = "RB"
  else
    LBstring = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseLB")
    RBstring = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseRB")
  end
  if 0 == controlType then
    if LBstring == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_CommandLMouse", skillCommand_Sequence._slots[uiIndex]._skillCommandBody, "Static_CommandLMouse_Cutscene_" .. uiIndex .. "_" .. skillCommand_Sequence.skillCommand[uiIndex])
    elseif RBstring == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_CommandRMouse", skillCommand_Sequence._slots[uiIndex]._skillCommandBody, "Static_CommandRMouse_Cutscene_" .. uiIndex .. "_" .. skillCommand_Sequence.skillCommand[uiIndex])
    else
      tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_CommandBg", skillCommand_Sequence._slots[uiIndex]._skillCommandBody, "StaticText_CommandBG_Cutscene_" .. uiIndex .. "_" .. skillCommand_Sequence.skillCommand[uiIndex])
      tempControl:SetText(text)
      tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
      tempControl:SetPosY(2)
    end
  elseif 1 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "StaticText_Command", skillCommand_Sequence._slots[uiIndex]._skillCommandBody, "StaticText_Command_Cutscene_" .. uiIndex .. "_" .. skillCommand_Sequence.skillCommand[uiIndex])
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
  elseif 2 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_Sequence_SkillCommandGuide, "Static_CommandPlus", skillCommand_Sequence._slots[uiIndex]._skillCommandBody, "Static_CommandPlus_Cutscene_" .. uiIndex .. "_" .. skillCommand_Sequence.skillCommand[uiIndex])
    tempControl:SetPosY(6)
  end
  tempControl:SetShow(true)
  local tempPosX = skillCommand_Sequence._slots[uiIndex]._skillCommandBody:GetSizeX()
  tempControl:SetPosX(tempPosX)
  skillCommand_Sequence._slots[uiIndex]._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX() + 5, skillCommand_Sequence._slots[uiIndex]._skillCommandBody:GetSizeY())
  skillCommand_Sequence.skillCommandControl[uiIndex][skillCommand_Sequence.skillCommand[uiIndex]] = tempControl
  skillCommand_Sequence.skillCommand[uiIndex] = skillCommand_Sequence.skillCommand[uiIndex] + 1
end
function SkillCommand_RePosCommand_Sequence(command, index, skillNo)
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert_Sequence(commandIndex, stringIndex, plusIndex)
  if 0 == swapIndex then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    commandControlRePos(0, text, index)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif 1 == swapIndex then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    commandControlRePos(1, text, index)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif 2 == swapIndex then
    local text = string.sub(command, plusIndex, plusIndex)
    commandControlRePos(2, text, index)
    command = string.gsub(command, "+", "", 1)
  else
    return
  end
  command = SkillCommand_RePosCommand_Sequence(command, index, skillNo)
end
function SkillCommand_SearchCommand_Sequence(command, index, skillNo)
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert_Sequence(commandIndex, stringIndex, plusIndex)
  if 0 == swapIndex then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    commandControlSet(0, text, index)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif 1 == swapIndex then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    commandControlSet(1, text, index)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif 2 == swapIndex then
    local text = string.sub(command, plusIndex, plusIndex)
    commandControlSet(2, text, index)
    command = string.gsub(command, "+", "", 1)
  else
    return
  end
  command = SkillCommand_SearchCommand_Sequence(command, index, skillNo)
end
function SkillCommand_UpdateTime_Sequence(updateTime)
  if nil == skillCommand_Sequence.skilldatatable then
    SkillCommand_Reset_Sequence()
    return
  end
  skillCommand_Sequence.elapsedTime = skillCommand_Sequence.elapsedTime + updateTime
  if skillCommand_Sequence.elapsedTime > 30 then
    skillCommand_Sequence.lvupSkillCount = 0
    SkillCommand_Reset_Sequence()
    FromClient_SkillCommandDataSet_Sequence()
    skillCommand_Sequence.elapsedTime = 0
    skillCommand_Sequence.isLevelUp = false
    for i = 0, skillCommand_Sequence.skillCount - 1 do
      skillCommand_Sequence._slots[i]._blueBG:SetShow(false)
    end
  end
end
function SkillCommand_Reset_Sequence()
  if 0 < skillCommand_Sequence.skillCount then
    for i = 0, skillCommand_Sequence.skillCount - 1 do
      skillCommand_Sequence._slots[i]._mainBG:SetShow(false)
      skillCommand_Sequence._slots[i]._skillIcon:SetShow(false)
      skillCommand_Sequence._slots[i]._skillName:SetShow(false)
      skillCommand_Sequence._slots[i]._skillCommand:SetShow(false)
      skillCommand_Sequence._slots[i]._skillCommandBody:SetShow(false)
      skillCommand_Sequence._slots[i]._skillCommandBody:SetSize(5, 30)
      table.remove(skillCommand_Sequence.skilldatatable, skillCommand_Sequence.skillCount - i)
    end
    skillCommand_Sequence.skilldatatable = {}
    for index = 0, skillCommand_Sequence.skillCount - 1 do
      if nil ~= skillCommand_Sequence.skillCommandControl[index] then
        for controlCountIndex = 0, #skillCommand_Sequence.skillCommandControl[index] do
          if nil ~= skillCommand_Sequence.skillCommandControl[index][controlCountIndex] then
            UI.deleteControl(skillCommand_Sequence.skillCommandControl[index][controlCountIndex])
            skillCommand_Sequence.skillCommandControl[index][controlCountIndex] = nil
          end
        end
      end
    end
  end
  skillCommand_Sequence.elapsedTime = 0
  skillCommand_Sequence.skillCount = 0
  skillCommand_Sequence.recommandSkillCount = 0
  skillCommand_Sequence.skillCommand = {}
end
function FGlobal_SkillCommand_ResetPosition_Sequence()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  local initPosX = scrX / 2 * 1.2
  local initPosY = scrY / 2 * 0.85
  Panel_Sequence_SkillCommandGuide:SetPosX(initPosX)
  Panel_Sequence_SkillCommandGuide:SetPosY(initPosY)
  FGlobal_InitPanelRelativePos(Panel_Sequence_SkillCommandGuide, initPosX, initPosY)
  FGlobal_PanelRepostionbyScreenOut(Panel_Sequence_SkillCommandGuide)
end
function SkillCommand_Effect_Sequence(skillWrapper)
  if not Panel_Sequence_SkillCommandGuide:GetShow() then
    return
  end
  if false == _ContentsGroup_SkillEffect then
    return
  end
  if true == skillCommand_Sequence._isServantRide and nil ~= skillCommand_Sequence._actorKeyRaw then
    return
  end
  if nil ~= skillWrapper then
    local skillNo = skillWrapper:getSkillNo()
    for i = 0, skillCommand_Sequence.skillCount - 1 do
      if nil ~= skillCommand_Sequence.skilldatatable[i + 1] then
        local skillKey = getSkillNoFromGroupForSequence(skillCommand_Sequence.skilldatatable[i + 1])
        if skillNo == skillKey then
          local isShow = true
          if true == isShow then
            skillCommand_Sequence._slots[i]._skillIcon:EraseAllEffect()
            if nil == skillCommand_Sequence._slots[i].isDoubleSize or false == skillCommand_Sequence._slots[i].isDoubleSize then
              skillCommand_Sequence._slots[i]._skillIcon:AddEffect("fUI_SkillCommand_01A", false, 125, 0)
            else
              skillCommand_Sequence._slots[i]._skillIcon:AddEffect("fUI_SkillCommand_01B", false, 125, 0)
            end
            SkillCommand_UseEffect_Sequence(i, true)
          end
        end
      end
    end
  end
end
function SkillCommand_UseEffect_Sequence(index, isUse)
  local control
  control = skillCommand_Sequence._slots[index]._blueBG
  if nil == control then
    return
  end
  control:SetShow(true)
  control:SetColor(Defines.Color.C_FFFFFFFF)
  local closeAni = control:addColorAnimation(0, 1.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  closeAni:SetStartColor(Defines.Color.C_FFFFFFFF)
  closeAni:SetEndColor(Defines.Color.C_99FFFFFF)
  closeAni:SetStartIntensity(3)
  closeAni:SetEndIntensity(1)
  closeAni.IsChangeChild = true
  closeAni:SetHideAtEnd(true)
end
function FromClient_ShowSequenceSkillCommandNoLimit(isShow)
  if isShow == true then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    FromClient_SkillCommandDataSet_Sequence()
    if skillCommand_Sequence.skillCount == 0 then
      return
    end
    FGlobal_SkillCommand_ResetPosition_Sequence()
    Panel_Sequence_SkillCommandGuide:SetShow(true, true)
    Panel_Sequence_SkillCommandGuide:SetRenderAndEventHide(false)
  else
    Panel_Sequence_SkillCommandGuide:SetShow(false, false)
    Panel_Sequence_SkillCommandGuide:SetRenderAndEventHide(true)
  end
end
function PaGlobal_SkillGuide_Sequence_Close()
  SkillCommand_Reset_Sequence()
  Panel_Sequence_SkillCommandGuide:SetShow(false)
end
