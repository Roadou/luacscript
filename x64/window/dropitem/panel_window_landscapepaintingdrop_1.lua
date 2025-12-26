function PaGlobal_LandscapePainting:initialize()
  if PaGlobal_LandscapePainting._initialize == true then
    return
  end
  self._ui.list2_landscapePaintingList = UI.getChildControl(Panel_Window_LandscapePaintingDrop, "List2_PaintingList")
  self._ui.btn_Close = UI.getChildControl(Panel_Window_LandscapePaintingDrop, "Button_Close")
  self._ui.itemSubPanel = UI.getChildControl(Panel_Window_LandscapePaintingDrop, "Static_SelectItem")
  local temp = UI.getChildControl(self._ui.itemSubPanel, "Static_SubframeTitle")
  self._ui.btn_subPanelClose = UI.getChildControl(temp, "Button_SubFrame_Close")
  self._ui.stc_itemSubPanel_constolBtnGroup = UI.getChildControl(self._ui.itemSubPanel, "Static_BG_ConsoleUI")
  self._ui.stc_itemSubPanel_constolBtn_A = UI.getChildControl(self._ui.stc_itemSubPanel_constolBtnGroup, "StaticText_Feed_ConsoleUI")
  self._ui.stc_itemSubPanel_constolBtn_B = UI.getChildControl(self._ui.stc_itemSubPanel_constolBtnGroup, "StaticText_Cancel_ConsoleUI")
  self._ui.stc_itemSubPanel_constolBtn_X = UI.getChildControl(self._ui.stc_itemSubPanel_constolBtnGroup, "StaticText_Detail_ConsoleUI")
  self._ui.stc_itemTemplate = UI.getChildControl(self._ui.itemSubPanel, "Static_IconBg")
  self._ui.stc_itemTemplate:SetShow(false)
  self._ui.stc_toolTipDesc = UI.getChildControl(Panel_Window_LandscapePaintingDrop, "Static_1")
  self._ui.stc_consoleBtnGroup = UI.getChildControl(Panel_Window_LandscapePaintingDrop, "Static_BottomGroup_ConsoleUI")
  self._ui.stc_console_A = UI.getChildControl(self._ui.stc_consoleBtnGroup, "StaticText_A_ConsoleUI")
  self._ui.stc_console_B = UI.getChildControl(self._ui.stc_consoleBtnGroup, "StaticText_B_ConsoleUI")
  self._ui.stc_console_Y = UI.getChildControl(self._ui.stc_consoleBtnGroup, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  for index = 0, __eLandscapePaintingType_Count - 1 do
    local string = ToClient_landscapePaintingDropString(index)
    self._landscapePaintingDropData[index].string = string
  end
  self:createControlChargeItemSlot()
  PaGlobal_LandscapePainting:registEventHandler()
  PaGlobal_LandscapePainting:validate()
  self._itemSubPanelPosX = self._ui.itemSubPanel:GetPosX()
  self._itemSubPanelPosY = self._ui.itemSubPanel:GetPosY()
  self:updateLandscapePaintingDropData()
  PaGlobal_LandscapePainting._initialize = true
  if self._isConsole == true then
    self._ui.stc_consoleBtnGroup:SetShow(true)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_console_A,
      self._ui.stc_console_Y,
      self._ui.stc_console_B
    }, self._ui.stc_consoleBtnGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    self._ui.stc_itemSubPanel_constolBtnGroup:SetShow(true)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui.stc_itemSubPanel_constolBtn_B,
      self._ui.stc_itemSubPanel_constolBtn_X,
      self._ui.stc_itemSubPanel_constolBtn_A
    }, self._ui.stc_itemSubPanel_constolBtnGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui.btn_Close:SetShow(false)
    self._ui.btn_subPanelClose:SetShow(false)
  end
end
function PaGlobal_LandscapePainting:registEventHandler()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  self._ui.list2_landscapePaintingList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_LandscapePainting_addListContent")
  self._ui.list2_landscapePaintingList:registEvent(__ePAUIList2EventType_Scrolling, "PaGlobal_LandscapePainting_itemSubPanelClose")
  self._ui.list2_landscapePaintingList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_LandscapePainting_Close()")
  self._ui.btn_subPanelClose:addInputEvent("Mouse_LUp", "PaGlobal_LandscapePainting_itemSubPanelClose()")
  self._ui.stc_toolTipDesc:addInputEvent("Mouse_On", "PaGlobal_LandscapePainting:descriptionToolTip(true)")
  self._ui.stc_toolTipDesc:addInputEvent("Mouse_Out", "PaGlobal_LandscapePainting:descriptionToolTip(false)")
  registerEvent("FromClient_LandscapePaintingDropUpdateSwitch", "PaGlobal_LandscapePainting_UpdateSwitch")
  registerEvent("FromClient_LandscapePaintingDropUpdatePoint", "PaGlobal_LandscapePainting_UpdatePoint")
