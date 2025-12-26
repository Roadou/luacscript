function PaGlobalFunc_Season_Character_Create_Close()
  PaGlobal_Season_Character_Create:prepareClose()
end
function PaGlobalFunc_Season_Character_Create()
  if PaGlobal_Season_Character_Create == nil then
    return
  end
  PaGlobal_Season_Character_Create._playerCreateType = __ePlayerCreateNormal
  PaGlobal_Season_Character_Create:createCharacter(true)
end
