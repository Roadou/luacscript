PaGlobal_PartyEnchant = {
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createEnchant = true,
    createCash = true,
    createMaidActorOnly = true,
    createOriginalForDuel = true
  },
  _slotConfig_count = {
    createIcon = true,
    createBorder = true,
    createCount = true,
    createEnchant = true,
    createCash = true
  },
  _groupEnchantResultEnum = {
    eResultSuccess = 0,
    eResultBroken = 1,
    eResultDown = 2,
    eResultFail = 3,
    eResultPrevent = 4,
    eResultError = 5,
    eResultCount = 6
  },
  _bubbleTextShowTime = 6,
  _originPartyMemberX = 0,
  _maxEnchantViewIndex = 3,
  _enchantViewDataList = {},
  _partyData = {},
  _originPosY = 0,
  _stcToSizeX = 0,
  _stcToSizeY = 0,
  _isAnimating = false,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_PartyEnchant_Init")
function FromClient_PartyEnchant_Init()
  PaGlobal_PartyEnchant:initialize()
end
function PaGlobal_PartyEnchant:initialize()
  if true == PaGlobal_PartyEnchant._initialize or nil == Panel_Widget_PartyEnchant_Member1_All or nil == Panel_Widget_PartyEnchant_Member2_All or nil == Panel_Widget_PartyEnchant_Member3_All or nil == Panel_Widget_PartyEnchant_Member4_All then
    return
  end
  local function setEnchantViewData(index, panel)
    local viewData = {
      _panel = nil,
      _ctrl = nil,
      _actorKey = nil,
      _bubbleTextDeltaTime = 0
    }
    viewData._panel = panel
    self._enchantViewDataList[index] = viewData
  end
  setEnchantViewData(0, Panel_Widget_PartyEnchant_Member1_All)
  setEnchantViewData(1, Panel_Widget_PartyEnchant_Member2_All)
  setEnchantViewData(2, Panel_Widget_PartyEnchant_Member3_All)
  setEnchantViewData(3, Panel_Widget_PartyEnchant_Member4_All)
  self._originPosY = Panel_Widget_PartyEnchant_Member1_All:GetPosY()
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    self._originPosY = self._originPosY + 50
  end
  for index = 0, self._maxEnchantViewIndex do
    if self._enchantViewDataList[index]._panel ~= nil then
      local Panel_Widget_PartyEnchant_Member = self._enchantViewDataList[index]._panel
      Panel_Widget_PartyEnchant_Member:SetSpanSize(Panel_Widget_PartyEnchant_Member:GetSpanSize().x, self._originPosY + index * (Panel_Widget_PartyEnchant_Member:GetSizeY() + 50))
      local viewDataCtrl = {}
      viewDataCtrl.stc_MemberInfo = UI.getChildControl(Panel_Widget_PartyEnchant_Member, "Static_MemberInfo")
      viewDataCtrl.stc_ClassBG = UI.getChildControl(viewDataCtrl.stc_MemberInfo, "Static_ClassBG")
      viewDataCtrl.stc_ClassIcon = UI.getChildControl(viewDataCtrl.stc_ClassBG, "Static_ClassIcon")
      viewDataCtrl.stc_Leader = UI.getChildControl(viewDataCtrl.stc_MemberInfo, "Static_Leader")
      viewDataCtrl.stc_FamilyName = UI.getChildControl(viewDataCtrl.stc_MemberInfo, "StaticText_FamilyName")
      viewDataCtrl.stc_Ready = UI.getChildControl(viewDataCtrl.stc_MemberInfo, "StaticText_Ready")
      viewDataCtrl.stc_EnchantArea = UI.getChildControl(Panel_Widget_PartyEnchant_Member, "Static_EnchantArea")
      viewDataCtrl.stc_Cron = UI.getChildControl(viewDataCtrl.stc_EnchantArea, "Static_Cron")
      viewDataCtrl.stc_CronSlotBg = UI.getChildControl(viewDataCtrl.stc_Cron, "Static_SlotBG")
      viewDataCtrl.stc_CronSlot = UI.getChildControl(viewDataCtrl.stc_Cron, "Static_Slot")
      viewDataCtrl.stc_Equip = UI.getChildControl(viewDataCtrl.stc_EnchantArea, "Static_Equip")
      viewDataCtrl.stc_EquipSlotBg = UI.getChildControl(viewDataCtrl.stc_Equip, "Static_SlotBG")
      viewDataCtrl.stc_EquipSlot = UI.getChildControl(viewDataCtrl.stc_Equip, "Static_Slot")
      viewDataCtrl.stc_To = UI.getChildControl(Panel_Widget_PartyEnchant_Member, "Static_To")
      viewDataCtrl.stc_TextTo = UI.getChildControl(viewDataCtrl.stc_To, "StaticText_To")
      viewDataCtrl._slotEquip = {}
      self._originPartyMemberX = viewDataCtrl.stc_FamilyName:GetPosX()
      self._stcToSizeX = viewDataCtrl.stc_To:GetSizeX()
      self._stcToSizeY = viewDataCtrl.stc_To:GetSizeY()
      local slotEquip = {}
      SlotItem.new(slotEquip, "EnchantGroupEnchant_Slot_0", 0, viewDataCtrl.stc_EquipSlot, self._slotConfig)
      slotEquip:createChild()
      slotEquip.empty = true
      slotEquip:clearItem()
      slotEquip.border:SetSize(44, 44)
      slotEquip.border:SetPosX(0)
      slotEquip.border:SetPosY(0)
      viewDataCtrl._slotEquip.slot = slotEquip
      local slotMaterialTop = {}
      SlotItem.new(slotMaterialTop, "EnchantGroupEnchant_Slot_1", 0, viewDataCtrl.stc_CronSlot, self._slotConfig_count)
      slotMaterialTop:createChild()
      slotMaterialTop.empty = true
      slotMaterialTop:clearItem()
      slotMaterialTop.border:SetSize(44, 44)
      slotMaterialTop.border:SetPosX(0)
      slotMaterialTop.border:SetPosY(0)
      viewDataCtrl._slotMateiralInfo = slotMaterialTop
      self._enchantViewDataList[index]._ctrl = viewDataCtrl
    end
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_PartyEnchant:validate()
  PaGlobal_PartyEnchant:registEventHandler()
  PaGlobal_PartyEnchant:swichPlatform(self._isConsole)
  PaGlobal_PartyEnchant._initialize = true
