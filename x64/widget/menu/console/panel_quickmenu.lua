PaGlobal_ConsoleQuickMenu = {
  _widgetForceClose = false,
  _inventoryData = {},
  _skillData = {},
  _functionTypeData = {},
  _ui = {
    _quickMenuPosition = {},
    _quickMenuPositionIcon = {},
    _quickMenuPositionSlot = {},
    _staticCircleLine = UI.getChildControl(Panel_QuickMenu, "Static_CircleLine"),
    _staticDeco = UI.getChildControl(Panel_QuickMenu, "Static_Deco"),
    _staticIconName = UI.getChildControl(Panel_QuickMenu, "Static_SelectedButton"),
    _staticTextIconNameDesc = UI.getChildControl(Panel_QuickMenu, "StaticText_SelectedButtonTitleDesc"),
    _staticTextIconDesc = UI.getChildControl(Panel_QuickMenu, "StaticText_SelectedButtonDesc"),
    _centerDeco = UI.getChildControl(Panel_QuickMenu, "Static_CenterDeco"),
    _line = {},
    _rightMenuPanel = {},
    _bubbleBG = UI.getChildControl(Panel_Widget_QuickMenu, "Static_Bubble"),
    _ringMenuBG = UI.getChildControl(Panel_Widget_QuickMenu, "Static_RingMenuBG"),
    _bubbleText = nil,
    _blackSpirit = nil
  },
  _curGroup = 0,
  _center = {_x = 0, _y = 0},
  _isAnimating = false,
  _registMode = {
    _isStart = false,
    _stickPosition = __eQuickMenuStickPosition_Count,
    _index = -1
  },
  _textureIcon = {
    _center = {
      [0] = {
        _x1 = 623,
        _y1 = 399,
        _x2 = 933,
        _y2 = 709
      },
      [1] = {
        _x1 = 399,
        _y1 = 88,
        _x2 = 709,
        _y2 = 398
      },
      [2] = {
        _x1 = 1,
        _y1 = 399,
        _x2 = 311,
        _y2 = 709
      },
      [3] = {
        _x1 = 312,
        _y1 = 399,
        _x2 = 622,
        _y2 = 709
      },
      [4] = {
        _x1 = 623,
        _y1 = 399,
        _x2 = 933,
        _y2 = 709
      },
      [5] = {
        _x1 = 399,
        _y1 = 88,
        _x2 = 709,
        _y2 = 398
      },
      [6] = {
        _x1 = 1,
        _y1 = 399,
        _x2 = 311,
        _y2 = 709
      },
      [7] = {
        _x1 = 312,
        _y1 = 399,
        _x2 = 622,
        _y2 = 709
      }
    },
    _bottom = {
      [0] = {
        _x1 = 399,
        _y1 = 710,
        _x2 = 485,
        _y2 = 796
      },
      [1] = {
        _x1 = 399,
        _y1 = 797,
        _x2 = 485,
        _y2 = 883
      },
      [2] = {
        _x1 = 486,
        _y1 = 710,
        _x2 = 572,
        _y2 = 796
      },
      [3] = {
        _x1 = 486,
        _y1 = 797,
        _x2 = 572,
        _y2 = 883
      },
      [4] = {
        _x1 = 399,
        _y1 = 710,
        _x2 = 485,
        _y2 = 796
      },
      [5] = {
        _x1 = 399,
        _y1 = 797,
        _x2 = 485,
        _y2 = 883
      },
      [6] = {
        _x1 = 486,
        _y1 = 710,
        _x2 = 572,
        _y2 = 796
      },
      [7] = {
        _x1 = 486,
        _y1 = 797,
        _x2 = 572,
        _y2 = 883
      }
    }
  },
  _slotConfig = {
    createIcon = true,
    createCount = true,
    createEnchant = false,
    createCooltime = true,
    createExpiration = true,
    createExpirationBG = true,
    createExpiration2h = true,
    createClassEquipBG = true,
    createEnduranceIcon = true,
    createCooltimeText = true,
    createCash = true,
    createMaidActorOnly = true,
    createItemLock = true,
    createBagIcon = true,
    createSoulComplete = true,
    createFamilyInvenotry = true
  },
  _maxMenuTabType = 5,
  _widgetState = {},
  _ringMoveCheck = false,
  _beforePositon = -1
}
function PaGlobal_ConsoleQuickMenu:initializeUI()
  local centerX, centerY, radius
  local uiScale = ToClient_getGameOptionControllerWrapper():getUIScale()
  for ii = 0, __eQuickMenuStickPosition_Count - 1 do
    self._ui._quickMenuPosition[ii] = UI.getChildControl(Panel_QuickMenu, "Button_Templete" .. tostring(ii))
    self._ui._quickMenuPositionIcon[ii] = UI.getChildControl(self._ui._quickMenuPosition[ii], "Static_Icon")
    self._ui._quickMenuPositionSlot[ii] = {}
    SlotItem.new(self._ui._quickMenuPositionSlot[ii], "QuickPosition_Slot_" .. ii, ii, self._ui._quickMenuPosition[ii], self._slotConfig)
    self._ui._quickMenuPositionSlot[ii]:createChild()
    self._ui._quickMenuPositionSlot[ii].icon:SetSize(self._ui._quickMenuPositionIcon[ii]:GetSizeX(), self._ui._quickMenuPositionIcon[ii]:GetSizeY())
    self._ui._quickMenuPositionSlot[ii].icon:SetPosX(self._ui._quickMenuPositionIcon[ii]:GetPosX())
    self._ui._quickMenuPositionSlot[ii].icon:SetPosY(self._ui._quickMenuPositionIcon[ii]:GetPosY())
    self._ui._quickMenuPositionSlot[ii].cooltime:SetSize(self._ui._quickMenuPositionSlot[ii].icon:GetSizeX(), self._ui._quickMenuPositionSlot[ii].icon:GetSizeY())
    radius = self._ui._quickMenuPositionSlot[ii].cooltime:GetSizeX() * 0.5 * uiScale
    centerX = self._ui._quickMenuPositionSlot[ii].cooltime:GetPosX() + 22
    centerY = self._ui._quickMenuPositionSlot[ii].cooltime:GetPosY() + 22
    self._ui._quickMenuPositionSlot[ii].cooltime:SetCircularClip(radius, float2(centerX, centerY))
  end
  self._ui._center = UI.getChildControl(Panel_QuickMenu, "Static_CenterPoint")
  if true == ToClient_isPS() then
    self._ui._stc_LTGuide = UI.getChildControl(Panel_QuickMenu, "Static_LT_PS")
  else
    self._ui._stc_LTGuide = UI.getChildControl(Panel_QuickMenu, "Static_LT_XB")
  end
  for ii = 0, __eQuickMenuStickPosition_Count - 1 do
    self._ui._line[ii] = UI.getChildControl(self._ui._center, "Static_Line" .. ii)
    self._ui._line[ii]:SetShow(false)
  end
  self._ui._widget = {}
  self._widgetState = {}
  for group = 0, __eQuickMenuDpadGroup_Count - 1 do
    local bg = UI.getChildControl(self._ui._ringMenuBG, "Static_Bg" .. tostring(group))
    self._ui._widget[group] = {}
    self._ui._widget[group]._bg = bg
    self._ui._widget[group]._pad = UI.getChildControl(bg, "Static_Pad")
    self._ui._widget[group]._slotBg = UI.getChildControl(bg, "Static_SlotBg")
    self._ui._widget[group]._slot = {}
    SlotItem.new(self._ui._widget[group]._slot, "QuickGroup_Slot_" .. group, group, bg, self._slotConfig)
    self._ui._widget[group]._slot:createChild()
    self._ui._widget[group]._slot.icon:SetPosY(self._ui._widget[group]._slotBg:GetPosY() + 2)
    self._ui._widget[group]._slot.icon:SetPosX(self._ui._widget[group]._slotBg:GetPosX() + 2)
    self._ui._widget[group]._slot.cooltime:SetSize(self._ui._widget[group]._slotBg:GetSizeX(), self._ui._widget[group]._slotBg:GetSizeY())
    centerX = self._ui._widget[group]._slot.cooltime:GetPosX() + 22
    centerY = self._ui._widget[group]._slot.cooltime:GetPosY() + 22
    radius = self._ui._widget[group]._slot.cooltime:GetSizeX() * 0.5 * uiScale
    self._ui._widget[group]._slot.cooltime:SetCircularClip(radius, float2(centerX, centerY))
    self._ui._widget[group]._selected = UI.getChildControl(bg, "Static_SelectedPad")
    self._ui._widget[group]._ring = UI.getChildControl(bg, "Static_Ring")
    self._ui._widget[group]._ringPosition = {}
    self._widgetState[group] = {}
    for position = 0, __eQuickMenuStickPosition_Count - 1 do
      self._ui._widget[group]._ringPosition[position] = UI.getChildControl(self._ui._widget[group]._ring, "Static_" .. tostring(position))
      self._widgetState[group][position] = nil
    end
  end
  self._ui._bubbleText = UI.getChildControl(self._ui._bubbleBG, "StaticText_Desc")
  self._ui._blackSpirit = UI.getChildControl(self._ui._bubbleBG, "Static_BlackSpirit")
  self._ui._blackSpirit:AddEffect("fN_DarkSpirit_Gage_01A", true, 0, 0)
  self._ui._rightMenuPanel._stc_LeftBg = UI.getChildControl(Panel_QuickMenuCustom, "Static_LeftBg")
  self._ui._rightMenuPanel._txt_RingMenuDesc = UI.getChildControl(self._ui._rightMenuPanel._stc_LeftBg, "StaticText_RingMenuDesc")
  self._ui._rightMenuPanel._txt_RingMenuDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._rightMenuPanel._txt_RingMenuDesc:SetAutoResize(true)
  self._ui._rightMenuPanel._txt_RingMenuDesc:SetText(self._ui._rightMenuPanel._txt_RingMenuDesc:GetText())
  self._ui._rightMenuPanel._txt_QuickSlotDesc = UI.getChildControl(self._ui._rightMenuPanel._stc_LeftBg, "StaticText_QuickSlotDesc")
  self._ui._rightMenuPanel._txt_QuickSlotDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._rightMenuPanel._txt_QuickSlotDesc:SetAutoResize(true)
  self._ui._rightMenuPanel._txt_QuickSlotDesc:SetText(self._ui._rightMenuPanel._txt_QuickSlotDesc:GetText())
  self._ui._rightMenuPanel._txt_ChangeMenuDesc = UI.getChildControl(self._ui._rightMenuPanel._stc_LeftBg, "StaticText_ChangeMenuDesc")
  self._ui._rightMenuPanel._txt_ChangeMenuDesc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._rightMenuPanel._txt_ChangeMenuDesc:SetAutoResize(true)
  self._ui._rightMenuPanel._txt_ChangeMenuDesc:SetText(self._ui._rightMenuPanel._txt_ChangeMenuDesc:GetText())
  self._ui._rightMenuPanel._stc_TabBg = UI.getChildControl(Panel_QuickMenuCustom, "Static_TabBg")
  self._ui._rightMenuPanel._btn_TabBtn = {}
  self._ui._rightMenuPanel._btn_TabBtn[__eQuickMenuDataType_Item] = UI.getChildControl(self._ui._rightMenuPanel._stc_TabBg, "RadioButton_Item")
  self._ui._rightMenuPanel._btn_TabBtn[__eQuickMenuDataType_Skill] = UI.getChildControl(self._ui._rightMenuPanel._stc_TabBg, "RadioButton_Skill")
  self._ui._rightMenuPanel._btn_TabBtn[__eQuickMenuDataType_Function] = UI.getChildControl(self._ui._rightMenuPanel._stc_TabBg, "RadioButton_Menu")
  self._ui._rightMenuPanel._btn_TabBtn[__eQuickMenuDataType_SocialAction] = UI.getChildControl(self._ui._rightMenuPanel._stc_TabBg, "RadioButton_Social")
  self._ui._rightMenuPanel._btn_TabBtn[__eQuickMenuDataType_GuildSkill] = UI.getChildControl(self._ui._rightMenuPanel._stc_TabBg, "RadioButton_GuildSkill")
