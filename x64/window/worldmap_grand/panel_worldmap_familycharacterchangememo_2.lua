function PaGlobalFunc_FamilyCharacterChangeMemo_All_Open(characterDataIndex)
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil then
    return false
  end
  self:prepareOpen(characterDataIndex)
end
function PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil then
    return false
  end
  self:prepareClose()
end
function PaGlobalFunc_FamilyCharacterChangeMemo_All_GetShow()
  if Panel_Window_FamilyCharacterChangeMemo_All == nil then
    return false
  end
  return Panel_Window_FamilyCharacterChangeMemo_All:GetShow()
end
function PaGlobalFunc_FamilyCharacterChangeMemo_All_Resize()
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil then
    return false
  end
  self:resize()
end
function PaGlobalFunc_FamilyCharacterChangeMemo_All_KeyBoardEnd(str)
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil then
    return false
  end
  if string.len(str) > self._maxInput then
    str = string.sub(str, 1, self._maxInput)
  end
  self._ui.edit_memo:SetEditText(str)
  ClearFocusEdit()
end
function HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil or self._currentCharacterIndex == nil then
    return false
  end
  local userInput = self._ui.edit_memo:GetEditText()
  if userInput == nil then
    return
  end
  if _ContentsOption_CH_CheckProhibitedWord == true then
    local result = ToClient_CheckChinaProhibitedWord(userInput, __eSceneIdFamilyCharacterMemo)
    if result == true then
      if self._isConsole == true then
        Panel_Window_FamilyCharacterChangeMemo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
      else
        self._ui.edit_memo:RegistReturnKeyEvent("")
        self._ui.btn_apply:SetIgnore(true)
      end
    end
    return
  end
  local characterData = getCharacterDataByIndex(self._currentCharacterIndex, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  ToClient_SetFamilyCharacterMemo(characterData._characterNo_s64, userInput)
  PaGlobalFunc_WorldMap_FamilyCharacterList_UpdateCharacterMemo(self._currentCharacterIndex)
  PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()
end
function HandleEventLUp_FamilyCharacterChangeMemo_All_Reset()
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil or self._currentCharacterIndex == nil then
    return false
  end
  local characterData = getCharacterDataByIndex(self._currentCharacterIndex, __ePlayerCreateNormal)
  if characterData == nil then
    return
  end
  SetFocusEdit(self._ui.edit_memo)
  self._ui.edit_memo:SetEditText("", true)
end
function HandleEventLUp_FamilyCharacterChangeMemo_All_SetFocusEdit()
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil or self._currentCharacterIndex == nil then
    return false
  end
  if Panel_Window_FamilyCharacterChangeMemo_All:GetShow() == false then
    return
  end
  self._ui.edit_memo:SetMaxInput(self._maxInput)
  SetFocusEdit(self._ui.edit_memo)
  self._ui.edit_memo:SetEditText(self._ui.edit_memo:GetEditText(), true)
end
function FromClient_CheckChinaProhibitedWord_FamilyCharacterMemo(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_WorldMap_FamilyCharacterChangeMemo
  if self == nil then
    return
  end
  if true == self._isConsole then
    Panel_Window_FamilyCharacterChangeMemo_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
  else
    self._ui.edit_memo:RegistReturnKeyEvent("HandleEventLUp_FamilyCharacterChangeMemo_All_Apply()")
    self._ui.btn_apply:SetIgnore(false)
  end
  if isPass == true then
    local characterData = getCharacterDataByIndex(self._currentCharacterIndex, __ePlayerCreateNormal)
    if characterData == nil then
      return
    end
    ToClient_SetFamilyCharacterMemo(characterData._characterNo_s64, filteredText)
    PaGlobalFunc_WorldMap_FamilyCharacterList_UpdateCharacterMemo(self._currentCharacterIndex)
    PaGlobalFunc_FamilyCharacterChangeMemo_All_Close()
  end
end
