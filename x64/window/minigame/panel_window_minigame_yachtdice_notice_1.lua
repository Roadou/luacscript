function PaGlobal_YachtDice_Notice:initialize()
  if true == PaGlobal_YachtDice_Notice._initialize then
    return
  end
  self._isConsole = true == ToClient_isConsole()
  self._ui._txt_multilineText = UI.getChildControl(self._ui._stc_gameBoardInfoArea, "MultilineText_Invite")
  self._ui._txt_gameBoardDesc = UI.getChildControl(self._ui._stc_gameBoardInfoArea, "StaticText_Desc")
  self._ui._txt_gamePlatformIcon = UI.getChildControl(self._ui._stc_gameBoardInfoArea, "Static_ConsolePartIcon")
  self._expireMaxTime = ToClient_getMiniGameYachtInviteExpireTime()
  self:initializeButton()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_YachtDice_Notice:initializeButton()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  if true == self._isConsole then
    self._ui._btn_ok:SetShow(false)
    self._ui._btn_cancel:SetShow(false)
    self._ui._stc_keyGuides:SetShow(true)
    local keyGuide_A = UI.getChildControl(self._ui._stc_keyGuides, "StaticText_Confirm_A")
    local keyGuide_B = UI.getChildControl(self._ui._stc_keyGuides, "StaticText_Refuse_B")
    local keyGuides = {keyGuide_A, keyGuide_B}
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui._stc_keyGuides, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
    Panel_Widget_MiniGame_YachtDice_Notice:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_MiniGameYacht_Notice_OnCLickedAcceptButton()")
    Panel_Widget_MiniGame_YachtDice_Notice:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobalFunc_MiniGameYacht_Notice_OnClickedRefuseButton()")
  else
    self._ui._btn_ok:SetShow(true)
    self._ui._btn_cancel:SetShow(true)
    self._ui._stc_keyGuides:SetShow(false)
    self._ui._btn_ok:addInputEvent("Mouse_LUp", "PaGlobalFunc_MiniGameYacht_Notice_OnCLickedAcceptButton()")
    self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_MiniGameYacht_Notice_OnClickedRefuseButton()")
  end
end
function PaGlobal_YachtDice_Notice:registEventHandler()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  if true == self._isConsole then
    registerEvent("FromClient_responseYachtDiceBattle", "PaGlobalFunc_MiniGameYacht_Notice_KeepOpenInfo")
  else
    registerEvent("FromClient_responseYachtDiceBattle", "PaGlobalFunc_MiniGameYacht_Notice_Open")
  end
  registerEvent("FromClient_responseCanceledYachtDiceBattleRequest", "PaGlobalFunc_MiniGameYacht_Notice_Canceled")
end
function PaGlobal_YachtDice_Notice:validate()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  self._ui._stc_titleArea:isValidate()
  self._ui._txt_multilineText:isValidate()
  self._ui._stc_gameBoardInfoArea:isValidate()
  self._ui._txt_gameBoardDesc:isValidate()
  self._ui._txt_remainTime:isValidate()
  self._ui._prg_remainTime:isValidate()
  self._ui._btn_ok:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._txt_gamePlatformIcon:isValidate()
end
function PaGlobal_YachtDice_Notice:keepOpenInfo(requestUserNickName, expireTime, gameBoardKey, platformId, platformType)
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  self._keepOpenInfo._requestUserNickName = requestUserNickName
  self._keepOpenInfo._expireTime = expireTime
  self._keepOpenInfo._gameBoardKey = gameBoardKey
  self._keepOpenInfo._requestUserPlatformId = platformId
  self._keepOpenInfo._requestUserPlatformType = platformType
end
function PaGlobal_YachtDice_Notice:prepareOpen(requestUserNickName, expireTime, gameBoardKey, platformId, platformType)
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  self._ui._txt_multilineText:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_INVITED_FROM_NAME", "name", requestUserNickName))
  if ToClient_isPS5() == true then
    self._ui._txt_gamePlatformIcon:SetShow(true)
    if platformType == __eGAME_PLATFORM_TYPE_PS then
      self._ui._txt_gamePlatformIcon:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_ps.dds")
    else
      self._ui._txt_gamePlatformIcon:ChangeTextureInfoNameAsync("combine/commonicon/crossplay_icon_other.dds")
    end
    self._ui._txt_multilineText:SetPosX(50)
    self._ui._txt_multilineText:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_YACHT_INVITED_FROM_NAMEWITHONLINEID", "name", requestUserNickName, "onlineid", platformId))
  else
    self._ui._txt_multilineText:SetPosX(1)
    self._ui._txt_gamePlatformIcon:SetShow(false)
  end
  local gameBoardSSW = ToClient_getYachtGameBoardStaticStatusWrapperByKey(gameBoardKey)
  if nil == gameBoardSSW then
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
  self._ui._txt_gameBoardDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_gameBoardDesc:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_DESC_INVITED", "desc", gameBoardSSW:getDesc()))
  self:initPanelPosition()
  self._cachedExpireTime = Int64toInt32(expireTime)
  self._remainExpireTime = Int64toInt32(expireTime - getServerUtc64())
  if self._remainExpireTime < 0 then
    UI.ASSERT_NAME(false, "\235\167\140\235\163\140\236\139\156\234\176\132\236\157\180 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.", "\236\157\180\236\163\188")
  end
  Panel_Widget_MiniGame_YachtDice_Notice:RegisterUpdateFunc("PaGlobalFunc_MiniGameYacht_Notice_Update")
  self:open()
