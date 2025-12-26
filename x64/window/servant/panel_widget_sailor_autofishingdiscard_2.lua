function PaGloabl_SailorAutoFishingDiscard_All_Open()
  local self = PaGlobal_SailorAutoFishingDiscard_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGloabl_SailorAutoFishingDiscard_All_Close()
  local self = PaGlobal_SailorAutoFishingDiscard_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGloabl_SailorAutoFishingDiscard_All_SetFishDiscardList(isShow)
  local self = PaGlobal_SailorAutoFishingDiscard_All
  if self == nil then
    return
  end
  self._ui._stc_fishDiscardList:SetShow(isShow)
  if isShow == true then
    for i = 0, self._eGradeList._count - 1 do
      if self._ui._chk_fishGradeList[i] ~= nil then
        local selectIcon = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_Select")
        if self._currentSelectGrade == i and self._currentSelectGrade ~= self._eGradeList._none then
          selectIcon:SetShow(true)
        else
          selectIcon:SetShow(false)
        end
      end
    end
  end
  if self._currentSelectGrade >= self._eGradeList._none and self._currentSelectGrade < self._eGradeList._count and PaGlobal_ShipCannon ~= nil then
    PaGlobal_ShipCannon._ui._stc_fishDiscardArrow:SetColor(self._arrowGradeColor[self._currentSelectGrade])
  end
end
function PaGloabl_SailorAutoFishingDiscard_All_ClickDiscardFishGrade(grade)
  local self = PaGlobal_SailorAutoFishingDiscard_All
  if self == nil then
    return
  end
  for i = 0, self._eGradeList._count - 1 do
    if self._ui._chk_fishGradeList[i] ~= nil then
      local selectIcon = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_Select")
      if grade == i and grade ~= self._eGradeList._none then
        selectIcon:SetShow(true)
      else
        selectIcon:SetShow(false)
      end
    end
  end
  self._currentSelectGrade = grade
  if self._currentSelectGrade >= self._eGradeList._none and self._currentSelectGrade < self._eGradeList._count and PaGlobal_ShipCannon ~= nil then
    PaGlobal_ShipCannon._ui._stc_fishDiscardArrow:SetColor(self._arrowGradeColor[self._currentSelectGrade])
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil then
    selfPlayer:setEmployeeFishingAutoItemGrade(grade)
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eEmployeeFishingGrade, grade, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGloabl_SailorAutoFishingDiscard_All_SetFishDiscardListConsole()
  local self = PaGlobal_SailorAutoFishingDiscard_All
  if self == nil then
    return
  end
  if self._isPadSnapping == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfProxy = getSelfPlayer():get()
  if selfProxy == nil then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if actorKeyRaw == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_REMOVEGRADE_SELECT_BOARDING"))
    return
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if vehicleProxy == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_REMOVEGRADE_SELECT_BOARDING"))
    return
  end
  local fishingSlotCount = ToClient_getEmployeePresetJobCount(vehicleProxy:getCharacterKeyRaw(), __eEmployeePresetJob_Fishing)
  if fishingSlotCount <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_REMOVEGRADE_OTHER_BOARDING"))
    return
  end
  if ToClient_canShowAutoFishingGauge() == false then
    local messageData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_SAILOR_FISHING_REMOVEGRADE_SELECT_DONT"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageData)
    return
  end
  if Panel_Widget_Sailor_AutoFishingDiscard:IsShow() == false then
    PaGloabl_SailorAutoFishingDiscard_All_Open()
  else
    PaGloabl_SailorAutoFishingDiscard_All_Close()
  end
end
