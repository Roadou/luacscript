function PaGlobal_GuildWareHouseHistory:init()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._topBg = UI.getChildControl(Panel_Window_GuildWareHouseHistory, "Static_TopBg")
  self._ui._mainBg = UI.getChildControl(Panel_Window_GuildWareHouseHistory, "Static_MainBg")
  self._ui._btn_close = UI.getChildControl(self._ui._topBg, "Button_Close_PCUI")
  self._ui._stc_descBg = UI.getChildControl(self._ui._mainBg, "Static_DescBg")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBg, "StaticText_Desc")
  self._ui._stc_keyGuide = UI.getChildControl(Panel_Window_GuildWareHouseHistory, "Static_BottomBg")
  self._ui._stc_tabBg = UI.getChildControl(Panel_Window_GuildWareHouseHistory, "Static_UserInven_RadioButtonBg")
  self._ui._rdo_warehouse = UI.getChildControl(self._ui._stc_tabBg, "RadioButton_Warehouse")
  self._ui._rdo_mansionBuff = UI.getChildControl(self._ui._stc_tabBg, "RadioButton_MansionBuff")
  self._ui._rdo_questAccept = UI.getChildControl(self._ui._stc_tabBg, "RadioButton_QuestAccept")
  self._ui._stc_tabSelectBar = UI.getChildControl(self._ui._stc_tabBg, "Static_SelectBar")
  self._ui._stc_keyGuide_LB = UI.getChildControl(self._ui._stc_tabBg, "Static_LB_ConsoleUI")
  self._ui._stc_keyGuide_RB = UI.getChildControl(self._ui._stc_tabBg, "Static_RB_ConsoleUI")
  self._ui._rdo_warehouse:addInputEvent("Mouse_LUp", "PaGlobal_GuildWareHouseHistory:selectTab(" .. tostring(self._eTabType.WAREHOUSE) .. ")")
  self._ui._rdo_mansionBuff:addInputEvent("Mouse_LUp", "PaGlobal_GuildWareHouseHistory:selectTab(" .. tostring(self._eTabType.MANSIONBUFF) .. ")")
  self._ui._rdo_questAccept:addInputEvent("Mouse_LUp", "PaGlobal_GuildWareHouseHistory:selectTab(" .. tostring(self._eTabType.QUESTACCEPT) .. ")")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildWareHouseHistory:close()")
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(self._ui._txt_desc:GetText())
  local basicSizeY = self._ui._stc_descBg:GetSizeY()
  local textSizeY = self._ui._txt_desc:GetTextSizeY()
  local gapSizeY = math.max(basicSizeY, textSizeY) - basicSizeY
  if gapSizeY > 0 then
    gapSizeY = gapSizeY + 15
  end
  Panel_Window_GuildWareHouseHistory:SetSize(Panel_Window_GuildWareHouseHistory:GetSizeX(), Panel_Window_GuildWareHouseHistory:GetSizeY() + gapSizeY)
  self._ui._mainBg:SetSize(self._ui._mainBg:GetSizeX(), self._ui._mainBg:GetSizeY() + gapSizeY)
  self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), basicSizeY + gapSizeY)
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), basicSizeY + gapSizeY)
  self._ui._stc_descBg:ComputePos()
  if _ContentsGroup_GuildQuestAndSkillImprove == false then
    self._ui._rdo_warehouse:SetSpanSize(-50, 0)
    self._ui._rdo_mansionBuff:SetSpanSize(50, 0)
    self._ui._rdo_questAccept:SetIgnore(true)
    self._ui._rdo_questAccept:SetShow(false)
  end
  self._ui._list2_logList = UI.getChildControl(self._ui._mainBg, "List2_WareHouse")
  local list2Content = UI.getChildControl(self._ui._list2_logList, "List2_WareHouse_Content")
  local list2slotBg = UI.getChildControl(list2Content, "Static_SlotBg")
  local list2slotIcon = UI.getChildControl(list2slotBg, "Static_ItemIcon")
  local slot = {}
  SlotItem.new(slot, "GuildHistory_ItemIcon_", 0, list2slotIcon, self._slotConfig)
  slot:createChild()
  slot.icon:SetHorizonCenter()
  slot.icon:SetVerticalMiddle()
  slot.icon:ComputePos()
  self._ui._list2_logList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_GuildWareHouseHistory_CreateControlList2")
  self._ui._list2_logList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:SetShow(self._isConsole == false)
  self._ui._stc_keyGuide:SetShow(self._isConsole == true)
  self._ui._stc_keyGuide_LB:SetShow(self._isConsole == true)
  self._ui._stc_keyGuide_RB:SetShow(self._isConsole == true)
  if self._isConsole == true then
    local keyguideB = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_B")
    local keyguideX = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_X")
    local keyguideA = UI.getChildControl(self._ui._stc_keyGuide, "StaticText_A")
    local keyGuides = {
      keyguideA,
      keyguideX,
      keyguideB
    }
    if _ContentsGroup_RenewUI == true then
      keyguideA:SetShow(false)
    else
      keyguideX:SetShow(false)
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    Panel_Window_GuildWareHouseHistory:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventPadLBRB_GuildWareHouseHistory_ChangeTab(true)")
    Panel_Window_GuildWareHouseHistory:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventPadLBRB_GuildWareHouseHistory_ChangeTab(false)")
  end
  registerEvent("FromClient_getGuildWareHouseMansionBuffQuestAcceptHistory", "FromClient_getGuildWareHouseMansionBuffQuestAcceptHistory")
