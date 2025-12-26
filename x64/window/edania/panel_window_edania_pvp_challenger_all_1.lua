function PaGlobal_Edania_PVP_Challneger:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_BuffBG = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_BuffBG")
  self._ui._stc_EnemyBuffBoarder = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_EnemyBuffListBoarder")
  self._ui._stc_EnemyBuffIcon = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_EnemyBuffIcon")
  self._ui._stc_Selected = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_Selected")
  local mainBG = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_Main_BG")
  self._ui._stc_Line = UI.getChildControl(mainBG, "Static_Line")
  for idx = 1, __eEdanaChallengerCount do
    local mainBG = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_Main_BG")
    local playerControl = UI.getChildControl(mainBG, "Static_Player" .. tostring(idx))
    local playerInfo = {_control = playerControl, _userNo = 0}
    self._ui._stc_PlayerControl:push_back(playerInfo)
  end
  self._ui._txt_LeftTime = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "StaticText_Time")
  self._ui._stc_Direction = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_SelectedDirection")
  self._ui._stc_Circle = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "Static_SelectedCircle")
  self._ui._txt_TimeLeft = UI.getChildControl(Panel_Window_Edania_PVP_Challenger, "StaticText_TimeLeft")
  self:registEventHandler()
  self:validate()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._initialize = true
  if ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Edania) == true and ToClient_GetEdanaInstanceFieldMode() == __eEdaniaInstanceContentsMode_Challenger then
    self:prepareOpen()
  end
end
function PaGlobal_Edania_PVP_Challneger:registEventHandler()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  registerEvent("FromClient_UpdateEdaniaInstanceFieldChallengerHp", "FromClient_UpdateEdaniaInstanceFieldChallengerHp")
  registerEvent("update_Monster_Info_Req", "FromClient_UpdateEdaniaInstanceFieldChallengerUI")
end
function PaGlobal_Edania_PVP_Challneger:prepareOpen()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  Panel_Window_Edania_PVP_Challenger:RegisterUpdateFunc("FromClient_Edania_PVP_Challenger_UpdatePerFrame")
  Panel_Window_Edania_PVP_Challenger:ComputePosAllChild()
  self._ui._txt_TimeLeft:SetSpanSize(-self._ui._txt_TimeLeft:GetTextSizeX() * 0.5, self._ui._txt_TimeLeft:GetSpanSize().y)
  self:update()
  self:unRenderPanel()
  self:open()
end
function PaGlobal_Edania_PVP_Challneger:open()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  PaGlobal_Edania_PVP_HUD_Close()
  Panel_Window_Edania_PVP_Challenger:SetShow(true)
end
function PaGlobal_Edania_PVP_Challneger:prepareClose()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  Panel_Window_Edania_PVP_Challenger:ClearUpdateLuaFunc()
  self:close()
end
function PaGlobal_Edania_PVP_Challneger:close()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  Panel_Window_Edania_PVP_Challenger:SetShow(false)
end
function PaGlobal_Edania_PVP_Challneger:update()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  local edaniaRegion = ToClient_GetEdanaInstanceFieldEdaniaRegion()
  local state = ToClient_GetEdanaInstanceFieldState()
  if state == __eEdaniaInstanceContentsState_Ready or state == __eEdaniaInstanceContentsState_Play then
    self:initializeData(edaniaRegion)
  elseif state == __eEdaniaInstanceContentsState_Result then
    self._ui._txt_LeftTime:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_CASH_CUSTOMIZATION_BTN_EXIT"))
  end
