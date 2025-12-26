function HandleEventLDown_LootingItemReport_ToggleStatButton()
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  if self._fieldIndex == nil or self._recordIndex == nil then
    return
  end
  local recordInfo = ToClient_GetLootingItemRecord(self._fieldIndex, self._recordIndex)
  if recordInfo == nil then
    return
  end
  self:updateStat(recordInfo, self._ui._chk_topGroup_statType:IsCheck())
end
function HandleEventLDown_LootingItemReport_RequestSaveRecord()
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  if self._fieldIndex == nil or self._recordIndex == nil then
    return
  end
  local recordInfo = ToClient_GetLootingItemRecord(self._fieldIndex, self._recordIndex)
  if recordInfo == nil then
    return
  end
  local isExistRecord = ToClient_IsExistLootingItemSavedRecord(self._fieldIndex, recordInfo:getClassType())
  if isExistRecord == true then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FARMINGTIMER_TITLE_NAME"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_FARMINGTIMER_SAVEMESSAGEBOX"),
      functionYes = HandleEventLDown_LootingItemReport_SaveRecord,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  else
    HandleEventLDown_LootingItemReport_SaveRecord()
  end
end
function HandleEventLDown_LootingItemReport_SaveRecord()
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  if self._fieldIndex == nil or self._recordIndex == nil then
    return
  end
  local recordInfo = ToClient_GetLootingItemRecord(self._fieldIndex, self._recordIndex)
  if recordInfo == nil then
    return
  end
  ToClient_RequestUpdateLootingItemSavedRecord(recordInfo:getRecordNo())
end
function HandleEventOnOut_LootingItemReport_ShowItemToolTip(isIn, itemKey, index)
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  if isIn == false then
    Panel_Tooltip_Item_hideTooltip()
  end
  local slot = self._ui._itemSlotList[index]
  if slot == nil then
    return
  end
  local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if itemStatic == nil then
    return
  end
  Panel_Tooltip_Item_Show(itemStatic, slot.control, true, false)
end
function HandleEventLDown_LootingItemReport_ToggleRecordList()
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  self:toggleRecordList(self._ui._chk_bottomGroup_arrow:IsCheck())
end
function HandleEventOnOut_LootingItemReport_showRecordInfoTooltip(isIn, fieldIndex, recordIndex)
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  if isIn == false then
    TooltipSimple_Hide()
    return
  end
  if fieldIndex == nil or recordIndex == nil then
    return
  end
  local recordInfo = ToClient_GetLootingItemRecord(fieldIndex, recordIndex)
  if recordInfo == nil then
    return
  end
  local contents = self._ui._list2_bottomGroup_recordList:GetContentByKey(toInt64(fieldIndex, recordIndex))
  if contents == nil then
    return
  end
  local btnContent = UI.getChildControl(contents, "Button_CharInfo")
  if btnContent == nil then
    return
  end
  TooltipSimple_Show(btnContent, recordInfo:getCharacterName())
end
function HandleEventLDown_LootingItemReport_loadRecordInfo(fieldIndex, recordIndex)
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  if self._fieldIndex == fieldIndex and self._recordIndex == recordIndex then
    return
  end
  self._ui._stc_loadingBg:SetShow(true)
  luaTimer_AddEvent(HandleEventLDown_LootingItemReport_openRecord, 500, false, 0, fieldIndex, recordIndex)
end
function HandleEventLDown_LootingItemReport_openRecord(fieldIndex, recordIndex)
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  self._ui._stc_loadingBg:SetShow(false)
  self:updateRecordInfo(fieldIndex, recordIndex)
end
function PaGloabl_Window_LootingItemReport_Main_All_ShowAni()
  if PaGlobal_Window_LootingItemReport_Main_All == nil then
    return
  end
end
function PaGloabl_Window_LootingItemReport_Main_All_HideAni()
  if PaGlobal_Window_LootingItemReport_Main_All == nil then
    return
  end
end
function PaGloabl_Window_LootingItemReport_Main_All_CreateReportList(contents, key)
  if PaGlobal_Window_LootingItemReport_Main_All == nil then
    return
  end
  local fieldIndex = highFromUint64(key)
  local recordIndex = lowFromUint64(key)
  local recordInfo = ToClient_GetLootingItemRecord(fieldIndex, recordIndex)
  if recordInfo == nil then
    return
  end
  local btnContent = UI.getChildControl(contents, "Button_CharInfo")
  if btnContent == nil then
    return
  end
  local dateInfo = UI.getChildControl(btnContent, "StaticText_CharInfo_Date")
  local skillTypeIcon = UI.getChildControl(btnContent, "Static_SkillTypeIcon")
  local level = UI.getChildControl(btnContent, "StaticText_CharInfo_Level")
  local time = UI.getChildControl(btnContent, "StaticText_CharInfo_Time")
  local btnView = UI.getChildControl(btnContent, "Button_View")
  local pinIcon = UI.getChildControl(btnContent, "Static_PinIcon")
  if dateInfo == nil or skillTypeIcon == nil or level == nil or time == nil or btnView == nil or pinIcon == nil then
    return
  end
  level:SetText(recordInfo:getLevel())
  PaGlobalFunc_Util_ChangeTextureClass(skillTypeIcon, recordInfo:getClassType())
  local timeValue = PATime(recordInfo:getExitTime())
  local timeStr = tostring(timeValue:GetYear()) .. "-" .. tostring(timeValue:GetMonth()) .. "-" .. tostring(timeValue:GetDay())
  dateInfo:SetText(timeStr)
  local playTime = Int64toInt32(recordInfo:getExitTime() - recordInfo:getEnterTime())
  time:SetText(convertSecondsToClockTime(playTime))
  btnView:addInputEvent("Mouse_LUp", "HandleEventLDown_LootingItemReport_loadRecordInfo(" .. fieldIndex .. "," .. recordIndex .. " )")
  btnContent:addInputEvent("Mouse_On", "HandleEventOnOut_LootingItemReport_showRecordInfoTooltip( true," .. fieldIndex .. "," .. recordIndex .. " )")
  btnContent:addInputEvent("Mouse_Out", "HandleEventOnOut_LootingItemReport_showRecordInfoTooltip( false," .. fieldIndex .. "," .. recordIndex .. " )")
  pinIcon:SetShow(ToClient_IsLootingItemSavedRecord(recordInfo:getRecordNo()))
end
function FromClient_UpdateLootingItemRecordList(recordNo)
  local self = PaGlobal_Window_LootingItemReport_Main_All
  if self == nil then
    return
  end
  self:updateRecordList(self._fieldIndex)
  local recordCount = ToClient_GetLootingItemRecordCount(fieldIndex)
  for index = 0, recordCount - 1 do
    local recordInfo = ToClient_GetLootingItemRecord(fieldIndex, index)
    if recordInfo == nil then
      return
    end
    if recordInfo:getRecordNo() == recordNo then
      self:updateRecordInfo(self._fieldIndex, index)
      return
    end
  end
end
function PaGloabl_Window_LootingItemReport_Main_All_Open(fieldIndex)
  if PaGlobal_Window_LootingItemReport_Main_All == nil then
    return
  end
  PaGlobal_Window_LootingItemReport_Main_All:prepareOpen(fieldIndex)
end
function PaGloabl_Window_LootingItemReport_Main_All_Close()
  if PaGlobal_Window_LootingItemReport_Main_All == nil then
    return
  end
  PaGlobal_Window_LootingItemReport_Main_All:prepareClose()
end
