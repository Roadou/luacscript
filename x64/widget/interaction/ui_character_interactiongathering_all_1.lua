function PaGlobal_InteractionGathering_All:initialize()
  if PaGlobal_InteractionGathering_All._initialize == true then
    return
  end
  self._ui._backGround = UI.getChildControl(UI_Character_InterActionGathering_All, "Static_Background")
  self._config._btn_offset_x = self._ui._backGround:GetPosX() + self._ui._backGround:GetSizeX() / 2
  self._config._btn_offset_y = self._ui._backGround:GetPosY() + self._ui._backGround:GetSizeY() / 2
  local centerBG = UI.getChildControl(self._ui._backGround, "Static_CenterBG")
  local mouseBG = UI.getChildControl(self._ui._backGround, "Static_1")
  local btn_collect = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_Collect")
  local interactionGuide = UI.getChildControl(self._ui._backGround, "StaticText_Purpose")
  self._config._guideDescYSize = interactionGuide:GetSizeY()
  interactionGuide:SetSize(self._config._guideDescXSize, self._config._guideDescYSize)
  self._ui._backGround:SetIgnore(false)
  centerBG:SetIgnore(true)
  mouseBG:SetIgnore(true)
  btn_collect:SetShow(false)
  PaGlobal_InteractionGathering_All:initializeButton()
  PaGlobal_InteractionGathering_All:registEventHandler()
  PaGlobal_InteractionGathering_All:validate()
  PaGlobal_InteractionGathering_All._initialize = true
end
function PaGlobal_InteractionGathering_All:initializeButton()
  self._ui._btn_ax = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_AX")
  self._ui._btn_injector = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_INJECTOR")
  self._ui._btn_homi = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_HOMI")
  self._ui._btn_meat = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_MEAT")
  self._ui._btn_leather = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_LEATHER")
  self._ui._btn_pick = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_PICK")
  self._ui._btn_barehand = UI.getChildControl(UI_Character_InterActionGathering_All, "Button_Hand")
  self._ui._btn_ax:SetTextHorizonCenter()
  self._ui._btn_injector:SetTextHorizonCenter()
  self._ui._btn_homi:SetTextHorizonCenter()
  self._ui._btn_meat:SetTextHorizonCenter()
  self._ui._btn_leather:SetTextHorizonCenter()
  self._ui._btn_pick:SetTextHorizonCenter()
  self._ui._btn_barehand:SetTextHorizonCenter()
  self._collectTypeUIInfo[__eCollectToolType_Axe] = {}
  self._collectTypeUIInfo[__eCollectToolType_Syringe] = {}
  self._collectTypeUIInfo[__eCollectToolType_Hoe] = {}
  self._collectTypeUIInfo[__eCollectToolType_ButcheryKnife] = {}
  self._collectTypeUIInfo[__eCollectToolType_SkinKnife] = {}
  self._collectTypeUIInfo[__eCollectToolType_Pickax] = {}
  self._collectTypeUIInfo[__eCollectToolType_BareHands] = {}
  self._collectTypeUIInfo[__eCollectToolType_Axe]._icon = self._ui._btn_ax
  self._collectTypeUIInfo[__eCollectToolType_Syringe]._icon = self._ui._btn_injector
  self._collectTypeUIInfo[__eCollectToolType_Hoe]._icon = self._ui._btn_homi
  self._collectTypeUIInfo[__eCollectToolType_ButcheryKnife]._icon = self._ui._btn_meat
  self._collectTypeUIInfo[__eCollectToolType_SkinKnife]._icon = self._ui._btn_leather
  self._collectTypeUIInfo[__eCollectToolType_Pickax]._icon = self._ui._btn_pick
  self._collectTypeUIInfo[__eCollectToolType_BareHands]._icon = self._ui._btn_barehand
  self._collectTypeUIInfo[__eCollectToolType_Axe]._desc = self._ui._btn_ax:GetText()
  self._collectTypeUIInfo[__eCollectToolType_Syringe]._desc = self._ui._btn_injector:GetText()
  self._collectTypeUIInfo[__eCollectToolType_Hoe]._desc = self._ui._btn_homi:GetText()
  self._collectTypeUIInfo[__eCollectToolType_ButcheryKnife]._desc = self._ui._btn_meat:GetText()
  self._collectTypeUIInfo[__eCollectToolType_SkinKnife]._desc = self._ui._btn_leather:GetText()
  self._collectTypeUIInfo[__eCollectToolType_Pickax]._desc = self._ui._btn_pick:GetText()
  self._collectTypeUIInfo[__eCollectToolType_BareHands]._desc = self._ui._btn_barehand:GetText()
  for ii, value in pairs(self._collectTypeList) do
    local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
    self._collectTypeUIInfo[value]._cant = UI.createAndCopyBasePropertyControl(UI_Character_InterActionGathering_All, "Static_Cant", UI_Character_InterActionGathering_All, "Static_Cant_" .. value)
    self._collectTypeUIInfo[value]._cant:SetShow(false)
    if 1 == isColorBlindMode then
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._collectTypeUIInfo[value]._cant, 421, 176, 455, 210)
      self._collectTypeUIInfo[value]._cant:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      self._collectTypeUIInfo[value]._cant:setRenderTexture(self._collectTypeUIInfo[value]._cant:getBaseTexture())
    end
  end
