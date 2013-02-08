CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAIS7NMF5PS3DYZRJQ',                        # required
    :aws_secret_access_key  => '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',                        # required
    :region                 => 'us-east-1',                  # optional, defaults to 'us-east-1'
    :host                   => 's3.amazonaws.com',             # optional, defaults to nil
    :endpoint               => 'https://s3.amazonaws.com' # optional, defaults to nil
  }
  config.fog_directory  = 'snippet-monkey'                     # required
  config.fog_public     = true                                  # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end