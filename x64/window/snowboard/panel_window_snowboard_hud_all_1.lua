function PaGlobal_SnowBoardHud:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_coinCount = UI.getChildControl(Panel_Window_SnowBoard_Hud_All, "StaticText_CoinCount")
  self._ui.stc_timerBg = UI.getChildControl(Panel_Window_SnowBoard_Hud_All, "Static_TimerBg")
  self._ui.txt_timer = UI.getChildControl(self._ui.stc_timerBg, "StaticText_TimeCount")
  self._ui.stc_checkDetail = UI.getChildControl(Panel_Window_SnowBoard_Hud_All, "Static_CheckedDetail")
  local checkPointBG = UI.getChildControl(self._ui.stc_checkDetail, "Static_CheckCountBG")
  self._ui.stc_checkPointValue = UI.getChildControl(checkPointBG, "StaticText_CheckCountValue")
  self._ui.stc_penaltyBg = UI.getChildControl(self._ui.stc_checkDetail, "Static_CheckPenaltyBG")
  local penaltySub = UI.getChildControl(self._ui.stc_penaltyBg, "Static_CheckPenaltySubBG")
  self._ui.stc_failCheckPointValue = UI.getChildControl(penaltySub, "StaticText_FailCountValue")
  self._ui.stc_penaltyGroup = UI.getChildControl(self._ui.stc_penaltyBg, "Static_PenaltyTimeGroup")
  self._ui.stc_penaltyTime = UI.getChildControl(self._ui.stc_penaltyGroup, "StaticText_PenaltyTimeValue")
  local checkPointBG = UI.getChildControl(Panel_Window_SnowBoard_Hud_All, "Static_CheckPointInfoBG")
  local checkPointProgress = UI.getChildControl(checkPointBG, "Static_CheckProgressGroup")
  self._ui.stc_checkPointProgressBase = UI.getChildControl(checkPointProgress, "Static_ProgressBase")
  local checkPointProgressBar = UI.getChildControl(self._ui.stc_checkPointProgressBase, "Static_CurrentProgressGroup")
  self._ui.stc_checkPointActive = UI.getChildControl(self._ui.stc_checkPointProgressBase, "Static_CheckPointGroup_Active")
  for index = 0, self._checkPointUIMax - 1 do
    local groupContol = UI.getChildControl(self._ui.stc_checkPointProgressBase, "Static_CheckPointGroup_" .. index)
    local barControl = UI.cloneControl(checkPointProgressBar, self._ui.stc_checkPointProgressBase, "Static_CheckPointBar_" .. index)
    local listControl = {
      iconGroup = groupContol,
      iconBase = UI.getChildControl(groupContol, "Static_Base"),
      barGroup = barControl,
      barBase = UI.getChildControl(barControl, "Static_Base")
    }
    self._progBar[index] = listControl
  end
  self._ui.btn_rideSnowBoard = UI.getChildControl(Panel_Window_SnowBoard_Hud_All, "Button_RideBoard")
  self._ui.btn_rideKeyGuide = UI.getChildControl(self._ui.btn_rideSnowBoard, "Static_KeyGuide")
  self._ui.btn_rideKeyGuide:SetShow(self._isConsole)
  self._progressSizeX = self._ui.stc_checkPointProgressBase:GetSizeX()
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_SnowBoardHud:registEventHandler()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  self._ui.btn_rideSnowBoard:addInputEvent("Mouse_LUp", "ToClient_StartSnowBoardAction()")
  registerEvent("FromClient_SnowBoardRaceReady", "FromClient_SnowBoardHud_PrepareRace")
  registerEvent("FromClient_SnowBoardRaceStart", "FromClient_SnowBoardHud_StartRace")
  registerEvent("FromClient_SnowBoardRaceComplete", "FromClient_SnowBoardHud_EndRace")
  registerEvent("FromClient_AcquireSnowBoardCoin", "FromClient_SnowBoardHud_AcquireCoin")
  registerEvent("FromClient_SnowBoardSuccessCheckPoint", "PaGlobalFunc_SnowBoardHud_SuccessCheckPoint")
