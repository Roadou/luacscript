function HandleOnOut_AngerGage(isShow)
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local angerPointToolTipStr = PAGetString(Defines.StringSheet_GAME, "LUA_ANGRYPOINT_DESC")
  TooltipSimple_Show(PaGlobal_SiegeWar_AngerGage._ui._stc_angry, "", angerPointToolTipStr)
end
function HandleLUp_AngerGage()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  PaGlobalFunc_GuildMain_All_Open()
  HandleEventLUp_GuildMain_All_ClickOtherTab(3)
end
function FromClient_SiegeWar_AngerGage_Update(setPoint)
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  PaGlobal_SiegeWar_AngerGage:setPointUpdate(setPoint)
end
function FromClient_SiegeWar_AngerGage_OnOff(isOnOff)
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if true == isOnOff then
    PaGlobal_SiegeWar_AngerGage:prepareOpen()
  else
    PaGlobal_SiegeWar_AngerGage:prepareClose()
  end
end
function FromClient_SiegeWar_AngerGage_ReSize()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if nil == PaGlobal_SiegeWar_AngerGage._ui._stc_angry then
    PaGlobal_SiegeWar_AngerGage._ui._stc_angry:ComputePosAllInChild()
  end
  if nil ~= Panel_Radar then
    Panel_SiegeWar_AngerGage:SetPosY(Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() + 10)
    if nil ~= Panel_SiegeWar_CastleInfo then
      Panel_SiegeWar_CastleInfo:SetPosY(Panel_SiegeWar_AngerGage:GetPosY() + PaGlobal_SiegeWar_AngerGage._ui._stc_angry:GetSizeY() + 10)
    end
    Panel_SiegeWar_AngerGage:SetPosX(Panel_Radar:GetPosX() + Panel_Radar:GetSizeX() - Panel_SiegeWar_AngerGage:GetSizeX() - 10)
  end
  if PaGlobalFunc_VillageSiegeStateWidget_IsShow() == true then
    PaGlobalFunc_VillageSiegeStateWidget_UpdatePanelPosition()
  end
end
function FromClient_SiegeWar_AngerGage_ResponseParticipateSiege(isParticipant, isSelf)
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  if false == isSelf then
    return
  end
  PaGlobal_SiegeWar_AngerGage:changeParticipant(isParticipant)
end
function FromClient_SiegeWar_AngerGage_ResponseParticipateSiegeMyGuild()
  if nil == Panel_SiegeWar_AngerGage then
    return
  end
  PaGlobal_SiegeWar_AngerGage:prepareClose()
end
function PaGlobal_SiegeWar_AngerGage_GetMainBgSizeY()
  if nil == Panel_SiegeWar_AngerGage then
    return 0
  end
  if nil == PaGlobal_SiegeWar_AngerGage._ui._stc_angry then
    return 0
  end
  return PaGlobal_SiegeWar_AngerGage._ui._stc_angry:GetSizeY()
end
