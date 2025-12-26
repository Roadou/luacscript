function PaGlobal_SiegeWar_AngerGage:initialize()
  if true == PaGlobal_SiegeWar_AngerGage._initialize then
    return
  end
  self._ui._stc_angry = UI.getChildControl(Panel_SiegeWar_AngerGage, "Static_Angry")
  self._ui._progress_Angry = UI.getChildControl(self._ui._stc_angry, "Progress2_Angry")
  self._ui._txt_Percent = UI.getChildControl(self._ui._stc_angry, "StaticText_Percent")
  self._ui._stc_Effect = UI.getChildControl(self._ui._stc_angry, "Static_Effect")
  PaGlobal_SiegeWar_AngerGage:registEventHandler()
  PaGlobal_SiegeWar_AngerGage:validate()
  self._isPlayingEffect = false
  PaGlobal_SiegeWar_AngerGage._initialize = true
  PaGlobal_SiegeWar_AngerGage:prepareOpen()
end
function PaGlobal_SiegeWar_AngerGage:registEventHandler()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  self._ui._stc_angry:addInputEvent("Mouse_On", "HandleOnOut_AngerGage(" .. tostring(true) .. ")")
  self._ui._stc_angry:addInputEvent("Mouse_Out", "HandleOnOut_AngerGage(" .. tostring(false) .. ")")
  self._ui._stc_angry:addInputEvent("Mouse_LUp", "HandleLUp_AngerGage()")
  registerEvent("FromClient_SiegeAngerPoint_Update", "FromClient_SiegeWar_AngerGage_Update")
  registerEvent("FromClient_SiegeAngerPoint_OnOff", "FromClient_SiegeWar_AngerGage_OnOff")
  registerEvent("onScreenResize", "FromClient_SiegeWar_AngerGage_ReSize")
  registerEvent("FromClient_ResponseParticipateSiege", "FromClient_SiegeWar_AngerGage_ResponseParticipateSiege")
  registerEvent("FromClient_ResponseParticipateSiegeMyGuild", "FromClient_SiegeWar_AngerGage_ResponseParticipateSiegeMyGuild")
end
function PaGlobal_SiegeWar_AngerGage:prepareOpen()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if true == Panel_SiegeWar_AngerGage:GetShow() then
    return
  end
  if false == ToClient_IsAnySiegeBeingOfMyChannel() then
    return
  end
  if false == ToClient_getSiegeParticipant() then
    return
  end
  if ToClient_IsOceanSiegeBeingOnMyChannel() == true then
    return
  end
  if nil ~= Panel_Radar then
    Panel_SiegeWar_AngerGage:SetPosY(Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() + 10)
    if nil ~= Panel_SiegeWar_CastleInfo then
      Panel_SiegeWar_CastleInfo:SetPosY(Panel_SiegeWar_AngerGage:GetPosY() + self._ui._stc_angry:GetSizeY() + 10)
    end
    Panel_SiegeWar_AngerGage:SetPosX(Panel_Radar:GetPosX() + Panel_Radar:GetSizeX() - Panel_SiegeWar_AngerGage:GetSizeX() - 10)
  end
  local currentPoint = ToClient_SiegeAngerCurrentPoint()
  self:setPointUpdate(currentPoint)
  if ToClient_isConsole() == true then
    Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    Panel_LatestQuest:SetIgnoreRenderAndEvent(true)
  else
    Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    Panel_CheckedQuest:SetIgnoreRenderAndEvent(true)
  end
  PaGlobal_SiegeWar_AngerGage:open()
  if PaGlobalFunc_VillageSiegeStateWidget_IsShow() == true then
    PaGlobalFunc_VillageSiegeStateWidget_UpdatePanelPosition()
  end
end
function PaGlobal_SiegeWar_AngerGage:open()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  Panel_SiegeWar_AngerGage:SetShow(true)
end
function PaGlobal_SiegeWar_AngerGage:prepareClose()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if false == Panel_SiegeWar_AngerGage:GetShow() then
    return
  end
  PaGlobal_SiegeWar_AngerGage:close()
  if PaGlobalFunc_VillageSiegeStateWidget_IsShow() == true then
    PaGlobalFunc_VillageSiegeStateWidget_UpdatePanelPosition()
  end
  if ToClient_isConsole() == true then
    Panel_MainQuest:SetIgnoreRenderAndEvent(false)
    Panel_LatestQuest:SetIgnoreRenderAndEvent(false)
  else
    Panel_MainQuest:SetIgnoreRenderAndEvent(false)
    Panel_CheckedQuest:SetIgnoreRenderAndEvent(false)
  end
end
function PaGlobal_SiegeWar_AngerGage:close()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  Panel_SiegeWar_AngerGage:SetShow(false)
end
function PaGlobal_SiegeWar_AngerGage:setPointUpdate(setPoint)
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  local maxAngerPoint = ToClient_GetMaxAngerPoint()
  if 0 == maxAngerPoint then
    _PA_ASSERT(false, "0\236\156\188\235\161\156 \235\130\152\235\136\132\235\160\164\237\149\156\235\139\164!!")
    return
  end
  local percent = setPoint / maxAngerPoint
  if percent >= 1 then
    if false == self._isPlayingEffect then
      self._ui._stc_Effect:AddEffect("fUI_SoegeWar_AngerGage_01A", true, 0, 0)
    end
    self._isPlayingEffect = true
  else
    self._ui._stc_Effect:EraseAllEffect()
    self._isPlayingEffect = false
  end
  self._ui._progress_Angry:SetProgressRate(percent * 100)
  self._ui._txt_Percent:SetText(string.format("%.0f %%", percent * 100))
end
function PaGlobal_SiegeWar_AngerGage:changeParticipant(isParticipant)
  if false == isParticipant then
    self:prepareClose()
    return
  end
  if false == ToClient_IsAnySiegeBeingOfMyChannel() then
    return
  end
  if ToClient_IsVillageSiegeBeing() == true and (ToClient_GetMinorSiegeMode() == __eMinorSiegeModeOccupy or ToClient_getSiegeTerritoryType() == __eSiegeTerritoryType_Ocean) and ToClient_IsGuildParticiapteInSiege2024() == false then
    return
  end
  self:prepareOpen()
end
function PaGlobal_SiegeWar_AngerGage_UpdatePerFrame(deletaTime)
  if ToClient_isConsole() == true then
    if Panel_MainQuest ~= nil and Panel_MainQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    end
    if Panel_LatestQuest ~= nil and Panel_LatestQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_LatestQuest:SetIgnoreRenderAndEvent(true)
    end
  else
    if Panel_MainQuest ~= nil and Panel_MainQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    end
    if Panel_CheckedQuest ~= nil and Panel_CheckedQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_CheckedQuest:SetIgnoreRenderAndEvent(true)
    end
  end
end
function PaGlobal_SiegeWar_AngerGage:validate()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  self._ui._stc_angry:isValidate()
  self._ui._progress_Angry:isValidate()
  self._ui._txt_Percent:isValidate()
  self._ui._stc_Effect:isValidate()
end
