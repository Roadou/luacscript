function PaGlobal_Edania_Contents_Open(openType, edaniaRegion, openByNpc)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  if openType == self.OPENTYPE.CHALLENGER and ToClient_IsEdana(selfPlayerWrapper:getUserNo()) == true then
    if openByNpc == true then
      openType = self.OPENTYPE.CHALLENGER
    else
      openType = self.OPENTYPE.EDANA
    end
  end
  self:prepareOpen(openType, edaniaRegion, openByNpc)
end
function PaGlobal_Edania_Contents_OpenByESC()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local edaniaRegion = ToClient_GetEdaniaRegion(selfPlayerWrapper:getUserNo())
  if edaniaRegion == __eEdaniaRegion_Count then
    edaniaRegion = ToClient_GetEdaniaApplyRegion()
    if edaniaRegion == __eEdaniaRegion_Count then
      edaniaRegion = __eEdaniaRegion_Aetherion
    end
  end
  PaGlobal_Edania_Contents_Open(self.OPENTYPE.CHALLENGER, edaniaRegion, false)
end
function PaGlobal_Edania_Contents_Close()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Edania_Contents_IsOpen()
  return Panel_Window_Edania_Contents_All:GetShow() == true
end
function PaGlobal_Edania_Contents_EnterBossRoom()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local function teleportBossRoom()
    ToClient_TeleportToBossRoom(self._edaniaRegion)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_WORLDBOSS_WARNING_MESSAGE"),
    functionYes = teleportBossRoom,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_Edania_Contents_EnterChallengeRoom()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local findIndex = -1
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_Edania)
  for index = 0, roomCount - 1 do
    local roomWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_Edania, index)
    if roomWrapper ~= nil and roomWrapper:getFieldMapKey() == self._data[self._edaniaRegion]._challengeRoomMapKey then
      findIndex = index
      break
    end
  end
  if findIndex == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEdanaChallenger"))
    return
  end
  ToClient_FindForJoinPrivateRoomForAll(__eInstanceContentsType_Edania, findIndex)
end
function PaGlobal_Edania_Contents_EnterEdanaRoom()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local findIndex = -1
  local roomCount = ToClient_requestGetInstancePrivateRoomCountWithType(__eInstanceContentsType_Edania)
  for index = 0, roomCount - 1 do
    local roomWrapper = ToClient_InstanceFieldRoomInfoWrapperWithType(__eInstanceContentsType_Edania, index)
    if roomWrapper ~= nil and roomWrapper:getFieldMapKey() == self._data[self._edaniaRegion]._edanaRoomMapKey then
      findIndex = index
      break
    end
  end
  if findIndex == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEdanaChallenger"))
    return
  end
  ToClient_FindForJoinPrivateRoomForAll(__eInstanceContentsType_Edania, findIndex)
