function PaGlobal_SeasonEquipment_Upgrade:initialize()
  if true == PaGlobal_SeasonEquipment_Upgrade._initialize then
    return
  end
  self._ui.btn_close = UI.getChildControl(Panel_Window_Season_Equiptment_Upgrade_All, "Button_Close_PCUI")
  self._ui.stc_itemSetting = UI.getChildControl(Panel_Window_Season_Equiptment_Upgrade_All, "Static_Item_Setting_Bg")
  self._ui.stc_effect = UI.getChildControl(self._ui.stc_itemSetting, "Static_Effect")
  self._ui.stc_naru_item = UI.getChildControl(self._ui.stc_itemSetting, "Static_Item_Naru")
  self._ui.stc_tubala = UI.getChildControl(self._ui.stc_itemSetting, "Static_Tubala")
  self._ui.btn_upgrade = UI.getChildControl(Panel_Window_Season_Equiptment_Upgrade_All, "Button_Upgrade")
  self._ui.txt_console = UI.getChildControl(self._ui.btn_upgrade, "StaticText_Upgrade_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  if true == self._isConsole then
    self._ui.btn_upgrade:SetText("")
    self._ui.txt_console:SetShow(true)
    local console_size = self._ui.txt_console:GetSizeX()
    local string_size = self._ui.txt_console:GetTextSizeX()
    local finalSize = -((console_size + string_size) / 2)
    self._ui.txt_console:SetSpanSize(finalSize, self._ui.txt_console:GetSpanSize().y)
    self._ui.btn_close:SetShow(false)
  end
  local slotNaru = {}
  SlotItem.new(slotNaru, "Static_Item_Naru_", 0, self._ui.stc_naru_item, self._slotConfig)
  slotNaru:createChild()
  slotNaru.empty = true
  slotNaru:clearItem()
  slotNaru.border:SetSize(40, 40)
  slotNaru.border:SetPosX(0)
  slotNaru.border:SetPosY(0)
  self.naruItem = slotNaru
  local slotTubala = {}
  SlotItem.new(slotTubala, "Static_Item_Tubala_", 0, self._ui.stc_tubala, self._slotConfig)
  slotTubala:createChild()
  slotTubala.empty = true
  slotTubala:clearItem()
  slotTubala.border:SetSize(40, 40)
  slotTubala.border:SetPosX(0)
  slotTubala.border:SetPosY(0)
  self.tubalaItem = slotTubala
  PaGlobal_SeasonEquipment_Upgrade:registEventHandler()
  PaGlobal_SeasonEquipment_Upgrade:validate()
  PaGlobal_SeasonEquipment_Upgrade._initialize = true
end
function PaGlobal_SeasonEquipment_Upgrade:registEventHandler()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  registerEvent("onScreenResize", "PaGlobal_SeasonEquipment_Upgrade_All_OnScreenResize")
  registerEvent("FromClient_ChangeEquipItem", "PaGlobal_SeasonEquipment_Upgrade_All_ClearChangeItem")
  if true == self._isConsole then
    Panel_Window_Season_Equiptment_Upgrade_All:registerPadEvent(__eConsoleUIPadEvent_Y, "HandleEventLUp_PaGlobal_SeasonEquipment_Upgrade()")
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_SeasonEquipment_Upgrade_Close()")
  self._ui.btn_upgrade:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_SeasonEquipment_Upgrade()")
end
function PaGlobal_SeasonEquipment_Upgrade:prepareOpen()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil ~= Panel_Window_Equipment_All then
    Panel_Window_Season_Equiptment_Upgrade_All:SetPosX(Panel_Window_Equipment_All:GetPosX() - Panel_Window_Season_Equiptment_Upgrade_All:GetSizeX() - 100)
  end
  self:clearNaruItem()
  Inventory_SetFunctor(nil, nil, nil, nil)
  if self._isConsole then
    local optionalEvent = {
      func = HandleEventLUp_PaGlobal_SeasonEquipment_Upgrade,
      keyGuideString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SEASON_UPGRADE_BTN")
    }
    Inventory_SetFunctor(PaGlobal_SeasonEquipment_Upgrade_Filter, PaGlobal_SeasonEquipment_Upgrade_All_RClickForTargetItem, PaGlobal_SeasonEquipment_Upgrade_Close, nil, optionalEvent)
  else
    Inventory_SetFunctor(PaGlobal_SeasonEquipment_Upgrade_Filter, PaGlobal_SeasonEquipment_Upgrade_All_RClickForTargetItem, PaGlobal_SeasonEquipment_Upgrade_Close, nil)
  end
  if false == _ContentsGroup_RenewUI then
    PaGlobalFunc_BetterEquipment_Close()
  end
  PaGlobal_SeasonEquipment_Upgrade:open()
end
function PaGlobal_SeasonEquipment_Upgrade:open()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  Panel_Window_Season_Equiptment_Upgrade_All:SetShow(true)
end
function PaGlobal_SeasonEquipment_Upgrade:prepareClose()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  Inventory_SetFunctor(nil, nil, nil, nil)
  self:clearNaruItem()
  PaGlobal_SeasonEquipment_Upgrade:close()
end
function PaGlobal_SeasonEquipment_Upgrade:close()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  Panel_Window_Season_Equiptment_Upgrade_All:SetShow(false)
end
function PaGlobal_SeasonEquipment_Upgrade:update()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == self.naruItemKey then
    self._ui.btn_upgrade:SetMonoTone(true)
    self._ui.btn_upgrade:SetIgnore(true)
  else
    self._ui.btn_upgrade:SetMonoTone(false)
    self._ui.btn_upgrade:SetIgnore(false)
  end
end
function PaGlobal_SeasonEquipment_Upgrade:setNaruItem(slotNo, itemWrapper, inventoryType)
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  if nil == slotNo or nil == itemWrapper or nil == inventoryType then
    return
  end
  self.naruItem.empty = false
  self.naruItem.slotNo = slotNo
  self.naruItem.inventoryType = inventoryType
  self.naruItem.icon:SetMonoTone(false)
  self.naruItem:setItem(itemWrapper)
  if true == self._isConsole then
    self.naruItem.icon:addInputEvent("Mouse_LUp", "HandleEventRUp_SeasonEquipment_Upgrade_All_ReleaseNaruItem()")
  else
    self.naruItem.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_SeasonEquipment_Upgrade_All_ReleaseNaruItem()")
  end
  if true == _ContentsGroup_RenewUI then
    self.naruItem.icon:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOn_SeasonEquipment_Upgrade_All_NaruItemTootip()")
    self.naruItem.icon:addInputEvent("Mouse_On", "HandleEventOn_SeasonEquipment_Upgrade_All_NaruItemSimpleTootipForConsle()")
    self.naruItem.icon:addInputEvent("Mouse_Out", "HandleEventOut_SeasonEquipment_Upgrade_All_Tooltip()")
  else
    self.naruItem.icon:addInputEvent("Mouse_On", "HandleEventOn_SeasonEquipment_Upgrade_All_NaruItemTootip()")
    self.naruItem.icon:addInputEvent("Mouse_Out", "HandleEventOut_SeasonEquipment_Upgrade_All_Tooltip()")
  end
  local naruItemSSW = itemWrapper:getStaticStatus()
  if nil ~= naruItemSSW then
    self.naruItemKey = naruItemSSW:get()._key
    self.tubalaItemKey = ToClient_getTubalaItemForNaruItemEnchantKey(naruItemSSW:get()._key)
    local itemSSW = getItemEnchantStaticStatus(self.tubalaItemKey)
    if nil ~= itemSSW then
      self.tubalaItem:setItemByStaticStatus(itemSSW, 1)
      if true == _ContentsGroup_RenewUI then
        self.naruItem.icon:registerPadEvent(__eConsoleUIPadEvent_X, "HandleEventOn_SeasonEquipment_Upgrade_All_TubalaItemTootip()")
        self.tubalaItem.icon:addInputEvent("Mouse_On", "HandleEventOn_SeasonEquipment_Upgrade_All_TubalaItemSimpleTootipForConsle()")
        self.tubalaItem.icon:addInputEvent("Mouse_Out", "HandleEventOut_SeasonEquipment_Upgrade_All_Tooltip()")
      else
        self.tubalaItem.icon:addInputEvent("Mouse_On", "HandleEventOn_SeasonEquipment_Upgrade_All_TubalaItemTootip()")
        self.tubalaItem.icon:addInputEvent("Mouse_Out", "HandleEventOut_SeasonEquipment_Upgrade_All_Tooltip()")
      end
    end
  end
  self:update()
end
function PaGlobal_SeasonEquipment_Upgrade:clearNaruItem()
  self.naruItem.inventoryType = nil
  self.naruItem.slotNo = nil
  self.naruItem:clearItem()
  self.naruItem.empty = true
  self.naruItem.icon:EraseAllEffect()
  self.naruItem.icon:addInputEvent("Mouse_RUp", "")
  self.naruItem.icon:addInputEvent("Mouse_On", "")
  self.naruItem.icon:addInputEvent("Mouse_Out", "")
  self.naruItem.icon:registerPadEvent(__eConsoleUIPadEvent_X, "")
  self.naruItemKey = nil
  self.tubalaItemKey = nil
  self.tubalaItem:clearItem()
  self.tubalaItem.icon:EraseAllEffect()
  self.tubalaItem.icon:addInputEvent("Mouse_RUp", "")
  self.tubalaItem.icon:addInputEvent("Mouse_On", "")
  self.tubalaItem.icon:addInputEvent("Mouse_Out", "")
  self.tubalaItem.icon:registerPadEvent(__eConsoleUIPadEvent_X, "")
  HandleEventOut_SeasonEquipment_Upgrade_All_Tooltip()
  self:update()
end
function PaGlobal_SeasonEquipment_Upgrade:validate()
  if nil == Panel_Window_Season_Equiptment_Upgrade_All then
    return
  end
  self._ui.btn_close:isValidate()
  self._ui.stc_itemSetting:isValidate()
  self._ui.stc_effect:isValidate()
  self._ui.stc_naru_item:isValidate()
  self._ui.stc_tubala:isValidate()
  self._ui.btn_upgrade:isValidate()
end