end
function PaGlobal_Edania_PVP_Challneger:initializeData(edaniaRegion)
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  self._ui._stc_BuffBG:SetShow(false)
  self._ui._stc_Line:SetShow(false)
  self._ui._stc_EnemyBuffBoarder:SetShow(false)
  self._ui._stc_Selected:SetShow(false)
  self._ui._stc_Direction:SetShow(false)
  self._ui._stc_Circle:SetShow(false)
  self._challengerCount = 0
  for idx = 1, __eEdanaChallengerCount do
    local playerInfo = self._ui._stc_PlayerControl[idx]
    local control = playerInfo._control
    local hpControl = UI.getChildControl(control, "CircularProgress_1")
    local levelControl = UI.getChildControl(control, "StaticText_Level")
    local classControl = UI.getChildControl(control, "Static_ClassIcon")
    local challengerInfo = ToClient_GetEdanaChallengerInfo(edaniaRegion, idx - 1)
    if challengerInfo ~= nil and challengerInfo:getChallengerState() == __eEdanaChallengerState_Challenger then
      local challengerUserNo = challengerInfo:getUserNo()
      playerInfo._userNo = challengerUserNo
      if challengerInfo:getUserNo() ~= selfPlayerWrapper:getUserNo() then
        control:SetShow(true)
        control:SetMonoTone(false)
        hpControl:SetProgressRate(0)
        levelControl:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SKILL_DEEPSKILL_LEVEL", "level", tostring(challengerInfo:getLevel())))
        local classSymbomInfo = NewClassData.newClass_Texture_ID[challengerInfo:getClassType()]._symbolTextureTID
        if classSymbomInfo ~= nil then
          classControl:ChangeTextureInfoTextureIDAsync(classSymbomInfo, 0)
          classControl:setRenderTexture(classControl:getBaseTexture())
        end
        self._challengerCount = self._challengerCount + 1
      else
        playerInfo._userNo = 0
        control:SetShow(false)
      end
    else
      playerInfo._userNo = 0
      control:SetShow(false)
    end
  end
  if self._challengerCount <= 0 then
    return
  end
  local controlIndex = 0
  for idx = 1, __eEdanaChallengerCount do
    local playerInfo = self._ui._stc_PlayerControl[idx]
    if playerInfo._userNo ~= 0 then
      playerInfo._control:SetSpanSize(self:getUIPositionX(controlIndex, self._challengerCount, 80), playerInfo._control:GetSpanSize().y)
      controlIndex = controlIndex + 1
    end
  end
  self._ui._stc_Line:SetShow(true)
  self._ui._stc_Line:SetSize(self._challengerCount * (self._ui._stc_PlayerControl[1]._control:GetSizeX() + 30) + 50, self._ui._stc_Line:GetSizeY())
  self._ui._stc_Line:ComputePos()
end
function PaGlobal_Edania_PVP_Challneger:getUIPositionX(index, count, spacing)
  local mid = (count - 1) / 2
  return (index - mid) * spacing
end
function PaGlobal_Edania_PVP_Challneger:updateUserHp(rankIndex, leftPercent)
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  local control = self._ui._stc_PlayerControl[rankIndex + 1]._control
  if control == nil then
    return
  end
  local hpControl = UI.getChildControl(control, "CircularProgress_1")
  hpControl:SetProgressRate(math.floor(leftPercent / 10000))
  if leftPercent <= 0 then
    control:SetMonoTone(true)
  end
end
function PaGlobal_Edania_PVP_Challneger:unRenderPanel()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  local targetPanel = Array.new()
  targetPanel:push_back(Panel_PersonalIcon_Left)
  targetPanel:push_back(Panel_MainQuest)
  targetPanel:push_back(Panel_CheckedQuest)
  targetPanel:push_back(Panel_Widget_Function)
  for idx = 1, #targetPanel do
    if targetPanel[idx] ~= nil then
      targetPanel[idx]:SetRenderAndEventHide(true)
    end
  end
end
function PaGlobal_Edania_PVP_Challneger:validate()
  if Panel_Window_Edania_PVP_Challenger == nil then
    return
  end
  self._ui._stc_BuffBG:isValidate()
  self._ui._stc_EnemyBuffBoarder:isValidate()
  self._ui._stc_EnemyBuffIcon:isValidate()
  self._ui._stc_Selected:isValidate()
  self._ui._stc_Line:isValidate()
  for idx = 1, __eEdanaChallengerCount do
    self._ui._stc_PlayerControl[idx]._control:isValidate()
  end
  self._ui._txt_LeftTime:isValidate()
  self._ui._stc_Direction:isValidate()
  self._ui._stc_Circle:isValidate()
  self._ui._txt_TimeLeft:isValidate()
end
