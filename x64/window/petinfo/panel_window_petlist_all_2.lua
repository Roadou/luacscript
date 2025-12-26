local isUnsealPet = function(petNo_s64, unsealPetCount)
  if unsealPetCount > 0 then
    for index = 0, unsealPetCount - 1 do
      local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
      if petNo_s64 == pcPetData:getPcPetNo() then
        return true
      end
    end
  end
  return false
end
function PaGlobal_PetList_All:createContents(control, key)
  local uiControls = {
    bg = UI.getChildControl(control, "Template_Static_ListContentBG"),
    unsealBg = UI.getChildControl(control, "Template_Static_ListContentUnsealBG"),
    iconBg = UI.getChildControl(control, "Template_Static_IconPetBG"),
    icon = UI.getChildControl(control, "Template_Static_IconPet"),
    name = UI.getChildControl(control, "Template_StaticText_PetName"),
    level = UI.getChildControl(control, "Template_StaticText_Level"),
    tier = UI.getChildControl(control, "Template_StaticText_Tier"),
    hungryIcon = UI.getChildControl(control, "Template_Static_HungryIcon"),
    hungryBg = UI.getChildControl(control, "Template_Static_Progress_Hungry_BG"),
    hungryProgress = UI.getChildControl(control, "Template_Static_Progress_Hungry"),
    hungryPercentText = UI.getChildControl(control, "StaticText_HungryPercent"),
    gradeLine = UI.getChildControl(control, "Template_Static_GradeLine"),
    gradeMark = UI.getChildControl(control, "Template_Static_GradeMark"),
    noUnsealpet = UI.getChildControl(control, "StaticText_NoneUnsealPet"),
    property = UI.getChildControl(control, "StaticText_Property"),
    orderFollow = UI.getChildControl(control, "CheckButton_Follow"),
    orderWait = UI.getChildControl(control, "CheckButton_Wait"),
    orderFind = UI.getChildControl(control, "CheckButton_Find"),
    orderGetItem = UI.getChildControl(control, "CheckButton_GetItem"),
    orderPlay = UI.getChildControl(control, "CheckButton_Play"),
    orderPlayIcon = nil,
    btnFusion = UI.getChildControl(control, "Template_Button_Fusion"),
    btnUnFusion = UI.getChildControl(control, "Template_Button_UnFusion"),
    btnCantFusion = UI.getChildControl(control, "Template_Button_DontFusion"),
    btnRegist = UI.getChildControl(control, "Template_Button_Regist"),
    btnUnsealAll = UI.getChildControl(control, "Template_Button_UnsealAll"),
    btnUnseal = UI.getChildControl(control, "Template_Button_Unseal"),
    btnUp = UI.getChildControl(control, "Button_Up"),
    btnDown = UI.getChildControl(control, "Button_Down"),
    btnFeed = UI.getChildControl(control, "Button_Feeding"),
    btnInfo = UI.getChildControl(control, "Template_Button_Info"),
    btnChangeSkill = UI.getChildControl(control, "Button_ChangeSkill"),
    btnSeal = UI.getChildControl(control, "Template_Button_Seal"),
    pcRoomIcon = UI.getChildControl(control, "Static_PCRoomIcon"),
    samePetIcon = UI.getChildControl(control, "Static_SamePet"),
    btnLeader = UI.getChildControl(control, "Button_Button_PetLeader_Confirm"),
    leaderIcon = UI.getChildControl(control, "Static_Static_LeaderMark"),
    btnChangeName = UI.getChildControl(control, "Template_Button_NameChange"),
    parent = control
  }
  uiControls.orderPlayIcon = UI.getChildControl(uiControls.orderPlay, "Static_PlayIcon")
  local groupBtns = {}
  for index = 1, self._maxPresetCount do
    groupBtns[index] = UI.getChildControl(control, "Template_Button_GroupIndex" .. tostring(index))
  end
  local skillIcon = {}
  for index = 0, self._contentsSkillIconCount - 1 do
    skillIcon[index] = UI.getChildControl(control, "Static_SkillIcon_" .. tostring(index))
  end
  self:initContents(uiControls, groupBtns, skillIcon)
  control:SetIgnore(not self._isConsole)
  uiControls.bg:SetIgnore(not self._isConsole)
  uiControls.unsealBg:SetIgnore(not self._isConsole)
  if toInt64(0, -1) == key then
    uiControls.noUnsealpet:SetShow(true)
    return
  else
    uiControls.iconBg:SetShow(true)
    uiControls.icon:SetShow(true)
    uiControls.tier:SetShow(true)
    uiControls.level:SetShow(true)
    uiControls.name:SetShow(true)
    uiControls.property:SetShow(true)
    uiControls.hungryProgress:SetShow(true)
    uiControls.hungryBg:SetShow(true)
    uiControls.hungryIcon:SetShow(true)
    uiControls.hungryPercentText:SetShow(true)
    uiControls.gradeLine:SetShow(true)
  end
  local sealPetCount = ToClient_getPetSealedList()
  local unsealPetCount = ToClient_getPetUnsealedList()
  local isFusion = PaGlobal_PetFusion_GetShow_All()
  if isUnsealPet(key, unsealPetCount) then
    for index = 0, unsealPetCount - 1 do
      local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
      if nil ~= pcPetData and key == pcPetData:getPcPetNo() then
        self:setUnsealPetContents(uiControls, groupBtns, skillIcon, key, pcPetData, index, isFusion)
        break
      end
    end
  else
    for index = 0, sealPetCount - 1 do
      local pcPetData = ToClient_getPetSealedDataByIndex(index)
      if nil ~= pcPetData and key == pcPetData._petNo then
        self:setSealPetContents(uiControls, groupBtns, skillIcon, key, pcPetData, index, isFusion)
        break
      end
    end
  end
end
function PaGlobal_PetList_All:initContents(uiControls, groupBtns, skillIcon)
  for _, control in pairs(uiControls) do
    if control ~= uiControls.parent then
      control:SetShow(false)
      if self._isConsole then
        control:SetIgnore(true)
      end
    end
  end
  for _, control in pairs(groupBtns) do
    control:SetShow(false)
    if self._isConsole then
      control:SetIgnore(true)
    end
  end
  for _, control in pairs(skillIcon) do
    control:SetShow(false)
    if self._isConsole then
      control:SetIgnore(true)
    end
  end
  uiControls.bg:SetShow(true)
  if self._isConsole then
    uiControls.bg:addInputEvent("Mouse_LUp", "")
  end