end
function PaGlobal_ConsoleQuickMenu:setCoolTime(slot, quickMenu)
  if slot == nil then
    return
  end
  if slot.count ~= nil then
    slot.count:SetShow(false)
  end
  local isInAbyssOne = false
  if _ContentsGroup_ProjectAbyssOne == true then
    isInAbyssOne = ToClient_isInAbyssOne()
  end
  if isInAbyssOne == false then
    slot.icon:SetMonoTone(false)
  end
  if __eQuickMenuDataType_Skill == quickMenu._type or __eQuickMenuDataType_GuildSkill == quickMenu._type then
    slot.icon:SetMonoTone(false)
    local remainTime = ToClient_getSkillCooltimebySkillNo(quickMenu._skillKey:getSkillNo())
    local skillReuseTime = ToClient_GetSkillReusetimebySkillNo(quickMenu._skillKey:getSkillNo())
    local realRemainTime = remainTime * skillReuseTime
    local intRemainTime = realRemainTime - realRemainTime % 1 + 1
    if remainTime > 0 then
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if skillReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
      else
        slot.cooltimeText:SetShow(false)
      end
    else
      slot.cooltime:SetShow(false)
      slot.cooltimeText:SetShow(false)
    end
  elseif __eQuickMenuDataType_Item == quickMenu._type then
    if isInAbyssOne == true then
      slot.icon:SetMonoTone(true)
      slot.icon:SetColor(Defines.Color.C_FF6C6C6C)
    end
    local slotNo = ToClient_GetItemSlotNo(quickMenu._itemWhereType, quickMenu._itemKey)
    local itemCount = 0
    local itemWrapper = getInventoryItemByType(quickMenu._itemWhereType, slotNo)
    if nil ~= itemWrapper then
      itemCount = Int64toInt32(itemWrapper:get():getCount_s64())
      if itemCount > 0 then
        if slot.count ~= nil then
          slot.count:SetShow(true)
          slot.count:SetText(itemCount)
        end
        if isInAbyssOne == false then
          slot.icon:SetMonoTone(false)
        end
      else
        if slot.count ~= nil then
          slot.count:SetShow(false)
        end
        slot.familyInvenIcon:SetShow(CppEnums.ItemWhereType.eFamilyInventory == quickMenu._itemWhereType)
        slot.icon:SetMonoTone(true)
      end
    else
      if slot.count ~= nil then
        slot.count:SetShow(false)
      end
      slot.familyInvenIcon:SetShow(CppEnums.ItemWhereType.eFamilyInventory == quickMenu._itemWhereType)
      slot.icon:SetMonoTone(true)
    end
    if 0 == itemCount then
      return
    end
    local remainTime = getItemCooltime(quickMenu._itemWhereType, slotNo)
    local itemReuseTime = getItemReuseCycle(quickMenu._itemWhereType, slotNo)
    local realRemainTime = remainTime * itemReuseTime
    local intRemainTime = realRemainTime - realRemainTime % 1 + 1
    if remainTime > 0 then
      slot.cooltime:UpdateCoolTime(remainTime)
      slot.cooltime:SetShow(true)
      slot.cooltimeText:SetText(Time_Formatting_ShowTop(intRemainTime))
      if itemReuseTime >= intRemainTime then
        slot.cooltimeText:SetShow(true)
        PaGlobal_TutorialManager:handleUpdateQuickSlotPerFrame(slot, quickMenu._itemKey:getItemKey())
      else
        slot.cooltimeText:SetShow(false)
      end
    elseif slot.cooltime:GetShow() then
      slot.cooltime:SetShow(false)
      slot.cooltimeText:SetShow(false)
    end
  elseif slot.cooltime:GetShow() then
    slot.cooltime:SetShow(false)
    slot.cooltimeText:SetShow(false)
  end
