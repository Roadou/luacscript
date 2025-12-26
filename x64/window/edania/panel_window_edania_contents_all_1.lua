function PaGlobal_Edania_Contents:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_EdanaMark = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_EdanaMark")
  self._ui._stc_Boss = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_Boss")
  self._ui._stc_RegionByBoss = UI.getChildControl(self._ui._stc_Boss, "Static_RegionByBoss")
  self._ui._txt_BossTitle = UI.getChildControl(self._ui._stc_Boss, "StaticText_CastleTitle")
  self._ui._txt_BossDesc = UI.getChildControl(self._ui._stc_Boss, "StaticText_SubDesc")
  self._ui._stc_RewardItem = UI.getChildControl(self._ui._stc_Boss, "Static_Reward_ItemSlot")
  self._ui._stc_BossInfo = UI.getChildControl(self._ui._stc_Boss, "Static_AtkDef")
  self._ui._txt_BossOffence = UI.getChildControl(self._ui._stc_BossInfo, "StaticText_Atk")
  self._ui._txt_BossDefence = UI.getChildControl(self._ui._stc_BossInfo, "StaticText_Def")
  self._ui._txt_BossEquipTitle = UI.getChildControl(self._ui._stc_BossInfo, "StaticText_Title")
  self._ui._stc_EquiptmentIcon = UI.getChildControl(self._ui._stc_BossInfo, "Static_EquipmentIcon")
  self._ui._stc_Challenger = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_PVP_Application")
  self._ui._stc_ChallengerBG = UI.getChildControl(self._ui._stc_Challenger, "Static_Application_BG")
  self._ui._txt_ChallengerCastleTitle = UI.getChildControl(self._ui._stc_Challenger, "StaticText_CastleTitle")
  self._ui._txt_ChallengerCastleDesc = UI.getChildControl(self._ui._stc_Challenger, "StaticText_SubDesc")
  self._ui._stc_ChallengerCurrentEdana = UI.getChildControl(self._ui._stc_Challenger, "Static_CurrentEdana")
  self._ui._txt_ChallengerEdanaName = UI.getChildControl(self._ui._stc_ChallengerCurrentEdana, "StaticText_CurrentEdanaName")
  self._ui._txt_ChallengerEdanaIcon = UI.getChildControl(self._ui._stc_ChallengerCurrentEdana, "Static_CurrentEdanaQustionIcon")
  self._ui._stc_ChallengerProgress = UI.getChildControl(self._ui._stc_Challenger, "Static_Progress")
  self._ui._txt_ChallengerProgressTitle = UI.getChildControl(self._ui._stc_ChallengerProgress, "StaticText_Title")
  self._ui._txt_ChallengerStatus = UI.getChildControl(self._ui._stc_ChallengerProgress, "StaticText_Status")
  self._ui._stc_ChallengerChallenge = UI.getChildControl(self._ui._stc_Challenger, "Static_Challenge")
  self._ui._txt_ChallengerTitle = UI.getChildControl(self._ui._stc_ChallengerChallenge, "StaticText_Title")
  self._ui._txt_ChallengerOffence = UI.getChildControl(self._ui._stc_ChallengerChallenge, "StaticText_Attk")
  self._ui._txt_ChallengerDefence = UI.getChildControl(self._ui._stc_ChallengerChallenge, "StaticText_Def")
  self._ui._btn_Refresh = UI.getChildControl(self._ui._stc_ChallengerChallenge, "Button_Refresh")
  self._ui._txt_ChallengerItemGradeType = UI.getChildControl(self._ui._stc_ChallengerChallenge, "StaticText_CheckEquipment")
  self._ui._stc_ChallengerProgress = UI.getChildControl(self._ui._stc_Challenger, "Static_Progress")
  self._ui._chk_ChallengerInfoOpen = UI.getChildControl(self._ui._stc_ChallengerProgress, "CheckButton_InfoOpen")
  self._ui._stc_ChallengerPreviousTax = UI.getChildControl(self._ui._stc_Challenger, "Static_AccrueTax")
  self._ui._txt_ChallengerPreviousTax = UI.getChildControl(self._ui._stc_ChallengerPreviousTax, "StaticText_Tax")
  self._ui._stc_Edana = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_PVP_Management")
  self._ui._stc_EdanaBG = UI.getChildControl(self._ui._stc_Edana, "Static_Management_BG")
  self._ui._txt_EdanaCastleTitle = UI.getChildControl(self._ui._stc_Edana, "StaticText_CastleTitle")
  self._ui._txt_EdanaCastleDesc = UI.getChildControl(self._ui._stc_Edana, "StaticText_SubDesc")
  self._ui._stc_EdanaCurrentEdana = UI.getChildControl(self._ui._stc_Edana, "Static_CurrentEdana")
  self._ui._txt_EdanaEdanaName = UI.getChildControl(self._ui._stc_EdanaCurrentEdana, "StaticText_CurrentEdanaName")
  self._ui._txt_EdanaEdanaIcon = UI.getChildControl(self._ui._stc_EdanaCurrentEdana, "Static_CurrentEdanaQustionIcon")
  self._ui._stc_EdanaProgress = UI.getChildControl(self._ui._stc_Edana, "Static_Progress")
  self._ui._txt_EdanaStatus = UI.getChildControl(self._ui._stc_EdanaProgress, "StaticText_Status")
  self._ui._stc_EdanaChallenge = UI.getChildControl(self._ui._stc_Edana, "Static_Challenge")
  self._ui._txt_EdanaTitle = UI.getChildControl(self._ui._stc_EdanaChallenge, "StaticText_Title")
  self._ui._txt_EdanaOffence = UI.getChildControl(self._ui._stc_EdanaChallenge, "StaticText_Attk")
  self._ui._txt_EdanaDefence = UI.getChildControl(self._ui._stc_EdanaChallenge, "StaticText_Def")
  self._ui._txt_EdanaItemGradeType = UI.getChildControl(self._ui._stc_EdanaChallenge, "StaticText_CheckEquipment")
  self._ui._stc_EdanaProgress = UI.getChildControl(self._ui._stc_Edana, "Static_Progress")
  self._ui._chk_EdanaInfoOpen = UI.getChildControl(self._ui._stc_EdanaProgress, "CheckButton_InfoOpen")
  self._ui._stc_EdanaTax = UI.getChildControl(self._ui._stc_Edana, "Static_Tax")
  self._ui._txt_EdanaTax = UI.getChildControl(self._ui._stc_EdanaTax, "StaticText_Tax")
  self._ui._stc_EdanaPreviousTax = UI.getChildControl(self._ui._stc_Edana, "Static_AccrueTax")
  self._ui._txt_EdanaPreviousTax = UI.getChildControl(self._ui._stc_EdanaPreviousTax, "StaticText_Tax")
  self._ui._stc_EdanaInfo = UI.getChildControl(self._ui._stc_Edana, "Static_Edana")
  self._ui._stc_Resource = UI.getChildControl(self._ui._stc_EdanaInfo, "StaticText_Resource")
  self._ui._btn_FieldEnchant = UI.getChildControl(self._ui._stc_EdanaInfo, "Button_Field_Enchant")
  self._ui._btn_Join = UI.getChildControl(Panel_Window_Edania_Contents_All, "Button_Join")
  self._ui._btn_FindNpc = UI.getChildControl(Panel_Window_Edania_Contents_All, "Button_FindNpcPath")
  self._ui._btn_Return = UI.getChildControl(Panel_Window_Edania_Contents_All, "Button_Return")
  self._ui._chk_CheckArea = UI.getChildControl(Panel_Window_Edania_Contents_All, "CheckButton_CheckArea")
  self._ui._stc_Info = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_Info")
  self._ui._frame_Desc = UI.getChildControl(self._ui._stc_Info, "Frame_Description")
  local frame_Content = UI.getChildControl(self._ui._frame_Desc, "Frame_1_Content")
  self._ui._receipt._rdo_Title = UI.getChildControl(frame_Content, "RadioButton_Receipt")
  self._ui._receipt._stc_Background = UI.getChildControl(frame_Content, "Static_BG_1")
  for index = 1, self._receiptCount do
    self._ui._receipt._txt_Content[index - 1] = UI.getChildControl(self._ui._receipt._stc_Background, "StaticText_Desc_Receipt_" .. tostring(index))
  end
  self._ui._pick._rdo_Title = UI.getChildControl(frame_Content, "Radiobutton_Pick")
  self._ui._pick._stc_Background = UI.getChildControl(frame_Content, "Static_BG_2")
  for index = 1, self._pickCount do
    self._ui._pick._txt_Content[index - 1] = UI.getChildControl(self._ui._pick._stc_Background, "StaticText_Desc_Pick_" .. tostring(index))
  end
  self._ui._fightDate._rdo_Title = UI.getChildControl(frame_Content, "Radiobutton_FightDate")
  self._ui._fightDate._stc_Background = UI.getChildControl(frame_Content, "Static_BG_3")
  for index = 1, self._fightDateCount do
    self._ui._fightDate._txt_Content[index - 1] = UI.getChildControl(self._ui._fightDate._stc_Background, "StaticText_Desc_Explanation_" .. tostring(index))
  end
  self._ui._final._rdo_Title = UI.getChildControl(frame_Content, "Radiobutton_Final")
  self._ui._final._stc_Background = UI.getChildControl(frame_Content, "Static_BG_4")
  for index = 1, self._finalCount do
    self._ui._final._txt_Content[index - 1] = UI.getChildControl(self._ui._final._stc_Background, "StaticText_Desc_Edana_" .. tostring(index))
  end
  self._ui._stc_KeyGuide_LT = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_Console_Page_Left")
  self._ui._stc_KeyGuide_RT = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_Console_Page_Right")
  self._ui._stc_KeyGuide = UI.getChildControl(Panel_Window_Edania_Contents_All, "Static_KeyGuide_ConsoleUI")
  self._ui._stc_KeyGuide_A = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_A_ConsoleUI")
  self._ui._stc_KeyGuide_B = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_B_ConsoleUI")
  self._ui._stc_KeyGuide_X = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_X_ConsoleUI")
  self._ui._stc_KeyGuide_Y = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_Y_ConsoleUI")
  self._ui._stc_KeyGuide_LT_X = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_LT_X_ConsoleUI")
  self._ui._stc_KeyGuide_LT_Y = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_LT_Y_ConsoleUI")
  self._ui._stc_KeyGuide_RT_Y = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_RT_Y_ConsoleUI")
  self._ui._stc_KeyGuide_Dpad_L = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_DpadL_ConsoleUI")
  self._ui._stc_KeyGuide_Dpad_R = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_DpadR_ConsoleUI")
  self._ui._stc_KeyGuide_LS = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_KeyGuide_LS_ConsoleUI")
  self:registEventHandler()
  self:validate()
  self:initializeData()
  self._isUsePadSnapping = _ContentsGroup_UsePadSnapping
  self._isConsole = ToClient_isConsole()
  self._initialize = true
