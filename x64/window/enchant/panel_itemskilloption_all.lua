PaGlobal_ItemSkillOption_All = {
  _ui = {
    _stc_titleBar = nil,
    _btn_Close = nil,
    _stc_LeftBg = nil,
    _txt_ItemSkillOptionDesc = nil,
    _stc_targetItemSlotBg = nil,
    _stc_materialSlotBg = nil,
    _txt_ResultText = nil,
    _stc_activeEffect = nil,
    _stc_TargetItemListBg = nil,
    _list2_TargetItem = nil,
    _txt_NoTargetItem = nil,
    _stc_MatItemListBg = nil,
    _list2_MatItem = nil,
    _chk_skipAni = nil,
    _btn_DoEnchant = nil,
    _keyGuide_DoEnchant_Y = nil,
    _stc_ConsoleKeyGuide = nil,
    keyguide_Select_A = nil,
    keyguide_Cancel_B = nil,
    keyguide_Detail_X = nil
  },
  _appliedSkillOptionCtrlList = nil,
  _materialItemCount = 0,
  _defaultMaterialItemKey = {},
  _targetItemSlot = {},
  _materialSlot = {},
  _equipListCount = -1,
  _equipList = {},
  _indexInvenEnd = -1,
  _materialListCount = -1,
  _materialList = {},
  _itemCount = {},
  _materialListItemCount = {},
  _slotCount = 0,
  _equipSlotNo = -1,
  _materialSlotNo = -1,
  _toApplySkillOptionIndex = -1,
  _doImprove = false,
  _doAnimation = false,
  _animationTime = 0,
  _animationPlayTime = 6,
  _slotConfig = {
    createIcon = true,
    createBorder = true,
    createCount = false,
    createEnchant = true,
    createCash = false,
    createOriginalForDuel = true
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Enchant/Panel_ItemSkillOption_All_1.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_ItemSkillOption_All_Init")
function FromClient_ItemSkillOption_All_Init()
  PaGlobal_ItemSkillOption_All:initialize()
end
function PaGlobal_ItemSkillOption_All:initialize()
  if PaGlobal_ItemSkillOption_All._initialize == true then
    return
  end
  local stc_tabBg = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_MainTabTypeBg")
  self._ui.rdo_tabImprove = UI.getChildControl(stc_tabBg, "Radiobutton_Improvement")
  self._ui.rdo_tabGoonWang = UI.getChildControl(stc_tabBg, "Radiobutton_Goonwang")
  local tablSelectBar = UI.getChildControl(stc_tabBg, "Static_SelectBar")
  self._ui.rdo_tabGoonWang:SetIgnore(true)
  tablSelectBar:SetSpanSize(self._ui.rdo_tabGoonWang:GetSpanSize().x, self._ui.rdo_tabGoonWang:GetSpanSize().y)
  self._ui._stc_titleBar = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_TitleBar")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_titleBar, "Static_CloseIcon")
  self._ui._stc_LeftBg = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_GuideNSlot")
  self._ui._txt_ItemSkillOptionDesc = UI.getChildControl(self._ui._stc_LeftBg, "StaticText_Text")
  self._ui._txt_ItemSkillOptionDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_ItemSkillOptionDesc:SetText(self._ui._txt_ItemSkillOptionDesc:GetText())
  self._ui._stc_improvementSlotBg = UI.getChildControl(self._ui._stc_LeftBg, "Static_ImprovementSlot")
  self._ui._stc_targetItemSlotBg = UI.getChildControl(self._ui._stc_improvementSlotBg, "Static_Slot2")
  SlotItem.new(self._targetItemSlot, "ItemSkillOption_TargetItemSlot", 0, self._ui._stc_targetItemSlotBg, self._slotConfig)
  self._targetItemSlot:createChild()
  self._targetItemSlot.icon:SetPosX(-1)
  self._targetItemSlot.icon:SetPosY(-1)
  self._ui._stc_materialSlotBg = UI.getChildControl(self._ui._stc_improvementSlotBg, "Static_Slot1")
  SlotItem.new(self._materialSlot, "ItemSkillOption_materialSlot", 0, self._ui._stc_materialSlotBg, self._slotConfig)
  self._materialSlot:createChild()
  self._materialSlot.icon:SetPosX(-1)
  self._materialSlot.icon:SetPosY(-1)
  self._ui._txt_ResultText = UI.getChildControl(self._ui._stc_improvementSlotBg, "StaticText_Result")
  self._ui._txt_ResultText:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_activeEffect = UI.getChildControl(self._ui._stc_LeftBg, "Static_ActiveEffect")
  ToClient_padSnapIgnoreMoveToThisControl(self._ui._stc_activeEffect, true)
  self._appliedSkillOptionCtrlList = Array.new()
  for idx = 1, 5 do
    local temp = {
      _bg = nil,
      _txt = nil,
      _rdoBtn = nil,
      _skillNo = nil,
      _skillLv = nil
    }
    local bg = UI.getChildControl(self._ui._stc_activeEffect, "StaticText_ActiveEffect_" .. tostring(idx))
    temp._bg = bg
    temp._txt = UI.getChildControl(bg, "StaticText_ActiveEffect_" .. tostring(idx))
    temp._rdoBtn = UI.getChildControl(bg, "RadioButton_Select")
    self._appliedSkillOptionCtrlList:push_back(temp)
  end
  self._ui._stc_TargetItemListBg = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_ItemList")
  self._ui._list2_TargetItem = UI.getChildControl(self._ui._stc_TargetItemListBg, "List2_ItemList")
  local list2_TargetItemContent = UI.getChildControl(self._ui._list2_TargetItem, "List2_1_Content")
  local rdo_TargetItem = UI.getChildControl(list2_TargetItemContent, "RadioButton_EquipList")
  local stc_TargetItemSlot = UI.getChildControl(rdo_TargetItem, "Static_EquipListSlot")
  local itemSlot = {}
  SlotItem.new(itemSlot, "ItemSkillOption_TargetItemSlot_", 0, stc_TargetItemSlot, self._slotConfig)
  itemSlot:createChild()
  itemSlot.empty = true
  itemSlot:clearItem()
  itemSlot.icon:SetPosX(1)
  itemSlot.icon:SetPosY(1)
  itemSlot.border:SetSize(44, 44)
  self._ui._txt_NoTargetItem = UI.getChildControl(self._ui._stc_TargetItemListBg, "StaticText_NoItemDesc")
  self._ui._txt_NoTargetItem:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_NoTargetItem:SetText(self._ui._txt_NoTargetItem:GetText())
  self._ui._stc_MatItemListBg = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_EnchantItemList")
  self._ui._list2_MatItem = UI.getChildControl(self._ui._stc_MatItemListBg, "List2_1")
  local list2_MatItemContent = UI.getChildControl(self._ui._list2_MatItem, "List2_1_Content")
  local rdo_MatItem = UI.getChildControl(list2_MatItemContent, "RadioButton_EnchantItemList")
  local stc_MatItemSlot = UI.getChildControl(rdo_MatItem, "Static_EnchantItemSlot")
  local m_itemSlot = {}
  SlotItem.new(m_itemSlot, "ItemSkillOption_MaterialSlot_", 0, stc_MatItemSlot, self._slotConfig)
  m_itemSlot:createChild()
  m_itemSlot.empty = true
  m_itemSlot:clearItem()
  m_itemSlot.icon:SetPosX(1)
  m_itemSlot.icon:SetPosY(1)
  m_itemSlot.border:SetSize(44, 44)
  local stc_button = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_Button")
  self._ui._chk_skipAni = UI.getChildControl(stc_button, "CheckButton_CheckButton")
  self._ui._btn_DoEnchant = UI.getChildControl(stc_button, "Button_EnchantButton")
  self._ui._keyGuide_DoEnchant_Y = UI.getChildControl(stc_button, "StaticText_EnchantButton_C")
  self._ui._stc_ConsoleKeyGuide = UI.getChildControl(Panel_Window_ItemSkillOption_All, "Static_ConsoleKeyGuide")
  self._ui.keyguide_Select_A = UI.getChildControl(self._ui._stc_ConsoleKeyGuide, "StaticText_SelectButton_C")
  self._ui.keyguide_Cancel_B = UI.getChildControl(self._ui._stc_ConsoleKeyGuide, "StaticText_CancelButton_C")
  self._ui.keyguide_Detail_X = UI.getChildControl(self._ui._stc_ConsoleKeyGuide, "StaticText_DetailButton_C")
  self._defaultMaterialItemKey = Array.new()
  for itemKey = 820953, 820967 do
    local temp = {_itemKey = itemKey, _count = 0}
    local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemKey))
    if itemSSW ~= nil then
      self._defaultMaterialItemKey:push_back(temp)
    end
  end
  PaGlobal_ItemSkillOption_All:registEventHandler()
  PaGlobal_ItemSkillOption_All:switchPlatform()
  PaGlobal_ItemSkillOption_All:validate()
  PaGlobal_ItemSkillOption_All._initialize = true
