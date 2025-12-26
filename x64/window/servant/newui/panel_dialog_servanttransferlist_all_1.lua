function PaGlobal_ServantTransferList_All:initialize()
  if nil == Panel_Dialog_ServantTransferList_All or true == self._initailize then
    return
  end
  self._ui._txt_Title = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "StaticText_Title")
  self._ui._btn_Close_PC = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Button_Close")
  self._ui._stc_Bg = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Static_Bg")
  self._ui._txt_Desc = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "StaticText_Desc")
  self._ui._txt_Count = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "StaticText_Count")
  self._ui._list2_Servant = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "List2_Servant")
  self._ui._list2_Content = UI.getChildControl(self._ui._list2_Servant, "List2_1_Content")
  self._ui._list2_Btn_List = UI.getChildControl(self._ui._list2_Content, "RadioButton_List")
  self._ui._list2_Verti_Scroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_VerticalScroll")
  self._ui._list2_Verti_Scroll_Up = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_UpButton")
  self._ui._list2_Verti_Scroll_Down = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_DownButton")
  self._ui._list2_Verti_Scroll_Ctrl = UI.getChildControl(self._ui._list2_Verti_Scroll, "List2_1_VerticalScroll_CtrlButton")
  self._ui._list2_Hori_Scroll = UI.getChildControl(self._ui._list2_Servant, "List2_1_HorizontalScroll")
  self._ui._list2_Hori_Scroll_Up = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_UpButton")
  self._ui._list2_Hori_Scroll_Down = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_DownButton")
  self._ui._list2_Hori_Scroll_Ctrl = UI.getChildControl(self._ui._list2_Hori_Scroll, "List2_1_HorizontalScroll_CtrlButton")
  self._ui._stc_Bottom_KeyGuide = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_Keyguide_A = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_A_ConsoleUI")
  self._ui._stc_Keyguide_B = UI.getChildControl(self._ui._stc_Bottom_KeyGuide, "StaticText_B_ConsoleUI")
  self._ui._stc_ButtonBg = UI.getChildControl(Panel_Dialog_ServantTransferList_All, "Static_ButtonBg")
  self._ui._btn_Territory_Temp = UI.getChildControl(self._ui._stc_ButtonBg, "Button_Territory_Template")
  self:textReSize()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_ServantTransferList_All:validate()
  PaGlobal_ServantTransferList_All:isConsoleUI(self._isConsole)
  PaGlobal_ServantTransferList_All:registerEventHandler(self._isConsole)
  self._ui._stc_ButtonBg:SetShow(false)
  for index = 0, self._maxTerritoryCount - 1 do
    local temp = UI.createControl(__ePAUIControl_Button, self._ui._stc_ButtonBg, "Button_Territory_" .. index)
    CopyBaseProperty(self._ui._btn_Territory_Temp, temp)
    local tempIcon = UI.createControl(__ePAUIControl_Static, temp, "Static_TerritoryIcon")
    CopyBaseProperty(UI.getChildControl(self._ui._btn_Territory_Temp, "Static_Icon"), tempIcon)
    tempIcon:ChangeTextureInfoNameAsync(self._categoryIconTexturePath._path)
    local normal = self._categoryIconTexturePath._normal
    local x1, y1, x2, y2 = setTextureUV_Func(tempIcon, normal[index][1], normal[index][2], normal[index][3], normal[index][4])
    tempIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    tempIcon:setRenderTexture(tempIcon:getBaseTexture())
    self._ui._btn_Territory[index] = temp
    self._ui._stc_TerritoryIcon[index] = tempIcon
  end
