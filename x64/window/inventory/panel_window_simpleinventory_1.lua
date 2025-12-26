function PaGlobal_SimpleInventory:init()
  self._ui._txt_titleBar = UI.getChildControl(self._ui._titleBar, "StaticText_TitleIcon")
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Win_Close_PCUI")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory:close(true)")
  self._ui._tabBg = UI.getChildControl(self._ui._invenBG, "Static_TabBg")
  self._ui._topBg = UI.getChildControl(self._ui._invenBG, "Static_TopBg")
  self._ui._mainBg = UI.getChildControl(self._ui._invenBG, "Static_MainSlotBG")
  self._ui._rdoBtn_inven = UI.getChildControl(self._ui._tabBg, "RadioButton_NormalInventory")
  self._ui._rdoBtn_cashInven = UI.getChildControl(self._ui._tabBg, "RadioButton_CashInventory")
  self._ui._rdoBtn_inven:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory:selectInventroy(" .. CppEnums.ItemWhereType.eInventory .. ")")
  self._ui._rdoBtn_cashInven:addInputEvent("Mouse_LUp", "PaGlobal_SimpleInventory:selectInventroy(" .. CppEnums.ItemWhereType.eCashInventory .. ")")
  self._ui._stc_keyguideLB = UI.getChildControl(self._ui._tabBg, "Static_LB_ConsoleUI")
  self._ui._stc_keyguideRB = UI.getChildControl(self._ui._tabBg, "Static_RB_ConsoleUI")
  self._ui._btn_sortOption = UI.getChildControl(self._ui._topBg, "Button_Sort_Set")
  self._ui._chk_sortButton = UI.getChildControl(self._ui._topBg, "CheckButton_ItemSort")
  self._ui._btn_sortOption:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleInventory_ToggleSortOption()")
  self._ui._txt_money = UI.getChildControl(self._ui._topBg, "Static_Text_Money")
  self._ui._btn_money = UI.getChildControl(self._ui._topBg, "Button_Money")
  if true == _ContentsGroup_SimpleInvenSearch then
    self._ui._btn_search = UI.getChildControl(self._ui._topBg, "Button_Search")
    self._ui._btn_search:SetShow(true)
    self._ui._btn_search:addInputEvent("Mouse_LUp", "PaGlobalFunc_SimpleInventory_SearchResult_Open()")
    self._ui._btn_search:addInputEvent("Mouse_On", "PaGlobalFunc_SimpleInventory_ShowSimpleToolTipSearch(true)")
    self._ui._btn_search:addInputEvent("Mouse_Out", "PaGlobalFunc_SimpleInventory_ShowSimpleToolTipSearch(false)")
    self._ui._btn_sortOption:SetPosX(self._ui._btn_search:GetPosX() + self._ui._btn_search:GetSizeX() + 2)
    self._ui._chk_sortButton:SetPosX(self._ui._btn_search:GetPosX() + self._ui._btn_search:GetSizeX() + 5)
  end
  self._ui._stc_transportItem = UI.getChildControl(self._ui._topBg, "StaticText_1")
  self._ui._stc_transportItemConsole = UI.getChildControl(self._ui._topBg, "StaticText_2_ConsoleUI")
  self._ui._scroll = UI.getChildControl(self._ui._mainBg, "Scroll_CashInven")
  UIScroll.InputEvent(self._ui._scroll, "HandleEventScroll_SimpleInventory")
  UIScroll.SetButtonSize(self._ui._scroll, self._config._slotCount, self._config._inventoryMax)
  UIScroll.InputEventByControl(self._ui._mainBg, "HandleEventScroll_SimpleInventory")
  local tmpSlotBg = UI.getChildControl(self._ui._mainBg, "Static_SlotBg_Template")
  local tmpLockSlotBg = UI.getChildControl(self._ui._mainBg, "Static_LockedSlotBg_Template")
  self._invenSlotSizeY = tmpSlotBg:GetSizeY()
  local gapX = tmpSlotBg:GetSizeX() + self._config._initPosX
  local gapY = tmpSlotBg:GetSizeY() + self._config._initPosY
  for ii = 0, self._config._slotCount - 1 do
    local slot = {
      bg = nil,
      icon = nil,
      lock = nil
    }
    local row = math.floor(ii / self._config._slotCols)
    local col = ii % self._config._slotCols
    slot.lock = UI.createControl(__ePAUIControl_Static, self._ui._mainBg, "slotLockBg_" .. ii)
    CopyBaseProperty(tmpLockSlotBg, slot.lock)
    slot.lock:SetPosX(self._config._initPosX + gapX * col)
    slot.lock:SetPosY(self._config._initPosY + gapY * row)
    slot.lock:SetShow(false)
    slot.bg = UI.createControl(__ePAUIControl_Static, self._ui._mainBg, "slotBg_" .. ii)
    CopyBaseProperty(tmpSlotBg, slot.bg)
    slot.bg:SetPosX(self._config._initPosX + gapX * col)
    slot.bg:SetPosY(self._config._initPosY + gapY * row)
    slot.bg:SetShow(false)
    SlotItem.new(slot, "slotIcon_" .. ii, ii, slot.bg, self._slotConfig)
    slot:createChild()
    slot.icon:SetShow(true)
    UIScroll.InputEventByControl(slot.icon, "HandleEventScroll_SimpleInventory")
    UIScroll.InputEventByControl(slot.lock, "HandleEventScroll_SimpleInventory")
    self._slots[ii] = slot
  end
  deleteControl(tmpSlotBg)
  deleteControl(tmpLockSlotBg)
  self._ui.stc_circle = UI.getChildControl(self._ui._equipBG, "Static_MainCircle_1")
  self._ui.stc_LifeEquipBg = UI.getChildControl(self._ui._equipBG, "Static_LifeEquipBg")
  self._ui.stc_LifeEquipBg:SetShow(false)
  self._ui.btn_Combat = UI.getChildControl(self._ui._equipBG, "RadioButton_Combat")
  self._ui.btn_Combat:SetShow(false)
  self._ui.btn_Life = UI.getChildControl(self._ui._equipBG, "RadioButton_Life")
  self._ui.btn_Life:SetShow(false)
  for slotNo = self._EquipNoMin, self._EquipNoMax - 1 do
    if true == PaGlobal_SimpleInventory:checkUsableSlot(slotNo) then
      local parentControl
      if slotNo >= __eEquipSlotNoAxe and slotNo <= __eEquipSlotNoSniperRifle then
        parentControl = self._ui.stc_LifeEquipBg
      else
        parentControl = self._ui.stc_circle
      end
      if self._slotNoId[slotNo] ~= nil then
        local slotBG = UI.getChildControl(parentControl, self._slotNoId[slotNo] .. "_BG")
        if slotBG ~= nil then
          slotBG:SetShow(false)
          self._equipSlotBG[slotNo] = slotBG
          local slot = {}
          slot.icon = UI.getChildControl(parentControl, self._slotNoId[slotNo])
          SlotItem.new(slot, "Equipment_" .. slotNo, slotNo, self._ui._equipBG, self._equipSlotConfig)
          slot:createChild()
          Panel_Tooltip_Item_SetPosition(slotNo, slot, "simpleEquipment")
          self._equipSlot[slotNo] = slot
        end
      end
    end
  end
  if _ContentsGroup_ArtifactItem == false then
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet1"):SetShow(false)
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet2"):SetShow(false)
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet1_BG"):SetShow(false)
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet2_BG"):SetShow(false)
  end
  self._ui.stc_abilityArea = UI.getChildControl(self._ui.stc_circle, "Static_AbilityArea")
  self._ui.stc_offenceIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack")
  self._ui.txt_offenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack_Value")
  self._ui.stc_defenceIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence")
  self._ui.txt_defenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence_Value")
  self._ui.stc_awakenOffenceIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack")
  self._ui.txt_awakenOffenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack_Value")
  self._ui.stc_shyAwakenIcon = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Title")
  self._ui.txt_shyAwakenText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Value")
  self._ui.stc_offenceIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(0, true)")
  self._ui.stc_offenceIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(0, false)")
  self._ui.stc_defenceIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(1, true)")
  self._ui.stc_defenceIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(1, false)")
  self._ui.stc_awakenOffenceIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(2, true)")
  self._ui.stc_awakenOffenceIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(2, false)")
  self._ui.stc_shyAwakenIcon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_StatTooltip(3, true)")
  self._ui.stc_shyAwakenIcon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_StatTooltip(3, false)")
  self._ui.btn_equipCrystal = UI.getChildControl(self._ui._equipBG, "Button_EquipCrystal")
  self._ui.btn_equipCrystal:addInputEvent("Mouse_On", "PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(true)")
  self._ui.btn_equipCrystal:addInputEvent("Mouse_Out", "PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(false)")
  self._ui.btn_equipCrystal:addInputEvent("Mouse_LUp", "PAGlobalFunc_CrystalTooltip_ToggleDetail_ForSimpleItem()")
  local underwearSlotBG = self._equipSlotBG[__eEquipSlotNoAvatarUnderwear]
  if nil ~= underwearSlotBG then
    self._originUnderWearSpanX = underwearSlotBG:GetSpanSize().x
  end
  local awakenWeaponSlotBG = self._equipSlotBG[__eEquipSlotNoAwakenWeapon]
  if nil ~= awakenWeaponSlotBG then
    self._changeUnderWearPosX = awakenWeaponSlotBG:GetPosX()
  end
  self._ui.stc_blankSlotTooltip = UI.getChildControl(self._ui._equipBG, "StaticText_Notice_1")
  self._ui.stc_blankSlotTooltip:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui.stc_blankSlotTooltip:SetFontColor(Defines.Color.C_FFC4BEBE)
  self._ui.stc_blankSlotTooltip:SetTextHorizonCenter()
  self._ui.btn_JoinCharacter = UI.getChildControl(self._ui._characterBG, "Button_Join")
  self._ui.txt_selectedCharName = UI.getChildControl(self._ui.btn_JoinCharacter, "StaticText_SelectedName")
  self._ui.btn_prevChar = UI.getChildControl(self._ui._characterBG, "Button_Before")
  self._ui.btn_nextChar = UI.getChildControl(self._ui._characterBG, "Button_Next")
  self._ui.btn_prevChar:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleInventory_ChangeCharacter(false)")
  self._ui.btn_nextChar:addInputEvent("Mouse_LUp", "HandleEventLUp_SimpleInventory_ChangeCharacter(true)")
  self._characterDataCount = getCharacterDataCount(__ePlayerCreateNormal)
  local selfProxy = getSelfPlayer()
  if nil ~= selfProxy then
    self._currentCharacterNo = selfProxy:getCharacterNo_64()
    PaGlobal_SimpleInventory:setCurrentCharacterIndex()
  end
  self._ui._stc_keyguideLS = UI.getChildControl(self._ui._keyguideBg, "StaticText_Sort_ConsoleUI")
  self._ui._stc_keyguideX = UI.getChildControl(self._ui._keyguideBg, "StaticText_X_ConsoleUI")
  self._ui._stc_keyguideY = UI.getChildControl(self._ui._keyguideBg, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyguideB = UI.getChildControl(self._ui._keyguideBg, "StaticText_B_ConsoleUI")
  self._ui._stc_keyguideLT = UI.getChildControl(self._ui._keyguideBg, "StaticText_Ltrigger_ConsoleUI")
  self._ui._stc_keyguideRT = UI.getChildControl(self._ui._keyguideBg, "StaticText_Rtrigger_ConsoleUI")
  self._ui._stc_keyguideRS = UI.getChildControl(self._ui._keyguideBg, "StaticText_RSClick_Search_ConsolUI")
  self._ui._stc_keyguideTransport = UI.getChildControl(self._ui._keyguideBg, "StaticText_A_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_SimpleInventory:setConsoleUI()
  PaGlobal_SimpleInventory:validate()
  self._originPanelSizeX = Panel_Window_SimpleInventory:GetSizeX()
  registerEvent("FromClient_LoadCompleteSimpleItem", "FromClient_SimpleInventory_LoadCompleteSimpleItem")
  registerEvent("FromClient_LoadCompleteOtherPlayerSimpleItem", "FromClient_SimpleInventory_LoadCompleteOtherPlayerSimpleItem")
  registerEvent("FromClient_ResponseTransportItem", "FromClient_ResponseTransportItem")
  registerEvent("FromClient_ItemEraseEvent", "FromClient_ItemEraseEvent")
  self:changeControlSettingWhenOpeneArtifact()
  self._ui._stc_transportItem:SetShow(not self._isConsole)
  self._ui._stc_transportItemConsole:SetShow(self._isConsole)
  if self._isConsole == true then
    self._ui._stc_transportItemConsole:SetPosX(self._ui._topBg:GetSizeX() - self._ui._stc_transportItemConsole:GetSizeX() - self._ui._stc_transportItemConsole:GetTextSizeX() - 10)
  else
    self._ui._stc_transportItem:SetPosX(self._ui._topBg:GetSizeX() - self._ui._stc_transportItem:GetSizeX() - self._ui._stc_transportItem:GetTextSizeX() - 10)
  end
end
function PaGlobal_SimpleInventory:changeControlSettingWhenOpeneArtifact()
  Panel_Window_SimpleInventory:SetSize(Panel_Window_SimpleInventory:GetSizeX(), Panel_Window_SimpleInventory:GetSizeY() + self._invenSlotSizeY + self._config._initPosY)
  self._ui._mainBg:SetSize(self._ui._mainBg:GetSizeX(), self._ui._mainBg:GetSizeY() + self._invenSlotSizeY + self._config._initPosY)
  self._ui._scroll:SetSize(self._ui._scroll:GetSizeX(), self._ui._scroll:GetSizeY() + self._invenSlotSizeY + self._config._initPosY)
  self._ui._equipBG:SetSize(self._ui._equipBG:GetSizeX(), self._ui._equipBG:GetSizeY() + self._invenSlotSizeY + self._config._initPosY)
  self._ui.stc_abilityArea:SetPosY(self._ui.stc_abilityArea:GetPosY() + self._invenSlotSizeY + self._config._initPosY)
  self._ui.btn_equipCrystal:SetPosY(self._ui.btn_equipCrystal:GetPosY() + self._invenSlotSizeY + self._config._initPosY)
  self._ui._characterBG:SetPosY(self._ui._characterBG:GetPosY() + self._invenSlotSizeY + self._config._initPosY)
  Panel_Window_SimpleInventory:ComputePos()
end
function PaGlobal_SimpleInventory:setCurrentCharacterIndex()
  for idx = 0, self._characterDataCount - 1 do
    local data = getCharacterDataByIndex(idx, __ePlayerCreateNormal)
    if nil ~= data and data._characterNo_s64 == self._currentCharacterNo then
      self._currentCharacterIndex = idx
      return
    end
  end
end
function PaGlobal_SimpleInventory:setConsoleUI()
  self._ui._keyguideBg:SetShow(self._isConsole)
  if true == self._isConsole then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_sortOption:SetShow(true)
    self._ui._chk_sortButton:SetShow(true)
    self._ui.btn_equipCrystal:SetShow(false)
    self._ui.btn_prevChar:SetShow(false)
    self._ui.btn_nextChar:SetShow(false)
    self._ui._stc_keyguideLB:SetShow(true)
    self._ui._stc_keyguideRB:SetShow(true)
    if nil ~= Panel_Window_SimpleInventory then
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_SimpleInventory_ToggleSortCheckButton()")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobalFunc_SimpleInventory_SelectInventoryForConsole(true)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobalFunc_SimpleInventory_SelectInventoryForConsole(false)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_LT, "HandleEventLUp_SimpleInventory_ChangeCharacter(false)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_RT, "HandleEventLUp_SimpleInventory_ChangeCharacter(true)")
      Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_Y, "PAGlobalFunc_SimpleInventory_ShowCrystalInfoForConsole()")
      if _ContentsGroup_SimpleInvenSearch == true then
        Panel_Window_SimpleInventory:registerPadEvent(__eConsoleUIPadEvent_RSClick, "PaGlobalFunc_SimpleInventory_SearchResult_Open()")
      end
    end
    self._ui.stc_offenceIcon:SetSpanSize(self._ui.stc_offenceIcon:GetSpanSize().x, 40)
    self._ui.stc_defenceIcon:SetSpanSize(self._ui.stc_defenceIcon:GetSpanSize().x, 40)
    self._ui.stc_awakenOffenceIcon:SetSpanSize(self._ui.stc_awakenOffenceIcon:GetSpanSize().x, 40)
    self._ui.stc_shyAwakenIcon:SetSpanSize(self._ui.stc_shyAwakenIcon:GetSpanSize().x, 40)
    self._ui.txt_offenceText:SetSpanSize(self._ui.txt_offenceText:GetSpanSize().x, 70)
    self._ui.txt_defenceText:SetSpanSize(self._ui.txt_defenceText:GetSpanSize().x, 70)
    self._ui.txt_awakenOffenceText:SetSpanSize(self._ui.txt_awakenOffenceText:GetSpanSize().x, 70)
    self._ui.txt_shyAwakenText:SetSpanSize(self._ui.txt_shyAwakenText:GetSpanSize().x, 70)
    PaGlobal_SimpleInventory:alignKeyGuides()
    Panel_Window_SimpleInventory:ignorePadSnapMoveToOtherPanel()
  end
