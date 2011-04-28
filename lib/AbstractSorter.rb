# To change this template, choose Tools | Templates
# and open the template in the editor.

require './ExtV1.rb'

class AbstractSorter
  
  def initialize
    @check = false
    @data = nil
    @unsortedData = nil
    @accessCount = 0
    @compareCount = 0
    @SortBlock = nil
    @isStableSorted = nil # Unbekannt solange @check nicht 
  end

  # Setter methods
  # Debug on
  def checkOn
    @check = true
  end

  # Debug off
  def checkOff
    @check = false
  end

  # data setter, provided data must be a collection!
  def data=(data)
    @data = data
  end

  def sortBlock(aTwoArgBlock)
    #@SortBlock = Proc.new(aTwoArgBlock) # Convert the block into a procedure.
    @SortBlock = aTwoArgBlock
  end

  # end of Setter methods

  # getter methods

  def data
    @data
  end

  def accessCount
    @accessCount
  end

  def compareCount
    @compareCount
  end

  def isStableSorted
    @isStableSorted
  end

  # end of getter methods

  def sort(seq = @data, sortBlock = nil)

    @accessCount = 0
    @compareCount = 0

    if (seq)
      @data = seq
    end

    if (sortBlock)
      self.sortBlock(sortBlock)
    end

    if (@check)
      # Unsortierte Daten vor der Sortierung für die Permutationsüberprüfung sichern.
      @unsortedData = Array.new(@data)
      @isStableSorted = true
      checkPreConditions()
    end

    performSort()

    if (@check)
      checkPostConditions()
    end

    #puts "--- Sortierung abgeschlossen ---"
    #puts "Sortierte Daten:"
    #puts self.data
    #puts "------------"
    #puts "Access Count"
    #puts self.accessCount
    #puts "Compare Count"
    #puts self.compareCount
    #puts "------------"
    
  end

  def fillAscending(aCount)
    index = 0
    number = 0

    @data = Array.new()
    aCount.times do
      @data[index] = number
      index += 1
      number += 1
    end
  end

  def fillDescending(aCount)
    index = aCount - 1
    number = aCount - 1

    @data = Array.new()
    aCount.times do
      @data[index] = number
      index -= 1
      number -= 1
    end
  end

  def fillAllEqual(aCount)
    index = 0
    @data = Array.new()
    aCount.times do
      @data[index] = 42
      index += 1
    end
  end

  def fillWithText(aTextFile)
    @data = Array.new()
    File.open(aTextFile, 'r') do |f1|
      index = 0
      while line = f1.gets
        @data[index] = line
        index += 1
      end
    end
  end

  def randomIndexBetween(firstIndex, lastIndex)
    check(true, int?(firstIndex), "Parameter is not a integer :(.")
    check(true, int?(lastIndex), "Parameter is not a integer :(.")
    return firstIndex + rand(lastIndex + 1)
  end

  def permuteRandom(aCount, seed = 0)
    r = Random.new(seed)
    aCount.times do
      index1 = randomIndexBetween(0, @data.size-1)
      index2 = randomIndexBetween(0, @data.size-1)
      #index1 = r.rand(@data.size)
      #index2 = r.rand(@data.size)
      temp = @data[index1]
      @data[index1] = @data[index2]
      @data[index2] = temp
    end
  end

  def performSort()
    abstract()
  end

  def sortBetween(startIndex, endIndex)
    abstract()
  end

  #start of protected methods
  protected

  #post conditions

  def checkPreConditions
    isDataValid()
    isSpaceshipImplementationValid()
    isEquivalenceImplementationValid()
  end

  def checkPostConditions
    check_post(true, isSorted(), 'Sort algorithm did not return a sorted collection :(.')
    check_post(true, isPermutation(), 'The sorted data is not a permutation of the unsorted data!')
    return true
  end

  def isDataValid()
    if (@check) then
      check_pre(seq?(data) == true,'Eingegebenes data-Objekt ist keine Collection!')
    end
    return true
  end

  def isSpaceshipImplementationValid()
