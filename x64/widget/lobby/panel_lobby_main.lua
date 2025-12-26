local UI_color = Defines.Color
local ePcWorkingType = CppEnums.PcWorkType
local const_64 = Defines.s64_const
if nil ~= Panel_CharacterSelect then
  Panel_CharacterSelect:SetShow(false, false)
end
local CCSC_Frame = UI.getChildControl(Panel_CharacterCreateSelectClass, "Frame_CharacterSelect")
local _frameContents = UI.getChildControl(CCSC_Frame, "Frame_1_Content")
local _frameScroll = UI.getChildControl(CCSC_Frame, "Frame_1_VerticalScroll")
local bottomFrame = UI.getChildControl(Panel_CharacterCreateSelectClass, "Frame_BottomDesc")
local _frameBottomDesc = UI.getChildControl(bottomFrame, "Frame_1_Content")
local tooltipDescSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONDESC")
local tooltipNameSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONTITLE")
local Panel_Lobby_ClassUI = {
  ClassButtons = {},
  ClassNames = {},
  ClassStatus = {}
}
local txt_BottomDesc = UI.getChildControl(_frameBottomDesc, "StaticText_Desc")
local classCountTemplate = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_ClassCount")
local classCountControl = {}
local recommandIconTemplate = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Icon")
local recommandClassIcon = {}
local recommandTooltip = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_IconTooltip")
local classCount = {}
local Panel_Lobby_UI = {
  CC_CharacterCreateText = UI.getChildControl(Panel_CharacterCreate, "StaticText_CharacterCreate"),
  CC_CharacterNameEdit = UI.getChildControl(Panel_CharacterCreate, "Edit_CharacterName"),
  CC_CreateButton = UI.getChildControl(Panel_CharacterCreate, "Button_CharacterCreateStart"),
  CC_BackButton = UI.getChildControl(Panel_CharacterCreate, "Button_Back"),
  CC_DumiText1 = UI.getChildControl(Panel_CharacterCreate, "StaticText_1"),
  CC_characterCreateBG = UI.getChildControl(Panel_CharacterCreate, "Static_BG"),
  CC_DumiText3 = UI.getChildControl(Panel_CharacterCreate, "StaticText_3"),
  CC_DumiText4 = UI.getChildControl(Panel_CharacterCreate, "StaticText_4"),
  CC_FrameHead = UI.getChildControl(Panel_CharacterCreate, "Frame_Head"),
  CC_FrameHead_Content = nil,
  CC_FrameHead_Content_Image = nil,
  CC_FrameHead_Scroll = nil,
  CC_FrameHair = UI.getChildControl(Panel_CharacterCreate, "Frame_Hair"),
  CC_FrameHair_Content = nil,
  CC_FrameHair_Content_Image = nil,
  CC_FrameHair_Scroll = nil,
  CC_SelectClassButton = UI.getChildControl(Panel_CharacterCreate, "Button_SelectClass"),
  CC_CBTText = UI.getChildControl(Panel_CharacterCreate, "StaticText_CBT"),
  CCSC_CreateTitle = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Title"),
  CCSC_ClassName = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_ClassName"),
  CCSC_PartLine = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_PartLine"),
  CCSC_ClassDescBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Desc_BG"),
  CCSC_ClassDesc = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Description"),
  CCSC_CreateButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_CharacterCreateStart"),
  CCSC_CreateBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_BG"),
  CCSC_AnimationSkipWhenClickBG = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_BG_AnimationSkipWhenClick"),
  CCSC_RadioNormalMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "RadioButton_Normal"),
  CCSC_RadioAwakenMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "RadioButton_Awaken"),
  CCSC_ClassMovie = UI.createControl(__ePAUIControl_WebControl, Panel_CharacterCreateSelectClass, "Static_ClassMovie"),
  CCSC_BackButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_Back"),
  CCSC_SelectClassButton = UI.getChildControl(Panel_CharacterCreateSelectClass, "Button_SelectClass"),
  CCSC_NoMovie = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_NoMovie"),
  CCSC_LeaveConsole = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Leave_ConsoleUI"),
  CCSC_SelectConsole = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Select"),
  CM_Edit_CharacterName
}
if false == _ContentsGroup_RenewUI_Customization then
  Panel_Lobby_UI.CM_Edit_CharacterName = UI.getChildControl(Panel_CustomizationMain, "Edit_CharacterName")
end
local Character_Status = {
  _stat_Ctrl = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Ctrl"),
  _stat_Att = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Att"),
  _stat_Def = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Def"),
  _stat_Evd = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Evd"),
  _stat_Cmb = UI.getChildControl(Panel_CharacterCreateSelectClass, "StaticText_Stat_Cmb")
}
local Panel_Lobby_Global_Variable = {
  currentSelectedIdx = -1,
  UIList = {},
  UiMaker = nil,
  characterSelect = -1,
  notClearValueCharacterSelect = -1,
  characterSelectType = -1,
  selectRegionInfo = nil,
  isWaitLine = false,
  selectCharacterLevel = -1
}
local Panel_Lobby_Enum = {
  eRotate_Left = 0,
  eRotate_Right = 1,
  eDistance_Far = 2,
  eDistance_Near = 3,
  eArrow_Up = 4,
  eArrow_Down = 5,
  eArrow_Left = 6,
  eArrow_Right = 7,
  eCharacterCustomization_HeadMesh = 0,
  eCharacterCustomization_HairMesh = 1
}
local sortCharacterCount = 1
local columnCountByRaw = 4
local columnCount = 0
local rowCount = 0
local classNameStartX = 18
local classNameStartY = 120
local classNameGapX = 17
local classNameGapY = 130
local classButtonStartX = 15
local classButtonGapX = 10
local classButtonGapY = 5
local baseNormalButtonSize = 210
local _CharInfo_BG = UI.getChildControl(Panel_CharacterSelect, "Static_CharInfo_BG")
_CharInfo_BG:setGlassBackground(false)
local Panel_CharacterDoing = {
  _CharInfo_Name = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Name"),
  _CharInfo_GaugeBG = UI.getChildControl(Panel_CharacterSelect, "Static_CharInfo_GaugeBG"),
  _CharInfo_Gauge = UI.getChildControl(Panel_CharacterSelect, "Progress2_CharInfo_Gauge"),
  _CharInfo_DoText = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Do"),
  _CharInfo_NowPos = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_NowPos"),
  _CharInfo_WhereText = UI.getChildControl(Panel_CharacterSelect, "StaticText_CharInfo_Where"),
  _ticketNoByRegion = UI.getChildControl(Panel_CharacterSelect, "StaticText_TicketNoByRegion")
}
local characterSelect_DoWork = {
  _doWork_BG = UI.getChildControl(Panel_CharacterSelect, "Static_Work_BG"),
  _doWork_GaugeBG = UI.getChildControl(Panel_CharacterSelect, "Static_Work_GaugeBG"),
  _doWork_Gauge = UI.getChildControl(Panel_CharacterSelect, "Static_Work_Gauge"),
  _doWork_Icon = UI.getChildControl(Panel_CharacterSelect, "Static_Work_Icon")
}
local Panel_Customization = {
  group = {}
}
local Panel_Lobby_LDownCheck_ViewControl = {}
local _headContentImage = {}
local _hairContentImage = {}
local characterTicketAbleUI = {}
local TAB_TYPE = {
  NORMAL = 1,
  PREMIUM = 2,
  HARDCORE = 3
}
local ClassUI_Pos = {
  posX = {},
  posY = {},
  nameX = {},
  nameY = {}
}
local _playerCreateType = __ePlayerCreateNormal
function FGlobal_SetPlayerCreateType(playerCreateType)
  _playerCreateType = playerCreateType
