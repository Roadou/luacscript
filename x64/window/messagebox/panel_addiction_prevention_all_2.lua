function HandleEventLUp_ConfirmExitButton()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  PaGlobal_AddictionPrevent:prepareClose()
end
function AddictionPrevent_Resize()
  if Panel_Addiction_Prevention_All == nil then
    return
  end
  PaGlobal_AddictionPrevent:computePos()
end
