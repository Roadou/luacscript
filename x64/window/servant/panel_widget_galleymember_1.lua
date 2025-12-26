function PaGlobal_GalleyMember_All:initialize()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  if true == self._initialize then
    return
  end
  self._ui._stc_memberTemplate = UI.getChildControl(Panel_Widget_GalleyMember, "Static_MemberTemplate")
  self._ui._stc_memberGroup = UI.getChildControl(Panel_Widget_GalleyMember, "Static_MemberGroup")
  self._ui._stc_ship = UI.getChildControl(Panel_Widget_GalleyMember, "Static_Ship")
  self:makeMemberSlotUI()
  self:validate()
  self:registEventHandler()
  self._ui._stc_memberTemplate:SetShow(false)
  self._ui._stc_ship:SetAlpha(0.9)
  self._initialize = true
end
function PaGlobal_GalleyMember_All:clear()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii] ~= nil and self._memberSlotUIArr[ii]._isSet == true then
      self:clearMemberData(ii)
    end
  end
end
function PaGlobal_GalleyMember_All:validate()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  self._ui._stc_memberTemplate:isValidate()
  self._ui._stc_memberGroup:isValidate()
  self._ui._stc_ship:isValidate()
end
function PaGlobal_GalleyMember_All:registEventHandler()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  Panel_Widget_GalleyMember:RegisterUpdateFunc("PaGlobal_GalleyMember_All_UpdatePerFrame")
  registerEvent("FromClient_ActorRideOnVehicle", "FromClient_ActorRideOnVehicle")
  registerEvent("FromClient_ActorRideOffVehicle", "FromClient_ActorRideOffVehicle")
  registerEvent("FromClient_PaddleMiniGameRoundResult", "FromClient_PaddleMiniGameRoundResult")
  registerEvent("EventSelfPlayerRideOff", "FromClient_RideOffGalleyMember")
end
function PaGlobal_GalleyMember_All:prepareOpen()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  self:clear()
  self:open()
end
function PaGlobal_GalleyMember_All:open()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  Panel_Widget_GalleyMember:SetShow(true)
  self:updateMemberDataArr()
  self:updateMemberSlotUI()
  PaGlobal_GalleyBoost_All_UpdatePlayMemberCountUI()
end
function PaGlobal_GalleyMember_All:prepareClose()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  self:close()
end
function PaGlobal_GalleyMember_All:close()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  Panel_Widget_GalleyMember:SetShow(false)
end
function PaGlobal_GalleyMember_All:updateMemberSlotUI()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  if self._initialize == false then
    return
  end
  if Panel_Widget_GalleyMember:GetShow() == false then
    return
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true then
      local characterActorProxyWrapper = getCharacterActor(self._memberSlotUIArr[ii]._actorKey)
      if characterActorProxyWrapper ~= nil then
        PaGlobalFunc_Util_SetSolrareMiniClassIcon(self._memberSlotUIArr[ii]._stc_classIcon, characterActorProxyWrapper:getClassType())
      end
      self._memberSlotUIArr[ii]._stc_classIcon:SetShow(true)
      if self._memberSlotUIArr[ii]._state == 0 then
        self._memberSlotUIArr[ii]._stc_sequenceUI:SetShow(false)
      elseif self._memberSlotUIArr[ii]._state == 1 then
        self._memberSlotUIArr[ii]._stc_sequenceUI:SetShow(true)
      end
    else
      self._memberSlotUIArr[ii]._stc_classIcon:SetShow(false)
    end
  end
  self:updateMemberUiPos()
end
function PaGlobal_GalleyMember_All:updateMemberUiPos()
  local alignUiCount = 0
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true then
      alignUiCount = alignUiCount + 1
      local lineNum = math.ceil(alignUiCount / 2) - 1
      if alignUiCount % 2 == 1 then
        self._memberSlotUIArr[ii]._stc_main:SetHorizonLeft()
      else
        self._memberSlotUIArr[ii]._stc_main:SetHorizonRight()
      end
      self._memberSlotUIArr[ii]._stc_main:SetPosY(lineNum * 50)
    end
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == false then
      alignUiCount = alignUiCount + 1
      local lineNum = math.ceil(alignUiCount / 2) - 1
      if alignUiCount % 2 == 1 then
        self._memberSlotUIArr[ii]._stc_main:SetHorizonLeft()
      else
        self._memberSlotUIArr[ii]._stc_main:SetHorizonRight()
      end
      self._memberSlotUIArr[ii]._stc_main:SetPosY(lineNum * 50)
    end
  end
end
function PaGlobal_GalleyMember_All:updateMemberDataArr()
  if Panel_Widget_GalleyMember == nil then
    return
  end
  local selfPlayer = getSelfPlayer():get()
  local vehicleProxy = getVehicleActor(selfPlayer:getRideVehicleActorKeyRaw())
  if vehicleProxy == nil then
    return
  end
  local vehicleProxyWrapper = vehicleProxy:get()
  local vehicleType = vehicleProxyWrapper:getVehicleType()
  for ii = 0, 42 do
    if ToClient_IsVehiclePaddleSeatIndex(vehicleType, ii) == true then
      local tempActorKey = vehicleProxyWrapper:getRider(ii)
      if tempActorKey ~= 0 then
        self:addMember(tempActorKey)
      end
    end
  end
