Factory.define :corpus, :class => SignantiaAnalysis::Corpus do |c|
  c.path "#{File.dirname(__FILE__)}/fixtures/corpus/"
end

Factory.define :analysis, :class => SignantiaAnalysis::Analysis do |a|
  a.md5sum "acaceb50eb543d1047c64987c914e547"
  a.regex "/[\\S]+/"
end

Factory.define :fragment, :class => SignantiaAnalysis::Fragment do |f|
  f.association(:analysis)
  f.text "word"
end