end
function PaGlobal_ItemSkillOption_All:switchPlatform()
  self._ui._keyGuide_DoEnchant_Y:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui._stc_ConsoleKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui._btn_DoEnchant:SetShow(_ContentsGroup_UsePadSnapping == false)
end
function PaGlobal_ItemSkillOption_All:registEventHandler()
  registerEvent("FromClient_ResponseUpdateItemSkillOption", "FromClient_ResponseUpdateItemSkillOption")
  registerEvent("FromClient_InventoryUpdate", "FromClient_ItemSkillOption_All_UpdateItemList")
  registerEvent("EventEquipmentUpdate", "FromClient_ItemSkillOption_All_UpdateItemList")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Window_ItemSkillOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ItemSkillOption_All_DoImprove()")
    self._ui._stc_materialSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventRUp_ItemSkillOption_All_SlotInit()")
    Panel_Window_ItemSkillOption_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_Improvement_All_tabClick(0)")
  else
    self._ui.rdo_tabImprove:addInputEvent("Mouse_LUp", "PaGlobalFunc_Improvement_All_tabClick(0)")
    self._targetItemSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ItemSkillOption_All_SlotInit()")
    self._materialSlot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_ItemSkillOption_All_SlotInit()")
    self._ui._chk_skipAni:addInputEvent("Mouse_On", "HandleEventOnOut_ItemSkillOption_All_AniSkipToolTip(true)")
    self._ui._chk_skipAni:addInputEvent("Mouse_Out", "HandleEventOnOut_ItemSkillOption_All_AniSkipToolTip(false)")
    self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ItemSkillOption_All_Close()")
    self._ui._btn_DoEnchant:addInputEvent("Mouse_LUp", "HandleEventLUp_ItemSkillOption_All_DoImprove()")
  end
  self._ui._list2_TargetItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ItemSkillOption_All_UpdateList2TargetItem")
  self._ui._list2_TargetItem:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_MatItem:registEvent(__ePAUIList2EventType_LuaChangeContent, "FromClient_ItemSkillOption_All_UpdateList2MatItem")
  self._ui._list2_MatItem:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_ItemSkillOption_All:clearAllLeftItemSlot()
  self._targetItemSlot:clearItem()
  self._equipSlotNo = -1
  self._targetItemSlot.icon:addInputEvent("Mouse_On", "")
  self._targetItemSlot.icon:addInputEvent("Mouse_Out", "")
  self._ui._stc_targetItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._stc_targetItemSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  self._materialSlot:clearItem()
  self._materialSlotNo = -1
  self._materialSlot.icon:addInputEvent("Mouse_On", "")
  self._materialSlot.icon:addInputEvent("Mouse_Out", "")
  self._ui._stc_materialSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
  self._ui._stc_materialSlotBg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
  PaGlobal_ItemSkillOption_All:clearAppliedItemSkill()
