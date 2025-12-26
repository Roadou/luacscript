function PaGlobal_DialogPetLeader_List_All:initialize()
  if true == PaGlobal_DialogPetLeader_List_All._initialize then
    return
  end
  local titleBar = UI.getChildControl(Panel_Dialog_PetLeader_List_All, "Static_TitleBG")
  self._ui.list2_Pet = UI.getChildControl(Panel_Dialog_PetLeader_List_All, "List2_PetList")
  self._ui.txt_Empty = UI.getChildControl(Panel_Dialog_PetLeader_List_All, "MultilineText_1")
  self._ui.stc_ButtonBg = UI.getChildControl(Panel_Dialog_PetLeader_List_All, "Static_ButtonBG")
  self._ui_console.txt_KeyGuideY = UI.getChildControl(self._ui.stc_ButtonBg, "StaticText_Y_ConsoleUI")
  self._ui_console.txt_KeyGuideA = UI.getChildControl(self._ui.stc_ButtonBg, "StaticText_Confirm_ConsoleUI")
  self._ui_console.txt_KeyGuideB = UI.getChildControl(self._ui.stc_ButtonBg, "StaticText_Close_ConsoleUI")
  local keyguides = {
    self._ui_console.txt_KeyGuideY,
    self._ui_console.txt_KeyGuideA,
    self._ui_console.txt_KeyGuideB
  }
  self._isConsole = _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    self._ui_console.txt_KeyGuideY:SetShow(true)
    self._ui_console.txt_KeyGuideA:SetShow(true)
    self._ui_console.txt_KeyGuideB:SetShow(true)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguides, self._ui.stc_ButtonBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  end
  self:changePlatform()
  if self._isConsole == false then
    Panel_Dialog_PetLeader_List_All:SetSize(Panel_Dialog_PetLeader_List_All:GetSizeX(), Panel_Dialog_PetLeader_List_All:GetSizeY() - self._ui.stc_ButtonBg:GetSizeY() + 10)
  end
  PaGlobal_DialogPetLeader_List_All:registEventHandler()
  PaGlobal_DialogPetLeader_List_All:validate()
  PaGlobal_DialogPetLeader_List_All._initialize = true
end
function PaGlobal_DialogPetLeader_List_All:registEventHandler()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  self._ui.list2_Pet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_DialogPetLeader_ListCreate_All")
  self._ui.list2_Pet:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("onScreenResize", "PaGlobal_DialogPetLeader_All_OnScreenSizeRefresh")
end
function PaGlobal_DialogPetLeader_List_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
  for _, control in pairs(self._ui_console) do
    control:SetShow(self._isConsole)
  end
  if self._ui_console == false then
    Panel_Dialog_PetLeader_List_All:SetSize(Panel_Dialog_PetLeader_List_All:GetSizeX(), Panel_Dialog_PetLeader_List_All:GetSizeY() - self._ui.stc_ButtonBg:GetSizeY())
  end
end
function PaGlobal_DialogPetLeader_List_All:prepareOpen()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  if _ContentsGroup_PetLeader == false then
    return
  end
  PaGlobal_DialogPetLeader_All._ui.stc_ResultSlot:EraseAllEffect()
  PaGlobal_DialogPetLeader_List_All:UpdatePetLeaderList()
  Panel_Dialog_PetLeader_List_All:SetPosX(Panel_Dialog_PetLeader_All:GetPosX() - Panel_Dialog_PetLeader_List_All:GetSizeX() - 10)
  Panel_Dialog_PetLeader_List_All:SetPosY(Panel_Dialog_PetLeader_All:GetPosY())
  Panel_Dialog_PetLeader_List_All:RegisterUpdateFunc("PaGlobal_DialogPetLeader_List_All_PerFrameUpdate")
  PaGlobal_DialogPetLeader_List_All:open()
end
function PaGlobal_DialogPetLeader_List_All:open()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  Panel_Dialog_PetLeader_List_All:SetShow(true)
end
function PaGlobal_DialogPetLeader_List_All:prepareClose()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  Panel_Dialog_PetLeader_List_All:ClearUpdateLuaFunc()
  PaGlobal_DialogPetLeader_List_All:close()