end
function PaGlobal_SnowBoardHud:prepareOpen(courseKeyRaw)
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(courseKeyRaw)
  if snowBoardStatic == nil then
    return
  end
  self._snowBoardCourseMode = snowBoardStatic:getMode()
  self._lastUpdateCheckPointIndex = -1
  local mode = snowBoardStatic:getMode()
  if self._snowBoardCourseMode == __eSnowBoardCourseMode_Item then
    self._ui.txt_coinCount:SetShow(true)
  elseif self._snowBoardCourseMode == __eSnowBoardCourseMode_Speed then
    self._ui.txt_coinCount:SetShow(true)
  else
    return
  end
  ToClient_WorldMapNaviClear()
  self:prepareCheckPointBar(courseKeyRaw)
  self:updateCheckPointBar()
  self:updateCheckText()
  self:resetTimer()
  self:open()
  Panel_Window_SnowBoard_Hud_All:ClearUpdateLuaFunc()
  Panel_Window_SnowBoard_Hud_All:RegisterUpdateFunc("PaGlobalFunc_SnowBoardHud_ActionButton")
end
function PaGlobal_SnowBoardHud:open()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  Panel_Window_SnowBoard_Hud_All:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_Window_SnowBoard_Hud_All:ComputePosAllChild()
  Panel_Window_SnowBoard_Hud_All:SetShow(true)
end
function PaGlobal_SnowBoardHud:prepareClose()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  self:resetTimer()
  self:close()
end
function PaGlobal_SnowBoardHud:close()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  Panel_Window_SnowBoard_Hud_All:SetShow(false)
end
function PaGlobal_SnowBoardHud:setCoinCount(totalCoinCount)
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  self._ui.txt_coinCount:SetText(totalCoinCount)
  self._ui.txt_coinCount:AddEffect("fUI_SnowBoard_Coin_01A", false, 0, 0)
end
function PaGlobal_SnowBoardHud:setTopTextSpeedMode()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  local checkPointCount = 0
  local currentIndex = ToClient_SnowBoardCurrentCheckPointIndex()
  if currentIndex < 0 then
    checkPointCount = 0
  else
    checkPointCount = currentIndex + 1
  end
  local totalCheckPointCount = ToClient_SnowBoardCourseCheckPointCount()
  local checkPointString = checkPointCount .. "/" .. totalCheckPointCount
  self._ui.txt_coinCount:SetText(checkPointString)
end
function PaGlobal_SnowBoardHud:startTimer()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  self._startTickCount = getTickCount32()
  self._raceTickCount = 0
  self:updateTimerText()
  Panel_Window_SnowBoard_Hud_All:ClearUpdateLuaFunc()
  Panel_Window_SnowBoard_Hud_All:RegisterUpdateFunc("PaGlobalFunc_SnowBoardHud_Update")
end
function PaGlobal_SnowBoardHud:resetTimer()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  self._startTickCount = 0
  self._raceTickCount = 0
  self:updateTimerText()
  self._ui.btn_rideSnowBoard:SetShow(false)
  Panel_Window_SnowBoard_Hud_All:ClearUpdateLuaFunc()
end
function PaGlobal_SnowBoardHud:updateTimerText()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  local min = math.floor(self._raceTickCount / 60000)
  local second = math.floor(self._raceTickCount % 60000 / 1000)
  local millis = math.floor(self._raceTickCount % 1000)
  if min > 99 then
    return
  end
  local timerText = string.format("%02d:%02d:%03d", min, second, millis)
  self._ui.txt_timer:SetText(timerText)
end
function PaGlobal_SnowBoardHud:update(deltaTime)
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  if Panel_Widget_Common_Countdown:GetShow() == true then
    local depth = Panel_Widget_Common_Countdown:GetDepth()
    Panel_Window_SnowBoard_Hud_All:SetDepth(depth + 1)
  end
  local actionButton = ToClient_CanStartSnowBoardAction()
  self._ui.btn_rideSnowBoard:SetShow(actionButton)
  self._raceTickCount = getTickCount32() - self._startTickCount
  self:updateTimerText()
