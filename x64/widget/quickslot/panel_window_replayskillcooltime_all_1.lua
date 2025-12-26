function PaGlobal_ReplaySkillCooltime:initialize()
  if self._initialize == true then
    return
  end
  for index = 0, self._maxSlotCount do
    local slot = {}
    SlotSkill.new(slot, index, Panel_Window_ReplaySkillCooltime_All, self.slotConfig)
    slot.icon:SetIgnore(true)
    if index >= 20 then
      slot.skillName = UI.createAndCopyBasePropertyControl(Panel_Window_ReplaySkillCooltime_All, "StaticText_RightTeam_UsedSkill", slot.icon, "UsedSkill_" .. index)
      if self._slot_rightInitPosY == 0 then
        self._slot_rightInitPosY = slot.icon:GetPosY()
      end
      if self._slot_rightSkillNameInitPosX == 0 then
        self._slot_rightSkillNameInitPosX = slot.skillName:GetPosX()
      end
    else
      slot.skillName = UI.createAndCopyBasePropertyControl(Panel_Window_ReplaySkillCooltime_All, "StaticText_LeftTeam_UsedSkill", slot.icon, "UsedSkill_" .. index)
      if self._slot_leftInitPosY == 0 then
        self._slot_leftInitPosY = slot.icon:GetPosY()
      end
    end
    slot.skillName:SetShow(false)
    slot:clearSkill()
    self.slots[index] = slot
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_ReplaySkillCooltime:registEventHandler()
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  registerEvent("FromClient_RenderModeChangeState", "ReplaySkillCooltime_OnResize")
  registerEvent("FromClient_insertReplayArshaSkillSlot", "ReplaySkillCooltime_Add")
  registerEvent("onScreenResize", "ReplaySkillCooltime_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "ReplaySkillCooltime_OnResize")
  registerEvent("FromClient_EndReplay", "PaGlobalFunc_ReplaySkillCooltime_Close")
  registerEvent("FromClient_ClearReplayTeamUi", "PaGlobalFunc_ReplaySkillCooltime_Close")
  registerEvent("FromClient_updateReplaySkillSlot", "ReplaySkillCooltime_Update")
  registerEvent("FromClient_ChangeSolareReplayAttachTarget", "SolareSkillCooltime_ClearAndSet")
end
function PaGlobal_ReplaySkillCooltime:prepareOpen(replayType)
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  self:updateSlotPosition(replayType)
  self:open()
end
function PaGlobal_ReplaySkillCooltime:open()
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  Panel_Window_ReplaySkillCooltime_All:RegisterUpdateFunc("ReplaySkillCooltime_UpdatePerFrame")
  Panel_Window_ReplaySkillCooltime_All:SetShow(true)
end
function PaGlobal_ReplaySkillCooltime:prepareClose()
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  self:clearSkillSlot()
  self:close()
end
function PaGlobal_ReplaySkillCooltime:close()
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  Panel_Window_ReplaySkillCooltime_All:ClearUpdateLuaFunc()
  Panel_Window_ReplaySkillCooltime_All:SetShow(false)
end
function PaGlobal_ReplaySkillCooltime:clearSkillSlot()
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  for index = 0, self._maxSlotCount do
    self.slots[index]:clearSkill()
    self.slots[index].skillName:SetShow(false)
  end
end
function PaGlobal_ReplaySkillCooltime:updateSlotPosition(replayType)
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  if replayType == __eReplayRecordType_Solare then
    local stc_solarePartyRightBg = UI.getChildControl(Panel_Widget_Solare_PlayerStatus, "Static_RightTeam")
    local posX = getScreenSizeX() * 0.7
    local posY = stc_solarePartyRightBg:GetParentPosY() - 100
    for index = 0, self._maxSlotCount do
      local slot = self.slots[index]
      if slot ~= nil then
        local slotIconInitPosY = 0
        if index >= 20 then
          slotIconInitPosY = self._slot_rightInitPosY
        else
          slotIconInitPosY = self._slot_leftInitPosY
        end
        local slotPosX = posX - slot.icon:GetSizeX() * 1.5
        local slotPosY = posY + slotIconInitPosY + index * self.config.slotGapY
        slot:setPos(slotPosX, slotPosY)
      end
    end
  elseif replayType == __eReplayRecordType_Arsha then
    local left_stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_LeftTeam")
    local left_stc_memberTemplate = UI.getChildControl(left_stc_mainBg, "Static_MemberArea")
    local right_stc_mainBg = UI.getChildControl(Panel_Widget_Arsha_Party_All, "Static_RightTeam")
    local right_stc_memberTemplate = UI.getChildControl(right_stc_mainBg, "Static_MemberArea")
    local leftTeamPosX = left_stc_memberTemplate:GetPosX()
    local leftTeamPosY = left_stc_memberTemplate:GetParentPosY() + left_stc_memberTemplate:GetSizeY()
    local rightTeamPosX = getOriginScreenSizeX()
    local rightTeamPosY = right_stc_memberTemplate:GetParentPosY() + right_stc_memberTemplate:GetSizeY()
    for index = 0, self._maxSlotCount do
      local slot = self.slots[index]
      if slot ~= nil then
        local slotPosX = 0
        local slotPosY = 0
        if index >= 20 then
          slotPosX = rightTeamPosX - slot.icon:GetSizeX() * 1.5
          slotPosY = rightTeamPosY + self._slot_rightInitPosY + (index - 20) * self.config.slotGapY
          slot.skillName:SetPosX(self._slot_rightSkillNameInitPosX - slot.icon:GetSizeX() / 10)
        else
          slotPosX = leftTeamPosX + slot.icon:GetSizeX() / 2
          slotPosY = leftTeamPosY + self._slot_leftInitPosY + index * self.config.slotGapY
        end
        slot:setPos(slotPosX, slotPosY)
      end
    end
  end
end
function PaGlobal_ReplaySkillCooltime:onResize()
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  Panel_Window_ReplaySkillCooltime_All:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  Panel_Window_ReplaySkillCooltime_All:ComputePos()
  FGlobal_PanelRepostionbyScreenOut(Panel_Window_ReplaySkillCooltime_All)
end
function PaGlobal_ReplaySkillCooltime:update(deltatime)
  if Panel_Window_ReplaySkillCooltime_All == nil then
    return
  end
  if ToClient_IsPlayingReplay() == false then
    return
  end
  self:clearSkillSlot()
  local loopCount = 2
  if ToClient_IsSolareReplay() == true then
    loopCount = 1
  end
  for idx = 0, loopCount - 1 do
    local skillKeyList = {}
    local slotCount = 0
    local teamNo = 1
    local skillData
    if idx == 0 then
      skillData = self._redTeam_skillData
    else
      skillData = self._blueTeam_skillData
      slotCount = 20
      teamNo = 2
    end
    for skillIdx = 1, #skillData do
      local slot = self.slots[slotCount]
      local skillKey = 0
      local skillNo = 0
      local attendActorKey = 0
      local remainTime = 0
      if nil ~= skillData[skillIdx] then
        skillKey = skillData[skillIdx].skillKey
        skillNo = skillData[skillIdx].skillNo
        if ToClient_IsSolareReplay() == true then
          attendActorKey = ToClient_GetCurrentAttachCameraReplayActorKey()
        else
          attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
        end
        remainTime = ToClient_getOtherSkillCooltimeForReplay(attendActorKey, skillKey)
      end
      if remainTime <= 0 then
        skillKeyList[#skillKeyList + 1] = skillIdx
      else
        local realRemainTime = 0
        local intRemainTime = 0
        local skillReuseTime = 0
        local skillTypeStaticWrapper = getSkillTypeStaticStatus(skillNo)
        if ToClient_IsSolareReplay() == true then
          attendActorKey = ToClient_GetCurrentAttachCameraReplayActorKey()
        else
          attendActorKey = ToClient_getReplayAttendInfoByTeamNo(teamNo)
        end
        local level = ToClient_getOtherLearnedSkillLevelForReplay(attendActorKey, skillTypeStaticWrapper)
        local skillStaticWrapper = getSkillStaticStatus(skillNo, level)
        if nil ~= skillStaticWrapper then
          skillReuseTime = skillStaticWrapper:get()._reuseCycle / 1000
        end
        if nil ~= slot then
          slot.icon:SetShow(true)
          slot.skillName:SetShow(true)
          slot:setSkillTypeStatic(skillTypeStaticWrapper)
          slot.cooltime:UpdateCoolTime(remainTime)
          slot.cooltime:SetShow(true)
          realRemainTime = remainTime * skillReuseTime
          intRemainTime = realRemainTime - realRemainTime % 1 + 1
          slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
          if skillReuseTime >= intRemainTime then
            slot.cooltimeText:SetShow(true)
          else
            slot.cooltimeText:SetShow(false)
          end
          local skillName = skillStaticWrapper:getName()
          slot.skillName:SetText(skillName)
          slot.skillName:SetShow(true)
        end
        slotCount = slotCount + 1
      end
    end
    for _, key in pairs(skillKeyList) do
      skillData[key] = nil
    end
  end
end
