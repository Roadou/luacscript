function PaGlobal_CameraMode_All:initialize()
  if true == PaGlobal_CameraMode_All._initialize or nil == Panel_Widget_CameraMode_All then
    return
  end
  self._ui.stc_title = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Title_Bg")
  self._ui.txt_distance = UI.getChildControl(self._ui.stc_title, "StaticText_Number")
  self._ui.stc_line[self._sequence.LEFT_TOP] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Line1")
  self._ui.stc_dot[self._sequence.LEFT_TOP] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Dot1")
  self._ui.stc_line[self._sequence.RIGHT_TOP] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Line2")
  self._ui.stc_dot[self._sequence.RIGHT_TOP] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Dot2")
  self._ui.stc_line[self._sequence.LEFT_BOTTOM] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Line3")
  self._ui.stc_dot[self._sequence.LEFT_BOTTOM] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Dot3")
  self._ui.stc_line[self._sequence.RIGHT_BOTTOM] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Line4")
  self._ui.stc_dot[self._sequence.RIGHT_BOTTOM] = UI.getChildControl(Panel_Widget_CameraMode_All, "Static_Dot4")
  self:initDotLine()
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_CameraMode_All:validate()
  PaGlobal_CameraMode_All:registEventHandler()
  PaGlobal_CameraMode_All:swichPlatform(self._isConsole)
  PaGlobal_CameraMode_All._initialize = true
end
function PaGlobal_CameraMode_All:initDotLine()
  self._dotLine = {}
  for index = 1, 4 do
    self._dotLine[index] = {}
  end
  self._dotLine[self._sequence.LEFT_TOP].startX = self._ui.stc_line[self._sequence.LEFT_TOP]:GetPosX() + self._ui.stc_line[self._sequence.LEFT_TOP]:GetSizeX()
  self._dotLine[self._sequence.LEFT_TOP].startY = self._ui.stc_line[self._sequence.LEFT_TOP]:GetPosY() + self._ui.stc_line[self._sequence.LEFT_TOP]:GetSizeY()
  self._dotLine[self._sequence.LEFT_TOP].endX = self._ui.stc_line[self._sequence.LEFT_TOP]:GetPosX()
  self._dotLine[self._sequence.LEFT_TOP].endY = self._ui.stc_line[self._sequence.LEFT_TOP]:GetPosY()
  self._dotLine[self._sequence.LEFT_TOP].xType = -1
  self._dotLine[self._sequence.LEFT_TOP].yType = -1
  self._dotLine[self._sequence.RIGHT_TOP].startX = self._ui.stc_line[self._sequence.RIGHT_TOP]:GetPosX()
  self._dotLine[self._sequence.RIGHT_TOP].startY = self._ui.stc_line[self._sequence.RIGHT_TOP]:GetPosY() + self._ui.stc_line[self._sequence.RIGHT_TOP]:GetSizeY()
  self._dotLine[self._sequence.RIGHT_TOP].endX = self._ui.stc_line[self._sequence.RIGHT_TOP]:GetPosX() + self._ui.stc_line[self._sequence.RIGHT_TOP]:GetSizeX()
  self._dotLine[self._sequence.RIGHT_TOP].endY = self._ui.stc_line[self._sequence.RIGHT_TOP]:GetPosY()
  self._dotLine[self._sequence.RIGHT_TOP].xType = 1
  self._dotLine[self._sequence.RIGHT_TOP].yType = -1
  self._dotLine[self._sequence.LEFT_BOTTOM].startX = self._ui.stc_line[self._sequence.LEFT_BOTTOM]:GetPosX() + self._ui.stc_line[self._sequence.LEFT_BOTTOM]:GetSizeX()
  self._dotLine[self._sequence.LEFT_BOTTOM].startY = self._ui.stc_line[self._sequence.LEFT_BOTTOM]:GetPosY()
  self._dotLine[self._sequence.LEFT_BOTTOM].endX = self._ui.stc_line[self._sequence.LEFT_BOTTOM]:GetPosX()
  self._dotLine[self._sequence.LEFT_BOTTOM].endY = self._ui.stc_line[self._sequence.LEFT_BOTTOM]:GetPosY() + self._ui.stc_line[self._sequence.LEFT_BOTTOM]:GetSizeY()
  self._dotLine[self._sequence.LEFT_BOTTOM].xType = -1
  self._dotLine[self._sequence.LEFT_BOTTOM].yType = 1
  self._dotLine[self._sequence.RIGHT_BOTTOM].startX = self._ui.stc_line[self._sequence.RIGHT_BOTTOM]:GetPosX()
  self._dotLine[self._sequence.RIGHT_BOTTOM].startY = self._ui.stc_line[self._sequence.RIGHT_BOTTOM]:GetPosY()
  self._dotLine[self._sequence.RIGHT_BOTTOM].endX = self._ui.stc_line[self._sequence.RIGHT_BOTTOM]:GetPosX() + self._ui.stc_line[self._sequence.RIGHT_BOTTOM]:GetSizeX()
  self._dotLine[self._sequence.RIGHT_BOTTOM].endY = self._ui.stc_line[self._sequence.RIGHT_BOTTOM]:GetPosY() + self._ui.stc_line[self._sequence.RIGHT_BOTTOM]:GetSizeY()
  self._dotLine[self._sequence.RIGHT_BOTTOM].xType = 1
  self._dotLine[self._sequence.RIGHT_BOTTOM].yType = 1
