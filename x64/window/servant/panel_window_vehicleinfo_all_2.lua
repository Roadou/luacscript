function HandleEventLUp_VehicleInfo_All_Close()
  PaGlobal_VehicleInfo_All:prepareClose()
end
function HandleEventLUp_VehicleInfo_All_ToggleServantSimulator()
  if _ContentsGroup_HorseSimulator == false then
    return
  end
  if PaGlobalFunc_ServantSimulator_IsShow() == true then
    PaGlobalFunc_ServantSimulator_Close()
  else
    local openTabList = {
      [1] = PaGlobal_ServantSimulator._tabType.DETAIL,
      [2] = PaGlobal_ServantSimulator._tabType.GROWUP,
      [3] = PaGlobal_ServantSimulator._tabType.MATING
    }
    local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
    if servantWrapper == nil then
      return
    end
    local servantNo = servantWrapper:getServantNo()
    PaGlobalFunc_ServantSimulator_Open(openTabList, servantNo, nil)
  end
end
function HandleEventOn_VehicleInfo_All_TextTooltip(tooltipType)
  local name, control, desc
  if PaGlobal_VehicleInfo_All._eTooltipType._exp == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_expValue:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_expValue
  elseif PaGlobal_VehicleInfo_All._eTooltipType._remainTime == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_remainPeriod:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_remainPeriod
  elseif PaGlobal_VehicleInfo_All._eTooltipType._deadCount == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_deadCount:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_deadCount
  elseif PaGlobal_VehicleInfo_All._eTooltipType._name == tooltipType then
    name = PaGlobal_VehicleInfo_All._ui._txt_nameValue:GetText()
    control = PaGlobal_VehicleInfo_All._ui._txt_nameValue
  elseif PaGlobal_VehicleInfo_All._eTooltipType._rentTime == tooltipType then
    control = PaGlobal_VehicleInfo_All._ui._txt_rentTime
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANTINFO_RENTENDTIME")
    desc = PaGlobal_VehicleInfo_All._ui._txt_rentTime:GetText()
  end
  if nil == control then
    HandleEventOut_VehicleInfo_All_TextTooltip()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOut_VehicleInfo_All_TextTooltip()
  if _ContentsGroup_UsePadSnapping then
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOn_VehicleInfo_All_ServantTierTooltip()
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_GRADEINFO_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_GENERATIONDESC")
  if true == PaGlobal_VehicleInfo_All._isConsole then
    local pos = {}
    local control = Panel_Window_VehicleInfo_All
    pos.x = control:GetPosX() + control:GetSizeX()
    pos.y = control:GetPosY()
    TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
  else
    local control = PaGlobal_VehicleInfo_All._ui._txt_tierValue
    TooltipSimple_Show(control, name, desc)
  end
end
function HandleEventOut_VehicleInfo_All_ServantTierTooltip()
  TooltipSimple_Hide()