end
function PaGlobal_ConsoleQuickMenu:setWidgetRingPosition(group, position, control)
  local quickMenuType = ToClient_GetAtQuickMenuType(group, position)
  local quickMenuFunctionType = ToClient_GetAtQuickMenuFunctionType(group, position)
  local beforeState = self._widgetState[group][position]
  local currentState = __eQuickMenuState_None
  if __eQuickMenuDataType_Empty == quickMenuType then
    currentState = __eQuickMenuState_None
  else
    currentState = __eQuickMenuState_Exist
  end
  if __eQuickMenuDataType_Skill == quickMenuType or __eQuickMenuDataType_GuildSkill == quickMenuType or __eQuickMenuDataType_Item == quickMenuType then
    currentState = ToClient_GetAtQuickMenuState(group, position)
  elseif ToClient_isPlayingSequence() == true then
    if PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute ~= nil and PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute(quickMenuType, quickMenuFunctionType) == false then
      currentState = __eQuickMenuState_Empty
    end
  elseif _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true and PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute ~= nil and PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute(quickMenuType, quickMenuFunctionType) == false then
    currentState = __eQuickMenuState_Empty
  end
  if currentState ~= beforeState then
    self._widgetState[group][position] = currentState
    self:setWidgetState(control, self._widgetState[group][position])
  end
