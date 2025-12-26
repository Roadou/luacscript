function PaGlobal_Window_PetSkillChange_All:initialize()
  if true == self._initialize then
    return
  end
  self._ui._stc_TitleArea = UI.getChildControl(Panel_Window_PetSkillChange_All, "Static_TitleArea")
  self._ui._btn_WinClose = UI.getChildControl(self._ui._stc_TitleArea, "Button_Win_Close")
  self._ui._btn_Question = UI.getChildControl(self._ui._stc_TitleArea, "Button_Question")
  self._ui._stc_PetinfoArea = UI.getChildControl(Panel_Window_PetSkillChange_All, "Static_PetInfoArea")
  self._ui._stc_PetIcon = UI.getChildControl(self._ui._stc_PetinfoArea, "Static_IconPet")
  self._ui._txt_PetName = UI.getChildControl(self._ui._stc_PetinfoArea, "StaticText_PetName")
  self._ui._txt_Tier = UI.getChildControl(self._ui._stc_PetinfoArea, "StaticText_Tier")
  self._ui._txt_SpecialSkill = UI.getChildControl(self._ui._stc_PetinfoArea, "StaticText_Skill_Special")
  self._ui._txt_BaseSkill = UI.getChildControl(self._ui._stc_PetinfoArea, "StaticText_Skill_GatheringTime")
  self._ui._txt_SkillChangeFailedCount = UI.getChildControl(self._ui._stc_PetinfoArea, "StaticText_Stack")
  self._ui._stc_qustionMark = UI.getChildControl(self._ui._stc_PetinfoArea, "Static_QuestionMark")
  self._ui._stc_CurrentSkillArea = UI.getChildControl(Panel_Window_PetSkillChange_All, "Static_SkillArea")
  local baseSkillKeyIdx = 0
  self._ui._stc_CurrentSkillBg[baseSkillKeyIdx] = UI.getChildControl(self._ui._stc_CurrentSkillArea, "Static_SkillBg_Base")
  self._ui._stc_CurrentSkillIcon[baseSkillKeyIdx] = UI.getChildControl(self._ui._stc_CurrentSkillBg[baseSkillKeyIdx], "Static_SkillIcon")
  self._ui._stc_CurrentSkillName[baseSkillKeyIdx] = UI.getChildControl(self._ui._stc_CurrentSkillBg[baseSkillKeyIdx], "StaticText_SkillName")
  self._ui._stc_SkillChangeButton[baseSkillKeyIdx] = nil
  for ii = baseSkillKeyIdx + 1, self._normalSkillCount do
    self._ui._stc_CurrentSkillBg[ii] = UI.getChildControl(self._ui._stc_CurrentSkillArea, "Static_SkillBg_" .. ii)
    self._ui._stc_CurrentSkillIcon[ii] = UI.getChildControl(self._ui._stc_CurrentSkillBg[ii], "Static_SkillIcon")
    self._ui._stc_CurrentSkillName[ii] = UI.getChildControl(self._ui._stc_CurrentSkillBg[ii], "StaticText_SkillName")
    self._ui._stc_SkillChangeButton[ii] = UI.getChildControl(self._ui._stc_CurrentSkillBg[ii], "Button_Change")
  end
  self._ui._stc_SkillListBg = UI.getChildControl(Panel_Window_PetSkillChange_All, "Static_SkillListBg")
  self._ui._list2_SkillChangeSlot = UI.getChildControl(self._ui._stc_SkillListBg, "List2_ServantSkill")
  self._ui._stc_BottomArea = UI.getChildControl(Panel_Window_PetSkillChange_All, "Static_BottomArea")
  self._ui._txt_SkillChangeItemCount = UI.getChildControl(self._ui._stc_BottomArea, "StaticText_1")
  self._ui._stc_buyButton = UI.getChildControl(self._ui._stc_BottomArea, "Button_Buy")
  self._ui_console.stc_KeyGuideBG = UI.getChildControl(Panel_Window_PetSkillChange_All, "Static_BottomKeyBG_ConsoleUI")
  self._ui_console.stc_Detail = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Detail_ConsoleUI")
  self._ui_console.stc_Change = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Change_ConsoleUI")
  self._ui_console.stc_Close = UI.getChildControl(self._ui_console.stc_KeyGuideBG, "StaticText_Close_ConsoleUI")
  self:registEventHandler()
  self:validate()
  Panel_Window_PetSkillChange_All:SetVerticalMiddle()
  Panel_Window_PetSkillChange_All:SetHorizonCenter()
  self._wishSkillList = Array.new()
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui_console.stc_KeyGuideBG:SetShow(self._isConsole)
  if self._isConsole == true then
    local guideIconGroup = {
      self._ui_console.stc_Detail,
      self._ui_console.stc_Change,
      self._ui_console.stc_Close
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui_console.stc_KeyGuideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
    Panel_Window_PetSkillChange_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "PaGlobal_Window_PetSkillChange_All:handlerMouseChangeStackQuestionBtnToggle()")
  end
  self._ui._btn_Question:SetShow(false)
  self._initialize = true
