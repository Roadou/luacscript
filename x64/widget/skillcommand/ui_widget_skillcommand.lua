local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
local IM = CppEnums.EProcessorInputMode
local UIMode = Defines.UIMode
Panel_SkillCommand:setMaskingChild(true)
Panel_SkillCommand:ActiveMouseEventEffect(true)
Panel_SkillCommand:setGlassBackground(true)
Panel_SkillCommand:RegisterShowEventFunc(true, "Panel_SkkillCommand_ShowAni()")
Panel_SkillCommand:RegisterShowEventFunc(false, "Panel_SkkillCommand_HideAni()")
local skillCommand = {
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
  _forceRideOff = {},
  _isForceRideOffServant = false,
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
  _eDrakaniaFormType = {FORM_NORMAL = 1, FORM_DRAGON = 2},
  _isDrakania = false
}
local servantSkillList = {
  _commonList = {
    44,
    46,
    47,
    48,
    4,
    3,
    8,
    9,
    10,
    20,
    21,
    22,
    23,
    24,
    28,
    27,
    29,
    32,
    33,
    34,
    35,
    25,
    31,
    55,
    72,
    73,
    74,
    75,
    76,
    36,
    37,
    38,
    39,
    40,
    41,
    56,
    57,
    58,
    59,
    60,
    65,
    66,
    67,
    91,
    106
  },
  _forShaiList = {
    64,
    62,
    63,
    61
  }
}
function Panel_SkkillCommand_ShowAni()
end
function Panel_SkkillCommand_HideAni()
end
function skillCommand:InitForceRideOffTipSlot()
  local slot = {}
  slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBG", Panel_SkillCommand, "ForceRideOffTip_mainBG")
  slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillIcon", slot._mainBG, "ForceRideOffTip_skillIcon")
  slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillName", slot._mainBG, "ForceRideOffTip_skillName")
  slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_SkillCommandBody", slot._mainBG, "ForceRideOffTip_skillCommandBody")
  slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillCommand", slot._mainBG, "ForceRideOffTip_skillCommand")
  slot._skillCommandPlus = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandPlus", slot._skillCommandBody, "ForceRideOffTip_CommandPlus")
  slot._mainBG:SetShow(false)
  slot._skillIcon:SetShow(false)
  slot._skillName:SetShow(false)
  slot._skillCommandBody:SetShow(false)
  slot._skillCommand:SetShow(false)
  local keyCount = 2
  slot._text = {}
  slot._textBG = {}
  local forceRideOffString = {}
  forceRideOffString[0] = keyCustom_GetString_ActionKey(__eActionInputType_MoveBack)
  forceRideOffString[1] = keyCustom_GetString_ActionKey(__eActionInputType_Interaction)
  for i = 0, keyCount - 1 do
    slot._text[i] = nil
    slot._textBg[i] = nil
    local tempControlTextBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_CommandBg", slot._skillCommandBody, "StaticText_CommandBG_Tip_ForceRideOffTip_" .. i)
    tempControlTextBG:SetText(forceRideOffString[i])
    tempControlTextBG:SetSize(tempControlTextBG:GetTextSizeX() + 10, tempControlTextBG:GetSizeY())
    tempControlTextBG:SetPosY(2)
    local tempControlText = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Command", slot._skillCommandBody, "StaticText_Command_Tip_ForceRideOffTip_" .. i)
    tempControlText:SetText(forceRideOffString[i])
    tempControlText:SetSize(tempControlTextBG:GetTextSizeX() + 10, tempControlTextBG:GetSizeY())
    tempControlText:SetShow(false)
    slot._textBG[i] = tempControlTextBG
    slot._text[i] = tempControlText
  end
  self._forceRideOff = slot
end
function skillCommand:Init()
  for i = 0, self.viewableMaxSkillCount - 1 do
    local slot = {}
    slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBG", Panel_SkillCommand, "skillCommand_mainBG_" .. i)
    slot._blueBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBlueBG", slot._mainBG, "skillCommand_blueBG_" .. i)
    slot._progress = {}
    slot._progress[1] = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Progress2_Template", slot._mainBG, "skillCommand_progress1_" .. self.viewableMaxSkillCount)
    slot._progress[2] = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Progress2_Template", slot._mainBG, "skillCommand_progress2_" .. self.viewableMaxSkillCount)
    slot._progress[3] = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Progress2_Template", slot._mainBG, "skillCommand_progress3_" .. self.viewableMaxSkillCount)
    slot._yellowBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillYellowBG", slot._mainBG, "skillCommand_yellowBG_" .. i)
    slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillIcon", slot._mainBG, "skillCommand_skillIcon_" .. i)
    slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillName", slot._mainBG, "skillCommand_skillName_" .. i)
    slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_SkillCommandBody", slot._mainBG, "skillCommand_skillCommandBody_" .. i)
    slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillCommand", slot._mainBG, "skillCommand_skillCommand_" .. i)
    slot._skillNext = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Next", slot._mainBG, "skillCommand_skillNext_" .. self.viewableMaxSkillCount)
    slot._mainBG:SetShow(false)
    slot._blueBG:SetShow(false)
    slot._yellowBG:SetShow(false)
    slot._skillIcon:SetShow(false)
    slot._skillName:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    slot._skillCommand:SetShow(false)
    slot._skillNext:SetShow(false)
    slot._progress[1]:SetShow(false)
    slot._progress[2]:SetShow(false)
    slot._progress[3]:SetShow(false)
    slot._mainBG:addInputEvent("Mouse_LUp", "SkillCommand_Click(" .. i .. ")")
    slot._coolTime = {}
    slot._coolTime[1] = 0
    slot._coolTime[2] = 0
    slot._coolTime[3] = 0
    slot._remainTime = {}
    slot._remainTime[1] = 0
    slot._remainTime[2] = 0
    slot._remainTime[3] = 0
    self._slots[i] = slot
  end
  self._classType = getSelfPlayer():getClassType()
  self._isDrakania = self._classType == __eClassType_Drakania
  SkillCommnad_SetSkillTable(__eClassType_ShyWaman == self._classType)
  Panel_SkillCommand:SetSize(300, 250)
  skillCommand:SkillComboInit()
  skillCommand:InitAttackModeTipSlot()
  skillCommand:InitForceRideOffTipSlot()
  skillCommand:unRenderPanel()
end
function skillCommand:unRenderPanel()
  if nil == Panel_SkillCommand then
    _PA_ASSERT_NAME(false, "Panel_GameTips nil \236\158\133\235\139\136\235\139\164.", "\236\160\149\236\167\128\237\152\156")
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsRemoteInstallMode()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_SkillCommand:SetRenderAndEventHide(true)
  else
    Panel_SkillCommand:SetRenderAndEventHide(false)
  end
end
function skillCommand:InitAttackModeTipSlot()
  local slot = {}
  slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBG", Panel_SkillCommand, "AttackModeTip_mainBG")
  slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillIcon", slot._mainBG, "AttackModeTip_skillIcon")
  slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillName", slot._mainBG, "AttackModeTip_skillName")
  slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_SkillCommandBody", slot._mainBG, "AttackModeTip_skillCommandBody")
  slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillCommand", slot._mainBG, "AttackModeTip_skillCommand")
  slot._mainBG:SetShow(false)
  slot._skillIcon:SetShow(false)
  slot._skillName:SetShow(false)
  slot._skillCommandBody:SetShow(false)
  slot._skillCommand:SetShow(false)
  self._attackModeTipSlot = slot
end
function skillCommand:Open(actorKeyRaw)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if Panel_SimpleBuildMode ~= nil and Panel_SimpleBuildMode:GetShow() == true then
    return
  end
  if false == questList_isClearQuest(21117, 2) and 1 >= getSelfPlayer():get():getLevel() then
    return
  end
  if nil ~= Panel_Cannon and true == Panel_Cannon:GetShow() then
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
  Panel_SkillCommand:SetSize(300, 250)
  if nil ~= actorKeyRaw then
    SkillCommand_SetServantSkill(actorKeyRaw)
  else
    skillCommand:SetSkill()
  end
  skillCommand:SetAttackModeTip()
  skillCommand:SetForceRideOffTip()
  Panel_SkillCommand:SetShow(true)
  if PaGlobalFunc_CollectMiniGame_IsPlaying ~= nil and PaGlobalFunc_CollectMiniGame_IsPlaying() == true then
    PaGlobalFunc_CollectMiniGame_UpdateSkillCommandState(true)
    Panel_SkillCommand:SetShow(false)
  end
