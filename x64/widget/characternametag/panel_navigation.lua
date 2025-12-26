Panel_Copy_NaviPath:SetPosX(-1000)
Panel_Copy_NaviPath:SetPosY(-1000)
NaviGuidePanel = nil
function FromClient_CreateNavigationPanel(targetPanel, index)
  local meterControl = UI.getChildControl(targetPanel, "StaticText_Meter")
  local naviButton = UI.getChildControl(targetPanel, "Checkbox_NaviBtn")
  local guideControl = UI.getChildControl(targetPanel, "MultilineText_Guide")
  guideControl:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_NAVI_AUTORUN_GUIDE"))
  guideControl:SetShow(false)
  NaviGuidePanel = targetPanel
  if true == isGameServiceTypeConsole() then
    meterControl:SetShow(false)
    naviButton:SetShow(false)
  else
    meterControl:SetTextMode(__eTextMode_AutoWrap)
    meterControl:SetShow(true)
    naviButton:addInputEvent("Mouse_LUp", "NavigationControlClick(" .. tostring(index) .. ")")
    naviButton:SetShow(true)
  end
end
function NavigationControlClick(index)
  local selfPlayer = getSelfPlayer():get()
  if selfPlayer:getNavigationMovePathIndex() == index then
    selfPlayer:setNavigationMovePath(-1)
    selfPlayer:checkNaviPathUI(-1)
  else
    if ToClient_GetNaviGuideGroupNo(index) ~= 0 then
      ToClient_DeleteNaviGuideByGroup(0)
    end
    selfPlayer:setNavigationMovePath(index)
    selfPlayer:checkNaviPathUI(index)
  end
end
ToClient_SetBubbleNaviPath(Panel_Copy_NaviPath)
ToClient_InitializeNaviPath()
registerEvent("FromClient_CreateNavigationPanel", "FromClient_CreateNavigationPanel")
