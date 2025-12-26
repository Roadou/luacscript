function PaGlobalFunc_ServantInfo_All_Open(servantNo, updateFlag)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  if PaGlobal_ServantInfo_All._currentVehicleIndexNo ~= servantNo then
    PaGlobal_ServantInfo_All._currentSkillListData._index = nil
    PaGlobal_ServantInfo_All._currentSkillListData._pos = nil
  end
  PaGlobal_ServantInfo_All._currentSlotType = -1
  if nil ~= Panel_Dialog_ServantList_All then
    PaGlobal_ServantInfo_All._currentSlotType = PaGlobalFunc_ServantList_All_Get_CurrentSlotType()
  end
  if -1 == PaGlobal_ServantInfo_All._currentSlotType or nil == PaGlobal_ServantInfo_All._currentSlotType then
    return
  end
  if nil ~= Panel_Dialog_ServantLookChange_All and true == Panel_Dialog_ServantLookChange_All:GetShow() then
    PaGlobalFunc_ServantLookChange_All_Close()
  end
  if _ContentsGroup_FantasyHorse == true then
    PaGlobalFunc_ServantFantasySkin_Close()
  end
  PaGlobal_ServantInfo_All._currentVehicleIndexNo = servantNo
  PaGlobal_ServantInfo_All._currentNpcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  PaGlobal_ServantInfo_All:prepareOpen(updateFlag)
end
function PaGlobalFunc_ServantInfo_GetShow()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  return Panel_Dialog_ServantInfo_All:GetShow()
end
function PaGlobalFunc_ServantInfo_All_Close()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:prepareClose()
end
function PaGlobalFunc_ServantInfo_All_CloseEquipInven()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:SetShow(false)
  ToClient_padSnapIgnoreMoveToThisControl(Panel_Dialog_ServantInfo_All, false)
end
function FromClient_ServantInfo_All_OnScreenSize()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  Panel_Dialog_ServantInfo_All:ComputePos()
end
function PaGlobalFunc_ServantInfo_All_ShowAni()
  UIAni.fadeInSCR_Right(Panel_Dialog_ServantInfo_All)
  local aniInfo3 = Panel_Dialog_ServantInfo_All:addColorAnimation(0, 0.2, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
end
function PaGlobalFunc_ServantInfo_All_HideAni()
  Panel_Dialog_ServantInfo_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Dialog_ServantInfo_All:addColorAnimation(0, 0.22, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function FromClient_ClearGuildServantDeadCount()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local currentServantNo = PaGlobal_ServantList_All:stableList_SelectSlotNo(PaGlobal_ServantList_All._selectSlotNo)
  if nil == currentServantNo then
    return
  end
  local servantInfo = guildStable_getServant(currentServantNo)
  if nil == servantInfo then
    return
  end
  if servantInfo:getVehicleType() == CppEnums.VehicleType.Type_Elephant then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_RECOVERINJURY_ELEPHANT"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_RESTOREDAMAGE_ACK"))
  end
  PaGlobal_ServantInfo_All:update()
end
function PaGlobalFunc_ServantInfo_All_Update()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
end
function FromClient_ServantInfo_All_List2ServantSkill(content, key)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:updateServantSkillByList2(content, key)
end
function FromClient_ServantInfo_All_ForgetServantSkill(notUse, notUse)
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantInfo_All_SkillChangeFinish()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:update()
  PaGlobal_ServantList_All:update()
end
function FromClient_ServantInfo_All_SetBeginningLevelServant()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  local msg = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_COMPLETE_SETBEGINNINGLEVEL")
  Proc_ShowMessage_Ack_WithOut_ChattingMessage(msg)
  if nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    PaGlobalFunc_ServantInfo_All_Open(0)
  else
    PaGlobal_ServantInfo_All:update()
  end
  PaGlobal_ServantList_All:update()
