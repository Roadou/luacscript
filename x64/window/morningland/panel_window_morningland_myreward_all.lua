PaGlobal_MorningMyReward = {
  _ui = {
    _btn_Close = nil,
    _stc_Template = nil,
    _btn_GetReward = nil,
    _stc_NoReward = nil,
    _stc_ConsoleBg = nil,
    _stc_Console_A = nil,
    _stc_Console_B = nil,
    _stc_Console_X = nil,
    _frame_List = nil,
    _frame_Content = nil,
    _frame_Scroll = nil,
    _rewardList = Array.new()
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true
  },
  _maxListCount = __eElementalMonsterWeekLimit + __eElementalMonsterPart2WeekLimit + __eElementalMonsterPart2WeekLimit,
  _itemMaxListCount = __eElementalMonsterWeekLimit,
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MorningLand_MyReward_Init")
function FromClient_MorningLand_MyReward_Init()
  PaGlobal_MorningMyReward:initialize()
end
function PaGlobal_MorningMyReward:initialize()
  if true == PaGlobal_MorningMyReward._initialize or nil == Panel_MorningLand_MyReward_All then
    return
  end
  local titleBg = UI.getChildControl(Panel_MorningLand_MyReward_All, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(titleBg, "Button_Close_PCUI")
  self._ui._frame_List = UI.getChildControl(Panel_MorningLand_MyReward_All, "Frame_TData_List")
  self._ui._frame_Content = UI.getChildControl(self._ui._frame_List, "Frame_1_Content")
  self._ui._frame_Content:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_MyReward_Tooltip(0,0," .. tostring(true) .. ")")
  self._ui._stc_Template = UI.getChildControl(self._ui._frame_Content, "Static_TRow_Template")
  self._ui._frame_Content:SetIgnore(false)
  self._ui._frame_Content:addInputEvent("Mouse_DownScroll", "MorningMyReward_ScrollEvent( true )")
  self._ui._frame_Content:addInputEvent("Mouse_UpScroll", "MorningMyReward_ScrollEvent( false )")
  self._ui._frame_Scroll = UI.getChildControl(self._ui._frame_List, "Frame_1_VerticalScroll")
  self._ui._frame_Scroll:SetInterval(__eElementalMonsterWeekLimit)
  for idx = 1, self._maxListCount do
    local tempTable = {
      _bg = nil,
      _txt_DiffAndBossName = nil,
      _txt_Rank = nil,
      _txt_Time = nil,
      _txt_IconSlot = Array.new(),
      _itemKeyForTooltip = Array.new()
    }
    if idx == 1 then
      tempTable._bg = self._ui._stc_Template
      tempTable._txt_DiffAndBossName = UI.getChildControl(self._ui._stc_Template, "StaticText_TD_Difficulty_0")
      tempTable._txt_Rank = UI.getChildControl(self._ui._stc_Template, "StaticText_TD_Rank_0")
      tempTable._txt_Time = UI.getChildControl(self._ui._stc_Template, "StaticText_TD_Time_0")
      for subIdx = 1, self._itemMaxListCount do
        local tempIcon = UI.getChildControl(self._ui._stc_Template, "Static_" .. tostring(subIdx - 1))
        local itemSlot = {}
        SlotItem.new(itemSlot, "MorninLandRankingMyReward_", idx, tempIcon, self._slotConfig)
        itemSlot:createChild()
        tempTable._txt_IconSlot:push_back(tempIcon)
      end
      self._ui._rewardList:push_back(tempTable)
    else
      local clonedBg = UI.cloneControl(self._ui._stc_Template, self._ui._frame_Content, "Static_TRow_Template_" .. tostring(idx))
      clonedBg:SetSpanSize(clonedBg:GetSpanSize().x, self._ui._stc_Template:GetSizeY() * (idx - 1))
      tempTable._bg = clonedBg
      tempTable._txt_DiffAndBossName = UI.getChildControl(clonedBg, "StaticText_TD_Difficulty_0")
      tempTable._txt_Rank = UI.getChildControl(clonedBg, "StaticText_TD_Rank_0")
      tempTable._txt_Time = UI.getChildControl(clonedBg, "StaticText_TD_Time_0")
      for subIdx = 1, self._itemMaxListCount do
        local tempIcon = UI.getChildControl(clonedBg, "Static_" .. tostring(subIdx - 1))
        tempTable._txt_IconSlot:push_back(tempIcon)
      end
      self._ui._rewardList:push_back(tempTable)
    end
  end
  self._ui._btn_GetReward = UI.getChildControl(Panel_MorningLand_MyReward_All, "Button_Get_Reward")
  self._ui._stc_NoReward = UI.getChildControl(Panel_MorningLand_MyReward_All, "StaticText_NoStatic")
  self._ui._stc_ConsoleBg = UI.getChildControl(Panel_MorningLand_MyReward_All, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._stc_Console_A = UI.getChildControl(self._ui._stc_ConsoleBg, "StaticText_B_ConsoleUI")
  self._ui._stc_Console_B = UI.getChildControl(self._ui._stc_ConsoleBg, "StaticText_A_ConsoleUI")
  self._ui._stc_Console_X = UI.getChildControl(self._ui._stc_ConsoleBg, "StaticText_X_ConsoleUI")
  Panel_MorningLand_MyReward_All:ignorePadSnapMoveToOtherPanel()
  PaGlobal_MorningMyReward:validate()
  PaGlobal_MorningMyReward:registEventHandler()
  PaGlobal_MorningMyReward:swichPlatform(self._isConsole)
  PaGlobal_MorningMyReward._initialize = true
end
function PaGlobal_MorningMyReward:registEventHandler()
  if nil == Panel_MorningLand_MyReward_All then
    return
  end
  registerEvent("FromClient_setElementalMonsterRewardInfo", "FromClient_CloseElementalMonsterRewardInfo")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningMyReward_Close()")
  self._ui._btn_GetReward:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningMyReward_GetReward()")
end
function PaGlobal_MorningMyReward:swichPlatform(isConsole)
  self._ui._stc_ConsoleBg:SetShow(isConsole)
  self._ui._btn_Close:SetShow(not isConsole)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    self._ui._stc_Console_X,
    self._ui._stc_Console_A,
    self._ui._stc_Console_B
  }, self._ui._stc_ConsoleBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui._stc_ConsoleBg:ComputePos()
end
function PaGlobal_MorningMyReward:prepareOpen()
  if nil == Panel_MorningLand_MyReward_All then
    return
  end
  local size = ToClient_ElementalBossRewardInfoCount()
  self._ui._frame_List:SetShow(size > 0)
  self._ui._stc_NoReward:SetShow(size <= 0)
  self._ui._btn_GetReward:SetShow(size > 0)
  PaGlobal_MorningMyReward:open()
  if size <= 0 then
    return
  end
  PaGlobal_MorningMyReward:update(size)
  PaGlobalFunc_MorningBossRank_OnScreenResize()
end
function PaGlobal_MorningMyReward:open()
  Panel_MorningLand_MyReward_All:SetShow(true)
end
function PaGlobal_MorningMyReward:prepareClose()
  PaGlobal_MorningLand_Boss_All_UpdateRewardAble()
  PaGlobal_MorningMyReward:close()
  if _ContentsGroup_RenewUI == true then
    if PaGlobalFunc_TooltipInfo_GetShow() == true then
      PaGlobalFunc_TooltipInfo_Close()
    end
  elseif Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_MorningMyReward:close()
  Panel_MorningLand_MyReward_All:SetShow(false)
end
function PaGlobal_MorningMyReward:update(size)
  for idx = 1, self._maxListCount do
    self._ui._rewardList[idx]._bg:SetShow(false)
  end
  self._ui._frame_Content:SetSize(self._ui._frame_Content:GetSizeX(), 82 * size)
  for idx = 1, size do
    local info = ToClient_ElementalBossRewardInfoCountIndex(idx - 1)
    self._ui._rewardList[idx]._bg:SetShow(info ~= nil)
    if info ~= nil then
      local monsterKey = info:getCharacterKey()
      local recordTick = info:getRecordTick64()
      local rankIndex = info:getRankIndex()
      local stageLevel = info:getConquestLevel()
      local monsterName = ""
      local isGuildReward = info:isGuildReward()
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(monsterKey)
      local isMorningLandMonsterPart2 = info:getMorningLandMonsterPart() == __eMorningLandMosterPart2
      if characterStaticStatusWarpper ~= nil then
        monsterName = characterStaticStatusWarpper:getName()
      end
      local time32 = convertThirdSecondsToClockTime(Int64toInt32(recordTick) / 1000)
      self._ui._rewardList[idx]._txt_DiffAndBossName:SetTextMode(__eTextMode_AutoWrap)
      self._ui._rewardList[idx]._txt_DiffAndBossName:SetText(monsterName .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(stageLevel)))
      if isMorningLandMonsterPart2 == true then
        if stageLevel == 0 then
          self._ui._rewardList[idx]._txt_DiffAndBossName:SetText(monsterName .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
        elseif stageLevel == 1 then
          self._ui._rewardList[idx]._txt_DiffAndBossName:SetText(monsterName .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
        end
      end
      local rankString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", rankIndex)
      if isGuildReward == true then
        rankString = rankString .. " (" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GUILD_RANK_TITLE") .. ")"
      end
      self._ui._rewardList[idx]._txt_Rank:SetText(rankString)
      self._ui._rewardList[idx]._txt_Time:SetText(time32)
      local itemKey = ToClient_getElementalMonsterRankRewardItemKey(monsterKey, rankIndex, isGuildReward)
      local subItemCount = ToClient_getItemBundleCountWithSort(itemKey)
      for subIdx = 1, self._itemMaxListCount do
        local itemWrapper = ToClient_getItemBundleCountByIndex(itemKey, subIdx - 1)
        self._ui._rewardList[idx]._txt_IconSlot[subIdx]:SetShow(itemWrapper ~= nil)
        if itemWrapper ~= nil then
          self._ui._rewardList[idx]._itemKeyForTooltip[subIdx] = itemWrapper:get()._key
          local itemSlot = {}
          SlotItem.reInclude(itemSlot, "MorninLandRankingMyReward_", slotIdx, self._ui._rewardList[idx]._txt_IconSlot[subIdx], self._slotConfig)
          itemSlot:setItemByStaticStatus(itemWrapper)
          if self._isConsole == true then
            self._ui._rewardList[idx]._txt_IconSlot[subIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MorningLand_MyReward_Tooltip(" .. tostring(idx) .. "," .. tostring(subIdx) .. ",false)")
          else
            itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_MyReward_Tooltip(" .. tostring(idx) .. "," .. tostring(subIdx) .. ",false)")
            itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_MorningLand_MyReward_Tooltip(" .. tostring(idx) .. "," .. tostring(subIdx) .. ",true)")
          end
        end
      end
    end
  end
  self._ui._frame_List:UpdateContentScroll()
  self._ui._frame_Scroll:SetControlTop()
  self._ui._frame_List:UpdateContentPos()
end
function PaGlobalFunc_MorningMyReward_Open()
  PaGlobal_MorningMyReward:prepareOpen()
end
function PaGlobalFunc_MorningMyReward_Close()
  PaGlobal_MorningMyReward:prepareClose()
end
function PaGlobalFunc_MorningMyReward_GetReward()
  ToClient_GetElementalMonsterReward()
end
function PaGlobalFunc_MorningMyReward_OnScreenResize()
  if Panel_MorningLand_MyReward_All == nil then
    return
  end
  Panel_MorningLand_MyReward_All:ComputePos()
end
function HandleEventLUp_MorningLand_MyReward_Tooltip(index, slotIdx, isHide)
  if PaGlobal_MorningMyReward._isConsole == true then
    if _ContentsGroup_RenewUI == true then
      if PaGlobalFunc_TooltipInfo_GetShow() == true then
        PaGlobalFunc_TooltipInfo_Close()
        return
      end
    elseif Panel_Tooltip_Item:GetShow() == true then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
  elseif isHide == true then
    Panel_Tooltip_Item_hideTooltip()
  end
  if PaGlobal_MorningMyReward._ui._rewardList[index] == nil then
    return
  end
  local itemKey = PaGlobal_MorningMyReward._ui._rewardList[index]._itemKeyForTooltip[slotIdx]
  if itemKey == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if itemSSW == nil then
    return
  end
  local itemSlotControl = PaGlobal_MorningMyReward._ui._rewardList[index]._txt_IconSlot[slotIdx]
  if itemSlotControl == nil then
    return
  end
  if _ContentsGroup_RenewUI == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, itemSlotControl, true, false)
  end
end
function FromClient_ElementalMonsterMyRewardLoaded()
  PaGlobal_MorningMyReward:prepareOpen()
end
function FromClient_CloseElementalMonsterRewardInfo()
  if Panel_MorningLand_MyReward_All == nil then
    return
  end
  local size = ToClient_ElementalBossRewardInfoCount()
  if size == 0 and Panel_MorningLand_MyReward_All:GetShow() == true then
    PaGlobal_MorningMyReward:prepareClose()
  end
end
function MorningMyReward_ScrollEvent(isDown)
  local self = HarvestList
  if self == nil then
    return
  end
  if isDown then
    self._ui._frame_Scroll:ControlButtonDown()
  else
    self._ui._frame_Scroll:ControlButtonUp()
  end
  self._ui._frame_List:UpdateContentScroll()
end
function PaGlobal_MorningMyReward:validate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_Template:isValidate()
  self._ui._btn_GetReward:isValidate()
  self._ui._stc_NoReward:isValidate()
  self._ui._stc_ConsoleBg:isValidate()
  self._ui._stc_Console_A:isValidate()
  self._ui._stc_Console_B:isValidate()
  self._ui._frame_List:isValidate()
end
