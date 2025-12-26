function PaGlobalFunc_Equipment_All_Open(isShowBlackSpiritInventory, showCombatOrLife)
  if nil == Panel_Window_Equipment_All then
    return
  end
  if true == _ContentsGroup_DuelCharacterCopyEquip and nil ~= PaGlobal_Equip_CharacterTag_ItemCopy_CanOpenInventory and false == PaGlobal_Equip_CharacterTag_ItemCopy_CanOpenInventory() then
    return
  end
  if isShowBlackSpiritInventory == nil then
    isShowBlackSpiritInventory = ToClient_isShowBlackSpiritInventory()
  end
  if Panel_Window_Equip_CharacterTag_ItemCopy ~= nil and Panel_Window_Equip_CharacterTag_ItemCopy:GetShow() == true then
    PaGlobal_Equipment_All._ui.check_popup:SetShow(false)
  else
    PaGlobal_Equipment_All._ui.check_popup:SetShow(true)
  end
  if showCombatOrLife == 1 then
    PaGlobal_Equipment_All._ui.btn_Combat:SetCheck(true)
    PaGlobal_Equipment_All._ui.btn_Life:SetCheck(false)
    HandleEventLUp_Equipment_All_ChangeMode(PaGlobal_Equipment_All._EquipMode._combat)
  elseif showCombatOrLife == 2 then
    PaGlobal_Equipment_All._ui.btn_Combat:SetCheck(false)
    PaGlobal_Equipment_All._ui.btn_Life:SetCheck(true)
    HandleEventLUp_Equipment_All_ChangeMode(PaGlobal_Equipment_All._EquipMode._life)
  end
  PaGlobal_Equipment_All:prepareOpen(isShowBlackSpiritInventory)
end
function PaGlobalFunc_Equipment_All_Close(closeUISubApp)
  if nil == Panel_Window_Equipment_All or false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  if true == closeUISubApp then
    audioPostEvent_SystemUi(1, 1)
    PaGlobal_Equipment_All._ui.check_popup:SetCheck(false)
    Panel_Window_Equipment_All:CloseUISubApp()
    local isCamp = false
    isCamp = PaGlobalFunc_RepairFunc_All_IsCampingType()
    if true == isCamp then
      if true == _ContentsGroup_NewUI_Camp_All then
        PaGlobalFunc_Camp_All_Open()
      else
        PaGlobal_Camp:open()
      end
    end
  end
  PaGlobal_Equipment_All:prepareClose()
end
function PaGlobalFunc_Equipment_All_SetShow(isShow, isShowBlackSpiritInventory, showLifeEquip)
  if true == isShow then
    PaGlobalFunc_Equipment_All_Open(isShowBlackSpiritInventory, showLifeEquip)
  else
    PaGlobalFunc_Equipment_All_Close(false)
  end
end
function PaGlobalFunc_Equipment_All_ShowAni()
  Panel_Window_Equipment_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_IN)
  local aniInfo1 = Panel_Window_Equipment_All:addScaleAnimation(0, 0.08, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Window_Equipment_All:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Window_Equipment_All:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  aniInfo1:SetDisableWhileAni(true)
  local aniInfo2 = Panel_Window_Equipment_All:addScaleAnimation(0.08, 0.15, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Window_Equipment_All:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Window_Equipment_All:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
  aniInfo2:SetDisableWhileAni(true)
end
function PaGlobalFunc_Equipment_All_HideAni()
  Panel_Window_Equipment_All:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Window_Equipment_All:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
function PaGlobalFunc_Equipment_All_OnScreenResize()
  if Defines.UIMode.eUIMode_Extraction ~= GetUIMode() then
    if true == _ContentsGroup_NewUI_Inventory_All then
      if true == Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetScreenParentPosY())
      else
        Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_Equipment_All:GetSizeX() - 5)
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
      end
    elseif true == Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetScreenParentPosY())
    else
      Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Equipment_All:GetSizeX())
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetPosY())
    end
  end
end
function PaGlobalFunc_Equipment_All_UpdateSlotData()
  PaGlobal_Equipment_All:updateSlotData()
end
function PaGlobalFunc_Equipment_All_DirectPanelShow(isShow, isAni)
  if true == Panel_Window_Equipment_All:IsUISubApp() then
    return
  end
  if false == isShow then
    Panel_Window_Equipment_All:SetShow(false, isAni)
    return
  end
  Panel_Window_Equipment_All:SetShow(true, isAni)
  PaGlobal_Equipment_All:updateSlotData()
end
function PaGlobalFunc_Equipment_All_SetFunctionButtonHide(isShow)
  PaGlobal_Equipment_All._ui.btn_servantInven:SetShow(isShow)
  if ToClient_isAdultUser() == false then
    PaGlobal_Equipment_All._ui.check_underwear:SetShow(false)
  else
    PaGlobal_Equipment_All._ui.check_underwear:SetShow(isShow)
  end
  PaGlobal_Equipment_All._ui.btn_petList:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_camouflage:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_helmInvisual:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_helmOpen:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_cloak:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_subWeapon:SetShow(isShow)
  PaGlobal_Equipment_All._ui.check_alchemyStone:SetShow(isShow)
