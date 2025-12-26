Panel_SkillCommand_Cutscene:setMaskingChild(true)
Panel_SkillCommand_Cutscene:ActiveMouseEventEffect(true)
Panel_SkillCommand_Cutscene:setGlassBackground(true)
local skillCommand_Cutscene = {
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
  viewableMaxSkillCount = 11,
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
function Panel_SkkillCommand_ShowAni()
end
function Panel_SkkillCommand_HideAni()
end
function skillCommand_Cutscene:Init()
  for i = 0, self.viewableMaxSkillCount - 1 do
    local slot = {}
    slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_C_SkillBG", Panel_SkillCommand_Cutscene, "skillCommand_Cutscene_mainBG_" .. i)
    slot._blueBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_C_SkillBlueBG", slot._mainBG, "skillCommand_Cutscene_blueBG_" .. i)
    slot._yellowBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_C_SkillYellowBG", slot._mainBG, "skillCommand_Cutscene_yellowBG_" .. i)
    slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_C_SkillIcon", slot._mainBG, "skillCommand_Cutscene_skillIcon_" .. i)
    slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_C_SkillName", slot._mainBG, "skillCommand_Cutscene_skillName_" .. i)
    slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_SkillCommandBody", slot._mainBG, "skillCommand_Cutscene_skillCommandBody_" .. i)
    slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_C_SkillCommand", slot._mainBG, "skillCommand_Cutscene_skillCommand_" .. i)
    slot._skillNext = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_Next", slot._mainBG, "skillCommand_Cutscene_skillNext_" .. self.viewableMaxSkillCount)
    slot._mainBG:SetShow(false)
    slot._blueBG:SetShow(false)
    slot._yellowBG:SetShow(false)
    slot._skillIcon:SetShow(false)
    slot._skillName:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    slot._skillCommand:SetShow(false)
    slot._skillNext:SetShow(false)
    self._slots[i] = slot
  end
  self._classType = getSelfPlayer():getClassType()
  Panel_SkillCommand_Cutscene:SetSize(300, 250)
  skillCommand_Cutscene:InitAttackModeTipSlot()
  Panel_SkillCommand_Cutscene:SetRenderAndEventHide(true)
  Panel_SkillCommand_Cutscene:SetShow(false)
end
function skillCommand_Cutscene:InitAttackModeTipSlot()
  local slot = {}
  slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_C_SkillBG", Panel_SkillCommand_Cutscene, "AttackModeTip_mainBG_Cutscene")
  slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_C_SkillIcon", slot._mainBG, "AttackModeTip_skillIcon_Cutscene")
  slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_C_SkillName", slot._mainBG, "AttackModeTip_skillName_Cutscene")
  slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_SkillCommandBody", slot._mainBG, "AttackModeTip_skillCommandBody_Cutscene")
  slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_C_SkillCommand", slot._mainBG, "AttackModeTip_skillCommand_Cutscene")
  slot._mainBG:SetShow(false)
  slot._skillIcon:SetShow(false)
  slot._skillName:SetShow(false)
  slot._skillCommandBody:SetShow(false)
  slot._skillCommand:SetShow(false)
  self._attackModeTipSlot = slot
end
function skillCommand_Cutscene:Open(actorKeyRaw)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if 0 == self.skillCount then
    return
  end
  for i = 0, self.skillCount - 1 do
    local slot = self._slots[i]
    local slotConfig = self._config.pos
    slot._mainBG:SetShow(true)
    slot._skillIcon:SetShow(true)
    slot._skillName:SetShow(true)
    slot._skillCommandBody:SetShow(true)
    slot._blueBG:SetShow(false)
    slot._yellowBG:SetShow(false)
  end
  self.sizeUpCount = 0
  Panel_SkillCommand_Cutscene:SetSize(300, 250)
  skillCommand_Cutscene:SetSkill_Cutscene()
  Panel_SkillCommand_Cutscene:SetShow(true)
end
function skillCommand_Cutscene:getSkillNoFromGroupForCutscene(skillNo)
  if skillNo == nil then
    return 0
  end
  local skillKey = ToClient_GetTopLevelActiveSkillForCutscene(skillNo)
  return skillKey:getSkillNo()
end
function FromClient_SkillCommandList_Cutscene(skillNo, isAwaken)
  local self = skillCommand_Cutscene
  if isAwaken == true then
    return
  end
  if self._weaponType == 2 then
    return
  end
  if 0 < #self.skilldatatable then
    local skillCheck = false
    for index = 1, #self.skilldatatable do
      if self.skilldatatable[index] == skillNo then
        skillCheck = true
      end
    end
    if not skillCheck then
      table.insert(self.skilldatatable, skillNo)
      self.recommandSkillCount = self.recommandSkillCount + 1
    end
  else
    table.insert(self.skilldatatable, skillNo)
    self.recommandSkillCount = self.recommandSkillCount + 1
  end
  self.skillCommandShowkeep[self.lvupSkillCount + self.recommandSkillCount - 1] = false
  self.elapsedTime = 0
end
function FromClient_SkillCommandDataSet_Cutscene()
  SkillCommand_Reset()
  if nil == getSelfPlayer() then
    return
  end
  local self = skillCommand_Cutscene
  ToClient_RequestCommandListForCutscene()
  self.skillCount = self.recommandSkillCount + self.lvupSkillCount
  if 0 == self.skillCount then
    return
  end
  self:Open()
  self.lvupSkillCount = 0
end
function SkillCommand_SetSkillShow_Cutscene(skillNo, isShow)
  if false == _ContentsGroup_SkillEffect then
    return
  end
  if nil == skillNo or nil == isShow then
    return
  end
  local self = skillCommand_Cutscene
  if true == isShow then
    for index, value in pairs(self.cooltimeSkill) do
      if value == skillNo then
        table.remove(self.cooltimeSkill, index)
      end
    end
  else
    local skillCheck = false
    for index, value in pairs(self.cooltimeSkill) do
      if value == skillNo then
        skillCheck = true
      end
    end
    if false == skillCheck then
      table.insert(self.cooltimeSkill, skillNo)
    end
  end
  local sortFunc = function(a, b)
    return a < b
  end
  table.sort(self.cooltimeSkill, sortFunc)
  local skillAddCnt = 0
  self.sizeUpCount = 0
  for i = 0, self.skillCount - 1 do
    local slot = self._slots[i]
    local isDoubleSize = false
    local skillNo = self.skilldatatable[i + 1]
    if nil ~= skillNo then
      local skillKey = self:getSkillNoFromGroupForCutscene(skillNo)
      local isShow = true
      for index, value in pairs(self.cooltimeSkill) do
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
function skillCommand_Cutscene:SetSkill_Cutscene()
  for i = 0, self.skillCount - 1 do
    if nil ~= self.skilldatatable[i + 1] then
      local skillWrapper = getSkillCommandStatus(self.skilldatatable[i + 1])
      local skillKey = self:getSkillNoFromGroupForCutscene(self.skilldatatable[i + 1])
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
      local slot = self._slots[i]
      slot._skillIcon:ChangeTextureInfoNameAsync("Icon/" .. iconPath)
      slot._skillIcon:SetMonoTone(false)
      slot._skillName:SetText(name)
      self.skillNameSizeX = math.max(self.skillNameSizeX, slot._skillName:GetPosX() + slot._skillName:GetTextSizeX())
    end
  end
  for i = 0, self.skillCount - 1 do
    local skillWrapper = getSkillCommandStatus(self.skilldatatable[i + 1])
    local command = ""
    if false == _ContentsGroup_UsePadSnapping then
      command = skillWrapper:getCommand()
    else
      command = skillWrapper:getConsoleCommand()
    end
    local slot = self._slots[i]
    local isDoubleSize = false
    self.skillCommand[i] = 0
    self.skillCommandControl[i] = {}
    command = SkillCommand_SearchCommand_Cutscene(command, i, self.skilldatatable[i + 1])
    slot._skillCommandBody:SetPosX(self.skillNameSizeX)
    self._slots[i]._mainBG:SetPosY(0 + (i + self.sizeUpCount) * 30 + i * 2)
    if Panel_SkillCommand_Cutscene:GetSizeX() < slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() then
      if slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() > 500 then
        Panel_SkillCommand_Cutscene:SetSize(400, 250)
      end
      isDoubleSize = skillCommand_Cutscene:CommandControl_RePos(i)
    end
    slot.isDoubleSize = isDoubleSize
    if true == isDoubleSize then
      slot._skillName:SetPosY(15)
      slot._skillIcon:SetPosY(17)
      self.sizeUpCount = self.sizeUpCount + 1
    else
      slot._skillIcon:SetPosY(2)
      slot._skillName:SetPosY(0)
    end
    self._maxBgSizeX = math.max(self._maxBgSizeX, self.skillNameSizeX + slot._skillCommandBody:GetSizeX())
  end
  for i = 0, self.skillCount - 1 do
    local slot = self._slots[i]
    slot._mainBG:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._blueBG:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._yellowBG:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
  end
  for i = 0, self.skillCount - 1 do
    if self.skillCommandShowkeep[i] then
      self._slots[i]._blueBG:SetShow(true)
    end
  end
end
function skillCommand_Cutscene:CommandControl_RePos(index)
  local slot = self._slots[index]
  local basePosX = slot._skillCommandBody:GetPosX()
  local tempPosX = 5
  local skillCommandSizeX = Panel_SkillCommand_Cutscene:GetSizeX() - slot._skillCommandBody:GetPosX()
  local skillCommandSizeY = 30
  local isDoubleSize = false
  for controlCountIndex = 0, #self.skillCommandControl[index] do
    local controlPos = self.skillCommandControl[index][controlCountIndex]:GetPosX() + self.skillCommandControl[index][controlCountIndex]:GetSizeX() + basePosX
    local continue = false
    if skillCommandSizeX < tempPosX + self.skillCommandControl[index][controlCountIndex]:GetSizeX() then
      skillCommandSizeX = self.skillCommandControl[index][controlCountIndex]:GetPosX() + self.skillCommandControl[index][controlCountIndex]:GetSizeX()
      if 5 == tempPosX then
        continue = true
      end
    end
    if controlPos > Panel_SkillCommand_Cutscene:GetSizeX() and false == continue then
      self.skillCommandControl[index][controlCountIndex]:SetPosX(tempPosX)
      self.skillCommandControl[index][controlCountIndex]:SetPosY(self.skillCommandControl[index][controlCountIndex]:GetPosY() + 30)
      tempPosX = tempPosX + self.skillCommandControl[index][controlCountIndex]:GetSizeX() + 5
      skillCommandSizeY = 60
      isDoubleSize = true
    end
  end
  slot._skillCommandBody:SetSize(skillCommandSizeX, skillCommandSizeY)
  return isDoubleSize
end
function SkillCommand_StringMatchForConvert_Cutscene(commandIndex, stringIndex, plusIndex)
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
function skillCommand_Cutscene:commandControlRePos(controlType, text, uiIndex)
  local tempControl
  tempControl = self.skillCommandControl[uiIndex][self.skillCommand[uiIndex]]
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
  local tempPosX = self._slots[uiIndex]._skillCommandBody:GetSizeX()
  tempControl:SetPosX(tempPosX)
  self._slots[uiIndex]._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX() + 5, self._slots[uiIndex]._skillCommandBody:GetSizeY())
  self.skillCommand[uiIndex] = self.skillCommand[uiIndex] + 1
