sources = files('main.vala', 'windows/greeter.vala', 'windows/wallpaper.vala')

dependencies = [
  common,
  dependency('astal-greet-0.1'),
]

# compiling data files into a binary
resource = import('gnome').compile_resources(
  'data',
  files('gresource.xml'),
  source_dir: meson.current_source_dir(),
)

import('gnome').compile_schemas(
  depend_files: files('ca.kappashell.greeter.gschema.xml'),
  build_by_default: true
)

install_data(
    'ca.kappashell.greeter.gschema.xml',
    install_dir: get_option('datadir') / 'glib-2.0' / 'schemas'
)

greeter_datadir = get_option('datadir') / 'kappashell'

lua_config = configuration_data()
lua_config.set(
    'GREETER_EXECUTABLE',
    get_option('prefix') / get_option('bindir') / 'kappashell-greeter'
)
configure_file(
    input: 'hyprland.lua.in',
    output: 'hyprland.lua',
    configuration: lua_config,
    install: true,
    install_dir: greeter_datadir,
)

wrapper_config = configuration_data()
wrapper_config.set(
    'GREETER_CONFIG',
    get_option('prefix') / greeter_datadir / 'hyprland.lua'
)

configure_file(
    input: 'kappagreet.in',
    output: 'kappagreet',
    configuration: wrapper_config,
    install: true,
    install_dir: get_option('bindir'),
    install_mode: 'rwxr-xr-x',
)

executable('kappashell-greeter', [sources, resource], dependencies: dependencies, vala_args: ['--pkg', 'passwd-1.0'], install: true)
