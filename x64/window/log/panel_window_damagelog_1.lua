function PaGlobal_DamageLog:initialize()
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._list2_logMgrList = UI.getChildControl(self._ui._stc_mainBg, "List2_LogList")
  self._ui._txt_empty = UI.getChildControl(self._ui._stc_mainBg, "StaticText_NoHorse")
  self._ui._bottomControls = {}
  for ii = 0, __eDamageLogUiType_Count - 1 do
    local controls = {txt_title = nil, txt_desc = nil}
    controls.txt_title = UI.getChildControl(Panel_Window_DamageLog, "StaticText_total_Title_" .. tostring(ii))
    controls.txt_desc = UI.getChildControl(Panel_Window_DamageLog, "StaticText_total_Value_" .. tostring(ii))
    controls.txt_title:isValidate()
    controls.txt_desc:isValidate()
    controls.txt_title:SetText(self._typeString[ii])
    controls.txt_desc:SetText("")
    self._ui._bottomControls[ii] = controls
  end
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_DamageLog:clear()
end
function PaGlobal_DamageLog:prepareOpen()
  local showType = ToClient_getDamageLogShowType()
  if showType <= 1 then
    return
  end
  self:open()
end
function PaGlobal_DamageLog:open()
  if false == self._initialize then
    return
  end
  if false == ToClient_IsDevelopment() then
    UI.ASSERT_NAME(false, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184\235\138\148 Dev\236\151\144\236\132\156\235\167\140 \236\130\172\236\154\169 \234\176\128\235\138\165 \237\149\169\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  self:clear()
  local maxCount = ToClient_getFrameEventDamageInfoCount()
  local logLevel = ToClient_getDamageLogLevel()
  self._ui._list2_logMgrList:getElementManager():clearKey()
  for ii = 0, maxCount - 1 do
    self._ui._list2_logMgrList:getElementManager():pushKey(toInt64(0, ii))
  end
  self._ui._txt_empty:SetShow(0 == maxCount)
  self:updateBottomControls()
  Panel_Window_DamageLog:SetShow(true)
end
function PaGlobal_DamageLog:prepareClose()
  self:close()
end
function PaGlobal_DamageLog:close()
  if true == Panel_Window_DamageLog_Detail:GetShow() then
    PaGlobal_DamageLog_Detail:prepareClose()
    return
  end
  Panel_Window_DamageLog:SetShow(false)
end
function PaGlobal_DamageLog:validate()
  self._ui._stc_titleBg:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._list2_logMgrList:isValidate()
end
function PaGlobal_DamageLog:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_DamageLog:prepareClose()")
  self._ui._list2_logMgrList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DamageLog_ListUpdate")
  self._ui._list2_logMgrList:createChildContent(__ePAUIList2ElementManagerType_List)
  registerEvent("FromClient_updateDamageLogList", "FromClient_updateDamageLogList")
end
function PaGlobal_DamageLog:showLogs(index)
  PaGlobal_DamageLog_Detail:prepareOpen(index)
end
function PaGlobal_DamageLog:getBuffName(logMgrWrapper)
  if nil == logMgrWrapper then
    return ""
  end
  local logWrapper = logMgrWrapper:getDamageLogWrapperByType(__eDamageLogType_BuffName)
  if nil == logWrapper then
    return ""
  end
  return logWrapper:getSimpleDescString()
end
function PaGlobal_DamageLog:getAttackResult(logMgrWrapper)
  if nil == logMgrWrapper then
    return ""
  end
  local logWrapper = logMgrWrapper:getDamageLogWrapperByType(__eDamageLogType_AttackResult)
  if nil == logWrapper then
    return ""
  end
  return logWrapper:getDetailDescString()
end
function PaGlobal_DamageLog:getAdditionalDamageType(logMgrWrapper)
  if nil == logMgrWrapper then
    return ""
  end
  local logWrapper = logMgrWrapper:getDamageLogWrapperByType(__eDamageLogType_AdditionalDamageType)
  if nil == logWrapper then
    return ""
  end
  local var_s64 = logWrapper:getVar()
  if var_s64 == toInt64(0, 0) then
    return "Back"
  elseif var_s64 == toInt64(0, 1) then
    return "Counter"
  elseif var_s64 == toInt64(0, 2) then
    return "Down"
  elseif var_s64 == toInt64(0, 3) then
    return "Speed"
  elseif var_s64 == toInt64(0, 4) then
    return "Air"
  else
    return "\236\157\188\235\176\152"
  end
end
function PaGlobal_DamageLog:getDamage(logMgrWrapper)
  if nil == logMgrWrapper then
    return 0
  end
  local logWrapper = logMgrWrapper:getDamageLogWrapperByType(__eDamageLogType_CurDamage)
  if nil == logWrapper then
    return 0
  end
  return logWrapper:getVar()
end
function PaGlobal_DamageLog:getAttackeeInfo(logMgrWrapper)
  if nil == logMgrWrapper then
    return ""
  end
  local logWrapper = logMgrWrapper:getDamageLogWrapperByType(__eDamageLogType_ClassType)
  if nil ~= logWrapper then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    local className = getCharacterClassName(tmpVar)
    if nil ~= className then
      txt_var = string.format("\237\148\188\234\178\169\236\158\144: %s(%d)", className, tmpVar)
      return txt_var
    end
  end
  logWrapper = logMgrWrapper:getDamageLogWrapperByType(__eDamageLogType_CharacterKey)
  if nil ~= logWrapper then
    local tmpVar = Int64toInt32(logWrapper:getVar())
    local characterSSW = ToClient_GetCharacterStaticStatusWrapper(tmpVar)
    if nil ~= characterSSW then
      txt_var = string.format("\237\148\188\234\178\169\236\158\144: %s(%d)", characterSSW:getName(), tmpVar)
      return txt_var
    end
  end
  return ""
end
function PaGlobal_DamageLog:updateBottomControls()
  local avgDamage = ToClient_getDamageLogAvgDamage()
  local totalHitCount = ToClient_getDamageLogTotalHitCount()
  local txt_desc = "\235\141\176\235\175\184\236\167\128 \237\143\137\234\183\160 = " .. tostring(avgDamage) .. ", " .. tostring(totalHitCount) .. " \235\178\136 \236\139\164\237\150\137"
  self._ui._bottomControls[__eDamageLogUiType_Damage].txt_desc:SetText(txt_desc)
  local DPS_s64 = ToClient_getDamageLogDPS()
  self._ui._bottomControls[__eDamageLogUiType_DPS].txt_desc:SetText(tostring(DPS_s64))
end
