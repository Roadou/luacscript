function PaGlobalFunc_MaidActorList_Open()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_MaidActorList_Close()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_MaidActorList_IsShow()
  local panel = Panel_Window_MaidActorList_All
  if panel == nil then
    return false
  end
  return Panel_Window_MaidActorList_All:GetShow()
end
function HandleEventLUp_MaidActorList_RegistMaidActor()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  if PaGlobalFunc_MaidActorRegist_IsShow() == true then
    PaGlobalFunc_MaidActorRegist_Close()
  else
    PaGlobalFunc_MaidActorRegist_Open(PaGlobal_MaidActorRegist._eOpenType.MAID_ACTOR_LIST)
  end
end
function HandleEventLUp_MaidActorList_UnregistMaidActor()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  local function do_confirm()
    local maidInfo = ToClient_GetMaidActorSimpleInfo(self._selectSlotIndex - 1)
    if maidInfo == nil then
      return
    end
    ToClient_RequestUnregistMaidActor(maidInfo:getMaidNo())
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MAIDACTORLIST_MESSAGEBOX_DESC_CLEAR"),
    functionYes = do_confirm,
    functionCancel = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW,
    exitButton = true
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_MaidActorList_ChangeHeadMaidActor()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  local maidInfo = ToClient_GetMaidActorSimpleInfo(self._selectSlotIndex - 1)
  if maidInfo == nil then
    return
  end
  local isReq = ToClient_RequestChangeHeadMaidActor(maidInfo:getMaidNo())
  if isReq == false then
    PaGlobalFunc_MaidActorList_Close()
    return
  end
end
function HandleEventLUp_MaidActorList_ChangeName()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  if PaGlobalFunc_ChangeMaidActorName_IsShow() == true then
    PaGlobalFunc_ChangeMaidActorName_Close()
  else
    local maidInfo = ToClient_GetMaidActorSimpleInfo(self._selectSlotIndex - 1)
    if maidInfo == nil then
      return
    end
    PaGlobalFunc_ChangeMaidActorName_Open(maidInfo:getMaidNo())
  end
end
function HandleEventLOnOut_MaidActorList_OverSlot(isOn, slotIndex)
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  if isOn == true then
    self:selectSlot(slotIndex)
  end
end
function HandleEventLUp_MaidActorList_ClickSlot(slotIndex)
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  self:selectSlot(slotIndex)
end
function HandleEventLUp_MaidActorList_DoubleClickSlot(slotIndex)
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  self:selectSlot(slotIndex)
  if self._ui.btn_create:IsEnable() == true then
    HandleEventLUp_MaidActorList_RegistMaidActor()
  elseif self._ui.btn_apply:IsEnable() == true then
    HandleEventLUp_MaidActorList_ChangeHeadMaidActor()
  end
end
function HandleEventLUp_MaidActorList_BuySlot(slotIndex)
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  self:selectSlot(slotIndex)
  PaGlobalFunc_EasyBuy_Open(137)
end
function FromClient_MaidActorList_MaidActorEvent(eventType)
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  local panelIsShow = Panel_Window_MaidActorList_All:GetShow()
  if panelIsShow == false then
    return
  end
  if eventType == __eMaidActorEventType_Load then
  elseif eventType == __eMaidActorEventType_Regist then
    self:updateSlot()
    self:updateBottomButton()
  elseif eventType == __eMaidActorEventType_Unregist then
    self:updateSlot()
    self:updateBottomButton()
  elseif eventType == __eMaidActorEventType_ChangeHead then
    PaGlobalFunc_MaidActorList_Close()
  elseif eventType == __eMaidActorEventType_ChangeName then
    self:updateSlot()
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 event \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
  end
end
function FromClient_MaidActorList_AddSlot()
  local self = PaGlobal_MaidActorList
  if self == nil then
    return
  end
  local panelIsShow = Panel_Window_MaidActorList_All:GetShow()
  if panelIsShow == false then
    return
  end
  self:updateSlot()
  self:selectSlot(self._selectSlotIndex)
end
