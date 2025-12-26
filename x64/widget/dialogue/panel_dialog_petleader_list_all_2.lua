function PaGlobal_DialogPetLeader_List_All_Open()
  PaGlobal_DialogPetLeader_List_All:prepareOpen()
end
function PaGlobal_DialogPetLeader_List_All_Close()
  PaGlobal_DialogPetLeader_List_All:prepareClose()
end
function PaGlobal_DialogPetLeader_ListCreate_All(control, key)
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  PaGlobal_DialogPetLeader_List_All:createContents(control, key)
end
function PaGlobal_DialogPetLeader_All_OnScreenSizeRefresh()
  Panel_Dialog_PetLeader_List_All:ComputePos()
end
function HandleEventLUp_DialogPetLeader_List_All_Select(sealIndex)
  if sealIndex == nil then
    return
  end
  local pcPetData = ToClient_getPetSealedDataByIndex(sealIndex)
  if nil == pcPetData then
    return
  end
  PaGlobal_DialogPetLeader_All_PushPet(sealIndex)
end
function HandleEventMouseOn_DialogPetLeader_List_All_NameTooltip(isShow, key, petName)
  if isShow == true then
    TooltipSimple_Hide()
    return
  end
  local contents = PaGlobal_DialogPetLeader_List_All._ui.list2_Pet:GetContentByKey(key)
  local nameControl = UI.getChildControl(contents, "Template_StaticText_PetName")
  name = petName
  control = nameControl
  TooltipSimple_Show(nameControl, petName, "")
end
function HandleEventMouseOn_DialogPetLeader_List_All_BaseSkillTooltip(skill_idx, typeStr)
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(skill_idx)
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventMouseOn_DialogPetLeader_List_All_EquipSkillToolTip(skill_idx, typeStr)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventMouseOut_DialogPetLeader_List_All_Hide_SkillToolTip()
  Panel_SkillTooltip_Hide()
end
function HandleEventMouseOn_DialogPetLeader_List_All_PropertyTooltip(skillType)
  local petPropertyText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", PaGlobal_PetList_GetSkillTypeString_All(skillType))
  TooltipSimple_CommonShow("", petPropertyText)
  TooltipSimple_Common_Pos(getMousePosX() + 15, getMousePosY() + 15)
end
function PaGlobal_DialogPetLeader_List_All_Update()
  PaGlobal_DialogPetLeader_List_All:UpdatePetLeaderList()
end
function PaGlobal_DialogPetLeader_List_All_PerFrameUpdate()
  Panel_Dialog_PetLeader_List_All:SetPosX(Panel_Dialog_PetLeader_All:GetPosX() - Panel_Dialog_PetLeader_List_All:GetSizeX() - 10)
  Panel_Dialog_PetLeader_List_All:SetPosY(Panel_Dialog_PetLeader_All:GetPosY())
end
