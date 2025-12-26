local _panel = Panel_Widget_ServantIcon
local UI_VT = CppEnums.VehicleType
_panel:SetDragEnable(false)
_panel:setGlassBackground(true)
local ServantIcon = {
  _ui = {
    btn_IconTemplate = UI.getChildControl(_panel, "Button_ServantIcon_template"),
    stc_ProgressBg = UI.getChildControl(_panel, "Static_HorseProgressBg"),
    progress_Hp = UI.getChildControl(_panel, "CircularProgress_Hp"),
    progress_Stamina = UI.getChildControl(_panel, "CircularProgress_Stamina"),
    stc_expMark = UI.getChildControl(_panel, "Static_expMark"),
    txt_bubbleBox = UI.getChildControl(_panel, "StaticText_BubbleBox")
  },
  _iconType = {
    servant_Land = 0,
    servant_Water = 1,
    servant_Summon = 2,
    servant_Awake = 3,
    servant_Guild = 4,
    monster = 5,
    house = 6,
    worker = 7,
    harvest = 8,
    pet = 9,
    maid = 10,
    camp = 11,
    battle = 12,
    tag = 13,
    fairy = 14,
    PartyRecruit = 15,
    rentInstanceField = 16,
    AutoUseBuffItem = 17,
    LifeRingMenu = 18,
    fishingCamp = 19,
    count = 20
  },
  _whistleType = {
    None = 0,
    PcRoom = 1,
    Whistle = 2,
    SuperWhistle = 3
  },
  _iconTable = {},
  _startPosX = 0,
  _startPosY = 100,
  _gapX = 60,
  _hitEffect = nil,
  _less10Effect = nil,
  _servant_BeforHP = 0,
  _currentNaviType = nil,
  _isTaming = false,
  _tamingLastNotifyTime = 0,
  _tamingCurrentTime = 0,
  _hungryCheck = false,
  _workerListCount = nil,
  _isSiegeMonsterIcon = false,
  _isServantIconFunctionAvailable = false,
  _lastWhistleType = 0,
  _autoUseBuffItem_UseItemTermTime = 1,
  _autoUseBuffItem_ExpireTime = 0,
  _stc_nextUseItemParent = nil,
  _stc_nextUseItemSlotBg = nil,
  _stc_nextUseItemProgress = nil,
  lifeActionModeChange = false,
  _slotConfig = {createIcon = true}
}
local _servantSimpleUIAlpha = 0.7
function ServantIcon:init()
  if _ContentsGroup_OneButtonBuff == true then
    self._stc_nextUseItemParent = UI.getChildControl(_panel, "Static_NextUseItem_Bubble")
    self._stc_nextUseItemProgress = UI.getChildControl(self._stc_nextUseItemParent, "CircularProgress_1")
    self._stc_nextUseItemSlotBg = UI.getChildControl(self._stc_nextUseItemParent, "Static_ItemSlot")
    local autoUseItemSlot = {}
    SlotItem.new(autoUseItemSlot, "Icon_AutoUse_", 0, self._stc_nextUseItemSlotBg, self._slotConfig)
    autoUseItemSlot:createChild()
    autoUseItemSlot.icon:SetPosX(0)
    autoUseItemSlot.icon:SetPosY(0)
    autoUseItemSlot.icon:SetSize(32, 32)
  end
  for iconIdx = 0, self._iconType.count - 1 do
    local icon = {}
    icon.btn = UI.createAndCopyBasePropertyControl(_panel, "Button_ServantIcon_template", _panel, "Button_Icon_" .. iconIdx)
    icon.btn:SetShow(false)
    if iconIdx <= self._iconType.servant_Awake then
      icon.progressBg = UI.createAndCopyBasePropertyControl(_panel, "Static_HorseProgressBg", _panel, "ProgressBg_" .. iconIdx)
      icon.progressHp = UI.createAndCopyBasePropertyControl(_panel, "CircularProgress_Hp", _panel, "ProgressHp_" .. iconIdx)
      icon.progressMp = UI.createAndCopyBasePropertyControl(_panel, "CircularProgress_Stamina", _panel, "ProgressStamina_" .. iconIdx)
      icon.progressBg:SetShow(false)
      icon.progressHp:SetShow(false)
      icon.progressMp:SetShow(false)
    end
    icon.btn:addInputEvent("Mouse_On", "PaGlobalFunc_ServantIcon_SimpleTooltip( true, " .. iconIdx .. " )")
    icon.btn:addInputEvent("Mouse_Out", "PaGlobalFunc_ServantIcon_SimpleTooltip( false )")
    icon.btn:addInputEvent("Mouse_LUp", "InputLUp_ServantIcon_LeftMouseFunction(" .. iconIdx .. ")")
    icon.btn:addInputEvent("Mouse_RUp", "InputRUp_ServantIcon_RightMouseFunction(" .. iconIdx .. ")")
    self._iconTable[iconIdx] = icon
    if iconIdx == self._iconType.LifeRingMenu then
      ServantIcon:lifeEquipIconInit()
      self._iconTable[self._iconType.LifeRingMenu].btn:SetAutoDisableTime(1)
    end
  end
  self._ui.stc_expMark:SetShow(false)
  self:registEventHandler()
  ServantIcon._isSiegeMonsterIcon = ServantIcon:checkSiegeMonsterIcon()
  self:updateServantIcon()
  self:updateHouseIcon()
  for iconType = self._iconType.pet, self._iconType.count do
    self:updateOtherIcon(iconType)
  end
  self:updatePos()
  local player = getSelfPlayer()
  if nil ~= player and true == player:get():isBattleGroundDefine() then
    PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetBattleIndex())
  end
  ServantIcon:unRenderPanel()
end
function ServantIcon:lifeEquipIconInit()
  local subPanel = UI.getChildControl(_panel, "Static_ButtonBg")
  local fishingBtn = UI.getChildControl(subPanel, "Button_1")
  local harpoonBtn = UI.getChildControl(subPanel, "Button_2")
  local normalBtn = UI.getChildControl(subPanel, "Button_3")
  fishingBtn:SetShow(false)
  harpoonBtn:SetShow(false)
  normalBtn:SetShow(false)
  fishingBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantIcon_ChangeLifeEquip(" .. tostring(__eActionMode_FishingRod) .. ")")
  harpoonBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantIcon_ChangeLifeEquip(" .. tostring(__eActionMode_FishingHarpoon) .. ")")
  normalBtn:addInputEvent("Mouse_LUp", "PaGlobalFunc_ServantIcon_ChangeLifeEquip(" .. tostring(__eActionMode_Normal) .. ")")
  fishingBtn:addInputEvent("Mouse_On", "PaGlobalFunc_ServantIcon_LifeStanceTooltip(" .. __eActionMode_FishingRod .. ")")
  harpoonBtn:addInputEvent("Mouse_On", "PaGlobalFunc_ServantIcon_LifeStanceTooltip(" .. __eActionMode_FishingHarpoon .. ")")
  normalBtn:addInputEvent("Mouse_On", "PaGlobalFunc_ServantIcon_LifeStanceTooltip(" .. __eActionMode_Normal .. ")")
  fishingBtn:addInputEvent("Mouse_Out", "PaGlobalFunc_ServantIcon_LifeStanceTooltip()")
  harpoonBtn:addInputEvent("Mouse_Out", "PaGlobalFunc_ServantIcon_LifeStanceTooltip()")
  normalBtn:addInputEvent("Mouse_Out", "PaGlobalFunc_ServantIcon_LifeStanceTooltip()")
  subPanel:SetHorizonLeft()
  subPanel:SetVerticalMiddle()
  self._iconTable[self._iconType.LifeRingMenu].subBg = subPanel
  self._iconTable[self._iconType.LifeRingMenu].fish = fishingBtn
  self._iconTable[self._iconType.LifeRingMenu].harpoon = harpoonBtn
  self._iconTable[self._iconType.LifeRingMenu].normal = normalBtn
end
function PaGlobalFunc_ServantIcon_LifeStanceTooltip(index)
  local name, control
  if __eActionMode_FishingRod == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_FISH")
    control = ServantIcon._iconTable[ServantIcon._iconType.LifeRingMenu].fish
  elseif __eActionMode_FishingHarpoon == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_JAKSAL")
    control = ServantIcon._iconTable[ServantIcon._iconType.LifeRingMenu].harpoon
  elseif __eActionMode_Normal == index then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_BASE")
    control = ServantIcon._iconTable[ServantIcon._iconType.LifeRingMenu].normal
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name)
end
function ServantIcon:unRenderPanel()
  if nil == Panel_Widget_ServantIcon then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local bHide = false
  local hideCondition = {
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing),
    ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare),
    ToClient_IsRemoteInstallMode()
  }
  for k, v in ipairs(hideCondition) do
    if true == v then
      bHide = true
    end
  end
  if true == bHide then
    Panel_Widget_ServantIcon:SetRenderAndEventHide(true)
  else
    Panel_Widget_ServantIcon:SetRenderAndEventHide(false)
  end
end
function ServantIcon:checkSiegeMonsterIcon()
  local selfPlayerProxyWrapper = getSelfPlayer()
  if nil == selfPlayerProxyWrapper then
    return
  end
  local myGuildInfo = ToClient_GetMyGuildInfoWrapper()
  if nil == myGuildInfo then
    return
  end
  local myGuildAllianceChair = ToClient_GetMyGuildAlliancChairGuild()
  local myGuildAllianceCacheNo
  if nil ~= myGuildAllianceChair then
    myGuildAllianceCacheNo = selfPlayerProxyWrapper:getGuildAllianceNo_s64()
  else
    myGuildAllianceCacheNo = selfPlayerProxyWrapper:getGuildNo_s64()
  end
  if nil == myGuildAllianceCacheNo then
    return
  end
  local guildMemberCount = myGuildInfo:getMemberCount()
  for ii = 1, guildMemberCount do
    local guildMemberInfo = myGuildInfo:getMember(ii - 1)
    if nil ~= guildMemberInfo and true == guildMemberInfo:isSelf() then
      local isVacation = guildMemberInfo:isVacation()
      if true == isVacation then
        return false
      end
    end
  end
  local isOccupyMajorSiege = ToClient_hasOccupyingMajorSiege(myGuildAllianceCacheNo)
  if true == isOccupyMajorSiege then
    return false
  end
  local isEnterMajorSiege = ToClient_isEnterMajorSiege(myGuildAllianceCacheNo)
  if true == isEnterMajorSiege then
    return true
  end
  return false
end
function ServantIcon:registEventHandler()
  registerEvent("EventSelfServantUpdate", "PaGlobalFunc_ServantIcon_Update")
  registerEvent("EventSelfServantUpdateOnlyHp", "PaGlobalFunc_ServantIcon_UpdateHP")
  registerEvent("EventSelfServantUpdateOnlyMp", "PaGlobalFunc_ServantIcon_UpdateMP")
  registerEvent("FromClient_SummonChanged", "PaGlobalFunc_ServantIcon_Update")
  registerEvent("FromClient_SummonAddList", "PaGlobalFunc_ServantIcon_Update")
  registerEvent("FromClient_SummonDelList", "PaGlobalFunc_ServantIcon_Update")
  registerEvent("EventSelfServantClose", "PaGlobalFunc_ServantIcon_Update")
  registerEvent("FromClient_ServantTaming", "FromClient_ServantIcon_TamingSuccess")
  registerEvent("EventSelfPlayerRideOn", "PaGlobal_ServantIcon_PlayerRideOn")
  registerEvent("FromClient_updateFood", "PaGlobalFunc_ServantIcon_UpdateMP")
  registerEvent("FromClient_ReceiveSetMyHouse", "FGlobal_MyHouseNavi_Update")
  registerEvent("FromClient_ReceiveReturnHouse", "FGlobal_MyHouseNavi_Update")
  registerEvent("FromClient_SetSelfTent", "FGlobal_MyHouseNavi_Update")
  registerEvent("FromClient_ResponseAuctionInfo", "FGlobal_MyHouseNavi_Update")
  registerEvent("WorldMap_WorkerDataUpdate", "FGlobal_MyHouseNavi_Update")
  registerEvent("FromClient_ChangeWorkerCount", "FromClient_ServantIcon_ChangeWorkerCount")
  registerEvent("FromClient_RefreshMaidList", "FGlobal_MaidIcon_SetPos")
  registerEvent("FromClient_UpdateMaidCoolTime", "PaGlobalFunc_ServantIcon_UpdateMaidIcon")
  registerEvent("WorldMap_StopWorkerWorking", "PaGlobalFunc_ServantIcon_UpdateHouseIcon")
  registerEvent("FromClient_Fairy_Update", "PaGlobalFunc_ServantIcon_FairyUpdate")
  registerEvent("EventSimpleUIEnable", "Servant_UpdateSimpleUI_Force_Out")
  registerEvent("EventSimpleUIDisable", "Servant_UpdateSimpleUI_Force_Over")
  registerEvent("onScreenResize", "PaGlobalFunc_ServantIcon_OnResize")
  registerEvent("FromClient_ApplyUISettingPanelInfo", "PaGlobalFunc_ServantIcon_OnResize")
  registerEvent("EventSelfPlayerLevelUp", "FromClient_ServantIcon_EventSelfPlayerLevelUp")
  registerEvent("FromClient_NotifyStartSiege", "FromClient_NotifyStartSiege_ServantIcon")
  registerEvent("FromClient_OccupySiege", "FromClient_NotifyOccupySiege_ServantIcon")
  registerEvent("FromClient_ReleaseSiege", "FromClient_NotifyReleaseSiege_ServantIcon")
  registerEvent("FromClient_responseTentInformationAck", "FromClient_responseTentInformationAck_ServantIcon")
  registerEvent("FromClient_NoticeLeftMaidCount", "FromClient_MaidList_All_NoticeLeftCount")
  registerEvent("ResponseParty_updatePartyList", "PaGlobalFunc_PartyRecruitIcon_Show")
  registerEvent("FromClient_updateRentInstanceFieldList", "PaGlobalFunc_updateRentInstanceFieldIcon")
  registerEvent("FromClient_EnterToInstanceField", "PaGlobalFunc_updateRentInstanceFieldIcon")
  if _ContentsGroup_OneButtonBuff == true then
    registerEvent("FromClient_UpdateAutoUseModeToggleState", "FromClient_ServantIcon_UpdateAutoUseItemModeToggleState")
    registerEvent("FromClient_StartAutoUseBuffItemTimer", "FromClient_ServantIcon_StartAutoUseBuffItemTimer")
    registerEvent("FromClient_ChangedLearnedFairyAutoUseBuffSkill", "FromClient_ServantIcon_ChangedLearnedFairyPotionSkill")
  end
  registerEvent("FromClient_UpdateUIOnce_NotReloadUI", "FromClient_ServantIcon_UpdateUIOnce_NotReloadUI")
  registerEvent("FromClient_ChangedLifeEquipModeAck", "FromClient_ChangedLifeEquipModeAck")
