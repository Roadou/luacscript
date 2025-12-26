PaGlobal_ServantLvUpMessageBox_All = {
  _ui = {
    _stc_text = nil,
    _btn_yes = nil,
    _btn_no = nil,
    _btn_confirm = nil,
    _btn_close = nil,
    _txt_content = nil,
    _txt_desc = nil,
    _stc_lvUpBg = nil,
    _edit_displayNumber = nil,
    _btn_1_lvUp = nil,
    _btn_max_lvUp = nil,
    _btn_1_lvDown = nil,
    _btn_max_lvDown = nil,
    _stc_consoleBg = nil,
    _txt_keyGuideA = nil,
    _txt_keyGuideB = nil,
    _txt_keyGuideY = nil
  },
  _currentServantNo = nil,
  _isSealed = false,
  _originPanslSizeY = 0,
  _originTextSizeY = 0,
  _originTextContentSizeY = 0,
  _originTextDescSizeY = 0,
  _isPadSnapping = false,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_ServantLvUpMessageBox_All_Init")
function FromClient_ServantLvUpMessageBox_All_Init()
  PaGlobal_ServantLvUpMessageBox_All:initialize()
end
function PaGlobal_ServantLvUpMessageBox_All:initialize()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._stc_text = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Static_Text")
  self._ui._btn_yes = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Button_Yes")
  self._ui._btn_no = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Button_Cancel")
  self._ui._btn_confirm = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Button_Confirm")
  self._ui._btn_close = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Button_Close")
  self._ui._txt_content = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "StaticText_Content")
  self._ui._txt_desc = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "StaticText_Desc")
  self._ui._stc_lvUpBg = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Static_LvUp_BG")
  self._ui._edit_displayNumber = UI.getChildControl(self._ui._stc_lvUpBg, "Static_DisplayNumber")
  self._ui._btn_1_lvUp = UI.getChildControl(self._ui._stc_lvUpBg, "Button_1_Lv_Up")
  self._ui._btn_max_lvUp = UI.getChildControl(self._ui._stc_lvUpBg, "Button_Max_Lv_Up")
  self._ui._btn_1_lvDown = UI.getChildControl(self._ui._stc_lvUpBg, "Button_1_Lv_Down")
  self._ui._btn_max_lvDown = UI.getChildControl(self._ui._stc_lvUpBg, "Button_Max_Lv_Down")
  self._ui._stc_consoleBg = UI.getChildControl(Panel_Dialog_ServantLvUpMessageBox_All, "Static_BottomBg_ConsoleUI")
  self._ui._txt_keyGuideA = UI.getChildControl(self._ui._stc_consoleBg, "StaticText_A_ConsoleUI")
  self._ui._txt_keyGuideB = UI.getChildControl(self._ui._stc_consoleBg, "StaticText_B_ConsoleUI")
  self._ui._txt_keyGuideY = UI.getChildControl(self._ui._stc_consoleBg, "StaticText_Y_ConsoleUI")
  self._isPadSnapping = ToClient_isUsePadSnapping()
  self._originPanslSizeY = Panel_Dialog_ServantLvUpMessageBox_All:GetSizeY()
  self._originTextSizeY = self._ui._stc_text:GetSizeY()
  self._originTextContentSizeY = self._ui._txt_content:GetSizeY()
  self._originTextDescSizeY = self._ui._txt_desc:GetSizeY()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_ServantLvUpMessageBox_All:registEventHandler()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  self._ui._btn_yes:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_LvUp()")
  self._ui._btn_no:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_Close()")
  self._ui._btn_confirm:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_Close()")
  self._ui._btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_Close()")
  self._ui._edit_displayNumber:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_EditLevel()")
  self._ui._btn_1_lvUp:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_EditLv(true)")
  self._ui._btn_max_lvUp:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_EditLvMax(true)")
  self._ui._btn_1_lvDown:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_EditLv(false)")
  self._ui._btn_max_lvDown:addInputEvent("Mouse_LUp", "PaGlobal_ServantLvUpMessageBox_All_EditLvMax(false)")
end
function PaGlobal_ServantLvUpMessageBox_All:prepareOpen(servantNo, isSealed)
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  self._currentServantNo = servantNo
  self._isSealed = isSealed
  self:update()
  self:open()
end
function PaGlobal_ServantLvUpMessageBox_All:open()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  Panel_Dialog_ServantLvUpMessageBox_All:SetShow(true)
end
function PaGlobal_ServantLvUpMessageBox_All:prepareClose()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  if Panel_NumberPad_IsPopUp() == true then
    Panel_NumberPad_Close()
  end
  self._currentServantNo = nil
  self._isSealed = false
  self:close()
