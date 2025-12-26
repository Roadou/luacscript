function PaGlobal_ShipCannon:initialize()
  if true == PaGlobal_ShipCannon._initialize then
    return
  end
  local panels = {
    [self._eCannon.left] = Panel_Widget_ShipCannon_Left,
    [self._eCannon.right] = Panel_Widget_ShipCannon_Right
  }
  self._ui._progress_powerGauge = {}
  self._ui._stc_cooltimes = {}
  self._ui._stc_cannonReady = {}
  self._ui._txt_bulletCount = {}
  for i = self._eCannon.left, self._eCannon.loopCount do
    self._ui._progress_powerGauge[i] = UI.getChildControl(panels[i], "CircularProgress_Press")
    self._ui._stc_cooltimes[i] = {}
    self._ui._stc_cooltimes[i][self._eCooltime.one] = UI.getChildControl(panels[i], "Static_CoolTime_1")
    self._ui._stc_cooltimes[i][self._eCooltime.two] = UI.getChildControl(panels[i], "Static_CoolTime_2")
    self._ui._stc_cooltimes[i][self._eCooltime.three] = UI.getChildControl(panels[i], "Static_CoolTime_3")
    self._ui._stc_cooltimes[i][self._eCooltime.ready] = UI.getChildControl(panels[i], "Static_CoolTime_Ready")
    self._ui._stc_cannonReady[i] = UI.getChildControl(panels[i], "Static_CannonReady")
    self._ui._txt_bulletCount[i] = UI.getChildControl(panels[i], "StaticText_BulletCount")
  end
  self._ui._stc_autoFishingGauge = UI.getChildControl(Panel_Widget_ShipCannon_Right, "Static_WorkerFishBG")
  self._ui._progress_FishingGauge = UI.getChildControl(self._ui._stc_autoFishingGauge, "Progress2_1")
  self._ui._stc_cantAutoFish = UI.getChildControl(self._ui._stc_autoFishingGauge, "Static_DontUse")
  self._ui._stc_fishDiscardArrow = UI.getChildControl(self._ui._stc_autoFishingGauge, "Button_Arrow")
  self._ui._stc_fishDiscardArrow:SetShow(_ContentsGroup_EmployeeAutoFishingDiscard == true)
  PaGlobal_ShipCannon:repositionAll()
  PaGlobal_ShipCannon:registEventHandler()
  PaGlobal_ShipCannon:validate()
  if ToClient_isConsole() == true or _ContentsGroup_UsePadSnapping == true then
    UI.getChildControl(Panel_Widget_ShipCannon_Left, "Static_MouseGuide"):SetShow(false)
    UI.getChildControl(Panel_Widget_ShipCannon_Right, "Static_MouseGuide"):SetShow(false)
  else
    UI.getChildControl(Panel_Widget_ShipCannon_Left, "Static_MouseGuide"):SetShow(true)
    UI.getChildControl(Panel_Widget_ShipCannon_Right, "Static_MouseGuide"):SetShow(true)
  end
  PaGlobal_ShipCannon._initialize = true
  FromClient_ShipCannon_PlayerRideOn()
