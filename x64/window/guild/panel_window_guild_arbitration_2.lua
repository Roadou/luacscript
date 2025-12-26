function PaGlobalFunc_Guild_Arbitration_Open(enemyGuildWarInfoIndex)
  if PaGlobal_Guild_Arbitration == nil then
    return
  end
  PaGlobal_Guild_Arbitration:prepareOpen(enemyGuildWarInfoIndex)
end
function PaGlobalFunc_Guild_Arbitration_Close()
  if PaGlobal_Guild_Arbitration == nil then
    return
  end
  PaGlobal_Guild_Arbitration:prepareClose()
end
function PaGlobalFunc_Guild_Arbitration_QuestListOpen(enemyGuildWarInfoIndex)
  HandleEventLUp_GuildMain_All_ClickOtherTab(PaGlobal_GuildMain_All._eTABINDEX._QUSET)
  PaGlobalFunc_Guild_Quest_All_ArbitrationOpen(enemyGuildWarInfoIndex)
  PaGlobalFunc_Guild_Arbitration_Close()
end
