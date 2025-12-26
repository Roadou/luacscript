Panel_Equipment_Artifacts_Tooltip:SetShow(false, false)
Panel_Equipment_Artifacts_Tooltip:ActiveMouseEventEffect(true)
Panel_Equipment_Artifacts_Tooltip:setMaskingChild(true)
Panel_Equipment_Artifacts_Tooltip:setGlassBackground(true)
local UI_color = Defines.Color
local _panel = Panel_Equipment_Artifacts_Tooltip
local ArtifactsTooltip = {
  _ui = {
    txt_windowTitle = UI.getChildControl(_panel, "StaticText_Title"),
    txt_noLightStone = UI.getChildControl(_panel, "StaticText_NoLightStone"),
    txt_setOptionTitle = UI.getChildControl(_panel, "StaticText_Set_Effect_Title"),
    txt_setOption = UI.getChildControl(_panel, "StaticText_SetOption")
  },
  _listEquip = {},
  _equipmentSize = 0,
  _txt_emptySlot = nil,
  _equipNoMin = __eEquipSlotNoArtifact1,
  _equipNoMax = __eEquipSlotNoCount,
  _panelSizeY = 0,
  _isDetail = false
}
function ArtifactsTooltip:Init()
  for ii = 1, 2 do
    local equip = {}
    equip.txt_equipName = UI.getChildControl(_panel, "StaticText_EquipmentName_" .. ii)
    equip.stc_mainBg = UI.getChildControl(_panel, "Static_Main_Bg_" .. ii)
    equip.stc_line = UI.getChildControl(equip.stc_mainBg, "Static_Stones")
    equip.stc_lightStone = {}
    for jj = 1, 2 do
      local lightStone = {}
      local stc = UI.getChildControl(equip.stc_mainBg, "Static_LightStone_Option_" .. jj)
      lightStone.stc_lightStoneIcon = UI.getChildControl(stc, "Static_LightStone_Icon")
      lightStone.txt_lightStoneName = UI.getChildControl(stc, "StaticText_LightStone_Name")
      lightStone.txt_lightStoneDesc = UI.getChildControl(stc, "StaticText_LightStone_Desc")
      lightStone.txt_lightStoneName:SetTextMode(__eTextMode_Limit_AutoWrap)
      lightStone.txt_lightStoneDesc:SetTextMode(__eTextMode_Limit_AutoWrap)
      lightStone.stc_off = UI.getChildControl(equip.stc_mainBg, "Static_Stone_Off_" .. jj)
      lightStone.stc_on = UI.getChildControl(equip.stc_mainBg, "Static_On_" .. jj)
      equip.stc_lightStone[jj] = lightStone
    end
    self._listEquip[ii] = equip
  end
  self._ui.txt_setOption:SetTextMode(__eTextMode_AutoWrap)
  self._ui.txt_setOptionTitle:SetTextMode(__eTextMode_Limit_AutoWrap)
  self._classType = getSelfPlayer():getClassType()
  self._txt_emptySlot = " <PAColor0xffc4bebe>(" .. PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EMPTY_SLOT") .. ")<PAOldColor>"
  self:AllSlotIsEmpty(true)
  self:SetPanelPos()
  Panel_Equipment_Artifacts_Tooltip:SetShow(false, false)
end
function ArtifactsTooltip:Update()
  self:UpdateUI()
  self:SetPanelPos()
  _panel:SetShow(true, true)
end
function ArtifactsTooltip:updateArtifactPreset(isShow, presetNo)
  if _ContentsGroup_LightStoneBag == false then
    return
  end
  if isShow == true then
    self:updateUIForArtifactPreset(presetNo)
    self:SetPanelPos(nil, true)
  end
  _panel:SetShow(isShow)
