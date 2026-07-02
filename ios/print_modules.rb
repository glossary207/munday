require 'cocoapods'
podfile = Pod::Podfile.from_file('Podfile')
config = Pod::Config.instance
config.installation_root = Pathname.pwd
analyzer = Pod::Installer::Analyzer.new(config.sandbox, podfile, config.lockfile)
analyzer.analyze
analyzer.pod_targets.each do |target|
  puts "#{target.name}: #{target.product_module_name}"
end
