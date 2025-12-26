PaGlobal_MorningLand_DetailReward = {
  _ui = {
    _btn_Close = nil,
    _combo2_Boss = nil,
    _combo2_Difficulty = nil,
    _list2_RewardInfo = nil,
    _stc_ConsoleKeyBg = nil,
    _stc_Console_A = nil,
    _stc_Console_B = nil
  },
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createCash = true,
    createEnchant = true
  },
  _maxSlotCount = 5,
  _itemInfoTbl = {},
  _selectedBossGroupIndex = 0,
  _selectedLevel = 0,
  _selectedCharacterKeyRaw = 0,
  _isConsole = false,
  _initialize = false,
  _contentListTbl = {}
}
registerEvent("FromClient_luaLoadComplete", "PaGlobal_MorningLand_DetailReward_Init")
function PaGlobal_MorningLand_DetailReward_Init()
  PaGlobal_MorningLand_DetailReward:initialize()
end
function PaGlobal_MorningLand_DetailReward:initialize()
  if true == PaGlobal_MorningLand_DetailReward._initialize or nil == Panel_MorningLand_DatailReward then
    return
  end
  local titleBg = UI.getChildControl(Panel_MorningLand_DatailReward, "Static_TitleArea")
  self._ui._btn_Close = UI.getChildControl(titleBg, "Button_Close_PCUI")
  local contentsBg = UI.getChildControl(Panel_MorningLand_DatailReward, "Static_ContentsArea")
  self._ui._combo2_Boss = UI.getChildControl(contentsBg, "Combobox_Boss")
  self._ui._combo2_Difficulty = UI.getChildControl(contentsBg, "Combobox_Difficulty")
  self._ui._list2_RewardInfo = UI.getChildControl(contentsBg, "List2_RewardInfo")
  self._ui._stc_ConsoleKeyBg = UI.getChildControl(Panel_MorningLand_DatailReward, "Static_KeyGuide_ConsoleUI_Import")
  self._ui._stc_Console_A = UI.getChildControl(self._ui._stc_ConsoleKeyBg, "StaticText_A_ConsoleUI")
  self._ui._stc_Console_B = UI.getChildControl(self._ui._stc_ConsoleKeyBg, "StaticText_B_ConsoleUI")
  self._ui._stc_Console_X = UI.getChildControl(self._ui._stc_ConsoleKeyBg, "StaticText_X_ConsoleUI")
  self._ui._stc_Console_X:SetShow(false)
  local list2Content = UI.getChildControl(self._ui._list2_RewardInfo, "List2_1_Content")
  local list2Template = UI.getChildControl(list2Content, "Static_RewardList_Template")
  for idx = 0, self._maxSlotCount - 1 do
    local list2SlotItem = UI.getChildControl(list2Template, "Static_" .. tostring(idx))
    local itemSlot = {}
    SlotItem.new(itemSlot, "MorninLandRankingReward_", idx, list2SlotItem, self._slotConfig)
    itemSlot:createChild()
    itemSlot.icon:SetPosY(2)
    itemSlot.icon:SetPosX(2)
  end
  for index = 0, PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART2_BOSSCOUNT - 1 do
    local morningBossSSW = ToClient_getElementalMonsterInfo(index, 0)
    if morningBossSSW ~= nil and morningBossSSW:getIsBoss() == true then
      local characterKeyRaw = morningBossSSW:getCharacterKeyRaw()
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(characterKeyRaw)
      if characterStaticStatusWarpper ~= nil then
        local name = characterStaticStatusWarpper:getName()
        self._ui._combo2_Boss:AddItem(name)
      end
    end
  end
  for levelIdx = 0, __eMaxMorningLandMonsterLevel - 1 do
    self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(levelIdx)))
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    PaGlobalFunc_ConsoleKeyGuide_SetAlign({
      self._ui._stc_Console_A,
      self._ui._stc_Console_B
    }, self._ui._stc_ConsoleKeyBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    self._ui._btn_Close:SetShow(false)
  end
  PaGlobal_MorningLand_DetailReward:validate()
  PaGlobal_MorningLand_DetailReward:registEventHandler()
  PaGlobal_MorningLand_DetailReward._initialize = true
end
function PaGlobal_MorningLand_DetailReward:registEventHandler()
  if nil == Panel_MorningLand_DatailReward then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_MorningLand_DetailReward_Close()")
  self._ui._combo2_Difficulty:addInputEvent("Mouse_LUp", "HandleEventLUp_MorningLand_DetailReward_OpenComboBox(true)")
  self._ui._combo2_Difficulty:GetListControl():AddSelectEvent("HandleEventLUp_MorningLand_DetailReward_SelectComboBox(true)")
  self._ui._combo2_Boss:GetListControl():AddSelectEvent("HandleEventLUp_MorningLand_DetailReward_SelectComboBox(false)")
  self._ui._combo2_Boss:addInputEvent("Mouse_LUp", "HandleEventLUp_MorningLand_DetailReward_OpenComboBox(false)")
  self._ui._list2_RewardInfo:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_MorningBossRank_DetailReward")
  self._ui._combo2_Difficulty:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_DetailReward_SetIgnore()")
  self._ui._combo2_Boss:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_DetailReward_SetIgnore()")
  self._ui._list2_RewardInfo:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_MorningLand_DetailReward:prepareOpen()
  if nil == Panel_MorningLand_DatailReward then
    return
  end
  if self._isConsole == true then
    PaGlobal_MorningLand_DetailReward._ui._stc_Console_X:SetShow(false)
  end
  PaGlobal_MorningLand_DetailReward:open()
  PaGlobal_MorningLand_DetailReward:update()
  PaGlobalFunc_MorningLand_DetailReward_OnScreenResize()
  HandleEventOnOut_MorningLand_DetailReward_ShowTootipKeyGuide(false)
  Panel_Window_MorningLand_Boss_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self._contentListTbl = Array.new()
end
function PaGlobal_MorningLand_DetailReward:update()
  self._ui._list2_RewardInfo:getElementManager():clearKey()
  self._itemInfoTbl = {}
  local morningBossSSW = ToClient_getElementalMonsterInfo(self._selectedBossGroupIndex, self._selectedLevel)
  if morningBossSSW == nil then
    return
  end
  if morningBossSSW:getIsBoss() == false then
    return
  end
  local isMorningLandMonsterPart2 = morningBossSSW:getMorningLandMonsterPartRaw() == __eMorningLandMosterPart2
  self._selectedCharacterKeyRaw = morningBossSSW:getCharacterKeyRaw()
  local rewardCount = ToClient_getElementalMonsterRankRewardCount(self._selectedCharacterKeyRaw, isMorningLandMonsterPart2)
  local dataCount = 0
  for idx = 0, rewardCount - 1 do
    local itemKey = ToClient_getElementalMonsterRankRewardItemKeyByIndex(self._selectedCharacterKeyRaw, idx, isMorningLandMonsterPart2)
    local itemCount = ToClient_getElementalMonsterRankRewardCountByIndex(self._selectedCharacterKeyRaw, idx, isMorningLandMonsterPart2)
    local rewardRank = ToClient_getElementalMonsterRankRewardRankByIndex(self._selectedCharacterKeyRaw, idx, isMorningLandMonsterPart2)
    local tempTbl = {
      _rank = rewardRank,
      _itemKey = itemKey,
      _count = itemCount,
      _index = idx,
      _characterKey = self._selectedCharacterKeyRaw,
      _slotIcon = {},
      _itemKeyForTooltip = {}
    }
    self._itemInfoTbl[idx] = tempTbl
    self._ui._list2_RewardInfo:getElementManager():pushKey(idx)
    dataCount = dataCount + 1
  end
  if dataCount > 0 and isMorningLandMonsterPart2 == false then
    local tempTbl = {
      _rank = -1,
      _itemKey = ToClient_getElementalMonsterBaseRewardItemKey(self._selectedCharacterKeyRaw, isMorningLandMonsterPart2),
      _count = ToClient_getElementalMonsterBaseRewardItemCount(self._selectedCharacterKeyRaw, isMorningLandMonsterPart2),
      _index = dataCount,
      _characterKey = self._selectedCharacterKeyRaw,
      _slotIcon = {},
      _itemKeyForTooltip = {}
    }
    self._itemInfoTbl[dataCount] = tempTbl
    self._ui._list2_RewardInfo:getElementManager():pushKey(dataCount)
  end
  HandleEventLUp_MorningLand_DetailReward_SetIgnore()
end
function PaGlobal_MorningLand_DetailReward:open()
  if nil == Panel_MorningLand_DatailReward then
    return
  end
  Panel_MorningLand_DatailReward:SetShow(true)
end
function PaGlobal_MorningLand_DetailReward:prepareClose()
  if nil == Panel_MorningLand_DatailReward then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  Panel_Window_MorningLand_Boss_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_MorningLand_DetailReward:close()
end
function PaGlobal_MorningLand_DetailReward:close()
  if nil == Panel_MorningLand_DatailReward then
    return
  end
  Panel_MorningLand_DatailReward:SetShow(false)
end
function PaGlobalFunc_MorningLand_DetailReward_Open()
  PaGlobal_MorningLand_DetailReward._selectedBossGroupIndex = PaGlobalFunc_MorningBossRank_GetSelectedBossGroupIndex()
  PaGlobal_MorningLand_DetailReward._selectedLevel = PaGlobalFunc_MorningBossRank_GetSelectedLevel()
  PaGlobal_MorningLand_DetailReward._ui._combo2_Difficulty:SetSelectItemIndex(PaGlobal_MorningLand_DetailReward._selectedLevel)
  PaGlobal_MorningLand_DetailReward._ui._combo2_Boss:SetSelectItemIndex(PaGlobal_MorningLand_DetailReward._selectedBossGroupIndex)
  PaGlobal_MorningLand_DetailReward:prepareOpen()
end
function PaGlobalFunc_MorningLand_DetailReward_OnScreenResize()
  Panel_MorningLand_DatailReward:ComputePos()
end
function PaGlobalFunc_MorningLand_DetailReward_Close()
  PaGlobal_MorningLand_DetailReward:prepareClose()
end
function HandleEventLUp_MorningLand_DetailReward_SetIgnore()
  local self = PaGlobal_MorningLand_DetailReward
  local set = false
  if PaGlobal_MorningLand_DetailReward._ui._combo2_Difficulty:isClicked() or PaGlobal_MorningLand_DetailReward._ui._combo2_Boss:isClicked() then
    set = true
  end
  if self._isConsole == true then
    for contentIdx = 1, #self._contentListTbl do
      local content = self._contentListTbl[contentIdx]
      local bg = UI.getChildControl(content, "Static_RewardList_Template")
      for slotIdx = 0, self._maxSlotCount - 1 do
        local list2SlotItem = UI.getChildControl(bg, "Static_" .. tostring(slotIdx))
        list2SlotItem:SetIgnore(set)
      end
    end
  end
end
function HandleEventLUp_MorningLand_DetailReward_OpenComboBox(isSelectDiffculty)
  local self = PaGlobal_MorningLand_DetailReward
  if isSelectDiffculty == true then
    PaGlobal_MorningLand_DetailReward._ui._combo2_Difficulty:ToggleListbox()
  else
    PaGlobal_MorningLand_DetailReward._ui._combo2_Boss:ToggleListbox()
  end
  HandleEventLUp_MorningLand_DetailReward_SetIgnore()
end
function HandleEventLUp_MorningLand_DetailReward_SelectComboBox(isSelectDiffculty)
  local self = PaGlobal_MorningLand_DetailReward
  if isSelectDiffculty == true then
    local index = self._ui._combo2_Difficulty:GetSelectIndex()
    if self._selectedLevel ~= index then
      self._selectedLevel = index
    end
  else
    local index = self._ui._combo2_Boss:GetSelectIndex()
    if self._selectedBossGroupIndex ~= index then
      self._selectedBossGroupIndex = index
    end
    self._ui._combo2_Difficulty:DeleteAllItem()
    if index < PaGlobal_MorningLand_Boss_All._MORNINGLAND_PART1_BOSSCOUNT then
      self._ui._combo2_Difficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(self._selectedLevel)))
      for levelIdx = 0, __eMaxMorningLandMonsterLevel - 1 do
        self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(levelIdx)))
      end
    else
      self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
      self._ui._combo2_Difficulty:AddItem(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
      if self._selectedLevel >= 2 then
        self._selectedLevel = 0
      end
      if self._selectedLevel == 0 then
        self._ui._combo2_Difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
      elseif self._selectedLevel == 1 then
        self._ui._combo2_Difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
      end
    end
  end
  PaGlobal_MorningLand_DetailReward:update()
end
function FromClient_MorningBossRank_DetailReward(content, key)
  local self = PaGlobal_MorningLand_DetailReward
  local index = Int64toInt32(key)
  local infoTable = self._itemInfoTbl[index]
  if infoTable == nil then
    return
  end
  local itemKey = infoTable._itemKey
  local itemCount = infoTable._count
  local rank = infoTable._rank
  local prevRankString = ""
  local rankString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", rank)
  if rank > 1 then
    if self._itemInfoTbl[index - 1] ~= nil then
      prevRankString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_RANK", "rank", self._itemInfoTbl[index - 1]._rank + 1) .. " "
    end
    rankString = prevRankString .. "~ " .. rankString
  elseif -1 == rank then
    rankString = PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_OUTOFRANKREWARD")
  end
  local bg = UI.getChildControl(content, "Static_RewardList_Template")
  local txt_rank = UI.getChildControl(bg, "StaticText_Rank")
  txt_rank:SetText(rankString)
  ToClient_getItemBundleCountWithSort(itemKey)
  for slotIdx = 0, self._maxSlotCount - 1 do
    local list2SlotItem = UI.getChildControl(bg, "Static_" .. tostring(slotIdx))
    list2SlotItem:SetShow(false)
    local itemWrapper = ToClient_getItemBundleCountByIndex(itemKey, slotIdx)
    if itemWrapper ~= nil then
      list2SlotItem:SetShow(true)
      local itemSlot = {}
      SlotItem.reInclude(itemSlot, "MorninLandRankingReward_", slotIdx, list2SlotItem, self._slotConfig)
      itemSlot:setItemByStaticStatus(itemWrapper)
      if self._isConsole == false then
        itemSlot.icon:addInputEvent("Mouse_On", "HandleEventLUp_MorningLand_DetailReward_Tooltip(" .. tostring(index) .. "," .. tostring(slotIdx) .. "," .. tostring(false) .. ")")
        itemSlot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_MorningLand_DetailReward_Tooltip(" .. tostring(index) .. "," .. tostring(slotIdx) .. "," .. tostring(true) .. ")")
      else
        list2SlotItem:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_MorningLand_DetailReward_Tooltip(" .. tostring(index) .. "," .. tostring(slotIdx) .. "," .. tostring(false) .. ")")
        list2SlotItem:addInputEvent("Mouse_On", "HandleEventOnOut_MorningLand_DetailReward_ShowTootipKeyGuide(true)")
        list2SlotItem:addInputEvent("Mouse_Out", "HandleEventOnOut_MorningLand_DetailReward_ShowTootipKeyGuide(false)")
      end
      infoTable._slotIcon[slotIdx] = itemSlot.icon
      infoTable._itemKeyForTooltip[slotIdx] = itemWrapper:get()._key
    end
  end
  self._contentListTbl:push_back(content)
end
function HandleEventOnOut_MorningLand_DetailReward_ShowTootipKeyGuide(isOn)
  PaGlobal_MorningLand_DetailReward._ui._stc_Console_X:SetShow(isOn)
  PaGlobalFunc_ConsoleKeyGuide_SetAlign({
    PaGlobal_MorningLand_DetailReward._ui._stc_Console_X,
    PaGlobal_MorningLand_DetailReward._ui._stc_Console_A,
    PaGlobal_MorningLand_DetailReward._ui._stc_Console_B
  }, PaGlobal_MorningLand_DetailReward._ui._stc_ConsoleKeyBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function HandleEventLUp_MorningLand_DetailReward_Tooltip(index, slotIdx, isHide)
  if PaGlobal_MorningLand_DetailReward._isConsole == false then
    if isHide == true then
      Panel_Tooltip_Item_hideTooltip()
      return
    end
  elseif _ContentsGroup_RenewUI == true then
    if true == Panel_Widget_Tooltip_Renew:GetShow() then
      PaGlobalFunc_TooltipInfo_Close()
      return
    end
  elseif Panel_Tooltip_Item:GetShow() == true then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  if PaGlobal_MorningLand_DetailReward._itemInfoTbl[index] == nil then
    return
  end
  local itemKey = PaGlobal_MorningLand_DetailReward._itemInfoTbl[index]._itemKeyForTooltip[slotIdx]
  if itemKey == nil then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(itemKey)
  if itemSSW == nil then
    return
  end
  local itemSlotControl = PaGlobal_MorningLand_DetailReward._itemInfoTbl[index]._slotIcon[slotIdx]
  if itemSlotControl == nil then
    return
  end
  if _ContentsGroup_RenewUI == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
  else
    Panel_Tooltip_Item_Show(itemSSW, Panel_MorningLand_DatailReward, true, false)
  end
end
function PaGlobal_MorningLand_DetailReward:validate()
  if nil == Panel_MorningLand_DatailReward then
    return
  end
  self._ui._btn_Close:isValidate()
  self._ui._combo2_Boss:isValidate()
  self._ui._combo2_Difficulty:isValidate()
  self._ui._list2_RewardInfo:isValidate()
  self._ui._stc_ConsoleKeyBg:isValidate()
  self._ui._stc_Console_A:isValidate()
  self._ui._stc_Console_B:isValidate()
end
