(load "gtk.lsp")

# Window
(set 'win (gtk_window_new 0))
(gtk_window_set_title win {"Wow, Redux!"})
(gtk_widget_set_usize win 800 600)
(gtk_window_set_position win 1)
(gtk_window_set_resizable win 0)

# Widget layout

# Show all widgets
(gtk_widget_show_all win)

# Main loop
(do-until (or (= event win)(= event button))
    (begin
      (set 'event (gtk_server_callback "update"))
      (sleep 100)
    )
)

# Exit GTK
(gtk_exit 0)

# Exit newLisp
(exit)
