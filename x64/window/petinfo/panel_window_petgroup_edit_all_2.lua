function PaGlobalFunc_PetGroupEdit_Open()
  PaGlobal_PetGroupEdit:prepareOpen()
end
function PaGlobalFunc_PetGroupEdit_Close()
  PaGlobal_PetGroupEdit:prepareClose()
end
function PaGlobalFunc_PetGroupEdit_GetShow()
  if Panel_Window_GroupEdit_All == nil then
    return false
  end
  return (Panel_Window_GroupEdit_All:GetShow())
end
function PaGlobalFunc_PetGroupEdit_ClickGroup(index)
  PaGlobal_PetGroupEdit:clickGroup(index)
end
function PaGlobalFunc_PetGroupEdit_ClickGroupForConsole(isLeft)
  local currentPresetCount = self._groupCount
  if _ContentsGroup_PetPresetExpansion == true then
    currentPresetCount = ToClient_GetPetPresetCount()
  end
  if isLeft == true then
    PaGlobal_PetGroupEdit._indexForConsole = PaGlobal_PetGroupEdit._indexForConsole - 1
  elseif isLeft == false then
    PaGlobal_PetGroupEdit._indexForConsole = PaGlobal_PetGroupEdit._indexForConsole + 1
  end
  if PaGlobal_PetGroupEdit._indexForConsole < 1 then
    PaGlobal_PetGroupEdit._indexForConsole = currentPresetCount
  elseif currentPresetCount < PaGlobal_PetGroupEdit._indexForConsole then
    PaGlobal_PetGroupEdit._indexForConsole = 1
  end
  PaGlobal_PetGroupEdit:clickGroup(PaGlobal_PetGroupEdit._indexForConsole)
end
