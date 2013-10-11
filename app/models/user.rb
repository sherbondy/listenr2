class User
  attr_accessor :oauth_token, :oauth_secret

  def initialize
    @keychain = KeychainItemWrapper.alloc.initWithIdentifier('ListenrOAuthData', accessGroup: nil)
    load
  end
  
  def store_creds(token, secret)
    self.oauth_token = token
    self.oauth_secret = secret
    save
  end

  def save
    @keychain.setObject oauth_token, forKey: KSecAttrAccount
    @keychain.setObject oauth_secret, forKey: KSecValueData
  end

  def load
    self.oauth_token = @keychain.objectForKey KSecAttrAccount
    self.oauth_secret = @keychain.objectForKey KSecValueData
  end
  
  def logged_in?
    !(self.oauth_token.empty? or self.oauth_secret.empty?)
  end

  def reset
    self.oauth_token = ''
    self.oauth_secret = ''
    @keychain.resetKeychainItem
  end
end