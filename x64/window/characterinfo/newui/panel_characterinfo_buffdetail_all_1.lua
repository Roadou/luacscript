function PaGlobal_CharacterInfo_BuffDetail_All:initialize()
  if self._initialize == true then
    return
  end
  self._ui._listClass.stc_bg = UI.getChildControl(Panel_CharacterInfo_BuffDetail, "Static_ClassifiedBg")
  self._ui._listClass.txt_name = UI.getChildControl(self._ui._listClass.stc_bg, "StaticText_ClassifiedTitle")
  self._ui._listGroup.stc_bg = UI.getChildControl(Panel_CharacterInfo_BuffDetail, "Static_GroupMainBG")
  self._ui._listGroup.stc_icon = UI.getChildControl(self._ui._listGroup.stc_bg, "Static_BuffTypeIcon")
  self._ui._listGroup.txt_name = UI.getChildControl(self._ui._listGroup.stc_bg, "StaticText_BuffName")
  self._ui._listGroup.txt_value = UI.getChildControl(self._ui._listGroup.stc_bg, "StaticText_TotalValue")
  self._ui._listTemplate.stc_bg = UI.getChildControl(Panel_CharacterInfo_BuffDetail, "Static_GroupSubBG")
  self._ui._listTemplate.stc_top = UI.getChildControl(self._ui._listTemplate.stc_bg, "Static_TopCalculation")
  self._ui._listTemplate.stc_left = UI.getChildControl(self._ui._listTemplate.stc_bg, "Static_DetailListArea")
  self._ui._listTemplate.stc_right = UI.getChildControl(self._ui._listTemplate.stc_bg, "Static_RightBG")
  self._ui._listScroll.stc_bg = UI.getChildControl(Panel_CharacterInfo_BuffDetail, "Scroll_CheckQuestList")
  self._ui._listScroll.btn_Ctrl = UI.getChildControl(self._ui._listScroll.stc_bg, "Scroll_CtrlButton")
  self._ui._listGroup.stc_bg:SetShow(false)
  self._ui._listTemplate.stc_bg:SetShow(false)
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._ui.stc_KeyGuide_Bg = UI.getChildControl(Panel_CharacterInfo_BuffDetail, "Static_Console_Buttons")
  self._ui.stc_KeyGuide_A = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_A_ConsoleUI")
  self._ui.stc_KeyGuide_B = UI.getChildControl(self._ui.stc_KeyGuide_Bg, "StaticText_B_ConsoleUI")
  self._ui.stc_KeyGuide_Bg:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_A:SetShow(self._isConsole)
  self._ui.stc_KeyGuide_B:SetShow(self._isConsole)
  self:registEventHandler()
  self:validate()
  self._initialize = true
  self:initCreateControl()
