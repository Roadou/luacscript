PaGlobal_MyInstruments_All = {
  _ui = {
    _btn_Close_PC = nil,
    _btn_WayPoint_Shop = nil,
    _frame = nil,
    _frame_contents = nil,
    _frame_contents_txt = nil,
    _frame_contents_icon = nil,
    _frame_contents_title = nil,
    _frame_vertical = nil,
    _frame_vertical_ctrl = nil,
    _frame_horizontal = nil,
    _txt_subTitle_template = nil,
    _txt_instruments_template = nil,
    _btn_Confirm = nil
  },
  _titleTable = {},
  _controlTable = {},
  _instrumentsIcon = {},
  _AdvancedTextTable = {
    "AUDIO_MIDI_TAB_NOVICE",
    "AUDIO_MIDI_TAB_ADVANCED",
    "AUDIO_MIDI_TAB_ADVANCED_ELECTRONIC"
  },
  _instrumentsTypeCount = {
    [0] = 8,
    [1] = 8,
    [2] = 5
  },
  _instrumentsString = {
    [0] = {
      {
        midiIndex = 0,
        _name = "AUDIO_MIDI_INSTRUMENT_0",
        _itemKey = 65657
      },
      {
        midiIndex = 1,
        _name = "AUDIO_MIDI_INSTRUMENT_1",
        _itemKey = 65658
      },
      {
        midiIndex = 2,
        _name = "AUDIO_MIDI_INSTRUMENT_2",
        _itemKey = 65659
      },
      {
        midiIndex = 4,
        _name = "AUDIO_MIDI_INSTRUMENT_4",
        _itemKey = 65661
      },
      {
        midiIndex = 5,
        _name = "AUDIO_MIDI_INSTRUMENT_5",
        _itemKey = 65662
      },
      {
        midiIndex = 6,
        _name = "AUDIO_MIDI_INSTRUMENT_6",
        _itemKey = 65663
      },
      {
        midiIndex = 7,
        _name = "AUDIO_MIDI_INSTRUMENT_7",
        _itemKey = 65664
      },
      {
        midiIndex = 8,
        _name = "AUDIO_MIDI_INSTRUMENT_8",
        _itemKey = 65665
      }
    },
    [1] = {
      {
        midiIndex = 10,
        _name = "AUDIO_MIDI_INSTRUMENT_10",
        _itemKey = 65917
      },
      {
        midiIndex = 11,
        _name = "AUDIO_MIDI_INSTRUMENT_11",
        _itemKey = 65918
      },
      {
        midiIndex = 13,
        _name = "AUDIO_MIDI_INSTRUMENT_13",
        _itemKey = 65920
      },
      {
        midiIndex = 15,
        _name = "AUDIO_MIDI_INSTRUMENT_15",
        _itemKey = 66250
      },
      {
        midiIndex = 16,
        _name = "AUDIO_MIDI_INSTRUMENT_16",
        _itemKey = 65921
      },
      {
        midiIndex = 17,
        _name = "AUDIO_MIDI_INSTRUMENT_17",
        _itemKey = 65922
      },
      {
        midiIndex = 18,
        _name = "AUDIO_MIDI_INSTRUMENT_18",
        _itemKey = 65923
      },
      {
        midiIndex = 19,
        _name = "AUDIO_MIDI_INSTRUMENT_19",
        _itemKey = 65924
      },
      {
        midiIndex = 39,
        _name = "AUDIO_MIDI_INSTRUMENT_39",
        _itemKey = 66908
      },
      {
        midiIndex = 40,
        _name = "AUDIO_MIDI_INSTRUMENT_40",
        _itemKey = 66909
      }
    },
    [2] = {
      {
        midiIndex = 14,
        _name = "AUDIO_MIDI_INSTRUMENT_14",
        _itemKey = 66253
      },
      {
        midiIndex = 20,
        _name = "AUDIO_MIDI_INSTRUMENT_20",
        _itemKey = 66254
      },
      {
        midiIndex = 21,
        _name = "AUDIO_MIDI_INSTRUMENT_21",
        _itemKey = 66254
      },
      {
        midiIndex = 22,
        _name = "AUDIO_MIDI_INSTRUMENT_22",
        _itemKey = 66254
      },
      {
        midiIndex = 23,
        _name = "AUDIO_MIDI_INSTRUMENT_23",
        _itemKey = 66254
      },
      {
        midiIndex = 24,
        _name = "AUDIO_MIDI_INSTRUMENT_24",
        _itemKey = 66255
      },
      {
        midiIndex = 25,
        _name = "AUDIO_MIDI_INSTRUMENT_25",
        _itemKey = 66255
      },
      {
        midiIndex = 26,
        _name = "AUDIO_MIDI_INSTRUMENT_26",
        _itemKey = 66255
      },
      {
        midiIndex = 27,
        _name = "AUDIO_MIDI_INSTRUMENT_27",
        _itemKey = 66255
      },
      {
        midiIndex = 28,
        _name = "AUDIO_MIDI_INSTRUMENT_28",
        _itemKey = 66256
      },
      {
        midiIndex = 29,
        _name = "AUDIO_MIDI_INSTRUMENT_29",
        _itemKey = 66256
      },
      {
        midiIndex = 30,
        _name = "AUDIO_MIDI_INSTRUMENT_30",
        _itemKey = 66256
      },
      {
        midiIndex = 31,
        _name = "AUDIO_MIDI_INSTRUMENT_31",
        _itemKey = 66256
      },
      {
        midiIndex = 32,
        _name = "AUDIO_MIDI_INSTRUMENT_32",
        _itemKey = 66257
      },
      {
        midiIndex = 33,
        _name = "AUDIO_MIDI_INSTRUMENT_33",
        _itemKey = 66257
      },
      {
        midiIndex = 34,
        _name = "AUDIO_MIDI_INSTRUMENT_34",
        _itemKey = 66257
      },
      {
        midiIndex = 35,
        _name = "AUDIO_MIDI_INSTRUMENT_35",
        _itemKey = 66257
      },
      {
        midiIndex = 36,
        _name = "AUDIO_MIDI_INSTRUMENT_36",
        _itemKey = 66905
      },
      {
        midiIndex = 37,
        _name = "AUDIO_MIDI_INSTRUMENT_37",
        _itemKey = 66906
      },
      {
        midiIndex = 38,
        _name = "AUDIO_MIDI_INSTRUMENT_38",
        _itemKey = 66907
      }
    }
  },
  _initialize = false
}
runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All_1.lua")
runLua("UI_Data/Script/Window/Composition/Panel_Window_MyInstruments_All_2.lua")
registerEvent("FromClient_luaLoadComplete", "FromClient_MyInstrumentsInit")
function FromClient_MyInstrumentsInit()
  PaGlobal_MyInstruments_All:initialize()
end
