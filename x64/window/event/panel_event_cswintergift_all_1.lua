function PaGlobal_Event_CSWintergift:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_BranchBG = UI.getChildControl(Panel_Event_CSWinterGift, "Static_BranchBG")
  self._ui._txt_CSWinterGiftTitle = UI.getChildControl(self._ui._stc_BranchBG, "StaticText_CSWinterGiftTitle")
  self._ui._stc_MiddleGroup = UI.getChildControl(self._ui._stc_BranchBG, "Static_MiddleGroup")
  self._ui._stc_ReciveGroup = UI.getChildControl(self._ui._stc_MiddleGroup, "Static_ReciveGroup")
  for slotIndex = 1, self._giftSlotCount do
    self._giftSlot[slotIndex] = UI.getChildControl(self._ui._stc_ReciveGroup, "Static_GiftSlot" .. tostring(slotIndex))
    local textControl = UI.getChildControl(self._giftSlot[slotIndex], "StaticText_ItemText")
    local text = textControl:GetText()
    textControl:SetText(text .. "")
    textControl:SetTextMode(__eTextMode_Limit_AutoWrap)
    textControl:setLineCountByLimitAutoWrap(2)
    textControl:SetText(text)
  end
  self._ui._txt_BotText = UI.getChildControl(self._ui._stc_BranchBG, "MultilineText_BotText")
  self._ui._txt_KeyGuide = UI.getChildControl(self._ui._stc_BranchBG, "Static_KeyGuide_ConsoleUI")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Event_CSWintergift:validate()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  self._ui._stc_BranchBG:isValidate()
  self._ui._txt_CSWinterGiftTitle:isValidate()
  self._ui._stc_MiddleGroup:isValidate()
  self._ui._stc_ReciveGroup:isValidate()
  for slotIndex = 1, self._giftSlotCount do
    self._giftSlot[slotIndex]:isValidate()
  end
  self._ui._txt_BotText:isValidate()
  self._ui._txt_KeyGuide:isValidate()
end
function PaGlobal_Event_CSWintergift:registEventHandler()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  registerEvent("onScreenResize", "FromClient_Event_CSWintergift_ResizePanel")
  registerEvent("selfPlayer_regionChanged", "PaGlobal_Event_CSWintergift_Open")
  if true == self._isConsole then
    Panel_Event_CSWinterGift:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEvent_LUp_Event_CSWintergift_Confirm()")
    Panel_Event_CSWinterGift:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEvent_LUp_Event_CSWintergift_ShowSelectItemTooltip()")
    Panel_Event_CSWinterGift:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_Event_CSWintergift_SaveShowByToday()")
    for slotIndex = 1, self._giftSlotCount do
      self._giftSlot[slotIndex]:addInputEvent("Mouse_On", "HandleEvent_On_Event_CSWintergift_UpdateSelectIndex(" .. tostring(slotIndex) .. ")")
      self._giftSlot[slotIndex]:addInputEvent("Mouse_Out", "HandleEvent_Out_Event_CSWintergift_CloseSelectItemTooltip()")
    end
  end
end
function PaGlobal_Event_CSWintergift:prepareOpen(regionData)
  if nil == Panel_Event_CSWinterGift then
    return
  end
  if nil == regionData or nil == regionData:get() then
    return
  end
  if false == regionData:get():isSafeZone() then
    return
  end
  if false == ToClient_isConsole() then
    return
  end
  if false == self:showByToday() then
    return
  end
  if true == ToClient_isPS() then
    local nationType = getServiceNationType()
    if 1 == nationType then
      if true == ToClient_GetIsBuyBundleByProductID(self._ps_EU_EntitlementID) then
        return
      end
    elseif true == ToClient_GetIsBuyBundleByProductID(self._ps_NA_ASIA_EntitlementID) then
      return
    end
  elseif true == ToClient_GetIsBuyBundleByProductID(self._xbox_LegacyProductID) then
    return
  end
  self._isTooltipShow = false
  self._selectIndex = nil
  PaGlobal_Event_CSWintergift:open()
end
function PaGlobal_Event_CSWintergift:open()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  Panel_Event_CSWinterGift:SetShow(true)
end
function PaGlobal_Event_CSWintergift:prepareClose()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  if false == self._isConsole then
    if nil ~= Panel_Tooltip_Item_hideTooltip then
      Panel_Tooltip_Item_hideTooltip()
    end
  elseif nil ~= PaGlobalFunc_TooltipInfo_Close then
    PaGlobalFunc_TooltipInfo_Close()
  end
  PaGlobal_Event_CSWintergift:close()
end
function PaGlobal_Event_CSWintergift:close()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  Panel_Event_CSWinterGift:SetShow(false)
end
function PaGlobal_Event_CSWintergift:showByToday()
  if nil == Panel_Event_CSWinterGift then
    return false
  end
  local year = ToClient_GetThisYear()
  local month = ToClient_GetThisMonth()
  local day = ToClient_GetToday()
  local dayCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListTime(__eWinterPakageBannerShowToday)
  if nil ~= dayCheck then
    local savedYear = dayCheck:GetYear()
    local savedMonth = dayCheck:GetMonth()
    local savedDay = dayCheck:GetDay()
    if year == savedYear and month == savedMonth and day == savedDay then
      return false
    end
  end
  return true
end
function PaGlobal_Event_CSWintergift:saveShowByToday()
  if nil == Panel_Event_CSWinterGift then
    return
  end
  local year = ToClient_GetThisYear()
  local month = ToClient_GetThisMonth()
  local day = ToClient_GetToday()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListTime(__eWinterPakageBannerShowToday, year, month, day, 0, 0, 0, CppEnums.VariableStorageType.eVariableStorageType_User)
end
