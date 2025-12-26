function PaGlobal_RoseWarTeamBuff:makeBuffIconList()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  self._buffUiPool = {}
  for index = 0, self._buffUiExpandCount - 1 do
    self:addBuffIcon(index)
  end
  self._currentBuffUiCount = self._buffUiExpandCount
end
function PaGlobal_RoseWarTeamBuff:expandBuffIconPool(expandCount)
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  local resultCount = self._currentBuffUiCount + expandCount
  for index = self._currentBuffUiCount, resultCount - 1 do
    self:addBuffIcon(index)
  end
  self._currentBuffUiCount = resultCount
end
function PaGlobal_RoseWarTeamBuff:addBuffIcon(index)
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  local controlId = "Static_BuffIcon_" .. tostring(index)
  local newControl = UI.cloneControl(self._ui._stc_buffTemplate, self._ui._stc_bg, controlId)
  if newControl == nil then
    UI.ASSERT_NAME(false, "\236\158\165\235\175\184\236\160\132\236\159\129 \236\160\132\236\136\160\236\167\128\235\143\132\236\151\144\236\132\156 \235\178\132\237\148\132\236\149\132\236\157\180\236\189\152\236\157\132 \236\131\157\236\132\177\237\149\152\236\167\128 \235\170\187\237\150\136\236\138\181\235\139\136\235\139\164.", "\234\182\140\236\132\160\236\154\169")
    return
  end
  newControl:SetShow(false)
  self._buffUiPool[index] = {_control = newControl}
end
function PaGlobal_RoseWarTeamBuff:makeBuffDataList()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  local selfPlayerWrapper = getSelfPlayer()
  if selfPlayerWrapper == nil then
    return
  end
  self._buffDataList = {}
  self._currentBuffCount = 0
  local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
  local fierceBattleObjectCount = ToClient_GetRoseWarFierceBattleObjectCount()
  for index = 0, fierceBattleObjectCount - 1 do
    local fierceBattleObjectInfoWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapperByIndex(index)
    if fierceBattleObjectInfoWrapper ~= nil and fierceBattleObjectInfoWrapper:getTeamNo() == selfPlayerTeamNo then
      local skillNo = ToClient_GetRoseWarFierceBattleObjectSkillNo(fierceBattleObjectInfoWrapper:getFierceBattleKeyRaw())
      if skillNo ~= 0 then
        local skillStaticWrapper = getSkillStaticStatus(skillNo, 1)
        if skillStaticWrapper ~= nil then
          local title = ""
          for buffIdx = 0, skillStaticWrapper:getBuffCount() - 1 do
            local buffIcon = skillStaticWrapper:getBuffIcon(buffIdx)
            if buffIcon ~= "" then
              local buffDesc = skillStaticWrapper:getBuffDescription(buffIdx)
              title = skillStaticWrapper:getName()
              self._buffDataList[self._currentBuffCount] = {
                _buffIcon = buffIcon,
                _buffDesc = buffDesc,
                _title = title
              }
              self._currentBuffCount = self._currentBuffCount + 1
            end
          end
        end
      end
    end
  end
end
function PaGlobal_RoseWarTeamBuff:updateBuffIcon()
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  local buffDataCount = self._currentBuffCount
  if buffDataCount > self._currentBuffUiCount then
    self:expandBuffIconPool(buffDataCount - self._currentBuffUiCount)
  end
  local totalSize = 0
  local gapX = 5
  for index = 0, self._currentBuffUiCount - 1 do
    local buffUiData = self._buffUiPool[index]
    if index < buffDataCount then
      buffUiData._control:ChangeTextureInfoNameAsync("icon/" .. self._buffDataList[index]._buffIcon)
      buffUiData._control:SetShow(true)
      totalSize = totalSize + buffUiData._control:GetSizeX() + gapX
      buffUiData._control:addInputEvent("Mouse_On", "PaGlobal_RoseWarTeamBuff:onHandlerBuffIcon(" .. tostring(index) .. ")")
      buffUiData._control:addInputEvent("Mouse_Out", "TooltipSimple_Hide()")
    else
      buffUiData._control:SetShow(false)
      buffUiData._control:addInputEvent("Mouse_On", "")
      buffUiData._control:addInputEvent("Mouse_Out", "")
    end
  end
  local startPosX = (self._ui._stc_bg:GetSizeX() - totalSize + gapX) / 2
  local curPosX = startPosX
  for index = 0, buffDataCount - 1 do
    self._buffUiPool[index]._control:SetPosX(curPosX)
    curPosX = curPosX + self._buffUiPool[index]._control:GetSizeX() + gapX
  end
end
function PaGlobal_RoseWarTeamBuff:onHandlerBuffIcon(index)
  if Panel_RoseWar_TeamBuff == nil then
    return
  end
  TooltipSimple_Show(self._buffUiPool[index]._control, self._buffDataList[index]._title, self._buffDataList[index]._buffDesc)
end
