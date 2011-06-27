module SignantiaAnalysis
  class Fragment
    include DataMapper::Resource
    
    property :id,
      Serial
    property :created_at,
      DateTime
    property :updated_at,
      DateTime
    
    property :text,
      String,
      :required => true
    belongs_to :corpus
    belongs_to :analysis
  end
end
