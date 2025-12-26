function PaGlobalFunc_MiniGame_YachtDice_Close()
  local panel = Panel_Window_MiniGame_YachtDice
  if nil == panel then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  if nil == self then
    return
  end
  self:closeMsg()
end
function FromClient_responseYachtDiceGameStart()
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  if false == self:initHandRankList() then
    return
  end
  self:updateRecordInfo()
  self:updatePoint()
  self:updateRollCount()
  self._currentGameDbType = ToClient_getCurrentMiniGameYachtType()
  if __eMiniGameDBType_Count == self._currentGameDbType then
    return
  end
  if __eMiniGameDBType_YachtDice_PVP_Normal == self._currentGameDbType or __eMiniGameDBType_YachtDice_PVP_Match == self._currentGameDbType then
    self._isPvPFirstTurn = true
  end
  self._ui._stc_msgPhase:SetShow(false)
  self._ui._stc_keyGuideBG:SetShow(true)
  self._isStartGame = true
  if true == self._isConsole then
    Panel_Window_MiniGame_YachtDice:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobal_MiniGame_YachtDice:doRoll()")
  end
  self._ui._btn_roll:addInputEvent("Mouse_LUp", "PaGlobal_MiniGame_YachtDice:doRoll()")
  self:eventStartHandRank(false)
end
function FromClient_responseYachtDiceGameKeepCard(index, isKeep)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:updateKeepCard(index, isKeep)
end
function FromClient_responseYachtDiceGameRoll(isSelfRoll)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:updateFieldCard()
  self:updateRollCount()
  self._ui._stc_msgPhase:SetShow(false)
  self:updateRollCardList()
end
function FromClient_responseYachtDiceGameCheckHand(key, isSelf, point)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  if self._currentRenderEventType == self._renderEventType.DrawFieldCard then
    self:eventEndDrawCard()
  end
  self:updateCheckHandEffect(key, isSelf, point)
  self:updatePoint()
  self:updateTotalPoint()
end
function FromClient_responseYachtDiceGameUpdateTurn()
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  if true == self._isPvPFirstTurn then
    return
  end
  self:clearRenderValue()
  self:hideAllFieldCard()
  self:updatePoint()
  self:updateTurnBG()
  self:updateRollCount()
  if true == ToClient_isEmptyYachtGameBoardPoint() and false == ToClient_isMyTurnMiniGameYachtDice() then
    return
  else
    self:eventStartChangeTurn()
  end
end
function FromClient_showYachtDiceGameUI(isOpenByNpc)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:prepareOpen(isOpenByNpc)
end
function FromClient_responseYachtDiceGameNPCDataList(isPlayerTimeOut)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  if __eMiniGameDBType_YachtDice_PVE ~= PaGlobal_MiniGame_YachtDice._currentGameDbType then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:clearRenderValue()
  self._isTimeOut = isPlayerTimeOut
  self:hideAllFieldCard()
  self:updatePoint()
  self:updateTurnBG()
  self:loadCompleteNpcAction()
end
function FromClient_processYachtGameBubbleText(isPlayer, bubbleText)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  if __eMiniGameDBType_YachtDice_PVE ~= PaGlobal_MiniGame_YachtDice._currentGameDbType then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  if true == isPlayer then
    self:showPlayerBubbleText(bubbleText)
  else
    self:showNpcBubbleText(bubbleText)
  end
end
function PaGlobalFunc_MiniGame_YachtDice_Update(deltaTime)
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:renderEventHandRank(deltaTime)
  self:renderEventBeforeGameStart(deltaTime)
  self:renderEventDrawFieldCard(deltaTime)
  self:renderEventChangeTurn(deltaTime)
  self:renderEventKeep(deltaTime)
  self:updateTimer(deltaTime)
  self:updateNpcActionEvent(deltaTime)
  self:updateAutoBubbleTextForPVE(deltaTime)
end
function PaGlobalFunc_MiniGame_YachtDice_ForceHide()
  if false == _ContentsGroup_MiniGame_YachtDice then
    return
  end
  if nil == Panel_Window_MiniGame_YachtDice then
    return
  end
  if false == Panel_Window_MiniGame_YachtDice:GetShow() then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  self:prepareClose()
end
function HandleEventLUp_MiniGameYachtDice_CheckPopUpUI()
  local panel = Panel_Window_MiniGame_YachtDice
  if nil == panel then
    return
  end
  local self = PaGlobal_MiniGame_YachtDice
  if nil == self then
    return
  end
  if true == self._ui._btn_popUp:IsCheck() then
    panel:OpenUISubApp()
  else
    panel:CloseUISubApp()
  end
  TooltipSimple_Hide()
end
function HandleEventOnOut_MiniGameYachtDice_PopupUITooltip(isShow)
  local self = PaGlobal_MiniGame_YachtDice
  if nil == self then
    return
  end
  if true == isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_TOOLTIP_NAME")
    local desc = ""
    if self._ui._btn_popUp:IsCheck() then
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_CHECK_TOOLTIP")
    else
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_POPUI_NOCHECK_TOOLTIP")
    end
    TooltipSimple_Show(self._ui._btn_popUp, name, desc)
  else
    TooltipSimple_Hide()
  end
end