end
function PaGlobal_ItemSkillOption_All:filterTargetItem(slotNo, itemWrapper, whereType, isEquip)
  if nil == itemWrapper then
    return false
  end
  local isDuplicatedItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if true == isDuplicatedItem then
    return false
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return false
  end
  local itemSSW = itemWrapper:getStaticStatus():get()
  if itemSSW:getContentsEventType() ~= __eContentsType_ItemSkillOption then
    return false
  end
  return true
end
function PaGlobal_ItemSkillOption_All:filterMatItem(slotNo, itemWrapper, whereType)
  if nil == itemWrapper then
    return false
  end
  if true == ToClient_Inventory_CheckItemLock(slotNo, whereType) then
    return false
  end
  local itemSS = itemWrapper:getStaticStatus()
  local itemSSW = itemSS:get()
  if itemSSW:getContentsEventType() ~= __eContentsType_ItemSkillOptionMaterial then
    return false
  end
  local skillNo = itemSS:getContentsEventParam1()
  local skillLv = itemSS:getContentsEventParam2()
  if PaGlobal_ItemSkillOption_All._equipSlotNo ~= -1 then
    for idx = 1, #self._appliedSkillOptionCtrlList do
      if self._appliedSkillOptionCtrlList[idx]._skillNo ~= -1 and self._appliedSkillOptionCtrlList[idx]._skillNo == skillNo and skillLv <= self._appliedSkillOptionCtrlList[idx]._skillLv then
        return false
      end
    end
  end
  return true