end
function skillCommand:getSkillNoFromGroup(skillNo)
  if nil == skillNo then
    return 0
  end
  local skillKey = ToClient_GetTopLevelLearnActiveSkillKey(skillNo)
  return skillKey:getSkillNo()
end
function FromClient_SkillCommandList(skillNo, isAwaken)
  local self = skillCommand
  if isAwaken then
    if 2 ~= self._weaponType then
      return
    end
  elseif 1 == self._weaponType or 0 == self._weaponType then
  else
    return
  end
  if isAwaken == true and self._classType == __eClassType_Drakania then
    local skillCommandWrapper = getSkillCommandStatus(skillNo)
    if skillCommandWrapper ~= nil then
      local isDragonForm = ToClient_isDrakaniaDragonForm()
      if isDragonForm == true and skillCommandWrapper:getExtraParam() == self._eDrakaniaFormType.FORM_NORMAL or isDragonForm == false and skillCommandWrapper:getExtraParam() == self._eDrakaniaFormType.FORM_DRAGON then
        return
      end
    end
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
function FromClient_SkillCommandListonLevelUp(skillNo, isAwaken)
  local self = skillCommand
  if isAwaken then
    if 2 == self._weaponType then
      FromClient_SkillCommandDataSet()
    end
    return
  elseif 1 == self._weaponType or 0 == self._weaponType then
  else
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
      self.lvupSkillCount = self.lvupSkillCount + 1
    end
  else
    table.insert(self.skilldatatable, skillNo)
    self.lvupSkillCount = self.lvupSkillCount + 1
  end
  self.skillCommandShowkeep[self.lvupSkillCount - 1] = true
  self.elapsedTime = 0
end
function FromClient_CheckLevelUpforSkillCommand()
  skillCommand.lvupSkillCount = 0
  SkillCommand_Reset()
end
function FromClient_SkillCommandDataSet()
  SkillCommand_Reset()
  if nil == getSelfPlayer() then
    return
  end
  local pcPosition = getSelfPlayer():get():getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
  local isPlayingSequence = ToClient_isPlayingSequence()
  local isSafeZone = regionInfo:get():isSafeZone()
  if ToClient_HardCoreChannelWithContensOption() == true then
    isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
  end
  if true == isSafeZone and false == isLocalWar and isPlayingSequence == false then
    return
  end
  local self = skillCommand
  if true == skillCommand._isServantRide and nil ~= self._actorKeyRaw then
    self.skillCount = SkillCommand_GetServantSkillCount(self._actorKeyRaw)
  else
    ToClient_RequestCommandList()
    self.skillCount = self.recommandSkillCount + self.lvupSkillCount
  end
  if 0 == self.skillCount then
    return
  end
  if FGlobal_IsChecked_SkillCommand() then
    if true == skillCommand._isServantRide and nil ~= self._actorKeyRaw then
      self:Open(self._actorKeyRaw)
      if true == _ContentsGroup_SkillComboGuide then
        skillCommand:skillComboOpen(false)
      end
    else
      self:Open()
      if true == _ContentsGroup_SkillComboGuide then
        skillCommand:skillComboOpen(true)
      end
    end
  end
  self.lvupSkillCount = 0
end
function SkillCommand_SetSkillShow(skillNo, isShow)
  if false == _ContentsGroup_SkillEffect then
    return
  end
  if nil == skillNo or nil == isShow then
    return
  end
  local self = skillCommand
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
      local skillKey = self:getSkillNoFromGroup(skillNo)
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
function skillCommand:SetAttackModeTip()
  if true == _ContentsGroup_UsePadSnapping then
    self._attackModeTipSlot._mainBG:SetShow(false)
    return
  end
  if true == skillCommand._isServantRide then
    self._attackModeTipSlot._mainBG:SetShow(false)
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
  local pcPosition = selfPlayer:getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
  local isSafeZone = regionInfo:get():isSafeZone()
  if ToClient_HardCoreChannelWithContensOption() == true then
    isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
  end
  if isSafeZone == true and false == isLocalWar then
    self._attackModeTipSlot._mainBG:SetShow(false)
    return
  end
  if false == FGlobal_IsChecked_SkillCommand() then
    self._attackModeTipSlot._mainBG:SetShow(false)
    return
  end
  self._attackModeTipSlot._mainBG:SetPosY(self._slots[0]._mainBG:GetPosY() - self._attackModeTipSlot._mainBG:GetSizeY() - 2)
  self._attackModeTipSlot._mainBG:SetShow(true)
  self._attackModeTipSlot._skillName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ATTACKMODE_CHANGE_DESC"))
  self._attackModeTipSlot._skillName:SetShow(true)
  self._attackModeTipSlot._skillName:SetPosX(self._attackModeTipSlot._skillIcon:GetPosX())
  self.skillNameSizeX = math.max(self.skillNameSizeX, self._attackModeTipSlot._skillName:GetPosX() + self._attackModeTipSlot._skillName:GetTextSizeX())
  local attckModeString = keyCustom_GetString_ActionKey(10)
  if nil == self._attackModeTipSlot._textBG then
    local tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_CommandBg", self._attackModeTipSlot._skillCommandBody, "StaticText_CommandBG_Tip_AttackModeTip")
    tempControl:SetText(attckModeString)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
    tempControl:SetPosY(2)
    self._attackModeTipSlot._textBG = tempControl
  else
    self._attackModeTipSlot._textBG:SetText(attckModeString)
    self._attackModeTipSlot._textBG:SetSize(self._attackModeTipSlot._textBG:GetTextSizeX() + 10, self._attackModeTipSlot._textBG:GetSizeY())
    self._attackModeTipSlot._textBG:SetPosY(2)
  end
  if nil == self._attackModeTipSlot._text then
    local tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Command", self._attackModeTipSlot._skillCommandBody, "StaticText_Command_Tip_AttackModeTip")
    tempControl:SetText(attckModeString)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
    tempControl:SetShow(true)
    self._attackModeTipSlot._text = tempControl
  else
    self._attackModeTipSlot._text:SetText(attckModeString)
    self._attackModeTipSlot._text:SetSize(self._attackModeTipSlot._text:GetTextSizeX() + 10, self._attackModeTipSlot._text:GetSizeY())
    self._attackModeTipSlot._text:SetShow(true)
  end
  local tempPosX = self._attackModeTipSlot._skillCommandBody:GetSizeX()
  self._attackModeTipSlot._text:SetPosX(tempPosX)
  self._attackModeTipSlot._textBG:SetPosX(tempPosX)
  self._attackModeTipSlot._skillCommandBody:SetPosX(self.skillNameSizeX)
  self._attackModeTipSlot._skillCommandBody:SetShow(true)
  self._maxBgSizeX = math.max(self._maxBgSizeX, self.skillNameSizeX + self._attackModeTipSlot._skillCommandBody:GetSizeX())
  self._attackModeTipSlot._mainBG:SetSize(self._maxBgSizeX, self._attackModeTipSlot._skillCommandBody:GetSizeY())
