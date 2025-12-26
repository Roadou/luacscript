Panel_Logo:SetShow(true, false)
Panel_Logo:SetSize(getScreenSizeX(), getScreenSizeY())
local static_PearlAbyss = UI.getChildControl(Panel_Logo, "Static_Pearl")
local static_Daum = UI.getChildControl(Panel_Logo, "Static_Daum")
local static_Grade = UI.getChildControl(Panel_Logo, "Static_Grade")
local staticText_Warning = UI.getChildControl(Panel_Logo, "MultilineText_Warning")
local staticText_WarningCH = UI.getChildControl(Panel_Logo, "MultilineText_WarningCH")
local staticText_Warning1 = UI.getChildControl(staticText_WarningCH, "MultilineText_Warning1")
local staticText_Warning2 = UI.getChildControl(staticText_WarningCH, "MultilineText_Warning2")
local staticText_Warning3 = UI.getChildControl(staticText_WarningCH, "MultilineText_Warning3")
local static_XboxScreen = UI.getChildControl(Panel_Logo, "Static_XboxScreen")
local txt_betaWarning = UI.getChildControl(Panel_Logo, "StaticText_BetaWarning")
txt_betaWarning:SetTextMode(__eTextMode_AutoWrap)
txt_betaWarning:SetText(txt_betaWarning:GetText())
txt_betaWarning:SetShow(isGameServiceTypeConsole() and _ContentsGroup_ForXBoxClosedBeta)
static_XboxScreen:SetShow(false)
local isConsoleRegionKorea = false
isConsoleRegionKorea = ToClient_isPS() and CppEnums.GameCountryRegionCodeType.KR == getGameCountryRegionCode()
if ToClient_isXBox() then
  isConsoleRegionKorea = ToClient_isKoreaXbox()
end
local static_Movie = UI.createControl(__ePAUIControl_WebControl, Panel_Logo, "WebControl_Movie")
local static_Quixel = UI.createControl(__ePAUIControl_Static, Panel_Logo, "Static_Quixel")
local setDivisionTime = 6
if isGameTypeTR() or isGameTypeTH() or isGameTypeID() or isGameTypeASIA() then
  setDivisionTime = 14.5
elseif isGameServiceTypeConsole() then
  setDivisionTime = 2.5
elseif isGameTypeKorea() then
  setDivisionTime = 10.5
elseif isGameTypeNA() then
  setDivisionTime = 10
elseif isGameTypeJapan() then
  setDivisionTime = 14
elseif isGameTypeCH() then
  setDivisionTime = 10.5
else
  setDivisionTime = 6
