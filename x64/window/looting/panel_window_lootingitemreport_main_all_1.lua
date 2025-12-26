function PaGlobal_Window_LootingItemReport_Main_All:initialize()
  if PaGlobal_Window_LootingItemReport_Main_All._initialize == true then
    return
  end
  self._ui._stc_titleBG = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_TitleBG")
  self._ui._stc_titleBG_TitleIcon = UI.getChildControl(self._ui._stc_titleBG, "StaticText_TItleIcon")
  self._ui._stc_titleBG_TitleDeco = UI.getChildControl(self._ui._stc_titleBG, "Static_TItleDeco")
  self._ui._stc_titleBG_Close = UI.getChildControl(self._ui._stc_titleBG, "Button_Close")
  self._ui._stc_topGroup = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_TopGroup")
  self._ui._txt_topGroup_levelName = UI.getChildControl(self._ui._stc_topGroup, "StaticText_LevelName")
  self._ui._txt_topGroup_class = UI.getChildControl(self._ui._stc_topGroup, "StaticText_Class")
  self._ui._stc_topGroup_skillTypeIcon = UI.getChildControl(self._ui._stc_topGroup, "Static_SkillTypeIcon")
  self._ui._stc_topGroup_awaken = UI.getChildControl(self._ui._stc_topGroup_skillTypeIcon, "Static_Type_Awaken")
  self._ui._stc_topGroup_succession = UI.getChildControl(self._ui._stc_topGroup_skillTypeIcon, "Static_Type_Succession")
  self._ui._stc_topGroup_valueBG = UI.getChildControl(self._ui._stc_topGroup, "Static_ValueBG")
  self._ui._stc_topGroup_faceIcon = UI.getChildControl(self._ui._stc_topGroup, "Static_Profile_Icon_1")
  self._ui._stc_topGroup_faceIconBg = UI.getChildControl(self._ui._stc_topGroup, "Static_Profile_BG_1")
  self._ui._txt_topGroup_mainWeaponValue = UI.getChildControl(self._ui._stc_topGroup_valueBG, "StaticText_MainWeaponValue")
  self._ui._txt_topGroup_arousalWeaponValue = UI.getChildControl(self._ui._stc_topGroup_valueBG, "StaticText_ArousalWeaponValue")
  self._ui._txt_topGroup_defenseValue = UI.getChildControl(self._ui._stc_topGroup_valueBG, "StaticText_DefenseValue")
  self._ui._chk_topGroup_statType = UI.getChildControl(self._ui._stc_topGroup_valueBG, "CheckButton_StatType")
  self._ui._stc_middleGroup = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_MiddleGroup")
  self._ui._txt_middleGroup_fieldInfo = UI.getChildControl(self._ui._stc_middleGroup, "StaticText_FieldInfo")
  self._ui._txt_middleGroup_time = UI.getChildControl(self._ui._stc_middleGroup, "StaticText_Time")
  self._ui._txt_middleGroup_date = UI.getChildControl(self._ui._stc_middleGroup, "StaticText_Date")
  self._ui._txt_middleGroup_killCount = UI.getChildControl(self._ui._stc_middleGroup, "StaticText_KillCount")
  self._ui._chk_middleGroup_pin = UI.getChildControl(self._ui._stc_middleGroup, "CheckButton_Pin")
  self._ui._stc_bottomGroup = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_BottomGroup")
  self._ui._stc_bottomGroup_lootItemBG = UI.getChildControl(self._ui._stc_bottomGroup, "Static_LootItemBG")
  self._ui._txt_bottomGroup_lootItemTitle = UI.getChildControl(self._ui._stc_bottomGroup_lootItemBG, "StaticText_LootItemTitle")
  self._ui._stc_bottomGroup_itemListBg = UI.getChildControl(self._ui._stc_bottomGroup_lootItemBG, "Static_ItemListBg")
  self._ui._frm_bottomGroup_itemListFrame = UI.getChildControl(self._ui._stc_bottomGroup_itemListBg, "Frame_ItemSlot")
  self._ui._stc_bottomGroup_itemListFrameContent = UI.getChildControl(self._ui._frm_bottomGroup_itemListFrame, "Frame_1_Content")
  self._ui._stc_bottomGroup_itemSlotArea = UI.getChildControl(self._ui._stc_bottomGroup_itemListFrameContent, "Static_ItemSlotArea")
  self._ui._stc_bottomGroup_itemSlot = UI.getChildControl(self._ui._stc_bottomGroup_itemSlotArea, "Static_Reward_Slot_Template")
  self._ui._chk_bottomGroup_arrow = UI.getChildControl(self._ui._stc_bottomGroup, "CheckButton_Arrow")
  self._ui._stc_bottomGroup_lootingRecordGroup = UI.getChildControl(self._ui._stc_bottomGroup, "Static_LootingRecordGroup")
  self._ui._stc_bottomGroup_columnNameGroup = UI.getChildControl(self._ui._stc_bottomGroup_lootingRecordGroup, "Static_ColumnNameGroup")
  self._ui._list2_bottomGroup_recordList = UI.getChildControl(self._ui._stc_bottomGroup_lootingRecordGroup, "List2_LootingRecordList")
  self._ui._stc_bottomGroup_guideDescBG = UI.getChildControl(self._ui._stc_bottomGroup, "Static_GuideDescBG")
  self._ui._txt_bottomGroup_guideDesc = UI.getChildControl(self._ui._stc_bottomGroup_guideDescBG, "StaticText_GuideDesc")
  self._ui._stc_bottomBg_consoleUI = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_BottomBg_1_ConsoleUI")
  self._ui._txt_bottomBg_keyGuide_a_confirn = UI.getChildControl(self._ui._stc_bottomBg_consoleUI, "StaticText_KeyGuide_A_Confirn")
  self._ui._txt_bottomBg_keyGuide_b_close = UI.getChildControl(self._ui._stc_bottomBg_consoleUI, "StaticText_KeyGuide_B_Close")
  self._ui._txt_bottomBg_keyGuide_y_daily = UI.getChildControl(self._ui._stc_bottomBg_consoleUI, "StaticText_KeyGuide_Y_Daily")
  self._ui._txt_bottomBg_keyGuide_x_detail = UI.getChildControl(self._ui._stc_bottomBg_consoleUI, "StaticText_KeyGuide_X_Detail")
  self._ui._stc_loadingBg = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_Loading_BG")
  self._ui._stc_loadingAni = UI.getChildControl(self._ui._stc_loadingBg, "Static_Loading")
  self._ui._stc_emptyMessageBg = UI.getChildControl(Panel_Window_LootingItemReport_Main_All, "Static_Message_BG")
  self._panelSizeY = Panel_Window_LootingItemReport_Main_All:GetSizeY()
  self._bottomBgSizeY = self._ui._stc_bottomGroup:GetSizeY()
  self._bottomRecordListSizeY = self._ui._stc_bottomGroup_lootingRecordGroup:GetSizeY()
  PaGlobal_Window_LootingItemReport_Main_All:registEventHandler()
  PaGlobal_Window_LootingItemReport_Main_All:validate()
  PaGlobal_Window_LootingItemReport_Main_All._initialize = true