end
function PaGlobal_LandscapePainting:validate()
  self._ui.list2_landscapePaintingList:isValidate()
  self._ui.stc_consoleBtnGroup:isValidate()
  self._ui.stc_console_A:isValidate()
  self._ui.stc_console_B:isValidate()
  self._ui.stc_console_Y:isValidate()
end
function PaGlobal_LandscapePainting:prepareOpen()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  self._ui.itemSubPanel:SetShow(false)
  self:update()
  self:open()
end
function PaGlobal_LandscapePainting:open()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  Panel_Window_LandscapePaintingDrop:SetShow(true)
end
function PaGlobal_LandscapePainting:prepareClose()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  if self._ui.itemSubPanel:GetShow() then
    self:itemSubPanelClose()
    return
  end
  self:close()
end
function PaGlobal_LandscapePainting:close()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  Panel_Window_LandscapePaintingDrop:SetShow(false)
end
function PaGlobal_LandscapePainting:createControlChargeItemSlot()
  for i = 0, self._config.chargeItemCount - 1 do
    local info = {}
    info._button = UI.createControl(__ePAUIControl_Static, self._ui.itemSubPanel, "feedButton_" .. i)
    CopyBaseProperty(self._ui.stc_itemTemplate, info._button)
    local itemSlot = {}
    SlotItem.new(itemSlot, "Item_Slot_" .. i, i, info._button, self._config._slotConfig)
    itemSlot:createChild()
    local slotConfig = self._config
    info._button:SetPosX(slotConfig._startX + slotConfig._gapX * (i % slotConfig._col))
    info._button:addInputEvent("Mouse_LUp", "HandleClicked_SelectFeedItem(" .. i .. ")")
    itemSlot.icon:SetIgnore(true)
    info._slot = itemSlot
    self._ui.stc_ItemSlots[i] = info
    self._ui.stc_ItemSlots[i]._button:SetShow(true)
  end
end
function PaGlobal_LandscapePainting:update()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  self:updateLandscapePaintingDropData()
  self:updateLandscapePaintingDropContentsLit()
end
function PaGlobal_LandscapePainting:updateLandscapePaintingDropData()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  for index = 0, __eLandscapePaintingType_Count - 1 do
    self._landscapePaintingDropData[index].currentPoint = ToClient_getCurrentPointLandScapePainting(index)
    self._landscapePaintingDropData[index].switch = ToClient_getCurrentSwitchLandScapePainting(index)
  end
end
function PaGlobal_LandscapePainting:updateLandscapePaintingDropContentsLit()
  if Panel_Window_LandscapePaintingDrop == nil then
    return
  end
  local toIndex = self._ui.list2_landscapePaintingList:getCurrenttoIndex()
  local scrollPos = self._ui.list2_landscapePaintingList:GetVScroll():GetControlPos()
  self._ui.list2_landscapePaintingList:getElementManager():clearKey()
  local keyCount = math.floor((__eLandscapePaintingType_Count - 1) / self._columCount)
  for key = 0, keyCount do
    self._ui.list2_landscapePaintingList:getElementManager():pushKey(key)
  end
  self._ui.list2_landscapePaintingList:setCurrenttoIndex(toIndex)
  self._ui.list2_landscapePaintingList:GetVScroll():SetControlPos(scrollPos)
end
function PaGlobal_LandscapePainting:prepareItemSlot(landScpaePaintingType, row, col)
  if landScpaePaintingType >= __eLandscapePaintingType_Count or landScpaePaintingType < 0 then
    return
  end
  local rowIndex = row - math.floor(self._ui.list2_landscapePaintingList:getCurrenttoIndex())
  self._ui.itemSubPanel:SetPosY(self._itemSubPanelPosY + rowIndex * self._itemPosGapY)
  self._ui.itemSubPanel:SetPosX(self._itemSubPanelPosX + col * self._itemPosGapX)
  local chargeItemCount = ToClient_getItemLandScapePaintingChargeCount(landScpaePaintingType)
  if chargeItemCount == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemNeedNotExist"))
    self:itemSubPanelClose()
    return
  end
  self:updateItemSlots(landScpaePaintingType)
  self._selectItemIndex = -1
  self._selectPaintingType = -1
  self._selectPaintingChargePoint = 0
  self._selectItemCount = 0
  self._ui.itemSubPanel:SetShow(true)