end
function PaGlobal_CharacterInfo_BuffDetail_All:initCreateControl()
  for slotIdx = 1, self._config.slotMaxCount do
    local classSlot = {}
    local baseClassControl = self._ui._listClass.stc_bg
    classSlot.bg = UI.createAndCopyBasePropertyControl(Panel_CharacterInfo_BuffDetail, "Static_ClassifiedBg", Panel_CharacterInfo_BuffDetail, "BuffDetail_ClassifiedBg_" .. slotIdx)
    classSlot.text = UI.createAndCopyBasePropertyControl(baseClassControl, "StaticText_ClassifiedTitle", classSlot.bg, "BuffDetail_ClassTitle_" .. slotIdx)
    classSlot.bg:ComputePos()
    classSlot.bg:SetPosY((slotIdx - 1) * (classSlot.bg:GetSizeY() + 5) + 10)
    classSlot.bg:SetShow(true)
    classSlot.bg:SetIgnore(false)
    classSlot.bg:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
    classSlot.bg:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
    self._uiPool.classTitle[slotIdx] = classSlot
    local groupSlot = {}
    local baseGroupControl = self._ui._listGroup.stc_bg
    groupSlot.bg = UI.createAndCopyBasePropertyControl(Panel_CharacterInfo_BuffDetail, "Static_GroupMainBG", Panel_CharacterInfo_BuffDetail, "BuffDetail_GroupTitleBG_" .. slotIdx)
    groupSlot.typeIcon = UI.createAndCopyBasePropertyControl(baseGroupControl, "Static_BuffTypeIcon", groupSlot.bg, "BuffDetail_GroupTypeIcon_" .. slotIdx)
    groupSlot.text = UI.createAndCopyBasePropertyControl(baseGroupControl, "StaticText_BuffName", groupSlot.bg, "BuffDetail_GroupName_" .. slotIdx)
    groupSlot.totalValue = UI.createAndCopyBasePropertyControl(baseGroupControl, "StaticText_TotalValue", groupSlot.bg, "BuffDetail_GroupCompletePercent_" .. slotIdx)
    groupSlot.bg:ComputePos()
    groupSlot.bg:SetPosY((slotIdx - 1) * (groupSlot.bg:GetSizeY() + 5) + 10)
    groupSlot.bg:SetShow(true)
    groupSlot.bg:SetIgnore(false)
    UI.setLimitTextAndAddTooltip(groupSlot.text, groupSlot.text:GetText())
    groupSlot.bg:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
    groupSlot.bg:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
    groupSlot.typeIcon:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
    groupSlot.typeIcon:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
    groupSlot.text:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
    groupSlot.text:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
    groupSlot.totalValue:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
    groupSlot.totalValue:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
    self._uiPool.groupTitle[slotIdx] = groupSlot
    local listSlot = {}
    local baseListControl = self._ui._listTemplate.stc_bg
    listSlot.bg = UI.createAndCopyBasePropertyControl(Panel_CharacterInfo_BuffDetail, "Static_GroupSubBG", Panel_CharacterInfo_BuffDetail, "BuffDetail_ListMainBG_" .. slotIdx)
    listSlot.top = UI.cloneControl(UI.getChildControl(baseListControl, "Static_TopCalculation"), listSlot.bg, "BuffDetail_ListBuffFormula_Top_" .. slotIdx)
    listSlot.left = UI.cloneControl(UI.getChildControl(baseListControl, "Static_DetailListArea"), listSlot.bg, "BuffDetail_ListBuffFormula_Left_" .. slotIdx)
    listSlot.back = UI.cloneControl(UI.getChildControl(baseListControl, "Static_BackImage"), listSlot.bg, "BuffDetail_ListBuffFormula_Back_" .. slotIdx)
    listSlot.right = UI.cloneControl(UI.getChildControl(baseListControl, "Static_RightBG"), listSlot.bg, "BuffDetail_ListBuffFormula_Right_" .. slotIdx)
    listSlot.bg:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
    listSlot.bg:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
    if self._isConsole == false then
      listSlot.bg:ChangeClickTextureInfoNameAsync("")
      listSlot.bg:ChangeOnTextureInfoNameAsync("")
    end
    listSlot.bg:ComputePos()
    listSlot.top:ComputePos()
    listSlot.left:ComputePos()
    listSlot.right:ComputePos()
    listSlot.back:ComputePos()
    listSlot.bg:SetPosY((slotIdx - 1) * (groupSlot.bg:GetSizeY() + 5) + 10)
    listSlot.bg:SetShow(false)
    listSlot.bg:SetIgnore(false)
    UI.getChildControl(listSlot.right, "StaticText_Detail_Selected_Desc"):SetShow(false)
    UI.getChildControl(listSlot.right, "Static_Detail_Total_Icon"):SetShow(false)
    for ii = 1, self._config.descMaxCount do
      UI.getChildControl(listSlot.right, "StaticText_Detail_List_Template_" .. ii):SetShow(false)
    end
    local data = {}
    for dataIdx = 1, self._config.dataMaxCount do
      local datam = {name = nil, value = nil}
      local controlName = "StaticText_Detail_" .. self._numToVar[dataIdx]
      local control = UI.getChildControl(listSlot.left, controlName)
      local button = UI.getChildControl(control, "StaticText_Icon_" .. self._numToVar[dataIdx])
      button:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
      button:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
      control:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
      control:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
      datam.name = UI.getChildControl(control, controlName)
      datam.name:ComputePos()
      datam.name:SetShow(true)
      datam.name:SetIgnore(false)
      datam.name:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
      datam.name:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
      datam.value = UI.getChildControl(control, controlName .. "_Value")
      datam.value:ComputePos()
      datam.value:SetShow(true)
      datam.value:SetIgnore(false)
      datam.value:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
      datam.value:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
      data[dataIdx] = datam
    end
    listSlot.data = data
    self._uiPool.listMain[slotIdx] = listSlot
  end
  for k, v in ipairs(self._ui._listTemplate) do
    if v ~= nil then
      v:SetShow(false)
    end
  end
  for groupIdx = 1, #self._formulaData do
    self._groupOpen[groupIdx] = false
    local isHidden = false
    for _, value in pairs(self._hideOption) do
      if value == groupIdx then
        isHidden = true
        break
      end
    end
    if isHidden == false and self._formulaData[groupIdx].data ~= nil then
      self:parseStringToFormula(groupIdx)
    end
  end
