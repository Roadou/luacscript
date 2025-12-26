local _panel = Panel_Lobby_ClassSelect_Renew
local _DefalutScreenSizeX = 1920
local _DefalutScreenSizeY = 1080
local ClassSelect = {
  _ui = {
    stc_LeftTopGroup = UI.getChildControl(_panel, "Static_LeftTopGroup"),
    list_ClassSelect = UI.getChildControl(_panel, "List2_Class"),
    stc_BottomGroup = UI.getChildControl(_panel, "Static_BottomGroup")
  },
  _focusTable = {},
  _currentSelectType = -1,
  _prevSelectType = -1,
  _Edit_CharacterName,
  _mainWeaponText,
  _subWeaponText,
  _mpConsumeType
}
local _playerCreateType = __ePlayerCreateNormal
function FGlobal_SetPlayerCreateType(playerCreateType)
  _playerCreateType = playerCreateType
end
function FGlobal_GetPlayerCreateType()
  return _playerCreateType
end
function ClassSelect:init()
  self._ui.txt_Title = UI.getChildControl(self._ui.stc_LeftTopGroup, "StaticText_Title")
  self._ui.txt_WeaponMain = UI.getChildControl(self._ui.stc_LeftTopGroup, "StaticText_WeaponMain")
  self._ui.txt_WeaponSub = UI.getChildControl(self._ui.stc_LeftTopGroup, "StaticText_WeaponSub")
  self._ui.txt_MP = UI.getChildControl(self._ui.stc_LeftTopGroup, "StaticText_MP")
  self._mainWeaponText = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_MAINHAND")
  self._subWeaponText = PAGetString(Defines.StringSheet_GAME, "PANEL_TOOLTIP_EQUIP_SUBHAND")
  self._mpConsumeType = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOBBY_SELECTCLASS_MP")
  self._ui.txt_ExitConsoleUI = UI.getChildControl(self._ui.stc_BottomGroup, "StaticText_Exit_ConsoleUI")
  self._ui.txt_SelectConsoleUI = UI.getChildControl(self._ui.stc_BottomGroup, "StaticText_Create_ConsoleUI")
  self._ui.txt_ShowSkillConsoleUI = UI.getChildControl(self._ui.stc_BottomGroup, "StaticText_ShowSkill_ConsoleUI")
  self._ui.txt_ShowSkillConsoleUI:SetShow(false)
  self._ui.txt_SelectConsoleUI:SetPosX(self._ui.txt_ExitConsoleUI:GetPosX() - self._ui.txt_SelectConsoleUI:GetTextSizeX() - self._ui.txt_SelectConsoleUI:GetSizeX() - 34)
  local keyGuides = {
    self._ui.txt_SelectConsoleUI,
    self._ui.txt_ExitConsoleUI
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_BottomGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
  if false == _ContentsGroup_RenewUI_Customization then
    self._Edit_CharacterName = UI.getChildControl(Panel_CustomizationMain, "Edit_CharacterName")
  end
  PaGlobalFunc_ClassSelect_ReSize()
  self:registEvent()
  self._ui.list_ClassSelect:getElementManager():clearKey()
  local classType = -1
  local count = getPossibleClassCount()
  if _ContentsGroup_HardCoreChannel == true and playerCreateType == __ePlayerCreateHardCore then
    count = ToClient_getHardCorePossbieClassCount()
  end
  for classIdx = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(classIdx)
    if _ContentsGroup_HardCoreChannel == true and playerCreateType == __ePlayerCreateHardCore then
      classType = ToClient_getHardCorePossbieClassFromIndex(classIdx)
    end
    if PaGlobalFunc_Util_GetClassTypeInfo(classType) ~= nil then
      self._ui.list_ClassSelect:getElementManager():pushKey(toInt64(0, classType))
    end
  end
  self._ui.list_ClassSelect:SetShow(false)
end
function ClassSelect:open()
  self._currentSelectType = -1
  self._prevSelectType = -1
  self._ui.list_ClassSelect:getElementManager():clearKey()
  local classType = -1
  local topClassType
  local playerCreateType = FGlobal_GetPlayerCreateType()
  local count = getPossibleClassCount()
  if _ContentsGroup_HardCoreChannel == true and playerCreateType == __ePlayerCreateHardCore then
    count = ToClient_getHardCorePossbieClassCount()
  end
  local newClassType = NewClassData.BeforeClassType
  local checkNewClassType = PaGlobalFunc_Util_GetNewClassType()
  if checkNewClassType ~= nil then
    newClassType = checkNewClassType
  end
  for classIdx = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(classIdx)
    if _ContentsGroup_HardCoreChannel == true and playerCreateType == __ePlayerCreateHardCore then
      classType = ToClient_getHardCorePossbieClassFromIndex(classIdx)
    end
    if playerCreateType ~= __ePlayerCreatePremium and playerCreateType ~= __ePlayerCreateHardCore and classType == newClassType and PaGlobalFunc_Util_GetClassTypeInfo(classType) ~= nil then
      self._ui.list_ClassSelect:getElementManager():pushKey(toInt64(0, classType))
      if nil == topClassType then
        topClassType = classType
      end
    end
  end
  for classIdx = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(classIdx)
    if _ContentsGroup_HardCoreChannel == true and playerCreateType == __ePlayerCreateHardCore then
      classType = ToClient_getHardCorePossbieClassFromIndex(classIdx)
    end
    if PaGlobalFunc_Util_GetClassTypeInfo(classType) ~= nil and (playerCreateType == __ePlayerCreatePremium or playerCreateType == __ePlayerCreateHardCore or classType ~= newClassType) then
      self._ui.list_ClassSelect:getElementManager():pushKey(toInt64(0, classType))
      if nil == topClassType then
        topClassType = classType
      end
    end
  end
  self._ui.list_ClassSelect:SetShow(true)
  _panel:SetShow(true)
  if nil == topClassType then
    topClassType = __eClassType_Warrior
  end
  InputMLUp_ClassSelect_SelectClassType(topClassType)
  for classIdx = 0, count - 1 do
    classType = getPossibleClassTypeFromIndex(classIdx)
    if _ContentsGroup_HardCoreChannel == true and playerCreateType == __ePlayerCreateHardCore then
      classType = ToClient_getHardCorePossbieClassFromIndex(classIdx)
    end
    if PaGlobalFunc_Util_GetClassTypeInfo(classType) ~= nil then
      self._ui.list_ClassSelect:requestUpdateByKey(toInt64(0, classType))
    end
  end
end
function ClassSelect:close()
  _panel:SetShow(false)
end
function ClassSelect:registEvent()
  self._ui.list_ClassSelect:registEvent(__ePAUIList2EventType_LuaChangeContent, "PaGlobalFunc_ClassSelect_ControlCreate")
  self._ui.list_ClassSelect:createChildContent(__ePAUIList2ElementManagerType_List)
end
function PaGlobalFunc_ClassSelect_Init()
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  self:init()
end
function PaGlobalFunc_ClassSelect_ControlCreate(content, key)
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  local classType = Int64toInt32(key)
  if classType < 0 then
    return
  end
  local stc_ClassBG = UI.getChildControl(content, "Static_ClassBG")
  local stc_FocusBox = UI.getChildControl(content, "Static_FoucsBox")
  local txt_ClassName = UI.getChildControl(content, "StaticText_ClassName")
  stc_ClassBG:SetShow(false)
  PaGlobalFunc_Util_SetCharacterSelectClassIcon(stc_ClassBG, classType)
  stc_ClassBG:SetShow(true)
  if NewClassData.newClass_String[classType] == nil then
    return
  end
  local classTypeString = NewClassData.newClass_String[classType]._classType2String
  if classTypeString == nil then
    classTypeString = ""
  end
  txt_ClassName:SetText(classTypeString)
  if classType == self._currentSelectType then
    stc_ClassBG:SetPosX(5)
    stc_FocusBox:SetPosX(0)
    txt_ClassName:SetPosX(190)
  else
    stc_ClassBG:SetPosX(25)
    stc_FocusBox:SetPosX(20)
    txt_ClassName:SetPosX(210)
  end
  self._focusTable[classType] = stc_FocusBox
  content:SetShow(true)
  stc_ClassBG:addInputEvent("Mouse_LUp", "InputMLUp_ClassSelect_SelectClassType(" .. classType .. ")")
  stc_ClassBG:addInputEvent("Mouse_On", "InputMO_ClassSelect_SelectClassType(" .. classType .. ")")
end
function PaGlobalFunc_ClassSelect_CharacterCreate(characterName, tutorialBranch)
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  local _edit_CharacterName = characterName
  local function createCharacterFunc()
    local isSeasonCharacter = false
    if nil ~= PaGlobalFunc_Customization_InputName_CanMakeSeasonCharacter and true == PaGlobalFunc_Customization_InputName_CanMakeSeasonCharacter() and nil ~= PaGlobalFunc_Customization_InputName_GetSeasonCharacterChecked then
      isSeasonCharacter = PaGlobalFunc_Customization_InputName_GetSeasonCharacterChecked()
    end
    if tutorialBranch == nil then
      tutorialBranch = __eQuestTutorialBranch_0
    end
    chracterCreate(self._currentSelectType, _edit_CharacterName, _playerCreateType, isSeasonCharacter, tutorialBranch)
    PaGlobalFunc_Customization_InputName_Open(false)
    PaGlobalFunc_Customization_InputName_SetCreateSync(false)
  end
  local cancelCharacterFunc = function()
    PaGlobalFunc_Customization_InputName_Open(false)
  end
  if nil == characterName or "" == characterName then
    local messageBoxMemo = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_AGREEMENTGUILD_EDIT")
    local messageBoxData = {
      title = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE"),
      content = messageBoxMemo,
      functionApply = MessageBox_Empty_function,
      priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
    }
    MessageBox.showMessageBox(messageBoxData)
    return
  end
  local messageBoxTitle = PAGetString(Defines.StringSheet_GAME, "LUA_ALERT_DEFAULT_TITLE")
  local messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  if not isGameServiceTypeKor() then
  end
  messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName) .. [[


<PAColor0xFFF26A6A>]] .. PAGetString(Defines.StringSheet_GAME, "LUA_MAKENAME_WARNING") .. "<PAOldColor>"
  do break end
  messageBoxMemo = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_LOBBY_MAIN_CHARACTERCREATE_RECONFIRM_CHARACTERNAME", "name", _edit_CharacterName)
  local messageBoxData = {
    title = messageBoxTitle,
    content = messageBoxMemo,
    functionYes = createCharacterFunc,
    functionNo = cancelCharacterFunc,
    priority = CppEnums.PAUIMB_PRIORITY.PAUIMB_PRIORITY_LOW
  }
  MessageBox.showMessageBox(messageBoxData)
  ClearFocusEdit()
  closeExplorer()
  Panel_CustomizingAlbum:SetShow(false)
  if true == _ContentsGroup_SelectStartPosition and _playerCreateType == __ePlayerCreateNormal then
    PaGlobal_StartBranch_All:prepareClose()
  end