end
function PaGlobal_PartyEnchant:registEventHandler()
  registerEvent("FromClient_SetGroupEnchant", "FromClient_SetGroupEnchant")
  registerEvent("FromClient_SetGroupEnchantCancel", "FromClient_SetGroupEnchantCancel")
  registerEvent("FromClient_SendChatMessageGroupEnchant", "FromClient_SendChatMessageGroupEnchant")
  registerEvent("FromClient_GroupEnchantRemasterResult", "PaGlobalFunc_PartyEnchant_ResultShow")
  Panel_Widget_PartyEnchant_Member1_All:RegisterUpdateFunc("PaGlobalFunc_PartyEnchant_Update")
end
function PaGlobal_PartyEnchant:swichPlatform(isConsole)
end
function PaGlobal_PartyEnchant:prepareOpen()
  if nil == Panel_Widget_PartyEnchant_Member1_All or nil == Panel_Widget_PartyEnchant_Member2_All or nil == Panel_Widget_PartyEnchant_Member3_All or nil == Panel_Widget_PartyEnchant_Member4_All then
    return
  end
  PaGlobal_PartyEnchant:update()
  PaGlobalFunc_PartyEnchant_OnScreenResize()
end
function PaGlobal_PartyEnchant:update()
  if nil == Panel_Widget_PartyEnchant_Member1_All or nil == Panel_Widget_PartyEnchant_Member2_All or nil == Panel_Widget_PartyEnchant_Member3_All or nil == Panel_Widget_PartyEnchant_Member4_All then
    return
  end
  PaGlobal_Party_All:openGroupEnchantState()
  local memberCount = RequestParty_getPartyMemberCount()
  if memberCount <= 0 then
    for index = 0, self._maxEnchantViewIndex do
      if self._enchantViewDataList[index] ~= nil then
        self._enchantViewDataList[index]._panel:SetShow(false)
      end
    end
    return
  end
  local viewDataListCount = 0
  if ToClient_IsGroupEnchantAble() == false then
    for index = 0, self._maxEnchantViewIndex do
      if self._enchantViewDataList[index] ~= nil then
        self._enchantViewDataList[index]._panel:SetShow(false)
      end
    end
  else
    if Panel_Window_StackExtraction_All:GetShow() == false and _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == false then
      return
    end
    if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
      if RequestParty_isLeader() == false and ToClient_GetIsGroupEnchant() == false then
        return
      end
    elseif RequestParty_isLeader() == false and PaGlobal_SpiritEnchant_All._isGroupEnchantPartyMember == false then
      return
    end
    for index = 0, memberCount - 1 do
      local memberData = RequestParty_getPartyMemberAt(index)
      if nil == memberData then
        return
      end
      local isSelf = RequestParty_isSelfPlayer(index)
      if isSelf == false then
        local isMaster = memberData._isMaster
        local actorKeyRaw = memberData:getActorKey()
        local name = memberData:name()
        local class = memberData:classType()
        local itemEnchantKeyRaw = memberData:getItemEnchantKeyRaw()
        local cronNeedCount = memberData:getGroupEcnahtNeedCronCount()
        local isCronUse = memberData:getGroupEnchantUseCron()
        local isReady = memberData:getGroupEnchantSet()
        local preventItemEnchantKeyRaw = memberData:getGroupEnchantPreventItemEnchantKeyRaw()
        self._enchantViewDataList[viewDataListCount]._actorKey = actorKeyRaw
        self._enchantViewDataList[viewDataListCount]._panel:SetShow(true)
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_To:SetShow(false)
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EVENT_PARTYENCHANT_READY"))
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Basic_Icon_Server_Mini_Off")
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:setRenderTexture(self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:getBaseTexture())
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:SetFontColor(Defines.Color.C_FF6C6C6C)
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_CronSlot:EraseAllEffect()
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_EquipSlot:EraseAllEffect()
        self._enchantViewDataList[viewDataListCount]._ctrl._slotEquip.slot:clearItem(true)
        self._enchantViewDataList[viewDataListCount]._ctrl._slotMateiralInfo:clearItem(true)
        if isMaster == true then
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Leader:SetShow(true)
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_FamilyName:SetPosX(self._originPartyMemberX + self._enchantViewDataList[viewDataListCount]._ctrl.stc_Leader:GetSizeX())
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_FamilyName:SetSpanSize(110, self._enchantViewDataList[viewDataListCount]._ctrl.stc_FamilyName:GetSpanSize().y)
        else
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Leader:SetShow(false)
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_FamilyName:SetSpanSize(90, self._enchantViewDataList[viewDataListCount]._ctrl.stc_FamilyName:GetSpanSize().y)
        end
        self._enchantViewDataList[viewDataListCount]._ctrl.stc_FamilyName:SetText(name)
        PaGlobalFunc_Util_SetFriendClassTypeIcon(self._enchantViewDataList[viewDataListCount]._ctrl.stc_ClassIcon, class)
        if isReady == true then
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Basic_Icon_Server_Mini_On_Green")
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:setRenderTexture(self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:getBaseTexture())
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EVENT_PARTYENCHANT_READYCOMPLETE"))
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:SetFontColor(Defines.Color.C_FFF4D351)
        else
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Basic_Icon_Server_Mini_Off")
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:setRenderTexture(self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:getBaseTexture())
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EVENT_PARTYENCHANT_READY"))
          self._enchantViewDataList[viewDataListCount]._ctrl.stc_Ready:SetFontColor(Defines.Color.C_FF6C6C6C)
        end
        local equipSlot = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKeyRaw))
        if equipSlot ~= nil then
          self._enchantViewDataList[viewDataListCount]._ctrl._slotEquip.slot:setItemByStaticStatus(equipSlot)
          if preventItemEnchantKeyRaw == 16080 then
            local currentPerfectSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
            self._enchantViewDataList[viewDataListCount]._ctrl._slotMateiralInfo:setItemByStaticStatus(currentPerfectSS, cronNeedCount)
            if isCronUse == true then
              self._enchantViewDataList[viewDataListCount]._ctrl.stc_Cron:SetMonoTone(false)
            else
              self._enchantViewDataList[viewDataListCount]._ctrl.stc_Cron:SetMonoTone(true)
            end
          else
            local preventItemSS = getItemEnchantStaticStatus(ItemEnchantKey(preventItemEnchantKeyRaw))
            if preventItemSS ~= nil then
              if preventItemSS:isSafeLowProtectorItem() == true then
                self._enchantViewDataList[viewDataListCount]._ctrl._slotMateiralInfo:setItemByStaticStatus(preventItemSS, 1)
              else
                self._enchantViewDataList[viewDataListCount]._ctrl._slotMateiralInfo:setItemByStaticStatus(preventItemSS)
              end
              self._enchantViewDataList[viewDataListCount]._ctrl.stc_Cron:SetMonoTone(false)
            else
              local cronSS = getItemEnchantStaticStatus(ItemEnchantKey(16080))
              self._enchantViewDataList[viewDataListCount]._ctrl._slotMateiralInfo:setItemByStaticStatus(cronSS, cronNeedCount)
              self._enchantViewDataList[viewDataListCount]._ctrl.stc_Cron:SetMonoTone(true)
            end
          end
        end
        viewDataListCount = viewDataListCount + 1
      else
        local isMaster = memberData._isMaster
        local isReady = memberData:getGroupEnchantSet()
        HandleEventLUp_SpiritEnchant_All_GroupEnchantReadyToggle(isReady, isMaster)
      end
    end
    if RequestParty_isLeader() == true then
      FGlobal_Enchant_SetGroupEnchantMode()
    end
  end
