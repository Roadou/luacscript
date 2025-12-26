function PaGlobal_ServantUpgrade:init()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_close = UI.getChildControl(self._ui._titleBar, "Button_Close")
  local newSlotBg = UI.getChildControl(self._ui._mainBg, "Static_NewShipSlotBG")
  local newSlot = {
    icon = nil,
    name = nil,
    kind = nil
  }
  newSlot.icon = UI.getChildControl(newSlotBg, "Static_NewShipSlotIcon")
  newSlot.name = UI.getChildControl(newSlotBg, "StaticText_TopDesc")
  newSlot.kind = UI.getChildControl(newSlotBg, "StaticText_NewShipKind")
  self._ui._newSlot = newSlot
  self._ui._fromMainItem = Array.new()
  for ii = 0, __eServantUpgradeMainFromItemCount - 1 do
    local slot = {
      bg = nil,
      icon = nil,
      slotIcon = {}
    }
    slot.bg = UI.getChildControl(self._ui._mainBg, "Static_EquipIcon" .. tostring(ii + 1) .. "_BG")
    slot.icon = UI.getChildControl(slot.bg, "Static_ItemSlot")
    SlotItem.new(slot.slotIcon, "MainItemIcon_" .. tostring(ii), ii, slot.icon, self._slotConfig)
    slot.slotIcon:createChild()
    slot.slotIcon.icon:SetPosY(1)
    if true == self._isConsole then
      slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade:itemTooltip_Show(" .. ii .. ")")
    else
      slot.slotIcon.icon:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade:itemTooltip_Show(" .. ii .. ")")
      slot.slotIcon.icon:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade:itemTooltip_Hide()")
    end
    self._ui._fromMainItem[ii] = slot
  end
  self._ui._fromSubItem = Array.new()
  for ii = 0, __eServantUpgradeSubFromItemCount - 1 do
    local slot = {
      bg = nil,
      txt = nil,
      lock = nil,
      slotIcon = {}
    }
    slot.bg = UI.getChildControl(self._ui._mainBg, "Static_MaterialIcon" .. tostring(ii + 1) .. "_BG")
    slot.txt = UI.getChildControl(slot.bg, "StaticText_NeedItemCount")
    slot.lock = UI.getChildControl(slot.bg, "Static_LockIcon")
    SlotItem.new(slot.slotIcon, "SubItemIcon_" .. tostring(ii), ii, slot.bg, self._slotConfig)
    slot.slotIcon:createChild()
    if true == self._isConsole then
      slot.bg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_ServantUpgrade:itemTooltip_Show(" .. __eServantUpgradeMainFromItemCount + ii .. ")")
    else
      slot.slotIcon.icon:addInputEvent("Mouse_On", "PaGlobal_ServantUpgrade:itemTooltip_Show(" .. __eServantUpgradeMainFromItemCount + ii .. ")")
      slot.slotIcon.icon:addInputEvent("Mouse_Out", "PaGlobal_ServantUpgrade:itemTooltip_Hide()")
    end
    self._ui._fromSubItem[ii] = slot
  end
  self._ui._btn_prev = UI.getChildControl(self._ui._mainBg, "Button_DecoArroW_L")
  self._ui._btn_next = UI.getChildControl(self._ui._mainBg, "Button_DecoArrow_R")
  self._ui._txt_index = UI.getChildControl(self._ui._mainBg, "StaticText_SlotCount")
  self._ui._btn_upgradeInfo = UI.getChildControl(self._ui._mainBg, "Button_AdditionalInfo")
  self._ui._txt_ready = UI.getChildControl(self._ui._stateBg, "StaticText_ReadytoTry")
  self._ui._txt_notReady = UI.getChildControl(self._ui._stateBg, "StaticText_NotReadyyet")
  self._ui._txt_preview = UI.getChildControl(self._ui._stateBg, "StaticText_Preview")
  self._ui._progressBar = UI.getChildControl(self._ui._progressGroup, "Progress2_2")
  self._ui._txt_progressPct = UI.getChildControl(self._ui._progressGroup, "StaticText_Percent")
  self._ui._bigCircle = UI.getChildControl(self._ui._progressGroup, "Static_BigCircle")
  self._ui._smallCircle = UI.getChildControl(self._ui._progressGroup, "Static_SmallCircle")
  self._ui._txt_desc = UI.getChildControl(Panel_Window_ServantUpgrade, "StaticText_Desc")
  local origin_descY = self._ui._txt_desc:GetSizeY()
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SHIPINFO_EXTEND_INFOSTRING"))
  local gapY = 5
  if origin_descY < self._ui._txt_desc:GetTextSizeY() + gapY then
    local addSizeY = self._ui._txt_desc:GetTextSizeY() + gapY - origin_descY
    self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), origin_descY + addSizeY)
    Panel_Window_ServantUpgrade:SetSize(Panel_Window_ServantUpgrade:GetSizeX(), Panel_Window_ServantUpgrade:GetSizeY() + addSizeY)
    self._ui._txt_desc:ComputePos()
    self._ui._btn_doUpgrade:ComputePos()
    self._ui._btn_shipTree:ComputePos()
    self._ui._btn_webGuide:ComputePos()
  end
  local progressSlot = {
    icon = nil,
    name = nil,
    kind = nil
  }
  progressSlot.icon = UI.getChildControl(self._ui._progressBg, "Static_NewShipSlotIcon")
  progressSlot.name = UI.getChildControl(self._ui._progressBg, "StaticText_TopDesc")
  progressSlot.kind = UI.getChildControl(self._ui._progressBg, "StaticText_NewShipKind")
  self._ui._progressSlot = progressSlot
  self._ui._stc_keyGuideLB = UI.getChildControl(self._ui._mainBg, "StaticText_LB_ConsoleUI")
  self._ui._stc_keyGuideRB = UI.getChildControl(self._ui._mainBg, "StaticText_RB_ConsoleUI")
  self._ui._stc_keyGuideX = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_X_ConsoleUI")
  self._ui._stc_keyGuideY = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_Y_ConsoleUI")
  self._ui._stc_keyGuideLTA = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_A_ConsoleUI")
  self._ui._stc_keyGuideB = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_B_ConsoleUI")
  self._ui._stc_keyGuideLTY = UI.getChildControl(self._ui._stc_keyGuideBG, "StaticText_KeyGuideLTY_Console")
  self:setConsoleUI()
  self:registEventHandler()
