glob = run_command('find', '.', '-name', '*.vala')
sources = glob.stdout().strip().split('\n')

dependencies = [
  dependency('glib-2.0'),
  dependency('gtk4'),
  dependency('gtk4-layer-shell-0'),
  dependency('astal-4-4.0'),
  dependency('astal-io-0.1'),
  dependency('astal-battery-0.1'),
  dependency('astal-wireplumber-0.1'),
  dependency('astal-network-0.1'),
  dependency('astal-mpris-0.1'),
  dependency('astal-power-profiles-0.1'),
  dependency('astal-tray-0.1'),
  dependency('astal-bluetooth-0.1'),
  dependency('astal-hyprland-0.1'),
  dependency('libnm'),
  dependency('json-glib-1.0'),
  dependency('gio-2.0'),
]

# compiling data files into a binary
resource = import('gnome').compile_resources(
  'data',
  files('gresource.xml'),
  source_dir: meson.current_build_dir(),
)

common_lib = library('kappashell-common', [sources, resource], dependencies: dependencies, install: true)

common = declare_dependency(link_with: common_lib, dependencies: dependencies, include_directories: include_directories('.'))
