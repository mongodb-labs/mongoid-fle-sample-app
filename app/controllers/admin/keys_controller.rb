module Admin
  class KeysController < ApplicationController
    def index
      @keys = User.all.map { |user| UserDataKey.create(user) }.compact
    end

    def destroy
      key_id = BSON::Binary.from_uuid(params[:id])
      User.client_encryption.delete_key(key_id)
      redirect_to admin_keys_path
    end
  end
end
