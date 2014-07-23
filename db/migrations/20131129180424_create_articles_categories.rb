Sequel.migration do
  change do
    create_table(:articles_categories) do
      Integer :article_id
      Integer :category_id
    end
  end
end
