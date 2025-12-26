function PaGlobal_GuildPresent_All_Open()
  PaGlobal_GuildPresent_All:prepareOpen()
end
function PaGlobal_GuildPresent_All_Close()
  PaGlobal_GuildPresent_All:prepareClose()
  PaGlobal_Warehouse_All_Close()
  warehouse_requestGuildWarehouseInfo(ToClient_isGuildItemShareWareHouse())
end
function PaGlobal_GuildPresent_All_Close_FromWarehouse()
  PaGlobal_GuildPresent_All:prepareClose()
end
function PaGlobal_GuildPresent_All_PushItem(warehouseSlotNo)
  PaGlobal_GuildPresent_All:pushItemSlot(warehouseSlotNo)
end
function PaGlobal_GuildPresent_All_PresentItem()
  PaGlobal_GuildPresent_All:presentItemToGuildMember()
end
function HandleEventLUp_GuildPresent_All_Confirm()
  if PaGlobal_GuildPresent_All._selectedItemKey == -1 then
    return
  end
  ClearFocusEdit()
  local memberName = PaGlobal_GuildPresent_All._ui._edit_memberNameText:GetEditText()
  if string.find(memberName, " ") ~= nil or memberName == "" then
    local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY")
    local messageBoxMemo = PAGetString(Defines.StringSheet_GAME, "LUA_AGREEMENTGUILD_FAMILYNAME")
    local messageboxData = {
      title = messageBoxTitle,
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
    return
  end
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_GUILDPRESENT_CONFIRM_SELECT", "Name", memberName)
  local messageBoxData = {
    content = messageBoxMemo,
    functionYes = PaGlobal_GuildPresent_All_PresentItem,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function PaGlobal_GuildPresent_InputName_SetFocus()
  PaGlobal_GuildPresent_All:setFocusGuildMemberEdit()
end
