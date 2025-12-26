local UIGroup = Defines.UIGroup
local RenderMode = Defines.RenderMode
__Guild_LimitPrice = false
isRecordMode = false
isLuaLoadingComplete = false
local UIFontType = ToClient_getGameOptionControllerWrapper():getUIFontSizeType()
preloadUI_cahngeUIFontSize(UIFontType)
function loadLogoUI_PC()
  basicLoadUI("UI_Data/UI_Lobby/UI_Logo.xml", "Panel_Logo", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Panel_Logo.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
end
function loadLoginUI_PC()
  basicLoadUI("UI_Data/UI_Lobby/UI_TermsofGameUse.XML", "Panel_TermsofGameUse", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Window/Copyright/Panel_Window_Copyright.XML", "Panel_Copyright", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/Panel_Lobby_Login_All.xml", "Panel_Lobby_Login_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/UI_Lobby/UI_Login_Nickname_All.XML", "Panel_Login_Nickname_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/UI_Lobby/UI_Login_Password_All.XML", "Panel_Login_Password_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/HelpMessage/Panel_HelpMessage.xml", "Panel_HelpMessage", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  basicLoadUI("UI_Data/Widget/NakMessage/NakMessage.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  if isGameTypeCH() == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_Addiction_Prevention_All.XML", "Panel_Addiction_Prevention_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
    runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All.lua")
  end
  loadUI("UI_Data/Window/MessageBox/Panel_Window_Common_Description.XML", "Panel_Window_Common_Description", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_Common_Description.lua")
  runLua("UI_Data/Script/Panel_TermsofGameUse.lua")
  runLua("UI_Data/Script/Window/Copyright/Panel_Copyright.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_Login_All.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Login_Nickname_All.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Login_Password_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/HelpMessage/Panel_HelpMessage.lua")
  if true == _ContentsGroup_UsePadSnapping then
    loadPadSnapTargetEffect()
  end
  preLoadGameOptionUI()
  loadGameOptionUI()
end
function loadServerSelectUI_PC()
  basicLoadUI("UI_Data/UI_Lobby/UI_ServerSelect_All.xml", "Panel_Lobby_ServerSelect_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Popup/UI_Popup_Hadum_Warning.XML", "Panel_Popup_Hadum_Warning", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/UI_Lobby/Panel_Lobby_ChannelDesc_ForNewbie_All.xml", "Panel_Lobby_ChannelDesc_ForNewbie", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  if isGameTypeCH() == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_Addiction_Prevention_All.XML", "Panel_Addiction_Prevention_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
    runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All.lua")
  end
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_AsiaChampionship_Agreement_All.XML", "Panel_AsiaChampionship_Agreement_All", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Window/MessageBox/Panel_AsiaChampionship_Agreement_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_ServerSelect_All.lua")
  runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning.lua")
  runLua("UI_Data/Script/UI_Lobby/Panel_Lobby_ChannelDesc_ForNewbie_All.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  if true == _ContentsGroup_UsePadSnapping then
    loadPadSnapTargetEffect()
  end
end
function loadLoadingUI_PC()
  if ToClient_isActorAnimationLoadingFlag() == true then
    return
  end
  loadUI("UI_Data/UI_Loading/UI_Loading_Progress.xml", "Panel_Loading", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  runLua("UI_Data/Script/Panel_Loading.lua")
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_WarInfoMessage.XML", "Panel_WarInfoMessage", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_TerritoryWarKillingScore.XML", "Panel_TerritoryWarKillingScore", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/HouseInfo/Panel_WolrdHouseInfo.XML", "Panel_WolrdHouseInfo", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_InstanceField.lua")
  if isGameTypeCH() == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_Addiction_Prevention_All.XML", "Panel_Addiction_Prevention_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
    runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All.lua")
  end
end
function preloadCustomizationUI_PC()
  loadUI("UI_Data/Customization/UI_Customization_Common_Decoration.xml", "Panel_Customization_Common_Decoration", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Main.XML", "Panel_CustomizationMain", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Transform.xml", "Panel_CustomizationTransform", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_TransformHair.xml", "Panel_CustomizationTransformHair", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_TransformBody.xml", "Panel_CustomizationTransformBody", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_CustomizationTest.xml", "Panel_CustomizationTest", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Control.xml", "Panel_Customization_Control", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Mesh.xml", "Panel_CustomizationMesh", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Motion.xml", "Panel_CustomizationMotion", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Expression.xml", "Panel_CustomizationExpression", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Cloth.xml", "Panel_CustomizationCloth", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_PoseEditor.xml", "Panel_CustomizationPoseEdit", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Frame.xml", "Panel_CustomizationFrame", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Skin.xml", "Panel_CustomizationSkin", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Static.xml", "Panel_CustomizationStatic", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Voice.xml", "Panel_CustomizationVoice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_TextureMenu.xml", "Panel_CustomizationTextureMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_ImagePreset.xml", "Panel_CustomizationImage", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Customization/UI_Customization_Message.xml", "Panel_CustomizationMessage", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Window/FileExplorer/FileExplorer.XML", "Panel_FileExplorer", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Window/CustomizingAlbum/Panel_Window_CustomizingAlbum.xml", "Panel_CustomizingAlbum", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Widget/ScreenShotMode/Panel_Widget_ScreenShotFrame.xml", "Panel_Widget_ScreenShotFrame", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_customScreenShot,
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContentsGroup_RgbUIPick or true == _ContentsGroup_RgbUIPickForItem then
    loadUI("UI_Data/Window/ColorPalette/Panel_Window_ColorPalette.XML", "Panel_Window_ColorPalette_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_IngameCustomize
    }))
  end
end
function loadCustomizationUI_PC()
  if false == _ContentsGroup_IsNPCCustomizationable then
    runLua("UI_Data/Script/Customization/Customization_Common.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_HairShape.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Common_Decoration.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_UiFrame.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Mesh.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_FaceBone.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_BodyBone.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Skin.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Pose.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Palette.lua")
    runLua("UI_Data/Script/Customization/Panel_CharacterCreation_Main.lua")
    runLua("UI_Data/Script/Customization/Panel_Action_Expression.lua")
    runLua("UI_Data/Script/Customization/Panel_Action_Cloth.lua")
    runLua("UI_Data/Script/Customization/Panel_Action_Pose.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Voice.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_TextureMenu.lua")
    runLua("UI_Data/Script/Customization/Panel_Customization_Image.lua")
    runLua("UI_Data/Script/Customization/Customization_HistoryTable.lua")
  else
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Customization_Common.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_HairShape.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Common_Decoration.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_UiFrame.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Mesh.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_FaceBone.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_BodyBone.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Skin.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Pose.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Palette.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_CharacterCreation_Main.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Action_Expression.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Action_Cloth.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Action_Pose.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Voice.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_TextureMenu.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Panel_Customization_Image.lua")
    runLua("UI_Data/Script/Customization/NPCCustomizationable/Customization_HistoryTable.lua")
  end
  if true == _ContentsGroup_RgbUIPick or true == _ContentsGroup_RgbUIPickForItem then
    runLua("UI_Data/Script/Window/ColorPalette/Panel_Window_ColorPalette_All.lua")
  end
  runLua("UI_Data/Script/Window/FileExplorer/FileExplorer.lua")
  runLua("UI_Data/Script/Window/FileExplorer/FileExplorer_GuildInfo.lua")
  runLua("UI_Data/Script/Window/FileExplorer/FileExplorer_Customization.lua")
  runLua("UI_Data/Script/Customization/Panel_Customization_WebAlbum.lua")
  runLua("UI_Data/Script/Widget/CustomScreenShot/CustomScreenShot.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SpeechBubble.lua")
end
function loadLobbyUI_PC()
  basicLoadUI("UI_Data/UI_Lobby/UI_Startl.xml", "Panel_Start", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_CharacterSelect.xml", "Panel_CharacterSelect", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/Panel_Lobby_CharacterSelect_All.xml", "Panel_CharacterSelect_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_CharacterCreate_SelectClass.xml", "Panel_CharacterCreateSelectClass", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_CharacterSelectTestForShadow.xml", "Panel_CharacterCreateSelectClassTest", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_CharacterCreate.xml", "Panel_CharacterCreate", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    basicLoadUI("UI_Data/Window/Season/Panel_Window_SeasonBanner_CharacterCreate.xml", "Panel_Window_SeasonBanner", UIGroup.PAGameUIGroup_Alert)
  end
  basicLoadUI("UI_Data/Window/Season/Panel_Window_Season_Character_Create.XML", "Panel_Window_Season_Character_Create", UIGroup.PAGameUIGroup_Alert)
  if true == _ContentsGroup_SelectStartPosition then
    basicLoadUI("UI_Data/Window/Quest/Panel_Window_StartBranch.XML", "Panel_Window_StartBranch", UIGroup.PAGameUIGroup_ModalDialog)
  end
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/FirstLogin/Panel_FirstLogin.XML", "Panel_FirstLogin", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/NoticeAlert/NoticeAlert.XML", "Panel_NoticeAlert", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/Panel_IME.XML", "Panel_IME", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Widget/DataProgress/Panel_DataProgress.XML", "Panel_DataProgress", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/UI_Lobby/UI_GamerTag.XML", "Panel_GamerTag", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_GamerTag.lua")
  runLua("UI_Data/Script/Common/Common_UIMode.lua")
  preloadCustomizationUI_PC()
  loadCustomizationUI_PC()
  basicLoadUI("UI_Data/Widget/NakMessage/NakMessage.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog)
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_Main.lua")
  runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_CharacterSelect_All.lua")
  if true == _ContentsGroup_SeasonContents or true == _ContentsGroup_PreSeason then
    runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonBanner.lua")
  end
  runLua("UI_Data/Script/Window/Season/Panel_Window_Season_Character_Create.lua")
  if true == _ContentsGroup_SelectStartPosition then
    runLua("UI_Data/Script/Window/Quest/Panel_Window_StartBranch_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/globalKeyBinderNotPlay.lua")
  runLua("UI_Data/Script/Window/FirstLogin/Panel_FirstLogin.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/NoticeAlert.lua")
  runLua("UI_Data/Script/Panel_Ime.lua")
  runLua("UI_Data/Script/Widget/Lobby/Panel_Lobby_DataProgress.lua")
  basicLoadUI("UI_Data/Window/Mercenary/Panel_Window_RedDesert.XML", "Panel_Window_RedDesert", UIGroup.PAGameUIGroup_Windows)
  runLua("UI_Data/Script/Window/Mercenary/Panel_Window_RedDesert.lua")
  if isGameTypeCH() == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_Addiction_Prevention_All.XML", "Panel_Addiction_Prevention_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
    runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All.lua")
  end
  if true == _ContentsGroup_UsePadSnapping then
    loadPadSnapTargetEffect()
  end
  preLoadGameOptionUI()
  loadGameOptionUI()
end
function preLoadGameUI_PC()
  loadUI("UI_Data/Widget/UIcontrol/Panel_OnlyPerframeUsed.XML", "Panel_OnlyPerframeUsed", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/AbyssOne/Panel_Window_MagnusEasyTeleport_Effect.XML", "Panel_Window_MagnusEasyTeleport_Effect", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Widget/UIcontrol/Panel_CommonGameScreenUI.XML", "Panel_CommonGameScreenUI", UIGroup.PAGameUIGroup_MiniGameUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieTheater_MessageBox.XML", "Panel_MovieTheater_MessageBox", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Window/Movie/UI_IntroMovie.xml", "Panel_IntroMovie", UIGroup.PAGameUIGroup_IntroMovie)
  loadUI("UI_Data/Window/Movie/UI_DialogMovie.xml", "Panel_DialogMovie", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Video
  }))
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieTheater_320.XML", "Panel_MovieTheater_320", UIGroup.PAGameUIGroup_Movie)
  loadUI("UI_Data/Window/Movie/Panel_MovieTheater_640.XML", "Panel_MovieTheater_640", UIGroup.PAGameUIGroup_Movie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieTheater_LowLevel.XML", "Panel_MovieTheater_LowLevel", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieTheater_SkillGuide_640.XML", "Panel_MovieTheater_SkillGuide_640", UIGroup.PAGameUIGroup_Movie)
  loadUI("UI_Data/Window/Movie/Panel_MovieGuide_Weblist.XML", "Panel_MovieGuide_Weblist", UIGroup.PAGameUIGroup_Movie, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Movie/Panel_MovieGuide_Web.XML", "Panel_MovieGuide_Web", UIGroup.PAGameUIGroup_Movie, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Movie/Panel_MovieSkillGuide_Weblist.XML", "Panel_MovieSkillGuide_Weblist", UIGroup.PAGameUIGroup_Movie, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Movie/Panel_MovieSkillGuide_Web.XML", "Panel_MovieSkillGuide_Web", UIGroup.PAGameUIGroup_Movie, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Movie/Panel_MovieWorldMapGuide_Web.XML", "Panel_MovieWorldMapGuide_Web", UIGroup.PAGameUIGroup_Movie, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieStroyIndun.XML", "Panel_MovieStroyIndun", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Window/Panel_IME.XML", "Panel_IME", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/Mail/Panel_Mail_InputText.XML", "Panel_Mail_InputText", UIGroup.PAGameUIGroup_WorldMap_Popups)
  loadUI("UI_Data/Window/WebHelper/Panel_WebControl.XML", "Panel_WebControl", UIGroup.PAGameUIGroup_ModalDialog + 1, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Panel_WebCashPayment.XML", "Panel_WebCashPayment", UIGroup.PAGameUIGroup_ModalDialog + 1, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.XML", "Panel_Window_PearlBox_Purchase_All", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/UIcontrol/UI_SpecialCharacter.XML", "Panel_SpecialCharacter", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_KeyboardGuide.xml", "Panel_Widget_KeyboardGuide", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/HelpMessage/Panel_HelpMessage.xml", "Panel_HelpMessage", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/FirstLogin/Panel_FirstLogin.XML", "Panel_FirstLogin", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Damage/CounterAttack.XML", "Panel_CounterAttack", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/GlobalManual/Panel_Global_Manual.xml", "Panel_Global_Manual", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if true == _ContentsGroup_NewUI_Fishing_All then
    basicLoadUI("UI_Data/Widget/Fishing/Panel_Widget_Fishing_All.xml", "Panel_Widget_Fishing_All", UIGroup.PAGameUIGroup_MiniGameUpUI)
  else
    basicLoadUI("UI_Data/Widget/Fishing/Panel_Fishing.xml", "Panel_Fishing", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/Fishing/Panel_Widget_FishingEventIcon.xml", "Panel_Widget_FishingEventIcon", UIGroup.PAGameUIGroup_MiniGameUpUI)
  basicLoadUI("UI_Data/Window/GuildWarInfo/Panel_GuildWarInfo_All.XML", "Panel_GuildWarInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/GuildWarInfo/Panel_Window_GuildWarInfoSmall_All.XML", "Panel_GuildWarInfoSmall_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/GuildWarInfo/Panel_GuildWarScore_All.XML", "Panel_GuildWarScore_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/SiegeWar/Panel_SiegeWar_CastleInfo.XML", "Panel_SiegeWar_CastleInfo", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Guild/PersonalBattle/Panel_Window_PersonalBattle.XML", "Panel_Window_PersonalBattle", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Auction/Panel_House_Auction.xml", "Panel_Auction", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Auction/Panel_GuildHouse_Auction_All.XML", "Panel_GuildHouse_Auction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Auction/Panel_GuildHouse_Auction_Detail_All.XML", "Panel_GuildHouse_Auction_Detail_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Auction/Panel_GuildHouse_Auction_Bid_All.XML", "Panel_GuildHouse_Auction_Bid_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Auction/Panel_Villa_Auction.XML", "Panel_Villa_Auction", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Auction/Panel_Masterpiece_Auction_All.XML", "Panel_Masterpiece_Auction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Auction/Panel_Masterpiece_Auction_Bid_All.XML", "Panel_Masterpiece_Auction_Bid_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_All.xml", "Panel_CharacterInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Basic_All.xml", "Panel_CharacterInfoBasic_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Life_All.xml", "Panel_CharacterInfoLife_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Title_All.xml", "Panel_CharacterInfoTitle_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_History_All.xml", "Panel_CharacterInfoHistory_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_FootPrint_All.xml", "Panel_CharacterInfoFootPrint_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_Challenge_All.xml", "Panel_CharacterInfoChallenge_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_CashBuff_All.xml", "Panel_CharacterInfoCashBuff_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_BuffDetailBoard == true then
    basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_BuffDetail_All.xml", "Panel_CharacterInfo_BuffDetail", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/PotencialUp/UI_Potencial_Up_New.xml", "Panel_Potencial_Up", UIGroup.PAGameUIGroup_Chatting)
  basicLoadUI("UI_Data/Window/LifeRanking/Panel_LifeRanking_All.xml", "Panel_LifeRanking_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Recommand/Panel_Window_Recommand.xml", "Panel_RecommandName", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_StatNew_All.xml", "Panel_Window_StatNew_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_StatDetail_All.xml", "Panel_Window_StatDetail_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki.xml", "Panel_Window_ExpirienceWiki", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_ExpirienceWiki_All then
    if _ContentsGroup_WikiNoToURL then
      loadUI("UI_Data/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All.xml", "Panel_Window_ExpirienceWiki_All", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_WorldMap,
        RenderMode.eRenderMode_RoseWar,
        RenderMode.eRenderMode_RoseWarMenu,
        RenderMode.eRenderMode_Sequence,
        RenderMode.eRenderMode_SequencePlayerControl,
        RenderMode.eRenderMode_InGameCashShop
      }))
    else
      loadUI("UI_Data/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All.xml", "Panel_Window_ExpirienceWiki_All", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_WorldMap,
        RenderMode.eRenderMode_RoseWar,
        RenderMode.eRenderMode_RoseWarMenu,
        RenderMode.eRenderMode_Sequence,
        RenderMode.eRenderMode_SequencePlayerControl,
        RenderMode.eRenderMode_InGameCashShop
      }))
    end
  end
  if true == _ContentsGroup_CouponCode then
    basicLoadUI("UI_Data/Window/InWeb/Panel_Window_CouponCode.XML", "Panel_Window_CouponCode", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Atoraxion/Panel_Window_Atoraxion_Enter_All.XML", "Panel_Atoraxion_Enter", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/WeaponChange/Panel_Widget_WeaponChange.XML", "Panel_Atoraxion_WeaponChange", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/NakMessage/NakMessage_Atoraxxion_Clear.XML", "Panel_Atoraxion_NakClear", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/Region/Region_Atoraxxion.XML", "Panel_Atoraxion_RegionChange", UIGroup.PAGameUIGroup_SimpleTooltip)
  loadUI("UI_Data/Window/Atoraxion/Panel_Window_Atoraxion_Select_All.XML", "Panel_Atoraxion_Select", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Guide/Panel_Window_Guide_All.XML", "Panel_Window_Guide_All", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_AtoraxionSea then
    basicLoadUI("UI_Data/Window/Movie/UI_AtoraxionMovie.xml", "Panel_AtoraxionMovie", UIGroup.PAGameUIGroup_IntroMovie)
  end
  if true == _ContentsGroup_AtoraxionDesert then
    basicLoadUI("UI_Data/Window/Atoraxion/Panel_Widget_Atoraxion_Info.XML", "Panel_Window_AtoraxionInfo", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_InstanceHorseRacing then
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Match_Confirm.XML", "Panel_HorseRacing_Match_Confirm", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Match_All.XML", "Panel_HorseRacing_Match_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Enter.XML", "Panel_HorseRacing_Enter", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Waiting.XML", "Panel_HorseRacing_Waiting", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Time.XML", "Panel_HorseRacing_Time", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_CountDown_Start.XML", "Panel_HorseRacing_CountDown", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_CheckPoint.XML", "Panel_HorceRacing_CheckPoint", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_NakMSG_Waiting.XML", "Panel_HorceRacing_WaitingNak", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_NakMSG_Start.XML", "Panel_HorceRacing_StartNak", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_KeyGuide.XML", "Panel_HorseRacing_KeyGuide", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_HelpIcon.XML", "Panel_HorseRacing_HelpIcon", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Waiting2.XML", "Panel_HorseRacing_Waiting2", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_WaitingCheck.XML", "Panel_HorseRacing_WaitingCheck", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_InstanceFreeBatttleField then
    basicLoadUI("UI_Data/Window/InstanceField/Panel_PlayBattle_All.XML", "Panel_FreeBattleField_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_DragonPalace then
    basicLoadUI("UI_Data/Window/InstanceField/Panel_DragonPalace_Match_All.XML", "Panel_DragonPalace_Match_All", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_RedBattleFieldMatching == true then
    basicLoadUI("UI_Data/Window/LocalWar/Panel_LocalWarInfo_All.xml", "Panel_LocalWarInfo_All", UIGroup.PAGameUIGroup_Windows)
  elseif true == _ContentsGroup_InstanceLocalWar then
    basicLoadUI("UI_Data/Window/LocalWar/Panel_LocalWarInfo_All_New.xml", "Panel_LocalWarInfo_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_LocalWarPapuCrio then
    basicLoadUI("UI_Data/Window/LocalWar/Panel_LocalWarIntro_PapuCrio.xml", "Panel_LocalWarIntro_PapuCrio", UIGroup.PAGameUIGroup_GameMenu)
  end
  basicLoadUI("UI_Data/Window/CompetitionGame/Panel_CompetitionGame.XML", "Panel_CompetitionGame", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_All.XML", "Panel_Window_Solrare_Matching", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Solrare/Panel_Popup_Solare_MatchConfirm_All.XML", "Panel_Popup_Solare_MatchConfirm", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_SolareRank_All.XML", "Panel_Solrare_Ranking", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_OtherInfo.XML", "Panel_Solrare_OtherInfo", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Finding_Match_All.XML", "Panel_Window_Solare_Finding_Match", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Equip_Set_BlackBG.XML", "Panel_Solrare_EquipPresetBlockBg", UIGroup.PAGameUIGroup_WorldMap)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Equip_Set.XML", "Panel_Solrare_EquipPresetList", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Popup_Solare_CrystalConfirm_All.XML", "Panel_Popup_Solare_CrystalConfirm_All", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Popup_Solare_BuyEquipment_All.XML", "Panel_Popup_Solare_BuyEquipment_All", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Custom_All.XML", "Panel_Window_Solrare_CustomMatching", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Custom_Invite_All.XML", "Panel_Window_Solrare_CustomMatching_Invite", UIGroup.PAGameUIGroup_WorldMap_Popups)
  loadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_Hud.XML", "Panel_Widget_Solare_Hud", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_PlayerStatus.XML", "Panel_Widget_Solare_PlayerStatus", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_Countdown.XML", "Panel_Widget_Solare_Countdown", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Window/Solrare/Panel_Window_Solare_Match_Score_3on3_All.XML", "Panel_Window_Solrare_RoundNotice", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay,
    RenderMode.eRenderMode_InstanceContentsCeremony
  }))
  basicLoadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_WaitOther.XML", "Panel_Widget_Solare_WaitOther", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Window/Solrare/Panel_Widget_Solare_TierUpgrade.XML", "Panel_Widget_Solare_TierUpgrade", UIGroup.PAGameUIGroup_Interaction + 1)
  if _ContentsGroup_SolareReplay == true then
    basicLoadUI("UI_Data/Window/Solrare/Panel_Window_Solare_ReplayList.XML", "Panel_Window_Solrare_ReplayList", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Replay/Panel_Window_InstanceContentsReplayDownloadWeb.XML", "Panel_Window_InstanceContentsReplayDownloadWeb", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_Reservation_All.XML", "Panel_Window_Arsha_Reservation_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Widget_Arsha_Hud_All.XML", "Panel_Widget_Arsha_Hud_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_Func_All.XML", "Panel_Window_Arsha_Func_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaPvPSubMenu_All.XML", "Panel_Window_ArshaPvPSubMenu_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaInviteList_All.XML", "Panel_Window_Arsha_InviteList_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaTeamNameChange_All.XML", "Panel_Window_Arsha_TeamNameChange_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_Arsha_TeamChangeControl_All.XML", "Panel_Window_Arsha_TeamChangeControl_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Widget_Arsha_Party_All.XML", "Panel_Widget_Arsha_Party_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Arsha/NewUI/Panel_Window_ArshaSelectMember_All.XML", "Panel_Window_ArshaSelectMember_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Arsha/Panel_Window_Arsha_ApplyWeb_All.XML", "Panel_Arsha_ApplyWeb_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Arsha/NewUI/Panel_Widget_Arsha_Replay_All.XML", "Panel_Arsha_Replay_All", UIGroup.PAGameUIGroup_Production_Modify, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Window/Replay/Panel_Window_ReplayInMirrorField_All.XML", "Panel_Window_ReplayInMirrorField_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Replay
  }))
  if true == _ContentsGroup_ConsoleGetItemForPC then
    basicLoadUI("UI_Data/Widget/ItemLog/Panel_Widget_ItemLog_Renew.XML", "Panel_Widget_ItemLog_Renew", UIGroup.PAGameUIGroup_Widget)
  end
  if true == _ContentsGroup_BatchSummonMonsterByItem then
    loadUI("UI_Data/Widget/Party/Panel_Widget_Old_Ruins_Raid_All.XML", "Panel_BatchSummonMonster", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_NewUI_Looting then
    loadUI("UI_Data/Window/Looting/Panel_Window_Looting_All.XML", "Panel_Window_Looting_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  else
    basicLoadUI("UI_Data/Window/Looting/UI_Window_Looting.XML", "Panel_Looting", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_NewUI_Dye_All then
    loadUI("UI_Data/Window/Dye/Panel_Dye_Pallet_All.XML", "Panel_Window_Palette_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Default,
      Defines.RenderMode.eRenderMode_Dye
    }))
    loadUI("UI_Data/Window/Dye/Panel_Dye_CharacterController_All.XML", "Panel_Widget_CharacterController_All", UIGroup.PAGameUIGroup_Housing, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Dye
    }))
    loadUI("UI_Data/Window/Dye/Panel_Dye_Main_All.XML", "Panel_Widget_Dye_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Dye
    }))
    basicLoadUI("UI_Data/Window/Dye/Panel_Window_Dye_ColorBalance_All.XML", "Panel_Window_ColorMix_All", UIGroup.PAGameUIGroup_Window_Progress)
  else
    if _ContentsGroup_NewUI_Dye_Palette_All then
      loadUI("UI_Data/Window/Dye/Panel_DyePalette_All.XML", "Panel_Window_Dye_Palette_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        Defines.RenderMode.eRenderMode_Default,
        Defines.RenderMode.eRenderMode_Dye
      }))
    else
      loadUI("UI_Data/Window/Dye/Panel_DyePalette.XML", "Panel_DyePalette", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        Defines.RenderMode.eRenderMode_Default,
        Defines.RenderMode.eRenderMode_Dye
      }))
      basicLoadUI("UI_Data/Window/Dye/Panel_ColorBalance.XML", "Panel_ColorBalance", UIGroup.PAGameUIGroup_Window_Progress)
    end
    loadUI("UI_Data/Window/Dye/Panel_DyePreview.XML", "Panel_DyePreview", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Dye
    }))
    loadUI("UI_Data/Window/Dye/Panel_Dye_New.XML", "Panel_Dye_New", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Dye
    }))
    loadUI("UI_Data/Window/Dye/Panel_DyeNew_CharacterController.XML", "Panel_DyeNew_CharacterController", UIGroup.PAGameUIGroup_Housing, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Dye
    }))
    loadUI("UI_Data/Window/Dye/Panel_Dye_ReNew.XML", "Panel_Dye_ReNew", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      Defines.RenderMode.eRenderMode_Dye
    }))
  end
  basicLoadUI("UI_Data/Window/Inventory/Panel_Window_Inventory_AutoSortFunction.XML", "Panel_Window_Inventory_AutoSortFunction", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Inventory/Panel_Window_Inventory_All.xml", "Panel_Window_Inventory_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Window/Inventory/UI_Window_TrashBox_Popup_All.XML", "Panel_Window_TrashBoxConfirm_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_PearlBoxWebBuy == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_WebPurchaseConfirm_All.XML", "Panel_Window_WebPurchaseConfirm_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  if true == _ContentsGroup_FamilyInventory then
    loadUI("UI_Data/Window/Inventory/Panel_Window_FamilyInventory_All.xml", "Panel_Window_FamilyInventory_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  basicLoadUI("UI_Data/Window/Inventory/UI_Inventory_SkillCooltime_Effect_Item_Slot.XML", "Panel_Inventory_CoolTime_Effect_Item_Slot", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Popup/UI_Popup_Inventory.XML", "Panel_Popup_MoveItem", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/MessageBox/UI_Win_UseItem_All.xml", "Panel_UseItem_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm.xml", "Panel_ImperialSupply_Horse_Confirm", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if false == _ContentsGroup_NewUI_ClothInventory_All then
    basicLoadUI("UI_Data/Window/Inventory/UI_Window_ClothInventory.XML", "Panel_Window_ClothInventory", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Window/Inventory/Panel_Window_ClothInventory_All.XML", "Panel_Window_ClothInventory_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Inventory/Panel_Window_ClothInventory_Renew_All.XML", "Panel_Window_ClothInventory_Renew_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_StaticSlot == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_NewbieInventory_StaticSlot_All.xml", "Panel_Window_NewbieInventory_StaticSlot_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  else
    loadUI("UI_Data/Window/Inventory/Panel_Window_NewbieInventory_All.xml", "Panel_Window_NewbieInventory_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_OneButtonBuff == true then
    basicLoadUI("UI_Data/Window/AutoBuff/Panel_Window_AutoBuff.XML", "Panel_Window_AutoBuff", UIGroup.PAGameUIGroup_Window_Progress)
  end
  loadUI("UI_Data/Widget/Roadmap/Panel_Widget_RoadMap.XML", "Panel_Window_BeginnerRoadmap", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Tooltip_BlackspiritPass.XML", "Panel_Window_BlackspiritPassTooltip", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Tooltip_BlackSpiritPass_Quest.XML", "Panel_Widget_Tooltip_BlackSpiritPass_Quest", UIGroup.PAGameUIGroup_Siege, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Season_Graduation_All.XML", "Panel_Season_Graduation_All", UIGroup.PAGameUIGroup_Siege, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Season/Panel_Season_Graduation_MSG.XML", "Panel_Season_Graduation_MSG", UIGroup.PAGameUIGroup_WorldBossLooting, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_SeasonItem.XML", "Panel_Window_MessageBox_SeasonItem_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  if true == _ContentsGroup_NewUI_Equipment_All then
    loadUI("UI_Data/Window/Equipment/Panel_Window_Equipment_All.XML", "Panel_Window_Equipment_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/Equipment/UI_Window_Equipment.XML", "Panel_Equipment", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Equipment/Panel_Equipment_SetEffectTooltip.XML", "Panel_Equipment_SetEffect_Tooltip", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Equipment/Panel_Equipment_CrystalTooltip.XML", "Panel_Equipment_Crystal_Tooltip", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Equipment/Panel_Equipment_ArtifactsTooltip.XML", "Panel_Equipment_Artifacts_Tooltip", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    loadUI("UI_Data/Window/Equipment/Panel_Window_Season_Equiptment_Upgrade_All.XML", "Panel_Window_Season_Equiptment_Upgrade_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Equipment/Panel_Widget_GotoShop_Banner.XML", "Panel_Widget_GotoShop_Banner", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_AccessoryStepUp == true then
    loadUI("UI_Data/Window/Equipment/Panel_Window_Accessory_StepUp_All.XML", "Panel_Window_Accessory_StepUp_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/NakMessage/Panel_Widget_Nak_AccessoryStepUp_All.XML", "Panel_Widget_Nak_AccessoryStepUp_All", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  basicLoadUI("UI_Data/Window/ExtendExpiration/Panel_ExtendExpiration.XML", "Panel_ExtendExpiration", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Window/LordMenu/Panel_Window_LordMenu_All.XML", "Panel_Window_LordMenu_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/LordMenu/Panel_Lord_Controller.XML", "Panel_Lord_Controller", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/NodeWarMenu/Panel_NodeWarMenu_Main.XML", "Panel_NodeWarMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/RightTopIcons/Panel_Window_Warcall_Castle.XML", "Panel_Window_Warcall_Castle", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    if _ContentsGroup_skillOldandNew then
      loadUI("UI_Data/Window/Skill/UI_Window_Skill_New.xml", "Panel_Window_Skill", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
    else
      loadUI("UI_Data/Window/Skill/UI_Window_Skill.xml", "Panel_Window_Skill", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
    end
    loadUI("UI_Data/Window/Skill/UI_Window_SkillCombination.XML", "Panel_SkillCombination", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_EnableSkill.XML", "Panel_EnableSkill", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_CoolTimeSlot.XML", "Panel_SkillCoolTimeSlot", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_ShowCharacter_All.xml", "Panel_Window_SkillGroup_Controller", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_SkillQuickSlot_All.xml", "Panel_Window_SkillGroup_QuickSlot", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Skill_Play_SelectType_All.xml", "Panel_Window_SkillGroup_SelectType", UIGroup.PAGameUIGroup_AlertPost, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_CoolTimeSlot_All.xml", "Panel_SkillGroup_CoolTimeSlot", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    if _ContentsGroup_ShowOtherClassSkill == true then
      loadUI("UI_Data/Window/Skill/Panel_Window_SkillGroup_All.xml", "Panel_Window_SkillGroup_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/Skill/Panel_Window_Skill_ShowAllClasses_All.xml", "Panel_Window_Skill_ShowAllClasses_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
    else
      loadUI("UI_Data/Window/Skill/Panel_Skill_Play_Main_All.xml", "Panel_Window_SkillGroup", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
    end
  end
  if true == _ContentsGroup_SkillFilter then
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_Filter_All.xml", "Panel_Window_SkillFilter_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_SkillPreset then
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_PresetSave_All.XML", "Panel_Window_SkillPreset", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_Skil_PresetMemo_All.XML", "Panel_Window_SkillPresetMemo", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == GlobalSwitch_UseDummyPlayerSkillWindow then
    loadUI("UI_Data/Window/Skill/Panel_Test_SkillView_Control.XML", "Panel_Test_SkillView_Control", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/SkillAwaken/UI_Frame_SkillAwaken_Options.xml", "Panel_Frame_AwkOptions", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/SkillAwaken/UI_Frame_SkillAwaken_List.xml", "Panel_Frame_AwkSkillList", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Skill/UI_Window_SkillGuide.xml", "Panel_Window_SkillGuide", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/SkillAwaken/UI_Window_SkillAwaken.xml", "Panel_SkillAwaken", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/SkillAwaken/Panel_SkillAwaken_ResultOption.xml", "Panel_SkillAwaken_ResultOption", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    loadUI("UI_Data/Window/Skill/UI_Window_ReinforceSkill_All.xml", "Panel_Window_ReinforceSkill_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Skill/UI_Window_SkillReinforce_All.xml", "Panel_SkillReinforce_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow
    }))
  else
    loadUI("UI_Data/Window/Skill/UI_Window_ReinforceSkill.xml", "Panel_Window_ReinforceSkill", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/UI_Window_SkillReinforce.xml", "Panel_SkillReinforce", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All.xml", "Panel_Window_BlackSpiritSkillLock_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_BlackSpiritLock.xml", "Panel_Window_Skill_BlackSpiritLock", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/DailyStamp/Panel_Window_DailyStamp_All.XML", "Panel_Window_DailyStamp_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/DailyStamp/Panel_Daily_Reward_Notice_All.XML", "Panel_Daily_Reward_Notice_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_BlackSpiritAdventure.XML", "Panel_Window_BlackSpiritAdventure", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_BlackSpiritAdventure_PCRoom.XML", "Panel_Window_BlackSpiritAdventureVerPC", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Quest/Panel_Window_AbyssOne_Help.XML", "Panel_AbyssOne_Help", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_EventMarbleGame.XML", "Panel_Window_EventMarbleGame", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Copyright/Panel_Window_Copyright.XML", "Panel_Copyright", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Policy/Panel_Window_Policy.XML", "Panel_Window_Policy", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Twitch/Panel_Twitch.XML", "Panel_Twitch", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/SaveSetting/Panel_SaveSetting.XML", "Panel_SaveSetting", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContentsGroup_NewUI_QuestOption_All then
    basicLoadUI("UI_Data/Window/Quest/UI_Window_Quest_Option_All.XML", "Panel_Window_Quest_Option_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/Quest/UI_Window_Quest_Option.XML", "Panel_Window_Quest_New_Option", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Quest/UI_Window_QuestInfo_ALL.XML", "Panel_Window_QuestInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  if _ContentsGroup_QuestSearch == true then
    basicLoadUI("UI_Data/Window/Quest/UI_Window_Quest_ALL.xml", "Panel_Window_Quest_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/Quest/Console/UI_Window_Quest_ALL_Old.xml", "Panel_Window_Quest_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_FeverQuest and true == _ContentsGroup_WorldmapFeverQuest then
    loadUI("UI_Data/Window/Quest/UI_Widget_RandonQuestInfo_All.XML", "Panel_Widget_RandomQuestInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  basicLoadUI("UI_Data/Window/MessageBox/Panel_MessageBoxElvia.XML", "Panel_Window_MessageBoxElvia_All", UIGroup.PAGameUIGroup_FadeScreen)
  basicLoadUI("UI_Data/Widget/Popup/UI_Popup_Hadum_Warning_Quest.XML", "Panel_Popup_Hadum_Warning_Quest", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/BuyDrink/Panel_BuyDrink.XML", "Panel_BuyDrink", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_NPCShop_All.xml", "Panel_Dialog_NPCShop_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WorkerHire/Panel_Window_WorkerRandomSelect_All.XML", "Panel_Window_WorkerRandomSelect_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WorkerHire/Panel_Window_WorkerRandomSelectOption_All.XML", "Panel_Window_WorkerRandomSelectOption_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WorkerHire/Panel_Window_WorkerRandomSelectOption_Grade_All.XML", "Panel_Window_WorkerRandomSelectOption_Grade_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/RandomShop/Panel_Window_RandomShop_All.XML", "Panel_Window_RandomShop_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_StackExtraction_All.XML", "Panel_Window_StackExtraction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_OtherUser_AdditionalRate_All.XML", "Panel_OtherUser_AdditionalRate_All", UIGroup.PAGameUIGroup_MarniWave, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/Panel_Window_EnchantStackConfirm_All.XML", "Panel_Window_EnchantStackConfirm_All", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemBox/Panel_Window_MessageBox_Edit_All.XML", "Panel_Window_MessageBox_Edit_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_SpiritGroupEnchant then
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member1_All.XML", "Panel_Widget_PartyEnchant_Member1_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member2_All.XML", "Panel_Widget_PartyEnchant_Member2_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member3_All.XML", "Panel_Widget_PartyEnchant_Member3_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_Member4_All.XML", "Panel_Widget_PartyEnchant_Member4_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Widget_PartyEnchant_BubbleText_All.XML", "Panel_Widget_PartyEnchant_BubbleText_All", UIGroup.PAGameUIGroup_GameMenu + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_EnchantRemaster then
    loadUI("UI_Data/Window/Enchant/Panel_Widget_Enchant_Main_All.XML", "Panel_Widget_Enchant_Main_All", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_Equip_All.XML", "Panel_Window_Enchant_Equip_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_Material_Select_All.XML", "Panel_Window_Enchant_Material_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_ProtectDecrease_All.XML", "Panel_Window_EnchantProtector_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_DarkStack_All.XML", "Panel_Window_EnchantStack_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_Enchant_StackExtraction_All.XML", "Panel_Window_Enchant_StackExtraction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_EnchantMessage_All.XML", "Panel_Window_EnchantMessage_All", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Inventory/Panel_Window_EnchantInventory_All.XML", "Panel_Window_EnchantInventory_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Enchant_Console_KeyGuide_All.XML", "Panel_Enchant_Console_KeyGuide", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_ValksList_All.XML", "Panel_Window_ValksList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_EnchantRenewer then
    loadUI("UI_Data/Window/Enchant/Panel_Window_AddStack_All.XML", "Panel_Window_AddStack_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/MarketPlace/Panel_Window_OTPConfirm_All.XML", "Panel_Window_OTPConfirm_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_FamilyStack then
    loadUI("UI_Data/Window/Enchant/Panel_Widget_StackStorage_All.XML", "Panel_Widget_StackStorage_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Enchant/Panel_Window_BeginnerEnchantGuide_All.XML", "Panel_Window_BeginnerEnchantGuide_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Enchant/UI_Window_Improvement_All.XML", "Panel_Window_Improvement_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Socket/UI_Win_Enchant_Socket_All.XML", "Panel_Window_Socket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Enchant/UI_Window_BonusEnchant.XML", "Panel_BonusEnchant", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Housing/Panel_HousingList.XML", "Panel_HousingList", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_HarvestList_All then
    basicLoadUI("UI_Data/Widget/Housing/Panel_HarvestList_All.XML", "Panel_HarvestList_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Widget/Housing/Panel_HarvestList.XML", "Panel_HarvestList", UIGroup.PAGameUIGroup_Windows)
  end
  if false == _ContentsGroup_PanelReload_Develop then
    basicLoadUI("UI_Data/Window/Servant/UI_HorseMp.XML", "Panel_HorseMp", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Servant/UI_HorseHp.XML", "Panel_HorseHp", UIGroup.PAGameUIGroup_Widget)
  end
  basicLoadUI("UI_Data/Window/Servant/Panel_Widget_ServantSummonBoss.XML", "Panel_Widget_ServantSummonBoss", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/Panel_Window_VehicleInfo_All.xml", "Panel_Window_VehicleInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_Window_LinkedSkill_All.XML", "Panel_Window_LinkedSkill_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/UI_ShipInfo.xml", "Panel_ShipInfo", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/UI_WorkerShipInfo.xml", "Panel_WorkerShipInfo", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_Window_GuildServantList_All.XML", "Panel_GuildStableList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_GuildeServant_RevivalList.xml", "Panel_GuildServant_RevivalList", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_OceanCurrent then
    basicLoadUI("UI_Data/Window/Servant/UI_ShipSpeedGauge_ALL.XML", "Panel_Widget_ShipSpeedGauge", UIGroup.PAGameUIGroup_ScreenEffect)
  end
  basicLoadUI("UI_Data/Window/Servant/UI_TopIcon_Servant.XML", "Panel_Window_Servant", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/HouseInfo/Panel_MyHouseNavi.XML", "Panel_MyHouseNavi", UIGroup.PAGameUIGroup_MainUI)
  if true == _ContentsGroup_RemasterUI_Main then
    basicLoadUI("UI_Data/Widget/ServantIcon/Panel_Widget_ServantIcon.XML", "Panel_Widget_ServantIcon", UIGroup.PAGameUIGroup_Widget)
  end
  basicLoadUI("UI_Data/Window/Servant/UI_Cannon.XML", "Panel_Cannon", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Servant/UI_CannonShip.XML", "Panel_CannonShip", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Window/WareHouse/Panel_Window_WareHouse_All.XML", "Panel_Window_Warehouse", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Inventory/Panel_Window_TotalSearch.XML", "Panel_Window_TotalSearch", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Window/ExplorePointUsingInfo/Panel_Window_ExplorePoint_UsingInfo.XML", "Panel_Window_ExplorePoint_UsingInfo", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if true == _ContentsGroup_CargoSell then
    loadUI("UI_Data/Window/Servant/Panel_Window_Cargo_Sell.XML", "Panel_Window_CargoSell", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/WareHouse/Panel_Window_GuildWareHouse_UseLog_All.XML", "Panel_Window_GuildWareHouseHistory", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Guild/Panel_Window_Guild_QuestInfo.XML", "Panel_GuildQuestInfo_All", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/WareHouse/Panel_Window_WareHouse_UseLog_All.XML", "Panel_Window_WareHouseHistory", UIGroup.PAGameUIGroup_WorldMap_Contents + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Delivery/Panel_Window_Delivery_All.XML", "Panel_Window_Delivery_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Delivery/UI_Window_Delivery_InformationView.XML", "Panel_Window_Delivery_InformationView", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Delivery/UI_Window_Carriage_Information.XML", "Panel_Window_Delivery_CarriageInformation", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  if _ContentsGroup_Crogdalo == true then
    loadUI("UI_Data/Widget/ServantIcon/Panel_Servant_FantasyStable.XML", "Panel_Window_CrogdaloStable", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantFunction_All.XML", "Panel_Dialog_ServantFunction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantInfo_All.XML", "Panel_Dialog_ServantInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantList_All.XML", "Panel_Dialog_ServantList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantLookChange_All.XML", "Panel_Dialog_ServantLookChange_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_Servant_PremiumLookChange.XML", "Panel_Dialog_Servant_PremiumLookChange", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantRegist_All.XML", "Panel_Dialog_ServantRegist_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All.XML", "Panel_Dialog_ServantTransferList_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExchange_All.XML", "Panel_Dialog_ServantExchange_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantMarket_All.XML", "Panel_Dialog_ServantMarket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantNameRegist_All.XML", "Panel_Dialog_ServantNameRegist_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExchange_Fantasy_All.XML", "Panel_Dialog_ServantExchange_Fantasy_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Window_SimpleStableList_All.XML", "Panel_Window_SimpleStableList_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_FantasyHorse == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySkin_All.XML", "Panel_Dialog_ServantFantasySkin", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Widget_Servant_FantasySkin_Complete_All.XML", "Panel_Widget_Servant_FantasySkin_Complete_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_ServantLevelUpRenewal == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantLvUpMessageBox_All.XML", "Panel_Dialog_ServantLvUpMessageBox_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantRental_All.XML", "Panel_Dialog_ServantMarket_Rental_Mating_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantCarriageLink_All.XML", "Panel_Dialog_ServantCarriageLink_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSkillManagement_All.XML", "Panel_Dialog_ServantSkillManagement_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Window_ServantRateDesc.XML", "Panel_Window_ServantRateDesc", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSwiftTraining_All.XML", "Panel_Dialog_ServantSwiftTraining_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSwiftResult_All.XML", "Panel_Dialog_ServantSwiftResult_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All.XML", "Panel_Dialog_ServantOnlyList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySelect_All.XML", "Panel_Dialog_Servant_FantasySelect_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_HorseSimulator == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSimulator.XML", "Panel_Dialog_ServantSimulator", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantSimulatorSubView.XML", "Panel_Dialog_ServantSimulatorSubView", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_LifeSimulator == true then
    loadUI("UI_Data/Window/Alchemy/Panel_Alchemy_RateViewList_All.XML", "Panel_Alchemy_RateViewList", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_ServantLevelDown == true then
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_HorseLevelDecrease_All.XML", "Panel_Dialog_HorseLevelDecrease_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/FindUser/Panel_Window_FindUser.XML", "Panel_Window_DetectUser", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetRegister_All.XML", "Panel_Window_PetRegister_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetListNew_All.XML", "Panel_Window_PetList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetInfo_All.XML", "Panel_Window_PetInfo_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetLookChange_All.XML", "Panel_Window_PetLookChange_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetComposeNew_All.XML", "Panel_Window_PetFusion_All", UIGroup.PAGameUIGroup_InstanceMission)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetControl_All.XML", "Panel_Widget_PetControl_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_GroupEdit_All.XML", "Panel_Window_GroupEdit_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetSkillChange_All.XML", "Panel_Window_PetSkillChange_All", UIGroup.PAGameUIGroup_Window_Progress_Child)
  if true == _ContentsGroup_PetSkillPercent then
    basicLoadUI("UI_Data/Window/PetInfo/Panel_Window_PetSkill_Percent_All.XML", "Panel_Window_PetSkill_Percent_All", UIGroup.PAGameUIGroup_HouseInfo)
  end
  if true == _ContentsGroup_isFairy then
    if true == _ContentsGroup_NewUI_Fairy_All then
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyRegister_ALL.XML", "Panel_Window_FairyRegister_All", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyChoiseTheReset_ALL.XML", "Panel_Window_FairyChoiceTheReset_All", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySetting_ALL.XML", "Panel_Window_FairySetting_All", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyGrowth_ALL.XML", "Panel_Window_FairyGrowth_All", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Fairyinfo_ALL.XML", "Panel_FairyInfo_All", UIGroup.PAGameUIGroup_Windows)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkill_ALL.XML", "Panel_Window_FairySkill_All", UIGroup.PAGameUIGroup_Window_Progress)
      if _ContentsGroup_FairyTierUpgradeAndRebirth then
        basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyTierUpgrade_ALL.XML", "Panel_Window_FairyTierUpgrade_All", UIGroup.PAGameUIGroup_Window_Progress)
      end
      if _ContentsGroup_FairyChangeSkill then
        basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyChangeSkill_All.XML", "Panel_Window_FairyChangeSkill_All", UIGroup.PAGameUIGroup_Window_Progress)
        basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkillChange_Viewhelp_ALL.XML", "Panel_FairySkillChange_Viewhelp", UIGroup.PAGameUIGroup_Window_Progress)
      end
    else
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyRegister.XML", "Panel_Window_FairyRegister", UIGroup.PAGameUIGroup_Windows)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySetting.XML", "Panel_Window_FairySetting", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyUpgrade.XML", "Panel_Window_FairyUpgrade", UIGroup.PAGameUIGroup_Window_Progress)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Fairyinfo.XML", "Panel_FairyInfo", UIGroup.PAGameUIGroup_Windows)
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyChoiseTheReset.XML", "Panel_Window_FairyChoiseTheReset", UIGroup.PAGameUIGroup_Window_Progress)
      if _ContentsGroup_FairyTierUpgradeAndRebirth then
        basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyTierUpgrade.XML", "Panel_Window_FairyTierUpgrade", UIGroup.PAGameUIGroup_Window_Progress)
      end
      basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkill.XML", "Panel_Window_FaIryTierUpgrade", UIGroup.PAGameUIGroup_Window_Progress)
    end
  end
  basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyIcon.XML", "Panel_Window_FairyIcon", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairySkinChange_All.XML", "Panel_Window_FairySkinChange_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidList_All.XML", "Panel_Window_MaidList_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_MaidActorSystem == true then
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidActorList_All.XML", "Panel_Window_MaidActorList_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidActorRegist_All.XML", "Panel_Window_MaidActorRegist_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_MaidActorChangeCloth_All.XML", "Panel_Window_MaidActorChangeCloth_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Maid/Panel_Window_ChangeMaidActorName_All.XML", "Panel_Window_ChangeMaidActorName_All", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_FishingEncyclopedia == true then
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All_New.XML", "Panel_Window_FishEncyclopedia_Renewal_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Window_MiniGame_FishSize_Update.XML", "Panel_Window_EncyclopediaNotice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  else
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All.XML", "Panel_Window_FishEncyclopedia_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if _ContentsGroup_FishCompetition == true then
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEvent_All.XML", "Panel_Window_FishCompetition", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEventMyReward_All.XML", "Panel_Window_FishCompetitionMyReward", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/Worldmap/FishEncyclopedia/Panel_Window_FishEventReward_All.XML", "Panel_Window_FishCompetitionRewardInfo", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if true == _ContentsGroup_NewUI_Camp_All then
    basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp_All.XML", "Panel_Window_Camp_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp_Warehouse_All.XML", "Panel_Window_CampWarehouse_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp_VillaBuff_All.xml", "Panel_Window_BuildingBuff_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Widget/Camp/Panel_Window_Camp.XML", "Panel_Window_Camp", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/BuildingBuff/Panel_Window_BuildingBuff.xml", "Panel_Window_BuildingBuff", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Camp/Panel_Icon_Camp.XML", "Panel_Icon_Camp", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/Camp/Panel_Window_CampRegister.XML", "Panel_Window_CampRegister", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Duel/Panel_Icon_Duel.XML", "Panel_Icon_Duel", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Exchange/UI_Window_Exchange.XML", "Panel_Window_Exchange", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Exchange/Panel_Window_ExchangeNumber_All.XML", "Panel_Window_NumberPad_All", UIGroup.PAGameUIGroup_SimpleTooltip + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_RoseWar,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_IngameCustomize,
    RenderMode.eRenderMode_Dye
  }))
  if _ContentsGroup_ExchangeCoinSystem == true then
    loadUI("UI_Data/Window/Exchange/Panel_ExchangeCoin_All.XML", "Panel_ExchangeCoin_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if true == _ContentsGroup_OceanCurrent then
    loadUI("UI_Data/Window/Servant/Panel_Window_ShipEquipManagement_ALL.XML", "Panel_Window_ShipEquipManagement_ALL", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter.XML", "Panel_Window_Barter", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter_Search.XML", "Panel_Window_Barter_Search", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter_Refresh_All.XML", "Panel_Window_Barter_Refresh", UIGroup.PAGameUIGroup_Window_Progress + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Exchange/Panel_Window_Barter_Search_SpecialInfo.XML", "Panel_Window_Barter_Search_Special", UIGroup.PAGameUIGroup_Window_Progress + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Widget/GreatSea/Panel_Widget_Anchorage_ALL.XML", "Panel_Widget_Anchorage", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Servant/Panel_Widget_OceanWind.XML", "Panel_Widget_OceanWind", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Servant/Panel_Widget_OceanCurrent.XML", "Panel_Widget_OceanCurrent", UIGroup.PAGameUIGroup_Widget)
    loadUI("UI_Data/Window/Sailor/Panel_Window_Sailor_Onboard_All.XML", "Panel_Window_Sailor_Onboard_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Sailor/Panel_Window_SailorManager_All.XML", "Panel_Window_SailorManager_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Sailor/Panel_Window_SailorRestore_All.XML", "Panel_Window_SailorRestore_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_NeedForHire_Item_All.xml", "Panel_Widget_EmployeeHireItem_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_BlackSpirit
    }))
    loadUI("UI_Data/Window/Servant/Panel_Window_ShipInfo_ALL.XML", "Panel_Window_ShipInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Servant/Panel_Window_CargoLoading_ALL.XML", "Panel_Window_CargoLoading_ALL", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Widget/Research/Panel_Widget_Research_ProgressBar.XML", "Panel_Widget_GreatSeaEvent_ProgressBar", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Widget/Research/Panel_Widget_Research_Resurt.XML", "Panel_Widget_GreatSeaEvent", UIGroup.PAGameUIGroup_Widget)
    loadUI("UI_Data/Widget/Research/Panel_Widget_seafaringResearch_Resurt.XML", "Panel_Widget_SeafaringResearch", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExtension_All.XML", "Panel_Window_ServantUpgrade", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExtension_All_Tree.XML", "Panel_Dialog_ServantExtension_All_Tree", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/NewUI/Panel_Dialog_ServantExtension_Additional_All.XML", "Panel_Window_ServantUpgradeInfo", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Servant/Panel_Widget_ShipCannon_Left.XML", "Panel_Widget_ShipCannon_Left", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Servant/Panel_Widget_ShipCannon_Right.XML", "Panel_Widget_ShipCannon_Right", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Servant/Panel_Widget_SailControl.XML", "Panel_Widget_SailControl", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Common/Panel_Window_ItemFilter_All.XML", "Panel_Window_ItemFilter_All", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    if _ContentsGroup_ImprovedGalleyShip == true then
      basicLoadUI("UI_Data/Window/Servant/Panel_Widget_GalleyBoost.XML", "Panel_Widget_GalleyBoost", UIGroup.PAGameUIGroup_Widget)
      basicLoadUI("UI_Data/Window/Servant/Panel_Widget_GalleyMember.XML", "Panel_Widget_GalleyMember", UIGroup.PAGameUIGroup_Widget)
    end
    if _ContentsGroup_EmployeePresetJob == true then
      loadUI("UI_Data/Window/Sailor/Panel_Window_SailorPresetManager_All.XML", "Panel_Window_SailorPresetManager_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/Sailor/Panel_Window_SailorManager_GroupPreset_All.XML", "Panel_Window_SailorPresetGroup_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/Servant/Panel_Window_ShipInfo_Renewal_ALL.XML", "Panel_Window_ShipInfo_Renewal_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
      loadUI("UI_Data/Window/Sailor/Panel_Window_SailorPreset_NameEdit_All.XML", "Panel_Window_SailorPreset_NameEdit_All", UIGroup.PAGameUIGroup_Window_Progress_Child, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      if _ContentsGroup_EmployeeAutoFishingDiscard == true then
        loadUI("UI_Data/Window/Servant/Panel_Widget_Sailor_AutoFishingDiscard.XML", "Panel_Widget_Sailor_AutoFishingDiscard", UIGroup.PAGameUIGroup_ScreenEffect, PAUIRenderModeBitSet({
          RenderMode.eRenderMode_Default
        }))
      end
    end
  end
  loadUI("UI_Data/Window/FadeScreen/UI_Fade_Screen.XML", "Panel_Fade_Screen", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Window/FadeScreen/Panel_FullScreenFade.XML", "Panel_FullScreenFade", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContetnsGroup_ChangeLoadingImg then
    basicLoadUI("UI_Data/Window/FadeScreen/Common_FadeOut_BG.XML", "Common_FadeOut", UIGroup.PAGameUIGroup_FadeScreen)
  else
    basicLoadUI("UI_Data/Window/FadeScreen/Common_FadeOut.XML", "Common_FadeOut", UIGroup.PAGameUIGroup_FadeScreen)
  end
  basicLoadUI("UI_Data/Window/Mail/Panel_Window_Mail_All.xml", "Panel_Window_Mail_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Mail/Panel_Window_MailDetail_All.xml", "Panel_Window_MailDetail_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Worldmap/Panel_HouseIcon.XML", "Panel_HouseIcon", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_town_manageWorker.XML", "Panel_manageWorker", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_Working_Progress.XML", "Panel_Working_Progress", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  if _ContentsGroup_HarvestList_All then
    loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_TentInfo_All.XML", "Panel_Worldmap_TentInfo_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  else
    loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_TentInfo.XML", "Panel_Worldmap_TentInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_TradeNpcItemInfo.XML", "Panel_TradeNpcItemInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_OutSideNode.XML", "Panel_WorldMap_Main", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Loading
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_MainCitadelSelect.XML", "Panel_Worldmap_MainCitadelSelect", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_NodeName.XML", "Panel_NodeName", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_InSideNode_Guild.XML", "Panel_NodeOwnerInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_InSideNode.XML", "Panel_NodeMenu", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_nodeHouseFilter.XML", "Panel_NodeHouseFilter", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_Finance.XML", "Panel_Finance_WorkManager", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_House.XML", "Panel_RentHouse_WorkManager", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_House_SelectBox.XML", "Panel_Select_Inherit", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_LargeCraft.XML", "Panel_LargeCraft_WorkManager", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_Building.XML", "Panel_Building_WorkManager", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_Plant.XML", "Panel_Plant_WorkManager", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_manageWork_Harvest.XML", "Panel_Harvest_WorkManager", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_MovieTooltip.XML", "Panel_WorldMap_MovieGuide", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_WarInfo.XML", "Panel_Win_Worldmap_WarInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_NodeWarInfo.XML", "Panel_Win_Worldmap_NodeWarInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Widget/WarInfoMessage/Panel_WarInfoMessage.XML", "Panel_WarInfoMessage", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Widget/WarInfoMessage/Panel_TerritoryWarKillingScore.XML", "Panel_TerritoryWarKillingScore", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/HouseInfo/Panel_WolrdHouseInfo.XML", "Panel_WolrdHouseInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_Territory.XML", "Panel_Worldmap_Territory", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_NodeStable.XML", "Panel_NodeStable", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_New_Worldmap_NodeStableInfo.XML", "Panel_NodeStableInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/UI_Worldmap_QuestInfo.XML", "Panel_QuestInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_NavigationButton.XML", "Panel_NaviButton", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_ResultDetectUser.XML", "Panel_DetectUserButton", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  if _ContentsGroup_WorldMapKnowledgeIcon == true then
    loadUI("UI_Data/Window/Worldmap_Grand/Panel_Window_Worldmap_KnowledgeList_All.XML", "Panel_Worldmap_KnowledgeList", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/Worldmap/UI_New_WorldMap_Tooltip.XML", "Panel_WorldMap_Tooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/WorldMap/UI_New_Worldmap_PartyMemberTail.XML", "Panel_WorldMap_PartyMemberTail", UIGroup.PAGameUIGroup_Party, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/WorldMap/UI_New_Worldmap_PartyMemberIcon.XML", "Panel_WorldMap_PartyMemberIcon", UIGroup.PAGameUIGroup_Party, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_NodeTooltip_All.XML", "Panel_WorldMap_NodeTooltip", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  if true == _ContentsGroup_OceanCurrent then
    loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_BarterInfo.XML", "Panel_Worldmap_BarterInfo", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_WORLDMAP())
  end
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_WaypointPreset.XML", "Panel_Worldmap_WaypointPreset", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_WaypointTypeOption.XML", "Panel_Worldmap_WaypointOption", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  if true == _ContentsGroup_WorldMapNodeNavigation then
    loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_NodeCal.XML", "Panel_Worldmap_NodeCal", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  end
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_NodeLevel.XML", "Panel_Worldmap_NodeLevel", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Exchange/Panel_Window_UseCharacterWp_all.XML", "Panel_Window_UseCharacterWp_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_FamilyCharacter_Pin_All.XML", "Panel_Worldmap_FamilyCharacter_Pin_All", UIGroup.PAGameUIGroup_Party, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_FamilyCharacter_List_All.XML", "Panel_Worldmap_FamilyCharacter_List_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/ChangeName/Panel_Window_ChangeCharacterMemo_All.XML", "Panel_Window_FamilyCharacterChangeMemo_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_WORLDMAP())
  basicLoadUI("UI_Data/Widget/Alert/Panel_Alert_Message.XML", "Panel_Alert_Message", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_BookMark_Name_All.XML", "Panel_WorldMap_BookMark", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Panel_WorldMap_StableList.XML", "Panel_WorldMap_StableList", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap/Panel_Worldmap_NodeTooltip_VillageWar_All.XML", "Panel_Worldmap_NodeTooltip_VillageWar_All", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft.XML", "Worldmap_Grand_GuildCraft", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildHouseControl.XML", "Worldmap_Grand_GuildHouseControl", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft_ChangeWorker.XML", "Worldmap_Grand_GuildCraft_ChangeWorker", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Worldmap_Grand/Worldmap_Guildwar_Position_List.XML", "Worldmap_Grand_Guildwar_ColorList", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ClanList_All.XML", "Panel_Window_ClanList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Cover_All.XML", "Panel_GuildMain_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Main_All.XML", "Panel_GuildInfo_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Warfare_All.XML", "Panel_GuildWarfare_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_WarfareNew_All.XML", "Panel_GuildWarfareNew_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_History_All.XML", "Panel_Guild_History_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_BossSummon_All.XML", "Panel_Guild_BossSummon_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_GoToWar_All.XML", "Panel_GuildDeclareWar_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Introduce_All.XML", "Panel_GuildIntroduce_All", UIGroup.PAGameUIGroup_Window_Progress)
  if _ContentsGroup_GuildQuestAndSkillImprove == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_QuestList_All.XML", "Panel_GuildQuestList_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Quest_All.XML", "Panel_GuildQuest_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Manufacture_All.XML", "Panel_Guild_Manufacture_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ManufactureInfo_All.XML", "Panel_Guild_ManufactureSelect_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_AllianceMain_All.XML", "Panel_GuildAlliance_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_AllianceInvite_All.XML", "Panel_GuildAllianceInvite_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_AlianceList_All.XML", "Panel_GuildAllianceList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Skill_All.XML", "Panel_GuildSkill_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MemberList_All.XML", "Panel_GuildMemeberList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildMatch_All.XML", "Panel_GuildMatch_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_GuildMatch == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildMatchScore_All.XML", "Panel_Window_GuildMatchScore_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildMatch_GameRecord.XML", "Panel_Window_GuildMatch_GameRecord", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Widget_GuildMatch_Countdown.XML", "Panel_Widget_GuildMatch_Countdown", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildMatch_Rank.XML", "Panel_Window_GuildMatch_Rank", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/NakMessage/NakMessage_KillCombo.XML", "Panel_NakMessage_KillCombo", UIGroup.PAGameUIGroup_Widget)
  end
  if true == _ContentsGroup_Guild_JoinRequest then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_RequestList_All.XML", "Panel_GuildJoinRequestList_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Volunteer_All.XML", "Panel_GuildVolunteerList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Max_Incentive_All.XML", "Panel_GuildIncentive_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Incentive_All.XML", "Panel_GuildIncentiveOption_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_WebInfo_All.XML", "Panel_GuildWebInfo_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_GuildRegistSoldier_All.XML", "Panel_GuildRegistSoldier_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_UseGuildFunds_All.XML", "Panel_GuildUseFund_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Deposit_All.XML", "Panel_GuildDeposit_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_SetGuildHouse_All.XML", "Panel_SelectGuildMansion_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/AlertArea/Panel_Widget_Guild_ItemShare.XML", "Panel_GuildItemShare_Message", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_AttributeReport_All.XML", "Panel_GuildAttributeReport_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ActivityFunds_List_All.XML", "Panel_Window_GuildActivityFunds_List_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_ActivityFunds_Option_All.XML", "Panel_Window_GuildActivityFunds_Option_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_DocumentManagement_All.XML", "Panel_Window_GuildDocumentManagement_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_IncentiveOption_All.XML", "Panel_Window_GuildIncentiveSetting_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MemberPointDetail_All.XML", "Panel_Window_GuildMemberPointDetail_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_PointOption_All.XML", "Panel_Window_GuildPointOption_All", UIGroup.PAGameUIGroup_MarniWave)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_PointMenu_All.XML", "Panel_Window_GuildPointMenu_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildPresent_All.XML", "Panel_Window_GuildPresent", UIGroup.PAGameUIGroup_GameMenu)
  if true == _ContentsGroup_NewGuildNone then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_SimpleInvite.XML", "Panel_Window_Guild_SimpleInvite", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Guild/Panel_Widget_GuildInvite_Alert.XML", "Panel_GuildInvite_Alert", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_InviteList.XML", "Panel_Guild_InviteList", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_GuildReward then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_MiningReward_All.XML", "Panel_GuildReward_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_MiningFuel_All.XML", "Panel_Guild_MiningFuel_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_AgreementGuild.XML", "Panel_AgreementGuild", Defines.UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_AgreementGuild_Master.XML", "Panel_AgreementGuild_Master", Defines.UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_GetDailyPay.XML", "Panel_Guild_GetDailyPay", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildAlliance_Invitation.XML", "Panel_GuildAlliance_Invitation", Defines.UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    Defines.RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/Color/Panel_War_Color.XML", "Panel_GuildWar_Color", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Color/Panel_War_Color_List.XML", "Panel_GuildWar_ColorList", UIGroup.PAGameUIGroup_Alert)
  if true == _ContentsGroup_Guild_JoinRequest then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_NoneGuild_All.XML", "Panel_Guild_NoneGuild", UIGroup.PAGameUIGroup_Window_Progress)
    if true == _ContentsGroup_NewGuildNone then
      basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_IntroduceMySelf.XML", "Panel_Guild_IntroduceMySelf", UIGroup.PAGameUIGroup_Alert)
    end
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_ApplyJoinList_All.XML", "Panel_Guild_ApplyJoinList", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_JoinRequestSet_All.XML", "Panel_Guild_JoinRequestSet", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_NoneJoinMember.XML", "Panel_Guild_NoneJoinMember", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_GuildServerWar then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MainServerSet_All.XML", "Panel_Guild_MainServerSet_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if false == _ContentsGroup_PanelReload_Develop then
    basicLoadUI("UI_Data/Window/Guild/Panel_GuildBattle_JoinMember.XML", "Panel_GuildBattle_JoinMember", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Guild/Panel_GuildBattle_Point.XML", "Panel_GuidlBattle_Point", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Guild/Panel_GuildBattle_EntryList.XML", "Panel_GuildBattle_EntryList", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/Guild/Panel_GuildBattle_SelectMember.XML", "Panel_GuildBattle_SelectMember", UIGroup.PAGameUIGroup_Widget)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildTentAttackedMsg.XML", "Panel_GuildTentAttackedMsg", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Duel.XML", "Panel_GuildDuel", UIGroup.PAGameUIGroup_Window_Progress)
  if false == _ContentsGroup_PanelReload_Develop then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_UseGuildFunds.XML", "Panel_Guild_UseGuildFunds", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_ChoiseTheMoney.XML", "Panel_Guild_ChoiseTheMoney", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if __Guild_LimitPrice then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_SetFundsList.XML", "Panel_Guild_SetFundsList", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildList_SetAttendanceWar.XML", "Panel_GuildList_SetAttendanceWar", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Window/Guild/Panel_CreateClan_All.XML", "Panel_CreateClan_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Guild/Panel_Guild_Create_All.XML", "Panel_Guild_Create_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_GuildAuthoritySeparation == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Authorization_All.XML", "Panel_Guild_Authorization_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Rank.XML", "Panel_Guild_Rank", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_GuildRank_Web.XML", "Panel_GuildRank_Web", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_GuildWatchingMode.XML", "Panel_GuildBattleWatchingMode", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/AlertArea/Panel_Widget_GuildWar.XML", "Panel_Widget_GuildWarAlert_All", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_NewUI_GameOption_All then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Window_Gameoption_Main_All.XML", "Panel_Window_GameOption_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Panel_Window_GameSettings_Notice_PopUp.XML", "Panel_Window_GameModeSettingNotice_All", UIGroup.PAGameUIGroup_Windows)
  elseif true == _ContentsGroup_isNewOption then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Option_Main.XML", "Panel_Window_cOption", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Camera.XML", "Panel_Performance_Camera", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_GraphicQuality.XML", "Panel_Performance_GraphicQuality", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Npc.XML", "Panel_Performance_Npc", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Performance_Optimize.XML", "Panel_Performance_Optimize", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Alert.XML", "Panel_Function_Alert", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Convenience.XML", "Panel_Function_Convenience", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Etc.XML", "Panel_Function_Etc", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Interaction.XML", "Panel_Function_Interaction", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Nation.XML", "Panel_Function_Nation", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_View.XML", "Panel_Function_View", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Function_Worldmap.XML", "Panel_Function_Worldmap", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Camera.XML", "Panel_Graphic_Camera", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Effect.XML", "Panel_Graphic_Effect", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Quality.XML", "Panel_Graphic_Quality", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_ScreenShot.XML", "Panel_Graphic_ScreenShot", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Window.XML", "Panel_Graphic_Window", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Graphic_Hdr.XML", "Panel_Graphic_HDR", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Action.XML", "Panel_Interface_Action", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Function.XML", "Panel_Interface_Function", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Mouse.XML", "Panel_Interface_Mouse", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Interface_Pad.XML", "Panel_Interface_Pad", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Interface_QuickSlot.XML", "Panel_Interface_QuickSlot", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Interface_UI.XML", "Panel_Interface_UI", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Option_Sound_OnOff.XML", "Panel_Sound_OnOff", UIGroup.PAGameUIGroup_Windows)
    if true == _ContentsGroup_InstrumentPerformance then
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    else
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume_NonMusicPlayOption.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    end
    basicLoadUI("UI_Data/Window/c_Option/Option_Alert_Alarm.XML", "Panel_Alert_Alarm", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Option/Panel_SetShortCut.XML", "Panel_SetShortCut", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_UISetting,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER_ADD_LOADING())
  loadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/MessageBox/Panel_KickOff.XML", "Panel_KickOff", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Knowledge/Panel_Knowledge_Info.XML", "Panel_Knowledge_Info", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/Knowledge/Panel_Knowledge_ViewHistory.XML", "Panel_Knowledge_ViewHistory", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/Knowledge/Panel_Knowledge_List.XML", "Panel_Knowledge_List", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/Knowledge/Panel_Knowledge_Main.XML", "Panel_Knowledge_Main", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/Knowledge/Panel_Knowledge_Point.XML", "Panel_Knowledge_Point", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Base.XML", "Panel_MentalGame_Base", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Center.XML", "Panel_MentalGame_Center", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Left_All.XML", "Panel_MentalGameLeft_All", UIGroup.PAGameUIGroup_QuestLog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Right_List_All.XML", "Panel_MentalGameRight_All", UIGroup.PAGameUIGroup_QuestLog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Select_All.XML", "Panel_MentalGameSelect_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Window/MentalKnowledge/MentalGame_Tooltip_All.XML", "Panel_MentalGameTooltip_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Knowledge
  }))
  loadUI("UI_Data/Widget/Damage/UI_Damage.XML", "Panel_Damage", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/QuestList/Field_QuestIcon.XML", "Panel_fieldQuest", UIGroup.PAGameUIGroup_Dialog)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_Endurance.XML", "Panel_Endurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_HorseEndurance.XML", "Panel_HorseEndurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_CarriageEndurance.XML", "Panel_CarriageEndurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_ShipEndurance.XML", "Panel_ShipEndurance", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Enduarance/UI_SailShipEndurance.XML", "Panel_SailShipEndurance", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/Repair/Panel_Dialog_Repair_Function_All.XML", "Panel_Dialog_Repair_Function_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Repair/Panel_Window_SetupRepair_All.XML", "Panel_Window_SetupRepair_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Endurance_Recovery_All.XML", "Panel_Window_Endurance_Recovery_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Repair/Panel_LuckyRepair_Result.XML", "Panel_LuckyRepair_Result", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Extraction/Panel_Window_Extraction_Function_All.XML", "Panel_Window_Extraction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Extraction/UI_Window_Extraction_Result.XML", "Panel_Window_Extraction_Result", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Crystal_All.XML", "Panel_Window_Extraction_Crystal_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Costume_All.XML", "Panel_Window_Extraction_Costume_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_System_All.XML", "Panel_Window_Extraction_System_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Blackstone_All.XML", "Panel_Window_Extraction_EnchantStone_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Caphras_All.XML", "Panel_Window_Extraction_Caphras_All", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BlackSmith/Panel_Window_Extraction_Artifacts_All.XML", "Panel_Window_Extraction_Artifacts_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Arena/Panel_Arena_Battle.XML", "Panel_Arena_Battle", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Arena/Panel_Window_Arena_Waiting.XML", "Panel_Arena_Waiting", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Gear.XML", "Panel_HorseRacing_Gear", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/HorseRacing/Panel_HorseRacing_Score.XML", "Panel_HorseRacing_Score", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/CharacterTag/Panel_CharacterTag_ALL.XML", "Panel_CharacterTag_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/CharacterTag/Panel_Icon_CharacterTag.XML", "Panel_Icon_CharacterTag", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/MainStatus/UI_Cursor.XML", "Panel_Cursor", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_HpMpBar_Remaster.XML", "Panel_MainStatus_User_Bar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_ExpGauge_Remaster.XML", "Panel_SelfPlayerExpGage", UIGroup.PAGameUIGroup_MainUI + 1)
  if true == _ContentsGroup_RemasterUI_Main then
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_FamilyBuff_New.XML", "Panel_PersonalIcon_Left", UIGroup.PAGameUIGroup_MainUI)
  else
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_PersonalIcon_Left.XML", "Panel_PersonalIcon_Left", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_GoldenBell.XML", "Panel_Widget_GoldenBell", UIGroup.PAGameUIGroup_SimpleTooltip)
  if true == _ContentsGroup_RemasterUI_Main then
    loadUI("UI_Data/Widget/MainStatus/Panel_Widget_MainStatus_New.XML", "Panel_MainStatus_Remaster", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  loadUI("UI_Data/Widget/MainStatus/UI_SelfPlayer_Main_Slot_Casting_Bar.XML", "Panel_Casting_Bar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_EscapeBar_All.XML", "Panel_Widget_EscapeBar_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow
  }))
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_PvpIcon_Remaster.XML", "Panel_PvpMode", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/MainStatus/Panel_ClassResource.XML", "Panel_ClassResource", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_Adrenallin_Remaster.XML", "Panel_Adrenallin", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_GuardGauge.XML", "Panel_GuardGauge", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_AutoTraining.XML", "Panel_AutoTraining", UIGroup.PAGameUIGroup_MainUI)
  if true == _ContentsGroup_RemasterUI_Main_RightTop then
    basicLoadUI("UI_Data/Widget/RightTopIcons/Panel_Widget_FunctionButton.XML", "Panel_Widget_Function", UIGroup.PAGameUIGroup_MainUI)
  end
  loadUI("UI_Data/Window/DropItem/Panel_Window_DropItem_All_Renew.XML", "Panel_Window_DropItem_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/DropItem/Panel_Window_DropItem_ImageTooltip_All.XML", "Panel_Window_DropItem_ImageTooltip_All", UIGroup.PAGameUIGroup_PhotoMode, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  if _ContentsGroup_FeverBuff then
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_AgrisGauge.XML", "Panel_Widget_AgrisGauge", UIGroup.PAGameUIGroup_Interaction)
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_AgrisGaugeTooltip.XML", "Panel_Widget_AgrisGaugeTooltip", UIGroup.PAGameUIGroup_SimpleTooltip)
  end
  if _ContentsGroup_LandscapePainting then
    basicLoadUI("UI_Data/Window/DropItem/Panel_Window_LandscapePaintingDrop_All.XML", "Panel_Window_LandscapePaintingDrop", UIGroup.PAGameUIGroup_Interaction)
  end
  if _ContentsGroup_PalaceManagement then
    loadUI("UI_Data/Window/PalaceManagement/Panel_Window_PalaceManagement_Map_All.XML", "Panel_Window_PalaceManagement_Map", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/PalaceManagement/Panel_PalaceManagement_Tooltip.XML", "Panel_Window_PalaceManagement_Tooltip", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/PalaceManagement/Panel_Window_PalaceManagement_Node_All.XML", "Panel_Window_PalaceManagement_Node", UIGroup.PAGameUIGroup_Windows + 2, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/PalaceManagement/Panel_Window_PalaceManagement_WorkManager.XML", "Panel_Window_PalaceManagement_WorkManager", UIGroup.PAGameUIGroup_Windows + 3, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if true == _ContentsGroup_HopeGauge then
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_HopeGauge.XML", "Panel_Widget_HopeGauge", UIGroup.PAGameUIGroup_Interaction)
    basicLoadUI("UI_Data/Widget/MainStatus/Panel_Widget_HopeGaugeOnOff_Renew.XML", "Panel_Widget_HopeGaugeOnOff", UIGroup.PAGameUIGroup_Interaction)
  end
  basicLoadUI("UI_Data/Window/MovieGuide/Panel_MovieGuide.XML", "Panel_MovieGuide", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/ImportantKnowledge/Panel_ImportantKnowledge.XML", "Panel_ImportantKnowledge", UIGroup.PAGameUIGroup_Housing)
  basicLoadUI("UI_Data/Widget/ImportantKnowledge/Panel_Knowledge_Main.XML", "Panel_NewKnowledge", UIGroup.PAGameUIGroup_Housing)
  basicLoadUI("UI_Data/Widget/ImportantKnowledge/Panel_NormalKnowledge.XML", "Panel_NormalKnowledge", UIGroup.PAGameUIGroup_Housing)
  basicLoadUI("UI_Data/Widget/NewEquip/Panel_NewEquip.XML", "Panel_NewEquip", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/NakMessage/NakMessage.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_SimpleTooltip + 1, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/NakMessage/NakMessage_MSG_SEQUENCE.XML", "Panel_NakMessage_Sequence", UIGroup.PAGameUIGroup_SimpleTooltip + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessage_Renewel.XML", "Panel_NakMessage_Renewel", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_RoseWar
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Important_Notice.XML", "Panel_Important_Notice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  loadUI("UI_Data/Widget/Chatting/UI_Window_Chat.XML", "Panel_Chat", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/Chatting/UI_Window_ChatOption.XML", "Panel_ChatOption", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  if ToClient_IsDevelopment() == true then
    loadUI("UI_Data/Widget/Chatting/UI_Window_Chatting_Input.XML", "Panel_Chatting_Input", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  else
    loadUI("UI_Data/Widget/Chatting/UI_Window_Chatting_Input.XML", "Panel_Chatting_Input", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER_NOT_SEQUENCE())
  end
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Filter.XML", "Panel_Chatting_Filter", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Macro.XML", "Panel_Chatting_Macro", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_SocialMenu.XML", "Panel_Chat_SocialMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_Emoticon.XML", "Panel_Chat_Emoticon", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_SubMenu.XML", "Panel_Chat_SubMenu", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Color.XML", "Panel_Chatting_Color", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  basicLoadUI("UI_Data/Widget/Chatting/Panel_Window_Join_ChannelChat.XML", "Panel_Window_ChannelChat", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Chatting/Panel_Window_ChannelChat_Wait.XML", "Panel_Widget_ChannelChat_Loading", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContentsGroup_ChatOption_All then
    loadUI("UI_Data/Widget/Chatting/Panel_Window_ChatOption_All.XML", "Panel_Window_ChatOption_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
    loadUI("UI_Data/Widget/Chatting/Panel_Window_Chatting_Color_All.XML", "Panel_Window_Chatting_Color_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_RoseWar
    }))
  end
  loadUI("UI_Data/Window/Report/Panel_Window_Chat_Report_All.XML", "Panel_Window_Chat_Report_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_GameTips.XML", "Panel_GameTips", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_GameTipsMask.XML", "Panel_GameTipMask", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/GameTips/UI_Window_GameTips.XML", "Panel_Window_GameTips", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Widget/NoticeAlert/NoticeAlert.XML", "Panel_NoticeAlert", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/UI_Panel_QuickSlot.XML", "Panel_QuickSlot", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Widget/QuickSlot/Panel_NewQuickSlot.XML", "Panel_NewQuickSlot", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_0.XML", "Panel_NewQuickSlot_0", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_1.XML", "Panel_NewQuickSlot_1", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_2.XML", "Panel_NewQuickSlot_2", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_3.XML", "Panel_NewQuickSlot_3", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_4.XML", "Panel_NewQuickSlot_4", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_5.XML", "Panel_NewQuickSlot_5", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_6.XML", "Panel_NewQuickSlot_6", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_7.XML", "Panel_NewQuickSlot_7", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_8.XML", "Panel_NewQuickSlot_8", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_9.XML", "Panel_NewQuickSlot_9", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_10.XML", "Panel_NewQuickSlot_10", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_11.XML", "Panel_NewQuickSlot_11", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_12.XML", "Panel_NewQuickSlot_12", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_13.XML", "Panel_NewQuickSlot_13", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_14.XML", "Panel_NewQuickSlot_14", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_15.XML", "Panel_NewQuickSlot_15", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_16.XML", "Panel_NewQuickSlot_16", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_17.XML", "Panel_NewQuickSlot_17", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_18.XML", "Panel_NewQuickSlot_18", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/NewQuickSlot/Panel_NewQuickSlot_19.XML", "Panel_NewQuickSlot_19", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_QuickView.XML", "Panel_SkillCooltime", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/QuickSlot/Panel_Window_ReplaySkillCooltime_All.XML", "Panel_Window_ReplaySkillCooltime_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  basicLoadUI("UI_Data/Widget/QuickSlot/Panel_SkillCoolTimeQuickSlot.XML", "Panel_SkillCoolTimeQuickSlot", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/Stamina/Stamina.XML", "Panel_Stamina", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  basicLoadUI("UI_Data/Widget/Stamina/CannonGauge.XML", "Panel_CannonGauge", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/Stamina/Panel_Widget_Stamina_Auto.XML", "Panel_Stamina_Auto", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/Housing/UI_Panel_Housing.XML", "Panel_Housing", UIGroup.PAGameUIGroup_Housing)
  if true == _ContentsGroup_NewUI_InstallMode_All then
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_All.XML", "Panel_House_InstallationMode_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_List_All.XML", "Panel_House_InstallationMode_List_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_ObjectControl_All.XML", "Panel_House_InstallationMode_ObjectControl_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_SeedList_All.XML", "Panel_House_InstallationMode_SeedList_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Widget/Housing/Panel_Housing_FarmInfo_All.XML", "Panel_Housing_FarmInfo_All", UIGroup.PAGameUIGroup_Housing, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_WarInfomation_All.XML", "Panel_House_InstallationMode_WarInfomation_All", UIGroup.PAGameUIGroup_Housing, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/Housing/Panel_House_Name_All.XML", "Panel_House_Name_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_War_All.XML", "Panel_House_InstallationMode_War_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_KeyGuide_All.XML", "Panel_House_InstallationMode_KeyGuide_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
  else
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_New.XML", "Panel_House_InstallationMode", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_Cart_New.XML", "Panel_House_InstallationMode_Cart", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_ObjectControl.XML", "Panel_House_InstallationMode_ObjectControl", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Widget/Housing/Panel_InstallationMode_FarmInfo.XML", "Panel_InstallationMode_FarmInfo", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Widget/Housing/Panel_Housing_FarmInfo_New.XML", "Panel_Housing_FarmInfo_New", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_HouseInstallation
    }))
    loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_WarInfomation.XML", "Panel_House_WarInformation", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Widget/Housing/Panel_HouseName.XML", "Panel_HouseName", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Window/ChangeName/Panel_Window_ChangeNickname_All.XML", "Panel_Change_Nickname_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_VillageTent.XML", "Panel_House_InstallationMode_VillageTent", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_HouseInstallation
  }))
  basicLoadUI("UI_Data/Window/ChangeName/Panel_NameSwapExchange.XML", "Panel_ExchangeNickname", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/ProgressBar/UI_Win_Collect_Bar.XML", "Panel_Collect_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/ProgressBar/UI_Win_Product_Bar.XML", "Panel_Product_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/ProgressBar/UI_Win_Enchant_Bar.XML", "Panel_Enchant_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_Exchange_Item.xml", "Panel_Exchange_Item", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Npc_Dialog_Scene.xml", "Panel_Dialog_Scene", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_DetectPlayer.xml", "Panel_DetectPlayer", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_GuildQuest_Reward.XML", "Panel_GuildQuest_Reward", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Knowledge_Management.XML", "Panel_KnowledgeManagement", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_Quest_Reward.xml", "Panel_Npc_Quest_Reward", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Intimacy_All.xml", "Panel_Npc_Intimacy_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_ButtonList_All.XML", "Panel_Dialog_List_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Exchange_All.XML", "Panel_Dialog_Exchange_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Quest_Reward_All.xml", "Panel_Dialog_Quest_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Interest_Knowledge_All.XML", "Panel_Interest_Knowledge_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_PetLeader_All.xml", "Panel_Dialog_PetLeader_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_PetLeader_List_All.xml", "Panel_Dialog_PetLeader_List_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_Dialog_All.xml", "Panel_Npc_Dialog_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_HorseWithoutOwner.XML", "Panel_Dialog_HorseWithoutOwner_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/SimpleDialog/Panel_Widget_SimpleDialog.XML", "Panel_Dialog_Simple_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/SimpleDialog/Panel_Widget_SimpleDialog_DescBox.XML", "Panel_Dialog_SimpleDesc_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Dialogue/Dialog_Itemtake_ALL.xml", "Panel_Dialogue_Itemtake_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/ItemLog/Panel_Widget_QuestRewardItem.xml", "Panel_Widget_QuestRewardItem", UIGroup.PAGameUIGroup_Window_Progress - 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_Main_Control.xml", "Panel_UIControl", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/QuestList/NewQuest.XML", "Panel_NewQuest", UIGroup.PAGameUIGroup_Chatting)
  loadUI("UI_Data/Widget/Menu/Panel_Menu.XML", "Panel_Menu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_UISetting
  }))
  loadUI("UI_Data/Widget/Menu/Panel_Widget_Menu_Remake.XML", "Panel_Widget_Menu_Remake", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_UISetting
  }))
  basicLoadUI("UI_Data/Widget/SkillLog/Panel_Widget_SkillLog.XML", "Panel_Widget_SkillLog", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/LvUpMessage/UI_Levelup_Reward.XML", "Panel_Levelup_Reward", UIGroup.PAGameUIGroup_Chatting)
  if true == _ContentsGroup_NewUI_LevelupInfo_All then
    basicLoadUI("UI_Data/Window/LevelUp/Panel_Window_LevelUp_ALL.XML", "Panel_Window_LevelUp_Info_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/LevelUp/Panel_Window_LevelUp.XML", "Panel_Levelup_Info", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Widget/Acquire/Acquire.XML", "Panel_Acquire", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Tutorial,
    RenderMode.eRenderMode_SkillWindow
  }))
  loadUI("UI_Data/Widget/Acquire/Acquire_QuestDirect.XML", "Panel_QuestDirect", UIGroup.PAGameUIGroup_Chatting, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_MentalGame,
    RenderMode.eRenderMode_customScreenShot
  }))
  loadUI("UI_Data/Widget/AlertArea/Panel_Widget_QuestAlert.XML", "Panel_Widget_QuestAlert", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if not _ContentsGroup_RemasterUI_MonsterHpBar then
    basicLoadUI("UI_Data/Widget/EnemyGauge/EnemyGauge.XML", "Panel_Monster_Bar", UIGroup.PAGameUIGroup_Windows)
  else
    loadUI("UI_Data/Widget/EnemyGauge/Panel_Widget_EnemyGauge.XML", "Panel_Monster_Bar", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SniperGame,
      RenderMode.eRenderMode_CutScene,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  basicLoadUI("UI_Data/Widget/Region/Region.XML", "Panel_Region", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/UIcontrol/UI_WhereUseTargetItem.XML", "Panel_WhereUseItemDirection", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Inventory/UI_Window_PartyInventory.XML", "Panel_Window_PartyInventory", UIGroup.PAGameUIGroup_Quest)
  loadUI("UI_Data/Widget/Party/Panel_Widget_Party_All.xml", "Panel_Widget_Party_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Party/Panel_Widget_Raid_All.xml", "Panel_Widget_Raid_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Party/Panel_Widget_PartyMatching_Atoraxxion.XML", "Panel_PartyContentRecurit", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/Party/Panel_Party_ItemList.XML", "Panel_Party_ItemList", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_ReturnUser_BlackSpirit.XML", "Panel_ReturnUser_BlackSpirit", UIGroup.PAGameUIGroup_Dialog)
  if false == _ContentsGroup_RemasterUI_QuestWidget then
    basicLoadUI("UI_Data/Widget/QuestList/ProgressGuildQuest.XML", "Panel_Current_Guild_Quest", UIGroup.PAGameUIGroup_Dialog)
    loadUI("UI_Data/Widget/QuestList/Panel_CheckedQuest.XML", "Panel_CheckedQuest", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Widget/QuestList/Panel_MainQuest.XML", "Panel_MainQuest", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  else
    loadUI("UI_Data/Widget/QuestList/Panel_Widget_QuestList.XML", "Panel_CheckedQuest", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Widget/QuestList/Panel_Widget_MainQuest.XML", "Panel_MainQuest", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if true == _ContentsGroup_RemasterUI_Radar then
    basicLoadUI("UI_Data/Widget/Radar/Panel_Widget_Radar.XML", "Panel_Radar", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/Radar/Panel_Widget_TimeBar.XML", "Panel_TimeBar", UIGroup.PAGameUIGroup_MainUI - 1)
  else
    basicLoadUI("UI_Data/Widget/Radar/Radar.XML", "Panel_Radar", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/Radar/RadarTimeBar.XML", "Panel_TimeBar", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/Radar/RadarTimeBarNumber.XML", "Panel_TimeBarNumber", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Radar/Radar_NightAlert.XML", "Panel_Radar_NightAlert", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_FrameLoop_Widget.XML", "Panel_FrameLoop_Widget", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/NpcNavigation/Panel_Window_NpcNavigation_All.XML", "Panel_NpcNavi_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/NpcNavigation/UI_Tooltip_NpcNavigation_All.XML", "Panel_Tooltip_NpcNavigation_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Widget/NaviPath/Panel_NaviPath.XML", "Panel_NaviPath", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/TownNpcNavi/Panel_Widget_TownNpcNavi.XML", "Panel_Widget_TownNpcNavi", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/NpcNavigation/Panel_Widget_TownSimpleNavi.XML", "Panel_Widget_TownSimpleNavi_All", UIGroup.PAGameUIGroup_MainUI + 1)
  if _ContentsGroup_NewVoiceChat == true then
    basicLoadUI("UI_Data/Window/VoiceChat/Panel_SetVoiceChat_Setting_New.XML", "Panel_VoiceChat_Setting_New", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/VoiceChat/Panel_SetVoiceChat_List_New.XML", "Panel_VoiceChat_List_New", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/VoiceChat/Panel_VoiceChat_Talker_New.XML", "Panel_VoiceChat_Talker_New", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/VoiceChat/Panel_SetVoiceChat_All.XML", "Panel_Window_SetVoiceChat_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_FarmingList then
    basicLoadUI("UI_Data/Widget/FarmingTimer/Panel_Widget_FarmingTimer_All.XML", "Panel_Widget_FarmingTimer_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/FarmingTimer/Panel_Widget_FarmingTimerReport_All.XML", "Panel_Widget_FarmingTimerReport_All", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_LootingItemRecord == true then
    basicLoadUI("UI_Data/Window/Looting/Panel_Window_LootingItemReport_Main_All.XML", "Panel_Window_LootingItemReport_Main_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_DragonPalace then
    basicLoadUI("UI_Data/Widget/Arena/Panel_RabbitLiverScramble_Timer.xml", "Panel_Widget_RabbitLiverScrambleTimer", UIGroup.PAGameUIGroup_Interaction - 1)
  end
  basicLoadUI("UI_Data/Widget/Bubble/Bubble.XML", "Panel_Bubble", UIGroup.PAGameUIGroup_Widget)
  if _ContentsGroup_Sequence == true then
    loadUI("UI_Data/Widget/Interaction/UI_Character_InterAction.XML", "Panel_Interaction", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_CutScene,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Interaction/UI_Character_InterAction_Gathering.XML", "UI_Character_InterActionGathering_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_CutScene,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  else
    basicLoadUI("UI_Data/Widget/Interaction/UI_Character_InterAction.XML", "Panel_Interaction", UIGroup.PAGameUIGroup_Interaction)
    basicLoadUI("UI_Data/Widget/Interaction/UI_Character_InterAction_Gathering.XML", "UI_Character_InterActionGathering_All", UIGroup.PAGameUIGroup_Interaction)
  end
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_FriendHouseList.XML", "Panel_Interaction_FriendHouseList", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_HouseRank.XML", "Panel_Interaction_HouseRank", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_House.XML", "Panel_Interaction_House", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Widget/Interaction/Panel_WatchingCommand.XML", "Panel_WatchingMode", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Interaction/Panel_CommandGuide.XML", "Panel_CommandGuide", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill.XML", "Panel_Tooltip_Skill", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLearning.XML", "Panel_Tooltip_Skill_forLearning", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_BlackSpirit.XML", "Panel_Tooltip_Skill_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_forLinkTooltip.XML", "Panel_Tooltip_Skill_forLinkTooltip", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_All.XML", "Panel_Tooltip_SkillGroup", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_forLearning_All.XML", "Panel_Tooltip_SkillGroup_forLearning", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_BlackSpirit_All.XML", "Panel_Tooltip_SkillGroup_forBlackSpirit", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_forLinkTooltip_All.XML", "Panel_Tooltip_SkillGroup_forLinkTooltip", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Tooltip_Skill_NextLevel_All.XML", "Panel_Tooltip_Skill_NextLevel_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    loadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Item_All.XML", "Panel_Widget_Tooltip_Item_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Item_Equip_All.XML", "Panel_Widget_Tooltip_Item_Equip_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Item_LinkedItem_All.XML", "Panel_Widget_Tooltip_Item_LinkedItem_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Item_LinkedClickItem_All.XML", "Panel_Widget_Tooltip_Item_LinkedClickItem_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Skill_Servant_All.XML", "Panel_Widget_Tooltip_Skill_Servant_All", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
  else
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Skill_Servant.XML", "Panel_Tooltip_Skill_Servant", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item.XML", "Panel_Tooltip_Item", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItem.XML", "Panel_Tooltip_Item_chattingLinkedItem", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_chattingLinkedItemClick.XML", "Panel_Tooltip_Item_chattingLinkedItemClick", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Item_equipped.XML", "Panel_Tooltip_Item_equipped", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_Dye,
      RenderMode.eRenderMode_HouseInstallation,
      RenderMode.eRenderMode_InGameCashShop,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  loadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Actor_All.XML", "Panel_Widget_Tooltip_Actor_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SkillWindow,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Guild_Introduce.XML", "Panel_Tooltip_Guild_Introduce", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Common.XML", "Panel_Tooltip_Common", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Work.XML", "Panel_Tooltip_Work", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SpeechBubble.XML", "Panel_Tooltip_SpeechBubble", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  basicLoadUI("UI_Data/Widget/Introduction/Panel_Widget_Introduction.XML", "Panel_Introduction", UIGroup.PAGameUIGroup_GameMenu)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect.XML", "Panel_CoolTime_Effect", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Slot.XML", "Panel_CoolTime_Effect_Slot", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Item.XML", "Panel_CoolTime_Effect_Item", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Item_Slot.XML", "Panel_CoolTime_Effect_Item_Slot", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/DeadMessage/Panel_DeadMessage_All.XML", "Panel_Window_DeadMessage_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_CutScene
  }))
  basicLoadUI("UI_Data/Window/DeadMessage/Panel_Cash_Revival_BuyItem_ALL.XML", "Panel_Cash_Revival_BuyItem_All", UIGroup.PAGameUIGroup_FadeScreen)
  basicLoadUI("UI_Data/Window/DeadMessage/Panel_DeadNodeSelect.XML", "Panel_DeadNodeSelect", UIGroup.PAGameUIGroup_FadeScreen)
  loadUI("UI_Data/Window/DeadMessage/DangerAlert.XML", "Panel_Danger", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER_NOT_SEQUENCE())
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_PriceRate_All.XML", "Panel_Dialog_Trade_PriceRate_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_BiddingGame_All.XML", "Panel_Dialog_Trade_BiddingGame_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_MarketItemList_All.XML", "Panel_Dialog_Trade_MarketItemList_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_Tooltip_All.XML", "Panel_Dialog_Trade_Tooltip_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_MyBasket_All.XML", "Panel_Dialog_Trade_MyBasket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_Function_All.XML", "Panel_Dialog_Trade_Function_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Worldmap_Trade_MarketItemList_All.XML", "Panel_Worldmap_Trade_MarketItemList_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/TradeMarket/Panel_Dialog_Trade_NoLink_All.XML", "Panel_Dialog_Trade_NoLink_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if true == _ContentsGroup_isUsedNewTradeEventNotice then
    loadUI("UI_Data/Window/TradeMarket/UI_Win_Npc_TradeEventNotice_Renewal_All.xml", "Panel_Window_TradeEventNotice_Renewal_All", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/TradeMarket/UI_Win_Npc_TradeMarket_Event.xml", "Panel_TradeMarket_EventInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/Alchemy/Panel_Window_Alchemy_All.xml", "Panel_Window_Alchemy_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Alchemy/Panel_RecentCook_New.xml", "Panel_RecentCook", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_FriendInfoList_All.XML", "Panel_FriendInfoList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_AddFriend_All.XML", "Panel_FriendList_Add_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_FriendRequest_All.XML", "Panel_Friend_RequestList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Window_Friend_ChangeGroupName_All.XML", "Panel_Friend_GroupRename_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Friend_TalkMessanger_All.XML", "Panel_Friend_TalkMessanger_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Widget_Friends_Floating.XML", "Panel_Widget_Friends_Floating", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Friend/Panel_Widget_Friends_Floating_Alert.XML", "Panel_Widget_Friends_FloatingAlert", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Alchemy/Panel_Manufacture_All.xml", "Panel_Window_Manufacture_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Alchemy/Panel_Manufacture_Notify.XML", "Panel_Manufacture_Notify", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_CombineBag == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_CombiInventory_All.xml", "Panel_Window_CombineBag", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  loadUI("UI_Data/Widget/FieldViewMode/UI_FieldViewMode.xml", "Panel_FieldViewMode", UIGroup.PAGameUIGroup_InstanceMission, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_UISetting
  }))
  loadUI("UI_Data/Window/GameExit/Panel_ChannelSelect_All.XML", "Panel_ChannelSelect_All", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/GameExit/Panel_Window_GameExit_All.xml", "Panel_Window_GameExit_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/GameExit/Panel_Window_ExitConfirm_Reboot.xml", "Panel_ExitConfirm", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/GameExit/Panel_ExitConfirm.xml", "Panel_ExitConfirm_Old", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/GameExit/Panel_Window_TrayConfirm_All.xml", "Panel_Window_TrayConfirm_All", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/DeadMessage/UI_NoAccessibleArea_Alert.xml", "Panel_NoAceessArea_Alert", UIGroup.PAGameUIGroup_ScreenEffect)
  loadUI("UI_Data/Window/ProductNote/Panel_ProductNote.XML", "Panel_ProductNote", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/KeyboardHelp/Panel_KeyboardHelp.XML", "Panel_KeyboardHelp", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/LevelupGuide/Panel_LevelupGuide.XML", "Panel_LevelupGuide", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/QnAWebLink/Panel_QnAWebLink.XML", "Panel_QnAWebLink", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_PowerControl_All.xml", "Panel_MiniGame_PowerControl_All", UIGroup.PAGameUIGroup_MainUI)
  if true == _ContentsGroup_NewUI_Fishing_All then
    basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_Command_All.xml", "Panel_MiniGame_Command_All", UIGroup.PAGameUIGroup_MiniGameUpUI)
    basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_SinGauge_All.xml", "Panel_MiniGame_SinGauge_All", UIGroup.PAGameUIGroup_MiniGameUpUI)
    basicLoadUI("UI_Data/Widget/PowerGauge/Panel_Widget_PowerGauge_All.XML", "Panel_Widget_PowerGauge_All", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Command.xml", "Panel_Command", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_SinGauge.xml", "Panel_SinGauge", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/PowerGauge/Panel_PowerGauge.XML", "Panel_PowerGauge", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_FillGauge.xml", "Panel_FillGauge", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Steal.xml", "Panel_MiniGame_Steal", UIGroup.PAGameUIGroup_MainUI)
  if true == _ContentsGroup_NewUI_Jaksal_All then
    basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_Jaksal_All.xml", "Panel_MiniGame_Jaksal_All", UIGroup.PAGameUIGroup_MainUI)
  else
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Jaksal.xml", "Panel_MiniGame_Jaksal", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/MiniGame/Minagame_SteeringGear.xml", "Panel_SteeringWheel", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Hammer_New.xml", "Panel_Hammer_New", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_ResultMessage.xml", "Panel_MiniGame_MiniGameResult", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_SniperShotResult_All.xml", "Panel_MiniGame_SniperShotResult_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SniperGame
  }))
  if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
    loadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_SniperReload_All.xml", "Panel_MiniGame_SniperReload_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SniperGame
    }))
    loadUI("UI_Data/Widget/SniperGame/Panel_SniperGame_All.xml", "Panel_MiniGame_SniperGame_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SniperGame
    }))
    loadUI("UI_Data/Widget/SniperGame/Panel_SniperGame_Result_All.xml", "Panel_MiniGame_SniperGame_Result_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SniperGame
    }))
  elseif false == _ContentsGroup_PanelReload_Develop then
    loadUI("UI_Data/Widget/MiniGame/MiniGame_SniperReload.xml", "MiniGame_SniperReload", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SniperGame
    }))
    loadUI("UI_Data/Widget/SniperGame/Panel_SniperGame.xml", "Panel_SniperGame", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SniperGame
    }))
    loadUI("UI_Data/Widget/SniperGame/Panel_SniperGame_Result.xml", "Panel_SniperGame_Result", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SniperGame
    }))
  end
  loadUI("UI_Data/Widget/MiniGame/MiniGame_Horse_Skill_Trainning_All.xml", "Panel_Minigame_GradientY_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MiniGame/MiniGame_Timing_All.xml", "Panel_MiniGame_Timing_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MiniGame/MiniGame_Horse_Trained_All.xml", "Panel_MiniGame_Horse_Trained_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Wagon_All.xml", "Panel_Minigame_Gradient_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Rhythm_All.xml", "Panel_MiniGame_Rhythm_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Rhythm_Drum_All.xml", "Panel_MiniGame_Rhythm_Drum_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_Find_All.xml", "Panel_MiniGame_Find_All", Defines.UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_MiniGame_YachtDice then
    loadUI("UI_Data/Window/MiniGame/Panel_Window_MiniGame_YachtDice.XML", "Panel_Window_MiniGame_YachtDice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_Minigame_YachtDice_Result.XML", "Panel_Widget_MiniGame_YachtDice_Result", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_MyDeck.XML", "Panel_Widget_MiniGame_Tooltip_MyDeck", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_Tooltip.XML", "Panel_Widget_MiniGame_Tooltip", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Window/MiniGame/Panel_Window_MiniGame_YachtDice_PVP_Invite.XML", "Panel_Window_MiniGame_YachtDice_PVP_Invite", Defines.UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Notice.XML", "Panel_Widget_MiniGame_YachtDice_Notice", Defines.UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_MiniGame_YachtDice_Match == true then
    loadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_MatchConfirm.XML", "Panel_Widget_MiniGame_YachtDice_MatchConfirm", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_FindingMatch.XML", "Panel_Widget_MiniGame_YachtDice_FindingMatch", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_RewardMarket == true then
    loadUI("UI_Data/Window/Dialog/Panel_Window_RewardMarket_All.XML", "Panel_Window_RewardMarket_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if true == ToClient_IsDevelopment() then
    loadUI("UI_Data/Window/Log/Panel_Window_DamageLog.XML", "Panel_Window_DamageLog", Defines.UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Sequence,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
    loadUI("UI_Data/Window/Log/Panel_Window_DamageLog_Detail.XML", "Panel_Window_DamageLog_Detail", Defines.UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Sequence,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  if true == _ContentsGroup_IceFishingGame then
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_IceFishing_All.XML", "Panel_MiniGame_IceFishing_All", Defines.UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningSlaughter_All.xml", "Panel_MiniGame_MorningSlaughter_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningSyringe_All.xml", "Panel_MiniGame_MorningSyringe_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningLeather_All.xml", "Panel_MiniGame_MorningLeather_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningMining_All.xml", "Panel_MiniGame_MorningMining_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningLogging_All.xml", "Panel_MiniGame_MorningLogging_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Widget/MiniGame/Panel_MiniGame_MorningHomi_All.xml", "Panel_MiniGame_MorningHomi_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  if _ContentsGroup_ImprovedGalleyShip == true then
    basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_GalleyPaddle_All.XML", "Panel_MiniGame_GalleyPaddle_All", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Widget/Tutorial/New/Panel_Widget_Tutorial_GuideUI.XML", "Panel_Widget_Tutorial_GuideUI", UIGroup.PAGameUIGroup_Tutorial)
  basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_Tutorial.XML", "Panel_Window_MessageBox_Tutorial", UIGroup.PAGameUIGroup_Tutorial)
  basicLoadUI("UI_Data/Widget/BossInstance/Panel_Widget_BossInstance_Dummy.XML", "Panel_Widget_BossInstance_Dummy", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/SkillCommand/UI_SkillCommand.xml", "Panel_SkillCommand", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Menu/Panel_Combo_Guide.xml", "Panel_Combo_Guide", UIGroup.PAGameUIGroup_MainUI)
  if ToClient_IsDevelopment() then
    basicLoadUI("UI_Data/Widget/SkillCommand/UI_ComboCommand.xml", "Panel_ComboCommand", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/Console/UI_Widget_NextCombo.xml", "Panel_ConsoleCombo", UIGroup.PAGameUIGroup_MainUI)
  end
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    loadUI("UI_Data/Widget/Search/Panel_Widget_Dialog_Search_All.xml", "Panel_Widget_Dialog_Search_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Widget/Search/UI_Dialog_Search.xml", "Panel_Dialog_Search", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Widget/Tutorial/Panel_Movie_KeyViewer.xml", "Panel_Movie_KeyViewer", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Widget/Tutorial/UI_Masking_Tutorial_Quest.XML", "Panel_Masking_Tutorial", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Tutorial
  }))
  if false == _ContentsGroup_Tutorial_Renewal then
    loadUI("UI_Data/Widget/Tutorial/Welcome_to_BlackDesert.xml", "Panel_Tutorial", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Tutorial,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/Tutorial/Panel_TutorialMenu.xml", "Panel_TutorialMenu", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  else
    loadUI("UI_Data/Widget/Tutorial/Panel_Tutorial_Renewal.XML", "Panel_Tutorial_Renew", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Tutorial
    }))
  end
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_ArousalTutorial.xml", "Panel_ArousalTutorial", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_SummonBossTutorial.xml", "Panel_SummonBossTutorial", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/Tutorial/UI_ButtonHelp.xml", "Panel_ButtonHelp", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Widget/Tutorial/UI_KeyTutorial.xml", "Panel_KeyTutorial", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_LifeTutorial.xml", "Panel_LifeTutorial", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_ValuePackageTutorial.xml", "Panel_ValuePackageTutorial", UIGroup.PAGameUIGroup_Alert)
  if true == _ContentsGroup_SelectStartPosition then
    basicLoadUI("UI_Data/Window/Quest/Panel_Window_StartBranch.XML", "Panel_Window_StartBranch", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/HouseInfo/Panel_HouseControl_Main.XML", "Panel_HouseControl", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/HouseInfo/Panel_House_SellBuy_Condition.XML", "Panel_House_SellBuy_Condition", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/Scroll/UI_Scroll.xml", "Panel_Scroll", UIGroup.PAGameUIGroup_GameSystemMenu)
  loadUI("UI_Data/Widget/BreathGauge/Panel_BreathGauge.XML", "Panel_BreathGauge", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Window/Delivery/UI_Window_Delivery_Person.XML", "Panel_Window_DeliveryForPerson", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Delivery/UI_Window_Delivery_GameExit.XML", "Panel_Window_DeliveryForGameExit", UIGroup.PAGameUIGroup_GameMenu)
  loadUI("UI_Data/Widget/Dialogue/Panel_AskKnowledge.XML", "Panel_AskKnowledge", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Cutscene/Panel_CutsceneMovie.XML", "Panel_Cutscene", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceMain.XML", "Panel_SequenceMain", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_SubTitle.XML", "Panel_Sequence_SubTitle", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceNotifier.XML", "Panel_SequenceNotifier", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_LetterBox.XML", "Panel_Sequence_LetterBox", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceSkip.XML", "Panel_SequenceSkip", UIGroup.PAGameUIGroup_MainUIFront, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceSkipPopUp.XML", "Panel_SequenceSkipPopUp", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_SequenceSkipEscPopUp.XML", "Panel_SequenceSkipEscPopUp", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_DeadMessage.XML", "Panel_Sequence_DeadMessage", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_R_SkipMessageBox.XML", "Panel_Sequence_R_SkipMessageBox", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_TitleTexture.XML", "Panel_Sequence_TitleTexture", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_KeyGuide.XML", "Panel_Sequence_KeyGuide", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_SkillCommandGuide.XML", "Panel_Sequence_SkillCommandGuide", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Window/Sequence/Panel_Sequence_SkillTutorial.XML", "Panel_Sequence_SkillTutorial", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_HpMpBar_Remaster_forCutscene.XML", "Panel_Sequence_HpMpBar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Widget/Stamina/Stamina_forCutscene.XML", "Panel_Sequence_Stamina", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_Adrenallin_Remaster_forCutscene.XML", "Panel_Sequence_Adrenallin", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
  if true == ToClient_IsDevelopment() then
    loadUI("UI_Data/Window/JobInfoReqForDev/UI_JobInfo_Create.XML", "Panel_JobInfoCreate", UIGroup.PAGameUIGroup_Tutorial, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/JobInfoReqForDev/UI_JobInfo_Func.XML", "Panel_JobInfoFunc", UIGroup.PAGameUIGroup_Tutorial, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_HouseHold_New.XML", "Panel_Copy_HouseHold", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Installation_New.XML", "Panel_Copy_Installation", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Maid_New.XML", "Panel_Copy_MaidActor", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_Solare_Buff.XML", "Panel_Actor_SolareBuffStateUI", UIGroup.PAGameUIGroup_MainUI)
  if true == ToClient_IsDevelopment() then
    basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Monster_New.XML", "Panel_Copy_Monster", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_CutScene
    }))
  else
    basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Monster_New.XML", "Panel_Copy_Monster", UIGroup.PAGameUIGroup_MainUI)
  end
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Npc_New.XML", "Panel_Copy_Npc", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_OtherPlayer_New.XML", "Panel_Copy_OtherPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_SelfPlayer_New.XML", "Panel_Copy_SelfPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Vehicle_New.XML", "Panel_Copy_Vehicle", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Actor/UI_Actor_ActionStatus.XML", "Panel_CharacterActionStatus", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl,
    RenderMode.eRenderMode_Replay
  }))
  basicLoadUI("UI_Data/Actor/UI_Actor_DummyCharacter_CC.XML", "Panel_Actor_DummyCharacter_CC", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_LocalWarOccupation_Gauge.XML", "Panel_LocalWar_OccupationGauge", UIGroup.PAGameUIGroup_MiniGameUI)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWarOccupation_Gauge_Big.XML", "Panel_LocalWar_CurrentOccupationGauge", UIGroup.PAGameUIGroup_MiniGameUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_BubbleBox.XML", "Panel_Copy_BubbleBox", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/HumanRelation/HumanRelation.XML", "Panel_Copy_HumanRelation", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/HumanRelation/HumanRelationIcon.XML", "Panel_Copy_HumanRelationIcon", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_WaitComment.XML", "Panel_Copy_WaitComment", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/NaviPath/Panel_NaviPath.XML", "Panel_Copy_NaviPath", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop.XML", "Panel_IngameCashShop", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_GoodsTooltip.XML", "Panel_IngameCashShop_GoodsTooltip", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_GoodsDetailInfo.XML", "Panel_IngameCashShop_GoodsDetailInfo", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_SetEquip.XML", "Panel_IngameCashShop_SetEquip", UIGroup.PAGameUIGroup_Window_Progress, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Controller.XML", "Panel_IngameCashShop_Controller", UIGroup.PAGameUIGroup_Interaction, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_BuyOrGift.XML", "Panel_IngameCashShop_BuyOrGift", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Password.XML", "Panel_IngameCashShop_Password", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_NewCart.XML", "Panel_IngameCashShop_NewCart", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_ChargeDaumCash.XML", "Panel_IngameCashShop_ChargeDaumCash", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_TermsofDaumCash.XML", "Panel_IngameCashShop_TermsofDaumCash", UIGroup.PAGameUIGroup_GameSystemMenu, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_MakePaymentsFromCart.XML", "Panel_IngameCashShop_MakePaymentsFromCart", UIGroup.PAGameUIGroup_Siege, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_BuyPearlBox.XML", "Panel_IngameCashShop_BuyPearlBox", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_HowUsePearlShop.XML", "Panel_IngameCashShop_HowUsePearlShop", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Coupon.XML", "Panel_IngameCashShop_Coupon", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_CategorySale.XML", "Panel_IngameCashShop_EventCart", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_EasyPayment.XML", "Panel_IngameCashShop_EasyPayment", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/IngameCashShop/Panel_Window_StampCoupon.XML", "Panel_Window_StampCoupon", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods.XML", "Panel_Window_RecommandGoods", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods_PopUp.XML", "Panel_Window_RecommandGoods_PopUp", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/ScreenShot_WebAlbum/Panel_ScreenShot_SNS.XML", "Panel_ScreenShot_SNS", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_BuyHistory.XML", "Panel_IngameCashShop_BuyHistory", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashSHop_ReturnBack.XML", "Panel_IngameCashSHop_ReturnBack", UIGroup.PAGameUIGroup_Siege, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_Desc.XML", "Panel_IngameCashShop_Desc", UIGroup.PAGameUIGroup_HouseInfo, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_All.XML", "Panel_IngameCashShop_MoonBlessing_All", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  if _ContentsGroup_PearlShopMoonBlessingRenew == true then
    loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_Renew_All.XML", "Panel_IngameCashShop_MoonBlessing_Renew_All", UIGroup.PAGameUIGroup_WorldMap_Contents, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  end
  if true == _ContentsGroup_GuildGiveaway then
    loadUI("UI_Data/Window/IngameCashShop/Panel_IngameCashShop_GuildReward_All.XML", "Panel_IngameCashShop_GuildGiveaway_All", UIGroup.PAGameUIGroup_InstanceMission, SETRENDERMODE_BITSET_INGAMECASHSHOP())
  end
  loadUI("UI_Data/Window/Cash_Customization/Panel_Cash_Customization.XML", "Panel_Cash_Customization", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_IngameCustomize
  }))
  loadUI("UI_Data/Window/Cash_Customization/Panel_Cash_Customization_BuyItem.XML", "Panel_Cash_Customization_BuyItem", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_IngameCustomize
  }))
  if true == ToClient_IsDevelopment() then
    loadUI("UI_Data/Script/QASupport/Panel_CreateRandomFaceBoneForDEV.XML", "Panel_CreateRandomFaceBoneForDEV", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_IngameCustomize
    }))
  end
  if true == _ContentsGroup_RenewUI_ItemMarketPlace then
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_BuyManagement.XML", "Panel_Window_MarketPlace_BuyManagement", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_Favorite.XML", "Panel_Window_MarketPlace_Favorite", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_Function.XML", "Panel_Window_MarketPlace_Function", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_Main.XML", "Panel_Window_MarketPlace_Main", UIGroup.PAGameUIGroup_WorldMap_Popups, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_MiniWallet.XML", "Panel_Window_MarketPlace_MiniWallet", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_MyInventory.XML", "Panel_Window_MarketPlace_MyInventory", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_SelectList.XML", "Panel_Window_MarketPlace_SelectList", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_PriceList.XML", "Panel_Window_MarketPlace_PriceList", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_SellManagement.XML", "Panel_Window_MarketPlace_SellManagement", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_WalletInventory.XML", "Panel_Window_MarketPlace_WalletInventory", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_SubWallet.XML", "Panel_Window_MarketPlace_SubWallet", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_TutorialSelect.XML", "Panel_Window_MarketPlace_TutorialSelect", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_Favorite.XML", "Panel_Window_ItemMarket_Favorite", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/MarketPlace/Panel_Window_MarketPlace_BuyProductInCashShop.XML", "Panel_Window_MarketPlace_BuyProductInCashShop", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_Favorite.XML", "Panel_Window_ItemMarket_Favorite", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_Function.XML", "Panel_Window_ItemMarket_Function", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarketNew.XML", "Panel_Window_ItemMarket", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_BidDesc.XML", "Panel_ItemMarket_BidDesc", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_ItemSet.XML", "Panel_Window_ItemMarket_ItemSet", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_RegistItem.XML", "Panel_Window_ItemMarket_RegistItem", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_BuyConfirm.XML", "Panel_Window_ItemMarket_BuyConfirm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_BuyConfirm_Secure.XML", "Panel_Window_ItemMarket_BuyConfirmSecure", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_AlarmList.XML", "Panel_ItemMarket_AlarmList", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_Alarm.XML", "Panel_ItemMarket_Alarm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_PreBid.XML", "Panel_ItemMarket_PreBid", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_PreBid_Manager.XML", "Panel_ItemMarket_PreBid_Manager", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_Password.XML", "Panel_ItemMarket_Password", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_AlarmList_New.XML", "Panel_Window_ItemMarketAlarmList_New", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_NewAlarm.XML", "Panel_ItemMarket_NewAlarm", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_Window_ItemMarket_RClickMenu.XML", "Panel_Window_ItemMarket_RClickMenu", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/ItemMarket/Panel_ItemMarket_Alarm_All.XML", "Panel_ItemMarket_Alarm_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BossAlert/Panel_BossAlert_SettingV2_All.XML", "Panel_BossAlert_SettingV2_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/BossAlert/Panel_BossAlertV2.XML", "Panel_BossAlertV2", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/RandomBoxSelect/Panel_Window_RandomBoxSelect_All.XML", "Panel_RandomBoxSelect_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Widget/Gacha_Roulette/Panel_Gacha_Roulette.XML", "Panel_Gacha_Roulette", UIGroup.PAGameUIGroup_Chatting)
  basicLoadUI("UI_Data/Window/PcRoomNotify/Panel_PcRoomNotify.XML", "Panel_PcRoomNotify", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/EventNotify/Panel_Window_NewsBanner_All.XML", "Panel_NewsBanner", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_NewUI_EventNotify_All then
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventNotify_All.XML", "Panel_EventNotify_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventNotifyContent_All.XML", "Panel_EventNotifyContent_All", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventNotify.XML", "Panel_EventNotify", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventNotifyContent.XML", "Panel_EventNotifyContent", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Window/Event/Panel_Event_100Day.XML", "Panel_Event_100Day", UIGroup.PAGameUIGroup_ModalDialog)
  if _ContentsGroup_EventGuidePage == true then
    basicLoadUI("UI_Data/Window/EventNotify/Panel_EventGuide_Total.XML", "Panel_EventGuide_Total", UIGroup.PAGameUIGroup_Windows)
  end
  preloadCustomizationUI_PC()
  if true == _ContentsGroup_NewUI_CarveSeal_All then
    basicLoadUI("UI_Data/Window/CarveSeal/Panel_Window_CarveSeal_All.XML", "Panel_Window_CarveSeal_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/CarveSeal/Panel_CarveSeal.XML", "Panel_CarveSeal", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/CarveSeal/Panel_ResetSeal.XML", "Panel_ResetSeal", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_DeleteMaxEnchanterName then
    basicLoadUI("UI_Data/Window/CarveSeal/Panel_Window_DeleteMaxEnchanterName.XML", "Panel_DeleteMaxEnchanterName", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/ClearVested/Panel_ClearVested.XML", "Panel_ClearVested", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/UI_Setting/Panel_Window_UIModify_All.XML", "Panel_Window_UIModify_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_UISetting
  }))
  loadUI("UI_Data/Window/UI_Setting/Panel_Window_SavePreset_All.XML", "Panel_Window_SavePreset_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_UISetting
  }))
  loadUI("UI_Data/Window/WorkerManager/Panel_Window_WorkerManager_New_All.XML", "Panel_Window_WorkerManager_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/WorkerManager/UI_WorkerChangeSkill_All.XML", "Panel_Window_WorkerManagerChangeSkill_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/WorkerManager/UI_WorkerRestoreAll_All.XML", "Panel_Window_WorkerManagerRestore_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_Worker_All.XML", "Panel_Widget_WorkerManagerTooltip_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Window/ChangeName/Panel_Window_WorkerName_All.XML", "Panel_Window_WorkerManagerChangeName_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Auction/Panel_Window_WorkerAuction_All.XML", "Panel_Window_WorkerAuction_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Tooltip/Panel_Widget_WorkerSkillTooltip_All.XML", "Panel_Widget_WorkerSkillTooltip_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/CharacterTag/Panel_EXPExchange_ALL.XML", "Panel_Window_ExchangeExp_All", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_NewUI_TransferLifeExp_All then
    basicLoadUI("UI_Data/Window/TransferLifeExperience/Panel_Widow_TransferLifeExperience_All.XML", "Panel_TransferLifeExperience_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/TransferLifeExperience/Panel_TransferLifeExperience.XML", "Panel_TransferLifeExperience", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/ChangeItem/Panel_ChangeItem.XML", "Panel_ChangeItem", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_NewUI_ChangeItem_All then
    basicLoadUI("UI_Data/Window/ChangeItem/Panel_Window_ChangeItem_All.XML", "Panel_Window_ChangeItem_All", UIGroup.PAGameUIGroup_Window_Progress)
  else
    basicLoadUI("UI_Data/Window/ChangeItem/Panel_ChangeWeapon.XML", "Panel_ChangeWeapon", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/Party/Panel_MatchResult.XML", "Panel_MatchResult", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_RaceTimeAttack.XML", "Panel_RaceTimeAttack", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_RaceFinishTime.XML", "Panel_RaceFinishTime", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Party/Panel_RaceResult.XML", "Panel_RaceResult", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_AlchemyStoneRenewal == true then
    basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyStone_Renewal_All.XML", "Panel_Window_AlchemyStone_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyStoneEvolve_All.XML", "Panel_Window_AlchemyStoneEvolve_All", UIGroup.PAGameUIGroup_Window_Progress_Child)
  else
    basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyStone_All.XML", "Panel_Window_AlchemyStone_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_ArtifactItem then
    basicLoadUI("UI_Data/Window/Artifacts/Panel_Window_Artifacts_All.XML", "Panel_Window_Artifacts_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Alchemy/Panel_AlchemyFigureHead_All.XML", "Panel_AlchemyFigureHead_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/RallyRanking/Panel_RallyRanking.XML", "Panel_RallyRanking", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWar.XML", "Panel_LocalWar", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWarTeam_All.XML", "Panel_LocalWarTeam", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWarTeam_SetVoiceChat_All.XML", "Panel_LocalWarTeam_SetVoiceChat_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Join/Panel_Window_Join.XML", "Panel_Join", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/WarInfoMessage/Panel_TerritoryWar_Caution.XML", "Panel_TerritoryWar_Caution", UIGroup.PAGameUIGroup_Widget)
  if true == _ContentsGroup_NewUI_ItemWarp_All then
    basicLoadUI("UI_Data/Window/ItemWarp/Panel_ItemWarp_All.XML", "Panel_ItemWarp_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  else
    basicLoadUI("UI_Data/Window/ItemWarp/Panel_ItemWarp.XML", "Panel_ItemWarp", UIGroup.PAGameUIGroup_WorldMap_Contents)
  end
  if _ContentsGroup_Telescope == true then
    basicLoadUI("UI_Data/Window/Scope/Panel_Window_Scope_All.XML", "Panel_Window_Scope_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  end
  basicLoadUI("UI_Data/Window/GoldenTreasureBox/Panel_TreasureBox_All.XML", "Panel_GoldenTreasureBox_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/ScreenShot_WebAlbum/Panel_ScreenShot_WebAlbum.XML", "Panel_ScreenShotAlbum", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/ScreenShot_WebAlbum/Panel_ScreenShotAlbum_FullScreen.XML", "Panel_ScreenShotAlbum_FullScreen", UIGroup.PAGameUIGroup_Siege, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop
  }))
  basicLoadUI("UI_Data/Window/Broadcast/Panel_Broadcast.xml", "Panel_Broadcast", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/CashShopAlert/UI_Widget_CashShopAlert.xml", "Panel_CashShopAlert", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Widget/NakMessage/NakMessageByActionChart.xml", "Panel_ActionMessage", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessageByActionChart_New.xml", "Panel_ActionMessage_New", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_RescueShip.xml", "Panel_RescueShip", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_SummonGamos.xml", "Panel_SummonGamos", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_Widget_SummonZod.xml", "Panel_Widget_SummonZod", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_Widget_SummonBelmorn.xml", "Panel_Widget_SummonBelmorn", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_SummonKatsvariak.xml", "Panel_SummonKatsvariak", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Tutorial/Panel_TamingBubble.xml", "Panel_TamingBubble", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Window/SeasonTexture/Panel_SeasonTexture.xml", "Panel_SeasonTexture", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/BossWave/Panel_Widget_BossWave.xml", "Panel_BossWave", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Party/Panel_Window_FindParty_All.xml", "Panel_PartyList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Party/Panel_Window_FindParty_Recruite_All.xml", "Panel_PartyRecruite_All", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Party/Panel_Window_FindParty_Guild_All.xml", "Panel_GuildPartyList_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Servant/Panel_ServantResurrection.xml", "Panel_ServantResurrection", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/TimeAttack/Panel_TimeAttack.xml", "Panel_TimeAttack", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/MonsterRanking/Panel_MonsterRanking.xml", "Panel_Window_MonsterRanking", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/BlackSpiritAdventure/Panel_Window_BlackSpiritAdventure2.xml", "Panel_Window_BlackSpiritAdventure_2", UIGroup.PAGameUIGroup_Windows)
  if true == isGameServiceTypeTurkey() then
    basicLoadUI("UI_Data/Window/TurkeyIME/Panel_TurkeyIME.XML", "Panel_TurkeyIME", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_NewUI_Memo_All then
    basicLoadUI("UI_Data/Window/Memo/Panel_Memo_Sticky_All.xml", "Panel_Memo_Sticky_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Memo/Panel_Memo_Main_All.xml", "Panel_Window_Memo_Main_All", UIGroup.PAGameUIGroup_Windows)
  else
    basicLoadUI("UI_Data/Window/Memo/Panel_Memo_Sticky.xml", "Panel_Memo_Sticky", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/Memo/Panel_Memo_Main.xml", "Panel_Memo_List", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    loadUI("UI_Data/Window/ButtonShortcuts/Panel_Window_ButtonShortcuts_All.xml", "Panel_Window_ButtonShortcuts_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_UISetting
    }))
  else
    loadUI("UI_Data/Window/ButtonShortcuts/Panel_ButtonShortcuts.xml", "Panel_ButtonShortcuts", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_UISetting
    }))
  end
  if _ContentsGroup_WorldmapButtonShortcuts == true then
    loadUI("UI_Data/Window/ButtonShortcuts/Panel_Window_WorldmapButtonShortcuts_All.xml", "Panel_Window_WorldmapButtonShortcuts_All", UIGroup.PAGameUIGroup_WorldMap_Contents, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Window/TranslationReport/Panel_Window_TranslationReport.XML", "Panel_TranslationReport", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Knowledge,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/TranslationReport/Panel_Window_TranslationText.XML", "Panel_Window_TranslationText", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Under18/Panel_Message_Under18.xml", "Panel_Message_Under18", UIGroup.PAGameUIGroup_FadeScreen)
  if true == _ContentsGroup_RemasterUI_Main_Alert then
    basicLoadUI("UI_Data/Widget/AlertArea/Panel_Widget_AlertArea.xml", "Panel_UIMain", UIGroup.PAGameUIGroup_MapRegion)
    basicLoadUI("UI_Data/Widget/AlertArea/Panel_Widget_ChallengeAlert.xml", "Panel_Widget_ChallengeAlert", UIGroup.PAGameUIGroup_MapRegion)
    loadUI("UI_Data/Widget/AlertArea/Panel_Widget_ContentUnlock.xml", "Panel_Widget_ContentUnlock", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Knowledge,
      RenderMode.eRenderMode_Dialog
    }))
  end
  basicLoadUI("UI_Data/Window/Achievement/Panel_Window_Achievement.XML", "Panel_Window_Achievement", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Achievement/Panel_Window_Achievement_BookShelf_All.XML", "Panel_Window_Achievement_BookShelf_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_MorningLand == true then
    basicLoadUI("UI_Data/Window/Achievement/Panel_Window_Achievement_Morningland.XML", "Panel_Window_Achievement_MorningLand", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Widget/Dialogue/Panel_NpcGift_All.xml", "Panel_Dialog_NpcGift_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/BlackDesertLab/Panel_Window_BlackDesertLab.xml", "Panel_Window_BlackDesertLab", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_All.XML", "Panel_MacroCheckQuiz_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/MacroCheckQuiz/Panel_Window_QuizNumpad_All.XML", "Panel_MacroCheckQuizPad_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Purification/Panel_Purification_All.XML", "Panel_Purification_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_CardGame then
    basicLoadUI("UI_Data/Window/CardGame/Panel_Window_CardGame.xml", "Panel_Window_CardGame", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_Menu_Xbox then
    basicLoadUI("UI_Data/Widget/Menu/Console/Panel_Menu_Renew.xml", "Panel_Window_Menu_Renew", UIGroup.PAGameUIGroup_Windows)
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_HardCore_All.xml", "Panel_CharacterInfo_HardCore_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/CharacterInfo/Panel_Window_CharacterInfo_HardCore_Basic_All.xml", "Panel_CharacterInfoBasic_HardCore_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_Quest_HardCore.XML", "Panel_Widget_Quest_HardCore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_LeftTime_HardCore.XML", "Panel_Widget_LeftTime_HardCore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Window_Hardcore_Result_All.XML", "Panel_Window_Hardcore_Result", UIGroup.PAGameUIGroup_WorldMap_Contents)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_Compass_Hardcore.XML", "Panel_Widget_Compass_Hardcore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Window_HardcoreRanking.XML", "Panel_Window_HardcoreRanking", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Window_Quest_HardCore.XML", "Panel_Window_Quest_HardCore", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_EnemyAlert_HardCore.XML", "Panel_Widget_EnemyAlert_HardCore", UIGroup.PAGameUIGroup_MainUI)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Widget_HardCoreBlackField_Enter.XML", "Panel_Widget_HardCoreBlackField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
    basicLoadUI("UI_Data/Widget/HardCore/Panel_Menu_HardCore.XML", "Panel_Menu_HardCore", UIGroup.PAGameUIGroup_Windows)
  end
  if false == _ContentsGroup_PanelReload_Develop then
    basicLoadUI("UI_Data/Window/Guild/Panel_AgreementVolunteer_Master.xml", "Panel_AgreementVolunteer_Master", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Window/Guild/Panel_AgreementVolunteer.xml", "Panel_AgreementVolunteer", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Window/Rank/Panel_Window_VolunteerRankWeb.xml", "Panel_Window_VolunteerRankWeb", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Rank/Panel_Window_AltarRank.xml", "Panel_AltarRank_Web", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/BetterEquipment/Panel_Widget_BetterEquipment.XML", "Panel_Widget_BetterEquipment", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/AccesoryQuest/Panel_Widget_AccesoryQuest.xml", "Panel_Widget_AccesoryQuest", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Quest/Panel_Window_QuestBranch.xml", "Panel_Window_QuestBranch", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/RewardList/Panel_Window_TotalReward_All.xml", "Panel_Window_TotalReward_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/RewardList/Panel_Window_TotalRewardHistory_All.xml", "Panel_Window_TotalRewardHistory_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Alert/Panel_Widget_LocalQuestAlert.xml", "Panel_Widget_LocalQuestAlert", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Dialogue/Panel_Widget_BlackSpirit_SkillSelect.xml", "Panel_Widget_BlackSpirit_SkillSelect", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_bloodAltar_renewal == true then
    basicLoadUI("UI_Data/Window/BloodAltar/Panel_Window_BloodAltar_All.XML", "Panel_Window_BloodAltar_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/BloodAltar/Panel_Widget_BloodAltarGauge_All.XML", "Panel_Widget_BloodAltarGauge_All", UIGroup.PAGameUIGroup_Widget)
    basicLoadUI("UI_Data/Window/BloodAltar/Panel_Window_BloodAltar_Retry_All.XML", "Panel_Window_BloodAltar_Retry_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Widget/BloodAltar/Panel_Widget_BloodAltar_RandomMatch.XML", "Panel_Widget_BloodAltar_RandomMatch", UIGroup.PAGameUIGroup_MapRegion)
  if ToClient_IsDevelopment() then
    basicLoadUI("UI_Data/Window/Panel_Window_UIEggTest.XML", "Panel_Window_UIEggTest", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/DM/Panel_Window_DM.XML", "Panel_Window_DM", UIGroup.PAGameUIGroup_Widget)
  end
  if false == _ContentsGroup_NewUI_PersonalMonster_All then
    basicLoadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonster.xml", "Panel_Window_PersonalMonster", UIGroup.PAGameUIGroup_Windows)
    loadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonsterInfo.xml", "Panel_Window_PersonalMonsterInfo", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
    basicLoadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonsterMessage.xml", "Panel_Window_PersonalMonsterMessage", UIGroup.PAGameUIGroup_ModalDialog)
  else
    basicLoadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonster_All.xml", "Panel_PersonalMonster_All", UIGroup.PAGameUIGroup_Windows)
    loadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonsterInfo_All.xml", "Panel_PersonalMonsterInfo_All", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
    basicLoadUI("UI_Data/Window/PersonalMonster/Panel_Window_PersonalMonsterMessage_All.xml", "Panel_PersonalMonsterMessage_All", UIGroup.PAGameUIGroup_ModalDialog)
  end
  basicLoadUI("UI_Data/Window/Report/Panel_Window_Report_All.XML", "Panel_Window_Report_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Banner/Panel_Window_Banner.XML", "Panel_Window_Banner", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Inventory/Panel_Window_SubInventory_All.XML", "Panel_Window_SimpleInventory", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Window/Inventory/Panel_Window_SimpleInventory_SearchResult.XML", "Panel_Window_SimpleInventory_SearchResult", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  if true == _ContentsGroup_DuelCharacterCopyEquip then
    basicLoadUI("UI_Data/Window/Inventory/UI_Window_Equip_CharacterTag_ItemCopy.XML", "Panel_Window_Equip_CharacterTag_ItemCopy", UIGroup.PAGameUIGroup_GameMenu)
    basicLoadUI("UI_Data/Window/Inventory/UI_Window_DescBox_ItemCopy.XML", "Panel_Window_DescBox_ItemCopy", UIGroup.PAGameUIGroup_GameMenu)
  end
  if true == _ContentsGroup_RestoreItem then
    basicLoadUI("UI_Data/Window/Inventory/Panel_Window_Restore_All.XML", "Panel_Window_Restore_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_InstrumentPerformance then
    loadUI("UI_Data/Window/Composition/Panel_Window_Composition_All.XML", "Panel_Window_Composition_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Composition/Panel_Window_MusicAlbum_All.XML", "Panel_Window_MusicAlbum_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Composition/Panel_Window_MusicShare_All.XML", "Panel_Window_MusicShare_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/PlayMusic/Panel_Window_PlayMusic_All.XML", "Panel_Window_MusicBoard_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/PlayMusic/Panel_Window_PlayMusicSetting_All.XML", "Panel_Window_MusicSetting_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Widget/PlayMusic/Panel_Widget_PlayWidget.XML", "Panel_Widget_PlayMusic_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    if true == _ContentsGroup_InstrumentShop then
      loadUI("UI_Data/Window/PlayMusic/Panel_Window_MyInstuments_All.XML", "Panel_Window_MyInstruments_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
      loadUI("UI_Data/Window/PlayMusic/Panel_Window_SelectInstuments_All.XML", "Panel_Window_SelectInstruments_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog
      }))
    end
  end
  basicLoadUI("UI_Data/Window/Common/Panel_Window_LetterScroll_All.XML", "Panel_Window_LetterScroll_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Common/Panel_Window_Picture.XML", "Panel_Window_Picture", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Common/Panel_Window_Invitation_All.XML", "Panel_Window_Invitation_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/KillLog/Panel_Widget_KillLog.XML", "Panel_Widget_KillLog", UIGroup.PAGameUIGroup_Alert, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if true == _ContentsGroup_SeasonContents then
    basicLoadUI("UI_Data/Window/Season/Panel_Season_CharacterTag.XML", "Panel_Window_ChangeSeasonCharacter_All", UIGroup.PAGameUIGroup_Windows)
  end
  if true == _ContentsGroup_GrowthPass then
    loadUI("UI_Data/Window/GrowthPass/Panel_Window_GrowthPass.XML", "Panel_Window_GrowthPass", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/GrowthPass/Panel_Window_GrowthPass_Info.XML", "Panel_Window_GrowthPass_Info", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/GrowthPass/Panel_Window_GrowthPass_PointShop.XML", "Panel_Window_GrowthPass_PointShop", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/GrowthPass/UI_Tooltip_Author.XML", "Panel_Tooltip_Author", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  end
  loadUI("UI_Data/Window/Season/Panel_Window_SeasonReward.XML", "Panel_Window_SeasonReward_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/Awakening_Succession/Panel_Widget_Awakening_Succession_Select_All.XML", "Panel_Widget_Awakening_Succession_Select_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if _ContentsGroup_LightStoneBag == true then
    loadUI("UI_Data/Window/Inventory/UI_Window_Inventory_Artifacts.XML", "Panel_Window_LightStoneBag", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Inventory/UI_Window_Inventory_Artifacts_PresetList.XML", "Panel_Window_ArtifactPreset_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if true == _ContentsGroup_NewUI_ShipControl_All then
    basicLoadUI("UI_Data/Window/Servant/Panel_Widget_Ship_Control.XML", "Panel_Widget_Ship_Control", UIGroup.PAGameUIGroup_Windows)
  end
  if _ContentsGroup_MorningLand == true then
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_Boss_All.XML", "Panel_Window_MorningLand_Boss_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_DetailReward_All.XML", "Panel_MorningLand_DatailReward", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_MyReward_All.XML", "Panel_MorningLand_MyReward_All", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_BossRanking_All.XML", "Panel_MorningLand_BossRanking", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_ConquestHistory_All.XML", "Panel_MorningLand_ConquestHistory", UIGroup.PAGameUIGroup_Windows + 1, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    if _ContentsGroup_MorningLand2 == true then
      loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_QuestBoard2_All.XML", "Panel_MorningLand_QuestBoard_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
    else
      loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_QuestBoard_All.XML", "Panel_MorningLand_QuestBoard_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
    end
    loadUI("UI_Data/Window/MorningLand/Panel_MorningLand_Scenario_All.XML", "Panel_MorningLand_Scenario_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/MorningLand/Panel_Widget_ConquestGiveUp_All.XML", "Panel_MorningLand_ConquestGiveUp", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/AlertArea/Panel_Widget_QuestBoardAlert.XML", "Panel_MorningLand_QuestBoardAlert_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_MorningLand2 == true then
    loadUI("UI_Data/Window/Movie/Panel_EndingCredit_All.XML", "Panel_EndingCredit_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Widget/UIcontrol/Panel_PadSnapTargetEffect.XML", "Panel_PadSnapTargetEffect", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  if true == _ContentsGroup_UsePadSnapping then
    loadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenu.xml", "Panel_QuickMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
    basicLoadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenuCustom_Edit.xml", "Panel_QuickMenuCustom", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenuCustom_RightRing.xml", "Panel_QuickMenuCustom_RightRing", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Widget/Menu/Console/Panel_Widget_QuickMenu.xml", "Panel_Widget_QuickMenu", UIGroup.PAGameUIGroup_Widget)
    loadUI("UI_Data/Widget/KeyGuide/Panel_ConsoleKeyGuide.xml", "Panel_ConsoleKeyGuide", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_IngameCustomize,
      RenderMode.eRenderMode_Dialog,
      Defines.RenderMode.eRenderMode_customScreenShot,
      Defines.RenderMode.eRenderMode_InGameCashShop
    }))
  end
  if true == ToClient_IsDevelopment() then
    loadUI("UI_Data/Window/PowerSave/Panel_Window_PowerSave_All.XML", "Panel_Window_PowerSave_All", UIGroup.PAGameUIGroup_Movie, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_PowerSave
    }))
  end
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Member.XML", "Panel_Widget_ThornCastle_Member", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Nak_Sub_Boss.XML", "Panel_Widget_ThornCastle_Nak_Sub_Boss", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Nak_Sub_Enemy.XML", "Panel_Widget_ThornCastle_Nak_Sub_Enemy", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Nak_Sub_Friendly.XML", "Panel_Widget_ThornCastle_Nak_Sub_Friendly", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Nak_Point.XML", "Panel_Widget_ThornCastle_Nak_Point", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Nak_Main.XML", "Panel_Widget_ThornCastle_Nak_Main", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_ScorePanel.XML", "Panel_Widget_ThornCastle_ScorePanel", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_DeadMessage.XML", "Panel_Widget_ThornCastle_DeadMessage", UIGroup.PAGameUIGroup_DeadMessage)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Reward_Win.XML", "Panel_Widget_ThornCastle_Reward_Win", UIGroup.PAGameUIGroup_BattleAlert)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Reward_Lose.XML", "Panel_Widget_ThornCastle_Reward_Lose", UIGroup.PAGameUIGroup_BattleAlert)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Enter.XML", "Panel_Widget_ThornCastle_Enter", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Matching.XML", "Panel_Widget_ThornCastle_Matching", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_Map.XML", "Panel_Widget_ThornCastle_Map", UIGroup.PAGameUIGroup_WorldMap)
  basicLoadUI("UI_Data/Widget/ThornCastle/Panel_Widget_ThornCastle_NPCShop_All.XML", "Panel_ThornCastle_Shop", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Timer/Panel_Window_Timer.XML", "Panel_Timer_Set", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Window/Timer/Panel_Window_TimerCount.XML", "Panel_Window_TimerCount", UIGroup.PAGameUIGroup_SimpleTooltip)
  basicLoadUI("UI_Data/Window/Option/Panel_Window_Description.XML", "Panel_Window_Description", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Widget/KeyGuide/Panel_Widget_AttackWayCorrection_KeyGuide.XML", "Panel_Widget_AttackWayCorrection_KeyGuide", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/Inventory/Panel_Window_TimeLimit_All.XML", "Panel_Window_ExpirationPeriodItem", UIGroup.PAGameUIGroup_Windows)
  if true == _ContentsGroup_RenewalLifeGradeUpUI then
    basicLoadUI("UI_Data/Widget/NakMessage/NakMessage_Life.XML", "Panel_NakMessage_Life", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  end
  basicLoadUI("UI_Data/Widget/SiegeWar/Panel_SiegeWar_AngerGage.XML", "Panel_SiegeWar_AngerGage", UIGroup.PAGameUIGroup_Widget)
  if true == _ContentsGroup_FairySkillChangeRateView then
    basicLoadUI("UI_Data/Window/FairyInfo/Panel_Window_FairyRateDesc.XML", "Panel_Window_FairyRateDesc", UIGroup.PAGameUIGroup_Window_Progress)
  end
  basicLoadUI("UI_Data/Window/Event/Panel_Event_OXQuiz_GM.XML", "Panel_Event_QuizGM", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_OXQuiz.XML", "Panel_Event_Quiz", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_QuizEvent == true then
    basicLoadUI("UI_Data/Window/Event/Panel_Event_OXQuiz_Minimal.XML", "Panel_Event_Quiz_Minimal", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Event/Panel_Event_TicketShop_All.XML", "Panel_Event_TicketShop", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_Unboxing_Progress.XML", "Panel_Event_TicketShop_Unboxing", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_TicketShop_Nak.XML", "Panel_Event_TicketShop_Nak", UIGroup.PAGameUIGroup_Alert)
  loadUI("UI_Data/Window/Cutscene/Panel_Window_CutSceneSkip.XML", "Panel_Window_CutSceneSkip", UIGroup.PAGameUIGroup_IntroMovie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Window/Cutscene/Panel_Widget_CutScene_CC.XML", "Panel_Window_CutSceneScript", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Window/Cutscene/Panel_CutScene_Esc_Skip.XML", "Panel_Window_CutSceneEscSkip", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Production,
    RenderMode.eRenderMode_CutScene
  }))
  loadUI("UI_Data/Widget/SkillCommand/UI_SkillCommand_Cutscene.xml", "Panel_SkillCommand_Cutscene", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene
  }))
  if true == _ContentsGroup_Production then
  end
  if true == _ContentsGroup_NewSequenceTutorial then
    loadUI("UI_Data/Widget/Production/Tutorial/Panel_Widget_NewTutorial_Quest.XML", "Panel_SequenceTutorial_Quest", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production,
      RenderMode.eRenderMode_CutScene
    }))
  end
  if true == _ContentsGroup_SelectBox then
    loadUI("UI_Data/Window/ItemBox/Panel_Window_Itembox_Select.XML", "Panel_Window_SelectBox", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_InGameCashShop
    }))
  end
  basicLoadUI("UI_Data/Window/ItemBox/Panel_Window_MessageBox_ForReward_All.XML", "Panel_Window_MessageBox_ForReward", UIGroup.PAGameUIGroup_SimpleTooltip + 1)
  loadUI("UI_Data/Window/Inventory/Panel_Window_AutoMove_Set.XML", "Panel_Window_ItemMoveSet", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Widget/RentInstanceField/Panel_RentInstanceField_List.XML", "Panel_RentInstanceField_List", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/RentInstanceField/Panel_RentInstanceField_Option.XML", "Panel_RentInstanceField_Option", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/RentInstanceField/Panel_RentInstanceField_Time.XML", "Panel_RentInstanceField_Time", UIGroup.PAGameUIGroup_MainUI + 1)
  if true == ToClient_IsDevelopment() then
    loadUI("UI_Data/Window/Replay/Panel_Window_ReplayLoadList_All.XML", "Panel_Window_ReplayLoadList_All", UIGroup.PAGameUIGroup_Production_Modify, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production
    }))
    loadUI("UI_Data/Window/Production/Panel_Window_ProductionModify_All.XML", "Panel_Window_ProductionModify_All", UIGroup.PAGameUIGroup_Production_Modify, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production
    }))
    loadUI("UI_Data/Window/Production/Panel_Window_ProductionTimeline_All.XML", "Panel_Window_ProductionTimeline_All", UIGroup.PAGameUIGroup_Production_Modify, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production
    }))
    loadUI("UI_Data/Window/Production/Panel_Window_ProductionCamera_All.XML", "Panel_Window_ProductionCamera_All", UIGroup.PAGameUIGroup_Production_Modify, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production
    }))
    loadUI("UI_Data/Window/Production/Panel_Window_ProductionRecord_All.XML", "Panel_Window_ProductionRecord_All", UIGroup.PAGameUIGroup_Production_Modify, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production
    }))
  end
  loadUI("UI_Data/Window/Replay/Panel_Window_ReplayController_All.XML", "Panel_Window_ReplayController_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Invite/Panel_Window_Invite_All.XML", "Panel_Window_Invite_All", UIGroup.PAGameUIGroup_Window_Progress)
  if true == _ContentsGroup_MansionContent then
    basicLoadUI("UI_Data/Window/Mansion/Panel_Window_MansionRank.XML", "Panel_Window_MansionRank_All", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Mansion/Panel_Window_Mansion_Contract.XML", "Panel_Window_Mansion_Contract_All", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Housing/Panel_House_InstallationMode_Siege.XML", "Panel_House_InstallationMode_Siege_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_HouseInstallation
  }))
  if true == isGameTypeCH() then
    basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_MarkSelect_All.XML", "Panel_GuildChangeMark_All", UIGroup.PAGameUIGroup_Window_Progress)
    loadUI("UI_Data/Window/BlackBackground/Panel_Global_BlackBackGround.xml", "Panel_Global_BlackBackGround", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  end
  if true == _ContentsGroup_SnowAntLabyrinth then
    loadUI("UI_Data/Widget/NakMessage/NakMessage_Erethea.xml", "Panel_NakMessage_Erether_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Sequence,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  loadUI("UI_Data/Window/Movie/UI_ImageSlider.xml", "Panel_ImageSlider_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/NakMessage/Panel_Widget_NakMessageChoice_All.XML", "Panel_Widget_NakMessageChoice_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Ping/Panel_Widget_Ping.XML", "Panel_Widget_Ping_All", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/Servant/UI_Horse_SubMP.XML", "Panel_HorseSubMp_All", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/PersonerField/Panel_Widget_PersonalField_Mini.XML", "Panel_Widget_PersonalField_Mini", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PersonerField/Panel_Window_PersonalField_Main.XML", "Panel_Window_PersonalField_Main", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/PersonerField/Panel_Widget_PersonalField_Enter.XML", "Panel_Widget_PersonalField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_WatchingCommand_Build.XML", "Panel_SimpleBuildMode", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Widget/PhotoMode/Panel_Widget_PhotoMode_Main.XML", "Panel_PhotoMode_Main", UIGroup.PAGameUIGroup_PhotoMode, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Widget/PhotoMode/Panel_Widget_PhotoMode_KeyFunction.XML", "Panel_PhotoMode_KeyFunction", UIGroup.PAGameUIGroup_PhotoMode, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Widget/PhotoMode/Panel_Widget_PhotoMode_CenterFunction.XML", "Panel_PhotoMode_CenterFunction", UIGroup.PAGameUIGroup_PhotoMode, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  loadUI("UI_Data/Widget/PhotoMode/Panel_Widget_PhotoMode_Preset.XML", "Panel_PhotoMode_Preset", UIGroup.PAGameUIGroup_PhotoMode, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay
  }))
  if _ContentsGroup_SequenceIndividual == true then
    loadUI("UI_Data/Window/Cutscene/Panel_Cutscene_QuickTimeEvent_1.XML", "Panel_Window_QuickTimeEvent_CircleKeyDown", UIGroup.PAGameUIGroup_FadeScreen, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_GroupCamera,
      RenderMode.eRenderMode_Production,
      RenderMode.eRenderMode_CutScene
    }))
  end
  if true == _ContentsGroup_RadioPlayer then
    loadUI("UI_Data/Widget/RadioPlayer/Panel_Widget_RadioPlayer.xml", "Panel_Widget_RadioPlayer", UIGroup.PAGameUIGroup_MarniWave, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/RadioPlayer/Panel_Widget_RadioPlayer_Mini.xml", "Panel_Widget_RadioPlayer_Mini", UIGroup.PAGameUIGroup_MarniWave, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Widget/RadioPlayer/Panel_Widget_RadioPlayer_ChannelName.xml", "Panel_Widget_RadioPlayer_ChannelName", UIGroup.PAGameUIGroup_MarniWave_Channel, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_RecoveryElephant.XML", "Panel_RecoveryElephant", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/Tutorial/Panel_ContentsTutorial.XML", "Panel_ContentsTutorial_All", UIGroup.PAGameUIGroup_Tutorial, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    UIGroup.PAGameUIGroup_ModalDialog,
    RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Arbitration.XML", "Panel_Window_Guild_Arbitration", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/EnterElvia/Panel_Widget_EnterElvia.XML", "Panel_Widget_HadumField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_Process_All.XML", "Panel_Chat_Process_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Widget/AbyssOne/NakMessage_WareHouse_Clear.XML", "NakMessage_Warehouse_Clear", UIGroup.PAGameUIGroup_ModalDialog)
  if _ContentsGroup_MagnusEasyTeleport == true then
    basicLoadUI("UI_Data/Window/AbyssOne/Panel_Window_MagnusEasyTeleportMap.XML", "Panel_Window_MagnusEasyTeleportMap", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Widget/NakMessage/Panel_Widget_Nak_AbyssOne_Skill.XML", "Panel_Widget_Nak_AbyssOneSkill", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  if _ContentsGroup_ArtifactItem == true then
    loadUI("UI_Data/Window/Artifacts/Panel_Window_Artifacts_Exchange_All.xml", "Panel_Window_Artifacts_Exchange_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/Artifacts/Panel_Window_Artifacts_Exchange_LOG_All.xml", "Panel_Window_Artifacts_Exchange_LOG_All", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Event/Panel_Event_SpecialPass_All.XML", "Panel_Event_SpecialPass_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/BossReward/Panel_Widget_BossLooting.XML", "Panel_Widget_BossLooting", UIGroup.PAGameUIGroup_WorldBossLooting)
  basicLoadUI("UI_Data/Widget/BossReward/Panel_Widget_BossReward.XML", "Panel_Widget_BossReward", UIGroup.PAGameUIGroup_WorldBossLooting)
  basicLoadUI("UI_Data/Widget/BossReward/Panel_Widget_Reward.XML", "Panel_Widget_Reward_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  basicLoadUI("UI_Data/Window/Guild/Panel_Window_Guild_Boss_InstanceEnter_Effect.XML", "Panel_Widget_GuildBossField_Enter", UIGroup.PAGameUIGroup_GameSystemMenu)
  if _ContentsGroup_JewelPreset == true then
    loadUI("UI_Data/Window/Socket/Panel_Window_JewelPreset_Inven_All.XML", "Panel_Window_JewelPreset_Inven_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Socket/Panel_Window_JewelPreset_All.XML", "Panel_Window_JewelPreset_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Socket/Panel_Window_JewelPreset_Tooltip_All.XML", "Panel_Window_JewelPreset_Tooltip_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
    basicLoadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_CrystalSet_All.XML", "Panel_Window_MessageBox_CrystalSet_All", UIGroup.PAGameUIGroup_SimpleTooltip)
  end
  basicLoadUI("UI_Data/Widget/Tooltip/Panel_Widget_Tooltip_Servant_All.XML", "Panel_Widget_Tooltip_Servant_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye,
    RenderMode.eRenderMode_SkillWindow
  }))
  basicLoadUI("UI_Data/Window/Common/Panel_Window_Bromide.XML", "Panel_Window_Bromide_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  loadUI("UI_Data/Widget/MorningLand/Panel_Widget_TimeRecordingLog_All.XML", "Panel_TimeLog_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if _ContentsGroup_RoseWar == true then
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Main.XML", "Panel_RoseWar_Main", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_MiniMap.XML", "Panel_RoseWar_MiniMap", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Command.XML", "Panel_RoseWar_Command", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_MiniMapPartyList.XML", "Panel_RoseWar_MiniMapPartyList", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Mission.XML", "Panel_RoseWar_Mission", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_MissionWidget.XML", "Panel_RoseWar_MissionWidget", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_MissionAccept.XML", "Panel_RoseWar_MissionAccept", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Region.XML", "Panel_RoseWar_Region", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Menu.XML", "Panel_RoseWar_Menu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWarMenu
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_EditParty_Drag.XML", "Panel_RoseWar_EditParty_Drag", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWarMenu,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_EditParty.XML", "Panel_RoseWar_EditParty", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWarMenu,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_DeadMessage.XML", "Panel_RoseWar_DeadMessage", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_TeamSkill.XML", "Panel_RoseWar_TeamSkill", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_TeamBuff.XML", "Panel_RoseWar_TeamBuff", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_PartyList.XML", "Panel_RoseWar_PartyList", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_RoseWarMenu
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Nak_WarLog.XML", "Panel_RoseWar_Nak_WarLog", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Nak_WarLog_L.XML", "Panel_RoseWar_Nak_WarLog_L", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_Nak_Teleport.XML", "Panel_RoseWar_Nak_Teleport", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_ScoreBoardWidget.XML", "Panel_RoseWar_ScoreBoardWidget", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_ScoreBoard.XML", "Panel_RoseWar_ScoreBoard", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_RoseWar
    }))
    loadUI("UI_Data/Window/RoseWar/Panel_RoseWar_TeamScoreBoard.XML", "Panel_RoseWar_TeamScoreBoard", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_RoseWarMenu
    }))
  end
  loadUI("UI_Data/Window/Siege/Panel_Window_VillageSiegeMenu_All.XML", "Panel_Window_VillageSiegeMenu_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Siege/Panel_Window_SiegeResult_All.XML", "Panel_Window_SiegeResult_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Siege/Panel_Window_OceanSiegeResult_All.XML", "Panel_Window_OceanSiegeResult_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  basicLoadUI("UI_Data/Window/Siege/Panel_Widget_VillageSiegeState_All.XML", "Panel_Widget_VillageSiegeState_All", UIGroup.PAGameUIGroup_Widget)
  if isGameTypeCH() == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_Addiction_Prevention_All.XML", "Panel_Addiction_Prevention_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
  end
  if _ContentsGroup_MonsterBuffZone == true then
    loadUI("UI_Data/Window/MonsterBuffZone/Panel_Window_MonsterBuffZone.XML", "Panel_Window_MonsterBuffZone", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/MonsterBuffZone/Panel_Window_MonsterBuffZoneItemRepair.XML", "Panel_Window_MonsterBuffZoneItemRepair", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  basicLoadUI("UI_Data/Widget/LifeRingMenu/Panel_Widget_LifeRingMenu_All.XML", "Panel_Widget_LifeRingMenu_All", UIGroup.PAGameUIGroup_GameSystemMenu)
  if _ContentsGroup_DamageConsoleView == true then
    loadUI("UI_Data/Window/Damage/Panel_Window_DamageConsoleView.XML", "Panel_Window_DamageConsoleView", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_MorningLandTierGo == true then
    loadUI("UI_Data/Widget/MorningLand/Panel_Widget_MorningLandSuccessMsg_All.XML", "Panel_MorningLandSuccessMsg_All", UIGroup.PAGameUIGroup_MainUIFront, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Sequence,
      RenderMode.eRenderMode_SequencePlayerControl
    }))
  end
  if _ContentsGroup_ItemSkillOption == true then
    loadUI("UI_Data/Window/Enchant/Panel_Window_ItemSkillOption_All.XML", "Panel_Window_ItemSkillOption_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Dialog_MakeGoonwang_All.XML", "Panel_Window_MakeGoonWang", UIGroup.PAGameUIGroup_MarniWave, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  if _ContentsGroup_MorningLandTierParty == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_MorningBoss_All.XML", "Panel_Window_MessageBoxForSequence_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Window/AutoMove/Panel_Window_AutoMove_Result.XML", "Panel_AutoMove_Result_All", UIGroup.PAGameUIGroup_GameMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/UI_Loading/UI_Loading_Progress.xml", "Panel_Loading", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Loading
  }))
  loadUI("UI_Data/Window/MessageBox/Panel_Window_NetworkAlert_All.XML", "Panel_Window_NetworkAlert_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Widget/Tooltip/Panel_Window_CharacterStat_All.XML", "Panel_Window_CharacterStat_All", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_RedBattleFieldMatching == true then
    basicLoadUI("UI_Data/Widget/LocalWar/Panel_Widget_LocalWar_Match_All.XML", "Panel_Widget_LocalWar_Match_All", UIGroup.PAGameUIGroup_Window_Progress)
    basicLoadUI("UI_Data/Widget/LocalWar/Panel_LocalWar_Match_Confirm_All.XML", "Panel_LocalWar_Match_Confirm_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    loadUI("UI_Data/Window/Inventory/Panel_Window_Notation_Ability_All.XML", "Panel_Notation_Ability", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  if _ContentsGroup_FishingCamp == true then
    basicLoadUI("UI_Data/Widget/Camp/Panel_Window_FishingCamp_All.XML", "Panel_Window_FishingCamp", UIGroup.PAGameUIGroup_Windows)
  end
  loadUI("UI_Data/Window/Edania/Panel_Window_Edania_Contents_All.XML", "Panel_Window_Edania_Contents_All", UIGroup.PAGameUIGroup_DeadMessage, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Edania/Panel_Window_Edania_PVP_HUD.XML", "Panel_Window_Edania_PVP_HUD", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Edania/Panel_Widget_Edania_Countdown.XML", "Panel_Widget_Edania_Countdown", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Edania/Panel_Window_Edania_PVP_Challenger.XML", "Panel_Window_Edania_PVP_Challenger", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Edania/Panel_Window_Edania_Join.XML", "Panel_Window_Edania_Join", UIGroup.PAGameUIGroup_Interaction)
  loadUI("UI_Data/Window/Edania/Panel_Window_Edania_Worldmap_Castle.XML", "Panel_Window_Edania_Worldmap_Castle", UIGroup.PAGameUIGroup_WorldMap_Popups, SETRENDERMODE_BITSET_WORLDMAP())
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_All.XML", "Panel_Window_Journal_All", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_Select_All.XML", "Panel_Window_Journal_Select_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_Page_All.XML", "Panel_Window_Journal_Page_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Window/Achievement/Panel_Window_Journal_Book_All.XML", "Panel_Window_Journal_Book_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  if _ContentsGroup_TotalPreset == true then
    loadUI("UI_Data/Window/PresetTotal/Panel_Window_PresetTotal_All.XML", "Panel_Window_PresetTotal_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/PresetTotal/Panel_Window_PresetTotalMemo_All.XML", "Panel_Window_TotalPresetMemo", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_ReforgeStonePreset == true then
    loadUI("UI_Data/Window/Enchant/Panel_Window_ReforgeStonePreset_All.XML", "Panel_Window_ReforgeStonePreset_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
    loadUI("UI_Data/Window/Enchant/Panel_Window_ReforgePresetNameEdit_All.XML", "Panel_Window_ReforgePresetNameEdit_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_SnowBoardMirrorField == true then
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_SnowBoard_Menu_All.XML", "Panel_Window_SnowBoard_Menu_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_SnowBoard_Result_All.XML", "Panel_Window_SnowBoard_Result_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_SnowBoard_Hud_All.XML", "Panel_Window_SnowBoard_Hud_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
    loadUI("UI_Data/Window/SnowBoard/Panel_Window_MessageBox_SnowBoard.XML", "Panel_Window_MessageBox_SnowBoard", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SnowBoardInMirrorField
    }))
  end
  loadUI("UI_Data/Window/Common/Panel_Widget_Common_Countdown.XML", "Panel_Widget_Common_Countdown", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Replay,
    RenderMode.eRenderMode_SnowBoardInMirrorField
  }))
  if _ContentsGroup_OceanSiege == true then
    loadUI("UI_Data/Widget/SiegeWar/Panel_Widget_OceanSiege_ReturnToSeaport.XML", "Panel_Widget_OceanSiege_ReturnToSeaport", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default
    }))
  end
  if _ContentsGroup_OlviaAcademy == true then
    basicLoadUI("UI_Data/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Alert.XML", "Panel_Window_OlviaAcademy_Alert", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Invitation.XML", "Panel_Window_OlviaAcademy_Invitation", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Main_All.XML", "Panel_Window_OlviaAcademy_Main_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Pass_All.XML", "Panel_Window_OlviaAcademy_Pass_All", UIGroup.PAGameUIGroup_Windows)
  end