end
function PaGlobal_GalleyMember_All:UpdatePerFrame(deltaTime)
  if Panel_Widget_GalleyMember == nil then
    return
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii] ~= nil and self._memberSlotUIArr[ii]._onRoundResult == true then
      self._memberSlotUIArr[ii]._innerTimer = self._memberSlotUIArr[ii]._innerTimer + deltaTime
      if self._memberSlotUIArr[ii]._innerTimer > 3 then
        self._memberSlotUIArr[ii]._onRoundResult = false
        self._memberSlotUIArr[ii]._stc_badUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_goodUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_perfectUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_resultUI:SetShow(false)
        self._memberSlotUIArr[ii]._innerTimer = 0
        self:updateSequenceUI(ii)
      end
    end
  end
end
function PaGlobal_GalleyMember_All:updateSequenceUI(index)
  if self._memberSlotUIArr[index]._state == 0 then
    self._memberSlotUIArr[index]._stc_sequenceUI:SetShow(false)
  elseif self._memberSlotUIArr[index]._state == 1 then
    self._memberSlotUIArr[index]._stc_sequenceUI:SetShow(true)
  end
end
function PaGlobal_GalleyMember_All:responseRoundResult(servantNo, userNo, resultType, round)
  if Panel_Widget_GalleyMember == nil then
    return
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii] ~= nil and self._memberSlotUIArr[ii]._isSet == true and self._memberSlotUIArr[ii]._userNo == userNo then
      self._memberSlotUIArr[ii]._stc_resultUI:SetShow(true)
      if resultType == __eMiniGameResultType_Bad then
        self._memberSlotUIArr[ii]._stc_badUI:SetShow(true)
        self._memberSlotUIArr[ii]._stc_goodUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_perfectUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_resultUI:AddEffect("FUI_Galley_MiniGame_Fail_01A", false, 0, 0)
        self._memberSlotUIArr[ii]._stc_resultUI:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_Sailor_Bad")
      elseif resultType == __eMiniGameResultType_Good then
        self._memberSlotUIArr[ii]._stc_badUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_goodUI:SetShow(true)
        self._memberSlotUIArr[ii]._stc_perfectUI:SetShow(false)
        self._memberSlotUIArr[ii]._stc_resultUI:AddEffect("FUI_Galley_MiniGame_Good_01A", false, 0, 0)
        self._memberSlotUIArr[ii]._stc_resultUI:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_Sailor_Good")
      else
        if resultType == __eMiniGameResultType_Excellent then
          self._memberSlotUIArr[ii]._stc_badUI:SetShow(false)
          self._memberSlotUIArr[ii]._stc_goodUI:SetShow(false)
          self._memberSlotUIArr[ii]._stc_perfectUI:SetShow(true)
          self._memberSlotUIArr[ii]._stc_resultUI:AddEffect("FUI_Galley_MiniGame_Perfect_01A", false, 0, 0)
          self._memberSlotUIArr[ii]._stc_resultUI:ChangeTextureInfoTextureIDAsync("Combine_Etc_MiniGame_16_Sailor_Perfect")
        else
        end
      end
      self._memberSlotUIArr[ii]._stc_resultUI:setRenderTexture(self._memberSlotUIArr[ii]._stc_resultUI:getBaseTexture())
      self._memberSlotUIArr[ii]._stc_sequenceUI:SetShow(false)
      self._memberSlotUIArr[ii]._onRoundResult = true
      if round == 5 then
        self._memberSlotUIArr[ii]._state = 0
      else
        self._memberSlotUIArr[ii]._state = 1
      end
    end
  end
end
function PaGlobal_GalleyMember_All:makeMemberSlotUI()
  for ii = 1, self._memberSlotCount do
    local controlId = "Static_MemberSlot_" .. tostring(ii)
    local newControl = UI.cloneControl(self._ui._stc_memberTemplate, self._ui._stc_memberGroup, controlId)
    local classIconUI = UI.getChildControl(newControl, "Static_ClassIcon")
    local resultUI = UI.getChildControl(newControl, "Static_Result")
    local perfectUI = UI.getChildControl(newControl, "Static_Perfect")
    local goodUI = UI.getChildControl(newControl, "Static_Good")
    local badUI = UI.getChildControl(newControl, "Static_Bad")
    local sequenceUI = UI.getChildControl(newControl, "Static_Sequence")
    newControl:SetShow(true)
    newControl:addInputEvent("Mouse_On", "PaGlobal_GalleyMember_All:onOutHandlerMemberSlotUI(" .. ii .. ", true)")
    newControl:addInputEvent("Mouse_Out", "PaGlobal_GalleyMember_All:onOutHandlerMemberSlotUI(" .. ii .. ", false)")
    classIconUI:SetAlpha(0.9)
    self._memberSlotUIArr[ii] = {
      _stc_main = newControl,
      _stc_classIcon = classIconUI,
      _stc_resultUI = resultUI,
      _stc_perfectUI = perfectUI,
      _stc_goodUI = goodUI,
      _stc_badUI = badUI,
      _stc_sequenceUI = sequenceUI,
      _isGameMember = false,
      _userNo = 0,
      _actorKey = 0,
      _state = 0,
      _onRoundResult = false,
      _innerTimer = 0,
      _isSet = false
    }
  end
