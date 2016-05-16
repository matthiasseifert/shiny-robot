#Counts all lines of real code in a file. These are all lines 
# in a given file which do not consist of a comment (neither block
# nor single line comment) and are not whitespace only.

require_relative 'loc.rb'

class Sloc < Loc
  def calculateValue(file)

    value = 0;

    file.each_line do
      |rawline|
      #remove leading and trailing whitespace.
      line = rawline.strip();

      unless(
      #line comment
      line.start_with?("//") ||
      #block comment start
      line.start_with?("/*") ||
      #block comment end
      line.start_with?("*/") ||
      #block comment content
      line.start_with?("*")  ||
      #empty line
      line.match("^$"))
        value+=1;

      end

    end

    return value;

  end

end