function PaGlobalFunc_ShipInfoRenewalAll_ViewServantUpgrade()
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  if nil ~= servantWrapper then
    PaGlobal_ServantUpgrade:open(servantWrapper:getCharacterKeyRaw(), false)
  end
end
function HandlerEventScrollDown_ShipInfoRenewalAll_ShipInven(isUp)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local prevSlotIndex = PaGlobal_ShipInfo_Renewal_All._startInvenSlotIndex
  PaGlobal_ShipInfo_Renewal_All._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_ShipInfo_Renewal_All._ui.list_basic_ShipInven, isUp, PaGlobal_ShipInfo_Renewal_All._config.row, PaGlobal_ShipInfo_Renewal_All._config.contentsCount, PaGlobal_ShipInfo_Renewal_All._startInvenSlotIndex, PaGlobal_ShipInfo_Renewal_All._config.col)
  if prevSlotIndex ~= PaGlobal_ShipInfo_Renewal_All._startInvenSlotIndex then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_ShipInfo_Renewal_All:basic_invenUpdate()
  end
end
function HandlerEventScrollDown_ShipInfoRenewalAll_ShipSkill(flag)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == flag then
    PaGlobal_ShipInfo_Renewal_All._ui.list_basic_SkillList:MouseUpScroll(PaGlobal_ShipInfo_Renewal_All._ui.list_basic_SkillList)
  elseif false == flag then
    PaGlobal_ShipInfo_Renewal_All._ui.list_basic_SkillList:MouseDownScroll(PaGlobal_ShipInfo_Renewal_All._ui.list_basic_SkillList)
  end
end
function HandleEventOnOut_ShipInfo_Renewal_All_EmptySlot_Tooltip(isShow, index, isCash)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  if nil == index then
    return
  end
  local self = PaGlobal_ShipInfo_Renewal_All
  local name, desc, control
  local titleIcon = false
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  if __eVehicleType_GalleyShip == vehicleType or __eVehicleType_PersonalBattleShip == vehicleType or __eVehicleType_PersonalTradeShip == vehicleType or __eVehicleType_CashPersonalTradeShip == vehicleType or __eVehicleType_CashPersonalBattleShip == vehicleType or __eVehicleType_Carrack == vehicleType then
    if index == 6 then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_LIFEEQUIP_TOOLTIP_07")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_SHIP_OCEAN_INDEX" .. index .. "")
    end
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_SHIP_NORMAL_INDEX" .. index .. "")
  end
  if false == isCash then
    control = self._equipSlotBG[index]
    titleIcon = self._equipSlotBGIcon[index]
  else
    control = self._equipSlotCashBG[index]
    titleIcon = self._equipSlotCashBGIcon[index]
  end
  desc = nil
  TooltipSimple_Show(control, name, desc, titleIcon)
end
function HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem(index, isOn, isCash)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local slot, slotNoTable
  if false == isCash then
    slot = PaGlobal_ShipInfo_Renewal_All._equipItemSlots[index]
    if false == PaGlobal_ShipInfo_Renewal_All._isBigShip then
      slotNoTable = PaGlobal_ShipInfo_Renewal_All._equipSlotNoSmall
    else
      slotNoTable = PaGlobal_ShipInfo_Renewal_All._equipSlotNoBig
    end
  else
    slot = PaGlobal_ShipInfo_Renewal_All._equipItemCashSlots[index]
    if false == PaGlobal_ShipInfo_Renewal_All._isBigShip then
      slotNoTable = PaGlobal_ShipInfo_Renewal_All._equipCashSlotNoSmall
    else
      slotNoTable = PaGlobal_ShipInfo_Renewal_All._equipCashSlotNoBig
    end
  end
  local slotNo = slotNoTable[index]
  if true == _ContentsGroup_RenewUI_Tooltip then
    _AudioPostEvent_SystemUiForXBOX(50, 0)
    if true == isOn then
      local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
      if nil == servantWrapper then
        return
      end
      if slotNo == __eEquipSlotNoHelm and true == PaGlobal_ShipInfo_Renewal_All._isBigShip then
        slotNo = __eEquipSlotNoChest
      end
      local itemWrapper = servantWrapper:getEquipItem(slotNo)
      if nil == itemWrapper then
        return
      end
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
      PaGlobalFunc_FloatingTooltip_Close()
    else
      PaGlobalFunc_TooltipInfo_Close()
    end
  else
    if true == _ContentsGroup_UsePadSnapping and slotNo == __eEquipSlotNoHelm and true == PaGlobal_ShipInfo_Renewal_All._isBigShip then
      slotNo = __eEquipSlotNoChest
    end
    Panel_Tooltip_Item_SetPosition(slotNo, slot, "ServantShipEquipment")
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "ServantShipEquipment", isOn)
  end