end
function PaGlobal_ConsoleQuickMenu:setWidgetState(control, state)
  control:ChangeTextureInfoNameAsync("Renewal/Function/Console_Function_RingMenu_01.dds")
  if state == __eQuickMenuState_None then
    control:SetShow(false)
  elseif state == __eQuickMenuState_Exist then
    control:getBaseTexture():setUV(setTextureUV_Func(control, 333, 97, 342, 106))
    control:SetShow(true)
  elseif state == __eQuickMenuState_Cooltime then
    control:getBaseTexture():setUV(setTextureUV_Func(control, 343, 97, 352, 106))
    control:SetShow(true)
  elseif state == __eQuickMenuState_Empty then
    control:getBaseTexture():setUV(setTextureUV_Func(control, 353, 97, 362, 106))
    control:SetShow(true)
  end
  control:setRenderTexture(control:getBaseTexture())
end
function FGlobal_Console_Widget_QuickMenuCustom_UpdatePerFrame(deltaTime)
  local self = PaGlobal_ConsoleQuickMenu
  if nil == self._ui._widget then
    return
  end
  for group = 0, __eQuickMenuDpadGroup_Count - 1 do
    if true == ToClient_isQuickMenuQuickMode(group) then
      local quickSlot = ToClient_getQuickModeValue(group)
      local slot = self._ui._widget[group]._slot
      self:setCoolTime(slot, quickSlot)
    else
      for position = 0, __eQuickMenuStickPosition_Count - 1 do
        self:setWidgetRingPosition(group, position, self._ui._widget[group]._ringPosition[position])
      end
    end
  end
end
function PaGlobal_ConsoleQuickMenuCustom_HighlightCategory(category)
  self = PaGlobal_ConsoleQuickMenu
  for ii = 0, self._maxMenuTabType - 1 do
    self._ui._rightMenuPanel._btn_TabBtn[ii]:SetFontColor(Defines.Color.C_FF888888)
  end
  self._ui._rightMenuPanel._btn_TabBtn[category]:SetFontColor(Defines.Color.C_FFEEEEEE)
end
function PaGlobal_ConsoleQuickMenu:setButtonPos(selectedIndex)
  if self._isAnimating then
    return
  end
  self._center.x = self._ui._center:GetPosX()
  self._center.y = self._ui._center:GetPosY()
  local angle = 2 * math.pi / 8 * 5
  local angleOffset = 2 * math.pi / 8
  for index = 0, 7 do
    angle = angle + angleOffset
    if selectedIndex == index then
      local x = 205 * math.cos(angle)
      local y = 205 * math.sin(angle)
      self._ui._quickMenuPosition[index]:SetPosX(self._center.x + x - 47)
      self._ui._quickMenuPosition[index]:SetPosY(self._center.y + y - 47)
      self._ui._line[index]:SetShow(false)
    else
      local x = 185 * math.cos(angle)
      local y = 185 * math.sin(angle)
      self._ui._quickMenuPosition[index]:SetPosX(self._center.x + x - 47)
      self._ui._quickMenuPosition[index]:SetPosY(self._center.y + y - 47)
      self._ui._line[index]:SetShow(false)
    end
  end
end
function PaGlobal_ConsoleQuickMenu:moveButtonAni(currentPosition)
  if nil == currentPosition or currentPosition < 0 or currentPosition >= __eQuickMenuStickPosition_Count then
    return
  end
  local control = self._ui._quickMenuPosition[currentPosition]
  local buttonMoveAni = control:addMoveAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  buttonMoveAni:SetStartPosition(control:GetPosX(), control:GetPosY())
  buttonMoveAni:SetEndPosition(self._center.x - 47, self._center.y - 47)
  buttonMoveAni.IsChangeChild = true
  control:CalcUIAniPos(buttonMoveAni)
  buttonMoveAni:SetDisableWhileAni(true)
  for index, value in pairs(self._ui._line) do
    value:SetShow(false)
  end
  self._isAnimating = true
end
function PaGlobal_ConsoleQuickMenu:clearButtonAni()
  for index, value in pairs(self._ui._quickMenuPosition) do
    value:ResetAndClearVertexAni()
  end
end
function QuickMenu_ShowAni()
  Panel_QuickMenu:ResetVertexAni()
  local alphaAni = Panel_QuickMenu:addColorAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  alphaAni:SetStartColorBySafe(PAUIColorType(Panel_QuickMenu:GetAlpha() * 255, 255, 255, 255))
  alphaAni:SetEndColorBySafe(PAUIColorType(255, 255, 255, 255))
  alphaAni.IsChangeChild = false
  local aniInfo1 = Panel_QuickMenu:addScaleAnimation(0, 0.1, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.9)
  aniInfo1:SetEndScale(1)
  aniInfo1.AxisX = Panel_QuickMenu:GetSizeX() / 2
  aniInfo1.AxisY = Panel_QuickMenu:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
end
function QuickMenu_HideAni()
  local aniInfo = UIAni.AlphaAnimation(0, Panel_QuickMenu, 0.1, 0.2)
  aniInfo:SetHideAtEnd(true)
end
function FGlobal_ConsoleQuickMenu_IsShow()
  return Panel_QuickMenu:GetShow()
end
function FGlobal_ConsoleQuickMenuCustom_IsShow()
  return Panel_QuickMenuCustom:GetShow()
end
function PaGlobal_ConsoleQuickMenu:Open(currentGroup)
  if currentGroup < 0 or currentGroup >= __eQuickMenuDpadGroup_Count then
    return
  end
  if true == Panel_QuickMenuCustom:GetShow() then
    return
  end
  if nil ~= Panel_Widget_Ping_All and true == Panel_Widget_Ping_All:GetShow() then
    return
  end
  self._curGroup = currentGroup
  self:SetUICurrentGroup(currentGroup)
  self._isAnimating = false
  PaGlobal_ConsoleQuickMenu:clearButtonAni()
  self:setButtonPos(__eQuickMenuStickPosition_Count)
  self:CrossTextureChange(currentGroup)
  Panel_QuickMenu:SetPosY((getOriginScreenSizeY() - Panel_QuickMenu:GetSizeY()) / 2)
  Panel_QuickMenu:SetShow(true, true)
  _AudioPostEvent_SystemUiForXBOX(52, 0)
  self._ui._staticTextIconNameDesc:SetText("")
  self._ui._staticCircleLine:EraseAllEffect()
  self._ui._staticCircleLine:AddEffect("fUI_Console_Rudder_01A", false, 0, 0)
