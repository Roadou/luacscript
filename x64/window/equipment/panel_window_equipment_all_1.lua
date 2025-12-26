function PaGlobal_Equipment_All:initialize()
  if nil == Panel_Window_Equipment_All or true == PaGlobal_Equipment_All._initialize then
    return
  end
  PaGlobal_Equipment_All:controlInit()
  PaGlobal_Equipment_All:setData()
  PaGlobal_Equipment_All:setSlot()
  PaGlobal_Equipment_All:registerEventHandler()
  PaGlobal_Equipment_All:validate()
  PaGlobal_Equipment_All._initialize = true
end
function PaGlobal_Equipment_All:controlInit()
  self._ui.txt_titleBG = UI.getChildControl(Panel_Window_Equipment_All, "StaticText_Title")
  self._ui.check_popup = UI.getChildControl(self._ui.txt_titleBG, "CheckButton_PopUp")
  self._ui.btn_question = UI.getChildControl(self._ui.txt_titleBG, "Button_Question")
  self._ui.btn_close = UI.getChildControl(self._ui.txt_titleBG, "Button_Close")
  self._ui.stc_circle = UI.getChildControl(Panel_Window_Equipment_All, "Static_MainCircle_1")
  self._ui.stc_circle:SetShow(true)
  self._ui.stc_abilityArea = UI.getChildControl(self._ui.stc_circle, "Static_AbilityArea")
  local stc_notationAbilityBg = UI.getChildControl(self._ui.stc_abilityArea, "Static_NotationAbilityBg")
  self._ui.chk_detailInfo = UI.getChildControl(stc_notationAbilityBg, "CheckButton_DetailInfo")
  self._ui.btn_notationSetting = UI.getChildControl(stc_notationAbilityBg, "Button_NotationAbilitySetting")
  stc_notationAbilityBg:SetShow(_ContentsGroup_RenewCharacterStatusViewMode == true)
  self._ui.txt_attackText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack")
  self._ui.txt_attackValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Attack_Value")
  self._ui.txt_defenceText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence")
  self._ui.txt_defenceValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_Defence_Value")
  self._ui.txt_awakenText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack")
  self._ui.txt_awakenValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_AwakenAttack_Value")
  self._ui.txt_shyStatText = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Title")
  self._ui.txt_shyStatValue = UI.getChildControl(self._ui.stc_abilityArea, "StaticText_ShyStat1_Value")
  self._ui.stc_bottomButtonArea = UI.getChildControl(Panel_Window_Equipment_All, "Static_BottomButtonArea")
  self._ui.btn_servantInven = UI.getChildControl(self._ui.stc_bottomButtonArea, "Button_ServantInventory")
  self._ui.check_camouflage = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_ShowNameWhenCamouflage")
  self._ui.check_underwear = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_Underwear_Invisual")
  self._ui.btn_petList = UI.getChildControl(self._ui.stc_bottomButtonArea, "Button_PetInfo")
  self._ui.check_helmInvisual = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_Helm_Invisual")
  self._ui.check_helmOpen = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_HelmOpen")
  self._ui.check_cloak = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_Cloak_Invisual")
  self._ui.check_subWeapon = UI.getChildControl(self._ui.stc_bottomButtonArea, "CheckButton_SubWeapon_Invisual")
  self._ui.btn_myStat = UI.getChildControl(Panel_Window_Equipment_All, "Button_MyStat")
  self._ui.stc_helmInvisualIcon = UI.getChildControl(self._ui.check_helmInvisual, "Static_Icon")
  self._ui.stc_helmOpenIcon = UI.getChildControl(self._ui.check_helmOpen, "Static_Icon")
  self._ui.btn_setEffect = UI.getChildControl(Panel_Window_Equipment_All, "Button_SetEffect")
  self._ui.btn_equipCrystal = UI.getChildControl(Panel_Window_Equipment_All, "Button_EquipCrystal")
  self._ui.btn_artifactOption = UI.getChildControl(Panel_Window_Equipment_All, "Button_Artifacts_Option")
  self._ui.stc_seasonBannerPass = UI.getChildControl(Panel_Window_Equipment_All, "Static_SeasonBanner")
  self._ui.stc_seasonBannerReward = UI.getChildControl(Panel_Window_Equipment_All, "Static_RewardList")
  self._ui.stc_seasonBannerUpgrade = UI.getChildControl(Panel_Window_Equipment_All, "Button_Season_Upgrade")
  self._ui.stc_sword = UI.getChildControl(self._ui.stc_seasonBannerUpgrade, "Static_Sword_Normal")
  self._ui.check_alchemyStone = UI.getChildControl(self._ui.stc_circle, "CheckBox_AlchemyStone")
  self._ui.txt_alchemyStoneQuickKey = UI.getChildControl(self._ui.stc_circle, "Static_Slot_AlchemyStone_Key")
  self._ui.rdo_stanceCombat = UI.getChildControl(Panel_Window_Equipment_All, "RadioButton_StanceCombat")
  self._ui.rdo_stanceFishing = UI.getChildControl(Panel_Window_Equipment_All, "RadioButton_StanceFishing")
  self._ui.rdo_stanceJaksal = UI.getChildControl(Panel_Window_Equipment_All, "RadioButton_StanceJaksal")
  self._ui.txt_stance = UI.getChildControl(Panel_Window_Equipment_All, "StaticText_Stance")
  self._ui.tooltipTemplate = UI.getChildControl(Panel_Window_Equipment_All, "StaticText_Notice_1")
  self._ui.txt_blankSlotTooltip = UI.createControl(__ePAUIControl_StaticText, Panel_Window_Equipment_All, "toolTip_BlankSlot_For_Equipment")
  CopyBaseProperty(self._ui.tooltipTemplate, self._ui.txt_blankSlotTooltip)
  self._ui.stc_blackSpiritBackImage = UI.getChildControl(Panel_Window_Equipment_All, "Static_BlackSpiritBackImage")
  self._ui.stc_imageWalk = UI.getChildControl(Panel_Window_Equipment_All, "Static_Walk")
  self._ui.stc_imageGo = UI.getChildControl(Panel_Window_Equipment_All, "Static_Go")
  self._ui.btn_newbieBag = UI.getChildControl(Panel_Window_Equipment_All, "Button_NewbieBag")
  self._ui.btn_Combat = UI.getChildControl(Panel_Window_Equipment_All, "RadioButton_Combat")
  self._ui.btn_Life = UI.getChildControl(Panel_Window_Equipment_All, "RadioButton_Life")
  self._ui.btn_Combat:SetShow(true)
  self._ui.btn_Life:SetShow(ToClient_HardCoreChannelWithContensOption() == false)
  self._ui.stc_LifeEquipBg = UI.getChildControl(Panel_Window_Equipment_All, "Static_LifeEquipBg")
  self._ui.stc_LifeEquipBg:SetShow(false)
  local frame = UI.getChildControl(self._ui.stc_LifeEquipBg, "Frame_Detail")
  local frameContent = UI.getChildControl(frame, "Frame_1_Content")
  local verticalScroll = UI.getChildControl(frame, "Frame_1_VerticalScroll")
  self._ui.txt_LifeDesc = UI.getChildControl(frameContent, "StaticText_Desc")
  self._ui.txt_LifeDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_LifeDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_LIFE_EQUIP_SLOT_DESC"))
  local textSizeY = self._ui.txt_LifeDesc:GetTextSizeY() + 10
  self._ui.txt_LifeDesc:SetSize(self._ui.txt_LifeDesc:GetSizeX(), math.max(textSizeY, 115))
  frameContent:SetSize(frameContent:GetSizeX(), math.max(textSizeY, 115))
  self._ui.txt_LifeDesc:ComputePos()
  frame:UpdateContentScroll()
  frame:UpdateContentPos()
  UIScroll.SetButtonSize(verticalScroll, frame:GetSizeY(), self._ui.txt_LifeDesc:GetTextSizeY() + 10)
  verticalScroll:SetControlPos(0)
  self._ui.stc_accessoryStepUpBanner = UI.getChildControl(Panel_Window_Equipment_All, "Button_EquipUpgradeBanner")
