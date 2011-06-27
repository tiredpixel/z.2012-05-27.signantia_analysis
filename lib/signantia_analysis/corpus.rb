module SignantiaAnalysis
  class Corpus
    include DataMapper::Resource
    
    property :id,
      Serial
    property :created_at,
      DateTime
    property :updated_at,
      DateTime
    
    property :path,
      FilePath,
      :required => true
    has n, :files
  end
end
