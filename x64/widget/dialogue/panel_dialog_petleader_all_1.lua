function PaGlobal_DialogPetLeader_All:initialize()
  if true == PaGlobal_DialogPetLeader_All._initialize then
    return
  end
  local titleBar = UI.getChildControl(Panel_Dialog_PetLeader_All, "Static_TitleBar")
  self._ui_pc.btn_Exit = UI.getChildControl(titleBar, "Button_Win_Close")
  self._ui_pc.btn_Question = UI.getChildControl(titleBar, "Button_Question")
  local mainBg = UI.getChildControl(Panel_Dialog_PetLeader_All, "Static_Main_BG")
  self._ui.stc_SlotBg = UI.getChildControl(mainBg, "Static_Slot_BG")
  self._ui.stc_PetSlotEmpty = UI.getChildControl(self._ui.stc_SlotBg, "Static_PetSlot_Empty")
  self._ui.stc_PetSlot = UI.getChildControl(self._ui.stc_SlotBg, "Static_PetSlot")
  self._ui.stc_ItemSlot = UI.getChildControl(self._ui.stc_SlotBg, "Static_ItemSlot")
  self._ui.stc_ResultSlot = UI.getChildControl(self._ui.stc_SlotBg, "Static_ResultSlot")
  self._ui.stc_SkillDesc = UI.getChildControl(mainBg, "Static_LeaderSkill_Desc")
  self._ui.txt_SkillTitle = UI.getChildControl(self._ui.stc_SkillDesc, "StaticText_Skill_Title")
  self._ui.txt_Empty = UI.getChildControl(mainBg, "MultilineText_Desc_Empty")
  self._ui.stc_SkillBg = UI.getChildControl(mainBg, "Static_Skill_BG")
  self._ui.stc_UpgradeBg = UI.getChildControl(self._ui.stc_SkillBg, "Static_Upgrade_BG")
  self._ui.stc_SkillSubBg = UI.getChildControl(self._ui.stc_SkillBg, "Static_SubBG")
  self._ui.txt_LeaderSkillDesc = UI.getChildControl(self._ui.stc_SkillSubBg, "StaticText_Desc_Skill_0")
  self._ui.txt_BaseSkill = UI.getChildControl(self._ui.stc_SkillSubBg, "StaticText_Desc_Skill_1")
  self._ui.stc_UpgradeIcon = UI.getChildControl(self._ui.txt_BaseSkill, "Static_UpgradeIcon")
  self._ui.txt_BaseSkillDesc = UI.getChildControl(self._ui.txt_BaseSkill, "StaticText_Desc")
  self._ui.txt_DescBox = UI.getChildControl(Panel_Dialog_PetLeader_All, "StaticText_DescBox")
  self._ui.txt_Desc = UI.getChildControl(self._ui.txt_DescBox, "StaticText_1")
  self._ui.txt_Desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_Desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLEADER_DESC_MAIN"))
  local addSizeY = self._ui.txt_Desc:GetTextSizeY() - self._ui.txt_Desc:GetSizeY()
  self._ui.txt_DescBox:SetSize(self._ui.txt_DescBox:GetSizeX(), self._ui.txt_DescBox:GetSizeY() + addSizeY)
  self._ui.txt_Desc:SetSize(self._ui.txt_Desc:GetSizeX(), self._ui.txt_Desc:GetTextSizeY())
  if addSizeY > 0 then
    Panel_Dialog_PetLeader_All:SetSize(Panel_Dialog_PetLeader_All:GetSizeX(), Panel_Dialog_PetLeader_All:GetSizeY() + addSizeY)
  end
  self._ui_pc.btn_Training = UI.getChildControl(mainBg, "Button_Training")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:changePlatform()
  PaGlobal_DialogPetLeader_All:registEventHandler()
  PaGlobal_DialogPetLeader_All:validate()
  PaGlobal_DialogPetLeader_All._initialize = true
end
function PaGlobal_DialogPetLeader_All:registEventHandler()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  self._ui_pc.btn_Exit:addInputEvent("Mouse_LUp", "PaGlobal_DialogPetLeader_All_Close()")
  self._ui_pc.btn_Question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PetLeader\" )")
  registerEvent("FromClient_PetUpgradeComplete", "FromClient_DialogPetLeader_All_Update")
  registerEvent("onScreenResize", "PaGlobal_DialogPetLeader_All_OnScreenSizeRefresh")
end
function PaGlobal_DialogPetLeader_All:changePlatform()
  for _, control in pairs(self._ui_pc) do
    control:SetShow(not self._isConsole)
  end
