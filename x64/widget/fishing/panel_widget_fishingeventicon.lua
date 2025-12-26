PaGlobal_FishingEventIcon = {
  _ui = {_stc_icon, _txt_desc},
  _regionKey = {
    [0] = 444
  },
  _isConsole = _ContentsGroup_UsePadSnapping,
  _initialize = false
}
function PaGlobal_FishingEventIcon:initialize()
  if true == self._initialize then
    return
  end
  if nil == Panel_Widget_FishingEventIcon then
    return
  end
  self._ui._stc_icon = UI.getChildControl(Panel_Widget_FishingEventIcon, "StaticText_FishIcon")
  self._ui._txt_desc = UI.getChildControl(Panel_Widget_FishingEventIcon, "StaticText_Desc")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_FishingEventIcon:registEventHandler()
  if nil == Panel_Widget_FishingEventIcon then
    return
  end
  registerEvent("selfPlayer_regionChanged", "PaGlobal_FishingEventIcon_Open")
end
function PaGlobal_FishingEventIcon:validate()
  self._ui._stc_icon:isValidate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_FishingEventIcon:preOpen()
  Panel_Widget_FishingEventIcon:SetPosX(Panel_Radar:GetPosX() - Panel_Widget_FishingEventIcon:GetSizeX() - 10)
  Panel_Widget_FishingEventIcon:SetShow(true)
end
function PaGlobal_FishingEventIcon:preClose()
  Panel_Widget_FishingEventIcon:SetShow(false)
end
function PaGlobal_FishingEventIcon_Close()
  PaGlobal_FishingEventIcon:preClose()
end
function PaGlobal_FishingEventIcon_Open(isSafeZone, isArenaZone, isDesert, isAtoraxion, regionType, regionKey, areaName, territoryName)
  if true == Panel_Widget_Fishing_All:GetShow() then
    return
  end
  local isShow = false
  for index = 0, #PaGlobal_FishingEventIcon._regionKey do
    if PaGlobal_FishingEventIcon._regionKey[index] == regionKey then
      isShow = true
      break
    end
  end
  if true == isShow then
    PaGlobal_FishingEventIcon:preOpen()
  else
    PaGlobal_FishingEventIcon:preClose()
  end
end
PaGlobal_FishingEventIcon:initialize()
