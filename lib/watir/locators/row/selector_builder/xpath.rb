module Watir
  module Locators
    class Row
      class SelectorBuilder
        class XPath < Element::SelectorBuilder::XPath
          attr_accessor :scope_tag_name

          def add_attributes(selector)
            attr_expr = attribute_expression(nil, selector)

            expressions = generate_expressions
            expressions.map! { |e| "#{e}[#{attr_expr}]" } unless attr_expr.empty?
            expressions.join(' | ')
          end

          def add_tag_name(selector)
            selector.delete(:tag_name)
            ''
          end

          def default_start
            ''
          end

          private

          def generate_expressions
            expressions = %w[./tr]
            return expressions if scope_tag_name.nil? || %w[tbody tfoot thead].include?(scope_tag_name)

            expressions + %w[./tbody/tr ./thead/tr ./tfoot/tr]
          end
        end
      end
    end
  end
end
