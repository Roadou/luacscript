function PaGlobal_Widget_PersonalField_All:initialize()
  if true == self._initialize then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_stateIcon = UI.getChildControl(Panel_Widget_PersonalField_Mini, "Static_StatusIcon")
  self._ui._stc_green = UI.getChildControl(self._ui._stc_stateIcon, "Static_Green")
  self._ui._stc_yellow = UI.getChildControl(self._ui._stc_stateIcon, "Static_Yellow")
  self._ui._stc_red = UI.getChildControl(self._ui._stc_stateIcon, "Static_Red")
  self._ui._stc_alertIcon = UI.getChildControl(Panel_Widget_PersonalField_Mini, "Static_AlertIcon")
  self._ui._txt_name = UI.getChildControl(Panel_Widget_PersonalField_Mini, "StaticText_Name")
  self._ui._txt_time = UI.getChildControl(Panel_Widget_PersonalField_Mini, "StaticText_Time")
  self._ui._btn_navi = UI.getChildControl(Panel_Widget_PersonalField_Mini, "Button_Navi")
  self._ui._btn_enter = UI.getChildControl(Panel_Widget_PersonalField_Mini, "Button_Enter")
  self._ui._btn_exit = UI.getChildControl(Panel_Widget_PersonalField_Mini, "Button_Exit")
  self._ui._txt_serverBusy = UI.getChildControl(Panel_Widget_PersonalField_Mini, "StaticText_ServerBusy")
  self._ui._txt_enter = UI.getChildControl(Panel_Widget_PersonalField_Mini, "StaticText_Enter_ConsoleUI")
  self._ui._stc_enterCondition = UI.getChildControl(Panel_Widget_PersonalField_Mini, "StaticText_EnterCondition")
  self._ui._stc_itemListBg = UI.getChildControl(Panel_Widget_PersonalField_Mini, "Static_RewardGroup")
  if _ContentsGroup_LootingItemRecord == true then
    for ii = 0, self._slotCount - 1 do
      local slot = UI.getChildControl(self._ui._stc_itemListBg, "Static_Reward_Slot_" .. ii)
      if slot ~= nil then
        self._ui._stc_itemList[ii] = {}
        self._ui._stc_itemList[ii].control = slot
        SlotItem.new(self._ui._stc_itemList[ii], "ItemIcon_" .. ii, ii, self._ui._stc_itemList[ii].control, self._itemSlotConfig)
        self._ui._stc_itemList[ii]:createChild()
        self._ui._stc_itemList[ii].control:SetShow(true)
      end
    end
  end
  self._ui._stc_itemListBg:SetShow(false)
  self:registEventHandler()
  self:validate()
  self._initialize = true
  self:setExitRelayFieldButton()
end
function PaGlobal_Widget_PersonalField_All:validate()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  self._ui._stc_stateIcon:isValidate()
  self._ui._stc_green:isValidate()
  self._ui._stc_yellow:isValidate()
  self._ui._stc_red:isValidate()
  self._ui._stc_alertIcon:isValidate()
  self._ui._txt_name:isValidate()
  self._ui._txt_time:isValidate()
  self._ui._btn_navi:isValidate()
  self._ui._btn_enter:isValidate()
  self._ui._btn_exit:isValidate()
  self._ui._txt_serverBusy:isValidate()
  self._ui._txt_enter:isValidate()
  self._ui._stc_enterCondition:isValidate()
  if _ContentsGroup_LootingItemRecord == true then
    self._ui._stc_itemListBg:isValidate()
    for ii = 0, self._slotCount - 1 do
      self._ui._stc_itemList[ii].control:isValidate()
    end
  end
