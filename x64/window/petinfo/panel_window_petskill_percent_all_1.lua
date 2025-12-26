function PaGlobal_PetSkill_Percent_All:initialize()
  if true == self._initialize then
    return
  end
  local titleBG = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Static_TitleBG")
  self._ui._btn_winClose = UI.getChildControl(titleBG, "Button_Win_Close_PC")
  local mainBg = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Static_MainBG")
  self._ui._list2 = UI.getChildControl(mainBg, "List2_1")
  self._ui._stc_descBg = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Static_BottomDescBG")
  self._ui._stc_bottonDesc = UI.getChildControl(self._ui._stc_descBg, "StaticText_Desc")
  self._ui._stc_bottonDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_bottonDesc:SetText(self._ui._stc_bottonDesc:GetText())
  self._ui._stc_bottonDesc:SetIgnore(true)
  self._ui._btn_close_pc = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Button_Close_PC")
  self._ui._txt_keyGuide_console = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "StaticText_KeyGuide_Console")
  self._ui._txt_keyGuide_console:SetShow(false)
  self._ui._stc_keyGuide_console = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Static_KeyGuide_ConsoleUI")
  local tierBg = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Static_RadioButtonBg")
  self._ui._btn_petTier_1 = UI.getChildControl(tierBg, "RadioButton_PetType_1")
  self._ui._btn_petTier_2 = UI.getChildControl(tierBg, "RadioButton_PetType_2")
  self._ui._stc_SelectBar = UI.getChildControl(tierBg, "Static_SelectBar")
  self._ui._stc_LB = UI.getChildControl(tierBg, "Static_LB_ConsoleUI")
  self._ui._stc_RB = UI.getChildControl(tierBg, "Static_RB_ConsoleUI")
  self._originPosX1 = self._ui._btn_petTier_1:GetSpanSize().x
  self._originPosX2 = self._ui._btn_petTier_2:GetSpanSize().x
  if true == ToClient_isConsole() or true == _ContentsGroup_UsePadSnapping then
    self._isConsole = true
  else
    self._isConsole = false
  end
  self._ui._stc_LB:SetShow(self._isConsole)
  self._ui._stc_RB:SetShow(self._isConsole)
  self._ui._btn_winClose:SetShow(not self._isConsole)
  self._ui._btn_close_pc:SetShow(not self._isConsole)
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_PetSkill_Percent_All:registEventHandler()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_PetSkill_Percent_All_ReSizePanel")
  registerEvent("FromClient_NotiPetEquipSkillRate", "FromClient_PetSkill_Percent_All_NotiPetSkill")
  self._ui._list2:registEvent(__ePAUIList2EventType_LuaChangeContent, "HandleEventLUp_PetSkill_Percent_All_ListControlCreate")
  self._ui._list2:createChildContent(__ePAUIList2ElementManagerType_List)
  if false == self._isConsole then
    self._ui._btn_close_pc:addInputEvent("Mouse_LUp", "HandleEventLUp_PetSkill_Percent_All_Close()")
    self._ui._btn_winClose:addInputEvent("Mouse_LUp", "HandleEventLUp_PetSkill_Percent_All_Close()")
    self._ui._btn_close_pc:SetShow(true)
    self._ui._btn_winClose:SetShow(true)
    self._ui._txt_keyGuide_console:SetShow(false)
    self._ui._btn_petTier_1:addInputEvent("Mouse_LUp", "HandleEventLUp_PetSkill_Percent_All_RequestPetSkillRate()")
    self._ui._btn_petTier_2:addInputEvent("Mouse_LUp", "HandleEventLUp_PetSkill_Percent_All_RequestPetSkillRate()")
  else
    self._ui._btn_close_pc:SetShow(false)
    self._ui._btn_winClose:SetShow(false)
    Panel_Window_PetSkill_Percent_All:registerPadEvent(__eConsoleUIPadEvent_LB, "HandleEventLUp_PetSkill_Percent_All_RequestPetSkillRate_Console(true)")
    Panel_Window_PetSkill_Percent_All:registerPadEvent(__eConsoleUIPadEvent_RB, "HandleEventLUp_PetSkill_Percent_All_RequestPetSkillRate_Console(false)")
    local tierBg = UI.getChildControl(Panel_Window_PetSkill_Percent_All, "Static_RadioButtonBg")
    tierBg:SetIgnore(true)
    self._ui._btn_petTier_1:SetIgnore(true)
    self._ui._btn_petTier_2:SetIgnore(true)
    Panel_Window_PetSkill_Percent_All:SetSize(Panel_Window_PetSkill_Percent_All:GetSizeX(), Panel_Window_PetSkill_Percent_All:GetSizeY() - self._ui._txt_keyGuide_console:GetSizeY())
  end
