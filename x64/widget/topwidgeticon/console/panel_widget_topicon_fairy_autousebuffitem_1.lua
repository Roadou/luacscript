function PaGlobal_TopIcon_AutoUseBuffItem:initialize()
  if self._initialize == true then
    return
  end
  self:initControl()
  self:validate()
  self:registEventHandler()
  local isShow = ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleServantIcon, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow)
  if isShow ~= 0 and 0 < ToClient_getFairyUnsealedList() + ToClient_getFairySealedList() then
    Panel_Widget_FairyAutoUseBuffItemIcon_Renew:SetShow(true)
    PaGlobalFunc_TopIcon_UpdatePos()
  end
  self:changeToggleState(nil)
  self:changeSkillState(nil)
  self:onScreenResize()
  self._initialize = true
end
function PaGlobal_TopIcon_AutoUseBuffItem:initControl()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  self._ui.stc_Icon = UI.getChildControl(Panel_Widget_FairyAutoUseBuffItemIcon_Renew, "Static_AutoUseBuffItemIcon_Template")
  self._ui.stc_nextUseItemParent = UI.getChildControl(Panel_Widget_FairyAutoUseBuffItemIcon_Renew, "Static_NextUseItem_Bubble")
  self._ui.stc_nextUseItemSlotBg = UI.getChildControl(self._ui.stc_nextUseItemParent, "Static_ItemSlot")
  self._ui.stc_nextUseItemProgress = UI.getChildControl(self._ui.stc_nextUseItemParent, "CircularProgress_1")
  local autoUseItemSlot = {}
  SlotItem.new(autoUseItemSlot, "Icon_AutoUse_", 0, self._ui.stc_nextUseItemSlotBg, self._slotConfig)
  autoUseItemSlot:createChild()
  autoUseItemSlot.icon:SetPosX(0)
  autoUseItemSlot.icon:SetPosY(0)
  autoUseItemSlot.icon:SetSize(32, 32)
end
function PaGlobal_TopIcon_AutoUseBuffItem:validate()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  self._ui.stc_Icon:isValidate()
end
function PaGlobal_TopIcon_AutoUseBuffItem:registEventHandler()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  registerEvent("onScreenResize", "FromClient_TopIcon_AutoUseBuff_Resize")
  registerEvent("FromClient_StartAutoUseBuffItemTimer", "FromClient_TopIcon_AutoUseBuff_StartAutoUseBuffItemTimer")
  registerEvent("FromClient_UpdateAutoUseModeToggleState", "FromClient_TopIcon_AutoUseBuff_ChangeToggleState")
  registerEvent("FromClient_ChangedLearnedFairyAutoUseBuffSkill", "FromClient_TopIcon_AutoUseBuff_ChangeSkillState")
end
function PaGlobal_TopIcon_AutoUseBuffItem:prepareOpen()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  self:open()
end
function PaGlobal_TopIcon_AutoUseBuffItem:open()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  Panel_Widget_FairyAutoUseBuffItemIcon_Renew:RegisterUpdateFunc("FromClient_TopIcon_AutoUseBuff_DeltaUpdate")
  PaGlobalFunc_TopIcon_Show(TopWidgetIconType.AutoUseBuffItem)
end
function PaGlobal_TopIcon_AutoUseBuffItem:prepareClose()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  self:close()
end
function PaGlobal_TopIcon_AutoUseBuffItem:close()
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  Panel_Widget_FairyAutoUseBuffItemIcon_Renew:ClearUpdateLuaFunc()
  PaGlobalFunc_TopIcon_Exit(TopWidgetIconType.AutoUseBuffItem)
end
function PaGlobal_TopIcon_AutoUseBuffItem:onScreenResize()
  local panel = Panel_Widget_FairyAutoUseBuffItemIcon_Renew
  if panel == nil then
    return
  end
  local posY = Panel_SelfPlayerExpGage:GetPosY() + Panel_SelfPlayerExpGage:GetSizeY() + 4
  panel:SetPosY(posY)
