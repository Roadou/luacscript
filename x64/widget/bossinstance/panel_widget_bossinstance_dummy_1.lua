function PaGlobal_BossInstance_Dummy:initialize()
  self:validate()
  self:registerEvent()
  self._initialize = true
  self:prepareOpen()
end
function PaGlobal_BossInstance_Dummy:clear()
end
function PaGlobal_BossInstance_Dummy:prepareOpen()
  self:open()
end
function PaGlobal_BossInstance_Dummy:open()
  if false == self._initialize then
    return
  end
  if false == _ContentsGroup_InstanceWorldBoss then
    return
  end
  if false == ToClient_IsInstanceFieldPlayerbyContentsType(__eeInstanceContentsType_WorldBoss) then
    return
  end
  self:clear()
  Panel_Widget_BossInstance_Dummy:SetShow(true)
end
function PaGlobal_BossInstance_Dummy:prepareClose()
  self:close()
end
function PaGlobal_BossInstance_Dummy:close()
  Panel_Widget_BossInstance_Dummy:SetShow(false)
end
function PaGlobal_BossInstance_Dummy:validate()
end
function PaGlobal_BossInstance_Dummy:registerEvent()
end
