function PaGlobal_ToolTip_Servant_All:initialize()
  if true == PaGlobal_ToolTip_Servant_All._initialize then
    return
  end
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  self._ui.stc_mouseL = UI.getChildControl(Panel_Widget_Tooltip_Servant_All, "Static_MouseLBtn")
  self._ui.stc_possibleL = UI.getChildControl(self._ui.stc_mouseL, "Static_PossibleIcon")
  self._ui.stc_impossibleL = UI.getChildControl(self._ui.stc_mouseL, "Static_ImpossibleIcon")
  self._ui.stc_descL = UI.getChildControl(self._ui.stc_mouseL, "StaticText_Desc")
  self._ui.stc_desc1L = UI.getChildControl(self._ui.stc_mouseL, "StaticText_Desc1")
  self._ui.stc_desc2L = UI.getChildControl(self._ui.stc_mouseL, "StaticText_Desc2")
  self._ui.stc_mouseR = UI.getChildControl(Panel_Widget_Tooltip_Servant_All, "Static_MouseRBtn")
  self._ui.stc_possibleR = UI.getChildControl(self._ui.stc_mouseR, "Static_PossibleIcon")
  self._ui.stc_impossibleR = UI.getChildControl(self._ui.stc_mouseR, "Static_ImpossibleIcon")
  self._ui.stc_descR = UI.getChildControl(self._ui.stc_mouseR, "StaticText_Desc")
  self._ui.stc_desc1R = UI.getChildControl(self._ui.stc_mouseR, "StaticText_Desc1")
  self._ui.stc_desc2R = UI.getChildControl(self._ui.stc_mouseR, "StaticText_Desc2")
  self._ui.stc_distance = UI.getChildControl(Panel_Widget_Tooltip_Servant_All, "StaticText_DistanceValue")
  self._ui.stc_calldistance = UI.getChildControl(Panel_Widget_Tooltip_Servant_All, "StaticText_CallDistanceValue")
  self._ui.stc_haveitem = UI.getChildControl(Panel_Widget_Tooltip_Servant_All, "StaticText_HaveItem")
  PaGlobal_ToolTip_Servant_All:registEventHandler()
  PaGlobal_ToolTip_Servant_All:validate()
  PaGlobal_ToolTip_Servant_All._initialize = true
end
function PaGlobal_ToolTip_Servant_All:registEventHandler()
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  registerEvent("FromClient_ShowSimpleDialog", "PaGlobal_ToolTip_Servant_All_Open")
  registerEvent("FromClient_HideSimpleDialog", "PaGlobal_ToolTip_Servant_All_Close")
  registerEvent("onScreenResize", "PaGlobal_ToolTip_Servant_All_OnScreenSizeRefresh")
