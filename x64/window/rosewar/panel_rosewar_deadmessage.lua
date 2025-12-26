PaGlobal_RoseWarDeadMessage = {
  _ui = {
    static_circleBG = nil,
    static_centerBG = nil,
    text_deathTitle = nil,
    static_battleMap = nil,
    rdo_rapidRespawn = nil,
    rdo_normalRespawn = nil,
    text_leftRapidRespawnTime = nil,
    text_leftNormalRespawnTime = nil,
    btn_observer = nil,
    btn_devRevive = nil,
    static_KamaCastle = nil,
    static_OdilCastle = nil,
    static_SelectBG = nil,
    btn_OutsideCastleRespawn = nil,
    btn_InsideCastleRespawn = nil,
    btn_PlazaRespawn = nil,
    static_LastDead = nil
  },
  _fierceBattleList = {},
  _selectedFierceBattleKey = nil,
  _selectedRespawnPositionType = __eRoseWarRespawnPositionType_Count,
  _attackerActorKeyRaw = nil,
  _respawnTime = ToClient_GetRoseWarReviveTime(false),
  _rapidReviveTime = nil,
  _normalReviveTime = nil,
  _prevUIMode = nil,
  _isConsole = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarDeadMessageInit")
function FromClient_RoseWarDeadMessageInit()
  PaGlobal_RoseWarDeadMessage:initialize()
end
function PaGlobal_RoseWarDeadMessage:initialize()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui.static_circleBG = UI.getChildControl(Panel_RoseWar_DeadMessage, "Static_CircleBG")
  self._ui.static_centerBG = UI.getChildControl(Panel_RoseWar_DeadMessage, "Static_CenterBG")
  self._ui.text_deathTitle = UI.getChildControl(self._ui.static_centerBG, "StaticText_DeathTitle")
  self._ui.static_battleMap = UI.getChildControl(Panel_RoseWar_DeadMessage, "Static_BattleMap")
  self._ui.rdo_rapidRespawn = UI.getChildControl(self._ui.static_battleMap, "RadioButton_ResponFast")
  self._ui.rdo_normalRespawn = UI.getChildControl(self._ui.static_battleMap, "RadioButton_ResponNormal")
  self._ui.text_leftRapidRespawnTime = UI.getChildControl(self._ui.static_battleMap, "StaticText_LeftFastTime")
  self._ui.text_leftNormalRespawnTime = UI.getChildControl(self._ui.static_battleMap, "StaticText_LeftNormalTime")
  self._ui.btn_observer = UI.getChildControl(self._ui.static_battleMap, "Button_Obserber")
  self._ui.btn_devRevive = UI.getChildControl(self._ui.static_battleMap, "Button_Dev")
  for i = 1, 20 do
    local temp = {
      icon = UI.getChildControl(self._ui.static_battleMap, "Button_" .. tostring(i)),
      stc_cantRevive = nil
    }
    temp.stc_cantRevive = UI.getChildControl(temp.icon, "Static_CantRevive")
    temp.stc_cantRevive:SetShow(false)
    self._fierceBattleList[i] = temp
    self:changeFierceBattleColor(i, __eRoseWarTeam_Neutral)
  end
  self._ui.static_KamaCastle = UI.getChildControl(self._ui.static_battleMap, "Button_Castle_Kama")
  self._ui.static_OdilCastle = UI.getChildControl(self._ui.static_battleMap, "Button_Castle_Othilita")
  self._ui.static_SelectBG = UI.getChildControl(self._ui.static_battleMap, "Static_SelectBg")
  self._ui.btn_OutsideCastleRespawn = UI.getChildControl(self._ui.static_SelectBG, "Button_1")
  self._ui.btn_InsideCastleRespawn = UI.getChildControl(self._ui.static_SelectBG, "Button_2")
  self._ui.btn_PlazaRespawn = UI.getChildControl(self._ui.static_SelectBG, "Button_3")
  self._ui.static_LastDead = UI.getChildControl(self._ui.static_battleMap, "Static_LastDead")
  self._ui.static_FixedResurrectionPoint = UI.getChildControl(self._ui.static_battleMap, "Static_FixedResurrectionPoint")
  self._ui.txt_FixedResurrectionPointTime = UI.getChildControl(self._ui.static_FixedResurrectionPoint, "StaticText_1")
  self:registerEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_RoseWarDeadMessage:registerEventHandler()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  Panel_RoseWar_DeadMessage:RegisterUpdateFunc("RoseWarRevive_UpdatePerFrame")
  registerEvent("FromClient_UpdateRoseWarFierceBattleDeadMessage", "FromClient_UpdateRoseWarFierceBattleDeadMessage")
  registerEvent("EventSelfPlayerDeadInRoseWar", "EventSelfPlayerDeadInRoseWar")
  registerEvent("EventSelfPlayerReviveInRoseWar", "EventSelfPlayerReviveInRoseWar")
  registerEvent("onScreenResize", "FromClient_RoseWar_DeadMessage_All_OnScreenReSize")
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_ReviveToNearTown")
  self._ui.btn_observer:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_ChangeToObserverMode()")
  self._ui.btn_devRevive:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_SelectDevRevive()")
  self._ui.rdo_rapidRespawn:addInputEvent("Mouse_On", "HandleEventOn_RoseWarDeadMessage_ShowToolip(true,true)")
  self._ui.rdo_rapidRespawn:addInputEvent("Mouse_Out", "HandleEventOn_RoseWarDeadMessage_ShowToolip(true,false)")
  self._ui.rdo_normalRespawn:addInputEvent("Mouse_On", "HandleEventOn_RoseWarDeadMessage_ShowToolip(false,true)")
  self._ui.rdo_normalRespawn:addInputEvent("Mouse_Out", "HandleEventOn_RoseWarDeadMessage_ShowToolip(false,false)")
  for i = 1, 20 do
    self._fierceBattleList[i].icon:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_SelectRespawnFierceBattle(" .. i .. ")")
    self._fierceBattleList[i].icon:addInputEvent("Mouse_On", "HandleEventOn_RoseWarDeadMessage_ShowFierceBattleTooltip(true, " .. i .. ")")
    self._fierceBattleList[i].icon:addInputEvent("Mouse_Out", "HandleEventOn_RoseWarDeadMessage_ShowFierceBattleTooltip(false, " .. i .. ")")
  end
  self._ui.static_KamaCastle:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_ShowRespawnPosition(true)")
  self._ui.static_OdilCastle:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_ShowRespawnPosition(false)")
  self._ui.btn_OutsideCastleRespawn:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_SelectRespawnCastle(" .. 1 .. ")")
  self._ui.btn_InsideCastleRespawn:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_SelectRespawnCastle(" .. 2 .. ")")
  self._ui.btn_PlazaRespawn:addInputEvent("Mouse_LUp", "HandleEventOn_RoseWarDeadMessage_SelectRespawnCastle(" .. 3 .. ")")
end
function RoseWarRevive_UpdatePerFrame(deltaTime)
  if PaGlobal_RoseWarDeadMessage._rapidReviveTime > 0 then
    PaGlobal_RoseWarDeadMessage._rapidReviveTime = PaGlobal_RoseWarDeadMessage._rapidReviveTime - deltaTime
  else
    PaGlobal_RoseWarDeadMessage._rapidReviveTime = 0
  end
  if 0 < PaGlobal_RoseWarDeadMessage._normalReviveTime then
    PaGlobal_RoseWarDeadMessage._normalReviveTime = PaGlobal_RoseWarDeadMessage._normalReviveTime - deltaTime
  else
    PaGlobal_RoseWarDeadMessage._normalReviveTime = 0
  end
  local rapidTime = math.floor(PaGlobal_RoseWarDeadMessage._rapidReviveTime)
  local normalTime = math.floor(PaGlobal_RoseWarDeadMessage._normalReviveTime)
  PaGlobal_RoseWarDeadMessage._ui.text_leftRapidRespawnTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(rapidTime)))
  PaGlobal_RoseWarDeadMessage._ui.text_leftNormalRespawnTime:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "BUFF_SECOND", "time_second", tostring(normalTime)))
  local fixedPoint = ToClient_GetCurrentFixedResurrectionPoint()
  if fixedPoint ~= nil and PaGlobal_RoseWarDeadMessage._fierceBattleList ~= nil then
    local fixedResurrectionKey = fixedPoint:getFierceBattleKey()
    local control = PaGlobal_RoseWarDeadMessage._fierceBattleList[fixedResurrectionKey].icon
    if control ~= nil then
      local posX = control:GetPosX() - 10
      local posY = control:GetPosY() - 10
      PaGlobal_RoseWarDeadMessage._ui.static_FixedResurrectionPoint:SetPosXY(posX, posY)
      local leftTime = fixedPoint:getEndTime() - Int64toInt32(getServerUtc64())
      local time = convertSecondsToClockTime(leftTime)
      PaGlobal_RoseWarDeadMessage._ui.txt_FixedResurrectionPointTime:SetText(time)
    end
  end
  PaGlobal_RoseWarDeadMessage._ui.static_FixedResurrectionPoint:SetShow(fixedPoint ~= nil)