end
function PaGlobal_PetList_All:setUnsealPetContents(uiControls, groupBtns, skillIcon, petNo64, pcPetData, index, isFusion)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  local iconPath = pcPetData:getIconPath()
  local petNo_s64 = pcPetData:getPcPetNo()
  local petName = pcPetData:getName()
  local petLevel = pcPetData:getLevel()
  local petLovely = pcPetData:getLovely()
  local pethungry = pcPetData:getHungry()
  local petState = pcPetData:getPetState()
  local petMaxLevel = petStaticStatus._maxLevel
  local petMaxHungry = petStaticStatus._maxHungry
  local petRace = petStaticStatus:getPetRace()
  local petTier = petStaticStatus:getPetTier() + 1
  local isJokerPetUse = petStaticStatus._isJokerPetUse
  local skillType, isPassive
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
    isPassive = pcPetData:getSkillParam(1):isPassiveSkill()
  end
  uiControls.gradeLine:SetColor(self._gradeColorConfig[petTier - 1])
  local hungryPercent = pethungry / petMaxHungry * 100
  uiControls.hungryProgress:SetProgressRate(hungryPercent)
  uiControls.hungryPercentText:SetText(string.format("%.1f", hungryPercent) .. "%")
  if hungryPercent >= 100 then
    uiControls.hungryPercentText:SetText(hungryPercent .. "%")
  end
  if true == pcPetData:getPetStaticStatus():isOnlyPcRoom() then
    uiControls.pcRoomIcon:SetShow(true)
  else
    uiControls.pcRoomIcon:SetShow(false)
  end
  local petGrade = ToClient_getGrade(pcPetData:getPetStaticStatus():getPetRace(), pcPetData:getPetStaticStatus():getPetKind())
  if 6 == petGrade then
    uiControls.samePetIcon:addInputEvent("Mouse_On", "PaGlobal_PetList_All:samePetIconTooltip(" .. tostring(index) .. ", false)")
    uiControls.samePetIcon:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    uiControls.samePetIcon:SetShow(true)
  else
    uiControls.samePetIcon:addInputEvent("Mouse_On", "")
    uiControls.samePetIcon:addInputEvent("Mouse_Out", "")
    uiControls.samePetIcon:SetShow(false)
  end
  uiControls.unsealBg:SetShow(true)
  uiControls.icon:SetMonoTone(false)
  uiControls.parent:SetMonoTone(false)
  uiControls.icon:SetColor(Defines.Color.C_FFFFFFFF)
  if false == self._isConsole then
    uiControls.orderFollow:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderWait:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderFind:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 1 .. "," .. index .. ")")
    uiControls.orderGetItem:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 2 .. "," .. index .. ")")
    uiControls.orderPlay:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetPlay_ToOne_All(" .. index .. ")")
    uiControls.btnFeed:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Show_All(" .. index .. ")")
    uiControls.orderFollow:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderWait:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderFind:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 1 .. "," .. index .. ")")
    uiControls.orderGetItem:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 2 .. "," .. index .. ")")
    uiControls.orderPlay:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetPlay_ToAll_All(" .. index .. ")")
    uiControls.orderFollow:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 0 .. ", " .. index .. ")")
    uiControls.orderWait:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 1 .. ", " .. index .. ")")
    uiControls.orderFind:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 2 .. ", " .. index .. ")")
    uiControls.orderGetItem:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 3 .. ", " .. index .. ")")
    uiControls.orderPlay:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 4 .. ", " .. index .. ")")
    uiControls.orderFollow:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderWait:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderFind:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderGetItem:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderPlay:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnFeed:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 11 .. ", " .. index .. ")")
    uiControls.btnFeed:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
  end
  if nil == self._petOrderList._follow[tostring(petNo_s64)] then
    self:initUnsealPetOrderInfo(petNo_s64)
  end
  uiControls.orderPlay:SetShow(self._isPlayOpen or self._isConsole)
  uiControls.orderPlayIcon:SetShow(self._isPlayOpen or self._isConsole)
  uiControls.orderFind:SetShow(true)
  uiControls.orderGetItem:SetShow(true)
  if isPassive then
    self._petOrderList._find[tostring(petNo_s64)] = true
  end
  if self._petOrderList._follow[tostring(petNo_s64)] then
    uiControls.orderFollow:SetShow(true)
  else
    uiControls.orderWait:SetShow(true)
  end
  uiControls.orderFind:SetCheck(self._petOrderList._find[tostring(petNo_s64)])
  uiControls.orderGetItem:SetCheck(self._petOrderList._getItem[tostring(petNo_s64)])
  local petLootingType = pcPetData:getPetLootingType()
  uiControls.orderPlayIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 1, 1, 36, 36)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 37, 1, 72, 36)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 73, 1, 108, 36)
  end
  uiControls.orderPlayIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlayIcon:setRenderTexture(uiControls.orderPlayIcon:getBaseTexture())
  uiControls.orderPlay:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 33, 138, 64, 169)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 65, 138, 96, 169)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 161, 138, 192, 169)
  end
  uiControls.orderPlay:getBaseTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:getOnTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:getClickTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:setRenderTexture(uiControls.orderPlay:getBaseTexture())
  uiControls.name:SetTextMode(__eTextMode_LimitText)
  uiControls.name:SetText(petName)
  if uiControls.name:IsLimitText() and false == self._isConsole then
    uiControls.name:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_NameTooltip_All( true,\t" .. index .. ", " .. tostring(true) .. ", " .. tostring(key) .. ")")
    uiControls.name:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_NameTooltip_All( false,\t" .. index .. ", " .. tostring(true) .. ", " .. tostring(key) .. ")")
  else
    uiControls.name:addInputEvent("Mouse_On", "")
    uiControls.name:addInputEvent("Mouse_Out", "")
  end
  if false == self._isConsole then
    uiControls.hungryProgress:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(5, " .. index .. ")")
    uiControls.hungryProgress:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.hungryPercentText:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(6, " .. index .. ")")
    uiControls.hungryPercentText:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.hungryIcon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(7, " .. index .. ")")
    uiControls.hungryIcon:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnInfo:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(8, " .. index .. ")")
    uiControls.btnInfo:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnSeal:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(9, " .. index .. ")")
    uiControls.btnSeal:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnFusion:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(10, " .. index .. ")")
    uiControls.btnFusion:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnUnFusion:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(10, " .. index .. ")")
    uiControls.btnUnFusion:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
  end
  local uiIndex = 0
  local baseskillindex = pcPetData:getPetBaseSkillIndex()
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  if nil ~= skillStaticStatus then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeStaticWrapper then
      local skillNo = skillStaticStatus:getSkillNo()
      skillIcon[uiIndex]:SetShow(true)
      skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      if false == self._isConsole then
        skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_BaseSkill_ShowTooltip_All( " .. baseskillindex .. ",\"sealPetListSkill\" )")
        skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_BaseSkill_HideTooltip_All()")
        Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "sealPetListSkill")
      end
      uiIndex = uiIndex + 1
    end
  end
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
          skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SkillToolTip_All( " .. skill_idx .. ", \"sealPetListSkill\" )")
          skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_Hide_SkillToolTip_All()")
          Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "sealPetListSkill")
        end
        uiIndex = uiIndex + 1
      end
    end
  end
  uiControls.btnInfo:SetShow(not isFusion and false == self._isConsole)
  uiControls.btnSeal:SetShow(not isFusion and false == self._isConsole)
  uiControls.btnFeed:SetShow(not isFusion and false == self._isConsole)
  if false == self._isConsole then
    uiControls.btnInfo:addInputEvent("Mouse_LUp", "PaGlobal_PetInfo_Open_All( \"" .. tostring(petNo_s64) .. "\" )")
    uiControls.btnSeal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Seal_All( \"" .. tostring(petNo_s64) .. "\")")
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
  if uiControls.property:IsLimitText() and false == self._isConsole then
    uiControls.property:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_PetPropertyTooltip_Show(" .. skillType .. ")")
    uiControls.property:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  else
    uiControls.property:SetIgnore(true)
    uiControls.property:addInputEvent("Mouse_On", "")
    uiControls.property:addInputEvent("Mouse_Out", "")
  end
  if false == isFusion then
    uiControls.gradeMark:SetShow(false)
  else
    uiControls.hungryProgress:SetShow(false)
    uiControls.hungryBg:SetShow(false)
    uiControls.hungryIcon:SetShow(false)
    uiControls.hungryPercentText:SetShow(false)
    local grade = ToClient_getGrade(petStaticStatus:getPetRace(), petStaticStatus:getPetKind())
    uiControls.gradeMark:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Pet_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(uiControls.gradeMark, self._gradeTypeUV[grade - 1][1], self._gradeTypeUV[grade - 1][2], self._gradeTypeUV[grade - 1][3], self._gradeTypeUV[grade - 1][4])
    uiControls.gradeMark:getBaseTexture():setUV(x1, y1, x2, y2)
    uiControls.gradeMark:setRenderTexture(uiControls.gradeMark:getBaseTexture())
    uiControls.gradeMark:SetShow(99 ~= petStaticStatus:getPetRace())
  end
  if self._isConsole then
    if isFusion then
      uiControls.unsealBg:addInputEvent("Mouse_LUp", "")
    else
      uiControls.unsealBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Show_ConsolePopUP_All(true , " .. index .. ")")
    end
  end
  self:changeFeedButtonStatus(uiControls.btnFeed)
