function PaGlobal_ImperialSupplyMSG:initialize()
  if PaGlobal_ImperialSupplyMSG._initialize == true then
    return
  end
  PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_BottomBG")
  PaGlobal_ImperialSupplyMSG._ui._stc_background = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_BackBlackBG")
  PaGlobal_ImperialSupplyMSG._ui._stc_effectShow = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_1")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot1 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot1")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot2 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot2")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot3 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot3")
  PaGlobal_ImperialSupplyMSG._ui._stc_slot4 = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_Slot4")
  PaGlobal_ImperialSupplyMSG._ui._stc_forEffect = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomBG, "Static_ForEffect")
  PaGlobal_ImperialSupplyMSG._ui._stc_moneyBG = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_DescEdge")
  PaGlobal_ImperialSupplyMSG._ui._stc_money = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_moneyBG, "StaticText_Desc")
  PaGlobal_ImperialSupplyMSG._ui._btn_supply = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Button_Supply")
  PaGlobal_ImperialSupplyMSG._ui._stc_title = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_TitleArea")
  PaGlobal_ImperialSupplyMSG._ui._btn_X = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_title, "Button_Close")
  PaGlobal_ImperialSupplyMSG._ui._btn_close = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Button_Cancel")
  PaGlobal_ImperialSupplyMSG._ui._stc_bottomDescBG = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_BottomDesc")
  PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_bottomDescBG, "StaticText_Desc")
  PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_BOTTOM_DESC"))
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg = UI.getChildControl(Panel_ImperialSupply_Horse_Confirm, "Static_KeyGuide_ConsoleUI_Import")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_B = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_A = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_X = UI.getChildControl(PaGlobal_ImperialSupplyMSG._ui._stc_keyGuideBg, "StaticText_X_ConsoleUI")
  PaGlobal_ImperialSupplyMSG:controlSetShow()
  if nil ~= self._ui._stc_slot1 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot1
    SlotItem.new(slot, "ItemSlot1", 0, self._ui._stc_slot1, self._slotConfig)
    slot:createChild()
    self._SlotList[1] = slot
  end
  if nil ~= self._ui._stc_slot2 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot2
    SlotItem.new(slot, "ItemSlot2", 0, self._ui._stc_slot2, self._slotConfig)
    slot:createChild()
    self._SlotList[2] = slot
  end
  if nil ~= self._ui._stc_slot3 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot3
    SlotItem.new(slot, "ItemSlot3", 0, self._ui._stc_slot3, self._slotConfig)
    slot:createChild()
    self._SlotList[3] = slot
  end
  if nil ~= self._ui._stc_slot4 then
    local slot = {}
    slot.slotBg = self._ui._stc_slot4
    SlotItem.new(slot, "ItemSlot4", 0, self._ui._stc_slot4, self._slotConfig)
    slot:createChild()
    self._SlotList[4] = slot
  end
  PaGlobal_ImperialSupplyMSG:registEventHandler()
  PaGlobal_ImperialSupplyMSG:validate()
  PaGlobal_ImperialSupplyMSG._initialize = true
end
function PaGlobal_ImperialSupplyMSG:registEventHandler()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  PaGlobal_ImperialSupplyMSG._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ImperialSupplyMSG:close()")
  PaGlobal_ImperialSupplyMSG._ui._btn_X:addInputEvent("Mouse_LUp", "PaGlobal_ImperialSupplyMSG:close()")
  PaGlobal_ImperialSupplyMSG._ui._btn_supply:addInputEvent("Mouse_LUp", "PaGlobal_ImperialSupplyMSG:SupplyMsg()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_ImperialSupply_Horse_Confirm:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_ImperialSupplyMSG:SupplyMsg()")
  end
  registerEvent("FromClient_LuaTimer_UpdatePerFrame", "PaGlobal_ImperialSupplyMSG_CheckTime")
