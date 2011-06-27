Factory.define :corpus, :class => SignantiaAnalysis::Corpus do |c|
  c.path "#{File.dirname(__FILE__)}/fixtures/corpus/"
end

Factory.define :corpus_with_callbacks, :class => SignantiaAnalysis::Corpus do |c|
  c.path "#{File.dirname(__FILE__)}/fixtures/corpus/"
  
  c.after_create { |corpus| corpus.register_textfiles }
end

Factory.define :textfile, :class => SignantiaAnalysis::Textfile do |f|
  f.association(:corpus)
  f.path "#{File.dirname(__FILE__)}/fixtures/corpus/1"
end

Factory.define :analysis, :class => SignantiaAnalysis::Analysis do |a|
  a.association(:corpus)
  a.regex "[\S]+"
end

Factory.define :fragment, :class => SignantiaAnalysis::Fragment do |f|
  f.association(:analysis)
  f.text "word"
end
