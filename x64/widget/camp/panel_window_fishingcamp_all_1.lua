function PaGlobal_FishingCamp:initialize()
  if PaGlobal_FishingCamp._initialize == true then
    return
  end
  self._ui.stc_cantUse = UI.getChildControl(Panel_Window_FishingCamp, "Static_FishCampCantUse")
  local buttons = UI.getChildControl(Panel_Window_FishingCamp, "Static_Bottom")
  self._ui.btn_unSeal = UI.getChildControl(buttons, "Button_UnsealTent")
  self._ui.btn_seal = UI.getChildControl(buttons, "Button_SealTent")
  for ii = 0, self._maxSlotCount - 1 do
    local stc_Slot = UI.getChildControl(Panel_Window_FishingCamp, "Static_Slot_" .. ii)
    self._slotUI[ii] = UI.getChildControl(stc_Slot, "Static_TentSlotBg")
  end
  for ii = 0, self._maxSlotCount - 1 do
    local slot = {}
    SlotItem.new(slot, "FishingCampEquip" .. ii, ii, self._slotUI[ii], self._itemSlotConfig)
    slot:createChild()
    self._itemSlots[ii] = slot
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_FishingCamp:registEventHandler()
  PaGlobal_FishingCamp:validate()
  PaGlobal_FishingCamp._initialize = true
end
function PaGlobal_FishingCamp:registEventHandler()
  if Panel_Window_FishingCamp == nil then
    return
  end
  self._ui.btn_unSeal:addInputEvent("Mouse_LUp", "PaGlobal_FishingCamp_SealOrUnsealFishingCamp()")
  self._ui.btn_seal:addInputEvent("Mouse_LUp", "PaGlobal_FishingCamp_SealOrUnsealFishingCamp()")
  registerEvent("FromClient_UpdateFishingCampIconUI", "PaGlobal_FishingCamp_UpdateFishingCampIcon")
  registerEvent("FromClient_UpdateFishingCampUI", "PaGlobal_FishingCamp_Update")
  registerEvent("FromClient_ServantUnseal", "PaGlobal_FishingCamp_Update")
  registerEvent("FromClient_ServantSeal", "PaGlobal_FishingCamp_Update")
end
function PaGlobal_FishingCamp:validate()
end
function PaGlobal_FishingCamp:prepareOpen()
  if Panel_Window_FishingCamp == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_FishingCamp:open()
  if Panel_Window_FishingCamp == nil then
    return
  end
  Panel_Window_FishingCamp:SetShow(true)
end
function PaGlobal_FishingCamp:prepareClose()
  if Panel_Window_FishingCamp == nil then
    return
  end
  Panel_Tooltip_Item_hideTooltip()
  self:close()
end
function PaGlobal_FishingCamp:close()
  if Panel_Window_FishingCamp == nil then
    return
  end
  Panel_Window_FishingCamp:SetShow(false)
end
function PaGlobal_FishingCamp:update()
  if Panel_Window_FishingCamp == nil then
    return
  end
  local isExist = ToClient_IsExistFishingCamp()
  self._ui.btn_unSeal:SetShow(not isExist)
  self._ui.btn_seal:SetShow(isExist)
  self:updateItemSlots()
  Panel_Tooltip_Item_hideTooltip()
end
function PaGlobal_FishingCamp:updateItemSlots()
  if Panel_Window_FishingCamp == nil then
    return
  end
  for ii = 0, self._maxSlotCount - 1 do
    local slot = self._itemSlots[ii]
    local itemWrapper = ToClient_GetFishingCampEquipItem(ii + 1)
    slot.icon:addInputEvent("Mouse_RUp", "PaGlobal_FishingCamp_RequestUnequipItem(" .. tostring(ii) .. ")")
    if nil ~= itemWrapper then
      slot:setItemByStaticStatus(itemWrapper)
      slot.icon:addInputEvent("Mouse_On", "PaGlobal_FishingCamp_ShowItemToolTip(" .. tostring(ii) .. "," .. itemWrapper:getItemKey() .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "PaGlobal_FishingCamp_ShowItemToolTip(" .. tostring(ii) .. "," .. itemWrapper:getItemKey() .. ",false)")
    else
      slot.icon:addInputEvent("Mouse_On", "")
      slot.icon:addInputEvent("Mouse_Out", "")
      slot:clearItem()
    end
  end
end
function PaGlobal_FishingCamp:showToolTip(equipSlotIndex, key, isShow)
  local itemWrapper = getItemEnchantStaticStatus(ItemEnchantKey(key))
  if PaGlobal_FishingCamp == nil or itemWrapper == nil then
    return
  end
  local self = PaGlobal_FishingCamp
  control = self._itemSlots[equipSlotIndex].icon
  if control == nil then
    return
  end
  if true == isShow then
    Panel_Tooltip_Item_Show(itemWrapper, control, true, false)
  else
    Panel_Tooltip_Item_hideTooltip()
  end
end
