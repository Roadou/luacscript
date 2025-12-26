PaGlobal_Edania_WorldMapTooltip = {
  _ui = {
    _txt_title = nil,
    _txt_castleInfoTitle = nil,
    _stc_castleIcon = nil,
    _txt_castleName = nil,
    _txt_occupationTitle = nil,
    _txt_occupationMark = nil,
    _txt_occupationOwner = nil,
    _txt_occupationDate = nil,
    _txt_occupationWeek = nil,
    _txt_accureTax = nil,
    _txt_tax = nil
  },
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Edania_WorldMapTooltip_Init")
function FromClient_Edania_WorldMapTooltip_Init()
  PaGlobal_Edania_WorldMapTooltip:initialize()
end
function PaGlobal_Edania_WorldMapTooltip:initialize()
  if Panel_Window_Edania_Worldmap_Castle == nil then
    return
  end
  if self._initialize == true then
    return
  end
  self._ui._txt_title = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_Title")
  self._ui._txt_castleInfoTitle = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_CastleInfoTItle")
  self._ui._stc_castleIcon = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "Static_SiteIcon")
  self._ui._txt_castleName = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_CastleName")
  self._ui._txt_occupationMark = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_OccupiersInfoMark")
  self._ui._txt_occupationTitle = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_OccupiersInfoTitle")
  self._ui._txt_occupationOwner = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_OccupationOwner")
  self._ui._txt_occupationDate = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_OccupationDate")
  self._ui._txt_occupationWeek = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_OccupationWeek")
  self._ui._txt_accureTax = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_AccrueTax")
  self._ui._txt_tax = UI.getChildControl(Panel_Window_Edania_Worldmap_Castle, "StaticText_Tax")
  self:registEventHandler()
  self:validate()
  self._initialize = true
end
function PaGlobal_Edania_WorldMapTooltip:registEventHandler()
  if Panel_Window_Edania_Worldmap_Castle == nil then
    return
  end
  registerEvent("FromClient_EdanaCastleTooltipShow", "FromClient_EdanaCastleTooltipShow")
  registerEvent("FromClient_EdanaCastleTooltipHide", "FromClient_EdanaCastleTooltipHide")
end
function PaGlobal_Edania_WorldMapTooltip:validate()
  if Panel_Window_Edania_Worldmap_Castle == nil then
    return
  end
  self._ui._txt_title:isValidate()
  self._ui._stc_castleIcon:isValidate()
  self._ui._txt_castleName:isValidate()
  self._ui._txt_occupationTitle:isValidate()
  self._ui._txt_occupationOwner:isValidate()
  self._ui._txt_occupationDate:isValidate()
  self._ui._txt_occupationWeek:isValidate()
  self._ui._txt_accureTax:isValidate()
  self._ui._txt_tax:isValidate()
end
function PaGlobal_Edania_WorldMapTooltip_Close()
  FromClient_EdanaCastleTooltipHide()
