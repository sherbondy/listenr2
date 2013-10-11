# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'
require 'rubygems'
require 'motion-testflight'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Listenr'
  app.identifier = 'com.unidextrous.listenr'
  app.codesign_certificate = ENV['CODESIGN_CERT']

  app.release do
    app.provisioning_profile = './distribution.mobileprovision'
  end

  app.development do
    app.provisioning_profile = './development.mobileprovision'
  end

  app.testflight do
    app.testflight.sdk = 'vendor/TestFlightSDK2'
    app.testflight.api_token = ENV['TF_API_TOKEN']
    app.testflight.team_token = ENV['TF_TEAM_TOKEN']
    app.testflight.app_token = ENV['TF_APP_TOKEN']
    app.testflight.notify = true
    app.testflight.identify_testers = true
  end
end