end
function PaGlobal_SimpleInventory:alignKeyGuides()
  if self._isConsole == true then
    local keyGuides = Array.new()
    keyGuides:push_back(self._ui._stc_keyguideLS)
    keyGuides:push_back(self._ui._stc_keyguideY)
    keyGuides:push_back(self._ui._stc_keyguideLT)
    keyGuides:push_back(self._ui._stc_keyguideRT)
    keyGuides:push_back(self._ui._stc_keyguideX)
    keyGuides:push_back(self._ui._stc_keyguideB)
    if _ContentsGroup_SimpleInvenSearch == true then
      self._ui._stc_keyguideRS:SetShow(true)
      keyGuides:push_back(self._ui._stc_keyguideRS)
    else
      self._ui._stc_keyguideRS:SetShow(false)
    end
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._keyguideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
end
function PaGlobal_SimpleInventory:updateSortKeyguide()
  if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.AnotherCharacterInventory) == false then
    self._ui._stc_keyguideLS:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SORT"))
  else
    self._ui._stc_keyguideLS:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_INVENTORY_KEYGUIDE_UNSORT"))
  end
  self:alignKeyGuides()
end
function PaGlobal_SimpleInventory:clear()
  self._invenWrapper = nil
  self._equipWrapper = nil
  self._ui._rdoBtn_inven:SetCheck(CppEnums.ItemWhereType.eInventory == self._itemWhereType)
  self._ui._rdoBtn_cashInven:SetCheck(CppEnums.ItemWhereType.eCashInventory == self._itemWhereType)
  self._ui._txt_money:SetText("0")
  self._ui._btn_money:SetPosX(self._ui._topBg:GetSizeX() - self._ui._txt_money:GetTextSizeX() - 60)
  self._selectedCharacterNo = nil
  self._selectedCharacterEquipAwakenWeapon = false
  ToClient_SetSimpleInventoryCharacterNo(-1)
  self._searchItemWhereType = nil
  TooltipSimple_Hide()
