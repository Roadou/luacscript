function PaGlobal_RoseWar_NakWarLog_L:initialize()
  if self._initialize == true then
    return
  end
  self._ui.static_PositiveBox = UI.getChildControl(Panel_RoseWar_Nak_WarLog_L, "Static_WarLog_PositiveBox")
  self._ui.static_NegativeBox = UI.getChildControl(Panel_RoseWar_Nak_WarLog_L, "Static_WarLog_NegativeBox")
  self._ui.static_NeutralBox = UI.getChildControl(Panel_RoseWar_Nak_WarLog_L, "Static_WarLog_NeutralBox")
  self:registEventHandler()
  self:validate()
  self:createTemplate()
  if ToClient_IsRoseWarObserveMode() == true then
    FromClient_RoseWarNakWarLog_L_ChangeRoseWarState(ToClient_GetRoseWarState())
  end
  self._initialize = true
end
function PaGlobal_RoseWar_NakWarLog_L:createTemplate()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  self._ui.static_PositiveBox:SetShow(false)
  self._ui.static_NegativeBox:SetShow(false)
  self._ui.static_NeutralBox:SetShow(false)
  for idx = 0, self._maxShowCount do
    local log = {
      _positiveBox = nil,
      _positive = nil,
      _positiveIcon = nil,
      _positiveImage = nil,
      _positiveMsg = nil,
      _negativeBox = nil,
      _negative = nil,
      _negativeIcon = nil,
      _negativeImage = nil,
      _negativeMsg = nil,
      _neutralBox = nil,
      _neutral = nil,
      _neutralIcon = nil,
      _neutralImage = nil,
      _neutralMsg = nil,
      _neutralSkill = nil,
      _neutralSkillIcon = nil,
      _neutralSkillDesc = nil,
      _boxType = NakWarLog_BoxType.count
    }
    local positiveBox = UI.cloneControl(self._ui.static_PositiveBox, Panel_RoseWar_Nak_WarLog_L, "Static_WarLog_PositiveBox_Copy_" .. idx)
    log._positiveBox = positiveBox
    log._positive = UI.getChildControl(positiveBox, "Static_WarLog_Positive")
    log._positiveIcon = UI.getChildControl(log._positive, "Static_Icon")
    log._positiveImage = UI.getChildControl(log._positive, "Static_Image")
    log._positiveMsg = UI.getChildControl(log._positive, "StaticText_Msg")
    local negativeBox = UI.cloneControl(self._ui.static_NegativeBox, Panel_RoseWar_Nak_WarLog_L, "Static_WarLog_NegativeBox_Copy_" .. idx)
    log._negativeBox = negativeBox
    log._negative = UI.getChildControl(negativeBox, "Static_WarLog_Negative")
    log._negativeIcon = UI.getChildControl(log._negative, "Static_Icon")
    log._negativeImage = UI.getChildControl(log._negative, "Static_Image")
    log._negativeMsg = UI.getChildControl(log._negative, "StaticText_Msg")
    local neutralBox = UI.cloneControl(self._ui.static_NeutralBox, Panel_RoseWar_Nak_WarLog_L, "Static_WarLog_NeutralBox_Copy_" .. idx)
    log._neutralBox = neutralBox
    log._neutral = UI.getChildControl(neutralBox, "Static_WarLog_Neutral")
    log._neutralIcon = UI.getChildControl(log._neutral, "Static_Icon")
    log._neutralImage = UI.getChildControl(log._neutral, "Static_Image")
    log._neutralMsg = UI.getChildControl(log._neutral, "StaticText_Msg")
    log._neutralSkill = UI.getChildControl(log._neutral, "Static_SkillBG")
    log._neutralSkillIcon = UI.getChildControl(log._neutralSkill, "Static_SkillIcon")
    log._neutralSkillDesc = UI.getChildControl(log._neutralSkill, "Static_SkillDesc")
    table.insert(self._readyLogList, log)
  end
end
function PaGlobal_RoseWar_NakWarLog_L:registEventHandler()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarNakWarLog_L_ChangeRoseWarState")
  registerEvent("FromClient_SetRoseWarObserveMode", "PaGlobalFunc_RoseWarNakWarLog_L_Open")
  registerEvent("FromClient_UnsetRoseWarObserveMode", "PaGlobalFunc_RoseWarNakWarLog_L_Close")
  Panel_RoseWar_Nak_WarLog_L:RegisterUpdateFunc("RoseWar_WarLog_L_UpdateFrame")