end
function HandleEventOn_VehicleInfo_All_StallionTooltip()
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local self = PaGlobal_VehicleInfo_All
  local isStallion = servantWrapper:isStallion()
  if true == isStallion then
    self._ui._txt_tooltipTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONNAME"))
    self._ui._txt_tooltipDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_STALLIONICONDESC"))
  else
    self._ui._txt_tooltipTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_NOTSTALLIONICONNAME"))
    self._ui._txt_tooltipDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_TEXT_NOTSTALLIONICONDESC_SHORT"))
  end
  for index = 1, self._maxStallionSkillCount do
    local isShow = index <= #self._stallionSkillIndex
    self._ui._sct_tooltipSkillIcon[index]:SetShow(isShow)
    self._ui._txt_tooltipSkillName[index]:SetShow(isShow)
    self._ui._sct_tooltipSkillIcon[index]:SetPosX(10 + (index + 1) % 2 * 175)
    self._ui._sct_tooltipSkillIcon[index]:SetPosY(self._ui._txt_tooltipDesc:GetPosY() + self._ui._txt_tooltipDesc:GetTextSizeY() + 10 + math.floor((index - 1) / 2) * 55)
    self._ui._txt_tooltipSkillName[index]:SetPosX(65 + (index + 1) % 2 * 175)
    self._ui._txt_tooltipSkillName[index]:SetPosY(self._ui._txt_tooltipDesc:GetPosY() + self._ui._txt_tooltipDesc:GetTextSizeY() + 22 + math.floor((index - 1) / 2) * 55)
    if true == isShow then
      local skillStaticStatusWrapper = getVehicleSkillStaticStatus(self._stallionSkillIndex[index])
      if nil ~= skillStaticStatusWrapper then
        self._ui._sct_tooltipSkillIcon[index]:ChangeTextureInfoNameAsync("Icon/" .. skillStaticStatusWrapper:getIconPath())
        self._ui._txt_tooltipSkillName[index]:SetText(skillStaticStatusWrapper:getName())
      end
      local skillWrapper = servantWrapper:getSkill(self._stallionSkillIndex[index])
      if nil ~= skillWrapper then
        self._ui._sct_tooltipSkillIcon[index]:SetMonoTone(false)
        self._ui._txt_tooltipSkillName[index]:SetMonoTone(false)
      else
        self._ui._sct_tooltipSkillIcon[index]:SetMonoTone(true)
        self._ui._txt_tooltipSkillName[index]:SetMonoTone(true)
      end
    end
  end
  self._ui._sct_tooltip:SetSize(self._ui._sct_tooltip:GetSizeX(), self._ui._sct_tooltipSkillIcon[#self._stallionSkillIndex]:GetPosY() + 55)
  if Panel_Window_VehicleInfo_All:GetPosX() + Panel_Window_VehicleInfo_All:GetSizeX() + self._ui._sct_tooltip:GetSizeX() + 10 > getScreenSizeX() then
    self._ui._sct_tooltip:SetPosX(self._ui._sct_tooltip:GetSizeX() * -1 - 10)
  else
    self._ui._sct_tooltip:SetPosX(Panel_Window_VehicleInfo_All:GetSizeX() + 10)
  end
  self._ui._sct_tooltip:SetShow(true)
end
function HandleEventOut_VehicleInfo_All_StallionTooltip()
  PaGlobal_VehicleInfo_All._ui._sct_tooltip:SetShow(false)
end
function HandleEventOn_VehicleInfo_All_WeightTooltip()
  local control
  if true == PaGlobal_VehicleInfo_All._ui._stc_weightGuide:GetShow() then
    control = PaGlobal_VehicleInfo_All._ui._stc_weightGuide
  elseif true == PaGlobal_VehicleInfo_All._ui._stc_heavyAlert:GetShow() then
    control = PaGlobal_VehicleInfo_All._ui._stc_heavyAlert
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_WEIGHT_TOOLTIP")
  TooltipSimple_Show(control, name)
end
function HandleEventOut_VehicleInfo_All_WeightTooltip()
  TooltipSimple_Hide()
end
function HandleEventOn_VehicleInfo_All_RentEndTimeTooltip(isShow, rentTime)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  name = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANTINFO_RENTENDTIME")
  desc = rentTime
  control = PaGlobal_VehicleInfo_All._ui._txt_rentTime
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_VehicleInfo_All_ShowUseAddStatItemTooltip(isShow, stat)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_VehicleInfo_All._ui._stc_OnlySpeed
  if nil == control or nil == stat then
    return
  end
  local statString, itemName = "", nil
  if __eServantStatTypeSpeed == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_SPEED")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_MAXSPEED")
    control = PaGlobal_VehicleInfo_All._ui._stc_OnlySpeed
  elseif __eServantStatTypeAcceleration == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_ACCE")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_ACCELERATION")
    control = PaGlobal_VehicleInfo_All._ui._stc_OnlyAcce
  elseif __eServantStatTypeCornering == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_CORNER")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_CORNERING")
    control = PaGlobal_VehicleInfo_All._ui._stc_OnlyCorner
  elseif __eServantStatTypeBrake == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_BRAKE")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_BRAKE")
    control = PaGlobal_VehicleInfo_All._ui._stc_OnlyBrake
  else
    return
  end
  local name = ""
  local desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_USEADDSTATITEMICON_TOOLTIP", "itemName", itemName, "stat", statString)
  TooltipSimple_Show(control, name, desc)
end
function HandlerEventScroll_VehicleInfo_All_InventoryScroll(isUp)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local prevSlotIndex = PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex
  local config = PaGlobal_VehicleInfo_All._inventory._config
  PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_VehicleInfo_All._ui._scroll_vertical, isUp, config.row, config.contentsCount, PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex, config.col)
  if prevSlotIndex ~= PaGlobal_VehicleInfo_All._inventory._startInvenSlotIndex then
    Panel_Tooltip_Item_hideTooltip()
    PaGlobal_VehicleInfo_All:updateInventorySlot()
  end
end
function HandleEventRUp_VehicleInfo_All_InvenSlotRClick(slotNo)
  FGlobal_PopupMoveItem_Init(CppEnums.ItemWhereType.eServantInventory, slotNo, CppEnums.MoveItemToType.Type_Vehicle, PaGlobal_VehicleInfo_All._actorKeyRaw, true)
  local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_VehicleInfo_All._actorKeyRaw, slotNo)
  if nil ~= itemWrapper then
    local itemStatic = itemWrapper:getStaticStatus():get()
    if nil ~= itemStatic then
      audioPostEvent_SystemItem(itemStatic._itemMaterial)
    end
  end
end
function HandleEventRUp_VehicleInfo_All_VehicleInvenTooltip_ForConsole(slotNo)
  if false == _ContentsGroup_RenewUI_Tooltip or nil == slotNo then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local itemWrapper = getServantInventoryItemBySlotNo(PaGlobal_VehicleInfo_All._actorKeyRaw, slotNo)
  if nil == itemWrapper then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