end
function PaGlobal_Window_PetSkillChange_All:registEventHandler()
  registerEvent("FromClient_PetSkillChange", "FromClient_PetSkillChange")
  self._ui._btn_WinClose:addInputEvent("Mouse_LUp", "PaGlobal_PetSkill_Change_Close_All()")
  if ToClient_isConsole() == true then
    self._ui._stc_buyButton:SetShow(false)
    self._ui._txt_SkillChangeItemCount:SetSpanSize(self._ui._stc_buyButton:GetSpanSize().x, self._ui._txt_SkillChangeItemCount:GetSpanSize().y)
    self._ui._txt_SkillChangeItemCount:ComputePos()
  else
    self._ui._stc_buyButton:SetShow(true)
    self._ui._stc_buyButton:addInputEvent("Mouse_LUp", "PaGlobal_Window_PetSkillChange_All:handlerExchangeItemPlusBtn()")
  end
  self._ui._stc_qustionMark:addInputEvent("Mouse_On", "PaGlobal_Window_PetSkillChange_All:handlerMouseChangeStackQuestionBtn(true)")
  self._ui._stc_qustionMark:addInputEvent("Mouse_Out", "PaGlobal_Window_PetSkillChange_All:handlerMouseChangeStackQuestionBtn(false)")
  self._ui._list2_SkillChangeSlot:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_PetSkillChange_CreateWishSkillListListContents")
  self._ui._list2_SkillChangeSlot:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobal_Window_PetSkillChange_All:prepareOpen(petNo_s64)
  self._currentPetNo = tonumber64(petNo_s64)
  self:update()
  if self._isConsole == true then
    Panel_Window_PetSkillChange_All:ignorePadSnapMoveToOtherPanelUpdate(true)
  end
  self:open()
end
function PaGlobal_Window_PetSkillChange_All:open()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  Panel_Window_PetSkillChange_All:SetShow(true)
  self._ui._stc_SkillListBg:SetShow(false)
end
function PaGlobal_Window_PetSkillChange_All:prepareClose()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  PaGlobal_Window_PetSkillChange_All:dataClear()
  if self._isConsole == true then
    Panel_Window_PetSkillChange_All:ignorePadSnapMoveToOtherPanelUpdate(false)
  end
  self:close()
