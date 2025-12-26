local classType = getSelfPlayer():getClassType()
function FromClient_EnduranceUpdate(enduranceType)
  if nil ~= Panel_Dialog_ServantList_All and true == Panel_Dialog_ServantList_All:GetShow() then
    if true == _ContentsGroup_NewUI_Camp_All then
      if false == PaGlobalFunc_Camp_All_GetIsCamping() then
        return
      end
    elseif nil ~= PaGlobal_Camp and false == PaGlobal_Camp:getIsCamping() then
      return
    end
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local isNeedCheckEquip = false
  local self = PaGlobalPlayerEnduranceList
  if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    self = PaGlobalPlayerEnduranceList
    isNeedCheckEquip = true
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
    self = PaGlobalHorseEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    if nil ~= servantInfoWrapper and false == PaGlobalFunc_Util_IsCarriage(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
    self = PaGlobalCarriageEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    if nil ~= servantInfoWrapper and true == PaGlobalFunc_Util_IsCarriage(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
    self = PaGlobalShipEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
    if nil ~= servantInfoWrapper and false == PaGlobalFunc_Util_IsBigShip(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
    self = PaGlobalSailShipEnduranceList
    local servantInfoWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
    if nil ~= servantInfoWrapper and true == PaGlobalFunc_Util_IsBigShip(servantInfoWrapper:getVehicleType()) then
      isNeedCheckEquip = true
    end
  end
  if not self:checkInit() then
    return
  end
  local isShow = false
  local brokenSubToolNo = __eEquipSlotNoCount
  local minEnduranceSubTool = 999
  local isCantRepair = false
  local isPcRoomEquip = false
  local isUnusableBadEquip = false
  local enduranceCheck = 0
  if true == isNeedCheckEquip then
    for index = 0, __eEquipSlotNoCount - 1 do
      local enduranceLevel = -1
      isPcRoomEquip = false
      isUnusableBadEquip = false
      if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
        enduranceLevel = ToClient_GetPlayerEquipmentEnduranceLevel(index)
        local equipItemWrapper = ToClient_getEquipmentItem(index)
        if nil ~= equipItemWrapper then
          if equipItemWrapper:needCheckPcRoom() then
            isPcRoomEquip = true
          end
          if equipItemWrapper:needCheckBad() then
            isUnusableBadEquip = true
          end
        end
        if __eEquipSlotNoSubTool == index or __eEquipSlotNoAxe == index or __eEquipSlotNoSyringe == index or __eEquipSlotNoHoe == index or __eEquipSlotNoButcheryKnife == index or __eEquipSlotNoSkinKnife == index or __eEquipSlotNoPickAx == index or __eEquipSlotNoFishingRod == index or __eEquipSlotNoBobber == index or __eEquipSlotNoFishingHarpoon == index then
          if enduranceLevel == 0 or enduranceLevel == 1 then
            local curEndurance = equipItemWrapper:get():getEndurance()
            local maxEndurance = equipItemWrapper:get():getMaxEndurance()
            local isHardcoreChannel = ToClient_HardCoreChannelWithContensOption()
            if isHardcoreChannel == false and curEndurance < maxEndurance and minEnduranceSubTool > curEndurance and minEnduranceSubTool > 0 then
              minEnduranceSubTool = curEndurance
              brokenSubToolNo = index
              isCantRepair = isCantRepair or not equipItemWrapper:checkToRepairItem()
            else
              enduranceLevel = -1
            end
          else
            enduranceLevel = -1
          end
        end
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
        enduranceLevel = ToClient_GetHorseEquipmentEnduranceLevel(index)
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
        enduranceLevel = ToClient_GetCarriageEquipmentEnduranceLevel(index)
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
        enduranceLevel = ToClient_GetShipEquipmentEnduranceLevel(index)
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
        enduranceLevel = ToClient_GetShipEquipmentEnduranceLevel(index)
      end
      if nil ~= self.enduranceInfo[index].control then
        self.enduranceInfo[index].control:ResetVertexAni()
        if enduranceLevel < 0 then
          self.enduranceInfo[index].itemEquiped = false
          self.enduranceInfo[index].color = Defines.Color.C_FF000000
          self.enduranceInfo[index].isBroken = false
        else
          self.enduranceInfo[index].itemEquiped = true
          if enduranceLevel > 1 then
            self.enduranceInfo[index].color = Defines.Color.C_FF444444
            self.enduranceInfo[index].isBroken = false
            if isPcRoomEquip or isUnusableBadEquip then
              Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Red")
              isShow = true
            end
          else
            if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
              if enduranceLevel == 0 then
                Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Red")
              elseif enduranceLevel == 1 then
                if isPcRoomEquip or isUnusableBadEquip then
                  Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Red")
                else
                  Panel_Endurance_updateVertexAniRun(self.enduranceInfo[index].control, index, "Orange")
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
              if 0 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Body_Red", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Saddle_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_RiderFoot_Red", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Head_Red", true)
                elseif 12 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_HorseFoot_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Body_Orange", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Saddle_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_RiderFoot_Orange", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_Head_Orange", true)
                elseif 12 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Horse_HorseFoot_Orange", true)
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
              if 0 == enduranceLevel then
                if 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Wheel_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Flag_Red", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Curtain_Red", true)
                elseif 13 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Lamp_Red", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Cover_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Wheel_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Flag_Orange", true)
                elseif 6 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Curtain_Orange", true)
                elseif 13 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Lamp_Orange", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Carriage_Cover_Orange", true)
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
              if 0 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Red", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Red", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Red", true)
                elseif 7 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_SubTool_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Orange", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Orange", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Orange", true)
                elseif 7 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_SubTool_Orange", true)
                end
              end
            elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
              if 0 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Red", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Red", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Red", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Red", true)
                elseif 7 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_SubTool_Red", true)
                end
              elseif 1 == enduranceLevel then
                if 3 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Goods_Orange", true)
                elseif 4 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Head_Orange", true)
                elseif 5 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Deco_Orange", true)
                elseif 25 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_Ship_Main_Orange", true)
                elseif 7 == index then
                  self.enduranceInfo[index].control:SetVertexAniRun("Ani_Color_SubTool_Orange", true)
                end
              end
            end
            self.enduranceInfo[index].isBroken = true
            isShow = true
            enduranceCheck = enduranceCheck + 1
          end
        end
        self.enduranceInfo[index].control:SetColor(self.enduranceInfo[index].color)
      end
    end
  end
  if true == _ContentsGroup_RemasterUI_Main_Alert and nil ~= Panel_UIMain and __eEquipSlotNoCount == self.brokenSubToolNo and __eEquipSlotNoCount ~= brokenSubToolNo and false == isShow then
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
      PaGlobalFunc_Widget_Alert_Show_EndurancePc()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
      PaGlobalFunc_Widget_Alert_Show_EnduranceHorse()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
      PaGlobalFunc_Widget_Alert_Show_EnduranceCarriage()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
      PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
      PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
    end
  end
  self.brokenSubToolNo = brokenSubToolNo
  if isShow then
    if true == _ContentsGroup_RemasterUI_Main_Alert and nil ~= Panel_UIMain and (false == self.panel:GetShow() or false == self.effectBG:IsEnable()) and __eEquipSlotNoCount == self.brokenSubToolNo then
      if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
        PaGlobalFunc_Widget_Alert_Show_EndurancePc()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Horse then
        PaGlobalFunc_Widget_Alert_Show_EnduranceHorse()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Carriage then
        PaGlobalFunc_Widget_Alert_Show_EnduranceCarriage()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_Ship then
        PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
      elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip then
        PaGlobalFunc_Widget_Alert_Show_EnduranceShip()
      end
    end
    for index = 0, __eEquipSlotNoCount - 1 do
      if nil ~= self.enduranceInfo[index].control then
        if __eEquipSlotNoSubTool == index or __eEquipSlotNoAxe == index or __eEquipSlotNoSyringe == index or __eEquipSlotNoHoe == index or __eEquipSlotNoButcheryKnife == index or __eEquipSlotNoSkinKnife == index or __eEquipSlotNoPickAx == index or __eEquipSlotNoFishingRod == index or __eEquipSlotNoBobber == index or __eEquipSlotNoFishingHarpoon == index then
          self.enduranceInfo[index].control:SetShow(index == self.brokenSubToolNo)
        else
          self.enduranceInfo[index].control:SetShow(true)
        end
      end
    end
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
      local isAwakenOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
      if nil == isAwakenOpen then
        isAwakenOpen = false
      end
      self.enduranceInfo[29].control:SetShow(isAwakenOpen)
    elseif enduranceType == CppEnums.EnduranceType.eEnduranceType_SailShip and _ContentsGroup_EmployeeAutoFishing == false and self.enduranceInfo[7].control ~= nil then
      self.enduranceInfo[7].control:SetShow(false)
    end
    self.effectBG:EraseAllEffect()
    if false == self.isEffectSound then
      self.isEffectSound = true
      audioPostEvent_SystemUi(8, 6)
    end
    if ToClient_HardCoreChannelWithContensOption() == true then
      isCantRepair = true
    end
    if true == isCantRepair then
      self.noticeEndurance:SetText("")
    else
      self.noticeEndurance:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ENDURANCE_NOTICEENDURACNE3"))
    end
    self.panel:SetShow(true)
    self.effectBG:SetEnable(true)
  else
    for index = 0, __eEquipSlotNoCount - 1 do
      if nil ~= self.enduranceInfo[index].control then
        self.enduranceInfo[index].control:SetShow(false)
        self.enduranceInfo[index].control:ResetVertexAni()
      end
    end
    self.isEffectSound = false
    self.effectBG:EraseAllEffect()
    self.noticeEndurance:SetShow(false)
    self.effectBG:SetEnable(false)
    if enduranceType == CppEnums.EnduranceType.eEnduranceType_Player then
    else
      self.panel:SetShow(false)
    end
  end
  local enduranceList = {
    PaGlobalPlayerEnduranceList,
    PaGlobalHorseEnduranceList,
    PaGlobalCarriageEnduranceList,
    PaGlobalShipEnduranceList,
    PaGlobalSailShipEnduranceList
  }
  local isRepairShow = false
  for key, value in pairs(enduranceList) do
    if value.effectBG:IsEnable() and false == isRepairShow then
      if true == isCantRepair then
        value.repair_AutoNavi:SetShow(false)
        value.repair_Navi:SetShow(false)
      else
        value.repair_AutoNavi:SetShow(true)
        value.repair_Navi:SetShow(true)
      end
      isRepairShow = true
      if ToClient_isConsole() == true then
        value.repair_AutoNavi:SetShow(false)
        value.repair_Navi:SetShow(false)
      end
    else
      value.repair_AutoNavi:SetShow(false)
      value.repair_Navi:SetShow(false)
    end
    if ToClient_HardCoreChannelWithContensOption() == true then
      value.repair_AutoNavi:SetShow(false)
      value.repair_Navi:SetShow(false)
    end
  end
  FGlobal_Inventory_WeightCheck_Reposition()
