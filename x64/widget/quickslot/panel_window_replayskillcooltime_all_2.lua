function PaGlobalFunc_ReplaySkillCooltime_Open(replayType)
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  self:prepareOpen(replayType)
end
function PaGlobalFunc_ReplaySkillCooltime_Close()
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  self:prepareClose()
end
function ReplaySkillCooltime_SetPosY(leftTeamPosY, rightTeamPosY)
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  for index = 0, self._maxSlotCount do
    if index >= 20 then
      self.slots[index]:setPos(self.slots[index].icon:GetPosX(), rightTeamPosY + (index - 20) * self.config.slotGapY)
    else
      self.slots[index]:setPos(self.slots[index].icon:GetPosX(), leftTeamPosY + index * self.config.slotGapY)
    end
  end
end
function ReplaySkillCooltime_Add(TSkillKey, TSkillNo, teamNo)
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
  if nil == skillTypeStaticWrapper or true == skillTypeStaticWrapper:isGuildSkill() then
    return
  end
  local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
  if nil == skillTypeStaticWrapper or true == skillTypeStaticWrapper:isGuildSkill() then
    return
  end
  if 1 == teamNo then
    self._redTeam_skillData[TSkillKey] = {}
    self._redTeam_skillData[TSkillKey].remainTime = 0
    self._redTeam_skillData[TSkillKey].skillNo = TSkillNo
  else
    self._blueTeam_skillData[TSkillKey] = {}
    self._blueTeam_skillData[TSkillKey].remainTime = 0
    self._blueTeam_skillData[TSkillKey].skillNo = TSkillNo
  end
end
function ReplaySkillCooltime_OnResize()
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  self:onResize()
end
function ReplaySkillCooltime_UpdatePerFrame(deltaTime)
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function SolareSkillCooltime_ClearAndSet(actorKeyRaw)
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  self:clearSkillSlot()
  SolareReplaySkillCooltime_Update()
end
function ReplaySkillCooltime_Update(recordType)
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  if Panel_Window_ReplaySkillCooltime_All:GetShow() == false then
    PaGlobalFunc_ReplaySkillCooltime_Open(recordType)
  end
  if recordType == __eReplayRecordType_Solare then
    SolareReplaySkillCooltime_Update()
  else
    ArshaReplaySkillCooltime_Update()
  end
end
function SolareReplaySkillCooltime_Update()
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  self._redTeam_skillData = {}
  local checkSkillKey = {}
  local skillCount = 1
  local actorKeyRaw = ToClient_GetCurrentAttachCameraReplayActorKey()
  local size = ToClient_GetReplayUseSkillDataInfoSizeByActorKey(actorKeyRaw)
  for index = 0, size - 1 do
    local useSkillData = ToClient_getReplayUseSkillDataInfoByActorKey(actorKeyRaw, index)
    if useSkillData ~= nil then
      local TSkillKey = useSkillData:getSkillKey()
      local TSkillNo = useSkillData:getSkillNo()
      if checkSkillKey[TSkillKey] == nil then
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
        if skillTypeStaticWrapper ~= nil and skillTypeStaticWrapper:isGuildSkill() ~= true then
          self._redTeam_skillData[skillCount] = {}
          self._redTeam_skillData[skillCount].remainTime = 0
          self._redTeam_skillData[skillCount].skillKey = TSkillKey
          self._redTeam_skillData[skillCount].skillNo = TSkillNo
          skillCount = skillCount + 1
          checkSkillKey[TSkillKey] = true
        end
      end
    end
  end
end
function ArshaReplaySkillCooltime_Update()
  local self = PaGlobal_ReplaySkillCooltime
  if self == nil then
    return
  end
  for teamNo = 1, 2 do
    if 1 == teamNo then
      self._redTeam_skillData = {}
    else
      self._blueTeam_skillData = {}
    end
    local checkSkillKey = {}
    local skillCount = 1
    local size = ToClient_getReplayUseSkillDataInfoSizeByTeamNo(teamNo)
    for idx = 1, size do
      local useSkillData = ToClient_getReplayUseSkillDataInfoByIndex(teamNo, idx - 1)
      if nil ~= useSkillData then
        local TSkillKey = useSkillData:getSkillKey()
        local TSkillNo = useSkillData:getSkillNo()
        if nil == checkSkillKey[TSkillKey] then
          local skillTypeStaticWrapper = getSkillTypeStaticStatus(TSkillNo)
          if nil ~= skillTypeStaticWrapper and true ~= skillTypeStaticWrapper:isGuildSkill() then
            if 1 == teamNo then
              self._redTeam_skillData[skillCount] = {}
              self._redTeam_skillData[skillCount].remainTime = 0
              self._redTeam_skillData[skillCount].skillKey = TSkillKey
              self._redTeam_skillData[skillCount].skillNo = TSkillNo
            else
              self._blueTeam_skillData[skillCount] = {}
              self._blueTeam_skillData[skillCount].remainTime = 0
              self._blueTeam_skillData[skillCount].skillKey = TSkillKey
              self._blueTeam_skillData[skillCount].skillNo = TSkillNo
            end
            skillCount = skillCount + 1
            checkSkillKey[TSkillKey] = true
          end
        end
      end
    end
  end
end