end
function HandlerEventMouseOn_ShipInfoRenewalAll_EquipItem_Console(slotNo, isOn)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    return
  end
  if true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if true == isOn then
    local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw, slotNo)
    if nil == itemWrapper then
      return
    end
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.Item, 0)
    PaGlobalFunc_FloatingTooltip_Close()
  else
    PaGlobalFunc_TooltipInfo_Close()
  end
end
function HandlerEventRUp_ShipInfoRenewalAll_EquipItem(slotNo)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  servant_doUnequip(servantWrapper:getActorKeyRaw(), slotNo)
end
function HandleEventMOn_ShipInfo_Renewal_Tooltip_Open(actorKeyRaw, key32)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  PaGlobal_ShipInfo_Renewal_All:ShipInfo_Tooltip_Open(actorKeyRaw, key32)
end
function HandleEventMOn_ShipInfoRenewalAll_ShipFoodTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local vehicleProxy = getVehicleActor(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  local strFood
  if nil ~= vehicleProxy then
    local currentMp = getMpToActor(vehicleProxy)
    local maxMp = getMaxMpToActor(vehicleProxy)
    strFood = makeDotMoney(currentMp) .. "/" .. makeDotMoney(maxMp)
  end
  if nil == strFood then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_HORSEHP_TOOLTIP_FOOD_NAME")
  local desc = strFood
  TooltipSimple_Show(PaGlobal_ShipInfo_Renewal_All._ui.txt_basic_ShipFood, name, desc)
end
function HandleEventMOn_ShipInfoRenewalAll_ShipItemFilterTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPINFO_FOODSUPPLY_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPINFO_FOODSUPPLY_DESC")
  TooltipSimple_Show(PaGlobal_ShipInfo_Renewal_All._ui.btn_foodEmergency, name, desc)
end
function HandleEventMOn_ShipInfoRenewalAll_WeightTooltip(control, isShow)
  local name = ""
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_ALL_WEIGHT_INFO")
  if true == PaGlobal_ShipInfo_Renewal_All._isConsole then
    if true == Panel_Tooltip_SimpleText:GetShow() then
      TooltipSimple_Hide()
      return
    end
    local pos = {}
    pos.x = control:GetParentPosX()
    pos.y = control:GetParentPosY() - 80
    TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventMLUp_ShipInfoRenewalAll_ShowEquipToggle()
  PaGlobal_ShipInfo_Renewal_All:showEquipToggle()
end
function HandleEventMLUp_ShipInfoRenewalAll_OpenItemFilter(type)
  PaGlobal_ItemFilter_All_Open(PaGlobal_ShipInfo_Renewal_All._servantNo, PaGlobal_ShipInfo_Renewal_All._isGuildShip, type)
end
function HandleEventRUp_ShipInfoRenewal_All_SlotRClick(slotNo)
  PaGlobal_ShipInfo_Renewal_All._moveItemToType = CppEnums.MoveItemToType.Type_Ship
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, CppEnums.MoveItemToType.Type_Ship, PaGlobal_ShipInfo_Renewal_All._actorKeyRaw, true)
  Panel_Tooltip_Item_hideTooltip()
  local itemWrapper = PaGlobal_ShipInfo_Renewal_All_GetMoveItem(slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function HandleEventLUp_ShipInfoRenewalAll_ServantSkillLock(index, isClickedBg)
  PaGlobal_ShipInfo_Renewal_All:updateServantSkillLock(index, isClickedBg)
end
function HandleEventDPadLeft_ShipInfoRenewalAll_changePadSnapTargetItemSlot()
  ToClient_padSnapChangeToTarget(PaGlobal_ShipInfo_Renewal_All._invenSlotBG[0])
end
function HandleEventMOn_ShipInfo_ShipInfoRenewal_CheckSkillLock(actorKeyRaw, index)
  PaGlobal_ShipInfo_Renewal_All:ShipInfo_CheckSkillLock(actorKeyRaw, index)
end
function PaGlobalFunc_ShipInfoRenewalAll_CreateSkillList(control, key)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  local index = Int64toInt32(key)
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSortedSkillForDisplay(PaGlobal_ShipInfo_Renewal_All._shipSkillIndex[index])
  if nil == skillWrapper then
    return
  end
  local stc_BG = UI.getChildControl(control, "Static_SkillName")
  local stc_skillBG = UI.getChildControl(stc_BG, "Static_ShipSkillBG")
  local stc_skliIcon = UI.getChildControl(stc_BG, "Static_ShipSkill")
  local chk_skillLockIcon = UI.getChildControl(stc_BG, "CheckButton_SkillLockIcon")
  local txt_skillName = UI.getChildControl(stc_BG, "StaticText_ShipName")
  local txt_skillDesc = UI.getChildControl(stc_BG, "StaticText_ShipCost")
  txt_skillName:SetText(skillWrapper:getName())
  UI.setLimitTextAndAddTooltip(txt_skillName)
  txt_skillDesc:SetText(skillWrapper:getDescription())
  UI.setLimitAutoWrapTextAndAddTooltip(txt_skillDesc, 2)
  stc_skliIcon:ChangeTextureInfoNameAsync("Icon/" .. skillWrapper:getIconPath())
  if true == _ContentsGroup_UsePadSnapping then
    stc_BG:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfo_ShipInfoRenewal_CheckSkillLock(" .. PaGlobal_ShipInfo_Renewal_All._actorKeyRaw .. ", " .. index .. ")")
    stc_BG:addInputEvent("Mouse_Out", "HandleEventMOn_ShipInfo_ShipInfoRenewal_CheckSkillLock()")
    stc_BG:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMOn_ShipInfo_Renewal_Tooltip_Open(" .. PaGlobal_ShipInfo_Renewal_All._actorKeyRaw .. ", " .. index .. ")")
    stc_BG:registerPadEvent(__eConsoleUIPadEvent_Up_DpadLeft, "HandleEventDPadLeft_ShipInfoRenewalAll_changePadSnapTargetItemSlot()")
    stc_BG:registerPadEvent(__eConsoleUIPadEvent_RStickUp, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipSkill(true)")
    stc_BG:registerPadEvent(__eConsoleUIPadEvent_RStickDown, "HandlerEventScrollDown_ShipInfoRenewalAll_ShipSkill(false)")
  else
    stc_skliIcon:addInputEvent("Mouse_On", "HandleEventMOn_ShipInfo_Renewal_Tooltip_Open(" .. PaGlobal_ShipInfo_Renewal_All._actorKeyRaw .. ", " .. index .. ")")
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    stc_skliIcon:addInputEvent("Mouse_Out", "PaGlobal_Tooltip_Skill_Servant_All_Close()")
  else
    stc_skliIcon:addInputEvent("Mouse_Out", "PaGlobal_Tooltip_Servant_Close()")
  end
  stc_skliIcon:SetShow(true)
  stc_skillBG:SetShow(false)
  if nil ~= chk_skillLockIcon then
    local skillNameSpanSizeX = PaGlobal_ShipInfo_Renewal_All._skillNameBaseSpanSizeX
    local gabX = 4
    if true == _ContentsGroup_ServantSkill_Lock and false == servantWrapper:isGuildServant() then
      local skillKey = skillWrapper:getKey()
      local servantType = servantWrapper:getServantType()
      if ToClient_checkCanBlockVehicleSkillCommand(skillKey) then
        chk_skillLockIcon:SetShow(true)
        chk_skillLockIcon:SetCheck(ToClient_isBlockVehicleSkillCommand(skillKey, servantType))
        chk_skillLockIcon:addInputEvent("Mouse_LUp", "HandleEventLUp_ShipInfoRenewalAll_ServantSkillLock(" .. index .. ")")
      else
        skillNameSpanSizeX = skillNameSpanSizeX - chk_skillLockIcon:GetSizeX() - gabX
        chk_skillLockIcon:SetShow(false)
      end
    else
      skillNameSpanSizeX = skillNameSpanSizeX - chk_skillLockIcon:GetSizeX() - gabX
      chk_skillLockIcon:SetShow(false)
    end
    txt_skillName:SetSpanSize(skillNameSpanSizeX, txt_skillName:GetSpanSize().y)
    if true == chk_skillLockIcon:GetShow() then
      stc_BG:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_ShipInfoRenewalAll_ServantSkillLock(" .. index .. ",true)")
    else
      stc_BG:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
    end
  end
end
function PaGlobal_ShipInfo_Renewal_All_Inventory_SetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
  PaGlobal_ShipInfo_Renewal_All:inventory_SetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
end
function PaGlobal_ShipInfo_Renewal_All_Close()
  PaGlobal_ShipInfo_Renewal_All:prepareClose()
end
function PaGlobal_ShipInfo_Renewal_All_GetMoveItem(slotNo)
  if PaGlobal_ShipInfo_Renewal_All._moveItemToType == CppEnums.MoveItemToType.Type_NewShip then
    return getServantInventoryItemBySlotNo(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw, slotNo)
  elseif PaGlobal_ShipInfo_Renewal_All._inventoryType == nil then
    return nil
  else
    return getInventoryItemByType(PaGlobal_ShipInfo_Renewal_All._inventoryType, slotNo)
  end
  return nil
end
function PaGlobal_ShipInfo_Renewal_All_PopToSomewhere(s64_count, slotNo)
  if s64_count > toInt64(0, 1) then
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_ShipInfo_Renewal_All_requestPopToInventory)
  else
    PaGlobal_ShipInfo_Renewal_All_requestPopToInventory(s64_count, slotNo)
  end
end
function PaGlobal_ShipInfo_Renewal_All_requestPopToInventory(s64_count, slotNo)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfActorKeyRaw = selfPlayer:getActorKey()
  if PaGlobal_ShipInfo_Renewal_All._moveItemToType == CppEnums.MoveItemToType.Type_NewShip then
    moveInventoryItemFromActorToActor(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw, selfActorKeyRaw, CppEnums.ItemWhereType.eServantInventory, slotNo, s64_count)
  else
    if PaGlobal_ShipInfo_Renewal_All._inventoryType == nil then
      return
    end
    moveInventoryItemFromActorToActor(selfActorKeyRaw, PaGlobal_ShipInfo_Renewal_All._actorKeyRaw, PaGlobal_ShipInfo_Renewal_All._inventoryType, slotNo, s64_count)
  end
end
function FromClient_ShipInfoRenewal_ChangeEquipItem(slotNo)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == Panel_Window_ShipInfo_Renewal_All:GetShow() then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_ShipInfo_Renewal_All:updateShipInformation()
    PaGlobal_ShipInfo_Renewal_All:updateShipStat()
    PaGlobal_ShipInfo_Renewal_All:updateStatBar()
    PaGlobal_ShipInfo_Renewal_All:updateCannonStat()
    PaGlobal_ShipInfo_Renewal_All:updateShipEquipment()
  end
end
function FromClient_ShipInfoRenewal_UpdateItem()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == Panel_Window_ShipInfo_Renewal_All:GetShow() then
    PaGlobal_ShipInfo_Renewal_All:updateShipInventory()
  end
end
function FromClient_ShipInfoRenewal_ShipStatChangedByBuff()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == Panel_Window_ShipInfo_Renewal_All:GetShow() then
    PaGlobal_ShipInfo_Renewal_All:updateShipInformation()
    PaGlobal_ShipInfo_Renewal_All:updateShipStat()
    PaGlobal_ShipInfo_Renewal_All:updateStatBar()
  end
end
function FromClient_ShipInfoRenewal_UpdateCannonStat()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == Panel_Window_ShipInfo_Renewal_All:GetShow() then
    PaGlobal_ShipInfo_Renewal_All:updateShipInformation()
    PaGlobal_ShipInfo_Renewal_All:updateCannonStat()
    PaGlobal_ShipInfo_Renewal_All:updateStatBar()
  end
end
function FromClient_ShipInfoRenewal_UpdateFoodStat()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return
  end
  if true == Panel_Window_ShipInfo_Renewal_All:GetShow() then
    PaGlobal_ShipInfo_Renewal_All:updateShipInformation()
  end
end
function FromClient_ShipInfoRenewal_notifyShipWeakenItem(equipSlotNo)
  local equipString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEMTOOLTIP_SHIPARMOR_" .. tostring(equipSlotNo))
  local finalString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DownEnchantMsg", "enchantDownSlot", equipString)
  Proc_ShowMessage_Ack(finalString)
end
function PaGlobal_ShipInfo_Renewal_All_GetShowPanel()
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return false
  end
  return Panel_Window_ShipInfo_Renewal_All:GetShow()
end
function PaGlobal_ShipInfo_Renewal_All_Open(actorKeyRaw, isBigShip)
  if nil == Panel_Window_ShipInfo_Renewal_All then
    return false
  end
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  if true == servantWrapper:isGuildServant() then
    if false == servantWrapper:isMyGuildServant() then
      return
    end
  elseif false == servantWrapper:isSelfVehicle() then
    return
  end
  PaGlobal_ShipInfo_Renewal_All:prepareOpen(actorKeyRaw, isBigShip)
end
function PaGlobal_ShipInfo_Renewal_All_BasicItemFilter(slotNo, notUse_itemWrappers, whereType)
  local itemWrapper = getInventoryItemByType(whereType, slotNo)
  if nil == itemWrapper then
    return true
  end
  local isDuplicatedItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedItem then
    return true
  end
  local isOriginalForDuel = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if true == isOriginalForDuel then
    return true
  end
  return false
end
function HandleEventMLUp_ShipInfoRenewalAll_OpenGoHomeList()
  local self = PaGlobal_ShipInfo_Renewal_All
  if self == nil then
    return
  end
  if self._ui._stc_goHomeListArea:GetShow() == false then
    self._ui._stc_goHomeListArea:SetShow(true)
    self._ui._chk_goHome:SetCheck(true)
  else
    self._ui._stc_goHomeListArea:SetShow(false)
    self._ui._chk_goHome:SetCheck(false)
  end
end
function HandleEventLUp_ShipInfoRenewalAll_SelectHomeButton(index)
  local self = PaGlobal_ShipInfo_Renewal_All
  if self == nil then
    return
  end
  if self._homePositionList[index] ~= nil then
    local pos = float3(self._homePositionList[index].x, self._homePositionList[index].y, self._homePositionList[index].z)
    ToClient_DeleteNaviGuideByGroup(0)
    ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, true)
    ToCleint_gotoWorldmapPosition(pos)
  end
end
function PaGlobalFunc_ShipInfoRenewalAll_ShowGoHomeTooltip(isShow)
  local self = PaGlobal_ShipInfo_Renewal_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_SHIPINFO_GOHOME_TOOLTIP_NAME")
  control = self._ui._chk_goHome
  TooltipSimple_Show(control, name, nil, false)
end