end
function PaGlobal_SimpleInventory:slotsClear()
  self._currentItemCount = 0
  for ii = 0, self._config._slotCount - 1 do
    local slot = self._slots[ii]
    slot:clearItem()
    slot.lock:SetShow(true)
    slot.bg:SetShow(false)
    slot.originalForDuelIcon:SetShow(false)
    slot.duplicatedForDuelIcon:SetShow(false)
  end
end
function PaGlobal_SimpleInventory:open(characterNo_s64)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  PaGlobal_SimpleInventory:prepareOpen(true)
  self:clear()
  self._selectedCharacterNo = characterNo_s64
  self._selectedCharacterEquipAwakenWeapon = false
  ToClient_SetSimpleInventoryCharacterNo(self._selectedCharacterNo)
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.AnotherCharacterInventory, Panel_Window_SimpleInventory, PaGlobal_SimpleInventory._ui._btn_sortOption, PaGlobal_SimpleInventory._ui._chk_sortButton, nil, nil)
  local invenWrapper = ToClient_SimpleInventoryWrapper(characterNo_s64)
  if nil == invenWrapper then
    return
  end
  self._invenWrapper = invenWrapper
  self._ui._txt_money:SetText(makeDotMoney(self._invenWrapper:getMoney_s64()))
  self._ui._btn_money:SetPosX(self._ui._topBg:GetSizeX() - self._ui._txt_money:GetTextSizeX() - 50)
  self:selectInventroy(self._itemWhereType)
  local equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo_s64)
  if nil == equipWrapper then
    return
  end
  self._equipWrapper = equipWrapper
  self:updateEquipment()
  self._ui.btn_prevChar:setRenderTexture(self._ui.btn_prevChar:getBaseTexture())
  self._ui.btn_nextChar:setRenderTexture(self._ui.btn_nextChar:getBaseTexture())
  self:updateStat()
  Panel_Window_SimpleInventory:SetShow(true)
