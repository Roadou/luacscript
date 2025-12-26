PaGlobal_AwakenSkill = {isAwakenWeaponContentsOpen = false}
function PaGlobal_AwakenSkill:initalize()
  self.isAwakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(getSelfPlayer():getClassType())
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SKILL_AWAKEN_WEAPONS"))
    if self.isAwakenWeaponContentsOpen then
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:SetShow(true)
    else
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.awaken]:SetShow(false)
    end
  else
  end
end