end
function PaGlobal_ServantUpgrade:setConsoleUI()
  if nil == Panel_Window_ServantUpgrade then
    return
  end
  if true == self._isConsole then
    self._ui._btn_close:SetShow(false)
    self._ui._btn_doUpgrade:SetShow(false)
    self._ui._btn_cancel:SetShow(false)
    self._ui._btn_shipTree:SetShow(false)
    self._ui._btn_upgradeInfo:SetShow(false)
    self._ui._btn_prev:SetShow(false)
    self._ui._btn_next:SetShow(false)
    self._ui._stc_keyGuideBG:SetShow(true)
    self._ui._stc_keyGuideLB:SetShow(true)
    self._ui._stc_keyGuideRB:SetShow(true)
    self._ui._stc_keyGuideLTY:SetShow(true)
    Panel_Window_ServantUpgrade:SetSize(Panel_Window_ServantUpgrade:GetSizeX(), Panel_Window_ServantUpgrade:GetSizeY() - self._ui._btn_doUpgrade:GetSizeY() - 10)
    self._ui._btn_webGuide:SetSpanSize(0, 10)
    self._ui._btn_webGuide:ComputePos()
    self:alignKeyGuide()
  else
    self._ui._btn_close:SetShow(true)
    self._ui._btn_doUpgrade:SetShow(true)
    self._ui._btn_shipTree:SetShow(true)
    self._ui._btn_upgradeInfo:SetShow(true)
    self._ui._btn_prev:SetShow(true)
    self._ui._btn_next:SetShow(true)
    self._ui._btn_webGuide:SetSpanSize(0, 10)
    self._ui._btn_webGuide:ComputePos()
    self._ui._stc_keyGuideBG:SetShow(false)
    self._ui._stc_keyGuideLB:SetShow(false)
    self._ui._stc_keyGuideRB:SetShow(false)
    self._ui._stc_keyGuideLTY:SetShow(false)
  end
