module Admin
  # This class represent a user's data key for the purpose of displaying it in
  # the Admin UI.
  class UserDataKey

    # @return [ BSON::Binary ] data key id.
    attr_reader :key_id

    # @return [ Array<String> ] data key alternate names.
    attr_reader :key_alt_names

    # @return [ String ] user's email.
    attr_reader :user_email

    def initialize(user, data_key)
      @user = user
      @data_key = data_key
      @user_email = @user.email
      @key_id = @data_key[:_id]
      @key_alt_names = @data_key.fetch(:keyAltNames) { [] }
    end

    def to_param
      @key_id.to_uuid
    end

    # Create an instance of UserDataKey from a user.
    #
    # This method tries to fetch the data key from the key vault collection.
    #
    # @param [ User ] user the user.
    #
    # @return [ UserDataKey | nil ] the user's data key or nil if the data key
    #  is not found.
    def self.create(user)
      data_key = EncryptionConfig.client_encryption.get_key_by_alt_name(user.encryption_key_name)
      return nil unless data_key

      UserDataKey.new(user, data_key)
    end
  end
end
