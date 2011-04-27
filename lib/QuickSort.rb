require './AbstractSorter'

#test
class QuickSort < AbstractSorter
  def performSort()
    sortBetween(0,@data.size - 1)
  end

  def sortBetween(index1, index2)
    quicksort(index1, index2)
  end
  
  def quicksort(left, right)
    if (less(left,right))
      pivot = teile(left, right)
      quicksort(left, pivot - 1)
      quicksort(pivot + 1, right)
    end
  end
  
  def teile(left, right)
    i = left 
    j = right - 1
    pivot = @data[right]
    
    begin
      
      while ((@data[i] <= pivot) && i < right)
        i += 1
      end
      
      while (@data[j] >= pivot && j > left)
        j -= 1
      end
      
      if (i < j)
        exchange(i,j)
      end
      
    end until(i >= j)
    
    #falls daten[i] > pivot dann
    #         tausche daten[i] mit daten[rechts]
    # ende
    
    if (@data[i] > pivot)
      exchange(i,right)
    end
    
    return i
  end
end

testQuickSort = QuickSort.new
testQuickSort.fillDescending(10)
testQuickSort.permuteRandom(50)
#testQuickSort.fillWithText('./MobyDick.txt')
puts "SelectionSort"
puts "-------------"
puts "Unsorted Data"
puts testQuickSort.data
puts "-------------"
testQuickSort.sort()