end
function PaGlobal_Widget_PersonalField_All:registEventHandler()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  registerEvent("onScreenResize", "FromClient_Widget_PersonalField_All_ResizePanel")
  registerEvent("FromClient_UpdateMirrorFieldState", "FromClient_Widget_PersonalField_All_UpdatePersonalFieldState")
  registerEvent("FromClient_UpdatePersonalFieldRemainTime", "FromClient_Widget_PersonalField_All_UpdateRemainTime")
  registerEvent("FromClient_UpdatePersonalFieldServerState", "FromClient_Widget_PersonalField_All_UpdateServerState")
  registerEvent("FromClient_PersonalFieldEnterFailed", "FromClient_Widget_PersonalField_All_ShowServerSelect")
  registerEvent("FromClient_UpdateCurrentLootingItemList", "FromClient_Widget_PersonalField_All_FromClient_UpdateCurrentLootingItemList")
  Panel_Widget_PersonalField_Mini:addInputEvent("Mouse_LUp", "PaGlobal_PersonalField_Main_All_Open()")
  self._ui._btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_PersonalField_All_Navi()")
  self._ui._btn_enter:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_PersonalField_All_OpenEnterUI()")
  self._ui._btn_exit:addInputEvent("Mouse_LUp", "HandleEventLUp_Widget_PersonalField_All_Leave()")
  self._ui._stc_stateIcon:addInputEvent("Mouse_On", "HandleEventOnOut_Widget_PersonalField_All_SetShowStateTooltip(true)")
  self._ui._stc_stateIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_Widget_PersonalField_All_SetShowStateTooltip(false)")
end
function PaGlobal_Widget_PersonalField_All:prepareOpen()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  if false == _ContentsGroup_PersonalField then
    return
  end
  if false == Panel_Widget_PersonalField_Mini:GetShow() then
    self._naviPos = nil
    self._index = nil
    self._checkType = -1
    self._isSetAreaInfo = false
    self._isShowRemainEffect = false
    self._isNonEnterServer = false
    Panel_Widget_PersonalField_Mini:EraseAllEffect()
  end
  self._ui._txt_time:SetShow(true)
  local isEnterPersonalRelayField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
  if isEnterPersonalRelayField == true then
    self:setExitRelayFieldButton()
  elseif self:updateData() == false then
    self:prepareClose()
    return
  end
  self:open()
end
function PaGlobal_Widget_PersonalField_All:open()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  Panel_Widget_PersonalField_Mini:SetShow(true)
end
function PaGlobal_Widget_PersonalField_All:prepareClose()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  self._naviPos = nil
  self._index = nil
  self._checkType = -1
  self._serverState = __ePersonalFieldServerState_NoEntry
  self._isSetAreaInfo = false
  self._isShowRemainEffect = false
  self._isFull = false
  if true == Panel_Widget_PersonalField_Mini:GetShow() then
    TooltipSimple_Hide()
  end
  Panel_Widget_PersonalField_Mini:EraseAllEffect()
  self:close()
end
function PaGlobal_Widget_PersonalField_All:close()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  Panel_Widget_PersonalField_Mini:SetShow(false)
end
function PaGlobal_Widget_PersonalField_All:setExitRelayFieldButton()
  if Panel_Widget_PersonalField_Mini == nil then
    return
  end
  local isEnterPersonalRelayField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
  if isEnterPersonalRelayField == false then
    return
  end
  self._ui._stc_green:SetShow(false)
  self._ui._stc_yellow:SetShow(false)
  self._ui._stc_red:SetShow(false)
  self._ui._btn_navi:SetShow(false)
  self._ui._btn_enter:SetShow(false)
  self._ui._txt_enter:SetShow(false)
  self._ui._stc_alertIcon:SetShow(false)
  self._ui._txt_time:SetShow(false)
  self._ui._stc_enterCondition:SetShow(false)
  self._ui._txt_name:SetText(ToClient_GetCurrentPersonalRelayFieldName())
  self._ui._btn_exit:SetShow(true)