end
function PaGlobal_RoseWarDeadMessage:prepareOpen(attackerActorKeyRaw, respawnTime)
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  PaGlobal_RoseWarDeadMessage._attackerActorKeyRaw = attackerActorKeyRaw
  PaGlobal_RoseWarDeadMessage._respawnTime = respawnTime
  PaGlobal_RoseWarDeadMessage._isObserverMode = false
  if ToClient_isPlayingSequence() == true then
    return
  end
  self:closeOtherPanel()
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_DeadMessage)
  if respawnTime <= 0 then
    self._rapidReviveTime = 0
    self._normalReviveTime = 0
  else
    respawnTime = respawnTime / 1000
    self._rapidReviveTime = respawnTime - (ToClient_GetRoseWarReviveTime(false) - ToClient_GetRoseWarReviveTime(true))
    self._normalReviveTime = respawnTime
    if 0 >= self._rapidReviveTime then
      self._rapidReviveTime = 0
    end
    if 0 >= self._normalReviveTime then
      self._normalReviveTime = 0
    end
  end
  self._ui.static_FixedResurrectionPoint:SetShow(false)
  self._ui.rdo_rapidRespawn:SetCheck(false)
  self._ui.rdo_normalRespawn:SetCheck(true)
  self._ui.btn_observer:SetShow(true)
  ToClient_UpdateRoseWarFierceBattleDeadMessage()
  self:updateDeathMessage(attackerActorKeyRaw)
  local fixedResurrectionPoint = ToClient_GetCurrentFixedResurrectionPoint()
  for fierceBattleKey = 1, 20 do
    self._fierceBattleList[fierceBattleKey].stc_cantRevive:SetShow(false)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKey)
    if fierceBattleStaticStatusWrapper ~= nil then
      local canRevive = fierceBattleStaticStatusWrapper:canRevive()
      self._fierceBattleList[fierceBattleKey].stc_cantRevive:SetShow(canRevive == false)
      if canRevive == false and fixedResurrectionPoint ~= nil and fixedResurrectionPoint:getFierceBattleKey() == fierceBattleKey then
        self._fierceBattleList[fierceBattleKey].stc_cantRevive:SetShow(false)
      end
    end
  end
  self:updateCastle()
  self._ui.btn_devRevive:SetShow(ToClient_IsDevelopment() == true)
  local selfPlayer = getSelfPlayer()
  if selfPlayer ~= nil then
    local sectorSize = 12800
    local leftSectorPosX = -49 * sectorSize
    local rightSectorPosX = -17 * sectorSize
    local leftSectorPosY = -33 * sectorSize
    local rightSectorPosY = -54 * sectorSize
    local position = selfPlayer:get():getPosition()
    local xRate = math.abs(position.x - leftSectorPosX) / math.abs(rightSectorPosX - leftSectorPosX)
    local yRate = math.abs(position.z - leftSectorPosY) / math.abs(rightSectorPosY - leftSectorPosY)
    local newPosX = self._ui.static_battleMap:GetSizeX() * xRate - self._ui.static_LastDead:GetSizeX() / 2
    local newPosY = self._ui.static_battleMap:GetSizeY() * 0.8 * yRate - self._ui.static_LastDead:GetSizeY() / 2
    self._ui.static_LastDead:SetPosXY(newPosX, newPosY)
    self._ui.static_LastDead:SetShow(true)
  end
  self:computePos()
  self:open()
  local aniInfo = self._ui.static_centerBG:addColorAnimation(0, 2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo.IsChangeChild = true
  local aniInfo2 = self._ui.static_battleMap:addColorAnimation(0, 2, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo2.IsChangeChild = true
end
function PaGlobal_RoseWarDeadMessage:open()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  Panel_RoseWar_DeadMessage:SetShow(true)
end
function PaGlobal_RoseWarDeadMessage:preapreClose()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  if self._prevUIMode ~= nil then
    SetUIMode(self._prevUIMode)
  end
  self._prevUIMode = nil
  self:close()
end
function PaGlobal_RoseWarDeadMessage:close()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  Panel_RoseWar_DeadMessage:SetShow(false)
end
function PaGlobal_RoseWarDeadMessage:closeOtherPanel()
  PanelCloseFunc_Skill()
  if PaGlobalFunc_Finish_WorldBossItemLooting ~= nil then
    PaGlobalFunc_Finish_WorldBossItemLooting()
  end
  PaGlobal_DeadMessage_All:closeChannelMoveWindow()
  close_attacked_WindowPanelList(true)
end
function PaGlobal_RoseWarDeadMessage:updateFierceBattleDeadMessage(fierceBattleKey, roseWarTeamNo)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local fierceBattleIconSet = self._fierceBattleList[fierceBattleKey]
  if fierceBattleIconSet == nil then
    return
  end
  self:changeFierceBattleColor(fierceBattleKey, roseWarTeamNo)
  if self._selectedFierceBattleKey == fierceBattleKey then
    self._selectedFierceBattleKey = nil
    self._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Count
  end
end
function PaGlobal_RoseWarDeadMessage:changeFierceBattleColor(fierceBattleKey, roseWarTeamNo)
  local fierceBattleIconSet = self._fierceBattleList[fierceBattleKey]
  if fierceBattleIconSet == nil then
    return
  end
  local fierceBattle = self._fierceBattleList[fierceBattleKey].icon
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local myRoseWarTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
  if roseWarTeamNo == __eRoseWarTeam_Neutral then
    fierceBattle:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 831, 55, 881, 105)
    fierceBattle:getBaseTexture():setUV(x1, y1, x2, y2)
    fierceBattle:setRenderTexture(fierceBattle:getBaseTexture())
    fierceBattle:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 831, 106, 881, 156)
    fierceBattle:getOnTexture():setUV(x1, y1, x2, y2)
    fierceBattle:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 1301, 346, 1351, 396)
    fierceBattle:getClickTexture():setUV(x1, y1, x2, y2)
  elseif roseWarTeamNo == myRoseWarTeamNo then
    fierceBattle:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 513, 55, 563, 105)
    fierceBattle:getBaseTexture():setUV(x1, y1, x2, y2)
    fierceBattle:setRenderTexture(fierceBattle:getBaseTexture())
    fierceBattle:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 525, 308, 575, 358)
    fierceBattle:getOnTexture():setUV(x1, y1, x2, y2)
    fierceBattle:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 1250, 346, 1300, 396)
    fierceBattle:getClickTexture():setUV(x1, y1, x2, y2)
  else
    fierceBattle:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 462, 55, 512, 105)
    fierceBattle:getBaseTexture():setUV(x1, y1, x2, y2)
    fierceBattle:setRenderTexture(fierceBattle:getBaseTexture())
    fierceBattle:ChangeOnTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 474, 308, 524, 358)
    fierceBattle:getOnTexture():setUV(x1, y1, x2, y2)
    fierceBattle:ChangeClickTextureInfoNameAsync("Combine/Etc/Combine_Etc_ElfWar_Command.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(fierceBattle, 1199, 346, 1249, 396)
    fierceBattle:getClickTexture():setUV(x1, y1, x2, y2)
  end
end
function PaGlobal_RoseWarDeadMessage:updateDeathMessage(attackerActorKeyRaw)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local attackerActorProxyWrapper
  if attackerActorKeyRaw ~= nil then
    attackerActorProxyWrapper = getActor(attackerActorKeyRaw)
  end
  local deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
  if attackerActorProxyWrapper ~= nil then
    if attackerActorKeyRaw == selfPlayerWrapper:getActorKey() then
      deadMessageString = PAGetString(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_DisplayMsg")
    else
      local nameType = ToClient_getChatNameType()
      if nameType == __eChatNameType_NickName then
        local playerActorProxyWrapper = getPlayerActor(attackerActorKeyRaw)
        if playerActorProxyWrapper ~= nil then
          deadMessageString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", playerActorProxyWrapper:getUserNickname())
        else
          deadMessageString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
        end
      else
        deadMessageString = PAGetStringParam1(Defines.StringSheet_GAME, "DEADMESSAGE_TEXT_KilledDisplayMsg", "attackerName", attackerActorProxyWrapper:getOriginalName())
      end
    end
  end
  self._ui.text_deathTitle:SetText(deadMessageString)
end
function PaGlobal_RoseWarDeadMessage:updateCastle()
  self._ui.static_SelectBG:SetShow(false)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local isKamasylviaTeam = selfPlayerWrapper:getRoseWarTeamNo() == __eRoseWarTeam_Kamasylvia
  self._ui.static_KamaCastle:SetShow(isKamasylviaTeam)
  self._ui.static_OdilCastle:SetShow(not isKamasylviaTeam)
  local backGroundTextureRoute = ""
  if isKamasylviaTeam == true then
    backGroundTextureRoute = "new_ui_common_forlua/Widget/Rader/ElfWar/ElfWarMap_Resurrectionarea_Kama.dds"
  else
    backGroundTextureRoute = "new_ui_common_forlua/Widget/Rader/ElfWar/ElfWarMap_Resurrectionarea_Odill.dds"
  end
  self._ui.static_battleMap:ChangeTextureInfoNameAsync(backGroundTextureRoute)
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui.static_battleMap, 0, 0, 1025, 880)
  self._ui.static_battleMap:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui.static_battleMap:setRenderTexture(self._ui.static_battleMap:getBaseTexture())
end
function PaGlobal_RoseWarDeadMessage:computePos()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  Panel_RoseWar_DeadMessage:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.static_circleBG:SetSize(getScreenSizeX(), getScreenSizeY())
  self._ui.static_centerBG:SetPosX((getScreenSizeX() - self._ui.static_centerBG:GetSizeX()) / 2)
  self._ui.static_centerBG:SetPosY((getScreenSizeY() - self._ui.static_centerBG:GetSizeY()) / 2)
  self._ui.static_battleMap:SetPosX((getScreenSizeX() - self._ui.static_battleMap:GetSizeX()) / 2)
  self._ui.static_battleMap:SetPosY((getScreenSizeY() - self._ui.static_battleMap:GetSizeY()) / 2)
end
function PaGlobal_RoseWarDeadMessage:validate()
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  self._ui.static_circleBG:isValidate()
  self._ui.static_centerBG:isValidate()
  self._ui.text_deathTitle:isValidate()
  self._ui.static_battleMap:isValidate()
  self._ui.rdo_rapidRespawn:isValidate()
  self._ui.rdo_normalRespawn:isValidate()
  self._ui.text_leftRapidRespawnTime:isValidate()
  self._ui.text_leftNormalRespawnTime:isValidate()
  self._ui.btn_observer:isValidate()
  for i = 1, 20 do
    self._fierceBattleList[i].icon:isValidate()
  end
  self._ui.static_KamaCastle:isValidate()
  self._ui.static_OdilCastle:isValidate()
  self._ui.static_SelectBG:isValidate()
  self._ui.btn_OutsideCastleRespawn:isValidate()
  self._ui.btn_InsideCastleRespawn:isValidate()
  self._ui.btn_PlazaRespawn:isValidate()
  self._ui.static_LastDead:isValidate()
end
function PaGlobal_RoseWarDeadMessage_ReOpen()
  if PaGlobal_RoseWarDeadMessage == nil then
    return
  end
  PaGlobal_RoseWarDeadMessage._ui.static_circleBG:SetShow(true)
  PaGlobal_RoseWarDeadMessage._ui.static_centerBG:SetShow(true)
  PaGlobal_RoseWarDeadMessage._ui.static_battleMap:SetShow(true)
  if PaGlobal_RoseWarDeadMessage._rapidReviveTime <= 0 and 0 >= PaGlobal_RoseWarDeadMessage._normalReviveTime then
    PaGlobal_RoseWarDeadMessage._ui.btn_observer:SetShow(false)
    PaGlobal_RoseWarDeadMessage._isObserverMode = false
  end
end
function FromClient_UpdateRoseWarFierceBattleDeadMessage(fierceBattleKey, roseWarTeamNo)
  PaGlobal_RoseWarDeadMessage:updateFierceBattleDeadMessage(fierceBattleKey, roseWarTeamNo)
end
function HandleEventOn_RoseWarDeadMessage_SelectRespawnFierceBattle(fierceBattleKey)
  local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKey)
  if fierceBattleStaticStatusWrapper == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  local canRevive = fierceBattleStaticStatusWrapper:canRevive()
  if canRevive == false then
    local myRoseWarTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
    local fixedResurrectionPoint = ToClient_GetCurrentFixedResurrectionPoint()
    if fixedResurrectionPoint == nil then
      if fierceBattleStaticStatusWrapper:getTeamNo() ~= myRoseWarTeamNo then
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotMyFierceBattleTeam"))
      else
        Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistAdvancedBase"))
      end
      return
    end
    if fixedResurrectionPoint:getFierceBattleKey() ~= fierceBattleKey or fixedResurrectionPoint:getEndTime() < Int64toInt32(getServerUtc64()) then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoNotExistAdvancedBase"))
      return
    end
  end
  PaGlobal_RoseWarDeadMessage._ui.static_SelectBG:SetShow(false)
  PaGlobal_RoseWarDeadMessage._selectedFierceBattleKey = fierceBattleKey
  PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_FierceBattle
  local isRapidRevive
  if PaGlobal_RoseWarDeadMessage._ui.rdo_rapidRespawn:IsCheck() == true then
    isRapidRevive = true
  elseif PaGlobal_RoseWarDeadMessage._ui.rdo_normalRespawn:IsCheck() == true then
    isRapidRevive = false
  end
  if isRapidRevive == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSelectRoseWarReviveType"))
    return
  end
  local function revive()
    local servantNo = toInt64(0, 0)
    local servantInfo = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
    if servantInfo ~= nil then
      servantNo = servantInfo:getServantNo()
    end
    deadMessage_Revival(__eRespawnType_RoseWar, 255, 0, getSelfPlayer():getRegionKey(), false, servantNo, false, false, PaGlobal_RoseWarDeadMessage._selectedFierceBattleKey, PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType, isRapidRevive, 0)
  end
  local fierceBattleName = ""
  if fierceBattleStaticStatusWrapper ~= nil then
    fierceBattleName = fierceBattleStaticStatusWrapper:getName()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_SANCTUM", "target", fierceBattleName),
    functionYes = revive,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function HandleEventOn_RoseWarDeadMessage_ShowRespawnPosition(isKamasylviaTeam)
  PaGlobal_RoseWarDeadMessage._ui.static_SelectBG:SetShow(not PaGlobal_RoseWarDeadMessage._ui.static_SelectBG:GetShow())
  if isKamasylviaTeam == true then
    PaGlobal_RoseWarDeadMessage._ui.static_SelectBG:SetPosXY(PaGlobal_RoseWarDeadMessage._ui.static_KamaCastle:GetPosX() + 50, PaGlobal_RoseWarDeadMessage._ui.static_KamaCastle:GetPosY())
  else
    PaGlobal_RoseWarDeadMessage._ui.static_SelectBG:SetPosXY(PaGlobal_RoseWarDeadMessage._ui.static_OdilCastle:GetPosX() + 50, PaGlobal_RoseWarDeadMessage._ui.static_OdilCastle:GetPosY())
  end