end
function PaGlobal_SimpleInventory:openOtherPlayerInventory()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  PaGlobal_SimpleInventory:prepareOpen(false)
  self:clear()
  PaGlobalFunc_AutoSortFunctionPanel_LinkPanel(InvenSortLinkPanelIndex.AnotherCharacterInventory, Panel_Window_SimpleInventory, PaGlobal_SimpleInventory._ui._btn_sortOption, PaGlobal_SimpleInventory._ui._chk_sortButton, nil, nil)
  local invenWrapper = ToClient_OtherPlayerSimpleInventoryWrapper()
  if nil == invenWrapper then
    return
  end
  self._invenWrapper = invenWrapper
  self._ui._txt_money:SetText(makeDotMoney(self._invenWrapper:getMoney_s64()))
  self._ui._btn_money:SetPosX(self._ui._topBg:GetSizeX() - self._ui._txt_money:GetTextSizeX() - 50)
  self:selectInventroy(CppEnums.ItemWhereType.eInventory)
  self._ui._equipBG:SetShow(false)
  local characterName = ToClient_GetOtherPlayerCharacterName()
  if nil == characterName then
    return
  end
  self._ui.txt_selectedCharName:SetText(characterName)
  Panel_Window_SimpleInventory:SetShow(true)
end
function PaGlobal_SimpleInventory:prepareOpen(isMyCharacter)
  if self._ui._equipBG:GetShow() == isMyCharacter then
    return
  end
  local grayLine = UI.getChildControl(self._ui._characterBG, "Static_Line")
  self._ui._equipBG:SetShow(isMyCharacter)
  self._ui.btn_nextChar:SetShow(isMyCharacter)
  self._ui.btn_prevChar:SetShow(isMyCharacter)
  grayLine:SetShow(isMyCharacter)
  if true == isMyCharacter then
    Panel_Window_SimpleInventory:SetSize(self._originPanelSizeX, Panel_Window_SimpleInventory:GetSizeY())
    self._ui._characterBG:SetSize(self._originPanelSizeX, self._ui._characterBG:GetSizeY())
    self._ui._titleBar:SetSize(self._originPanelSizeX, self._ui._titleBar:GetSizeY())
    self._ui._txt_titleBar:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_SUBINVENTORY_TITLE"))
  else
    Panel_Window_SimpleInventory:SetSize(self._ui._invenBG:GetSizeX(), Panel_Window_SimpleInventory:GetSizeY())
    self._ui._characterBG:SetSize(self._ui._invenBG:GetSizeX(), self._ui._characterBG:GetSizeY())
    self._ui._titleBar:SetSize(self._ui._invenBG:GetSizeX(), self._ui._titleBar:GetSizeY())
    self._ui._txt_titleBar:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GAMEEXIT_VIEW_INVENTORY"))
  end
  Panel_Window_SimpleInventory:ComputePosAllChild()
end
function PaGlobal_SimpleInventory:close(isCloseAll)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.AnotherCharacterInventory) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
  TooltipSimple_Hide()
  if true == _ContentsGroup_SimpleInvenSearch and nil ~= Panel_Window_SimpleInventory_SearchResult and true == Panel_Window_SimpleInventory_SearchResult:GetShow() then
    PaGlobal_SimpleInventory_SearchResult:prepareClose()
    if true ~= isCloseAll then
      return
    end
  end
  if true == self._isConsole then
    if nil ~= Panel_Window_Inventory_Detail and true == Panel_Window_Inventory_Detail:GetShow() then
      PaGlobal_InventoryEquip_Detail_Renew_Close()
      return
    end
  else
    PAGlobalFunc_CrystalTooltip_Show_ForSimpleItem(false)
  end
  self._itemWhereType = CppEnums.ItemWhereType.eInventory
  ToClient_SetSimpleInventoryWhereType(self._itemWhereType)
  self:itemTooltip_Hide()
  Panel_Window_SimpleInventory:SetShow(false)
end
function PaGlobal_SimpleInventory:requestSimpleInventory(index)
  local data = getCharacterDataByIndex(index, __ePlayerCreateNormal)
  if nil == data then
    return
  end
  if true == _ContentsGroup_PreSeason and data._characterSeasonType == __eCharacterSeasonType_Season then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_SELECTCHARACTER_NOTYET_1"))
    return
  end
  self._selectedCharacterClassType = getCharacterClassType(data)
  self._selectedCharacterIndex = index
  self._ui.txt_selectedCharName:SetText(getCharacterName(data))
  PaGlobal_SimpleInventory:updateChangeButton(index)
  PaGlobal_SimpleInventory:clearSearchItemInfo(false, true)
  PaGlobal_SimpleInventory:clearSearchEquipItemInfo(false, true)
  PaGlobal_SimpleInventory._ui.btn_JoinCharacter:addInputEvent("Mouse_LUp", "PaGlobal_GameExit_All_ChangeCharacter(" .. index .. ")")
  ToClient_requestSimpleItem(index)
end
function PaGlobal_SimpleInventory:itemTooltip_Show(itemEnchantKey, index)
  local itemSSW = getItemEnchantStaticStatus(ItemEnchantKey(itemEnchantKey))
  local control = Panel_Window_SimpleInventory
  if nil ~= itemSSW and nil ~= control then
    Panel_Tooltip_Item_Show(itemSSW, control, true)
  end
end
function PaGlobal_SimpleInventory:itemTooltip_Hide()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_SimpleInventory:setSlot(simpleItemWrapper, itemSSW, itemCount_s64, itemWhereType, inventorySlotNo, isSealed, isVested)
  if nil == itemSSW then
    return
  end
  local slot = self._slots[self._currentItemCount]
  if nil == slot then
    return
  end
  local slotIsSealed = isSealed
  local isTradeAble = requestIsRegisterItemForItemMarket(itemSSW:get()._key)
  if isVested == true or isTradeAble == false then
    slotIsSealed = false
  end
  slot:setItemByStaticStatus(itemSSW, itemCount_s64, nil, nil, nil, nil, nil, nil, nil, nil, slotIsSealed, nil, nil, nil)
  slot:setMaidActorItemIcon(simpleItemWrapper:isMaidEquipableItem())
  if false == self._isConsole then
    slot.icon:addInputEvent("Mouse_On", "PaGlobal_SimpleInventory:itemTooltip_Show(" .. itemSSW:get()._key:get() .. "," .. self._currentItemCount .. ")")
    slot.icon:addInputEvent("Mouse_Out", "PaGlobal_SimpleInventory:itemTooltip_Hide()")
    slot.icon:addInputEvent("Mouse_RUp", "PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(" .. itemSSW:get()._key:get() .. ", " .. itemWhereType .. ", " .. inventorySlotNo .. ", " .. tostring(isSealed) .. ")")
  elseif false == _ContentsGroup_RenewUI_Tooltip then
    slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_SimpleInventory:itemTooltip_Show(" .. itemSSW:get()._key:get() .. "," .. self._currentItemCount .. ")")
    slot.bg:addInputEvent("Mouse_Out", "PaGlobal_SimpleInventory:itemTooltip_Hide()")
    slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(" .. itemSSW:get()._key:get() .. ", " .. itemWhereType .. ", " .. inventorySlotNo .. ", " .. tostring(isSealed) .. ")")
  else
    slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SimpleInventory_ShowItemTooltipForConsole(" .. itemSSW:get()._key:get() .. ")")
    slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(" .. itemSSW:get()._key:get() .. ", " .. itemWhereType .. ", " .. inventorySlotNo .. ", " .. tostring(isSealed) .. ")")
  end
  slot.lock:SetShow(false)
  slot.bg:SetShow(true)
  local isOriginalItem = simpleItemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
  if isOriginalItem == true then
    slot.originalForDuelIcon:SetShow(true)
  else
    slot.originalForDuelIcon:SetShow(false)
  end
  local isDuplicatedItem = simpleItemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
  if isDuplicatedItem == true then
    slot.duplicatedForDuelIcon:SetShow(true)
  else
    slot.duplicatedForDuelIcon:SetShow(false)
  end
  self._currentItemCount = self._currentItemCount + 1
