# encoding: utf-8
require 'spec_helper'
require 'file_writer'
require 'fileutils'

# rubocop:disable LineLength
describe QiitaMatome::FileWriter do
  context :new do
    cases = [
      {
        case_no: 1,
        case_title: 'valid output path',
        contents: "hoge\nhige",
        output_file: './tmp/output.md',
        expected: './tmp/output.md'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          file_writer = QiitaMatome::FileWriter.new(c[:output_file], c[:contents])

          # -- when --
          actual = file_writer.output_file

          # -- then --
          expect(actual).to eq(c[:expected])
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

  context :write do
    WRITE_TMP = 'write_tmp'
    cases = [
      {
        case_no: 1,
        case_title: 'valid output path',
        contents: "hoge\nhige",
        output_file: './tmp/output.md',
        expected: "hoge\nhige"
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          file_writer = QiitaMatome::FileWriter.new(c[:output_file], c[:contents])

          # -- when --
          file_writer.write
          actual = File.read(c[:output_file])

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
        Dir.mkdir(WRITE_TMP) unless Dir.exist? WRITE_TMP
        Dir.chdir(WRITE_TMP)
      end

      def case_after(c)
        # implement each case after
        Dir.chdir('../')
        FileUtils.rm_rf(WRITE_TMP) if Dir.exist? WRITE_TMP
      end
    end
  end
end
# rubocop:enable LineLength
