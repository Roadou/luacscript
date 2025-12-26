function PaGlobalFunc_DamageLog_Detail_ListUpdate(contents, key)
  local self = PaGlobal_DamageLog_Detail
  if nil == self._logMgrWrapper then
    return
  end
  local index = Int64toInt32(key)
  local logWrapper = self._logMgrWrapper:getDamageLogWrapperByIndex(index)
  if nil == logWrapper then
    return
  end
  local attackType = self._logMgrWrapper:getAttackType()
  if attackType >= __eAttackTypeCount then
    return
  end
  local stc_info = UI.getChildControl(contents, "Static_Detail_Info")
  local stc_name = UI.getChildControl(stc_info, "StaticText_Name")
  local stc_desc0 = UI.getChildControl(stc_info, "StaticText_Desc_0")
  local stc_desc1 = UI.getChildControl(stc_info, "StaticText_Desc_1")
  local stc_desc2 = UI.getChildControl(stc_info, "StaticText_Desc_2")
  local logType = logWrapper:getType()
  local txt_var = ""
  if __eDamageLogType_Percent == logType then
    txt_var = tostring(logWrapper:getVar() / toInt64(0, CppDefine.e1Percent)) .. "%"
  elseif __eDamageLogType_CriticalRate == logType then
    txt_var = tostring(logWrapper:getVar() / toInt64(0, CppDefine.e1Percent)) .. "%"
  elseif __eDamageLogType_ActorType == logType then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    txt_var = self._actorTypeString[tmpVar]
  elseif __eDamageLogType_AttackResult == logType then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    txt_var = self._attackResultString[tmpVar]
  elseif __eDamageLogType_AdditionalDamageType == logType then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    txt_var = self._attackAdditionalDamageTypeString[tmpVar]
  elseif __eDamageLogType_ClassType == logType then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    local className = getCharacterClassName(tmpVar)
    if nil ~= className then
      txt_var = string.format("%s(%d)", className, tmpVar)
    end
  elseif __eDamageLogType_CharacterKey == logType then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    local characterSSW = ToClient_GetCharacterStaticStatusWrapper(tmpVar)
    if nil ~= characterSSW then
      txt_var = string.format("%s(%d)", characterSSW:getName(), tmpVar)
    end
  elseif __eDamageLogType_DamageAddRate == logType then
    txt_var = tostring(logWrapper:getVar()) .. "%"
  else
    txt_var = tostring(logWrapper:getVar())
  end
  if __eDamageLogType_Desc == logType then
    stc_name:SetText(logWrapper:getTypeString())
  else
    stc_name:SetText(logWrapper:getTypeString() .. " : " .. txt_var)
  end
  stc_desc0:SetText(logWrapper:getSimpleDescString())
  stc_desc1:SetText(logWrapper:getDetailDescString())
  stc_desc2:SetText(logWrapper:getColumNameString())
end
