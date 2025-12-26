function PaGlobal_MiniGame_SniperReload_All:initialize()
  if nil == Panel_MiniGame_SniperReload_All or true == PaGlobal_MiniGame_SniperReload_All._initialize then
    return
  end
  self._ui.stc_sniper_normal = UI.getChildControl(Panel_MiniGame_SniperReload_All, "Static_Sniper_Normal")
  local stc_sniper_normal_bg = UI.getChildControl(self._ui.stc_sniper_normal, "Static_BG")
  self._ui.stc_sniper_normal_reloadMark = UI.getChildControl(stc_sniper_normal_bg, "Static_ReloadMark")
  self._ui.stc_sniper_marnii = UI.getChildControl(Panel_MiniGame_SniperReload_All, "Static_Sniper_Marnii")
  local stc_sniper_marnii_bg = UI.getChildControl(self._ui.stc_sniper_marnii, "Static_BG")
  self._ui.stc_sniper_marnii_reloadMark = UI.getChildControl(stc_sniper_marnii_bg, "Static_ReloadMark")
  PaGlobal_MiniGame_SniperReload_All._ui.stc_spaceBar = UI.getChildControl(Panel_MiniGame_SniperReload_All, "Static_SpaceBar")
  PaGlobal_MiniGame_SniperReload_All._ui.txt_leftTime = UI.getChildControl(Panel_MiniGame_SniperReload_All, "StaticText_LeftTime")
  PaGlobal_MiniGame_SniperReload_All._ui.txt_desc = UI.getChildControl(Panel_MiniGame_SniperReload_All, "StaticText_Desc")
  self._ui.progress_reloadTimeBG = UI.getChildControl(Panel_MiniGame_SniperReload_All, "Static_TimerBG")
  self._ui.progress_reloadTime = UI.getChildControl(self._ui.progress_reloadTimeBG, "Progress2_Timer")
  PaGlobal_MiniGame_SniperReload_All._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MINIGAME_SNIPERRELOAD_DESC"))
  PaGlobal_MiniGame_SniperReload_All:registerEventHandler()
  PaGlobal_MiniGame_SniperReload_All:validate()
  self._isMarniiSniperRifle = false
  self._activeReloadControl = {}
  self._reloadFailed = false
  PaGlobal_MiniGame_SniperReload_All._initialize = true
end
function PaGlobal_MiniGame_SniperReload_All:registerEventHandler()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_Minigame_Sniper_All_OnScreenSize")
end
function PaGlobal_MiniGame_SniperReload_All:prepareOpen()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  self._isMarniiSniperRifle = ToClient_isEquipNewSniperRifle() == true and _ContentsGroup_NewSniperMode == true
  self._ui.stc_sniper_marnii:SetShow(false)
  self._ui.stc_sniper_normal:SetShow(false)
  self._activeReloadControl = {}
  if self._isMarniiSniperRifle == true then
    self._activeReloadControl.control = self._ui.stc_sniper_marnii
    self._activeReloadControl.reloadMark = self._ui.stc_sniper_marnii_reloadMark
    self._leftSuccessX = 248
    self._rightSuccessX = 308
    self._leftEndX = 108
    self._rightEndX = 442
    self._span = 167
  else
    self._activeReloadControl.control = self._ui.stc_sniper_normal
    self._activeReloadControl.reloadMark = self._ui.stc_sniper_normal_reloadMark
    self._leftSuccessX = 220
    self._rightSuccessX = 276
    self._leftEndX = 80
    self._rightEndX = 410
    self._span = 165
  end
  self._activeReloadControl.control:SetShow(true)
  self._reloadFailed = false
  Panel_MiniGame_SniperReload_All:RegisterUpdateFunc("Panel_Minigame_UpdateFunc")
  FromClient_Minigame_Sniper_All_OnScreenSize()
  PaGlobal_MiniGame_SniperReload_All:calculateRemainTime()
  PaGlobal_MiniGame_SniperReload_All:open()
end
function PaGlobal_MiniGame_SniperReload_All:open()
  if nil == Panel_MiniGame_SniperReload_All or true == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperReload_All:SetShow(true)
end
function PaGlobal_MiniGame_SniperReload_All:prepareClose()
  if nil == Panel_MiniGame_SniperReload_All or false == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._theta = 0
  self._reloadTimeLimit = self._config._reloadTimeDefault
  self._reloadRemainTime = self._config._reloadTimeDefault
  self._isMarniiSniperRifle = false
  self._ui.stc_sniper_normal_reloadMark:ResetVertexAni()
  self._ui.stc_sniper_marnii_reloadMark:ResetVertexAni()
  self._ui.stc_sniper_normal_reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui.stc_sniper_marnii_reloadMark:SetColor(Defines.Color.C_FFFFFFFF)
  Panel_MiniGame_SniperReload_All:ClearUpdateLuaFunc()
  PaGlobal_MiniGame_SniperReload_All:close()
end
function PaGlobal_MiniGame_SniperReload_All:close()
  if nil == Panel_MiniGame_SniperReload_All or false == Panel_MiniGame_SniperReload_All:GetShow() then
    return
  end
  Panel_MiniGame_SniperReload_All:SetShow(false)
end
function PaGlobal_MiniGame_SniperReload_All:calculateRemainTime()
  local remainTimeRate = ToClient_SniperGame_GetReloadSpeedRate()
  self._reloadTimeLimit = self._config._reloadTimeDefault / remainTimeRate
  self._reloadRemainTime = self._reloadTimeLimit
end
function PaGlobal_MiniGame_SniperReload_All:validate()
  if nil == Panel_MiniGame_SniperReload_All then
    return
  end
  PaGlobal_MiniGame_SniperReload_All._ui.stc_spaceBar:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.txt_leftTime:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.txt_desc:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.progress_reloadTimeBG:isValidate()
  PaGlobal_MiniGame_SniperReload_All._ui.progress_reloadTime:isValidate()
  self._ui.stc_sniper_normal:isValidate()
  self._ui.stc_sniper_normal_reloadMark:isValidate()
  self._ui.stc_sniper_marnii:isValidate()
  self._ui.stc_sniper_marnii_reloadMark:isValidate()
end
