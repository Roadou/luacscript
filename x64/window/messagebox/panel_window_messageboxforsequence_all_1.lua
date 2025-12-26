function PaGlobal_Window_MessageBoxForSequence_All:initialize()
  if PaGlobal_Window_MessageBoxForSequence_All._initialize == true then
    return
  end
  self._ui._stc_blockBG = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Static_BlockBG")
  self._ui._stc_text = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Static_Text")
  self._ui._txt_static_text_title = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Static_Text_Title")
  self._ui._btn_yes = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Button_Yes")
  self._ui._btn_no = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Button_No")
  self._ui._btn_close = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Button_Close")
  self._ui._multilineText_content = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "StaticText_Content")
  self._ui._multilineText_selectType = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "MultilineText_SelectType")
  self._ui._stc_acceptProgressBar = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Static_Accept_ProgressBar")
  self._ui._stc_progessBG = UI.getChildControl(self._ui._stc_acceptProgressBar, "Static_ProgessBG")
  self._ui._stc_progressBar = UI.getChildControl(self._ui._stc_acceptProgressBar, "Progress2_1")
  self._ui._stc_attributeList = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Static_Attribute_RadioButtonList")
  self._ui._rdo_Attribute_Sun = UI.getChildControl(self._ui._stc_attributeList, "RadioButton_Sun")
  self._ui._rdo_Attribute_Moon = UI.getChildControl(self._ui._stc_attributeList, "RadioButton_Moon")
  self._ui._rdo_Attribute_Land = UI.getChildControl(self._ui._stc_attributeList, "RadioButton_Land")
  self._ui._stc_consoleUI = UI.getChildControl(Panel_Window_MessageBoxForSequence_All, "Static_BottomBg_ConsoleUI")
  self._ui._stc_consoleUI_A = UI.getChildControl(self._ui._stc_consoleUI, "StaticText_A_ConsoleUI")
  self._ui._stc_consoleUI_B = UI.getChildControl(self._ui._stc_consoleUI, "StaticText_B_ConsoleUI")
  self._ui._stc_consoleUI_Y = UI.getChildControl(self._ui._stc_consoleUI, "StaticText_Y_ConsoleUI")
  self._attributeList = {
    [0] = self._ui._rdo_Attribute_Sun,
    [1] = self._ui._rdo_Attribute_Moon,
    [2] = self._ui._rdo_Attribute_Land
  }
  for index = 0, #self._attributeList do
    self._attributeList[index]:SetMonoTone(true)
    self._attributeList[index]:SetAlpha(0.4)
  end
  self._difficultList = {
    [0] = "PANEL_MORNING2_EASY",
    [1] = "PANEL_MORNING2_HARD"
  }
  self._isConsole = true == ToClient_isConsole() or true == _ContentsGroup_UsePadSnapping
  if self._isConsole == true then
    self._ui._stc_consoleUI:SetShow(true)
    self._ui._btn_yes:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_YES_WITHOUT_KEY"))
    self._ui._btn_no:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MESSAGEBOX_BTN_NO_WITHOUT_KEY"))
  else
    self._ui._stc_consoleUI:SetShow(false)
  end
  PaGlobal_Window_MessageBoxForSequence_All:registEventHandler()
  PaGlobal_Window_MessageBoxForSequence_All:validate()
  PaGlobal_Window_MessageBoxForSequence_All._initialize = true
end
function PaGlobal_Window_MessageBoxForSequence_All:registEventHandler()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  for index = 0, #self._attributeList do
    self._attributeList[index]:addInputEvent("Mouse_LUp", "PaGlobal_Window_MessageBoxForSequence_All:setMorningLandBossAttribute( " .. index .. " )")
    self._attributeList[index]:addInputEvent("Mouse_On", "PaGlobal_Window_MessageBoxForSequence_All:SelectAttributeTooltip(true, " .. index .. " )")
    self._attributeList[index]:addInputEvent("Mouse_Out", "PaGlobal_Window_MessageBoxForSequence_All:SelectAttributeTooltip()")
  end
  registerEvent("FromClient_OpenMessageBoxForSequence", "FromClient_OpenMessageBoxForSequence")
  registerEvent("FromClient_RefuseMorningLandBossEnter", "FromClient_RefuseMorningLandBossEnter")
  registerEvent("FromClient_CloseMorningLandBossEnter", "FromClient_CloseMorningLandBossEnter")
  registerEvent("FromClient_WaitTeleportMoringBossEnter", "FromClient_WaitTeleportMoringBossEnter")
  registerEvent("ResponseParty_withdraw", "FromClient_WithdrawPartyMemberMorningBossEnter")
  self._ui._btn_no:addInputEvent("Mouse_LUp", "PaGlobal_Window_MessageBoxForSequence_All:answerMorningLandBossParty( false, false )")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Window_MessageBoxForSequence_All:answerMorningLandBossParty( false, false )")
  self._ui._btn_yes:addInputEvent("Mouse_LUp", "PaGlobal_Window_MessageBoxForSequence_All:answerMorningLandBossParty( true, false )")