end
function ServantIcon:hideAllIcon()
  for _, icon in pairs(self._iconTable) do
    if nil ~= icon then
      icon.btn:SetShow(false)
      if nil ~= icon.progressBg then
        icon.progressBg:SetShow(false)
      end
      if nil ~= icon.progressHp then
        icon.progressHp:SetShow(false)
      end
      if nil ~= icon.progressMp then
        icon.progressMp:SetShow(false)
      end
    end
  end
end
function ServantIcon:hideAllIconForInstance()
  for iconIdx = 0, self._iconType.count - 1 do
    if self._iconType.fairy ~= iconIdx and self._iconType.pet ~= iconIdx then
      local icon = self._iconTable[iconIdx]
      if nil ~= icon then
        icon.btn:SetShow(false)
        if nil ~= icon.progressBg then
          icon.progressBg:SetShow(false)
        end
        if nil ~= icon.progressHp then
          icon.progressHp:SetShow(false)
        end
        if nil ~= icon.progressMp then
          icon.progressMp:SetShow(false)
        end
      end
    end
  end
  self:updatePos()
end
function ServantIcon:hideServantIcon()
  for iconIdx = 0, self._iconType.monster do
    icon = self._iconTable[iconIdx]
    if nil ~= icon then
      icon.btn:SetShow(false)
      if nil ~= icon.progressBg then
        icon.progressBg:SetShow(false)
      end
      if nil ~= icon.progressHp then
        icon.progressHp:SetShow(false)
      end
      if nil ~= icon.progressMp then
        icon.progressMp:SetShow(false)
      end
    end
  end
end
function ServantIcon:hideHouseIcon()
  for iconIdx = self._iconType.house, self._iconType.count - 1 do
    icon = self._iconTable[iconIdx]
    if nil ~= icon then
      icon.btn:SetShow(false)
      if nil ~= icon.progressBg then
        icon.progressBg:SetShow(false)
      end
      if nil ~= icon.progressHp then
        icon.progressHp:SetShow(false)
      end
      if nil ~= icon.progressMp then
        icon.progressMp:SetShow(false)
      end
    end
  end
end
function ServantIcon:changeServantIconTextureWithWhistle(control, whistleType, vehicleType)
  if self._whistleType.SuperWhistle == whistleType then
    control:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_RaceHorse == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 52, 52)
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.VehicleType.Type_Camel == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 53, 52, 104)
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.VehicleType.Type_Donkey == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 157, 52, 208)
      if subVehicleType == 2 then
        x1, y1, x2, y2 = setTextureUV_Func(control, 209, 105, 260, 156)
      end
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 53, 1, 104, 52)
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    end
  else
    control:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
    if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_RaceHorse == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 1, 1, 52, 52)
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.VehicleType.Type_Camel == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 53, 105, 104, 156)
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.VehicleType.Type_Donkey == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 157, 1, 208, 52)
      if subVehicleType == 2 then
        control:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
        x1, y1, x2, y2 = setTextureUV_Func(control, 209, 1, 260, 52)
      end
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
      local x1, y1, x2, y2 = setTextureUV_Func(control, 261, 53, 312, 104)
      control:getBaseTexture():setUV(x1, y1, x2, y2)
    end
  end
end
function ServantIcon:updateLandVehicleIcon(vehicleType, whistleType, subVehicleType)
  local icon = self._iconTable[self._iconType.servant_Land]
  if nil == icon then
    return
  end
  self._lastWhistleType = whistleType
  self:changeServantIconTextureWithWhistle(icon.btn, whistleType, vehicleType)
  if self._whistleType.Whistle == whistleType then
    icon.btn:SetColor(Defines.Color.C_FFFFE069)
  elseif self._whistleType.PcRoom == whistleType then
    if _ContentsGroup_PremeumPCRoomSuperWhistle == true then
      self:changeServantIconTextureWithWhistle(icon.btn, self._whistleType.SuperWhistle, vehicleType)
    end
    icon.btn:SetColor(Defines.Color.C_FF3DB298)
  else
    icon.btn:SetColor(Defines.Color.C_FFEEEEEE)
  end
end
function ServantIcon:updateLandVehicleIcon_Dead(vehicleType, vehicleSubType)
  local icon = self._iconTable[self._iconType.servant_Land]
  if nil == icon then
    return
  end
  if CppEnums.VehicleType.Type_Horse == vehicleType or CppEnums.VehicleType.Type_RaceHorse == vehicleType then
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 105, 1, 156, 52)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  elseif CppEnums.VehicleType.Type_Camel == vehicleType then
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 103, 53, 156, 104)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  elseif CppEnums.VehicleType.Type_Donkey == vehicleType then
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 105, 157, 156, 208)
    if 2 == vehicleSubType then
      x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 209, 53, 260, 104)
    end
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  elseif CppEnums.VehicleType.Type_RidableBabyElephant == vehicleType then
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 157, 1, 208, 52)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  elseif CppEnums.VehicleType.Type_Carriage == vehicleType or CppEnums.VehicleType.Type_RepairableCarriage == vehicleType then
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 157, 157, 208, 208)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  end
end
function ServantIcon:updateServantIcon()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  self:checkServantFunctionUse()
  if nil == self._iconTable[self._iconType.servant_Land] then
    return
  end
  self:hideServantIcon()
  icon.btn:SetColor(Defines.Color.C_FFEEEEEE)
  icon.btn:SetMonoTone(false, false)
  local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if nil ~= landVehicleWrapper then
    local icon = self._iconTable[self._iconType.servant_Land]
    local isRussiaPremiumPack = false
    icon.btn:SetMonoTone(false, false)
    if nil ~= selfPlayer then
      isRussiaPremiumPack = selfPlayer:get():isApplyChargeSkill(CppEnums.UserChargeType.eUserChargeType_RussiaPack3)
    end
    local isPremiumPcRoom = temporaryWrapper:isPremiumPcRoom()
    local isDeadIconAble = landVehicleWrapper:getHp() <= 0 and true == self._isServantIconFunctionAvailable
    local currentVehicleType = landVehicleWrapper:getVehicleType()
    local currentVehicleSubType = landVehicleWrapper:getVehicleSubType()
    if currentVehicleType == CppEnums.VehicleType.Type_Horse or currentVehicleType == CppEnums.VehicleType.Type_RaceHorse or currentVehicleType == CppEnums.VehicleType.Type_Camel or currentVehicleType == CppEnums.VehicleType.Type_Donkey or currentVehicleType == CppEnums.VehicleType.Type_RidableBabyElephant then
      if isPremiumPcRoom == true and (isGameTypeKorea() == true or isGameTypeJapan() == true) then
        if doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) then
          self:updateLandVehicleIcon(currentVehicleType, self._whistleType.SuperWhistle, currentVehicleSubType)
        else
          self:updateLandVehicleIcon(currentVehicleType, self._whistleType.PcRoom, currentVehicleSubType)
        end
      elseif isRussiaPremiumPack == true then
        if doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) then
          self:updateLandVehicleIcon(currentVehicleType, self._whistleType.SuperWhistle, currentVehicleSubType)
        elseif doHaveContentsItem(__eContentsType_OrderToServant, CppEnums.VehicleType.Type_Horse) then
          self:updateLandVehicleIcon(currentVehicleType, self._whistleType.Whistle, currentVehicleSubType)
        else
          self:updateLandVehicleIcon(currentVehicleType, self._whistleType.PcRoom, currentVehicleSubType)
        end
      elseif doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) then
        self:updateLandVehicleIcon(currentVehicleType, self._whistleType.SuperWhistle, currentVehicleSubType)
      elseif doHaveContentsItem(__eContentsType_OrderToServant, CppEnums.VehicleType.Type_Horse) then
        self:updateLandVehicleIcon(currentVehicleType, self._whistleType.Whistle, currentVehicleSubType)
      else
        self:updateLandVehicleIcon(currentVehicleType, self._whistleType.None, currentVehicleSubType)
      end
    elseif CppEnums.VehicleType.Type_Carriage == currentVehicleType or CppEnums.VehicleType.Type_CowCarriage == currentVehicleType or CppEnums.VehicleType.Type_RepairableCarriage == currentVehicleType then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 365, 1, 416, 52)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:SetColor(Defines.Color.C_FFEEEEEE)
    else
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 0, 0, 1, 1)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:SetColor(Defines.Color.C_FFEEEEEE)
    end
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    icon.progressHp:SetProgressRate(landVehicleWrapper:getHp() / landVehicleWrapper:getMaxHp() * 50)
    icon.progressMp:SetProgressRate(landVehicleWrapper:getMp() / landVehicleWrapper:getMaxMp() * 50)
    icon.btn:SetShow(true)
    icon.progressBg:SetShow(true)
    icon.progressHp:SetShow(true)
    icon.progressMp:SetShow(true)
    icon.btn:ActiveMouseEventEffect(true)
    local servantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    local regionInfo = getRegionInfoByPosition(servantInfo:getPosition())
    if false == regionInfo:get():isSafeZone() and false == Panel_Dialog_ServantFunction_All:GetShow() then
      self:servantHpChecker(landVehicleWrapper:getHp(), landVehicleWrapper:getMaxHp(), currentVehicleType)
    end
    if true == isDeadIconAble then
      icon.btn:SetColor(Defines.Color.C_FFEEEEEE)
      PaGlobalFunc_ServantIcon_SetServantIconByState(true, currentVehicleType, currentVehicleSubType)
    end
    local selfProxy = getSelfPlayer()
    if nil == selfProxy then
      return
    end
    local actorKeyRaw = selfProxy:get():getRideVehicleActorKeyRaw()
    local unsealCacheData = getServantInfoFromActorKey(actorKeyRaw)
    if nil ~= unsealCacheData then
      HorseHP_OpenByInteraction()
      HorseMP_OpenByInteraction()
    end
  elseif true == self._isServantIconFunctionAvailable then
    local last = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
    local icon = self._iconTable[self._iconType.servant_Land]
    icon.btn:SetShow(true)
    icon.progressBg:SetShow(false)
    icon.progressHp:SetShow(false)
    icon.progressMp:SetShow(false)
    icon.btn:ActiveMouseEventEffect(true)
    if nil == last then
      self:updateLandVehicleIcon(CppEnums.VehicleType.Type_Horse, self._whistleType.Whistle, nil)
      icon.btn:SetMonoTone(true, true)
    else
      local lastServantState = last:getStateType()
      local vehicleType = last:getVehicleType()
      if CppEnums.ServantStateType.Type_Coma == lastServantState then
        PaGlobalFunc_ServantIcon_SetServantIconByState(true, vehicleType, last:getVehicleSubType())
      end
    end
  else
    PaGlobal_ServantIcon_HideBuubbleMessage()
  end
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if nil ~= seaVehicleWrapper and UI_VT.Type_SailingBoat ~= seaVehicleWrapper:getVehicleType() then
    local icon = self._iconTable[self._iconType.servant_Water]
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 53, 53, 104, 104)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    icon.progressHp:SetProgressRate(seaVehicleWrapper:getHp() / seaVehicleWrapper:getMaxHp() * 50)
    icon.progressMp:SetProgressRate(getMpToServantInfo(seaVehicleWrapper) / getMaxMpToServantInfo(seaVehicleWrapper) * 50)
    icon.btn:SetShow(true)
    icon.progressBg:SetShow(true)
    icon.progressHp:SetShow(true)
    icon.progressMp:SetShow(true)
    icon.btn:ActiveMouseEventEffect(true)
    local selfProxy
    if getSelfPlayer() and getSelfPlayer():get() then
      selfProxy = getSelfPlayer():get()
    end
    if nil == selfProxy then
      return
    end
    if selfProxy:doRideMyVehicle() then
      HorseHP_OpenByInteraction()
      HorseMP_OpenByInteraction()
    end
  end
  local summonCount = getSelfPlayer():getSummonListCount()
  for summon_idx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summon_idx)
    local characterKey = summonInfo:getCharacterKey()
    if characterKey >= 60028 and characterKey <= 60037 or 60068 == characterKey or 60069 == characterKey then
      local summonWrapper = summonInfo:getActor()
      local hpRate = 0
      local mpRate = 0
      if nil == summonWrapper then
        hpRate = 50
        mpRate = 50
      else
        local hp = summonWrapper:get():getHp()
        local maxHp = summonWrapper:get():getMaxHp()
        local mp = summonWrapper:get():getMp()
        local maxMp = summonWrapper:get():getMaxMp()
        if maxHp == 0 then
          hpRate = 50
        else
          hpRate = hp / maxHp * 50
        end
        if maxMp == 0 then
          mpRate = 50
        else
          mpRate = mp / maxMp * 50
        end
      end
      local icon = self._iconTable[self._iconType.servant_Summon]
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 105, 1, 156, 52)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      icon.progressHp:SetProgressRate(hpRate)
      icon.progressMp:SetProgressRate(mpRate)
      icon.btn:SetShow(true)
      icon.progressBg:SetShow(true)
      icon.progressHp:SetShow(true)
      icon.progressMp:SetShow(true)
      icon.btn:ActiveMouseEventEffect(true)
      break
    elseif 60134 == characterKey or 60137 == characterKey or 60136 == characterKey or 60135 == characterKey then
      local summonWrapper = summonInfo:getActor()
      local hpRate = 0
      local mpRate = 0
      if nil == summonWrapper then
        hpRate = 50
        mpRate = 50
      else
        local hp = summonWrapper:get():getHp()
        local maxHp = summonWrapper:get():getMaxHp()
        local mp = summonWrapper:get():getMp()
        local maxMp = summonWrapper:get():getMaxMp()
        if maxHp == 0 then
          hpRate = 50
        else
          hpRate = hp / maxHp * 50
        end
        if maxMp == 0 then
          mpRate = 50
        else
          mpRate = mp / maxMp * 50
        end
      end
      local icon = self._iconTable[self._iconType.servant_Awake]
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 157, 53, 208, 104)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      icon.progressHp:SetProgressRate(hpRate)
      icon.progressMp:SetProgressRate(mpRate)
      icon.btn:SetShow(true)
      icon.progressBg:SetShow(true)
      icon.progressHp:SetShow(true)
      icon.progressMp:SetShow(true)
      icon.btn:ActiveMouseEventEffect(true)
      break
    end
  end
  local elephantCount = guildstable_getUnsealGuildServantCount()
  for index = 0, elephantCount - 1 do
    local servantWrapper = guildStable_getUnsealGuildServantAt(index)
    local vehicleType = servantWrapper:getVehicleType()
    if UI_VT.Type_Elephant == vehicleType or UI_VT.Type_Train == vehicleType or UI_VT.Type_SailingBoat == vehicleType or UI_VT.Type_PersonalBattleShip == vehicleType or UI_VT.Type_CashPersonalBattleShip == vehicleType or UI_VT.Type_SiegeTower == vehicleType or UI_VT.Type_LargeSiegeTower == vehicleType or UI_VT.Type_GuildDragon == vehicleType then
      local icon = self._iconTable[self._iconType.servant_Guild]
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 105, 53, 156, 104)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      icon.btn:SetShow(true)
      break
    end
  end
  if true == ServantIcon._isSiegeMonsterIcon and true == _ContentsGroup_ServantSummonMonster_InWar then
    local icon = self._iconTable[self._iconType.monster]
    icon.btn:ChangeTextureInfoNameAsync("renewal/Button/Console_Btn_Main.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 365, 105, 416, 156)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    icon.btn:SetShow(true)
  end
  if true == ToClient_isSeasonChannel() or true == ToClient_isSeasonNewbieChannel() then
    ServantIcon:updateOtherIcon(ServantIcon._iconType.PartyRecruit, false)
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) or true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) then
    self:hideAllIconForInstance()
  end
