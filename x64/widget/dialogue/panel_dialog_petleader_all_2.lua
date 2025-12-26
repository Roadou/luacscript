function PaGlobal_DialogPetLeader_All_Open()
  PaGlobal_DialogPetLeader_All:prepareOpen()
end
function PaGlobal_DialogPetLeader_All_Close()
  PaGlobal_DialogPetLeader_All:prepareClose()
end
function PaGlobal_DialogPetLeader_All_PushPet(sealIndex)
  if sealIndex == nil then
    return
  end
  PaGlobal_DialogPetLeader_All:pushPet(sealIndex)
end
function PaGlobal_DialogPetLeader_All_IsUpgradeStart()
  return PaGlobal_DialogPetLeader_All._isUpgradeStart
end
function PaGlobal_DialogPetLeader_All_OnScreenSizeRefresh()
  Panel_Dialog_PetLeader_All:ComputePos()
end
function PaGlobal_DialogPetLeader_All_GetSkillTypeString(skillType)
  local paramText = ""
  if 1 == skillType then
    paramText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_ITEMGETTIME", "itemGetTime", string.format("%.1f", math.floor(skillParam:getParam(0) / 10) / 100))
  elseif 2 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDGATHER")
  elseif 3 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPK")
  elseif 4 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDPLACE")
  elseif 5 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MOBAGGRO")
  elseif 6 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_FINDRAREMONSTER")
  elseif 7 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REDUCEAUTOFISHINGTIME")
  elseif 8 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_REGISTILL")
  elseif 9 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_AUTOGETHERING")
  elseif 10 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_GETHERINGINCREASE")
  elseif 11 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_HPRECOVERY")
  elseif 12 == skillType then
    paramText = PAGetString(Defines.StringSheet_GAME, "LUA_PETINFO_PETSKILLTYPE_MPRECOVERY")
  end
  return paramText
end
function HandleEventLUp_DialogPetLeader_All_Confirm(sealIndex, itemSlotNo)
  if sealIndex == nil or itemSlotNo == nil then
    return
  end
  local pcPetData = ToClient_getPetSealedDataByIndex(sealIndex)
  if nil == pcPetData then
    return
  end
  PaGlobal_DialogPetLeader_All._ui.stc_ResultSlot:EraseAllEffect()
  PaGlobal_DialogPetLeader_All._ui.stc_ResultSlot:AddEffect("fUI_Maid_01A", false, 0, 0)
  ToClient_requestPetUpgradeByItem(pcPetData:getName(), pcPetData._petNo, CppEnums.ItemWhereType.eInventory, itemSlotNo, 1)
end
function HandleEventLUp_DialogPetLeader_All_Confirm(sealIndex, itemSlotNo)
  if sealIndex == nil or itemSlotNo == nil then
    return
  end
  local pcPetData = ToClient_getPetSealedDataByIndex(sealIndex)
  if nil == pcPetData then
    return
  end
  local function confirm_compose()
    PaGlobal_DialogPetLeader_List_All_Update()
    PaGlobal_DialogPetLeader_All._ui.stc_ResultSlot:EraseAllEffect()
    audioPostEvent_SystemUi(13, 26)
    PaGlobal_DialogPetLeader_All._ui.stc_ResultSlot:AddEffect("fUI_InGame_Pet_Out_02A", false, 0, 0)
    PaGlobal_DialogPetLeader_All._upgradeSealIndex = sealIndex
    PaGlobal_DialogPetLeader_All._upgradeInvenSlotNo = itemSlotNo
    PaGlobal_DialogPetLeader_All._isUpgradeStart = true
    Panel_Dialog_PetLeader_All:ClearUpdateLuaFunc()
    Panel_Dialog_PetLeader_All:RegisterUpdateFunc("PaGlobal_DialogPetLeader_All_Delay_PerFrameUpdate_All")
  end
  local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_PETLEADER_ALERT_POPUP_DESC")
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxMemo,
    functionYes = confirm_compose,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventOnOut_DialogPetLeader_All_ItemTooltip(isShow, itemEnchantKey)
  if false == isShow then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local enchantKey = ItemEnchantKey(itemEnchantKey)
  local itemSSW = getItemEnchantStaticStatus(enchantKey)
  if nil == itemSSW then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  local key64 = tonumber64(keyString)
  local content = PaGlobal_DialogPetLeader_All._ui.stc_ItemSlot
  if nil == content then
    Panel_Tooltip_Item_hideTooltip()
    return
  end
  Panel_Tooltip_Item_Show(itemSSW, content, true, false)
end
function HandleEventMouseOn_DialogPetLeader_All_BaseSkillTooltip(skill_idx, typeStr)
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(skill_idx)
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventMouseOn_DialogPetLeader_All_EquipSkillToolTip(skill_idx, typeStr)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skill_idx)
  local petSkillNo = skillStaticStatus:getSkillNo()
  Panel_SkillTooltip_Show(petSkillNo, false, typeStr)
end
function HandleEventMouseOut_DialogPetLeader_All_Hide_SkillToolTip()
  Panel_SkillTooltip_Hide()
end
function PaGlobal_DialogPetLeader_All_Delay_PerFrameUpdate_All(deltaTime)
  if PaGlobal_DialogPetLeader_All._isUpgradeStart == false then
    return
  end
  if PaGlobal_DialogPetLeader_All._upgradeSealIndex == nil or PaGlobal_DialogPetLeader_All._upgradeInvenSlotNo == nil then
    return
  end
  PaGlobal_DialogPetLeader_All._upgradeStartDelayTime = PaGlobal_DialogPetLeader_All._upgradeStartDelayTime + deltaTime
  if PaGlobal_DialogPetLeader_All._upgradeStartDelayTime >= 3 then
    local pcPetData = ToClient_getPetSealedDataByIndex(PaGlobal_DialogPetLeader_All._upgradeSealIndex)
    if nil == pcPetData then
      return
    end
    ToClient_requestPetUpgradeByItem(pcPetData:getName(), pcPetData._petNo, CppEnums.ItemWhereType.eInventory, PaGlobal_DialogPetLeader_All._upgradeInvenSlotNo, 1)
    PaGlobal_DialogPetLeader_All._isUpgradeStart = false
    PaGlobal_DialogPetLeader_All._upgradeStartDelayTime = 0
    PaGlobal_DialogPetLeader_All._upgradeSealIndex = nil
    PaGlobal_DialogPetLeader_All._upgradeInvenSlotNo = nil
    Panel_Dialog_PetLeader_All:ClearUpdateLuaFunc()
    return
  end
end
function FromClient_DialogPetLeader_All_Update()
  PaGlobal_DialogPetLeader_All:upgradeComplete()
  PaGlobal_DialogPetLeader_List_All_Update()
end