end
function PaGlobal_Window_MessageBoxForSequence_All:prepareOpen(elementalBossKey, isHelpUser)
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  local screenSizeX = getScreenSizeX() + 500
  local screenSizeY = getScreenSizeY() + 500
  self._ui._stc_blockBG:SetSize(screenSizeX, screenSizeY)
  self._ui._stc_blockBG:ComputePos()
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(elementalBossKey)
  if morningBossSSW == nil then
    ToClient_AnswerMorningLandBossParty(false, self._currentSelectAttribute)
    return
  end
  local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(elementalBossKey)
  local bossName = characterStaticStatusWarpper:getName()
  local difficulty = PAGetString(Defines.StringSheet_RESOURCE, self._difficultList[morningBossSSW:getLevel()])
  local messageboxMemo = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_START", "bossname", bossName, "difficulty", difficulty)
  if isHelpUser ~= nil and isHelpUser == true then
    messageboxMemo = messageboxMemo .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_HELPUSER_NOTICE")
  end
  self._ui._multilineText_content:SetText(messageboxMemo)
  self._ui._multilineText_selectType:SetSpanSize(0, self._ui._multilineText_content:GetPosY() + self._ui._multilineText_content:GetTextSizeY() + self._MESSAGEBOX_UI_GAP)
  self._ui._multilineText_selectType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_None"))
  self._ui._multilineText_selectType:ComputePos()
  self:calculatePosition()
  Panel_Window_MessageBoxForSequence_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  self._messageDeltaTime = 0
  Panel_Window_MessageBoxForSequence_All:ClearUpdateLuaFunc()
  Panel_Window_MessageBoxForSequence_All:RegisterUpdateFunc("FromClient_MessageBoxForSequence_UpdatePerFrame")
  self._ui._btn_no:SetIgnore(false)
  self._ui._btn_no:SetMonoTone(false)
  self._ui._btn_close:SetIgnore(self._isConsole)
  self._ui._btn_close:SetShow(not self._isConsole)
  self._ui._btn_close:SetMonoTone(false)
  self._ui._btn_yes:SetIgnore(false)
  self._ui._btn_yes:SetMonoTone(false)
  self._ui._rdo_Attribute_Sun:SetIgnore(false)
  self._ui._rdo_Attribute_Moon:SetIgnore(false)
  self._ui._rdo_Attribute_Land:SetIgnore(false)
  self._isAcceptInvite = false
  PaGlobal_Window_MessageBoxForSequence_All:clear()
  if FromClinet_AllCloseFullScreenUI ~= nil then
    FromClinet_AllCloseFullScreenUI()
  end
  PaGlobal_Window_MessageBoxForSequence_All:open()
end
function PaGlobal_Window_MessageBoxForSequence_All:open()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  Panel_Window_MessageBoxForSequence_All:SetShow(true)
end
function PaGlobal_Window_MessageBoxForSequence_All:prepareClose()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  TooltipSimple_Hide()
  PaGlobal_Window_MessageBoxForSequence_All:clear()
  SetUIMode(Defines.UIMode.eUIMode_Default)
  Panel_Window_MessageBoxForSequence_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  PaGlobal_Window_MessageBoxForSequence_All:close()
end
function PaGlobal_Window_MessageBoxForSequence_All:close()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  Panel_Window_MessageBoxForSequence_All:SetShow(false)
end
function PaGlobal_Window_MessageBoxForSequence_All:update()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
end
function PaGlobal_Window_MessageBoxForSequence_All:validate()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  self._ui._stc_blockBG:isValidate()
  self._ui._stc_text:isValidate()
  self._ui._txt_static_text_title:isValidate()
  self._ui._btn_yes:isValidate()
  self._ui._btn_no:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._multilineText_content:isValidate()
  self._ui._stc_acceptProgressBar:isValidate()
  self._ui._stc_progessBG:isValidate()
  self._ui._stc_progressBar:isValidate()
  self._ui._stc_attributeList:isValidate()
  self._ui._rdo_Attribute_Sun:isValidate()
  self._ui._rdo_Attribute_Moon:isValidate()
  self._ui._rdo_Attribute_Land:isValidate()
  self._ui._stc_consoleUI:isValidate()
  self._ui._stc_consoleUI_A:isValidate()
  self._ui._stc_consoleUI_B:isValidate()
  self._ui._stc_consoleUI_Y:isValidate()