end
function PaGlobal_CameraMode_All:swichPlatform(isConsole)
  if true == isConsole then
  else
  end
end
function PaGlobal_CameraMode_All:prepareOpen()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  if false == _ContentsGroup_PadCameraMoveMode then
    return
  end
  if housing_isBuildMode() or housing_isInstallMode() then
    return
  end
  self._minDistance = ToClient_getCharacterCameraMinDistance()
  self._maxDistance = ToClient_getCharacterCameraMaxDistance()
  self._distanceCheckInterval = 0
  PaGlobal_CameraMode_All:open()
  PaGlobal_CameraMode_All:update()
  PaGlobal_CameraMode_All:resize()
end
function PaGlobal_CameraMode_All:dataclear()
end
function PaGlobal_CameraMode_All:open()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  Panel_Widget_CameraMode_All:SetShow(true)
end
function PaGlobal_CameraMode_All:prepareClose()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  PaGlobalFunc_ConsoleKeyGuide_PopGuide()
  self:saveCameraSet()
  PaGlobal_CameraMode_All:close()
end
function PaGlobal_CameraMode_All:close()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  Panel_Widget_CameraMode_All:SetShow(false)
end
function PaGlobal_CameraMode_All:update()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  if false == Panel_Widget_CameraMode_All:GetShow() then
    return
  end
  self:updateNumber()
  self:updateDot()
end
function PaGlobal_CameraMode_All:updateNumber()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  self._curDistance = characterCameraDistanceFromCharacter()
  self._distancePer = math.floor(self._curDistance / self._maxDistance * 100)
  self._ui.txt_distance:SetText(string.format("%.0f", self._distancePer) .. "%")
end
function PaGlobal_CameraMode_All:updateDot()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  for spot = 1, 4 do
    if nil ~= self._ui.stc_line[spot] then
      local linePosX = self._dotLine[spot].startX + self._ui.stc_line[spot]:GetSizeX() * math.abs(self._distancePer / 100) * self._dotLine[spot].xType
      local linePosY = self._dotLine[spot].startY + self._ui.stc_line[spot]:GetSizeY() * math.abs(self._distancePer / 100) * self._dotLine[spot].yType
      self._ui.stc_dot[spot]:SetPosX(linePosX)
      self._ui.stc_dot[spot]:SetPosY(linePosY)
    end
  end
end
function PaGlobal_CameraMode_All:saveCameraSet()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  if false == Panel_Widget_CameraMode_All:GetShow() then
    return
  end
  if false == self._isConsole then
    return
  end
  local curCameraAdditional = characterCameraAdditionalTranslation()
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__ePadCameraDistanceFromCharacter, self._curDistance, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__ePadCameraFromCharacterPosX, curCameraAdditional.x, CppEnums.VariableStorageType.eVariableStorageType_User)
  ToClient_getGameUIManagerWrapper():setLuaCacheDataListNumber(__ePadCameraFromCharacterPosY, curCameraAdditional.y, CppEnums.VariableStorageType.eVariableStorageType_User)
end
function PaGlobal_CameraMode_All:registEventHandler()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_CameraMode_All_onScreenResize")
  registerEvent("FromClient_changePadCameraControlMode", "FromClient_CameraMode_All_ChangePadCameraControlMode")
  registerEvent("FromClient_SetCamDistFromCharacter", "FromClient_CameraMode_All_SetCamDistText")
end
function PaGlobal_CameraMode_All:validate()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
end
function PaGlobal_CameraMode_All:resize()
  if nil == Panel_Widget_CameraMode_All then
    return
  end
  Panel_Widget_CameraMode_All:ComputePos()
end