end
function Panel_Endurance_updateVertexAniRun(control, idx, color)
  if control == nil then
    return
  end
  if 0 == idx then
    control:SetVertexAniRun("Ani_Color_WeaponR_" .. color, true)
  elseif 1 == idx then
    control:SetVertexAniRun("Ani_Color_WeaponL_" .. color, true)
  elseif 2 == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif 3 == idx then
    control:SetVertexAniRun("Ani_Color_Armor_" .. color, true)
  elseif 4 == idx then
    control:SetVertexAniRun("Ani_Color_Glove_" .. color, true)
  elseif 5 == idx then
    control:SetVertexAniRun("Ani_Color_Boots_" .. color, true)
  elseif 6 == idx then
    control:SetVertexAniRun("Ani_Color_Helm_" .. color, true)
  elseif 7 == idx then
    control:SetVertexAniRun("Ani_Color_Necklace_" .. color, true)
  elseif 8 == idx then
    control:SetVertexAniRun("Ani_Color_Ring1_" .. color, true)
  elseif 9 == idx then
    control:SetVertexAniRun("Ani_Color_Ring2_" .. color, true)
  elseif 10 == idx then
    control:SetVertexAniRun("Ani_Color_Earing1_" .. color, true)
  elseif 11 == idx then
    control:SetVertexAniRun("Ani_Color_Earing2_" .. color, true)
  elseif 12 == idx then
    control:SetVertexAniRun("Ani_Color_Belt_" .. color, true)
  elseif 29 == idx then
    control:SetVertexAniRun("Ani_Color_AwakenWeapon_" .. color, true)
  elseif 32 == idx then
    control:SetVertexAniRun("Ani_Color_Artifacts1_" .. color, true)
  elseif 33 == idx then
    control:SetVertexAniRun("Ani_Color_Artifacts2_" .. color, true)
  elseif __eEquipSlotNoAxe == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoSyringe == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoHoe == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoButcheryKnife == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoSkinKnife == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoPickAx == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoFishingRod == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoBobber == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  elseif __eEquipSlotNoFishingHarpoon == idx then
    control:SetVertexAniRun("Ani_Color_SubTool_" .. color, true)
  end