end
function PaGlobal_ShipCannon:registEventHandler()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  registerEvent("EventSelfPlayerRideOn", "FromClient_ShipCannon_PlayerRideOn")
  registerEvent("EventSelfPlayerRideOff", "FromClient_ShipCannon_PlayerRideOff")
  registerEvent("FromClient_UpdateCannonStatCount", "FromClient_UpdateCannonStatCount")
  registerEvent("onScreenResize", "FromClient_ShipCannon_OnScreenResize")
  registerEvent("FromClient_UpdateCannonCoolTime_Left", "FromClient_UpdateCannonCoolTime_Left")
  registerEvent("FromClient_UpdateCannonCoolTime_Right", "FromClient_UpdateCannonCoolTime_Right")
  ActionChartEventBindFunction(420, PaGloabl_ShipCannon_ActionEventGaugeFull_Left)
  ActionChartEventBindFunction(421, PaGloabl_ShipCannon_ActionEventAfterFire_Left)
  ActionChartEventBindFunction(422, PaGloabl_ShipCannon_ActionEventGaugeOne_Left)
  ActionChartEventBindFunction(423, PaGloabl_ShipCannon_ActionEventGaugeTwo_Left)
  ActionChartEventBindFunction(424, PaGloabl_ShipCannon_ActionEventHideGauge_Left)
  ActionChartEventBindFunction(425, PaGloabl_ShipCannon_ActionEventGaugeFull_Right)
  ActionChartEventBindFunction(426, PaGloabl_ShipCannon_ActionEventAfterFire_Right)
  ActionChartEventBindFunction(427, PaGloabl_ShipCannon_ActionEventGaugeOne_Right)
  ActionChartEventBindFunction(428, PaGloabl_ShipCannon_ActionEventGaugeTwo_Right)
  ActionChartEventBindFunction(429, PaGloabl_ShipCannon_ActionEventHideGauge_Right)
  if _ContentsGroup_EmployeeAutoFishing == true then
    Panel_Widget_ShipCannon_Right:RegisterUpdateFunc("UpdateFunc_ShipCannon_UpdateAutoFishingGauge")
  end
  self._ui._stc_cantAutoFish:addInputEvent("Mouse_On", "PaGloabl_ShipCannon_CantAutoFishingTooltip(true)")
  self._ui._stc_cantAutoFish:addInputEvent("Mouse_Out", "PaGloabl_ShipCannon_CantAutoFishingTooltip(false)")
  self._ui._stc_autoFishingGauge:addInputEvent("Mouse_On", "PaGloabl_ShipCannon_CanAutoFishingTooltip(true)")
  self._ui._stc_autoFishingGauge:addInputEvent("Mouse_Out", "PaGloabl_ShipCannon_CanAutoFishingTooltip(false)")
  if _ContentsGroup_EmployeeAutoFishingDiscard == true then
    self._ui._stc_autoFishingGauge:addInputEvent("Mouse_LUp", "PaGloabl_SailorAutoFishingDiscard_All_Open()")
    self._ui._stc_fishDiscardArrow:addInputEvent("Mouse_LUp", "PaGloabl_SailorAutoFishingDiscard_All_Open()")
  end