end
function ServantIcon:updateOtherIcon(iconType, isForced, param1)
  local icon = self._iconTable[iconType]
  if nil == icon then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  if true == _ContentsGroup_ForceShowWidgetIcon then
    if iconType ~= self._iconType.pet and iconType ~= self._iconType.maid and iconType ~= self._iconType.fairy and true == PaGlobal_TutorialManager:isDoingTutorial() and 6 >= getSelfPlayer():get():getLevel() then
      return
    end
  elseif true == PaGlobal_TutorialManager:isDoingTutorial() and 6 >= getSelfPlayer():get():getLevel() then
    return
  end
  local isPcRoom = temporaryWrapper:isPremiumPcRoom()
  local isShow = false
  if iconType == self._iconType.pet then
    local unSealPetCount = ToClient_getPetUnsealedList()
    if 0 == unSealPetCount then
      FGlobal_PetHungryAlert(false)
    end
    local petCount = ToClient_getPetSealedList()
    local PcPetData = ToClient_getPetUnsealedDataByIndex(0)
    local condition = false
    if true == _ContentsGroup_ForceShowWidgetIcon then
      condition = true
    else
      condition = 0 ~= petCount or nil ~= PcPetData or isPcRoom and _ContentsGroup_KR_Transfer
    end
    if true == condition then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 53, 1, 104, 52)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      isShow = true
      if 0 ~= petCount or nil ~= PcPetData or true == isPcRoom and true == _ContentsGroup_KR_Transfer then
        icon.btn:SetColor(Defines.Color.C_FFFFFFFF)
      else
        icon.btn:SetColor(Defines.Color.C_FFA3A3A3)
      end
    end
    if isShow == true then
      local subIconShow = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBoolNoSave(__ePetIconShowNosave)
      if subIconShow == true then
        PaGlobal_PetControl_All:prepareOpen()
      else
        PaGlobal_PetControl_All:prepareClose()
      end
    end
  elseif iconType == self._iconType.maid then
    local condition = false
    if true == _ContentsGroup_ForceShowWidgetIcon then
      condition = true
    else
      condition = 0 < getTotalMaidList() and getSelfPlayer():get():getLevel() >= 7 or isPcRoom and _ContentsGroup_KR_Transfer and getSelfPlayer():get():getLevel() >= 7
    end
    if true == condition then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 209, 1, 260, 52)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      icon.btn:EraseAllEffect()
      local allMaidInCool, someMaidInCool = self:maidCoolTime()
      if allMaidInCool then
        icon.btn:AddEffect("fUI_Maid_02A", true, 0, 0)
      elseif someMaidInCool then
        icon.btn:AddEffect("fUI_Maid_01A", true, 0, 0)
      end
      isShow = true
      if 0 < getTotalMaidList() or true == isPcRoom and true == _ContentsGroup_KR_Transfer then
        icon.btn:SetColor(Defines.Color.C_FFFFFFFF)
      else
        icon.btn:SetColor(Defines.Color.C_FFA3A3A3)
      end
      if _ContentsGroup_MaidActorSystem == true then
        icon.btn:setButtonShortcutsWithEvent("InputRUp_ServantIcon_RightMouseFunction(" .. iconType .. ")", "PANEL_WINDOW_TOGGLESUMMON_MAIDACTOR_TITLE")
      end
    end
  elseif iconType == self._iconType.camp then
    if true == ToClient_isCampingReigsted() then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 313, 1, 364, 52)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      icon.btn:setButtonShortcutsWithEvent("InputLUp_ServantIcon_LeftMouseFunction(" .. iconType .. ")", "PANEL_SIMPLETOOLTIP_BUTTONSHORTCUT_CAMP")
      isShow = true
    end
  elseif iconType == self._iconType.fairy then
    if true == _ContentsGroup_isFairy then
      local count = ToClient_getFairyUnsealedList() + ToClient_getFairySealedList()
      local condition = false
      if true == _ContentsGroup_ForceShowWidgetIcon then
        condition = true
      else
        condition = count > 0
      end
      if true == condition then
        icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 313, 105, 364, 156)
        icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
        icon.btn:setRenderTexture(icon.btn:getBaseTexture())
        isShow = true
        if count > 0 then
          icon.btn:SetColor(Defines.Color.C_FFFFFFFF)
        else
          icon.btn:SetColor(Defines.Color.C_FFA3A3A3)
        end
        if true == PaGlobalFunc_SevanrIcon_CheckFamilyNewUser() and count <= 0 and false == PaGlobalFunc_ServantIcon_CheckFamilyCharacterLevel(_ContentsUiCheck_FairyIconOpenLevel) then
          isShow = false
        end
      end
    end
  elseif iconType == self._iconType.battle then
    local selfProxy = getSelfPlayer()
    if true == _ContentsGroup_BattleGroundPvP and nil ~= selfProxy and true == selfProxy:get():isBattleGroundDefine() then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 209, 105, 260, 156)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      icon.btn:SetColor(Defines.Color.C_FFFCF422)
      isShow = true
    else
      isPlaying = getSelfPlayer():isDefinedPvPMatch()
      if true == isPlaying then
        icon.btn:SetColor(Defines.Color.C_FFFFFFFF)
        icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 209, 105, 260, 156)
        icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
        icon.btn:setRenderTexture(icon.btn:getBaseTexture())
        isShow = true
      end
    end
  elseif iconType == self._iconType.tag then
    if true == PaGlobalFunc_ServantIcon_CharacterTagCheckShow() then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 313, 53, 364, 104)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      if true == ToClient_IsContentsGroupOpen("330") then
        icon.btn:setButtonShortcutsWithEvent("InputRUp_ServantIcon_RightMouseFunction(" .. iconType .. ")", "PANEL_SIMPLESHORTCUT_CHARACTER_CHANGE")
      end
      isShow = true
      if true == PaGlobalFunc_SevanrIcon_CheckFamilyNewUser() and false == PaGlobalFunc_ServantIcon_CheckFamilyCharacterLevel(_ContentsUiCheck_TagIconOpenLevel) then
        isShow = false
      end
      if getSelfPlayer():get():isSeasonCharacter() == true then
        isShow = false
      end
      if true == isShow then
        if true == _ContentsGroup_AddExpEvent_TagCharacter then
          _panel:SetChildOrder(icon.btn:GetKey(), self._ui.stc_expMark:GetKey())
          self._ui.stc_expMark:SetShow(true)
        end
      else
        self._ui.stc_expMark:SetShow(false)
      end
    end
  elseif iconType == self._iconType.PartyRecruit then
    local selfPlayer = getSelfPlayer()
    if nil == selfPlayer then
      return
    end
    local selfPlayerGet = selfPlayer:get()
    if nil == selfPlayerGet then
      return
    end
    if true == ToClient_isSeasonChannel() or true == ToClient_isSeasonNewbieChannel() then
      if true == selfPlayerGet:hasParty() and true == RequestParty_isLeader() then
        isShow = true
      else
        isShow = true
      end
    else
      local pcPosition = selfPlayerGet:getPosition()
      local regionInfo = getRegionInfoByPosition(pcPosition)
      if nil == regionInfo then
        return
      end
      if false == regionInfo:get():isAtoraxion() then
        return
      end
      if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AtoraxionBoss) then
        return
      end
      if RequestParty_getPartyMemberCount() < ToClient_GetPartyMaxMemberCount() then
        isShow = true
      end
    end
    if true == isShow then
      icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 413, 157, 464, 208)
      icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
      icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    end
  elseif iconType == self._iconType.rentInstanceField then
    local iconState = ToClient_getShowInRentInstanceFieldIconState()
    if iconState > 0 then
      isShow = true
      ToClient_requestUpdateRentInstanceFieldPlayerCount()
      if 1 == iconState then
        icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 53, 157, 104, 208)
        icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
        icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      elseif 2 == iconState then
        icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
        local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 53, 105, 104, 156)
        icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
        icon.btn:setRenderTexture(icon.btn:getBaseTexture())
      else
        isShow = false
        _PA_ASSERT(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
      end
    end
  elseif iconType == self._iconType.AutoUseBuffItem then
    if _ContentsGroup_OneButtonBuff == true then
      icon.btn:EraseAllEffect()
      local isLearnedFairyPotionSkill = param1
      if isLearnedFairyPotionSkill == nil then
        PaGlobal_FairyInfo_All:update()
        isLearnedFairyPotionSkill = ToClient_isLearnedFairySkill()
      end
      if isLearnedFairyPotionSkill == true then
        local isActivateAutoUseBuffItem = ToClient_getCurrentAutoUseModeToggleState()
        if isActivateAutoUseBuffItem ~= nil and isActivateAutoUseBuffItem == true then
          icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 261, 53, 312, 104)
          icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
          icon.btn:setRenderTexture(icon.btn:getBaseTexture())
          icon.btn:AddEffect("fui_ingame_widget_autouse_01a", true, 0, 0)
        else
          icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 261, 1, 312, 52)
          icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
          icon.btn:setRenderTexture(icon.btn:getBaseTexture())
        end
        icon.btn:setButtonShortcutsWithEvent("InputRUp_ServantIcon_RightMouseFunction(" .. iconType .. ")", "PANEL_WINDOW_AUTOBUFF_TITLE")
        isShow = true
      else
        isShow = false
      end
    else
      isShow = false
    end
  elseif iconType == self._iconType.LifeRingMenu then
    local currentMode = ToClient_GetCurrentActionMode()
    ServantIcon_LifeRingMenuBtn_ChangeTexture(currentMode)
    isShow = true
  elseif iconType == self._iconType.fishingCamp and _ContentsGroup_FishingCamp == true and ToClient_isFishingCampReigsted() == true then
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 313, 1, 364, 52)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    isShow = true
  end
  icon.btn:SetShow(isShow)
  icon.btn:ActiveMouseEventEffect(isShow)
  if (true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) or true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField)) and true ~= isForced then
    self:hideAllIconForInstance()
  end