end
function PaGlobalFunc_Equipment_All_UseAlchemyStoneCheck(flag)
  PaGlobal_Equipment_All._isUsedAlchemyStone = flag
end
function PaGlobalFunc_Equipment_All_AlchemyStonCheck()
  if false == PaGlobal_Equipment_All._ui.check_alchemyStone:IsCheck() then
    return 0
  end
  local coolTime = PaGlobalAppliedBuffList:getAlchemyStoneBuff_RemainTime()
  if coolTime > -1 then
    return coolTime + 3
  end
  coolTime = 0
  local equipAlchemyStoneCoolTime = ToClient_GetEquipAlchemyStoneCoolTime()
  if 0 == equipAlchemyStoneCoolTime then
    return coolTime
  end
  coolTime = equipAlchemyStoneCoolTime / 1000 + 2
  return coolTime
end
function PaGlobalFunc_Equipment_All_IsReuseTime(deltaTime)
  if 3 <= PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime then
    PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime = 0
    return true
  end
  PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime = PaGlobal_Equipment_All._reuseAlchemyStoneCheckTime + deltaTime
  return false
end
function PaGlobalFunc_Equipment_All_PosSave()
  PaGlobal_Equipment_All._equipMentPosX = Panel_Window_Equipment_All:GetPosX()
  PaGlobal_Equipment_All._equipMentPosY = Panel_Window_Equipment_All:GetPosY()
end
function PaGlobalFunc_Equipment_All_PosLoad()
  Panel_Window_Equipment_All:SetPosX(PaGlobal_Equipment_All._equipMentPosX)
  Panel_Window_Equipment_All:SetPosY(PaGlobal_Equipment_All._equipMentPosY)
end
function PaGlobalFunc_Equipment_All_BesideInvenPos()
  if true == _ContentsGroup_NewUI_Inventory_All then
    if Panel_Window_Inventory_All:GetShow() then
      if true == Panel_Window_Inventory_All:IsUISubApp() then
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetScreenParentPosY())
      else
        Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory_All:GetPosY())
        Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory_All:GetPosX() - Panel_Window_Equipment_All:GetSizeX() - 5)
      end
    end
  elseif Panel_Window_Inventory:GetShow() then
    if true == Panel_Window_Inventory:IsUISubApp() then
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetScreenParentPosY())
    else
      Panel_Window_Equipment_All:SetPosY(Panel_Window_Inventory:GetPosY())
      Panel_Window_Equipment_All:SetPosX(Panel_Window_Inventory:GetPosX() - Panel_Window_Equipment_All:GetSizeX())
    end
  end
end
function PaGlobalFunc_Equipment_All_AccSlotNo(itemWrapper, isChange)
  local equipType = itemWrapper:getStaticStatus():getEquipType()
  local acc
  local ringSlotNo1 = __eEquipSlotNoRing1
  local ringSlotNo2 = __eEquipSlotNoRing2
  local earingSlotNo1 = __eEquipSlotNoEaring1
  local earingSlotNo2 = __eEquipSlotNoEaring2
  local artifactSlotNo1 = __eEquipSlotNoArtifact1
  local artifactSlotNo2 = __eEquipSlotNoArtifact2
  if 16 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(ringSlotNo1)
    equipItemWrapper2 = ToClient_getEquipmentItem(ringSlotNo2)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = ringSlotNo1 + PaGlobal_Equipment_All._slotRingIndex
      if true == isChange then
        if 0 == PaGlobal_Equipment_All._slotRingIndex then
          PaGlobal_Equipment_All._slotRingIndex = 1
        else
          PaGlobal_Equipment_All._slotRingIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      PaGlobal_Equipment_All._slotRingIndex = 0
      acc = ringSlotNo1
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      PaGlobal_Equipment_All._slotRingIndex = 0
      acc = ringSlotNo2
    else
      PaGlobal_Equipment_All._slotRingIndex = 0
      acc = ringSlotNo1
    end
  elseif 17 == equipType then
    equipItemWrapper = ToClient_getEquipmentItem(earingSlotNo1)
    equipItemWrapper2 = ToClient_getEquipmentItem(earingSlotNo2)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = earingSlotNo1 + PaGlobal_Equipment_All._slotEaringIndex
      if true == isChange then
        if 0 == PaGlobal_Equipment_All._slotEaringIndex then
          PaGlobal_Equipment_All._slotEaringIndex = 1
        else
          PaGlobal_Equipment_All._slotEaringIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = earingSlotNo1
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = earingSlotNo2
    else
      acc = earingSlotNo1
    end
  elseif 92 == equipType then
    if false == _ContentsGroup_ArtifactItem then
      return acc
    end
    equipItemWrapper = ToClient_getEquipmentItem(artifactSlotNo1)
    equipItemWrapper2 = ToClient_getEquipmentItem(artifactSlotNo2)
    if nil ~= equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = artifactSlotNo1 + PaGlobal_Equipment_All._slotArtifactIndex
      if true == isChange then
        if 0 == PaGlobal_Equipment_All._slotArtifactIndex then
          PaGlobal_Equipment_All._slotArtifactIndex = 1
        else
          PaGlobal_Equipment_All._slotArtifactIndex = 0
        end
      end
    elseif nil == equipItemWrapper and nil ~= equipItemWrapper2 then
      acc = artifactSlotNo1
    elseif nil ~= equipItemWrapper and nil == equipItemWrapper2 then
      acc = artifactSlotNo2
    else
      acc = artifactSlotNo1
    end
  end
  return acc
