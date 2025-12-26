function PaGlobalFunc_QuestTypeSet_All_Open()
  PaGlobal_QuestTypeSet_All:prepareOpen()
end
function PaGlobalFunc_QuestTypeSet_All_Close()
  PaGlobal_QuestTypeSet_All:prepareClose()
end
function HandlePadEventOn_QuestTypeSet_All_ShowDescription(selectType)
  if PaGlobal_QuestTypeSet_All._questTypeGroup[selectType] == nil then
    return
  end
  PaGlobal_QuestTypeSet_All._ui.txt_selectedTypeName:SetText(PaGlobal_QuestTypeSet_All._questTypeStr[selectType].title)
  PaGlobal_QuestTypeSet_All._ui.stc_selectedTypeDesc:SetText(PaGlobal_QuestTypeSet_All._questTypeStr[selectType].titleDesc)
end
function HandleEventLUp_QuestTypeSet_All_CheckButton(buttonIdx)
  if __eQuestSelectType_Count == buttonIdx then
    PaGlobal_QuestTypeSet_All:checkButtonAll()
  else
    ToClient_ToggleQuestSelectType(buttonIdx)
  end
  PaGlobal_QuestTypeSet_All:favorTypeUpdate()
end
function FromClient_Quest_All_LevelFifty_SetFavorType()
  if nil == getSelfPlayer() then
    return
  end
  if 50 ~= getSelfPlayer():get():getLevel() then
    return
  end
  if false == PaGlobal_QuestTypeSet_All._isConsole then
    return
  end
  if true == PaGlobal_QuestTypeSet_All._questTypeGroup[__eQuestSelectType_Etc].check:IsCheck() then
    return
  end
  PaGlobal_QuestTypeSet_All._questTypeGroup[__eQuestSelectType_Etc].icon:SetCheck(true)
  PaGlobal_QuestTypeSet_All._questTypeGroup[__eQuestSelectType_Etc].check:SetCheck(true)
end
