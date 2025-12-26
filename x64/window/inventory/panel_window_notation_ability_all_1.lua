function PaGlobal_NotationAbility:initialize()
  if self._initialize == true then
    return
  end
  self._isPadMode = _ContentsGroup_UsePadSnapping
  local titleArea = UI.getChildControl(Panel_Notation_Ability, "Static_TitleArea")
  local selectArea = UI.getChildControl(Panel_Notation_Ability, "Static_SelectBG")
  self._ui._btn_close = UI.getChildControl(titleArea, "Button_Close")
  self._ui._rdo_showEquipAbility = UI.getChildControl(selectArea, "Radiobutton_Equip")
  self._ui._rdo_showTotalAbility = UI.getChildControl(selectArea, "Radiobutton_Total")
  self._ui._chk_addMonsterAtk = UI.getChildControl(selectArea, "CheckButton_Monster")
  self._ui._rdo_addKindNone = UI.getChildControl(selectArea, "RadioButton_None")
  self._ui._rdo_addKindKamaAtk = UI.getChildControl(selectArea, "RadioButton_Kama")
  self._ui._rdo_addKindAinAtk = UI.getChildControl(selectArea, "RadioButton_Ain")
  self._ui._rdo_addKindHumanAtk = UI.getChildControl(selectArea, "RadioButton_Human")
  self._ui._rdo_addKindEdaniaAtk = UI.getChildControl(selectArea, "RadioButton_Edanina")
  local sizeY = selectArea:GetSizeY()
  local sizeX = selectArea:GetSizeX()
  local panelSizeY = Panel_Notation_Ability:GetSizeY()
  local panelSizeX = Panel_Notation_Ability:GetSizeX()
  self._ui._rdo_addKindEdaniaAtk:SetShow(true)
  selectArea:SetSize(sizeX, sizeY + 40)
  Panel_Notation_Ability:SetSize(panelSizeX, panelSizeY + 40)
  self._ui._rdo_showEquipAbility:useGlowFont(true, "RealFont_17_Base", Defines.Color.C_FF616161)
  self._ui._btn_close:SetShow(self._isPadMode == false)
  local keyGuideBg = UI.getChildControl(Panel_Notation_Ability, "Static_KeyGuide_ConsoleUI")
  keyGuideBg:SetShow(self._isPadMode == true)
  if self._isPadMode == true then
    local keyGuide_A = UI.getChildControl(keyGuideBg, "StaticText_A_ConsoleUI")
    local keyGuide_B = UI.getChildControl(keyGuideBg, "StaticText_B_ConsoleUI")
    local keyGuideList = Array.new()
    keyGuideList:push_back(keyGuide_A)
    keyGuideList:push_back(keyGuide_B)
    for _, control in pairs(keyGuideList) do
      if control ~= nil then
        control:SetShow(true)
      end
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT, nil, nil)
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_NotationAbility:registEventHandler()
  if Panel_Notation_Ability == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_Close()")
  self._ui._rdo_showEquipAbility:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeViewType(" .. tostring(__eUINotationAbilityViewType_Equip) .. ")")
  self._ui._rdo_showEquipAbility:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,0)")
  self._ui._rdo_showEquipAbility:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,0)")
  self._ui._rdo_showTotalAbility:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeViewType(" .. tostring(__eUINotationAbilityViewType_Total) .. ")")
  self._ui._rdo_showTotalAbility:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,1)")
  self._ui._rdo_showTotalAbility:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,1)")
  self._ui._chk_addMonsterAtk:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeAddMonsterAtk()")
  self._ui._chk_addMonsterAtk:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,2)")
  self._ui._chk_addMonsterAtk:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,2)")
  self._ui._rdo_addKindNone:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeAddAtkType(" .. tostring(__eUINotationAbilityAddAtkType_None) .. ")")
  self._ui._rdo_addKindNone:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,3)")
  self._ui._rdo_addKindNone:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,3)")
  self._ui._rdo_addKindKamaAtk:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeAddAtkType(" .. tostring(__eUINotationAbilityAddAtkType_Kamasylvia) .. ")")
  self._ui._rdo_addKindKamaAtk:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,4)")
  self._ui._rdo_addKindKamaAtk:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,4)")
  self._ui._rdo_addKindAinAtk:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeAddAtkType(" .. tostring(__eUINotationAbilityAddAtkType_Ain) .. ")")
  self._ui._rdo_addKindAinAtk:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,5)")
  self._ui._rdo_addKindAinAtk:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,5)")
  self._ui._rdo_addKindHumanAtk:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeAddAtkType(" .. tostring(__eUINotationAbilityAddAtkType_Human) .. ")")
  self._ui._rdo_addKindHumanAtk:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,6)")
  self._ui._rdo_addKindHumanAtk:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,6)")
  self._ui._rdo_addKindEdaniaAtk:addInputEvent("Mouse_LUp", "PaGlobalFunc_NotationAbility_ChangeAddAtkType(" .. tostring(__eUINotationAbilityAddAtkType_Edania) .. ")")
  self._ui._rdo_addKindEdaniaAtk:addInputEvent("Mouse_On", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(true,7)")
  self._ui._rdo_addKindEdaniaAtk:addInputEvent("Mouse_Out", "HandleEventOnOut_NotationAbility_ShowButtonTooltip(false,7)")
  registerEvent("FromClient_UpdatePlayerAttackStat", "FromClient_NotationAbility_OnChangeStatus")
end
function PaGlobal_NotationAbility:prepareOpen(fromPanel)
  if Panel_Notation_Ability == nil then
    return
  end
  if fromPanel == nil then
    return
  end
  self:comptePanelPosition(fromPanel)
  self:updateButtonState()
  self:open()
end
function PaGlobal_NotationAbility:open()
  if Panel_Notation_Ability == nil then
    return
  end
  Panel_Notation_Ability:SetShow(true)
end
function PaGlobal_NotationAbility:prepareClose()
  if Panel_Notation_Ability == nil then
    return
  end
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_NotationAbility:close()
  if Panel_Notation_Ability == nil then
    return
  end
  Panel_Notation_Ability:SetShow(false)
end
function PaGlobal_NotationAbility:comptePanelPosition(fromPanel)
  if Panel_Notation_Ability == nil then
    return
  end
  if fromPanel == nil then
    return
  end
  local resultPosX = 0
  local resultPosY = 0
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  if fromPanel:GetShow() == true then
    local panelPosX = fromPanel:GetPosX()
    local panelPosY = fromPanel:GetPosY()
    local leftSize = panelPosX
    local rightSize = screenX - panelPosX - fromPanel:GetSizeX()
    local posX = 0
    if leftSize <= rightSize then
      posX = panelPosX + fromPanel:GetSizeX() + 5
    else
      posX = panelPosX - Panel_Notation_Ability:GetSizeX() - 5
    end
    resultPosX = posX
    resultPosY = panelPosY
  else
    resultPosX = screenX / 2 - Panel_Notation_Ability:GetSizeX() / 2
    resultPosY = screenY / 2 - Panel_Notation_Ability:GetSizeY() / 2
  end
  Panel_Notation_Ability:SetPosX(resultPosX)
  Panel_Notation_Ability:SetPosY(resultPosY)
  Panel_Notation_Ability:ComputePosAllChild()
end
function PaGlobal_NotationAbility:updateButtonState()
  if Panel_Notation_Ability == nil then
    return
  end
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  self._ui._rdo_showEquipAbility:SetCheck(viewType == __eUINotationAbilityViewType_Equip)
  self._ui._rdo_showTotalAbility:SetCheck(viewType == __eUINotationAbilityViewType_Total)
  local enableAddAtkFlag = viewType == __eUINotationAbilityViewType_Total
  local addAtkType = ToClient_GetNotationAbilityOption_AddAtkType()
  self._ui._rdo_addKindNone:SetCheck(addAtkType == __eUINotationAbilityAddAtkType_None)
  self._ui._rdo_addKindNone:SetEnable(enableAddAtkFlag == true)
  self._ui._rdo_addKindNone:SetMonoTone(enableAddAtkFlag == false)
  self._ui._rdo_addKindKamaAtk:SetCheck(addAtkType == __eUINotationAbilityAddAtkType_Kamasylvia)
  self._ui._rdo_addKindKamaAtk:SetEnable(enableAddAtkFlag == true)
  self._ui._rdo_addKindKamaAtk:SetMonoTone(enableAddAtkFlag == false)
  self._ui._rdo_addKindAinAtk:SetCheck(addAtkType == __eUINotationAbilityAddAtkType_Ain)
  self._ui._rdo_addKindAinAtk:SetEnable(enableAddAtkFlag == true)
  self._ui._rdo_addKindAinAtk:SetMonoTone(enableAddAtkFlag == false)
  self._ui._rdo_addKindHumanAtk:SetCheck(addAtkType == __eUINotationAbilityAddAtkType_Human)
  self._ui._rdo_addKindHumanAtk:SetEnable(enableAddAtkFlag == true)
  self._ui._rdo_addKindHumanAtk:SetMonoTone(enableAddAtkFlag == false)
  self._ui._rdo_addKindEdaniaAtk:SetCheck(addAtkType == __eUINotationAbilityAddAtkType_Edania)
  self._ui._rdo_addKindEdaniaAtk:SetEnable(enableAddAtkFlag == true)
  self._ui._rdo_addKindEdaniaAtk:SetMonoTone(enableAddAtkFlag == false)
  local addMonsterAtk = ToClient_GetNotationAbilityOption_AddMonsterAtk()
  self._ui._chk_addMonsterAtk:SetCheck(addMonsterAtk == true)
  self._ui._chk_addMonsterAtk:SetEnable(enableAddAtkFlag == true)
  self._ui._chk_addMonsterAtk:SetMonoTone(enableAddAtkFlag == false)
end
function PaGlobal_NotationAbility:updateOtherUI()
  if Panel_Notation_Ability == nil then
    return
  end
  if PaGlobal_RenewDropItem_All ~= nil and PaGlobalFunc_RenewDropItem_GetShow() == true then
    FromClient_RenewDropItem_OnClearQuest(false)
  end
  if PaGlobal_Equipment_All ~= nil and PaGlobal_Equipment_All:updateAbility() ~= nil and Panel_Window_Equipment_All ~= nil and Panel_Window_Equipment_All:GetShow() == true then
    PaGlobal_Equipment_All:updateAbility()
  end
  if PaGlobal_Inventory_All_ForConsole ~= nil and PaGlobal_Inventory_All_ForConsole:updateAttackStat() ~= nil and Panel_Window_Inventory ~= nil and Panel_Window_Inventory:GetShow() == true then
    PaGlobal_Inventory_All_ForConsole:updateAttackStat(true)
  end
  if PaGlobal_MainStatus_AttackStatusUpdate ~= nil and Panel_MainStatus_Remaster ~= nil and Panel_MainStatus_Remaster:GetShow() == true then
    PaGlobal_MainStatus_AttackStatusUpdate()
  end
  if PaGlobal_SelfPlayerExpGage_AttackInfoUpdate ~= nil and Panel_SelfPlayerExpGage ~= nil and Panel_SelfPlayerExpGage:GetShow() == true then
    PaGlobal_SelfPlayerExpGage_AttackInfoUpdate()
  end
  if PaGlobal_CharacterStatNew_All ~= nil and Panel_Window_StatNew_All ~= nil and Panel_Window_StatNew_All:GetShow() == true then
    PaGlobal_CharacterStatNew_Update()
  end
end
function PaGlobal_NotationAbility:getHPVEquipBonus()
  local totalHpv = 0
  local EquipNoMin = __eEquipSlotNoRightHand
  local EquipNoMax = __eEquipSlotNoCount
  local serverTime = getServerUtc64()
  for equipNo = EquipNoMin, EquipNoMax do
    local itemWrapper = ToClient_getEquipmentItem(equipNo)
    local canEquip = Toclient_checkEquipItem(equipNo, serverTime)
    if nil ~= itemWrapper and true == canEquip then
      local itemSSW = itemWrapper:getStaticStatus()
      local item_type = itemSSW:getItemType()
      local pv, hpv = 0, 0
      if 1 == item_type then
        for idx = 0, 2 do
          local currnetPv = itemSSW:ToClient_getPV(idx)
          if pv < currnetPv then
            pv = currnetPv
          end
          local currentHPV = itemSSW:ToClient_getHPV(idx)
          if hpv < currentHPV then
            hpv = currentHPV
          end
        end
      end
      local cronKey = itemSSW:getCronKey()
      local enchantLevel = itemSSW:get()._key:getEnchantLevel()
      local gradeCount = ToClient_GetCronEnchnatInfoCount(cronKey, enchantLevel)
      local lastCount = 0
      local currentGrade = 0
      local lastIndex = gradeCount - 1
      local currentEnchantFailCount = itemWrapper:getCronEnchantFailCount()
      if currentEnchantFailCount > 0 and gradeCount > 0 then
        local itemaddedPV = itemWrapper:getAddedPV()
        local itemaddedHPV = itemWrapper:getCronHPV()
        pv = pv + itemaddedPV
        hpv = hpv + itemaddedHPV
      end
      totalHpv = totalHpv + hpv
    end
  end
  return tostring(totalHpv)
end
function PaGlobal_NotationAbility:getMyAtk()
  if Panel_Notation_Ability == nil then
    return 0
  end
  local myAtk = 0
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  myAtk = ToClient_getAttackDisplayOffence(__eSkillTypeParam_Succession, true)
  if viewType == __eUINotationAbilityViewType_Total then
    local addMonsterAtk = ToClient_GetNotationAbilityOption_AddMonsterAtk()
    local addAtkType = ToClient_GetNotationAbilityOption_AddAtkType()
    local newTribeType = __eNewTribeType_Count
    if addAtkType == __eUINotationAbilityAddAtkType_Kamasylvia then
      newTribeType = __eNewTribeType_Kamasilvia
    elseif addAtkType == __eUINotationAbilityAddAtkType_Ain then
      newTribeType = __eNewTribeType_NonHuman
    elseif addAtkType == __eUINotationAbilityAddAtkType_Human then
      newTribeType = __eNewTribeType_Human
    elseif addAtkType == __eUINotationAbilityAddAtkType_Edania then
      newTribeType = __eNewTribeType_Edania
    end
    myAtk = ToClient_getAttackOffenceAll(__eSkillTypeParam_Succession, addMonsterAtk, newTribeType, false)
  end
  return myAtk
end
function PaGlobal_NotationAbility:getMyAwakenAtk()
  if Panel_Notation_Ability == nil then
    return 0
  end
  local myAwakenAtk = 0
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  myAwakenAtk = ToClient_getAttackDisplayOffence(__eSkillTypeParam_Awaken, true)
  if viewType == __eUINotationAbilityViewType_Total then
    local addMonsterAtk = ToClient_GetNotationAbilityOption_AddMonsterAtk()
    local newTribeType = __eNewTribeType_Count
    local addAtkType = ToClient_GetNotationAbilityOption_AddAtkType()
    if addAtkType == __eUINotationAbilityAddAtkType_Kamasylvia then
      newTribeType = __eNewTribeType_Kamasilvia
    elseif addAtkType == __eUINotationAbilityAddAtkType_Ain then
      newTribeType = __eNewTribeType_NonHuman
    elseif addAtkType == __eUINotationAbilityAddAtkType_Human then
      newTribeType = __eNewTribeType_Human
    elseif addAtkType == __eUINotationAbilityAddAtkType_Edania then
      newTribeType = __eNewTribeType_Edania
    end
    myAwakenAtk = ToClient_getAttackOffenceAll(__eSkillTypeParam_Awaken, addMonsterAtk, newTribeType, false)
  end
  return myAwakenAtk
end
function PaGlobal_NotationAbility:getMyDef()
  if Panel_Notation_Ability == nil then
    return 0
  end
  local myDef = ToClient_getAttackDisplayDefence(true)
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  if viewType == __eUINotationAbilityViewType_Total then
    myDef = ToClient_getAttackDefenceAll(true)
  end
  return myDef
end
function PaGlobal_NotationAbility:getIconColor()
  if Panel_Notation_Ability == nil then
    return Defines.Color.C_FFEEEEEE
  end
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  if viewType == __eUINotationAbilityViewType_Equip then
    return Defines.Color.C_FFFFFFFF
  elseif viewType == __eUINotationAbilityViewType_Total then
    return Defines.Color.C_FFF1D59F
  else
    return Defines.Color.C_FFFFFFFF
  end
end
function PaGlobal_NotationAbility:getFontColor()
  if Panel_Notation_Ability == nil then
    return Defines.Color.C_FFEEEEEE
  end
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  if viewType == __eUINotationAbilityViewType_Equip then
    return Defines.Color.C_FFFFFFFF
  elseif viewType == __eUINotationAbilityViewType_Total then
    local addAtkType = ToClient_GetNotationAbilityOption_AddAtkType()
    if addAtkType == __eUINotationAbilityAddAtkType_Kamasylvia then
      return Defines.Color.C_FF93D2CD
    elseif addAtkType == __eUINotationAbilityAddAtkType_Ain then
      return Defines.Color.C_FFECFF86
    elseif addAtkType == __eUINotationAbilityAddAtkType_Human then
      return Defines.Color.C_FFFFB6A0
    elseif addAtkType == __eUINotationAbilityAddAtkType_Edania then
      return Defines.Color.C_FFCEA6FC
    else
      return Defines.Color.C_FFF1D59F
    end
  else
    return Defines.Color.C_FFFFFFFF
  end
end
function PaGlobal_NotationAbility:getGlowFontColor()
  if Panel_Notation_Ability == nil then
    return Defines.Color.C_FFEEEEEE
  end
  local viewType = ToClient_GetNotationAbilityOption_ViewType()
  if viewType == __eUINotationAbilityViewType_Equip then
    return Defines.Color.C_FFFFFFFF
  elseif viewType == __eUINotationAbilityViewType_Total then
    local addAtkType = ToClient_GetNotationAbilityOption_AddAtkType()
    if addAtkType == __eUINotationAbilityAddAtkType_Kamasylvia then
      return Defines.Color.C_FF204343
    elseif addAtkType == __eUINotationAbilityAddAtkType_Ain then
      return Defines.Color.C_FF4A451A
    elseif addAtkType == __eUINotationAbilityAddAtkType_Human then
      return Defines.Color.C_FF5D4225
    elseif addAtkType == __eUINotationAbilityAddAtkType_Edania then
      return Defines.Color.C_FF893DD0
    else
      return Defines.Color.C_FFF1D59F
    end
  else
    return Defines.Color.C_FFFFFFFF
  end
end
