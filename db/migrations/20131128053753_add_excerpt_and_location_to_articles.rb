Sequel.migration do
  change do
    add_column :articles, :excerpt, String
    add_column :articles, :location, String
  end
end