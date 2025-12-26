function PaGlobal_FishCompetition_RequestOpen()
  if Panel_Window_FishCompetition == nil then
    return
  end
  PaGlobal_FishCompetition:requestOpen()
end
function PaGlobal_FishCompetition_Close()
  if Panel_Window_FishCompetition == nil or Panel_Window_FishCompetition:GetShow() == false then
    return
  end
  PaGlobal_FishCompetition:prepareClose()
end
function PaGlobal_FishCompetition_CreateContent(content, key)
  if content == nil or key == nil then
    return
  end
  PaGlobal_FishCompetition:createContent(content, key)
end
function PaGlobal_FishCompetition_SelectButton(index)
  if Panel_Window_FishCompetition == nil then
    return
  end
  PaGlobal_FishCompetition:selectButton(index)
end
function FromClient_UpdateFishCompetition()
  if Panel_Window_FishCompetition == nil then
    return
  end
  if Panel_Window_FishCompetition:GetShow() == false then
    PaGlobal_FishCompetition:prepareOpen()
  end
  PaGlobal_FishCompetition:update()
end
function HandleEventOnOut_FishCompetition_CatcthRegionTooltip(index, regionKey, isShow)
  if Panel_Window_FishCompetition == nil then
    return
  end
  if isShow == false then
    TooltipSimple_Hide()
    return
  end
  local regionInfoWrapper = getRegionInfoByRegionKey(RegionKey(regionKey))
  local control = PaGlobal_FishCompetition._ui.stc_catchRegion[index]
  TooltipSimple_Show(control, regionInfoWrapper:getAreaName(), "")
end
function HandleEventMOn_FishCompetitionGuide_SimpleTooltip(isShow)
  if Panel_Window_FishCompetition == nil then
    return
  end
  local self = PaGlobal_FishCompetition
  if self == nil then
    return
  end
  if self._isConsole == true then
    if Panel_Tooltip_SimpleText:GetShow() == true then
      isShow = false
    else
      isShow = true
    end
  end
  local control = self._ui.btn_Guide
  local name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_GUIDETITLE")
  local desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_FISHEVENT_GUIDEDESC")
  local pos = {
    x = Panel_Window_FishCompetition:GetPosX() + Panel_Window_FishCompetition:GetSizeX(),
    y = Panel_Window_FishCompetition:GetPosY()
  }
  if isShow == true then
    if self._isConsole == true then
      TooltipSimple_ShowSetSetPos_Console(pos, name, desc)
    else
      TooltipSimple_Show(control, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function FromClient_CheckCompetitionRewardExist()
  if Panel_Window_FishCompetition == nil then
    return
  end
  PaGlobal_FishCompetition:checkCompetitionRewardExist()
end
