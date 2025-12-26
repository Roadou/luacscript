local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local IM = CppEnums.EProcessorInputMode
Panel_LocalWar:SetShow(false)
Panel_LocalWarTeam:SetShow(false)
Panel_LocalWar:setMaskingChild(true)
Panel_LocalWar:ActiveMouseEventEffect(true)
Panel_LocalWar:setGlassBackground(true)
Panel_LocalWar:RegisterShowEventFunc(true, "LocalWar_ShowAni()")
Panel_LocalWar:RegisterShowEventFunc(false, "LocalWar_HideAni()")
function LocalWar_ShowAni()
end
function LocalWar_HideAni()
end
local isLocalwarOpen = ToClient_IsContentsGroupOpen("43")
local myTeam = UI.getChildControl(Panel_LocalWar, "StaticText_MyTeam")
local accumulateKillCount = UI.getChildControl(Panel_LocalWar, "StaticText_AccumulateKillCountIcon")
local currentContinuityKillCount = UI.getChildControl(Panel_LocalWar, "StaticText_CurrentContinuityKillCountIcon")
local maxContinuityKillCount = UI.getChildControl(Panel_LocalWar, "StaticText_MaxContinuityKillCountIcon")
local buttonQuestion = UI.getChildControl(Panel_LocalWar, "Button_Question")
buttonQuestion:SetShow(false)
local _txt_LocalWarTime, _txt_LocalWarTime, _txt_LocalWarBlack, _txt_LocalWarRed, _txt_TeamBlack, _txt_TeamRed, oldLocalWarFor_AllUI
_oldLocalWarFor_AllUI = UI.getChildControl(Panel_LocalWarTeam, "Static_LocalWar_Old")
_txt_LocalWarTime = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_TimeLine")
_txt_LocalWarBlack = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_ScoreTeamBlackDesert")
_txt_LocalWarRed = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_ScoreTeamRedDesert")
_txt_TeamBlack = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_MyTeamBlack")
_txt_TeamRed = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_MyTeamRed")
local _txt_TeamBlackTitle = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_TeamBlackDesert")
local _txt_TeamRedTitle = UI.getChildControl(_oldLocalWarFor_AllUI, "StaticText_TeamRedDesert")
local isOccupationMode = false
local occupationWinningPoint = 0
local noneTowerTextureUV = {
  [1] = {
    x1 = 289,
    y1 = 500,
    x2 = 339,
    y2 = 550
  },
  [2] = {
    x1 = 340,
    y1 = 500,
    x2 = 390,
    y2 = 550
  },
  [3] = {
    x1 = 391,
    y1 = 500,
    x2 = 441,
    y2 = 550
  },
  [4] = {
    x1 = 442,
    y1 = 500,
    x2 = 492,
    y2 = 550
  },
  [5] = {
    x1 = 493,
    y1 = 500,
    x2 = 543,
    y2 = 550
  }
}
local redTowerTextureUV = {
  [1] = {
    x1 = 289,
    y1 = 551,
    x2 = 339,
    y2 = 601
  },
  [2] = {
    x1 = 340,
    y1 = 551,
    x2 = 390,
    y2 = 601
  },
  [3] = {
    x1 = 391,
    y1 = 551,
    x2 = 441,
    y2 = 601
  },
  [4] = {
    x1 = 442,
    y1 = 551,
    x2 = 492,
    y2 = 601
  },
  [5] = {
    x1 = 493,
    y1 = 551,
    x2 = 543,
    y2 = 601
  }
}
local blackTowerTextureUV = {
  [1] = {
    x1 = 289,
    y1 = 602,
    x2 = 339,
    y2 = 652
  },
  [2] = {
    x1 = 340,
    y1 = 602,
    x2 = 390,
    y2 = 652
  },
  [3] = {
    x1 = 391,
    y1 = 602,
    x2 = 441,
    y2 = 652
  },
  [4] = {
    x1 = 442,
    y1 = 602,
    x2 = 492,
    y2 = 652
  },
  [5] = {
    x1 = 493,
    y1 = 602,
    x2 = 543,
    y2 = 652
  }
}
occuMainBg = UI.getChildControl(Panel_LocalWarTeam, "Static_Mini_BG")
occuLeftTimeText = UI.getChildControl(occuMainBg, "StaticText_TimeLine_Mini")
local occuTeamBlackText = UI.getChildControl(occuMainBg, "StaticText_TeamBlackDesert_Mini")
occuMyTeamBlackIcon = UI.getChildControl(occuTeamBlackText, "Static_MyTeamBlack")
occuScoreBlackScore = UI.getChildControl(occuMainBg, "StaticText_ScoreTeamBlackDesert_Mini")
occuScoreBlackProg = UI.getChildControl(occuMainBg, "Progress2_Blue_Mini")
local occuTeamRedText = UI.getChildControl(occuMainBg, "StaticText_TeamRedDesert_Mini")
occuMyTeamRedIcon = UI.getChildControl(occuTeamRedText, "Static_MyTeamRed")
occuScoreRedScore = UI.getChildControl(occuMainBg, "StaticText_ScoreTeamRedDesert_Mini")
occuScoreRedProg = UI.getChildControl(occuMainBg, "Progress2_Red_Mini")
occuMainBg:SetShow(false)
occuTeamBlackText:SetSize(occuTeamBlackText:GetTextSizeX(), occuTeamBlackText:GetSizeY())
occuMyTeamBlackIcon:ComputePos()
occuMyTeamRedIcon:ComputePos()
occuTeamRedText:SetSize(occuTeamRedText:GetTextSizeX(), occuTeamRedText:GetSizeY())
occupationTowerParent = UI.getChildControl(occuMainBg, "Static_Tower_Icons_Mini")
occupationStateIconList = Array.new()
for idx = 1, 5 do
  local tempTable = {}
  tempTable.towerBg = UI.getChildControl(occupationTowerParent, "Static_Tower_" .. tostring(idx) .. "_Mini")
  tempTable.iconNone = UI.getChildControl(tempTable.towerBg, "Static_None")
  tempTable.iconBlack = UI.getChildControl(tempTable.towerBg, "Static_BlackIcon")
  tempTable.iconRed = UI.getChildControl(tempTable.towerBg, "Static_RedIcon")
  local noneBg = UI.getChildControl(tempTable.iconNone, "Static_1")
  local redBg = UI.getChildControl(tempTable.iconRed, "Static_1")
  local blackBg = UI.getChildControl(tempTable.iconBlack, "Static_1")
  tempTable.stc_effect = UI.getChildControl(tempTable.towerBg, "Static_Effect")
  tempTable.savedScore = UI.getChildControl(tempTable.towerBg, "StaticText_Score")
  tempTable.savedScore:SetShow(false)
  local texture = blackTowerTextureUV[idx]
  local x1, y1, x2, y2 = setTextureUV_Func(blackBg, texture.x1, texture.y1, texture.x2, texture.y2)
  blackBg:getBaseTexture():setUV(x1, y1, x2, y2)
  blackBg:setRenderTexture(blackBg:getBaseTexture())
  texture = redTowerTextureUV[idx]
  local x1, y1, x2, y2 = setTextureUV_Func(redBg, texture.x1, texture.y1, texture.x2, texture.y2)
  redBg:getBaseTexture():setUV(x1, y1, x2, y2)
  redBg:setRenderTexture(redBg:getBaseTexture())
  texture = noneTowerTextureUV[idx]
  local x1, y1, x2, y2 = setTextureUV_Func(noneBg, texture.x1, texture.y1, texture.x2, texture.y2)
  noneBg:getBaseTexture():setUV(x1, y1, x2, y2)
  noneBg:setRenderTexture(noneBg:getBaseTexture())
  occupationStateIconList:push_back(tempTable)
