function PaGlobal_SelectGuildMansion_All:initialize()
  if PaGlobal_SelectGuildMansion_All._initialize == true or Panel_SelectGuildMansion_All == nil then
    return
  end
  self._ui._btn_close = UI.getChildControl(Panel_SelectGuildMansion_All, "Button_Close")
  self._ui._btn_confirm = UI.getChildControl(Panel_SelectGuildMansion_All, "Button_Yes")
  self._ui._btn_cancel = UI.getChildControl(Panel_SelectGuildMansion_All, "Button_No")
  self._ui._edit_familyName = UI.getChildControl(Panel_SelectGuildMansion_All, "Edit_FamilyName")
  self._ui._edit_familyName:SetMaxInput(30)
  self._ui._searchedResultList = UI.getChildControl(Panel_SelectGuildMansion_All, "List2_SearchedResultList")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_SelectGuildMansion_All, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self._ui.stc_content1 = UI.getChildControl(Panel_SelectGuildMansion_All, "MultilineText_Content_1")
  self.keyguide = {
    self._ui.stc_keyGuide_Y,
    self._ui.stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._isConsole = _ContentsGroup_UsePadSnapping
  PaGlobal_SelectGuildMansion_All:switchPlatform(self._isConsole)
  PaGlobal_SelectGuildMansion_All:validate()
  PaGlobal_SelectGuildMansion_All:registEventHandler()
  PaGlobal_SelectGuildMansion_All._initialize = true
end
function PaGlobal_SelectGuildMansion_All:switchPlatform(isConsole)
  self._ui.stc_KeyGuide_Bg:SetShow(isConsole)
  self._ui._btn_close:SetShow(not isConsole)
  local contentString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MESSAGEBOX_GUILDHOUSE_CONTENT1")
  if self._isConsole == false then
    contentString = contentString .. "\n" .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MESSAGEBOX_GUILDHOUSE_CONTENT1_PC_ADVICE")
  end
  self._ui.stc_content1:SetText(contentString)
end
function PaGlobal_SelectGuildMansion_All:validate()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
end
function PaGlobal_SelectGuildMansion_All:registEventHandler()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_SelectGuildMansion_All_Close()")
  self._ui._btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_SelectGuildMansion_All_Close()")
  self._ui._edit_familyName:RegistReturnKeyEvent("PaGlobalFunc_Guild_SelectGuildMansion_All_SearchGuildMember()")
  self._ui._searchedResultList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_Guild_SelectGuildMansion_All_CreateContent")
  self._ui._searchedResultList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobalFunc_SelectGuildMansion_All_ConfirmButton()")
  Panel_SelectGuildMansion_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_Guild_SelectGuildMansion_All_SearchGuildMember()")
  self._ui._edit_familyName:setXboxVirtualKeyBoardEndEvent("PaGlobalFunc_SelectGuildMansion_All_KeyboardEnd()")
  registerEvent("FromClient_SelectGuildMansionUpdate", "PaGlobalFunc_Guild_SelectGuildMansion_All_Update()")
end
function PaGlobal_SelectGuildMansion_All:prepareOpen()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  if self._isConsole == false then
    SetFocusEdit(self._ui._edit_familyName)
  end
  PaGlobal_SelectGuildMansion_All:updateAllUI(false)
  PaGlobal_SelectGuildMansion_All:open()
end
function PaGlobal_SelectGuildMansion_All:open()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  Panel_SelectGuildMansion_All:SetShow(true)
end
function PaGlobal_SelectGuildMansion_All:prepareClose()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  PaGlobal_SelectGuildMansion_All:clear()
  PaGlobal_SelectGuildMansion_All:close()
end
function PaGlobal_SelectGuildMansion_All:close()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  Panel_SelectGuildMansion_All:SetShow(false)
end
function PaGlobal_SelectGuildMansion_All:searchGuildMember()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  local familyName = self._ui._edit_familyName:GetText()
  ToClient_SearchGuildMemberByFamilyName(familyName)
  PaGlobal_SelectGuildMansion_All:updateAllUI(false)
  if self._isConsole == true then
    ClearFocusEdit()
  end
end
function PaGlobal_SelectGuildMansion_All:updateAllUI(isAfterSearch)
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  PaGlobal_SelectGuildMansion_All:updateListUI(isAfterSearch)
  PaGlobal_SelectGuildMansion_All:updateConfirmButton()
end
function PaGlobal_SelectGuildMansion_All:updateListUI(isAfterSearch)
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  local mansionCount = ToClient_GetGuildMemberMansionCount()
  local listManager = self._ui._searchedResultList:getElementManager()
  listManager:clearKey()
  for index = 0, mansionCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  if mansionCount >= 1 and isAfterSearch == true then
    PaGlobal_SelectGuildMansion_All:setFocusToFirstElement()
  end
end
function PaGlobal_SelectGuildMansion_All:setFocusToFirstElement()
  if self._isConsole == false then
    return
  end
  ClearFocusEdit()
  local content = UI.getChildControl(self._ui._searchedResultList, "List2_SearchedResultList_Content_" .. tostring(0))
  local radioButton = UI.getChildControl(content, "MansionButton")
  ToClient_padSnapChangeToTarget(radioButton)
end
function PaGlobal_SelectGuildMansion_All:updateConfirmButton()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  local selectedMansionIndex = PaGlobal_SelectGuildMansion_All:getCheckedIndex()
  if selectedMansionIndex == nil then
    self._ui._btn_confirm:SetIgnore(true)
    self._ui._btn_confirm:SetMonoTone(true)
    return
  end
  self._ui._btn_confirm:SetIgnore(false)
  self._ui._btn_confirm:SetMonoTone(false)
end
function PaGlobal_SelectGuildMansion_All:createContent(content, key)
  if Panel_SelectGuildMansion_All == nil or content == nil or key == nil then
    return
  end
  local index = Int64toInt32(key)
  local mansionWrapper = ToClient_GetGuildMemberMansion(index)
  if mansionWrapper == nil then
    return
  end
  local btn_mansionButton = UI.getChildControl(content, "MansionButton")
  btn_mansionButton:SetText(mansionWrapper:getName())
  btn_mansionButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_SelectGuildMansion_All_UpdateConfirmButton()")
end
function PaGlobal_SelectGuildMansion_All:confirmButton()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  local selectedMansionIndex = PaGlobal_SelectGuildMansion_All:getCheckedIndex()
  if selectedMansionIndex == nil then
    return
  end
  ToClient_RequestChangeMansionMember(selectedMansionIndex, true)
end
function PaGlobal_SelectGuildMansion_All:clear()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  local listManager = self._ui._searchedResultList:getElementManager()
  listManager:clearKey()
  ToClient_ResetSearchedGuildMember()
  self._ui._edit_familyName:SetEditText("")
end
function PaGlobal_SelectGuildMansion_All:getCheckedIndex()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  local selectedMansionIndex
  local mansionCount = ToClient_GetGuildMemberMansionCount()
  for index = 0, mansionCount - 1 do
    local content = UI.getChildControl(self._ui._searchedResultList, "List2_SearchedResultList_Content_" .. tostring(index))
    local radioButton = UI.getChildControl(content, "MansionButton")
    if radioButton:IsChecked() == true then
      selectedMansionIndex = index
      break
    end
  end
  return selectedMansionIndex
end
