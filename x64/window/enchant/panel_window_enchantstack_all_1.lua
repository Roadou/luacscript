function PaGlobal_EnchantStack_All:initialize()
  if Panel_Window_EnchantStack_All == nil or PaGlobal_EnchantStack_All._initialize == true then
    return
  end
  self._isConsole = _ContentsGroup_UsePadSnapping
  self:controlInit()
  self:setConsoleUI()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_EnchantStack_All:controlInit()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  self._ui.stc_titleArea = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_TitleArea_Import")
  self._ui.btn_question = UI.getChildControl(self._ui.stc_titleArea, "Button_Question")
  self._ui.btn_close = UI.getChildControl(self._ui.stc_titleArea, "Button_Close")
  self._ui.stc_radioButtonBg = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_RadioButtonBg")
  self._ui.stc_radioButton_stack = UI.getChildControl(self._ui.stc_radioButtonBg, "RadioButton_Stack")
  self._ui.stc_radioButton_valksCry = UI.getChildControl(self._ui.stc_radioButtonBg, "RadioButton_StackBonus")
  self._ui.stc_selectBar = UI.getChildControl(self._ui.stc_radioButtonBg, "Static_SelectBar")
  self._ui.stc_mainBg = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_MainBG")
  self._ui.txt_normalStack = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Normal_Stack")
  self._ui.stc_normalArrow = UI.getChildControl(self._ui.txt_normalStack, "Static_SelectArrow")
  self._ui.txt_bonusStack = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Bonus_Stack")
  self._ui.stc_bonusArrow = UI.getChildControl(self._ui.txt_bonusStack, "Static_SelectArrow")
  self._ui.txt_selectStack = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Select_Stack")
  self._ui.txt_selectRate = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Select_Rate")
  self._ui.txt_probability = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Select_Probability")
  self._ui.txt_successRate = UI.getChildControl(self._ui.stc_mainBg, "StaticText_Select_Probability_Rate")
  self._ui.btn_othersChoice = UI.getChildControl(self._ui.stc_mainBg, "Button_Recommand")
  self._ui.stc_listArea = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_ListArea")
  self._ui.frame_itemList = UI.getChildControl(self._ui.stc_listArea, "Frame_TotalReward_Import")
  self._ui.frame_content = UI.getChildControl(self._ui.frame_itemList, "Frame_1_Content")
  self._ui.stc_listGroup = UI.getChildControl(self._ui.frame_content, "Static_Group")
  self._ui.stc_slot = UI.getChildControl(self._ui.frame_content, "Static_ItemSlotBg")
  self._ui.stc_select = UI.getChildControl(self._ui.frame_content, "Static_Select")
  self._ui.scroll_vertical = UI.getChildControl(self._ui.frame_itemList, "Frame_1_VerticalScroll")
  self._ui.scroll_vertical_btn = UI.getChildControl(self._ui.scroll_vertical, "Frame_1_VerticalScroll_CtrlButton")
  self._ui.stc_subSelectBG = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_Sub_SelectStack")
  self._ui.stc_titleBG = UI.getChildControl(self._ui.stc_subSelectBG, "Static_Sub_TitleBar")
  self._ui.stc_title = UI.getChildControl(self._ui.stc_titleBG, "StaticText_1")
  self._ui.btn_selectListClose = UI.getChildControl(self._ui.stc_titleBG, "Button_Close")
  self._ui.list2_selectList = UI.getChildControl(self._ui.stc_subSelectBG, "List2_2")
  local listContetns = UI.getChildControl(self._ui.list2_selectList, "List2_2_Content")
  local itemButtonControl = UI.getChildControl(listContetns, "RadioButton_1")
  local itemSlotControl = UI.getChildControl(itemButtonControl, "Static_EquipListSlotBg")
  local slot = {}
  SlotItem.new(slot, "SelectListSlotIcon_" .. 0, 0, itemSlotControl, self._slotConfig)
  slot:createChild()
  slot.empty = true
  slot:clearItem()
  slot.border:SetSize(itemSlotControl:GetSizeX(), itemSlotControl:GetSizeY())
  self._ui.btn_apply = UI.getChildControl(Panel_Window_EnchantStack_All, "Button_1_Import")
  self._ui.stc_keyGuide = UI.getChildControl(Panel_Window_EnchantStack_All, "Static_ConsoleKeyGuide")
  self._ui.txt_guideIconB = UI.getChildControl(self._ui.stc_keyGuide, "StaticText_CancelButton_C")
  for index = 0, ToClient_GetStartStackSetSize() do
    local tempContent = UI.cloneControl(self._ui.stc_listGroup, self._ui.frame_content, "CategoryGroup_" .. index)
    if tempContent ~= nil then
      local tempCheckBox = UI.getChildControl(tempContent, "Static_GroupTitleBG")
      self._categoryList[index] = {}
      self._categoryList[index].content = tempContent
      self._categoryList[index].checkBox = tempCheckBox
      local tempCount = UI.getChildControl(tempCheckBox, "StaticText_CompletePercent")
      self._categoryList[index].countText = tempCount
      local text = UI.getChildControl(tempCheckBox, "StaticText_QuestName")
      self._categoryList[index].rangeText = text
      self._categoryList[index].content:SetShow(false)
      self._categoryList[index].isCollapsed = false
    end
  end
  self._ui.stc_slot:SetShow(false)
  self._ui.stc_slot:SetIgnore(false)
  self._ui.stc_radioButton_stack:SetCheck(true)