end
function PaGlobal_ItemSkillOption_All:resize()
  if true == Panel_Npc_Dialog_All:GetShow() then
    Panel_Window_ItemSkillOption_All:SetPosY(Panel_Npc_Dialog_All:GetPosY() - Panel_Window_ItemSkillOption_All:GetSizeY() - 50)
  end
  Panel_Window_ItemSkillOption_All:SetSpanSize(0, -PaGlobalFunc_DialogMain_All_FunctionSizeY())
  Panel_Window_ItemSkillOption_All:ComputePosAllChild()
  if _ContentsGroup_UsePadSnapping == true then
    local tempBtnGroup = {
      self._ui.keyguide_Detail_X,
      self._ui.keyguide_Select_A,
      self._ui.keyguide_Cancel_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui._stc_ConsoleKeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_ItemSkillOption_All:prepareOpen()
  if _ContentsGroup_ReforgeStonePreset == true then
    return
  end
  self._ui.rdo_tabGoonWang:SetCheck(true)
  self._ui.rdo_tabImprove:SetCheck(false)
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  PaGlobal_ItemSkillOption_All:resize()
  PaGlobal_ItemSkillOption_All:open()
  Panel_Window_ItemSkillOption_All:RegisterUpdateFunc("FromClient_ItemSkillOptionAll_UpdatePerframe")
  PaGlobal_ItemSkillOption_All:clearAllLeftItemSlot()
  PaGlobal_ItemSkillOption_All:update()
end
function PaGlobal_ItemSkillOption_All:open()
  Panel_Window_ItemSkillOption_All:SetShow(true)
end
function PaGlobal_ItemSkillOption_All:prepareClose()
  if PaGlobal_ItemSkillOption_All._doImprove == true then
    HandleEventLUp_ItemSkillOption_All_DoImprove()
    PaGlobal_ItemSkillOption_All._targetItemSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._materialSlot.icon:EraseAllEffect()
    PaGlobal_ItemSkillOption_All._doImprove = false
  end
  Panel_Tooltip_Item_hideTooltip()
  if true == _ContentsGroup_RenewUI_Tooltip and true == PaGlobalFunc_TooltipInfo_GetShow() then
    PaGlobalFunc_TooltipInfo_Close()
  end
  Panel_Npc_Dialog_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  self._doImprove = false
  self._doAnimation = false
  ToClient_BlackspiritEnchantClose()
  Panel_Window_ItemSkillOption_All:ClearUpdateLuaFunc()
  PaGlobal_ItemSkillOption_All:close()
end
function PaGlobal_ItemSkillOption_All:close()
  Panel_Window_ItemSkillOption_All:SetShow(false)
end
function PaGlobal_ItemSkillOption_All:clearAppliedItemSkill()
  for idx = 1, #self._appliedSkillOptionCtrlList do
    self._appliedSkillOptionCtrlList[idx]._bg:SetShow(false)
    self._appliedSkillOptionCtrlList[idx]._txt:SetText("")
    self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetCheck(false)
    self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetMonoTone(true, true)
    self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetIgnore(true)
    self._appliedSkillOptionCtrlList[idx]._skillNo = -1
    self._appliedSkillOptionCtrlList[idx]._skillLv = -1
  end
  self._toApplySkillOptionIndex = -1
  self._ui._txt_ItemSkillOptionDesc:SetText("")
  ToClient_padSnapIgnoreMoveToThisControl(self._ui._stc_activeEffect, true)
end
function PaGlobal_ItemSkillOption_All:update()
  PaGlobal_ItemSkillOption_All:updateTargetItem()
end
function PaGlobal_ItemSkillOption_All:updateAppliedItemSkill()
  PaGlobal_ItemSkillOption_All:clearAppliedItemSkill()
  if PaGlobal_ItemSkillOption_All._equipSlotNo ~= -1 then
    local appliedSkillCount = 0
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, PaGlobal_ItemSkillOption_All._equipSlotNo)
    if nil ~= itemWrapper then
      appliedSkillCount = itemWrapper:getAppliedItemSkillOptionCount()
      for idx = 1, #self._appliedSkillOptionCtrlList do
        self._appliedSkillOptionCtrlList[idx]._bg:SetShow(true)
        self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetMonoTone(true, true)
        self._appliedSkillOptionCtrlList[idx]._txt:SetMonoTone(true, true)
        self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetIgnore(true)
        self._appliedSkillOptionCtrlList[idx]._rdoBtn:SetCheck(false)
        local skillWrapper = itemWrapper:getAppliedItemSkillOptionByIndex(idx - 1)
        if skillWrapper ~= nil then
          local buffCount = skillWrapper:getBuffCount()
          local buffText = ""
          for buffIdx = 0, skillWrapper:getBuffCount() - 1 do
            local buffName = skillWrapper:getBuffDescription(buffIdx)
            if buffName ~= "" then
              if buffText ~= "" then
                buffText = buffText .. " / " .. buffName
              else
                buffText = buffName
              end
            end
          end
          self._appliedSkillOptionCtrlList[idx]._txt:SetText(buffText)
          self._appliedSkillOptionCtrlList[idx]._txt:SetFontColor(Defines.Color.C_FFFFEDD4)
          UI.setLimitTextAndAddTooltip(self._appliedSkillOptionCtrlList[idx]._txt, self._appliedSkillOptionCtrlList[idx]._txt:GetText(), "")
          self._appliedSkillOptionCtrlList[idx]._skillNo = skillWrapper:getSkillNo()
          self._appliedSkillOptionCtrlList[idx]._skillLv = skillWrapper:getSkillLv()
        else
          self._appliedSkillOptionCtrlList[idx]._txt:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_ADDBUTTON"))
          self._appliedSkillOptionCtrlList[idx]._txt:SetFontColor(Defines.Color.C_FFF5BA3A)
          break
        end
      end
      if 5 == appliedSkillCount then
        self._ui._txt_ItemSkillOptionDesc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_DESC_1"))
      else
        self._ui._txt_ItemSkillOptionDesc:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_ENCHANTGOONWANG_DESC_2", "count", tostring(5 - appliedSkillCount)))
      end
    end
  end
