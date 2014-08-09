Pod::Spec.new do |s|
  s.name         = 'AHTabBarController'
  s.version      = '1.0'
  s.homepage     = 'https://github.com/ArthurDevNL/AHTabBarController'
  s.authors      =  { 'Arthur Hemmer' => 'arthurhemmer@hotmail.com' }
  s.summary      = 'A traditional UITabBarController with possibilities of adding multiple items behind every tab.'
    s.license      =  {
        :type => 'MIT',
        :file => 'LICENSE'
    }

# Source Info
  s.platform     =  :ios, '7.0'
  s.source       =  {
    :git => 'https://github.com/ArthurDevNL/AHTabBarController.git',
    :tag => s.version.to_s
    }
  s.source_files = 'AHTabBarController/AHTabBarController/*.{m,h}', 'AHTabBarController/AHTabBarController/Category/*.{m,h}'
  s.framework    =  'QuartzCore'

  s.requires_arc = true
  
# Pod Dependencies

end