end
function PaGlobal_PetList_All:changeFeedButtonStatus(button)
  local texturePath = "combine/etc/combine_etc_pet_03.dds"
  if ToClient_Pet_GetFeedItemCount() == 0 then
    button:ChangeTextureInfoNameAsync(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(button, 949, 38, 985, 74)
    button:getBaseTexture():setUV(x1, y1, x2, y2)
    button:setRenderTexture(button:getBaseTexture())
    button:ChangeOnTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 986, 38, 1022, 74)
    button:getOnTexture():setUV(x1, y1, x2, y2)
    button:ChangeClickTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 1023, 38, 1059, 74)
    button:getClickTexture():setUV(x1, y1, x2, y2)
    local btnFeedIcon = UI.getChildControl(button, "Static_FeedingIcon")
    if btnFeedIcon ~= nil then
      btnFeedIcon:SetShow(false)
    end
  else
    local texturePath = "combine/btn/combine_btn_00.dds"
    button:ChangeTextureInfoNameAsync(texturePath)
    local x1, y1, x2, y2 = setTextureUV_Func(button, 1, 1, 41, 41)
    button:getBaseTexture():setUV(x1, y1, x2, y2)
    button:setRenderTexture(button:getBaseTexture())
    button:ChangeOnTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 42, 1, 82, 41)
    button:getOnTexture():setUV(x1, y1, x2, y2)
    button:ChangeClickTextureInfoNameAsync(texturePath)
    x1, y1, x2, y2 = setTextureUV_Func(button, 83, 1, 123, 41)
    button:getClickTexture():setUV(x1, y1, x2, y2)
    local btnFeedIcon = UI.getChildControl(button, "Static_FeedingIcon")
    if btnFeedIcon ~= nil then
      btnFeedIcon:SetShow(true)
    end
  end
