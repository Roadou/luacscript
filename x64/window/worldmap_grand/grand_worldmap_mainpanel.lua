local IM = CppEnums.EProcessorInputMode
local UI_color = Defines.Color
local UI_ST = CppEnums.SpawnType
local UI_ANI_ADV = CppEnums.PAUI_ANIM_ADVANCE_TYPE
local UI_AV = CppEnums.PA_UI_ALIGNVERTICAL
local UI_TT = CppEnums.PAUI_TEXTURE_TYPE
local UI_VT = CppEnums.VillageSiegeType
local currentTownMode = false
local eWorldmapState = CppEnums.WorldMapState
local eCheckState = CppEnums.WorldMapCheckState
local isEnableBattle = ToClient_IsContentsGroupOpen("21")
local territoryFilterBG = UI.getChildControl(Panel_WorldMap_Main, "Static_SiegeTerritoryFilter_BG")
local territoryInfoControl = UI.getChildControl(territoryFilterBG, "Static_SiegeTerritoryInfo")
local isShowUIByObserver = true
local switchSiegeType = UI.getChildControl(territoryFilterBG, "Static_InfoSwitch_BG")
local stc_leftFunctions = UI.getChildControl(Panel_WorldMap_Main, "Static_Worldmap_Left_Function")
local stc_contentsList = UI.getChildControl(stc_leftFunctions, "Check_ContensList")
local stc_search = UI.getChildControl(stc_leftFunctions, "Check_Search")
local worldmapGrand = {
  ui = {
    ModeBG = UI.getChildControl(Panel_WorldMap_Main, "Mode_Bg"),
    TitleBG = UI.getChildControl(Panel_WorldMap_Main, "Static_TitleBG"),
    TopIconBG = UI.getChildControl(Panel_WorldMap_Main, "Static_TopIconBG"),
    filterBg = UI.getChildControl(Panel_WorldMap_Main, "Static_FilterBg"),
    filterArrow = UI.getChildControl(Panel_WorldMap_Main, "Static_FilterArrow"),
    filterTitle = UI.getChildControl(Panel_WorldMap_Main, "StaticText_FilterTitle"),
    buttonBlackSpirit = UI.getChildControl(Panel_WorldMap_Main, "Button_BlackSpirit"),
    buttonTutorial_1 = UI.getChildControl(Panel_WorldMap_Main, "Button_Tutorial_1"),
    buttonTutorial_2 = UI.getChildControl(Panel_WorldMap_Main, "Button_Tutorial_2"),
    buttonTutorial_3 = UI.getChildControl(Panel_WorldMap_Main, "Button_Tutorial_3"),
    MainMenuBG = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Bg"),
    edit_NodeName = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Edit_NodeName"),
    btn_SearchNodeName = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Button_NodeSearch"),
    edit_ItemName = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Edit_ItemName"),
    btn_SearchItemName = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Button_ItemSearch"),
    edit_UseType = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Edit_UseType"),
    btn_SearchUseType = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Button_UseTypeSearch"),
    edit_GuildName = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Edit_GuildType"),
    btn_SearchGuildName = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Button_GuildTypeSearch"),
    searchPartLine = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Static_Partline"),
    explorePointBG = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Static_ExplorePoint_Bg"),
    ListBG = UI.getChildControl(Panel_WorldMap_Main, "List_Bg"),
    list_Title = UI.getChildControl(Panel_WorldMap_Main, "List_Title"),
    list_KeyWord = UI.getChildControl(Panel_WorldMap_Main, "List_KeyWord"),
    list_SearchBG = UI.getChildControl(Panel_WorldMap_Main, "List_SearchListBG"),
    list_scroll = UI.getChildControl(Panel_WorldMap_Main, "Scroll_List"),
    daySelectBg = UI.getChildControl(Panel_WorldMap_Main, "Static_SelectDayBg"),
    daySelectTitle = UI.getChildControl(Panel_WorldMap_Main, "StaticText_SelectDayTitle"),
    comboBox_DaySelect = UI.getChildControl(Panel_WorldMap_Main, "Combobox_SelectDay"),
    comboBox_TaxGrade = UI.getChildControl(Panel_WorldMap_Main, "Combobox_SelectTaxGrade"),
    nodeSelectBg = UI.getChildControl(Panel_WorldMap_Main, "Static_SelectTerritoryBg"),
    nodeSelectTitle = UI.getChildControl(Panel_WorldMap_Main, "StaticText_SelectTerritoryTitle"),
    comboBox_TerritorySelect = UI.getChildControl(Panel_WorldMap_Main, "Combobox_SelectTerritory"),
    comboBox_NodeType = UI.getChildControl(Panel_WorldMap_Main, "Combobox_SelectNodeType"),
    stc_SiegeTerritoryFilterBG = UI.getChildControl(Panel_WorldMap_Main, "Static_SiegeTerritoryFilter_BG"),
    btn_SiegeTerritoryFilter = UI.getChildControl(territoryFilterBG, "RadioButton_SiegeTerritoryFilter"),
    stc_SiegeTerritoryFilterBar = UI.getChildControl(territoryFilterBG, "Static_SelectBar"),
    btn_SiegeTerritoryFilterList = {},
    stc_TerritoryInfo = UI.getChildControl(territoryFilterBG, "Static_SiegeTerritoryInfo"),
    stc_TerritoryInfoTitle = UI.getChildControl(territoryInfoControl, "StaticText_TerritoryName"),
    stc_TerritoryInfoDay = UI.getChildControl(territoryInfoControl, "StaticText_Info"),
    btn_TerritoryInfoAll = UI.getChildControl(Panel_WorldMap_Main, "Button_All"),
    btn_TerritoryInfoMy = UI.getChildControl(Panel_WorldMap_Main, "CheckButton_Guild"),
    stc_switchSiegeType = UI.getChildControl(territoryFilterBG, "Static_InfoSwitch_BG"),
    btn_minorSiege = UI.getChildControl(switchSiegeType, "RadioButton_1"),
    btn_majorSiege = UI.getChildControl(switchSiegeType, "RadioButton_2"),
    stc_HardCoreBg = UI.getChildControl(Panel_WorldMap, "Static_Bg_Hardcore"),
    stc_HardCoreBossTitle = {},
    btn_OceanSiege = nil,
    chk_contentsList = UI.getChildControl(stc_contentsList, "Check_Icon"),
    chk_search = UI.getChildControl(stc_search, "Check_Icon"),
    list2_contents = UI.getChildControl(Panel_WorldMap_Main, "List2_ContentsList")
  },
  menuContentsList = {
    [0] = {
      key = eCheckState.eCheck_Quest,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Request_Off",
        path = "",
        uv = {
          x1 = 151,
          y1 = 347,
          x2 = 181,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_QUEST_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    },
    [1] = {
      key = eCheckState.eCheck_Knowledge,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Knowledge_Off",
        path = "",
        uv = {
          x1 = 120,
          y1 = 347,
          x2 = 150,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_KNOWLEDGE"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_KNOWLEDGE_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    },
    [2] = {
      key = eCheckState.eCheck_FishnChip,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Fishing_Off",
        path = "",
        uv = {
          x1 = 337,
          y1 = 347,
          x2 = 367,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_FISH_NAME"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_FISH_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    },
    [3] = {
      key = eCheckState.eCheck_Monster,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Region_Off",
        path = "",
        uv = {
          x1 = 182,
          y1 = 347,
          x2 = 212,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_MONSTER"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_MONSTERINFO_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    },
    [4] = {
      key = eCheckState.eCheck_Node,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Hub_Off",
        path = "",
        uv = {
          x1 = 306,
          y1 = 347,
          x2 = 336,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_NODE"),
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_NODE_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    },
    [5] = {
      key = eCheckState.eCheck_MyBossMonster,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_DarkRifts_Off",
        path = "",
        uv = {
          x1 = 399,
          y1 = 347,
          x2 = 429,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_MYBOSSMONSTER"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    },
    [6] = {
      key = eCheckState.eCheck_AbyssWell,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Well_Off",
        path = "",
        uv = {
          x1 = 368,
          y1 = 285,
          x2 = 398,
          y2 = 315
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_ABYSSWELL"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    },
    [7] = {
      key = eCheckState.eCheck_Postions,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Location_Off",
        path = "",
        uv = {
          x1 = 275,
          y1 = 347,
          x2 = 305,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_LOCATION"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    },
    [8] = {
      key = eCheckState.eCheck_Way,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Direction_Off",
        path = "",
        uv = {
          x1 = 213,
          y1 = 347,
          x2 = 243,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_WAY"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    },
    [9] = {
      key = eCheckState.eCheck_Trade,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Trade_Off",
        path = "",
        uv = {
          x1 = 368,
          y1 = 347,
          x2 = 398,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_TRADE"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    },
    [10] = {
      key = eCheckState.eCheck_Wagon,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Transport_Off",
        path = "",
        uv = {
          x1 = 244,
          y1 = 347,
          x2 = 274,
          y2 = 377
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_WAGON"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    },
    [11] = {
      key = eCheckState.eCheck_Barter,
      icon = {
        TID = "Combine_Etc_WorldMap_Filter_Icon_Exchange_Off",
        path = "",
        uv = {
          x1 = 399,
          y1 = 285,
          x2 = 429,
          y2 = 315
        }
      },
      name = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_BARTER"),
      desc = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_RENEWAL_QUEST")
    }
  },
  searchResultUiPool = {},
  template = {
    templateButton = UI.getChildControl(Panel_WorldMap_Main, "Mode_Button"),
    templateCheck = UI.getChildControl(Panel_WorldMap_Main, "Mode_ToggleButton"),
    templateRadio = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Button_1")
  },
  config = {
    searchingResultMaxCount = 8,
    searchingResultCount = 0,
    searchType = 0,
    selectNodeType = 0,
    scrollStartIdx = 0,
    searchDefaultNodeName = PAGetString(Defines.StringSheet_GAME, "LUA_GRANDWORLDMAP_SEARCHDEFAULT_NODENAME"),
    searchDefaultItemName = PAGetString(Defines.StringSheet_GAME, "LUA_GRANDWORLDMAP_SEARCHDEFAULT_ITEMNAME"),
    searchDefaultGuildName = PAGetString(Defines.StringSheet_GAME, "LUA_GRANDWORLDMAP_SEARCHDEFAULT_GUILDTYPE"),
    searchDefaultUseType = PAGetString(Defines.StringSheet_GAME, "LUA_GRANDWORLDMAP_SEARCHDEFAULT_USETYPE")
  },
  _isAllowTutorialPanelShow = false,
  _currentSelectTerritoryIndex = -1,
  _territoryInfoBasePosY = 0,
  _territoryFilterBgBaseSizeY = 0,
  _isMajorSiegeView = ToClient_GetIsMajorSiegeView(),
  _isOnlyOceanSiegeView = false,
  _currentMajorSiegeCount = 0
}
function WorldMap_HardcoreBossList_Init()
  local bossTitleTemplate = UI.getChildControl(Panel_WorldMap, "Static_BossTemplate_Hardcore")
  local maxBossCount = ToClient_getHardCoreMaxBossCount()
  local startPositionY = bossTitleTemplate:GetPosY()
  local templateSizeY = bossTitleTemplate:GetSizeY()
  bossTitleTemplate:SetShow(false)
  for index = 0, maxBossCount - 1 do
    local bossTitle = UI.cloneControl(bossTitleTemplate, Panel_WorldMap, "Static_BossTemplate_Hardcore_" .. tostring(index))
    local decoBg = UI.getChildControl(bossTitle, "Static_DecoBg")
    local bossSpawnText = UI.getChildControl(decoBg, "StaticText_SpawnTime")
    bossSpawnText:SetText(PAGetString(Defines.StringSheet_RESOURCE, "PANEL_WORLDMAP_HARDCOREBOSSVALUE"))
    bossTitle:SetPosY(startPositionY + templateSizeY * index)
    bossTitle:SetShow(false)
    worldmapGrand.ui.stc_HardCoreBossTitle[index] = bossTitle
  end
end
WorldMap_HardcoreBossList_Init()
local nationSiege_BossClass = {
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_NATIONSEIGE_CALPHEON_BOSS"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_NATIONSEIGE_VALENCIA_BOSS"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_NATIONSEIGE_CALPHEON_SUBBOSS_2"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_NATIONSEIGE_CALPHEON_SUBBOSS_1"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_NATIONSEIGE_VALENCIA_SUBBOSS_2"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_NAKMESSAGE_NATIONSEIGE_VALENCIA_SUBBOSS_1")
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
local nationSiege_BossCharacterKey = {
  [1] = 28181,
  [2] = 28182,
  [3] = 28192,
  [4] = 28193,
  [5] = 28187,
  [6] = 28194
}
local nationSiege_BossDieIcon = {
  _path = {
    [1] = "new_ui_common_forlua/widget/worldmap/nodeicon_calpheongeneralposition_Death.dds",
    [2] = "new_ui_common_forlua/widget/worldmap/nodeicon_valenciageneralposition_Death.dds",
    [3] = "new_ui_common_forlua/widget/worldmap/nodeicon_calpheonvanposition_Death.dds",
    [4] = "new_ui_common_forlua/widget/worldmap/nodeicon_calpheoncommanderposition_Death.dds",
    [5] = "new_ui_common_forlua/widget/worldmap/nodeicon_valenciavanposition_Death.dds",
    [6] = "new_ui_common_forlua/widget/worldmap/nodeicon_valenciacommanderposition_Death.dds"
  },
  _UV = {
    x1 = 0,
    y1 = 0,
    x2 = 300,
    y2 = 350
  }
}
local territoryIcon = {
  _path = {
    [1] = "new_ui_common_forlua/widget/worldmap/territory/territorymark_valenos_large.dds",
    [2] = "new_ui_common_forlua/widget/worldmap/territory/territorymark_selendia_large.dds",
    [3] = "new_ui_common_forlua/widget/worldmap/territory/territorymark_calpheon_large.dds",
    [4] = "new_ui_common_forlua/widget/worldmap/territory/territorymark_mediah_large.dds",
    [5] = "new_ui_common_forlua/widget/worldmap/territory/territorymark_valencia_large.dds",
    [6] = "new_ui_common_forlua/widget/worldmap/territory/territorymark_kamasylvia_large.dds"
  },
  _UV = {
    x1 = 0,
    y1 = 0,
    x2 = 256,
    y2 = 256
  }
}
local territoryIndex = {
  [1] = 0,
  [2] = 1,
  [3] = 2,
  [4] = 3,
  [5] = 4,
  [6] = 6
}
local minorSiegeViewDistance = {
  [0] = 330000,
  [1] = 230000,
  [2] = 430000,
  [3] = 370000,
  [4] = 490000,
  [6] = 350000
}
local majorSiegeViewDistance = {
  [2] = 180000,
  [3] = 100000,
  [4] = 400000
}
local oceanSiegeCameraInfo = {
  pos = float3(-64014, -4371, 272063),
  distance = 330000
}
local gradeString = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_LOW_LEVEL"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_MIDDLE_LEVEL"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_SIEGENODE_HIGH_LEVEL")
}
worldmapGrand.ui.list_scrollBtn = UI.getChildControl(worldmapGrand.ui.list_scroll, "Scroll_CtrlButton")
worldmapGrand.ui.daySelectBg:SetShow(false)
worldmapGrand.ui.daySelectTitle:SetShow(false)
worldmapGrand.ui.comboBox_DaySelect:SetShow(false)
worldmapGrand.ui.comboBox_TaxGrade:SetShow(false)
worldmapGrand.ui.btn_SiegeTerritoryFilter:SetShow(false)
worldmapGrand.ui.daySelectTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_GUILDWARFILTER"))
worldmapGrand.ui.comboBox_DaySelect:addInputEvent("Mouse_LUp", "WorldMap_GuildWar_DayFilterShow()")
worldmapGrand.ui.comboBox_DaySelect:GetListControl():addInputEvent("Mouse_LUp", "GuildWar_SetDay()")
worldmapGrand.ui.comboBox_TaxGrade:addInputEvent("Mouse_LUp", "WorldMap_GuildWar_TaxGradeFilterShow()")
worldmapGrand.ui.comboBox_TaxGrade:GetListControl():addInputEvent("Mouse_LUp", "GuildWar_SetGrade()")
worldmapGrand.ui.comboBox_DaySelect:setListTextHorizonCenter()
worldmapGrand.ui.comboBox_TaxGrade:setListTextHorizonCenter()
worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(false)
worldmapGrand.ui.btn_TerritoryInfoMy:SetShow(false)
worldmapGrand.ui.nodeSelectBg:SetShow(false)
worldmapGrand.ui.nodeSelectTitle:SetShow(false)
worldmapGrand.ui.comboBox_TerritorySelect:setListTextHorizonCenter()
worldmapGrand.ui.comboBox_NodeType:setListTextHorizonCenter()
worldmapGrand.ui.comboBox_TerritorySelect:SetShow(false)
worldmapGrand.ui.comboBox_NodeType:SetShow(false)
worldmapGrand.ui.nodeSelectTitle:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_PRODUCTNODEFILTER"))
worldmapGrand.ui.comboBox_TerritorySelect:addInputEvent("Mouse_LUp", "WorldMap_TerritorySelect_Show()")
worldmapGrand.ui.comboBox_TerritorySelect:GetListControl():addInputEvent("Mouse_LUp", "TerritorySelect_Set()")
worldmapGrand.ui.comboBox_NodeType:addInputEvent("Mouse_LUp", "WorldMap_ProductNodeType_Show()")
worldmapGrand.ui.comboBox_NodeType:GetListControl():addInputEvent("Mouse_LUp", "ProductNodeType_Set()")
worldmapGrand._territoryInfoBasePosY = worldmapGrand.ui.stc_TerritoryInfoTitle:GetPosY()
worldmapGrand._territoryFilterBgBaseSizeY = worldmapGrand.ui.stc_SiegeTerritoryFilterBG:GetSizeY()
if nil ~= territoryFilterBG then
  territoryFilterBG:SetShow(false)
end
worldmapGrand.ui.stc_HardCoreBg:SetShow(false)
local dayString = {
  [UI_VT.eVillageSiegeType_Sunday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SUNDAY_COLOR"),
  [UI_VT.eVillageSiegeType_Monday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_MONDAY_COLOR"),
  [UI_VT.eVillageSiegeType_Tuesday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_TUESDAY_COLOR"),
  [UI_VT.eVillageSiegeType_Wednesday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_WEDNESDAY_COLOR"),
  [UI_VT.eVillageSiegeType_Thursday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_THUSDAY_COLOR"),
  [UI_VT.eVillageSiegeType_Friday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_FRIDAY_COLOR"),
  [UI_VT.eVillageSiegeType_Saturday] = PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SATURDAY_COLOR")
}
function WorldMap_ContributorPoint_Init()
  local self = worldmapGrand
  self.ui.explorePointBG = UI.getChildControl(Panel_WorldMap_Main, "MainMenu_Static_ExplorePoint_Bg")
  self.ui.explorePointIcon = UI.getChildControl(self.ui.explorePointBG, "MainMenu_ExplorePoint_Icon")
  self.ui.explorePointValue = UI.getChildControl(self.ui.explorePointBG, "MainMenu_StaticText_ExplorePoint_Value")
end
WorldMap_ContributorPoint_Init()
function WorldMap_GuildWar_DayFilterShow()
  worldmapGrand.ui.comboBox_DaySelect:DeleteAllItem()
  local count = 0
  for index = 0, UI_VT.eVillageSiegeType_Count do
    if 0 == index then
      worldmapGrand.ui.comboBox_DaySelect:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"), index)
    else
      worldmapGrand.ui.comboBox_DaySelect:AddItem(dayString[index - 1], index)
    end
    count = count + 1
  end
  worldmapGrand.ui.comboBox_DaySelect:GetListControl():SetSize(worldmapGrand.ui.comboBox_DaySelect:GetSizeX(), count * 17)
  worldmapGrand.ui.comboBox_DaySelect:ToggleListbox()
end
function GuildWar_SetDay()
  local selectIndex = worldmapGrand.ui.comboBox_DaySelect:GetSelectIndex()
  if 0 == selectIndex then
    ToClient_resetVisibleVillageSiegeType()
    worldmapGrand.ui.comboBox_DaySelect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"))
  else
    ToClient_setVisibleVillageSiegeType(selectIndex - 1)
    worldmapGrand.ui.comboBox_DaySelect:SetText(dayString[selectIndex - 1])
  end
  worldmapGrand.ui.comboBox_DaySelect:ToggleListbox()
end
function GuildWar_SetType()
  worldmapGrand.ui.btn_majorSiege:SetCheck(worldmapGrand._isMajorSiegeView)
  worldmapGrand.ui.btn_minorSiege:SetCheck(not worldmapGrand._isMajorSiegeView)
end
function GuildWar_SetDayUseIndex(selectIndex, isNotToggle)
  if 0 == selectIndex then
    ToClient_resetVisibleVillageSiegeType()
    worldmapGrand.ui.comboBox_DaySelect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"))
  else
    ToClient_setVisibleVillageSiegeType(selectIndex - 1)
    worldmapGrand.ui.comboBox_DaySelect:SetText(dayString[selectIndex - 1])
  end
  if nil == isNotToggle or false == isNotToggle then
    worldmapGrand.ui.comboBox_DaySelect:ToggleListbox()
  end
end
local maxTaxGrade = 4
function WorldMap_GuildWar_TaxGradeFilterShow()
  maxTaxGrade = 6
  worldmapGrand.ui.comboBox_TaxGrade:DeleteAllItem()
  local count = 0
  for index = 0, maxTaxGrade do
    if index ~= 1 and index ~= 2 then
      if 0 == index then
        worldmapGrand.ui.comboBox_TaxGrade:AddItem(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"), index)
      else
        local tempString = ""
        local taxGrade = index - 1
        local taxLevel
        tempString = "LUA_NODEGRADE_"
        if 0 == taxGrade then
          taxLevel = 0
        elseif 1 == taxGrade then
          taxLevel = 1
        elseif 2 == taxGrade then
          taxLevel = 0
        elseif 3 == taxGrade then
          taxLevel = 2
        elseif 4 == taxGrade then
          taxLevel = 3
        elseif 5 == taxGrade then
          taxLevel = 4
        end
        tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxLevel))
        local isShow = true
        if 0 == taxLevel and 2 == taxGrade then
          isShow = false
          count = count - 1
        end
        if true == isShow then
          worldmapGrand.ui.comboBox_TaxGrade:AddItem(tempString)
        end
      end
      count = count + 1
    end
  end
  worldmapGrand.ui.comboBox_TaxGrade:GetListControl():SetSize(worldmapGrand.ui.comboBox_TaxGrade:GetSizeX(), count * 16)
  worldmapGrand.ui.comboBox_TaxGrade:ToggleListbox()
end
function GuildWar_SetGrade()
  if worldmapGrand.ui.comboBox_TaxGrade:GetSelectIndex() == -1 then
    return
  end
  local selectIndex = worldmapGrand.ui.comboBox_TaxGrade:GetSelectIndex() - 1
  if -1 == selectIndex then
    ToClient_resetVisibleVillageSiegeTaxLevel()
    worldmapGrand.ui.comboBox_TaxGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"))
  else
    selectIndex = selectIndex + 2
    if selectIndex >= 2 then
      selectIndex = selectIndex + 1
    end
    ToClient_setVisibleVillageSiegeTaxLevel(selectIndex)
    local taxGrade = selectIndex
    local taxLevel
    tempString = "LUA_NODEGRADE_"
    if 0 == taxGrade then
      taxLevel = 0
    elseif 1 == taxGrade then
      taxLevel = 1
    elseif 2 == taxGrade then
      taxLevel = 0
    elseif 3 == taxGrade then
      taxLevel = 2
    elseif 4 == taxGrade then
      taxLevel = 3
    elseif 5 == taxGrade then
      taxLevel = 4
    end
    tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxLevel))
    worldmapGrand.ui.comboBox_TaxGrade:SetText(tempString)
  end
  worldmapGrand.ui.comboBox_TaxGrade:ToggleListbox()
end
function GuildWar_SetGradeUseIndex(selectIndex, isNotToggle)
  if -1 == selectIndex then
    ToClient_resetVisibleVillageSiegeTaxLevel()
    worldmapGrand.ui.comboBox_TaxGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDEFALUT"))
  else
    ToClient_setVisibleVillageSiegeTaxLevel(selectIndex)
    local taxGrade = selectIndex
    local taxLevel
    local gradeText = ""
    tempString = "LUA_NODEGRADE_"
    if 0 == taxGrade then
      taxLevel = 0
    elseif 1 == taxGrade then
      taxLevel = 1
    elseif 2 == taxGrade then
      taxLevel = 0
    elseif 3 == taxGrade then
      taxLevel = 2
    elseif 4 == taxGrade then
      taxLevel = 3
    elseif 5 == taxGrade then
      taxLevel = 4
    end
    tempString = PAGetString(Defines.StringSheet_GAME, tempString .. tostring(taxLevel)) .. " " .. gradeText
    worldmapGrand.ui.comboBox_TaxGrade:SetText(tempString)
  end
  if nil == isNotToggle or false == isNotToggle then
    worldmapGrand.ui.comboBox_TaxGrade:ToggleListbox()
  end
end
function FGlobal_WorldmapMain_IsAllowTutorialPanelShow()
  return worldmapGrand._isAllowTutorialPanelShow
end
function FGlobal_WorldmapMain_SetAllowTutorialPanelShow(bAllow)
  worldmapGrand._isAllowTutorialPanelShow = bAllow
end
function FGlobal_WorldmapMain_InitTutorialButton()
  if 20 <= getSelfPlayer():get():getLevel() or true == questList_isClearQuest(654, 4) then
    FGlobal_WorldmapMain_SetShowBlackSpiritButton(_ContentsGroup_Tutorial_After_Renewal_Valid)
  else
    FGlobal_WorldmapMain_SetShowBlackSpiritButton(false)
  end
  local wui = worldmapGrand.ui
  local blackSpiritButtonPosX = getScreenSizeX() - wui.buttonBlackSpirit:GetSizeX() - 20
  local blackSpiritButtonPosY = worldmapGrand.ui.nodeSelectBg:GetPosY() + worldmapGrand.ui.nodeSelectBg:GetSizeY() + 30
  wui.buttonBlackSpirit:SetPosX(blackSpiritButtonPosX)
  wui.buttonBlackSpirit:SetPosY(blackSpiritButtonPosY)
  wui.buttonTutorial_1:SetShow(false, false)
  wui.buttonTutorial_2:SetShow(false, false)
  wui.buttonTutorial_3:SetShow(false, false)
  wui.buttonTutorial_1:SetPosX(getScreenSizeX() - wui.buttonTutorial_1:GetSizeX() - 10)
  wui.buttonTutorial_1:SetPosY(wui.buttonBlackSpirit:GetPosY() + wui.buttonBlackSpirit:GetSizeY() + 5)
  wui.buttonTutorial_2:SetPosX(getScreenSizeX() - wui.buttonTutorial_2:GetSizeX() - 10)
  wui.buttonTutorial_2:SetPosY(wui.buttonTutorial_1:GetPosY() + wui.buttonTutorial_1:GetSizeY() + 5)
  wui.buttonTutorial_3:SetPosX(getScreenSizeX() - wui.buttonTutorial_3:GetSizeX() - 10)
  wui.buttonTutorial_3:SetPosY(wui.buttonTutorial_2:GetPosY() + wui.buttonTutorial_2:GetSizeY() + 5)
end
function HandleClicked_GrandWorldMap_TutorialButton(buttonNum)
  PaGlobal_TutorialManager:handleClickWorldmapTutorialButton(buttonNum)
end
function FGlobal_WorldmapMain_SetShowBlackSpiritButton(bShow)
  worldmapGrand.ui.buttonBlackSpirit:SetShow(bShow, true)
end
function HandleClicked_GrandWorldMap_BlackSpiritButton()
  local wui = worldmapGrand.ui
  wui.buttonBlackSpirit:AddEffect("fUI_Light", false, 0, 0)
  if true == wui.buttonTutorial_1:GetShow() or true == wui.buttonTutorial_1:GetShow() or true == wui.buttonTutorial_1:GetShow() then
    FGlobal_GrandWorldmap_SetShowTutorialButton(false)
  else
    FGlobal_GrandWorldmap_SetShowTutorialButton(true)
  end
end
function FGlobal_GrandWorldmap_SetShowTutorialButton(bshow)
  local wui = worldmapGrand.ui
  wui.buttonTutorial_1:SetShow(bshow, true)
  wui.buttonTutorial_2:SetShow(bshow, true)
  wui.buttonTutorial_3:SetShow(bshow, true)
end
function FGlobal_SetShow_WorldmapSearchUi(bShow)
  FGlobal_SetShow_WorldmapSearchMenu(bShow)
  FGlobal_SetShow_WorldmapExplorePoint(bShow)
end
function FGlobal_SetShow_WorldmapExplorePoint(bShow)
  worldmapGrand.ui.explorePointBG:SetShow(bShow)
  worldmapGrand.ui.explorePointIcon:SetShow(bShow)
  worldmapGrand.ui.explorePointValue:SetShow(false)
end
function FGlobal_SetShow_WorldmapSearchAndMenu(bShow)
  if _ContentsGroup_WorldMapMenuFilter == true then
    worldmapGrand.ui.chk_contentsList:SetShow(bShow)
    worldmapGrand.ui.chk_search:SetShow(bShow)
  end
end
function FGlobal_SetShow_WorldmapSearchMenu(bShow)
  worldmapGrand.ui.MainMenuBG:SetShow(bShow)
  worldmapGrand.ui.edit_NodeName:SetShow(bShow)
  worldmapGrand.ui.btn_SearchNodeName:SetShow(bShow)
  worldmapGrand.ui.edit_ItemName:SetShow(bShow)
  worldmapGrand.ui.btn_SearchItemName:SetShow(bShow)
  worldmapGrand.ui.edit_UseType:SetShow(bShow)
  worldmapGrand.ui.btn_SearchUseType:SetShow(bShow)
  worldmapGrand.ui.edit_GuildName:SetShow(bShow)
  worldmapGrand.ui.btn_SearchGuildName:SetShow(bShow)
  worldmapGrand.ui.ListBG:SetShow(bShow)
  worldmapGrand.ui.list_KeyWord:SetShow(bShow)
  worldmapGrand.ui.list_SearchBG:SetShow(bShow)
  worldmapGrand.ui.list_scroll:SetShow(bShow)
  if _ContentsGroup_WorldMapMenuFilter == true then
    worldmapGrand.ui.list_Title:SetShow(false)
  else
    worldmapGrand.ui.list_Title:SetShow(bShow)
  end
end
function FGlobal_GetShow_WorldmapSearchMenu()
  return worldmapGrand.ui.MainMenuBG:GetShow()
end
function FGlobal_GetShow_WorldmapContentsMenu()
  return worldmapGrand.ui.list2_contents:GetShow()
end
function FGlobal_SetCheck_WorldmapSearchMenu(isCheck)
  worldmapGrand.ui.chk_search:SetCheck(isCheck)
end
function FGlobal_SetCheck_WorldmapContentsMenu(isCheck)
  worldmapGrand.ui.chk_contentsList:SetCheck(isCheck)
end
function FGlobal_WorldmapMain_AddEffectUiNodeButtonByWaypointKey(waypointKey, effectName, isLoop, offsetX, offsetY)
  local uiNodeButton = ToClient_FindNodeButtonByWaypointKey(waypointKey)
  if nil ~= uiNodeButton then
    uiNodeButton:AddEffect(effectName, isLoop, offsetX, offsetY)
  end
end
function FGlobal_WorldmapMain_EraseAllEffectUiNodeButtonByWaypointKey(waypointKey)
  local uiNodeButton = ToClient_FindNodeButtonByWaypointKey(waypointKey)
  if nil ~= uiNodeButton then
    uiNodeButton:EraseAllEffect()
  end
end
local eventTempControl
function FGlobal_WorldmapMain_GetOrCreateEventTempControl(eventName, targetUi, parentPanel, color)
  eventTempControl = UI.getChildControl(parentPanel, "Static_Temp_MouseOn")
  if nil ~= eventTempControl then
    return eventTempControl
  end
  eventTempControl = UI.createControl(__ePAUIControl_Static, parentPanel, "Static_Temp_MouseOn")
  eventTempControl:addInputEvent(eventName, "FGlobal_WorldmapMain_HandleEventTempControl()")
  eventTempControl:ChangeTextureInfoNameAsync("new_ui_common_forlua/default/Default_Etc_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(eventTempControl, 111, 60, 112, 61)
  eventTempControl:getBaseTexture():setUV(x1, y1, x2, y2)
  eventTempControl:setRenderTexture(eventTempControl:getBaseTexture())
  eventTempControl:SetPosX(targetUi:GetPosX())
  eventTempControl:SetPosY(targetUi:GetPosY())
  eventTempControl:SetSize(targetUi:GetSizeX(), targetUi:GetSizeY())
  local decidedColor = Defines.Color.C_FFFFCE22
  if nil ~= color then
    decidedColor = color
  end
  eventTempControl:SetColor(decidedColor)
  eventTempControl:SetShow(true)
  return eventTempControl
end
function FGlobal_WorldmapMain_GetEventTempControl()
  return eventTempControl
end
function FGlobal_WorldmapMain_HandleEventTempControl()
  PaGlobal_TutorialManager:handleWorldmapMainEventTempControl()
end
local toAlpha = 0
local currAlpha = 0
function FGlobal_WorldmapMain_PerFrameAlphaAnimationEventTempControl(minAlpha, maxAlpha, RateWithDeltaTime)
  if nil ~= eventTempControl then
    currAlpha = eventTempControl:GetAlpha()
    if maxAlpha <= currAlpha + 0.01 then
      toAlpha = minAlpha
    elseif minAlpha >= currAlpha - 0.01 then
      toAlpha = maxAlpha
    end
    UIAni.perFrameAlphaAnimation(toAlpha, eventTempControl, RateWithDeltaTime)
  end
end
Panel_WorldMap_Main:SetShow(false, false)
worldmapGrand.template.templateButton:SetShow(false)
worldmapGrand.template.templateCheck:SetShow(false)
worldmapGrand.template.templateRadio:SetShow(false)
local worldMapState = {}
local worldMapCheckState = {}
local worldMapNodeListType = {}
local worldMapMenuState = {}
function FGlobal_WorldmapMain_GetWorldmapModeButtonList()
  return worldMapState
end
function FGlobal_WorldmapMain_GetWorldmapCheckButtonList()
  return worldMapCheckState
end
local worldMapCheckStateInMode = {
  [eWorldmapState.eWMS_EXPLORE_PLANT] = {},
  [eWorldmapState.eWMS_REGION] = {},
  [eWorldmapState.eWMS_LOCATION_INFO_WATER] = {},
  [eWorldmapState.eWMS_LOCATION_INFO_CELCIUS] = {},
  [eWorldmapState.eWMS_LOCATION_INFO_HUMIDITY] = {},
  [eWorldmapState.eWMS_GUILD_WAR] = {},
  [eWorldmapState.eWMS_PRODUCT_NODE] = {},
  [eWorldmapState.eWMS_FAMILY_CHARACTER] = {}
}
local modeTexture = {
  [eWorldmapState.eWMS_EXPLORE_PLANT] = {
    [0] = {
      1,
      34,
      53,
      86
    },
    [1] = {
      1,
      87,
      53,
      139
    },
    [2] = {
      1,
      140,
      53,
      192
    }
  },
  [eWorldmapState.eWMS_REGION] = {
    [0] = {
      54,
      34,
      106,
      86
    },
    [1] = {
      54,
      87,
      106,
      139
    },
    [2] = {
      54,
      140,
      106,
      192
    }
  },
  [eWorldmapState.eWMS_LOCATION_INFO_WATER] = {
    [0] = {
      107,
      34,
      159,
      86
    },
    [1] = {
      107,
      87,
      159,
      139
    },
    [2] = {
      107,
      140,
      159,
      192
    }
  },
  [eWorldmapState.eWMS_LOCATION_INFO_CELCIUS] = {
    [0] = {
      160,
      34,
      212,
      86
    },
    [1] = {
      160,
      87,
      212,
      139
    },
    [2] = {
      160,
      140,
      212,
      192
    }
  },
  [eWorldmapState.eWMS_LOCATION_INFO_HUMIDITY] = {
    [0] = {
      213,
      34,
      265,
      86
    },
    [1] = {
      213,
      87,
      265,
      139
    },
    [2] = {
      213,
      140,
      265,
      192
    }
  },
  [eWorldmapState.eWMS_GUILD_WAR] = {
    [0] = {
      266,
      34,
      318,
      86
    },
    [1] = {
      266,
      87,
      318,
      139
    },
    [2] = {
      266,
      140,
      318,
      192
    }
  },
  [eWorldmapState.eWMS_PRODUCT_NODE] = {
    [0] = {
      319,
      34,
      371,
      86
    },
    [1] = {
      319,
      87,
      371,
      139
    },
    [2] = {
      319,
      140,
      371,
      192
    }
  },
  [eWorldmapState.eWMS_FAMILY_CHARACTER] = {
    [0] = {
      425,
      34,
      477,
      86
    },
    [1] = {
      425,
      87,
      477,
      139
    },
    [2] = {
      425,
      140,
      477,
      192
    }
  }
}
local function changeModeTexture(modeType)
  local control = worldMapState[modeType]
  local posArray = modeTexture[modeType]
  control:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Btn_01.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[0][1], posArray[0][2], posArray[0][3], posArray[0][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:ChangeOnTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Btn_01.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[1][1], posArray[1][2], posArray[1][3], posArray[1][4])
  control:getOnTexture():setUV(x1, y1, x2, y2)
  control:ChangeClickTextureInfoNameAsync("Renewal/PcRemaster/Remaster_Btn_01.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[2][1], posArray[2][2], posArray[2][3], posArray[2][4])
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
local modeFilterTexture = {
  [eCheckState.eCheck_Quest] = {
    [0] = {
      32,
      1,
      62,
      31
    },
    [1] = {
      32,
      63,
      62,
      93
    },
    [2] = {
      32,
      125,
      62,
      155
    }
  },
  [eCheckState.eCheck_Knowledge] = {
    [0] = {
      1,
      1,
      31,
      31
    },
    [1] = {
      1,
      63,
      31,
      93
    },
    [2] = {
      1,
      125,
      31,
      155
    }
  },
  [eCheckState.eCheck_FishnChip] = {
    [0] = {
      63,
      32,
      93,
      62
    },
    [1] = {
      63,
      94,
      93,
      124
    },
    [2] = {
      63,
      156,
      93,
      186
    }
  },
  [eCheckState.eCheck_Node] = {
    [0] = {
      32,
      32,
      62,
      62
    },
    [1] = {
      32,
      94,
      62,
      124
    },
    [2] = {
      32,
      156,
      62,
      186
    }
  },
  [eCheckState.eCheck_Way] = {
    [0] = {
      94,
      1,
      124,
      31
    },
    [1] = {
      94,
      63,
      124,
      93
    },
    [2] = {
      94,
      125,
      124,
      155
    }
  },
  [eCheckState.eCheck_Postions] = {
    [0] = {
      1,
      32,
      31,
      62
    },
    [1] = {
      1,
      94,
      31,
      124
    },
    [2] = {
      1,
      156,
      31,
      186
    }
  },
  [eCheckState.eCheck_Trade] = {
    [0] = {
      94,
      32,
      124,
      62
    },
    [1] = {
      94,
      94,
      124,
      124
    },
    [2] = {
      94,
      156,
      124,
      186
    }
  },
  [eCheckState.eCheck_Wagon] = {
    [0] = {
      125,
      1,
      155,
      31
    },
    [1] = {
      125,
      63,
      155,
      93
    },
    [2] = {
      125,
      125,
      155,
      155
    }
  },
  [eCheckState.eCheck_Monster] = {
    [0] = {
      63,
      1,
      93,
      31
    },
    [1] = {
      63,
      63,
      93,
      93
    },
    [2] = {
      63,
      125,
      93,
      155
    }
  },
  [eCheckState.eCheck_MyBossMonster] = {
    [0] = {
      125,
      206,
      155,
      236
    },
    [1] = {
      125,
      237,
      155,
      267
    },
    [2] = {
      125,
      268,
      155,
      298
    }
  },
  [eCheckState.eCheck_Barter] = {
    [0] = {
      1,
      280,
      31,
      310
    },
    [1] = {
      1,
      311,
      31,
      341
    },
    [2] = {
      1,
      342,
      31,
      372
    }
  }
}
local function changeModeFilterTexture(modeFilterType)
  local control = worldMapCheckState[modeFilterType]
  local posArray = modeFilterTexture[modeFilterType]
  control:ChangeTextureInfoNameAsync("Renewal/PcRemaster/Remaster_WorldMap_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[0][1], posArray[0][2], posArray[0][3], posArray[0][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:ChangeOnTextureInfoNameAsync("Renewal/PcRemaster/Remaster_WorldMap_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[1][1], posArray[1][2], posArray[1][3], posArray[1][4])
  control:getOnTexture():setUV(x1, y1, x2, y2)
  control:ChangeClickTextureInfoNameAsync("Renewal/PcRemaster/Remaster_WorldMap_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[2][1], posArray[2][2], posArray[2][3], posArray[2][4])
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
local worldMapNodeType = {
  normal = 0,
  viliage = 1,
  city = 2,
  gate = 3,
  trade = 5,
  dangerous = 9
}
function FGlobal_WorldmapMain_GetWorldmapNodeType()
  return worldMapNodeType
end
local nodeList = {
  [0] = worldMapNodeType.normal,
  [1] = worldMapNodeType.viliage,
  [2] = worldMapNodeType.city,
  [3] = worldMapNodeType.gate,
  [4] = worldMapNodeType.trade,
  [5] = worldMapNodeType.dangerous
}
local nodeListCount = 6
local nodeTexture = {
  [worldMapNodeType.normal] = {
    [0] = {
      2,
      2,
      42,
      42
    },
    [1] = {
      2,
      2,
      42,
      42
    },
    [2] = {
      2,
      43,
      42,
      83
    }
  },
  [worldMapNodeType.viliage] = {
    [0] = {
      43,
      2,
      83,
      42
    },
    [1] = {
      43,
      2,
      83,
      42
    },
    [2] = {
      43,
      43,
      83,
      83
    }
  },
  [worldMapNodeType.city] = {
    [0] = {
      84,
      2,
      124,
      42
    },
    [1] = {
      84,
      2,
      124,
      42
    },
    [2] = {
      84,
      43,
      124,
      83
    }
  },
  [worldMapNodeType.gate] = {
    [0] = {
      125,
      2,
      165,
      42
    },
    [1] = {
      125,
      2,
      165,
      42
    },
    [2] = {
      125,
      43,
      165,
      83
    }
  },
  [worldMapNodeType.trade] = {
    [0] = {
      166,
      2,
      206,
      42
    },
    [1] = {
      166,
      2,
      206,
      42
    },
    [2] = {
      166,
      43,
      206,
      83
    }
  },
  [worldMapNodeType.dangerous] = {
    [0] = {
      207,
      2,
      247,
      42
    },
    [1] = {
      207,
      2,
      247,
      42
    },
    [2] = {
      207,
      43,
      247,
      83
    }
  }
}
local worldMapNodeType_String = {
  [worldMapNodeType.normal] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPE_NORMAL"),
  [worldMapNodeType.viliage] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPE_VILIAGE"),
  [worldMapNodeType.city] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPE_CITY"),
  [worldMapNodeType.gate] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPE_GATE"),
  [worldMapNodeType.trade] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPE_TRADE"),
  [worldMapNodeType.dangerous] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPE_DANGEROUS")
}
local worldMapNodeTypeString = {
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_0"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_1"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_2"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_3"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_4"),
  [5] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_5"),
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_6"),
  [7] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODETYPE_7")
}
local worldMapNodeTypeIndex = {
  [0] = -1,
  [1] = CppEnums.ExplorationNodeType.eExplorationNodeType_Farm,
  [2] = CppEnums.ExplorationNodeType.eExplorationNodeType_Collect,
  [3] = CppEnums.ExplorationNodeType.eExplorationNodeType_Quarry,
  [4] = CppEnums.ExplorationNodeType.eExplorationNodeType_Logging,
  [5] = CppEnums.ExplorationNodeType.eExplorationNodeType_Craft,
  [6] = CppEnums.ExplorationNodeType.eExplorationNodeType_Excavation,
  [7] = CppEnums.ExplorationNodeType.eExplorationNodeType_MonopolyFarm
}
local btnArray = {}
local _selectNodeType = -1
local _selectTerritory = -1
function WorldMap_ProductNodeType_Show()
  worldmapGrand.ui.comboBox_NodeType:DeleteAllItem()
  local count = 0
  for index = 0, #worldMapNodeTypeString do
    worldmapGrand.ui.comboBox_NodeType:AddItem(worldMapNodeTypeString[index])
    count = count + 1
  end
  worldmapGrand.ui.comboBox_NodeType:GetListControl():SetSize(worldmapGrand.ui.comboBox_NodeType:GetSizeX(), count * 17)
  worldmapGrand.ui.comboBox_NodeType:ToggleListbox()
end
function ProductNodeType_Set()
  local selectIndex = worldmapGrand.ui.comboBox_NodeType:GetSelectIndex()
  worldmapGrand.ui.comboBox_NodeType:SetText(worldMapNodeTypeString[selectIndex])
  _selectNodeType = selectIndex
  WorldMapArrowEffectErase()
  if -1 ~= worldMapNodeTypeIndex[selectIndex] then
    ToClient_FilterNodeType(_selectTerritory, worldMapNodeTypeIndex[selectIndex])
  end
  worldmapGrand.ui.comboBox_NodeType:ToggleListbox()
end
function PrevNodeType_Set()
  WorldMapArrowEffectErase()
  if -1 ~= _selectNodeType then
    ToClient_FilterNodeType(_selectTerritory, worldMapNodeTypeIndex[_selectNodeType])
  end
end
local territoryString = {
  [-1] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_ALL"),
  [0] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_0"),
  [1] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_1"),
  [2] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_2"),
  [3] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_3"),
  [4] = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_4"),
  [5] = "\235\158\143 \237\149\173\234\181\172",
  [6] = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_6"),
  [7] = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_7"),
  [8] = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_8"),
  [9] = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_9"),
  [10] = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_10"),
  [11] = PAGetString(Defines.StringSheet_GAME, "LUA_TERRITORYNAME_11")
}
function WorldMap_TerritorySelect_Show()
  worldmapGrand.ui.comboBox_TerritorySelect:DeleteAllItem()
  local count = 0
  for index = -1, #territoryString do
    if 5 ~= index and territoryString[index] ~= "" then
      worldmapGrand.ui.comboBox_TerritorySelect:AddItem(territoryString[index])
      count = count + 1
    end
  end
  worldmapGrand.ui.comboBox_TerritorySelect:GetListControl():SetSize(worldmapGrand.ui.comboBox_TerritorySelect:GetSizeX(), count * 18)
  worldmapGrand.ui.comboBox_TerritorySelect:GetListControl():SetItemQuantity(count)
  worldmapGrand.ui.comboBox_TerritorySelect:ToggleListbox()
end
function TerritorySelect_Set()
  local selectIndex = worldmapGrand.ui.comboBox_TerritorySelect:GetSelectIndex()
  if selectIndex > 5 then
    selectIndex = selectIndex + 1
  end
  worldmapGrand.ui.comboBox_TerritorySelect:SetText(territoryString[selectIndex - 1])
  _selectTerritory = selectIndex - 1
  if _selectNodeType > -1 then
    WorldMapArrowEffectErase()
    ToClient_FilterNodeType(_selectTerritory, worldMapNodeTypeIndex[_selectNodeType])
  end
  worldmapGrand.ui.comboBox_TerritorySelect:ToggleListbox()
end
local worldmapGrand_SearchType = {
  nodeName = 0,
  itemName = 1,
  nodeType = 2,
  UseType = 3,
  GuildName = 4
}
local _isGuildWarMode = false
local _isBlackFog = false
local _currentRenderMode = eWorldmapState.eWMS_EXPLORE_PLANT
local function MoveSearchUI()
  worldmapGrand.ui.MainMenuBG:SetSpanSize(10, 55)
  local uiControl = worldmapGrand.ui
  uiControl.edit_NodeName:SetPosX(20)
  uiControl.btn_SearchNodeName:SetPosX(199)
  uiControl.edit_ItemName:SetPosX(20)
  uiControl.btn_SearchItemName:SetPosX(199)
  uiControl.edit_UseType:SetPosX(20)
  uiControl.btn_SearchUseType:SetPosX(199)
  uiControl.edit_GuildName:SetPosX(20)
  uiControl.btn_SearchGuildName:SetPosX(199)
  local seachBoxStartPosY = worldMapNodeListType[nodeList[nodeListCount - 1]]:GetPosY() + worldMapNodeListType[nodeList[nodeListCount - 1]]:GetSizeY() + 57
  uiControl.edit_NodeName:SetPosY(seachBoxStartPosY)
  uiControl.btn_SearchNodeName:SetPosY(seachBoxStartPosY)
  uiControl.edit_ItemName:SetPosY(uiControl.edit_NodeName:GetPosY() + uiControl.edit_NodeName:GetSizeY() + 4)
  uiControl.btn_SearchItemName:SetPosY(uiControl.edit_NodeName:GetPosY() + uiControl.edit_NodeName:GetSizeY() + 4)
  uiControl.edit_UseType:SetPosY(uiControl.edit_ItemName:GetPosY() + uiControl.edit_ItemName:GetSizeY() + 4)
  uiControl.btn_SearchUseType:SetPosY(uiControl.edit_ItemName:GetPosY() + uiControl.edit_ItemName:GetSizeY() + 4)
  uiControl.edit_GuildName:SetPosY(uiControl.edit_UseType:GetPosY() + uiControl.edit_UseType:GetSizeY() + 4)
  uiControl.btn_SearchGuildName:SetPosY(uiControl.edit_UseType:GetPosY() + uiControl.edit_UseType:GetSizeY() + 4)
  for idx = 0, worldmapGrand.config.searchingResultMaxCount - 1 do
    worldmapGrand.searchResultUiPool[idx]:SetPosX(4)
    worldmapGrand.searchResultUiPool[idx]:SetPosY(50 + worldmapGrand.searchResultUiPool[idx]:GetSizeY() * idx)
  end
  worldmapGrand.ui.ListBG:SetSpanSize(10, 314)
  worldmapGrand.ui.list_Title:SetSpanSize(190, 87)
  worldmapGrand.ui.list_KeyWord:SetSpanSize(23, 292)
  worldmapGrand.ui.list_scroll:SetSpanSize(224, 314)
  worldmapGrand.ui.explorePointBG:SetPosX(90)
  worldmapGrand.ui.explorePointBG:SetPosY(5)
  worldmapGrand.ui.explorePointBG:SetSize(170, 40)
  worldmapGrand.ui.explorePointBG:ChangeTextureInfoTextureIDAsync("Combine_Etc_Wight_WorldMap_Contribution_BG")
  local x1, y1, x2, y2 = setTextureUV_Func(worldmapGrand.ui.explorePointBG, 200, 37, 235, 77)
  worldmapGrand.ui.explorePointBG:getBaseTexture():setUV(x1, y1, x2, y2)
  worldmapGrand.ui.explorePointBG:setRenderTexture(worldmapGrand.ui.explorePointBG:getBaseTexture())
  stc_contentsList:SetShow(true)
  stc_search:SetShow(true)
end
local function MakeModeButton()
  worldMapState[eWorldmapState.eWMS_EXPLORE_PLANT] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_Explore")
  worldMapState[eWorldmapState.eWMS_REGION] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_Region")
  worldMapState[eWorldmapState.eWMS_LOCATION_INFO_WATER] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_Water")
  worldMapState[eWorldmapState.eWMS_LOCATION_INFO_CELCIUS] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_Celcius")
  worldMapState[eWorldmapState.eWMS_LOCATION_INFO_HUMIDITY] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_Humidity")
  if _ContentsGroup_Siege == true then
    worldMapState[eWorldmapState.eWMS_GUILD_WAR] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_Guildwar")
  end
  worldMapState[eWorldmapState.eWMS_PRODUCT_NODE] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_ProductNode")
  if _ContentsGroup_WorldMapFamilyCharacterManagement == true then
    worldMapState[eWorldmapState.eWMS_FAMILY_CHARACTER] = UI.createControl(__ePAUIControl_RadioButton, Panel_WorldMap_Main, "Mode_Button_FamilyCharacter")
  end
  for modeIndex, value in pairs(worldMapState) do
    CopyBaseProperty(worldmapGrand.template.templateButton, value)
    value:addInputEvent("Mouse_LUp", "WorldMapStateChange(" .. modeIndex .. ", false)")
    value:addInputEvent("Mouse_On", "WorldMapStateChange_SimpleTooltips(true," .. modeIndex .. ")")
    value:addInputEvent("Mouse_Out", "WorldMapStateChange_SimpleTooltips( false )")
    value:setTooltipEventRegistFunc("WorldMapStateChange_SimpleTooltips(true," .. modeIndex .. ")")
    value:SetShow(true)
    value:SetEnable(true)
    value:SetGroup(0)
    changeModeTexture(modeIndex)
  end
end
local function MakeModeChekcState()
  if _ContentsGroup_WorldMapMenuFilter == true then
    worldMapMenuState[eCheckState.eCheck_Quest] = true
    worldMapMenuState[eCheckState.eCheck_Knowledge] = true
    worldMapMenuState[eCheckState.eCheck_FishnChip] = true
    worldMapMenuState[eCheckState.eCheck_Node] = true
    worldMapMenuState[eCheckState.eCheck_Way] = true
    worldMapMenuState[eCheckState.eCheck_Postions] = true
    worldMapMenuState[eCheckState.eCheck_Trade] = true
    worldMapMenuState[eCheckState.eCheck_Wagon] = true
    worldMapMenuState[eCheckState.eCheck_Monster] = true
    if _ContentsGroup_NodeBoss == true then
      worldMapMenuState[eCheckState.eCheck_MyBossMonster] = true
    end
    if _ContentsGroup_Barter == true then
      worldMapMenuState[eCheckState.eCheck_Barter] = true
    end
    worldMapMenuState[eCheckState.eCheck_AbyssWell] = true
  else
    worldMapCheckState[eCheckState.eCheck_Quest] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Quest")
    worldMapCheckState[eCheckState.eCheck_Knowledge] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Knowledge")
    worldMapCheckState[eCheckState.eCheck_FishnChip] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Fishnchip")
    worldMapCheckState[eCheckState.eCheck_Node] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Node")
    worldMapCheckState[eCheckState.eCheck_Trade] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Trade")
    worldMapCheckState[eCheckState.eCheck_Way] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_WayGuide")
    worldMapCheckState[eCheckState.eCheck_Postions] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Positions")
    worldMapCheckState[eCheckState.eCheck_Wagon] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Carriage")
    worldMapCheckState[eCheckState.eCheck_Monster] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Monster")
    if true == _ContentsGroup_NodeBoss then
      worldMapCheckState[eCheckState.eCheck_MyBossMonster] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_MyBossMonster")
    end
    if true == _ContentsGroup_Barter then
      worldMapCheckState[eCheckState.eCheck_Barter] = UI.createControl(__ePAUIControl_CheckButton, Panel_WorldMap_Main, "CheckButton_Barter")
    end
    for checkIndex, value in pairs(worldMapCheckState) do
      if nil ~= worldMapCheckState then
        CopyBaseProperty(worldmapGrand.template.templateCheck, worldMapCheckState[checkIndex])
        worldMapCheckState[checkIndex]:addInputEvent("Mouse_LUp", "WorldMapCheckListChange(" .. checkIndex .. ")")
        worldMapCheckState[checkIndex]:addInputEvent("Mouse_RUp", "WorldMapCheckListChangeAll(" .. checkIndex .. ")")
        worldMapCheckState[checkIndex]:addInputEvent("Mouse_On", "WorldMapCheckListToolTips( true," .. checkIndex .. ")")
        worldMapCheckState[checkIndex]:addInputEvent("Mouse_Out", "WorldMapCheckListToolTips( false )")
        worldMapCheckState[checkIndex]:SetShow(true)
        worldMapCheckState[checkIndex]:SetEnable(true)
        changeModeFilterTexture(checkIndex)
      end
    end
  end
end
local function changeNodeTexture(nodeType)
  local control = worldMapNodeListType[nodeType]
  local posArray = nodeTexture[nodeType]
  control:ChangeTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_WorldMap_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[0][1], posArray[0][2], posArray[0][3], posArray[0][4])
  control:getBaseTexture():setUV(x1, y1, x2, y2)
  control:ChangeOnTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_WorldMap_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[1][1], posArray[1][2], posArray[1][3], posArray[1][4])
  control:getOnTexture():setUV(x1, y1, x2, y2)
  control:ChangeClickTextureInfoNameAsync("Renewal/UI_Icon/Console_Icon_WorldMap_00.dds")
  local x1, y1, x2, y2 = setTextureUV_Func(control, posArray[2][1], posArray[2][2], posArray[2][3], posArray[2][4])
  control:getClickTexture():setUV(x1, y1, x2, y2)
  control:setRenderTexture(control:getBaseTexture())
end
local function MakeNodeListType()
  worldMapNodeListType[worldMapNodeType.normal] = UI.createControl(__ePAUIControl_RadioButton, worldmapGrand.ui.MainMenuBG, "GrandWorldMap_NodeType_RadioButton_Normal")
  worldMapNodeListType[worldMapNodeType.viliage] = UI.createControl(__ePAUIControl_RadioButton, worldmapGrand.ui.MainMenuBG, "GrandWorldMap_NodeType_RadioButton_Viliage")
  worldMapNodeListType[worldMapNodeType.city] = UI.createControl(__ePAUIControl_RadioButton, worldmapGrand.ui.MainMenuBG, "GrandWorldMap_NodeType_RadioButton_City")
  worldMapNodeListType[worldMapNodeType.gate] = UI.createControl(__ePAUIControl_RadioButton, worldmapGrand.ui.MainMenuBG, "GrandWorldMap_NodeType_RadioButton_Gate")
  worldMapNodeListType[worldMapNodeType.trade] = UI.createControl(__ePAUIControl_RadioButton, worldmapGrand.ui.MainMenuBG, "GrandWorldMap_NodeType_RadioButton_Trade")
  worldMapNodeListType[worldMapNodeType.dangerous] = UI.createControl(__ePAUIControl_RadioButton, worldmapGrand.ui.MainMenuBG, "GrandWorldMap_NodeType_RadioButton_Dangerous")
  for checkIndex, value in pairs(worldMapNodeListType) do
    CopyBaseProperty(worldmapGrand.template.templateRadio, worldMapNodeListType[checkIndex])
    worldMapNodeListType[checkIndex]:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchNodeType(" .. checkIndex .. ")")
    worldMapNodeListType[checkIndex]:addInputEvent("Mouse_On", "worldmapGrand_nodeTypeTooltip( true," .. checkIndex .. ")")
    worldMapNodeListType[checkIndex]:addInputEvent("Mouse_Out", "worldmapGrand_nodeTypeTooltip( false )")
    worldMapNodeListType[checkIndex]:setTooltipEventRegistFunc("worldmapGrand_nodeTypeTooltip( true," .. checkIndex .. ")")
    worldMapNodeListType[checkIndex]:SetShow(true)
    worldMapNodeListType[checkIndex]:SetEnable(true)
  end
end
function FGlobal_WorldmapMain_GetNodeTypeRadioButton(nodeType)
  return worldMapNodeListType[nodeType]
end
function FGlobal_WorldmapMain_AddEffectNodeTypeRadioButton(nodeType, effectName, isLoop, offsetX, offsetY)
  worldMapNodeListType[nodeType]:AddEffect(effectName, isLoop, offsetX, offsetY)
end
function FGlobal_WorldmapMain_EraseAllEffectNodeTypeRadioButton(nodeType)
  worldMapNodeListType[nodeType]:EraseAllEffect()
end
local function nodeControl_SetTexture()
  for checkIndex = 0, nodeListCount - 1 do
    local value = nodeList[checkIndex]
    changeNodeTexture(value)
  end
end
local function MakeSearchResultPool()
  for idx = 0, worldmapGrand.config.searchingResultMaxCount - 1 do
    worldmapGrand.searchResultUiPool[idx] = UI.createAndCopyBasePropertyControl(Panel_WorldMap_Main, "List_itemName", worldmapGrand.ui.list_SearchBG, "WorldmapGrand_SearchResultList_" .. idx)
    worldmapGrand.searchResultUiPool[idx]:SetPosX(4)
    worldmapGrand.searchResultUiPool[idx]:SetPosY(5 + worldmapGrand.searchResultUiPool[idx]:GetSizeY() * idx)
    worldmapGrand.searchResultUiPool[idx]:SetText("")
    worldmapGrand.searchResultUiPool[idx]:SetShow(false)
  end
end
function FGlobal_WorldmapMain_GetSearchResultUiPool(index)
  return worldmapGrand.searchResultUiPool[index]
end
function FGlobal_WorldmapMain_GetSearchingResultCount()
  return worldmapGrand.config.searchingResultCount
end
local function AlignButtonPosition()
  if _ContentsGroup_WorldMapMenuFilter == true then
    worldmapGrand.ui.filterBg:SetShow(false)
  else
    local modeSizeX = 60
    local beginIndex = -1
    local modeCount = 0
    for modeIndex, value in pairs(worldMapState) do
      if value ~= nil then
        if beginIndex == -1 then
          beginIndex = modeIndex
        end
        modeCount = modeCount + 1
      end
    end
    local modeBtnOffsetX = getScreenSizeX() - modeSizeX * modeCount
    local modeII = 0
    for modeIndex, value in pairs(worldMapState) do
      value:SetPosX(modeBtnOffsetX + (value:GetSizeX() + 7) * modeII)
      value:SetPosY(15)
      modeII = modeII + 1
    end
    local showFilterCount = 0
    local filterBgSizeX = 0
    local filterBgSizeY = 0
    local filterBtnSizeX = 0
    local filterBtnSizeY = 0
    for checkIndex = 0, CppEnums.WorldMapCheckState.eCheck_MAX - 1 do
      if nil ~= worldMapCheckState[checkIndex] and true == worldMapCheckState[checkIndex]:GetShow() then
        if filterBtnSizeX < worldMapCheckState[checkIndex]:GetSizeX() then
          filterBtnSizeX = worldMapCheckState[checkIndex]:GetSizeX()
        end
        if filterBtnSizeY < worldMapCheckState[checkIndex]:GetSizeY() then
          filterBtnSizeY = worldMapCheckState[checkIndex]:GetSizeY()
        end
        showFilterCount = showFilterCount + 1
      end
    end
    filterBgSizeX = 10 + showFilterCount * (filterBtnSizeX + 10)
    filterBgSizeY = filterBtnSizeY + 4
    local filterBeginX = getScreenSizeX() - filterBgSizeX
    local iconIndex = 0
    for checkIndex = 0, CppEnums.WorldMapCheckState.eCheck_MAX - 1 do
      if nil ~= worldMapCheckState[checkIndex] and true == worldMapCheckState[checkIndex]:GetShow() then
        worldMapCheckState[checkIndex]:SetPosX(filterBeginX + (worldMapCheckState[checkIndex]:GetSizeX() + 10) * iconIndex)
        worldMapCheckState[checkIndex]:SetPosY(76)
        iconIndex = iconIndex + 1
      end
    end
    worldmapGrand.ui.filterBg:SetSize(filterBgSizeX, filterBgSizeY)
    worldmapGrand.ui.filterBg:SetPosX(worldMapCheckState[0]:GetPosX() - 10)
    worldmapGrand.ui.filterBg:SetPosY(worldMapCheckState[0]:GetPosY() - 2)
    worldmapGrand.ui.filterArrow:SetPosX(worldMapState[_currentRenderMode]:GetPosX() + worldMapState[_currentRenderMode]:GetSizeX() / 2 - worldmapGrand.ui.filterArrow:GetSizeX() / 2)
    worldmapGrand.ui.filterArrow:SetPosY(worldMapCheckState[0]:GetPosY() - worldmapGrand.ui.filterArrow:GetSizeY() - 3)
  end
  worldmapGrand.ui.daySelectBg:SetPosX(worldmapGrand.ui.filterBg:GetPosX() + worldmapGrand.ui.filterBg:GetSizeX() - worldmapGrand.ui.daySelectBg:GetSizeX())
  worldmapGrand.ui.daySelectBg:SetPosY(worldmapGrand.ui.filterBg:GetPosY() + worldmapGrand.ui.filterBg:GetSizeY() + 10)
  worldmapGrand.ui.daySelectTitle:SetPosX(worldmapGrand.ui.daySelectBg:GetPosX() + worldmapGrand.ui.daySelectBg:GetSizeX() / 2 - worldmapGrand.ui.daySelectTitle:GetSizeX() / 2)
  worldmapGrand.ui.daySelectTitle:SetPosY(worldmapGrand.ui.daySelectBg:GetPosY() + 5)
  worldmapGrand.ui.comboBox_DaySelect:SetPosX(worldmapGrand.ui.daySelectBg:GetPosX() + worldmapGrand.ui.daySelectBg:GetSizeX() - worldmapGrand.ui.comboBox_DaySelect:GetSizeX())
  worldmapGrand.ui.comboBox_DaySelect:SetPosY(worldmapGrand.ui.daySelectBg:GetPosY() + 35)
  worldmapGrand.ui.comboBox_TaxGrade:SetPosX(worldmapGrand.ui.daySelectBg:GetPosX())
  worldmapGrand.ui.comboBox_TaxGrade:SetPosY(worldmapGrand.ui.daySelectBg:GetPosY() + 35)
  worldmapGrand.ui.btn_TerritoryInfoMy:SetPosX(worldmapGrand.ui.comboBox_TaxGrade:GetPosX() - worldmapGrand.ui.btn_TerritoryInfoMy:GetSizeX() - 10)
  worldmapGrand.ui.btn_TerritoryInfoMy:SetPosY(worldmapGrand.ui.daySelectBg:GetPosY() + 35)
  worldmapGrand.ui.btn_TerritoryInfoAll:SetPosX(worldmapGrand.ui.btn_TerritoryInfoMy:GetPosX() - worldmapGrand.ui.btn_TerritoryInfoMy:GetSizeX() - 10)
  worldmapGrand.ui.btn_TerritoryInfoAll:SetPosY(worldmapGrand.ui.daySelectBg:GetPosY() + 35)
  if _ContentsGroup_WorldMapMenuFilter == true then
    worldmapGrand.ui.nodeSelectBg:SetPosX(getScreenSizeX() - worldmapGrand.ui.nodeSelectBg:GetSizeX() - 20)
    worldmapGrand.ui.nodeSelectBg:SetPosY(55)
  else
    worldmapGrand.ui.nodeSelectBg:SetPosX(worldmapGrand.ui.filterBg:GetPosX() + worldmapGrand.ui.filterBg:GetSizeX() - worldmapGrand.ui.nodeSelectBg:GetSizeX())
    worldmapGrand.ui.nodeSelectBg:SetPosY(worldmapGrand.ui.filterBg:GetPosY() + worldmapGrand.ui.filterBg:GetSizeY() + 10)
  end
  worldmapGrand.ui.nodeSelectTitle:SetPosX(worldmapGrand.ui.nodeSelectBg:GetPosX() + worldmapGrand.ui.nodeSelectBg:GetSizeX() / 2 - worldmapGrand.ui.nodeSelectTitle:GetSizeX() / 2)
  worldmapGrand.ui.nodeSelectTitle:SetPosY(worldmapGrand.ui.nodeSelectBg:GetPosY() + 5)
  worldmapGrand.ui.comboBox_NodeType:SetPosX(worldmapGrand.ui.nodeSelectBg:GetPosX() + worldmapGrand.ui.nodeSelectBg:GetSizeX() - worldmapGrand.ui.comboBox_NodeType:GetSizeX())
  worldmapGrand.ui.comboBox_NodeType:SetPosY(worldmapGrand.ui.nodeSelectBg:GetPosY() + 35)
  worldmapGrand.ui.comboBox_TerritorySelect:SetPosX(worldmapGrand.ui.nodeSelectBg:GetPosX())
  worldmapGrand.ui.comboBox_TerritorySelect:SetPosY(worldmapGrand.ui.nodeSelectBg:GetPosY() + 35)
  if true == _ContentsGroup_ShowMajorSiegeArea then
    worldmapGrand.ui.stc_switchSiegeType:SetShow(true)
    worldmapGrand:territoryFiltterSetPosWithMajorSiege()
  else
    worldmapGrand.ui.stc_switchSiegeType:SetShow(false)
    worldmapGrand:territoryFiltterSetPos()
  end
  local colsCount = 6
  local xGap = 10
  local yGap = 37
  for checkIndex = 0, nodeListCount - 1 do
    local value = nodeList[checkIndex]
    worldMapNodeListType[value]:SetPosX(xGap + checkIndex % colsCount * worldMapNodeListType[value]:GetSizeX() + (checkIndex - 1) * 7)
    worldMapNodeListType[value]:SetPosY(yGap + worldMapNodeListType[value]:GetSizeY() * math.floor(checkIndex / colsCount) + 10)
  end
  if _ContentsGroup_WorldMapMenuFilter == true then
  else
    local uiControl = worldmapGrand.ui
    local seachBoxStartPosY = worldMapNodeListType[nodeList[nodeListCount - 1]]:GetPosY() + worldMapNodeListType[nodeList[nodeListCount - 1]]:GetSizeY() + 22
    uiControl.edit_NodeName:SetPosY(seachBoxStartPosY)
    uiControl.btn_SearchNodeName:SetPosY(seachBoxStartPosY)
    uiControl.edit_ItemName:SetPosY(uiControl.edit_NodeName:GetPosY() + uiControl.edit_NodeName:GetSizeY() + 4)
    uiControl.btn_SearchItemName:SetPosY(uiControl.edit_NodeName:GetPosY() + uiControl.edit_NodeName:GetSizeY() + 4)
    uiControl.edit_UseType:SetPosY(uiControl.edit_ItemName:GetPosY() + uiControl.edit_ItemName:GetSizeY() + 4)
    uiControl.btn_SearchUseType:SetPosY(uiControl.edit_ItemName:GetPosY() + uiControl.edit_ItemName:GetSizeY() + 4)
    uiControl.edit_GuildName:SetPosY(uiControl.edit_UseType:GetPosY() + uiControl.edit_UseType:GetSizeY() + 4)
    uiControl.btn_SearchGuildName:SetPosY(uiControl.edit_UseType:GetPosY() + uiControl.edit_UseType:GetSizeY() + 4)
  end
end
local function worldmapGrand_OpenSet()
  local uiControl = worldmapGrand.ui
  if isEnableBattle == true then
    if _ContentsGroup_WorldMapMenuFilter == false then
      worldmapGrand.ui.edit_GuildName:SetShow(true)
      worldmapGrand.ui.btn_SearchGuildName:SetShow(true)
    end
  else
    worldmapGrand.ui.edit_GuildName:SetShow(false)
    worldmapGrand.ui.btn_SearchGuildName:SetShow(false)
  end
  worldmapGrand.ui.TitleBG:SetSize(getScreenSizeX(), worldmapGrand.ui.TitleBG:GetSizeY())
  worldmapGrand.ui.TopIconBG:ComputePos()
  worldmapGrand.ui.TitleBG:ComputePos()
  uiControl.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  uiControl.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  uiControl.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  uiControl.edit_GuildName:SetEditText(worldmapGrand.config.searchDefaultGuildName, true)
end
function WorldMapSearchMenuCheck()
  if worldmapGrand.ui.chk_contentsList:IsCheck() == true then
    worldmapGrand.ui.chk_contentsList:SetCheck(false)
    worldmapGrand.ui.list2_contents:SetShow(false)
  end
  FGlobal_SetShow_WorldmapSearchMenu(worldmapGrand.ui.chk_search:IsCheck())
  worldmapGrand.ui.list_Title:SetShow(false)
end
function WorldMapContentsListCheck()
  local isOpen = worldmapGrand.ui.chk_contentsList:IsCheck()
  worldmapGrand.ui.list2_contents:SetShow(isOpen)
  if isOpen == true then
    if worldmapGrand.ui.chk_search:IsCheck() == true then
      FGlobal_SetShow_WorldmapSearchMenu(false)
      worldmapGrand.ui.chk_search:SetCheck(false)
    end
    worldmapGrand.ui.list2_contents:getElementManager():clearKey()
    for index = 0, #worldmapGrand.menuContentsList do
      worldmapGrand.ui.list2_contents:getElementManager():pushKey(index)
    end
  end
end
function UpdateMenuContensList(content, key)
  local key32 = Int64toInt32(key)
  local menuState = worldmapGrand.menuContentsList[key32].key
  local btn_control = UI.getChildControl(content, "Check_ControlList1")
  local stc_icon = UI.getChildControl(btn_control, "Static_Icon")
  local iconData = worldmapGrand.menuContentsList[key32].icon
  if worldmapGrand.menuContentsList[key32] == nil or iconData == nil or worldmapGrand.menuContentsList[key32].name == "" or worldmapGrand.menuContentsList[key32].func == "" then
    UI.ASSERT_NAME(false, "WorldMap Conttents Menu\236\151\144 \236\132\184\237\140\133\235\144\152\236\167\128 \236\149\138\236\157\128 \235\141\176\236\157\180\237\132\176\234\176\128 \236\158\136\236\138\181\235\139\136\235\139\164. Index : " .. key32, "\234\185\128\236\132\177\234\183\156")
    return
  end
  if iconData.TID ~= "" then
    stc_icon:ChangeTextureInfoTextureIDAsync(iconData.TID)
  elseif iconData.path ~= "" then
    stc_icon:ChangeTextureInfoNameAsync(iconData.path)
  end
  local x1, y1, x2, y2 = setTextureUV_Func(stc_icon, iconData.uv.x1, iconData.uv.y1, iconData.uv.x2, iconData.uv.y2)
  stc_icon:getBaseTexture():setUV(x1, y1, x2, y2)
  stc_icon:setRenderTexture(stc_icon:getBaseTexture())
  btn_control:SetText(worldmapGrand.menuContentsList[key32].name)
  local state = worldmapGrand.menuContentsList[key32].key
  btn_control:addInputEvent("Mouse_LUp", "WorldMapCheckListChange(" .. state .. ")")
  btn_control:addInputEvent("Mouse_RUp", "WorldMapCheckListChangeAll(" .. state .. ")")
  btn_control:addInputEvent("Mouse_On", "WorldMapCheckListToolTips(true, " .. state .. ")")
  btn_control:addInputEvent("Mouse_Out", "WorldMapCheckListToolTips(false)")
  btn_control:SetCheck(worldMapMenuState[menuState])
end
function WorldMapCheckListChange(checkState, isCheck)
  local withSave = _currentRenderMode == eWorldmapState.eWMS_EXPLORE_PLANT
  if _ContentsGroup_WorldMapMenuFilter == true then
    if isCheck == nil then
      worldMapMenuState[checkState] = not worldMapMenuState[checkState]
      isCheck = worldMapMenuState[checkState]
    else
      worldMapMenuState[checkState] = isCheck
    end
  elseif nil == isCheck then
    isCheck = worldMapCheckState[checkState]:IsCheck()
  end
  ToClient_WorldmapCheckState(checkState, isCheck, withSave)
  if withSave then
    worldMapCheckStateInMode[_currentRenderMode][checkState] = isCheck
  end
  if CppEnums.WorldMapCheckState.eCheck_Postions == checkState and true == isCheck then
    if eWorldmapState.eWMS_EXPLORE_PLANT == _currentRenderMode then
      FGlobal_ActorTooltip_SetShowPartyMemberIcon(true)
    end
  else
    FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
    ToClient_Worldmap_ShowGuildMemberIcon(false)
  end
  if CppEnums.WorldMapCheckState.eCheck_Barter == checkState and true == isCheck and eWorldmapState.eWMS_EXPLORE_PLANT == _currentRenderMode then
    if _ContentsGroup_WorldMapMenuFilter == true then
      if worldMapMenuState[eCheckState.eCheck_Node] == false then
        WorldMapCheckListChange(CppEnums.WorldMapCheckState.eCheck_Node, true)
        worldMapMenuState[eCheckState.eCheck_Node] = true
      end
      if worldMapMenuState[eCheckState.eCheck_Monster] == false then
        WorldMapCheckListChange(CppEnums.WorldMapCheckState.eCheck_Monster, true)
        worldMapMenuState[eCheckState.eCheck_Monster] = true
      end
      if worldMapMenuState[eCheckState.eCheck_AbyssWell] == false then
        WorldMapCheckListChange(CppEnums.WorldMapCheckState.eCheck_AbyssWell, true)
        worldMapMenuState[eCheckState.eCheck_AbyssWell] = true
      end
      WorldMapContentsListCheck()
    else
      if worldMapCheckState[eCheckState.eCheck_Node]:IsCheck() == false then
        WorldMapCheckListChange(CppEnums.WorldMapCheckState.eCheck_Node, true)
        worldMapCheckState[eCheckState.eCheck_Node]:SetCheck(true)
      end
      if worldMapCheckState[eCheckState.eCheck_Monster]:IsCheck() == false then
        WorldMapCheckListChange(CppEnums.WorldMapCheckState.eCheck_Monster, true)
        worldMapCheckState[eCheckState.eCheck_Monster]:SetCheck(true)
      end
    end
  end
end
function WorldMapCheckListChangeAll(checkState)
  if _ContentsGroup_WorldMapMenuFilter == true then
    for index = 0, #worldMapMenuState do
      if index ~= checkState then
        WorldMapCheckListChange(index, false)
      else
        WorldMapCheckListChange(index, true)
      end
    end
    if checkState == CppEnums.WorldMapCheckState.eCheck_Barter then
      WorldMapCheckListChange(eCheckState.eCheck_AbyssWell, true)
    end
    WorldMapContentsListCheck()
  else
    for checkIndex, value in pairs(worldMapCheckState) do
      if checkIndex ~= checkState then
        WorldMapCheckListChange(checkIndex, false)
        value:SetCheck(false)
      else
        WorldMapCheckListChange(checkIndex, true)
        value:SetCheck(true)
      end
    end
  end
end
local function CheckStateByChangeMode()
  if _ContentsGroup_WorldMapMenuFilter == true then
    for menuState, value in pairs(worldMapCheckStateInMode[_currentRenderMode]) do
      worldMapMenuState[menuState] = value
      ToClient_WorldmapCheckState(menuState, worldMapMenuState[menuState], false)
    end
    WorldMapCheckListChange(eCheckState.eCheck_Node, worldMapMenuState[eCheckState.eCheck_Node])
  else
    for checkIndex, value in pairs(worldMapCheckStateInMode[_currentRenderMode]) do
      worldMapCheckState[checkIndex]:SetCheck(value)
      ToClient_WorldmapCheckState(checkIndex, worldMapCheckState[checkIndex]:IsCheck(), false)
    end
    WorldMapCheckListChange(eCheckState.eCheck_Node, worldMapCheckState[eCheckState.eCheck_Node]:IsCheck())
  end
end
function worldmapGrand:UpdateList()
  if worldmapGrand_SearchType.nodeName == self.config.searchType then
    self.ui.list_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHTITLE_NODE"))
    self.ui.list_KeyWord:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHKEYWORD", "keyword", self.ui.edit_NodeName:GetEditText(), "count", self.config.searchingResultCount))
  elseif worldmapGrand_SearchType.nodeType == self.config.searchType then
    self.ui.list_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHTITLE_NODE"))
    self.ui.list_KeyWord:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_NODETYPEKEYWORD", "keyword", worldMapNodeType_String[self.config.selectNodeType], "count", self.config.searchingResultCount))
  elseif worldmapGrand_SearchType.itemName == self.config.searchType then
    self.ui.list_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHTITLE_HOUSE"))
    self.ui.list_KeyWord:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHKEYWORD", "keyword", self.ui.edit_ItemName:GetEditText(), "count", self.config.searchingResultCount))
  elseif worldmapGrand_SearchType.GuildName == self.config.searchType then
    self.ui.list_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHTITLE_NODE"))
    self.ui.list_KeyWord:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHKEYWORD", "keyword", self.ui.edit_GuildName:GetEditText(), "count", self.config.searchingResultCount))
  else
    self.ui.list_Title:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHTITLE_USETYPE"))
    self.ui.list_KeyWord:SetText(PAGetStringParam2(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_SEARCHKEYWORD", "keyword", self.ui.edit_UseType:GetEditText(), "count", self.config.searchingResultCount))
  end
  for idx = 0, self.config.searchingResultMaxCount - 1 do
    self.searchResultUiPool[idx]:SetTextMode(__eTextMode_Limit_AutoWrap)
    self.searchResultUiPool[idx]:SetText("")
    self.searchResultUiPool[idx]:SetShow(false)
    self.searchResultUiPool[idx]:addInputEvent("Mouse_LUp", "")
  end
  local resultUiCount = 0
  for resultIdx = self.config.scrollStartIdx, self.config.searchingResultCount - 1 do
    if resultUiCount >= self.config.searchingResultMaxCount then
      break
    end
    local resultString = ""
    if worldmapGrand_SearchType.nodeName == self.config.searchType then
      resultString = ToClient_getFindResultNameByIndex(resultIdx)
    elseif worldmapGrand_SearchType.nodeType == self.config.searchType then
      resultString = ToClient_getFindResultNameByIndex(resultIdx)
    elseif worldmapGrand_SearchType.itemName == self.config.searchType then
      local HouseInfoStaticStatusWrapper = ToClient_getHouseInfoWrapperByIndex(resultIdx)
      resultString = HouseInfoStaticStatusWrapper:getName()
    elseif worldmapGrand_SearchType.GuildName == self.config.searchType then
      resultString = ToClient_getFindResultNameByIndex(resultIdx)
    else
      local HouseInfoStaticStatusWrapper = ToClient_getHouseInfoWrapperByHouseUseTypeNameIndex(resultIdx)
      resultString = HouseInfoStaticStatusWrapper:getName()
    end
    local slot = self.searchResultUiPool[resultUiCount]
    slot:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_GotoNodeFocus( " .. resultIdx .. " )")
    slot:addInputEvent("Mouse_UpScroll", "GrandWorldMap_Scroll( true )")
    slot:addInputEvent("Mouse_DownScroll", "GrandWorldMap_Scroll( false )")
    slot:SetText(resultString)
    slot:SetShow(true)
    resultUiCount = resultUiCount + 1
  end
  local isScrollShown = self.ui.list_scroll:GetShow()
  UIScroll.SetButtonSize(self.ui.list_scroll, self.config.searchingResultMaxCount, self.config.searchingResultCount)
  if isScrollShown == false then
    self.ui.list_scroll:SetShow(false)
  end
end
function WorldmapNodeList_UpScrollEvent()
  GrandWorldMap_Scroll(true)
end
function WorldmapNodeList_DownScrollEvent()
  GrandWorldMap_Scroll(false)
end
function worldmapGrand:UpdateExplorePoint()
  local explorePoint = ToClient_getExplorePoint()
  local cont_expRate = Int64toInt32(explorePoint:getExperience_s64()) / Int64toInt32(getRequireExplorationExperience_s64())
  self.ui.explorePointIcon:SetText(PAGetString(Defines.StringSheet_RESOURCE, "CHARACTERINFO_TEXT_CONTRIBUTION"))
  self.ui.explorePointValue:SetText(tostring(explorePoint:getRemainedPoint()) .. " / " .. tostring(explorePoint:getAquiredPoint()))
  if _ContentsGroup_WorldMapMenuFilter == false and (isGameTypeNA() or isGameTypeSA() or isGameTypeTH() or isGameTypeID() or isGameTypeTR() or isGameTypeASIA()) then
    worldmapGrand.ui.explorePointIcon:SetVerticalTop()
    worldmapGrand.ui.explorePointValue:SetPosY(worldmapGrand.ui.explorePointIcon:GetPosY() + worldmapGrand.ui.explorePointIcon:GetTextSizeY() + 10)
    worldmapGrand.ui.explorePointBG:SetSize(229, worldmapGrand.ui.explorePointIcon:GetTextSizeY() + worldmapGrand.ui.explorePointValue:GetTextSizeY() + 25)
  else
    worldmapGrand.ui.explorePointBG:SetSize(229, 40)
    worldmapGrand.ui.explorePointIcon:SetVerticalTop()
    worldmapGrand.ui.explorePointValue:SetTextVerticalTop()
    worldmapGrand.ui.explorePointValue:SetSpanSize(10, 12)
    UI.setLimitTextAndAddTooltip(worldmapGrand.ui.explorePointIcon, worldmapGrand.ui.explorePointIcon:GetText())
    UI.setLimitTextAndAddTooltip(worldmapGrand.ui.explorePointValue, worldmapGrand.ui.explorePointValue:GetText())
  end
end
local function productNode_Filter_Init()
  _selectNodeType = -1
  _selectTerritory = -1
  worldmapGrand.ui.nodeSelectBg:SetShow(false)
  worldmapGrand.ui.nodeSelectTitle:SetShow(false)
  worldmapGrand.ui.comboBox_TerritorySelect:SetShow(false)
  worldmapGrand.ui.comboBox_NodeType:SetShow(false)
  worldmapGrand.ui.comboBox_TerritorySelect:SetSelectItemIndex(-1)
  worldmapGrand.ui.comboBox_TerritorySelect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TERRITORYSTRING_ALL"))
  worldmapGrand.ui.comboBox_NodeType:SetSelectItemIndex(-1)
  worldmapGrand.ui.comboBox_NodeType:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_NODESELECT"))
  WorldMapArrowEffectErase()
end
function PaGlobalFunc_UpdateHardCoreBossListUI()
  if _ContentsGroup_HardCoreChannel ~= true or ToClient_isHardCoreChannel() ~= true then
    return false
  end
  local bossMaxCount = ToClient_getHardCoreMaxBossCount()
  for bossIndex = 0, bossMaxCount - 1 do
    worldmapGrand.ui.stc_HardCoreBossTitle[bossIndex]:SetShow(false)
  end
  local currentCharacterCount = ToClient_getCurrentHardCoreRandomSpawnCharacterCount()
  local bossIndex = 0
  for index = 0, currentCharacterCount - 1 do
    if bossMaxCount <= bossIndex then
      return
    end
    local randomSpawnCharacterKey = ToClient_getHardCoreBossKeyByIndex(index)
    if randomSpawnCharacterKey ~= 0 then
      local characterKey = ToClient_getHardCoreCharaterKeyByRandomSpawnCharaterKey(randomSpawnCharacterKey)
      worldmapGrand.ui.stc_HardCoreBossTitle[bossIndex]:SetShow(true)
      local decoBgControl = UI.getChildControl(worldmapGrand.ui.stc_HardCoreBossTitle[bossIndex], "Static_DecoBg")
      local characterWrapper = ToClient_GetCharacterStaticStatusWrapper(characterKey)
      local textControl = UI.getChildControl(decoBgControl, "StaticText_BossName")
      textControl:SetText(characterWrapper:getName())
      local textureID = ToClient_getHardCoreBossUIIconTextureID(randomSpawnCharacterKey)
      local textureControl = UI.getChildControl(decoBgControl, "Static_BossImage")
      textureControl:ChangeTextureInfoTextureIDAsync(textureID)
      textureControl:setRenderTexture(textureControl:getBaseTexture())
      bossIndex = bossIndex + 1
    end
  end
end
function PaGlobalFunc_WorldMapHardCoreModeSet()
  if _ContentsGroup_HardCoreChannel ~= true or ToClient_isHardCoreChannel() ~= true then
    return false
  end
  ToClient_WorldmapStateChange(eWorldmapState.eWMS_EXPLORE_PLANT)
  if _ContentsGroup_WorldMapMenuFilter == true then
    for menuState, value in pairs(worldMapMenuState) do
      local isShow = false
      if menuState == eCheckState.eCheck_Monster then
        isShow = true
      end
      ToClient_WorldmapCheckState(menuState, isShow, false)
    end
  else
    for checkIndex, value in pairs(worldMapCheckState) do
      local isShow = false
      if checkIndex == eCheckState.eCheck_Monster then
        isShow = true
      end
      ToClient_WorldmapCheckState(checkIndex, isShow, false)
    end
  end
  Panel_WorldMap_Main:SetShow(false, false)
  ToClient_worldmapTerritoryManagerSetShow(false)
  ToClient_worldmapGuildHouseSetShow(false, CppEnums.WaypointKeyUndefined)
  PaGlobalFunc_HardCoreWorldMapBottomMenuSet()
  PaGlobalFunc_UpdateHardCoreBossListUI()
  worldmapGrand.ui.stc_HardCoreBg:SetSize(getScreenSizeX(), getScreenSizeY())
  worldmapGrand.ui.stc_HardCoreBg:SetShow(true)
  return true
end
function FGlobal_WorldMapOpenForMain()
  AlignButtonPosition()
  worldmapGrand_OpenSet()
  Panel_WorldMap_Main:SetShow(true, false)
  for index, checkArray in pairs(worldMapCheckStateInMode) do
    local worldMapState
    if _ContentsGroup_WorldMapMenuFilter == true then
      worldMapState = worldMapMenuState
    else
      worldMapState = worldMapCheckState
    end
    for menuState, value in pairs(worldMapState) do
      if index == eWorldmapState.eWMS_EXPLORE_PLANT then
        checkArray[menuState] = ToClient_isWorldmapCheckState(menuState)
      elseif index == eWorldmapState.eWMS_GUILD_WAR then
        if menuState == eCheckState.eCheck_Node or menuState == eCheckState.eCheck_Postions then
          checkArray[menuState] = true
        else
          checkArray[menuState] = false
        end
      elseif index == eWorldmapState.eWMS_PRODUCT_NODE then
        if menuState == eCheckState.eCheck_Node then
          checkArray[menuState] = true
        else
          checkArray[menuState] = false
        end
      elseif index == eWorldmapState.eWMS_FAMILY_CHARACTER then
        if menuState == eCheckState.eCheck_Node or menuState == eCheckState.eCheck_Monster or _ContentsGroup_WorldMapMenuFilter == true and menuState == eCheckState.eCheck_AbyssWell then
          checkArray[menuState] = true
        else
          checkArray[menuState] = false
        end
      else
        checkArray[menuState] = false
      end
    end
  end
  if _ContentsGroup_WorldMapMenuFilter == true then
    FGlobal_WorldMapCheckRenderMode(_currentRenderMode, false)
    for menuState, value in pairs(worldMapMenuState) do
      value = worldMapCheckStateInMode[_currentRenderMode][menuState]
      ToClient_WorldmapCheckState(menuState, value, false)
    end
  else
    for checkIndex, value in pairs(worldMapCheckState) do
      value:SetCheck(worldMapCheckStateInMode[_currentRenderMode][checkIndex])
      ToClient_WorldmapCheckState(checkIndex, value:IsCheck(), false)
    end
  end
  worldmapGrand.ui.chk_contentsList:SetCheck(worldmapGrand.ui.list2_contents:GetShow())
  worldmapGrand.ui.chk_search:SetCheck(worldmapGrand.ui.MainMenuBG:GetShow())
  for idx, value in pairs(worldMapNodeListType) do
    worldMapNodeListType[idx]:SetCheck(false)
  end
  local defaultSelectFilter = worldMapNodeType.city
  HandleClicked_GrandWorldMap_SearchNodeType(defaultSelectFilter)
  worldMapNodeListType[defaultSelectFilter]:SetCheck(true)
  CheckStateByChangeMode()
  if _ContentsGroup_WorldMapMenuFilter == true then
  else
    worldMapState[_currentRenderMode]:SetCheck(true)
  end
  worldmapGrand:UpdateExplorePoint()
  FGlobal_WorldmapGrand_Bottom_MenuSet()
  worldmapGrand.ui.list_scroll:SetControlPos(0)
  worldmapGrand.config.scrollStartIdx = 0
  productNode_Filter_Init()
  ToClient_setDoTerrainHide(_currentRenderMode == eWorldmapState.eWMS_PRODUCT_NODE or _currentRenderMode == eWorldmapState.eWMS_FAMILY_CHARACTER)
  worldmapGrand:territoryFilterShow(false)
  PaGlobal_Worlmap_CapitalButtonClose()
  PaGlobal_WorldMapNodeTooltip_VillageWar_Close()
  local myGuildAllianceCacheNo
  local selfPlayerProxyWrapper = getSelfPlayer()
  local ignoreGuildButton = true
  if nil ~= selfPlayerProxyWrapper then
    if true == selfPlayerProxyWrapper:isGuildAllianceMember() then
      myGuildAllianceCacheNo = selfPlayerProxyWrapper:getGuildAllianceNo_s64()
    else
      myGuildAllianceCacheNo = selfPlayerProxyWrapper:getGuildNo_s64()
    end
  end
  local guildNo32 = Int64toInt32(myGuildAllianceCacheNo)
  local isGuildNoDefined = 0 ~= guildNo32
  if nil ~= myGuildAllianceCacheNo and true == isGuildNoDefined and (true == ToClient_hasOccupyingSiege(myGuildAllianceCacheNo) or true == ToClient_hasOccupyingMajorSiege(myGuildAllianceCacheNo)) then
    ignoreGuildButton = false
  end
  worldmapGrand.ui.btn_TerritoryInfoMy:SetIgnore(ignoreGuildButton)
  if _currentRenderMode == eWorldmapState.eWMS_GUILD_WAR then
    worldmapGrand.ui.daySelectBg:SetShow(true)
    worldmapGrand.ui.daySelectTitle:SetShow(true)
    worldmapGrand.ui.comboBox_DaySelect:SetShow(true)
    worldmapGrand.ui.comboBox_TaxGrade:SetShow(true)
    worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(true)
    worldmapGrand.ui.btn_TerritoryInfoMy:SetShow(true)
    worldmapGrand:territoryFilterShow(true)
  elseif _currentRenderMode == eWorldmapState.eWMS_PRODUCT_NODE then
    worldmapGrand.ui.nodeSelectBg:SetShow(true)
    worldmapGrand.ui.nodeSelectTitle:SetShow(true)
    worldmapGrand.ui.comboBox_TerritorySelect:SetShow(true)
    worldmapGrand.ui.comboBox_NodeType:SetShow(true)
  end
  if state == eWorldmapState.eWMS_EXPLORE_PLANT then
    if _ContentsGroup_WorldMapMenuFilter == true then
      if worldMapMenuState[CppEnums.WorldMapCheckState.eCheck_Postions] == true then
        FGlobal_ActorTooltip_SetShowPartyMemberIcon(true)
      else
        ToClient_Worldmap_ShowGuildMemberIcon(false)
        FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
      end
    elseif worldMapCheckState[CppEnums.WorldMapCheckState.eCheck_Postions]:IsCheck() == true then
      FGlobal_ActorTooltip_SetShowPartyMemberIcon(true)
    else
      ToClient_Worldmap_ShowGuildMemberIcon(false)
      FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
    end
  else
    ToClient_Worldmap_ShowGuildMemberIcon(false)
    FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
  end
  FGlobal_WorldmapMain_InitTutorialButton()
  FGlobal_Hide_Tooltip_Work(nil, true)
  local worldmapTabNo = ToClient_GetWorldMapTabNo()
  if 0 ~= worldmapTabNo then
    for modeIndex, value in pairs(worldMapState) do
      if modeIndex == worldmapTabNo then
        value:SetCheck(true)
      else
        value:SetCheck(false)
      end
    end
  end
  if false == isShowUIByObserver then
    isShowUIByObserver = true
    PaGlobalFunc_WorldmapMain_ToggleButtonByObserver()
  end
  CreateBtn_CameraSaveSlots()
end
function FGlobal_WorldmapGrand_Main_UpdateExplorePoint()
  worldmapGrand:UpdateExplorePoint()
end
function FGlobal_resetGuildWarMode()
  _isGuildWarMode = false
  ToClient_SetGuildMode(false)
end
function FGlobal_isGuildWarMode()
  return _isGuildWarMode
end
function FGlobal_WorldMapStateMaintain()
  CheckStateByChangeMode()
end
function WorldMapStateChange(state, openWorldmap)
  if state == eWorldmapState.eWMS_GUILD_WAR then
    worldmapGrand.ui.comboBox_DaySelect:SetSelectItemIndex(-1)
    worldmapGrand.ui.comboBox_DaySelect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDAY"))
    worldmapGrand.ui.comboBox_TaxGrade:SetSelectItemIndex(-1)
    worldmapGrand.ui.comboBox_TaxGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTTAXGRADE"))
    worldmapGrand.ui.btn_TerritoryInfoMy:SetCheck(false)
    worldmapGrand._currentSelectTerritoryIndex = -1
    ToClient_resetVisibleVillageSiegeType()
    ToClient_resetVisibleVillageSiegeTaxLevel()
    worldmapGrand:territoryInfoShow(-1)
    ToClient_resetVisibleVillageMyGuild()
  else
    worldmapGrand.ui.daySelectBg:SetShow(false)
    worldmapGrand.ui.daySelectTitle:SetShow(false)
    worldmapGrand.ui.comboBox_DaySelect:SetShow(false)
    worldmapGrand.ui.comboBox_TaxGrade:SetShow(false)
    worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(false)
    worldmapGrand.ui.btn_TerritoryInfoMy:SetShow(false)
  end
  productNode_Filter_Init()
  _currentRenderMode = state
  worldmapGrand:territoryFilterShow(false)
  PaGlobal_Worlmap_CapitalButtonClose()
  if _ContentsGroup_WorldMapFamilyCharacterManagement == true then
    ToClient_worldmapActorManagerFamilyCharacterIconSetShow(false)
    PaGlobalFunc_WorldMapFamilyCharacterIcon_HideAll()
    PaGlobalFunc_WorldMap_FamilyCharacterList_Close()
  end
  worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(false)
  local renderState = state
  _isBlackFog = false
  if eWorldmapState.eWMS_EXPLORE_PLANT == state then
    _isGuildWarMode = false
  elseif eWorldmapState.eWMS_GUILD_WAR == state then
    renderState = eWorldmapState.eWMS_EXPLORE_PLANT
    worldmapGrand.ui.daySelectBg:SetShow(true)
    worldmapGrand.ui.daySelectTitle:SetShow(true)
    worldmapGrand.ui.comboBox_DaySelect:SetShow(true)
    worldmapGrand.ui.comboBox_TaxGrade:SetShow(true)
    worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(true)
    worldmapGrand.ui.btn_TerritoryInfoMy:SetShow(true)
    worldmapGrand:territoryFilterShow(true)
    _isGuildWarMode = true
    worldmapGrand._isMajorSiegeView = false
    HandleClicked_MajorSiegeView(worldmapGrand._isMajorSiegeView)
  elseif eWorldmapState.eWMS_PRODUCT_NODE == state then
    worldmapGrand.ui.nodeSelectBg:SetShow(true)
    worldmapGrand.ui.nodeSelectTitle:SetShow(true)
    worldmapGrand.ui.comboBox_TerritorySelect:SetShow(true)
    worldmapGrand.ui.comboBox_NodeType:SetShow(true)
    _isBlackFog = true
    _isGuildWarMode = false
    renderState = eWorldmapState.eWMS_EXPLORE_PLANT
  elseif eWorldmapState.eWMS_FAMILY_CHARACTER == state then
    _isBlackFog = true
    _isGuildWarMode = false
    renderState = eWorldmapState.eWMS_EXPLORE_PLANT
    ToClient_worldmapActorManagerFamilyCharacterIconSetShow(true)
    PaGlobalFunc_WorldMap_FamilyCharacterList_Open()
  else
    _isGuildWarMode = false
  end
  ToClient_SetGuildMode(_isGuildWarMode)
  if (state == eWorldmapState.eWMS_EXPLORE_PLANT or state == eWorldmapState.eWMS_GUILD_WAR or state == eWorldmapState.eWMS_PRODUCT_NODE) and openWorldmap == false then
    ToClient_reloadNodeLine(_isGuildWarMode, CppEnums.WaypointKeyUndefined)
  end
  ToClient_WorldmapStateChange(renderState)
  CheckStateByChangeMode()
  ToClient_setDoTerrainHide(_isBlackFog)
  if _ContentsGroup_WorldMapMenuFilter == false then
    worldmapGrand.ui.filterArrow:SetPosX(worldMapState[state]:GetPosX() + worldMapState[state]:GetSizeX() / 2 - worldmapGrand.ui.filterArrow:GetSizeX() / 2)
  end
  if state == eWorldmapState.eWMS_EXPLORE_PLANT then
    if _ContentsGroup_WorldMapMenuFilter == true then
      if worldMapMenuState[CppEnums.WorldMapCheckState.eCheck_Postions] == true then
        FGlobal_ActorTooltip_SetShowPartyMemberIcon(true)
      else
        ToClient_Worldmap_ShowGuildMemberIcon(false)
        FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
      end
    elseif worldMapCheckState[CppEnums.WorldMapCheckState.eCheck_Postions]:IsCheck() == true then
      FGlobal_ActorTooltip_SetShowPartyMemberIcon(true)
    else
      ToClient_Worldmap_ShowGuildMemberIcon(false)
      FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
    end
  else
    ToClient_Worldmap_ShowGuildMemberIcon(false)
    FGlobal_ActorTooltip_SetShowPartyMemberIcon(false)
  end
  ToClient_SetWorldMapTabNo(state)
  if false == isShowUIByObserver then
    isShowUIByObserver = true
    PaGlobalFunc_WorldmapMain_ToggleButtonByObserver()
  end
end
function WorldMapArrowEffectEraseClear()
  btnArray = {}
end
function WorldMapArrowEffectErase()
  if nil == btnArray then
    return
  end
  for v, btn in pairs(btnArray) do
    btn:EraseAllEffect()
    btn:getBaseTextureInfo():setVertexAnimation(1, 1, 0, CppEnums.PA_UI_ANI_TYPE.PA_UI_ANI_ONETIME_DISAPPEAR)
    local nodeType = btn:FromClient_getExplorationNodeInClient():getStaticStatus()._nodeType
    if CppEnums.ExplorationNodeType.eExplorationNodeType_Trade == nodeType then
      btn:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/worldmap/worldmap_icon_03.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 344, 203, 512, 399)
      btn:getBaseTexture():setUV(x1, y1, x2, y2)
      btn:setRenderTexture(btn:getBaseTexture())
      btn:ChangeOnTextureInfoNameAsync("New_UI_Common_forLua/Widget/Dialogue/worldmap_icon_03.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 344, 4, 511, 200)
      btn:getOnTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.ExplorationNodeType.eExplorationNodeType_Dangerous == nodeType then
      btn:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/worldmap/worldmap_icon_04.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 0, 203, 167, 398)
      btn:getBaseTexture():setUV(x1, y1, x2, y2)
      btn:setRenderTexture(btn:getBaseTexture())
      btn:ChangeOnTextureInfoNameAsync("New_UI_Common_forLua/Widget/Dialogue/worldmap_icon_04.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 0, 4, 167, 199)
      btn:getOnTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.ExplorationNodeType.eExplorationNodeType_Normal == nodeType then
      btn:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/worldmap/worldmap_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 171, 203, 340, 399)
      btn:getBaseTexture():setUV(x1, y1, x2, y2)
      btn:setRenderTexture(btn:getBaseTexture())
      btn:ChangeOnTextureInfoNameAsync("New_UI_Common_forLua/Widget/Dialogue/worldmap_icon_00.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 171, 4, 340, 200)
      btn:getOnTexture():setUV(x1, y1, x2, y2)
    elseif CppEnums.ExplorationNodeType.eExplorationNodeType_Viliage == nodeType then
      btn:ChangeTextureInfoNameAsync("New_UI_Common_forLua/Widget/worldmap/worldmap_icon_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 0, 203, 168, 399)
      btn:getBaseTexture():setUV(x1, y1, x2, y2)
      btn:setRenderTexture(btn:getBaseTexture())
      btn:ChangeOnTextureInfoNameAsync("New_UI_Common_forLua/Widget/Dialogue/worldmap_icon_02.dds")
      local x1, y1, x2, y2 = setTextureUV_Func(btn, 0, 4, 168, 200)
      btn:getOnTexture():setUV(x1, y1, x2, y2)
    end
  end
  btnArray = {}
end
function FromClient_NodeFilterOn(house_btn)
  local btn = house_btn
  table.insert(btnArray, btn)
  local nodeType = btn:FromClient_getExplorationNodeInClient():getStaticStatus()._nodeType
  local textureLink = ""
  if CppEnums.ExplorationNodeType.eExplorationNodeType_Trade == nodeType then
    textureLink = "new_ui_common_forlua/widget/worldmap/TradeNode_Sequence.dds"
  elseif CppEnums.ExplorationNodeType.eExplorationNodeType_Dangerous == nodeType then
    textureLink = "new_ui_common_forlua/widget/worldmap/DangerNode_Sequence.dds"
  elseif CppEnums.ExplorationNodeType.eExplorationNodeType_Normal == nodeType then
    textureLink = "new_ui_common_forlua/widget/worldmap/Node_Sequence.dds"
  elseif CppEnums.ExplorationNodeType.eExplorationNodeType_Viliage == nodeType then
    textureLink = "new_ui_common_forlua/widget/worldmap/VillageNode_Sequence.dds"
  end
  if "" ~= textureLink then
    btn:getBaseTextureInfo():setVertexAnimation(4, 4, 0.1, CppEnums.PA_UI_ANI_TYPE.PA_UI_ANI_INFINITE)
    btn:ChangeTextureInfoNameAsync(textureLink)
  end
  btn:EraseAllEffect()
  btn:AddEffect("UI_ArrowMark_Diagonal01", true, 70, 80)
end
registerEvent("FromClient_NodeFilterOn", "FromClient_NodeFilterOn")
function FGlobal_SetNodeFilter()
  if worldmapGrand.ui.nodeSelectBg:GetShow() then
    PrevNodeType_Set()
  end
end
function WorldMapStateChange_SimpleTooltips(isShow, tipType)
  local name, desc, control
  if eWorldmapState.eWMS_EXPLORE_PLANT == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_PLANT_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_PLANT_DESC")
  elseif eWorldmapState.eWMS_REGION == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_REGION_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_REGION_DESC")
  elseif eWorldmapState.eWMS_LOCATION_INFO_WATER == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_WATER_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_WATER_DESC")
  elseif eWorldmapState.eWMS_LOCATION_INFO_CELCIUS == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_CELCIUS_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_CELCIUS_DESC")
  elseif eWorldmapState.eWMS_LOCATION_INFO_HUMIDITY == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_HUMIDITY_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_HUMIDITY_DESC")
  elseif eWorldmapState.eWMS_GUILD_WAR == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_GUILDWAR_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_GUILDWAR_DESC")
  elseif eWorldmapState.eWMS_PRODUCT_NODE == tipType then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TOOLTIP_NODEFILTER")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAP_TOOLTIP_NODEFILTERDESC")
  else
    if eWorldmapState.eWMS_FAMILY_CHARACTER == tipType then
      name = PAGetString(Defines.StringSheet_GAME, "LUA_FAMILYCHARACTER_WORLDMAPTOOLTIP_TITLE")
      desc = PAGetString(Defines.StringSheet_GAME, "LUA_FAMILYCHARACTER_WORLDMAPTOOLTIP_DESC")
    else
    end
  end
  control = worldMapState[tipType]
  if isShow == true and nil ~= control then
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function WorldMapMenuStateToolTips(isShow, checkType)
  if isShow == true then
    TooltipSimple_Show(uiControl, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function WorldMapCheckListToolTips(isShow, checkType)
  local name, desc, uiControl, state
  if checkType == eCheckState.eCheck_Quest then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_QUEST_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_QUEST_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(0)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Quest]
    end
  elseif checkType == eCheckState.eCheck_Knowledge then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_KNOWLEDGE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_KNOWLEDGE_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(1)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Knowledge]
    end
  elseif checkType == eCheckState.eCheck_FishnChip then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_FISH_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_FISH_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(2)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_FishnChip]
    end
  elseif checkType == eCheckState.eCheck_Node then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_NODE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_NODE_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(4)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Node]
    end
  elseif checkType == eCheckState.eCheck_Trade then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_TRADE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_TRADE_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(9)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Trade]
    end
  elseif checkType == eCheckState.eCheck_Way then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_DIRECTION_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_DIRECTION_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(8)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Way]
    end
  elseif checkType == eCheckState.eCheck_Postions then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_WHERE_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_NEW_WORLDMAP_PANEL_TOOLTIP_WHERE_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(7)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Postions]
    end
  elseif checkType == eCheckState.eCheck_Wagon then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_WAGON")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_WAGON_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(10)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Wagon]
    end
  elseif checkType == eCheckState.eCheck_Monster then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_MONSTERINFO_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_MONSTERINFO_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(3)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Monster]
    end
  elseif checkType == eCheckState.eCheck_MyBossMonster then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_MYBOSSMONSTER_NAME")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_MYBOSSMONSTER_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(5)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_MyBossMonster]
    end
  elseif checkType == eCheckState.eCheck_Barter then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_WORLDMAPICONTOOLTIP_TITLE")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_BARTER_WORLDMAPICONTOOLTIP_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(11)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_Barter]
    end
  elseif checkType == eCheckState.eCheck_AbyssWell then
    name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_ABYSSWELL")
    desc = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_ABYSSWELL_DESC") .. "\n" .. PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_PANEL_TOOLTIP_COMMON_DESC")
    if _ContentsGroup_WorldMapMenuFilter == true then
      uiControl = worldmapGrand.ui.list2_contents:GetContentByKey(6)
    else
      uiControl = worldMapCheckState[eCheckState.eCheck_AbyssWell]
    end
  end
  if isShow == true then
    if _ContentsGroup_WorldMapMenuFilter == true then
      local icon = UI.getChildControl(UI.getChildControl(uiControl, "Check_ControlList1"), "Static_Icon")
      TooltipSimple_Show(uiControl, name, desc, icon)
    else
      TooltipSimple_Show(uiControl, name, desc)
    end
  else
    TooltipSimple_Hide()
  end
end
function worldmapGrand_nodeTypeTooltip(isShow, typeIdx)
  local uiControl = worldMapNodeListType[typeIdx]
  local name = worldMapNodeType_String[typeIdx]
  local desc
  if true == isShow then
    registTooltipControl(uiControl, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(uiControl, name, desc, false)
  else
    TooltipSimple_Hide()
  end
end
function worldmapGrand:territoryFilterShow(isShow)
  if nil == Panel_WorldMap_Main or nil == self.ui.btn_SiegeTerritoryFilter then
    return
  end
  self._currentMajorSiegeCount = 0
  for i = 1, #territoryIndex do
    if nil ~= territoryIndex[i] and true == ToClient_isStartMajorSiege(territoryIndex[i]) then
      self._currentMajorSiegeCount = self._currentMajorSiegeCount + 1
    end
  end
  local tempRadioButton
  for i = 1, #territoryIcon._path do
    if nil == self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]] then
      tempRadioButton = UI.cloneControl(self.ui.btn_SiegeTerritoryFilter, self.ui.stc_SiegeTerritoryFilterBG, "Territory_Radio_Button" .. i)
      tempRadioButton:SetShow(isShow)
      tempRadioButton:ChangeTextureInfoNameAsync(territoryIcon._path[i])
      local x1, y1, x2, y2 = setTextureUV_Func(tempRadioButton, territoryIcon._UV.x1, territoryIcon._UV.y1, territoryIcon._UV.x2, territoryIcon._UV.y2)
      tempRadioButton:getBaseTexture():setUV(x1, y1, x2, y2)
      tempRadioButton:setRenderTexture(tempRadioButton:getBaseTexture())
      tempRadioButton:addInputEvent("Mouse_LUp", "HandleEventLUp_GrandWorldMap_TerritoryInfoShow(" .. territoryIndex[i] .. ")")
      self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]] = tempRadioButton
    else
      self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetShow(isShow)
    end
  end
  if _ContentsGroup_OceanSiege == true and self.ui.btn_OceanSiege == nil then
    self.ui.btn_OceanSiege = UI.cloneControl(self.ui.btn_SiegeTerritoryFilter, self.ui.stc_SiegeTerritoryFilterBG, "Territory_Radio_Button_1")
    self.ui.btn_OceanSiege:SetShow(isShow)
    self.ui.btn_OceanSiege:ChangeTextureInfoTextureIDAsync("Territorymark_Balenos_Sea_large")
    self.ui.btn_OceanSiege:addInputEvent("Mouse_LUp", "HandleEventLUp_GrandWorldMap_OceanTerritoryInfoShow()")
  end
  self.ui.daySelectBg:SetShow(false)
  self.ui.daySelectTitle:SetShow(false)
  if true == _ContentsGroup_ShowMajorSiegeArea then
    self:territoryFiltterSetPosWithMajorSiege()
    GuildWar_SetType()
  else
    self:territoryFiltterSetPos()
  end
  self.ui.stc_SiegeTerritoryFilterBG:SetShow(isShow)
  Panel_WorldMap_Main:SetChildIndex(worldmapGrand.ui.comboBox_DaySelect, 9999)
  Panel_WorldMap_Main:SetChildIndex(worldmapGrand.ui.comboBox_TaxGrade, 9999)
end
function worldmapGrand:territoryFiltterSetPos()
  if nil == Panel_WorldMap_Main or nil == self.ui.btn_SiegeTerritoryFilter then
    return
  end
  self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.filterBg:GetSizeX(), self.ui.stc_SiegeTerritoryFilterBG:GetSizeY())
  if _ContentsGroup_OceanSiege == true then
    self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.filterBg:GetSizeX() + 40, self.ui.stc_SiegeTerritoryFilterBG:GetSizeY())
  end
  local padding = 10
  local addSize = self.ui.btn_SiegeTerritoryFilter:GetSizeX() + padding
  local half = #self.ui.btn_SiegeTerritoryFilterList / 2
  if _ContentsGroup_OceanSiege == true then
    half = (#self.ui.btn_SiegeTerritoryFilterList + 1) / 2
  end
  local basePosX = self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() / 2 - self.ui.btn_SiegeTerritoryFilter:GetSizeX() * half - padding * (half - 0.5)
  local posY = 0
  if _ContentsGroup_WorldMapMenuFilter == true then
    posY = 55
  else
    posY = self.ui.filterBg:GetPosY() + self.ui.filterBg:GetSizeY() + padding
  end
  local tempRadioButton
  local buttonPosY = self.ui.stc_SiegeTerritoryFilterBG:GetSizeY() / 4 - self.ui.btn_SiegeTerritoryFilter:GetSizeY() / 2
  for i = 1, #self.ui.btn_SiegeTerritoryFilterList do
    if nil ~= self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]] then
      self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetPosX(basePosX)
      self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetPosY(buttonPosY)
      basePosX = basePosX + addSize
    end
  end
  if _ContentsGroup_OceanSiege == true and self.ui.btn_OceanSiege ~= nil then
    self.ui.btn_OceanSiege:SetShow(true)
    self.ui.btn_OceanSiege:SetPosX(basePosX)
    self.ui.btn_OceanSiege:SetPosY(buttonPosY)
  end
  self.ui.stc_SiegeTerritoryFilterBG:SetPosY(posY)
  self.ui.stc_SiegeTerritoryFilterBG:SetPosX(getScreenSizeX() - self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() - padding * 2)
  posY = self.ui.stc_SiegeTerritoryFilterBG:GetPosY() + self.ui.stc_SiegeTerritoryFilterBG:GetSizeY() + padding
  self.ui.comboBox_DaySelect:SetPosY(posY)
  self.ui.comboBox_TaxGrade:SetPosY(posY)
  self.ui.btn_TerritoryInfoMy:SetPosY(posY)
  posY = self.ui.comboBox_DaySelect:GetPosY() + self.ui.comboBox_DaySelect:GetSizeY() + padding
  self.ui.btn_TerritoryInfoAll:SetPosY(posY)
  local sizeX = (self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() - padding * 2) / 3
  self.ui.comboBox_DaySelect:SetSize(sizeX, self.ui.comboBox_DaySelect:GetSizeY())
  self.ui.comboBox_TaxGrade:SetSize(sizeX, self.ui.comboBox_TaxGrade:GetSizeY())
  self.ui.btn_TerritoryInfoAll:SetSize(sizeX, self.ui.btn_TerritoryInfoAll:GetSizeY())
  self.ui.btn_TerritoryInfoMy:SetSize(sizeX, self.ui.btn_TerritoryInfoMy:GetSizeY())
  local posX = getScreenSizeX() - self.ui.comboBox_DaySelect:GetSizeX() - padding * 2
  self.ui.comboBox_DaySelect:SetPosX(posX)
  posX = self.ui.comboBox_DaySelect:GetPosX() - self.ui.comboBox_TaxGrade:GetSizeX() - padding
  self.ui.comboBox_TaxGrade:SetPosX(posX)
  posX = self.ui.comboBox_TaxGrade:GetPosX() - self.ui.btn_TerritoryInfoMy:GetSizeX() - padding
  self.ui.btn_TerritoryInfoMy:SetPosX(posX)
  self.ui.btn_TerritoryInfoAll:SetPosX(self.ui.btn_TerritoryInfoMy:GetPosX())
  self.ui.stc_TerritoryInfo:SetSize(self.ui.stc_SiegeTerritoryFilterBG:GetSizeX(), self.ui.stc_SiegeTerritoryFilterBG:GetSizeY() / 2)
  self.ui.stc_TerritoryInfo:SetSpanSize(self.ui.stc_TerritoryInfo:GetSpanSize().x, self.ui.stc_SiegeTerritoryFilterBG:GetSizeY() / 2)
end
function worldmapGrand:territoryFiltterSetPosWithMajorSiege()
  if nil == Panel_WorldMap_Main or nil == self.ui.btn_SiegeTerritoryFilter then
    return
  end
  self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.filterBg:GetSizeX(), self.ui.stc_SiegeTerritoryFilterBG:GetSizeY())
  if _ContentsGroup_OceanSiege == true then
    self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.filterBg:GetSizeX() + 40, self.ui.stc_SiegeTerritoryFilterBG:GetSizeY())
  end
  local padding = 10
  local posY = 0
  if _ContentsGroup_WorldMapMenuFilter == true then
    posY = 55
  else
    posY = self.ui.filterBg:GetPosY() + self.ui.filterBg:GetSizeY() + padding
  end
  local tempRadioButton
  local buttonPosY = self.ui.btn_SiegeTerritoryFilter:GetSizeY() / 2
  local showCount = 0
  if true == self._isMajorSiegeView then
    local half = self._currentMajorSiegeCount / 2
    local addSize = self.ui.btn_SiegeTerritoryFilter:GetSizeX() + padding
    local basePosX = self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() / 2 - self.ui.btn_SiegeTerritoryFilter:GetSizeX() * half - padding * (half - 0.5)
    for i = 1, #self.ui.btn_SiegeTerritoryFilterList do
      if nil ~= self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]] then
        if true == ToClient_isStartMajorSiege(territoryIndex[i]) then
          self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetPosX(basePosX + addSize * showCount)
          self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetPosY(buttonPosY)
          self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetShow(true)
          showCount = showCount + 1
        else
          self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetShow(false)
        end
      end
    end
    if _ContentsGroup_OceanSiege == true and self.ui.btn_OceanSiege ~= nil then
      self.ui.btn_OceanSiege:SetShow(false)
    end
  else
    local half = #self.ui.btn_SiegeTerritoryFilterList / 2
    if _ContentsGroup_OceanSiege == true then
      half = (#self.ui.btn_SiegeTerritoryFilterList + 1) / 2
    end
    local basePosX = self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() / 2 - self.ui.btn_SiegeTerritoryFilter:GetSizeX() * half - padding * (half - 0.5)
    local addSize = self.ui.btn_SiegeTerritoryFilter:GetSizeX() + padding
    for i = 1, #self.ui.btn_SiegeTerritoryFilterList do
      if nil ~= self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]] then
        self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetPosX(basePosX)
        self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:SetPosY(buttonPosY)
        self.ui.btn_SiegeTerritoryFilterList[territoryIndex[i]]:addInputEvent("Mouse_LUp", "HandleEventLUp_GrandWorldMap_TerritoryInfoShow(" .. territoryIndex[i] .. ")")
        basePosX = basePosX + addSize
      end
    end
    if _ContentsGroup_OceanSiege == true and self.ui.btn_OceanSiege ~= nil then
      self.ui.btn_OceanSiege:SetShow(true)
      self.ui.btn_OceanSiege:SetPosX(basePosX)
      self.ui.btn_OceanSiege:SetPosY(buttonPosY)
    end
  end
  self.ui.stc_SiegeTerritoryFilterBG:SetPosY(posY)
  self.ui.stc_SiegeTerritoryFilterBG:SetPosX(getScreenSizeX() - self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() - padding * 2)
  posY = self.ui.stc_SiegeTerritoryFilterBG:GetPosY() + self.ui.stc_SiegeTerritoryFilterBG:GetSizeY() + padding
  if true == self._isMajorSiegeView then
    self.ui.comboBox_DaySelect:SetShow(false)
    self.ui.comboBox_TaxGrade:SetShow(false)
    self.ui.btn_TerritoryInfoMy:SetShow(false)
    self.ui.btn_TerritoryInfoAll:SetPosY(posY)
  else
    self.ui.comboBox_DaySelect:SetShow(true)
    self.ui.comboBox_TaxGrade:SetShow(true)
    self.ui.btn_TerritoryInfoMy:SetShow(true)
    self.ui.comboBox_DaySelect:SetPosY(posY)
    self.ui.comboBox_TaxGrade:SetPosY(posY)
    self.ui.btn_TerritoryInfoMy:SetPosY(posY)
    posY = self.ui.comboBox_DaySelect:GetPosY() + self.ui.comboBox_DaySelect:GetSizeY() + padding
    self.ui.btn_TerritoryInfoAll:SetPosY(posY)
    local sizeX = (self.ui.stc_SiegeTerritoryFilterBG:GetSizeX() - padding * 2) / 3
    self.ui.comboBox_DaySelect:SetSize(sizeX, self.ui.comboBox_DaySelect:GetSizeY())
    self.ui.comboBox_TaxGrade:SetSize(sizeX, self.ui.comboBox_TaxGrade:GetSizeY())
    self.ui.btn_TerritoryInfoAll:SetSize(sizeX, self.ui.btn_TerritoryInfoAll:GetSizeY())
    self.ui.btn_TerritoryInfoMy:SetSize(sizeX, self.ui.btn_TerritoryInfoMy:GetSizeY())
    local posX = getScreenSizeX() - self.ui.comboBox_DaySelect:GetSizeX() - padding * 2
    self.ui.comboBox_DaySelect:SetPosX(posX)
    posX = self.ui.comboBox_DaySelect:GetPosX() - self.ui.comboBox_TaxGrade:GetSizeX() - padding
    self.ui.comboBox_TaxGrade:SetPosX(posX)
    posX = self.ui.comboBox_TaxGrade:GetPosX() - self.ui.btn_TerritoryInfoMy:GetSizeX() - padding
    self.ui.btn_TerritoryInfoMy:SetPosX(posX)
    self.ui.btn_TerritoryInfoAll:SetPosX(self.ui.btn_TerritoryInfoMy:GetPosX())
  end
  if _currentRenderMode ~= eWorldmapState.eWMS_GUILD_WAR then
    self.ui.comboBox_DaySelect:SetShow(false)
    self.ui.comboBox_TaxGrade:SetShow(false)
    self.ui.btn_TerritoryInfoMy:SetShow(false)
  end
  self.ui.stc_TerritoryInfo:SetSize(self.ui.stc_SiegeTerritoryFilterBG:GetSizeX(), self.ui.btn_SiegeTerritoryFilter:GetSizeY() + padding * 2)
  self.ui.stc_TerritoryInfo:SetSpanSize(self.ui.stc_TerritoryInfo:GetSpanSize().x, self.ui.btn_SiegeTerritoryFilter:GetSizeX() + buttonPosY + padding * 2)
  self.ui.stc_switchSiegeType:SetPosY(self.ui.stc_TerritoryInfo:GetPosY() + self.ui.stc_TerritoryInfo:GetSizeY() + padding * 2)
  self.ui.stc_switchSiegeType:SetSize(self.ui.stc_SiegeTerritoryFilterBG:GetSizeX(), self.ui.stc_switchSiegeType:GetSizeY())
  self.ui.stc_switchSiegeType:ComputePosAllChild()
end
function worldmapGrand:updateMinorSiege2022TerritoryInfoSize()
  if _ContentsGroup_MinorSiege2022 == false then
    return
  end
  self.ui.stc_TerritoryInfoTitle:SetSize(self.ui.stc_TerritoryInfoTitle:GetSizeX(), self.ui.stc_TerritoryInfoTitle:GetTextSizeY() * 2)
  self.ui.stc_TerritoryInfoTitle:ComputePos()
  local changeInfoSizeY = self.ui.stc_TerritoryInfoTitle:GetSizeY() + self.ui.stc_TerritoryInfoTitle:GetSpanSize().y * 2
  self.ui.stc_TerritoryInfo:SetSize(self.ui.stc_TerritoryInfo:GetSizeX(), changeInfoSizeY)
  local infoSwitchButtonGapY = 0
  if self.ui.stc_switchSiegeType:GetShow() == true then
    infoSwitchButtonGapY = self.ui.stc_switchSiegeType:GetSizeY()
  end
  local territoryFilterBGSizeY = self.ui.stc_TerritoryInfo:GetPosY() + changeInfoSizeY + infoSwitchButtonGapY
  self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.stc_SiegeTerritoryFilterBG:GetSizeX(), territoryFilterBGSizeY)
end
function worldmapGrand:territoryInfoShowforMajorSiege(territoryKeyIndex)
  local title = PAGetString(Defines.StringSheet_RESOURCE, "LUA_TERRITORY_WAR_INFO")
  local day = ""
  local territoryKey, territoryName
  self.ui.stc_TerritoryInfoDay:SetShow(_ContentsGroup_MinorSiege2022 == false)
  self.ui.stc_TerritoryInfoTitle:SetTextMode(__eTextMode_AutoWrap)
  if territoryKeyIndex == -1 then
    if _ContentsGroup_MinorSiege2022 == false then
      local today = ToClient_GetDayOfWeek()
      for i = 1, #self.ui.btn_SiegeTerritoryFilterList do
        if true == ToClient_isStartMajorSiege(territoryIndex[i]) then
          territoryKey = getTerritoryByIndex(territoryIndex[i])
          territoryName = getTerritoryNameByKey(territoryKey)
          day = day .. territoryName .. "/"
        end
      end
      day = string.sub(day, 1, string.len(day) - 1)
      self.ui.stc_TerritoryInfoTitle:SetText(day)
      self.ui.stc_TerritoryInfoDay:SetText("")
      self.ui.stc_TerritoryInfoTitle:ComputePos()
      self.ui.stc_TerritoryInfoTitle:SetPosY(self.ui.stc_TerritoryInfo:GetSizeY() / 2 - 10)
      self.ui.stc_TerritoryInfoDay:ComputePos()
      self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.stc_SiegeTerritoryFilterBG:GetSizeX(), self._territoryFilterBgBaseSizeY + 52)
    else
      self.ui.stc_TerritoryInfoTitle:SetText(title)
      self:updateMinorSiege2022TerritoryInfoSize()
    end
    self.ui.stc_SiegeTerritoryFilterBar:SetShow(false)
    GuildWar_SetType()
    return
  end
  self.ui.stc_TerritoryInfoTitle:SetPosY(self._territoryInfoBasePosY + 10)
  if nil ~= self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex] then
    self.ui.stc_SiegeTerritoryFilterBar:SetPosX(self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex]:GetPosX())
    self.ui.stc_SiegeTerritoryFilterBar:SetPosY(self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex]:GetPosY() + self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex]:GetSizeY() + 5)
  end
  territoryKey = getTerritoryByIndex(territoryKeyIndex)
  territoryName = getTerritoryNameByKey(territoryKey)
  self.ui.stc_TerritoryInfoTitle:SetText(title .. " : " .. territoryName)
  if _ContentsGroup_MinorSiege2022 == false then
    day = day .. dayStringShort[UI_VT.eVillageSiegeType_Saturday]
    day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", day)
    self.ui.stc_TerritoryInfoDay:SetText(day)
    self.ui.stc_TerritoryInfoDay:ComputePos()
    self.ui.stc_TerritoryInfoTitle:ComputePos()
  else
    self:updateMinorSiege2022TerritoryInfoSize()
  end
  self.ui.stc_SiegeTerritoryFilterBar:SetShow(true)
  GuildWar_SetType()