end
function LocalWar_Icon_Tooltip_Event()
  accumulateKillCount:addInputEvent("Mouse_On", "Panel_LocalWar_Icon_ToolTip_Show(" .. 0 .. ")")
  accumulateKillCount:addInputEvent("Mouse_Out", "Panel_LocalWar_Icon_ToolTip_Show()")
  currentContinuityKillCount:addInputEvent("Mouse_On", "Panel_LocalWar_Icon_ToolTip_Show(" .. 1 .. ")")
  currentContinuityKillCount:addInputEvent("Mouse_Out", "Panel_LocalWar_Icon_ToolTip_Show()")
  maxContinuityKillCount:addInputEvent("Mouse_On", "Panel_LocalWar_Icon_ToolTip_Show(" .. 2 .. ")")
  maxContinuityKillCount:addInputEvent("Mouse_Out", "Panel_LocalWar_Icon_ToolTip_Show()")
  buttonQuestion:addInputEvent("Mouse_On", "Panel_LocalWar_Icon_ToolTip_Show(" .. 3 .. ")")
  buttonQuestion:addInputEvent("Mouse_Out", "Panel_LocalWar_Icon_ToolTip_Show()")
end
local saveBlackScore = 0
local saveRedScore = 0
local blackTeam = 0
local redTeam = 0
local killCheck = false
local teamCheck = false
local killCount = {
  _accumulate,
  _current,
  _max
}
local displayTime = function(timeValue)
  timeValue = timeValue / 1000
  if timeValue > 3600 then
    timeValue = timeValue / 3600
    return tostring(timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_CONSIGNMENTSALE_HOUR")
  elseif timeValue > 120 then
    timeValue = timeValue / 60
    return tostring(timeValue) .. PAGetString(Defines.StringSheet_GAME, "LUA_CONSIGNMENTSALE_MINUTE")
  elseif timeValue > 0 then
    return PAGetString(Defines.StringSheet_GAME, "LUA_CONSIGNMENTSALE_DEADLINE")
  else
    return PAGetString(Defines.StringSheet_GAME, "LUA_CONSIGNMENTSALE_SALECLOSE")
  end
end
function LocalWar_KillCount_Init()
  local team = ""
  local teamBlackIconCtrl = _txt_TeamBlack
  local teamRedIconCtrl = _txt_TeamRed
  if true == ToClient_IsOccupationModeInRedBattleField() then
    teamBlackIconCtrl = occuMyTeamBlackIcon
    teamRedIconCtrl = occuMyTeamRedIcon
  end
  teamBlackIconCtrl:SetShow(false)
  teamRedIconCtrl:SetShow(false)
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if 1 == ToClient_GetMyTeamNoRedBattleField() then
    if instanceMapKey == __eInstanceRedBattleField_PapuCrio then
      team = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_5")
    else
      team = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_1")
    end
    teamBlackIconCtrl:SetShow(true)
  else
    if instanceMapKey == __eInstanceRedBattleField_PapuCrio then
      team = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_4")
    else
      team = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_2")
    end
    teamRedIconCtrl:SetShow(true)
  end
  myTeam:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_3", "team", team))
end
function Panel_LocalWar_Icon_ToolTip_Show(index)
  local isShow, name, desc, uiControl = true, nil, nil, nil
  if 0 == index then
    name = "\235\136\132\236\160\129 \236\178\152\236\185\152 \237\154\159\236\136\152"
    uiControl = accumulateKillCount
  elseif 1 == index then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ACCUMULATEKILLCOUNT")
    uiControl = currentContinuityKillCount
  elseif 2 == index then
    name = "\236\181\156\235\140\128 \236\151\176\236\134\141 \236\178\152\236\185\152 \237\154\159\236\136\152"
    uiControl = maxContinuityKillCount
  elseif 3 == index then
    name = "\234\181\173\236\167\128\236\160\132\236\157\180\235\158\128?"
    desc = "\234\181\173\236\167\128\236\160\132\236\151\144 \235\140\128\237\149\156 \236\132\164\235\170\133\236\157\180 \235\147\164\236\150\180\234\176\145\235\139\136\235\139\164.\n\234\181\173\236\167\128\236\160\132 \236\132\164\235\170\133! \234\181\173\236\167\128\236\160\132 \236\132\164\235\170\133! \234\181\173\236\167\128\236\160\132 \236\132\164\235\170\133!"
    uiControl = buttonQuestion
  else
    isShow = false
  end
  if isShow then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function NewLocalWar_Show()
  if not Panel_LocalWarTeam:GetShow() then
    Panel_LocalWarTeam:SetShow(true)
  end
  if true == _ContentsGroup_LocalWarOccupation and true == ToClient_IsOccupationModeInRedBattleField() then
    isOccupationMode = true
    occuMainBg:SetShow(true)
    occuMainBg:ComputePos()
    _oldLocalWarFor_AllUI:SetShow(false)
    LocalWar_KillCount_Init()
  else
    if nil == _oldLocalWarFor_AllUI then
      return
    end
    _oldLocalWarFor_AllUI:SetShow(true)
  end
  if __eInstanceRedBattleField_PapuCrio == ToClient_getJoinRedBattleFieldMapKey() then
    _txt_TeamBlackTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_5"))
    _txt_TeamRedTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_4"))
  end
end
function NewLocalWar_Hide()
  if Panel_LocalWarTeam:GetShow() then
    Panel_LocalWarTeam:SetShow(false)
  end
end
function FGlobal_NewLocalWar_Show()
  if 0 == ToClient_GetMyTeamNoRedBattleField() then
    NewLocalWar_Hide()
    return
  end
  saveBlackScore = 0
  saveRedScore = 0
  NewLocalWar_Show()
end
function NewLocalWar_Update()
  local teamBlackPoint = ToClient_GetRedBattleFieldTeamPoint(0)
  local teamRedPoint = ToClient_GetRedBattleFieldTeamPoint(1)
  local isTeam = ToClient_GetMyTeamNoRedBattleField()
  local txt_BlackTeamScore = _txt_LocalWarBlack
  local txt_RedTeamScore = _txt_LocalWarRed
  if true == isOccupationMode then
    txt_BlackTeamScore = occuScoreBlackScore
    txt_RedTeamScore = occuScoreRedScore
  end
  if true == isOccupationMode then
    if teamBlackPoint > saveBlackScore then
      txt_BlackTeamScore:EraseAllEffect()
      txt_BlackTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 70, -1.5)
      saveBlackScore = teamBlackPoint
    end
    if teamRedPoint > saveRedScore then
      txt_RedTeamScore:EraseAllEffect()
      txt_RedTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 70, -1.5)
      saveRedScore = teamRedPoint
    end
  else
    txt_BlackTeamScore:EraseAllEffect()
    txt_RedTeamScore:EraseAllEffect()
    if teamBlackPoint > saveBlackScore then
      if teamBlackPoint > 99 and teamBlackPoint < 1000 then
        txt_BlackTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 5, -1.5)
      elseif teamBlackPoint > 9 and teamBlackPoint < 100 then
        txt_BlackTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, -1, -1.5)
      elseif teamBlackPoint < 10 then
        txt_BlackTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, -5, -1.5)
      else
        txt_BlackTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 0, 0)
      end
      saveBlackScore = teamBlackPoint
    end
    if teamRedPoint > saveRedScore then
      if teamRedPoint > 99 and teamRedPoint < 1000 then
        txt_RedTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, -4, -1.5)
      elseif teamRedPoint > 9 and teamRedPoint < 100 then
        txt_RedTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 1, -1.5)
      elseif teamRedPoint < 10 then
        txt_RedTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 5, -1.5)
      else
        txt_RedTeamScore:AddEffect("UI_GuildWar_ArrowMark_Big01", false, 0, 0)
      end
      saveRedScore = teamRedPoint
    end
  end
  txt_BlackTeamScore:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_BLACKDESERTTEAM", "teamBlackPoint", teamBlackPoint))
  txt_RedTeamScore:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_REDDESERTTEAM", "teamRedPoint", teamRedPoint))
  if true == isOccupationMode then
    if occupationWinningPoint <= 0 then
      occupationWinningPoint = ToClient_getOccupationWinningPoint()
    end
    if teamBlackPoint > 0 then
      occuScoreBlackProg:SetProgressRate(teamBlackPoint * 100 / occupationWinningPoint)
    else
      occuScoreBlackProg:SetProgressRate(0)
    end
    if teamRedPoint > 0 then
      occuScoreRedProg:SetProgressRate(teamRedPoint * 100 / occupationWinningPoint)
    else
      occuScoreRedProg:SetProgressRate(0)
    end
  end
