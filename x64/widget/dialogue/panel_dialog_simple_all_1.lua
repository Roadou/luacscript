function PaGlobal_Dialog_Simple_All:initialize()
  if true == PaGlobal_Dialog_Simple_All._initialize then
    return
  end
  if nil == Panel_Dialog_Simple_All then
    return
  end
  self._ui.stc_mainbg = UI.getChildControl(Panel_Dialog_Simple_All, "Static_MainBG")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_mainbg, "Static_TitleBG")
  self._ui.txt_npcName = UI.getChildControl(self._ui.stc_title, "StaticText_NPC_Name")
  self._ui.txt_contentDesc = UI.getChildControl(self._ui.stc_title, "StaticText_MainDialog")
  self._ui.btn_template = UI.getChildControl(self._ui.stc_title, "Button_Function")
  self._ui.btn_template:SetShow(false)
  for ii = 1, self._btnMaxCount do
    self._uiBtnList[ii] = UI.cloneControl(self._ui.btn_template, self._ui.stc_title, "Button_FunctionButton_" .. ii)
    self._uiBtnList[ii]:SetShow(false)
  end
  PaGlobal_Dialog_Simple_All:registEventHandler()
  PaGlobal_Dialog_Simple_All:validate()
  PaGlobal_Dialog_Simple_All._initialize = true
end
function PaGlobal_Dialog_Simple_All:registEventHandler()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  registerEvent("FromClient_ShowSimpleDialog", "PaGlobal_Dialog_Simple_All_Open")
  registerEvent("FromClient_HideSimpleDialog", "PaGlobal_Dialog_Simple_All_Close")
  registerEvent("onScreenResize", "PaGlobal_Dialog_Simple_All_OnScreenSizeRefresh")
  Panel_Dialog_Simple_All:RegisterUpdateFunc("PaGlobal_Dialog_Simple_All_UpdatePerFrame")
end
function PaGlobal_Dialog_Simple_All:prepareOpen()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  for ii = 1, self._btnMaxCount do
    self._uiBtnList[ii]:SetShow(false)
  end
  if true == PaGlobal_QAServantSupportOn then
    return
  end
  if true == isMoviePlayMode() then
    return
  end
  PaGloalFunc_DialogMain_All_PreClosePanel()
  local dialogData = ToClient_GetCurrentDialogData()
  dialogData:setDefaultMainDialog()
  local npcTitle = dialogData:getContactNpcTitle()
  local npcName = dialogData:getContactNpcName()
  self._ui.txt_npcName:SetText(npcTitle .. npcName)
  PaGlobal_Dialog_Simple_All_SetNpcDialogReset()
  local talkIndex
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    return
  end
  local funcBtnCount = dialogData:getFuncButtonCount()
  if funcBtnCount <= 0 then
  end
  local funcButton, funcButtonType
  for index = 0, funcBtnCount - 1 do
    funcButton = dialogData:getFuncButtonAt(index)
    if nil == funcButton then
      return
    end
    funcButtonType = tonumber(funcButton._param)
    if CppEnums.ContentsType.Contents_Talk == funcButtonType then
      talkIndex = index
      break
    end
  end
  if nil == talkIndex then
    self._uiBtnList[self._dialogIndex.TALK]:SetShow(false)
  else
    self._uiBtnList[self._dialogIndex.TALK]:SetShow(true)
  end
  local funcButton = dialogData:getFuncButtonAt(talkIndex)
  if nil ~= funcButton then
    local btnText = funcButton:getText()
    self._uiBtnList[self._dialogIndex.TALK]:SetText(btnText)
    self._uiBtnList[self._dialogIndex.TALK]:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogSimple_All_FuncButton(" .. talkIndex .. ")")
    self._templetSpanX = self._uiBtnList[self._dialogIndex.TALK]:GetSpanSize().x
    self._templetSpanY = self._uiBtnList[self._dialogIndex.TALK]:GetSpanSize().y
  end
  local nDlgButtoncount = dialogData:getDialogButtonCount()
  if nDlgButtoncount == 1 then
    local dialogButtonLink = dialogData:getDialogButtonAt(0)
    local btnText = dialogButtonLink:getText()
    local btnIndex = 0
    self._uiBtnList[self._dialogIndex.TALK + 1]:SetText(btnText)
    self._uiBtnList[self._dialogIndex.TALK + 1]:SetShow(false)
    self._uiBtnList[self._dialogIndex.TALK + 1]:addInputEvent("Mouse_LUp", "Dialog_clickDialogSimpleButtonReq(" .. btnIndex .. ")")
  else
    for i = 0, nDlgButtoncount - 1 do
      local dialogButtonLink = dialogData:getDialogButtonAt(i)
      local btnText = dialogButtonLink:getText()
      self._uiBtnList[self._dialogIndex.TALK + 1 + i]:SetText(btnText)
      self._uiBtnList[self._dialogIndex.TALK + 1 + i]:SetShow(false)
      self._uiBtnList[self._dialogIndex.TALK + 1 + i]:SetSpanSize(self._templetSpanX, self._templetSpanY + 30 * i)
      self._uiBtnList[self._dialogIndex.TALK + 1 + i]:addInputEvent("Mouse_LUp", "Dialog_clickDialogSimpleButtonReq(" .. i .. ")")
    end
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local startPosX = screenSizeX - Panel_Dialog_Simple_All:GetSizeX()
  if screenSizeY <= 800 then
    Panel_Dialog_Simple_All:SetPosY(screenSizeY / 2 - Panel_Dialog_Simple_All:GetSizeY() / 2 - 30)
  else
    Panel_Dialog_Simple_All:SetPosY(screenSizeY / 2 - Panel_Dialog_Simple_All:GetSizeY() / 2 - 100)
  end
  Panel_Dialog_Simple_All:ComputePos()
  SetUIMode(Defines.UIMode.eUIMode_NpcSimpleDialog)
  PaGlobal_Dialog_Simple_All:open()