end
function PaGlobal_DialogPetLeader_All:prepareOpen()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  if _ContentsGroup_PetLeader == false then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local startPosX = screenSizeX - Panel_Dialog_PetLeader_All:GetSizeX()
  if screenSizeY <= 800 then
    Panel_Dialog_PetLeader_All:SetPosY(screenSizeY / 2 - Panel_Dialog_PetLeader_All:GetSizeY() / 2 - 30)
  else
    Panel_Dialog_PetLeader_All:SetPosY(screenSizeY / 2 - Panel_Dialog_PetLeader_All:GetSizeY() / 2 - 100)
  end
  Panel_Dialog_PetLeader_All:ComputePos()
  PaGlobal_DialogPetLeader_All:clear()
  PaGlobal_DialogPetLeader_List_All_Open()
  ToClient_UpdateOpenUICondition(__eCheckOpenUIType_5TierPetUpgrade)
  PaGlobal_DialogPetLeader_All:open()
end
function PaGlobal_DialogPetLeader_All:open()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  Panel_Dialog_PetLeader_All:SetShow(true)
end
function PaGlobal_DialogPetLeader_All:prepareClose()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  PaGlobal_DialogPetLeader_All:clear()
  PaGlobal_DialogPetLeader_List_All_Close()
  PaGlobal_DialogPetLeader_All:close()