end
function PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(itemEnchantKey, itemWhereType, inventorySlotNo, isSealed, searchIndex)
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  local isFreeBattle = selfProxy:get():isBattleGroundDefine()
  local isArshaJoin = ToClient_IsMyselfInArena()
  local localWarTeam = ToClient_GetMyTeamNoRedBattleField()
  local isPremiumCharacter = getTemporaryInformationWrapper():isPremiumCharacter()
  local isSavageDefence = ToClient_getPlayNowSavageDefence()
  local isGuildBattle = ToClient_getJoinGuildBattle()
  local isRestrictRegion = ToClient_RestrictContentsByRegion(__eRestrictContentsType_Maid)
  if localWarTeam ~= 0 or ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) == true then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_LOCALWAR"))
    return
  end
  if isFreeBattle then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_FREEBATTLE"))
    return
  end
  if isArshaJoin then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_ARSHA"))
    return
  end
  if selfplayerIsInHorseRace() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_HORSERACE_NEW"))
    return
  end
  if isPremiumCharacter then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_PREMIUMCHARACTER"))
    return
  end
  if isSavageDefence then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantPlayingSavageDefence"))
    return
  end
  if isGuildBattle then
    if true == ToClient_isPersonalBattle() then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_PERSONALBATTLE"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_GUILDBATTLE"))
    end
    return
  end
  if isRestrictRegion then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoRestrictContentsByRegion"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_HorseRacing) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_ICON_MAID_DONT_SUMMON_HORSERACE"))
    return
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantDoAnythingAfterSolrareStart"))
    return
  end
  local itemCount_s64 = toInt64(0, 0)
  if searchIndex ~= nil then
    itemCount_s64 = tonumber64(ToClient_getItemCountAndCacheBySearchIndex(searchIndex))
  else
    itemCount_s64 = tonumber64(ToClient_getItemCountAndCache(self._selectedCharacterNo, itemWhereType, inventorySlotNo))
  end
  if itemCount_s64 == Defines.s64_const.s64_0 then
    return
  end
  itemCount_s64 = ToClient_getMoveCountWhenUseMaid(itemEnchantKey, itemCount_s64, false)
  if itemCount_s64 == Defines.s64_const.s64_0 then
    return
  end
  local function transportItemToMyBag()
    if itemCount_s64 > Defines.s64_const.s64_1 then
      Panel_NumberPad_Show(true, itemCount_s64, itemEnchantKey, HandleEventLUp_SimpleInventory_TransportItemToMyBag, nil, itemWhereType, nil, isSealed)
    else
      HandleEventLUp_SimpleInventory_TransportItemToMyBag(itemCount_s64, itemEnchantKey, itemWhereType, isSealed)
    end
  end
  local cancelFunction = function()
    if PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened ~= nil and PaGlobal_TotalSearch._isPadMode == false then
      PaGlobalFunc_TotalSearch_SetFocusEditWhenPanelOpened()
    end
  end
  if ToClient_getUsableMaidCountByType(false) == 0 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantFindUseableMaid"))
    return
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OTHERINVENTORY_ITEM_MOVE_MESSAGE", "count", tostring(ToClient_getUsableMaidCountByType(false)))
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = transportItemToMyBag,
    functionNo = cancelFunction,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_SimpleInventory:selectInventroy(itemWhereType)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  if CppEnums.ItemWhereType.eInventory ~= itemWhereType and CppEnums.ItemWhereType.eCashInventory ~= itemWhereType then
    return
  end
  if PaGlobalFunc_AutoSortFunctionPanel_GetShow(InvenSortLinkPanelIndex.AnotherCharacterInventory) == true then
    PaGlobalFunc_AutoSortFunctionPanel_Hide()
  end
  self._currentIndex = 0
  self._maxSlotCount = self._invenWrapper:getInventorySize(itemWhereType)
  self._itemWhereType = itemWhereType
  ToClient_SetSimpleInventoryWhereType(self._itemWhereType)
  PaGlobalFunc_AutoSortFunctionPanel_LoadSortOptionAndDoSort(InvenSortLinkPanelIndex.AnotherCharacterInventory, false)
  self._ui._scroll:SetControlTop()
  self._ui._scroll:SetControlPos(0)
  self._ui._rdoBtn_inven:SetCheck(CppEnums.ItemWhereType.eInventory == itemWhereType)
  self._ui._rdoBtn_cashInven:SetCheck(CppEnums.ItemWhereType.eCashInventory == itemWhereType)
  self:updateSlot()
  self:updateSearchItem()
end
function PaGlobal_SimpleInventory:updateSlot()
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self:slotsClear()
  self:updateSearchItem()
  for ii = self._currentIndex, self._maxSlotCount do
    if self._config._slotCount <= self._currentItemCount then
      return
    end
    local slotNo = ii
    if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.AnotherCharacterInventory) == true then
      slotNo = selfPlayer:get():getRealInventorySlotNoNew(__eInventorySortWhereType_AnotherCharacterInventory, ii)
    end
    local itemWrapper = self._invenWrapper:getSimpleItemWrapper(self._itemWhereType, slotNo)
    if itemWrapper ~= nil then
      local itemSSW = getItemEnchantStaticStatus(itemWrapper:getItemEnchantKey())
      if nil ~= itemSSW then
        self:setSlot(itemWrapper, itemSSW, itemWrapper:getItemCount_s64(), itemWrapper:getItemWhereType(), itemWrapper:getInventorySlotNo(), itemWrapper:getItemIsSealed(), itemWrapper:getItemIsVested())
      end
    end
  end
end
function PaGlobal_SimpleInventory:checkUsableSlot(index)
  if index == self._UnUsedEquipNo_01 or index == self._UnUsedEquipNo_02 or index == __eEquipSlotNoCount or index == __eEquipSlotNoExplorationBonus0 or index == __eEquipSlotNoInstallation4 or index == __eEquipSlotNoBody or index == __eEquipSlotNoAvatarBody then
    return false
  end
  if false == _ContentsGroup_ArtifactItem and (index == __eEquipSlotNoArtifact1 or index == __eEquipSlotNoArtifact2) then
    return false
  end
  return true
