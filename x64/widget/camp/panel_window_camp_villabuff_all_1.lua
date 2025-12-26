function PaGlobal_BuildingBuff_All:initialize()
  if true == self._initialize then
    return
  end
  Panel_Window_BuildingBuff_All:setGlassBackground(true)
  self._ui._stc_Title = UI.getChildControl(Panel_Window_BuildingBuff_All, "StaticText_Title")
  self._ui._btn_Close = UI.getChildControl(self._ui._stc_Title, "Button_Win_Close_PC")
  self._ui._stc_SubFrame = UI.getChildControl(Panel_Window_BuildingBuff_All, "Static_SubFrameBg")
  self._ui._stc_BottomGroup = UI.getChildControl(Panel_Window_BuildingBuff_All, "Static_BottomGroup")
  self._ui._txt_DescBG = UI.getChildControl(self._ui._stc_BottomGroup, "StaticText_BottomDesc")
  self._ui._stc_MoneyArea = UI.getChildControl(self._ui._stc_BottomGroup, "Static_MyMoneyArea")
  self._ui._txt_MoneyValue = UI.getChildControl(self._ui._stc_MoneyArea, "StaticText_MoneyValue")
  self._ui._stc_KeyGuide = UI.getChildControl(Panel_Window_BuildingBuff_All, "Static_ConsoleKeyGuide")
  self._maxPriceKey = ToClient_GetBuildingBuffCount()
  self:productRelocation()
  local basePanelSizeX = 700
  local wideSizeX = 0
  local tempBg = UI.getChildControl(self._ui._stc_SubFrame, "Static_TemplateBg")
  local tempBuyButton = UI.getChildControl(tempBg, "Button_BuffBuy")
  for index = 0, self._sortCount do
    self._ui._stc_TemplateBg[index] = UI.createAndCopyBasePropertyControl(self._ui._stc_SubFrame, "Static_TemplateBg", self._ui._stc_SubFrame, "Static_BuffAreaBg_" .. index)
    self._ui._stc_TemplateBg[index]:SetPosY(self._ui._stc_TemplateBg[index]:GetSizeY() * index + 10)
    self._ui._stc_DescBg[index] = UI.createAndCopyBasePropertyControl(tempBg, "Static_DescBg", self._ui._stc_TemplateBg[index], "Static_BuffDescBg_" .. index)
    self._ui._stc_BuffIcon[index] = UI.createAndCopyBasePropertyControl(tempBg, "Static_Icon", self._ui._stc_TemplateBg[index], "Static_BuffIcon_" .. index)
    self._ui._stc_BuffIcon[index]:ChangeTextureInfoNameAsync(self._buffIconPath[index])
    self._ui._txt_BuffName[index] = UI.createAndCopyBasePropertyControl(tempBg, "StaticText_BuffName", self._ui._stc_TemplateBg[index], "Static_BuffName_" .. index)
    self._ui._txt_BuffName[index]:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_BuffName[index]:SetText(self._buffName[index])
    self._ui._txt_BuffEffect[index] = UI.createAndCopyBasePropertyControl(tempBg, "StaticText_BuffEffect", self._ui._stc_TemplateBg[index], "StaticText_BuffEffect_" .. index)
    self._ui._txt_BuffEffect[index]:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_BuffEffect[index]:SetText(self._buffDesc[index])
    self._ui._btn_BuffBuy[index] = {}
    self._ui._txt_BuffPrice[index] = {}
    for ii = 0, #self._sortTable[index] - 1 do
      local buffIndex = self._sortTable[index][ii + 1]
      local keyCount = self._keyCount[buffIndex]
      local buffCount = self._buffCount[buffIndex]
      local buttonSplitCount = 2
      if #self._sortTable[0] > 4 then
        buttonSplitCount = 3
        wideSizeX = 160
      end
      self._ui._btn_BuffBuy[index][ii] = UI.createAndCopyBasePropertyControl(tempBg, "Button_BuffBuy", self._ui._stc_TemplateBg[index], "Button_BuffBuy_" .. index .. "_" .. ii)
      self._ui._btn_BuffBuy[index][ii]:SetPosXY(370 + (self._ui._btn_BuffBuy[index][ii]:GetSizeX() + 10) * (ii % buttonSplitCount), (self._ui._btn_BuffBuy[index][ii]:GetSizeY() + 10) * math.floor(ii / buttonSplitCount) + 10)
      self._ui._btn_BuffBuy[index][ii]:SetText(self._buffTime[index][ii])
      self._ui._btn_BuffBuy[index][ii]:addInputEvent("Mouse_LUp", "HandleEventLUp_BuildingBuff_All_ApplyBuff(" .. keyCount .. "," .. buffCount .. ")")
      self._ui._txt_BuffPrice[index][ii] = UI.createAndCopyBasePropertyControl(tempBuyButton, "StaticText_BuffPrice", self._ui._btn_BuffBuy[index][ii], "StaticText_BuffPrice_" .. index .. "_" .. ii)
      self._ui._txt_BuffPrice[index][ii]:SetText(self._buffPrice[index][ii])
      self._ui._txt_BuffPrice[index][ii]:SetPosX(self._ui._btn_BuffBuy[index][ii]:GetSizeX() / 2 + (self._ui._txt_BuffPrice[index][ii]:GetSizeX() + self._ui._txt_BuffPrice[index][ii]:GetTextSizeX() - 50) / 2)
    end
    self._ui._stc_TemplateBg[index]:SetSize(basePanelSizeX + wideSizeX, self._ui._btn_BuffBuy[index][#self._sortTable[index] - 1]:GetPosY() + self._ui._btn_BuffBuy[index][#self._sortTable[index] - 1]:GetSizeY() + 10)
    self._ui._stc_DescBg[index]:SetSize(basePanelSizeX + wideSizeX - 20, self._ui._stc_DescBg[index]:GetSizeY())
  end
  self._ui._txt_DescBG:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Left, 10)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Top, 10)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Right, 10)
  self._ui._txt_DescBG:setPadding(CppEnums.Padding.ePadding_Bottom, 10)
  self._ui._txt_DescBG:SetSize(self._ui._txt_DescBG:GetSizeX() + wideSizeX, self._ui._txt_DescBG:GetTextSizeY() + 10)
  self._ui._txt_DescBG:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_BUILDINGBUFF_BOTTOMDESC"))
  self._ui._stc_SubFrame:SetSize(self._ui._stc_SubFrame:GetSizeX() + wideSizeX, self._ui._stc_TemplateBg[self._sortCount]:GetPosY() + self._ui._stc_TemplateBg[self._sortCount]:GetSizeY() + 5)
  self._ui._stc_BottomGroup:SetSize(basePanelSizeX + wideSizeX, self._ui._stc_MoneyArea:GetSizeY() + self._ui._txt_DescBG:GetSizeY() + 20)
  self._ui._stc_Title:SetSize(basePanelSizeX + wideSizeX, self._ui._stc_Title:GetSizeY())
  Panel_Window_BuildingBuff_All:SetSize(basePanelSizeX + wideSizeX, self._ui._stc_SubFrame:GetPosY() + self._ui._stc_SubFrame:GetSizeY() + self._ui._stc_BottomGroup:GetSizeY() + 20)
  UI.getChildControl(self._ui._stc_Title, "Static_Deco"):ComputePos()
  self._ui._btn_Close:ComputePos()
  self._ui._stc_BottomGroup:ComputePos()
  self._ui._txt_DescBG:ComputePos()
  self._ui._stc_KeyGuide:ComputePos()
  self._ui._stc_MoneyArea:ComputePos()
  self._ui._txt_MoneyValue:ComputePos()
  self.originPanelSizeY = Panel_Window_BuildingBuff_All:GetSizeY()
  self.originDescSizeY = self._ui._txt_DescBG:GetSizeY()
  self.originBottomBGSizeY = self._ui._stc_BottomGroup:GetSizeY()
  self.originKeyGuidePosY = self._ui._stc_KeyGuide:GetPosY()
  self:setPos()
  self:initControlConsole()
  self:resizePanel()
  self:setAlignKeyGuide()
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_BuildingBuff_All:productRelocation()
  local tempName = {}
  local tempDesc = {}
  for index = 0, self._maxPriceKey - 1 do
    local buffMaxCount = ToClient_GetCountPerBuffKeyCount(index)
    for buffIndex = 0, buffMaxCount - 1 do
      self._keyCount[self._totalBuffCount] = index
      self._buffCount[self._totalBuffCount] = buffIndex
      local skillNo = ToClient_GetBuildingBuff(index, buffIndex)
      local skillWrapper = getSkillTypeStaticStatus(skillNo)
      if nil ~= skillWrapper then
        local name = skillWrapper:getName()
        local left = string.find(name, "%(")
        tempName[self._totalBuffCount] = string.sub(name, 1, left - 1)
        tempDesc[self._totalBuffCount] = string.gsub(string.lower(skillWrapper:getDescription()), "\239\188\140", "")
      end
      self._totalBuffCount = self._totalBuffCount + 1
    end
  end
  self._sortCount = 0
  for index = 0, self._totalBuffCount - 1 do
    if nil == self._sortTable[self._sortCount] then
      self._sortTable[self._sortCount] = {}
      table.insert(self._sortTable[self._sortCount], index)
    else
      local isSame = false
      for ii = 0, self._sortCount do
        for jj = 0, #self._sortTable[ii] - 1 do
          local keyCount = self._keyCount[self._sortTable[ii][jj + 1]]
          local buffCount = self._buffCount[self._sortTable[ii][jj + 1]]
          local skillNo = ToClient_GetBuildingBuff(keyCount, buffCount)
          local skillWrapper = getSkillTypeStaticStatus(skillNo)
          if nil ~= skillWrapper then
            local buffName = skillWrapper:getName()
            local left = string.find(buffName, "%(")
            buffName = string.sub(buffName, 1, left - 1)
            local buffDesc = string.gsub(string.lower(skillWrapper:getDescription()), "\239\188\140", "")
            local dummyString1, changeCount1 = string.gsub(buffDesc, "%d", "")
            local dummyString2, changeCount2 = string.gsub(tempDesc[index], "%d", "")
            local compareNumberMatch = changeCount1 == changeCount2
            if buffName == tempName[index] or buffDesc == tempDesc[index] or true == compareNumberMatch then
              table.insert(self._sortTable[ii], index)
              isSame = true
              break
            end
          end
        end
      end
      if false == isSame then
        self._sortCount = self._sortCount + 1
        self._sortTable[self._sortCount] = {}
        table.insert(self._sortTable[self._sortCount], index)
      end
    end
  end
  for index = 0, self._sortCount do
    self._buffTime[index] = {}
    self._buffPrice[index] = {}
    for ii = 0, #self._sortTable[index] - 1 do
      local keyCount = self._keyCount[self._sortTable[index][ii + 1]]
      local buffCount = self._buffCount[self._sortTable[index][ii + 1]]
      local buffPrice = ToClient_GetBuildingBuffCost(keyCount, buffCount)
      local skillNo = ToClient_GetBuildingBuff(keyCount, buffCount)
      local skillWrapper = getSkillTypeStaticStatus(skillNo)
      if nil ~= skillWrapper then
        local buffName = skillWrapper:getName()
        local left = string.find(buffName, "%(")
        local right = string.find(buffName, "%)")
        local buffDesc = skillWrapper:getDescription()
        buffDesc = string.gsub(string.gsub(string.gsub(string.gsub(buffDesc, ", ", "\n"), " ,", "\n"), ",", "\n"), "\239\188\140", "\n")
        self._buffName[index] = string.sub(buffName, 1, left - 1)
        self._buffTime[index][ii] = string.sub(buffName, left + 1, right - 1)
        self._buffDesc[index] = buffDesc
        self._buffPrice[index][ii] = makeDotMoney(buffPrice)
      end
    end
  end
