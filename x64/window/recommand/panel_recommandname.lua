local IM = CppEnums.EProcessorInputMode
local HelpMailType = {
  eHelpMailType_Repay = 0,
  eHelpMailType_Thanks = 1,
  eHelpMailType_ValentineNot1 = 2,
  eHelpMailType_ValentineNot2 = 3,
  eHelpMailType_Valentine = 4,
  eHelpMailType_Event1 = 5,
  eHelpMailType_Event2 = 6,
  eHelpMailType_Event3 = 7,
  eHelpMailType_Event4 = 8,
  eHelpMailType_Event5 = 9,
  eHelpMailType_Event6 = 10
}
local _helpMailType = HelpMailType.eHelpMailType_Thanks
PaGlobal_SendMailForHelp = {
  _ui = {
    stc_titleBg = nil,
    stc_title = nil,
    btn_close = nil,
    btn_apply = nil,
    btn_cancle = nil,
    edit_name = nil,
    txt_contentHelper = nil,
    txt_warning = nil,
    stc_illust = nil
  },
  _ui_console = {stc_editKeyGuide = nil, stc_bottomKeyGuideBg = nil}
}
function PaGlobal_SendMailForHelp:initialize()
  if nil == Panel_RecommandName then
    return
  end
  self._ui.stc_titleBg = UI.getChildControl(Panel_RecommandName, "Static_TitleBg")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_titleBg, "StaticText_Title")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_Win_Close")
  self._ui.btn_apply = UI.getChildControl(Panel_RecommandName, "Button_Apply")
  self._ui.btn_cancle = UI.getChildControl(Panel_RecommandName, "Button_Cancel")
  self._ui.edit_name = UI.getChildControl(Panel_RecommandName, "Edit_Nickname")
  self._ui.txt_contentHelper = UI.getChildControl(Panel_RecommandName, "StaticText_ToRecommander")
  self._ui.txt_warning = UI.getChildControl(Panel_RecommandName, "StaticText_Warnning")
  self._ui.stc_illust = UI.getChildControl(Panel_RecommandName, "Static_Illust")
  self._ui_console.stc_editKeyGuide = UI.getChildControl(self._ui.edit_name, "Static_X_ConsoleUI")
  self._ui_console.stc_bottomKeyGuideBg = UI.getChildControl(Panel_RecommandName, "Static_BottomBg_ConsoleUI")
  self._ui.txt_warning:SetTextMode(__eTextMode_AutoWrap)
  self._ui.edit_name:SetTextMode(__eTextMode_LimitText)
  self._ui.edit_name:SetMaxInput(getGameServiceTypeCharacterNameLength())
  self._ui.btn_close:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.btn_apply:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui.btn_cancle:SetShow(not _ContentsGroup_UsePadSnapping)
  self._ui_console.stc_editKeyGuide:SetShow(_ContentsGroup_UsePadSnapping)
  self._ui_console.stc_bottomKeyGuideBg:SetShow(_ContentsGroup_UsePadSnapping)
  if true == _ContentsGroup_UsePadSnapping then
    self._ui.txt_warning:SetSpanSize(self._ui.txt_warning:GetSpanSize().x, self._ui.edit_name:GetSpanSize().y)
    self._ui.edit_name:SetSpanSize(self._ui.edit_name:GetSpanSize().x, self._ui.btn_apply:GetSpanSize().y)
    local keyGuide_confirm = UI.getChildControl(self._ui_console.stc_bottomKeyGuideBg, "StaticText_A_ConsoleUI")
    local keyGuide_cancle = UI.getChildControl(self._ui_console.stc_bottomKeyGuideBg, "StaticText_B_ConsoleUI")
    local keyGuides = {keyGuide_confirm, keyGuide_cancle}
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui_console.stc_bottomKeyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self._ui.edit_name:addInputEvent("Mouse_LUp", "PaGlobal_SendMailForHelp:clearEdit()")
  self._ui.edit_name:addInputEvent("Mouse_On", "PaGlobal_SendMailForHelp:EditToolTip(true)")
  self._ui.edit_name:addInputEvent("Mouse_Out", "PaGlobal_SendMailForHelp:EditToolTip(false)")
  self:registEventHandler()
end
function PaGlobal_SendMailForHelp:clearEdit()
  self._ui.edit_name:SetEditText("")
end
function PaGlobal_SendMailForHelp:EditToolTip(isShow)
  if isShow == true then
    TooltipSimple_Show(self._ui.edit_name, "", PAGetString(Defines.StringSheet_GAME, "LUA_VALENTINE_EDITBOX_GUIDE_DESC"))
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_SendMailForHelp:registEventHandler()
  if nil == Panel_RecommandName then
    return
  end
  Panel_RecommandName:SetShow(false, false)
  Panel_RecommandName:setGlassBackground(true)
  Panel_RecommandName:ActiveMouseEventEffect(true)
  Panel_RecommandName:setMaskingChild(true)
  if true == _ContentsGroup_UsePadSnapping then
    Panel_RecommandName:registerPadEvent(__eConsoleUIPadEvent_A, "HandleClicked_SendMailForHelp()")
    Panel_RecommandName:registerPadEvent(__eConsoleUIPadEvent_X, "HandlePadEvent_SendMAilForHelp_FocusEditBox()")
    Panel_RecommandName:ignorePadSnapMoveToOtherPanel()
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "FGlobal_SendMailForHelpClose()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleClicked_SendMailForHelp()")
    self._ui.btn_cancle:addInputEvent("Mouse_LUp", "FGlobal_SendMailForHelpClose()")
  end