end
function HandleEventRUp_VehicleInfo_All_EquipItemRClick(slotNo)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local itemWrapper = servantWrapper:getEquipItem(slotNo)
  if nil == itemWrapper then
    return
  end
  servant_doUnequip(servantWrapper:getActorKeyRaw(), slotNo)
end
function HandleEventOn_VehicleInfo_All_EquipItemTooltip(slotNo, isOn)
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  if true == isOn and true == _ContentsGroup_RenewUI_Tooltip then
    local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
    local itemWrapper
    if nil ~= servantWrapper then
      itemWrapper = servantWrapper:getEquipItem(slotNo)
    end
    if nil ~= itemWrapper then
      PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
    end
  else
    Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "ServantEquipment", isOn)
  end
end
function HandleEventOnOut_ServantInfo_All_EmptySlot_Tooltip(isShow, slotNo)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local self = PaGlobal_VehicleInfo_All
  local name, desc, control
  local titleIcon = false
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local VehicleType = servantWrapper:getVehicleType()
  if self._eViewType._normal == self._viewType then
    if __eVehicleType_Elephant == VehicleType or __eVehicleType_Ridable_BabyElephant == VehicleType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_ELEPHANT_SLOTNO" .. slotNo .. "")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_HORSE_SLOTNO" .. slotNo .. "")
    end
    control = self._ui._stc_equipSlot[slotNo]
    titleIcon = self._ui._stc_equipIcon[slotNo]
  elseif self._eViewType._carriage == self._viewType then
    control = self._ui._stc_equipSlot[slotNo]
    titleIcon = self._ui._stc_equipIcon[slotNo]
    name = PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_CARRIAGE_SLOTNO" .. slotNo .. "")
  end
  desc = nil
  TooltipSimple_Show(control, name, desc, titleIcon)
end
function HandleEventLUp_VehicleInfo_All_EquipShow(slotNo)
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local isShowEquip = PaGlobal_VehicleInfo_All._ui._chk_equipShow[slotNo]:IsCheck()
  if true == PaGlobal_VehicleInfo_All._isConsole then
    isShowEquip = not isShowEquip
    PaGlobal_VehicleInfo_All._ui._chk_equipShow[slotNo]:SetCheck(isShowEquip)
  end
  if isShowEquip then
    ToClient_SetVehicleEquipSlotFlag(PaGlobal_VehicleInfo_All._actorKeyRaw, slotNo)
  else
    ToClient_ResetVehicleEquipSlotFlag(PaGlobal_VehicleInfo_All._actorKeyRaw, slotNo)
  end
end
function HandleEventOn_VehicleInfo_All_SetKeyGuideY(isShow)
  PaGlobal_VehicleInfo_All._ui._console.txt_keyGuideY:SetShow(isShow)
  PaGlobal_VehicleInfo_All:setAlignKeyGuide()
end
function HandleEventOnOut_VehicleInfo_All_ShowStallionToolTip(isShow, index)
  if false == isShow or nil == index then
    TooltipSimple_Hide()
    return
  end
  local skillList = PaGlobal_VehicleInfo_All:getSkillList()
  if nil == skillList then
    return
  end
  local content = skillList:GetContentByKey(toInt64(0, index))
  if nil == content then
    return
  end
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  if nil == stc_BG then
    return
  end
  local control = UI.getChildControl(stc_BG, "Static_SkillStallionIcon")
  if nil == control then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOn_VehicleInfo_All_SkillTooltip(isShow, index)
  if false == isShow then
    if true == _ContentsGroup_NewUI_Tooltip_All then
      if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
        PaGlobal_Tooltip_Skill_Servant_All_Close()
      end
    elseif nil ~= PaGlobal_Tooltip_Servant_Close then
      PaGlobal_Tooltip_Servant_Close()
    end
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local skillWrapper = servantWrapper:getSkill(PaGlobal_VehicleInfo_All._skillIndexList[index])
  if nil == skillWrapper then
    skillWrapper = servantWrapper:getSkillXXX(PaGlobal_VehicleInfo_All._skillIndexList[index])
    if nil == skillWrapper then
      return
    end
  end
  local desc = skillWrapper:getDescription()
  local content = PaGlobal_VehicleInfo_All:getSkillList():GetContentByKey(toInt64(0, index))
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  local stc_skillBG = UI.getChildControl(stc_BG, "Static_VehicleSkillBG")
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Open then
      PaGlobal_Tooltip_Skill_Servant_All_Open(skillWrapper, stc_skillBG, false)
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Open then
    local isShowStallionSkillTooltip = false
    if true == PaGlobal_VehicleInfo_All._isConsole then
      isShowStallionSkillTooltip = servantWrapper:isStallionSkill(skillWrapper:getKey())
    end
    PaGlobal_Tooltip_Servant_Open(skillWrapper, stc_skillBG, false, isShowStallionSkillTooltip)
  end
