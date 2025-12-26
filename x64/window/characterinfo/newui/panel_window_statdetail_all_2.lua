function PaGlobal_CharacterStatDetail_All_ShowAni()
  if PaGlobal_CharacterStatDetail_All == nil then
    return
  end
end
function PaGlobal_CharacterStatDetail_All_HideAni()
  if PaGlobal_CharacterStatDetail_All == nil then
    return
  end
end
function PaGlobal_CharacterStatDetail_All_Open()
  if PaGlobal_CharacterStatDetail_All == nil then
    return
  end
  PaGlobal_CharacterStatDetail_All:prepareOpen()
end
function PaGlobal_CharacterStatDetail_All_Close()
  if PaGlobal_CharacterStatDetail_All == nil then
    return
  end
  PaGlobal_CharacterStatDetail_All:prepareClose()
end
function PaGlobal_CharacterStatDetail_All_StatUpdate()
  if PaGlobal_CharacterStatDetail_All == nil then
    return
  end
  if Panel_Window_StatDetail_All:GetShow() == false then
    return
  end
  PaGlobal_CharacterStatDetail_All:update()
end
function PaGlobal_CharacterStatDetail_All_ListUpdate(control, InputKey)
  if PaGlobal_CharacterStatDetail_All == nil then
    return
  end
  PaGlobal_CharacterStatDetail_All:listContent(control, InputKey)
end