end
function HandleClicked_SendMailForHelp()
  if nil == Panel_RecommandName then
    return
  end
  local content = PaGlobal_SendMailForHelp._ui.txt_contentHelper:GetText()
  local title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECOMMANDGIFT")
  if _helpMailType == HelpMailType.eHelpMailType_Thanks then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECOMMANDGIFT")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDMAIL2")
  elseif _helpMailType == HelpMailType.eHelpMailType_Repay then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECOMMANDGIFT")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDMAIL1")
  elseif _helpMailType == HelpMailType.eHelpMailType_Valentine then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE_TITLE")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE_DESC")
  elseif _helpMailType == HelpMailType.eHelpMailType_Event1 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_TITLE1")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_CONTENT1")
  elseif _helpMailType == HelpMailType.eHelpMailType_Event2 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_TITLE2")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_CONTENT2")
  elseif _helpMailType == HelpMailType.eHelpMailType_Event3 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_TITLE3")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_CONTENT3")
  elseif _helpMailType == HelpMailType.eHelpMailType_Event4 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_TITLE4")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_CONTENT4")
  elseif _helpMailType == HelpMailType.eHelpMailType_Event5 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_TITLE5")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_CONTENT5")
  elseif _helpMailType == HelpMailType.eHelpMailType_Event6 then
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_TITLE6")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GET_CONTENT6")
  else
    title = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE")
    content = PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDMAIL_BALENTINE")
  end
  ToClient_SendMailForHelp(PaGlobal_SendMailForHelp._ui.edit_name:GetEditText(), title, content)
  Panel_RecommandName:SetShow(false, false)
  PaGlobal_SendMailForHelp._ui.edit_name:SetEditText("", true)
  ClearFocusEdit()
  CheckChattingInput()
end
function HandlePadEvent_SendMAilForHelp_FocusEditBox()
  if nil == Panel_RecommandName then
    return
  end
  SetFocusEdit(PaGlobal_SendMailForHelp._ui.edit_name)
end
function FromClient_SendMailForHelp(helpMailType)
  Panel_RecommandName:SetShow(true, false)
  _helpMailType = helpMailType
  PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetShow(true)
  PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetTextMode(__eTextMode_AutoWrap)
  PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECOMMAND_BTN"))
  if _helpMailType == HelpMailType.eHelpMailType_Thanks then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_TONEWBIE"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_THANKSGIFTMAIL"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_EDITCHARACTERNAME"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Repay then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_TORECOMMANDER"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_PAYMAIL"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_EDITCHARACTERNAME"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Valentine then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE_SENDER_DESC"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE_SENDER_TITLE"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_EDITCHARACTERNAME"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "MAIL_SEND_BTN_SEND"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Event1 then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT1"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_TITLE1"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT_RED1"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN1"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Event2 then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT2"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_TITLE2"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT_RED2"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN2"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Event3 then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT3"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_TITLE3"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT_RED3"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN3"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Event4 then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT4"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_TITLE4"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT_RED4"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN4"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Event5 then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT5"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_TITLE5"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT_RED5"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN5"))
  elseif _helpMailType == HelpMailType.eHelpMailType_Event6 then
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT6"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_TITLE6"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_CONTENT_RED6"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN6"))
  else
    PaGlobal_SendMailForHelp._ui.txt_contentHelper:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_BALENTINEMAIL"))
    PaGlobal_SendMailForHelp._ui.stc_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_BALENTINEMAIL"))
    PaGlobal_SendMailForHelp._ui.txt_warning:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_EDITCHARACTERNAME"))
    PaGlobal_SendMailForHelp._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SEND_BTN"))
  end
  PaGlobal_SendMailForHelp._ui.edit_name:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VALENTINE_EDITBOX_GUIDE_DESC"))
end
function FromClient_SendMailForHelpComplete(isSender, helpMailType)
  if helpMailType == HelpMailType.eHelpMailType_Thanks then
    if isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_COMPLETE"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GETRECOMMAND"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Repay then
  elseif helpMailType == HelpMailType.eHelpMailType_Valentine then
    if isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE_COMPLETE"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_VALENTINE_GETCOMPLETE"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Event1 then
    if true == isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDER_MESSAGE1"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECEIVER_MESSAGE1"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Event2 then
    if true == isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDER_MESSAGE2"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECEIVER_MESSAGE2"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Event3 then
    if true == isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDER_MESSAGE3"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECEIVER_MESSAGE3"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Event4 then
    if true == isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDER_MESSAGE4"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECEIVER_MESSAGE4"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Event5 then
    if true == isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDER_MESSAGE5"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECEIVER_MESSAGE5"))
    end
  elseif helpMailType == HelpMailType.eHelpMailType_Event6 then
    if true == isSender then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDER_MESSAGE6"))
    else
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_RECEIVER_MESSAGE6"))
    end
  elseif isSender then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_SENDCOMPLETE_BALENTINE"))
  else
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_RECOMMANDNAME_GETBALENTINE"))
  end
end
function FGlobal_SendMailForHelpClose()
  Panel_RecommandName:SetShow(false, false)
  PaGlobal_SendMailForHelp._ui.edit_name:SetEditText("", true)
  ClearFocusEdit()
  CheckChattingInput()
end
function FromClient_SendMailForHelp_Init()
  PaGlobal_SendMailForHelp:initialize()
end
registerEvent("FromClient_luaLoadComplete", "FromClient_SendMailForHelp_Init")
registerEvent("FromClient_SendMailForHelp", "FromClient_SendMailForHelp")
registerEvent("FromClient_SendMailForHelpComplete", "FromClient_SendMailForHelpComplete")