end
function FGlobal_GetPlayerCreateType()
  return _playerCreateType
end
local newCharacterList = {}
local lastCharacter_PosX = 0
local lastCharacter_PosY = 0
local newCharacterInfo = NewClassData.NewCharacterInfo
local function newCharacter()
  local saveCharType = -1
  if 0 == #newCharacterInfo then
    return
  end
  for idx = 1, #newCharacterInfo do
    if newCharacterInfo[idx][2] < ToClient_GetThisYear() then
    elseif newCharacterInfo[idx][2] == ToClient_GetThisYear() and newCharacterInfo[idx][3] < ToClient_GetThisMonth() then
    elseif newCharacterInfo[idx][2] == ToClient_GetThisYear() and newCharacterInfo[idx][3] == ToClient_GetThisMonth() and newCharacterInfo[idx][4] < ToClient_GetToday() then
    else
      local count = getPossibleClassCount()
      for ii = 0, count - 1 do
        local classType = getPossibleClassTypeFromIndex(ii)
        if nil ~= classType and classType == newCharacterInfo[idx][1] then
          saveCharType = ii
          break
        end
      end
      table.insert(newCharacterList, saveCharType)
    end
  end
end
local function Panel_Lobby_Function_Initialize()
  newCharacter()
  UI.ASSERT(nil ~= Panel_CharacterCreateSelectClass, "createCharacter_SelectClass\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassName, "CCSC_ClassName\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_PartLine, "CCSC_PartLine\t\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassDescBG, "CCSC_ClassDescBG\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassDesc, "CCSC_ClassDesc\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_CreateButton, "CCSC_CreateButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_ClassMovie, "CCSC_ClassMovie\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_BackButton, "CCSC_BackButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CCSC_SelectClassButton, "CCSC_SelectClassButton\t\tnil")
  UI.ASSERT(nil ~= Panel_CharacterCreate, "createCharacter\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CharacterCreateText, "CC_CharacterCreateText\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CharacterNameEdit, "CC_CharacterNameEdit\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_CreateButton, "CC_CreateButton\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_BackButton, "CC_BackButton\t\t\t\tnil")
  UI.ASSERT(nil ~= Panel_Lobby_UI.CC_SelectClassButton, "CC_SelectClassButton\t\tnil")
  if isGameServiceTypeKor() then
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(15)
  elseif isGameServiceTypeDev() then
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(15)
  else
    Panel_Lobby_UI.CC_CharacterNameEdit:SetMaxInput(30)
  end
  local RadioButton_Template = UI.getChildControl(_frameContents, "RadioButton_Select_Template")
  local StaticText_Template = UI.getChildControl(_frameContents, "StaticText_Name_Template")
  local StaticStat_Template = UI.getChildControl(Panel_CharacterCreateSelectClass, "Static_Stat_Template")
  Panel_Lobby_ClassCountCheck()
  local count = getPossibleClassCount()
  for index = 0, count do
    local classType = getPossibleClassTypeFromIndex(index)
    if classType ~= __eClassType_Count and NewClassData.newClass_CharacterCreate_Slot_Data[classType] ~= nil then
      local tempRadioButton = UI.createControl(__ePAUIControl_RadioButton, _frameContents, "RadioButton_Select_" .. classType)
      local tempStaticText = UI.createControl(__ePAUIControl_MultiLineText, _frameContents, "StaticText_Name_" .. classType)
      local tempStaticStat = UI.createControl(__ePAUIControl_Static, Panel_CharacterCreateSelectClass, "StaticStat_" .. classType)
      CopyBaseProperty(RadioButton_Template, tempRadioButton)
      CopyBaseProperty(StaticText_Template, tempStaticText)
      CopyBaseProperty(StaticStat_Template, tempStaticStat)
      tempStaticStat:ChangeTextureInfoNameAsync(NewClassData.newClass_CharacterCreate_Slot_Data[classType]._classStatTexture)
      Panel_Lobby_ClassUI.ClassButtons[classType] = tempRadioButton
      Panel_Lobby_ClassUI.ClassNames[classType] = tempStaticText
      Panel_Lobby_ClassUI.ClassStatus[classType] = tempStaticStat
    end
  end
  RadioButton_Template:SetShow(false)
  StaticText_Template:SetShow(false)
  StaticStat_Template:SetShow(false)
  Panel_Lobby_UI.CC_FrameHead_Content = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead, "Frame_Head_Content")
  Panel_Lobby_UI.CC_FrameHead_Content_Image = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead_Content, "Frame_Head_Content_Image")
  Panel_Lobby_UI.CC_FrameHead_Scroll = UI.getChildControl(Panel_Lobby_UI.CC_FrameHead, "Frame_Head_Scroll")
  Panel_Lobby_UI.CC_FrameHair_Content = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair, "Frame_Hair_Content")
  Panel_Lobby_UI.CC_FrameHair_Content_Image = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair_Content, "Frame_Hair_Content_Image")
  Panel_Lobby_UI.CC_FrameHair_Scroll = UI.getChildControl(Panel_Lobby_UI.CC_FrameHair, "Frame_Hair_Scroll")
  Panel_CharacterCreate:SetShow(false, false)
  Panel_CharacterCreateSelectClass:SetShow(false, false)
  Panel_Lobby_UI.CCSC_CreateBG:SetSize(450, getScreenSizeY())
  Panel_Lobby_UI.CCSC_AnimationSkipWhenClickBG:SetSize(getScreenSizeX() - 450, getScreenSizeY())
  Panel_Lobby_UI.CC_characterCreateBG:setGlassBackground(true)
  Panel_Lobby_UI.CCSC_CreateBG:setGlassBackground(true)
  Panel_Lobby_UI.CCSC_ClassName:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_PartLine:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_ClassDescBG:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_ClassDesc:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_CreateButton:addInputEvent("Mouse_LUp", "changeCreateCharacterMode()")
  Panel_Lobby_UI.CCSC_BackButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateCancel()")
  Panel_Lobby_UI.CCSC_SelectClassButton:addInputEvent("Mouse_LUp", "")
  Panel_Lobby_UI.CCSC_AnimationSkipWhenClickBG:addInputEvent("Mouse_LUp", "characterCreateCancelIntroAction()")
  for index = 0, __eClassType_Count - 1 do
    if Panel_Lobby_ClassUI.ClassNames[index] ~= nil then
      Panel_Lobby_ClassUI.ClassNames[index]:SetTextMode(__eTextMode_AutoWrap)
      local className = NewClassData.newClass_String[index]._classType2String
      if className == nil then
        className = ""
      end
      Panel_Lobby_ClassUI.ClassNames[index]:SetText(className)
    end
    if Panel_Lobby_ClassUI.ClassButtons[index] ~= nil then
      PaGlobalFunc_Util_SetCharacterCreateClassIcon(Panel_Lobby_ClassUI.ClassButtons[index], index)
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_LUp", "Panel_Lobby_function_SelectClassType(" .. index .. ", true)")
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_On", "Panel_Lobby_SelectClass_MouseEvent(" .. index .. ", true)")
      Panel_Lobby_ClassUI.ClassButtons[index]:addInputEvent("Mouse_Out", "Panel_Lobby_SelectClass_MouseEvent(" .. index .. ", false)")
    end
  end
  local createCount = 0
  for index = 0, count do
    local classType = getPossibleClassTypeFromIndex(index)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
    local className = Panel_Lobby_ClassUI.ClassNames[classType]
    if classButton ~= nil and classButton:GetShow() then
      classButton:SetPosX(classButtonStartX + classButton:GetPosX() + (classButton:GetSizeX() + classButtonGapX) * columnCount)
      classButton:SetPosY(classButton:GetPosY() + (classButton:GetSizeY() + classButtonGapY) * rowCount)
      local nameGapSize = (classButton:GetSizeX() - className:GetSizeX()) / 2
      className:SetPosX(classButton:GetPosX() + nameGapSize)
      className:SetPosY(classButton:GetPosY() + classButton:GetSizeY() - className:GetTextSizeY() - 10)
      if 0 == sortCharacterCount % columnCountByRaw then
        columnCount = 0
        rowCount = rowCount + 1
      else
        columnCount = columnCount + 1
      end
      sortCharacterCount = sortCharacterCount + 1
      className:SetSize(88, Panel_Lobby_ClassUI.ClassNames[classType]:GetTextSizeY() + 5)
      ClassUI_Pos.posX[createCount] = classButton:GetPosX()
      ClassUI_Pos.posY[createCount] = classButton:GetPosY()
      ClassUI_Pos.nameX[createCount] = className:GetPosX()
      if className:GetTextSizeY() > 20 then
        ClassUI_Pos.nameY[createCount] = className:GetPosY() + (className:GetTextSizeY() - 20)
      else
        ClassUI_Pos.nameY[createCount] = className:GetPosY()
      end
      if nil == classCountControl[classType] then
        classCountControl[classType] = UI.createControl(__ePAUIControl_StaticText, classButton, "StaticText_ClassCount_" .. classType)
        CopyBaseProperty(classCountTemplate, classCountControl[classType])
        classCountControl[classType]:SetTextMode(__eTextMode_AutoWrap)
        classCountControl[classType]:SetText(classCountControl[classType]:GetText())
        classCountControl[classType]:SetShow(false)
      end
      if nil ~= classCount[classType] then
        className:SetFontColor(Defines.Color.C_FFFFEEA0)
      else
        className:SetFontColor(Defines.Color.C_FFEFEFEF)
      end
      if NewClassData.newClass_CharacterCreate_Slot_Data[classType] ~= nil and NewClassData.newClass_CharacterCreate_Slot_Data[classType]._isRecommand ~= nil then
        local contryType = getContryTypeLua()
        if NewClassData.newClass_CharacterCreate_Slot_Data[classType]._isRecommand[contryType] ~= nil then
          recommandClassIcon[classType] = UI.createControl(__ePAUIControl_StaticText, _frameContents, "CreateStatic_RecommandIcon_" .. classType)
          CopyBaseProperty(recommandIconTemplate, recommandClassIcon[classType])
          recommandClassIcon[classType]:SetShow(true)
          recommandClassIcon[classType]:SetSpanSize(5, 5)
          recommandClassIcon[classType]:SetPosX(classButton:GetPosX())
          recommandClassIcon[classType]:SetPosY(classButton:GetPosY() + 1)
          recommandClassIcon[classType]:addInputEvent("Mouse_On", "Panel_Lobby_SelectClass_Recommand_MouseEvent(" .. classType .. ", true)")
          recommandClassIcon[classType]:addInputEvent("Mouse_Out", "Panel_Lobby_SelectClass_Recommand_MouseEvent(" .. classType .. ", false)")
        end
      end
      createCount = createCount + 1
    end
  end
  Panel_Lobby_UI.CC_SelectClassButton:addInputEvent("Mouse_LUp", "changeCreateCharacterMode_SelectClass()")
  Panel_Lobby_UI.CC_CreateButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateOk()")
  Panel_Lobby_UI.CC_BackButton:addInputEvent("Mouse_LUp", "Panel_CharacterCreateCancel()")
  if true == _ContentsGroup_UsePadSnapping then
    Panel_Lobby_UI.CCSC_ClassMovie:SetShow(false)
    Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(false)
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(false)
    Panel_Lobby_UI.CCSC_ClassDesc:SetShow(false)
    txt_BottomDesc:SetShow(false)
    bottomFrame:SetShow(false)
    _frameBottomDesc:SetShow(false)
    Panel_Lobby_UI.CCSC_ClassDescBG:SetShow(false)
  else
    local scrX = getScreenSizeX()
    local scrY = getScreenSizeY()
    Panel_Lobby_UI.CCSC_ClassMovie:SetPosX(scrX - 441)
    Panel_Lobby_UI.CCSC_ClassMovie:SetPosY(scrY - 372)
    Panel_Lobby_UI.CCSC_ClassMovie:SetUrl(422, 237, "coui://UI_Data/UI_Html/Class_Movie.html")
    Panel_Lobby_UI.CCSC_ClassMovie:SetSize(422, 237)
    Panel_Lobby_UI.CCSC_ClassMovie:SetSpanSize(-1, 0)
    Panel_Lobby_UI.CCSC_ClassMovie:SetShow(true)
    local checkAgeType = ToClient_isAdultUser()
    if checkAgeType then
      Panel_Lobby_UI.CCSC_ClassMovie:SetMonoTone(false)
    else
      Panel_Lobby_UI.CCSC_ClassMovie:SetMonoTone(true)
    end
    local isChina = isGameTypeCH()
    Panel_Lobby_UI.CCSC_ClassMovie:SetIgnore(isChina == true)
    Panel_Lobby_UI.CCSC_ClassMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SelectClass_OpenClassHompage()")
    Panel_Lobby_UI.CCSC_NoMovie:SetPosX(scrX - 441)
    Panel_Lobby_UI.CCSC_NoMovie:SetPosY(scrY - 372)
    Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SetMovie()")
    Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_On", "Panel_Lobby_TooltipShow(" .. 0 .. ")")
    Panel_Lobby_UI.CCSC_RadioNormalMovie:addInputEvent("Mouse_Out", "Panel_Lobby_TooltipHide()")
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_LUp", "Panel_Lobby_SetMovie()")
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_On", "Panel_Lobby_TooltipShow(" .. 1 .. ")")
    Panel_Lobby_UI.CCSC_RadioAwakenMovie:addInputEvent("Mouse_Out", "Panel_Lobby_TooltipHide()")
  end
