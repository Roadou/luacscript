function PaGlobal_VillageSiegeStateWidget:initialize()
  if self._initialize == true then
    return
  end
  self._ui._stc_titleBg = UI.getChildControl(Panel_Widget_VillageSiegeState_All, "Static_TitleArea")
  self._ui._txt_title = UI.getChildControl(self._ui._stc_titleBg, "StaticText_Title")
  self._ui._btn_change = UI.getChildControl(self._ui._stc_titleBg, "Button_Change")
  self._ui._lst_siegeTentList = UI.getChildControl(Panel_Widget_VillageSiegeState_All, "List2_SiegeTentList")
  self._ui._btn_change:SetShow(false)
  self._ui._lst_siegeTentList:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_VillageSiegeStateWidget_CreateSiegeTentListContent")
  self._ui._lst_siegeTentList:createChildContent(__ePAUIList2ElementManagerType_List)
  self._ui._lst_siegeTentList:changeAnimationSpeed(100)
  self:registEventHandler()
  self:validate()
  self._isConsole = ToClient_isConsole()
  self._initialize = true
  local isVillageSiegeBeing = ToClient_IsAnySiegeBeingOfMyChannel() == true and ToClient_IsVillageSiegeBeing() == true
  if isVillageSiegeBeing == true and (ToClient_GetMinorSiegeMode() == __eMinorSiegeModeOccupy or ToClient_getSiegeTerritoryType() == __eSiegeTerritoryType_Ocean) then
    self:prepareOpen()
  end
end
function PaGlobal_VillageSiegeStateWidget:registEventHandler()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  registerEvent("FromClient_VillageSiegeStateUI_OnOff", "FromClient_VillageSiegeStateUI_OnOff")
  registerEvent("FromClient_ResponseParticipateSiege", "FromClient_VillageSiegeStateUI_ChangedParticipateSiege")
end
function PaGlobal_VillageSiegeStateWidget:validate()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  self._ui._stc_titleBg:isValidate()
  self._ui._txt_title:isValidate()
  self._ui._btn_change:isValidate()
  self._ui._lst_siegeTentList:isValidate()
end
function PaGlobal_VillageSiegeStateWidget:prepareOpen()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  local isVillageSiegeBeing = ToClient_IsAnySiegeBeingOfMyChannel() == true and ToClient_IsVillageSiegeBeing() == true
  if isVillageSiegeBeing == false then
    return
  end
  if ToClient_GetMinorSiegeMode() == __eMinorSiegeModeBuilding and ToClient_getSiegeTerritoryType() == __eSiegeTerritoryType_Default then
    return
  end
  if self._isConsole == true then
    Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    Panel_LatestQuest:SetIgnoreRenderAndEvent(true)
  else
    Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    Panel_CheckedQuest:SetIgnoreRenderAndEvent(true)
  end
  self:updateWidgetTitleText()
  self:updateSiegeTentList(true)
  self:open()
end
function PaGlobal_VillageSiegeStateWidget:open()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  Panel_Widget_VillageSiegeState_All:RegisterUpdateFunc("PaGlobalFunc_VillageSiegeStateWidget_Update")
  Panel_Widget_VillageSiegeState_All:SetShow(true)
end
function PaGlobal_VillageSiegeStateWidget:prepareClose()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  self._accumulatedDeltaTime = 0
  self:close()
  if self._isConsole == true then
    Panel_MainQuest:SetIgnoreRenderAndEvent(false)
    Panel_LatestQuest:SetIgnoreRenderAndEvent(false)
  else
    Panel_MainQuest:SetIgnoreRenderAndEvent(false)
    Panel_CheckedQuest:SetIgnoreRenderAndEvent(false)
  end
end
function PaGlobal_VillageSiegeStateWidget:close()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  Panel_Widget_VillageSiegeState_All:ClearUpdateLuaFunc()
  Panel_Widget_VillageSiegeState_All:SetShow(false)