end
function skillCommand_Cutscene:commandControlSet(controlType, text, uiIndex)
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
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_CommandLMouse", self._slots[uiIndex]._skillCommandBody, "Static_CommandLMouse_Cutscene_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    elseif RBstring == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_CommandRMouse", self._slots[uiIndex]._skillCommandBody, "Static_CommandRMouse_Cutscene_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    else
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_CommandBg", self._slots[uiIndex]._skillCommandBody, "StaticText_CommandBG_Cutscene_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
      tempControl:SetText(text)
      tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
      tempControl:SetPosY(2)
    end
  elseif 1 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "StaticText_Command", self._slots[uiIndex]._skillCommandBody, "StaticText_Command_Cutscene_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
  elseif 2 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand_Cutscene, "Static_CommandPlus", self._slots[uiIndex]._skillCommandBody, "Static_CommandPlus_Cutscene_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    tempControl:SetPosY(6)
  end
  tempControl:SetShow(true)
  local tempPosX = self._slots[uiIndex]._skillCommandBody:GetSizeX()
  tempControl:SetPosX(tempPosX)
  self._slots[uiIndex]._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX() + 5, self._slots[uiIndex]._skillCommandBody:GetSizeY())
  self.skillCommandControl[uiIndex][self.skillCommand[uiIndex]] = tempControl
  self.skillCommand[uiIndex] = self.skillCommand[uiIndex] + 1