end
function PaGlobal_Widget_PersonalField_All:updateData()
  if nil == Panel_Widget_PersonalField_Mini then
    return false
  end
  if false == _ContentsGroup_PersonalField then
    return false
  end
  local isNotShow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eIsShowPersonalFieldWidget)
  if true == isNotShow then
    return false
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return false
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return false
  end
  local isEnterMirrorField = ToClient_IsEnterMirrorField()
  local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
  if true == isEnterMirrorField and false == isEnterPersonalField then
    return false
  end
  self._ui._btn_navi:SetShow(false)
  self._ui._btn_enter:SetShow(false)
  self._ui._btn_exit:SetShow(false)
  self._ui._txt_enter:SetShow(false)
  self._ui._stc_enterCondition:SetShow(false)
  self._ui._stc_alertIcon:SetShow(false)
  local selfPlayerPosition = selfPlayer:getPosition()
  local instanceSpawnWrapper
  if true == self._isSetAreaInfo and nil ~= self._index then
    if true == isEnterPersonalField then
      if false == self._isConsole then
        self._ui._btn_exit:SetShow(true)
      end
      self:updateRemainTime()
      return true
    end
    instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByIndex(self._index)
    if nil == instanceSpawnWrapper then
      return false
    end
    self:setShowItemList(false)
  else
    local curChannelData = getCurrentChannelServerData()
    if nil == curChannelData then
      return false
    end
    if true == curChannelData._isInstanceChannel then
      return false
    end
    local regionInfo = getRegionInfoByPosition(selfPlayerPosition)
    if nil == regionInfo or nil == regionInfo:get() then
      return false
    end
    if true == regionInfo:get():isSafeZone() then
      return false
    end
    if true == curChannelData:isPVPServer() or true == curChannelData._isSiegeChannel then
      self._isNonEnterServer = true
    end
    instanceSpawnWrapper = ToClient_getInstanceSpawnInfoWrapperByPosition(selfPlayerPosition)
    if nil ~= instanceSpawnWrapper then
      local index = instanceSpawnWrapper:getIndex()
      if -1 == index then
        return false
      end
      self._naviPos = instanceSpawnWrapper:getCenterPos()
      self._index = index
      local areaName = instanceSpawnWrapper:getAreaName()
      if nil ~= areaName then
        self._ui._txt_name:SetText(areaName)
      end
    else
      if false == isEnterPersonalField then
        return false
      end
      self._ui._txt_name:SetText("")
      if false == self._isConsole then
        self._ui._btn_exit:SetShow(true)
      end
    end
    self:setShowItemList(false)
  end
  if nil ~= instanceSpawnWrapper then
    local radius = instanceSpawnWrapper:getRadius()
    local distance = instanceSpawnWrapper:getDistance(selfPlayerPosition)
    if radius < distance then
      return false
    end
    if false == self._isNonEnterServer then
      local checkType = -1
      if true == isEnterPersonalField then
        if false == self._isConsole then
          self._ui._btn_exit:SetShow(true)
        end
        checkType = 0
      else
        local checkInsidePersonalField = distance < radius * 0.8
        if true == checkInsidePersonalField then
          if true == self._isConsole then
            self._ui._txt_enter:SetShow(true)
            self._ui._txt_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_WIDGET_ENTER"))
          else
            self._ui._btn_enter:SetShow(true)
          end
          checkType = 1
        else
          if false == self._isConsole then
            self._ui._btn_navi:SetShow(true)
          end
          checkType = 2
        end
        local enterItemSSW = getItemEnchantStaticStatus(instanceSpawnWrapper:getEnterItemKey())
        if enterItemSSW ~= nil then
          self._ui._txt_time:SetShow(false)
          local enterItemText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PANEL_PERSONALFIELD_ENTER", "itemname", enterItemSSW:getName())
          self._ui._stc_enterCondition:SetText(enterItemText)
          self._ui._stc_enterCondition:SetShow(true)
          UI.setLimitTextAndAddTooltip(self._ui._stc_enterCondition, enterItemText, "")
        end
      end
      if self._checkType ~= checkType then
        if nil ~= Panel_Window_PersonalField_Main and true == Panel_Window_PersonalField_Main:GetShow() and nil ~= PaGlobalFunc_PersonalField_Main_All_Update then
          PaGlobalFunc_PersonalField_Main_All_Update()
        end
        self._checkType = checkType
      end
    end
    self._isSetAreaInfo = true
  end
  self:updateRemainTime()
  self:updateServerState()
  return true