end
function PaGlobal_BuildingBuff_All:setAlignKeyGuide()
  local selectKeyGuide = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_Select")
  local closeKeyGuide = UI.getChildControl(self._ui._stc_KeyGuide, "StaticText_Close")
  selectKeyGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_GENERIC_KEYGUIDE_XBOX_SELECT"))
  closeKeyGuide:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_COMMON_CLOSE"))
  local keyGuide = {selectKeyGuide, closeKeyGuide}
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuide, self._ui._stc_KeyGuide, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function PaGlobal_BuildingBuff_All:initControlConsole()
  if false == _ContentsGroup_UsePadSnapping then
    return
  end
  self._ui._stc_KeyGuide:SetShow(true)
end
function PaGlobal_BuildingBuff_All:registEventHandler()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All._ui._btn_Close:addInputEvent("Mouse_LUp", "PaGlobalFunc_BuildingBuff_All_Close()")
  registerEvent("FromClient_InventoryUpdate", "PaGlobalFunc_BuildingBuff_All_UpdateMoney")
  registerEvent("EventWarehouseUpdate", "PaGlobalFunc_BuildingBuff_All_UpdateMoney")
end
function PaGlobal_BuildingBuff_All:prepareOpen()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  do
    local selfPlayer = getSelfPlayer():get()
    local regionInfo = getRegionInfoByPosition(selfPlayer:getPosition())
    if nil == regionInfo then
      return
    end
    local regionInfoWrapper = getRegionInfoWrapper(regionInfo:getAffiliatedTownRegionKey())
    local wayKey = regionInfoWrapper:getPlantKeyByWaypointKey():getWaypointKey()
    if true == ToClient_IsAccessibleRegionKey(regionInfo:getAffiliatedTownRegionKey()) then
      warehouse_requestInfo(regionInfoWrapper:get()._waypointKey)
    else
      local plantWayKey = ToClient_GetOtherRegionKey_NeerByTownRegionKey()
      local newRegionInfo = ToClient_getRegionInfoWrapperByWaypoint(plantWayKey)
      if nil == newRegionInfo then
        return
      end
      warehouse_requestInfo(newRegionInfo:get()._waypointKey)
    end
  end
  ToClient_RequestCurrentMainTownRegionWarehouseInfo()
  PaGlobal_BuildingBuff_All:updateMoney()
  PaGlobal_BuildingBuff_All:open()
