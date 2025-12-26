local IM = CppEnums.EProcessorInputMode
isClearedQuest = false
local isFirstSummonBoss = false
function executeLuaFunc(funcText)
  if nil == getSelfPlayer() then
    return
  end
  if isIntroMoviePlaying then
    return
  end
  local charLevel = getSelfPlayer():get():getLevel()
  if funcText == "move_tutorial1" or funcText == "move_tutorial2" then
  elseif funcText == "closeDialog" then
    close_WindowPanelList()
  elseif funcText == "PVP_Notice" then
    close_WindowPanelList()
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_NOWYOUCANKILLANYONE")
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_WARNING"),
      content = messageBoxMemo,
      functionYes = pvpMode_changedMode,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  elseif funcText == "manufacture" then
    Panel_WebHelper_ShowToggle("PanelManufacture")
  elseif funcText == "gathering" then
    Panel_WebHelper_ShowToggle("Gathering")
  elseif funcText == "trade" then
    Panel_WebHelper_ShowToggle("PanelTradeMarketGraph")
  elseif funcText == "node" then
    Panel_WebHelper_ShowToggle("NodeMenu")
  elseif funcText == "housing" then
    Panel_WebHelper_ShowToggle("PanelHouseControl")
  elseif funcText == "tent" then
    Panel_WebHelper_ShowToggle("PanelWindowTent")
  elseif funcText == "alchemy" then
    Panel_WebHelper_ShowToggle("PanelAlchemy")
  elseif funcText == "cook" then
    Panel_WebHelper_ShowToggle("PanelCook")
  elseif funcText == "pet" then
    Panel_WebHelper_ShowToggle("Pet")
  elseif funcText == "servant" then
    Panel_WebHelper_ShowToggle("PanelServantinfo")
  elseif funcText == "stable" then
    Panel_WebHelper_ShowToggle("PanelWindowStableShop")
  elseif funcText == "selectQuest" then
    PaGlobalFunc_DialogMain_All_Close()
  elseif funcText == "findTargetMovieGuide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_FindTarget()
  elseif funcText == "learnSkillMovieGuide" then
    if ToClient_isConsole() == false then
      FGlobal_Panel_LowLevelGuide_MovePlay_LearnSkill()
      PaGlobalFunc_DialogMain_All_FirstLearnSkill()
      Panel_SkillCommand:SetShow(false)
    end
  elseif funcText == "acceptQuestMovieGuide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_AcceptQuest()
    Panel_SkillCommand:SetShow(false)
  elseif funcText == "callblackspiritmovieguide" then
    FGlobal_Panel_LowLevelGuide_MovePlay_BlackSpirit()
    Panel_SkillCommand:SetShow(false)
  elseif funcText == "summonBoss1" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      PaGlobal_SummonBossTutorial_Manager:startTutorial(0)
    end
  elseif funcText == "summonBoss2" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      PaGlobal_SummonBossTutorial_Manager:startTutorial(1)
    end
  elseif funcText == "summonBoss3" or funcText == "summonBoss4" or funcText == "summonBoss5" or funcText == "summonBoss6" or funcText == "summonBoss7" or funcText == "summonBoss8" or funcText == "summonBoss9" or funcText == "summonBoss10" or funcText == "summonBoss11" or funcText == "summonBoss12" or funcText == "summonBoss13" or funcText == "summonBoss14" or funcText == "summonBoss15" or funcText == "summonBoss16" or funcText == "summonBoss17" or funcText == "summonBoss18" or funcText == "summonBoss19" or funcText == "summonBoss20" or funcText == "summonBoss21" or funcText == "summonBoss22" or funcText == "summonBoss23" or funcText == "summonBoss24" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      PaGlobal_SummonBossTutorial_Manager:startTutorial(2)
    end
  elseif funcText == "summonBoss29" or funcText == "summonBoss30" or funcText == "summonBoss31" or funcText == "summonBoss32" or funcText == "summonBoss33" or funcText == "summonBoss34" or funcText == "summonBoss35" or funcText == "summonBoss36" or funcText == "summonBoss37" or funcText == "summonBoss38" or funcText == "summonBoss39" or funcText == "summonBoss40" or funcText == "summonBoss41" or funcText == "summonBoss42" or funcText == "summonBoss43" or funcText == "summonBoss44" or funcText == "summonBoss45" or funcText == "summonBoss46" or funcText == "summonBoss47" or funcText == "summonBoss48" or funcText == "summonBoss49" or funcText == "summonBoss50" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      PaGlobal_SummonBossTutorial_Manager:startTutorial(funcText)
    end
  elseif funcText == "arousal_attack_tutorial" then
    PaGlobal_ArousalTutorial_Manager:startTutorial()
  elseif funcText == "huntingTutorial1" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      FGlobal_HuntingTutorial(1)
    end
  elseif funcText == "huntingTutorial2" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      FGlobal_HuntingTutorial(2)
    end
  elseif funcText == "huntingTutorial3" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      FGlobal_HuntingTutorial(3)
    end
  elseif funcText == "huntingTutorialEnd" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      FGlobal_HuntingTutorialEnd()
    end
  elseif funcText == "valuePackage" then
    if false == _ContentsGroup_RenewUI_Tutorial then
      PaGlobal_ValuePackageTutorial_Manager:startTutorial()
    end
  elseif funcText == "AwakenGuide" then
    if _ContentsGroup_ShowOtherClassSkill == true then
      PaGlobalFunc_SkillGroup_All_OpenByAwakenGuide()
    elseif PaGlobalFunc_SkillGroup_OpenByAwakenGuide ~= nil then
      PaGlobalFunc_SkillGroup_OpenByAwakenGuide()
    end
  elseif funcText == "AbyssOneJoin" then
    if Panel_AbyssOne_Help ~= nil then
      PaGlobal_AbyssOneJoinGuide_SetOnShowFlag()
    end
  else
    local paramList = string.split(funcText, "/")
    local funcName = paramList[1]
    if funcName == nil then
      return
    end
    if funcName == "ContentsTutorial" and PaGlobalFunc_ContentsTutorial_All_Open ~= nil then
      if paramList[2] == nil or paramList[3] == nil then
        return
      end
      local fileName = paramList[2]
      local tutorialKey = Int64toInt32(tonumber64(paramList[3]))
      PaGlobalFunc_ContentsTutorial_All_Open(fileName, tutorialKey)
    end
  end
end
registerEvent("executeLuaFunc", "executeLuaFunc")
