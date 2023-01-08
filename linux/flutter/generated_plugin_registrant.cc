//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <bitsdojo_window_linux/bitsdojo_window_plugin.h>
#include <pillow/pillow_plugin.h>
#include <quantum/quantum_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) bitsdojo_window_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BitsdojoWindowPlugin");
  bitsdojo_window_plugin_register_with_registrar(bitsdojo_window_linux_registrar);
  g_autoptr(FlPluginRegistrar) pillow_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PillowPlugin");
  pillow_plugin_register_with_registrar(pillow_registrar);
  g_autoptr(FlPluginRegistrar) quantum_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "QuantumPlugin");
  quantum_plugin_register_with_registrar(quantum_registrar);
}
