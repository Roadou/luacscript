function PaGlobalFunc_CompleteChangeFormFantasyServant_Open(stringParam, servantNo, servantCharacterKeyRaw, changeFormIndexRaw)
  local self = PaGlobal_CompleteChangeFormFantasyServant
  if self == nil then
    return
  end
  if Panel_Dialog_ServantInfo_All ~= nil and Panel_Dialog_ServantInfo_All:GetShow() == true then
    PaGlobalFunc_ServantInfo_All_Close()
  end
  self:prepareOpen(stringParam, servantNo, servantCharacterKeyRaw, changeFormIndexRaw)
end
function PaGlobalFunc_CompleteChangeFormFantasyServant_Close()
  local self = PaGlobal_CompleteChangeFormFantasyServant
  if self == nil then
    return
  end
  if Panel_Dialog_ServantInfo_All ~= nil and Panel_Dialog_ServantInfo_All:GetShow() == false then
    PaGlobalFunc_ServantInfo_All_Open()
  end
  self:prepareClose()
end
function PaGlobalFunc_CompleteChangeFormFantasyServant_Update(deltaTime)
  local self = PaGlobal_CompleteChangeFormFantasyServant
  if self == nil then
    return
  end
  self:update(deltaTime)
end
function FromClient_CompleteChangeFormFantasyServant_SuccessChangeForm()
  local self = PaGlobal_CompleteChangeFormFantasyServant
  if self == nil then
    return
  end
  self._isSuccessFlag = true
end
function FromClient_CompleteChangeFormFantasyServant_FailedChangeForm()
  local self = PaGlobal_CompleteChangeFormFantasyServant
  if self == nil then
    return
  end
  PaGlobalFunc_CompleteChangeFormFantasyServant_Close()
end