end
function PaGlobal_VillageSiegeStateWidget:update(deltaTime)
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  local listManager = self._ui._lst_siegeTentList:getElementManager()
  if listManager == nil then
    return
  end
  local siegeTentCount = ToClient_GetBuildingInfoCountSiege2024()
  local listSize_s64 = listManager:getSize()
  if siegeTentCount > Int64toInt32(listSize_s64) then
    self:updateSiegeTentList(false)
  else
    self._ui._lst_siegeTentList:requestUpdateVisible()
  end
  if self._isConsole == true then
    if Panel_MainQuest ~= nil and Panel_MainQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    end
    if Panel_LatestQuest ~= nil and Panel_LatestQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_LatestQuest:SetIgnoreRenderAndEvent(true)
    end
  else
    if Panel_MainQuest ~= nil and Panel_MainQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_MainQuest:SetIgnoreRenderAndEvent(true)
    end
    if Panel_CheckedQuest ~= nil and Panel_CheckedQuest:isSetIgnoreRenderAndEvent() == false then
      Panel_CheckedQuest:SetIgnoreRenderAndEvent(true)
    end
  end
end
function PaGlobal_VillageSiegeStateWidget:updatePanelPosition()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  Panel_Widget_VillageSiegeState_All:SetPosX(Panel_Radar:GetPosX() + Panel_Radar:GetSizeX() - Panel_Widget_VillageSiegeState_All:GetSizeX() - 10)
  if Panel_SiegeWar_AngerGage ~= nil and Panel_SiegeWar_AngerGage:GetShow() == true then
    Panel_Widget_VillageSiegeState_All:SetPosY(Panel_SiegeWar_AngerGage:GetPosY() + Panel_SiegeWar_AngerGage:GetSizeY() + 10)
  elseif Panel_Radar ~= nil then
    Panel_Widget_VillageSiegeState_All:SetPosY(Panel_Radar:GetPosY() + Panel_Radar:GetSizeY() + 10)
  end
end
function PaGlobal_VillageSiegeStateWidget:updateWidgetTitleText()
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  local territoryKeyRaw = ToClient_GetStartSiegeTerritoryKey()
  local territoryName = ""
  if territoryKeyRaw == self._eTerritoryKeyRaw.BALENOS then
    territoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_0")
  elseif territoryKeyRaw == self._eTerritoryKeyRaw.SERENDIA then
    territoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_1")
  elseif territoryKeyRaw == self._eTerritoryKeyRaw.CALPHEON then
    territoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_2")
  elseif territoryKeyRaw == self._eTerritoryKeyRaw.MEDIA then
    territoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_3")
  elseif territoryKeyRaw == self._eTerritoryKeyRaw.VALENCIA then
    territoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_4")
  elseif territoryKeyRaw == self._eTerritoryKeyRaw.KAMASYLVIA then
    territoryName = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_6")
  end
  self._ui._txt_title:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TITLE_2024", "name", territoryName))
end
function PaGlobal_VillageSiegeStateWidget:updateSiegeTentList(doCreateChildContent)
  if Panel_Widget_VillageSiegeState_All == nil then
    return
  end
  local prevListSizeY = self._ui._lst_siegeTentList:GetSizeY()
  local siegeTentCount = ToClient_GetBuildingInfoCountSiege2024()
  local siegeTentViewMaxCount = 6
  if self._isConsole == true then
    siegeTentViewMaxCount = 15
  end
  local siegeTentListViewCount = math.min(siegeTentCount, siegeTentViewMaxCount)
  local content = self._ui._lst_siegeTentList:GetContent()
  local listSizeY = content:GetSizeY() * siegeTentListViewCount
  self._ui._lst_siegeTentList:SetSize(self._ui._lst_siegeTentList:GetSizeX(), listSizeY)
  self._ui._lst_siegeTentList:ComputePos()
  if doCreateChildContent ~= nil and doCreateChildContent == true or prevListSizeY ~= listSizeY then
    self._ui._lst_siegeTentList:createChildContent(__ePAUIList2ElementManagerType_List)
  end
  local listManager = self._ui._lst_siegeTentList:getElementManager()
  if listManager == nil then
    return
  end
  listManager:clearKey()
  for index = 0, siegeTentCount - 1 do
    listManager:pushKey(toInt64(0, index))
  end
  self._ui._lst_siegeTentList:updateContentPos()
  local panelSizeY = listSizeY + self._ui._lst_siegeTentList:GetSpanSize().y + 100
  Panel_Widget_VillageSiegeState_All:SetSize(Panel_Widget_VillageSiegeState_All:GetSizeX(), panelSizeY)
  self:updatePanelPosition()