end
function PaGlobal_SnowBoardHud:prepareCheckPointBar(courseKeyRaw)
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  local snowBoardStatic = ToClient_GetSnowBoardStaticStatusByKey(courseKeyRaw)
  if snowBoardStatic == nil then
    return
  end
  self._checkPointCount = snowBoardStatic:getCheckPointCount()
  for index = 0, self._checkPointUIMax - 1 do
    self._progBar[index].iconGroup:SetShow(false)
    self._progBar[index].barGroup:SetShow(false)
  end
  local needPositionChange = self._checkPointCount < self._checkPointUIMax
  if needPositionChange == true then
    for index = 0, self._checkPointCount - 1 do
      self._progBar[index].iconGroup:SetShow(true)
      self._progBar[index].barGroup:SetShow(true)
      self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(self._checkPointBase)
      local textureId = self._progressBase
      self._progBar[index].barBase:ChangeTextureInfoTextureIDAsync(textureId)
      self._progBar[index].barBase:setRenderTexture(self._progBar[index].barBase:getBaseTexture())
      if index ~= self._checkPointCount - 1 then
        self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(self._checkPointBase)
      else
        self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(self._checkPointGoal)
      end
      self._progBar[index].iconBase:setRenderTexture(self._progBar[index].iconBase:getBaseTexture())
    end
    local oncePosX = 0
    if self._checkPointCount > 0 then
      oncePosX = self._progressSizeX / self._checkPointCount
    else
      oncePosX = self._progressSizeX / self._checkPointUIMax
    end
    for index = 0, self._checkPointCount - 1 do
      self._progBar[index].iconGroup:SetSpanSize((index + 1) * oncePosX - 15, -20)
      self._progBar[index].barGroup:SetSpanSize(index * oncePosX, 0)
      local sizeY = self._progBar[index].barBase:GetSizeY()
      self._progBar[index].barGroup:SetSize(oncePosX, sizeY)
      self._progBar[index].barBase:SetSize(oncePosX, sizeY)
    end
  else
    for index = 0, self._checkPointUIMax - 1 do
      self._progBar[index].iconGroup:SetShow(true)
      self._progBar[index].barGroup:SetShow(true)
      self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(self._checkPointBase)
      self._progBar[index].iconBase:setRenderTexture(self._progBar[index].iconBase:getBaseTexture())
      local textureId = self._progressBase
      self._progBar[index].barBase:ChangeTextureInfoTextureIDAsync(textureId)
      self._progBar[index].barBase:setRenderTexture(self._progBar[index].barBase:getBaseTexture())
    end
    if self._checkPointCount <= self._checkPointUIMax then
      self._progBar[self._checkPointUIMax - 1].iconBase:ChangeTextureInfoTextureIDAsync(self._checkPointGoal)
      self._progBar[self._checkPointUIMax - 1].iconBase:setRenderTexture(self._progBar[self._checkPointUIMax - 1].iconBase:getBaseTexture())
    end
    local oncePosX = self._progressSizeX / self._checkPointUIMax
    for index = 0, self._checkPointUIMax - 1 do
      self._progBar[index].iconGroup:SetSpanSize((index + 1) * oncePosX - 15, -20)
      self._progBar[index].barGroup:SetSpanSize(index * oncePosX, 0)
      local sizeY = self._progBar[index].barBase:GetSizeY()
      self._progBar[index].barGroup:SetSize(oncePosX, sizeY)
      self._progBar[index].barBase:SetSize(oncePosX, sizeY)
    end
  end