end
function PaGlobal_PetList_All:setSealPetContents(uiControls, groupBtns, skillIcon, petNo64, pcPetData, index, isFusion)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  local iconPath = pcPetData:getIconPath()
  local petNo_s64 = pcPetData._petNo
  local petName = pcPetData:getName()
  local petLevel = pcPetData._level
  local petLovely = pcPetData._lovely
  local pethungry = pcPetData._hungry
  local petState = pcPetData._petState
  local petMaxLevel = petStaticStatus._maxLevel
  local petMaxHungry = petStaticStatus._maxHungry
  local petRace = petStaticStatus:getPetRace()
  local petTier = petStaticStatus:getPetTier() + 1
  local isJokerPetUse = petStaticStatus._isJokerPetUse
  local skillType, isPassive
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
    isPassive = pcPetData:getSkillParam(1):isPassiveSkill()
  end
  uiControls.gradeLine:SetColor(self._gradeColorConfig[petTier - 1])
  local hungryPercent = pethungry / petMaxHungry * 100
  uiControls.hungryProgress:SetProgressRate(hungryPercent)
  uiControls.hungryPercentText:SetText(string.format("%.1f", hungryPercent) .. "%")
  if hungryPercent >= 100 then
    uiControls.hungryPercentText:SetText(hungryPercent .. "%")
  end
  if true == pcPetData:getPetStaticStatus():isOnlyPcRoom() then
    uiControls.pcRoomIcon:SetShow(true)
  else
    uiControls.pcRoomIcon:SetShow(false)
  end
  local petGrade = ToClient_getGrade(pcPetData:getPetStaticStatus():getPetRace(), pcPetData:getPetStaticStatus():getPetKind())
  if 6 == petGrade then
    uiControls.samePetIcon:addInputEvent("Mouse_On", "PaGlobal_PetList_All:samePetIconTooltip(" .. tostring(index) .. ", true)")
    uiControls.samePetIcon:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    uiControls.samePetIcon:SetShow(true)
  else
    uiControls.samePetIcon:addInputEvent("Mouse_On", "")
    uiControls.samePetIcon:addInputEvent("Mouse_Out", "")
    uiControls.samePetIcon:SetShow(false)
  end
  if false == isFusion and false == self._isConsole then
    for uIdx = 1, self._GroupCount do
      groupBtns[uIdx]:SetShow(true)
      groupBtns[uIdx]:addInputEvent("Mouse_LUp", "PaGlobal_PetList_GroupSealCheck_All(\"" .. tostring(petNo_s64) .. "\", " .. tostring(uIdx) .. " )")
      groupBtns[uIdx]:SetCheck(self:isCheckGroupBtnByPetNo(petNo_s64, uIdx))
      groupBtns[uIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ",6," .. tostring(uIdx) .. ")")
      groupBtns[uIdx]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    end
    if _ContentsGroup_PetPresetExpansion == true then
      local currentPresetCount = ToClient_GetPetPresetCount()
      for uIdx = 6, self._maxPresetCount do
        local stc_IconLock = UI.getChildControl(groupBtns[uIdx], "Static_IconLock")
        groupBtns[uIdx]:addInputEvent("Mouse_LUp", "PaGlobal_PetList_GroupSealCheck_All(\"" .. tostring(petNo_s64) .. "\", " .. tostring(uIdx) .. " )")
        groupBtns[uIdx]:SetShow(true)
        if uIdx > currentPresetCount then
          groupBtns[uIdx]:removeInputEvent("Mouse_LUp")
          groupBtns[uIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(true, 1, " .. tostring(uIdx) .. ", " .. index .. ")")
          groupBtns[uIdx]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_RestrictedPresetTooltip(false)")
          groupBtns[uIdx]:ChangeTextureInfoTextureIDAsync("Combine_Btn_Basic_Normal", __eUITextureTypeBase)
          groupBtns[uIdx]:ChangeTextureInfoTextureIDAsync("Combine_Btn_Basic_Normal", __eUITextureTypeOn)
          groupBtns[uIdx]:ChangeTextureInfoTextureIDAsync("Combine_Btn_Basic_Normal", __eUITextureTypeClick)
          groupBtns[uIdx]:SetText("")
          groupBtns[uIdx]:SetCheck(false)
          stc_IconLock:SetShow(true)
        else
          groupBtns[uIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ",6," .. tostring(uIdx) .. ")")
          groupBtns[uIdx]:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
          groupBtns[uIdx]:ChangeTextureInfoTextureIDAsync("Combine_Btn_Basic_Normal", __eUITextureTypeBase)
          groupBtns[uIdx]:ChangeTextureInfoTextureIDAsync("Combine_Btn_Basic_Over", __eUITextureTypeOn)
          groupBtns[uIdx]:ChangeTextureInfoTextureIDAsync("Combine_Btn_Basic_OverClick", __eUITextureTypeClick)
          groupBtns[uIdx]:SetCheck(self:isCheckGroupBtnByPetNo(petNo_s64, uIdx))
          groupBtns[uIdx]:SetText(tostring(uIdx))
          stc_IconLock:SetShow(false)
        end
      end
    end
  end
  self:initSealPetOrderInfo(petNo_s64)
  uiControls.name:SetTextMode(__eTextMode_LimitText)
  uiControls.name:SetText(petName)
  if uiControls.name:IsLimitText() and false == self._isConsole then
    uiControls.name:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_NameTooltip_All( true,\t" .. index .. ", " .. tostring(false) .. ", " .. tostring(key) .. ")")
    uiControls.name:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_NameTooltip_All( false,\t" .. index .. ", " .. tostring(false) .. ", " .. tostring(key) .. ")")
  else
    uiControls.name:addInputEvent("Mouse_On", "")
    uiControls.name:addInputEvent("Mouse_Out", "")
  end
  if false == self._isConsole then
    uiControls.btnUp:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangePosition_All(true," .. index .. ")")
    uiControls.btnUp:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 4 .. ")")
    uiControls.btnUp:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnUp:SetShow(true)
    uiControls.btnDown:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 5 .. ")")
    uiControls.btnDown:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnDown:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangePosition_All(false," .. index .. ")")
    uiControls.btnDown:SetShow(true)
    uiControls.btnUnseal:SetShow(true)
    uiControls.btnUnseal:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 0 .. ")")
    uiControls.btnUnseal:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.hungryProgress:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 1 .. ")")
    uiControls.hungryProgress:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.hungryPercentText:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 2 .. ")")
    uiControls.hungryPercentText:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.hungryIcon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 3 .. ")")
    uiControls.hungryIcon:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnFusion:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 7 .. ")")
    uiControls.btnFusion:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnUnFusion:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 7 .. ")")
    uiControls.btnUnFusion:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnChangeSkill:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 8 .. ")")
    uiControls.btnChangeSkill:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnChangeName:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeName( \"" .. tostring(petNo_s64) .. "\",\"" .. tostring(iconPath:gsub("\\", "\\\\")) .. "\")")
    uiControls.btnChangeName:addInputEvent("Mouse_On", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(true, " .. index .. ", " .. 9 .. ")")
    uiControls.btnChangeName:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetListNew_SimpleTooltipBTN_All(false)")
    uiControls.btnChangeName:SetShow(true)
  end
  local isLeader = ToClient_isLeaderPet(petNo_s64)
  local uiIndex = 0
  local baseskillindex = pcPetData:getPetBaseSkillIndex()
  if isLeader == true then
    baseskillindex = ToClient_getLeaderBaseSkill(petNo_s64)
  end
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  if nil ~= skillStaticStatus then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeStaticWrapper then
      local skillNo = skillStaticStatus:getSkillNo()
      skillIcon[uiIndex]:SetShow(true)
      skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      if false == self._isConsole then
        skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_BaseSkill_ShowTooltip_All( " .. baseskillindex .. ", \"unSealPetListSkill\" )")
        skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_BaseSkill_HideTooltip_All()")
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
          skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SkillToolTip_All( " .. skill_idx .. ", \"unSealPetListSkill\" )")
          skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_Hide_SkillToolTip_All()")
          Panel_SkillTooltip_SetPosition(skillNo, skillIcon[uiIndex], "unSealPetListSkill")
        end
        uiIndex = uiIndex + 1
      end
    end
  end
  local isFusionAble = self:fusionButtonShowCheck(petNo_s64, petTier, petRace)
  uiControls.btnFusion:SetShow(isFusionAble)
  uiControls.btnUnFusion:SetShow(true == self:unFusionButtonCheck(petNo_s64))
  local isFusionMonoTone = self:fusionButtonMonoToneCheck(petNo_s64, petTier, petRace)
  uiControls.btnCantFusion:SetShow(isFusionMonoTone)
  uiControls.icon:SetMonoTone(isFusionMonoTone)
  uiControls.parent:SetMonoTone(isFusionMonoTone)
  if true == isFusionMonoTone then
    uiControls.icon:SetColor(Defines.Color.C_FFD20000)
  else
    uiControls.icon:SetColor(Defines.Color.C_FFFFFFFF)
  end
  if false == self:unFusionButtonCheck(petNo_s64) then
    uiControls.btnUnseal:SetMonoTone(false)
  else
    uiControls.btnUnseal:SetMonoTone(true)
  end
  uiControls.btnUnseal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Unseal_All( \"" .. tostring(petNo_s64) .. "\" , false )")
  uiControls.btnFusion:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_Set_All( \"" .. tostring(petNo_s64) .. "\" ," .. petRace .. ", " .. petTier .. ", " .. index .. "," .. tostring(isJokerPetUse) .. " )")
  uiControls.btnCantFusion:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_Set_All( \"" .. tostring(petNo_s64) .. "\" ," .. petRace .. ", " .. petTier .. ", " .. index .. "," .. tostring(isJokerPetUse) .. " )")
  uiControls.btnUnFusion:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_UnSet_All( \"" .. tostring(petNo_s64) .. "\"," .. index .. " )")
  uiControls.btnFusion:SetPosX(uiControls.btnUnseal:GetPosX() - (uiControls.btnFusion:GetSizeX() - 10))
  uiControls.btnCantFusion:SetPosX(uiControls.btnUnseal:GetPosX() - (uiControls.btnFusion:GetSizeX() - 4))
  uiControls.btnUnFusion:SetPosX(uiControls.btnUnseal:GetPosX() - (uiControls.btnFusion:GetSizeX() - 4))
  if true == isFusion then
    uiControls.btnUnseal:SetShow(false)
    uiControls.btnUp:SetShow(false)
    uiControls.btnDown:SetShow(false)
    uiControls.btnFusion:SetPosX(uiControls.btnUnseal:GetPosX() + uiControls.btnFusion:GetSizeX())
    uiControls.btnCantFusion:SetPosX(uiControls.btnUnseal:GetPosX() + uiControls.btnFusion:GetSizeX())
    uiControls.btnUnFusion:SetPosX(uiControls.btnUnseal:GetPosX() + uiControls.btnFusion:GetSizeX())
    uiControls.btnLeader:SetShow(false)
  end
  uiControls.icon:ChangeTextureInfoNameAsync(iconPath)
  uiControls.tier:SetFontColor(self._gradeColorConfig[petTier - 1])
  uiControls.tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petTier))
  if _ContentsGroup_PetLevelDelete then
    uiControls.level:SetShow(false)
    if self._isConsole == false then
      uiControls.btnChangeName:SetPosX(uiControls.level:GetPosX())
      uiControls.name:SetPosX(uiControls.btnChangeName:GetPosX() + 30)
    else
      uiControls.name:SetPosX(uiControls.level:GetPosX())
    end
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
  if uiControls.property:IsLimitText() and false == self._isConsole then
    uiControls.property:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_PetPropertyTooltip_Show(" .. skillType .. ")")
    uiControls.property:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  else
    uiControls.property:SetIgnore(true)
    uiControls.property:addInputEvent("Mouse_On", "")
    uiControls.property:addInputEvent("Mouse_Out", "")
  end
  if false == isFusion then
    uiControls.gradeMark:SetShow(false)
  else
    uiControls.hungryProgress:SetShow(false)
    uiControls.hungryBg:SetShow(false)
    uiControls.hungryIcon:SetShow(false)
    uiControls.hungryPercentText:SetShow(false)
    local grade = ToClient_getGrade(petStaticStatus:getPetRace(), petStaticStatus:getPetKind())
    uiControls.gradeMark:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Pet_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(uiControls.gradeMark, self._gradeTypeUV[grade - 1][1], self._gradeTypeUV[grade - 1][2], self._gradeTypeUV[grade - 1][3], self._gradeTypeUV[grade - 1][4])
    uiControls.gradeMark:getBaseTexture():setUV(x1, y1, x2, y2)
    uiControls.gradeMark:setRenderTexture(uiControls.gradeMark:getBaseTexture())
    uiControls.gradeMark:SetShow(99 ~= petStaticStatus:getPetRace())
  end
  if self._isConsole then
    if isFusion then
      if true == uiControls.btnFusion:GetShow() then
        uiControls.bg:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_Set_All( \"" .. tostring(petNo_s64) .. "\" ," .. petRace .. ", " .. petTier .. ", " .. index .. "," .. tostring(isJokerPetUse) .. " )")
      end
      if true == uiControls.btnCantFusion:GetShow() then
        uiControls.bg:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_Set_All( \"" .. tostring(petNo_s64) .. "\" ," .. petRace .. ", " .. petTier .. ", " .. index .. "," .. tostring(isJokerPetUse) .. " )")
      end
      if true == uiControls.btnUnFusion:GetShow() then
        uiControls.bg:addInputEvent("Mouse_LUp", "PaGlobal_PetFusion_Compose_UnSet_All( \"" .. tostring(petNo_s64) .. "\"," .. index .. " )")
      end
    else
      uiControls.bg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Show_ConsolePopUP_All( false , " .. index .. ")")
    end
  end
  local isLeader = ToClient_isLeaderPet(petNo_s64)
  if petTier == self._leaderPetTier then
    if self._isConsole == true or isFusion == true then
      uiControls.btnLeader:SetShow(false)
    else
      uiControls.btnLeader:SetShow(true)
    end
    if isLeader == true then
      uiControls.btnLeader:SetShow(false)
      uiControls.leaderIcon:SetShow(true)
    else
      uiControls.leaderIcon:SetShow(false)
      uiControls.btnLeader:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_ChangeLeader( \"" .. tostring(petNo_s64) .. "\")")
    end
  end
  uiControls.btnChangeSkill:SetShow(false)
  if _ContenstGroup_PetSkillChange == true then
    if isFusion == false and self._isConsole == false and self._changeSkillTierLimit <= petTier - 1 and pcPetData:getPetStaticStatus():isOnlyPcRoom() == false then
      uiControls.btnChangeSkill:SetShow(true)
      uiControls.btnChangeSkill:addInputEvent("Mouse_LUp", "PaGlobal_PetSkill_Change_Open_All( \"" .. tostring(petNo_s64) .. "\")")
    else
      uiControls.btnChangeSkill:SetShow(false)
    end
  end