end
function PaGlobal_DialogPetLeader_List_All:close()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  Panel_Dialog_PetLeader_List_All:SetShow(false)
end
function PaGlobal_DialogPetLeader_List_All:validate()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
end
function PaGlobal_DialogPetLeader_List_All:UpdatePetLeaderList()
  if nil == Panel_Dialog_PetLeader_List_All then
    return
  end
  self._ui.txt_Empty:SetShow(true)
  self._ui.list2_Pet:getElementManager():clearKey()
  local sealPetCount = ToClient_getPetSealedList()
  local unsealPetCount = ToClient_getPetUnsealedList()
  local isEmptyShow = true
  for index = 0, sealPetCount do
    local petData = ToClient_getPetSealedDataByIndex(index)
    if nil ~= petData then
      local petNo_s64 = petData._petNo
      local isUpgrade = ToClient_IsUpgradePet(petData._petNo)
      if isUpgrade == true then
        self._ui.list2_Pet:getElementManager():pushKey(petNo_s64)
        isEmptyShow = false
      end
    end
  end
  self._ui.txt_Empty:SetShow(isEmptyShow)
end
function PaGlobal_DialogPetLeader_List_All:createContents(control, key)
  local uiControls = {
    bg = UI.getChildControl(control, "Template_Static_ListContentBG"),
    iconBg = UI.getChildControl(control, "Template_Static_IconPetBG"),
    icon = UI.getChildControl(control, "Template_Static_IconPet"),
    name = UI.getChildControl(control, "Template_StaticText_PetName"),
    level = UI.getChildControl(control, "Template_StaticText_Level"),
    tier = UI.getChildControl(control, "Template_StaticText_Tier"),
    gradeLine = UI.getChildControl(control, "Template_Static_GradeLine"),
    property = UI.getChildControl(control, "StaticText_Property"),
    pcRoomIcon = UI.getChildControl(control, "Static_PCRoomIcon"),
    parent = control
  }
  local skillIcon = {}
  for index = 0, self._contentsSkillIconCount - 1 do
    skillIcon[index] = UI.getChildControl(control, "Static_SkillIcon_" .. tostring(index))
  end
  self:initContents(uiControls, skillIcon)
  local isUpgrade = ToClient_IsUpgradePet(key)
  if isUpgrade == true and PaGlobal_DialogPetLeader_All_IsUpgradeStart() == false then
    control:SetIgnore(false)
    uiControls.bg:SetIgnore(false)
    control:SetMonoTone(false)
  else
    control:SetIgnore(true)
    uiControls.bg:SetIgnore(true)
    control:SetMonoTone(true)
  end
  uiControls.bg:SetShow(true)
  uiControls.iconBg:SetShow(true)
  uiControls.icon:SetShow(true)
  uiControls.tier:SetShow(true)
  uiControls.level:SetShow(true)
  uiControls.name:SetShow(true)
  uiControls.property:SetShow(true)
  uiControls.gradeLine:SetShow(true)
  local pcPetData = ToClient_getPetUnSealedDataByPetNo(key)
  if nil ~= pcPetData then
    PaGlobal_DialogPetLeader_List_All:setUnsealPetInfo(uiControls, skillIcon, key, pcPetData)
    return
  end
  pcPetData = ToClient_getPetSealedDataByPetNo(key)
  if nil ~= pcPetData then
    PaGlobal_DialogPetLeader_List_All:setSealPetInfo(uiControls, skillIcon, key, pcPetData)
  end