end
function ServantIcon_LifeRingMenuBtn_ChangeTexture(currentMode)
  local icon = ServantIcon._iconTable[ServantIcon._iconType.LifeRingMenu]
  if nil == icon then
    return
  end
  if currentMode == __eActionMode_Normal or currentMode == __eActionMode_FishingRod then
    icon.btn:ChangeTextureInfoNameAsync("renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 157, 209, 208, 260)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
  end
  icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  icon.btn:ActiveMouseEventEffect(true)
end
function ServantIcon:maidCoolTime()
  if nil == getSelfPlayer() then
    return
  end
  local count = getTotalMaidList()
  local allMaidInCool = true
  local someMaidInCool = false
  for index = 0, count - 1 do
    local maidInfoWrapper = getMaidDataByIndex(index)
    if nil ~= maidInfoWrapper then
      local coolTime = maidInfoWrapper:getCoolTime()
      if coolTime > 0 then
        someMaidInCool = true
      else
        allMaidInCool = false
      end
    end
  end
  if true == _ContentsGroup_ForceShowWidgetIcon and count <= 0 then
    allMaidInCool = false
    someMaidInCool = false
  end
  return allMaidInCool, someMaidInCool
end
function ServantIcon:updateHouseIcon()
  if true == PaGlobal_TutorialManager:isDoingTutorial() then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  if nil == self._iconTable[self._iconType.house] then
    return
  end
  self._iconTable[self._iconType.house].btn:SetShow(false)
  self._iconTable[self._iconType.harvest].btn:SetShow(false)
  self._iconTable[self._iconType.worker].btn:SetShow(false)
  if 0 < ToClient_getMyDwellingCount() then
    local icon = self._iconTable[self._iconType.house]
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 209, 53, 260, 104)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    icon.btn:SetShow(true)
    icon.btn:ActiveMouseEventEffect(true)
  end
  local tentCheck = temporaryWrapper:isSelfTent()
  if true == tentCheck then
    local icon = self._iconTable[self._iconType.harvest]
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 105, 105, 156, 156)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    icon.btn:SetShow(true)
    icon.btn:ActiveMouseEventEffect(true)
  end
  local isNpcWorkerCount = 0
  if nil ~= self._workerListCount then
    isNpcWorkerCount = self._workerListCount
    self._workerListCount = nil
  else
    isNpcWorkerCount = ToClient_getMyNpcWorkerCount()
  end
  if isNpcWorkerCount > 0 then
    local icon = self._iconTable[self._iconType.worker]
    icon.btn:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(icon.btn, 157, 105, 208, 156)
    icon.btn:getBaseTexture():setUV(x1, y1, x2, y2)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
    icon.btn:EraseAllEffect()
    local someNpcWorkerDontHaveActionPoint = self:checkZeroNpcWorkerActionPoint()
    if true == someNpcWorkerDontHaveActionPoint then
      icon.btn:AddEffect("fUI_Worker_01A", true, 0, 0)
    end
    icon.btn:SetShow(true)
    icon.btn:ActiveMouseEventEffect(true)
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_SavageDefence) or true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) then
    self:hideAllIconForInstance()
  end
end
function ServantIcon:npcWorkerCoolTime()
  if nil == getSelfPlayer() then
    return
  end
  local count = ToClient_getMyNpcWorkerCount()
  local allNpcWorkerInCool = true
  local someNpcWorkerInCool = false
  for index = 0, count - 1 do
    local workerNoRaw = ToClient_getMyNpcWorkerNoRawByIndex(index)
    local workerWrapper = getWorkerWrapper(workerNoRaw, false)
    if nil ~= workerWrapper then
      local leftTime = workerWrapper:getLeftWorkingTime()
      if leftTime > 0 then
        someNpcWorkerInCool = true
      else
        allNpcWorkerInCool = false
      end
    end
  end
  return allNpcWorkerInCool, someNpcWorkerInCool
end
function ServantIcon:checkZeroNpcWorkerActionPoint()
  if nil == getSelfPlayer() then
    return
  end
  local someNpcWorkerDontHaveActionPoint = false
  local count = ToClient_getMyNpcWorkerCount()
  for index = 0, count - 1 do
    local workerNoRaw = ToClient_getMyNpcWorkerNoRawByIndex(index)
    local workerWrapper = getWorkerWrapper(workerNoRaw, false)
    if nil ~= workerWrapper and 0 >= workerWrapper:getActionPoint() then
      someNpcWorkerDontHaveActionPoint = true
    end
  end
  return someNpcWorkerDontHaveActionPoint
end
function ServantIcon:updatePos()
  local currentXgap = self._startPosX
  for iconIdx = 0, self._iconType.count - 1 do
    if nil ~= self._iconTable[iconIdx] and true == self._iconTable[iconIdx].btn:GetShow() then
      self._iconTable[iconIdx].btn:SetPosX(currentXgap)
      if true == self._ui.stc_expMark:GetShow() and iconIdx == self._iconType.tag then
        self._ui.stc_expMark:SetPosX(currentXgap + 10)
      end
      if nil ~= self._iconTable[iconIdx].progressBg then
        self._iconTable[iconIdx].progressBg:SetPosX(currentXgap)
      end
      if nil ~= self._iconTable[iconIdx].progressHp then
        self._iconTable[iconIdx].progressHp:SetPosX(currentXgap)
      end
      if nil ~= self._iconTable[iconIdx].progressMp then
        self._iconTable[iconIdx].progressMp:SetPosX(currentXgap)
      end
      currentXgap = currentXgap + self._gapX
      if iconIdx == self._iconType.LifeRingMenu then
        self._iconTable[self._iconType.LifeRingMenu].subBg:SetPosXY(self._iconTable[self._iconType.LifeRingMenu].btn:GetPosX(), self._iconTable[self._iconType.LifeRingMenu].btn:GetSizeY() + 5)
      end
    end
  end
  if true == _ContentsGroup_InstrumentPerformance and nil ~= PaGlobal_PlayMusic_All then
    PaGlobal_PlayMusic_All:setPos()
  end
end
function PaGlobalFunc_ServantIcon_GetGapX()
  return ServantIcon._gapX
end
function ServantIcon:updateServantHP()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if nil ~= landVehicleWrapper and true == self._iconTable[self._iconType.servant_Land].btn:GetShow() then
    self._iconTable[self._iconType.servant_Land].progressHp:SetProgressRate(landVehicleWrapper:getHp() / landVehicleWrapper:getMaxHp() * 50)
    local servantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    local regionInfo = getRegionInfoByPosition(servantInfo:getPosition())
    if false == regionInfo:get():isSafeZone() and false == Panel_Dialog_ServantFunction_All:GetShow() then
      self:servantHpChecker(landVehicleWrapper:getHp(), landVehicleWrapper:getMaxHp(), landVehicleWrapper:getVehicleType())
    end
  end
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if nil ~= seaVehicleWrapper then
    self._iconTable[self._iconType.servant_Water].progressHp:SetProgressRate(seaVehicleWrapper:getHp() / seaVehicleWrapper:getMaxHp() * 50)
  end
  local summonCount = getSelfPlayer():getSummonListCount()
  for summon_idx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summon_idx)
    local characterKey = summonInfo:getCharacterKey()
    local slotNo = -1
    if characterKey >= 60028 and characterKey <= 60037 or characterKey == 60068 then
      slotNo = self._iconType.servant_Summon
    elseif 60134 == characterKey or 60137 == characterKey or 60136 == characterKey or 60135 == characterKey then
      slotNo = self._iconType.servant_Awake
    end
    if -1 ~= slotNo then
      local summonWrapper = summonInfo:getActor()
      if nil ~= summonWrapper then
        local hpRate = 50
        local hp = summonWrapper:get():getHp()
        local maxHp = summonWrapper:get():getMaxHp()
        if maxHp == 0 then
          hpRate = 50
        else
          hpRate = hp / maxHp * 50
        end
        self._iconTable[slotNo].progressHp:SetProgressRate(hpRate)
      end
    end
  end
end
function ServantIcon:updateServantMP()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if nil ~= landVehicleWrapper and true == self._iconTable[self._iconType.servant_Land].btn:GetShow() then
    self._iconTable[self._iconType.servant_Land].progressMp:SetProgressRate(landVehicleWrapper:getMp() / landVehicleWrapper:getMaxMp() * 50)
  end
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if nil ~= seaVehicleWrapper then
    PaGlobal_ServantIcon_ShowRowFoodMessage()
    self._iconTable[self._iconType.servant_Water].progressMp:SetProgressRate(getMpToServantInfo(seaVehicleWrapper) / getMaxMpToServantInfo(seaVehicleWrapper) * 50)
  end
  local summonCount = getSelfPlayer():getSummonListCount()
  for summon_idx = 0, summonCount - 1 do
    local summonInfo = getSelfPlayer():getSummonDataByIndex(summon_idx)
    local characterKey = summonInfo:getCharacterKey()
    local slotNo = -1
    if characterKey >= 60028 and characterKey <= 60037 or characterKey == 60068 then
      slotNo = self._iconType.servant_Summon
    elseif 60134 == characterKey or 60137 == characterKey or 60136 == characterKey or 60135 == characterKey then
      slotNo = self._iconType.servant_Awake
    end
    if -1 ~= slotNo then
      local summonWrapper = summonInfo:getActor()
      if nil ~= summonWrapper then
        local mpRate = 50
        local mp = summonWrapper:get():getMp()
        local maxMp = summonWrapper:get():getMaxMp()
        if maxMp == 0 then
          mpRate = 50
        else
          mpRate = mp / maxMp * 50
        end
        self._iconTable[slotNo].progressMp:SetProgressRate(mpRate)
      end
    end
  end
end
function ServantIcon:servantHpChecker(currentHp, currentMaxHp, vehicleType)
  local isNowEquipCheck = IsNowEquipCheck()
  local currentHp = currentHp
  local remainHp = currentHp / currentMaxHp * 100
  local isHpFull = false
  if currentHp == currentMaxHp then
    isHpFull = true
  end
  local servantIcon = self._iconTable[self._iconType.servant_Land]
  if currentHp < self._servant_BeforHP and nil ~= self._servant_BeforHP and isNowEquipCheck == false and isHpFull == false then
    if nil ~= self._hitEffect then
      servantIcon.btn:EraseEffect(self._hitEffect)
    end
    self._hitEffect = servantIcon.btn:AddEffect("fUI_Alarm_HorseAttack04", false, -0.1, -0.15)
    ToClient_RequestNakMessageRenewel(__eNakMessage_ServantWarning)
  end
  self._servant_BeforHP = currentHp
  if nil ~= self._less10Effect then
    servantIcon.btn:EraseEffect(self._less10Effect)
  end
  local effectName
  if remainHp <= 10 then
    if 0 == vehicleType then
      effectName = "fUI_Alarm_HorseAttack05"
    elseif 2 == vehicleType then
      effectName = "fUI_Alarm_HorseAttack05"
    elseif 3 == vehicleType then
      effectName = "fUI_Alarm_HorseAttack05"
    elseif 4 == vehicleType then
      effectName = "fUI_Alarm_HorseAttack05"
    elseif 9 == vehicleType then
      effectName = "fUI_Alarm_HorseAttack05"
    else
      effectName = "fUI_Alarm_HorseAttack05"
    end
    if nil ~= effectName then
      self._less10Effect = servantIcon.btn:AddEffect(effectName, false, -0.1, -0.15)
    end
  end