end
function PaGlobal_Widget_PersonalField_All:updateRemainTime()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  if true == self._isNonEnterServer then
    self._ui._txt_time:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALFIELD_ALERT_DESC_MINI"))
    return
  end
  if nil == PaGlobal_Widget_PersonalField_All_SetRemainTimeText then
    return
  end
  PaGlobal_Widget_PersonalField_All_SetRemainTimeText(self._ui._txt_time)
  if false == ToClient_IsEnterMirrorField() then
    Panel_Widget_PersonalField_Mini:EraseAllEffect()
    self._isShowRemainEffect = false
    return
  end
  if true == self._isShowRemainEffect then
    return
  end
  Panel_Widget_PersonalField_Mini:EraseAllEffect()
  local seconds = ToClient_GetPersonalFieldLeftTime()
  if nil == seconds or seconds < 0 then
    return
  end
  local clockHours = math.max(math.floor(seconds / 3600), 0)
  if clockHours > 0 then
    return
  end
  local checkRemainMinute = 1
  local clockMinutes = math.max(math.floor(seconds % 3600 / 60), 0)
  if checkRemainMinute <= clockMinutes then
    return
  end
  Panel_Widget_PersonalField_Mini:AddEffect("fUI_InGame_Light_03A", true, 0, 0)
  audioPostEvent_SystemUi(25, 3)
  _AudioPostEvent_SystemUiForXBOX(25, 3)
  self._isShowRemainEffect = true
end
function PaGlobal_Widget_PersonalField_All:updateServerState()
  if nil == Panel_Widget_PersonalField_Mini then
    return
  end
  self._ui._stc_alertIcon:SetShow(true)
  self._ui._stc_stateIcon:SetShow(false)
  self._ui._stc_green:SetShow(false)
  self._ui._stc_yellow:SetShow(false)
  self._ui._stc_red:SetShow(false)
  self._ui._txt_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALFIELD_SERVERSTATUS_LOCKED"))
  self._ui._btn_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PERSONALFIELD_SERVERSTATUS_LOCKED"))
  self._ui._btn_enter:SetIgnore(true)
  self._serverState = __ePersonalFieldServerState_NoEntry
  if true == self._isNonEnterServer then
    return
  end
  local curChannelData = getCurrentChannelServerData()
  if nil == curChannelData then
    return
  end
  if true == curChannelData._isSiegeChannel or true == curChannelData:isPVPServer() or true == curChannelData._isInstanceChannel then
    self._ui._btn_exit:SetShow(false)
    self._ui._txt_enter:SetShow(false)
    return
  end
  self._serverState = ToClient_GetPersonalFieldServerState(curChannelData._serverNo)
  if __ePersonalFieldServerState_NoEntry == self._serverState then
    return
  end
  self._ui._stc_stateIcon:SetShow(true)
  self._ui._stc_alertIcon:SetShow(false)
  if __ePersonalFieldServerState_Free == self._serverState then
    self._ui._stc_green:SetShow(true)
  elseif __ePersonalFieldServerState_Busy == self._serverState then
    self._ui._stc_yellow:SetShow(true)
  else
    self._ui._stc_red:SetShow(true)
  end
  self._ui._txt_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_WIDGET_ENTER"))
  self._ui._btn_enter:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PERSONALFIELD_ENTER"))
  self._ui._btn_enter:SetIgnore(false)
end
function PaGlobal_Widget_PersonalField_All:setShowItemList(show)
  if _ContentsGroup_LootingItemRecord == false then
    return
  end
  self._ui._stc_itemListBg:SetShow(show)
end
function PaGlobal_Widget_PersonalField_All:updateItemList()
  if Panel_Widget_PersonalField_Mini == nil then
    return
  end
  if _ContentsGroup_LootingItemRecord == false then
    return
  end
  local isEnterPersonalField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalField)
  local isEnterPersonalRelyaField = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_PersonalRelayField)
  if false == isEnterPersonalField and false == isEnterPersonalRelyaField then
    self._ui._stc_itemListBg:SetShow(false)
    return
  end
  local recordInfo = ToClient_GetCurrentLootingRecord()
  if recordInfo == nil then
    self._ui._stc_itemListBg:SetShow(false)
    return
  end
  local listCount = recordInfo:getItemListCount()
  for ii = 0, self._slotCount - 1 do
    if self._ui._stc_itemList[ii] ~= nil then
      if ii < listCount then
        local itemKey = recordInfo:getItemKey(ii)
        self._ui._stc_itemList[ii].icon:SetShow(true)
        local itemStatic = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
        if itemStatic ~= nil then
          self._ui._stc_itemList[ii]:setItemByStaticStatus(itemStatic, recordInfo:getItemCount(ii))
        end
      else
        self._ui._stc_itemList[ii].icon:SetShow(false)
      end
    end
  end
  self._ui._stc_itemListBg:SetShow(true)
end