end
function PaGlobal_TopIcon_AutoUseBuffItem:changeToggleState(isOn)
  local panel = Panel_Widget_FairyAutoUseBuffItemIcon_Renew
  if panel == nil then
    return
  end
  local isModeOn = isOn
  if isModeOn == nil then
    isModeOn = ToClient_getCurrentAutoUseModeToggleState()
  end
  self._ui.stc_Icon:EraseAllEffect()
  if isModeOn == true then
    if panel:GetShow() == false then
      self:prepareOpen()
    end
    self._ui.stc_Icon:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Icon, 261, 53, 312, 104)
    self._ui.stc_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Icon:setRenderTexture(self._ui.stc_Icon:getBaseTexture())
    self._ui.stc_Icon:AddEffect("fui_ingame_widget_autouse_01a", true, 0, 0)
  else
    self._ui.stc_Icon:ChangeTextureInfoNameAsync("Renewal/Button/Console_Btn_Main_01.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(self._ui.stc_Icon, 261, 1, 312, 52)
    self._ui.stc_Icon:getBaseTexture():setUV(x1, y1, x2, y2)
    self._ui.stc_Icon:setRenderTexture(self._ui.stc_Icon:getBaseTexture())
    self:changeSkillState(nil)
  end
  PaGlobalFunc_TopIcon_UpdatePos()
end
function PaGlobal_TopIcon_AutoUseBuffItem:changeSkillState(isLearned)
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil then
    return
  end
  if PaGlobal_FairyInfo_All == nil then
    UI.ASSERT_NAME(false, "\236\178\152\235\166\172\234\176\128 \237\149\132\236\154\148\237\149\169\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local isLearnedSkill = isLearned
  if isLearnedSkill == nil then
    PaGlobal_FairyInfo_All:update()
    isLearnedSkill = ToClient_isLearnedFairySkill()
  end
  if isLearnedSkill == true then
    if panel:GetShow() == false then
      self:prepareOpen()
    end
  else
    self:prepareClose()
  end
  PaGlobalFunc_TopIcon_UpdatePos()
end
function PaGlobal_TopIcon_AutoUseBuffItem:startAutoUseItemTimer(usableItemKeyRaw)
  local panel = Panel_Widget_FairyAutoUseBuffItemIcon_Renew
  if panel == nil then
    return
  end
  if usableItemKeyRaw == nil then
    UI.ASSERT_NAME(false, "\236\158\144\235\143\153 \236\130\172\236\154\169 \235\140\128\236\131\129 \236\149\132\236\157\180\237\133\156 Key\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!!! \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!!!!", "\236\157\180\236\163\188")
    return
  end
  local itemEnchantKey = ItemEnchantKey(usableItemKeyRaw, 0)
  local itemSSW = getItemEnchantStaticStatus(itemEnchantKey)
  if itemSSW == nil then
    UI.ASSERT_NAME(false, "\236\158\144\235\143\153 \236\130\172\236\154\169 \235\140\128\236\131\129 ItemSSW\234\176\128 \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164!!! \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180 \235\182\128\237\131\129\235\147\156\235\166\189\235\139\136\235\139\164!!!!", "\236\157\180\236\163\188")
    return
  end
  if panel:GetShow() == false and ToClient_getCurrentAutoUseModeToggleState() == true and ToClient_isLearnedFairySkill() == true and ToClient_isOnAutoUseItemUpdateFuncFlag() == false then
    ToClient_setUseAutoUseItemUpdateFunc()
    return
  end
  if self._ui.stc_nextUseItemParent:GetShow() == true then
    return
  end
  self._ui.stc_nextUseItemParent:SetShow(true)
  self._autoUseBuffItem_ExpireTime = self._autoUseBuffItem_UseItemTermTime
  local autoUseBtnCenterPosX = self._ui.stc_Icon:GetPosX() + self._ui.stc_Icon:GetSizeX() / 2
  local autoUseBtnPosY = self._ui.stc_Icon:GetPosY()
  self._ui.stc_nextUseItemParent:SetPosX(autoUseBtnCenterPosX - self._ui.stc_nextUseItemParent:GetSizeX() / 2)
  self._ui.stc_nextUseItemParent:SetPosY(autoUseBtnPosY + self._ui.stc_nextUseItemParent:GetSizeY() + 10)
  local autoUseItemSlot = {}
  SlotItem.reInclude(autoUseItemSlot, "Icon_AutoUse_", 0, self._ui.stc_nextUseItemSlotBg, self._slotConfig)
  autoUseItemSlot:clearItem()
  autoUseItemSlot:setItemByStaticStatus(itemSSW)
  autoUseItemSlot.icon:addInputEvent("Mouse_On", "")
  autoUseItemSlot.icon:addInputEvent("Mouse_Out", "")
  self._ui.stc_nextUseItemProgress:SetProgressRate(100)
end
function PaGlobal_TopIcon_AutoUseBuffItem:update(deltaTime)
  if Panel_Widget_FairyAutoUseBuffItemIcon_Renew == nil or _ContentsGroup_OneButtonBuff == false then
    return
  end
  local isActivateAutoUseBuffItem = ToClient_getCurrentAutoUseModeToggleState()
  if isActivateAutoUseBuffItem == false or ToClient_isLearnedFairySkill() == false then
    if self._ui.stc_nextUseItemParent:GetShow() == true then
      self._ui.stc_nextUseItemParent:SetShow(false)
    end
    return
  end
  if self._ui.stc_nextUseItemParent:GetShow() == false then
    return
  end
  self._autoUseBuffItem_ExpireTime = self._autoUseBuffItem_ExpireTime - deltaTime
  local expireTimeRatio = self._autoUseBuffItem_ExpireTime / self._autoUseBuffItem_UseItemTermTime
  self._ui.stc_nextUseItemProgress:SetProgressRate(expireTimeRatio * 100)
  if self._autoUseBuffItem_ExpireTime < 0 then
    self._ui.stc_nextUseItemParent:SetShow(false)
    ToClient_setUseAutoUseItemUpdateFunc()
  end
end
