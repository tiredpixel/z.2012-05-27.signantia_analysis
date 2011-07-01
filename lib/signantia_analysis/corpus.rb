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
      Dir[path.to_s + "*"].sort.each_with_index do |f, i|
        puts "  * #{i}  #{f}"
        start = Time.now
        
        @analysis = Analysis.analyse(f, regex)
        
        self.analyses << @analysis
        
        self.save
        
        puts "    time:        #{Time.now - start}"
      end
    end
  end
end
