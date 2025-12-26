function PaGlobal_Alchemy_RateViewList:initialize()
  if PaGlobal_Alchemy_RateViewList._initialize == true then
    return
  end
  self._ui._stc_topGroup = UI.getChildControl(Panel_Alchemy_RateViewList, "Static_TopGroup")
  self._ui._stc_btn_close = UI.getChildControl(self._ui._stc_topGroup, "Button_Close")
  self._ui._stc_contentGroup = UI.getChildControl(Panel_Alchemy_RateViewList, "Static_ContentGroup")
  self._ui._stc_frame = UI.getChildControl(self._ui._stc_contentGroup, "Frame_TotalReward")
  self._ui._stc_frameContent = UI.getChildControl(self._ui._stc_frame, "Frame_1_Content")
  self._ui._scroll_vertical = UI.getChildControl(self._ui._stc_frame, "Frame_1_VerticalScroll")
  self._ui._txt_lifeTitle = UI.getChildControl(self._ui._stc_frameContent, "StaticText_LifeTitle")
  self._ui._stc_group = UI.getChildControl(self._ui._stc_frameContent, "Static_Group")
  self._ui._chk_eventDrop = UI.getChildControl(self._ui._stc_frameContent, "Static_GroupTitleBG")
  self._ui._stc_itemSlotBG = UI.getChildControl(self._ui._stc_group, "Static_ItemSlotBg")
  self._ui._txt_itemName = UI.getChildControl(self._ui._stc_itemSlotBG, "StaticText_ItemName")
  self._ui._stc_horizonLine = UI.getChildControl(self._ui._stc_group, "Static_HorizonLIne")
  self._ui._console_keyGuide = UI.getChildControl(Panel_Alchemy_RateViewList, "Static_Key_Guide_ConsoleUI")
  self._ui._stc_console_detail = UI.getChildControl(self._ui._console_keyGuide, "StaticText_Detail_ConsoleUI")
  self._ui._stc_console_close = UI.getChildControl(self._ui._console_keyGuide, "StaticText_Close_ConsoleUI")
  PaGlobal_Alchemy_RateViewList:registEventHandler()
  PaGlobal_Alchemy_RateViewList:validate()
  PaGlobal_Alchemy_RateViewList:createTemplate()
  PaGlobal_Alchemy_RateViewList._initialize = true
end
function PaGlobal_Alchemy_RateViewList:registEventHandler()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  registerEvent("FromClient_CalculateGroup", "FromClient_CalculateGroup")
  registerEvent("FromClient_CalculateGroupPercent", "FromClient_CalculateGroupPercent")
  registerEvent("FromClient_OpenAlchemyShowRateViewButton", "FromClient_OpenAlchemyShowRateViewButton")
  registerEvent("FromClient_OpenManufactureShowRateViewButton", "FromClient_OpenManufactureShowRateViewButton")
  self._ui._stc_btn_close:addInputEvent("Mouse_LUp", "PaGloabl_Alchemy_RateViewList_Close(true)")
end
function PaGlobal_Alchemy_RateViewList:createTemplate()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  self._ui._chk_eventDrop:addInputEvent("Mouse_LUp", "PaGlobal_Alchemy_RateViewList_ToggleEventDrop()")
  for dropType = self.NORMAL_DROP, self.DROP_COUNT do
    local list = {
      _lifeTitle,
      _data = {}
    }
    local lifeTitle = UI.createAndCopyBasePropertyControl(self._ui._stc_frameContent, "StaticText_LifeTitle", self._ui._stc_frameContent, "StaticText_LifeTitle_" .. tostring(dropType))
    for i = 0, self._groupPoolCount do
      local group = UI.createAndCopyBasePropertyControl(self._ui._stc_frameContent, "Static_Group", self._ui._stc_frameContent, "Static_Group_" .. tostring(dropType) .. "_" .. tostring(i))
      local itemSlotBG = UI.createAndCopyBasePropertyControl(self._ui._stc_group, "Static_ItemSlotBg", group, "Static_ItemSlotBg")
      local itemName = UI.createAndCopyBasePropertyControl(self._ui._stc_itemSlotBG, "StaticText_ItemName", itemSlotBG, "StaticText_ItemName")
      local groupTitle = UI.createAndCopyBasePropertyControl(self._ui._stc_group, "StaticText_GroupTitle", group, "StaticText_GroupTitle")
      local horizoneLine = UI.createAndCopyBasePropertyControl(self._ui._stc_group, "Static_HorizonLIne", group, "Static_HorizonLine")
      local newSlot = {}
      SlotItem.new(newSlot, "ItemSlot", 0, itemSlotBG, self._slotConfig)
      newSlot:createChild()
      newSlot.empty = true
      newSlot:clearItem()
      newSlot.icon:SetPosXY(1, 1)
      if self._isConsole == true then
        itemSlotBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGloabl_Alchemy_RateViewList_ShowItemTooltip(true, " .. dropType .. ", " .. i .. ")")
      elseif self._isPadMode == true then
        itemSlotBG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGloabl_Alchemy_RateViewList_ShowItemTooltip(true, " .. dropType .. ", " .. i .. ")")
        newSlot.icon:addInputEvent("Mouse_Out", "PaGloabl_Alchemy_RateViewList_ShowItemTooltip(false, " .. dropType .. ", " .. i .. ")")
      else
        newSlot.icon:addInputEvent("Mouse_On", "PaGloabl_Alchemy_RateViewList_ShowItemTooltip(true, " .. dropType .. ", " .. i .. ")")
        newSlot.icon:addInputEvent("Mouse_Out", "PaGloabl_Alchemy_RateViewList_ShowItemTooltip(false, " .. dropType .. ", " .. i .. ")")
      end
      group:SetShow(false)
      itemSlotBG:SetShow(false)
      itemName:SetShow(false)
      groupTitle:SetShow(false)
      local data = {_group, _itemSlot}
      data._group = group
      data._itemSlot = newSlot
      list._data[i] = data
    end
    list._lifeTitle = lifeTitle
    self._list[dropType] = list
  end
  self._ui._stc_group:SetShow(false)
  if self._isConsole == true or self._isPadMode == true then
    local keyGuideList = Array.new()
    keyGuideList:push_back(self._ui._stc_console_detail)
    keyGuideList:push_back(self._ui._stc_console_close)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._console_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP, nil, nil)
  end