end
function ServantIcon:ShowBubbleText(desc, control)
  self._ui.txt_bubbleBox:SetShow(true)
  self._ui.txt_bubbleBox:SetPosX(control:GetSizeX() * 0.8)
  self._ui.txt_bubbleBox:SetPosY(control:GetSizeY() - 5)
  self._ui.txt_bubbleBox:SetText(desc)
  if 230 < self._ui.txt_bubbleBox:GetTextSizeX() then
    self._ui.txt_bubbleBox:SetSize(230, 0)
    self._ui.txt_bubbleBox:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_bubbleBox:SetText(desc)
    self._ui.txt_bubbleBox:SetSize(250, self._ui.txt_bubbleBox:GetTextSizeY() + 38)
  else
    self._ui.txt_bubbleBox:SetSize(250, 55)
  end
end
function ServantIcon:HideBubbleText()
  self._ui.txt_bubbleBox:SetShow(false)
end
function PaGlobalFunc_ServantIcon_SetServantIconByState(isDead, type, subType)
  local self = ServantIcon
  if false == self._isServantIconFunctionAvailable then
    return
  end
  local icon = self._iconTable[self._iconType.servant_Land]
  icon.btn:SetShow(true)
  if true == isDead then
    icon.progressBg:SetShow(false)
    icon.progressHp:SetShow(false)
    icon.progressMp:SetShow(false)
    self:updateLandVehicleIcon_Dead(type, subType)
  elseif false == isDead then
    icon.progressBg:SetShow(true)
    icon.progressHp:SetShow(true)
    icon.progressMp:SetShow(true)
    self:updateLandVehicleIcon(type, self._lastWhistleType, subType)
    icon.btn:setRenderTexture(icon.btn:getBaseTexture())
  end
end
function PaGlobal_ServantIcon_ShowBuubbleMessage()
  ServantIcon:ShowBubbleText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANT_RIDEBUBBLEMESSAGE"), ServantIcon._iconTable[0].btn)
end
function PaGlobal_ServantIcon_HideBuubbleMessage()
  ServantIcon:HideBubbleText()
end
function PaGlobal_ServantIcon_PlayerRideOn()
  PaGlobal_ServantIcon_HideBuubbleMessage()
end
function PaGlobalFunc_ServantIcon_Init()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:init()
end
function PaGlobalFunc_ServantIcon_Update()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateServantIcon()
  self:updatePos()
end
function FGlobal_Window_Servant_Update()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateServantIcon()
  self:updatePos()
end
function Panel_Window_Servant_Update()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateServantIcon()
  self:updatePos()
end
function PaGlobalFunc_ServantIcon_UpdatePos()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updatePos()
end
function PaGlobalFunc_ServantIcon_UpdateHP()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateServantHP()
end
function PaGlobalFunc_ServantIcon_UpdateMP()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateServantMP()
end
function Panel_MyHouseNavi_Update(init, listCount)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if nil == init then
    return
  end
  self._workerListCount = listCount
  self:updateHouseIcon()
  self:updatePos()
  self:updateOtherIcon(self._iconType.maid)
end
function FGlobal_MyHouseNavi_Update()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateHouseIcon()
  self:updatePos()
  self:updateOtherIcon(self._iconType.maid)
end
function PaGlobalFunc_ServantIcon_MaidCoolUpdate()
  local self = ServantIcon
  self:updateOtherIcon(self._iconType.maid)
end
function PaGlobal_Fairy_SetPosIcon()
  PaGlobalFunc_ServantIcon_FairyUpdate()
end
function PaGlobalFunc_ServantIcon_FairyUpdate()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateOtherIcon(self._iconType.fairy)
  self:updatePos()
end
function reset_ServantHP(BeforHP)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self._servant_BeforHP = BeforHP
end
function FGlobal_PetHungryAlert(petHungryCheck)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  local icon = self._iconTable[self._iconType.pet]
  if nil == icon then
    return
  end
  icon.btn:EraseAllEffect()
  if petHungryCheck and 0 < ToClient_getPetUnsealedList() then
    icon.btn:AddEffect("fUI_Pet_01A", true, 0, -1)
  end
  self._hungryCheck = petHungryCheck
end
function PaGlobalFunc_ServantIcon_UpdateOtherIcon(iconType)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateOtherIcon(iconType)
  self:updatePos()
end
function FGlobal_MaidIcon_SetPos(resetScroll)
  PaGlobalFunc_ServantIcon_UpdateMaidIcon(resetScroll)
end
function PaGlobalFunc_ServantIcon_UpdateMaidIcon(resetScroll)
  PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetMaidIndex())
  local self = ServantIcon
  self:updateOtherIcon(self._iconType.maid)
  if true == resetScroll and nil ~= Panel_Window_MaidList and true == Panel_Window_MaidList:GetShow() then
    MaidList_SetScroll()
    PaGlobalFunc_IconMaid_ResetScroll()
  end
end
function PaGlobalFunc_ServantIcon_UpdateHouseIcon()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:updateHouseIcon()
end
function Servant_Call(idx)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if 0 == idx then
    InputLUp_ServantIcon_LeftMouseFunction(self._iconType.servant_Land)
  else
  end
end
function Servant_Navi(idx)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if 0 == idx then
    InputRUp_ServantIcon_RightMouseFunction(self._iconType.servant_Land)
  elseif 1 == idx then
    InputRUp_ServantIcon_RightMouseFunction(self._iconType.servant_Water)
  end
end
function FGlobal_PetListNew_NoPet()
  PaGlobalFunc_ServantIcon_UpdateOtherIcon(PaGlobalFunc_ServantIcon_GetPetIndex())
end
function PaGlobalFunc_ServantIcon_UpdateAutoBuffItemIcon()
  if _ContentsGroup_OneButtonBuff ~= true then
    return
  end
  if ServantIcon == nil then
    return
  end
  ServantIcon:updateOtherIcon(ServantIcon._iconType.AutoUseBuffItem)
  ServantIcon:updatePos()
end
function Panel_Window_Servant_GetShow()
  return _panel:GetShow()
end
function PaGlobalFunc_ServantIcon_CharacterTagCheckShow()
  if false == ToClient_IsContentsGroupOpen("330") then
    return false
  end
  if true == ToClient_isConsole() then
    return false
  end
  local player = getSelfPlayer()
  if nil == player then
    return false
  end
  return true
end
function PaGlobalFunc_ServantIcon_SimpleTooltip(isShow, tipType)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if tipType == nil then
    return TooltipSimple_Hide()
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return TooltipSimple_Hide()
  end
  local uiControl = self._iconTable[tipType].btn
  local name = ""
  local desc = ""
  if tipType == self._iconType.servant_Land or tipType == self._iconType.servant_Water then
    local vehicleWrapper = temporaryWrapper:getUnsealVehicle(tipType)
    if vehicleWrapper == nil then
      if true == self._isServantIconFunctionAvailable and tipType == self._iconType.servant_Land and true == isShow then
        local last = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
        if nil ~= last then
          local lastServantState = last:getStateType()
          if CppEnums.ServantStateType.Type_Coma == lastServantState then
            name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_DEAD_TITLE")
            desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_DEAD_DESC")
            if _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) then
              desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_DEAD_DESC_NAVI_2")
            else
              desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_DEAD_DESC_NAVI")
            end
            TooltipSimple_Show(uiControl, name, desc)
            if getEnableSimpleUI() then
              PaGlobalFunc_ServantIcon_UpdateSimpleUI(true)
            end
            return
          end
        end
      end
      name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SERVANT")
      desc = PAGetString(Defines.StringSheet_GAME, "LAU_SERVANTICON_SEALICON_TOOLTIP")
      if _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) then
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_DEAD_DESC_NAVI_2")
      end
    else
      local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
      local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
      local targetType = vehicleWrapper:getVehicleType()
      if UI_VT.Type_Horse == targetType or CppEnums.VehicleType.Type_RaceHorse == targetType or UI_VT.Type_Camel == targetType or UI_VT.Type_Donkey == targetType or UI_VT.Type_Elephant == targetType or UI_VT.Type_Carriage == targetType or UI_VT.Type_CowCarriage == targetType or UI_VT.Type_RidableBabyElephant == targetType or UI_VT.Type_RepairableCarriage == targetType then
        if isPremiumPcRoom and (UI_VT.Type_Horse == targetType or UI_VT.Type_Camel == targetType or UI_VT.Type_Donkey == targetType or UI_VT.Type_RidableBabyElephant == targetType) then
          if doHaveContentsItem(__eContentsType_OrderToServant, CppEnums.VehicleType.Type_Horse) or doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) then
            name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SERVANT")
            ServantDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANT_ICONHELP")
          else
            name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SERVANT")
            ServantDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANT_ICONHELP_FORPCROOM")
          end
        else
          name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_SERVANT")
          ServantDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANT_ICONHELP")
        end
        PaGlobal_Tooltip_Servant_All_Open(uiControl, __eServantTypeVehicle)
        return
      elseif true == _ContentsGroup_OceanCurrent then
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_CALL_TOOLTIP_NAME")
        ServantDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SHIP_ICONHELP")
        PaGlobal_Tooltip_Servant_All_Open(uiControl, __eServantTypeShip)
        return
      else
        name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_ICON_UI")
        if true == _ContentsOption_CH_GameType then
          ServantDesc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTPOSITIONSHIP_ICON_UI")
        else
          ServantDesc = PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SHIP_ICONHELP_SEANOTOPEN")
        end
      end
      desc = ServantDesc
    end
  elseif tipType == self._iconType.house then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_TOOLTIP_SELFHOUSE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_TOOLTIP_SELFHOUSE_DESC")
  elseif tipType == self._iconType.harvest then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_TOOLTIP_TENT_NAME")
    if isharvestManagement then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_TOOLTIP_TENT_DESC")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_TOOLTIP_TENT_DESC_2")
    end
  elseif tipType == self._iconType.worker then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_WORKER_TOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MYHOUSENAVI_WORKER_TOOLTIP_DESC")
  elseif tipType == self._iconType.pet then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_BUTTONTOOLTIP_PETLIST_NAME")
    if 0 == ToClient_getPetUnsealedList() then
      if 0 == ToClient_getPetSealedList() then
        local temporaryPCRoomWrapper = getTemporaryInformationWrapper()
        local isPremiumPcRoom = temporaryPCRoomWrapper:isPremiumPcRoom()
        if true == isPremiumPcRoom and true == _ContentsGroup_KR_Transfer then
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_PET_WIKI_PCROOM_INFO")
        else
          desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_PET_WIKI_INFO")
        end
      else
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_BUTTONTOOLTIP_WAITPET_DESC")
      end
    else
      if Panel_Widget_PetControl_All:GetShow() then
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_BUTTONTOOLTIP_ICONHIDE_DESC")
      else
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_PETCONTROL_BUTTONTOOLTIP_ICONSHOW_DESC")
      end
      if true == self._hungryCheck then
        desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_PETCONTROL_BUTTONTOOLTIP_PETHUNGRY_DESC", "desc", desc)
      end
    end
  elseif tipType == self._iconType.maid then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_TOOLTIP_NAME")
    desc = ""
    local warehouseInMaid = checkMaid_WarehouseIn(true)
    local warehouseOutMaid = checkMaid_WarehouseOut(true)
    local marketMaid = checkMaid_SubmitMarket(true)
    if warehouseInMaid or warehouseOutMaid then
      desc = "<" .. PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_WAREHOUSE") .. ">"
    end
    if marketMaid then
      if "" == desc then
        desc = "<" .. PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_MARKET") .. ">"
      else
        desc = desc .. ", <" .. PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_MARKET") .. ">"
      end
    end
    local maidCount = getTotalMaidList()
    local cooltimeText = ""
    local maidAffiliatedTownName = ""
    local areaName = {}
    local sameAreaCoolTime = {}
    local oneMinute = 60
    local mIndex = 0
    local usableMaidCount = 0
    if "" == desc then
      desc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MAIDLIST_TOOLTIP_DESC_2", "maidCount", maidCount)
    else
      desc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MAIDLIST_TOOLTIP_DESC_3", "desc", desc, "maidCount", maidCount)
    end
    if "" ~= maidAffiliatedTownName then
      desc = desc .. "\n" .. maidAffiliatedTownName
    end
    if not warehouseInMaid and not warehouseOutMaid and "" ~= cooltimeText then
      desc = desc .. "\n" .. cooltimeText
    end
    local hotkeyDesc = ""
    if _ContentsGroup_MaidActorSystem == true then
      hotkeyDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_TOOLTIP_DESC_4_MAIDACTOR")
    else
      hotkeyDesc = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDLIST_TOOLTIP_DESC_4")
    end
    desc = desc .. "\n" .. hotkeyDesc
    if 0 == maidCount then
      local isPcRoom = getTemporaryInformationWrapper():isPremiumPcRoom()
      if true == isPcRoom and true == _ContentsGroup_KR_Transfer then
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_MAID_WIKI_PCROOM_INFO")
      else
        desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_MAID_WIKI_INFO")
      end
    end
    if _ContentsGroup_MaidActorSystem == true then
      desc = desc .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    end
  elseif tipType == self._iconType.battle then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_ICON_DUEL_SHOWTOOLTIP_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_PVPBATTLE_ICON_DUEL_SHOWTOOLTIP_DESC")
    local selfProxy = getSelfPlayer()
    if true == _ContentsGroup_BattleGroundPvP and nil ~= selfProxy and true == selfProxy:get():isBattleGroundDefine() then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_1ON1ARENA_TOOLTIP_NAME")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_1ON1ARENA_TOOLTIP_DESC")
    end
  elseif tipType == self._iconType.camp then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CAMP_TOOLTIP_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
  elseif tipType == self._iconType.fairy then
    local count = ToClient_getFairyUnsealedList() + ToClient_getFairySealedList()
    name = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYICON_TITLE")
    if 0 == count then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_FAIRY_WIKI_INFO")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAIRYICON_DESC")
    end
  elseif tipType == self._iconType.tag then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_TAG")
    if true == _ContentsGroup_AddExpEvent_TagCharacter then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_TAGCHAR_ICON_TOOLTIP_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_TAKEEXP_EVENT")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_TAGCHAR_ICON_TOOLTIP_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_SHORTBUTTON_HOWTOUSE_TOOLTIP_DESC")
    end
  elseif tipType == self._iconType.monster then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_WIDGET_TOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTSUMMONBOSS_WIDGET_TOOLTIP_DESC")
  elseif tipType == self._iconType.PartyRecruit then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PARTYLIST_TITLE")
  elseif tipType == self._iconType.rentInstanceField then
    local iconState = ToClient_getShowInRentInstanceFieldIconState()
    if 1 == iconState then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_BTN_EXIT_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_BTN_EXIT_DESC")
    elseif 2 == iconState then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_BTN_ENTER_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_BTN_ENTER_DESC")
    else
      name = ""
      desc = ""
      _PA_ASSERT(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    end
  elseif tipType == self._iconType.AutoUseBuffItem then
    if _ContentsGroup_OneButtonBuff == true then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_AUTOBUFF_SERVANTICON_TOOLTIP_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_AUTOBUFF_SERVANTICON_TOOLTIP_DESC")
    end
  elseif tipType == self._iconType.LifeRingMenu then
    local currentMode = ToClient_GetCurrentActionMode()
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_LIFE_TOOLTIP_POSITIONCHANGE_TITLE")
    if currentMode == __eActionMode_Normal then
      local stance = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_BASE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_LIFE_TOOLTIP_POSITIONCHANGE_TO_FISH_DESC")
      desc = desc .. PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_LIFE_TOOLTIPNAME", "stance", stance) .. "\n"
    elseif currentMode == __eActionMode_FishingRod then
      local stance = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_FISH")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_LIFE_TOOLTIP_POSITIONCHANGE_TO_DEFAULT_DESC")
      desc = desc .. PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_LIFE_TOOLTIPNAME", "stance", stance) .. "\n"
    elseif currentMode == __eActionMode_FishingHarpoon then
      local stance = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_JAKSAL")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_LIFE_TOOLTIP_POSITIONCHANGE_TO_DEFAULT_DESC")
      desc = desc .. PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_LIFE_TOOLTIPNAME", "stance", stance) .. "\n"
    end
    desc = desc .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_LIFE_TOOLTIPDESC")
  elseif tipType == self._iconType.fishingCamp then
    name = "\235\130\154\236\139\156\236\186\160\237\148\132(\237\133\140\236\138\164\237\138\184)"
    desc = "\235\130\154\236\139\156\236\186\160\237\148\132(\237\133\140\236\138\164\237\138\184)"
  else
    TooltipSimple_Hide()
    return
  end
  if true == isShow then
    TooltipSimple_Show(uiControl, name, desc)
    if getEnableSimpleUI() then
      PaGlobalFunc_ServantIcon_UpdateSimpleUI(true)
    end
  else
    TooltipSimple_Hide()
    if getEnableSimpleUI() then
      PaGlobalFunc_ServantIcon_UpdateSimpleUI(false)
    end
  end