end
function PaGlobal_PetSkill_Percent_All:prepareOpen()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  self:requsetPetSkillRate()
  self._ui._stc_keyGuide_console:SetShow(false)
  self:resizeBottonDesc()
  self:open()
end
function PaGlobal_PetSkill_Percent_All:open()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  Panel_Window_PetSkill_Percent_All:SetShow(true)
end
function PaGlobal_PetSkill_Percent_All:prepareClose()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  self:close()
end
function PaGlobal_PetSkill_Percent_All:close()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  Panel_Window_PetSkill_Percent_All:SetShow(false)
end
function PaGlobal_PetSkill_Percent_All:createListControl(content, key)
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  if nil == content then
    return
  end
  if nil == key then
    return
  end
  local stc_skillIcon = UI.getChildControl(content, "Static_SkillIcon")
  local txt_name = UI.getChildControl(content, "StaticText_SkillName")
  local txt_desc = UI.getChildControl(content, "StaticText_SkillDesc")
  local txt_rate = UI.getChildControl(content, "StaticText_1")
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(Int64toInt32(key))
  if nil ~= skillStaticStatus then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if nil ~= skillTypeStaticWrapper then
      stc_skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      txt_name:SetText(skillTypeStaticWrapper:getName())
      txt_desc:SetText(skillTypeStaticWrapper:getDescription())
      local rate = ToClient_getPetEquipSkillRate(Int64toInt32(key)) / 10000
      txt_rate:SetText(tostring(rate) .. "%")
      if false == self._isConsole then
        stc_skillIcon:addInputEvent("Mouse_On", "HandleEventOnOff_PetSkill_Percent_All_ShowToolTip( " .. Int64toInt32(key) .. ", \"petSkillRate_" .. Int64toInt32(key) .. "\")")
        stc_skillIcon:addInputEvent("Mouse_Out", "HandleEventMouseOut_PetSkillRateList_TooltipHide()")
      end
      local str = "petSkillRate_" .. Int64toInt32(key)
      Panel_SkillTooltip_SetPosition(skillStaticStatus:getSkillNo(), stc_skillIcon, str)
    end
  end