end
function PaGlobal_SimpleInventory:updateEquipment()
  self._extendedSlotInfoArray = {}
  local checkExtendedSlot = false
  local classType = self._selectedCharacterClassType
  for slotNo = self._EquipNoMin, self._EquipNoMax - 1 do
    if true == PaGlobal_SimpleInventory:checkUsableSlot(slotNo) then
      PaGlobal_SimpleInventory:setEquipSlotBGIcon(slotNo, classType)
      local equipItemWrapper = self._equipWrapper:getSimpleEquipItemWrapper(slotNo)
      if nil == equipItemWrapper then
        return
      end
      local slotBG = self._equipSlotBG[slotNo]
      local slot = self._equipSlot[slotNo]
      if nil == slotBG or nil == slot then
        return
      end
      local itemWrapper = equipItemWrapper:getItem()
      if nil ~= itemWrapper then
        local itemSSW = itemWrapper:getStaticStatus()
        local slotNoMax = itemSSW:getExtendedSlotCount()
        for i = 1, slotNoMax do
          local extendSlotNo = itemSSW:getExtendedSlotIndex(i - 1)
          if slotNoMax ~= extendSlotNo then
            self._extendedSlotInfoArray[extendSlotNo] = slotNo
            checkExtendedSlot = true
          end
        end
        PaGlobal_SimpleInventory:setItemInfoUseWrapper(slot, itemWrapper, false, false, slotNo)
        slotBG:SetShow(false)
        slot.icon:SetEnable(true)
        slot.icon:SetShow(true)
        if __eEquipSlotNoAwakenWeapon == slotNo then
          self._selectedCharacterEquipAwakenWeapon = true
        end
        if false == self._isConsole then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",false)")
          slot.icon:addInputEvent("Mouse_RUp", "PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(" .. itemSSW:get()._key:get() .. ", " .. __eItemWhereTypeEquip .. ", " .. slotNo .. ", " .. tostring(itemWrapper:isSealed()) .. ")")
        elseif false == _ContentsGroup_RenewUI_Tooltip then
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(" .. itemSSW:get()._key:get() .. ", " .. __eItemWhereTypeEquip .. ", " .. slotNo .. ", " .. tostring(itemWrapper:isSealed()) .. ")")
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_EquipmentTooltip(" .. slotNo .. ",false)")
        else
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobal_SimpleInventory:itemTooltip_TransportItemToMyBag(" .. itemSSW:get()._key:get() .. ", " .. __eItemWhereTypeEquip .. ", " .. slotNo .. ", " .. tostring(itemWrapper:isSealed()) .. ")")
          slot.icon:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_SimpleInventory_ShowEquipItemTooltipForConsole(" .. slotNo .. ")")
        end
        local isOriginalItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseOriginalDuelItem)
        if isOriginalItem == true then
          slot.originalForDuelIcon:SetShow(true)
        end
        local isDuplicatedItem = itemWrapper:isSetLimitOption(__eItemLimitOptionType_LimitItemUseDuelCharacter)
        if isDuplicatedItem == true then
          slot.duplicatedForDuelIcon:SetShow(true)
        end
      else
        slot:clearItem()
        slot.icon:SetEnable(true)
        slotBG:SetShow(true)
        local useAwakenWeapon = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
        if __eEquipSlotNoAwakenWeapon == slotNo then
          local isShowAwakenWeapon = true == useAwakenWeapon or true == _ContentsGroup_AwakenWeaponCommonSlot
          slotBG:SetShow(isShowAwakenWeapon)
          slot.icon:SetEnable(isShowAwakenWeapon)
          slot.icon:SetShow(isShowAwakenWeapon)
          self._selectedCharacterEquipAwakenWeapon = false
        elseif __eEquipSlotNoAvatarAwakenWeapon == slotNo then
          local isShow = useAwakenWeapon
          if __eClassType_ShyWaman == classType then
            isShow = false
          end
          slotBG:SetShow(isShow)
          slot.icon:SetEnable(isShow)
          slot.icon:SetShow(isShow)
        end
        if false == self._isConsole then
          slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_SimpleInventory_EmptySlotTooltip(" .. slotNo .. ",true)")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_SimpleInventory_EmptySlotTooltip(" .. slotNo .. ",false)")
          slot.icon:removeInputEvent("Mouse_RUp")
        end
        if __eEquipSlotNoLantern == slotNo then
          slot.icon:SetShow(false)
          slotBG:SetShow(false)
        end
      end
    end
  end
  if _ContentsGroup_ArtifactItem == false then
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet1"):SetShow(false)
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet2"):SetShow(false)
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet1_BG"):SetShow(false)
    UI.getChildControl(self._ui.stc_circle, "Static_Slot_Bracelet2_BG"):SetShow(false)
  end
  if true == checkExtendedSlot then
    PaGlobal_SimpleInventory:updateExtendedSlot()
  end
end
function PaGlobal_SimpleInventory:updateExtendedSlot()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  if nil == self._extendedSlotInfoArray then
    return
  end
  for extendSlotNo, parentSlotNo in pairs(self._extendedSlotInfoArray) do
    if nil ~= extendSlotNo and nil ~= parentSlotNo then
      local parrentEquipItemWrapper = self._equipWrapper:getSimpleEquipItemWrapper(parentSlotNo)
      if nil == parrentEquipItemWrapper then
        return
      end
      local setSlotBG = self._equipSlotBG[extendSlotNo]
      local slot = self._equipSlot[extendSlotNo]
      if nil == setSlotBG or nil == slot then
        return
      end
      local itemWrapper = parrentEquipItemWrapper:getItem()
      if nil ~= itemWrapper then
        setSlotBG:SetShow(false)
        PaGlobal_SimpleInventory:setItemInfoUseWrapper(slot, itemWrapper, true, true)
      end
    end
  end
end
function PaGlobal_SimpleInventory:setEquipSlotBGIcon(slotNo, classType)
  if nil == slotNo or nil == classType then
    return
  end
  if slotNo < self._EquipNoMin or slotNo >= self._EquipNoMax then
    return
  end
  local slotBG = self._equipSlotBG[slotNo]
  local slot = self._equipSlot[slotNo]
  if nil == slotBG or nil == slot then
    return
  end
  if __eClassType_ShyWaman == classType then
    if __eEquipSlotNoAwakenWeapon == slotNo then
      slotBG:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 283, 48, 329, 94)
      slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBG:setRenderTexture(slotBG:getBaseTexture())
    elseif __eEquipSlotNoAvatarAwakenWeapon == slotNo then
      slotBG:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 330, 48, 376, 94)
      slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
      slotBG:setRenderTexture(slotBG:getBaseTexture())
    end
  elseif __eEquipSlotNoAwakenWeapon == slotNo then
    slotBG:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 95, 1, 141, 47)
    slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBG:setRenderTexture(slotBG:getBaseTexture())
  elseif __eEquipSlotNoAvatarAwakenWeapon == slotNo then
    slotBG:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(slotBG, 95, 95, 141, 141)
    slotBG:getBaseTexture():setUV(x1, y1, x2, y2)
    slotBG:setRenderTexture(slotBG:getBaseTexture())
  end
  local underwearSlotNo = __eEquipSlotNoAvatarUnderwear
  local underwearSlotBG = self._equipSlotBG[underwearSlotNo]
  local underwearSlot = self._equipSlot[underwearSlotNo]
  if nil == underwearSlotBG or nil == underwearSlot then
    return
  end
  local spanY = underwearSlotBG:GetSpanSize().y
  if __eClassType_ShyWaman == classType or false == PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType) then
    underwearSlotBG:SetPosX(self._changeUnderWearPosX)
    underwearSlot.icon:SetPosX(self._changeUnderWearPosX)
  else
    underwearSlotBG:SetSpanSize(self._originUnderWearSpanX, spanY)
    underwearSlot.icon:SetSpanSize(self._originUnderWearSpanX, spanY)
  end
