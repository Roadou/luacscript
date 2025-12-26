function PaGlobalFunc_MiniGame_YachtDice_Result_Close()
  if nil == Panel_Widget_MiniGame_YachtDice_Result then
    return
  end
  PaGlobal_MiniGame_YachtDice_Result:prepareClose()
  PaGlobal_MiniGame_YachtDice:prepareClose()
end
function FromClient_responseYachtDiceGameStop(hostPoint, acceptorPoint, recordType, isGameOver, isMeCauseOver, isPvPMode)
  if false == isGameOver then
    if false == isMeCauseOver then
      PaGlobal_MiniGame_YachtDice_Result:prepareOpen(hostPoint, acceptorPoint, recordType, isPvPMode)
    else
      PaGlobal_MiniGame_YachtDice:prepareClose()
    end
  else
    PaGlobal_MiniGame_YachtDice_Result:prepareOpen(hostPoint, acceptorPoint, recordType, isPvPMode)
  end
end
function FromClient_MiniGameYachtDice_Result_Resize()
  if nil == Panel_Widget_MiniGame_YachtDice_Result then
    return
  end
  PaGlobal_MiniGame_YachtDice_Result:resizePanel()
end
