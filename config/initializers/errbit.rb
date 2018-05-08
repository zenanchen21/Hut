Airbrake.configure do |config|
  config.api_key = '36150670fe19d647bd42f91a6acac1b7'
  config.host    = 'errbit.hut.shefcompsci.org.uk'
  config.port    = 443
  config.secure  = config.port == 443
end