end
local _winningTeam = 2
function LocalwarReloadUI()
  local teamBlackPoint = ToClient_GetRedBattleFieldTeamPoint(0)
  local teamRedPoint = ToClient_GetRedBattleFieldTeamPoint(1)
  if teamBlackPoint < teamRedPoint then
    _winningTeam = 0
  elseif teamBlackPoint > teamRedPoint then
    _winningTeam = 1
  else
    _winningTeam = 2
  end
  local timeControl = _txt_LocalWarTime
  if true == isOccupationMode then
    timeControl = occuLeftTimeText
  end
  if 0 == ToClient_GetRedBattleFieldState() then
    if true == _ContentsGroup_InstanceLocalWar then
      timeControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_READY"))
    end
  elseif 1 == ToClient_GetRedBattleFieldState() then
    timeControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
  elseif 2 == ToClient_GetRedBattleFieldState() then
    timeControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWARINFO_FINISH"))
    if 0 == ToClient_GetMyTeamNoRedBattleField() then
      NewLocalWar_Hide()
    end
  end
  if timeControl:GetSizeX() < timeControl:GetTextSizeX() then
    local text = timeControl:GetText()
    local startFind, endFind = string.find(text, " ")
    local retText = text
    if nil ~= startFind then
      local strLen = string.len(text)
      retText = string.sub(text, 1, startFind) .. "\n" .. string.sub(text, endFind + 1, strLen)
    end
    timeControl:SetText(retText)
  end
  if 0 == ToClient_GetMyTeamNoRedBattleField() then
    NewLocalWar_Hide()
  end
