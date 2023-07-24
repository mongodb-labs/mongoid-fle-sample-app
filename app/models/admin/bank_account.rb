module Admin
  # This class represents a bank account without automatic encryption.
  # We fetch encrypted fields from the database and try to decrypt them
  # using the explicit client encryption API.
  #
  # If there is no encryption key available, we fall back to the unencrypted
  # data.
  class BankAccount
    include Mongoid::Document
    include Mongoid::Timestamps

    # We use the unencrypted client to skip automatic encryption
    # for this model.
    store_in client: :unencrypted, collection: :bank_accounts

    field :name, type: String
    # Encrypted fields are stored as BSON::Binary.
    field :account_number, type: BSON::Binary
    field :account_type, type: String
    # Encrypted fields are stored as BSON::Binary.
    field :bank_name, type: BSON::Binary
    field :encryption_key_name, type: String

    has_many :transactions, class_name: 'Admin::Transaction'

    # Decrypt the account number using the explicit client encryption API.
    # If there is no encryption key available, we fall back to the unencrypted
    # data.
    #
    # @return [ String | BSON::Binary ] the decrypted account number as a string
    #  or the unencrypted account number as a BSON::Binary.
    def account_number
      EncryptionConfig.client_encryption.decrypt(self[:account_number])
    rescue Mongo::Error::CryptError
      self[:account_number]
    end

    # Decrypt the bank name using the explicit client encryption API.
    # If there is no encryption key available, we fall back to the unencrypted
    # data.
    #
    # @return [ String | BSON::Binary ] the decrypted bank name as a string
    #  or the unencrypted account number as a BSON::Binary.
    def bank_name
      EncryptionConfig.client_encryption.decrypt(self[:bank_name])
    rescue Mongo::Error::CryptError
      self[:bank_name]
    end
  end
end