end
function PaGlobal_CharacterInfo_BuffDetail_All:validate()
  self._ui._listClass.stc_bg:isValidate()
  self._ui._listClass.txt_name:isValidate()
  self._ui._listGroup.stc_bg:isValidate()
  self._ui._listGroup.stc_icon:isValidate()
  self._ui._listGroup.txt_name:isValidate()
  self._ui._listGroup.txt_value:isValidate()
  self._ui._listTemplate.stc_bg:isValidate()
  self._ui._listScroll.stc_bg:isValidate()
  self._ui._listScroll.btn_Ctrl:isValidate()
end
function PaGlobal_CharacterInfo_BuffDetail_All:switchPlatForm(console)
end
function PaGlobal_CharacterInfo_BuffDetail_All:registEventHandler()
  registerEvent("FromClient_UpdateBuffDetailBorad", "PaGlobalFunc_CharInfoBuffDetail_All_Update")
  UIScroll.InputEvent(self._ui._listScroll.stc_bg, "HandleEvent_BuffDetail_All_ListScroll")
  PaGlobal_CharInfo_All._ui.stc_BuffDetailBg:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll( true )")
  PaGlobal_CharInfo_All._ui.stc_BuffDetailBg:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll( false )")
end
function PaGlobal_CharacterInfo_BuffDetail_All:prepareOpen()
  self:update()
  self:open()
end
function PaGlobal_CharacterInfo_BuffDetail_All:open()
  Panel_CharacterInfo_BuffDetail:SetShow(true)
end
function PaGlobal_CharacterInfo_BuffDetail_All:prepareClose()
  self:close()
end
function PaGlobal_CharacterInfo_BuffDetail_All:close()
  Panel_CharacterInfo_BuffDetail:SetShow(false)
