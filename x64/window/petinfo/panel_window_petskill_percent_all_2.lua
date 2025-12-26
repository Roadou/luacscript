function HandleEventLUp_PetSkill_Percent_All_RequestPetSkillRate()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  PaGlobal_PetSkill_Percent_All:requsetPetSkillRate()
end
function HandleEventLUp_PetSkill_Percent_All_RequestPetSkillRate_Console(isLeft)
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  if true == isLeft then
    if true == PaGlobal_PetSkill_Percent_All._ui._btn_petTier_1:IsChecked() then
      return
    end
  else
    if false == PaGlobal_PetSkill_Percent_All._ui._btn_petTier_2:GetShow() then
      return
    end
    if true == PaGlobal_PetSkill_Percent_All._ui._btn_petTier_2:IsChecked() then
      return
    end
  end
  PaGlobal_PetSkill_Percent_All._ui._btn_petTier_1:SetCheck(isLeft)
  PaGlobal_PetSkill_Percent_All._ui._btn_petTier_2:SetCheck(not isLeft)
  PaGlobal_PetSkill_Percent_All:requsetPetSkillRate()
end
function HandleEventMouseOut_PetSkillRateList_TooltipHide()
  Panel_SkillTooltip_Hide()
end
function HandleEventOnOff_PetSkill_Percent_All_ShowToolTip(skill_idx, typeStr)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventLUp_PetSkill_Percent_All_ListControlCreate(content, key)
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  PaGlobal_PetSkill_Percent_All:createListControl(content, key)
end
function HandleEventLUp_PetSkill_Percent_All_Close()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  PaGlobal_PetSkill_Percent_All:prepareClose()
end
function HandleEventLUp_PetSkill_Percent_All_Open()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  PaGlobal_PetSkill_Percent_All:prepareOpen()
end
function FromClient_PetSkill_Percent_All_ReSizePanel()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
end
function FromClient_PetSkill_Percent_All_NotiPetSkill()
  PaGlobal_PetSkill_Percent_All._ui._list2:getElementManager():clearKey()
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  for skill_idx = 0, skillMaxCount - 1 do
    local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
    if nil ~= skillStaticStatus and 0 ~= ToClient_getPetEquipSkillRate(skill_idx) then
      PaGlobal_PetSkill_Percent_All._ui._list2:getElementManager():pushKey(toInt64(0, skill_idx))
    end
  end
end
