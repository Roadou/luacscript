function PaGlobal_ExchangeExp_All_Open()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  PaGlobal_ExchangeExp_All:prepareOpen()
end
function PaGlobal_ExchangeExp_All_Close()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  PaGlobal_ExchangeExp_All:prepareClose()
end
function HandleEventLUp_ExchangeExp_All_ChangeConfirm()
  if -1 == PaGlobal_ExchangeExp_All._selectedCharacterIndex then
    return
  end
  local selfCharacterIndex = ToClient_GetMyCharacterIndex()
  local selfCharacterData = getCharacterDataByIndex(selfCharacterIndex, __ePlayerCreateNormal)
  local selfCharacterName = getCharacterName(selfCharacterData)
  local characterData = getCharacterDataByIndex(PaGlobal_ExchangeExp_All._selectedCharacterIndex, __ePlayerCreateNormal)
  local characterName = getCharacterName(characterData)
  local ExchangeExp = function()
    if PaGlobal_ExchangeExp_All._isOnlyInventoryAndWeight == true then
      ToClient_RequestExchangeCharacterInventoryAndWeight(PaGlobal_ExchangeExp_All._fromWhereType, PaGlobal_ExchangeExp_All._fromSlotNo, PaGlobal_ExchangeExp_All._selectedCharacterIndex)
    else
      ToClient_RequestExchangeBattleAndSkillExperienceWithInven(PaGlobal_ExchangeExp_All._fromWhereType, PaGlobal_ExchangeExp_All._fromSlotNo, PaGlobal_ExchangeExp_All._selectedCharacterIndex)
    end
  end
  local messageBoxContent = ""
  if PaGlobal_ExchangeExp_All._isOnlyInventoryAndWeight == true then
    messageBoxContent = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXPCHANGE_CONFIRM_A", "name0", selfCharacterName, "name1", characterName)
  else
    messageBoxContent = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_EXPCHANGE_CONFIRM", "name0", selfCharacterName, "name1", characterName)
  end
  local messageboxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CONFIRM"),
    content = messageBoxContent,
    functionYes = ExchangeExp,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageboxData)
end
function HandleEventLUp_ExchangeExp_All_ClickCharacterList(charIndex)
  PaGlobal_ExchangeExp_All._selectedCharacterIndex = charIndex
  PaGlobal_ExchangeExp_All:update()
end
function HandleEventScroll_ExchangeExp_All_ScrollEvent(isUp)
  PaGlobal_ExchangeExp_All._pageIndex = UIScroll.ScrollEvent(PaGlobal_ExchangeExp_All._ui.scroll_charList, isUp, 1, math.ceil(PaGlobal_ExchangeExp_All._maxCharacterCount / 6), PaGlobal_ExchangeExp_All._pageIndex, 1)
  PaGlobal_ExchangeExp_All:updateCharacterList()
end
function FromClient_ExchangeExp_All_OnScreenResize()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  Panel_Window_ExchangeExp_All:ComputePos()
end
function FromClient_ExchangeExp_All_SuccessExchange()
  Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_SEASON_CHARACTERTAG_SUCCESSCHANGE"))
  PaGlobal_ExchangeExp_All_Close()
  if nil ~= InventoryWindow_Close then
    InventoryWindow_Close()
  end
end
function FromClient_ShowExchangeExpWindow(fromWhereType, fromSlotNo)
  PaGlobal_ExchangeExp_All._fromWhereType = fromWhereType
  PaGlobal_ExchangeExp_All._fromSlotNo = fromSlotNo
  PaGlobal_ExchangeExp_All._isOnlyInventoryAndWeight = false
  PaGlobal_ExchangeExp_All_Open()
end
function FromClient_ShowExchangeInventoryAndWeightWindow(fromWhereType, fromSlotNo)
  PaGlobal_ExchangeExp_All._fromWhereType = fromWhereType
  PaGlobal_ExchangeExp_All._fromSlotNo = fromSlotNo
  PaGlobal_ExchangeExp_All._isOnlyInventoryAndWeight = true
  PaGlobal_ExchangeExp_All_Open()
end