end
function PaGlobal_PartyEnchant:open()
end
function PaGlobal_PartyEnchant:prepareClose()
  PaGlobal_PartyEnchant:close()
end
function PaGlobal_PartyEnchant:close()
  local memberCount = RequestParty_getPartyMemberCount()
  for index = 0, memberCount - 1 do
    if self._enchantViewDataList[index] ~= nil then
      self._enchantViewDataList[index]._panel:SetShow(false)
    end
  end
end
function PaGlobalFunc_PartyEnchant_OnScreenResize()
  PaGlobal_PartyEnchant:ComputePos()
end
function PaGlobal_PartyEnchant:ComputePos()
  for index = 0, self._maxEnchantViewIndex do
    if self._enchantViewDataList[index]._panel ~= nil then
      local Panel_Widget_PartyEnchant_Member = self._enchantViewDataList[index]._panel
      Panel_Widget_PartyEnchant_Member:ComputePosAllChild()
    end
  end
end
function PaGlobalFunc_PartyEnchant_Close()
  PaGlobal_PartyEnchant:prepareClose()
end
function PaGlobal_PartyEnchant:validate()
end
function FromClient_SetGroupEnchant()
  PaGlobal_PartyEnchant:update()
end
function FromClient_SetGroupEnchantRemasterCancel(isLeader)
  PaGlobal_Party_All:openGroupEnchantState()
  local doExit = function()
    if ToClient_GetIsGroupEnchant() == true then
      PaGlobalFunc_PartyEnchant_Close()
      PaGlobalFunc_EnchantMain_All_Close()
    end
  end
  if isLeader == true and RequestParty_isLeader() == true then
    doExit()
  end
  if Panel_Widget_Enchant_Main_All:GetShow() == false then
    return
  end
  local descStr
  if isLeader == true then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_PARTYENCHANT_LEADER_OUT")
  else
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_PARTYENCHANT_CREW_OUT")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = descStr,
    functionApply = doExit,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_PartyEnchant._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData, nil, false, true)
  end
