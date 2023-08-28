# Uset model with automatic encryption enabled.
class User
  include Mongoid::Document
  include Mongoid::Timestamps

  # User model is encrypted with a key that is stored in the key vault collection.
  # The key must be created before the user is created.
  encrypt_with key_id: ENV['USER_KEY_ID']

  # Encrypted fields. All fields are encrypted with the same key.
  field :first_name, type: String, encrypt: { deterministic: false }
  field :last_name, type: String, encrypt: { deterministic: false }

  # This field stores name of the encryption key that is used to encrypt
  # the user's data.
  field :encryption_key_name, type: String

  validates_presence_of :email, :first_name, :last_name
  index({ email: 1 }, { unique: true })
  has_many :bank_accounts, dependent: :destroy

  # We must generate a data key for each user to encrypt the user's data.
  before_create :generate_data_key
  # We must delete the data key when the user is deleted.
  after_destroy :delete_data_key

   # Devise related fields - BEGIN
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  field :email, type: String, encrypt: { deterministic: true }
  field :encrypted_password, type: String, default: ""
  field :reset_password_token, type: String
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time
  # Devise related fields - END

  private

  def generate_data_key
    generate_encryption_key_name    
    EncryptionConfig.client_encryption.create_data_key(EncryptionConfig.kms_providers.keys.first, key_alt_names: [encryption_key_name])
  end

  # Generate encryption key name.
  #
  # We use the user's email to generate encryption key name since the email is unique.
  #
  # @return [ String ] the encryption key name.
  def generate_encryption_key_name
    self.encryption_key_name = Digest::SHA256.hexdigest(email)
  end

  def delete_data_key
    data_key = EncryptionConfig.client_encryption.get_key_by_alt_name(encryption_key_name)
    return unless data_key

    EncryptionConfig.client_encryption.delete_key(data_key[:_id])
  end

end
