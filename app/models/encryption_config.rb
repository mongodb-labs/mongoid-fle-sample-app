# This class contains encryption configuration.
#
# Encryption configuration is stored in the Mongoid configuration file.
# This class provides access to the configuration.
class EncryptionConfig
  class << self
    # Name of the client configuration for auto encryption.
    ENCRYPTED_CLIENT = :default

    # Name of the client to access the key vault.
    KEY_VAULT_CLIENT = :key_vault

    # @return [ Array<Hash> ] KMS providers configuration.
    def kms_providers
      Mongoid.clients.dig(ENCRYPTED_CLIENT, :options, :auto_encryption_options, :kms_providers)
    end

    # @return [ String ] Key vault namespace.
    def key_vault_namespace
      Mongoid.clients.dig(ENCRYPTED_CLIENT, :options, :auto_encryption_options, :key_vault_namespace)
    end

    # Returns a client encryption instance that can be used to encrypt and
    # decrypt fields manually.
    #
    # @return [ Mongo::ClientEncryption ] Client encryption instance.
    def client_encryption
      @client_encryption ||= Mongo::ClientEncryption.new(
        Mongoid.client(KEY_VAULT_CLIENT),
        key_vault_namespace: key_vault_namespace,
        kms_providers: kms_providers
      )
    end
  end
end