end
function PaGlobal_ServantLvUpMessageBox_All:close()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  Panel_Dialog_ServantLvUpMessageBox_All:SetShow(false)
end
function PaGlobal_ServantLvUpMessageBox_All:update()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  local servantInfo = stable_getServantByServantNo(self._currentServantNo)
  local possibleLevel = servantInfo:getPossibleLevel()
  local currentLevel = servantInfo:getLevel()
  self._ui._txt_desc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANT_STACK_LVUP_3"))
  self:updateServantLvUpInfoDesc(servantInfo, currentLevel + 1)
  local diffContent = self._ui._txt_content:GetTextSizeY() - self._originTextContentSizeY
  local diffDesc = self._ui._txt_desc:GetTextSizeY() - self._originTextDescSizeY
  if diffContent < 0 then
    diffContent = 0
  end
  if diffDesc < 0 then
    diffDesc = 0
  end
  self._ui._txt_content:SetSize(self._ui._txt_content:GetSizeX(), self._originTextContentSizeY + diffContent)
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), self._originTextDescSizeY + diffDesc)
  self._ui._txt_desc:SetPosY(self._ui._txt_content:GetPosY() + self._ui._txt_content:GetSizeY() + 10)
  if possibleLevel > currentLevel then
    self._ui._edit_displayNumber:SetText(currentLevel + 1)
    self._ui._stc_lvUpBg:SetShow(true)
    self._ui._btn_yes:SetShow(true)
    self._ui._btn_no:SetShow(true)
    self._ui._btn_confirm:SetShow(false)
    Panel_Dialog_ServantLvUpMessageBox_All:SetSize(Panel_Dialog_ServantLvUpMessageBox_All:GetSizeX(), self._originPanslSizeY + diffContent + diffDesc + 60)
    self._ui._stc_text:SetSize(Panel_Dialog_ServantLvUpMessageBox_All:GetSizeX(), self._originTextSizeY + diffContent + diffDesc + 10)
    self._ui._stc_lvUpBg:SetPosY(self._ui._txt_desc:GetPosY() + self._ui._txt_desc:GetSizeY() + 10)
    self._ui._btn_yes:ComputePos()
    self._ui._btn_no:ComputePos()
  else
    self._ui._stc_lvUpBg:SetShow(false)
    self._ui._btn_yes:SetShow(false)
    self._ui._btn_no:SetShow(false)
    self._ui._btn_confirm:SetShow(true)
    Panel_Dialog_ServantLvUpMessageBox_All:SetSize(Panel_Dialog_ServantLvUpMessageBox_All:GetSizeX(), self._originPanslSizeY + diffContent + diffDesc)
    self._ui._stc_text:SetSize(Panel_Dialog_ServantLvUpMessageBox_All:GetSizeX(), self._originTextSizeY + diffContent + diffDesc)
    self._ui._btn_confirm:ComputePos()
  end
  if self._isPadSnapping == true then
    self._ui._stc_consoleBg:SetPosY(Panel_Dialog_ServantLvUpMessageBox_All:GetSizeY())
  end
end
function PaGlobal_ServantLvUpMessageBox_All:updateServantLvUpInfoDesc(servantInfo, targetLevel)
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  if servantInfo == nil or targetLevel == nil then
    return
  end
  local s64_expStack = servantInfo:getExperienceStack()
  local s64_needExp = servantInfo:getNeedExperienceForLvUp()
  local s64_usedExp = servantInfo:getNeedExperienceForExpLvUp(targetLevel)
  local possibleLevel = servantInfo:getPossibleLevel()
  local currentLevel = servantInfo:getLevel()
  if possibleLevel > currentLevel then
    self._ui._txt_content:SetText(PAGetStringParam4(Defines.StringSheet_GAME, "LUA_WINDOW_SERVANT_STACK_LVUP_2", "goallevel", targetLevel, "level", possibleLevel, "usedexp", makeDotMoney(s64_usedExp), "exp", makeDotMoney(s64_expStack)))
  else
    self._ui._txt_content:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_LVUP_REQUIRE_EXP", "requireexp", makeDotMoney(s64_needExp)))
  end
