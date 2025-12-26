function FromClient_TopIcon_AutoUseBuff_Resize()
  if PaGlobal_TopIcon_AutoUseBuffItem == nil then
    return
  end
  PaGlobal_TopIcon_AutoUseBuffItem:onScreenResize()
end
function FromClient_TopIcon_AutoUseBuff_ChangeToggleState(isAutoUseModeOn)
  if PaGlobal_TopIcon_AutoUseBuffItem == nil then
    return
  end
  PaGlobal_TopIcon_AutoUseBuffItem:changeToggleState(isAutoUseModeOn)
end
function FromClient_TopIcon_AutoUseBuff_ChangeSkillState(isLearnedFairySkill)
  if PaGlobal_TopIcon_AutoUseBuffItem == nil then
    return
  end
  PaGlobal_TopIcon_AutoUseBuffItem:changeSkillState(isLearnedFairySkill)
end
function FromClient_TopIcon_AutoUseBuff_StartAutoUseBuffItemTimer(usableItemKeyRaw)
  if PaGlobal_TopIcon_AutoUseBuffItem == nil then
    return
  end
  PaGlobal_TopIcon_AutoUseBuffItem:startAutoUseItemTimer(usableItemKeyRaw)
end
function FromClient_TopIcon_AutoUseBuff_DeltaUpdate(deltaTime)
  if PaGlobal_TopIcon_AutoUseBuffItem == nil then
    return
  end
  PaGlobal_TopIcon_AutoUseBuffItem:update(deltaTime)
end