end
LocalwarReloadUI()
function NewLocalWar_TurnAround()
  local teamBlackPoint = ToClient_GetRedBattleFieldTeamPoint(0)
  local teamRedPoint = ToClient_GetRedBattleFieldTeamPoint(1)
  local myTeamIndex = ToClient_GetMyTeamNoRedBattleField() - 1
  local prevWinningTeam = _winningTeam
  if teamBlackPoint < teamRedPoint then
    _winningTeam = 0
  elseif teamBlackPoint > teamRedPoint then
    _winningTeam = 1
  else
    return
  end
  if prevWinningTeam == _winningTeam or 2 == prevWinningTeam then
    return
  end
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local teamName0 = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_1")
  local teamName1 = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_2")
  if instanceMapKey == __eInstanceRedBattleField_PapuCrio then
    teamName0 = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_5")
    teamName1 = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_BELONG_4")
  end
  if 0 == _winningTeam then
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_RedBattleFieldTurnAround, teamName1)
    teamCheck = true
  elseif 1 == _winningTeam then
    ToClient_RequestNakMessageRenewelWithString(__eNakMessage_RedBattleFieldTurnAround, teamName0)
    teamCheck = false
  end
end
local saveLocalWarTime = 0
local delayTime = 1
local localwarDeltaTime = 0
local timeControlForPerFrame = _txt_LocalWarTime
function NewLocalWar_TimeUpdate(deltaTime)
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if instanceMapKey == __eInstanceRedBattleField_PapuCrio and nil ~= Panel_LocalWarIntro_PapuCrio then
    local selfPlayer = getSelfPlayer()
    if nil ~= selfPlayer then
      local localwarState = ToClient_GetRedBattleFieldState()
      if 0 == localwarState or 1 == localwarState then
        local selfProxyGet = getSelfPlayer():get()
        if nil ~= selfProxyGet then
          local actorKeyRaw = selfProxyGet:getRideVehicleActorKeyRaw()
          if 0 == actorKeyRaw then
            if nil ~= Panel_LocalWarIntro_PapuCrio and false == Panel_LocalWarIntro_PapuCrio:GetShow() then
              Panel_LocalWarIntro_PapuCrio:SetShow(true)
            end
          elseif nil ~= Panel_LocalWarIntro_PapuCrio and true == Panel_LocalWarIntro_PapuCrio:GetShow() then
            Panel_LocalWarIntro_PapuCrio:SetShow(false)
          end
        end
      end
    end
  end
  if 0 == ToClient_GetRedBattleFieldState() then
    return
  end
  localwarDeltaTime = localwarDeltaTime + deltaTime
  if delayTime <= localwarDeltaTime then
    local warTime = ToClient_GetRedBattleFieldRemainedTime()
    if saveLocalWarTime > 0 and 0 == warTime then
      if true == isOccupationMode then
        occuLeftTimeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
      else
        _txt_LocalWarTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
      end
    end
    saveLocalWarTime = warTime
    if 0 == warTime then
      if 1 == ToClient_GetRedBattleFieldState() then
        if true == isOccupationMode then
          occuLeftTimeText:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
        else
          _txt_LocalWarTime:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_SOONFINISH"))
        end
      end
      return
    end
    local warTimeMinute = math.floor(warTime / 60)
    local warTimeSecond = warTime % 60
    if warTimeMinute < 10 then
      warTimeMinute = "0" .. warTimeMinute
    end
    if warTimeSecond < 10 then
      warTimeSecond = "0" .. warTimeSecond
    end
    localwarDeltaTime = 0
    if true == isOccupationMode then
      occuLeftTimeText:SetText(tostring(warTimeMinute) .. " : " .. tostring(warTimeSecond))
    else
      _txt_LocalWarTime:SetText(tostring(warTimeMinute) .. " : " .. tostring(warTimeSecond))
    end
  end