end
function Panel_Lobby_ClassCountCheck()
  local characterCount = getCharacterDataCount(__ePlayerCreateNormal)
  classCount = {}
  for index = 0, characterCount - 1 do
    local charData = getCharacterDataByIndex(index, __ePlayerCreateNormal)
    if nil ~= charData then
      local classType = getCharacterClassType(charData)
      if nil == classCount[classType] then
        classCount[classType] = 1
      else
        classCount[classType] = classCount[classType] + 1
      end
    end
  end
end
local function Panel_Lobby_function_StartUp_CreateCharacter_SelectClass()
  Panel_Lobby_Global_Variable.UiMaker = Panel_CharacterCreateSelectClass
  Panel_Lobby_Global_Variable.UiMaker:SetSize(getScreenSizeX(), getScreenSizeY())
  Panel_CharacterCreateSelectClass:SetShow(true, false)
  Panel_CharacterCreateSelectClass:SetSize(getScreenSizeX(), getScreenSizeY())
  _frameContents:ComputePos()
  for _, value in pairs(Character_Status) do
    value:ComputePos()
  end
  for _, value in pairs(Panel_Lobby_UI) do
    value:ComputePos()
  end
  bottomFrame:ComputePos()
  bottomFrame:GetVScroll():SetControlTop()
  bottomFrame:UpdateContentPos()
  bottomFrame:UpdateContentScroll()
  CCSC_Frame:ComputePos()
  CCSC_Frame:GetVScroll():SetControlTop()
  CCSC_Frame:UpdateContentPos()
  CCSC_Frame:UpdateContentScroll()
  local scrSizeY = getScreenSizeY()
  local sumSizeY
  sumSizeY = scrSizeY - (Panel_Lobby_UI.CCSC_ClassName:GetSizeY() + Panel_Lobby_UI.CCSC_ClassMovie:GetSizeY() + Panel_Lobby_UI.CCSC_ClassDescBG:GetSizeY() + 112)
  CCSC_Frame:SetSize(_frameContents:GetSizeX(), sumSizeY)
  Panel_Lobby_UI.CCSC_RadioNormalMovie:SetPosX(CCSC_Frame:GetPosX() + 17)
  Panel_Lobby_UI.CCSC_RadioNormalMovie:SetPosY(CCSC_Frame:GetPosY() + CCSC_Frame:GetSizeY() + 10)
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetPosX(Panel_Lobby_UI.CCSC_RadioNormalMovie:GetPosX() + baseNormalButtonSize + 5)
  Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetPosY(CCSC_Frame:GetPosY() + CCSC_Frame:GetSizeY() + 10)
  if sumSizeY < _frameContents:GetSizeY() then
    _frameScroll:SetShow(true)
    _frameScroll:SetInterval(sumSizeY / 100 * 1.1)
  else
    _frameScroll:SetShow(false)
  end
  for classIndex = 0, __eClassType_Count - 1 do
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classIndex]
    local className = Panel_Lobby_ClassUI.ClassNames[classIndex]
    local classStatus = Panel_Lobby_ClassUI.ClassStatus[classIndex]
    if classButton ~= nil then
      classButton:SetShow(false)
      classButton:ComputePos()
    end
    if className ~= nil then
      className:SetShow(false)
      className:ComputePos()
    end
    if classStatus ~= nil then
      classStatus:ComputePos()
    end
  end
  local function ClassBtn_Show(classIndex)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classIndex]
    local className = Panel_Lobby_ClassUI.ClassNames[classIndex]
    if classButton ~= nil then
      classButton:SetShow(true)
    end
    if className ~= nil then
      className:SetShow(true)
    end
  end
  local count = getPossibleClassCount()
  for index = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(index)
    ClassBtn_Show(classType)
  end
  local classType = PaGlobalFunc_CharacterSelect_FirstClass()
  local isPrimiumTab = 1
  local isHardCoreTab = 0
  isPrimiumTab = TAB_TYPE.PREMIUM == PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  isHardCoreTab = TAB_TYPE.HARDCORE == PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  if isPrimiumTab and false == PaGlobalFunc_CharacterSelect_IsCheckPremiumCharacter(classType) then
    classType = __eClassType_Warrior
  end
  if isHardCoreTab == true then
    classType = PaGlobalFunc_CharacterSelect_GetFristHardCoreClass()
  end
  if nil == classType then
    Panel_Lobby_function_SelectClassType(__eClassType_Warrior)
  else
    Panel_Lobby_function_SelectClassType(classType)
  end