end
function PaGlobal_ServantUpgrade:alignKeyGuide()
  local keyGuide = {
    self._ui._stc_keyGuideLTY,
    self._ui._stc_keyGuideX,
    self._ui._stc_keyGuideY,
    self._ui._stc_keyGuideLTA,
    self._ui._stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ServantUpgrade:registEventHandler()
  if true == self._isConsole then
    Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_LB, "PaGlobal_ServantUpgrade:handleClickedPrevButton()")
    Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_RB, "PaGlobal_ServantUpgrade:handleClickedNextButton()")
    Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_ServantUpgrade:handleClickedUpgradeInfoButton()")
    Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_ServantUpgrade:doServantUpgrade()")
    Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_ServantUpgrade_handleClickedViewTree(6789)")
    self._ui._btn_webGuide:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantUpgrade_handleClickedWebGuide()")
  else
    self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantUpgrade_Cancel()")
    self._ui._btn_doUpgrade:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:doServantUpgrade()")
    self._ui._btn_shipTree:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantUpgrade_handleClickedViewTree(6789)")
    self._ui._btn_prev:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:handleClickedPrevButton()")
    self._ui._btn_next:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:handleClickedNextButton()")
    self._ui._btn_upgradeInfo:addInputEvent("Mouse_LUp", "PaGlobal_ServantUpgrade:handleClickedUpgradeInfoButton()")
    self._ui._btn_webGuide:addInputEvent("Mouse_LUp", "HandleEventLUp_ServantUpgrade_handleClickedWebGuide()")
  end
end
function PaGlobal_ServantUpgrade:clear()
  self._servantNo_s64 = nil
  self._fromCharacterKey = nil
  self._toCharacterKey = nil
  self._toCharacterKeyList = nil
  self._selectIndex = 0
  self._maxIndex = 0
  self._isUpgradable = true
  ToClient_clearServantUpgradeSlotNoList()
  self:cancelClear()
  self._ui._bigCircle:SetVertexAniRun("Ani_Rotate_New", false)
  self._ui._smallCircle:SetVertexAniRun("Ani_Rotate_New", false)
end
function PaGlobal_ServantUpgrade:cancelClear()
  self._updateCurrentTime = 0
  self._isProgressing = false
  self._ui._txt_progressPct:SetText("")
  self._ui._progressBar:SetProgressRate(0)
  self._ui._mainBg:SetShow(true)
  self._ui._stateBg:SetShow(true)
  self._ui._txt_index:SetShow(true)
  self._ui._progressGroup:SetShow(false)
  self._ui._progressBg:SetShow(false)
  self:selectIndex(self._selectIndex)
end
function PaGlobal_ServantUpgrade:open(fromCharacterKey, isInWharf, index)
  local pageIndex = index or 0
  if false == _ContentsGroup_Barter then
    return
  end
  if true == Panel_Window_ServantUpgrade:GetShow() then
    return
  end
  local characterSSW = ToClient_GetCharacterStaticStatusWrapper(fromCharacterKey)
  if nil == characterSSW then
    return
  end
  self:clear()
  self._isInWharf = isInWharf
  self._fromCharacterKey = fromCharacterKey
  self._toCharacterKeyList = ToClient_servantUpgradeCharacterKeyList(self._fromCharacterKey)
  if nil == self._toCharacterKeyList then
    return
  end
  self._maxIndex = #self._toCharacterKeyList
  if dialog_getTalker() ~= nil then
    self._myShipInfo = PaGlobalFunc_ServantList_All_GetSealedTypeServantInfo()
  elseif _ContentsGroup_EmployeePresetJob == true and PaGlobal_ShipInfo_Renewal_All_GetShowPanel() == true then
    self._myShipInfo = getServantInfoFromActorKey(PaGlobal_ShipInfo_Renewal_All._actorKeyRaw)
  elseif Panel_Window_ShipInfo_All:GetShow() == true then
    self._myShipInfo = getServantInfoFromActorKey(PaGlobal_ShipInfo_All._actorKeyRaw)
  end
  if self._myShipInfo == nil then
    return
  end
  self:selectIndex(pageIndex)
  PaGlobal_ServantUpgrade:checkServantUpgrade(self._myShipInfo:getCharacterKeyRaw(), self._selectIndex)
  if true == Panel_Dialog_ServantExtension_All_Tree:GetShow() then
    PaGlobal_ServantUpgrade_Tree_Close()
  end
  self:updateShowShipTreeButton()
  Panel_Window_ServantUpgrade:ignorePadSnapMoveToOtherPanel()
  Panel_Window_ServantUpgrade:SetShow(true)