end
function PaGlobal_DialogPetLeader_List_All:setUnsealPetInfo(uiControls, skillIcon, key, pcPetData)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  local iconPath = pcPetData:getIconPath()
  local petNo_s64 = pcPetData:getPcPetNo()
  local petName = pcPetData:getName()
  local petLevel = pcPetData:getLevel()
  local petTier = petStaticStatus:getPetTier() + 1
  local skillType
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
  end
  uiControls.gradeLine:SetColor(self._gradeColorConfig[petTier - 1])
  uiControls.name:SetTextMode(__eTextMode_LimitText)
  uiControls.name:SetText(petName)
  if true == uiControls.name:IsLimitText() and false == self._isConsole then
    uiControls.name:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_NameTooltip( true,\t" .. tostring(key) .. ", " .. petName .. ")")
    uiControls.name:addInputEvent("Mouse_Out", "HandleEventMouseOn_DialogPetLeader_List_All_NameTooltip( false,\t" .. tostring(key) .. ", " .. petName .. ")")
  else
    uiControls.name:addInputEvent("Mouse_On", "")
    uiControls.name:addInputEvent("Mouse_Out", "")
  end
  if true == pcPetData:getPetStaticStatus():isOnlyPcRoom() then
    uiControls.pcRoomIcon:SetShow(true)
  else
    uiControls.pcRoomIcon:SetShow(false)
  end
  local uiIndex = 0
  local baseskillindex = pcPetData:getPetBaseSkillIndex()
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  if nil ~= skillStaticStatus then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeStaticWrapper then
      local skillNo = skillStaticStatus:getSkillNo()
      skillIcon[uiIndex]:SetShow(true)
      skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      if false == self._isConsole then
        skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_BaseSkillTooltip( " .. baseskillindex .. ", \"unSealPetListSkill\" )")
        skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_DialogPetLeader_List_All_Hide_SkillToolTip()")
        Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "unSealPetListSkill")
      end
      uiIndex = uiIndex + 1
    end
  end
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  for skill_idx = 0, skillMaxCount - 1 do
    local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
    local isLearn = pcPetData:isPetEquipSkillLearned(skill_idx)
    if true == isLearn and nil ~= skillStaticStatus then
      local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
      if nil ~= skillTypeStaticWrapper then
        local skillNo = skillStaticStatus:getSkillNo()
        skillIcon[uiIndex]:SetShow(true)
        skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
        if false == self._isConsole then
          skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_EquipSkillToolTip( " .. skill_idx .. ", \"unSealPetListSkill\" )")
          skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_DialogPetLeader_List_All_Hide_SkillToolTip()")
          Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "unSealPetListSkill")
        end
        uiIndex = uiIndex + 1
      end
    end
  end
  uiControls.icon:ChangeTextureInfoNameAsync(iconPath)
  uiControls.tier:SetFontColor(self._gradeColorConfig[petTier - 1])
  uiControls.tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petTier))
  if _ContentsGroup_PetLevelDelete then
    uiControls.level:SetShow(false)
    uiControls.name:SetPosX(uiControls.level:GetPosX())
  else
    uiControls.level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(petLevel))
  end
  local tierEndPosX = uiControls.tier:GetPosX() + uiControls.tier:GetTextSizeX()
  if tierEndPosX > uiControls.property:GetPosX() then
    uiControls.property:SetPosX(tierEndPosX + 5)
  end
  local propertyText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", PaGlobal_PetList_GetSkillTypeString_All(skillType))
  uiControls.property:SetTextMode(__eTextMode_LimitText)
  uiControls.property:SetText(propertyText)
  if true == uiControls.property:IsLimitText() and false == self._isConsole then
    uiControls.property:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_PropertyTooltip(" .. skillType .. ")")
    uiControls.property:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  else
    uiControls.property:addInputEvent("Mouse_On", "")
    uiControls.property:addInputEvent("Mouse_Out", "")
  end
  uiControls.bg:addInputEvent("Mouse_LUp", "")