end
function HandleEventOn_VehicleInfo_All_WarningTooltip(isShow, index)
  if false == isShow then
    if _ContentsGroup_UsePadSnapping then
    else
      TooltipSimple_Hide()
    end
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local name, desc
  local skillWrapper = servantWrapper:getSkill(PaGlobal_VehicleInfo_All._skillIndexList[index])
  local content = PaGlobal_VehicleInfo_All:getSkillList():GetContentByKey(toInt64(0, index))
  local stc_BG = UI.getChildControl(content, "Static_SkillName")
  local stc_warning = UI.getChildControl(stc_BG, "Static_Warning")
  if nil ~= skillWrapper then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTINFO_NEEDSKILLTITLE")
    desc = skillWrapper:getConditionDescription()
    TooltipSimple_Show(stc_warning, name, desc)
  end
end
function HandleEventLUp_VehicleInfo_All_ServantSkillLock(index, isSkillBGClick)
  PaGlobal_VehicleInfo_All:updateServantSkillLock(index, isSkillBGClick)
end
function HandleEventLUp_VehicleInfo_All_LinkedServantSkill(index)
  PaGloabl_LinkedSkill_All_Open(PaGlobal_VehicleInfo_All._actorKeyRaw, index)
end
function HandleEventLUp_VehicleInfo_All_SetAutoFeed()
  break
end
function PaGlobalFunc_HorseInfo_GetIsCheckAutoCarrot()
  return false
end
function HandleEventLUp_VehicleInfo_All_LearnServantSkillByDiceCount(useCount)
  if false == _ContentsGroup_HorseSkillLearnNewWay then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  if true == servantWrapper:isGuildServant() then
    return
  end
  local vehicleType = servantWrapper:getVehicleType()
  if CppEnums.VehicleType.Type_RaceHorse == vehicleType then
    return
  end
  local myservantinfo = stable_getServantByServantNo(servantWrapper:getServantNo())
  if nil == myservantinfo then
    return
  end
  if (CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType) and Defines.s64_const.s64_0 < myservantinfo:getRentOwnerNo() then
    return
  end
  ToClient_LearnServantSkillByDiceCount(useCount)
end
function HandleEventOnOut_VehicleInfo_All_SnappingSkill(isOn, index)
  if nil == Panel_Window_VehicleInfo_All and false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  if false == PaGlobal_VehicleInfo_All._isConsole then
    return
  end
  if nil == index or nil == isOn or false == isOn then
    HandleEventOn_VehicleInfo_All_SkillTooltip(false)
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "")
    PaGlobal_VehicleInfo_All._ui._console.txt_keyGuideRTX:SetShow(false)
    PaGlobal_VehicleInfo_All:setSkillLockKeyguide(false)
  else
    PaGlobal_VehicleInfo_All._selectSkillIndex = index
    local skillList = PaGlobal_VehicleInfo_All:getSkillList()
    if nil ~= skillList and nil ~= PaGlobal_VehicleInfo_All._actorKeyRaw then
      local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
      if nil ~= servantWrapper and nil ~= PaGlobal_VehicleInfo_All._skillIndexList[index] then
        local skillWrapper = servantWrapper:getSkill(PaGlobal_VehicleInfo_All._skillIndexList[index])
        if nil ~= skillWrapper then
          local key = skillList:getKeyByIndex(index - 1)
          if -1 == key then
            index = index + 1
            key = skillList:getKeyByIndex(index - 1)
          end
          local control = skillList:GetContentByKey(key)
          if nil ~= control then
            local stc_BG = UI.getChildControl(control, "Static_SkillName")
            local stc_skillBG = UI.getChildControl(stc_BG, "Static_VehicleSkillBG")
            local chk_skillLockIcon = UI.getChildControl(stc_BG, "CheckButton_SkillLockIcon")
            if nil ~= chk_skillLockIcon then
              local skillKey = skillWrapper:getKey()
              local servantType = servantWrapper:getServantType()
              chk_skillLockIcon:SetCheck(ToClient_isBlockVehicleSkillCommand(skillKey, servantType))
              if true == chk_skillLockIcon:GetShow() then
                PaGlobal_VehicleInfo_All:setSkillLockKeyguide(true)
              end
            end
          end
        end
      end
    end
    Panel_Window_VehicleInfo_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_X, "HandleEventOnOut_VehicleInfo_All_ShowSkillTooltipByPad()")
    PaGlobal_VehicleInfo_All._ui._console.txt_keyGuideRTX:SetShow(true)
  end
  PaGlobal_VehicleInfo_All:setAlignKeyGuide()
end
function HandleEventOnOut_VehicleInfo_All_ShowSkillTooltipByPad()
  if false == PaGlobal_VehicleInfo_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_GetShow and true == PaGlobal_Tooltip_Skill_Servant_All_GetShow() then
      HandleEventOn_VehicleInfo_All_SkillTooltip(false)
    else
      HandleEventOn_VehicleInfo_All_SkillTooltip(true, PaGlobal_VehicleInfo_All._selectSkillIndex)
    end
  elseif nil ~= Panel_Tooltip_Skill_Servant and true == Panel_Tooltip_Skill_Servant:GetShow() then
    HandleEventOn_VehicleInfo_All_SkillTooltip(false)
  else
    HandleEventOn_VehicleInfo_All_SkillTooltip(true, PaGlobal_VehicleInfo_All._selectSkillIndex)
  end
