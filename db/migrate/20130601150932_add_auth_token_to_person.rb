class AddAuthTokenToPerson < ActiveRecord::Migration
  def change
    add_column :auth_people, :auth_token, :string
  end
end