end
function FromClient_SetGroupEnchantCancel(isLeader)
  if _ContentsGroup_EnchantRemaster == true then
    FromClient_SetGroupEnchantRemasterCancel(isLeader)
    return
  end
  PaGlobal_Party_All:openGroupEnchantState()
  local doExit = function()
    if PaGlobal_SpiritEnchant_All._isGroupEnchantPartyMember == true or PaGlobal_SpiritEnchant_All._isLeaderGroupEnchantMode == true then
      ToClient_BlackspiritEnchantCancel()
      PaGlobalFunc_PartyEnchant_Close()
      PaGlobal_SpiritEnchant_All:prepareClose()
      HandleEventLUp_DialogMain_All_BackClick()
    end
  end
  if isLeader == true and RequestParty_isLeader() == true then
    doExit()
  end
  if Panel_Window_StackExtraction_All:GetShow() == false then
    return
  end
  local descStr
  if isLeader == true then
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_PARTYENCHANT_LEADER_OUT")
  else
    descStr = PAGetString(Defines.StringSheet_GAME, "LUA_EVENT_PARTYENCHANT_CREW_OUT")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = descStr,
    functionApply = doExit,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_PartyEnchant._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData, nil, false, true)
  end
end
function PaGlobalFunc_PartyEnchant_StartEffect()
  if _ContentsGroup_EnchantRemaster == true and Panel_Widget_Enchant_Main_All:GetShow() == true then
    if Panel_Widget_Enchant_Main_All:GetShow() == false then
      return
    end
  elseif Panel_Window_StackExtraction_All:GetShow() == false then
    return
  end
  local self = PaGlobal_PartyEnchant
  local memberCount = RequestParty_getPartyMemberCount()
  for index = 0, memberCount - 1 do
    local enchantViewData = self._enchantViewDataList[index]
    if nil == enchantViewData then
      return
    end
    self._isAnimating = true
    enchantViewData._ctrl.stc_CronSlot:EraseAllEffect()
    enchantViewData._ctrl.stc_EquipSlot:EraseAllEffect()
    enchantViewData._ctrl.stc_CronSlot:AddEffect("fUI_Party_Upgrade_02A", true, 0, 0)
    enchantViewData._ctrl.stc_EquipSlot:AddEffect("fUI_Party_Upgrade_02B", true, 0, 0)
  end