end
function PaGlobal_ServantLvUpMessageBox_All:validate()
  if Panel_Dialog_ServantLvUpMessageBox_All == nil then
    return
  end
  self._ui._stc_text:isValidate()
  self._ui._btn_yes:isValidate()
  self._ui._btn_no:isValidate()
  self._ui._btn_confirm:isValidate()
  self._ui._btn_close:isValidate()
  self._ui._txt_content:isValidate()
  self._ui._stc_lvUpBg:isValidate()
  self._ui._edit_displayNumber:isValidate()
  self._ui._btn_1_lvUp:isValidate()
  self._ui._btn_max_lvUp:isValidate()
  self._ui._btn_1_lvDown:isValidate()
  self._ui._btn_max_lvDown:isValidate()
  self._ui._stc_consoleBg:isValidate()
  self._ui._txt_keyGuideA:isValidate()
  self._ui._txt_keyGuideB:isValidate()
  self._ui._txt_keyGuideY:isValidate()
end
function PaGlobal_ServantLvUpMessageBox_All_Open(servantNo, isSealed)
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  if servantNo == nil then
    return
  end
  if stable_getServantByServantNo(servantNo) == nil then
    return
  end
  self:prepareOpen(servantNo, isSealed)
end
function PaGlobal_ServantLvUpMessageBox_All_Close()
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  self:prepareClose()
end
function PaGlobal_ServantLvUpMessageBox_All_EditLevel()
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  if ToClient_IsPossibleServantLevelUpByExpStack(self._currentServantNo, not self._isSealed) == false then
    return
  end
  local servantInfo = stable_getServantByServantNo(self._currentServantNo)
  local s64_maxLevel = tonumber64(servantInfo:getPossibleLevel())
  Panel_NumberPad_Show(true, s64_maxLevel, 0, PaGlobal_ServantLvUpMessageBox_All_EditLevelConfirm)
end
function PaGlobal_ServantLvUpMessageBox_All_EditLevelConfirm(inputNumber)
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  local servantInfo = stable_getServantByServantNo(self._currentServantNo)
  local maxLevel = servantInfo:getPossibleLevel()
  local minLevel = servantInfo:getLevel() + 1
  local targetLevel = Int64toInt32(inputNumber)
  if minLevel > targetLevel then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemTooLowLevel"))
    return
  end
  if maxLevel < targetLevel then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoItemTooHighLevel"))
    return
  end
  self._ui._edit_displayNumber:SetText(targetLevel)
  self:updateServantLvUpInfoDesc(servantInfo, targetLevel)
end
function PaGlobal_ServantLvUpMessageBox_All_LvUp()
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  if self._currentServantNo == nil then
    return
  end
  local targetLevel = self._ui._edit_displayNumber:GetText()
  local servantInfo = stable_getServantByServantNo(self._currentServantNo)
  if self._isSealed == true then
    ToClient_LevelUpSealServantByExpStack(servantInfo:getServantNo(), targetLevel)
  else
    ToClient_LevelUpUnsealServantByExpStack(targetLevel)
  end
  self:prepareClose()
end
function PaGlobal_ServantLvUpMessageBox_All_EditLv(isLvUp)
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  if Panel_NumberPad_IsPopUp() == true then
    Panel_NumberPad_Close()
  end
  local currentEditLevel = self._ui._edit_displayNumber:GetText()
  local servantInfo = stable_getServantByServantNo(self._currentServantNo)
  local maxLevel = servantInfo:getPossibleLevel()
  local minLevel = servantInfo:getLevel() + 1
  if isLvUp == true then
    currentEditLevel = currentEditLevel + 1
    if maxLevel < currentEditLevel then
      currentEditLevel = maxLevel
    end
  else
    currentEditLevel = currentEditLevel - 1
    if minLevel > currentEditLevel then
      currentEditLevel = minLevel
    end
  end
  self._ui._edit_displayNumber:SetText(currentEditLevel)
  self:updateServantLvUpInfoDesc(servantInfo, currentEditLevel)
end
function PaGlobal_ServantLvUpMessageBox_All_EditLvMax(isLvUp)
  local self = PaGlobal_ServantLvUpMessageBox_All
  if self == nil then
    return
  end
  if Panel_NumberPad_IsPopUp() == true then
    Panel_NumberPad_Close()
  end
  local servantInfo = stable_getServantByServantNo(self._currentServantNo)
  local targetLevel = 0
  if isLvUp == true then
    targetLevel = servantInfo:getPossibleLevel()
  else
    targetLevel = servantInfo:getLevel() + 1
  end
  self._ui._edit_displayNumber:SetText(targetLevel)
  self:updateServantLvUpInfoDesc(servantInfo, targetLevel)
end
