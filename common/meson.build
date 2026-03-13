sources = files('main.vala')

dependencies = [
  dependency('glib-2.0'),
  dependency('gtk4'),
]

commonLib = library('kappashell-common', sources, dependencies: dependencies, install: true)

common = declare_dependency(link_with: commonLib, dependencies: dependencies, include_directories: include_directories('.'))
