function PaGlobal_MessageBox_CrystalSet_All:initialize()
  if PaGlobal_MessageBox_CrystalSet_All._initialize == true or Panel_Window_MessageBox_CrystalSet_All == nil then
    return
  end
  self._ui.stc_textTitle = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Static_Text_Title")
  self._ui.btn_close = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Button_Close")
  self._ui.stc_bg = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Static_BG")
  self._ui.stc_textContent = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "StaticText_Content")
  self._ui.stc_changeBg = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Static_ChangeBg")
  self._ui.stc_beforeTitle = UI.getChildControl(self._ui.stc_changeBg, "StaticText_BeforeTitle")
  self._ui.stc_beforeTitleTemplate = UI.getChildControl(self._ui.stc_changeBg, "Static_BeforeSlotBg_Template")
  self._ui.stc_arrow = UI.getChildControl(self._ui.stc_changeBg, "Static_Arrow")
  self._ui.stc_afterTitle = UI.getChildControl(self._ui.stc_changeBg, "StaticText_AfterTitle")
  self._ui.stc_afterTitleTemplate = UI.getChildControl(self._ui.stc_changeBg, "Static_AfterSlotBg_Template")
  self._ui.stc_detailBg = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Static_DetailBg")
  self._ui.stc_textSubTitle = UI.getChildControl(self._ui.stc_detailBg, "StaticText_SubTitle")
  self._ui.stc_frame = UI.getChildControl(self._ui.stc_detailBg, "Frame_1")
  self._ui.stc_frameContent = UI.getChildControl(self._ui.stc_frame, "Frame_1_Content")
  self._ui.stc_textNameTemp = UI.getChildControl(self._ui.stc_frameContent, "StaticText_NameTemp")
  self._ui.stc_vScroll = UI.getChildControl(self._ui.stc_frame, "Frame_1_VerticalScroll")
  self._ui.btn_yes = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Button_Yes")
  self._ui.btn_no = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Button_No")
  self._ui.stc_consoleGuide = UI.getChildControl(Panel_Window_MessageBox_CrystalSet_All, "Static_BottomBg_ConsoleUI")
  self._isPadSnapping = _ContentsGroup_UsePadSnapping
  if isGameTypeRussia() or isGameServiceTypeTurkey() then
    self._exeptionLanguage = true
  end
  local languageType = ToClient_getResourceType()
  if nil ~= languageType then
    self._languageTypeString = Defines.LanguageTypeToString[languageType]
    if nil ~= self._languageTypeString and ("FR" == self._languageTypeString or "SP" == self._languageTypeString or "PT" == self._languageTypeString or "ES" == self._languageTypeString or "DE" == self._languageTypeString) then
      self._exeptionLanguage = true
    end
  end
  PaGlobal_MessageBox_CrystalSet_All:validate()
  PaGlobal_MessageBox_CrystalSet_All:registEventHandler()
  PaGlobal_MessageBox_CrystalSet_All:swichPlatform(self._isPadSnapping)
  for i = 0, __eJewelSlotMaxCount - 1 do
    local deleteTitle = UI.cloneControl(self._ui.stc_beforeTitleTemplate, self._ui.stc_changeBg, "Static_deleteSlotBg_" .. i .. "")
    deleteTitle:SetAlpha(0)
    self._deleteJewelSlotBgList[i] = deleteTitle
    local slot = {}
    slot = SlotItem.new(slot, "deleteJewelSet_Slot", i, deleteTitle, self._slotConfig)
    slot:createChild()
    slot.icon:SetIgnore(true)
    self._deleteJewelSlotList[i] = slot
  end
  for i = 0, __eJewelSlotMaxCount - 1 do
    local addTitle = UI.cloneControl(self._ui.stc_afterTitleTemplate, self._ui.stc_changeBg, "Static_addSlotBg_" .. i .. "")
    addTitle:SetAlpha(0)
    self._addJewelSlotBgList[i] = addTitle
    local slot = {}
    slot = SlotItem.new(slot, "addJewelSet_Slot", i, addTitle, self._slotConfig)
    slot:createChild()
    slot.icon:SetIgnore(true)
    self._addJewelSlotList[i] = slot
  end
  self._ui.stc_textNameTemp:SetIgnore(true)
  self._ui.stc_beforeTitleTemplate:SetShow(false)
  self._ui.stc_afterTitleTemplate:SetShow(false)
  if Panel_Window_MessageBox_CrystalSet_All ~= nil then
    Panel_Window_MessageBox_CrystalSet_All:SetPosX((getScreenSizeX() - Panel_Window_MessageBox_CrystalSet_All:GetSizeX()) * 0.5)
  end
  self._panelOriginSizeY = Panel_Window_MessageBox_CrystalSet_All:GetSizeY()
  self._stcBgOriginSizeY = self._ui.stc_bg:GetSizeY()
  self._stcChangeBgOriginSizeY = self._ui.stc_changeBg:GetSizeY()
  self._slotTemplateOriginPosX = self._ui.stc_afterTitleTemplate:GetPosX()
  self._slotTemplateOriginSizeX = self._ui.stc_afterTitleTemplate:GetSizeX()
  self._slotDeleteTemplateOriginPosY = self._ui.stc_beforeTitleTemplate:GetPosY()
  self._slotAddTemplateOriginPosY = self._ui.stc_afterTitleTemplate:GetPosY()
  self._stcArrowOriginPosY = self._ui.stc_arrow:GetPosY()
  self._stcAfterTitleOriginPosY = self._ui.stc_afterTitle:GetPosY()
  self._stcDetailBgOriginPosY = self._ui.stc_detailBg:GetPosY()
  self._stcDetailBgOriginSizeY = self._ui.stc_detailBg:GetSizeY()
  self._stcFrameOriginPosY = self._ui.stc_frame:GetPosY()
  self._stcFrameOriginSizeY = self._ui.stc_frame:GetSizeY()
  self._stcFrameContentOriginSizeY = self._ui.stc_frameContent:GetSizeY()
  self._stcFrameContentOriginPosY = self._ui.stc_frameContent:GetPosY()
  self._btnYesOriginPosY = self._ui.btn_yes:GetPosY()
  self._btnNoOriginPosY = self._ui.btn_no:GetPosY()
  self._stcConsoleGuidePosY = self._ui.stc_consoleGuide:GetPosY()
  PaGlobal_MessageBox_CrystalSet_All._initialize = true