end
function FromClient_KillRedBattleField(killPlayer, deadPlayer, killPlayerTeam, getScore, isOccupationMode)
  if nil == killPlayer or nil == deadPlayer then
    return
  end
  local isOccupation = isOccupationMode
  if nil == isOccupationMode then
    isOccupation = false
  end
  local teamBlackPoint = ToClient_GetRedBattleFieldTeamPoint(0)
  local teamRedPoint = ToClient_GetRedBattleFieldTeamPoint(1)
  blackTeam = teamBlackPoint
  redTeam = teamRedPoint
  local isTeam = ToClient_GetMyTeamNoRedBattleField()
  local mainMessage, mainStr, subStr
  if isTeam == killPlayerTeam then
    if getScore >= 100 then
      mainStr = "[" .. killPlayer .. "]"
      subStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_GETSCROE_ALOT", "getScore", getScore)
      ToClient_RequestNakMessageRenewelWithString(__eNakMessage_RedBattleFieldCriticalRed, mainStr, subStr)
    end
    if true == isOccupation then
      mainMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWAR_VALENCIA_KILLMESSAGE", "killPlayer", killPlayer, "deadPlayer", deadPlayer) .. "<PAOldColor>"
    else
      mainMessage = "<PAColor0xFF2C7BFF>" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_LOCALWAR_KILLPLAYER", "killPlayer", killPlayer, "deadPlayer", deadPlayer, "score", getScore) .. "<PAOldColor>"
    end
    PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.localWar, killPlayer, deadPlayer, nil)
  else
    if getScore >= 100 then
      mainStr = "[" .. killPlayer .. "]"
      subStr = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOCALWAR_GETSCROE_ALOT", "getScore", getScore)
      ToClient_RequestNakMessageRenewelWithString(__eNakMessage_RedBattleFieldCriticalBlack, mainStr, subStr)
    end
    if true == isOccupation then
      mainMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam2(Defines.StringSheet_GAME, "LUA_LOCALWAR_VALENCIA_KILLMESSAGE", "killPlayer", killPlayer, "deadPlayer", deadPlayer) .. "<PAOldColor>"
    else
      mainMessage = "<PAColor0xFFC02A2A>" .. PAGetStringParam3(Defines.StringSheet_GAME, "LUA_LOCALWAR_KILLPLAYER", "killPlayer", killPlayer, "deadPlayer", deadPlayer, "score", getScore) .. "<PAOldColor>"
    end
    PaGlobal_Widget_KillLog_AddLog(PaGlobal_Widget_KillLog._eLogType.localWar, killPlayer, deadPlayer, nil)
  end
  local msg = {
    main = mainMessage,
    sub = "",
    addMsg = ""
  }
  if nil ~= msg.main then
    chatting_sendMessage("", msg.main, CppEnums.ChatType.Battle)
  end
  NewLocalWar_Update()
  NewLocalWar_TurnAround()