end
function HandleEventLUp_ServantInfo_All_SkillChangeOpen()
  local self = PaGlobal_ServantInfo_All
  if self == nil then
    return
  end
  PaGlobalFunc_ServantFunction_All_ChangeTab(0)
  if self._currentVehicleNo == nil then
    return
  end
  if Panel_Dialog_ServantSkillManagement_All == nil then
    return
  end
  if self._currentSlotType == 0 then
    PaGlobalFunc_ServantSkillManagement_All_Open(self._currentVehicleNo, false)
  elseif self._currentSlotType == 1 then
    PaGlobalFunc_ServantSkillManagement_All_Open(self._currentVehicleNo, true)
  end
end
function HandleEventLUp_ServantInfo_All_MatingCompleteImmediately()
  if nil == Panel_Dialog_ServantInfo_All or false == Panel_Dialog_ServantInfo_All:GetShow() or nil == PaGlobal_ServantInfo_All._currentVehicleIndexNo then
    return
  end
  local servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  if nil == servantInfo then
    return
  end
  local function matingImmediately()
    stable_requestCompleteServantMating(PaGlobal_ServantInfo_All._currentVehicleIndexNo, servantInfo:getCompleteMatingFromPearl_s64())
  end
  local titleString = PAGetString(Defines.StringSheet_GAME, "LUA_IMMDEDIATELY_MSGBOX_TITLE")
  local contentString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_12", "pearl", tostring(servantInfo:getCompleteMatingFromPearl_s64()))
  local gameServiceType = getGameServiceType()
  local eCountryType = CppEnums.CountryType
  local isJapan = eCountryType.JPN_ALPHA == gameServiceType or eCountryType.JPN_REAL == gameServiceType
  local isJapanConsole = true == ToClient_isConsole() and CppEnums.ServiceResourceType.eServiceResourceType_JP == ToClient_getResourceType()
  if true == isJapan then
    local noticeString = [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_7") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_8") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_3")
    contentString = contentString .. noticeString
  elseif true == isJapanConsole then
    local noticeString = [[


]] .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_CONSOLE_2") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_8") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_GAMESHOP_NOTICE_3")
    contentString = contentString .. noticeString
  end
  local messageboxData = {
    title = titleString,
    content = contentString,
    functionYes = matingImmediately,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventOn_Servant_Tooltip_Open(key32)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All:Servant_Tooltip_Open(key32)
end
function HandleEventOnOut_ServantInfo_All_ShowSkillTitleToolTip(key32, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
  local control = UI.getChildControl(content, "StaticText_SkillName")
  if nil == control then
    return
  end
  local name = ""
  local desc = control:GetText()
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantInfo_All_ShowStallionToolTip(isShow, key32)
  if false == isShow or nil == key32 then
    TooltipSimple_Hide()
    return
  end
  local content = PaGlobal_ServantInfo_All._ui._list2_Skill:GetContentByKey(toInt64(0, key32))
  if nil == content then
    return
  end
  local control = UI.getChildControl(content, "Static_SkillStallionIcon")
  if nil == control then
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_STALLIONSKILL_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
function HandleEventScroll_ServantInfo_All_saveScrollPos()
  PaGlobal_ServantInfo_All._currentSkillListData._index = PaGlobal_ServantInfo_All._ui._list2_Skill:getCurrenttoIndex()
  PaGlobal_ServantInfo_All._currentSkillListData._pos = PaGlobal_ServantInfo_All._ui._list2_Skill:GetVScroll():GetControlPos()
end
function HandleEventOut_ServantInfo_All_SkillTooltipClose()
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_Close then
      PaGlobal_Tooltip_Skill_Servant_All_Close()
    end
  elseif nil ~= PaGlobal_Tooltip_Servant_Close then
    PaGlobal_Tooltip_Servant_Close()
  end
end
function PaGlobalFunc_ServantInfo_All_IsSkillBgShow()
  return PaGlobal_ServantInfo_All._ui._stc_SkillBg:GetShow()
end
function HandleEventLUp_ServantInfo_All_OpenEquipInven()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == PaGlobal_ServantInfo_All._currentServantInfo then
    return
  end
  PaGlobal_ServantInfo_All._startInvenSlotIndex = 0
  PaGlobal_ServantInfo_All._ui._scroll_vertical:SetControlTop()
  PaGlobal_ServantInfo_All:switchEquipInvenConsoleUI(_ContentsGroup_UsePadSnapping)
  if PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() == false and PaGlobal_ServantInfo_All._ui._servantEquipSlotList ~= nil and 0 < #PaGlobal_ServantInfo_All._ui._servantEquipSlotList then
    ToClient_padSnapChangeToTarget(PaGlobal_ServantInfo_All._ui._servantEquipSlotList[1]._slotControl)
  end
  PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:SetShow(true)
  if PaGlobal_ServantInfo_All._ui._chk_viewInven:IsCheck() == true then
    PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:SetShow(true)
  else
    PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:SetShow(false)
  end
  if PaGlobal_ServantInfo_All._ui._stc_SkillBg:GetShow() == false then
    ToClient_padSnapIgnoreMoveToThisControl(Panel_Dialog_ServantInfo_All, true)
  end
end
function HandleEventLUp_ServantInfo_All_PrepareOpenEquipInven()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All._isShowInventory = true
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil ~= uiManagerWrapper then
    uiManagerWrapper:setLuaCacheDataListBool(__eServantInfoInventoryOpen, PaGlobal_ServantInfo_All._isShowInventory, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  HandleEventLUp_ServantInfo_All_OpenEquipInven()
  PaGlobal_ServantInfo_All:updateUserInvenSlot()
end
function HandleEventLUp_ServantInfo_All_ToggleEquipInven()
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  PaGlobal_ServantInfo_All._isShowInventory = not PaGlobal_ServantInfo_All._isShowInventory
  if true == PaGlobal_ServantInfo_All._isShowInventory then
    HandleEventLUp_ServantInfo_All_PrepareOpenEquipInven()
  else
    HandleEventLUp_ServantInfo_All_CloseEquipInven()
  end
end
function HandleEventLUp_ServantInfo_All_CloseEquipInven()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if false == PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All._isShowInventory = false
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if nil ~= uiManagerWrapper then
    uiManagerWrapper:setLuaCacheDataListBool(__eServantInfoInventoryOpen, PaGlobal_ServantInfo_All._isShowInventory, CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:SetShow(false)
  PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:SetShow(false)
  ToClient_padSnapIgnoreMoveToThisControl(Panel_Dialog_ServantInfo_All, false)
end
function HandlerEventScroll_ServantInfo_All_InventoryScroll(isUp)
  if nil == Panel_Dialog_ServantInfo_All then
    return
  end
  local prevSlotIndex = PaGlobal_ServantInfo_All._startInvenSlotIndex
  local config = PaGlobal_ServantInfo_All._INVENTORY_CONFIG
  PaGlobal_ServantInfo_All._startInvenSlotIndex = UIScroll.ScrollEvent(PaGlobal_ServantInfo_All._ui._scroll_vertical, isUp, config.row, config.contentsCount, PaGlobal_ServantInfo_All._startInvenSlotIndex, config.col)
  if prevSlotIndex ~= PaGlobal_ServantInfo_All._startInvenSlotIndex then
    if true == _ContentsGroup_RenewUI_Tooltip then
      if true == PaGlobalFunc_TooltipInfo_GetShow() then
        PaGlobalFunc_TooltipInfo_Close()
        PaGlobalFunc_FloatingTooltip_Close()
      end
    else
      Panel_Tooltip_Item_hideTooltip()
    end
    PaGlobal_ServantInfo_All:updateInvenSlot()
  end
end
function HandleEventOn_ServantInfo_All_EquipToolTip(equipNo, isOn)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil == PaGlobalFunc_TooltipInfo_GetShow then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Close then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Open then
      return
    end
    if nil == PaGlobalFunc_FloatingTooltip_Close then
      return
    end
  else
    if nil == Panel_Tooltup_Item_isShow then
      return
    end
    if nil == Panel_Tooltip_Item_hideTooltip then
      return
    end
    if nil == Panel_Tooltip_Item_Show then
      return
    end
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if false == isOn then
    return
  end
  local currentServantInfo
  if PaGlobalFunc_ServantFunction_All_GetIsGuild() == true then
    currentServantInfo = guildStable_getServant(self._currentVehicleIndexNo)
  elseif PaGlobal_ServantList_All._currentSealType == PaGlobal_ServantList_All._ENUM_TYPESEALED then
    currentServantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  else
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper ~= nil then
      currentServantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    end
  end
  if currentServantInfo == nil then
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg
  if nil == control then
    return
  end
  local itemWrapper = currentServantInfo:getEquipItem(equipNo)
  if nil == itemWrapper then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  else
    Panel_Tooltip_Item_Show(itemWrapper, control, false, true)
    Panel_Tooltip_Item_Set_Position(control, nil, nil, nil, nil, true, nil)
  end
end
function HandleEventOn_ServantInfo_All_EquipInvenToolTip(itemEnchantKeyRaw, isOn)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    if nil == PaGlobalFunc_TooltipInfo_GetShow then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Close then
      return
    end
    if nil == PaGlobalFunc_TooltipInfo_Open then
      return
    end
    if nil == PaGlobalFunc_FloatingTooltip_Close then
      return
    end
  else
    if nil == Panel_Tooltup_Item_isShow then
      return
    end
    if nil == Panel_Tooltip_Item_hideTooltip then
      return
    end
    if nil == Panel_Tooltip_Item_Show then
      return
    end
  end
  if false == _ContentsGroup_RenewUI_Tooltip then
    Panel_Tooltip_Item_hideTooltip()
  end
  if false == isOn then
    return
  end
  if nil == itemEnchantKeyRaw then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
  if nil == itemSSW then
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_userInventoryBG_inStable
  if nil == control then
    return
  end
  local currentServantInfo
  if PaGlobal_ServantList_All._currentSealType == PaGlobal_ServantList_All._ENUM_TYPESEALED then
    currentServantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  else
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper ~= nil then
      currentServantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    end
  end
  if true == _ContentsGroup_RenewUI_Tooltip then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  elseif currentServantInfo ~= nil then
    Panel_Tooltip_Item_Show(itemSSW, control, true, nil, nil, nil, nil, nil, "Stable_Inventory", nil, nil, currentServantInfo:getEquipItem(itemSSW:getEquipSlotNo()))
    Panel_Tooltip_Item_Set_Position(control, nil, nil, nil, nil, true, nil)
  else
    Panel_Tooltip_Item_Show(itemSSW, control, true)
    Panel_Tooltip_Item_Set_Position(control, nil, nil, nil, nil, true, nil)
  end
end
function HandleEventOn_ServantInfo_All_ItemWrapperToolTip(slotNo, isOn)
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if _ContentsGroup_RenewUI_Tooltip == true then
    if PaGlobalFunc_TooltipInfo_GetShow == nil then
      return
    end
    if PaGlobalFunc_TooltipInfo_Close == nil then
      return
    end
    if PaGlobalFunc_TooltipInfo_Open == nil then
      return
    end
    if PaGlobalFunc_FloatingTooltip_Close == nil then
      return
    end
  else
    if Panel_Tooltup_Item_isShow == nil then
      return
    end
    if Panel_Tooltip_Item_hideTooltip == nil then
      return
    end
    if Panel_Tooltip_Item_Show == nil then
      return
    end
  end
  if _ContentsGroup_RenewUI_Tooltip == false then
    Panel_Tooltip_Item_hideTooltip()
  end
  if isOn == false then
    return
  end
  if slotNo == nil then
    return
  end
  local itemWrapper = getInventoryItemByType(ServantInfo_All_UserInventory_GetCurrentType(), slotNo)
  if itemWrapper == nil then
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_userInventoryBG_inStable
  if control == nil then
    return
  end
  local currentServantInfo
  if PaGlobal_ServantList_All._currentSealType == PaGlobal_ServantList_All._ENUM_TYPESEALED then
    currentServantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
  else
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper ~= nil then
      currentServantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    end
  end
  if _ContentsGroup_RenewUI_Tooltip == true then
    PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemWrapper, itemWrapper, Defines.TooltipTargetType.ItemWithoutCompare, 0)
  elseif currentServantInfo ~= nil then
    local itemEnchantWrapper = itemWrapper:getStaticStatus()
    if itemEnchantWrapper == nil then
      return
    end
    Panel_Tooltip_Item_Show(itemWrapper, control, false, true, nil, nil, nil, nil, "Stable_Inventory", nil, nil, currentServantInfo:getEquipItem(itemEnchantWrapper:getEquipSlotNo()))
    Panel_Tooltip_Item_Set_Position(control, nil, nil, nil, nil, true, nil)
  else
    Panel_Tooltip_Item_Show(itemWrapper, control, false, true)
    Panel_Tooltip_Item_Set_Position(control, nil, nil, nil, nil, true, nil)
  end
end
function HandleEventOn_ServantInfo_All_GetActorKeyRaw()
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if nil == PaGlobal_ServantInfo_All._currentServantInfo then
    return
  end
  return PaGlobal_ServantInfo_All._currentServantInfo:getActorKeyRaw()
end
function HandleEventOnOut_ServantInfo_All_ShowUseAddStatItemTooltip(isShow, stat)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_ServantInfo_All._ui._stc_OnlySpeed
  if nil == control or nil == stat then
    return
  end
  local statString, itemName = "", nil
  if __eServantStatTypeSpeed == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_SPEED")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_MAXSPEED")
    control = PaGlobal_ServantInfo_All._ui._stc_OnlySpeed
  elseif __eServantStatTypeAcceleration == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_ACCE")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_ACCELERATION")
    control = PaGlobal_ServantInfo_All._ui._stc_OnlyAcce
  elseif __eServantStatTypeCornering == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_CORNER")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_CORNERING")
    control = PaGlobal_ServantInfo_All._ui._stc_OnlyCorner
  elseif __eServantStatTypeBrake == stat then
    itemName = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ADDSTATITEM_BRAKE")
    statString = PAGetString(Defines.StringSheet_RESOURCE, "STABLE_INFO_TEXT_BRAKE")
    control = PaGlobal_ServantInfo_All._ui._stc_OnlyBrake
  else
    return
  end
  local name = ""
  local desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_SERVANT_USEADDSTATITEMICON_TOOLTIP", "itemName", itemName, "stat", statString)
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_ServantInfo_All_SnappingSkill(isOn, key32)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  if false == PaGlobal_ServantInfo_All._isConsole then
    return
  end
  if nil == key32 or nil == isOn or false == isOn then
    HandleEventOut_ServantInfo_All_SkillTooltipClose()
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    PaGlobal_ServantInfo_All._ui._stc_ConsoleKeyGuideY:SetShow(false)
  else
    PaGlobal_ServantInfo_All._selectSkillIndex = key32
    Panel_Dialog_ServantInfo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventOnOut_ServantInfo_All_ShowSkillTooltipByPad()")
    PaGlobal_ServantInfo_All._ui._stc_ConsoleKeyGuideY:SetShow(true)
  end
  PaGlobal_ServantInfo_All:setKeyguide()