end
function PaGlobal_GalleyMember_All:addMember(actorKey)
  local selfPlayer = getSelfPlayer()
  local vehicleProxy = getVehicleActor(getSelfPlayer():get():getRideVehicleActorKeyRaw())
  if vehicleProxy == nil then
    return
  end
  local vehicleType = vehicleProxy:get():getVehicleType()
  local characterActorProxyWrapper = getCharacterActor(actorKey)
  if characterActorProxyWrapper == nil then
    return
  end
  if ToClient_IsVehiclePaddleSeatIndex(vehicleType, characterActorProxyWrapper:get():getVehicleSeatIndex()) == false then
    return
  end
  local playerActorWrapper = getPlayerActor(actorKey)
  if playerActorWrapper == nil then
    return
  end
  local userNo = playerActorWrapper:getUserNo()
  if self:isAlreadMember(userNo) == true then
    return
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == false then
      self._memberSlotUIArr[ii]._isSet = true
      self._memberSlotUIArr[ii]._actorKey = actorKey
      self._memberSlotUIArr[ii]._userNo = userNo
      return
    end
  end
end
function PaGlobal_GalleyMember_All:removeMember(actorKey)
  local playerActorProxyWrapper = getPlayerActor(actorKey)
  if nil == playerActorProxyWrapper then
    return
  end
  local userNo = playerActorProxyWrapper:getUserNo()
  if self:isAlreadMember(userNo) == false then
    return
  end
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true and self._memberSlotUIArr[ii]._userNo == userNo then
      self:clearMemberData(ii)
      return
    end
  end
end
function PaGlobal_GalleyMember_All:clearMemberData(index)
  self._memberSlotUIArr[index]._isSet = false
  self._memberSlotUIArr[index]._actorKey = 0
  self._memberSlotUIArr[index]._userNo = 0
  self._memberSlotUIArr[index]._state = 0
  self._memberSlotUIArr[index]._onRoundResult = false
  self._memberSlotUIArr[index]._innerTimer = 0
  self._memberSlotUIArr[index]._stc_badUI:SetShow(false)
  self._memberSlotUIArr[index]._stc_goodUI:SetShow(false)
  self._memberSlotUIArr[index]._stc_perfectUI:SetShow(false)
  self._memberSlotUIArr[index]._stc_resultUI:SetShow(false)
  self._memberSlotUIArr[index]._stc_sequenceUI:SetShow(false)
  self._memberSlotUIArr[index]._stc_classIcon:SetShow(false)
end
function PaGlobal_GalleyMember_All:isAlreadMember(userNo)
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true and self._memberSlotUIArr[ii]._userNo == userNo then
      return true
    end
  end
  return false
end
function PaGlobal_GalleyMember_All:getMiniGamePlayerCount()
  local gamePlayerCount = 0
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true and self._memberSlotUIArr[ii]._isGameMember == true then
      gamePlayerCount = gamePlayerCount + 1
    end
  end
  return gamePlayerCount
end
function PaGlobal_GalleyMember_All:getClearedMiniGamePlayerCount()
  local clearedPlayerCount = 0
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true and self._memberSlotUIArr[ii]._isGameMember == true and self._memberSlotUIArr[ii]._state == 0 then
      clearedPlayerCount = clearedPlayerCount + 1
    end
  end
  return clearedPlayerCount
end
function PaGlobal_GalleyMember_All:getPlayerCount()
  local playerCount = 0
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true then
      playerCount = playerCount + 1
    end
  end
  return playerCount
end
function PaGlobal_GalleyMember_All:onOutHandlerMemberSlotUI(index, isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local memberSlotData = self._memberSlotUIArr[index]
  if memberSlotData == nil then
    return
  end
  local playerActorProxyWrapper = getPlayerActor(memberSlotData._actorKey)
  if playerActorProxyWrapper == nil then
    return
  end
  TooltipSimple_Show(memberSlotData._stc_main, playerActorProxyWrapper:getUserNickname(), "", false)
end
function PaGlobal_GalleyMember_All:responsePaddleMiniGameEnd()
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true then
      self._memberSlotUIArr[ii]._isGameMember = false
    end
  end
end
function PaGlobal_GalleyMember_All:responsePaddleMiniGameStart()
  for ii = 1, self._memberSlotCount do
    if self._memberSlotUIArr[ii]._isSet == true then
      self._memberSlotUIArr[ii]._state = 1
      self._memberSlotUIArr[ii]._isGameMember = true
      self:updateSequenceUI(ii)
    end
  end
end
