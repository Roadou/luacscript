function PaGlobalFunc_Memo_Main_All_CheckUiEdit(targetUI)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  if nil == PaGlobal_Memo_All._currentFocusId then
    return false
  end
  local currentMemo = PaGlobal_Memo_All._stickyMemoList[PaGlobal_Memo_All._currentFocusId]
  if nil == currentMemo then
    return false
  end
  local currentEdit = PaGlobal_Memo_All._stickyMemoList[PaGlobal_Memo_All._currentFocusId]._ui._MultiLineText
  if nil ~= targetUI and targetUI:GetKey() == currentEdit:GetKey() then
    return true
  end
  return false
end
function PaGlobalFunc_Memo_Main_All_Open()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:prepareOpen()
end
function PaGlobalFunc_Memo_Main_All_Close()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:prepareClose()
end
function PaGlobalFunc_Memo_Main_All_Save(saveMode, inputId)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Save(saveMode, inputId)
end
function PaGlobalFunc_Memo_Main_All_ShowAni()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:memo_List_ShowAni()
end
function PaGlobalFunc_Memo_Main_All_HideAni()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:memo_List_HideAni()
end
function HandleEventLUp_Memo_Main_All_AddMemo()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:AddMemo()
end
function HandleEventLUp_Memo_Main_All_MemoRemoveAll()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:MemoRemoveAll()
end
function HandleEventLUp_Memo_Main_All_ListClose()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:ListClose()
end
function HandleEventLUp_Memo_Main_All_StickyClose(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyClose(id)
end
function HandleEventLPress_Memo_Main_All_StickyAlpahSlider(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyAlphaSlider(id)
  PaGlobal_Memo_All:Save(PaGlobal_Memo_All._SaveMode.SETTING, id)
end
function HandleEventLDown_Memo_Main_All_StickyResizeStartPos(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyResizeStartPos(id)
end
function HandleEventLPress_Memo_Main_All_StickyResize(id, type)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyResize(id, type)
end
function HandleEventLUp_Memo_Main_All_StickyEnd(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyResizeEnd(id)
end
function HandleEventLUp_Memo_Main_All_StickyClickedContent(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyMouseLUPContent(id)
end
function HandleEventAllkeyEvent_Memo_Main_All_StickyClickedContent(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyClickedContent(id)
end
function HandleEventLUp_Memo_Main_All_MemoSave(saveMode, inputId)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Save(saveMode, inputId)
end
function HandleEventLUp_Memo_Main_All_Check_PopUI(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Check_PopUI(id)
end
function HandleEventLUp_Memo_Main_All_StickyToggleChangeColor(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleChangeColor(id)
end
function HandleEventLUp_Memo_Main_All_StickyChangeColorEnd(id, color)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyChangeColorEnd(id, color)
end
function HandleEventScrollUp_Memo_Main_All_OnMouseWheel(stickyMemoId, isUp)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:OnMouseWheel(stickyMemoId, isUp)
end
function HandleEventScrollDown_Memo_Main_All_OnMouseWheel(stickyMemoId, isUp)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:OnMouseWheel(stickyMemoId, isUp)
end
function HandleEventLDClick_Memo_Main_All_StickyToggleShow(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleMessageBox(id)
end
function HandleEventLUp_Memo_Main_All_StickyToggleShow(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:StickyToggleMessageBox(id)
end
function HandleEventLUp_Memo_Main_All_RemoveConfirmPopUp(id)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:RemoveConfirmPopUp(id)
end
function HandleEventMOn_Memo_Main_All_Tooltip_Show(uiType)
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Tooltip_Show(uiType)
end
function HandleEventMOut_Memo_Main_All_Tooltip_Hide()
  if nil == Panel_Window_Memo_Main_All then
    return
  end
  PaGlobal_Memo_All:Tooltip_Hide()
end
function FromClient_CheckChinaProhibitedWord_Memo(isPass, filteredText)
  if _ContentsOption_CH_CheckProhibitedWord == false then
    return
  end
  local self = PaGlobal_Memo_All
  if self == nil then
    return
  end
  local id = self._currentFocusId
  local stickyMemo = self._stickyMemoList[id]
  if stickyMemo ~= nil then
    stickyMemo._ui._btn_Close:SetIgnore(false)
    stickyMemo._ui._btn_Save:SetIgnore(false)
  end
  if isPass == true then
    local content = stickyMemo._ui._MultiLineText:GetEditText()
    PaGlobal_Memo_All:SaveFilteredText(self._currentSaveMode, self._currentFocusId, content)
  else
    local memoInfo = ToClient_getMemo(id)
    if memoInfo:isOn() == true and self._isClose == true and stickyMemo ~= nil then
      stickyMemo._isOn = false
      stickyMemo._ui._MultiLineText:SetModified(false)
      HandleEventLUp_Memo_Main_All_StickyClose(id)
    end
    self._isClose = false
  end
end
function FromClient_SaveMemo(saveMode, id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  local stickyMemo = PaGlobal_Memo_All._stickyMemoList[id]
  if stickyMemo == nil then
    return
  end
  local posX = stickyMemo._mainPanel:GetPosX()
  local posY = stickyMemo._mainPanel:GetPosY()
  local memoInfo = ToClient_getMemo(id)
  if true == stickyMemo._isSubAppMode then
    posX = memoInfo:getPositionX()
    posY = memoInfo:getPositionY()
  end
  local info = MemoInfo(id)
  local content = memoInfo:getContent()
  if _content == "" or content == "Content" then
    content = PAGetString(Defines.StringSheet_GAME, "LUA_MEMO_INSERTCONTENT")
  elseif saveMode == PaGlobal_Memo_All._SaveMode.ALL then
    content = stickyMemo._ui._MultiLineText:GetEditText()
  end
  info:setInfo(content, stickyMemo._isOn, int2(posX, posY), int2(stickyMemo._mainPanel:GetSizeX(), stickyMemo._mainPanel:GetSizeY()), stickyMemo._stickyMemoAlpha, stickyMemo._stickyMemoColor)
  ToClient_updateMemo(info, saveMode)
  stickyMemo._ui._MultiLineText:SetModified(false)
  PaGlobal_Memo_All:ListUpdate()
end
function HandleEventLUp_Memo_Main_All_StickyBoldButton(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyLUPBoldButton(id)
  if isGameTypeCH() == false then
    FromClient_SaveMemo(PaGlobal_Memo_All._SaveMode.ALL, id)
  end
end
function HandleEventLUp_Memo_Main_All_StickyItalicButton(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyLUPItalicButton(id)
  if isGameTypeCH() == false then
    FromClient_SaveMemo(PaGlobal_Memo_All._SaveMode.ALL, id)
  end
end
function HandleEventLUp_Memo_Main_All_StickyUnderLineButton(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyLUPUnderLineButton(id)
  if isGameTypeCH() == false then
    FromClient_SaveMemo(PaGlobal_Memo_All._SaveMode.ALL, id)
  end
end
function HandleEventLUp_Memo_Main_All_StickyDeleteLineButton(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyLUPDeleteLineButton(id)
  if isGameTypeCH() == false then
    FromClient_SaveMemo(PaGlobal_Memo_All._SaveMode.ALL, id)
  end
end
function HandleEventLUp_Memo_Main_All_StickyToggleTextChangeColor(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyToggleTextChangeColor(id)
end
function HandleEventLUp_Memo_Main_All_StickyColorButton(id, color)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyLUPColorButton(id, color)
  if isGameTypeCH() == false then
    FromClient_SaveMemo(PaGlobal_Memo_All._SaveMode.ALL, id)
  end
end
function FromClient_CheckStickyMemoFontButton(id, isBold, isItalic, isUnderLine, isDeleteLine)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickySetFontCheckButton(id, isBold, isItalic, isUnderLine, isDeleteLine)
end
function HandleEventLUp_Memo_Main_All_StickyToggleToolBar(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyToggleToolBar(id)
end
function HandleEventLUp_Memo_Main_All_StickySavedColorButton(id)
  if Panel_Window_Memo_Main_All == nil then
    return
  end
  PaGlobal_Memo_All:StickyLUPBeforeColorButton(id)
  if isGameTypeCH() == false then
    FromClient_SaveMemo(PaGlobal_Memo_All._SaveMode.ALL, id)
  end
end
