require 'FileListUtils.rb'

class Starter
  #Keep the paths of all plugin files added relative to this file.
  PluginsAdded = Array.new;
  
  #Adds a single file as a plugin. The file given as parameter 
  # will be added to the PluginsAdded array and integrated using "require" 
  def registerPluginFile(file)
    PluginsAdded.push(file);
    require file;
  end
  private :registerPluginFile;
  
  #searches the given folder for all files matching *.rb and
  # registers them using registerPlugins(...)
  # Additionally the names of all files found are written to the console
  def includePlugins(folder)
    totalNumberOfPlugins=0;
    puts "Including plugins from the " + folder + " folder";
    
    FileListUtils.getFileList(folder,"*.rb").each do
      |file|
      puts "found " + file.split("/").last;
      registerPluginFile(file);
      
      totalNumberOfPlugins += 1;
    end
    
    puts "Added " + totalNumberOfPlugins.to_s + " plugin" + ((totalNumberOfPlugins==1) ? "" : "s") + " in total";
  end
  private :includePlugins;
  
   
  def initialize()
    puts "creating starter";
    includePlugins("plugins/");
  end
  
  Starter.new();

end