end
function PaGlobal_Edania_Contents:registEventHandler()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  registerEvent("FromClient_OpenEdaniaContents", "PaGlobal_Edania_Contents_Open")
  registerEvent("FromClient_UpdateEdaniaContents", "FromClient_UpdateEdaniaContents")
  registerEvent("FromClient_UpdateEdanaTax", "FromClient_UpdateEdanaTax")
  registerEvent("onScreenResize", "PaGlobal_Edania_Contents_ScreenResize")
  if self._isUsePadSnapping == false then
    self._ui._chk_ChallengerInfoOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_ShowInfo()")
    self._ui._chk_EdanaInfoOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_ShowInfo()")
    self._ui._btn_FieldEnchant:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_UseDropBuff()")
    self._ui._btn_Join:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_Join()")
    self._ui._btn_FindNpc:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_FindNpcPosition()")
    self._ui._btn_Return:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_TeleportToMyCastle()")
    self._ui._chk_CheckArea:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_ToggleEdaniaRegion()")
    self._ui._txt_ChallengerEdanaIcon:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(0,true)")
    self._ui._txt_ChallengerEdanaIcon:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(0,false)")
    self._ui._btn_Refresh:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_Refresh()")
    self._ui._btn_Refresh:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(4,true)")
    self._ui._btn_Refresh:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(4,false)")
    self._ui._txt_EdanaEdanaIcon:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(1,true)")
    self._ui._txt_EdanaEdanaIcon:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(1,false)")
    self._ui._stc_EdanaTax:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(2,true)")
    self._ui._stc_EdanaTax:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(2,false)")
    self._ui._stc_EdanaInfo:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(3,true)")
    self._ui._stc_EdanaInfo:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(3,false)")
    self._ui._btn_Return:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(5,true)")
    self._ui._btn_Return:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(5,false)")
    self._ui._stc_EquiptmentIcon:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(6,true)")
    self._ui._stc_EquiptmentIcon:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(6,false)")
    self._ui._chk_CheckArea:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(7,true)")
    self._ui._chk_CheckArea:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(7,false)")
    self._ui._stc_ChallengerPreviousTax:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(8,true)")
    self._ui._stc_ChallengerPreviousTax:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(8,false)")
    self._ui._stc_EdanaPreviousTax:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowTooltip(9,true)")
    self._ui._stc_EdanaPreviousTax:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowTooltip(9,false)")
    self._ui._receipt._rdo_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_DescriptionCheck(0)")
    self._ui._pick._rdo_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_DescriptionCheck(1)")
    self._ui._fightDate._rdo_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_DescriptionCheck(2)")
    self._ui._final._rdo_Title:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_DescriptionCheck(3)")
  end