end
function PaGlobal_Window_MessageBoxForSequence_All:clear()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  for index = 0, #self._attributeList do
    self._attributeList[index]:SetMonoTone(true)
    self._attributeList[index]:SetAlpha(0.4)
  end
  self._currentSelectAttribute = -1
end
function PaGlobal_Window_MessageBoxForSequence_All:setMorningLandBossAttribute(attributeIndex)
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  if attributeIndex > #self._attributeList then
    return
  end
  for index = 0, #self._attributeList do
    self._attributeList[index]:SetMonoTone(true)
    self._attributeList[index]:SetAlpha(0.4)
  end
  self._attributeList[attributeIndex]:SetAlpha(1)
  self._attributeList[attributeIndex]:SetMonoTone(false)
  self._currentSelectAttribute = attributeIndex
  self._ui._multilineText_selectType:SetPosY(self._ui._multilineText_content:GetPosY() + self._ui._multilineText_content:GetTextSizeY() + 15)
  local selectTypeMSG
  if attributeIndex == 0 then
    selectTypeMSG = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_SUN")
    self._ui._multilineText_selectType:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE", "selectType", selectTypeMSG))
  elseif attributeIndex == 1 then
    selectTypeMSG = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_MOON")
    self._ui._multilineText_selectType:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE", "selectType", selectTypeMSG))
  elseif attributeIndex == 2 then
    selectTypeMSG = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_LAND")
    self._ui._multilineText_selectType:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE", "selectType", selectTypeMSG))
  else
    self._ui._multilineText_selectType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_None"))
  end
end
function PaGlobal_Window_MessageBoxForSequence_All:SelectAttributeTooltip(isShow, index)
  if isShow == nil then
    TooltipSimple_Hide()
    return
  end
  local name, desc, control
  if index == 0 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_SUN")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_SUN_TOOLTIP")
  elseif index == 1 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_MOON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_MOON_TOOLTIP")
  elseif index == 2 then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_LAND")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_MORNINGLANDBOSSSELECTTYPE_LAND_TOOLTIP")
  end
  control = self._attributeList[index]
  TooltipSimple_Show(control, name, desc, false)
end
function PaGlobal_Window_MessageBoxForSequence_All:answerMorningLandBossParty(isEnter, isTimeOut)
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  if isEnter == true then
    if self._currentSelectAttribute == -1 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_BLACKSHRINE_SELECTATTRIBUTE"))
      return
    end
    if self._isAcceptInvite == false then
      self._isAcceptInvite = true
      self._ui._btn_no:SetIgnore(true)
      self._ui._btn_no:SetMonoTone(true)
      self._ui._btn_close:SetShow(self._isConsole == false)
      self._ui._btn_close:SetIgnore(true)
      self._ui._btn_close:SetMonoTone(true)
      self._ui._btn_yes:SetIgnore(true)
      self._ui._btn_yes:SetMonoTone(true)
      self._ui._rdo_Attribute_Sun:SetIgnore(true)
      self._ui._rdo_Attribute_Moon:SetIgnore(true)
      self._ui._rdo_Attribute_Land:SetIgnore(true)
      ToClient_AnswerMorningLandBossParty(true, self._currentSelectAttribute, isTimeOut)
    end
    SetUIMode(Defines.UIMode.eUIMode_EnterMorningLandPartyBoss)
  else
    ToClient_AnswerMorningLandBossParty(false, self._currentSelectAttribute, isTimeOut)
    PaGlobalFunc_MessageBoxForSequence_All_Close()
  end
end
function PaGlobal_Window_MessageBoxForSequence_All:calculatePosition()
  if Panel_Window_MessageBoxForSequence_All == nil then
    return
  end
  local textBoxSize = self._ui._multilineText_content:GetTextSizeY() - self._MESSAGEBOX_CONTENT_TEXTSIZE_Y
  if textBoxSize < 0 then
    textBoxSize = 0
  end
  Panel_Window_MessageBoxForSequence_All:SetSize(450, self._MESSAGEBOX_ORIGINAL_SIZE_Y + textBoxSize)
  Panel_Window_MessageBoxForSequence_All:ComputePos()
  self._ui._btn_no:ComputePos()
  self._ui._btn_close:ComputePos()
  self._ui._btn_yes:ComputePos()
  self._ui._stc_attributeList:ComputePos()
  self._ui._stc_acceptProgressBar:ComputePos()
  self._ui._stc_consoleUI:ComputePos()
end
