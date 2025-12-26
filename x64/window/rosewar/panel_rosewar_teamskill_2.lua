function PaGlobalFunc_RoseWarTeamSkill_Open(openInfo)
  PaGlobalFunc_RoseWarTeamSkillManager_Clear()
  PaGlobal_RoseWarTeamSkill:prepareOpen(openInfo)
end
function PaGlobalFunc_RoseWarTeamSkill_Close()
  PaGlobalFunc_RoseWarTeamSkillManager_Clear()
  PaGlobal_RoseWarTeamSkill:prepareClose()
end
function PaGlobalFunc_RoseWarTeamSkill_Update(deltaTime)
  PaGlobal_RoseWarTeamSkill:update(deltaTime)
end
function PaGlobalFunc_RoseWarTeamSkill_SetShowPartyList(flag)
  if flag == true then
    PaGlobal_RoseWarTeamSkill:prepareOpenPartyList()
  else
    PaGlobal_RoseWarTeamSkill:closePartyList()
  end
end
function PaGlobalFunc_RoseWarTeamSkill_ShowPartyList(fierceBattleKeyRaw)
  PaGlobal_RoseWarTeamSkill:showPartyList(fierceBattleKeyRaw)
end
function PaGlobalFunc_RoseWarTeamSkill_ShowSkillEffect(skillType, skillUseInfo)
  PaGlobal_RoseWarTeamSkill:showSkillEffect(skillType, skillUseInfo)
end
function PaGlobalFunc_RoseWarTeamSkill_HideSkillEffect(skillType)
  PaGlobal_RoseWarTeamSkill:hideSkillEffect(skillType)
end
function HandleEventLUp_RoseWarTeamSkill_SelectSkillType(skillType)
  PaGlobalFunc_RoseWarTeamSkillManager_SelectSkillType(skillType)
end
function HandleEventLUp_RoseWarTeamSkill_UnSelectSkillType(skillType)
  PaGlobalFunc_RoseWarTeamSkillManager_UnSelectSkillType(skillType)
end
function InputEventMOn_RoseWarTeamSkill_HideSkillTooltip()
  PaGlobal_RoseWarTeamSkill:hideTooltip()
end
function InputEventMOn_RoseWarTeamSkill_ShowSkillTooltip(skillType)
  PaGlobal_RoseWarTeamSkill:showTooltip(skillType)
end
function FromClient_PaGlobal_RoseWarTeamSkill_OnScreenResize()
  PaGlobal_RoseWarTeamSkill:resize()
end
function FromClient_ResponseRoseWarUseSkillAck(skillType, isSucceed)
  PaGlobalFunc_RoseWarTeamSkillManager_UseSkillAck(skillType, isSucceed)
end