end
function HandleEventLUp_VehicleInfo_All_ReturnMasterlessHorse()
  if Panel_Window_VehicleInfo_All == nil then
    return
  end
  if HandleEventLUp_HorseWithoutOwner_Return == nil then
    return
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRAVELHORSE_SERVANT_MESSAGE"),
    functionYes = HandleEventLUp_HorseWithoutOwner_Return,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventOnOut_VehicleInfo_All_ReturnMasterlessHorseToolTip(isShow)
  if Panel_Window_VehicleInfo_All == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_VehicleInfo_All._ui._btn_returnMasterlessHorse
  if control == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRAVELHORSE_TOOLTIP_RETURNBACK_NAME")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TRAVELHORSE_TOOLTIP_RETURNBACK_DESC")
  TooltipSimple_Show(control, name, desc)
end
function FromClient_VehicleInfo_All_OpenSevantInfomation(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  if servantWrapper:isGuildServant() then
    if false == servantWrapper:isMyGuildServant() then
      return
    end
  elseif false == servantWrapper:isSelfVehicle() then
    return
  end
  if nil ~= Panel_Window_CampWarehouse_All and Panel_Window_CampWarehouse_All:GetShow() then
    PaGlobalFunc_CampWarehouse_All_Close()
  end
  local vehicleType = servantWrapper:getVehicleType()
  if PaGlobal_VehicleInfo_All:isCheckTank(vehicleType) then
    return
  end
  if PaGlobal_VehicleInfo_All:isCheckNormal(vehicleType) then
    PaGlobal_VehicleInfo_All:stallionSkillCheck(actorKeyRaw)
    PaGlobal_VehicleInfo_All:prepareOpen(PaGlobal_VehicleInfo_All._eViewType._normal, actorKeyRaw)
  elseif PaGlobal_VehicleInfo_All:isCheckCarriage(vehicleType) then
    PaGlobal_VehicleInfo_All:prepareOpen(PaGlobal_VehicleInfo_All._eViewType._carriage, actorKeyRaw)
  elseif PaGlobal_VehicleInfo_All:isCheckShip(vehicleType) then
    if _ContentsGroup_EmployeePresetJob == true then
      PaGlobal_ShipInfo_Renewal_All:prepareOpen(actorKeyRaw, false)
    elseif true == _ContentsGroup_OceanCurrent then
      PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, false)
    elseif true == _ContentsGroup_RenewUI then
      if _ContentsGroup_EmployeePresetJob == true then
        PaGlobal_ShipInfo_Renewal_All:prepareOpen(actorKeyRaw, false)
      else
        PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, false)
      end
    else
      ShipInfo_OpenByActorKeyRaw(actorKeyRaw)
    end
  elseif PaGlobal_VehicleInfo_All:isCheckBigShip(vehicleType) then
    if _ContentsGroup_EmployeePresetJob == true then
      PaGlobal_ShipInfo_Renewal_All:prepareOpen(actorKeyRaw, true)
    elseif true == _ContentsGroup_OceanCurrent then
      PaGlobal_ShipInfo_All:prepareOpen(actorKeyRaw, true)
    else
      WorkerShipInfo_OpenByActorKeyRaw(actorKeyRaw)
    end
  end
end
function FromClient_VehicleInfo_All_UpdateHp()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateHp()
end
function FromClient_VehicleInfo_All_UpdateMp()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateStamina()
end
function FromClient_VehicleInfo_All_UpdateLevel()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateLevel()
end
function FromClient_VehicleInfo_All_ServantEquipmentUpdate()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  FromClient_VehicleInfo_All_UpdateAll()
end
function FromClient_VehicleInfo_All_UpdateAll()
  if false == Panel_Window_VehicleInfo_All:GetShow() then
    return
  end
  PaGlobal_VehicleInfo_All:updateData(PaGlobal_VehicleInfo_All._viewType)
end
function PaGloabl_VehicleInfo_All_ShowAni()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
end
function PaGloabl_VehicleInfo_All_HideAni()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
end
function PaGlobal_VehicleInfo_All_Close()
  PaGlobal_VehicleInfo_All:prepareClose()
end
function PaGlobal_VehicleInfo_All_GetActorKeyRaw()
  return PaGlobal_VehicleInfo_All._actorKeyRaw
end
function PaGlobal_VehicleInfo_All_InfoUpdate()
  PaGlobal_VehicleInfo_All:update(PaGlobal_VehicleInfo_All._viewType)
end
function PaGlobal_VehicleInfo_All_GetPanelShow()
  if nil == Panel_Window_VehicleInfo_All then
    return false
  end
  return Panel_Window_VehicleInfo_All:GetShow()