end
function PaGlobal_InteractionGathering_All:registEventHandler()
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  for key, value in pairs(self._collectTypeUIInfo) do
    value._icon:addInputEvent("Mouse_LUp", "PaGlobal_InteractionGathering_All_ButtonPushed( " .. CppEnums.ActionInputType.ActionInputType_Interaction .. " , " .. key .. " )")
    value._icon:addInputEvent("Mouse_UpScroll", "PaGlobal_InteractionGathering_All_RotateButton( true )")
    value._icon:addInputEvent("Mouse_DownScroll", "PaGlobal_InteractionGathering_All_RotateButton( false )")
  end
  self._ui._backGround:addInputEvent("Mouse_UpScroll", "PaGlobal_InteractionGathering_All_RotateButton( true )")
  self._ui._backGround:addInputEvent("Mouse_DownScroll", "PaGlobal_InteractionGathering_All_RotateButton( false )")
end
function PaGlobal_InteractionGathering_All:rotateButton(doClockWise)
  if self._activatedIconCount <= 1 or self._isRotating == true then
    return
  end
  if isCollectingAction() == true then
    return
  end
  if doClockWise == true then
    for idx = 1, self._activatedIconCount - 1 do
      local temp = self._activatedIconList[idx]
      self._activatedIconList[idx] = self._activatedIconList[idx - 1]
      self._activatedIconList[idx - 1] = temp
    end
  else
    for idx = self._activatedIconCount - 1, 1, -1 do
      local temp = self._activatedIconList[idx]
      self._activatedIconList[idx] = self._activatedIconList[idx - 1]
      self._activatedIconList[idx - 1] = temp
    end
  end
  self._clockWiseRotation = doClockWise
  self._buttonAnimationTime = 0
  self._buttonFirstOpen = false
  self._isRotating = true
  ToClient_SetSelectToolType(self._collectActionString, self._activatedIconList[0])
  self:prepareDesc()
end
function PaGlobal_InteractionGathering_All:prepareOpen()
  if UI_Character_InterActionGathering_All == nil then
    return false
  end
  if self:prepareOpenButton() == false then
    return false
  end
  self:prepareDesc()
  PaGlobal_InteractionGathering_All:open()
  return true
end
function PaGlobal_InteractionGathering_All:prepareDesc()
  local actor = interaction_getInteractable()
  if actor == nil then
    return false
  end
  local actorName = actor:getName()
  if actor:get():isInstallationActor() == true or actor:get():isDeadBody() == true or actor:get():isCollect() == true then
    if actor:get():isMonster() == false then
      actorName = actor:get():getStaticStatusName()
    end
  elseif actor:get():isNpc() == true then
    local npcTitle = actor:getCharacterTitle()
    if nil == npcTitle or "" == npcTitle then
      actorName = actor:getName()
    else
      actorName = npcTitle .. "\n" .. actor:getName()
    end
  elseif actor:get():isHouseHold() == true then
    if actor:getCharacterStaticStatusWrapper():getObjectStaticStatus():isPersonalTent() then
      actorName = actor:getCharacterStaticStatusWrapper():getName()
    else
      actorName = actor:getAddress()
    end
  elseif actor:get():isLoot() == true then
    actorName = actor:getLootItemName()
  end
  if actorName ~= nil then
    local txt_Name = UI.getChildControl(self._ui._backGround, "Static_Text_CharacterName")
    txt_Name:SetTextHorizonCenter()
    txt_Name:SetTextVerticalTop()
    txt_Name:SetAutoResize(true)
    txt_Name:SetText(actorName)
  else
    UI.ASSERT(false, "Interaction_Show // Actor Name is Nil!!!!")
  end
  local interactionGuide = UI.getChildControl(self._ui._backGround, "StaticText_Purpose")
  local interactionText = PAGetString(Defines.StringSheet_GAME, "INTERACTION_MENU" .. tostring(CppEnums.InteractionType.InteractionType_Collect))
  if self._activatedIconCount == 1 then
    local interactionDesc = PAGetStringParam2(Defines.StringSheet_GAME, "LUA_INTERACTION_PURPOSE_0", "interactionkey", keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction), "interaction", interactionText)
    interactionGuide:SetSize(self._config._guideDescXSize, self._config._guideDescYSize)
    interactionGuide:SetText(interactionDesc)
    interactionGuide:SetShow(true)
  elseif self._activatedIconCount > 1 then
    local interactionDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_INTERACTION_PURPOSE_4", "interactionkey", keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction), "interaction", interactionText, "change", keyCustom_GetString_UiKey(__eUiInputType_Interaction0))
    interactionGuide:SetTextMode(__eTextMode_AutoWrap)
    interactionGuide:SetAutoResize(true)
    interactionGuide:SetText(interactionDesc)
    interactionGuide:SetShow(true)
  else
    interactionGuide:SetShow(false)
  end
  if __eCollectToolType_BareHands ~= self._activatedIconList[0] and ToClient_CheckEquipTool(self._activatedIconList[0]) == false then
    interactionDesc = "<PAColor0xFFFFD649>" .. CppEnums.CollectToolTypeName[self._activatedIconList[0]] .. "<PAOldColor>"
    interactionDesc = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_INTERACTION_TEXT_NEEDGUIDE", "interactionDesc", interactionDesc)
    interactionGuide:SetTextMode(__eTextMode_AutoWrap)
    interactionGuide:SetAutoResize(true)
    interactionGuide:SetText(interactionDesc)
    interactionGuide:SetShow(true)
  end