end
function worldmapGrand:territoryInfoShow(territoryKeyIndex)
  if nil == Panel_WorldMap_Main then
    return
  end
  if true == self._isMajorSiegeView then
    self:territoryInfoShowforMajorSiege(territoryKeyIndex)
    return
  end
  local title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NODEGUILDWARMENU_TITLE")
  local day = ""
  local territoryKey, territoryName
  self.ui.stc_TerritoryInfoDay:SetShow(_ContentsGroup_MinorSiege2022 == false)
  self.ui.stc_TerritoryInfoTitle:SetTextMode(__eTextMode_AutoWrap)
  if territoryKeyIndex == -1 then
    if _ContentsGroup_MinorSiege2022 == false then
      local today = ToClient_GetDayOfWeek()
      for i = 1, #self.ui.btn_SiegeTerritoryFilterList do
        territoryKey = getTerritoryByIndex(territoryIndex[i])
        if nil ~= territoryKey and true == ToClient_checkSiegeDay(territoryKey, today) then
          territoryName = getTerritoryNameByKey(territoryKey)
          day = day .. territoryName .. "/"
        end
      end
      day = string.sub(day, 1, string.len(day) - 1)
      day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_OUTSIDENIDE_TERRITORY_DESC", "name", day)
      self.ui.stc_TerritoryInfoTitle:SetText(day)
      self.ui.stc_TerritoryInfoDay:SetText("")
      self.ui.stc_TerritoryInfoTitle:ComputePos()
      self.ui.stc_TerritoryInfoTitle:SetPosY(self.ui.stc_TerritoryInfo:GetSizeY() / 2 - 10)
      self.ui.stc_TerritoryInfoDay:ComputePos()
      self.ui.stc_SiegeTerritoryFilterBG:SetSize(self.ui.stc_SiegeTerritoryFilterBG:GetSizeX(), self._territoryFilterBgBaseSizeY + 52)
    else
      self.ui.stc_TerritoryInfoTitle:SetText(title)
      self:updateMinorSiege2022TerritoryInfoSize()
    end
    self.ui.stc_SiegeTerritoryFilterBar:SetShow(false)
    GuildWar_SetType()
    return
  end
  self.ui.stc_TerritoryInfoTitle:SetPosY(self._territoryInfoBasePosY)
  if nil ~= self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex] then
    self.ui.stc_SiegeTerritoryFilterBar:SetPosX(self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex]:GetPosX())
    self.ui.stc_SiegeTerritoryFilterBar:SetPosY(self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex]:GetPosY() + self.ui.btn_SiegeTerritoryFilterList[territoryKeyIndex]:GetSizeY() + 5)
  end
  territoryKey = getTerritoryByIndex(territoryKeyIndex)
  territoryName = getTerritoryNameByKey(territoryKey)
  self.ui.stc_TerritoryInfoTitle:SetText(title .. " : " .. territoryName)
  for i = 0, UI_VT.eVillageSiegeType_Count - 1 do
    if true == ToClient_checkSiegeDay(territoryKey, i) then
      day = day .. dayStringShort[i] .. "/"
    end
  end
  if _ContentsGroup_MinorSiege2022 == false then
    day = string.sub(day, 1, string.len(day) - 1)
    day = PAGetStringParam1(Defines.StringSheet_GAME, "LUA_WORLDMAP_ACTORTOOLTIP_GUILDWARDAY", "day", day)
    self.ui.stc_TerritoryInfoDay:SetText(day)
    self.ui.stc_TerritoryInfoDay:ComputePos()
    self.ui.stc_TerritoryInfoTitle:ComputePos()
  else
    self:updateMinorSiege2022TerritoryInfoSize()
  end
  self.ui.stc_SiegeTerritoryFilterBar:SetShow(true)
  GuildWar_SetType()