end
function PaGlobal_Window_LootingItemReport_Main_All:registEventHandler()
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  self._ui._list2_bottomGroup_recordList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGloabl_Window_LootingItemReport_Main_All_CreateReportList")
  self._ui._list2_bottomGroup_recordList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._stc_titleBG_Close:addInputEvent("Mouse_LUp", "PaGloabl_Window_LootingItemReport_Main_All_Close()")
  self._ui._chk_topGroup_statType:addInputEvent("Mouse_LUp", "HandleEventLDown_LootingItemReport_ToggleStatButton()")
  self._ui._chk_middleGroup_pin:addInputEvent("Mouse_LUp", "HandleEventLDown_LootingItemReport_RequestSaveRecord()")
  self._ui._chk_bottomGroup_arrow:addInputEvent("Mouse_LUp", "HandleEventLDown_LootingItemReport_ToggleRecordList()")
end
function PaGlobal_Window_LootingItemReport_Main_All:prepareOpen(fieldIndex)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  if Panel_Window_PersonalField_Main ~= nil and Panel_Window_PersonalField_Main:GetShow() == true and Panel_Window_LootingItemReport_Main_All:GetShow() == false then
    Panel_Window_LootingItemReport_Main_All:SetPosX(Panel_Window_PersonalField_Main:GetPosX() + Panel_Window_PersonalField_Main:GetSizeX())
    Panel_Window_LootingItemReport_Main_All:SetPosY(Panel_Window_PersonalField_Main:GetPosY())
  end
  self._ui._stc_loadingBg:SetShow(false)
  self._fieldIndex = nil
  self._recordIndex = nil
  self._recordCount = 0
  PaGlobal_Window_LootingItemReport_Main_All:setShowUI(false)
  self:updateRecordList(fieldIndex)
  PaGlobal_Window_LootingItemReport_Main_All:open()