end
function skillCommand:SetForceRideOffTip()
  if true == _ContentsGroup_UsePadSnapping then
    self._forceRideOff._mainBG:SetShow(false)
    return
  end
  if false == skillCommand._isServantRide then
    self._forceRideOff._mainBG:SetShow(false)
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
  local pcPosition = selfPlayer:getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local isSafeZone = regionInfo:get():isSafeZone()
  if ToClient_HardCoreChannelWithContensOption() == true then
    isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
  end
  if false == FGlobal_IsChecked_SkillCommand() then
    self._forceRideOff._mainBG:SetShow(false)
    return
  end
  if isSafeZone == true then
    SkillCommand_Reset()
    self._maxBgSizeX = 0
    self.skillNameSizeX = 0
  end
  if skillCommand._isForceRideOffServant == false then
    self._forceRideOff._mainBG:SetShow(false)
    return
  end
  local startPosY = self._slots[0]._mainBG:GetPosY()
  if self._attackModeTipSlot._mainBG ~= nil and self._attackModeTipSlot._mainBG:GetShow() == true then
    startPosY = self._attackModeTipSlot._mainBG:GetPosY()
  end
  self._forceRideOff._mainBG:SetPosY(startPosY - self._forceRideOff._mainBG:GetSizeY() - 2)
  self._forceRideOff._mainBG:SetShow(true)
  self._forceRideOff._skillName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VEHICLE_RIDE_IMMEDIATELY_OFF"))
  self._forceRideOff._skillName:SetShow(true)
  self._forceRideOff._skillName:SetPosX(self._forceRideOff._skillIcon:GetPosX())
  self.skillNameSizeX = math.max(self.skillNameSizeX, self._forceRideOff._skillName:GetPosX() + self._forceRideOff._skillName:GetTextSizeX() + 20)
  local keyCount = 2
  for i = 0, keyCount - 1 do
    self._forceRideOff._textBG[i]:SetSize(self._forceRideOff._textBG[i]:GetTextSizeX() + 10, self._forceRideOff._textBG[i]:GetSizeY())
    self._forceRideOff._textBG[i]:SetPosY(2)
    self._forceRideOff._text[i]:SetSize(self._forceRideOff._text[i]:GetTextSizeX() + 10, self._forceRideOff._text[i]:GetSizeY())
    self._forceRideOff._text[i]:SetPosY(2)
  end
  local skillCommandSizeX = 0
  self._forceRideOff._text[0]:SetPosX(0)
  self._forceRideOff._textBG[0]:SetPosX(0)
  skillCommandSizeX = skillCommandSizeX + self._forceRideOff._text[0]:GetSizeX() + 5
  self._forceRideOff._skillCommandPlus:SetPosX(self._forceRideOff._text[0]:GetPosX() + self._forceRideOff._text[0]:GetSizeX() + 5)
  skillCommandSizeX = skillCommandSizeX + self._forceRideOff._skillCommandPlus:GetSizeX() + 5
  self._forceRideOff._text[1]:SetPosX(self._forceRideOff._skillCommandPlus:GetPosX() + self._forceRideOff._skillCommandPlus:GetSizeX() + 5)
  self._forceRideOff._textBG[1]:SetPosX(self._forceRideOff._skillCommandPlus:GetPosX() + self._forceRideOff._skillCommandPlus:GetSizeX() + 5)
  skillCommandSizeX = skillCommandSizeX + self._forceRideOff._text[1]:GetSizeX() + 5
  self._forceRideOff._skillCommandBody:SetPosX(self.skillNameSizeX)
  self._forceRideOff._skillCommandBody:SetShow(true)
  self._forceRideOff._skillCommandBody:SetSize(skillCommandSizeX, self._forceRideOff._skillCommandBody:GetSizeY())
  self._maxBgSizeX = math.max(self._maxBgSizeX, self.skillNameSizeX + self._forceRideOff._skillCommandBody:GetSizeX() + 20)
  self._forceRideOff._mainBG:SetSize(self._maxBgSizeX, self._forceRideOff._skillCommandBody:GetSizeY())
end
function skillCommand:SetSkill()
  self._maxBgSizeX = 0
  self.skillNameSizeX = 0
  for i = 0, self.skillCount - 1 do
    if nil ~= self.skilldatatable[i + 1] then
      local skillWrapper = getSkillCommandStatus(self.skilldatatable[i + 1])
      local skillKey = self:getSkillNoFromGroup(self.skilldatatable[i + 1])
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
    command = SkillCommand_SearchCommand(command, i, self.skilldatatable[i + 1])
    slot._skillCommandBody:SetPosX(self.skillNameSizeX)
    self._slots[i]._mainBG:SetPosY(0 + (i + self.sizeUpCount) * 30 + i * 2)
    if Panel_SkillCommand:GetSizeX() < slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() then
      if slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() > 300 then
        Panel_SkillCommand:SetSize(400, 250)
      end
      isDoubleSize = skillCommand:CommandControl_RePos(i)
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
    slot._progress[1]:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._progress[2]:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._progress[3]:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
  end
  for i = 0, self.skillCount - 1 do
    if self.skillCommandShowkeep[i] then
      self._slots[i]._blueBG:SetShow(true)
    end
  end
end
function skillCommand:CommandControl_RePos(index)
  local slot = self._slots[index]
  local basePosX = slot._skillCommandBody:GetPosX()
  local tempPosX = 5
  local skillCommandSizeX = Panel_SkillCommand:GetSizeX() - slot._skillCommandBody:GetPosX()
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
    if controlPos > Panel_SkillCommand:GetSizeX() and false == continue then
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
function SkillCommand_StringMatchForConvert(commandIndex, stringIndex, plusIndex)
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
function skillCommand:commandControlRePos(controlType, text, uiIndex)
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
function skillCommand:commandControlSet(controlType, text, uiIndex)
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
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandLMouse", self._slots[uiIndex]._skillCommandBody, "Static_CommandLMouse_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    elseif RBstring == text then
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandRMouse", self._slots[uiIndex]._skillCommandBody, "Static_CommandRMouse_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    else
      tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_CommandBg", self._slots[uiIndex]._skillCommandBody, "StaticText_CommandBG_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
      tempControl:SetText(text)
      tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
      tempControl:SetPosY(2)
    end
  elseif 1 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Command", self._slots[uiIndex]._skillCommandBody, "StaticText_Command_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
  elseif 2 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandPlus", self._slots[uiIndex]._skillCommandBody, "Static_CommandPlus_" .. uiIndex .. "_" .. self.skillCommand[uiIndex])
    tempControl:SetPosY(6)
  end
  tempControl:SetShow(true)
  local tempPosX = self._slots[uiIndex]._skillCommandBody:GetSizeX()
  tempControl:SetPosX(tempPosX)
  self._slots[uiIndex]._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX() + 5, self._slots[uiIndex]._skillCommandBody:GetSizeY())
  self.skillCommandControl[uiIndex][self.skillCommand[uiIndex]] = tempControl
  self.skillCommand[uiIndex] = self.skillCommand[uiIndex] + 1
end
function SkillCommand_RePosCommand(command, index, skillNo)
  local self = skillCommand
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert(commandIndex, stringIndex, plusIndex)
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
  command = SkillCommand_RePosCommand(command, index, skillNo)
end
function SkillCommand_SearchCommand(command, index, skillNo)
  local self = skillCommand
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local swapIndex = SkillCommand_StringMatchForConvert(commandIndex, stringIndex, plusIndex)
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
  command = SkillCommand_SearchCommand(command, index, skillNo)