end
function Panel_Lobby_Function_showCharacterCreate_SelectClass()
  PaGlobalFunc_CharacterSelect_All_Close()
  Panel_Lobby_Global_Variable.currentSelectedIdx = -1
  local isXbox = _ContentsGroup_UsePadSnapping
  Panel_Lobby_UI.CCSC_LeaveConsole:SetShow(isXbox)
  Panel_Lobby_UI.CCSC_SelectConsole:SetShow(isXbox)
  Panel_Lobby_UI.CCSC_BackButton:SetShow(not isXbox)
  Panel_Lobby_UI.CCSC_CreateButton:SetShow(not isXbox)
  Panel_Lobby_function_DeleteButton()
  Panel_Lobby_function_ClearData()
  Panel_Lobby_function_StartUp_CreateCharacter_SelectClass()
  Panel_CharacterCreateSelectClass:SetShow(true, false)
  if false == _ContentsGroup_RenewUI_Customization then
    Panel_CharacterCreate:SetShow(false, false)
    Panel_Customization_Control:SetShow(false, false)
    Panel_CustomizationMotion:SetShow(false, false)
    Panel_CustomizationExpression:SetShow(false, false)
    Panel_CustomizationCloth:SetShow(false, false)
    Panel_CustomizationTest:SetShow(false, false)
    Panel_CustomizationMesh:SetShow(false, false)
    Panel_CustomizationMain:SetShow(false, false)
    Panel_CustomizationStatic:SetShow(false, false)
    Panel_CustomizationMessage:SetShow(false, false)
    Panel_CustomizationFrame:SetShow(false, false)
  end
  Panel_CharacterCreateSelectClass:SetSize(getScreenSizeY(), getScreenSizeX())
  PaGlobalFunc_CharacterSelect_TabState()
