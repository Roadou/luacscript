function PaGlobal_HardCoreResult:initialize()
  if PaGlobal_HardCoreResult._initialize == true then
    return
  end
  self._ui._stc_CenterArea = UI.getChildControl(Panel_Window_Hardcore_Result, "Static_CenterArea")
  self._ui._txt_CharacterName = UI.getChildControl(self._ui._stc_CenterArea, "StaticText_CharName")
  self._ui._txt_PlayTime = UI.getChildControl(self._ui._stc_CenterArea, "StaticText_PlayTime")
  self._ui._stc_PlayTimeIcon = UI.getChildControl(self._ui._txt_PlayTime, "Static_Icon")
  self._ui._txt_GetPoint = UI.getChildControl(self._ui._stc_CenterArea, "StaticText_GetPoint")
  self._ui._stc_PointIcon = UI.getChildControl(self._ui._txt_GetPoint, "Static_Icon")
  self._ui._stc_HorizonArrow = UI.getChildControl(self._ui._stc_CenterArea, "Static_HorizonArrow")
  self._ui._txt_AfterPoint = UI.getChildControl(self._ui._stc_CenterArea, "StaticText_AfterPoint")
  self._ui._txt_PointStatusDesc = UI.getChildControl(self._ui._stc_CenterArea, "StaticText_PointStatusDesc")
  local gaugeBg = UI.getChildControl(self._ui._stc_CenterArea, "Static_GaugeBG")
  self._ui._stc_RankPointProgress = UI.getChildControl(gaugeBg, "Progress2_MinusPoint")
  self._ui._stc_CoinPointProgress = UI.getChildControl(gaugeBg, "Progress2_FixPoint")
  self._ui._btn_Cinfirm = UI.getChildControl(self._ui._stc_CenterArea, "Button_Confirm")
  self._ui._btn_Close = UI.getChildControl(Panel_Window_Hardcore_Result, "Button_Close")
  self._ui._txt_ExchangeCoinCount = UI.getChildControl(self._ui._stc_CenterArea, "StaticText_Coin")
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_HardCoreResult:registEventHandler()
  PaGlobal_HardCoreResult:validate()
  self._selfPlayer = getSelfPlayer()
  if self._selfPlayer ~= nil then
    self._ui._txt_CharacterName:SetText(self._selfPlayer:getOriginalName())
  end
  Panel_Window_Hardcore_Result:SetSize(getScreenSizeX(), getScreenSizeY())
  PaGlobal_HardCoreResult._initialize = true
end
function PaGlobal_HardCoreResult:registEventHandler()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  registerEvent("FromClient_HardCoreResultOpen", "PaGlobal_HardCoreResult_Open")
  self._ui._btn_Cinfirm:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreResult:accumulateCurrentRankPoint()")
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_HardCoreResult_Close()")
end
function PaGlobal_HardCoreResult:validate()
end
function PaGlobal_HardCoreResult:prepareOpen()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  self:update()
  self:open()
end
function PaGlobal_HardCoreResult:open()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  Panel_Window_Hardcore_Result:SetShow(true)
end
function PaGlobal_HardCoreResult:prepareClose()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  self:close()
end
function PaGlobal_HardCoreResult:close()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  Panel_Window_Hardcore_Result:SetShow(false)
end
function PaGlobal_HardCoreResult:setPlayTime()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  local s64_PlayTime = ToClient_getHardCorePlayTime()
  local s64_hourCycle = toInt64(0, 3600)
  local s64_minuteCycle = toInt64(0, 60)
  local s64_hour = s64_PlayTime / s64_hourCycle
  local s64_minute = (s64_PlayTime - s64_hourCycle * s64_hour) / s64_minuteCycle
  local hourString = tostring(s64_hour)
  local minuteString = tostring(s64_minute)
  local limit = toInt64(0, 10)
  if s64_hour < limit then
    hourString = "0" .. hourString
  end
  if s64_minute < limit then
    minuteString = "0" .. minuteString
  end
  local leftTimeText = hourString .. " : " .. minuteString
  local resultText = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HARDCORE_RESULT_PLAYTIME", "time", leftTimeText)
  self._ui._txt_PlayTime:SetText(resultText)
  self._ui._txt_PlayTime:SetSize(self._ui._txt_PlayTime:GetTextSizeX() + self._ui._stc_PlayTimeIcon:GetSizeX(), self._ui._txt_PlayTime:GetSizeY())
  local centerPos = self._ui._stc_CenterArea:GetSizeX() * 0.5
  local sizeX = self._ui._txt_PlayTime:GetSizeX()
  self._ui._txt_PlayTime:SetPosX(centerPos - sizeX * 0.5)
