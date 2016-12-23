Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id
      column :user_name,       String,   null: false
      column :hashed_password, String,   null: false
      column :first_name,      String,   null: false
      column :last_name,       String,   null: false
    end
  end
end