end
function PaGlobal_VillageSiegeStateWidget:createSiegeTentListContent(content, key)
  if Panel_Widget_VillageSiegeState_All == nil or content == nil or key == nil then
    return
  end
  local siegeTentIndex = Int64toInt32(key)
  local siegeTentWrapper = ToClient_GetBuildingInfoWrapperSiege2024(siegeTentIndex)
  if siegeTentWrapper == nil then
    return
  end
  local regionWrapper = getRegionInfoWrapper(siegeTentWrapper:getRegionKeyRaw())
  if regionWrapper == nil then
    return
  end
  local stc_progressBg = UI.getChildControl(content, "Static_ProgressBg")
  local prg_yellow = UI.getChildControl(content, "CircularProgress_Yellow")
  local prg_red = UI.getChildControl(content, "CircularProgress_Red")
  local txt_tentName = UI.getChildControl(content, "StaticText_NodeName")
  local txt_subName = UI.getChildControl(content, "StaticText_GuildName")
  local btn_navi = UI.getChildControl(content, "Button_Navi")
  local prg_hp = UI.getChildControl(content, "Progress2_Hp")
  local isHideSiege = siegeTentWrapper:isHideSiege()
  local endState = siegeTentWrapper:getEndState()
  local tentName = regionWrapper:getAreaName()
  local guildName = siegeTentWrapper:getGuildName()
  txt_tentName:SetText(tentName)
  if endState == __eBuildingInfoStateSiege2024_NotEnd then
    content:SetMonoTone(false, false)
    btn_navi:SetShow(self._isConsole == false)
    btn_navi:addInputEvent("Mouse_LUp", "HandleEventLUp_VillageSiegeStateWidget_OnClickedNaviButton(" .. siegeTentIndex .. ")")
    if isHideSiege == true then
      prg_red:SetShow(false)
      prg_yellow:SetShow(false)
    else
      local remainTimePercent = siegeTentWrapper:getRemainTimeRate() * 100
      if remainTimePercent <= 25 then
        prg_red:SetShow(true)
        prg_yellow:SetShow(false)
        prg_red:SetProgressRate(remainTimePercent)
      else
        prg_red:SetShow(false)
        prg_yellow:SetShow(true)
        prg_yellow:SetProgressRate(remainTimePercent)
      end
    end
    prg_hp:SetShow(true)
    local remainHPPercent = siegeTentWrapper:getHPRate() * 100
    prg_hp:SetProgressRate(remainHPPercent)
    if guildName == nil or guildName == "" then
      txt_subName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_EMPTY_TENT_STATE_2024"))
    else
      txt_subName:SetText(guildName)
    end
  elseif endState == __eBuildingInfoStateSiege2024_OccupyEnd then
    content:SetMonoTone(true, true)
    btn_navi:SetShow(false)
    prg_red:SetShow(false)
    prg_yellow:SetShow(false)
    prg_hp:SetShow(false)
    txt_subName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_6"))
  elseif endState == __eBuildingInfoStateSiege2024_ReleaseEnd then
    content:SetMonoTone(true, true)
    btn_navi:SetShow(false)
    prg_red:SetShow(false)
    prg_yellow:SetShow(false)
    prg_hp:SetShow(false)
    txt_subName:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGESIEGE_STATE_TOOLTIP_2024_5"))
  else
    UI.ASSERT_NAME(false, "\235\185\132\236\160\149\236\131\129\236\158\133\235\139\136\235\139\164. \235\176\156\236\131\157\236\139\156 \234\188\173 \236\160\156\235\179\180\237\149\180\236\163\188\236\132\184\236\154\148.", "\236\157\180\236\163\188")
    return
  end
  content:addInputEvent("Mouse_On", "HandleEventLUp_VillageSiegeStateWidget_OnOutTentContent(true, " .. siegeTentIndex .. ")")
  content:addInputEvent("Mouse_Out", "HandleEventLUp_VillageSiegeStateWidget_OnOutTentContent(false, " .. siegeTentIndex .. ")")
end