end
function RoseWar_WarLog_L_UpdateFrame(deltaTime)
  PaGlobal_RoseWar_NakWarLog_L:updatePerFrame(deltaTime)
end
function PaGlobal_RoseWar_NakWarLog_L:prepareOpen()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  self:open()
end
function PaGlobal_RoseWar_NakWarLog_L:open()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  Panel_RoseWar_Nak_WarLog_L:SetShow(true)
end
function PaGlobal_RoseWar_NakWarLog_L:prepareClose()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWar_NakWarLog_L:close()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  Panel_RoseWar_Nak_WarLog_L:SetShow(false)
end
function PaGlobal_RoseWar_NakWarLog_L:updatePosition()
  local posY = Panel_RoseWar_Nak_WarLog_L:GetSizeY()
  local count = table.getn(self._showingLogList)
  for i = count, 1, -1 do
    local logUI = self._showingLogList[i]
    if logUI ~= nil then
      if logUI._neutralBox:GetShow() == true then
        posY = posY - logUI._neutralSkillDesc:GetSizeY()
      end
      logUI._positiveBox:SetPosXY(logUI._positiveBox:GetPosX(), posY)
      logUI._negativeBox:SetPosXY(logUI._negativeBox:GetPosX(), posY)
      logUI._neutralBox:SetPosXY(logUI._neutralBox:GetPosX(), posY)
      posY = posY - logUI._positiveBox:GetSizeY()
    end
  end
end
function PaGlobal_RoseWar_NakWarLog_L:updatePerFrame(deltaTime)
  self:updateShowingLogUI(deltaTime)
  if table.getn(self._logInfoList) <= 0 or 0 >= table.getn(self._readyLogList) then
    return
  end
  local logInfo = table.remove(self._logInfoList, 1)
  local logUI = table.remove(self._readyLogList, 1)
  self:setLogInfo(logInfo, logUI)
  self:updatePosition()
end
function PaGlobal_RoseWar_NakWarLog_L:updateShowingLogUI(deltaTime)
  for i in pairs(self._showingLogList) do
    local logUI = self._showingLogList[i]
    if logUI ~= nil then
      local showingUI
      if logUI._boxType == NakWarLog_BoxType.positive then
        showingUI = logUI._positiveBox
      elseif logUI._boxType == NakWarLog_BoxType.negative then
        showingUI = logUI._negativeBox
      elseif logUI._boxType == NakWarLog_BoxType.neutral then
        showingUI = logUI._neutralBox
      end
      if showingUI:GetShow() == false then
        table.remove(self._showingLogList, i)
        table.insert(self._readyLogList, logUI)
      end
    end
  end
