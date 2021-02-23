from kitty.window import DynamicColor


def main(args):
    pass

def handle_result(args, answer, target_window_id, boss):
    tab = boss.active_tab
    w = boss.window_id_map.get(target_window_id)
    if tab is not None:
       if tab.current_layout.name == 'stack':
          tab.last_used_layout()
          tab.enabled_layouts.remove('stack')
          w.change_colors({DynamicColor(2):'#1e1e1e'})
       else:
          tab.enabled_layouts.append('stack')
          tab.goto_layout('stack')
          w.change_colors({DynamicColor(2):'black'})

handle_result.no_ui = True
