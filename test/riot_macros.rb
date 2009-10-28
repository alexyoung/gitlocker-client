module Custom
  module Macros
    def asserts_response(title, expected, &block)
      asserts("#{title} was not #{expected}") do
        yield.status
      end.equals(expected)
    end

    def asserts_response_ok(title, &block)
      asserts_response title, 200, &block
    end
  end
end

Riot::Context.instance_eval { include Custom::Macros }
