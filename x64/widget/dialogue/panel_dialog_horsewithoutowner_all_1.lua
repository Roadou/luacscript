function PaGlobal_HorseWithoutOwner:initialize()
  if PaGlobal_HorseWithoutOwner._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui._btn_summon = UI.getChildControl(Panel_Dialog_HorseWithoutOwner_All, "Button_RentMe")
  self._ui._stc_summon_console = UI.getChildControl(self._ui._btn_summon, "StaticText_X_ConsoleUI")
  self._ui._btn_return = UI.getChildControl(Panel_Dialog_HorseWithoutOwner_All, "Button_Return")
  self._ui._stc_return_console = UI.getChildControl(self._ui._btn_return, "StaticText_X_ConsoleUI")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_HorseWithoutOwner:registEventHandler()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  self._ui._btn_summon:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseWithoutOwner_SummonOrReturn()")
  self._ui._btn_return:addInputEvent("Mouse_LUp", "HandleEventLUp_HorseWithoutOwner_SummonOrReturn()")
end
function PaGlobal_HorseWithoutOwner:prepareOpen()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  local talker = dialog_getTalker()
  if nil == talker then
    return
  end
  local actorKeyRaw = talker:getActorKey()
  local npcActorProxyWrapper = getNpcActor(actorKeyRaw)
  if ToClient_IsCanSummonMasterlessHorseNPC(actorKeyRaw) == false then
    self:prepareClose()
    return
  end
  local temporaryWrapper = getTemporaryInformationWrapper()
  if temporaryWrapper == nil then
    self:prepareClose()
    return
  end
  self._ui._btn_summon:EraseAllEffect()
  self._ui._btn_return:EraseAllEffect()
  local landVehicleWrapper = temporaryWrapper:getUnsealVehicle(__eServantTypeVehicle)
  if landVehicleWrapper ~= nil then
    if landVehicleWrapper:getCharacterKeyRaw() ~= self._rentCharacterKeyRaw then
      self:prepareClose()
      return
    end
    self._ui._btn_summon:SetIgnore(true)
    self._ui._btn_summon:SetMonoTone(true)
    self._ui._btn_return:SetShow(true)
    self._ui._stc_summon_console:SetShow(false)
    self._ui._stc_return_console:SetShow(self._isConsole)
    self._ui._btn_return:AddEffect("fUI_Horse_Call_Button_01B", true, 0, 0)
  else
    self._ui._btn_summon:SetIgnore(false)
    self._ui._btn_summon:SetMonoTone(false)
    self._ui._btn_return:SetShow(false)
    self._ui._stc_summon_console:SetShow(self._isConsole)
    self._ui._stc_return_console:SetShow(false)
    self._ui._btn_summon:AddEffect("fUI_Horse_Call_Button_01A", true, 0, 0)
  end
  self:resize()
  self:open()
end
function PaGlobal_HorseWithoutOwner:resize()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  Panel_Dialog_HorseWithoutOwner_All:SetPosY(Panel_Npc_Dialog_All:GetPosY() - Panel_Dialog_HorseWithoutOwner_All:GetSizeY() - PaGlobalFunc_DialogMain_All_GetContentSizeY() - 30)
end
function PaGlobal_HorseWithoutOwner:open()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  if _ContentsGroup_MasterlessHorse == false then
    return
  end
  Panel_Dialog_HorseWithoutOwner_All:SetShow(true)
end
function PaGlobal_HorseWithoutOwner:prepareClose()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  self:close()
end
function PaGlobal_HorseWithoutOwner:close()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  Panel_Dialog_HorseWithoutOwner_All:SetShow(false)
end
function PaGlobal_HorseWithoutOwner:validate()
  if Panel_Dialog_HorseWithoutOwner_All == nil then
    return
  end
  self._ui._btn_summon:isValidate()
  self._ui._stc_summon_console:isValidate()
  self._ui._btn_return:isValidate()
  self._ui._stc_return_console:isValidate()
end
