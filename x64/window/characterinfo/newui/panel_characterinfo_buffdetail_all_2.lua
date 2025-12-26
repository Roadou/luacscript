function PaGlobalFunc_CharInfoBuffDetail_All_Update()
  if PaGlobalFunc_ChracterInfo_All_GetBgShow(PaGlobal_CharInfo_All._TABINDEX._buffDetail) == false then
    return
  end
  local self = PaGlobal_CharacterInfo_BuffDetail_All
  self:update()
  HandleEventLDown_BuffDetail_All_UpdateDescArea(self._currentDescIndex.uiCount, self._currentDescIndex.groupIdx, self._currentDescIndex.tokenIdx, self._currentDescIndex.dataIdx)
end
function HandleEvent_BuffDetail_All_ListScroll(isUp)
  local self = PaGlobal_CharacterInfo_BuffDetail_All
  local newStartSlotIndex = UIScroll.ScrollEvent(self._ui._listScroll.stc_bg, isUp, self._config.slotMaxCount, self._listCount + self._openedOffset, self._startSlotIndex, 1)
  if isUp == true then
    if self._useArray[newStartSlotIndex + self._config.slotMaxCount - 6].isGroup == false and self._useArray[newStartSlotIndex + self._config.slotMaxCount - 6].isClass == false then
      newStartSlotIndex = newStartSlotIndex - 6
    end
  else
    local newEndSlotIndex = math.min(self._listCount, newStartSlotIndex + self._config.slotMaxCount - 1)
    if self._useArray[newEndSlotIndex].isGroup == false and self._useArray[newEndSlotIndex].isClass == false then
      newStartSlotIndex = newStartSlotIndex + 6
    end
  end
  newStartSlotIndex = math.max(1, newStartSlotIndex)
  newStartSlotIndex = math.min(newStartSlotIndex, self._listCount + self._openedOffset - self._config.slotMaxCount)
  if newStartSlotIndex == self._startSlotIndex then
    return
  else
    for groupIdx = 1, #self._formulaData do
      if self._groupOpen[groupIdx] == true then
        for tokenIdx = 1, #self._formulaData[groupIdx].parsed do
          self._formulaData[groupIdx].parsed[tokenIdx]:SetShow(false)
        end
      end
    end
    self._startSlotIndex = newStartSlotIndex
  end
  self:update()
end
function HandleEventLUp_BuffDetail_All_GroupTitleUpdateExpand(Idx)
  local self = PaGlobal_CharacterInfo_BuffDetail_All
  if self._groupOpen[Idx] == nil then
    return
  end
  self._currentDescIndex.uiCount = nil
  self._currentDescIndex.groupIdx = nil
  self._currentDescIndex.tokenIdx = nil
  self._currentDescIndex.dataIdx = nil
  for groupIdx = 1, #self._formulaData do
    if self._groupOpen[groupIdx] == true then
      for tokenIdx = 1, #self._formulaData[groupIdx].parsed do
        self._formulaData[groupIdx].parsed[tokenIdx]:SetShow(false)
      end
    end
  end
  local indexA = 0
  for tokenIdx = 1, #self._formulaData[Idx].parsed do
    if indexA == 0 and self._formulaData[Idx].format:sub(tokenIdx, tokenIdx) == "A" then
      indexA = tokenIdx
    end
  end
  local isOpenableOnlyGroupOne = true
  local isOpenGroup = not self._groupOpen[Idx]
  if isOpenableOnlyGroupOne == true and isOpenGroup == true then
    for groupIdx = 1, #self._formulaData do
      if self._groupOpen[groupIdx] == true then
        self._groupOpen[groupIdx] = false
        break
      end
    end
  end
  self._groupOpen[Idx] = isOpenGroup
  self:update()
  local newUiCount = 1
  for idx = self._startSlotIndex, self._listCount do
    if newUiCount > self._config.slotMaxCount then
      break
    end
    if self._useArray[idx] ~= nil then
      if self._useArray[idx].isGroup == true and self._useArray[idx].groupIdx == Idx then
        break
      end
      newUiCount = newUiCount + 1
    end
  end
  if newUiCount == self._config.slotMaxCount then
    HandleEvent_BuffDetail_All_ListScroll(false)
  elseif newUiCount >= self._config.slotMaxCount - 7 then
    for ii = 1, newUiCount - (self._config.slotMaxCount - 7) do
      HandleEvent_BuffDetail_All_ListScroll(false)
    end
  end
  if isOpenGroup == true and indexA > 0 then
    self._currentDescIndex.uiCount = newUiCount
    self._currentDescIndex.groupIdx = Idx
    self._currentDescIndex.tokenIdx = indexA
    self._currentDescIndex.dataIdx = 1
    self:update()
  end
