function PaGlobal_Tooltip_Actor_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui._web_Actor = UI.createControl(__ePAUIControl_WebControl, Panel_Widget_Tooltip_Actor_All, "WebControl_Actor")
  self._ui._web_Actor:SetShow(true)
  self._ui._web_Actor:SetHorizonCenter()
  self._ui._web_Actor:SetVerticalTop()
  self._ui._web_Actor:SetSpanSize(0, 60)
  self._ui._web_Actor:SetSize(Panel_Widget_Tooltip_Actor_All:GetSizeX(), Panel_Widget_Tooltip_Actor_All:GetSizeY())
  self._ui._web_Actor:ResetUrl()
  self._ui._web_Actor:ComputePos()
  local stc_title_area = UI.getChildControl(Panel_Widget_Tooltip_Actor_All, "StaticText_TitleArea")
  local btn_Refresh = UI.getChildControl(stc_title_area, "Button_Refresh")
  self._ui.btn_close = UI.getChildControl(stc_title_area, "Button_Win_Close")
  PaGlobal_Util_RegistWebResetControl(btn_Refresh)
  btn_Refresh:SetShow(_ContentsGroup_ResetCoherent)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Tooltip_Actor_All:registEventHandler()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_Tooltip_Actor_All_Close()")
end
function PaGlobal_Tooltip_Actor_All:prepareOpen(actorKey)
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  self._actorKey = actorKey
  self:update()
  self:open()
end
function PaGlobal_Tooltip_Actor_All:open()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  audioPostEvent_SystemUi(13, 6)
  _AudioPostEvent_SystemUiForXBOX(13, 6)
  Panel_Widget_Tooltip_Actor_All:SetShow(true, true)
  FGlobal_SetCandidate()
  local url = ToClient_getInGamePortalWeb()
  if nil == getSelfPlayer() then
    return
  end
  local userNo = getSelfPlayer():get():getUserNo()
  local cryptKey = getSelfPlayer():get():getWebAuthenticKeyCryptString()
  local isGm = ToClient_SelfPlayerIsGM()
  local cultureCode = ToClient_GetWebCultureCode()
  local userNickName = getSelfPlayer():getUserNickname()
  local actorProxyWrapper = getActor(self._actorKey)
  if nil == actorProxyWrapper then
    return
  end
  local objectKey = actorProxyWrapper:getObjectKeyRaw()
  local actorName = actorProxyWrapper:getName()
  url = url .. "/ObjectToolTip/Index/Detail?userNo=" .. tostring(userNo) .. "&certKey=" .. tostring(cryptKey) .. "&isGm=" .. tostring(isGm) .. "&objectKey=" .. tostring(objectKey) .. "&cultureCode=" .. tostring(cultureCode) .. "&userNickname=" .. tostring(userNickName) .. "&actorName=" .. tostring(actorName)
  self._ui._web_Actor:SetUrl(Panel_Widget_Tooltip_Actor_All:GetSizeX(), Panel_Widget_Tooltip_Actor_All:GetSizeY(), url, false, true)
  self._ui._web_Actor:SetIME(true)
end
function PaGlobal_Tooltip_Actor_All:prepareClose()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  self._actorKey = 0
  ToClient_ResetSelectedActorProxy()
  self:close()
end
function PaGlobal_Tooltip_Actor_All:close()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  Panel_Widget_Tooltip_Actor_All:SetShow(false)
end
function PaGlobal_Tooltip_Actor_All:update()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
  local actorProxyWrapper = getActor(self._actorKey)
  if nil == actorProxyWrapper then
    return
  end
end
function PaGlobal_Tooltip_Actor_All:validate()
  if nil == Panel_Widget_Tooltip_Actor_All then
    return
  end
end