end
function HandleEventOnOut_Equipment_All_EquipmentTooltip(slotNo, isOn)
  Panel_Tooltip_Item_Show_GeneralNormal(slotNo, "equipment", isOn, false, nil, nil, Panel_Window_Equipment_All, 2, 50)
end
function HandleEventOnOut_Equipment_All_EmptySlotTooltip(slotNo, isOn)
  if nil == getSelfPlayer() then
    return
  end
  if PaGlobalFunc_Equipment_All_PushOpenDelayFunc(HandleEventOnOut_Equipment_All_EmptySlotTooltip, slotNo, isOn) == true then
    return
  end
  local tooltipControl = PaGlobal_Equipment_All._ui.txt_blankSlotTooltip
  local classType = getSelfPlayer():getClassType()
  if true == isOn then
    if classType == __eClassType_ShyWaman and __eEquipSlotNoAwakenWeapon == slotNo then
      tooltipControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
    elseif classType == __eClassType_ShyWaman and __eEquipSlotNoAvatarAwakenWeapon == slotNo then
      tooltipControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON_CASH"))
    else
      tooltipControl:SetText(PaGlobal_Equipment_All._slotNoIdToString[slotNo])
    end
    tooltipControl:SetSize(tooltipControl:GetTextSizeX() + 30, 20)
    tooltipControl:SetPosX(PaGlobal_Equipment_All._ui.stc_circle:GetPosX() + PaGlobal_Equipment_All.slots[slotNo].icon:GetPosX() - tooltipControl:GetTextSizeX())
    if tooltipControl:GetPosX() < 0 then
      tooltipControl:SetPosX(0)
    end
    tooltipControl:SetPosY(PaGlobal_Equipment_All._ui.stc_circle:GetPosY() + PaGlobal_Equipment_All.slots[slotNo].icon:GetPosY())
    tooltipControl:SetShow(true)
  else
    tooltipControl:SetShow(false)
  end
end
function HandleEventLUp_Equipment_All_EquipSlotLClick(slotNo)
  if true == DragManager:isDragging() and nil ~= Panel_Window_StackExtraction_All and true == Panel_Window_StackExtraction_All:GetShow() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALL_CANTEQUIP_ENCHANT_MODE"))
    DragManager:clearInfo()
    return
  end
  local inventoryPanel
  if true == _ContentsGroup_NewUI_Inventory_All then
    inventoryPanel = Panel_Window_Inventory_All
  else
    inventoryPanel = Panel_Window_Inventory
  end
  if DragManager.dragStartPanel == inventoryPanel then
    local inventoryType = Inventory_GetCurrentInventoryType()
    local dragSlotNo = DragManager.dragSlotInfo
    if nil == dragSlotNo then
      return
    end
    local itemWrapper = getInventoryItemByType(inventoryType, dragSlotNo)
    if nil ~= itemWrapper then
      local itemStatic = itemWrapper:getStaticStatus()
      if itemStatic:isEquipable() then
        if true == _ContentsGroup_NewUI_Inventory_All then
          PaGlobalFunc_Inventory_All_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
        else
          Inventory_SlotRClickXXX(DragManager.dragSlotInfo, slotNo)
        end
        DragManager:clearInfo()
        PaGlobal_Equipment_All._ui.txt_blankSlotTooltip:SetShow(false)
      end
    end
  else
    local itemWrapper = ToClient_getEquipmentItem(slotNo)
    if nil == itemWrapper then
      HandleEventLUp_Equipment_All_ItemAcquireHelper(slotNo)
    end
  end
end
function HandleEventRUp_Equipment_All_EquipSlotRClick(slotNo)
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    Panel_Tooltip_Item_hideTooltip()
    if __eEquipSlotNoAvatarUnderwear == slotNo then
      PaGlobal_Equipment_All:hideUnderwear()
    end
    local repairPanel = Panel_Dialog_Repair_Function_All
    local endurancePanel = Panel_Window_Endurance_Recovery_All
    local seasonUpgradePanel
    local itemSSW = itemWrapper:getStaticStatus()
    local isChangeSeasonItem = false
    if repairPanel:IsShow() and nil ~= endurancePanel and false == endurancePanel:GetShow() then
      PaGlobalFunc_RepairFunc_All_EquipWindowRClick(slotNo, itemWrapper)
    elseif repairPanel:IsShow() and nil ~= endurancePanel and true == endurancePanel:GetShow() then
      equipmentDoUnequip(slotNo)
    else
      equipmentDoUnequip(slotNo)
    end
  end
