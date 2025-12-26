function PaGlobal_ExchangeExp_All:initialize()
  if true == PaGlobal_ExchangeExp_All._initialize then
    return
  end
  self._ui.stc_titleBG = UI.getChildControl(Panel_Window_ExchangeExp_All, "StaticText_Title")
  self._ui.stc_titleIcon = UI.getChildControl(self._ui.stc_titleBG, "StaticText_TitleIcon")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.stc_topBG = UI.getChildControl(Panel_Window_ExchangeExp_All, "Static_TopBg")
  local leftSlot = {}
  leftSlot.bg = UI.getChildControl(self._ui.stc_topBG, "Static_MainImageBorder_1")
  leftSlot.image = UI.getChildControl(leftSlot.bg, "Static_MainImage_1")
  leftSlot.enableBG = UI.getChildControl(leftSlot.bg, "Static_EnableImage_1")
  leftSlot.name = UI.getChildControl(leftSlot.bg, "StaticText_Name_1")
  leftSlot.seasonIcon = UI.getChildControl(leftSlot.bg, "Static_StateIcon")
  leftSlot.seasonIcon:SetShow(false)
  leftSlot.exp = UI.getChildControl(leftSlot.bg, "StaticText_Value_EXP")
  leftSlot.expTitle = UI.getChildControl(leftSlot.bg, "StaticText_Title_EXP")
  leftSlot.skillExp = UI.getChildControl(leftSlot.bg, "StaticText_Value_SkillEXP")
  leftSlot.skillExpTitle = UI.getChildControl(leftSlot.bg, "StaticText_Title_SkillEXP")
  leftSlot.weight = UI.getChildControl(leftSlot.bg, "StaticText_Value_Weight")
  leftSlot.weightTitle = UI.getChildControl(leftSlot.bg, "StaticText_Title_Weight")
  leftSlot.slotCount = UI.getChildControl(leftSlot.bg, "StaticText_Value_Inventory")
  leftSlot.slotCountTitle = UI.getChildControl(leftSlot.bg, "StaticText_Title_Inventory")
  self._ui.leftSlot = leftSlot
  local rightSlot = {}
  rightSlot.bg = UI.getChildControl(self._ui.stc_topBG, "Static_MainImageBorder_2")
  rightSlot.image = UI.getChildControl(rightSlot.bg, "Static_MainImage_2")
  rightSlot.name = UI.getChildControl(rightSlot.bg, "StaticText_Name_2")
  rightSlot.enableBG = UI.getChildControl(rightSlot.bg, "Static_EnableImage_2")
  rightSlot.addIcon = UI.getChildControl(rightSlot.bg, "Static_AddIcon")
  rightSlot.selectText = UI.getChildControl(rightSlot.bg, "StaticText_SelectCharacter")
  self._ui.rightSlot = rightSlot
  rightSlot.selectText:SetTextMode(__eTextMode_AutoWrap)
  rightSlot.selectText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXPEXCHANGE_SELECT"))
  self._ui.btn_change = UI.getChildControl(self._ui.stc_topBG, "Button_Transfer")
  self._ui.stc_midBG = UI.getChildControl(Panel_Window_ExchangeExp_All, "Static_MidBg")
  self._ui.stc_slotTemplate = UI.getChildControl(self._ui.stc_midBG, "Static_CharacterImageBorderTemplate")
  self._ui.scroll_charList = UI.getChildControl(self._ui.stc_midBG, "Scroll_Tag")
  local sizeX = self._ui.stc_slotTemplate:GetSizeX()
  local sizeY = self._ui.stc_slotTemplate:GetSizeY()
  for index = 0, 5 do
    self._ui.characterList[index] = UI.cloneControl(self._ui.stc_slotTemplate, self._ui.stc_midBG, "Static_CharacterList_" .. index)
    self._ui.characterList[index]:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ExchangeExp_All_ScrollEvent(true)")
    self._ui.characterList[index]:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ExchangeExp_All_ScrollEvent(false)")
    self._ui.characterList[index]:SetPosX(10 + (sizeX + 10) * (index % self._charSlotColumnCount))
    self._ui.characterList[index]:SetPosY(10 + sizeY * math.floor(index / self._charSlotColumnCount))
  end
  self._ui.stc_slotTemplate:SetShow(false)
  self._ui.stc_descBG = UI.getChildControl(Panel_Window_ExchangeExp_All, "Static_DescBg")
  self._ui.txt_desc = UI.getChildControl(self._ui.stc_descBG, "StaticText_Desc")
  self._ui.stc_keyguideBG = UI.getChildControl(Panel_Window_ExchangeExp_All, "Static_KeyGuide_Console")
  self._ui.stc_keyGuideA = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_Select_Console")
  self._ui.stc_keyGuideB = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_Close_Console")
  self._ui.stc_keyGuideLBRB = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_RB_ConsoleUI")
  self._ui.stc_keyGuideY = UI.getChildControl(self._ui.stc_keyguideBG, "StaticText_Y_ConsoleUI")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._maxCharacterCount = getCharacterDataCount(__ePlayerCreateNormal)
  self:registEventHandler()
  self:changePanelSize()
  self:setConsoleUI()
  self:validate()
  self._initialize = true