end
function PaGlobal_ServantTransferList_All:textReSize()
  local textSizeX = self._ui._txt_Desc:GetTextSizeX()
  local sizeX = self._ui._txt_Desc:GetSizeX()
  if textSizeX > sizeX then
    local text = self._ui._txt_Desc:GetText()
    self._ui._txt_Desc:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_Desc:SetText(text)
    self._ui._txt_Desc:SetTextVerticalTop()
    local textSizeY = self._ui._txt_Desc:GetTextSizeY()
    local value = textSizeY - self._ui._txt_Desc:GetSizeY()
    local txt_Count_OriginPosY = self._ui._txt_Count:GetPosY()
    local list2_Servant_OriginPosY = self._ui._list2_Servant:GetPosY()
    self._ui._txt_Count:SetPosY(txt_Count_OriginPosY + value)
    self._ui._list2_Servant:SetPosY(list2_Servant_OriginPosY + value)
    self._ui._stc_Bg:SetSize(self._ui._stc_Bg:GetSizeX(), self._ui._stc_Bg:GetSizeY() + value)
    Panel_Dialog_ServantTransferList_All:SetSize(Panel_Dialog_ServantTransferList_All:GetSizeX(), Panel_Dialog_ServantTransferList_All:GetSizeY() + value)
    self._ui._stc_Bottom_KeyGuide:SetPosY(Panel_Dialog_ServantTransferList_All:GetSizeY())
  end
end
function PaGlobal_ServantTransferList_All:validate()
  if nil == Panel_Dialog_ServantTransferList_All then
    return
  end
  self._ui._txt_Title:isValidate()
  self._ui._btn_Close_PC:isValidate()
  self._ui._stc_Bg:isValidate()
  self._ui._txt_Desc:isValidate()
  self._ui._txt_Count:isValidate()
  self._ui._list2_Servant:isValidate()
  self._ui._list2_Content:isValidate()
  self._ui._list2_Btn_List:isValidate()
  self._ui._list2_Verti_Scroll:isValidate()
  self._ui._list2_Verti_Scroll_Up:isValidate()
  self._ui._list2_Verti_Scroll_Down:isValidate()
  self._ui._list2_Verti_Scroll_Ctrl:isValidate()
  self._ui._list2_Hori_Scroll:isValidate()
  self._ui._list2_Hori_Scroll_Up:isValidate()
  self._ui._list2_Hori_Scroll_Down:isValidate()
  self._ui._list2_Hori_Scroll_Ctrl:isValidate()
  self._ui._stc_Bottom_KeyGuide:isValidate()
  self._ui._stc_Keyguide_A:isValidate()
  self._ui._stc_Keyguide_B:isValidate()
  self._ui._stc_ButtonBg:isValidate()
  self._ui._btn_Territory_Temp:isValidate()
  self._initailize = true
end
function PaGlobal_ServantTransferList_All:registerEventHandler(isConsole)
  if nil == Panel_Dialog_ServantTransferList_All or false == self._initailize then
    return
  end
  registerEvent("onScreenResize", "FromClient_ServantTransferList_All_OnScreenResize")
  self._ui._list2_Servant:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ServantTransferList_All_List2Update")
  self._ui._list2_Servant:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == isConsole then
    self._ui._btn_Close_PC:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantTransferList_All_Close()")
  else
  end
