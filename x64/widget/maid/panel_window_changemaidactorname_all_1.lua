function PaGlobal_ChangeMaidActorName:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_blackBg = UI.getChildControl(Panel_Window_ChangeMaidActorName_All, "Static_BlackBG")
  self._ui.stc_titleBg = UI.getChildControl(Panel_Window_ChangeMaidActorName_All, "Static_TitleBG")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBg, "Button_CloseButton_PC")
  self._ui.btn_close:SetShow(self._isConsole == false)
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_ChangeMaidActorName_All, "Static_MainBG")
  self._ui.edt_name = UI.getChildControl(self._ui.stc_mainBg, "Edit_Name")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Description")
  self._ui.txt_desc:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_CUSTOM_MAID_REGISTER_DESC", "min", tostring(getGameServiceTypeNameMinLength()), "max", ToClient_GetMaidActorNameLengthMax()))
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.edt_name:SetSpanSize(0, 20)
  self._ui.edt_name:ComputePos()
  self._ui.txt_desc:SetSpanSize(0, self._ui.edt_name:GetSpanSize().y + self._ui.edt_name:GetSizeY() + 10)
  self._ui.txt_desc:ComputePos()
  self._ui.stc_mainBg:SetSize(self._ui.stc_mainBg:GetSizeX(), self._ui.txt_desc:GetSpanSize().y + self._ui.txt_desc:GetSizeY() + 20)
  self._ui.stc_mainBg:ComputePos()
  self._ui.stc_buttonBg = UI.getChildControl(Panel_Window_ChangeMaidActorName_All, "Static_ButtonGroup")
  self._ui.btn_apply = UI.getChildControl(self._ui.stc_buttonBg, "Button_Yes")
  self._ui.btn_cancel = UI.getChildControl(self._ui.stc_buttonBg, "Button_No")
  self._ui.stc_buttonBg:SetShow(self._isConsole == false)
  self._ui.stc_keyGuideBg = UI.getChildControl(Panel_Window_ChangeMaidActorName_All, "Static_KeyGuide_Console")
  self._ui.stc_keyGuideBg:SetShow(self._isConsole)
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_Select_Console")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyGuideBg, "StaticText_Exit_Console")
  self._ui.stc_keyGuideX = UI.getChildControl(self._ui.edt_name, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui.stc_keyGuideA:SetShow(self._isConsole)
  self._ui.stc_keyGuideB:SetShow(self._isConsole)
  self._ui.stc_keyGuideX:SetShow(self._isConsole)
  local panelSizeY = self._ui.stc_mainBg:GetSpanSize().y + self._ui.stc_mainBg:GetSizeY() + self._ui.stc_buttonBg:GetSizeY()
  Panel_Window_ChangeMaidActorName_All:SetSize(Panel_Window_ChangeMaidActorName_All:GetSizeX(), panelSizeY)
  Panel_Window_ChangeMaidActorName_All:ComputePosAllChild()
  if self._isConsole == true then
    Panel_Window_ChangeMaidActorName_All:SetSize(Panel_Window_ChangeMaidActorName_All:GetSizeX(), Panel_Window_ChangeMaidActorName_All:GetSizeY() - self._ui.stc_buttonBg:GetSizeY())
    Panel_Window_ChangeMaidActorName_All:ComputePosAllChild()
    local keyGuideList = Array.new()
    keyGuideList:push_back(self._ui.stc_keyGuideA)
    keyGuideList:push_back(self._ui.stc_keyGuideB)
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui.stc_keyGuideBg, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  end
  self:registEventHandler()
  self._initialize = true
end
function PaGlobal_ChangeMaidActorName:registEventHandler()
  if Panel_Window_ChangeMaidActorName_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Window_ChangeMaidActorName_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "HandleLUp_ChangeMaidActorName_DoRequest()")
    Panel_Window_ChangeMaidActorName_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventUpX_ChangeMaidActorName_InputEditMode()")
  else
    self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChangeMaidActorName_Close()")
    self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleLUp_ChangeMaidActorName_DoRequest()")
    self._ui.btn_cancel:addInputEvent("Mouse_LUp", "PaGlobalFunc_ChangeMaidActorName_Close()")
  end
  self._ui.edt_name:SetMaxInput(ToClient_GetMaidActorNameLengthMax())
  self._ui.edt_name:RegistReturnKeyEvent("HandleLUp_ChangeMaidActorName_DoRequest()")
  registerEvent("FromClient_MaidActorEvent", "FromClient_ChangeMaidActorName_MaidActorEvent")
end
function PaGlobal_ChangeMaidActorName:prepareOpen(maidNo)
  if Panel_Window_ChangeMaidActorName_All == nil then
    return
  end
  if self._isConsole == true and PaGlobalFunc_MaidActorList_IsShow() == true then
    PaGlobalFunc_MaidActorList_Close()
  end
  self._ui.edt_name:SetEditText("")
  if self._isConsole == false then
    SetFocusEdit(self._ui.edt_name)
  end
  self._maidNo = maidNo
  self:open()
end
function PaGlobal_ChangeMaidActorName:open()
  if Panel_Window_ChangeMaidActorName_All == nil then
    return
  end
  self._ui.stc_blackBg:SetSize(getScreenSizeX() + 500, getScreenSizeY() + 500)
  self._ui.stc_blackBg:ComputePos()
  Panel_Window_ChangeMaidActorName_All:SetDepth(10000)
  Panel_Window_ChangeMaidActorName_All:SetShow(true)
end
function PaGlobal_ChangeMaidActorName:prepareClose()
  if Panel_Window_ChangeMaidActorName_All == nil then
    return
  end
  if self._isConsole == true and PaGlobalFunc_MaidActorList_IsShow() == false then
    PaGlobalFunc_MaidActorList_Open()
  end
  self._maidNo = nil
  self:close()
end
function PaGlobal_ChangeMaidActorName:close()
  if Panel_Window_ChangeMaidActorName_All == nil then
    return
  end
  Panel_Window_ChangeMaidActorName_All:SetShow(false)
end
