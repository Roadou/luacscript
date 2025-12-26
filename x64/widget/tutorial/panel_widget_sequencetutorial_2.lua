function PaGlobalFunc_SequenceTutorial_Open()
  PaGlobal_SequenceTutorial:prepareOpen()
end
function PaGlobalFunc_SequenceTutorial_Close()
  PaGlobal_SequenceTutorial:prepareClose()
end
function PaGlobal_SequenceTutorial_SkillGuideShow(isShowPanel, isShowKeyGuide)
  if true == isShowPanel then
    PaGlobalFunc_SequenceTutorial_Open()
    PaGlobal_SkillGuide_Cutscene_Open()
  else
    PaGlobalFunc_SequenceTutorial_Close()
  end
  PaGlobal_SequenceTutorial._ui._stc_keyGuideBg:SetShow(isShowKeyGuide)
end
function HandleEventLUp_SequenceTutorial_Close()
  PaGlobalFunc_SequenceTutorial_Close()
end
function FromClient_SequenceTutorialGuideSet()
  PaGlobal_SequenceTutorial:setMainDesc()
end
