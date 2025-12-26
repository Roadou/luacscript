function PaGlobal_InteractionGathering_All_Open()
  if UI_Character_InterActionGathering_All == nil then
    return false
  end
  return PaGlobal_InteractionGathering_All:prepareOpen()
end
function PaGlobal_InteractionGathering_All_Close()
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  PaGlobal_InteractionGathering_All:prepareClose()
end
function PaGlobal_InteractionGathering_All_ButtonPushed(keycode, key)
  local self = PaGlobal_InteractionGathering_All
  if self == nil then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : PaGlobal_InteractionGathering_All")
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  DragManager:clearInfo()
  if keycode ~= CppEnums.ActionInputType.ActionInputType_Interaction then
    setUiInputProcessed(keycode)
  end
  if FGlobal_GetIsCutScenePlay() == true and FGlobal_GetIsCutScenePlayerControlMode() == false then
    return
  end
  preUIMode = GetUIMode()
  if PaGlobal_SkillGroup ~= nil and Panel_Window_SkillGroup:GetShow() == true and PaGlobal_SkillGroup._isWindow == false then
    return
  end
  if PaGlobal_SkillGroup_All ~= nil and true == Panel_Window_SkillGroup_All:GetShow() and PaGlobal_SkillGroup_All._isWindow == false then
    return
  end
  local actorWrapper = interaction_getInteractable()
  if actorWrapper == nil then
    return
  end
  local characterStaticStatusWrapper = actorWrapper:getCharacterStaticStatusWrapper()
  if characterStaticStatusWrapper == nil then
    return
  end
  if characterStaticStatusWrapper:isAttrSet(__eHoeMiniGameCharacter) == true then
    local playerWp = selfPlayer:getWp()
    local needWp = ToClient_CheckMiniGameFindWp(characterStaticStatusWrapper:getCharacterKey())
    if playerWp < needWp then
      local charName = characterStaticStatusWrapper:getName()
      local failMsg = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_MINIGAMEFIND_WPHELP", "name", charName)
      Proc_ShowMessage_Ack(failMsg)
      return
    end
    if getWeightLevel() >= __eWeightLevel3 then
      Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemIsTooHeavy"))
      return
    end
  end
  if keycode == CppEnums.ActionInputType.ActionInputType_Interaction then
    if self._activatedIconCount <= 0 then
      return
    end
    local targetIconToolType = self._activatedIconList[0]
    if targetIconToolType == nil then
      return
    end
    if key ~= nil and key ~= targetIconToolType then
      return
    end
    local targetIconUIInfo = self._collectTypeUIInfo[targetIconToolType]
    if targetIconUIInfo == nil then
      return
    end
    if targetIconUIInfo._isAble == false then
      return
    end
    ToClient_SetCollectToolType(targetIconToolType)
    interaction_processInteraction(CppEnums.InteractionType.InteractionType_Collect)
  elseif keycode == __eUiInputType_Interaction0 then
    PaGlobal_InteractionGathering_All_RotateButton(true)
    return
  elseif keycode == __eUiInputType_Interaction1 then
    PaGlobal_InteractionGathering_All_RotateButton(false)
    return
  else
    return
  end
end
function PaGlobal_InteractionGathering_All_RotateButton(doClockWise)
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  PaGlobal_InteractionGathering_All:rotateButton(doClockWise)
end
