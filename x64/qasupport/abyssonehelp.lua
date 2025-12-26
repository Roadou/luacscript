function goa1(param1, param2, param3)
  if nil == param3 then
    ToClient_InstanceContentsJoin(17, 0, param1)
  else
    ToClient_InstanceContentsJoin(param1, param2, param3)
  end
end
function movea1(param1, param2, param3)
  if nil == param3 then
    ToClient_MoveInstanceField(17, 0, param1)
  else
    ToClient_MoveInstanceField(param1, param2, param3)
  end
end
function questQAComplete(key1, key2)
  ToClient_qaCompleteQuest(key1, key2)
  PaGlobalFunc_QuestInfo_All_Close()
end
function questQACondition(key1, key2)
  ToClient_ChatProcess("/questcondition " .. key1 .. " " .. key2)
end
function questQAAccept(key1, key2)
  ToClient_qaAcceptQuest(key1, key2)
end
function scstart(scName)
  if nil == scName then
    return
  end
  ToClient_SequenceTriggerForQA(scName)
end