end
function PaGlobal_ServantTransferList_All:isConsoleUI(isConsole)
  if nil == Panel_Dialog_ServantTransferList_All or false == self._initailize then
    return
  end
  Panel_Dialog_ServantTransferList_All:SetDragEnable(not isConsole)
  Panel_Dialog_ServantTransferList_All:SetDragAll(not isConsole)
  self._ui._btn_Close_PC:SetShow(not isConsole)
  self._ui._stc_Bottom_KeyGuide:SetShow(isConsole)
  if true == isConsole then
    local keyguide = {
      self._ui._stc_Keyguide_A,
      self._ui._stc_Keyguide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyguide, self._ui._stc_Bottom_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._stc_Bottom_KeyGuide:SetPosY(Panel_Dialog_ServantTransferList_All:GetSizeY())
  end
end
function PaGlobal_ServantTransferList_All:prepareOpen()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  self._isWorldMapOpen = false
  FromClient_ServantTransferList_All_OnScreenResize()
  PaGlobal_ServantTransferList_All:open()
  PaGlobal_ServantTransferList_All:update()
end
function PaGlobal_ServantTransferList_All:open()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  for index = 0, self._maxTerritoryCount - 1 do
    self._ui._btn_Territory[index]:SetShow(false)
  end
  self._ui._stc_ButtonBg:SetShow(false)
  Panel_Dialog_ServantTransferList_All:SetShow(true)
end
function PaGlobal_ServantTransferList_All:update()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer then
    return
  end
  self._isTransBackWordList = false
  self._ui._list2_Servant:getElementManager():clearKey()
  local currentRegionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local currentRegionKey = currentRegionInfo:getRegionKey()
  self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTTRANSFER_DESC"))
  self:textReSize()
  local sortList = {}
  local territoryList = {}
  local roseWarRegionCount = 0
  if __eServantTypeVehicle == stable_getServantType() then
    self._curOpenType = self._eOpenType.STABLE
    local territoryCount = 0
    local regionKeyCount = ToClient_GetCountOfRegionListWithStableNpc()
    for i = 0, regionKeyCount - 1 do
      local regionKey = ToClient_GetRegionWithStableNpcByIndex(i)
      if regionKey ~= currentRegionKey then
        if ToClient_IsRoseWarServantNpcRegion(regionKey) == false then
          local regionInfoWrapper = getRegionInfoWrapper(regionKey)
          if nil ~= regionInfoWrapper then
            local territoryKey = regionInfoWrapper:getTerritoryKeyRaw()
            if 0 == territoryCount then
              sortList[territoryKey] = {}
              table.insert(sortList[territoryKey], regionKey)
              territoryList[territoryCount] = territoryKey
              territoryCount = territoryCount + 1
            else
              if nil == sortList[territoryKey] then
                sortList[territoryKey] = {}
                territoryList[territoryCount] = territoryKey
                territoryCount = territoryCount + 1
              end
              table.insert(sortList[territoryKey], regionKey)
            end
          end
        else
          roseWarRegionCount = roseWarRegionCount + 1
        end
      end
    end
    local territoryIndex = 0
    for ii = 0, territoryCount - 1 do
      local territoryKey = territoryList[ii]
      for jj = 0, #sortList[territoryKey] do
        if 0 == jj then
          self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, territoryKey + 100000))
          self:territoryButtonShow(territoryKey, ii, territoryIndex)
        else
          local regionKey = sortList[territoryKey][jj]
          self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, regionKey))
        end
        territoryIndex = territoryIndex + 1
      end
    end
    regionKeyCount = regionKeyCount - 1 - roseWarRegionCount
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVETITLE"))
    self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_STABLE_CHANGE_REGION_LIST_COUNT", "count", regionKeyCount))
  elseif __eServantTypeShip == stable_getServantType() then
    self._curOpenType = self._eOpenType.WHARF
    local isGuildWharf = PaGlobalFunc_ServantFunction_All_GetIsGuild()
    local territoryCount = 0
    local regionKeyCount = ToClient_GetCountOfRegionListWithWharfNpc(isGuildWharf)
    for i = 0, regionKeyCount - 1 do
      local regionKey = ToClient_GetRegionWithWharfNpcByIndex(i)
      if regionKey ~= currentRegionKey then
        local regionInfoWrapper = getRegionInfoWrapper(regionKey)
        if nil ~= regionInfoWrapper then
          local territoryKey = regionInfoWrapper:getTerritoryKeyRaw()
          if 0 == territoryCount then
            sortList[territoryKey] = {}
            table.insert(sortList[territoryKey], regionKey)
            territoryList[territoryCount] = territoryKey
            territoryCount = territoryCount + 1
          else
            if nil == sortList[territoryKey] then
              sortList[territoryKey] = {}
              territoryList[territoryCount] = territoryKey
              territoryCount = territoryCount + 1
            end
            table.insert(sortList[territoryKey], regionKey)
          end
        end
      end
    end
    local territoryIndex = 0
    for ii = 0, territoryCount - 1 do
      local territoryKey = territoryList[ii]
      for jj = 0, #sortList[territoryKey] do
        if 0 == jj then
          self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, territoryKey + 100000))
          self:territoryButtonShow(territoryKey, ii, territoryIndex)
        else
          local regionKey = sortList[territoryKey][jj]
          self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, regionKey))
        end
        territoryIndex = territoryIndex + 1
      end
    end
    regionKeyCount = regionKeyCount - 1 - roseWarRegionCount
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHARF_VEHICLEMOVETITLE"))
    self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_WHARF_CHANGE_REGION_LIST_COUNT", "count", regionKeyCount))
  else
    return
  end
