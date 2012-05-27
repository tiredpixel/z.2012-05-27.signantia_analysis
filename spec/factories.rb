FactoryGirl.define do
  factory :corpus, :class => SignantiaAnalysis::Corpus do
    path "#{File.dirname(__FILE__)}/fixtures/corpus/"
  end
  
  factory :analysis, :class => SignantiaAnalysis::Analysis do
    md5sum "acaceb50eb543d1047c64987c914e547"
    regex "/[\\S]+/"
  end
  
  factory :fragment, :class => SignantiaAnalysis::Fragment do
    association(:analysis)
    text "word"
  end
end