end
function ArtifactsTooltip:updateUIForArtifactPreset(presetNo)
  if _ContentsGroup_LightStoneBag == false then
    return
  end
  local tempWrapper = getTemporaryInformationWrapper()
  if tempWrapper == nil then
    return
  end
  self._equipmentSize = 0
  self._panelSizeY = 70 + self._ui.txt_noLightStone:GetTextSizeY()
  local equipWrapper
  for ii = 1, 2 do
    local stc = self._listEquip[ii]
    stc.txt_equipName:SetShow(false)
    stc.stc_mainBg:SetShow(false)
  end
  for ii = 1, 2 do
    local itemSSW
    if ii == 1 then
      itemSSW = tempWrapper:getArtifactPresetLeftArtifactItemStaticStatusWrapper(presetNo)
    elseif ii == 2 then
      itemSSW = tempWrapper:getArtifactPresetRightArtifactItemStaticStatusWrapper(presetNo)
    end
    if itemSSW ~= nil then
      local socketCount = 2
      if socketCount ~= 0 then
        self._equipmentSize = self._equipmentSize + 1
        local equip = self._listEquip[self._equipmentSize]
        equip.txt_equipName:SetShow(true)
        equip.stc_mainBg:SetShow(true)
        PAGlobalFunc_SetItemTextColor(equip.txt_equipName, itemSSW)
        equip.txt_equipName:SetTextMode(__eTextMode_Limit_AutoWrap)
        equip.txt_equipName:SetText(itemSSW:getName())
        for socketNo = 0, socketCount - 1 do
          local pushedItemSSW
          if socketNo == 0 then
            if ii == 1 then
              pushedItemSSW = tempWrapper:getArtifactPresetLeftFirstPushedItemItemStaticStatusWrapper(presetNo)
            else
              pushedItemSSW = tempWrapper:getArtifactPresetRightFirstPushedItemStaticStatusWrapper(presetNo)
            end
          elseif socketNo == 1 then
            if ii == 1 then
              pushedItemSSW = tempWrapper:getArtifactPresetLeftSecondPushedItemItemStaticStatusWrapper(presetNo)
            else
              pushedItemSSW = tempWrapper:getArtifactPresetRightSecondPushedItemStaticStatusWrapper(presetNo)
            end
          end
          if pushedItemSSW ~= nil then
            PAGlobalFunc_SetItemTextColor(equip.stc_lightStone[socketNo + 1].txt_lightStoneName, pushedItemSSW)
            equip.stc_lightStone[socketNo + 1].txt_lightStoneName:SetText(pushedItemSSW:getName())
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:ChangeTextureInfoNameAsync("icon/" .. pushedItemSSW:getIconPath())
            local x1, y1, x2, y2 = setTextureUV_Func(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon, 0, 0, 42, 42)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:setRenderTexture(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture())
            equip.stc_lightStone[socketNo + 1].stc_on:SetShow(true)
            local skillSSW = pushedItemSSW:getSkillByIdx(self._classType)
            if skillSSW == nil then
              equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText("")
            else
              local buffList = ""
              for buffIdx = 0, skillSSW:getBuffCount() - 1 do
                local desc = skillSSW:getBuffDescription(buffIdx)
                if nil == desc or "" == desc then
                  break
                end
                if nil == buffList or "" == buffList then
                  buffList = desc
                else
                  buffList = buffList .. " / " .. desc
                end
              end
              equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText(buffList)
            end
          else
            equip.stc_lightStone[socketNo + 1].txt_lightStoneName:SetText(self._txt_emptySlot)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_common_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon, 179, 104, 225, 150)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:setRenderTexture(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture())
            equip.stc_lightStone[socketNo + 1].stc_on:SetShow(false)
            equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText("")
          end
        end
      end
    end
  end
  if 0 ~= self._equipmentSize then
    self._ui.txt_noLightStone:SetShow(false)
    self._ui.txt_setOptionTitle:SetShow(true)
    self._ui.txt_setOption:SetShow(true)
    self._ui.txt_setOption:SetText("")
    local setStr = tempWrapper:getArtifactPresetSetEffectString(presetNo)
    if setStr ~= nil then
      self._ui.txt_setOption:SetText(setStr)
    else
      self._ui.txt_setOption:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_NOSET"))
    end
    self._panelSizeY = 5 + self._ui.txt_windowTitle:GetTextSizeY()
    self._panelSizeY = self._panelSizeY + (self._listEquip[1].stc_mainBg:GetSizeY() + self._listEquip[1].txt_equipName:GetTextSizeY() + 5) * self._equipmentSize
    self._panelSizeY = self._panelSizeY + self._ui.txt_setOptionTitle:GetTextSizeY() + self._ui.txt_setOption:GetTextSizeY() + 5
    self._panelSizeY = self._panelSizeY + 70
    local equip = self._listEquip[self._equipmentSize]
    local setOptionTitleY = equip.stc_mainBg:GetPosY() + equip.stc_mainBg:GetSizeY() + 20
    self._ui.txt_setOptionTitle:SetPosY(setOptionTitleY)
    self._ui.txt_setOption:SetPosY(setOptionTitleY + self._ui.txt_setOptionTitle:GetTextSizeY() + 5)
    self._panelSizeY = self._ui.txt_setOption:GetPosY() + self._ui.txt_setOption:GetTextSizeY() + 10
  else
    self._ui.txt_noLightStone:SetShow(true)
    self._ui.txt_setOptionTitle:SetShow(false)
    self._ui.txt_setOption:SetShow(false)
  end
  _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
  self._ui.txt_setOptionTitle:ComputePos()
  self._ui.txt_setOption:ComputePos()
