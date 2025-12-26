function PaGlobal_Restore_All:initialize()
  if true == PaGlobal_Restore_All._initialize then
    return
  end
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  self._isConsole = ToClient_isConsole()
  local stc_title = UI.getChildControl(Panel_Window_Restore_All, "Static_Title")
  self._ui._btn_close = UI.getChildControl(stc_title, "Button_Close")
  self._ui._stc_restoreNum = UI.getChildControl(Panel_Window_Restore_All, "StaticText_RestoreNum")
  self._ui._btn_buyItem = UI.getChildControl(Panel_Window_Restore_All, "Button_BuyItem")
  self._ui._btn_restore = UI.getChildControl(Panel_Window_Restore_All, "Button_Restore")
  self._ui._list2_item = UI.getChildControl(Panel_Window_Restore_All, "List2_Item")
  self._ui._list2_jewel = UI.getChildControl(Panel_Window_Restore_All, "List2_Crystal")
  self._ui._btn_radioBtnBg = UI.getChildControl(Panel_Window_Restore_All, "Static_RadioButtonBg")
  self._ui._btn_normal = UI.getChildControl(self._ui._btn_radioBtnBg, "RadioButton_Normal")
  self._ui._btn_jewel = UI.getChildControl(self._ui._btn_radioBtnBg, "RadioButton_Crystal")
  self._ui._stc_selectbar = UI.getChildControl(self._ui._btn_radioBtnBg, "Static_SelectBar")
  self._ui._stc_subFrameBg = UI.getChildControl(Panel_Window_Restore_All, "Static_SubFrameBg")
  local slot = {}
  local list2_content = UI.getChildControl(self._ui._list2_item, "List2_1_Content")
  local list2_btn_radio = UI.getChildControl(list2_content, "RadioButton_Item")
  local list2_itemslot = UI.getChildControl(list2_btn_radio, "Static_ItemSlot")
  SlotItem.new(slot, "Restore_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:createChild()
  list2_content = UI.getChildControl(self._ui._list2_jewel, "List2_1_Content")
  list2_btn_radio = UI.getChildControl(list2_content, "RadioButton_Item")
  for i = 1, __eJewelDestroyMaxCount do
    local list2_jewelslot = UI.getChildControl(list2_btn_radio, "Static_ItemSlot_" .. i .. "")
    local jewelSlot = {}
    SlotItem.new(jewelSlot, "Restore_Slot_Icon_", i, list2_jewelslot, self._slotConfig)
    jewelSlot:createChild()
  end
  self._ui._stc_descBg = UI.getChildControl(Panel_Window_Restore_All, "Static_DescBg")
  self._ui._stc_txtDescItem = UI.getChildControl(self._ui._stc_descBg, "StaticText_Desc")
  self._ui._stc_txtDescJewel = UI.getChildControl(self._ui._stc_descBg, "StaticText_Desc_JewelRestore")
  self._ui_console._stc_keyGuideBg = UI.getChildControl(Panel_Window_Restore_All, "Static_KeyGuide_ConsoleUI")
  self._ui_console._stc_keyGuideA = UI.getChildControl(self._ui_console._stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui_console._stc_keyGuideB = UI.getChildControl(self._ui_console._stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui_console._stc_keyGuideX = UI.getChildControl(self._ui_console._stc_keyGuideBg, "StaticText_X_ConsoleUI")
  self._ui_console._stc_lbConsole = UI.getChildControl(self._ui._btn_radioBtnBg, "Static_LB_ConsoleUI")
  self._ui_console._stc_rbConsole = UI.getChildControl(self._ui._btn_radioBtnBg, "Static_RB_ConsoleUI")
  local policyDesc = ""
  if isGameTypeNA() then
    policyDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POLICY_DESC_EN", "periodTime", __eRestoreItemPeriodTime, "maxCount", __eMaxRestoreItemCount, "resetDay", 1)
  else
    policyDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POLICY_DESC", "periodTime", __eRestoreItemPeriodTime, "maxCount", __eMaxRestoreItemCount, "resetDay", 1)
  end
  self._ui._stc_txtDescItem:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_txtDescItem:SetText(policyDesc)
  policyDesc = PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESTORATION_TOOLTIPDESC")
  self._ui._stc_txtDescJewel:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_txtDescJewel:SetText(policyDesc)
  self._originStcDescBgSizeY = self._ui._stc_descBg:GetSizeY()
  self._originStcSubFrameBg = self._ui._stc_subFrameBg:GetSizeY()
  self._originPanelSizeY = Panel_Window_Restore_All:GetSizeY()
  if self._originStcDescBgSizeY < self._ui._stc_txtDescItem:GetTextSizeY() + 5 then
    self._addItemDescSizeY = self._ui._stc_txtDescItem:GetTextSizeY() + 5 - self._originStcDescBgSizeY
  else
    self._addItemDescSizeY = 0
  end
  if self._originStcDescBgSizeY < self._ui._stc_txtDescJewel:GetTextSizeY() + 5 then
    self._addJewelDescSizeY = self._ui._stc_txtDescJewel:GetTextSizeY() + 5 - self._originStcDescBgSizeY
  else
    self._addJewelDescSizeY = 0
  end
  self._ui._stc_subFrameBg:ComputePos()
  self._ui._stc_descBg:ComputePos()
  self._ui._stc_txtDescItem:ComputePos()
  self._ui._stc_txtDescJewel:ComputePos()
  PaGlobal_Restore_All:registEventHandler()
  PaGlobal_Restore_All:validate()
  PaGlobal_Restore_All:controlSetShow()
  PaGlobal_Restore_All:consoleSetting()
  PaGlobal_Restore_All._initialize = true
end
function PaGlobal_Restore_All:registEventHandler()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._ui._list2_item:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Restore_All_CreateListControl")
  self._ui._list2_item:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._list2_jewel:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_Restore_All_CreateJewelListControl")
  self._ui._list2_jewel:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Close()")
  self._ui._btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_RestoreItem()")
  self._ui._btn_normal:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_SelectRestoreCategory(" .. self._restoreCategoryTable.__eItem .. ")")
  self._ui._btn_jewel:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_SelectRestoreCategory(" .. self._restoreCategoryTable.__eJewel .. ")")
  self._ui._btn_buyItem:addInputEvent("Mouse_LUp", "PaGlobalFunc_EasyBuy_Open(127)")
  registerEvent("FromClient_Restore_All_UpdateList", "FromClient_Restore_All_UpdateList")
  registerEvent("FromClient_Restore_All_UpdateInfo", "FromClient_Restore_All_UpdateInfo")
  registerEvent("FromClient_Restore_All_ChangedRestoreReq", "FromClient_Restore_All_ChangedRestoreReq")
  registerEvent("FromClient_Restore_All_UpdateJewelList", "FromClient_Restore_All_UpdateJewelList")
  registerEvent("FromClient_RestoreJewelByItemRestoration", "FromClient_RestoreJewelByItemRestoration")
  if self._isPadSnapping then
    registerEvent("onScreenResize", "FromClient_Restore_All_Reposition")
    Panel_Window_Restore_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_Restore_All_SetUpperTab(-1)")
    Panel_Window_Restore_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_Restore_All_SetUpperTab(1)")
  end
end
function PaGlobal_Restore_All:prepareOpen(restoreType)
  if nil == Panel_Window_Restore_All then
    return
  end
  local invenCheck = false
  if true == _ContentsGroup_NewUI_Inventory_All then
    invenCheck = Panel_Window_Inventory_All:IsShow() and Panel_Window_Inventory_All:IsUISubApp()
  else
    invenCheck = Panel_Window_Inventory:IsShow() and Panel_Window_Inventory:IsUISubApp()
  end
  if true == invenCheck then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RESTORE_ITEM_DO_NOT_USE"))
    return
  end
  self._restoreType = restoreType
  self._selectSlotNo = nil
  self._currentTab = 0
  self._ui._btn_normal:SetCheck(true)
  self._ui._btn_jewel:SetCheck(false)
  self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), self._originStcDescBgSizeY + self._addItemDescSizeY)
  self._ui._stc_subFrameBg:SetSize(self._ui._stc_subFrameBg:GetSizeX(), self._originStcSubFrameBg + self._addItemDescSizeY)
  Panel_Window_Restore_All:SetSize(Panel_Window_Restore_All:GetSizeX(), self._originPanelSizeY + self._addItemDescSizeY)
  self._ui._list2_item:GetVScroll():SetControlPos(0)
  self._ui._list2_item:setMinScrollBtnSize(float2(5, 50))
  self._ui._list2_jewel:GetVScroll():SetControlPos(0)
  self._ui._list2_jewel:setMinScrollBtnSize(float2(5, 50))
  self._ui._btn_restore:SetIgnore(true)
  self._ui._btn_restore:SetMonoTone(true)
  self:updateInfo(self._restoreCategoryTable.__eItem)
  if _ContentsGroup_CrystalRestore == false then
    local RadioButtonBg = UI.getChildControl(Panel_Window_Restore_All, "Static_RadioButtonBg")
    RadioButtonBg:SetShow(false)
  else
    ToClient_RequestJewelDestroyedList()
  end
  ToClient_RequestRestoreItemList(self._restoreType)
  ToClient_RequestResetRestoreItemUserInfo(self._restoreType)
  self:reposition()
  PaGlobal_Restore_All:open()
end
function PaGlobal_Restore_All:open()
  if nil == Panel_Window_Restore_All then
    return
  end
  Panel_Window_Restore_All:SetShow(true)
end
function PaGlobal_Restore_All:prepareClose()
  if nil == Panel_Window_Restore_All then
    return
  end
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
  PaGlobal_Restore_All:close()
end
function PaGlobal_Restore_All:close()
  if nil == Panel_Window_Restore_All then
    return
  end
  Panel_Window_Restore_All:SetShow(false)
end
function PaGlobal_Restore_All:validate()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._ui._btn_close:isValidate()
  self._ui._stc_restoreNum:isValidate()
  self._ui._btn_buyItem:isValidate()
  self._ui._btn_restore:isValidate()
  self._ui._list2_item:isValidate()
  self._ui._stc_selectbar:isValidate()
  self._ui._btn_normal:isValidate()
  self._ui._btn_jewel:isValidate()
  self._ui._stc_descBg:isValidate()
  self._ui._stc_txtDescItem:isValidate()
  self._ui._stc_txtDescJewel:isValidate()
  self._ui._stc_subFrameBg:isValidate()
  self._ui_console._stc_keyGuideBg:isValidate()
  self._ui_console._stc_keyGuideA:isValidate()
  self._ui_console._stc_keyGuideB:isValidate()
  self._ui_console._stc_keyGuideX:isValidate()
  self._ui_console._stc_lbConsole:isValidate()
  self._ui_console._stc_rbConsole:isValidate()
end
function PaGlobal_Restore_All:controlSetShow()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._ui._btn_close:SetShow(not self._isPadSnapping)
  self._ui._btn_restore:SetShow(not self._isPadSnapping)
  self._ui._btn_buyItem:SetShow(false)
  self._ui_console._stc_keyGuideBg:SetShow(self._isPadSnapping)
  self._ui_console._stc_lbConsole:SetShow(self._isPadSnapping)
  self._ui_console._stc_rbConsole:SetShow(self._isPadSnapping)
end
function PaGlobal_Restore_All:updateList()
  if nil == Panel_Window_Restore_All then
    return
  end
  if nil == self._ui._list2_item:getElementManager() then
    return
  end
  self._ui._list2_item:getElementManager():clearKey()
  self:setList()
end
function PaGlobal_Restore_All:updateJewelList()
  if nil == Panel_Window_Restore_All then
    return
  end
  if nil == self._ui._list2_jewel:getElementManager() then
    return
  end
  self._ui._list2_jewel:getElementManager():clearKey()
  self:setJewelList()
end
function PaGlobal_Restore_All:updateInfo(restoreCategory)
  if nil == Panel_Window_Restore_All then
    return
  end
  local restoreCount = 0
  local restoreCountString = ""
  if restoreCategory == self._restoreCategoryTable.__eItem then
    restoreCount = ToClient_GetItemRestorationLimitCount(self._restoreType)
    restoreCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_LIMIT_COUNT", "count", restoreCount, "maxCount", __eMaxRestoreItemCount)
    self._ui._btn_buyItem:SetShow(false)
  elseif restoreCategory == self._restoreCategoryTable.__eJewel then
    restoreCount = ToClient_GetJewelRestorationCount()
    local jewelRestoreMaxCount = ToClient_GetJewelRestorationMaxCount()
    restoreCountString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_LIMIT_COUNT", "count", restoreCount, "maxCount", jewelRestoreMaxCount)
    self._ui._btn_buyItem:SetShow(true)
  else
    UI.ASSERT_NAME(false, "\235\179\181\234\181\172 \236\185\180\237\133\140\234\179\160\235\166\172\234\176\128 \236\182\148\234\176\128\235\144\152\235\169\180 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
  end
  self._ui._stc_restoreNum:SetText(restoreCountString)
  self._ui._stc_restoreNum:SetSize(self._ui._stc_restoreNum:GetTextSizeX(), 20)
  self._ui._stc_restoreNum:ComputePos()
  self._ui._btn_buyItem:ComputePos()
  self._ui._btn_buyItem:SetPosX(self._ui._stc_restoreNum:GetPosX() + self._ui._stc_restoreNum:GetTextSizeX() + 10)
end
function PaGlobal_Restore_All:updateRestoreButton(restoreCategory)
  if nil == Panel_Window_Restore_All then
    return
  end
  if restoreCategory == self._restoreCategoryTable.__eItem then
    local isRestoreReq = ToClient_IsRestoreReq()
    local isIgnore = isRestoreReq or nil == self._selectSlotNo
    self._ui._btn_restore:SetIgnore(isIgnore)
    self._ui._btn_restore:SetMonoTone(isIgnore)
    self._ui._btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_RestoreItem()")
  elseif restoreCategory == self._restoreCategoryTable.__eJewel then
    local isIgnore = self._selectSlotNo == nil
    self._ui._btn_restore:SetIgnore(isIgnore)
    self._ui._btn_restore:SetMonoTone(isIgnore)
    self._ui._btn_restore:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_RestoreJewel()")
  else
    UI.ASSERT_NAME(false, "\235\179\181\234\181\172 \236\185\180\237\133\140\234\179\160\235\166\172\234\176\128 \236\182\148\234\176\128\235\144\152\235\169\180 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
  end
end
function PaGlobal_Restore_All:setList()
  if nil == Panel_Window_Restore_All then
    return
  end
  self._selectSlotNo = nil
  self:updateRestoreButton(self._restoreCategoryTable.__eItem)
  local listCount = ToClient_RequestRestoreItemListCount(self._restoreType)
  for ii = 0, listCount - 1 do
    self._ui._list2_item:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobal_Restore_All:setJewelList()
  if Panel_Window_Restore_All == nil then
    return
  end
  self._selectSlotNo = nil
  self:updateRestoreButton(self._restoreCategoryTable.__eJewel)
  local listCount = ToClient_GetJewelDestroyedListCount()
  for ii = 0, listCount - 1 do
    self._ui._list2_jewel:getElementManager():pushKey(toInt64(0, ii))
  end
end
function PaGlobal_Restore_All:createList(control, key)
  local restoreType = self._restoreType
  local index = Int64toInt32(key)
  local itemSSW = ToClient_RequestRestoreItemEnchantStaticStatusWrapperAt(restoreType, index)
  if nil == itemSSW then
    return
  end
  local s64_stackCount = ToClient_RequestRestoreItemCountAt(restoreType, index)
  local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
  local list2_itemslot = UI.getChildControl(list2_btn_radio, "Static_ItemSlot")
  local list2_itemname = UI.getChildControl(list2_btn_radio, "StaticText_ItemName")
  local list2_itemtime = UI.getChildControl(list2_btn_radio, "StaticText_ItemTime")
  list2_btn_radio:setNotImpactScrollEvent(true)
  list2_btn_radio:SetCheck(false)
  list2_btn_radio:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eItem .. ")")
  list2_itemslot:SetIgnore(true)
  local slot = {}
  SlotItem.reInclude(slot, "Restore_Slot_Icon_", 0, list2_itemslot, self._slotConfig)
  slot:clearItem()
  slot.icon:SetIgnore(true)
  slot:setItemByStaticStatus(itemSSW, s64_stackCount)
  local itemName = MakeUpItemNameWithEnchantLevel(restoreType, index)
  list2_itemname:SetText(itemName)
  local expirationTime = ToClient_GetRestoreItemExpirationTime(restoreType, index)
  local expirationTimeString = PAGetString(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_EXPIRATION_TIME") .. " " .. convertStringFromDatetimeAll(expirationTime - getServerUtc64())
  list2_itemtime:SetText(expirationTimeString)
end
function PaGlobal_Restore_All:createJewelList(control, key)
  local index = Int64toInt32(key)
  local destroyedGroupNo = ToClient_GetJewelDestroyedGroupNo(index)
  local jewelCount = ToClient_GetJewelDestroyedGroupJewelCount(index)
  local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
  local list2_txt_jewelTime = UI.getChildControl(list2_btn_radio, "StaticText_Time")
  local list2_txt_jewelCantRestore = UI.getChildControl(list2_btn_radio, "StaticText_CantRestore")
  list2_btn_radio:setNotImpactScrollEvent(true)
  list2_btn_radio:SetCheck(false)
  if self._isPadSnapping == false then
    list2_btn_radio:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eJewel .. ")")
  else
    list2_btn_radio:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eJewel .. ")")
    list2_btn_radio:addInputEvent("Mouse_On", "PaGlobalFunc_Restore_All_UpdateConsoleKeyGuide(1)")
  end
  for i = 0, __eJewelDestroyMaxCount - 1 do
    local list2_jewelslot = UI.getChildControl(list2_btn_radio, "Static_ItemSlot_" .. i + 1 .. "")
    if list2_jewelslot ~= nil then
      local slot = {}
      SlotItem.reInclude(slot, "Restore_Slot_Icon_", i + 1, list2_jewelslot, self._slotConfig)
      slot:clearItem()
      if jewelCount > i then
        local jewelItemSSW = ToClient_GetJewelDestroyedItemStaticStatusWrapper(index, i)
        slot:setItemByStaticStatus(jewelItemSSW)
        slot.icon:SetIgnore(false)
        if self._isPadSnapping == false then
          slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_Restore_All_ShowJewelTooltip(true, " .. index .. ", " .. i .. ")")
          slot.icon:addInputEvent("Mouse_Out", "HandleEventLUp_Restore_All_ShowJewelTooltip(false, " .. index .. ", " .. i .. ")")
          slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eJewel .. ")")
        else
          list2_jewelslot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Restore_All_ShowJewelTooltip(true, " .. index .. ", " .. i .. ")")
          list2_jewelslot:addInputEvent("Mouse_Out", "HandleEventLUp_Restore_All_ShowJewelTooltip(false, " .. index .. ", " .. i .. ")")
          list2_jewelslot:addInputEvent("Mouse_On", "PaGlobalFunc_Restore_All_UpdateConsoleKeyGuide(2)")
        end
      else
        list2_jewelslot:addInputEvent("Mouse_Out", "HandleEventLUp_Restore_All_ShowJewelTooltip(false)")
        if self._isPadSnapping == false then
          slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eJewel .. ")")
          slot.icon:addInputEvent("Mouse_On", "HandleEventLUp_Restore_All_ShowJewelTooltip(false)")
          slot.icon:removeInputEvent("Mouse_Out")
        else
          list2_jewelslot:addInputEvent("Mouse_On", "PaGlobalFunc_Restore_All_UpdateConsoleKeyGuide(3)")
          list2_jewelslot:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
        end
      end
      list2_jewelslot:SetShow(true)
    end
  end
  local isBadPlayer = ToClient_GetJewelDestroyedIsBadPlayer(index)
  local isJewelRestoredAlready = ToClient_IsJewelRestoredAlready(index)
  list2_txt_jewelCantRestore:SetShow(true)
  list2_txt_jewelTime:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eJewel .. ")")
  list2_txt_jewelCantRestore:addInputEvent("Mouse_LUp", "HandleEventLUp_Restore_All_Select(" .. tostring(index) .. "," .. self._restoreCategoryTable.__eJewel .. ")")
  if isJewelRestoredAlready == true then
    local destroyedTime = ToClient_GetJewelDestroyedTime(index)
    local destroyedTimeString = os.date("%Y-%m-%d %H:%M", Int64toInt32(destroyedTime))
    list2_txt_jewelTime:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_CRYSTAL_DESTROYEDTIME") .. " : " .. destroyedTimeString)
    UI.setLimitTextAndAddTooltip(list2_txt_jewelTime, list2_txt_jewelTime:GetText(), "")
    local restoredTime = ToClient_GetJewelRestoredTime(index)
    local restoredTimeString = os.date("%Y-%m-%d %H:%M", Int64toInt32(restoredTime))
    list2_txt_jewelCantRestore:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_CRYSTAL_RESTOREDTIME") .. " : " .. restoredTimeString)
    UI.setLimitTextAndAddTooltip(list2_txt_jewelCantRestore, list2_txt_jewelCantRestore:GetText(), "")
    list2_txt_jewelCantRestore:SetFontColor(Defines.Color.C_FF4898D0)
    list2_txt_jewelCantRestore:SetOverFontColor(Defines.Color.C_FF4898D0)
    list2_txt_jewelCantRestore:SetClickFontColor(Defines.Color.C_FF4898D0)
  else
    local destroyedTime = ToClient_GetJewelDestroyedTime(index)
    local destroyedTimeString = os.date("%Y-%m-%d %H:%M", Int64toInt32(destroyedTime))
    list2_txt_jewelTime:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_CRYSTAL_DESTROYEDTIME") .. " :  " .. destroyedTimeString)
    UI.setLimitTextAndAddTooltip(list2_txt_jewelTime, list2_txt_jewelTime:GetText(), "")
    if isBadPlayer == true then
      list2_txt_jewelCantRestore:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_RESTOREITEM_CRYSTAL_CANTRESTORE"))
      UI.setLimitTextAndAddTooltip(list2_txt_jewelCantRestore, list2_txt_jewelCantRestore:GetText(), "")
      list2_txt_jewelCantRestore:SetFontColor(Defines.Color.C_FFD05D48)
      list2_txt_jewelCantRestore:SetOverFontColor(Defines.Color.C_FFD05D48)
      list2_txt_jewelCantRestore:SetClickFontColor(Defines.Color.C_FFD05D48)
      list2_txt_jewelCantRestore:addInputEvent("Mouse_On", "HandleEventOnOut_Restore_All_ShowCantRestoreTooltip(true, " .. index .. ")")
      list2_txt_jewelCantRestore:addInputEvent("Mouse_Out", "HandleEventOnOut_Restore_All_ShowCantRestoreTooltip(false, " .. index .. ")")
    else
      list2_txt_jewelCantRestore:SetShow(false)
    end
  end