end
function PaGlobal_SnowBoardHud:updateCheckPointBar()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  if self._checkPointCount < 0 then
    return
  end
  self._ui.stc_checkPointActive:SetShow(false)
  local currentIndex = ToClient_SnowBoardCurrentCheckPointIndex()
  local isBasicMode = self._checkPointCount <= self._checkPointUIMax
  if isBasicMode == true then
    for index = 0, currentIndex do
      local isSuccess = ToClient_SnowBoardCheckPointState(index)
      local iconTextureId = self._checkPointBase
      local textureId = self._progressBase
      if isSuccess == 1 then
        textureId = self._progressSucess
        iconTextureId = self._checkPointPass
      end
      if index > self._lastUpdateCheckPointIndex and index <= currentIndex then
        textureId = self._progressActive
      end
      if isSuccess ~= 1 then
        textureId = self._progressFail
        if index >= self._lastUpdateCheckPointIndex then
          self._progBar[index].barBase:EraseAllEffect()
          local sizeX = self._progBar[index].barBase:GetSizeX() * 0.5
          self._progBar[index].barBase:AddEffect("fUI_SnowBoard_Check_02A", false, sizeX, 0)
        end
      end
      self._progBar[index].iconGroup:SetShow(true)
      self._progBar[index].barBase:ChangeTextureInfoTextureIDAsync(textureId)
      self._progBar[index].barBase:setRenderTexture(self._progBar[index].barBase:getBaseTexture())
    end
    if currentIndex >= 0 then
      self._progBar[currentIndex].iconGroup:SetShow(false)
      self._ui.stc_checkPointActive:SetShow(true)
      self._ui.stc_checkPointActive:SetSpanSize(self._progBar[currentIndex].iconGroup:GetSpanSize().x, self._ui.stc_checkPointActive:GetSpanSize().y)
      local isSuccess = ToClient_SnowBoardCheckPointState(currentIndex)
      self._progBar[currentIndex].barBase:EraseAllEffect()
      local sizeX = self._progBar[currentIndex].barBase:GetSizeX() * 0.5
      self._progBar[currentIndex].barBase:AddEffect("fUI_SnowBoard_Check_01A", false, sizeX, 0)
    end
  else
    local currentIndex = ToClient_SnowBoardCurrentCheckPointIndex()
    if currentIndex < self._checkPointUpdateCount then
      for index = 0, currentIndex do
        local isSuccess = ToClient_SnowBoardCheckPointState(index)
        local iconTextureId = self._checkPointBase
        local textureId = self._progressBase
        if isSuccess == 1 then
          textureId = self._progressSucess
          iconTextureId = self._checkPointPass
        end
        if index > self._lastUpdateCheckPointIndex and index <= currentIndex then
          textureId = self._progressActive
        end
        if isSuccess ~= 1 then
          textureId = self._progressFail
          if index >= self._lastUpdateCheckPointIndex then
            self._progBar[index].barBase:EraseAllEffect()
            local sizeX = self._progBar[index].barBase:GetSizeX() * 0.5
            self._progBar[index].barBase:AddEffect("fUI_SnowBoard_Check_02A", false, sizeX, 0)
          end
        end
        self._progBar[index].iconGroup:SetShow(true)
        self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(iconTextureId)
        self._progBar[index].iconBase:setRenderTexture(self._progBar[index].iconBase:getBaseTexture())
        self._progBar[index].barBase:ChangeTextureInfoTextureIDAsync(textureId)
        self._progBar[index].barBase:setRenderTexture(self._progBar[index].barBase:getBaseTexture())
      end
      if currentIndex >= 0 then
        self._progBar[currentIndex].iconGroup:SetShow(false)
        self._ui.stc_checkPointActive:SetShow(true)
        self._ui.stc_checkPointActive:SetSpanSize(self._progBar[currentIndex].iconGroup:GetSpanSize().x, self._ui.stc_checkPointActive:GetSpanSize().y)
        local isSuccess = ToClient_SnowBoardCheckPointState(currentIndex)
        self._progBar[currentIndex].barBase:EraseAllEffect()
        local sizeX = self._progBar[currentIndex].barBase:GetSizeX() * 0.5
        self._progBar[currentIndex].barBase:AddEffect("fUI_SnowBoard_Check_01A", false, sizeX, 0)
      end
    else
      if currentIndex >= self._checkPointCount - self._checkPointUIMax + self._checkPointUpdateCount then
        for index = 0, self._checkPointUIMax - 1 do
          local checkPointIndex = self._checkPointCount - self._checkPointUIMax + index
          local isSuccess = ToClient_SnowBoardCheckPointState(checkPointIndex)
          local iconTextureId = self._checkPointBase
          local textureId = self._progressBase
          if isSuccess == 1 then
            textureId = self._progressSucess
            iconTextureId = self._checkPointPass
          elseif currentIndex > checkPointIndex then
            textureId = self._progressFail
            iconTextureId = self._checkPointFail
            if checkPointIndex >= self._lastUpdateCheckPointIndex then
              self._progBar[index].barBase:EraseAllEffect()
              local sizeX = self._progBar[index].barBase:GetSizeX() * 0.5
              self._progBar[index].barBase:AddEffect("fUI_SnowBoard_Check_02A", false, sizeX, 0)
            end
          end
          if checkPointIndex == currentIndex then
            textureId = self._progressActive
          end
          if checkPointIndex == currentIndex then
            self._progBar[index].iconGroup:SetShow(false)
            self._ui.stc_checkPointActive:SetShow(true)
            self._ui.stc_checkPointActive:SetSpanSize(self._progBar[index].iconGroup:GetSpanSize().x, self._ui.stc_checkPointActive:GetSpanSize().y)
            self._progBar[index].barBase:EraseAllEffect()
            local sizeX = self._progBar[index].barBase:GetSizeX() * 0.5
            self._progBar[index].barBase:AddEffect("fUI_SnowBoard_Check_01A", false, sizeX, 0)
          else
            self._progBar[index].iconGroup:SetShow(true)
          end
          self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(iconTextureId)
          self._progBar[index].iconBase:setRenderTexture(self._progBar[index].iconBase:getBaseTexture())
          self._progBar[index].barBase:ChangeTextureInfoTextureIDAsync(textureId)
          self._progBar[index].barBase:setRenderTexture(self._progBar[index].barBase:getBaseTexture())
        end
      else
        for index = 0, self._checkPointUIMax - 1 do
          local checkPointIndex = index + (currentIndex - self._checkPointUpdateCount + 1)
          local isSuccess = ToClient_SnowBoardCheckPointState(checkPointIndex)
          local iconTextureId = self._checkPointBase
          local textureId = self._progressBase
          if isSuccess == 1 then
            textureId = self._progressSucess
            iconTextureId = self._checkPointPass
          elseif currentIndex > checkPointIndex then
            textureId = self._progressFail
            iconTextureId = self._checkPointFail
            if checkPointIndex >= self._lastUpdateCheckPointIndex then
              self._progBar[index].barBase:EraseAllEffect()
              local sizeX = self._progBar[index].barBase:GetSizeX() * 0.5
              self._progBar[index].barBase:AddEffect("fUI_SnowBoard_Check_02A", false, sizeX, 0)
            end
          end
          if checkPointIndex == currentIndex then
            textureId = self._progressActive
          end
          if checkPointIndex == currentIndex then
            self._progBar[index].iconGroup:SetShow(false)
            self._ui.stc_checkPointActive:SetShow(true)
            self._ui.stc_checkPointActive:SetSpanSize(self._progBar[index].iconGroup:GetSpanSize().x, self._ui.stc_checkPointActive:GetSpanSize().y)
            self._progBar[index].barBase:EraseAllEffect()
            local sizeX = self._progBar[index].barBase:GetSizeX() * 0.5
            self._progBar[index].barBase:AddEffect("fUI_SnowBoard_Check_01A", false, sizeX, 0)
          else
            self._progBar[index].iconGroup:SetShow(true)
          end
          self._progBar[index].iconBase:ChangeTextureInfoTextureIDAsync(iconTextureId)
          self._progBar[index].iconBase:setRenderTexture(self._progBar[index].iconBase:getBaseTexture())
          self._progBar[index].barBase:ChangeTextureInfoTextureIDAsync(textureId)
          self._progBar[index].barBase:setRenderTexture(self._progBar[index].barBase:getBaseTexture())
        end
      end
      if currentIndex >= self._checkPointCount - self._checkPointUIMax + self._checkPointUpdateCount then
        self._progBar[self._checkPointUIMax - 1].iconBase:ChangeTextureInfoTextureIDAsync(self._checkPointGoal)
        self._progBar[self._checkPointUIMax - 1].iconBase:setRenderTexture(self._progBar[self._checkPointUIMax - 1].iconBase:getBaseTexture())
      end
    end
  end
  self._lastUpdateCheckPointIndex = currentIndex
