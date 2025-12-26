function HandleEventLUp_PetRegister_Register_All()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  if PaGlobal_PetRegister_All._isRegister == true then
    PaGlobal_PetRegister_All:registPet()
  else
    PaGlobal_PetRegister_All:changePetNameConfirm()
  end
end
function HandleEventLUp_PetRegister_ClearEdit_All()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  PaGlobal_PetRegister_All:clearEdit()
end
function Input_PetRegister_KeyboardEnd_All(str)
  PaGlobal_PetRegister_All._ui.edit_Name:SetEditText(str)
  ClearFocusEdit()
  HandleEventLUp_PetRegister_Register_All()
end
function FromClient_InputPetName_All(fromWhereType, fromSlotNo)
  if nil == Panel_Window_PetRegister_All then
    return
  end
  PaGlobal_PetRegister_All:inputPetName(fromWhereType, fromSlotNo)
end
function FromClient_PetAddSealedList(petNo, reason, petType)
  if reason == nil then
    return
  end
  if PaGlobal_PetRegister_All._isConsole then
    if reason == 1 then
      if petType == __ePetType_Normal then
        PaGlobalFunc_PetList_ShowByRegisterPet()
      else
        return
      end
    end
  elseif reason == 1 then
    if petType == __ePetType_Normal then
      PaGlobalFunc_PetList_ShowByRegisterPet()
    elseif petType == __ePetType_Fairy then
      if true == _ContentsGroup_NewUI_Fairy_All then
        PaGlobal_FairyInfo_Open_All(false)
      else
        PaGlobal_FairyInfo_Open(false)
      end
      PaGlobal_Fairy_SetPosIcon()
    else
      return
    end
  end
end
function PaGlobal_PetRegister_All_GetShow()
  if nil ~= Panel_Window_PetRegister_All then
    return Panel_Window_PetRegister_All:GetShow()
  end
end
function PaGlobal_PetRegister_All_Close()
  if nil == Panel_Window_PetRegister_All then
    return
  end
  PaGlobal_PetRegister_All:prepareClose()
end
