InvenSortLinkPanelIndex = {
  Inventory = 0,
  WareHouse = 1,
  FamilyInventory = 2,
  AnotherCharacterInventory = 3,
  MarketPlaceInventory = 4,
  MarketPlaceWallet = 5,
  MarketPlaceWalletMain = 6,
  ColsoleInventory = 7,
  ColsoleFamilyInventory = 8,
  NewbieInventory = 9,
  EnchantInventory = 10,
  ConsoleEnchantInventory = 11,
  Count = 12
}
PaGlobal_InvenAutoSort = {
  _panelList = {
    [InvenSortLinkPanelIndex.Inventory] = {
      _panel = nil,
      _contentsOption = _ContentsGroup_NewUI_Inventory_All,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.WareHouse] = {
      _panel = nil,
      _contentsOption = true,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.FamilyInventory] = {
      _panel = nil,
      _contentsOption = _ContentsGroup_FamilyInventory,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.AnotherCharacterInventory] = {
      _panel = nil,
      _contentsOption = true,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.MarketPlaceInventory] = {
      _panel = nil,
      _contentsOption = ToClient_isConsole() == false and _ContentsGroup_RenewUI_ItemMarketPlace == true or ToClient_isConsole(),
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.MarketPlaceWallet] = {
      _panel = nil,
      _contentsOption = ToClient_isConsole() == false and _ContentsGroup_RenewUI_ItemMarketPlace == true or ToClient_isConsole(),
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.MarketPlaceWalletMain] = {
      _panel = nil,
      _contentsOption = ToClient_isConsole() == false and _ContentsGroup_RenewUI_ItemMarketPlace == true or ToClient_isConsole(),
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.ColsoleInventory] = {
      _panel = nil,
      _contentsOption = _ContentsGroup_UsePadSnapping and _ContentsGroup_RenewUI_InventoryEquip,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.ColsoleFamilyInventory] = {
      _panel = nil,
      _contentsOption = _ContentsGroup_UsePadSnapping and _ContentsGroup_RenewUI_InventoryEquip,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.NewbieInventory] = {
      _panel = nil,
      _contentsOption = true,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.EnchantInventory] = {
      _panel = nil,
      _contentsOption = _ContentsGroup_EnchantRemaster,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    },
    [InvenSortLinkPanelIndex.ConsoleEnchantInventory] = {
      _panel = nil,
      _contentsOption = _ContentsGroup_UsePadSnapping and _ContentsGroup_RenewUI_InventoryEquip and _ContentsGroup_EnchantRemaster,
      _isInitialize = false,
      _isUseSort = false,
      _checkIn = false,
      _isCategoryView = false,
      _currentSortProperty = __eInventorySortPropertyType_Auto,
      _currentSortByType = __eInventorySortByType_Count,
      _ui = {
        _parent = nil,
        _sortButton = nil,
        _checkButton = nil,
        _categoryButton = nil,
        _slotButton = nil,
        _stc_sortMainArea = nil,
        _sortPropertyTypeButtonList = {},
        _stc_sortSubArea = nil,
        _rdo_ascending = nil,
        _rdo_descending = nil
      }
    }
  },
  _ui = {_stc_sortMainArea = nil, _stc_sortSubArea = nil},
  _isConsole = false,
  _currentPanelIndex = nil,
  _sortPropertyTypeButtonList = {},
  _initialize = false
}
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Inventory_AutoSortFunction_1.lua")
runLua("UI_Data/Script/Window/Inventory/Panel_Window_Inventory_AutoSortFunction_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_PaGlobalInvenAutoSortInit")
function FromClient_PaGlobalInvenAutoSortInit()
  PaGlobal_InvenAutoSort:initialize()
end
