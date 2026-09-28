sources = files('main.vala')

dependencies = [common]

# compiling data files into a binary
resource = import('gnome').compile_resources(
  'data',
  files('gresource.xml'),
  source_dir: meson.current_build_dir(),
)

executable('kappashell-desktop', [sources, resource], dependencies: dependencies, install: true)
