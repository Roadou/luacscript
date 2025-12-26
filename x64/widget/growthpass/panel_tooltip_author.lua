Panel_Tooltip_Author:SetShow(false)
Panel_Tooltip_Author:setGlassBackground(true)
Panel_Tooltip_Author:SetIgnoreChild(true)
Panel_Tooltip_Author:SetIgnore(true)
local _styleDesc = UI.getChildControl(Panel_Tooltip_Author, "Tooltip_Description")
local _mouseL = UI.getChildControl(Panel_Tooltip_Author, "Static_Help_MouseL")
local _mouseR = UI.getChildControl(Panel_Tooltip_Author, "Static_Help_MouseR")
local _gaugeBG = UI.getChildControl(Panel_Tooltip_Author, "Static_Gauge_BG")
local _gaugeProgress = UI.getChildControl(Panel_Tooltip_Author, "Progress_Gauge")
local _gaugeBarHead = UI.getChildControl(_gaugeProgress, "Progress2_1_Bar_Head")
local _gaugeTime = UI.getChildControl(Panel_Tooltip_Author, "StaticText_Gauge_Main")
local _isTooltipShow = false
if _ContentsGroup_RenewUI then
  _styleDesc:SetShow(false)
  _styleDesc = UI.getChildControl(Panel_Tooltip_Author, "Tooltip_Description_Console")
  _uiName:SetShow(true)
  _styleDesc:SetShow(true)
end
local uiTextGroup = {_styleDesc = _styleDesc}
local TooltipAuthor_SetPosition = function(parentPos, size, reversePosX)
  local itemShow = Panel_Tooltip_Author:GetShow()
  if not itemShow then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local itemPosX = Panel_Tooltip_Author:GetSizeX()
  local itemPosY = Panel_Tooltip_Author:GetSizeY()
  local posX = parentPos.x
  local posY = parentPos.y
  local isLeft = false
  if true == reversePosX then
    isLeft = posX < screenSizeX / 2
  else
    isLeft = posX > screenSizeX / 2
  end
  local isTop = posY > screenSizeY / 2
  local tooltipSize = {width = 0, height = 0}
  local tooltipEquipped = {width = 0, height = 0}
  local sumSize = {width = 0, height = 0}
  if Panel_Tooltip_Author:GetShow() then
    tooltipSize.width = Panel_Tooltip_Author:GetSizeX()
    tooltipSize.height = Panel_Tooltip_Author:GetSizeY()
    sumSize.width = sumSize.width + tooltipSize.width
    sumSize.height = math.max(sumSize.height, tooltipSize.height)
  end
  if not isLeft then
    posX = posX + size.x
  end
  if isTop then
    posY = posY + size.y
    local yDiff = posY - sumSize.height
    if yDiff < 0 then
      posY = posY - yDiff
    end
  else
    local yDiff = screenSizeY - (posY + sumSize.height)
    if yDiff < 0 then
      posY = posY + yDiff
    end
  end
  if Panel_Tooltip_Author:GetShow() then
    if isLeft then
      posX = posX - tooltipSize.width
    end
    local yTmp = posY
    if isTop then
      yTmp = yTmp - tooltipSize.height
    end
    Panel_Tooltip_Author:SetPosX(mousePosX + 15)
    Panel_Tooltip_Author:SetPosY(mousePosY + 15)
    if screenSizeX < Panel_Tooltip_Author:GetPosX() + Panel_Tooltip_Author:GetSizeX() then
      Panel_Tooltip_Author:SetPosX(mousePosX - Panel_Tooltip_Author:GetSizeX())
    else
      Panel_Tooltip_Author:SetPosX(mousePosX + 15)
    end
    if screenSizeY < Panel_Tooltip_Author:GetPosY() + Panel_Tooltip_Author:GetSizeY() then
      Panel_Tooltip_Author:SetPosY(mousePosY - Panel_Tooltip_Author:GetSizeY())
    else
      Panel_Tooltip_Author:SetPosY(mousePosY + 15)
    end
  end
