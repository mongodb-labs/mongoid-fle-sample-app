# This model represents a bank account with automatic encryption enabled.
class BankAccount
  include Mongoid::Document
  include Mongoid::Timestamps

  # We specify that the encryption key name is stored in the
  # encryption_key_name field. MongoDB will use this field to
  # determine which encryption key to use for encryption and
  # decryption. Keys are stored in the key vault collection.
  encrypt_with key_name_field: :encryption_key_name

  # Encrypted fields.
  field :account_number, type: String, encrypt: { deterministic: false }
  field :bank_name, type: String, encrypt: { deterministic: false }

  # Unencrypted fields.
  field :name, type: String
  field :account_type, type: String
  field :encryption_key_name, type: String

  validates_presence_of :name, :account_number, :account_type, :bank_name

  belongs_to :user
  has_many :transactions

  # We must set the encryption key name before persisting the record.
  before_create :set_encryption_key

  private

  # We set the encryption key name to the user's encryption key name because
  # all user's data to be encrypted with the same key.
  def set_encryption_key
    self.encryption_key_name = user.encryption_key_name
  end
end