end
function FromClient_EdanaCastleTooltipShow(edanaCastleUI, edaniaRegion, edanaImageID)
  local self = PaGlobal_Edania_WorldMapTooltip
  if self == nil then
    return
  end
  if edanaCastleUI == nil or edanaCastleUI:GetShow() == false then
    return
  end
  self._ui._txt_title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_SYSTEM_REWARD_MAIL_SENDERNAME"))
  if edanaImageID ~= nil then
    self._ui._stc_castleIcon:ChangeTextureInfoTextureIDAsync(edanaImageID, 0)
    self._ui._stc_castleIcon:setRenderTexture(self._ui._stc_castleIcon:getBaseTexture())
  end
  self._ui._txt_castleName:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_WORLDMAP_CASTLE_NAME", "castlename", PaGlobal_Edania_Contents._data[edaniaRegion]._castleName))
  local edanaInfoWrapper = ToClient_GetEdanaInfo(edaniaRegion)
  if edanaInfoWrapper == nil then
    return
  end
  if edanaInfoWrapper:isEmpty() == true then
    self._ui._txt_occupationTitle:SetShow(false)
    self._ui._txt_occupationOwner:SetShow(false)
    self._ui._txt_occupationDate:SetShow(false)
    self._ui._txt_occupationWeek:SetShow(false)
    self._ui._txt_occupationMark:SetShow(false)
    self._ui._txt_accureTax:SetShow(false)
    self._ui._txt_tax:SetShow(false)
    Panel_Window_Edania_Worldmap_Castle:SetSize(Panel_Window_Edania_Worldmap_Castle:GetSizeX(), 180)
  else
    self._ui._txt_occupationTitle:SetShow(true)
    self._ui._txt_occupationOwner:SetShow(true)
    self._ui._txt_occupationDate:SetShow(true)
    self._ui._txt_occupationWeek:SetShow(true)
    self._ui._txt_occupationMark:SetShow(true)
    self._ui._txt_accureTax:SetShow(true)
    self._ui._txt_tax:SetShow(true)
    self._ui._txt_occupationTitle:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_occupationOwner:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_occupationDate:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_occupationWeek:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_accureTax:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_tax:SetTextMode(__eTextMode_AutoWrap)
    self._ui._txt_occupationOwner:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_WORLDMAP_OCCUPAIER_NAME", "familyname", edanaInfoWrapper:getUserNickName()))
    local registerDate = edanaInfoWrapper:getRegisterDate()
    self._ui._txt_occupationDate:SetText(PAGetStringParam4(Defines.StringSheet_GAME, "LUA_EDANIA_WORLDMAP_OCCUPY_TIME", "year", tostring(registerDate:GetYear()), "month", tostring(registerDate:GetMonth()), "day", tostring(registerDate:GetDay()), "time", tostring(registerDate:GetHour())))
    local occupyWeekValue = ToClient_GetEdanaCastleAccumulatedOccupiedCount(edaniaRegion)
    if occupyWeekValue ~= -1 then
      self._ui._txt_occupationWeek:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_EDANIA_WORLDMAP_OCCUPY_PERIOD", "value", occupyWeekValue + 1))
    else
      self._ui._txt_occupationWeek:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EDANIA_WORLDMAP_NO_OCCUPY_PERIOD"))
    end
    local taxString = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_EDANIA_WORLDMAP_TAX") .. " : " .. makeDotMoney(edanaInfoWrapper:getPreviousTax())
    self._ui._txt_tax:SetText(taxString)
    self._ui._txt_occupationTitle:SetPosY(self._ui._txt_castleName:GetPosY() + self._ui._txt_castleName:GetTextSizeY() + 10)
    self._ui._txt_occupationOwner:SetPosY(self._ui._txt_occupationTitle:GetPosY() + self._ui._txt_occupationTitle:GetTextSizeY())
    self._ui._txt_occupationDate:SetPosY(self._ui._txt_occupationOwner:GetPosY() + self._ui._txt_occupationOwner:GetTextSizeY())
    self._ui._txt_occupationWeek:SetPosY(self._ui._txt_occupationDate:GetPosY() + self._ui._txt_occupationDate:GetTextSizeY())
    self._ui._txt_accureTax:SetPosY(self._ui._txt_occupationWeek:GetPosY() + self._ui._txt_occupationWeek:GetTextSizeY() + 15)
    self._ui._txt_tax:SetPosY(self._ui._txt_accureTax:GetPosY() + self._ui._txt_accureTax:GetTextSizeY() - 5)
    self._ui._txt_occupationMark:SetPosY(self._ui._txt_occupationTitle:GetPosY() + 8)
    local panelSizeY = self._ui._txt_title:GetSizeY() + 20 + self._ui._txt_castleInfoTitle:GetTextSizeY() + 5 + self._ui._txt_castleName:GetTextSizeY() + 10 + self._ui._txt_occupationTitle:GetTextSizeY() + self._ui._txt_occupationOwner:GetTextSizeY() + self._ui._txt_occupationDate:GetTextSizeY() + self._ui._txt_occupationWeek:GetTextSizeY() + 20 + self._ui._txt_accureTax:GetTextSizeY() + 10 + self._ui._txt_tax:GetTextSizeY() + 10
    Panel_Window_Edania_Worldmap_Castle:SetSize(Panel_Window_Edania_Worldmap_Castle:GetSizeX(), panelSizeY)
  end
  local posX = edanaCastleUI:GetPosX()
  local posY = edanaCastleUI:GetPosY()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local infoTooltipIsRight = true
  if _ContentsGroup_UsePadSnapping == false then
    if posX / screenSizeX > 0.5 then
      posX = posX - Panel_Window_Edania_Worldmap_Castle:GetSizeX()
      infoTooltipIsRight = false
    else
      posX = posX + edanaCastleUI:GetSizeX()
    end
    if posY / screenSizeY > 0.5 then
      posY = posY - Panel_Window_Edania_Worldmap_Castle:GetSizeY()
    end
  else
    posX = screenSizeX / 2 + edanaCastleUI:GetSizeX() - 50
    posY = screenSizeY / 2 - Panel_Window_Edania_Worldmap_Castle:GetSizeY() / 2
  end
  Panel_Window_Edania_Worldmap_Castle:SetPosX(posX)
  Panel_Window_Edania_Worldmap_Castle:SetPosY(posY)
  Panel_Window_Edania_Worldmap_Castle:SetShow(true)
end
function FromClient_EdanaCastleTooltipHide()
  local self = PaGlobal_Edania_WorldMapTooltip
  if self == nil then
    return
  end
  Panel_Window_Edania_Worldmap_Castle:SetShow(false)
end