end
function PaGlobal_InteractionGathering_All:open()
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  UI_Character_InterActionGathering_All:SetShow(true)
end
function PaGlobal_InteractionGathering_All:prepareClose()
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  PaGlobal_InteractionGathering_All:close()
end
function PaGlobal_InteractionGathering_All:close()
  if nil == UI_Character_InterActionGathering_All then
    return
  end
  UI_Character_InterActionGathering_All:SetShow(false)
end
function PaGlobal_InteractionGathering_All:update(deltaTime)
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  if UI_Character_InterActionGathering_All:GetShow() == false then
    return
  end
  self:updateButton(deltaTime)
end
function PaGlobal_InteractionGathering_All:prepareOpenButton()
  local actor = interaction_getInteractable()
  if actor == nil then
    return false
  end
  if Interaction_isSetInteractableFragLua(actor, CppEnums.InteractionType.InteractionType_Collect) == false then
    return false
  end
  if actor:get():isCollect() == false and actor:get():isDeadBody() == false and actor:get():isHoeCharacter() == false then
    return false
  end
  local collectWrapper = getCollectActor(actor:getActorKey())
  if collectWrapper == nil then
    collectWrapper = getMonsterActor(actor:getActorKey())
    if collectWrapper == nil then
      collectWrapper = getDeadBodyActor(actor:getActorKey())
      if collectWrapper == nil then
        _PA_ASSERT(false, "\236\177\132\236\167\145\236\157\184\237\132\176\235\158\153\236\133\152\236\157\132 \236\136\152\237\150\137\236\164\145\236\157\184\235\141\176 \235\140\128\236\131\129\236\157\180 \236\177\132\236\167\145\235\172\188\236\157\180 \236\149\132\235\139\153\235\139\136\235\139\164. \235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164.")
        return false
      end
    end
  end
  if collectWrapper:isCollectable() == false and actor:get():isHoeCharacter() == false then
    return false
  end
  self._activatedIconCount = 0
  for idx = 1, #self._collectTypeList do
    local targetCollectType = self._collectTypeList[idx]
    if targetCollectType ~= nil then
      local isAble = collectWrapper:getCharacterStaticStatusWrapper():isCollectableToolType(targetCollectType)
      local targetUIInfo = self._collectTypeUIInfo[targetCollectType]
      if targetUIInfo ~= nil then
        if isAble == true then
          if self._activatedIconCount > self._config._MAXICON then
            _PA_ASSERT(false, "\236\177\132\236\167\145\235\172\188\236\157\152 \236\177\132\236\167\145\236\185\180\237\133\140\234\179\160\235\166\172 \236\162\133\235\165\152\234\176\128 " .. self._config._MAXICON .. "\234\176\128\236\167\128\235\165\188 \235\132\152\236\150\180\234\176\128\235\169\180 \235\178\132\237\138\188 \235\140\128\236\157\145\236\157\180 \236\149\136\235\144\169\235\139\136\235\139\164!!")
            break
          end
          self._activatedIconList[self._activatedIconCount] = targetCollectType
          self._activatedIconCount = self._activatedIconCount + 1
          targetUIInfo._icon:SetShow(true)
        else
          targetUIInfo._icon:SetShow(false)
        end
        if targetUIInfo._cant ~= nil then
          targetUIInfo._cant:SetShow(false)
        end
      end
    end
  end
  self._collectActionString = ""
  for idx = 0, self._activatedIconCount - 1 do
    self._collectActionString = self._collectActionString .. self._activatedIconList[idx]
  end
  if self._activatedIconCount > 1 and ToClient_GetSelectToolType(self._collectActionString) < __eCollectToolType_Count then
    for idx = 0, self._activatedIconCount - 1 do
      if ToClient_GetSelectToolType(self._collectActionString) == self._activatedIconList[idx] then
        local temp = self._activatedIconList[idx]
        self._activatedIconList[idx] = self._activatedIconList[0]
        self._activatedIconList[0] = temp
      end
    end
  end
  if self._activatedIconCount == 0 then
    return false
  end
  self._buttonAnimationTime = 0
  self._buttonFirstOpen = true
  self._isRotating = true
  return true
