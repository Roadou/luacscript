function PaGloabl_Alchemy_RateViewList_Open()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  PaGlobal_Alchemy_RateViewList:prepareOpen()
end
function PaGloabl_Alchemy_RateViewList_Close(isRecentCookClose)
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  if isRecentCookClose == true then
    if PaGlobal_Alchemy_All._isPanelRecentCookOpened == true and Panel_RecentCook ~= nil then
      Panel_RecentCook:SetShow(true)
    else
      Panel_RecentCook:SetShow(false)
    end
  end
  PaGlobal_Alchemy_RateViewList:prepareClose()
end
function PaGloabl_Alchemy_RateViewList_IsShow()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  return Panel_Alchemy_RateViewList:GetShow() == true
end
function PaGloabl_Alchemy_RateViewList_CalculateAlchemy()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  PaGlobal_Alchemy_RateViewList._lifeType = __eType_Life4
  PaGlobal_Alchemy_RateViewList:clearGroup()
  PaGlobalFunc_Alchemy_All_ShowRateViewButton(false)
  PaGloabl_Alchemy_RateViewList_Close(false)
  ToClient_calculateAlchemyPercent(false)
end
function PaGloabl_Alchemy_RateViewList_CalculateCook()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  PaGlobal_Alchemy_RateViewList._lifeType = __eType_Life3
  PaGlobal_Alchemy_RateViewList:clearGroup()
  PaGlobalFunc_Alchemy_All_ShowRateViewButton(false)
  PaGloabl_Alchemy_RateViewList_Close(false)
  ToClient_calculateAlchemyPercent(true)
end
function PaGloabl_Alchemy_RateViewList_CalculateManufacture(actionName, slotNo0, slotNo1, slotNo2, slotNo3, slotNo4)
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  PaGlobal_Alchemy_RateViewList._lifeType = __eType_Life5
  PaGlobal_Alchemy_RateViewList:clearGroup()
  PaGlobalFunc_Manufacture_All_ShowRateView(false)
  PaGloabl_Alchemy_RateViewList_Close(false)
  ToClient_calculateManufacturePercent(actionName, slotNo0, slotNo1, slotNo2, slotNo3, slotNo4)