end
function PaGlobal_Edania_Contents:prepareOpen(openType, edaniaRegion, openByNpc)
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self:update(openType, edaniaRegion, openByNpc)
  self:open()
  if openType == self.OPENTYPE.CHALLENGER then
    ToClient_padSnapChangeToTarget(self._ui._stc_ChallengerPreviousTax)
  elseif openType == self.OPENTYPE.EDANA then
    ToClient_padSnapChangeToTarget(self._ui._stc_EdanaPreviousTax)
  end
end
function PaGlobal_Edania_Contents:open()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  Panel_Window_Edania_Contents_All:SetShow(true)
end
function PaGlobal_Edania_Contents:prepareClose()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self._openDesc = -1
  Panel_Window_Edania_Contents_All:ClearUpdateLuaFunc()
  Panel_Tooltip_Item_hideTooltip()
  TooltipSimple_Hide()
  self:close()
end
function PaGlobal_Edania_Contents:close()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  Panel_Window_Edania_Contents_All:SetShow(false)
end
function PaGlobal_Edania_Contents:initializeData()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  local newItemSlot = {}
  SlotItem.new(newItemSlot, "Icon_ItemSlot", 0, self._ui._stc_RewardItem, self._itemSlotConfing)
  newItemSlot:clearItem()
  newItemSlot:createChild()
  newItemSlot.icon:SetPosX(5)
  newItemSlot.icon:SetPosY(5)
  newItemSlot.icon:SetSize(44, 44)
  newItemSlot.icon:SetHorizonLeft()
  newItemSlot.icon:SetVerticalTop()
  self._bossClearItem = newItemSlot
  self._ui._stc_EdanaMark:SetShow(false)
  local etcOptionWrapper = ToClient_GetEdaniaEtcOption()
  if etcOptionWrapper ~= nil then
    for regionIndex = 0, __eEdaniaRegion_Count - 1 do
      self._data[regionIndex]._challengerRoomOffenceStat = etcOptionWrapper:getLimitStat(regionIndex, false, true)
      self._data[regionIndex]._challengerRoomDefenceStat = etcOptionWrapper:getLimitStat(regionIndex, false, false)
      self._data[regionIndex]._boosRoomOffenceStat = etcOptionWrapper:getLimitStat(regionIndex, true, true)
      self._data[regionIndex]._boosRoomDefenceStat = etcOptionWrapper:getLimitStat(regionIndex, true, false)
      self._data[regionIndex]._rdo_Mark:SetShow(true)
      self._data[regionIndex]._rdo_Mark:addInputEvent("Mouse_LUp", "HandleEventLUp_Edania_Contents_ToggleEdaniaMark(" .. regionIndex .. ")")
    end
  end
  for index = 1, self._receiptCount do
    local control = self._ui._receipt._txt_Content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_MAINUI_RECEIPT_" .. tostring(index)))
    control:SetSize(control:GetSizeX(), control:GetTextSizeY())
    self._maxReceiptSize = self._maxReceiptSize + control:GetTextSizeY()
  end
  for index = 1, self._pickCount do
    local control = self._ui._pick._txt_Content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_MAINUI_PICK_" .. tostring(index)))
    control:SetSize(control:GetSizeX(), control:GetTextSizeY())
    self._maxPickSize = self._maxPickSize + control:GetTextSizeY()
  end
  for index = 1, self._fightDateCount do
    local control = self._ui._fightDate._txt_Content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_MAINUI_EXPLANATION_" .. tostring(index)))
    control:SetSize(control:GetSizeX(), control:GetTextSizeY())
    self._maxFightDateSize = self._maxFightDateSize + control:GetTextSizeY()
  end
  for index = 1, self._finalCount do
    local control = self._ui._final._txt_Content[index - 1]
    control:SetTextMode(__eTextMode_AutoWrap)
    control:SetAutoResize(true)
    control:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_MAINUI_EDANA_" .. tostring(index)))
    control:SetSize(control:GetSizeX(), control:GetTextSizeY())
    self._maxFinalSize = self._maxFinalSize + control:GetTextSizeY()
  end
  local posY = 5
  for index = 0, #self._ui._receipt._txt_Content do
    self._ui._receipt._txt_Content[index]:SetPosX(5)
  end
  self._ui._receipt._txt_Content[0]:SetPosY(5)
  self._ui._receipt._txt_Content[1]:SetPosY(self._ui._receipt._txt_Content[0]:GetPosY() + self._ui._receipt._txt_Content[0]:GetTextSizeY() + 2)
  self._ui._receipt._txt_Content[2]:SetPosY(self._ui._receipt._txt_Content[1]:GetPosY() + self._ui._receipt._txt_Content[1]:GetTextSizeY() + 2)
  self._ui._receipt._txt_Content[3]:SetPosY(self._ui._receipt._txt_Content[2]:GetPosY() + self._ui._receipt._txt_Content[2]:GetTextSizeY() + 2)
  self._ui._receipt._txt_Content[4]:SetPosY(self._ui._receipt._txt_Content[3]:GetPosY() + self._ui._receipt._txt_Content[3]:GetTextSizeY() + 2)
  self._ui._receipt._txt_Content[5]:SetPosY(self._ui._receipt._txt_Content[4]:GetPosY() + self._ui._receipt._txt_Content[4]:GetTextSizeY() + 2)
  self._ui._receipt._txt_Content[6]:SetPosY(self._ui._receipt._txt_Content[5]:GetPosY() + self._ui._receipt._txt_Content[5]:GetTextSizeY() + 2)
  posY = 5
  for index = 0, #self._ui._pick._txt_Content do
    self._ui._pick._txt_Content[index]:SetPosX(5)
  end
  self._ui._pick._txt_Content[0]:SetPosY(5)
  self._ui._pick._txt_Content[1]:SetPosY(self._ui._pick._txt_Content[0]:GetPosY() + self._ui._pick._txt_Content[0]:GetTextSizeY() + 2)
  self._ui._pick._txt_Content[2]:SetPosY(self._ui._pick._txt_Content[1]:GetPosY() + self._ui._pick._txt_Content[1]:GetTextSizeY() + 2)
  posY = 5
  for index = 0, #self._ui._fightDate._txt_Content do
    self._ui._fightDate._txt_Content[index]:SetPosX(5)
  end
  self._ui._fightDate._txt_Content[0]:SetPosY(5)
  self._ui._fightDate._txt_Content[1]:SetPosY(self._ui._fightDate._txt_Content[0]:GetPosY() + self._ui._fightDate._txt_Content[0]:GetTextSizeY() + 2)
  self._ui._fightDate._txt_Content[2]:SetPosY(self._ui._fightDate._txt_Content[1]:GetPosY() + self._ui._fightDate._txt_Content[1]:GetTextSizeY() + 2)
  self._ui._fightDate._txt_Content[3]:SetPosY(self._ui._fightDate._txt_Content[2]:GetPosY() + self._ui._fightDate._txt_Content[2]:GetTextSizeY() + 2)
  self._ui._fightDate._txt_Content[4]:SetPosY(self._ui._fightDate._txt_Content[3]:GetPosY() + self._ui._fightDate._txt_Content[3]:GetTextSizeY() + 2)
  self._ui._fightDate._txt_Content[5]:SetPosY(self._ui._fightDate._txt_Content[4]:GetPosY() + self._ui._fightDate._txt_Content[4]:GetTextSizeY() + 2)
  self._ui._fightDate._txt_Content[6]:SetPosY(self._ui._fightDate._txt_Content[5]:GetPosY() + self._ui._fightDate._txt_Content[5]:GetTextSizeY() + 2)
  self._ui._fightDate._txt_Content[7]:SetPosY(self._ui._fightDate._txt_Content[6]:GetPosY() + self._ui._fightDate._txt_Content[6]:GetTextSizeY() + 2)
  posY = 5
  for index = 0, #self._ui._final._txt_Content do
    self._ui._final._txt_Content[index]:SetPosX(5)
  end
  self._ui._final._txt_Content[0]:SetPosY(5)
  self._ui._final._txt_Content[1]:SetPosY(self._ui._final._txt_Content[0]:GetPosY() + self._ui._final._txt_Content[0]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[2]:SetPosY(self._ui._final._txt_Content[1]:GetPosY() + self._ui._final._txt_Content[1]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[3]:SetPosY(self._ui._final._txt_Content[2]:GetPosY() + self._ui._final._txt_Content[2]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[4]:SetPosY(self._ui._final._txt_Content[3]:GetPosY() + self._ui._final._txt_Content[3]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[5]:SetPosY(self._ui._final._txt_Content[4]:GetPosY() + self._ui._final._txt_Content[4]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[6]:SetPosY(self._ui._final._txt_Content[5]:GetPosY() + self._ui._final._txt_Content[5]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[7]:SetPosY(self._ui._final._txt_Content[6]:GetPosY() + self._ui._final._txt_Content[6]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[8]:SetPosY(self._ui._final._txt_Content[7]:GetPosY() + self._ui._final._txt_Content[7]:GetTextSizeY() + 2)
  self._ui._final._txt_Content[9]:SetPosY(self._ui._final._txt_Content[8]:GetPosY() + self._ui._final._txt_Content[8]:GetTextSizeY() + 2)
  local txt_receipt = UI.getChildControl(self._ui._receipt._rdo_Title, "StaticText_Receipt")
  local txt_pick = UI.getChildControl(self._ui._pick._rdo_Title, "StaticText_Pick")
  local txt_fightDate = UI.getChildControl(self._ui._fightDate._rdo_Title, "StaticText_FightDate")
  local txt_final = UI.getChildControl(self._ui._final._rdo_Title, "StaticText_Final")
  txt_receipt:SetText(ToClient_GetEdanaTimeString(__eEdaniaModeByTime_Apply))
  txt_pick:SetText(ToClient_GetEdanaTimeString(__eEdaniaModeByTime_Raffle))
  txt_fightDate:SetText(ToClient_GetEdanaTimeString(__eEdaniaModeByTime_Challenge))
  txt_final:SetText(ToClient_GetEdanaTimeString(__eEdaniaModeByTime_Edana))
  UI.setLimitTextAndAddTooltip(txt_receipt, txt_receipt:GetText(), "")
  UI.setLimitTextAndAddTooltip(txt_pick, txt_pick:GetText(), "")
  UI.setLimitTextAndAddTooltip(txt_fightDate, txt_fightDate:GetText(), "")
  UI.setLimitTextAndAddTooltip(txt_final, txt_final:GetText(), "")
end
function PaGlobal_Edania_Contents:update(openType, edaniaRegion, openByNpc)
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self:updateCommon()
  self:updateEdaniaRegion(edaniaRegion)
  self:updateOpenType(openType, openByNpc)
  self:updatePosition()
end
function PaGlobal_Edania_Contents:updateCommon()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self._ui._stc_Info:SetShow(false)
  self._ui._receipt._rdo_Title:SetCheck(true)
  self._ui._receipt._stc_Background:SetShow(false)
  self._ui._receipt._stc_Background:SetSize(self._ui._receipt._stc_Background:GetSizeX(), 1)
  self._ui._pick._rdo_Title:SetCheck(false)
  self._ui._pick._stc_Background:SetShow(false)
  self._ui._pick._stc_Background:SetSize(self._ui._pick._stc_Background:GetSizeX(), 1)
  self._ui._fightDate._rdo_Title:SetCheck(false)
  self._ui._fightDate._stc_Background:SetShow(false)
  self._ui._fightDate._stc_Background:SetSize(self._ui._fightDate._stc_Background:GetSizeX(), 1)
  self._ui._final._rdo_Title:SetCheck(false)
  self._ui._final._stc_Background:SetShow(false)
  self._ui._final._stc_Background:SetSize(self._ui._final._stc_Background:GetSizeX(), 1)
  PaGlobal_Edania_Contents_ScreenResize()
  HandleEventLUp_Edania_Contents_DescriptionCheck(0)
  ToClient_requestInstanceFieldRoomList(false, __eInstanceContentsType_Edania)
  self._ui._txt_ChallengerStatus:SetText(ToClient_GetEdanaTimeString(__eEdaniaModeByTime_Count))
  self._ui._txt_EdanaStatus:SetText(ToClient_GetEdanaTimeString(__eEdaniaModeByTime_Count))
  UI.setLimitTextAndAddTooltip(self._ui._txt_ChallengerProgressTitle, self._ui._txt_ChallengerProgressTitle:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._txt_ChallengerStatus, self._ui._txt_ChallengerStatus:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._txt_EdanaStatus, self._ui._txt_EdanaStatus:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._btn_FieldEnchant, self._ui._btn_FieldEnchant:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._btn_Return, self._ui._btn_Return:GetText(), "")
  UI.setLimitTextAndAddTooltip(self._ui._chk_CheckArea, self._ui._chk_CheckArea:GetText(), "")
  Panel_Window_Edania_Contents_All:RegisterUpdateFunc("PaGlobal_Edania_Contents_InformationUpdate")
end
function PaGlobal_Edania_Contents:updateEdaniaRegion(edaniaRegion)
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self._edaniaRegion = edaniaRegion
  local etcOptionWrapper = ToClient_GetEdaniaEtcOption()
  local edanaInfoWrapper = ToClient_GetEdanaInfo(edaniaRegion)
  if etcOptionWrapper == nil or edanaInfoWrapper == nil then
    return
  end
  local edaniaRegionData = self._data[edaniaRegion]
  local offenceValue = ToClient_getAttackDisplayOffenceMax(false)
  local defenceValue = ToClient_getAttackDisplayDefence(false)
  local bossClearItemKey = etcOptionWrapper:getEdanaBossClearItemKey(edaniaRegion)
  local checkBossRoomItemGradeType = ToClient_CheckBossRoomItemGradeType(edaniaRegion)
  local checkChallengerRoomItemGradeType = ToClient_CheckChallengerRoomItemGradeType(edaniaRegion)
  self._ui._stc_EdanaMark:ChangeTextureInfoTextureIDAsync(edaniaRegionData._edanaMarkTexture)
  local edaniaApplyRegion = ToClient_GetEdaniaApplyRegion()
  for regionIndex = 0, __eEdaniaRegion_Count - 1 do
    local mark = self._data[regionIndex]._rdo_Mark
    if regionIndex == edaniaRegion then
      mark:setRenderTexture(mark:getClickTexture())
      mark:SetCheck(true)
      mark:SetMonoTone(false)
    else
      mark:setRenderTexture(mark:getBaseTexture())
      mark:SetCheck(false)
      mark:SetMonoTone(true)
    end
    local applyControl = UI.getChildControl(mark, "Static_Apply")
    if applyControl ~= nil then
      applyControl:SetShow(regionIndex == edaniaApplyRegion)
    end
  end
  self._ui._stc_RegionByBoss:ChangeTextureInfoTextureIDAsync(edaniaRegionData._bossTexture)
  self._ui._txt_BossTitle:SetText(edaniaRegionData._bossName)
  self._ui._txt_BossDesc:SetText(edaniaRegionData._bossDesc)
  if offenceValue >= edaniaRegionData._boosRoomOffenceStat then
    self._ui._txt_BossOffence:SetText("<PAColor0xffb5e45b>" .. tostring(edaniaRegionData._boosRoomOffenceStat) .. "<PAOldColor>")
  else
    self._ui._txt_BossOffence:SetText("<PAColor0xffee6257>" .. tostring(edaniaRegionData._boosRoomOffenceStat) .. "<PAOldColor>")
  end
  if defenceValue >= edaniaRegionData._boosRoomDefenceStat then
    self._ui._txt_BossDefence:SetText("<PAColor0xffb5e45b>" .. tostring(edaniaRegionData._boosRoomDefenceStat) .. "<PAOldColor>")
  else
    self._ui._txt_BossDefence:SetText("<PAColor0xffee6257>" .. tostring(edaniaRegionData._boosRoomDefenceStat) .. "<PAOldColor>")
  end
  local bossRoomItemGradeText = ""
  if checkBossRoomItemGradeType == true then
    bossRoomItemGradeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_QUEST_COMPLETE_EQUIPMENT")
  else
    bossRoomItemGradeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_QUEST_INCOMPLETE_EQUIPMENT")
  end
  self._ui._txt_BossEquipTitle:SetText(bossRoomItemGradeText)
  UI.setLimitTextAndAddTooltip(self._ui._txt_BossEquipTitle, bossRoomItemGradeText, "")
  local bossClearItemSSW = getItemEnchantStaticStatus(bossClearItemKey)
  if bossClearItemSSW == nil then
    self._bossClearItem:clearItem()
    self._bossClearItem.icon:addInputEvent("Mouse_On", "")
    self._bossClearItem.icon:addInputEvent("Mouse_Out", "")
  else
    self._bossClearItem:setItemByStaticStatus(bossClearItemSSW)
    self._bossClearItem.icon:addInputEvent("Mouse_On", "HandleEventLUp_Edania_Contents_ShowBossClearItemTooltip(true)")
    self._bossClearItem.icon:addInputEvent("Mouse_Out", "HandleEventLUp_Edania_Contents_ShowBossClearItemTooltip(false)")
  end
  UI.setLimitTextAndAddTooltip(self._ui._txt_ChallengerTitle, self._ui._txt_ChallengerTitle:GetText(), "")
  self._ui._txt_ChallengerCastleTitle:SetText(edaniaRegionData._castleName)
  self._ui._txt_ChallengerCastleDesc:SetText(edaniaRegionData._castleDesc)
  self._ui._txt_ChallengerEdanaName:SetText(edanaInfoWrapper:getUserNickName())
  if offenceValue >= edaniaRegionData._challengerRoomOffenceStat then
    self._ui._txt_ChallengerOffence:SetText("<PAColor0xffb5e45b>" .. tostring(edaniaRegionData._challengerRoomOffenceStat) .. "<PAOldColor>")
  else
    self._ui._txt_ChallengerOffence:SetText("<PAColor0xffee6257>" .. tostring(edaniaRegionData._challengerRoomOffenceStat) .. "<PAOldColor>")
  end
  if defenceValue >= edaniaRegionData._challengerRoomDefenceStat then
    self._ui._txt_ChallengerDefence:SetText("<PAColor0xffb5e45b>" .. tostring(edaniaRegionData._challengerRoomDefenceStat) .. "<PAOldColor>")
  else
    self._ui._txt_ChallengerDefence:SetText("<PAColor0xffee6257>" .. tostring(edaniaRegionData._challengerRoomDefenceStat) .. "<PAOldColor>")
  end
  local challengerRoomItemGradeText = ""
  if checkChallengerRoomItemGradeType == true then
    challengerRoomItemGradeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_QUEST_COMPLETE_EQUIPMENT")
  else
    challengerRoomItemGradeText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_QUEST_INCOMPLETE_EQUIPMENT")
  end
  self._ui._txt_ChallengerItemGradeType:SetText(challengerRoomItemGradeText)
  self._ui._txt_ChallengerPreviousTax:SetText(makeDotMoney(edanaInfoWrapper:getPreviousTax()))
  local spanX = self._ui._btn_FieldEnchant:GetSpanSize().x + 13
  self._ui._txt_ChallengerPreviousTax:SetPosX(self._ui._stc_ChallengerPreviousTax:GetSizeX() - self._ui._txt_ChallengerPreviousTax:GetSizeX() - self._ui._txt_ChallengerPreviousTax:GetTextSizeX() - spanX)
  UI.setLimitTextAndAddTooltip(self._ui._txt_EdanaTitle, self._ui._txt_EdanaTitle:GetText(), "")
  self._ui._txt_EdanaCastleTitle:SetText(edaniaRegionData._castleName)
  self._ui._txt_EdanaCastleDesc:SetText(edaniaRegionData._castleDesc)
  self._ui._txt_EdanaEdanaName:SetText(edanaInfoWrapper:getUserNickName())
  if offenceValue >= edaniaRegionData._challengerRoomOffenceStat then
    self._ui._txt_EdanaOffence:SetText("<PAColor0xffb5e45b>" .. tostring(edaniaRegionData._challengerRoomOffenceStat) .. "<PAOldColor>")
  else
    self._ui._txt_EdanaOffence:SetText("<PAColor0xffee6257>" .. tostring(edaniaRegionData._challengerRoomOffenceStat) .. "<PAOldColor>")
  end
  if defenceValue >= edaniaRegionData._challengerRoomDefenceStat then
    self._ui._txt_EdanaDefence:SetText("<PAColor0xffb5e45b>" .. tostring(edaniaRegionData._challengerRoomDefenceStat) .. "<PAOldColor>")
  else
    self._ui._txt_EdanaDefence:SetText("<PAColor0xffee6257>" .. tostring(edaniaRegionData._challengerRoomDefenceStat) .. "<PAOldColor>")
  end
  self._ui._txt_EdanaItemGradeType:SetText(challengerRoomItemGradeText)
  self._ui._txt_EdanaTax:SetText(makeDotMoney(edanaInfoWrapper:getTax()))
  self._ui._txt_EdanaPreviousTax:SetText(makeDotMoney(edanaInfoWrapper:getPreviousTax()))
  self._ui._txt_EdanaPreviousTax:SetPosX(self._ui._stc_EdanaPreviousTax:GetSizeX() - self._ui._txt_EdanaPreviousTax:GetSizeX() - self._ui._txt_EdanaPreviousTax:GetTextSizeX() - spanX)
  self._ui._stc_Resource:SetText(tostring(edanaInfoWrapper:getDropBuffCount()) .. " / " .. tostring(etcOptionWrapper:getEdanaDropBuffCount()))
end
function PaGlobal_Edania_Contents:updateOpenType(openType, openByNpc)
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self._openType = openType
  self._ui._stc_KeyGuide_LT:SetShow(false)
  self._ui._stc_KeyGuide_RT:SetShow(false)
  self._ui._stc_KeyGuide:SetShow(false)
  self._ui._stc_KeyGuide_A:SetShow(false)
  self._ui._stc_KeyGuide_B:SetShow(false)
  self._ui._stc_KeyGuide_X:SetShow(false)
  self._ui._stc_KeyGuide_Y:SetShow(false)
  self._ui._stc_KeyGuide_LT_X:SetShow(false)
  self._ui._stc_KeyGuide_LT_Y:SetShow(false)
  self._ui._stc_KeyGuide_RT_Y:SetShow(false)
  self._ui._stc_KeyGuide_Dpad_L:SetShow(false)
  self._ui._stc_KeyGuide_Dpad_R:SetShow(false)
  self._ui._stc_KeyGuide_LS:SetShow(false)
  if self._isUsePadSnapping == true then
    self._ui._stc_KeyGuide_LT:SetShow(true)
    self._ui._stc_KeyGuide_RT:SetShow(true)
    self._ui._stc_KeyGuide:SetShow(true)
    self._ui._stc_KeyGuide:SetSize(getScreenSizeX(), self._ui._stc_KeyGuide:GetSizeY())
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_LT, "PaGlobal_Edania_Contents_ChangeEdana(true)")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_RT, "PaGlobal_Edania_Contents_ChangeEdana(false)")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "")
    Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "")
  end
  if openType == self.OPENTYPE.BOSS then
    self._ui._stc_Boss:SetShow(true)
    self._ui._stc_Challenger:SetShow(false)
    self._ui._stc_Edana:SetShow(false)
    self._ui._btn_Join:SetShow(true)
    self._ui._btn_FindNpc:SetShow(false)
    self._ui._btn_Return:SetShow(false)
    self._ui._chk_CheckArea:SetShow(false)
    local countString = ""
    if ToClient_IsClearEdaniaBossQuest(self._edaniaRegion) == true then
      countString = "0 / 1"
    else
      countString = "1 / 1"
    end
    self._ui._btn_Join:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_BOSS_ENTER_COUNT", "count", countString))
    for regionIndex = 0, __eEdaniaRegion_Count - 1 do
      local mark = self._data[regionIndex]._rdo_Mark
      mark:SetIgnore(true)
    end
    if self._isUsePadSnapping == true then
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_X, "HandleEventLUp_Edania_Contents_ShowBossClearItemTooltip(true)")
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Edania_Contents_Join()")
      self._ui._stc_KeyGuide_LT_X:SetShow(true)
      self._ui._stc_KeyGuide_Y:SetShow(true)
      self._ui._stc_KeyGuide_B:SetShow(true)
      local keyGuideList = {
        self._ui._stc_KeyGuide_LT_X,
        self._ui._stc_KeyGuide_Y,
        self._ui._stc_KeyGuide_B
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      self._ui._stc_KeyGuide:SetSpanSize(self._ui._stc_KeyGuide:GetSpanSize().x, 0)
    end
  elseif openType == self.OPENTYPE.CHALLENGER then
    self._ui._stc_Boss:SetShow(false)
    self._ui._stc_Challenger:SetShow(true)
    self._ui._stc_Edana:SetShow(false)
    self._ui._btn_Join:SetShow(openByNpc == true)
    self._ui._btn_FindNpc:SetShow(openByNpc == false)
    self._ui._btn_Return:SetShow(false)
    self._ui._chk_CheckArea:SetShow(false)
    self._ui._btn_Join:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_ENTER"))
    for regionIndex = 0, __eEdaniaRegion_Count - 1 do
      local mark = self._data[regionIndex]._rdo_Mark
      if openByNpc == true then
        mark:SetIgnore(true)
      else
        mark:SetIgnore(false)
      end
    end
    if self._isUsePadSnapping == true then
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_Edania_Contents_Refresh()")
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventLUp_Edania_Contents_ShowInfo()")
      self._ui._stc_KeyGuide_LT_Y:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_BUTTON_REFRESH"))
      if openByNpc == true then
        Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Edania_Contents_Join()")
        self._ui._stc_KeyGuide_LT_Y:SetShow(true)
        self._ui._stc_KeyGuide_Dpad_L:SetShow(true)
        self._ui._stc_KeyGuide_Y:SetShow(true)
        self._ui._stc_KeyGuide_B:SetShow(true)
        local keyGuideList = {
          self._ui._stc_KeyGuide_LT_Y,
          self._ui._stc_KeyGuide_Dpad_L,
          self._ui._stc_KeyGuide_Y,
          self._ui._stc_KeyGuide_B
        }
        PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
        self._ui._stc_KeyGuide:SetSpanSize(self._ui._stc_KeyGuide:GetSpanSize().x, 0)
      else
        Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventLUp_Edania_Contents_FindNpcPosition()")
        self._ui._stc_KeyGuide_LT_Y:SetShow(true)
        self._ui._stc_KeyGuide_Dpad_L:SetShow(true)
        self._ui._stc_KeyGuide_X:SetShow(true)
        self._ui._stc_KeyGuide_B:SetShow(true)
        local keyGuideList = {
          self._ui._stc_KeyGuide_LT_Y,
          self._ui._stc_KeyGuide_Dpad_L,
          self._ui._stc_KeyGuide_X,
          self._ui._stc_KeyGuide_B
        }
        PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
        self._ui._stc_KeyGuide:SetSpanSize(self._ui._stc_KeyGuide:GetSpanSize().x, 0)
      end
    end
  elseif openType == self.OPENTYPE.EDANA then
    self._ui._stc_Boss:SetShow(false)
    self._ui._stc_Challenger:SetShow(false)
    self._ui._stc_Edana:SetShow(true)
    self._ui._btn_Join:SetShow(true)
    self._ui._btn_FindNpc:SetShow(false)
    self._ui._btn_Return:SetShow(true)
    self._ui._chk_CheckArea:SetShow(true)
    self._ui._chk_CheckArea:SetCheck(ToClient_IsEdaniaAreaOn() == true)
    self._ui._btn_Join:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_ENTER"))
    ToClient_RequestEdanaMiscInfo(self._edaniaRegion)
    for regionIndex = 0, __eEdaniaRegion_Count - 1 do
      local mark = self._data[regionIndex]._rdo_Mark
      mark:SetIgnore(true)
    end
    if self._isUsePadSnapping == true then
      self._ui._stc_KeyGuide_LT_Y:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_SYSTEM_INCREASE_DROP_ITEM"))
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_DpadLeft, "HandleEventLUp_Edania_Contents_ShowInfo()")
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_Edania_Contents_Join()")
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_RTPress_Y, "HandleEventLUp_Edania_Contents_TeleportToMyCastle()")
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LTPress_Y, "HandleEventLUp_Edania_Contents_UseDropBuff()")
      Panel_Window_Edania_Contents_All:registerPadEvent(__eConsoleUIPadEvent_LSClick, "HandleEventLUp_Edania_Contents_ToggleEdaniaRegion()")
      self._ui._stc_KeyGuide_LS:SetShow(true)
      self._ui._stc_KeyGuide_LT_Y:SetShow(true)
      self._ui._stc_KeyGuide_RT_Y:SetShow(true)
      self._ui._stc_KeyGuide_Dpad_L:SetShow(true)
      self._ui._stc_KeyGuide_Y:SetShow(true)
      self._ui._stc_KeyGuide_B:SetShow(true)
      local keyGuideList = {
        self._ui._stc_KeyGuide_LS,
        self._ui._stc_KeyGuide_LT_Y,
        self._ui._stc_KeyGuide_RT_Y,
        self._ui._stc_KeyGuide_Dpad_L,
        self._ui._stc_KeyGuide_Y,
        self._ui._stc_KeyGuide_B
      }
      PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuideList, self._ui._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
      self._ui._stc_KeyGuide:SetSpanSize(self._ui._stc_KeyGuide:GetSpanSize().x, 0)
    end
  else
    _PA_ASSERT(false, "OPENTYPE\236\157\180 \236\182\148\234\176\128\235\144\152\236\151\136\236\138\181\235\139\136\235\139\164. \236\158\145\236\151\133\237\149\180\236\163\188\236\132\184\236\154\148!")
  end
