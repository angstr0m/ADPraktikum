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
    i = links 
    j = rechts - 1
    pivot = daten[rechts]
    
    begin
      
#      // Suche von links ein Element, welches größer als das Pivotelement ist
#         wiederhole solange daten[i] ≤ pivot und i < rechts
#             i := i + 1
#         ende
#
#         // Suche von rechts ein Element, welches kleiner als das Pivotelement ist
#         wiederhole solange daten[j] ≥ pivot und j > links
#              j := j - 1 
#         ende
#
#         falls i < j dann
#             tausche daten[i] mit daten[j]
#         ende
      
    
    end until(i >= j)
  end
end