function PaGlobal_ServantSwiftResult_All:initialize()
  if nil == Panel_Dialog_ServantSwiftResult_All or true == PaGlobal_ServantSwiftResult_All.initialize then
    return
  end
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_HorseToehold")
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_HorseToehold_OnlyFantasy")
  PaGlobal_ServantSwiftResult_All._ui._stc_Success = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_AwakenSuccess")
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail = UI.getChildControl(Panel_Dialog_ServantSwiftResult_All, "Static_AwakenSuccess")
  PaGlobal_ServantSwiftResult_All.initialize = true
  PaGlobal_ServantSwiftResult_All:validate()
  PaGlobal_ServantSwiftResult_All:RegisterEventHandler()
end
function PaGlobal_ServantSwiftResult_All:validate()
  if nil == Panel_Dialog_ServantSwiftResult_All or true == PaGlobal_ServantSwiftResult_All.initialize then
    return
  end
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:isValidate()
  PaGlobal_ServantSwiftResult_All._ui._stc_Success:isValidate()
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail:isValidate()
  PaGlobal_ServantSwiftResult_All.initialize = true
end
function PaGlobal_ServantSwiftResult_All:RegisterEventHandler()
  if nil == Panel_Dialog_ServantSwiftResult_All or false == PaGlobal_ServantSwiftResult_All.initialize then
    return
  end
  registerEvent("onScreenResize", "PaGlobalFunc_ServantSwiftResult_All_OnScreenResize")
  registerEvent("FromClient_fantasyVoltarionEffect", "PaGlobalFunc_ServantSwiftResult_All_fantasyVoltarionEffect")
end
function PaGlobalFunc_ServantSwiftResult_All_OnScreenResize()
  if nil == Panel_Dialog_ServantSwiftResult_All or false == Panel_Dialog_ServantSwiftResult_All:GetShow() then
    return
  end
  Panel_Dialog_ServantSwiftResult_All:ComputePos()
end
function PaGlobalFunc_ServantSwiftResult_All_AwakenEffect(isAwaken, servantKey)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:ChangeTextureInfoNameAsync("Combine/Frame/Combine_Frame_Noticebar_Reinforce.dds")
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:getBaseTexture():setUV(0, 0, 1, 1)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:setRenderTexture(PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:getBaseTexture())
  if 0 == isAwaken then
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 6, 0, 220, servantKey)
    return
  elseif true == isAwaken then
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(true)
    PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_AWAKENSUCCESS"))
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 7, 0, 220, servantKey)
  else
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(true)
    PaGlobal_ServantSwiftResult_All._ui._stc_Success:SetShow(false)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_STABLESTALLION_TEXT_AWAKENFAIL"))
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 12, 0, 220, servantKey)
  end
end
function PaGlobalFunc_ServantSwiftResult_All_fantasyMixEffect(fantasyMixState, servantKey)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  local nakStableBG = "Combine/Etc/Combine_Etc_Nak_Stablebg.dds"
  if 31539 == servantKey then
    nakStableBG = "Combine/Etc/Combine_ETC_Nak_Arduanat_BG.dds"
  elseif 31557 == servantKey then
    nakStableBG = "Combine/Etc/Combine_ETC_Nak_Dine_BG.dds"
  elseif servantKey == 31575 then
    nakStableBG = "Combine/Etc/Combine_ETC_Nak_Dum_BG.dds"
  end
  if nil ~= nakStableBG then
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:getBaseTexture():setUV(0, 0, 1, 1)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:setRenderTexture(PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:getBaseTexture())
  end
  if 0 == fantasyMixState then
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 15, 0, 220, servantKey)
  elseif 1 == fantasyMixState then
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:ChangeTextureInfoNameAsync(nakStableBG)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:SetShow(true)
    PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTEXCHANGE_FANTASY_TEXT_AWAKENSUCCESS"))
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 16, 0, 280, servantKey)
  elseif 2 == fantasyMixState then
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:ChangeTextureInfoNameAsync(nakStableBG)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(true)
    PaGlobal_ServantSwiftResult_All._ui._stc_Success:SetShow(false)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANTEXCHANGE_FANTASY_TEXT_AWAKENFAIL"))
    PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 17, 0, 220, servantKey)
  end