end
function PaGlobal_Edania_Contents:updatePosition()
  local spanX = self._ui._btn_Refresh:GetSpanSize().x
  self._ui._txt_ChallengerStatus:SetPosX(self._ui._stc_ChallengerChallenge:GetSizeX() - self._ui._txt_ChallengerStatus:GetSizeX() - self._ui._btn_Refresh:GetSizeX() - spanX)
  spanX = self._ui._btn_FieldEnchant:GetSpanSize().x
  self._ui._txt_EdanaStatus:SetSize(self._ui._txt_EdanaStatus:GetTextSizeX(), self._ui._txt_EdanaStatus:GetSizeY())
  self._ui._txt_EdanaStatus:SetPosX(self._ui._stc_EdanaProgress:GetSizeX() - self._ui._txt_EdanaStatus:GetSizeX() - self._ui._chk_EdanaInfoOpen:GetSizeX() - spanX)
end
function PaGlobal_Edania_Contents:validate()
  if Panel_Window_Edania_Contents_All == nil then
    return
  end
  self._ui._stc_EdanaMark:isValidate()
  self._ui._stc_Boss:isValidate()
  self._ui._stc_RegionByBoss:isValidate()
  self._ui._txt_BossTitle:isValidate()
  self._ui._txt_BossDesc:isValidate()
  self._ui._stc_RewardItem:isValidate()
  self._ui._stc_BossInfo:isValidate()
  self._ui._txt_BossOffence:isValidate()
  self._ui._txt_BossDefence:isValidate()
  self._ui._txt_BossEquipTitle:isValidate()
  self._ui._stc_EquiptmentIcon:isValidate()
  self._ui._stc_Challenger:isValidate()
  self._ui._stc_ChallengerBG:isValidate()
  self._ui._txt_ChallengerCastleTitle:isValidate()
  self._ui._txt_ChallengerCastleDesc:isValidate()
  self._ui._stc_ChallengerCurrentEdana:isValidate()
  self._ui._txt_ChallengerEdanaName:isValidate()
  self._ui._stc_ChallengerProgress:isValidate()
  self._ui._txt_ChallengerStatus:isValidate()
  self._ui._stc_ChallengerChallenge:isValidate()
  self._ui._txt_ChallengerOffence:isValidate()
  self._ui._txt_ChallengerDefence:isValidate()
  self._ui._btn_Refresh:isValidate()
  self._ui._txt_ChallengerItemGradeType:isValidate()
  self._ui._stc_ChallengerProgress:isValidate()
  self._ui._chk_ChallengerInfoOpen:isValidate()
  self._ui._stc_ChallengerPreviousTax:isValidate()
  self._ui._txt_ChallengerPreviousTax:isValidate()
  self._ui._stc_Edana:isValidate()
  self._ui._stc_EdanaBG:isValidate()
  self._ui._txt_EdanaCastleTitle:isValidate()
  self._ui._txt_EdanaCastleDesc:isValidate()
  self._ui._stc_EdanaCurrentEdana:isValidate()
  self._ui._txt_EdanaEdanaName:isValidate()
  self._ui._stc_EdanaProgress:isValidate()
  self._ui._txt_EdanaStatus:isValidate()
  self._ui._stc_EdanaChallenge:isValidate()
  self._ui._txt_EdanaOffence:isValidate()
  self._ui._txt_EdanaDefence:isValidate()
  self._ui._txt_EdanaItemGradeType:isValidate()
  self._ui._stc_EdanaProgress:isValidate()
  self._ui._chk_EdanaInfoOpen:isValidate()
  self._ui._stc_EdanaTax:isValidate()
  self._ui._txt_EdanaTax:isValidate()
  self._ui._stc_EdanaPreviousTax:isValidate()
  self._ui._txt_EdanaPreviousTax:isValidate()
  self._ui._stc_EdanaInfo:isValidate()
  self._ui._stc_Resource:isValidate()
  self._ui._btn_FieldEnchant:isValidate()
  self._ui._btn_Join:isValidate()
  self._ui._btn_FindNpc:isValidate()
  self._ui._btn_Return:isValidate()
  self._ui._chk_CheckArea:isValidate()
  self._ui._stc_Info:isValidate()
  self._ui._stc_KeyGuide:isValidate()
  self._ui._stc_KeyGuide_A:isValidate()
  self._ui._stc_KeyGuide_B:isValidate()
  self._ui._stc_KeyGuide_X:isValidate()
  self._ui._stc_KeyGuide_Y:isValidate()
  self._ui._stc_KeyGuide_LT_X:isValidate()
  self._ui._stc_KeyGuide_LT_Y:isValidate()
  self._ui._stc_KeyGuide_RT_Y:isValidate()
  self._ui._stc_KeyGuide_Dpad_L:isValidate()
  self._ui._stc_KeyGuide_Dpad_R:isValidate()
end