end
function PaGlobal_EnchantStack_All:setConsoleUI()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  self._ui.stc_keyGuide:SetShow(self._isConsole == true)
  self._ui.btn_close:SetShow(self._isConsole == false)
  self._ui.btn_question:SetShow(ToClient_isConsole() == false)
  local guideIconGroup = {
    self._ui.txt_guideIconB
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(guideIconGroup, self._ui.stc_keyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHTAUTOWRAP)
  self._ui.stc_keyGuide:ComputePos()
end
function PaGlobal_EnchantStack_All:prepareOpen(triedStack)
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  self._triedStack = triedStack
  self._ui.stc_radioButton_stack:SetCheck(true)
  self._ui.stc_radioButton_valksCry:SetCheck(false)
  self._ui.stc_subSelectBG:SetShow(false)
  PaGlobal_EnchantStack_All:open()
  PaGlobal_EnchantStack_All._ui.frame_itemList:GetVScroll():SetControlTop()
  ToClient_UpdateEnchantStackList()
  if Panel_OtherUser_AdditionalRate_All ~= nil and Panel_OtherUser_AdditionalRate_All:GetShow() == true then
    PaGlobalFunc_OtherUser_TriedStack_OnScreenResize()
    PaGlobal_OtherUser_TriedStack:open()
  end
  if self._isConsole == false then
    local showOtherUserEnchantAdditionalRate = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eShowOtherUserEnchantAdditionalRate)
    if showOtherUserEnchantAdditionalRate == false then
      self._ui.btn_othersChoice:EraseAllEffect()
      self._ui.btn_othersChoice:AddEffect("FUI_StackUserInfo_Button_01A", true, 0, 0)
    end
  end
end
function PaGlobal_EnchantStack_All:open()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  Panel_Window_EnchantStack_All:SetShow(true)
end
function PaGlobal_EnchantStack_All:prepareClose()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  TooltipSimple_Hide()
  Panel_Tooltip_Item_hideTooltip()
  ToClient_ClearEnchantStack()
  PaGlobalFunc_OtherUser_TriedStack_Close()
  PaGlobal_EnchantStack_All:close()
