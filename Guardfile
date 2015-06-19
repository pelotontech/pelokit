require 'guard'
require 'guard/rspec'

spec_dirs     = (`find spec -type d -maxdepth 1 | sort | grep spec/`).split "\n"
rspec_options = { cmd:            'rspec --tty',
                  failed_mode:    :keep,
                  all_after_pass: false,
                  all_on_start:   true,
                  spec_paths:     spec_dirs }
guard :rspec, rspec_options do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