end
local TooltipAuthor_SetPosition_UISubApp = function(parent, size, reversePosX)
  local itemShow = Panel_Tooltip_Author:GetShow()
  if not itemShow then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local itemPosX = Panel_Tooltip_Author:GetSizeX()
  local itemPosY = Panel_Tooltip_Author:GetSizeY()
  local posX = parent:GetScreenParentPosX()
  local posY = parent:GetScreenParentPosY()
  local isLeft = false
  if true == reversePosX then
    isLeft = posX < screenSizeX / 2
  else
    isLeft = posX > screenSizeX / 2
  end
  local isTop = posY > screenSizeY / 2
  local tooltipSize = {width = 0, height = 0}
  local tooltipEquipped = {width = 0, height = 0}
  local sumSize = {width = 0, height = 0}
  if Panel_Tooltip_Author:GetShow() then
    tooltipSize.width = Panel_Tooltip_Author:GetSizeX()
    tooltipSize.height = Panel_Tooltip_Author:GetSizeY()
    sumSize.width = sumSize.width + tooltipSize.width
    sumSize.height = math.max(sumSize.height, tooltipSize.height)
  end
  if not isLeft then
    posX = posX + size.x
  end
  if isTop then
    posY = posY + size.y
    local yDiff = posY - sumSize.height
    if yDiff < 0 then
      posY = posY - yDiff
    end
  else
    local yDiff = screenSizeY - (posY + sumSize.height)
    if yDiff < 0 then
      posY = posY + yDiff
    end
  end
  if Panel_Tooltip_Author:GetShow() then
    if isLeft then
      posX = posX - tooltipSize.width
    end
    local yTmp = posY
    if isTop then
      yTmp = yTmp - tooltipSize.height
    end
    posX = parent:GetScreenParentPosX() + parent:GetParentPosX()
    yTmp = parent:GetScreenParentPosY() + parent:GetParentPosY()
    local mousePosX = getMousePosX()
    local mousePosY = getMousePosY()
    if screenSizeX < Panel_Tooltip_Author:GetPosX() + Panel_Tooltip_Author:GetSizeX() then
      Panel_Tooltip_Author:SetPosX(posX - Panel_Tooltip_Author:GetSizeX())
    else
      Panel_Tooltip_Author:SetPosX(mousePosX + 15)
    end
    if screenSizeY < Panel_Tooltip_Author:GetPosY() + Panel_Tooltip_Author:GetSizeY() then
      Panel_Tooltip_Author:SetPosY(yTmp - Panel_Tooltip_Author:GetSizeY())
    else
      Panel_Tooltip_Author:SetPosY(mousePosY + 15)
    end
  end
end
function TooltipAuthor_CommonShow(name, desc)
  _isTooltipShow = Panel_Tooltip_Author:GetShow()
  if Panel_Tooltip_Author:GetShow() then
    Panel_Tooltip_Author:SetShow(false)
  end
  if nil ~= desc and "" ~= desc then
    local descLength = string.len(desc)
    local panelWidth = 230
    if descLength < 230 then
      _styleDesc:SetSize(panelWidth - 40, _styleDesc:GetSizeY())
      Panel_Tooltip_Author:SetSize(panelWidth, Panel_Tooltip_Author:GetSizeY())
    elseif descLength >= 230 and descLength < 500 then
      _styleDesc:SetSize(panelWidth + 80, _styleDesc:GetSizeY())
      Panel_Tooltip_Author:SetSize(panelWidth + 100, Panel_Tooltip_Author:GetSizeY())
    else
      _styleDesc:SetSize(panelWidth + 120, _styleDesc:GetSizeY())
      Panel_Tooltip_Author:SetSize(panelWidth + 140, Panel_Tooltip_Author:GetSizeY())
    end
    _gaugeBG:SetShow(false)
    _gaugeProgress:SetShow(false)
    _gaugeBarHead:SetShow(false)
    _gaugeTime:SetShow(false)
    _styleDesc:SetTextHorizonLeft()
    _styleDesc:SetAutoResize()
    _styleDesc:SetTextMode(__eTextMode_AutoWrap)
    _styleDesc:SetText(desc)
    _styleDesc:SetShow(true)
    Panel_Tooltip_Author:SetSize(_styleDesc:GetTextSizeX() + 15, _styleDesc:GetTextSizeY() + 5)
  end
  Panel_Tooltip_Author:SetShow(true)