end
function ArtifactsTooltip:UpdateSimpleItem()
  if nil == PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo then
    return
  end
  local characterNo = PaGlobalFunc_SimpleInventory_GetSelectedCharacterNo()
  if nil == characterNo then
    return
  end
  self:UpdateUI(characterNo)
  self:SetPanelPos(true)
  _panel:SetShow(true, true)
end
function ArtifactsTooltip:UpdateUI(characterNo)
  self._equipmentSize = 0
  self._panelSizeY = 70 + self._ui.txt_noLightStone:GetTextSizeY()
  local equipWrapper
  if nil ~= characterNo then
    equipWrapper = ToClient_SimpleEquipmentWrapper(characterNo)
    if nil == equipWrapper then
      return
    end
  end
  for ii = 1, 2 do
    local stc = self._listEquip[ii]
    stc.txt_equipName:SetShow(false)
    stc.stc_mainBg:SetShow(false)
  end
  for equipNo = self._equipNoMin, self._equipNoMax - 1 do
    local itemWrapper
    if nil == characterNo then
      itemWrapper = ToClient_getEquipmentItem(equipNo)
    else
      local equipItemWrapper = equipWrapper:getSimpleEquipItemWrapper(equipNo)
      if nil == equipItemWrapper then
        return
      end
      itemWrapper = equipItemWrapper:getItem()
    end
    if nil ~= itemWrapper then
      local socketCount = itemWrapper:get():getUsableItemSocketCount()
      if 0 ~= socketCount then
        self._equipmentSize = self._equipmentSize + 1
        local equip = self._listEquip[self._equipmentSize]
        equip.txt_equipName:SetShow(true)
        equip.stc_mainBg:SetShow(true)
        local equipItemEnchantSSW = itemWrapper:getStaticStatus()
        PAGlobalFunc_SetItemTextColor(equip.txt_equipName, equipItemEnchantSSW)
        equip.txt_equipName:SetTextMode(__eTextMode_Limit_AutoWrap)
        equip.txt_equipName:SetText(equipItemEnchantSSW:getName())
        for socketNo = 0, socketCount - 1 do
          local itemEnchantSSW = itemWrapper:getPushedItem(socketNo)
          if nil ~= itemEnchantSSW then
            PAGlobalFunc_SetItemTextColor(equip.stc_lightStone[socketNo + 1].txt_lightStoneName, itemEnchantSSW)
            equip.stc_lightStone[socketNo + 1].txt_lightStoneName:SetText(itemEnchantSSW:getName())
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:ChangeTextureInfoNameAsync("icon/" .. itemEnchantSSW:getIconPath())
            local x1, y1, x2, y2 = setTextureUV_Func(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon, 0, 0, 42, 42)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:setRenderTexture(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture())
            equip.stc_lightStone[socketNo + 1].stc_on:SetShow(true)
            local skillSSW = itemEnchantSSW:getSkillByIdx(self._classType)
            if nil == skillSSW then
              equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText("")
            else
              local buffList = ""
              for buffIdx = 0, skillSSW:getBuffCount() - 1 do
                local desc = skillSSW:getBuffDescription(buffIdx)
                if nil == desc or "" == desc then
                  break
                end
                if nil == buffList or "" == buffList then
                  buffList = desc
                else
                  buffList = buffList .. " / " .. desc
                end
              end
              equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText(buffList)
            end
          else
            equip.stc_lightStone[socketNo + 1].txt_lightStoneName:SetText(self._txt_emptySlot)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:ChangeTextureInfoNameAsync("renewal/pcremaster/remaster_common_00.dds")
            local x1, y1, x2, y2 = setTextureUV_Func(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon, 179, 104, 225, 150)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture():setUV(x1, y1, x2, y2)
            equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:setRenderTexture(equip.stc_lightStone[socketNo + 1].stc_lightStoneIcon:getBaseTexture())
            equip.stc_lightStone[socketNo + 1].stc_on:SetShow(false)
            equip.stc_lightStone[socketNo + 1].txt_lightStoneDesc:SetText("")
          end
        end
      end
    end
  end
  if 0 ~= self._equipmentSize then
    self._ui.txt_noLightStone:SetShow(false)
    self._ui.txt_setOptionTitle:SetShow(true)
    self._ui.txt_setOption:SetShow(true)
    self._ui.txt_setOption:SetText("")
    local setStr = ToClient_getLightStoneSet()
    if nil ~= setStr then
      self._ui.txt_setOption:SetText(setStr)
    else
      self._ui.txt_setOption:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_ARTIFACTS_NOSET"))
    end
    self._panelSizeY = 5 + self._ui.txt_windowTitle:GetTextSizeY()
    self._panelSizeY = self._panelSizeY + (self._listEquip[1].stc_mainBg:GetSizeY() + self._listEquip[1].txt_equipName:GetTextSizeY() + 5) * self._equipmentSize
    self._panelSizeY = self._panelSizeY + self._ui.txt_setOptionTitle:GetTextSizeY() + self._ui.txt_setOption:GetTextSizeY() + 5
    self._panelSizeY = self._panelSizeY + 70
    local equip = self._listEquip[self._equipmentSize]
    local setOptionTitleY = equip.stc_mainBg:GetPosY() + equip.stc_mainBg:GetSizeY() + 20
    self._ui.txt_setOptionTitle:SetPosY(setOptionTitleY)
    self._ui.txt_setOption:SetPosY(setOptionTitleY + self._ui.txt_setOptionTitle:GetTextSizeY() + 5)
    self._panelSizeY = self._ui.txt_setOption:GetPosY() + self._ui.txt_setOption:GetTextSizeY() + 10
  else
    self._ui.txt_noLightStone:SetShow(true)
    self._ui.txt_setOptionTitle:SetShow(false)
    self._ui.txt_setOption:SetShow(false)
  end
  _panel:SetSize(_panel:GetSizeX(), self._panelSizeY)
  self._ui.txt_setOptionTitle:ComputePos()
  self._ui.txt_setOption:ComputePos()
