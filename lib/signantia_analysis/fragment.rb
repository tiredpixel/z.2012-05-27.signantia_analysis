module SignantiaAnalysis
  class Fragment
    include DataMapper::Resource
    
    property :id,
      Serial
    property :created_at,
      DateTime
    property :updated_at,
      DateTime
    
    belongs_to :analysis
    
    property :text,
      String,
      :required => true
    property :frequency,
      Integer,
      :default => 0
  end
end
