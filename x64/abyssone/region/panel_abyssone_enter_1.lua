function PaGlobal_EnterAbyssOne:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_mainBg = UI.getChildControl(Panel_AbyssOne_Enter, "Static_BG")
  self._ui._stc_regionName = UI.getChildControl(self._ui._stc_mainBg, "StaticText_RegionName")
  self._ui._stc_regionDesc = UI.getChildControl(self._ui._stc_mainBg, "MultilineText_Desc")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnterAbyssOne:registEventHandler()
  if Panel_AbyssOne_Enter == nil then
    return
  end
  Panel_AbyssOne_Enter:RegisterShowEventFunc(true, "Panel_AbyssOne_Enter_ShowAni()")
  Panel_AbyssOne_Enter:RegisterShowEventFunc(false, "Panel_AbyssOne_Enter_HideAni()")
  registerEvent("FromClient_OpenAbyssOneRegionTitle", "FromClient_CheckEnterAbyssOne")
end
function PaGlobal_EnterAbyssOne:validate()
  if Panel_AbyssOne_Enter == nil then
    return
  end
  self._ui._stc_mainBg:isValidate()
  self._ui._stc_regionName:isValidate()
  self._ui._stc_regionDesc:isValidate()
end
function PaGlobal_EnterAbyssOne:prepareOpen()
  if Panel_AbyssOne_Enter == nil then
    return
  end
  local isSuccessSetData = self:setData()
  if isSuccessSetData == false then
    UI.ASSERT_NAME(false, "\236\150\180\235\185\132\236\138\164\236\155\144 \236\158\133\236\158\165 UI \236\132\184\237\140\133\236\151\144 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  self._accDeltaTimeSec = 0
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_EnterAbyssOne:open()
  if Panel_AbyssOne_Enter == nil then
    return
  end
  audioPostEvent_SystemUi(33, 2)
  _AudioPostEvent_SystemUiForXBOX(33, 2)
  Panel_AbyssOne_Enter:RegisterUpdateFunc("PaGlobalFunc_EnterAbyssOne_Update")
  Panel_AbyssOne_Enter:SetShow(true, true)
end
function PaGlobal_EnterAbyssOne:prepareClose()
  if Panel_AbyssOne_Enter == nil then
    return
  end
  self:close()
end
function PaGlobal_EnterAbyssOne:close()
  if Panel_AbyssOne_Enter == nil then
    return
  end
  Panel_AbyssOne_Enter:ClearUpdateLuaFunc()
  Panel_AbyssOne_Enter:SetShow(false, true)
end
function PaGlobal_EnterAbyssOne:recalcPanelPosition()
  local panel = Panel_AbyssOne_Enter
  if panel == nil then
    return
  end
  Panel_AbyssOne_Enter:ComputePos()
end
function PaGlobal_EnterAbyssOne:update(deltaTime)
  if Panel_AbyssOne_Enter == nil then
    return
  end
  self._accDeltaTimeSec = self._accDeltaTimeSec + deltaTime
  if self._hideTimeSec <= self._accDeltaTimeSec then
    PaGlobalFunc_EnterAbyssOne_Close()
    return
  end
end
function PaGlobal_EnterAbyssOne:setData()
  if Panel_AbyssOne_Enter == nil then
    return false
  end
  local currentMapKey = ToClient_GetCurrentInstanceFieldMapKey()
  local instanceMapSSW = ToClient_GetInstanceMapStaticStatusWrapper(currentMapKey)
  if instanceMapSSW == nil then
    return false
  end
  local mapNameStrig = PAGetString(Defines.StringSheet_GAME, instanceMapSSW:getFieldNameStringKey())
  if mapNameStrig == nil then
    return false
  end
  local mapDescString = PAGetString(Defines.StringSheet_GAME, instanceMapSSW:getFieldDescStringKey())
  if mapDescString == nil then
    return false
  end
  self._ui._stc_regionName:SetText(mapNameStrig)
  self._ui._stc_regionDesc:SetText(mapDescString)
  return true
end
