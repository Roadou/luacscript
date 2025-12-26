PaGlobal_Edania_Join = {
  _dragStart = false,
  _mousePosX = 0,
  _mousePosY = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Edania_Join_Init")
function FromClient_Edania_Join_Init()
  PaGlobal_Edania_Join:initialize()
end
function PaGlobal_Edania_Join:initialize()
  if self._initialize == true then
    return
  end
  self:registEventHandler()
  self:validate()
  self._initialize = true
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper ~= nil then
    local edaniaRegion = ToClient_GetEdaniaRegion(selfPlayerWrapper:getUserNo())
    if edaniaRegion ~= __eEdaniaRegion_Count then
      PaGlobal_Edania_Join_OpenUI()
    end
  end
end
function PaGlobal_Edania_Join:registEventHandler()
  if Panel_Window_Edania_Join == nil then
    return
  end
  registerEvent("FromClient_OpenEdaniaJoinButton", "FromClient_OpenEdaniaJoinButton")
  Panel_Window_Edania_Join:addInputEvent("Mouse_LDown", "HandleEventLUp_Edania_Join_DragStart()")
  Panel_Window_Edania_Join:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Join_OpenUI()")
end
function PaGlobal_Edania_Join:prepareOpen()
  if Panel_Window_Edania_Join == nil then
    return
  end
  local _stc_effect = UI.getChildControl(Panel_Window_Edania_Join, "Static_Effect")
  _stc_effect:EraseAllEffect()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper ~= nil then
    local userNo = selfPlayerWrapper:getUserNo()
    if ToClient_IsShowJoinEffect(userNo) == true then
      _stc_effect:AddEffect("fUI_Edania_Join_01A", true, 0, 0)
    end
  end
  self:loadPos()
  self:open()
end
function PaGlobal_Edania_Join:open()
  if Panel_Window_Edania_Join == nil then
    return
  end
  Panel_Window_Edania_Join:SetShow(true)
end
function PaGlobal_Edania_Join:prepareClose()
  if Panel_Window_Edania_Join == nil then
    return
  end
  PaGlobal_Edania_Join_SavePos()
  self:close()
end
function PaGlobal_Edania_Join:close()
  if Panel_Window_Edania_Join == nil then
    return
  end
  Panel_Window_Edania_Join:SetShow(false)
end
function PaGlobal_Edania_Join:loadPos()
  if Panel_Window_Edania_Join == nil then
    return
  end
  if ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eEdaniaJoinButtonPosX) == false or ToClient_getGameUIManagerWrapper():hasLuaCacheDataList(__eEdaniaJoinButtonPosY) == false then
    return
  end
  local posX = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eEdaniaJoinButtonPosX)
  local posY = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eEdaniaJoinButtonPosY)
  if posX >= getScreenSizeX() or posY >= getScreenSizeY() then
    Panel_Window_Edania_Join:ComputePosAllChild()
    return
  end
  Panel_Window_Edania_Join:SetPosXY(posX, posY)
end
function PaGlobal_Edania_Join:validate()
  if Panel_Window_Edania_Join == nil then
    return
  end
end
function PaGlobal_Edania_Join_OpenUI()
  local self = PaGlobal_Edania_Join
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobal_Edania_Join_CloseUI()
  local self = PaGlobal_Edania_Join
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_Edania_Join_SavePos()
  local self = PaGlobal_Edania_Join
  if self == nil then
    return
  end
  if Panel_Window_Edania_Join:GetShow() == false then
    return
  end
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eEdaniaJoinButtonPosX, Panel_Window_Edania_Join:GetPosX(), CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__eEdaniaJoinButtonPosY, Panel_Window_Edania_Join:GetPosY(), CppEnums.VariableStorageType.eVariableStorageType_User)
end
function HandleEventLUp_Edania_Join_DragStart()
  local self = PaGlobal_Edania_Join
  if self == nil then
    return
  end
  self._dragStart = true
  self._mousePosX = getMousePosX()
  self._mousePosY = getMousePosY()
end
function HandleEventLUp_Edania_Join_OpenUI()
  local self = PaGlobal_Edania_Join
  if self == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local edaniaRegion = ToClient_GetEdaniaRegion(selfPlayerWrapper:getUserNo())
  if edaniaRegion == __eEdaniaRegion_Count then
    return
  end
  if self._dragStart == true then
    local currentMousePoxX = getMousePosX()
    local currentMousePoxY = getMousePosY()
    local distance = math.sqrt((self._mousePosX - currentMousePoxX) ^ 2 + (self._mousePosY - currentMousePoxY) ^ 2)
    if distance > 1 then
      _dragStart = false
      return
    end
  end
  PaGlobal_Edania_Join_SavePos()
  if PaGlobal_Edania_Contents_Open ~= nil then
    PaGlobal_Edania_Contents_Open(PaGlobal_Edania_Contents.OPENTYPE.CHALLENGER, edaniaRegion, false)
  end
  self._dragStart = false
end
function FromClient_OpenEdaniaJoinButton(isShow)
  if isShow == true then
    PaGlobal_Edania_Join_OpenUI()
  else
    PaGlobal_Edania_Join_CloseUI()
  end
end