end
function PaGlobal_PetList_All:setUnsealLeaderPetContents(petNo64, index)
  if false == _ContentsGroup_PetLeader then
    return
  end
  local pcPetData = ToClient_getPetUnSealedDataByPetNo(petNo64)
  if nil == pcPetData then
    return
  end
  local uiControls = self._ui._petLeader
  uiControls.bg:SetShow(true)
  uiControls.unsealBg:SetShow(true)
  uiControls.bg:SetIgnore(not self._isConsole)
  uiControls.unsealBg:SetIgnore(not self._isConsole)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  local iconPath = pcPetData:getIconPath()
  local petNo_s64 = pcPetData:getPcPetNo()
  local petName = pcPetData:getName()
  local petLevel = pcPetData:getLevel()
  local petLovely = pcPetData:getLovely()
  local pethungry = pcPetData:getHungry()
  local petState = pcPetData:getPetState()
  local petMaxLevel = petStaticStatus._maxLevel
  local petMaxHungry = petStaticStatus._maxHungry
  local petRace = petStaticStatus:getPetRace()
  local petTier = petStaticStatus:getPetTier() + 1
  local isJokerPetUse = petStaticStatus._isJokerPetUse
  local skillType, isPassive
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
    isPassive = pcPetData:getSkillParam(1):isPassiveSkill()
  end
  uiControls.gradeLine:SetColor(self._gradeColorConfig[petTier - 1])
  local hungryPercent = pethungry / petMaxHungry * 100
  uiControls.hungryProgress:SetProgressRate(hungryPercent)
  uiControls.hungryPercentText:SetText(string.format("%.1f", hungryPercent) .. "%")
  if hungryPercent >= 100 then
    uiControls.hungryPercentText:SetText(hungryPercent .. "%")
  end
  if false == self._isConsole then
    uiControls.orderFollow:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderWait:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderFind:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 1 .. "," .. index .. ")")
    uiControls.orderGetItem:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetOrder_ToOne_All(" .. 2 .. "," .. index .. ")")
    uiControls.orderPlay:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_SetPlay_ToOne_All(" .. index .. ")")
    uiControls.btnFeed:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_FeedUI_Show_All(" .. index .. ")")
    uiControls.orderFollow:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderWait:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 0 .. "," .. index .. ")")
    uiControls.orderFind:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 1 .. "," .. index .. ")")
    uiControls.orderGetItem:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetOrder_ToAll_All(" .. 2 .. "," .. index .. ")")
    uiControls.orderPlay:addInputEvent("Mouse_RUp", "HandleEventRUp_PetList_SetPlay_ToAll_All(" .. index .. ")")
    uiControls.orderFollow:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 0 .. ", " .. index .. ")")
    uiControls.orderWait:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 1 .. ", " .. index .. ")")
    uiControls.orderFind:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 2 .. ", " .. index .. ")")
    uiControls.orderGetItem:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 3 .. ", " .. index .. ")")
    uiControls.orderPlay:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 4 .. ", " .. index .. ")")
    uiControls.orderFollow:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderWait:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderFind:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderGetItem:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.orderPlay:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnFeed:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(" .. 11 .. ", " .. index .. ")")
    uiControls.btnFeed:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
  end
  if nil == self._petOrderList._follow[tostring(petNo_s64)] then
    self:initUnsealPetOrderInfo(petNo_s64)
  end
  uiControls.orderPlay:SetShow(self._isPlayOpen or self._isConsole)
  uiControls.orderPlayIcon:SetShow(self._isPlayOpen or self._isConsole)
  uiControls.orderFind:SetShow(true)
  uiControls.orderGetItem:SetShow(true)
  uiControls.orderFollow:SetShow(false)
  uiControls.orderWait:SetShow(false)
  if isPassive then
    self._petOrderList._find[tostring(petNo_s64)] = true
  end
  if self._petOrderList._follow[tostring(petNo_s64)] then
    uiControls.orderFollow:SetShow(true)
  else
    uiControls.orderWait:SetShow(true)
  end
  uiControls.orderFind:SetCheck(self._petOrderList._find[tostring(petNo_s64)])
  uiControls.orderGetItem:SetCheck(self._petOrderList._getItem[tostring(petNo_s64)])
  local petLootingType = pcPetData:getPetLootingType()
  uiControls.orderPlayIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 1, 1, 36, 36)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 37, 1, 72, 36)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 73, 1, 108, 36)
  end
  uiControls.orderPlayIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlayIcon:setRenderTexture(uiControls.orderPlayIcon:getBaseTexture())
  uiControls.orderPlay:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 33, 138, 64, 169)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 65, 138, 96, 169)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 161, 138, 192, 169)
  end
  uiControls.orderPlay:getBaseTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:getOnTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:getClickTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:setRenderTexture(uiControls.orderPlay:getBaseTexture())
  uiControls.name:SetTextMode(__eTextMode_LimitText)
  uiControls.name:SetText(petName)
  if uiControls.name:IsLimitText() and false == self._isConsole then
    uiControls.name:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_NameTooltip_All( true,\t" .. index .. ", " .. tostring(true) .. ", " .. tostring(key) .. ")")
    uiControls.name:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_NameTooltip_All( false,\t" .. index .. ", " .. tostring(true) .. ", " .. tostring(key) .. ")")
  else
    uiControls.name:addInputEvent("Mouse_On", "")
    uiControls.name:addInputEvent("Mouse_Out", "")
  end
  if false == self._isConsole then
    uiControls.hungryProgress:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(5, " .. index .. ")")
    uiControls.hungryProgress:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.hungryPercentText:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(6, " .. index .. ")")
    uiControls.hungryPercentText:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.hungryIcon:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(7, " .. index .. ")")
    uiControls.hungryIcon:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnInfo:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(8, " .. index .. ")")
    uiControls.btnInfo:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
    uiControls.btnSeal:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_OrderTooltip_All(9, " .. index .. ")")
    uiControls.btnSeal:addInputEvent("Mouse_Out", "HandleEventMouseOn_PetList_OrderTooltip_All()")
  end
  uiControls.btnChangeSkill:SetShow(false)
  local uiIndex = 0
  local baseskillindex = ToClient_getLeaderBaseSkill(petNo_s64)
  local skillMaxCount = ToClient_getPetEquipSkillMax()
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  if nil ~= skillStaticStatus then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeStaticWrapper then
      local skillNo = skillStaticStatus:getSkillNo()
      uiControls.skillIcon[uiIndex]:SetShow(true)
      uiControls.skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      if false == self._isConsole then
        uiControls.skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_BaseSkill_ShowTooltip_All( " .. baseskillindex .. ",\"sealPetListSkill\" )")
        uiControls.skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_BaseSkill_HideTooltip_All()")
        Panel_SkillTooltip_SetPosition(skillNo, uiControls.skillIcon[uiIndex], "sealPetListSkill")
      end
      uiIndex = uiIndex + 1
    end
  end
  for skill_idx = 0, skillMaxCount - 1 do
    local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
    local isLearn = pcPetData:isPetEquipSkillLearned(skill_idx)
    if true == isLearn and nil ~= skillStaticStatus then
      local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
      if nil ~= skillTypeStaticWrapper then
        local skillNo = skillStaticStatus:getSkillNo()
        uiControls.skillIcon[uiIndex]:SetShow(true)
        uiControls.skillIcon[uiIndex]:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
        if false == self._isConsole then
          uiControls.skillIcon[uiIndex]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_Show_SkillToolTip_All( " .. skill_idx .. ", \"sealPetListSkill\" )")
          uiControls.skillIcon[uiIndex]:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetList_Hide_SkillToolTip_All()")
          Panel_SkillTooltip_SetPosition(skillNo, uiControls.skillIcon[uiIndex], "sealPetListSkill")
        end
        uiIndex = uiIndex + 1
      end
    end
  end
  uiControls.btnInfo:SetShow(not isFusion and false == self._isConsole)
  uiControls.btnSeal:SetShow(not isFusion and false == self._isConsole)
  uiControls.btnFeed:SetShow(not isFusion and false == self._isConsole)
  if false == self._isConsole then
    uiControls.btnInfo:addInputEvent("Mouse_LUp", "PaGlobal_PetInfo_Open_All( \"" .. tostring(petNo_s64) .. "\" )")
    uiControls.btnSeal:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Seal_All( \"" .. tostring(petNo_s64) .. "\")")
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
  if uiControls.property:IsLimitText() and false == self._isConsole then
    uiControls.property:addInputEvent("Mouse_On", "HandleEventMouseOn_PetList_PetPropertyTooltip_Show(" .. skillType .. ")")
    uiControls.property:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
  else
    uiControls.property:SetIgnore(true)
    uiControls.property:addInputEvent("Mouse_On", "")
    uiControls.property:addInputEvent("Mouse_Out", "")
  end
  uiControls.gradeMark:SetShow(false)
  if self._isConsole == true then
    uiControls.property:SetIgnore(true)
    uiControls.unsealBg:addInputEvent("Mouse_LUp", "HandleEventLUp_PetList_Show_ConsolePopUP_All(true , " .. index .. ")")
    uiControls.unsealBg:addInputEvent("Mouse_On", "PaGlobal_PetList_All:unsealLeaderPetOrderUpdate(" .. index .. ")")
  else
    uiControls.unsealBg:addInputEvent("Mouse_LUp", "")
  end
  if PaGlobal_PetList_All._showLeaderEffect == true then
    PaGlobal_PetList_All._ui._petLeader.bg:EraseAllEffect()
    PaGlobal_PetList_All._ui._petLeader.bg:AddEffect("fUI_InGame_Pet_Out_01A", false, 0, 0)
    PaGlobal_PetList_All._ui.txt_LeaderSkillList:EraseAllEffect()
    PaGlobal_PetList_All._ui.txt_LeaderSkillList:AddEffect("fUI_InGame_Light_05A", false, 0, 0)
    PaGlobal_PetList_All._showLeaderEffect = false
  end
  self:changeFeedButtonStatus(uiControls.btnFeed)
  self._isUnsealLeaderPet = true
