PaGlobal_SuccessionSkill = {isSuccessionContentsOpen = false}
function PaGlobal_SuccessionSkill:initalize()
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    if PaGlobal_SuccessionSkill_IsCheckOpenContents() then
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:SetShow(true)
    else
      PaGlobal_Skill.radioButtons[PaGlobal_Skill.eTabIndex.succession]:SetShow(false)
    end
  else
  end
end
function PaGlobal_SuccessionSkill_IsCheckOpenContents()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return false
  end
  return PaGlobalFunc_Util_IsSuccessionContentsOpen(selfPlayer:getClassType())
end
