function PaGlobal_Endurance_InvenSlot_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui.txt_InvenSlotIcon = UI.getChildControl(Panel_Endurance, "StaticText_InvenSlotOver")
  self._ui.txt_InvenSlotText = UI.getChildControl(Panel_Endurance, "StaticText_NoticeInvenSlot")
  self._ui.btn_RepairAutoNavi = UI.getChildControl(Panel_Endurance, "CheckButton_Repair_AutoNavi")
  self:registEventHandler()
  self:validate()
  self:checkInvenSlot()
  self._initialize = true
end
function PaGlobal_Endurance_InvenSlot_All:registEventHandler()
  if nil == Panel_Endurance then
    return
  end
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_Endurance_InvenSlot_All_CheckInvenSlot")
end
function PaGlobal_Endurance_InvenSlot_All:prepareOpen()
  if nil == Panel_Endurance then
    return
  end
  self:open()
end
function PaGlobal_Endurance_InvenSlot_All:open()
  if nil == Panel_Endurance then
    return
  end
  Panel_Endurance:SetShow(true)
end
function PaGlobal_Endurance_InvenSlot_All:prepareClose()
  if nil == Panel_Endurance then
    return
  end
  self:close()
end
function PaGlobal_Endurance_InvenSlot_All:close()
  if nil == Panel_Endurance then
    return
  end
  Panel_Endurance:SetShow(false)
end
function PaGlobal_Endurance_InvenSlot_All:checkInvenSlot()
  if nil == Panel_Endurance then
    return
  end
  self._ui.txt_InvenSlotIcon:SetShow(false)
  self._ui.txt_InvenSlotText:SetShow(false)
end
function PaGlobal_Endurance_InvenSlot_All:setPosY(posY)
  if nil == Panel_Endurance then
    return
  end
  if false == PaGlobal_Endurance_InvenSlot_All._initialize then
    return
  end
  self._ui.txt_InvenSlotIcon:SetPosY(posY)
  self._ui.txt_InvenSlotText:SetPosY(posY)
end
function PaGlobal_Endurance_InvenSlot_All:setEffect(slotCount)
  self._ui.txt_InvenSlotIcon:EraseAllEffect()
  if slotCount <= 2 then
    self._ui.txt_InvenSlotIcon:AddEffect("fUI_Weight_02B", true, -0.5, -1.3)
  elseif slotCount <= 5 then
    self._ui.txt_InvenSlotIcon:AddEffect("fUI_Weight_02A", true, -0.5, -1.3)
  end
end
function PaGlobal_Endurance_InvenSlot_All:validate()
  if nil == Panel_Endurance then
    return
  end
  self._ui.txt_InvenSlotIcon:isValidate()
  self._ui.txt_InvenSlotText:isValidate()
  self._ui.btn_RepairAutoNavi:isValidate()
end