end
function PaGlobal_ImperialSupplyMSG:prepareOpen()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  if _ContentsGroup_UsePadSnapping == false then
    self._ui._btn_supply:SetMonoTone(false)
    self._ui._btn_supply:SetIgnore(false)
    self._ui._btn_supply:SetShow(true)
    self._ui._btn_close:SetMonoTone(false)
    self._ui._btn_close:SetIgnore(false)
    self._ui._btn_close:SetSize(235, 40)
    self._ui._btn_close:SetSpanSize(120, 525)
    self._ui._btn_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CANCEL"))
  else
    PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y:SetShow(true)
    local keyGuide = {
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_B,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_A,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_X
    }
    Panel_ImperialSupply_Horse_Confirm:ComputePosAllChild()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self._rewardItemKeyList = {}
  self._treasureComponentItemkey = nil
  local servantInfo = PaGlobalFunc_ServantList_All_ServantInfo()
  self._horseTier = servantInfo:getTier()
  self._isUsedAnyAddStatItem = servantInfo:isUsedAnyAddStatItem()
  self._sellCost = servantInfo:getSellCost_s64()
  self._isMutationHorse = servantInfo:getVehicleSubType() == __eTVehicleSubType_MutationHorse
  self._treasureComponentItemkey = nil
  self._isTreasureSlotShow = false
  self._isEffectShowing = false
  self._elapsedTime = 0
  PaGlobal_ImperialSupplyMSG:open()
end
function PaGlobal_ImperialSupplyMSG:open()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  Panel_ImperialSupply_Horse_Confirm:SetShow(true)
end
function PaGlobal_ImperialSupplyMSG:prepareClose()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  PaGlobal_ImperialSupplyMSG:close()
end
function PaGlobal_ImperialSupplyMSG:close()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
  if self._isEffectShowing == true then
    return
  end
  Panel_ImperialSupply_Horse_Confirm:SetShow(false)