end
function PaGlobal_MessageBox_CrystalSet_All:registEventHandler()
  self._ui.btn_close:addInputEvent("Mouse_LUp", "HandleEventLUp_MessageBox_CrystalSet_All_Close()")
  self._ui.btn_yes:addInputEvent("Mouse_LUp", "PaGlobalFunc_MessageBox_CrystalSet_All_ClickYes()")
  self._ui.btn_no:addInputEvent("Mouse_LUp", "HandleEventLUp_MessageBox_CrystalSet_All_Close()")
  if self._isPadSnapping == true then
    Panel_Window_MessageBox_CrystalSet_All:registerPadEvent(__eConsoleUIPadEvent_Up_A, "PaGlobalFunc_MessageBox_CrystalSet_All_ClickYes()")
    Panel_Window_MessageBox_CrystalSet_All:registerPadEvent(__eConsoleUIPadEvent_Up_B, "HandleEventLUp_MessageBox_CrystalSet_All_Close()")
    Panel_Window_MessageBox_CrystalSet_All:registerPadEvent(__eConsoleUIPadEvent_DpadDown, "ToClient_padSnapIgnoreGroupMove()")
    Panel_Window_MessageBox_CrystalSet_All:registerPadEvent(__eConsoleUIPadEvent_DpadRight, "ToClient_padSnapIgnoreGroupMove()")
  end
  registerEvent("onScreenResize", "FromClient_MessageBox_CrystalSet_All_OnScreenResize")
end
function PaGlobal_MessageBox_CrystalSet_All:swichPlatform(isConsole)
  if true == isConsole then
    self._ui.btn_close:SetShow(false)
    self._ui.stc_consoleGuide:SetShow(true)
    local consoleGuideA = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_A_ConsoleUI")
    local consoleGuideB = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_B_ConsoleUI")
    local consoleGuideScroll = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_RS_ConsoleUI")
    local tempBtnGroup = {
      consoleGuideScroll,
      consoleGuideA,
      consoleGuideB
    }
    PaGlobalFunc_ConsoleKeyGuide_SetAlign(tempBtnGroup, self._ui.stc_consoleGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  else
    self._ui.btn_close:SetShow(true)
    self._ui.stc_consoleGuide:SetShow(false)
  end
end
function PaGlobal_MessageBox_CrystalSet_All:prepareOpen()
  if Panel_Window_MessageBox_CrystalSet_All == nil and Panel_Window_MessageBox_CrystalSet_All:IsShow() == false then
    return
  end
  self._deleteJewelKeyList = {}
  self._addJewelKeyList = {}
  self._deleteJewelSlotNoList = {}
  self._addJewelSlotNoList = {}
  self._deleteJewelCount = 0
  self._addJewelCount = 0
  PaGlobal_MessageBox_CrystalSet_All:update()
  PaGlobal_MessageBox_CrystalSet_All:resize()
  PaGlobalFunc_JewelPreset_SetBlockBg(true)
  PaGlobal_MessageBox_CrystalSet_All:open()
end
function PaGlobal_MessageBox_CrystalSet_All:open()
  Panel_Window_MessageBox_CrystalSet_All:SetShow(true)
end
function PaGlobal_MessageBox_CrystalSet_All:prepareClose()
  Panel_Window_MessageBox_CrystalSet_All:SetSize(Panel_Window_MessageBox_CrystalSet_All:GetSizeX(), self._panelOriginSizeY)
  self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._stcBgOriginSizeY)
  self._ui.stc_changeBg:SetSize(self._ui.stc_changeBg:GetSizeX(), self._stcChangeBgOriginSizeY)
  for slotNo = 0, __eJewelSlotMaxCount - 1 do
    local title = self._deleteJewelSlotBgList[slotNo]
    if title ~= nil then
      title:SetPosXY(self._slotTemplateOriginPosX, self._slotDeleteTemplateOriginPosY)
      title:SetShow(false)
    end
    local slot = self._deleteJewelSlotList[slotNo]
    if slot ~= nil then
      slot:clearItem()
    end
  end
  for slotNo = 0, __eJewelSlotMaxCount - 1 do
    local title = self._addJewelSlotBgList[slotNo]
    if title ~= nil then
      title:SetPosXY(self._slotTemplateOriginPosX, self._slotAddTemplateOriginPosY)
      title:SetShow(false)
    end
    local slot = self._addJewelSlotList[slotNo]
    if slot ~= nil then
      slot:clearItem()
    end
  end
  self._ui.stc_arrow:SetPosY(self._stcArrowOriginPosY)
  self._ui.stc_afterTitle:SetPosY(self._stcAfterTitleOriginPosY)
  self._ui.stc_detailBg:SetPosY(self._stcDetailBgOriginPosY)
  self._ui.stc_detailBg:SetSize(self._ui.stc_detailBg:GetSizeX(), self._stcDetailBgOriginSizeY)
  self._ui.stc_frame:SetPosY(self._stcFrameOriginPosY)
  self._ui.stc_frame:SetSize(self._ui.stc_frame:GetSizeX(), self._stcFrameOriginSizeY)
  self._ui.stc_frameContent:SetSize(self._ui.stc_frameContent:GetSizeX(), self._stcFrameContentOriginSizeY)
  self._ui.stc_frameContent:SetPosY(self._stcFrameContentOriginPosY)
  self._ui.btn_yes:SetPosY(self._btnYesOriginPosY)
  self._ui.btn_no:SetPosY(self._btnNoOriginPosY)
  self._ui.stc_consoleGuide:SetPosY(self._stcConsoleGuidePosY)
  self._deleteJewelKeyList = {}
  self._addJewelKeyList = {}
  self._deleteJewelSlotNoList = {}
  self._addJewelSlotNoList = {}
  self._deleteJewelCount = 0
  self._addJewelCount = 0
  PaGlobalFunc_JewelPreset_SetBlockBg(false)
  PaGlobal_MessageBox_CrystalSet_All:close()
end
function PaGlobal_MessageBox_CrystalSet_All:close()
  Panel_Window_MessageBox_CrystalSet_All:SetShow(false)
end
function PaGlobal_MessageBox_CrystalSet_All:update()
  self:updateJewelIcon()
  self:updateJewelDetailBg()
