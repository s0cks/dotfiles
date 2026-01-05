local flexoki = import 'lib/flexoki.libsonnet';
local bottom = import 'lib/bottom.libsonnet';

local Cpu(p) = 
  {
    all_entry_color: p.pu,
    avg_entry_color: p.ma,
    cpu_core_colors: p.rainbow,
  };

local Memory(p) = 
  {
    ram_color: p.pu,
    cache_color: p.ye,
    swap_color: p.gr,
    gpu_colors: p.rainbow,
    arc_color: p.bl,
  };

local Network(p) = 
  {
    rx_color: "#a6e3a1",
    tx_color: "#f38ba8",
    rx_total_color: "#89dceb",
    tx_total_color: "#a6e3a1",
  };

local Battery(p) =
  {
    high_battery_color: p.gr,
    medium_battery_color: p.ye,
    low_battery_color: p.re,
  };

local Styles(p) =
  {
    cpu: Cpu(p),
    memory: Memory(p),
    network: Network(p),
    battery: Battery(p),
    tables: {
      headers: {
        color: "#f5e0dc",
      },
    },
    graphs: {
      graph_color: "#a6adc8",
      legend_text: {
        color: "#a6adc8",
      },
    },
    widgets: {
      border_color: "#585b70",
      selected_border_color: "#f5c2e7",
      widget_title: {color: "#f2cdcd"},
      text: {color: "#cdd6f4"},
      selected_text: {color: "#11111b", bg_color: "#cba6f7"},
      disabled_text: {color: "#1e1e2e"},
    }
  };

{
  ["bottom.toml"]: bottom.manifest(Styles(flexoki.Dark)),
}