end
function PaGlobal_InteractionGathering_All:validate()
  if UI_Character_InterActionGathering_All == nil then
    return
  end
  self._ui._backGround:isValidate()
  self._ui._btn_ax:isValidate()
  self._ui._btn_injector:isValidate()
  self._ui._btn_homi:isValidate()
  self._ui._btn_meat:isValidate()
  self._ui._btn_leather:isValidate()
  self._ui._btn_pick:isValidate()
  self._ui._btn_barehand:isValidate()
end
function PaGlobal_InteractionGathering_All:updateButton(deltaTime)
  self._buttonAnimationTime = self._buttonAnimationTime + deltaTime
  local aniRate = self._buttonAnimationTime / self._config._ANIMATION_TIME
  if aniRate > 1 then
    aniRate = 1
    self._isRotating = false
  end
  for idx = 0, self._activatedIconCount - 1 do
    self:subUpdateButton(idx, aniRate)
  end
end
function PaGlobal_InteractionGathering_All:subUpdateButton(idx, aniRate)
  local targetToolType = self._activatedIconList[idx]
  if targetToolType == nil then
    return
  end
  local targetToolUIInfo = self._collectTypeUIInfo[targetToolType]
  if targetToolUIInfo == nil then
    return
  end
  self:setIconMonotone(targetToolType, targetToolUIInfo)
  self:setIconDescription(idx, targetToolUIInfo)
  self:setIconPosition(idx, targetToolUIInfo, aniRate)
end
function PaGlobal_InteractionGathering_All:setIconMonotone(targetToolType, targetToolUIInfo)
  if targetToolType == nil or targetToolUIInfo == nil then
    return
  end
  if __eCollectToolType_BareHands ~= targetToolType then
    if ToClient_CheckEquipTool(targetToolType) == true then
      targetToolUIInfo._isAble = true
      targetToolUIInfo._icon:SetMonoTone(false)
      if targetToolUIInfo._cant ~= nil then
        targetToolUIInfo._cant:SetShow(false)
      end
    else
      targetToolUIInfo._isAble = false
      targetToolUIInfo._icon:SetMonoTone(true)
      if targetToolUIInfo._cant ~= nil then
        targetToolUIInfo._cant:SetShow(true)
      end
    end
  end
end
function PaGlobal_InteractionGathering_All:setIconDescription(idx, targetToolUIInfo)
  if targetToolUIInfo == nil then
    return
  end
  if idx ~= 0 then
    targetToolUIInfo._icon:SetIgnore(true)
    targetToolUIInfo._icon:SetTextSpan(0, targetToolUIInfo._icon:GetSizeY())
  else
    if targetToolUIInfo._isAble == true then
      targetToolUIInfo._icon:SetIgnore(false)
    else
      targetToolUIInfo._icon:SetIgnore(true)
    end
    targetToolUIInfo._icon:SetTextSpan(0, self._config._iconTextTextSpanY)
  end
  if idx == 0 then
    targetToolUIInfo._icon:SetText(targetToolUIInfo._desc .. " (" .. keyCustom_GetString_ActionKey(CppEnums.ActionInputType.ActionInputType_Interaction) .. ")")
  elseif idx == 1 then
    targetToolUIInfo._icon:SetText(targetToolUIInfo._desc .. " (" .. keyCustom_GetString_UiKey(__eUiInputType_Interaction0) .. ")")
  elseif self._activatedIconCount >= 2 and idx == self._activatedIconCount - 1 then
    targetToolUIInfo._icon:SetText(targetToolUIInfo._desc .. " (" .. keyCustom_GetString_UiKey(__eUiInputType_Interaction1) .. ")")
  end
