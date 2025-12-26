function SkillGroupQuickSlot_DropHandler(slotIndex)
  if false == isUseNewQuickSlot() then
    QuickSlot_DropHandler(slotIndex)
  else
    HandleClicked_NewQuickSlot_Use(slotIndex)
  end
end
function SkillGroupQuickSlot_Click(slotIndex)
  if false == isUseNewQuickSlot() then
    QuickSlot_Click(slotIndex)
  else
    HandleClicked_NewQuickSlot_Use(slotIndex)
  end
end
function SkillGroupQuickSlot_DragStart(slotIndex)
  local quickSlotInfo = getQuickSlotItem(slotIndex)
  if PaGlobal_TutorialManager ~= nil and true == PaGlobal_TutorialManager:isDoingTutorial() and 502 == quickSlotInfo._itemKey:get() and 0 == slotIndex then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_GLOBALKEYBINDER_TUTORIALALERT"))
    return
  end
  if CppEnums.QuickSlotType.eItem == quickSlotInfo._type or CppEnums.QuickSlotType.eCashItem == quickSlotInfo._type or CppEnums.QuickSlotType.eInstanceItem == quickSlotInfo._type then
    local itemStaticWrapper = getItemEnchantStaticStatus(quickSlotInfo._itemKey)
    DragManager:setDragInfo(Panel_Window_SkillGroup_QuickSlot, nil, slotIndex, "Icon/" .. itemStaticWrapper:getIconPath(), QuickSlot_GroundClick, nil)
  elseif CppEnums.QuickSlotType.eSkill == quickSlotInfo._type then
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(quickSlotInfo._skillKey:getSkillNo())
    DragManager:setDragInfo(Panel_Window_SkillGroup_QuickSlot, nil, slotIndex, "Icon/" .. skillTypeStaticWrapper:getIconPath(), QuickSlot_GroundClick, nil)
  elseif CppEnums.QuickSlotType.eSocialAction == quickSlotInfo._type then
    local socialActionKeyFromCpp = quickSlotInfo._socialActionKey:get()
    local sASS = ToClient_getSocialActionStaticStatusByKey(socialActionKeyFromCpp)
    if nil == sASS then
      _PA_ASSERT_NAME(false, "socialActionInfo\236\157\152 StaticStatus\235\165\188 \234\176\128\236\160\184\236\152\164\235\138\148\235\141\176 \236\139\164\237\140\168\237\149\152\236\152\128\236\138\181\235\139\136\235\139\164.", "\236\160\149\236\152\129\236\164\128")
      return
    end
    local iconPath = sASS:getIconPath()
    if nil ~= iconPath then
      iconPath = "Icon/" .. iconPath
    end
    DragManager:setDragInfo(Panel_Window_SkillGroup_QuickSlot, nil, slotIndex, iconPath, QuickSlot_GroundClick, nil)
  end
end
function PaGlobal_SkillGroup_QuickSlot_Resize()
  self = PaGlobal_SkillGroup_QuickSlot
  panel = Panel_Window_SkillGroup_QuickSlot
  panel:ComputePos()
  local screenSizeY = getScreenSizeY()
  panel:SetPosX(Panel_Window_SkillGroup_Controller:GetPosX() + Panel_Window_SkillGroup_Controller:GetSizeX() / 2 - panel:GetSizeX() / 2)
  panel:SetPosY(screenSizeY - panel:GetSizeY() - 20)
  for ii = 0, self._config.slotCount - 1 do
    self._slots[ii].number:SetText((keyCustom_GetString_ActionKey(PaGlobal_SkillGroup_QuickSlot.slotKey[ii])))
  end
  if false == isUseNewQuickSlot() then
    local slotBg = UI.getChildControl(panel, "Static_SlotBG")
    local slotSizeY = slotBg:GetSizeY()
    panel:SetPosY(panel:GetPosY() + slotSizeY)
    local posY = slotBg:GetPosY() + slotSizeY + 10
    self._ui._stc_bottomLine:SetPosY(posY)
    for ii = self._config.oldSlotCount, self._config.slotCount - 1 do
      self._slots[ii].groupBg:SetShow(false)
    end
  else
    local slotBg = UI.getChildControl(panel, "Static_SlotBG")
    local slotSizeY = slotBg:GetSizeY()
    local posY = slotBg:GetPosY() + slotSizeY * 2 + 30
    self._ui._stc_bottomLine:SetPosY(posY)
    for ii = self._config.oldSlotCount, self._config.slotCount - 1 do
      self._slots[ii].groupBg:SetShow(true)
    end
  end
end