end
function GuildWar_SetTerritoryKey(territoryKeyIndex)
  if -1 == territoryKeyIndex then
    worldmapGrand:territoryInfoShow(territoryKeyIndex)
    ToClient_resetVisibleVillageTerritoryKey()
  else
    local territoryKey = getTerritoryByIndex(territoryKeyIndex)
    if nil == territoryKey then
      return
    end
    if true == worldmapGrand._isMajorSiegeView then
      ToClient_setVisibleMajorSiegeTerritoryKey(territoryKey)
    else
      ToClient_setVisibleVillageTerritoryKey(territoryKey)
    end
  end
end
function HandleEventLUp_GrandWorldMap_GuildWar_ResetDayAndGrade()
  GuildWar_SetGradeUseIndex(-1, true)
  GuildWar_SetDayUseIndex(0, true)
  worldmapGrand._currentSelectTerritoryIndex = -1
  worldmapGrand._isMajorSiegeView = false
  ToClient_SetMajorSiegeViewMode(worldmapGrand._isMajorSiegeView)
  worldmapGrand:territoryInfoShow(-1)
  HandleClicked_MajorSiegeView(false)
  ToClient_resetVisibleVillageTerritoryKey()
  worldmapGrand.ui.comboBox_DaySelect:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTDAY"))
  worldmapGrand.ui.comboBox_TaxGrade:SetText(PAGetString(Defines.StringSheet_GAME, "LUA_VILLAGETENT_SELECTTAXGRADE"))
  worldmapGrand.ui.btn_TerritoryInfoMy:SetCheck(false)
  ToClient_resetVisibleVillageMyGuild()