end
function PaGlobal_PetList_All:unsealLeaderPetOrderUpdate(index)
  if false == _ContentsGroup_PetLeader then
    return
  end
  local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
  if nil == pcPetData then
    return
  end
  local uiControls = self._ui._petLeader
  local petNo_s64 = pcPetData:getPcPetNo()
  local skillType, isPassive
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
    isPassive = pcPetData:getSkillParam(1):isPassiveSkill()
  end
  if nil == self._petOrderList._follow[tostring(petNo_s64)] then
    self:initUnsealPetOrderInfo(petNo_s64)
  end
  uiControls.orderPlay:SetShow(self._isPlayOpen or self._isConsole)
  uiControls.orderPlayIcon:SetShow(self._isPlayOpen or self._isConsole)
  uiControls.orderFind:SetShow(true)
  uiControls.orderGetItem:SetShow(true)
  uiControls.orderFollow:SetShow(false)
  uiControls.orderWait:SetShow(false)
  if isPassive then
    self._petOrderList._find[tostring(petNo_s64)] = true
  end
  if self._petOrderList._follow[tostring(petNo_s64)] then
    uiControls.orderFollow:SetShow(true)
  else
    uiControls.orderWait:SetShow(true)
  end
  uiControls.orderFind:SetCheck(self._petOrderList._find[tostring(petNo_s64)])
  uiControls.orderGetItem:SetCheck(self._petOrderList._getItem[tostring(petNo_s64)])
  local petLootingType = pcPetData:getPetLootingType()
  uiControls.orderPlayIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 1, 1, 36, 36)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 37, 1, 72, 36)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlayIcon, 73, 1, 108, 36)
  end
  uiControls.orderPlayIcon:getBaseTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlayIcon:setRenderTexture(uiControls.orderPlayIcon:getBaseTexture())
  uiControls.orderPlay:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Pet_00.dds")
  local x1, y1, x2, y2
  if 0 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 33, 138, 64, 169)
  elseif 1 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 65, 138, 96, 169)
  elseif 2 == petLootingType then
    x1, y1, x2, y2 = setTextureUV_Func(uiControls.orderPlay, 161, 138, 192, 169)
  end
  uiControls.orderPlay:getBaseTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:getOnTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:getClickTexture():setUV(x1, y1, x2, y2)
  uiControls.orderPlay:setRenderTexture(uiControls.orderPlay:getBaseTexture())