end
function loadGameUI_PC()
  if _ContentsGroup_RenewUI then
    runLua("UI_Data/Script/Window/BlackBackground/Panel_Global_BlackBackground.lua")
  end
  runLua("UI_Data/Script/Panel_Ime.lua")
  runLua("UI_Data/Script/Tutorial/Panel_WebControl.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_WebCashPayment.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.lua")
  runLua("UI_Data/Script/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki.lua")
  if _ContentsGroup_ExpirienceWiki_All then
    runLua("UI_Data/Script/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All.lua")
  end
  if true == _ContentsGroup_CouponCode then
    runLua("UI_Data/Script/Window/InWeb/Panel_Window_CouponCode.lua")
  end
  runLua("UI_Data/Script/DragManager.lua")
  runLua("UI_Data/Script/Fullsizemode.lua")
  runLua("UI_Data/Script/globalPreLoadUI.lua")
  runLua("UI_Data/Script/global_fromActionChart_LuaEvent.lua")
  runLua("UI_Data/Script/Widget/GlobalManual/Panel_Global_Manual.lua")
  if true == _ContentsGroup_NewUI_Fishing_All then
    runLua("UI_Data/Script/Widget/Fishing/Panel_Widget_Fishing_All.lua")
  else
    runLua("UI_Data/Script/Widget/Fishing/Panel_Fishing.lua")
  end
  runLua("UI_Data/Script/Widget/Fishing/Panel_Widget_FishingEventIcon.lua")
  if true == _ContentsGroup_NewUI_ButtonShortcuts_All then
    runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_Window_ButtonShortcuts_All.lua")
  else
    runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_ButtonShortcuts.lua")
  end
  if _ContentsGroup_WorldmapButtonShortcuts == true then
    runLua("UI_Data/Script/Window/ButtonShortcuts/Panel_Window_WorldmapButtonShortcuts_All.lua")
  end
  runLua("UI_Data/Script/Window/FirstLogin/Panel_FirstLogin.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_Reconnect.lua")
  runLua("UI_Data/Script/NpcWorker/workerLuaWrapper.lua")
  runLua("UI_Data/Script/Widget/Radar/Radar_GlobalValue.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfo_All.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/Panel_GuildWarInfoSmall_All.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/PAnel_GuildWarScore_All.lua")
  runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_GuildWarAlert_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildWareHouseHistory.lua")
  runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouseHistory.lua")
  runLua("UI_Data/Script/Window/Guild/PersonalBattle/Panel_Window_PersonalBattle.lua")
  runLua("UI_Data/Script/Window/GuildWarInfo/Panel_Window_SiegeSummon.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_House_Auction.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_Detail_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_GuildHouse_Auction_Bid_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_TerritoryAuthority_Auction.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Window_WorkerAuction_All.lua")
  runLua("UI_Data/Script/Widget/Tooltip/Panel_WorkerSkillTooltip_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Villa_Auction.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_All.lua")
  runLua("UI_Data/Script/Window/Auction/Panel_Masterpiece_Auction_Bid_All.lua")
  runLua("UI_Data/Script/Window/ChangeNickName/Panel_Change_Nickname_All.lua")
  runLua("UI_Data/Script/Window/ChangeNickName/Panel_ExchangeNickname.lua")
  runLua("UI_Data/Script/Common/Common_UIMode.lua")
  runLua("UI_Data/Script/Common/Common_BlackSpirit.lua")
  runLua("UI_Data/Script/Common/Common_Web.lua")
  runLua("UI_Data/Script/Window/LordMenu/Panel_Window_LordMenu_All.lua")
  runLua("UI_Data/Script/Window/NodeWarMenu/Panel_NodeWarMenu.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_Warcall_Castle.lua")
  runLua("UI_Data/Script/Widget/FieldViewMode/FieldViewMode.lua")
  runLua("UI_Data/Script/Widget/Chatting/Notice/Panel_Important_Notice.lua")
  runLua("UI_Data/Script/Widget/Chatting/ChatMain/Panel_Widget_ChatMain.lua")
  runLua("UI_Data/Script/Widget/Chatting/ChatSubMenu/Panel_Widget_ChatSubMenu.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Input.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_ChatOption.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Filter.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Macro.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_SocialAction.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chat_Emoticon.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Color.lua")
  if true == _ContentsGroup_ChatOption_All then
    runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChatOption_All.lua")
    runLua("UI_Data/Script/Widget/Chatting/Panel_Window_Chatting_Color_All.lua")
  end
  if true == _ContentsGroup_ChannelChat then
    runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat.lua")
    runLua("UI_Data/Script/Widget/Chatting/Panel_Widget_ChannelChat_Loading.lua")
  end
  runLua("UI_Data/Script/Window/Report/Panel_Window_Chat_Report_All.lua")
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill.lua")
  else
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SkillGroup.lua")
  end
  if true == _ContentsGroup_NewUI_Tooltip_All then
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Control_All.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Item_All.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Item_Equip_All.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Item_LinkedItem_All.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Item_LinkedClickItem_All.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Skill_Servant_All.lua")
  else
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Item.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill_Servant.lua")
  end
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Actor_All.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Guild_Introduce.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Common.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Work.lua")
  runLua("UI_Data/Script/Widget/Introduction/Panel_Introduction.lua")
  runLua("UI_Data/Script/Widget/Menu/Panel_Menu.lua")
  runLua("UI_Data/Script/Widget/Menu/Panel_Widget_Menu_Remake.lua")
  runLua("UI_Data/Script/Widget/SkillLog/Widget_SkillLog.lua")
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_Sequence.lua")
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage_Renewel.lua")
  runLua("UI_Data/Script/Widget/Stamina/Stamina.lua")
  runLua("UI_Data/Script/Widget/Stamina/Panel_Widget_Stamina_Auto_All.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire_QuestDirect.lua")
  runLua("UI_Data/Script/Widget/Region/Region.lua")
  runLua("UI_Data/Script/Widget/Acquire/Alert_QuestDirect.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_Window_SpiritEnchant_All.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_OtherUser_AdditionalRate_All.lua")
  if true == _ContentsGroup_EnchantRemaster then
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_Enchant_Main_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Equip_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_Material_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantProtector_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantStack_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_Enchant_StackExtraction_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantMessage_All.lua")
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_EnchantInventory_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Enchant_Console_KeyGuide_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_ValksList_All.lua")
  end
  if true == _ContentsGroup_EnchantRenewer then
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_AddStack_All.lua")
  end
  runLua("UI_Data/Script/Window/Enchant/Panel_Window_EnchantStackConfirm_All.lua")
  runLua("UI_Data/Script/Window/ItemBox/Panel_Window_MessageBox_Edit_All.lua")
  if true == _ContentsGroup_SpiritGroupEnchant then
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_PartyEnchant_Member_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_PartyEnchant_BubbleText_All.lua")
  end
  runLua("UI_Data/Script/Window/Enchant/Panel_Window_BeginnerEnchantGuide_All.lua")
  runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_OTPConfirm_All.lua")
  if true == _ContentsGroup_FamilyStack then
    runLua("UI_Data/Script/Window/Enchant/Panel_Widget_StackStorage_All.lua")
  end
  runLua("UI_Data/Script/Window/Socket/Panel_Window_Socket_All.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_Improvement_All.lua")
  runLua("UI_Data/Script/Window/Enchant/Panel_BonusEnchant.lua")
  runLua("UI_Data/Script/Window/DeadMessage/Panel_Window_DeadMessage_All.lua")
  runLua("UI_Data/Script/Window/DeadMessage/Panel_Cash_Revival_BuyItem_All.lua")
  if true == _ContentsGroup_BatchSummonMonsterByItem then
    runLua("UI_Data/Script/Widget/Party/Panel_BatchSummonMonster.lua")
  end
  if true == _ContentsGroup_NewUI_Looting then
    runLua("UI_Data/Script/Window/Looting/Panel_Window_Looting_All.lua")
  else
    runLua("UI_Data/Script/Window/Looting/Panel_Looting.lua")
  end
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Basic_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Life_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Title_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_History_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_FootPrint_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_Challenge_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_CashBuff_All.lua")
  if _ContentsGroup_BuffDetailBoard == true then
    runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_CharacterInfo_BuffDetail_All.lua")
  end
  if true == _ContentsGroup_NewUI_Equipment_All then
    runLua("UI_Data/Script/Window/Equipment/Panel_Window_Equipment_All.lua")
  else
    runLua("UI_Data/Script/Window/Equipment/Panel_Window_Equiment.lua")
  end
  if true == _ContentsGroup_Season_EquipmentUpgrade then
    runLua("UI_Data/Script/Window/Equipment/Panel_Window_Season_Equipment_Upgrade_All.lua")
  end
  runLua("UI_Data/Script/Window/Equipment/Panel_Widget_GotoShop_Banner_All.lua")
  if _ContentsGroup_AccessoryStepUp == true then
    runLua("UI_Data/Script/Window/Equipment/Panel_Window_Accessory_StepUp_All.lua")
    runLua("UI_Data/Script/Widget/NakMessage/Panel_Widget_Nak_AccessoryStepUp_All.lua")
  end
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_Inventory_AutoSortFunction.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_Inventory_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_TrashBoxConfirm_All.lua")
  if false == _ContentsGroup_NewUI_ClothInventory_All then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory.lua")
  else
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_All.lua")
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_ClothInventory_Renew_All.lua")
  end
  if _ContentsGroup_PearlBoxWebBuy == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_WebPurchaseConfirm_All.lua")
  end
  if _ContentsGroup_OneButtonBuff == true then
    runLua("UI_Data/Script/Window/AutoBuff/Panel_Window_AutoUseBuffItem.lua")
  end
  if true == _ContentsGroup_FamilyInventory then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_FamilyInventory_All.lua")
  end
  if _ContentsGroup_StaticSlot == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_NewbieInventory_StaticSlot_All.lua")
  else
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_NewbieInventory_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_SeasonItem_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_SimpleInventory_SearchResult.lua")
  if true == _ContentsGroup_DuelCharacterCopyEquip then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Equip_CharacterTag_ItemCopy_All.lua")
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_DescBox_ItemCopy_All.lua")
  end
  runLua("UI_Data/Script/Widget/Popup/Panel_Popup_MoveItem.lua")
  runLua("UI_Data/Script/Window/Equipment/Panel_Equiment_SetEffectTooltip.lua")
  runLua("UI_Data/Script/Window/Equipment/Panel_Equiment_CrystalTooltip.lua")
  runLua("UI_Data/Script/Window/Equipment/Panel_Equiment_ArtifactsTooltip.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_UseItem_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_ImperialSupply_Horse_Confirm.lua")
  runLua("UI_Data/Script/Window/ExtendExpiration/Panel_ExtendExpiration.lua")
  runLua("UI_Data/Script/Widget/UIcontrolBar/Panel_WhereUseItemDirection.lua")
  runLua("UI_Data/Script/Window/LifeRanking/Panel_LifeRanking_All.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_Enter.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_WeaponChange.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_NakClear.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_RegionChange.lua")
  runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_MapSelecter.lua")
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_AtoraxionBoss) and true == _ContentsGroup_AtoraxionSea then
    runLua("UI_Data/Script/Window/Movie/Panel_AtoraxionMovie.lua")
  end
  if true == _ContentsGroup_AtoraxionDesert then
    runLua("UI_Data/Script/Window/Atoraxion/Panel_Atoraxion_RegionInfo.lua")
  end
  if true == _ContentsGroup_InstanceHorseRacing then
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Match_Confirm.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Enter.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Waiting.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_CountDown.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_PlayTime.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_CheckPoint.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Waiting_Nak.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Starting_Nak.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_KeyGuide.lua")
    runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_HelpIcon.lua")
  end
  if true == _ContentsGroup_InstanceFreeBatttleField then
    runLua("UI_Data/Script/Window/InstanceField/Panel_FreeBattleField_All.lua")
  end
  if true == _ContentsGroup_DragonPalace then
    runLua("UI_Data/Script/Window/InstanceField/Panel_DragonPalace_Match_All.lua")
  end
  if _ContentsGroup_RedBattleFieldMatching == true then
    runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All.lua")
    runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarTeam_SetVoiceChat_All.lua")
  elseif true == _ContentsGroup_InstanceLocalWar then
    runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarInfo_All_New.lua")
    runLua("UI_Data/Script/Window/LocalWar/Panel_LocalWarTeam_SetVoiceChat_All.lua")
  end
  runLua("UI_Data/Script/Window/CompetitionGame/Panel_CompetitionGame.lua")
  runLua("UI_Data/Script/Window/Match/Panel_MatchingSystem.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Matching.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_MatchConfirm.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Ranking.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_EquipPresetList.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_OtherInfo.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Hud.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_PlayerStatus.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_Match_Score.lua")
  if _ContentsGroup_SolareReplay == true then
    runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_ReplayList.lua")
    runLua("UI_Data/Script/Window/Replay/Panel_Window_InstanceContentsReplayDownloadWeb.lua")
  end
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch.lua")
  runLua("UI_Data/Script/Window/Solrare/Panel_Solrare_CustomMatch_Invite.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_Reservation_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Hud_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_Func_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_InviteList_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamNameChange_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_TeamChange_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Window_Arsha_SelectMember_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Party_All.lua")
  runLua("UI_Data/Script/Window/Arsha/NewUI/Panel_Widget_Arsha_Replay_Party_All.lua")
  runLua("UI_Data/Script/Window/Arsha/Panel_Arsha_ApplyWeb_All.lua")
  runLua("UI_Data/Script/Window/Arsha/Panel_Widget_Arsha_Replay_All.lua")
  runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayInMirrorField_All.lua")
  runLua("UI_Data/Script/Window/Recommand/Panel_RecommandName.lua")
  runLua("UI_Data/Script/Window/Steam/Panel_Window_Steam.lua")
  runLua("UI_Data/Script/Window/DailyStamp/Panel_Window_DailyStamp_All.lua")
  runLua("UI_Data/Script/Window/DailyStamp/Panel_Window_Daily_Reward_Notice_All.lua")
  runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_BlackSpiritAdventure.lua")
  runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_BlackSpiritAdventure_VerPcroom.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_AbyssOne_Help.lua")
  if _ContentsGroup_MagnusEasyTeleport == true then
    runLua("UI_Data/Script/Window/Quest/Panel_Window_MagnusEasyTeleportMap.lua")
  end
  runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_EventMarbleGame.lua")
  runLua("UI_Data/Script/Window/Copyright/Panel_Copyright.lua")
  runLua("UI_Data/Script/Window/Policy/Panel_Window_Policy.lua")
  runLua("UI_Data/Script/Window/Twitch/Panel_Twitch.lua")
  runLua("UI_Data/Script/Window/SaveSetting/Panel_SaveSetting.lua")
  runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Succession.lua")
  runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Awaken.lua")
  if false == _ContentsGroup_UISkillGroupTreeLayOut then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Global.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Event.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Combination.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Animation.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_EnableSkill.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_CoolTimeSlot.lua")
  else
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Controller.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_QuickSlot.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_CoolTimeSlot.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType.lua")
    if _ContentsGroup_ShowOtherClassSkill == true then
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_All.lua")
      runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_ShowAllClasses_All.lua")
    else
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup.lua")
    end
  end
  if true == _ContentsGroup_SkillFilter then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillFilter_All.lua")
  end
  if true == _ContentsGroup_SkillPreset then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPreset.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPresetMemo.lua")
  end
  if true == GlobalSwitch_UseDummyPlayerSkillWindow then
    runLua("UI_Data/Script/Window/Skill/Test_SkillView_Control.lua")
  end
  runLua("UI_Data/Script/Window/SkillAwaken/Panel_Window_SkillAwaken.lua")
  runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGuide.lua")
  if true == _ContentsGroup_NewUI_ReinforceSkill_All then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_ReinforceSkill_All.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Reinforce_All.lua")
  else
    runLua("UI_Data/Script/Window/Skill/Panel_Window_ReinforceSkill.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Reinforce.lua")
  end
  if true == _ContentsGroup_NewUI_BlackSpiritSkillLock_All then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All.lua")
  else
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock.lua")
  end
  runLua("UI_Data/Script/Window/WareHouse/Panel_Window_WareHouse_All.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_TotalSearch.lua")
  runLua("UI_Data/Script/Window/ExplorePointUsingInfo/Panel_Window_ExplorePoint_UsingInfo.lua")
  if true == _ContentsGroup_CargoSell then
    runLua("UI_Data/Script/Window/Servant/Panel_Window_CargoSell.lua")
  end
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantFunction_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantInfo_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantLookChange_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_PremiumLookChange.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantRegist_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSwiftTraining_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantExchange_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantMarket_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantNameRegist_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantMarket_Rental_Mating_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantCarriageLink_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSkillManagement_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Window_ServantRateDesc.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSwiftResult_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantOnlyList_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantExchange_Fantasy_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySelect_All.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantTransferBackwordList_All.lua")
  if _ContentsGroup_HorseSimulator == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSimulator.lua")
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantSimulatorSubView.lua")
  end
  if _ContentsGroup_Crogdalo == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Window_CrogdaloStable.lua")
  end
  if _ContentsGroup_FantasyHorse == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_Servant_FantasySkin_All.lua")
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Widget_Servant_FantasySkin_Complete_All.lua")
  end
  if _ContentsGroup_ServantLevelDown == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_HorseLevelDecrease_All.lua")
  end
  if _ContentsGroup_ServantLevelUpRenewal == true then
    runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Dialog_ServantLvUpMessageBox_All.lua")
  end
  runLua("UI_Data/Script/Window/Servant/Panel_Window_VehicleInfo_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_LinkedSkill_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantInfo_Ship.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantInfo_WorkerShip.lua")
  runLua("UI_Data/Script/Window/Servant/HorseMp.lua")
  runLua("UI_Data/Script/Window/Servant/HorseHp.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_HorseSubMp_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Widget_ServantSummonBoss.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_ServantInventory.lua")
  runLua("UI_Data/Script/Window/Servant/NewUI/Panel_Window_GuildStableList_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_GuildServant_RevivalList.lua")
  if _ContentsGroup_LifeSimulator == true then
    runLua("UI_Data/Script/Window/Alchemy/Panel_Alchemy_RateViewList.lua")
  end
  runLua("UI_Data/Script/Widget/Housing/Panel_HousingList.lua")
  if _ContentsGroup_HarvestList_All then
    runLua("UI_Data/Script/Widget/Housing/Panel_HarvestList_All.lua")
  else
    runLua("UI_Data/Script/Widget/Housing/Panel_HarvestList.lua")
  end
  runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidList_All.lua")
  if _ContentsGroup_MaidActorSystem == true then
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorList_All.lua")
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorRegist_All.lua")
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_MaidActorChangeCloth_All.lua")
    runLua("UI_Data/Script/Widget/Maid/Panel_Window_ChangeMaidActorName_All.lua")
  end
  runLua("UI_Data/Script/Window/CharacterTag/Panel_Window_CharacterTag_All.lua")
  runLua("UI_Data/Script/Window/CharacterTag/Panel_Icon_CharacterTag.lua")
  if true == _ContentsGroup_NewUI_Camp_All then
    runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_All.lua")
    runLua("UI_Data/Script/Widget/Camp/Panel_Window_CampWarehouse_All.lua")
    runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp_VillaBuff_All.lua")
  else
    runLua("UI_Data/Script/Widget/Camp/Panel_Window_Camp.lua")
    runLua("UI_Data/Script/Window/BuildingBuff/Panel_Window_BuildingBuff.lua")
  end
  runLua("UI_Data/Script/Widget/Camp/Panel_Window_CampRegister.lua")
  runLua("UI_Data/Script/Widget/PvP/PvP_Battle.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetRegister_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetList_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetInfo_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetLookChange_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetFusion_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Widget_PetControl_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetGroup_Edit_All.lua")
  runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkillChange_All.lua")
  if true == _ContentsGroup_PetSkillPercent then
    runLua("UI_Data/Script/Window/PetInfo/Panel_Window_PetSkill_Percent_All.lua")
  end
  if true == _ContentsGroup_isFairy then
    if true == _ContentsGroup_NewUI_Fairy_All then
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_Fairy_All.lua")
      if true == _ContentsGroup_FairyLookChange then
        runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkinChange_All.lua")
      end
    else
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyRegister.lua")
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySetting_ReNew.lua")
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyUpgrade.lua")
      if _ContentsGroup_FairyTierUpgradeAndRebirth then
        runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyTierUpgrade.lua")
      end
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Fairyinfo.lua")
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyChoiseTheReset.lua")
      runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkill.lua")
      if true == _ContentsGroup_FairyLookChange then
        runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairySkinChange_All.lua")
      end
    end
  end
  runLua("UI_Data/Script/Window/Servant/Panel_Cannon.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_CannonShip.lua")
  runLua("UI_Data/Script/Widget/QuestList/Panel_NewQuest.lua")
  runLua("UI_Data/Script/Widget/UIControlBar/Panel_UIControl.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_QuickSlot.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_NewQuickSlot.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_SkillCooltime.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_Window_ReplaySkillCooltime_All.lua")
  runLua("UI_Data/Script/Widget/QuickSlot/Panel_SkillcoolTimeQuickSlot.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_MainStatus_User_Bar.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_SelfPlayerExpGage.lua")
  runLua("UI_Data/Script/Widget/MainStatus/PvpMode_Button.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_ClassResource.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Adrenallin.lua")
  if true == _ContentsGroup_RemasterUI_Main then
    runLua("UI_Data/Script/Widget/MainStatus/Panel_MainStatus_Remaster.lua")
  end
  runLua("UI_Data/Script/Widget/MainStatus/Panel_GuardGauge.lua")
  if true == _ContentsGroup_RemasterUI_Main then
    runLua("UI_Data/Script/Widget/MainStatus/Panel_PersonalIcon_Left_Remaster.lua")
  else
    runLua("UI_Data/Script/Widget/MainStatus/Panel_PersonalIcon_Left.lua")
  end
  if _ContentsGroup_FeverBuff then
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGauge.lua")
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_AgrisGaugeTooltip.lua")
  end
  if _ContentsGroup_LandscapePainting then
    runLua("UI_Data/Script/Window/DropItem/Panel_Window_LandscapePaintingDrop_All.lua")
  end
  if _ContentsGroup_PalaceManagement then
    runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Map_All.lua")
    runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Node_All.lua")
    runLua("UI_Data/Script/Window/PalaceManagement/Panel_Window_PalaceManagement_Worker_All.lua")
  end
  if true == _ContentsGroup_HopeGauge then
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGauge.lua")
    runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_HopeGaugeOnOff.lua")
  end
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_GoldenBell.lua")
  if _ContentsGroup_NewVoiceChat == true then
    runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_Setting_New_All.lua")
    runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_List_New.lua")
    runLua("UI_Data/Script/Window/voiceChat/Panel_VoiceChat_Talker_New.lua")
  else
    runLua("UI_Data/Script/Widget/RightTopIcons/Panel_Window_PersonalIcon_SetVoiceChat_All.lua")
  end
  runLua("UI_Data/Script/Widget/RightTopIcons/Panel_PersonalIcon_AutoTraining_Alarm.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Panel_PersonalIcon_AutoTraining2.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_Widget_TownSimpleNavi_All.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/Renewal/Panel_Widget_FunctionButton.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_PersonalIcon_NpcNavi_All.lua")
  runLua("UI_Data/Script/Widget/RightTopIcons/NewUI/Panel_Tooltip_NpcNavigation_All.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Window_BlackspiritPass.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackspiritPass.lua")
  runLua("UI_Data/Script/Window/Season/Panel_Tooltip_BlackSpiritPassQuest.lua")
  runLua("UI_Data/Script/Window/BeginnerRoadMap/Panel_Window_BeginnerRoadMap.lua")
  runLua("UI_Data/Script/Window/DropItem/Panel_Window_RenewDropItem_All.lua")
  runLua("UI_Data/Script/Window/DropItem/Panel_Window_DropItem_ImageTooltip_All.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/NoticeAlert.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/InstanceNoticeAlert.lua")
  runLua("UI_Data/Script/Widget/Damage/UI_Lua_Damage.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterNameTag.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_BubbleBox.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_WaitComment.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Navigation.lua")
  runLua("UI_Data/Script/Widget/HumanRelations/HumanRelations.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterActionStatus.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Actor_DummyCharacter_CC.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_Actor_SolareBuffStateUI.lua")
  runLua("UI_Data/Script/Window/Keypad/Panel_Window_NumberPad_All.lua")
  runLua("UI_Data/Script/Window/Keypad/Panel_Window_UseCharacterWp_All.lua")
  runLua("UI_Data/Script/Window/BuyDrink/Panel_BuyDrink.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Exchange_Item.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Scene.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_DetectPlayer.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ButtonType.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_KnowledgeManagement.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Reward.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Main_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Simple_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Simple_Desc_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Intimacy_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_InterestKnowledge_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Quest_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialogue_Itemtake_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ExchangeList_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/DialogKeybinderManager_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_PetLeader_List_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_HorseWithoutOwner_All.lua")
  runLua("UI_Data/Script/Widget/ItemLog/Panel_Widget_QuestRewardItem.lua")
  runLua("UI_Data/Script/Window/WokerHire/Panel_Window_WorkerRandomSelect_All.lua")
  runLua("UI_Data/Script/Window/WokerHire/Panel_Window_WorkerRandomSelectOption_All.lua")
  runLua("UI_Data/Script/Window/RandomShop/Panel_Window_RandomShop_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_GuildQuest_Reward.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NPCShop_All.lua")
  runLua("UI_Data/Script/Widget/HelpMessage/Panel_HelpMessage.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_MentalKnowledge_Base.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_MentalGame_All.lua")
  runLua("UI_Data/Script/Window/Knowledge/Panel_Knowledge_Main.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_IntroMovie.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_DialogMovie.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieTheater_320.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieTheater_640.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieTheater_LowLevel.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieTheater_SkillGuide_640.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieGuide_Web.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieGuide_Weblist.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieSkillGuide_Web.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieSkillGuide_Weblist.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieWorldMapGuide_Web.lua")
  runLua("UI_Data/Script/Widget/Buff/Panel_AppliedBuffList.lua")
  if true == _ContentsGroup_Tutorial_Renewal then
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiBlackSpirit_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiGuideButton_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiHeadlineMessage_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiMasking_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UISmallBlackSpirit.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Panel_Tutorial_UiManager_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Manager.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_EventList.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase1_BaiscMove_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase2_BasicControl_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase3_InteractionSupplyBox_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase4_InventoryAndQuickSlot_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase5_CallBlackSpirit_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase8_BaiscMove.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase9_SnowMountainBasicMove.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_BladeMasterWomen_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Warrior_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Ranger_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_RangerMan_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Sorcerer_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Giant_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Tamer_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_BladeMaster_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Valkyrie_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_WizardWomen_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Wizard_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_NinjaWomen_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_NinjaMan_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_DarkElf_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Combattant_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_CombattantWomen_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_Ran_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_LocalHost_Renewal.lua")
    runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_BasicSkill_7Layer_Renewal.lua")
  else
    runLua("UI_Data/Script/Tutorial/Tutorial_Manager.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_EventList.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase1_BasicMove.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase2_BasicControl.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase3_InteractionSupplyBox.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase4_InventoryAndQuickSlot.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase5_CallBlackSpirit.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_BladeMasterWomen.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Warrior.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Ranger.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_RangerMan.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Sorcerer.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Giant.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Tamer.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_BladeMaster.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Valkyrie.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_WizardWomen.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Wizard.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_NinjaWomen.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_NinjaMan.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_DarkElf.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Combattant.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_CombattantWomen.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_Ran.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_LocalHost.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase_BasicSkill_7Layer.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase7_FindRequestTarget.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase8_WesternGuardCamp.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase9_AncientStoneChamber.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase10_WorldmapNodeAndNavi.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase11_WorldmapBuyHouse.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase12_WorldmapMenu.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase13_Hidel_FindNearNpc.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase14_Hidel_Trade.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase15_Hidel_Worker.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase16_NewItemEquip.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase17_ItemSell.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase18_Enchant.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase19_ExtractionEnchantStone.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase20_WallRiding.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase21_ItemSellPractice.lua")
    runLua("UI_Data/Script/Tutorial/Tutorial_Phase22_EnchantStack.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Tutorial_UiBlackSpirit.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Tutorial_UiHeadlineMessage.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Tutorial_UiKeyButton.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Tutorial_UiMasking.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Tutorial_UiManager.lua")
    runLua("UI_Data/Script/Widget/Tutorial/Panel_TutorialMenu.lua")
  end
  runLua("UI_Data/Script/Widget/Tutorial/Panel_Movie_KeyViewer.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/ArousalTutorial_Manager.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiManager.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiBlackSpirit.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiHeadlineMessage.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_ArousalTutorial_UiKeyButton.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/SummonBossTutorial_Manager.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_SummonBossTutorial_UiManager.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_SummonBossTutorial_UiBlackSpirit.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_SummonBossTutorial_UiHeadlineMessage.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_SummonBossTutorial_UiKeyButton.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_LifeTutorial.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/ValuePackageTutorial_Manager.lua")
  if false == _ContentsGroup_RemasterUI_QuestWidget then
    runLua("UI_Data/Script/Widget/QuestList/Panel_LatestQuest.lua")
    runLua("UI_Data/Script/Widget/QuestList/Panel_MainQuest.lua")
    runLua("UI_Data/Script/Widget/QuestList/Panel_CheckedQuest.lua")
  else
    runLua("UI_Data/Script/Widget/QuestList/Panel_Widget_MainQuest.lua")
    runLua("UI_Data/Script/Widget/QuestList/Panel_Widget_CheckedQuest.lua")
  end
  if _ContentsGroup_HardCoreChannel == true then
    runLua("UI_Data/Script/Window/HardCore/HardCoreChannel_UIController.lua")
  end
  if ToClient_HardCoreChannelWithContensOption() == true then
    runLua("UI_Data/Script/Widget/HardCore/Panel_HardCoreMenu.lua")
    runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_All.lua")
    runLua("UI_Data/Script/Window/HardCore/Panel_CharacterInfo_HardCore_Basic_All.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Quest_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_LeftTime_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Result_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Compass_Hardcore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_Ranking_Hardcore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Window_Quest_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_EnemyAlert_HardCore.lua")
    runLua("UI_Data/Script/Widget/HardCore/Panel_Widget_HardCoreBlackField_Enter_All.lua")
  end
  if true == _ContentsGroup_ConsoleGetItemForPC then
    runLua("UI_Data/Script/Widget/itemLog/Panel_Widget_ItemLog_Renew.lua")
  end
  runLua("UI_Data/Script/Widget/Party/Panel_PartyCombat.lua")
  runLua("UI_Data/Script/Widget/Party/Panel_Widget_Party_All_New.lua")
  runLua("UI_Data/Script/Widget/Party/Panel_Widget_Raid_All.lua")
  runLua("UI_Data/Script/Widget/Party/Panel_PartyContentsRecurit.lua")
  runLua("UI_Data/Script/Widget/Party/Panel_PartyItemList.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_All.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_InformationView_New.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_CarriageInformation_New.lua")
  if _ContentsGroup_FishingEncyclopedia == true then
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_Renewal_All.lua")
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_EncyclopediaNotice.lua")
  else
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishEncyclopedia_All.lua")
  end
  if _ContentsGroup_FishCompetition == true then
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetition.lua")
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionMyReward.lua")
    runLua("UI_Data/Script/Window/WorldMap/FishEncyclopedia/Panel_Window_FishCompetitionRewardInfo.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_Window_ClanList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMain_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildInfo_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_History_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_BossSummon_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildDeclareWar_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIntroduce_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfare_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWarfareNew_All.lua")
  if _ContentsGroup_GuildQuestAndSkillImprove == true then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestList_All.lua")
  else
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuest_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildQuestInfo_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_Manufacture_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Guild_ManufactureSelect_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAlliance_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceInvite_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildAllianceList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildSkill_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMemberList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_All.lua")
  if _ContentsGroup_GuildMatch == true then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_Score_All.lua")
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_GameRecord.lua")
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildMatch_CountDown.lua")
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMatch_Rank.lua")
    runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_KillCombo.lua")
  end
  runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_GuildItemShareMessage.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildAttributeReport_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_List_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildActivityFunds_Option_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildDocumentManagement_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildIncentiveSetting_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildMemberPointDetail_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointOption_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_Window_GuildPointMenu_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_SelectGuildMansion_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildPresent_All.lua")
  if true == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildJoinRequest_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildVolunteerList_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentive_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildIncentiveOption_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildWebInfo_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildUseFunds_All.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildDeposit_All.lua")
  if true == _ContentsGroup_GuildReward then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildReward_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_Window_MiningFuel_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildLoadManager.lua")
  runLua("UI_Data/Script/Window/Guild/Frame_Guild_List.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Guild_InvitationGuildAlliance.lua")
  if true == ToClient_IsDevelopment() then
    runLua("UI_Data/Script/Window/JobInfoReqForDev/Panel_JobInfoCreate.lua")
    runLua("UI_Data/Script/Window/JobInfoReqForDev/Panel_JobInfoFunc.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_GuildBattle_Control.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_GuildBattle_JoinMember.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_GuildBattle_Point.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_GuildBattle_SelectAttend.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_GuildBattle_SelectEntry.lua")
  runLua("UI_Data/Script/Window/Color/Panel_GuildWar_Color_All.lua")
  runLua("UI_Data/Script/Window/Color/Panel_GuildWar_ColorList_All.lua")
  if false == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/Frame_Guild_Recruitment.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Frame_Guild_CraftInfo.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_GuildDuel.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatNew_All.lua")
  runLua("UI_Data/Script/Window/CharacterInfo/NewUI/Panel_Window_StatDetail_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_CreateClan_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Guild_Create_All.lua")
  if _ContentsGroup_GuildAuthoritySeparation == true then
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_Authorization_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_AgreementGuild.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_AgreementGuild_Master.lua")
  if true == _ContentsGroup_NewGuildNone then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_SimpleInvite.lua")
    runLua("UI_Data/Script/Window/Guild/Panel_GuildInvite_Alert.lua")
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_InviteList.lua")
  end
  if __Guild_LimitPrice then
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_SetFundsList.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_GuildRank.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Guild_ChoiseTheMoney.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Guild_GetDailyPay.lua")
  if true == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_NoneGuild.lua")
    if true == _ContentsGroup_NewGuildNone then
      runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildIntroduceMySelf_All.lua")
    end
  else
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_NoneJoinMember.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_GuildList_SetAttendanceWar.lua")
  runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildRegistSoldier_All.lua")
  if true == _ContentsGroup_Guild_JoinRequest then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildJoinRequestSet.lua")
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildApplyJoinList.lua")
  end
  if true == _ContentsGroup_GuildServerWar then
    runLua("UI_Data/Script/Window/Guild/Panel_Window_GuildMainServerSet.lua")
  end
  runLua("UI_Data/Script/Widget/LevelUpMessage/Panel_Levelup_Reward.lua")
  if true == _ContentsGroup_NewUI_LevelupInfo_All then
    runLua("UI_Data/Script/Window/LevelupInfo/Panel_Window_LevelUp_Info_All.lua")
  else
    runLua("UI_Data/Script/Window/LevelupInfo/Panel_Levelup_Info.lua")
  end
  runLua("UI_Data/Script/Widget/FadeScreen/Panel_Fade_Screen.lua")
  runLua("UI_Data/Script/Widget/FadeScreen/Panel_FullScreenFade.lua")
  runLua("UI_Data/Script/Widget/FadeScreen/Common_FadeOut.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction_FriendHouseList.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction_HouseRank.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_WatchingMode.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_CommandGuide.lua")
  runLua("UI_Data/Script/Widget/Interaction/UI_Character_InterActionGathering_All.lua")
  runLua("UI_Data/Script/Widget/Housing/Panel_Housing.lua")
  runLua("UI_Data/Script/Widget/Housing/AlertInstallation.lua")
  runLua("UI_Data/Script/Window/HouseInfo/Panel_House_SellBuy_Condition.lua")
  runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_VillageTentPopUp.lua")
  if true == _ContentsGroup_NewUI_InstallMode_All then
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_List_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_ObjectControl_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_SeedList_All.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_Housing_FarmInfo_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_WarInfomation_All.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_House_Name_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_War_All.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_KeyGuide_All.lua")
  else
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_New.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_Cart_New.lua")
    runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_ObjectControl.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_InstallationMode_FarmGuide.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_Housing_FarmInfo.lua")
    runLua("UI_Data/Script/Widget/Housing/Panel_HouseName.lua")
  end
  runLua("UI_Data/Script/Window/HouseInfo/Panel_New_HouseControl.lua")
  runLua("UI_Data/Script/Widget/ProgressBar/Panel_ProgressBar.lua")
  if not _ContentsGroup_RemasterUI_MonsterHpBar then
    runLua("UI_Data/Script/Widget/EnemyGauge/Panel_RecentTargetInfo.lua")
  else
    runLua("UI_Data/Script/Widget/EnemyGauge/Panel_Widget_EnemyGauge_New.lua")
  end
  runLua("UI_Data/Script/Window/Exchange/Panel_ExchangeWithPC.lua")
  if _ContentsGroup_ExchangeCoinSystem == true then
    runLua("UI_Data/Script/Window/Exchange/Panel_ExchangeCoin_All.lua")
  end
  if true == _ContentsGroup_OceanCurrent then
    runLua("UI_Data/Script/Window/Servant/ShipEquipManagement/Panel_Window_ShipEquipManagement_ALL.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_Barter.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoRefresh.lua")
    runLua("UI_Data/Script/Window/Exchange/Panel_Window_BarterInfoSearch_Special.lua")
    runLua("UI_Data/Script/Widget/GreatSea/Panel_Window_Anchor.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_OceanGuide.lua")
    runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorManager_All.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_All.lua")
    runLua("UI_Data/Script/Window/Servant/CargoLoading/Panel_Window_CargoLoading_ALL.lua")
    runLua("UI_Data/Script/Widget/GreatSea/Panel_Widget_GreatSeaEvent.lua")
    runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Employee_HireItem_All.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_ShipSpeedGauge_All.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgrade_Tree.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantUpgradeInfo.lua")
    runLua("UI_Data/Script/Window/Servant/ShipCannon/Panel_Widget_ShipCannon.lua")
    runLua("UI_Data/Script/Window/Common/Panel_Window_ItemFilter_All.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_SailControl.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyBoost.lua")
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_GalleyMember.lua")
    if _ContentsGroup_EmployeePresetJob == true then
      runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPresetManager_All.lua")
      runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPresetGroup_All.lua")
      runLua("UI_Data/Script/Window/Servant/Panel_Window_ShipInfo_Renewal_All.lua")
      runLua("UI_Data/Script/Window/Sailor/Panel_Window_SailorPreset_NameEdit_All.lua")
      if _ContentsGroup_EmployeeAutoFishingDiscard == true then
        runLua("UI_Data/Script/Window/Servant/Panel_Widget_Sailor_AutoFishingDiscard.lua")
      end
    end
  end
  if _ContentsGroup_3DMiniMapOpen then
    runLua("UI_Data/Script/Window/WorldMap/WorldMiniMap.lua")
    runLua("UI_Data/Script/Window/WorldMap/WorldMiniMapPin.lua")
  end
  runLua("UI_Data/Script/Widget/Radar/Radar_Background.lua")
  runLua("UI_Data/Script/Widget/Radar/Radar_Pin.lua")
  runLua("UI_Data/Script/Widget/Radar/Radar.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_InstanceField.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_KickOff.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Function_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_MarketitemList_ALL.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_Tooltip_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_PriceRate_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_MyBasket_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_BiddingGame_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Worldmap_Trade_MarketItemList_All.lua")
  runLua("UI_Data/Script/Window/TradeMarket/Panel_Dialog_Trade_NoLink_All.lua")
  runLua("UI_Data/Script/Widget/GameTips/Panel_Widget_KeyboardGuide.lua")
  if true == _ContentsGroup_isUsedNewTradeEventNotice then
    runLua("UI_Data/Script/Window/TradeMarket/Panel_TradeEventNotice_Renewal_All.lua")
  else
    runLua("UI_Data/Script/Window/TradeMarket/Panel_TradeEventNotice.lua")
  end
  runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Alchemy_All.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_RecentCook_New.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_All.lua")
  runLua("UI_Data/Script/Window/Alchemy/Panel_Window_Manufacture_Notify_All.lua")
  runLua("UI_Data/Script/Window/Friend/Panel_FriendInfo_All.lua")
  runLua("UI_Data/Script/Window/Mail/Panel_Window_Mail_All.lua")
  runLua("UI_Data/Script/Window/Mail/Panel_Window_MailDetail_All.lua")
  if true == _ContentsGroup_NewUI_GameOption_All then
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Header_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Initialize_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_OptionFunc_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Main_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameOption_Util_All.lua")
    runLua("UI_Data/Script/Window/Option/NewUI/Panel_Window_GameModeSettingNotice_All.lua")
  elseif true == _ContentsGroup_isNewOption then
    runLua("UI_Data/Script/Window/Option/GameOptionHeader.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionMain.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
    runLua("UI_Data/Script/Window/Option/Panel_Option_Main.lua")
  elseif true == _ContentsGroup_RenewUI_RenewOPtion then
    runLua("UI_Data/Script/Window/Option/GameOptionHeader_Renew.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionMain_Renew.lua")
    runLua("UI_Data/Script/Window/Option/GameOptionUtil.lua")
    runLua("UI_Data/Script/Window/Option/Panel_Option_Main_Renew.lua")
  end
  runLua("UI_Data/Script/Window/Option/Panel_SetShortCut.lua")
  runLua("UI_Data/Script/Widget/SkillCommand/UI_Widget_SkillCommand.lua")
  runLua("UI_Data/Script/Widget/SkillCommand/UI_Widget_SkillCommand_Cutscene.lua")
  runLua("UI_Data/Script/Window/ProductNote/Panel_ProductNote.lua")
  runLua("UI_Data/Script/Window/KeyboardHelp/Panel_Window_KeyboardHelp.lua")
  runLua("UI_Data/Script/Window/LevelupGuide/Panel_LevelupGuide.lua")
  runLua("UI_Data/Script/Window/QnAWebLink/Panel_QnAWebLink.lua")
  if _ContentsGroup_NewUI_Dye_All then
    runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_Palette_All.lua")
    runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Widget_Dye_All.lua")
    runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Widget_Dye_CharacterController_All.lua")
    runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_ColorMix_All.lua")
  else
    if _ContentsGroup_NewUI_Dye_Palette_All then
      runLua("UI_Data/Script/Window/Dye/NewUI/Panel_Window_Dye_Palette_All.lua")
    else
      runLua("UI_Data/Script/Window/Dye/Panel_DyePalette.lua")
      runLua("UI_Data/Script/Window/Dye/Panel_ColorBalance.lua")
    end
    runLua("UI_Data/Script/Window/Dye/Panel_DyePreview.lua")
    runLua("UI_Data/Script/Window/Dye/Panel_DyeNew_CharacterController.lua")
    runLua("UI_Data/Script/Window/Dye/Panel_Dye_ReNew.lua")
    runLua("UI_Data/Script/Window/Dye/Panel_Dye_ReNew_ButtonHandler.lua")
  end
  runLua("UI_Data/Script/Widget/GameTips/Panel_GameTips.lua")
  runLua("UI_Data/Script/Widget/GameTips/Panel_GameTips_Frame.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Main.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_PowerControl_All.lua")
  if true == _ContentsGroup_NewUI_Fishing_All then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Command_All.lua")
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SinGauge_All.lua")
    runLua("UI_Data/Script/Widget/PowerGauge/Panel_Widget_PowerGauge_All.lua")
  else
    runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Command.lua")
    runLua("UI_Data/Script/Widget/MiniGame/MiniGame_SinGauge.lua")
    runLua("UI_Data/Script/Widget/PowerGauge/Panel_PowerGauge.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_FillGauge.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Steal.lua")
  if true == _ContentsGroup_NewUI_Jaksal_All then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Jaksal_All.lua")
  else
    runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Jaksal.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_SteeringGear.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Hammer.lua")
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Clear.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperShotResult_All.lua")
  if true == _ContentsGroup_NewUI_MiniGame_Sniper_All then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperReload_All.lua")
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_All.lua")
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_Result_All.lua")
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_SniperGame_Control_All.lua")
  else
    runLua("UI_Data/Script/Widget/MiniGame/MiniGame_SniperReload.lua")
    runLua("UI_Data/Script/Widget/SniperGame/Panel_SniperGame.lua")
    runLua("UI_Data/Script/Widget/SniperGame/Panel_SniperGame_Result.lua")
    runLua("UI_Data/Script/Widget/SniperGame/Panel_SniperGame_Control.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GradientY_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Timing_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_HerbMachine_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Buoy_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_BattleGauge_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Gradient_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Rhythm_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Rhythm_Drum_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Find_All.lua")
  if true == _ContentsGroup_MiniGame_YachtDice then
    runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_Result.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_Tooltip_MyDeck.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Invite.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Window_MiniGame_YachtDice_Notice.lua")
  end
  if _ContentsGroup_MiniGame_YachtDice_Match == true then
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_MatchConfirm.lua")
    runLua("UI_Data/Script/Window/MiniGame/Panel_Widget_MiniGame_YachtDice_FindingMatch.lua")
  end
  if _ContentsGroup_RewardMarket == true then
    runLua("UI_Data/Script/Window/Dialog/Panel_Window_RewardMarket_All.lua")
  end
  if true == ToClient_IsDevelopment() then
    runLua("UI_Data/Script/Window/Log/Panel_Window_DamageLog.lua")
    runLua("UI_Data/Script/Window/Log/Panel_Window_DamageLog_Detail.lua")
  end
  if true == _ContentsGroup_IceFishingGame then
    runLua("UI_Data/Script/Widget/MiniGame/MiniGame_IceFishing_All.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningSlaughter_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningSyringe_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningLeather_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningMining_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningLogging_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_CollectMiniGame_MorningHomi_All.lua")
  if _ContentsGroup_ImprovedGalleyShip == true then
    runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GalleyPaddle_All.lua")
  end
  runLua("UI_Data/Script/Widget/Tutorial/New/Panel_Widget_Tutorial_GuideUI.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_Tutorial.lua")
  runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_BossInstance_Dummy.lua")
  if true == _ContentsGroup_NewUI_DialogSearch_All then
    runLua("UI_Data/Script/Widget/Search/Panel_Widget_DialogSearch_All.lua")
  else
    runLua("UI_Data/Script/Widget/Search/Panel_Dialog_Search.lua")
  end
  runLua("UI_Data/Script/Window/GameExit/Panel_ChannelSelect_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_GameExit_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitConfirm_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitTrayConfirm_All.lua")
  runLua("UI_Data/Script/Window/DeadMessage/Panel_NoAccessArea_Alert.lua")
  runLua("UI_Data/Script/Widget/Enduarance/Enduarance.lua")
  runLua("UI_Data/Script/Widget/BreathGauge/Panel_BreathGauge.lua")
  runLua("UI_Data/Script/Window/Repair/Panel_Dialog_Repair_Function_All.lua")
  runLua("UI_Data/Script/Window/Repair/Panel_Window_SetupRepair_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Endurance_Recovery_All.lua")
  runLua("UI_Data/Script/Window/Extraction/Panel_Window_Extraction_All.lua")
  runLua("UI_Data/Script/Window/Extraction/Panel_Window_Extraction_Result.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Costume_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Crystal_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_System_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Blackstone_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Caphras_All.lua")
  runLua("UI_Data/Script/Window/BlackSmith/Panel_Window_Extraction_Artifacts_All.lua")
  runLua("UI_Data/Script/Widget/Arena/Panel_Arena_Battle.lua")
  runLua("UI_Data/Script/Widget/Arena/Panel_Window_Arena_Waiting.lua")
  runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Gear.lua")
  runLua("UI_Data/Script/Window/HorseRacing/Panel_HorseRacing_Score.lua")
  runLua("UI_Data/Script/Widget/Scroll/Panel_Scroll.lua")
  runLua("UI_Data/Script/Tutorial/KeyTutorial.lua")
  runLua("UI_Data/Script/Tutorial/TutorialMain.lua")
  if true == _ContentsGroup_SelectStartPosition then
    runLua("UI_Data/Script/Window/Quest/Panel_Window_StartBranch_All.lua")
  end
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_Person.lua")
  runLua("UI_Data/Script/Window/Delivery/Panel_Window_Delivery_GameExit.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestInfo_All.lua")
  if true == _ContentsGroup_FeverQuest and true == _ContentsGroup_WorldmapFeverQuest then
    runLua("UI_Data/Script/Window/Quest/Panel_Widget_RandomQuestInfo_All.lua")
  end
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBoxElvia_All.lua")
  runLua("UI_Data/Script/Widget/Popup/Panel_Popup_Hadum_Warning_Quest.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_AskKnowledge.lua")
  runLua("UI_Data/Script/Widget/NaviPath/NaviPath.lua")
  runLua("UI_Data/Script/Widget/TownNpcNavi/Panel_Widget_TownNpcNavi.lua")
  runLua("UI_Data/Script/CutScene.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceMain.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_LetterBox.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SubTitle.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceNotifier.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceSkip.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceSkipPopUp.lua")
  runLua("UI_Data/Script/Sequence/Panel_SequenceSkipEscPopUp.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_DeadMessage.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_R_SkipMessageBox.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_TitleTexture.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_KeyGuide.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SkillCommandGuide.lua")
  runLua("UI_Data/Script/Sequence/Panel_Sequence_SkillTutorial.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_HpMpBar.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_Stamina.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_Adrenallin.lua")
  runLua("UI_Data/Script/Widget/InGameCustomize/InGameCustomize.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Cart.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MakePaymentsFromCart.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyHistory.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashSHop_ReturnBack.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Desc.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GoodsTooltip.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GoodsDetailInfo.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_All.lua")
  if _ContentsGroup_PearlShopMoonBlessingRenew == true then
    runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_MoonBlessing_Renew_All.lua")
  end
  if true == _ContentsGroup_GuildGiveaway then
    runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_GuildGiveaway_All.lua")
  end
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_SetEquip.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyOrGift.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_PaymentPassword.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_ChargeDaumCash.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_TermsofDaumCash.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_BuyPearlBox.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_HowUsePearlShop.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_Coupon.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_EasyPayment.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_EventCart.lua")
  runLua("UI_Data/Script/Widget/CashShopAlert/Recommend_Manager.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods.lua")
  runLua("UI_Data/Script/Window/IngameCashShop/Panel_IngameCashShop_RecommandGoods_PopUp.lua")
  runLua("UI_Data/Script/Widget/Coupon/Coupon.lua")
  runLua("UI_Data/Script/Window/ScreenShot_WebAlbum/Panel_ScreenShot_SNS.lua")
  runLua("UI_Data/Script/Window/Cash_Customization/Panel_Cash_Customization.lua")
  if true == ToClient_IsDevelopment() then
    runLua("UI_Data/Script/QASupport/Panel_CreateRandomFaceBoneForDEV.lua")
  end
  if true == _ContentsGroup_RenewUI_ItemMarketPlace then
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_Main.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_ItemMarket.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_Wallet.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_Function.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_MyInventory.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_WalletInventory.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_SubWallet.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_WalletManager.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_Sell.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_Buy.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_Filter.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_SelectList.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_PriceList.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_BuyProductInCashShop.lua")
    runLua("UI_Data/Script/Window/MarketPlace/Panel_Window_MarketPlace_TutorialSelect.lua")
  end
  runLua("UI_Data/Script/Window/ItemMarket/Panel_ItemMarket_Alarm_All.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Function.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_ItemSet.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarketNew.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Favorite.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_RegistItem.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_BuyConfirm.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_AlarmList.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Alarm.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_PreBid.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_PreBid_Manager.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Password.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_Window_ItemMarket_Alarm_New.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Panel_ItemMarket_NewAlarm.lua")
  runLua("UI_Data/Script/Window/ItemMarket/Common_ItemMarketFunction.lua")
  runLua("UI_Data/Script/Window/BossAlert/Panel_BossAlert_SettingV2_All.lua")
  runLua("UI_Data/Script/Window/BossAlert/Panel_BossAlert_Alarm.lua")
  runLua("UI_Data/Script/Widget/Gacha_Roulette/Panel_Gacha_Roulette_All.lua")
  runLua("UI_Data/Script/Widget/PowerGauge/CannonGuage.lua")
  runLua("UI_Data/Script/Window/PcRoomNotify/Panel_PcRoomNotify.lua")
  runLua("UI_Data/Script/Window/EventNotify/Console/Panel_NewsBanner.lua")
  if true == _ContentsGroup_NewUI_EventNotify_All then
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotify_All.lua")
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotifyContent_All.lua")
  else
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotify.lua")
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventNotifyContent.lua")
  end
  runLua("UI_Data/Script/Window/Event/Panel_Event_100Day.lua")
  if _ContentsGroup_EventGuidePage == true then
    runLua("UI_Data/Script/Window/EventNotify/Panel_EventGuide_Total.lua")
  end
  if true == _ContentsGroup_NewUI_CarveSeal_All then
    runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_CarveSeal_All.lua")
  else
    runLua("UI_Data/Script/Window/CarveSeal/Panel_CarveSeal.lua")
    runLua("UI_Data/Script/Window/CarveSeal/Panel_ResetSeal.lua")
  end
  if true == _ContentsGroup_DeleteMaxEnchanterName then
    runLua("UI_Data/Script/Window/CarveSeal/Panel_Window_DeleteMaxEnchanterName.lua")
  end
  runLua("UI_Data/Script/Window/ClearVested/Panel_ClearVested.lua")
  runLua("UI_Data/Script/Window/UI_Setting/Panel_Window_UIModify_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeSkill_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Restore_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_Tooltip_All.lua")
  runLua("UI_Data/Script/Window/WorkerManager/Panel_WorkerManager_ChangeName_All.lua")
  if true == _ContentsGroup_NewUI_TransferLifeExp_All then
    runLua("UI_Data/Script/Window/TransferLifeExperience/Panel_TransferLifeExperience_All.lua")
  else
    runLua("UI_Data/Script/Window/TransferLifeExperience/Panel_TransferLifeExperience.lua")
  end
  runLua("UI_Data/Script/Window/CharacterTag/Panel_Window_ExchangeExp_All.lua")
  runLua("UI_Data/Script/Window/ChangeItem/Panel_ChangeItem.lua")
  if true == _ContentsGroup_NewUI_ChangeItem_All then
    runLua("UI_Data/Script/Window/ChangeItem/Panel_Window_ChangeItem_All.lua")
  else
    runLua("UI_Data/Script/Window/ChangeItem/Panel_ChangeWeapon.lua")
  end
  if _ContentsGroup_AlchemyStoneRenewal == true then
    runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_Renewal_All.lua")
    runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStoneEvolve_All.lua")
  else
    runLua("UI_Data/Script/Window/Alchemy/Panel_Window_AlchemyStone_All.lua")
  end
  if true == _ContentsGroup_ArtifactItem then
    runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_All.lua")
  end
  runLua("UI_Data/Script/Window/Alchemy/Panel_AlchemyFigureHead_All.lua")
  runLua("UI_Data/Script/Window/RallyRanking/Panel_RallyRanking.lua")
  runLua("UI_Data/Script/Panel_SpecialCharacter.lua")
  runLua("UI_Data/Script/Widget/LocalWar/Panel_LocalWar.lua")
  runLua("UI_Data/Script/Window/Join/Panel_Window_Join.lua")
  runLua("UI_Data/Script/Widget/WarInfoMessage/Panel_TerritoryWar_Alert.lua")
  runLua("UI_Data/Script/Widget/Alert/Alert_Message.lua")
  if false == _ContentsGroup_NewUI_ItemWarp_All then
    runLua("UI_Data/Script/Window/Item/Panel_Window_Item_Warp.lua")
  else
    runLua("UI_Data/Script/Window/Item/Panel_Itemwarp_All.lua")
  end
  if _ContentsGroup_Telescope == true then
    runLua("UI_Data/Script/Window/Item/Panel_Window_Telescope_All.lua")
  end
  runLua("UI_Data/Script/Window/Item/ConnectUi.lua")
  runLua("UI_Data/Script/Window/GoldenTreasureBox/Panel_TreasureBox_All.lua")
  runLua("UI_Data/Script/Widget/ScreenshotMode/Panel_ScreenShot_WebAlbum.lua")
  runLua("UI_Data/Script/Widget/ScreenshotMode/Panel_ScreenShotAlbum_FullScreen.lua")
  if true == _ContentsGroup_NewUI_QuestOption_All then
    runLua("UI_Data/Script/Widget/QuestList/Panel_Window_Quest_Option_All.lua")
  else
    runLua("UI_Data/Script/Widget/QuestList/Panel_CheckedQuest_Option.lua")
  end
  runLua("UI_Data/Script/Window/Broadcast/Panel_Broadcast.lua")
  runLua("UI_Data/Script/Widget/CashShopAlert/Panel_CashShopAlert.lua")
  runLua("UI_Data/Script/SeasonTexture_Window.lua")
  runLua("UI_Data/Script/Widget/NakMessage/ActionMessage.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_RescueShipBubble.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_SummonGamos.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SummonZod.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SummonBelmorn.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/Panel_SummonKatsvariak.lua")
  runLua("UI_Data/Script/Widget/Tutorial/Panel_TamingBubble.lua")
  runLua("UI_Data/Script/Widget/BossWave/Panel_BossWave.lua")
  runLua("UI_Data/Script/Window/Party/Panel_Window_PartyList_All.lua")
  runLua("UI_Data/Script/Window/Party/Panel_Window_PartyRecruite_All.lua")
  runLua("UI_Data/Script/Window/Party/Panel_Window_GuildPartyList_All.lua")
  runLua("UI_Data/Script/Window/Servant/Panel_Window_ServantResurrection.lua")
  runLua("UI_Data/Script/Window/BlackSpiritAdventure/Panel_BlackSpiritAdventure2.lua")
  runLua("UI_Data/Script/AbyssOne/Panel_Window_MagnusEasyTeleport_Effect.lua")
  runLua("UI_Data/Script/Widget/TimeAttack/TimeAttack.lua")
  runLua("UI_Data/Script/Window/MonsterRanking/Panel_Window_MonsterRanking.lua")
  runLua("UI_Data/Script/AutoQuest/AutoFrameCheckManager.lua")
  runLua("UI_Data/Script/ReconnectAction/HorseRiding.lua")
  runLua("UI_Data/Script/Window/Under18/Panel_Window_Under18.lua")
  runLua("UI_Data/Script/Window/BlackDesertLab/Panel_Window_BlackDesertLab.lua")
  runLua("UI_Data/Script/Panel_OnlyPerframeUsed.lua")
  runLua("UI_Data/Script/Panel_CommonGameScreenUI.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/Panel_ReturnUser_BlackSpirit.lua")
  loadCustomizationUI_PC()
  runLua("UI_Data/Script/QASupport/QASupportMain.lua")
  runLua("UI_Data/Script/QASupport/QADontSpawn.lua")
  runLua("UI_Data/Script/QASupport/QASupportDamageWriter.lua")
  runLua("UI_Data/Script/QASupport/QASupportDamage_Monster.lua")
  runLua("UI_Data/Script/QASupport/QASupportDamage_Character.lua")
  runLua("UI_Data/Script/QASupport/Panel_Window_DM.lua")
  runLua("UI_Data/Script/QASupport/ServantQASupport/QAServantSupport.lua")
  runLua("UI_Data/Script/QASupport/ServantQASupport/QAServantTestCommand.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAAutoSupportMain.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAItemMarketSupport.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAItemMarketTestCommand.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAAutoSupport_All.lua")
  runLua("UI_Data/Script/QASupport/AutoQASupport/QAAutoSupport_Command.lua")
  runLua("UI_Data/Script/Window/TranslationReport/Panel_TranslationReport.lua")
  runLua("UI_Data/Script/Window/TranslationReport/Panel_Window_TranslationText.lua")
  if true == isGameServiceTypeTurkey() then
    runLua("UI_Data/Script/Window/TurkeyIME/Panel_TurkeyIME.lua")
  end
  if true == _ContentsGroup_NewUI_Memo_All then
    runLua("UI_Data/Script/Window/Memo/Panel_Window_Memo_Main_All.lua")
  else
    runLua("UI_Data/Script/Window/Memo/Panel_Memo_Main.lua")
    runLua("UI_Data/Script/Window/Memo/Panel_Memo_Sticky.lua")
  end
  runLua("UI_Data/Script/Window/RecommendEngine/Panel_RecommendEngine_Main.lua")
  if true == _ContentsGroup_RemasterUI_Main_Alert then
    runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_AlertArea_Renew.lua")
    runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_ChallengeAlert.lua")
    runLua("UI_Data/Script/Widget/AlertArea/Panel_Widget_ContentUnlock.lua")
  end
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NpcGift_All.lua")
  runLua("UI_Data/Script/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_All.lua")
  runLua("UI_Data/Script/Window/MacroCheckQuiz/Panel_Window_MacroCheckQuiz_NumPad_All.lua")
  runLua("UI_Data/Script/Window/Purification/Panel_Window_Purification_All.lua")
  if _ContentsGroup_CardGame then
    runLua("UI_Data/Script/Window/CardGame/Panel_Window_CardGame.lua")
  end
  if _ContentsGroup_Menu_Xbox then
    runLua("UI_Data/Script/Widget/Menu/Console/Panel_Window_Menu_Renew.lua")
  end
  runLua("UI_Data/Script/Widget/BetterEquipment/Panel_Widget_BetterEquipment.lua")
  if true == _ContentsGroup_RemasterUI_Main then
    runLua("UI_Data/Script/Widget/ServantIcon/Panel_Widget_ServantIcon.lua")
  else
    runLua("UI_Data/Script/Window/Servant/Panel_Window_Servant.lua")
    runLua("UI_Data/Script/Window/HouseInfo/Panel_MyHouseNavi.lua")
    runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyIcon.lua")
  end
  runLua("UI_Data/Script/Window/DetectUser/Panel_Window_DetectUser.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Common_MainStatus.lua")
  runLua("UI_Data/Script/Window/StoryInstanceDungeon/Panel_Window_StoryInstanceDungeon.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_AgreementVolunteer_Master.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_AgreementVolunteer.lua")
  runLua("UI_Data/Script/Window/Rank/Panel_Window_VolunteerRankWeb.lua")
  runLua("UI_Data/Script/Window/Rank/Panel_Window_AltarRank.lua")
  runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_AngerGage.lua")
  runLua("UI_Data/Script/Widget/Siege/Panel_SiegeWar_CastleInfo.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_BookShelf_All.lua")
  if _ContentsGroup_MorningLand == true then
    runLua("UI_Data/Script/Window/Achievement/Panel_Window_Achievement_MorningLand.lua")
  end
  runLua("UI_Data/Script/Widget/AccesoryQuest/Panel_Widget_AccesoryQuest.lua")
  if false == _ContentsGroup_NewUI_PersonalMonster_All then
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonster.lua")
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonsterMessage.lua")
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonsterInfo.lua")
  else
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonster_All.lua")
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonsterInfo_All.lua")
    runLua("UI_Data/Script/Window/PersonalMonster/Panel_Window_PersonalMonsterMessage_All.lua")
  end
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestBranch.lua")
  runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalReward_All.lua")
  runLua("UI_Data/Script/Window/RewardList/Panel_Window_TotalRewardHistory_All.lua")
  runLua("UI_Data/Script/Widget/Alert/Panel_Widget_LocalQuestAlert.lua")
  runLua("UI_Data/Script/Tutorial_Renewal/Tutorial_Phase_MarketPlace.lua")
  runLua("UI_Data/Script/Widget/BlackSpirit_SkillSelect/Panel_Widget_BlackSpirit_SkillSelect.lua")
  if _ContentsGroup_bloodAltar_renewal == true then
    runLua("UI_Data/Script/Window/BloodAltar/Panel_Window_BloodAltar_All.lua")
    runLua("UI_Data/Script/Window/BloodAltar/Panel_Widget_BloodAltarGauge_All.lua")
    runLua("UI_Data/Script/Window/BloodAltar/Panel_Window_BloodAltarRetry_All.lua")
  end
  runLua("UI_Data/Script/Widget/BloodAltar/Panel_Widget_BloodAltarJoin.lua")
  runLua("UI_Data/Script/Window/Report/Panel_Window_ReportAll.lua")
  runLua("UI_Data/Script/Window/Report/Panel_Window_ReportAll_1.lua")
  runLua("UI_Data/Script/Window/Report/Panel_Window_ReportAll_2.lua")
  runLua("UI_Data/Script/Window/Banner/Panel_Window_Banner.lua")
  if true == _ContentsGroup_RestoreItem then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Restore_All.lua")
  end
  if true == _ContentsGroup_FarmingList then
    runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimer_All.lua")
    runLua("UI_Data/Script/Widget/FarmingTimer/Panel_Widget_FarmingTimerReport_All.lua")
  end
  if _ContentsGroup_LootingItemRecord == true then
    runLua("UI_Data/Script/Window/Looting/Panel_Window_LootingItemReport_Main_All.lua")
  end
  if true == _ContentsGroup_DragonPalace then
    runLua("UI_Data/Script/Widget/Arena/Panel_RabbitLiverScramble_Timer.lua")
  end
  if true == _ContentsGroup_InstrumentPerformance then
    runLua("UI_Data/Script/Window/Composition/Panel_Composition_All.lua")
    runLua("UI_Data/Script/Window/Composition/Panel_MusicAlbum_All.lua")
    runLua("UI_Data/Script/Window/Composition/Panel_MusicShare_All.lua")
    runLua("UI_Data/Script/Window/Composition/Panel_Widget_PlayMusic_All.lua")
    runLua("UI_Data/Script/Window/Composition/Panel_Window_MusicBoard_All.lua")
    runLua("UI_Data/Script/Window/Composition/Panel_Window_MusicSetting_All.lua")
    if true == _ContentsGroup_InstrumentShop then
      runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All.lua")
      runLua("UI_Data/Script/Window/Composition/Panel_Window_SelectInstruments_All.lua")
    end
  end
  runLua("UI_Data/Script/Window/Common/Panel_Window_LetterScroll_All.lua")
  runLua("UI_Data/Script/Window/Common/Panel_Window_Picture.lua")
  runLua("UI_Data/Script/Window/Common/Panel_Window_Invitation_All.lua")
  if true == _ContentsGroup_SeasonContents then
    runLua("UI_Data/Script/Window/Season/Panel_Window_ChangeSeasonCharacter_All.lua")
  end
  if true == _ContentsGroup_GrowthPass then
    runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass.lua")
    runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_Info.lua")
    runLua("UI_Data/Script/Window/GrowthPass/Panel_Window_GrowthPass_PointShop.lua")
    runLua("UI_Data/Script/Widget/GrowthPass/Panel_Tooltip_Author.lua")
  end
  runLua("UI_Data/Script/Window/Season/Panel_Window_SeasonReward_All.lua")
  runLua("UI_Data/Script/Widget/Awakening_Succession/Panel_Awakening_Succession.lua")
  if _ContentsGroup_LightStoneBag == true then
    runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_LightStoneBag.lua")
    runLua("UI_Data/Script/Window/LightStoneBag/Panel_Window_ArtifactPreset_All.lua")
  end
  if _ContentsGroup_CombineBag == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Combine.lua")
  end
  if true == _ContentsGroup_NewUI_ShipControl_All then
    runLua("UI_Data/Script/Window/Servant/Panel_Widget_Ship_Control_All.lua")
  end
  if _ContentsGroup_MorningLand == true then
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_Boss_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_Ranking_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_ConquestHistory_All.lua")
    if _ContentsGroup_MorningLand2 == true then
      runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_QuestBoard2_All.lua")
    else
      runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_QuestBoard_All.lua")
    end
    runLua("UI_Data/Script/Window/MorningLand/Panel_MorningLand_Scenario_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_DetailReward_All.lua")
    runLua("UI_Data/Script/Window/MorningLand/Panel_Window_MorningLand_MyReward_All.lua")
    runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_ConquestGiveUp_All.lua")
    runLua("UI_Data/Script/Widget/AlertArea/Panel_MorningLand_QuestBoardAlert_All.lua")
  end
  if _ContentsGroup_MorningLand2 == true then
    runLua("UI_Data/Script/Window/Movie/Panel_EndingCredit_All.lua")
  end
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Member.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Notify.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Score.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_DeadMessage.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Reward.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Enter.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_Map.lua")
  runLua("UI_Data/Script/Widget/ThornCastle/Panel_Widget_ThornCastle_NPCShop_All.lua")
  if true == isGameTypeCH() then
    runLua("UI_Data/Script/Window/Guild/NewUI/Panel_GuildChangeMark_All.lua")
    runLua("UI_Data/Script/Window/BlackBackground/Panel_Global_BlackBackground.lua")
  end
  if ToClient_IsDevelopment() then
    runLua("UI_Data/Script/Panel_UIEgg_Test.lua")
  end
  if true == _ContentsGroup_NewCloseManager then
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager_ExceptionList.lua")
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager_Renew.lua")
  else
  end
  if true == ToClient_IsDevelopment() then
    runLua("UI_Data/Script/Window/PowerSave/Panel_Window_PowerSave_All.lua")
  end
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinderUiInputType.lua")
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinderManager.lua")
  runLua("UI_Data/Script/GlobalKeyBinder/globalKeyBinder.lua")
  runLua("UI_Data/Script/Widget/KillLog/Panel_Widget_KillLog.lua")
  if true == _ContentsGroup_UsePadSnapping then
    runLua("UI_Data/Script/Panel_PadSnapTargetEffect.lua")
    runLua("UI_Data/Script/Widget/Menu/Console/Panel_QuickMenu.lua")
    runLua("UI_Data/Script/Widget/Menu/Console/ConsoleQuickMenu.lua")
    runLua("UI_Data/Script/Widget/Menu/Console/Panel_QuickMenuSetting.lua")
    runLua("UI_Data/Script/Widget/ConsoleKeyGuide/Panel_ConsoleKeyGuide.lua")
  end
  runLua("UI_Data/Script/Window/Timer/Panel_Window_Timer.lua")
  runLua("UI_Data/Script/Window/Timer/Panel_Window_TimerCount.lua")
  runLua("UI_Data/Script/Window/Option/Panel_Window_Description.lua")
  runLua("UI_Data/Script/Widget/ToTargetKeyGuide/Panel_Widget_ToTargetKeyGuide.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_ExpirationPeriodItem.lua")
  if true == _ContentsGroup_RenewalLifeGradeUpUI then
    runLua("UI_Data/Script/Widget/NakMessage/NakMessage_Life.lua")
  end
  if true == _ContentsGroup_FairySkillChangeRateView then
    runLua("UI_Data/Script/Window/FairyInfo/Panel_Window_FairyRateDesc.lua", "Panel_Window_FairyRateDesc")
  end
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneSkip.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneScript.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutScene_ESC_Skip.lua")
  if true == _ContentsGroup_NewSequenceTutorial then
    runLua("UI_Data/Script/Widget/Tutorial/Panel_Widget_SequenceTutorial.lua")
  end
  if true == _ContentsGroup_SelectBox then
    runLua("UI_Data/Script/Window/ItemBox/Panel_Window_SelectBox.lua")
  end
  runLua("UI_Data/Script/Window/ItemBox/Panel_Window_MessageBox_ForReward.lua")
  runLua("UI_Data/Script/Window/Inventory/Panel_Window_ItemMoveSet.lua")
  runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_List.lua")
  runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_Option.lua")
  if true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_PersonalField) then
    runLua("UI_Data/Script/Widget/RentInstanceField/Panel_RentInstanceField_Time.lua")
  end
  if true == ToClient_IsDevelopment() then
    runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayLoadList_All.lua")
    runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionModify_All.lua")
    runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionTimeline_All.lua")
    runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionCamera_All.lua")
    runLua("UI_Data/Script/Window/Production/Panel_Window_ProductionRecord_All.lua")
  end
  runLua("UI_Data/Script/Window/Replay/Panel_Window_ReplayController_All.lua")
  runLua("UI_Data/Script/Window/Event/Panel_Event_QuizGM_All.lua")
  runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_All.lua")
  if _ContentsGroup_QuizEvent == true then
    runLua("UI_Data/Script/Window/Event/Panel_Event_Quiz_Minimal_All.lua")
  end
  runLua("UI_Data/Script/Window/Event/Panel_Event_TicketShop_All.lua")
  runLua("UI_Data/Script/Window/Invite/Panel_Window_Invite_All.lua")
  if true == _ContentsGroup_MansionContent then
    runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionRank_All.lua")
  end
  runLua("UI_Data/Script/Window/Mansion/Panel_Window_MansionContract_All.lua")
  runLua("UI_Data/Script/Window/Housing/Panel_House_InstallationMode_Siege_All.lua")
  if true == _ContentsGroup_LocalWarOccupation and true == ToClient_IsInstanceFieldPlayerbyContentsType(__eInstanceContentsType_RedBattleField) then
    runLua("UI_Data/Script/Widget/LocalWar/Panel_LocalWarOccupation_Gauge.lua")
  end
  runLua("UI_Data/Script/Window/Movie/Panel_ImageSlider_All.lua")
  runLua("UI_Data/Script/Widget/Ping/Panel_Widget_Ping_All.lua")
  runLua("UI_Data/Script/Window/PersonalField/Panel_Widget_PersonalField_All.lua")
  runLua("UI_Data/Script/Window/PersonalField/Panel_Window_PersonalField_Main_All.lua")
  runLua("UI_Data/Script/Window/PersonalField/Panel_Widget_PersonalField_Enter_All.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_SimpleBuildMode_All.lua")
  runLua("UI_Data/Script/Widget/PhotoMode/Panel_Widget_PhotoMode_Main_All.lua")
  if _ContentsGroup_SequenceIndividual == true then
    runLua("UI_Data/Script/Window/Cutscene/Panel_Window_QuickTimeEvent_Manager.lua")
    runLua("UI_Data/Script/Window/Cutscene/Panel_Window_QuickTimeEvent_CircleKeyDown.lua")
  end
  if true == _ContentsGroup_RadioPlayer then
    runLua("UI_Data/Script/Widget/RadioPlayer/Panel_Widget_RadioPlayer_All.lua")
  end
  runLua("UI_Data/Script/Window/Guild/Panel_Window_RecoveryElephant.lua")
  runLua("UI_Data/Script/Window/Tutorial/Panel_ContentsTutorial_All.lua")
  runLua("UI_Data/Script/Window/Guild/Panel_Window_Guild_Arbitration.lua")
  runLua("UI_Data/Script/Widget/EnterElvia/Panel_Widget_HadumField_Enter_All.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chat_Process_All.lua")
  runLua("UI_Data/Script/Window/WareHouse/NakMessage_Warehouse_Clear_All.lua")
  runLua("UI_Data/Script/Widget/NakMessage/AbyssOne_SKill_NakMessage.lua")
  if _ContentsGroup_ArtifactItem == true then
    runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_Exchange_All.lua")
  end
  runLua("UI_Data/Script/Window/Artifacts/Panel_Window_Artifacts_Exchange_Log_All.lua")
  runLua("UI_Data/Script/Window/Event/Panel_Event_SpecialPass_All.lua")
  runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BossReward_All.lua")
  runLua("UI_Data/Script/Widget/BossReward/Panel_Widget_BoxReward_All.lua")
  runLua("UI_Data/Script/Widget/BossInstance/Panel_Widget_GuildBossField_Enter_All.lua")
  if _ContentsGroup_JewelPreset == true then
    runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelPreset_All.lua")
    runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelInven_All.lua")
    runLua("UI_Data/Script/Window/Socket/Panel_Window_JewelTooltip_All.lua")
    runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_CrystalSet_All.lua")
  end
  runLua("UI_Data/Script/Window/Guide/Panel_Window_ContentsGuide.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Widget_Tooltip_Servant_All.lua")
  runLua("UI_Data/Script/Window/Common/Panel_Window_Bromide_All.lua")
  if _ContentsGroup_RoseWar == true then
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Main.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMap.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Command.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MiniMapPartyList.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Mission.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MissionWidget.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_MissionAccept.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Region.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Menu.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_EditParty.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_DeadMessage.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamSkill.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamBuff.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_PartyList.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_WarLog.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_WarLog_L.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_Nak_Teleport.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_ScoreBoardWidget.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_ScoreBoard.lua")
    runLua("UI_Data/Script/Window/RoseWar/Panel_RoseWar_TeamScoreBoard.lua")
  end
  runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_TimeRecordingLog_All.lua")
  runLua("UI_Data/Script/Window/FieldWalkingCamera/Panel_FieldWalkingCamera.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Window_VillageSiegeMenu_All.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Window_SiegeResult_All.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Window_OceanSiegeResult_All.lua")
  runLua("UI_Data/Script/Window/Siege/Panel_Widget_VillageSiegeState_All.lua")
  if isGameTypeCH() == true then
    runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All.lua")
  end
  if _ContentsGroup_MonsterBuffZone == true then
    runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZone.lua")
    runLua("UI_Data/Script/Window/MonsterBuffZone/Panel_Window_MonsterBuffZoneItemRepair.lua")
  end
  runLua("UI_Data/Script/Widget/LifeRingMenu/Panel_Widget_LifeRingMenu_All.lua")
  if _ContentsGroup_DamageConsoleView == true then
    runLua("UI_Data/Script/Window/Damage/Panel_Window_DamageConsoleView.lua")
  end
  if _ContentsGroup_MorningLandTierGo == true then
    runLua("UI_Data/Script/Widget/MorningLand/Panel_Widget_MorningLandSuccessMsg_All.lua")
  end
  if _ContentsGroup_ItemSkillOption == true then
    runLua("UI_Data/Script/Window/Enchant/Panel_ItemSkillOption_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_MakeGoonWang_All.lua")
  end
  if _ContentsGroup_MorningLandTierParty == true then
    runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBoxForSequence_All.lua")
  end
  runLua("UI_Data/Script/Window/AutoMove/Panel_AutoMove_Result_All.lua")
  runLua("UI_Data/Script/Panel_Loading.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_NetworkAlert_All.lua")
  runLua("UI_Data/Script/Widget/Tooltip/Panel_Window_CharacterStat_All.lua")
  if _ContentsGroup_RedBattleFieldMatching == true then
    runLua("UI_Data/Script/Widget/LocalWar/Panel_Widget_LocalWar_Match_All.lua")
    runLua("UI_Data/Script/Widget/LocalWar/Panel_LocalWar_Match_Confirm_All.lua")
  end
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Notation_Ability_All.lua")
  end
  if _ContentsGroup_TotalPreset == true then
    runLua("UI_Data/Script/Window/PresetTotal/Panel_Window_PresetTotal_All.lua")
    runLua("UI_Data/Script/Window/PresetTotal/Panel_Window_PresetTotalMemo.lua")
  end
  if _ContentsGroup_ReforgeStonePreset == true then
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgeStonePreset_All.lua")
    runLua("UI_Data/Script/Window/Enchant/Panel_Window_ReforgePresetNameEdit_All.lua")
  end
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_All.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_Select_All.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_Page_All.lua")
  runLua("UI_Data/Script/Window/Achievement/Panel_Window_Journal_Book_All.lua")
  if _ContentsGroup_SnowBoardMirrorField == true then
    runLua("UI_Data/Script/Window/SnowBoard/SnowBoardMain.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Menu_All.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Result_All.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_SnowBoard_Hud_All.lua")
    runLua("UI_Data/Script/Window/SnowBoard/Panel_Window_MessageBox_SnowBoard.lua")
  end
  runLua("UI_Data/Script/Window/Common/Panel_Widget_Common_Countdown.lua")
  if _ContentsGroup_OceanSiege == true then
    runLua("UI_Data/Script/Widget/Siege/Panel_Widget_OceanSiege_ReturnToSeaport.lua")
  end
  LoadingPanel_Init()
  isLuaLoadingComplete = true
