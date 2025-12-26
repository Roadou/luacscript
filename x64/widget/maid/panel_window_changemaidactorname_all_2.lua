function PaGlobalFunc_ChangeMaidActorName_Open(maidNo)
  local self = PaGlobal_ChangeMaidActorName
  if self == nil then
    return
  end
  self:prepareOpen(maidNo)
end
function PaGlobalFunc_ChangeMaidActorName_Close()
  local self = PaGlobal_ChangeMaidActorName
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_ChangeMaidActorName_IsShow()
  local panel = Panel_Window_ChangeMaidActorName_All
  if panel == nil then
    return false
  end
  return panel:GetShow()
end
function HandleEventUpX_ChangeMaidActorName_InputEditMode()
  local self = PaGlobal_ChangeMaidActorName
  if self == nil then
    return
  end
  SetFocusEdit(self._ui.edt_name)
end
function HandleLUp_ChangeMaidActorName_DoRequest()
  local self = PaGlobal_ChangeMaidActorName
  if self == nil then
    return
  end
  if self._maidNo == nil then
    return
  end
  ToClient_RequestChangeMaidActorName(self._maidNo, self._ui.edt_name:GetEditText())
end
function FromClient_ChangeMaidActorName_MaidActorEvent(eventType)
  local self = PaGlobal_ChangeMaidActorName
  if self == nil then
    return
  end
  if PaGlobalFunc_ChangeMaidActorName_IsShow() == false then
    return
  end
  if eventType == __eMaidActorEventType_Load then
  elseif eventType == __eMaidActorEventType_Regist then
  elseif eventType == __eMaidActorEventType_Unregist then
  elseif eventType == __eMaidActorEventType_ChangeHead then
  elseif eventType == __eMaidActorEventType_ChangeName then
    PaGlobalFunc_ChangeMaidActorName_Close()
  else
    UI.ASSERT_NAME(false, "\236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\157\128 event \237\131\128\236\158\133\236\158\133\235\139\136\235\139\164!", "\236\157\180\236\163\188")
  end
end