end
function SkillCommand_RePosCommand_Cutscene(command, index, skillNo)
  local self = skillCommand_Cutscene
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert_Cutscene(commandIndex, stringIndex, plusIndex)
  if 0 == swapIndex then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    self:commandControlRePos(0, text, index)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif 1 == swapIndex then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    self:commandControlRePos(1, text, index)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif 2 == swapIndex then
    local text = string.sub(command, plusIndex, plusIndex)
    self:commandControlRePos(2, text, index)
    command = string.gsub(command, "+", "", 1)
  else
    return
  end
  command = SkillCommand_RePosCommand_Cutscene(command, index, skillNo)
end
function SkillCommand_SearchCommand_Cutscene(command, index, skillNo)
  local self = skillCommand_Cutscene
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert_Cutscene(commandIndex, stringIndex, plusIndex)
  if 0 == swapIndex then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    self:commandControlSet(0, text, index)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif 1 == swapIndex then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    self:commandControlSet(1, text, index)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif 2 == swapIndex then
    local text = string.sub(command, plusIndex, plusIndex)
    self:commandControlSet(2, text, index)
    command = string.gsub(command, "+", "", 1)
  else
    return
  end
  command = SkillCommand_SearchCommand_Cutscene(command, index, skillNo)
end
function SkillCommand_UpdateTime_Cutscene(updateTime)
  local self = skillCommand_Cutscene
  if nil == self.skilldatatable then
    SkillCommand_Reset_Cutscene()
    return
  end
  self.elapsedTime = self.elapsedTime + updateTime
  if self.elapsedTime > 30 then
    self.lvupSkillCount = 0
    SkillCommand_Reset_Cutscene()
    FromClient_SkillCommandDataSet_Cutscene()
    self.elapsedTime = 0
    self.isLevelUp = false
    for i = 0, self.skillCount - 1 do
      self._slots[i]._blueBG:SetShow(false)
    end
  end