end
function loadPadSnapTargetEffect()
  loadUI("UI_Data/Widget/UIcontrol/Panel_PadSnapTargetEffect.XML", "Panel_PadSnapTargetEffect", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_PadSnapTargetEffect.lua")
end
function loadWorldMapUI_PC()
  ToClient_initializeWorldMap("UI_Data/Window/Worldmap_Grand/Worldmap_Grand_Base.XML")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_HouseNavi.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WorkManager_House.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WorkManager_LargeCraft.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WorkManager_Plant.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_NodeStable.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_Worldmap_NodeStableInfo.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Grand_WorldMap_MainPanel.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Grand_WorldMap_MenuPanel.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Grand_WorldMap_NodeMenu.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WorkManager_Building.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WorkManager_Harvest.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WorkManager_Finance.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Grand_WorldMap_NodeName.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Grand_WorldMap_MovieTooltip.lua")
  runLua("UI_Data/Script/Widget/WarInfoMessage/Panel_WarInfoMessage.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_WarInfo.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_NodeWarInfo.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Grand_WorldMap_NodeOwnerInfo.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_QuestTooltip.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_TerritoryTooltip.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_ActorTooltip.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_PopupManager.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_HouseHold.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Knowledge.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Town_WorkerManage.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Working_Progress.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_LordManager.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Delivery.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WroldMap_TradeNpcItemInfo.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_TradeNpcList.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_NodeTooltip_VillageWar_All.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Worldmap_Grand_NodeLevel.lua")
  if _ContentsGroup_WorldMapKnowledgeIcon == true then
    runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_KnowledgeList.lua")
  end
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_BookMark.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_StableList.lua")
  if _ContentsGroup_HarvestList_All then
    runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_TentInfo_All.lua")
  else
    runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_Tent.lua")
  end
  runLua("UI_Data/Script/Window/Worldmap_Grand/New_WorldMap_PinGuide.lua")
  if true == _ContentsGroup_OceanCurrent then
    runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_Worldmap_BarterInfo.lua")
  end
  runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_WaypointPreset.lua")
  runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_WaypointOption.lua")
  if true == _ContentsGroup_WorldMapNodeNavigation then
    runLua("UI_Data/Script/Window/WorldMap_Grand/Worldmap_Grand_NodeNavigation.lua")
  end
  runLua("UI_Data/Script/Window/Worldmap_Grand/Worldmap_Grand_GuildColorList.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildHouseControl.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/WordMap_Craft/Worldmap_Grand_GuildCraft_ChangeWorker.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_FamilyChracterPin.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_FamilyCharacterList.lua")
  runLua("UI_Data/Script/Window/Worldmap_Grand/Panel_WorldMap_FamilyCharacterChangeMemo.lua")
  ToClient_postInitializeWorldmap()
  if _ContentsGroup_FishingCamp == true then
    runLua("UI_Data/Script/Widget/Camp/Panel_Window_FishingCamp_All.lua")
  end
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_Contents_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Hud_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Edania_CountDown_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_PVP_Challenger_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_Join_All.lua")
  runLua("UI_Data/Script/Window/Edania/Panel_Window_Edania_Worldmap_Castle_All.lua")
  if _ContentsGroup_OlviaAcademy == true then
    runLua("UI_Data/Script/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Alert.lua")
    runLua("UI_Data/Script/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Invitation.lua")
    runLua("UI_Data/Script/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Main_All.lua")
    runLua("UI_Data/Script/Window/OlviaAcademy/Panel_Window_OlviaAcademy_Pass_All.lua")
  end
end
PaGlobal_SetLoadUIFunc(loadLogoUI_PC, LOADUI_TYPE.logoUI)
PaGlobal_SetLoadUIFunc(loadLoginUI_PC, LOADUI_TYPE.loginUI)
PaGlobal_SetLoadUIFunc(loadServerSelectUI_PC, LOADUI_TYPE.serverSelectUI)
PaGlobal_SetLoadUIFunc(loadLoadingUI_PC, LOADUI_TYPE.loadingUI)
PaGlobal_SetLoadUIFunc(loadLobbyUI_PC, LOADUI_TYPE.lobbyUI)
PaGlobal_SetLoadUIFunc(preLoadGameUI_PC, LOADUI_TYPE.preLoadGameUI)
PaGlobal_SetLoadUIFunc(loadGameUI_PC, LOADUI_TYPE.GameUI)
PaGlobal_SetLoadUIFunc(loadWorldMapUI_PC, LOADUI_TYPE.WorldMapUI)
function reloadUI_PC_SwapCharacter()
  if _ContentsGroup_ShowOtherClassSkill == true then
    loadUI("UI_Data/Window/Skill/Panel_Window_SkillGroup_All.xml", "Panel_Window_SkillGroup_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_All.lua")
    FromClient_SkillGroup_All_Init()
  else
    loadUI("UI_Data/Window/Skill/Panel_Skill_Play_Main_All.xml", "Panel_Window_SkillGroup", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup.lua")
    FromClient_SkillGroupInit()
  end
end
PaGlobal_SetReloadUIFunc(reloadUI_PC_SwapCharacter, __eUIReloadEventType_SwapCharacter)