end
function PaGlobal_Edania_Contents_InformationUpdate(deltaTime)
  local self = PaGlobal_Edania_Contents
  if self == nil or Panel_Window_Edania_Contents_All:GetShow() == false then
    return
  end
  local receiptControl = self._ui._receipt
  local receiptMaxSize = self._maxReceiptSize
  local pickControl = self._ui._pick
  local pickMaxSize = self._maxPickSize
  local fightDateControl = self._ui._fightDate
  local fightDateMaxSize = self._maxFightDateSize
  local finalControl = self._ui._final
  local finalMaxSize = self._maxFinalSize
  local frame = self._ui._frame_Desc
  local vScroll = frame:GetVScroll()
  local content = frame:GetFrameContent()
  local speedTime = self._aniSpeedTime
  local valueExtraY = 200
  if receiptControl._rdo_Title:IsCheck() == true then
    local value = receiptControl._stc_Background:GetSizeY() + (receiptMaxSize - receiptControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + valueExtraY)
    content:SetSize(content:GetSizeX(), value + valueExtraY)
    receiptControl._stc_Background:SetSize(receiptControl._stc_Background:GetSizeX(), value)
    receiptControl._stc_Background:SetShow(true)
  else
    local value = receiptControl._stc_Background:GetSizeY() - (receiptMaxSize + receiptControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    receiptControl._stc_Background:SetSize(receiptControl._stc_Background:GetSizeX(), value)
    if receiptControl._stc_Background:GetSizeY() <= 10 then
      receiptControl._stc_Background:SetShow(false)
    end
  end
  if pickControl._rdo_Title:IsCheck() == true then
    local value = pickControl._stc_Background:GetSizeY() + (pickMaxSize - pickControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + valueExtraY)
    content:SetSize(content:GetSizeX(), value + valueExtraY)
    pickControl._stc_Background:SetSize(pickControl._stc_Background:GetSizeX(), value)
    pickControl._stc_Background:SetShow(true)
  else
    local value = pickControl._stc_Background:GetSizeY() - (pickMaxSize + pickControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    pickControl._stc_Background:SetSize(pickControl._stc_Background:GetSizeX(), value)
    if pickControl._stc_Background:GetSizeY() <= 10 then
      pickControl._stc_Background:SetShow(false)
    end
  end
  if fightDateControl._rdo_Title:IsCheck() == true then
    local value = fightDateControl._stc_Background:GetSizeY() + (fightDateMaxSize - fightDateControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + valueExtraY)
    content:SetSize(content:GetSizeX(), value + valueExtraY)
    fightDateControl._stc_Background:SetSize(fightDateControl._stc_Background:GetSizeX(), value)
    fightDateControl._stc_Background:SetShow(true)
  else
    local value = fightDateControl._stc_Background:GetSizeY() - (fightDateMaxSize + fightDateControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    fightDateControl._stc_Background:SetSize(fightDateControl._stc_Background:GetSizeX(), value)
    if fightDateControl._stc_Background:GetSizeY() <= 10 then
      fightDateControl._stc_Background:SetShow(false)
    end
  end
  if finalControl._rdo_Title:IsCheck() == true then
    local value = finalControl._stc_Background:GetSizeY() + (finalMaxSize - finalControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    vScroll:SetShow(frame:GetSizeY() < value + valueExtraY)
    content:SetSize(content:GetSizeX(), value + valueExtraY)
    finalControl._stc_Background:SetSize(finalControl._stc_Background:GetSizeX(), value)
    finalControl._stc_Background:SetShow(true)
  else
    local value = finalControl._stc_Background:GetSizeY() - (finalMaxSize + finalControl._stc_Background:GetSizeY()) * deltaTime * speedTime
    if value < 10 then
      value = 10
    end
    finalControl._stc_Background:SetSize(finalControl._stc_Background:GetSizeX(), value)
    if finalControl._stc_Background:GetSizeY() <= 10 then
      finalControl._stc_Background:SetShow(false)
    end
  end
  receiptControl._stc_Background:SetPosY(receiptControl._rdo_Title:GetPosY() + receiptControl._rdo_Title:GetSizeY())
  if receiptControl._stc_Background:GetShow() == true then
    pickControl._rdo_Title:SetPosY(receiptControl._stc_Background:GetPosY() + receiptControl._stc_Background:GetSizeY() + 10)
  else
    pickControl._rdo_Title:SetPosY(receiptControl._rdo_Title:GetPosY() + receiptControl._rdo_Title:GetSizeY() + 5)
  end
  pickControl._stc_Background:SetPosY(pickControl._rdo_Title:GetPosY() + pickControl._rdo_Title:GetSizeY())
  if pickControl._stc_Background:GetShow() == true then
    fightDateControl._rdo_Title:SetPosY(pickControl._stc_Background:GetPosY() + pickControl._stc_Background:GetSizeY() + 10)
  else
    fightDateControl._rdo_Title:SetPosY(pickControl._rdo_Title:GetPosY() + pickControl._rdo_Title:GetSizeY() + 5)
  end
  fightDateControl._stc_Background:SetPosY(fightDateControl._rdo_Title:GetPosY() + fightDateControl._rdo_Title:GetSizeY())
  if fightDateControl._stc_Background:GetShow() == true then
    finalControl._rdo_Title:SetPosY(fightDateControl._stc_Background:GetPosY() + fightDateControl._stc_Background:GetSizeY() + 10)
  else
    finalControl._rdo_Title:SetPosY(fightDateControl._rdo_Title:GetPosY() + fightDateControl._rdo_Title:GetSizeY() + 5)
  end
  finalControl._stc_Background:SetPosY(finalControl._rdo_Title:GetPosY() + finalControl._rdo_Title:GetSizeY())
  for _, control in pairs(receiptControl._txt_Content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < receiptControl._stc_Background:GetSizeY())
  end
  for _, control in pairs(pickControl._txt_Content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < pickControl._stc_Background:GetSizeY())
  end
  for _, control in pairs(fightDateControl._txt_Content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < fightDateControl._stc_Background:GetSizeY())
  end
  for _, control in pairs(finalControl._txt_Content) do
    control:SetShow(control:GetPosY() + control:GetSizeY() < finalControl._stc_Background:GetSizeY())
  end
end
function PaGlobal_Edania_Contents_ScreenResize()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local sizeX = getScreenSizeX()
  local sizeY = getScreenSizeY()
  Panel_Window_Edania_Contents_All:SetSize(sizeX, sizeY)
  self._ui._stc_Boss:SetSize(sizeX, sizeY)
  self._ui._stc_RegionByBoss:SetSize(sizeX, sizeY)
  self._ui._stc_Challenger:SetSize(sizeX, sizeY)
  self._ui._stc_ChallengerBG:SetSize(sizeX, sizeY)
  self._ui._stc_Edana:SetSize(sizeX, sizeY)
  self._ui._stc_EdanaBG:SetSize(sizeX, sizeY)
  Panel_Window_Edania_Contents_All:ComputePosAllChild()
end
function PaGlobal_Edania_Contents_ChangeEdana(isLeft)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  if isLeft == true then
    self._edaniaRegion = self._edaniaRegion - 1
    if self._edaniaRegion <= __eEdaniaRegion_Aetherion then
      self._edaniaRegion = __eEdaniaRegion_Aetherion
    end
  else
    self._edaniaRegion = self._edaniaRegion + 1
    if self._edaniaRegion > __eEdaniaRegion_Count - 1 then
      self._edaniaRegion = __eEdaniaRegion_Count - 1
    end
  end
  HandleEventLUp_Edania_Contents_ToggleEdaniaMark(self._edaniaRegion)
end
function HandleEventLUp_Edania_Contents_UseDropBuff()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  ToClient_UseEdanaDropBuff(self._edaniaRegion)
end
function HandleEventLUp_Edania_Contents_ShowInfo()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  self._ui._stc_Info:SetShow(self._ui._stc_Info:GetShow() == false)
end
function HandleEventLUp_Edania_Contents_Join()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  if self._openType == self.OPENTYPE.BOSS then
    PaGlobal_Edania_Contents_EnterBossRoom()
  elseif self._openType == self.OPENTYPE.CHALLENGER then
    local selfPlayerWrapper = getSelfPlayer()
    if selfPlayerWrapper == nil then
      return
    end
    if ToClient_IsEdanaChallenger(selfPlayerWrapper:getUserNo()) == true then
      PaGlobal_Edania_Contents_EnterChallengeRoom()
    elseif ToClient_IsEdanaFinalChallenger(selfPlayerWrapper:getUserNo()) == true then
      PaGlobal_Edania_Contents_EnterEdanaRoom()
    elseif ToClient_IsSelfRegionApplyEdana(selfPlayerWrapper:getUserNo(), selfPlayerWrapper:getCharacterNo_64()) == true then
      PaGlobal_Edania_Contents_EnterEdanaRoom()
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEdanaChallenger"))
    end
  elseif self._openType == self.OPENTYPE.EDANA then
    PaGlobal_Edania_Contents_EnterEdanaRoom()
  end
end
function HandleEventLUp_Edania_Contents_DescriptionCheck(descType)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local frame = self._ui._frame_Desc
  local vScroll = frame:GetVScroll()
  vScroll:SetControlTop()
  frame:UpdateContentScroll()
  frame:UpdateContentPos()
  self._openDesc = descType
  if descType == 0 then
    self._ui._receipt._stc_Background:SetShow(true)
  elseif descType == 1 then
    self._ui._pick._stc_Background:SetShow(true)
  elseif descType == 2 then
    self._ui._fightDate._stc_Background:SetShow(true)
  elseif descType == 3 then
    self._ui._final._stc_Background:SetShow(true)
  else
    self._openDesc = -1
  end
end
function HandleEventLUp_Edania_Contents_ShowTooltip(tooltipType, isShow)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local etcOptionWrapper = ToClient_GetEdaniaEtcOption()
  if etcOptionWrapper == nil then
    return
  end
  local name, desc, control
  if tooltipType == 0 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_AUTHORITY")
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_AUTHORITY_CURRENT_DESC", "time", etcOptionWrapper:getEdanaDropBuffTime(), "percent", etcOptionWrapper:getEdanaDropBuffPercent())
    control = self._ui._txt_ChallengerEdanaIcon
  elseif tooltipType == 1 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_AUTHORITY")
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_AUTHORITY_CURRENT_DESC", "time", etcOptionWrapper:getEdanaDropBuffTime(), "percent", etcOptionWrapper:getEdanaDropBuffPercent())
    control = self._ui._txt_EdanaEdanaIcon
  elseif tooltipType == 2 then
    local taxPercent = etcOptionWrapper:getEdanaPersonalFieldTaxPercent(self._edaniaRegion) / 10000
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_TAX_STATUS")
    desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_TAX_STATUS_DESC", "percent", taxPercent, "date", PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SUNDAY"))
    control = self._ui._stc_EdanaTax
  elseif tooltipType == 3 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_AUTHORITY")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_AUTHORITY_DESC", "percent", etcOptionWrapper:getEdanaDropBuffPercent())
    control = self._ui._stc_EdanaInfo
  elseif tooltipType == 4 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_BUTTON_REFRESH")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_BUTTON_REFRESH_DESC")
    control = self._ui._btn_Refresh
  elseif tooltipType == 5 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_RETURN_BUTTON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_RETURN_BUTTON_DESC")
    control = self._ui._btn_Return
  elseif tooltipType == 6 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_CHECK_EQUIPMENT")
    control = self._ui._stc_EquiptmentIcon
  elseif tooltipType == 7 then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_GUIDELINE_TITLE")
    desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_GUIDELINE_DESC")
    control = self._ui._chk_CheckArea
  elseif tooltipType == 8 then
    local taxPercent = etcOptionWrapper:getEdanaPersonalFieldTaxPercent(self._edaniaRegion) / 10000
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_ACCRUETAX_TOOLTIP")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_ACCRUETAX_TOOLTIP_DESC", "percent", taxPercent)
    control = self._ui._stc_ChallengerPreviousTax
  elseif tooltipType == 9 then
    local taxPercent = etcOptionWrapper:getEdanaPersonalFieldTaxPercent(self._edaniaRegion) / 10000
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_ACCRUETAX_TOOLTIP")
    desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_ACCRUETAX_TOOLTIP_DESC", "percent", taxPercent)
    control = self._ui._stc_EdanaPreviousTax
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Edania_Contents_ShowBossClearItemTooltip(isShow)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  if self._isUsePadSnapping == true then
    if self._isConsole == true then
      if PaGlobalFunc_TooltipInfo_GetShow() == true then
        isShow = false
      end
    elseif self._isUsePadSnapping == true and Panel_Tooltup_Item_isShow() == true then
      isShow = false
    end
  end
  if isShow == false then
    if self._isConsole == true then
      PaGlobalFunc_TooltipInfo_Close()
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    return
  end
  local etcOptionWrapper = ToClient_GetEdaniaEtcOption()
  if etcOptionWrapper == nil then
    return
  end
  local bossClearItemKey = etcOptionWrapper:getEdanaBossClearItemKey(self._edaniaRegion)
  local bossClearItemSSW = getItemEnchantStaticStatus(bossClearItemKey)
  if bossClearItemSSW == nil then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, bossClearItemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(bossClearItemSSW, self._ui._stc_RewardItem, true, false)
  end