end
function PaGlobal_ServantTransferList_All:territoryButtonShow(territoryKey, index, territoryIndex)
  if true == self._isConsole then
    self._ui._stc_ButtonBg:SetShow(false)
    return
  end
  self._ui._btn_Territory[territoryKey]:SetPosY(self._ui._btn_Territory_Temp:GetPosY() + index * (self._ui._btn_Territory_Temp:GetSizeY() + 4))
  self._ui._btn_Territory[territoryKey]:addInputEvent("Mouse_On", "PaGlobal_ServantTransferList_All:territoryTooltipShow(true," .. territoryKey .. ")")
  self._ui._btn_Territory[territoryKey]:addInputEvent("Mouse_Out", "PaGlobal_ServantTransferList_All:territoryTooltipShow(false)")
  self._ui._btn_Territory[territoryKey]:addInputEvent("Mouse_LUp", "PaGlobal_ServantTransferList_All:moveIndex(" .. territoryIndex .. ")")
  self._ui._btn_Territory[territoryKey]:SetShow(true)
  self._ui._stc_ButtonBg:SetSize(self._ui._stc_ButtonBg:GetSizeX(), (index + 1) * (self._ui._btn_Territory_Temp:GetSizeY() + 4) + 4)
  self._ui._stc_ButtonBg:SetShow(true)
end
function PaGlobal_ServantTransferList_All:territoryTooltipShow(isShow, territoryKey)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local territoryInfoWrapper = getTerritoryInfoWrapper(territoryKey)
  if nil == territoryInfoWrapper then
    return
  end
  local name = territoryInfoWrapper:getTerritoryName()
  TooltipSimple_Show(self._ui._btn_Territory[territoryKey], name, nil, self._ui._stc_TerritoryIcon[territoryKey])
end
function PaGlobal_ServantTransferList_All:moveIndex(index)
  PaGlobal_ServantTransferList_All._ui._list2_Servant:moveIndex(index)
