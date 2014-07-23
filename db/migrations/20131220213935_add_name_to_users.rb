Sequel.migration do
  change do
    add_column :users, :name, String
  end
end