end
function Panel_Logo_Init()
  static_Daum:SetShow(true)
  static_Quixel:SetShow(true)
  local length = 98
  local height = 28
  static_Quixel:SetSize(length, height)
  if isGameServiceTypeConsole() == true then
    static_Quixel:SetHorizonLeft()
  else
    static_Quixel:SetHorizonRight()
  end
  static_Quixel:SetVerticalBottom()
  static_Quixel:SetSpanSize(30, 30)
  static_Quixel:ChangeTextureInfoNameAsync("quixel_logo_01.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(static_Quixel, 0, 0, length, height)
  static_Quixel:getBaseTexture():setUV(x1, y1, x2, y2)
  static_Quixel:setRenderTexture(static_Quixel:getBaseTexture())
  if isGameTypeKorea() or _ContentsGroup_RenewUI then
    static_Grade:SetSize(416, 121)
    static_Grade:ChangeTextureInfoNameAsync("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 416, 121)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
    static_Daum:SetShow(false)
  elseif isGameTypeNA() then
    static_Grade:SetSize(421, 122)
    static_Grade:ChangeTextureInfoNameAsync("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 421, 122)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
    static_Grade:SetShow(true)
    staticText_Warning:SetShow(false)
    static_Daum:SetShow(false)
  elseif isGameTypeTaiwan() or isGameTypeTR() or isGameTypeTH() or isGameTypeASIA() or isGameTypeID() or isGameTypeGT() or isGameServiceTypeConsole() or isGameTypeRussia() then
    static_Grade:SetSize(130, 129)
    static_Grade:ChangeTextureInfoNameAsync("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 130, 129)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
    static_Daum:SetShow(false)
  elseif isGameTypeSA() then
    static_Daum:SetSize(1024, 302)
    static_Daum:ChangeTextureInfoNameAsync("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 1024, 302)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
    staticText_Warning:SetShow(false)
    static_Grade:SetShow(false)
    static_Daum:SetShow(false)
  elseif isGameTypeCH() then
    static_Daum:SetSize(406, 248)
    static_Daum:ChangeTextureInfoNameAsync("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 406, 248)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
    static_Daum:SetShow(false)
    static_Grade:SetShow(false)
    staticText_Warning:SetShow(false)
    staticText_Warning1:SetShow(false)
    staticText_Warning2:SetShow(false)
    staticText_Warning3:SetShow(false)
  elseif isGameTypeJapan() then
    static_Daum:SetSize(688, 323)
    static_Daum:ChangeTextureInfoNameAsync("DAUM_CI.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Daum, 0, 0, 688, 323)
    static_Daum:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Daum:setRenderTexture(static_Daum:getBaseTexture())
    static_Daum:SetShow(false)
  else
    static_Grade:SetSize(311, 121)
    static_Grade:ChangeTextureInfoNameAsync("GameGradeIcon18.dds")
    local x1, y1, x2, y2 = setTextureUV_Func(static_Grade, 0, 0, 311, 121)
    static_Grade:getBaseTexture():setUV(x1, y1, x2, y2)
    static_Grade:setRenderTexture(static_Grade:getBaseTexture())
  end
  static_PearlAbyss:SetShow(false)
  ToClient_StartLedDeviceAnimation(6)
end
function setWarningText()
  if isGameTypeKorea() then
    local isAdult = ToClient_IsAdultLogin()
    if isAdult then
      staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE"))
    else
      staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE_15"))
    end
  elseif isConsoleRegionKorea then
    staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE"))
  elseif isGameTypeTaiwan() or isGameTypeGT() then
    staticText_Warning:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOGO_AGE_TW"))
  elseif isGameTypeCH() then
    if staticText_Warning1:GetShow() == false or staticText_Warning2:GetShow() == false or staticText_Warning3:GetShow() == false then
      staticText_Warning1:SetShow(true)
      staticText_Warning2:SetShow(true)
      staticText_Warning3:SetShow(true)
    end
    staticText_Warning1:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_1"))
    staticText_Warning2:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_2"))
    staticText_Warning3:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WARNING_3"))
    staticText_Warning1:SetHorizonCenter()
    staticText_Warning2:SetHorizonCenter()
    staticText_Warning3:SetHorizonCenter()
    staticText_Warning2:SetVerticalMiddle()
    local ratioX = getScreenSizeX() / 1920
    local ratioY = getScreenSizeY() / 1080
    if ratioX > 1 then
      ratioX = 1
    end
    if ratioY > 1 then
      ratioY = 1
    end
    staticText_Warning3:SetSpanSize(0, (staticText_Warning2:GetTextSizeY() / 2 + staticText_Warning3:GetTextSizeY()) * ratioX)
    staticText_Warning1:SetSpanSize(0, (-(staticText_Warning2:GetTextSizeY() / 2) - staticText_Warning1:GetTextSizeY()) * ratioY)
  else
    staticText_Warning:SetText("")
  end
  staticText_Warning:SetSize(getScreenSizeX(), staticText_Warning:GetTextSizeY())
  staticText_Warning:ComputePos()
end
Panel_Logo_Init()
Panel_Logo:ComputePos()
static_PearlAbyss:ComputePos()
static_Daum:ComputePos()
static_Grade:ComputePos()
staticText_Warning:ComputePos()
static_Quixel:ComputePos()
static_Daum:SetAlpha(0)
static_Grade:SetAlpha(0)
if isGameServiceTypeConsole() == false then
  static_Quixel:SetAlpha(0)
end
staticText_Warning:SetFontAlpha(0)
static_XboxScreen:ComputePos()
if _ContentsGroup_RenewUI then
  static_Grade:SetShow(isConsoleRegionKorea)
end
local startAniTime = 4.5
if isConsoleRegionKorea then
  startAniTime = setDivisionTime
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime, startAniTime + 1.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo4 = static_Grade:addColorAnimation(startAniTime + 3.5, startAniTime + 4.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime, startAniTime + 1.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 3.5, startAniTime + 4.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
elseif isGameTypeKorea() then
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 6, startAniTime + 7.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo4 = static_Grade:addColorAnimation(startAniTime + 9.5, startAniTime + 10.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 6, startAniTime + 7.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 9.5, startAniTime + 10.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static_Quixel:addColorAnimation(startAniTime + 6, startAniTime + 7.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo6:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo7 = static_Quixel:addColorAnimation(startAniTime + 9.5, startAniTime + 10.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo7:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo7:SetEndColor(Defines.Color.C_00FFFFFF)
elseif isGameTypeNA() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 6, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 6, startAniTime + 9, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = static_Quixel:addColorAnimation(startAniTime + 6, startAniTime + 9, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
elseif isGameTypeTaiwan() or isGameTypeGT() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo4 = static_Grade:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static_Quixel:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo6:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo7 = static_Quixel:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo7:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo7:SetEndColor(Defines.Color.C_00FFFFFF)
elseif isGameServiceTypeConsole() then
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Grade:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo4 = static_Grade:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_00FFFFFF)
  aniInfo5.IsChangeChild = true
elseif isGameTypeCH() then
  startAniTime = setDivisionTime
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = staticText_Warning:addColorAnimation(startAniTime + 2, startAniTime + 7.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo3.IsChangeChild = true
  local aniInfo4 = static_Quixel:addColorAnimation(startAniTime + 2, startAniTime + 7.5, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo4:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo4:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo5 = staticText_Warning:addColorAnimation(startAniTime + 9, startAniTime + 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo5:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo5:SetEndColor(Defines.Color.C_FFFFFFFF)
  aniInfo5.IsChangeChild = true
  local aniInfo6 = static_Quixel:addColorAnimation(startAniTime + 9, startAniTime + 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo6:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo6:SetEndColor(Defines.Color.C_FFFFFFFF)
elseif isGameTypeTR() or isGameTypeTH() or isGameTypeID() or isGameTypeASIA() then
  local aniInfo1 = static_Quixel:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo2 = static_Quixel:addColorAnimation(startAniTime + 7, startAniTime + 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_00FFFFFF)
elseif isGameTypeRussia() or isGameTypeSA() then
  local aniInfo1 = static_Quixel:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_FFFFFFFF)
else
  local aniInfo11 = static_Daum:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo11:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo11:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo1 = static_Daum:addColorAnimation(startAniTime + 3, startAniTime + 8, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo1:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo1:SetEndColor(Defines.Color.C_00FFFFFF)
  local aniInfo2 = static_Quixel:addColorAnimation(startAniTime + 0, startAniTime + 3, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo2:SetStartColor(Defines.Color.C_00FFFFFF)
  aniInfo2:SetEndColor(Defines.Color.C_FFFFFFFF)
  local aniInfo3 = static_Quixel:addColorAnimation(startAniTime + 7, startAniTime + 10, CppEnums.PAUI_ANIM_ADVANCE_TYPE.PAUI_ANIM_ADVANCE_COS_HALF_PI)
  aniInfo3:SetStartColor(Defines.Color.C_FFFFFFFF)
  aniInfo3:SetEndColor(Defines.Color.C_00FFFFFF)
end
local updateTime = 0
function Panel_Logo_Update()
  if isGameTypeCH() == true then
    local ratioX = getScreenSizeX() / 1920
    local ratioY = getScreenSizeY() / 1080
    if ratioX > 1 then
      ratioX = 1
    end
    if ratioY > 1 then
      ratioY = 1
    end
    staticText_WarningCH:SetSize(getScreenSizeX(), getScreenSizeY())
    staticText_WarningCH:SetScaleChild(ratioX, ratioY)
    staticText_WarningCH:ComputePosAllChild()
    staticText_WarningCH:SetPosXY((getScreenSizeX() - staticText_WarningCH:GetSizeX()) / 2, (getScreenSizeY() - staticText_WarningCH:GetSizeY()) / 2)
  end
  local uiScale = getGlobalScale()
  local sizeX = getResolutionSizeX()
  local sizeY = getResolutionSizeY()
  sizeX = sizeX / uiScale
  sizeY = sizeY / uiScale
  local movieSizeX = sizeX
  local movieSizeY = sizeX * 9 / 16
  local posX = 0
  local posY = 0
  if sizeY >= movieSizeY then
    posY = (sizeY - movieSizeY) / 2
  else
    movieSizeX = sizeY * 16 / 9
    movieSizeY = sizeY
    posX = (sizeX - movieSizeX) / 2
  end
  Panel_Logo:SetPosX(0)
  Panel_Logo:SetPosY(0)
  Panel_Logo:SetSize(sizeX, sizeY)
  static_Movie:SetIgnore(true)
  static_Movie:SetPosX(posX)
  static_Movie:SetPosY(posY)
  static_Movie:SetSize(movieSizeX, movieSizeY)
  if true == isGameServiceTypeConsole() then
    static_XboxScreen:SetPosX(-8)
    static_XboxScreen:SetPosY(-8)
    static_XboxScreen:SetSize(sizeX + 34, sizeY + 19)
    txt_betaWarning:ComputePos()
    static_Quixel:SetHorizonLeft()
  end
  if isGameTypeCH() == true then
    static_Movie:SetUrl(1920, 1080, "coui://UI_Movie/CI_Play.html", false, true)
  else
    static_Movie:SetUrl(1920, 1080, "coui://UI_Movie/CI_Play_NoSound.html", false, true)
  end
end
function Panel_Logo_Pause(deltaTime)
  updateTime = updateTime + deltaTime
  if setDivisionTime < updateTime then
    if nil ~= static_Movie then
      static_Movie:ResetUrl()
      static_Movie:SetShow(false)
    end
    setWarningText()
    if true == isGameServiceTypeConsole() then
      static_XboxScreen:SetShow(true)
      if isConsoleRegionKorea and startAniTime + 4.5 > updateTime then
        static_XboxScreen:SetShow(false)
      end
      update_XboxLoadingCircle(deltaTime)
    end
  end
end
Panel_Logo_Update()
Panel_Logo:RegisterUpdateFunc("Panel_Logo_Pause")
