#
# Be sure to run `pod lib lint Tableable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Tableable'
  s.version          = '0.3.0.0'
  s.summary          = 'Compose a UITableView data source out of separate Section data sources. Built with Swift 3. Newest available Swift 2.3 version is 0.2.0.0.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Tableable is a replacement for UITableViewDataSource / UITableViewDelegate. It lets you compose a tableview out of self-contained sections (implementing TableViewSectionable).
Perfect, for instance if the number of sections is calculated dynamically.
                       DESC

  s.homepage         = 'https://github.com/hrunar/Tableable'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Runar Svendsen' => 'runar.svendsen@gmail.com' }
  s.source           = { :git => 'https://github.com/hrunar/Tableable.git', :tag => s.version.to_s }
  #s.social_media_url = 'https://twitter.com/hrunar'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Tableable/Classes/**/*'

  # s.resource_bundles = {
  #   'Tableable' => ['Tableable/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
