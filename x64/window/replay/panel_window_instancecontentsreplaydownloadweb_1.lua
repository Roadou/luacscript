function PaGlobal_InstanceContentsReplayDownloadWeb:initialize()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil or self._initialize == true then
    return
  end
  self._ui._stc_title = UI.getChildControl(Panel_Window_InstanceContentsReplayDownloadWeb, "StaticText_Title")
  self._ui._btn_refresh = UI.getChildControl(self._ui._stc_title, "Button_Refresh")
  self._ui._btn_close = UI.getChildControl(self._ui._stc_title, "Button_Close")
  self._webUI = UI.createControl(__ePAUIControl_WebControl, Panel_Window_InstanceContentsReplayDownloadWeb, "WebControl_ReplayList")
  self._webUI:SetShow(true)
  self._webUI:SetSize(870, 630)
  self._webUI:SetHorizonCenter()
  self._webUI:SetVerticalTop()
  self._webUI:SetSpanSize(0, 60)
  self._webUI:ComputePos()
  self._webUI:ResetUrl()
  PaGlobal_Util_RegistWebResetControl(self._ui._btn_refresh)
  self:resize()
  self:registEventHandler()
  self:initServiceTypeStrArray()
  self._initialize = true
end
function PaGlobal_InstanceContentsReplayDownloadWeb:registEventHandler()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_InstanceContentsReplayDownloadWeb_Close()")
  registerEvent("onScreenResize", "PaGlobalFunc_InstanceContentsReplayDownloadWeb_Resize")
end
function PaGlobal_InstanceContentsReplayDownloadWeb:initServiceTypeStrArray()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  self._serviceTypeStrArr = {}
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_NONE] = "DEV"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_DEV] = "DEV"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_KOR_ALPHA] = "KR_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_KOR_REAL] = "KR"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_KOR_TEST] = nil
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_JPN_ALPHA] = "JP_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_JPN_REAL] = "JP"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_RUS_ALPHA] = "RU_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_RUS_REAL] = "RU"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_KR2_ALPHA] = "CH_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_KR2_REAL] = "CH"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_NA_ALPHA] = "NA_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_NA_REAL] = "NA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_TW_ALPHA] = "TW_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_TW_REAL] = "TW"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_SA_ALPHA] = "SA_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_SA_REAL] = "SA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_TH_ALPHA] = "TH_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_TH_REAL] = "TH"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_ID_ALPHA] = "ID_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_ID_REAL] = "ID"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_TR_ALPHA] = "TR_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_TR_REAL] = "TR"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_PS_ALPHA] = "PS_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_PS_REAL] = "PS"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_XB_ALPHA] = "XB_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_XB_REAL] = "XB"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_GT_ALPHA] = "GT_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_GT_REAL] = "GT"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_XX_ALPHA] = "XX_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_XX_REAL] = "XX"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_XXXXXXX] = nil
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_XXXXXXX] = nil
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_CS_ALPHA] = "CS_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_CS_REAL] = "CS"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_ASIA_ALPHA] = "ASIA_ALPHA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_ASIA_REAL] = "ASIA"
  self._serviceTypeStrArr[CppEnums.GameServiceType.eGameServiceType_Count] = nil
end
function PaGlobal_InstanceContentsReplayDownloadWeb:prepareOpen()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    return
  end
  local resourceType = getGameServiceType()
  local serviceTypeStr = self._serviceTypeStrArr[resourceType]
  if serviceTypeStr == nil then
    return
  end
  local nationType = getServiceNationType()
  if nationType == 1 then
    if resourceType == CppEnums.GameServiceType.eGameServiceType_NA_ALPHA then
      serviceTypeStr = "EU_ALPHA"
    elseif resourceType == CppEnums.GameServiceType.eGameServiceType_NA_REAL then
      serviceTypeStr = "EU"
    end
  end
  local worldNo = temporaryWrapper:getSelectedWorldServerNo()
  local webUrl = PaGlobal_URL_Check(worldNo)
  webUrl = webUrl .. "/Solare/Replay/RankList?_serviceType=" .. serviceTypeStr .. "&_classType=-1"
  self._webUI:SetUrl(self._panelSizeX - 20, self._panelSizeY - 70, webUrl, false, true)
  self._webUI:SetIME(true)
  self._ui._btn_refresh:SetShow(_ContentsGroup_ResetCoherent)
  self:open()
end
function PaGlobal_InstanceContentsReplayDownloadWeb:open()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  Panel_Window_InstanceContentsReplayDownloadWeb:SetShow(true)
end
function PaGlobal_InstanceContentsReplayDownloadWeb:prepareClose()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  self._webUI:ResetUrl()
  self:close()
end
function PaGlobal_InstanceContentsReplayDownloadWeb:close()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  Panel_Window_InstanceContentsReplayDownloadWeb:SetShow(false)
end
function PaGlobal_InstanceContentsReplayDownloadWeb:resize()
  if Panel_Window_InstanceContentsReplayDownloadWeb == nil then
    return
  end
  Panel_Window_InstanceContentsReplayDownloadWeb:SetSize(self._panelSizeX, self._panelSizeY)
  self._ui._stc_title:SetSize(self._panelSizeX, self._ui._stc_title:GetSizeY())
  self._webUI:SetSize(self._panelSizeX - 20, self._panelSizeY - 70)
  self._webUI:SetHorizonCenter()
  self._webUI:SetVerticalTop()
  self._webUI:SetSpanSize(0, self._ui._stc_title:GetSizeY() + 10)
  Panel_Window_InstanceContentsReplayDownloadWeb:ComputePosAllChild()
end
