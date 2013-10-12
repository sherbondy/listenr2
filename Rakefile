# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'motion-testflight'
require 'motion-cocoapods'
require 'bubble-wrap/core'
require 'bubble-wrap/ui'
require 'geomotion'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Listenr'
  app.version = '0.0.1'
  app.identifier = 'com.unidextrous.listenr'
  app.codesign_certificate = ENV['CODESIGN_CERT']
  app.seed_id = 'TN8DQYA993'

  app.frameworks += ['Security', 'AVFoundation']

  app.entitlements['keychain-access-groups'] = [
    app.seed_id + '.' + app.identifier
  ]
  
  app.pods do
    pod 'TMTumblrSDK'
    pod 'KeychainItemWrapper'
  end
  
  # explicitly declare dependencies k depends on v
  app.files_dependencies({})

  app.release do
    app.provisioning_profile = './distribution.mobileprovision'
  end

  app.development do
    app.provisioning_profile = './development.mobileprovision'
  end
  
  app.info_plist['CFBundleURLTypes'] = [
    { 'CFBundleURLName' => 'com.unidextrous.listenr',
      'CFBundleURLSchemes' => ['listenr'] }
  ]

  app.testflight do
    app.testflight.sdk = 'vendor/TestFlightSDK2'
    app.testflight.api_token = ENV['TF_API_TOKEN']
    app.testflight.team_token = ENV['TF_TEAM_TOKEN']
    app.testflight.app_token = ENV['TF_APP_TOKEN']
    app.testflight.distribution_lists = ['listenr_alpha']
    app.testflight.notify = true
    app.testflight.identify_testers = true
  end
end
