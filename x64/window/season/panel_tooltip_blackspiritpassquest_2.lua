function PaGlobal_BlackspiritPassTooltipQuest:initialize()
  if true == self._initialize then
    return
  end
  local textBg = UI.getChildControl(Panel_Widget_Tooltip_BlackSpiritPass_Quest, "StaticText_TitleBg")
  self._ui._txt_title = UI.getChildControl(textBg, "StaticText_Title")
  self._ui._stc_descBG = UI.getChildControl(Panel_Widget_Tooltip_BlackSpiritPass_Quest, "Static_BG")
  self._ui._txt_desc = UI.getChildControl(self._ui._stc_descBG, "StaticText_DESC")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_BlackspiritPassTooltipQuest:registEventHandler()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
end
function PaGlobal_BlackspiritPassTooltipQuest:prepareOpenConsole(index)
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  if nil == PaGlobal_BlackspiritPass then
    return
  end
  local questInfo = PaGlobal_BlackspiritPass._questInfo[index]
  if nil == questInfo then
    return
  end
  local questWrapper = ToClient_GetSeasonPassQuestAt(index, __eSeasonPassQuest_Normal)
  if nil == questWrapper then
    return
  end
  self._ui._txt_title:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_title:SetText(questWrapper:getTitle())
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(ToClient_getReplaceDialog(questWrapper:getDesc()))
  self:setPositionForConsole(index)
  self:setSizeY()
  PaGlobal_BlackspiritPassTooltipQuest:open()
end
function PaGlobal_BlackspiritPassTooltipQuest:prepareOpen(index)
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  if nil == PaGlobal_BlackspiritPass then
    return
  end
  local questInfo = PaGlobal_BlackspiritPass._questInfo[index]
  if nil == questInfo then
    return
  end
  local questWrapper = ToClient_GetSeasonPassQuestAt(index, __eSeasonPassQuest_Normal)
  if nil == questWrapper then
    return
  end
  self._ui._txt_title:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_title:SetText(questWrapper:getTitle())
  self._ui._txt_desc:SetTextMode(__eTextMode_AutoWrap)
  self._ui._txt_desc:SetText(ToClient_getReplaceDialog(questWrapper:getDesc()))
  self:setPosition()
  self:setSizeY()
  PaGlobal_BlackspiritPassTooltipQuest:open()
end
function PaGlobal_BlackspiritPassTooltipQuest:open()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  Panel_Widget_Tooltip_BlackSpiritPass_Quest:SetShow(true)
end
function PaGlobal_BlackspiritPassTooltipQuest:prepareClose()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  PaGlobal_BlackspiritPassTooltipQuest:close()
end
function PaGlobal_BlackspiritPassTooltipQuest:close()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  Panel_Widget_Tooltip_BlackSpiritPass_Quest:SetShow(false)
end
function PaGlobal_BlackspiritPassTooltipQuest:update()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
end
function PaGlobal_BlackspiritPassTooltipQuest:validate()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._stc_descBG:isValidate()
  self._ui._txt_desc:isValidate()
end
function PaGlobal_BlackspiritPassTooltipQuest:setPositionForConsole(index)
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  local seasonPassAndRoadMapPanel = Panel_Window_BeginnerRoadmap
  if seasonPassAndRoadMapPanel == nil then
    return
  end
  local seasonPassArea = UI.getChildControl(seasonPassAndRoadMapPanel, "Static_BlackspiritPass")
  if seasonPassArea == nil then
    return
  end
  local posX = seasonPassArea:GetPosX() + seasonPassArea:GetSizeX() + 15
  local posY = seasonPassArea:GetPosY() + 242
  Panel_Widget_Tooltip_BlackSpiritPass_Quest:SetPosXY(posX, posY)
end
function PaGlobal_BlackspiritPassTooltipQuest:setPosition()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local panelPosX = mousePosX + 15
  local panelPosY = mousePosY + 15
  local panelSizeX = Panel_Widget_Tooltip_BlackSpiritPass_Quest:GetSizeX()
  local panelSizeY = Panel_Widget_Tooltip_BlackSpiritPass_Quest:GetSizeY()
  if screenSizeX < panelPosX + panelSizeX then
    panelPosX = mousePosX - panelSizeX - 15
  end
  if screenSizeY < panelPosY + panelSizeY then
    panelPosY = mousePosY - panelSizeY - 15
  end
  Panel_Widget_Tooltip_BlackSpiritPass_Quest:SetPosXY(panelPosX, panelPosY)
end
function PaGlobal_BlackspiritPassTooltipQuest:setSizeY()
  if nil == Panel_Widget_Tooltip_BlackSpiritPass_Quest then
    return
  end
  local txtSizeY = self._ui._txt_desc:GetTextSizeY()
  self._ui._txt_desc:SetSize(self._ui._txt_desc:GetSizeX(), txtSizeY)
  local spanSizeY = 20
  self._ui._stc_descBG:SetSize(self._ui._stc_descBG:GetSizeX(), txtSizeY + spanSizeY)
  local panelSizeY = self._ui._stc_descBG:GetPosY() + self._ui._stc_descBG:GetSizeY()
  Panel_Widget_Tooltip_BlackSpiritPass_Quest:SetSize(Panel_Widget_Tooltip_BlackSpiritPass_Quest:GetSizeX(), panelSizeY)
end