end
function SkillCommand_UpdateTime(updateTime)
  local self = skillCommand
  local weaponType
  if 0 == self._weaponType then
    weaponType = 1
  else
    weaponType = self._weaponType
  end
  if false == self._isDrakania then
    if 0 < self.skillCount then
      for i = 0, self.skillCount - 1 do
        if nil ~= self._slots[i]._coolTime[weaponType] then
          if 0 < self._slots[i]._coolTime[1] then
            self._slots[i]._remainTime[1] = self._slots[i]._remainTime[1] - updateTime
            self._slots[i]._progress[1]:SetProgressRate(self._slots[i]._remainTime[1] / self._slots[i]._coolTime[1] * 100)
          end
          if 0 < self._slots[i]._coolTime[2] then
            self._slots[i]._remainTime[2] = self._slots[i]._remainTime[2] - updateTime
            self._slots[i]._progress[2]:SetProgressRate(self._slots[i]._remainTime[2] / self._slots[i]._coolTime[2] * 100)
          end
          if 1 == weaponType then
            self._slots[i]._progress[1]:SetShow(true)
            self._slots[i]._progress[2]:SetShow(false)
          elseif 2 == weaponType then
            self._slots[i]._progress[1]:SetShow(false)
            self._slots[i]._progress[2]:SetShow(true)
          end
        end
      end
    end
  elseif 0 < self.skillCount then
    for i = 0, self.skillCount - 1 do
      if nil ~= self._slots[i]._coolTime[weaponType] then
        if 0 < self._slots[i]._coolTime[3] then
          self._slots[i]._remainTime[3] = self._slots[i]._remainTime[3] - updateTime
          self._slots[i]._progress[3]:SetProgressRate(self._slots[i]._remainTime[3] / self._slots[i]._coolTime[3] * 100)
          if 0 == i or 1 == i then
            self._slots[i]._remainTime[2] = self._slots[i]._remainTime[2] - updateTime
            self._slots[i]._progress[2]:SetProgressRate(self._slots[i]._remainTime[2] / self._slots[i]._coolTime[2] * 100)
          end
        end
        if 0 < self._slots[i]._coolTime[2] then
          self._slots[i]._remainTime[2] = self._slots[i]._remainTime[2] - updateTime
          self._slots[i]._progress[2]:SetProgressRate(self._slots[i]._remainTime[2] / self._slots[i]._coolTime[2] * 100)
          if 0 == i or 1 == i then
            self._slots[i]._remainTime[3] = self._slots[i]._remainTime[3] - updateTime
            self._slots[i]._progress[3]:SetProgressRate(self._slots[i]._remainTime[3] / self._slots[i]._coolTime[3] * 100)
          end
        end
        if 0 < self._slots[i]._coolTime[1] then
          self._slots[i]._remainTime[1] = self._slots[i]._remainTime[1] - updateTime
          self._slots[i]._progress[1]:SetProgressRate(self._slots[i]._remainTime[1] / self._slots[i]._coolTime[1] * 100)
        end
        if 2 == weaponType then
          local isDragonForm = ToClient_isDrakaniaDragonForm()
          if isDragonForm == true then
            self._slots[i]._progress[3]:SetShow(true)
            self._slots[i]._progress[2]:SetShow(false)
            self._slots[i]._progress[1]:SetShow(false)
          else
            self._slots[i]._progress[3]:SetShow(false)
            self._slots[i]._progress[2]:SetShow(true)
            self._slots[i]._progress[1]:SetShow(false)
          end
        else
          self._slots[i]._progress[3]:SetShow(false)
          self._slots[i]._progress[2]:SetShow(false)
          self._slots[i]._progress[1]:SetShow(true)
        end
      end
    end
  end
  if true == _ContentsGroup_SkillComboGuide then
    skillCommand:updatePerFrame(updateTime)
  end
  if not self.isLevelUp then
    return
  end
  if nil == self.skilldatatable then
    SkillCommand_Reset()
    return
  end
  self.elapsedTime = self.elapsedTime + updateTime
  if self.elapsedTime > 30 then
    self.lvupSkillCount = 0
    SkillCommand_Reset()
    FromClient_SkillCommandDataSet()
    self.elapsedTime = 0
    self.isLevelUp = false
    for i = 0, self.skillCount - 1 do
      self._slots[i]._blueBG:SetShow(false)
    end
  end
end
function SkillCommand_Reset()
  local self = skillCommand
  if 0 < self.skillCount then
    for i = 0, self.skillCount - 1 do
      self._slots[i]._mainBG:SetShow(false)
      self._slots[i]._skillIcon:SetShow(false)
      self._slots[i]._skillName:SetShow(false)
      self._slots[i]._skillCommand:SetShow(false)
      self._slots[i]._skillCommandBody:SetShow(false)
      self._slots[i]._skillCommandBody:SetSize(5, 30)
      self._slots[i]._progress[1]:SetShow(false)
      self._slots[i]._progress[2]:SetShow(false)
      self._slots[i]._progress[3]:SetShow(false)
      self._slots[i]._progress[1]:SetProgressRate(0)
      self._slots[i]._progress[2]:SetProgressRate(0)
      self._slots[i]._progress[3]:SetProgressRate(0)
      if false == Panel_SkillCommand:GetShow() then
        self._slots[i]._coolTime[1] = 0
        self._slots[i]._coolTime[2] = 0
        self._slots[i]._coolTime[3] = 0
        self._slots[i]._remainTime[1] = 0
        self._slots[i]._remainTime[2] = 0
        self._slots[i]._remainTime[3] = 0
      end
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
function SkillCommand_Click(index)
  if _ContentsGroup_ShowOtherClassSkill == true then
    PaGlobalFunc_SkillGroup_All_Open()
  elseif ToClient_isConsole() == false then
    HandleMLUp_SkillWindow_OpenForLearn()
  else
    PaGlobalFunc_Skill_Open()
  end
end
function FGlobal_SkillCommand_ResetPosition()
  local scrX = getScreenSizeX()
  local scrY = getScreenSizeY()
  local relativePosX = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionX)
  local relativePosY = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, 0, CppEnums.PanelSaveType.PanelSaveType_RelativePositionY)
  if relativePosX == -1 and relativePosY == -1 then
    local initPosX = scrX / 2 * 1.2
    local initPosY = scrY / 2 * 0.85
    Panel_SkillCommand:SetPosX(initPosX)
    Panel_SkillCommand:SetPosY(initPosY)
    changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, false, true, false)
    FGlobal_InitPanelRelativePos(Panel_SkillCommand, initPosX, initPosY)
  elseif relativePosX == 0 and relativePosY == 0 then
    Panel_SkillCommand:SetPosX(scrX / 2 * 1.2)
    Panel_SkillCommand:SetPosY(scrY / 2 * 0.85)
  elseif true == _ContentsGroup_RenewUI then
    Panel_SkillCommand:SetRelativePosX(relativePosX)
    Panel_SkillCommand:SetRelativePosY(relativePosY)
    Panel_SkillCommand:SetPosX(getOriginScreenSizeX() * relativePosX - Panel_SkillCommand:GetSizeX() / 2)
    Panel_SkillCommand:SetPosY(getOriginScreenSizeY() * relativePosY - Panel_SkillCommand:GetSizeY() / 2)
  else
    Panel_SkillCommand:SetRelativePosX(relativePosX)
    Panel_SkillCommand:SetRelativePosY(relativePosY)
    Panel_SkillCommand:SetPosX(scrX * relativePosX - Panel_SkillCommand:GetSizeX() / 2)
    Panel_SkillCommand:SetPosY(scrY * relativePosY - Panel_SkillCommand:GetSizeY() / 2)
  end
  FGlobal_PanelRepostionbyScreenOut(Panel_SkillCommand)
end
function ScreenReisze_RePosCommand()
  changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, false, true, false)
end
function PaGlobal_SkillCommand_CheckRegion(isShow)
  if nil == Panel_SkillCommand or nil == isShow then
    return
  end
  if ToClient_isPlayingSequence() == true then
    return
  end
  if false == FGlobal_IsChecked_SkillCommand() then
    return
  end
  if true == isShow then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local nowRegionInfo = selfPlayer:getCurrentRegionInfo()
    if nil ~= nowRegionInfo then
      local isSafeZone = nowRegionInfo:get():isSafeZone()
      local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
      if ToClient_HardCoreChannelWithContensOption() == true then
        isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
      end
      if isSafeZone == false or true == isLocalWar then
        FromClient_SkillCommandDataSet()
        if true == _ContentsGroup_SkillComboGuide then
          skillCommand:skillComboOpen(true)
        end
      elseif true == _ContentsGroup_SkillComboGuide then
        skillCommand:skillComboOpen(false)
      end
    end
  else
    Panel_SkillCommand:SetShow(false)
    if true == _ContentsGroup_SkillComboGuide then
      skillCommand:skillComboOpen(false)
    end
    if PaGlobalFunc_CollectMiniGame_IsPlaying ~= nil and PaGlobalFunc_CollectMiniGame_IsPlaying() == true then
      PaGlobalFunc_CollectMiniGame_UpdateSkillCommandState(false)
    end
  end
end
function PaGlobal_SkillCommand_HardCoreChangeRegion(prevHardCoreRegionType, hardCoreRegionType)
  PaGlobal_SkillCommand_CheckRegion(true)
end
function FromClient_RegionChange(isSafeZone)
  if ToClient_isPlayingSequence() == true then
    return
  end
  if not FGlobal_IsChecked_SkillCommand() then
    Panel_SkillCommand:SetShow(false)
    if PaGlobalFunc_CollectMiniGame_IsPlaying ~= nil and PaGlobalFunc_CollectMiniGame_IsPlaying() == true then
      PaGlobalFunc_CollectMiniGame_UpdateSkillCommandState(false)
    end
    return
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
  end
  local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
  if true == isLocalWar then
    FromClient_SkillCommandDataSet()
  elseif isSafeZone == false and _ContentsGroup_UsePadSnapping == true then
    FromClient_SkillCommandDataSet()
  else
    Panel_SkillCommand:SetShow(false)
    if PaGlobalFunc_CollectMiniGame_IsPlaying ~= nil and PaGlobalFunc_CollectMiniGame_IsPlaying() == true then
      PaGlobalFunc_CollectMiniGame_UpdateSkillCommandState(false)
    end
  end
