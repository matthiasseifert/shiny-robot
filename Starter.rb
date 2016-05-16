require  'logger'

@@logger = Logger.new(STDOUT);
@@logger.level = Logger::DEBUG;

require_relative 'FileListUtils.rb';

class Starter
  #Keep the paths of all plugin files added relative to this file.
  PluginClasses = Array.new;

  #Keeps the instantiated objects of the found pluginClasses.
  PluginObjects = Array.new;

  #keeps track if the pluginObjects have already been created.
  @isPluginsObjectsCreated = false;
  #Adds a single file as a plugin. The file given as parameter
  # will be added to the PluginsAdded array and integrated using "require"
  def requirePluginFile(file)
    require_relative file;
  end
  private :requirePluginFile;

  #searches the given folder for all files matching *.rb and
  # registers them using registerPlugins(...)
  # Additionally the names of all files found are written to the console
  def includePlugins(folder)

    @@logger.info("Including plugins from folder " + folder);

    classesBefore = ObjectSpace.each_object(Class).to_a;

    FileListUtils.getFileList(folder,"*.rb").each do
      |file|

      @@logger.info("found " + file.split(File::SEPARATOR).last);
      require_relative file;

    end

    newClasses = ObjectSpace.each_object(Class).to_a - classesBefore;

    newClasses.each do
      |clazz|
      if clazz.method_defined?("calculateMetrics")
        PluginClasses.push(clazz);
        @@logger.info("Adding class " + clazz.to_s);
      else
        @@logger.debug("Ignoring class " + clazz.to_s);
      end

    end

    @@logger.info("Added " + PluginClasses.length.to_s + " plugin" + ((PluginClasses.length==1) ? "" : "s") + " in total");

  end
  private :includePlugins;

  #constructor
  def initialize()
    @@logger.info("creating starter");
    includePlugins("plugins/");
  end

  #create the plug in objects used for the calculation of the metrics
  def createPluginObjects
    PluginClasses.each do
      |pluginClass|
      PluginObjects.push(pluginClass.new());
    end
    @isPluginsObjectsCreated = true;
  end
  private :createPluginObjects

  def runAllMetricsForFile(path)
    if(!@isPluginsObjectsCreated)
      @@logger.info( "creating plugin objects");
      createPluginObjects()
    end
    PluginObjects.each() do
      |pluginObject|
      pluginObject.calculateMetrics(path);
    end
  end

  codeFiles = FileListUtils.getFileListRecursively("/home/seiferms/dev/testprojects/oos/","*.java");

  starter = Starter.new();
  puts "running for " + codeFiles.length.to_s + " files.";

  codeFiles.each do
    |path|
    @@logger.info("Calculating all metrics for " + path);
    starter.runAllMetricsForFile(path);
  end

end