end
function PaGlobal_PetList_All:samePetIconTooltip(index, isSealed)
  local key
  if false == isSealed then
    local pcPetData = ToClient_getPetUnsealedDataByIndex(index)
    key = pcPetData:getPcPetNo()
  else
    local pcPetData = ToClient_getPetSealedDataByIndex(index)
    key = pcPetData._petNo
  end
  local contents = self._ui.list2_Pet:GetContentByKey(key)
  if nil == contents then
    return
  end
  local control = UI.getChildControl(contents, "Static_SamePet")
  local txt = PAGetString(Defines.StringSheet_GAME, "LUA_PET_ICONTOOLTIP_SAMETYPE")
  TooltipSimple_Show(control, txt, "")
end
function PaGlobal_PetList_All:updatePenalSize()
  local addPcRoomSizeY = 0
  local addLeaderPetSizeY = 0
  local addConsoleSizeY = 0
  if ToClient_isButtonOnRegisteredPetForPcRoom() == true or self._pcFilterInitialize == true and self._isConsole == false then
    addPcRoomSizeY = self._ui_pc.stc_FilterBG:GetSizeY()
  end
  if self._isUnsealLeaderPet == true and self._ui_pc.rdo_PCRoom:IsChecked() == false then
    addLeaderPetSizeY = 37
  end
  if self._isConsole == true then
    addConsoleSizeY = -self._ui._petLeader.bg:GetSizeY() + 50
  end
  Panel_Window_PetList_All:SetSize(Panel_Window_PetList_All:GetSizeX(), self._originPanelSizeY + addPcRoomSizeY + addLeaderPetSizeY + addConsoleSizeY + 10)
  self._ui.stc_InsideBG:SetSize(self._ui.stc_InsideBG:GetSizeX(), self._originInsideBGSizeY + addPcRoomSizeY + addLeaderPetSizeY + addConsoleSizeY + 10)
  self._ui_pc.stc_DesBG:SetSpanSize(self._ui_pc.stc_DesBG:GetSpanSize().x, self._originDesBGSpanY + addPcRoomSizeY + addLeaderPetSizeY + addConsoleSizeY + 10)
  self._ui_pc.stc_FindGroupBG:SetSpanSize(self._ui_pc.stc_FindGroupBG:GetSpanSize().x, self._originFindGroupBGSpanY + addPcRoomSizeY + addLeaderPetSizeY + addConsoleSizeY + 10)
  self._ui_pc.stc_BtnGroup:SetSpanSize(self._ui_pc.stc_BtnGroup:GetSpanSize().x, self._originBtnGroupSpanY + addPcRoomSizeY + addLeaderPetSizeY + addConsoleSizeY + 10)
  self._ui.stc_SkillInfoBG:SetSpanSize(self._ui.stc_SkillInfoBG:GetSpanSize().x, self._originSkillInfoBGSpanY + addPcRoomSizeY + addLeaderPetSizeY + 10)
  self._ui._petLeader.bg:SetSpanSize(self._ui._petLeader.bg:GetSpanSize().x, self._originLeaderPetSpanY + addPcRoomSizeY)
  self._ui_pc.btn_RegistPCRoom:SetPosY(self._originBtnRegistPCRoomSpanY + addPcRoomSizeY)
  self._ui_console.stc_Bottom_KeyGuideBG:SetPosY(self._ui_pc.stc_FindGroupBG:GetPosY() + self._ui_pc.stc_FindGroupBG:GetSizeY() + 10)
  self._ui.list2_Pet:requestUpdateVisible()
  self._ui.list2_Pet:changeScrollMoveIndex(0)
