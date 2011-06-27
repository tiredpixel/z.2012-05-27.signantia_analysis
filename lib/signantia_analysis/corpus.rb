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
    has n, :analyses
    
    after :save, :register_files
    
    def register_files
      Dir[path + "*"].each do |f|
        files.create(
          :path => f
          )
      end
    end
  end
end
