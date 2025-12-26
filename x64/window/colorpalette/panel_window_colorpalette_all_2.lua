function PaGlobal_ColorPalette_All_Open(openType)
  if nil == openType then
    _PA_ASSERT_NAME(false, "Palette \236\157\152 \237\131\128\236\158\133(\236\187\164\235\167\136/\236\158\165\235\185\132)\236\157\132 \236\132\164\236\160\149\237\149\180\236\149\188\237\149\169\235\139\136\235\139\164.", "\237\148\132\235\161\156\234\183\184\235\158\1681\237\140\128 / \234\185\128\237\152\132\235\185\136")
    return
  end
  PaGlobal_ColorPalette_All:prepareOpen(openType)
end
function PaGlobal_ColorPalette_All_Close()
  PaGlobal_ColorPalette_All:prepareClose()
end
function PaGlobal_ColorPalette_All_SetDecorationPart(classType, paramType, paramIndex)
  PaGlobal_ColorPalette_All:setDecorationPart(classType, paramType, paramIndex)
end
function HandleEventLPress_ColorPalette_All_SelectPaletteType(paletteType)
  PaGlobal_ColorPalette_All:setPaletteType(paletteType)
end
function HandleEventLDown_ColorPalette_All_PanelClicked(panelType)
  PaGlobal_ColorPalette_All:panelClicked(panelType)
end
function HandleEventLPress_ColorPalette_All_PanelPressed(panelType)
  PaGlobal_ColorPalette_All:panelPressed(panelType)
end
function HandleEventLUp_ColorPalette_All_PanelReleased(panelType)
  PaGlobal_ColorPalette_All:panelReleased(panelType)
end
function HandleEventKey_ColorPalette_All_ApplyRGBToTarget()
  PaGlobal_ColorPalette_All:applyEditBoxRGBToTarget()
end
function FromClient_ColorPalette_All_ReSizePanel()
  PaGlobal_ColorPalette_All:resizePanel()
end
function FromClient_ColorPalette_All_EditBoxChanged(colorType)
  PaGlobal_ColorPalette_All:editBoxChanged(colorType)
end
function FromClient_ColorPalette_All_EventRGBInfoCleared()
  PaGlobal_ColorPalette_All:lastAppliedRGBInformationClear()
end
function FromClient_ColorPalette_All_EventRGBHistoryApplied(paramIndex, colorInfo)
  PaGlobal_ColorPalette_All:colorHistoryApplied(paramIndex, colorInfo)
end
function PaGlobal_ColorPalette_All_SetHslInfo(colorType, hslInfo)
  return PaGlobal_ColorPalette_All:SetHslInfo(colorType, hslInfo)
end
function PaGlobal_ColorPalette_All_GetRgbToolTip()
  return PaGlobal_ColorPalette_All:getRGBToolTip()
end
function HandleEventOnOut_ColorPalette_All_SelectPaletteType(isOn, buttonIdx)
  if nil == InputMOnOut_Dye_CategoryTooltip then
    return
  end
  PaGlobal_ColorPalette_All:InputMOnOut_Dye_CategoryTooltip(isOn, buttonIdx)
end
function PaGlobal_ColorPalette_All_UpdatePerFrame(deltaTime)
  PaGlobal_ColorPalette_All:colorPaletteUpdatePerFrame(deltaTime)
end
function HandleEventLBRB_ColorPalette_All_ChangeTarget(value)
  PaGlobal_ColorPalette_All:changeWeaponType(value)
end
function HandleEventLTDown_ColorPalette_All_ColorPalettePressed()
  PaGlobal_ColorPalette_All:colorPalettePressedInConsoleMode()
end
function HandleEventLTUp_ColorPalette_All_ColorPaletteReleased()
  PaGlobal_ColorPalette_All:colorPaletteReleasedInConsoleMode()
end
function PaGlobal_ColorPalette_All_ClickedSlotChanged()
  PaGlobal_ColorPalette_All:clickedSlotChanged()
end
function PaGlobal_ColorPalette_All_ClearLastValueCached()
  PaGlobal_ColorPalette_All:clearLastCachedValue()
end
function HandleEventLDown_ColorPalette_All_FocusEditBox(colorType)
  PaGlobal_ColorPalette_All:editBoxFocused(colorType)
end
function HandleEventLUp_ColorPalette_All_LoadColorPreset(index)
  PaGlobal_ColorPalette_All:loadColorPreset(index)
end
function HandleEventLUp_ColorPalette_All_SaveColorPreset()
  PaGlobal_ColorPalette_All:saveColorPreset()
end
function HandleEventLUp_ColorPalette_All_ColorPresetFocused(index)
  PaGlobal_ColorPalette_All:colorPresetFocused(index)
end
function HandleEventLUp_ColorPalette_All_ColorPresetUnFocused(index)
  PaGlobal_ColorPalette_All:colorPresetUnFocused(index)
end