end
function PaGlobal_YachtDice_Notice:open()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  Panel_Widget_MiniGame_YachtDice_Notice:SetShow(true)
end
function PaGlobal_YachtDice_Notice:prepareClose()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  Panel_Widget_MiniGame_YachtDice_Notice:ClearUpdateLuaFunc()
  self._isReverseMove = false
  self._isMoveDone = false
  self._isExpireRequest = false
  self._panelMoveDeltaTime = 0
  self._cachedExpireTime = 0
  self._remainExpireTime = 0
  self._lastUpdateTime = 0
  self._ui._prg_remainTime:SetProgressRate(100)
  self:close()
end
function PaGlobal_YachtDice_Notice:close()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  Panel_Widget_MiniGame_YachtDice_Notice:SetShow(false)
end
function PaGlobal_YachtDice_Notice:update(deltaTime)
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  self:updatePanelPos(deltaTime)
  self:updateTimer(deltaTime)
end
function PaGlobal_YachtDice_Notice:updatePanelPos(deltaTime)
  local panel = Panel_Widget_MiniGame_YachtDice_Notice
  if nil == panel then
    return
  end
  if true == self._isConsole then
    return
  end
  if true == self._isMoveDone then
    return
  end
  self._panelMoveDeltaTime = self._panelMoveDeltaTime + deltaTime
  local goalPosX = 0
  if true == self._isReverseMove then
    goalPosX = getScreenSizeX()
  else
    goalPosX = getScreenSizeX() - panel:GetSizeX() - 5
  end
  local currentPosX = panel:GetPosX()
  local moveValue = (currentPosX - goalPosX) * self._panelMoveDeltaTime
  local newPosX = currentPosX - moveValue
  if false == self._isReverseMove and goalPosX >= newPosX then
    self._isMoveDone = true
    self._panelMoveDeltaTime = 0
    return
  elseif true == self._isReverseMove and goalPosX <= newPosX then
    self:prepareClose()
    return
  end
  panel:SetPosX(newPosX)
end
function PaGlobal_YachtDice_Notice:updateTimer(deltaTime)
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  if 0 == self._remainExpireTime then
    return
  end
  local currentServerUtc = Int64toInt32(getServerUtc64())
  if 0.1 < currentServerUtc - self._lastUpdateTime then
    self._remainExpireTime = self._cachedExpireTime - currentServerUtc
  end
  self._remainExpireTime = self._remainExpireTime - deltaTime
  local ratio = self._remainExpireTime / self._expireMaxTime
  self._ui._txt_remainTime:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_remainTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_YACHT_TIMELEFT", "time", tostring(math.floor(self._remainExpireTime))))
  self._ui._prg_remainTime:SetProgressRate(ratio * 100)
  if 0 > self._remainExpireTime then
    self._isMoveDone = false
    self._isReverseMove = true
    if true == self._isConsole then
      PaGlobalFunc_MiniGameYacht_Notice_Close(true)
    end
  end
  self._lastUpdateTime = currentServerUtc
end
function PaGlobal_YachtDice_Notice:recalcPanelSize()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  local panel = Panel_Widget_MiniGame_YachtDice_Notice
  local titleAreaSizeY = self._ui._stc_titleArea:GetSizeY()
  self._ui._txt_multilineText:SetSize(self._ui._txt_multilineText:GetSizeX(), self._ui._txt_multilineText:GetTextSizeY() + 10)
  local userInfoAreaSizeY = self._ui._txt_multilineText:GetSizeY()
  self._ui._txt_gameBoardDesc:SetSize(self._ui._txt_gameBoardDesc:GetSizeX(), self._ui._txt_gameBoardDesc:GetTextSizeY())
  local boardDescSizeY = self._ui._txt_gameBoardDesc:GetSizeY()
  self._ui._stc_gameBoardInfoArea:SetSize(self._ui._stc_gameBoardInfoArea:GetSizeX(), self._ui._txt_gameBoardDesc:GetPosY() + boardDescSizeY)
  self._ui._stc_gameBoardInfoArea:SetPosY(self._ui._txt_multilineText:GetPosY() + userInfoAreaSizeY)
  local gameBoardAreaSizeY = self._ui._stc_gameBoardInfoArea:GetSizeY()
  self._ui._txt_remainTime:SetPosY(self._ui._stc_gameBoardInfoArea:GetPosY() + gameBoardAreaSizeY + 15)
  self._ui._prg_remainTime:SetPosY(self._ui._txt_remainTime:GetPosY() + self._ui._txt_remainTime:GetSizeY() + 10)
  self._ui._btn_ok:SetPosY(self._ui._prg_remainTime:GetPosY() + self._ui._prg_remainTime:GetSizeY() + 10)
  self._ui._btn_cancel:SetPosY(self._ui._btn_ok:GetPosY())
  panel:SetSize(panel:GetSizeX(), self._ui._btn_cancel:GetPosY() + self._ui._btn_cancel:GetSizeY() + 10)
end
function PaGlobal_YachtDice_Notice:initPanelPosition()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  local panel = Panel_Widget_MiniGame_YachtDice_Notice
  if true == self._isConsole then
    panel:SetPosX(getScreenSizeX() / 2 - panel:GetSizeX() / 2)
    panel:SetPosY(getScreenSizeY() / 2 - panel:GetSizeY() / 2)
  else
    panel:SetPosX(getScreenSizeX())
    panel:SetPosY(getScreenSizeY() - panel:GetSizeY() - 5)
  end
end
function PaGlobal_YachtDice_Notice:doCloseAnimation()
  if nil == Panel_Widget_MiniGame_YachtDice_Notice then
    return
  end
  self._remainExpireTime = 0
  self._isMoveDone = false
  self._isReverseMove = true
end