end
function HandleEventLUp_GrandWorldMap_GuildWar_setShowMyGuild()
  if nil == worldmapGrand then
    return
  end
  if true == worldmapGrand.ui.btn_TerritoryInfoMy:IsCheck() then
    ToClient_setVisibleVillageMyGuild()
  else
    ToClient_resetVisibleVillageMyGuild()
  end
end
function HandleEventLUp_GrandWorldMap_GuildWar_SetTerritoryKey(territoryKeyIndex)
  GuildWar_SetTerritoryKey(territoryKeyIndex)
end
function HandleEventLUp_GrandWorldMap_TerritoryInfoShow(territoryKey)
  if nil == worldmapGrand then
    return
  end
  if worldmapGrand._currentSelectTerritoryIndex == territoryKey then
    worldmapGrand._currentSelectTerritoryIndex = -1
    worldmapGrand:territoryInfoShow(worldmapGrand._currentSelectTerritoryIndex)
    ToClient_resetVisibleVillageTerritoryKey()
    return
  end
  if _ContentsGroup_MinorSiege2022 == true then
    local viewDistance = 200000
    if worldmapGrand._isMajorSiegeView == true then
      if majorSiegeViewDistance[territoryKey] ~= nil then
        viewDistance = majorSiegeViewDistance[territoryKey]
      end
    elseif minorSiegeViewDistance[territoryKey] ~= nil then
      viewDistance = minorSiegeViewDistance[territoryKey]
    end
    ToClient_SetDistanceCamera(viewDistance)
  end
  worldmapGrand._currentSelectTerritoryIndex = territoryKey
  worldmapGrand:territoryInfoShow(territoryKey)
  GuildWar_SetTerritoryKey(territoryKey)
  local mainTownPos = ToClient_getMainTwonPosition(territoryKey)
  ToCleint_gotoWorldmapPosition(mainTownPos)
  GuildWar_SetType()
  worldmapGrand._isOnlyOceanSiegeView = false
