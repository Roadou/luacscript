local UI_color = Defines.Color
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_VT = CppEnums.VehicleType
Panel_Cannon:SetShow(false, false)
Panel_Cannon:RegisterShowEventFunc(true, "CannonShowAni()")
Panel_Cannon:RegisterShowEventFunc(false, "CannonHideAni()")
local _enum_CannonType = {
  _default = 0,
  _cannon = 1,
  _throwStone = 2,
  _throwStoneUpgrade = 3,
  _throwFire = 4,
  _ballista = 5,
  _train = 6,
  _monsterHuntCannon = 7
}
local _current_cannonActorKeyRaw = 0
local _current_cannonCharacterKeyRaw = 0
local fireGuide = {
  fireGuide_BG = UI.getChildControl(Panel_Cannon, "Static_CommandBG"),
  fireGuide_KeyR = nil,
  fireGuide_KeyS = nil,
  fireGuide_KeyW = nil,
  fireGuide_MouseL = nil,
  fireGuide_MouseR = nil,
  fireGuide_MouseL2 = nil,
  fireGuide_MouseR2 = nil,
  fireGuide_Space = nil,
  fireGuide_Text_High = nil,
  fireGuide_Text_Low = nil,
  fireGuide_Text_Fire = nil,
  fireGuide_Text_Fire_2 = nil,
  fireGuide_Text_ContinueFire = nil
}
fireGuide.fireGuide_KeyR = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_Key_R")
fireGuide.fireGuide_KeyS = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_Key_S")
fireGuide.fireGuide_KeyW = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_Key_W")
fireGuide.fireGuide_MouseL = UI.getChildControl(fireGuide.fireGuide_BG, "Static_Key_MouseL_0")
fireGuide.fireGuide_MouseR = UI.getChildControl(fireGuide.fireGuide_BG, "Static_Key_MouseR_0")
fireGuide.fireGuide_MouseL2 = UI.getChildControl(fireGuide.fireGuide_BG, "Static_Key_MouseL_1")
fireGuide.fireGuide_MouseR2 = UI.getChildControl(fireGuide.fireGuide_BG, "Static_Key_MouseR_1")
fireGuide.fireGuide_Space = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_Key_Space")
fireGuide.fireGuide_Text_High = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_HighAngle")
fireGuide.fireGuide_Text_Low = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_LowAngle")
fireGuide.fireGuide_Text_Fire = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_Fire")
fireGuide.fireGuide_Text_Fire_2 = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_Fire2")
fireGuide.fireGuide_Text_ContinueFire = UI.getChildControl(fireGuide.fireGuide_BG, "StaticText_ContinueFire")
fireGuide.fireGuide_Text_High:SetSize(fireGuide.fireGuide_Text_High:GetTextSizeX(), fireGuide.fireGuide_Text_High:GetSizeY())
fireGuide.fireGuide_Text_Low:SetSize(fireGuide.fireGuide_Text_Low:GetTextSizeX(), fireGuide.fireGuide_Text_Low:GetSizeY())
fireGuide.fireGuide_Text_Fire:SetSize(fireGuide.fireGuide_Text_Fire:GetTextSizeX(), fireGuide.fireGuide_Text_Fire:GetSizeY())
fireGuide.fireGuide_Text_Fire_2:SetSize(fireGuide.fireGuide_Text_Fire_2:GetTextSizeX(), fireGuide.fireGuide_Text_Fire_2:GetSizeY())
fireGuide.fireGuide_Text_ContinueFire:SetSize(fireGuide.fireGuide_Text_ContinueFire:GetTextSizeX(), fireGuide.fireGuide_Text_ContinueFire:GetSizeY())
function CannonShowAni()
  local aniInfo1 = Panel_Cannon:addScaleAnimation(0, 0.08, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartScale(0.5)
  aniInfo1:SetEndScale(1.05)
  aniInfo1.AxisX = Panel_Cannon:GetSizeX() / 2
  aniInfo1.AxisY = Panel_Cannon:GetSizeY() / 2
  aniInfo1.ScaleType = 2
  aniInfo1.IsChangeChild = true
  local aniInfo2 = Panel_Cannon:addScaleAnimation(0.08, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartScale(1.05)
  aniInfo2:SetEndScale(1)
  aniInfo2.AxisX = Panel_Cannon:GetSizeX() / 2
  aniInfo2.AxisY = Panel_Cannon:GetSizeY() / 2
  aniInfo2.ScaleType = 2
  aniInfo2.IsChangeChild = true
end
function CannonHideAni()
  Panel_Cannon:SetShowWithFade(CppEnums.PAUI_SHOW_FADE_TYPE.PAUI_ANI_TYPE_FADE_OUT)
  local aniInfo1 = Panel_Cannon:addColorAnimation(0, 0.15, UI_ANI_ADV.PAUI_ANIM_ADVANCE_SIN_HALF_PI)
  aniInfo1:SetStartColor(UI_color.C_FFFFFFFF)
  aniInfo1:SetEndColor(UI_color.C_00FFFFFF)
  aniInfo1:SetStartIntensity(3)
  aniInfo1:SetEndIntensity(1)
  aniInfo1.IsChangeChild = true
  aniInfo1:SetHideAtEnd(true)
  aniInfo1:SetDisableWhileAni(true)
end
local Cannon_Initialize = function()
end
local nowCool = 0
local cannon = {}
function Cannon_KeyGuideBgSizeAlign(BgControl, childList)
  if BgControl == nil or childList == nil then
    return
  end
  local resultSizeX = 0
  local resultSizeY = 0
  for index, control in pairs(childList) do
    if control ~= nil then
      local sizeX = control:GetPosX() + control:GetSizeX()
      local sizeY = control:GetPosY() + control:GetSizeY()
      if resultSizeX < sizeX then
        resultSizeX = sizeX
      end
      if resultSizeY < sizeY then
        resultSizeY = sizeY
      end
    end
  end
  BgControl:SetSize(resultSizeX + 20, resultSizeY + 10)
  local screenX = getScreenSizeX()
  local screenY = getScreenSizeY()
  Panel_Cannon:SetSize(BgControl:GetSizeX(), BgControl:GetSizeY())
  Panel_Cannon:SetPosX(screenX / 3 * 2 - 100)
  Panel_Cannon:SetPosY(screenY / 2 - Panel_Cannon:GetSizeY() / 2)
end
function Cannon_AbyssOne_ShowLostCannon(show)
  fireGuide.fireGuide_BG:SetShow(show)
  fireGuide.fireGuide_KeyR:SetShow(show)
  fireGuide.fireGuide_KeyS:SetShow(show)
  fireGuide.fireGuide_KeyW:SetShow(show)
  fireGuide.fireGuide_MouseL:SetShow(show)
  fireGuide.fireGuide_MouseR:SetShow(show)
  fireGuide.fireGuide_MouseL2:SetShow(show)
  fireGuide.fireGuide_MouseR2:SetShow(show)
  fireGuide.fireGuide_Space:SetShow(show)
  fireGuide.fireGuide_Text_High:SetShow(show)
  fireGuide.fireGuide_Text_Low:SetShow(show)
  fireGuide.fireGuide_Text_Fire:SetShow(show)
  fireGuide.fireGuide_Text_Fire_2:SetShow(show)
  fireGuide.fireGuide_Text_ContinueFire:SetShow(show)
  local array = Array.new()
  array:push_back(fireGuide.fireGuide_KeyR)
  array:push_back(fireGuide.fireGuide_KeyS)
  array:push_back(fireGuide.fireGuide_KeyW)
  array:push_back(fireGuide.fireGuide_MouseL)
  array:push_back(fireGuide.fireGuide_MouseR)
  array:push_back(fireGuide.fireGuide_MouseL2)
  array:push_back(fireGuide.fireGuide_MouseR2)
  array:push_back(fireGuide.fireGuide_Space)
  array:push_back(fireGuide.fireGuide_Text_High)
  array:push_back(fireGuide.fireGuide_Text_Low)
  array:push_back(fireGuide.fireGuide_Text_Fire)
  array:push_back(fireGuide.fireGuide_Text_Fire_2)
  array:push_back(fireGuide.fireGuide_Text_ContinueFire)
  fireGuide.fireGuide_MouseR:SetColor(UI_color.C_FF000000)
  fireGuide.fireGuide_MouseL2:SetColor(UI_color.C_FF000000)
  Cannon_KeyGuideBgSizeAlign(fireGuide.fireGuide_BG, array)
  if show == true and PaGlobalFunc_CannonStack_UpdatePanelPos ~= nil then
    PaGlobalFunc_CannonStack_UpdatePanelPos(Panel_Cannon:GetPosX(), Panel_Cannon:GetPosY() + Panel_Cannon:GetSizeY() + 5)
  end
end
function Cannon_GuideShow(show)
  if _ContentsGroup_UsePadSnapping == true then
    return
  end
  for _, value in pairs(fireGuide) do
    value:SetShow(false)
  end
  if _current_cannonCharacterKeyRaw == 61036 then
    Cannon_AbyssOne_ShowLostCannon(show)
  end
end
function FromClient_Cannon_Show(actorKeyRaw)
  if Panel_Cannon:GetShow() == true then
    return
  end
  local selfPlayer = getSelfPlayer()
  if selfPlayer == nil then
    return
  end
  local vehicleActorProxyWrapper = getVehicleActor(actorKeyRaw)
  if vehicleActorProxyWrapper == nil then
    return
  end
  if vehicleActorProxyWrapper:get():isCannon() == false then
    return
  end
  local seatPosition = selfPlayer:get():getVehicleSeatIndex()
  local vehicleMainType = vehicleActorProxyWrapper:get():getVehicleType()
  local vehicleSubType = vehicleActorProxyWrapper:get():getVehicleSubType()
  _current_cannonCharacterKeyRaw = vehicleActorProxyWrapper:getCharacterKeyRaw()
  _current_cannonActorKeyRaw = actorKeyRaw
  Cannon_Initialize()
  Cannon_GuideShow(true)
  Panel_Cannon:SetShow(true, true)
end
function FromClient_Cannon_Hide()
  if Panel_Cannon:GetShow() == false then
    return
  end
  _current_cannonActorKeyRaw = 0
  _current_cannonCharacterKeyRaw = 0
  Cannon_GuideShow(false)
  Panel_Cannon:SetShow(false, true)
end
Cannon_Initialize()
registerEvent("EventSelfPlayerRideOn", "FromClient_Cannon_Show")
registerEvent("EventSelfPlayerRideOff", "FromClient_Cannon_Hide")