end
function HandleEventLUp_Edania_Contents_Refresh()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  ToClient_ApplyEdanaChallenge(self._edaniaRegion)
end
function HandleEventLUp_Edania_Contents_FindNpcPosition()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  ToClient_FindNpcPosition(self._edaniaRegion)
  PaGlobal_Edania_Contents_Close()
end
function HandleEventLUp_Edania_Contents_TeleportToMyCastle()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local isSuccess = ToClient_CallPreCoolTimeProgressBar(__ePreCoolTimeType_EdanaCastleTeleport, self._edaniaRegion)
  if isSuccess == false then
    return
  end
  PaGlobal_Edania_Contents_Close()
end
function HandleEventLUp_Edania_Contents_ToggleEdaniaRegion()
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  ToClient_ToggleEdaniaArea()
  self._ui._chk_CheckArea:SetCheck(ToClient_IsEdaniaAreaOn() == true)
end
function HandleEventLUp_Edania_Contents_ToggleEdaniaMark(edaniaRegion)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local mark = self._data[edaniaRegion]._rdo_Mark
  if mark == nil then
    return
  end
  if mark:IsIgnore() == true then
    return
  end
  PaGlobal_Edania_Contents_Open(self.OPENTYPE.CHALLENGER, edaniaRegion, false)
end
function FromClient_UpdateEdaniaContents()
  if PaGlobal_Edania_Contents_IsOpen ~= nil and PaGlobal_Edania_Contents_IsOpen() == false then
    return
  end
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  if self._openType == nil or self._edaniaRegion == nil then
    return
  end
  self:update(self._openType, self._edaniaRegion)
end
function FromClient_UpdateEdanaTax(edaniaRegion)
  local self = PaGlobal_Edania_Contents
  if self == nil then
    return
  end
  local edanaInfoWrapper = ToClient_GetEdanaInfo(edaniaRegion)
  if edanaInfoWrapper == nil then
    return
  end
  self._ui._txt_EdanaTax:SetText(makeDotMoney(edanaInfoWrapper:getTax()))
  local spanX = self._ui._btn_FieldEnchant:GetSpanSize().x + 13
  self._ui._txt_EdanaTax:SetPosX(self._ui._stc_EdanaTax:GetSizeX() - self._ui._txt_EdanaTax:GetSizeX() - self._ui._txt_EdanaTax:GetTextSizeX() - spanX)
end
