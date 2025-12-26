Panel_KeyboardHelp:SetShow(false, false)
local keyboardHelp = {
  stc_titleBg = UI.getChildControl(Panel_KeyboardHelp, "Static_TitleBG"),
  btn_Close = UI.getChildControl(Panel_KeyboardHelp, "Button_CloseWindow"),
  btn_GameOption = UI.getChildControl(Panel_KeyboardHelp, "Button_GameOption"),
  btn_ShortCut = UI.getChildControl(Panel_KeyboardHelp, "Button_ShortCut"),
  btn_Help = UI.getChildControl(Panel_KeyboardHelp, "Button_Help")
}
keyboardHelp.btn_XClose = UI.getChildControl(keyboardHelp.stc_titleBg, "Button_Close")
function KeyBoardHelp_Init()
  if _ContentsOption_CH_Help == true then
    keyboardHelp.btn_Help:SetShow(false)
  end
end
function KeyboardHelpShow()
  if Panel_KeyboardHelp:GetShow() then
    return
  end
  audioPostEvent_SystemUi(1, 0)
  _AudioPostEvent_SystemUiForXBOX(1, 0)
  Panel_KeyboardHelp:SetShow(true)
end
function FGlobal_KeyboardHelpShow()
  if Panel_KeyboardHelp:IsShow() then
    Panel_KeyboardHelp:SetShow(false)
    return false
  else
    audioPostEvent_SystemUi(1, 0)
    _AudioPostEvent_SystemUiForXBOX(1, 0)
    Panel_KeyboardHelp:SetShow(true)
    return true
  end
end
function KeyboardHelpHide()
  Panel_KeyboardHelp:SetShow(false)
  audioPostEvent_SystemUi(1, 1)
  _AudioPostEvent_SystemUiForXBOX(1, 1)
end
function keyboardHelp:registEventHandler()
  self.btn_Close:addInputEvent("Mouse_LUp", "KeyboardHelpHide()")
  self.btn_XClose:addInputEvent("Mouse_LUp", "KeyboardHelpHide()")
  self.btn_GameOption:addInputEvent("Mouse_LUp", "PaGlobal_GameOption_All_GameOptionShortCutOpen(true)")
  self.btn_ShortCut:addInputEvent("Mouse_LUp", "PaGlobalFunc_ButtonShorcuts_All_HelpOpen(true)")
  self.btn_Help:addInputEvent("Mouse_LUp", "FGlobal_Panel_WebHelper_ShowToggle(true)")
end
KeyBoardHelp_Init()
keyboardHelp:registEventHandler()