end
function PaGloabl_Alchemy_RateViewList_ShowItemTooltip(isShow, dropType, index)
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  local self = PaGlobal_Alchemy_RateViewList
  if isShow == true then
    local itemSlot = self._list[dropType]._data[index]._itemSlot
    if itemSlot == nil then
      return
    end
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemSlot._itemEnchantKeyRaw))
    if itemSSW == nil then
    elseif PaGlobal_Alchemy_RateViewList._isConsole == true then
      if PaGlobalFunc_TooltipInfo_GetShow ~= nil and PaGlobalFunc_TooltipInfo_GetShow() == true then
        PaGlobalFunc_TooltipInfo_Close()
        return
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    else
      Panel_Tooltip_Item_Show(itemSSW, itemSlot.icon, true, false)
    end
  elseif PaGlobal_Alchemy_RateViewList._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function FromClient_CalculateGroup(dropType, index, itemEnchantKeyRaw)
  local self = PaGlobal_Alchemy_RateViewList
  local list = self._list[dropType]
  if list == nil then
    return
  end
  local group = list._data[index]._group
  local lifeTitle = list._lifeTitle
  if group == nil or lifeTitle == nil then
    return
  end
  local itemSlotBG = UI.getChildControl(group, "Static_ItemSlotBg")
  local itemName = UI.getChildControl(itemSlotBG, "StaticText_ItemName")
  local groupTitle = UI.getChildControl(group, "StaticText_GroupTitle")
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
  local itemSlot = list._data[index]._itemSlot
  if itemSSW == nil and itemEnchantKeyRaw == 0 then
    itemSlot.empty = true
    itemSlot._itemEnchantKeyRaw = itemEnchantKeyRaw
    itemName:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_NO_RESULT"))
  else
    itemSlot:setItemByStaticStatus(itemSSW)
    itemSlot._itemEnchantKeyRaw = itemEnchantKeyRaw
    itemName:SetText(itemSSW:getName())
  end
  self._ui._chk_eventDrop:SetShow(dropType == self.EVENT_DROP)
  local isShow = true
  if dropType == self.NORMAL_DROP then
    if index == 0 then
      lifeTitle:SetPosY(10)
      if self._lifeType == __eType_Life3 then
        lifeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_TITLE_COOK_MAIN"))
      elseif self._lifeType == __eType_Life4 then
        lifeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_TITLE_ALCHEMY_MAIN"))
      elseif self._lifeType == __eType_Life5 then
        lifeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_TITLE_MANUFACTURE_MAIN"))
      end
      group:SetPosY(lifeTitle:GetPosY() + lifeTitle:GetSizeY())
    else
      group:SetPosY(list._data[index - 1]._group:GetPosY() + list._data[index - 1]._group:GetSizeY())
    end
    self._normalTotalCount = self._normalTotalCount + 1
    isShow = true
  else
    if index == 0 then
      local lifeTitlePosY = 0
      local normaList = self._list[self.NORMAL_DROP]
      for i = 0, self._groupPoolCount do
        local normalGroup = normaList._data[i]._group
        if normalGroup:GetShow() == true then
          lifeTitlePosY = normalGroup:GetPosY() + normalGroup:GetSizeY()
        else
          break
        end
      end
      lifeTitle:SetPosY(lifeTitlePosY + 10)
      lifeTitle:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_TITLE_ETC_MAIN"))
      self._ui._chk_eventDrop:SetPosY(lifeTitle:GetPosY() + lifeTitle:GetTextSizeY() + 10)
      group:SetPosY(self._ui._chk_eventDrop:GetPosY() + self._ui._chk_eventDrop:GetSizeY())
    elseif index == 1 then
      group:SetPosY(self._ui._chk_eventDrop:GetPosY() + self._ui._chk_eventDrop:GetSizeY())
    else
      group:SetPosY(list._data[index - 1]._group:GetPosY() + list._data[index - 1]._group:GetSizeY())
    end
    self._eventTotalCount = self._eventTotalCount + 1
    isShow = false
  end
  groupTitle:SetText("")
  lifeTitle:SetShow(true)
  group:SetShow(isShow)
  itemSlotBG:SetShow(true)
  itemName:SetShow(true)
end
function FromClient_CalculateGroupPercent(dropType, index, itemEnchantKeyRaw, count, percent, countIndex)
  local self = PaGlobal_Alchemy_RateViewList
  local list = self._list[dropType]
  if list == nil then
    return
  end
  local group = list._data[index]._group
  if group == nil then
    return
  end
  local groupTitle = UI.getChildControl(group, "StaticText_GroupTitle")
  local itemSlotBG = UI.getChildControl(group, "Static_ItemSlotBg")
  local itemName = UI.getChildControl(itemSlotBG, "StaticText_ItemName")
  local horizoneLine = UI.getChildControl(group, "Static_HorizonLine")
  local percentString = PaGlobal_Alchemy_RateViewList:makeRateStringMinMax(percent, 4, 8)
  local finalString = ""
  local count32 = Int64toInt32(count)
  if count32 == 0 then
    finalString = groupTitle:GetText() .. PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_NO_GET_RATE", "rate", percentString) .. "\n"
  else
    finalString = groupTitle:GetText() .. PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_GET_RATE", "count", tostring(count), "rate", percentString) .. "\n"
  end
  groupTitle:SetText(finalString)
  groupTitle:SetSize(groupTitle:GetSizeX(), groupTitle:GetTextSizeY())
  groupTitle:SetPosY(itemSlotBG:GetPosY() + itemSlotBG:GetSizeY())
  if dropType == self.EVENT_DROP and index == 0 then
    group:SetSize(group:GetSizeX(), horizoneLine:GetSizeY() + 10)
    group:SetShow(false)
    local successValueStr = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_LIFERATEVIEW_ADD_ETC_RATE", "rate", PaGlobal_Alchemy_RateViewList:makeRateStringMinMax(1 - percent, 4, 8))
    UI.getChildControl(self._ui._chk_eventDrop, "StaticText_EtcName"):SetText(successValueStr)
    itemSlotBG:SetShow(false)
    itemName:SetShow(false)
    groupTitle:SetShow(false)
  else
    group:SetSize(group:GetSizeX(), itemSlotBG:GetPosY() + itemSlotBG:GetSizeY() + groupTitle:GetSizeY() - 10)
    groupTitle:SetShow(true)
  end
  horizoneLine:ComputePos()
  if dropType == self.NORMAL_DROP then
    self._normalTotalSizeY = group:GetPosY() + group:GetSizeY()
  else
    self._eventTotalSizeY = group:GetPosY() + group:GetSizeY()
  end
  local sizeY = 0
  if dropType == self.NORMAL_DROP then
    sizeY = self._normalTotalSizeY
    self._ui._stc_frameContent:SetSize(self._ui._stc_frameContent:GetSizeX(), sizeY)
    UIScroll.SetButtonSize(self._ui._scroll_vertical, self._normalTotalCount, sizeY)
    self._ui._scroll_vertical:SetControlPos(0)
    self._ui._stc_frame:UpdateContentPos()
  elseif dropType == self.EVENT_DROP then
    sizeY = self._ui._chk_eventDrop:GetPosY() + self._ui._chk_eventDrop:GetSizeY()
    self._ui._stc_frameContent:SetSize(self._ui._stc_frameContent:GetSizeX(), sizeY)
    UIScroll.SetButtonSize(self._ui._scroll_vertical, self._normalTotalCount, sizeY)
    self._ui._scroll_vertical:SetControlPos(0)
    self._ui._stc_frame:UpdateContentPos()
  end
  if sizeY < Panel_Alchemy_RateViewList:GetSizeY() - self._ui._stc_topGroup:GetSizeY() then
    self._ui._scroll_vertical:SetShow(false)
  else
    self._ui._scroll_vertical:SetShow(true)
  end