end
function FromClient_ConsoleQuickMenu_Close(currentPosition)
  local self = PaGlobal_ConsoleQuickMenu
  if nil == self then
    return
  end
  self._beforePositon = -1
  PaGlobal_ConsoleQuickMenu:moveButtonAni(currentPosition)
  _AudioPostEvent_SystemUiForXBOX(52, 2)
  Panel_QuickMenu:SetShow(false, false)
end
function PaGlobal_ConsoleQuickMenu:SetUICurrentGroup(group)
  local groupInfo = self:GetCurrentGroupInfo(group)
  local isInAbyssOne = _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true
  local isPlayingSequence = ToClient_isPlayingSequence() == true
  for position, info in ipairs(groupInfo) do
    local slot = self._ui._quickMenuPositionSlot[position - 1]
    local control = self._ui._quickMenuPositionIcon[position - 1]
    if control ~= nil and slot ~= nil then
      control:ChangeTextureInfoNameAsync(info._icon)
      if nil ~= info._uv then
        control:getBaseTexture():setUV(setTextureUV_Func(control, info._uv._x1, info._uv._y1, info._uv._x2, info._uv._y2))
      else
        control:getBaseTexture():setUV(0, 0, 1, 1)
      end
      control:setRenderTexture(control:getBaseTexture())
      slot:clearItem()
      slot.icon:ReleaseTexture()
      slot.icon:ChangeTextureInfoNameAsync("")
      control:SetMonoTone(false)
      slot.icon:SetMonoTone(false)
      control:SetColor(Defines.Color.C_FFFFFFFF)
      slot.icon:SetColor(Defines.Color.C_FFFFFFFF)
      if __eQuickMenuDataType_Item == info._type then
        local quickMenu = ToClient_getAtQuickMenu(group, position - 1)
        if quickMenu ~= nil then
          local itemStaticStatusWrapper = getItemEnchantStaticStatus(quickMenu._itemKey)
          if itemStaticStatusWrapper ~= nil then
            local slotNo = ToClient_GetItemNoByInventory(quickMenu._itemWhereType, quickMenu._itemNo)
            local itemWrapper = getInventoryItemByType(quickMenu._itemWhereType, slotNo)
            if itemWrapper ~= nil then
              local selfPlayer = getSelfPlayer():get()
              local inventory = selfPlayer:getInventoryByType(quickMenu._itemWhereType)
              slot:setItem(itemWrapper, slotNo, false, false, CppEnums.ItemWhereType.eFamilyInventory == quickMenu._itemWhereType)
            else
              slot.icon:ChangeTextureInfoNameAsync("Icon/" .. itemStaticStatusWrapper:getIconPath())
            end
            slot.icon:SetShow(true)
          end
        end
      elseif info._type == __eQuickMenuDataType_Skill or info._type == __eQuickMenuDataType_GuildSkill then
        local quickMenu = ToClient_getAtQuickMenu(group, position - 1)
        if quickMenu ~= nil then
          local skillTypeStaticWrapper = getSkillTypeStaticStatus(quickMenu._skillKey:getSkillNo())
          if skillTypeStaticWrapper ~= nil then
            slot.icon:ChangeTextureInfoNameAsync("Icon/" .. skillTypeStaticWrapper:getIconPath())
          end
        end
      elseif info._type == __eQuickMenuDataType_SocialAction then
        local quickMenu = ToClient_getAtQuickMenu(group, position - 1)
        if quickMenu ~= nil then
          local socialActionStaticStatus = ToClient_getSocialActionStaticStatusByKey(quickMenu._socialActionKey)
          if socialActionStaticStatus ~= nil then
            slot.icon:ChangeTextureInfoNameAsync("Icon/" .. socialActionStaticStatus:getIconPath())
          end
        end
      end
      if isPlayingSequence == true then
        local isMonoTone = false
        local quickMenu = ToClient_getAtQuickMenu(group, position - 1)
        if quickMenu == nil then
          isMonoTone = true
        elseif PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute ~= nil and PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute(quickMenu._type, quickMenu._functionType) == false then
          isMonoTone = true
        end
        local color = Defines.Color.C_FFFFFFFF
        if info._type == __eQuickMenuDataType_Function then
          if isMonoTone == true then
            color = Defines.Color.C_FF6C6C6C
          end
          isMonoTone = false
        end
        control:SetMonoTone(isMonoTone)
        slot.icon:SetMonoTone(isMonoTone)
        control:SetColor(color)
        slot.icon:SetColor(color)
      elseif isInAbyssOne == true then
        local isMonoTone = false
        local quickMenu = ToClient_getAtQuickMenu(group, position - 1)
        if quickMenu == nil then
          isMonoTone = true
        elseif PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute ~= nil and PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute(quickMenu._type, quickMenu._functionType) == false then
          isMonoTone = true
        end
        local color = Defines.Color.C_FFFFFFFF
        if info._type == __eQuickMenuDataType_Function then
          if isMonoTone == true then
            color = Defines.Color.C_FF6C6C6C
          end
          isMonoTone = false
        end
        control:SetMonoTone(isMonoTone)
        slot.icon:SetMonoTone(isMonoTone)
        control:SetColor(color)
        slot.icon:SetColor(color)
      end
    end
  end