end
function HandleEventLUp_Equipment_All_AvatarShowToggle(slotNo)
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil and (true == selfPlayer:get():getUnderwearModeInhouse() or true == selfPlayer:get():getSwimmingSuitMode()) then
    local isChecked = PaGlobal_Equipment_All.avataSlots[slotNo]:IsCheck()
    if isChecked then
      isChecked = false
    else
      isChecked = true
    end
    PaGlobal_Equipment_All.avataSlots[slotNo]:SetCheck(isChecked)
    return
  end
  local isChecked = PaGlobal_Equipment_All.avataSlots[slotNo]:IsCheck()
  if true == isChecked then
    ToClient_SetAvatarEquipSlotFlag(slotNo)
  else
    ToClient_ResetAvatarEquipSlotFlag(slotNo)
  end
  Toclient_setShowAvatarEquip()
end
function HandleEventLUp_Equipment_All_QuestBook()
  local itemWrapper = ToClient_getEquipmentItem(__eEquipSlotNoQuestBook)
  if nil == itemWrapper then
    HandleEventLUp_Equipment_All_ItemAcquireHelper(__eEquipSlotNoQuestBook)
  elseif isKeyPressed(CppEnums.VirtualKeyCode.KeyCode_SHIFT) and (true == questList_isClearQuest(21108, 1) or true == questList_isClearQuest(678, 7)) then
    PaGlobalFunc_Achievement_Open()
    InventoryWindow_Close()
  end
end
function HandleEventLUp_Equipment_All_CheckPopupUI()
  if true == PaGlobal_Equipment_All._ui.check_popup:IsCheck() then
    Panel_Window_Equipment_All:OpenUISubApp()
  else
    Panel_Window_Equipment_All:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventLUp_Equipment_All_ServantInventoryOpen()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if GetUIMode() == Defines.UIMode.eUIMode_Repair then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_REPAIRMODENOOPENINVENTORY"))
    return
  end
  if selfplayerIsInHorseRace() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_OPEN_SERVENTINVENTORY"))
    return
  end
  local isFreeBattle = selfPlayer:get():isBattleGroundDefine()
  if true == isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_FREEBATTLE_NOT_USE"))
    return
  end
  if true == _ContentsGroup_NewUI_Camp_All then
    PaGlobalFunc_CampWarehouse_All_CloseWareHouseOnly()
  end
  ServantInventory_OpenAll()
  Panel_Window_ServantInventory:SetPosX(Panel_Window_Equipment_All:GetPosX() - Panel_Window_ServantInventory:GetSizeX() - 5)
  Panel_Window_ServantInventory:SetPosY(Panel_Window_Equipment_All:GetPosY())
end
function HandleEventLUp_Equipment_All_ShowNameWhenCamouflage()
  Toclient_setShowNameWhenCamouflage(not getSelfPlayer():get():isShowNameWhenCamouflage())
end
function HandleEventLUp_Equipment_All_HelmInvisual()
  selfPlayerShowHelmet(not PaGlobal_Equipment_All._ui.check_helmInvisual:IsCheck())
  PaGlobal_Equipment_All:updateHelmIcon()
end
function HandleEventLUp_Equipment_All_HelmOpen()
  selfPlayerShowBattleHelmet(PaGlobal_Equipment_All._ui.check_helmOpen:IsCheck())
  PaGlobal_Equipment_All:updateHelmIcon()
end
function HandleEventLUp_Equipment_All_ShowCloak()
  selfPlayerShowCloak(not PaGlobal_Equipment_All._ui.check_cloak:IsCheck())