end
function HandleEventOnOut_ServantInfo_All_ShowSkillTooltipByPad()
  if false == PaGlobal_ServantInfo_All._isConsole then
    return
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    if nil ~= PaGlobal_Tooltip_Skill_Servant_All_GetShow and true == PaGlobal_Tooltip_Skill_Servant_All_GetShow() then
      HandleEventOut_ServantInfo_All_SkillTooltipClose()
    else
      HandleEventOn_Servant_Tooltip_Open(PaGlobal_ServantInfo_All._selectSkillIndex)
    end
  elseif nil ~= Panel_Tooltip_Skill_Servant and true == Panel_Tooltip_Skill_Servant:GetShow() then
    HandleEventOut_ServantInfo_All_SkillTooltipClose()
  else
    HandleEventOn_Servant_Tooltip_Open(PaGlobal_ServantInfo_All._selectSkillIndex)
  end
end
function FromClient_LoadCompleteServantSimpleItem(servantNo)
  if nil == Panel_Dialog_ServantInfo_All and false == Panel_Dialog_ServantInfo_All:GetShow() then
    return
  end
  PaGlobal_ServantInfo_All:clearInventory()
  if nil == servantNo or 0 == servantNo or servantNo ~= PaGlobal_ServantInfo_All._currentVehicleNo then
    return
  end
  local simpleInvenWrapper = ToClient_SimpleServantInventoryWrapper(servantNo)
  if nil == simpleInvenWrapper then
    return
  end
  PaGlobal_ServantInfo_All._currentServantInventory = simpleInvenWrapper
  PaGlobal_ServantInfo_All:updateInventory()