end
function PaGlobal_ShipCannon:prepareOpen(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    if true == Panel_Widget_ShipCannon_Left:GetShow() then
      return
    end
  elseif self._eCannon.right == eCannon and true == Panel_Widget_ShipCannon_Right:GetShow() then
    return
  end
  if _ContentsGroup_EmployeeAutoFishingDiscard == true then
    self._ui._stc_fishDiscardArrow:SetShow(true)
    if PaGlobal_SailorAutoFishingDiscard_All._currentSelectGrade >= PaGlobal_SailorAutoFishingDiscard_All._eGradeList._none and PaGlobal_SailorAutoFishingDiscard_All._currentSelectGrade < PaGlobal_SailorAutoFishingDiscard_All._eGradeList._count then
      self._ui._stc_fishDiscardArrow:SetColor(PaGlobal_SailorAutoFishingDiscard_All._arrowGradeColor[PaGlobal_SailorAutoFishingDiscard_All._currentSelectGrade])
    end
  end
  Panel_Widget_ShipCannon_Left:RegisterUpdateFunc("HandleEventUpdate_ShipCannon_GuageUpdateFrame")
  PaGlobal_ShipCannon:open(eCannon)
end
function PaGlobal_ShipCannon:open(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    Panel_Widget_ShipCannon_Left:SetShow(true)
  elseif self._eCannon.right == eCannon then
    Panel_Widget_ShipCannon_Right:SetShow(true)
  else
    Panel_Widget_ShipCannon_Left:SetShow(true)
    Panel_Widget_ShipCannon_Right:SetShow(true)
    PaGlobal_ShipCannon:repositionAll()
    return
  end
  PaGlobal_ShipCannon:reposition(eCannon)
end
function PaGlobal_ShipCannon:prepareClose(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    if false == Panel_Widget_ShipCannon_Left:GetShow() then
      return
    end
  elseif self._eCannon.right == eCannon and false == Panel_Widget_ShipCannon_Right:GetShow() then
    return
  end
  self._autoFishingEffectOn = false
  Panel_Widget_ShipCannon_Left:ClearUpdateLuaFunc("HandleEventUpdate_ShipCannon_GuageUpdateFrame")
  PaGlobal_ShipCannon:close(eCannon)
end
function PaGlobal_ShipCannon:close(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  if self._eCannon.left == eCannon then
    Panel_Widget_ShipCannon_Left:SetShow(false)
  elseif self._eCannon.right == eCannon then
    Panel_Widget_ShipCannon_Right:SetShow(false)
  end
end
function PaGlobal_ShipCannon:update()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
end
function PaGlobal_ShipCannon:validate()
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  for i = self._eCannon.left, self._eCannon.loopCount do
    self._ui._progress_powerGauge[i]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.one]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.two]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.three]:isValidate()
    self._ui._stc_cooltimes[i][self._eCooltime.ready]:isValidate()
    self._ui._stc_cannonReady[i]:isValidate()
    self._ui._txt_bulletCount[i]:isValidate()
  end
end
function PaGlobal_ShipCannon:updateCooltime(eCannon, eCooltime)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  PaGlobal_ShipCannon:hideCooltime(eCannon)
  self._ui._stc_cooltimes[eCannon][eCooltime]:SetShow(true)
  if self._eCooltime.ready == eCooltime then
    self._ui._stc_cannonReady[eCannon]:SetShow(true)
  end
end
function PaGlobal_ShipCannon:hideCooltime(eCannon)
  if nil == Panel_Widget_ShipCannon_Left or nil == Panel_Widget_ShipCannon_Right then
    return
  end
  for i = self._eCooltime.one, self._eCooltime.loopCount do
    self._ui._stc_cooltimes[eCannon][i]:SetShow(false)
  end
  self._ui._stc_cannonReady[eCannon]:SetShow(false)
end
function PaGlobal_ShipCannon:reposition(eCannon)
  if _ContentsGroup_EmployeeAutoFishing == true then
    if self._eCannon.left == eCannon then
      if Panel_Widget_ShipCannon_Left ~= nil and Panel_Widget_SailControl ~= nil then
        Panel_Widget_ShipCannon_Left:SetPosX(Panel_Widget_SailControl:GetPosX() - Panel_Widget_ShipCannon_Left:GetSizeX())
        Panel_Widget_ShipCannon_Left:SetPosY(Panel_Widget_SailControl:GetPosY() + Panel_Widget_ShipCannon_Left:GetSizeY() * 0.5)
      end
    elseif self._eCannon.right == eCannon and Panel_Widget_ShipCannon_Right ~= nil and Panel_Widget_OceanWind ~= nil then
      Panel_Widget_ShipCannon_Right:SetPosX(Panel_Widget_OceanWind:GetPosX() + Panel_Widget_ShipCannon_Right:GetSizeX())
      Panel_Widget_ShipCannon_Right:SetPosY(Panel_Widget_OceanWind:GetPosY() + Panel_Widget_ShipCannon_Right:GetSizeY() * 0.5)
    end
  elseif self._eCannon.left == eCannon then
    if nil ~= Panel_Widget_ShipCannon_Left and nil ~= Panel_Widget_OceanCurrent then
      Panel_Widget_ShipCannon_Left:SetPosX(Panel_Widget_ShipSpeedGauge:GetPosX() - Panel_Widget_ShipCannon_Left:GetSizeX())
      Panel_Widget_ShipCannon_Left:SetPosY(Panel_Widget_OceanCurrent:GetPosY() + Panel_Widget_ShipCannon_Left:GetSizeY() * 0.5)
    end
  elseif self._eCannon.right == eCannon and nil ~= Panel_Widget_ShipCannon_Right and nil ~= Panel_Widget_OceanWind then
    Panel_Widget_ShipCannon_Right:SetPosX(Panel_Widget_OceanWind:GetPosX() + Panel_Widget_ShipCannon_Right:GetSizeX())
    Panel_Widget_ShipCannon_Right:SetPosY(Panel_Widget_OceanWind:GetPosY() + Panel_Widget_ShipCannon_Right:GetSizeY() * 0.5)
  end
end
function PaGlobal_ShipCannon:repositionAll()
  for i = self._eCannon.left, self._eCannon.loopCount do
    self:reposition(i)
  end
end
function PaGlobal_ShipCannon:updateBulletCount(count)
  for i = self._eCannon.left, self._eCannon.loopCount do
    self._ui._txt_bulletCount[i]:SetText(count)
  end
end
function PaGlobal_ShipCannon:updateGaugeAll(percent)
  self:updateGauge(self._eCannon.left, percent)
  self:updateGauge(self._eCannon.right, percent)
end
function PaGlobal_ShipCannon:updateGauge(eCannon, percent)
  self._ui._progress_powerGauge[eCannon]:SetProgressRate(percent)
end
function PaGlobal_ShipCannon:SetShowGuageAll(isShow)
  self:SetShowGuage(self._eCannon.left, isShow)
  self:SetShowGuage(self._eCannon.right, isShow)
end
function PaGlobal_ShipCannon:SetShowGuage(eCannon, isShow)
  self._ui._progress_powerGauge[eCannon]:SetShow(isShow)
end
function PaGlobal_ShipCannon:hideGuageAndCache()
  self:SetShowGuageAll(false)
  self.currentPower = ToClient_getCommonGauge()
  self:updateGaugeAll(0)
end