end
function SkillCommand_Reset_Cutscene()
  local self = skillCommand_Cutscene
  if 0 < self.skillCount then
    for i = 0, self.skillCount - 1 do
      self._slots[i]._mainBG:SetShow(false)
      self._slots[i]._skillIcon:SetShow(false)
      self._slots[i]._skillName:SetShow(false)
      self._slots[i]._skillCommand:SetShow(false)
      self._slots[i]._skillCommandBody:SetShow(false)
      self._slots[i]._skillCommandBody:SetSize(5, 30)
      table.remove(self.skilldatatable, self.skillCount - i)
    end
    self.skilldatatable = {}
    for index = 0, self.skillCount - 1 do
      if nil ~= self.skillCommandControl[index] then
        for controlCountIndex = 0, #self.skillCommandControl[index] do
          if nil ~= self.skillCommandControl[index][controlCountIndex] then
            UI.deleteControl(self.skillCommandControl[index][controlCountIndex])
            self.skillCommandControl[index][controlCountIndex] = nil
          end
        end
      end
    end
  end
  self.elapsedTime = 0
  self.skillCount = 0
  self.recommandSkillCount = 0
  self.skillCommand = {}
end
function FGlobal_SkillCommand_ResetPosition_Cutscene()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  local initPosX = scrX / 2 * 1.2
  local initPosY = scrY / 2 * 0.85
  Panel_SkillCommand_Cutscene:SetPosX(initPosX)
  Panel_SkillCommand_Cutscene:SetPosY(initPosY)
  FGlobal_InitPanelRelativePos(Panel_SkillCommand_Cutscene, initPosX, initPosY)
  FGlobal_PanelRepostionbyScreenOut(Panel_SkillCommand_Cutscene)
