function PaGlobal_ServantSimulator:initDetailControl()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._detail._stc_leftBg = UI.getChildControl(self._ui._stc_detailBg, "Static_LeftBg")
  local horseImageBg = UI.getChildControl(self._ui._detail._stc_leftBg, "Static_HorseImageBG")
  self._ui._detail._stc_horseImageFrame = UI.getChildControl(horseImageBg, "Static_HorseImage")
  self._ui._detail._stc_horseImage = UI.getChildControl(self._ui._detail._stc_horseImageFrame, "Static_RealImage")
  self._ui._detail._stc_selectHorse = UI.getChildControl(self._ui._detail._stc_horseImageFrame, "Static_SelectHorse")
  self._ui._detail._btn_changeHorse = UI.getChildControl(self._ui._detail._stc_horseImageFrame, "Button_ChangeHorse")
  self._ui._detail._stc_horseName = UI.getChildControl(self._ui._detail._stc_horseImageFrame, "StaticText_Name")
  self._ui._detail._stc_horseGender = UI.getChildControl(horseImageBg, "Static_Gender")
  self._ui._detail._btn_reset = UI.getChildControl(horseImageBg, "Button_Reset")
  self._ui._detail._stc_equipSlot = UI.getChildControl(self._ui._detail._stc_leftBg, "Static_EquipSlot")
  self._ui._detail._stc_equipTitle = UI.getChildControl(self._ui._detail._stc_equipSlot, "StaticText_EquipTitle")
  self._ui._detail._checkbox_imprint = UI.getChildControl(self._ui._detail._stc_leftBg, "CheckButton_Seal")
  self._ui._detail._stc_horseLevel = UI.getChildControl(self._ui._detail._stc_leftBg, "Static_HorseLevel")
  self._ui._detail._stc_rightBg = UI.getChildControl(self._ui._stc_detailBg, "Static_RightBg")
  self._ui._detail._stc_lifeLevel = UI.getChildControl(self._ui._detail._stc_rightBg, "Static_LifeLevel")
  self._ui._detail._stc_noData = UI.getChildControl(self._ui._detail._stc_rightBg, "StaticText_NoData")
  self._ui._detail._stc_vitalityText = UI.getChildControl(self._ui._detail._stc_rightBg, "StaticText_DefaultStat")
  self._ui._detail._stc_lifeAbilityHelp = UI.getChildControl(self._ui._detail._stc_rightBg, "Static_LifeAbilityHelp")
  self._ui._detail._lst_vitalityList = UI.getChildControl(self._ui._detail._stc_rightBg, "List2_VitalityList")
  self._ui._detail._stc_abilityText = UI.getChildControl(self._ui._detail._stc_rightBg, "StaticText_AbilityStat")
  self._ui._detail._lst_abilityList = UI.getChildControl(self._ui._detail._stc_rightBg, "List2_AbilityList")
  self._ui._detail._txt_rightBottomDesc = UI.getChildControl(self._ui._stc_detailBg, "StaticText_Bottom_Desc")
  self._ui._detail._stc_skillStat = UI.getChildControl(self._ui._detail._stc_rightBg, "StaticText_SkillStat")
  self._ui._detail._stc_studySkillHelp = UI.getChildControl(self._ui._detail._stc_rightBg, "Static_StudySkillHelp")
  self._ui._detail._lst_skillList = UI.getChildControl(self._ui._detail._stc_rightBg, "List2_SkillList")
  self._ui._detail._stc_skillBottomDesc = UI.getChildControl(self._ui._detail._stc_rightBg, "Static_SkillBottomDesc")
  self._ui._detail._stc_learnSkillDesc = UI.getChildControl(self._ui._detail._stc_skillBottomDesc, "StaticText_LearnSkillDesc")
  self._ui._detail._stc_learnSkillAddRate = UI.getChildControl(self._ui._detail._stc_skillBottomDesc, "StaticText_LearnSkillAddRate")
  self._ui._detail._stc_vitalityText:ComputePos()
  self._ui._detail._stc_skillStat:ComputePos()
  local lifeSpanSize = self._ui._detail._stc_vitalityText:GetSpanSize()
  local lifeSize = self._ui._detail._stc_vitalityText:GetTextSizeX() + 10
  self._ui._detail._stc_lifeAbilityHelp:SetSpanSize(lifeSpanSize.x + self._ui._detail._stc_vitalityText:GetSizeX() + lifeSize, self._ui._detail._stc_lifeAbilityHelp:GetSpanSize().y + self._ui._detail._stc_vitalityText:GetSizeY() / 2)
  local textSpanSize = self._ui._detail._stc_skillStat:GetSpanSize()
  local textSize = self._ui._detail._stc_skillStat:GetTextSizeX() + 10
  self._ui._detail._stc_studySkillHelp:SetSpanSize(textSpanSize.x - textSize - self._ui._detail._stc_studySkillHelp:GetSizeX(), self._ui._detail._stc_studySkillHelp:GetSpanSize().y + self._ui._detail._stc_skillStat:GetSizeY() / 2)
  if _ContentsGroup_VehicleLearnSkill_Renewal == false then
    self._ui._detail._stc_skillBottomDesc:SetShow(false)
    self._ui._detail._lst_skillList:SetSize(self._ui._detail._lst_skillList:GetSizeX(), 710)
    local skillScroll = UI.getChildControl(self._ui._detail._lst_skillList, "List2_1_VerticalScroll")
    local skillScrollBtn = UI.getChildControl(skillScroll, "List2_1_VerticalScroll_DownButton")
    skillScroll:SetSize(skillScroll:GetSizeX(), 620)
    skillScrollBtn:SetPosY(620)
  end
  for ii = 1, #Util.VEHICLE_SLOTNO_TO_EQUIPNO[Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] do
    local index = ii
    local slotNo = Util.VEHICLE_SLOTNO_TO_EQUIPNO[Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL][index]
    local slot = {}
    local itemSlot = SlotItem.new(slot, "ServantInfoEquipment_" .. index, slotNo, self._ui._detail._stc_equipSlot, self._EQUIP_SLOT_CONFIG)
    if nil == itemSlot then
      return
    end
    slot:createChild()
    local slotControl = UI.getChildControl(self._ui._detail._stc_equipSlot, "Static_ItemSlot" .. index)
    if nil == slotControl then
      return
    end
    local iconControl = UI.getChildControl(slotControl, "Static_Icon_EuipType")
    if nil == iconControl then
      return
    end
    slot.icon:SetPosX(slotControl:GetPosX())
    slot.icon:SetPosY(slotControl:GetPosY())
    slot.icon:SetShow(false)
    slot.icon:SetAutoDisableTime(1)
    slot.background = slotControl
    if self._isConsole == true then
      slot.icon:setPadSnapType(__ePadSnapType_Target)
      slot.icon:setPadSnapIndex(0)
    end
    self._ui._detail._servantEquipSlotList[slotNo] = {
      _slot = slot,
      _slotControl = slotControl,
      _iconControl = iconControl
    }
  end
  for ii = 1, #Util.VEHICLE_SLOTNO_TO_PEARLEQUIPNO[Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] do
    local index = ii
    local slotNo = Util.VEHICLE_SLOTNO_TO_PEARLEQUIPNO[Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL][index]
    local slot = {}
    local itemSlot = SlotItem.new(slot, "ServantInfoPearlEquipment_" .. index, slotNo, self._ui._detail._stc_equipSlot, self._EQUIP_SLOT_CONFIG)
    if nil == itemSlot then
      return
    end
    slot:createChild()
    local slotControl = UI.getChildControl(self._ui._detail._stc_equipSlot, "Static_PearlItemSlot" .. tostring(index))
    if nil == slotControl then
      return
    end
    local iconControl = UI.getChildControl(slotControl, "Static_Icon_EuipType")
    if nil == iconControl then
      return
    end
    slot.background = slotControl
    slot.icon:SetPosX(slotControl:GetPosX())
    slot.icon:SetPosY(slotControl:GetPosY())
    slot.icon:SetShow(false)
    slot.icon:SetAutoDisableTime(1)
    if self._isConsole == true then
      slot.icon:setPadSnapType(__ePadSnapType_Target)
      slot.icon:setPadSnapIndex(0)
    end
    self._ui._detail._servantPearlEquipSlotList[slotNo] = {
      _slot = slot,
      _slotControl = slotControl,
      _iconControl = iconControl
    }
  end