end
function PaGlobal_Window_LootingItemReport_Main_All:open(fieldIndex)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  Panel_Window_LootingItemReport_Main_All:SetShow(true)
end
function PaGlobal_Window_LootingItemReport_Main_All:prepareClose()
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  PaGlobal_Window_LootingItemReport_Main_All:close()
end
function PaGlobal_Window_LootingItemReport_Main_All:close()
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  Panel_Window_LootingItemReport_Main_All:SetShow(false)
end
function PaGlobal_Window_LootingItemReport_Main_All:updateRecordList(fieldIndex)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  ToClient_RefreshLootingItemRecord(fieldIndex)
  self._ui._list2_bottomGroup_recordList:getElementManager():clearKey()
  self._recordCount = ToClient_GetLootingItemRecordCount(fieldIndex)
  if self._recordCount == 0 then
    self._ui._stc_emptyMessageBg:SetShow(true)
    self:toggleRecordList(false)
    return
  else
    self._ui._stc_emptyMessageBg:SetShow(false)
  end
  self:toggleRecordList(self._ui._chk_bottomGroup_arrow:IsCheck())
  self._fieldIndex = fieldIndex
  self._recordIndex = nil
  for i = 0, self._recordCount - 1 do
    self._ui._list2_bottomGroup_recordList:getElementManager():pushKey(toInt64(fieldIndex, i))
  end
  self:updateRecordInfo(fieldIndex, 0)
end
function PaGlobal_Window_LootingItemReport_Main_All:updateRecordInfo(fieldIndex, recordIndex)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  local recordInfo = ToClient_GetLootingItemRecord(fieldIndex, recordIndex)
  if recordInfo == nil then
    return
  end
  local instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByIndex(fieldIndex)
  if instanceSpawnWrapper == nil then
    return
  end
  PaGlobal_Window_LootingItemReport_Main_All:setShowUI(true)
  self._fieldIndex = fieldIndex
  self._recordIndex = recordIndex
  self._ui._txt_topGroup_levelName:SetText("Lv." .. recordInfo:getLevel() .. " " .. recordInfo:getCharacterName())
  local playerClass = recordInfo:getClassType()
  self._ui._txt_topGroup_class:SetText(NewClassData.newClass_String[playerClass]._classType2String)
  PaGlobalFunc_Util_SetSolrareMiniClassIcon(self._ui._stc_topGroup_faceIcon, playerClass)
  if recordInfo:getSkillTypeParam() == __eSkillTypeParam_Awaken then
    self._ui._stc_topGroup_awaken:SetShow(true)
    self._ui._stc_topGroup_succession:SetShow(false)
  else
    self._ui._stc_topGroup_awaken:SetShow(false)
    self._ui._stc_topGroup_succession:SetShow(true)
  end
  self._ui._txt_topGroup_mainWeaponValue:SetText(recordInfo:getOffence())
  self._ui._txt_topGroup_arousalWeaponValue:SetText(recordInfo:getAwakenOffence())
  self._ui._txt_topGroup_defenseValue:SetText(recordInfo:getDefence())
  self._ui._txt_middleGroup_fieldInfo:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FARMINGTIMER_NAME", "area", instanceSpawnWrapper:getAreaName()))
  local playTime = Int64toInt32(recordInfo:getExitTime() - recordInfo:getEnterTime())
  local clockHours = math.floor(playTime / 3600)
  local clockMinutes = math.floor(playTime % 3600 / 60)
  local clockSeconds = playTime % 60
  local str = ""
  if clockHours > 0 then
    str = tostring(clockHours) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_HOUR") .. " "
  end
  if clockMinutes > 0 then
    str = str .. tostring(clockMinutes) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_MINUTE") .. " "
  end
  str = str .. tostring(clockSeconds) .. PAGetString(Defines.StringSheet_GAME, "LUA_GLOBAL_TIME_SECOND")
  self._ui._txt_middleGroup_time:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FARMINGTIMER_TIME", "time", str))
  local dateTime = PATime(recordInfo:getExitTime())
  local timeStr = tostring(dateTime:GetYear()) .. "-" .. tostring(dateTime:GetMonth()) .. "-" .. tostring(dateTime:GetDay()) .. " " .. tostring(dateTime:GetHour()) .. ":" .. tostring(dateTime:GetMinute())
  self._ui._txt_middleGroup_date:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FARMINGTIMER_DATE", "date", timeStr))
  self._ui._txt_middleGroup_killCount:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_FARMINGTIMER_MONSTERKILL", "kill", recordInfo:getKillCount()))
  self:updateStat(recordInfo, self._ui._chk_topGroup_statType:IsCheck())
  local count = (self._ui._stc_bottomGroup_itemSlotArea:GetSizeX() - 20) / (self._ui._stc_bottomGroup_itemSlot:GetSizeX() + 10)
  local slotCountPerRow = math.floor(count)
  local slotCount = self._ui._itemSlotList:length()
  local itemCount = recordInfo:getItemListCount()
  if slotCount < itemCount then
    local needSlotCount = itemCount - slotCount
    local currentCount = 0
    for idx = slotCount, itemCount - 1 do
      local slot = {}
      slot.control = UI.cloneControl(self._ui._stc_bottomGroup_itemSlot, self._ui._stc_bottomGroup_itemSlotArea, "Static_ItemSlot_" .. idx)
      SlotItem.new(slot, "ItemIcon_" .. idx, idx, slot.control, self._itemSlotConfig)
      slot:createChild()
      slot.control:SetShow(true)
      self._ui._itemSlotList:push_back(slot)
    end
  end
  local startPanX = 10
  local startPanY = 10
  local panGap = 10
  local iconSizeX = self._ui._stc_bottomGroup_itemSlot:GetSizeX()
  local iconSizeY = self._ui._stc_bottomGroup_itemSlot:GetSizeY()
  for slotIndex = 1, self._ui._itemSlotList:length() do
    local positionIndex = slotIndex - 1
    local xPos = positionIndex % slotCountPerRow
    local yPos = math.floor(positionIndex / slotCountPerRow)
    self._ui._itemSlotList[slotIndex].control:SetSpanSize(startPanX + (iconSizeX + panGap) * xPos, startPanY + (iconSizeY + panGap) * yPos)
    if itemCount > positionIndex then
      self._ui._itemSlotList[slotIndex].control:SetShow(true)
      local itemKey = recordInfo:getItemKey(positionIndex)
      local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
      self._ui._itemSlotList[slotIndex].icon:addInputEvent("Mouse_On", "HandleEventOnOut_LootingItemReport_ShowItemToolTip( true," .. itemKey .. "," .. slotIndex .. ")")
      self._ui._itemSlotList[slotIndex].icon:addInputEvent("Mouse_Out", "HandleEventOnOut_LootingItemReport_ShowItemToolTip( false )")
      if itemStatic ~= nil then
        self._ui._itemSlotList[slotIndex]:setItemByStaticStatus(itemStatic, recordInfo:getItemCount(positionIndex))
      end
    else
      self._ui._itemSlotList[slotIndex].icon:removeInputEvent("Mouse_On")
      self._ui._itemSlotList[slotIndex].icon:removeInputEvent("Mouse_Out")
      self._ui._itemSlotList[slotIndex].control:SetShow(false)
    end
  end
  local isSaveRecord = ToClient_IsLootingItemSavedRecord(recordInfo:getRecordNo())
  self._ui._chk_middleGroup_pin:SetShow(isSaveRecord == false)
  self._ui._chk_middleGroup_pin:SetCheck(isSaveRecord)
