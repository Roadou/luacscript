local VCK = CppEnums.VirtualKeyCode
function FromClient_AddFlickerPin(uiControl, position, isForGuild, PinInfo)
  uiControl:EraseAllEffect()
  local guideParam = NavigationGuideParam()
  if nil ~= PinInfo then
    guideParam._pingType = PinInfo._notifyPingTypeBDO
  end
  if isForGuild then
    local effectName = "UI_WorldMap_Ping01"
    if nil ~= PaGlobalFunc_Radar_Pin_GetPingEffectName then
      effectName = PaGlobalFunc_Radar_Pin_GetPingEffectName(PinInfo._notifyPingTypeBDO, isForGuild)
    end
    uiControl:AddEffect(effectName, false, 0, 0)
    if nil ~= PinInfo then
      guideParam._color = PinInfo:getPingColor()
      guideParam._bgColor = PinInfo:getPingBGColor()
      guideParam._beamColor = PinInfo:getPingBeamColor()
    else
      guideParam._color = float4(1, 0.8, 0.6, 1)
      guideParam._bgColor = float4(0.6, 0.2, 0.2, 0.3)
      guideParam._beamColor = float4(0.4, 0.15, 0.15, 1)
    end
  else
    local effectName = "UI_WorldMap_Ping02"
    if nil ~= PaGlobalFunc_Radar_Pin_GetPingEffectName then
      effectName = PaGlobalFunc_Radar_Pin_GetPingEffectName(pingType, isForGuild)
    end
    uiControl:AddEffect(effectName, false, 0, 0)
    if nil ~= PinInfo then
      guideParam._color = PinInfo:getPingColor()
      guideParam._bgColor = PinInfo:getPingBGColor()
      guideParam._beamColor = PinInfo:getPingBeamColor()
    else
      guideParam._color = float4(1, 0.8, 0.6, 1)
      guideParam._bgColor = float4(0.6, 0.2, 0.2, 0.3)
      guideParam._beamColor = float4(0.4, 0.15, 0.15, 1)
    end
  end
  worldmap_addNavigationBeam(position, guideParam, true)
end
function FromClient_UpdatePingTypeIcon(pingTypeIcon, pingType, isForGuild)
  if nil == pingTypeIcon then
    return
  end
  if nil == isForGuild or false == isForGuild then
    pingTypeIcon:SetShow(false)
    return
  end
  if pingType == __eNotifyPingTypeBDO_Attack then
    pingTypeIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Ping_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(pingTypeIcon, 404, 62, 464, 122)
    pingTypeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    pingTypeIcon:setRenderTexture(pingTypeIcon:getBaseTexture())
  elseif pingType == __eNotifyPingTypeBDO_Dangerous then
    pingTypeIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Ping_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(pingTypeIcon, 282, 62, 342, 122)
    pingTypeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    pingTypeIcon:setRenderTexture(pingTypeIcon:getBaseTexture())
  elseif pingType == __eNotifyPingTypeBDO_Move then
    pingTypeIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Ping_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(pingTypeIcon, 343, 62, 403, 122)
    pingTypeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    pingTypeIcon:setRenderTexture(pingTypeIcon:getBaseTexture())
  elseif pingType == __eNotifyPingTypeBDO_Help then
    pingTypeIcon:ChangeTextureInfoNameAsync("Combine/Etc/Combine_Etc_Ping_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(pingTypeIcon, 465, 62, 525, 122)
    pingTypeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
    pingTypeIcon:setRenderTexture(pingTypeIcon:getBaseTexture())
  else
    pingTypeIcon:SetShow(false)
  end
end
function FromClient_LDownWorldMapPanel()
  if isKeyPressed(VCK.KeyCode_CONTROL) then
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      return
    end
    ToClient_requestWordmapPin(true, false, ToClient_GetPingType())
  elseif isKeyPressed(VCK.KeyCode_SHIFT) then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    if false == selfPlayer:hasParty() then
      return
    end
    ToClient_requestWordmapPin(false, false, __eNotifyPingTypeBDO_None)
  end
end
function FromClient_LDoubleClickWorldMapPanel()
  if isKeyPressed(VCK.KeyCode_CONTROL) then
    local guildWrapper = ToClient_GetMyGuildInfoWrapper()
    if nil == guildWrapper then
      return
    end
    ToClient_requestWordmapPin(true, true, ToClient_GetPingType())
  elseif isKeyPressed(VCK.KeyCode_SHIFT) then
    local selfPlayerWrapper = getSelfPlayer()
    if nil == selfPlayerWrapper then
      return
    end
    local selfPlayer = selfPlayerWrapper:get()
    if nil == selfPlayer then
      return
    end
    if false == selfPlayer:hasParty() then
      return
    end
    ToClient_requestWordmapPin(false, true, __eNotifyPingTypeBDO_None)
  end
end
function FromClient_LClickPin(actorKey, isForGuild)
  if isKeyPressed(VCK.KeyCode_CONTROL) and true == isForGuild then
    ToClient_RequestDeletePositionGuide(actorKey, isForGuild)
  elseif isKeyPressed(VCK.KeyCode_SHIFT) and false == isForGuild then
    ToClient_RequestDeletePositionGuide(actorKey, isForGuild)
  end
end
registerEvent("FromClient_AddFlickerPin", "FromClient_AddFlickerPin")
registerEvent("FromClient_LDownWorldMapPanel", "FromClient_LDownWorldMapPanel")
registerEvent("FromClient_LDoubleClickWorldMapPanel", "FromClient_LDoubleClickWorldMapPanel")
registerEvent("FromClient_LClickPin", "FromClient_LClickPin")
registerEvent("FromClient_UpdatePingTypeIcon", "FromClient_UpdatePingTypeIcon")
