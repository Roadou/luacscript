ToClient_SetSolareBuffStatePanel(Panel_Actor_SolareBuffStateUI)
ToClient_InitializeSolarePanelPool(6)
PaGlobal_Actor_SolareBuffStateUI = {_initialize = false, _maxUICount = 6}
registerEvent("FromClient_luaLoadComplete", "FromClient_SolareBuffStateUIInit")
function FromClient_SolareBuffStateUIInit()
  PaGlobal_Actor_SolareBuffStateUI:initialize()
end
function PaGlobal_Actor_SolareBuffStateUI:initialize()
  if true == self._initialize then
    return
  end
  registerEvent("FromClient_SolareBuffStateUIUpdate", "FromClient_SolareBuffStateUI_ChangeBuff")
  self._initialize = true
end
function PaGlobal_Actor_SolareBuffStateUI:setBuffState(actorKey, panel, buffType)
  if nil == panel then
    return
  end
  local actorProxyWrapper = getActor(actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local paneltwo = actorProxyWrapper:get():getSolareBuffStateUIPanel()
  if nil == paneltwo then
    return
  end
  panel:ComputePos()
  paneltwo:ComputePos()
  local fireBuff = UI.getChildControl(panel, "Static_Icon_Att")
  local waterBuff = UI.getChildControl(panel, "Static_Icon_Armor")
  local leafBuff = UI.getChildControl(panel, "Static_Icon_Heal")
  local windBuff = UI.getChildControl(panel, "Static_Icon_Speed")
  if buffType == __eSolareBuffFire then
    fireBuff:SetShow(true)
    waterBuff:SetShow(false)
    leafBuff:SetShow(false)
    windBuff:SetShow(false)
  elseif buffType == __eSolareBuffWater then
    waterBuff:SetShow(true)
    fireBuff:SetShow(false)
    leafBuff:SetShow(false)
    windBuff:SetShow(false)
  elseif buffType == __eSolareBuffLeaf then
    leafBuff:SetShow(true)
    fireBuff:SetShow(false)
    waterBuff:SetShow(false)
    windBuff:SetShow(false)
  elseif buffType == __eSolareBuffWind then
    windBuff:SetShow(true)
    leafBuff:SetShow(false)
    waterBuff:SetShow(false)
    fireBuff:SetShow(false)
  elseif buffType == __eSolareBuffCount then
    fireBuff:SetShow(false)
    waterBuff:SetShow(false)
    leafBuff:SetShow(false)
    windBuff:SetShow(false)
  end
end
function FromClient_SolareBuffStateUI_ChangeBuff(actorKey, panel, buffType)
  PaGlobal_Actor_SolareBuffStateUI:setBuffState(actorKey, panel, buffType)
end
