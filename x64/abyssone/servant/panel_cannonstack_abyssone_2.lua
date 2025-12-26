function PaGlobalFunc_CannonStack_Open()
  local self = PaGlobal_CannonStack
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_CannonStack_Close()
  local self = PaGlobal_CannonStack
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_CannonStack_UpdatePanelPos(x, y)
  local panel = Panel_CannonStack
  if panel == nil then
    return
  end
  panel:SetPosX(x)
  panel:SetPosY(y)
  panel:ComputePosAllChild()
end
function FromAction_CannonStack_Stack_0()
  local self = PaGlobal_CannonStack
  if self == nil then
    return
  end
  self:updateStack(self._eStack._stack_0)
end
function FromAction_CannonStack_Stack_1()
  local self = PaGlobal_CannonStack
  if self == nil then
    return
  end
  self:updateStack(self._eStack._stack_1)
end
function FromAction_CannonStack_Stack_2()
  local self = PaGlobal_CannonStack
  if self == nil then
    return
  end
  self:updateStack(self._eStack._stack_2)
end
function FromAction_CannonStack_Stack_3()
  local self = PaGlobal_CannonStack
  if self == nil then
    return
  end
  self:updateStack(self._eStack._stack_3)
end
