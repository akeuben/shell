sources = files('main.vala', 'windows/greeter.vala')

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

executable('kappashell-greeter', [sources, resource], dependencies: dependencies, vala_args: ['--pkg', 'passwd-1.0'], install: true)
