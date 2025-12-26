function PaGlobal_CharacterInfo_HardCore_All:initialize()
  if PaGlobal_CharacterInfo_HardCore_All._initialize == true then
    return
  end
  local titleBg = UI.getChildControl(Panel_CharacterInfo_HardCore_All, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(titleBg, "Button_Close")
  self._ui._btn_Question = UI.getChildControl(titleBg, "Button_Question")
  self._ui._btn_StickerUI = UI.getChildControl(titleBg, "CheckButton_PopUp")
  local tabBg = UI.getChildControl(Panel_CharacterInfo_HardCore_All, "Static_TapBg")
  self._ui._stc_selectLine = UI.getChildControl(tabBg, "Static_SelectLine")
  local basicTabData = {
    btn = nil,
    panel = nil,
    bg = nil,
    updateFunc = nil
  }
  basicTabData.btn = UI.getChildControl(tabBg, "RadioButton_Tab_Basic")
  basicTabData.btn:SetShow(false)
  basicTabData.bg = UI.getChildControl(Panel_CharacterInfo_HardCore_All, "Static_BasicBg")
  self._tabData[self._HARDCORE_CHARACTERINFO_TABINDEX._basic] = basicTabData
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_CharacterInfo_HardCore_All:registEventHandler()
  PaGlobal_CharacterInfo_HardCore_All:validate()
  self._initialize = true
end
function PaGlobal_CharacterInfo_HardCore_All:registEventHandler()
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  self._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo_HardCore_Close()")
  self._ui._btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SelfCharacterInfo\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui._btn_Question, "\"SelfCharacterInfo\"")
  self._ui._btn_StickerUI:addInputEvent("Mouse_LUp", "HandleEventLUp_ChracterInfo_HardCore_All_PopUpUI()")
  self._ui._btn_StickerUI:addInputEvent("Mouse_On", "HandleEventOnOut_ChracterInfo_HardCore_All_PopUpUI_Tooltip(true)")
  self._ui._btn_StickerUI:addInputEvent("Mouse_Out", "HandleEventOnOut_ChracterInfo_HardCore_All_PopUpUI_Tooltip(false)")
end
function PaGlobal_CharacterInfo_HardCore_All:validate()
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  self._ui._btn_Close:isValidate()
  self._ui._btn_Question:isValidate()
  self._ui._btn_StickerUI:isValidate()
  self._ui._stc_selectLine:isValidate()
end
function PaGlobal_CharacterInfo_HardCore_All:prepareOpen()
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  self:dataClear()
  self:open()
  self:otherTabOpen(self._HARDCORE_CHARACTERINFO_TABINDEX._basic)
end
function PaGlobal_CharacterInfo_HardCore_All:otherTabOpen(idx)
  UI.ASSERT_NAME(nil ~= self._tabData[idx], "PaGlobal_CharacterInfo_HardCore_All.lua / self._tabData[idx] is nil ", "-")
  if nil ~= self._currentTabIdx then
    if idx == self._currentTabIdx then
      return
    end
    self._tabData[self._currentTabIdx].btn:SetCheck(false)
    self._tabData[self._currentTabIdx].bg:SetShow(false)
  end
  if self._tabData[idx].bg:GetShow() == false then
    return
  end
  self._currentTabIdx = idx
  local updateFunc = self._tabData[idx].updateFunc
  UI.ASSERT_NAME(nil ~= self._tabData[idx].updateFunc, "PaGlobal_CharacterInfo_HardCore_All.lua / idx =" .. tostring(idx) .. "\tupdateFunc is nil ", "-")
  self._tabData[self._currentTabIdx].btn:SetCheck(true)
  self._tabData[self._currentTabIdx].bg:SetShow(true)
  updateFunc()
  local selectLinePosX = self._tabData[self._currentTabIdx].btn:GetPosX() - (self._tabData[self._currentTabIdx].btn:GetSizeX() * 0.5 + 5 * self._tabData[self._currentTabIdx].btn:GetScale().x)
  self._ui._stc_selectLine:SetSpanSize(selectLinePosX, self._ui._stc_selectLine:GetSpanSize().y)
  ClearFocusEdit()
end
function PaGlobal_CharacterInfo_HardCore_All:setTabData(index, panel, updateFunc)
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  UI.ASSERT_NAME(nil ~= index, "PaGlobal_CharacterInfo_HardCore_All.lua / index is nil", "-")
  UI.ASSERT_NAME(nil ~= self._tabData, "PaGlobal_CharacterInfo_HardCore_All_1.lua / table is nil", "-")
  self._tabData[index].panel = panel
  self._tabData[index].updateFunc = updateFunc
  UI.ASSERT_NAME(nil ~= self._tabData[index].btn, "PaGlobal_CharacterInfo_HardCore_All_1.lua / btn is nil", "-")
  UI.ASSERT_NAME(nil ~= self._tabData[index].panel, "PaGlobal_CharacterInfo_HardCore_All_1.lua / panel is nil", "-")
  UI.ASSERT_NAME(nil ~= self._tabData[index].bg, "PaGlobal_CharacterInfo_HardCore_All_1.lua / bg is nil", "-")
  UI.ASSERT_NAME(nil ~= self._tabData[index].updateFunc, "PaGlobal_CharacterInfo_HardCore_All_1.lua / updateFunc is nil", "-")
  self._tabData[index].bg:MoveChilds(self._tabData[index].bg:GetID(), self._tabData[index].panel)
  deletePanel(self._tabData[index].panel:GetID())
  self._tabData[index].bg:ComputePos()
  self._tabData[index].btn:addInputEvent("Mouse_LUp", "PaGlobal_CharacterInfo_HardCore_ClickOtherTab(" .. index .. ")")
  if false == self._isConsole then
    self._tabData[index].btn:addInputEvent("Mouse_On", "PaGlobal_CharacterInfo_HardCore_TabBtn_Tooltip(" .. index .. ")")
    self._tabData[index].btn:addInputEvent("Mouse_Out", "PaGlobal_CharacterInfo_HardCore_TabBtn_Tooltip()")
  end
  self._tabData[index].btn:SetShow(true)
end
function PaGlobal_CharacterInfo_HardCore_All:open()
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  Panel_CharacterInfo_HardCore_All:SetShow(true)
end
function PaGlobal_CharacterInfo_HardCore_All:prepareClose()
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  self:close()
end
function PaGlobal_CharacterInfo_HardCore_All:close()
  if Panel_CharacterInfo_HardCore_All == nil then
    return
  end
  Panel_CharacterInfo_HardCore_All:SetShow(false)
end
function PaGlobal_CharacterInfo_HardCore_All:dataClear()
  self._currentTabIdx = nil
  self._consoleIdx = 0
end