end
function PaGlobal_ServantUpgrade:close()
  PaGlobal_ServantUpgradeInfo:close()
  PaGlobal_ServantUpgrade:itemTooltip_Hide()
  Panel_Window_ServantUpgrade:ClearUpdateLuaFunc("Update_ServantUpgrade_ProgressBar")
  Panel_Window_ServantUpgrade:SetShow(false)
end
function PaGlobal_ServantUpgrade:doServantUpgrade()
  if true == self._isProgressing then
    return
  end
  if nli == self._servantNo_s64 then
    return
  end
  if false == self._isUpgradable then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoInventoryNotEnoughItem"))
    return
  end
  if 0 < ToClient_GetEmployeeCountByServant(self._servantNo_s64) then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantServantUpgradeEmployee"))
    return
  end
  self._npcType = PaGlobalFunc_ServantFunction_All_Get_NpcType()
  local servantInfo
  if self._npcType == 2 then
    servantInfo = stable_getServantByServantNo(self._servantNo_s64)
    self._npcType = __eStableNpcType_SEA
  elseif self._npcType == 3 then
    servantInfo = guildStable_getServantByServantNo(self._servantNo_s64)
    self._npcType = __eStableNpcType_GUILD_SEA
  end
  if servantInfo == nil then
    return
  end
  local equipSlotNo = {}
  if _ContentsGroup_EmployeePresetJob == true then
    equipSlotNo = PaGlobal_ShipInfo_Renewal_All._equipSlotNo
  else
    equipSlotNo = PaGlobal_ShipInfo_All._equipSlotNo
  end
  for _, v in pairs(equipSlotNo) do
    local itemWrapper = servantInfo:getEquipItem(v)
    if nil ~= itemWrapper then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoExistItemInVehicle"))
      return
    end
  end
  self._ui._mainBg:SetShow(false)
  self._ui._stateBg:SetShow(false)
  if true == self._isConsole then
    self._ui._stc_keyGuideLB:SetShow(false)
    self._ui._stc_keyGuideRB:SetShow(false)
  else
    self._ui._btn_prev:SetShow(false)
    self._ui._btn_next:SetShow(false)
  end
  self._ui._txt_index:SetShow(false)
  self._ui._progressGroup:SetShow(true)
  self._ui._progressBg:SetShow(true)
  self._ui._bigCircle:SetVertexAniRun("Ani_Rotate_New", true)
  self._ui._smallCircle:SetVertexAniRun("Ani_Rotate_New", true)
  self._isProgressing = true
  Panel_Window_ServantUpgrade:RegisterUpdateFunc("Update_ServantUpgrade_ProgressBar")
end
function PaGlobal_ServantUpgrade:progressBarUpdateComplete()
  Panel_Window_ServantUpgrade:ClearUpdateLuaFunc("Update_ServantUpgrade_ProgressBar")
  self._isProgressing = false
  self:close()
  ToClient_requestServantUpgrade(self._servantNo_s64, self._toCharacterKey, self._npcType)