end
function PaGlobal_ItemSkillOption_All:updateTargetItem()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  self._equipListCount = 0
  self._equipList = {}
  self._targetItemSlot:clearItem()
  self._toIndex = self._ui._list2_TargetItem:getCurrenttoIndex()
  self._ui._list2_TargetItem:getElementManager():clearKey()
  self._ui._list2_MatItem:getElementManager():clearKey()
  self._materialSlot:clearItem()
  self._indexInvenEnd = -1
  PaGlobal_ItemSkillOption_All:clearAppliedItemSkill()
  local slotNo = 0
  selfPlayer:sortInventorySlotNoNew(0, 2, 1)
  for invenIdx = 0, invenSize - 1 do
    slotNo = selfPlayer:getRealInventorySlotNoNew(__eItemWhereTypeInventory, invenIdx)
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
    if itemWrapper ~= nil and PaGlobal_ItemSkillOption_All:filterTargetItem(slotNo, itemWrapper, __eItemWhereTypeInventory) == true then
      self._equipListCount = self._equipListCount + 1
      self._equipList[self._equipListCount] = slotNo
      self._ui._list2_TargetItem:getElementManager():pushKey(toInt64(0, self._equipListCount))
    end
  end
  self._indexInvenEnd = self._equipListCount
  for equipIdx = __eEquipSlotNoRightHand, __eEquipSlotNoCount do
    local itemWrapper = ToClient_getEquipmentItem(equipIdx)
    if nil ~= itemWrapper and true == PaGlobal_ItemSkillOption_All:filterTargetItem(equipIdx, itemWrapper, __eItemWhereTypeEquip, true) then
      self._equipListCount = self._equipListCount + 1
      self._equipList[self._equipListCount] = equipIdx
      self._ui._list2_TargetItem:getElementManager():pushKey(toInt64(0, self._equipListCount))
    end
  end
  if self._equipListCount <= 0 then
    self._ui._txt_NoTargetItem:SetShow(true)
  else
    self._ui._txt_NoTargetItem:SetShow(false)
    self._ui._list2_TargetItem:setCurrenttoIndex(self._toIndex)
  end
  PaGlobal_ItemSkillOption_All:updateForDefaultMatItem()
