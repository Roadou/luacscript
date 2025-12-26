function PaGlobal_MorningLand_Scenario_All_Open(sIndex, index)
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  PaGlobal_MorningLand_Scenario_All:prepareOpen(sIndex, index)
end
function PaGlobal_MorningLand_Scenario_All_Close()
  if Panel_MorningLand_Scenario_All == nil then
    return
  end
  PaGlobal_MorningLand_Scenario_All:prepareClose()
end
function PaGlobal_MorningLand_Scenario_All_FindNavi(groupId, questNo, isAuto)
  ToClient_DeleteNaviGuideByGroup(0)
  if isAuto == true then
    if PaGlobal_MorningLand_Scenario_All._ui_pc.btn_AutoNavi:IsCheck() == false then
      PaGlobal_MorningLand_Scenario_All._naviGroup = nil
      PaGlobal_MorningLand_Scenario_All._ui_pc.btn_Navi:SetCheck(false)
      PaGlobal_MorningLand_Scenario_All._ui_pc.btn_AutoNavi:SetCheck(false)
      return
    end
    PaGlobal_MorningLand_Scenario_All._ui_pc.btn_Navi:SetCheck(true)
    PaGlobal_MorningLand_Scenario_All._ui_pc.btn_AutoNavi:SetCheck(true)
  else
    if PaGlobal_MorningLand_Scenario_All._ui_pc.btn_Navi:IsCheck() == false then
      PaGlobal_MorningLand_Scenario_All._naviGroup = nil
      return
    end
    PaGlobal_MorningLand_Scenario_All._ui_pc.btn_Navi:SetCheck(true)
  end
  local questInfo = questList_getQuestStatic(groupId, questNo)
  if nil == questInfo then
    return
  end
  local navigationGuideParam = NavigationGuideParam()
  navigationGuideParam._questGroupNo = groupId
  navigationGuideParam._questNo = questNo
  navigationGuideParam._isAutoErase = questInfo:isGuideAutoErase()
  if 0 == questInfo:getAccecptNpc():get() then
    HandleClicked_CallBlackSpirit()
  end
  local npcData = npcByCharacterKey_getNpcInfo(questInfo:getAccecptNpc(), questInfo:getAccecptDialogIndex())
  if nil == npcData then
    return
  end
  local posX = npcData:getPosition().x
  local posY = npcData:getPosition().y
  local posZ = npcData:getPosition().z
  local naviPathKey = worldmapNavigatorStart(float3(posX, posY, posZ), navigationGuideParam, isAuto, false, false)
  if naviPathKey == -1 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_NO_FINDWAY"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PROCMESSAGE_QUEST_ALEADY_FINDWAY"))
    audioPostEvent_SystemUi(0, 14)
  end
  PaGlobal_MorningLand_Scenario_All._naviGroup = groupId
  PaGlobal_MorningLand_Scenario_All._isAuto = isAuto
end
