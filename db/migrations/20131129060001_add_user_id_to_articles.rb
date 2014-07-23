Sequel.migration do
  change do
    add_column :articles, :user_id, Integer
  end
end
