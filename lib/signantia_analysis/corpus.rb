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
    has n, :textfiles
    has n, :analyses
    
    after :save, :register_textfiles
    
    def register_textfiles
      Dir[path + "*"].each do |f|
        textfiles.create(
          :path => f
          )
      end
    end
  end
end
