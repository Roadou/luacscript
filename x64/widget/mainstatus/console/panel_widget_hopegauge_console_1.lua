function PaGlobal_HopeGauge_Console:initialize()
  if PaGlobal_HopeGauge_Console._initialize == true then
    return
  end
  self._ui._stc_MainBG = UI.getChildControl(Panel_Widget_HopeGauge_Console, "Static_MainBG")
  self._ui._btn[0] = UI.getChildControl(self._ui._stc_MainBG, "Button_0")
  self._ui._btn[1] = UI.getChildControl(self._ui._stc_MainBG, "Button_1")
  self._ui._btn[2] = UI.getChildControl(self._ui._stc_MainBG, "Button_2")
  self._ui._icon_Center = UI.getChildControl(self._ui._stc_MainBG, "Static_CenterIcon")
  self._ui._icon_grade[0] = UI.getChildControl(self._ui._icon_Center, "Static_Grade0")
  self._ui._icon_grade[1] = UI.getChildControl(self._ui._icon_Center, "Static_Grade1")
  self._ui._icon_grade[2] = UI.getChildControl(self._ui._icon_Center, "Static_Grade2")
  self._ui._stc_State = UI.getChildControl(self._ui._stc_MainBG, "StaticText_State")
  self._ui._txt_RemainTime = UI.getChildControl(self._ui._stc_MainBG, "StaticText_Time")
  self._ui._keyGuide_Area = UI.getChildControl(Panel_Widget_HopeGauge_Console, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._keyGuide_Y = UI.getChildControl(self._ui._keyGuide_Area, "StaticText_Y_ConsoleUI")
  self._ui._keyGuide_B = UI.getChildControl(self._ui._keyGuide_Area, "StaticText_B_ConsoleUI")
  self._ui._keyGuide_A = UI.getChildControl(self._ui._keyGuide_Area, "StaticText_A_ConsoleUI")
  self._ui._keyGuide_X = UI.getChildControl(self._ui._keyGuide_Area, "StaticText_X_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  local itemBg = UI.getChildControl(Panel_Widget_HopeGauge_Console, "Static_ItemBG")
  self._ui._icon_Bg = UI.getChildControl(itemBg, "Static_IconBg")
  self._ui._txt_itemName = UI.getChildControl(Panel_Widget_HopeGauge_Console, "StaticText_ItemName")
  for i = 0, self._config._feedStaticItemCount - 1 do
    local info = {}
    info._button = UI.createControl(__ePAUIControl_Static, itemBg, "Static_IconBg_" .. i)
    CopyBaseProperty(self._ui._icon_Bg, info._button)
    local itemSlot = {}
    SlotItem.new(itemSlot, "Item_Slot_" .. i, i, info._button, self._config._slotConfig)
    itemSlot:createChild()
    local slotConfig = self._config
    info._button:SetPosX(slotConfig._startX + slotConfig._gapX * (i % slotConfig._col))
    itemSlot.icon:SetIgnore(true)
    info._slot = itemSlot
    info._button:addInputEvent("Mouse_LUp", "HandleClicked_HopeGuage_Console_SelectFeedItem(" .. i .. ")")
    info._button:addInputEvent("Mouse_On", "PaGlobal_HopeGauge_Console:updateItemName(" .. i .. ")")
    self._ui._stc_ItemSlots[i] = info
  end
  self._ui._icon_Bg:SetShow(false)
  local keyGuides = {
    self._ui._keyGuide_A,
    self._ui._keyGuide_Y,
    self._ui._keyGuide_B,
    self._ui._keyGuide_X
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._keyGuide_Area, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  PaGlobal_HopeGauge_Console:registEventHandler()
  PaGlobal_HopeGauge_Console:validate()
  PaGlobal_HopeGauge_Console._initialize = true
end
function PaGlobal_HopeGauge_Console:registEventHandler()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  registerEvent("FromClient_updateItemCollectionTimer", "FromClient_HopeGaugeConsole_UpdateTimer")
  registerEvent("FromClient_updateItemCollectionPoint", "FromClient_HopeGaugeConsole_Update")
  registerEvent("FromClient_updateItemCollectionGrade", "FromClient_HopeGaugeConsole_Update")
  registerEvent("FromClient_InventoryUpdate", "FromClient_HopeGaugeConsole_InventoryUpdate")
  Panel_Widget_HopeGauge_Console:registerPadEvent(__eConsoleUIPadEvent_LT, "PaGlobal_HopeGauge_Console:moveGradeButton(true)")
  Panel_Widget_HopeGauge_Console:registerPadEvent(__eConsoleUIPadEvent_RT, "PaGlobal_HopeGauge_Console:moveGradeButton(false)")
  Panel_Widget_HopeGauge_Console:registerPadEvent(__eConsoleUIPadEvent_Y, "PaGlobal_HopeGauge_Console:confrim()")
end
function PaGlobal_HopeGauge_Console:prepareOpen()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  self._selectedCount = 0
  self._selectItemIndex = 0
  self._selectedPoint = 0
  self:update()
  self:updateButtons()
  self:updateFeedItem()
  PaGlobal_HopeGauge_Console:open()
end
function PaGlobal_HopeGauge_Console:open()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  Panel_Widget_HopeGauge_Console:SetShow(true)
end
function PaGlobal_HopeGauge_Console:prepareClose()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_HopeGauge_Console:close()
end
function PaGlobal_HopeGauge_Console:close()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  Panel_Widget_HopeGauge_Console:SetShow(false)
end
function PaGlobal_HopeGauge_Console:update()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local point = Int64toInt32(selfPlayer:get():getItemCollectionScrollPoint())
  local grade = selfPlayer:get():getItemCollectionScrollGrade()
  local alertPoint = ToClient_getHopeGaugeAlert()
  local state = "LUA_HOPE_USE_" .. tostring(grade)
  self._selectedGrade = grade
  self._ui._stc_State:SetText(PAGetString(Defines.StringSheet_GAME, state))
  self._ui._txt_RemainTime:SetText(Util.Time.timeFormatting(point))
end
function PaGlobal_HopeGauge_Console:updateButtons()
  for k, v in pairs(self._ui._btn) do
    v:setRenderTexture(v:getBaseTexture())
  end
  for k, v in pairs(self._ui._icon_grade) do
    v:SetShow(false)
  end
  self._ui._btn[self._selectedGrade]:setRenderTexture(self._ui._btn[self._selectedGrade]:getClickTexture())
  self._ui._icon_grade[self._selectedGrade]:SetShow(true)
end
function PaGlobal_HopeGauge_Console:validate()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
end
function PaGlobal_HopeGauge_Console:moveGradeButton(isLeft)
  if isLeft == true then
    if self._selectedGrade == 0 then
      return
    end
    self._selectedGrade = self._selectedGrade - 1
  else
    if self._selectedGrade == 2 then
      return
    end
    self._selectedGrade = self._selectedGrade + 1
  end
  self:updateButtons()
end
function PaGlobal_HopeGauge_Console:confrim()
  if nil == Panel_Widget_HopeGauge_Console then
    return
  end
  if false == Panel_Widget_HopeGauge_Console:GetShow() then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local coolTime = ToClient_getItemCollectionScrollCoolTime()
  if 0 ~= coolTime then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_SymbolNo, "eErrNoHopeGaugeCoolTime", "cooltime", Util.Time.timeFormatting(coolTime)))
    return
  end
  local point = Int64toInt32(selfPlayer:get():getItemCollectionScrollPoint())
  if point <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEnoughItemCollectionPoint"))
    return
  end
  local point = Int64toInt32(selfPlayer:get():getItemCollectionScrollPoint())
  if point <= 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotEnoughItemCollectionPoint"))
    return
  end
  local idx = self._selectedGrade
  local function buffOn()
    ToClient_ApplyItemCollectionScroll(self._selectedGrade, false)
  end
  local contentString = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE")
  if 0 == idx then
    contentString = PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_OFF_INFO")
  elseif 1 == idx then
    contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOPE_GRADE_ON_MSG", "grade", idx, "drop", ToClient_GetHopeDropByGrade(idx), "count", ToClient_GetHopeCountByGrade(idx))
  elseif 2 == idx then
    contentString = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_HOPE_GRADE_ON_MSG", "grade", idx, "drop", ToClient_GetHopeDropByGrade(idx), "count", ToClient_GetHopeCountByGrade(idx))
  end
  contentString = contentString .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_HOPE_USE_DESC")
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_HOPEGAUGE_TOOLTIP_TITLE"),
    content = contentString,
    functionYes = buffOn,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if -1 ~= PaGlobal_HopeGaugeOnOff._selectItemIndex then
    MessageBox.showMessageBox(messageboxData)
  end
end
function PaGlobal_HopeGauge_Console:updateTimerOnly()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local point = Int64toInt32(selfPlayer:get():getItemCollectionScrollPoint())
  self._ui._txt_RemainTime:SetText(Util.Time.timeFormatting(point))
end
function PaGlobal_HopeGauge_Console:updateFeedItem()
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local userFeedItemCount = ToClient_getItemCollectionScrollCount()
  for i = 0, self._config._feedStaticItemCount - 1 do
    local targetSlot = self._ui._stc_ItemSlots[i]
    if i < userFeedItemCount then
      local feedItem = ToClient_getItemCollectionScrollByIndex(i)
      if nil == feedItem then
        return
      end
      if nil == targetSlot then
        return
      end
      targetSlot._slot:clearItem()
      targetSlot._slot:setItem(feedItem)
      targetSlot._slot.icon:SetShow(true)
      targetSlot._button:SetShow(true)
      targetSlot._button:SetIgnore(false)
      targetSlot._button:SetEnable(true)
      local itemSSW = feedItem:getStaticStatus()
      if itemSSW ~= nil then
        local itemKeyRaw = itemSSW:get()._key:get()
        if self._isConsole == true then
          targetSlot._button:registerPadEvent(__eConsoleUIPadEvent_X, "PaGlobalFunc_HopeGauge_Console_ShowItemTooptip_Toggle(" .. i .. "," .. itemKeyRaw .. ")")
          targetSlot._button:addInputEvent("Mouse_Out", "PaGlobalFunc_HopeGauge_Console_ShowItemTooptip(" .. i .. "," .. itemKeyRaw .. ", false)")
        else
          targetSlot._button:addInputEvent("Mouse_Out", "PaGlobalFunc_HopeGauge_Console_ShowItemTooptip(" .. i .. "," .. itemKeyRaw .. ", false)")
          targetSlot._button:addInputEvent("Mouse_On", "PaGlobalFunc_HopeGauge_Console_ShowItemTooptip(" .. i .. "," .. itemKeyRaw .. ", true)")
        end
      end
    elseif nil ~= targetSlot then
      targetSlot._slot:clearItem()
      if self._isConsole == true then
        targetSlot._button:registerPadEvent(__eConsoleUIPadEvent_X, "")
      else
        targetSlot._button:removeInputEvent("Mouse_On")
        targetSlot._button:removeInputEvent("Mouse_Out")
      end
    end
  end
end
function PaGlobal_HopeGauge_Console:selectFeedItem(idx)
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local feedItem = ToClient_getItemCollectionScrollByIndex(idx)
  if nil == feedItem then
    return
  end
  if feedItem:isSet() == false then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local player = selfPlayer:get()
  local itemStatic = feedItem:getStaticStatus()
  if itemStatic == nil then
    return
  end
  self._selectedPoint = itemStatic:getContentsEventParam1()
  local itemCount = Int64toInt32(feedItem:getCount())
  local point = Int64toInt32(player:getItemCollectionScrollPoint())
  local limitPoint = ToClient_ItemCollectionPointLimit()
  local enableTime = limitPoint - point
  local enableCount = enableTime / self._selectedPoint
  if itemCount < enableCount then
    enableCount = itemCount
  end
  if enableCount < 1 then
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_SymbolNo, "eErrNoHopeGaugePointisFull", "max", Util.Time.timeFormatting(ToClient_ItemCollectionPointLimit())))
    return
  end
  local finalCount = toInt64(0, enableCount)
  self._selectedCount = 0
  self._selectItemIndex = idx
  Panel_Tooltip_Item_hideTooltip()
  Panel_NumberPad_Show(true, finalCount, nil, PaGlobalFunc_HopeGauge_Console_ChargeScroll)
end
function PaGlobal_HopeGauge_Console:updateItemName(slotIdx)
  if Panel_Widget_HopeGauge_Console == nil then
    return
  end
  local feedItem = ToClient_getItemCollectionScrollByIndex(slotIdx)
  if feedItem == nil then
    self._ui._txt_itemName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  if feedItem:isSet() == false then
    self._ui._txt_itemName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  local itemStatic = feedItem:getStaticStatus()
  if itemStatic == nil then
    self._ui._txt_itemName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NO_ITEMSCROLL"))
    return
  end
  self._ui._txt_itemName:SetText(itemStatic:getName())
end
