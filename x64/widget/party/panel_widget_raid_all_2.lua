function PaGlobalFunc_Widget_Raid_All_Open()
  PaGlobal_Raid_All:prepareOpen()
end
function PaGlobalFunc_Widget_Raid_All_Close()
  PaGlobal_Raid_All:prepareClose()
end
function HanldeEventOnOut_Widget_Raid_All_Panel()
  PaGlobal_Raid_All._ui_pc.stc_buttonBG:SetShow(UI.checkIsInMouseAndEventPanel(Panel_Widget_Raid_All))
end
function HandleEventOnOut_Widget_Raid_All_LimitTextTooptip(isShow, index)
  PaGlobal_Raid_All:limitTextTooptip(isShow, index)
end
function HanldeEventOnOut_Widget_Raid_All_ButtonAction(isShow, index)
  PaGlobal_Raid_All:showButtonAction(isShow, index)
end
function HanldeEventLUp_Widget_Raid_All_ClickButtonAction(index)
  PaGlobal_Raid_All:clickButtonAction(index)
end
function HandleEventLUp_Widget_Raid_All_ChangeLeader()
  PaGlobal_Raid_All:changeLeader()
end
function HandleEventLUp_Widget_Raid_All_BanishMember()
  PaGlobal_Raid_All:banishMember()
end
function HandleEventLUp_Widget_Raid_All_ExitParty(selectIndex)
  PaGlobal_Raid_All:exitParty(selectIndex)
end
function HandleEventLUp_Widget_Raid_All_ExitParty_Self()
  PaGlobal_Raid_All:exitParty()
end
function HandleEventRUp_Widget_Raid_All_NaviGuide(index)
  PaGlobal_Raid_All:naviGuide(index)
end
function HandleEventLUp_Widget_Raid_All_ToggleDragMove()
  if true == PaGlobal_Raid_All._ui_pc.chk_dragToggle:IsCheck() then
    Panel_Widget_Raid_All:SetDragEnable(false)
  else
    Panel_Widget_Raid_All:SetDragEnable(true)
  end
  HandleEventOnOut_Raid_All_ToggleDragToolTip(true)
end
function HandleEventLPress_Widget_Raid_All_DragPanelAndSavePos()
  if PaGlobal_Raid_All._ui_pc.chk_dragToggle:IsCheck() == true then
    return
  else
    local currentScreenSize = {
      x = getScreenSizeX(),
      y = getScreenSizeY()
    }
    local PosX = 0
    local PosY = 0
    local posX = Panel_Widget_Raid_All:GetPosX()
    local posY = Panel_Widget_Raid_All:GetPosY()
    Panel_Widget_Raid_All:SetPosX(posX)
    Panel_Widget_Raid_All:SetPosY(posY)
    local rateX = posX + Panel_Widget_Raid_All:GetSizeX() / 2
    local rateY = posY + Panel_Widget_Raid_All:GetSizeY() / 2
    Panel_Widget_Raid_All:SetRelativePosX(rateX / currentScreenSize.x)
    Panel_Widget_Raid_All:SetRelativePosY(rateY / currentScreenSize.y)
  end
end
function HandleEventLUp_Widget_Raid_All_ExitToolTip(isShow, index)
  if false == isShow then
    TooltipSimple_Hide()
    return
  end
  local name = PAGetString(Defines.StringSheet_GAME, "LUA_ROSEWAR_PARTY_OUT_TITLE")
  local desc = ""
  TooltipSimple_Show(PaGlobal_Raid_All._uiPartyMemberList[index]._leaveBtn, name, desc)
end
function FromClient_Widget_Raid_All_HideOption()
  if nil == Panel_Widget_Raid_All then
    return false
  end
  PaGlobal_Raid_All._ui_pc.btn_leave:SetShow(false)
  PaGlobal_Raid_All._ui_pc.btn_ordersBg:SetShow(false)
  return false
end
function FromClient_Widget_Raid_All_ScreenResize()
  PaGlobal_Raid_All:resize()
end
function PaGlobalFunc_Widget_Raid_All_Update()
  if false == Panel_Widget_Raid_All:GetShow() then
    return
  end
  PaGlobal_Raid_All:update()
end
function PaGlobalFunc_Widget_Raid_All_GetShow()
  if nil == Panel_Widget_Raid_All then
    return false
  end
  return Panel_Widget_Raid_All:GetShow()
end
function HandleEventOnOut_Raid_All_ToggleDragToolTip(show)
  if show == false then
    TooltipSimple_Hide()
    return
  end
  local control = PaGlobal_Raid_All._ui_pc.chk_dragToggle
  local name = ""
  local desc = ""
  if control:IsCheck() == true then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_LOCK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_LOCK_DESC")
  else
    name = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_UNLOCK_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_CHATNEW_TOOLTIP_UNLOCK_DESC")
  end
  TooltipSimple_Show(control, name, desc)
end