end
function HandleEventLUp_Equipment_All_ShowUnderWear()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == selfPlayer:get():isWearingUnderwear() and false == selfPlayer:get():isWearingSwimmingSuit() then
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
    return
  end
  if selfPlayer:get():isWearingBack() == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_UNDERWEAR_BACKSLOT_NO"))
    PaGlobal_Equipment_All._ui.check_underwear:SetCheck(false)
    return
  end
  if true == selfPlayer:get():isWearingSwimmingSuit() then
    if false == IsSelfPlayerWaitAction() and false == IsSelfPlayerSwimmingWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_SWIMMINGSUIT"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getSwimmingSuitMode())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if true == isSafeZone or true == IsSelfPlayerSwimmingWaitAction() then
      if true == selfPlayer:get():getSwimmingSuitMode() then
        selfPlayer:get():setSwimmingSuitMode(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setSwimmingSuitMode(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_SWIMMINGSUIT_ALERT"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getSwimmingSuitMode()))
    end
  else
    if false == IsSelfPlayerWaitAction() or true == IsSelfPlayerBattleWaitAction() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_UNDERWEAR"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
      return
    end
    local regionInfo = getRegionInfoByPosition(selfPlayer:get():getPosition())
    local isSafeZone = regionInfo:get():isSafeZone()
    if isSafeZone then
      if selfPlayer:get():getUnderwearModeInhouse() then
        selfPlayer:get():setUnderwearModeInhouse(false)
        Toclient_setShowAvatarEquip()
      else
        selfPlayer:get():setUnderwearModeInhouse(true)
      end
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_UNDERWARE_ALERT"))
      PaGlobal_Equipment_All._ui.check_underwear:SetCheck(selfPlayer:get():getUnderwearModeInhouse())
    end
  end
end
function HandleEventLUp_Equipment_All_ShowSubWeapon()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  if false == IsSelfPlayerWaitAction() or true == IsSelfPlayerBattleWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_CURRENTACTION_NOT_HIDEWEAPON"))
    PaGlobal_Equipment_All._ui.check_subWeapon:SetCheck(not PaGlobal_Equipment_All._ui.check_subWeapon:IsCheck())
    return
  end
  selfPlayerShowSubWeapon(not PaGlobal_Equipment_All._ui.check_subWeapon:IsCheck())
end
function HandleEventOnOut_Equipment_All_ToggleButtonToolTip(isShow, btnType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control, icon
  if btnType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_SERVANTINVENTORY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_SERVANTINVENTORY_DESC")
    control = PaGlobal_Equipment_All._ui.btn_servantInven
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.btn_servantInven, "Static_Icon")
  elseif btnType == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_CAMOUFLAGE_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_CAMOUFLAGE_TOOLTIP_DESC")
    control = PaGlobal_Equipment_All._ui.check_camouflage
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.check_camouflage, "Static_Icon")
  elseif btnType == 2 then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    if true == PaGlobal_Equipment_All._isSwimmingSuitContentEnable and true == selfPlayer:get():isWearingSwimmingSuit() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SWIMMINGSUIT_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SWIMMINGSUIT_TOOLTIP_DESC")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_UNDERWEAR_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_UNDERWEAR_TOOLTIP_DESC")
    end
    control = PaGlobal_Equipment_All._ui.check_underwear
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.check_underwear, "Static_Icon")
  elseif btnType == 3 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_PETLIST_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_PETLIST_DESC")
    control = PaGlobal_Equipment_All._ui.btn_petList
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.btn_petList, "Static_Icon")
  elseif btnType == 4 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELM_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELM_DESC")
    control = PaGlobal_Equipment_All._ui.check_helmInvisual
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.check_helmInvisual, "Static_Icon")
  elseif btnType == 5 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELMOPEN_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_CHECKHELMOPEN_DESC")
    control = PaGlobal_Equipment_All._ui.check_helmOpen
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.check_helmOpen, "Static_Icon")
  elseif btnType == 6 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIP_CLOAK_DESC")
    control = PaGlobal_Equipment_All._ui.check_cloak
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.check_cloak, "Static_Icon")
  elseif btnType == 7 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_HIDE_SUBWEAPON_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_HIDE_SUBWEAPON_TOOLTIP_DESC")
    control = PaGlobal_Equipment_All._ui.check_subWeapon
    icon = UI.getChildControl(PaGlobal_Equipment_All._ui.check_subWeapon, "Static_Icon")
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc, icon)
end
function HandleEventOnOut_Equipment_All_PopupUITooltip(isShow)
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if PaGlobal_Equipment_All._ui.check_popup:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(PaGlobal_Equipment_All._ui.check_popup, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Equipment_All_ClickDetailInfo()
  if PaGlobal_Equipment_All == nil then
    return
  end
  PaGlobalFunc_NotationAbility_ChangeViewTypeByCheckButton(PaGlobal_Equipment_All._ui.chk_detailInfo)
  HandleEventOnOff_Equipment_All_ClickDetailInfo(true)
end
function HandleEventOnOff_Equipment_All_ClickDetailInfo(isOn)
  if PaGlobal_Equipment_All == nil then
    return
  end
  if isOn == true then
    local control = PaGlobal_Equipment_All._ui.chk_detailInfo
    local name = ""
    local desc = ""
    if control:IsCheck() == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_EQUIPSTATS_VIEW_BTN")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_TOTALSTATS_DD")
    else
      name = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_TOTALSTATS_VIEW_BTN")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_DROPINFO_RECOMMAND_MONSTERATT_SUM")
    end
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventLUp_Equipment_All_NotationSetting()
  if PaGlobal_Equipment_All == nil then
    return
  end
  PaGlobalFunc_NotationAbility_ToggleShow(Panel_Window_Equipment_All)
end
function HandleEventOnOff_Equipment_All_NotationSetting(isOn)
  if PaGlobal_Equipment_All == nil then
    return
  end
  if isOn == true then
    local control = PaGlobal_Equipment_All._ui.btn_notationSetting
    local childControl = UI.getChildControl(control, "Static_Icon")
    local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NOTATION_ABILITY_TITLE")
    local desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    if _ContentsGroup_UsePadSnapping == true then
      desc = nil
    end
    TooltipSimple_Show(control, name, desc, childControl)
  else
    TooltipSimple_Hide()
  end