end
function PaGlobal_RoseWar_NakWarLog_L:setLogInfo(logInfo, logUI)
  local positiveBox = logUI._positiveBox
  local positive = logUI._positive
  local positiveIcon = logUI._positiveIcon
  local positiveImage = logUI._positiveImage
  local positiveMsg = logUI._positiveMsg
  local negativeBox = logUI._negativeBox
  local negative = logUI._negative
  local negativeIcon = logUI._negativeIcon
  local negativeImage = logUI._negativeImage
  local negativeMsg = logUI._negativeMsg
  local neutralBox = logUI._neutralBox
  local neutral = logUI._neutral
  local neutralIcon = logUI._neutralIcon
  local neutralImage = logUI._neutralImage
  local neutralMsg = logUI._neutralMsg
  local neutralSkill = logUI._neutralSkill
  local neutralSkillIcon = logUI._neutralSkillIcon
  local neutralSkillDesc = logUI._neutralSkillDesc
  local txtSkillDesc = UI.getChildControl(neutralSkillDesc, "StaticText_SkillDesc")
  positiveBox:SetShow(false)
  positive:SetShow(false)
  positiveIcon:SetShow(false)
  positiveImage:SetShow(false)
  positiveMsg:SetShow(true)
  negativeBox:SetShow(false)
  negative:SetShow(false)
  negativeIcon:SetShow(false)
  negativeImage:SetShow(false)
  negativeMsg:SetShow(true)
  neutralBox:SetShow(false)
  neutral:SetShow(false)
  neutralIcon:SetShow(false)
  neutralImage:SetShow(false)
  neutralMsg:SetShow(true)
  neutralSkill:SetShow(false)
  neutralSkillIcon:SetShow(false)
  neutralSkillDesc:SetShow(false)
  txtSkillDesc:SetShow(false)
  logUI._boxType = NakWarLog_BoxType.count
  if logInfo._type == __eRoseWarWarLogType_Occupy_BattleFierceBattle then
    positiveBox:SetShow(true)
    positive:SetShow(true)
    positiveIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    positiveMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SANCTUM_OCCUPY", "sanctumname", fierceBattleName))
    logUI._boxType = NakWarLog_BoxType.positive
    positiveBox:EraseAllEffect()
    positiveBox:AddEffect("fUI_RoseWar_WarLog_01B_Blue", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 1)
    _AudioPostEvent_SystemUiForXBOX(36, 1)
  elseif logInfo._type == __eRoseWarWarLogType_Capture_BattleFierceBattle_Negative then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    negativeMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SANCTUM_CAPTURE_NEGATIVE", "sanctumname", fierceBattleName))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 2)
    _AudioPostEvent_SystemUiForXBOX(36, 2)
  elseif logInfo._type == __eRoseWarWarLogType_Capture_BattleFierceBattle_Positive then
    positiveBox:SetShow(true)
    positive:SetShow(true)
    positiveIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    positiveMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SANCTUM_CAPTURE_POSITIVE", "sanctumname", fierceBattleName))
    logUI._boxType = NakWarLog_BoxType.positive
    positiveBox:EraseAllEffect()
    positiveBox:AddEffect("fUI_RoseWar_WarLog_01B_Blue", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 3)
    _AudioPostEvent_SystemUiForXBOX(36, 3)
  elseif logInfo._type == __eRoseWarWarLogType_Free_BattleFierceBattle_Negative then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    negativeMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SANCTUM_FREE_NEGATIVE", "sanctumname", fierceBattleName))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 4)
    _AudioPostEvent_SystemUiForXBOX(36, 4)
  elseif logInfo._type == __eRoseWarWarLogType_Free_BattleFierceBattle_Positive then
    positiveBox:SetShow(true)
    positive:SetShow(true)
    positiveIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    positiveMsg:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SANCTUM_FREE_POSITIVE", "sanctumname", fierceBattleName))
    logUI._boxType = NakWarLog_BoxType.positive
    positiveBox:EraseAllEffect()
    positiveBox:AddEffect("fUI_RoseWar_WarLog_01B_Blue", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 5)
    _AudioPostEvent_SystemUiForXBOX(36, 5)
  elseif logInfo._type == __eRoseWarWarLogType_Occupy_GimicAdrenalinFierceBattle then
    neutralBox:SetShow(true)
    neutral:SetShow(true)
    neutralIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    neutralMsg:SetText("<PAColor0xFF438DCC>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALTAR_POSITIVE", "altarname", fierceBattleName) .. "<PAOldColor>")
    logUI._boxType = NakWarLog_BoxType.neutral
    neutralBox:EraseAllEffect()
    neutralBox:AddEffect("fUI_RoseWar_WarLog_01B_Yellow", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 46)
    _AudioPostEvent_SystemUiForXBOX(36, 46)
  elseif logInfo._type == __eRoseWarWarLogType_Destory_GimicAdrenalinFierceBattle then
    neutralBox:SetShow(true)
    neutral:SetShow(true)
    neutralIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    neutralMsg:SetText("<PAColor0xFFD05D48>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALTAR_NEGATIVE", "altarname", fierceBattleName) .. "<PAOldColor>")
    logUI._boxType = NakWarLog_BoxType.neutral
    neutralBox:EraseAllEffect()
    neutralBox:AddEffect("fUI_RoseWar_WarLog_01B_Yellow", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 47)
    _AudioPostEvent_SystemUiForXBOX(36, 47)
  elseif logInfo._type == __eRoseWarWarLogType_KamaBoss_HP90 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Kama")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_KAMA_90"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 53)
    _AudioPostEvent_SystemUiForXBOX(36, 53)
  elseif logInfo._type == __eRoseWarWarLogType_KamaBoss_HP70 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Kama")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_KAMA_70"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 54)
    _AudioPostEvent_SystemUiForXBOX(36, 54)
  elseif logInfo._type == __eRoseWarWarLogType_KamaBoss_HP50 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Kama")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_KAMA_50"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 55)
    _AudioPostEvent_SystemUiForXBOX(36, 55)
  elseif logInfo._type == __eRoseWarWarLogType_KamaBoss_HP30 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Kama")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_KAMA_30"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 56)
    _AudioPostEvent_SystemUiForXBOX(36, 56)
  elseif logInfo._type == __eRoseWarWarLogType_KamaBoss_HP10 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Kama")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_KAMA_10"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 57)
    _AudioPostEvent_SystemUiForXBOX(36, 57)
  elseif logInfo._type == __eRoseWarWarLogType_OdilBoss_HP90 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Odil")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_ODYL_90"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 53)
    _AudioPostEvent_SystemUiForXBOX(36, 53)
  elseif logInfo._type == __eRoseWarWarLogType_OdilBoss_HP70 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Odil")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_ODYL_70"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 54)
    _AudioPostEvent_SystemUiForXBOX(36, 54)
  elseif logInfo._type == __eRoseWarWarLogType_OdilBoss_HP50 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Odil")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_ODYL_50"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 55)
    _AudioPostEvent_SystemUiForXBOX(36, 55)
  elseif logInfo._type == __eRoseWarWarLogType_OdilBoss_HP30 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Odil")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_ODYL_30"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 56)
    _AudioPostEvent_SystemUiForXBOX(36, 56)
  elseif logInfo._type == __eRoseWarWarLogType_OdilBoss_HP10 then
    negativeBox:SetShow(true)
    negative:SetShow(true)
    negativeImage:SetShow(true)
    negativeImage:ChangeTextureInfoTextureIDAsync("Combine_Etc_Nak_RoseWar_Ingame_Profile_Odil")
    negativeImage:setRenderTexture(negativeImage:getBaseTexture())
    negativeMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALLYOFFICER_ODYL_10"))
    logUI._boxType = NakWarLog_BoxType.negative
    negativeBox:EraseAllEffect()
    negativeBox:AddEffect("fUI_RoseWar_WarLog_01B_Red", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 57)
    _AudioPostEvent_SystemUiForXBOX(36, 57)
  elseif logInfo._type == __eRoseWarWarLogType_KamaSylvia_UseSkill then
    neutralBox:SetShow(true)
    neutral:SetShow(true)
    neutralSkill:SetShow(true)
    neutralSkillIcon:SetShow(true)
    neutralSkillDesc:SetShow(true)
    txtSkillDesc:SetShow(true)
    local skillname = ""
    local skillNo = ToClient_GetRoseWarSkillKey(logInfo._param1)
    local skillTypeSS = getSkillTypeStaticStatus(skillNo)
    local skillString = ""
    if skillTypeSS ~= nil then
      local level = getLearnedSkillLevel(skillTypeSS)
      local skillStatic = getSkillStaticStatus(skillNo, level)
      if skillStatic ~= nil then
        local skillTypeSSW = skillStatic:getSkillTypeStaticStatusWrapper()
        if skillTypeSSW ~= nil then
          skillname = skillTypeSSW:getName()
        end
      end
    end
    local isSameTeam = false
    local myRoseWarTeamNo = getSelfPlayer():getRoseWarTeamNo()
    if ToClient_IsRoseWarObserveMode() == true then
      myRoseWarTeamNo = ToClient_GetRoseObserveTeamNo()
      isSameTeam = true
    elseif myRoseWarTeamNo == __eRoseWarTeam_Kamasylvia then
      isSameTeam = true
    else
      isSameTeam = false
    end
    if isSameTeam == true then
      skillname = "<PAColor0xFF438DCC>" .. skillname .. "<PAOldColor>"
    else
      skillname = "<PAColor0xFFD05D48>" .. skillname .. "<PAOldColor>"
    end
    if logInfo._param1 == __eRoseWarSkillType_Scan then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015280.dds")
      skillString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_1", "skillname", skillname)
    elseif logInfo._param1 == __eRoseWarSkillType_Recall then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015281.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_6", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_Bombard then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015282.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_3_KAMA", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_Summon then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015283.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_4", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_Conceal then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015284.dds")
      skillString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_2", "skillname", skillname)
    elseif logInfo._param1 == __eRoseWarSkillType_Zonya then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015285.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_5", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_FixedResurrection then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015287.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_7", "skillname", skillname, "sanctumname", fierceBattleName)
    else
      UI.ASSERT(false, "RoseWarSkillType\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148! (" .. tostring(logInfo._type) .. ", " .. tostring(logInfo._param1) .. ")")
      return
    end
    local x1, y1, x2, y2 = setTextureUV_Func(neutralSkillIcon, 0, 0, 44, 44)
    neutralSkillIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    neutralSkillIcon:setRenderTexture(neutralSkillIcon:getBaseTexture())
    neutralMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_KAMA"))
    txtSkillDesc:SetText(skillString)
    logUI._boxType = NakWarLog_BoxType.neutral
    neutralBox:EraseAllEffect()
    neutralBox:AddEffect("fUI_RoseWar_WarLog_01B_Yellow", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 58)
    _AudioPostEvent_SystemUiForXBOX(36, 58)
  elseif logInfo._type == __eRoseWarWarLogType_Odylita_UseSkill then
    neutralBox:SetShow(true)
    neutral:SetShow(true)
    neutralSkill:SetShow(true)
    neutralSkillIcon:SetShow(true)
    neutralSkillDesc:SetShow(true)
    txtSkillDesc:SetShow(true)
    local skillname = ""
    local skillNo = ToClient_GetRoseWarSkillKey(logInfo._param1)
    local skillTypeSS = getSkillTypeStaticStatus(skillNo)
    local skillString = ""
    if skillTypeSS ~= nil then
      local level = getLearnedSkillLevel(skillTypeSS)
      local skillStatic = getSkillStaticStatus(skillNo, level)
      if skillStatic ~= nil then
        local skillTypeSSW = skillStatic:getSkillTypeStaticStatusWrapper()
        if skillTypeSSW ~= nil then
          skillname = skillTypeSSW:getName()
        end
      end
    end
    local isSameTeam = false
    local myRoseWarTeamNo = getSelfPlayer():getRoseWarTeamNo()
    if ToClient_IsRoseWarObserveMode() == true then
      myRoseWarTeamNo = ToClient_GetRoseObserveTeamNo()
      isSameTeam = false
    elseif myRoseWarTeamNo == __eRoseWarTeam_Odyllita then
      isSameTeam = true
    else
      isSameTeam = false
    end
    if isSameTeam == true then
      skillname = "<PAColor0xFF438DCC>" .. skillname .. "<PAOldColor>"
    else
      skillname = "<PAColor0xFFD05D48>" .. skillname .. "<PAOldColor>"
    end
    if logInfo._param1 == __eRoseWarSkillType_Scan then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015280.dds")
      skillString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_1", "skillname", skillname)
    elseif logInfo._param1 == __eRoseWarSkillType_Recall then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015281.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_6", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_Bombard then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015282.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_3_ODYL", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_Summon then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015283.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_4", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_Conceal then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015284.dds")
      skillString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_2", "skillname", skillname)
    elseif logInfo._param1 == __eRoseWarSkillType_Zonya then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015285.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_5", "skillname", skillname, "sanctumname", fierceBattleName)
    elseif logInfo._param1 == __eRoseWarSkillType_FixedResurrection then
      neutralSkillIcon:ChangeTextureInfoNameAsync("icon/new_icon/04_pc_skill/07_guild_skill/00015287.dds")
      local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param2)
      local fierceBattleName = ""
      if fierceBattleStaticStatusWrapper ~= nil then
        fierceBattleName = fierceBattleStaticStatusWrapper:getName()
      end
      if isSameTeam == true then
        fierceBattleName = "<PAColor0xFF438DCC>" .. fierceBattleName .. "<PAOldColor>"
      else
        fierceBattleName = "<PAColor0xFFD05D48>" .. fierceBattleName .. "<PAOldColor>"
      end
      skillString = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_7", "skillname", skillname, "sanctumname", fierceBattleName)
    else
      UI.ASSERT(false, "RoseWarSkillType\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. \236\151\172\234\184\176\235\143\132 \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148! (" .. tostring(logInfo._type) .. ", " .. tostring(logInfo._param1) .. ")")
      return
    end
    local x1, y1, x2, y2 = setTextureUV_Func(neutralSkillIcon, 0, 0, 44, 44)
    neutralSkillIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    neutralSkillIcon:setRenderTexture(neutralSkillIcon:getBaseTexture())
    neutralMsg:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_SKILL_ODYL"))
    txtSkillDesc:SetText(skillString)
    logUI._boxType = NakWarLog_BoxType.neutral
    neutralBox:EraseAllEffect()
    neutralBox:AddEffect("fUI_RoseWar_WarLog_01B_Yellow", false, -positiveBox:GetSizeX(), 0)
    audioPostEvent_SystemUi(36, 59)
    _AudioPostEvent_SystemUiForXBOX(36, 59)
  elseif logInfo._type == __eRoseWarWarLogType_Occupy_GimicConquestFierceBattle then
    neutralBox:SetShow(true)
    neutral:SetShow(true)
    neutralIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    neutralMsg:SetText("<PAColor0xFF438DCC>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALTAR_POSITIVE", "altarname", fierceBattleName) .. "<PAOldColor>")
    logUI._boxType = NakWarLog_BoxType.neutral
    neutralBox:EraseAllEffect()
    neutralBox:AddEffect("fUI_RoseWar_WarLog_01A_Yellow", false, 0, 0)
    audioPostEvent_SystemUi(36, 46)
    _AudioPostEvent_SystemUiForXBOX(36, 46)
  elseif logInfo._type == __eRoseWarWarLogType_Destory_GimicConquestFierceBattle then
    neutralBox:SetShow(true)
    neutral:SetShow(true)
    neutralIcon:SetShow(true)
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(logInfo._param1)
    local fierceBattleName = ""
    if fierceBattleStaticStatusWrapper ~= nil then
      fierceBattleName = fierceBattleStaticStatusWrapper:getName()
    end
    neutralMsg:SetText("<PAColor0xFFD05D48>" .. PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_LOG_ALTAR_NEGATIVE", "altarname", fierceBattleName) .. "<PAOldColor>")
    logUI._boxType = NakWarLog_BoxType.neutral
    neutralBox:EraseAllEffect()
    neutralBox:AddEffect("fUI_RoseWar_WarLog_01A_Yellow", false, 0, 0)
    audioPostEvent_SystemUi(36, 47)
    _AudioPostEvent_SystemUiForXBOX(36, 47)
  else
    UI.ASSERT(false, "RoseWarWarLogType \237\131\128\236\158\133\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164! \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148")
    return
  end
  if logUI._boxType == NakWarLog_BoxType.count then
    UI.ASSERT(false, "NakWarLog_BoxType\236\157\128 \235\176\152\235\147\156\236\139\156 \236\182\148\234\176\128\235\144\152\236\150\180\236\149\188\237\149\169\235\139\136\235\139\164!")
    return
  end
  local showingUI
  if logUI._boxType == NakWarLog_BoxType.positive then
    showingUI = positiveBox
    positive:ResetVertexAni(true)
    positive:SetAlpha(1)
    positiveIcon:ResetVertexAni(true)
    positiveIcon:SetAlpha(1)
    positiveImage:ResetVertexAni(true)
    positiveImage:SetAlpha(1)
    positiveMsg:ResetVertexAni(true)
    positiveMsg:SetFontAlpha(1)
  elseif logUI._boxType == NakWarLog_BoxType.negative then
    showingUI = negativeBox
    negative:ResetVertexAni(true)
    negative:SetAlpha(1)
    negativeIcon:ResetVertexAni(true)
    negativeIcon:SetAlpha(1)
    negativeImage:ResetVertexAni(true)
    negativeImage:SetAlpha(1)
    negativeMsg:ResetVertexAni(true)
    negativeMsg:SetFontAlpha(1)
  elseif logUI._boxType == NakWarLog_BoxType.neutral then
    showingUI = neutralBox
    neutral:ResetVertexAni(true)
    neutral:SetAlpha(1)
    neutralIcon:ResetVertexAni(true)
    neutralIcon:SetAlpha(1)
    neutralImage:ResetVertexAni(true)
    neutralImage:SetAlpha(1)
    negativeMsg:ResetVertexAni(true)
    neutralMsg:SetFontAlpha(1)
    neutralSkill:ResetVertexAni(true)
    neutralSkill:SetAlpha(1)
    neutralSkillIcon:ResetVertexAni(true)
    neutralSkillIcon:SetAlpha(1)
    neutralSkillDesc:ResetVertexAni(true)
    neutralSkillDesc:SetAlpha(1)
    txtSkillDesc:ResetVertexAni(true)
    txtSkillDesc:SetFontAlpha(1)
  end
  showingUI:ResetVertexAni(true)
  showingUI:SetAlpha(1)
  local aniInfo = showingUI:addColorAnimation(self._showingTime - self._hideTime, self._showingTime, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_LINEAR)
  aniInfo:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo:SetHideAtEnd(true)
  aniInfo.IsChangeChild = true
  table.insert(self._showingLogList, logUI)
end
function PaGlobal_RoseWar_NakWarLog_L:validate()
  if Panel_RoseWar_Nak_WarLog_L == nil then
    return
  end
  self._ui.static_PositiveBox:isValidate()
  self._ui.static_NegativeBox:isValidate()
  self._ui.static_NeutralBox:isValidate()
end