end
function PaGlobalFunc_ServantIcon_UpdateSimpleUI(isOver)
  _servantSimpleUIAlpha = 0.7
  if isOver then
    _servantSimpleUIAlpha = 1
  end
end
function Servant_UpdateSimpleUI_Force_Out()
  PaGlobalFunc_ServantIcon_UpdateSimpleUI(false)
end
function Servant_UpdateSimpleUI_Force_Over()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  PaGlobalFunc_ServantIcon_UpdateSimpleUI(true)
  for _, icon in pairs(self._iconTable) do
    if nil ~= icon and true == icon.btn:GetShow() then
      icon.btn:SetAlpha(1)
      if nil ~= icon.progressBg then
        icon.progressBg:SetAlpha(1)
      end
      if nil ~= icon.progressHp then
        icon.progressHp:SetAlpha(1)
      end
      if nil ~= icon.progressMp then
        icon.progressMp:SetAlpha(1)
      end
    end
  end
end
function FGlobal_ServantIcon_IsNearMonster_Effect(_addEffect)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if self._iconTable[self._iconType.servant_Land].btn:GetShow() then
    if true == _addEffect then
      self._iconTable[self._iconType.servant_Land].btn:EraseAllEffect()
      self._iconTable[self._iconType.servant_Land].btn:AddEffect("fUI_Alarm_HorseAttack04", false, 0, 0)
    else
      self._iconTable[self._iconType.servant_Land].btn:EraseAllEffect()
    end
  end
end
local checkTime = 0
local lifeTime = 0
function PaGlobalFunc_ServantIcon_UpdatePerFrameFunc(deltaTime)
  local self = ServantIcon
  if self == nil then
    return
  end
  if _ContentsGroup_OneButtonBuff == true then
    self:updateAutoUseBuffItem(deltaTime)
  end
  if true == self.lifeActionModeChange then
    lifeTime = lifeTime + deltaTime
    if lifeTime > 1 then
      local currentMode = ToClient_GetCurrentActionMode()
      ServantIcon_LifeRingMenuBtn_ChangeTexture(currentMode)
      self.lifeActionModeChange = false
      lifeTime = 0
    end
  end
  checkTime = checkTime + deltaTime
  if checkTime < 60 then
    return
  end
  checkTime = 0
  if not self._iconTable[self._iconType.harvest].btn:GetShow() then
    return
  end
  self._iconTable[self._iconType.harvest].btn:EraseAllEffect()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  local tentCount = temporaryWrapper:getSelfTentCount()
  if tentCount <= 0 then
    return
  end
  local isAlert = false
  local isAllAlert = true
  for index = 0, tentCount - 1 do
    local householdDataWithInstallationWrapper = temporaryWrapper:getSelfTentWrapperByIndex(index)
    local harvestcount = householdDataWithInstallationWrapper:getSelfHarvestCount()
    for ii = 0, harvestcount - 1 do
      local percent = math.min(householdDataWithInstallationWrapper:getSelfHarvestCompleteRate(ii) * 100, 200)
      if percent >= 100 then
        isAlert = true
        if false == isAllAlert then
          break
        end
      else
        isAllAlert = false
      end
    end
  end
  if isAlert then
    if false == isAllAlert then
      self._iconTable[self._iconType.harvest].btn:AddEffect("fUI_Garden_01A", true, 0, 0)
    else
      self._iconTable[self._iconType.harvest].btn:AddEffect("fUI_Garden_01B", true, 0, 0)
    end
  end
end
function PaGlobal_ServantIcon_ShowRowFoodMessage()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if false == _ContentsGroup_OceanCurrent then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
  if nil == seaVehicleWrapper then
    return
  end
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local actorKeyRaw = selfPlayer:get():getRideVehicleActorKeyRaw()
  local rideVehicleInfo = getServantInfoFromActorKey(actorKeyRaw)
  local characterKey = seaVehicleWrapper:getCharacterKeyRaw()
  if nil == rideVehicleInfo or rideVehicleInfo:getCharacterKeyRaw() ~= characterKey then
    return
  end
  local shipStaticStatus = ToClient_EmployeeCharacterShipStaticStatusWrapper(characterKey)
  if nil == shipStaticStatus then
    return
  end
  local prevFoodRate = self._iconTable[self._iconType.servant_Water].progressMp:GetCurrentControlPos() * 2
  local nowFoodRate = getMpToServantInfo(seaVehicleWrapper) / getMaxMpToServantInfo(seaVehicleWrapper) * 100
  if false == shipStaticStatus:getIsSummonFull() then
    if prevFoodRate > 50 and nowFoodRate <= 50 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_FOOD_REMAINING_WARNING"))
    elseif nowFoodRate <= 10 and 0 ~= nowFoodRate then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_FOOD_REMAINING_WARNING"))
    elseif prevFoodRate > 0 and 0 == nowFoodRate then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_USEEMPLOYEESHIP_LOWFOOD"))
    end
  elseif prevFoodRate > 50 and nowFoodRate <= 50 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_DURABILITY_REMAINING_WARNING"))
  elseif nowFoodRate <= 10 and 0 ~= nowFoodRate then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SHIP_DURABILITY_REMAINING_WARNING"))
  elseif prevFoodRate > 0 and 0 == nowFoodRate then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_NONUSEEMPLOYEESHIP_LOWFOOD"))
  end
