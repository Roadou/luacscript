function PaGlobal_RoseWarMiniMap:makeMiniMapFierceBattleObjectTooltip()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._ui._stc_objectTooltip = UI.getChildControl(Panel_RoseWar_MiniMap, "Static_FierceBattleObject_Tooltip")
  self._ui._stc_objectTooltip_Altar_BG = UI.getChildControl(self._ui._stc_objectTooltip, "Static_Altar_BG")
  self._ui._stc_shadow = UI.getChildControl(self._ui._stc_objectTooltip, "Static_Shadow")
  self._ui._stc_objectTooltip_flag = UI.getChildControl(self._ui._stc_objectTooltip, "Static_Flag")
  self._ui._stc_objectTooltip_image = UI.getChildControl(self._ui._stc_objectTooltip, "Static_Image")
  self._ui._stc_objectTooltip_monsterIcon = UI.getChildControl(self._ui._stc_objectTooltip, "Static_Monster")
  self._ui._stc_objectTooltip_icon = UI.getChildControl(self._ui._stc_objectTooltip, "Static_Icon")
  self._ui._stc_objectTooltip_cooltime = UI.getChildControl(self._ui._stc_objectTooltip_icon, "StaticText_CoolTime")
  self._ui._stc_objectTooltip_title = UI.getChildControl(self._ui._stc_objectTooltip, "StaticText_Title")
  self._ui._stc_objectTooltip_desc = UI.getChildControl(self._ui._stc_objectTooltip, "StaticText_Desc")
  self._ui._stc_objectTooltip_progressBox = UI.getChildControl(self._ui._stc_objectTooltip, "Static_ProgressBox")
  self._ui._stc_objectTooltip_red = UI.getChildControl(self._ui._stc_objectTooltip_progressBox, "Progress2_Red")
  self._ui._stc_objectTooltip_blue = UI.getChildControl(self._ui._stc_objectTooltip_progressBox, "Progress2_Blue")
end
function PaGlobal_RoseWarMiniMap:setShowMiniMapFierceBattleObjectTooltip(isCommander, teamNo, fierceBattleKeyRaw, isShow)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if isShow == true then
    self:setTooltipData(isCommander, teamNo, fierceBattleKeyRaw)
    self:setTitleDescFireceBattleObjectTooltip()
    self:setTextureKeyFireceBattleObjectTooltip()
    self:updateHpBarFireceBattleObjectTooltip(self._tooltipData._fierceBattleKeyRaw, false)
    self:updateSize()
    self:setTooltipPos()
  elseif isCommander == true then
    local iconData = self._miniMapBossIconList[teamNo]
    if iconData ~= nil then
      iconData._miniIconControl._box:SetShow(true)
      iconData._bigIconControl._box:SetShow(false)
    end
  end
  self._ui._stc_objectTooltip:SetShow(isShow)
end
function PaGlobal_RoseWarMiniMap:setTooltipData(isCommander, teamNo, fierceBattleKeyRaw)
  local tooltipType = self._eTooltipType.NONE
  local characterKey
  if isCommander == true then
    tooltipType = self._eTooltipType.COMMANDER
    local iconData = self._miniMapBossIconList[teamNo]
    if iconData ~= nil then
      iconData._miniIconControl._box:SetShow(false)
      iconData._bigIconControl._box:SetShow(true)
      characterKey = iconData._characterKey
    end
  else
    local fierceBattleIconData = self:getFierceBattleObjectIconData(fierceBattleKeyRaw)
    if fierceBattleIconData ~= nil then
      local fierceBattleIconDataWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleIconData._fierceBattleKeyRaw)
      if fierceBattleIconDataWrapper ~= nil then
        if ToClient_IsRoseWarGimicFierceBattle(fierceBattleIconDataWrapper:getCharacterKeyRaw()) == true then
          tooltipType = self._eTooltipType.FIERCE_BATTLE_GIMIC
        else
          tooltipType = self._eTooltipType.FIERCE_BATTLE
        end
        teamNo = fierceBattleIconDataWrapper:getTeamNo()
        characterKey = fierceBattleIconDataWrapper:getCharacterKeyRaw()
      end
    end
  end
  if tooltipType == self._eTooltipType.NONE then
    return
  end
  self._tooltipData = {
    _type = tooltipType,
    _fierceBattleKeyRaw = fierceBattleKeyRaw,
    _teamNo = teamNo,
    _characterKey = characterKey
  }