end
function FromClient_MultiKillLocalWar(killerName, deadPlayerName, killCount, posX, posY, posZ)
  if killCount >= 5 then
    local killPlayerPos3D = float3(posX, posY, posZ)
    LocalWar_MultiKillPlayerIcon_WorldMap(killerName, killCount, killPlayerPos3D)
  end
end
function FromClient_UpdateRedBattleFieldState(state)
  if nil == state or "" == state then
    return
  end
  if not isLocalwarOpen then
    return
  end
  local instanceMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  if FromClient_ServantSummonBoss_EventSelfPlayerRideOn ~= nil and instanceMapKey == __eInstanceRedBattleField_PapuCrio then
    FromClient_ServantSummonBoss_EventSelfPlayerRideOn()
  end
  local timeControl = _txt_LocalWarTime
  if true == isOccupationMode then
    timeControl = occuLeftTimeText
  end
  local msg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if 0 == state then
    ToClient_RequestNakMessageRenewel(__eNakMessage_RedBattleFieldRecruit)
  elseif 1 == state then
    ToClient_RequestNakMessageRenewel(__eNakMessage_RedBattleFieldStart)
  elseif 2 == state then
    local teamBlackPoint = ToClient_GetRedBattleFieldTeamPoint(0)
    local teamRedPoint = ToClient_GetRedBattleFieldTeamPoint(1)
    local winnerTeamNo = 2
    if teamBlackPoint < teamRedPoint then
      winnerTeamNo = 2
    elseif teamBlackPoint > teamRedPoint then
      winnerTeamNo = 1
    end
    if winnerTeamNo == ToClient_GetMyTeamNoRedBattleField() then
      ToClient_RequestNakMessageRenewel(__eNakMessage_RedBattleFieldWin)
    else
      ToClient_RequestNakMessageRenewel(__eNakMessage_RedBattleFieldLose)
    end
    timeControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_FINISH"))
  elseif 3 == state then
    ToClient_RequestNakMessageRenewel(__eNakMessage_RedBattleFieldEnd)
  end