end
function PaGlobal_SnowBoardHud:updateCheckText()
  if Panel_Window_SnowBoard_Hud_All == nil then
    return
  end
  local currentIndex = ToClient_SnowBoardCurrentCheckPointIndex()
  local currentCheckPointCount = currentIndex + 1
  local failPassedCheckPointCount = ToClient_SnowBoardFailCheckPointCount()
  self._ui.stc_checkPointValue:SetText(currentCheckPointCount - failPassedCheckPointCount)
  self._ui.stc_failCheckPointValue:SetText(failPassedCheckPointCount)
  local penaltyTick = ToClient_RacePenaltyTick()
  local min = math.floor(penaltyTick / 60000)
  local second = math.floor(penaltyTick % 60000 / 1000)
  local penaltyString = string.format("%02d:%02d", min, second)
  if penaltyTick == 0 then
    self._ui.stc_penaltyTime:SetText("")
  else
    local text = self._ui.stc_penaltyTime:GetText()
    self._ui.stc_penaltyTime:EraseAllEffect()
    if text ~= penaltyString then
      audioPostEvent_SystemUi(11, 176)
      self._ui.stc_penaltyTime:AddEffect("fUI_SnowBoard_Penalty_01A", false, 0, 0)
    end
    self._ui.stc_penaltyTime:SetText(penaltyString)
  end
  if self._snowBoardCourseMode == __eSnowBoardCourseMode_Item then
    self:setCoinCount(ToClient_SnowBoardCoinCount())
  elseif self._snowBoardCourseMode == __eSnowBoardCourseMode_Speed then
    self:setTopTextSpeedMode()
  end
end