end
function TooltipAuthor_Common_Pos(posX, posY)
  Panel_Tooltip_Author:SetPosXY(posX, posY)
end
function TooltipAuthor_ShowSetSetPos_Console(pos, name, desc)
  if nil == pos.x then
    pos.x = 0
  end
  if nil == pos.y then
    pos.y = 0
  end
  Panel_Tooltip_Author:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/blackpanel_series.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Tooltip_Author, 127, 1, 189, 63)
  Panel_Tooltip_Author:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Tooltip_Author:setRenderTexture(Panel_Tooltip_Author:getBaseTexture())
  _mouseL:SetShow(false)
  _mouseR:SetShow(false)
  Panel_Tooltip_Author:SetPosXY(pos.x, pos.y)
  TooltipAuthor_CommonShow(name, desc)
end
function TooltipAuthor_Show(uiControl, name, desc, reversePosX)
  Panel_Tooltip_Author:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/blackpanel_series.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Tooltip_Author, 127, 1, 189, 63)
  Panel_Tooltip_Author:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Tooltip_Author:setRenderTexture(Panel_Tooltip_Author:getBaseTexture())
  _mouseL:SetShow(false)
  _mouseR:SetShow(false)
  TooltipAuthor_CommonShow(name, desc)
  local parentPos = {
    x = uiControl:GetParentPosX(),
    y = uiControl:GetParentPosY()
  }
  local size = {
    x = uiControl:GetSizeX(),
    y = uiControl:GetSizeY()
  }
  if uiControl:IsUISubApp() == true then
    TooltipAuthor_SetPosition_UISubApp(uiControl, size, reversePosX)
    Panel_Tooltip_Author:OpenUISubApp()
  else
    TooltipAuthor_SetPosition(parentPos, size, reversePosX)
  end
end
function TooltipAuthor_PCRoomHomeBuff_Show(uiControl, name, desc, reversePosX, needTime, useTime)
  Panel_Tooltip_Author:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/blackpanel_series.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Tooltip_Author, 127, 1, 189, 63)
  Panel_Tooltip_Author:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Tooltip_Author:setRenderTexture(Panel_Tooltip_Author:getBaseTexture())
  _mouseL:SetShow(false)
  _mouseR:SetShow(false)
  TooltipAuthor_CommonShow_Gauge(name, desc, needTime, useTime)
  local parentPos = {
    x = uiControl:GetParentPosX(),
    y = uiControl:GetParentPosY()
  }
  local size = {
    x = uiControl:GetSizeX(),
    y = uiControl:GetSizeY()
  }
  if uiControl:IsUISubApp() == true then
    TooltipAuthor_SetPosition_UISubApp(uiControl, size, reversePosX)
    Panel_Tooltip_Author:OpenUISubApp()
  else
    TooltipAuthor_SetPosition(parentPos, size, reversePosX)
  end
end
function TooltipAuthor_ShowUsePosSize(parentPos, size, name, desc)
  Panel_Tooltip_Author:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/blackpanel_series.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(Panel_Tooltip_Author, 127, 1, 189, 63)
  Panel_Tooltip_Author:getBaseTexture():setUV(x1, y1, x2, y2)
  Panel_Tooltip_Author:setRenderTexture(Panel_Tooltip_Author:getBaseTexture())
  _mouseL:SetShow(false)
  _mouseR:SetShow(false)
  TooltipAuthor_CommonShow(name, desc)
  TooltipAuthor_SetPosition(parentPos, size)
end
function TooltipAuthor_Hide()
  Panel_Tooltip_Author:SetShow(false)
  if Panel_Tooltip_Author:IsUISubApp() == true then
    Panel_Tooltip_Author:CloseUISubApp()
  end
  _gaugeBG:SetShow(false)
  _gaugeProgress:SetShow(false)
  _gaugeBarHead:SetShow(false)
  _gaugeTime:SetShow(false)
end
