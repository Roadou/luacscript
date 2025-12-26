PaGlobal_MorningLand_ConquestGiveUp_All = {
  _ui = {
    stc_conquestGiveUpBg = nil,
    txt_bossName = nil,
    txt_difficulty = nil,
    btn_conquestGiveUp = nil,
    btn_conquestMove = nil
  },
  _initialize = false,
  _isConsole = false,
  _isOpen = false,
  _defaultY = 0
}
registerEvent("FromClient_luaLoadComplete", "FromClient_MorningLand_ConquestGiveUp_Init")
function FromClient_MorningLand_ConquestGiveUp_Init()
  PaGlobal_MorningLand_ConquestGiveUp_All:initialize()
end
function PaGlobal_MorningLand_ConquestGiveUp_All:initialize()
  if self._isInitialize == true then
    return
  end
  if _ContentsGroup_MorningLand == false then
    return
  end
  if Panel_MorningLand_ConquestGiveUp == nil then
    return
  end
  self._ui.stc_conquestGiveUpBg = UI.getChildControl(Panel_MorningLand_ConquestGiveUp, "Static_ConquestGiveUpBG")
  self._ui.txt_bossName = UI.getChildControl(self._ui.stc_conquestGiveUpBg, "StaticText_ConquestGiveUp_Name_0")
  self._ui.txt_difficulty = UI.getChildControl(self._ui.stc_conquestGiveUpBg, "StaticText_ConquestGiveUp_Difficulty_0")
  self._ui.btn_conquestGiveUp = UI.getChildControl(Panel_MorningLand_ConquestGiveUp, "Button_ConquestGiveUp")
  self._ui.btn_conquestMove = UI.getChildControl(Panel_MorningLand_ConquestGiveUp, "Button_ConquestWayToMove")
  self._isConsole = _ContentsGroup_UsePadSnapping
  self._defaultY = Panel_MorningLand_ConquestGiveUp:GetSizeY()
  Panel_MorningLand_ConquestGiveUp:ComputePosAllChild()
  PaGlobal_MorningLand_ConquestGiveUp_All:registEventHandler()
  FromClient_clearElementalMonsterKey()
  PaGlobal_MorningLand_ConquestGiveUp_All._initialize = true
  PaGlobal_MorningLand_ConquestGiveUp_All_OnScreenResize()
end
function PaGlobal_MorningLand_ConquestGiveUp_All:registEventHandler()
  if Panel_MorningLand_ConquestGiveUp == nil then
    return
  end
  self._ui.btn_conquestGiveUp:addInputEvent("Mouse_LUp", "ToClient_RequestClearElementalMonster()")
  self._ui.btn_conquestMove:addInputEvent("Mouse_LUp", "PaGlobal_MorningLand_ConquestGiveUp_All:setWayPoint()")
  registerEvent("FromClient_setElementalMonsterKey", "FromClient_clearElementalMonsterKey")
  registerEvent("onScreenResize", "PaGlobal_MorningLand_ConquestGiveUp_All_OnScreenResize")
end
function PaGlobal_MorningLand_ConquestGiveUp_All:prepareOpen()
  if _ContentsGroup_MorningLand == false then
    return
  end
  if Panel_MorningLand_ConquestGiveUp == nil then
    return
  end
  self._ui.btn_conquestGiveUp:SetShow(not self._isConsole)
  self._ui.btn_conquestMove:SetShow(not self._isConsole)
  if self._isConsole == true then
    Panel_MorningLand_ConquestGiveUp:SetSize(Panel_MorningLand_ConquestGiveUp:GetSizeX(), self._defaultY - self._ui.btn_conquestGiveUp:GetSizeY())
  end
  local selectedBoss = ToClient_GetSeletedElementalMonsterKey()
  if selectedBoss ~= nil and selectedBoss > 0 then
    local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(selectedBoss)
    if nil ~= morningBossSSW then
      local characterStaticStatusWarpper = getCharacterStaticStatusWarpper(selectedBoss)
      local isMorningLandMonsterPart2 = morningBossSSW:getMorningLandMonsterPartRaw() == __eMorningLandMosterPart2
      local selectedDifficulty = morningBossSSW:getLevel()
      if isMorningLandMonsterPart2 == true then
        return
      end
      self._ui.txt_bossName:SetText(characterStaticStatusWarpper:getName())
      self._ui.txt_difficulty:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_MORNING_ATTRBOSS_DIFFICULTY_" .. tostring(selectedDifficulty)))
      if isMorningLandMonsterPart2 == true then
        if selectedDifficulty == 0 then
          self._ui.txt_difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_EASY"))
        elseif selectedDifficulty == 1 then
          self._ui.txt_difficulty:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_MORNING2_HARD"))
        end
      end
    end
  else
    return
  end
  PaGlobal_MorningLand_ConquestGiveUp_All_OnScreenResize()
  self:open()
