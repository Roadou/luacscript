local UIGroup = Defines.UIGroup
local RenderMode = Defines.RenderMode
local _IsXbox = _ContentsGroup_UsePadSnapping
runLua("UI_Data/Script/RenderMode/renderMode.lua")
local _isRemasterUIOption = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eSwapRemasterUISetting)
local _isRemasterUIInit = ToClient_getGameUIManagerWrapper():getLuaCacheDataListBool(__eInitRemasterUI)
function PaGlobalFunc_IsRemasterUIOption()
  if ToClient_isInAbyssOne() == true then
    return true
  end
  if false == _isRemasterUIInit then
    return true
  end
  return _isRemasterUIOption
end
function PaGlobalFunc_SetRemasterUIOption(isRemaster)
  _isRemasterUIOption = isRemaster
end
function basicLoadUI(panelNodeName, panelID, panelGroup)
  loadUI(panelNodeName, panelID, panelGroup, SETRENDERMODE_BITSET_DEFULAT())
end
function CheckTutorialEnd()
  if getSelfPlayer() == nil then
    return false
  end
  if true == _ContentsGroup_Tutorial_Renewal then
    return 7 <= getSelfPlayer():get():getLevel()
  end
  return ToClient_getTutorialLimitLevel() <= getSelfPlayer():get():getLevel()
end
LOADUI_TYPE = {
  logoUI = 0,
  loginUI = 1,
  serverSelectUI = 2,
  loadingUI = 3,
  lobbyUI = 4,
  preLoadGameUI = 5,
  GameUI = 6,
  GameUI_XXX = 7,
  WorldMapUI = 8
}
local _loadUIFunc = {}
function PaGlobal_SetLoadUIFunc(func, Type)
  _loadUIFunc[Type] = func