end
function PaGlobal_Equipment_All:checkUsableSlot(index)
  if index == self._UnUsedEquipNo_01 or index == self._UnUsedEquipNo_02 or index == __eEquipSlotNoCount or index == __eEquipSlotNoExplorationBonus0 or index == __eEquipSlotNoInstallation4 or index == __eEquipSlotNoBody or index == __eEquipSlotNoAvatarBody or index == __eEquipSlotNoHuntRifle or index == __eEquipSlotNoSniperRifle then
    return false
  end
  if false == _ContentsGroup_ArtifactItem and (index == __eEquipSlotNoArtifact1 or index == __eEquipSlotNoArtifact2) then
    return false
  end
  return true
end
function PaGlobal_Equipment_All:setSlot()
  if nil == getSelfPlayer() then
    return
  end
  local classType = getSelfPlayer():getClassType()
  for slotNo = self._EquipNoMin, self._EquipNoMax do
    if true == PaGlobal_Equipment_All:checkUsableSlot(slotNo) then
      local parentControl
      if slotNo > __eEquipSlotNoArtifact2 and slotNo < __eEquipSlotNoHuntRifle then
        parentControl = self._ui.stc_LifeEquipBg
      else
        parentControl = self._ui.stc_circle
      end
      local slotBG = UI.getChildControl(parentControl, self._slotNoId[slotNo] .. "_BG")
      slotBG:SetShow(false)
      self.slotBGs[slotNo] = slotBG
      if slotNo == __eEquipSlotNoRightHand or slotNo == __eEquipSlotNoLeftHand or slotNo == __eEquipSlotNoAwakenWeapon then
        local effectControl = UI.getChildControl(parentControl, self._slotNoId[slotNo] .. "_EffectCheck")
        if effectControl ~= nil then
          if _ContentsGroup_ItemSkillOption == true then
            self.effectCtrl[slotNo] = effectControl
            self.effectCtrl[slotNo]:SetCheck(false)
            self.effectCtrl[slotNo]:addInputEvent("Mouse_LUp", "PaGlobalFunc_Equipment_All_ToggleEffectSwitch(" .. slotNo .. ")")
          else
            effectControl:SetShow(false)
          end
        end
      end
      local whereType = Inventory_GetCurrentInventoryType()
      if true == ToClient_EquipSlot_CheckItemLock(slotNo, whereType) then
        ToClient_Inventory_RemoveItemLock(slotNo, whereType)
      end
      if __eEquipSlotNoAwakenWeapon == slotNo then
        if __eClassType_ShyWaman == classType then
          self.slotBGs[slotNo]:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 283, 48, 329, 94)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        else
          self.slotBGs[slotNo]:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 95, 1, 141, 47)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        end
      end
      if __eEquipSlotNoAvatarAwakenWeapon == slotNo then
        if __eClassType_ShyWaman == classType then
          self.slotBGs[slotNo]:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 330, 48, 376, 94)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        else
          self.slotBGs[slotNo]:ChangeTextureInfoNameAsync("combine/icon/combine_equip_icon_00.dds")
          local x1, y1, x2, y2 = setTextureUV_Func(self.slotBGs[slotNo], 95, 95, 141, 141)
          self.slotBGs[slotNo]:getBaseTexture():setUV(x1, y1, x2, y2)
          self.slotBGs[slotNo]:setRenderTexture(self.slotBGs[slotNo]:getBaseTexture())
        end
      end
      local slot = {}
      slot.icon = UI.getChildControl(parentControl, self._slotNoId[slotNo])
      SlotItem.new(slot, "Equipment_" .. slotNo, slotNo, Panel_Equipment, self._slotConfig)
      slot:createChild()
      slot.icon:addInputEvent("Mouse_RUp", "HandleEventRUp_Equipment_All_EquipSlotRClick(" .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_EquipSlotLClick(" .. slotNo .. ")")
      slot.icon:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_EquipmentTooltip(" .. slotNo .. ",true)")
      slot.icon:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_EquipmentTooltip(" .. slotNo .. ",false)")
      Panel_Tooltip_Item_SetPosition(slotNo, slot, "equipment")
      self.slots[slotNo] = slot
      if slotNo == __eEquipSlotNoTemp and _ContentsGroup_TempXXX == false then
        self.slotBGs[slotNo]:SetShow(false)
        self.slots[slotNo].icon:SetShow(false)
      end
      if nil ~= self._avataEquipSlotId[slotNo] then
        self.avataSlots[slotNo] = UI.getChildControl(self._ui.stc_circle, self._avataEquipSlotId[slotNo])
        self.avataSlots[slotNo]:SetShow(true)
        self.avataSlots[slotNo]:SetPosX(slot.icon:GetPosX() + slot.icon:GetSizeX() - 15)
        self.avataSlots[slotNo]:SetPosY(slot.icon:GetPosY() + slot.icon:GetSizeY() - 15)
        self.avataSlots[slotNo]:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_AvatarShowToggle(" .. slotNo .. ")")
        if slotNo <= __eEquipSlotNoAvatarUnderwear or __eEquipSlotNoAvatarAwakenWeapon == slotNo then
          self.avataSlots[slotNo]:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( true, 0, " .. slotNo .. " )")
          self.avataSlots[slotNo]:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( false, 0, " .. slotNo .. " )")
        elseif slotNo == __eEquipSlotNoTemp then
          self.avataSlots[slotNo]:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( true, 2, " .. slotNo .. " )")
          self.avataSlots[slotNo]:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( false, 2, " .. slotNo .. " )")
        else
          self.avataSlots[slotNo]:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( true, 1, " .. slotNo .. " )")
          self.avataSlots[slotNo]:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_CostumeAccToolTip( false, 1, " .. slotNo .. " )")
        end
        if __eEquipSlotNoAvatarAwakenWeapon == slotNo then
          if __eClassType_ShyWaman == classType then
            self.avataSlots[slotNo]:SetShow(false)
          else
            self.avataSlots[slotNo]:SetShow(self._awakenWeaponContentsOpen)
          end
        end
      end
    end
  end
  if __eClassType_ShyWaman == classType or false == self._awakenWeaponContentsOpen then
    local underwearSlot = __eEquipSlotNoAvatarUnderwear
    local spanX = 0
    local spanY = self.slotBGs[underwearSlot]:GetSpanSize().y
    if nil ~= self.slotBGs[underwearSlot] then
      self.slotBGs[underwearSlot]:SetSpanSize(spanX, spanY)
      self.slotBGs[underwearSlot]:ComputePos()
    end
    if nil ~= self.slots[underwearSlot] then
      self.slots[underwearSlot].icon:SetSpanSize(spanX, spanY)
      self.slots[underwearSlot].icon:ComputePos()
    end
    if nil ~= self.avataSlots[underwearSlot] then
      local slotIcon = self.slots[underwearSlot].icon
      self.avataSlots[underwearSlot]:SetPosX(slotIcon:GetPosX() + slotIcon:GetSizeX() - 15)
      self.avataSlots[underwearSlot]:SetPosY(slotIcon:GetPosY() + slotIcon:GetSizeY() - 15)
    end
  end
  if true == _ContentsGroup_ArtifactItem then
    local txt_subTitle = UI.getChildControl(self._ui.stc_circle, "Static_Text_SubTitle")
    txt_subTitle:SetSpanSize(txt_subTitle:GetSpanSize().x, txt_subTitle:GetSpanSize().y + 20)
    txt_subTitle:ComputePos()
  else
    local slot1 = UI.getChildControl(self._ui.stc_circle, self._slotNoId[__eEquipSlotNoArtifact1])
    local slot2 = UI.getChildControl(self._ui.stc_circle, self._slotNoId[__eEquipSlotNoArtifact2])
    local slotBG1 = UI.getChildControl(self._ui.stc_circle, self._slotNoId[__eEquipSlotNoArtifact1] .. "_BG")
    local slotBG2 = UI.getChildControl(self._ui.stc_circle, self._slotNoId[__eEquipSlotNoArtifact2] .. "_BG")
    slot1:SetShow(false)
    slot2:SetShow(false)
    slotBG1:SetShow(false)
    slotBG2:SetShow(false)
  end
  self._ui.check_alchemyStone:SetSpanSize(self._ui.check_alchemyStone:GetSpanSize().x, self._ui.check_alchemyStone:GetSpanSize().y + 30)
  self._ui.check_alchemyStone:ComputePos()
  self._ui.txt_alchemyStoneQuickKey:SetSpanSize(self._ui.txt_alchemyStoneQuickKey:GetSpanSize().x, self._ui.txt_alchemyStoneQuickKey:GetSpanSize().y + 30)
  self._ui.txt_alchemyStoneQuickKey:ComputePos()
  if self._ui.stc_circle ~= nil then
    local childCount = self._ui.stc_circle:getChildControlCount()
    for childIdx = 0, childCount - 1 do
      local child = UI.getChildControlByIndex(self._ui.stc_circle, childIdx)
      if child ~= nil then
        local childsChildCound = child:getChildControlCount()
        if childsChildCound > 0 then
          local plusControl = UI.getChildControlNoneAssert(child, "Static_PlusClick")
          if plusControl ~= nil then
            plusControl:SetShow(not _ContentsGroup_ChinaOnly)
          end
        end
      end
    end
  end
  if self._ui.stc_LifeEquipBg ~= nil then
    local childCount = self._ui.stc_LifeEquipBg:getChildControlCount()
    for childIdx = 0, childCount - 1 do
      local child = UI.getChildControlByIndex(self._ui.stc_LifeEquipBg, childIdx)
      if child ~= nil then
        local childsChildCound = child:getChildControlCount()
        if childsChildCound > 0 then
          local plusControl = UI.getChildControlNoneAssert(child, "Static_PlusClick")
          if plusControl ~= nil then
            plusControl:SetShow(false)
          end
        end
      end
    end
  end
  self._ui.btn_Combat:SetCheck(true)
end
function PaGlobal_Equipment_All:setData()
  self._isAlchemyStoneCheck = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eAlchemyStone)
  local isSolare = ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_Solare)
  if true == isSolare then
    self._isAlchemyStoneCheck = true
  end
  local classType = getSelfPlayer():getClassType()
  self._awakenWeaponContentsOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(classType)
  if nil == self._awakenWeaponContentsOpen then
    self._awakenWeaponContentsOpen = false
  end
  self._ui.check_popup:SetShow(_ContentsGroup_PopUp)
  self._ui.txt_attackText:SetEnableArea(0, 0, self._ui.txt_attackText:GetTextSizeX() + 30, self._ui.txt_attackText:GetSizeY())
  self._ui.txt_defenceText:SetEnableArea(0, 0, self._ui.txt_defenceText:GetTextSizeX() + 30, self._ui.txt_defenceText:GetSizeY())
  self._ui.txt_awakenText:SetEnableArea(0, 0, self._ui.txt_awakenText:GetTextSizeX() + 30, self._ui.txt_awakenText:GetSizeY())
  self._ui.txt_shyStatText:SetEnableArea(0, 0, self._ui.txt_shyStatText:GetTextSizeX() + 30, self._ui.txt_shyStatText:GetSizeY())
  if false == ToClient_isAdultUser() then
    self._ui.check_underwear:SetShow(false)
  else
    self._ui.check_underwear:SetShow(true)
  end
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) then
    self._ui.check_underwear:SetShow(false)
  end
  self._ui.btn_petList:SetShow(true)
  self._ui.check_camouflage:SetShow(true)
  self._ui.check_helmInvisual:SetShow(true)
  self._ui.check_helmOpen:SetShow(true)
  self._ui.check_cloak:SetShow(true)
  self._ui.check_subWeapon:SetShow(true)
  getSelfPlayer():get():setUnderwearModeInhouse(false)
  getSelfPlayer():get():setSwimmingSuitMode(false)
  self._ui.check_underwear:SetCheck(false)
  self._ui.check_camouflage:SetCheck(Toclient_setShowNameWhenCamouflage())
  selfPlayerShowHelmet(ToClient_IsShowHelm())
  selfPlayerShowBattleHelmet(ToClient_IsShowBattleHelm())
  self._ui.check_helmInvisual:SetCheck(not ToClient_IsShowHelm())
  self._ui.check_helmOpen:SetCheck(ToClient_IsShowBattleHelm())
  self._ui.check_cloak:SetCheck(not ToClient_IsShowCloak())
  PaGlobal_Equipment_All:updateHelmIcon()
  self._ui.check_alchemyStone:SetCheck(self._isAlchemyStoneCheck)
  local initSucceed = PaGlobal_EquipmentTooltip:initWithIcon(self._ui.btn_setEffect)
  self._ui.btn_setEffect:SetShow(initSucceed)
  self._ui.btn_setEffect:SetIgnore(not initSucceed)
  initSucceed = PaGlobalFunc_CrystalToolTip_InitWithIcon(self._ui.btn_equipCrystal)
  self._ui.btn_equipCrystal:SetShow(initSucceed)
  self._ui.btn_equipCrystal:SetIgnore(not initSucceed)
  if true == _ContentsGroup_ArtifactItem then
    initSucceed = PaGlobalFunc_ArtifactsToolTip_InitWithIcon(self._ui.btn_artifactOption)
    self._ui.btn_artifactOption:SetShow(initSucceed)
    self._ui.btn_artifactOption:SetIgnore(not initSucceed)
  else
    self._ui.btn_artifactOption:SetShow(false)
  end
  local isShowSubWeapon = ToClient_IsShowSubWeapon()
  selfPlayerShowSubWeapon(isShowSubWeapon)
  self._ui.check_subWeapon:SetCheck(not isShowSubWeapon)
  self._ui.txt_blankSlotTooltip:SetColor(Defines.Color.C_FFFFFFFF)
  self._ui.txt_blankSlotTooltip:SetAlpha(1)
  self._ui.txt_blankSlotTooltip:SetFontColor(Defines.Color.C_FFC4BEBE)
  self._ui.txt_blankSlotTooltip:SetTextHorizonCenter()
  self._ui.txt_blankSlotTooltip:SetShow(false)
  self._ui.txt_blankSlotTooltip:SetIgnore(true)
  if true == _ContentsGroup_ArtifactItem then
    local spanSizeY = 10
    self._ui.btn_servantInven:SetSpanSize(self._ui.btn_servantInven:GetSpanSize().x, spanSizeY)
    self._ui.check_camouflage:SetSpanSize(self._ui.check_camouflage:GetSpanSize().x, spanSizeY)
    self._ui.check_underwear:SetSpanSize(self._ui.check_underwear:GetSpanSize().x, spanSizeY)
    self._ui.btn_petList:SetSpanSize(self._ui.btn_petList:GetSpanSize().x, spanSizeY)
    self._ui.check_helmInvisual:SetSpanSize(self._ui.check_helmInvisual:GetSpanSize().x, spanSizeY)
    self._ui.check_helmOpen:SetSpanSize(self._ui.check_helmOpen:GetSpanSize().x, spanSizeY)
    self._ui.check_cloak:SetSpanSize(self._ui.check_cloak:GetSpanSize().x, spanSizeY)
    self._ui.check_subWeapon:SetSpanSize(self._ui.check_subWeapon:GetSpanSize().x, spanSizeY)
    self._ui.btn_myStat:SetSize(self._ui.btn_setEffect:GetSizeX(), self._ui.btn_myStat:GetSizeY())
    self._ui.btn_myStat:SetSpanSize(self._ui.btn_setEffect:GetSpanSize().x, self._ui.btn_myStat:GetSpanSize().y)
    self._ui.btn_myStat:SetShow(true)
  else
    local spanSizeY = 10
    self._ui.btn_servantInven:SetSpanSize(self._ui.btn_servantInven:GetSpanSize().x, spanSizeY)
    self._ui.check_camouflage:SetSpanSize(self._ui.check_camouflage:GetSpanSize().x, spanSizeY)
    self._ui.check_underwear:SetSpanSize(self._ui.check_underwear:GetSpanSize().x, spanSizeY)
    self._ui.btn_petList:SetSpanSize(self._ui.btn_petList:GetSpanSize().x, spanSizeY)
    self._ui.check_helmInvisual:SetSpanSize(self._ui.check_helmInvisual:GetSpanSize().x, spanSizeY)
    self._ui.check_helmOpen:SetSpanSize(self._ui.check_helmOpen:GetSpanSize().x, spanSizeY)
    self._ui.check_cloak:SetSpanSize(self._ui.check_cloak:GetSpanSize().x, spanSizeY)
    self._ui.check_subWeapon:SetSpanSize(self._ui.check_subWeapon:GetSpanSize().x, spanSizeY)
    self._ui.btn_myStat:SetShow(true)
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    self._ui.btn_myStat:SetIgnore(true)
    self._ui.btn_myStat:SetMonoTone(true)
  end
  local currentMode = ToClient_GetCurrentActionMode()
  self._ui.rdo_stanceCombat:SetCheck(currentMode == __eActionMode_Normal)
  self._ui.rdo_stanceFishing:SetCheck(currentMode == __eActionMode_FishingRod)
  self._ui.rdo_stanceJaksal:SetCheck(currentMode == __eActionMode_FishingHarpoon)
  if currentMode == __eActionMode_Normal then
    self._ui.txt_stance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_BASE"))
  elseif currentMode == __eActionMode_FishingRod then
    self._ui.txt_stance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_FISH"))
  elseif currentMode == __eActionMode_FishingHarpoon then
    self._ui.txt_stance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_JAKSAL"))
  else
    self._ui.txt_stance:SetText("")
  end