end
function PaGlobal_DialogPetLeader_All:close()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  Panel_Dialog_PetLeader_All:SetShow(false)
end
function PaGlobal_DialogPetLeader_All:validate()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
end
function PaGlobal_DialogPetLeader_All:pushPet(sealIndex)
  if nil == Panel_Dialog_PetLeader_All or nil == sealIndex then
    return
  end
  PaGlobal_DialogPetLeader_All:clear()
  local pcPetData = ToClient_getPetSealedDataByIndex(sealIndex)
  if nil == pcPetData then
    return
  end
  local petStaticStatus = pcPetData:getPetStaticStatus()
  if nil == petStaticStatus then
    return
  end
  local characterKey = petStaticStatus:getCharacterKey()
  local iconPath = pcPetData:getIconPath()
  local petNo_s64 = pcPetData._petNo
  local petLevel = pcPetData._level
  local petTier = petStaticStatus:getPetTier() + 1
  local skillType
  if nil ~= pcPetData:getSkillParam(1) then
    skillType = pcPetData:getSkillParam(1)._type
  end
  if petTier < 4 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_CANTBETOGETHER_TEXT"))
    return
  end
  if not _ContentsGroup_PetLevelDelete and petLevel < 10 then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_CANTBETOGETHER_TEXT"))
    return
  end
  local newPetStaticStatus = ToClient_getPetUpgradeSimulationResult(characterKey)
  if nil == newPetStaticStatus then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_PETCOMPOSE_CANTBETOGETHER_TEXT"))
    return
  end
  self._ui.stc_PetSlotEmpty:SetShow(false)
  self._ui.stc_PetSlot:ChangeTextureInfoNameAsync(iconPath)
  local upgradeItemKey = ToClient_getPetUpgradeItem(petStaticStatus:getPetTier())
  local inventory = getSelfPlayer():get():getInventory(CppEnums.ItemWhereType.eInventory)
  local invenMaxSize = inventory:sizeXXX()
  local itemSlotNo
  for ii = __eTInventorySlotNoUseStart, invenMaxSize - 1 do
    local itemWrapper = getInventoryItemByType(CppEnums.ItemWhereType.eInventory, ii)
    if nil ~= itemWrapper then
      local item = itemWrapper:get()
      if nil ~= item then
        local itemkey = item:getKey():getItemKey()
        if nil ~= itemkey and upgradeItemKey:getItemKey() == itemkey then
          itemSlotNo = ii
          break
        end
      end
    end
  end
  if itemSlotNo ~= nil then
    self._ui.stc_ItemSlot:SetMonoTone(false)
    self._ui_pc.btn_Training:SetEnable(true)
    self._ui_pc.btn_Training:SetMonoTone(false)
    self._ui_pc.btn_Training:SetIgnore(false)
    self._ui_pc.btn_Training:addInputEvent("Mouse_LUp", "HandleEventLUp_DialogPetLeader_All_Confirm(" .. tostring(sealIndex) .. "," .. tostring(itemSlotNo) .. ")")
    Panel_Dialog_PetLeader_List_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_DialogPetLeader_All_Confirm(" .. tostring(sealIndex) .. "," .. tostring(itemSlotNo) .. ")")
  end
  self._ui.stc_ResultSlot:ChangeTextureInfoNameAsync(iconPath)
  local leaderBuffPercent = ToClient_getPetLeaderBuff(newPetStaticStatus:getPetTier())
  self._ui.txt_LeaderSkillDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_LeaderSkillDesc:SetText(PAGetStringParam1(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_PETLEADER_SKILL_DESC", "percent", leaderBuffPercent))
  self._ui.stc_SkillBg:SetShow(true)
  self._ui.txt_Empty:SetShow(false)
  self._ui.txt_BaseSkill:SetShow(true)
  local baseskillIndex = ToClient_getLeaderBaseSkill(petNo_s64)
  local skillStaticStatus = ToClient_getPetBaseSkillStaticStatus(baseskillIndex)
  if skillStaticStatus ~= nil then
    local skillTypeStaticWrapper = skillStaticStatus:getSkillTypeStaticStatusWrapper()
    if skillTypeStaticWrapper ~= nil then
      local skillNo = skillStaticStatus:getSkillNo()
      self._ui.txt_BaseSkill:SetShow(true)
      self._ui.txt_BaseSkill:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
      self._ui.txt_BaseSkillDesc:SetShow(true)
      self._ui.txt_BaseSkillDesc:SetTextMode(__eTextMode_AutoWrap)
      self._ui.txt_BaseSkillDesc:SetText(skillStaticStatus:getName())
      if self._isConsole == false then
        self._ui.txt_BaseSkillDesc:addInputEvent("Mouse_On", "HandleEventMouseOn_DialogPetLeader_All_BaseSkillTooltip( " .. baseskillIndex .. ", \"sealPetListSkill\" )")
        self._ui.txt_BaseSkillDesc:addInputEvent("Mouse_Out", "HandleEventMouseOut_DialogPetLeader_All_Hide_SkillToolTip()")
        Panel_SkillTooltip_SetPosition(skillNo, self._ui.txt_BaseSkillDesc, "sealPetListSkill")
      end
    end
  end
end
function PaGlobal_DialogPetLeader_All:clear()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  self._ui.txt_Empty:SetShow(true)
  self._ui.stc_SkillDesc:SetShow(false)
  self._ui.stc_PetSlotEmpty:SetShow(true)
  self._ui.stc_PetSlot:ChangeTextureInfoNameAsync("")
  self._ui.stc_ResultSlot:ChangeTextureInfoNameAsync("")
  self._ui_pc.btn_Training:SetEnable(false)
  self._ui_pc.btn_Training:SetMonoTone(true)
  self._ui_pc.btn_Training:SetIgnore(true)
  self._ui.txt_LeaderSkillDesc:SetText("-")
  self._ui.txt_Empty:SetShow(true)
  self._ui.stc_SkillBg:SetShow(false)
  local upgradeItemKey = ToClient_getPetUpgradeItem(3)
  local itemWrapper = getItemEnchantStaticStatus(upgradeItemKey)
  if nil ~= itemWrapper then
    self._ui.stc_ItemSlot:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getIconPath())
    self._ui.stc_ItemSlot:SetMonoTone(true)
    self._ui.stc_ItemSlot:addInputEvent("Mouse_On", "HandleEventOnOut_DialogPetLeader_All_ItemTooltip(true" .. "," .. tostring(upgradeItemKey:getItemKey()) .. ")")
    self._ui.stc_ItemSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogPetLeader_All_ItemTooltip(false" .. "," .. tostring(upgradeItemKey:getItemKey()) .. ")")
  end
  self._ui_pc.btn_Training:addInputEvent("Mouse_LUp", "")
  Panel_Dialog_PetLeader_List_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  self._upgradeSealIndex = nil
  self._upgradeInvenSlotNo = nil
  self._isUpgradeStart = false
  Panel_Dialog_PetLeader_All:ClearUpdateLuaFunc()
end
function PaGlobal_DialogPetLeader_All:upgradeComplete()
  if nil == Panel_Dialog_PetLeader_All then
    return
  end
  self._ui.stc_PetSlotEmpty:SetShow(true)
  self._ui.stc_PetSlot:ChangeTextureInfoNameAsync("")
  self._ui_pc.btn_Training:SetEnable(false)
  self._ui_pc.btn_Training:SetMonoTone(true)
  self._ui_pc.btn_Training:SetIgnore(true)
  local upgradeItemKey = ToClient_getPetUpgradeItem(3)
  local itemWrapper = getItemEnchantStaticStatus(upgradeItemKey)
  if nil ~= itemWrapper then
    self._ui.stc_ItemSlot:ChangeTextureInfoNameAsync("Icon/" .. itemWrapper:getIconPath())
    self._ui.stc_ItemSlot:SetMonoTone(true)
    self._ui.stc_ItemSlot:addInputEvent("Mouse_On", "HandleEventOnOut_DialogPetLeader_All_ItemTooltip(true" .. "," .. tostring(upgradeItemKey:getItemKey()) .. ")")
    self._ui.stc_ItemSlot:addInputEvent("Mouse_Out", "HandleEventOnOut_DialogPetLeader_All_ItemTooltip(false" .. "," .. tostring(upgradeItemKey:getItemKey()) .. ")")
  end
  self._ui_pc.btn_Training:addInputEvent("Mouse_LUp", "")
  Panel_Dialog_PetLeader_List_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
  self._upgradeSealIndex = nil
  self._upgradeInvenSlotNo = nil
  self._isUpgradeStart = false
  Panel_Dialog_PetLeader_All:ClearUpdateLuaFunc()
end
