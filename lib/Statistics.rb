require './AbstractSorter.rb'
require './SelectionSort.rb'
require './InsertionSort.rb'
require './MergeSort.rb'
require './QuickSort.rb'

:SELECT
:INSERT
:MERGE
:QUICK
:ASC
:DSC
:EQL
:RND
:CMP
:ACC
:TIME

class Statistics
  
  def initialize()
    #, 10000, 100000
    @values_for_n = Array[10, 100, 1000, 10000, 100000]
    @data_configurations = Array[:ASC, :DSC, :EQL, :RND]
    @algorithms = Array[:SELECT, :INSERT, :MERGE, :QUICK]
    @tableEntries = Array.new()
  end
  
  attr_accessor :tableEntries 
  
  def testAlgorithms()
    @algorithms.each do |algorithm|
      @data_configurations.each do |configuration|
        @values_for_n.each do |n|
          testAlgorithm = TestAlgorithm.new(algorithm, configuration, n)
          @tableEntries << testAlgorithm.runTests()
        end
      end
    end
  end
end

class TestAlgorithm
  
  def initialize(algorithm, data_configuration, n)
    
    @algorithm
    @algorithm_symbol = algorithm
    @data_configuration
    @data_configuration_symbol = data_configuration
    @n = n
  
    @cmp = 0
    @acc = 0
    @time = 0
    
    case algorithm
    when :SELECT
      @algorithm = SelectionSort.new()
    when :INSERT
      @algorithm = InsertionSort.new()
    when :MERGE
      @algorithm = MergeSort.new()
    when :QUICK
      @algorithm = QuickSort.new()
    end
    
    case data_configuration
    when :ASC
      @algorithm.fillAscending(n)
    when :DSC
      @algorithm.fillDescending(n)
    when :EQL
      @algorithm.fillAllEqual(n)
    when :RND
      @algorithm.fillAllEqual(n)
      @algorithm.permuteRandom(2 * n)
    end
  end
  
  def runTests()
    @algorithm.checkOff
    
    time do
      @algorithm.sort
    end
    
    @cmp = @algorithm.compareCount
    @acc = @algorithm.accessCount
    
    tableEntry = TableEntry.new(@n, @algorithm_symbol, @data_configuration_symbol, @cmp, @acc, @time)
    return tableEntry
  end
  
  def time()
    start = Time.now
    yield
    @time = Time.now - start
  end
end

class TableEntry
  
  attr_accessor :datasize, :algorithm, :dataConfiguration, :cmp, :acc, :time
  
  def initialize(datasize, algorithm, dataConfiguration, cmp, acc, time)
    @datasize = datasize
    @algorithm = algorithm
    @dataConfiguration = dataConfiguration
    @cmp = cmp
    @acc = acc
    @time = time
  end
  
  def to_s()
    s = "Algorithmus: " + @algorithm.to_s + " Konfiguration: " + @dataConfiguration.to_s + " Anzahl-n: " + @datasize.to_s + " compare-count: " +  @cmp.to_s + " Access-Count: " + @acc.to_s + " Time: " + @time.to_s
  end
end

s = Statistics.new()
s.testAlgorithms()
puts s.tableEntries
#puts "BLA"