end
function PaGlobal_Equipment_All:registerEventHandler()
  if nil == Panel_Window_Equipment_All then
    return
  end
  Panel_Window_Equipment_All:RegisterUpdateFunc("PaGlobalFunc_Equipment_All_UpdatePerFrame")
  self._ui.check_popup:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_CheckPopupUI()")
  self._ui.check_popup:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_PopupUITooltip(true)")
  self._ui.check_popup:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_PopupUITooltip(false)")
  if true == _ContentsGroup_SeasonContents then
    self._ui.stc_seasonBannerPass:addInputEvent("Mouse_LUp", "PaGlobalFunc_SeasonPassAndRoadMap_OpenAndClose()")
    self._ui.stc_seasonBannerPass:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_BannerTooltip(true," .. self._bannerType.SEASONPASS .. ")")
    self._ui.stc_seasonBannerPass:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_BannerTooltip(false," .. self._bannerType.SEASONPASS .. ")")
  end
  self._ui.stc_seasonBannerReward:addInputEvent("Mouse_LUp", "PaGlobal_TotalReward_All_Open()")
  self._ui.stc_seasonBannerReward:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_BannerTooltip(true," .. self._bannerType.TOTALREWARD .. ")")
  self._ui.stc_seasonBannerReward:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_BannerTooltip(false," .. self._bannerType.TOTALREWARD .. ")")
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    self._ui.stc_seasonBannerUpgrade:addInputEvent("Mouse_LUp", "PaGlobal_SeasonEquipment_Upgrade_Open()")
    self._ui.stc_seasonBannerUpgrade:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_BannerTooltip(true," .. self._bannerType.SEASONUPGRADE .. ")")
    self._ui.stc_seasonBannerUpgrade:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_BannerTooltip(false," .. self._bannerType.SEASONUPGRADE .. ")")
  end
  if _ContentsGroup_AccessoryStepUp == true then
    self._ui.stc_accessoryStepUpBanner:addInputEvent("Mouse_LUp", "PaGlobal_Window_Accessory_StepUp_All_Open()")
    self._ui.stc_accessoryStepUpBanner:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_AccessoryStepUpTooltip(true)")
    self._ui.stc_accessoryStepUpBanner:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_AccessoryStepUpTooltip(false)")
  end
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"PanelWindowEquipment\" )")
  PaGlobal_Util_RegistHelpTooltipEvent(self._ui.btn_question, "\"PanelWindowEquipment\"")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_Equipment_All_Close(true)")
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    self._ui.chk_detailInfo:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ClickDetailInfo()")
    self._ui.chk_detailInfo:addInputEvent("Mouse_On", "HandleEventOnOff_Equipment_All_ClickDetailInfo(true)")
    self._ui.chk_detailInfo:addInputEvent("Mouse_Out", "HandleEventOnOff_Equipment_All_ClickDetailInfo(false)")
    self._ui.btn_notationSetting:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_NotationSetting()")
    self._ui.btn_notationSetting:addInputEvent("Mouse_On", "HandleEventOnOff_Equipment_All_NotationSetting(true)")
    self._ui.btn_notationSetting:addInputEvent("Mouse_Out", "HandleEventOnOff_Equipment_All_NotationSetting(false)")
    self._ui.btn_notationSetting:setButtonShortcutsWithEvent("HandleEventLUp_Equipment_All_NotationSetting()", "PANEL_NOTATION_ABILITY_TITLE")
  end
  self._ui.txt_attackText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 0)")
  self._ui.txt_attackText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.txt_defenceText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 1)")
  self._ui.txt_defenceText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.txt_awakenText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 2)")
  self._ui.txt_awakenText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.txt_shyStatText:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_StatTooltip(true, 3)")
  self._ui.txt_shyStatText:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_StatTooltip(false)")
  self._ui.btn_servantInven:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 0 )")
  self._ui.btn_servantInven:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 0 )")
  self._ui.btn_servantInven:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ServantInventoryOpen()")
  self._ui.check_camouflage:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 1 )")
  self._ui.check_camouflage:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 1 )")
  self._ui.check_camouflage:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowNameWhenCamouflage()")
  self._ui.check_underwear:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 2 )")
  self._ui.check_underwear:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 2 )")
  self._ui.check_underwear:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowUnderWear()")
  self._ui.btn_petList:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 3 )")
  self._ui.btn_petList:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 3 )")
  self._ui.btn_petList:addInputEvent("Mouse_LUp", "PaGlobal_PetList_Toggle_All()")
  self._ui.check_helmInvisual:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 4 )")
  self._ui.check_helmInvisual:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 4 )")
  self._ui.check_helmInvisual:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_HelmInvisual()")
  self._ui.check_helmOpen:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 5 )")
  self._ui.check_helmOpen:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 5 )")
  self._ui.check_helmOpen:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_HelmOpen()")
  self._ui.check_cloak:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( true, 6 )")
  self._ui.check_cloak:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip( false, 6 )")
  self._ui.check_cloak:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowCloak()")
  self._ui.check_subWeapon:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip(true, 7)")
  self._ui.check_subWeapon:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_ToggleButtonToolTip(false, 7)")
  self._ui.check_subWeapon:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ShowSubWeapon()")
  self._ui.check_alchemyStone:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_AlchemyStoneToolTip(true)")
  self._ui.check_alchemyStone:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_AlchemyStoneToolTip(false)")
  self._ui.check_alchemyStone:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_AlchemyStoneCheckEvent()")
  self._ui.btn_myStat:addInputEvent("Mouse_LUp", "PaGlobal_CharacterStatNew_Toggle()")
  self._ui.btn_newbieBag:addInputEvent("Mouse_LUp", "PaGlobalFunc_NewbieInventory_Open()")
  self._ui.btn_Combat:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ChangeMode(" .. tostring(self._EquipMode._combat) .. ")")
  self._ui.btn_Combat:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_SimpleTooltip(" .. tostring(self._EquipMode._combat) .. ",true)")
  self._ui.btn_Combat:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_SimpleTooltip(" .. tostring(self._EquipMode._combat) .. ",false)")
  self._ui.btn_Life:addInputEvent("Mouse_LUp", "HandleEventLUp_Equipment_All_ChangeMode(" .. tostring(self._EquipMode._life) .. ")")
  self._ui.btn_Life:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_SimpleTooltip(" .. tostring(self._EquipMode._life) .. ",true)")
  self._ui.btn_Life:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_SimpleTooltip(" .. tostring(self._EquipMode._life) .. ",false)")
  self._ui.rdo_stanceCombat:addInputEvent("Mouse_LUp", "aabbcc(" .. __eActionMode_Normal .. ")")
  self._ui.rdo_stanceFishing:addInputEvent("Mouse_LUp", "aabbcc(" .. __eActionMode_FishingRod .. ")")
  self._ui.rdo_stanceJaksal:addInputEvent("Mouse_LUp", "aabbcc(" .. __eActionMode_FishingHarpoon .. ")")
  self._ui.rdo_stanceCombat:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_Stance(" .. __eActionMode_Normal .. ")")
  self._ui.rdo_stanceFishing:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_Stance(" .. __eActionMode_FishingRod .. ")")
  self._ui.rdo_stanceJaksal:addInputEvent("Mouse_On", "HandleEventOnOut_Equipment_All_Stance(" .. __eActionMode_FishingHarpoon .. ")")
  self._ui.rdo_stanceCombat:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_Stance()")
  self._ui.rdo_stanceFishing:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_Stance()")
  self._ui.rdo_stanceJaksal:addInputEvent("Mouse_Out", "HandleEventOnOut_Equipment_All_Stance()")
  Panel_Window_Equipment_All:RegisterShowEventFunc(true, "PaGlobalFunc_Equipment_All_ShowAni()")
  Panel_Window_Equipment_All:RegisterShowEventFunc(false, "PaGlobalFunc_Equipment_All_HideAni()")
  registerEvent("onScreenResize", "PaGlobalFunc_Equipment_All_OnScreenResize")
  registerEvent("EventEquipmentUpdate", "PaGlobalFunc_Equipment_All_UpdateSlotData")
  registerEvent("EventEquipItem", "FromClient_Equipment_All_EventEquipItem")
  registerEvent("EventPCEquipSetShow", "Equipment_SetShow")
  registerEvent("FromClient_UpdateFamilySkill", "PaGlobalFunc_Equipment_All_UpdateSlotData")
  registerEvent("FromClient_FamilySpeicalInfoChange", "FromClient_Equipment_All_FamilySpeicalInfoChange")
  registerEvent("FromClient_CharacterSpeicalInfoChange", "FromClient_Equipment_All_CharacterSpeicalInfoChange")
  registerEvent("FromClient_ChangeUnderwearModeInHouse", "FromClient_Equipment_All_ChangeUnderwearMode")
  registerEvent("FromClient_ChangeSwimmingSuitShowMode", "FromClient_Equipment_All_ChangeSwimmingSuitMode")