end
function ArtifactsTooltip:ChangeTextColor(control, nameColorGrade)
  if 0 == nameColorGrade then
    control:SetFontColor(UI_color.C_FFFFFFFF)
  elseif 1 == nameColorGrade then
    control:SetFontColor(4284350320)
  elseif 2 == nameColorGrade then
    control:SetFontColor(4283144191)
  elseif 3 == nameColorGrade then
    control:SetFontColor(4294953010)
  elseif 4 == nameColorGrade then
    control:SetFontColor(4294929408)
  else
    control:SetFontColor(UI_color.C_FFFFFFFF)
  end
end
function ArtifactsTooltip:SetPanelPos(isSimpleItem, isArtifactPreset)
  if _ContentsGroup_RenewUI == true then
  end
  local control
  if _ContentsGroup_NewUI_Equipment_All == true then
    control = Panel_Window_Equipment_All
  else
    control = Panel_Equipment
  end
  if isSimpleItem ~= nil and isSimpleItem == true then
    control = Panel_Window_SimpleInventory
  elseif isArtifactPreset ~= nil and isArtifactPreset == true then
    control = Panel_Window_ArtifactPreset_All
  end
  if control == nil then
    return
  end
  local equipPosX = 0
  local equipPosY = 0
  if control:IsUISubApp() == true then
    equipPosX = control:GetScreenParentPosX()
    equipPosY = control:GetScreenParentPosY()
  else
    equipPosX = control:GetPosX()
    equipPosY = control:GetPosY()
  end
  local posX = equipPosX - _panel:GetSizeX()
  if posX < 0 then
    posX = equipPosX + control:GetSizeX()
  end
  local posY = equipPosY + control:GetSizeY() - _panel:GetSizeY() - 10
  if posY < 0 then
    posY = 0
  elseif getScreenSizeY() < posY + _panel:GetSizeY() then
    posY = getScreenSizeY() - _panel:GetSizeY()
  end
  _panel:SetPosX(posX)
  _panel:SetPosY(posY)