end
function PaGlobal_SimpleInventory:setItemInfoUseWrapper(slot, itemWrapper, isMono, isExtended, slotNo)
  slot:setItem(itemWrapper, slotNo, true)
  if false == isExtended then
    slot.icon:SetEnable(true)
  else
    slot.icon:SetEnable(false)
  end
  if true == isMono then
    slot.icon:SetMonoTone(true)
  elseif false == isMono then
    slot.icon:SetMonoTone(false)
  end
end
function PaGlobal_SimpleInventory:updateChangeButton(index)
  local preCharacterShow = -1 ~= PaGlobal_SimpleInventory:getNextIndex(false, index)
  local nextCharacterShow = -1 ~= PaGlobal_SimpleInventory:getNextIndex(true, index)
  local prevIndex = index - 1
  local prevShow = true
  if prevIndex == self._currentCharacterIndex then
    prevIndex = prevIndex - 1
  end
  if prevIndex < 0 then
    prevShow = false
  end
  if false == self._isConsole then
    self._ui.btn_prevChar:SetShow(preCharacterShow)
  else
    self._ui._stc_keyguideLT:SetShow(preCharacterShow)
  end
  local nextIndex = index + 1
  local nextShow = true
  if nextIndex == self._currentCharacterIndex then
    nextIndex = nextIndex + 1
  end
  if nextIndex >= self._characterDataCount then
    nextShow = false
  end
  if false == self._isConsole then
    self._ui.btn_nextChar:SetShow(nextCharacterShow)
  else
    self._ui._stc_keyguideRT:SetShow(nextCharacterShow)
  end
  if true == self._isConsole then
    self:alignKeyGuides()
  end
end
function PaGlobal_SimpleInventory:updateStat()
  if nil == self._selectedCharacterNo then
    return
  end
  local statWrapper = ToClient_SimpleStatWrapper(self._selectedCharacterNo)
  if nil == statWrapper then
    return
  end
  local offence = statWrapper:getOffence()
  local defence = statWrapper:getDefence()
  local awakenOffence = statWrapper:getAwakenOffence()
  self._ui.txt_offenceText:SetText(tostring(offence))
  self._ui.txt_defenceText:SetText(tostring(defence))
  local awakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(self._selectedCharacterClassType)
  if false == awakenWeaponContentsOpen or false == self._selectedCharacterEquipAwakenWeapon then
    self._ui.stc_shyAwakenIcon:SetShow(false)
    self._ui.txt_shyAwakenText:SetShow(false)
    self._ui.stc_awakenOffenceIcon:SetShow(false)
    self._ui.txt_awakenOffenceText:SetShow(false)
    self._ui.stc_offenceIcon:SetSpanSize(110, self._ui.stc_offenceIcon:GetSpanSize().y)
    self._ui.txt_offenceText:SetSpanSize(90, self._ui.txt_offenceText:GetSpanSize().y)
    self._ui.stc_defenceIcon:SetSpanSize(110, self._ui.stc_defenceIcon:GetSpanSize().y)
    self._ui.txt_defenceText:SetSpanSize(90, self._ui.txt_defenceText:GetSpanSize().y)
  else
    if __eClassType_ShyWaman == self._selectedCharacterClassType then
      self._ui.stc_shyAwakenIcon:SetShow(true)
      self._ui.txt_shyAwakenText:SetShow(true)
      self._ui.stc_awakenOffenceIcon:SetShow(false)
      self._ui.txt_awakenOffenceText:SetShow(false)
      self._ui.txt_shyAwakenText:SetText(tostring(awakenOffence))
    else
      self._ui.stc_shyAwakenIcon:SetShow(false)
      self._ui.txt_shyAwakenText:SetShow(false)
      self._ui.stc_awakenOffenceIcon:SetShow(true)
      self._ui.txt_awakenOffenceText:SetShow(true)
      self._ui.txt_awakenOffenceText:SetText(tostring(awakenOffence))
    end
    self._ui.stc_offenceIcon:SetSpanSize(90, self._ui.stc_offenceIcon:GetSpanSize().y)
    self._ui.txt_offenceText:SetSpanSize(70, self._ui.txt_offenceText:GetSpanSize().y)
    self._ui.stc_defenceIcon:SetSpanSize(90, self._ui.stc_defenceIcon:GetSpanSize().y)
    self._ui.txt_defenceText:SetSpanSize(70, self._ui.txt_defenceText:GetSpanSize().y)
  end
end
function PaGlobal_SimpleInventory:getNextIndex(isNext, selectIndex)
  local changeIndex = selectIndex
  if true == isNext then
    changeIndex = changeIndex + 1
  else
    changeIndex = changeIndex - 1
  end
  if changeIndex == PaGlobal_SimpleInventory._currentCharacterIndex then
    if true == isNext then
      changeIndex = changeIndex + 1
    else
      changeIndex = changeIndex - 1
    end
  end
  local data = getCharacterDataByIndex(changeIndex, __ePlayerCreateNormal)
  if nil == data then
    return -1
  end
  local removeTime = getCharacterDataRemoveTime(changeIndex, __ePlayerCreateNormal)
  if true == _ContentsGroup_PreSeason and data._characterSeasonType == __eCharacterSeasonType_Season or nil ~= removeTime then
    local index = PaGlobal_SimpleInventory:getNextIndex(isNext, changeIndex)
    return index
  end
  return changeIndex
