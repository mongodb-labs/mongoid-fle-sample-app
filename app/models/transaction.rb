# This model represents a transaction with automatic encryption enabled.
class Transaction
  include Mongoid::Document
  include Mongoid::Timestamps

  # We specify that the encryption key name is stored in the
  # encryption_key_name field. MongoDB will use this field to
  # determine which encryption key to use for encryption and
  # decryption. Keys are stored in the key vault collection.
  encrypt_with key_name_field: :encryption_key_name

  # Encrypted fields.
  field :amount, type: Integer, encrypt: { deterministic: false }
  field :description, type: String, encrypt: { deterministic: false }

  # Unencrypted fields.
  field :completed_at, type: Time
  field :encryption_key_name, type: String

  validates_presence_of :amount, :description, :completed_at
  after_initialize :set_defaults

  # We must set the encryption key name before persisting the record.
  before_create :set_encryption_key

  belongs_to :bank_account

  # Convert the amount to a displayable string.
  #
  # We store the amount in cents as an integer. This method converts the
  # amount to a string with a decimal point.
  #
  # @return [ String ] the amount as a string.
  def displayable_amount
    "#{amount / 100}.#{amount % 100}"
  end

  private

  def set_defaults
    self[:completed_at] = Time.zone.now if completed_at.nil?
  end

  # We set the encryption key name to the bank account's encryption key name because
  # all bank account's data to be encrypted with the same key.
  def set_encryption_key
    self.encryption_key_name = bank_account.encryption_key_name
  end
end