end
function FromClient_ServantInfo_All_UpdateEquipSlot()
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  guildstable_listGuildServant()
end
function HandleEventRUp_ServantInfo_All_UnEquip(equipSlotNo)
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() == false then
    return
  end
  local servantInfo
  local sealed = 0
  local unsealed = 1
  if PaGlobal_ServantInfo_All._currentSlotType == sealed then
    if PaGlobal_ServantInfo_All._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(PaGlobal_ServantInfo_All._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    else
      servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
    end
    ToClient_unequipUnsummonedServant(servantInfo:getServantNo(), equipSlotNo)
  elseif PaGlobal_ServantInfo_All._currentSlotType == unsealed then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper == nil then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    servant_doUnequip(servantInfo:getActorKeyRaw(), equipSlotNo)
  end
end
function HandleEventRUp_ServantInfo_All_EquipFromInventory(invenSlotNo)
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:GetShow() == false then
    return
  end
  if Panel_Dialog_ServantExchange_Fantasy_All:GetShow() == true then
    return
  end
  local itemWrapper = getInventoryItemByType(ServantInfo_All_UserInventory_GetCurrentType(), invenSlotNo)
  local vestedWhenEquip = 2
  if itemWrapper ~= nil then
    local itemEnchantWrapper = itemWrapper:getStaticStatus()
    if itemEnchantWrapper == nil then
      return
    end
    if itemEnchantWrapper:get()._vestedType:getItemKey() == vestedWhenEquip and itemWrapper:get():isVested() == false then
      local function bindingItemUse()
        HandleEventRUp_ServantInfo_All_EquipFromInventoryXXX(invenSlotNo)
      end
      local messageContent
      if itemEnchantWrapper:isUserVested() then
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT_USERVESTED")
      else
        messageContent = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_CONTENT")
      end
      local messageboxData = {
        title = PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_BINDING_ALERT_TITLE"),
        content = messageContent,
        functionYes = bindingItemUse,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    else
      HandleEventRUp_ServantInfo_All_EquipFromInventoryXXX(invenSlotNo)
    end
  end
end
function HandleEventRUp_ServantInfo_All_EquipFromInventoryXXX(invenSlotNo)
  local servantInfo
  local sealed = 0
  local unsealed = 1
  if PaGlobal_ServantInfo_All._currentSlotType == sealed then
    if PaGlobal_ServantInfo_All._currentVehicleIndexNo ~= nil and PaGlobal_ServantList_All:isCrogdaloServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo) == true then
      servantInfo = ToClient_getServantCrogdaloByIndex(math.abs(PaGlobal_ServantInfo_All._currentVehicleIndexNo - tonumber(PaGlobal_ServantList_All._crogdalIndexStart)))
    else
      servantInfo = stable_getServant(PaGlobal_ServantInfo_All._currentVehicleIndexNo)
    end
    ToClient_equipUnsummonedServant(servantInfo:getServantNo(), ServantInfo_All_UserInventory_GetCurrentType(), invenSlotNo)
  elseif PaGlobal_ServantInfo_All._currentSlotType == unsealed then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper == nil then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
    if servantInfo == nil then
      return
    end
    ToClient_ServantEquipByServantNo(servantInfo:getServantNo(), ServantInfo_All_UserInventory_GetCurrentType(), invenSlotNo)
  end
end
function ServantInfo_All_UserInventory_GetCurrentType()
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._rdo_userInventory_pearl:IsChecked() then
    return CppEnums.ItemWhereType.eCashInventory
  else
    return CppEnums.ItemWhereType.eInventory
  end
end
function HandleEventLUp_ServantInfo_All_UserInventory_RadioTypeTab()
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:GetShow() == false then
    return
  end
  PaGlobal_ServantInfo_All:categoryScrollTop()
  PaGlobal_ServantInfo_All:updateUserInvenSlot()
  PaGlobal_ServantInfo_All:updateSelectBar()
end
function HandleEventPadPress_ServantInfo_All_ChangeInventoryTab(right)
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:GetShow() == false then
    return
  end
  local tabChanged = false
  if right then
    if PaGlobal_ServantInfo_All._ui._rdo_userInventory_pearl:IsCheck() == false then
      PaGlobal_ServantInfo_All._ui._rdo_userInventory_pearl:SetCheck(true)
      PaGlobal_ServantInfo_All._ui._rdo_userInventory_normal:SetCheck(false)
      tabChanged = true
    end
  elseif PaGlobal_ServantInfo_All._ui._rdo_userInventory_normal:IsCheck() == false then
    PaGlobal_ServantInfo_All._ui._rdo_userInventory_normal:SetCheck(true)
    PaGlobal_ServantInfo_All._ui._rdo_userInventory_pearl:SetCheck(false)
    tabChanged = true
  end
  if tabChanged == true then
    HandleEventLUp_ServantInfo_All_UserInventory_RadioTypeTab()
    ToClient_padSnapResetControl()
  end
end
function HandleEventLUp_ServantInfo_All_ViewUserInventoryToggle()
  if Panel_Dialog_ServantInfo_All == nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    return
  end
  if PaGlobal_ServantInfo_All._ui._stc_servantEquipInvenBg:GetShow() == false then
    return
  end
  local uiManagerWrapper = ToClient_getGameUIManagerWrapper()
  if uiManagerWrapper ~= nil then
    uiManagerWrapper:setLuaCacheDataListBool(__eServantInfoUserInventoryOpen, PaGlobal_ServantInfo_All._ui._chk_viewInven:IsCheck(), CppEnums.VariableStorageType.eVariableStorageType_User)
  end
  if PaGlobal_ServantInfo_All._ui._chk_viewInven:IsCheck() == true then
    PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:SetShow(true)
  else
    PaGlobal_ServantInfo_All._ui._stc_userInventory_inStable:SetShow(false)
  end
end
function FromClient_ServantPreviewEquipmentUpdate()
  local sealed = 0
  local unsealed = 1
  if PaGlobal_ServantInfo_All._currentSlotType == sealed then
    local slotNo = PaGlobal_ServantInfo_All._currentVehicleIndexNo
    if slotNo == nil then
      return
    end
    if isGuildStable() == false then
      stable_previewEquipItem(slotNo)
    end
  elseif PaGlobal_ServantInfo_All._currentSlotType == unsealed and isGuildStable() == false then
    ToClient_previewUnsealedServantEquipItem()
  end
end
function isEquipForLandVehicle(itemWrapper)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local itemStatic = itemSSW:get()
  if itemStatic == nil then
    return
  end
  local usableType = itemSSW:getUsableServantSubType()
  if itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Horse, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Donkey, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Camel, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Elephant, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_TwoWheelCarriage, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_FourWheeledCarriage, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_MountainGoat, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Tank, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_BabyElephant, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_RaceHorse, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_RepairableCarrage, usableType) == true then
    return true
  else
    return false
  end