end
function PaGlobal_MessageBox_CrystalSet_All:updateJewelIcon()
  local allDeleteJewelKeyList = {}
  local allDeleteJewelSlotNoList = {}
  local allAddJewelKeyList = {}
  local allAddJewelSlotNoList = {}
  local allDeleteJewelListCount = 0
  local allAddJewelListCount = 0
  for slotNo = 0, __eJewelSlotMaxCount - 1 do
    local deleteJewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(PaGlobal_JewelPreset._selectJewelPresetNo, slotNo)
    if deleteJewelItemSSW ~= nil then
      local itemKey = deleteJewelItemSSW:getItemKey()
      allDeleteJewelKeyList[allDeleteJewelListCount] = itemKey
      allDeleteJewelSlotNoList[allDeleteJewelListCount] = slotNo
      allDeleteJewelListCount = allDeleteJewelListCount + 1
    end
    local addJewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
    if addJewelItemSSW ~= nil then
      local itemKey = addJewelItemSSW:getItemKey()
      allAddJewelKeyList[allAddJewelListCount] = itemKey
      allAddJewelSlotNoList[allAddJewelListCount] = slotNo
      allAddJewelListCount = allAddJewelListCount + 1
    end
  end
  for deleteNum = 0, allDeleteJewelListCount - 1 do
    for addNum = 0, allAddJewelListCount - 1 do
      if allDeleteJewelKeyList[deleteNum] ~= nil and allAddJewelKeyList[addNum] ~= nil then
        local deleteKey = allDeleteJewelKeyList[deleteNum]
        local addKey = allAddJewelKeyList[addNum]
        if deleteKey == addKey then
          allDeleteJewelKeyList[deleteNum] = nil
          allDeleteJewelSlotNoList[deleteNum] = nil
          allAddJewelKeyList[addNum] = nil
          allAddJewelSlotNoList[addNum] = nil
        end
      end
    end
  end
  for deleteSlotNo = 0, allDeleteJewelListCount - 1 do
    if allDeleteJewelKeyList[deleteSlotNo] ~= nil then
      self._deleteJewelKeyList[self._deleteJewelCount] = allDeleteJewelKeyList[deleteSlotNo]
      self._deleteJewelSlotNoList[self._deleteJewelCount] = allDeleteJewelSlotNoList[deleteSlotNo]
      self._deleteJewelCount = self._deleteJewelCount + 1
    end
  end
  for addSlotNo = 0, allAddJewelListCount - 1 do
    if allAddJewelKeyList[addSlotNo] ~= nil then
      self._addJewelKeyList[self._addJewelCount] = allAddJewelKeyList[addSlotNo]
      self._addJewelSlotNoList[self._addJewelCount] = allAddJewelSlotNoList[addSlotNo]
      self._addJewelCount = self._addJewelCount + 1
    end
  end
  for i = 0, self._deleteJewelCount - 1 do
    if self._deleteJewelKeyList[i] ~= nil then
      local jewelSlotNo = self._deleteJewelSlotNoList[i]
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(PaGlobal_JewelPreset._selectJewelPresetNo, jewelSlotNo)
      if jewelItemSSW ~= nil then
        local slot = self._deleteJewelSlotList[i]
        if slot ~= nil then
          slot:setItemByStaticStatus(jewelItemSSW)
          local deleteTitle = self._deleteJewelSlotBgList[i]
          deleteTitle:SetShow(true)
        end
      end
    end
  end
  for i = 0, self._addJewelCount - 1 do
    if self._addJewelKeyList[i] ~= nil then
      local jewelSlotNo = self._addJewelSlotNoList[i]
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(jewelSlotNo)
      if jewelItemSSW ~= nil then
        local slot = self._addJewelSlotList[i]
        if slot ~= nil then
          slot:setItemByStaticStatus(jewelItemSSW)
          local addTitle = self._addJewelSlotBgList[i]
          addTitle:SetShow(true)
        end
      end
    end
  end
end
function PaGlobal_MessageBox_CrystalSet_All:updateJewelDetailBg()
  self._deleteTotalDesc = {}
  self._deleteBuffCount = 0
  self._addTotalDesc = {}
  self._addBuffCount = 0
  self._totalDesc = {}
  self._buffCount = 0
  local classType = getSelfPlayer():getClassType()
  local deleteJewelBuffTable = {}
  local addJewelBuffTable = {}
  for deleteSlotNo = 0, self._deleteJewelCount - 1 do
    if self._deleteJewelKeyList[deleteSlotNo] ~= nil then
      local jewelSlotNo = self._deleteJewelSlotNoList[deleteSlotNo]
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(PaGlobal_JewelPreset._selectJewelPresetNo, jewelSlotNo)
      if jewelItemSSW ~= nil then
        local data = {
          slotNo = jewelSlotNo,
          groupNumber = jewelItemSSW:getJewelGroupNumber()
        }
        table.insert(deleteJewelBuffTable, data)
      end
    end
  end
  for addSlotNo = 0, self._addJewelCount - 1 do
    if self._addJewelKeyList[addSlotNo] ~= nil then
      local jewelSlotNo = self._addJewelSlotNoList[addSlotNo]
      local jewelItemSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(jewelSlotNo)
      if jewelItemSSW ~= nil then
        local data = {
          slotNo = jewelSlotNo,
          groupNumber = jewelItemSSW:getJewelGroupNumber()
        }
        table.insert(addJewelBuffTable, data)
      end
    end
  end
  local sortFunction = function(data1, data2)
    if data1.groupNumber == data2.groupNumber then
      return data1.slotNo < data2.slotNo
    else
      return data1.groupNumber < data2.groupNumber
    end
  end
  table.sort(deleteJewelBuffTable, sortFunction)
  table.sort(addJewelBuffTable, sortFunction)
  local usingDeleteJewelCount = 0
  local usingAddJewelCount = 0
  for idx, data in pairs(deleteJewelBuffTable) do
    self:createDeleteDetailBg(data.slotNo, classType)
    usingDeleteJewelCount = usingDeleteJewelCount + 1
  end
  for idx, data in pairs(addJewelBuffTable) do
    self:createAddDetailBg(data.slotNo, classType)
    usingAddJewelCount = usingAddJewelCount + 1
  end
  self._buffCount = 0
  for i = 0, self._deleteBuffCount - 1 do
    self._totalDesc[self._buffCount] = self._deleteTotalDesc[i]
    self._buffCount = self._buffCount + 1
  end
  for i = 0, self._addBuffCount - 1 do
    self._totalDesc[self._buffCount] = self._addTotalDesc[i]
    self._buffCount = self._buffCount + 1
  end
  self:createWholeBuffDetailBg()
