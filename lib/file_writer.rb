require 'fileutils'

module QiitaMatome
  #  QiitaMatome FileWriter
  class FileWriter
    attr_reader :output_file, :contents

    def initialize(output_file, contents)
      @output_file = output_file
      @contents = contents
    end

    def write
      dir = File.dirname(@output_file)
      FileUtils.mkdir_p(dir) unless Dir.exist?(dir)
      File.open(@output_file, 'w:UTF-8') { |f|f.print @contents }
    end
  end
end
