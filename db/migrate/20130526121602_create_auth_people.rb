class CreateAuthPeople < ActiveRecord::Migration
  def change
    create_table :auth_people do |t|
      t.string :email, :uniq => true, :not_null => true
      t.string :pass
      t.string :salt, :limit => 8
      t.integer :login_count, :default => 0
      t.integer :fail_count, :default => 0
      t.string :last_login_ip

      t.timestamps
    end
  end
end
