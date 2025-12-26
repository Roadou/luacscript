function PaGlobal_BossInstance_Esc()
  local exit_Instance = function()
    ToClient_UnJoinInstanceFieldForAll()
  end
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
    content = PAGetString(Defines.StringSheet_GAME, "LUA_CREWMATCH_EXIT"),
    functionYes = exit_Instance,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
