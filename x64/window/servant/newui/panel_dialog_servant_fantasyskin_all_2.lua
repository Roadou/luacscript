function PaGlobalFunc_ServantFantasySkin_Open()
  local self = PaGlobal_ServantFantasySkin
  if self == nil then
    return
  end
  local selectedServantNo
  if Panel_Dialog_ServantList_All ~= nil then
    selectedServantNo = PaGlobalFunc_ServantList_All_Get_SortedServantNo()
  end
  if selectedServantNo == nil then
    return
  end
  if Panel_Dialog_ServantInfo_All ~= nil and Panel_Dialog_ServantInfo_All:GetShow() == true then
    PaGlobalFunc_ServantInfo_All_Close()
  end
  self._currentServantNo = selectedServantNo
  self:prepareOpen()
end
function PaGlobalFunc_ServantFantasySkin_Close()
  local self = PaGlobal_ServantFantasySkin
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLUp_ServantFantasySkin_DoChange()
  local self = PaGlobal_ServantFantasySkin
  if self == nil then
    return
  end
  if self._currentServantNo == nil then
    return
  end
  if self._currentServantCharacterKeyRaw == nil then
    return
  end
  if self._changeTargetFormIndexRaw == nil then
    return
  end
  local isValid = stable_checkFantasyHorseChangeFormItem(self._changeTargetFormIndexRaw, self._currentServantCharacterKeyRaw)
  if isValid == false then
    return
  end
  local function changeForm_confirm()
    self:setServantModelForm_original(false)
    local stringParam = ""
    if self._changeTargetFormIndexRaw == 0 then
      stringParam = "DREAM_ADOOANAT_ORIGINAL"
    else
      stringParam = "DREAM_ADOOANAT_ICE"
    end
    PaGlobalFunc_CompleteChangeFormFantasyServant_Open(stringParam, self._currentServantNo, self._currentServantCharacterKeyRaw, self._changeTargetFormIndexRaw)
    PaGlobalFunc_ServantFantasySkin_Close()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_STABLELIST_CHANGECONFIRM_TITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_HORSESKINCHANGE_POPUP_DESC"),
    functionYes = changeForm_confirm,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  return
end
function HandleEventLUp_ServantFantasySkin_SetModelForm_Original()
  local self = PaGlobal_ServantFantasySkin
  if self == nil then
    return
  end
  self:changeClickControl(0)
  self:setServantModelForm_original(true)
end
function HandleEventLUp_ServantFantasySkin_SetModelForm_New()
  local self = PaGlobal_ServantFantasySkin
  if self == nil then
    return
  end
  self:changeClickControl(1)
  self:setServantModelForm_new(true)
end
function FromClient_ServantFantasySkin_SuccessChangeForm(newFormIndexRaw)
  local self = PaGlobal_ServantFantasySkin
  if self == nil then
    return
  end
  self:setServantModelForm(newFormIndexRaw, true)
end