end
function PaGlobal_ServantTransferList_All:updateFromWorldmap()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer() then
    return
  end
  local servantNo = self._servantNo
  if nil == servantNo then
    return
  end
  local servantInfo = stable_getServantByServantNo(servantNo)
  if nil == servantInfo then
    return
  end
  local servantRegionKey = servantInfo:getRegionKeyRaw()
  self._ui._list2_Servant:getElementManager():clearKey()
  self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTTRANSFER_DESC"))
  self:textReSize()
  self._curOpenType = self._eOpenType.WORLDMAP
  local sortList = {}
  local territoryList = {}
  local territoryCount = 0
  local regionKeyCount = ToClient_GetCountOfRegionListWithStableNpc()
  local roseWarRegionCount = 0
  for i = 0, regionKeyCount - 1 do
    local regionKey = ToClient_GetRegionWithStableNpcByIndex(i)
    if regionKey ~= servantRegionKey then
      if ToClient_IsRoseWarServantNpcRegion(regionKey) == false then
        local regionInfoWrapper = getRegionInfoWrapper(regionKey)
        if nil ~= regionInfoWrapper then
          local territoryKey = regionInfoWrapper:getTerritoryKeyRaw()
          if 0 == territoryCount then
            sortList[territoryKey] = {}
            table.insert(sortList[territoryKey], regionKey)
            territoryList[territoryCount] = territoryKey
            territoryCount = territoryCount + 1
          else
            if nil == sortList[territoryKey] then
              sortList[territoryKey] = {}
              territoryList[territoryCount] = territoryKey
              territoryCount = territoryCount + 1
            end
            table.insert(sortList[territoryKey], regionKey)
          end
        end
      else
        roseWarRegionCount = roseWarRegionCount + 1
      end
    end
  end
  local territoryIndex = 0
  for ii = 0, territoryCount - 1 do
    local territoryKey = territoryList[ii]
    for jj = 0, #sortList[territoryKey] do
      if 0 == jj then
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, territoryKey + 100000))
        self:territoryButtonShow(territoryKey, ii, territoryIndex)
      else
        local regionKey = sortList[territoryKey][jj]
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, regionKey))
      end
      territoryIndex = territoryIndex + 1
    end
  end
  regionKeyCount = regionKeyCount - 1 - roseWarRegionCount
  self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVETITLE"))
  self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_STABLE_CHANGE_REGION_LIST_COUNT", "count", regionKeyCount))
end
function PaGlobal_ServantTransferList_All:backwardPrepareOpen()
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  FromClient_ServantTransferList_All_OnScreenResize()
  PaGlobal_ServantTransferList_All:open()
  PaGlobal_ServantTransferList_All:transBackwardListUpdate()
end
function PaGlobal_ServantTransferList_All:PrepareOpenFromWorldmap(servantNo)
  if nil == Panel_Dialog_ServantTransferList_All or true == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  FromClient_ServantTransferList_All_OnScreenResize()
  self._servantNo = servantNo
  if false == Panel_Dialog_ServantTransferList_All:GetShow() then
    WorldMapPopupManager:increaseLayer(true)
    WorldMapPopupManager:push(Panel_Dialog_ServantTransferList_All, true)
  end
  self._isTransBackWordList = false
  self._isWorldMapOpen = true
  PaGlobal_ServantTransferList_All:open()
  PaGlobal_ServantTransferList_All:updateFromWorldmap()
end
function PaGlobal_ServantTransferList_All:transBackwardListUpdate()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if nil == getSelfPlayer then
    return
  end
  self._isTransBackWordList = true
  self._ui._list2_Servant:getElementManager():clearKey()
  local currentRegionInfo = getRegionInfoByPosition(getSelfPlayer():get():getPosition())
  local currentRegionKey = currentRegionInfo:getRegionKey()
  local sortList = {}
  local territoryList = {}
  local territoryCount = 0
  local listCount = ToClient_getReverseTransferableRegionCount()
  local exceptionCurrentRegion = false
  for index = 0, listCount - 1 do
    local regionKey = ToClient_getReverseTransferableRegionKeyByIndex(index)
    if regionKey ~= currentRegionKey then
      local regionInfoWrapper = getRegionInfoWrapper(regionKey)
      if nil ~= regionInfoWrapper then
        local territoryKey = regionInfoWrapper:getTerritoryKeyRaw()
        if 0 == territoryCount then
          sortList[territoryKey] = {}
          table.insert(sortList[territoryKey], regionKey)
          territoryList[territoryCount] = territoryKey
          territoryCount = territoryCount + 1
        else
          if nil == sortList[territoryKey] then
            sortList[territoryKey] = {}
            territoryList[territoryCount] = territoryKey
            territoryCount = territoryCount + 1
          end
          table.insert(sortList[territoryKey], regionKey)
        end
      end
    else
      exceptionCurrentRegion = true
    end
  end
  local territoryIndex = 0
  for ii = 0, territoryCount - 1 do
    local territoryKey = territoryList[ii]
    for jj = 0, #sortList[territoryKey] do
      if 0 == jj then
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, territoryKey + 100000))
        self:territoryButtonShow(territoryKey, ii, territoryIndex)
      else
        local regionKey = sortList[territoryKey][jj]
        self._ui._list2_Servant:getElementManager():pushKey(toInt64(0, regionKey))
      end
      territoryIndex = territoryIndex + 1
    end
  end
  if exceptionCurrentRegion == true then
    listCount = listCount - 1
  end
  self._ui._txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTTRANSFERBACKWARD_DESC"))
  self:textReSize()
  if __eServantTypeVehicle == stable_getServantType() then
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLE_VEHICLEMOVE_BACKWARD_TITLE"))
    self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_STABLE_CHANGE_REGION_BACKWARD_LIST_COUNT", "count", listCount))
  elseif __eServantTypeShip == stable_getServantType() then
    self._ui._txt_Title:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WHARF_VEHICLEMOVE_BACKWARD_TITLE"))
    self._ui._txt_Count:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "LUA_WHARF_CHANGE_REGION_BACKWARD_LIST_COUNT", "count", listCount))
  else
    return
  end