end
function PaGlobal_EnchantStack_All:close()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  Panel_Window_EnchantStack_All:SetShow(false)
end
function PaGlobal_EnchantStack_All:registEventHandler()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  registerEvent("FromClient_UpdateEnchantStack", "PaGlobalFunc_EnchantStack_Update")
  self._ui.list2_selectList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobal_EnchantStack_UpdateSelectList")
  self._ui.list2_selectList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui.btn_question:addInputEvent("Mouse_LUp", "Panel_WebHelper_ShowToggle( \"SpiritEnchant\" )")
  self._ui.btn_close:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_All_Close()")
  self._ui.stc_radioButton_stack:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_Update(true)")
  self._ui.stc_radioButton_valksCry:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_Update(true)")
  self._ui.btn_selectListClose:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_All_ListClose()")
  self._ui.btn_apply:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStack_All_Apply()")
  self._ui.btn_othersChoice:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantMain_OthersChoice()")
  self._ui.txt_normalStack:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_All_ChangeTabByType(false)")
  self._ui.txt_bonusStack:addInputEvent("Mouse_LUp", "PaGlobalFunc_EnchantStack_All_ChangeTabByType(true)")
  self._ui.btn_othersChoice:addInputEvent("Mouse_On", "PaGlobalFunc_EnchantStack_All_HandleOthersChoiceTooltip(true)")
  self._ui.btn_othersChoice:addInputEvent("Mouse_Out", "PaGlobalFunc_EnchantStack_All_HandleOthersChoiceTooltip(false)")
  if self._isConsole == true then
    Panel_Window_EnchantStack_All:registerPadEvent(__eConsoleUIPadEvent_Up_LB, "PaGlobalFunc_EnchantStack_All_ChangeTab()")
    Panel_Window_EnchantStack_All:registerPadEvent(__eConsoleUIPadEvent_Up_RB, "PaGlobalFunc_EnchantStack_All_ChangeTab()")
  end
end
function PaGlobal_EnchantStack_All:validate()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
end
function PaGlobal_EnchantStack_All:update(resetScroll)
  if nil == Panel_Window_EnchantStack_All or Panel_Window_EnchantStack_All:GetShow() == false then
    return
  end
  self:updateSelectBar()
  self:updateMainBackground()
  self:setItemSlots(resetScroll)
  self:updateApplyButton()
  ToClient_padSnapRefreshTarget(Panel_Window_EnchantStack_All)
end
function PaGlobal_EnchantStack_All:updateApplyButton()
  local isApplyAvailable = ToClient_GetCurrentEnchantStackIndex() ~= -1 or ToClient_GetCurrentValksCryIndex() ~= -1
  self._ui.btn_apply:SetMonoTone(isApplyAvailable == false)
  self._ui.btn_apply:SetIgnore(isApplyAvailable == false)
end
function PaGlobal_EnchantStack_All:updateMainBackground()
  local isValksCryTab = self._ui.stc_radioButton_valksCry:IsCheck()
  self._ui.txt_normalStack:SetText("+" .. ToClient_GetCurrentEnchantStackValue())
  self._ui.txt_bonusStack:SetText("+" .. ToClient_GetCurrentValksCryValue())
  self._ui.stc_normalArrow:SetShow(isValksCryTab == false)
  self._ui.stc_bonusArrow:SetShow(isValksCryTab == true)
  if isValksCryTab == true then
    self._ui.txt_selectRate:SetText(self._ui.txt_bonusStack:GetText())
  else
    local rateString = " (" .. tostring(PaGlobal_EnchantMain_All:getAdditionalSuccessRate(true)) .. "%)"
    self._ui.txt_selectRate:SetText(self._ui.txt_normalStack:GetText() .. rateString)
  end
  local currentConsumeRate = ToClient_GetCurrentStackSuccessRate()
  if isValksCryTab == false and currentConsumeRate > 0 then
    self._ui.txt_successRate:SetText(string.format("%.2f", currentConsumeRate / CppDefine.e1Percent) .. "%")
    self._ui.txt_successRate:SetShow(true)
    self._ui.txt_probability:SetShow(true)
    self._ui.txt_selectStack:SetPosXY(self._ui.txt_selectStack:GetPosX(), 160)
    self._ui.txt_selectRate:SetPosXY(self._ui.txt_selectRate:GetPosX(), 160)
    self._ui.txt_probability:SetPosXY(self._ui.txt_probability:GetPosX(), 195)
    self._ui.txt_successRate:SetPosXY(self._ui.txt_successRate:GetPosX(), 195)
  else
    self._ui.txt_successRate:SetShow(false)
    self._ui.txt_probability:SetShow(false)
    self._ui.txt_successRate:SetText("100%")
    self._ui.txt_selectStack:SetPosXY(self._ui.txt_selectStack:GetPosX(), 180)
    self._ui.txt_selectRate:SetPosXY(self._ui.txt_selectRate:GetPosX(), 180)
  end
end
function PaGlobal_EnchantStack_All:changeTab(isValksCryTab)
  self._ui.stc_radioButton_stack:SetCheck(isValksCryTab == false)
  self._ui.stc_radioButton_valksCry:SetCheck(isValksCryTab == true)
  self:update(true)
