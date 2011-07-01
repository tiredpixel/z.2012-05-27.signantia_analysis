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
      String,
      :required => true
    
    def self.analyse(path, regex)
      data = ''
      
      open(path) { |f| data = f.read }
      
      md5 = Digest::MD5.hexdigest(data)
      
      @analysis = Analysis.first_or_create(
        :md5sum => md5,
        :regex => regex
        )
      
      Analysis.transaction do
        data.scan(eval(@analysis.regex)).each do |word|
          @fragment = @analysis.fragments.first_or_create(:text => word)
          @fragment.frequency += 1
          @fragment.save!
        end
      end
      
      @analysis
    end
  end
end
