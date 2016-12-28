Pod::Spec.new do |s|
  s.name             = 'NMTableView'
  s.version          = '0.0.1'
  s.summary          = 'Improved UITableView'
  s.description      = <<-DESC
An improved version of UITableView.
                       DESC

  s.homepage         = 'https://github.com/NicolasMahe/NMTableView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nicolas Mahé' => 'nicolas@mahe.me' }
  s.source           = { :git => 'https://github.com/NicolasMahe/NMTableView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'NMTableView/**/*.swift'

  s.frameworks = 'UIKit'
  s.dependency 'NMUIExtension'

end
