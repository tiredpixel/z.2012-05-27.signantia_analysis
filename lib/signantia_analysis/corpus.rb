module SignantiaAnalysis
  class Corpus
    include DataMapper::Resource
    
    property :id,
      Serial
    property :created_at,
      DateTime
    property :updated_at,
      DateTime
    
    has n, :analyses, :through => Resource
    
    property :path,
      FilePath,
      :required => true
  end
end
