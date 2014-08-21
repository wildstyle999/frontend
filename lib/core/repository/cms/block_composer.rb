module Core::Repository
  module CMS
    # Recombines CMS blocks to emulate current public website repo.
    # TODO: replace with native support for displaying blocks outside of frontend core
    class BlockComposer
      class Block < OpenStruct
        def to_s
          content.to_s
        end
      end

      attr_reader :blocks, :id, :parser

      def initialize(blocks=[], id="content", parser=Kramdown::Document)
        @blocks = Array(blocks)
        @parser = parser
        @id = id
      end

      def find(id)
        Block.new(blocks.detect { |block| block['identifier'] == id })
      end

      def to_html
        parser.new(self.to_s).to_html
      end

      def to_s
        find(id).to_s
      end
    end
  end
end