end
function PaGlobal_Window_LootingItemReport_Main_All:updateStat(recordInfo, isTotalStatus)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  if recordInfo == nil then
    return
  end
  if isTotalStatus == true then
    self._ui._txt_topGroup_mainWeaponValue:SetText(recordInfo:getTotalOffence())
    self._ui._txt_topGroup_arousalWeaponValue:SetText(recordInfo:getTotalAwakenOffence())
    self._ui._txt_topGroup_defenseValue:SetText(recordInfo:getTotalDefence())
  else
    self._ui._txt_topGroup_mainWeaponValue:SetText(recordInfo:getOffence())
    self._ui._txt_topGroup_arousalWeaponValue:SetText(recordInfo:getAwakenOffence())
    self._ui._txt_topGroup_defenseValue:SetText(recordInfo:getDefence())
  end
end
function PaGlobal_Window_LootingItemReport_Main_All:setShowUI(isShow)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  self._ui._txt_topGroup_mainWeaponValue:SetText(0)
  self._ui._txt_topGroup_arousalWeaponValue:SetText(0)
  self._ui._txt_topGroup_defenseValue:SetText(0)
  self._ui._txt_topGroup_levelName:SetShow(isShow)
  self._ui._txt_topGroup_class:SetShow(isShow)
  self._ui._stc_topGroup_skillTypeIcon:SetShow(isShow)
  self._ui._stc_topGroup_faceIcon:SetShow(isShow)
  self._ui._stc_topGroup_faceIconBg:SetShow(isShow)
  self._ui._txt_middleGroup_fieldInfo:SetShow(isShow)
  self._ui._txt_middleGroup_time:SetShow(isShow)
  self._ui._txt_middleGroup_date:SetShow(isShow)
  self._ui._txt_middleGroup_killCount:SetShow(isShow)
  self._ui._chk_middleGroup_pin:SetShow(isShow)
  for slotIndex = 1, self._ui._itemSlotList:length() do
    self._ui._itemSlotList[slotIndex]:clearItem()
    self._ui._itemSlotList[slotIndex].icon:removeInputEvent("Mouse_On")
    self._ui._itemSlotList[slotIndex].icon:removeInputEvent("Mouse_Out")
    self._ui._itemSlotList[slotIndex].control:SetShow(isShow)
  end