end
function Panel_Lobby_Function_showCharacterCustomization(customizationData)
  Panel_Lobby_function_DeleteButton()
  Panel_CharacterCreateSelectClass:SetShow(false, false)
  if true == _ContentsGroup_RenewUI_Customization then
    PaGlobalFunc_Customization_SetClassType(index)
  else
    Panel_Lobby_UI.CM_Edit_CharacterName:SetEditText("")
    ShowCharacterCustomization(customizationData, Panel_Lobby_Global_Variable.characterSelectType, false)
  end
  viewCharacterCreateMode(Panel_Lobby_Global_Variable.characterSelectType)
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportSceneEnterCustomizeCharacter, true)
  end
end
function Panel_Lobby_function_ClearData()
  Panel_Lobby_Global_Variable.characterSelect = -1
  Panel_Lobby_Global_Variable.characterSelectType = -1
  Panel_Lobby_Global_Variable.selectRegionInfo = nil
end
local _index
function Panel_Lobby_function_SelectClassType(index, isOn)
  if index < __eClassType_Count then
    if false == ToClient_checkCreatePossibleClass(index, FGlobal_GetPlayerCreateType()) then
      return
    end
    if index == Panel_Lobby_Global_Variable.currentSelectedIdx then
      changeCreateCharacterMode()
      return
    else
      Panel_Lobby_Global_Variable.currentSelectedIdx = index
    end
    for key, value in pairs(Panel_Lobby_ClassUI.ClassButtons) do
      value:SetMonoTone(true)
      value:SetVertexAniRun("Ani_Color_Reset", true)
      value:EraseAllEffect()
    end
    Panel_Lobby_ClassUI.ClassButtons[index]:SetMonoTone(false)
    local effectName = "UI_CharactorSelcect_Line"
    local isPrimiumTab = 1
    isPrimiumTab = TAB_TYPE.NORMAL == PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
    if isPrimiumTab and #newCharacterInfo > 0 then
      for idx = 1, #newCharacterInfo do
        if index == newCharacterInfo[idx][1] then
          effectName = "fUI_Lobby_SelectCharacter_01A"
          break
        end
      end
    end
    Panel_Lobby_ClassUI.ClassButtons[index]:AddEffect(effectName, true, 10, 4)
    if true == _ContentsGroup_UsePadSnapping then
      _index = index
      viewCharacterCreateSelectClassMode(index)
      Panel_Lobby_Global_Variable.characterSelectType = index
      Panel_Lobby_UI.CCSC_ClassName:SetText(getClassName(index, FGlobal_GetPlayerCreateType()))
    else
      local movieName = getClassMovie(index, FGlobal_GetPlayerCreateType())
      Panel_Lobby_UI.CCSC_RadioNormalMovie:SetCheck(false)
      Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetCheck(true)
      local isAwakenOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(index)
      if nil == isAwakenOpen then
        isAwakenOpen = false
      end
      if nil ~= movieName and "" ~= movieName then
        Panel_Lobby_UI.CCSC_ClassMovie:SetShow(true)
        Panel_Lobby_UI.CCSC_NoMovie:SetShow(false)
        if true == isAwakenOpen then
          movieName = string.gsub(movieName, ".webm", "_A.webm")
          Panel_Lobby_UI.CCSC_RadioNormalMovie:SetSize(baseNormalButtonSize, Panel_Lobby_UI.CCSC_RadioNormalMovie:GetSizeY())
        else
          Panel_Lobby_UI.CCSC_RadioNormalMovie:SetCheck(true)
          Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetCheck(false)
          Panel_Lobby_UI.CCSC_RadioNormalMovie:SetSize(baseNormalButtonSize * 2 + 5, Panel_Lobby_UI.CCSC_RadioNormalMovie:GetSizeY())
        end
        Panel_Lobby_UI.CCSC_ClassMovie:TriggerEvent("PlayMovie", "coui://" .. movieName)
      else
        Panel_Lobby_UI.CCSC_ClassMovie:SetShow(false)
        Panel_Lobby_UI.CCSC_NoMovie:SetShow(true)
      end
      Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(true)
      Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(isAwakenOpen)
      if index == __eClassType_RangerMan or index == __eClassType_Scholar or index == __eClassType_PWGE or index == __eClassType_PJKD or index == __eClassType_PDKL then
        Panel_Lobby_UI.CCSC_RadioNormalMovie:SetShow(false)
        Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetShow(false)
      end
      _PA_ASSERT_NAME(NewClassData.NewClassType == __eClassType_PDKL, "\236\131\136\235\161\156\236\154\180 ClassType \235\163\168\236\149\132 \236\158\145\236\151\133 \236\139\156 \237\153\149\236\157\184\237\149\180\236\163\188\236\132\184\236\154\148. ", "\236\161\176\236\139\156\236\153\132")
      _index = index
      viewCharacterCreateSelectClassMode(index)
      Panel_Lobby_Global_Variable.characterSelectType = index
      Panel_Lobby_UI.CCSC_ClassName:SetText(getClassName(index, FGlobal_GetPlayerCreateType()))
      Panel_Lobby_UI.CCSC_ClassDesc:SetTextMode(__eTextMode_AutoWrap)
      Panel_Lobby_UI.CCSC_ClassDesc:SetText(getClassDescription(index, FGlobal_GetPlayerCreateType()))
      Panel_Lobby_UI.CCSC_ClassDesc:SetShow(false)
      txt_BottomDesc:SetTextMode(__eTextMode_AutoWrap)
      txt_BottomDesc:SetText(getClassDescription(index, FGlobal_GetPlayerCreateType()))
    end
    _frameBottomDesc:SetSize(_frameBottomDesc:GetSizeX(), txt_BottomDesc:GetTextSizeY() + 10)
    if index == __eClassType_ShyWaman then
      tooltipDescSaved = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_CHARACTERSELECT_CREATE_SHY_AWAKENWEAPON_TOOLTIP")
      tooltipNameSaved = PAGetString(Defines.StringSheet_GAME, "LUA_LOBBY_CHARACTERSELECT_CREATE_SHY_AWAKENWEAPON_TOOLTIP_NAME")
      Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_EQUIPMENT_SHY_AWAKENWEAPON"))
    else
      tooltipNameSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONTITLE")
      tooltipDescSaved = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_AWAKENWEAPONDESC")
      Panel_Lobby_UI.CCSC_RadioAwakenMovie:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_SKILL_RELEASEWEAPONE"))
    end
    for _, value in pairs(Panel_Lobby_ClassUI.ClassStatus) do
      value:SetShow(false)
    end
    Panel_Lobby_ClassUI.ClassStatus[index]:SetShow(true)
  end
  bottomFrame:UpdateContentPos()
  bottomFrame:UpdateContentScroll()