end
function PaGlobal_Dialog_Simple_All:open()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  Panel_Dialog_Simple_All:SetShow(true)
end
function PaGlobal_Dialog_Simple_All:prepareClose()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  if false == _ContentsGroup_UsePadSnapping and nil ~= Panel_SkillCommand then
    if FGlobal_IsChecked_SkillCommand() == true then
      PaGlobal_SkillGuide_Open()
      changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, true, true, false)
    else
      Panel_SkillCommand:SetShow(false)
      changePositionBySever(Panel_SkillCommand, CppEnums.PAGameUIType.PAGameUIPanel_SkillCommand, true, true, false)
    end
  end
  PaGlobalFunc_DialogMain_All_ResetRenderMode()
  if getTutorialQuestNo ~= nil then
    local questNo = getTutorialQuestNo()
    if -1 == questNo then
      setTutorialQuestNo(-1)
    elseif 0 ~= questNo then
      Tutorial_Quest(questNo)
      setTutorialQuestNo(0)
    else
      setTutorialQuestNo(-1)
    end
  end
  if false == _ContentsGroup_RemasterUI_Main_Alert and Panel_NewEquip_EffectLastUpdate ~= nil then
    Panel_NewEquip_EffectLastUpdate()
  end
  if nil == isSetWait then
    isSetWait = true
  end
  Dialog_clickExitReq(isSetWait)
  ToClient_PopDialogueFlush()
  ToClient_AudioPostEvent_UIAudioStateEvent("UISTATE_CLOSE_DEFAULT")
  PaGlobal_Dialog_SimpleDesc_All_Close()
  PaGlobal_Dialog_Simple_All:close()
end
function PaGlobal_Dialog_Simple_All:close()
  if nil == Panel_Dialog_Simple_All then
    return
  end
  Panel_Dialog_Simple_All:SetShow(false)
end
function PaGlobal_Dialog_Simple_All:validate()
  if nil == Panel_Dialog_Simple_All then
    return
  end
end
function PaGlobal_Dialog_Simple_All:setTranslationKey(localizedType, LocalizedKey)
  if nil == LocalizedKey then
    return
  end
  self._ui.txt_contentDesc:setLocalizedStaticType(localizedType)
  self._ui.txt_contentDesc:setLocalizedKey(LocalizedKey)
end
