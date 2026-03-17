namespace Kappashell {
    public Gtk.Grid SystemTrayWidget(Json.Node config, WidgetEnvironment env) throws BarConfigError {
        var tray = AstalTray.get_default();
        var grid = new Gtk.Grid();

        NotifyHandler update_tray = () => {
            print("The tray has %u items\n",tray.items.length());
            int i = 0;
            var child = grid.get_first_child();
            while(child != null) {
                grid.remove(child);
                child = grid.get_first_child();
            }
            foreach(var item in tray.items) {
                var btn = new Gtk.Button();
                btn.add_css_class("tray-item");
                btn.set_child(new Gtk.Image.from_gicon(item.gicon));

                var menu = new Gtk.PopoverMenu.from_model(item.menu_model);

                menu.set_parent(btn);
                menu.insert_action_group("dbusmenu", item.action_group);
                menu.set_menu_model(item.menu_model);

                var a = item.notify["menu-model"].connect(() => menu.set_menu_model(item.menu_model));
                var b = item.notify["action-group"].connect(() => menu.insert_action_group("dbusmenu", item.action_group));

                btn.destroy.connect((self) => {
                    item.disconnect(a);
                    item.disconnect(b);
                    menu.unparent();
                    menu.destroy();
                });

                var leftClick = new Gtk.GestureClick();
                leftClick.button = Gdk.BUTTON_PRIMARY;
                leftClick.pressed.connect((_, x, y) => {
                    if(item.is_menu) {
                        menu.popup();
                    } else {
                        item.activate((int) x, (int) y);
                    }
                });

                var rightClick = new Gtk.GestureClick();
                rightClick.button = Gdk.BUTTON_SECONDARY;
                rightClick.pressed.connect(() => menu.popup());

                btn.add_controller(leftClick);
                btn.add_controller(rightClick);
                
                grid.attach(btn, i % 2, i / 2, 1, 1);
                i++;
            }
        };

        tray.item_added.connect(() => update_tray());
        tray.item_removed.connect(() => update_tray());

        update_tray();

        return grid;
    }
}