end
function FGlobal_SkillCommand_Show(isShow)
  if isShow then
    FromClient_SkillCommandDataSet()
  end
end
function SkillCommand_LimitLevelCheck()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if not FGlobal_IsChecked_SkillCommand() then
    return
  end
  skillCommand.isLevelUp = true
  FromClient_SkillCommandDataSet()
end
function FromClient_EventSelfPlayerUsedSkill_ForSkillCommand()
  if not Panel_SkillCommand:GetShow() then
    return
  end
  if false == _ContentsGroup_SkillEffect then
    return
  end
  if true == skillCommand._isServantRide and nil ~= skillCommand._actorKeyRaw then
    return
  end
  local self = skillCommand
  local skillWrapper = selfPlayerUsedSkillFront()
  local weaponType = self._weaponType
  if 0 == weaponType then
    weaponType = 1
  end
  if 0 == self._weaponType then
    self._weaponType = 1
  end
  if nil ~= skillWrapper then
    local skillNo = skillWrapper:getSkillNo()
    for i = 0, self.skillCount - 1 do
      if nil ~= self.skilldatatable[i + 1] then
        local skillKey = self:getSkillNoFromGroup(self.skilldatatable[i + 1])
        if skillNo == skillKey then
          local isShow = true
          if true == isShow then
            self._slots[i]._skillIcon:EraseAllEffect()
            if nil == self._slots[i].isDoubleSize or false == self._slots[i].isDoubleSize then
              self._slots[i]._skillIcon:AddEffect("fUI_SkillCommand_01A", false, 125, 0)
            else
              self._slots[i]._skillIcon:AddEffect("fUI_SkillCommand_01B", false, 125, 0)
            end
            SkillCommand_UseEffect(i, true)
            local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
            local remainTime = skillStaticWrapper:get()._reuseCycle / 1000
            if remainTime > 0 then
              if true == self._isDrakania then
                if 2 == self._weaponType then
                  do
                    local isDragonForm = ToClient_isDrakaniaDragonForm()
                    if true == isDragonForm then
                      self._slots[i]._coolTime[3] = remainTime
                      self._slots[i]._remainTime[3] = remainTime
                      self._slots[i]._progress[3]:SetProgressRate(100)
                      self._slots[i]._progress[3]:SetShow(true)
                      if 0 == i or 1 == i then
                        self._slots[i]._coolTime[2] = remainTime
                        self._slots[i]._remainTime[2] = remainTime
                        self._slots[i]._progress[2]:SetProgressRate(100)
                      end
                      break
                    end
                    self._slots[i]._coolTime[2] = remainTime
                    self._slots[i]._remainTime[2] = remainTime
                    self._slots[i]._progress[2]:SetProgressRate(100)
                    self._slots[i]._progress[2]:SetShow(true)
                    if 0 == i or 1 == i then
                      self._slots[i]._coolTime[3] = remainTime
                      self._slots[i]._remainTime[3] = remainTime
                      self._slots[i]._progress[3]:SetProgressRate(100)
                    end
                  end
                  break
                end
                self._slots[i]._coolTime[self._weaponType] = remainTime
                self._slots[i]._remainTime[self._weaponType] = remainTime
                self._slots[i]._progress[self._weaponType]:SetProgressRate(100)
                self._slots[i]._progress[self._weaponType]:SetShow(true)
                break
              end
              self._slots[i]._coolTime[weaponType] = remainTime
              self._slots[i]._remainTime[weaponType] = remainTime
              self._slots[i]._progress[weaponType]:SetProgressRate(100)
              self._slots[i]._progress[weaponType]:SetShow(true)
            end
            break
          end
        end
      else
      end
    end
  end
end
function SkillCommand_UseEffect(index, isUse)
  local control
  control = skillCommand._slots[index]._blueBG
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
function FromClient_SkillCommandWeaponType(weaponType)
  local self = skillCommand
  if self._weaponType == weaponType or 0 == weaponType then
    self._weaponType = weaponType
    return
  else
    self._weaponType = weaponType
    if Panel_SkillCommand:GetShow() == true then
      FromClient_SkillCommandDataSet()
    end
  end
end
function FromClient_ShowSequenceSkillCommand(isShow)
  if ToClient_isPlayingSequence() == false then
    return
  end
  if getSelfPlayer() == nil then
    return
  end
  local self = skillCommand
  if FGlobal_IsChecked_SkillCommand() == false then
    Panel_SkillCommand:SetShow(false)
    if _ContentsGroup_SkillComboGuide == true then
      self:skillComboOpen(false)
    end
    return
  end
  if isShow == true then
    SkillCommand_Reset()
    ToClient_RequestCommandList()
    self.skillCount = self.recommandSkillCount + self.lvupSkillCount
    if self.skillCount == 0 then
      return
    end
    Panel_SkillCommand:SetShow(true)
    self.lvupSkillCount = 0
    self:Open()
    self:SkillComboSetting()
    self:SetAttackModeTip()
    if _ContentsGroup_SkillComboGuide == true then
      self:skillComboOpen(true)
    end
  else
    Panel_SkillCommand:SetShow(false)
    if _ContentsGroup_SkillComboGuide == true then
      self:skillComboOpen(false)
    end
  end
end
function FormClient_ResetSkillCommandFromSequence()
  local self = skillCommand
  if FGlobal_IsChecked_SkillCommand() == true then
    Panel_SkillCommand:SetShow(true)
    self:SkillComboSetting()
    self:SetAttackModeTip()
    if _ContentsGroup_SkillComboGuide == true then
      self:skillComboOpen(true)
    end
  else
    Panel_SkillCommand:SetShow(false)
    if _ContentsGroup_SkillComboGuide == true then
      self:skillComboOpen(false)
    end
  end