end
function PaGlobal_PetList_All:updateListSize(isUnsealLeaderPet, noclearscroll)
  local list2SpanSizeY = 0
  local leaderSpanSizeY = 0
  local leaderSizeY = 0
  if ToClient_isButtonOnRegisteredPetForPcRoom() == true or self._pcFilterInitialize == true and self._isConsole == false then
    list2SpanSizeY = self._ui_pc.stc_FilterBG:GetSizeY()
  end
  if isUnsealLeaderPet == true and self._ui_pc.rdo_PCRoom:IsChecked() == false then
    leaderSpanSizeY = self._ui._petLeader.bg:GetSizeY()
    leaderSizeY = self._ui._petLeader.bg:GetSizeY() - 37
  end
  self._ui.list2_Pet:SetSpanSize(self._ui.list2_Pet:GetSpanSize().x, self._originPetListSpanY + list2SpanSizeY + leaderSpanSizeY)
  self._ui.list2_Pet:SetSize(self._ui.list2_Pet:GetSizeX(), self._originListSizeY - leaderSizeY)
  if noclearscroll == nil or noclearscroll == false then
    self._ui.list2_Pet:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetList_ListCreate_All")
    self._ui.list2_Pet:createChildContent(__ePAUIList2ElementManagerType_List)
  end
  self._ui.list2_Pet:GetVScroll():SetControlPos(0)
  self._ui.list2_Pet:setCurrenttoIndex(0)
end
function PaGlobal_PetList_All:CheckPetLeaderUnseal()
  self._isUnsealLeaderPet = false
  local unsealPetCount = ToClient_getPetUnsealedList()
  for index = 0, unsealPetCount do
    local petData = ToClient_getPetUnsealedDataByIndex(index)
    if nil ~= petData and ToClient_isLeaderPet(petData:getPcPetNo()) == true then
      self._isUnsealLeaderPet = true
    end
  end
end
