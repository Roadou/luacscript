PaGlobal_Sequence_DeadMessage = {
  _ui = {
    _stc_centerBG = nil,
    _stc_ResurrectionBG = nil,
    _stc_deathReasonText = nil,
    _btn_SequenceResurrection = nil,
    _btn_DEV_Resurrection = nil,
    _btn_Retry = nil,
    _btn_Revive = nil,
    _btn_Observer = nil,
    _btn_Stronger = nil,
    _stc_selectedKeyGuide = nil
  },
  _prevUIMode = nil,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_InitSequenceDeadMessage")
function FromClient_InitSequenceDeadMessage()
  local self = PaGlobal_Sequence_DeadMessage
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._stc_circleBG = UI.getChildControl(Panel_Sequence_DeadMessage, "Static_CircleBG")
  self._ui._stc_centerBG = UI.getChildControl(Panel_Sequence_DeadMessage, "Static_CenterBG")
  self._ui._stc_ResurrectionBG = UI.getChildControl(Panel_Sequence_DeadMessage, "Static_ResurrectionBG")
  self._ui._stc_deathReasonText = UI.getChildControl(self._ui._stc_centerBG, "StaticText_DeathTitle")
  self._ui._stc_selectedKeyGuide = UI.getChildControl(self._ui._stc_ResurrectionBG, "Static_SelectButton_Console")
  self._ui._btn_DEV_Resurrection = UI.getChildControl(self._ui._stc_ResurrectionBG, "Button_LargeButton")
  self._ui._btn_Retry = UI.getChildControl(self._ui._stc_ResurrectionBG, "Button_Retry")
  self._ui._btn_SequenceResurrection = UI.getChildControl(self._ui._stc_ResurrectionBG, "Button_SmallButton")
  self._ui._btn_Revive = UI.getChildControl(self._ui._stc_ResurrectionBG, "Button_Revive")
  self._ui._btn_Observer = UI.getChildControl(self._ui._stc_ResurrectionBG, "Button_Observer")
  self._ui._btn_Stronger = UI.getChildControl(self._ui._stc_ResurrectionBG, "Button_SmallButton_Stronger")
  self._ui._stc_selectedKeyGuide:SetShow(self._isConsole)
  self:registEventHandler()
  FromClient_Sequence_DeadMessage_All_OnScreenReSize()
  self._initialize = true
end
function PaGlobal_Sequence_DeadMessage:registEventHandler()
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  registerEvent("EventSelfPlayerDeadInSequence", "FromClient_SequenceDeadMessage_SelfPlayerDead")
  registerEvent("EventSelfPlayerReviveInSequence", "PaGlobalFunc_SequenceDeadMessage_Close")
  registerEvent("onScreenResize", "FromClient_Sequence_DeadMessage_All_OnScreenReSize")
  registerEvent("FromClient_ResponseBlackTempleLeftReviveCount", "FromClient_ResponseBlackTempleLeftReviveCount")
  registerEvent("FromClient_SequenceDeadMessage_BGShow", "FromClient_SequenceDeadMessage_BGShow")
  if ToClient_IsDevelopment() == true then
    self._ui._btn_DEV_Resurrection:addInputEvent("Mouse_LUp", "HandleEventLUp_SequenceDeadMessage_DEV_Resurrection()")
    self._ui._btn_DEV_Resurrection:SetShow(true)
  else
    self._ui._btn_DEV_Resurrection:SetShow(false)
  end
  self._ui._btn_Retry:addInputEvent("Mouse_LUp", "HandleEventLUp_SequenceDeadMessage_Retry()")
  self._ui._btn_SequenceResurrection:addInputEvent("Mouse_LUp", "HandleEventLUp_SequenceDeadMessage_SequenceResurrection()")
  if self._isConsole == true then
    if ToClient_IsDevelopment() == true then
      self._ui._btn_DEV_Resurrection:addInputEvent("Mouse_On", "PaGlobal_Sequence_DeadMessage:updateKeyGuide(0)")
    end
    self._ui._btn_Retry:addInputEvent("Mouse_On", "PaGlobal_Sequence_DeadMessage:updateKeyGuide(1)")
    self._ui._btn_SequenceResurrection:addInputEvent("Mouse_On", "PaGlobal_Sequence_DeadMessage:updateKeyGuide(2)")
    self._ui._btn_Revive:addInputEvent("Mouse_On", "PaGlobal_Sequence_DeadMessage:updateKeyGuide(3)")
    self._ui._btn_Observer:addInputEvent("Mouse_On", "PaGlobal_Sequence_DeadMessage:updateKeyGuide(4)")
    self._ui._btn_Stronger:addInputEvent("Mouse_On", "PaGlobal_Sequence_DeadMessage:updateKeyGuide(5)")
  end
  self._ui._btn_Revive:addInputEvent("Mouse_LUp", "HandleEventLUp_SequenceDeadMessage_Revive()")
  self._ui._btn_Observer:addInputEvent("Mouse_LUp", "HandleEventLUp_SequenceDeadMessage_Observer()")
  self._ui._btn_Stronger:addInputEvent("Mouse_LUp", "HandleEventLUp_SpiritEnchant_All_EnchantGuide()")
end
function PaGlobal_Sequence_DeadMessage:prepareOpen(attackerActorKeyRaw)
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  self._ui._stc_circleBG:SetShow(true)
  self._ui._stc_centerBG:SetShow(true)
  self._ui._stc_ResurrectionBG:SetShow(true)
  local selfProxy = getSelfPlayer()
  local attackerActorProxyWrapper
  if attackerActorKeyRaw ~= nil then
    attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
  end
  local isPartySequence = ToClient_isPartySequence() == true
  self._ui._btn_Revive:SetShow(isPartySequence)
  self._ui._btn_Observer:SetShow(isPartySequence)
  local isShowSpecUpGuide = false
  local temporaryWrapper = getTemporaryInformationWrapper()
  if nil ~= temporaryWrapper then
    local userType = temporaryWrapper:getMyAdmissionToSpeedServer()
    if 1 == userType or 2 == userType then
      isShowSpecUpGuide = true
    end
  end
  self._ui._btn_Stronger:SetShow(isShowSpecUpGuide)
  local isMilitia = false
  local playerActorProxyWrapper
  if attackerActorKeyRaw ~= nil then
    playerActorProxyWrapper = getPlayerActor(attackerActorKeyRaw)
  end
  if playerActorProxyWrapper ~= nil then
    isMilitia = playerActorProxyWrapper:get():isVolunteer()
  end
  local deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  local deadWhoString
  if attackerActorProxyWrapper ~= nil then
    if attackerActorKeyRaw == selfProxy:getActorKey() then
      deadWhoString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
    elseif isMilitia == true then
      deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", PAGetString(Defines.StringSheet_GAME, "LUA_WARINFOMESSAGE_MILITIA"))
    elseif _ContentsGroup_NameTypeEqually == true then
      local nameType = ToClient_getChatNameType()
      if nameType == __eChatNameType_NickName then
        if playerActorProxyWrapper ~= nil then
          deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", playerActorProxyWrapper:getUserNickname())
        end
      else
        deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
      end
    else
      deadWhoString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
    end
  end
  if deadWhoString == nil then
    self._ui._stc_deathReasonText:SetText(deadMessageString)
  else
    self._ui._stc_deathReasonText:SetText(deadWhoString)
  end
  self._ui._stc_deathReasonText:SetShow(true)
  self:setPosition(isPartySequence)
  self:open()
end
function PaGlobal_Sequence_DeadMessage:open()
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  Panel_Sequence_DeadMessage:SetAlpha(0)
  Panel_Sequence_DeadMessage:SetShow(true)
  local aniInfo = UIAni.AlphaAnimation(1, Panel_Sequence_DeadMessage, 0, 5)
  aniInfo:SetDisableWhileAni(true)
end
function PaGlobal_Sequence_DeadMessage:prepareClose()
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  self._prevUIMode = nil
  self:close()
end
function PaGlobal_Sequence_DeadMessage:close()
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  Panel_Sequence_DeadMessage:SetShow(false)
end
function PaGlobal_Sequence_DeadMessage:setPosition(isPartySequence)
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  if isPartySequence == true then
    self._ui._btn_SequenceResurrection:SetPosY(self._ui._btn_DEV_Resurrection:GetPosY() + self._ui._btn_DEV_Resurrection:GetSizeY() + 10)
    self._ui._btn_Revive:SetPosY(self._ui._btn_SequenceResurrection:GetPosY() + self._ui._btn_SequenceResurrection:GetSizeY() + 10)
    self._ui._btn_Observer:SetPosY(self._ui._btn_Revive:GetPosY() + self._ui._btn_Revive:GetSizeY() + 10)
    self._ui._btn_Stronger:SetPosY(self._ui._btn_Observer:GetPosY() + self._ui._btn_Observer:GetSizeY() + 20)
  else
    self._ui._btn_Retry:SetPosY(self._ui._btn_DEV_Resurrection:GetPosY() + self._ui._btn_DEV_Resurrection:GetSizeY() + 10)
    self._ui._btn_SequenceResurrection:SetPosY(self._ui._btn_Retry:GetPosY() + self._ui._btn_Retry:GetSizeY() + 10)
    self._ui._btn_Stronger:SetPosY(self._ui._btn_SequenceResurrection:GetPosY() + self._ui._btn_SequenceResurrection:GetSizeY() + 20)
  end
end
function PaGlobal_Sequence_DeadMessage:updateKeyGuide(btnType)
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  if self._isConsole == false then
    return
  end
  local guideTargetControl
  if btnType == 0 then
    if self._ui._btn_DEV_Resurrection:GetShow() == true then
      guideTargetControl = self._ui._btn_DEV_Resurrection
    end
  elseif btnType == 1 then
    if self._ui._btn_Retry:GetShow() == true then
      guideTargetControl = self._ui._btn_Retry
    end
  elseif btnType == 2 then
    if self._ui._btn_SequenceResurrection:GetShow() == true then
      guideTargetControl = self._ui._btn_SequenceResurrection
    end
  elseif btnType == 3 then
    if self._ui._btn_Revive:GetShow() == true then
      guideTargetControl = self._ui._btn_Revive
    end
  elseif btnType == 4 then
    if self._ui._btn_Observer:GetShow() == true then
      guideTargetControl = self._ui._btn_Observer
    end
  elseif btnType == 5 and self._ui._btn_Stronger:GetShow() == true then
    guideTargetControl = self._ui._btn_Stronger
  end
  if guideTargetControl == nil then
    return
  end
  local posY = guideTargetControl:GetPosY() + (guideTargetControl:GetSizeY() - self._ui._stc_selectedKeyGuide:GetSizeY()) / 2
  self._ui._stc_selectedKeyGuide:SetPosY(posY)
end
function FromClient_SequenceDeadMessage_SelfPlayerDead(attackerActorKeyRaw, isSkipDeathPenalty, isHasRestoreExp, isAblePvPMatchRevive, respawnTime)
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  self:prepareOpen(attackerActorKeyRaw)
end
function PaGlobalFunc_SequenceDeadMessage_Close()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  SetUIMode(self._prevUIMode)
  self:prepareClose()
end
function PaGlobal_SequenceDeadMessage_CloseOnly()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  self:prepareClose()
end
function FromClient_Sequence_DeadMessage_All_OnScreenReSize()
  if Panel_Sequence_DeadMessage == nil then
    return
  end
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  Panel_Sequence_DeadMessage:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui._stc_circleBG:SetPosX((getScreenSizeX() - self._ui._stc_circleBG:GetSizeX()) / 2)
  self._ui._stc_circleBG:SetPosY((getScreenSizeY() - self._ui._stc_circleBG:GetSizeY()) / 2)
  Panel_Sequence_DeadMessage:ComputePos()
  self._ui._stc_circleBG:ComputePos()
  self._ui._stc_centerBG:ComputePos()
  self._ui._stc_ResurrectionBG:SetPosX(getScreenSizeX() / 2 - self._ui._stc_ResurrectionBG:GetSizeX() / 2)
  self._ui._stc_ResurrectionBG:SetPosY(getScreenSizeY() / 2)
end
function HandleEventLUp_SequenceDeadMessage_DEV_Resurrection()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  if ToClient_IsDevelopment() == false then
    return
  end
  local revivalType = __eRespawnType_Immediately
  local slotNo = 2
  local itemWhereType = CppEnums.ItemWhereType.eCashInventory
  local revivalRegionKey = getSelfPlayer():getRegionKey()
  local isPvpMatchRevive = false
  local servantNo = toInt64(0, 0)
  local isFairy = false
  local isImmediateRespawnForSiege = false
  deadMessage_Revival(revivalType, slotNo, itemWhereType, revivalRegionKey, isPvpMatchRevive, servantNo, isFairy, isImmediateRespawnForSiege, 0, __eRoseWarRespawnPositionType_Count, false, 0)
end
function HandleEventLUp_SequenceDeadMessage_Retry()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  ToClient_EscapeSequence(__eESequenceEscapeType_StartPos)
end
function HandleEventLUp_SequenceDeadMessage_SequenceResurrection()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  local isEnterBlackTempleParty = ToClient_IsEnterMirrorField(__eMirrorFieldContentsKey_BlackTemple)
  if isEnterBlackTempleParty == true then
    local selfIsPartyLeader = RequestParty_isLeader()
    local contentString = ""
    if selfIsPartyLeader == true then
      contentString = PAGetString(Defines.StringSheet_GAME, "MORNINGLAND_ESC_BOX_LEADER")
    else
      contentString = PAGetString(Defines.StringSheet_GAME, "MORNINGLAND_ESC_BOX_MEMBER")
    end
    local PartyResurrectionConfirm = function()
      ToClient_EscapeSequence(__eESequenceEscapeType_ResurrectPos)
    end
    local messageboxTitle = PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_TEXT_TITLE")
    local messageboxContent = contentString
    local messageboxData = {
      title = messageboxTitle,
      content = messageboxContent,
      functionYes = PartyResurrectionConfirm,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData, nil, nil, self._isConsole)
  else
    ToClient_EscapeSequence(__eESequenceEscapeType_ResurrectPos)
  end
end
function HandleEventLUp_SequenceDeadMessage_Observer()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  self._ui._stc_circleBG:SetShow(false)
  self._ui._stc_centerBG:SetShow(false)
  self._ui._stc_ResurrectionBG:SetShow(false)
  observerCameraModeStart()
  ShowCommandFunc(nil, true)
end
function HandleEventLUp_SequenceDeadMessage_Revive()
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  local revivalType = __eRespawnType_BlackTemple
  local slotNo = 0
  local itemWhereType = CppEnums.ItemWhereType.eCashInventory
  local revivalRegionKey = getSelfPlayer():getRegionKey()
  local isPvpMatchRevive = false
  local servantNo = toInt64(0, 0)
  local isFairy = false
  local isImmediateRespawnForSiege = false
  deadMessage_Revival(revivalType, slotNo, itemWhereType, revivalRegionKey, isPvpMatchRevive, servantNo, isFairy, isImmediateRespawnForSiege, 0, __eRoseWarRespawnPositionType_Count, false, 0)
end
function PaGlobal_SequenceDeadMessage_BGShow(isShow)
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  self._ui._stc_circleBG:SetShow(isShow)
  self._ui._stc_centerBG:SetShow(isShow)
  self._ui._stc_ResurrectionBG:SetShow(isShow)
end
function FromClient_ResponseBlackTempleLeftReviveCount(leftCount)
  local self = PaGlobal_Sequence_DeadMessage
  if self == nil then
    return
  end
  self._ui._btn_Revive:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_BLACKTEMPLE_REVIVE_DESC_1", "LifeCount", tostring(leftCount)))
end
function FromClient_SequenceDeadMessage_BGShow(isShow)
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  if selfPlayer:isDead() == false then
    return
  end
  Panel_Sequence_DeadMessage:SetShow(isShow)
end
