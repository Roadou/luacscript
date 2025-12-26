local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_color = Defines.Color
function RoseWarRegion_ShowAni()
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  UIAni.fadeInSCR_MidOut(Panel_RoseWar_Region)
  local aniInfo = Panel_RoseWar_Region:addColorAnimation(0, 1.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo.IsChangeChild = false
  local aniInfo2 = self._ui._stc_regionName:addColorAnimation(0, 1.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo2:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo2:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo2.IsChangeChild = false
  local aniInfo3 = self._ui._stc_regionPlace:addColorAnimation(0, 1.05, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo3:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo3:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = false
  local aniInfo4 = self._ui._stc_line_L:addColorAnimation(0, 1.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo4:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo4:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo4.IsChangeChild = false
  local aniInfo5 = self._ui._stc_line_R:addColorAnimation(0, 1.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo5:SetStartColor(UI_color.C_00FFFFFF)
  aniInfo5:SetEndColor(UI_color.C_FFFFFFFF)
  aniInfo5.IsChangeChild = false
end
function RoseWarRegion_HideAni()
  local self = PaGlobal_RoseWarRegion
  if self == nil then
    return
  end
  Panel_RoseWar_Region:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo = Panel_RoseWar_Region:addColorAnimation(0, 1.5, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo.IsChangeChild = true
  aniInfo:SetHideAtEnd(true)
  aniInfo:SetDisableWhileAni(true)
end
function PaGlobal_RoseWarRegion:initialize()
  if self._initialize == true then
    return
  end
  self:registEventHandler()
  self:validate()
  Panel_RoseWar_Region:SetShow(false, false)
  Panel_RoseWar_Region:RegisterShowEventFunc(true, "RoseWarRegion_ShowAni()")
  Panel_RoseWar_Region:RegisterShowEventFunc(false, "RoseWarRegion_HideAni()")
  self._initialize = true
  if ToClient_IsRoseWarServer() == true and ToClient_IsFoundNearFierceBattleObjectInfo() == true then
    FromClient_RoseWarRegion_ChangeNearRegion(ToClient_GetFoundNearFierceBattleObjectInfoKeyRaw())
  else
    FromClient_RoseWarRegion_RemoveNearRegion()
  end
end
function PaGlobal_RoseWarRegion:registEventHandler()
  if Panel_RoseWar_Region == nil then
    return
  end
  registerEvent("FromClient_ChangedNearFierceBattleObjectInfo", "FromClient_RoseWarRegion_ChangeNearRegion")
  registerEvent("FromClient_FindNewNearFierceBattleObjectInfo", "FromClient_RoseWarRegion_FindNearRegion")
  registerEvent("FromClient_RemovedNearFierceBattleObjectInfo", "FromClient_RoseWarRegion_RemoveNearRegion")
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarRegion_ChangeRoseWarState")
end
function PaGlobal_RoseWarRegion:validate()
  if Panel_RoseWar_Region == nil then
    return
  end
end
function PaGlobal_RoseWarRegion:prepareOpen(fierceBattleKeyRaw)
  if Panel_RoseWar_Region == nil then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
  if fierceBattleObjectInfoWrapper == nil then
    return
  end
  local myRoseWarTeamNo = selfPlayer:getRoseWarTeamNo()
  if ToClient_IsRoseWarObserveMode() == true then
    myRoseWarTeamNo = ToClient_GetRoseObserveTeamNo()
  end
  local regionPlaceString = ""
  local fierceBattleObjectTeamNo = fierceBattleObjectInfoWrapper:getTeamNo()
  if fierceBattleObjectTeamNo == __eRoseWarTeam_Kamasylvia then
    regionPlaceString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_CAMP", "Param", PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_KAMASILVIA"))
  elseif fierceBattleObjectTeamNo == __eRoseWarTeam_Odyllita then
    regionPlaceString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_CAMP", "Param", PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_ODILITA"))
  elseif fierceBattleObjectTeamNo == __eRoseWarTeam_Neutral then
    regionPlaceString = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ROSEWAR_CAMP", "Param", PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_NEUTRAL"))
  else
    return
  end
  local regionPlaceFontColor = 0
  if fierceBattleObjectTeamNo == __eRoseWarTeam_Neutral then
    regionPlaceFontColor = 4292390039
  elseif myRoseWarTeamNo == fierceBattleObjectTeamNo then
    regionPlaceFontColor = 4282617292
  else
    regionPlaceFontColor = 4291845448
  end
  self._ui._stc_regionPlace:SetText(regionPlaceString)
  self._ui._stc_regionPlace:SetFontColor(regionPlaceFontColor)
  self._ui._stc_regionName:SetText(fierceBattleObjectInfoWrapper:getName())
  self._deltaTime = 0
  PaGlobalFunc_Radar_SetRegionSubNameText(fierceBattleObjectInfoWrapper:getName())
  PaGlobalFunc_WorldMinimap_SetRegionSubNameText(fierceBattleObjectInfoWrapper:getName())
  self:onScreenResize()
  self:open()
end
function PaGlobal_RoseWarRegion:open()
  if Panel_RoseWar_Region == nil then
    return
  end
  if Panel_Region ~= nil and Panel_Region:GetShow() == true then
    Panel_Region:SetShow(false, false)
  end
  Panel_RoseWar_Region:RegisterUpdateFunc("PaGlobalFunc_RoseWarRegion_Update")
  Panel_RoseWar_Region:SetShow(true, true)
end
function PaGlobal_RoseWarRegion:prepareClose()
  if Panel_RoseWar_Region == nil then
    return
  end
  self:close()
end
function PaGlobal_RoseWarRegion:close()
  if Panel_RoseWar_Region == nil then
    return
  end
  Panel_RoseWar_Region:ClearUpdateLuaFunc()
  Panel_RoseWar_Region:SetShow(false, true)
end
function PaGlobal_RoseWarRegion:onScreenResize()
  if Panel_RoseWar_Region == nil then
    return
  end
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_RoseWar_Region:SetSize(screenX, 64)
  Panel_RoseWar_Region:SetPosX(0)
  Panel_RoseWar_Region:SetPosY(screenY - 300)
  self._ui._stc_regionName:SetPosX(screenX / 2 - 256)
  self._ui._stc_regionPlace:SetPosX(screenX / 2 - 256)
  self._ui._stc_line_L:SetSize(screenX / 2 - 278, 11)
  self._ui._stc_line_R:SetSize(screenX / 2 - 278, 11)
  self._ui._stc_line_L:SetPosX(0)
  self._ui._stc_line_R:SetPosX(screenX - screenX / 2 + 278)
  self._ui._stc_line_L:SetPosY(32)
  self._ui._stc_line_R:SetPosY(32)
end
function PaGlobal_RoseWarRegion:update(deltaTime)
  if Panel_RoseWar_Region == nil then
    return
  end
  self._deltaTime = self._deltaTime + deltaTime
  if self._showTime <= self._deltaTime then
    self:prepareClose()
  end
end
