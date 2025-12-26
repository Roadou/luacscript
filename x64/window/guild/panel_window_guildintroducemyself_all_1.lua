function PaGlobal_GuildIntroduceMySelf_All:initialize()
  if true == PaGlobal_GuildIntroduceMySelf_All._initialize then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Guild_IntroduceMySelf, "Static_TitleArea")
  self._ui.btn_titleClose = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_mainArea = UI.getChildControl(Panel_Guild_IntroduceMySelf, "Static_MainArea")
  self._ui.btn_apply = UI.getChildControl(self._ui.stc_mainArea, "Button_Apply")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_mainArea, "Button_Close")
  self._ui.txt_edit = UI.getChildControl(self._ui.stc_mainArea, "MultilineEdit_NoticeSquare")
  self._ui.txt_editCover = UI.getChildControl(self._ui.stc_mainArea, "MultilineEdit_CoverBox")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_mainArea, "StaticText_Desc")
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_Guild_IntroduceMySelf, "Static_KeyGuide_ConsoleUI")
  self._ui.stc_keyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_keyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_keyGuide_X = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_X_ConsoleUI")
  self._ui.stc_keyGuide_Y = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_Y_ConsoleUI")
  self.keyguide = {
    self._ui.stc_keyGuide_A,
    self._ui.stc_keyGuide_Y,
    self._ui.stc_keyGuide_X,
    self._ui.stc_keyGuide_B
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(self._ui.txt_desc:GetText())
  PaGlobal_GuildIntroduceMySelf_All:switchPlatform(self._isConsole)
  PaGlobal_GuildIntroduceMySelf_All:registEventHandler()
  if self._isConsole == true then
    Panel_Guild_IntroduceMySelf:SetSize(Panel_Guild_IntroduceMySelf:GetSizeX(), Panel_Guild_IntroduceMySelf:GetSizeY() - 50)
    self._ui.stc_KeyGuide_Bg:SetPosY(self._ui.stc_KeyGuide_Bg:GetPosY() - 50)
  end
  PaGlobal_GuildIntroduceMySelf_All:validate()
  PaGlobal_GuildIntroduceMySelf_All._initialize = true
end
function PaGlobal_GuildIntroduceMySelf_All:switchPlatform(isConsole)
  self._ui.stc_KeyGuide_Bg:SetShow(isConsole)
  self._ui.btn_titleClose:SetShow(not isConsole)
  self._ui.btn_apply:SetShow(not isConsole)
  self._ui.btn_close:SetShow(not isConsole)
end
function PaGlobal_GuildIntroduceMySelf_All:registEventHandler()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  self._ui.btn_titleClose:addInputEvent("Mouse_LUp", "PaGlobal_GuildIntroduceMySelf_Close()")
  self._ui.txt_editCover:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIntroduceMySelf_EditName()")
end
function PaGlobal_GuildIntroduceMySelf_All:prepareOpen(category, index, isSearchList)
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  self._isSearchList = isSearchList
  if isGameTypeTaiwan() then
    self._ui.txt_edit:SetMaxEditLine(7)
  else
    self._ui.txt_edit:SetMaxEditLine(10)
  end
  self._ui.txt_edit:SetMaxInput(200)
  if nil == category then
    self._ui.txt_edit:SetEditText("")
    self._category = nil
    self._index = index
    self._ui.txt_desc:SetShow(false)
    self._ui.txt_editCover:SetIgnore(true)
    self._ui.txt_editCover:addInputEvent("Mouse_LUp", "")
    self._ui.stc_keyGuide_Y:SetShow(false)
    self._ui.stc_keyGuide_B:SetShow(false)
    PaGlobal_GuildIntroduceMySelf_All:update()
    self._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_GUILD"))
    self._ui.btn_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_APPLYJOIN_EXCEPT"))
    self._ui.stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "INTERACTION_BTN_GUILD"))
    self._ui.stc_keyGuide_X:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_APPLYJOIN_EXCEPT"))
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIntroduceMySelf_DeleteApplicant()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIntroduceMySelf_InviteGuild()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_GuildIntroduceMySelf_InviteGuild()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildIntroduceMySelf_DeleteApplicant()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_B, "")
    self.keyguide = {
      self._ui.stc_keyGuide_A,
      self._ui.stc_keyGuide_X
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  else
    self._category = category
    self._index = index
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_APPLY_INTRODUCE_EDIT_TXT"))
    self._ui.txt_edit:SetEditText("")
    self._ui.txt_editCover:SetIgnore(false)
    self._ui.txt_editCover:addInputEvent("Mouse_LUp", "PaGlobalFunc_GuildIntroduceMySelf_EditName()")
    self._ui.btn_apply:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_APPLY_CONFIRM"))
    self._ui.btn_close:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    self._ui.stc_keyGuide_A:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_APPLY_CONFIRM"))
    self._ui.stc_keyGuide_B:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
    self._ui.stc_keyGuide_X:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MUSICLIST_EDIT"))
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_GuildIntroduceMySelf_Close()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_PaGlobal_GuildIntroduceMySelf_Apply()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "PaGlobalFunc_GuildIntroduceMySelf_EditName()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobalFunc_GuildIntroduceMySelf_EditName()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleEventLUp_PaGlobal_GuildIntroduceMySelf_Apply()")
    Panel_Guild_IntroduceMySelf:registerPadEvent(__eConsoleUIPadEvent_Up_B, "PaGlobal_GuildIntroduceMySelf_Close()")
    self.keyguide = {
      self._ui.stc_keyGuide_A,
      self._ui.stc_keyGuide_Y,
      self._ui.stc_keyGuide_X,
      self._ui.stc_keyGuide_B
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(self.keyguide, self._ui.stc_KeyGuide_Bg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  PaGlobal_GuildIntroduceMySelf_All:open()
end
function PaGlobal_GuildIntroduceMySelf_All:open()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  Panel_Guild_IntroduceMySelf:SetShow(true)
end
function PaGlobal_GuildIntroduceMySelf_All:prepareClose()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  self._category = nil
  self._index = nil
  ClearFocusEdit()
  CheckChattingInput()
  PaGlobal_GuildIntroduceMySelf_All:close()
end
function PaGlobal_GuildIntroduceMySelf_All:close()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  Panel_Guild_IntroduceMySelf:SetShow(false)
end
function PaGlobal_GuildIntroduceMySelf_All:update()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  if nil == self._category then
    local applicantInfoWrapper = ToClient_getGuildApplicantInfoWrapper(self._index)
    if nil == applicantInfoWrapper then
      return
    end
    self._ui.txt_edit:SetTextMode(__eTextMode_AutoWrap)
    self._ui.txt_edit:SetText(applicantInfoWrapper:getIntroduction())
  end
end
function PaGlobal_GuildIntroduceMySelf_All:validate()
  if nil == Panel_Guild_IntroduceMySelf then
    return
  end
  self._ui.stc_titleArea:isValidate()
  self._ui.btn_titleClose:isValidate()
  self._ui.stc_mainArea:isValidate()
  self._ui.btn_apply:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.txt_edit:isValidate()
  self._ui.txt_editCover:isValidate()
end