end
function HandleEventLUp_GrandWorldMap_OceanTerritoryInfoShow()
  if worldmapGrand == nil then
    return
  end
  if _ContentsGroup_OceanSiege == false then
    return
  end
  local title = PAGetString(Defines.StringSheet_RESOURCE, "PANEL_NODEGUILDWARMENU_TITLE")
  worldmapGrand._currentSelectTerritoryIndex = -1
  if worldmapGrand._isOnlyOceanSiegeView == true then
    worldmapGrand._isOnlyOceanSiegeView = false
    ToClient_SetOceanSiegeViewMode(true, true)
    worldmapGrand.ui.stc_SiegeTerritoryFilterBar:SetShow(false)
  else
    worldmapGrand._isOnlyOceanSiegeView = true
    ToClient_SetOceanSiegeViewMode(true, false)
    ToClient_SetDistanceCamera(oceanSiegeCameraInfo.distance)
    ToCleint_gotoWorldmapPosition(oceanSiegeCameraInfo.pos)
    worldmapGrand.ui.stc_SiegeTerritoryFilterBar:SetShow(true)
    worldmapGrand.ui.stc_SiegeTerritoryFilterBar:SetPosX(worldmapGrand.ui.btn_OceanSiege:GetPosX())
    worldmapGrand.ui.stc_SiegeTerritoryFilterBar:SetPosY(worldmapGrand.ui.btn_OceanSiege:GetPosY() + worldmapGrand.ui.btn_OceanSiege:GetSizeY() + 5)
    worldmapGrand.ui.stc_TerritoryInfoTitle:SetTextMode(__eTextMode_AutoWrap)
    title = title .. " : " .. PAGetString(Defines.StringSheet_RESOURCE, "PANEL_BLUEWAR_DESC")
  end
  worldmapGrand.ui.stc_TerritoryInfoTitle:SetText(title)
  worldmapGrand.ui.stc_TerritoryInfoTitle:ComputePos()
  GuildWar_SetType()
