#include <gtk/gtk.h>

void kappashell_add_css_provider(GdkDisplay *display, GtkStyleProvider *provider, guint priority) {
    gtk_style_context_add_provider_for_display(display, provider, priority);
}
