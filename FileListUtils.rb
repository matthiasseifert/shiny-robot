class FileListUtils
  #Returns an array containing the paths for all files
  # matching the given pattern in the given directory
  # and all subdirectories. The path returned is relative
  # to the parentDirectory of the parentDirectory-parameter
  def self.getFileListRecursively(parentDirectory, pattern)
    return Dir.glob(appendDelimiterIfNecessary(parentDirectory)+"**/"+pattern);
  end

  #Returns an array containing the paths for all files
  # matching the given pattern only in the given directory.
  # The path returned is relative to the parentDirectory
  # of the parentDirectory-parameter
  def self.getFileList(parentDirectory, pattern)
    return Dir.glob(appendDelimiterIfNecessary(parentDirectory)+pattern);
  end

  #Returns an array containing the paths for all directories
  # matching the given pattern only in the given directory.
  # The path returned is relative to the parentDirectory
  # of the parentDirectory-parameter
  def self.getDirectoryList(parentDirectory)
    return getFileList(parentDirectory,"");
  end

  #Returns an array containing the paths for all directories
  # matching the given pattern in the given directory and 
  # all subdirectories. The path returned is relative 
  # to the parentDirectory of the parentDirectory-parameter
  def self.getDirectoryListRecursively(parentDirectory)
    return getFileListRecursively(parentDirectory,"");
  end

  private
  
  #If the last character of the path given as a parameter is not
  # the system's file delimiter this method will return
  # the path given with the system's delimiter appended.
  # Otherwise the method will return the path given unchanged.
  def self.appendDelimiterIfNecessary(path)
    systemDelimiter = File::SEPARATOR;
    if(path[-1,1] != systemDelimiter)
      return path + systemDelimiter;
    end
    return path;

  end
end