end
function PaGlobal_ServantUpgrade:selectToServant(toCharacterKey)
  self._toCharacterKey = nil
  self._isUpgradable = true
  local characterSSW = ToClient_GetCharacterStaticStatusWrapper(toCharacterKey)
  if nil == characterSSW then
    return
  end
  local servantUpgradeWrapper = ToClient_ServantUpgradeStaticStatusWrapper(self._fromCharacterKey, toCharacterKey)
  if nil == servantUpgradeWrapper then
    return
  end
  local toWrapper = ToClient_FormStaticStatusWrapper(toCharacterKey)
  if nil ~= toWrapper then
    self._ui._newSlot.icon:ChangeTextureInfoNameAsync(toWrapper:getIcon1())
    self._ui._progressSlot.icon:ChangeTextureInfoNameAsync(toWrapper:getIcon1())
  end
  for ii = 0, __eServantUpgradeMainFromItemCount - 1 do
    self._ui._fromMainItem[ii].slotIcon.icon:SetMonoTone(false, false)
    local itemEnchantKey = servantUpgradeWrapper:getFromItemEnchantKey(ii)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemSSW then
      self._ui._fromMainItem[ii].slotIcon:setItemByStaticStatus(itemSSW)
      local slotNo = ToClient_InventoryGetSlotNo(itemEnchantKey)
      if __eTInventorySlotNoUndefined == slotNo then
        self._ui._fromMainItem[ii].slotIcon.icon:SetMonoTone(true, true)
        self._isUpgradable = false
      else
        ToClient_setServantUpgradeSlotNo(ii, slotNo)
      end
    end
  end
  for ii = 0, __eServantUpgradeSubFromItemCount - 1 do
    local index = __eServantUpgradeMainFromItemCount + ii
    self._ui._fromSubItem[ii].slotIcon.icon:SetMonoTone(true, true)
    local itemEnchantKey = servantUpgradeWrapper:getFromItemEnchantKey(index)
    local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
    if nil ~= itemSSW then
      local needItemCount_s64 = servantUpgradeWrapper:getFromItemCount(index)
      local myItemCount_s64 = toInt64(0, 0)
      self._ui._fromSubItem[ii].slotIcon:setItemByStaticStatus(itemSSW)
      local slotNo = ToClient_InventoryGetSlotNo(itemEnchantKey)
      if __eTInventorySlotNoUndefined ~= slotNo then
        local itemWrapper = getInventoryItem(slotNo)
        if nil ~= itemWrapper and false == itemWrapper:empty() then
          myItemCount_s64 = itemWrapper:getCount()
          if needItemCount_s64 <= myItemCount_s64 then
            self._ui._fromSubItem[ii].slotIcon.icon:SetMonoTone(false, false)
            ToClient_setServantUpgradeSlotNo(index, slotNo)
            myItemCount_s64 = needItemCount_s64
          else
            self._isUpgradable = false
          end
        else
          self._isUpgradable = false
        end
      else
        self._isUpgradable = false
      end
      if needItemCount_s64 <= myItemCount_s64 then
        self._ui._fromSubItem[ii].txt:SetFontColor(Defines.Color.C_FF83A543)
      else
        self._ui._fromSubItem[ii].txt:SetFontColor(Defines.Color.C_FFD05D48)
      end
      self._ui._fromSubItem[ii].txt:SetText(tostring(myItemCount_s64) .. "/" .. tostring(needItemCount_s64))
      self._ui._fromSubItem[ii].lock:SetShow(false)
    else
      self._ui._fromSubItem[ii].txt:SetText("")
      self._ui._fromSubItem[ii].slotIcon:clearItem()
      self._ui._fromSubItem[ii].lock:SetShow(true)
    end
  end
  if true == self._isConsole then
    self._ui._btn_doUpgrade:SetShow(false)
  end
  self._ui._btn_shipTree:ComputePos()
  self._toCharacterKey = toCharacterKey
  self._ui._newSlot.kind:SetText(characterSSW:getName())
  self._ui._progressSlot.kind:SetText(characterSSW:getName())