end
function Panel_Lobby_SelectClass_OpenClassHompage()
  local isAwakenOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(_index)
  if nil == isAwakenOpen then
    return
  end
  local url = ""
  if true == isGameTypeKorea() then
    url = "https://www.kr.playblackdesert.com"
  elseif true == isGameTypeJapan() then
    url = "https://www.jp.playblackdesert.com"
  elseif true == isGameTypeRussia() then
    url = "https://www.ru.playblackdesert.com"
  else
    if true == isGameTypeNA() then
      url = "https://www.naeu.playblackdesert.com"
      local languageType = ToClient_getResourceType()
      if nil ~= languageType then
        local languageTypeString = Defines.LanguageTypeToString[languageType]
        if nil ~= languageTypeString then
          if CppEnums.ServiceResourceType.eServiceResourceType_ID == languageType then
            languageTypeString = "EN"
          end
          if "KR" == languageTypeString or "DV" == languageTypeString then
            url = url .. "/ko-kr"
          elseif "EN" == languageTypeString then
            url = url .. "/en-US"
          elseif "DE" == languageTypeString then
            url = url .. "/de-DE"
          elseif "FR" == languageTypeString then
            url = url .. "/fr-FR"
          elseif "ES" == languageTypeString or "SP" == languageTypeString then
            url = url .. "/es-ES"
            elseif true == isGameTypeTaiwan() then
              url = "https://www.tw.playblackdesert.com"
            elseif true == isGameTypeTR() then
              url = "https://www.tr.playblackdesert.com"
            elseif true == isGameTypeTH() then
              url = "https://www.th.playblackdesert.com"
            elseif true == isGameTypeID() then
              url = "https://www.sea.playblackdesert.com"
            elseif true == isGameTypeASIA() then
              local ingameBoardUrl = ToClient_getIngameBoardURL()
              local startIdx, endIdx = string.find(ingameBoardUrl, "/Game/InGame")
              local subUrl = string.sub(ingameBoardUrl, 0, startIdx)
              url = subUrl
            else
              return
            end
          end
        end
      else
      end
  end
  if true == isGameTypeASIA() then
    url = url .. "/Game/Classes?_classType=" .. _index
  else
    url = url .. "/GameInfo/Class?classType=" .. _index
  end
  if true == isAwakenOpen and true == Panel_Lobby_UI.CCSC_RadioAwakenMovie:IsCheck() then
    url = url .. "#awakening"
  else
    url = url .. "#original"
  end
  ToClient_OpenChargeWebPage(url, false)
end
function Panel_Lobby_SetMovie()
  if _index == nil then
    return
  end
  local movieName = getClassMovie(_index, FGlobal_GetPlayerCreateType())
  if movieName ~= nil then
    local isAwakenOpen = PaGlobalFunc_Util_GetIsAwakenWeaponContentsOpen(_index)
    if true == isAwakenOpen and true == Panel_Lobby_UI.CCSC_RadioAwakenMovie:IsCheck() then
      movieName = string.gsub(movieName, ".webm", "_A.webm")
    end
    Panel_Lobby_UI.CCSC_ClassMovie:TriggerEvent("PlayMovie", "coui://" .. movieName)
  end
end
function Panel_Lobby_SelectClass_MouseEvent(index, isOn)
  local classButton = Panel_Lobby_ClassUI.ClassButtons[index]
  if classButton ~= nil then
    if isOn == true then
      classButton:SetVertexAniRun("Ani_Color_Bright", true)
      if true == _ContentsGroup_UsePadSnapping then
        if index == Panel_Lobby_Global_Variable.currentSelectedIdx then
          Panel_Lobby_UI.CCSC_SelectConsole:SetText("Create")
        else
          Panel_Lobby_UI.CCSC_SelectConsole:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT"))
        end
      end
      classCountControl[index]:SetMonoTone(false)
      classCountControl[index]:useGlowFont(true, "RealFont_14_Glow", 4278190080)
      classCountControl[index]:SetShow(nil ~= classCount[index])
      local _isDev = ToClient_IsDevelopment()
      if _isDev == true or isGameTypeCH() == true then
        classCountControl[index]:SetSize(20, 20)
        classCountControl[index]:SetHorizonRight()
        classCountControl[index]:SetSpanSize(5, 5)
        classCountControl[index]:SetText("")
        classCountControl[index]:ChangeTextureInfoTextureIDAsync("Combine_Etc_Instock_icon", 0)
        classCountControl[index]:setRenderTexture(classCountControl[index]:getBaseTexture())
      else
        classCountControl[index]:SetSize(95, 20)
        classCountControl[index]:SetHorizonCenter()
        classCountControl[index]:SetSpanSize(0, 5)
        classCountControl[index]:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WINDOW_ARTIFACTS_LIST_INVENTORY"))
      end
    else
      classButton:ResetVertexAni()
      classCountControl[index]:useGlowFont(false)
      classCountControl[index]:SetShow(false)
    end
  end
end
function Panel_Lobby_SelectClass_Recommand_MouseEvent(classType, isShow)
  if isShow == false then
    Panel_Lobby_SelectClass_Recommand_HideAni()
    return
  end
  if Panel_Lobby_ClassUI.ClassButtons[classType] == nil or recommandClassIcon[classType] == nil then
    return
  end
  recommandTooltip:SetPosX(Panel_Lobby_ClassUI.ClassButtons[classType]:GetParentPosX())
  recommandTooltip:SetPosY(Panel_Lobby_ClassUI.ClassButtons[classType]:GetParentPosY() + recommandClassIcon[classType]:GetSizeY() + 5)
  local screenSizeX = getScreenSizeX()
  local overSizeX = screenSizeX - (recommandTooltip:GetPosX() + recommandTooltip:GetSizeX())
  if overSizeX < 0 then
    recommandTooltip:SetPosX(recommandTooltip:GetPosX() + overSizeX)
  end
  Panel_Lobby_SelectClass_Recommand_ShowAni()
end
function Panel_Lobby_SelectClass_Recommand_ShowAni()
  recommandTooltip:SetAlpha(0)
  recommandTooltip:SetShow(true)
  local aniInfo = UIAni.AlphaAnimation(1, recommandTooltip, 0, 0.5)
