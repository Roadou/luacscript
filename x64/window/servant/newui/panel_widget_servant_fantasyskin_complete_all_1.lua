function PaGlobal_CompleteChangeFormFantasyServant:initialize()
  if self._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:initializeControl()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_CompleteChangeFormFantasyServant:initializeControl()
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  self._ui._stc_horseEffectBg = UI.getChildControl(Panel_Widget_Servant_FantasySkin_Complete_All, "Static_HorseEffectBG")
  self._ui._stc_descBg = UI.getChildControl(Panel_Widget_Servant_FantasySkin_Complete_All, "Static_DescBG")
end
function PaGlobal_CompleteChangeFormFantasyServant:registEventHandler()
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  if self._isConsole == true then
    Panel_Widget_Servant_FantasySkin_Complete_All:ignorePadSnapMoveToOtherPanel()
  end
  registerEvent("FromClient_FantasyServantChangeForm", "FromClient_CompleteChangeFormFantasyServant_SuccessChangeForm")
  registerEvent("FromClient_FailedServantChangeForm", "FromClient_CompleteChangeFormFantasyServant_FailedChangeForm")
end
function PaGlobal_CompleteChangeFormFantasyServant:prepareOpen(stringParam, servantNo, servantCharacterKeyRaw, changeFormIndexRaw)
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  if stringParam == nil or servantNo == nil or servantCharacterKeyRaw == nil or changeFormIndexRaw == nil then
    return
  end
  self._state = 0
  self._accTime = 0
  self._openParam = stringParam
  self._currentServantNo = servantNo
  self._changeTargetFormIndexRaw = changeFormIndexRaw
  self._currentServantCharacterKeyRaw = servantCharacterKeyRaw
  self._isSuccessFlag = false
  self._ui._stc_horseEffectBg:SetShow(false)
  self._ui._stc_descBg:SetShow(false)
  self:recalcPanelPosition()
  self:open()
end
function PaGlobal_CompleteChangeFormFantasyServant:recalcPanelPosition()
  local panel = Panel_Widget_Servant_FantasySkin_Complete_All
  if panel == nil then
    return
  end
  local calcPosX = getScreenSizeX() / 2 - panel:GetSizeX() / 2
  local calcPosY = getScreenSizeY() / 2 - panel:GetSizeY() / 2
  if calcPosX < 0 then
    calcPosX = 0
  end
  if calcPosY < 0 then
    calcPosY = 0
  end
  panel:SetPosX(calcPosX)
  panel:SetPosY(calcPosY)
  panel:SetSize(getScreenSizeX(), getScreenSizeY())
  panel:ComputePosAllChild()
end
function PaGlobal_CompleteChangeFormFantasyServant:open()
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  Panel_Widget_Servant_FantasySkin_Complete_All:RegisterUpdateFunc("PaGlobalFunc_CompleteChangeFormFantasyServant_Update")
  Panel_Widget_Servant_FantasySkin_Complete_All:SetShow(true)
end
function PaGlobal_CompleteChangeFormFantasyServant:prepareClose()
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  self._state = 0
  self._accTime = 0
  self._openParam = ""
  self._currentServantNo = nil
  self._changeTargetFormIndexRaw = nil
  self._currentServantCharacterKeyRaw = nil
  self._isSuccessFlag = false
  self:close()
end
function PaGlobal_CompleteChangeFormFantasyServant:close()
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  Panel_Widget_Servant_FantasySkin_Complete_All:ClearUpdateLuaFunc()
  Panel_Widget_Servant_FantasySkin_Complete_All:SetShow(false)
end
function PaGlobal_CompleteChangeFormFantasyServant:validate()
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  self._ui._stc_horseEffectBg:isValidate()
  self._ui._stc_descBg:isValidate()
end
function PaGlobal_CompleteChangeFormFantasyServant:setData(stringParam)
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  if stringParam == nil or stringParam == "" then
    return
  end
  self._ui._stc_horseEffectBg:SetShow(true)
  self._ui._stc_descBg:SetShow(true)
  if stringParam == "DREAM_ADOOANAT_ORIGINAL" then
    self._ui._stc_horseEffectBg:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01A_A", false, -10, 190)
    self._ui._stc_descBg:ChangeTextureInfoNameAsync("combine/etc/combine_etc_nak_stablebg.dds")
  elseif stringParam == "DREAM_ADOOANAT_ICE" then
    self._ui._stc_horseEffectBg:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01C", false, -10, 190)
    self._ui._stc_descBg:ChangeTextureInfoNameAsync("combine/etc/combine_etc_nak_stablebg_02.dds")
  else
    UI.ASSERT_NAME(false, "\236\151\172\234\184\176\235\143\132 \235\147\177\235\161\157\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
end
function PaGlobal_CompleteChangeFormFantasyServant:update(deltaTime)
  if Panel_Widget_Servant_FantasySkin_Complete_All == nil then
    return
  end
  local time_loadingEffect = 4
  local time_resultEffect = 3.5
  self._accTime = self._accTime + deltaTime
  if self._state == 0 then
    self._state = 1
    Panel_Widget_Servant_FantasySkin_Complete_All:AddEffect("fUI_Horse_ExchangeFantasy_Summon_01B", false, 0, 0)
    audioPostEvent_SystemUi(10, 2)
    _AudioPostEvent_SystemUiForXBOX(10, 2)
  elseif self._state == 1 and time_loadingEffect < self._accTime then
    self._state = 2
    local rv = stable_changeForm(self._currentServantNo, self._changeTargetFormIndexRaw, 0, false, self._currentServantCharacterKeyRaw)
    if rv ~= 0 then
      PaGlobalFunc_CompleteChangeFormFantasyServant_Close()
    end
  elseif self._state == 2 and self._isSuccessFlag == true then
    self._state = 3
    self._accTime = 0
    self:setData(self._openParam)
    audioPostEvent_SystemUi(10, 3)
    _AudioPostEvent_SystemUiForXBOX(10, 3)
  elseif self._state == 3 and time_resultEffect < self._accTime then
    self._state = 4
    PaGlobalFunc_CompleteChangeFormFantasyServant_Close()
  end
end