end
function PaGlobalFunc_ServantSwiftResult_All_DoAwakenEffect()
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 13, 0, -190)
end
function PaGlobalFunc_ServantSwiftResult_All_AddEffect(control, index, posX, posY, servantKey)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  if 0 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_02A", false, posX, posY)
  elseif 1 == index then
  elseif 2 == index then
    control:AddEffect("fCO_Egg_Random_01B", false, posX, posY)
  elseif 3 == index then
  elseif 4 == index then
    control:AddEffect("fUI_Horse_Upgrade_03A", false, posX, -50)
  elseif 5 == index then
    control:AddEffect("fUI_Horse_Upgrade_04A", false, posX, -50)
  elseif 6 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_05B", false, posX, posY)
  elseif 7 == index then
    if 9989 == servantKey or 9889 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06B", false, posX, posY)
    elseif 9988 == servantKey or 9888 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06C", false, posX, posY)
    elseif 9987 == servantKey or 9887 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06D", false, posX, posY)
    elseif 31611 == servantKey or 31612 == servantKey then
      control:AddEffect("fUI_Horse_Upgrade_06E", false, posX, posY)
    end
  elseif 8 == index then
  elseif 9 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_01A", false, posX, -80)
  elseif 10 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_01B", false, posX, -80)
  elseif 11 == index then
    control:AddEffect("fUI_Horse_Upgrade_NEW_01C", false, posX, -80)
  elseif 12 == index then
    control:AddEffect("fUI_Horse_Upgrade_06A", false, posX, posY)
  elseif 13 == index then
  elseif 14 == index then
    control:AddEffect("fUI_Horse_ExchangeFantasy_Gain_01A", false, posX, posY)
  elseif 15 == index then
    control:AddEffect("fUI_Horse_ExchangeFantasy_Summon_01A", false, posX, posY)
  elseif 16 == index then
    if 31539 == servantKey then
      control:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01A", false, posX, posY)
    elseif servantKey == 31575 then
      control:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01D", false, posX, posY)
    elseif 31557 == servantKey then
      control:AddEffect("fUI_Horse_ExchangeFantasy_Succes_01B", false, posX, posY)
    end
  elseif 17 == index then
    control:AddEffect("fUI_Horse_Upgrade_06A", false, posX, posY)
  end
  if nil ~= PaGlobal_ServantSwiftResult_All._effectControl and nil ~= PaGlobal_ServantSwiftResult_All._controlCount then
    PaGlobal_ServantSwiftResult_All._effectControl[PaGlobal_ServantSwiftResult_All._controlCount] = control
    PaGlobal_ServantSwiftResult_All._controlCount = PaGlobal_ServantSwiftResult_All._controlCount + 1
  end
end
function PaGlobalFunc_ServantSwiftResult_All_EffectErase()
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  for i = 0, PaGlobal_ServantSwiftResult_All._controlCount - 1 do
    if nil ~= PaGlobal_ServantSwiftResult_All._effectControl[i] then
      PaGlobal_ServantSwiftResult_All._effectControl[i]:EraseAllEffect()
    end
  end
end
function PaGlobalFunc_ServantSwiftResult_All_EffectClose()
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  PaGlobal_ServantSwiftResult_All._controlCount = 0
  PaGlobal_ServantSwiftResult_All._effectControl = {}
  Panel_Dialog_ServantSwiftResult_All:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold_Fantasy:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Success:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
end
function PaGlobalFunc_ServantSwiftResult_All_OnlyPanelShow(isShow)
  if nil == Panel_Dialog_ServantSwiftResult_All then
    return
  end
  Panel_Dialog_ServantSwiftResult_All:SetShow(isShow)
end
function PaGlobalFunc_ServantSwiftResult_All_fantasyVoltarionEffect()
  if Panel_Dialog_ServantSwiftResult_All == nil then
    return
  end
  Panel_Dialog_ServantSwiftResult_All:SetShow(true)
  local nakStableBG = "Combine/Etc/Combine_ETC_Nak_StableBG_04.dds"
  if nil ~= nakStableBG then
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:getBaseTexture():setUV(0, 0, 1, 1)
    PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:setRenderTexture(PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:getBaseTexture())
  end
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:ChangeTextureInfoNameAsync(nakStableBG)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetShow(true)
  PaGlobal_ServantSwiftResult_All._ui._stc_Fail:SetShow(false)
  PaGlobal_ServantSwiftResult_All._ui._stc_Horse_ToeHold:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_SERVANT_REGISTER_VOLTARION_TEXT"))
  PaGlobalFunc_ServantSwiftResult_All_AddEffect(Panel_Dialog_ServantSwiftResult_All, 7, 0, 280, 31611)
  audioPostEvent_SystemUi(13, 28)
  _AudioPostEvent_SystemUiForXBOX(13, 28)
  PaGlobal_ServantSwiftResult_All._timerNo = luaTimer_AddEvent(PaGlobalFunc_ServantSwiftResult_All_fantasyVoltarionEffectOff, 5000, false, 0)
end
function PaGlobalFunc_ServantSwiftResult_All_fantasyVoltarionEffectOff()
  PaGlobalFunc_ServantSwiftResult_All_EffectErase()
  PaGlobalFunc_ServantSwiftResult_All_EffectClose()
end