end
function FromClient_WorldMapMajorSiegeChangeRegion_GrandWorldMapMain(territoryKey)
  HandleEventLUp_GrandWorldMap_TerritoryInfoShow(territoryKey)
end
function HandleClicked_GrandWorldMap_SearchNode()
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  local searchString = worldmapGrand.ui.edit_NodeName:GetEditText()
  worldmapGrand.config.searchType = worldmapGrand_SearchType.nodeName
  ClearFocusEdit()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
  worldmapGrand.config.searchingResultCount = ToClient_FindNodeByName(tostring(searchString))
  worldmapGrand.ui.list_scroll:SetControlPos(0)
  worldmapGrand.config.scrollStartIdx = 0
  worldmapGrand:UpdateList()
end
function HandleClicked_GrandWorldMap_SearchGuild()
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  local searchString = worldmapGrand.ui.edit_GuildName:GetEditText()
  worldmapGrand.config.searchType = worldmapGrand_SearchType.GuildName
  ClearFocusEdit()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
  worldmapGrand.config.searchingResultCount = ToClient_findNodebyGuildName(tostring(searchString))
  worldmapGrand.ui.list_scroll:SetControlPos(0)
  worldmapGrand.config.scrollStartIdx = 0
  worldmapGrand:UpdateList()
end
function HandleClicked_GrandWorldMap_SearchItem()
  worldmapGrand.ui.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  local searchString = worldmapGrand.ui.edit_ItemName:GetEditText()
  worldmapGrand.config.searchType = worldmapGrand_SearchType.itemName
  ClearFocusEdit()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
  worldmapGrand.config.searchingResultCount = ToCleint_findHouseByItemName(tostring(searchString))
  worldmapGrand.ui.list_scroll:SetControlPos(0)
  worldmapGrand.config.scrollStartIdx = 0
  worldmapGrand:UpdateList()