end
function FromClient_RedBattleFieldKickOut()
  local msg = ""
  if _ContentsGroup_RedBattleFieldMatching == true then
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_REDBATTLEFIELD_KICKOUT_MATCH"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_REDBATTLEFIELD_KICKOUT_SUB_MATCH"),
      addMsg = ""
    }
  else
    msg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_KICKOUT"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_KICKOUT_SUB"),
      addMsg = ""
    }
  end
  Proc_ShowMessage_Ack_For_RewardSelect(msg, 5, 34, false)
end
function FromClient_RedBattleFieldAdvantage(teamNo)
  local advantageMsg = {
    main = "",
    sub = "",
    addMsg = ""
  }
  if nil == teamNo then
    return
  end
  if 0 == teamNo then
    advantageMsg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ADVANTAGEMSG_PARAM0_MAIN"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ADVANTAGEMSG_PARAM0_SUB"),
      addMsg = ""
    }
  elseif 1 == teamNo then
    advantageMsg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ADVANTAGEMSG_PARAM1_MAIN"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ADVANTAGEMSG_PARAM1_SUB"),
      addMsg = ""
    }
  elseif 2 == teamNo then
    advantageMsg = {
      main = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ADVANTAGEMSG_PARAM2_MAIN"),
      sub = PAGetString(Defines.StringSheet_GAME, "LUA_LOCALWAR_ADVANTAGEMSG_PARAM2_SUB"),
      addMsg = ""
    }
  end
  Proc_ShowMessage_Ack_For_RewardSelect(advantageMsg, 5, 34, false)
end
function FromClient_UpdateMyKillCountRedBattleField()
end
function LocalWar_MultiKillPlayerIcon_WorldMap(name, count, pos)
  local showTime = 180
  ToClient_worldmapAddIcon("Static_RedIcon_LocalWar", pos, showTime)
end
function FromClient_RedBattleFieldOccupationUpdateScore(actorKeyRaw, savedScore)
  NewLocalWar_Update()
  NewLocalWar_TurnAround()
  if nil ~= actorKeyRaw and nil ~= savedScore then
    PaGlobalFunc_LocalWarOccupation_UpdateSavedScore(actorKeyRaw, savedScore)
  end
end
local sizeX = Panel_LocalWar:GetSizeX()
local sizeY = Panel_LocalWar:GetSizeY()
local iconPosX = accumulateKillCount:GetPosX()
local gapX = 60
local gapY = 30
function Panel_NewLocalWar_Repos()
  Panel_LocalWarTeam:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  _oldLocalWarFor_AllUI:SetSize(getOriginScreenSizeX(), _oldLocalWarFor_AllUI:GetSizeY())
  _oldLocalWarFor_AllUI:ComputePosAllChild()
  Panel_LocalWarTeam:ComputePos()
  if nil ~= Panel_LocalWarIntro_PapuCrio then
    Panel_LocalWarTeam:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
    Panel_LocalWarTeam:ComputePos()
  end