end
function PaGlobal_RoseWarMiniMap:setTitleDescFireceBattleObjectTooltip()
  if self._tooltipData == nil then
    return
  end
  local title = ""
  local desc = ""
  if self._tooltipData._type == self._eTooltipType.COMMANDER then
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_TITLE")
    if self._tooltipData._characterKey ~= nil then
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(self._tooltipData._characterKey)
      desc = characterStaticStatusWarpper:getName()
    else
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ROSEWAR_WORLDMAP_TOOLTIP_TITLE")
    end
  else
    local fierceBattleStaticStatusWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(self._tooltipData._fierceBattleKeyRaw)
    title = fierceBattleStaticStatusWrapper:getName()
    local buffDesc = self:getFierceBattleObjectBuffDesc(self._tooltipData._fierceBattleKeyRaw)
    if buffDesc ~= "" then
      desc = buffDesc
    else
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(self._tooltipData._characterKey)
      desc = characterStaticStatusWarpper:getName()
    end
  end
  self._ui._stc_objectTooltip_title:SetText(title)
  self._ui._stc_objectTooltip_desc:SetText(desc)
end
function PaGlobal_RoseWarMiniMap:setTextureKeyFireceBattleObjectTooltip()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._tooltipData == nil then
    return
  end
  local textureData
  if self._tooltipData._type == self._eTooltipType.COMMANDER then
    if self._tooltipData._teamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
      textureData = {
        _bg = "Combine_Etc_RoseWar_Command_Wight_Frm_ToolTip_BG_1",
        _icon = "Combine_Etc_RoseWar_Command_Wight_Img_Profile_1"
      }
    elseif self._tooltipData._teamNo == Defines.RoseWarTeamNo.ODYLLITA then
      textureData = {
        _bg = "Combine_Etc_RoseWar_Command_Wight_Frm_ToolTip_BG_1",
        _icon = "Combine_Etc_RoseWar_Command_Wight_Img_Profile_3"
      }
    else
      UI.ASSERT_NAME(false, "\235\140\128\236\157\145 \235\144\152\236\167\128 \236\149\138\236\157\128 \236\158\145\236\151\133\236\158\133\235\139\136\235\139\164.", "\234\182\140\236\132\160\236\154\169")
    end
  elseif self._tooltipData._type == self._eTooltipType.FIERCE_BATTLE then
    local monsterImg = ToClient_GetRoseWarFierceBattleObjectTooltipImgPath(self._tooltipData._characterKey)
    textureData = {
      _bg = "Combine_Etc_RoseWar_Command_Wight_Frm_ToolTip_BG_1",
      _icon = monsterImg
    }
  elseif self._tooltipData._type == self._eTooltipType.FIERCE_BATTLE_GIMIC then
    local fierceBattleBuffStaticStatusWrapper = ToClient_GetRoseWarGimicFierceBattleBuffStaticStatusWrapper(self._tooltipData._fierceBattleKeyRaw)
    local buffType = fierceBattleBuffStaticStatusWrapper:getBuffType()
    local buffIcon = "Combine_Etc_RoseWar_Command_Icon_Map_Mode_3"
    textureData = {
      _bg = "Combine_Etc_RoseWar_Command_Wight_Frm_ToolTip_BG_2",
      _icon = buffIcon
    }
  else
    UI.ASSERT_NAME(false, "\235\140\128\236\157\145\235\144\152\236\167\128 \236\149\138\236\157\128 \236\158\145\236\151\133\236\158\133\235\139\136\235\139\164.", "\234\182\140\236\132\160\236\154\169")
  end
  if textureData == nil then
    return
  end
  if self._tooltipData._type == self._eTooltipType.FIERCE_BATTLE_GIMIC then
    self._ui._stc_shadow:SetShow(false)
    self._ui._stc_objectTooltip_image:SetShow(false)
    self._ui._stc_objectTooltip_monsterIcon:SetShow(false)
    self._ui._stc_objectTooltip_icon:SetShow(true)
    self._ui._stc_objectTooltip_icon:ChangeTextureInfoTextureIDAsync(textureData._icon, __eUITextureTypeBase)
    self._ui._stc_objectTooltip_icon:setRenderTexture(self._ui._stc_objectTooltip_icon:getBaseTexture())
  elseif self._tooltipData._type == self._eTooltipType.COMMANDER then
    self._ui._stc_shadow:SetShow(true)
    self._ui._stc_objectTooltip_icon:SetShow(false)
    self._ui._stc_objectTooltip_monsterIcon:SetShow(false)
    self._ui._stc_objectTooltip_image:SetShow(true)
    self._ui._stc_objectTooltip_image:ChangeTextureInfoTextureIDAsync(textureData._icon, __eUITextureTypeBase)
    self._ui._stc_objectTooltip_image:setRenderTexture(self._ui._stc_objectTooltip_image:getBaseTexture())
  elseif self._tooltipData._type == self._eTooltipType.FIERCE_BATTLE then
    self._ui._stc_shadow:SetShow(true)
    self._ui._stc_objectTooltip_icon:SetShow(false)
    self._ui._stc_objectTooltip_image:SetShow(false)
    self._ui._stc_objectTooltip_monsterIcon:SetShow(true)
    self._ui._stc_objectTooltip_monsterIcon:ChangeTextureInfoNameAsync(textureData._icon)
    self._ui._stc_objectTooltip_monsterIcon:setRenderTexture(self._ui._stc_objectTooltip_monsterIcon:getBaseTexture())
  end
  self._ui._stc_objectTooltip_Altar_BG:ChangeTextureInfoTextureIDAsync(textureData._bg, __eUITextureTypeBase)
  self._ui._stc_objectTooltip_Altar_BG:setRenderTexture(self._ui._stc_objectTooltip_Altar_BG:getBaseTexture())
  local flagTextureName = ""
  if self._tooltipData._teamNo == Defines.RoseWarTeamNo.KAMASYLVIA then
    flagTextureName = "Combine_Etc_RoseWar_CampList_Icon_Flag_Kama"
  elseif self._tooltipData._teamNo == Defines.RoseWarTeamNo.ODYLLITA then
    flagTextureName = "Combine_Etc_RoseWar_CampList_Icon_Flag_Odil"
  elseif self._tooltipData._teamNo == Defines.RoseWarTeamNo.NEUTRAL then
    flagTextureName = ""
  else
    UI.ASSERT_NAME(false, "\235\140\128\236\157\145 \235\144\152\236\167\128 \236\149\138\236\157\128 \236\158\145\236\151\133\236\158\133\235\139\136\235\139\164.", "\234\182\140\236\132\160\236\154\169")
  end
  self._ui._stc_objectTooltip_flag:ChangeTextureInfoTextureIDAsync(flagTextureName, __eUITextureTypeBase)
  self._ui._stc_objectTooltip_flag:setRenderTexture(self._ui._stc_objectTooltip_flag:getBaseTexture())
  local progressTextureKey
  if self._tooltipData._type == self._eTooltipType.COMMANDER then
    progressTextureKey = "Combine_Etc_RoseWar_Command_Wight_Progress_ToolTip_Red"
  elseif self._tooltipData._type == self._eTooltipType.FIERCE_BATTLE_GIMIC then
    progressTextureKey = "Combine_Etc_RoseWar_Command_Wight_Progress_ToolTip_Red"
  else
    local selfPlayerWrapper = getSelfPlayer()
    if selfPlayerWrapper ~= nil then
      local selfPlayerTeamNo = selfPlayerWrapper:getRoseWarTeamNo()
      if ToClient_IsRoseWarObserveMode() == true then
        selfPlayerTeamNo = ToClient_GetRoseObserveTeamNo()
      end
      if self._tooltipData._teamNo == Defines.RoseWarTeamNo.NEUTRAL then
        progressTextureKey = "Combine_Etc_RoseWar_Command_Wight_Progress_ToolTip_Gray"
      elseif self._tooltipData._teamNo == selfPlayerTeamNo then
        progressTextureKey = "Combine_Etc_RoseWar_Command_Wight_Progress_ToolTip_Blue"
      else
        progressTextureKey = "Combine_Etc_RoseWar_Command_Wight_Progress_ToolTip_Red"
      end
    end
  end
  if progressTextureKey ~= nil then
    self._ui._stc_objectTooltip_red:ChangeTextureInfoTextureIDAsync(progressTextureKey, __eUITextureTypeBase)
    self._ui._stc_objectTooltip_red:setRenderTexture(self._ui._stc_objectTooltip_red:getBaseTexture())
  end