end
function PaGlobal_CharacterInfo_BuffDetail_All:dataClear()
end
function PaGlobal_CharacterInfo_BuffDetail_All:update()
  local arrayIdx = 1
  self._openedOffset = 1
  self._useArray = {}
  for groupIdx = 1, #self._formulaData do
    local isHidden = false
    for _, value in pairs(self._hideOption) do
      if value == groupIdx then
        isHidden = true
        break
      end
    end
    if isHidden == false then
      if self._formulaData[groupIdx].data ~= nil then
        self._useArray[arrayIdx] = {
          isClass = false,
          isGroup = true,
          title = self._formulaData[groupIdx].name,
          groupIdx = groupIdx,
          height = 0
        }
        arrayIdx = arrayIdx + 1
        if self._groupOpen[groupIdx] == true then
          self._useArray[arrayIdx] = {
            isClass = false,
            isGroup = false,
            title = "",
            groupIdx = groupIdx,
            height = 6
          }
          self._openedOffset = self._openedOffset + self._useArray[arrayIdx].height
          arrayIdx = arrayIdx + 1
        end
      else
        self._useArray[arrayIdx] = {
          isClass = true,
          isGroup = false,
          title = self._formulaData[groupIdx].name,
          groupIdx = groupIdx,
          height = 0
        }
        arrayIdx = arrayIdx + 1
      end
    end
  end
  for uiIdx = 1, self._config.slotMaxCount do
    self._uiPool.classTitle[uiIdx].bg:SetShow(false)
    self._uiPool.groupTitle[uiIdx].bg:SetShow(false)
    self._uiPool.listMain[uiIdx].bg:SetShow(false)
  end
  self._listCount = #self._useArray
  UIScroll.SetButtonSize(self._ui._listScroll.stc_bg, self._config.slotMaxCount, self._listCount + self._openedOffset - 1)
  local uiCount = 1
  for idx = self._startSlotIndex, self._listCount do
    if uiCount > self._config.slotMaxCount then
      break
    end
    if self._useArray[idx].isClass == true then
      self._uiPool.classTitle[uiCount].bg:SetShow(true)
      self._uiPool.classTitle[uiCount].text:SetText(self._useArray[idx].title)
      self._uiPool.classTitle[uiCount].bg:SetPosX(self._ui.scaleRatio * self._ui._listClass.stc_bg:GetPosX())
      self._uiPool.classTitle[uiCount].bg:SetPosY((uiCount - 1) * (self._ui._listClass.stc_bg:GetSizeY() + self._ui.scaleRatio * 5) + self._ui.scaleRatio * 10)
      if self._isConsole == true then
        if uiCount == 1 then
          self._uiPool.classTitle[uiCount].bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_BuffDetail_All_ListScroll(true)")
        elseif uiCount == self._config.slotMaxCount then
          self._uiPool.classTitle[uiCount].bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_BuffDetail_All_ListScroll(false)")
        end
      end
    elseif self._useArray[idx].isGroup == true then
      local typeKey = 0
      local isBarExpand = false
      typeKey = self._useArray[idx].groupIdx
      isBarExpand = self._groupOpen[typeKey]
      self._uiPool.groupTitle[uiCount].typeIcon:ChangeTextureInfoNameAsync("combine/etc/combine_etc_buffinfo.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(self._uiPool.groupTitle[uiCount].typeIcon, self._formulaData[typeKey].iconUV.x1, self._formulaData[typeKey].iconUV.y1, self._formulaData[typeKey].iconUV.x2, self._formulaData[typeKey].iconUV.y2)
      self._uiPool.groupTitle[uiCount].typeIcon:getBaseTexture():setUV(x1, y1, x2, y2)
      self._uiPool.groupTitle[uiCount].typeIcon:setRenderTexture(self._uiPool.groupTitle[uiCount].typeIcon:getBaseTexture())
      self._uiPool.groupTitle[uiCount].bg:SetShow(true)
      self._uiPool.groupTitle[uiCount].bg:SetCheck(isBarExpand)
      self._uiPool.groupTitle[uiCount].text:SetText(self._useArray[idx].title)
      self._uiPool.groupTitle[uiCount].bg:SetPosX(self._ui.scaleRatio * self._ui._listGroup.stc_bg:GetPosX())
      self._uiPool.groupTitle[uiCount].bg:SetPosY((uiCount - 1) * (self._ui._listGroup.stc_bg:GetSizeY() + self._ui.scaleRatio * 5) + self._ui.scaleRatio * 10)
      local totalValueFuncParams = self._formulaData[self._useArray[idx].groupIdx].totalParams
      if totalValueFuncParams ~= nil then
        self._uiPool.groupTitle[uiCount].totalValue:SetShow(true)
        self._uiPool.groupTitle[uiCount].totalValue:SetText(ToClient_getTotalBuffPercent(totalValueFuncParams[1], totalValueFuncParams[2]) .. "%")
      else
        self._uiPool.groupTitle[uiCount].totalValue:SetShow(false)
      end
      local opened = 0
      self._uiPool.groupTitle[uiCount].bg:addInputEvent("Mouse_LUp", "HandleEventLUp_BuffDetail_All_GroupTitleUpdateExpand(" .. self._useArray[idx].groupIdx - opened .. ")")
      if self._isConsole == true then
        if uiCount == 1 then
          self._uiPool.groupTitle[uiCount].bg:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_BuffDetail_All_ListScroll(true)")
        elseif uiCount == self._config.slotMaxCount then
          self._uiPool.groupTitle[uiCount].bg:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_BuffDetail_All_ListScroll(false)")
        end
      end
    else
      self._uiPool.listMain[uiCount].bg:SetShow(true)
      self._uiPool.listMain[uiCount].bg:SetPosX(self._ui.scaleRatio * self._ui._listGroup.stc_bg:GetPosX())
      self._uiPool.listMain[uiCount].bg:SetPosY((uiCount - 1) * (self._ui._listGroup.stc_bg:GetSizeY() + self._ui.scaleRatio * 5) + self._ui.scaleRatio * 10)
      self:setFormulaAndDetail(uiCount, self._useArray[idx].groupIdx)
      if self._isConsole == true then
        if uiCount == 1 then
          local control = UI.getChildControl(self._uiPool.listMain[uiCount].left, "StaticText_Detail_A")
          control:registerPadEvent(__eConsoleUIPadEvent_DpadUp, "HandleEvent_BuffDetail_All_ListScroll(true)")
        elseif uiCount == 6 then
          local lastIdx = #self._formulaData[self._useArray[idx].groupIdx].data
          local controlName = "StaticText_Detail_" .. self._numToVar[lastIdx]
          local control = UI.getChildControl(self._uiPool.listMain[uiCount].left, controlName)
          control:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_BuffDetail_All_ListScroll(false)")
          if self._formulaData[self._useArray[idx].groupIdx].data.desc == nil then
            self._uiPool.listMain[uiCount].right:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_BuffDetail_All_ListScroll(false)")
          else
            local rightControl = UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_List_Template_" .. #self._formulaData[self._useArray[idx].groupIdx].data.desc)
            rightControl:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "HandleEvent_BuffDetail_All_ListScroll(false)")
          end
        end
      end
      uiCount = uiCount + 6
    end
    uiCount = uiCount + 1
  end
  local posY = self._ui._listScroll.stc_bg:GetControlButton():GetPosY()
  local maxPosY = self._ui._listScroll.stc_bg:GetSizeY() - self._ui._listScroll.stc_bg:GetControlButton():GetSizeY()
  if posY > maxPosY then
    self._ui._listScroll.stc_bg:GetControlButton():SetPosY(maxPosY)
  end