end
function FGlobal_SkillCommand_Show_Cutscene(isShow)
  if isShow then
    FromClient_SkillCommandDataSet_Cutscene()
  end
end
function SkillCommand_Effect_Cutscene(skillWrapper)
  if not Panel_SkillCommand_Cutscene:GetShow() then
    return
  end
  if false == _ContentsGroup_SkillEffect then
    return
  end
  if true == skillCommand_Cutscene._isServantRide and nil ~= skillCommand_Cutscene._actorKeyRaw then
    return
  end
  local self = skillCommand_Cutscene
  if nil ~= skillWrapper then
    local skillNo = skillWrapper:getSkillNo()
    for i = 0, self.skillCount - 1 do
      if nil ~= self.skilldatatable[i + 1] then
        local skillKey = self:getSkillNoFromGroupForCutscene(self.skilldatatable[i + 1])
        if skillNo == skillKey then
          local isShow = true
          if true == isShow then
            self._slots[i]._skillIcon:EraseAllEffect()
            if nil == self._slots[i].isDoubleSize or false == self._slots[i].isDoubleSize then
              self._slots[i]._skillIcon:AddEffect("fUI_SkillCommand_01A", false, 125, 0)
            else
              self._slots[i]._skillIcon:AddEffect("fUI_SkillCommand_01B", false, 125, 0)
            end
            SkillCommand_UseEffect_Cutscene(i, true)
          end
        end
      end
    end
  end
end
function SkillCommand_UseEffect_Cutscene(index, isUse)
  local control
  control = skillCommand_Cutscene._slots[index]._blueBG
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
function PaGlobal_SkillGuide_Cutscene_Open()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  FromClient_SkillCommandDataSet_Cutscene()
  if skillCommand_Cutscene.skillCount == 0 then
    return
  end
  Panel_SkillCommand_Cutscene:SetShow(true, true)
  Panel_SkillCommand_Cutscene:SetRenderAndEventHide(false)
end
function PaGlobal_SkillGuide_Cutscene_Close()
  SkillCommand_Reset_Cutscene()
  Panel_SkillCommand_Cutscene:SetShow(false)
end
skillCommand_Cutscene:Init()
Panel_SkillCommand_Cutscene:RegisterUpdateFunc("SkillCommand_UpdateTime_Cutscene")
registerEvent("FromClient_SkillCommandList_Cutscene", "FromClient_SkillCommandList_Cutscene")
registerEvent("onScreenResize", "FGlobal_SkillCommand_ResetPosition_Cutscene")
registerEvent("FromClient_ApplyUISettingPanelInfo", "FGlobal_SkillCommand_ResetPosition_Cutscene")
registerEvent("FromClient_RenderModeChangeState", "FGlobal_SkillCommand_ResetPosition_Cutscene")
registerEvent("FromClient_LeaveSequencePossessMode", "PaGlobal_SkillGuide_Cutscene_Close")
