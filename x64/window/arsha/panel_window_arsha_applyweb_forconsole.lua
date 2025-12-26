PaGlobal_Arsha_ApplyWeb_forConsole = {
  _ui = {_stc_QR = nil},
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Arsha_ApplyWeb_forConsole_Init")
function FromClient_Arsha_ApplyWeb_forConsole_Init()
  PaGlobal_Arsha_ApplyWeb_forConsole:initialize()
end
function PaGlobal_Arsha_ApplyWeb_forConsole:initialize()
  local contentBg = UI.getChildControl(Panel_Window_Arsha_ApplyWeb_forConsole, "Static_Content_BG")
  local staticQRBG = UI.getChildControl(contentBg, "Static_QR_BG")
  self._ui._stc_QR = UI.getChildControl(staticQRBG, "Static_QR")
  local resourceType = ToClient_getResourceType()
  if resourceType == __ePASRT_EN then
    self._ui._stc_QR:ChangeTextureInfoNameAsync("Combine/CommonIcon/_EN_TuvalaCup_QR.dds")
  elseif resourceType == __ePASRT_JP then
    self._ui._stc_QR:ChangeTextureInfoNameAsync("Combine/CommonIcon/_JP_TuvalaCup_QR.dds")
  elseif resourceType == __ePASRT_KR then
  elseif resourceType == __ePASRT_FR then
    self._ui._stc_QR:ChangeTextureInfoNameAsync("Combine/CommonIcon/_FR_TuvalaCup_QR.dds")
  elseif resourceType == __ePASRT_DE then
    self._ui._stc_QR:ChangeTextureInfoNameAsync("Combine/CommonIcon/_DE_TuvalaCup_QR.dds")
  else
    self._ui._stc_QR:ChangeTextureInfoNameAsync("Combine/CommonIcon/_EN_TuvalaCup_QR.dds")
  end
end
function PaGlobal_Arsha_ApplyWeb_forConsole:prepareOpen()
  PaGlobal_Arsha_ApplyWeb_forConsole:open()
end
function PaGlobal_Arsha_ApplyWeb_forConsole:open()
  Panel_Window_Arsha_ApplyWeb_forConsole:SetShow(true)
end
function PaGlobal_Arsha_ApplyWeb_ForConsole_Open()
  if PaGlobal_Arsha_ApplyWeb_forConsole == nil then
    return
  end
  PaGlobal_Arsha_ApplyWeb_forConsole:prepareOpen()
end
function PaGlobal_Arsha_ApplyWeb_forConsole:prepareClose()
  PaGlobal_Arsha_ApplyWeb_forConsole:close()
end
function PaGlobal_Arsha_ApplyWeb_forConsole:close()
  Panel_Window_Arsha_ApplyWeb_forConsole:SetShow(false)
end
function PaGlobal_Arsha_ApplyWeb_ForConsole_Close()
  if PaGlobal_Arsha_ApplyWeb_forConsole == nil then
    return
  end
  PaGlobal_Arsha_ApplyWeb_forConsole:prepareClose()
end