end
function aabbcc(index)
  ToClient_RequestChangeActionMode(index)
  PaGlobal_Equipment_All._ui.rdo_stanceFishing:SetIgnore(index == __eActionMode_FishingHarpoon)
  PaGlobal_Equipment_All._ui.rdo_stanceJaksal:SetIgnore(index == __eActionMode_FishingRod)
  if index == __eActionMode_Normal then
    PaGlobal_Equipment_All._ui.txt_stance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_BASE"))
  elseif index == __eActionMode_FishingRod then
    PaGlobal_Equipment_All._ui.txt_stance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_FISH"))
  elseif index == __eActionMode_FishingHarpoon then
    PaGlobal_Equipment_All._ui.txt_stance:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_JAKSAL"))
  else
    PaGlobal_Equipment_All._ui.txt_stance:SetText("")
  end
end
function HandleEventOnOut_Equipment_All_Stance(index)
  local name, control
  if index == __eActionMode_Normal then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_BASE")
    control = PaGlobal_Equipment_All._ui.rdo_stanceCombat
  elseif index == __eActionMode_FishingRod then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_FISH")
    control = PaGlobal_Equipment_All._ui.rdo_stanceFishing
  elseif index == __eActionMode_FishingHarpoon then
    name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SERVANTICON_SUBBUTTON_JAKSAL")
    control = PaGlobal_Equipment_All._ui.rdo_stanceJaksal
  else
    TooltipSimple_Hide()
    return
  end
  TooltipSimple_Show(control, name)
