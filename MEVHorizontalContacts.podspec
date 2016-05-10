#
# Be sure to run `pod lib lint MEVHorizontalContacts.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MEVHorizontalContacts"
  s.version          = "1.0"
  s.summary          = "An iOS UICollectionViewLayout subclass to show a list of contacts with configurable expandable items."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A very customazible layout in order to show a list of Contacts with menu options and diffente items with images or icons.
                        DESC

  s.homepage         = "https://github.com/manuelescrig/MEVHorizontalContacts"
  s.screenshots      = "https://cloud.githubusercontent.com/assets/1849990/15137846/645a0d18-168c-11e6-96e2-651d8f8de3b0.gif"
  s.license          = 'MIT'
  s.author           = { "Manuel Escrig Ventura" => "manuelescrig@gmail.com" }
  s.source           = { :git => "https://github.com/manuelescrig/MEVHorizontalContacts.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/manuelescrig'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.source_files = 'MEVHorizontalContacts/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MEVHorizontalContacts' => ['MEVHorizontalContacts/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