end
function PaGlobal_ToolTip_Servant_All:prepareOpen(control, servantType)
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  if servantType == __eServantTypeShip then
    Panel_Widget_Tooltip_Servant_All:SetSize(350, 200)
    Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, 350, 200)
    self._ui.stc_mouseR:SetSpanSize(10, 70)
    self._ui.stc_distance:SetSize(310, 20)
    self._ui.stc_distance:SetSpanSize(20, 170)
    self._ui.stc_calldistance:SetSize(310, 20)
    self._ui.stc_calldistance:SetSpanSize(20, 140)
  else
    Panel_Widget_Tooltip_Servant_All:SetSize(250, 180)
    Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, 250, 180)
    self._ui.stc_mouseR:SetSpanSize(10, 50)
    self._ui.stc_distance:SetSize(210, 20)
    self._ui.stc_distance:SetSpanSize(20, 150)
    self._ui.stc_calldistance:SetSize(210, 20)
    self._ui.stc_calldistance:SetSpanSize(20, 120)
  end
  self._ui.stc_possibleL:SetShow(false)
  self._ui.stc_impossibleL:SetShow(false)
  self._ui.stc_descL:SetShow(false)
  self._ui.stc_desc1L:SetShow(false)
  self._ui.stc_desc2L:SetShow(false)
  self._ui.stc_possibleR:SetShow(false)
  self._ui.stc_impossibleR:SetShow(false)
  self._ui.stc_descR:SetShow(false)
  self._ui.stc_desc1R:SetShow(false)
  self._ui.stc_desc2R:SetShow(false)
  self._ui.stc_haveitem:SetShow(false)
  if servantType == __eServantTypeVehicle then
    local isPremiumPcRoom = false
    local temporaryWrapper = getTemporaryInformationWrapper()
    if temporaryWrapper ~= nil then
      isPremiumPcRoom = temporaryWrapper:isPremiumPcRoom()
    end
    local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
    if nil ~= landVehicleWrapper then
    end
    local isShowCrogDalog = PaGlobal_ToolTip_Servant_All:dohaveCrogAndUnsealed()
    self._ui.stc_descL:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_VEHICLECALL"))
    self._ui.stc_descR:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_VEHICLELOCATION"))
    local isRecall = ToClient_GetCallableVehicle(__eServantTypeVehicle, __eServantCallType_Recall)
    local resetDistance = ToClient_GetUnsealVehicleResetDistance(__eServantTypeVehicle)
    local betweenDistance = ToClient_GetPlayerBetweenVehicle(__eServantTypeVehicle)
    if isRecall == true then
      self._ui.stc_possibleL:SetShow(false)
      self._ui.stc_impossibleL:SetShow(false)
    else
      self._ui.stc_impossibleL:SetShow(false)
      self._ui.stc_possibleL:SetShow(false)
    end
    if CppEnums.VehicleType.Type_Carriage ~= landVehicleWrapper:getVehicleType() and CppEnums.VehicleType.Type_CowCarriage ~= landVehicleWrapper:getVehicleType() and CppEnums.VehicleType.Type_RepairableCarriage ~= landVehicleWrapper:getVehicleType() then
      local superWhistle = ToClient_GetContentsEventItemName(__eContentsType_SuperWhistle)
      local orderToServant = ToClient_GetContentsEventItemName(__eContentsType_OrderToServant)
      if superWhistle ~= "" then
        self._ui.stc_haveitem:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_HAVEITEM", "itemName", superWhistle))
        self._ui.stc_haveitem:SetShow(true)
      elseif isPremiumPcRoom == true then
        self._ui.stc_haveitem:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_HAVEITEM", "itemName", PAGetString(Defines.StringSheet_GAME, "LUA_SELFPLAYEREXPGAGE_PCROOM_TITLE")))
        self._ui.stc_haveitem:SetShow(true)
      elseif orderToServant ~= "" then
        self._ui.stc_haveitem:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_HAVEITEM", "itemName", orderToServant))
        self._ui.stc_haveitem:SetShow(true)
      else
        Panel_Widget_Tooltip_Servant_All:SetSize(250, 160)
        Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, 250, 160)
        self._ui.stc_distance:SetSpanSize(20, 130)
        self._ui.stc_calldistance:SetSpanSize(20, 100)
        self._ui.stc_haveitem:SetShow(false)
      end
    else
      Panel_Widget_Tooltip_Servant_All:SetSize(250, 160)
      Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, 250, 160)
      self._ui.stc_distance:SetSpanSize(20, 130)
      self._ui.stc_calldistance:SetSpanSize(20, 100)
    end
    local callDistance
    if doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) == true or isPremiumPcRoom == true and _ContentsGroup_PremeumPCRoomSuperWhistle == true then
      if CppEnums.VehicleType.Type_Carriage ~= landVehicleWrapper:getVehicleType() and CppEnums.VehicleType.Type_CowCarriage ~= landVehicleWrapper:getVehicleType() and CppEnums.VehicleType.Type_RepairableCarriage ~= landVehicleWrapper:getVehicleType() then
        callDistance = PAGetString(Defines.StringSheet_GAME, "LUA_TRADEMARKET_SELLLIST_REMAININFINITY")
      else
        callDistance = resetDistance / 100
      end
    else
      callDistance = resetDistance / 100
    end
    local distance = math.ceil(math.sqrt(betweenDistance) / 100 / 10) * 10
    local stc_callDistance = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_CALLDISTANCE", "distance", callDistance)
    local stc_distance = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_CURRENTDISTANCE", "currentDistance", distance)
    self._ui.stc_calldistance:SetText(stc_callDistance)
    self._ui.stc_distance:SetText(stc_distance)
    if isRecall == false then
      self._ui.stc_distance:SetText("<PAColor0xFFEE6E57>" .. stc_distance .. "<PAOldColor>")
    end
    if isShowCrogDalog == true then
      if doHaveContentsItem(__eContentsType_SuperWhistle, CppEnums.VehicleType.Type_Horse) == true or isPremiumPcRoom == true and _ContentsGroup_PremeumPCRoomSuperWhistle == true then
        self._ui.stc_descL:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_VEHICLECALL"))
      elseif callDistance < distance then
        self._ui.stc_descL:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_VEHICLELOCATION"))
      else
        self._ui.stc_descL:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_VEHICLECALL"))
      end
      self._ui.stc_descR:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTICON_TREASURETOOLTIP"))
      Panel_Widget_Tooltip_Servant_All:SetSize(self._ui.stc_descL:GetTextSizeX() + 10, 180)
    end
    self._ui.stc_descL:SetShow(true)
    self._ui.stc_descR:SetShow(true)
    if self._ui.stc_haveitem:GetShow() == true then
      if Panel_Widget_Tooltip_Servant_All:GetSizeX() <= self._ui.stc_haveitem:GetTextSizeX() + 50 then
        Panel_Widget_Tooltip_Servant_All:SetSize(self._ui.stc_haveitem:GetTextSizeX() + 100, Panel_Widget_Tooltip_Servant_All:GetSizeY())
        Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, self._ui.stc_haveitem:GetTextSizeX() + 100, Panel_Widget_Tooltip_Servant_All:GetSizeY())
      end
    elseif Panel_Widget_Tooltip_Servant_All:GetSizeX() <= self._ui.stc_calldistance:GetTextSizeX() + 50 then
      Panel_Widget_Tooltip_Servant_All:SetSize(self._ui.stc_calldistance:GetTextSizeX() + 100, Panel_Widget_Tooltip_Servant_All:GetSizeY())
      Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, self._ui.stc_calldistance:GetTextSizeX() + 100, Panel_Widget_Tooltip_Servant_All:GetSizeY())
    end
    if Panel_Widget_Tooltip_Servant_All:GetSizeX() <= self._ui.stc_desc1L:GetTextSizeX() + 30 then
      Panel_Widget_Tooltip_Servant_All:SetSize(self._ui.stc_desc1L:GetTextSizeX() + 30, Panel_Widget_Tooltip_Servant_All:GetSizeY())
      Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, self._ui.stc_desc1L:GetTextSizeX() + 30, Panel_Widget_Tooltip_Servant_All:GetSizeY())
    end
  else
    local isRecall = ToClient_GetCallableVehicle(__eServantTypeShip, __eServantCallType_Recall)
    local isRide = ToClient_GetCallableVehicle(__eServantTypeShip, __eServantCallType_Ride)
    self._ui.stc_impossibleR:SetShow(false)
    self._ui.stc_possibleR:SetShow(false)
    if isRide == true then
      self._ui.stc_possibleL:SetShow(false)
      self._ui.stc_impossibleL:SetShow(false)
    else
      self._ui.stc_impossibleL:SetShow(false)
      self._ui.stc_possibleL:SetShow(false)
    end
    local resetDistance = ToClient_GetUnsealVehicleResetDistance(__eServantTypeShip)
    local betweenDistance = ToClient_GetPlayerBetweenVehicle(__eServantTypeShip)
    local callDistance = math.sqrt(resetDistance) / 100
    local distance = math.ceil(math.sqrt(betweenDistance) / 100 / 10) * 10
    local stc_callDistance = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_CALLDISTANCE", "distance", callDistance)
    local stc_distance = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WIDGET_SERVANTICON_TOOLTIP_CURRENTDISTANCE", "currentDistance", distance)
    local stc_desc1R = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_SHIPCALL", "distance", callDistance)
    local stc_desc2R = PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WIDGET_SERVANTICON_TOOLTIP_SHIPLOCATION", "distance", callDistance)
    self._ui.stc_calldistance:SetText(stc_callDistance)
    self._ui.stc_distance:SetText(stc_distance)
    self._ui.stc_desc1R:SetText(stc_desc1R)
    self._ui.stc_desc2R:SetText(stc_desc2R)
    local lengthyControl
    if self._ui.stc_desc1L:GetTextSizeX() < self._ui.stc_desc2R:GetTextSizeX() then
      lengthyControl = self._ui.stc_desc2R
    else
      lengthyControl = self._ui.stc_desc1L
    end
    if Panel_Widget_Tooltip_Servant_All:GetSizeX() <= lengthyControl:GetTextSizeX() + 50 then
      Panel_Widget_Tooltip_Servant_All:SetSize(lengthyControl:GetTextSizeX() + 100, Panel_Widget_Tooltip_Servant_All:GetSizeY())
      Panel_Widget_Tooltip_Servant_All:SetEnableArea(0, 0, lengthyControl:GetTextSizeX() + 100, Panel_Widget_Tooltip_Servant_All:GetSizeY())
    end
    self._ui.stc_desc1L:SetShow(true)
    self._ui.stc_desc2L:SetShow(true)
    self._ui.stc_desc1R:SetShow(true)
    self._ui.stc_desc2R:SetShow(true)
  end
  Panel_Widget_Tooltip_Servant_All:SetShow(true)
  PaGlobal_ToolTip_Servant_All:TooltipServant_Show(control)
