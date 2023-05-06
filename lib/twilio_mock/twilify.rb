module Twilify
  module_function

  # extracted from the deprecated Twilio::REST::Utils
  def process(something)
    if something.is_a? Hash
      something = something.to_a
      something = something.map { |pair| [process(pair[0]).to_sym, pair[1]] }
      something = something.flatten(1)
      Hash[*something]
    else
      something.to_s.split("_").map! do |s|
        [s[0, 1].capitalize, s[1..-1]].join
      end.join
    end
  end
end