end
function PaGlobal_Window_LootingItemReport_Main_All:toggleRecordList(isShow)
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  if isShow == true and 0 < self._recordCount then
    self._ui._stc_bottomGroup_lootingRecordGroup:SetShow(true)
    Panel_Window_LootingItemReport_Main_All:SetSize(Panel_Window_LootingItemReport_Main_All:GetSizeX(), self._panelSizeY)
    self._ui._stc_bottomGroup:SetSize(self._ui._stc_bottomGroup:GetSizeX(), self._bottomBgSizeY)
    self._ui._stc_bottomGroup_guideDescBG:ComputePos()
  else
    self._ui._stc_bottomGroup_lootingRecordGroup:SetShow(false)
    Panel_Window_LootingItemReport_Main_All:SetSize(Panel_Window_LootingItemReport_Main_All:GetSizeX(), self._panelSizeY - self._bottomRecordListSizeY)
    self._ui._stc_bottomGroup:SetSize(self._ui._stc_bottomGroup:GetSizeX(), self._bottomBgSizeY - self._bottomRecordListSizeY)
    self._ui._stc_bottomGroup_guideDescBG:ComputePos()
  end
end
function PaGlobal_Window_LootingItemReport_Main_All:validate()
  if Panel_Window_LootingItemReport_Main_All == nil then
    return
  end
  self._ui._stc_titleBG:isValidate()
  self._ui._stc_titleBG_TitleIcon:isValidate()
  self._ui._stc_titleBG_TitleDeco:isValidate()
  self._ui._stc_titleBG_Close:isValidate()
  self._ui._stc_topGroup:isValidate()
  self._ui._txt_topGroup_levelName:isValidate()
  self._ui._txt_topGroup_class:isValidate()
  self._ui._stc_topGroup_skillTypeIcon:isValidate()
  self._ui._stc_topGroup_valueBG:isValidate()
  self._ui._stc_topGroup_faceIcon:isValidate()
  self._ui._stc_topGroup_faceIconBg:isValidate()
  self._ui._txt_topGroup_mainWeaponValue:isValidate()
  self._ui._txt_topGroup_arousalWeaponValue:isValidate()
  self._ui._txt_topGroup_defenseValue:isValidate()
  self._ui._chk_topGroup_statType:isValidate()
  self._ui._stc_middleGroup:isValidate()
  self._ui._txt_middleGroup_fieldInfo:isValidate()
  self._ui._txt_middleGroup_time:isValidate()
  self._ui._txt_middleGroup_date:isValidate()
  self._ui._txt_middleGroup_killCount:isValidate()
  self._ui._chk_middleGroup_pin:isValidate()
  self._ui._stc_bottomGroup:isValidate()
  self._ui._stc_bottomGroup_lootItemBG:isValidate()
  self._ui._txt_bottomGroup_lootItemTitle:isValidate()
  self._ui._stc_bottomGroup_itemListBg:isValidate()
  self._ui._frm_bottomGroup_itemListFrame:isValidate()
  self._ui._stc_bottomGroup_itemListFrameContent:isValidate()
  self._ui._stc_bottomGroup_itemSlotArea:isValidate()
  self._ui._stc_bottomGroup_itemSlot:isValidate()
  self._ui._chk_bottomGroup_arrow:isValidate()
  self._ui._stc_bottomGroup_lootingRecordGroup:isValidate()
  self._ui._stc_bottomGroup_guideDescBG:isValidate()
  self._ui._txt_bottomGroup_guideDesc:isValidate()
  self._ui._stc_bottomBg_consoleUI:isValidate()
  self._ui._txt_bottomBg_keyGuide_a_confirn:isValidate()
  self._ui._txt_bottomBg_keyGuide_b_close:isValidate()
  self._ui._txt_bottomBg_keyGuide_y_daily:isValidate()
  self._ui._txt_bottomBg_keyGuide_x_detail:isValidate()
end