end
function Panel_Lobby_SelectClass_Recommand_HideAni()
  recommandTooltip:SetAlpha(1)
  local aniInfo = UIAni.AlphaAnimation(0, recommandTooltip, 0, 0.1)
  aniInfo:SetHideAtEnd(true)
end
function Panel_CharacterCreateOk()
  chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, Panel_Lobby_UI.CC_CharacterNameEdit:GetEditText(), _playerCreateType, false, __eQuestTutorialBranch_0)
end
function Panel_Lobby_CheckNotAllowSeasonClassType()
  if nil == Panel_Lobby_Global_Variable.characterSelectType then
    return true
  end
  return ToClient_checkNotAllowSeasonClassType(Panel_Lobby_Global_Variable.characterSelectType)
end
function Panel_CharacterCreateOK_Renew(characterName)
  local _edit_CharacterName = characterName
  local function createCharacterFunc()
    chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, _playerCreateType, false, __eQuestTutorialBranch_0)
    PaGlobalFunc_Customization_InputName_Close()
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeASIA() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName) .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
  else
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  end
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = createCharacterFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
end
function Panel_CharacterCreateOK_Confirm(tutorialBranch)
  local isSeason = false
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    isSeason = false
  else
    isSeason = true
  end
  local _edit_CharacterName = ""
  if false == _ContentsGroup_newCreateButtonLayout then
    if true == isSeason then
      _edit_CharacterName = PaGlobalFunc_Customization_GetEditName()
    else
      _edit_CharacterName = Panel_Lobby_UI.CM_Edit_CharacterName:GetEditText()
    end
  else
    _edit_CharacterName = PaGlobalFunc_Customization_GetInputName()
  end
  if tutorialBranch == nil then
    tutorialBranch = __eQuestTutorialBranch_0
  end
  local function createCharacterFunc()
    if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
      if _playerCreateType == __ePlayerCreatePremium then
        chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, _playerCreateType, false, __eQuestTutorialBranch_0)
      elseif _playerCreateType == __ePlayerCreateHardCore then
        chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, _playerCreateType, false, __eQuestTutorialBranch_0)
      else
        chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, _playerCreateType, PaGlobalFunc_Customization_IsSeasonBtnClick(), tutorialBranch)
      end
    else
      chracterCreate(Panel_Lobby_Global_Variable.characterSelectType, _edit_CharacterName, _playerCreateType, false, tutorialBranch)
    end
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  if isGameTypeKorea() or isGameTypeTaiwan() or isGameTypeTH() or isGameTypeASIA() or isGameTypeRussia() or isGameTypeID() or isGameTypeTR() then
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName) .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
  else
    messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  end
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = createCharacterFunc,
    functionNo = MessageBox_Empty_function,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  if true == _ContentsGroup_SelectStartPosition and FGlobal_GetPlayerCreateType() == __ePlayerCreateNormal then
    PaGlobal_StartBranch_All:prepareClose()
  end
  ClearFocusEdit()
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
  ToClient_DeleteCustomizationTempData()
  if _ContentsOption_CH_GPM == true then
    ToClient_reportChinaGPM(__eReportSceneClickCreateCharacterInCustomized, true)
  end
end
function Panel_CharacterCreateOK_NewCustomization(isPossible)
  local isSeason = false
  if false == _ContentsGroup_SeasonContents and false == _ContentsGroup_PreSeason then
    isSeason = false
  else
    isSeason = true
  end
  if isPossible == false then
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_MESSAGEBOX_NOTIFY"),
      content = PAGetString(Defines.StringSheet_GAME, "LUA_DUPLICATIONNAME_DIRECT_CREATE_IMPOSSIBLE"),
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
  end
  if false == _ContentsGroup_NewSequenceTutorial and true == _ContentsGroup_SelectStartPosition and FGlobal_GetPlayerCreateType() == __ePlayerCreateNormal and nil ~= Panel_Window_StartBranch then
    PaGlobalFunc_StartBranch_All_CreateOpen()
    return
  end
  Panel_CharacterCreateOK_Confirm(__eQuestTutorialBranch_0)
end
function Panel_CharacterCreateCancel()
  if true == characterCreateIsOnLookAtCameraTimerRunning() then
    characterCreateCancelIntroAction()
    return
  end
  Panel_CharacterCreateSelectClass:SetShow(false)
  characterCreateCancel(FGlobal_GetPlayerCreateType())
  TooltipSimple_Hide()
end
function Panel_Lobby_function_DeleteButton()
  if nil == Panel_Lobby_Global_Variable.UiMaker then
    return
  end
  for _, value in pairs(Panel_Lobby_Global_Variable.UIList) do
    UI.deleteControl(value)
  end
  Panel_Lobby_Global_Variable.UIList = {}
  Panel_Lobby_Global_Variable.UiMaker = nil
end
function Panel_Lobby_TooltipShow(buttonType)
  local uiControl, name, desc
  if 0 == buttonType then
    uiControl = Panel_Lobby_UI.CCSC_RadioNormalMovie
    name = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_MAINWEAPONTITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_SELECTCLASS_MAINWEAPONDESC")
  elseif 1 == buttonType then
    uiControl = Panel_Lobby_UI.CCSC_RadioNormalMovie
    name = tooltipNameSaved
    desc = tooltipDescSaved
  end
  if nil ~= uiControl then
    TooltipSimple_Show(uiControl, name, desc)
  end
end
function Panel_Lobby_TooltipHide()
  TooltipSimple_Hide()