end
function PaGlobalFunc_PartyEnchant_ResultShow()
  if Panel_Window_StackExtraction_All:GetShow() == false then
    if _ContentsGroup_EnchantRemaster == true then
      if Panel_Widget_Enchant_Main_All:GetShow() == false then
        return
      end
    else
      return
    end
  end
  local self = PaGlobal_PartyEnchant
  local memberCount = RequestParty_getPartyMemberCount()
  self._isAnimating = false
  for index = 0, memberCount - 1 do
    do
      local enchantViewData = self._enchantViewDataList[index]
      local function groupEnchantResultShow()
        if nil == enchantViewData then
          return
        end
        local memberData = ToClient_getPartyMemberByActorKeyRaw(self._enchantViewDataList[index]._actorKey)
        if nil == memberData then
          return
        end
        local groupEnchantResult = memberData:getGroupEnchantResult()
        local groupEnchantResultItem = memberData:getGroupEnchantResultItemRaw()
        enchantViewData._ctrl._slotMateiralInfo:clearItem(true)
        enchantViewData._ctrl._slotEquip.slot:clearItem(true)
        enchantViewData._ctrl.stc_Ready:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EVENT_PARTYENCHANT_READY"))
        enchantViewData._ctrl.stc_Ready:ChangeTextureInfoAndSizeByTextureIDKey("Combine_Basic_Icon_Server_Mini_Off")
        enchantViewData._ctrl.stc_Ready:setRenderTexture(enchantViewData._ctrl.stc_Ready:getBaseTexture())
        enchantViewData._ctrl.stc_Ready:SetFontColor(Defines.Color.C_FF6C6C6C)
        local resultItemSS = getItemEnchantStaticStatus(ItemEnchantKey(groupEnchantResultItem))
        if resultItemSS ~= nil then
          enchantViewData._ctrl._slotEquip.slot:setItemByStaticStatus(resultItemSS)
        end
        if groupEnchantResult == self._groupEnchantResultEnum.eResultSuccess then
          enchantViewData._ctrl.stc_EquipSlot:AddEffect("fUI_Party_Upgrade_Success_01A", false, 0, 0)
        else
          enchantViewData._ctrl.stc_EquipSlot:AddEffect("fUI_Party_Upgrade_Fail_01A", true, 0, 0)
        end
      end
      groupEnchantResultShow()
    end
  end
  PaGlobalFunc_PartyEnchant_EndExit()
end
function PaGlobalFunc_PartyEnchant_EndExit()
  local doExit = function()
    PaGlobal_PartyEnchant:update()
    if Panel_Window_StackExtraction_All:GetShow() == true then
      PaGlobalFunc_SpiritEnchant_All_Close()
    else
      PaGlobalFunc_EnchantMain_All_Close()
    end
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "PANEL_EVENT_PARTYENCHANT_DONE"),
    functionApply = doExit,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  if false == PaGlobal_PartyEnchant._isConsole then
    MessageBox.showMessageBox(messageBoxData, nil, false, false)
  else
    MessageBox.showMessageBox(messageBoxData, nil, false, true)
  end
