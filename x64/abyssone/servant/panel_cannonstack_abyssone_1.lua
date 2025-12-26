function PaGlobal_CannonStack:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_stackBg_0 = UI.getChildControl(Panel_CannonStack, "Static_StackBG_0")
  self._ui._stc_stackBg_1 = UI.getChildControl(Panel_CannonStack, "Static_StackBG_1")
  self._ui._stc_stackBg_2 = UI.getChildControl(Panel_CannonStack, "Static_StackBG_2")
  self._ui._stc_stack_0 = UI.getChildControl(Panel_CannonStack, "Static_Stack_0")
  self._ui._stc_stack_1 = UI.getChildControl(Panel_CannonStack, "Static_Stack_1")
  self._ui._stc_stack_2 = UI.getChildControl(Panel_CannonStack, "Static_Stack_2")
  self._originalPosX = Panel_CannonStack:GetPosX()
  self._originalPosY = Panel_CannonStack:GetPosY()
  self:initList()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CannonStack:initList()
  if Panel_CannonStack == nil then
    return
  end
  self._cannonStackInfoList = Array.new()
  self:makeAndPushCannonStackInfo(0, 61036)
end
function PaGlobal_CannonStack:makeAndPushCannonStackInfo(index, targetVehicleCharacterKeyRaw)
  if Panel_CannonStack == nil then
    return
  end
  if self._cannonStackInfoList[index] ~= nil then
    UI.ASSERT_NAME(false, "index\234\176\128 \236\164\145\235\179\181\235\144\169\235\139\136\235\139\164. \236\130\189\236\158\133 \236\139\164\237\140\168.", "\236\157\180\236\163\188")
    return
  end
  local newData = {
    _characterKeyRaw = targetVehicleCharacterKeyRaw,
    _bgControlList = Array.new(),
    _stackControlList = Array.new()
  }
  if targetVehicleCharacterKeyRaw == 61036 then
    newData._bgControlList:push_back(self._ui._stc_stackBg_0)
    newData._bgControlList:push_back(self._ui._stc_stackBg_1)
    newData._bgControlList:push_back(self._ui._stc_stackBg_2)
    newData._stackControlList[self._eStack._stack_1] = self._ui._stc_stack_0
    newData._stackControlList[self._eStack._stack_2] = self._ui._stc_stack_1
    newData._stackControlList[self._eStack._stack_3] = self._ui._stc_stack_2
  end
  self._cannonStackInfoList[index] = newData
end
function PaGlobal_CannonStack:registEventHandler()
  if Panel_CannonStack == nil then
    return
  end
  registerEvent("EventSelfPlayerRideOn", "PaGlobalFunc_CannonStack_Open")
  registerEvent("EventSelfPlayerRideOff", "PaGlobalFunc_CannonStack_Close")
  ActionChartEventBindFunction(1100, FromAction_CannonStack_Stack_0)
  ActionChartEventBindFunction(1101, FromAction_CannonStack_Stack_1)
  ActionChartEventBindFunction(1102, FromAction_CannonStack_Stack_2)
  ActionChartEventBindFunction(1103, FromAction_CannonStack_Stack_3)
end
function PaGlobal_CannonStack:validate()
  if Panel_CannonStack == nil then
    return
  end
  self._ui._stc_stackBg_0:isValidate()
  self._ui._stc_stackBg_1:isValidate()
  self._ui._stc_stackBg_2:isValidate()
  self._ui._stc_stack_0:isValidate()
  self._ui._stc_stack_1:isValidate()
  self._ui._stc_stack_2:isValidate()
end
function PaGlobal_CannonStack:prepareOpen()
  if Panel_CannonStack == nil then
    return
  end
  local isLoadVehicleData = self:initShowData()
  if isLoadVehicleData == nil or isLoadVehicleData == false then
    return
  end
  self:open()
end
function PaGlobal_CannonStack:open()
  if Panel_CannonStack == nil then
    return
  end
  Panel_CannonStack:SetShow(true)
end
function PaGlobal_CannonStack:prepareClose()
  if Panel_CannonStack == nil then
    return
  end
  self._currentIndex = nil
  Panel_CannonStack:SetPosX(self._originalPosX)
  Panel_CannonStack:SetPosY(self._originalPosY)
  Panel_CannonStack:ComputePosAllChild()
  self:close()
end
function PaGlobal_CannonStack:close()
  if Panel_CannonStack == nil then
    return
  end
  Panel_CannonStack:SetShow(false)
end
function PaGlobal_CannonStack:initShowData()
  if Panel_CannonStack == nil then
    return false
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return false
  end
  local selfProxy = getSelfPlayer():get()
  if selfProxy == nil then
    return false
  end
  local actorKeyRaw = selfProxy:getRideVehicleActorKeyRaw()
  if actorKeyRaw == nil then
    return false
  end
  local vehicleProxy = getVehicleActor(actorKeyRaw)
  if vehicleProxy == nil then
    return false
  end
  local characterKeyRaw = vehicleProxy:getCharacterKeyRaw()
  local isExistData = false
  for key, value in pairs(self._cannonStackInfoList) do
    if value ~= nil and value._characterKeyRaw == characterKeyRaw then
      self._currentIndex = key
      isExistData = true
      break
    end
  end
  if isExistData == false or self._cannonStackInfoList[self._currentIndex] == nil then
    return false
  end
  for key, value in pairs(self._ui) do
    if value ~= nil then
      value:SetShow(false)
      value:ComputePos()
    end
  end
  for key, value in pairs(self._cannonStackInfoList[self._currentIndex]._bgControlList) do
    if value ~= nil then
      value:SetShow(true)
      value:ComputePos()
    end
  end
  return true
end
function PaGlobal_CannonStack:updateStack(enumStack)
  if Panel_CannonStack == nil then
    return
  end
  if enumStack >= self._eStack._count then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \237\131\145\236\138\185\235\172\188\236\157\152 enumStack\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  if self._currentIndex == nil then
    return
  end
  local currentData = self._cannonStackInfoList[self._currentIndex]
  if currentData == nil then
    UI.ASSERT_NAME(false, "\237\152\132\236\158\172 \236\157\184\235\141\177\236\138\164\236\151\144 \235\140\128\236\157\145\237\149\152\235\138\148 \235\141\176\236\157\180\237\132\176\234\176\128 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164. insert \234\181\172\235\172\184\236\157\132 \236\158\145\236\132\177\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  for key, value in pairs(currentData._stackControlList) do
    if value ~= nil then
      value:SetShow(false)
    end
  end
  for index = 0, enumStack do
    if currentData._stackControlList[index] ~= nil then
      currentData._stackControlList[index]:SetShow(true)
    end
  end
end