end
function SkillCommand_SetServantSkill(actorKeyRaw)
  local self = skillCommand
  if nil == actorKeyRaw then
    return
  end
  self._maxBgSizeX = 0
  self.skillNameSizeX = 0
  local servantSkillindex = SkillCommand_GetServantSkillTable(actorKeyRaw)
  local servantSkillCount = SkillCommand_GetServantSkillCount(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  self.skillNameSizeX = 0
  for i = 0, servantSkillCount - 1 do
    local skillWrapper = servantWrapper:getSkill(servantSkillindex[i + 1])
    local iconPath = skillWrapper:getIconPath()
    local name = skillWrapper:getName()
    local slot = self._slots[i]
    slot._skillIcon:ChangeTextureInfoNameAsync("Icon/" .. iconPath)
    slot._skillName:SetText(name)
    self.skillNameSizeX = math.max(self.skillNameSizeX, slot._skillName:GetPosX() + slot._skillName:GetTextSizeX())
  end
  local maxBgSizeX = 0
  for i = 0, servantSkillCount - 1 do
    local skillWrapper = servantWrapper:getSkill(servantSkillindex[i + 1])
    local command = skillWrapper:getDescription()
    local slot = self._slots[i]
    local isDoubleSize = false
    self.skillCommand[i] = 0
    self.skillCommandControl[i] = {}
    skillCommand:commandControlSet(1, command, i)
    slot._skillCommandBody:SetPosX(self.skillNameSizeX)
    self._slots[i]._mainBG:SetPosY(0 + (i + self.sizeUpCount) * 30 + i * 2)
    if Panel_SkillCommand:GetSizeX() < slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() and slot._skillCommandBody:GetPosX() + slot._skillCommandBody:GetSizeX() > 400 then
      Panel_SkillCommand:SetSize(400, 250)
      self.skillCommandControl[i][self.skillCommand[i] - 1]:SetSize(300, 20)
      self.skillCommandControl[i][self.skillCommand[i] - 1]:SetTextMode(__eTextMode_AutoWrap)
      self.skillCommandControl[i][self.skillCommand[i] - 1]:SetText(command)
      self.skillCommandControl[i][self.skillCommand[i] - 1]:SetSpanSize(4, 10)
      self._slots[i]._skillCommandBody:SetSize(310, 50)
      isDoubleSize = true
    end
    if true == isDoubleSize then
      slot._skillName:SetPosY(12)
      slot._skillIcon:SetPosY(14)
      self.sizeUpCount = self.sizeUpCount + 0.69
    else
      slot._skillIcon:SetPosY(2)
      slot._skillName:SetPosY(0)
    end
    self._maxBgSizeX = math.max(self._maxBgSizeX, self.skillNameSizeX + slot._skillCommandBody:GetSizeX())
  end
  for i = 0, servantSkillCount - 1 do
    local slot = self._slots[i]
    slot._mainBG:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
    slot._blueBG:SetSize(self._maxBgSizeX, slot._skillCommandBody:GetSizeY())
  end
  for i = 0, servantSkillCount - 1 do
    if self.skillCommandShowkeep[i] then
      self._slots[i]._blueBG:SetShow(true)
    end
  end
end
function PaGlobal_SkillCommand_PlayerRideOn(actorKeyRaw)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  if selfPlayer == nil then
    return
  end
  local pcPosition = selfPlayer:getPosition()
  local regionInfo = getRegionInfoByPosition(pcPosition)
  local servantWrapper
  if nil ~= PaGlobal_ServantSummonBoss_GetShow and true == PaGlobal_ServantSummonBoss_GetShow() then
    return
  end
  if nil ~= skillCommand._actorKeyRaw then
    servantWrapper = getServantInfoFromActorKey(skillCommand._actorKeyRaw)
  end
  skillCommand._isServantRide = true
  if nil == actorKeyRaw then
    if nil == skillCommand._actorKeyRaw or nil == servantWrapper then
      skillCommand._isServantRide = false
      skillCommand._isForceRideOffServant = false
      return
    end
  else
    skillCommand._actorKeyRaw = actorKeyRaw
  end
  if servantWrapper ~= nil and servantWrapper:getServantType() == __eServantTypeVehicle then
    skillCommand._isForceRideOffServant = true
  end
  if true == FGlobal_IsChecked_SkillCommand() then
    SkillCommand_Reset()
    skillCommand.skillCount = SkillCommand_GetServantSkillCount(skillCommand._actorKeyRaw)
    local isSafeZone = regionInfo:get():isSafeZone()
    if ToClient_HardCoreChannelWithContensOption() == true then
      isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
    end
    if false == isSafeZone then
      skillCommand:Open(skillCommand._actorKeyRaw)
      if true == _ContentsGroup_SkillComboGuide then
        skillCommand:skillComboOpen(false)
      end
    elseif isSafeZone == true and _ContentsGroup_UsePadSnapping == false then
      skillCommand:Open(skillCommand._actorKeyRaw)
    end
  end
end
function PaGlobal_SkillCommand_PlayerRideOff()
  local selfPlayer = getSelfPlayer()
  skillCommand._isServantRide = false
  skillCommand._isForceRideOffServant = false
  skillCommand._actorKeyRaw = nil
  if nil ~= selfPlayer then
    local nowRegionInfo = selfPlayer:getCurrentRegionInfo()
    FromClient_RegionChange(nowRegionInfo:get():isSafeZone())
  end
end
function SkillCommand_GetServantSkillCount(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return 0
  end
  local returnValue = 0
  for _, value in ipairs(servantSkillList._commonList) do
    local skillWrapper = servantWrapper:getSkill(value)
    if nil ~= skillWrapper and returnValue < 10 then
      returnValue = returnValue + 1
    end
  end
  return returnValue
end
function SkillCommand_GetServantSkillTable(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  local returnSkillIndex = {}
  local limitCount = 0
  for _, value in ipairs(servantSkillList._commonList) do
    local skillWrapper = servantWrapper:getSkill(value)
    if nil ~= skillWrapper and limitCount < 10 then
      table.insert(returnSkillIndex, value)
      limitCount = limitCount + 1
    end
  end
  return returnSkillIndex
end
function SkillCommand_ServantInfoUpdate()
  if nil ~= skillCommand._actorKeyRaw then
    PaGlobal_SkillCommand_PlayerRideOn()
  end
end
function SkillCommnad_SetSkillTable(isShai)
  if true == isShai then
    for _, value in ipairs(servantSkillList._forShaiList) do
      table.insert(servantSkillList._commonList, value)
    end
  end
end
function skillCommand:SkillComboInit()
  if false == _ContentsGroup_SkillComboGuide then
    return
  end
  self._comboTitle = UI.getChildControl(Panel_SkillCommand, "StaticText_ComboTitle")
  self._comboTitle:SetShow(false)
  local slot = {}
  slot._mainBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_ComboBg", Panel_SkillCommand, "skillCommand_mainBG_" .. self.viewableMaxSkillCount)
  slot._blueBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillBlueBG", slot._mainBG, "skillCommand_blueBG_" .. self.viewableMaxSkillCount)
  slot._yellowBG = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillYellowBG", slot._mainBG, "skillCommand_yellowBG_" .. self.viewableMaxSkillCount)
  slot._skillIcon = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_C_SkillIcon", slot._mainBG, "skillCommand_skillIcon_" .. self.viewableMaxSkillCount)
  slot._skillName = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillName", slot._mainBG, "skillCommand_skillName_" .. self.viewableMaxSkillCount)
  slot._skillCommandBody = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_SkillCommandBody", slot._mainBG, "skillCommand_skillCommandBody_" .. self.viewableMaxSkillCount)
  slot._skillCommand = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_C_SkillCommand", slot._mainBG, "skillCommand_skillCommand_" .. self.viewableMaxSkillCount)
  slot._skillNext = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Next", slot._mainBG, "skillCommand_skillNext_" .. self.viewableMaxSkillCount)
  slot._mainBG:SetShow(false)
  slot._blueBG:SetShow(false)
  slot._yellowBG:SetShow(false)
  slot._skillIcon:SetShow(false)
  slot._skillName:SetShow(false)
  slot._skillCommandBody:SetShow(false)
  slot._skillCommand:SetShow(false)
  slot._skillNext:SetShow(false)
  self._comboSlot = slot
  self._comboSlotIndex = self.viewableMaxSkillCount + 1
  self._skillComboMaxBgSizeX = self._comboSlot._mainBG:GetSizeX()
  for controlType = 0, self._skillComboComtrolTypeCount - 1 do
    self._skillComboControl[controlType] = {}
    if 3 == controlType then
      for ii = 0, self._skillComboNextIconCount - 1 do
        skillCommand:comboControlInit(controlType, self._comboSlotIndex, ii)
      end
    else
      for ii = 0, self._skillComboControlIconCount - 1 do
        skillCommand:comboControlInit(controlType, self._comboSlotIndex, ii)
      end
    end
  end
end
function skillCommand:comboControlInit(controlType, uiIndex, controlIndex)
  if nil == self._comboSlot then
    return
  end
  local slot = self._comboSlot
  local tempControl
  if 0 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_CommandBg", slot._skillCommandBody, "StaticText_CommandBG_" .. uiIndex .. "_" .. controlIndex)
  elseif 1 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Command", slot._skillCommandBody, "StaticText_Command_" .. uiIndex .. "_" .. controlIndex)
  elseif 2 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandPlus", slot._skillCommandBody, "Static_CommandPlus_" .. uiIndex .. "_" .. controlIndex)
  elseif 3 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "StaticText_Next", slot._skillCommandBody, "Static_CommandNext_" .. uiIndex .. "_" .. controlIndex)
  elseif 4 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandLMouse", slot._skillCommandBody, "Static_CommandLMouse_" .. uiIndex .. "_" .. controlIndex)
  elseif 5 == controlType then
    tempControl = UI.createAndCopyBasePropertyControl(Panel_SkillCommand, "Static_CommandRMouse", slot._skillCommandBody, "Static_CommandRMouse_" .. uiIndex .. "_" .. controlIndex)
  end
  if nil == tempControl then
    self._skillComboControl[controlType][controlIndex] = nil
  else
    tempControl:SetShow(false)
    self._skillComboControl[controlType][controlIndex] = tempControl
  end
end
function skillCommand:SkillComboSetting()
  local option = true
  if true == _ContentsGroup_NewUI_GameOption_All then
    if PaGlobal_GameOption_All_GetSkillComboSetting == nil then
      return
    end
    option = PaGlobal_GameOption_All_GetSkillComboSetting()
    if nil ~= option and false == option then
      return
    end
  else
    if FGlobal_IsChecked_GetSkillComboSetting == nil then
      return
    end
    option = FGlobal_IsChecked_GetSkillComboSetting()
    if nil ~= option and false == option then
      return
    end
  end
  if nil == self._comboSlot then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local nowRegionInfo = selfPlayer:getCurrentRegionInfo()
  local isSafeZone = nowRegionInfo:get():isSafeZone()
  if ToClient_HardCoreChannelWithContensOption() == true then
    isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
  end
  local comboListSize = Toclient_getLearnSkillComboListCount()
  local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
  local slot = self._comboSlot
  if comboListSize <= 0 or true == isSafeZone and false == isLocalWar or true == skillCommand._isServantRide then
    slot._mainBG:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    self._comboTitle:SetShow(false)
    return
  end
  if comboListSize <= self._skillComboShowIndex then
    self._skillComboShowIndex = 0
  end
  if -1 == self._curComboType then
    skillCommand:setSkillComboType()
  end
  local index = 0
  local isTypeFind = false
  while comboListSize > index do
    index = index + 1
    local comboType = Toclient_getLearnSkillComboType(self._skillComboShowIndex)
    if comboType == self._curComboType then
      isTypeFind = true
      index = comboListSize
    else
      self._skillComboShowIndex = self._skillComboShowIndex + 1
      if comboListSize <= self._skillComboShowIndex then
        self._skillComboShowIndex = 0
      end
    end
  end
  if false == isTypeFind then
    slot._mainBG:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    self._comboTitle:SetShow(false)
    return
  end
  for controlType = 0, self._skillComboComtrolTypeCount - 1 do
    if 3 == controlType then
      for ii = 0, self._skillComboNextIconCount - 1 do
        skillCommand:comboControlHide(controlType, ii)
      end
    else
      for ii = 0, self._skillComboControlIconCount - 1 do
        skillCommand:comboControlHide(controlType, ii)
      end
    end
  end
  local comboCount = Toclient_getSkillComboListCount(self._skillComboShowIndex)
  self._skillComboLineCount = 1
  self._skillComboBgSize = 0
  self._comboTitle:SetShow(true)
  slot._mainBG:SetShow(true)
  slot._skillCommandBody:SetShow(true)
  slot._skillCommandBody:SetSize(0, slot._skillCommandBody:GetSizeY())
  slot._skillCommandBody:SetPosX(0)
  local command = ""
  for jj = 0, comboCount - 1 do
    local tmpCommand = Toclient_getLearnSkillComboListCommand(self._skillComboShowIndex, jj)
    local skillNo = Toclient_getLearnSkillComboListSkillNo(self._skillComboShowIndex, jj)
    if jj == comboCount - 1 then
      command = command .. tmpCommand
    else
      command = command .. tmpCommand .. " | "
    end
  end
  SkillCombo_MakeCommand(command, self._comboSlotIndex)
  self._comboTitle:SetPosY(5 + (self.skillCount + self.sizeUpCount) * 30 + self.skillCount * 2)
  self._comboSlot._mainBG:SetSize(self._skillComboBgSize + 5, self._comboSlot._skillCommandBody:GetSizeY())
  self._comboSlot._mainBG:SetPosY(0 + (self.skillCount + self.sizeUpCount + 1) * 30 + self.skillCount * 2)
end
function skillCommand:updatePerFrame(deltatime)
  self._skillComboTimer = self._skillComboTimer + deltatime
  if self._skillComboTimer < self._skillComboLastUpdate + self._skillComboFrameDelay then
    return
  end
  self._skillComboLastUpdate = self._skillComboTimer
  skillCommand:SkillComboSetting()
  skillCommand:SetAttackModeTip()
  self._skillComboShowIndex = self._skillComboShowIndex + 1
end
function skillCommand:convertSkillcomboText(text)
  local commandIndex = string.find(text, ":")
  local endIndex = string.find(text, "%}")
  local plusIndex = string.find(text, "+")
  local slashIndex = string.find(text, "/")
  if nil ~= plusIndex then
    return text
  elseif nil ~= slashIndex then
    return text
  elseif nil == commandIndex or nil == endIndex and nil == plusIndex and nil == slashIndex then
    return PAGetString(Defines.StringSheet_GAME, text)
  end
  local actionText = string.sub(text, commandIndex + 1, endIndex - 1)
  if "MoveFront" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveFront)
  elseif "MoveBack" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveBack)
  elseif "MoveLeft" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveLeft)
  elseif "MoveRight" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_MoveRight)
  elseif "Attack1" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Attack1)
  elseif "Attack2" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Attack2)
  elseif "MoveDash" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Dash)
  elseif "Jump" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Jump)
  elseif "CrouchOrSkill" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_CrouchOrSkill)
  elseif "GrabOrGuard" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_GrabOrGuard)
  elseif "Kick" == actionText then
    return keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Kick)
  end
