module SignantiaAnalysis
  class Analysis
    include DataMapper::Resource
    
    property :id,
      Serial
    property :created_at,
      DateTime
    property :updated_at,
      DateTime
    
    property :regex,
      Regexp,
      :required => true
    belongs_to :corpus
    has n, :fragments
  end
end
