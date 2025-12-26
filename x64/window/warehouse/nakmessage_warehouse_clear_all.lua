PaGlobal_Warehouse_Clear = {
  _ui = {_txt_DescMain, _txt_DescSub},
  _showFlag = false,
  _warehouseName = nil,
  _closeDelta = 0,
  _initialize = false
}
registerEvent("FromClient_luaLoadComplete", "FromClient_Warehouse_Clear_Init")
function FromClient_Warehouse_Clear_Init()
  PaGlobal_Warehouse_Clear:initialize()
end
function PaGlobal_Warehouse_Clear:initialize()
  if self._initialize == true then
    return
  end
  local Static_MainBG = UI.getChildControl(NakMessage_Warehouse_Clear, "Static_MainBG")
  local Static_Desc_BG = UI.getChildControl(Static_MainBG, "Static_Desc_BG")
  self._ui._txt_DescMain = UI.getChildControl(Static_Desc_BG, "StaticText_Desc_1")
  self._ui._txt_DescSub = UI.getChildControl(Static_Desc_BG, "StaticText_Desc_2")
  self:validate()
  NakMessage_Warehouse_Clear:RegisterShowEventFunc(true, "NakMessage_Warehouse_Clear_ShowAni()")
  NakMessage_Warehouse_Clear:RegisterShowEventFunc(false, "NakMessage_Warehouse_Clear_HideAni()")
  registerEvent("FromClient_AbyssOneWarehouseOpenNak", "FromClient_AbyssOneWarehouseOpenNak")
  self._initialize = true
end
function PaGlobal_Warehouse_Clear:validate()
  if NakMessage_Warehouse_Clear == nil then
    return
  end
  self._ui._txt_DescMain:isValidate()
  self._ui._txt_DescSub:isValidate()
end
function PaGlobal_Warehouse_Clear:prepareOpen(warehouseName)
  if NakMessage_Warehouse_Clear == nil or warehouseName == nil then
    return
  end
  self._ui._txt_DescMain:SetText(PAGetStringParam1(Defines.StringSheet_GAME, "LUA_ABYSSONE_WAREHOUSE_OPEN_TITLE", "territoryName", warehouseName))
  if _ContentsGroup_RenewUI == true then
    local selfPlayer = getSelfPlayer()
    local currentRegionKeyRaw = selfPlayer:getRegionKeyRaw()
    if currentRegionKeyRaw == 202 then
      self._ui._txt_DescMain:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ABYSSONE_WAREHOUSE_OPEN_TITLE_CS"))
    end
  end
  self._ui._txt_DescSub:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_ABYSSONE_WAREHOUSE_OPEN_DESC"))
  self._closeDelta = 0
  self:open()
end
function PaGlobal_Warehouse_Clear:open()
  if NakMessage_Warehouse_Clear == nil then
    return
  end
  audioPostEvent_SystemUi(33, 1)
  _AudioPostEvent_SystemUiForXBOX(33, 1)
  NakMessage_Warehouse_Clear:SetShow(true, true)
end
function PaGlobal_Warehouse_Clear:prepareClose()
  if NakMessage_Warehouse_Clear == nil then
    return
  end
  self:close()
end
function PaGlobal_Warehouse_Clear:close()
  if NakMessage_Warehouse_Clear == nil then
    return
  end
  NakMessage_Warehouse_Clear:SetShow(false, true)
end
function NakMessage_Warehouse_Clear_ShowAni()
  NakMessage_Warehouse_Clear:SetAlpha(0)
  local aniInfo = UIAni.AlphaAnimation(1, NakMessage_Warehouse_Clear, 0, 0.5)
end
function NakMessage_Warehouse_Clear_HideAni()
  NakMessage_Warehouse_Clear:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, NakMessage_Warehouse_Clear, 0, 0.5)
  aniInfo:SetHideAtEnd(true)
end
function FromClient_AbyssOneWarehouseOpenNak(warehouseName)
  if PaGlobal_Warehouse_Clear == nil or warehouseName == nil then
    return
  end
  PaGlobal_Warehouse_Clear._showFlag = true
  PaGlobal_Warehouse_Clear._warehouseName = warehouseName
end
function PaGlobal_Warehouse_Clear:update(deltaTime)
  if NakMessage_Warehouse_Clear == nil then
    return
  end
  self._closeDelta = self._closeDelta + deltaTime
  if self._closeDelta < 5 then
    return
  end
  self:prepareClose()
end
function PaGlobalFunc_Warehouse_Clear_UpdatePerFrame(deltaTime)
  local self = PaGlobal_Warehouse_Clear
  if self == nil or NakMessage_Warehouse_Clear == nil then
    return
  end
  local currentUIMode = GetUIMode()
  if currentUIMode ~= Defines.UIMode.eUIMode_Default then
    return
  end
  if NakMessage_Warehouse_Clear:GetShow() == true then
    self:update(deltaTime)
  else
    if self._showFlag == false then
      return
    end
    self:prepareOpen(self._warehouseName)
    self._showFlag = false
    self._warehouseName = nil
  end
end
