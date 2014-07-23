Sequel.migration do
  change do
    create_table(:profiles) do
      primary_key :id
      Integer :user_id
      String :name
      Date :birthday
      String :bio, text: true
      String :color
      String :twitter

      DateTime :created_at
      DateTime :updated_at
    end
  end
end