end
function PaGlobal_ExchangeExp_All:setConsoleUI()
  if true == self._isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.btn_change:SetShow(false)
    self._ui.stc_keyguideBG:SetShow(true)
    self:setAlignKeyGuide()
  else
    self._ui.btn_close:SetShow(true)
    self._ui.btn_change:SetShow(true)
    self._ui.stc_keyguideBG:SetShow(false)
  end
end
function PaGlobal_ExchangeExp_All:registEventHandler()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  registerEvent("onScreenResize", "FromClient_ExchangeExp_All_OnScreenResize")
  registerEvent("FromClient_SuccessExchangeExp", "FromClient_ExchangeExp_All_SuccessExchange")
  registerEvent("FromClient_ShowExchangeExpWindow", "FromClient_ShowExchangeExpWindow")
  registerEvent("FromClient_ShowExchangeInventoryAndWeightWindow", "FromClient_ShowExchangeInventoryAndWeightWindow")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobal_ExchangeExp_All_Close()")
  self._ui.btn_change:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeExp_All_ChangeConfirm()")
  self._ui.stc_midBG:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ExchangeExp_All_ScrollEvent(true)")
  self._ui.stc_midBG:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ExchangeExp_All_ScrollEvent(false)")
  if true == self._isConsole then
    Panel_Window_ExchangeExp_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "HandleEventScroll_ExchangeExp_All_ScrollEvent(true)")
    Panel_Window_ExchangeExp_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "HandleEventScroll_ExchangeExp_All_ScrollEvent(false)")
  end
  UIScroll.InputEvent(self._ui.scroll_charList, "HandleEventScroll_ExchangeExp_All_ScrollEvent")