end
function HandleClicked_GrandWorldMap_SearchUseType()
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  local searchString = worldmapGrand.ui.edit_UseType:GetEditText()
  worldmapGrand.config.searchType = worldmapGrand_SearchType.UseType
  ClearFocusEdit()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
  worldmapGrand.config.searchingResultCount = ToClient_findHouseByHouseUseTypeName(tostring(searchString))
  worldmapGrand.ui.list_scroll:SetControlPos(0)
  worldmapGrand.config.scrollStartIdx = 0
  worldmapGrand:UpdateList()
end
function HandleClicked_MajorSiegeView(isSet)
  worldmapGrand._isMajorSiegeView = isSet
  ToClient_SetMajorSiegeViewMode(isSet)
  if true == worldmapGrand._isMajorSiegeView then
    WorldMapCheckListChange(CppEnums.WorldMapCheckState.eCheck_Node, false)
    CheckStateByChangeMode()
  end
  GuildWar_SetType()
  worldmapGrand._currentSelectTerritoryIndex = -1
  GuildWar_SetTerritoryKey(-1)
  worldmapGrand:territoryFilterShow(true)
  worldmapGrand:territoryInfoShow(-1)
end
function HandleClicked_GrandWorldMap_SearchNode_ResetString()
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  worldmapGrand.ui.edit_NodeName:SetEditText("", true)
  SetUIMode(Defines.UIMode.eUIMode_WoldMapSearch)
