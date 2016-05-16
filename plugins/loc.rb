#Simply counts all lines in a file no matter if the lines consist 
# of code, comments or whitespace
class Loc
  def calculateMetrics(path)
    file = File.new(path, "r");
    value = calculateValue(file);
    file.close();
    @@logger.debug(self.class.to_s + ": calculated value is " + value.to_s);
    return value;
  end
  
  def calculateValue(file)
    return file.readlines.size;
  end
  private :calculateValue
  
end
