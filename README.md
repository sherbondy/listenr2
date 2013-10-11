Hi there, to run listenr, you will need [RubyMotion](http://www.rubymotion.com).
You will also need to make sure all of the required env files exist by running:
'''
source setup_env.sh
'''

(This file doesn't exist in the repo. See: setup_env_template.sh to get started.)

Do 'bundle install' to install the dependencies.

Now try:
'''
rake pod:install
rake
'''

To install on your device, make sure to have 'development.mobileprovision' and 'distribution.mobileprovision' files in the root of this directory.

Hooray!