end
function PaGlobal_Restore_All:reposition()
  if false == self._isPadSnapping then
    return
  end
  Panel_Window_Restore_All:ComputePos()
end
function PaGlobal_Restore_All:consoleSetting()
  if false == self._isPadSnapping then
    return
  end
  PaGlobalFunc_Restore_All_UpdateConsoleKeyGuide(1)
  self._ui._stc_descBg:SetPosY(self._ui._btn_restore:GetPosY())
  local subSizeY = self._ui._btn_restore:GetSizeY()
  self._ui._stc_subFrameBg:SetSize(self._ui._stc_subFrameBg:GetSizeX(), self._ui._stc_subFrameBg:GetSizeY() - subSizeY)
  Panel_Window_Restore_All:SetSize(Panel_Window_Restore_All:GetSizeX(), Panel_Window_Restore_All:GetSizeY() - subSizeY)
  self._ui_console._stc_keyGuideBg:ComputePos()
  Panel_Window_Restore_All:SetVerticalMiddle()
  Panel_Window_Restore_All:SetHorizonCenter()
end
function PaGlobal_Restore_All:selectRestoreCategory(restoreCategory)
  if restoreCategory == self._restoreCategoryTable.__eItem then
    self._ui._stc_txtDescJewel:SetShow(false)
    self._selectSlotNo = nil
    self:updateInfo(self._restoreCategoryTable.__eItem)
    self:updateRestoreButton(self._restoreCategoryTable.__eItem)
    local listCount = ToClient_GetJewelDestroyedListCount()
    for index = 0, listCount - 1 do
      local control = self._ui._list2_jewel:GetContentByKey(index)
      if control ~= nil then
        local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
        list2_btn_radio:SetCheck(false)
      end
    end
    self._ui._list2_jewel:SetShow(false)
    self._ui._list2_item:SetShow(true)
    self._ui._stc_txtDescItem:SetShow(true)
    self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), self._originStcDescBgSizeY + self._addItemDescSizeY)
    self._ui._stc_subFrameBg:SetSize(self._ui._stc_subFrameBg:GetSizeX(), self._originStcSubFrameBg + self._addItemDescSizeY)
    Panel_Window_Restore_All:SetSize(Panel_Window_Restore_All:GetSizeX(), self._originPanelSizeY + self._addItemDescSizeY)
    self._ui._btn_jewel:SetCheck(false)
    self._ui._btn_normal:SetCheck(true)
    self._ui._stc_selectbar:SetSpanSize(self._ui._btn_normal:GetPosX() + (self._ui._btn_normal:GetSizeX() - self._ui._stc_selectbar:GetSizeX()) * 0.5, self._ui._stc_selectbar:GetSpanSize().y)
    if self._isPadSnapping == true then
      self._ui_console._stc_keyGuideA:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ITEM_RESTORATION_POPUP_TITLE"))
    end
  elseif restoreCategory == self._restoreCategoryTable.__eJewel then
    self._ui._stc_txtDescItem:SetShow(false)
    self._selectSlotNo = nil
    self:updateInfo(self._restoreCategoryTable.__eJewel)
    self:updateRestoreButton(self._restoreCategoryTable.__eJewel)
    local listCount = ToClient_RequestRestoreItemListCount(self._restoreType)
    for index = 0, listCount - 1 do
      local control = self._ui._list2_item:GetContentByKey(index)
      if control ~= nil then
        local list2_btn_radio = UI.getChildControl(control, "RadioButton_Item")
        list2_btn_radio:SetCheck(false)
      end
    end
    self._ui._list2_item:SetShow(false)
    self._ui._list2_jewel:SetShow(true)
    self._ui._stc_txtDescJewel:SetShow(true)
    self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), self._originStcDescBgSizeY + self._addJewelDescSizeY)
    self._ui._stc_subFrameBg:SetSize(self._ui._stc_subFrameBg:GetSizeX(), self._originStcSubFrameBg + self._addJewelDescSizeY)
    Panel_Window_Restore_All:SetSize(Panel_Window_Restore_All:GetSizeX(), self._originPanelSizeY + self._addJewelDescSizeY)
    self._ui._btn_normal:SetCheck(false)
    self._ui._btn_jewel:SetCheck(true)
    self._ui._stc_selectbar:SetSpanSize(self._ui._btn_jewel:GetPosX() + (self._ui._btn_jewel:GetSizeX() - self._ui._stc_selectbar:GetSizeX()) * 0.5, self._ui._stc_selectbar:GetSpanSize().y)
    if self._isPadSnapping == true then
      self._ui_console._stc_keyGuideA:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_DEADMESSAGE_RESTORATION"))
    end
  else
    UI.ASSERT_NAME(false, "\235\179\181\234\181\172 \236\185\180\237\133\140\234\179\160\235\166\172\234\176\128 \236\182\148\234\176\128\235\144\152\235\169\180 \236\182\148\234\176\128 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164.", "\236\152\164\236\131\129\235\175\188")
  end
  self:consoleSetting()
  TooltipSimple_Hide()
  if self._isConsole == true then
    PaGlobalFunc_TooltipInfo_Close()
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