end
function PaGlobal_ServantSimulator:registEventHandler_Detail()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._detail._stc_selectHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
  self._ui._detail._btn_changeHorse:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantSimulator_ToggleSubView(nil)")
  self._ui._detail._btn_changeHorse:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(0, true)")
  self._ui._detail._btn_changeHorse:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowChangeHorseButtonTooltip(0, false)")
  self._ui._detail._btn_reset:addInputEvent("Mouse_LUp", "HandleEventOn_ServantSimulator_All_ResetDetailSelectInfo()")
  self._ui._detail._lst_vitalityList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._detail._lst_abilityList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._detail._lst_skillList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_ServantSimulator_CreateDetailSkillContents")
  self._ui._detail._lst_skillList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._detail._stc_lifeAbilityHelp:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(true)")
  self._ui._detail._stc_lifeAbilityHelp:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpHPMPStatDescTooltip(false)")
  self._ui._detail._stc_studySkillHelp:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(true)")
  self._ui._detail._stc_studySkillHelp:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowGrowUpSkillStatDescTooltip(false)")
end
function PaGlobal_ServantSimulator:validate_Detail()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._detail._stc_leftBg:isValidate()
  self._ui._detail._stc_horseImageFrame:isValidate()
  self._ui._detail._stc_horseImage:isValidate()
  self._ui._detail._stc_selectHorse:isValidate()
  self._ui._detail._btn_changeHorse:isValidate()
  self._ui._detail._stc_horseName:isValidate()
  self._ui._detail._stc_horseGender:isValidate()
  self._ui._detail._btn_reset:isValidate()
  self._ui._detail._stc_equipSlot:isValidate()
  self._ui._detail._stc_equipTitle:isValidate()
  self._ui._detail._checkbox_imprint:isValidate()
  self._ui._detail._stc_lifeLevel:isValidate()
  self._ui._detail._stc_horseLevel:isValidate()
  self._ui._detail._stc_rightBg:isValidate()
  self._ui._detail._stc_noData:isValidate()
  self._ui._detail._stc_vitalityText:isValidate()
  self._ui._detail._stc_lifeAbilityHelp:isValidate()
  self._ui._detail._lst_vitalityList:isValidate()
  self._ui._detail._stc_abilityText:isValidate()
  self._ui._detail._lst_abilityList:isValidate()
  self._ui._detail._stc_skillStat:isValidate()
  self._ui._detail._stc_studySkillHelp:isValidate()
  self._ui._detail._lst_skillList:isValidate()
  for index, value in pairs(self._ui._detail._servantEquipSlotList) do
    value._slotControl:isValidate()
    value._iconControl:isValidate()
  end
  for index, value in pairs(self._ui._detail._servantPearlEquipSlotList) do
    value._slotControl:isValidate()
    value._iconControl:isValidate()
  end