end
function HandleEventOnOut_Equipment_All_StatTooltip(isShow, tipType)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  if 0 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_ATTACK")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ATTACK_TEXT_TOOLTIP_DESC")
    control = PaGlobal_Equipment_All._ui.txt_attackText
  elseif 1 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_DEFENCE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_DEFENCE_TEXT_TOOLTIP_DESC")
    control = PaGlobal_Equipment_All._ui.txt_defenceText
  elseif 2 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "EQUIPMENT_TOOLTIP_AWAKEN_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_AWAKEN_TEXT_TOOLTIP_DESC")
    control = PaGlobal_Equipment_All._ui.txt_awakenText
  elseif 3 == tipType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_SHYSTAT_1")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SHYSTAT1_DESC")
    control = PaGlobal_Equipment_All._ui.txt_shyStatText
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Equipment_All_CostumeAccToolTip(isShow, btnType, slotNo)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  local desc = ""
  local control
  if btnType == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DESC")
    control = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_circle, PaGlobal_Equipment_All._avataEquipSlotId[slotNo])
  elseif btnType == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DECO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_TOOLTIPS_BTN_CHECKFLAG_DECO_DESC")
    control = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_circle, PaGlobal_Equipment_All._avataEquipSlotId[slotNo])
  elseif btnType == 2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_VISUAL_HIDE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_VISUAL_HIDE_DESC")
    control = UI.getChildControl(PaGlobal_Equipment_All._ui.stc_circle, PaGlobal_Equipment_All._avataEquipSlotId[slotNo])
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventOnOut_Equipment_All_AlchemyStoneToolTip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALCHEMYSTONETITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_ALCHEMYSTONEDESC")
  TooltipSimple_Show(PaGlobal_Equipment_All._ui.check_alchemyStone, name, desc)
end
function HandleEventLUp_Equipment_All_AlchemyStoneCheckEvent(isShow)
  local isSolare = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  local isCheck = PaGlobal_Equipment_All._ui.check_alchemyStone:IsCheck()
  if nil ~= isShow and isCheck then
    isCheck = isShow
  end
  if false == isSolare then
    ToClient_getGameUIManagerWrapper():setLuaCacheDataListBool(__eAlchemyStone, isCheck, CppEnums.VariableStorageType.eVariableStorageType_Character)
  end
end
function HandleEventOnOut_Equipment_All_BannerTooltip(isShow, bannerType)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    PaGlobal_Equipment_All_ShowSeasonUpgradeEquipEffect(false)
    return
  end
  local name, desc, control = "", "", nil
  if PaGlobal_Equipment_All._bannerType.SEASONPASS == bannerType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASON_MAIN_TITLE")
    control = PaGlobal_Equipment_All._ui.stc_seasonBannerPass
  elseif PaGlobal_Equipment_All._bannerType.TOTALREWARD == bannerType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_TOTALREWARD_TITLE")
    control = PaGlobal_Equipment_All._ui.stc_seasonBannerReward
  elseif PaGlobal_Equipment_All._bannerType.SEASONUPGRADE == bannerType then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASON_UPGRADE_TITLE")
    control = PaGlobal_Equipment_All._ui.stc_sword
    PaGlobal_Equipment_All_ShowSeasonUpgradeEquipEffect(true)
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function HandleEventLUp_Equipment_All_ChangeMode(equipMode)
  if equipMode == PaGlobal_Equipment_All._EquipMode._combat then
    PaGlobal_Equipment_All._ui.stc_circle:SetShow(true)
    PaGlobal_Equipment_All._ui.stc_LifeEquipBg:SetShow(false)
    PaGlobal_Equipment_All._ui.rdo_stanceCombat:SetShow(false)
    PaGlobal_Equipment_All._ui.rdo_stanceFishing:SetShow(false)
    PaGlobal_Equipment_All._ui.rdo_stanceJaksal:SetShow(false)
    PaGlobal_Equipment_All._ui.txt_stance:SetShow(false)
  elseif equipMode == PaGlobal_Equipment_All._EquipMode._life then
    PaGlobal_Equipment_All._ui.stc_circle:SetShow(false)
    PaGlobal_Equipment_All._ui.stc_LifeEquipBg:SetShow(true)
    PaGlobal_Equipment_All._ui.rdo_stanceCombat:SetShow(false)
    PaGlobal_Equipment_All._ui.rdo_stanceFishing:SetShow(false)
    PaGlobal_Equipment_All._ui.rdo_stanceJaksal:SetShow(false)
    PaGlobal_Equipment_All._ui.txt_stance:SetShow(false)
  end