end
function PaGlobal_CharacterInfo_BuffDetail_All:setFormulaAndDetail(uiCount, buffIdx)
  if buffIdx == nil or buffIdx < 1 or buffIdx >= self._listCount + #self._hideOption then
    return
  end
  for dataIdx = 1, self._config.dataMaxCount do
    local controlName = "StaticText_Detail_" .. self._numToVar[dataIdx]
    if dataIdx <= #self._formulaData[buffIdx].data then
      self._uiPool.listMain[uiCount].data[dataIdx].name:SetText(self._formulaData[buffIdx].data[dataIdx].name)
      self._uiPool.listMain[uiCount].data[dataIdx].name:SetShow(true)
      if buffIdx >= 22 and buffIdx < 28 and dataIdx == 3 or buffIdx == 28 and dataIdx == 2 then
        local func = self._formulaData[buffIdx].data[dataIdx].func
        local params = self._formulaData[buffIdx].data[dataIdx].params
        func(params[1])
        self._uiPool.listMain[uiCount].data[dataIdx].value:SetShow(false)
      else
        local func = self._formulaData[buffIdx].data[dataIdx].func
        local params = self._formulaData[buffIdx].data[dataIdx].params
        local unit = self._formulaData[buffIdx].data[dataIdx].unit
        local combined = ""
        if func ~= nil then
          local percent = func(params[1], params[2]) * 0.01
          if percent % 100 ~= 0 then
            combined = string.format("%.2f", percent * 0.01)
          else
            combined = tostring(percent * 0.01)
          end
          self._uiPool.listMain[uiCount].data[dataIdx].value:SetShow(true)
        elseif #params > 0 then
          combined = tostring(params[1])
          if dataIdx == 1 then
            self._uiPool.listMain[uiCount].data[dataIdx].value:SetShow(false)
          else
            self._uiPool.listMain[uiCount].data[dataIdx].value:SetShow(true)
          end
        else
          self._uiPool.listMain[uiCount].data[dataIdx].value:SetShow(false)
        end
        if unit ~= nil then
          combined = combined .. unit
        end
        self._uiPool.listMain[uiCount].data[dataIdx].value:SetText(combined)
      end
      local tokenIdx
      for ii = 1, #self._formulaData[buffIdx].parsed do
        local token = self._formulaData[buffIdx].format:sub(ii, ii)
        if token ~= nil and token == self._numToVar[dataIdx] then
          tokenIdx = ii
          break
        end
      end
      local dataControl = UI.getChildControl(self._uiPool.listMain[uiCount].left, controlName)
      dataControl:SetShow(true)
      dataControl:addInputEvent("Mouse_LDown", "HandleEventLDown_BuffDetail_All_UpdateDescArea(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ")")
      dataControl:addInputEvent("Mouse_On", "HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ", true)")
      dataControl:addInputEvent("Mouse_Out", "HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ", false)")
      local tokenIconControl = UI.getChildControl(dataControl, "StaticText_Icon_" .. self._numToVar[dataIdx])
      tokenIconControl:addInputEvent("Mouse_LDown", "HandleEventLDown_BuffDetail_All_UpdateDescArea(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ")")
      tokenIconControl:addInputEvent("Mouse_On", "HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ", true)")
      tokenIconControl:addInputEvent("Mouse_Out", "HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ", false)")
    else
      UI.getChildControl(self._uiPool.listMain[uiCount].left, controlName):SetShow(false)
      self._uiPool.listMain[uiCount].data[dataIdx].name:SetText("")
      self._uiPool.listMain[uiCount].data[dataIdx].name:SetShow(false)
      self._uiPool.listMain[uiCount].data[dataIdx].value:SetText("")
      self._uiPool.listMain[uiCount].data[dataIdx].value:SetShow(true)
      self._uiPool.listMain[uiCount].data[dataIdx].name:removeInputEvent("Mouse_LDown")
      self._uiPool.listMain[uiCount].data[dataIdx].name:removeInputEvent("Mouse_On")
      self._uiPool.listMain[uiCount].data[dataIdx].name:removeInputEvent("Mouse_Out")
    end
  end
  UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_Selected_Desc"):SetShow(false)
  UI.getChildControl(self._uiPool.listMain[uiCount].right, "Static_Detail_Total_Icon"):SetShow(false)
  for ii = 1, self._config.descMaxCount do
    UI.getChildControl(self._uiPool.listMain[uiCount].right, "StaticText_Detail_List_Template_" .. ii):SetShow(false)
  end
  self:resetSelectedEffect(uiCount, buffIdx)
  HandleEventLDown_BuffDetail_All_UpdateDescArea(uiCount, buffIdx, self._currentDescIndex.tokenIdx, self._currentDescIndex.dataIdx)
  self._ui._listTemplate.stc_top:SetShow(true)
  local dataIdx = 1
  for tokenIdx = 1, #self._formulaData[buffIdx].parsed do
    self._formulaData[buffIdx].parsed[tokenIdx]:SetShow(true)
    local posX = self._formulaData[buffIdx].parsed[tokenIdx]:GetSpanSize().x + self._ui.scaleRatio * self._ui._listGroup.stc_bg:GetPosX()
    local posY = self._formulaData[buffIdx].parsed[tokenIdx]:GetSpanSize().y + self._ui.scaleRatio * self._ui._listGroup.stc_bg:GetPosY() + (uiCount - 1) * (self._ui._listGroup.stc_bg:GetSizeY() + self._ui.scaleRatio * 5) + self._ui.scaleRatio * 28
    self._formulaData[buffIdx].parsed[tokenIdx]:SetPosX(posX)
    self._formulaData[buffIdx].parsed[tokenIdx]:SetPosY(posY)
    local token = self._formulaData[buffIdx].format:sub(tokenIdx, tokenIdx)
    if token ~= nil and string.find("ABCDEFGH", token, 1, true) ~= nil then
      self._formulaData[buffIdx].parsed[tokenIdx]:addInputEvent("Mouse_LDown", "HandleEventLDown_BuffDetail_All_UpdateDescArea(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ")")
      self._formulaData[buffIdx].parsed[tokenIdx]:addInputEvent("Mouse_On", "HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ", true)")
      self._formulaData[buffIdx].parsed[tokenIdx]:addInputEvent("Mouse_Out", "HandleEventOnOut_BuffDetail_All_TokenHighLightOnOff(" .. uiCount .. ", " .. buffIdx .. ", " .. tokenIdx .. ", " .. dataIdx .. ", false)")
      self._formulaData[buffIdx].parsed[tokenIdx]:addInputEvent("Mouse_UpScroll", "HandleEvent_BuffDetail_All_ListScroll(true)")
      self._formulaData[buffIdx].parsed[tokenIdx]:addInputEvent("Mouse_DownScroll", "HandleEvent_BuffDetail_All_ListScroll(false)")
      dataIdx = dataIdx + 1
    end
  end
  local keySpace = self._ui.scaleRatio * 5
  local keySize = self._ui.scaleRatio * 6
  local space = keySize + keySpace
  for _, value in ipairs(self._formulaData[buffIdx].parsed) do
    if value:GetShow() == true then
      value:SetPosX(keySpace + value:getChildControlCount() * keySize + self._ui.scaleRatio * 8)
      if string.len(value:GetText()) == 0 then
        keySpace = keySpace + space + (value:GetSizeX() - self._ui.scaleRatio * 4) / 2
      else
        keySpace = keySpace + space + self._ui.scaleRatio * math.min(value:GetTextSizeX(), 40)
      end
    end
  end
