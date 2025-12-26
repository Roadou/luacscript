function PaGlobal_ServantUpgradeInfo_Close()
  if true == PaGlobal_ServantUpgradeInfo._isConsole then
    return
  end
  PaGlobal_ServantUpgradeInfo:close()
end
function PaGlobal_ServantUpgradeInfo_Tooltip(fromCharacterKeyRaw, toCharacterKeyRaw)
  local self = PaGlobal_ServantUpgradeInfo
  if true == self:setServantInfo(fromCharacterKeyRaw, 0) and true == self:setServantInfo(toCharacterKeyRaw, 1) then
    for ii = 0, self._dataType.TypeCount - 1 do
      local str = self:makeString(self._dataList[ii][1], self._dataList[ii][0], self._dataTypeUnit[ii].unitStr, self._dataTypeUnit[ii].unitValue, self._dataTypeUnit[ii].dp)
      self._controlList[ii]:SetText(str)
    end
    if false == Panel_Window_ServantUpgradeInfo:GetShow() then
      Panel_Window_ServantUpgradeInfo:SetShow(true)
    else
      Panel_Window_ServantUpgradeInfo:SetShow(false)
    end
    PaGlobal_ServantUpgradeInfo_reposition()
  else
    Panel_Window_ServantUpgradeInfo:SetShow(false)
  end
end
function PaGlobal_ServantUpgradeInfo_reposition()
  if nil == Panel_Window_ServantUpgrade or nil == Panel_Window_ServantUpgradeInfo then
    return
  end
  local mousePosX = getMousePosX()
  local mousePosY = getMousePosY()
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  Panel_Window_ServantUpgradeInfo:SetPosXY(mousePosX + 15, mousePosY + 15)
  if screenSizeX < Panel_Window_ServantUpgradeInfo:GetPosX() + Panel_Window_ServantUpgradeInfo:GetSizeX() then
    Panel_Window_ServantUpgradeInfo:SetPosX(mousePosX - Panel_Window_ServantUpgradeInfo:GetSizeX())
  else
    Panel_Window_ServantUpgradeInfo:SetPosX(mousePosX + 15)
  end
  if screenSizeY < Panel_Window_ServantUpgradeInfo:GetPosY() + Panel_Window_ServantUpgradeInfo:GetSizeY() then
    Panel_Window_ServantUpgradeInfo:SetPosY(mousePosY - Panel_Window_ServantUpgradeInfo:GetSizeY())
  else
    Panel_Window_ServantUpgradeInfo:SetPosY(mousePosY + 15)
  end
end
