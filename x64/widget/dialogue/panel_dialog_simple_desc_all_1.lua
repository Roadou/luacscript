function PaGlobal_Dialog_SimpleDesc_All:initialize()
  if true == PaGlobal_Dialog_SimpleDesc_All._initialize then
    return
  end
  if nil == Panel_Dialog_SimpleDesc_All then
    return
  end
  self._ui.stc_mainbg = UI.getChildControl(Panel_Dialog_SimpleDesc_All, "Static_MainBG")
  self._ui.txt_npcName = UI.getChildControl(self._ui.stc_mainbg, "StaticText_NPC_Name")
  self._ui.frame = UI.getChildControl(self._ui.stc_mainbg, "Frame_1")
  self._ui.frame_content = UI.getChildControl(self._ui.frame, "Frame_1_Content")
  self._ui.frame_verticalScroll = UI.getChildControl(self._ui.frame, "Frame_1_VerticalScroll")
  self._ui.txt_desc = UI.getChildControl(self._ui.frame_content, "StaticText_Desc")
  self._ui.txt_close = UI.getChildControl(self._ui.stc_mainbg, "StaticText_Close")
  PaGlobal_Dialog_SimpleDesc_All:registEventHandler()
  PaGlobal_Dialog_SimpleDesc_All._initialize = true
end
function PaGlobal_Dialog_SimpleDesc_All:registEventHandler()
  if nil == Panel_Dialog_SimpleDesc_All then
    return
  end
  registerEvent("FromClient_ShowSimpleDesc", "PaGlobal_Dialog_SimpleDesc_All_Open")
  registerEvent("onScreenResize", "PaGlobal_Dialog_SimpleDesc_All_OnScreenSizeRefresh")
  Panel_Dialog_SimpleDesc_All:RegisterUpdateFunc("PaGlobal_Dialog_Simple_All_UpdatePerFrame")
end
function PaGlobal_Dialog_SimpleDesc_All:prepareOpen()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local startPosX = screenSizeX - Panel_Dialog_SimpleDesc_All:GetSizeX()
  if screenSizeY <= 800 then
    Panel_Dialog_SimpleDesc_All:SetPosY(screenSizeY / 2 - Panel_Dialog_SimpleDesc_All:GetSizeY() / 2 - 30)
  else
    Panel_Dialog_SimpleDesc_All:SetPosY(screenSizeY / 2 - Panel_Dialog_SimpleDesc_All:GetSizeY() / 2 - 100)
  end
  Panel_Dialog_SimpleDesc_All:ComputePos()
  local dialogData = ToClient_GetCurrentDialogData()
  if nil == dialogData then
    ToClient_PopDialogueFlush()
    return
  end
  local mainDialog = dialogData:getMainDialog()
  if nil == mainDialog or "" == mainDialog then
    ToClient_PopDialogueFlush()
    return
  end
  local npcTitle = dialogData:getContactNpcTitle()
  local npcName = dialogData:getContactNpcName()
  self._ui.txt_npcName:SetText(npcTitle .. npcName)
  local realDialog = ToClient_getReplaceDialog(mainDialog)
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_desc:SetText(realDialog)
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  self._ui.frame_content:SetSize(self._ui.frame_content:GetSizeX(), self._ui.txt_desc:GetSizeY() + 20)
  PaGlobalFunc_DialogSimple_Hide()
  local frameVScroll = self._ui.frame:GetVScroll()
  if frameVScroll ~= nil then
    frameVScroll:SetControlPos(0)
    self._ui.frame:UpdateContentPos()
  end
  if self._ui.frame:GetSizeY() < self._ui.txt_desc:GetSizeY() then
    frameVScroll:SetShow(true)
  else
    frameVScroll:SetShow(false)
  end
  PaGlobal_Dialog_SimpleDesc_All:open()
end
function PaGlobal_Dialog_SimpleDesc_All:open()
  if nil == Panel_Dialog_SimpleDesc_All then
    return
  end
  Panel_Dialog_SimpleDesc_All:SetShow(true)
end
function PaGlobal_Dialog_SimpleDesc_All:prepareClose()
  if nil == Panel_Dialog_SimpleDesc_All then
    return
  end
  self._frameScrollCtrlPos = 0
  PaGlobal_Dialog_SimpleDesc_All:close()
end
function PaGlobal_Dialog_SimpleDesc_All:close()
  if nil == Panel_Dialog_SimpleDesc_All then
    return
  end
  Panel_Dialog_SimpleDesc_All:SetShow(false)
end