end
function PaGlobal_BuildingBuff_All:open()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  Panel_Window_BuildingBuff_All:SetShow(true)
end
function PaGlobal_BuildingBuff_All:prepareClose()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  PaGlobal_BuildingBuff_All:close()
end
function PaGlobal_BuildingBuff_All:close()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
  Panel_Window_BuildingBuff_All:SetShow(false)
end
function PaGlobal_BuildingBuff_All:update()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
end
function PaGlobal_BuildingBuff_All:setPos()
  Panel_Window_BuildingBuff_All:SetPosX(getScreenSizeX() / 2 - Panel_Window_BuildingBuff_All:GetSizeX() / 2)
  Panel_Window_BuildingBuff_All:SetPosY(getScreenSizeY() / 2 - Panel_Window_BuildingBuff_All:GetSizeY() / 2)
end
function PaGlobal_BuildingBuff_All:resizePanel()
  local descSizeY = PaGlobal_BuildingBuff_All._ui._txt_DescBG:GetTextSizeY()
  local extraSizeY = descSizeY - self.originDescSizeY
  if extraSizeY > 0 then
    Panel_Window_BuildingBuff_All:SetSize(Panel_Window_BuildingBuff_All:GetSizeX(), self.originPanelSizeY + extraSizeY)
    PaGlobal_BuildingBuff_All._ui._stc_BottomGroup:SetSize(PaGlobal_BuildingBuff_All._ui._stc_BottomGroup:GetSizeX(), self.originBottomBGSizeY + extraSizeY)
    PaGlobal_BuildingBuff_All._ui._txt_DescBG:SetSize(PaGlobal_BuildingBuff_All._ui._txt_DescBG:GetSizeX(), self.originDescSizeY + extraSizeY)
    PaGlobal_BuildingBuff_All._ui._stc_KeyGuide:SetPosY(PaGlobal_BuildingBuff_All.originKeyGuidePosY + extraSizeY)
  end
end
function PaGlobal_BuildingBuff_All:updateMoney()
  if nil == getSelfPlayer() then
    return
  end
  self._ui._txt_MoneyValue:SetText(makeDotMoney(getSelfPlayer():get():getMoneyInventory():getMoney_s64()))
end
function PaGlobal_BuildingBuff_All:applyBuff(keyCount, buffIndex, index)
  local function apply()
    ToClient_ApplyBuildingBuff(keyCount, buffIndex, true)
  end
  local skillNo = ToClient_GetBuildingBuff(keyCount, buffIndex)
  local skillWrapper = getSkillTypeStaticStatus(skillNo)
  if nil ~= skillWrapper then
    local buffName = skillWrapper:getName()
    local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_CAMP_BUILDINGBUFF_MESSAGEBOX_DESC", "skillName", buffName)
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = messageBoxMemo,
      functionYes = apply,
      functionNo = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
end
function PaGlobal_BuildingBuff_All:validate()
  if nil == Panel_Window_BuildingBuff_All then
    return
  end
end
