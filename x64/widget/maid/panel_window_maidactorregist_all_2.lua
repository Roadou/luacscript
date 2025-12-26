function PaGlobalFunc_MaidActorRegist_Open(openType)
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  self:prepareOpen(openType)
end
function PaGlobalFunc_MaidActorRegist_Close()
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_MaidActorRegist_IsShow()
  local panel = Panel_Window_MaidActorRegist_All
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function HandleEventLUp_MaidActorRegist_DoRegist()
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  if self._slots == nil then
    return
  end
  if self._selectSlotIndex == nil then
    return
  end
  local selectedSlotData = self._slots[self._selectSlotIndex]
  if selectedSlotData == nil then
    return
  end
  local slot = selectedSlotData._control
  local maidCharacterKeyRaw = selectedSlotData._maidCharacterKeyRaw
  local inputName = self._ui.edt_name:GetEditText()
  ToClient_RequestRegistMaidActor(maidCharacterKeyRaw, inputName)
end
function HandleEventUpX_MaidActorRegist_InputEditMode()
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  SetFocusEdit(self._ui.edt_name)
end
function HandleEventLOnOut_MaidActorRegist_OverSlot(isOn, slotIndex)
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  self:overSlot(isOn, slotIndex)
end
function HandleEventLUp_MaidActorRegist_ClickSlot(slotIndex)
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  self:selectSlot(slotIndex)
end
function FromClient_MaidActorRegist_MaidActorEvent(eventType)
  local self = PaGlobal_MaidActorRegist
  if self == nil then
    return
  end
  if PaGlobalFunc_MaidActorRegist_IsShow() == false then
    return
  end
  if eventType == __eMaidActorEventType_Load then
  elseif eventType == __eMaidActorEventType_Regist then
    PaGlobalFunc_MaidActorRegist_Close()
  elseif eventType == __eMaidActorEventType_Unregist then
  elseif eventType == __eMaidActorEventType_ChangeHead then
  elseif eventType == __eMaidActorEventType_ChangeName then
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 event \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
  end
end