end
function PaGlobal_LandscapePainting:updateItemSlots(landScpaePaintingType)
  local chargeItemCount = ToClient_getItemLandScapePaintingChargeCount(landScpaePaintingType)
  for i = 0, self._config.chargeItemCount - 1 do
    local targetSlot = self._ui.stc_ItemSlots[i]
    if targetSlot ~= nil then
      targetSlot._button:removeInputEvent("Mouse_LUp")
    end
    if i < chargeItemCount then
      local chargeItem = ToClient_getItemLandScapePaintingChargeByIndex(landScpaePaintingType, i)
      if nil ~= chargeItem and targetSlot ~= nil then
        targetSlot._slot:clearItem()
        targetSlot._slot:setItem(chargeItem)
        targetSlot._slot.icon:SetShow(true)
        targetSlot._button:SetShow(true)
        targetSlot._button:SetIgnore(false)
        targetSlot._button:SetEnable(true)
        targetSlot._button:addInputEvent("Mouse_LUp", "PaGlobal_LandscapePainting_addLandscapePaintingPoint(" .. landScpaePaintingType .. "," .. i .. ")")
        if self._isConsole == false then
          targetSlot._button:addInputEvent("Mouse_On", "PaGlobal_LandscapePainting:chargeItemToolTip(" .. i .. "," .. chargeItem:getStaticStatus():getItemKey() .. ",true)")
          targetSlot._button:addInputEvent("Mouse_Out", "PaGlobal_LandscapePainting:chargeItemToolTip(" .. i .. "," .. chargeItem:getStaticStatus():getItemKey() .. ",false)")
        else
          targetSlot._button:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_LandscapePainting:chargeItemToolTipconsole(" .. i .. "," .. chargeItem:getStaticStatus():getItemKey() .. ",true)")
        end
      end
    elseif nil ~= targetSlot then
      targetSlot._button:SetShow(false)
      targetSlot._slot:clearItem()
    end
  end
end
function PaGlobal_LandscapePainting:selectChargeItem(landScpaePaintingType, idx)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local chargeItem = ToClient_getItemLandScapePaintingChargeByIndex(landScpaePaintingType, idx)
  if nil == chargeItem then
    return
  end
  local itemStatic = chargeItem:getStaticStatus()
  local chargePoint = 0
  if nil ~= itemStatic then
    chargePoint = itemStatic:getContentsEventParam2()
  end
  if chargePoint == 0 then
    return
  end
  local itemCount = Int64toInt32(chargeItem:getCount())
  local currentLandscapePoint = ToClient_getCurrentPointLandScapePainting(landScpaePaintingType)
  local limitPoint = ToClient_getLimitPointLandScapePainting()
  local enableCount = (limitPoint - currentLandscapePoint) / chargePoint
  if itemCount < enableCount then
    enableCount = itemCount
  end
  self._selectItemIndex = idx
  self._selectPaintingType = landScpaePaintingType
  self._selectPaintingChargePoint = chargePoint
  local finalCount = toInt64(0, enableCount)
  Panel_NumberPad_Show(true, finalCount, nil, PaGlobal_LandscapePainting_chargeLandscapePaintingPoint)
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_LandscapePainting:chargeLandscapePaintingPoint(inputNumber)
  self._selectItemCount = Int64toInt32(inputNumber)
  ToClient_chargeItemLandscapePaintingFromUI(self._selectPaintingType, self._selectItemIndex, self._selectItemCount)