end
function PaGlobal_ItemSkillOption_All:updateForDefaultMatItem()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  local invenSize = selfPlayer:getInventorySlotCount(false)
  for m_index = 1, #self._defaultMaterialItemKey do
    self._defaultMaterialItemKey[m_index]._count = 0
  end
  self._ui._list2_MatItem:getElementManager():clearKey()
  for slotNo = 0, invenSize - 1 do
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
    if nil ~= itemWrapper then
      local itemSSW = itemWrapper:getStaticStatus():get()
      if itemSSW:getContentsEventType() == __eContentsType_ItemSkillOptionMaterial and ToClient_Inventory_CheckItemLock(slotNo, whereType) == false then
        for m_index = 1, #self._defaultMaterialItemKey do
          local itemkey = itemSSW._key:getItemKey()
          local itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
          if itemkey == self._defaultMaterialItemKey[m_index]._itemKey then
            self._defaultMaterialItemKey[m_index]._count = itemCount
          end
        end
      end
    end
  end
  for m_index = 1, #self._defaultMaterialItemKey do
    self._ui._list2_MatItem:getElementManager():pushKey(toInt64(0, m_index))
  end
end
function PaGlobal_ItemSkillOption_All:updateMatItem()
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  local selfPlayer = selfPlayerWrapper:get()
  self._ui._list2_MatItem:getElementManager():clearKey()
  self._materialList = {}
  self._materialListItemCount = {}
  self._itemCount = {}
  self._materialListCount = 0
  local invenSize = selfPlayer:getInventorySlotCount(false)
  for invenIdx = 0, invenSize - 1 do
    slotNo = selfPlayer:getRealInventorySlotNoNew(__eItemWhereTypeInventory, invenIdx)
    local itemWrapper = getInventoryItemByType(__eItemWhereTypeInventory, slotNo)
    if itemWrapper ~= nil and PaGlobal_ItemSkillOption_All:filterMatItem(slotNo, itemWrapper, __eItemWhereTypeInventory) == true then
      self._materialListCount = self._materialListCount + 1
      self._materialList[self._materialListCount] = slotNo
      self._ui._list2_MatItem:getElementManager():pushKey(toInt64(0, self._materialListCount))
    end
  end
end
function PaGlobal_ItemSkillOption_All:validate()
  self._ui._stc_titleBar:isValidate()
  self._ui._btn_Close:isValidate()
  self._ui._stc_LeftBg:isValidate()
  self._ui._txt_ItemSkillOptionDesc:isValidate()
  self._ui._stc_targetItemSlotBg:isValidate()
  self._ui._stc_materialSlotBg:isValidate()
  self._ui._txt_ResultText:isValidate()
  self._ui._stc_TargetItemListBg:isValidate()
  self._ui._list2_TargetItem:isValidate()
  self._ui._txt_NoTargetItem:isValidate()
  self._ui._stc_MatItemListBg:isValidate()
  self._ui._list2_MatItem:isValidate()
  self._ui._chk_skipAni:isValidate()
  self._ui._btn_DoEnchant:isValidate()
  self._ui._keyGuide_DoEnchant_Y:isValidate()
  self._ui._stc_ConsoleKeyGuide:isValidate()
  self._ui.keyguide_Select_A:isValidate()
  self._ui.keyguide_Cancel_B:isValidate()
  self._ui.keyguide_Detail_X:isValidate()
end