end
function PaGlobal_Alchemy_RateViewList:prepareOpen()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  if self._lifeType == __eType_Life3 or self._lifeType == __eType_Life4 then
    Panel_Alchemy_RateViewList:SetPosXY(Panel_Window_Alchemy_All:GetPosX() - Panel_Alchemy_RateViewList:GetSizeX() - 5, Panel_Window_Alchemy_All:GetPosY())
  elseif self._lifeType == __eType_Life5 then
    Panel_Alchemy_RateViewList:SetPosXY(Panel_Window_Manufacture_All:GetPosX() - Panel_Alchemy_RateViewList:GetSizeX() - 5, Panel_Window_Manufacture_All:GetPosY())
  end
  PaGlobal_Alchemy_RateViewList:open()
end
function PaGlobal_Alchemy_RateViewList:open()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  Panel_Alchemy_RateViewList:SetShow(true)
end
function PaGlobal_Alchemy_RateViewList:prepareClose()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  if PaGlobal_Alchemy_RateViewList._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  PaGlobal_Alchemy_RateViewList:close()
end
function PaGlobal_Alchemy_RateViewList:close()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  Panel_Alchemy_RateViewList:SetShow(false)
end
function PaGlobal_Alchemy_RateViewList:clearGroup()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  for dropType = self.NORMAL_DROP, self.DROP_COUNT do
    local list = self._list[dropType]
    local lifeTitle = list._lifeTitle
    for i = 0, PaGlobal_Alchemy_RateViewList._groupPoolCount do
      local group = list._data[i]._group
      local itemSlotBG = UI.getChildControl(group, "Static_ItemSlotBg")
      local itemName = UI.getChildControl(itemSlotBG, "StaticText_ItemName")
      local groupTitle = UI.getChildControl(group, "StaticText_GroupTitle")
      group:SetShow(false)
      itemSlotBG:SetShow(false)
      itemName:SetShow(false)
      groupTitle:SetShow(false)
    end
    lifeTitle:SetShow(false)
  end
  self._normalTotalCount = 0
  self._eventTotalCount = 0
  self._isEventDropOpen = false
  self._ui._chk_eventDrop:SetCheck(true)
end
function PaGlobal_Alchemy_RateViewList:makeRateStringMinMax(rate, basicCount, maxCount)
  if Panel_Alchemy_RateViewList == nil then
    return ""
  end
  if rate == nil or rate < 0 then
    return ""
  end
  if basicCount == nil or basicCount < 0 then
    return ""
  end
  local rv = string.format("%." .. tostring(maxCount) .. "f", rate * 100)
  local rvLen = string.len(rv)
  local charArray = Array.new()
  for index = 1, rvLen do
    local rvChar = string.sub(rv, index, index)
    charArray:push_back(rvChar)
  end
  local findFirstNotZero = 1
  local findPoint = false
  for index = 1, #charArray do
    local rvChar = charArray[index]
    if rvChar == "." then
      findPoint = true
    end
    if findPoint == true then
      if rvChar == "0" then
        findFirstNotZero = findFirstNotZero + 1
      elseif rvChar ~= "." then
        break
      end
    end
  end
  if basicCount > findFirstNotZero then
    return PaGlobalFunc_Util_MakeRateDotString(rate, basicCount)
  elseif maxCount < findFirstNotZero then
    return PaGlobalFunc_Util_MakeRateDotString(rate, maxCount)
  else
    return PaGlobalFunc_Util_MakeRateDotString(rate, findFirstNotZero)
  end
  return PaGlobalFunc_Util_MakeRateDotString(rate, basicCount)
end
function PaGlobal_Alchemy_RateViewList:validate()
  if Panel_Alchemy_RateViewList == nil then
    return
  end
  self._ui._stc_topGroup:isValidate()
  self._ui._stc_btn_close:isValidate()
  self._ui._stc_contentGroup:isValidate()
  self._ui._stc_frame:isValidate()
  self._ui._stc_frameContent:isValidate()
  self._ui._scroll_vertical:isValidate()
  self._ui._txt_lifeTitle:isValidate()
  self._ui._stc_group:isValidate()
  self._ui._stc_itemSlotBG:isValidate()
  self._ui._txt_itemName:isValidate()
  self._ui._stc_horizonLine:isValidate()
end
