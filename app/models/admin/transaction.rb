module Admin
  # This class represents a transaction without automatic encryption.
  # We fetch encrypted fields from the database and try to decrypt them
  # using the explicit client encryption API.
  #
  # If there is no encryption key available, we fall back to the unencrypted
  # data.
  class Transaction
    include Mongoid::Document
    include Mongoid::Timestamps

    # We use the unencrypted client to skip automatic encryption
    # for this model.
    store_in client: :unencrypted, collection: :transactions

    # Encrypted fields are stored as BSON::Binary.
    field :amount, type: BSON::Binary
    # Encrypted fields are stored as BSON::Binary.
    field :description, type: BSON::Binary
    field :completed_at, type: Time
    field :encryption_key_name, type: String

    belongs_to :bank_account, class_name: 'Admin::BankAccount'

    # Decrypt the amount using the explicit client encryption API.
    # If there is no encryption key available, we fall back to the unencrypted
    # data.
    #
    # @return [ Integer | BSON::Binary ] the decrypted amount as an integer
    #  or the unencrypted account number as a BSON::Binary.
    def amount
      EncryptionConfig.client_encryption.decrypt(self[:amount])
    rescue Mongo::Error::CryptError
      self[:amount]
    end

    # Decrypt the description using the explicit client encryption API.
    # If there is no encryption key available, we fall back to the unencrypted
    # data.
    #
    # @return [ String | BSON::Binary ] the decrypted description as a string
    #  or the unencrypted account number as a BSON::Binary.
    def description
      EncryptionConfig.client_encryption.decrypt(self[:description])
    rescue Mongo::Error::CryptError
      self[:description]
    end

    # Convert the amount to a displayable string.
    #
    # We store the amount in cents as an integer. This method converts the
    # amount to a string with a decimal point.
    #
    # @return [ String ] the amount as a string.
    def displayable_amount
      return 0 unless amount
      return amount if amount.is_a?(BSON::Binary)
      "#{amount / 100}.#{amount % 100}"
    end
  end
end
