function PaGlobal_Dialog_Simple_All_Open()
  PaGlobal_Dialog_Simple_All:prepareOpen()
end
function PaGlobal_Dialog_Simple_All_Close()
  PaGlobal_Dialog_Simple_All:prepareClose()
end
function FromClient_Dialog_Simple_All_ShowDialog()
  PaGlobal_Dialog_Simple_All_Open()
end
function PaGlobal_Dialog_Simple_All_SetNpcDialogReset()
  local dialogData = ToClient_GetCurrentDialogData()
  dialogData:setDefaultMainDialog()
  local mainDialog = dialogData:getMainDialog()
  PaGlobal_Dialog_Simple_All._mainDialog = {}
  PaGlobal_Dialog_Simple_All._maxLine = 0
  PaGlobal_Dialog_Simple_All._curLine = 0
  local stringList = string.split(mainDialog, "\n")
  local i = 0
  local strFirst, strSecond
  while true do
    strFirst = stringList[i * 2 + 1]
    strSecond = stringList[i * 2 + 2]
    if strFirst ~= nil and strSecond ~= nil then
      PaGlobal_Dialog_Simple_All._mainDialog[i] = strFirst .. "\n" .. strSecond
    elseif strFirst == nil then
      break
    elseif strSecond == nil then
      PaGlobal_Dialog_Simple_All._mainDialog[i] = strFirst
      break
    end
    i = i + 1
  end
  PaGlobal_Dialog_Simple_All._maxLine = #PaGlobal_Dialog_Simple_All._mainDialog
  if nil == PaGlobal_Dialog_Simple_All._mainDialog[PaGlobal_Dialog_Simple_All._curLine] then
    return
  end
  local realDialog = ToClient_getReplaceDialog(PaGlobal_Dialog_Simple_All._mainDialog[PaGlobal_Dialog_Simple_All._curLine])
  local dialogData = ToClient_GetCurrentDialogData()
  local funcBtnCount = dialogData:getFuncButtonCount()
  local localizedType = dialogData:getLocalizedTypeForLua()
  local mainDialogLocalizedKey = dialogData:getMainDialogLocalizedKey()
  PaGlobal_Dialog_Simple_All:setTranslationKey(localizedType, mainDialogLocalizedKey)
  PaGlobal_Dialog_Simple_All._ui.txt_contentDesc:SetText(realDialog)
end
function HandleEventLUp_DialogSimple_All_FuncButton(index, isType)
  if nil == Panel_Dialog_Simple_All then
    return
  end
  if true == MessageBoxGetShow() then
    return
  end
  if nil == index then
    return
  end
  if nil == isType then
    isType = false
  end
  PaGlobal_Dialog_Simple_All._uiBtnList[PaGlobal_Dialog_Simple_All._dialogIndex.TALK]:SetShow(false)
  local dialogData = ToClient_GetCurrentDialogData()
  local nDlgButtoncount = dialogData:getDialogButtonCount()
  if nDlgButtoncount == 1 then
    PaGlobal_Dialog_Simple_All._uiBtnList[PaGlobal_Dialog_Simple_All._dialogIndex.TALK + 1]:SetShow(true)
  else
    for i = 0, nDlgButtoncount - 1 do
      if nil ~= PaGlobal_Dialog_Simple_All._uiBtnList[PaGlobal_Dialog_Simple_All._dialogIndex.TALK + 1 + i] then
        PaGlobal_Dialog_Simple_All._uiBtnList[PaGlobal_Dialog_Simple_All._dialogIndex.TALK + 1 + i]:SetShow(true)
      end
    end
  end
end
function PaGlobalFunc_DialogSimple_Hide()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  Panel_Dialog_Simple_All:SetShow(false)
end
function PaGlobalFunc_DialogSimple_Show()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  Panel_Dialog_Simple_All:SetShow(true)
end
function PaGlobal_Dialog_Simple_Interaction()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  if PaGlobal_Dialog_Simple_All._uiBtnList[PaGlobal_Dialog_Simple_All._dialogIndex.TALK]:GetShow() == true then
    HandleEventLUp_DialogSimple_All_FuncButton(0)
  else
    Dialog_clickDialogSimpleButtonReq(0)
  end
end
function PaGlobal_Dialog_Simple_All_UpdatePerFrame(deltaTime)
  if deltaTime <= 0 then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return
  end
  ToClient_CheckDistanceSimpleDialogNpc()
end
function PaGlobal_Dialog_Simple_All_OnScreenSizeRefresh()
  Panel_Dialog_Simple_All:ComputePos()
end