end
function PaGlobal_GuildWareHouseHistory:open()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  if self._currentTabType == nil then
    self:selectTab(self._eTabType.WAREHOUSE)
  else
    self:selectTab(self._currentTabType)
  end
  if PaGlobal_WareHouse_All._isConsole == true then
    if Panel_Window_Warehouse:GetShow() == true then
      Panel_Window_GuildWareHouseHistory:SetPosX(Panel_Window_Warehouse:GetPosX() - Panel_Window_Warehouse:GetSizeX() * 0.5 - Panel_Window_GuildWareHouseHistory:GetSizeX() * 0.5)
    else
      Panel_Window_GuildWareHouseHistory:SetPosX(Panel_GuildMain_All:GetPosX() + Panel_GuildMain_All:GetSizeX() * 0.5 - Panel_Window_GuildWareHouseHistory:GetSizeX() * 0.5)
    end
  end
  Panel_Window_GuildWareHouseHistory:SetShow(true)
end
function PaGlobal_GuildWareHouseHistory:close()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  self._currentTabType = nil
  Panel_Window_GuildWareHouseHistory:SetShow(false)
  self:itemTooltipHide()
  if Panel_GuildQuestInfo_All ~= nil then
    PaGlobal_GuildQuestInfo_Close_All()
  end
end
function PaGlobal_GuildWareHouseHistory:itemTooltipShow(index, itemKey, enchantLevel)
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey, enchantLevel))
  if itemSSW ~= nil then
    Panel_Tooltip_Item_Show(itemSSW, Panel_Window_GuildWareHouseHistory, true)
  end