end
function PaGlobal_ToolTip_Servant_All:open()
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  Panel_Widget_Tooltip_Servant_All:SetShow(true)
end
function PaGlobal_ToolTip_Servant_All:prepareClose()
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  PaGlobal_ToolTip_Servant_All:close()
end
function PaGlobal_ToolTip_Servant_All:close()
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  Panel_Widget_Tooltip_Servant_All:SetShow(false)
end
function PaGlobal_ToolTip_Servant_All:validate()
  if nil == Panel_Widget_Tooltip_Servant_All then
    return
  end
  self._ui.stc_mouseL:isValidate()
  self._ui.stc_possibleL:isValidate()
  self._ui.stc_impossibleL:isValidate()
  self._ui.stc_descL:isValidate()
  self._ui.stc_desc1L:isValidate()
  self._ui.stc_desc2L:isValidate()
  self._ui.stc_mouseR:isValidate()
  self._ui.stc_possibleR:isValidate()
  self._ui.stc_impossibleR:isValidate()
  self._ui.stc_descR:isValidate()
  self._ui.stc_desc1R:isValidate()
  self._ui.stc_desc2R:isValidate()
  self._ui.stc_distance:isValidate()
  self._ui.stc_calldistance:isValidate()
  self._ui.stc_haveitem:isValidate()