end
function PaGlobal_MorningLand_ConquestGiveUp_All:open()
  if nil == Panel_MorningLand_ConquestGiveUp then
    return
  end
  Panel_MorningLand_ConquestGiveUp:SetShow(true)
end
function PaGlobal_MorningLand_ConquestGiveUp_All:prepareClose()
  if nil == Panel_MorningLand_ConquestGiveUp then
    return
  end
  ToClient_DeleteNaviGuideByGroup(0)
  PaGlobal_MorningLand_ConquestGiveUp_All:close()
end
function PaGlobal_MorningLand_ConquestGiveUp_All:close()
  if nil == Panel_MorningLand_ConquestGiveUp then
    return
  end
  Panel_MorningLand_ConquestGiveUp:SetShow(false)
end
function PaGlobal_MorningLand_ConquestGiveUp_All:resetPosition()
  local radarSizeX = FGlobal_Panel_Radar_GetSizeX()
  Panel_MorningLand_ConquestGiveUp:SetPosX(getScreenSizeX() - radarSizeX - Panel_MorningLand_ConquestGiveUp:GetSizeX() - 15)
  local tempPanel
  if true == PaGlobalFunc_AccesoryQuest_ReturnPanelShow() then
    tempPanel = Panel_Widget_AccesoryQuest
    if nil ~= tempPanel then
      Panel_MorningLand_ConquestGiveUp:SetPosY(tempPanel:GetPosY() + tempPanel:GetSizeY() + 20)
    end
  elseif true == PcEnduranceToggle() or PaGlobalFunc_Endurance_InvenSlot_All_GetShow() then
    tempPanel = PaGlobalPlayerWeightList.weight
    local invenSlotIcon = PaGlobal_Endurance_InvenSlot_All._ui.txt_InvenSlotIcon
    if nil ~= tempPanel then
      if invenSlotIcon:GetShow() then
        Panel_MorningLand_ConquestGiveUp:SetPosY(invenSlotIcon:GetPosY() + invenSlotIcon:GetSizeY() + 80)
      else
        Panel_MorningLand_ConquestGiveUp:SetPosY(tempPanel:GetPosY() + tempPanel:GetSizeY() + 80)
      end
    end
  else
    if true == PaGlobalHorseEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalHorseEnduranceList.panel
    elseif true == PaGlobalCarriageEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalCarriageEnduranceList.panel
    elseif true == PaGlobalShipEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalShipEnduranceList.panel
    elseif true == PaGlobalSailShipEnduranceList.panel:GetShow() then
      tempPanel = PaGlobalSailShipEnduranceList.panel
    elseif true == PaGlobalPlayerEnduranceList.enduranceInfo[0].control:GetShow() then
      tempPanel = PaGlobalPlayerEnduranceList.panel
    end
    if nil ~= tempPanel then
      Panel_MorningLand_ConquestGiveUp:SetPosY(tempPanel:GetPosY() + tempPanel:GetSizeY() + 30)
    else
      Panel_MorningLand_ConquestGiveUp:SetPosY(50)
    end
  end
end
function PaGlobal_MorningLand_ConquestGiveUp_All:setWayPoint()
  if nil == Panel_MorningLand_ConquestGiveUp then
    return
  end
  local morningBossSSW = ToClient_getElementalMonsterInfoByCharacterKey(ToClient_GetSeletedElementalMonsterKey())
  if nil ~= morningBossSSW then
    ToClient_DeleteNaviGuideByGroup(0)
    local posX = morningBossSSW:getPosition().x
    local posY = morningBossSSW:getPosition().y
    local posZ = morningBossSSW:getPosition().z
    worldmapNavigatorStart(float3(posX, posY, posZ), NavigationGuideParam(), false, false, false)
  end
end
function PaGlobal_MorningLand_ConquestGiveUp_All_OnScreenResize()
  local self = PaGlobal_MorningLand_ConquestGiveUp_All
  if true == self._initialize then
    self:resetPosition()
  end
end
function PaGlobal_MorningLand_ConquestGiveUp_All_Close()
  if nil == Panel_MorningLand_ConquestGiveUp then
    return
  end
  PaGlobal_MorningLand_ConquestGiveUp_All:prepareClose()
end
function PaGlobal_MorningLand_ConquestGiveUp_All_Open()
  if nil == PaGlobal_MorningLand_ConquestGiveUp_All then
    return
  end
  PaGlobal_MorningLand_ConquestGiveUp_All:prepareOpen()
end
function FromClient_clearElementalMonsterKey()
  if nil == PaGlobal_MorningLand_ConquestGiveUp_All then
    return
  end
  local selectedBoss = ToClient_GetSeletedElementalMonsterKey()
  if selectedBoss ~= nil and selectedBoss > 0 then
    PaGlobal_MorningLand_ConquestGiveUp_All_Open()
  else
    PaGlobal_MorningLand_ConquestGiveUp_All_Close()
  end
end