end
function PaGlobal_Equipment_All:validate()
  if nil == Panel_Window_Equipment_All then
    return
  end
  self._ui.txt_titleBG:isValidate()
  self._ui.check_popup:isValidate()
  self._ui.btn_question:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_circle:isValidate()
  self._ui.stc_abilityArea:isValidate()
  self._ui.txt_attackText:isValidate()
  self._ui.txt_attackValue:isValidate()
  self._ui.txt_defenceText:isValidate()
  self._ui.txt_defenceValue:isValidate()
  self._ui.txt_awakenText:isValidate()
  self._ui.txt_awakenValue:isValidate()
  self._ui.txt_shyStatText:isValidate()
  self._ui.txt_shyStatValue:isValidate()
  self._ui.stc_bottomButtonArea:isValidate()
  self._ui.btn_servantInven:isValidate()
  self._ui.check_camouflage:isValidate()
  self._ui.check_underwear:isValidate()
  self._ui.btn_petList:isValidate()
  self._ui.check_helmInvisual:isValidate()
  self._ui.check_helmOpen:isValidate()
  self._ui.check_cloak:isValidate()
  self._ui.check_subWeapon:isValidate()
  self._ui.btn_setEffect:isValidate()
  self._ui.btn_equipCrystal:isValidate()
  self._ui.btn_artifactOption:isValidate()
  self._ui.check_alchemyStone:isValidate()
  self._ui.txt_alchemyStoneQuickKey:isValidate()
  self._ui.tooltipTemplate:isValidate()
  self._ui.txt_blankSlotTooltip:isValidate()
  self._ui.stc_seasonBannerPass:isValidate()
  self._ui.stc_seasonBannerReward:isValidate()
  self._ui.stc_seasonBannerUpgrade:isValidate()
  self._ui.stc_sword:isValidate()
  self._ui.stc_blackSpiritBackImage:isValidate()
  self._ui.stc_imageWalk:isValidate()
  self._ui.stc_imageGo:isValidate()
  self._ui.btn_newbieBag:isValidate()
  self._ui.btn_Combat:isValidate()
  self._ui.btn_Life:isValidate()
  self._ui.stc_LifeEquipBg:isValidate()
  self._ui.txt_LifeDesc:isValidate()
  self._ui.stc_accessoryStepUpBanner:isValidate()
end