end
function PaGlobal_CharacterInfo_BuffDetail_All:parseStringToFormula(buffIdx)
  local formula = self._formulaData[buffIdx].format
  local parent = UI.getChildControl(self._ui._listTemplate.stc_bg, "Static_TopCalculation")
  for idx = 1, #formula do
    local token = formula:sub(idx, idx)
    if token == "(" then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "StaticText_LeftBracket"), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_" .. buffIdx .. "_" .. idx)
    elseif token == ")" then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "StaticText_RightBracket"), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_Var_" .. buffIdx .. "_" .. idx)
    elseif token == "*" then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "StaticText_Multiplecation"), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_Var_" .. buffIdx .. "_" .. idx)
    elseif token == "+" then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "StaticText_Plus"), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_Var_" .. buffIdx .. "_" .. idx)
    elseif token == "1" then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "StaticText_DefaultValue"), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_Var_" .. buffIdx .. "_" .. idx)
    elseif token == "2" then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "StaticText_VehicleExtraCoeff"), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_Var_" .. buffIdx .. "_" .. idx)
    elseif string.find("ABCDEFGH", token, 1, true) ~= nil then
      self._formulaData[buffIdx].parsed[idx] = UI.cloneControl(UI.getChildControl(parent, "Button_" .. token), Panel_CharacterInfo_BuffDetail, "BuffDetail_ListBuffFormula_Top_Var_" .. buffIdx .. "_" .. idx)
    else
      UI.ASSERT_NAME(false, "BuffDetail formula token is invalid. Cannot be replaced to control = " .. token, "\234\185\128\236\132\177\234\183\156")
    end
  end