end
function FromClient_SendChatMessageGroupEnchant(actorKeyRaw, msg)
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  if Panel_Window_StackExtraction_All:GetShow() == false then
    return
  end
  local self = PaGlobal_PartyEnchant
  local selfPlayer = getSelfPlayer()
  if nil ~= selfPlayer and selfPlayer:getActorKey() == actorKeyRaw then
    PaGlobal_BubbleText:SetShowBubbleText(true)
    PaGlobal_BubbleText:SetBubbleText(msg)
    return
  end
  local memberCount = RequestParty_getPartyMemberCount()
  for index = 0, memberCount - 1 do
    local enchantViewData = self._enchantViewDataList[index]
    if nil == enchantViewData then
      return
    end
    local memberData = ToClient_getPartyMemberByActorKeyRaw(enchantViewData._actorKey)
    if nil == memberData then
      return
    end
    local groupEnchantActorKeyRaw = memberData:getActorKey()
    if actorKeyRaw == groupEnchantActorKeyRaw then
      self:SetShowBubbleText(enchantViewData, true)
      self:SetBubbleText(enchantViewData, msg)
    end
  end
end
function PaGlobal_PartyEnchant:SetShowBubbleText(enchantViewData, isShow)
  enchantViewData._ctrl.stc_To:SetShow(isShow)
  enchantViewData._ctrl.stc_TextTo:SetShow(isShow)
  if false == isShow then
    enchantViewData._ctrl.stc_TextTo:SetText("")
  else
    enchantViewData._ctrl.stc_To:ResetVertexAni()
    enchantViewData._ctrl.stc_To:SetVertexAniRun("Ani_Move_Pos_New", true)
    enchantViewData._ctrl.stc_To:SetVertexAniRun("Ani_Scale_New", true)
  end
end
function PaGlobal_PartyEnchant:SetBubbleText(enchantViewData, text)
  UI.ASSERT_NAME(nil ~= text, "bubbleText\234\176\128 nil\236\158\133\235\139\136\235\139\164.", "\236\181\156\237\149\156\236\167\132")
  enchantViewData._ctrl.stc_TextTo:SetTextMode(__eTextMode_AutoWrap)
  enchantViewData._ctrl.stc_TextTo:SetText(text)
  enchantViewData._ctrl.stc_To:SetSize(self._stcToSizeX, self._stcToSizeY)
  if enchantViewData._ctrl.stc_TextTo:GetTextSizeX() > enchantViewData._ctrl.stc_To:GetSizeX() then
    enchantViewData._ctrl.stc_To:SetSize(enchantViewData._ctrl.stc_TextTo:GetTextSizeX() + 30, enchantViewData._ctrl.stc_To:GetSizeY())
  end
  if enchantViewData._ctrl.stc_TextTo:GetTextSizeY() > enchantViewData._ctrl.stc_To:GetSizeY() then
    enchantViewData._ctrl.stc_To:SetSize(enchantViewData._ctrl.stc_To:GetSizeX(), enchantViewData._ctrl.stc_TextTo:GetTextSizeY() + 30)
  end
  enchantViewData._ctrl.stc_To:ComputePosAllChild()
  enchantViewData._bubbleTextDeltaTime = 0
  enchantViewData._isShowBubbleText = true
end
function PaGlobalFunc_PartyEnchant_Update(deltaTime)
  if _ContentsGroup_SpiritGroupEnchant == false then
    return
  end
  if Panel_Window_StackExtraction_All:GetShow() == false then
    return
  end
  local self = PaGlobal_PartyEnchant
  self:updateAutoBubbleText(deltaTime)
end
function PaGlobal_PartyEnchant:updateAutoBubbleText(deltaTime)
  local memberCount = RequestParty_getPartyMemberCount()
  for index = 0, memberCount - 1 do
    local enchantViewData = self._enchantViewDataList[index]
    if nil == enchantViewData then
      return
    end
    if true == enchantViewData._isShowBubbleText then
      enchantViewData._bubbleTextDeltaTime = enchantViewData._bubbleTextDeltaTime + deltaTime
      if self._bubbleTextShowTime < enchantViewData._bubbleTextDeltaTime then
        self:SetShowBubbleText(enchantViewData, false)
        enchantViewData._isShowBubbleText = false
        enchantViewData._bubbleTextDeltaTime = 0
      end
    end
  end
end
