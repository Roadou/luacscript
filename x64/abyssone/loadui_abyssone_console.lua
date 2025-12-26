local UIGroup = Defines.UIGroup
local RenderMode = Defines.RenderMode
isLuaLoadingComplete = false
local UIFontType = ToClient_getGameOptionControllerWrapper():getUIFontSizeType()
preloadUI_cahngeUIFontSize(UIFontType)
function preLoadGameUI_PC()
  loadUI("UI_Data/Widget/NakMessage/NakMessage.XML", "Panel_NakMessage", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/NakMessage/NakMessage_MSG_SEQUENCE.XML", "Panel_NakMessage_Sequence", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessage_Renewel.XML", "Panel_NakMessage_Renewel", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/Panel_IME.XML", "Panel_IME", UIGroup.PAGameUIGroup_ModalDialog)
  loadUI("UI_Data/Window/WebHelper/Panel_WebControl.XML", "Panel_WebControl", UIGroup.PAGameUIGroup_ModalDialog + 1, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Panel_WebCashPayment.XML", "Panel_WebCashPayment", UIGroup.PAGameUIGroup_ModalDialog + 1, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.XML", "Panel_Window_PearlBox_Purchase_All", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/ProductNote/Panel_ProductNote.XML", "Panel_ProductNote", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/KeyboardHelp/Panel_KeyboardHelp.XML", "Panel_KeyboardHelp", UIGroup.PAGameUIGroup_ModalDialog + 1, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/LevelupGuide/Panel_LevelupGuide.XML", "Panel_LevelupGuide", UIGroup.PAGameUIGroup_WorldMap_Contents)
  if _ContentsGroup_ExpirienceWiki_All == true then
    if _ContentsGroup_WikiNoToURL == true then
      loadUI("UI_Data/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All.xml", "Panel_Window_ExpirienceWiki_All", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_Dialog,
        RenderMode.eRenderMode_InGameCashShop
      }))
    else
      loadUI("UI_Data/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All.xml", "Panel_Window_ExpirienceWiki_All", UIGroup.PAGameUIGroup_ModalDialog + 1, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default
      }))
    end
  end
  basicLoadUI("UI_Data/Window/Event/Panel_Event_TicketShop_All.XML", "Panel_Event_TicketShop", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_Unboxing_Progress.XML", "Panel_Event_TicketShop_Unboxing", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Event/Panel_Event_TicketShop_Nak.XML", "Panel_Event_TicketShop_Nak", UIGroup.PAGameUIGroup_Alert)
  basicLoadUI("UI_Data/Window/GameExit/Panel_Window_GameExit_All.xml", "Panel_Window_GameExit_All", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/GameExit/Panel_Window_ExitConfirm_Reboot.xml", "Panel_ExitConfirm", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/GameExit/Panel_ExitConfirm.xml", "Panel_ExitConfirm_Old", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/GameExit/Panel_Window_TrayConfirm_All.xml", "Panel_Window_TrayConfirm_All", UIGroup.PAGameUIGroup_GameMenu, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Exchange/Panel_Window_ExchangeNumber_All.XML", "Panel_Window_NumberPad_All", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_InGameCashShop
  }))
  basicLoadUI("UI_Data/Window/SeasonTexture/Panel_SeasonTexture.xml", "Panel_SeasonTexture", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Chatting/Panel_Important_Notice.XML", "Panel_Important_Notice", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Widget_Chatting_Renew.XML", "Panel_Widget_Chatting_Renew", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Window_ChattingHistory_Renew.XML", "Panel_Window_ChattingHistory_Renew", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Widget_ChattingViewer_Renew.XML", "Panel_Widget_ChattingViewer_Renew", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Window_Chatting_BlockList.XML", "Panel_Chatting_BlockList", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Console/Panel_Window_Chatting_FunctionList.XML", "Panel_Chatting_FunctionList", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/UI_Window_ChatOption.XML", "Panel_ChatOption", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/UI_Window_Chatting_Input.XML", "Panel_Chatting_Input", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SniperGame
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Filter.XML", "Panel_Chatting_Filter", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Macro.XML", "Panel_Chatting_Macro", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_SocialMenu.XML", "Panel_Chat_SocialMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_SubMenu.XML", "Panel_Chat_SubMenu", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/Chatting/Panel_Chatting_Color.XML", "Panel_Chatting_Color", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/Chatting/Panel_Window_Join_ChannelChat.XML", "Panel_Window_ChannelChat", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Widget/Chatting/Panel_Window_ChannelChat_Wait.XML", "Panel_Widget_ChannelChat_Loading", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Report/Panel_Window_Chat_Report_All.XML", "Panel_Window_Chat_Report_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_RoseWar
  }))
  loadUI("UI_Data/Widget/Tooltip/UI_Tooltip_SimpleText.XML", "Panel_Tooltip_SimpleText", UIGroup.PAGameUIGroup_SimpleTooltip, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_GameTips.XML", "Panel_GameTips", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/GameTips/UI_Widget_GameTipsMask.XML", "Panel_GameTipMask", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Window/GameTips/UI_Window_GameTips.XML", "Panel_Window_GameTips", UIGroup.PAGameUIGroup_WorldMap_Contents)
  loadUI("UI_Data/Window/ChangeName/Panel_Window_ChangeNickname_All.XML", "Panel_Change_Nickname_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  basicLoadUI("UI_Data/Window/ChangeName/Panel_NameSwapExchange.XML", "Panel_ExchangeNickname", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_ChatOption_All == true then
    loadUI("UI_Data/Widget/Chatting/Panel_Window_ChatOption_All.XML", "Panel_Window_ChatOption_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
    loadUI("UI_Data/Widget/Chatting/Panel_Window_Chatting_Color_All.XML", "Panel_Window_Chatting_Color_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_WorldMap
    }))
  end
  loadUI("UI_Data/Widget/UIcontrol/Panel_OnlyPerframeUsed.XML", "Panel_OnlyPerframeUsed", UIGroup.PAGameUIGroup_Widget, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/Region/Region_AbyssOne.XML", "Panel_AbyssOne_Enter", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Widget/AbyssOne/Panel_AbyssOne_DungeonInfo.XML", "Panel_Window_AbyssOneInfo", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/AbyssOne/Panel_DeadMessage_A1.XML", "Panel_AbyssOne_Resurrection", UIGroup.PAGameUIGroup_ModalDialog)
  basicLoadUI("UI_Data/Window/AbyssOne/Panel_Menu_AbyssOne.XML", "Panel_Menu_AbyssOne", UIGroup.PAGameUIGroup_GameMenu)
  if _ContentsGroup_SnowAntLabyrinth == true then
    loadUI("UI_Data/Widget/NakMessage/NakMessage_Erethea.xml", "Panel_NakMessage_Erether_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_Sequence
    }))
  end
  loadUI("UI_Data/Widget/NoticeAlert/NoticeAlert.XML", "Panel_NoticeAlert", UIGroup.PAGameUIGroup_GameSystemMenu, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessageByActionChart.xml", "Panel_ActionMessage", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence
  }))
  loadUI("UI_Data/Widget/NakMessage/NakMessageByActionChart_New.xml", "Panel_ActionMessage_New", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence
  }))
  loadUI("UI_Data/Widget/NakMessage/Panel_Widget_NakMessageChoice_All.XML", "Panel_Widget_NakMessageChoice_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Sequence
  }))
  basicLoadUI("UI_Data/Window/AbyssOne/Panel_Popup_AbyssOne_BuyEquipment_All.XML", "Panel_Popup_AbyssOne_BuyEquipment_All", UIGroup.PAGameUIGroup_WorldMap_Popups)
  basicLoadUI("UI_Data/Window/AbyssOne/Panel_Window_AbyssOne_Equip_Set_BlackBG.XML", "Panel_AbyssOne_EquipPresetBlockBg", UIGroup.PAGameUIGroup_WorldMap)
  basicLoadUI("UI_Data/Window/AbyssOne/Panel_Window_AbyssOne_Equip.XML", "Panel_AbyssOne_EquipPresetList", UIGroup.PAGameUIGroup_WorldMap_Popups)
  loadUI("UI_Data/Window/Equipment/Panel_Equipment_CrystalTooltip.XML", "Panel_Equipment_Crystal_Tooltip", UIGroup.PAGameUIGroup_SimpleTooltip, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/MessageBox/Panel_Window_MessageBox_All.XML", "Panel_Window_MessageBox_All", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER())
  basicLoadUI("UI_Data/Window/MessageBox/Panel_ScreenShot_For_Desktop.XML", "Panel_ScreenShot_For_Desktop", UIGroup.PAGameUIGroup_ModalDialog)
  loadUI("UI_Data/Widget/Interaction/Console/Panel_Widget_Interaction_Renew.XML", "Panel_Widget_PanelInteraction_Renew", UIGroup.PAGameUIGroup_Interaction, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_CutScene
  }))
  basicLoadUI("UI_Data/Widget/Interaction/Console/Panel_Window_HouseList_Renew.XML", "Panel_Interaction_HouseList", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_HouseRank.XML", "Panel_Interaction_HouseRank", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_Interaction_House.XML", "Panel_Interaction_House", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_WatchingCommand.XML", "Panel_WatchingMode", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Widget/Interaction/Panel_CommandGuide.XML", "Panel_CommandGuide", UIGroup.PAGameUIGroup_Interaction)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_SelfPlayer_New.XML", "Panel_Copy_SelfPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_OtherPlayer_New.XML", "Panel_Copy_OtherPlayer", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Vehicle_New.XML", "Panel_Copy_Vehicle", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Npc_New.XML", "Panel_Copy_Npc", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Monster_New.XML", "Panel_Copy_Monster", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_HouseHold_New.XML", "Panel_Copy_HouseHold", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Installation_New.XML", "Panel_Copy_Installation", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_NameTag_Maid_New.XML", "Panel_Copy_MaidActor", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_WaitComment.XML", "Panel_Copy_WaitComment", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Damage/UI_Damage.XML", "Panel_Damage", UIGroup.PAGameUIGroup_Dialog)
  basicLoadUI("UI_Data/Widget/Damage/CounterAttack.XML", "Panel_CounterAttack", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Intimacy_All.xml", "Panel_Npc_Intimacy_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Interest_Knowledge_All.XML", "Panel_Interest_Knowledge_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/UI_Win_Npc_Dialog_All.xml", "Panel_Npc_Dialog_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_ButtonList_All.XML", "Panel_Dialog_List_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
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
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_Exchange_All.XML", "Panel_Dialog_Exchange_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  loadUI("UI_Data/Widget/Dialogue/Dialog_Itemtake_ALL.xml", "Panel_Dialogue_Itemtake_All", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit
  }))
  loadUI("UI_Data/Widget/Dialogue/Panel_Dialog_NPCShop_All.xml", "Panel_Dialog_NPCShop_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Widget/ItemLog/Panel_Widget_QuestRewardItem.xml", "Panel_Widget_QuestRewardItem", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_BlackSpirit,
    RenderMode.eRenderMode_Production
  }))
  if _ContentsGroup_NewUI_Tooltip_All == true then
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
  loadUI("UI_Data/Widget/Tooltip/Console/Panel_Widget_Tooltip_Renew.XML", "Panel_Widget_Tooltip_Renew", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye
  }))
  loadUI("UI_Data/Widget/Tooltip/Console/Panel_Widget_FloatingTooltip_Renew.XML", "Panel_Widget_FloatingTooltip_Renew", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_InGameCashShop,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_Dialog,
    RenderMode.eRenderMode_HouseInstallation,
    RenderMode.eRenderMode_Dye
  }))
  if _ContentsGroup_UISkillGroupTreeLayOut == false then
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
      RenderMode.eRenderMode_Dialog
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
    RenderMode.eRenderMode_InGameCashShop
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
  loadUI("UI_Data/Window/Cutscene/Panel_CutsceneMovie.XML", "Panel_Cutscene", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera
  }))
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
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_HpMpBar_Remaster_forCutscene.XML", "Panel_Sequence_HpMpBar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Sequence
  }))
  loadUI("UI_Data/Widget/Stamina/Stamina_forCutscene.XML", "Panel_Sequence_Stamina", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Sequence
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_Adrenallin_Remaster_forCutscene.XML", "Panel_Sequence_Adrenallin", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_GroupCamera,
    RenderMode.eRenderMode_Sequence
  }))
  basicLoadUI("UI_Data/Window/c_Option/Console/Panel_Window_OptionMain_Renew.XML", "Panel_Window_Option_Main", UIGroup.PAGameUIGroup_Windows)
  if _ContentsGroup_NewUI_GameOption_All == true then
    basicLoadUI("UI_Data/Window/c_Option/Panel_Window_Gameoption_Main_All.XML", "Panel_Window_GameOption_All", UIGroup.PAGameUIGroup_Windows)
    basicLoadUI("UI_Data/Window/c_Option/Panel_Window_GameSettings_Notice_PopUp.XML", "Panel_Window_GameModeSettingNotice_All", UIGroup.PAGameUIGroup_Windows)
  elseif _ContentsGroup_isNewOption == true then
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
    if _ContentsGroup_InstrumentPerformance == true then
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    else
      basicLoadUI("UI_Data/Window/c_Option/Option_Sound_Volume_NonMusicPlayOption.XML", "Panel_Sound_Volume", UIGroup.PAGameUIGroup_Windows)
    end
    basicLoadUI("UI_Data/Window/c_Option/Option_Alert_Alarm.XML", "Panel_Alert_Alarm", UIGroup.PAGameUIGroup_Windows)
  end
  basicLoadUI("UI_Data/Window/Copyright/Panel_Window_Copyright.XML", "Panel_Copyright", UIGroup.PAGameUIGroup_Windows)
  loadUI("UI_Data/Window/DeadMessage/DangerAlert.XML", "Panel_Danger", UIGroup.PAGameUIGroup_FadeScreen, SETRENDERMODE_BITSET_ALLRENDER_NOT_SEQUENCE())
  basicLoadUI("UI_Data/Widget/AbyssOne/Panel_Widget_MainStatus_New_AbyssOne.XML", "Panel_MainStatus_Remaster", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/Buff/UI_BuffList_All.XML", "Panel_AppliedBuffList_Console", UIGroup.PAGameUIGroup_SkillAndBuff)
  basicLoadUI("UI_Data/Widget/AbyssOne/UI_SkillCooltime_QuickView_AbyssOne.XML", "Panel_SkillCooltime", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/SkillLog/Panel_Widget_SkillLog.XML", "Panel_Widget_SkillLog", UIGroup.PAGameUIGroup_Widget)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect.XML", "Panel_CoolTime_Effect", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Slot.XML", "Panel_CoolTime_Effect_Slot", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Item.XML", "Panel_CoolTime_Effect_Item", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/QuickSlot/UI_SkillCooltime_Effect_Item_Slot.XML", "Panel_CoolTime_Effect_Item_Slot", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/AbyssOne/UI_Panel_QuickSlot_AbyssOne.XML", "Panel_QuickSlot", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Actor/UI_Actor_ActionStatus.XML", "Panel_CharacterActionStatus", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/AbyssOne/Panel_ClassResource_AbyssOne.XML", "Panel_ClassResource", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MainStatus/Panel_GuardGauge.XML", "Panel_GuardGauge", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/AbyssOne/Stamina_AbyssOne.xml", "Panel_Stamina", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/Chatting/Panel_Chat_Process_All.XML", "Panel_Chat_Process_All", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/EnemyGauge/Console/Panel_Widget_EnemyGauge_Renew.XML", "Panel_Monster_Bar", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SniperGame,
    RenderMode.eRenderMode_CutScene,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/ProgressBar/UI_Win_Collect_Bar.XML", "Panel_Collect_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/ProgressBar/UI_Win_Product_Bar.XML", "Panel_Product_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  basicLoadUI("UI_Data/Widget/ProgressBar/UI_Win_Enchant_Bar.XML", "Panel_Enchant_Bar", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Widget/MainStatus/UI_SelfPlayer_Main_Slot_Casting_Bar.XML", "Panel_Casting_Bar", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  loadUI("UI_Data/Widget/MainStatus/Panel_Widget_EscapeBar_All.XML", "Panel_Widget_EscapeBar_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SkillWindow
  }))
  loadUI("UI_Data/Window/AbyssOne/UI_Window_QuestInfo_ALL_AbyssOne.XML", "Panel_Window_QuestInfo_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Window/AbyssOne/UI_Window_Quest_ALL_AbyssOne.XML", "Panel_Window_Quest_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Quest/UI_Window_FavorQuest_ALL.xml", "Panel_Window_QuestTypeSet_All", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Window/Quest/Panel_Window_QuestBranch.xml", "Panel_Window_QuestBranch", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Actor/UI_Actor_BubbleBox.XML", "Panel_Copy_BubbleBox", UIGroup.PAGameUIGroup_MainUI)
  if _ContetnsGroup_ChangeLoadingImg == true then
    basicLoadUI("UI_Data/Window/AbyssOne/Common_FadeOut_BG_AbyssOne.XML", "Common_FadeOut", UIGroup.PAGameUIGroup_FadeScreen)
  else
    basicLoadUI("UI_Data/Window/AbyssOne/Common_FadeOut_AbyssOne.XML", "Common_FadeOut", UIGroup.PAGameUIGroup_FadeScreen)
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
  basicLoadUI("UI_Data/Widget/AbyssOne/UI_CannonStack_AbyssOne.XML", "Panel_CannonStack", UIGroup.PAGameUIGroup_Widget)
  if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == true then
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
  if _ContentsGroup_UISkillGroupTreeLayOut == true then
    loadUI("UI_Data/Window/Skill/Panel_Skill_Play_SelectType_All.xml", "Panel_Window_SkillGroup_SelectType", UIGroup.PAGameUIGroup_AlertPost, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_SkillQuickSlot_All.xml", "Panel_Window_SkillGroup_QuickSlot", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_ShowCharacter_All.xml", "Panel_Window_SkillGroup_Controller", UIGroup.PAGameUIGroup_Dialog, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    loadUI("UI_Data/Window/Skill/Panel_Window_Skill_CoolTimeSlot_All.xml", "Panel_SkillGroup_CoolTimeSlot", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Default,
      RenderMode.eRenderMode_SkillWindow,
      RenderMode.eRenderMode_Dialog
    }))
    if _ContentsGroup_SkillFilter == true then
      loadUI("UI_Data/Window/Skill/Panel_Window_Skill_Filter_All.xml", "Panel_Window_SkillFilter_All", UIGroup.PAGameUIGroup_Window_Progress, PAUIRenderModeBitSet({
        RenderMode.eRenderMode_Default,
        RenderMode.eRenderMode_SkillWindow,
        RenderMode.eRenderMode_Dialog
      }))
    end
    basicLoadUI("UI_Data/Widget/QuickSlot/Panel_SkillCoolTimeQuickSlot.XML", "Panel_SkillCoolTimeQuickSlot", UIGroup.PAGameUIGroup_MainUI)
    if _ContentsGroup_SkillPreset == true then
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
    if _ContentsGroup_ShowOtherClassSkill == true then
      loadUI("UI_Data/Window/Skill/Panel_Window_SkillGroup_All.xml", "Panel_Window_SkillGroup_All", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
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
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Horse_Skill_Trainning_All.xml", "Panel_Minigame_GradientY_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Timing_All.xml", "Panel_MiniGame_Timing_All", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/MiniGame/MiniGame_Horse_Trained_All.xml", "Panel_MiniGame_Horse_Trained_All", UIGroup.PAGameUIGroup_MainUI)
  loadUI("UI_Data/Window/SaveSetting/Panel_SaveSetting.XML", "Panel_SaveSetting", UIGroup.PAGameUIGroup_Windows, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Window/Movie/UI_DialogMovie.xml", "Panel_DialogMovie", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Video
  }))
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieTheater_MessageBox.XML", "Panel_MovieTheater_MessageBox", UIGroup.PAGameUIGroup_Movie)
  basicLoadUI("UI_Data/Window/Movie/Panel_MovieTheater_320.XML", "Panel_MovieTheater_320", UIGroup.PAGameUIGroup_Movie)
  loadUI("UI_Data/Window/Movie/Panel_MovieTheater_640.XML", "Panel_MovieTheater_640", UIGroup.PAGameUIGroup_Movie, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  basicLoadUI("UI_Data/Widget/GlobalManual/Panel_Global_Manual.xml", "Panel_Global_Manual", UIGroup.PAGameUIGroup_MainUI)
  basicLoadUI("UI_Data/Widget/BreathGauge/Panel_BreathGauge.XML", "Panel_BreathGauge", UIGroup.PAGameUIGroup_Widget)
  loadUI("UI_Data/Widget/AbyssOne/Panel_Widget_MainQuest_AbyssOne.XML", "Panel_Widget_MainQuest_AbyssOne", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/AbyssOne/Panel_Widget_QuestList_AbyssOne.XML", "Panel_CheckedQuest", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap
  }))
  loadUI("UI_Data/Widget/UIcontrol/Panel_PadSnapTargetEffect.XML", "Panel_PadSnapTargetEffect", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  loadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenu.xml", "Panel_QuickMenu", UIGroup.PAGameUIGroup_Windows, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_WorldMap,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenuCustom_Edit.xml", "Panel_QuickMenuCustom", UIGroup.PAGameUIGroup_Windows)
  basicLoadUI("UI_Data/Widget/Menu/Console/Panel_QuickMenuCustom_RightRing.xml", "Panel_QuickMenuCustom_RightRing", UIGroup.PAGameUIGroup_Window_Progress)
  loadUI("UI_Data/Widget/Menu/Console/Panel_Widget_QuickMenu.xml", "Panel_Widget_QuickMenu", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  if _ContentsGroup_NewUI_DialogSearch_All == true then
    loadUI("UI_Data/Widget/Search/Panel_Widget_Dialog_Search_All.xml", "Panel_Widget_Dialog_Search_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  else
    loadUI("UI_Data/Widget/Search/UI_Dialog_Search.xml", "Panel_Dialog_Search", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
      RenderMode.eRenderMode_Dialog
    }))
  end
  loadUI("UI_Data/Widget/KeyGuide/Panel_ConsoleKeyGuide.xml", "Panel_ConsoleKeyGuide", UIGroup.PAGameUIGroup_Widget, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_IngameCustomize,
    RenderMode.eRenderMode_Dialog,
    Defines.RenderMode.eRenderMode_customScreenShot,
    Defines.RenderMode.eRenderMode_InGameCashShop
  }))
  loadUI("UI_Data/Widget/Console/Panel_Widger_Camera_Mode.xml", "Panel_Widget_CameraMode_All", UIGroup.PAGameUIGroup_MainUI, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_SequencePlayerControl
  }))
  basicLoadUI("UI_Data/Widget/AbyssOne/NakMessage_FirstClear_AbyssOne.XML", "Panel_AbyssOne_FirstClearMessage", UIGroup.PAGameUIGroup_Widget)
  if isGameTypeCH() == true then
    loadUI("UI_Data/Window/MessageBox/Panel_Window_Addiction_Prevention_All.XML", "Panel_Addiction_Prevention_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
  end
  if _ContentsGroup_GuildAuthoritySeparation == true then
    basicLoadUI("UI_Data/Window/Guild/Panel_Guild_Authorization_All.XML", "Panel_Guild_Authorization_All", UIGroup.PAGameUIGroup_Window_Progress)
  end
  loadUI("UI_Data/Window/Movie/UI_ImageSlider.xml", "Panel_ImageSlider_All", UIGroup.PAGameUIGroup_ModalDialog, PAUIRenderModeBitSet({
    RenderMode.eRenderMode_Default,
    RenderMode.eRenderMode_Dialog
  }))
  loadUI("UI_Data/Window/MessageBox/Panel_Window_NetworkAlert_All.XML", "Panel_Window_NetworkAlert_All", UIGroup.PAGameUIGroup_Tutorial, SETRENDERMODE_BITSET_ALLRENDER())
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    basicLoadUI("UI_Data/Window/Inventory/Panel_Window_Notation_Ability_All.XML", "Panel_Notation_Ability", UIGroup.PAGameUIGroup_Windows)
  end
end
function loadGameUI_PC()
  if true == ToClient_IsDevelopment() then
    runLua("UI_Data/Script/QASupport/AbyssOneHelp.lua")
  end
  runLua("UI_Data/Script/DragManager.lua")
  runLua("UI_Data/Script/Fullsizemode.lua")
  runLua("UI_Data/Script/global_fromActionChart_LuaEvent.lua")
  runLua("UI_Data/Script/Common/Common_UIMode.lua")
  runLua("UI_Data/Script/Common/Common_BlackSpirit.lua")
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage.lua")
  runLua("UI_Data/Script/Widget/NakMessage/Panel_NakMessage_Sequence.lua")
  runLua("UI_Data/Script/Widget/NakMessage/NakMessage_Renewel.lua")
  runLua("UI_Data/Script/Panel_Ime.lua")
  runLua("UI_Data/Script/Tutorial/Panel_WebControl.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_WebCashPayment.lua")
  runLua("UI_Data/Script/Window/WebHelper/Panel_Window_PearlBox_Purchase_All.lua")
  runLua("UI_Data/Script/Window/ProductNote/Panel_ProductNote.lua")
  runLua("UI_Data/Script/Window/KeyboardHelp/Panel_Window_KeyboardHelp.lua")
  runLua("UI_Data/Script/Window/LevelupGuide/Panel_LevelupGuide.lua")
  if _ContentsGroup_ExpirienceWiki_All == true then
    runLua("UI_Data/Script/Window/ExpirienceWiki/Panel_Window_ExpirienceWiki_All.lua")
  end
  runLua("UI_Data/Script/Window/Event/Panel_Event_TicketShop_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_GameExit_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitConfirm_All.lua")
  runLua("UI_Data/Script/Window/GameExit/Panel_Window_ExitTrayConfirm_All.lua")
  runLua("UI_Data/Script/Window/Keypad/Panel_Window_NumberPad_All.lua")
  runLua("UI_Data/Script/SeasonTexture_Window.lua")
  runLua("UI_Data/Script/Widget/GameTips/Panel_GameTips.lua")
  runLua("UI_Data/Script/Widget/GameTips/Panel_GameTips_Frame.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/Chatting/Notice/Panel_Important_Notice.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Widget_Chatting_Renew.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Window_ChattingHistory_Renew.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Widget_ChattingViewer_Renew.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Window_Chatting_BlockList.lua")
  runLua("UI_Data/Script/Widget/Chatting/Console/Panel_Window_Chatting_FunctionList.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_ChatOption.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Filter.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Macro.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_SocialAction.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chatting_Color.lua")
  runLua("UI_Data/Script/Widget/Chatting/CreateChattingContent.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Widget_ChannelChat_Loading.lua")
  runLua("UI_Data/Script/Window/Report/Panel_Window_Chat_Report_All.lua")
  if true == _ContentsGroup_ChatOption_All then
    runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChatOption_All.lua")
    runLua("UI_Data/Script/Widget/Chatting/Panel_Window_Chatting_Color_All.lua")
  end
  if true == _ContentsGroup_ChannelChat then
    runLua("UI_Data/Script/Widget/Chatting/Panel_Window_ChannelChat.lua")
    runLua("UI_Data/Script/Widget/Chatting/Panel_Widget_ChannelChat_Loading.lua")
  end
  runLua("UI_Data/Script/Window/ChangeNickName/Panel_Change_Nickname_All.lua")
  runLua("UI_Data/Script/Window/ChangeNickName/Panel_ExchangeNickname.lua")
  runLua("UI_Data/Script/AbyssOne/Panel_OnlyPerframeUsed_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_Enter.lua")
  runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_RegionInfo.lua")
  runLua("UI_Data/Script/AbyssOne/Resurrection/Panel_AbyssOne_Resurrection.lua")
  runLua("UI_Data/Script/AbyssOne/Menu/Panel_AbyssOne_Menu.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/NoticeAlert.lua")
  runLua("UI_Data/Script/Widget/NakMessage/ActionMessage.lua")
  runLua("UI_Data/Script/Widget/NoticeAlert/InstanceNoticeAlert.lua")
  runLua("UI_Data/Script/AbyssOne/Panel_AbyssOne_EquipPresetList.lua")
  runLua("UI_Data/Script/AbyssOne/Panel_AbyssOne_Inventory_All.lua")
  runLua("UI_Data/Script/Window/Equipment/Panel_Equiment_CrystalTooltip.lua")
  runLua("UI_Data/Script/Window/MessageBox/MessageBox_Common.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_MessageBox_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_ScreenShot_For_Desktop.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction_Renew.lua")
  runLua("UI_Data/Script/Widget/Interaction/Console/Panel_Interaction_HouseList_Renew.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_Interaction_HouseRank.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_WatchingMode.lua")
  runLua("UI_Data/Script/Widget/Interaction/Panel_CommandGuide.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterNameTag.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_WaitComment.lua")
  runLua("UI_Data/Script/Widget/Damage/UI_Lua_Damage.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Intimacy_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_InterestKnowledge_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Main_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_List_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_Quest_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ExchangeList_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialogue_Itemtake_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_NPCShop_All.lua")
  runLua("UI_Data/Script/Widget/Dialogue/Panel_Dialog_ButtonType.lua")
  runLua("UI_Data/Script/Widget/ItemLog/Panel_Widget_QuestRewardItem.lua")
  if _ContentsGroup_NewUI_Tooltip_All == true then
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
  if _ContentsGroup_UISkillGroupTreeLayOut == false then
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill.lua")
  else
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SkillGroup.lua")
  end
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Guild_Introduce.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Common.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SimpleText.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_New_Work.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Console/Panel_Widget_Tooltip_Renew.lua")
  runLua("UI_Data/Script/Widget/ToolTip/Console/Panel_Widget_FloatingTooltip_Renew.lua")
  runLua("UI_Data/Script/CutScene.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneSkip.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutSceneScript.lua")
  runLua("UI_Data/Script/Window/Cutscene/Panel_Window_CutScene_ESC_Skip.lua")
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
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_HpMpBar.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_Stamina.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_Widget_Sequence_Adrenallin.lua")
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
  runLua("UI_Data/Script/Window/Copyright/Panel_Copyright.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Common_MainStatus.lua")
  runLua("UI_Data/Script/AbyssOne/MainStatus/Panel_MainStatus_Remaster_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/Buff/Panel_AppliedBuffList_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/Buff/Panel_AppliedBuffList_Console_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/QuickSlot/Panel_QuickSlot_AbyssOne.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_CharacterActionStatus.lua")
  runLua("UI_Data/Script/AbyssOne/Skill/Panel_SkillCooltime_AbyssOne.lua")
  runLua("UI_Data/Script/Widget/SkillLog/Widget_SkillLog.lua")
  runLua("UI_Data/Script/AbyssOne/MainStatus/Panel_ClassResource_AbyssOne.lua")
  runLua("UI_Data/Script/Widget/MainStatus/Panel_GuardGauge.lua")
  runLua("UI_Data/Script/AbyssOne/Stamina/Stamina_AbyssOne.lua")
  runLua("UI_Data/Script/Widget/Chatting/Panel_Chat_Process_All.lua")
  runLua("UI_Data/Script/Widget/EnemyGauge/Console/Panel_Widget_MonsterBar_Renew.lua")
  runLua("UI_Data/Script/Widget/ProgressBar/Panel_ProgressBar.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_Quest_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestInfo_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestTypeSet_All.lua")
  runLua("UI_Data/Script/Window/Quest/Panel_Window_QuestBranch.lua")
  runLua("UI_Data/Script/Widget/CharacterNameTag/Panel_BubbleBox.lua")
  runLua("UI_Data/Script/AbyssOne/FadeScreen/Common_FadeOut_AbyssOne.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire.lua")
  runLua("UI_Data/Script/Widget/Acquire/Acquire_QuestDirect.lua")
  runLua("UI_Data/Script/Widget/Acquire/Alert_QuestDirect.lua")
  runLua("UI_Data/Script/AbyssOne/Servant/Panel_CannonStack_AbyssOne.lua")
  if _ContentsGroup_NewUI_BlackSpiritSkillLock_All == true then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock_All.lua")
  else
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_BlackSpiritLock.lua")
  end
  if _ContentsGroup_UISkillGroupTreeLayOut == true then
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_SelectType.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_QuickSlot.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_Controller.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_CoolTimeSlot.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Succession.lua")
    runLua("UI_Data/Script/Window/Skill/Panel_Window_Skill_Awaken.lua")
    runLua("UI_Data/Script/Widget/QuickSlot/Panel_SkillcoolTimeQuickSlot.lua")
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_SkillGroup.lua")
    if _ContentsGroup_SkillFilter == true then
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillFilter_All.lua")
    end
    if _ContentsGroup_SkillPreset == true then
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPreset.lua")
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillPresetMemo.lua")
    end
    if _ContentsGroup_ShowOtherClassSkill == true then
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup_All.lua")
    else
      runLua("UI_Data/Script/Window/Skill/Panel_Window_SkillGroup.lua")
    end
  else
    runLua("UI_Data/Script/Widget/ToolTip/Panel_Tooltip_Skill.lua")
  end
  runLua("UI_Data/Script/Widget/MiniGame/MiniGame_Main.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_GradientY_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Timing_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_HerbMachine_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_Buoy_All.lua")
  runLua("UI_Data/Script/Widget/MiniGame/Panel_MiniGame_BattleGauge_All.lua")
  runLua("UI_Data/Script/Window/SaveSetting/Panel_SaveSetting.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_DialogMovie.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieTheater_320.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_MovieTheater_640.lua")
  runLua("UI_Data/Script/Widget/GlobalManual/Panel_Global_Manual.lua")
  runLua("UI_Data/Script/Widget/BreathGauge/Panel_BreathGauge.lua")
  runLua("UI_Data/Script/AbyssOne/Quest/Panel_Widget_MainQuest_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/Quest/Panel_Widget_QuestList_AbyssOne.lua")
  runLua("UI_Data/Script/Panel_PadSnapTargetEffect.lua")
  ToClient_loadQuickMenuPanel(Panel_QuickMenu)
  runLua("UI_Data/Script/Widget/Menu/Console/Panel_QuickMenu.lua")
  runLua("UI_Data/Script/Widget/Menu/Console/ConsoleQuickMenu.lua")
  runLua("UI_Data/Script/Widget/Menu/Console/Panel_QuickMenuSetting.lua")
  runLua("UI_Data/Script/Widget/ConsoleKeyGuide/Panel_ConsoleKeyGuide.lua")
  runLua("UI_Data/Script/Widget/Camera/Panel_Widget_Camera_Mode_All.lua")
  if _ContentsGroup_NewUI_DialogSearch_All == true then
    runLua("UI_Data/Script/Widget/Search/Panel_Widget_DialogSearch_All.lua")
  else
    runLua("UI_Data/Script/Widget/Search/Panel_Dialog_Search.lua")
  end
  runLua("UI_Data/Script/AbyssOne/Nak/TutorialMain_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/Region/Panel_AbyssOne_FirstClearMessage.lua")
  if isGameTypeCH() == true then
    runLua("UI_Data/Script/Window/MessageBox/Panel_Addiction_Prevention_All.lua")
  end
  if _ContentsGroup_GuildAuthoritySeparation == true then
    runLua("UI_Data/Script/Window/Guild/Panel_Guild_Authorization_All.lua")
  end
  if true == _ContentsGroup_NewCloseManager then
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager_ExceptionList.lua")
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager_Renew_AbyssOne.lua")
  else
    runLua("UI_Data/Script/GlobalKeyBinder/globalCloseManager.lua")
  end
  runLua("UI_Data/Script/AbyssOne/globalKeyBinderUiInputType_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/globalKeyBinderManager_AbyssOne.lua")
  runLua("UI_Data/Script/AbyssOne/globalKeyBinder_AbyssOne.lua")
  runLua("UI_Data/Script/Widget/Dialogue/DialogKeybinderManager_All.lua")
  runLua("UI_Data/Script/Window/Movie/Panel_ImageSlider_All.lua")
  runLua("UI_Data/Script/Window/MessageBox/Panel_Window_NetworkAlert_All.lua")
  if _ContentsGroup_RenewCharacterStatusViewMode == true then
    runLua("UI_Data/Script/Window/Inventory/Panel_Window_Notation_Ability_All.lua")
  end
  runLua("UI_Data/Script/Widget/MainStatus/Common_MainStatus_Console.lua")
  isLuaLoadingComplete = true
end
function loadLogoUI_PC()
  _PA_SVC_LOG("loadui_abyssone loadLogoUI_PC")
end
function loadLoginUI_PC()
  _PA_SVC_LOG("loadui_abyssone loadLoginUI_PC")
end
function loadServerSelectUI_PC()
  _PA_SVC_LOG("loadui_abyssone loadServerSelectUI_PC")
end
function loadLoadingUI_PC()
  _PA_SVC_LOG("loadui_abyssone loadLoadingUI_PC")
end
function loadLobbyUI_PC()
  _PA_SVC_LOG("loadui_abyssone loadLobbyUI_PC")
end
function loadWorldMapUI_PC()
end
function loadPadSnapTargetEffect()
  loadUI("UI_Data/Widget/UIcontrol/Panel_PadSnapTargetEffect.XML", "Panel_PadSnapTargetEffect", UIGroup.PAGameUIGroup_ModalDialog, SETRENDERMODE_BITSET_ALLRENDER())
  runLua("UI_Data/Script/Panel_PadSnapTargetEffect.lua")
end
PaGlobal_SetLoadUIFunc(loadLogoUI_PC, LOADUI_TYPE.logoUI)
PaGlobal_SetLoadUIFunc(loadLoginUI_PC, LOADUI_TYPE.loginUI)
PaGlobal_SetLoadUIFunc(loadServerSelectUI_PC, LOADUI_TYPE.serverSelectUI)
PaGlobal_SetLoadUIFunc(loadLoadingUI_PC, LOADUI_TYPE.loadingUI)
PaGlobal_SetLoadUIFunc(loadLobbyUI_PC, LOADUI_TYPE.lobbyUI)
PaGlobal_SetLoadUIFunc(preLoadGameUI_PC, LOADUI_TYPE.preLoadGameUI)
PaGlobal_SetLoadUIFunc(loadGameUI_PC, LOADUI_TYPE.GameUI)
PaGlobal_SetLoadUIFunc(loadWorldMapUI_PC, LOADUI_TYPE.WorldMapUI)
function reloadUI_PCPadAbyssOne_SwapCharacter()
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
PaGlobal_SetReloadUIFunc(reloadUI_PCPadAbyssOne_SwapCharacter, __eUIReloadEventType_SwapCharacter)
