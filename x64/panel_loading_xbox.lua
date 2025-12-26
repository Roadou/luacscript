Panel_Loading_Xbox:SetShow(true)
Panel_Loading_Xbox:SetOffsetIgnorePanel(true)
Panel_Loading_Xbox:ignorePadSnapUpdate(false)
Panel_Loading_Xbox:SetEnable(false)
local _knowledge_title = UI.getChildControl(Panel_Loading_Xbox, "StaticText_knowTitle")
local static_LoadingCircle = UI.getChildControl(Panel_Loading_Xbox, "Static_LoadingCircle")
local static_LoadingBlackSpirit = UI.getChildControl(Panel_Loading_Xbox, "Static_LoadingBlackSpirit")
local staticText_LoadingProgress = UI.getChildControl(Panel_Loading_Xbox, "StaticText_LoadingProgress")
local txt_versionInfo = UI.getChildControl(Panel_Loading_Xbox, "StaticText_VersionInfo")
static_LoadingCircle:SetAlpha(0)
static_LoadingBlackSpirit:SetAlpha(0)
static_LoadingCircle:SetShow(false)
static_LoadingBlackSpirit:SetShow(false)
staticText_LoadingProgress:SetShow(false)
_knowledge_title:SetShow(false)
local screenX, screenY = getScreenSizeX(), getScreenSizeY()
local tempTime = 0
Panel_Loading_Xbox:SetSize(screenX, screenY)
Panel_Loading_Xbox:ComputePos()
txt_versionInfo:ComputePos()
txt_versionInfo:SetShow(_ContentsGroup_XB_Obt)
local currentMaxProgress = 1
local currentProgress = 0
local alphaValue = 0
local completeAckCount = 0
local isIndependent = false
function update_XboxLoadingCircle(deltaTime)
  tempTime = tempTime + deltaTime
  _knowledge_title:SetText(math.floor(tempTime))
  static_LoadingCircle:SetShow(true)
  static_LoadingBlackSpirit:SetShow(true)
  staticText_LoadingProgress:SetShow(true)
  currentProgress = currentProgress + deltaTime * (math.random(0, currentMaxProgress - currentProgress) / 10)
  if currentMaxProgress < currentProgress then
    currentProgress = currentMaxProgress
  end
  staticText_LoadingProgress:SetText(tostring(math.floor(currentProgress)) .. "%")
  alphaValue = alphaValue + 0.008
  static_LoadingCircle:SetAlpha(alphaValue)
  static_LoadingBlackSpirit:SetAlpha(alphaValue)
  static_LoadingCircle:SetPosX(screenX - static_LoadingCircle:GetSizeX() - static_LoadingCircle:GetSizeX() * 0.8)
  static_LoadingCircle:SetPosY(screenY - static_LoadingCircle:GetSizeY() - static_LoadingCircle:GetSizeY() * 0.4)
  static_LoadingBlackSpirit:SetPosX(static_LoadingCircle:GetPosX() + static_LoadingCircle:GetSizeX() * 0.5 - static_LoadingBlackSpirit:GetSizeX() * 0.5)
  static_LoadingBlackSpirit:SetPosY(static_LoadingCircle:GetPosY() + static_LoadingCircle:GetSizeY() * 0.5 - static_LoadingBlackSpirit:GetSizeY() * 0.5)
  staticText_LoadingProgress:SetPosX(static_LoadingCircle:GetPosX() + static_LoadingCircle:GetSizeX() * 0.5 - staticText_LoadingProgress:GetSizeX() * 0.4)
  staticText_LoadingProgress:SetPosY(static_LoadingCircle:GetPosY() + static_LoadingCircle:GetSizeY())
end
function updateIndependent(deltaTime)
  if isIndependent == false then
    return
  end
  update_XboxLoadingCircle(deltaTime)
end
function LoadingPanel_SetCurrentMaxProgress_Xbox(curMaxRate)
  currentProgress = currentMaxProgress
  currentMaxProgress = curMaxRate
end
function LoadingPanel_AddCurrentMaxProgress_Xbox()
  completeAckCount = completeAckCount + 1
  curMaxRate = 20 * completeAckCount
  if curMaxRate >= 100 then
    curMaxRate = 99
  end
  currentProgress = currentMaxProgress
  currentMaxProgress = curMaxRate
end
function LoadingPanel_SetIndependent(flag)
  isIndependent = flag
  if flag == true and Panel_CharacterSelect_All ~= nil then
    Panel_CharacterSelect_All:SetShow(false)
  end
end
registerEvent("FromClient_currentProgressMaxRate", "LoadingPanel_SetCurrentMaxProgress_Xbox")
registerEvent("FromClient_AddProgressMaxRate", "LoadingPanel_AddCurrentMaxProgress_Xbox")
registerEvent("FromClient_OpenXboxLoadingPanel", "LoadingPanel_SetIndependent")
Panel_Loading_Xbox:RegisterUpdateFunc("updateIndependent")
