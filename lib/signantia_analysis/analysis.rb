module SignantiaAnalysis
  class Analysis
    include DataMapper::Resource
    
    property :id,
      Serial
    property :created_at,
      DateTime
    property :updated_at,
      DateTime
    
    has n, :corpuss, :through => Resource
    has n, :fragments
    
    property :md5sum,
      String,
      :length => 32,
      :required => true
    property :regex,
      Regexp,
      :required => true
    property :status,
      Boolean,
      :default => false
  end
end