end
function HandleEventLDown_BuffDetail_All_UpdateDescArea(uiCount, groupIdx, tokenIdx, dataIdx)
  if uiCount == nil or groupIdx == nil then
    return
  end
  local self = PaGlobal_CharacterInfo_BuffDetail_All
  if groupIdx < 1 or groupIdx > #self._formulaData then
    UI.ASSERT_NAME(false, "BuffDetail groupIdx is invalid = groupIdx : " .. tostring(groupIdx), "\234\185\128\236\132\177\234\183\156")
    return
  end
  for ii = 1, self._config.descMaxCount do
    UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_List_Template_" .. ii):SetShow(false)
  end
  if dataIdx == nil then
    return
  end
  if dataIdx < 1 or dataIdx > #self._formulaData[groupIdx].data then
    UI.ASSERT_NAME(false, "BuffDetail dataIdx is invalid = groupIdx : " .. tostring(groupIdx) .. ", dataIdx : " .. tostring(dataIdx), "\234\185\128\236\132\177\234\183\156")
    return
  end
  local txt_desc = UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_Selected_Desc")
  local stc_totalIcon = UI.getChildControl(self._uiPool.listMain[uiCount].right, "Static_Detail_Total_Icon")
  local txt_total = UI.getChildControl(stc_totalIcon, "StaticText_Detail_Total_Value")
  stc_totalIcon:SetShow(true)
  txt_total:SetShow(true)
  local func = self._formulaData[groupIdx].data[dataIdx].func
  local params = self._formulaData[groupIdx].data[dataIdx].params
  if dataIdx == 1 and func == nil and params ~= nil then
    txt_desc:SetText(params[1])
    stc_totalIcon:SetShow(false)
    txt_total:SetShow(false)
  else
    txt_desc:SetText(self._formulaData[groupIdx].data[dataIdx].name)
  end
  if self._uiPool.listMain[uiCount].data[dataIdx].value:GetShow() == true then
    txt_total:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_TOTALVALUE") .. " : " .. self._uiPool.listMain[uiCount].data[dataIdx].value:GetText())
  else
    txt_total:SetText(self._uiPool.listMain[uiCount].data[dataIdx].value:GetText())
  end
  UI.setLimitTextAndAddTooltip(txt_total, txt_total:GetText())
  UI.setLimitTextAndAddTooltip(txt_desc, txt_desc:GetText())
  txt_desc:SetShow(true)
  local descs = self._formulaData[groupIdx].data[dataIdx].desc
  if descs ~= nil then
    if groupIdx >= 22 and groupIdx < 28 and dataIdx == 3 or groupIdx == 28 and dataIdx == 2 then
      if func ~= nil then
        func(params[1])
        for ii = 1, 3 do
          local desc = UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_List_Template_" .. ii)
          if ii <= #descs then
            local combined = ""
            local percent = ToClient_getCollectingStatAddDropRate(ii - 1) * 0.01
            if percent % 100 ~= 0 then
              combined = string.format("%.2f", percent * 0.01) .. self._formulaData[groupIdx].data[dataIdx].unit
            else
              combined = tostring(percent * 0.01) .. self._formulaData[groupIdx].data[dataIdx].unit
            end
            desc:SetShow(true)
            desc:SetText("-  " .. descs[ii] .. " : " .. combined)
            UI.setLimitTextAndAddTooltip(desc, desc:GetText())
          end
        end
        local desc = UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_List_Template_4")
        desc:SetShow(true)
        desc:SetText("-  " .. descs[4])
        UI.setLimitTextAndAddTooltip(desc, desc:GetText())
        txt_total:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BUFFDETAIL_DESC_TOTALVALUE"))
      end
    else
      for ii = 1, self._config.descMaxCount do
        local desc = UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_List_Template_" .. ii)
        if ii <= #descs then
          desc:SetShow(true)
          desc:SetText("-  " .. descs[ii])
          UI.setLimitTextAndAddTooltip(desc, desc:GetText())
        end
      end
    end
  end
  if tokenIdx ~= nil then
    self:resetSelectedEffect(uiCount, groupIdx)
    UI.getChildControl(self._formulaData[groupIdx].parsed[tokenIdx], "Static_Selected"):SetShow(true)
    self._formulaData[groupIdx].parsed[tokenIdx]:setRenderTexture(self._formulaData[groupIdx].parsed[tokenIdx]:getClickTexture())
    local dataControl = UI.getChildControl(self._uiPool.listMain[uiCount].left, "StaticText_Detail_" .. self._numToVar[dataIdx])
    local tokenIconControl = UI.getChildControl(dataControl, "StaticText_Icon_" .. self._numToVar[dataIdx])
    dataControl:setRenderTexture(dataControl:getClickTexture())
    tokenIconControl:setRenderTexture(tokenIconControl:getClickTexture())
  end
  self._currentDescIndex.uiCount = uiCount
  self._currentDescIndex.groupIdx = groupIdx
  self._currentDescIndex.tokenIdx = tokenIdx
  self._currentDescIndex.dataIdx = dataIdx
