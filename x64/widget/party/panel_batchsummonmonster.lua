PaGlobal_BatchSummonMonster = {
  _ui = {
    stc_bg = nil,
    stc_OnBg = nil,
    stc_Ready_Lazer_1 = nil,
    stc_Ready_Lazer_2 = nil,
    stc_Ready_Lazer_3 = nil,
    stc_Ready_Lazer_4 = nil,
    stc_Ready_Lazer_5 = nil,
    stc_MySlot = nil,
    stc_MySlotItemSlot = nil,
    stc_MySlotCrown = nil,
    stc_MySlotName = nil,
    stc_LeaderOrNormalSlot = nil,
    stc_LeaderOrNormalSlotItemSlot = nil,
    stc_LeaderOrNormalSlotCrown = nil,
    stc_LeaderOrNormalSlotName = nil,
    stc_NormalSlot_1 = nil,
    stc_NormalSlotItemSlot_1 = nil,
    stc_NormalSlotName_1 = nil,
    stc_NormalSlot_2 = nil,
    stc_NormalSlotItemSlot_2 = nil,
    stc_NormalSlotName_2 = nil,
    stc_NormalSlot_3 = nil,
    stc_NormalSlotItemSlot_3 = nil,
    stc_NormalSlotName_3 = nil,
    txt_Level = nil,
    chk_Ready = nil,
    btn_Summon = nil,
    stc_KeyGuide_Bg = nil,
    stc_KeyGuide_A = nil,
    stc_KeyGuide_B = nil,
    stc_KeyGuide_X = nil,
    stc_KeyGuide_Y = nil,
    multi_desc = nil
  },
  _slotConfig = {
    createBorder = false,
    createCount = true,
    createCooltime = false,
    createCooltimeText = false,
    createCash = true,
    createEnchant = true,
    createQuickslotBagIcon = false,
    createOriginalForDuel = false
  },
  _userInfo = {},
  _openItemKey = 0,
  _possibleMaxUseItemCount = 0,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_BatchSummonMonster_Init")
function FromClient_BatchSummonMonster_Init()
  PaGlobal_BatchSummonMonster:initialize()
end
function PaGlobal_BatchSummonMonster:initialize()
  if true == PaGlobal_BatchSummonMonster._initialize or nil == Panel_BatchSummonMonster then
    return
  end
  self._ui.stc_bg = UI.getChildControl(Panel_BatchSummonMonster, "Static_Bg")
  self._ui.stc_OnBg = UI.getChildControl(self._ui.stc_bg, "Static_On")
  self._ui.stc_Ready_Lazer_1 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Ready_Lazer_01")
  self._ui.stc_Ready_Lazer_2 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Ready_Lazer_02")
  self._ui.stc_Ready_Lazer_3 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Ready_Lazer_03")
  self._ui.stc_Ready_Lazer_4 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Ready_Lazer_04")
  self._ui.stc_Ready_Lazer_5 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Ready_Lazer_05")
  self._ui.stc_MySlot = UI.getChildControl(Panel_BatchSummonMonster, "Static_My_Slot")
  local mySlot = UI.getChildControl(self._ui.stc_MySlot, "Static_Slot")
  self._ui.stc_MySlotCrown = UI.getChildControl(self._ui.stc_MySlot, "Static_Crown")
  self._ui.stc_MySlotName = UI.getChildControl(mySlot, "StaticText_Name")
  self._ui.stc_MySlotItemSlot = {}
  SlotItem.new(self._ui.stc_MySlotItemSlot, "Static_My_SlotItemSlot", nil, mySlot, self._slotConfig)
  self._ui.stc_MySlotItemSlot:createChild()
  self._ui.stc_MySlotItemSlot:clearItem()
  self._ui.stc_MySlotItemSlot.icon:SetHorizonCenter()
  self._ui.stc_MySlotItemSlot.icon:SetVerticalMiddle()
  self._ui.stc_LeaderOrNormalSlot = UI.getChildControl(Panel_BatchSummonMonster, "Static_Party_Slot_Leader")
  local leaderSlot = UI.getChildControl(self._ui.stc_LeaderOrNormalSlot, "Static_Slot")
  self._ui.stc_LeaderOrNormalSlotCrown = UI.getChildControl(self._ui.stc_LeaderOrNormalSlot, "Static_Crown")
  self._ui.stc_LeaderOrNormalSlotName = UI.getChildControl(leaderSlot, "StaticText_Name")
  self._ui.stc_LeaderOrNormalSlotItemSlot = {}
  SlotItem.new(self._ui.stc_LeaderOrNormalSlotItemSlot, "Static_My_SlotItemSlot", nil, leaderSlot, self._slotConfig)
  self._ui.stc_LeaderOrNormalSlotItemSlot:createChild()
  self._ui.stc_LeaderOrNormalSlotItemSlot:clearItem()
  self._ui.stc_LeaderOrNormalSlotItemSlot.icon:SetHorizonCenter()
  self._ui.stc_LeaderOrNormalSlotItemSlot.icon:SetVerticalMiddle()
  self._ui.stc_NormalSlot_1 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Party_Slot_01")
  local slot1 = UI.getChildControl(self._ui.stc_NormalSlot_1, "Static_Slot")
  self._ui.stc_NormalSlotName_1 = UI.getChildControl(slot1, "StaticText_Name")
  self._ui.stc_NormalSlotItemSlot_1 = {}
  SlotItem.new(self._ui.stc_NormalSlotItemSlot_1, "Static_My_SlotItemSlot", nil, slot1, self._slotConfig)
  self._ui.stc_NormalSlotItemSlot_1:createChild()
  self._ui.stc_NormalSlotItemSlot_1:clearItem()
  self._ui.stc_NormalSlotItemSlot_1.icon:SetHorizonCenter()
  self._ui.stc_NormalSlotItemSlot_1.icon:SetVerticalMiddle()
  self._ui.stc_NormalSlot_2 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Party_Slot_02")
  local slot2 = UI.getChildControl(self._ui.stc_NormalSlot_2, "Static_Slot")
  self._ui.stc_NormalSlotName_2 = UI.getChildControl(slot2, "StaticText_Name")
  self._ui.stc_NormalSlotItemSlot_2 = {}
  SlotItem.new(self._ui.stc_NormalSlotItemSlot_2, "Static_My_SlotItemSlot", nil, slot2, self._slotConfig)
  self._ui.stc_NormalSlotItemSlot_2:createChild()
  self._ui.stc_NormalSlotItemSlot_2:clearItem()
  self._ui.stc_NormalSlotItemSlot_2.icon:SetHorizonCenter()
  self._ui.stc_NormalSlotItemSlot_2.icon:SetVerticalMiddle()
  self._ui.stc_NormalSlot_3 = UI.getChildControl(Panel_BatchSummonMonster, "Static_Party_Slot_03")
  local slot3 = UI.getChildControl(self._ui.stc_NormalSlot_3, "Static_Slot")
  self._ui.stc_NormalSlotName_3 = UI.getChildControl(slot3, "StaticText_Name")
  self._ui.stc_NormalSlotItemSlot_3 = {}
  SlotItem.new(self._ui.stc_NormalSlotItemSlot_3, "Static_My_SlotItemSlot", nil, slot3, self._slotConfig)
  self._ui.stc_NormalSlotItemSlot_3:createChild()
  self._ui.stc_NormalSlotItemSlot_3:clearItem()
  self._ui.stc_NormalSlotItemSlot_3.icon:SetHorizonCenter()
  self._ui.stc_NormalSlotItemSlot_3.icon:SetVerticalMiddle()
  self._ui.txt_Level = UI.getChildControl(Panel_BatchSummonMonster, "StaticText_Level")
  self._ui.chk_Ready = UI.getChildControl(Panel_BatchSummonMonster, "CheckButton_Ready")
  self._ui.chk_Ready:SetShow(false)
  self._ui.btn_Summon = UI.getChildControl(Panel_BatchSummonMonster, "Button_Summon")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_BatchSummonMonster, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B")
  self._ui.stc_KeyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_X")
  self._ui.stc_KeyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y")
  self._ui.multi_desc = UI.getChildControl(Panel_BatchSummonMonster, "MultilineText_Desc")
  self._userInfo = Array.new()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_BatchSummonMonster:validate()
  PaGlobal_BatchSummonMonster:registEventHandler()
  PaGlobal_BatchSummonMonster:swichPlatform(self._isConsole)
  PaGlobal_BatchSummonMonster._initialize = true
end
function PaGlobal_BatchSummonMonster:registEventHandler()
  if nil == Panel_BatchSummonMonster then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_BatchSummonMonster_OnScreenResize")
  registerEvent("ResponseParty_withdraw", "FromClient_BatchSummonMonster_UpdateByPartyUpdate")
  registerEvent("ResponseParty_changeLeader", "FromClient_BatchSummonMonster_UpdateByPartyUpdate")
  registerEvent("ResponseParty_accept", "FromClient_BatchSummonMonster_UpdateByPartyUpdate")
  registerEvent("FromClient_BatchSummonMonsterKeySet", "FromClient_BatchSummonMonster_UpdateSummonCountJustOne")
  registerEvent("FromClient_BatchSummonMonsterListAck", "FromClient_BatchSummonMonster_RefreshSummonCountAll")
  registerEvent("FromClient_BatchSummonMonsterUIOpen", "PaGlobalFunc_BatchSummonMonster_Open")
  self._ui.stc_MySlotItemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_BatchSummonMonster_InventoryClick()")
end
function PaGlobal_BatchSummonMonster:swichPlatform(isConsole)
  self._ui.btn_Summon:SetShow(not isConsole)
  self._ui.stc_KeyGuide_Bg:SetShow(isConsole)
  if true == isConsole then
    PaGlobal_BatchSummonMonster:keyAlign()
    Panel_BatchSummonMonster:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_BatchSummonMonster_InventoryClick()")
  else
    self._ui.btn_Summon:addInputEvent("Mouse_LUp", "HandleClicked_BatchSummonMonster_Summon()")
  end
end
function PaGlobal_BatchSummonMonster:keyAlign()
  local temp = {
    self._ui.stc_KeyGuide_Y,
    self._ui.stc_KeyGuide_X,
    self._ui.stc_KeyGuide_A,
    self._ui.stc_KeyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(temp, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  self._ui.stc_KeyGuide_Bg:ComputePos()
end
function PaGlobal_BatchSummonMonster:prepareOpen(openItemKey)
  if nil == Panel_BatchSummonMonster then
    return
  end
  self._openItemKey = openItemKey
  PaGlobal_BatchSummonMonster._ui.txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_LEVEL", "level", 0))
  PaGlobal_BatchSummonMonster:open()
  PaGlobal_BatchSummonMonster:requestSummonDataList()
  PaGlobal_BatchSummonMonster:inventoryOpen()
  PaGlobalFunc_BatchSummonMonster_OnScreenResize()
  if true == self._isConsole then
    Panel_Npc_Dialog_All:SetIgnore(true)
    Panel_Npc_Dialog_All:SetIgnoreChild(true)
    PaGlobalFunc_DialogMain_All_ShowToggle(true)
  end
end
function PaGlobal_BatchSummonMonster:inventoryOpen()
  if false == self._isConsole then
    Inventory_SetFunctor(PaGlobalFunc_BatchSummonMonster_InventoryFilterFunction, HandleEventRUp_BatchSummonMonster_InventoryClick, nil, nil)
    if true == _ContentsGroup_NewUI_Inventory_All then
      PaGlobalFunc_Inventory_All_SetInventoryDragNoUse(Panel_Window_Alchemy_All)
    else
      FGlobal_SetInventoryDragNoUse(Panel_Window_Alchemy_All)
    end
    InventoryWindow_Show()
  else
  end
end
function PaGlobal_BatchSummonMonster:findItemWrapperWithCount(targetCount)
  local inventory = getSelfPlayer():get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
  if nil == inventory then
    return false
  end
  local invenMaxSize = inventory:sizeXXX()
  local currentCount = 0
  for ii = 0, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, ii)
    if nil ~= itemWrapper then
      local itemKey = itemWrapper:get():getKey():getItemKey()
      local enchantLevel = itemWrapper:get():getKey():getEnchantLevel()
      if itemKey == PaGlobal_BatchSummonMonster._openItemKey then
        currentCount = currentCount + 1
      end
    end
  end
  if targetCount <= currentCount then
    return true
  end
  return false
end
function PaGlobal_BatchSummonMonster:requestSummonDataList()
  self._userInfo = Array.new()
  ToClient_RequestAllUserBatchSummonItemCount()
end
function PaGlobal_BatchSummonMonster:update()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local userNo = selfPlayer:get():getUserNo()
  local hasParty = selfPlayer:get():hasParty()
  local isPartyEmpty = ToClient_IsPartyEmpty()
  local selfIsPartyLeader = RequestParty_isLeader()
  local isSummonAble = true == isPartyEmpty or true == selfIsPartyLeader
  self._ui.btn_Summon:SetMonoTone(not isSummonAble, not isSummonAble)
  self._ui.btn_Summon:SetIgnore(not isSummonAble)
  PaGlobal_BatchSummonMonster:clearAllSlot()
  if true == self._isConsole and true == selfIsPartyLeader then
    self._ui.stc_KeyGuide_X:SetShow(true)
    Panel_BatchSummonMonster:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleClicked_BatchSummonMonster_Summon()")
    PaGlobal_BatchSummonMonster:keyAlign()
  end
  local startSlotIndex = 3
  if true == selfIsPartyLeader then
    startSlotIndex = 2
  end
  local infoSize = #self._userInfo
  for idx = 1, infoSize do
    if nil ~= self._userInfo[idx] then
      if true == isPartyEmpty then
        PaGlobal_BatchSummonMonster:setInfo(self._userInfo[idx], 1)
      else
        local isLeader = self._userInfo[idx]._isLeader
        if true == isLeader then
          if true == selfIsPartyLeader then
            PaGlobal_BatchSummonMonster:setInfo(self._userInfo[idx], 1)
          else
            PaGlobal_BatchSummonMonster:setInfo(self._userInfo[idx], 2)
          end
        elseif userNo == self._userInfo[idx]._userNo64 then
          PaGlobal_BatchSummonMonster:setInfo(self._userInfo[idx], 1)
        else
          PaGlobal_BatchSummonMonster:setInfo(self._userInfo[idx], startSlotIndex)
          startSlotIndex = startSlotIndex + 1
        end
      end
    end
  end
  PaGlobal_BatchSummonMonster:addEffectBySummonItemSet()
end
function PaGlobal_BatchSummonMonster:clearAllSlot()
  self._ui.stc_MySlotItemSlot:clearItem()
  self._ui.stc_LeaderOrNormalSlotItemSlot:clearItem()
  self._ui.stc_NormalSlotItemSlot_1:clearItem()
  self._ui.stc_NormalSlotItemSlot_2:clearItem()
  self._ui.stc_NormalSlotItemSlot_3:clearItem()
  self._ui.stc_MySlotName:SetText("")
  self._ui.stc_LeaderOrNormalSlotName:SetText("")
  self._ui.stc_NormalSlotName_1:SetText("")
  self._ui.stc_NormalSlotName_2:SetText("")
  self._ui.stc_NormalSlotName_3:SetText("")
  self._ui.stc_LeaderOrNormalSlotCrown:SetShow(false)
  self._ui.stc_MySlotCrown:SetShow(false)
  self._ui.stc_Ready_Lazer_1:SetShow(false)
  self._ui.stc_Ready_Lazer_2:SetShow(false)
  self._ui.stc_Ready_Lazer_3:SetShow(false)
  self._ui.stc_Ready_Lazer_4:SetShow(false)
  self._ui.stc_Ready_Lazer_5:SetShow(false)
  self._ui.stc_OnBg:SetShow(false)
  Panel_BatchSummonMonster:EraseAllEffect()
  self._ui.stc_Ready_Lazer_1:EraseAllEffect()
  self._ui.stc_Ready_Lazer_2:EraseAllEffect()
  self._ui.stc_Ready_Lazer_3:EraseAllEffect()
  self._ui.stc_Ready_Lazer_4:EraseAllEffect()
  self._ui.stc_Ready_Lazer_5:EraseAllEffect()
  self._ui.stc_NormalSlot_1:EraseAllEffect()
  self._ui.stc_NormalSlot_2:EraseAllEffect()
  self._ui.stc_NormalSlot_3:EraseAllEffect()
  self._ui.stc_LeaderOrNormalSlot:EraseAllEffect()
  self._ui.stc_MySlot:EraseAllEffect()
  if true == self._isConsole then
    self._ui.stc_KeyGuide_X:SetShow(false)
    Panel_BatchSummonMonster:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  end
end
function PaGlobal_BatchSummonMonster:setInfo(userInfo, index)
  if nil == userInfo or nil == index then
    return
  end
  local isItemKeyDefines = true
  local itemEnchantKey = ItemEnchantKey(userInfo._summonKey, 0)
  if nil == itemEnchantKey then
    isItemKeyDefines = false
  end
  if false == itemEnchantKey:isDefined() then
    isItemKeyDefines = false
  end
  local summonItemCount = userInfo._summonLevel
  local userNo64 = userInfo._userNo64
  local isLeader = userInfo._isLeader
  local name = userInfo._userName
  local itemWrapper = getItemEnchantStaticStatus(itemEnchantKey)
  if nil == itemWrapper then
    isItemKeyDefines = false
  end
  local iconGap = 20
  if 1 == index then
    if true == isItemKeyDefines then
      self._ui.stc_MySlotItemSlot:setItemByStaticStatus(itemWrapper, summonItemCount)
      self._ui.stc_Ready_Lazer_1:SetShow(true)
      self._ui.stc_Ready_Lazer_1:AddEffect("fUI_Box_Light_02A", true, 0, 0)
      self._ui.stc_MySlot:EraseAllEffect()
    else
      self._ui.stc_MySlot:AddEffect("fUI_Box_Light_01A", true, 0, 0)
    end
    self._ui.stc_MySlotName:SetText(name)
    self._ui.stc_MySlotName:SetSize(self._ui.stc_MySlotName:GetTextSizeX(), self._ui.stc_MySlotName:GetSizeY())
    self._ui.stc_MySlotName:ComputePos()
    self._ui.stc_MySlotCrown:SetShow(isLeader)
    self._ui.stc_MySlotCrown:SetPosX(self._ui.stc_MySlotName:GetPosX() - iconGap)
  elseif 2 == index then
    if true == isItemKeyDefines then
      self._ui.stc_LeaderOrNormalSlotItemSlot:setItemByStaticStatus(itemWrapper, summonItemCount)
      self._ui.stc_Ready_Lazer_2:SetShow(true)
      self._ui.stc_Ready_Lazer_2:AddEffect("fUI_Box_Light_02B", true, 0, 0)
      self._ui.stc_LeaderOrNormalSlot:EraseAllEffect()
    else
      self._ui.stc_LeaderOrNormalSlot:AddEffect("fUI_Box_Light_01A", true, 0, 0)
    end
    self._ui.stc_LeaderOrNormalSlotName:SetText(name)
    self._ui.stc_LeaderOrNormalSlotName:SetSize(self._ui.stc_LeaderOrNormalSlotName:GetTextSizeX(), self._ui.stc_LeaderOrNormalSlotCrown:GetSizeY())
    self._ui.stc_LeaderOrNormalSlotName:ComputePos()
    self._ui.stc_LeaderOrNormalSlotCrown:SetShow(isLeader)
    self._ui.stc_LeaderOrNormalSlotCrown:SetPosX(self._ui.stc_LeaderOrNormalSlotName:GetPosX() - iconGap)
  elseif 3 == index then
    if true == isItemKeyDefines then
      self._ui.stc_NormalSlotItemSlot_1:setItemByStaticStatus(itemWrapper, summonItemCount)
      self._ui.stc_Ready_Lazer_3:SetShow(true)
      self._ui.stc_Ready_Lazer_3:AddEffect("fUI_Box_Light_02C", true, 0, 0)
      self._ui.stc_NormalSlot_1:EraseAllEffect()
    else
      self._ui.stc_NormalSlot_1:AddEffect("fUI_Box_Light_01A", true, 0, 0)
    end
    self._ui.stc_NormalSlotName_1:SetText(name)
  elseif 4 == index then
    if true == isItemKeyDefines then
      self._ui.stc_NormalSlotItemSlot_2:setItemByStaticStatus(itemWrapper, summonItemCount)
      self._ui.stc_Ready_Lazer_4:SetShow(true)
      self._ui.stc_Ready_Lazer_4:AddEffect("fUI_Box_Light_02D", true, 0, 0)
      self._ui.stc_NormalSlot_2:EraseAllEffect()
    else
      self._ui.stc_NormalSlot_2:AddEffect("fUI_Box_Light_01A", true, 0, 0)
    end
    self._ui.stc_NormalSlotName_2:SetText(name)
  elseif 5 == index then
    if true == isItemKeyDefines then
      self._ui.stc_NormalSlotItemSlot_3:setItemByStaticStatus(itemWrapper, summonItemCount)
      self._ui.stc_Ready_Lazer_5:SetShow(true)
      self._ui.stc_Ready_Lazer_5:AddEffect("fUI_Box_Light_02E", true, 0, 0)
      self._ui.stc_NormalSlot_3:EraseAllEffect()
    else
      self._ui.stc_NormalSlot_3:AddEffect("fUI_Box_Light_01A", true, 0, 0)
    end
    self._ui.stc_NormalSlotName_3:SetText(name)
  end
end
function PaGlobal_BatchSummonMonster:addEffectBySummonItemSet()
  local selfIsPartyLeader = RequestParty_isLeader()
  local isPartyEmpty = ToClient_IsPartyEmpty()
  local partyMemberCount = RequestParty_getPartyMemberCount()
  self._ui.stc_OnBg:EraseAllEffect()
  self._ui.btn_Summon:EraseAllEffect()
  if true == isPartyEmpty then
    local isSelfSummonItemSet = false
    for idx = 1, #PaGlobal_BatchSummonMonster._userInfo do
      if nil ~= PaGlobal_BatchSummonMonster._userInfo[idx] then
        isSelfSummonItemSet = 0 < PaGlobal_BatchSummonMonster._userInfo[idx]._summonLevel
        break
      end
    end
    if false == isSelfSummonItemSet then
      self._ui.stc_MySlot:AddEffect("fUI_Box_Light_01A", true, 0, 0)
    else
      self._ui.stc_OnBg:SetShow(true)
      self._ui.stc_OnBg:AddEffect("fUI_Box_Light_04A", true, 0, 0)
      self._ui.btn_Summon:AddEffect("fUI_Box_Light_03A", true, 0, 0)
    end
  else
    local isPartyLeaderSetItem = false
    local partyLeaderItemCount = 0
    for idx = 1, #PaGlobal_BatchSummonMonster._userInfo do
      if nil ~= PaGlobal_BatchSummonMonster._userInfo[idx] and true == PaGlobal_BatchSummonMonster._userInfo[idx]._isLeader then
        isPartyLeaderSetItem = 0 < PaGlobal_BatchSummonMonster._userInfo[idx]._summonLevel
        partyLeaderItemCount = PaGlobal_BatchSummonMonster._userInfo[idx]._summonLevel
      end
    end
    if false == isPartyLeaderSetItem then
      self._ui.stc_NormalSlot_1:EraseAllEffect()
      self._ui.stc_NormalSlot_2:EraseAllEffect()
      self._ui.stc_NormalSlot_3:EraseAllEffect()
      if true == selfIsPartyLeader then
        self._ui.stc_LeaderOrNormalSlot:EraseAllEffect()
      else
        self._ui.stc_MySlot:EraseAllEffect()
      end
    elseif partyLeaderItemCount > 0 and partyMemberCount == #PaGlobal_BatchSummonMonster._userInfo then
      local allPartyItemCount = 0
      for idx = 1, #PaGlobal_BatchSummonMonster._userInfo do
        if nil ~= PaGlobal_BatchSummonMonster._userInfo[idx] then
          allPartyItemCount = allPartyItemCount + PaGlobal_BatchSummonMonster._userInfo[idx]._summonLevel
        end
      end
      if allPartyItemCount == partyLeaderItemCount * partyMemberCount then
        self._ui.stc_OnBg:SetShow(true)
        self._ui.stc_OnBg:AddEffect("fUI_Box_Light_04A", true, 0, 0)
        if true == selfIsPartyLeader then
          self._ui.btn_Summon:AddEffect("fUI_Box_Light_03A", true, 0, 0)
        end
      end
    end
  end
end
function PaGlobal_BatchSummonMonster:open()
  if nil == Panel_BatchSummonMonster then
    return
  end
  Panel_BatchSummonMonster:SetShow(true)
end
function PaGlobal_BatchSummonMonster:prepareClose()
  if nil == Panel_BatchSummonMonster then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  InventoryWindow_Close()
  if true == self._isConsole then
    Panel_Npc_Dialog_All:SetIgnore(false)
    Panel_Npc_Dialog_All:SetIgnoreChild(false)
  end
  PaGlobal_BatchSummonMonster:close()
end
function PaGlobal_BatchSummonMonster:close()
  if nil == Panel_BatchSummonMonster then
    return
  end
  Panel_BatchSummonMonster:SetShow(false)
end
function PaGlobal_BatchSummonMonster:addInfo(userNo64, summonKey, summonLevel, isLeader)
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  local selfUserNo = selfPlayer:get():getUserNo()
  local tempTable = {
    _summonKey = summonKey,
    _summonLevel = summonLevel,
    _userNo64 = userNo64,
    _isLeader = isLeader,
    _userName = ""
  }
  local isPartyEmpty = ToClient_IsPartyEmpty()
  if false == isPartyEmpty then
    local partyMemberCount = RequestParty_getPartyMemberCount()
    for index = 0, partyMemberCount - 1 do
      local memberData = RequestParty_getPartyMemberAt(index)
      if nil ~= memberData then
        local partyMemberUserNo = memberData:getUserNo()
        if partyMemberUserNo == tempTable._userNo64 then
          tempTable._userName = memberData:name()
        end
      end
    end
  elseif selfUserNo == tempTable._userNo64 then
    tempTable._userName = selfPlayer:getOriginalName()
  end
  local hasInfo = false
  local foundIndex = -1
  local infoSize = #self._userInfo
  for idx = 1, infoSize do
    if nil ~= self._userInfo[idx] and self._userInfo[idx]._userNo64 == userNo64 then
      hasInfo = true
      foundIndex = idx
    end
  end
  if true == hasInfo and -1 ~= foundIndex then
    self._userInfo[foundIndex] = tempTable
  else
    self._userInfo:push_back(tempTable)
  end
end
function PaGlobalFunc_BatchSummonMonster_Open(openItemKey, maxPossibleItem)
  if maxPossibleItem > 0 then
    PaGlobal_BatchSummonMonster._possibleMaxUseItemCount = maxPossibleItem
  end
  PaGlobal_BatchSummonMonster:prepareOpen(openItemKey)
end
function PaGlobalFunc_BatchSummonMonster_OnScreenResize()
  if nil == Panel_BatchSummonMonster or false == Panel_BatchSummonMonster:GetShow() then
    return
  end
  Panel_BatchSummonMonster:ComputePos()
end
function PaGlobalFunc_BatchSummonMonster_Close()
  PaGlobal_BatchSummonMonster:prepareClose()
  ToClient_SetBatchSummonItemWithCount(PaGlobal_BatchSummonMonster._openItemKey, 0)
end
function HandleEventRUp_BatchSummonMonster_InventoryClick(notUse, notUse)
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    return
  end
  local summonKey = 0
  local summonLevel = 0
  local possibleMaxSetCount64 = toInt64(0, PaGlobal_BatchSummonMonster._possibleMaxUseItemCount)
  if false == ToClient_IsPartyEmpty() and false == RequestParty_isLeader() then
    for idx = 1, #PaGlobal_BatchSummonMonster._userInfo do
      if true == PaGlobal_BatchSummonMonster._userInfo[idx]._isLeader then
        summonKey = PaGlobal_BatchSummonMonster._userInfo[idx]._summonKey
        summonLevel = PaGlobal_BatchSummonMonster._userInfo[idx]._summonLevel
        if summonKey <= 0 or summonLevel <= 0 then
          Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_PARTY_LEADER"))
          return
        end
        if summonLevel > 0 then
          possibleMaxSetCount64 = toInt64(0, summonLevel)
        end
      end
    end
  end
  Panel_NumberPad_Show_MaxCount(true, possibleMaxSetCount64, nil, HandleEventRUp_BatchSummonMonster_NumberPadComfirm, nil, false)
end
function HandleEventRUp_BatchSummonMonster_NumberPadComfirm(count64, notUse)
  local count32 = Int64toInt32(count64)
  if count32 <= 0 then
    return
  end
  local hasItemEnough = PaGlobal_BatchSummonMonster:findItemWrapperWithCount(count32)
  if false == hasItemEnough then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_NOT_ENOUGH"))
    return
  end
  if nil == Panel_BatchSummonMonster or false == Panel_BatchSummonMonster:GetShow() then
    return
  end
  if nil == PaGlobal_BatchSummonMonster._openItemKey then
    return
  end
  ToClient_SetBatchSummonItemWithCount(PaGlobal_BatchSummonMonster._openItemKey, count32)
end
function PaGlobalFunc_BatchSummonMonster_InventoryFilterFunction(slotNo, itemWrapper, whereType)
  if CppEnums.ItemWhereType.eInventory ~= whereType then
    return true
  end
  local isTradable = itemWrapper:getStaticStatus():isPersonalTrade()
  local isVested = itemWrapper:get():isVested()
  if isTradable and isVested then
    return true
  end
  if true == itemWrapper:get():isSeized() then
    return true
  end
  local isCash = itemWrapper:getStaticStatus():get():isCash()
  if isCash then
    return true
  end
  local itemExpiration = itemWrapper:getExpirationDate()
  if nil ~= itemExpiration and false == itemExpiration:isIndefinite() then
    local s64_remainTime = getLeftSecond_s64(itemExpiration)
    if Defines.s64_const.s64_0 == s64_remainTime then
      return true
    end
  end
  local itemKey = itemWrapper:get():getKey():getItemKey()
  if PaGlobal_BatchSummonMonster._openItemKey ~= itemKey then
    return true
  end
  return false
end
function FromClient_BatchSummonMonster_UpdateByPartyUpdate()
  if nil == Panel_BatchSummonMonster or false == Panel_BatchSummonMonster:GetShow() then
    return
  end
  local isPartyEmpty = ToClient_IsPartyEmpty()
  if true == isPartyEmpty then
    PaGlobal_BatchSummonMonster:prepareClose()
    return
  end
  PaGlobal_BatchSummonMonster:requestSummonDataList()
end
function FromClient_BatchSummonMonster_UpdateSummonCountJustOne(summonKey, summonLevel, userNo64, isPartyLeader, isSummonComplete)
  if nil == Panel_BatchSummonMonster or false == Panel_BatchSummonMonster:GetShow() then
    return
  end
  if true == isSummonComplete then
    PaGlobal_BatchSummonMonster:prepareClose()
    PaGlobalFunc_DialogList_All_Close(true)
    PaGlobalFunc_DialogMain_All_Close(false, false, true)
    return
  end
  local isPartyEmpty = ToClient_IsPartyEmpty()
  if true == isPartyEmpty then
    PaGlobal_BatchSummonMonster._ui.txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_LEVEL", "level", summonLevel))
  elseif true == isPartyLeader then
    PaGlobal_BatchSummonMonster._ui.txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_LEVEL", "level", summonLevel))
  end
  PaGlobal_BatchSummonMonster:addInfo(userNo64, summonKey, summonLevel, isPartyLeader)
  PaGlobal_BatchSummonMonster:update()
end
function FromClient_BatchSummonMonster_RefreshSummonCountAll(userNo64, summonKey, summonLevel, isPartyLeader, totalListCount, ackIndex, possibleMaxUseItemCount)
  if nil == Panel_BatchSummonMonster or false == Panel_BatchSummonMonster:GetShow() then
    return
  end
  PaGlobal_BatchSummonMonster:addInfo(userNo64, summonKey, summonLevel, isPartyLeader)
  if possibleMaxUseItemCount > 0 then
    PaGlobal_BatchSummonMonster._possibleMaxUseItemCount = possibleMaxUseItemCount
  end
  local isPartyEmpty = ToClient_IsPartyEmpty()
  if true == isPartyEmpty then
    PaGlobal_BatchSummonMonster._ui.txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_LEVEL", "level", summonLevel))
  elseif true == isPartyLeader then
    PaGlobal_BatchSummonMonster._ui.txt_Level:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_LEVEL", "level", summonLevel))
  end
  if totalListCount == ackIndex then
    PaGlobal_BatchSummonMonster:update()
  end
end
function HandleClicked_BatchSummonMonster_Summon()
  if nil == Panel_BatchSummonMonster or false == Panel_BatchSummonMonster:GetShow() then
    return
  end
  if false == IsSelfPlayerWaitAction() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ALERTAREA_NOTUSEALERT"))
    return
  end
  if false == ToClient_IsPartyEmpty() and false == RequestParty_isLeader() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ANCIENT_RUINS_RAID_PARTY_ONLY_LEADER"))
    return
  end
  local summonKey, summonLevel
  for idx = 1, #PaGlobal_BatchSummonMonster._userInfo do
    if nil ~= PaGlobal_BatchSummonMonster._userInfo[idx] and (true == PaGlobal_BatchSummonMonster._userInfo[idx]._isLeader or true == ToClient_IsPartyEmpty()) then
      summonKey = PaGlobal_BatchSummonMonster._userInfo[idx]._summonKey
      summonLevel = PaGlobal_BatchSummonMonster._userInfo[idx]._summonLevel
    end
  end
  if nil ~= summonKey and nil ~= summonLevel then
    ToClient_RequestBatchSummonMonster(summonKey, summonLevel)
  end
end
function PaGlobal_BatchSummonMonster:validate()
  if nil == Panel_BatchSummonMonster then
    return
  end
  self._ui.stc_bg:isValidate()
  self._ui.stc_OnBg:isValidate()
  self._ui.stc_Ready_Lazer_1:isValidate()
  self._ui.stc_Ready_Lazer_2:isValidate()
  self._ui.stc_Ready_Lazer_3:isValidate()
  self._ui.stc_Ready_Lazer_4:isValidate()
  self._ui.stc_Ready_Lazer_5:isValidate()
  self._ui.stc_MySlot:isValidate()
  self._ui.stc_MySlotCrown:isValidate()
  self._ui.stc_MySlotName:isValidate()
  self._ui.stc_LeaderOrNormalSlot:isValidate()
  self._ui.stc_LeaderOrNormalSlotCrown:isValidate()
  self._ui.stc_LeaderOrNormalSlotName:isValidate()
  self._ui.stc_NormalSlot_1:isValidate()
  self._ui.stc_NormalSlotName_1:isValidate()
  self._ui.stc_NormalSlot_2:isValidate()
  self._ui.stc_NormalSlotName_2:isValidate()
  self._ui.stc_NormalSlot_3:isValidate()
  self._ui.stc_NormalSlotName_3:isValidate()
  self._ui.txt_Level:isValidate()
  self._ui.chk_Ready:isValidate()
  self._ui.btn_Summon:isValidate()
  self._ui.stc_KeyGuide_Bg:isValidate()
  self._ui.stc_KeyGuide_A:isValidate()
  self._ui.stc_KeyGuide_B:isValidate()
  self._ui.stc_KeyGuide_X:isValidate()
  self._ui.stc_KeyGuide_Y:isValidate()
  self._ui.multi_desc:isValidate()
end