end
function PaGlobal_ServantUpgrade:updateShowShipTreeButton()
  if Panel_Window_ServantUpgrade == nil then
    return
  end
  if self._isConsole == true then
    return
  end
  if self._myShipInfo == nil then
    self._ui._btn_shipTree:SetShow(true)
    return
  end
  if self._myShipInfo:getVehicleType() == __eVehicleType_GalleyShip then
    self._ui._btn_shipTree:SetShow(false)
    self._ui._btn_doUpgrade:SetSize(Panel_Window_ServantUpgrade:GetSizeX() - 20, self._ui._btn_doUpgrade:GetSizeY())
  else
    self._ui._btn_shipTree:SetShow(true)
    self._ui._btn_doUpgrade:SetSize((Panel_Window_ServantUpgrade:GetSizeX() - 20) / 2, self._ui._btn_doUpgrade:GetSizeY())
  end
end
function PaGlobal_ServantUpgrade:itemTooltip_Show(index)
  local servantUpgradeWrapper = ToClient_ServantUpgradeStaticStatusWrapper(self._fromCharacterKey, self._toCharacterKey)
  if nil == servantUpgradeWrapper then
    return
  end
  local itemSSW = getItemEnchantStaticStatus(servantUpgradeWrapper:getFromItemEnchantKey(index))
  if nil ~= itemSSW then
    local control
    if index < __eServantUpgradeMainFromItemCount then
      control = self._ui._fromMainItem[index].icon
    else
      control = self._ui._fromSubItem[index - __eServantUpgradeMainFromItemCount].slotIcon.icon
    end
    if nil ~= control then
      if true == _ContentsGroup_RenewUI then
        if nil ~= PaGlobalFunc_TooltipInfo_GetShow and true == PaGlobalFunc_TooltipInfo_GetShow() then
          PaGlobalFunc_TooltipInfo_Close()
          return
        end
        PaGlobalFunc_TooltipInfo_Open(Defines.TooltipDataType.ItemSSWrapper, itemSSW, Defines.TooltipTargetType.Item, 0, getScreenSizeX())
      else
        if true == self._isConsole and true == Panel_Tooltup_Item_isShow() then
          Panel_Tooltip_Item_hideTooltip()
          return
        end
        Panel_Tooltip_Item_Show(itemSSW, control, true)
      end
    end
  end
end
function PaGlobal_ServantUpgrade:itemTooltip_Hide()
  if true == _ContentsGroup_RenewUI then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
function PaGlobal_ServantUpgrade:selectIndex(index)
  if nil == self._toCharacterKeyList then
    return
  end
  if index < 0 or index > #self._toCharacterKeyList then
    return
  end
  self._selectIndex = index
  self:selectToServant(self._toCharacterKeyList[self._selectIndex]:get())
  self._ui._txt_index:SetText(tostring(self._selectIndex + 1) .. "/" .. tostring(self._maxIndex + 1))
  local leftControl = self._ui._btn_prev
  local rightControl = self._ui._btn_next
  if true == self._isConsole then
    leftControl = self._ui._stc_keyGuideLB
    rightControl = self._ui._stc_keyGuideRB
  end
  if self._maxIndex == 0 then
    leftControl:SetShow(false)
    rightControl:SetShow(false)
  elseif index <= 0 then
    leftControl:SetShow(false)
    rightControl:SetShow(true)
  elseif index >= self._maxIndex then
    leftControl:SetShow(true)
    rightControl:SetShow(false)
  else
    leftControl:SetShow(true)
    rightControl:SetShow(true)
  end
  if true == Panel_Window_ServantUpgradeInfo:GetShow() then
    PaGlobal_ServantUpgrade:openServantUpgradeInfo()
  end
end
function PaGlobal_ServantUpgrade:handleClickedPrevButton()
  local index = self._selectIndex - 1
  if index < 0 then
    index = 0
  end
  self:selectIndex(index)
  PaGlobal_ServantUpgrade:checkServantUpgrade(self._myShipInfo:getCharacterKeyRaw(), index)