end
function HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(uiCount, groupIdx, tokenIdx, dataIdx, isOn)
  if uiCount == nil or groupIdx == nil or tokenIdx == nil or dataIdx == nil or isOn == nil then
    return
  end
  local self = PaGlobal_CharacterInfo_BuffDetail_All
  UI.getChildControl(self._formulaData[groupIdx].parsed[tokenIdx], "Static_Selected"):SetShow(isOn)
  local dataControl = UI.getChildControl(self._uiPool.listMain[uiCount].left, "StaticText_Detail_" .. self._numToVar[dataIdx])
  local tokenIconControl = UI.getChildControl(dataControl, "StaticText_Icon_" .. self._numToVar[dataIdx])
  if isOn == true then
    self._formulaData[groupIdx].parsed[tokenIdx]:setRenderTexture(self._formulaData[groupIdx].parsed[tokenIdx]:getOnTexture())
    dataControl:setRenderTexture(dataControl:getOnTexture())
    tokenIconControl:setRenderTexture(tokenIconControl:getOnTexture())
  else
    self:resetSelectedEffect(uiCount, groupIdx)
    if self._currentDescIndex.uiCount ~= nil and self._currentDescIndex.groupIdx ~= nil and self._currentDescIndex.tokenIdx ~= nil and self._currentDescIndex.dataIdx ~= nil then
      UI.getChildControl(self._formulaData[self._currentDescIndex.groupIdx].parsed[self._currentDescIndex.tokenIdx], "Static_Selected"):SetShow(true)
      dataControl = UI.getChildControl(self._uiPool.listMain[self._currentDescIndex.uiCount].left, "StaticText_Detail_" .. self._numToVar[self._currentDescIndex.dataIdx])
      tokenIconControl = UI.getChildControl(dataControl, "StaticText_Icon_" .. self._numToVar[self._currentDescIndex.dataIdx])
      self._formulaData[self._currentDescIndex.groupIdx].parsed[self._currentDescIndex.tokenIdx]:setRenderTexture(self._formulaData[self._currentDescIndex.groupIdx].parsed[self._currentDescIndex.tokenIdx]:getOnTexture())
      dataControl:setRenderTexture(dataControl:getOnTexture())
      tokenIconControl:setRenderTexture(tokenIconControl:getOnTexture())
    end
  end
end