end
function PaGlobal_RoseWarMiniMap:updateHpBarFireceBattleObjectTooltip(fierceBattleKeyRaw, isDeltaUpdate)
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._tooltipData == nil then
    return
  end
  if self._tooltipData._fierceBattleKeyRaw ~= fierceBattleKeyRaw then
    return
  end
  self._ui._stc_objectTooltip_cooltime:SetShow(false)
  if self._tooltipData._type == self._eTooltipType.FIERCE_BATTLE_GIMIC then
    local roseWarGimmickIconData = self:getFierceBattleObjectIconData(fierceBattleKeyRaw)
    if roseWarGimmickIconData == nil then
      return
    end
    if isDeltaUpdate == true and roseWarGimmickIconData._isDead == false then
      return
    end
    local curTime = Int64toInt32(getServerUtc64())
    if curTime < roseWarGimmickIconData._nextSpawnTime then
      local remainTime = roseWarGimmickIconData._nextSpawnTime - curTime
      local remainHundredRate = remainTime / self._gimmickRespawnTime * 100
      self._ui._stc_objectTooltip_cooltime:SetShow(true)
      self._ui._stc_objectTooltip_cooltime:SetText(tostring(remainTime))
      self._ui._stc_objectTooltip_blue:SetShow(false)
      self._ui._stc_objectTooltip_red:SetShow(true)
      self._ui._stc_objectTooltip_red:SetProgressRate(remainHundredRate)
    else
      local fierceBattleIconDataWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(fierceBattleKeyRaw)
      if fierceBattleIconDataWrapper == nil then
        return
      end
      local adrenalinPoint = fierceBattleIconDataWrapper:getAdrenalinPoint()
      local adrenalinRate = self:getAdrenalinRate(adrenalinPoint)
      self._ui._stc_objectTooltip_red:SetShow(false)
      self._ui._stc_objectTooltip_blue:SetShow(true)
      if IsSelfPlayerRoseWarGrade_Commander() == false and IsSelfPlayerRoseWarGrade_SubCommander() == false then
        adrenalinRate = 0
      end
      self._ui._stc_objectTooltip_blue:SetProgressRate(adrenalinRate)
    end
  else
    self._ui._stc_objectTooltip_blue:SetShow(false)
    self._ui._stc_objectTooltip_red:SetShow(true)
    local progressRatioHundred = 100
    if self._tooltipData._type == self._eTooltipType.COMMANDER then
      local roseWarBossInfo = ToClient_GetRoseWarBossInfoXXX(self._tooltipData._teamNo)
      if roseWarBossInfo ~= nil then
        progressRatioHundred = roseWarBossInfo._currentHpRatio * 100
      end
    else
      local fierceBattleIconDataWrapper = ToClient_GetRoseWarFierceBattleObjectInfoWrapper(self._tooltipData._fierceBattleKeyRaw)
      if fierceBattleIconDataWrapper == nil then
        return
      end
      progressRatioHundred = fierceBattleIconDataWrapper:getCurrentHpRatio() * 100
    end
    self._ui._stc_objectTooltip_red:SetProgressRate(progressRatioHundred)
  end
