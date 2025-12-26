function PaGloabl_SetupRepair_All_Open(isCamping)
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  PaGlobal_SetupRepair_All._isCamping = isCamping
  PaGlobal_SetupRepair_All:prepareOpen()
end
function PaGloabl_SetupRepair_All_Close()
  if nil == Panel_Window_SetupRepair_All then
    return
  end
  PaGlobal_SetupRepair_All:prepareClose()
end
function HandleEventLUp_SetupRepair_Save()
  if nil == Panel_Window_SetupRepair_All or Panel_Window_SetupRepair_All:GetShow() == false then
    return
  end
  PaGlobal_SetupRepair_All:saveRepairTypeLuaCache()
  PaGloabl_SetupRepair_All_Close()
end
function HandleEventMOut_SetupRepair_CheckButton()
  if nil == Panel_Window_SetupRepair_All or Panel_Window_SetupRepair_All:GetShow() == false then
    return
  end
  PaGlobal_SetupRepair_All:setCheckButtons()
end