end
function HandleEventOnOut_Equipment_All_SimpleTooltip(equipMode, isShow)
  if nil == isShow or false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control = "", "", nil
  if equipMode == PaGlobal_Equipment_All._EquipMode._combat then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_GUILD_FAVORTYPE1")
    control = PaGlobal_Equipment_All._ui.btn_Combat
  elseif equipMode == PaGlobal_Equipment_All._EquipMode._life then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_QUEST_GUILD_FAVORTYPE2")
    control = PaGlobal_Equipment_All._ui.btn_Life
  end
  if nil == control then
    return
  end
  TooltipSimple_Show(control, name, desc)
end
function FromClient_Equipment_All_ChangeUnderwearMode(isUnderwearModeInHouse)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_Equipment_All._ui.check_underwear:SetCheck(isUnderwearModeInHouse)
end
function FromClient_Equipment_All_ChangeSwimmingSuitMode(isShowSwimmingSuit)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  PaGlobal_Equipment_All._ui.check_underwear:SetCheck(isShowSwimmingSuit)
end
function FromClient_Equipment_All_FamilySpeicalInfoChange()
  if false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  PaGlobal_Equipment_All:updateSlotData()
end
function FromClient_Equipment_All_CharacterSpeicalInfoChange()
  if false == Panel_Window_Equipment_All:GetShow() then
    return
  end
  PaGlobal_Equipment_All:updateSlotData()
end
function FromClient_Equipment_All_EventEquipItem(slotNo)
  local slot_boder = PaGlobal_Equipment_All.slots[slotNo]
  if slotNo > 33 and slotNo < 43 then
    HandleEventLUp_Equipment_All_ChangeMode(PaGlobal_Equipment_All._EquipMode._life)
    if slotNo > 39 and slotNo < 43 then
      PaGlobalFunc_ServantIcon_LifeRingMenu_Alarm()
    end
    PaGlobal_Equipment_All._ui.btn_Life:SetCheck(true)
    PaGlobal_Equipment_All._ui.btn_Combat:SetCheck(false)
    PaGlobal_Equipment_All._ui.stc_LifeEquipBg:AddEffect("UI_ItemInstall_BigRing", false, 1.3, -94.7)
    slot_boder.border:AddEffect("UI_ItemInstall_Cash", false, 0, 0)
    return
  end
  if slot == nil then
    return
  end
  HandleEventLUp_Equipment_All_ChangeMode(PaGlobal_Equipment_All._EquipMode._combat)
  PaGlobal_Equipment_All._ui.btn_Life:SetCheck(false)
  PaGlobal_Equipment_All._ui.btn_Combat:SetCheck(true)
  local slot = PaGlobal_Equipment_All.slots[slotNo]
  if slotNo > 13 and slotNo < 24 then
    slot.border:AddEffect("UI_ItemInstall_Cash", false, 0, 0)
  else
    slot.border:AddEffect("UI_ItemInstall", false, 0, 0)
  end
  slot.border:AddEffect("fUI_SkillButton01", false, 0, 0)
  if false == _ContentsGroup_ArtifactItem then
    if slotNo < 14 or 29 == slotNo or 32 == slotNo or 33 == slotNo then
      PaGlobal_Equipment_All._ui.stc_circle:AddEffect("UI_ItemInstall_BigRing", false, -0.9, 0)
    else
      PaGlobal_Equipment_All._ui.stc_circle:AddEffect("UI_ItemInstall_BigRing02", false, -0.9, 0)
    end
  elseif slotNo < 14 or 29 == slotNo or 32 == slotNo or 33 == slotNo then
    PaGlobal_Equipment_All._ui.stc_circle:AddEffect("UI_ItemInstall_BigRing", false, 0, 38)
  else
    PaGlobal_Equipment_All._ui.stc_circle:AddEffect("UI_ItemInstall_BigRing02", false, 0, 38)
  end
  local itemWrapper = ToClient_getEquipmentItem(slotNo)
  if nil ~= itemWrapper then
    local offenceStatus = 0
    local AwakenStatus = 0
    local DefenceStatus = 0
    if _ContentsGroup_RenewCharacterStatusViewMode == true and PaGlobalFunc_NotationAbility_IsLateInitialized ~= nil and PaGlobalFunc_NotationAbility_IsLateInitialized() == true then
      offenceStatus = PaGlobalFunc_NotationAbility_GetMyAtk()
      AwakenStatus = PaGlobalFunc_NotationAbility_GetMyAwakenAtk()
      DefenceStatus = PaGlobalFunc_NotationAbility_GetMyDef()
    else
      ToClient_updateAttackStat()
      offenceStatus = ToClient_getOffence()
      AwakenStatus = ToClient_getAwakenOffence()
      DefenceStatus = ToClient_getDefence()
    end
    if PaGlobal_Equipment_All._offenceValue ~= offenceStatus then
      PaGlobal_Equipment_All._ui.txt_attackValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      PaGlobal_Equipment_All._ui.txt_attackValue:AddEffect("UI_SkillButton01", false, 19, -1)
    end
    if PaGlobal_Equipment_All._awakenOffecnValue ~= AwakenStatus and PaGlobal_Equipment_All._awakenWeaponContentsOpen == true then
      PaGlobal_Equipment_All._ui.txt_awakenValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      PaGlobal_Equipment_All._ui.txt_awakenValue:AddEffect("UI_SkillButton01", false, 19, -1)
    end
    if PaGlobal_Equipment_All._defenceValue ~= DefenceStatus then
      PaGlobal_Equipment_All._ui.txt_defenceValue:AddEffect("fUI_SkillButton01", false, 19, -1)
      PaGlobal_Equipment_All._ui.txt_defenceValue:AddEffect("UI_SkillButton01", false, 19, -1)
    end
    PaGlobal_TutorialManager:handleEquipItem(slotNo)
  end
  PaGlobal_Equipment_All:updateUnderwearSlot(slotNo)