end
function PaGlobal_ImperialSupplyMSG:SupplyMsg()
  if self._treasureComponentItemkey ~= nil then
    return
  end
  local _title = PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_TEXT_TITLE")
  local _desc = PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALMSG_DESC")
  if self._isUsedAnyAddStatItem == true then
    _desc = _desc .. [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_BUFF_USE_WARN")
  end
  messageboxData = {
    title = _title,
    content = _desc,
    functionYes = PaGlobal_ImperialSupplyMSG_SoupplyHorse,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function PaGlobal_ImperialSupplyMSG:update()
  local resultMoney = makeDotMoney(self._sellCost)
  PaGlobal_ImperialSupplyMSG._ui._stc_money:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_MONEY", "money", resultMoney))
  PaGlobal_ImperialSupplyMSG:setRewardItems()
  PaGlobal_ImperialSupplyMSG:setTreasureComponentReward()
  PaGlobal_ImperialSupplyMSG:setSlots()
end
function PaGlobal_ImperialSupplyMSG:MouseLupEvent_supplyHorse()
  local currentServantNo = PaGlobalFunc_ServantList_All_CurrentSelectSlotNo()
  stable_changeToReward(currentServantNo, CppEnums.ServantToRewardType.Type_Money)
  PaGlobal_ServantList_All._SellCheck = true
end
function PaGlobal_ImperialSupplyMSG_SoupplyHorse()
  PaGlobal_ImperialSupplyMSG:MouseLupEvent_supplyHorse()
end
function PaGlobal_ImperialSupplyMSG:setRewardItems()
  self._rewardItemKeyList = {}
  if self._isMutationHorse == true then
    table.insert(self._rewardItemKeyList, 752379)
    return
  end
  if self._horseTier == 9 then
    table.insert(self._rewardItemKeyList, 1020)
    return
  end
  if _ContentsGroup_ServantFantasyMix == false then
    table.insert(self._rewardItemKeyList, 1020)
    return
  end
  table.insert(self._rewardItemKeyList, 1020)
  table.insert(self._rewardItemKeyList, 757003)
  if self._event == true then
    table.insert(self._rewardItemKeyList, 768897)
  end
end
function PaGlobal_ImperialSupplyMSG:setTreasureComponentReward()
  if self._treasureComponentItemkey == nil then
    return
  end
  table.insert(self._rewardItemKeyList, self._treasureComponentItemkey)
end
function PaGlobal_ImperialSupplyMSG:setSlots()
  local slotCount = #self._SlotList
  for idx = 1, slotCount do
    self._SlotList[idx].slotBg:SetShow(false)
  end
  local isTreasureExist = self._treasureComponentItemkey ~= nil
  local typeCount = #self._rewardItemKeyList
  if isTreasureExist == true then
    typeCount = typeCount - 1
  end
  local startX = -25 * (typeCount - 1)
  for idx = 1, typeCount do
    self._SlotList[idx].slotBg:SetSpanSize(startX, 80)
    self._SlotList[idx]:clearItem(true)
    startX = startX + 50
    PaGlobal_ImperialSupplyMSG:setSlotByIndex(idx)
  end
  if isTreasureExist == true then
    local idx = typeCount + 1
    self._SlotList[idx].slotBg:SetSpanSize(startX, 80)
    self._SlotList[idx]:clearItem(true)
    PaGlobal_ImperialSupplyMSG:setSlotByIndex(idx)
    self._ui._stc_forEffect:SetSpanSize(startX, 80)
  end
end
function PaGlobal_ImperialSupplyMSG:setSlotByIndex(idx)
  if self._isTreasureSlotShow == false and PaGlobal_ImperialSupplyMSG:isTreasureItemKey(self._rewardItemKeyList[idx]) == true then
    return
  end
  self._SlotList[idx].slotBg:SetShow(true)
  local itemCount = PaGlobal_ImperialSupplyMSG:getItemRewardCount(idx)
  local item = getItemEnchantStaticStatus(ItemEnchantKey(self._rewardItemKeyList[idx]))
  if nil ~= item then
    self._SlotList[idx]:setItemByStaticStatus(item, itemCount)
    if true == _ContentsGroup_UsePadSnapping then
      self._SlotList[idx].slotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ImperialSupplyMSG:showItemTooltip(" .. idx .. ")")
      self._SlotList[idx].slotBg:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    else
      self._SlotList[idx].icon:addInputEvent("Mouse_On", "PaGlobal_ImperialSupplyMSG:showItemTooltip(" .. idx .. ")")
      self._SlotList[idx].icon:addInputEvent("Mouse_Out", "Panel_Tooltip_Item_hideTooltip()")
    end
  end
end
function PaGlobal_ImperialSupplyMSG:getItemRewardCount(idx)
  local itemKey = self._rewardItemKeyList[idx]
  if itemKey == 1020 then
    return self._horseTier
  end
  if itemKey == 757003 then
    local itemCount = 0
    if 1 == self._horseTier then
      itemCount = 1
    elseif 2 == self._horseTier then
      itemCount = 2
    elseif 3 == self._horseTier then
      itemCount = 3
    elseif 4 == self._horseTier then
      itemCount = 4
    elseif 5 == self._horseTier then
      itemCount = 5
    elseif 6 == self._horseTier then
      itemCount = 10
    elseif 7 == self._horseTier then
      itemCount = 15
    elseif 8 == self._horseTier then
      itemCount = 20
    elseif 9 == self._horseTier then
      itemCount = 0
    end
    if true == self._event then
      itemCount = itemCount * 2
    end
    return itemCount
  end
  if itemKey == 752379 then
    return 1
  end
  if itemKey == 768897 then
    return self._horseTier * 2
  end
  if PaGlobal_ImperialSupplyMSG:isTreasureItemKey(itemKey) == true then
    return 1
  end
  return 0
end
function PaGlobal_ImperialSupplyMSG:validate()
  if Panel_ImperialSupply_Horse_Confirm == nil then
    return
  end
end
function PaGlobal_ImperialSupplyMSG:showItemTooltip(index)
  if nil ~= Panel_Tooltip_Item and true == Panel_Tooltip_Item:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(self._rewardItemKeyList[index]))
  local icon = self._SlotList[index].icon
  if true == _ContentsGroup_UsePadSnapping then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0)
  else
    Panel_Tooltip_Item_Show_ImperialHorse(itemSSW, icon, true)
  end
