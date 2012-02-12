# Gtk function vivification code from http://www.gtk-server.org/
# Import GTK-server and create global symbols for GTK function names
(if
  (= ostype "Win32") (import "gtk-server.dll" "gtk")
  (= ostype "OSX") (import "libgtk-server.dylib" "gtk")
  (= ostype "Linux") (import "libgtk-server.so" "gtk")
  )

# Now try to find GTK-server configfile
(set 'cfgfile (open "gtk-server.cfg" "read"))
(when (not cfgfile)
  (set 'cfgfile (open "/usr/local/etc/gtk-server.cfg" "read"))
  (when (not cfgfile) (set 'cfgfile (open "/etc/gtk-server.cfg" "read"))))

# No configfile? Exit
(when (not cfgfile)(println "No GTK-server configfile found! Exiting...")(exit))

# Create global GTK symbols
(while (read-line cfgfile)
       (when (and (starts-with (current-line) "FUNCTION_NAME") (regex "gtk_+|gdk_+|g_+" (current-line)))
         (set 'func (chop ((parse (current-line) " ") 2)))
         (set 'lb (append {(lambda()(setq s "} func {")(dolist (x (args))(setq s (string s " " x)))(get-string (gtk s)))}))
         (constant (global (sym func)) (eval-string lb))))

(close cfgfile)

(constant (global 'NULL) "NULL")