end
function PaGlobal_SimpleInventory:validate()
  if nil == Panel_Window_SimpleInventory then
    UI.ASSERT_NAME(false, "Panel_Window_SimpleInventory\236\157\180 \235\161\156\235\147\156\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\154\176\236\160\149\235\172\180")
    return
  end
  self._ui._txt_titleBar:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._tabBg:isValidate()
  self._ui._topBg:isValidate()
  self._ui._mainBg:isValidate()
  self._ui._stc_transportItem:isValidate()
  self._ui._stc_transportItemConsole:isValidate()
  self._ui._rdoBtn_inven:isValidate()
  self._ui._rdoBtn_cashInven:isValidate()
  self._ui._stc_keyguideLB:isValidate()
  self._ui._stc_keyguideRB:isValidate()
  self._ui._btn_sortOption:isValidate()
  self._ui._chk_sortButton:isValidate()
  self._ui._txt_money:isValidate()
  self._ui._btn_money:isValidate()
  self._ui._scroll:isValidate()
  self._ui.stc_circle:isValidate()
  self._ui.stc_LifeEquipBg:isValidate()
  self._ui.btn_equipCrystal:isValidate()
  self._ui.stc_blankSlotTooltip:isValidate()
  self._ui.stc_abilityArea:isValidate()
  self._ui.stc_offenceIcon:isValidate()
  self._ui.txt_offenceText:isValidate()
  self._ui.stc_defenceIcon:isValidate()
  self._ui.txt_defenceText:isValidate()
  self._ui.stc_awakenOffenceIcon:isValidate()
  self._ui.txt_awakenOffenceText:isValidate()
  self._ui.stc_shyAwakenIcon:isValidate()
  self._ui.txt_shyAwakenText:isValidate()
  self._ui.txt_selectedCharName:isValidate()
  self._ui.btn_prevChar:isValidate()
  self._ui.btn_nextChar:isValidate()
  self._ui._stc_keyguideLS:isValidate()
  self._ui._stc_keyguideX:isValidate()
  self._ui._stc_keyguideY:isValidate()
  self._ui._stc_keyguideB:isValidate()
  self._ui._stc_keyguideLT:isValidate()
  self._ui._stc_keyguideRT:isValidate()
  self._ui._stc_keyguideRS:isValidate()
  self._ui._stc_keyguideTransport:isValidate()
  self._ui.btn_Combat:isValidate()
  self._ui.btn_Life:isValidate()
end
function PaGlobal_SimpleInventory:searchItem(selectIndex, itemWhereType, slotNo)
  self:requestSimpleInventory(selectIndex)
  self:clearSearchItemInfo(true, true)
  self:clearSearchEquipItemInfo(true, true)
  if CppEnums.ItemWhereType.eEquip == itemWhereType then
    slot = self._equipSlot[slotNo]
    if nil ~= slot then
      table.insert(self._searchItemEquipSlotList, slotNo)
    end
  else
    self._searchItemWhereType = itemWhereType
    table.insert(self._searchItemSlotList, slotNo)
    self:selectInventroy(itemWhereType)
  end
  self:scrollToSearchItem()
  self:updateSearchItemEquip()
  self:updateSearchItem()
end
function PaGlobal_SimpleInventory:searchItemByItemEnchantKey(selectIndex, itemWhereType, itemEnchantKey)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self:requestSimpleInventory(selectIndex)
  self:clearSearchItemInfo(true, true)
  self:clearSearchEquipItemInfo(true, true)
  self._searchItemWhereType = itemWhereType
  self:selectInventroy(itemWhereType)
  for slotNo, slotControl in pairs(self._equipSlot) do
    if nil ~= slotNo and nil ~= slotControl then
      local equipItemWrapper = self._equipWrapper:getSimpleEquipItemWrapper(slotNo)
      if nil ~= equipItemWrapper then
        local equipItemEnchantKey = equipItemWrapper:getItemEnchantKey()
        if itemEnchantKey:getItemKey() == equipItemEnchantKey:getItemKey() and itemEnchantKey:getEnchantLevel() == equipItemEnchantKey:getEnchantLevel() then
          table.insert(self._searchItemEquipSlotList, slotNo)
        end
      end
    end
  end
  for ii = self._currentIndex, self._maxSlotCount do
    local slotNo = ii
    if nil ~= slotNo then
      local itemWrapper = self._invenWrapper:getSimpleItemWrapper(self._itemWhereType, slotNo)
      if nil ~= itemWrapper then
        local inventoryItemEnchantKey = itemWrapper:getItemEnchantKey()
        if itemEnchantKey:getItemKey() == inventoryItemEnchantKey:getItemKey() and itemEnchantKey:getEnchantLevel() == inventoryItemEnchantKey:getEnchantLevel() then
          table.insert(self._searchItemSlotList, ii)
        end
      end
    end
  end
  self:scrollToSearchItem()
  self:updateSearchItem()
  self:updateSearchItemEquip()
end
function PaGlobal_SimpleInventory:scrollToSearchItem()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if self._config._slotRows <= 0 then
    return
  end
  if self._itemWhereType ~= self._searchItemWhereType then
    return
  end
  local slotNo = self._searchItemSlotList[1]
  if nil == slotNo then
    return
  end
  if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.AnotherCharacterInventory) == true then
    slotNo = selfPlayer:get():getSimpleInventorySearchResultSlotNo(slotNo)
    if 0 == slotNo then
      return
    end
  end
  local screenShowCount = self._config._slotRows * self._config._slotCols
  local scrollEndIndex = self._config._inventoryMax - screenShowCount
  local limitEndIndex = math.floor(scrollEndIndex / self._config._slotRows) * self._config._slotRows
  self._currentIndex = math.floor(slotNo / self._config._slotRows) * self._config._slotRows
  self._currentIndex = math.min(limitEndIndex, self._currentIndex)
  self._ui._scroll:SetControlPos(math.min(self._currentIndex / scrollEndIndex, 1))
  self:updateSlot()
end
function PaGlobal_SimpleInventory:updateSearchItem()
  if nil == self._searchItemWhereType then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  self:clearSearchItemInfo(true, false)
  if self._itemWhereType ~= self._searchItemWhereType then
    return
  end
  for key, slotNo in pairs(self._searchItemSlotList) do
    local sortedSlotNo = slotNo
    if PaGlobalFunc_AutoSortFunctionPanel_IsSorted(InvenSortLinkPanelIndex.AnotherCharacterInventory) == true then
      sortedSlotNo = selfPlayer:get():getSimpleInventorySearchResultSlotNo(slotNo)
    end
    local slot = self._slots[sortedSlotNo - self._currentIndex]
    if nil ~= slot then
      slot.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
      slot.icon:SetMonoTone(false)
    end
  end
end
function PaGlobal_SimpleInventory:updateSearchItemEquip()
  if nil == Panel_Window_SimpleInventory then
    return
  end
  self:clearSearchEquipItemInfo(true, false)
  for key, slotNo in pairs(self._searchItemEquipSlotList) do
    if nil ~= slotNo then
      local slotControl = self._equipSlot[slotNo]
      if nil ~= slotControl then
        slotControl.icon:AddEffect("fUI_Tuto_ItemHp_01A", true, 0, 0)
        slotControl.icon:SetMonoTone(false)
      end
    end
  end
end
function PaGlobal_SimpleInventory:clearSearchItemInfo(isMonoTone, isDataClear)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  for ii = 0, self._config._slotCount - 1 do
    local slot = self._slots[ii]
    if nil ~= slot then
      slot.icon:SetMonoTone(isMonoTone)
      slot.icon:EraseAllEffect()
    end
  end
  if true == isDataClear then
    self._searchItemWhereType = nil
    self._searchItemSlotList = {}
  end
end
function PaGlobal_SimpleInventory:clearSearchEquipItemInfo(isMonoTone, isDataClear)
  if nil == Panel_Window_SimpleInventory then
    return
  end
  for ii = self._EquipNoMin, self._EquipNoMax - 1 do
    local slot = self._equipSlot[ii]
    if nil ~= slot then
      slot.icon:SetMonoTone(isMonoTone)
      slot.icon:EraseAllEffect()
    end
  end
  if true == isDataClear then
    self._searchItemEquipSlotList = {}
  end
  PaGlobal_SimpleInventory:updateExtendedSlot()
end