end
function PaGlobal_MessageBox_CrystalSet_All:createDeleteDetailBg(slotNo, classType)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromJewelPreset(PaGlobal_JewelPreset._selectJewelPresetNo, slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local buffList = ""
  local startIndex = 2
  for buffIdx = 0, skillSSW:getBuffCount() - 1 do
    local desc = skillSSW:getBuffDescription(buffIdx)
    if desc == nil or desc == "" then
      break
    end
    local plusStart, plusEnd = string.find(desc, "+")
    local minusStart, minusEnd = string.find(desc, "-")
    if plusStart ~= nil and minusStart ~= nil then
      local tempDesc = desc
      tempDesc = string.gsub(tempDesc, "+", "#")
      tempDesc = string.gsub(tempDesc, "-", "+")
      desc = string.gsub(tempDesc, "#", "-")
    elseif plusStart ~= nil then
      local tempDesc = desc
      desc = string.gsub(tempDesc, "+", "-")
    elseif minusStart ~= nil then
      local tempDesc = desc
      desc = string.gsub(tempDesc, "-", "+")
    end
    if buffList == nil or buffList == "" then
      buffList = desc
    else
      buffList = buffList .. " / " .. desc
    end
    if self._exeptionLanguage == true then
      local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
      exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
      if isGameServiceTypeTurkey() then
        exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
      end
      if exeption > 0 then
        self._deleteTotalDesc[self._deleteBuffCount] = desc
        local count = 0
        local count1 = select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], ",", ","))
        local count2 = select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], "&", "&"))
        if count1 < count2 then
          self._separationCharater = "&"
          count = count2
        else
          self._separationCharater = ","
          count = count1
        end
        if count > 0 then
          local temp = self._deleteTotalDesc[self._deleteBuffCount]
          for index = 1, exeption do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            if nil ~= cIndex1 then
              self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex1 - 1)
              if 0 == select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], "%d", "%d")) then
                temp = string.sub(temp, cIndex2 + startIndex, -1)
                self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex1 - 1)
              end
              temp = string.sub(temp, cIndex2 + startIndex, -1)
              self._deleteBuffCount = self._deleteBuffCount + 1
            else
              local cIndex1, cIndex2 = string.find(temp, "LT")
              if nil == cIndex1 then
                cIndex1, cIndex2 = string.find(temp, "%d+")
                if nil ~= cIndex1 then
                  self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._deleteBuffCount = self._deleteBuffCount + 1
                end
              else
                self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex2)
                temp = string.sub(temp, cIndex2, -1)
                self._deleteBuffCount = self._deleteBuffCount + 1
              end
            end
          end
        else
          self._deleteBuffCount = self._deleteBuffCount + 1
        end
      end
    else
      local exeption = select(2, string.gsub(desc, "%d", "%d"))
      if exeption > 0 then
        self._deleteTotalDesc[self._deleteBuffCount] = desc
        local count = select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], self._separationCharater, self._separationCharater))
        if count > 0 then
          local temp = self._deleteTotalDesc[self._deleteBuffCount]
          for index = 1, count do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex1 - 1)
            temp = string.sub(temp, cIndex2 + startIndex, -1)
            self._deleteBuffCount = self._deleteBuffCount + 1
          end
        else
          self._deleteBuffCount = self._deleteBuffCount + 1
        end
      end
    end
  end
  local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(classType)
  if subSkillSSW ~= nil then
    for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
      local desc = subSkillSSW:getBuffDescription(buffIdx)
      if desc == nil or desc == "" then
        break
      end
      local plusStart, plusEnd = string.find(desc, "+")
      local minusStart, minusEnd = string.find(desc, "-")
      if plusStart ~= nil and minusStart ~= nil then
        local tempDesc = desc
        tempDesc = string.gsub(tempDesc, "+", "#")
        tempDesc = string.gsub(tempDesc, "-", "+")
        desc = string.gsub(tempDesc, "#", "-")
      elseif plusStart ~= nil then
        local tempDesc = desc
        desc = string.gsub(tempDesc, "+", "-")
      elseif minusStart ~= nil then
        local tempDesc = desc
        desc = string.gsub(tempDesc, "-", "+")
      end
      if buffList == nil or buffList == "" then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
      if self._exeptionLanguage == true then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._deleteTotalDesc[self._deleteBuffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], ",", ","))
          local count2 = select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._deleteTotalDesc[self._deleteBuffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + startIndex, -1)
                  self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + startIndex, -1)
                self._deleteBuffCount = self._deleteBuffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._deleteBuffCount = self._deleteBuffCount + 1
                  end
                else
                  self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._deleteBuffCount = self._deleteBuffCount + 1
                end
              end
            end
          else
            self._deleteBuffCount = self._deleteBuffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._deleteTotalDesc[self._deleteBuffCount] = desc
          local count = select(2, string.gsub(self._deleteTotalDesc[self._deleteBuffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._deleteTotalDesc[self._deleteBuffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._deleteTotalDesc[self._deleteBuffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + startIndex, -1)
              self._deleteBuffCount = self._deleteBuffCount + 1
            end
          else
            self._deleteBuffCount = self._deleteBuffCount + 1
          end
        end
      end
    end
  end
end
function PaGlobal_MessageBox_CrystalSet_All:createAddDetailBg(slotNo, classType)
  local itemEnchantSSW = ToClient_GetJewelStaticStatusWrapperFromSelectedJewelPreset(slotNo)
  if itemEnchantSSW == nil then
    return
  end
  local skillSSW = itemEnchantSSW:getSkillByIdx(classType)
  if skillSSW == nil then
    return
  end
  local buffList = ""
  local startIndex = 2
  for buffIdx = 0, skillSSW:getBuffCount() - 1 do
    local desc = skillSSW:getBuffDescription(buffIdx)
    if desc == nil or desc == "" then
      break
    end
    if buffList == nil or buffList == "" then
      buffList = desc
    else
      buffList = buffList .. " / " .. desc
    end
    if self._exeptionLanguage == true then
      local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
      exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
      if isGameServiceTypeTurkey() then
        exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
      end
      if exeption > 0 then
        self._addTotalDesc[self._addBuffCount] = desc
        local count = 0
        local count1 = select(2, string.gsub(self._addTotalDesc[self._addBuffCount], ",", ","))
        local count2 = select(2, string.gsub(self._addTotalDesc[self._addBuffCount], "&", "&"))
        if count1 < count2 then
          self._separationCharater = "&"
          count = count2
        else
          self._separationCharater = ","
          count = count1
        end
        if count > 0 then
          local temp = self._addTotalDesc[self._addBuffCount]
          for index = 1, exeption do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            if nil ~= cIndex1 then
              self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex1 - 1)
              if 0 == select(2, string.gsub(self._addTotalDesc[self._addBuffCount], "%d", "%d")) then
                temp = string.sub(temp, cIndex2 + startIndex, -1)
                self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex1 - 1)
              end
              temp = string.sub(temp, cIndex2 + startIndex, -1)
              self._addBuffCount = self._addBuffCount + 1
            else
              local cIndex1, cIndex2 = string.find(temp, "LT")
              if nil == cIndex1 then
                cIndex1, cIndex2 = string.find(temp, "%d+")
                if nil ~= cIndex1 then
                  self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._addBuffCount = self._addBuffCount + 1
                end
              else
                self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex2)
                temp = string.sub(temp, cIndex2, -1)
                self._addBuffCount = self._addBuffCount + 1
              end
            end
          end
        else
          self._addBuffCount = self._addBuffCount + 1
        end
      end
    else
      local exeption = select(2, string.gsub(desc, "%d", "%d"))
      if exeption > 0 then
        self._addTotalDesc[self._addBuffCount] = desc
        local count = select(2, string.gsub(self._addTotalDesc[self._addBuffCount], self._separationCharater, self._separationCharater))
        if count > 0 then
          local temp = self._addTotalDesc[self._addBuffCount]
          for index = 1, count do
            local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
            self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex1 - 1)
            temp = string.sub(temp, cIndex2 + startIndex, -1)
            self._addBuffCount = self._addBuffCount + 1
          end
        else
          self._addBuffCount = self._addBuffCount + 1
        end
      end
    end
  end
  local subSkillSSW = itemEnchantSSW:getSubSkillByIdx(classType)
  if subSkillSSW ~= nil then
    for buffIdx = 0, subSkillSSW:getBuffCount() - 1 do
      local desc = subSkillSSW:getBuffDescription(buffIdx)
      if desc == nil or desc == "" then
        break
      end
      if buffList == nil or buffList == "" then
        buffList = desc
      else
        buffList = buffList .. " / " .. desc
      end
      if self._exeptionLanguage == true then
        local exeption = select(2, string.gsub(desc, "+%d", "+%d"))
        exeption = exeption + select(2, string.gsub(desc, "-%d", "-%d"))
        if isGameServiceTypeTurkey() then
          exeption = exeption + select(2, string.gsub(desc, "+%%%d", "+%%%d"))
        end
        if exeption > 0 then
          self._addTotalDesc[self._addBuffCount] = desc
          local count = 0
          local count1 = select(2, string.gsub(self._addTotalDesc[self._addBuffCount], ",", ","))
          local count2 = select(2, string.gsub(self._addTotalDesc[self._addBuffCount], "&", "&"))
          if count1 < count2 then
            self._separationCharater = "&"
            count = count2
          else
            self._separationCharater = ","
            count = count1
          end
          if count > 0 then
            local temp = self._addTotalDesc[self._addBuffCount]
            for index = 1, exeption do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              if nil ~= cIndex1 then
                self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex1 - 1)
                if 0 == select(2, string.gsub(self._addTotalDesc[self._addBuffCount], "%d", "%d")) then
                  temp = string.sub(temp, cIndex2 + startIndex, -1)
                  self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex1 - 1)
                end
                temp = string.sub(temp, cIndex2 + startIndex, -1)
                self._addBuffCount = self._addBuffCount + 1
              else
                local cIndex1, cIndex2 = string.find(temp, "LT")
                if nil == cIndex1 then
                  cIndex1, cIndex2 = string.find(temp, "%d+")
                  if nil ~= cIndex1 then
                    self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex2)
                    temp = string.sub(temp, cIndex2, -1)
                    self._addBuffCount = self._addBuffCount + 1
                  end
                else
                  self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex2)
                  temp = string.sub(temp, cIndex2, -1)
                  self._addBuffCount = self._addBuffCount + 1
                end
              end
            end
          else
            self._addBuffCount = self._addBuffCount + 1
          end
        end
      else
        local exeption = select(2, string.gsub(desc, "%d", "%d"))
        if exeption > 0 then
          self._addTotalDesc[self._addBuffCount] = desc
          local count = select(2, string.gsub(self._addTotalDesc[self._addBuffCount], self._separationCharater, self._separationCharater))
          if count > 0 then
            local temp = self._addTotalDesc[self._addBuffCount]
            for index = 1, count do
              local cIndex1, cIndex2 = string.find(temp, self._separationCharater)
              self._addTotalDesc[self._addBuffCount] = string.sub(temp, 1, cIndex1 - 1)
              temp = string.sub(temp, cIndex2 + startIndex, -1)
              self._addBuffCount = self._addBuffCount + 1
            end
          else
            self._addBuffCount = self._addBuffCount + 1
          end
        end
      end
    end
  end
