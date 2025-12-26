Panel_House_InstallationMode_VillageTent:SetShow(false)
Panel_House_InstallationMode_VillageTent:setMaskingChild(true)
Panel_House_InstallationMode_VillageTent:ActiveMouseEventEffect(true)
Panel_House_InstallationMode_VillageTent:setGlassBackground(true)
local bg = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Static_VillageTentBG")
local btnClose = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Button_CloseIcon")
local btnApply = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Button_Apply")
local templateDay = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_DayTemplate")
local templateRegion = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_RegionTemplate")
local joinDesc = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_VillageTent_JoinDesc")
local bottomBg = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "Static_NoticeBg")
local bottomDesc = UI.getChildControl(Panel_House_InstallationMode_VillageTent, "StaticText_NoticeDesc")
bottomDesc:SetTextMode(__eTextMode_AutoWrap)
bottomDesc:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_HOUSE_INSTALLATIONMODE_VILLAGETENTPOPUP_DESC"))
local regionInfoWrapper = {}
local dayControl = {}
local dayCount = 0
local UI_VT = CppEnums.VillageSiegeType
joinDesc:SetTextMode(__eTextMode_AutoWrap)
btnClose:addInputEvent("Mouse_LUp", "VillageTent_Close()")
btnApply:addInputEvent("Mouse_LUp", "VillageTent_SetRegion()")
templateDay:SetShow(false)
templateRegion:SetShow(false)
local posY = templateDay:GetPosY()
local textGap = 25
local maxCount = 7
local dayString = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY")
}
local dayStringShort = {
  [UI_VT.eVillageSiegeType_Sunday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SUNDAY"),
  [UI_VT.eVillageSiegeType_Monday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_MONDAY"),
  [UI_VT.eVillageSiegeType_Tuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_TUESDAY"),
  [UI_VT.eVillageSiegeType_Wednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_WEDNESDAY"),
  [UI_VT.eVillageSiegeType_Thursday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_THURSDAY"),
  [UI_VT.eVillageSiegeType_Friday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_FRIDAY"),
  [UI_VT.eVillageSiegeType_Saturday] = PAGetString(Defines.StringSheet_GAME, "LUA_DAYOFWEEK_SATURDAY")
}
function VillageTent_Init()
  dayControl = {}
  local temp = {}
  for index = 0, maxCount - 1 do
    dayControl[index] = {}
    temp[index] = {}
    temp[index]._day = UI.createControl(__ePAUIControl_StaticText, Panel_House_InstallationMode_VillageTent, "StaticText_Day_" .. index)
    CopyBaseProperty(templateDay, temp[index]._day)
    temp[index]._day:SetPosY(posY + index * textGap)
    temp[index]._day:SetShow(false)
    temp[index]._regionName = UI.createControl(__ePAUIControl_StaticText, Panel_House_InstallationMode_VillageTent, "StaticText_RegionName_" .. index)
    CopyBaseProperty(templateRegion, temp[index]._regionName)
    temp[index]._regionName:SetPosY(posY + index * textGap)
    temp[index]._regionName:SetShow(false)
    dayControl[index] = temp[index]
  end
end
function FGlobal_VillageTent_SelectPopup()
  local position = housing_getInstallationPos()
  local count = housing_getInstallableSiegeKeyList(position)
  local regionWrapper = housing_getInstallableSiegeRegionInfo(0)
  local msgBoxDesc = ""
  local dayStr = ""
  if nil ~= regionWrapper then
    local territoryKey = regionWrapper:getTerritoryKeyRaw()
    local villageSiegeType = regionWrapper:getVillageSiegeType()
    local today = ToClient_GetDayOfWeek()
    if _ContentsGroup_MinorSiege2022 == true then
      dayStr = dayStringShort[villageSiegeType]
    else
      for ii = 0, UI_VT.eVillageSiegeType_Count - 1 do
        local findDay = ii + today
        if findDay >= UI_VT.eVillageSiegeType_Count then
          findDay = findDay % UI_VT.eVillageSiegeType_Count
        end
        if true == ToClient_checkSiegeDayByRawKey(territoryKey, findDay) then
          dayStr = dayStringShort[findDay]
          break
        end
      end
    end
  end
  msgBoxDesc = PAGetStringParam3(Defines.StringSheet_GAME, "LUA_POPUP_LOCALSIEGE_BUILDCASTLE_DESC", "territory", regionWrapper:getTerritoryName(), "region", regionWrapper:getAreaName(), "date", dayStr)
  local messageBoxData = {
    title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_VILLAGETENT_TITLE"),
    content = msgBoxDesc,
    functionYes = VillageTent_SetRegion,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
end
function VillageTent_SetSize(count)
  bg:SetSize(bg:GetSizeX(), 70 + (count - 1) * textGap)
  joinDesc:SetPosY(dayControl[count - 1]._day:GetPosY() + 45)
  bottomDesc:SetPosY(joinDesc:GetPosY() + joinDesc:GetTextSizeY() + 15)
  bottomBg:SetSize(bottomBg:GetSizeX(), bottomDesc:GetTextSizeY() + 15)
  Panel_House_InstallationMode_VillageTent:SetSize(Panel_House_InstallationMode_VillageTent:GetSizeX(), joinDesc:GetPosY() + joinDesc:GetTextSizeY() + bottomBg:GetSizeY() + 70)
  bottomBg:ComputePos()
  btnApply:ComputePos()
end
function VillageTent_ChangeFontColor(index)
  for ii = 0, dayCount - 1 do
    if ii == index then
      dayControl[ii]._day:SetFontColor(Defines.Color.C_FFFFCE22)
      dayControl[ii]._regionName:SetFontColor(Defines.Color.C_FFFFCE22)
      dayCheck = true
    else
      dayControl[ii]._day:SetFontColor(Defines.Color.C_FFC4BEBE)
      dayControl[ii]._regionName:SetFontColor(Defines.Color.C_FFC4BEBE)
    end
  end
end
function VillageTent_SetRegion()
  local position = housing_getInstallationPos()
  local countOfSiege = ToClient_getJoinableSiegeCount(position)
  local regionKeyRaw = ToClient_getJoinableSiegeKeyAt(position, 0)
  if true == ToClient_IsRemoteInstallMode() then
    ToClient_InsertRemoteInstall(regionKeyRaw)
    ToClient_EndRemoteInstall()
  else
    housing_InstallObject(regionKeyRaw)
  end
  if true == _ContentsGroup_NewUI_InstallMode_All then
    PaGlobal_House_InstallationMode_ObjectControl_All_Cancel()
    PaGlobal_House_Installation_All_Close()
  else
    FGlobal_HouseInstallationControl_Close()
    FGlobal_House_InstallationMode_Close()
  end
end
function VillageTent_Close()
  Panel_House_InstallationMode_VillageTent:SetShow(false)
end
VillageTent_Init()