end
function NewLocalWar_Init()
  if 0 == ToClient_GetMyTeamNoRedBattleField() then
    NewLocalWar_Hide()
    return
  end
  if nil ~= Panel_LocalWarIntro_PapuCrio then
    Panel_LocalWarTeam:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
    Panel_LocalWarTeam:ComputePos()
  end
end
function PaGlobalFunc_LocalWarOccupation_UpdateState(index, occupationType, isBlackExist, isRedExist)
  if false == _ContentsGroup_LocalWarOccupation then
    return
  end
  if nil == Panel_LocalWar_OccupationGauge or false == PaGlobal_LocalWarOccupation_Gauge._initialize then
    return
  end
  if index < 0 or index > #occupationStateIconList then
    return
  end
  if nil == occupationStateIconList[index] then
    return
  end
  local isBlackShowing = occupationStateIconList[index].iconBlack:GetShow()
  local isRedShowing = occupationStateIconList[index].iconRed:GetShow()
  local isNoneShowing = occupationStateIconList[index].iconNone:GetShow()
  occupationStateIconList[index].iconBlack:SetShow(0 == occupationType)
  occupationStateIconList[index].iconRed:SetShow(1 == occupationType)
  occupationStateIconList[index].iconNone:SetShow(2 == occupationType)
  occupationStateIconList[index].stc_effect:SetShow(true == isBlackExist or true == isRedExist)
  occupationStateIconList[index].stc_effect:EraseAllEffect()
  if true == isBlackExist and true == isRedExist then
    occupationStateIconList[index].stc_effect:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
  elseif true == occupationStateIconList[index].iconRed:GetShow(true) and true == isBlackExist then
    occupationStateIconList[index].stc_effect:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
  elseif true == occupationStateIconList[index].iconBlack:GetShow(true) and true == isRedExist then
    occupationStateIconList[index].stc_effect:AddEffect("fUI_Panel_LocalWar_Battle_01A", true, 0, 0)
  elseif false == isBlackShowing and true == occupationStateIconList[index].iconBlack:GetShow() or true == isNoneShowing and true == occupationStateIconList[index].iconBlack:GetShow() then
    occupationStateIconList[index].stc_effect:AddEffect("fUI_Panel_LocalWar_Blue_01A", false, 0, 0)
  elseif false == isRedShowing and true == occupationStateIconList[index].iconRed:GetShow() or true == isNoneShowing and true == occupationStateIconList[index].iconRed:GetShow() then
    occupationStateIconList[index].stc_effect:AddEffect("fUI_Panel_LocalWar_Red_01A", false, 0, 0)
  else
    occupationStateIconList[index].stc_effect:EraseAllEffect()
  end
end
function PaGlobalFunc_LocalWarOccupation_UpdateSavingScore(index, savedScore)
  if false == _ContentsGroup_LocalWarOccupation then
    return
  end
  if nil == Panel_LocalWar_OccupationGauge or false == PaGlobal_LocalWarOccupation_Gauge._initialize then
    return
  end
  if index < 0 or index > #occupationStateIconList then
    return
  end
  if nil == occupationStateIconList[index] then
    return
  end
  if savedScore <= 0 then
    occupationStateIconList[index].savedScore:SetShow(false)
    return
  end
  if false == occupationStateIconList[index].savedScore:GetShow() then
    occupationStateIconList[index].savedScore:SetShow(true)
  end
  occupationStateIconList[index].savedScore:SetText(savedScore)
end
NewLocalWar_Init()
LocalWar_Icon_Tooltip_Event()
FGlobal_NewLocalWar_Show()
NewLocalWar_Update()
LocalWar_KillCount_Init()
registerEvent("onScreenResize", "Panel_NewLocalWar_Repos")
registerEvent("FromClient_UpdateMyKillCountRedBattleField", "FromClient_UpdateMyKillCountRedBattleField")
registerEvent("FromClient_KillRedBattleField", "FromClient_KillRedBattleField")
registerEvent("FromClient_UpdateRedBattleFieldState", "FromClient_UpdateRedBattleFieldState")
registerEvent("FromClient_RedBattleFieldKickOut", "FromClient_RedBattleFieldKickOut")
registerEvent("FromClient_RedBattleFieldOccupationUpdateScore", "FromClient_RedBattleFieldOccupationUpdateScore")
Panel_LocalWarTeam:RegisterUpdateFunc("NewLocalWar_TimeUpdate")