end
function isEquipForSeaVehicle(itemWrapper)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local itemStatic = itemSSW:get()
  if itemStatic == nil then
    return
  end
  local usableType = itemSSW:getUsableServantSubType()
  if itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Ship, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Raft, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_FishingBoat, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_GalleyShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalTradeShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_FastShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_CashPersonalTradeShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_CashPersonalBattleShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Carrack, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_GalleyShipSolo, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalTradeShipSolo2, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalBattleShipSolo2, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalTradeShipSolo1, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalBattleShipSolo1, usableType) == true then
    return true
  else
    return false
  end
end
function GetItemEquipServantType(itemWrapper)
  local itemSSW = itemWrapper:getStaticStatus()
  if itemSSW == nil then
    return
  end
  local itemStatic = itemSSW:get()
  if itemStatic == nil then
    return
  end
  local usableType = itemSSW:getUsableServantSubType()
  if itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_TwoWheelCarriage, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_FourWheeledCarriage, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Tank, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_RepairableCarrage, usableType) == true then
    return PaGlobal_ServantInfo_All._ENUM_SERVANT_TYPE._CARRIAGE
  elseif itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Horse, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Donkey, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Camel, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_MountainGoat, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_RaceHorse, usableType) == true then
    return PaGlobal_ServantInfo_All._ENUM_SERVANT_TYPE._HORSE
  elseif itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Elephant, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_BabyElephant, usableType) == true then
    return PaGlobal_ServantInfo_All._ENUM_SERVANT_TYPE._ELEPHANT
  elseif itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Raft, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_GalleyShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalTradeShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_FastShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_CashPersonalTradeShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_CashPersonalBattleShip, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Carrack, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_GalleyShipSolo, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalTradeShipSolo2, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalBattleShipSolo2, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalTradeShipSolo1, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_PersonalBattleShipSolo1, usableType) == true then
    return PaGlobal_ServantInfo_All._ENUM_SERVANT_TYPE._OCEANSHIP
  elseif itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_Ship, usableType) == true or itemStatic:isServantTypeUsable(CppEnums.ServantKind.Type_FishingBoat, usableType) == true then
    return PaGlobal_ServantInfo_All._ENUM_SERVANT_TYPE._SHIP
  end
end
function PaGlobalFunc_ServantInfo_All_LevelUpSealServantByExpStack()
  local self = PaGlobal_ServantInfo_All
  if self == nil then
    return
  end
  local isSealServant = false
  if self._currentSlotType == 0 then
    isSealServant = true
  else
    isSealServant = false
  end
  if self._currentSlotType == 0 then
    servantInfo = stable_getServant(self._currentVehicleIndexNo)
  elseif self._currentSlotType == 1 then
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper == nil then
      return
    end
    servantInfo = temporaryWrapper:getUnsealVehicle(stable_getServantType())
  end
  PaGlobal_ServantLvUpMessageBox_All_Open(servantInfo:getServantNo(), isSealServant)
end
function HandleEventOnOut_ServantInfo_All_ShowStackLvUpTooltip(isShow)
  local self = PaGlobal_ServantInfo_All
  if self == nil then
    return
  end
  if isShow == nil or isShow == false then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui._txt_ExpValue
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_EXP_TOOLTIP")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_EXP_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
