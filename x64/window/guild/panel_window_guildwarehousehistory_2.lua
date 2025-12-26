function FromClient_getGuildWareHouseMansionBuffQuestAcceptHistory()
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  self:open()
end
function PaGlobal_GuildWareHouseHistory_CreateControlList2(content, key)
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  local index = Int64toInt32(key)
  local wrapper
  local txt_info = UI.getChildControl(content, "StaticText_Content")
  local txt_date = UI.getChildControl(content, "StaticText_Date")
  local slotBg = UI.getChildControl(content, "Static_SlotBg")
  local iconGroup = UI.getChildControl(slotBg, "Static_ItemIcon")
  local itemCount = UI.getChildControl(slotBg, "StaticText_ItemCount")
  local itemIcon = UI.getChildControl(iconGroup, "Static_GuildHistory_ItemIcon_")
  local itemEnchant = UI.getChildControl(itemIcon, "StaticText_GuildHistory_ItemIcon__Enchant")
  local itemBorder = UI.getChildControl(itemIcon, "Static_GuildHistory_ItemIcon__Border")
  content:SetIgnore(true)
  if self._currentTabType == self._eTabType.WAREHOUSE then
    wrapper = ToClient_guildWareHouseHistoryWrapper(index)
  elseif self._currentTabType == self._eTabType.MANSIONBUFF then
    wrapper = ToClient_getGuildMansionBuffHistoryWrapper(index)
  elseif self._currentTabType == self._eTabType.QUESTACCEPT then
    wrapper = ToClient_getGuildQuestAcceptHistoryWrapper(index)
  else
    return
  end
  if wrapper == nil then
    return
  end
  local txt = ""
  if self._currentTabType == self._eTabType.QUESTACCEPT then
    local questNo = wrapper:getGuildQuestNo()
    txt = ToClient_GetGuildQuestNameByQuestNo(questNo)
    local paTime = PATime(wrapper:getRegisterDate())
    local hour = tostring(paTime:GetHour())
    local minute = tostring(paTime:GetMinute())
    if paTime:GetHour() < 10 then
      hour = "0" .. hour
    end
    if paTime:GetMinute() < 10 then
      minute = "0" .. minute
    end
    local registerDate = tostring(paTime:GetYear()) .. "." .. tostring(paTime:GetMonth()) .. "." .. tostring(paTime:GetDay()) .. " " .. hour .. ":" .. minute
    local dateString = ""
    if wrapper:isComplete() == true then
      dateString = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUESTLOG_RECEIVEMEMBER", "familyName", wrapper:getUserNickName(), "date", registerDate)
    elseif wrapper:isGiveUp() == true then
      dateString = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUESTLOG_GIVEUPMEMBER", "familyName", wrapper:getUserNickName(), "date", registerDate)
    else
      dateString = PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_GUILDQUESTLOG_ACCEPTMEMBER", "familyName", wrapper:getUserNickName(), "date", registerDate)
    end
    txt_date:SetText(dateString)
    slotBg:addInputEvent("Mouse_On", "")
    slotBg:addInputEvent("Mouse_Out", "")
    itemIcon:addInputEvent("Mouse_On", "")
    itemIcon:addInputEvent("Mouse_Out", "")
    slotBg:SetIgnore(not self._isConsole)
    itemIcon:SetIgnore(false)
    txt_info:SetIgnore(false)
    txt_date:SetIgnore(false)
    itemEnchant:SetShow(false)
    itemCount:SetShow(false)
    itemBorder:SetShow(false)
    itemIcon:ChangeTextureInfoNameAsync(ToClient_GetGuildQuestIconPathByQuestNo(questNo))
    if _ContentsGroup_RenewUI == true then
      UI.getChildControl(self._ui._stc_keyGuide, "StaticText_X"):SetShow(true)
      slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All_ByQuestNo(" .. questNo .. ", " .. index .. ")")
    else
      UI.getChildControl(self._ui._stc_keyGuide, "StaticText_A"):SetShow(true)
    end
    itemIcon:addInputEvent("Mouse_LUp", "PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All_ByQuestNo(" .. questNo .. ", " .. index .. ")")
    txt_info:addInputEvent("Mouse_LUp", "PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All_ByQuestNo(" .. questNo .. ", " .. index .. ")")
    txt_date:addInputEvent("Mouse_LUp", "PaGlobal_GuildQuestInfo_NonProgressingQuest_Open_All_ByQuestNo(" .. questNo .. ", " .. index .. ")")
  else
    local itemSSW = getItemEnchantStaticStatus(wrapper:getItemEnchantKey())
    if itemSSW ~= nil then
      local slot = {}
      local itemStatic = itemSSW:get()
      local enchantLevel = itemStatic._key:getEnchantLevel()
      SlotItem.reInclude(slot, "GuildHistory_ItemIcon_", 0, iconGroup, self._slotConfig)
      slot:setItemByStaticStatus(itemSSW)
      slotBg:SetIgnore(not self._isConsole)
      slot.icon:SetIgnore(false)
      txt_info:SetIgnore(true)
      txt_date:SetIgnore(true)
      slot.icon:addInputEvent("Mouse_LUp", "")
      txt_info:addInputEvent("Mouse_LUp", "")
      txt_date:addInputEvent("Mouse_LUp", "")
      if _ContentsGroup_RenewUI_Tooltip == true then
        slot.icon:addInputEvent("Mouse_On", "HandleEventRUp_GuildWareHouseHistory_ShowFloatingTooltip(true," .. index .. "," .. wrapper:getItemEnchantKey():get() .. ")")
        slot.icon:addInputEvent("Mouse_Out", "HandleEventRUp_GuildWareHouseHistory_ShowFloatingTooltip(false)")
        slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventRUp_GuildWareHouseHistory_ShowDetailTooltip(" .. wrapper:getItemEnchantKey():get() .. ")")
      elseif self._isConsole == true then
        slot.icon:addInputEvent("Mouse_On", "PaGlobal_GuildWareHouseHistory:itemTooltipShow(" .. index .. "," .. wrapper:getItemEnchantKey():getItemKey() .. "," .. wrapper:getItemEnchantKey():getEnchantLevel() .. ")")
        slot.icon:addInputEvent("Mouse_Out", "PaGlobal_GuildWareHouseHistory:itemTooltipHide()")
      else
        slot.icon:addInputEvent("Mouse_On", "PaGlobal_GuildWareHouseHistory:itemTooltipShow(" .. index .. "," .. wrapper:getItemEnchantKey():getItemKey() .. "," .. wrapper:getItemEnchantKey():getEnchantLevel() .. ")")
        slot.icon:addInputEvent("Mouse_Out", "PaGlobal_GuildWareHouseHistory:itemTooltipHide()")
      end
      itemCount:SetText(tostring(wrapper:getItemCount()))
      if self._currentTabType == self._eTabType.WAREHOUSE then
        if wrapper:isPush() == true then
          txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_PUSH", "userNickName", wrapper:getUserNickName())
        else
          txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_WAREHOUSE_HISTORY_POP", "userNickName", wrapper:getUserNickName())
        end
      elseif self._currentTabType == self._eTabType.MANSIONBUFF then
        local buffHistoryType = wrapper:getBuffHistoryType()
        if buffHistoryType == __eGuildMansionBuffHistoryType_Install then
          txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_MANSION_BUFF_HISTORY_INSTALL", "userNickName", wrapper:getUserNickName())
        elseif buffHistoryType == __eGuildMansionBuffHistoryType_TakeBack then
          txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_MANSION_BUFF_HISTORY_TAKEBACK", "userNickName", wrapper:getUserNickName())
        elseif buffHistoryType == __eGuildMansionBuffHistoryType_Use then
          txt = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILD_MANSION_BUFF_HISTORY_USE", "userNickName", wrapper:getUserNickName())
        else
          txt = ""
        end
      end
    end
    local paTime = PATime(wrapper:getRegisterDate())
    local registerDate = tostring(paTime:GetYear()) .. "." .. tostring(paTime:GetMonth()) .. "." .. tostring(paTime:GetDay())
    txt_date:SetText(registerDate)
    itemEnchant:SetShow(true)
    itemCount:SetShow(true)
  end
  UI.setLimitTextAndAddTooltip(txt_date, txt_date:GetText())
  txt_info:SetText(txt)
  UI.setLimitTextAndAddTooltip(txt_info, txt_info:GetText())