end
function PaGlobal_LandscapePainting_addListContent(control, InputKey)
  if nil == Panel_Window_LandscapePaintingDrop then
    return
  end
  if nil == control or nil == InputKey then
    return
  end
  local self = PaGlobal_LandscapePainting
  if self == nil then
    return
  end
  local key = Int64toInt32(InputKey)
  local listControlGroup = {}
  for ii = 0, self._columCount - 1 do
    local buttonControl = UI.getChildControl(control, "CheckButton_Bg_" .. ii)
    local textBg = UI.getChildControl(buttonControl, "Static_TextBG")
    local listControl = {
      button = buttonControl,
      textBg = textBg,
      checkBox = UI.getChildControl(buttonControl, "CheckButton_SelectPaintBG"),
      txt_Name = UI.getChildControl(textBg, "StaticText_Name"),
      stc_paintBG = UI.getChildControl(buttonControl, "Static_PaintBG"),
      btn_SelectItem = UI.getChildControl(buttonControl, "Button_SelectItem"),
      progress_Point = UI.getChildControl(buttonControl, "Progress2_ItemGauge"),
      progress_PointBg = UI.getChildControl(buttonControl, "Static_ProgressBG"),
      pointValue = UI.getChildControl(buttonControl, "StaticText_Value")
    }
    listControlGroup[ii] = listControl
  end
  local paintingTypeStart = key * self._columCount
  local paintingTypeEnd = paintingTypeStart + self._columCount
  for ii = paintingTypeStart, paintingTypeEnd - 1 do
    local index = ii - paintingTypeStart
    if ii < __eLandscapePaintingType_Count then
      local landscapeType = self._indexForType[ii]
      listControlGroup[index].button:SetShow(true)
      listControlGroup[index].checkBox:SetIgnore(true)
      listControlGroup[index].checkBox:SetCheck(self._landscapePaintingDropData[landscapeType].switch)
      UI.setLimitTextAndAddTooltip(listControlGroup[index].txt_Name)
      listControlGroup[index].txt_Name:SetText(self._landscapePaintingDropData[landscapeType].string)
      if listControlGroup[index].txt_Name:IsLimitText() then
        listControlGroup[index].txt_Name:SetIgnore(false)
      else
        listControlGroup[index].txt_Name:SetIgnore(true)
      end
      listControlGroup[index].progress_Point:SetProgressRate(self._landscapePaintingDropData[landscapeType].currentPoint / self._pointMax * 100)
      if self._isConsole == true then
        listControlGroup[index].pointValue:SetShow(true)
        local name = "<PAColor0xFFF5BA3A>" .. makeDotMoney(self._landscapePaintingDropData[landscapeType].currentPoint) .. "<PAOldColor>/" .. makeDotMoney(self._pointMax)
        listControlGroup[index].pointValue:SetText(name)
      else
        listControlGroup[index].pointValue:SetShow(false)
      end
      if self._isConsole == true and listControlGroup[index].txt_Name:IsLimitText() == true then
        listControlGroup[index].stc_paintBG:addInputEvent("Mouse_On", "PaGlobal_LandscapePainting:simpleTooltipName( true, " .. landscapeType .. "," .. key .. "," .. index .. ")")
        listControlGroup[index].stc_paintBG:addInputEvent("Mouse_Out", "PaGlobal_LandscapePainting:simpleTooltipName( false, " .. landscapeType .. "," .. key .. "," .. index .. ")")
      end
      listControlGroup[index].stc_paintBG:ChangeTextureInfoTextureIDAsync(self._paintingTexture[landscapeType].on, 1)
      if self._landscapePaintingDropData[landscapeType].switch == true then
        listControlGroup[index].stc_paintBG:addInputEvent("Mouse_LUp", "ToClient_setCurrentSwitchLandScapePainting(" .. landscapeType .. ", false)")
        listControlGroup[index].button:ChangeTextureInfoTextureIDAsync("Combine_Etc_ElaServinLandscapes_ListBG_ON")
        listControlGroup[index].button:setRenderTexture(listControlGroup[index].button:getBaseTexture())
        listControlGroup[index].progress_Point:ChangeTextureInfoTextureIDAsync("Combine_Etc_ElaServinLandscapes_Gauge_ON")
        listControlGroup[index].progress_Point:setRenderTexture(listControlGroup[index].progress_Point:getBaseTexture())
        listControlGroup[index].textBg:ChangeTextureInfoTextureIDAsync("Combine_Etc_ElaServinLandscapes_NameBG_ON")
        listControlGroup[index].textBg:setRenderTexture(listControlGroup[index].textBg:getBaseTexture())
        listControlGroup[index].stc_paintBG:ChangeTextureInfoTextureIDAsync(self._paintingTexture[landscapeType].on)
        listControlGroup[index].stc_paintBG:setRenderTexture(listControlGroup[index].stc_paintBG:getBaseTexture())
      else
        listControlGroup[index].stc_paintBG:addInputEvent("Mouse_LUp", "ToClient_setCurrentSwitchLandScapePainting(" .. landscapeType .. ", true)")
        listControlGroup[index].button:ChangeTextureInfoTextureIDAsync("Combine_Etc_ElaServinLandscapes_ListBG_OFF")
        listControlGroup[index].button:setRenderTexture(listControlGroup[index].button:getBaseTexture())
        listControlGroup[index].progress_Point:ChangeTextureInfoTextureIDAsync("Combine_Etc_ElaServinLandscapes_Gauge_OFF")
        listControlGroup[index].progress_Point:setRenderTexture(listControlGroup[index].progress_Point:getBaseTexture())
        listControlGroup[index].textBg:ChangeTextureInfoTextureIDAsync("Combine_Etc_ElaServinLandscapes_NameBG_OFF")
        listControlGroup[index].textBg:setRenderTexture(listControlGroup[index].textBg:getBaseTexture())
        listControlGroup[index].stc_paintBG:ChangeTextureInfoTextureIDAsync(self._paintingTexture[landscapeType].off)
        listControlGroup[index].stc_paintBG:setRenderTexture(listControlGroup[index].stc_paintBG:getBaseTexture())
      end
      listControlGroup[index].stc_paintBG:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_LandscapePainting_showLandscapePaintingItem(" .. landscapeType .. "," .. key .. "," .. index .. ")")
      listControlGroup[index].btn_SelectItem:addInputEvent("Mouse_LUp", "PaGlobal_LandscapePainting_showLandscapePaintingItem(" .. landscapeType .. "," .. key .. "," .. index .. ")")
      if self._isConsole == false then
        listControlGroup[index].progress_PointBg:addInputEvent("Mouse_On", "PaGlobal_LandscapePainting:simpleTooltip( true, " .. landscapeType .. ")")
        listControlGroup[index].progress_PointBg:addInputEvent("Mouse_Out", "PaGlobal_LandscapePainting:simpleTooltip( false, " .. landscapeType .. ")")
      end
    else
      listControlGroup[index].button:SetShow(false)
    end
  end