end
function PaGlobal_EnchantStack_All:updateSelectBar()
  if self._ui.stc_radioButton_valksCry:IsCheck() == true then
    self._ui.stc_selectBar:SetPosX(self._ui.stc_radioButton_valksCry:GetPosX() + (self._ui.stc_radioButton_valksCry:GetSizeX() - self._ui.stc_selectBar:GetSizeX()) * 0.5)
  else
    self._ui.stc_selectBar:SetPosX(self._ui.stc_radioButton_stack:GetPosX() + (self._ui.stc_radioButton_stack:GetSizeX() - self._ui.stc_selectBar:GetSizeX()) * 0.5)
  end
end
function PaGlobal_EnchantStack_All:setItemSlots(resetScroll)
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  PaGlobal_EnchantStack_All:resetSlot()
  local sizeY = PaGlobal_EnchantStack_All:setItemSlotsByList(self._ui.stc_radioButton_valksCry:IsCheck() == true)
  PaGlobal_EnchantStack_All:updateFrameContent(sizeY, resetScroll)
end
function PaGlobal_EnchantStack_All:setItemSlotsByList(isValksCryTab)
  local categoryStartPosY = 0
  local groupItemSlotIndex = 0
  local itemStartPosY = self.SLOT_OFFSET
  local categorySizeY = 50
  local sortedList = {}
  local itemCount = ToClient_GetEnchantStackListSize()
  self._valksAdviceEffectPos = nil
  self._ui.stc_select:SetShow(false)
  self._ui.frame_content:SetChildIndex(self._ui.stc_select, 9999)
  for index = 1, itemCount do
    local itemSS = ToClient_GetEnchantStackForLua(index - 1)
    if nil ~= itemSS and (itemSS:checkToValksCry() == true and isValksCryTab == true or itemSS:checkToValksCry() == false and isValksCryTab == false) then
      local showIndex = itemSS:getStartStackIndex()
      if sortedList[showIndex] == nil then
        sortedList[showIndex] = {}
      end
      sortedList[showIndex][#sortedList[showIndex] + 1] = index
    end
  end
  for showIndex = 0, ToClient_GetStartStackSetSize() do
    if sortedList[showIndex] ~= nil then
      self._categoryList[showIndex].content:SetShow(true)
      self._categoryList[showIndex].content:SetSpanSize(0, categoryStartPosY + 10)
      self._categoryList[showIndex].countText:SetText("(" .. #sortedList[showIndex] .. ")")
      self._categoryList[showIndex].checkBox:addInputEvent("Mouse_LUp", "HandleEventRUp_EnchantStack_CheckBox(" .. showIndex .. ")")
      local isCategoryAvailable = false
      groupItemSlotIndex = 0
      if self._categoryList[showIndex].isCollapsed == false then
        for _, realIndex in ipairs(sortedList[showIndex]) do
          local itemSS = ToClient_GetEnchantStackForLua(realIndex - 1)
          if itemSS ~= nil then
            if PaGlobal_EnchantStack_All._listItemSlots[realIndex] == nil then
              PaGlobal_EnchantStack_All._listItemSlots[realIndex] = PaGlobal_EnchantStack_All:createSlot(realIndex)
            end
            local slot = PaGlobal_EnchantStack_All._listItemSlots[realIndex]
            local row = math.floor(groupItemSlotIndex / self.COLUMN_PER_ROW)
            local col = groupItemSlotIndex % self.COLUMN_PER_ROW
            local itemPosY = self._categoryList[showIndex].content:GetPosY() + categorySizeY
            slot.iconBg:SetPosX(PaGlobal_EnchantStack_All.SLOT_OFFSET + PaGlobal_EnchantStack_All.SLOT_SIZE * col)
            slot.iconBg:SetPosY(itemPosY + PaGlobal_EnchantStack_All.SLOT_OFFSET + PaGlobal_EnchantStack_All.SLOT_SIZE * row)
            slot.iconBg:SetShow(true)
            slot:clearItem(true)
            slot:setItemByStaticStatus(itemSS, ToClient_GetEnchantStackCount(realIndex - 1))
            slot.icon:EraseAllEffect()
            if self._triedStack ~= nil and ToClient_isValksAdviceInRange(self._triedStack, realIndex - 1) == true then
              if self._valksAdviceEffectPos == nil then
                self._valksAdviceEffectPos = slot.iconBg:GetPosY()
              end
              slot.icon:AddEffect("fUI_NewItem02", true, 0, 0)
            end
            if ToClient_isConsole() == true then
              slot.iconBg:registerPadEvent(__eConsoleUIPadEvent_Up_X, "HandleEventOn_EnchantStack_Slot(" .. realIndex .. ", nil)")
            else
              slot.icon:addInputEvent("Mouse_On", "HandleEventOn_EnchantStack_Slot(" .. realIndex .. ", true)")
              slot.icon:addInputEvent("Mouse_Out", "HandleEventOn_EnchantStack_Slot(" .. realIndex .. ", false)")
            end
            local isAvailable = ToClient_IsEnchantStackAvailable(realIndex - 1)
            local isSelect = realIndex - 1 == ToClient_GetCurrentEnchantStackIndex() or realIndex - 1 == ToClient_GetCurrentValksCryIndex()
            if isAvailable == true then
              isCategoryAvailable = true
            end
            slot.iconBg:SetMonoTone(isAvailable == false)
            if (isAvailable == false and isSelect == false) == true then
              slot.icon:addInputEvent("Mouse_LUp", "")
            else
              slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStack_Slot(" .. realIndex .. ")")
              if self._isConsole == true then
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStack_Slot(" .. realIndex .. ")")
              end
            end
            if isSelect == true then
              self._ui.stc_select:SetPosXY(slot.iconBg:GetPosX() + 6, slot.iconBg:GetPosY() + 6)
              self._ui.stc_select:SetShow(true)
              slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStack_Clear()")
              if self._isConsole == true then
                slot.icon:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStack_Clear()")
              end
            end
            groupItemSlotIndex = groupItemSlotIndex + 1
            itemStartPosY = slot.iconBg:GetPosY()
            categoryStartPosY = itemStartPosY + categorySizeY
          end
        end
      else
        categoryStartPosY = categoryStartPosY + 60
      end
      self:setCheckBoxText(self._categoryList[showIndex].rangeText, showIndex, isCategoryAvailable)
    end
  end
  self._triedStack = nil
  return categoryStartPosY + 10
end
function PaGlobal_EnchantStack_All:updateFrameContent(sizeY, resetScroll)
  PaGlobal_EnchantStack_All._ui.frame_content:SetSize(PaGlobal_EnchantStack_All._ui.frame_content:GetSizeX(), sizeY)
  local tempSizeY = PaGlobal_EnchantStack_All._ui.scroll_vertical:GetSizeY() * (PaGlobal_EnchantStack_All.CONTENT_MIN_HEIGHT / PaGlobal_EnchantStack_All._ui.frame_content:GetSizeY())
  PaGlobal_EnchantStack_All._ui.scroll_vertical_btn:SetSize(PaGlobal_EnchantStack_All._ui.scroll_vertical_btn:GetSizeX(), tempSizeY)
  if self._valksAdviceEffectPos ~= nil then
    PaGlobal_EnchantStack_All._ui.frame_itemList:GetVScroll():SetControlPos(self._valksAdviceEffectPos / sizeY)
  elseif resetScroll == true then
    PaGlobal_EnchantStack_All._ui.frame_itemList:GetVScroll():SetControlTop()
  end
  PaGlobal_EnchantStack_All._ui.frame_itemList:UpdateContentScroll()
  PaGlobal_EnchantStack_All._ui.frame_itemList:UpdateContentPos()
end
function PaGlobal_EnchantStack_All:resetSlot()
  if nil == Panel_Window_EnchantStack_All then
    return
  end
  for ii = 0, ToClient_GetStartStackSetSize() do
    if self._categoryList[ii] ~= nil then
      self._categoryList[ii].content:SetShow(false)
    end
  end
  for index, slot in pairs(self._listItemSlots) do
    if slot ~= nil then
      slot:clearItem()
      slot.iconBg:SetShow(false)
      slot.icon:addInputEvent("Mouse_RUp", "")
      slot.icon:addInputEvent("Mouse_On", "")
      slot.icon:addInputEvent("Mouse_Out", "")
    end
  end
end
function PaGlobal_EnchantStack_All:createSlot(index)
  local keyString = "EnchantStack_SlotBG_"
  local itemSlotBg = UI.createAndCopyBasePropertyControl(PaGlobal_EnchantStack_All._ui.frame_content, "Static_ItemSlotBg", PaGlobal_EnchantStack_All._ui.frame_content, keyString .. tostring(index))
  local itemSlot = {}
  SlotItem.new(itemSlot, keyString .. tostring(index), index, itemSlotBg, PaGlobal_EnchantStack_All._slotConfig)
  itemSlot:createChild()
  itemSlot.iconBg = itemSlotBg
  itemSlotBg:SetShow(true)
  itemSlotBg:SetIgnore(false)
  itemSlot.icon:SetAutoDisableTime(0.5)
  return itemSlot
end
function PaGlobal_EnchantStack_All:setCheckBox(index)
  self._categoryList[index].isCollapsed = self._categoryList[index].isCollapsed == false
  self:update(false)
end
function PaGlobal_EnchantStack_All:setCheckBoxText(text, index, isAvailable)
  if isAvailable == true then
    text:SetFontColor(Defines.Color.C_FFDDC39E)
  else
    text:SetFontColor(Defines.Color.C_FFD05D48)
  end
  if self._ui.stc_radioButton_valksCry:IsCheck() == true then
    text:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ENCHANT_RENEWAL_STACK_BONUS", "value", tostring(ToClient_GetMaxValksCryStack())))
    return
  end
  if index == 0 then
    text:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_STACK_ZERO"))
    return
  end
  text:SetText(PAGetStringParam2(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_RENEWAL_STACK_RANGE", "start", tostring(ToClient_GetStartStackByIndex(index - 1)), "end", tostring(ToClient_GetMaxEnchantFailCount())))
end
function PaGlobal_EnchantStack_All:selectSlot(index)
  local itemSS = ToClient_GetEnchantStackForLua(index - 1)
  if itemSS == nil then
    return
  end
  self._ui.stc_subSelectBG:SetShow(false)
  if itemSS:isBlackStone() == true or itemSS:isCrystalizedDespair() == true then
    self:handleBlackStone(index)
    return
  end
  if itemSS:checkToValksCry() == true then
    Panel_NumberPad_Show(true, toInt64(0, ToClient_GetAvailableValksCryStack(index - 1)), index, HandleEventLUp_EnchantStack_All_SetCurrentEnchantStack)
    return
  end
  self:setCurrentEnchantStack(1, index)
end
function PaGlobal_EnchantStack_All:handleBlackStone(index)
  local itemSS = ToClient_GetEnchantStackForLua(index - 1)
  if itemSS == nil then
    return
  end
  local itemToFailCountSSW = getItemToFailCountStaticStatus(ItemEnchantKey(itemSS:getItemKey(), 0))
  if nil == itemToFailCountSSW then
    return
  end
  self._targetEnchantStackIndex = index
  local titleString = ""
  if itemSS:isBlackStone() == true then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_BLACK_WEAPON_SELECT")
  elseif itemSS:isCrystalizedDespair() == true then
    titleString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ENCHANT_ADD_BLACK_WEAPON_SELECT")
  end
  self._ui.stc_title:SetText(titleString)
  local blackStoneOrderList = {}
  for index = 0, itemToFailCountSSW:getSize() - 1 do
    local stackCount = itemToFailCountSSW:getStackCount(index)
    local blackStoneOrderData = {_listKey = index, _stackCount = stackCount}
    table.insert(blackStoneOrderList, blackStoneOrderData)
  end
  local sortFunc = function(a, b)
    return a._stackCount > b._stackCount
  end
  table.sort(blackStoneOrderList, sortFunc)
  self._ui.list2_selectList:getElementManager():clearKey()
  for key, data in pairs(blackStoneOrderList) do
    if nil ~= data then
      self._ui.list2_selectList:getElementManager():pushKey(toInt64(0, data._listKey))
    end
  end
  self._ui.stc_subSelectBG:SetShow(true)
end
function PaGlobal_EnchantStack_All:updateSelectList(contents, key)
  if nil == contents then
    return
  end
  local idx = Int64toInt32(key)
  local itemButtonControl = UI.getChildControl(contents, "RadioButton_1")
  local itemSlotControl = UI.getChildControl(itemButtonControl, "Static_EquipListSlotBg")
  local itemNameControl = UI.getChildControl(itemButtonControl, "StaticText_EquipName")
  local stackCountControl = UI.getChildControl(itemButtonControl, "StaticText_Stack")
  local mostStack = UI.getChildControl(itemButtonControl, "Static_Most")
  mostStack:SetShow(false)
  local itemSS = ToClient_GetEnchantStackForLua(self._targetEnchantStackIndex - 1)
  if itemSS == nil then
    return
  end
  local targetItemEnchantKey = ItemEnchantKey(itemSS:getItemKey(), 0)
  local itemToFailCountSSW = getItemToFailCountStaticStatus(targetItemEnchantKey)
  if nil == itemToFailCountSSW then
    return
  end
  local itemEnchantSSW = getItemEnchantStaticStatus(targetItemEnchantKey)
  if itemEnchantSSW == nil then
    return
  end
  local itemCount = itemToFailCountSSW:getItemCount(idx)
  local stackCount = itemToFailCountSSW:getStackCount(idx)
  local itemGradeColor = ConvertFromGradeToColor(itemEnchantSSW:getGradeType())
  local itemName = itemEnchantSSW:getName() .. " x " .. tostring(itemCount)
  itemNameControl:SetText(itemName)
  itemNameControl:SetFontColor(itemGradeColor)
  stackCountControl:SetText("+" .. tostring(stackCount))
  local slot = {}
  SlotItem.reInclude(slot, "SelectListSlotIcon_" .. 0, 0, itemSlotControl, self._slotConfig)
  slot:clearItem()
  slot:setItemByStaticStatus(itemEnchantSSW, itemCount)
  slot.icon:addInputEvent("Mouse_On", "")
  slot.icon:addInputEvent("Mouse_Out", "")
  local currentItemCount = PaGlobal_EnchantStack_All:getItemCount(CppEnums.ItemWhereType.eEnchantInventory, targetItemEnchantKey)
  itemButtonControl:SetCheck(false)
  if itemCount > currentItemCount then
    itemButtonControl:SetMonoTone(true)
    itemButtonControl:SetIgnore(true)
  else
    itemButtonControl:SetMonoTone(false)
    itemButtonControl:SetIgnore(false)
    itemButtonControl:addInputEvent("Mouse_LUp", "HandleEventLUp_EnchantStack_All_SetCurrentEnchantStack(" .. itemCount .. ", " .. self._targetEnchantStackIndex .. ")")
  end
end
function PaGlobal_EnchantStack_All:getItemCount(itemWhereType, itemEnchantKey)
  local inventory = self:getSelfInventory(itemWhereType)
  if nil == inventory then
    return 0
  end
  return Int64toInt32(inventory:getItemCount_s64(itemEnchantKey))
end
function PaGlobal_EnchantStack_All:getSelfInventory(whereType)
  local selfPlayerWrapper = getSelfPlayer()
  if nil == selfPlayerWrapper then
    return nil
  end
  local selfPlayer = selfPlayerWrapper:get()
  if nil == selfPlayer then
    return nil
  end
  return selfPlayer:getInventoryByType(whereType)
end
function PaGlobal_EnchantStack_All:setCurrentEnchantStack(count, index)
  if self._ui.stc_radioButton_valksCry:IsCheck() == true then
    local valksCryCount = Int64toInt32(count)
    ToClient_SetCurrentValksCry(index - 1, valksCryCount)
  else
    ToClient_SetCurrentEnchantStack(index - 1, count)
  end
  self._ui.stc_subSelectBG:SetShow(false)
end
function PaGlobal_EnchantStack_All:apply()
  ToClient_RequestConvertItemToStack()
end
function PaGlobal_EnchantStack_All:handleOthersChoiceTooltip(isShow)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local control = self._ui.btn_othersChoice
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_TITLE")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SPIRITENCHANT_OTHER_ADDITIONALRATE_TOOLTIP_DESC")
  TooltipSimple_Show(control, name, desc)
end