end
function PaGlobal_ConsoleQuickMenu:GetPositionInfo(quickMenu)
  if nil == quickMenu then
    return nil
  end
  local icon = ""
  local uv
  if __eQuickMenuDataType_Skill == quickMenu._type or __eQuickMenuDataType_GuildSkill == quickMenu._type then
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(quickMenu._skillKey:getSkillNo())
    if nil ~= skillTypeStaticWrapper then
      icon = "Icon/" .. skillTypeStaticWrapper:getIconPath()
    end
  elseif __eQuickMenuDataType_Item == quickMenu._type then
    local itemStaticStatusWrapper = getItemEnchantStaticStatus(quickMenu._itemKey)
    if nil ~= itemStaticStatusWrapper then
      icon = "Icon/" .. itemStaticStatusWrapper:getIconPath()
    end
  elseif __eQuickMenuDataType_Function == quickMenu._type then
    if self._functionTypeList._ToggleData[__eQuickMenuDataType_Function][quickMenu._functionType] ~= nil then
      local data = self._functionTypeList._ToggleData[__eQuickMenuDataType_Function][quickMenu._functionType]()
      icon = data._path
      uv = {
        _x1 = data._x1,
        _y1 = data._y1,
        _x2 = data._x2,
        _y2 = data._y2
      }
    else
      icon = self._functionTypeList._icon[__eQuickMenuDataType_Function][quickMenu._functionType]._path
      local iconUV = self._functionTypeList._icon[__eQuickMenuDataType_Function][quickMenu._functionType]
      uv = {
        _x1 = iconUV._x1,
        _y1 = iconUV._y1,
        _x2 = iconUV._x2,
        _y2 = iconUV._y2
      }
    end
  elseif __eQuickMenuDataType_SocialAction == quickMenu._type then
    for ii = 0, ToClient_getSocialActionInfoList() - 1 do
      local socialActionInfo = ToClient_getSocialActionInfoByIndex(ii)
      local sASS = socialActionInfo:getStaticStatus()
      local socialKey = sASS:getKey()
      if socialKey == quickMenu._socialActionKey then
        icon = "Icon/" .. sASS:getIconPath()
        break
      end
    end
  end
  return {
    _icon = icon,
    _uv = uv,
    _type = quickMenu._type
  }