end
function PaGlobal_ImperialSupplyMSG:controlSetShow()
  if nil == Panel_ImperialSupply_Horse_Confirm then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    self._ui._stc_keyGuideBg:SetShow(false)
    Panel_ImperialSupply_Horse_Confirm:SetSize(500, 655)
    Panel_ImperialSupply_Horse_Confirm:ComputePosAllChild()
  else
    Panel_ImperialSupply_Horse_Confirm:SetSize(500, 600)
    self._ui._btn_supply:SetShow(false)
    self._ui._btn_close:SetShow(false)
    self._ui._btn_X:SetShow(false)
    self._ui._stc_keyGuideBg:SetShow(true)
    local keyGuide = {
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_B,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_A,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_X
    }
    Panel_ImperialSupply_Horse_Confirm:ComputePosAllChild()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  if true == _ContentsGroup_ServantFantasyMix then
    PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_BOTTOM_DESC"))
  else
    PaGlobal_ImperialSupplyMSG._ui._txt_bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_IMPERIALHORSESUPPLY_BOTTOM_CONSOLE_DESC"))
  end
end
function PaGlobal_ImperialSupplyMSG:showTreasureComponentEffect(treasureComponentItemKey)
  self._ui._stc_effectShow:AddEffect("fUI_DongDongLamp_02A", false, 0, 0)
  self._isEffectShowing = true
  self._treasureComponentItemkey = treasureComponentItemKey
  self._isTreasureSlotShow = false
  PaGlobal_ImperialSupplyMSG:update()
  if _ContentsGroup_UsePadSnapping == false then
    self._ui._btn_supply:SetMonoTone(true)
    self._ui._btn_supply:SetIgnore(true)
    self._ui._btn_close:SetMonoTone(true)
    self._ui._btn_close:SetIgnore(true)
  else
    PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_Y:SetShow(false)
    local keyGuide = {
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_B,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_A,
      PaGlobal_ImperialSupplyMSG._ui._stc_keyGuide_X
    }
    Panel_ImperialSupply_Horse_Confirm:ComputePosAllChild()
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ImperialSupplyMSG:checkTime(fDeltaTime)
  if self._isEffectShowing == false then
    return
  end
  if self._elapsedTime <= self._slotShowTime and self._elapsedTime + fDeltaTime >= self._slotShowTime then
    PaGlobal_ImperialSupplyMSG:showTreasureSlot()
  end
  if self._elapsedTime <= self._slotEffectStartTime and self._elapsedTime + fDeltaTime >= self._slotEffectStartTime then
    PaGlobal_ImperialSupplyMSG:showTreasureSlotEffect()
  end
  if self._elapsedTime <= self._backgroundEffectEndTime and self._elapsedTime + fDeltaTime >= self._backgroundEffectEndTime then
    PaGlobal_ImperialSupplyMSG:endBackgroundEffect()
  end
  self._elapsedTime = self._elapsedTime + fDeltaTime
end
function PaGlobal_ImperialSupplyMSG:endBackgroundEffect()
  self._isEffectShowing = false
  self._ui._btn_supply:SetShow(false)
  self._ui._btn_close:SetSize(480, 40)
  self._ui._btn_close:SetSpanSize(0, 525)
  self._ui._btn_close:SetMonoTone(false)
  self._ui._btn_close:SetIgnore(false)
  self._ui._btn_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
end
function PaGlobal_ImperialSupplyMSG:showTreasureSlot()
  self._isTreasureSlotShow = true
  PaGlobal_ImperialSupplyMSG:update()
end
function PaGlobal_ImperialSupplyMSG:showTreasureSlotEffect()
  local treasureComponentIndex
  local typeCount = #self._rewardItemKeyList
  for idx = 1, typeCount do
    if PaGlobal_ImperialSupplyMSG:isTreasureItemKey(self._rewardItemKeyList[idx]) == true then
      treasureComponentIndex = idx
      break
    end
  end
  if treasureComponentIndex == nil then
    return
  end
  self._ui._stc_forEffect:AddEffect("fUI_DongDongLamp_01A", false, 0, 0)
end
function PaGlobal_ImperialSupplyMSG:isTreasureItemKey(itemKey)
  if itemKey == 53804 or itemKey == 53805 then
    return true
  end
  return false
end