end
local _reloadUIFunc = {}
function PaGlobal_SetReloadUIFunc(func, reloadEventType)
  if reloadEventType == nil or reloadEventType < 0 or reloadEventType >= __eUIReloadEventType_Count then
    UI.ASSERT_NAME(false, "reloadEventType\236\151\144 \235\140\128\237\149\156 \237\150\137\236\156\132\234\176\128 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  _reloadUIFunc[reloadEventType] = func
end
local ePlatform = {
  PC = 0,
  XBox = 1,
  PS4 = 2,
  Instance = 3,
  InstanceLobby = 4
}
local platformType = ePlatform.PC
function PaGlobal_LoadPlatformUI()
  if ToClient_isMustAbyssOneLoading() == true and ToClient_isMagnusTeleportFlag() == false then
    if ToClient_isConsole() == true then
      runLua("UI_Data/Script/AbyssOne/loadUI_AbyssOne_Console.lua")
      platformType = ePlatform.XBox
    elseif _ContentsGroup_UsePadSnapping == true then
      runLua("UI_Data/Script/AbyssOne/loadUI_AbyssOne_PadControl.lua")
      platformType = ePlatform.PC
    else
      runLua("UI_Data/Script/AbyssOne/loadUI_AbyssOne.lua")
      platformType = ePlatform.PC
    end
  elseif ToClient_isConsole() == true then
    runLua("UI_Data/Script/loadUI_Console.lua")
    platformType = ePlatform.XBox
  elseif _ContentsGroup_UsePadSnapping == true then
    runLua("UI_Data/Script/loadUI_PC_PadControl.lua")
    platformType = ePlatform.PC
  else
    runLua("UI_Data/Script/loadUI_PC.lua")
    platformType = ePlatform.PC
  end
end
PaGlobal_LoadPlatformUI()
function loadLogoUI()
  local func = _loadUIFunc[LOADUI_TYPE.logoUI]
  func()
end
function loadLoginUI()
  local func = _loadUIFunc[LOADUI_TYPE.loginUI]
  func()
end
function loadServerSelectUI()
  local func = _loadUIFunc[LOADUI_TYPE.serverSelectUI]
  func()
end
function loadLoadingUI()
  local func = _loadUIFunc[LOADUI_TYPE.loadingUI]
  func()
end
function loadSceneEditUI()
  basicLoadUI("UI_Data/Widget/Radar/Panel_Widget_SceneEdit_Radar.XML", "Panel_SceneEdit_Radar_All", UIGroup.PAGameUIGroup_MainUI)
  runLua("UI_Data/Script/Widget/Radar/Panel_SceneEdit_Radar.lua")
  if true == ToClient_IsDevelopment() then
    basicLoadUI("UI_Data/Widget/NakMessage/NakMessage.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog)
    loadUI("UI_Data/Window/JobInfoReqForDev/UI_JobInfo_Create.XML", "Panel_JobInfoCreate", UIGroup.PAGameUIGroup_Tutorial, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/JobInfoReqForDev/UI_JobInfo_Func.XML", "Panel_JobInfoFunc", UIGroup.PAGameUIGroup_Tutorial, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
    runLua("UI_Data/Script/Window/JobInfoReqForDev/Panel_JobInfoCreate.lua")
    runLua("UI_Data/Script/Window/JobInfoReqForDev/Panel_JobInfoFunc.lua")
  end
end
function loadLobbyUI()
  local func = _loadUIFunc[LOADUI_TYPE.lobbyUI]
  func()
end
function preLoadGameUI()
  local func = _loadUIFunc[LOADUI_TYPE.preLoadGameUI]
  func()
  loadUI("UI_Data/Widget/UIcontrol/QASupport_AutomationPanel.XML", "QASupport_AutomationPanel", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
end
function loadGameUI()
  local func = _loadUIFunc[LOADUI_TYPE.GameUI]
  func()
  runLua("UI_Data/Script/QASupport/QASupport_AutomationPanel/QASupport_AutomationPanel.lua")
end
function loadGameUI_XXX()
  local func = _loadUIFunc[LOADUI_TYPE.GameUI_XXX]
  func()
end
function loadWorldMapUI()
  local func = _loadUIFunc[LOADUI_TYPE.WorldMapUI]
  func()
end
function preLoadGameOptionUI()
  basicLoadUI("UI_Data/Window/WebHelper/Panel_WebControl.XML", "Panel_WebControl", UIGroup.PAGameUIGroup_DeadMessage)
  basicLoadUI("UI_Data/Window/WebHelper/Panel_WebCashPayment.XML", "Panel_WebCashPayment", UIGroup.PAGameUIGroup_DeadMessage)
  basicLoadUI("UI_Data/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.XML", "Panel_Window_PearlBox_Purchase_All", UIGroup.PAGameUIGroup_GameMenu)
  if true == _ContentsGroup_NewUI_GameOption_All then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Window_Gameoption_Main_All.XML", "Panel_Window_GameOption_All", UIGroup.PAGameUIGroup_Windows)
    if ToClient_isLobbyProcessor() == true then
      basicLoadUI("UI_Data/Window/c_Option/Panel_Window_Gameoption_Tutorial_All.XML", "Panel_Window_GameoptionTutorial_All", UIGroup.PAGameUIGroup_Window_Progress)
      Panel_Window_GameoptionTutorial_All:setUiConvertableType(CppEnums.UIConvertableType.eUIConvertableType_none)
    end
  elseif true == _ContentsGroup_isNewOption then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Option_Main.XML", "Panel_Window_cOption", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Camera.XML", "Panel_Performance_Camera", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_GraphicQuality.XML", "Panel_Performance_GraphicQuality", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Npc.XML", "Panel_Performance_Npc", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Optimize.XML", "Panel_Performance_Optimize", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Alert.XML", "Panel_Function_Alert", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Nation.XML", "Panel_Function_Nation", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Camera.XML", "Panel_Graphic_Camera", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Effect.XML", "Panel_Graphic_Effect", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Quality.XML", "Panel_Graphic_Quality", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_ScreenShot.XML", "Panel_Graphic_ScreenShot", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Window.XML", "Panel_Graphic_Window", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Hdr.XML", "Panel_Graphic_HDR", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Sound_OnOff.XML", "Panel_Sound_OnOff", UIGroup.PAGameUIGroup_Windows)
    if true == _ContentsGroup_InstrumentPerformance then
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    else
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume_NonMusicPlayOption.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    end
  elseif true == _ContentsGroup_RenewUI_RenewOPtion then
    basicLoadUI("UI_Data/Window/c_Option/Console/Panel_Window_OptionMain_Renew.XML", "Panel_Window_Option_Main", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill.XML", "Panel_Tooltip_Skill", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLearning.XML", "Panel_Tooltip_Skill_forLearning", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_BlackSpirit.XML", "Panel_Tooltip_Skill_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLinkTooltip.XML", "Panel_Tooltip_Skill_forLinkTooltip", UIGroup.PAGameUIGroup_GameMenu)
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item.XML", "Panel_Tooltip_Item", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItem.XML", "Panel_Tooltip_Item_chattingLinkedItem", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItemClick.XML", "Panel_Tooltip_Item_chattingLinkedItemClick", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_equipped.XML", "Panel_Tooltip_Item_equipped", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Guild_Introduce.XML", "Panel_Tooltip_Guild_Introduce", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Common.XML", "Panel_Tooltip_Common", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Worker.XML", "Panel_Worker_Tooltip", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Work.XML", "Panel_Tooltip_Work", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip)
end
function loadGameOptionUI()
  if true == _ContentsGroup_NewUI_GameOption_All then
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Header_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Initialize_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_OptionFunc_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Main_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Util_All.lua")
    if ToClient_isLobbyProcessor() == true then
      runLua("UI_Data/Script/Window/c_Option/Panel_Window_Gameoption_Tutorial_All.lua")
    end
    PaGlobal_GameOption_All:Init()
    ToClient_initGameOption()
  elseif true == _ContentsGroup_isNewOption then
    runLua("UI_Data/Script/Window/Option/GameOptionHeader.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionMain.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
    runLua("UI_Data/Script/Window/Option/Panel_Option_Main.lua")
    PaGlobal_Option:Init()
    ToClient_initGameOption()
  elseif true == _ContentsGroup_RenewUI_RenewOPtion then
    runLua("UI_Data/Script/Window/Option/GameOptionHeader_Renew.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionMain_Renew.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
    runLua("UI_Data/Script/Window/Option/Panel_Option_Main_Renew.lua")
    PaGlobal_Option:Init()
    ToClient_initGameOption()
  end
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinderManager.lua")
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinder.lua")
  runLua("UI_Data/Script/Tutorial/Panel_WebControl.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_WebCashPayment.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Item.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Guild_Introduce.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Common.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Worker.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Work.lua")
end
function loadOceanUI()
  basicLoadUI("UI_Data/Window/Cutscene/Panel_CutsceneMovie.XML", "Panel_Cutscene", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Acquire/Acquire.XML", "Panel_Acquire", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Acquire/Acquire_QuestDirect.XML", "Panel_QuestDirect", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_Movie_KeyViewer.xml", "Panel_Movie_KeyViewer", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Tutorial
  }))
  loadUI("UI_Data/Window/Cutscene/Panel_Cutscene_QuickTimeEvent_1.XML", "Panel_Window_QuickTimeEvent_CircleKeyDown", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  runLua("UI_Data/Script/Widget/Acquire/Acquire.lua")
  runLua("UI_Data/Script/CutScene_Ocean.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire_QuestDirect.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_Movie_KeyViewer.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_QuickTimeEvent_Manager.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_QuickTimeEvent_CircleKeyDown.lua")
  basicLoadUI("UI_Data/Window/Sequence/Panel_SequenceMain.XML", "Panel_SequenceMain", UIGroup.PAGameUIGroup_Dialog)
  basicLoadUI("UI_Data/Window/Sequence/Panel_Sequence_SubTitle.XML", "Panel_Sequence_SubTitle", UIGroup.PAGameUIGroup_Dialog)
  basicLoadUI("UI_Data/Window/Sequence/Panel_SequenceNotifier.XML", "Panel_SequenceNotifier", UIGroup.PAGameUIGroup_Dialog)
  basicLoadUI("UI_Data/Window/Sequence/Panel_Sequence_LetterBox.XML", "Panel_Sequence_LetterBox", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Window/Sequence/Panel_Sequence_TitleTexture.XML", "Panel_Sequence_TitleTexture", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Window/Sequence/Panel_Sequence_SkillTutorial.XML", "Panel_Sequence_SkillTutorial", UIGroup.PAGameUIGroup_MainUI)
  runLua("UI_Data/Script/Sequence/Panel_SequenceMain.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_LetterBox.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SubTitle.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceNotifier.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_TitleTexture.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SkillTutorial.lua")
  FromClient_InitSequenceMain()
end
function PaGlobal_GetPanelWindowInventory()
  if ePlatform.Instance == platformType then
    return Instance_Window_Inventory
  elseif ePlatform.InstanceLobby == platformType then
    return Instance_Window_Inventory
  elseif true == _ContentsGroup_NewUI_Inventory_All then
    return Panel_Window_Inventory_All
  else
    return Panel_Window_Inventory
  end
end
function PaGlobal_GetPanelTooltipSimpleText()
  if ePlatform.Instance == platformType then
    return Instance_Tooltip_SimpleText
  elseif ePlatform.InstanceLobby == platformType then
    return Instance_Tooltip_SimpleText
  else
    return Panel_Tooltip_SimpleText
  end
end
function reloadUIByEvent(reloadEventType)
  if reloadEventType == nil or reloadEventType < 0 or reloadEventType >= __eUIReloadEventType_Count then
    UI.ASSERT_NAME(false, "reloadEventType\236\151\144 \235\140\128\237\149\156 \237\150\137\236\156\132\234\176\128 \236\160\149\236\157\152\235\144\152\236\167\128 \236\149\138\236\149\152\236\138\181\235\139\136\235\139\164.", "\236\157\180\236\163\188")
    return
  end
  local reloadFunc = _reloadUIFunc[reloadEventType]
  reloadFunc()
end