end
function PaGlobal_VehicleInfo_All_InvenSetFunctor(slotNo, itemWrapper, s64_count, inventoryType)
  local servantWrapper = getServantInfoFromActorKey(PaGlobal_VehicleInfo_All._actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  local itemSSW = itemWrapper:getStaticStatus()
  if nil == itemSSW then
    return
  end
  local itemSS = itemSSW:get()
  if nil == itemSS then
    return
  end
  PaGlobal_VehicleInfo_All._inventoryType = inventoryType
  PaGlobal_VehicleInfo_All._inventroySlotNo = slotNo
  local linkServantInfo = PaGlobal_LinkedSkill_All:getServantInfo()
  local linkServantKind, linkServantKindSub
  if linkServantInfo ~= nil then
    linkServantKind = linkServantInfo:getServantKind()
    linkServantKindSub = linkServantInfo:getServantKindSub()
  end
  local servantKind = servantWrapper:getServantKind()
  local servantKindSub = servantWrapper:getServantKindSub()
  if true == itemSS:isServantTypeUsable(servantKind, servantKindSub) then
    if 2 == itemSS._vestedType:getItemKey() and false == itemWrapper:get():isVested() then
      local messageContent
      if itemSSW:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = PaGlobal_VehicleInfo_All_InventoryUseItem,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      PaGlobal_VehicleInfo_All_InventoryUseItem()
    end
  elseif Panel_Window_LinkedSkill_All ~= nil and Panel_Window_LinkedSkill_All:GetShow() == true and linkServantInfo ~= nil and itemSS:isServantTypeUsable(linkServantKind, linkServantKindSub) == true then
    if itemSS._vestedType:getItemKey() == 2 and itemWrapper:get():isVested() == false then
      local messageContent
      if itemSSW:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = PaGlobal_VehicleInfo_All_InventoryUseItemForLinkedServant,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      PaGlobal_VehicleInfo_All_InventoryUseItemForLinkedServant()
    end
  else
    Panel_NumberPad_Show(true, s64_count, slotNo, PaGlobal_VehicleInfo_All_MoveInventoryItemFromActorToActor, nil, inventoryType)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus():get()
      if nil ~= itemStatic then
        audioPostEvent_SystemItem(itemStatic._itemMaterial)
      end
    end
  end
end
function PaGlobal_VehicleInfo_All_MoveInventoryItemFromActorToActor(s64_count, slotNo, whereType)
  moveInventoryItemFromActorToActor(getSelfPlayer():get():getActorKeyRaw(), PaGlobal_VehicleInfo_All._actorKeyRaw, whereType, slotNo, s64_count)
end
function PaGlobal_VehicleInfo_All_InventoryUseItem()
  inventoryUseItem(PaGlobal_VehicleInfo_All._inventoryType, PaGlobal_VehicleInfo_All._inventroySlotNo, __eEquipSlotNoCount, false)
end
function PaGlobal_VehicleInfo_All_InventoryUseItemForLinkedServant()
  local linkServantInfo = PaGlobal_LinkedSkill_All:getServantInfo()
  if linkServantInfo == nil then
    return
  end
  ToClient_equipUnsummonedServant(linkServantInfo:getServantNo(), PaGlobal_VehicleInfo_All._inventoryType, PaGlobal_VehicleInfo_All._inventroySlotNo)
end
function PaGlobal_VehicleInfo_All_UpdateSkillList(control, key)
  PaGlobal_VehicleInfo_All:updateSkillList(control, key)
end
function PaGlobal_VehicleInfo_All_UpdateHorseList(control, key)
  PaGlobal_VehicleInfo_All:updateHorseList(control, key)
end
function PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
  local servantWrapper = getServantInfoFromActorKey(actorKeyRaw)
  if nil == servantWrapper then
    return
  end
  FromClient_VehicleInfo_All_OpenSevantInfomation(actorKeyRaw)
end
function PaGlobal_VehicleInfo_All_OpenHorseInfo()
  if nil == Panel_Window_VehicleInfo_All then
    return
  end
  local selfPlayer = getSelfPlayer()
  local selfProxy = selfPlayer:get()
  if nil == selfProxy then
    return
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if nil == vehicleProxy then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_HORSEINFO_HORSEINFOALERTMSG"))
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  if false == ToClient_isCheckRenderModeGame() then
    return
  end
  if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_Camel == vehicleType or CppEnums.VehicleType.Type_Donkey == vehicleType or CppEnums.VehicleType.Type_Elephant == vehicleType or CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType or CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
    PaGlobal_VehicleInfo_All_Open(actorKeyRaw)
  elseif nil ~= PaGlobalFunc_Util_IsShip and true == PaGlobalFunc_Util_IsShip(vehicleType) then
    if _ContentsGroup_EmployeePresetJob == true and PaGlobal_ShipInfo_Renewal_All_Open ~= nil then
      PaGlobal_ShipInfo_Renewal_All_Open(actorKeyRaw, false)
    elseif true == _ContentsGroup_OceanCurrent and nil ~= PaGlobal_ShipInfo_All_Open then
      PaGlobal_ShipInfo_All_Open(actorKeyRaw, false)
    end
  elseif nil ~= PaGlobalFunc_Util_IsBigShip and true == PaGlobalFunc_Util_IsBigShip(vehicleType) then
    if _ContentsGroup_EmployeePresetJob == true and PaGlobal_ShipInfo_Renewal_All_Open ~= nil then
      PaGlobal_ShipInfo_Renewal_All_Open(actorKeyRaw, true)
    elseif true == _ContentsGroup_OceanCurrent and nil ~= PaGlobal_ShipInfo_All_Open then
      PaGlobal_ShipInfo_All_Open(actorKeyRaw, true)
    end
  end
end
function IsNowEquipCheck()
  return false
end
function PaGlobal_VehicleInfo_All_ToggleAutoFeed()
  if false == PaGlobal_VehicleInfo_All._isConsole then
    return
  end
  if true == PaGlobal_VehicleInfo_All._ui._chk_autoFeed:IsCheck() then
    PaGlobal_VehicleInfo_All._ui._chk_autoFeed:SetCheck(false)
  else
    PaGlobal_VehicleInfo_All._ui._chk_autoFeed:SetCheck(true)
  end
  if true == _ContentsGroup_RenewUI then
    FGlobal_ToggleServantAutoCarrot_PadInput()
  else
    HandlePadEventX_ServantMpBar_ToggleAutoCarrot()
  end
end
function PaGlobalFunc_HorseInfo_GetIsCheckAutoCarrot()
  if nil == PaGlobal_VehicleInfo_All._ui._chk_autoFeed then
    return true
  end
  return PaGlobal_VehicleInfo_All._ui._chk_autoFeed:IsCheck()
end
function PaGlobalFunc_VehicleInfo_All_StallionTooltipForConsole()
  if true == PaGlobal_VehicleInfo_All._stallionTooltipShow then
    HandleEventOut_VehicleInfo_All_StallionTooltip()
    PaGlobal_VehicleInfo_All._stallionTooltipShow = false
  else
    HandleEventOn_VehicleInfo_All_StallionTooltip()
    PaGlobal_VehicleInfo_All._tierTooltipShow = false
    PaGlobal_VehicleInfo_All._stallionTooltipShow = true
  end
end
function PaGlobalFunc_VehicleInfo_All_ServantTierTooltipForConsole()
  if true == PaGlobal_VehicleInfo_All._tierTooltipShow then
    HandleEventOut_VehicleInfo_All_ServantTierTooltip()
    PaGlobal_VehicleInfo_All._tierTooltipShow = false
  else
    HandleEventOn_VehicleInfo_All_ServantTierTooltip()
    PaGlobal_VehicleInfo_All._stallionTooltipShow = false
    PaGlobal_VehicleInfo_All._tierTooltipShow = true
  end
end
function PaGlobal_VehicleInfo_All_Close_Inventory()
  Inventory_SetFunctor(nil, nil, nil, nil)
end
function PaGlobal_VehicleInfo_All_ItemAcquireHelper(slotNo, vehicleType)
  if ToClient_isConsole() == true then
    return
  end
  local checkIsCashSlot = function(slotNo)
    if __eEquipSlotNoAvatarChest == slotNo or __eEquipSlotNoAvatarGlove == slotNo or __eEquipSlotNoAvatarBoots == slotNo or __eEquipSlotNoAvatarHelm == slotNo or __eEquipSlotNoAvatarBody == slotNo then
      return true
    end
    return false
  end
  if checkIsCashSlot(slotNo) == true then
    if PaGlobalFunc_Util_IsHorse(vehicleType) == true then
      PaGlobal_ItemAcquireHelper_SetCashShopData(__eInGameCashShopMainTab_Vehicle, __eInGameCashShopSubTab_Horse, PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GOTOPEARLSHOP"))
      return
    end
    if PaGlobalFunc_Util_IsCarriage(vehicleType) == true then
      PaGlobal_ItemAcquireHelper_SetCashShopData(__eInGameCashShopMainTab_Vehicle, __eInGameCashShopSubTab_Carriage, PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GOTOPEARLSHOP"))
      return
    end
  else
    if ToClient_isConsole() == true then
      return
    end
    local mainCategoryIndex, subCategoryIndex = PaGlobal_VehicleInfo_All_FindItemMarketCategoryIndex(slotNo, vehicleType)
    PaGlobal_ItemAcquireHelper_SetItemMarketData(mainCategoryIndex, subCategoryIndex, PAGetString(Defines.StringSheet_GAME, "LUA_VEHICLEINFO_GOTOITEMMARKET"))
    return
  end
end
function PaGlobal_VehicleInfo_All_FindItemMarketCategoryIndex(slotNo, vehicleType)
  if nil == getSelfPlayer() then
    return
  end
  local self = PaGlobal_ItemAcquireHelper
  if nil == self._marketCategoryTable then
    self._marketCategoryTable = PaGlobalFunc_getItemMarketCategoryListAndSetUI(nil)
  end
  if self._marketCategoryTable == nil then
    return
  end
  local marketMainIndexFromSheet, marketSubIndexFromSheet
  if PaGlobalFunc_Util_IsCarriage(vehicleType) == true then
    marketMainIndexFromSheet = 75
    if slotNo == __eEquipSlotNoGlove then
      marketSubIndexFromSheet = 2
    elseif slotNo == __eEquipSlotNoBoots then
      marketSubIndexFromSheet = 4
    elseif slotNo == __eEquipSlotNoHelm then
      marketSubIndexFromSheet = 5
    elseif slotNo == __eEquipSlotNoLantern then
      marketSubIndexFromSheet = 6
    elseif slotNo == __eEquipSlotNoBody then
      marketSubIndexFromSheet = 3
    end
  elseif PaGlobalFunc_Util_IsHorse(vehicleType) == true then
    marketMainIndexFromSheet = 65
    if __eVehicleType_Elephant == vehicleType or __eVehicleType_Ridable_BabyElephant == vehicleType then
      if slotNo == __eEquipSlotNoChest then
        marketSubIndexFromSheet = 9
      elseif slotNo == __eEquipSlotNoGlove then
        marketSubIndexFromSheet = 11
      elseif slotNo == __eEquipSlotNoBoots then
        marketSubIndexFromSheet = 8
      elseif slotNo == __eEquipSlotNoHelm then
        marketSubIndexFromSheet = 10
      elseif slotNo == __eEquipSlotNoBelt then
        marketSubIndexFromSheet = 7
      end
    elseif slotNo == __eEquipSlotNoChest then
      marketSubIndexFromSheet = 4
    elseif slotNo == __eEquipSlotNoGlove then
      marketSubIndexFromSheet = 5
    elseif slotNo == __eEquipSlotNoBoots then
      marketSubIndexFromSheet = 6
    elseif slotNo == __eEquipSlotNoHelm then
      marketSubIndexFromSheet = 3
    elseif slotNo == __eEquipSlotNoBelt then
      marketSubIndexFromSheet = 7
    end
  end
  UI.ASSERT(marketMainIndexFromSheet ~= nil and marketSubIndexFromSheet ~= nil, "\235\140\128\236\157\145 \235\144\152\236\167\128 \236\149\138\236\157\128 \235\167\136\236\176\168/\235\167\144\236\157\152 slotNo\236\158\133\235\139\136\235\139\164. slotNo : " .. slotNo .. ", vehicleType : " .. vehicleType)
  local mainIndex, subIndex
  for idx = 0, #self._marketCategoryTable do
    if self._marketCategoryTable[idx] ~= nil and marketMainIndexFromSheet == self._marketCategoryTable[idx]._categoryNo then
      if self._marketCategoryTable[idx]._isMain == true then
        mainIndex = idx
      elseif marketSubIndexFromSheet == self._marketCategoryTable[idx]._subIndex + 1 then
        subIndex = idx
      end
    end
  end
  return mainIndex, subIndex
end
function HandleEventOnOut_VehicleInfo_All_ShowStackLvUpTooltip(isShow, isCarriage, index)
  local self = PaGlobal_VehicleInfo_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  if isCarriage == nil then
    isCarriage = false
  elseif isCarriage == true and index == nil then
    return
  end
  local control
  if isCarriage == true then
    local content = self._ui._list2_horseList:GetContentByKey(toInt64(0, index))
    if content == nil then
      return
    end
    local btn_carriageHorse = UI.getChildControl(content, "Button_CarriageHorse")
    local txt_horseExp = UI.getChildControl(btn_carriageHorse, "StaticText_HorseExp")
    control = txt_horseExp
  else
    control = self._ui._txt_expValue
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_EXP_TOOLTIP")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_EXP_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_VehicleInfo_All_StackLvUp()
  local self = PaGlobal_VehicleInfo_All
  if self == nil then
    return
  end
  if _ContentsGroup_ServantLevelUpRenewal == false then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if servantWrapper == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoDistanceIsFar"))
    return
  end
  local servantNo = servantWrapper:getServantNo()
  PaGlobal_ServantLvUpMessageBox_All_Open(servantNo, false)
end
function HandleEventLUp_VehicleInfo_All_LevelDecrease()
  local self = PaGlobal_VehicleInfo_All
  if self == nil then
    return
  end
  if _ContentsGroup_ServantLevelUpRenewal == false then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if servantWrapper == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoDistanceIsFar"))
    return
  end
  local servantNo = servantWrapper:getServantNo()
  ToClient_requestGetServantLastVariedStat(servantNo)
end
function HandleEventLUp_VehicleInfo_All_SkillChange()
  local self = PaGlobal_VehicleInfo_All
  if self == nil then
    return
  end
  if _ContentsGroup_ServantLevelUpRenewal == false then
    return
  end
  local servantWrapper = getServantInfoFromActorKey(self._actorKeyRaw)
  if servantWrapper == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoDistanceIsFar"))
    return
  end
  local servantNo = servantWrapper:getServantNo()
  PaGlobalFunc_ServantSkillManagement_All_Open(servantNo, true)
end