end
function PaGlobal_ServantSimulator:clearDetailSelectInfo()
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._detail._stc_selectHorse:SetShow(false)
  self._ui._detail._stc_noData:SetShow(false)
  self._ui._detail._btn_reset:SetShow(false)
  self._detailSelectInfo._dataIndex = nil
  self._detailSelectInfo._isMyHorse = nil
  self._detailSelectInfo._servantNo = nil
  self._detailSelectInfo._isAllPearlAvatar = nil
  self._ui._detail._btn_changeHorse:SetShow(true)
  self._ui._detail._checkbox_imprint:SetCheck(false)
  self._ui._detail._stc_horseImage:SetShow(false)
  local horseName = "-"
  self._ui._detail._stc_horseName:SetText(horseName)
  self._ui._detail._stc_horseGender:SetShow(false)
  self._ui._detail._stc_horseLevel:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSELECTLIST_TITLE"))
  self._ui._detail._stc_lifeAbilityHelp:SetShow(false)
  self._ui._detail._stc_vitalityText:SetShow(false)
  self._ui._detail._lst_vitalityList:SetShow(false)
  self._ui._detail._stc_abilityText:SetShow(false)
  self._ui._detail._lst_abilityList:SetShow(false)
  self._ui._detail._lst_skillList:SetShow(false)
  self._ui._detail._stc_skillStat:SetShow(false)
  self._ui._detail._stc_studySkillHelp:SetShow(false)
  self._ui._detail._stc_lifeLevel:SetShow(false)
  self._ui._detail._txt_rightBottomDesc:SetShow(false)
  for index, value in pairs(self._ui._detail._servantEquipSlotList) do
    value._slot:clearItem()
  end
  for index, value in pairs(self._ui._detail._servantPearlEquipSlotList) do
    value._slot:clearItem()
  end
  self._ui._detail._stc_learnSkillAddRate:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SKILL_BOTTOM_TOTAL", "percent", 0))