#    @data.each_cons(2) {|a|
#
#
#        check_pre((a[0] <=> a[0]) == 0, 'Die Implementierung des Spaceship-Operators erfüllt nicht die Reflexivitäts Anforderungen!')
#        check_pre((a[1] <=> a[1]) == 0, 'Die Implementierung des Spaceship-Operators erfüllt nicht die Reflexivitäts Anforderungen!')
#        # Symmetrie überprüfen
#        check_pre((a[0] <=> a[1]) == ((a[1] <=> a[0]) * -1), 'Die Implementierung des Spaceship-Operators erfüllt nicht die Symmetrie Anforderungen!')
#
#    }
    
    @data.each {|a|
      # Reflexivität überprüfen
      check_pre((a <=> a) == 0, 'Die Implementierung des Spaceship-Operators erfüllt nicht die Reflexivitäts Anforderungen!')
      @data.each {|b|
        # Symmetrie überprüfen
        ergebnis1 = (a <=> b)
        check_pre(ergebnis1 == ((b <=> a) * -1), 'Die Implementierung des Spaceship-Operators erfüllt nicht die Symmetrie Anforderungen!')
        @data.each {|c|
          # Transitivität prüfen
          ergebnis2 = (b <=> c)
          if ((ergebnis1 == 1) and (ergebnis2 == 1)) then
            check_pre((a <=> c) == 1, 'Die Implementierung des Spaceship-Operators erfüllt nicht die Transitivitäts Anforderungen!')
          elsif ((ergebnis1 == -1) and (ergebnis2 == -1))
            check_pre((a <=> c) == -1, 'Die Implementierung des Spaceship-Operators erfüllt nicht die Transitivitäts Anforderungen!')
          elsif ((ergebnis1 == 0) and (ergebnis2 == 0))
            check_pre((a <=> c) == 0, 'Die Implementierung des Spaceship-Operators erfüllt nicht die Transitivitäts Anforderungen!')
          end
        }
      }
    }
  end

  def isEquivalenceImplementationValid()
    @data.each {|a|
      # Reflexivität überprüfen
      check_pre((a == a), 'Die Implementierung des Äquivalenz-Operators erfüllt nicht die Reflexivitäts Anforderungen!')
      @data.each {|b|
        # Symmetrie überprüfen
        ergebnis1 = (a == b)
        check_pre(ergebnis1 == ((b == a)), 'Die Implementierung des Äquivalenz-Operators erfüllt nicht die Symmetrie Anforderungen!')
        @data.each {|c|
          # Transitivität prüfen
          ergebnis2 = (b == c)
          if ((ergebnis1 == ergebnis2) == 0)
            check_pre((a == c), 'Die Implementierung des Äquivalenz-Operators erfüllt nicht die Transitivitäts Anforderungen!')
          end
        }
      }
    }
  end

  def isSortedBetween(firstIndex, lastIndex)

    monoton_steigend = nil

    tempArr = @data.slice(firstIndex..lastIndex)

    tempArr.each_cons(2) {|a|

      if (monoton_steigend.nil?)
        if (compare(a[1], a[0]) == 1)
          # Collection ist aufsteigend sortiert
          monoton_steigend = true
        elsif (compare(a[1], a[0]) == -1)
          # Collection ist absteigend sortiert
          monoton_steigend = false
        end
      end

      if (compare(a[1], a[0]) == 0)
        # Werte bleiben in diesem Iterationsschritt gleichbleibend. Ab in den nächsten Iterationsschritt.
        next
      end

      if ( compare(a[1], a[0]) == 1 && (monoton_steigend == true )) then
        next # Werte steigen.
      elsif ( compare(a[1], a[0]) == -1 && ( monoton_steigend == false )) then
        next # Werte fallen.
      else
        return false
      end
    }

    return true
  end

  def isSorted
    isSortedBetween(0, @data.size - 1)
  end

  def isPermutation

    # Create working copies of the needed data
    dataWorkingCopy = Array.new(@data)
    unsortedDataWorkingCopy = Array.new(@unsortedData)

    # The unsorted and sorted data must be the same size! No objects must have gone missing! Also no objects must have been added!
    if (dataWorkingCopy.size != unsortedDataWorkingCopy.size)
      return false
    end

    # Check, if the sorted Collection contains the same objects as the unsorted one.
    dataWorkingCopy.each {|obj1|
      equivalentDataFound = false
      # Look for obj1 in the unsorted data, and delete it if found.
      unsortedDataWorkingCopy.each_index{|index|
        if (obj1 == unsortedDataWorkingCopy[index])
          # The equivalent data has been found.
          unsortedDataWorkingCopy.delete_at(index)
          equivalentDataFound = true
          break
        end
      }
      if  (equivalentDataFound == false)
        # The equivalent data could not be found :(.
        return false
      end
    }

    return true
  end

  # end of preconditions

  # change index1 and index2 in the data Collection
  def exchange(index1, index2)

    if (@check)
      if (@data[index1] == @data[index2])
        @isStableSorted = false
      end
    end

    temp = self[index1]
    self[index1] = self[index2]
    self[index2] = temp
  end

  # utility methods
  # Compare anObj to anotherObj using the spaceship-operator.
  def compare(anObj, anotherObj)

    @compareCount += 1

    if (@SortBlock)
      return @SortBlock.call(anObj, anotherObj)
    end
    return anObj <=> anotherObj
  end

  def compareExchange(index1,index2)
    # If the objects at index1 and index2 in the array @data are different, change them.
    if (compare(@data[index1], @date[index2]) != 0)
      exchange(index1, index2)
    end
  end

  def less(anObj, anotherObj)
    if (compare(anObj, anotherObj) == -1)
      return true
    else
      return false
    end
  end

  def [](anIndex)
    @accessCount += 1
    @data[anIndex]
  end

  def []=(anIndex, anObject)
    @accessCount += 1
    @data[anIndex] = anObject
  end
end





class Object
  def abstract()
    raise AbstractMethodError, "Inherited classes must implement all the abstract members of it's super class."
  end
end

#testSelectionSort = SelectionSort.new
#testSelectionSort.fillDescending(10)
#testSelectionSort.permuteRandom(50)
##testSelectionSort.fillWithText('./MobyDick.txt')
##puts "SelectionSort"
##puts "-------------"
##puts "Unsorted Data"
##puts testSelectionSort.data
##puts "-------------"
#testSelectionSort.sort()
#
#testInsertionSort = InsertionSort.new
##testInsertionSort.fillWithText('./MobyDick.txt')
#testInsertionSort.fillDescending(10)
#testInsertionSort.permuteRandom(50)
###puts testInsertionSort.data
#testInsertionSort.checkOn
##puts "InsertionSort 1"
##puts "---------------"
#testInsertionSort.sort
##puts "InsertionSort 2"
##puts "---------------"
#testInsertionSort.sort([1,3,4,2,7],Proc.new {|a,b| a<=>b})