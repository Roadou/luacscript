function PaGlobal_DamageLog_Detail:initialize()
  self._ui._btn_close = UI.getChildControl(self._ui._stc_titleBg, "Button_Close")
  self._ui._list2_logList = UI.getChildControl(self._ui._stc_mainBg, "List2_LogList_Sub")
  self:validate()
  self:registerEvent()
  self._initialize = true
end
function PaGlobal_DamageLog_Detail:clear()
  self._logMgrWrapper = nil
end
function PaGlobal_DamageLog_Detail:prepareOpen(index)
  self:open(index)
end
function PaGlobal_DamageLog_Detail:open(index)
  if false == self._initialize then
    return
  end
  if false == ToClient_IsDevelopment() then
    UI.ASSERT_NAME(false, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184\235\138\148 Dev\236\151\144\236\132\156\235\167\140 \236\130\172\236\154\169 \234\176\128\235\138\165 \237\149\169\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  local logMgrWrapper = ToClient_getFrameEventDamageInfoWrapper(index)
  if nil == logMgrWrapper then
    UI.ASSERT_NAME(false, "\235\141\176\235\175\184\236\167\128 \235\161\156\234\183\184 \236\160\149\235\179\180\234\176\128 \236\151\134\236\138\181\235\139\136\235\139\164.", "\235\176\149\234\183\156\235\130\152")
    return
  end
  self:clear()
  self._logMgrWrapper = logMgrWrapper
  self:updateLogList()
  local selectedIndex = self._ui._combo_logLevel:GetSelectIndex()
  if -1 == selectedIndex then
    self._ui._combo_logLevel:SetSelectItemIndex(__eDamageLogLevel_0)
  end
  Panel_Window_DamageLog_Detail:SetShow(true)
end
function PaGlobal_DamageLog_Detail:prepareClose()
  self:close()
end
function PaGlobal_DamageLog_Detail:close()
  Panel_Window_DamageLog_Detail:SetShow(false)
end
function PaGlobal_DamageLog_Detail:validate()
  self._ui._stc_titleBg:isValidate()
  self._ui._stc_mainBg:isValidate()
  self._ui._btn_cancel:isValidate()
  self._ui._combo_logLevel:isValidate()
  self._ui._edit_keyword:isValidate()
end
function PaGlobal_DamageLog_Detail:registerEvent()
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_DamageLog_Detail:prepareClose()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobal_DamageLog_Detail:prepareClose()")
  self._ui._list2_logList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_DamageLog_Detail_ListUpdate")
  self._ui._list2_logList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._combo_logLevel:addInputEvent("Mouse_LUp", "PaGlobal_DamageLog_Detail:showDamageLogLevelList()")
  self._ui._combo_logLevel:GetListControl():AddSelectEvent("PaGlobal_DamageLog_Detail:updateLogList()")
  self._ui._combo_logLevel:setListTextHorizonCenter()
  self._ui._combo_logLevel:DeleteAllItem()
  for ii = __eDamageLogLevel_0, __eDamageLogLevel_Count - 1 do
    self._ui._combo_logLevel:AddItem(self._damageLogLevelString[ii])
  end
  self._ui._edit_keyword:RegistReturnKeyEvent("PaGlobal_DamageLog_Detail:updateLogList()")
end
function PaGlobal_DamageLog_Detail:checkCondition(index)
  if nil == self._logMgrWrapper then
    return false
  end
  local logWrapper = self._logMgrWrapper:getDamageLogWrapperByIndex(index)
  if nil == logWrapper then
    return false
  end
  local currentLogLevel = self._ui._combo_logLevel:GetSelectIndex()
  if currentLogLevel > logWrapper:getDamageLogLevel() then
    return false
  end
  local attackType = self._logMgrWrapper:getAttackType()
  local keyword = self._ui._edit_keyword:GetEditText()
  if false == logWrapper:findString(attackType, keyword) then
    return false
  end
  return true
end
function PaGlobal_DamageLog_Detail:showDamageLogLevelList()
  self._ui._combo_logLevel:ToggleListbox()
end
function PaGlobal_DamageLog_Detail:updateLogList()
  if nil == self._logMgrWrapper then
    return
  end
  local maxCount = self._logMgrWrapper:getLogCount()
  self._ui._list2_logList:getElementManager():clearKey()
  for ii = 0, maxCount - 1 do
    if true == self:checkCondition(ii) then
      self._ui._list2_logList:getElementManager():pushKey(toInt64(0, ii))
    end
  end
end