end
function PaGlobal_CharacterInfo_BuffDetail_All:resetSelectedEffect(uiCount, groupIdx)
  if uiCount == nil or groupIdx == nil then
    return
  end
  for ii = 1, #self._formulaData[groupIdx].parsed do
    local token = self._formulaData[groupIdx].format:sub(ii, ii)
    if token ~= nil and string.find("ABCDEFGH", token, 1, true) ~= nil then
      UI.getChildControl(self._formulaData[groupIdx].parsed[ii], "Static_Selected"):SetShow(false)
      self._formulaData[groupIdx].parsed[ii]:setRenderTexture(self._formulaData[groupIdx].parsed[ii]:getBaseTexture())
    end
  end
  for ii = 1, self._config.dataMaxCount do
    local dataControl = UI.getChildControl(self._uiPool.listMain[uiCount].left, "StaticText_Detail_" .. self._numToVar[ii])
    local tokenIconControl = UI.getChildControl(dataControl, "StaticText_Icon_" .. self._numToVar[ii])
    dataControl:setRenderTexture(dataControl:getBaseTexture())
    tokenIconControl:setRenderTexture(tokenIconControl:getBaseTexture())
  end
end
function PaGlobal_CharacterInfo_BuffDetail_All:resizePanel()
  local currentX = getMousePosX()
  local currentY = getMousePosY()
  if self._ui.oriMousePosX == 0 then
    self._ui.oriMousePosX = currentX
    self._ui.oriMousePosY = currentY
  end
  local deltaX = currentX - self._ui.oriMousePosX
  local scaleX = Panel_CharacterInfo_All:GetScale().x
  local modifyScaleX = scaleX + deltaX * 0.0014
  if modifyScaleX < 0.5 then
    modifyScaleX = 0.5
  end
  if modifyScaleX > 1 then
    modifyScaleX = 1
  end
  self._ui.scaleRatio = modifyScaleX
  self._ui.oriMousePosX = currentX
  self._ui.oriMousePosY = currentY
  self:update()
end