end
function PaGlobalFunc_ClassSelect_Open()
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  PaGlobalFunc_CharacterSelect_All_Close()
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
  self:open()
end
function PaGlobalFunc_ClassSelect_Close()
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  self:close()
end
function PaGlobalFunc_ClassSelect_showCustomization(customizationData)
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  PaGlobalFunc_ClassSelect_Close()
  resizeUIScale()
  if true == _ContentsGroup_RenewUI_Customization then
    PaGlobalFunc_Customization_SetClassType(self._currentSelectType)
  else
    self._Edit_CharacterName:SetEditText("")
    ShowCharacterCustomization(customizationData, self._currentSelectType, false)
  end
  viewCharacterCreateMode(self._currentSelectType)
end
function Panel_CharacterCreateCancel()
  if true == characterCreateIsOnLookAtCameraTimerRunning() then
    characterCreateCancelIntroAction()
    return
  end
  _AudioPostEvent_SystemUiForXBOX(50, 3)
  _panel:SetShow(false)
  characterCreateCancel(FGlobal_GetPlayerCreateType())
  TooltipSimple_Hide()
end
function InputMLUp_ClassSelect_SelectClassType(classType)
  local self = ClassSelect
  _AudioPostEvent_SystemUiForXBOX(50, 0)
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  if classType >= __eClassType_Count then
    _PA_ASSERT(false, "\236\152\172\235\176\148\235\165\180\236\167\128 \236\149\138\236\157\128 class type \236\158\133\235\139\136\235\139\164!!")
    return
  end
  if false == ToClient_checkCreatePossibleClass(classType, _playerCreateType) then
    _PA_ASSERT(false, "\236\132\160\237\131\157\237\149\160 \236\136\152 \236\151\134\235\138\148 \237\129\180\235\158\152\236\138\164 \236\158\133\235\139\136\235\139\164!!")
    return
  end
  if classType == self._currentSelectType then
    _AudioPostEvent_SystemUiForXBOX(1, 2)
    changeCreateCharacterMode()
    return
  else
    local classTypeSelectInfo = PaGlobalFunc_Util_GetClassTypeInfo(classType)
    self._currentSelectType = classType
    self._ui.list_ClassSelect:requestUpdateByKey(toInt64(0, self._currentSelectType))
    self._ui.list_ClassSelect:requestUpdateByKey(toInt64(0, self._prevSelectType))
    self._prevSelectType = self._currentSelectType
    self._ui.txt_WeaponMain:SetText(self._mainWeaponText .. " : " .. classTypeSelectInfo._mainWeaponType)
    self._ui.txt_WeaponSub:SetText(self._subWeaponText .. " : " .. classTypeSelectInfo._subWeaponType)
    self._ui.txt_MP:SetText(self._mpConsumeType .. " : " .. classTypeSelectInfo._manaType)
    viewCharacterCreateSelectClassMode(classType)
  end
