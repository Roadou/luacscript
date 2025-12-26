function PaGlobal_BarterInfoSearch_Refresh_Close()
  PaGlobal_BarterInfoRefresh:close()
end
function PaGlobal_BarterInfoSearch_RequestChangeBarterList()
  ToClient_requrstChangeBarterList(PaGlobal_BarterInfoRefresh._selectIndex)
  PaGlobal_BarterInfoRefresh:close()
end
function PaGlobal_BarterInfoSearch_RequestCoolDownBarterListConfirm(count)
  PaGlobal_BarterInfoRefresh._refreshCount = Int64toInt32(count)
  local needCountOnce = ToClient_getBarterConvertNeedExchangeCountForTimeMax()
  local needCountForOneMinute = ToClient_getBarterConvertNeedExchangeCount()
  local variedMinuteForOnce = needCountOnce / needCountForOneMinute
  local messageBoxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_BARTERREFRESH_CONFIRM", "remainCount", PaGlobal_BarterInfoRefresh._refreshCount * needCountOnce, "time", PaGlobal_BarterInfoRefresh._refreshCount * variedMinuteForOnce)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_ALERT_NOTIFICATIONS"),
    content = messageBoxMemo,
    functionYes = PaGlobal_BarterInfoSearch_RequestCoolDownBarterList,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_BarterInfoSearch_RequestCoolDownBarterList()
  if PaGlobal_BarterInfoRefresh._refreshCount == nil then
    return
  end
  for i = 1, PaGlobal_BarterInfoRefresh._refreshCount do
    ToClient_requrstChangeBarterList(PaGlobal_BarterInfoRefresh._selectIndex)
  end
  PaGlobal_BarterInfoRefresh:close()
end