end
function InputLUp_ServantIcon_LeftMouseFunction(index)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if true == ToClient_IsInClientInstanceDungeon() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoClientDungeon"))
    return
  end
  if Panel_UIControl:GetShow() then
    return
  end
  if index == self._iconType.servant_Land then
    local temporaryWrapper = getTemporaryInformationWrapper()
    local servantInfo
    if temporaryWrapper ~= nil then
      servantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    end
    if nil == servantInfo then
      if true == self._isServantIconFunctionAvailable then
        local last = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
        if nil ~= last then
          local lastServantState = last:getStateType()
          if _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) then
            PaGlobalFunc_NaviNearestStable(isUnsealVehicle)
          elseif CppEnums.ServantStateType.Type_Coma == lastServantState then
            audioPostEvent_SystemUi(0, 0)
            _AudioPostEvent_SystemUiForXBOX(50, 0)
            ToClient_DeleteNaviGuideByGroup(0)
            local servantNo = last:getServantNo()
            local pos = ToClient_GetLastDeadLandVehiclePosition(servantNo)
            local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, false)
          end
        elseif _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) then
          PaGlobalFunc_NaviNearestStable(isUnsealVehicle)
        end
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
      end
      return
    end
    if ToClient_IsEnterMirrorField() == true and ToClient_CheckActorInsideMirrorField(servantInfo:getPosition()) == false then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantCallServant"))
      return
    end
    local isPremiumPcRoom = temporaryWrapper:isPremiumPcRoom()
    if _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) == true then
      local vehicleType = servantInfo:getVehicleType()
      local resetDistance = ToClient_GetUnsealVehicleResetDistance(__eServantTypeVehicle)
      local betweenDistance = ToClient_GetPlayerBetweenVehicle(__eServantTypeVehicle)
      local callDistance = resetDistance / 100
      if (doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) == true or isPremiumPcRoom == true and _ContentsGroup_PremeumPCRoomSuperWhistle == true) and CppEnums.VehicleType.Type_Carriage ~= vehicleType and CppEnums.VehicleType.Type_CowCarriage ~= vehicleType and CppEnums.VehicleType.Type_RepairableCarriage ~= vehicleType then
        servant_callServant()
        return
      end
      local distance = math.ceil(math.sqrt(betweenDistance) / 100 / 10) * 10
      if callDistance >= distance then
        servant_callServant()
      else
        ToClient_DeleteNaviGuideByGroup(0)
        if index == self._currentNaviType then
          self._currentNaviType = nil
          return
        end
        local position = float3(servantInfo:getPositionX(), servantInfo:getPositionY(), servantInfo:getPositionZ())
        worldmapNavigatorStart(position, NavigationGuideParam(), false, true, true)
        audioPostEvent_SystemUi(0, 14)
        temporaryWrapper:refreshUnsealVehicle(servantInfo, true)
        self._currentNaviType = index
      end
      return
    end
    servant_callServant()
  elseif index == self._iconType.servant_Water then
    if _ContentsGroup_NewUI_ShipControl_All then
      ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_AutoRide)
    end
  elseif index == self._iconType.servant_Guild then
    FGlobal_GuildServantList_Open()
  elseif index == self._iconType.house then
    if true == _ContentsGroup_UsePadSnapping then
      if nil ~= PaGlobal_ResidenceList then
        PaGlobal_ResidenceList:open()
      end
    elseif nil ~= FGlobal_HousingList_Open then
      FGlobal_HousingList_Open()
    end
  elseif index == self._iconType.worker then
    self:updateHouseIcon()
    PaGlobalFunc_WorkerManager_All_ShowToggle()
  elseif index == self._iconType.harvest then
    if _ContentsGroup_HarvestList_All then
      if nil ~= Panel_HarvestList_All and true == Panel_HarvestList_All:GetShow() then
        PaGlobal_HarvestList_All_Close()
        return
      end
      PaGlobal_HarvestList_All_Open()
    else
      if nil ~= Panel_HarvestList and true == Panel_HarvestList:GetShow() then
        HarvestList_Close()
        return
      end
      FGlobal_HarvestList_Open()
    end
  elseif index == self._iconType.pet then
    PaGlobal_PetList_Toggle_All()
  elseif index == self._iconType.maid then
    self:updateOtherIcon(self._iconType.maid)
    if PaGlobalFunc_MarketPlace_MyInven_Close ~= nil then
      PaGlobalFunc_MarketPlace_MyInven_Close()
    end
    if PaGlobalFunc_MarketPlace_WalletInven_Close ~= nil then
      PaGlobalFunc_MarketPlace_WalletInven_Close()
    end
    if PaGlobal_Warehouse_All_Close ~= nil then
      PaGlobal_Warehouse_All_Close()
    end
    if PaGlobalFunc_Inventory_All_Close ~= nil then
      PaGlobalFunc_Inventory_All_Close()
    end
    if nil ~= Panel_Window_MaidList_All and true == Panel_Window_MaidList_All:GetShow() then
      PaGlobalFunc_MaidList_All_Close()
    else
      PaGlobalFunc_MaidList_All_Open()
    end
  elseif index == self._iconType.camp then
    if true == _ContentsGroup_NewUI_Camp_All then
      PaGlobalFunc_Camp_All_Open()
    else
      PaGlobal_Camp:open()
    end
  elseif index == self._iconType.fairy then
    if true == _ContentsGroup_NewUI_Fairy_All then
      PaGlobal_FairyInfo_Open_All(false)
    else
      PaGlobal_FairyInfo_Open(false)
    end
  elseif index == self._iconType.tag then
    PaGlobalFunc_CharacterTag_All_Open()
  elseif index == self._iconType.monster then
    servant_callGuildMonsterRideVehicle()
  elseif self._iconType.battle == index then
    local selfProxy = getSelfPlayer()
    if true == _ContentsGroup_BattleGroundPvP and nil ~= selfProxy and true == selfProxy:get():isBattleGroundDefine() then
      PaGlobal_Arena_Battle_Open()
    end
  elseif self._iconType.PartyRecruit == index then
    PaGlobalFunc_Menu_All_PartyList_Show()
  elseif self._iconType.rentInstanceField == index then
    local iconState = ToClient_getShowInRentInstanceFieldIconState()
    if 1 == iconState then
      local funcYes = function()
        ToClient_UnJoinInstanceFieldForAll()
      end
      local messageboxData = {
        title = "",
        content = PAGetString(Defines.StringSheet_GAME, "LUA_PERSONALSERVER_EXIT"),
        functionYes = funcYes,
        functionNo = MessageBox_Empty_function,
        priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
      }
      MessageBox.showMessageBox(messageboxData)
    elseif 2 == iconState then
      PaGlobal_RentInstanceField_List_Open()
    else
      _PA_ASSERT(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
    end
  elseif self._iconType.AutoUseBuffItem == index then
    if _ContentsGroup_OneButtonBuff == true then
      if PaGlobalFunc_AutoUseBuffItem_GetShow() == true then
        PaGlobalFunc_AutoUseBuffItem_Close()
      else
        PaGlobalFunc_AutoUseBuffItem_Open()
      end
    end
  elseif self._iconType.LifeRingMenu == index then
    if self._iconTable[index].subBg:GetShow() == true then
      self._iconTable[index].subBg:SetShow(false)
    else
      self._iconTable[index].subBg:SetShow(true)
      local currentMode = ToClient_GetCurrentActionMode()
      local isNormalMode = __eActionMode_Normal == currentMode
      self._iconTable[index].normal:SetShow(isNormalMode == false)
      self._iconTable[index].fish:SetShow(isNormalMode == true)
      self._iconTable[index].harpoon:SetShow(isNormalMode == true)
      local count = 2
      if isNormalMode == false then
        count = 1
      end
      self._iconTable[index].subBg:SetSize(self._iconTable[index].normal:GetSizeX() * count, self._iconTable[index].harpoon:GetSizeY())
    end
  elseif index == self._iconType.fishingCamp then
    PaGlobal_FishingCamp_Open()
  end
end
function InputRUp_ServantIcon_RightMouseFunction(index)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if Panel_UIControl:GetShow() then
    return
  end
  if true == ToClient_IsInClientInstanceDungeon() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoClientDungeon"))
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil == temporaryWrapper then
    return
  end
  if self._iconType.servant_Water == index then
    local isRecallShip = false
    if true == _ContentsGroup_NewUI_ShipControl_All and true == ToClient_CheckShipRecallDistance() then
      ToClient_AutoRideOnShipDetail(__eServantShipRideControlType_Recall)
      isRecallShip = true
    end
    if false == isRecallShip then
      ToClient_DeleteNaviGuideByGroup(0)
      if index == self._currentNaviType then
        self._currentNaviType = nil
        return
      end
      local seaVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeShip)
      if nil == seaVehicleWrapper then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
        return
      end
      local position = float3(seaVehicleWrapper:getPositionX(), seaVehicleWrapper:getPositionY(), seaVehicleWrapper:getPositionZ())
      worldmapNavigatorStart(position, NavigationGuideParam(), false, true, true)
      temporaryWrapper:refreshUnsealVehicle(seaVehicleWrapper, true)
      self._currentNaviType = index
    end
    audioPostEvent_SystemUi(0, 14)
  elseif self._iconType.servant_Land == index then
    local servantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    if nil == servantInfo then
      if true == self._isServantIconFunctionAvailable then
        local last = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
        local icon = self._iconTable[self._iconType.servant_Land]
        local isUnsealVehicle = false
        if _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) then
          PaGlobalFunc_CrogdaloStable_ShowToggle()
        else
          if nil ~= last then
            local lastServantState = last:getStateType()
            if CppEnums.ServantStateType.Type_Coma == lastServantState then
              isUnsealVehicle = true
              Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CONDITION_COMADESC"))
            end
          end
          ToClient_DeleteNaviGuideByGroup(0)
          if index == self._currentNaviType then
            self._currentNaviType = nil
            return
          end
          PaGlobalFunc_NaviNearestStable(isUnsealVehicle)
        end
      elseif _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) then
        PaGlobalFunc_CrogdaloStable_ShowToggle()
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_STABLELIST_NOT_UNSEAL_SERVANT"))
      end
      return
    end
    if servantInfo ~= nil and _ContentsGroup_UsePadSnapping == false and _ContentsGroup_Crogdalo == true and doHaveContentsItem(__eContentsType_Crogdalo) == true and servantInfo:canUseCrogdaloNest() == true then
      PaGlobalFunc_CrogdaloStable_ShowToggle()
      return
    end
    ToClient_DeleteNaviGuideByGroup(0)
    if index == self._currentNaviType then
      self._currentNaviType = nil
      return
    end
    local position = float3(servantInfo:getPositionX(), servantInfo:getPositionY(), servantInfo:getPositionZ())
    worldmapNavigatorStart(position, NavigationGuideParam(), false, true, true)
    audioPostEvent_SystemUi(0, 14)
    temporaryWrapper:refreshUnsealVehicle(servantInfo, true)
    self._currentNaviType = index
  elseif self._iconType.harvest == index then
    ToClient_DeleteNaviGuideByGroup(0)
    if index == self._currentNaviType then
      self._currentNaviType = nil
      return
    end
    local navigationGuideParam = NavigationGuideParam()
    navigationGuideParam._isAutoErase = true
    local myTentCount = temporaryWrapper:getSelfTentCount()
    for textIdx = 0, myTentCount - 1 do
      local tentWrapper = temporaryWrapper:getSelfTentWrapperByIndex(textIdx)
      local tentPosX = tentWrapper:getSelfTentPositionX()
      local tentPosY = tentWrapper:getSelfTentPositionY()
      local tentPosZ = tentWrapper:getSelfTentPositionZ()
      local tentPos = float3(tentPosX, tentPosY, tentPosZ)
      worldmapNavigatorStart(tentPos, navigationGuideParam, false, false, true)
    end
    audioPostEvent_SystemUi(0, 14)
    self._currentNaviType = index
  elseif self._iconType.pet == index then
    Panel_Widget_PetControl_ShowToggle_All()
  elseif self._iconType.battle == index then
    local selfProxy = getSelfPlayer()
    if true == _ContentsGroup_BattleGroundPvP and nil ~= selfProxy and true == selfProxy:get():isBattleGroundDefine() then
      PaGlobal_Arena_Battle_Open()
    else
      PaGlobal_PvPBattle:cancelMatch()
    end
  elseif self._iconType.camp == index then
    if true == _ContentsGroup_NewUI_Camp_All then
      PaGlobalFunc_Camp_All_RequestNavi()
    else
      PaGlobal_Camp:navi()
    end
  elseif self._iconType.tag == index then
    PaGlobalFunc_CharacterTag_All_Change()
  elseif self._iconType.AutoUseBuffItem == index then
    if _ContentsGroup_OneButtonBuff == true then
      local isActivateAutoUseBuffItem = ToClient_getCurrentAutoUseModeToggleState()
      local newState = not isActivateAutoUseBuffItem
      if newState == true and ToClient_getAutoUseBuffItemTotalCheckedCount() == 0 then
        ToClient_clearAndUpdateMap()
      end
      ToClient_setAutoUseModeToggleState(newState)
    end
  elseif self._iconType.maid == index and _ContentsGroup_MaidActorSystem == true and HandleEventLUp_MaidList_All_ToggleSummonMaidActor ~= nil then
    HandleEventLUp_MaidList_All_ToggleSummonMaidActor()
  end
end
function FromClient_ServantIcon_TamingSuccess(isTaming)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self._isTaming = isTaming
  if true == isTaming then
    ServantIcon_TamingNotify()
    Panel_FrameLoop_Widget:SetShow(true)
  else
    ServantIcon_TamingServant_Registed()
  end
end
function FromClient_ServantIcon_ChangeWorkerCount(isInitialize, listCount)
  Panel_MyHouseNavi_Update(isInitialize, listCount)
end
function FromClient_notifyUpdateGrowStep_ServantIcon(key, bool)
  if nil == key or nil == bool then
    return
  end
  local self = ServantIcon
  local changeGrowStep = false
  if __eGrowStep_worker == key then
    self:updateHouseIcon()
    changeGrowStep = true
  elseif __eGrowStep_dualCharacter == key then
    self:updateOtherIcon(self._iconType.tag)
    changeGrowStep = true
  end
  if true == changeGrowStep then
    self:updatePos()
  end
end
function FromClient_NotifyStartSiege_ServantIcon(msgtype, regionKeyRaw)
  if 0 == msgtype or 1 == msgtype then
    ServantIcon._isSiegeMonsterIcon = ServantIcon:checkSiegeMonsterIcon()
    ServantIcon:updateServantIcon()
    ServantIcon:updatePos()
  end
end
function FromClient_NotifyOccupySiege_ServantIcon(regionKeyRaw, guildName, isAlliance)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  if regionInfoWrapper:get():isMainTown() then
    ServantIcon._isSiegeMonsterIcon = false
    ServantIcon:updateServantIcon()
    ServantIcon:updatePos()
  end
end
function FromClient_NotifyReleaseSiege_ServantIcon(regionKeyRaw)
  local regionInfoWrapper = getRegionInfoWrapper(regionKeyRaw)
  if nil == regionInfoWrapper then
    return
  end
  if regionInfoWrapper:get():isMainTown() then
    ServantIcon._isSiegeMonsterIcon = false
    ServantIcon:updateServantIcon()
    ServantIcon:updatePos()
  end
end
function FromClient_responseTentInformationAck_ServantIcon()
  ServantIcon._isSiegeMonsterIcon = ServantIcon:checkSiegeMonsterIcon()
  ServantIcon:updateServantIcon()
  ServantIcon:updatePos()
end
function FromClient_ServantIcon_EventSelfPlayerLevelUp()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self:checkServantFunctionUse()
  self:updateOtherIcon(self._iconType.fairy)
  self:updateOtherIcon(self._iconType.tag)
  self:updatePos()
end
function ServantIcon_TamingNotify()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TAMING_NOTIFY"))
end
function ServantIcon_TamingServant_Registed()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  self._isTaming = false
  Panel_FrameLoop_Widget:SetShow(false)
end
function PaGlobalFunc_ServantIcon_OnResize()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  local initPosX = 10
  local initPosY = PaGlobalFunc_MainStatus_GetPosY() + PaGlobalFunc_MainStatus_GetSizeY()
  if _panel:GetRelativePosX() == -1 and _panel:GetRelativePosY() == -1 then
    if false == changePositionBySever(_panel, CppEnums.PAGameUIType.PAGameUIPanel_ServantIcon, true, true, false) then
      _panel:SetPosX(initPosX)
      _panel:SetPosY(initPosY)
    end
    FGlobal_InitPanelRelativePos(_panel, initPosX, initPosY)
  elseif _panel:GetRelativePosX() == 0 and _panel:GetRelativePosY() == 0 then
    _panel:SetPosX(initPosX)
    _panel:SetPosY(initPosY)
  else
    _panel:SetPosX(getScreenSizeX() * _panel:GetRelativePosX() - _panel:GetSizeX() / 2)
    _panel:SetPosY(getScreenSizeY() * _panel:GetRelativePosY() - _panel:GetSizeY() / 2)
  end
  _panel:SetShow(true)
  if 0 < ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_IsSaved) then
    _panel:SetShow(ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow))
  end
  FGlobal_PanelRepostionbyScreenOut(_panel)
  self:updatePos()