end
function HandleClicked_GrandWorldMap_SearchGuild_ResetString()
  worldmapGrand.ui.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_GuildName:SetEditText("", true)
  SetUIMode(Defines.UIMode.eUIMode_WoldMapSearch)
end
function HandleClicked_GrandWorldMap_SearchItem_ResetString()
  worldmapGrand.ui.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  worldmapGrand.ui.edit_GuildName:SetEditText(worldmapGrand.config.searchDefaultGuildName, true)
  worldmapGrand.ui.edit_ItemName:SetEditText("", true)
  SetUIMode(Defines.UIMode.eUIMode_WoldMapSearch)
end
function HandleClicked_GrandWorldMap_SearchUseType_ResetString()
  worldmapGrand.ui.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_GuildName:SetEditText(worldmapGrand.config.searchDefaultGuildName, true)
  worldmapGrand.ui.edit_UseType:SetEditText("", true)
  SetUIMode(Defines.UIMode.eUIMode_WoldMapSearch)
end
function HandleClicked_GrandWorldMap_SearchNodeType(typeIndex)
  if worldMapNodeType.note == typeIndex then
    return
  end
  worldmapGrand.ui.edit_NodeName:SetEditText(worldmapGrand.config.searchDefaultNodeName, true)
  worldmapGrand.ui.edit_ItemName:SetEditText(worldmapGrand.config.searchDefaultItemName, true)
  worldmapGrand.ui.edit_UseType:SetEditText(worldmapGrand.config.searchDefaultUseType, true)
  worldmapGrand.config.searchType = worldmapGrand_SearchType.nodeType
  worldmapGrand.config.selectNodeType = typeIndex
  worldmapGrand.config.searchingResultCount = ToClient_FindNodeByType(typeIndex)
  worldmapGrand.ui.list_scroll:SetControlPos(0)
  worldmapGrand.config.scrollStartIdx = 0
  worldmapGrand:UpdateList()
  PaGlobal_TutorialManager:handleClickedGrandWorldMapSearchNodeType(typeIndex)
end
function HandleClicked_GrandWorldMap_GotoNodeFocus(resultIdx)
  if worldmapGrand_SearchType.nodeName == worldmapGrand.config.searchType or worldmapGrand_SearchType.nodeType == worldmapGrand.config.searchType then
    ToCleint_gotoFindTown(resultIdx)
  elseif worldmapGrand_SearchType.itemName == worldmapGrand.config.searchType then
    ToClient_gotoHouseNode(resultIdx)
  elseif worldmapGrand_SearchType.GuildName == worldmapGrand.config.searchType then
    ToCleint_gotoFindTown(resultIdx)
  else
    ToClient_gotoHouseNodeHouseUseType(resultIdx)
  end
  PaGlobal_TutorialManager:handleClickedGrandWorldmapGotoNodeFocus(resultIdx)
end
function FGlobal_WorldmapMain_GotoBuildingMostRemainExpiredTime()
  if false == Panel_WorldMap_Main:GetShow() then
    return
  end
  local buildingInfo = ToClient_getBuildingInfoMostRemainExpiredTime()
  if nil == buildingInfo then
    return
  end
  local buildingPosition = buildingInfo:getPosition()
  ToCleint_gotoWorldmapPosition(buildingPosition)
end
function GrandWorldMap_Scroll(isUp)
  worldmapGrand.ui.list_scroll:SetInterval(worldmapGrand.config.searchingResultCount - worldmapGrand.config.searchingResultMaxCount)
  worldmapGrand.config.scrollStartIdx = UIScroll.ScrollEvent(worldmapGrand.ui.list_scroll, isUp, worldmapGrand.config.searchingResultMaxCount, worldmapGrand.config.searchingResultCount, worldmapGrand.config.scrollStartIdx, 1)
  worldmapGrand:UpdateList()
end
function HandleClicked_GrandWorldMap_ScrollPress()
  local config = worldmapGrand.config
  local scrollPos = worldmapGrand.ui.list_scroll:GetControlPos()
  local resultCount = config.searchingResultCount
  local maxViewCount = config.searchingResultMaxCount
  config.scrollStartIdx = math.ceil((resultCount - maxViewCount) * scrollPos)
  worldmapGrand:UpdateList()
end
function HandleOnout_GrandWorldMap_explorePointHelp(isShow)
  local control = worldmapGrand.ui.explorePointHelp
  if isShow then
    local name = PAGetString(Defines.StringSheet_GAME, "LUA_WORLDMAPGRAND_HELPICON_EXPLORERPOINT")
    local desc
    registTooltipControl(control, Panel_Tooltip_SimpleText)
    TooltipSimple_Show(control, name, desc)
  else
    TooltipSimple_Hide()
  end
end
function FGlobal_GrandWorldMap_SearchToWorldMapMode()
  ClearFocusEdit()
  SetUIMode(Defines.UIMode.eUIMode_WorldMap)
end
function worldmapGrand_OnScreenResize()
  Panel_WorldMap_Main:SetSize(getScreenSizeX(), getScreenSizeY())
  worldmapGrand.ui.ModeBG:ComputePos()
end
function FromClient_RenderStateChange(state)
  if _ContentsGroup_WorldMapMenuFilter == true then
    for menuState, value in pairs(worldMapMenuState) do
      worldMapMenuState[menuState] = ToClient_isWorldmapCheckState(menuState)
    end
  else
    for checkIndex, value in pairs(worldMapCheckState) do
      worldMapCheckState[checkIndex]:SetCheck(ToClient_isWorldmapCheckState(checkIndex))
    end
  end
end
function worldmapGrand:registEventHandler()
  local ui = self.ui
  ui.ListBG:addInputEvent("Mouse_UpScroll", "GrandWorldMap_Scroll( true )")
  ui.ListBG:addInputEvent("Mouse_DownScroll", "GrandWorldMap_Scroll( false )")
  ui.buttonBlackSpirit:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_BlackSpiritButton()")
  ui.buttonTutorial_1:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_TutorialButton( 1 )")
  ui.buttonTutorial_2:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_TutorialButton( 2 )")
  ui.buttonTutorial_3:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_TutorialButton( 3 )")
  ui.btn_SearchNodeName:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchNode()")
  ui.btn_SearchItemName:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchItem()")
  ui.btn_SearchUseType:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchUseType()")
  ui.btn_SearchGuildName:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchGuild()")
  ui.edit_NodeName:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchNode_ResetString()")
  ui.edit_NodeName:RegistReturnKeyEvent("HandleClicked_GrandWorldMap_SearchNode()")
  ui.edit_GuildName:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchGuild_ResetString()")
  ui.edit_GuildName:RegistReturnKeyEvent("HandleClicked_GrandWorldMap_SearchGuild()")
  ui.edit_ItemName:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchItem_ResetString()")
  ui.edit_ItemName:RegistReturnKeyEvent("HandleClicked_GrandWorldMap_SearchItem()")
  ui.edit_UseType:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_SearchUseType_ResetString()")
  ui.edit_UseType:RegistReturnKeyEvent("HandleClicked_GrandWorldMap_SearchUseType()")
  ui.ListBG:SetIgnore(false)
  ui.ListBG:SetSize(ui.ListBG:GetSizeX(), ui.list_scroll:GetSizeY())
  ui.list_scrollBtn:addInputEvent("Mouse_LPress", "HandleClicked_GrandWorldMap_ScrollPress()")
  ui.list_scrollBtn:addInputEvent("Mouse_UpScroll", "GrandWorldMap_Scroll( true )")
  ui.list_scrollBtn:addInputEvent("Mouse_DownScroll", "GrandWorldMap_Scroll( false )")
  ui.list_scroll:addInputEvent("Mouse_LUp", "HandleClicked_GrandWorldMap_ScrollPress()")
  ui.btn_majorSiege:addInputEvent("Mouse_LUp", "HandleClicked_MajorSiegeView(true)")
  ui.btn_minorSiege:addInputEvent("Mouse_LUp", "HandleClicked_MajorSiegeView(false)")
  ui.btn_TerritoryInfoAll:addInputEvent("Mouse_LUp", "HandleEventLUp_GrandWorldMap_GuildWar_ResetDayAndGrade()")
  ui.btn_TerritoryInfoMy:addInputEvent("Mouse_LUp", "HandleEventLUp_GrandWorldMap_GuildWar_setShowMyGuild()")
  registerEvent("FromClient_RenderStateChange", "FromClient_RenderStateChange")
  registerEvent("FromClient_MouseOnWorldmapMonsterInfo", "FromClient_MouseOnWorldmapMonsterInfo")
  registerEvent("FromClient_MouseOutWorldmapMonsterInfo", "FromClient_MouseOutWorldmapMonsterInfo")
  registerEvent("FromClient_WorldMapMajorSiegeChangeRegion", "FromClient_WorldMapMajorSiegeChangeRegion_GrandWorldMapMain")
  registerEvent("FromClient_UpdateHardCoreBossListUI", "PaGlobalFunc_UpdateHardCoreBossListUI")
  if _ContentsGroup_WorldMapMenuFilter == true then
    ui.chk_contentsList:addInputEvent("Mouse_LUp", "WorldMapContentsListCheck()")
    ui.chk_search:addInputEvent("Mouse_LUp", "WorldMapSearchMenuCheck()")
    ui.list2_contents:registEvent(__ePAUIList2EventType_LuaChangeContent, "UpdateMenuContensList")
    ui.list2_contents:createChildContent(__ePAUIList2ElementManagerType_List)
  end
end
function maptest(scale, minScale, maxScale, yGap)
  ToClient_SetScalerWorldmapMonsterInfo(scale, minScale, maxScale, yGap)
end
MakeSearchResultPool()
MakeNodeListType()
nodeControl_SetTexture()
MakeModeChekcState()
if _ContentsGroup_WorldMapMenuFilter == true then
  MoveSearchUI()
else
  MakeModeButton()
end
function FromClient_luaLoadComplete_WorldmapMain()
  FGlobal_WorldmapMain_InitTutorialButton()
  worldmapGrand:registEventHandler()
end
function PaGlobalFunc_WorldmapMain_ToggleButtonByObserver()
  if nil == Panel_WorldMap_Main then
    return
  end
  isShowUIByObserver = not isShowUIByObserver
  FGlobal_SetShow_WorldmapSearchMenu(isShowUIByObserver)
  worldmapGrand.ui.explorePointBG:SetShow(isShowUIByObserver)
  worldmapGrand.ui.filterBg:SetShow(isShowUIByObserver)
  if _ContentsGroup_WorldMapMenuFilter == true then
    stc_contentsList:SetShow(isShowUIByObserver)
    stc_search:SetShow(isShowUIByObserver)
    if worldMapMenuState ~= nil then
      for menuState, value in pairs(worldMapMenuState) do
        if value ~= nil then
          value = isShowUIByObserver
        end
      end
    end
  elseif worldMapCheckState ~= nil then
    for checkIndex, value in pairs(worldMapCheckState) do
      if nil ~= value then
        value:SetShow(isShowUIByObserver)
      end
    end
  end
  if nil ~= worldMapState then
    for checkIndex, value in pairs(worldMapState) do
      if nil ~= value then
        value:SetShow(isShowUIByObserver)
      end
    end
  end
  if true == isShowUIByObserver then
    if _currentRenderMode == eWorldmapState.eWMS_GUILD_WAR then
      worldmapGrand.ui.comboBox_DaySelect:SetShow(true)
      worldmapGrand.ui.comboBox_TaxGrade:SetShow(true)
      worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(true)
      worldmapGrand.ui.btn_TerritoryInfoMy:SetShow(true)
      worldmapGrand.ui.stc_SiegeTerritoryFilterBG:SetShow(true)
    elseif _currentRenderMode == eWorldmapState.eWMS_PRODUCT_NODE then
      worldmapGrand.ui.nodeSelectBg:SetShow(true)
      worldmapGrand.ui.nodeSelectTitle:SetShow(true)
      worldmapGrand.ui.comboBox_TerritorySelect:SetShow(true)
      worldmapGrand.ui.comboBox_NodeType:SetShow(true)
    elseif _currentRenderMode == eWorldmapState.eWMS_FAMILY_CHARACTER then
    end
    AlignButtonPosition()
  else
    worldmapGrand.ui.comboBox_DaySelect:SetShow(false)
    worldmapGrand.ui.comboBox_TaxGrade:SetShow(false)
    worldmapGrand.ui.btn_TerritoryInfoAll:SetShow(false)
    worldmapGrand.ui.btn_TerritoryInfoMy:SetShow(false)
    worldmapGrand.ui.stc_SiegeTerritoryFilterBG:SetShow(false)
    worldmapGrand.ui.nodeSelectBg:SetShow(false)
    worldmapGrand.ui.nodeSelectTitle:SetShow(false)
    worldmapGrand.ui.comboBox_TerritorySelect:SetShow(false)
    worldmapGrand.ui.comboBox_NodeType:SetShow(false)
  end
end
registerEvent("onScreenResize", "worldmapGrand_OnScreenResize")
registerEvent("FromClient_luaLoadComplete", "FromClient_luaLoadComplete_WorldmapMain")