end
function HandleEventRUp_GuildWareHouseHistory_ShowFloatingTooltip(isShow, index, itemEnchantKey)
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  if isShow == false then
    PaGlobalFunc_FloatingTooltip_Close()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if itemSSW ~= nil then
    local content = self._ui._list2_logList:GetContentByKey(index)
    local slotBg = UI.getChildControl(content, "Static_SlotBg")
    PaGlobalFunc_FloatingTooltip_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, slotBg, "WareHouse")
  end
end
function HandleEventRUp_GuildWareHouseHistory_ShowDetailTooltip(itemEnchantKey)
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  if PaGlobalFunc_TooltipInfo_GetShow() == true then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  if itemSSW ~= nil then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
    PaGlobalFunc_FloatingTooltip_Close()
  end
end
function HandleEventPadLBRB_GuildWareHouseHistory_ChangeTab(isLeft)
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  if isLeft == nil then
    return
  end
  local nextTabType = self._currentTabType
  if isLeft == true then
    nextTabType = (nextTabType + 2) % 3
    self:selectTab(nextTabType)
  else
    nextTabType = (nextTabType + 1) % 3
    self:selectTab(nextTabType)
  end
end
function PaGlobalFunc_GuildWareHouseHistory_SetTab(tabType)
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  if tabType ~= self._eTabType.WAREHOUSE and tabType ~= self._eTabType.MANSIONBUFF and tabType ~= self._eTabType.QUESTACCEPT then
    UI.ASSERT_NAME(false, "GuildWareHouseHistory UI\236\157\152 \237\131\173 \237\131\128\236\158\133\236\157\180 \235\185\132\236\160\149\236\131\129\236\157\180\235\139\164. \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\235\130\152?", "\236\157\180\236\163\188")
    return
  end
  self._currentTabType = tabType
end
function PaGlobalFunc_GuildWareHouseHistory_Close()
  local self = PaGlobal_GuildWareHouseHistory
  if self == nil then
    return
  end
  self:close()
end
