function PaGlobal_SailorAutoFishingDiscard_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_fishDiscardList = UI.getChildControl(Panel_Widget_Sailor_AutoFishingDiscard, "Static_SelectDrop")
  self._ui._stc_closeFishDiscardList = UI.getChildControl(self._ui._stc_fishDiscardList, "Button_Close")
  self._currentSelectGrade = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eEmployeeFishingGrade)
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil then
    selfPlayer:setEmployeeFishingAutoItemGrade(self._currentSelectGrade)
  end
  for index = 0, self._eGradeList._count - 1 do
    self._gradeString[index] = {}
    self._gradeString[index].name = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_DISCARD_ITEM_GRADE_" .. tostring(index))
    if self._eGradeList._none == index and self._eGradeList._normal == index then
      self._gradeString[index].desc = ""
    else
      self._gradeString[index].desc = PAGetString(Defines.StringSheet_GAME, "LUA_FISHING_WARNING_SELECT_" .. tostring(index - 1))
    end
  end
  local posX = 135
  self._ui._chk_fishGradeList = {}
  for i = 0, self._eGradeList._count - 1 do
    self._ui._chk_fishGradeList[i] = UI.getChildControl(self._ui._stc_fishDiscardList, "CheckButton_FishGrade" .. i)
    if self._ui._chk_fishGradeList[i] ~= nil then
      local gapX = self._ui._chk_fishGradeList[i]:GetSizeX() + 10
      local noSetIcon = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_NoSet")
      local fishIcon = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_FishIcon")
      local selectIcon = UI.getChildControl(self._ui._chk_fishGradeList[i], "Static_Select")
      self._ui._chk_fishGradeList[i]:SetShow(true)
      self._ui._chk_fishGradeList[i]:SetPosX(posX + gapX * (i - 1))
      if i == self._eGradeList._none then
        noSetIcon:SetShow(true)
        fishIcon:SetShow(false)
      else
        noSetIcon:SetShow(false)
        fishIcon:SetShow(true)
        fishIcon:SetColor(self._fishGradeColor[i])
      end
      selectIcon:SetShow(false)
    end
  end
  self._isPadSnapping = ToClient_isUsePadSnapping()
  Panel_Widget_Sailor_AutoFishingDiscard:SetIgnore(true)
  self._ui._stc_fishDiscardList:SetShow(true)
  self._ui._stc_closeFishDiscardList:SetShow(self._isPadSnapping == false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_SailorAutoFishingDiscard_All:registEventHandler()
  if Panel_Widget_Sailor_AutoFishingDiscard == nil then
    return
  end
  if _ContentsGroup_EmployeeAutoFishing == true then
    Panel_Widget_Sailor_AutoFishingDiscard:RegisterUpdateFunc("UpdateFunc_SailorAutoFishingDiscard_All_UpdateAutoFishingGauge")
  end
  self._ui._stc_closeFishDiscardList:addInputEvent("Mouse_LUp", "PaGloabl_SailorAutoFishingDiscard_All_Close()")
  for i = 0, self._eGradeList._count - 1 do
    if self._ui._chk_fishGradeList[i] ~= nil then
      self._ui._chk_fishGradeList[i]:addInputEvent("Mouse_LUp", "PaGloabl_SailorAutoFishingDiscard_All_ClickDiscardFishGrade(" .. i .. ")")
    end
  end
end
function PaGlobal_SailorAutoFishingDiscard_All:prepareOpen()
  if Panel_Widget_Sailor_AutoFishingDiscard == nil then
    return
  end
  if Panel_Widget_Sailor_AutoFishingDiscard:IsShow() == true then
    return
  end
  if Panel_Widget_ShipCannon_Right ~= nil then
    Panel_Widget_Sailor_AutoFishingDiscard:SetPosXY(Panel_Widget_ShipCannon_Right:GetPosX() - 15, Panel_Widget_ShipCannon_Right:GetPosY() - 75)
  end
  PaGloabl_SailorAutoFishingDiscard_All_SetFishDiscardList(true)
  self:open()
end
function PaGlobal_SailorAutoFishingDiscard_All:open()
  if Panel_Widget_Sailor_AutoFishingDiscard == nil then
    return
  end
  Panel_Widget_Sailor_AutoFishingDiscard:SetShow(true)
end
function PaGlobal_SailorAutoFishingDiscard_All:prepareClose()
  if Panel_Widget_Sailor_AutoFishingDiscard == nil then
    return
  end
  if Panel_Widget_Sailor_AutoFishingDiscard:IsShow() == false then
    return
  end
  PaGloabl_SailorAutoFishingDiscard_All_SetFishDiscardList(false)
  self:close()
  if self._isPadSnapping == true then
    ToClient_padSnapResetControl()
  end
end
function PaGlobal_SailorAutoFishingDiscard_All:close()
  if Panel_Widget_Sailor_AutoFishingDiscard == nil then
    return
  end
  Panel_Widget_Sailor_AutoFishingDiscard:SetShow(false)
  Panel_Widget_Sailor_AutoFishingDiscard:SetIgnore(true)
end
function PaGlobal_SailorAutoFishingDiscard_All:validate()
  if Panel_Widget_Sailor_AutoFishingDiscard == nil then
    return
  end
  self._ui._stc_fishDiscardList:isValidate()
  self._ui._stc_closeFishDiscardList:isValidate()
end