end
function PaGlobal_ServantUpgrade:handleClickedNextButton()
  local index = self._selectIndex + 1
  if index > self._maxIndex then
    index = self._maxIndex
  end
  self:selectIndex(index)
  PaGlobal_ServantUpgrade:checkServantUpgrade(self._myShipInfo:getCharacterKeyRaw(), index)
end
function HandleEventLUp_ServantUpgrade_handleClickedViewTree(key)
  local self = PaGlobal_ServantUpgrade
  if Panel_Window_ServantUpgrade ~= nil and Panel_Window_ServantUpgrade:GetShow() == true then
    PaGlobal_ServantUpgrade_Close()
  end
  PaGlobal_ServantUpgrade_Tree:open(self._fromCharacterKey, self._toCharacterKey, self._isInWharf)
end
function PaGlobal_ServantUpgrade:handleClickedUpgradeInfoButton()
  if false == Panel_Window_ServantUpgradeInfo:GetShow() then
    PaGlobal_ServantUpgrade:openServantUpgradeInfo()
  else
    PaGlobal_ServantUpgradeInfo:close()
  end
end
function PaGlobal_ServantUpgrade:checkServantUpgrade(fromKey, index)
  local canUpgrade = false
  if dialog_getTalker() ~= nil then
    local servantUpgradeWrapper = ToClient_ServantUpgradeStaticStatusWrapper(fromKey, self._toCharacterKeyList[index]:get())
    if servantUpgradeWrapper ~= nil then
      canUpgrade = true
    end
  end
  if canUpgrade == true then
    if self._isConsole == false then
      self._ui._btn_doUpgrade:SetShow(true)
      if self._isUpgradable == false then
        self._ui._btn_doUpgrade:SetMonoTone(true)
      else
        self._ui._btn_doUpgrade:SetMonoTone(false)
      end
    elseif self._isConsole == true then
      Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "PaGlobal_ServantUpgrade:doServantUpgrade()")
      self._ui._stc_keyGuideLTA:SetShow(true)
      local keyGuide = {
        self._ui._stc_keyGuideLTY,
        self._ui._stc_keyGuideX,
        self._ui._stc_keyGuideY,
        self._ui._stc_keyGuideLTA,
        self._ui._stc_keyGuideB
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
    self._servantNo_s64 = self._myShipInfo:getServantNo()
    self._ui._newSlot.name:SetText(self._myShipInfo:getName())
    self._ui._progressSlot.name:SetText(self._myShipInfo:getName())
    self._ui._txt_preview:SetShow(false)
    self._ui._btn_shipTree:SetSize(210, 50)
    self._ui._btn_shipTree:SetHorizonLeft()
    self._ui._btn_shipTree:SetSpanSize(230, 70)
    if self._isUpgradable == false then
      self._ui._txt_ready:SetShow(false)
      self._ui._txt_notReady:SetShow(true)
    else
      self._ui._txt_ready:SetShow(true)
      self._ui._txt_notReady:SetShow(false)
    end
  else
    if self._isConsole == false then
      self._ui._btn_doUpgrade:SetShow(false)
    elseif self._isConsole == true then
      Panel_Window_ServantUpgrade:registerPadEvent(__eConsoleUIPadEvent_LTPress_A, "")
      self._ui._stc_keyGuideLTA:SetShow(false)
      local keyGuide = {
        self._ui._stc_keyGuideLTY,
        self._ui._stc_keyGuideX,
        self._ui._stc_keyGuideY,
        self._ui._stc_keyGuideB
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_keyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    end
    self._servantNo_s64 = nil
    self._ui._txt_preview:SetShow(true)
    self._ui._txt_ready:SetShow(false)
    self._ui._txt_notReady:SetShow(false)
    self._ui._btn_shipTree:SetSize(430, 50)
    self._ui._btn_shipTree:SetHorizonCenter()
    self._ui._btn_shipTree:SetSpanSize(0, 70)
  end
end
function PaGlobal_ServantUpgrade:openServantUpgradeInfo()
  if self._myShipInfo ~= nil then
    PaGlobal_ServantUpgradeInfo:open(self._myShipInfo:getCharacterKeyRaw(), self._toCharacterKey)
  end
end