end
function SkillCombo_MakeCommand(command, index)
  local self = skillCommand
  local commandIndex = string.find(command, "<")
  local stringIndex = string.find(command, "[%[]")
  local plusIndex = string.find(command, "+")
  local nextIndex = string.find(command, "|")
  local swapIndex = SkillCombo_StringMatchForConvert(commandIndex, stringIndex, plusIndex, nextIndex)
  if 0 == swapIndex then
    local text = string.sub(command, commandIndex + 1, string.find(command, ">") - 1)
    self:comboControlSet(0, text, self._skillCombo[0], self._skillComboLineCount)
    command = string.gsub(command, "<" .. text .. ">", "", 1)
  elseif 1 == swapIndex then
    local text = string.sub(command, stringIndex + 1, string.find(command, "[%]]") - 1)
    self:comboControlSet(1, text, self._skillCombo[1], self._skillComboLineCount)
    command = string.gsub(command, "[%[]" .. text .. "[%]]", "", 1)
  elseif 2 == swapIndex then
    local text = string.sub(command, plusIndex, plusIndex)
    self:comboControlSet(2, text, self._skillCombo[2], self._skillComboLineCount)
    command = string.gsub(command, "+", "", 1)
  elseif 3 == swapIndex then
    local text = string.sub(command, nextIndex, nextIndex)
    self:comboControlSet(3, text, self._skillCombo[3], self._skillComboLineCount)
    command = string.gsub(command, "|", "", 1)
  else
    return
  end
  command = SkillCombo_MakeCommand(command, index)
end
function SkillCombo_StringMatchForConvert(commandIndex, stringIndex, plusIndex, nextIndex)
  local returnValue
  if nil ~= commandIndex then
    returnValue = 0
    if nil ~= stringIndex then
      if stringIndex < commandIndex then
        returnValue = 1
      end
      if nil ~= plusIndex then
        if plusIndex < math.min(commandIndex, stringIndex) then
          returnValue = 2
        end
        if nil ~= nextIndex and nextIndex < commandIndex and nextIndex < stringIndex and nextIndex < plusIndex then
          returnValue = 3
        end
      elseif nil ~= nextIndex and nextIndex < commandIndex and nextIndex < stringIndex then
        returnValue = 3
      end
    elseif nil ~= plusIndex then
      if plusIndex < commandIndex then
        returnValue = 2
      end
      if nil ~= nextIndex and nextIndex < commandIndex and nextIndex < plusIndex then
        returnValue = 3
      end
    elseif nil ~= nextIndex and nextIndex < commandIndex then
      returnValue = 3
    end
  elseif nil ~= stringIndex then
    returnValue = 1
    if nil ~= plusIndex then
      if plusIndex < stringIndex then
        returnValue = 2
      end
      if nil ~= nextIndex and nextIndex < stringIndex and nextIndex < plusIndex then
        returnValue = 3
      end
    elseif nil ~= nextIndex and nextIndex < stringIndex then
      returnValue = 3
    end
  elseif nil ~= plusIndex then
    returnValue = 2
    if nil ~= nextIndex and nextIndex < plusIndex then
      returnValue = 3
    end
  elseif nil ~= nextIndex then
    returnValue = 3
  end
  return returnValue
end
function skillCommand:comboControlHide(controlType, controlIndex)
  if nil == self._skillComboControl[controlType][controlIndex] then
    return
  end
  self._skillComboControl[controlType][controlIndex]:SetShow(false)
  self._skillCombo[controlType] = 0
