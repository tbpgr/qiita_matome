# encoding: utf-8
require 'spec_helper'
require 'qiita_matome_core'

# rubocop:disable LineLength, UnusedMethodArgument, UselessAssignment
describe QiitaMatome::Core do
  context :execute do
    cases = [
      {
        case_no: 1,
        case_title: 'case_title',
        expected: 'expected'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_core = QiitaMatome::Core.new

          # -- when --
          # TODO: implement execute code
          # actual = qiita_matome_core.execute

          # -- then --
          # TODO: implement assertion code
          # expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
# rubocop:enable LineLength, UnusedMethodArgument, UselessAssignment