end
function PaGlobal_MessageBox_CrystalSet_All:createWholeBuffDetailBg()
  if self._buffCount <= 0 then
    self._ui.stc_detailBg:SetShow(false)
    self._ui.stc_textNameTemp:SetText("")
    return
  end
  self._ui.stc_detailBg:SetShow(true)
  local temp1, temp2, temp3 = {}, {}, {}
  for index = 0, #self._totalDesc do
    local cIndex1, cIndex2 = string.find(self._totalDesc[index], "+")
    if nil ~= cIndex1 or nil ~= cIndex2 then
      temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
      local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
      temp2[index] = tonumber(string.match(backString, "[%d%.]+"))
    else
      cIndex1, cIndex2 = string.find(self._totalDesc[index], "-")
      if nil ~= cIndex1 or nil ~= cIndex2 then
        temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
        local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
        temp2[index] = tonumber(string.match(backString, "[%d%.]+")) * -1
      else
        cIndex1, cIndex2 = string.find(self._totalDesc[index], "[%d%.]")
        if nil ~= cIndex1 then
          temp1[index] = string.gsub(string.sub(self._totalDesc[index], 1, cIndex1 - 1), " ", "")
          local backString = string.gsub(string.sub(self._totalDesc[index], cIndex2, string.len(self._totalDesc[index])), " ", "")
          temp2[index] = tonumber(string.match(backString, "[%d%.]+"))
        end
      end
    end
  end
  local temp = {}
  local buffCategoryCount = 0
  for index = 0, #self._totalDesc do
    if buffCategoryCount > 0 then
      local isSame = false
      for ii = 0, buffCategoryCount - 1 do
        local compareIndex = temp[ii]
        if temp1[compareIndex] == temp1[index] and false == isSame then
          if nil ~= temp3[ii] then
            temp3[ii] = temp3[ii] + temp2[index]
          end
          isSame = true
        end
      end
      if false == isSame then
        temp[buffCategoryCount] = index
        temp3[buffCategoryCount] = temp2[index]
        buffCategoryCount = buffCategoryCount + 1
      end
    else
      temp[buffCategoryCount] = index
      temp3[buffCategoryCount] = temp2[index]
      buffCategoryCount = buffCategoryCount + 1
    end
  end
  for index = 0, buffCategoryCount - 1 do
    if temp3[index] == 0 then
      temp[index] = nil
      temp3[index] = nil
    end
  end
  local function jewelSubUICreate(index)
    if self._effectDesc[index] == nil then
      self._effectDesc[index] = UI.createAndCopyBasePropertyControl(self._ui.stc_frameContent, "StaticText_NameTemp", self._ui.stc_frameContent, "StaticText_EffectDesc_" .. index)
      self._effectDesc[index]:SetTextMode(__eTextMode_AutoWrap)
    end
  end
  if 0 < self._beforeCount then
    for index = 0, self._beforeCount - 1 do
      self._effectDesc[index]:SetShow(false)
    end
  end
  for index = 0, buffCategoryCount - 1 do
    if temp3[index] ~= nil then
      if temp3[index] >= 0 then
        local minusCount = select(2, string.gsub(self._totalDesc[temp[index]], "-[%d%.]", "-[%d%.]"))
        if minusCount > 0 then
          for ii = 1, minusCount do
            if minusCount == ii then
              self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "+")
            end
          end
        end
        local plusCount = select(2, string.gsub(self._totalDesc[temp[index]], "+", "+"))
        if plusCount > 0 then
          local index1, index2 = string.find(self._totalDesc[temp[index]], "+")
          local frontString = string.sub(self._totalDesc[temp[index]], 1, index1 - 1)
          local backString = string.sub(self._totalDesc[temp[index]], index2, string.len(self._totalDesc[temp[index]]))
          backString = string.gsub(backString, "[%d%.]+", temp3[index])
          self._totalDesc[temp[index]] = frontString .. backString
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "<PAColor0xffffec80>+")
        else
          self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "[%d%.]+", "<PAColor0xffffec80>+" .. temp3[index])
        end
      else
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "+", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "-", "")
        self._totalDesc[temp[index]] = string.gsub(self._totalDesc[temp[index]], "[%d%.]+", "<PAColor0xffffec80>" .. temp3[index])
      end
      self._totalDesc[temp[index]] = self._totalDesc[temp[index]] .. "<PAOldColor>"
      local tempStart, tempEnd = string.find(self._totalDesc[temp[index]], "-")
      if tempStart ~= nil then
        local tempDesc = self._totalDesc[temp[index]]
        self._totalDesc[temp[index]] = string.gsub(tempDesc, "<PAColor0xffffec80>", "<PAColor0xffff5555>")
      end
    end
    if index >= self._beforeCount then
      jewelSubUICreate(index)
    end
    if temp[index] ~= nil then
      self._effectDesc[index]:SetText(self._totalDesc[temp[index]])
      self._effectDesc[index]:SetShow(true)
    end
  end
  local effectDescOrder = 0
  local effectDescOrderTable = {}
  for index = 0, buffCategoryCount - 1 do
    if temp[index] ~= nil then
      local tempStart, tempEnd = string.find(self._totalDesc[temp[index]], "-")
      if tempStart ~= nil then
        effectDescOrderTable[effectDescOrder] = self._effectDesc[index]
        if effectDescOrder == 0 then
          effectDescOrderTable[effectDescOrder]:SetPosY(self._ui.stc_textNameTemp:GetPosY())
        else
          effectDescOrderTable[effectDescOrder]:SetPosY(effectDescOrderTable[effectDescOrder - 1]:GetPosY() + math.max(20, effectDescOrderTable[effectDescOrder - 1]:GetTextSizeY()))
        end
        effectDescOrder = effectDescOrder + 1
      end
    end
  end
  local addGap = 30
  for index = 0, buffCategoryCount - 1 do
    if temp[index] ~= nil then
      local tempStart, tempEnd = string.find(self._totalDesc[temp[index]], "+")
      if tempStart ~= nil then
        effectDescOrderTable[effectDescOrder] = self._effectDesc[index]
        if effectDescOrder == 0 then
          effectDescOrderTable[effectDescOrder]:SetPosY(self._ui.stc_textNameTemp:GetPosY())
        else
          effectDescOrderTable[effectDescOrder]:SetPosY(effectDescOrderTable[effectDescOrder - 1]:GetPosY() + math.max(20, effectDescOrderTable[effectDescOrder - 1]:GetTextSizeY()))
        end
        effectDescOrder = effectDescOrder + 1
      end
    end
  end
  self._beforeCount = buffCategoryCount
  self._ui.stc_frameContent:SetSize(self._ui.stc_frameContent:GetSizeX(), buffCategoryCount * math.max(20, self._effectDesc[buffCategoryCount - 1]:GetTextSizeY()) + 10)