end
function PaGlobal_PetSkill_Percent_All:setTierButton(tier1, tier2)
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  self._ui._tier1 = tier1
  self._ui._tier2 = tier2
  if -1 == tier1 and -1 == tier2 then
    self._ui._btn_petTier_1:SetCheck(false)
    self._ui._btn_petTier_2:SetCheck(false)
    self._ui._btn_petTier_1:SetShow(false)
    self._ui._btn_petTier_2:SetShow(false)
    self._ui._stc_SelectBar:SetShow(false)
    return
  end
  local tier1 = PaGlobal_PetFusion_All._ui.txt_N1Title:GetText()
  local tier2 = PaGlobal_PetFusion_All._ui.txt_N2Title:GetText()
  self._ui._btn_petTier_1:SetText(tier1)
  self._ui._btn_petTier_2:SetText(tier2)
  local isShowForTier1 = PaGlobal_PetFusion_All._ui.txt_N1Title:GetShow()
  local isShowForTier2 = PaGlobal_PetFusion_All._ui.txt_N2Title:GetShow()
  self._ui._btn_petTier_1:SetShow(isShowForTier1)
  self._ui._btn_petTier_2:SetShow(isShowForTier2)
  if true == isShowForTier1 then
    self._ui._btn_petTier_1:SetCheck(true)
    self._ui._stc_SelectBar:SetShow(true)
    self._ui._stc_SelectBar:SetPosX(self._ui._btn_petTier_1:GetPosX() + self._ui._stc_SelectBar:GetSizeX() * 0.3)
  end
  if false == isShowForTier2 then
    self._ui._btn_petTier_1:SetHorizonCenter()
    self._ui._btn_petTier_1:SetSpanSize(0, self._ui._btn_petTier_1:GetSpanSize().y)
  else
    self._ui._btn_petTier_1:SetHorizonLeft()
    self._ui._btn_petTier_1:SetHorizonLeft()
    self._ui._btn_petTier_1:SetSpanSize(self._originPosX1, self._ui._btn_petTier_1:GetSpanSize().y)
    self._ui._btn_petTier_2:SetSpanSize(self._originPosX2, self._ui._btn_petTier_2:GetSpanSize().y)
  end
end
function PaGlobal_PetSkill_Percent_All:requsetPetSkillRate()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  local count = 0
  for index = 0, PaGlobal_PetFusion_All._config._petMaxTableCount - 1 do
    if -1 ~= PaGlobal_PetFusion_All._petNoList[index] then
      ToClient_pushPetListForEquipSkillRate(PaGlobal_PetFusion_All._petNoList[index], count)
      count = count + 1
    end
  end
  local targetTier = -1
  if true == self._ui._btn_petTier_1:IsChecked() then
    targetTier = self._ui._tier1
    self._ui._stc_SelectBar:SetPosX(self._ui._btn_petTier_1:GetPosX() + self._ui._stc_SelectBar:GetSizeX() * 0.3)
  elseif true == self._ui._btn_petTier_2:IsChecked() then
    targetTier = self._ui._tier2
    self._ui._stc_SelectBar:SetPosX(self._ui._btn_petTier_2:GetPosX() + self._ui._stc_SelectBar:GetSizeX() * 0.3)
  end
  if -1 == targetTier then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_SymbolNo, "eErrNoPetLowTier"))
    return
  end
  ToClient_requestPetEquipSkillRate(PaGlobal_PetFusion_All._currentSkillPetNo, PaGlobal_PetFusion_All._currentLookPetNo, targetTier - 1)
end
function PaGlobal_PetSkill_Percent_All:validate()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  self._ui._list2:isValidate()
  self._ui._stc_descBg:isValidate()
  self._ui._btn_close_pc:isValidate()
  self._ui._txt_keyGuide_console:isValidate()
  self._ui._btn_winClose:isValidate()
end
function PaGlobal_PetSkill_Percent_All:resizeBottonDesc()
  if nil == Panel_Window_PetSkill_Percent_All then
    return
  end
  local txtSizeY = self._ui._stc_bottonDesc:GetTextSizeY()
  self._ui._stc_bottonDesc:SetSize(self._ui._stc_bottonDesc:GetSizeX(), txtSizeY)
  local spanSizeY = 15
  self._ui._stc_descBg:SetSize(self._ui._stc_descBg:GetSizeX(), txtSizeY + spanSizeY)
  local panelSizeY = self._ui._stc_descBg:GetPosY() + self._ui._stc_descBg:GetSizeY() + 60
  if true == self._isConsole then
    panelSizeY = panelSizeY - self._ui._txt_keyGuide_console:GetSizeY()
  end
  Panel_Window_PetSkill_Percent_All:SetSize(Panel_Window_PetSkill_Percent_All:GetSizeX(), panelSizeY)
  self._ui._stc_keyGuide_console:ComputePos()
  self._ui._btn_close_pc:ComputePos()
end