end
function PaGlobal_ExchangeExp_All:setAlignKeyGuide()
  if false == self._isConsole then
    return
  end
  local keyGuides = {
    self._ui.stc_keyGuideY,
    self._ui.stc_keyGuideLBRB,
    self._ui.stc_keyGuideA,
    self._ui.stc_keyGuideB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_keyguideBG, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
end
function PaGlobal_ExchangeExp_All:changePanelSize()
  self._ui.txt_desc:SetTextMode(__eTextMode_AutoWrap)
  if self._isOnlyInventoryAndWeight == true then
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXPEXCHANGE_DESC_A"))
  else
    self._ui.txt_desc:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXPEXCHANGE_DESC"))
  end
  self._ui.txt_desc:SetSize(self._ui.txt_desc:GetSizeX(), self._ui.txt_desc:GetTextSizeY())
  local changeSizeY = self._ui.txt_desc:GetTextSizeY() + 10 - self._ui.stc_descBG:GetSizeY()
  self._ui.stc_descBG:SetSize(self._ui.stc_descBG:GetSizeX(), self._ui.txt_desc:GetTextSizeY() + 10)
  Panel_Window_ExchangeExp_All:SetSize(Panel_Window_ExchangeExp_All:GetSizeX(), Panel_Window_ExchangeExp_All:GetSizeY() + changeSizeY)
  self._ui.stc_descBG:ComputePos()
  self._ui.txt_desc:ComputePos()
  self._ui.stc_keyguideBG:ComputePos()
  Panel_Window_ExchangeExp_All:ComputePos()
end
function PaGlobal_ExchangeExp_All:prepareOpen()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  local selfProxy = getSelfPlayer()
  if nil == selfProxy then
    return
  end
  if true == selfProxy:get():isBattleGroundDefine() then
    Proc_ShowMessage_Ack(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_FREEBATTLE"))
    return
  end
  self:update()
  self:changeLeftSlotSpanSizeY()
  self:changePanelSize()
  PaGlobal_ExchangeExp_All:open()
end
function PaGlobal_ExchangeExp_All:changeLeftSlotSpanSizeY()
  if self._isOnlyInventoryAndWeight == true then
    self._ui.stc_titleIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXPEXCHANGE_TITLE_A"))
    self._ui.leftSlot.exp:SetShow(false)
    self._ui.leftSlot.expTitle:SetShow(false)
    self._ui.leftSlot.skillExp:SetShow(false)
    self._ui.leftSlot.skillExpTitle:SetShow(false)
    self._ui.leftSlot.weight:SetSpanSize(0, -35)
    self._ui.leftSlot.weightTitle:SetSpanSize(0, -35)
    self._ui.leftSlot.slotCount:SetSpanSize(0, -60)
    self._ui.leftSlot.slotCountTitle:SetSpanSize(0, -60)
  else
    self._ui.stc_titleIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_EXPEXCHANGE_TITLE"))
    self._ui.leftSlot.exp:SetShow(true)
    self._ui.leftSlot.expTitle:SetShow(true)
    self._ui.leftSlot.skillExp:SetShow(true)
    self._ui.leftSlot.skillExpTitle:SetShow(true)
    self._ui.leftSlot.exp:SetSpanSize(0, -35)
    self._ui.leftSlot.expTitle:SetSpanSize(0, -35)
    self._ui.leftSlot.skillExp:SetSpanSize(0, -60)
    self._ui.leftSlot.skillExpTitle:SetSpanSize(0, -60)
    self._ui.leftSlot.weight:SetSpanSize(0, -85)
    self._ui.leftSlot.weightTitle:SetSpanSize(0, -85)
    self._ui.leftSlot.slotCount:SetSpanSize(0, -110)
    self._ui.leftSlot.slotCountTitle:SetSpanSize(0, -110)
  end
end
function PaGlobal_ExchangeExp_All:open()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  Panel_Window_ExchangeExp_All:SetShow(true)
end
function PaGlobal_ExchangeExp_All:prepareClose()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  self:clear()
  PaGlobal_ExchangeExp_All:close()
end
function PaGlobal_ExchangeExp_All:close()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  Panel_Window_ExchangeExp_All:SetShow(false)
end
function PaGlobal_ExchangeExp_All:clear()
  self._selectedCharacterIndex = -1
  self._fromWhereType = nil
  self._fromSlotNo = nil
end
function PaGlobal_ExchangeExp_All:update()
  self:updateTopSlotImage()
  self:updateCharacterList()
end
function PaGlobal_ExchangeExp_All:updateTopSlotImage()
  local selfCharIndex = ToClient_GetMyCharacterIndex()
  self:setSlotImage(selfCharIndex, true)
  local selectedIndex = self._selectedCharacterIndex
  self:setSlotImage(selectedIndex, false)
  if -1 == selectedIndex then
    if true == self._isConsole then
      self._ui.stc_keyGuideY:SetShow(false)
      self:setAlignKeyGuide()
      Panel_Window_ExchangeExp_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "")
    else
      self._ui.btn_change:SetIgnore(true)
      self._ui.btn_change:SetMonoTone(true)
    end
  elseif true == self._isConsole then
    self._ui.stc_keyGuideY:SetShow(true)
    self:setAlignKeyGuide()
    Panel_Window_ExchangeExp_All:registerPadEvent(__eConsoleUIPadEvent_Up_Y, "HandleEventLUp_ExchangeExp_All_ChangeConfirm()")
  else
    self._ui.btn_change:SetIgnore(false)
    self._ui.btn_change:SetMonoTone(false)
  end
end
function PaGlobal_ExchangeExp_All:setSlotImage(idx, isLeft)
  local slot = self._ui.leftSlot
  if false == isLeft then
    slot = self._ui.rightSlot
  end
  if -1 == idx then
    slot.image:ReleaseTexture()
    slot.image:SetAlpha(0)
    slot.image:ChangeTextureInfoNameAsync("")
    slot.image:setRenderTexture(slot.image:getBaseTexture())
    slot.name:SetText("")
    if slot == self._ui.rightSlot then
      if nil ~= slot.addIcon then
        slot.addIcon:SetShow(true)
      end
      if nil ~= slot.selectText then
        slot.selectText:SetShow(true)
      end
    end
    slot.enableBG:SetShow(false)
  else
    local characterData = getCharacterDataByIndex(idx, __ePlayerCreateNormal)
    local char_Type = getCharacterClassType(characterData)
    local char_Level = string.format("%d", characterData._level)
    local char_Name = getCharacterName(characterData)
    local char_TextureName = getCharacterFaceTextureByIndex(idx)
    local isExitPhoto = PaGlobal_GameExit_All_GetIsExitPhoto()
    local isCaptureExist = slot.image:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, isExitPhoto)
    if true == isCaptureExist then
      slot.image:getBaseTexture():setUV(0, 0, 1, 1)
    else
      local defaultFaceTexture = NewClassData.newClass_Texture_ID[char_Type]._defaultFaceTextureTID
      if defaultFaceTexture ~= nil then
        slot.image:ChangeTextureInfoTextureIDAsync(defaultFaceTexture, 0)
      end
    end
    slot.image:setRenderTexture(slot.image:getBaseTexture())
    slot.image:SetAlpha(1)
    slot.enableBG:SetShow(true)
    slot.name:SetText(char_Name)
    if slot == self._ui.leftSlot then
      local selfPlayer = getSelfPlayer()
      if nil ~= selfPlayer then
        if self._isOnlyInventoryAndWeight == false then
          local skillPointNeedExp = selfPlayer:get():getSkillPointNeedExperience()
          local skillExpRate = 0
          if 0 ~= skillPointNeedExp then
            skillExpRate = selfPlayer:get():getSkillPointExperience() / skillPointNeedExp
            skillExpRate = skillExpRate * 100
          end
          local skillPoint = tostring(selfPlayer:get():getRemainSkillPoint())
          local skillPointExp = string.format("%.1f", skillExpRate)
          slot.skillExp:SetShow(true)
          slot.skillExp:SetText(skillPoint .. " (" .. skillPointExp .. "%)")
          slot.skillExp:SetColor(4292723614)
          local s64_needExp = selfPlayer:get():getNeedExp_s64()
          local s64_exp = selfPlayer:get():getExp_s64()
          local stringS64Exp = tostring64(s64_exp)
          local stringS64NeedExp = tostring64(s64_needExp)
          local rate = tonumber(stringS64Exp) * 1000 * 100 / tonumber(stringS64NeedExp)
          local real_rate = rate / 1000
          slot.exp:SetShow(true)
          slot.exp:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level .. " (" .. string.format("%.3f", real_rate) .. "%)")
        end
        local inventory = selfPlayer:get():getInventoryByType(CppEnums.ItemWhereType.eInventory)
        if nil ~= inventory then
          local useStartSlot = inventorySlotNoUserStart()
          local invenUseSize = inventory:size()
          slot.slotCount:SetText(tostring(invenUseSize - useStartSlot))
          slot.slotCount:SetShow(true)
        else
          slot.slotCount:SetShow(false)
        end
        local _const = Defines.s64_const
        local s64_maxWeight = selfPlayer:get():getPossessableWeight_s64()
        local s64_maxWeight_div = s64_maxWeight / _const.s64_100
        local str_MaxWeight = string.format("%.0f", Int64toInt32(s64_maxWeight_div) / 100)
        slot.weight:SetText(str_MaxWeight)
      end
    end
    if slot == self._ui.rightSlot then
      if nil ~= slot.addIcon then
        slot.addIcon:SetShow(false)
      end
      if nil ~= slot.selectText then
        slot.selectText:SetShow(false)
      end
    end
  end