end
function PaGlobal_Window_PetSkillChange_All:close()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  Panel_Window_PetSkillChange_All:SetShow(false)
end
function PaGlobal_Window_PetSkillChange_All:validate()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
end
function PaGlobal_Window_PetSkillChange_All:setCurrentEquipSkillUi(uiIdx, petSkillIdx, skillTypeStaticWrapper, isBaseSkillKey)
  self._ui._stc_CurrentSkillBg[uiIdx]:SetShow(true)
  self._ui._stc_CurrentSkillBg[uiIdx]:SetIgnore(false)
  self._ui._stc_CurrentSkillIcon[uiIdx]:ChangeTextureInfoNameAsync("icon/" .. skillTypeStaticWrapper:getIconPath())
  local x1, y1, x2, y2 = setTextureUV_Func(self._ui._stc_CurrentSkillIcon[uiIdx], 0, 0, 43, 43)
  self._ui._stc_CurrentSkillIcon[uiIdx]:getBaseTexture():setUV(x1, y1, x2, y2)
  self._ui._stc_CurrentSkillIcon[uiIdx]:setRenderTexture(self._ui._stc_CurrentSkillIcon[uiIdx]:getBaseTexture())
  if isBaseSkillKey == true then
    if self._isConsole then
      self._ui._stc_CurrentSkillBg[uiIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMouseOn_PetInfo_BaseSkillTooltip_Show_All( " .. petSkillIdx .. ", " .. uiIdx .. " )")
    else
      self._ui._stc_CurrentSkillBg[uiIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetInfo_BaseSkillTooltip_Show_All( " .. petSkillIdx .. ", " .. uiIdx .. " )")
    end
  elseif self._isConsole then
    self._ui._stc_CurrentSkillBg[uiIdx]:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventMouseOn_PetInfo_SkillTooltip_Show_All( " .. petSkillIdx .. ", " .. uiIdx .. " )")
  else
    self._ui._stc_CurrentSkillBg[uiIdx]:addInputEvent("Mouse_On", "HandleEventMouseOn_PetInfo_SkillTooltip_Show_All( " .. petSkillIdx .. ", " .. uiIdx .. " )")
  end
  self._ui._stc_CurrentSkillBg[uiIdx]:addInputEvent("Mouse_Out", "Panel_SkillTooltip_Hide()")
  self._ui._stc_CurrentSkillName[uiIdx]:SetTextMode(__eTextMode_AutoWrap)
  self._ui._stc_CurrentSkillName[uiIdx]:SetText(skillTypeStaticWrapper:getDescription())
  UI.setLimitTextAndAddTooltip(self._ui._stc_CurrentSkillName[uiIdx], self._ui._stc_CurrentSkillName[uiIdx]:GetText(), "")
  if nil ~= self._ui._stc_SkillChangeButton[uiIdx] then
    self._ui._stc_SkillChangeButton[uiIdx]:addInputEvent("Mouse_LUp", "HandleEventMouseLup_PetSkillChange_SkillChangeButton(" .. petSkillIdx .. "," .. uiIdx .. ")")
  end
  Panel_SkillTooltip_SetPosition(skillNo, self._ui._stc_CurrentSkillBg[uiIdx], "PetSkill")
end
function PaGlobal_Window_PetSkillChange_All:update()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  local pcPetData = ToClient_getPetSealedDataByPetNo(self._currentPetNo)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  self._ui._stc_PetIcon:ChangeTextureInfoNameAsync(pcPetData:getIconPath())
  self._ui._txt_PetName:SetText(pcPetData:getName())
  self._ui._txt_Tier:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_SERVANT_TIER", "tier", petStaticStatus:getPetTier() + 1))
  self._ui._txt_BaseSkill:SetText(PaGlobal_PetInfo_GetPetSpecialSkillText(pcPetData, 0))
  self._ui._txt_SpecialSkill:SetText(PaGlobal_PetInfo_GetPetSpecialSkillText(pcPetData, 1))
  self._ui._txt_SkillChangeFailedCount:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_SkillChangeFailedCount:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PETSKILLCHANGE_STACK", "num", pcPetData:getSkillChangeStackCount()))
  self._ui._stc_qustionMark:SetPosX(self._ui._txt_SkillChangeFailedCount:GetTextSizeX() + 190)
  UI.setLimitTextAndAddTooltip(self._ui._txt_BaseSkill, self._ui._txt_BaseSkill:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._txt_SpecialSkill, self._ui._txt_SpecialSkill:GetText(), "")
  local uiIdx = 0
  local baseskillindex = pcPetData:getPetBaseSkillIndex()
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillindex)
  if nil ~= skillStaticStatus then
    self:setCurrentEquipSkillUi(uiIdx, baseskillindex, skillStaticStatus:getSkillTypeStaticStatusWrapper(), true)
    uiIdx = uiIdx + 1
  end
  local petSkillMaxCount = petStaticStatus:getMaxEquipSkillCount()
  for ii = 0, petSkillMaxCount do
    if true == pcPetData:isPetEquipSkillLearned(ii) then
      local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(ii)
      self:setCurrentEquipSkillUi(uiIdx, ii, skillStaticStatus:getSkillTypeStaticStatusWrapper(), false)
      uiIdx = uiIdx + 1
    end
  end
  for ii = uiIdx, self._normalSkillCount do
    self._ui._stc_CurrentSkillBg[ii]:SetShow(false)
    self._ui._stc_CurrentSkillBg[ii]:SetIgnore(true)
  end
  local cashInvenIdx = 0
  local itemCount = 0
  for cashInvenIdx = 0, ToClient_InventoryGetSize(CppEnums.ItemWhereType.eCashInventory) - 1 do
    cashInvenItem = ToClient_GetInventoryItemByProductCategory(CppEnums.ItemWhereType.eCashInventory, __eContentsType_ChangePetSkill, cashInvenIdx)
    if cashInvenItem ~= nil then
      itemCount = itemCount + Int64toInt32(cashInvenItem:get():getCount_s64())
    end
  end
  self._ui._txt_SkillChangeItemCount:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_PETSKILLCHANGE_HAVECOUNT", "count", itemCount))
end
function PaGlobal_Window_PetSkillChange_All:resizePanel()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  Panel_Window_PetSkillChange_All:SetSize(Panel_Window_PetSkillChange_All:GetSizeX(), Panel_Window_PetSkillChange_All:GetSizeY())
  Panel_Window_PetSkillChange_All:ComputePos()
end
function PaGlobal_Window_PetSkillChange_All:setPosition()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  Panel_Window_PetSkillChange_All:ComputePos()
end
function PaGlobal_Window_PetSkillChange_All:convertPercentToString(rate, isAddSymbol)
  local retPercent = string.format("%.4f", rate / CppDefine.e100Percent * 100)
  if isAddSymbol ~= nil and isAddSymbol == false then
    return retPercent
  else
    return retPercent .. "%"
  end
end
function PaGlobal_Window_PetSkillChange_All:createWishSkillListContents(contents, key)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  local rdo_baground = UI.getChildControl(contents, "RadioButton_SkillSlotBg")
  local stc_SkillIconBg = UI.getChildControl(contents, "Static_SkillIconBg")
  local stc_skillIcon = UI.getChildControl(stc_SkillIconBg, "Static_SkillIcon")
  local txt_skillName = UI.getChildControl(contents, "StaticText_SkillName")
  local txt_skillRate = UI.getChildControl(contents, "StaticText_Rate")
  local btn_apply = UI.getChildControl(contents, "Button_Adjust")
  local skillKey = tonumber(tostring(key))
  local pcPetData = ToClient_getPetSealedDataByPetNo(self._currentPetNo)
  local skillStaticStatus = ToClient_getPetEquipSkillStaticStatus(skillKey)
  local skillInfoWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
  btn_apply:addInputEvent("Mouse_LUp", "HandleEventMouseLup_PetSkillChange_ApplyButton(" .. skillKey .. " )")
  rdo_baground:addInputEvent("Mouse_LUp", "PaGlobal_Window_PetSkillChange_All:handlerMouseClickListContents(" .. skillKey .. ")")
  txt_skillName:addInputEvent("Mouse_LUp", "PaGlobal_Window_PetSkillChange_All:handlerMouseClickListContents(" .. skillKey .. ")")
  stc_skillIcon:ChangeTextureInfoNameAsync("Icon/" .. skillInfoWrapper:getIconPath())
  txt_skillRate:SetShow(false)
  btn_apply:SetShow(false)
  if self._currentSelectedKey == skillKey then
    btn_apply:SetShow(true)
    rdo_baground:ChangeTextureInfoTextureIDAsync("Combine_Frame_GradationSlot_OverClick")
    txt_skillName:SetSize(190, txt_skillName:GetSizeY())
  else
    rdo_baground:ChangeTextureInfoTextureIDAsync("Combine_Frame_GradationSlot_Normal")
    txt_skillName:SetSize(260, txt_skillName:GetSizeY())
  end
  rdo_baground:setRenderTexture(rdo_baground:getBaseTexture())
  if self._currentSelectedKey ~= nil then
    local rate = pcPetData:getSkillChangeSuccessRateView(skillKey)
    rate = rate * 100
    local calculratedRate = string.format("%.4f", rate) .. "%"
    txt_skillRate:SetText(calculratedRate)
    txt_skillRate:SetShow(true)
  end
  txt_skillName:SetTextMode(__eTextMode_AutoWrap)
  txt_skillName:SetText(skillInfoWrapper:getName())
  UI.setLimitTextAndAddTooltip(txt_skillName, txt_skillName:GetText(), "")
end
function PaGlobal_Window_PetSkillChange_All:handleEventMouseLup_SkillChangeButton(changingSkillKey, idx)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  self._currentSelectedKey = nil
  self._changingSkillKey = changingSkillKey
  self._ui._stc_SkillListBg:SetShow(true)
  self:updateLearnSkillList()
  for ii = 1, #self._ui._stc_CurrentSkillName do
    if ii == idx then
      self._ui._stc_CurrentSkillName[ii]:SetFontColor(Defines.Color.C_FFF5BA3A)
    else
      self._ui._stc_CurrentSkillName[ii]:SetFontColor(Defines.Color.C_FFDDC39E)
    end
  end
end
function PaGlobal_Window_PetSkillChange_All:updateLearnSkillList()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  self._currentSelectedKey = nil
  local pcPetData = ToClient_getPetSealedDataByPetNo(self._currentPetNo)
  local petStaticStatus = pcPetData:getPetStaticStatus()
  local maxEquipSkillCount = petStaticStatus:getMaxEquipSkillCount()
  self._ui._list2_SkillChangeSlot:getElementManager():clearKey()
  for idxSkillKey = 0, maxEquipSkillCount do
    if 0 == pcPetData:checkChangeSkill(self._changingSkillKey, idxSkillKey, true) then
      self._ui._list2_SkillChangeSlot:getElementManager():pushKey(idxSkillKey)
    end
  end
end
function PaGlobal_Window_PetSkillChange_All:handleEventMouseLup_SkillChangeApplyButton(wishSkillKey)
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  if ToClient_InventorySizeByProductCategory(CppEnums.ItemWhereType.eCashInventory, __eContentsType_ChangePetSkill) < 1 then
    PaGlobalFunc_EasyBuy_Open(128, nil, false)
    return
  end
  local pcPetData = ToClient_getPetSealedDataByPetNo(self._currentPetNo)
  local changingSkillStaticStatus = ToClient_getPetEquipSkillStaticStatus(self._changingSkillKey)
  local changingSkillWrapper = changingSkillStaticStatus:getSkillTypeStaticStatusWrapper()
  local changingSkillName = changingSkillWrapper:getName()
  local wishSkillStaticStatus = ToClient_getPetEquipSkillStaticStatus(wishSkillKey)
  local wishSkillWrapper = wishSkillStaticStatus:getSkillTypeStaticStatusWrapper()
  local wishSkillName = wishSkillStaticStatus:getName()
  local function skillChangeConfirm()
    audioPostEvent_SystemUi(3, 19)
    ToClient_requestChangeEquipPetSkill(self._currentPetNo, self._changingSkillKey, wishSkillKey)
    PaGlobal_PetSkill_Change_Close_All()
    self:dataClear()
  end
  local rate = pcPetData:getSkillChangeSuccessRateView(wishSkillKey)
  rate = rate * 100
  local calculratedRate = string.format("%.4f", rate)
  local function skillChangeCheck()
    local messageboxData = {
      title = PAGetString(Defines.StringSheet_GAME, "PANEL_PETSKILLCHANGE_TITLE"),
      content = PAGetStringParam3(Defines.StringSheet_RESOURCE, "PANEL_PETSKILLCHANGE_MSGBOXCONTENT", "skillName1", changingSkillName, "skillName2", wishSkillName, "percent", calculratedRate),
      functionYes = skillChangeConfirm,
      functionCancel = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageboxData)
  end
  skillChangeCheck()
end
function PaGlobal_Window_PetSkillChange_All:dataClear()
  if nil == Panel_Window_PetSkillChange_All then
    return
  end
  self._currentPetNo = nil
  self._changingSkillKey = nil
  for ii = 1, #self._ui._stc_CurrentSkillName do
    self._ui._stc_CurrentSkillName[ii]:SetFontColor(Defines.Color.C_FFDDC39E)
  end
end
function PaGlobal_Window_PetSkillChange_All:handlerExchangeItemPlusBtn()
  if Panel_Window_PetSkillChange_All == nil then
    return
  end
  PaGlobalFunc_EasyBuy_Open(128, nil, false)
end
function PaGlobal_Window_PetSkillChange_All:handlerMouseClickListContents(key)
  if Panel_Window_PetSkillChange_All == nil then
    return
  end
  self._currentSelectedKey = key
  local pcPetData = ToClient_getPetSealedDataByPetNo(self._currentPetNo)
  if pcPetData:setSkillChangeSuccessRateAdjust(key) ~= 0 then
    return
  end
  self._ui._list2_SkillChangeSlot:requestUpdateVisible()
  if self._isConsole == true then
    local control = self._ui._list2_SkillChangeSlot:GetContentByKey(key)
    if control ~= nil then
      local btn_apply = UI.getChildControl(control, "Button_Adjust")
      ToClient_padSnapChangeToTarget(btn_apply)
    end
  end
end
function PaGlobal_Window_PetSkillChange_All:handlerMouseChangeStackQuestionBtn(isShow)
  if isShow == true then
    TooltipSimple_Show(self._ui._stc_qustionMark, "", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETSKILLCHANGE_STACKTOOLTIPDESC"))
  else
    TooltipSimple_Hide()
  end
end
function PaGlobal_Window_PetSkillChange_All:handlerMouseChangeStackQuestionBtnToggle()
  if self._isConsoleToolTipShow == false then
    local pos = {}
    pos.x = self._ui._stc_qustionMark:GetParentPosX() + self._ui._stc_qustionMark:GetSizeX()
    pos.y = self._ui._stc_qustionMark:GetParentPosY()
    TooltipSimple_ShowSetSetPos_Console(pos, "", PAGetString(Defines.StringSheet_RESOURCE, "PANEL_PETSKILLCHANGE_STACKTOOLTIPDESC"))
    self._isConsoleToolTipShow = true
  else
    TooltipSimple_Hide()
    self._isConsoleToolTipShow = false
  end
end
