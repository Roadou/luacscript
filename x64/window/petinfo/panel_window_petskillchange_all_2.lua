function HandleEventMouseLup_PetSkillChange_SkillChangeButton(changingSkillKey, idx)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  PaGlobal_Window_PetSkillChange_All:handleEventMouseLup_SkillChangeButton(changingSkillKey, idx)
end
function HandleEventMouseLup_PetSkillChange_ApplyButton(wishSkillKey)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  PaGlobal_Window_PetSkillChange_All:handleEventMouseLup_SkillChangeApplyButton(wishSkillKey)
end
function FromClient_PetSkillChange(petNo, changingSkillKey, learnedSkillKey)
  PaGlobal_Window_PetSkillChange_All:prepareClose()
end
function PaGlobal_PetSkill_Change_Open_All(petNo_s64)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  if _ContenstGroup_PetSkillChange == false then
    return
  end
  PaGlobal_Window_PetSkillChange_All:prepareOpen(petNo_s64)
end
function PaGlobal_PetSkill_Change_Close_All()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  PaGlobal_Window_PetSkillChange_All:prepareClose()
end
function PaGlobal_PetSkillChange_CreateWishSkillListListContents(contents, key)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  PaGlobal_Window_PetSkillChange_All:createWishSkillListContents(contents, key)
end