end
function PaGlobal_ExchangeExp_All:updateCharacterList()
  local selfPlayer = getSelfPlayer()
  if nil == selfPlayer then
    return
  end
  for ii = 0, 5 do
    self._ui.characterList[ii]:SetShow(false)
  end
  local availableIndexTable = {}
  local tableIndex = 0
  local selfCharIndex = ToClient_GetMyCharacterIndex()
  local characterCount = getCharacterDataCount(__ePlayerCreateNormal)
  for idx = 0, characterCount - 1 do
    if idx ~= selfCharIndex then
      local characterData = getCharacterDataByIndex(idx, __ePlayerCreateNormal)
      availableIndexTable[tableIndex] = idx
      tableIndex = tableIndex + 1
    end
  end
  self._maxCharacterCount = tableIndex
  UIScroll.SetButtonSize(self._ui.scroll_charList, 1, math.ceil(self._maxCharacterCount / 6))
  for ii = 0, 5 do
    local listIndex = ii + self._pageIndex * 6
    local idx = availableIndexTable[listIndex]
    if nil == idx then
      return
    end
    if idx > characterCount - 1 then
      return
    end
    local slot = self._ui.characterList[ii]
    slot:SetShow(true)
    local targetImage = UI.getChildControl(slot, "Static_CharacterImage")
    local targetLevel = UI.getChildControl(slot, "StaticText_Level")
    local targetName = UI.getChildControl(slot, "StaticText_Name")
    local targetSelect = UI.getChildControl(slot, "Static_Selected")
    local targetState = UI.getChildControl(slot, "StaticText_State")
    local characterData = getCharacterDataByIndex(idx, __ePlayerCreateNormal)
    local char_Type = getCharacterClassType(characterData)
    local char_Level = string.format("%d", characterData._level)
    local char_Name = getCharacterName(characterData)
    local char_TextureName = getCharacterFaceTextureByIndex(idx)
    local isExitPhoto = PaGlobal_GameExit_All_GetIsExitPhoto()
    local isCaptureExist = targetImage:ChangeTextureInfoNameNotDDS(char_TextureName, char_Type, isExitPhoto)
    if isCaptureExist == true then
      targetImage:getBaseTexture():setUV(0, 0, 1, 1)
    else
      local defaultFaceTexture = NewClassData.newClass_Texture_ID[char_Type]._defaultFaceTextureTID
      if defaultFaceTexture ~= nil then
        targetImage:ChangeTextureInfoTextureIDAsync(defaultFaceTexture, 0)
      end
    end
    targetImage:setRenderTexture(targetImage:getBaseTexture())
    targetLevel:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_COMMON_LV") .. "." .. char_Level)
    targetName:SetText(char_Name)
    if self._selectedCharacterIndex == idx then
      targetSelect:SetShow(true)
      targetImage:SetMonoTone(false)
    else
      targetSelect:SetShow(false)
      if -1 ~= self._selectedCharacterIndex then
        targetImage:SetMonoTone(true)
      else
        targetImage:SetMonoTone(false)
      end
    end
    local removeTime = getCharacterDataRemoveTime(idx, __ePlayerCreateNormal)
    if nil == removeTime then
      targetState:SetShow(false)
      slot:addInputEvent("Mouse_LUp", "HandleEventLUp_ExchangeExp_All_ClickCharacterList(" .. tostring(idx) .. ")")
    else
      targetImage:SetMonoTone(true)
      targetState:SetShow(true)
      targetState:SetTextMode(__eTextMode_AutoWrap)
      if nil ~= removeTime then
        targetState:SetText(PAGetString(Defines.StringSheet_GAME, "CHARACTER_DELETING"))
      end
      slot:addInputEvent("Mouse_LUp", "")
    end
    slot:addInputEvent("Mouse_UpScroll", "HandleEventScroll_ExchangeExp_All_ScrollEvent(true)")
    slot:addInputEvent("Mouse_DownScroll", "HandleEventScroll_ExchangeExp_All_ScrollEvent(false)")
  end
end
function PaGlobal_ExchangeExp_All:validate()
  if nil == Panel_Window_ExchangeExp_All then
    return
  end
  self._ui.stc_titleBG:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_topBG:isValidate()
  self._ui.btn_change:isValidate()
  self._ui.stc_midBG:isValidate()
  self._ui.stc_slotTemplate:isValidate()
  self._ui.scroll_charList:isValidate()
  self._ui.stc_descBG:isValidate()
  self._ui.txt_desc:isValidate()
  self._ui.stc_keyguideBG:isValidate()
  self._ui.stc_keyGuideA:isValidate()
  self._ui.stc_keyGuideB:isValidate()
  self._ui.stc_keyGuideLBRB:isValidate()
  self._ui.stc_keyGuideY:isValidate()
end