end
function PaGlobal_Alchemy_RateViewList_ToggleEventDrop()
  local self = PaGlobal_Alchemy_RateViewList
  self._isEventDropOpen = not self._isEventDropOpen
  local list = self._list[self.EVENT_DROP]
  if list == nil then
    return
  end
  if list._data == nil then
    return
  end
  local lifeTitle = list._lifeTitle
  local totalSizeY = lifeTitle:GetPosY() + lifeTitle:GetSizeY() + 10
  if self._isEventDropOpen == true then
    self._ui._chk_eventDrop:SetPosY(totalSizeY)
    for index = 1, self._groupPoolCount do
      local group = list._data[index]._group
      if group ~= nil then
        if index < self._eventTotalCount then
          group:SetShow(true)
          totalSizeY = group:GetPosY() + group:GetSizeY()
        else
          group:SetShow(false)
        end
      end
    end
  else
    self._ui._chk_eventDrop:SetPosY(totalSizeY)
    for index = 0, self._groupPoolCount do
      local group = list._data[index]._group
      if group ~= nil then
        group:SetShow(false)
      end
    end
    totalSizeY = self._ui._chk_eventDrop:GetPosY() + self._ui._chk_eventDrop:GetSizeY()
  end
  self._ui._stc_frameContent:SetSize(self._ui._stc_frameContent:GetSizeX(), totalSizeY)
  UIScroll.SetButtonSize(self._ui._scroll_vertical, self._normalTotalCount + self._eventTotalCount, totalSizeY)
  self._ui._scroll_vertical:SetControlPos(self._normalTotalSizeY / totalSizeY)
  self._ui._stc_frame:UpdateContentPos()
  if totalSizeY < Panel_Alchemy_RateViewList:GetSizeY() - self._ui._stc_topGroup:GetSizeY() then
    self._ui._scroll_vertical:SetShow(false)
  else
    self._ui._scroll_vertical:SetShow(true)
  end
end
function FromClient_OpenAlchemyShowRateViewButton()
  if PaGlobalFunc_Alchemy_All_ShowRateViewButton ~= nil then
    PaGlobalFunc_Alchemy_All_ShowRateViewButton(true)
  end
end
function FromClient_OpenManufactureShowRateViewButton()
  if PaGlobalFunc_Manufacture_All_ShowRateView ~= nil then
    PaGlobalFunc_Manufacture_All_ShowRateView(true)
  end
end
