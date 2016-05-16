#Counts all lines in a file which contain nothing but a comment. 
# This includes all 

require_relative 'loc.rb'

class Cloc < Loc
  def calculateValue(file)
    value = 0;
    file.each_line do
      |rawline|
      #remove leading and trailing whitespace
      line = rawline.strip;
      
      if(line.start_with?("//") ||
        line.start_with?("/*") ||
        line.start_with?("*") ||
        line.start_with?("*/")
        )
        value += 1;
      end
      
    end
    return value;
  end
  
end