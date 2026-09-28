#include <gtk/gtk.h>

void kappashell_add_css_provider(GdkDisplay *display, GtkStyleProvider *provider, guint priority) {
    gtk_style_context_add_provider_for_display(display, provider, priority);
}

void kappashell_add_css_provider_for_widget(GtkWidget *widget, GtkStyleProvider *provider, guint priority) {
    GtkStyleContext *context = gtk_widget_get_style_context(widget);
    gtk_style_context_add_provider(context, provider, priority);
}