end
function PaGlobal_ConsoleQuickMenu:GetCurrentGroupInfo(padGroup)
  if padGroup < 0 or padGroup >= __eQuickMenuDpadGroup_Count then
    return
  end
  local table = {}
  for position = 0, __eQuickMenuStickPosition_Count - 1 do
    local quickMenu = ToClient_getAtQuickMenu(padGroup, position)
    if nil == quickMenu then
      return
    end
    table[#table + 1] = self:GetPositionInfo(quickMenu)
  end
  return table
end
function PaGlobal_ConsoleQuickMenu:GetPresetGroupInfo(presetIndex, padGroup)
  if padGroup < 0 or padGroup >= __eQuickMenuDpadGroup_Count then
    return
  end
  local table = {}
  for position = 0, __eQuickMenuStickPosition_Count - 1 do
    local quickMenu = ToClient_getAtQuickMenuForPreset(presetIndex, padGroup, position)
    if nil == quickMenu then
      return
    end
    table[#table + 1] = self:GetPositionInfo(quickMenu)
  end
  return table
end
function PaGlobal_ConsoleQuickMenu:GetCurrentQuickMenuName(group, position)
  if group < 0 or group >= __eQuickMenuDpadGroup_Count then
    return ""
  end
  local table = {}
  local quickMenu = ToClient_getAtQuickMenu(group, position)
  if nil == quickMenu then
    return ""
  end
  local name = ""
  if __eQuickMenuDataType_Skill == quickMenu._type or __eQuickMenuDataType_GuildSkill == quickMenu._type then
    local skillTypeStaticWrapper = getSkillTypeStaticStatus(quickMenu._skillKey:getSkillNo())
    if nil ~= skillTypeStaticWrapper then
      name = skillTypeStaticWrapper:getName()
    end
  elseif __eQuickMenuDataType_Item == quickMenu._type then
    local itemStaticStatusWrapper = getItemEnchantStaticStatus(quickMenu._itemKey)
    if nil ~= itemStaticStatusWrapper then
      name = itemStaticStatusWrapper:getName()
    end
  elseif __eQuickMenuDataType_Function == quickMenu._type then
    if self._functionTypeList._ToggleData[__eQuickMenuDataType_Function][quickMenu._functionType] ~= nil then
      local data = self._functionTypeList._ToggleData[__eQuickMenuDataType_Function][quickMenu._functionType]()
      name = data._name
    else
      name = self._functionTypeList._name[__eQuickMenuDataType_Function][quickMenu._functionType]
    end
  end
  return name
end
function PaGlobal_ConsoleQuickMenu:setIcon(control, icon, uv)
  if nil == control then
    return
  end
  control:SetShow(false)
  if nil == icon then
    return
  end
  control:ChangeTextureInfoNameAsync(icon)
  if nil ~= uv then
    control:getBaseTexture():setUV(setTextureUV_Func(control, uv._x1, uv._y1, uv._x2, uv._y2))
  else
    control:getBaseTexture():setUV(0, 0, 1, 1)
  end
  control:setRenderTexture(control:getBaseTexture())
  control:SetShow(true)
end
function PaGlobal_ConsoleQuickMenu:setAsyncIcon(control, icon)
  if nil == control then
    return
  end
  control:SetShow(false)
  if nil == icon then
    return
  end
  control:ChangeTextureInfoNameAsync(icon)
  local x1, y1, x2, y2 = setTextureUV_Func(control, 0, 0, 44, 44)
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
  control:SetShow(true)
end
function PaGlobal_ConsoleQuickMenu:CrossTextureChange(currentGroup)
  local bottomControl = self._ui._staticIconName
  local iconPathData1 = self._textureIcon._bottom[currentGroup]
  bottomControl:ChangeTextureInfoNameAsync("Renewal/Function/Console_Function_RingMenu.dds")
  bottomControl:getBaseTexture():setUV(setTextureUV_Func(bottomControl, iconPathData1._x1, iconPathData1._y1, iconPathData1._x2, iconPathData1._y2))
  bottomControl:setRenderTexture(bottomControl:getBaseTexture())
  local centerControl = self._ui._centerDeco
  local iconPathData2 = self._textureIcon._center[currentGroup]
  centerControl:ChangeTextureInfoNameAsync("Renewal/Function/Console_Function_RingMenu.dds")
  centerControl:getBaseTexture():setUV(setTextureUV_Func(centerControl, iconPathData2._x1, iconPathData2._y1, iconPathData2._x2, iconPathData2._y2))
  centerControl:setRenderTexture(centerControl:getBaseTexture())
  if currentGroup < __eQuickMenuDpadGroup_Count / 2 then
    self._ui._stc_LTGuide:SetShow(false)
  else
    self._ui._stc_LTGuide:SetShow(true)
  end
end
function PaGlobal_ConsoleQuickMenu:setWidget()
  if nil == self._ui._widget then
    return
  end
  for group = 0, __eQuickMenuDpadGroup_Count - 1 do
    local widget = self._ui._widget[group]
    if ToClient_isQuickMenuQuickMode(group) then
      widget._ring:SetShow(false)
      widget._slot.icon:SetShow(true)
    else
      widget._ring:SetShow(true)
      widget._slot.icon:SetShow(false)
    end
  end
  for group = 0, __eQuickMenuDpadGroup_Count - 1 do
    local widget = self._ui._widget[group]
    if ToClient_isQuickMenuQuickMode(group) then
      widget._ring:SetShow(false)
      widget._slot.icon:SetShow(true)
      local quickSlot = ToClient_getQuickModeValue(group)
      local quickSlotInfo = self:GetPositionInfo(quickSlot)
      if nil ~= widget._slot.bagIcon then
        widget._slot.bagIcon:ChangeTextureInfoNameAsync("")
      end
      if __eQuickMenuDataType_Item == quickSlotInfo._type then
        local itemStaticStatusWrapper = getItemEnchantStaticStatus(quickSlot._itemKey)
        if itemStaticStatusWrapper ~= nil then
          local selfPlayer = getSelfPlayer():get()
          local inventory = selfPlayer:getInventoryByType(quickSlot._itemWhereType)
          local slotNo = inventory:getSlot(quickSlot._itemKey)
          local itemWrapper = getInventoryItemByType(quickSlot._itemWhereType, slotNo)
          if nil ~= itemWrapper then
            local widgetSlotNo = ToClient_GetItemNoByInventory(quickSlot._itemWhereType, quickSlot._itemNo)
            widget._slot:setItem(itemWrapper, widgetSlotNo, false, false, CppEnums.ItemWhereType.eFamilyInventory == quickSlot._itemWhereType)
          end
          self:setAsyncIcon(widget._slot.icon, quickSlotInfo._icon)
        end
      elseif __eQuickMenuDataType_Skill == quickSlotInfo._type or __eQuickMenuDataType_GuildSkill == quickSlotInfo._type then
        self:setAsyncIcon(widget._slot.icon, quickSlotInfo._icon)
      elseif __eQuickMenuDataType_SocialAction == quickSlotInfo._type then
        self:setAsyncIcon(widget._slot.icon, quickSlotInfo._icon)
      else
        self:setIcon(widget._slot.icon, quickSlotInfo._icon, quickSlotInfo._uv)
      end
    end
  end
end
function FromClient_ConsoleQuickMenu_UpdateWidget()
  PaGlobal_ConsoleQuickMenu:setWidget()
end
function FromClient_ConsoleQuickMenu_luaLoadComplete()
  PaGlobal_ConsoleQuickMenu:initializeUI()
  PaGlobal_ConsoleQuickMenu:setDefaultSetting()
  PaGlobal_ConsoleQuickMenu:setWidget()
  if true == _ContentsGroup_RenewUI then
    if 0 ~= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleQuickMenu, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
      Panel_Widget_QuickMenu:SetShow(true)
      PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(true)
    end
  elseif true == _ContentsGroup_UsePadSnapping then
    Panel_Widget_QuickMenu:SetShow(true)
    PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(true)
  end
  ToClient_setAvailableInputWidget(true)
  registerEvent("FromClient_ConsoleQuickMenu_OpenCustomPage", "FromClient_ConsoleQuickMenu_OpenCustomPage")
  registerEvent("FromClient_ConsoleQuickMenu_Open", "FromClient_ConsoleQuickMenu_Open")
  registerEvent("FromClient_ConsoleQuickMenu_Close", "FromClient_ConsoleQuickMenu_Close")
  registerEvent("FromClient_ConsoleQuickMenu_Execute", "FromClient_ConsoleQuickMenu_Execute")
  registerEvent("FromClient_ConsoleQuickMenu_Selecting", "FromClient_ConsoleQuickMenu_Selecting")
  registerEvent("EventProcessorInputModeChange", "FGlobal_InputModeChangeForQuickMenu")
  registerEvent("EventEquipmentUpdate", "FromClient_ConsoleQuickMenu_UpdateWidget")
  registerEvent("FromClient_UpdateInventoryBag", "FromClient_ConsoleQuickMenu_UpdateWidget")
  if true == ToClient_IsRemoteControlMode() then
    Panel_Widget_QuickMenu:SetShow(false)
  end
end
function FromClient_ConsoleQuickMenu_Open(group)
  PaGlobal_ConsoleQuickMenu:Open(group)
end
function FromClient_ConsoleQuickMenu_Execute(position)
end
function FromClient_ConsoleQuickMenu_Selecting(group, position)
  local self = PaGlobal_ConsoleQuickMenu
  local isInAbyssOne = _ContentsGroup_ProjectAbyssOne == true and ToClient_isInAbyssOne() == true
  local isPlayingSequence = ToClient_isPlayingSequence() == true
  for ii = 0, __eQuickMenuStickPosition_Count - 1 do
    local quickSlot = ToClient_getAtQuickMenu(group, ii)
    local slot = self._ui._quickMenuPositionSlot[ii]
    local control = self._ui._quickMenuPosition[ii]
    local quickSlotInfo
    if quickSlot ~= nil and slot ~= nil and control ~= nil then
      quickSlotInfo = self:GetPositionInfo(quickSlot)
      if quickSlotInfo ~= nil and __eQuickMenuDataType_SocialAction == quickSlotInfo._type then
        self:setAsyncIcon(slot.icon, quickSlotInfo._icon)
      end
    end
    if control ~= nil then
      local isMonoTone = false
      if isPlayingSequence == true then
        if quickSlot == nil then
          isMonoTone = true
        elseif PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute ~= nil then
          isMonoTone = not PaGlobalFunc_ConsoleQuickMenu_CheckSequencePlayerControlExecute(quickSlot._type, quickSlot._functionType)
        end
      elseif isInAbyssOne == true then
        if quickSlot == nil then
          isMonoTone = true
        elseif PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute ~= nil then
          isMonoTone = not PaGlobalFunc_ConsoleQuickMenu_CheckAbyssOneExecute(quickSlot._type, quickSlot._functionType)
        end
      end
      if position == __eQuickMenuStickPosition_Count then
        local color = Defines.Color.C_FFFFFFFF
        if isPlayingSequence == true or isInAbyssOne == true then
          if isMonoTone == true then
            color = Defines.Color.C_FF6C6C6C
          end
          if quickSlot._type == __eQuickMenuDataType_Function then
            isMonoTone = false
          end
        end
        control:SetColor(color)
        slot.icon:SetColor(color)
        control:SetMonoTone(isMonoTone)
        slot.icon:SetMonoTone(isMonoTone)
        control:SetCheck(false)
      elseif position == ii then
        local name = self:GetCurrentQuickMenuName(self._curGroup, position)
        self._ui._staticTextIconNameDesc:SetText(name)
        local color = Defines.Color.C_FFFFFFFF
        if isPlayingSequence == true or isInAbyssOne == true then
          if isMonoTone == true then
            color = Defines.Color.C_FF6C6C6C
          end
          if quickSlot._type == __eQuickMenuDataType_Function then
            isMonoTone = false
          end
        end
        control:SetColor(color)
        slot.icon:SetColor(color)
        control:SetMonoTone(isMonoTone)
        slot.icon:SetMonoTone(isMonoTone)
        control:SetCheck(true)
        if self._ringMoveCheck == false and self._beforePositon ~= position then
          _AudioPostEvent_SystemUiForXBOX(51, 6)
          self._ringMoveCheck = true
          self._beforePositon = position
          local decoEffectPosX = control:GetPosX() + (control:GetSizeX() - self._ui._staticDeco:GetSizeX()) * 0.5
          local decoEffectPosY = control:GetPosY() + (control:GetSizeY() - self._ui._staticDeco:GetSizeY()) * 0.5
          self._ui._staticDeco:EraseAllEffect()
          self._ui._staticDeco:AddEffect("", false, decoEffectPosX, decoEffectPosY)
          control:EraseAllEffect()
          control:AddEffect("", false, 0, 0)
          self._ui._quickMenuPositionIcon[position]:EraseAllEffect()
          self._ui._quickMenuPositionIcon[position]:AddEffect("fUI_Console_Rudder_02A", false, 0, 0)
        end
      else
        local color = Defines.Color.C_FF6C6C6C
        if quickSlot._type ~= __eQuickMenuDataType_Function then
          isMonoTone = true
        end
        control:SetColor(color)
        slot.icon:SetColor(color)
        control:SetMonoTone(isMonoTone)
        slot.icon:SetMonoTone(isMonoTone)
        control:SetCheck(false)
      end
    end
    self:setCoolTime(slot, quickSlot)
  end
  self._ringMoveCheck = false
end
function FGlobal_InputModeChangeForQuickMenu(prevMode, currentMode)
  if true == PaGlobal_ConsoleQuickMenu._widgetForceClose then
    return
  end
  if true == ToClient_IsRemoteControlMode() then
    Panel_Widget_QuickMenu:SetShow(false)
    return
  end
  if currentMode == CppEnums.EProcessorInputMode.eProcessorInputMode_GameMode then
    if true == _ContentsGroup_RenewUI then
      if 0 ~= ToClient_GetUiInfo(CppEnums.PAGameUIType.PAGameUIPanel_ConsoleQuickMenu, 0, CppEnums.PanelSaveType.PanelSaveType_IsShow) then
        PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(true)
      end
    elseif true == _ContentsGroup_UsePadSnapping then
      PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(true)
    end
  else
    if currentMode == CppEnums.EProcessorInputMode.eProcessorInputMode_UiMode then
      PaGlobalFunc_ConsoleKeyGuide_PopGuide()
    end
    PaGlobal_ConsoleQuickMenu._ui._ringMenuBG:SetShow(false)
  end
end
function PaGlobal_QuickMenu_SetShowBlackSpirit(isShow, desc, position)
  local self = PaGlobal_ConsoleQuickMenu
  if nil ~= self._ui._bubbleText then
    self._ui._bubbleBG:SetShow(isShow)
    if false == isShow then
      return
    end
    self._ui._bubbleText:SetText(desc)
    self._ui._bubbleBG:SetSize(self._ui._bubbleText:GetTextSizeX() + 20, self._ui._bubbleBG:GetSizeY())
    self._ui._bubbleText:ComputePos()
    self._ui._blackSpirit:ComputePos()
    local posX = self._ui._widget[position]._bg:GetPosX() - self._ui._bubbleBG:GetSizeX()
    self._ui._bubbleBG:SetPosX(posX)
  end
end
Panel_Widget_QuickMenu:RegisterUpdateFunc("FGlobal_Console_Widget_QuickMenuCustom_UpdatePerFrame")
Panel_QuickMenu:RegisterShowEventFunc(true, "QuickMenu_ShowAni()")
Panel_QuickMenu:RegisterShowEventFunc(false, "QuickMenu_HideAni()")
registerEvent("FromClient_luaLoadComplete", "FromClient_ConsoleQuickMenu_luaLoadComplete")
