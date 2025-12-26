PaGlobal_RoseWarMain = {
  _prevUIMode = nil,
  _renderMode = nil,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_RoseWarMainInit")
function FromClient_RoseWarMainInit()
  PaGlobal_RoseWarMain:initialize()
end
function PaGlobal_RoseWarMain:initialize()
  if self._initialize == true then
    return
  end
  self._prevUIMode = Defines.UIMode.eUIMode_Default
  self._renderMode = RenderModeWrapper.new(99, {
    Defines.RenderMode.eRenderMode_RoseWar
  }, false)
  self._renderMode:setClosefunctor(nil, PaGlobalFunc_RoseWarMain_Close)
  registerEvent("FromClient_ChangeRoseWarState", "FromClient_RoseWarMain_ChangeRoseWarState")
  registerEvent("FromClient_UnsetRoseWarObserveMode", "FromClient_RoseWarMain_UnsetRoseWarObserveMode")
  self._initialize = true
end
function PaGlobal_RoseWarMain:open()
  if Panel_RoseWar_Main == nil then
    return
  end
  self._renderMode:set()
  self._prevUIMode = GetUIMode()
  SetUIMode(Defines.UIMode.eUIMode_RoseWar)
  Panel_RoseWar_Main:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_RoseWar_Main:ComputePosAllChild()
  Panel_RoseWar_Main:SetShow(true)
  PaGlobalFunc_RoseWarMiniMap_Open()
  if PaGlobalFunc_RoseWarMiniMap_IsShow() == false then
    self:close()
  end
end
function PaGlobal_RoseWarMain:close()
  if Panel_RoseWar_Main == nil then
    return
  end
  ToClient_HideRoseWarMain()
  PaGlobal_RoseWarMain._renderMode:reset()
  SetUIMode(PaGlobal_RoseWarMain._prevUIMode)
  PaGlobal_RoseWarMain._prevUIMode = Defines.UIMode.eUIMode_Default
  Panel_RoseWar_Main:SetShow(false)
  PaGlobalFunc_RoseWarMiniMap_Close()
end
function PaGlobalFunc_RoseWarMain_Open()
  if Panel_RoseWar_Main == nil then
    return
  end
  if ToClient_IsRoseWarServer() == false then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoCantActionOnlyRoseWarServer"))
    return
  end
  if ToClient_ShowRoseWarMain() == false then
    return
  end
  PaGlobal_RoseWarMain:open()
end
function PaGlobalFunc_RoseWarMain_Close()
  if Panel_RoseWar_Main == nil then
    return
  end
  if 0 < ToClient_GetRoseWarSelectIconListCount() then
    ToClient_ClearRoseWarSelectIconList()
    return
  end
  if PaGlobalFunc_RoseWarCommand_IsShow() == true then
    PaGlobalFunc_RoseWarCommand_Close()
    return
  end
  PaGlobal_RoseWarMain:close()
end
function FromClient_RoseWarMain_ChangeRoseWarState(state)
  if Panel_RoseWar_Main == nil or state == nil then
    return
  end
  if state == __eRoseWar_Stop then
    ToClient_ClearRoseWarSelectIconList()
    PaGlobalFunc_RoseWarCommand_Close()
    if Panel_RoseWar_Main:GetShow() == true then
      PaGlobal_RoseWarMain:close()
    end
  end
end
function FromClient_RoseWarMain_UnsetRoseWarObserveMode()
  if Panel_RoseWar_Main == nil then
    return
  end
  if Panel_RoseWar_Main:GetShow() == true then
    PaGlobal_RoseWarMain:close()
  end
end
function IsSelfPlayerRoseWarGrade_Commander()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getRoseWarGradeType() == __eRoseWarPlayerGradeType_Commander
end
function IsSelfPlayerRoseWarGrade_SubCommander()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getRoseWarGradeType() == __eRoseWarPlayerGradeType_SubCommander
end
function IsSelfPlayerRoseWarGrade_GuildPartyLeader()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getRoseWarGradeType() == __eRoseWarPlayerGradeType_GuildPartyLeader
end
function IsSelfPlayerRoseWarGrade_GuildMember()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getRoseWarGradeType() == __eRoseWarPlayerGradeType_GuildMember
end
function IsSelfPlayerRoseWarGrade_MercenaryPartyLeader()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getRoseWarGradeType() == __eRoseWarPlayerGradeType_MercenaryPartyLeader
end
function IsSelfPlayerRoseWarGrade_Mercenary()
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return false
  end
  return selfPlayerWrapper:getRoseWarGradeType() == __eRoseWarPlayerGradeType_Mercenary
end
function IsMouseInRoseWarPanel(panel)
  if panel == nil then
    return false
  end
  if panel:GetShow() == false then
    return false
  end
  local panelPosX = panel:GetPosX()
  local panelPosY = panel:GetPosY()
  local panelSizeX = panel:GetSizeX()
  local panelSizeY = panel:GetSizeY()
  local lt = float2(panelPosX, panelPosY)
  local rb = float2(panelPosX + panelSizeX, panelPosY + panelSizeY)
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  if mousePosX >= lt.x and mousePosX <= rb.x and mousePosY >= lt.y and mousePosY <= rb.y then
    return true
  end
  return false
end
