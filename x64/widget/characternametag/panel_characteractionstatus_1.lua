ToClient_SetActionStatusPanel(Panel_CharacterActionStatus)
ToClient_InitializeActionStatusPanelPool(500)
function PaGlobal_CharacterActionStatus:initialize()
  if self._initialize == true then
    return
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_CharacterActionStatus:registEventHandler()
  if Panel_CharacterActionStatus == nil then
    return
  end
  registerEvent("FromClient_NotifyPlayerGuardType", "FromClient_NotifyPlayerGuardType")
  registerEvent("FromClient_NotifyPlayerAvoid", "FromClient_NotifyPlayerAvoid")
end
function PaGlobal_CharacterActionStatus:prepareOpen()
  if Panel_CharacterActionStatus == nil then
    return
  end
  self:open()
end
function PaGlobal_CharacterActionStatus:open()
  if Panel_CharacterActionStatus == nil then
    return
  end
  Panel_CharacterActionStatus:SetShow(true)
end
function PaGlobal_CharacterActionStatus:prepareClose()
  if Panel_CharacterActionStatus == nil then
    return
  end
  self:close()
end
function PaGlobal_CharacterActionStatus:close()
  if Panel_CharacterActionStatus == nil then
    return
  end
  Panel_CharacterActionStatus:SetShow(false)
end
function PaGlobal_CharacterActionStatus:update(actorKey, guardType)
  if Panel_CharacterActionStatus == nil then
    return
  end
  local actorProxyWrapper = getActor(actorKey)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getActionStatusUIPanel()
  if panel == nil then
    return
  end
  local superArmor = UI.getChildControl(panel, "Static_Icon_SuperArmor")
  local defence = UI.getChildControl(panel, "Static_Icon_Defence")
  local avoid = UI.getChildControl(panel, "Static_Icon_Avoid")
  local superDefence_armor = UI.getChildControl(panel, "Static_Icon_SuperDefence_Armor")
  local superDefence_defence = UI.getChildControl(panel, "Static_Icon_SuperDefence_Defence")
  if guardType == __eGuardType_None then
    panel:SetShow(false)
    superArmor:SetShow(false)
    defence:SetShow(false)
    avoid:SetShow(false)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  panel:SetShow(true)
  if guardType == __eGuardType_SuperArmor then
    defence:SetShow(false)
    superArmor:SetShow(true)
    superArmor:EraseAllEffect()
    superArmor:AddEffect("fUI_Judgment_SuperArmor_01A", true, 0, 0)
    avoid:SetShow(false)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  if guardType == __eGuardType_Defence then
    defence:SetShow(true)
    defence:EraseAllEffect()
    defence:AddEffect("fUI_Judgment_Defence_01A", true, 0, 0)
    superArmor:SetShow(false)
    avoid:SetShow(false)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  if guardType == __eGuardType_Avoid then
    defence:SetShow(false)
    superArmor:SetShow(false)
    avoid:SetShow(true)
    avoid:EraseAllEffect()
    avoid:AddEffect("fUI_Judgment_Avoid_01A", true, 0, 0)
    superDefence_armor:SetShow(false)
    superDefence_defence:SetShow(false)
    return
  end
  if guardType == __eGuardType_SuperDefence then
    defence:SetShow(false)
    superArmor:SetShow(false)
    avoid:SetShow(false)
    superDefence_armor:SetShow(true)
    superDefence_defence:SetShow(true)
    superDefence_armor:EraseAllEffect()
    superDefence_defence:EraseAllEffect()
    superDefence_armor:AddEffect("fUI_Judgment_SuperArmor_01A", true, 0, 0)
    superDefence_defence:AddEffect("fUI_Judgment_Defence_01A", true, 0, 0)
    return
  end
end
function PaGlobal_CharacterActionStatus:updateAvoid(actorKey, guardType)
  if Panel_CharacterActionStatus == nil then
    return
  end
  local actorProxyWrapper = getActor(actorKey)
  if actorProxyWrapper == nil then
    return
  end
  local panel = actorProxyWrapper:get():getActionStatusUIPanel()
  if panel == nil then
    return
  end
  local superArmor = UI.getChildControl(panel, "Static_Icon_SuperArmor")
  local defence = UI.getChildControl(panel, "Static_Icon_Defence")
  local avoid = UI.getChildControl(panel, "Static_Icon_Avoid")
  local superDefence_armor = UI.getChildControl(panel, "Static_Icon_SuperDefence_Armor")
  local superDefence_defence = UI.getChildControl(panel, "Static_Icon_SuperDefence_Defence")
  if guardType == __eGuardType_None then
    avoid:SetShow(false)
    avoid:SetSpanSize(95, 0)
    return
  end
  panel:SetShow(true)
  if guardType == __eGuardType_Avoid then
    avoid:SetShow(true)
    if superArmor:GetShow() == true or defence:GetShow() == true or superDefence_armor:GetShow() == true or superDefence_defence:GetShow() == true then
      avoid:SetSpanSize(170, 0)
    else
      avoid:SetSpanSize(95, 0)
    end
    avoid:EraseAllEffect()
    avoid:AddEffect("fUI_Judgment_Avoid_01A", true, 0, 0)
    return
  end
end