end
function PaGlobal_RoseWarMiniMap:setTooltipPos()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  if self._tooltipData == nil then
    return
  end
  local targetControl
  local gapX = 0
  local gapY = -20
  if self._tooltipData._type == self._eTooltipType.COMMANDER then
    local bossIconData = self._miniMapBossIconList[self._tooltipData._teamNo]
    if bossIconData == nil then
      return
    end
    targetControl = bossIconData._control
  else
    local fierceBattleIconData = self:getFierceBattleObjectIconData(self._tooltipData._fierceBattleKeyRaw)
    if fierceBattleIconData == nil then
      return
    end
    targetControl = fierceBattleIconData._control
    gapX = 25
    gapY = 0
  end
  local screenSizeX = getScreenSizeX()
  local minimapLTRB = self:getMiniMapLTRB()
  local posX = minimapLTRB.left + targetControl:GetPosX() + targetControl:GetSizeX() + gapX
  local isLeft = false
  if screenSizeX < posX + self._ui._stc_objectTooltip:GetSizeX() then
    isLeft = true
  end
  if isLeft == true then
    posX = minimapLTRB.left + targetControl:GetPosX() - self._ui._stc_objectTooltip:GetSizeX()
  end
  self._ui._stc_objectTooltip:SetPosXY(posX, minimapLTRB.top + targetControl:GetPosY() - (self._ui._stc_objectTooltip:GetSizeY() - targetControl:GetSizeY()) / 2 + gapY)
end
function PaGlobal_RoseWarMiniMap:updateTooltipProgressUI()
  if self._tooltipData == nil then
    return
  end
  self:updateHpBarFireceBattleObjectTooltip(self._tooltipData._fierceBattleKeyRaw, true)
end
function PaGlobal_RoseWarMiniMap:updateSize()
  if Panel_RoseWar_MiniMap == nil then
    return
  end
  self._ui._stc_objectTooltip:SetSize(self._ui._stc_objectTooltip:GetSizeX(), 110 + self._ui._stc_objectTooltip_desc:GetTextSizeY())
end
