class Article < Sequel::Model
  plugin :validation_helpers

  many_to_one :user

  def validate
    super 
    validates_presence [:title, :body]
  end
  
  def long_title
    "#{title} - #{published_at}"
  end
  
  def owned_by?(owner)
    user == owner
  end
end