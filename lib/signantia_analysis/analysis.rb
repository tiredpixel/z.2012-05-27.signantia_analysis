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
      
      @analysis = Analysis.first(
        :md5sum => md5,
        :regex => regex
        )
      
      if !@analysis
        @analysis = Analysis.create(
          :md5sum => md5,
          :regex => regex
          )
        
        start = Time.now
        
        hash = Hash.new(0)
        
        data.scan(eval(@analysis.regex)).each do |word|
          hash[word] += 1
        end
        
        puts "    hash time:   #{Time.now - start}"
        puts "    hash size:   #{hash.count}"
        
        start = Time.now
        
        Analysis.transaction do
          hash.each do |word, frequency|
            @fragment = @analysis.fragments.first_or_create(:text => word)
            @fragment.frequency += frequency
            @fragment.save!
          end
        end
        
        db_time = Time.now - start
        puts "    db time:     #{db_time}"
        puts "    hash keys/s: #{hash.count / db_time}"
      else
        puts "    cached"
      end
      
      @analysis
    end
  end
end