end
function ArtifactsTooltip:AllSlotIsEmpty(flag)
  self._ui.txt_noLightStone:SetShow(flag)
end
function PaGlobalFunc_ArtifactsToolTip_InitWithIcon(icon)
  if not icon then
    return false
  end
  icon:addInputEvent("Mouse_On", "PAGlobalFunc_ArtifactsTooltip_Show(true)")
  icon:addInputEvent("Mouse_Out", "PAGlobalFunc_ArtifactsTooltip_Show(false)")
  return true
end
function PAGlobalFunc_ArtifactsTooltip_ToggleDetail()
  local self = ArtifactsTooltip
  self._isDetail = not self._isDetail
  self:Update()
  if true == _panel:IsUISubApp() then
    _panel:CloseUISubApp()
    self:SetPanelPos()
    _panel:OpenUISubApp()
  end
end
function PAGlobalFunc_ArtifactsTooltip_Show(flag)
  local self = ArtifactsTooltip
  if self == nil then
    return
  end
  if _panel:GetShow() == flag then
    return
  end
  if flag == true then
    self._isDetail = true
    self:Update()
  end
  local equipPanel
  if true == _ContentsGroup_NewUI_Equipment_All then
    equipPanel = Panel_Window_Equipment_All
  else
    equipPanel = Panel_Equipment
  end
  if true == equipPanel:IsUISubApp() then
    if flag then
      _panel:SetShow(true)
      _panel:OpenUISubApp()
    else
      _panel:SetShow(false)
      _panel:CloseUISubApp()
    end
  else
    _panel:SetShow(flag, flag)
  end
end
function PAGlobalFunc_ArtifactsTooltip_Show_ForSimpleItem(flag)
  if _panel:GetShow() == flag then
    return
  end
  if true == flag then
    ArtifactsTooltip._isDetail = false
    ArtifactsTooltip:UpdateSimpleItem()
  end
  _panel:SetShow(flag, flag)
end
function PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(isShow, presetNo)
  if isShow == nil then
    return
  end
  local self = ArtifactsTooltip
  if self == nil then
    return
  end
  self:updateArtifactPreset(isShow, presetNo)
end
function PaGlobalFunc_ArtifactTooltip_ChangeTextColor(control, nameColorGrade)
  ArtifactsTooltip:ChangeTextColor(control, nameColorGrade)
end
function PaGlobalFunc_ArtifactTooltip_ToggleArtifactPresetInfo(presetNo)
  local isShow = true
  if PAGlobalFunc_ArtifactsTooltip_GetShow() == true then
    isShow = false
  end
  PaGlobalFunc_ArtifactTooltip_Show_ForArtifactPreset(isShow, presetNo)
end
function PAGlobalFunc_ArtifactsTooltip_ToggleDetail_ForSimpleItem()
  local self = ArtifactsTooltip
  if self == nil then
    return
  end
  self._isDetail = not self._isDetail
  self:UpdateSimpleItem()
end
function PAGlobalFunc_ArtifactsTooltip_GetShow()
  return _panel:GetShow()
end
function FGlobal_ArtifactsToolTip_Init()
  local self = ArtifactsTooltip
  if self == nil then
    return
  end
  self:Init()
end
registerEvent("FromClient_luaLoadComplete", "FGlobal_ArtifactsToolTip_Init")