end
function PaGlobal_DialogPetLeader_List_All:setSealPetInfo(uiControls, skillIcon, key, pcPetData)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  local iconPath = pcPetData:getIconPath()
  local petNo_s64 = pcPetData._petNo
  local petName = pcPetData:getName()
  local petLevel = pcPetData._level
  local petTier = petStaticStatus:getPetTier() + 1
  local skillType
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
  end
  uiControls.gradeLine:SetColor(self._gradeColorConfig[petTier - 1])
  uiControls.name:SetTextMode(__eTextMode_LimitText)
  uiControls.name:SetText(petName)
  if true == uiControls.name:IsLimitText() and false == self._isConsole then
    uiControls.name:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_NameTooltip( true,\t" .. tostring(key) .. ", " .. petName .. ")")
    uiControls.name:addInputEvent("Mouse_Out", "HandleEventMouseOn_DialogPetLeader_List_All_NameTooltip( false,\t" .. tostring(key) .. ", " .. petName .. ")")
  else
    uiControls.name:addInputEvent("Mouse_On", "")
    uiControls.name:addInputEvent("Mouse_Out", "")
  end
  if true == pcPetData:getPetStaticStatus():isOnlyPcRoom() then
    uiControls.pcRoomIcon:SetShow(true)
  else
    uiControls.pcRoomIcon:SetShow(false)
  end
  local uiIndex = 0
  local baseskillindex = pcPetData:getPetBaseSkillIndex()
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  if nil ~= skillStaticStatus then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeStaticWrapper then
      local skillNo = skillStaticStatus:getSkillNo()
      skillIcon[uiIndex]:SetShow(true)
      skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      if false == self._isConsole then
        skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_BaseSkillTooltip( " .. baseskillindex .. ", \"sealPetListSkill\" )")
        skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_DialogPetLeader_List_All_Hide_SkillToolTip()")
        Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "sealPetListSkill")
      end
      uiIndex = uiIndex + 1
    end
  end
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  for skill_idx = 0, skillMaxCount - 1 do
    local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
    local isLearn = pcPetData:isPetEquipSkillLearned(skill_idx)
    if true == isLearn and nil ~= skillStaticStatus then
      local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
      if nil ~= skillTypeStaticWrapper then
        local skillNo = skillStaticStatus:getSkillNo()
        skillIcon[uiIndex]:SetShow(true)
        skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
        if false == self._isConsole then
          skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_EquipSkillToolTip( " .. skill_idx .. ", \"sealPetListSkill\" )")
          skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_DialogPetLeader_List_All_Hide_SkillToolTip()")
          Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "sealPetListSkill")
        end
        uiIndex = uiIndex + 1
      end
    end
  end
  uiControls.icon:ChangeTextureInfoNameAsync(iconPath)
  uiControls.tier:SetFontColor(self._gradeColorConfig[petTier - 1])
  uiControls.tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petTier))
  if _ContentsGroup_PetLevelDelete then
    uiControls.level:SetShow(false)
    uiControls.name:SetPosX(uiControls.level:GetPosX())
  else
    uiControls.level:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. tostring(petLevel))
  end
  local tierEndPosX = uiControls.tier:GetPosX() + uiControls.tier:GetTextSizeX()
  if tierEndPosX > uiControls.property:GetPosX() then
    uiControls.property:SetPosX(tierEndPosX + 5)
  end
  local propertyText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_SPECIALSKILL", "paramText", PaGlobal_PetList_GetSkillTypeString_All(skillType))
  uiControls.property:SetTextMode(__eTextMode_LimitText)
  uiControls.property:SetText(propertyText)
  if true == uiControls.property:IsLimitText() and false == self._isConsole then
    uiControls.property:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_List_All_PropertyTooltip(" .. skillType .. ")")
    uiControls.property:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  else
    uiControls.property:addInputEvent("Mouse_On", "")
    uiControls.property:addInputEvent("Mouse_Out", "")
  end
  local sealIndex = ToClient_getPetSealedIndexByPetNo(key)
  if sealIndex >= 0 then
    uiControls.bg:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogPetLeader_List_All_Select(" .. tostring(sealIndex) .. ")")
  else
    uiControls.bg:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobal_DialogPetLeader_List_All:initContents(uiControls, skillIcon)
  for _, control in pairs(uiControls) do
    if control ~= uiControls.parent then
      control:SetShow(false)
      if self._isConsole then
        control:SetIgnore(true)
      end
    end
  end
  for _, control in pairs(skillIcon) do
    control:SetShow(false)
    if self._isConsole then
      control:SetIgnore(true)
    end
  end
  uiControls.bg:SetShow(true)
  uiControls.bg:SetCheck(false)
  if self._isConsole then
    uiControls.bg:addInputEvent("Mouse_LUp", "")
  end
end
