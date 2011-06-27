Factory.define :corpus, :class => SignantiaAnalysis::Corpus do |c|
  c.path "#{File.dirname(__FILE__)}/fixtures/corpus/"
end

Factory.define :corpus_with_callbacks, :class => SignantiaAnalysis::Corpus do |c|
  c.path "#{File.dirname(__FILE__)}/fixtures/corpus/"
  
  c.after_create { |corpus| corpus.register_files }
end

Factory.define :file, :class => SignantiaAnalysis::File do |f|
  f.path "#{File.dirname(__FILE__)}/fixtures/corpus/1"
  f.association(:corpus)
end

Factory.define :analysis, :class => SignantiaAnalysis::Analysis do |a|
  a.regex "[\S]+"
end

Factory.define :fragment, :class => SignantiaAnalysis::Fragment do |f|
  f.text "word"
  f.association(:corpus)
  f.association(:analysis)
end
