local luaLoadAfterTime = 0
local luaLoadAfterFrameCount = 0
local periodicTimeCheck = 0
local skillWindowCloseTimeCheck = 0
local skillWindowScrollResetTime = 30
local garbageCollectCheckTime = 180
local garbageCheckDeltaTime = 0
function PaGlobalFunc_SkillWindowCloseTimeReset()
  skillWindowCloseTimeCheck = 0
end
function PaGlobalFunc_SkillWindowScrollReset()
  return skillWindowScrollResetTime < skillWindowCloseTimeCheck
end
function FGlobal_getLuaLoadTime()
  return luaLoadAfterTime
end
function FGlobal_getFrameCount()
  return luaLoadAfterFrameCount
end
function Panel_OnlyPerframeUsedFunction(deltaTime)
  luaLoadAfterTime = luaLoadAfterTime + deltaTime
  luaLoadAfterFrameCount = luaLoadAfterFrameCount + 1
  garbageCheckDeltaTime = garbageCheckDeltaTime + deltaTime
  if garbageCheckDeltaTime >= garbageCollectCheckTime then
    garbageCheckDeltaTime = 0
    local garbageCount = collectgarbage("count")
    garbageCount = math.floor(garbageCount)
    _PA_SVC_LOG("garbageCount = " .. tostring(garbageCount))
  end
  if nil ~= PaGlobal_ReducedPerframe then
    PaGlobal_ReducedPerframe(deltaTime)
  end
  if nil ~= PaGlobal_BossAlert_NewAlarmShow then
    PaGlobal_BossAlert_NewAlarmShow(deltaTime)
  end
  if nil ~= NewQuickSlot_UpdatePerFrame then
    NewQuickSlot_UpdatePerFrame(deltaTime)
  end
  if nil ~= FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame then
    FGlobal_SkillCoolTimeQuickSlot_UpdatePerFrame(deltaTime)
  end
  if nil ~= Competition_UpdatePerFrame then
    Competition_UpdatePerFrame(deltaTime)
  end
  if false == _ContentsGroup_RenewUI and nil ~= GameTips_MessageUpdate then
    GameTips_MessageUpdate(deltaTime)
  end
  if PaGlobal_AbyssOneJoinGuide_Update ~= nil then
    PaGlobal_AbyssOneJoinGuide_Update(deltaTime)
  end
  if PaGlobalFunc_Warehouse_Clear_UpdatePerFrame ~= nil then
    PaGlobalFunc_Warehouse_Clear_UpdatePerFrame(deltaTime)
  end
  if nil ~= OnlyPerFrame_ProgressBar_Collect_Update then
    OnlyPerFrame_ProgressBar_Collect_Update(deltaTime)
  end
  if nil ~= WorldMap_ShortcutButton_RePos then
    WorldMap_ShortcutButton_RePos()
  end
  if nil ~= WorldMap_DetectUserButton_RePos then
    WorldMap_DetectUserButton_RePos()
  end
  if nil ~= ChattingViewManager_UpdatePerFrame then
    ChattingViewManager_UpdatePerFrame(deltaTime)
  end
  if Panel_WhereUseItemDirection:GetShow() then
    WhereUseItemDirectionRestore()
  end
  local reUseTime = false
  if true == _ContentsGroup_NewUI_Equipment_All then
    reUseTime = PaGlobalFunc_Equipment_All_IsReuseTime(deltaTime)
  else
    reUseTime = PaGlobalFunc_Equipment_IsReuseTime(deltaTime)
  end
  if true == reUseTime then
    local cooltime = 0
    if true == _ContentsGroup_NewUI_Equipment_All then
      cooltime = PaGlobalFunc_Equipment_All_AlchemyStonCheck()
    else
      cooltime = FGlobal_AlchemyStonCheck()
    end
    if cooltime > 0 then
      if true == ToClient_GetAlchemyStoneReuseNextTick() then
        if _ContentsGroup_AlchemyStoneRenewal == true then
          PaGlobalFunc_AlchemyStone_Renewal_All_Use()
        else
          PaGlobalFunc_AlchemyStone_All_Use()
        end
        ToClient_SetAlchemyStoneReuseNextTick(cooltime)
      end
    else
      ToClient_SetAlchemyStoneReuseNextTick(0)
    end
  end
  if nil ~= AutoFrameCheckManager_UpdatePerFrame then
    AutoFrameCheckManager_UpdatePerFrame()
  end
  if nil ~= QASupport_UpdatePerFrame then
    QASupport_UpdatePerFrame(deltaTime)
  end
  if nil ~= Update_ReconnectHorse then
    Update_ReconnectHorse()
  end
  if nil ~= Auto_FrameMove then
    Auto_FrameMove(deltaTime)
  end
  if nil ~= FGlobal_GuildBattle_UpdatePerFrame then
    FGlobal_GuildBattle_UpdatePerFrame(deltaTime)
  end
  if nil ~= UpdateFunc_FairyRegisterAni then
    UpdateFunc_FairyRegisterAni(deltaTime)
  end
  if nil ~= PaGlobalFunc_DeadMessage_All_Update then
    PaGlobalFunc_DeadMessage_All_Update(deltaTime)
  end
  if not ToClient_isCheckRenderModeGame() then
    local lanternIdx = 1
    if true == _ContentsGroup_RenewUI then
      lanternIdx = 2
    end
    PaGlobalFunc_UseTab_Show(lanternIdx, false)
    HideUseTab_Func()
  end
  periodicTimeCheck = periodicTimeCheck + deltaTime
  if periodicTimeCheck > 30 then
    periodicTimeCheck = 0
    if nil ~= FGlobal_TerritoryWar_Caution then
      FGlobal_TerritoryWar_Caution()
    end
    if nil ~= FGlobal_SummonPartyCheck then
      FGlobal_SummonPartyCheck()
    end
    if nil ~= FGlobal_ReturnStoneCheck then
      FGlobal_ReturnStoneCheck()
    end
  end
  if nil ~= Panel_Widget_GardenIcon_Renew then
    PaGlobalFunc_GardenIcon_UpdatePerFrameFunc(deltaTime)
  end
  if true == _ContentsGroup_UsePadSnapping then
    if true == _ContentsGroup_NewUI_Fishing_All then
      if nil ~= Panel_Widget_Fishing_All and true == Panel_Widget_Fishing_All:GetShow() and nil ~= PaGlobal_Fishing_All_UpdatePerFrameFunc then
        PaGlobal_Fishing_All_UpdatePerFrameFunc(deltaTime)
      end
    elseif nil ~= Panel_Fishing and true == Panel_Fishing:GetShow() and nil ~= PaGlobalFunc_FishingCheckBox_UpdatePerFrameFunc then
      PaGlobalFunc_FishingCheckBox_UpdatePerFrameFunc(deltaTime)
    end
  end
  if false == isRealServiceMode() then
    if nil ~= PaGlobalFunc_ServantTest_UpdatePerFrameFunc and true == PaGlobal_QAServantSupportOn then
      PaGlobalFunc_ServantTest_UpdatePerFrameFunc(deltaTime)
    end
    if nil ~= PaGlobalFunc_ItemMarketTest_UpdatePerFrameFunc and true == PaGlobal_QAItemMarketSupportOn then
      PaGlobalFunc_ItemMarketTest_UpdatePerFrameFunc(deltaTime)
    end
    if nil ~= PaGlobal_AutoQASupport then
      PaGlobal_AutoQASupport:updatePerFrameFunc()
    end
  end
  if _ContentsGroup_UsePadSnapping then
    FGlobal_KeyGuideTypeCheck(deltaTime)
    if nil ~= PaGlobalFunc_CameraMode_All_DistanceCheck then
      PaGlobalFunc_CameraMode_All_DistanceCheck(deltaTime)
    end
  end
  if true == _ContentsGroup_FarmingList and nil ~= Panel_Widget_FarmingTimer_All then
    PaGlobalFunc_FarmingTimer_UpdatePerFrame(deltaTime)
  end
  if true == _ContentsGroup_StackHpBaranimation and nil ~= stackHpBarAnimation then
    stackHpBarAnimation(deltaTime)
  end
  if true == _ContentsGroup_QuizEvent and nil ~= Panel_Event_Quiz then
    PaGlobal_Event_Quiz_UpdateFrameEvent(deltaTime)
  end
  if true == _ContentsGroup_QuizEvent and nil ~= Panel_Event_Quiz_Minimal and true == Panel_Event_Quiz_Minimal:GetShow() then
    PaGlobal_Event_Quiz_Minimal_UpdateFrameEvent(deltaTime)
  end
  if nil ~= PaGlobalFunc_QuestMainAlretXXX then
    PaGlobalFunc_QuestMainAlretXXX(deltaTime)
  end
  if nil ~= PaGlobal_PartyList_All_UpdateFunc and nil ~= PaGlobalFunc_PartyList_All_IsBtnDisableSet and true == PaGlobalFunc_PartyList_All_IsBtnDisableSet() then
    PaGlobal_PartyList_All_UpdateFunc(deltaTime)
  end
  if nil ~= PaGlobal_GuildPartyList_All_UpdateFunc and nil ~= PaGlobalFunc_GuildPartyList_All_IsBtnDisableSet and true == PaGlobalFunc_GuildPartyList_All_IsBtnDisableSet() then
    PaGlobal_GuildPartyList_All_UpdateFunc(deltaTime)
  end
  if nil ~= PaGlobalFunc_StaminaAutoRun_OpenCheckAutoMove then
    PaGlobalFunc_StaminaAutoRun_OpenCheckAutoMove()
  end
  if nil ~= PaGlobalFunc_NakMsgSequence_UpdateFunc then
    PaGlobalFunc_NakMsgSequence_UpdateFunc(deltaTime)
  end
  if RoseWarMiniMap_Update_Always ~= nil then
    RoseWarMiniMap_Update_Always(deltaTime)
  end
  skillWindowCloseTimeCheck = skillWindowCloseTimeCheck + deltaTime
end
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_OnlyPerframeUsed")
function FromClient_luaLoadComplete_OnlyPerframeUsed()
  if true == _ContentsGroup_UsePadSnapping then
    Panel_OnlyPerframeUsed:SetOffsetIgnorePanel(true)
  end
  Panel_OnlyPerframeUsed:SetShow(true)
  Panel_OnlyPerframeUsed:RegisterUpdateFunc("Panel_OnlyPerframeUsedFunction")
end
local ReducedPerframeFunc = {
  AppliedBuffList_Update,
  QuestWidget_ProgressingGuildQuest_UpdateRemainTime,
  PaGlobalFunc_InventoryInfo_SearchCooltime,
  TimeBar_UpdatePerFrame
}
local accumulatedTime = 0
function PaGlobal_ReducedPerframe(deltaTime)
  if false == _ContentsGroup_ReducedLua then
    return
  end
  accumulatedTime = accumulatedTime + deltaTime
  if accumulatedTime > 1 then
    for _, func in pairs(ReducedPerframeFunc) do
      if nil ~= func then
        func(accumulatedTime)
      end
    end
    accumulatedTime = 0
  end
end