end
function PaGlobal_ServantSimulator:requestHorseDetailInformation(inputIndex)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self:clearDetailSelectInfo()
  if inputIndex == nil then
    return
  end
  local dataWrapper = ToClient_GetHorseSimulateDetailInformationMyHorseInfoByIndex(inputIndex)
  if dataWrapper == nil then
    return
  end
  local servantNo = dataWrapper:getServantNo()
  local servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
  if servantWrapper == nil then
    servantWrapper = stable_getServantByServantNo(servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
  end
  if servantWrapper == nil then
    return
  end
  self._detailSelectInfo._dataIndex = inputIndex
  self._detailSelectInfo._isMyHorse = true
  ToClient_CheckServantDetailInformation(servantNo, servantWrapper:getLevel())
end
function PaGlobal_ServantSimulator:updateRightBg_DetailSelectInfo(servantNo)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  self._ui._detail._btn_changeHorse:SetShow(true)
  if self._detailSelectInfo._dataIndex == nil then
    self:clearDetailSelectInfo()
    return
  end
  local index = self._detailSelectInfo._dataIndex
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local dataWrapper = ToClient_GetHorseSimulateDetailInformationMyHorseInfoByIndex(index)
  if dataWrapper == nil then
    return
  end
  self._detailSelectInfo._servantNo = dataWrapper:getServantNo()
  local servantWrapper = stable_getServantByServantNo(self._detailSelectInfo._servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
  if servantWrapper == nil then
    servantWrapper = stable_getServantByServantNo(self._detailSelectInfo._servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
  end
  if servantWrapper == nil then
    return
  end
  local currentVehicleType = servantWrapper:getVehicleType()
  if currentVehicleType ~= __eVehicleType_Horse then
    return
  end
  self._ui._detail._stc_selectHorse:SetShow(false)
  self._ui._detail._stc_noData:SetShow(false)
  self._ui._detail._btn_reset:SetShow(false)
  local horseName = "-"
  local level = servantWrapper:getLevel()
  local selfProxy = selfPlayer:get()
  local lifeLevel = 1
  if selfPlayer ~= nil then
    lifeLevel = selfPlayer:get():getLifeExperienceLevel(CppEnums.LifeExperienceType.training)
  end
  local horseLevelStr = "<PAColor0xffffc340>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EXPEDITION_UNIT_LEVEL", "level", level) .. "<PAOldColor> "
  if dataWrapper:isMyHorse() == true then
    horseName = horseLevelStr .. dataWrapper:getMyHorseNameForLua()
  else
    horseName = horseLevelStr .. dataWrapper:getHorseTitleNameForLua()
  end
  if ToClient_IsDevelopment() == true then
    horseName = horseName .. "(" .. tostring(dataWrapper:getCharacterKeyRaw()) .. ")"
  end
  if servantWrapper:isImprint() == true then
    self._ui._detail._checkbox_imprint:SetCheck(true)
  else
    self._ui._detail._checkbox_imprint:SetCheck(false)
  end
  self._ui._detail._stc_horseName:SetText(horseName)
  self._ui._detail._stc_horseName:SetSize(self._ui._detail._stc_horseName:GetTextSizeX() + 10, self._ui._detail._stc_horseName:GetTextSizeY())
  self._ui._detail._stc_horseName:ComputePos()
  local currentServantFormIndexRaw = servantWrapper:getFormIndexRaw()
  local formManager = getServantFormManager()
  if formManager == nil then
    self._ui._detail._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
  elseif currentServantFormIndexRaw == 0 then
    self._ui._detail._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
  else
    local currentDefaultFormIndexRaw = servantWrapper:getDefaultFormIndexRaw()
    if currentServantFormIndexRaw == currentDefaultFormIndexRaw then
      self._ui._detail._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
    else
      local changableFormSSW = formManager:getFormByFormIndexRaw(currentServantFormIndexRaw)
      if changableFormSSW ~= nil then
        self._ui._detail._stc_horseImage:ChangeTextureInfoNameAsync(changableFormSSW:getIcon1())
      else
        self._ui._detail._stc_horseImage:ChangeTextureInfoNameAsync(dataWrapper:getIconPath1())
      end
    end
  end
  self._ui._detail._stc_horseImage:setRenderTexture(self._ui._detail._stc_horseImage:getBaseTexture())
  local genderTextureId
  if servantWrapper:isDisplayGender() == true then
    if dataWrapper:isMale() == true then
      genderTextureId = "Combine_Etc_Stable_Male"
    else
      genderTextureId = "Combine_Etc_Stable_Female"
    end
    self._ui._detail._stc_horseGender:ChangeTextureInfoTextureIDAsync(genderTextureId)
    self._ui._detail._stc_horseGender:setRenderTexture(self._ui._detail._stc_horseGender:getBaseTexture())
    self._ui._detail._stc_horseGender:SetShow(true)
  else
    self._ui._detail._stc_horseGender:SetShow(false)
  end
  self._ui._detail._stc_lifeLevel:SetShow(true)
  self._ui._detail._stc_horseImage:SetShow(true)
  self._ui._detail._stc_lifeLevel:SetText(PaGlobalFunc_Util_CraftLevelColorStrReplace(lifeLevel, PAGetString(Defines.StringSheet_GAME, "LUA_CHARACTERINFO_LIFE6")) .. " " .. PaGlobalFunc_Util_CraftLevelColorReplace(lifeLevel))
  self._ui._detail._stc_horseLevel:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_HORSE_LEVEL", "level", level))
  self._ui._detail._txt_rightBottomDesc:SetShow(true)
  self._ui._detail._stc_lifeAbilityHelp:SetShow(false)
  self._ui._detail._stc_vitalityText:SetShow(true)
  self._ui._detail._lst_vitalityList:SetShow(true)
  self._ui._detail._stc_abilityText:SetShow(true)
  self._ui._detail._lst_abilityList:SetShow(true)
  self._ui._detail._lst_skillList:SetShow(true)
  self._ui._detail._stc_skillStat:SetShow(true)
  self._ui._detail._stc_studySkillHelp:SetShow(true)
  self:updateDetailResult(dataWrapper, servantWrapper, level, lifeLevel)
end
function PaGlobal_ServantSimulator:updateDetailResult(dataWrapper, servantWrapper, level, lifeLevel)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if self._detailSelectInfo._dataIndex == nil or self._detailSelectInfo._isMyHorse == nil then
    return
  end
  self:updateDetailResult_EquipSlot(dataWrapper, servantWrapper, level, lifeLevel)
  self:updateDetailResult_Stat(dataWrapper, servantWrapper, level, lifeLevel)
  self:updateDetailResult_Skill(dataWrapper, servantWrapper, level, lifeLevel)
end
function PaGlobal_ServantSimulator:updateDetailResult_EquipSlot(dataWrapper, servantWrapper, level, lifeLevel)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if servantWrapper == nil then
    return
  end
  for index, value in pairs(self._ui._detail._servantEquipSlotList) do
    local slotNo = index
    local slot = value._slot
    local itemWrapper = servantWrapper:getEquipItem(slotNo)
    local iconControl = slot._iconControl
    if iconControl ~= nil then
      iconControl:SetShow(true)
    end
    if itemWrapper ~= nil then
      slot:setItem(itemWrapper, slotNo, true)
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        local itemKey = itemSSW:get()._key
        if itemKey ~= nil then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOn_ServantSimulator_All_EquipToolTip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_ServantSimulator_All_EquipToolTip(" .. slotNo .. ",false)")
          slot.icon:SetShow(true)
          if iconControl ~= nil then
            iconControl:SetShow(false)
          end
        end
      end
    else
      slot.icon:SetShow(false)
    end
  end
  local currentVehicleType = servantWrapper:getVehicleType()
  local vehicleTypeGroup = PaGlobalFunc_Util_getVehicleTypeGroup(currentVehicleType)
  if nil == vehicleTypeGroup or Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._COUNT == vehicleTypeGroup then
    return
  end
  local pearlEquipCount = 0
  local extendSlotNoList = {}
  for index, value in pairs(self._ui._detail._servantPearlEquipSlotList) do
    local slotNo = index
    local slot = value._slot
    local itemWrapper = servantWrapper:getEquipItem(slotNo)
    local iconControl = slot._iconControl
    if iconControl ~= nil then
      iconControl:SetShow(true)
    end
    if itemWrapper ~= nil then
      slot:setItem(itemWrapper, slotNo, true)
      local itemSSW = itemWrapper:getStaticStatus()
      if itemSSW ~= nil then
        local itemKey = itemSSW:get()._key
        if itemKey ~= nil then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOn_ServantSimulator_All_EquipToolTip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_ServantSimulator_All_EquipToolTip(" .. slotNo .. ",false)")
          slot.icon:SetShow(true)
          if iconControl ~= nil then
            iconControl:SetShow(false)
          end
        end
        pearlEquipCount = pearlEquipCount + 1
      end
      local extendSlotCount = itemSSW:getExtendedSlotCount()
      for ii = 0, extendSlotCount - 1 do
        local extendEquipNo = itemSSW:getExtendedSlotIndex(ii)
        local extendSlotNo = PaGlobalFunc_Util_getVehicleSlotNoToEquipNo(vehicleTypeGroup, extendEquipNo, true)
        if extendSlotNo ~= -1 then
          extendSlotNoList[extendSlotNo] = equipNo
          pearlEquipCount = pearlEquipCount + 1
        end
      end
    else
      slot.icon:SetShow(false)
    end
  end
  if pearlEquipCount >= #Util.VEHICLE_SLOTNO_TO_PEARLEQUIPNO[Util.ENUM_VEHICLE_EQUIP_TYPE_GROUP._NORMAL] then
    self._detailSelectInfo._isAllPearlAvatar = true
  else
    self._detailSelectInfo._isAllPearlAvatar = false
  end
end
function PaGlobal_ServantSimulator:updateDetailResult_Stat(dataWrapper, servantWrapper, level, lifeLevel)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil or servantWrapper == nil then
    return
  end
  local lastGrowthStatInfo = ToClient_GetHorseSimulateDetailInformationGrowthStat(servantWrapper:getServantNo(), level)
  self:updateDetailResultStat_Vitality(dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  self:updateDetailResultStat_GrowthStat(dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
end
function PaGlobal_ServantSimulator:updateDetailResultStat_Vitality(dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local listManager = self._ui._detail._lst_vitalityList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  for ii = 0, self._DETAIL_VITALITYSTAT_ENUM.COUNT - 1 do
    local index = ii
    local key = toInt64(0, index)
    listManager:pushKey(key)
    local content = self._ui._detail._lst_vitalityList:GetContentByKey(key)
    PaGlobal_ServantSimulator:createDetailVitalityContents(content, ii, dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  end
end
function PaGlobal_ServantSimulator:createDetailVitalityContents(content, key, dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local txt_title_big = UI.getChildControl(content, "StaticText_Title_Big")
  local txt_value1 = UI.getChildControl(content, "StaticText_Value1")
  local txt_value2 = UI.getChildControl(content, "StaticText_Value2")
  local txt_value3 = UI.getChildControl(content, "StaticText_Value3")
  local txt_value4_Title = UI.getChildControl(content, "StaticText_Value4_Title")
  local txt_value4_Value = UI.getChildControl(content, "StaticText_Value4_Value")
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  if self._DETAIL_VITALITYSTAT_ENUM.LIST_SUBJECT == key then
    txt_title_big:SetText("")
    txt_value1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_1LEVEL_TITLE"))
    txt_value2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_CURRENTLEVEL_TITLE"))
    txt_value3:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_PREVIOUSGROWTHSTAT"))
    txt_value4_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_MAXSTAT_TITLE"))
    txt_value1:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value1:setRenderTexture(txt_value1:getBaseTexture())
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
    txt_value4_Title:SetShow(true)
    txt_value4_Value:SetShow(false)
    return
  elseif self._DETAIL_VITALITYSTAT_ENUM.HP == key then
    local baseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_HP)
    local currentStat = servantWrapper:getMaxHpExceptEquip()
    local maxStat = dataWrapper:getMaxStatVariedStat(__eHorseSimulateGrowUpStatType_HP, level, true, lifeLevel)
    local currentBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_HP)
    txt_title_big:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_HP"))
    txt_value1:SetText(baseStat)
    txt_value2:SetText(currentStat)
    txt_value4_Value:SetText(currentBaseStat + maxStat)
    if lastGrowthStatInfo ~= nil and level > 1 then
      local prevBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level - 1, __eHorseSimulateGrowUpStatType_HP)
      local lastStat = lastGrowthStatInfo:getHp()
      if lastStat == 0 then
        txt_value3:SetText("0")
      else
        txt_value3:SetText(currentBaseStat - prevBaseStat + lastStat)
      end
    else
      txt_value3:SetText("0")
    end
  elseif self._DETAIL_VITALITYSTAT_ENUM.MP == key then
    local baseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_MP)
    local currentStat = servantWrapper:getMaxMpExceptEquip()
    local growthStat = servantWrapper:getGrowthMp()
    local maxStat = dataWrapper:getMaxStatVariedStat(__eHorseSimulateGrowUpStatType_MP, level, true, lifeLevel)
    local currentBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_MP)
    txt_title_big:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_STAMINA"))
    txt_value1:SetText(baseStat)
    txt_value2:SetText(currentStat)
    txt_value4_Value:SetText(currentBaseStat + maxStat)
    if lastGrowthStatInfo ~= nil and level > 1 then
      local prevBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level - 1, __eHorseSimulateGrowUpStatType_MP)
      local lastStat = lastGrowthStatInfo:getMp()
      if lastStat == 0 then
        txt_value3:SetText("0")
      else
        txt_value3:SetText(currentBaseStat - prevBaseStat + lastStat)
      end
    else
      txt_value3:SetText("0")
    end
  elseif self._DETAIL_VITALITYSTAT_ENUM.WEIGHT == key then
    txt_title_big:SetText(PAGetString(Defines.StringSheet_RESOURCE, "SERVANT_INFO_TEXT_WEIGHT"))
    local baseWeight = ToClient_GetHorseSimulateWeight(horseCharacterKeyRaw, 1)
    local currentStat = servantWrapper:getMaxWeight_s64()
    txt_value1:SetText(makeWeightString(baseWeight, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
    txt_value2:SetText(makeWeightString(currentStat, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
    if lastGrowthStatInfo ~= nil and level > 1 then
      local prevStat = Int64toInt32(currentStat) - Int64toInt32(ToClient_GetHorseSimulateWeight(horseCharacterKeyRaw, level - 1))
      txt_value3:SetText(makeWeightString(prevStat, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
    else
      txt_value3:SetText("0" .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
    end
    txt_value4_Value:SetText(makeWeightString(currentStat, 0) .. PAGetString(Defines.StringSheet_RESOURCE, "TRADEMARKET_STD_TXT_LT"))
  end
  txt_value4_Title:SetShow(false)
  txt_value4_Value:SetShow(true)
  txt_value1:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
  txt_value1:setRenderTexture(txt_value1:getBaseTexture())
  txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
  txt_value2:setRenderTexture(txt_value2:getBaseTexture())
end
function PaGlobal_ServantSimulator:updateDetailResultStat_GrowthStat(dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local listManager = self._ui._detail._lst_abilityList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  self._ui._detailSelectInfo._abilityInfoList = {}
  for ii = 0, self._DETAIL_GROWTHSTAT_ENUM.COUNT - 1 do
    local index = ii
    local key = toInt64(0, index)
    listManager:pushKey(key)
    local content = self._ui._detail._lst_abilityList:GetContentByKey(key)
    PaGlobal_ServantSimulator:createDetailGrowthStatContents(content, ii, dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  end
end
function PaGlobal_ServantSimulator:createDetailGrowthStatContents(content, key, dataWrapper, servantWrapper, level, lifeLevel, lastGrowthStatInfo)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local txt_title_big = UI.getChildControl(content, "StaticText_Title_Big")
  local txt_value1 = UI.getChildControl(content, "StaticText_Value1")
  local txt_value2 = UI.getChildControl(content, "StaticText_Value2")
  local txt_value3 = UI.getChildControl(content, "StaticText_Value3")
  local stc_grade = UI.getChildControl(content, "Static_Grade")
  local txt_value4_Title = UI.getChildControl(content, "StaticText_Value4_Title")
  local txt_value4_Value = UI.getChildControl(content, "StaticText_Value4_Value")
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  if level < 2 then
    stc_grade:SetShow(false)
  else
    stc_grade:SetShow(true)
    level = math.min(30, level)
  end
  local currentStat = 0
  local growthStat = 0
  local averageStat = 0
  local abilityStr = ""
  local maxStatValue
  if self._DETAIL_GROWTHSTAT_ENUM.LIST_SUBJECT == key then
    txt_title_big:SetText("")
    txt_value1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_1LEVEL_TITLE"))
    txt_value2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_CURRENTLEVEL_TITLE"))
    txt_value3:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_PREVIOUSGROWTHSTAT"))
    txt_value4_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_MAXSTAT_TITLE"))
    txt_value1:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value1:setRenderTexture(txt_value1:getBaseTexture())
    txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value2:setRenderTexture(txt_value2:getBaseTexture())
    txt_value3:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Title")
    txt_value3:setRenderTexture(txt_value3:getBaseTexture())
    txt_value4_Title:SetShow(true)
    txt_value4_Value:SetShow(false)
    stc_grade:SetShow(false)
    return
  elseif self._DETAIL_GROWTHSTAT_ENUM.SPEED == key then
    abilityStr = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_MAXSPEED")
    local baseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_Speed)
    currentStat = servantWrapper:getStatExceptEquip(CppEnums.ServantStatType.Type_MaxMoveSpeed)
    growthStat = servantWrapper:getGrowthStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
    averageStat = dataWrapper:getAverageStatVariedStat(__eHorseSimulateGrowUpStatType_Speed, level, true, lifeLevel)
    local maxStat = dataWrapper:getMaxStatVariedStat(__eHorseSimulateGrowUpStatType_Speed, level, true, lifeLevel)
    local currentBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Speed)
    txt_value1:SetText(string.format("%.1f", baseStat / 10000))
    txt_value2:SetText(string.format("%.1f", currentStat / 10000))
    txt_value4_Value:SetText(string.format("%.1f", currentBaseStat / 10000 + maxStat / 10))
    if level > 1 then
      maxStatValue = maxStat / (level - 1)
    else
      maxStatValue = maxStat
    end
    if lastGrowthStatInfo ~= nil then
      local lastStat = lastGrowthStatInfo:getStat(CppEnums.ServantStatType.Type_MaxMoveSpeed)
      txt_value3:SetText(string.format("%.1f", lastStat / 10000))
    else
      txt_value3:SetText("0")
    end
    PaGlobal_ServantSimulator:setGradeTexture(stc_grade, growthStat, maxStat * 1000, key)
  elseif self._DETAIL_GROWTHSTAT_ENUM.ACCELERATION == key then
    abilityStr = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_ACCELERATION")
    txt_title_big:SetText(abilityStr)
    local baseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_Acceleration)
    currentStat = servantWrapper:getStatExceptEquip(CppEnums.ServantStatType.Type_Acceleration)
    growthStat = servantWrapper:getGrowthStat(CppEnums.ServantStatType.Type_Acceleration)
    averageStat = dataWrapper:getAverageStatVariedStat(__eHorseSimulateGrowUpStatType_Acceleration, level, true, lifeLevel)
    local maxStat = dataWrapper:getMaxStatVariedStat(__eHorseSimulateGrowUpStatType_Acceleration, level, true, lifeLevel)
    local currentBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Acceleration)
    txt_value1:SetText(string.format("%.1f", baseStat / 10000))
    txt_value2:SetText(string.format("%.1f", currentStat / 10000))
    txt_value4_Value:SetText(string.format("%.1f", currentBaseStat / 10000 + maxStat / 10))
    if level > 1 then
      maxStatValue = maxStat / (level - 1)
    else
      maxStatValue = maxStat
    end
    if lastGrowthStatInfo ~= nil then
      local lastStat = lastGrowthStatInfo:getStat(CppEnums.ServantStatType.Type_Acceleration)
      txt_value3:SetText(string.format("%.1f", lastStat / 10000))
    else
      txt_value3:SetText("0")
    end
    PaGlobal_ServantSimulator:setGradeTexture(stc_grade, growthStat, maxStat * 1000, key)
  elseif self._DETAIL_GROWTHSTAT_ENUM.CORNERING == key then
    abilityStr = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_CORNERING")
    local baseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_Cornering)
    currentStat = servantWrapper:getStatExceptEquip(CppEnums.ServantStatType.Type_CorneringSpeed)
    growthStat = servantWrapper:getGrowthStat(CppEnums.ServantStatType.Type_CorneringSpeed)
    averageStat = dataWrapper:getAverageStatVariedStat(__eHorseSimulateGrowUpStatType_Cornering, level, true, lifeLevel)
    local maxStat = dataWrapper:getMaxStatVariedStat(__eHorseSimulateGrowUpStatType_Cornering, level, true, lifeLevel)
    local currentBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Cornering)
    txt_value1:SetText(string.format("%.1f", baseStat / 10000))
    txt_value2:SetText(string.format("%.1f", currentStat / 10000))
    txt_value4_Value:SetText(string.format("%.1f", currentBaseStat / 10000 + maxStat / 10))
    if level > 1 then
      maxStatValue = maxStat / (level - 1)
    else
      maxStatValue = maxStat
    end
    if lastGrowthStatInfo ~= nil then
      local lastStat = lastGrowthStatInfo:getStat(CppEnums.ServantStatType.Type_CorneringSpeed)
      txt_value3:SetText(string.format("%.1f", lastStat / 10000))
    else
      txt_value3:SetText("0")
    end
    PaGlobal_ServantSimulator:setGradeTexture(stc_grade, growthStat, maxStat * 1000, key)
  elseif self._DETAIL_GROWTHSTAT_ENUM.BRAKE == key then
    abilityStr = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_BRAKE")
    local baseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, 1, __eHorseSimulateGrowUpStatType_Brake)
    currentStat = servantWrapper:getStatExceptEquip(CppEnums.ServantStatType.Type_BrakeSpeed)
    growthStat = servantWrapper:getGrowthStat(CppEnums.ServantStatType.Type_BrakeSpeed)
    averageStat = dataWrapper:getAverageStatVariedStat(__eHorseSimulateGrowUpStatType_Brake, level, true, lifeLevel)
    local maxStat = dataWrapper:getMaxStatVariedStat(__eHorseSimulateGrowUpStatType_Brake, level, true, lifeLevel)
    local currentBaseStat = ToClient_GetHorseSimulateGrowUpDefaultStat(horseCharacterKeyRaw, level, __eHorseSimulateGrowUpStatType_Brake)
    txt_value1:SetText(string.format("%.1f", baseStat / 10000))
    txt_value2:SetText(string.format("%.1f", currentStat / 10000))
    txt_value4_Value:SetText(string.format("%.1f", currentBaseStat / 10000 + maxStat / 10))
    if level > 1 then
      maxStatValue = maxStat / (level - 1)
    else
      maxStatValue = maxStat
    end
    if lastGrowthStatInfo ~= nil then
      local lastStat = lastGrowthStatInfo:getStat(CppEnums.ServantStatType.Type_BrakeSpeed)
      txt_value3:SetText(string.format("%.1f", lastStat / 10000))
    else
      txt_value3:SetText("0")
    end
    PaGlobal_ServantSimulator:setGradeTexture(stc_grade, growthStat, maxStat * 1000, key)
  end
  if level < 2 then
    self._detailSelectInfo._abilityInfoList[key] = {
      control = stc_grade,
      growthAverage = 0,
      totalAverage = 0,
      ability = abilityStr
    }
  else
    self._detailSelectInfo._abilityInfoList[key] = {
      control = stc_grade,
      growthAverage = growthStat / (level - 1),
      totalAverage = averageStat / (level - 1),
      ability = abilityStr
    }
  end
  txt_title_big:SetText(abilityStr)
  stc_grade:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_ShowDetailAbilityStatToolTip( true, " .. key .. "," .. maxStatValue / 10 .. ")")
  stc_grade:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_ShowDetailAbilityStatToolTip( false )")
  txt_value1:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
  txt_value1:setRenderTexture(txt_value1:getBaseTexture())
  txt_value2:ChangeTextureInfoTextureIDAsync("Combine_Frame_03_TableBG_Sub")
  txt_value2:setRenderTexture(txt_value2:getBaseTexture())
  txt_value4_Title:SetShow(false)
  txt_value4_Value:SetShow(true)
end
function PaGlobal_ServantSimulator:updateDetailResult_Skill(dataWrapper, servantWrapper, level, lifeLevel)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil or servantWrapper == nil then
    return
  end
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if dataWrapper == nil then
    return
  end
  local listManager = self._ui._detail._lst_skillList:getElementManager()
  if listManager == nil then
    return
  end
  local topIndex = self._ui._detail._lst_skillList:getCurrenttoIndex()
  local scroll = self._ui._detail._lst_skillList:GetVScroll()
  local scrollPos = scroll:GetControlPos()
  listManager:clearKey()
  local horseCharacterKeyRaw = dataWrapper:getCharacterKeyRaw()
  local isImprint = servantWrapper:isImprint()
  local isEquipAvatar = self._detailSelectInfo._isAllPearlAvatar
  local servantNo = dataWrapper:getServantNo()
  local isValidResult = ToClient_MakeHorseSimulateDetailSkillInfo(servantNo, lifeLevel, isImprint, isEquipAvatar)
  if isValidResult == false then
    return
  end
  listManager:pushKey(toInt64(0, self._list_subject_skillCantLearn))
  local dataCount = ToClient_GetHorseSimulateDetailSkillInfoCount()
  for dataIndex = 0, dataCount - 1 do
    listManager:pushKey(toInt64(0, dataIndex))
  end
  self._ui._detail._lst_skillList:setCurrenttoIndex(topIndex)
  scroll:SetControlPos(scrollPos)
  self:updateLearnSkillBottomDesc(servantNo, level)
  self._ui._detail._stc_learnSkillAddRate:addInputEvent("Mouse_On", "HandleEventOnOut_ServantSimulator_showLearnSkillPercentTooltipDetailInformation( true )")
  self._ui._detail._stc_learnSkillAddRate:addInputEvent("Mouse_Out", "HandleEventOnOut_ServantSimulator_showLearnSkillPercentTooltipDetailInformation( false )")
end
function PaGlobal_ServantSimulator:createDetailSkillContents(content, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  local dataIndex = Int64toInt32(key)
  local cbx_skill = UI.getChildControl(content, "CheckButton_SkillName")
  local stc_icon = UI.getChildControl(cbx_skill, "Static_SkillIcon")
  local txt_skillName = UI.getChildControl(cbx_skill, "StaticText_SkillName")
  local txt_rate = UI.getChildControl(cbx_skill, "StaticText_SkillPercent")
  local txt_learnedSkill = UI.getChildControl(cbx_skill, "StaticText_LearnedSkill")
  if dataIndex == self._list_subject_skillCantLearn then
    cbx_skill:SetIgnore(true)
    cbx_skill:SetCheck(false)
    stc_icon:SetShow(false)
    txt_skillName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_NO_SKILL_RATE"))
    txt_rate:SetText(PaGlobalFunc_Util_MakeRateDotString(ToClient_GetHorseSimulateDetailInformationCantLearnableRate(), 4, true))
    txt_learnedSkill:SetShow(false)
  else
    local dataWrapper = ToClient_GetHorseSimulateDetailSkillInfoByIndex(dataIndex)
    if dataWrapper == nil then
      return
    end
    local skillWrapper = dataWrapper:getSkillWrapper()
    if skillWrapper == nil then
      return
    end
    local isDefaultSkill = dataWrapper:isDefaultSkill()
    local isSelect = dataWrapper:isSelected()
    cbx_skill:SetCheck(isSelect)
    stc_icon:SetShow(true)
    stc_icon:ChangeTextureInfoNameAsync("Icon/" .. skillWrapper:getIconPath())
    txt_skillName:SetText(skillWrapper:getName())
    txt_rate:SetShow(true)
    if isSelect == true then
      if isDefaultSkill == true then
        txt_rate:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_DEFAULT_SKILL"))
        txt_learnedSkill:SetShow(false)
      else
        txt_rate:SetText("")
        txt_learnedSkill:SetShow(true)
      end
    else
      txt_rate:SetText(PaGlobalFunc_Util_MakeRateDotString(dataWrapper:getRate(), 4, true))
      txt_learnedSkill:SetShow(false)
    end
  end
end
function PaGlobal_ServantSimulator:setGradeTexture(control, myHorseValue, maxValue, key)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if myHorseValue >= maxValue * self._gradePercentage.S then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_HorseInfo_Grade_S")
    control:setRenderTexture(control:getBaseTexture())
    local grade = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_EVALUATION_5")
    control:SetText("  <PAColor0xffe0e0e0>" .. grade .. "<PAOldColor>")
    self._grade[key] = 5
  elseif myHorseValue >= maxValue * self._gradePercentage.AA then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_HorseInfo_Grade_Aplus")
    control:setRenderTexture(control:getBaseTexture())
    local grade = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_EVALUATION_4")
    control:SetText("  <PAColor0xffe0e0e0>" .. grade .. "<PAOldColor>")
    self._grade[key] = 4
  elseif myHorseValue >= maxValue * self._gradePercentage.A then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_HorseInfo_Grade_A")
    control:setRenderTexture(control:getBaseTexture())
    local grade = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_EVALUATION_3")
    control:SetText("  <PAColor0xffe0e0e0>" .. grade .. "<PAOldColor>")
    self._grade[key] = 3
  elseif myHorseValue >= maxValue * self._gradePercentage.C then
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_HorseInfo_Grade_B")
    control:setRenderTexture(control:getBaseTexture())
    local grade = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_EVALUATION_2")
    control:SetText("  <PAColor0xffe0e0e0>" .. grade .. "<PAOldColor>")
    self._grade[key] = 2
  else
    control:ChangeTextureInfoTextureIDAsync("Combine_Etc_HorseInfo_Grade_C")
    control:setRenderTexture(control:getBaseTexture())
    local grade = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RATE_EVALUATION_1")
    control:SetText("  <PAColor0xff000000>" .. grade .. "<PAOldColor>")
    self._grade[key] = 1
  end
end
function PaGlobal_ServantSimulator:updateLearnSkillBottomDesc(servantNo, level)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if _ContentsGroup_VehicleLearnSkill_Renewal == false then
    return
  end
  local skillRate = string.format("%.1f", ToClient_GetVehicleLearnSkillAddRateTotal(servantNo) / 10000)
  self._ui._detail._stc_learnSkillAddRate:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SERVANTSIMULATOR_SKILL_BOTTOM_TOTAL", "percent", skillRate))
end
function PaGlobal_ServantSimulator:showLearnSkillPercentTooltip(isShow)
  if Panel_Dialog_ServantSimulator == nil then
    return
  end
  if _ContentsGroup_VehicleLearnSkill_Renewal == false then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  if self._detailSelectInfo._servantNo == nil then
    return
  end
  local servantWrapper = stable_getServantByServantNo(self._detailSelectInfo._servantNo, CppEnums.ServantWhereType.ServantWhereTypeUser)
  if servantWrapper == nil then
    servantWrapper = stable_getServantByServantNo(self._detailSelectInfo._servantNo, CppEnums.ServantWhereType.ServantWhereTypeCrogdaloStable)
  end
  if servantWrapper == nil then
    return
  end
  local control = self._ui._detail._stc_learnSkillAddRate
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_STUDYSKILL_TOOLTIP_NAME")
  local desc = ""
  local trainingSKillStatStaticStatus = ToClient_getTrainingLevelSkillStatStaticStatus()
  local skillRate = 0
  if trainingSKillStatStaticStatus ~= nil then
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_LEARNSKILLRATEFROMTRAININGLEVEL", "percent", string.format("%.1f", trainingSKillStatStaticStatus._addVehicleSkillOwnerRate / 10000))
  end
  if servantWrapper:isImprint() == true then
    desc = desc .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_LEARNSKILLRATEFROMIMPRINT", "percent", string.format("%.1f", ToClient_GetVehicleLearnSkillAddRateFromImprint() / 10000))
  end
  local equipRate = servantWrapper:getVehicleLearnSkillAddRateFromEquip()
  if equipRate > 0 then
    desc = desc .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_LEARNSKILLRATEFROMPEARLEQUIP", "percent", string.format("%.1f", equipRate / 10000))
  end
  local playerPercent = ToClient_GetVehicleLearnSkillAddRateFromSelfPlayer()
  if playerPercent > 0 then
    desc = desc .. "\n" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANTSIMULATOR_LEARNSKILLRATEFROMPEARLEQUIP", "percent", string.format("%.1f", playerPercent / 10000))
  end
  TooltipSimple_Show(control, name, desc)
end
