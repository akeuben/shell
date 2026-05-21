project('kappashell', 'vala', version: '0.1.0')

vapi_dir = meson.current_source_dir() / 'vapi'
add_project_arguments(['--vapidir', vapi_dir], language: 'vala')

add_project_arguments('-w', language: 'c')

subdir('common')
subdir('desktop')
# subdir('greeter')