end
function skillCommand:comboControlSet(controlType, text, controlIndex, lineCount)
  if nil == self._comboSlot then
    return
  end
  local slot = self._comboSlot
  local LBstring = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseLB")
  local RBstring = PAGetString(Defines.StringSheet_GAME, "InputCustomizer_MouseRB")
  local LBstringIndex = string.find(LBstring, text)
  local RBstringIndex = string.find(RBstring, text)
  if "" ~= text and nil ~= LBstringIndex then
    controlType = 4
    controlIndex = self._skillCombo[controlType]
  elseif "" ~= text and nil ~= RBstringIndex then
    controlType = 5
    controlIndex = self._skillCombo[controlType]
  end
  if nil == self._skillComboControl[controlType][controlIndex] then
    return
  end
  local tempControl = self._skillComboControl[controlType][controlIndex]
  if 0 == controlType then
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
    tempControl:SetPosY(2)
  elseif 1 == controlType then
    if "/" ~= text then
      text = PAGetString(Defines.StringSheet_GAME, text)
    end
    tempControl:SetText(text)
    tempControl:SetSize(tempControl:GetTextSizeX() + 10, tempControl:GetSizeY())
    tempControl:SetPosY(0)
  elseif 2 == controlType then
    tempControl:SetPosY(6)
  elseif 3 == controlType then
    tempControl:SetPosY(6)
  elseif 4 == controlType then
    tempControl:SetPosY(0)
  elseif 5 == controlType then
    tempControl:SetPosY(0)
  end
  tempControl:SetShow(true)
  local tempPosX = slot._skillCommandBody:GetSizeX() + 5
  local tempSizeY = 30
  if 3 == controlType and tempPosX > self._skillComboMaxBgSizeX then
    self._skillComboLineCount = self._skillComboLineCount + 1
    tempPosX = 0
  end
  tempControl:SetPosX(tempPosX)
  tempControl:SetPosY(tempControl:GetPosY() + tempSizeY * (self._skillComboLineCount - 1))
  local commandBodySize = tempPosX + tempControl:GetSizeX()
  if commandBodySize > self._skillComboBgSize then
    self._skillComboBgSize = commandBodySize
  end
  slot._skillCommandBody:SetSize(tempPosX + tempControl:GetSizeX(), tempSizeY * self._skillComboLineCount)
  self._skillComboControl[controlType][controlIndex] = tempControl
  self._skillCombo[controlType] = self._skillCombo[controlType] + 1
end
function FromClient_SkillComboUpdate()
  skillCommand:setSkillComboType()
  skillCommand:SkillComboSetting()
  skillCommand:SetAttackModeTip()
end
function skillCommand:skillComboOpen(isOpen)
  if false == _ContentsGroup_SkillComboGuide then
    return
  end
  local option = true
  if true == _ContentsGroup_NewUI_GameOption_All then
    option = PaGlobal_GameOption_All_GetSkillComboSetting()
    if nil ~= option and false == option then
      isOpen = false
    end
  else
    option = FGlobal_IsChecked_GetSkillComboSetting()
    if nil ~= option and false == option then
      isOpen = false
    end
  end
  if true == skillCommand._isServantRide then
    isOpen = false
  end
  if nil == self._comboSlot then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local nowRegionInfo = selfPlayer:getCurrentRegionInfo()
  local isSafeZone = nowRegionInfo:get():isSafeZone()
  if ToClient_HardCoreChannelWithContensOption() == true then
    isSafeZone = ToClient_HardCoreSelfplayerRegionCheck(__eHardCoreChannelRegionSafe)
  end
  if true == isSafeZone then
    isOpen = false
  end
  local isLocalWar = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)
  if true == isLocalWar then
    isOpen = true
  end
  local slot = self._comboSlot
  if true == isOpen then
    local comboListSize = Toclient_getLearnSkillComboListCount()
    if comboListSize <= 0 then
      return
    end
    skillCommand:SkillComboSetting()
    skillCommand:SetAttackModeTip()
  else
    self._comboTitle:SetShow(false)
    slot._mainBG:SetShow(false)
    slot._skillCommandBody:SetShow(false)
    for controlType = 0, self._skillComboComtrolTypeCount - 1 do
      if 3 == controlType then
        for ii = 0, self._skillComboNextIconCount - 1 do
          skillCommand:comboControlHide(controlType, ii)
        end
      else
        for ii = 0, self._skillComboControlIconCount - 1 do
          skillCommand:comboControlHide(controlType, ii)
        end
      end
    end
  end
end
function skillCommand:setSkillComboType()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local classType = selfPlayerWrapper:getClassType()
  local successionRoot = ToClient_getSuccessionRootSkillGroupNo(classType)
  local cacheValue = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eSkillGroupWindowPlayerTree)
  local playerType = ToClient_GetCurrentPlayerSkillType()
  local curType = -2
  if 0 == cacheValue then
    curType = playerType
  else
    curType = cacheValue - 1
  end
  if 0 == successionRoot then
    curType = 0
  end
  self._curComboType = curType
end
function PaGlobal_SkillCombo_UpdateSkillCombo()
  skillCommand:setSkillComboType()
  skillCommand:SkillComboSetting()
  skillCommand:SetAttackModeTip()
end
function PaGlobal_SkillGuide_Open()
  if false == FGlobal_IsChecked_SkillCommand() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == questList_isClearQuest(21117, 2) and 1 >= getSelfPlayer():get():getLevel() then
    return
  end
  if 0 == skillCommand.skillCount then
    return
  end
  SkillCommand_Reset()
  Panel_SkillCommand:SetShow(true, true)
  if PaGlobalFunc_CollectMiniGame_IsPlaying ~= nil and PaGlobalFunc_CollectMiniGame_IsPlaying() == true then
    PaGlobalFunc_CollectMiniGame_UpdateSkillCommandState(true)
    Panel_SkillCommand:SetShow(false)
  end
end
skillCommand:Init()
Panel_SkillCommand:RegisterUpdateFunc("SkillCommand_UpdateTime")
registerEvent("FromClient_CheckLevelUpforSkillCommand", "FromClient_CheckLevelUpforSkillCommand")
registerEvent("FromClient_SkillCommandListonLevelUp", "FromClient_SkillCommandListonLevelUp")
registerEvent("EventSelfPlayerLevelUp", "SkillCommand_LimitLevelCheck")
registerEvent("FromClient_SkillCommandList", "FromClient_SkillCommandList")
registerEvent("onScreenResize", "FGlobal_SkillCommand_ResetPosition")
registerEvent("FromClient_ApplyUISettingPanelInfo", "FGlobal_SkillCommand_ResetPosition")
registerEvent("selfPlayer_regionChangedOnlyUsedSafeZone", "FromClient_RegionChange")
registerEvent("FromClient_SelfHardCoreRegionChange", "PaGlobal_SkillCommand_HardCoreChangeRegion")
registerEvent("FromClient_RenderModeChangeState", "FGlobal_SkillCommand_ResetPosition")
registerEvent("FromClient_SkillCommandWeaponType", "FromClient_SkillCommandWeaponType")
registerEvent("EventSelfPlayerRideOn", "PaGlobal_SkillCommand_PlayerRideOn")
registerEvent("EventSelfPlayerRideOff", "PaGlobal_SkillCommand_PlayerRideOff")
registerEvent("EventSelfServantUpdate", "SkillCommand_ServantInfoUpdate")
registerEvent("EventlearnedSkill", "FromClient_SkillCommandDataSet")
registerEvent("EventSkillWindowClearSkill", "FromClient_SkillCommandDataSet")
registerEvent("EventSkillWindowClearSkillByPoint", "FromClient_SkillCommandDataSet")
registerEvent("EventSkillWindowClearSkillAll", "FromClient_SkillCommandDataSet")
registerEvent("EventSkillWindowUpdate", "FromClient_SkillCommandDataSet")
registerEvent("FromClient_UpdateSkillComboGuide", "FromClient_SkillComboUpdate")
registerEvent("FromClient_ShowSequenceSkillCommand", "FromClient_ShowSequenceSkillCommand")
registerEvent("FromClient_StopSequence", "FormClient_ResetSkillCommandFromSequence")
registerEvent("EventSelfPlayerUsedSkill", "FromClient_EventSelfPlayerUsedSkill_ForSkillCommand")
