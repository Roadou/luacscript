function PaGlobalFunc_MessageBox_CrystalSet_All_Open()
  local self = PaGlobal_MessageBox_CrystalSet_All
  if self == nil then
    return
  end
  self:prepareOpen()
end
function PaGlobalFunc_MessageBox_CrystalSet_All_Close()
  local self = PaGlobal_MessageBox_CrystalSet_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function HandleEventLUp_MessageBox_CrystalSet_All_Close()
  PaGlobalFunc_MessageBox_CrystalSet_All_Close()
end
function FromClient_MessageBox_CrystalSet_All_OnScreenResize()
  local self = PaGlobal_MessageBox_CrystalSet_All
  if self == nil then
    return
  end
  self:resize()
end
function PaGlobal_MessageBox_CrystalSet_All_IsOpen()
  if Panel_Window_MessageBox_CrystalSet_All == nil then
    return false
  end
  return Panel_Window_MessageBox_CrystalSet_All:GetShow()
end
function PaGlobalFunc_MessageBox_CrystalSet_All_ClickYes()
  local self = PaGlobal_MessageBox_CrystalSet_All
  if self == nil then
    return
  end
  self:prepareClose()
  PaGlobalFunc_JewelPreset_SaveJewel()
end
