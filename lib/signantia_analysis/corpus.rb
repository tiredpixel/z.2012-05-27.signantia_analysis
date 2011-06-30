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
    
    def analyse(regex)
      Dir[path.to_s + "*"].each do |f|
        @analysis = Analysis.analyse(f, regex)
        
        self.analyses << @analysis
        
        self.save
      end
    end
  end
end