end
function PaGlobal_HardCoreResult:setPointDesc(string, point, color)
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  self._ui._txt_PointStatusDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, string, "point", tostring(point)))
  self._ui._txt_PointStatusDesc:SetShow(true)
  self._ui._stc_HorizonArrow:SetColor(color)
  self._ui._txt_AfterPoint:SetFontColor(color)
end
function PaGlobal_HardCoreResult:setPointGauge()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  local lastRankPoint = ToClient_getHardCoreAccumulatedPoint()
  local currentRankPoint = ToClient_getHardCoreRankPoint()
  local coinPoint = ToClient_getHardCoreCoinPoint()
  local maxCount = ToClient_getHardCoreExchangeCoinMaxCount()
  self._ui._txt_GetPoint:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_HARDCORE_RESULT_GETPOINT", "point", tostring(lastRankPoint)))
  self._ui._txt_GetPoint:SetSize(self._ui._txt_GetPoint:GetTextSizeX() + self._ui._stc_PointIcon:GetSizeX(), self._ui._txt_GetPoint:GetSizeY())
  self._ui._txt_AfterPoint:SetText(tostring(currentRankPoint))
  self._ui._txt_AfterPoint:SetSize(self._ui._txt_AfterPoint:GetTextSizeX(), self._ui._txt_AfterPoint:GetSizeY())
  local controlTotalSizeX = self._ui._txt_GetPoint:GetSizeX() + self._ui._stc_HorizonArrow:GetSizeX() + self._ui._txt_AfterPoint:GetSizeX()
  local centerPos = self._ui._stc_CenterArea:GetSizeX() * 0.5
  self._ui._txt_GetPoint:SetPosX(centerPos - controlTotalSizeX * 0.5)
  self._ui._stc_HorizonArrow:SetPosX(self._ui._txt_GetPoint:GetPosX() + self._ui._txt_GetPoint:GetSizeX())
  self._ui._txt_AfterPoint:SetPosX(self._ui._stc_HorizonArrow:GetPosX() + self._ui._stc_HorizonArrow:GetSizeX())
  local rankPoint = 0
  if lastRankPoint < currentRankPoint then
    rankPoint = currentRankPoint - lastRankPoint
  end
  local exchangePoint = coinPoint + rankPoint
  if maxCount < exchangePoint then
    rankPoint = rankPoint - (exchangePoint - maxCount)
    exchangePoint = maxCount
  end
  self._ui._txt_ExchangeCoinCount:SetText(tostring(exchangePoint))
  local coinPointRate = coinPoint / maxCount * 100
  local rankPointRate = exchangePoint / maxCount * 100
  self._ui._stc_CoinPointProgress:SetProgressRate(coinPointRate)
  self._ui._stc_RankPointProgress:SetProgressRate(rankPointRate)
  if lastRankPoint < currentRankPoint then
    self:setPointDesc("LUA_HARDCORE_RESULT_INCREASEPOINT", currentRankPoint - lastRankPoint, Defines.Color.C_FFF5BA3A)
  elseif lastRankPoint > currentRankPoint then
    self:setPointDesc("LUA_HARDCORE_RESULT_DECREASEPOINT", lastRankPoint - currentRankPoint, Defines.Color.C_FFBA2737)
  else
    self._ui._txt_PointStatusDesc:SetShow(false)
  end
end
function PaGlobal_HardCoreResult:update()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  self:setPlayTime()
  self:setPointGauge()
end
function PaGlobal_HardCoreResult:accumulateCurrentRankPoint()
  if Panel_Window_Hardcore_Result == nil then
    return
  end
  ToClient_AccumulateCurrentRankPoint()
end