end
function HandleEventOn_RoseWarDeadMessage_SelectRespawnCastle(positionType)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  PaGlobal_RoseWarDeadMessage._selectedFierceBattleKey = 0
  PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Count
  if positionType == 1 then
    if selfPlayerWrapper:getRoseWarTeamNo() == 0 then
      PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Kamasylvia_OuterCastleGate
    elseif selfPlayerWrapper:getRoseWarTeamNo() == 1 then
      PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Odyllita_OuterCastleGate
    end
  elseif positionType == 2 then
    if selfPlayerWrapper:getRoseWarTeamNo() == 0 then
      PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Kamasylvia_InsideCastleGate
    elseif selfPlayerWrapper:getRoseWarTeamNo() == 1 then
      PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Odyllita_InsideCastleGate
    end
  elseif positionType == 3 then
    if selfPlayerWrapper:getRoseWarTeamNo() == 0 then
      PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Kamasylvia_Plaza
    elseif selfPlayerWrapper:getRoseWarTeamNo() == 1 then
      PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType = __eRoseWarRespawnPositionType_Odyllita_Plaza
    end
  end
  local isRapidRevive
  if PaGlobal_RoseWarDeadMessage._ui.rdo_rapidRespawn:IsCheck() == true then
    isRapidRevive = true
  elseif PaGlobal_RoseWarDeadMessage._ui.rdo_normalRespawn:IsCheck() == true then
    isRapidRevive = false
  end
  if isRapidRevive == nil then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSelectRoseWarReviveType"))
    return
  end
  if PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType == __eRoseWarRespawnPositionType_Count then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoSelectRoseWarRevivePositionType"))
    return
  end
  local function revive()
    local servantNo = toInt64(0, 0)
    local servantInfo = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
    if servantInfo ~= nil then
      servantNo = servantInfo:getServantNo()
    end
    deadMessage_Revival(__eRespawnType_RoseWar, 255, 0, getSelfPlayer():getRegionKey(), false, servantNo, false, false, PaGlobal_RoseWarDeadMessage._selectedFierceBattleKey, PaGlobal_RoseWarDeadMessage._selectedRespawnPositionType, isRapidRevive, 0)
  end
  local messageBoxDesc = ""
  if positionType == 1 then
    messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_OUTGATE")
  elseif positionType == 2 then
    messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_INGATE")
  elseif positionType == 3 then
    messageBoxDesc = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_CONFIRM_SQUARE")
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = messageBoxDesc,
    functionYes = revive,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function EventSelfPlayerDeadInRoseWar(attackerActorKeyRaw, respawnTime)
  PaGlobal_RoseWarDeadMessage:prepareOpen(attackerActorKeyRaw, respawnTime)