end
function FromClient_PlayerEnduranceUpdate()
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Player)
end
function FromClient_ServantEnduranceUpdate()
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Horse)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Carriage)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_Ship)
  FromClient_EnduranceUpdate(CppEnums.EnduranceType.eEnduranceType_SailShip)
  Panel_ShipEndurance_Position()
end
function Panel_Endurance_Update()
  FromClient_PlayerEnduranceUpdate()
  FromClient_ServantEnduranceUpdate()
end
function renderModeChange_Panel_Endurance_Update(prevRenderModeList, nextRenderModeList)
  if CheckRenderModebyGameMode(nextRenderModeList) == false then
    return
  end
  Panel_Endurance_Update()
end
registerEvent("FromClient_RenderModeChangeState", "renderModeChange_Panel_Endurance_Update")
registerEvent("FromClient_luaLoadComplete", "Panel_Endurance_Update")
registerEvent("FromClient_EquipEnduranceChanged", "FromClient_PlayerEnduranceUpdate")
registerEvent("EventEquipmentUpdate", "FromClient_PlayerEnduranceUpdate")
registerEvent("FromClient_SelfPlayerTendencyChanged", "FromClient_PlayerEnduranceUpdate")
registerEvent("EventServantEquipItem", "FromClient_ServantEnduranceUpdate")
registerEvent("EventServantEquipmentUpdate", "FromClient_ServantEnduranceUpdate")
registerEvent("FromClient_ServantEquipEnduranceChanged", "FromClient_ServantEnduranceUpdate")
registerEvent("FromClient_ServantUpdate", "FromClient_ServantEnduranceUpdate")