end
function PaGlobal_GuildWareHouseHistory:itemTooltipHide()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_GuildWareHouseHistory:selectTab(tabType)
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  if tabType ~= self._eTabType.WAREHOUSE and tabType ~= self._eTabType.MANSIONBUFF and tabType ~= self._eTabType.QUESTACCEPT then
    return
  end
  self:itemTooltipHide()
  self._currentTabType = tabType
  local selectBarSpanX = 0
  if self._currentTabType == self._eTabType.WAREHOUSE then
    self._ui._rdo_warehouse:SetCheck(true)
    self._ui._rdo_mansionBuff:SetCheck(false)
    self._ui._rdo_questAccept:SetCheck(false)
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDWAREHOUSELOG_DESC"))
    selectBarSpanX = self._ui._rdo_warehouse:GetPosX() + self._ui._rdo_warehouse:GetSizeX() / 2
    self:updateList_Warehouse()
    if Panel_GuildQuestInfo_All ~= nil then
      PaGlobal_GuildQuestInfo_Close_All()
    end
    if self._isConsole == true then
      UI.getChildControl(self._ui._stc_keyGuide, "StaticText_X"):SetShow(false)
      UI.getChildControl(self._ui._stc_keyGuide, "StaticText_A"):SetShow(false)
      local wrapper = ToClient_guildWareHouseHistoryWrapper(0)
      if wrapper ~= nil then
        PaGlobal_GuildWareHouseHistory:itemTooltipShow(0, wrapper:getItemEnchantKey():getItemKey(), wrapper:getItemEnchantKey():getEnchantLevel())
      end
    end
  elseif self._currentTabType == self._eTabType.MANSIONBUFF then
    self._ui._rdo_warehouse:SetCheck(false)
    self._ui._rdo_mansionBuff:SetCheck(true)
    self._ui._rdo_questAccept:SetCheck(false)
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMANORLOG_DESC"))
    selectBarSpanX = self._ui._rdo_mansionBuff:GetPosX() + self._ui._rdo_mansionBuff:GetSizeX() / 2
    self:updateList_MansionBuff()
    if Panel_GuildQuestInfo_All ~= nil then
      PaGlobal_GuildQuestInfo_Close_All()
    end
    if self._isConsole == true then
      UI.getChildControl(self._ui._stc_keyGuide, "StaticText_X"):SetShow(false)
      UI.getChildControl(self._ui._stc_keyGuide, "StaticText_A"):SetShow(false)
      local wrapper = ToClient_getGuildMansionBuffHistoryWrapper(0)
      if wrapper ~= nil then
        PaGlobal_GuildWareHouseHistory:itemTooltipShow(0, wrapper:getItemEnchantKey():getItemKey(), wrapper:getItemEnchantKey():getEnchantLevel())
      end
    end
  elseif self._currentTabType == self._eTabType.QUESTACCEPT then
    self._ui._rdo_warehouse:SetCheck(false)
    self._ui._rdo_mansionBuff:SetCheck(false)
    self._ui._rdo_questAccept:SetCheck(true)
    self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILDMISSIONLOG_DESC"))
    selectBarSpanX = self._ui._rdo_questAccept:GetPosX() + self._ui._rdo_questAccept:GetSizeX() / 2
    self:updateList_QuestAccept()
  else
    return
  end
  if self._isConsole == true then
    local firstContent = self._ui._list2_logList:GetContentByKey(self._ui._list2_logList:getKeyByIndex(0))
    if firstContent ~= nil then
      ToClient_padSnapChangeToTarget(UI.getChildControl(firstContent, "Static_SlotBg"))
    end
  end
  self._ui._stc_tabSelectBar:SetSpanSize(selectBarSpanX - self._ui._stc_tabSelectBar:GetSizeX() / 2, self._ui._stc_tabSelectBar:GetSpanSize().y)
  self._ui._stc_tabSelectBar:ComputePos()
end
function PaGlobal_GuildWareHouseHistory:updateList_Warehouse()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  local listManager = self._ui._list2_logList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  for ii = 0, ToClient_guildWareHouseHistoryCount() - 1 do
    listManager:pushKey(ii)
  end
  self._ui._list2_logList:ComputePos()
end
function PaGlobal_GuildWareHouseHistory:updateList_MansionBuff()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  local listManager = self._ui._list2_logList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  for ii = 0, ToClient_getGuildMansionBuffHistoryCount() - 1 do
    listManager:pushKey(ii)
  end
  self._ui._list2_logList:ComputePos()
end
function PaGlobal_GuildWareHouseHistory:updateList_QuestAccept()
  if Panel_Window_GuildWareHouseHistory == nil then
    return
  end
  local listManager = self._ui._list2_logList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  for ii = ToClient_getGuildQuestAcceptHistoryCount() - 1, 0, -1 do
    listManager:pushKey(ii)
  end
  self._ui._list2_logList:ComputePos()
end