end
function EventSelfPlayerReviveInRoseWar()
  PaGlobal_RoseWarDeadMessage:preapreClose()
end
function HandleEventOn_RoseWarDeadMessage_SelectDevRevive()
  local servantNo = toInt64(0, 0)
  local servantInfo = ToClient_GetLastUnsealVehicleCaheDataAt(__eServantTypeVehicle)
  if servantInfo ~= nil then
    servantNo = servantInfo:getServantNo()
  end
  deadMessage_Revival(__eRespawnType_Immediately, 0, CppEnums.ItemWhereType.eCashInventory, getSelfPlayer():getRegionKey(), false, servantNo, false, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
end
function HandleEventOn_RoseWarDeadMessage_ChangeToObserverMode()
  PaGlobal_RoseWarDeadMessage._ui.static_circleBG:SetShow(false)
  PaGlobal_RoseWarDeadMessage._ui.static_centerBG:SetShow(false)
  PaGlobal_RoseWarDeadMessage._ui.static_battleMap:SetShow(false)
  PaGlobal_RoseWarDeadMessage._isObserverMode = true
  observerCameraModeStart()
  if PaGlobal_RoseWarDeadMessage._rapidReviveTime <= 0 then
    ShowCommandFunc(PaGlobal_RoseWarDeadMessage._normalReviveTime)
  else
    ShowCommandFunc(PaGlobal_RoseWarDeadMessage._rapidReviveTime)
  end
  PaGlobal_DeadMessage_All:actionGuideOnOff(false)
end
function FromClient_RoseWar_DeadMessage_All_OnScreenReSize()
  PaGlobal_RoseWarDeadMessage:computePos()
end
function FromClient_ReviveToNearTown(state)
  if state == __eRoseWar_Start then
    return
  end
  if Panel_RoseWar_DeadMessage:GetShow() == false then
    return
  end
  deadMessage_Revival(__eRespawnType_NearTown, 255, 0, getSelfPlayer():getRegionKey(), false, toInt64(0, 0), false, false, 0, __eRoseWarRespawnPositionType_Count, false, 0)
  if EventSelfPlayerReviveInRoseWar ~= nil then
    EventSelfPlayerReviveInRoseWar()
  end
end
function HandleEventOn_RoseWarDeadMessage_ShowToolip(isRapidRevive, isShow)
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  if isShow == nil or isRapidRevive == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local name = ""
  if isRapidRevive == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_TYPE_FAST_TOOLTIP")
    TooltipSimple_Show(PaGlobal_RoseWarDeadMessage._ui.rdo_rapidRespawn, name)
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_RIVAVE_TYPE_NORMAL_TOOLTIP")
    TooltipSimple_Show(PaGlobal_RoseWarDeadMessage._ui.rdo_normalRespawn, name)
  end
end
function HandleEventOn_RoseWarDeadMessage_ShowFierceBattleTooltip(isShow, fierceBattleKey)
  if Panel_RoseWar_DeadMessage == nil then
    return
  end
  if isShow == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKey)
  if fierceBattleStaticStatusWrapper ~= nil then
    local name = fierceBattleStaticStatusWrapper:getName()
    local control = PaGlobal_RoseWarDeadMessage._fierceBattleList[fierceBattleKey].icon
    if control ~= nil then
      TooltipSimple_Show(control, name)
    end
  end
end