end
function PaGlobal_MessageBox_CrystalSet_All:resize()
  local deleteRowCount = 0
  if 0 < self._deleteJewelCount and self._deleteJewelCount <= 7 then
    local isDeleteOdd = self._deleteJewelCount % 2 == 1
    local startPosX = 0
    if isDeleteOdd == true then
      startPosX = -(self._slotTemplateOriginSizeX + 10) * ((self._deleteJewelCount - 1) / 2)
    else
      startPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (self._deleteJewelCount / 2 - 1)
    end
    for slotNo = 0, self._deleteJewelCount - 1 do
      local title = self._deleteJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (startPosX + slotNo * (self._slotTemplateOriginSizeX + 10))
      title:SetPosX(PosX)
    end
  elseif self._deleteJewelCount > 7 and self._deleteJewelCount <= 14 then
    local firstNum = math.floor(self._deleteJewelCount / 2) + self._deleteJewelCount % 2
    local secondNum = self._deleteJewelCount - firstNum
    local isFirstDeleteOdd = firstNum % 2 == 1
    local isSecondDeleteOdd = secondNum % 2 == 1
    local firstStartPosX = 0
    local secondStartPosX = 0
    if isFirstDeleteOdd == true then
      firstStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((firstNum - 1) / 2)
    else
      firstStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (firstNum / 2 - 1)
    end
    if isSecondDeleteOdd == true then
      secondStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((secondNum - 1) / 2)
    else
      secondStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (secondNum / 2 - 1)
    end
    for slotNo = 0, firstNum - 1 do
      local title = self._deleteJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (firstStartPosX + slotNo * (self._slotTemplateOriginSizeX + 10))
      title:SetPosX(PosX)
    end
    for slotNo = firstNum, firstNum + secondNum - 1 do
      local title = self._deleteJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (secondStartPosX + (slotNo - firstNum) * (self._slotTemplateOriginSizeX + 10))
      local PosY = title:GetPosY() + title:GetSizeY() + 10
      title:SetPosXY(PosX, PosY)
      title:SetPosX(PosX)
    end
    deleteRowCount = deleteRowCount + 1
  elseif self._deleteJewelCount > 14 and self._deleteJewelCount <= __eJewelSlotMaxCount - 1 then
    local firstNum = math.floor(self._deleteJewelCount / 3)
    local secondNum = math.floor(self._deleteJewelCount / 3)
    local thirdNum = math.floor(self._deleteJewelCount / 3)
    local rest = self._deleteJewelCount % 3
    for i = 0, rest - 1 do
      if i % 3 == 0 then
        firstNum = firstNum + 1
      elseif i % 3 == 1 then
        secondNum = secondNum + 1
      elseif i % 3 == 2 then
        thirdNum = thirdNum + 1
      end
    end
    local isFirstDeleteOdd = firstNum % 2 == 1
    local isSecondDeleteOdd = secondNum % 2 == 1
    local isThirdDeleteOdd = thirdNum % 2 == 1
    local firstStartPosX = 0
    local secondStartPosX = 0
    local thirdStartPosX = 0
    if isFirstDeleteOdd == true then
      firstStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((firstNum - 1) / 2)
    else
      firstStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (firstNum / 2 - 1)
    end
    if isSecondDeleteOdd == true then
      secondStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((secondNum - 1) / 2)
    else
      secondStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (secondNum / 2 - 1)
    end
    if isThirdDeleteOdd == true then
      thirdStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((thirdNum - 1) / 2)
    else
      thirdStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (thirdNum / 2 - 1)
    end
    for slotNo = 0, firstNum - 1 do
      local title = self._deleteJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (firstStartPosX + slotNo * (self._slotTemplateOriginSizeX + 10))
      title:SetPosX(PosX)
    end
    for slotNo = firstNum, firstNum + secondNum - 1 do
      local title = self._deleteJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (secondStartPosX + (slotNo - firstNum) * (self._slotTemplateOriginSizeX + 10))
      local PosY = title:GetPosY() + title:GetSizeY() + 10
      title:SetPosXY(PosX, PosY)
      title:SetPosX(PosX)
    end
    for slotNo = firstNum + secondNum, firstNum + secondNum + thirdNum - 1 do
      local title = self._deleteJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (thirdStartPosX + (slotNo - firstNum - secondNum) * (self._slotTemplateOriginSizeX + 10))
      local PosY = title:GetPosY() + title:GetSizeY() + 10 + title:GetSizeY() + 10
      title:SetPosXY(PosX, PosY)
      title:SetPosX(PosX)
    end
    deleteRowCount = deleteRowCount + 2
  end
  local addRowCount = 0
  if 0 < self._addJewelCount and 7 >= self._addJewelCount then
    local isAddOdd = self._addJewelCount % 2 == 1
    local startPosX = 0
    if isAddOdd == true then
      startPosX = -(self._slotTemplateOriginSizeX + 10) * ((self._addJewelCount - 1) / 2)
    else
      startPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (self._addJewelCount / 2 - 1)
    end
    for slotNo = 0, self._addJewelCount - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (startPosX + slotNo * (self._slotTemplateOriginSizeX + 10))
      title:SetPosX(PosX)
    end
  elseif 7 < self._addJewelCount and 14 >= self._addJewelCount then
    local firstNum = math.floor(self._addJewelCount / 2) + self._addJewelCount % 2
    local secondNum = self._addJewelCount - firstNum
    local isFirstAddOdd = firstNum % 2 == 1
    local isSecondAddOdd = secondNum % 2 == 1
    local firstStartPosX = 0
    local secondStartPosX = 0
    if isFirstAddOdd == true then
      firstStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((firstNum - 1) / 2)
    else
      firstStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (firstNum / 2 - 1)
    end
    if isSecondAddOdd == true then
      secondStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((secondNum - 1) / 2)
    else
      secondStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (secondNum / 2 - 1)
    end
    for slotNo = 0, firstNum - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (firstStartPosX + slotNo * (self._slotTemplateOriginSizeX + 10))
      title:SetPosX(PosX)
    end
    for slotNo = firstNum, firstNum + secondNum - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (secondStartPosX + (slotNo - firstNum) * (self._slotTemplateOriginSizeX + 10))
      local PosY = title:GetPosY() + title:GetSizeY() + 10
      title:SetPosXY(PosX, PosY)
      title:SetPosX(PosX)
    end
    addRowCount = addRowCount + 1
  elseif 14 < self._addJewelCount and self._addJewelCount <= __eJewelSlotMaxCount - 1 then
    local firstNum = math.floor(self._addJewelCount / 3)
    local secondNum = math.floor(self._addJewelCount / 3)
    local thirdNum = math.floor(self._addJewelCount / 3)
    local rest = self._addJewelCount % 3
    for i = 0, rest - 1 do
      if i % 3 == 0 then
        firstNum = firstNum + 1
      elseif i % 3 == 1 then
        secondNum = secondNum + 1
      elseif i % 3 == 2 then
        thirdNum = thirdNum + 1
      end
    end
    local isFirstAddOdd = firstNum % 2 == 1
    local isSecondAddOdd = secondNum % 2 == 1
    local isThirdAddOdd = thirdNum % 2 == 1
    local firstStartPosX = 0
    local secondStartPosX = 0
    local thirdStartPosX = 0
    if isFirstAddOdd == true then
      firstStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((firstNum - 1) / 2)
    else
      firstStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (firstNum / 2 - 1)
    end
    if isSecondAddOdd == true then
      secondStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((secondNum - 1) / 2)
    else
      secondStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (secondNum / 2 - 1)
    end
    if isThirdAddOdd == true then
      thirdStartPosX = -(self._slotTemplateOriginSizeX + 10) * ((thirdNum - 1) / 2)
    else
      thirdStartPosX = -(self._slotTemplateOriginSizeX / 2 + 5) - (self._slotTemplateOriginSizeX + 10) * (thirdNum / 2 - 1)
    end
    for slotNo = 0, firstNum - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (firstStartPosX + slotNo * (self._slotTemplateOriginSizeX + 10))
      title:SetPosX(PosX)
    end
    for slotNo = firstNum, firstNum + secondNum - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (secondStartPosX + (slotNo - firstNum) * (self._slotTemplateOriginSizeX + 10))
      local PosY = title:GetPosY() + title:GetSizeY() + 10
      title:SetPosXY(PosX, PosY)
      title:SetPosX(PosX)
    end
    for slotNo = firstNum + secondNum, firstNum + secondNum + thirdNum - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      local PosX = title:GetPosX() + (thirdStartPosX + (slotNo - firstNum - secondNum) * (self._slotTemplateOriginSizeX + 10))
      local PosY = title:GetPosY() + title:GetSizeY() + 10 + title:GetSizeY() + 10
      title:SetPosXY(PosX, PosY)
      title:SetPosX(PosX)
    end
    addRowCount = addRowCount + 2
  end
  local deleteSlotPosGap = 0
  local addSlotPosGap = 0
  if deleteRowCount > 0 then
    deleteSlotPosGap = (self._ui.stc_beforeTitleTemplate:GetSizeY() + 10) * deleteRowCount
    self._ui.stc_arrow:SetPosY(self._ui.stc_arrow:GetPosY() + deleteSlotPosGap)
    self._ui.stc_afterTitle:SetPosY(self._ui.stc_afterTitle:GetPosY() + deleteSlotPosGap)
    for slotNo = 0, self._addJewelCount - 1 do
      local title = self._addJewelSlotBgList[slotNo]
      if title ~= nil then
        title:SetPosXY(title:GetPosX(), title:GetPosY() + deleteSlotPosGap)
      end
    end
  end
  if addRowCount > 0 then
    addSlotPosGap = (self._ui.stc_afterTitleTemplate:GetSizeY() + 10) * addRowCount
  end
  local slotPosGap = deleteSlotPosGap + addSlotPosGap
  self._ui.stc_changeBg:SetSize(self._ui.stc_changeBg:GetSizeX(), self._stcChangeBgOriginSizeY + slotPosGap)
  Panel_Window_MessageBox_CrystalSet_All:SetSize(Panel_Window_MessageBox_CrystalSet_All:GetSizeX(), self._panelOriginSizeY + slotPosGap)
  self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._stcBgOriginSizeY + slotPosGap)
  self._ui.stc_detailBg:SetPosY(self._stcDetailBgOriginPosY + slotPosGap)
  if self._isPadSnapping == false then
    self._ui.btn_yes:SetPosY(self._btnYesOriginPosY + slotPosGap)
    self._ui.btn_no:SetPosY(self._btnNoOriginPosY + slotPosGap)
  end
  if self._ui.stc_frame:GetSizeY() > self._ui.stc_frameContent:GetSizeY() then
    self._ui.stc_frame:SetSize(self._ui.stc_frame:GetSizeX(), self._ui.stc_frameContent:GetSizeY())
    local minusGap = self._ui.stc_detailBg:GetSizeY() - (self._ui.stc_textSubTitle:GetSizeY() + self._ui.stc_frame:GetSizeY())
    self._ui.stc_detailBg:SetSize(self._ui.stc_detailBg:GetSizeX(), self._ui.stc_textSubTitle:GetSizeY() + self._ui.stc_frame:GetSizeY())
    Panel_Window_MessageBox_CrystalSet_All:SetSize(Panel_Window_MessageBox_CrystalSet_All:GetSizeX(), Panel_Window_MessageBox_CrystalSet_All:GetSizeY() - minusGap)
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() - minusGap)
    if self._isPadSnapping == false then
      self._ui.btn_yes:SetPosY(self._ui.btn_yes:GetPosY() - minusGap)
      self._ui.btn_no:SetPosY(self._ui.btn_no:GetPosY() - minusGap)
    end
    self._ui.stc_vScroll:SetShow(false)
    if self._isPadSnapping == true then
      self._ui.stc_consoleGuide:SetPosY(self._stcConsoleGuidePosY - minusGap)
      local consoleGuideScroll = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_RS_ConsoleUI")
      consoleGuideScroll:SetShow(false)
    end
  elseif self._buffCount == 0 then
    local minusGap = self._stcFrameOriginSizeY
    Panel_Window_MessageBox_CrystalSet_All:SetSize(Panel_Window_MessageBox_CrystalSet_All:GetSizeX(), Panel_Window_MessageBox_CrystalSet_All:GetSizeY() - minusGap)
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() - minusGap)
    if self._isPadSnapping == false then
      self._ui.btn_yes:SetPosY(self._ui.btn_yes:GetPosY() - minusGap)
      self._ui.btn_no:SetPosY(self._ui.btn_no:GetPosY() - minusGap)
    end
    self._ui.stc_vScroll:SetShow(false)
    if self._isPadSnapping == true then
      self._ui.stc_consoleGuide:SetPosY(self._stcConsoleGuidePosY - minusGap)
      local consoleGuideScroll = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_RS_ConsoleUI")
      consoleGuideScroll:SetShow(false)
    end
  else
    self._ui.stc_vScroll:SetShow(true)
    if self._isPadSnapping == true then
      self._ui.stc_consoleGuide:SetPosY(self._stcConsoleGuidePosY + slotPosGap)
      local consoleGuideScroll = UI.getChildControl(self._ui.stc_consoleGuide, "StaticText_RS_ConsoleUI")
      consoleGuideScroll:SetShow(true)
    end
  end
  self._ui.stc_frame:UpdateContentScroll()
  self._ui.stc_vScroll:SetControlTop()
  self._ui.stc_frame:UpdateContentPos()
  Panel_Window_MessageBox_CrystalSet_All:SetPosY((getScreenSizeY() - Panel_Window_MessageBox_CrystalSet_All:GetSizeY()) * 0.5)
  if self._isPadSnapping == true then
    self._ui.btn_yes:SetShow(false)
    self._ui.btn_no:SetShow(false)
    self._ui.stc_consoleGuide:SetPosY(self._ui.stc_consoleGuide:GetPosY() - self._ui.btn_yes:GetSizeY() - 20)
    local diff = self._ui.btn_yes:GetSizeY() - self._ui.stc_consoleGuide:GetSizeY() + 20
    Panel_Window_MessageBox_CrystalSet_All:SetSize(Panel_Window_MessageBox_CrystalSet_All:GetSizeX(), Panel_Window_MessageBox_CrystalSet_All:GetSizeY() - diff)
    self._ui.stc_bg:SetSize(self._ui.stc_bg:GetSizeX(), self._ui.stc_bg:GetSizeY() - diff)
  end
end
function PaGlobal_MessageBox_CrystalSet_All:validate()
  self._ui.stc_textTitle:isValidate()
  self._ui.btn_close:isValidate()
  self._ui.stc_bg:isValidate()
  self._ui.stc_textContent:isValidate()
  self._ui.stc_changeBg:isValidate()
  self._ui.stc_beforeTitle:isValidate()
  self._ui.stc_beforeTitleTemplate:isValidate()
  self._ui.stc_arrow:isValidate()
  self._ui.stc_afterTitle:isValidate()
  self._ui.stc_afterTitleTemplate:isValidate()
  self._ui.stc_detailBg:isValidate()
  self._ui.stc_textSubTitle:isValidate()
  self._ui.stc_frame:isValidate()
  self._ui.stc_frameContent:isValidate()
  self._ui.stc_textNameTemp:isValidate()
  self._ui.stc_vScroll:isValidate()
  self._ui.btn_yes:isValidate()
  self._ui.btn_no:isValidate()
end