end
function InputMO_ClassSelect_SelectClassType(classType)
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  for _, focus in pairs(self._focusTable) do
    focus:SetShow(false)
  end
  self._focusTable[classType]:SetShow(true)
  local selectText = ""
  if classType == self._currentSelectType then
    selectText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_LOBBY_SELECTCLASS_CREATE")
  else
    selectText = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_DIALOG_MAIN_SELECT")
  end
  self._ui.txt_SelectConsoleUI:SetText(selectText)
  self._ui.txt_SelectConsoleUI:SetPosX(self._ui.txt_ExitConsoleUI:GetPosX() - self._ui.txt_SelectConsoleUI:GetTextSizeX() - self._ui.txt_SelectConsoleUI:GetSizeX() - 34)
  local keyGuides = {
    self._ui.txt_SelectConsoleUI,
    self._ui.txt_ExitConsoleUI
  }
  PaGlobalFunc_ConsoleKeyGuide_SetAlign(keyGuides, self._ui.stc_BottomGroup, CONSOLEKEYGUID_ALIGN_TYPE.eALIGN_TYPE_RIGHT)
end
function FromClient_PlayGoSelectClass(index)
  InputMLUp_ClassSelect_SelectClassType(index)
end
function PaGlobalFunc_ClassSelect_ReSize()
  local self = ClassSelect
  if nil == self then
    _PA_ASSERT(false, "\237\140\168\235\132\144\236\157\180 \236\161\180\236\158\172\237\149\152\236\167\128 \236\149\138\236\138\181\235\139\136\235\139\164!! : ClassSelect")
    return
  end
  local screenSizeX = getScreenSizeX()
  local screenSizeY = getScreenSizeY()
  local modifiedRateX = Panel_Lobby_ClassSelect_Renew:GetSizeX() / screenSizeX
  local modifiedRateY = Panel_Lobby_ClassSelect_Renew:GetSizeY() / screenSizeY
  Panel_Lobby_ClassSelect_Renew:SetSize(screenSizeX, screenSizeY)
  Panel_Lobby_ClassSelect_Renew:ComputePos()
  self._ui.stc_LeftTopGroup:SetPosXY(self._ui.stc_LeftTopGroup:GetPosX() * modifiedRateX, self._ui.stc_LeftTopGroup:GetPosY() * modifiedRateY)
  self._ui.stc_BottomGroup:SetPosY(self._ui.stc_BottomGroup:GetPosY() * modifiedRateY)
  self._ui.stc_BottomGroup:SetPosX(screenSizeX - self._ui.stc_BottomGroup:GetSizeX() - 25)
  self._ui.stc_BottomGroup:ComputePos()
  self._ui.list_ClassSelect:SetSize(self._ui.list_ClassSelect:GetSizeX(), screenSizeY - self._ui.stc_BottomGroup:GetSizeY() - 30)
  self._ui.list_ClassSelect:ComputePos()
  self._ui.txt_ExitConsoleUI:ComputePos()
  self._ui.txt_SelectConsoleUI:ComputePos()
end
PaGlobalFunc_ClassSelect_Init()
registerEvent("EventChangeLobbyStageToCharacterCreate_SelectClass", "PaGlobalFunc_ClassSelect_Open")
registerEvent("EventCharacterCustomizationInitUi", "PaGlobalFunc_ClassSelect_showCustomization")
if ToClient_IsDevelopment() == true then
  registerEvent("PlayGoSelectClass", "FromClient_PlayGoSelectClass")
end
