Pod::Spec.new do |s|
  s.name             = 'CountDownLabel'
  s.version          = '0.1.0'
  s.summary          = 'CountDown logic via custom label. You can use use own view implementation via CountDown class usage'

  s.description      = <<-DESC
Enables using cound down logic on label or any custom UI. Uses the formatter logic.
                       DESC

  s.homepage         = 'https://github.com/pionl/CountDownLabel'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Martin Kluska' => 'martin.kluska@imakers.cz' }
  s.source           = { :git => 'https://github.com/pionl/CountDownLabel.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pionl'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CountDownLabel/Classes/**/*'

  # Bundle the localizations
  s.resource_bundle = {
    'CountDownLabel' => ['CountDownLabel/Localization/*.lproj']
  }

end
