Factory.define :file, :class => SignantiaAnalysis::File do |f|
  f.path "#{File.dirname(__FILE__)}/fixtures/corpus/1"
end