end
function PaGlobal_ToolTip_Servant_All:dohaveCrogAndUnsealed()
  if _ContentsGroup_Crogdalo == false then
    return false
  end
  if doHaveContentsItem(__eContentsType_Crogdalo) == false then
    return false
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  local servantInfo = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if nil == servantInfo then
    return false
  end
  if servantInfo:canUseCrogdaloNest() == false then
    return false
  end
  return true
end
function PaGlobal_ToolTip_Servant_All:TooltipServant_Show(uiControl)
  local parentPos = {
    x = uiControl:GetParentPosX(),
    y = uiControl:GetParentPosY()
  }
  local size = {
    x = uiControl:GetSizeX(),
    y = uiControl:GetSizeY()
  }
  PaGlobal_ToolTip_Servant_All:TooltipServant_SetPosition(parentPos, size, reversePosX)
end
function PaGlobal_ToolTip_Servant_All:TooltipServant_SetPosition(parentPos, size, reversePosX)
  local tooltipShow = Panel_Widget_Tooltip_Servant_All:GetShow()
  if not tooltipShow then
    return
  end
  Panel_Tooltip_SimpleText:SetShow(false)
  if Panel_Tooltip_SimpleText:IsUISubApp() == true then
    Panel_Tooltip_SimpleText:CloseUISubApp()
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local itemPosX = Panel_Widget_Tooltip_Servant_All:GetSizeX()
  local itemPosY = Panel_Widget_Tooltip_Servant_All:GetSizeY()
  local posX = parentPos.x
  local posY = parentPos.y
  local isLeft = false
  if true == reversePosX then
    isLeft = posX < screenSizeX / 2
  else
    isLeft = posX > screenSizeX / 2
  end
  local isTop = posY > screenSizeY / 2
  local tooltipSize = {width = 0, height = 0}
  local tooltipEquipped = {width = 0, height = 0}
  local sumSize = {width = 0, height = 0}
  if Panel_Widget_Tooltip_Servant_All:GetShow() then
    tooltipSize.width = Panel_Widget_Tooltip_Servant_All:GetSizeX()
    tooltipSize.height = Panel_Widget_Tooltip_Servant_All:GetSizeY()
    sumSize.width = sumSize.width + tooltipSize.width
    sumSize.height = math.max(sumSize.height, tooltipSize.height)
  end
  if not isLeft then
    posX = posX + size.x
  end
  if isTop then
    posY = posY + size.y
    local yDiff = posY - sumSize.height
    if yDiff < 0 then
      posY = posY - yDiff
    end
  else
    local yDiff = screenSizeY - (posY + sumSize.height)
    if yDiff < 0 then
      posY = posY + yDiff
    end
  end
  if Panel_Widget_Tooltip_Servant_All:GetShow() then
    if isLeft then
      posX = posX - tooltipSize.width
    end
    local yTmp = posY
    if isTop then
      yTmp = yTmp - tooltipSize.height
    end
    Panel_Widget_Tooltip_Servant_All:SetPosX(mousePosX + 15)
    Panel_Widget_Tooltip_Servant_All:SetPosY(mousePosY + 15)
    if screenSizeX < Panel_Widget_Tooltip_Servant_All:GetPosX() + Panel_Widget_Tooltip_Servant_All:GetSizeX() then
      Panel_Widget_Tooltip_Servant_All:SetPosX(mousePosX - Panel_Widget_Tooltip_Servant_All:GetSizeX())
    else
      Panel_Widget_Tooltip_Servant_All:SetPosX(mousePosX + 15)
    end
    if screenSizeY < Panel_Widget_Tooltip_Servant_All:GetPosY() + Panel_Widget_Tooltip_Servant_All:GetSizeY() then
      Panel_Widget_Tooltip_Servant_All:SetPosY(mousePosY - Panel_Widget_Tooltip_Servant_All:GetSizeY())
    else
      Panel_Widget_Tooltip_Servant_All:SetPosY(mousePosY + 15)
    end
  end
end
