function PaGlobal_WorldMap_FamilyCharacterChangeMemo:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_blockBg = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Static_BlockBg")
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Static_TitleBg")
  self._ui.stc_subFrame = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Static_SubFrame")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Close")
  self._ui.edit_memo = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Edit_Memo")
  self._ui.btn_apply = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Button_Apply_PCUI")
  self._ui.btn_reset = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Button_Cancel_PCUI")
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_FamilyCharacterChangeMemo_All, "Static_BottomBg_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_Y_ConsoleUI")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuideX = UI.getChildControl(self._ui.edit_memo, "Static_X_ConsoleUI")
  self._ui.edit_memo:SetMaxInput(self._maxInput)
  Panel_Window_FamilyCharacterChangeMemo_All:ignorePadSnapMoveToOtherPanel()
  self:setConsoleUI()
  self:setPanelSize()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:setPanelSize()
  local gap = 10
  local modifySizeY = self._ui.btn_apply:GetSizeY() + gap
  local panelDefaultSizeY = self._ui.stc_titleBg:GetSizeY() + self._ui.edit_memo:GetSizeY() + gap * 2
  local panelSizeY = panelDefaultSizeY
  if self._isConsole == true then
    panelSizeY = panelDefaultSizeY + gap
  else
    panelSizeY = panelDefaultSizeY + modifySizeY + gap
  end
  Panel_Window_FamilyCharacterChangeMemo_All:SetSize(Panel_Window_FamilyCharacterChangeMemo_All:GetSizeX(), panelSizeY)
  self._ui.stc_subFrame:SetSize(self._ui.stc_subFrame:GetSizeX(), panelSizeY - self._ui.stc_titleBg:GetSizeY())
  self._ui.stc_keyGuideBg:ComputePos()
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:setConsoleUI()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return
  end
  if self._isConsole == true then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_apply:SetShow(false)
    self._ui.btn_reset:SetShow(false)
    self._ui.stc_keyGuideX:SetShow(true)
    self._ui.stc_keyGuideBg:SetShow(true)
    self:alignKeyGuide()
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_apply:SetShow(true)
    self._ui.btn_reset:SetShow(true)
    self._ui.stc_keyGuideBg:SetShow(false)
  end
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:alignKeyGuide()
  local keyGuideTable = {
    self._ui.stc_keyGuideY,
    self._ui.stc_keyGuideA,
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideTable, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:registEventHandler()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_FamilyCharacterChangeMemo_All_Resize")
  registerEvent("FromClient_CheckChinaProhibitedWord_FamilyCharacterMemo", "FromClient_CheckChinaProhibitedWord_FamilyCharacterMemo()")
  if self._isConsole == true then
    Panel_Window_FamilyCharacterChangeMemo_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_FamilyCharacterChangeMemo_All_SetFocusEdit()")
    Panel_Window_FamilyCharacterChangeMemo_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_FamilyCharacterChangeMemo_All_Reset()")
    Panel_Window_FamilyCharacterChangeMemo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
    self._ui.edit_memo:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_FamilyCharacterChangeMemo_All_KeyBoardEnd")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()")
    self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
    self._ui.edit_memo:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyCharacterChangeMemo_All_SetFocusEdit()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
    self._ui.btn_reset:addInputEvent("Mouse_LUp", "HandleEventLUp_FamilyCharacterChangeMemo_All_Reset()")
  end
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:prepareOpen(characterDataIndex)
  if Panel_Window_FamilyCharacterChangeMemo_All == nil or characterDataIndex == nil then
    return
  end
  self._currentCharacterIndex = characterDataIndex
  self._ui.edit_memo:SetEditText("")
  local characterData = getCharacterDataByIndex(self._currentCharacterIndex, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  local currentText = ToClient_GetFamilyCharacterMemo(characterData._characterNo_s64)
  self._ui.edit_memo:SetMaxInput(self._maxInput)
  SetFocusEdit(self._ui.edit_memo)
  self._ui.edit_memo:SetEditText(currentText, true)
  self:resize()
  self:open()
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:open()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return
  end
  Panel_Window_FamilyCharacterChangeMemo_All:SetShow(true)
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:prepareClose()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    if self._isConsole == true then
      Panel_Window_FamilyCharacterChangeMemo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
    else
      self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
      self._ui.btn_apply:SetIgnore(false)
    end
  end
  self._currentCharacterIndex = nil
  self:close()
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:close()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return
  end
  Panel_Window_FamilyCharacterChangeMemo_All:SetShow(false)
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:resize()
  self:setPanelSize()
  Panel_Window_FamilyCharacterChangeMemo_All:ComputePos()
  self._ui.stc_blockBg:SetSize(getOriginScreenSizeX(), getOriginScreenSizeY())
  self._ui.stc_blockBg:ComputePos()
end
function PaGlobal_WorldMap_FamilyCharacterChangeMemo:validate()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return
  end
  self._ui.stc_blockBg:isValidate()
  self._ui.stc_titleBg:isValidate()
  self._ui.stc_subFrame:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.edit_memo:isValidate()
  self._ui.btn_apply:isValidate()
  self._ui.btn_reset:isValidate()
  self._ui.stc_keyGuideBg:isValidate()
  self._ui.stc_keyGuideY:isValidate()
  self._ui.stc_keyGuideA:isValidate()
  self._ui.stc_keyGuideB:isValidate()
  self._ui.stc_keyGuideX:isValidate()
end