end
function PaGlobal_Equipment_All_ShowSeasonUpgradeEquipEffect(isSet)
  if true == isSet then
    if false == PaGlobal_Equipment_All._seasonUpgradeEffect then
      PaGlobal_Equipment_All._seasonUpgradeEffect = isSet
      PaGlobalFunc_Equipment_All_UpdateSlotData()
      Inventory_SetFunctor(PaGlobal_SeasonEquipment_Upgrade_Filter, nil, nil, nil)
    end
  elseif true == PaGlobal_Equipment_All._seasonUpgradeEffect and nil ~= Panel_Window_Season_Equiptment_Upgrade_All and false == Panel_Window_Season_Equiptment_Upgrade_All:GetShow() then
    PaGlobal_Equipment_All._seasonUpgradeEffect = isSet
    PaGlobalFunc_Equipment_All_UpdateSlotData()
    Inventory_SetFunctor(nil, nil, nil, nil)
    PaGlobal_Equipment_All_ShowSeasonUpgradeBannerEffect(true)
  end
end
function PaGlobal_Equipment_All_ShowSeasonUpgradeBannerEffect(isShow)
  PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:EraseAllEffect()
  local equipInven = ToClient_CanChangeEquipItem(CppEnums.ItemWhereType.eEquip)
  local Inventory = ToClient_CanChangeEquipItem(CppEnums.ItemWhereType.eInventory)
  if true == isShow and (true == equipInven or true == Inventory) then
    PaGlobal_Equipment_All._ui.stc_seasonBannerUpgrade:AddEffect("fUI_Equipment_UP_01A", true, 0, 0)
  end
end
function HandleEventOnOut_Equipment_All_AccessoryStepUpTooltip(isOn)
  local self = PaGlobal_Equipment_All
  if self == nil then
    return
  end
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EQUIP_DONGUPGRADE_TITLE")
  local desc = PAGetString(Defines.StringSheet_GAME, "LUA_EQUIP_DONGUPGRADE_INVENTORYBUTTON_TOOLTIP")
  if isOn == true then
    TooltipSimple_Show(self._ui.stc_accessoryStepUpBanner, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function PaGlobalFunc_Equipment_All_UpdatePerFrame(deltaTime)
  if Panel_Window_Equipment_All == nil or Panel_Window_Equipment_All:GetShow() == false then
    return
  end
  PaGlobalFunc_Equipment_All_OpenDelayFuncImpl(deltaTime)
end
function PaGlobalFunc_Equipment_All_OpenDelayFuncImpl(deltaTime)
  local self = PaGlobal_Equipment_All
  if self._openAfterTime > self._delayFuncTime then
    return
  end
  self._openAfterTime = self._openAfterTime + deltaTime * 1000
  if #self._delayFuncList == 0 then
    return
  end
  if self._openAfterTime > self._delayFuncTime then
    for funcIdx = 1, #self._delayFuncList do
      if self._delayFuncList[funcIdx] ~= nil then
        self._delayFuncList[funcIdx]._func(self._delayFuncList[funcIdx]._param0, self._delayFuncList[funcIdx]._param1)
      end
    end
  end
end
function PaGlobalFunc_Equipment_All_PushOpenDelayFunc(func, param0, param1)
  local self = PaGlobal_Equipment_All
  if self._openAfterTime > self._delayFuncTime then
    return false
  end
  local findIdx = #self._delayFuncList + 1
  if #self._delayFuncList ~= 0 then
    for funcIdx = 1, #self._delayFuncList do
      if self._delayFuncList[funcIdx] ~= nil and self._delayFuncList[funcIdx]._func == func then
        findIdx = funcIdx
      end
    end
  end
  self._delayFuncList[findIdx] = {
    _func = func,
    _param0 = param0,
    _param1 = param1
  }
  return true
end
function PaGlobalFunc_Equipment_All_ToggleEffectSwitch(equipSlotNo)
  if _ContentsGroup_ItemSkillOption == false then
    return
  end
  local isSet = ToClient_isSetUniqueEquipEffectSlotFlag(equipSlotNo)
  if isSet == true then
    ToClient_resetUniqueEquipEffectSlotFlag(equipSlotNo)
  else
    ToClient_setUniqueEquipEffectSlotFlag(equipSlotNo)
  end
end
