function HandleEventLUp_MonsterBuffZone_Deactive()
  local self = PaGlobal_MonsterBuffZone
  if self == nil then
    return
  end
  local requestDeactive = function()
    ToClient_RequestDeactiveMonsterBuffZone()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_DEKIA_SUMMONOFF_MSGTITLE"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_DEKIA_SUMMONOFF_MSGDESC"),
    functionYes = requestDeactive,
    functionNo = MessageBox_Empty_function,
    exitButton = true,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobalFunc_MonsterBuffZone_Update(deltaTime)
  local self = PaGlobal_MonsterBuffZone
  if self == nil then
    return
  end
  self:updatePerFrame(deltaTime)
end
function FromClient_MonsterBuffZone_ActiveSelfPlayerMonsterBuffZone()
  local self = PaGlobal_MonsterBuffZone
  if self == nil then
    return
  end
  self:prepareOpen()
end
function FromClient_MonsterBuffZone_DeactiveSelfPlayerMonsterBuffZone()
  local self = PaGlobal_MonsterBuffZone
  if self == nil then
    return
  end
  self:prepareClose()
end
function FromClient_MonsterBuffZone_DecreaseMonsterBuffZoneEndurance(newEndurance, maxEndurance)
  local self = PaGlobal_MonsterBuffZone
  if self == nil then
    return
  end
  self:updateEndurance(newEndurance, maxEndurance)
end
