function PaGlobalFunc_Guild_SelectGuildMansion_All_Open()
  if Panel_SelectGuildMansion_All == nil then
    return
  end
  PaGlobal_SelectGuildMansion_All:prepareOpen()
end
function PaGlobalFunc_SelectGuildMansion_All_Close()
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  PaGlobal_SelectGuildMansion_All:prepareClose()
end
function PaGlobalFunc_Guild_SelectGuildMansion_All_SearchGuildMember()
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  PaGlobal_SelectGuildMansion_All:searchGuildMember()
end
function PaGlobalFunc_Guild_SelectGuildMansion_All_Update()
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  PaGlobal_SelectGuildMansion_All:updateAllUI(true)
end
function PaGlobalFunc_Guild_SelectGuildMansion_All_CreateContent(content, key)
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  if content == nil or key == nil then
    return
  end
  PaGlobal_SelectGuildMansion_All:createContent(content, key)
end
function PaGlobalFunc_SelectGuildMansion_All_ConfirmButton()
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  PaGlobal_SelectGuildMansion_All:confirmButton()
end
function PaGlobalFunc_SelectGuildMansion_All_UpdateConfirmButton()
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  PaGlobal_SelectGuildMansion_All:updateConfirmButton()
end
function PaGlobalFunc_SelectGuildMansion_All_KeyboardEnd(str)
  if nil == Panel_SelectGuildMansion_All then
    return
  end
  PaGlobal_SelectGuildMansion_All._ui._edit_familyName:SetEditText(str)
  ClearFocusEdit()
end