end
function PaGlobalFunc_CharacterSelect_TabState()
  local classTabState = 1
  classTabState = PaGlobalFunc_CharacterSelect_All_GetCurrentTab()
  newCharacter()
  local newCharID = PaGlobalFunc_CharacterSelect_FirstClass()
  local count = getPossibleClassCount()
  local slotNum = 0
  local frameSizeY = 0
  local slotSizeY = 0
  for index = 0, count - 1 do
    local classType = getPossibleClassTypeFromIndex(index)
    local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
    local className = Panel_Lobby_ClassUI.ClassNames[classType]
    if classButton ~= nil and classButton:GetShow() then
      classButton:SetShow(false)
      className:SetShow(false)
    end
    if recommandClassIcon[classType] ~= nil then
      recommandClassIcon[classType]:SetShow(false)
    end
  end
  if TAB_TYPE.NORMAL == classTabState then
    for ii = 1, #newCharacterInfo do
      Panel_Lobby_ClassUI.ClassButtons[newCharacterInfo[ii][1]]:SetPosXY(ClassUI_Pos.posX[slotNum], ClassUI_Pos.posY[slotNum])
      Panel_Lobby_ClassUI.ClassNames[newCharacterInfo[ii][1]]:SetPosXY(ClassUI_Pos.nameX[slotNum], ClassUI_Pos.nameY[slotNum])
      slotNum = slotNum + 1
    end
    for index = 0, count - 1 do
      local classType = getPossibleClassTypeFromIndex(index)
      local classButton = Panel_Lobby_ClassUI.ClassButtons[classType]
      local className = Panel_Lobby_ClassUI.ClassNames[classType]
      if nil ~= classButton then
        if PaGlobalFunc_CharacterSelect_CheckNewClass(classType) == false then
          classButton:SetPosX(ClassUI_Pos.posX[slotNum])
          classButton:SetPosY(ClassUI_Pos.posY[slotNum])
          className:SetPosX(ClassUI_Pos.nameX[slotNum])
          if 20 < className:GetTextSizeY() then
            className:SetPosY(ClassUI_Pos.nameY[slotNum] - (className:GetTextSizeY() - 20))
          else
            className:SetPosY(ClassUI_Pos.nameY[slotNum])
          end
          slotNum = slotNum + 1
        end
        slotSizeY = classButton:GetSizeY()
        classButton:SetShow(true)
        className:SetShow(true)
      end
      if recommandClassIcon[classType] ~= nil then
        local _isDev = ToClient_IsDevelopment()
        if _isDev == true or isGameTypeCH() == true or isGameTypeNA() then
          recommandClassIcon[classType]:SetShow(true)
          recommandClassIcon[classType]:SetSpanSize(5, 5)
        else
          recommandClassIcon[classType]:SetShow(false)
        end
        recommandClassIcon[classType]:SetPosX(classButton:GetPosX())
        recommandClassIcon[classType]:SetPosY(classButton:GetPosY() + 1)
      end
    end
  elseif TAB_TYPE.PREMIUM == classTabState then
    for idx = 0, getPossiblePremiumClassCount() - 1 do
      local specialType = getPossiblePremiumClassTypeFromIndex(idx)
      local classButton = Panel_Lobby_ClassUI.ClassButtons[specialType]
      local className = Panel_Lobby_ClassUI.ClassNames[specialType]
      if nil ~= classButton then
        classButton:SetPosX(ClassUI_Pos.posX[slotNum])
        classButton:SetPosY(ClassUI_Pos.posY[slotNum])
        classButton:SetShow(true)
        className:SetPosX(ClassUI_Pos.nameX[slotNum])
        if 20 < className:GetTextSizeY() then
          className:SetPosY(ClassUI_Pos.nameY[slotNum] - (className:GetTextSizeY() - 20))
        else
          className:SetPosY(ClassUI_Pos.nameY[slotNum])
        end
        className:SetShow(true)
        slotNum = slotNum + 1
        slotSizeY = classButton:GetSizeY()
      end
    end
  elseif TAB_TYPE.HARDCORE == classTabState then
    for idx = 0, ToClient_getHardCorePossbieClassCount() - 1 do
      local specialType = ToClient_getHardCorePossbieClassFromIndex(idx)
      local classButton = Panel_Lobby_ClassUI.ClassButtons[specialType]
      local className = Panel_Lobby_ClassUI.ClassNames[specialType]
      if nil ~= classButton then
        classButton:SetPosX(ClassUI_Pos.posX[slotNum])
        classButton:SetPosY(ClassUI_Pos.posY[slotNum])
        classButton:SetShow(true)
        className:SetPosX(ClassUI_Pos.nameX[slotNum])
        if 20 < className:GetTextSizeY() then
          className:SetPosY(ClassUI_Pos.nameY[slotNum] - (className:GetTextSizeY() - 20))
        else
          className:SetPosY(ClassUI_Pos.nameY[slotNum])
        end
        className:SetShow(true)
        slotNum = slotNum + 1
        slotSizeY = classButton:GetSizeY()
      end
    end
  end
  local addRaw = 1
  if 0 == slotNum % columnCountByRaw then
    addRaw = 0
  end
  frameSizeY = (math.floor(slotNum / columnCountByRaw) + addRaw) * (slotSizeY + classButtonGapY) + classButtonGapY
  _frameContents:SetSize(_frameContents:GetSizeX(), frameSizeY)
end
function PaGlobalFunc_CharacterSelect_CheckNewClass(classType)
  for ii = 1, #newCharacterInfo do
    if newCharacterInfo[ii][1] == classType then
      return true
    end
  end
  return false
end
function PaGlobalFunc_CharacterSelect_FirstClass()
  return PaGlobalFunc_Util_GetNewClassType()
end
function PaGlobalFunc_CharacterSelect_IsCheckPremiumCharacter(classType)
  for idx = 0, getPossiblePremiumClassCount() - 1 do
    if getPossiblePremiumClassTypeFromIndex(idx) == classType then
      return true
    end
  end
  return false
end
function PaGlobalFunc_CharacterSelect_GetFristHardCoreClass()
  local count = ToClient_getHardCorePossbieClassCount()
  if count == 0 then
    return __eClassType_Warrior
  end
  local classType = ToClient_getHardCorePossbieClassFromIndex(0)
  return classType
end
local applyButton = UI.getChildControl(Panel_CharacterCreateSelectClassTest, "Button_Apply")
local shadowClassEdit = UI.getChildControl(Panel_CharacterCreateSelectClassTest, "Edit_ShadowClassIndex")
Panel_CharacterCreateSelectClassTest:SetShow(false)
function PaGlobalFunc_SelectShadowCharacter_Toggle()
  if false == ToClient_IsDevelopment() then
    return
  end
  if false == Panel_CharacterCreateSelectClassTest:GetShow() then
    Panel_CharacterCreateSelectClassTest:SetShow(true)
    shadowClassEdit:SetMaxInput(15)
    applyButton:addInputEvent("Mouse_LUp", "PaGlobalFunc_SelectShadowCharacter_Apply()")
  else
    Panel_CharacterCreateSelectClassTest:SetShow(false)
  end
end
function PaGlobalFunc_SelectShadowCharacter_Apply()
  local shadowClass = shadowClassEdit:GetEditText()
  shadowClassEdit:SetEditText("")
  ToClient_SelectShadowCharacterShow(shadowClass)
end
function FromClient_ClassVideoInitComplete()
  Panel_Lobby_SetMovie()
end
Panel_Lobby_Function_Initialize()
registerEvent("EventChangeLobbyStageToCharacterCreate_SelectClass", "Panel_Lobby_Function_showCharacterCreate_SelectClass")
registerEvent("FromClient_ClassVideoInitComplete", "FromClient_ClassVideoInitComplete")
registerEvent("EventCharacterCustomizationInitUi", "Panel_Lobby_Function_showCharacterCustomization")
registerEvent("FromClient_CharacterCreateOK", "Panel_CharacterCreateOK_NewCustomization")
