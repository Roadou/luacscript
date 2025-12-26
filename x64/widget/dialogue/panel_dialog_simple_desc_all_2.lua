function PaGlobal_Dialog_SimpleDesc_All_Open()
  PaGlobal_Dialog_SimpleDesc_All:prepareOpen()
end
function PaGlobal_Dialog_SimpleDesc_All_Close()
  PaGlobal_Dialog_SimpleDesc_All:prepareClose()
end
function FromClient_Dialog_SimpleDesc_All_ShowDialog()
  PaGlobal_Dialog_SimpleDesc_All_Open()
end
function FromClient_DialogButtonClick_Contents_Talk()
  PaGlobal_Dialog_SimpleDesc_All_Open()
end
function PaGlobal_Dialog_SimpleDesc_All_OnScreenSizeRefresh()
  Panel_Dialog_SimpleDesc_All:ComputePos()
end