end
function PaGlobalFunc_ServantIcon_TamingServantTime(DeltaTime)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  if not self._tamingSuccess then
    return
  end
  self._tamingCurrentTime = self._tamingCurrentTime + DeltaTime
  if self._tamingCurrentTime < self._tamingLastNotifyTime + 20 then
    ServantIcon_TamingNotify()
    self._tamingLastNotifyTime = currentTime
  end
end
function PaGlobalFunc_ServantIcon_GetLastIcon()
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  local lastIcon
  for index = self._iconType.count - 1, 0, -1 do
    if nil ~= self._iconTable[index] and true == self._iconTable[index].btn:GetShow() then
      lastIcon = self._iconTable[index].btn
      break
    end
  end
  return lastIcon
end
function PaGlobalFunc_ServantIcon_CheckFamilyCharacterLevel(compLevel)
  local characterDataCount = getCharacterDataCount(__ePlayerCreateNormal)
  for index = 0, characterDataCount - 1 do
    local characterData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
    if compLevel <= characterData._level then
      return true
    end
  end
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer then
    local curLevel = selfPlayer:get():getLevel()
    if compLevel <= curLevel then
      return true
    end
  end
  return false
end
function PaGlobalFunc_SevanrIcon_CheckFamilyNewUser()
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    if 2 == userType then
      return true
    end
  end
  return false
end
function PaGlobalFunc_ServantIcon_GetIconPosX(iconType)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  return _panel:GetPosX() + self._iconTable[iconType].btn:GetPosX()
end
function PaGlobalFunc_ServantIcon_GetIconPosY(iconType)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  return _panel:GetPosY() + self._iconTable[iconType].btn:GetPosY()
end
function PaGlobalFunc_ServantIcon_GetIconSizeX(iconType)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  return self._iconTable[iconType].btn:GetSizeX()
end
function PaGlobalFunc_ServantIcon_GetIconSizeY(iconType)
  local self = ServantIcon
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ServantIcon")
    return
  end
  return self._iconTable[iconType].btn:GetSizeY()
end
function PaGlobalFunc_ServantIcon_GetPetIndex()
  return ServantIcon._iconType.pet
end
function PaGlobalFunc_ServantIcon_GetMaidIndex()
  return ServantIcon._iconType.maid
end
function PaGlobalFunc_ServantIcon_GetCampIndex()
  return ServantIcon._iconType.camp
end
function PaGlobalFunc_ServantIcon_GetBattleIndex()
  return ServantIcon._iconType.battle
end
function PaGlobalFunc_ServantIcon_GetTagIndex()
  return ServantIcon._iconType.tag
end
function PaGlobalFunc_ServantIcon_GetPanelPosY()
  return _panel:GetPosY()
end
function PaGlobalFunc_ServantIcon_GetFishingCamp()
  return ServantIcon._iconType.fishingCamp
end
Panel_FrameLoop_Widget:RegisterUpdateFunc("PaGlobalFunc_ServantIcon_TamingServantTime")
_panel:RegisterUpdateFunc("PaGlobalFunc_ServantIcon_UpdatePerFrameFunc")
function FGlobal_Window_Servant_ColorBlindUpdate()
end
function FGlobal_RaceInfo_Hide()
end
function HouseNaviBasicInitPosition()
end
registerEvent("FromClient_luaLoadComplete", "PaGlobalFunc_ServantIcon_Init")
function PaGlobal_CampTestOpen()
  if true == ToClient_IsDevelopment() then
    ServantIcon:updateOtherIcon(ServantIcon._iconType.camp, true)
  end
end
function PaGlobalFunc_PartyRecruitIcon_Show()
  ServantIcon:updateOtherIcon(ServantIcon._iconType.PartyRecruit, false)
end
function FromClient_MaidList_All_NoticeLeftCount(isMarketMaid)
  if _ContentsGroup_UseMultiMaid == false then
    return
  end
  if isMarketMaid == nil then
    isMarketMaid = false
  end
  local leftCount = ToClient_getUsableMaidCountByType(isMarketMaid)
  local ackString = ""
  if isMarketMaid == false then
    ackString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MAIDUSECOUNT_MSG", "maidName", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_WAREHOUSEMAID_TAPBUTTON"), "count", tostring(leftCount))
  else
    ackString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MAIDUSECOUNT_MSG", "maidName", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_MAIDLIST_EXCHANGEMAID_TAPBUTTON"), "count", tostring(leftCount))
  end
  Proc_ShowMessage_Ack(ackString)
end
function PaGlobalFunc_updateRentInstanceFieldIcon()
  ServantIcon:updateOtherIcon(ServantIcon._iconType.rentInstanceField, false)
  ServantIcon:updatePos()
end
function PaGlobalFunc_NaviNearestStable(isUnsealVehicle)
  local player = getSelfPlayer()
  if nil == player then
    return
  end
  if nil == CppEnums.SpawnType.eSpawnType_Stable then
    return
  end
  audioPostEvent_SystemUi(0, 0)
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  ToClient_DeleteNaviGuideByGroup(0)
  local position = player:get3DPos()
  local nearNpcInfo = getNearNpcInfoByType(CppEnums.SpawnType.eSpawnType_Stable, position)
  if nil == nearNpcInfo then
    return
  end
  local isSpawnNearNpc = nearNpcInfo:isTimeSpawn()
  local pos = nearNpcInfo:getPosition()
  local npcNaviKey = ToClient_WorldMapNaviStart(pos, NavigationGuideParam(), false, false)
  audioPostEvent_SystemUi(0, 14)
  _AudioPostEvent_SystemUiForXBOX(0, 14)
  local selfPlayer = getSelfPlayer():get()
  selfPlayer:setNavigationMovePath(npcNaviKey)
  selfPlayer:checkNaviPathUI(npcNaviKey)
  if false == isSpawnNearNpc then
    NotifyDisplay(PAGetString(Defines.StringSheet_GAME, "NPCNAVIGATION_REST_AVAILABLE"))
  end
  if false == isUnsealVehicle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_NAVIGATIONDESCRIPTION_NOT_UNSEAL_VEHICLE"))
  else
    Proc_ShowMessage_Ack(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_TOWNNPCNAVI_NAVIGATIONDESCRIPTION", "npcName", tostring(CppEnums.SpawnTypeString[CppEnums.SpawnType.eSpawnType_Stable])))
  end
  PaGlobal_TutorialManager:handleClickedTownNpcIconNaviStart(CppEnums.SpawnType.eSpawnType_Stable, false)
end
function ServantIcon:checkServantFunctionUse()
  local player = getSelfPlayer()
  local playerGet = player:get()
  if nil ~= player and 15 <= playerGet:getLevel() or questList_isClearQuest(21119, 1) or questList_isClearQuest(21119, 2) or questList_isClearQuest(21119, 3) then
    self._isServantIconFunctionAvailable = true
  end
end
function PaGlobalFunc_ServantIcon_ChangeLifeEquip(index)
  local self = ServantIcon
  if nil == self then
    return
  end
  ToClient_RequestChangeActionMode(index)
  TooltipSimple_Hide()
  ServantIcon_LifeRingMenuBtn_ChangeTexture(index)
  self.lifeActionModeChange = true
  self._iconTable[self._iconType.LifeRingMenu].subBg:SetShow(false)
  self._iconTable[self._iconType.LifeRingMenu].fish:SetShow(false)
  self._iconTable[self._iconType.LifeRingMenu].harpoon:SetShow(false)
  self._iconTable[self._iconType.LifeRingMenu].normal:SetShow(false)
end
function FromClient_ServantIcon_UpdateAutoUseItemModeToggleState(isOn)
  local self = ServantIcon
  if self == nil or _ContentsGroup_OneButtonBuff == false then
    return
  end
  self:updateOtherIcon(self._iconType.AutoUseBuffItem)
  self:updatePos()
end
function FromClient_ServantIcon_StartAutoUseBuffItemTimer(itemKeyRaw)
  local self = ServantIcon
  if self == nil or _ContentsGroup_OneButtonBuff == false then
    return
  end
  if itemKeyRaw == nil then
    UI.ASSERT_NAME(false, "\236\158\144\235\143\153 \236\130\172\236\154\169 \235\140\128\236\131\129 \236\149\132\236\157\180\237\133\156 Key\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!!! \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!!!!", "\236\157\180\236\163\188")
    return
  end
  local itemEnchantKey = ItemEnchantKey(itemKeyRaw, 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    UI.ASSERT_NAME(false, "\236\158\144\235\143\153 \236\130\172\236\154\169 \235\140\128\236\131\129 ItemSSW\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!!! \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!!!!", "\236\157\180\236\163\188")
    return
  end
  if _panel:GetShow() == false and ToClient_getCurrentAutoUseModeToggleState() == true and ToClient_isLearnedFairySkill() == true and ToClient_isOnAutoUseItemUpdateFuncFlag() == false then
    ToClient_setUseAutoUseItemUpdateFunc()
    return
  end
  if self._stc_nextUseItemParent:GetShow() == true then
    return
  end
  self._stc_nextUseItemParent:SetShow(true)
  self._autoUseBuffItem_ExpireTime = self._autoUseBuffItem_UseItemTermTime
  local icon = self._iconTable[self._iconType.AutoUseBuffItem]
  if icon == nil then
    UI.ASSERT_NAME(false, "\236\158\144\235\143\153 \236\130\172\236\154\169 Icon\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!!! \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!!!!", "\236\157\180\236\163\188")
    return
  end
  local autoUseBtnCenterPosX = icon.btn:GetPosX() + icon.btn:GetSizeX() / 2
  local autoUseBtnPosY = icon.btn:GetPosY()
  self._stc_nextUseItemParent:SetPosX(autoUseBtnCenterPosX - self._stc_nextUseItemParent:GetSizeX() / 2)
  self._stc_nextUseItemParent:SetPosY(autoUseBtnPosY + self._stc_nextUseItemParent:GetSizeY() + 10)
  local autoUseItemSlot = {}
  SlotItem.reInclude(autoUseItemSlot, "Icon_AutoUse_", 0, self._stc_nextUseItemSlotBg, self._slotConfig)
  autoUseItemSlot:clearItem()
  autoUseItemSlot:setItemByStaticStatus(itemSSW)
  autoUseItemSlot.icon:addInputEvent("Mouse_On", "")
  autoUseItemSlot.icon:addInputEvent("Mouse_Out", "")
  self._stc_nextUseItemProgress:SetProgressRate(100)
end
function FromClient_ServantIcon_ChangedLearnedFairyPotionSkill(isLearned)
  local self = ServantIcon
  if self == nil or _ContentsGroup_OneButtonBuff == false then
    return
  end
  self:updateOtherIcon(self._iconType.AutoUseBuffItem, nil, isLearned)
  self:updatePos()
end
function FromClient_ServantIcon_UpdateUIOnce_NotReloadUI()
  PaGlobalFunc_ServantIcon_UpdateAutoBuffItemIcon()
end
function ServantIcon:updateAutoUseBuffItem(deltaTime)
  if _ContentsGroup_OneButtonBuff == false then
    return
  end
  local isActivateAutoUseBuffItem = ToClient_getCurrentAutoUseModeToggleState()
  if isActivateAutoUseBuffItem == false or ToClient_isLearnedFairySkill() == false then
    if self._stc_nextUseItemParent:GetShow() == true then
      self._stc_nextUseItemParent:SetShow(false)
    end
    return
  end
  if self._stc_nextUseItemParent:GetShow() == false then
    return
  end
  self._autoUseBuffItem_ExpireTime = self._autoUseBuffItem_ExpireTime - deltaTime
  local expireTimeRatio = self._autoUseBuffItem_ExpireTime / self._autoUseBuffItem_UseItemTermTime
  self._stc_nextUseItemProgress:SetProgressRate(expireTimeRatio * 100)
  if self._autoUseBuffItem_ExpireTime < 0 then
    self._stc_nextUseItemParent:SetShow(false)
    ToClient_setUseAutoUseItemUpdateFunc()
  end
end
function FromClient_ChangedLifeEquipModeAck(mode)
  if ServantIcon_LifeRingMenuBtn_ChangeTexture ~= nil then
    ServantIcon_LifeRingMenuBtn_ChangeTexture(mode)
  end
end
function PaGlobalFunc_ServantIcon_LifeRingMenu_Alarm()
  local self = ServantIcon
  self._iconTable[self._iconType.LifeRingMenu].btn:EraseAllEffect()
  if Panel_Window_Equipment_All ~= nil then
    if Panel_Window_Equipment_All:GetShow() == true then
      self._iconTable[self._iconType.LifeRingMenu].btn:AddEffect("UI_ItemInstall", true, 0, 0)
    else
      self._iconTable[self._iconType.LifeRingMenu].btn:EraseAllEffect()
    end
  end
end
