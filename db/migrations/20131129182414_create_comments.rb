Sequel.migration do
  change do
    create_table(:comments) do
      primary_key :id
      Integer :article_id
      String :name
      String :email
      String :body, text: true

      DateTime :created_at
      DateTime :updated_at
    end
  end
end