end
function PaGlobal_ServantTransferList_All:list2Update(content, key)
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() or nil == key then
    return
  end
  local regionKey = Int64toInt32(key)
  if regionKey >= 100000 then
    local territoryKey = regionKey - 100000
    local territoryInfoWrapper = getTerritoryInfoWrapper(territoryKey)
    local territoryName = territoryInfoWrapper:getTerritoryName()
    local regionControl = UI.getChildControl(content, "RadioButton_List")
    regionControl:SetText("<PAColor0xFFF5BA3A>\226\151\134 " .. territoryName .. "<PAOldColor>")
    if self._isConsole then
      regionControl:SetIgnore(false)
      regionControl:addInputEvent("Mouse_LUp", "")
    else
      regionControl:SetIgnore(true)
    end
    return
  end
  local regionInfo = getRegionInfoWrapper(regionKey)
  if nil == regionInfo then
    return
  end
  local regionControl = UI.getChildControl(content, "RadioButton_List")
  regionControl:setNotImpactScrollEvent(true)
  if false == self._isTransBackWordList then
    regionControl:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantTransferList_All_Transfer(" .. regionKey .. ")")
  else
    regionControl:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantTransferBackwardList_All_Open(" .. regionKey .. ")")
  end
  local regionKey = regionInfo:getRegionKey()
  local servantCount = 0
  if self._isTransBackWordList == true then
    servantCount = ToClient_getReverseTransferableListCountByRegionKey(regionKey)
  elseif self._curOpenType == self._eOpenType.STABLE or self._curOpenType == self._eOpenType.WORLDMAP then
    servantCount = ToClient_StableCountFromRegionKeyRaw(regionKey)
  elseif self._curOpenType == self._eOpenType.WHARF then
    local isGuildWharf = PaGlobalFunc_ServantFunction_All_GetIsGuild()
    servantCount = ToClient_WharfCountFromRegionKeyRaw(regionKey, isGuildWharf)
  end
  regionControl:SetIgnore(false)
  regionControl:SetCheck(false)
  regionControl:SetText(regionInfo:getAreaName() .. " (" .. servantCount .. ")")
end
function PaGlobal_ServantTransferList_All:prepareClose()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  if MessageBoxCheck.isCurrentOpen(self._currentTitle) then
    messageBoxCheck_CancelButtonUp()
  end
  PaGlobal_ServantTransferList_All:close()
end
function PaGlobal_ServantTransferList_All:close()
  if nil == Panel_Dialog_ServantTransferList_All or false == Panel_Dialog_ServantTransferList_All:GetShow() then
    return
  end
  Panel_Dialog_ServantTransferList_All:SetShow(false)
end
