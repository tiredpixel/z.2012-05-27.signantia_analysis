module SignantiaAnalysis
  class Textfile
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
    property :md5sum,
      String,
      :length => 32,
      :default => lambda { |r, p|
        Digest::MD5.hexdigest(r.path.read) if r.path
        }
    belongs_to :corpus
    
    validates_uniqueness_of :path, :scope => :corpus_id
  end
end