end
function PaGlobal_InteractionGathering_All:setIconPosition(idx, targetToolUIInfo, aniRate)
  if targetToolUIInfo == nil then
    return
  end
  local targetIcon = targetToolUIInfo._icon
  if targetIcon == nil then
    return
  end
  local iconPosX = 0
  local iconPosY = 0
  if self._buttonFirstOpen == true then
    local ANGLE_OFFSET = math.pi * -0.5
    local div = idx / self._activatedIconCount
    iconPosX = self._config._btn_offset_x + self._config._circle_radius * aniRate * math.cos(ANGLE_OFFSET - math.pi * 2 * div * aniRate) - targetIcon:GetSizeX() / 2
    iconPosY = self._config._btn_offset_y + self._config._circle_radius * aniRate * math.sin(ANGLE_OFFSET - math.pi * 2 * div * aniRate) - targetIcon:GetSizeY() / 2
    targetIcon:SetAlpha(aniRate)
  else
    local ANGLE_OFFSET = math.pi * -0.5
    for dummy = 0, idx - 1 do
      ANGLE_OFFSET = ANGLE_OFFSET - math.pi * (2 / self._activatedIconCount)
    end
    if self._clockWiseRotation == true then
      ANGLE_OFFSET = ANGLE_OFFSET - math.pi * (2 / self._activatedIconCount)
      iconPosX = self._config._btn_offset_x + self._config._circle_radius * math.cos(ANGLE_OFFSET + math.pi * 2 / self._activatedIconCount * aniRate) - targetIcon:GetSizeX() / 2
      iconPosY = self._config._btn_offset_y + self._config._circle_radius * math.sin(ANGLE_OFFSET + math.pi * 2 / self._activatedIconCount * aniRate) - targetIcon:GetSizeY() / 2
    else
      ANGLE_OFFSET = ANGLE_OFFSET + math.pi * (2 / self._activatedIconCount)
      iconPosX = self._config._btn_offset_x + self._config._circle_radius * math.cos(ANGLE_OFFSET - math.pi * 2 / self._activatedIconCount * aniRate) - targetIcon:GetSizeX() / 2
      iconPosY = self._config._btn_offset_y + self._config._circle_radius * math.sin(ANGLE_OFFSET - math.pi * 2 / self._activatedIconCount * aniRate) - targetIcon:GetSizeY() / 2
    end
  end
  targetIcon:SetPosX(iconPosX)
  targetIcon:SetPosY(iconPosY)
  if targetToolUIInfo._cant ~= nil then
    targetToolUIInfo._cant:SetPosX(iconPosX)
    targetToolUIInfo._cant:SetPosY(iconPosY)
  end
end
function FGlobal_Window_InteractionGathering_ColorBlindUpdate()
  local self = PaGlobal_InteractionGathering_All
  if self == nil then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : PaGlobal_InteractionGathering_All")
    return
  end
  local isColorBlindMode = ToClient_getGameUIManagerWrapper():getLuaCacheDataListNumber(__eColorBlindMode)
  for ii, value in pairs(self._collectTypeList) do
    if 0 == isColorBlindMode then
      if self._collectTypeUIInfo[value] ~= nil then
        local x1, y1, x2, y2 = setTextureUV_Func(self._collectTypeUIInfo[value]._cant, 458, 178, 488, 208)
        self._collectTypeUIInfo[value]._cant:getBaseTexture():setUV(x1, y1, x2, y2)
        self._collectTypeUIInfo[value]._cant:setRenderTexture(self._collectTypeUIInfo[value]._cant:getBaseTexture())
      end
    elseif 1 == isColorBlindMode then
      if self._collectTypeUIInfo[value] ~= nil then
        local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._collectTypeUIInfo[value]._cant, 421, 176, 455, 210)
        self._collectTypeUIInfo[value]._cant:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
        self._collectTypeUIInfo[value]._cant:setRenderTexture(self._collectTypeUIInfo[value]._cant:getBaseTexture())
      end
    elseif 2 == isColorBlindMode and self._collectTypeUIInfo[value] ~= nil then
      local xx1, yy1, xx2, yy2 = setTextureUV_Func(self._collectTypeUIInfo[value]._cant, 458, 178, 488, 208)
      self._collectTypeUIInfo[value]._cant:getBaseTexture():setUV(xx1, yy1, xx2, yy2)
      self._collectTypeUIInfo[value]._cant:setRenderTexture(self._collectTypeUIInfo[value]._cant:getBaseTexture())
    end
  end
end
