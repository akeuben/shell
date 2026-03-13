sources = files('main.vala')

dependencies = [
  dependency('glib-2.0')
]

commonLib = library('kappashell-common', sources, dependencies: dependencies, install: false)

common = declare_dependency(link_with: commonLib, dependencies: dependencies, include_directories: include_directories('.'))