end
function PaGlobal_LandscapePainting:simpleTooltipName(isShow, landscapeType, key, index)
  local name = self._landscapePaintingDropData[landscapeType].string
  local desc
  local content = self._ui.list2_landscapePaintingList:GetContentByKey(key)
  if content ~= nil then
    local buttonControl = UI.getChildControl(content, "CheckButton_Bg_" .. index)
    local textBg = UI.getChildControl(buttonControl, "Static_TextBG")
    local txt_Name = UI.getChildControl(textBg, "StaticText_Name")
    local pos = {
      x = txt_Name:GetParentPosX(),
      y = txt_Name:GetParentPosY() + txt_Name:GetSizeY()
    }
    if isShow == true then
      TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    end
  end
  if isShow == false then
    TooltipSimple_Hide()
  end
end
function PaGlobal_LandscapePainting:simpleTooltip(isShow, type)
  local name = "<PAColor0xFFF5BA3A>" .. makeDotMoney(self._landscapePaintingDropData[type].currentPoint) .. "<PAOldColor>/" .. makeDotMoney(self._pointMax)
  local desc
  if isShow == true then
    registTooltipControl(Panel_Window_LandscapePaintingDrop, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(Panel_Window_LandscapePaintingDrop, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_LandscapePainting:getToolTipString(includeKeyGuide)
  local returnString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXTRADROP_BOTTOM_DESC") .. "\n"
  self:updateLandscapePaintingDropData()
  for index = 0, __eLandscapePaintingType_Count - 1 do
    local fieldString = ToClient_landscapePaintingDropString(index)
    if self._landscapePaintingDropData[index].switch == true then
      returnString = returnString .. fieldString .. " : " .. makeDotMoney(self._landscapePaintingDropData[index].currentPoint) .. "\n"
    end
  end
  if includeKeyGuide == nil or includeKeyGuide ~= nil and includeKeyGuide == true then
    returnString = returnString .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EXTRADROP_BOTTOM_DESC2")
  end
  return returnString
end
function PaGlobal_LandscapePainting:itemSubPanelClose()
  self._selectItemIndex = -1
  self._selectPaintingType = -1
  self._selectPaintingChargePoint = 0
  self._selectItemCount = 0
  self._ui.itemSubPanel:SetShow(false)
  if self._isConsole == false then
    Panel_Tooltip_Item_hideTooltip()
  elseif PaGlobalFunc_TooltipInfo_Close ~= nil then
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_LandscapePainting:chargeItemToolTip(controlIndex, itemKey, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemWrapper then
    return
  end
  local control = self._ui.stc_ItemSlots[controlIndex]._slot.icon
  if control == nil then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_Show(itemWrapper, control, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_LandscapePainting:chargeItemToolTipconsole(controlIndex, itemKey, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
  if nil == itemWrapper then
    return
  end
  if true == isShow then
    if PaGlobalFunc_TooltipInfo_Open ~= nil then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    end
  elseif PaGlobalFunc_TooltipInfo_Close ~= nil then
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function PaGlobal_LandscapePainting:descriptionToolTip(isShow)
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_TOOLTIP_NAME")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPITEM_TOOLTIP_DESC")
    local uiControl = self._ui.stc_toolTipDesc
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
